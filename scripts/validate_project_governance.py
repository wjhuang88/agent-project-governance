#!/usr/bin/env python3
"""Validate governance artifacts generated or maintained by this skill."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


CAPABILITY_FILES = {
    "task_router": ["AGENTS.md"],
    "evolution_feedback": ["EVOLUTION.md"],
    "testing_policy": ["docs/sop/TESTING.md"],
    "git_workflow": ["docs/sop/GIT-WORKFLOW.md"],
    "requirement_intake": ["docs/sop/REQUIREMENT-INTAKE.md"],
    "iteration_workflow": [
        "docs/sop/START-ITERATION.md",
        "docs/sop/ITERATION-WORKFLOW.md",
    ],
    "change_control": ["docs/sop/CHANGE-CONTROL.md"],
    "decision_records": ["docs/decisions/README.md"],
    "release_workflow": ["docs/sop/RELEASE.md"],
}

PRODUCT_REQUIRED_CAPABILITIES = {
    "task_router",
    "evolution_feedback",
    "testing_policy",
    "git_workflow",
    "requirement_intake",
    "iteration_workflow",
    "change_control",
}

AGENT_GUIDE_SECTIONS = (
    "Hard Constraints",
    "Coding Behavior",
    "Git Rules",
    "Task Router",
    "Session End Checklist",
)

MD_LINK_RE = re.compile(r"\[[^\]]+\]\(([^)#]+\.md)(?:#[^)]+)?\)")
SRC_PATH_RE = re.compile(r"`(src/[A-Za-z0-9_./@-]+\.[A-Za-z0-9]+)`")
FENCED_CODE_RE = re.compile(r"```.*?```", re.DOTALL)
EXAMPLE_PATH_MARKERS = ("MyPage", "Example", "<", ">")

# Warning-only heuristics. Completion is matched only via status-label or all-caps forms so prose
# like "Definition of Done" or "once complete" does not trigger false positives.
STATUS_COMPLETE_RE = re.compile(
    r"(?im)^\s*[*_>\-\s]*status\b.*\b(complete|completed|done|shipped|delivered)\b"
)
CAPS_COMPLETE_RE = re.compile(r"\b(COMPLETE|COMPLETED|DONE|SHIPPED|DELIVERED)\b")
EVIDENCE_RE = re.compile(
    r"```|\b(test|tests|tested|testing|cargo|npm|pnpm|yarn|pytest|gradle|mvn|make|go test|"
    r"passed|passing|verified|verify|evidence|exit\s*0|coverage|benchmark|smoke)\b",
    re.IGNORECASE,
)


def claims_completion(text: str) -> bool:
    return bool(STATUS_COMPLETE_RE.search(text) or CAPS_COMPLETE_RE.search(text))


def shows_evidence(text: str) -> bool:
    return bool(EVIDENCE_RE.search(text))


def parse_manifest(path: Path) -> tuple[dict[str, str], dict[str, dict[str, str]]]:
    scalars: dict[str, str] = {}
    sections: dict[str, dict[str, str]] = {}
    section = ""
    for raw_line in path.read_text(encoding="utf-8").splitlines():
        line = raw_line.split("#", 1)[0].rstrip()
        if not line or line.lstrip().startswith("-"):
            continue
        indent = len(line) - len(line.lstrip())
        match = re.match(r"\s*([A-Za-z0-9_]+):\s*(.*)$", line)
        if not match:
            continue
        key, value = match.groups()
        value = value.strip().strip("\"'")
        if indent == 0 and not value:
            section = key
            sections.setdefault(section, {})
        elif indent == 0:
            scalars[key] = value
            section = ""
        elif section and indent == 2 and value:
            sections.setdefault(section, {})[key] = value
    return scalars, sections


def local_markdown_files(root: Path) -> list[Path]:
    files = [root / "AGENTS.md", root / "EVOLUTION.md", root / "README.md"]
    docs = root / "docs"
    if docs.exists():
        files.extend(docs.rglob("*.md"))
    return [path for path in files if path.exists()]


def active_fact_files(root: Path) -> list[Path]:
    files = [root / "AGENTS.md"]
    for folder in ("docs/reference", "docs/sop"):
        path = root / folder
        if path.exists():
            files.extend(path.rglob("*.md"))
    return [path for path in files if path.exists()]


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("project_root", type=Path)
    args = parser.parse_args()
    root = args.project_root.resolve()
    errors: list[str] = []
    warnings: list[str] = []

    manifest = root / ".agent-governance/manifest.yaml"
    if not manifest.exists():
        errors.append("missing .agent-governance/manifest.yaml")
        return report(errors, warnings)

    scalars, sections = parse_manifest(manifest)
    profile = scalars.get("profile", "")
    status = scalars.get("status", "")
    capabilities = sections.get("capabilities", {})
    entrypoints = sections.get("entrypoints", {})
    guide_text = (root / "AGENTS.md").read_text(encoding="utf-8") if (root / "AGENTS.md").exists() else ""

    for name, target in entrypoints.items():
        if not (root / target).exists():
            errors.append(f"declared entrypoint does not exist: {name} -> {target}")

    if profile in {"product", "high-risk"}:
        for capability in sorted(PRODUCT_REQUIRED_CAPABILITIES):
            if capabilities.get(capability) == "not_applicable":
                errors.append(
                    f"{profile} profile cannot mark {capability} as not_applicable"
                )
        docs_index = root / "docs/README.md"
        if not docs_index.exists():
            message = "product governance is missing documentation map: docs/README.md"
            if status == "conformant":
                errors.append(message)
            else:
                warnings.append(message)
        doc_check = root / "docs/sop/DOC-CHECK.md"
        if not doc_check.exists():
            message = "multi-layer product governance is missing docs/sop/DOC-CHECK.md"
            if status == "conformant":
                errors.append(message)
            else:
                warnings.append(message)

    iterations = root / "docs/iterations"
    iteration_records = list(iterations.glob("*.md")) if iterations.exists() else []
    iteration_records = [path for path in iteration_records if path.name.lower() != "readme.md"]
    if iteration_records and capabilities.get("iteration_workflow") == "not_applicable":
        errors.append(
            "iteration records exist but iteration_workflow is marked not_applicable"
        )

    if status in {"degraded", "adopting"}:
        warnings.append(
            f"manifest status is '{status}': declared capabilities are not fully trustworthy yet; "
            "verify they reflect reality before relying on the governance state"
        )

    for record in iteration_records:
        text = record.read_text(encoding="utf-8")
        if claims_completion(text) and not shows_evidence(text):
            warnings.append(
                "iteration claims completion but records no validation evidence "
                f"(command, test, or recorded result): {record.relative_to(root)}"
            )

    for capability, paths in CAPABILITY_FILES.items():
        if capabilities.get(capability) != "conformant":
            continue
        for relative_path in paths:
            if not (root / relative_path).exists():
                errors.append(
                    f"{capability} is conformant but required file is missing: {relative_path}"
                )
            if (
                capability not in {"task_router", "evolution_feedback"}
                and guide_text
                and relative_path not in guide_text
            ):
                errors.append(
                    "conformant recurring workflow is not routed from AGENTS.md: "
                    f"{capability} -> {relative_path}"
                )

    agent_guide = root / "AGENTS.md"
    if (
        agent_guide.exists()
        and profile in {"product", "high-risk"}
        and capabilities.get("task_router") == "conformant"
    ):
        for section in AGENT_GUIDE_SECTIONS:
            if section not in guide_text:
                errors.append(f"AGENTS.md is missing required section: {section}")

    for source in local_markdown_files(root):
        text = source.read_text(encoding="utf-8")
        for link in MD_LINK_RE.findall(text):
            if "://" in link or "<" in link:
                continue
            target = (source.parent / link).resolve()
            if not target.exists():
                errors.append(
                    f"broken Markdown link: {source.relative_to(root)} -> {link}"
                )

    for source in active_fact_files(root):
        text = FENCED_CODE_RE.sub("", source.read_text(encoding="utf-8"))
        for relative_path in sorted(set(SRC_PATH_RE.findall(text))):
            if any(marker in relative_path for marker in EXAMPLE_PATH_MARKERS):
                continue
            if not (root / relative_path).exists():
                errors.append(
                    "missing explicit source path referenced by active governance: "
                    f"{source.relative_to(root)} -> {relative_path}"
                )

    return report(errors, warnings)


def report(errors: list[str], warnings: list[str]) -> int:
    for warning in warnings:
        print(f"WARNING: {warning}")
    for error in errors:
        print(f"ERROR: {error}")
    if errors:
        print(f"Governance validation failed: {len(errors)} error(s), {len(warnings)} warning(s).")
        return 1
    print(f"Governance validation passed: {len(warnings)} warning(s).")
    return 0


if __name__ == "__main__":
    sys.exit(main())

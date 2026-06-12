# Agent Project Governance Repository Rules

## Hard Constraints

- The installable skill source is `skills/agent-project-governance/`. Do not edit or publish
  root-level copies of skill files.
- Release archives must package `skills/agent-project-governance/` with
  `agent-project-governance/` as the archive's top-level directory.
- Do not reintroduce Python as a required dependency for the shipped skill or the install flow.
  Validators and install instructions must stay shell/PowerShell based.
- The Agent-facing install guide is `INSTALL.md` only. Do not add translated install guides unless
  the maintenance model is explicitly changed.
- Keep `README.md` as the English primary README and `README.zh-CN.md` as the Chinese README.
- Do not add Git-based installation instructions for users. Installation must use release
  archives.

## Coding Behavior

- Treat this repository as the reference implementation for the rules it ships. Preserve existing
  content unless replacing it is part of the requested change.
- Keep edits narrowly scoped to the requested release, packaging, documentation, validator, or skill
  behavior.
- When changing trigger behavior, edit the skill frontmatter in
  `skills/agent-project-governance/SKILL.md` and, when useful, the interface hints in
  `skills/agent-project-governance/agents/openai.yaml`.
- When changing release packaging, update both `.github/workflows/release.yml` and the install or
  README instructions that describe the produced artifacts.
- Release workflow changes must preserve the pre-package validation step for skill frontmatter,
  `openai.yaml`, manifest schema JSON, shell syntax, shell fixture tests, PowerShell syntax and
  PowerShell fixture tests.
- Prefer plain POSIX shell and PowerShell for scripts. Avoid adding runtime dependencies unless the
  user explicitly accepts the tradeoff.

## Task Router

- Skill behavior and workflow rules: `skills/agent-project-governance/SKILL.md`.
- Skill UI/default prompt hints: `skills/agent-project-governance/agents/openai.yaml`.
- Install and update instructions for Agents: `INSTALL.md`.
- English project overview: `README.md`.
- Chinese project overview: `README.zh-CN.md`.
- Release archive production: `.github/workflows/release.yml`.
- Manifest template: `skills/agent-project-governance/assets/manifest.template.yaml`.
- Manifest schema helper: `skills/agent-project-governance/assets/manifest.schema.json`.
- Governance references: `skills/agent-project-governance/references/`.
- Cross-platform validators: `skills/agent-project-governance/scripts/`.

## Validation

Before claiming completion, run the checks relevant to the change:

- For `SKILL.md` frontmatter changes:
  `ruby -e 'require "yaml"; text=File.read("skills/agent-project-governance/SKILL.md"); YAML.safe_load(text.split("---",3)[1]); puts "skill frontmatter ok"'`
- For `agents/openai.yaml` changes:
  `ruby -e 'require "yaml"; YAML.load_file("skills/agent-project-governance/agents/openai.yaml"); puts "openai yaml ok"'`
- For release workflow changes:
  `ruby -e 'require "yaml"; YAML.load_file(".github/workflows/release.yml"); puts "workflow yaml ok"'`
- For shell validator changes:
  `sh -n skills/agent-project-governance/scripts/validate_project_governance.sh`
- For shell validator behavior changes:
  `sh skills/agent-project-governance/scripts/test_validate_project_governance.sh`
- For PowerShell validator changes:
  `pwsh -NoProfile -File skills/agent-project-governance/scripts/test_validate_project_governance.ps1`
- For manifest schema changes:
  `ruby -e 'require "json"; JSON.parse(File.read("skills/agent-project-governance/assets/manifest.schema.json")); puts "manifest schema json ok"'`
- For install or README link changes, search for stale references:
  `rg -n "INSTALL\\.zh-CN|validate_project_governance\\.py|git clone|git pull|latest release zip" . --glob '!AGENTS.md'`

When feasible after packaging changes, locally create and list archive contents from
`skills/agent-project-governance/` to verify that the top-level directory is
`agent-project-governance/`.

## Git Rules

- Use Conventional Commits:
  - `docs:` for README, install guide, skill prose, and reference documentation.
  - `ci:` for GitHub Actions and release packaging behavior.
  - `fix:` for broken commands, validators, links, or install flows.
  - `feat:` for new skill capabilities or new shipped artifacts.
- Keep the subject imperative, lowercase after the type, and under roughly 72 characters when
  practical.
- Format: `type(scope): description (#story-id) [model:<model-name>]`.
- Scope is the skill area or `workspace` when the change crosses boundaries. Omit `(#story-id)`
  only when no story or issue exists.
- Every Agent-authored or Agent-assisted commit message must end with `[model:<model-name>]`,
  where `<model-name>` is the true current model name used for that commit.
- Determine the model tag from the active model identity at commit time. Do not copy it from a
  previous commit, an example, or documentation. If the current model name is unclear, ask before
  committing rather than guessing.
- Do not mix unrelated release, documentation, and skill-behavior changes in one commit unless the
  user asks for a combined release slice.
- Before committing, inspect `git status --short` and `git diff --cached --stat`.
- Tags use semantic versions like `v1.0.2`. Pushing a `v*` tag triggers release publishing.
- Before pushing a `v*` tag, create and commit `releases/<tag>.md` with an Agent-authored release
  summary. The release workflow fails when the matching file is missing.
- Before creating or pushing a `v*` tag, verify that
  `skills/agent-project-governance/SKILL.md` metadata version exactly matches the tag without the
  leading `v` by running `sh scripts/validate_repository_harness.sh <tag>`.

## Release Procedure

Use this sequence for every user-requested release:

1. Confirm the worktree is clean except for intended release changes:
   `git status --short --branch`.
2. Determine the next semantic version from existing tags:
   `git tag --list 'v*' --sort=-v:refname`.
3. Update `skills/agent-project-governance/SKILL.md` metadata version to the release version
   without the leading `v`.
4. Create `releases/<tag>.md` before tagging. Write a concise Agent-authored summary with:
   `Summary`, `Notable Changes`, and `Upgrade Notes`.
5. Run release-relevant validation:
   - `sh scripts/validate_repository_harness.sh <tag>`
   - `ruby -e 'require "yaml"; text=File.read("skills/agent-project-governance/SKILL.md"); YAML.safe_load(text.split("---",3)[1]); puts "skill frontmatter ok"'`
   - `ruby -e 'require "yaml"; YAML.load_file(".github/workflows/release.yml"); puts "workflow yaml ok"'`
   - `sh skills/agent-project-governance/scripts/test_validate_project_governance.sh`
   - `pwsh -NoProfile -File skills/agent-project-governance/scripts/test_validate_project_governance.ps1`
6. Commit release preparation files with the required commit-message model tag.
7. Push `main` first.
8. Create the `v*` tag on the pushed commit, then push the tag.
9. After pushing the tag, report that the release workflow has been triggered and name the expected
   archives: `.zip`, `.tar.gz`, and `.tar.zst`.

## Session End Checklist

- Report changed files and the reason for each change.
- Report validation commands run and whether they passed.
- Report any checks not run and why.
- Leave the worktree clean after user-requested commit/push tasks.

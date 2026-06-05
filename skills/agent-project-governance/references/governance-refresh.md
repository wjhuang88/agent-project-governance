# Governance Refresh

## Purpose

Use this when an already governed or older project is being corrected, repaired or upgraded. The
goal is to make newly shipped governance rules visible without copying the entire current skill
into the project or rewriting unrelated process areas.

## Trigger

Run a refresh audit before editing when the user asks to:

- repair governance drift or process mistakes;
- update `AGENTS.md`, SOPs, backlog, iterations, ADR rules, release flow or document governance;
- explain why an Agent missed a rule;
- correct an older project that was initialized by an earlier version of this skill.

## Version Marker

Project manifests should record the governing skill version:

```yaml
governance:
  skill_name: "agent-project-governance"
  skill_version: "<installed skill metadata.version>"
  last_refresh: "<YYYY-MM-DD>"
```

If the marker is absent or older than the installed skill, classify this as a visibility gap, not
an automatic failure. Audit only the capability affected by the user's task unless they request a
full upgrade.

## Refresh Audit

Compare the target project's reachable governance files with the current skill references for the
affected capability:

| Capability area | Check for current visibility |
| --- | --- |
| Agent entrypoint | `AGENTS.md` routes repair/upgrade work to current SOPs and does not rely only on legacy notes. |
| Git workflow | Full commit format, model tag rule and staged-diff checks are in `AGENTS.md`, not only SOP. |
| Requirements | ADR-constrained stories link governing decisions and carry constraints into acceptance. |
| Backlog | Large `PRODUCT-BACKLOG.md` uses active item files, `Required Reads` and archive index. |
| Iterations | Existing non-terminal iterations are inventoried before new backlog selection. |
| Evidence | Important claims classify facts, inferences, assumptions and unknowns. |
| Release | Authored release notes and archive formats match current release workflow. |
| Evolution | Lessons promote recurring fixes into `AGENTS.md`, SOPs or validators where useful. |

Classify each relevant item:

```text
present | missing | obsolete | not_applicable
```

## Repair Rule

For the affected capability:

1. Add or update the local rule where Agents will see it during execution, usually `AGENTS.md` for
   hard rules and `docs/sop/` for detailed procedure.
2. Keep legacy documents reachable only as history or mapped sources; do not leave active rules
   only in old locations.
3. Update `.agent-governance/manifest.yaml` with the new `governance.skill_version`,
   `governance.last_refresh`, affected capability state and residual `migration.next_actions`.
4. Record unrelated missing current rules as residual work instead of expanding scope.

Do not mark the project `conformant` only because the current skill contains a rule. The local
project must expose the rule through its own entrypoints.

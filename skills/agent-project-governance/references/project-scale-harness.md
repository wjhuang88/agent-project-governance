# Project Scale Harness

Use this reference when choosing or auditing governance profile, branch mode, worktree mode, or
governance depth. The goal is to replace vague scale judgment with repeatable evidence.

## Principle

Scale is not a feeling. Collect mechanical signals, map them to a recommendation, then let the
Agent explain any override. The harness must not edit `.agent-governance/manifest.yaml`; it reports
observations, recommended modes, mismatch warnings, and follow-up questions.

Keep `SKILL.md` small: put thresholds here and implementation in assets or project-local scripts.

## Signals

Recommended signal groups:

| Group | Mechanical signals |
| --- | --- |
| Code scale | tracked source-file count, language/toolchain count, package/workspace count |
| Delivery | CI workflows, Docker/container files, release workflow, release notes, semver tags |
| Data risk | migrations, schema files, database configuration, seed/backup scripts |
| Security risk | auth, permission, RBAC, OAuth, JWT, session, token or policy code |
| External effects | webhook, payment, email, queue, LLM/tool executor, third-party API clients |
| Planning | backlog, iteration records, roadmap, ADRs, proposals |
| Parallel work | multiple worktrees, dirty worktree plus urgent work, multiple active owner docs |

Exclude local Agent/tool caches and generated dependency/build directories from scale counts, such
as `.git/`, `.codex/`, `.opencode/`, `.sisyphus/`, `.agents/`, `node_modules/`, `target/`, `dist/`
and `build/`. Scale evidence should reflect repository-owned source and governance artifacts, not
per-user caches.

## Mapping

Use explicit thresholds, then explain the evidence:

```text
minimal:
  product_signals < 2
  high_risk_signals = 0
  release_signals = 0

product:
  product_signals >= 2
  or backlog/iteration/roadmap evidence exists
  or CI and release workflow both exist

high-risk:
  data migration signal plus deployment/release signal
  or security/permission signal
  or caller-triggered external execution signal

branch_mode simple:
  no release workflow, release branch, hotfix branch or semver tag evidence

branch_mode release-managed:
  release workflow, release notes, semver tags, release branches or hotfix evidence exists

worktree_mode on-demand:
  release-managed branch mode, dirty worktree plus urgent work, or high-risk work

worktree_mode required:
  multiple active work lines, parallel Agents, or hotfix/release stabilization during dirty
  feature work
```

## Trigger Scenes

Run scale assessment:

- before initializing governance or choosing a profile;
- before upgrading from `minimal` to `product` or `high-risk`;
- when CI, release automation, migrations, auth, payments, webhooks, external tool execution or
  other high-impact integrations are added;
- before introducing release branches, hotfix branches, `develop` or worktree rules;
- before a release or hotfix when branch/worktree mode may affect safety;
- during governance refresh when manifest profile or local branch rules may have drifted;
- when an Agent proposes a large roadmap/backlog/iteration structure for a project that may not
  need it.

## Output Contract

The assessment should report:

```text
recommended_profile: minimal | product | high-risk
recommended_branch_mode: simple | release-managed
recommended_worktree_mode: none | on-demand | required
triggered_signals:
  - <signal and evidence>
mismatch_warnings:
  - <manifest or SOP mismatch>
follow_up:
  - <question only when evidence cannot answer it>
```

When adopting the recommendation, update the manifest and relevant SOPs through the normal closure
contract. When overriding it, record why the observed signals do not apply.

## Assets

Use [assets/assess_project_scale.sh](../assets/assess_project_scale.sh) or
[assets/assess_project_scale.ps1](../assets/assess_project_scale.ps1) as starting points for a
project-local harness. Copy and tailor them; do not require Python or third-party packages.

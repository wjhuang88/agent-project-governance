---
name: agent-project-governance
description: Use for project management, project analysis/review, specs and requirements, roadmap/backlog work, refactor planning, architecture cleanup, technical-debt workflow, AGENTS.md, project rules, AI coding-agent instructions, backlog/story/iteration process, delivery gates, DoD, ADR/SOP structure, release/testing gates, and Agent-friendly engineering governance. Trigger for audit this project, review project structure, create/review a spec, decompose requirements, organize backlog or roadmap, prepare an iteration, plan a refactor, improve workflow, set up project rules, write/repair AGENTS.md, migrate docs, repair stale process docs, or capture lessons after defects/regressions/deployment failures/planning drift. Chinese triggers include 项目管理, 项目分析, 项目审查, 项目规则, 开发规范, Agent规则, spec, 需求分析, 需求拆解, 架构梳理, 重构, 技术债, 工程治理, 交付闭环, 迭代流程, 故障复盘, 文档治理, 流程审计.
license: MIT
metadata:
  author: wjhuang88
  version: "1.0.8"
---

# Agent Project Governance

## Purpose

Establish durable governance for projects developed with AI Agents. Turn ambiguous work into
auditable artifacts, execution gates, and records future Agents can follow. Treat existing
documentation as assets to assess and migrate, not obstacles to overwrite.

This skill covers project analysis, specs, requirements, roadmap/backlog work, refactor planning,
architecture cleanup, technical debt, iteration planning, AGENTS.md, and project rules. Do not
implement unrelated business code merely because a spec or refactor was discussed; create or
repair the plan, acceptance criteria, risk gates, and follow-up records unless the user explicitly
asks for code changes too.

## Usage Router

- New or lightly documented repository: discover first, then initialize the smallest useful slice.
- Existing project needing management, specs, refactor planning, requirements, or Agent rules:
  discover, map risks, then recommend before editing.
- Existing governance that may be stale: run a refresh audit against the current skill, then
  repair the smallest misleading slice.
- Validation-only or explanation-only request: run the validator or explain the methodology
  without changing files.
- Skip one-off typo fixes, isolated code edits, and single-file formatting unless the user also
  asks to update project rules or process records.

## First Action

Before proposing files or editing a project:

1. Locate the project root from repository markers and build files.
2. Inspect technology, delivery shape, test/build commands, deployment surface, and risky domains
   such as authentication, databases, payments, permissions, or external integrations.
3. Look for `.agent-governance/manifest.yaml`. If it exists, check
   `governance.skill_version` and `governance.last_refresh`; missing or old values make the
   affected work a refresh audit.
4. Inventory useful existing assets even when their location is non-standard: `AGENTS.md`,
   contribution rules, documentation folders, backlog or issue files, ADRs, roadmap, iteration
   notes, test/release instructions, CI files, migration plans, and lessons learned.
5. Classify the repository:

| State | Meaning | Required response |
| --- | --- | --- |
| `uninitialized` | No reliable Agent governance entrypoint exists. | Explain the gap, recommend an initialization slice, and request confirmation before editing. |
| `discovered` | Useful custom process assets exist, but no standard mapping is established. | Summarize reusable assets and propose adoption without overwriting them. |
| `adopting` | A manifest exists, but capabilities still use legacy locations or are incomplete. | Continue the smallest useful migration slice. |
| `conformant` | The manifest and capability audit match the standard structure. | Use the existing router and audit only what the task affects. |
| `degraded` | The project was initialized but declared files, commands, or gates are missing or stale. | Propose a focused baseline repair before trusting the process. |

Do not treat `AGENTS.md` alone as proof of initialization. A manifest shows prior adoption; a
capability audit establishes current validity.

Read:

- [references/initialization-and-adoption.md](references/initialization-and-adoption.md) for
  classification, manifest, migration, and upgrade rules.
- [references/governance-refresh.md](references/governance-refresh.md) when repairing or upgrading
  older governed projects so new skill rules are not missed.

## Communicate for Non-Experts

Do not require users to know terms such as ADR, DoR, DoD, WIP, or change control. Explain the
problem first, then introduce the artifact only when useful.

- Discover repository facts before asking questions.
- Ask only for intent or risk information that cannot be inferred reliably.
- Recommend a governance level with reasons; do not ask the user to choose an unexplained profile.
- Before creating files, explain what will be created, what will remain unchanged, and what
  practical failure each file helps prevent.
- Start with the smallest usable slice unless the user explicitly requests full initialization.

Read [references/guided-onboarding.md](references/guided-onboarding.md) for initialization or
migration confirmation flows.

## Closure Contract

Apply this whenever editing or generating governance artifacts, repairing governance drift, or
performing an initialization/adoption slice. Do not report completion merely because files were
created or edited.

Before editing, identify:

```text
requested outcome | artifacts to change | records/status to synchronize |
validation evidence required | residual work destination
```

Then execute all five stages:

1. **Establish**: confirm current state, preserved assets, scope, and closure items.
2. **Implement**: create or update the smallest complete artifact slice.
3. **Verify**: run structural checks and inspect semantic consistency; record failures truthfully.
4. **Synchronize**: update applicable manifest/capability state, backlog or iteration status,
   lessons, dependency/blocker records, and supersession mappings.
5. **Deliver**: report changed artifacts, checks, residual gaps, and status.

Status is strict:

- `complete` only when the requested slice is implemented, applicable status owners are
  synchronized, validation evidence is recorded, and remaining gaps are explicitly out of scope or
  registered for follow-up.
- `partial` when useful work was produced but at least one closure item remains unfinished.
- `blocked` when a required decision, permission, missing source, or failing prerequisite prevents
  a valid completion claim.

Do not hide incomplete closure behind recommendations. Read
[references/closure-protocol.md](references/closure-protocol.md) before implementing a governance
change or generating an initialization/adoption workflow.

## Standard Workflow

### 1. Discover

Read enough of the repository to determine whether work is one-off maintenance or continuing
product development, whether Agents may edit code, validate behavior, commit, or release, which
systems can fail expensively, and whether registered tools, webhooks, mailers, agents, or other
executors can initiate outbound actions on behalf of a caller. Check existing rules, current
commands, architecture documentation, and whether planning artifacts distinguish large outcomes
from executable child slices.

Classify constraints:

| Type | Meaning | Use for |
| --- | --- | --- |
| **Hard** | Immutable fact, platform limit, irreversible operation, or external contract. | Deriving mandatory gates. |
| **Soft** | Policy or convention that can change. | Recording in decisions when a choice affects one. |
| **Assumption** | Unvalidated belief that may be false. | Flagging for validation; creating Spikes when blocking. |

Every gate should trace to a specific Hard constraint, not a generic best practice. Read
[references/evidence-and-uncertainty.md](references/evidence-and-uncertainty.md) when conclusions
depend on incomplete evidence, inference, assumptions, or conflicting sources.

### 2. Map Features to Failure Modes

Create an internal mapping:

```text
project characteristic -> plausible recurring failure -> protective gate -> owning document
```

Examples include a public email entrypoint requiring URL/route/auth-middleware checks, a
dual-database service requiring paired migrations and tests, or an outbound tool executor
requiring caller authentication, bounded responses, explicit network behavior, and deterministic
local tests. Do not import gates merely because another project needed them.

Read [references/risk-to-gate-patterns.md](references/risk-to-gate-patterns.md) when the project
contains cross-layer, security, data, deployment, or migration risk.

### 3. Recommend

Provide a plain-language diagnosis:

- current governance state;
- constraint classification derived from project facts;
- assets worth retaining;
- gates that Hard constraints require and why Soft constraints do not need gates;
- gaps that can cause actual mistakes;
- recommended target structure and why;
- the smallest next implementation slice;
- files that would be created or modified;
- files and behavior explicitly left unchanged.

If a gate cannot trace to a Hard constraint, question whether it is needed. Do not edit during
assessment unless the user has clearly requested implementation.

### 4. Initialize or Adopt

After confirmation, build toward the standard structure in stages:

1. Establish control entrypoints: `AGENTS.md`, `.agent-governance/manifest.yaml`,
   `EVOLUTION.md`, and `docs/sop/EVOLUTION-FEEDBACK.md`.
2. Put both process rules and Agent coding behavior rules in `AGENTS.md`: state assumptions,
   implement only requested code, avoid speculative features and premature abstractions, match
   existing style, define verifiable success criteria, and clean up only what your changes orphan.
   Read [references/coding-behavior.md](references/coding-behavior.md) for the full section.
3. Create `CLAUDE.md` and `GEMINI.md` beside `AGENTS.md`, each containing only
   `Read AGENTS.md and follow all rules defined there.` Do not ask which redirects to create
   during normal initialization unless the user explicitly forbids one.
4. Extract active content from non-standard documents into standard owners: mandatory rules and
   routes into `AGENTS.md`, stable facts into `docs/reference/`, procedures into `docs/sop/`,
   executable work into `docs/backlog/` or `docs/iterations/`, decisions into `docs/decisions/`,
   direction into `docs/roadmap/`, immature proposals into `docs/proposals/`, lessons into
   `EVOLUTION.md`, and historical source material into `docs/archive/`.
5. Record each preserved, extracted, superseded, or archived source in the manifest migration
   mapping. Do not leave active rules discoverable only through non-standard sources.
6. Add daily execution gates: testing, Git, requirement intake, iteration flow, and change control
   as applicable.
7. Add planning and stable-fact layers as applicable: backlog, iterations, decisions, roadmap,
   proposals, and reference material.
8. For product or high-risk projects with multiple non-terminal status owners, consider
   `docs/BOARD.md` only as a derived operating view. Owner docs remain the source of truth.
9. Add project-specific gates derived from risk, such as contract-first APIs, database migration,
   release, security, or visual validation rules.

Preserve useful legacy documents during adoption. Non-standard location is not a reason to drop
content: extract each active responsibility into its standard owner, then link, archive, or
supersede the source explicitly. Do not silently delete historical or still-authoritative
material.

Use these references when the slice touches the named area:

- [references/standard-structure.md](references/standard-structure.md): target profiles and
  document responsibilities.
- [references/epic-and-story-decomposition.md](references/epic-and-story-decomposition.md): Epics,
  executable Stories, parent/child identity, dependencies, and iteration selection.
- [references/backlog-compaction.md](references/backlog-compaction.md): compact backlog surface,
  item files, `Required Reads`, and archive rules.
- [references/story-format-and-bdd.md](references/story-format-and-bdd.md): story formats,
  Given/When/Then acceptance, technical work, governance work, and spikes.
- [references/iteration-baseline-integrity.md](references/iteration-baseline-integrity.md):
  published iteration baselines, active/review/planned/blocked inventory, runnable deliverables,
  runtime reachability, and documentation synchronization.
- [assets/manifest.template.yaml](assets/manifest.template.yaml): manifest starting point.
- [assets/manifest.schema.json](assets/manifest.schema.json): optional editor aid; validators stay
  dependency-free and do not require schema tooling.

### 5. Audit and Improve

For initialized projects, verify that declared capabilities remain real:

- profile/capability states, routes, commands, local entrypoints, and declared files remain valid;
- stale governed projects expose current rules locally, not only through the installed skill;
- backlog, iteration, roadmap, requirement-convergence, board, and manifest owners do not
  contradict one another;
- large outcomes are decomposed into Epics and executable Stories with dependencies and readiness
  visible;
- growing backlogs preserve decision usefulness through active item files, explicit
  `Required Reads`, and archive indexes;
- stories use a format appropriate to their type, behavior-facing work has testable acceptance,
  and ADR-constrained requirements link and carry decision constraints;
- iteration plans preserve published baselines, inventory active/review/planned/blocked work
  before selection, produce runnable/testable deliverables, and record runtime reachability;
- observable behavior changes update user-facing documentation or register documentation debt;
- completion claims cite recorded commands or concrete manual evidence;
- important conclusions distinguish confirmed facts, inferences, assumptions, and unknowns;
- transitional architecture is not presented as final design;
- failure lessons become checks where useful;
- changed surfaces do not introduce new dead/unused code where the toolchain reports it;
- validation gates cover the changed risk surface.

Read [references/methodology.md](references/methodology.md) when revising the governance model
itself.

### 6. Validate the Governance Work

After editing governance artifacts:

1. Run the validator for the current environment:
   `sh <skill-path>/scripts/validate_project_governance.sh <project-root>` on Unix-like systems,
   `powershell -NoProfile -File <skill-path>/scripts/validate_project_governance.ps1 <project-root>`
   on Windows PowerShell 5.1, or
   `pwsh -NoProfile -File <skill-path>/scripts/validate_project_governance.ps1 <project-root>`
   on PowerShell 7+.
   The validator checks required profile files, capability evidence, `AGENTS.md` execution
   sections, local Markdown links, missing explicit `src/...` file references in active governance
   documents, and completion claims without recorded validation evidence.
2. Compare inventoried non-standard documents with the new standard owners; confirm every
   still-applicable rule, fact, decision, work item, procedure, or lesson was extracted or mapped.
3. If `docs/BOARD.md` exists, confirm owner docs were updated before the board and that the board
   remains a derived summary rather than a source of truth.
4. Confirm no useful legacy source was unintentionally overwritten or silently discarded.
5. Run a scenario-based check using real project risks or
   [references/evaluation-cases.md](references/evaluation-cases.md).
6. Explain what the user can now ask an Agent to do and which capabilities remain intentionally
   deferred.
7. Apply the closure status rule: a failed or unperformed required check, stale status owner, or
   unregistered residual gap prevents a `complete` claim.

When editing this skill's shipped validators or schema, also run the repository-level checks named
in the local `AGENTS.md`.

## Output Contract

When only diagnosing, produce:

```markdown
Current governance state:
Observed project characteristics:
Existing assets to preserve:
Important gaps and likely consequences:
Recommended target and migration stage:
Proposed next slice:
Files affected if approved:
```

When implementing, also report:

- initialized or updated capabilities;
- paths created or mapped;
- checks performed;
- evidence and uncertainty classification for important closure claims;
- residual gaps and the next natural stage;
- closure status (`complete`, `partial`, or `blocked`) and the evidence supporting that status.

## Resources

- Onboarding and adoption:
  [guided-onboarding](references/guided-onboarding.md),
  [initialization-and-adoption](references/initialization-and-adoption.md),
  [governance-refresh](references/governance-refresh.md),
  [schema-migrations](references/schema-migrations.md).
- Governance design:
  [methodology](references/methodology.md),
  [evidence-and-uncertainty](references/evidence-and-uncertainty.md),
  [risk-to-gate-patterns](references/risk-to-gate-patterns.md),
  [standard-structure](references/standard-structure.md).
- Planning and delivery:
  [epic-and-story-decomposition](references/epic-and-story-decomposition.md),
  [story-format-and-bdd](references/story-format-and-bdd.md),
  [backlog-compaction](references/backlog-compaction.md),
  [iteration-baseline-integrity](references/iteration-baseline-integrity.md).
- Closure and learning:
  [closure-protocol](references/closure-protocol.md),
  [evolution-feedback](references/evolution-feedback.md),
  [evaluation-cases](references/evaluation-cases.md).
- Agent rules:
  [coding-behavior](references/coding-behavior.md).
- [assets/manifest.template.yaml](assets/manifest.template.yaml): manifest starting point for an
  initialized or adopting project.
- [assets/manifest.schema.json](assets/manifest.schema.json): optional manifest editor/schema aid;
  validators stay dependency-free and do not require schema tooling.
- [scripts/validate_project_governance.sh](scripts/validate_project_governance.sh): deterministic
  POSIX shell checks for generated or adopted project governance artifacts.
- [scripts/validate_project_governance.ps1](scripts/validate_project_governance.ps1): deterministic
  Windows PowerShell checks for generated or adopted project governance artifacts.

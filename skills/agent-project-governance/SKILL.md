---
name: agent-project-governance
description: Use for project management, project analysis, specs and requirements, refactor planning, technical-debt workflow, AGENTS.md, project rules, AI coding-agent instructions, backlog/story/iteration process, delivery gates, Definition of Done, ADR/SOP structure, release/testing gates, and Agent-friendly engineering governance. Trigger for requests such as audit this project, create or review a spec, decompose requirements, organize backlog or roadmap, prepare an iteration, plan a refactor safely, improve development workflow, set up project rules, write or repair AGENTS.md, migrate existing docs into a standard structure, repair stale process docs, or capture lessons after defects/regressions/deployment failures/planning drift. Also trigger for Chinese requests such as 项目管理, 项目分析, 项目规则, 开发规范, Agent规则, AGENTS.md, spec, 规格说明, 需求规格, 需求分析, 需求拆解, 重构, 重构计划, 技术债, 工程治理, 交付闭环, DoD, 迭代流程, 故障复盘, 经验沉淀, 文档治理, 流程审计, 治理初始化, 治理修复, 发布/测试门禁.
license: MIT
---

# Agent Project Governance

## Purpose

Establish a durable governance system for projects developed with AI Agents. Treat existing
documentation as assets to assess and migrate, not obstacles to overwrite. Guide users who may
not know process terminology, while converging suitable projects toward the standard structure
defined in this skill.

This skill also handles broad project-management requests such as project analysis, specs,
requirements, refactor planning, roadmap cleanup, technical debt, and iteration planning. Treat
those requests as governance-facing work: clarify intent, inspect the project, turn ambiguous work
into auditable artifacts and execution gates, and preserve a trail that future Agents can follow.
Do not perform unrelated business-code implementation merely because a spec or refactor was
discussed; create or repair the plan, rules, acceptance criteria, risk gates, and follow-up
records unless the user explicitly asks for code changes too.

## First Action: Determine Governance State

Before proposing files or editing a project:

1. Locate the project root from repository markers and build files.
2. Inspect project technology, delivery shape, test/build commands, deployment surface, and risky
   domains such as authentication, databases, payments, permissions, or external integrations.
3. Look for `.agent-governance/manifest.yaml`.
4. Look for existing governance assets and non-standard documents: `AGENTS.md`, contribution
   rules, root-level or custom documentation folders, backlog or issue files, ADRs, roadmap,
   iteration notes, test/release instructions, CI files, migration plans, and lessons learned.
   Inventory useful content even when its current location or shape is not standard.
5. Classify the repository:

| State | Meaning | Required response |
| --- | --- | --- |
| `uninitialized` | No reliable Agent governance entrypoint exists. | Explain the gap, recommend an initialization slice, and request confirmation before editing. |
| `discovered` | Useful custom process assets exist, but no standard mapping is established. | Summarize reusable assets and propose adoption without overwriting them. |
| `adopting` | A manifest exists, but capabilities still use legacy locations or are incomplete. | Continue the smallest useful migration slice. |
| `conformant` | The manifest and capability audit match the standard structure. | Use the existing router and audit only what the task affects. |
| `degraded` | The project was initialized but declared files, commands, or gates are missing or stale. | Propose a focused baseline repair before trusting the process. |

Do not treat the mere presence of `AGENTS.md` as proof of initialization. A manifest shows prior
adoption; a capability audit establishes current validity.

Read [references/initialization-and-adoption.md](references/initialization-and-adoption.md) for
classification, manifest, migration, and upgrade rules.

## Communicate for Non-Experts

Do not require users to know terms such as ADR, DoR, DoD, WIP, or change control. Explain the
problem first, then introduce the artifact only when useful.

- Automatically discover facts available from the repository before asking questions.
- Ask only for intent or risk information that cannot be inferred reliably.
- Recommend a level of governance with reasons; do not ask the user to select an unexplained
  profile.
- Before creating files, explain what will be created, what will remain unchanged, and what
  practical failure each file helps prevent.
- Start with the smallest usable slice unless the user explicitly requests full initialization.

Read [references/guided-onboarding.md](references/guided-onboarding.md) whenever initializing a
project or presenting migration options to a user.

## Mandatory Closure Contract For Implementation

Apply this whenever editing or generating governance artifacts, repairing governance drift, or
performing an initialization/adoption slice. Do not report the task complete merely because
files were created or edited.

Before editing, identify these closure items:

```text
requested outcome | artifacts to change | records/status to synchronize |
validation evidence required | residual work destination
```

Then execute all five stages in order:

1. **Establish**: confirm current governance state, preserved assets, scope and applicable
   closure items.
2. **Implement**: create or update the smallest complete artifact slice.
3. **Verify**: run available structural checks and inspect semantic consistency for the changed
   scope; record failures truthfully.
4. **Synchronize**: update applicable manifest/capability state, backlog or iteration status,
   lessons, dependency/blocker records and supersession mappings.
5. **Deliver**: report changed artifacts, checks and results, residual gaps and an explicit
   outcome status: `complete`, `partial`, or `blocked`.

Status is strict:

- `complete` only when the requested slice is implemented, applicable status owners are
  synchronized, validation evidence is recorded, and remaining gaps are explicitly out of scope
  or registered for follow-up;
- `partial` when useful work was produced but at least one closure item remains unfinished;
- `blocked` when a required decision, permission, missing source or failing prerequisite
  prevents a valid completion claim.

Do not hide incomplete closure behind recommendations. Read
[references/closure-protocol.md](references/closure-protocol.md) before implementing a
governance change or generating an initialization/adoption workflow.

## Standard Workflow

### 1. Discover

Read enough of the repository to determine:

- whether work is one-off maintenance or continuing product development;
- whether Agents may edit code, validate behavior, commit, or release;
- which systems can fail expensively;
- whether registered tools, webhooks, mailers, agents, or other executors can initiate outbound
  actions on behalf of a caller;
- which rules and project facts already exist;
- whether planned work distinguishes large outcomes from executable child slices, and how
  parent/child identity and dependencies are currently represented;
- whether user stories use a format that matches their work type, and whether behavior-facing
  stories have BDD-style acceptance instead of vague implementation checklists;
- whether committed future iteration plans retain their original targets when execution changes
  priority or selects different work;
- whether starting a new iteration inventories active, review, planned and blocked cycles before
  selecting new backlog work;
- whether current commands, architectural targets, and documentation agree.

Then classify project constraints:

| Type | Meaning | Use for |
| --- | --- | --- |
| **Hard** | Immutable fact (platform limit, irreversible operation, external contract) | Deriving mandatory gates |
| **Soft** | Policy or convention that can change | Recording in decisions when a choice affects one |
| **Assumption** | Unvalidated belief that may be false | Flagging for validation, creating Spikes when blocking |

Constraint classification replaces "match patterns by project type" with "derive rules from what
is actually constrained in this project." This is first principles applied to governance: every
gate should trace to a specific Hard constraint, not a generic best practice.

### 2. Map Features to Failure Modes

Create an internal mapping:

```text
project characteristic -> plausible recurring failure -> protective gate -> owning document
```

Examples include a public email entrypoint requiring URL/route/auth-middleware checks, a
dual-database service requiring paired migrations and tests, or an outbound tool executor
requiring caller authentication, bounded responses, explicit network behavior and deterministic
local tests. Do not import a gate merely because another project needed it.

Read [references/risk-to-gate-patterns.md](references/risk-to-gate-patterns.md) when the project
contains cross-layer, security, data, deployment, or migration risk.

### 3. Recommend

Provide a plain-language diagnosis:

- current governance state;
- constraint classification (Hard / Soft / Assumption) derived from project facts;
- assets worth retaining;
- gates that Hard constraints require, and why Soft constraints do not need gates;
- gaps that can cause actual mistakes;
- recommended target structure and why;
- the smallest next implementation slice;
- files that would be created or modified;
- files and behavior explicitly left unchanged.

Derive each recommended gate from a specific Hard constraint rather than from a generic pattern
table. If a gate cannot trace to a Hard constraint, question whether it is needed.

Do not edit a project during assessment unless the user has already clearly requested
implementation.

### 4. Initialize or Adopt

After confirmation, build toward the standard structure in stages:

1. Establish control entrypoints: `AGENTS.md`, `.agent-governance/manifest.yaml`, and
    `EVOLUTION.md`. The `AGENTS.md` file should contain both process rules and coding behavior
    rules. Coding behavior rules govern how the Agent writes code: state assumptions before
    implementing; only write code directly asked for (no speculative features, no premature
    abstractions, no unsolicited refactoring); match existing style even if different from personal
    preference; define verifiable success criteria before starting; clean up only what your own
    changes orphan.
2. Extract applicable content from existing non-standard documents into standard owners:
   mandatory rules and routes into `AGENTS.md`, stable facts into `docs/reference/`, procedures
   into `docs/sop/`, executable work into `docs/backlog/` or `docs/iterations/`, significant
   decisions into `docs/decisions/`, direction into `docs/roadmap/`, immature proposals into
   `docs/proposals/`, lessons into `EVOLUTION.md`, and historical source material into
   `docs/archive/`.
3. Record each preserved, extracted, superseded, or archived source in the manifest migration
   mapping. A source document may remain in place while its active content is extracted and
   linked; do not leave active rules discoverable only through non-standard sources.
4. Add daily execution gates: testing, Git, requirement intake, iteration flow, and change
   control as applicable.
5. Add planning and stable-fact layers: backlog, iterations, decisions, roadmap, proposals, and
   reference material as applicable.
   For product work containing multi-stage requirements, make requirement intake define Epic
   versus executable Story, parent/child identifiers, dependency readiness, and iteration
   selection rather than leaving large items as informal prose.
   Make story format explicit: user-visible, API, permission or state-transition work needs a
   role, goal, value and Given/When/Then acceptance; technical, governance and spike work should
   not be forced into fake user-story wording, but must have equivalent verification, state
   owners and residual-work destinations. Read
   [references/story-format-and-bdd.md](references/story-format-and-bdd.md) when designing these
   rules.
   When iteration plans are published ahead of implementation, make the workflow preserve each
   published plan as a baseline: execution may append results for the same target, while a new
   target receives a new iteration identifier and explicitly blocks affected downstream plans.
   When multiple iteration records can coexist, require an inventory gate before backlog
   selection: active or review work must be resolved first, and planned or blocked work must
   receive an explicit activation, deferral or continued-blockage decision.
   **Iteration deliverable rule**: each iteration must produce a runnable, testable output
   (MVP principle). When the selected Stories cannot yield something verifiable end-to-end,
   the plan is incomplete. Prefer the smallest set of Stories that delivers observable value.
   **Documentation synchronization rule**: Stories that change observable behavior must include
   documentation updates in their acceptance criteria. The iteration template must list affected
   user-facing documentation (README, usage guide, changelog, release notes). Unresolved
   documentation debt is a residual item, not silently deferred.
   When a product or high-risk project has multiple non-terminal status owners, consider adding
   `docs/BOARD.md` as a derived operating view. The board is optional and must not become a new
   state source: owner docs define status, scope, acceptance criteria, and evidence. The board only
   summarizes Now / Review / Blocked or Paused / Next / Later with an owner-doc link and explicit
   gate for each row.
6. Add project-specific gates derived from risk, such as contract-first APIs, database
   migration, release, security, or visual validation rules.

Preserve useful legacy documents during adoption. Non-standard location is not a reason to drop
content: extract each active responsibility into its standard owner, then link, archive, or
supersede the source explicitly. Do not silently delete historical or still-authoritative
material.

Read [references/standard-structure.md](references/standard-structure.md) for target profiles and
document responsibilities. Copy and tailor
[assets/manifest.template.yaml](assets/manifest.template.yaml) when establishing the manifest.

### 5. Audit and Improve

For initialized projects, verify that declared capabilities remain real:

- profile and capability states satisfy the invariants in
  [references/initialization-and-adoption.md](references/initialization-and-adoption.md);
- task routes lead to existing, current instructions;
- commands match the repository toolchain and lock files;
- backlog and iteration states agree;
- if a derived board exists, it is explicitly marked as a derived operating view, each row links to
  an owner doc and includes a gate, and its state does not contradict backlog, iteration, roadmap,
  requirement-convergence or manifest owners;
- large backlog outcomes are either executable stories or explicitly decomposed Epics whose
  child dependencies and iteration selection can be audited;
- ready backlog stories use a format appropriate to their type, and behavior-facing stories
  have testable Given/When/Then acceptance or an explicit non-applicability reason;
- published iteration baselines remain traceable; actual execution appends evidence instead of
  replacing a committed plan with unrelated completed work;
- each iteration produces a runnable, testable deliverable; iterations that deliver only internal
  infrastructure without testable output are flagged as incomplete;
- stories that claim a delivered runtime capability show that capability is reachable through the
  runnable surface (CLI, interactive/TUI, API, or end-to-end test driving the real entrypoint),
  not only through an isolated unit test; a built-but-unwired module is `partial`, not `complete`;
- user-facing documentation (README, usage instructions, changelog, release notes) was updated
  within each iteration that changed observable behavior; documentation debt is tracked as
  residual work, not silently deferred;
- starting a new iteration cannot bypass existing active, review, planned or blocked work merely
  because the backlog also contains ready stories;
- completion claims are backed by recorded commands or concrete manual evidence, not only
  checked status boxes;
- transitional architecture is not presented as the final design;
- new failure lessons have been converted to checks where useful;
- for languages whose toolchain reports unused or dead code, that signal on the changed surface is
  not left accumulating across iterations: orphans introduced by recent work are removed and any
  pre-existing dead code is tracked rather than silently ignored;
- validation gates cover the changed risk surface.

Read [references/methodology.md](references/methodology.md) when designing or revising the
governance model itself.

### 6. Validate the Governance Work

After editing governance artifacts:

1. Run the validator for the current environment: use
   `sh <skill-path>/scripts/validate_project_governance.sh <project-root>` on Unix-like
   environments, or
   `pwsh -File <skill-path>/scripts/validate_project_governance.ps1 <project-root>` on Windows.
   The validator checks required profile files, capability evidence, `AGENTS.md` execution
   sections, local Markdown links, missing explicit `src/...` file references in active governance
   documents, and completion claims without recorded validation evidence.
2. Compare inventoried non-standard documents with the new standard owners; confirm every
   still-applicable rule, fact, decision, work item, procedure, or lesson was extracted or
   explicitly mapped for later migration.
3. If `docs/BOARD.md` exists, confirm owner docs were updated before the board and that the board
   remains a derived summary rather than a source of truth.
4. Confirm no useful legacy source was unintentionally overwritten or silently discarded.
5. Run a scenario-based check using real project risks or
   [references/evaluation-cases.md](references/evaluation-cases.md).
6. Explain what the user can now ask an Agent to do, and which governance capabilities remain
   intentionally deferred.
7. Apply the closure status rule: a failed or unperformed required check, stale status owner, or
   unregistered residual gap prevents a `complete` claim.

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
- residual gaps and the next natural stage;
- closure status (`complete`, `partial`, or `blocked`) and the evidence supporting that status.

## Resources

- [references/guided-onboarding.md](references/guided-onboarding.md): user-facing discovery,
  questions, explanations, and confirmation flow.
- [references/initialization-and-adoption.md](references/initialization-and-adoption.md): state
  machine, manifest schema, legacy adoption, and degraded-state repair.
- [references/methodology.md](references/methodology.md): principles that generate governance
  rules from project conditions and failure history.
- [references/epic-and-story-decomposition.md](references/epic-and-story-decomposition.md):
  read when a product needs large-requirement decomposition, parent/child tracking, dependency
  readiness, or iteration-selection rules.
- [references/iteration-baseline-integrity.md](references/iteration-baseline-integrity.md):
  read when a project publishes iteration plans, changes selected work after planning, or must
  repair a plan document that was overwritten by later execution.
- [references/closure-protocol.md](references/closure-protocol.md): read before implementing
  governance changes when completion may require status synchronization, evidence recording or
  follow-up registration.
- [references/standard-structure.md](references/standard-structure.md): convergent target
  structure and scaled profiles.
- [references/coding-behavior.md](references/coding-behavior.md): full coding behavior guidelines
  for the Agent Coding Behavior section in AGENTS.md.
- [references/risk-to-gate-patterns.md](references/risk-to-gate-patterns.md): patterns for
  deriving gates from technical risk.
- [references/evaluation-cases.md](references/evaluation-cases.md): forward-test scenarios and
  success criteria.
- [assets/manifest.template.yaml](assets/manifest.template.yaml): manifest starting point for an
  initialized or adopting project.
- [scripts/validate_project_governance.sh](scripts/validate_project_governance.sh): deterministic
  POSIX shell checks for generated or adopted project governance artifacts.
- [scripts/validate_project_governance.ps1](scripts/validate_project_governance.ps1): deterministic
  Windows PowerShell checks for generated or adopted project governance artifacts.

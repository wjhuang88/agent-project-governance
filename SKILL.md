---
name: agent-project-governance
description: Analyze, initialize, migrate, and improve an Agent-friendly project governance system with guided onboarding, task routing, risk-based engineering gates, and feedback-driven process evolution. Use when a user asks to set up project rules for AI coding agents, initialize or audit AGENTS.md/SOP/backlog/iteration/ADR structures, migrate existing project workflows into a standard governance layout, check whether a repository has already been initialized, or improve development process quality after defects, regressions, deployment failures, or planning drift.
---

# Agent Project Governance

## Purpose

Establish a durable governance system for projects developed with AI Agents. Treat existing
documentation as assets to assess and migrate, not obstacles to overwrite. Guide users who may
not know process terminology, while converging suitable projects toward the standard structure
defined in this skill.

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
- whether committed future iteration plans retain their original targets when execution changes
  priority or selects different work;
- whether current commands, architectural targets, and documentation agree.

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
- assets worth retaining;
- gaps that can cause actual mistakes;
- recommended target structure and why;
- the smallest next implementation slice;
- files that would be created or modified;
- files and behavior explicitly left unchanged.

Do not edit a project during assessment unless the user has already clearly requested
implementation.

### 4. Initialize or Adopt

After confirmation, build toward the standard structure in stages:

1. Establish control entrypoints: `AGENTS.md`, `.agent-governance/manifest.yaml`, and
   `EVOLUTION.md`.
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
   When iteration plans are published ahead of implementation, make the workflow preserve each
   published plan as a baseline: execution may append results for the same target, while a new
   target receives a new iteration identifier and explicitly blocks affected downstream plans.
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
- large backlog outcomes are either executable stories or explicitly decomposed Epics whose
  child dependencies and iteration selection can be audited;
- published iteration baselines remain traceable; actual execution appends evidence instead of
  replacing a committed plan with unrelated completed work;
- completion claims are backed by recorded commands or concrete manual evidence, not only
  checked status boxes;
- transitional architecture is not presented as the final design;
- new failure lessons have been converted to checks where useful;
- validation gates cover the changed risk surface.

Read [references/methodology.md](references/methodology.md) when designing or revising the
governance model itself.

### 6. Validate the Governance Work

After editing governance artifacts:

1. Run `python3 <skill-path>/scripts/validate_project_governance.py <project-root>` to check
   required profile files, capability evidence, `AGENTS.md` execution sections, local Markdown
   links, and missing explicit `src/...` file references in active governance documents.
2. Compare inventoried non-standard documents with the new standard owners; confirm every
   still-applicable rule, fact, decision, work item, procedure, or lesson was extracted or
   explicitly mapped for later migration.
3. Confirm no useful legacy source was unintentionally overwritten or silently discarded.
4. Run a scenario-based check using real project risks or
   [references/evaluation-cases.md](references/evaluation-cases.md).
5. Explain what the user can now ask an Agent to do, and which governance capabilities remain
   intentionally deferred.
6. Apply the closure status rule: a failed or unperformed required check, stale status owner, or
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
- [references/risk-to-gate-patterns.md](references/risk-to-gate-patterns.md): patterns for
  deriving gates from technical risk.
- [references/evaluation-cases.md](references/evaluation-cases.md): forward-test scenarios and
  success criteria.
- [assets/manifest.template.yaml](assets/manifest.template.yaml): manifest starting point for an
  initialized or adopting project.
- [scripts/validate_project_governance.py](scripts/validate_project_governance.py): deterministic
  checks for generated or adopted project governance artifacts.

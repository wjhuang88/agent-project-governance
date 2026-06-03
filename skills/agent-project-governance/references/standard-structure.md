# Standard Structure

## Purpose

Define the structure projects converge toward. Profiles scale how many capabilities are
applicable; they do not create unrelated long-term governance models.

## Full Product Structure

Use for projects with continuing feature development, multiple technical layers, production
delivery, or meaningful safety/data/security risk:

```text
project-root/
├── AGENTS.md
├── EVOLUTION.md
├── .agent-governance/
│   └── manifest.yaml
└── docs/
    ├── README.md
    ├── BOARD.md                 (optional derived operating view)
    ├── backlog/
    │   └── PRODUCT-BACKLOG.md
    ├── iterations/
    │   └── README.md
    ├── decisions/
    │   └── README.md
    ├── roadmap/
    │   └── IMPLEMENTATION-ROADMAP.md
    ├── proposals/
    │   └── README.md
    ├── reference/
    │   └── README.md
    └── sop/
        ├── REQUIREMENT-INTAKE.md
        ├── START-ITERATION.md
        ├── ITERATION-WORKFLOW.md
        ├── CHANGE-CONTROL.md
        ├── LOCAL-DEV.md
        ├── NEW-FEATURE.md
        ├── DOC-CHECK.md
        ├── PAIRING-WORKFLOW.md
        ├── TESTING.md
        ├── GIT-WORKFLOW.md
        └── RELEASE.md
```

Add specialized SOPs only when derived from risk: API contract, database migration, security,
privacy/compliance, visual QA, operations, or similar.

## Scaled Profiles

Do not ask users to pick internal labels. Recommend one in plain language.

| Internal profile | Plain-language explanation | Required capability baseline |
| --- | --- | --- |
| `minimal` | Basic rules for safe Agent collaboration on a small project. | Agent guide, manifest, evolution feedback, testing, Git. |
| `product` | Continuous feature development with planned work and changing requirements. | Minimal plus document map, backlog, iterations, requirement intake, iteration workflow, change control, reference facts. |
| `high-risk` | Product work where release, security, permissions, data, or integrations can cause material harm. | Product plus decisions, roadmap, proposals as needed, release/pairing and derived risk SOPs. |

Minimal is conformant when non-applicable capabilities are declared explicitly in its manifest.
It is not an excuse for a complex product to omit essential controls.

## Artifact Responsibilities

| Artifact | Responsibility | Must not become |
| --- | --- | --- |
| `AGENTS.md` | Compact launch rules, task router, known active traps and applicable close-out gates. | A dump of all design and historical documentation. |
| `manifest.yaml` | Governance adoption/state metadata and capability map. | A duplicate of SOP content. |
| `EVOLUTION.md` | Reusable lessons from observed failures or corrections. | A generic changelog. |
| Backlog | Implementable stories and, when needed, Epic containers with child/dependency traceability. | A long-term brainstorm list or untracked large plan. |
| Iterations | Published plan baseline, lifecycle disposition, selected work, execution result, validation and retrospective. | A reusable identifier whose original target can be replaced by unrelated execution or ignored when new work starts. |
| Decisions | Important tradeoffs, alternatives, and supersession. Each decision record should include a constraint decomposition (Hard/Soft/Assumption) and a reversal trigger stating when to revisit the decision. | Routine implementation notes. |
| Roadmap | Stage ordering and prioritization logic. | A substitute for executable work items. |
| Proposals | Uncommitted directions not yet executable. | Tasks Agents directly start coding. |
| Board | Derived operating view of Now, Review, Blocked/Paused, Next and Later work. Each row links to an owner doc and has an explicit gate. | A second backlog, execution log, acceptance checklist, or source of truth for status. |
| Reference | Stable facts such as architecture, contracts, config, test inventory. | Procedures and moving status. |
| User Documentation | README, usage/installation instructions, changelog, release notes. Updated as part of each iteration's deliverable, not deferred to a separate documentation phase. | Internal governance procedures. |
| SOP | Procedures and checks for recurring actions. | Duplicated technical truth that drifts from reference/code. |

## Agent Guide Quality Contract

For a project where Agents modify code, `AGENTS.md` is not complete merely because it exists.
Keep detailed procedures in `docs/sop/`, but expose the execution rules an Agent must see before
choosing a deeper document.

Minimum sections for a `product` or `high-risk` project:

| Section | Required content |
| --- | --- |
| Hard Constraints | Worktree check, routing-before-process-work, backlog/change-control rules, documentation ownership, lessons and decision write-back, and project-derived prohibitions. |
| Coding Behavior | Rules governing how the Agent writes code. Read [references/coding-behavior.md](coding-behavior.md) for the full guidelines; at minimum include: state assumptions before implementing; only write code directly asked for (no speculative features, no premature abstractions, no unsolicited refactoring); match existing style even if different from personal preference; define verifiable success criteria before starting; clean up only what your own changes orphan. |
| Git Rules | Staged-diff review, safe staging, and the complete commit format an Agent must follow before any direct shell commit. Put non-standard commit requirements here, not only in `docs/sop/GIT-WORKFLOW.md`. At minimum, when an Agent generates a commit, `AGENTS.md` must state a full format such as `type(scope): description (#story-id) [model:<model-name>]`, define scope, and say `[model:<model-name>]` is required for Agent-authored or Agent-assisted commits. |
| Task Router | Routes for project orientation, intake, iteration start, in-iteration change, implementation, testing, Git, diagnosis, document maintenance and decisions; all mandatory targets must exist. |
| Session End Checklist | Status synchronization, verification evidence, residual-work registration, lessons/decision write-back, commit readiness checks, documentation synchronization check ("Did this session change observable behavior? If yes, are user-facing docs updated?"), derived board synchronization when `docs/BOARD.md` exists ("Did owner docs change active/review/paused/next state? If yes, were owner docs updated first and then the board?"), and a decision review: "Did this session make any technical choice that affects Soft or Assumption constraints? If yes, is it recorded in docs/decisions/?" |
| Current Known Traps | Include when discovery or `EVOLUTION.md` exposes active project-specific traps. |

For `minimal` projects, include the same sections that apply to its actual work; at minimum an
Agent that edits code needs Hard Constraints, Coding Behavior, Git Rules, Task Router and Session
End Checklist.

## Evolution Feedback Quality Contract

`EVOLUTION.md` must be usable during diagnosis, not only serve as an append-only lesson list.
When `evolution_feedback` is applicable:

- state when a new lesson must be written back, such as a corrected omission, repeated failure,
  newly discovered trap, or unexpectedly successful workaround;
- provide a repeatable entry shape covering symptom, cause, remedy and reusable prevention;
- once multiple lessons exist, add a short lookup table or equivalent index so an Agent can find
  likely fixes before rereading the full history;
- route current mandatory constraints into `AGENTS.md` or an owning SOP rather than relying on
  lessons alone.

Do not force a particular language or heading scheme when an equivalent, navigable structure
already exists.

## Supporting Document Triggers

Create only documents supported by repository usage, but do not omit a procedure that an active
workflow already depends on.

| Document | Required when |
| --- | --- |
| `docs/README.md` | Profile is `product` or `high-risk`, or governance uses three or more `docs/` responsibility directories. |
| `docs/BOARD.md` | Optional for product/high-risk projects with multiple active status owners, non-terminal iterations, or frequent Agent handoffs. Must be a derived view only. |
| `docs/sop/START-ITERATION.md` and `docs/sop/ITERATION-WORKFLOW.md` | Iteration records exist, or the project uses planned feature iterations. |
| Published-plan baseline rule in iteration SOP/template | Iteration plans may be committed before execution or execution priority can change after planning. |
| Iteration inventory-before-selection rule in start workflow | Multiple iteration records may coexist or future plans are published ahead of work. |
| Epic/Story rules inside `docs/sop/REQUIREMENT-INTAKE.md` | Product work includes outcomes that span multiple independently testable slices, ordered stages, or iterations. |
| `docs/sop/CHANGE-CONTROL.md` | Profile is `product` or `high-risk`, or work can change after implementation begins. |
| `docs/sop/LOCAL-DEV.md` | Agents are expected to run or debug the application locally. |
| `docs/sop/NEW-FEATURE.md` | Agents are expected to add product behavior repeatedly. |
| `docs/sop/DOC-CHECK.md` | The project uses multiple standard governance document layers or migrates legacy documentation. |
| `docs/sop/PAIRING-WORKFLOW.md` | Complex/high-risk work needs staged implementation and review. |
| `docs/sop/RELEASE.md` | Agents support packaging, deployment or release verification. |
| Iteration MVP deliverable requirement | Profile is `product` or `high-risk`. Each iteration must produce a runnable, testable output. |
| Documentation synchronization in iteration workflow | Profile is `product` or `high-risk`. User-facing docs (README, usage guide, changelog) are updated as part of each iteration, not deferred. |

## Derived Operating Board

For product or high-risk projects with multiple active status owners, `docs/BOARD.md` may be
added as a derived operating view. It helps Agents answer current operating questions quickly,
but owner docs still define truth.

Rules:

- Owner docs define status, scope, acceptance criteria, verification evidence and lifecycle state;
  the board only summarizes current operating state.
- Status changes are made in owner docs first, then reflected on the board.
- Every row links to an owner doc.
- Every row has an explicit gate: exit, resume, activation or deferral condition.
- The board must not contain story details, acceptance checklists, execution logs or new
  requirements.
- Keep board tables to four columns: `Item`, `State`, `Owner Doc`, `Gate`.

## Non-Standard Source Migration

When initializing or adopting a repository that already has useful documents outside this
structure, do not leave authoritative active content in parallel locations. Extract content by
responsibility into the standard owner, preserve or archive useful source history, and record the
source-to-target mapping in `.agent-governance/manifest.yaml`.

Typical extraction examples:

| Existing content | Standard destination |
| --- | --- |
| Root-level development rules or Agent prompts | `AGENTS.md` |
| Mixed migration summary containing current boundaries and lessons | `docs/reference/`, `docs/decisions/`, `EVOLUTION.md`, and optionally `docs/archive/` |
| Informal feature list with implementable items | `docs/backlog/` |
| Repeatable deployment/test steps inside a plan file | `docs/sop/` |

Do not declare the affected capability `conformant` until active content is reachable in its
standard owner or a deliberately retained standard mapping.

## Conformance Audit

A project is structurally conformant only when:

- the manifest exists and states a justified profile;
- all applicable standard entrypoints exist or explicitly map migrated sources;
- `AGENTS.md` meets its quality contract and routes recurring process tasks;
- implementation workflows define when a result is complete versus partial or blocked, so an
  Agent cannot finish after file creation while omitting status/evidence/follow-up closure;
- procedures point to current toolchain, paths, and architecture;
- planned work/status sources do not contradict completed records;
- if a board exists, it is explicitly marked as a derived operating view rather than a source of
  truth;
- board rows link to owner docs and include explicit gates;
- board state does not contradict backlog, iteration, roadmap, requirement convergence or manifest
  owners;
- applicable Epic/child relationships preserve project identifiers, dependency readiness and
  iteration traceability;
- a committed iteration plan remains identifiable after execution or reprioritization, and
  unrelated work has not silently replaced its baseline target;
- iteration-start procedures inventory non-terminal cycles before selecting new backlog stories,
  and expose status drift instead of bypassing it;
- project-specific high-risk surfaces have gates;
- lessons can feed process changes back into the structure.
- discovered non-standard documents have their still-valid active content extracted into standard
  owners or explicitly mapped, without losing source history.

## Decision Record Template

When an Agent makes a technical choice that affects Soft or Assumption constraints, it should
record the decision in `docs/decisions/` using this structure:

```markdown
# [Decision Title]

## Context
[Why a decision is needed]

## Constraint Decomposition

| Constraint | Type | Source | Can Change? |
| --- | --- | --- | --- |
| [constraint] | Hard / Soft / Assumption | [fact/decision/assumption] | No / Yes / Maybe |

## Reasoning
[From Hard constraints: what is the simplest approach that satisfies them?
From Soft constraints: why deviate from the simplest approach if we chose to?
From Assumptions: which need validation before this decision is trustworthy?]

## Decision
[What was chosen and what was rejected]

## Reversal Trigger
[Under what conditions should this decision be revisited? What facts would need to change?]
```

### When to Write a Decision Record

| Trigger | Example |
| --- | --- |
| Choosing between approaches that all satisfy Hard constraints | REST vs gRPC for internal services |
| Proceeding based on an unvalidated Assumption | "Scaling won't be needed until next year" |
| Overriding a Soft constraint with justification | "Using a cache despite the 'no caching' convention" |
| A Hard constraint forces an unpopular choice | "Must use stored procedures due to compliance" |

Do NOT write a decision record for trivial changes that follow established patterns with no
constraint implications.

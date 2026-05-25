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
| `AGENTS.md` | Compact launch rules, task router, known active traps. | A dump of all design and historical documentation. |
| `manifest.yaml` | Governance adoption/state metadata and capability map. | A duplicate of SOP content. |
| `EVOLUTION.md` | Reusable lessons from observed failures or corrections. | A generic changelog. |
| Backlog | Implementable work and its acceptance/validation requirements. | A long-term brainstorm list. |
| Iterations | Selected work, execution result, validation and retrospective. | The canonical product requirements source. |
| Decisions | Important tradeoffs, alternatives, and supersession. | Routine implementation notes. |
| Roadmap | Stage ordering and prioritization logic. | A substitute for executable work items. |
| Proposals | Uncommitted directions not yet executable. | Tasks Agents directly start coding. |
| Reference | Stable facts such as architecture, contracts, config, test inventory. | Procedures and moving status. |
| SOP | Procedures and checks for recurring actions. | Duplicated technical truth that drifts from reference/code. |

## Agent Guide Quality Contract

For a project where Agents modify code, `AGENTS.md` is not complete merely because it exists.
Keep detailed procedures in `docs/sop/`, but expose the execution rules an Agent must see before
choosing a deeper document.

Minimum sections for a `product` or `high-risk` project:

| Section | Required content |
| --- | --- |
| Hard Constraints | Worktree check, routing-before-process-work, backlog/change-control rules, documentation ownership, lessons and decision write-back, and project-derived prohibitions. |
| Git Rules | Staged-diff review, safe staging, commit convention and traceability rule when applicable. |
| Task Router | Routes for project orientation, intake, iteration start, in-iteration change, implementation, testing, Git, diagnosis, document maintenance and decisions; all mandatory targets must exist. |
| Session End Checklist | Status synchronization, verification evidence, lessons/decision write-back, and commit readiness checks. |
| Current Known Traps | Include when discovery or `EVOLUTION.md` exposes active project-specific traps. |

For `minimal` projects, include the same sections that apply to its actual work; at minimum an
Agent that edits code needs Hard Constraints, Git Rules, Task Router and Session End Checklist.

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
| `docs/sop/START-ITERATION.md` and `docs/sop/ITERATION-WORKFLOW.md` | Iteration records exist, or the project uses planned feature iterations. |
| `docs/sop/CHANGE-CONTROL.md` | Profile is `product` or `high-risk`, or work can change after implementation begins. |
| `docs/sop/LOCAL-DEV.md` | Agents are expected to run or debug the application locally. |
| `docs/sop/NEW-FEATURE.md` | Agents are expected to add product behavior repeatedly. |
| `docs/sop/DOC-CHECK.md` | The project uses multiple standard governance document layers or migrates legacy documentation. |
| `docs/sop/PAIRING-WORKFLOW.md` | Complex/high-risk work needs staged implementation and review. |
| `docs/sop/RELEASE.md` | Agents support packaging, deployment or release verification. |

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
- procedures point to current toolchain, paths, and architecture;
- planned work/status sources do not contradict completed records;
- project-specific high-risk surfaces have gates;
- lessons can feed process changes back into the structure.
- discovered non-standard documents have their still-valid active content extracted into standard
  owners or explicitly mapped, without losing source history.

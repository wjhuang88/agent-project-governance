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
| `product` | Continuous feature development with planned work and changing requirements. | Minimal plus backlog, iterations, requirement intake, change control, reference facts. |
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

## Conformance Audit

A project is structurally conformant only when:

- the manifest exists and states a justified profile;
- all applicable standard entrypoints exist or explicitly map migrated sources;
- `AGENTS.md` routes recurring process tasks;
- procedures point to current toolchain, paths, and architecture;
- planned work/status sources do not contradict completed records;
- project-specific high-risk surfaces have gates;
- lessons can feed process changes back into the structure.

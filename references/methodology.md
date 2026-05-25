# Methodology

## Purpose

Generate a project governance system from the shape of the project and the failures it can
experience. Do not begin with a folder template and assume it fits.

## Governing Ideas

### Make Agent Execution Navigable

An Agent needs a short mandatory entrypoint and routed detail, not a single large handbook.
Create a project entrypoint that identifies hard constraints and maps task types to deeper
instructions or authoritative facts.

### Convert Work Into Verifiable Slices

Separate:

- future ideas that need exploration;
- decisions that alter architecture or product direction;
- planned stages and dependencies;
- executable work with acceptance criteria;
- execution records and validation results.

An Agent should implement only work that is small enough and specific enough to validate.

### Generate Gates From Risk

Use this reasoning chain:

```text
What can fail repeatedly or expensively?
-> What evidence would reveal/prevent the failure?
-> At what workflow point must that evidence be checked?
-> Where must the rule live so an Agent finds it?
```

A gate without a project-derived failure mode is overhead. A known expensive failure without a
gate is unfinished process design.

### Control Scope Before Continuing Implementation

Agent-assisted work is especially vulnerable to mid-task scope drift. Distinguish:

- clarification that leaves acceptance unchanged;
- small scope change within the same concept;
- new independent future work;
- product or architecture pivot;
- urgent repair that legitimately interrupts planned work.

Require recording and re-planning before expanding code for any change that affects the current
acceptance target.

### Separate Implementation And Review

For complex or risky changes, use staged pairing:

```text
Driver establishes and implements a bounded slice
-> Navigator reviews evidence, gaps, and scope
-> Driver fixes grounded findings
-> Navigator verifies commit readiness
```

Review findings must cite a requirement, documented target, changed file, diff, test, or
specific operational risk.

### Feed Failure Back Into The Process

When a user catches an omission, a validation misses a real defect, or an architecture boundary
is misunderstood:

1. fix the immediate defect;
2. record symptom, root cause, remedy, and reusable lesson;
3. determine whether task routing, a SOP check, stable reference, or risk gate should change.

This feedback loop is the source of a project-specific governance system.

## Separation Of Responsibilities

| Information type | Appropriate owner |
| --- | --- |
| Mandatory Agent entry rules and routes | `AGENTS.md` |
| Recurring procedures | `docs/sop/` |
| Stable technical facts and contracts | `docs/reference/` |
| Executable planned work | `docs/backlog/` |
| A bounded work cycle and its result | `docs/iterations/` |
| Significant choices and supersession | `docs/decisions/` |
| Direction and ordering | `docs/roadmap/` |
| Immature or far-future ideas | `docs/proposals/` |
| Discovered traps and process learning | `EVOLUTION.md` |

Use only layers justified by the project profile, but do not merge distinct responsibilities in
a way that makes Agents guess which statement is authoritative.

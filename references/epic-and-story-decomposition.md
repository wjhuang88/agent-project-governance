# Epic And Story Decomposition

## Purpose

Use this reference when a product backlog contains large, multi-stage requirements or when an
Agent must design requirement-intake and iteration rules. The result should make small work
executable without rewriting a project's existing history.

## Explain The Problem First

Users do not need process vocabulary before they can make good choices. Start with:

- "This item contains several results that can finish or fail separately."
- "We need a parent record for the overall outcome and smaller records an Agent can actually
  complete and verify."
- "We will preserve the identifiers and records you already use, then apply a predictable
  relationship rule to new work."

Introduce `Epic`, `Story` and `Definition of Ready (DoR)` only after connecting each term to
that practical purpose.

## Decide Whether A Parent Container Is Needed

Treat a work item as an **executable Story** when it delivers one independently verifiable
outcome in the project's normal small delivery window.

Treat a work item as an **Epic** when any of these is true:

1. It exceeds the normal small delivery window and cannot be validated safely as one batch.
2. It includes multiple outcomes that can each be accepted or rejected independently.
3. It must progress through ordered stages such as foundation, migration, integration, rollout
   or cleanup.
4. It needs an early investigation, security check or compatibility proof to unblock later work.
5. It will span iterations or roadmap stages and one completion status would conceal partial
   delivery.

Do not create an Epic solely because a Story changes several technical layers. A vertical Story
may appropriately update frontend, backend and documentation together if it still has one
acceptance outcome.

## Split In This Order

Prefer dimensions that leave every child meaningful and verifiable:

| Priority | Split dimension | Use when | Avoid |
| --- | --- | --- | --- |
| 1 | End-to-end value or observable outcome | A caller/user can validate each delivered slice. | Dividing UI and API when neither works alone. |
| 2 | Risk or unknown first | A spike, permission boundary, migration proof or performance test unlocks decisions. | Calling open-ended research a Story without a conclusion. |
| 3 | Delivery stage or dependency boundary | Foundation must precede integration, rollout or cleanup. | Claiming dependent stages run independently. |
| 4 | Module, layer or ownership | A layer artifact is itself verifiable or intentionally unlocks later work. | Splitting just to match teams or folders. |

A child Story should:

- produce one stated outcome;
- fit the project's small delivery window;
- be independently reviewable and status-trackable;
- include acceptance checks, minimum validation and exclusions;
- state what dependency it consumes and what future work it unlocks.

If a child cannot be meaningfully validated without a sibling, merge them or describe it as an
explicit enabling Story with an honest dependency boundary.

## Preserve Identifiers And Express Relationships

Discover the project's existing identifier convention before proposing one. For new Epic
families, recommend:

```text
<PREFIX>-012       parent Epic
<PREFIX>-012-A     child Story
<PREFIX>-012-B     child Story
```

Rules:

- Retain the existing prefix (`APP`, `PB`, `EVO`, ticket-system key, or another convention).
- Do not renumber historical items merely to conform. Record older parent/child relationships
  explicitly and use the new suffix convention going forward where suitable.
- If an existing Story expands into an Epic, retain its ID as the parent and create new child
  suffixes.
- Prefer one parent-to-child level. A child that needs extensive subchildren is a signal to
  refine scope or promote a new Epic rather than create a difficult-to-read tree.

An Epic record must reference its children; each child must reference its parent. Do not infer
relationships from adjacent numbers alone.

## Record And Validate Dependencies

Require every Epic to maintain a child summary:

```markdown
| Child | Outcome | Status | Depends on | Iteration |
|-------|---------|--------|------------|-----------|
| PB-012-A | Establish build entrypoint | Ready | None | - |
| PB-012-B | Switch deployment path | Proposed | PB-012-A | - |
```

Require every child Story to state:

- parent Epic;
- hard dependencies or external blockers;
- outcome it unlocks, if any;
- acceptance criteria and minimum validation.

Before marking a child `Ready` or selecting it into an iteration:

1. Ensure each hard dependency names a specific child, external condition or decision record.
2. Ensure dependencies do not form a cycle.
3. Ensure hard prerequisites are complete, or selected earlier in the same iteration with a
   recorded execution and validation sequence.
4. When a child is deferred, dropped or completed, synchronize the Epic summary and revisit its
   completion condition.

## Distinguish Readiness Levels

An Epic can be ready for planning without being directly implementable:

| Readiness subject | Minimum requirement |
| --- | --- |
| Epic for roadmap/refinement | Overall outcome and boundary, reason for decomposition, first child set or a bounded decomposition activity, major dependency/risk map, completion condition. |
| Child Story for implementation | One outcome, small enough scope, acceptance and minimum validation, affected surfaces, exclusions, parent/dependency fields, no unresolved hard prerequisite. |

Iteration planning must select ready Stories, not a parent Epic with an unfinished checklist
inside it.

## Select Work Into Iterations

- For one-Agent micro-iterations, default to one ready Story.
- For ordinary iterations, children from multiple Epics may be selected when they support a
  coherent goal, are individually ready, fit WIP limits and have compatible dependency order.
- Multiple children from one Epic may enter the same iteration when their order and verification
  remain explicit.
- Completing a child updates the parent summary; the Epic becomes done only when its required
  child outcomes are complete or deliberately removed with an explicit scope decision.

## Governance Artifacts To Generate Or Repair

For applicable product projects, ensure:

- requirement intake defines Epic versus Story, identifier relationships, dependency checks and
  separate readiness criteria;
- iteration-start rules reject bare Epic selection and enforce dependency closure;
- iteration/review rules synchronize completed child status back to the parent;
- document-consistency checks detect orphan children, stale parent summaries and false Epic
  completion;
- guided onboarding describes the relationship in ordinary language for users unfamiliar with
  planning terminology.

# Iteration Baseline Integrity

## When To Read This

Use this reference when a project publishes iteration plans before implementation, changes
priority after planning, uses later iterations that depend on an earlier planned result, or has
already overwritten a plan document with different completed work.

## Why A Published Plan Must Remain Visible

A committed plan is evidence of intended scope, assumptions and dependency order. Actual results
are meaningful only when reviewers can compare them with that baseline. Replacing a published
plan with unrelated work loses three things:

- the reason downstream work was considered ready;
- the record of what was deliberately deferred or changed;
- the ability to distinguish delivered work from work that merely occupied its identifier.

Use plain language with beginners: a planned iteration is a dated promise about what will be
checked next. When priorities change, keep that promise visible and create a new page for the
replacement work.

## Generate The Project Rule

For any project where iteration documents can be committed before work begins, establish these
rules in the Agent entrypoint, iteration-start workflow, change-control workflow, document
check, and iteration template:

1. A committed `Planned` iteration becomes a published plan baseline.
2. The baseline includes original objective, selected or candidate stories, dependencies, scope
   exclusions, acceptance checks and planned validation.
3. Work for the same objective may activate the document and append evidence, variance and
   retrospective; it must not erase the original target.
4. Work for a different objective or story set must use a new iteration identifier.
5. The abandoned plan records whether it is deferred, superseded or blocked and why.
6. A later plan dependent on an unexecuted baseline becomes blocked for activation until that
   prerequisite is replanned and satisfied.
7. Starting a new cycle first inventories non-terminal iteration documents and records their
   disposition before querying the backlog for new work.

Do not force an iteration workflow into a small project that does not plan work this way. The
rule is applicable when committed plans or dependent execution records exist.

## Minimal Template Content

A published plan should distinguish immutable baseline material from appended execution facts:

```markdown
# Iteration NNN: <planned objective>

> Document status: Planned
> Published plan date:
> Planned objective:
> Baseline rule: once published, this planned target is preserved; changed targets use a new ID.

## Published Baseline
- selected or candidate stories and parent relationship where applicable
- prerequisites and dependencies
- scope and explicit non-goals
- planned acceptance and validation
- risks and rollback assumptions

## Actual Activation And Execution
| Date | Type | Record |
| --- | --- | --- |
```

The target project may rename headings or statuses. Preserve the distinction between prior plan
and later facts.

## Inventory Before Backlog Selection

When a user requests a new or next iteration, inspect iteration records before scanning the
backlog for ready work.

| Existing state | Mandatory decision before selecting new backlog work |
| --- | --- |
| `Active` / `In Progress` | Continue, close, or pause/switch with a change record; an urgent or process-repair interruption must be explicit. |
| `Review` | Complete evidence and status closure, or register the blocker/residual work. |
| `Planned` | Activate the baseline if still correct, or record its deferral, supersession or blockage. |
| `Blocked` | Confirm the blocker and its impact; unrelated work is allowed only after recording continued blockage or another disposition. |
| `Closed` / `Deferred` | No activation blocker; read only when dependency checking requires it. |

A story table showing `Done` does not by itself close its iteration. Treat status drift or
missing completion evidence as degradation; move the iteration to `Review` until the evidence
or residual disposition is recorded rather than claiming it is closed.

## Activation And Replanning Decision

Before starting a published iteration, compare intended execution with its baseline.

| Situation | Correct action |
| --- | --- |
| Same objective and acceptance boundary | Activate the existing plan and append execution evidence. |
| Same objective with a bounded clarification | Record the clarification before coding and append evidence. |
| Different story, Epic, outcome or acceptance target | Leave the original baseline visible, record the replan, and create a new iteration ID. |
| A planned prerequisite will not run as scheduled | Mark dependent future plans blocked until a new prerequisite plan exists. |

Higher priority is a reason to replan, not permission to overwrite.

## Repair An Already Overwritten Document

When discovering a historical overwrite:

1. Recover the last published baseline from version control, review records or other reliable
   evidence.
2. Do not remove actual completion records for replacement work that did happen.
3. Add a clear deviation note stating the original target, replacement work, date or source of
   the deviation, and whether the original objective remains undone.
4. Restore the minimum original baseline needed for traceability: target, candidate/selected
   work, prerequisites and non-goals.
5. Examine downstream plans and mark any invalid activation assumptions as blocked.
6. Register a focused governance repair item and write the reusable lesson into the project's
   feedback mechanism.

Avoid falsifying history in either direction: the replacement execution did occur, and the
original plan was not fulfilled.

## Initialization And Audit Guidance

During initialization or adoption:

- inspect whether future iteration records already exist and whether later execution retains
  their published targets;
- inspect all non-terminal iteration records before allowing selection from the backlog, and
  require a recorded disposition for active, review, planned and blocked work;
- explain the baseline rule before generating an iteration template for a non-expert user;
- add the rule only to documents appropriate for the project's selected governance profile;
- preserve existing historical records during migration and record any necessary repairs.

During audit, report degradation when:

- a document title, original objective or dependencies disagree with its completion record;
- different work has reused a published identifier without a replan record;
- downstream work still claims an unmet prerequisite;
- status claims hide missing baseline or validation evidence.
- a new iteration was selected while non-terminal iteration work or blockage remained
  undispositioned.

The repair is complete only when plan history, actual execution, dependencies and the prevention
rule are all traceable.

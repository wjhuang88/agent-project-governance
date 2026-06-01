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
When one planned outcome contains several independently valid results or ordered phases, keep it
as an Epic-level container and execute child stories instead of letting a large status label hide
partial delivery. Use
[epic-and-story-decomposition.md](epic-and-story-decomposition.md) when designing that contract.

### Match Story Format To The Work

Traditional user-story wording is valuable for behavior a user or caller can observe. It becomes
misleading when every technical, governance or exploratory task is forced into `As a user` form.
For Agent-governed projects, make requirement intake distinguish Product/User, API/Permission,
Technical, Governance and Spike stories.

Require behavior-facing stories to state role, goal, value and Given/When/Then acceptance. For
technical, governance and spike work, require equivalent evidence instead: engineering or process
goal, scope, exclusions, command or manual validation, status owners and residual-work tracking.

The goal is not format uniformity; the goal is that an Agent can decide whether the item is ready,
what it must not do, and what evidence proves completion. Use
[story-format-and-bdd.md](story-format-and-bdd.md) when designing this part of the governance
model.

### Adapt Sprint Concepts Without Copying Scrum

A Scrum Sprint is a team timebox with planning, capacity, ceremonies and review. An Agent
iteration is an auditable work batch. It may be a one-story micro-iteration, a product batch, a
published future plan, or a governance repair slice.

Borrow these Sprint ideas when useful:

- a clear iteration goal;
- small work selection;
- acceptance before implementation;
- review against evidence;
- retrospective lessons converted into process checks.

Do not require team-capacity rituals, burn-down reporting or ceremony artifacts unless the target
project already benefits from them. The invariant is traceability from selected story to evidence
and closure, not conformance to Scrum vocabulary.

### Make Every Iteration Produce A Runnable Deliverable

Inspired by MVP thinking: the purpose of an iteration is to produce something that can be run
and tested, not just a collection of completed tasks. This principle applies to planning and
Story selection:

1. **Plan for testable output.** When selecting Stories for an iteration, ensure their combined
   result is something a user or reviewer can execute and validate end-to-end.
2. **Prefer the smallest viable increment.** Choose the minimum set of Stories that delivers
   observable value. An iteration that produces only internal plumbing without a testable
   surface is acceptable only as an explicit, documented exception.
3. **Slice vertically when possible.** A thin vertical slice (frontend + backend + test) that
   demonstrates one capability is preferable to a thick horizontal layer that demonstrates
   nothing independently.

An iteration plan that cannot articulate its runnable deliverable is incomplete.

### Synchronize User-Facing Documentation Within Each Iteration

Documentation is not a post-release cleanup task. It is part of the iteration's Definition of
Done:

- Stories that change observable behavior must include documentation updates in their acceptance
  criteria.
- The iteration template includes a documentation checklist: which user-facing files (README,
  usage instructions, API docs, changelog, release notes) are expected to change.
- The iteration retrospective confirms documentation was updated. Unresolved documentation debt
  is a residual item, not silently deferred to a future iteration.
- For `product` and `high-risk` profiles, the iteration-start SOP must prompt the Agent to
  identify affected documentation before coding begins.

### Make Evidence Precede Completion

A status field or checked acceptance box is not verification. For any executable story, require
the recorded validation result to identify what was actually run or manually checked and whether
it passed. Planning records should exist before implementation begins; retroactively writing a
story as started and completed in one close-out step removes the review point that could have
caught scope and validation gaps.

Use these completion rules:

- do not mark a required gate complete when it failed, was not run, or was replaced by a narrower
  check;
- keep a story in review or create a repair slice when verification finds a blocking defect;
- for high-risk work, require a distinct review conclusion before completion.

A particularly deceptive omission is the **built-but-unwired** capability: a module is created and
its unit tests pass, yet no user-reachable path in the delivered runnable surface invokes it.
Passing unit tests prove a unit works in isolation; they do not prove the capability is reachable
through the runnable deliverable the iteration claims to produce. For any story that delivers a
new runtime capability, require evidence that the capability is exercised through the delivered
surface (CLI invocation, interactive/TUI path, API call, or an end-to-end test that drives the
real entrypoint), not only through an isolated unit test. "Library exists and is unit-tested" is
`partial`, not `complete`, until the capability is integrated into a path a user or caller can
actually reach.

### Preserve Published Plans As Comparison Evidence

An iteration plan committed before execution is not an unused identifier that later work may
reuse. It records the target against which delivery, variance and prioritization should be
evaluated.

Derive the following rules when projects publish iteration plans:

- execution for the same target appends activation, results, evidence and retrospective to the
  existing baseline without deleting its original scope;
- execution for a different target uses a new iteration identifier, while the old plan records
  its delay, supersession or blockage;
- downstream planned work that depended on an abandoned prerequisite cannot be activated until
  the prerequisite is re-established under an auditable plan;
- if an existing document was overwritten already, retain the actual work evidence and restore a
  concise original-baseline and deviation note rather than pretending either history did not
  happen.

Preserving published plans is insufficient if agents can ignore them at the next start command.
Before selecting backlog work, require a disposition of existing iteration inventory: continue
or close active and review work; activate, defer or explicitly leave planned and blocked work
blocked. A blocked plan may permit unrelated work only after that decision and its dependency
impact are recorded.

Use [iteration-baseline-integrity.md](iteration-baseline-integrity.md) when generating or
repairing the project-specific workflow.

### Design For Agents That May Stop Too Early

Process instructions that only state correct principles still permit a weak executor to edit a
few files and announce success. For governance implementation, reduce freedom at the completion
boundary:

- require a closure ledger before edits so the Agent cannot silently omit status owners,
  validation or residual work;
- require a fixed sequence of establish, implement, verify, synchronize and deliver;
- define `complete`, `partial` and `blocked` so useful intermediate work is reportable without
  falsifying completion;
- turn observed omissions into an evaluation case and, where deterministic, a validator check.

Do not turn every design decision into a script. Use low-freedom steps for state transitions and
evidence; retain judgment for choosing project-appropriate artifacts and gates. See
[closure-protocol.md](closure-protocol.md).

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

### Treat Outbound Execution As A Security Boundary

When a project lets API clients, agents, webhooks, plugins, or configured tools trigger outbound
requests or side effects, registration and discovery are not sufficient controls. Derive gates
for:

- who may trigger execution, including public-discovery versus execution boundaries;
- deterministic initialization that does not depend on implicit host proxy or optional
  infrastructure discovery;
- timeout, response-size and error-mapping behavior;
- local controllable tests for success, rejection and failure cases rather than public network
  dependencies.

Do not prescribe a specific HTTP library or proxy strategy. Require the target project to make
its network behavior explicit and verifiable.

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

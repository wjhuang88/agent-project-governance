# Evaluation Cases

## Purpose

Forward-test whether this skill derives useful governance from evidence rather than copying a
source project's SOPs. Present a case to an Agent with the skill available and check the expected
reasoning and recommendations.

## Case 1: New Small Library With A Beginner User

Input:

- A single-language library with tests and Git, no deployment or database.
- User asks: "I want AI to help maintain this; set up whatever rules are needed."

Expected behavior:

- Classify as `uninitialized`.
- Explain risks without unexplained process terminology.
- Recommend basic collaboration rules, not a full product lifecycle.
- Propose `AGENTS.md`, manifest, evolution feedback, testing and Git instructions.
- Mark release/backlog/ADR capabilities `not_applicable` or defer them with reasons.

Failure signals:

- Creating a complex roadmap and release framework without evidence.
- Asking the user to choose among unexplained profile names.

## Case 2: Existing Product With Custom Docs

Input:

- A frontend/backend application with `CONTRIBUTING.md`, `docs/architecture/`, and deployment
  notes, but no standard manifest or Agent router.
- User wants Agent-assisted continued development.

Expected behavior:

- Classify as `discovered`.
- Inventory content in existing assets and extract applicable active rules/facts/procedures into
  standard owners while preserving source history.
- Propose a first adoption slice centered on entrypoint, manifest and lessons feedback.
- State that the long-term target is the standard structure, not permanent parallel governance.

Failure signals:

- Deleting existing documents.
- Creating standard placeholders while leaving active rules available only in custom documents.
- Declaring the custom layout complete without a migration path.

## Case 3: Toolchain Drift

Input:

- The project moved from one frontend package manager/build runtime to another.
- Current scripts use the new runtime, but Docker and process docs still use the old one.

Expected behavior:

- Identify drift as an execution reliability risk.
- Recommend one canonical tool and lockfile, plus checks over scripts, build images and
  instructions.
- If already initialized, classify relevant capability as `degraded` until repaired.

## Case 4: Public User Link Flow

Input:

- An application sends invitation or password reset emails.
- The email link uses an internal backend origin, and the accepting endpoint is unauthenticated
  but not reflected in middleware/testing guidance.

Expected behavior:

- Derive a linked gate covering public URL configuration, visible frontend route, API contract,
  authorization/CSRF exception behavior and tests.
- Recommend recording the lesson if the defect was already observed.

## Case 5: Transitional Deployment Mistaken For Target Architecture

Input:

- Static files are temporarily served through a reverse proxy while the roadmap says they will
  ultimately be embedded in a backend artifact.
- Documentation labels the proxy stack as final and plans CI around it prematurely.

Expected behavior:

- Separate current transition from final architecture.
- Recommend documenting both and deferring workflows that depend on unsettled final commands
  when appropriate.
- Add deployment-path checks only while the transition remains applicable.

## Case 6: Status Drift After Completed Work

Input:

- A summary table marks a story Done.
- Detailed acceptance criteria remain unchecked and the contract still labels implemented
  endpoints as unavailable.

Expected behavior:

- Treat this as governance degradation, not cosmetic editing.
- Recommend synchronizing detail/status/reference facts and adding a completion gate.

## Case 7: Contradictory Manifest And Stale Stable Facts

Input:

- A manifest declares `profile: product`, `change_control: conformant` and
  `iteration_workflow: not_applicable`.
- The repository already contains completed iteration records, but no change-control or
  iteration workflow SOP files.
- `AGENTS.md` and reference documentation instruct Agents to use a source client file that was
  removed during a recent refactor; current code imports another client.

Expected behavior:

- Classify the initialized governance baseline as `degraded`.
- Reject `not_applicable` for iteration workflow because iteration evidence exists and the
  product profile requires it.
- Report the missing SOP evidence behind the falsely conformant/missing capabilities.
- Report the stale source path as a stable-fact drift requiring entrypoint/reference repair.
- Recommend running the bundled validator during repair and after regeneration.

Failure signals:

- Treating manifest strings as sufficient evidence.
- Comparing only document counts with a benchmark project.
- Adding missing files without correcting stale rules or capability states.

## Case 8: Outbound Tool Execution Declared Complete Without Reliable Evidence

Input:

- An application exposes registered HTTP tools through an agent protocol endpoint.
- Tool listing may be public, but a newly implemented call path now executes outbound requests.
- The completed iteration marks tests and lint checks passed, while recorded evidence only shows
  partial tests; one test calls a public delay service.
- Initialization reads implicit host proxy configuration and upstream 5xx responses are wrapped
  as normal results.

Expected behavior:

- Treat the executor as a security and operational boundary, not a routine handler.
- Require an explicit decision on anonymous discovery versus execution authorization.
- Derive gates for deterministic client initialization, timeout/response limits, and error
  mapping.
- Require local controllable tests for authenticated success, unauthenticated rejection,
  upstream errors and timeout/limit cases; reject public network dependencies as completion
  evidence.
- Mark governance or iteration completion as degraded until required commands are run and their
  actual outcomes match checked acceptance items.
- Recommend a process improvement that forces plan-before-code and staged review for outbound
  execution work.

Failure signals:

- Accepting `Done` because a status table is checked.
- Treating a publicly visible tool as automatically safe to execute anonymously.
- Recommending only more tests without addressing authorization or deterministic initialization.

## Case 9: A Multi-Stage Requirement Hidden As One Story

Input:

- A continuing product repository has a backlog item called "replace the frontend delivery
  stack", covering build migration, runtime configuration, deployment switching, cleanup and
  eventual CI updates.
- Some phases have already been assigned independent identifiers under an existing project
  prefix, while new requirements are still written as one large row.
- The user asks whether child work can be taken from different large initiatives in one
  iteration.

Expected behavior:

- Identify the oversized item as an Epic candidate because it has independently verifiable
  results and dependency ordering, not merely because it touches multiple directories.
- Preserve the existing identifier prefix and historical identifiers; recommend a parent/child
  convention such as `<PREFIX>-012` and `<PREFIX>-012-A` only for newly governed families or
  future children, rather than renumbering history.
- Require an Epic completion condition, child outcome/status/dependency table, and reciprocal
  parent reference in each child story.
- Distinguish Epic readiness for planning from Story readiness for implementation.
- Allow a normal iteration to select children across Epics only when each is ready, dependency
  closure is clear, WIP is controlled and the iteration goal remains coherent.
- Explain these choices in plain language before introducing terms such as Epic or DoR.

Failure signals:

- Forcing every layer or team into a separate child even though no child is independently
  testable.
- Selecting the parent Epic as executable work.
- Requiring renumbering of existing history solely to match the new convention.

## Case 10: A Published Future Iteration Is Reused For Different Work

Input:

- A product project commits future iteration documents before implementation.
- One published plan reserves an iteration for a prerequisite design/refinement story.
- Later, an executor edits that same document into the completion record for unrelated
  higher-priority stories, while a downstream plan still declares the original prerequisite.
- The user wants the already completed work retained and the process improved.

Expected behavior:

- Identify loss of the published comparison baseline and broken dependency traceability as a
  governance defect, not merely a stale title.
- Preserve actual completed-work evidence, while restoring a concise record of the original
  target and explicitly stating that it was not executed.
- Mark dependent future plans blocked until the original prerequisite is completed or deliberately
  replanned.
- Require new work with a different target to receive a new iteration identifier; only same-target
  execution may append progress and results to an existing published plan.
- Add this rule to the project entrypoint, relevant SOPs, iteration template, document audit and
  lessons feedback, scaled to the repository's existing structure.

Failure signals:

- Rewriting the document back to the original plan and losing real completion evidence.
- Accepting the repurposed document as valid because the replacement work is Done.
- Leaving dependent planned iterations activatable without their prerequisite.

## Case 11: Governance Files Are Generated But Initialization Is Not Closed

Input:

- A user asks an Agent to initialize governance for an existing product repository.
- The Agent creates `AGENTS.md` and several SOP files, but does not create or update the
  promised manifest, does not map existing process assets, does not run its validator and does
  not record missing release/change-control capability.
- The Agent says initialization is complete because the new files exist.

Expected behavior:

- Treat this as `partial`, not complete: file generation is only the implementation stage of the
  closure sequence.
- Before editing, identify required artifacts, state/status owners, evidence and residual-work
  destination in a closure ledger.
- Preserve useful existing assets and explicitly map or defer them rather than silently ignoring
  them.
- Run applicable deterministic validation and report the result; failed or unavailable required
  evidence prevents a complete claim.
- Synchronize manifest/capability state and register any intentionally deferred capability or
  discovered defect before delivering a closure status.

Failure signals:

- Declaring completion solely from the presence of generated files.
- Omitting validation or silently ignoring a promised artifact/status update.
- Mentioning remaining work in prose without recording where it will be tracked.

## Case 12: New Iteration Requested While Existing Cycles Are Not Settled

Input:

- A product project has ready backlog stories.
- One iteration is `In Progress` or `Review`; its stories show `Done`, but one mandatory
  acceptance item has no completion evidence.
- One future iteration is `Planned` or `Blocked`.
- The user asks to start the next iteration.

Expected behavior:

- Inspect iteration inventory before selecting work from the backlog.
- Treat the status mismatch as degraded governance and keep the first iteration in `Review`
  until its evidence or residual-work disposition is recorded.
- Assess the planned or blocked iteration and record whether it activates, remains blocked or is
  deferred before considering new work.
- Select unrelated backlog work only after those dispositions are explicit; a recorded blocker
  does not permanently freeze unrelated work.

Failure signals:

- Immediately selecting the highest-priority ready story without inspecting existing iterations.
- Closing an iteration merely because its stories show `Done`.
- Treating a blocked plan as either invisible or an indefinite prohibition without recording a
  decision.

## Case 13: User Story Format And BDD Are Applied Mechanically

Input:

- A product project uses Agent iterations rather than a full Scrum team process.
- The backlog contains mixed items: a user-visible email confirmation flow, an API permission
  boundary, a refactor, a governance SOP repair and an exploratory deployment spike.
- The user asks whether Sprint, user stories and BDD should be introduced.

Expected behavior:

- Explain that a traditional Sprint is a team timebox, while the project iteration should be an
  auditable work batch with goal, evidence and closure.
- Recommend borrowing small-batch planning, acceptance-first work, review and retrospective
  lessons without forcing ceremonies, capacity metrics or burn-down artifacts.
- Define multiple story shapes: Product/User, API/Permission/State, Technical, Governance and
  Spike.
- Require role, goal, value, scope, exclusions, dependencies, acceptance, validation and state
  owners before a story is Ready.
- Require Given/When/Then acceptance for the email flow and API permission boundary.
- Use equivalent technical acceptance for the refactor and governance repair, including commands,
  document consistency checks, status owners and residual-work tracking.
- Treat the deployment investigation as a Spike with a timebox and decision/evidence output.

Failure signals:

- Forcing every item into `As a user, I want...` wording even when there is no real user behavior.
- Accepting behavior-facing work without Given/When/Then scenarios or a clear exemption.
- Treating BDD scenarios as implementation checklists such as "Then the handler is updated".
- Introducing Scrum ceremony overhead without evidence that the project needs it.

## Acceptance For This Skill

The skill is effective when it:

- classifies initialization/adoption state correctly;
- communicates in usable language to a non-expert;
- preserves existing valid assets while specifying a convergent target;
- extracts still-valid content from non-standard documents into standard responsibility owners
  during initialization or adoption;
- derives only applicable risk gates;
- requires command-level evidence before completion and staged review for applicable high-risk
  changes;
- treats caller-triggered outbound actions as security boundaries when present;
- supplies executable Epic/Story decomposition rules when planned work spans independent slices;
- preserves published iteration baselines and repairs dependency traceability when execution
  diverges from a committed plan;
- forces iteration inventory disposition before new backlog selection when non-terminal cycles
  exist;
- matches story format to work type and requires BDD for behavior-facing acceptance while using
  equivalent evidence for technical, governance and spike work;
- forces implementation work through an explicit closure sequence and prevents unsupported
  `complete` claims when status, evidence or residual tracking is missing;
- turns observed failures into durable process improvements.

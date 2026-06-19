# Long-Running Task Protocol

Use this reference when generating or repairing a project SOP for work that should run through
multiple phases without repeated user interaction.

## Trigger

Create or apply `docs/sop/LONG-RUNNING-TASK.md` when any of these is true:

- the user asks for an unattended, autonomous, overnight, background, or long-running task;
- work spans three or more ordered implementation/validation phases;
- a command, build, migration, evaluation, or batch operation may run for more than 30 minutes;
- multiple repositories, worktrees, releases, migrations, or external systems must be coordinated;
- interruption would lose expensive progress or leave state difficult to reconstruct.

Do not use this protocol to make a short task ceremonial.

## Startup Contract

Before starting, write one complete task record and obtain one consolidated user confirmation.
Do not begin execution while required confirmation fields remain unresolved.

The task record must list:

```text
Outcome:
In scope:
Out of scope:
Ordered task items:
Dependencies and prerequisites:
Artifacts and state owners to update:
Validation and acceptance evidence:
Branch, worktree and checkpoint plan:
Allowed permissions and external actions:
Destructive or irreversible operations:
Time, cost and resource limits:
Failure, retry and fallback policy:
Default decisions for foreseeable ambiguity:
Residual-work destination:
```

Each task item needs an identifier, expected output, completion gate, dependencies, and fallback.
The list is the execution baseline; do not silently replace it with unrelated work.

## Consolidated Confirmation

Ask one grouped confirmation request that includes every decision the repository cannot answer:

- outcome, scope boundaries and priorities;
- acceptance criteria and required evidence;
- authorization to edit, execute, commit, push, release, migrate, deploy, spend money, use network
  services, or perform destructive actions as applicable;
- credentials, environments, accounts, branches, worktrees and deployment targets;
- time/cost/resource limits and acceptable retry behavior;
- default choices for expected ambiguity;
- what to defer versus what must stop the run;
- checkpoint, progress-recording and final-delivery expectations.

Discover repository facts before asking. Do not ask the user to reconfirm facts, permissions, or
defaults already provided in the request or local rules.

Confirmation should authorize the whole planned cycle, not only its first task item. Record the
approved contract in the task/iteration owner document before execution.

## Autonomous Execution Rules

After confirmation:

1. Execute the listed items in dependency order.
2. Use approved defaults without asking follow-up questions.
3. Record progress and evidence at phase checkpoints.
4. Commit an intended checkpoint before starting the next staged development phase when local Git
   rules require it.
5. Retry or use the approved fallback within the confirmed limits.
6. Defer optional work to the declared residual destination rather than interrupting the run.
7. Keep owner documents synchronized before updating derived views.

The Agent may interrupt and ask again only when a new condition is both unaddressed by the startup
contract and prevents safe, valid progress, such as:

- missing permission, credential, account, or environment access;
- a destructive or irreversible action not previously authorized;
- contradictory requirements that would change the approved outcome;
- a safety, legal, security, privacy, or material-cost risk outside confirmed limits;
- repeated prerequisite failure after the approved retry/fallback policy is exhausted.

For a non-blocking unknown, choose the confirmed default, use the safest reversible option, or
defer it. Do not interrupt merely to ask for preference.

## Checkpoints And Recovery

Each checkpoint records:

```text
Completed task items:
Current state and artifacts:
Commands/checks and actual results:
Open risks or deviations:
Next task item:
Recovery or resume instruction:
```

Store checkpoints in the owning task or iteration record. A Git commit may preserve code state,
but it does not replace progress, validation, and recovery records.

## Harness Checks

When the project generates long-running task records, add deterministic checks where practical:

- required startup-contract fields exist;
- every task item has an identifier, gate and dependency/fallback field;
- required confirmation is recorded before status becomes `In Progress`;
- phase completion includes validation evidence;
- checkpoint/resume information exists for non-terminal work;
- `complete` is rejected when task items, state synchronization, or evidence remain unresolved.

Keep semantic judgments, such as whether the scope is wise or acceptance is meaningful, with the
Agent/user. The harness checks structure and recorded evidence.

# Closure Protocol

## When To Read This

Read before implementing governance initialization, adoption, audit repair or process
improvements. This protocol is deliberately mechanical because the Agent using the skill may be
good at producing files but weak at checking whether the user's problem is actually closed.

## Required Outcome

A governance change is closed only when all applicable outputs are true:

| Closure dimension | Required result |
| --- | --- |
| Artifacts | Requested governance files or edits exist and preserve relevant prior content. |
| State | Manifest, capability, backlog, iteration, dependency or supersession owners are synchronized where applicable. |
| Evidence | Required validation has been run and its actual result recorded; failures are not marked complete. |
| Residuals | Known omitted work, blockers or failed checks are registered in an owning artifact or explicitly out of scope. |
| Delivery | The user receives an explicit `complete`, `partial` or `blocked` status with evidence. |

If any applicable dimension is absent, the outcome is not `complete`.

## Step 0: Create A Closure Ledger

Before editing, fill this minimal ledger in the working note, iteration record or final report
draft. Do not rely on memory.

```markdown
Requested outcome:
Artifacts to create or update:
Existing assets to preserve:
State/status owners to synchronize:
Validation required:
Residual-work destination:
```

For a diagnosis-only request, the ledger may stop after identifying the recommended next slice.
For implementation, proceed through every stage below.

## Step 1: Establish

1. Read the repository state and required local instructions before writing.
2. Determine whether the project is uninitialized, discovered, adopting, conformant or degraded.
3. Identify the smallest complete slice the user authorized.
4. Record protected existing documents and uncommitted changes.
5. Add missing work to the project's planned-work owner before implementation when its
   governance already requires this.

Stop as `blocked` if a required source cannot be read or writing requires permission the user
does not grant. Do not call an unexecuted plan complete.

## Step 2: Implement

Implement only the established slice. During implementation:

- preserve or explicitly map useful legacy content;
- write requirements, workflow and status information to their owning artifacts;
- use project-specific rules rather than generic placeholders;
- if the requested target changes, apply change control before expanding edits.

Creating files is not a completion event. Continue to verification and synchronization.

## Step 3: Verify

Run checks applicable to what changed:

| Changed surface | Minimum evidence |
| --- | --- |
| Skill package | Skill structure validator and whitespace/diff check. |
| Project governance Markdown | Local-link check and whitespace/diff check. |
| Manifest/capability declaration | Project governance validator or an explicitly recorded reason it cannot yet pass. |
| Changed command, build or release rule | Verify against repository scripts/configuration and run the relevant command when feasible. |
| High-risk workflow rule | Exercise or review the relevant evaluation scenario. |

Record commands and true outcomes. A failed required check produces `partial` or `blocked`
unless the repair scope includes and resolves the failure.

## Step 4: Synchronize

After verification, inspect every applicable owner:

```text
manifest capability state
backlog/story status and acceptance
iteration execution/validation result
non-terminal iteration inventory and disposition before new backlog selection
dependency or blocked-plan state
ADR/supersession mapping
lessons or known-trap record
residual follow-up item
```

Update only applicable owners, but never omit one because the main files already look correct.
If an item is intentionally not applicable, state why in the closure report or manifest.

## Step 5: Deliver With A Strict Status

Use this final form for implementation work:

```markdown
Closure status: complete | partial | blocked

Implemented:
- <artifact or capability>

Synchronized:
- <status/record owner updated, or not applicable with reason>

Verified:
- `<command or review>`: <actual result>

Residual:
- <recorded follow-up and path, or none within authorized scope>
```

Choose status using this table:

| Condition | Status |
| --- | --- |
| All applicable closure dimensions satisfied | `complete` |
| Useful artifacts exist but status, validation, residual registration or authorized implementation is incomplete | `partial` |
| Progress cannot validly continue without permission, a missing decision, unavailable source or failed prerequisite | `blocked` |

Never report `complete` with unchecked mandatory acceptance items, a failed required validation,
unmapped preserved assets, or known work that exists only in conversational prose.

## Forward-Test Before Trusting The Protocol

For a newly generated or materially revised governance workflow, test one realistic failure
scenario: give an Agent evidence of missing status/evidence/follow-up work and verify it does not
declare completion after file creation alone. Use the closest case in
`references/evaluation-cases.md`, especially the incomplete-initialization case.

# Guided Onboarding

## Purpose

Guide users who want Agent-assisted development but may not know engineering-process terminology.
The user should understand practical benefits and approve concrete changes without having to
design the governance model.

## Language Rules

- Explain risks in ordinary terms before naming a process artifact.
- Say "place to record planned work" before "backlog", and explain the term if it becomes useful.
- Say "record of important technical choices" before "ADR".
- Say "what must be true before work begins/ends" before "DoR/DoD".
- Avoid presenting internal profile names as choices.
- Distinguish business-code changes from governance-file changes explicitly.

## Discovery Before Questions

Inspect the repository first:

- programming languages and package/build manifests;
- frontend/backend/database/deployment boundaries;
- tests, CI, containers, migrations, authentication and security configuration;
- existing instructions and planning documents;
- Git status if implementation is requested.

Do not ask users what a detectable framework, package manager, or documentation file is.

## Questions to Ask Only When Needed

Ask a small group of plain-language questions when intent cannot be inferred:

1. Will this project keep receiving new features, or is it mostly a one-time or maintenance task?
2. Should AI Agents be allowed to edit code, run checks, commit, or help release it?
3. Will real users or production systems depend on it?
4. Which failures concern you most: unclear changing requests, broken behavior, data loss,
   security/access mistakes, deployment failure, or something else?

Use the answers to recommend a structure; do not ask the user to assemble one.

## Uninitialized Project Message Pattern

Use a message with this shape:

```markdown
I did not find a reliable project entrypoint that tells an AI Agent how to work safely here.
This does not stop the code from running, but it increases the chance of:
- starting changes without understanding existing work;
- mixing future ideas into the current task;
- omitting the checks most important to this project;
- repeating configuration, interface, or deployment mistakes.

Based on the repository, I recommend establishing <plain-language level>.
Reason:
- <observed project characteristic and consequence>

First initialization slice:
- <file>: <what it protects the user from>

This step will not modify:
- business code;
- build/deployment behavior unless specifically approved;
- existing useful documents without an explicit preservation, extraction, archive, or
  supersession action.
```

Request confirmation before writing files unless the user already explicitly requested
initialization implementation after seeing the plan.

## Existing Project Message Pattern

When custom governance assets exist:

```markdown
This project already contains useful working rules, but they are not yet organized under the
standard Agent governance entrypoint.

Assets to preserve:
- <old file>: <valuable responsibility>

Main gaps:
- <missing capability>: <practical risk>

Recommended first migration slice:
- Create the standard entrypoint and manifest.
- Extract active rules, facts, decisions, procedures and lessons into their standard locations,
  recording where each source was mapped without deleting history.
- Defer deeper file migration until the entrypoint is usable.

Long-term destination:
- The project converges on the standard governance structure, with legacy sources either
  incorporated into standard owners, archived as history, or explicitly superseded.
```

## After Initialization

Do not end with file names only. Explain normal requests the user can now make, such as:

- "Record this new feature idea and tell me whether it is ready to implement."
- "Implement this fix and run the right checks."
- "Review the latest iteration for quality gaps."
- "Prepare a release and identify missing verification."

Explain what was intentionally deferred and when it should be added.

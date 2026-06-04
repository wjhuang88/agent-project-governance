# Evolution Feedback SOP

Create `docs/sop/EVOLUTION-FEEDBACK.md` when `evolution_feedback` is applicable. It governs how
Agents update `EVOLUTION.md`.

## Required Workflow

At session close, check whether the work exposed a reusable lesson:

- corrected omission in rules, docs, tests, commands, or generated artifacts;
- repeated failure, surprising failure, or user correction;
- newly discovered project trap;
- workaround that should be reused;
- process drift that caused an Agent to miss an existing rule.

If none apply, do not write a lesson. `EVOLUTION.md` is not a changelog.

## Entry Shape

Use this compact shape:

```markdown
## YYYY-MM-DD - short lesson title

- Trigger:
- Symptom:
- Root cause:
- Fix:
- Prevention:
- Promoted to rule/check:
```

`Promoted to rule/check` must name `AGENTS.md`, a SOP, validator, test, or `none`. If the lesson is
mandatory for future execution, promote it instead of leaving it only in `EVOLUTION.md`.

## Routing Rule

`AGENTS.md` must route diagnosis, session close, failed validation, user correction, and repeated
mistake review to this SOP before writing `EVOLUTION.md`.

When multiple lessons exist, keep a short index at the top of `EVOLUTION.md` so Agents can find
relevant traps before reading the full file.

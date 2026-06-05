# Evidence And Uncertainty Contract

Use this reference when an Agent diagnoses a project, writes governance conclusions, prepares
requirements, reviews completion, or records lessons.

## Rule

Do not present an unverified inference as a confirmed fact. Important governance claims must carry
the right evidence level:

| Level | Meaning | Required handling |
| --- | --- | --- |
| Confirmed | Directly supported by repository content, command output, test evidence, or explicit user input. | State as fact and cite the source path, command, or user-provided statement. |
| Inferred | Reasonable conclusion from available evidence, but not directly proven. | Label as inference and name what would confirm or falsify it. |
| Assumption | Needed to proceed but not verified. | Record validation path or residual owner before relying on it. |
| Unknown | Evidence is missing or contradictory. | Do not decide or claim completion; ask, inspect, or mark blocked/partial. |

## Workflow

Before implementation or closure:

1. Identify claims that affect scope, readiness, risk, architecture, status, or completion.
2. Classify each claim as Confirmed, Inferred, Assumption, or Unknown.
3. Promote high-impact assumptions into validation tasks, ADRs, backlog items, or residual work.
4. Downgrade closure status when required evidence is missing.

## Common Failure

The dangerous failure is not ordinary uncertainty; it is a confident claim with no matching
evidence. If a user corrects such a claim, record the lesson through
`docs/sop/EVOLUTION-FEEDBACK.md` and decide whether to promote it into an `AGENTS.md` rule, SOP
check, validator check, or evaluation case.

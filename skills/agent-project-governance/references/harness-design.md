# Project Harness Design

Use this reference whenever creating or repairing governance documents for a user project. The
goal is to turn mechanical governance rules into executable checks instead of leaving them only as
Agent instructions.

## Principle

If a constraint can be checked deterministically, put it in the project-local harness. The Agent
should spend judgment on discovering the right constraints; the script should enforce the parts
that no longer require judgment.

Do not add runtime dependencies unless the user accepts the tradeoff. Prefer plain POSIX shell and
Windows PowerShell, matching the bundled validators.

## What Belongs In The Harness

Good candidates:

- required governance files and directories exist;
- manifest profile, status and capability values are valid;
- conformant capabilities have owner documents and routes from `AGENTS.md`;
- `CLAUDE.md` and `GEMINI.md` redirect to `AGENTS.md` instead of duplicating rules;
- Markdown links resolve locally;
- derived boards declare themselves as derived views and include owner-doc and gate columns;
- active backlog rows include `Required Reads` when item files, ADRs or specs are mandatory;
- completed stories or iterations include validation evidence;
- profile, branch mode, worktree mode and governance depth recommendations are backed by
  repeatable scale signals;
- project-specific Hard constraints produce repeatable checks, such as migration notes, contract
  tests, security review markers, visual evidence, release artifacts, or API compatibility checks.

Poor candidates:

- whether a gate is truly justified by a Hard constraint;
- whether a story is small enough or semantically valuable;
- whether acceptance criteria are meaningful;
- which legacy content should migrate to which owner.

Those remain Agent/human judgments, but their conclusions can create new harness checks.

## Generated Artifact Rule

When initializing or adopting governance, create or update project-local validation scripts when
any mechanical rule is introduced. Default paths:

```text
scripts/validate_project_governance.sh
scripts/validate_project_governance.ps1
```

If the project already has a script or task runner, integrate with it instead of duplicating
entrypoints, but keep the checks easy for an Agent to run locally. Route the command from
`AGENTS.md` and from the relevant SOP, usually `docs/sop/TESTING.md` or `docs/sop/DOC-CHECK.md`.

If a suitable harness cannot be implemented in the current slice, record the missing check as
residual work with an owner and reason. Do not call a governance slice `complete` when mandatory
mechanical checks were only written as prose and neither scripted nor registered as residual work.

## Implementation Pattern

1. Inventory the rules being introduced by the new governance documents.
2. Split each rule into:
   - **mechanical**: can be checked by file existence, exact text, enum values, links, command
     output or simple pattern matching;
   - **judgment**: requires project context or semantic evaluation.
3. Add mechanical checks to the project-local harness.
4. Add fixtures or small sample cases for harness behavior when practical.
5. Run the harness and record the command/result in the closure report.
6. Promote repeated failures from `EVOLUTION.md` into the harness when the prevention is
   deterministic.

The bundled validators are starting points, not a limit. Tailor checks to the project's actual
Hard constraints and keep warnings for rules that are useful but may be temporarily transitional.
Read [project-scale-harness.md](project-scale-harness.md) when scale, branch mode, worktree mode or
governance depth affects the generated rules.

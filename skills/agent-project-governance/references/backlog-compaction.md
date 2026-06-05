# Backlog Compaction

## Purpose

Keep `docs/backlog/PRODUCT-BACKLOG.md` useful as a decision surface while preventing it from
becoming an oversized record dump. This protocol applies to product backlog documents. It does
not govern `EVOLUTION.md`, which follows `docs/sop/EVOLUTION-FEEDBACK.md` because lesson history
preserves process-correction causality.

## Required Shape

Use one fixed entrypoint:

```text
docs/backlog/PRODUCT-BACKLOG.md
```

For continuing product work, structure backlog records like this:

```text
docs/backlog/
├── PRODUCT-BACKLOG.md
├── active/
│   └── REQ-012-short-title.md
└── archive/
    └── 2026-Q2/
        └── REQ-003-old-title.md
```

`PRODUCT-BACKLOG.md` stays the routing and prioritization view. Item files carry the executable
context. Archive files preserve non-active history.

## PRODUCT-BACKLOG.md Contract

Use these sections, in this order:

```markdown
# Product Backlog

## Current Priorities
## Active Items
## Blocked Items
## Archived Index
## Reading Rules
```

Active and blocked tables must include these columns:

```markdown
| ID | Title | Status | Priority | Decision Context | Required Reads |
| --- | --- | --- | --- | --- | --- |
```

Rules:

- `Decision Context` must preserve enough reason to judge scope, priority, dependency and ADR
  impact without opening archive files.
- `Required Reads` must list the item file and every mandatory ADR, spec, decision, dependency or
  archived item needed before implementation or prioritization.
- Do not store full acceptance criteria, long discussion or execution logs in the main backlog.
- Do not remove context from the main backlog unless the remaining table still supports priority,
  scope, dependency and ADR-impact decisions.

## Item File Contract

Each active item file must include:

- problem or outcome;
- goal and non-goals;
- status, priority and parent Epic if applicable;
- dependencies and blockers;
- governing ADRs, specs or decisions;
- acceptance criteria and validation evidence required;
- residual-work destination.

An item is not Ready when a governing ADR, spec or dependency is only implicit. Put that target in
`Required Reads` and in the item file.

## Mechanical Reading Rule

For any backlog-related task:

1. Read `docs/backlog/PRODUCT-BACKLOG.md`.
2. Find the target row.
3. Read every path listed in `Required Reads`.
4. Read archive only when `Required Reads` points to archive, the item says `Supersedes`,
   `Superseded by` or `Depends on`, or the user asks about history or rationale.

Do not rely on "as needed" judgment when a mandatory read can be made explicit in the table.

## Archive Rule

Archive only non-active execution context:

- `Done`;
- `Canceled`;
- `Superseded`;
- `Deferred` for a stated period or condition.

Do not archive `Active`, `Ready`, `In Progress`, or still-relevant `Blocked` work. If a completed
or superseded item still constrains active work, keep a summary and archive path in `Required
Reads` for the active item.

When archiving an item:

1. Move the item file from `docs/backlog/active/` to `docs/backlog/archive/<period>/`.
2. Remove it from `Active Items` or `Blocked Items`.
3. Add it to `Archived Index`.
4. Preserve `Decision Context`.
5. Preserve `Required Reads` when the archived item still affects active work.

Before archiving, answer:

```text
Can PRODUCT-BACKLOG.md still support priority, scope, dependency and ADR-impact decisions
without opening the archive?
```

If not, compact less or add the missing summary/link before archiving.

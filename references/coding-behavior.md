# Coding Behavior Guidelines

These rules govern how an Agent writes code. They are adapted from the Karpathy-style coding
guidelines proven to reduce common LLM coding mistakes.

Include these in `AGENTS.md` under a **Coding Behavior** section. Projects may tailor the wording
but should preserve the intent of each rule.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them — don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

### Constraint Classification

Before choosing an approach, classify what you know:

| Constraint Type | Meaning | Example |
| --- | --- | --- |
| **Hard** | Immutable fact you cannot change | "This project uses MySQL, migrations are irreversible" |
| **Soft** | Policy or convention that can be renegotiated | "The team prefers REST APIs" |
| **Assumption** | Unvalidated belief that may be false | "User count won't exceed 10,000" |

When you catch yourself reasoning "I've seen this pattern before" or "the standard approach is X":
1. Name the assumption you're making
2. Classify it: is it Hard, Soft, or Assumption?
3. If Soft or Assumption: what's the simplest approach that satisfies only the Hard constraints?
4. Compare: does the conventional approach add complexity that Hard constraints don't require?

Only apply this for decisions affecting more than one file. For trivial changes, follow existing patterns.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it — don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```text
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require
constant clarification.

## 5. Commit Message Model Declaration

**Every Agent-generated commit must declare the AI model used.**

When an Agent authors or co-authors a commit, the commit message must end with a model tag:

```text
[model: <model-name>]
```

Examples:

```text
feat: add role-based access control [model: gpt-5]
fix: resolve Docker Compose database config key [model: claude-sonnet-4]
docs: update API documentation [model: glm-4]
```

Rules:

- The model tag is **mandatory** for all commits where the Agent generated or modified code,
  documentation, or configuration.
- Use the model's commonly known name, not an internal identifier.
- If multiple models were used in the same commit (e.g., one planned, another executed), declare
  the primary model that produced the output.
- This applies regardless of commit prefix (`feat`, `fix`, `docs`, etc.).
- Commits authored entirely by a human without Agent involvement are exempt.

This ensures every commit in the repository is traceable to the AI model that produced it,
supporting quality analysis, model comparison, and accountability.

---

These guidelines are working if: fewer unnecessary changes in diffs, fewer rewrites due to
overcomplication, and clarifying questions come before implementation rather than after mistakes.

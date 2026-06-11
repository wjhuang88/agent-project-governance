# Git Branch And Worktree Modes

Use this reference when a project needs branch rules, release/hotfix handling, or parallel Agent
work isolation. Do not introduce full GitFlow by default.

## Principle

Branch and worktree rules exist to protect release safety and work isolation. Start simple, add
release or worktree structure only when mechanical project signals or user intent justify it.

## Modes

| Mode | Use when | Branch policy | Worktree policy |
| --- | --- | --- | --- |
| `simple` | Small project, no release maintenance, no parallel work. | `main` plus short-lived task branches if needed. | None by default. |
| `release-managed` | Release workflow, semver tags, release notes, release stabilization or hotfixes exist. | `main`, `release/*`, `hotfix/*`, optional `feature/*`. | Use on demand for release or hotfix work. |
| `parallel-agent` | Multiple Agents or active work lines can overlap, or high-risk release/hotfix work must not touch dirty feature work. | Each work item has one owning branch and merge target. | Dedicated worktree per active branch/work item. |

Avoid `develop` unless the project has a real next-version integration line that must coexist
with a stable release line. Do not add `develop` only because GitFlow examples include it.

## AGENTS.md Minimum Rules

Expose the rules an Agent must see before touching Git:

```text
- Before editing, run `git status --short --branch` and identify the branch/worktree.
- Do not start unrelated work in a dirty worktree.
- Use the branch mode in `docs/sop/GIT-WORKFLOW.md`.
- Release or hotfix work uses a dedicated branch and, when configured, a dedicated worktree.
- Before staging, confirm `git rev-parse --show-toplevel` and the current branch.
- Before committing, inspect `git diff --cached --stat`.
```

Keep the full commit format and model tag rule in `AGENTS.md`, not only in the Git SOP.

## GIT-WORKFLOW.md Content

The Git SOP should define:

- current branch mode: `simple`, `release-managed` or `parallel-agent`;
- allowed branch prefixes and merge targets;
- whether `develop` is disabled or explicitly enabled with a reason;
- when to use a dedicated worktree;
- where branch/worktree ownership is recorded, such as iteration or story owner docs;
- release and hotfix gates when applicable.

Suggested branch table:

| Branch | Purpose | Direct Agent commits | Merge target |
| --- | --- | --- | --- |
| `main` | Stable or releasable baseline. | No, except explicitly approved release/hotfix maintenance. | n/a |
| `feature/*` | One story or small change. | Yes. | `main` or `develop` when enabled. |
| `release/*` | Release stabilization only. | Yes, release fixes only. | `main`. |
| `hotfix/*` | Urgent production repair. | Yes, narrowly scoped. | `main` and active release/develop if used. |
| `develop` | Optional next-version integration line. | Usually no direct Agent commits. | `release/*` or `main`. |

## Worktree Rules

Use a separate worktree when:

- working on a hotfix while feature work is dirty;
- validating a release branch;
- running two Agent tasks in parallel;
- a change creates long-running generated files, migrations or build artifacts;
- the user asks to preserve the current worktree state.

Default layout:

```text
../<repo-name>-worktrees/
  feature-<id>/
  release-<version>/
  hotfix-<id>/
```

Before using a worktree:

1. Run `git worktree list`.
2. Confirm no existing worktree owns the target branch.
3. Create or select the branch/worktree.
4. Record `Branch`, `Worktree`, and `Merge Target` in the owner doc.

## Harness Checks

Mechanical checks can enforce:

- current branch matches the allowed mode;
- `release/*` has release notes or a release owner doc;
- `hotfix/*` has a linked incident, issue, or owner doc;
- iteration/story owner docs declare branch, worktree and merge target when required;
- no release/hotfix task runs in a dirty unrelated worktree;
- `develop` is absent unless explicitly enabled in the Git SOP;
- release tag preparation has matching release notes.

Read [project-scale-harness.md](project-scale-harness.md) before introducing or changing modes so
branch rules are derived from observed project signals.

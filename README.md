# Agent Project Governance

Engineering governance and automated constraints for AI Agents. This
project is not just a documentation template — it is a
**meta-methodology**: governance rules are derived from first principles
based on each project's actual constraints, not copied from generic
playbooks.

The shipped artifact is an [Agent Skills](https://agentskills.io)-compatible
skill named **`agent-project-governance`**, packaged under
[`skills/agent-project-governance/`](skills/agent-project-governance/).
Releases are produced by the workflow in
[`.github/workflows/release.yml`](.github/workflows/release.yml): a
push of a tag matching `v*` builds a zip of the skill directory and
attaches it to a GitHub Release.

[中文说明 / Chinese version →](README.zh-CN.md)

---

## The Problem

When AI agents participate in collaborative development, the same
governance breakdowns keep showing up:

- **Scope creep** — the agent modifies code outside the requested
  change because no constraint boundary was defined.
- **Rule rot** — project docs drift from the real engineering commands
  (test, build, deploy), so the agent executes the wrong steps.
- **Defect regression** — past incident lessons never become
  executable constraints, so the same mistakes repeat.
- **Plan drift** — without iteration-baseline protection, execution
  drifts from the original plan and the actual goal becomes unclear.
- **Coarse granularity** — large requirements handed to the agent
  without decomposition produce uncontrolled quality.

The root cause is the absence of an Agent-facing, executable rule
system. `agent-project-governance` solves this by establishing a
discoverable, executable, and verifiable rule framework.

## Core Features

### Automated Governance Rule Execution

AI agents execute the configured checks unconditionally, eliminating the
omissions and shortcuts that occur when humans try to follow rules.

| Governance dimension | Solution |
| --- | --- |
| **Iteration baseline integrity** | The committed plan is treated as a protected baseline; execution results are appended, not replaced. |
| **Verifiable DoD** | Agents must record actual command output and verification evidence, not just status checkboxes. |
| **Lightweight change control** | Requirement changes trigger a change log automatically, integrating control with development. |
| **BDD acceptance criteria** | Given/When/Then acceptance is filled in automatically; delivery standards stay uniform. |
| **Continuous improvement (Kaizen)** | Incident analyses are captured in the lessons log and trigger a rule-update check. |
| **WIP limit** | Before starting a new iteration, active / review / planned / blocked cycles are inventoried first. |
| **Requirement decomposition** | Complex requirements are split into Epics and independently verifiable Stories. |

### Dynamic Diagnosis and On-Demand Configuration

During initialization the skill audits the project in full — technology
stack, build tools, test scripts, sensitive boundaries (auth,
permissions, databases), and documentation synchronization state — and
generates rules that fit the project as it actually is.

### Five-Level Governance State

Project governance maturity is quantified by a state model:

| State | Definition | Recommended next action |
| --- | --- | --- |
| `uninitialized` | No Agent-facing governance rules exist | Establish minimal control entrypoints |
| `discovered` | Scattered docs exist, need standardization | Extract and map existing assets |
| `adopting` | Framework in place, migration in progress | Complete remaining asset migration |
| `conformant` | Rules complete and validated | Maintain execution discipline |
| `degraded` | Docs stale or commands broken | Repair baseline and resync state |

### Risk-Driven Governance Depth

The recommended governance level is derived from project
characteristics, not project type:

| Project type | Core governance requirements |
| --- | --- |
| Small library / component | Entry rules, manifest, lessons, test and Git flow |
| Continuously delivered product | Above + docs index, backlog, iteration flow, change control |
| High-risk system (production, data, permissions) | Above + ADRs, release review, risk-specific gates |

### Verifiable Delivery Standard

Following the Definition of Done (DoD) principle, every governance
action produces real, enforceable outcomes. After each execution, the
agent must state one of:

- **`complete`** — planned items finished, validation passed, residual
  items registered.
- **`partial`** — partial output is in effect, work remains.
- **`blocked`** — execution is blocked by missing decisions or
  permissions.

### Risk Gate Derivation

Defensive checks are generated from project-specific technical features:

| Project feature | Potential risk | Governance measure |
| --- | --- | --- |
| Agent holds code-commit authority | Unintended changes | Mandatory staged-diff review before commit |
| Frontend/backend API collaboration | Contract breakage | Automated contract sync check |
| Auth and permission modules present | Access-control bypass | Maintain permission matrix and run route validation |
| Containerized deployment | Environment consistency risk | Validate build artifacts and release configuration |
| External service integration | Cascading failures | Strengthen timeout handling and mock test environment |

### Built-in Validator

Cross-platform scripts validate governance artifacts continuously. No
Python or third-party dependencies required.

```bash
# macOS / Linux / Unix-like shell
sh <skill-path>/scripts/validate_project_governance.sh <project-root>

# Windows PowerShell
pwsh -File <skill-path>/scripts/validate_project_governance.ps1 <project-root>
```

Checks include: manifest file integrity, `AGENTS.md` structure
compliance, internal link validity, source-code reference accuracy, and
whether completion status is backed by verification evidence.

## Quick Start

This section has two entry points — pick the one that matches you.

### For AI agents and LLMs

See [INSTALL.md](INSTALL.md) for the full install and update
guide. It includes a guided dialog that walks the user through
choosing their agent (OpenCode, Claude Code, Cursor, Codex,
Copilot, Amp, …) and the install scope (project vs. global)
before running any command. Use the same guide for fresh
installs, in-place updates, verification, and troubleshooting.

### For humans

The skill is a single directory named `agent-project-governance/`
that you place under your agent's skill directory. Most agents
look under:

- **OpenCode** — `.opencode/skills/` (project) or
  `~/.config/opencode/skills/` (global)
- **Claude Code** — `.claude/skills/` (project) or
  `~/.claude/skills/` (global)
- **Other Agent-Skills-standard tools** (Cursor, Codex, Copilot,
  Amp, …) — `.agents/skills/` (project) or `~/.agents/skills/`
  (global)

Download the latest release zip from the
[Releases page](https://github.com/wjhuang88/agent-project-governance/releases);
its top-level directory is `agent-project-governance/`, so a
single `unzip` into the target places the skill at the right
path. For in-place updates and troubleshooting, see
[INSTALL.md](INSTALL.md#4-update-an-existing-install).

### Use the skill

Trigger the skill with natural language. The agent decides when to load
it from the skill description.

Audit the current state without modifying files:

```text
Use $agent-project-governance to audit the current project's Agent
governance state. Analyse only; do not modify files. Report existing
assets, actual risks, the main gaps, and the recommended minimal next
step.
```

Initialize the governance framework:

```text
Use $agent-project-governance to initialize Agent engineering
governance for the current project. Read the code and existing docs
first; describe the proposed structure, what will be preserved /
extracted / created, and only then start implementation.
```

Migrate existing assets into the standard structure:

```text
Use $agent-project-governance to migrate the existing rules, plans,
technical decisions, and lessons documents into the standard
structure. Do not delete valuable history; record the source-to-target
mapping in the manifest.
```

Other scenarios:

| Scenario | Example prompt |
| --- | --- |
| Governance degradation | `$agent-project-governance check whether current governance docs, source, commands, and manifest are consistent` |
| Incident analysis and feedback | `$agent-project-governance analyse the process problems exposed by the defect and write the lessons back to EVOLUTION.md` |
| Complex requirement decomposition | `$agent-project-governance inspect large backlog items and split them into Epics and executable Stories` |
| Iteration preparation | `$agent-project-governance inventory all incomplete iterations first, then select the next Ready Story from the backlog` |

## Release Channels

- **Git tags** matching `v*` (e.g., `v1.0.0`) trigger
  [`.github/workflows/release.yml`](.github/workflows/release.yml), which:
  1. Zips [`skills/agent-project-governance/`](skills/agent-project-governance/)
     into `agent-project-governance-<tag>.zip`.
  2. Attaches the zip to a GitHub Release for that tag, with
     auto-generated release notes.
- The zip's top-level directory is `agent-project-governance/`, so it
  can be extracted directly into an agent's skill directory.
- See the [Releases page](https://github.com/wjhuang88/agent-project-governance/releases)
  for published versions.

## Standard Document Structure

For continuously delivered products, the recommended structure is
(small projects may trim as needed):

```text
project-root/
├── AGENTS.md              # Agent operating spec and core constraints
├── EVOLUTION.md           # Postmortems and lessons learned
├── .agent-governance/
│   └── manifest.yaml      # Governance state and capability list
└── docs/
    ├── README.md          # Documentation navigation manual
    ├── backlog/           # Requirements pool (Epic / Story)
    ├── iterations/        # Iteration plans and execution records
    ├── decisions/         # Architecture Decision Records (ADR)
    ├── roadmap/           # Evolution roadmap
    ├── proposals/         # Improvement proposals
    ├── reference/         # Technical fact sheets
    ├── sop/               # Standard Operating Procedures
    └── archive/           # Historical archive
```

### Responsibility Boundaries

| Governance item | Content scope | Out of scope |
| --- | --- | --- |
| `AGENTS.md` | Core constraints, task router, risk warnings | Verbose history, detailed tutorials |
| `manifest.yaml` | State list, capability map, risk-gate config | Detailed SOP steps |
| `EVOLUTION.md` | Root causes, preventive measures, fix records | Version changelog |
| `docs/sop/` | Standard steps and verification metrics | One-off notes |
| `docs/backlog/` | Pending requirements, tech-debt list | Trivial ideas |
| `docs/iterations/` | Iteration baseline, execution evidence | Detailed requirement spec |
| `docs/decisions/` | Significant trade-offs, alternatives review | Routine code-change notes |

### Required `AGENTS.md` Elements

If an agent may modify code, `AGENTS.md` must include:

- **Hard Constraints** — non-negotiable project no-go areas and
  pre-checks.
- **Coding Behavior** — coding rules: state assumptions first, minimal
  changes, match existing style, define verifiable success criteria,
  clean up only the orphans your own changes leave behind.
- **Git Rules** — commit conventions and staged-area review. Commits
  generated by an agent must end with `[model: <model-name>]` to
  declare the AI model used.
- **Task Router** — directs the agent to the relevant governance docs
  by task type.
- **Session End Checklist** — state synchronization and final
  verification.
- **Current Known Traps** — known high-frequency failure patterns.

## Requirement Decomposition Principles

Borrowing from Scrum's Epic/Story model and XP's small-step delivery:

- Complex requirements must be split into independently verifiable
  Stories; large Epics must never be handed to the agent directly.
- A Story must be independently verifiable; it does not span
  iterations.
- Iterations only accept Stories that are already in the Ready state.
- Cross-stack or multi-dimensional requirements are not forcibly
  split if they can be delivered independently.

### Iteration Delivery Principle

Following the MVP mindset, every iteration must produce a runnable and
testable version:

- **Verifiable deliverable** — the Stories selected for an iteration
  must produce end-to-end executable output. Iterations that complete
  only internal infrastructure with no testable deliverable are
  considered incomplete.
- **Smallest viable increment** — prefer the smallest set of Stories
  that delivers observable user value. Only when explicitly recorded
  as an exception (such as infrastructure migration) may an iteration
  have no testable output.
- **Vertical-slice first** — split features into thin slices that run
  through frontend / backend / tests rather than thick horizontal
  layers that cannot be shown on their own.

### Documentation Synchronization Principle

User-facing documentation is not a post-release cleanup; it is part
of the Definition of Done for every iteration:

- Stories that change observable behaviour must include documentation
  updates in their acceptance criteria.
- The iteration template must list the affected user-facing documents
  (README, usage guide, API docs, changelog, release notes).
- Iteration retrospectives must confirm documentation is up to date.
  Unresolved documentation debt is registered as residual work and
  may not be silently deferred.

## Iteration Baseline Protection

Borrowing from Scrum plan integrity and Lean traceability:

- A locked plan is the execution baseline; actual output may not
  overwrite the original goal.
- Before starting a new iteration, the existing tasks must be
  resolved:
  - **Active** — keep following up or record the reason for
    suspension.
  - **Review** — fill in the missing acceptance evidence.
  - **Planned** — activate or record the reason for deferral.
  - **Blocked** — record the blocker and emit an interim conclusion.

## Asset Migration Strategy

The "respect existing value" principle: do not create parallel
documentation systems.

1. **Inventory the current state** — identify the governance attribute
   of each existing document.
2. **Validate** — drop stale rules.
3. **Map responsibilities** — extract effective content into the
   standard structure.
4. **Preserve history** — archive old documents; never silently
   delete.
5. **Record linkage** — record the migration mapping in the manifest.

## Scope of Application

- Focuses on engineering governance rules; does not intervene in
  product decisions.
- Tailors rules to project characteristics; does not blindly apply
  generic processes.
- Emphasizes consistency between rules and the actual engineering
  state; rejects formalistic documentation.
- Emphasizes verifiable evidence; rejects verbal completion
  confirmation.
- Mandates requirement decomposition and baseline protection.

## FAQ

### What scenarios is this skill for?
For projects that collaborate deeply with AI agents (Cursor, Claude
Code, OpenCode, etc.) and pursue engineering quality. For one-off
fragmented edits, a full governance system is unnecessary.

### Does the governance process modify business logic?
No. Governance actions are limited to governance files (`AGENTS.md`,
`docs/`, etc.). Product business code is not modified unless
explicitly requested.

### If `AGENTS.md` already exists, do I still need this skill?
Recommended. The skill can audit whether the existing document covers
the current project's risk boundaries, whether the commands are
valid, and whether the SOPs are in sync.

### Is the full directory structure mandatory?
No. The skill recommends a minimal structure based on project size
and risk level; only high-risk or complex products need full
deployment.

### What is the manifest for?
The manifest makes governance state measurable and auditable. It
records rule validity, capability coverage, and asset migration
paths.

### Why can't an existing iteration plan be overwritten?
To keep the development process traceable. Recording the deviation
between plan and actual is critical data for continuous improvement.

## Theoretical Basis

The skill is a **meta-methodology**: it re-constructs classical
theories in an Agent-facing way, grounded in first principles.

| Theory | Core borrowed idea | Application scenario |
| --- | --- | --- |
| **First principles** | Derive rules from Hard/Soft constraints, not analogy | Governance derivation, risk control, ADR triggers |
| **Scrum** | Plan baseline, iteration inventory, requirement layering, DoD | Baseline protection, requirement decomposition |
| **XP** | Small steps, continuous validation, shared rules, MVP runnable delivery | Tiered governance, validation generation, iteration delivery standard |
| **BDD** | Executable specification | Automated acceptance criteria |
| **Lean** | Value-stream protection, waste elimination, Kaizen, docs as deliverable | Asset migration, lessons feedback loop, in-iteration doc sync |
| **Change control** | Impact assessment and registration | CHANGE-CONTROL SOP |
| **ADR** | Record decision context and superseding conditions | Decision asset management |
| **WIP limit** | Limit concurrent tasks | Iteration pre-inventory |

First principles are at the core: Scrum / XP / Lean define *what* to
do, while first principles ensure that rules are fully adapted to
the constraints of the **current project**. Every governance gate
must be traceable to a project-level Hard constraint.

## License

MIT

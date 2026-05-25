# Initialization And Adoption

## Contents

- Governance states
- Detection algorithm
- Manifest contract
- Initializing a new project
- Adopting an existing project
- Repairing degraded governance

## Governance States

| State | Definition | Terminal? |
| --- | --- | --- |
| `uninitialized` | No standard manifest and no reliable Agent execution entrypoint. | No |
| `discovered` | Existing custom governance assets have been identified but not mapped. | No |
| `adopting` | Standard manifest exists; one or more applicable capabilities remain legacy or missing. | No |
| `conformant` | Applicable capabilities use standard entrypoints and pass an audit. | Yes, subject to re-audit |
| `degraded` | A previously adopted project has missing, contradictory, or obsolete governance assets. | No |

A custom structure may be respected during migration, but it is not a completed end state. The
destination is a conformant standard structure, with justified `not_applicable` capabilities for
smaller projects.

## Detection Algorithm

1. Identify the likely repository root.
2. Search for `.agent-governance/manifest.yaml`.
3. If a manifest exists:
   - read its profile, state, entrypoints, and capabilities;
   - verify declared paths exist;
   - compare declared commands and risks with current code/configuration;
   - classify as `conformant`, `adopting`, or `degraded`.
4. If no manifest exists:
   - search for governance assets such as `AGENTS.md`, `CONTRIBUTING*`, architecture docs,
     ADR directories, issue/backlog documents, release/testing instructions, and lessons learned;
   - classify as `discovered` if useful assets exist, otherwise `uninitialized`.
5. Present findings and a minimal implementation slice before writing.

## Manifest Contract

The project-level output `.agent-governance/manifest.yaml` records adoption state, not policy
text. Begin with `assets/manifest.yaml.template` and tailor it.

Required logical content:

- schema version and managing skill;
- profile and governance state;
- standard entrypoint paths;
- capability states;
- project-derived risk gates;
- legacy mappings and next migration actions when not yet conformant.

Capability status values:

| Value | Meaning |
| --- | --- |
| `conformant` | Standard entrypoint exists and accurately governs current work. |
| `legacy` | Valid capability remains in a non-standard source during adoption. |
| `missing` | Applicable capability has not yet been established. |
| `not_applicable` | Explicitly unnecessary for the current project profile. |
| `degraded` | Declared capability exists but is obsolete, broken, or contradictory. |

Never mark a capability conformant just because a file with a matching name exists.

## Initializing A New Project

Establish the smallest usable control surface first:

1. Create `AGENTS.md` as the Agent-facing entrypoint and task router.
2. Create `.agent-governance/manifest.yaml` with initial capability status.
3. Create `EVOLUTION.md` for recurring lessons and process improvements.
4. Add minimum testing and Git instructions when Agents may modify code.
5. Mark later planning or risk workflows as `missing` or `not_applicable`; do not fabricate
   mature process content prematurely.

For projects with continuing features, proceed after user agreement to requirements, iteration,
and change-control capabilities.

## Adopting An Existing Project

Protect useful assets while converging:

| Existing asset condition | Action |
| --- | --- |
| Accurate, already single-purpose, and compatible | Link or move into standard responsibility with a recorded mapping. |
| Accurate but mixes several responsibilities | Extract relevant material into standard files; retain a pointer or supersession note. |
| Historical record | Preserve in place or archive; do not rewrite history to match new process. |
| Contradictory or obsolete rule | Flag the conflict, get agreement, then explicitly supersede it. |
| Automated hook/template still useful | Preserve it and reference it from the owning SOP. |

Recommended adoption sequence:

1. Create the standard entrypoint, manifest, and evolution record.
2. Register legacy assets and immediate conflicts.
3. Migrate daily execution rules: testing, Git, requirement intake, iteration, and change
   control.
4. Migrate planning, decisions, stable reference facts, and proposals.
5. Add project-specific risk gates and change state to `conformant` only after an audit.

## Repairing Degraded Governance

Treat drift as a process defect:

- identify the discrepancy and its user impact;
- determine whether code, configuration, target architecture, or documentation is authoritative;
- repair the smallest set of governance files needed to remove misleading instructions;
- update manifest capability state;
- add a lesson when the drift exposes a recurring failure mode.

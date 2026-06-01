# Initialization And Adoption

## Contents

- Governance states
- Detection algorithm
- Manifest contract
- Initializing a new project
- Adopting an existing project
- Extracting non-standard documents
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
   - search for non-standard or mixed-responsibility documents such as root-level planning files,
     migration reports, implementation summaries, custom `notes/` directories, or docs whose
     content spans procedures, decisions and historical records;
   - classify as `discovered` if useful assets exist, otherwise `uninitialized`.
5. **Classify project constraints** before recommending governance depth:

| Constraint type | Meaning | Example | Governance implication |
| --- | --- | --- | --- |
| **Hard** | Immutable fact; cannot change | "Uses MySQL; migrations are irreversible" | Derive mandatory gates from these |
| **Soft** | Policy or convention; can change | "Team prefers REST APIs" | Record in decisions when a choice is made |
| **Assumption** | Unvalidated belief; may be false | "User count won't exceed 10K" | Flag for validation; create Spike if blocking |

6. Present findings, the constraint classification, and a minimal implementation slice before
   writing. Explain which gates derive from Hard constraints and which Soft constraints are
   respected but not mandatory.

## Manifest Contract

The project-level output `.agent-governance/manifest.yaml` records adoption state, not policy
text. Begin with `assets/manifest.template.yaml` and tailor it.

Required logical content:

- schema version and managing skill;
- profile and governance state;
- standard entrypoint paths;
- capability states;
- project-derived risk gates;
- legacy mappings, extraction destinations/status, and next migration actions when not yet
  conformant.

Capability status values:

| Value | Meaning |
| --- | --- |
| `conformant` | Standard entrypoint exists and accurately governs current work. |
| `legacy` | Valid capability remains in a non-standard source during adoption. |
| `missing` | Applicable capability has not yet been established. |
| `not_applicable` | Explicitly unnecessary for the current project profile. |
| `degraded` | Declared capability exists but is obsolete, broken, or contradictory. |

Never mark a capability conformant just because a file with a matching name exists.

The manifest records auditable governance state and must be version-controlled (committed),
not git-ignored. If a project excludes `.agent-governance/manifest.yaml` from version control,
governance state becomes a local-only artifact: collaborators and CI cannot see the declared
profile, capability states, or risk gates, and the environment-appropriate validator
(`scripts/validate_project_governance.sh` or `scripts/validate_project_governance.ps1`) cannot run
in continuous integration. During audit, treat a git-ignored or untracked manifest as a
governance-visibility gap and recommend committing it.

## Profile And Capability Invariants

Use these invariants before writing the manifest and again after every governance edit:

| Condition | Required interpretation |
| --- | --- |
| A capability is `conformant` | Its standard owning file(s) exist, are routed when recurring work needs them, and accurately describe the current project. |
| Profile is `product` or `high-risk` | `task_router`, `evolution_feedback`, `testing_policy`, `git_workflow`, `requirement_intake`, `iteration_workflow` and `change_control` cannot be `not_applicable`. |
| Iteration records already exist | `iteration_workflow` cannot be `not_applicable`; `START-ITERATION.md` and `ITERATION-WORKFLOW.md` must exist or the capability is `missing`/`degraded`. |
| `change_control` is `conformant` | `docs/sop/CHANGE-CONTROL.md` exists and is reachable from the task router. |
| Profile is `product` or `high-risk` | `docs/README.md` exists as a documentation map, unless the manifest explicitly records it as an unfinished migration action. |
| A recurring workflow is `conformant` | Its owning SOP or reference entry is reachable from `AGENTS.md` task routing, not only present on disk. |
| A declared rule names code paths, commands or dependencies | They are checked against the current repository; obsolete stable facts make the owning capability `degraded`. |

An adopting repository may intentionally leave applicable capabilities `missing` while completing
a small slice. It may not mark an absent, stale or contradictory capability as `conformant`.

## Initializing A New Project

Establish the smallest usable control surface first:

1. Create `AGENTS.md` as the Agent-facing entrypoint and task router.
2. Create `.agent-governance/manifest.yaml` with initial capability status.
3. Create `EVOLUTION.md` for recurring lessons and process improvements.
4. Add minimum testing and Git instructions when Agents may modify code.
5. If existing non-standard documents were discovered, extract their active content into the
   standard owners described below and record source-to-target mappings in the manifest.
6. Mark later planning or risk workflows as `missing` or `not_applicable`; do not fabricate
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
2. Inventory each legacy or non-standard source and classify its useful content by
   responsibility.
3. Extract active content into standard owners; preserve, link, archive, or explicitly
   supersede the original sources.
4. Register source-to-target mappings and immediate conflicts in the manifest.
5. Migrate daily execution rules: testing, Git, requirement intake, iteration, and change
   control.
6. Migrate planning, decisions, stable reference facts, and proposals.
7. Add project-specific risk gates and change state to `conformant` only after an audit.

## Extracting Non-Standard Documents

Initialization and adoption must not leave active knowledge stranded in arbitrary document
locations. A document is non-standard when its authoritative content belongs to a standard
governance responsibility but is stored elsewhere, or when it mixes several responsibilities
that Agents need to query independently.

### Extraction Mapping

| Content found in an existing document | Standard owner | Source handling |
| --- | --- | --- |
| Mandatory Agent rules and task routing | `AGENTS.md` | Extract active rules; retain a link or supersession note. |
| Reusable failures, corrections and checks | `EVOLUTION.md` | Extract lessons; preserve original history or archive it. |
| Stable architecture, commands, boundaries and contracts | `docs/reference/` | Extract current facts; do not copy obsolete facts as current. |
| Repeatable operating procedure | `docs/sop/` | Extract actionable sequence and checks. |
| Implementable requirement or defect | `docs/backlog/` | Create or update a tracked work item with acceptance evidence. |
| Active bounded execution record | `docs/iterations/` | Preserve status and validation results in an iteration record. |
| Important selected tradeoff | `docs/decisions/` | Extract as an ADR or map to an existing decision record. |
| Sequenced future direction | `docs/roadmap/` | Extract only committed direction, not speculative ideas. |
| Immature idea or candidate direction | `docs/proposals/` | Extract without making it executable work. |
| Historical plan or obsolete snapshot | `docs/archive/` | Preserve as history; link from current owners only if useful. |

### Required Procedure

1. Build an inventory with each source path, content categories, whether it is still valid, and
   proposed standard owner.
2. Identify contradictions between a source document and current code, configuration or newer
   documentation; do not migrate contradicted text as active policy.
3. Extract still-valid active content into one or more standard owners. Do not merely create an
   empty standard file while leaving the rule only in the legacy source.
4. Preserve historical context. Move to `docs/archive/`, leave a source pointer, or explicitly
   mark supersession according to user agreement and repository conventions.
5. Record each source in `migration.legacy_assets` with an action, `extracted_to` destination
   paths, and current status.
6. Audit that Agents can reach all active extracted rules through `AGENTS.md` routing or the
   standard document map without reading arbitrary legacy files first.
7. Run the environment-appropriate validator from this skill against the target repository before
   claiming that the produced or repaired governance baseline is valid.

### Completion Rule

A repository with useful active governance content only in non-standard sources is `adopting`,
not `conformant`. If an initialized repository claims conformance while extraction mappings or
active content are missing, classify the affected capability as `degraded`.

## Repairing Degraded Governance

Treat drift as a process defect:

- identify the discrepancy and its user impact;
- determine whether code, configuration, target architecture, or documentation is authoritative;
- repair the smallest set of governance files needed to remove misleading instructions;
- update manifest capability state;
- add a lesson when the drift exposes a recurring failure mode.

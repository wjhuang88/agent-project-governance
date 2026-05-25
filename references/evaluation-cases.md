# Evaluation Cases

## Purpose

Forward-test whether this skill derives useful governance from evidence rather than copying a
source project's SOPs. Present a case to an Agent with the skill available and check the expected
reasoning and recommendations.

## Case 1: New Small Library With A Beginner User

Input:

- A single-language library with tests and Git, no deployment or database.
- User asks: "I want AI to help maintain this; set up whatever rules are needed."

Expected behavior:

- Classify as `uninitialized`.
- Explain risks without unexplained process terminology.
- Recommend basic collaboration rules, not a full product lifecycle.
- Propose `AGENTS.md`, manifest, evolution feedback, testing and Git instructions.
- Mark release/backlog/ADR capabilities `not_applicable` or defer them with reasons.

Failure signals:

- Creating a complex roadmap and release framework without evidence.
- Asking the user to choose among unexplained profile names.

## Case 2: Existing Product With Custom Docs

Input:

- A frontend/backend application with `CONTRIBUTING.md`, `docs/architecture/`, and deployment
  notes, but no standard manifest or Agent router.
- User wants Agent-assisted continued development.

Expected behavior:

- Classify as `discovered`.
- Preserve and map existing assets.
- Propose a first adoption slice centered on entrypoint, manifest and lessons feedback.
- State that the long-term target is the standard structure, not permanent parallel governance.

Failure signals:

- Deleting existing documents.
- Declaring the custom layout complete without a migration path.

## Case 3: Toolchain Drift

Input:

- The project moved from one frontend package manager/build runtime to another.
- Current scripts use the new runtime, but Docker and process docs still use the old one.

Expected behavior:

- Identify drift as an execution reliability risk.
- Recommend one canonical tool and lockfile, plus checks over scripts, build images and
  instructions.
- If already initialized, classify relevant capability as `degraded` until repaired.

## Case 4: Public User Link Flow

Input:

- An application sends invitation or password reset emails.
- The email link uses an internal backend origin, and the accepting endpoint is unauthenticated
  but not reflected in middleware/testing guidance.

Expected behavior:

- Derive a linked gate covering public URL configuration, visible frontend route, API contract,
  authorization/CSRF exception behavior and tests.
- Recommend recording the lesson if the defect was already observed.

## Case 5: Transitional Deployment Mistaken For Target Architecture

Input:

- Static files are temporarily served through a reverse proxy while the roadmap says they will
  ultimately be embedded in a backend artifact.
- Documentation labels the proxy stack as final and plans CI around it prematurely.

Expected behavior:

- Separate current transition from final architecture.
- Recommend documenting both and deferring workflows that depend on unsettled final commands
  when appropriate.
- Add deployment-path checks only while the transition remains applicable.

## Case 6: Status Drift After Completed Work

Input:

- A summary table marks a story Done.
- Detailed acceptance criteria remain unchecked and the contract still labels implemented
  endpoints as unavailable.

Expected behavior:

- Treat this as governance degradation, not cosmetic editing.
- Recommend synchronizing detail/status/reference facts and adding a completion gate.

## Acceptance For This Skill

The skill is effective when it:

- classifies initialization/adoption state correctly;
- communicates in usable language to a non-expert;
- preserves existing valid assets while specifying a convergent target;
- derives only applicable risk gates;
- turns observed failures into durable process improvements.

# Story Format And BDD

## Purpose

Use this reference when designing requirement-intake, backlog refinement, iteration planning or
document audits for a project that uses AI Agents. The goal is not to copy Scrum or BDD rituals;
it is to make every executable work item understandable, small, and verifiable.

## Explain The Adaptation

Tell the user in plain language:

- A traditional Sprint is a team timebox; an Agent iteration is an auditable work batch.
- A user story is useful when a user, caller or role observes behavior, but not every engineering
  or governance task should pretend to be one.
- BDD is mandatory for behavior-facing acceptance, not for every document or refactor.
- Non-behavior work still needs equivalent evidence: commands, structural checks, state owners
  and residual-work tracking.

## Choose A Story Shape

Discover the project's existing terminology and preserve it when possible, but require every
ready story to fit one of these shapes:

| Shape | Use when | Title pattern | Required content |
| --- | --- | --- | --- |
| Product / User Story | A person observes product behavior, UI, notification or workflow. | `<role> can <capability>` | role, goal, value, scope, exclusions, BDD acceptance |
| API / Permission / State Story | A caller observes an endpoint, authorization rule, state transition or error mapping. | `<actor> triggers <action> and receives <result>` | actor, precondition, action, observable result, BDD acceptance |
| Technical Story | The outcome is build, migration, refactor, reliability, performance or engineering readiness. | `<technical object> reaches <verifiable state>` | technical objective, affected surfaces, exclusions, command/manual validation |
| Governance / Docs Story | The outcome changes process, plans, SOPs, ADRs, reference facts or completion gates. | `<process object> prevents/supports <governance outcome>` | failure mode, owning artifacts, consistency checks, closure owner |
| Spike | The work reduces uncertainty rather than delivering behavior. | `Spike: validate/compare <question>` | question, timebox, options, expected decision/evidence output |

Do not force Technical, Governance or Spike items into fake `As a user` phrasing. If there is no
real user behavior, require a clear engineering or process goal instead.

## Require Standard Story Information

For every ready story, require these information points even if the project names the fields
differently:

- **identity**: user, caller, maintainer, operator, Agent or other role receiving the result;
- **goal**: the capability, behavior or state to achieve;
- **value**: why the work matters now or what failure it prevents;
- **scope**: what this slice changes;
- **exclusions**: what this slice deliberately leaves out;
- **acceptance**: BDD scenarios or equivalent technical checks;
- **dependencies**: specific story IDs, decisions or external blockers;
- **minimum validation**: command, test, manual check or document consistency check;
- **state owners**: backlog, iteration, contract, ADR, reference, release notes or lessons to
  synchronize on completion.
- **uncertainty**: assumptions or unknowns that affect implementation, plus the validation or
  residual path for each.

## ADR-Linked Requirement Rule

When a story depends on, implements, changes, or is constrained by an ADR/decision record, the
story must explicitly link that decision before it can be Ready.

Require these fields or local equivalents:

- **decision links**: concrete paths such as `docs/decisions/ADR-0003-cache.md`;
- **decision constraint**: the part of the ADR that limits implementation choices;
- **acceptance impact**: the scenario, checklist item, or validation command proving the story
  followed that constraint.

Do not rely on an issue title, roadmap note, or Agent memory to carry ADR context. If a relevant
ADR exists but the story does not name it, keep the story in refinement. If implementation would
violate or supersede the ADR, route through change control and update or supersede the decision
before coding.

## Product Or API Story Template

Use this for behavior-facing work:

```markdown
As a <role>,
I want <capability or action>,
so that <business value or avoided problem>.

Scope:
- ...

Out of scope:
- ...

Acceptance:
- Given <precondition>
  When <actor action>
  Then <observable result>
  And <required state change, side effect or audit evidence>
```

The `Then` line must describe something observable by a user, caller, log, response, database
state or documented artifact. It should not say "the handler is updated" or "the code is
refactored".

## Technical Or Governance Story Template

Use this when behavior-facing BDD would be artificial:

```markdown
To <reduce a risk or achieve an engineering/process goal>,
the maintainer/Agent needs <verifiable result>,
so that <future work, operation or governance remains reliable>.

Scope:
- ...

Out of scope:
- ...

Acceptance:
- [ ] <command or manual check> proves <result>
- [ ] <owning document/status> is synchronized
- [ ] <residual or exception> is recorded in <destination>
```

Technical acceptance is acceptable only when it proves a result, not when it merely lists files
to edit.

## Spike Template

Use this when the correct implementation is not known:

```markdown
Spike: validate <question>

Timebox:
Options:
Evidence to gather:
Output:
- [ ] recommended option, rejected options and reasons, or follow-up stories
- [ ] validation evidence and known limits
```

Do not mark a Spike done because code exists. It is done when it answers the question and records
what to do next.

## BDD Applicability

Require Given/When/Then for:

- user-visible pages, flows, emails, notifications, public links or onboarding;
- API behavior, error mapping, idempotency, authentication or authorization;
- permissions, role boundaries, audit trails and externally triggered side effects;
- state machines, approvals, lifecycle transitions and workflows;
- defects caused by ambiguous behavior acceptance.

Allow equivalent technical acceptance for:

- internal refactors whose external behavior is intentionally unchanged;
- build, deployment, migration, documentation or process work;
- exploratory spikes;
- purely structural cleanup, as long as validation and state owners are explicit.

If behavior-facing work lacks BDD acceptance, keep it in refinement. If non-behavior work lacks
command/manual validation and state owners, keep it out of implementation.

## Quality Checks

During requirement intake or document audit, reject stories that:

- describe only an implementation action, such as "modify handler" or "update docs";
- have no user/caller/maintainer identity;
- repeat the title as the value statement;
- omit exclusions, allowing the Agent to expand scope;
- omit a governing ADR/decision link when implementation choices are constrained by one;
- treat an assumption or unresolved external fact as confirmed without a validation path;
- mix several independently valid outcomes into one story;
- use BDD but put implementation details in `Then`;
- call open-ended research a story without a timebox and decision output;
- claim completion when acceptance proves only an isolated unit (a passing unit test on a new
  module) while no user-reachable path in the runnable deliverable invokes that capability; a
  built-but-unwired capability is `partial`, not `complete`.

Good story format should make these questions answerable before implementation starts:

1. Who receives the result?
2. What changes for them or for the engineering system?
3. Why is this slice valuable now?
4. What is explicitly not included?
5. What evidence will prove completion?
6. Which state or reference documents must be synchronized?

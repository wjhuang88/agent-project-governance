# Risk To Gate Patterns

## How To Use

Select only patterns supported by the repository or user intent. For each selected pattern,
record the observed signal, likely failure, required check, and appropriate governance owner.

| Observed characteristic | Recurring failure to prevent | Derived gate | Typical owner |
| --- | --- | --- | --- |
| Agent edits and commits code | Unrelated edits or unauditable generated changes enter commits. | Inspect working tree and staged diff; define commit traceability rules. | Agent guide + Git SOP |
| Multiple package managers or a runtime migration | Agents revert to stale commands or dual lockfiles. | Name one canonical tool/lockfile; scan current docs/scripts/container builds. | Reference + Testing/Release SOP |
| API frontend/backend boundary | A UI calls missing routes or DTO fields diverge. | Contract-first change order; client/DTO/test alignment. | Contract SOP + API reference |
| Public unauthenticated state-changing endpoint | Middleware blocks valid user flow or allows unintended access. | Test route, auth/RBAC exceptions, CSRF policy, and error cases together. | Contract/Testing SOP |
| Email or external clickable links | Users receive internal/unreachable or unhandled URLs. | Validate configured public base URL, frontend public route, API handler, expiry/errors. | Config reference + Testing/Release SOP |
| Authentication, permissions, or tenancy | Authorization bypass or incorrect tenant access. | Define protected/public route matrix and role tests. | Security/Contract/Testing SOP |
| Caller-triggered outbound requests or tool execution | Public discovery becomes anonymous execution; host proxy discovery breaks startup; upstream errors look like success; unbounded responses exhaust resources. | Separate discovery from execution auth; require explicit network/client initialization, timeout/response/error behavior, and local mock tests for success and failure. | Security/Contract/Testing SOP + Agent guide |
| Multiple supported databases | Only one migration/repository behaves correctly. | Update and test each supported persistence path. | Database migration SOP |
| Docker, proxy, CDN, or static frontend delivery | Local builds pass but deployed assets/API paths break. | Verify reverse-proxy paths/content types/health and distinguish transitional deployment from target architecture. | Release SOP + Roadmap/ADR |
| Production build outputs | Debug artifacts or secrets ship publicly. | Check sourcemaps, secrets, environment injection, and build artifacts. | Release/Security SOP |
| Sandbox or optional infrastructure fallback | Feature appears successful while safety mechanism is disabled. | Verify initialization/fallback logging and execution mode. | Operations/Testing SOP |
| Major architecture or product naming pivot | Current tasks expand obsolete direction. | Pause scope, write decision, retarget backlog and handle partial work. | Change-control SOP + ADR |
| Documentation tracks execution status | Summary says Done while required commands failed, were not run, or only narrower checks passed. | Create plans before implementation; require command-level evidence for checked acceptance items and a distinct review for high-risk completion. | Iteration/Git/Pairing SOP |

## Selecting Gate Strength

- Use a hard required check for security, data integrity, irreversible release, or repeated real
  defects.
- Use a recommended check for moderate operational or consistency risk.
- Leave a documented observation without a gate when the characteristic is speculative or
  currently irrelevant.

## Avoid Template Leakage

Never infer a project uses a particular database, package manager, proxy, authentication scheme,
or release model because a source project did. Read the target project's code and documentation,
then choose relevant patterns.

# AKTOps threat model

## Assets

- Repository source code and history.
- Branch ruleset configuration.
- GitHub Actions workflow definitions.
- Governance credentials and secrets.
- Dependency manifests and lockfiles.
- Audit evidence and operational documentation.

## Trust boundaries

- Contributor workstation to GitHub.
- Pull request code to privileged GitHub Actions workflows.
- Workflow runner to GitHub REST API.
- Repository-scoped token to repository administration API.
- External dependencies and GitHub Actions to the build environment.

## Threats and mitigations

| Threat | Potential impact | Current mitigation | Residual risk |
|---|---|---|---|
| Force push or default-branch deletion | Loss or rewrite of protected history | Ruleset blocks deletion and non-fast-forward updates | Ruleset may be removed or bypassed by a sufficiently privileged actor |
| Malicious workflow change | Privileged API action or secret exposure | PR governance and restricted token design guidance | Review and token protections remain essential |
| Token compromise | Ruleset tampering | Repository-scoped credential recommendation | Token rotation and monitoring are operational responsibilities |
| Secret committed to Git | Credential exposure | PR checklist and ignore patterns | No secret scanner or push protection is included by default |
| Vulnerable dependency | Compromise through dependency | Dependabot update proposals | Updates are not equivalent to vulnerability blocking |
| Configuration drift | Weakened governance | Reapply/verify manually | No continuous drift detection yet |
| Over-broad integration bypass | Protected branch modification | No bypass actors in baseline | Integration owners must assess exceptions separately |

## Secure operating practices

- Protect default-branch changes with pull requests.
- Review changes to workflows, scripts and policy files carefully.
- Keep privileged credentials out of untrusted pull-request execution.
- Restrict who can modify Actions secrets and repository settings.
- Audit ruleset state after provisioning and after material governance changes.
- Record and periodically review any exceptions.

## Scope

This is a lightweight threat model for the repository template. Each adopting project must add application-specific assets, threats, data classifications and deployment risks.

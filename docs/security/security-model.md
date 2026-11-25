# Security model and limitations

## Current controls

- Default-branch deletion protection.
- Blocking non-fast-forward updates.
- Linear history requirement.
- Pull-request requirement.
- Review-thread resolution requirement.
- Dependabot update proposals for GitHub Actions and npm.
- A pull-request checklist that prompts contributors to consider secrets and validation.

## Important limitations

These controls do not, by themselves, provide:
- Secret scanning or push protection.
- Static application security testing or CodeQL analysis.
- Dependency vulnerability blocking or dependency review enforcement.
- Signed-commit enforcement.
- Required CI status checks.
- Deployment approvals or environment protection.
- Continuous configuration drift detection.
- A guarantee that a contributor has tested code merely because a checklist exists.

The presence of a .gitignore entry for secret-like files is not a security boundary. It does not detect secrets in already tracked files or files with different names.

## Recommended adoption profile

For repositories handling production workloads, assess and enable:
1. Secret scanning and push protection where available.
2. Code scanning with an appropriate query suite.
3. Dependency review and automated vulnerability updates.
4. Required status checks for stable CI workflows.
5. Code-owner review and a non-zero approval requirement.
6. Signed commits where key management is operationally sustainable.
7. Protected deployment environments and least-privilege deployment credentials.

Availability depends on GitHub plan, repository visibility, organisation policy and configuration.

## Token handling

The provisioning identity needs repository Administration: write. Keep this privilege separate from ordinary build and deployment jobs. Use a fine-grained token restricted to the destination repository when a PAT is needed. Never commit credentials, include them in logs or expose them to untrusted pull-request code.

## Responsible claims

Describe only controls that are configured and verified in the target repository as enabled. Treat recommendations and roadmap items as recommendations and roadmap items.

# Contributing to AKTOps

Thank you for helping improve the AKTOps repository engineering baseline.

## Before making a change

- Read the [architecture overview](docs/architecture/overview.md).
- Understand the [governance model](docs/governance/governance-model.md).
- Check whether the proposed capability is implemented, recommended or roadmap-only.

## Change expectations

- Keep policy separate from provisioning implementation.
- Prefer least-privilege permissions.
- Do not introduce default bypass actors without a documented threat assessment.
- Do not add required status checks until their check names are stable and verified.
- Keep scripts explicit about their target repository.
- Make provisioning failures visible and non-zero.
- Update documentation whenever behaviour, permissions or limitations change.

## Validation

For JSON policy changes:

~~~powershell
Get-Content .github/rulesets/branch-ruleset.json -Raw | ConvertFrom-Json | Out-Null
~~~

For workflow changes, inspect the workflow syntax and ensure all required permissions are explicit. Test governance changes against a disposable repository before applying them to important projects.

## Pull requests

Use the repository pull request template. Explain the reason for the change, validation performed, security impact, operational impact and rollback considerations.

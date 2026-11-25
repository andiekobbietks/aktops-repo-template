# Policy as code

## Source of truth

The current desired branch-governance configuration is stored in:

`/.github/rulesets/branch-ruleset.json`

The file is submitted to the GitHub REST API by the PowerShell and Actions provisioning paths.

## Change process

1. Propose a policy change through a pull request.
2. Explain the security or operational reason.
3. Validate the JSON syntax and expected rule types.
4. Review permission and bypass implications.
5. Merge the policy change through the repository's configured governance.
6. Apply the policy to the destination repository.
7. Verify the resulting ruleset in GitHub.

## Idempotency

Provisioning looks for a ruleset with the stable name `AKTOps - SOP-SEC-042`. If exactly one exists, it updates that ruleset. If none exists, it creates one. If duplicates exist, provisioning stops and requires manual resolution.

This is create-or-update behaviour. It is not continuous drift reconciliation: manual changes made after provisioning are not automatically repaired unless the workflow or script is run again.

## Validation boundaries

JSON syntax validation proves only that the document parses. It does not prove that GitHub accepts every rule or that the executing token has permission. The API response and a subsequent verification remain necessary.

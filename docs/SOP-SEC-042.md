# Standard Operating Procedure: SOP-SEC-042

**Title:** GitHub Repository Governance and Default-Branch Ruleset Baseline  
**Owner:** Andrea Kwabena Technologies / AKTOps  
**Status:** Baseline specification  
**Review cadence:** At least annually and after material GitHub platform or policy changes  
**Applies to:** Repositories that explicitly adopt the AKTOps baseline

## 1. Purpose

Define a repeatable baseline for protecting the default branch of an adopting GitHub repository. The procedure uses a declarative ruleset and supported GitHub API provisioning paths.

## 2. Control objectives

The baseline aims to:
- Prevent accidental deletion of the default branch.
- Block non-fast-forward updates, including force pushes.
- Preserve linear commit history.
- Require pull requests before merging.
- Require review conversations to be resolved before merging.

## 3. Implemented policy

The source policy is .github/rulesets/branch-ruleset.json. It targets ~DEFAULT_BRANCH and activates the controls listed above.

The required approving review count is currently zero. This keeps the template usable for individual maintainers, but adopting teams should select an approval threshold appropriate to their risk, separation-of-duties and compliance requirements.

No bypass actors are configured by default. Decap CMS compatibility is not claimed by this baseline. Any GitHub App bypass must be separately identified, justified, narrowly scoped and tested.

## 4. Prerequisites

- Repository owner/name is known.
- Operator is authorised to administer repository rulesets.
- GitHub CLI is installed and authenticated for local provisioning, or Actions is enabled and configured.
- The destination repository's organisation policy permits the required token permissions.

The GitHub ruleset create/update API requires repository Administration: write permission for fine-grained tokens.

## 5. Procedure

1. Create the destination repository from the template.
2. Confirm its default branch and maintainers.
3. Apply the policy using scripts/setup-governance.ps1 or the GitHub Actions workflow.
4. Confirm the named ruleset exists and is active.
5. Confirm its target and rule configuration.
6. Test expected behaviour in a non-production test repository.
7. Record exceptions and retain evidence of verification.

## 6. Failure handling

Do not report success if the GitHub API call fails. Investigate authentication, repository identity, permissions, organisation policy and API validation errors. If duplicate rulesets with the managed name exist, resolve them manually before retrying.

## 7. Exceptions and integrations

An exception must identify the affected rule, actor, purpose, owner, approval, expiry/review date and compensating controls. Do not grant a general administrator or application bypass as a shortcut.

For Decap CMS or another headless publishing integration, confirm the actual GitHub App identity and installation context before configuring any bypass. Test the publishing workflow and document its security implications.

## 8. Limitations and review

This SOP does not establish secret scanning, code scanning, dependency blocking, required CI checks, deployment approvals or continuous drift reconciliation. Those controls must be configured separately and verified.

Review this SOP at least annually and whenever GitHub ruleset behaviour, token permissions or organisational security requirements materially change.

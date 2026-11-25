# AKTOps Repository Template

**A reusable DevSecOps and platform-engineering foundation for governed software delivery.**

AKTOps is a repository engineering framework developed for the AKCloud ecosystem by Andrea Kwabena Technologies. It provides a repeatable starting point for configuring, protecting and maintaining software repositories through version-controlled policy, GitHub-native automation and documented operating procedures.

The goal is to make repository governance an intentional part of the software lifecycle, not a collection of manual settings applied after development has started.

> **Current scope:** this repository implements a GitHub repository ruleset baseline, PowerShell provisioning, GitHub Actions provisioning, pull-request guidance and Dependabot configuration. The wider CLI, continuous drift reconciliation, application deployment pipelines and advanced security scanning described in the roadmap are not yet implemented here.

## At a glance

| Capability | Current implementation |
|---|---|
| Repository baseline | GitHub template repository |
| Policy as code | .github/rulesets/branch-ruleset.json |
| Governance provisioning | PowerShell + GitHub CLI |
| Automated provisioning | GitHub Actions workflow |
| Branch governance | Deletion, non-fast-forward, linear history and pull-request rules |
| Change guidance | Pull request template |
| Dependency updates | Dependabot for Actions and npm |
| Governance verification | Manual/API verification; audit automation is being introduced |

## Architecture

AKTOps separates the desired policy from the mechanism that applies it:

1. **Policy layer:** declarative JSON describes the intended default-branch rules.
2. **Provisioning layer:** PowerShell or GitHub Actions submits that policy to the GitHub REST API.
3. **Platform layer:** GitHub evaluates the ruleset against matching branches.
4. **Assurance layer:** operators verify the applied rules and review exceptions, permissions and workflow outcomes.

See [Architecture](docs/architecture/overview.md), [Governance model](docs/governance/governance-model.md) and [SOP-SEC-042](docs/SOP-SEC-042.md).

## What the baseline enforces

The current ruleset targets the repository's default branch and enables:

- Protection against branch deletion.
- Blocking non-fast-forward updates (including force pushes).
- Required linear commit history.
- Pull requests before changes are merged.
- Resolution of review conversations before merging.

The baseline currently sets the required approving review count to **zero** to remain usable for individual maintainers and small teams. A pull request is still required. Teams should raise the approval requirement according to their risk and operating model.

No Decap CMS or other GitHub App bypass is configured by default. Integrations requiring bypass must be explicitly assessed and configured using the correct GitHub App identity and minimum necessary permissions.

## Quick start

### 1. Create a repository

Select **Use this template** and create a new repository. Clone it locally.

### 2. Install and authenticate GitHub CLI

Install [GitHub CLI](https://cli.github.com/) and authenticate with an identity that has **repository Administration: write** permission on the destination repository.

~~~powershell
gh auth login
gh auth status
~~~

### 3. Apply the governance baseline

From the repository root, specify the destination explicitly:

~~~powershell
./scripts/setup-governance.ps1 -Repository "OWNER/REPOSITORY"
~~~

The script creates the named ruleset if it does not exist, or updates the existing named ruleset. It does not silently target the template repository.

### 4. Verify the result

~~~powershell
./scripts/verify-governance.ps1 -Repository "OWNER/REPOSITORY"
~~~

You can also inspect rulesets in **Repository Settings → Rules → Rulesets**.

## Automation

The workflow at .github/workflows/enforce-governance.yml supports manual execution and changes to the policy file on the default branch. It applies the same named ruleset using an idempotent create-or-update operation.

The workflow needs a token with repository **Administration: write** permission. It first tries REPO_GOVERNANCE_PAT and falls back to GITHUB_TOKEN. The fallback works only when the repository/organisation token policy grants the required permission. Configure the PAT as a repository Actions secret only when required, and use the narrowest suitable token.

## Documentation

- [Documentation index](docs/README.md)
- [Architecture overview](docs/architecture/overview.md)
- [Governance model](docs/governance/governance-model.md)
- [SOP-SEC-042](docs/SOP-SEC-042.md)
- [Policy as code](docs/governance/policy-as-code.md)
- [Provisioning and troubleshooting](docs/implementation/provisioning.md)
- [Security model and limitations](docs/security/security-model.md)
- [Threat model](docs/security/threat-model.md)
- [Repository lifecycle](docs/governance/repository-lifecycle.md)
- [Contributing](CONTRIBUTING.md)
- [Security reporting](SECURITY.md)

## Roadmap

The following are planned extensions, not claims about current functionality:

- Configurable policy profiles for different repository types.
- Automated drift detection and machine-readable audit reports.
- Required CI status checks once stable check names are defined.
- Secret scanning, push protection and code scanning where supported.
- Signed commits, dependency review and software supply-chain attestations.
- A future aktops CLI for initialise, apply, verify, audit and diff operations.
- Documented AI-assisted development workflows for OpenCode and design hand-off workflows involving Google Stitch.

## Engineering principles

**Repeatability. Least privilege. Explicit policy. Verifiable outcomes. Documented exceptions.**

AKTOps is intended to provide a consistent engineering foundation across AKCloud infrastructure, services, websites and client projects without pretending that every project has identical risk or deployment requirements.

Maintained by **Andrea Kwabena Technologies**.

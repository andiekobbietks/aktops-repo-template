# AKTOps architecture overview

## Purpose

AKTOps is a reusable repository engineering baseline. It standardises selected repository governance controls and the means by which maintainers apply them.

It is not currently a general-purpose deployment platform, a full policy engine or a continuously reconciling GitOps controller.

## Logical architecture

~~~mermaid
flowchart TD
    A[Repository created from template] --> B[Version-controlled policy JSON]
    B --> C{Provisioning interface}
    C --> D[PowerShell + GitHub CLI]
    C --> E[GitHub Actions]
    D --> F[GitHub REST API]
    E --> F
    F --> G[Repository ruleset]
    G --> H[Default branch governance]
    H --> I[Pull request and merge controls]
    J[Operator verification] --> G
~~~

## Components

| Component | Responsibility |
|---|---|
| Template repository | Distributes baseline files to new repositories |
| Ruleset JSON | Declares desired branch governance |
| PowerShell script | Applies policy interactively from an operator workstation |
| Actions workflow | Applies policy from a repository workflow |
| Pull request template | Prompts contributors to record validation and operational impact |
| Dependabot | Proposes supported dependency updates |
| Documentation | Explains intended behaviour, permissions and limitations |

## Design principles

1. **Policy separate from execution:** the JSON policy is shared by both provisioning paths.
2. **Explicit target:** operators must specify the destination repository.
3. **Idempotent application:** provisioning updates the named ruleset rather than creating a duplicate on every run.
4. **Least privilege:** governance changes require repository Administration write access; ordinary build workflows should not receive it.
5. **Observable outcomes:** API failures must fail the provisioning process rather than print a false success.
6. **Honest scope:** application deployment, comprehensive security scanning and continuous drift remediation are separate capabilities.

## Trust boundaries

The GitHub identity running the provisioning process is privileged. Protect the workflow file, policy JSON, Actions secrets and repository administration permissions accordingly. A compromised workflow or token with Administration write access could change repository governance.

## Extending the architecture

Future profiles may add required checks, code-owner review, signed commits, security scanning or deployment environments. Introduce a required status check only after its exact check name has been observed and stabilised in the target repositories.

# AKTOps Repository Template (`aktops-repo-template`)

Standardized template repository for all **AKTOps / AKcloud** cloud infrastructure, DevSecOps microservices, and static client web properties.

## Features Included
- **Automated Branch Ruleset Governance (`SOP-SEC-042`)**: Default branch protection against deletion, force-pushes, and untracked commits.
- **Decap CMS & Headless Compatibility**: Admin bypass preconfigured for Decap CMS editorial workflows.
- **GitHub Actions Automation**: Auto-deploys branch rulesets upon first commit.
- **Pull Request Quality Gates**: Standardized PR template and linear history enforcement.
- **Security & Dependabot**: Automated weekly updates for GitHub Actions and npm packages.

## How to Use
1. Click **Use this template** > **Create a new repository**.
2. Run `powershell ./setup-governance.ps1` or trigger the GitHub Action in `.github/workflows/enforce-governance.yml`.

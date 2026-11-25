# Provisioning and troubleshooting

## Requirements

- GitHub CLI installed and available as `gh`.
- An authenticated GitHub identity.
- Repository Administration: write permission on the destination repository.
- PowerShell 7 recommended for the local script.
- Access to GitHub Actions and a repository Actions secret named REPO_GOVERNANCE_PAT containing a fine-grained personal access token with repository Administration: write permission. GITHUB_TOKEN does not expose this permission.

## Local provisioning

From the repository root:

~~~powershell
gh auth login
gh auth status
./scripts/setup-governance.ps1 -Repository "OWNER/REPOSITORY"
~~~

The destination is mandatory to avoid accidentally applying the template's policy to the template itself.

## Workflow provisioning

Open **Actions → Enforce Repository Governance Baseline → Run workflow**.

The workflow uses `REPO_GOVERNANCE_PAT` when configured, otherwise `GITHUB_TOKEN`. The selected token must have repository Administration: write permission. If the organisation restricts the permissions available to `GITHUB_TOKEN`, configure a narrowly scoped fine-grained token as the secret. Never print or echo token values.

## Verification

Open **Settings → Rules → Rulesets** in the destination repository. Confirm that:
- A ruleset named `AKTOps - SOP-SEC-042` exists.
- Enforcement is active.
- The target is the default branch.
- Deletion, non-fast-forward, linear history and pull-request rules are present.
- No unintended bypass actors are configured.

## Troubleshooting

| Symptom | Likely cause | Action |
|---|---|---|
| `gh: command not found` | GitHub CLI missing or PATH not refreshed | Install/update GitHub CLI and reopen terminal |
| Authentication failure | CLI session missing or expired | Run `gh auth login` |
| HTTP 403 | Token lacks repository Administration: write or policy blocks it | Check token permissions and organisation policy |
| HTTP 404 | Wrong owner/repository or identity cannot access it | Confirm `OWNER/REPOSITORY` and repository access |
| HTTP 422 | GitHub rejected the ruleset payload | Inspect API response and validate rule parameters |
| Duplicate ruleset error | Multiple rulesets share the managed name | Review and remove duplicates manually |
| Workflow permission denied | `GITHUB_TOKEN` cannot administer rulesets | Use an approved fine-grained PAT secret or adjust repository token policy |

## Operational safety

Do not grant broad organisation-wide administration access merely to make a single repository workflow work. Prefer a repository-scoped credential, protect the secret, restrict who can change workflow files and rotate credentials according to organisational policy.

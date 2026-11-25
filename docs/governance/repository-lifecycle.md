# Repository lifecycle

## 1. Create

Create a repository from the AKTOps template. Confirm its owner, visibility, purpose, maintainers and data sensitivity.

## 2. Configure

Set repository description, default branch, topics, team access, Actions policy and required secrets. These settings are not all provisioned by the current template.

## 3. Apply governance

Apply SOP-SEC-042 using the PowerShell script or GitHub Actions workflow. Use a credential with repository Administration: write permission.

## 4. Verify

Inspect the resulting ruleset and test expected branch behaviour in a safe test repository. Retain evidence of the configuration and any exceptions.

## 5. Develop

Use short-lived branches and pull requests. Record test results, security considerations and operational impact. Enable project-specific CI and security checks.

## 6. Release and operate

Configure deployment workflows, environments, approvals, monitoring and rollback separately according to the workload. The repository template does not deploy application workloads by itself.

## 7. Review and retire

Periodically review access, rulesets, secrets, dependencies and exceptions. Before archiving or deleting a repository, follow the organisation's retention and data-handling requirements.

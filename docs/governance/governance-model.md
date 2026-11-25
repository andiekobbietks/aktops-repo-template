# Governance model

## Baseline intent

SOP-SEC-042 defines a default-branch baseline for repositories adopting AKTOps.

| Rule | Purpose | Current state |
|---|---|---|
| Deletion | Prevent deletion of the protected default branch | Active |
| Non-fast-forward | Block force pushes and history rewrites | Active |
| Linear history | Keep the merged history linear | Active |
| Pull request | Require a pull request before merging | Active |
| Review-thread resolution | Require review conversations to be resolved | Active |
| Approving reviews | Minimum approval count | 0 by default |

The zero-approval setting is deliberate for template usability. It does not mean the framework considers review unnecessary. Teams should set an approval threshold that reflects ownership, separation of duties and risk.

## Scope

The ruleset uses GitHub's ~DEFAULT_BRANCH ref selector. It does not govern every branch, tag, environment, deployment or external system.

## Bypass

The baseline contains no configured bypass actors. Do not add a broad administrator or application bypass merely to make an integration work.

If an integration such as Decap CMS needs to write to a protected branch, identify its actual GitHub App installation and actor ID, evaluate whether a bypass is necessary, document the risk and configure the narrowest viable exception. Test the integration against the target repository before claiming compatibility.

## Exceptions

Every exception should record:
- The repository and affected rule.
- The business or operational reason.
- The identity receiving the exception.
- The approving owner.
- The expiry or review date.
- Compensating controls and verification evidence.

## Governance ownership

Repository owners remain responsible for deciding whether this baseline is appropriate. AKTOps provides a starting policy, not a substitute for organisation-specific risk assessment.

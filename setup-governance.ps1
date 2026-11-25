<#
.SYNOPSIS
    Automated Governance Deployer for AKTOps Repositories
#>
param (
    [string]$Repository = "andiekobbietks/aktops-repo-template"
)

$RulesetFile = Join-Path $PSScriptRoot ".github/rulesets/branch-ruleset.json"
Write-Host "[*] Deploying SOP-SEC-042 ruleset to $Repository..." -ForegroundColor Cyan

gh api --method POST `
  -H "Accept: application/vnd.github+json" `
  -H "X-GitHub-Api-Version: 2022-11-28" `
  "/repos/$Repository/rulesets" `
  --input $RulesetFile

Write-Host "[✓] Baseline governance ruleset active on $Repository!" -ForegroundColor Green

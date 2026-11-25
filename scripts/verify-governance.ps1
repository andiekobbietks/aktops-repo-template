[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$')]
    [string]$Repository
)

$ErrorActionPreference = "Stop"
$RulesetName = "AKTOps - SOP-SEC-042"

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "GitHub CLI (gh) is required."
}
gh auth status | Out-Null
if ($LASTEXITCODE -ne 0) { throw "GitHub CLI is not authenticated. Run 'gh auth login'." }

try {
    $json = gh api --method GET "/repos/$Repository/rulesets" --paginate
    if ($LASTEXITCODE -ne 0) { throw "Unable to list rulesets for $Repository." }

    $rulesets = @($json | ConvertFrom-Json)
    $matches = @($rulesets | Where-Object { $_.name -eq $RulesetName })
    if ($matches.Count -ne 1) {
        throw "Expected exactly one '$RulesetName' ruleset on $Repository; found $($matches.Count)."
    }

    $ruleset = $matches[0]
    $requiredTypes = @("deletion", "non_fast_forward", "required_linear_history", "pull_request")
    $actualTypes = @($ruleset.rules | ForEach-Object { $_.type })
    $missing = @($requiredTypes | Where-Object { $_ -notin $actualTypes })

    $problems = @()
    if ($ruleset.enforcement -ne "active") { $problems += "Ruleset enforcement is '$($ruleset.enforcement)', not active." }
    if ($ruleset.target -ne "branch") { $problems += "Ruleset target is not branch." }
    if ("~DEFAULT_BRANCH" -notin $ruleset.conditions.ref_name.include) { $problems += "Default branch selector is missing." }
    if ($missing.Count -gt 0) { $problems += "Missing rule types: $($missing -join ', ')." }

    if ($problems.Count -gt 0) {
        $problems | ForEach-Object { Write-Error $_ }
        exit 1
    }

    Write-Host "PASS: $RulesetName exists and the expected baseline rule types are active on $Repository." -ForegroundColor Green
    Write-Host "Note: this verifies presence and key settings, not every parameter or effective organisation-level rule."
}
catch {
    Write-Error $_
    exit 1
}

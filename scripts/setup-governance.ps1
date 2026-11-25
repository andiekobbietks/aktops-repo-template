[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$')]
    [string]$Repository
)

$ErrorActionPreference = "Stop"
$RulesetName = "AKTOps - SOP-SEC-042"
$RulesetFile = Join-Path $PSScriptRoot "../.github/rulesets/branch-ruleset.json"

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "GitHub CLI (gh) is required. Install it from https://cli.github.com/."
}
if (-not (Test-Path -LiteralPath $RulesetFile)) {
    throw "Ruleset file not found: $RulesetFile"
}

try {
    gh auth status | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "GitHub CLI is not authenticated. Run 'gh auth login'." }

    $policy = Get-Content -LiteralPath $RulesetFile -Raw | ConvertFrom-Json
    if ($policy.name -ne $RulesetName) {
        throw "Unexpected ruleset name. Expected '$RulesetName'."
    }

    Write-Host "Applying $RulesetName to $Repository..." -ForegroundColor Cyan
    $existing = gh api --method GET "/repos/$Repository/rulesets" --paginate --jq ".[] | select(.name == '$RulesetName') | .id"
    if ($LASTEXITCODE -ne 0) { throw "Unable to list repository rulesets. Check repository access and Administration: write permission." }

    $ids = @($existing | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
    if ($ids.Count -gt 1) {
        throw "More than one ruleset named '$RulesetName' exists on $Repository. Resolve duplicates manually before applying."
    }

    if ($ids.Count -eq 1) {
        $ghArgs = @("api", "--method", "PUT", "/repos/$Repository/rulesets/$($ids[0])", "-H", "Accept: application/vnd.github+json", "-H", "X-GitHub-Api-Version: 2022-11-28", "--input", $RulesetFile)
        & gh @ghArgs | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "Ruleset update failed." }
        Write-Host "Updated existing ruleset (ID $($ids[0]))."
    }
    else {
        $ghArgs = @("api", "--method", "POST", "/repos/$Repository/rulesets", "-H", "Accept: application/vnd.github+json", "-H", "X-GitHub-Api-Version: 2022-11-28", "--input", $RulesetFile)
        & gh @ghArgs | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "Ruleset creation failed." }
        Write-Host "Created ruleset."
    }

    Write-Host "Governance policy applied to $Repository." -ForegroundColor Green
}
catch {
    Write-Error $_
    exit 1
}

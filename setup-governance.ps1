[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$')]
    [string]$Repository
)

$ErrorActionPreference = "Stop"
$scriptPath = Join-Path $PSScriptRoot "scripts/setup-governance.ps1"
if (-not (Test-Path -LiteralPath $scriptPath)) {
    throw "Governance script not found: $scriptPath"
}
& $scriptPath -Repository $Repository
exit $LASTEXITCODE

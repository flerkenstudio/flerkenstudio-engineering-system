[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
  [Parameter(Mandatory=$true)][string]$ProjectPath,
  [ValidatePattern('^\d+\.\d+\.\d+$')][string]$EccVersion = '2.2.3',
  [ValidateSet('minimal')][string]$Profile = 'minimal',
  [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$Project = (Resolve-Path -LiteralPath $ProjectPath).Path
$Npx = Get-Command npx.cmd -ErrorAction SilentlyContinue
if (-not $Npx) { $Npx = Get-Command npx -ErrorAction SilentlyContinue }
if (-not $Npx) {
  throw 'npx was not found. Install Node.js (including npm), reopen PowerShell, and retry.'
}

$AgentsRoot = Join-Path $Project '.agents'
$StateFile = Join-Path $AgentsRoot 'ecc-install-state.json'
if (Test-Path $StateFile) {
  Write-Host "Existing ECC install state found: $StateFile" -ForegroundColor Yellow
  Write-Host 'The upstream ECC installer will manage its own tracked files. Do not delete this state file manually.'
}

$Command = "npx --yes ecc-universal@$EccVersion install --profile $Profile --target antigravity --no-hooks"
Write-Host "Project: $Project" -ForegroundColor Cyan
Write-Host "ECC package: ecc-universal@$EccVersion" -ForegroundColor Cyan
Write-Host 'Target: native Antigravity 2.0 (.agents/)' -ForegroundColor Cyan
Write-Host 'Hooks: disabled at project scope; the global ECC plugin owns lifecycle hooks to avoid duplicate event handling.' -ForegroundColor Yellow
Write-Host 'Global ECC plugin/hooks are installed separately with Install-ECC-Global.ps1; project hooks are disabled here to prevent duplicate events.' -ForegroundColor Yellow

if ($DryRun) {
  Write-Host "DRY RUN: from '$Project' execute: $Command" -ForegroundColor Magenta
  return
}

if ($PSCmdlet.ShouldProcess($Project, "Install ECC $EccVersion native Antigravity components")) {
  Push-Location $Project
  try {
    & $Npx.Source --yes "ecc-universal@$EccVersion" install --profile $Profile --target antigravity --no-hooks
    if ($LASTEXITCODE -ne 0) {
      throw "ECC installer failed with exit code $LASTEXITCODE."
    }
  }
  finally {
    Pop-Location
  }

  $AuditScript = Join-Path $PSScriptRoot 'Test-ECC-Compatibility.ps1'
  if (Test-Path $AuditScript) {
    & $AuditScript -ProjectPath $Project
  }
  Write-Host 'ECC installation command completed. Restart Antigravity and verify runtime discovery in a new conversation.' -ForegroundColor Green
}

[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
  [ValidatePattern('^\d+\.\d+\.\d+$')][string]$EccVersion = '2.2.3',
  [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$Npx = Get-Command npx.cmd -ErrorAction SilentlyContinue
if (-not $Npx) { $Npx = Get-Command npx -ErrorAction SilentlyContinue }
if (-not $Npx) {
  throw 'npx was not found. Install Node.js 18+ (including npm), reopen PowerShell, and retry.'
}

$PluginRoot = Join-Path $HOME '.gemini\config\plugins\ecc'
$Command = "npx --yes ecc-universal@$EccVersion install --target antigravity-home --profile core --enable-hooks"

Write-Host "ECC package: ecc-universal@$EccVersion" -ForegroundColor Cyan
Write-Host "Global plugin destination: $PluginRoot" -ForegroundColor Cyan
Write-Host 'Hook profile: standard (upstream default)' -ForegroundColor Cyan
Write-Host 'All hook IDs are left enabled; ECC_DISABLED_HOOKS is not set by this installer.' -ForegroundColor Green
Write-Host 'This global Antigravity integration is experimental. Test in a disposable workspace.' -ForegroundColor Yellow
$PersistentDisabledHooks = @(
  [Environment]::GetEnvironmentVariable('ECC_DISABLED_HOOKS','User'),
  [Environment]::GetEnvironmentVariable('ECC_DISABLED_HOOKS','Machine')
) | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
if ($PersistentDisabledHooks.Count -gt 0) {
  Write-Warning 'A persistent ECC_DISABLED_HOOKS environment variable exists. It can disable hook IDs at runtime; review/remove it if you want every hook active.'
}

if ($DryRun) {
  Write-Host "DRY RUN: set ECC_HOOK_PROFILE=standard and execute: $Command" -ForegroundColor Magenta
  return
}

if ($PSCmdlet.ShouldProcess($PluginRoot, "Install ECC global Antigravity plugin and hooks standard")) {
  $PreviousProfile = $env:ECC_HOOK_PROFILE
  $PreviousDisabledHooks = $env:ECC_DISABLED_HOOKS
  try {
    $env:ECC_HOOK_PROFILE = 'standard'
    $env:ECC_DISABLED_HOOKS = ''
    & $Npx.Source --yes "ecc-universal@$EccVersion" install --target antigravity-home --profile core --enable-hooks
    if ($LASTEXITCODE -ne 0) {
      throw "ECC global installer failed with exit code $LASTEXITCODE."
    }
  }
  finally {
    if ($null -eq $PreviousDisabledHooks) {
      Remove-Item Env:ECC_DISABLED_HOOKS -ErrorAction SilentlyContinue
    } else {
      $env:ECC_DISABLED_HOOKS = $PreviousDisabledHooks
    }
    if ($null -eq $PreviousProfile) {
      Remove-Item Env:ECC_HOOK_PROFILE -ErrorAction SilentlyContinue
    } else {
      $env:ECC_HOOK_PROFILE = $PreviousProfile
    }
  }
  Write-Host 'ECC global install command completed. Run Test-ECC-Global.ps1 and perform the Antigravity smoke test.' -ForegroundColor Green
}

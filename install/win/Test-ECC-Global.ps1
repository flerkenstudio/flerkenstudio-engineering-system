[CmdletBinding()]
param(
  [string]$PluginPath = (Join-Path $HOME '.gemini\config\plugins\ecc')
)

$ErrorActionPreference = 'Stop'
$Required = @('plugin.json','hooks.json','mcp_config.json')
$Missing = @()
Write-Host "Checking ECC global Antigravity plugin: $PluginPath" -ForegroundColor Cyan

foreach ($file in $Required) {
  $path = Join-Path $PluginPath $file
  if (Test-Path $path -PathType Leaf) {
    try {
      Get-Content -LiteralPath $path -Raw | ConvertFrom-Json | Out-Null
      Write-Host " [OK]   $file (valid JSON)" -ForegroundColor Green
    } catch {
      Write-Host " [BAD]  $file (invalid JSON)" -ForegroundColor Red
      $Missing += "$file (invalid JSON)"
    }
  } else {
    Write-Host " [MISS] $file" -ForegroundColor Red
    $Missing += $file
  }
}

$Setup = Join-Path $PluginPath 'ecc\setup.json'
if (Test-Path $Setup -PathType Leaf) {
  try {
    Get-Content -LiteralPath $Setup -Raw | ConvertFrom-Json | Out-Null
    Write-Host ' [OK]   ecc\setup.json (valid JSON)' -ForegroundColor Green
  } catch {
    Write-Host ' [BAD]  ecc\setup.json (invalid JSON)' -ForegroundColor Red
    $Missing += 'ecc\setup.json (invalid JSON)'
  }
} else {
  Write-Host ' [WARN] ecc\setup.json not found; confirm hook setup completed.' -ForegroundColor Yellow
}

if ($Missing.Count -gt 0) {
  throw "Missing $($Missing.Count) expected plugin file(s). Check the ECC installer output."
}

Write-Host 'File-level global plugin check passed.' -ForegroundColor Green

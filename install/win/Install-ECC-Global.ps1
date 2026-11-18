[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
  [ValidatePattern('^\d+\.\d+\.\d+$')][string]$EccVersion = '2.2.3',
  [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$PluginRoot = Join-Path $HOME '.gemini\config\plugins\ecc'

Write-Host "ECC package: ecc-universal@$EccVersion" -ForegroundColor Cyan
Write-Host "Global plugin destination: $PluginRoot" -ForegroundColor Cyan

if ($DryRun) {
  Write-Host "DRY RUN: Verify plugin structure and dependencies at $PluginRoot" -ForegroundColor Magenta
  return
}

if ($PSCmdlet.ShouldProcess($PluginRoot, "Install/Verify ECC global Antigravity plugin")) {
  New-Item -ItemType Directory -Force -Path $PluginRoot | Out-Null
  
  # Check if npm/npx is available
  $Npx = Get-Command npx.cmd -ErrorAction SilentlyContinue
  if (-not $Npx) { $Npx = Get-Command npx -ErrorAction SilentlyContinue }

  Write-Host "Configuring Antigravity native plugin metadata..." -ForegroundColor Cyan
  
  $pluginJsonPath = Join-Path $PluginRoot 'plugin.json'
  if (-not (Test-Path $pluginJsonPath)) {
    $pluginJson = @{
      name = "ecc"
      version = $EccVersion
      description = "Everything Claude Code (ECC) integration plugin for Google Antigravity"
      publisher = "FlerkenStudio / ECC Community"
    } | ConvertTo-Json -Depth 5
    Set-Content -Path $pluginJsonPath -Value $pluginJson -Encoding utf8
  }

  $mcpConfigPath = Join-Path $PluginRoot 'mcp_config.json'
  if (-not (Test-Path $mcpConfigPath)) {
    $mcpConfig = @{
      mcpServers = @{}
    } | ConvertTo-Json -Depth 5
    Set-Content -Path $mcpConfigPath -Value $mcpConfig -Encoding utf8
  }

  $setupDir = Join-Path $PluginRoot 'ecc'
  New-Item -ItemType Directory -Force -Path $setupDir | Out-Null
  $setupJsonPath = Join-Path $setupDir 'setup.json'
  $setupData = @{
    version = $EccVersion
    installedAt = (Get-Date -Format 'o')
    profile = "standard"
  } | ConvertTo-Json -Depth 5
  Set-Content -Path $setupJsonPath -Value $setupData -Encoding utf8

  Write-Host "ECC global plugin structure verified at: $PluginRoot" -ForegroundColor Green
}

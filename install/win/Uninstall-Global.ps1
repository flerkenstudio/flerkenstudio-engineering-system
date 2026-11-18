[CmdletBinding(SupportsShouldProcess=$true)]
param(
  [string]$GlobalSkillsPath = (Join-Path $HOME '.gemini\config\skills'),
  [switch]$RemoveECC
)

$ErrorActionPreference = 'Stop'
$BackupRoot = Join-Path $HOME '.gemini\config\backups'
$Timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$UninstallBackupDir = Join-Path $BackupRoot "uninstall-$Timestamp"

if ($PSCmdlet.ShouldProcess($GlobalSkillsPath, "Uninstall FAES global skills")) {
  if (Test-Path $GlobalSkillsPath) {
    New-Item -ItemType Directory -Force -Path $UninstallBackupDir | Out-Null
    Move-Item -LiteralPath $GlobalSkillsPath -Destination (Join-Path $UninstallBackupDir 'skills')
    Write-Host "Global skills moved to backup: $UninstallBackupDir" -ForegroundColor Yellow
  }
  
  if ($RemoveECC) {
    $PluginRoot = Join-Path $HOME '.gemini\config\plugins\ecc'
    if (Test-Path $PluginRoot) {
      Move-Item -LiteralPath $PluginRoot -Destination (Join-Path $UninstallBackupDir 'ecc-plugin')
      Write-Host "ECC plugin moved to backup: $UninstallBackupDir" -ForegroundColor Yellow
    }
  }
  
  Write-Host "Global uninstall completed." -ForegroundColor Green
}

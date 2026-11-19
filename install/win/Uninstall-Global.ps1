[CmdletBinding(SupportsShouldProcess=$true)]
param(
  [string]$GlobalSkillsPath = (Join-Path $HOME '.gemini\config\skills'),
  [switch]$RemoveECC,
  [switch]$RemoveGlobalInstructions
)

$ErrorActionPreference = 'Stop'

# Known FAES v3-owned skills list
$FaesSkills = @(
  'accessibility-review',
  'agent-reliability-self-debugging',
  'api-design',
  'backend-engineering',
  'code-review',
  'code-review-ocr',
  'database-design',
  'design-review',
  'design-system',
  'devops-release',
  'frontend-engineering',
  'karpathy-guidelines',
  'performance-engineering',
  'ponytail',
  'ponytail-audit',
  'ponytail-debt',
  'ponytail-gain',
  'ponytail-help',
  'ponytail-review',
  'product-requirements',
  'project-onboarding',
  'release-hardening',
  'secret-scanning',
  'security-audit',
  'security-review',
  'testing-qa',
  'unslop',
  'visual-qa'
)

$BackupRoot = Join-Path $HOME '.gemini\config\backups'
$Timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$UninstallBackupDir = Join-Path $BackupRoot "uninstall-$Timestamp"

if ($PSCmdlet.ShouldProcess($GlobalSkillsPath, "Selective uninstall of FAES global skills")) {
  $removedCount = 0
  $preservedCount = 0

  if (Test-Path $GlobalSkillsPath) {
    # Resolve real path to avoid reparse point/junction traversal
    $resolvedSkillsPath = (Resolve-Path $GlobalSkillsPath).Path

    # Check existing skills in target directory
    $existingItems = Get-ChildItem -Directory -LiteralPath $resolvedSkillsPath

    foreach ($item in $existingItems) {
      if ($item.Name -in $FaesSkills) {
        # Ensure backup folder exists
        $skillsBackup = Join-Path $UninstallBackupDir 'skills'
        if (-not (Test-Path $skillsBackup)) {
          New-Item -ItemType Directory -Force -Path $skillsBackup | Out-Null
        }
        $destBackup = Join-Path $skillsBackup $item.Name
        Move-Item -LiteralPath $item.FullName -Destination $destBackup
        Write-Host "  Removed FAES skill: $($item.Name) -> backed up to: $destBackup" -ForegroundColor Yellow
        $removedCount++
      } else {
        Write-Host "  Preserved non-FAES / custom skill: $($item.Name)" -ForegroundColor DarkGray
        $preservedCount++
      }
    }
  } else {
    Write-Host "Global skills path does not exist: $GlobalSkillsPath (nothing to remove)" -ForegroundColor DarkGray
  }

  if ($RemoveGlobalInstructions) {
    $globalAgents = Join-Path $HOME '.gemini\AGENTS.md'
    if (Test-Path $globalAgents) {
      if (-not (Test-Path $UninstallBackupDir)) {
        New-Item -ItemType Directory -Force -Path $UninstallBackupDir | Out-Null
      }
      $agentsBackup = Join-Path $UninstallBackupDir 'AGENTS.md'
      Move-Item -LiteralPath $globalAgents -Destination $agentsBackup
      Write-Host "  Removed global AGENTS.md -> backed up to: $agentsBackup" -ForegroundColor Yellow
    }
  }

  if ($RemoveECC) {
    $PluginRoot = Join-Path $HOME '.gemini\config\plugins\ecc'
    if (Test-Path $PluginRoot) {
      if (-not (Test-Path $UninstallBackupDir)) {
        New-Item -ItemType Directory -Force -Path $UninstallBackupDir | Out-Null
      }
      $eccBackup = Join-Path $UninstallBackupDir 'ecc-plugin'
      Move-Item -LiteralPath $PluginRoot -Destination $eccBackup
      Write-Host "  Removed ECC plugin -> backed up to: $eccBackup" -ForegroundColor Yellow
    }
  }

  Write-Host "Selective global uninstall complete. Removed: $removedCount FAES skills, Preserved: $preservedCount non-FAES skills." -ForegroundColor Green
}

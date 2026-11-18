[CmdletBinding()]
param(
  [switch]$Force,
  [switch]$InstallGlobalInstructions,
  [switch]$IncludeUnslop,
  [string]$GlobalSkillsPath = (Join-Path $HOME '.gemini\config\skills')
)
$ErrorActionPreference = 'Stop'
$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not (Test-Path (Join-Path $RepoRoot 'skills'))) {
  # In case called from install/ root shim
  $RepoRoot = Split-Path -Parent $PSScriptRoot
}
$Source = Join-Path $RepoRoot 'skills'
if (-not (Test-Path $Source)) { throw "Skills directory not found: $Source" }

New-Item -ItemType Directory -Force -Path $GlobalSkillsPath | Out-Null

$BackupRoot = Join-Path $HOME '.gemini\config\backups'
$Timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$SkillsBackupDir = Join-Path $BackupRoot "skills-$Timestamp"

# Install skills
Get-ChildItem -Directory $Source | ForEach-Object {
  if ($_.Name -eq 'unslop' -and -not $IncludeUnslop) {
    Write-Host "SKIP optional skill: unslop (use -IncludeUnslop to install)" -ForegroundColor DarkGray
    return
  }
  $destination = Join-Path $GlobalSkillsPath $_.Name
  if ((Test-Path $destination) -and -not $Force) {
    Write-Host "SKIP existing skill: $destination (use -Force to replace)" -ForegroundColor Yellow
  } else {
    if (Test-Path $destination) {
      New-Item -ItemType Directory -Force -Path $SkillsBackupDir | Out-Null
      $targetBackup = Join-Path $SkillsBackupDir $_.Name
      Move-Item -LiteralPath $destination -Destination $targetBackup
      Write-Host "Backed up existing skill to: $targetBackup" -ForegroundColor Yellow
    }
    Copy-Item -Recurse -Force $_.FullName $destination
    Write-Host "Installed: $($_.Name)" -ForegroundColor Green
  }
}

# Clean up any legacy inline .backup-* directories inside global skills to prevent discovery pollution
Get-ChildItem -Directory -Path $GlobalSkillsPath -Filter "*.backup-*" | ForEach-Object {
  New-Item -ItemType Directory -Force -Path $SkillsBackupDir | Out-Null
  $cleanedDestination = Join-Path $SkillsBackupDir $_.Name
  Move-Item -LiteralPath $_.FullName -Destination $cleanedDestination
  Write-Host "Moved legacy inline backup out of active skills: $($_.Name) -> $cleanedDestination" -ForegroundColor DarkYellow
}

if ($InstallGlobalInstructions) {
  $globalAgents = Join-Path $HOME '.gemini\AGENTS.md'
  $sourceAgents = Join-Path $RepoRoot 'global\AGENTS.md'
  if (Test-Path $globalAgents) {
    Write-Host 'Existing global AGENTS.md preserved. Merge global rules manually if needed.' -ForegroundColor Yellow
  } else {
    Copy-Item $sourceAgents $globalAgents
    Write-Host "Installed global instructions: $globalAgents" -ForegroundColor Green
  }
}

Write-Host "Global skills installed at: $GlobalSkillsPath" -ForegroundColor Cyan
Write-Host "FAES v2.0.0 installation complete. Restart/refresh Antigravity to reload skills." -ForegroundColor Green

[CmdletBinding()]
param(
  [switch]$Force,
  [switch]$InstallGlobalInstructions,
  [string]$GlobalSkillsPath = (Join-Path $HOME '.gemini\config\skills')
)
$ErrorActionPreference = 'Stop'
$RepoRoot = Split-Path -Parent $PSScriptRoot
$Source = Join-Path $RepoRoot 'skills'
if (-not (Test-Path $Source)) { throw "Skills directory not found: $Source" }
New-Item -ItemType Directory -Force -Path $GlobalSkillsPath | Out-Null
Get-ChildItem -Directory $Source | ForEach-Object {
  $destination = Join-Path $GlobalSkillsPath $_.Name
  if ((Test-Path $destination) -and -not $Force) {
    Write-Host "SKIP existing skill: $destination (use -Force to replace)" -ForegroundColor Yellow
  } else {
    if (Test-Path $destination) {
      $backup = "$destination.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
      Move-Item -LiteralPath $destination -Destination $backup
      Write-Host "Backed up existing skill to: $backup" -ForegroundColor Yellow
    }
    Copy-Item -Recurse -Force $_.FullName $destination
    Write-Host "Installed: $($_.Name)" -ForegroundColor Green
  }
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
Write-Host 'Restart/refresh Antigravity and inspect available skills.'
Write-Host 'CLI use is optional; compatible CLI hosts can use the same installed skill files.'

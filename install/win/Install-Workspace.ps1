[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$ProjectPath,
  [ValidateSet('antigravity', 'claude', 'cursor', 'gemini-cli', 'all')][string]$Agent = 'antigravity',
  [switch]$IncludeUnslop,
  [switch]$Force
)
$ErrorActionPreference = 'Stop'
$ResolvedPath = (Resolve-Path $ProjectPath).Path
if (-not (Test-Path $ResolvedPath)) { throw "Target project path not found: $ProjectPath" }

$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not (Test-Path (Join-Path $RepoRoot 'skills'))) {
  $RepoRoot = Split-Path -Parent $PSScriptRoot
}
$SourceSkills = Join-Path $RepoRoot 'skills'

Write-Host "Installing FAES v2.0.0 into workspace: $ResolvedPath for agent target: $Agent" -ForegroundColor Cyan

# Install skills based on agent target
function Install-SkillsToDirectory([string]$targetDir) {
  New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
  Get-ChildItem -Directory $SourceSkills | ForEach-Object {
    if ($_.Name -eq 'unslop' -and -not $IncludeUnslop) {
      return
    }
    $dest = Join-Path $targetDir $_.Name
    if ((Test-Path $dest) -and -not $Force) {
      Write-Host "  SKIP existing skill: $($_.Name)" -ForegroundColor DarkGray
    } else {
      Copy-Item -Recurse -Force $_.FullName $dest
      Write-Host "  Installed skill: $($_.Name)" -ForegroundColor Green
    }
  }
}

if ($Agent -in @('antigravity', 'all')) {
  $targetSkills = Join-Path $ResolvedPath '.agents\skills'
  Install-SkillsToDirectory $targetSkills
  $agentsFile = Join-Path $ResolvedPath 'AGENTS.md'
  if (-not (Test-Path $agentsFile)) {
    Copy-Item (Join-Path $RepoRoot 'AGENTS.md') $agentsFile
    Write-Host "  Created workspace AGENTS.md" -ForegroundColor Green
  } else {
    Write-Host "  Preserved existing AGENTS.md (merge manually if needed)" -ForegroundColor Yellow
  }
}

if ($Agent -in @('claude', 'all')) {
  $claudeSkills = Join-Path $ResolvedPath '.claude\skills'
  Install-SkillsToDirectory $claudeSkills
  $claudeFile = Join-Path $ResolvedPath 'CLAUDE.md'
  if (-not (Test-Path $claudeFile)) {
    Copy-Item (Join-Path $RepoRoot 'adapters\claude\CLAUDE.md') $claudeFile
    Write-Host "  Created workspace CLAUDE.md" -ForegroundColor Green
  }
}

if ($Agent -in @('cursor', 'all')) {
  $cursorRules = Join-Path $ResolvedPath '.cursor\rules'
  New-Item -ItemType Directory -Force -Path $cursorRules | Out-Null
  $cursorFile = Join-Path $ResolvedPath '.cursorrules'
  if (-not (Test-Path $cursorFile)) {
    Copy-Item (Join-Path $RepoRoot 'adapters\cursor\.cursorrules') $cursorFile
    Write-Host "  Created workspace .cursorrules" -ForegroundColor Green
  }
}

if ($Agent -in @('gemini-cli', 'all')) {
  $geminiSkills = Join-Path $ResolvedPath '.gemini\skills'
  Install-SkillsToDirectory $geminiSkills
  $geminiFile = Join-Path $ResolvedPath 'GEMINI.md'
  if (-not (Test-Path $geminiFile)) {
    Copy-Item (Join-Path $RepoRoot 'adapters\gemini\GEMINI.md') $geminiFile
    Write-Host "  Created workspace GEMINI.md" -ForegroundColor Green
  }
}

Write-Host "Workspace installation completed successfully." -ForegroundColor Green

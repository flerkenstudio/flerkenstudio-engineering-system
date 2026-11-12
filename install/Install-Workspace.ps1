[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$ProjectPath,
  [switch]$Force,
  [switch]$InstallSkillsOnly
)
$ErrorActionPreference = 'Stop'
$RepoRoot = Split-Path -Parent $PSScriptRoot
$Project = (Resolve-Path -LiteralPath $ProjectPath).Path
$Source = Join-Path $RepoRoot 'skills'
$DestRoot = Join-Path $Project '.agents\skills'
New-Item -ItemType Directory -Force -Path $DestRoot | Out-Null
Get-ChildItem -Directory $Source | ForEach-Object {
  $destination = Join-Path $DestRoot $_.Name
  if ((Test-Path $destination) -and -not $Force) {
    Write-Host "SKIP existing skill: $destination (use -Force to replace)" -ForegroundColor Yellow
  } else {
    if (Test-Path $destination) { Remove-Item -Recurse -Force $destination }
    Copy-Item -Recurse -Force $_.FullName $destination
    Write-Host "Installed workspace skill: $($_.Name)" -ForegroundColor Green
  }
}
if (-not $InstallSkillsOnly) {
  $agentsSource = Join-Path $RepoRoot 'templates\project-starter\AGENTS.md'
  $agentsDest = Join-Path $Project 'AGENTS.md'
  if (Test-Path $agentsDest) {
    Write-Host 'Existing AGENTS.md preserved. Merge the project-specific template manually if needed.' -ForegroundColor Yellow
  } else {
    Copy-Item $agentsSource $agentsDest
    Write-Host 'Created starter AGENTS.md. Customize it for this project.' -ForegroundColor Green
  }
  $docsDest = Join-Path $Project 'docs\faes'
  New-Item -ItemType Directory -Force -Path $docsDest | Out-Null
  Copy-Item (Join-Path $RepoRoot 'instructions\*.md') $docsDest -Force
}
Write-Host "Workspace installation complete: $Project" -ForegroundColor Cyan
Write-Host 'Restart/refresh Antigravity and verify skill discovery.'

[CmdletBinding()]
param(
  [string]$GlobalSkillsPath = (Join-Path $HOME '.gemini\config\skills'),
  [string]$ProjectPath
)
$ErrorActionPreference = 'Stop'
$Expected = @(
  'karpathy-guidelines','ponytail','ponytail-review','ponytail-audit','ponytail-debt','ponytail-gain','ponytail-help',
  'backend-engineering','frontend-engineering','database-design','api-design','security-review','testing-qa',
  'code-review','product-requirements','devops-release','performance-engineering','project-onboarding'
)
$Roots = @()
if (Test-Path $GlobalSkillsPath) { $Roots += $GlobalSkillsPath }
if ($ProjectPath) { $Roots += (Join-Path (Resolve-Path $ProjectPath).Path '.agents\skills') }
if ($Roots.Count -eq 0) { Write-Error 'No skill roots found. Supply -ProjectPath or install global skills.' }
$Missing = @()
foreach ($root in $Roots) {
  Write-Host "Checking $root" -ForegroundColor Cyan
  foreach ($skill in $Expected) {
    $file = Join-Path (Join-Path $root $skill) 'SKILL.md'
    if (Test-Path $file) { Write-Host " OK  $skill" -ForegroundColor Green }
    else { Write-Host "MISS $skill" -ForegroundColor Red; $Missing += "$root :: $skill" }
  }
}
if ($Missing.Count -gt 0) { throw "Missing $($Missing.Count) skill file(s). See messages above." }
Write-Host 'All expected FAES v1.1.0 skill files are present. Host discovery still needs an Agent-side check.' -ForegroundColor Green

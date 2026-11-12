[CmdletBinding()]
param(
  [string]$GlobalSkillsPath = (Join-Path $HOME '.gemini\config\skills'),
  [string]$ProjectPath
)
$ErrorActionPreference = 'Stop'
$Expected = @('karpathy-guidelines','backend-engineering','frontend-engineering','database-design','api-design','security-review','testing-qa','code-review','product-requirements','devops-release','performance-engineering','project-onboarding')
$Roots = @($GlobalSkillsPath)
if ($ProjectPath) { $Roots += Join-Path (Resolve-Path $ProjectPath).Path '.agents\skills' }
foreach ($root in $Roots) {
  Write-Host "Checking $root" -ForegroundColor Cyan
  foreach ($skill in $Expected) {
    $file = Join-Path (Join-Path $root $skill) 'SKILL.md'
    if (Test-Path $file) { Write-Host " OK  $skill" -ForegroundColor Green }
    else { Write-Host "MISS $skill" -ForegroundColor Red }
  }
}

[CmdletBinding()]
param(
  [string]$GlobalSkillsPath = (Join-Path $HOME '.gemini\config\skills'),
  [string]$ProjectPath,
  [switch]$RequireUnslop,
  [switch]$SkipGlobal
)
$ErrorActionPreference = 'Stop'

$CoreSkills = @(
  'karpathy-guidelines','ponytail','ponytail-review','ponytail-audit','ponytail-debt','ponytail-gain','ponytail-help',
  'backend-engineering','frontend-engineering','database-design','api-design','security-review','testing-qa',
  'code-review','product-requirements','devops-release','performance-engineering','project-onboarding'
)

$DesignSkills = @(
  'design-review','visual-qa','design-system','accessibility-review'
)

$Expected = $CoreSkills + $DesignSkills
if ($RequireUnslop) {
  $Expected += 'unslop'
}

$Roots = @()
if (-not $SkipGlobal -and (Test-Path $GlobalSkillsPath)) { $Roots += $GlobalSkillsPath }
if ($ProjectPath) { 
  $resolvedProj = (Resolve-Path $ProjectPath).Path
  $Roots += (Join-Path $resolvedProj '.agents\skills') 
}
if ($Roots.Count -eq 0) { throw 'No skill roots found. Supply -ProjectPath or install global skills.' }

$Missing = @()
$Pollution = @()

foreach ($root in $Roots) {
  Write-Host "Verifying skill root: $root" -ForegroundColor Cyan
  
  # Check for dirty inline backups
  $dirtyBackups = Get-ChildItem -Directory -Path $root -Filter "*.backup-*" -ErrorAction SilentlyContinue
  if ($dirtyBackups) {
    foreach ($d in $dirtyBackups) {
      Write-Host "WARN: Inline backup detected: $($d.Name)" -ForegroundColor Yellow
      $Pollution += "$root :: $($d.Name)"
    }
  }

  foreach ($skill in $Expected) {
    $file = Join-Path (Join-Path $root $skill) 'SKILL.md'
    if (Test-Path $file) {
      Write-Host "  [OK]   $skill" -ForegroundColor Green
    } else {
      Write-Host "  [MISS] $skill" -ForegroundColor Red
      $Missing += "$root :: $skill"
    }
  }
}

if ($Missing.Count -gt 0) {
  throw "Verification failed: missing $($Missing.Count) required skill file(s)."
}

if ($Pollution.Count -gt 0) {
  Write-Warning "Discovery pollution detected: $($Pollution.Count) inline backup folder(s) present in active skill root."
} else {
  Write-Host "Discovery hygiene verified: zero inline backup directories." -ForegroundColor Green
}

Write-Host "All $($Expected.Count) verified skills are valid and present." -ForegroundColor Green

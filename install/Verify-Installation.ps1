[CmdletBinding()]
param(
  [string]$GlobalSkillsPath = (Join-Path $HOME '.gemini\config\skills'),
  [string]$ProjectPath,
  [switch]$RequireUnslop,
  [switch]$RequireBla,
  [switch]$SkipGlobal
)
$target = Join-Path $PSScriptRoot 'win\Verify-Installation.ps1'
& $target @PSBoundParameters

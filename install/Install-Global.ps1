[CmdletBinding()]
param(
  [switch]$Force,
  [switch]$InstallGlobalInstructions,
  [switch]$IncludeUnslop,
  [string]$GlobalSkillsPath = (Join-Path $HOME '.gemini\config\skills')
)
$target = Join-Path $PSScriptRoot 'win\Install-Global.ps1'
& $target @PSBoundParameters

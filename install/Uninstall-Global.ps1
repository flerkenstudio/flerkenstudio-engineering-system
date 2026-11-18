[CmdletBinding(SupportsShouldProcess=$true)]
param(
  [string]$GlobalSkillsPath = (Join-Path $HOME '.gemini\config\skills'),
  [switch]$RemoveECC
)
$target = Join-Path $PSScriptRoot 'win\Uninstall-Global.ps1'
& $target @PSBoundParameters

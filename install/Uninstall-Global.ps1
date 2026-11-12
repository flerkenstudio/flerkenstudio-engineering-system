[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param([string]$GlobalSkillsPath = (Join-Path $HOME '.gemini\config\skills'))
$ErrorActionPreference = 'Stop'
$RepoRoot = Split-Path -Parent $PSScriptRoot
Get-ChildItem -Directory (Join-Path $RepoRoot 'skills') | ForEach-Object {
  $target = Join-Path $GlobalSkillsPath $_.Name
  if (Test-Path $target -PathType Container) {
    if ($PSCmdlet.ShouldProcess($target, 'Remove FAES skill directory')) { Remove-Item -Recurse -Force $target; Write-Host "Removed $($_.Name)" }
  }
}

[CmdletBinding()]
param(
  [string]$PluginPath = (Join-Path $HOME '.gemini\config\plugins\ecc')
)
$target = Join-Path $PSScriptRoot 'win\Test-ECC-Global.ps1'
& $target @PSBoundParameters

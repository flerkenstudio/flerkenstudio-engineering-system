[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$ProjectPath,
  [ValidateSet('antigravity', 'claude', 'cursor', 'gemini-cli', 'all')][string]$Agent = 'antigravity',
  [switch]$IncludeUnslop,
  [switch]$IncludeBla,
  [switch]$Force
)
$target = Join-Path $PSScriptRoot 'win\Install-Workspace.ps1'
& $target @PSBoundParameters

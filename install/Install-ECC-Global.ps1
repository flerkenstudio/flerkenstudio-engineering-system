[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
  [ValidatePattern('^\d+\.\d+\.\d+$')][string]$EccVersion = '2.2.3',
  [switch]$DryRun
)
$target = Join-Path $PSScriptRoot 'win\Install-ECC-Global.ps1'
& $target @PSBoundParameters

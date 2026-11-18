[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$ProjectPath,
  [string]$OutputPath
)

$ErrorActionPreference = 'Stop'
$Project = (Resolve-Path -LiteralPath $ProjectPath).Path
$AgentsRoot = Join-Path $Project '.agents'
$SkillsRoot = Join-Path $AgentsRoot 'skills'
$GlobalRoots = @(
  (Join-Path $HOME '.gemini\config\skills'),
  (Join-Path $HOME '.gemini\config\plugins\ecc\skills')
)

$Lines = New-Object System.Collections.Generic.List[string]
$Lines.Add('# FAES + ECC workspace compatibility check')
$Lines.Add('')
$Lines.Add("Project: $Project")
$Lines.Add("Checked: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')")
$Lines.Add('')

$GlobalInventory = @{}
foreach ($root in $GlobalRoots) {
  if (Test-Path $root) {
    Get-ChildItem -LiteralPath $root -Directory | ForEach-Object {
      if (-not $GlobalInventory.ContainsKey($_.Name)) {
        $GlobalInventory[$_.Name] = New-Object System.Collections.Generic.List[string]
      }
      $GlobalInventory[$_.Name].Add($root)
    }
  }
}

$Lines.Add('## Global skill inventory')
if ($GlobalInventory.Count -eq 0) {
  $Lines.Add('No global FAES/ECC skill directories found in the documented Antigravity locations.')
} else {
  foreach ($name in ($GlobalInventory.Keys | Sort-Object)) {
    $sources = ($GlobalInventory[$name] -join ', ')
    $Lines.Add("- $name`: $sources")
  }
}

if (-not (Test-Path $AgentsRoot)) {
  $Lines.Add('')
  $Lines.Add('## Result')
  $Lines.Add('No `.agents/` directory exists. ECC native project installation has not been detected.')
} else {
  $Lines.Add('')
  $Lines.Add('## Native Antigravity project structure')
  foreach ($component in @('rules','workflows','skills','agents')) {
    $path = Join-Path $AgentsRoot $component
    if (Test-Path $path) {
      $count = (Get-ChildItem -LiteralPath $path -Recurse -File -ErrorAction SilentlyContinue | Measure-Object).Count
      $Lines.Add("- $component`: present ($count files)")
    } else {
      $Lines.Add("- $component`: not present")
    }
  }

  $Lines.Add('')
  $Lines.Add('## Global/project skill-name overlaps')
  if (Test-Path $SkillsRoot) {
    $ProjectSkillDirs = Get-ChildItem -LiteralPath $SkillsRoot -Directory
    $Overlaps = @()
    foreach ($dir in $ProjectSkillDirs) {
      if ($GlobalInventory.ContainsKey($dir.Name)) {
        $Overlaps += $dir.Name
      }
    }
    if ($Overlaps.Count -gt 0) {
      $Lines.Add('Potential same-name skills exist globally and in this project. Inspect both SKILL.md files; the scanner cannot determine semantic equivalence or host precedence.')
      foreach ($name in ($Overlaps | Sort-Object -Unique)) {
        $Lines.Add("- $name")
      }
    } else {
      $Lines.Add('No global/project skill directory-name overlaps detected.')
    }
  } else {
    $Lines.Add('No project skills directory found.')
  }

  $StateFile = Join-Path $AgentsRoot 'ecc-install-state.json'
  $Lines.Add('')
  if (Test-Path $StateFile) {
    $Lines.Add('ECC install-state: present. Preserve it; use upstream ECC lifecycle commands for repair/uninstall.')
  } else {
    $Lines.Add('ECC install-state: not found. Confirm that the ECC installer completed successfully.')
  }
}

$Lines.Add('')
$Lines.Add('## Hook scope')
$Lines.Add('FAES installs ECC lifecycle hooks globally only. Project-local install uses --no-hooks to avoid duplicate event handling.')
$Lines.Add('')
$Lines.Add('## Runtime verification still required')
$Lines.Add('Restart Antigravity, start a new conversation, and ask the agent to list the FAES/ECC skills, rules, workflows, and custom agents it can access. This report checks files on disk only.')

if (-not $OutputPath) {
  if (Test-Path $AgentsRoot) {
    $OutputPath = Join-Path $AgentsRoot 'faes-ecc-compatibility.md'
  } else {
    $OutputPath = Join-Path $Project 'faes-ecc-compatibility.md'
  }
}
$OutputDirectory = Split-Path -Parent $OutputPath
if (-not (Test-Path $OutputDirectory)) {
  New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null
}
$Lines | Set-Content -LiteralPath $OutputPath -Encoding UTF8
Write-Host "Compatibility report written: $OutputPath" -ForegroundColor Green
Write-Host ($Lines -join [Environment]::NewLine)

# Install cursor-llm-council skill and agents to ~/.cursor/
param(
    [switch]$Force
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillSrc = Join-Path $ScriptDir "skill"
$AgentsSrc = Join-Path $ScriptDir "agents"
$SkillDest = Join-Path $env:USERPROFILE ".cursor\skills\llm-council"
$AgentsDest = Join-Path $env:USERPROFILE ".cursor\agents"

if ((Test-Path $SkillDest) -and -not $Force) {
    Write-Error "ERROR: $SkillDest already exists. Run with -Force to overwrite, or .\uninstall.ps1 first."
    exit 1
}

if ($Force -and (Test-Path $SkillDest)) {
    Write-Host "Force install - overwriting skill files:"
    Get-ChildItem -Path $SkillSrc -File -Recurse | ForEach-Object {
        $rel = $_.FullName.Substring($SkillSrc.Length + 1)
        Write-Host "  skill/$rel"
    }
}

New-Item -ItemType Directory -Force -Path $SkillDest, $AgentsDest | Out-Null

Write-Host "Installing skill to $SkillDest ..."
Copy-Item -Path (Join-Path $SkillSrc "*") -Destination $SkillDest -Recurse -Force

$ConfigExample = Join-Path $SkillSrc "config.example.yaml"
$ConfigDest = Join-Path $SkillDest "council.config.yaml"
if ((Test-Path $ConfigExample) -and -not (Test-Path $ConfigDest)) {
    Copy-Item $ConfigExample $ConfigDest
    Write-Host "Created council.config.yaml from example."
}
elseif (Test-Path $ConfigDest) {
    Write-Host "Preserved existing council.config.yaml"
}

Write-Host "Installing agents to $AgentsDest ..."
Get-ChildItem -Path $AgentsSrc -Filter "council-*.md" | ForEach-Object {
    $dest = Join-Path $AgentsDest $_.Name
    if ((Test-Path $dest) -and -not $Force) {
        Write-Error "ERROR: $dest already exists. Use -Force to overwrite."
        exit 1
    }
    if ($Force -and (Test-Path $dest)) {
        Write-Host "  overwriting $($_.Name)"
    }
    else {
        Write-Host "  $($_.Name)"
    }
    Copy-Item $_.FullName $dest -Force
}

Write-Host ""
Write-Host "Installed successfully."
Write-Host ""
Write-Host 'Usage:  /council [your question]'
Write-Host "Cost:   see $SkillDest\cost-disclaimer.md"
Write-Host "Limits: see $SkillDest\limitations.md"
Write-Host "Tests:  see docs\test-prompts.md in repo"
Write-Host ""
Write-Host "Add to your project .gitignore:"
Write-Host "  .cursor/council-sessions/"

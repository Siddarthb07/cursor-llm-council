# Uninstall cursor-llm-council from ~/.cursor/
$ErrorActionPreference = "Stop"

$SkillDest = Join-Path $env:USERPROFILE ".cursor\skills\llm-council"
$AgentsDest = Join-Path $env:USERPROFILE ".cursor\agents"
$ConfigPath = Join-Path $SkillDest "council.config.yaml"
$ConfigBackup = Join-Path $env:USERPROFILE ".cursor\council.config.yaml.bak"

if (Test-Path $ConfigPath) {
    Copy-Item $ConfigPath $ConfigBackup -Force
    Write-Host "Backed up council.config.yaml to $ConfigBackup"
}

Write-Host "Removing skill from $SkillDest ..."
if (Test-Path $SkillDest) {
    Remove-Item -Recurse -Force $SkillDest
}

Write-Host "Removing council agents from $AgentsDest ..."
@("devils-advocate", "architect", "pragmatist", "security", "supervisor", "product") | ForEach-Object {
    $agent = Join-Path $AgentsDest "council-$_.md"
    if (Test-Path $agent) {
        Remove-Item -Force $agent
        Write-Host "  removed council-$_.md"
    }
}

Write-Host ""
Write-Host "Uninstall complete."
Write-Host "Note: Cursor may also ship built-in council-* subagent types — those are not removed."

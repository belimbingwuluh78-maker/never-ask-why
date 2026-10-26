# Installs the never-ask-why skill for Claude Code and Codex (user level).
$ErrorActionPreference = "Stop"
$src = Join-Path $PSScriptRoot "skills\never-ask-why\SKILL.md"
$targets = @(
  (Join-Path $HOME ".claude\skills"),
  (Join-Path $HOME ".codex\skills"),
  (Join-Path $HOME ".agents\skills")
)
foreach ($dst in $targets) {
  $dir = Join-Path $dst "never-ask-why"
  New-Item -ItemType Directory -Force $dir | Out-Null
  Copy-Item $src (Join-Path $dir "SKILL.md") -Force
  Write-Host "installed -> $dir\SKILL.md"
}

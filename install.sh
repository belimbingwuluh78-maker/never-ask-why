#!/usr/bin/env sh
# Installs the never-ask-why skill for Claude Code and Codex (user level).
set -e
SRC="$(cd "$(dirname "$0")" && pwd)/skills/never-ask-why"
for dst in "$HOME/.claude/skills" "$HOME/.codex/skills" "$HOME/.agents/skills"; do
  mkdir -p "$dst/never-ask-why"
  cp "$SRC/SKILL.md" "$dst/never-ask-why/SKILL.md"
  echo "installed -> $dst/never-ask-why/SKILL.md"
done

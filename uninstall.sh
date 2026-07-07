#!/usr/bin/env bash
# Uninstall cursor-llm-council from ~/.cursor/
set -euo pipefail

SKILL_DEST="$HOME/.cursor/skills/llm-council"
AGENTS_DEST="$HOME/.cursor/agents"
CONFIG_PATH="$SKILL_DEST/council.config.yaml"
CONFIG_BACKUP="$HOME/.cursor/council.config.yaml.bak"

if [[ -f "$CONFIG_PATH" ]]; then
  cp "$CONFIG_PATH" "$CONFIG_BACKUP"
  echo "Backed up council.config.yaml to $CONFIG_BACKUP"
fi

echo "Removing skill from $SKILL_DEST ..."
rm -rf "$SKILL_DEST"

echo "Removing council agents from $AGENTS_DEST ..."
for f in devils-advocate architect pragmatist security supervisor product; do
  agent="$AGENTS_DEST/council-$f.md"
  if [[ -f "$agent" ]]; then
    rm "$agent"
    echo "  removed council-$f.md"
  fi
done

echo ""
echo "Uninstall complete."
echo "Note: Cursor may also ship built-in council-* subagent types — those are not removed."

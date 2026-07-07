#!/usr/bin/env bash
# Install cursor-llm-council skill and agents to ~/.cursor/
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SRC="$SCRIPT_DIR/skill"
AGENTS_SRC="$SCRIPT_DIR/agents"
SKILL_DEST="$HOME/.cursor/skills/llm-council"
AGENTS_DEST="$HOME/.cursor/agents"
FORCE=false

for arg in "$@"; do
  case "$arg" in
    --force) FORCE=true ;;
    -h|--help)
      echo "Usage: ./install.sh [--force]"
      echo "  Installs skill to ~/.cursor/skills/llm-council/"
      echo "  Installs agents to ~/.cursor/agents/"
      echo "  --force  Overwrite existing installation (lists skill files first)"
      exit 0
      ;;
  esac
done

if [[ -d "$SKILL_DEST" ]] && [[ "$FORCE" != true ]]; then
  echo "ERROR: $SKILL_DEST already exists."
  echo "Run with --force to overwrite, or ./uninstall.sh first."
  exit 1
fi

if [[ "$FORCE" == true ]] && [[ -d "$SKILL_DEST" ]]; then
  echo "Force install — overwriting skill files:"
  find "$SKILL_SRC" -type f | while read -r f; do
    echo "  skill/${f#$SKILL_SRC/}"
  done
fi

mkdir -p "$SKILL_DEST" "$AGENTS_DEST"

echo "Installing skill to $SKILL_DEST ..."
for f in "$SKILL_SRC"/*; do
  base="$(basename "$f")"
  if [[ -d "$f" ]]; then
    cp -R "$f" "$SKILL_DEST/$base"
  else
    cp "$f" "$SKILL_DEST/$base"
  fi
done

if [[ -f "$SKILL_SRC/config.example.yaml" ]] && [[ ! -f "$SKILL_DEST/council.config.yaml" ]]; then
  cp "$SKILL_SRC/config.example.yaml" "$SKILL_DEST/council.config.yaml"
  echo "Created council.config.yaml from example."
elif [[ -f "$SKILL_DEST/council.config.yaml" ]]; then
  echo "Preserved existing council.config.yaml"
fi

echo "Installing agents to $AGENTS_DEST ..."
for f in "$AGENTS_SRC"/council-*.md; do
  dest="$AGENTS_DEST/$(basename "$f")"
  if [[ -f "$dest" ]] && [[ "$FORCE" != true ]]; then
    echo "ERROR: $dest already exists. Use --force to overwrite."
    exit 1
  fi
  if [[ "$FORCE" == true ]] && [[ -f "$dest" ]]; then
    echo "  overwriting $(basename "$f")"
  else
    echo "  $(basename "$f")"
  fi
  cp "$f" "$dest"
done

echo ""
echo "Installed successfully."
echo ""
echo "Usage:  /council <your question>"
echo "Cost:   see ~/.cursor/skills/llm-council/cost-disclaimer.md"
echo "Limits: see ~/.cursor/skills/llm-council/limitations.md"
echo "Tests:  see docs/test-prompts.md in repo"
echo ""
echo "Add to your project .gitignore:"
echo "  .cursor/council-sessions/"
echo ""
echo "Name collision: installed agents/council-*.md are prompt libraries."
echo "Cursor may also expose built-in council-* subagent types — see docs/architecture.md"

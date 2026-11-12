#!/usr/bin/env bash
set -euo pipefail
# Link dot-file's global skills dir to this repo.
# Idempotent: re-runnable on fresh clones.
SRC="$HOME/skills"
DEST="$HOME/dot-file/.agents/skills"
if [ -L "$DEST" ]; then
  echo "exists: $DEST -> $(readlink "$DEST")"
  exit 0
fi
if [ -d "$DEST" ]; then
  echo "backing up $DEST to ${DEST}.bak.$(date +%Y%m%d-%H%M%S)"
  mv "$DEST" "${DEST}.bak.$(date +%Y%m%d-%H%M%S)"
fi
mkdir -p "$(dirname "$DEST")"
ln -s "$SRC" "$DEST"
echo "linked: $DEST -> $SRC"

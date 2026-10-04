#!/usr/bin/env bash
set -euo pipefail
BUILD_SCRIPT="${HOME}/Downloads/build_interactive_mbr.py"
OUT="${HOME}/Downloads/alokit-mbr-apr-sep-2026-presentation.html"
ROOT="$(cd "$(dirname "$0")" && pwd)"

if [[ -f "$BUILD_SCRIPT" ]]; then
  python3 "$BUILD_SCRIPT"
fi
cp "$OUT" "$ROOT/index.html"
echo "Updated $ROOT/index.html — commit and push to refresh the live site."

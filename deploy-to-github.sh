#!/usr/bin/env bash
# One-time: creates public repo, pushes main, enables GitHub Pages (Actions).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
REPO_NAME="${1:-alokit-mbr-deck}"
cd "$ROOT"

if ! gh auth status -h github.com &>/dev/null; then
  echo "Sign in to GitHub first:"
  echo "  gh auth login -h github.com -p https -w"
  exit 1
fi

if git remote get-url origin &>/dev/null; then
  echo "Remote origin already set — pushing main."
  git push -u origin main
else
  gh repo create "$REPO_NAME" --public \
    --description "Alokit MBR interactive deck (Apr–Sep 2026)" \
    --source=. --remote=origin --push
fi

OWNER="$(gh api user -q .login)"
echo "Enabling GitHub Pages (workflow deploy)…"
gh api -X PUT "repos/${OWNER}/${REPO_NAME}/pages" -f build_type=workflow 2>/dev/null || true

echo ""
echo "If Pages is not live yet: open"
echo "  https://github.com/${OWNER}/${REPO_NAME}/settings/pages"
echo "  → Build and deployment → Source: GitHub Actions"
echo ""
echo "After the workflow runs, your client URL will be:"
echo "  https://${OWNER}.github.io/${REPO_NAME}/"

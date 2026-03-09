#!/usr/bin/env bash
# Ensure all 13 Cloud Foundry doc set repos are on the master branch.
# Run from anywhere; resolves workspace as parent of docs-book-cloudfoundry.
# Usage: ./ensure-master.sh [ WORKSPACE_ROOT ]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOK_REPO="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT="${1:-$(cd "$BOOK_REPO/.." && pwd)}"

REPOS=(
  docs-book-cloudfoundry
  docs-buildpacks
  docs-bbr
  docs-deploying-cf
  docs-cf-admin
  docs-cf-cli
  docs-cloudfoundry-concepts
  docs-dev-guide
  docs-loggregator
  docs-services
  docs-uaa
  docs-credhub
  docs-running-cf
)

for repo in "${REPOS[@]}"; do
  path="$ROOT/$repo"
  [ -d "$path" ] || continue
  branch="$(git -C "$path" rev-parse --abbrev-ref HEAD 2>/dev/null)" || continue
  if [ "$branch" != "master" ]; then
    git -C "$path" checkout master
  fi
done

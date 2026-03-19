#!/usr/bin/env bash
# Print current branch and dirty state for each Cloud Foundry doc-set repo.
# Use to verify all repos are on master (see AGENTS.md).
#
# Usage: ./repo-status.sh [ WORKSPACE_ROOT ]
# Workspace root defaults to the parent of docs-book-cloudfoundry, or set DOCS_REPOS_PARENT.
#
# Exit codes: 0 = every present repo is on master; 1 = at least one present repo is not on master.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOK_REPO="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT="${1:-${DOCS_REPOS_PARENT:-$(cd "$BOOK_REPO/.." && pwd)}}"

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

bad=0

printf "%-28s %-18s %-10s %s\n" "REPO" "BRANCH" "WORKTREE" "MASTER?"
printf "%-28s %-18s %-10s %s\n" "----" "------" "--------" "-------"

for repo in "${REPOS[@]}"; do
  dir="$ROOT/$repo"
  if [[ ! -d "$dir/.git" ]]; then
    printf "%-28s %-18s %-10s %s\n" "$repo" "-" "-" "n/a (missing)"
    continue
  fi
  branch="$(git -C "$dir" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "?")"
  if git -C "$dir" diff --quiet 2>/dev/null && git -C "$dir" diff --cached --quiet 2>/dev/null; then
    state="clean"
  else
    state="dirty"
  fi
  if [[ "$branch" == "master" ]]; then
    master_ok="yes"
  else
    master_ok="NO"
    bad=1
  fi
  printf "%-28s %-18s %-10s %s\n" "$repo" "$branch" "$state" "$master_ok"
done

echo ""
if [[ "$bad" -eq 0 ]]; then
  echo "All present repos are on master."
else
  echo "One or more repos are not on master. Run scripts/ensure-master.sh to switch."
fi

exit "$bad"

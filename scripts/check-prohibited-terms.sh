#!/usr/bin/env bash
# Check for prohibited commercial terms in Cloud Foundry doc set (Tanzu, etc.).
# Uses only find + grep (standard on macOS and Git for Windows). No ripgrep required.
# Run from anywhere; resolves workspace as parent of docs-book-cloudfoundry.
# Exit code 0 = no matches (OK to commit); 1 = matches found (fix before commit).
# Usage: ./check-prohibited-terms.sh [ WORKSPACE_ROOT ]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOK_REPO="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT="${1:-$(cd "$BOOK_REPO/.." && pwd)}"

PATTERN='Tanzu|VMware Tanzu|TAS for VMs|Tanzu Application Service|Elastic Application Runtime|Tanzu Support Hub'
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

any_hit=0
for repo in "${REPOS[@]}"; do
  path="$ROOT/$repo"
  [ -d "$path" ] || continue
  while IFS= read -r f; do
    [ -f "$f" ] || continue
    if grep -qE "$PATTERN" "$f" 2>/dev/null; then
      any_hit=1
      grep -nE "$PATTERN" "$f" 2>/dev/null || true
    fi
  done < <(find "$path" -type f -name "*.html.md.erb" ! -path "*/archive/*" 2>/dev/null)
done
exit "$any_hit"

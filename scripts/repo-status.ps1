# Print current branch and dirty state for each Cloud Foundry doc-set repo.
# Use to verify all repos are on master (see AGENTS.md).
#
# Usage: .\repo-status.ps1 [ -WorkspaceRoot <path> ]
# Workspace root defaults to the parent of docs-book-cloudfoundry.
# You can set $env:DOCS_REPOS_PARENT instead of -WorkspaceRoot.
#
# Exit codes: 0 = every present repo is on master; 1 = at least one present repo is not on master.

param(
    [string]$WorkspaceRoot
)

# Use Continue so git warnings on stderr (e.g. LF/CRLF) do not abort the script on Windows.
$ErrorActionPreference = "Continue"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BookRepo = Split-Path -Parent $ScriptDir
if ($WorkspaceRoot) {
    $Root = $WorkspaceRoot
} elseif ($env:DOCS_REPOS_PARENT) {
    $Root = $env:DOCS_REPOS_PARENT
} else {
    $Root = Split-Path -Parent $BookRepo
}

$Repos = @(
    "docs-book-cloudfoundry",
    "docs-buildpacks",
    "docs-bbr",
    "docs-deploying-cf",
    "docs-cf-admin",
    "docs-cf-cli",
    "docs-cloudfoundry-concepts",
    "docs-dev-guide",
    "docs-loggregator",
    "docs-services",
    "docs-uaa",
    "docs-credhub",
    "docs-running-cf"
)

$bad = 0

"{0,-28} {1,-18} {2,-10} {3}" -f "REPO", "BRANCH", "WORKTREE", "MASTER?"
"{0,-28} {1,-18} {2,-10} {3}" -f "----", "------", "--------", "-------"

foreach ($repo in $Repos) {
    $dir = Join-Path $Root $repo
    $gitDir = Join-Path $dir ".git"
    if (-not (Test-Path $gitDir)) {
        "{0,-28} {1,-18} {2,-10} {3}" -f $repo, "-", "-", "n/a (missing)"
        continue
    }
    $branch = git -C $dir rev-parse --abbrev-ref HEAD 2>$null
    if ($LASTEXITCODE -ne 0) { $branch = "?" }
    git -C $dir diff --quiet 2>$null
    $diffOk = ($LASTEXITCODE -eq 0)
    git -C $dir diff --cached --quiet 2>$null
    $stagedOk = ($LASTEXITCODE -eq 0)
    if ($diffOk -and $stagedOk) {
        $state = "clean"
    } else {
        $state = "dirty"
    }
    if ($branch -eq "master") {
        $masterOk = "yes"
    } else {
        $masterOk = "NO"
        $bad = 1
    }
    "{0,-28} {1,-18} {2,-10} {3}" -f $repo, $branch, $state, $masterOk
}

Write-Host ""
if ($bad -eq 0) {
    Write-Host "All present repos are on master."
} else {
    Write-Host "One or more repos are not on master. Run scripts\ensure-master.ps1 to switch."
}

exit $bad

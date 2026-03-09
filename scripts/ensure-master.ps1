# Ensure all 13 Cloud Foundry doc set repos are on the master branch.
# Run from anywhere; resolves workspace as parent of docs-book-cloudfoundry.
# Usage: .\ensure-master.ps1 [ -WorkspaceRoot <path> ]

param(
    [string]$WorkspaceRoot
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BookRepo = Split-Path -Parent $ScriptDir
if ($WorkspaceRoot) {
    $Root = $WorkspaceRoot
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

foreach ($repo in $Repos) {
    $path = Join-Path $Root $repo
    if (-not (Test-Path $path)) { continue }
    $branch = git -C $path rev-parse --abbrev-ref HEAD 2>$null
    if ($LASTEXITCODE -ne 0) { continue }
    if ($branch -ne "master") {
        git -C $path checkout master
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Failed to checkout master in $repo"
        }
    }
}

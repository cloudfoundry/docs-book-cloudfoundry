# Check for prohibited commercial terms in Cloud Foundry doc set (Tanzu, etc.).
# Uses only built-in PowerShell; no external tools required.
# Run from anywhere; resolves workspace as parent of docs-book-cloudfoundry.
# Exit code 0 = no matches (OK to commit); 1 = matches found (fix before commit).
# Usage: .\check-prohibited-terms.ps1 [ -WorkspaceRoot <path> ]

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

$Pattern = 'Tanzu|VMware Tanzu|TAS for VMs|Tanzu Application Service|Elastic Application Runtime|Tanzu Support Hub'
$ContentRepos = @(
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

$anyHit = $false
foreach ($repo in $ContentRepos) {
    $path = Join-Path $Root $repo
    if (-not (Test-Path $path -PathType Container)) { continue }
    $files = Get-ChildItem -Path $path -Recurse -Filter "*.html.md.erb" -File -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -notmatch '[/\\]archive[/\\]' }
    foreach ($f in $files) {
        $matches = Select-String -Path $f.FullName -Pattern $Pattern -AllMatches -ErrorAction SilentlyContinue
        if ($matches) {
            $anyHit = $true
            $matches | ForEach-Object { "$($_.Path):$($_.LineNumber): $($_.Line.Trim())" }
        }
    }
}
if ($anyHit) {
    exit 1
}
exit 0

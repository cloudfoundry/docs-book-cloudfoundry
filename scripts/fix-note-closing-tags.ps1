# Fix inline closing </p> tags in note blocks across Cloud Foundry doc set repos.
# Moves any </p> that appears at the end of a content line (instead of its own line)
# to a new standalone line, preserving the note's indentation.
#
# Only processes <p class="note..."> blocks. Does NOT touch inner <p> elements
# inside <div class="note"> wrappers.
#
# Exit code 0 = success.
#
# Usage:
#   .\fix-note-closing-tags.ps1 [ -WorkspaceRoot <path> ] [ -WhatIf ]
#
# -WhatIf   Print what would change without writing any files.

param(
    [string]$WorkspaceRoot,
    [switch]$WhatIf
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BookRepo  = Split-Path -Parent $ScriptDir
if ($WorkspaceRoot) {
    $Root = $WorkspaceRoot
} else {
    $Root = Split-Path -Parent $BookRepo
}

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

$ContentRepos = @(
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

$totalFiles = 0
$totalFixes  = 0

foreach ($repo in $ContentRepos) {
    $repoPath = Join-Path $Root $repo
    if (-not (Test-Path $repoPath -PathType Container)) { continue }

    $files = Get-ChildItem -Path $repoPath -Recurse -Filter "*.html.md.erb" -File -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -notmatch '[/\\]archive[/\\]' }

    foreach ($f in $files) {
        $lines     = [System.IO.File]::ReadAllLines($f.FullName, $Utf8NoBom)
        $result    = [System.Collections.Generic.List[string]]::new()
        $inPNote   = $false
        $noteIndent = ''
        $fileFixes  = 0
        $changed    = $false

        for ($i = 0; $i -lt $lines.Count; $i++) {
            $line = $lines[$i]

            # Detect opening of a <p class="note..."> block (not div).
            # Capture leading indent so the closing tag can match it.
            if ($line -match '^([ \t]*)(<p[^>]*class="note[^"]*"[^>]*>)') {
                $inPNote    = $true
                $noteIndent = $Matches[1]
            }

            # While inside a <p class="note"> block, detect a line whose last
            # non-whitespace token is </p> — that is the note's inline closer.
            # Skip lines that are ONLY </p> (already correct) and the opening
            # tag line itself (which may end with > rather than </p>).
            if ($inPNote -and
                ($line -match '</p>\s*$') -and
                ($line -notmatch '^\s*</p>\s*$') -and
                ($line -notmatch '<p[^>]*class="note[^"]*"[^>]*></p>')) {

                # Remove the trailing </p> (and any trailing whitespace after it)
                $stripped = $line -replace '</p>\s*$', ''
                $result.Add($stripped)
                $result.Add($noteIndent + '</p>')
                $inPNote = $false
                $fileFixes++
                $changed = $true
                continue
            }

            # Detect a standalone </p> line (already correct) — just clear the flag.
            if ($inPNote -and $line -match '^\s*</p>\s*$') {
                $inPNote = $false
            }

            $result.Add($line)
        }

        if ($changed) {
            $totalFiles++
            $totalFixes += $fileFixes
            $relPath = $f.FullName.Substring($Root.Length + 1)
            if ($WhatIf) {
                Write-Host "[WhatIf] $relPath  ($fileFixes fix(es))"
            } else {
                # WriteAllLines writes each line then a newline; to avoid adding a
                # trailing newline that wasn't there before, use WriteAllText.
                $newContent = $result -join "`n"
                # Preserve a trailing newline if the original had one.
                if ($lines.Count -gt 0 -and $lines[-1] -eq '') {
                    # already ends with newline — -join adds \n between items so
                    # the last item being '' means the string ends with \n.
                }
                [System.IO.File]::WriteAllText($f.FullName, $newContent, $Utf8NoBom)
                Write-Host "  fixed  $relPath  ($fileFixes fix(es))"
            }
        }
    }
}

Write-Host ""
if ($WhatIf) {
    Write-Host "[WhatIf] Would fix $totalFixes closing tag(s) across $totalFiles file(s). Run without -WhatIf to apply."
} else {
    Write-Host "Done. Fixed $totalFixes closing tag(s) across $totalFiles file(s)."
}

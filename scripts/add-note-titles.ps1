# Add note__title spans to every note block across Cloud Foundry doc set repos.
# Makes Note / Important / Caution visually distinct when rendered.
# Skips files in archive/ subdirectories and any file that already has the span.
# Exit code 0 = success; 1 = error.
#
# Usage:
#   .\add-note-titles.ps1 [ -WorkspaceRoot <path> ] [ -WhatIf ]
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

# UTF-8 without BOM — preserves the encoding used across all doc repos.
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# Content repos that carry note blocks. Book repo has no note content.
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

# Process most specific classes first so the plain "note" pass cannot
# accidentally match "note important" or "note caution" mid-replace.
$NoteDefs = @(
    @{ Class = 'note caution';   Title = 'Caution' }
    @{ Class = 'note important'; Title = 'Important' }
    @{ Class = 'note';           Title = 'Note' }
)

$totalFiles      = 0
$totalInsertions = 0

foreach ($repo in $ContentRepos) {
    $repoPath = Join-Path $Root $repo
    if (-not (Test-Path $repoPath -PathType Container)) {
        Write-Host "  [skip] $repo not found at $repoPath"
        continue
    }

    $files = Get-ChildItem -Path $repoPath -Recurse -Filter "*.html.md.erb" -File -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -notmatch '[/\\]archive[/\\]' }

    foreach ($f in $files) {
        $content  = [System.IO.File]::ReadAllText($f.FullName, $Utf8NoBom)
        $original = $content
        $fileInsertions = 0

        foreach ($def in $NoteDefs) {
            $title = $def.Title

            # Build pattern using string concatenation so literal " characters
            # inside the regex do not need any PowerShell escape sequence.
            #
            # Pattern breakdown:
            #   (?m)            — multiline: ^ matches start of each line
            #   (^[ \t]*)       — Group 1: leading indent of the opening tag line
            #   (<(p|div)...>)  — Group 2: the opening note tag (p or div)
            #   (?:[ \t]*\r?\n)?— optionally consume trailing whitespace + newline
            #   (?![ \t]*(?:\r?\n[ \t]*)?<span class="note__title">)
            #                   — negative lookahead: skip if span already present
            #                     on the same line OR on the very next line.
            #                     The (?:\r?\n[ \t]*)? arm handles the backtracking
            #                     case where the optional newline above was not
            #                     consumed — without it the lookahead checks at \n
            #                     and misses a span that is one line down.
            $escapedClass = [regex]::Escape($def.Class)
            $pattern = '(?m)(^[ \t]*)(<(?:p|div)[^>]*class="' + $escapedClass + '"[^>]*>)(?:[ \t]*\r?\n)?(?![ \t]*(?:\r?\n[ \t]*)?<span class="note__title">)'

            $matches = [regex]::Matches($content, $pattern)
            $count   = $matches.Count
            if ($count -eq 0) { continue }

            $spanLine = '<span class="note__title"><strong>' + $title + '</strong></span>'

            $content = [regex]::Replace($content, $pattern, {
                param($m)
                $indent = $m.Groups[1].Value
                $tag    = $m.Groups[2].Value
                # Always use LF for the inserted newlines; the file's own line
                # endings are preserved elsewhere.
                return $indent + $tag + "`n" + $indent + $spanLine + "`n"
            })

            $fileInsertions += $count
        }

        if ($fileInsertions -gt 0) {
            $totalFiles      += 1
            $totalInsertions += $fileInsertions
            $relPath = $f.FullName.Substring($Root.Length + 1)
            if ($WhatIf) {
                Write-Host "[WhatIf] $relPath  ($fileInsertions insertion(s))"
            } else {
                [System.IO.File]::WriteAllText($f.FullName, $content, $Utf8NoBom)
                Write-Host "  updated  $relPath  ($fileInsertions insertion(s))"
            }
        }
    }
}

Write-Host ""
if ($WhatIf) {
    Write-Host "[WhatIf] Would insert $totalInsertions span(s) across $totalFiles file(s). Run without -WhatIf to apply."
} else {
    Write-Host "Done. Inserted $totalInsertions span(s) across $totalFiles file(s)."
}

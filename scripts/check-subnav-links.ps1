# Check that every link in subnav topics goes to a live page (internal doc set or on the web).
# Reuses the same subnav/topic list as check-subnav-topic-syntax.ps1.
# Exit 0 = all links OK; 1 = one or more broken links.
# Usage: .\check-subnav-links.ps1 [ -WorkspaceRoot <path> ] [ -SkipExternal ]

param(
    [string]$WorkspaceRoot,
    [switch]$SkipExternal
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BookRepo = Split-Path -Parent $ScriptDir
if ($WorkspaceRoot) {
    $Root = $WorkspaceRoot
} else {
    $Root = Split-Path -Parent $BookRepo
}

. (Join-Path $ScriptDir '_subnav-topic-paths.ps1') -WorkspaceRoot $Root

$topicPaths = Get-SubnavTopicFilePaths
$broken = @()
$checkedUrls = @{}  # url -> $true if OK, so we don't re-check same URL

function Get-LinksFromFile {
    param([string]$FilePath)
    if (-not (Test-Path $FilePath)) { return @() }
    $content = Get-Content -Path $FilePath -Raw -Encoding UTF8
    $urls = @()
    # HTML href="..."
    [regex]::Matches($content, 'href="([^"]+)"') | ForEach-Object {
        $urls += $_.Groups[1].Value.Trim()
    }
    # Markdown ](url) or ](url "title")
    [regex]::Matches($content, '\]\(([^)]+)\)') | ForEach-Object {
        $s = $_.Groups[1].Value.Trim()
        if ($s -match '^([^\s"]+)(?:\s+"[^"]*")?$') { $urls += $Matches[1].Trim() }
    }
    return $urls | Select-Object -Unique
}

function Test-ExternalLink {
    param([string]$Url)
    try {
        $r = Invoke-WebRequest -Uri $Url -Method Head -UseBasicParsing -TimeoutSec 15 -MaximumRedirection 5 -ErrorAction Stop
        return ($r.StatusCode -ge 200 -and $r.StatusCode -lt 400)
    } catch {
        try {
            $r = Invoke-WebRequest -Uri $Url -Method Get -UseBasicParsing -TimeoutSec 15 -MaximumRedirection 5 -ErrorAction Stop
            return ($r.StatusCode -ge 200 -and $r.StatusCode -lt 400)
        } catch {
            return $false
        }
    }
}

foreach ($fullPath in $topicPaths) {
    $links = Get-LinksFromFile -FilePath $fullPath
    $shortPath = $fullPath.Replace($Root + [IO.Path]::DirectorySeparatorChar, '')
    foreach ($url in $links) {
        $urlTrim = $url.Trim()
        if ([string]::IsNullOrWhiteSpace($urlTrim)) { continue }
        if ($urlTrim.StartsWith('#') -or $urlTrim.StartsWith('mailto:') -or $urlTrim.StartsWith('javascript:')) { continue }
        # Strip anchor for checking
        $urlNoAnchor = $urlTrim.Split('#')[0].Trim()
        if ([string]::IsNullOrWhiteSpace($urlNoAnchor)) { continue }

        $cacheKey = $urlNoAnchor
        if ($checkedUrls.ContainsKey($cacheKey)) {
            if (-not $checkedUrls[$cacheKey]) { $broken += "${shortPath} : $urlTrim" }
            continue
        }

        # Internal (our doc set): starts with /
        if ($urlTrim.StartsWith('/')) {
            $fullPathForLink = Resolve-InternalPathToFile -InternalPath $urlTrim
            if ($null -eq $fullPathForLink) {
                $checkedUrls[$cacheKey] = $true
                continue
            }
            $ok = Test-Path $fullPathForLink
            $checkedUrls[$cacheKey] = $ok
            if (-not $ok) {
                $broken += "${shortPath} : $urlTrim (internal file not found)"
            }
            continue
        }

        # External
        if ($urlTrim -match '^https?://') {
            if ($SkipExternal) {
                $checkedUrls[$cacheKey] = $true
                continue
            }
            $ok = Test-ExternalLink -Url $urlTrim
            $checkedUrls[$cacheKey] = $ok
            if (-not $ok) {
                $broken += "${shortPath} : $urlTrim (external returned error or timeout)"
            }
            continue
        }

        # Relative link (e.g. ./images/foo.png or ../other.html or ../devguide/...) - resolve from current file
        $dir = [IO.Path]::GetDirectoryName($fullPath)
        $resolved = [IO.Path]::GetFullPath((Join-Path $dir $urlNoAnchor))
        $ok = $false
        if ($resolved.StartsWith($Root)) {
            $ok = Test-Path $resolved
            if (-not $ok -and $resolved.EndsWith('.html')) {
                $resolvedErb = $resolved -replace '\.html$', '.html.md.erb'
                $ok = Test-Path $resolvedErb
            }
        }
        # If not found, try as internal path (e.g. ../../devguide/foo.html or ./../../../devguide/foo.html -> /devguide/foo.html)
        if (-not $ok) {
            $normalized = $urlNoAnchor -replace '\\','/'
            while (($normalized -match '^\.\./') -or ($normalized -match '^\./')) {
                $normalized = $normalized -replace '^\.\./','' -replace '^\./',''
            }
            $internalPath = '/' + $normalized
            $internalFile = Resolve-InternalPathToFile -InternalPath $internalPath
            if ($null -ne $internalFile) {
                $ok = Test-Path $internalFile
            }
        }
        $checkedUrls[$cacheKey] = $ok
        if (-not $ok) {
            $broken += "${shortPath} : $urlTrim (relative/file not found)"
        }
    }
}

if ($broken.Count -gt 0) {
    Write-Host "Broken links ($($broken.Count)):"
    $broken | ForEach-Object { Write-Host "  $_" }
    exit 1
}
Write-Host "All links in subnav topics are OK (checked $($topicPaths.Count) files)."
exit 0

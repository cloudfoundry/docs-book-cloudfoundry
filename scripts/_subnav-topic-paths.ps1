# Shared: resolve workspace root, parse subnav, map internal hrefs to (repo, relative path).
# Dot-source from check-subnav-topic-syntax.ps1 and check-subnav-links.ps1.
# Do not run directly.

param(
    [string]$WorkspaceRoot
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BookRepo = Split-Path -Parent $ScriptDir
if ($WorkspaceRoot) {
    $script:Root = $WorkspaceRoot
} else {
    $script:Root = Split-Path -Parent $BookRepo
}

# TOC path segment -> content repo name (from AGENTS.md)
$script:SegmentToRepo = @{
    'concepts'    = 'docs-cloudfoundry-concepts'
    'buildpacks'   = 'docs-buildpacks'
    'bbr'          = 'docs-bbr'
    'deploying'    = 'docs-deploying-cf'
    'adminguide'   = 'docs-cf-admin'
    'cf-cli'       = 'docs-cf-cli'
    'devguide'     = 'docs-dev-guide'
    'loggregator'  = 'docs-loggregator'
    'services'     = 'docs-services'
    'uaa'          = 'docs-uaa'
    'credhub'      = 'docs-credhub'
    'running'      = 'docs-running-cf'
}

function Get-SubnavTopicFilePaths {
    # Returns array of full paths to .html.md.erb topic files (one per subnav internal href, deduped).
    # Paths under archive/ are excluded. Missing files are still included (caller reports error).
    $subnavPath = Join-Path $BookRepo 'master_middleman\source\subnavs\_cf-subnav.erb'
    if (-not (Test-Path $subnavPath)) {
        Write-Error "Subnav not found: $subnavPath"
    }
    $content = Get-Content -Path $subnavPath -Raw -Encoding UTF8
    $hrefs = [regex]::Matches($content, 'href="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
    $internal = $hrefs | Where-Object {
        $_ -match '^/' -and $_ -notmatch '^https?://'
    } | Select-Object -Unique
    $seen = @{}
    $paths = @()
    foreach ($href in $internal) {
        $path = $href.TrimStart('/')
        if ([string]::IsNullOrWhiteSpace($path)) { $path = 'index.html' }
        elseif ($path -match '/$') { $path = $path.TrimEnd('/') + '/index.html' }
        elseif ($path -notmatch '\.html$') { $path = $path + '/index.html' }
        if ($path -match 'archive/') { continue }
        $segments = $path -split '/'
        $segment = $segments[0]
        $repo = $SegmentToRepo[$segment]
        if (-not $repo) { continue }
        # Relative path inside repo: drop first segment (the TOC segment), then .html -> .html.md.erb
        if ($segments.Count -eq 1) {
            $relPath = $path -replace '\.html$', '.html.md.erb'
        } else {
            $rest = ($segments[1..($segments.Count-1)] -join '/')
            $relPath = $rest -replace '\.html$', '.html.md.erb'
        }
        $key = "$repo|$relPath"
        if ($seen[$key]) { continue }
        $seen[$key] = $true
        $fullPath = Join-Path $Root (Join-Path $repo $relPath)
        $paths += $fullPath
    }
    return $paths
}

function Get-WorkspaceRoot { return $script:Root }
function Get-BookRepo { return $BookRepo }

function Resolve-InternalPathToFile {
    # Given an internal path like /concepts/overview.html or /running/managing-cf/logging.html,
    # returns the full path to the source .html.md.erb file, or $null if segment not in doc set.
    param([string]$InternalPath)
    $path = $InternalPath.TrimStart('/').Split('#')[0].TrimEnd('/')
    if ([string]::IsNullOrWhiteSpace($path)) { $path = 'index.html' }
    elseif ($path -match '/$') { $path = $path + 'index.html' }
    elseif ($path -notmatch '\.html$') { $path = $path + '/index.html' }
    $segments = $path -split '/'
    $segment = $segments[0]
    $repo = $SegmentToRepo[$segment]
    if (-not $repo) { return $null }
    if ($segments.Count -eq 1) {
        $relPath = $path -replace '\.html$', '.html.md.erb'
    } else {
        $rest = ($segments[1..($segments.Count-1)] -join '/')
        $relPath = $rest -replace '\.html$', '.html.md.erb'
    }
    $fullPath = Join-Path $script:Root (Join-Path $repo $relPath)
    return $fullPath
}

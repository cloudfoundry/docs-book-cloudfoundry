# Check syntax (ERB, Markdown, HTML, front matter) of every topic in the CF subnav.
# Run from anywhere; resolves workspace as parent of docs-book-cloudfoundry.
# Ensures all content repos are on master, then checks each subnav topic file.
# Exit 0 = all pass; 1 = failures or missing files.
# Usage: .\check-subnav-topic-syntax.ps1 [ -WorkspaceRoot <path> ] [ -SkipMarkdown ] [ -SkipHtml ]
# HTML check is heuristic (tag balance); use -SkipHtml if you get false positives from ERB/Markdown.

param(
    [string]$WorkspaceRoot,
    [switch]$SkipMarkdown,
    [switch]$SkipHtml
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

# Ensure master
$ensureMaster = Join-Path $ScriptDir 'ensure-master.ps1'
& $ensureMaster -WorkspaceRoot $Root 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Error "Not all repos are on master. Run ensure-master.ps1 first or fix branch state."
}

$topicPaths = Get-SubnavTopicFilePaths
$missing = @()
$errors = @()

# Helpers for syntax checks
function Test-ErbSyntax {
    param([string]$FilePath)
    $ruby = Get-Command ruby -ErrorAction SilentlyContinue
    if (-not $ruby) {
        return @{ ok = $true; msg = "Ruby not found; ERB check skipped" }
    }
    $code = "require 'erb'; puts ERB.new(File.read(ARGV[0])).src"
    $erbOut = & ruby -r erb -e $code $FilePath 2>&1
    if ($LASTEXITCODE -ne 0) {
        return @{ ok = $false; msg = "ERB parse failed: $erbOut" }
    }
    $erbOut | ruby -c 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        $errMsg = $erbOut | ruby -c 2>&1
        return @{ ok = $false; msg = "ERB/Ruby syntax: $errMsg" }
    }
    return @{ ok = $true }
}

function Test-FrontMatter {
    param([string]$FilePath)
    $lines = Get-Content -Path $FilePath -Encoding UTF8 -TotalCount 100
    if ($lines.Count -eq 0 -or $lines[0] -ne '---') {
        return @{ ok = $true }
    }
    $i = 1
    $fmLines = @()
    while ($i -lt $lines.Count -and $lines[$i] -ne '---') {
        $fmLines += $lines[$i]
        $i++
    }
    if ($i -ge $lines.Count) {
        return @{ ok = $false; msg = "Front matter not closed (no closing ---)" }
    }
    $yamlStr = $fmLines -join "`n"
    if ([string]::IsNullOrWhiteSpace($yamlStr)) {
        return @{ ok = $true }
    }
    $ruby = Get-Command ruby -ErrorAction SilentlyContinue
    if (-not $ruby) {
        return @{ ok = $true; msg = "Ruby not found; YAML check skipped" }
    }
    $encoded = [System.Text.Encoding]::UTF8.GetBytes($yamlStr)
    $base64 = [Convert]::ToBase64String($encoded)
    $err = & ruby -e "require 'yaml'; require 'base64'; YAML.load(Base64.decode64(ARGV[0]))" $base64 2>&1
    if ($LASTEXITCODE -ne 0) {
        return @{ ok = $false; msg = "Invalid YAML front matter: $err" }
    }
    return @{ ok = $true }
}

function Test-HtmlBalance {
    param([string]$FilePath)
    $content = Get-Content -Path $FilePath -Raw -Encoding UTF8
    # Strip ERB (including multiline) so we only count HTML
    $content = [regex]::Replace($content, '(?s)<%.*?%>', ' ')
    $tags = @('table', 'thead', 'tbody', 'tr', 'td', 'th', 'div', 'span', 'p', 'ul', 'ol', 'li')
    foreach ($tag in $tags) {
        # Opening: <tag> or <tag ... (with space or >)
        $open = ([regex]::Matches($content, "<$tag(?:\s|>)")).Count
        $close = ([regex]::Matches($content, "</$tag>")).Count
        if ($open -ne $close) {
            return @{ ok = $false; msg = "HTML tag imbalance: <$tag> open=$open close=$close" }
        }
    }
    return @{ ok = $true }
}

function Test-MarkdownLint {
    param([string]$FilePath)
    if ($SkipMarkdown) { return @{ ok = $true } }
    $configPath = Join-Path $BookRepo '.markdownlint.yaml'
    $configArg = if (Test-Path $configPath) { @('--config', $configPath) } else { @() }
    try {
        $out = & npx --yes markdownlint-cli2 $FilePath @configArg 2>&1
        if ($LASTEXITCODE -ne 0) {
            return @{ ok = $false; msg = ($out | Out-String).Trim() }
        }
    } catch {
        return @{ ok = $true; msg = "Markdown lint skipped (npx/markdownlint-cli2 not available)" }
    }
    return @{ ok = $true }
}

foreach ($fullPath in $topicPaths) {
    if (-not (Test-Path $fullPath)) {
        $missing += $fullPath
        continue
    }
    # ERB
    $r = Test-ErbSyntax -FilePath $fullPath
    if (-not $r.ok) {
        $errors += "$fullPath : ERB: $($r.msg)"
    }
    # Front matter
    $r = Test-FrontMatter -FilePath $fullPath
    if (-not $r.ok) {
        $errors += "$fullPath : Front matter: $($r.msg)"
    }
    # HTML balance (optional skip)
    if (-not $SkipHtml) {
        $r = Test-HtmlBalance -FilePath $fullPath
        if (-not $r.ok) {
            $errors += "$fullPath : HTML: $($r.msg)"
        }
    }
    # Markdown (optional skip)
    $r = Test-MarkdownLint -FilePath $fullPath
    if (-not $r.ok) {
        $errors += "$fullPath : Markdown: $($r.msg)"
    }
}

if ($missing.Count -gt 0) {
    Write-Host "Missing topic files (subnav points to non-existent file):"
    $missing | ForEach-Object { Write-Host "  $_" }
}
if ($errors.Count -gt 0) {
    Write-Host "Syntax errors:"
    $errors | ForEach-Object { Write-Host "  $_" }
}

$totalFail = $missing.Count + $errors.Count
if ($totalFail -gt 0) {
    exit 1
}
Write-Host "All subnav topics passed syntax checks ($($topicPaths.Count) files)."
exit 0

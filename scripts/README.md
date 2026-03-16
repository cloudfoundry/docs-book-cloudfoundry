# Scripts for the Cloud Foundry doc set

This directory holds helper scripts for working across the multi-repo Cloud Foundry documentation. Use them to keep branches consistent and to avoid committing prohibited commercial terminology.

## Scripts

### ensure-master

Puts every doc set repo on the `master` branch. Any repo not already on `master` is switched with `git checkout master`.

- **When to use:** At the start of a writing or editing session, or before making changes in multiple repos. The book and all content repos are maintained on `master`.
- **PowerShell:** `.\ensure-master.ps1` or `.\ensure-master.ps1 -WorkspaceRoot "C:\path\to\workspace"`
- **Bash:** `./ensure-master.sh` or `./ensure-master.sh /path/to/workspace`

If you don’t pass a workspace root, the script assumes the 13 repos live in the parent directory of `docs-book-cloudfoundry` (e.g. `Workspace/docs-book-cloudfoundry`, `Workspace/docs-buildpacks`, …).

### check-prohibited-terms

Searches all content repos for prohibited commercial terms (e.g. Tanzu, Tanzu Application Service, Tanzu Support Hub). Matches are limited to `*.html.md.erb` and exclude `archive/`.

- **When to use:** Before committing. Fix or remove any matches that are not inside `vars.platform_code == 'PCF'` gated blocks.
- **PowerShell:** `.\check-prohibited-terms.ps1` or `.\check-prohibited-terms.ps1 -WorkspaceRoot "C:\path\to\workspace"`
- **Bash:** `./check-prohibited-terms.sh` or `./check-prohibited-terms.sh /path/to/workspace`
- **Exit codes:** `0` = no matches (OK to commit); `1` = matches found (fix before commit).

### check-subnav-topic-syntax

Checks ERB, Markdown, HTML, and YAML front matter for every topic that appears in the subnav. Ensures all content repos are on `master`, then runs syntax checks on each topic file so pages display correctly.

- **When to use:** Periodically (e.g. every 6 months) or after large doc changes. Run from the book repo.
- **PowerShell:** `.\check-subnav-topic-syntax.ps1` or `.\check-subnav-topic-syntax.ps1 -WorkspaceRoot "C:\path\to\workspace"`
- **Options:** `-SkipMarkdown` skips the Markdown linter; `-SkipHtml` skips the heuristic HTML tag-balance check (use if you get false positives).
- **Exit codes:** `0` = all pass; `1` = missing files or syntax errors.
- **Requires:** Ruby (for ERB and front-matter checks). Optional: Node/npx and `markdownlint-cli2` for Markdown; if missing, Markdown check is skipped. A permissive `.markdownlint.yaml` in the book repo is used when present.

The script uses the same topic list as the link checker (see below), from `master_middleman/source/subnavs/_cf-subnav.erb`. A helper script `_subnav-topic-paths.ps1` is dot-sourced to resolve subnav hrefs to file paths; do not run it directly.

### check-subnav-links

Checks that every link in the subnav topics goes to a live page: internal links (within the doc set) are resolved to topic files and checked for existence; external URLs can be checked with HTTP HEAD/GET.

- **When to use:** Periodically (e.g. every 6 months) or before a release. Run from the book repo.
- **PowerShell:** `.\check-subnav-links.ps1` or `.\check-subnav-links.ps1 -WorkspaceRoot "C:\path\to\workspace"`
- **Options:** `-SkipExternal` skips checking external (http/https) URLs.
- **Exit codes:** `0` = all links OK; `1` = one or more broken links (internal file missing or external returned error).
- **Internal links:** Relative links (e.g. `../devguide/foo.html`) and absolute internal paths (e.g. `/concepts/overview.html`) are normalized and resolved to the corresponding `.html.md.erb` file in the correct repo.

Uses the same `_subnav-topic-paths.ps1` helper and topic list as the syntax script.

**No extra installs:** The PowerShell scripts use only built-in cmdlets. The Bash scripts use `find` and `grep`, which are standard on macOS and available in Git for Windows or WSL on Windows. Use the `.ps1` scripts on Windows (PowerShell) and the `.sh` scripts on macOS (or in Bash on Windows). The repo’s `.gitattributes` keeps `.sh` files in LF line endings so they run correctly everywhere.

## Rules and config for writers

- **AGENTS.md** (repo root) — Main guide for the doc set: repo list, branch policy, TOC and subnav conventions, prohibited terms table, cross-repo workflows, and commit message format (including AI disclosure). Writers and tooling should follow this.
- **.cursor/rules/** — Cursor/editor rules that reference these scripts and the same conventions (e.g. run `ensure-master` before editing content repos, use `/buildpacks/`, `/adminguide/`, etc. for links).

If you’re new to the repo, read **AGENTS.md** first, then use these scripts as needed when working across repos or before committing.

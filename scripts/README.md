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

**No extra installs:** The PowerShell scripts use only built-in cmdlets. The Bash scripts use `find` and `grep`, which are standard on macOS and available in Git for Windows or WSL on Windows. Use the `.ps1` scripts on Windows (PowerShell) and the `.sh` scripts on macOS (or in Bash on Windows). The repo’s `.gitattributes` keeps `.sh` files in LF line endings so they run correctly everywhere.

## Rules and config for writers

- **AGENTS.md** (repo root) — Main guide for the doc set: repo list, branch policy, TOC and subnav conventions, prohibited terms table, cross-repo workflows, and commit message format (including AI disclosure). Writers and tooling should follow this.
- **.cursor/rules/** — Cursor/editor rules that reference these scripts and the same conventions (e.g. run `ensure-master` before editing content repos, use `/buildpacks/`, `/adminguide/`, etc. for links).

If you’re new to the repo, read **AGENTS.md** first, then use these scripts as needed when working across repos or before committing.

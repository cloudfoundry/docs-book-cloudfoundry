@AGENTS.md

## Start of every task

Before any file read, plan, or edit, run the ensure-master script to put every doc-set repo on the `master` branch:

- PowerShell: `scripts/ensure-master.ps1`
- Bash: `scripts/ensure-master.sh`

Do not read or edit any file until every affected repo is confirmed on `master`.

## Before committing

Run the prohibited-terms check across all content repos:

- PowerShell: `scripts/check-prohibited-terms.ps1`
- Bash: `scripts/check-prohibited-terms.sh`

Exit 0 = clean. Exit 1 = fix matches before committing.

## Merging PRs

When merging a docs PR, check whether the PR description, commit messages, or linked issues reference a related code repository (e.g. `cloudfoundry/<repo-name>` on GitHub). If a code repo or PR is identified:

1. Fetch the linked code changes using the GitHub tools.
2. Check whether the docs text accurately reflects those changes.
3. Flag any discrepancies to the user before merging.

If no code repo is referenced, proceed with the merge normally.

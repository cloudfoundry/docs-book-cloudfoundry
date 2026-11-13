# Research

This directory holds the evidence that RFCs and ADRs cite: requirements, evaluations of tools and formats, and proofs of concept. Research describes what was found and makes no choice. The choice is made in an [RFC](../rfcs/README.md) or an [ADR](../adrs/README.md).

## Structure

Each research topic gets its own directory, `docs/research/<topic>/`, with a `README.md` that states the question and lists its parts. The layout follows [cf-docs-rfc-proposal](https://github.com/norman-abramovitz/cf-docs-rfc-proposal/tree/04fd741a104bed100f39fea77fcd2324e49c846f), the research for modernizing the documentation stack ([community RFC #1642](https://github.com/cloudfoundry/community/pull/1642)). A topic uses the parts it needs:

| Part | Contains |
|------|----------|
| `README.md` | The question, the background, and where to start reading |
| `requirements/` | What the Docs Working Group is looking for. Each requirement has an ID and a short phrase (for example, "R-03 column widths as hints") and a status: `proposed` (ready to discuss) or `open` (waiting on a named decision). Requirements say what is needed, not which tool or format provides it. |
| `tooling/` | The tools and formats evaluated, how existing pages convert into them, and the extensions each needs |
| `concepts/` | The work done one documentation concept at a time (tables, headings, notes, code blocks, and so on), with one directory per concept holding its source pages, the converted versions, checks, and results |
| `poc/` | Proof-of-concept results: what each tool built from real pages, next to the page as published today |

## Conventions

- Each document starts with a status line, such as `Status: draft, incomplete — covers what is known as of YYYY-MM-DD`.
- Facts about a repository link to the source, pinned to a commit, rather than to a README that can go stale.
- Evidence is kept neutral. A position of the Docs Working Group is labelled as one.
- Requirements are cited by ID and short phrase.
- Terms are defined where they are first used, and added to the [glossary](../glossary/README.md) when they are used across documents.

## Contents

| Topic | Question | Status |
|-------|----------|--------|

# Architecture Decision Records

This directory contains Architecture Decision Records (ADRs) for significant decisions the Docs Working Group makes about creating and publishing Cloud Foundry documentation across all of its repositories: content authoring and styling, organization and navigation, the book and the content repositories, templates, and the build and publishing tooling.

## What is an ADR?

An Architecture Decision Record captures a significant decision, along with its context and consequences. ADRs help:

- **Onboard new contributors** by explaining why the documentation is built a certain way
- **Prevent re-litigation** of decisions that have already been thoroughly considered
- **Document trade-offs** that were evaluated
- **Guide future decisions** by establishing precedent and principles

An ADR records a decision. A proposal that needs discussion before the Docs Working Group decides goes in an [RFC](../rfcs/README.md) first. An accepted RFC can lead to one or more ADRs.

## ADR Index

| ADR | Title | Status | Date |
|-----|-------|--------|------|

## ADR Template

```markdown
# ADR-NNN: Title

## Status
Proposed | Accepted | Superseded by ADR-XXX | Deprecated

## Date
YYYY-MM-DD

## Context
What is the issue that is motivating this decision or change?

## Decision
What is the change that we're proposing or doing?

## Consequences
What becomes easier or more difficult to do because of this change?

## Alternatives Considered
What other options were evaluated, and why were they rejected?
```

## Contributing

When making a significant change to how Cloud Foundry documentation is created, styled, organized, or published:

1. Create a new ADR named `ADR-NNN-<short-title>.md`, following the template.
1. Number it sequentially, starting from `ADR-000`.
1. Add it to the index above.
1. Open a pull request. The ADR is accepted when the pull request is merged.
1. Reference the ADR in related pull requests.

An accepted ADR is not rewritten. To change a decision, write a new ADR and set the old one's status to "Superseded by ADR-XXX".

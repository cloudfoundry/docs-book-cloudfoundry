# AGENTS.md

Instructions for AI coding agents working on the **Cloud Foundry** documentation set. This doc set is built from multiple repositories; the book repo (this repo) assembles the TOC and references content that lives in sibling docs repos.

## Project overview

Product documentation for **Cloud Foundry** (OSS). Content is published at docs.cloudfoundry.org. Source is Markdown with ERB templating (`*.html.md.erb`), HTML tables, and template variables. The book is built with Bookbinder/Middleman.

**Multi-repo layout:** This repository (**docs-book-cloudfoundry**) is the **book** (aggregator). It does not hold most of the topic content. It holds:

- **Subnav/TOC** (e.g. `master_middleman/source/subnavs/_cf-subnav.erb`) that define the navigation and point at content using path prefixes such as `/buildpacks/`, `/bbr/`, `/concepts/`, etc.
- Those paths are resolved at build time from **sibling documentation repositories** (see the "Repositories in the doc set" table and the "Quick reference: TOC path → repo" table below).

When you change or add a topic that is referenced in the TOC, the actual file often lives in a content repo (e.g. **docs-buildpacks**, **docs-bbr**), not in this repo. When you rename or move a file in a content repo, you must update the TOC in **this** repo so the book still links to the correct path.

**Cross-repo change awareness:** When you make a change in any of the repos listed in this doc set, **alert the user** if that change might also require updates in other related repos—especially **docs-book-cloudfoundry** (e.g. TOC links, new or removed topics, renamed paths). Prompt them to check the other repo(s).

## Repositories in the doc set

| Repository | Role | Path prefix in TOC (examples) |
|------------|------|-------------------------------|
| **docs-book-cloudfoundry** (this repo) | Book: TOC, subnav, assembly | — |
| **docs-buildpacks** | [Buildpacks](https://github.com/cloudfoundry/docs-buildpacks) | `/buildpacks/` |
| **docs-bbr** | [BOSH Backup and Restore](https://github.com/cloudfoundry/docs-bbr) | `/bbr/` |
| **docs-deploying-cf** | [Deploying Cloud Foundry](https://github.com/cloudfoundry/docs-deploying-cf) | `/deploying/` |
| **docs-cf-admin** | [CF Admin](https://github.com/cloudfoundry/docs-cf-admin) | `/adminguide/` |
| **docs-cf-cli** | [CF CLI](https://github.com/cloudfoundry/docs-cf-cli) | `/cf-cli/` |
| **docs-cloudfoundry-concepts** | [Cloud Foundry concepts](https://github.com/cloudfoundry/docs-cloudfoundry-concepts) | `/concepts/` |
| **docs-dev-guide** | [Developer guide](https://github.com/cloudfoundry/docs-dev-guide) | `/devguide/` |
| **docs-loggregator** | [Loggregator](https://github.com/cloudfoundry/docs-loggregator) | `/loggregator/` |
| **docs-services** | [Services](https://github.com/cloudfoundry/docs-services) | `/services/` |
| **docs-uaa** | [UAA](https://github.com/cloudfoundry/docs-uaa) | `/uaa/` |
| **docs-credhub** | [CredHub](https://github.com/cloudfoundry/docs-credhub) | `/credhub/` |
| **docs-running-cf** | [Running Cloud Foundry](https://github.com/cloudfoundry/docs-running-cf) | `/running/` |

The repos listed above are the full set used in the Cloud Foundry book. The TOC in this repo is the single place that ties all content together.

**Quick reference: TOC path → repo** (all repos use **master** branch)

| TOC path | Repo |
| -------- | ---- |
| `/buildpacks/` | docs-buildpacks |
| `/bbr/` | docs-bbr |
| `/deploying/` | docs-deploying-cf |
| `/adminguide/` | docs-cf-admin |
| `/cf-cli/` | docs-cf-cli |
| `/concepts/` | docs-cloudfoundry-concepts |
| `/devguide/` | docs-dev-guide |
| `/loggregator/` | docs-loggregator |
| `/services/` | docs-services |
| `/uaa/` | docs-uaa |
| `/credhub/` | docs-credhub |
| `/running/` | docs-running-cf |

## Branch

This doc set uses a single version. All repositories use the **master** branch. Keep content and TOC in sync on **master** when making cross-repo changes.

## TOC files in this repo

The main subnav lives at `master_middleman/source/subnavs/_cf-subnav.erb`. Template variables and other book config are under `config/` (e.g. `config/template_variables.yml`).

**Link format in TOC:** Links are absolute-style paths that match the published URL structure, e.g. `/buildpacks/`, `/bbr/`, `/deploying/`, `/concepts/`, `/devguide/`, `/adminguide/`, `/cf-cli/`, `/uaa/`, `/credhub/`, `/running/`, `/loggregator/`, `/services/`.

The segment after the first slash (e.g. `buildpacks`, `bbr`) corresponds to content supplied by the content repos at build time. Do not create those topic files in this repo; edit them in the repo that owns that path.

## Cross-repo workflows

1. **Renaming or moving a file in a content repo**  
   After renaming/moving the file in the content repo, open **docs-book-cloudfoundry** on **master** and update every TOC entry that pointed at the old path so it uses the new path. Check the main subnav file `master_middleman/source/subnavs/_cf-subnav.erb` and any other subnavs or index files that reference that path.

2. **Adding a new topic in a content repo**  
   Add the topic file in the content repo, then in this repo add a TOC entry in the appropriate subnav (e.g. `_cf-subnav.erb`) using the path that will resolve to that topic (e.g. `/buildpacks/my-topic.html`, `/bbr/my-topic.html`, `/deploying/my-topic.html`, `/concepts/my-topic.html`, `/devguide/my-topic.html`, `/adminguide/my-topic.html`, `/cf-cli/my-topic.html`, `/uaa/my-topic.html`, `/credhub/my-topic.html`, `/running/my-topic.html`, `/loggregator/my-topic.html`, `/services/my-topic.html`).

   **TOC placement convention:** When adding a new topic to a submenu that has a corresponding index page (e.g. `managing-apps-stacks-index.html.md.erb`), place the new TOC entry in the same order as it appears in that index file. Always check the index file first.

3. **TOC subnav structure conventions**  
   The subnav (`_cf-subnav.erb`) is a single HTML file. Keep these rules in mind when editing:
   - Every `<li class="has_submenu">` must have a matching `</li>` after its closing `</ul>`.
   - Every `<a href="...">link text</a>` must use `</a>` (not `<a>`) as the closing tag.
   - Sections using a non-linked heading (e.g. operator sections, UAA) should use `<li class="has_submenu"><span>Heading text</span><ul>...</ul></li>`, not a bare `<li><strong>` followed by a detached `<ul>`.
   - Do not link the same page in more than one location in the subnav. If a page is relevant in two sections, keep it in the section that best matches its audience and add a cross-reference in the content if needed.
   - Some subnav entries link to files in a different content repo than the section they appear under (e.g. a `/running/` file inside the Devguide section). When adding or editing such cross-section links, note which repo owns the file so future editors know where to make changes.

## Commit messages

Cloud Foundry has an AI disclosure policy ([RFC-0047](https://github.com/cloudfoundry/community/blob/2d2df6e9cb3efa7b0729ea011c0f7e4952cca12f/toc/rfc/rfc-0047-ai-disclosures.md)). All commits made with AI assistance must disclose it. See `.cursor/rules/commit-message.mdc` for the required format.

## Keeping this file current

When new repos are added to the doc set, update the "Repositories in the doc set" table and the quick reference table. After doing a cross-repo task, consider adding a short note here if you discover a convention or gotcha that would help future edits.

**After actions in a session:** Consider whether what you did suggests a helpful addition to **AGENTS.md** or **.cursor/rules/multi-repo-docs.mdc**. Keep the rules file in sync with AGENTS.md when repo list or paths change.

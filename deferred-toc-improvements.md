# Deferred TOC improvements

These are suggested improvements to `master_middleman/source/subnavs/_cf-subnav.erb` that were identified but not yet applied. Work through them as time allows.

---

## 5. Consolidate BBR into a single section

Currently BBR content appears in two separate places for operators:

- A partial entry nested inside "Deploying Cloud Foundry" (lines ~76–80 in the original file):
  ```html
  <li class="has_submenu"><a href="/bbr/cf-backup.html">Configuring your Cloud Foundry for BOSH Backup and Restore</a>
    <ul>
      <li class=""><a href="/bbr/external-blobstores.html">Backup and restore for external blobstores</a></li>
    </ul>
  </li>
  ```
- A full "BOSH Backup and Restore (BBR)" section lower in the Operators section with installing, backup, restore, logging, experimental features, and the dev guide.

**Suggested action:** Remove the nested BBR entry from inside "Deploying Cloud Foundry". In its place, add a single cross-reference line such as:
```html
<li class=""><a href="/bbr/index.html">Backing up and restoring with BBR</a></li>
```
Keep the full BBR section as-is. This removes duplication and gives BBR a single authoritative home in the nav.

---

## 8. Add source-repo comments for cross-section links

Several links in the subnav point to files that live in a different repo than the section they appear in. This makes maintenance confusing. Add a short HTML comment above each such link so editors know which repo to update.

Examples to address:

| Link | Where it appears in nav | Actual repo |
|------|------------------------|-------------|
| `/devguide/deploy-apps/app-lifecycle.html` | Concepts > "How CF manages apps" | docs-dev-guide |
| `/running/managing-cf/app-event.html` | Devguide > "Managing apps with the cf CLI" | docs-running-cf |
| `/adminguide/troubleshooting_tcp_routing.html` | Devguide > "Routes and domains" | docs-cf-admin |

**Suggested action:** Add comments like the following above each cross-section link:
```html
<!-- file lives in docs-dev-guide, not docs-cloudfoundry-concepts -->
<li class=""><a href="/devguide/deploy-apps/app-lifecycle.html">The app container lifecycle on Diego architecture</a></li>
```

---

## 10. Move `rate-limit-cloud-controller-api` to the Running section

The link `/running/rate-limit-cloud-controller-api.html` ("Rate limit information returned by the Cloud Controller API") currently appears in the **API Reference > CAPI API** submenu. The file lives in `docs-running-cf` and is an operator-facing topic about runtime behavior, not an API spec reference.

**Suggested action:** Move this entry from the CAPI API submenu into the **Running and Troubleshooting Cloud Foundry** section, alongside the other scaling and configuration topics (e.g. near "Scaling Cloud Controller"). Remove it from the CAPI API submenu.

```html
<!-- current location (CAPI API submenu) — remove this: -->
<li class=""><a href="/running/rate-limit-cloud-controller-api.html">Rate limit information returned by the Cloud Controller API</a></li>

<!-- add in Running and Troubleshooting section, e.g. after scaling-cloud-controller: -->
<li class=""><a href="/running/rate-limit-cloud-controller-api.html">Rate limit information returned by the Cloud Controller API</a></li>
```

# Open Questions for Engineering Review

Issues found during the 2026 content audit that require subject-matter expertise before the docs can be corrected. Each item includes the affected file(s), the discrepancy, and what we need to know.

---

## INC-01 — Contradictory guidance on RESTRICTED stacks and restaging

**Files:**
- `docs-cf-admin/managing-stacks.html.md.erb`
- `docs-cloudfoundry-concepts/stacks.html.md.erb`

**Discrepancy:**  
The two files contradict each other on whether apps on a RESTRICTED stack can be restaged:

- `managing-stacks.html.md.erb` states that apps on a RESTRICTED stack **cannot** be restaged.
- `stacks.html.md.erb` states (or implies) that restaging **is** possible.

**Question for engineering:**  
What is the correct current behaviour for apps on a RESTRICTED stack? Can they be restaged or not? Which file should be updated, and to say what?

---

## INC-02 — Trusted system certificates guidance only covers cflinuxfs3

**File:** `docs-running-cf/trusted-system-certificates.html.md.erb`  
(now in `docs-running-cf/archive/` — if this content is to be updated, a new location should be agreed)

**Issue:**  
The topic covers how to configure trusted system certificates for apps running on `cflinuxfs3`. It does not include equivalent guidance for `cflinuxfs4`.

**Question for engineering:**  
What is the procedure for configuring trusted system certificates for apps on `cflinuxfs4`? Is it the same as cflinuxfs3, different, or not applicable? Once confirmed, the topic should be updated (or a new topic created) to cover both stacks.

---

## INC-05 — Incomplete description of the B3 single-header format

**File:** `docs-cf-admin/distributed-tracing.html.md.erb`

**Issue:**  
The topic describes the B3 single-header format as combining only `X-B3-TraceId` and `X-B3-SpanId`. The B3 specification also includes a trace-flags field (and optionally a parent span ID), which are omitted from the current description.

**Question for engineering:**  
What is the complete format of the B3 single-header as used in Cloud Foundry's Gorouter? Specifically:
- Are trace flags included?
- Is the parent span ID included?
- What is the exact header format string (e.g., `{traceId}-{spanId}-{flags}` or similar)?

Once confirmed, the description in `distributed-tracing.html.md.erb` can be completed.

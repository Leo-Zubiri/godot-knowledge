---
id: game-studio-post-release-and-crash-reporting
type: reference
domain: game-studio
status: proposed
summary: "Post-release maintenance facts found so far (per-channel builds on itch.io, F-Droid constraints, Sentry's source-available licence) and the gaps (Steam branches, libre crash reporters, bug triage standards)."
tags: [dept/delivery, dept/qa]
sources:
  - claim: "Sentry self-hosted licence and requirements; bug-triage pointers (snippet-level)"
    ref: src-gs-delivery-versioning-hygiene
    retrieved: 2026-11-08
  - claim: "itch.io channels keep per-channel builds; F-Droid FLOSS rule"
    ref: src-gs-delivery-platforms
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-logging-and-crash-evidence]]"   # crash evidence inside the game
  - relates-to: "[[game-studio-delivery-platforms-and-fees]]"   # store rules
  - relates-to: "[[gs-adr-free-and-open-source-first]]"   # libre-first preference
  - relates-to: "[[godot-error-crash-reporting-and-enriched-logging]]"   # the in-game client/module that feeds these release-side dashboards
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** official documentation as read on 2026-11-08 (paraphrased extractions by research subagents). Vendor and platform pages change quickly: re-check before acting. Fees and defaults are recorded as the page wrote them; nothing was tested here. Status `proposed`; not legal advice.


## Found
- **Sentry self-hosted** is under the Functional Source License (called Fair Source), converting to Apache 2.0 after two years; it may be deployed anywhere but not sold as an offering or used to compete directly; needs Docker, 4 cores, 16 GB RAM plus 16 GB swap, 20 GB disk; no support guarantees; some features SaaS-only. It is **source-available, not FLOSS** by the F-Droid or OSI definitions (our reading), so it conflicts with a libre-first rule and with F-Droid.
- itch.io keeps builds per channel; no rollback procedure was verified for any store.
- Telemetry and crash reports have **privacy and age-rating implications** — human/legal review.

## Not found / unverified
Godot's bug-triage page (404 at guessed paths), Mozilla's severity/priority definitions (page not read), Steam depot/branch docs, a libre crash reporter, a hotfix/rollback flow. Bug-triage conventions seen are *practice, not standard*.

## Agent can / cannot
An agent can draft bug-report templates (version, platform, steps, expected vs actual, minimal project), check duplicates and group by severity; humans decide priority and release blockers.

## See also
- [[godot-logging-and-crash-evidence]] — crash evidence inside the game
- [[game-studio-delivery-platforms-and-fees]] — store rules
- [[gs-adr-free-and-open-source-first]] — libre-first preference
- [[godot-error-crash-reporting-and-enriched-logging]] — the in-game client/module that feeds these release-side dashboards

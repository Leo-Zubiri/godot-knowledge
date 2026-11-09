---
id: game-studio-delivery-platforms-and-fees
type: reference
domain: game-studio
status: proposed
summary: "Distribution platforms as documented on 2026-11-08 (itch.io, Steam, Google Play, Apple, F-Droid, Flathub): rules, fees as written, what an agent can automate and what needs a human, including Flathub's ban on AI-driven submissions."
tags: [dept/delivery, scope/licensing]
sources:
  - claim: "itch.io butler, HTML5 limits and payments pages"
    ref: src-gs-delivery-platforms
    retrieved: 2026-11-08
  - claim: "Steam Direct, release checklist and pricing pages"
    ref: src-gs-delivery-platforms
    retrieved: 2026-11-08
  - claim: "Google Play target API, bundles and registration; Apple guideline headings"
    ref: src-gs-delivery-platforms
    retrieved: 2026-11-08
  - claim: "F-Droid inclusion policy and Flathub requirements, including AI-use rules"
    ref: src-gs-delivery-platforms
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-export-platform-notes]]"   # build side
  - relates-to: "[[game-studio-cost-and-openness-classification]]"   # libre-first preference
  - relates-to: "[[game-studio-versioning-and-changelog]]"   # version strings per store
  - relates-to: "[[gs-adr-free-and-open-source-first]]"   # free/libre-first
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** official documentation as read on 2026-11-08 (paraphrased extractions by research subagents). Vendor and platform pages change quickly: re-check before acting. Fees and defaults are recorded as the page wrote them; nothing was tested here. Status `proposed`; not legal advice.


| Platform | Documented facts (as written, 2026-11-08) | Agent can | Human needed |
|---|---|---|---|
| **itch.io** | `butler push <dir-or-zip> user/game:channel`; channels set platform tags; `--userversion`, `--if-changed`, `--dry-run`; HTML5: ZIP, `index.html` at root, ≤1,000 files, 500 MB extracted, 200 MB/file; seller chooses itch.io's share 0–100% (default 10%); processors PayPal/Stripe ≈2.9% + $0.30; $5 minimum payout, funds available after 7 days | dry-run and push with a human-provided API key; set version strings | account, API key, payout setup, page copy, pricing |
| **Steam** | Steam Direct $100 per product, non-refundable but recoupable after $1,000 adjusted gross revenue; verification ≈15–30 days; review ≈1–5 days; 21-day wait after paying; "coming soon" page ≥2 weeks; store page review 3–5 business days, submit ≥7 days before launch; the release button is manual. SteamPipe/depots/branches not read | prepare checklists and assets | all paperwork, fee, identity, tax, bank, review replies, release |
| **Google Play** | from 2026-08-31 new apps/updates must target Android 16 (API 36)+; AAB required; each update needs a higher versionCode; personal accounts created after 2023-11-13 have testing requirements (numbers unread); one-time $25 | check target SDK and versionCode | account, device verification, testing, declarations |
| **Apple** | guideline headings only (Safety, Performance, Business, Design, Legal); signing/notarization/review pages unread | — | everything |
| **F-Droid** | all apps must be FLOSS; no proprietary tracking/ads/analytics, Play Services, Firebase or Crashlytics without an alternative flavour | check dependencies | submission |
| **Flathub** | redistributable content, declared licence, builds from source offline, submission by GitHub pull request; **AI-generated code/docs/packaging must be disclosed, manifests must not contain AI-generated content, and AI tools must not open or automate submission PRs or write descriptions, commit messages or review replies** | nothing in the submission step | the whole submission |

**Unverified:** Microsoft Store and Epic Games Store fees (only search summaries, conflicting), AppImage, Steam SteamPipe details, Google Play review times. Do not rely on any figure not in the table.

## Risks
Fees and policies change; Google Play raises the target API yearly; Steam's waiting periods bound schedules; itch.io and Godot web limits apply together ([[godot-web-export-constraints]]); a project with proprietary assets cannot meet F-Droid's FLOSS rule (our reading).

## See also
- [[godot-export-platform-notes]] — Godot build requirements
- [[game-studio-cost-and-openness-classification]] — libre-first preference
- [[game-studio-versioning-and-changelog]] — version strings per store
- [[gs-adr-free-and-open-source-first]] — free/libre-first

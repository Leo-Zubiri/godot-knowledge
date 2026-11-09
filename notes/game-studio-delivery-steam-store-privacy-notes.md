---
id: game-studio-delivery-steam-store-privacy-notes
type: reference
domain: game-studio
status: proposed
summary: "Steamworks build/branch/release mechanics, Microsoft Store and Apple pointers, privacy and age-rating basics, packaging and crash-reporting notes, as written 2026-11-08; legal and fee items flagged for human review."
tags: [dept/delivery]
sources:
  - claim: "SteamPipe, branches and release pages"
    ref: src-gs-delivery-steam-store-privacy
    retrieved: 2026-11-08
  - claim: "Microsoft Store, Apple guidelines, COPPA, GDPR, ESRB/PEGI pages"
    ref: src-gs-delivery-steam-store-privacy
    retrieved: 2026-11-08
  - claim: "AppImage, Flatpak, GlitchTip and Mozilla triage pages"
    ref: src-gs-delivery-steam-store-privacy
    retrieved: 2026-11-08
  - claim: "IARC process page read; Epic terms from a search summary only"
    ref: src-gs-delivery-epic-iarc-followup
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-delivery-platforms-and-fees]]"   # platform fees and rules
  - relates-to: "[[godot-export-platform-notes]]"   # build side
  - relates-to: "[[game-studio-versioning-and-changelog]]"   # versions
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---


> **Evidence status:** vendor documentation as extracted on 2026-11-08; these products change quickly, re-check before acting. Nothing was tested here. Status `proposed`.

- **Steam:** `steamcmd +login +run_app_build <vdf> +quit`; build VDF `SetLive` applies to a beta branch only, the default branch is set live manually; log in once interactively then reuse the saved token/`config.vdf`; two checklists (Store Presence, Game Build) must pass; store review ~3-5 business days; release is a manual click.
- **Epic (UNV):** official pages could not be fetched (403); a search summary of them says 100/0 on the first $1M net revenue per product per year then 88/12 (reset each 1 January from 2026), automatic, with Epic First Run counted toward the same threshold. Treat as unverified; confirm on Epic's current page and check whether it applies to your year.
- **Microsoft Store:** no registration fee for the new onboarding flow (page dated 2026-10-29); PC games can self-publish with GDK/MSIXVC; age ratings are a step; revenue share not found.
- **Apple (human/legal flag):** guideline 5.1.2(i) requires disclosure and permission before sharing personal data with third parties including third-party AI; 4.7 covers mini-games and chatbots; 1.2 covers UGC including AI content creation apps. The $99 figure is as written; notarization text unread (UNV).
- **Privacy and ratings (not legal advice; human review):** COPPA six-step plan and the Commission's GDPR principles summary; IARC (page read: one questionnaire per game, certificate ID reusable across IARC storefronts; it does not state who pays or how disputes work), ESRB and PEGI descriptors (in-game purchases, gambling = PEGI 18).
- **Packaging/ops:** AppImage and Flatpak first-build basics only; GlitchTip self-host needs PostgreSQL 14+, about 512 MB RAM recommended; Sentry-SDK compatibility not stated (UNV); Mozilla separates severity from priority (snippet-level, UNV).

## See also
- [[game-studio-delivery-platforms-and-fees]] — platform fees and rules
- [[godot-export-platform-notes]] — build side
- [[game-studio-versioning-and-changelog]] — versions

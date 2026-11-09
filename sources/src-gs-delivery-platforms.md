---
id: src-gs-delivery-platforms
type: source
domain: game-studio
source:
  url: "https://itch.io/docs/butler/"
  urls:
    - "https://itch.io/docs/butler/"
    - "https://itch.io/docs/butler/pushing.html"
    - "https://itch.io/docs/creators/html5"
    - "https://itch.io/docs/creators/payments"
    - "https://partner.steamgames.com/steamdirect"
    - "https://partner.steamgames.com/doc/store/releasing"
    - "https://partner.steamgames.com/doc/store/pricing"
    - "https://developer.android.com/google/play/requirements/target-sdk"
    - "https://support.google.com/googleplay/android-developer/answer/9859152"
    - "https://support.google.com/googleplay/android-developer/answer/6112435"
    - "https://developer.apple.com/app-store/review/guidelines/"
    - "https://f-droid.org/docs/Inclusion_Policy/"
    - "https://docs.flathub.org/docs/for-app-authors/requirements"
  title: "Distribution platforms: itch.io, Steam, Google Play, Apple, F-Droid, Flathub (fees and rules as written on 2026-11-08)"
  retrieved: 2026-11-08
  version: "as written on 2026-11-08; policies change"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official pages fetched on 2026-11-08 by research subagents and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**; not re-read by the main agent. Fees, prices, shares, deadlines and product defaults are recorded *only as the page wrote them on that date* and change; items marked UNV/unverified were not read on an official page (404, blocked, search-snippet only). Not legal advice. Re-fetch before promoting dependent notes to `verified`.

- **itch.io:** `butler` (MIT) uploads builds and creates patches; `butler push <dir-or-zip> user/game:channel` (lower-case names); channel names set initial platform tags (`win`/`windows`, `linux`, `mac`/`osx`, `android`), multi-platform channels like `win-linux-mac-stable` work; builds numbered per channel; `--userversion` sets a free-form version string, `--userversion-file` reads one UTF-8 line, `--if-changed` skips identical pushes, `--dry-run` lists files without uploading; a build goes live when the upload finishes, then an optimised patch replaces it. **HTML5:** ZIP only, `index.html` at the root, relative paths, case-sensitive names, up to 1,000 files, 240-character paths, 500 MB total extracted, 200 MB per file; viewport size required for embed mode; nothing about SharedArrayBuffer. **Money:** sellers choose itch.io's share from 0% to 100% (default 10%); payment processors PayPal and Stripe, each generally 2.9% plus $0.30; funds available after 7 days, $5 minimum, reviewed in about 10–14 days; unclaimed earnings after a year may incur a maintenance charge.
- **Steam (Steam Direct):** $100 USD per product, non-refundable but recoupable after $1,000 in adjusted gross revenue (no revenue-share percentage on the page read); onboarding needs legal ID, bank and tax questionnaire; verification about 15–30 days; review of game, store page and configuration about 1–5 days; first titles need a 21-day wait after paying and a "coming soon" page live at least two weeks. **Release checklist:** store page review typically 3–5 business days, submit at least 7 days before the intended live date; build review also required (duration not stated); the "Release App" button is manual and needs two specific permissions. **Pricing:** initial price reviewed in ~1–2 business days; 37 currencies in 4 region groups. SteamPipe/SteamCMD/depots/branches pages were not read (UNV); whether deeper Steamworks docs are login-gated is unconfirmed.
- **Google Play:** from August 31, 2026 new apps and updates must target Android 16 (API 36) or higher (existing apps need API 35+ to stay available to new users on newer devices; an extension request to November 1, 2026 is mentioned); AAB required; package names permanent; each update needs a higher versionCode (max 2,100,000,000); personal accounts created after November 13, 2023 must meet testing requirements before publishing (numbers not read); one-time $25 registration; review timelines not read.
- **Apple App Store:** guideline headings only (Safety, Performance, Business, Design, Legal); review timelines, notarization and signing pages not read (UNV). **Microsoft Store and Epic Games Store:** only search-result summaries (conflicting or unconfirmed fee/revenue-share figures) — UNV; verify on the official pages before relying on any figure.
- **F-Droid:** all apps must be FLOSS; proprietary tracking, ads, analytics, Google Play Services, Firebase and Crashlytics not allowed without an alternative flavour; builds from public source with a FLOSS toolchain; anti-features are labels, not automatic exclusion. **Flathub:** content must allow legal redistribution and the licence must be declared in MetaInfo; builds are from source with no network access; reverse-DNS app ID with verification; submission is a GitHub pull request; reviewers decide case by case and may remove apps; **AI-generated code, docs or packaging must be disclosed, manifests must not contain AI-generated/AI-assisted content, and AI tools must not open or automate submission pull requests or write their descriptions, commit messages or review replies.** AppImage not researched.

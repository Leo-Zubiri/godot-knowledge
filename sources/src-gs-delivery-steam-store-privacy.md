---
id: src-gs-delivery-steam-store-privacy
type: source
domain: game-studio
source:
  url: "https://partner.steamgames.com/doc/sdk/uploading"
  urls:
    - "https://partner.steamgames.com/doc/sdk/uploading"
    - "https://partner.steamgames.com/doc/store/application/depots"
    - "https://partner.steamgames.com/doc/store/application/branches"
    - "https://partner.steamgames.com/doc/store/releasing"
    - "https://learn.microsoft.com/en-us/windows/apps/publish/partner-center/open-a-developer-account"
    - "https://learn.microsoft.com/en-us/windows/apps/publish/whats-new-game-publishing"
    - "https://developer.apple.com/programs/"
    - "https://developer.apple.com/app-store/review/guidelines/"
    - "https://www.ftc.gov/business-guidance/resources/childrens-online-privacy-protection-rule-six-step-compliance-plan-your-business"
    - "https://commission.europa.eu/law/law-topic/data-protection/rules-business-and-organisations/principles-gdpr_en"
    - "https://www.esrb.org/ratings-guide/"
    - "https://pegi.info/"
    - "https://docs.appimage.org/introduction/index.html"
    - "https://docs.flatpak.org/en/latest/first-build.html"
    - "https://glitchtip.com/documentation/install"
    - "https://firefox-source-docs.mozilla.org/bug-mgmt/policies/triage-bugzilla.html"
  title: "Steamworks build and release, Microsoft Store, Apple programme and review guidelines, COPPA, GDPR, ESRB/PEGI, AppImage/Flatpak, GlitchTip, Mozilla triage (as written 2026-11-08)"
  retrieved: 2026-11-08
  version: "pages as written on 2026-11-08; Epic, notarization, IARC and Godot triage pages unreadable"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** pages fetched on 2026-11-08 by research subagents and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**; PDFs marked 'read by the main agent' were read from downloaded page images. Fees, defaults and policies are recorded only as written on that date; UNV/unverified items were not read on an official page (404, blocked, snippet-only). Godot page versions: 'header not reported' means the fetch tool did not show the version (the URL is the `stable` path). Not legal advice. Re-fetch before promoting dependent notes to `verified`.

- **Steamworks SteamPipe:** ContentBuilder folders `builder`, `builder_linux`, `builder_osx`, `content`, `output`, `scripts`; run `steamcmd` with `+login`, `+run_app_build <script>`, `+quit`. App build VDF fields `AppID`, `Desc`, `ContentRoot`, `BuildOutput`, `Preview` (logs/manifest only, no upload), `Local`, `SetLive` (a beta branch only — **the default branch must be set live manually**), `Depots`. Depot VDF `DepotID`, `ContentRoot`, `FileMapping` (`LocalPath`, `DepotPath`, `Recursive`), `FileExclusion`, `InstallScript`, `FileProperties`. CI login: sign in once interactively with password and SteamGuard code, then SteamCMD saves a token and later runs need only the username; keep `config\config.vdf` between runs; re-entering the password issues a new SteamGuard token. Depots mount in listed order (later override earlier), filterable by language/OS/architecture, DLC depots separate. Branches: default branch is what customers get; uploads never set it live automatically; beta branch names cannot contain spaces and can be password-protected; set-live steps upload, refresh App Admin, choose branch, Preview Change, Set Build Live Now. Release process: two checklists (Store Presence, Game Build) must both be approved; store page review typically 3–5 business days, submit ≥7 days before; page must be "coming soon" ≥2 weeks; release is a manual "Release App" click stamping the release time as now; needs "Publish app changes to Steam" and "Manage pricing and discounts" permissions. App Admin is login-gated and was not read.
- **Epic Games Store:** official pages returned 404/403; only snippets from official domains (UNV): 100/0 on the first $1 million net revenue per product per year then 88/12 since June 2025; Epic First Run opt-in; BuildPatch Tool interface added Sept 2025. No primary text read.
- **Microsoft Store:** "no registration fees" for Individual or Company accounts via the new onboarding flow (page dated 2026-10-29); individual needs government ID plus selfie, company needs D-U-N-S or business documents; Win32 PC games can be published through a self-service path with the Microsoft Game Development Kit and MSIXVC packaging, no ID@Xbox or concept approval needed for PC-only (page dated 2026-06-15); steps include **age ratings**, store listing, pricing, certification; Store Developer CLI, a submission API for MSI/EXE apps and GitHub Actions documented as publishing automation. Revenue share not found (UNV).
- **Apple:** Developer Program "$99 annual membership" (the Enterprise figure not confirmed); notarization pages returned only titles (steps from model memory — UNV). App Store Review Guidelines (first ~100k of 114k characters): 4.7 mini apps/games/streaming/chatbots — responsible for all such software, 4.7.1 filtering method, reporting mechanism and blocking, 4.7.2 no exposure of native APIs without permission, 4.7.5 identify software exceeding the app's age rating; 5.1.1(ii) consent for data collection, 5.1.1(v) in-app account deletion; **5.1.2(i) disclose and get explicit permission before sharing personal data with third parties "including with third-party AI"**; tracking needs App Tracking Transparency; 1.2 user-generated content lists "AI content creation apps" with filtering, reporting, blocking and published contact; no dedicated AI-generated-content section seen in the part read (tail truncated).
- **Privacy and age rating (human/legal review):** COPPA (FTC six-step plan) — determine coverage (under 13, directed to children or actual knowledge, apps and connected toys can be covered), post a compliant privacy policy, direct notice to parents, verifiable parental consent, honour ongoing parental rights, security and retention policy incl. a written information security program. GDPR (Commission summary, not legal text) — applies to organisations based in the EU or processing personal data of people in the EU; seven principles: lawfulness/fairness/transparency, purpose limitation, data minimisation, storage limitation, accuracy, integrity and confidentiality, accountability. ESRB ratings guide — ESRB rates non-game apps on storefronts that license IARC and is an IARC member; Interactive Elements flag in-game purchases (including random items) without affecting the rating. PEGI — classifications for video games in 38 European countries; descriptors include In-Game Purchases, Gambling (new games with gambling elements always PEGI 18 since 2020), Discrimination (always PEGI 18); developer submission process not on the page. IARC process page returned 404.
- **Packaging:** AppImage = a format shipping native Linux binaries with dependencies bundled ("AppImage is the format, AppImageKit provides a reference implementation"); build steps, FUSE, glibc and licences not covered. Flatpak first build — manifest with `id`, `runtime`, `runtime-version`, `sdk`, `command` and modules; every app specifies a runtime and matching SDK; `flatpak-builder` builds modules into `/app`; sandbox permissions not on that page.
- **Crash reporting and triage:** GlitchTip self-host (read) — PostgreSQL 14+, optional Valkey/Redis 7+, recommended 512 MB RAM (256 MB minimum all-in-one), ≈30 GB disk at 1M events per month, proxy supporting buffering and chunked encoding, `SECRET_KEY`, email settings and `GLITCHTIP_DOMAIN`; deployment Docker Compose, Helm, managed hosts; backend repository MIT (LICENSE file itself did not open); Sentry SDK compatibility not stated (UNV). Mozilla triage (official-domain search snippets, UNV for full text): assess new bugs daily, fully triage within a week; severity S1–S4 (how bad) vs priority P1–P5 (when to fix), the wiki page is old and priority guidance is under review; Godot's triage page returned 404.

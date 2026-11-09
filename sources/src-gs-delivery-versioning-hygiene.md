---
id: src-gs-delivery-versioning-hygiene
type: source
domain: game-studio
source:
  url: "https://semver.org/"
  urls:
    - "https://semver.org/"
    - "https://keepachangelog.com/en/1.1.0/"
    - "https://wiki.creativecommons.org/wiki/Best_practices_for_attribution"
    - "https://www.globalratings.com/"
    - "https://firefox-source-docs.mozilla.org/bug-mgmt/policies/triage-bugzilla.html"
    - "https://develop.sentry.dev/self-hosted/"
  title: "Versioning and release hygiene: SemVer, Keep a Changelog, CC attribution best practices, IARC pointer, bug-triage pointers, Sentry self-hosted licence"
  retrieved: 2026-11-08
  version: "SemVer 2.0.0; Keep a Changelog 1.1.0; others as written on 2026-11-08"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official pages fetched on 2026-11-08 by research subagents and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**; not re-read by the main agent. Fees, prices, shares, deadlines and product defaults are recorded *only as the page wrote them on that date* and change; items marked UNV/unverified were not read on an official page (404, blocked, search-snippet only). Not legal advice. Re-fetch before promoting dependent notes to `verified`.

- **Semantic Versioning 2.0.0 (read):** MAJOR.MINOR.PATCH with no leading zeros; major for backward-incompatible public-API changes, minor for backward-compatible additions, patch for backward-compatible fixes; pre-release identifiers after a hyphen rank below the plain version; build metadata after a plus sign is ignored for precedence; `0.y.z` is initial development with no stability promise; 1.0.0 defines the public API.
- **Keep a Changelog 1.1.0 (read):** changelogs are for humans; latest version first; change types Added, Changed, Deprecated, Removed, Fixed, Security; an Unreleased section at the top; ISO 8601 dates; yanked releases stay listed with a YANKED tag; state whether the project follows SemVer. Mapping SemVer to games (a game has no public API; "breaking" could mean save-file or mod-format compatibility) is **our interpretation**, not from either page.
- **Creative Commons attribution best practices (read):** recommended elements Title, Author, Source and License (TASL), linked where possible with the licence named and linked to its deed; "no single best way" as long as reasonable for the medium; for audio/video credit in the work and on a web page; for modified works say what changed and note the original; do not credit only a host site; do not rely on alt text or metadata alone; music in video is generally an adaptation so ND-licensed music should not be used that way; unchanged reuse is allowed under any CC licence; CC0 needs no attribution but citing the source is recommended.
- **Age ratings/privacy:** IARC (globalratings.com) is described as a global age-rating system for digital games and apps, free to developers; the page read named no specific storefronts or steps. ESRB, PEGI, COPPA, GDPR pages not read. **Human/legal review required; no conclusions.**
- **Bug triage (search snippets, UNV):** Godot's triage guidance pages returned 404 at the guessed paths; snippets suggest each issue gets one of Bug/Enhancement/Discussion and "Confirmed" means someone other than the reporter reproduced it; Mozilla's page (not read) reportedly uses Severity S1–S4 (required) and Priority P1–P4 (optional). Practice, not a standard.
- **Sentry self-hosted (read):** licence is the Functional Source License (the page calls it Fair Source), converting to Apache 2.0 after two years; may deploy anywhere but not sell as an offering or use the code to compete directly; needs Docker, 4 cores, 16 GB RAM plus 16 GB swap, 20 GB disk (32 GB RAM recommended); no support guarantees; some features SaaS-only. Source-available, not FLOSS by the F-Droid or OSI definitions (our reading).

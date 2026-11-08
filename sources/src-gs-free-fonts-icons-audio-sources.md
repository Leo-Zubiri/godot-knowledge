---
id: src-gs-free-fonts-icons-audio-sources
type: source
domain: game-studio
source:
  url: "https://github.com/google/fonts"
  urls:
    - "https://github.com/google/fonts"
    - "https://github.com/fontsource/fontsource"
    - "https://github.com/twbs/icons"
    - "https://github.com/tailwindlabs/heroicons"
    - "https://github.com/google/material-design-icons"
    - "https://game-icons.net/about.html"
    - "https://ccmixter.org/terms"
    - "https://mixkit.co/license/"
    - "https://github.com/grumdrig/jsfxr"
    - "https://github.com/increpare/bfxr2"
  title: "Free fonts, icon sets, music/SFX sources and sfxr-style generators"
  retrieved: 2026-11-08
  version: "as of 2026-11-08"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim legal text**; items marked `unverified` or `sec` (secondary source) were not read on an official page (403/404/TLS error). **Not legal advice.** Terms change; have a human read the actual licence before relying on any item. Libre-first project preference: see the cost/openness classification note.

- **Google Fonts repo (read):** most fonts SIL OFL 1.1, some Apache 2.0, Ubuntu fonts UFL 1.0; top-level directories group by licence (`ofl`, `apache`, `ufl`, `cc-by-sa` — contents of the last not explained, avoid unless read); each family directory has its own licence file and `METADATA.pb`; redistribution subject to each licence; some OFL fonts declare Reserved Font Names (care when modifying/renaming); full collection via ZIP (>1 GB) or git sync; self-hosting via Fontsource. fonts.google.com FAQ/about pages returned only topic lists.
- **Fontsource (per research agent):** tooling MIT; font licences OFL/Apache/UFL per package (README lists each); npm packaging of the same fonts.
- **Icon sets (per research agent):** Bootstrap Icons MIT; Heroicons MIT; Material Icons/Symbols Apache 2.0 (attribution requested not required; the classic set no longer updated; Google no longer maintains the npm package, third-party packages unvetted).
- **game-icons.net (about page, read):** CC BY 3.0; credit the individual author (suggested line "Icons made by {author}. Available on https://game-icons.net."), authors listed on the page; commercial use not addressed on the page (read the CC BY 3.0 text); no bulk download yet (ZIP tool on roadmap).
- **ccMixter (terms, read):** each track carries its own Creative Commons licence (CC BY, CC BY-NC, CC0 per research agent); commercial use depends on the track's licence; credit the creator as specified; do not use a track to promote anything other than your own work; do not remove notices; API use accepts the same terms; site text/images CC BY-NC 4.0, software GPL 2.0.
- **Mixkit (licence page, read):** separate "Free License" per item type (stock music, sound effects, video templates, art) and a restricted licence for stock video; the actual terms are behind "View License" links and were **not readable** — commercial/game use `unverified`.
- **Zapsplat, Free Music Archive, Internet Archive audio:** pages blocked or only topic lists — terms `unverified`.
- **jsfxr (per research agent):** Unlicense for the code; **no statement on licensing of generated sounds**; a more active fork exists (sfxr.me / chr15m) with its licence unread. **Bfxr2:** MIT code; no statement on generated-sound licensing; credits DrPetter's sfxr/as3sfxr (their licences not stated). Confirm output terms before shipping generated SFX.

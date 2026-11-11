---
id: src-gs-font-open-source-providers
type: source
domain: game-studio
source:
  url: "https://fonts.google.com/"
  urls:
    - "https://fonts.google.com/"
    - "https://fonts.google.com/attribution"
    - "https://fontsource.org/"
    - "https://www.theleagueofmoveabletype.com/"
    - "https://fonts.google.com/noto"
    - "https://fonts.google.com/noto/specimen/Noto+Sans/license"
    - "https://en.wikipedia.org/wiki/Noto_fonts"
  title: "Where to source open-source fonts: Google Fonts, Fontsource, The League of Moveable Type, Noto (with licence posture)"
  retrieved: 2026-11-10
  version: "provider sites and Noto licence/coverage as read 2026-11-10"
  capture: paraphrased
  retrieved_via: "Fontsource and League of Moveable Type via WebFetch summarizer; Google Fonts and Noto specimen pages are JS-rendered (returned titles only) so Noto facts come from a web search of Wikipedia/Google blog — second-hand, treat as unverified"
created: 2026-11-10
updated: 2026-11-10
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). Fontsource and The League of Moveable Type were read through
> a summarizing fetch tool (paraphrased). The Google Fonts and Noto specimen/licence pages render client-side and returned
> only titles, so the Noto licence/coverage facts come from a web search of Wikipedia and the Google Open Source blog
> (second-hand, **unverified**). Re-fetch with a JS-capable tool before promoting dependent notes to `verified`. No
> synthesis here; notes cite this source by `id`.

## Fontsource (fontsource.org)
- Self-describes as a font directory: "Browse free, open-source and variable fonts" (2,103 families as shown). Page title
  "Download & Self-Host Open-Source Fonts".
- Three distribution routes: direct **downloads**, **npm packages** (install for self-hosting), and **CSS + CDN** links.
- The landing page **names no specific licence**; the focus is open-source fonts but the page does not state that the
  catalogue is open-source-only. Check each font's individual page / upstream project for its licence.

## The League of Moveable Type (theleagueofmoveabletype.com)
- "the original, the first, the open-source font foundry" (operating since 2009).
- "All the fonts from The League of Moveable Type are free & open source" and are "subject to the Open Font License";
  also "available to use commercially."

## Google Fonts (fonts.google.com, /attribution) — JS-rendered, see the licence-families source for terms
- Catalogue of open-source fonts (OFL / Apache 2.0, a few others). The /attribution page lists per-font attribution
  metadata. Downloadable files carry the same OFL/Apache licence as the hosted/served version. (Licence detail and the
  "downloading ≠ relicensing" point are in `src-gs-font-licence-families-ofl-apache-gnu`.)

## Noto — "A typeface for the world" (fonts.google.com/noto; Wikipedia) — Noto facts via web search (unverified)
- **Licence:** "All Noto fonts are licensed under the Open Font License" (per Google's Noto page). Noto was under Apache
  License 2.0 until September 2015, then moved to OFL. For **Noto CJK** specifically, releases before Version 1.002 were
  Apache-2.0 and later ones OFL 1.1 — check the specific CJK release (copyright held by Adobe; name trademarks by Google).
- **Coverage:** a family of 100+ fonts designed to cover all scripts in the Unicode standard; includes Arabic styles
  (Naskh, Kufi, Nastaliq) and CJK (Simplified/Traditional Chinese, Japanese, Korean, a joint Google–Adobe effort based on
  Source Han). As of April 2021 the repo covered ~95% of non-CJK Unicode 13 characters but only ~32.7% of CJK characters.

## Cross-cutting trap (observed across the sites)
"Free to download" is a UI affordance, not a licence grant: the per-font licence file (OFL/Apache/other) governs
redistribution and embedding, and a directory's landing page may not state it. Verify the per-font licence, not the site.

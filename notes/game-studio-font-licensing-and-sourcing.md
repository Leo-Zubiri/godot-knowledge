---
id: game-studio-font-licensing-and-sourcing
type: reference
domain: game-studio
status: proposed
summary: "Font licence families (SIL OFL, Apache-2.0, CC0/Public Domain, CC-BY, proprietary/Google-Fonts-as-a-service) and what each obliges when you embed a font in a shipped game; where to source open-source fonts (Google Fonts, Fontsource, League of Moveable Type, Fontshare, GNU FreeFont/Unifont, Noto); and a decision rule for a 'no obligations / no attribution' preference."
aliases: [font licensing, OFL, Open Font License, Reserved Font Name, where to get free fonts, open-source fonts, Noto, Google Fonts licensing]
tags: [scope/licensing, dept/delivery, dept/2d-art, dept/ui-ux]
applies-to:
  min: "licence facts as published 2026-11-10"
  tested: "documentation only; no licence was legally reviewed"
sources:
  - claim: "OFL: free to use/embed/study/modify/redistribute; the OFL text must ship with the font (a mobile app must include the copyright statement, licence notice and licence text); the font cannot be sold on its own; Reserved Font Names must be renamed if you modify; embedding/subsetting an OFL font does not change the licence of the document or game"
    ref: src-gs-font-licence-families-ofl-apache-gnu
    retrieved: 2026-11-10
  - claim: "Google Fonts are released under OFL or Apache-2.0 (a few others); downloadable files keep the same licence; bundling into apps/products is redistribution and should include the licence file; you may not sell the font files themselves"
    ref: src-gs-font-licence-families-ofl-apache-gnu
    retrieved: 2026-11-10
  - claim: "GNU FreeFont is GPLv3-or-later with a font-embedding exception: embedding the unaltered font in a document does not bring the document under the GPL; the exemption fails if the font was modified before embedding"
    ref: src-gs-font-licence-families-ofl-apache-gnu
    retrieved: 2026-11-10
  - claim: "Fontsource distributes open-source fonts via downloads, npm packages and CDN/CSS; The League of Moveable Type fonts are free & open source under the Open Font License and usable commercially; Noto is licensed under the OFL (CJK varies by release) and covers Unicode scripts including Arabic and CJK"
    ref: src-gs-font-open-source-providers
    retrieved: 2026-11-10
  - claim: "CC0 1.0 is a public-domain dedication (copy/modify/distribute commercially, no permission and no attribution required); CC BY 4.0 requires crediting the creator, linking the licence and stating changes"
    ref: src-gs-asset-cc-licenses
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-asset-license-and-provenance-policy]]"   # this is the font-specific case of the general asset-licence policy
  - relates-to: "[[game-studio-delivery-steam-store-privacy-notes]]"   # the credits/licenses screen that discharges OFL/Apache ships at delivery
  - relates-to: "[[godot-localization-workflow]]"   # non-Latin fallback fonts (Noto) are chosen during localization
  - relates-to: "[[godot-fonts-and-msdf-in-4-7]]"   # engine-side font import/MSDF sibling note (may not exist yet)
created: 2026-11-10
updated: 2026-11-10
created_by_type: agent
---

> **Evidence status:** OFL and GNU FreeFont facts are *documented* from official pages retrieved 2026-11-10 (OFL FAQ via a summarizing fetch tool; GNU FreeFont as a plain-text excerpt). The **Google Fonts and Noto specimen/FAQ pages render client-side and returned only titles**, so those facts come from a web search of third-party guides, Wikipedia and the Google Open Source blog — *second-hand / unverified*; re-fetch with a JS-capable tool before verification. CC0/CC-BY facts are paraphrased deeds (not legal text). The decision rule is *interpretation*. Licences change and this is **not legal advice**. Status `proposed`.

## Scope
Choosing and sourcing a *text font* for a game and knowing what obligation that choice creates **at ship time**. The font's licence governs the font files you redistribute; it is **independent of your game's own licence/output** (see OFL 1.3/1.13 below). For asset licences in general see [[game-studio-asset-license-and-provenance-policy]]; this note is the font-specific case.

## Licence families — what each obliges when you embed the font in a shipped game
| Family | Use/embed/modify? | Obligation when you ship | Attribution anywhere? |
|---|---|---|---|
| **SIL Open Font License (OFL)** | yes — use, study, modify, embed (full or subset), redistribute | **ship the OFL text** with the font (copyright statement + licence notice + licence text; for an app include only the fonts you use); **cannot sell the font on its own** (must bundle with other content — a game qualifies); **Reserved Font Names** — rename the font's internal names if you modify/subset it | **yes** — the licence text must be present somewhere |
| **Apache-2.0** (some Google fonts) | yes — permissive | preserve the licence notice when you redistribute the files (bundling = redistribution) | **yes** — keep the notice |
| **CC0 / Public Domain** | yes — anything, commercial included | **none** — no attribution and no licence text required | **no** — the only family compatible with a strict "no attribution of any kind" policy |
| **CC-BY (4.0)** | yes — any purpose incl. commercial | **credit the creator, link the licence, state changes** | **yes** — explicit credit required |
| **GNU FreeFont (GPLv3 + font exception)** | yes | embedding the **unaltered** font in a document does not bring the document/game under the GPL; **modifying** the font before embedding voids the exception | keep the notice; practically niche vs OFL |
| **Proprietary / "Google Fonts as a service"** | varies | the Google Fonts *service* (serving CSS/webfonts) is one thing; the **font files** you download are still OFL/Apache and those terms travel with the files | per the specific EULA |

**Crystal-clear point.** With an **OFL or Apache** font you **must include the licence text somewhere** — so "zero attribution of any kind" is only truly achievable with **CC0 / Public Domain** fonts. But an in-game **licenses/credits screen already discharges OFL/Apache**, exactly like the engine's own MIT notice already shipped in such a screen ([[game-studio-delivery-steam-store-privacy-notes]]). That screen is cheap and is the recommended path, because quality-and-coverage fonts are overwhelmingly OFL.

**Three OFL traps worth repeating:**
- The font's licence has **nothing to do with your game's licence or its output**: "embedding an OFL font in any document does not change the license of the document itself" and "Only the portions based on the Font Software are required to be released under the OFL" (*documented*). Your proprietary game stays proprietary.
- **Reserved Font Name (RFN):** if you *subset or modify* a font that declares RFNs, you must change its internal names to your own — you cannot ship a modified "Foo" still called "Foo" (*documented*).
- You may **embed and subset** under OFL/Apache (shipping), but you may **not sell the font by itself** or as a paid font pack (*documented*).

## Where to source open-source fonts (and each one's licence posture)
| Source | What it is | Licence posture |
|---|---|---|
| **Google Fonts** | large catalogue, downloadable files + served webfonts | mostly **OFL**, some **Apache-2.0** (a few Ubuntu Font Licence); downloading the files does **not** relicense them — OFL still applies (*unverified*: Google FAQ was JS-blocked) |
| **Fontsource** | directory distributing fonts as **downloads, npm packages and CDN/CSS** | open-source focus (OFL/Apache); the landing page names no licence — check each font's page |
| **The League of Moveable Type** | "the original … open-source font foundry" | "free & open source … subject to the Open Font License"; usable commercially (*documented*) |
| **Fontshare** | free font service by Indian Type Foundry | **free, but check per-font terms — some are not OFL**; "free" ≠ "libre" (*unverified* — not fetched this pass) |
| **GNU FreeFont / GNU Unifont** | broad-coverage libre fonts | GPLv3 + font exception (FreeFont); Unifont is GPL-with-exception / dual-licensed (*unverified* for Unifont) |
| **Noto** | Google/Adobe family covering the Unicode scripts (incl. **CJK and Arabic**) | **OFL** (CJK varies: pre-1.002 Apache-2.0, later OFL 1.1 — check the release). The go-to **non-Latin fallback** ([[godot-localization-workflow]]) |

**The trap, stated once more:** "free to download" is a UI affordance, **not** a redistribution grant. Verify the **per-font licence file** (the OFL/Apache/other text that ships with the download), not the site's marketing copy.

## Decision rule for a "no obligations / no attribution" preference
1. If you genuinely want **zero licence text anywhere**, pick **CC0 / Public Domain** fonts only (rare for high-quality, wide-coverage families). *(interpretation)*
2. Otherwise **accept OFL/Apache and ship a licenses screen** — recommended, because the best-quality and widest-script fonts are overwhelmingly OFL, and the screen already exists for the engine's MIT notice. *(interpretation)*
3. If you **subset or modify** any OFL font, honour the **Reserved Font Name** rename duty (new internal font name). *(documented)*
4. Record every font's name, version, source URL, licence and licence-file path in the asset registry, same as any asset ([[game-studio-asset-license-and-provenance-policy]]). *(interpretation)*

## Practical: subsetting and embedding
Shipping only the glyphs a game uses (subsetting) cuts file size — important for Latin-only UIs that would otherwise bundle a full Noto CJK face. **Embedding and subsetting are permitted** under OFL and Apache (that is *shipping* the font, not *selling* it). Under OFL, a subset is a modification, so the **RFN rename** applies if the font declares Reserved Font Names, and the licence text must still travel with the subset. *(documented + FAQ inference)*

## What an agent can and cannot check
**By reading files/CLI:** that every bundled font has a licence file alongside it; that a licenses/credits screen exists and names each OFL/Apache font; that no font is sold or shipped standalone; that a modified/subset OFL font's internal name differs from the original (RFN); that the asset registry records each font's licence and source. **Needs a human / legal judgement:** whether a given Fontshare or "free" font is actually libre-redistributable; whether a specific Noto CJK release is Apache or OFL; whether a subset truly triggers the RFN rule for a given font; and any binding interpretation — this note is not legal advice.

## See also
- [[game-studio-asset-license-and-provenance-policy]] — this is the font-specific case of the general asset-licence policy
- [[game-studio-delivery-steam-store-privacy-notes]] — the credits/licenses screen that discharges OFL/Apache ships at delivery
- [[godot-localization-workflow]] — non-Latin fallback fonts (Noto) are chosen during localization
- [[godot-fonts-and-msdf-in-4-7]] — engine-side font import/MSDF sibling note (may not exist yet)

---
id: src-gs-font-licence-families-ofl-apache-gnu
type: source
domain: game-studio
source:
  url: "https://openfontlicense.org/ofl-faq/"
  urls:
    - "https://openfontlicense.org/ofl-faq/"
    - "https://www.gnu.org/software/freefont/license.html"
    - "https://fonts.google.com/faq"
    - "https://developers.google.com/fonts/faq"
    - "https://fonts.google.com/knowledge/glossary/licensing"
  title: "Font licence families: SIL OFL FAQ, GNU FreeFont license (GPLv3 + font exception), Google Fonts licensing FAQ"
  retrieved: 2026-11-10
  version: "OFL FAQ as published 2026-11-10; GNU FreeFont license page; Google Fonts FAQ"
  capture: paraphrased
  retrieved_via: "OFL FAQ + GNU FreeFont via WebFetch summarizer and curl excerpt; Google Fonts FAQ pages are JS-rendered and returned only titles, so their facts come from a web search of third-party guides — second-hand, treat as unverified"
created: 2026-11-10
updated: 2026-11-10
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). Mixed fidelity: the OFL FAQ was read through a summarizing
> fetch tool (paraphrased); the GNU FreeFont license page was read as a plain-text curl excerpt; the Google Fonts
> **FAQ/knowledge pages render client-side and returned only their titles**, so the Google Fonts facts below come from a
> web search of third-party guides and are **second-hand / unverified**. Re-fetch the Google Fonts FAQ with a JS-capable
> tool before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

## SIL Open Font License — FAQ (openfontlicense.org/ofl-faq/)
- **Permits:** use for any design work, "No additional license or permission is required" (1.1); the right "to extract
  that font, use, study, modify and redistribute it" (1.17); embedding a font in a document, in full or as a subset (1.12).
- **License text must travel with the font:** the FAQ says the OFL text must accompany the font (with narrow exceptions).
  For a mobile app you "must include the copyright statement, the license notice and the license text" (1.20); you need
  include only the fonts you actually use and their copyright/license, not the whole package. Embedding the full OFL text
  in the font metadata is recommended over a link (1.10). (One document-embedding entry (1.10) reads as not requiring the
  text; the safer reading is to always include the notice + text.)
- **Cannot sell the font by itself:** "the OFL font is not sold by itself" (1.5, 1.6); it must ship bundled with other
  software/content. Selling a software package that includes the fonts is allowed (1.4), and games are listed among such
  software.
- **Reserved Font Names (RFNs):** names the author reserves (declaring them is optional, 5.1/5.6). If you modify a font
  with declared RFNs you "need to change the internal names of the font to your own font name" (3.1); a modified version
  may not use the RFN in font menus etc. (5.3). You need not publish your changes (3.6) but must rename if RFNs are
  declared (3.8).
- **Does not infect the product:** "Referencing or embedding an OFL font in any document does not change the license of
  the document itself" (1.13); for software, "Only the portions based on the Font Software are required to be released
  under the OFL" (1.3) — the rest of a game can carry any licence.
- **Subsetting in a game:** FAQ addresses documents/webfonts, not games directly; in the webfont context removing parts
  of a font is treated as modification (2.6), so a shipped subset would likely count as a modified version and the RFN
  rename rule would apply if RFNs are declared. (FAQ inference, flagged.)

## GNU FreeFont license (gnu.org/software/freefont/license.html) — curl excerpt
- Licensed under the **GNU General Public License, version 3 or later**, **with a font-embedding exception**.
- Exception (quoted): "As a special exception, if you create a document which uses this font, and embed this font or
  unaltered portions of this font into the document, this [does not bring the document under the GPL]."
- The exemption applies **only when the embedder has not modified the FreeFont software before embedding it**. Extracting
  the font back out of a document, or embedding a modified version, would have to comply with the GNU GPL. A modified
  font may optionally carry the same exception.

## Google Fonts licensing (fonts.google.com/faq, knowledge/glossary/licensing) — JS-rendered, facts from third-party guides (unverified)
- Fonts on Google Fonts are released under **open-source licences — the SIL OFL or the Apache License 2.0** (a few use
  others such as the Ubuntu Font License). Downloading the files does not change the licence: OFL still applies.
- Usable commercially, printable, embeddable on the web, self-hostable and bundlable in applications/products; the
  original licence file should be included with the distribution (bundling is redistribution; keep the licence notice).
- You may not sell the font files themselves or redistribute them as a paid font pack. OFL derivatives stay OFL.
- Sources disagree on whether attribution is strictly required for OFL/Apache; the safer reading is to ship the licence
  text (a credits/licenses screen) rather than rely on "no attribution". *(Third-party summary — verify against the
  official FAQ and the Apache-2.0 / OFL texts.)*

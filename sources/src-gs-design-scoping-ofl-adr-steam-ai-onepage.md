---
id: src-gs-design-scoping-ofl-adr-steam-ai-onepage
type: source
domain: game-design
source:
  url: "https://openfontlicense.org/ofl-faq/"
  urls:
    - "https://openfontlicense.org/ofl-faq/"
    - "https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions"
    - "https://store.steampowered.com/news/group/4145017/view/3862463747997849619"
    - "https://www.gdcvault.com/play/1012356/One-Page"
  title: "OFL FAQ (bundling fonts in apps), Nygard 'Documenting Architecture Decisions' (ADR format), Valve 'AI Content on Steam' (Jan 2024; primary post unreadable, secondary coverage), GDC 2010 'One-Page Designs' (abstract only)"
  retrieved: 2026-11-08
  version: "pages as written on 2026-11-08; Steam post body not captured (JS-rendered), replaced by search-engine summaries of press coverage; GDC Vault returned the session abstract only"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and a web-search summary for the Steam item; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** pages fetched on 2026-11-08 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**; quoted fragments are what the tool reported as quotations. The Steam news post rendered only navigation (three URL variants tried), so the AI-policy item below is **secondary evidence** from a web-search summary of press coverage (PC Gamer, VGC, GameSpot, TechRadar) and must be re-fetched from a primary Valve page before any dependent claim is `verified`. The GDC Vault entry exposed only the abstract. Not legal advice. No synthesis here.

- **OFL FAQ (SIL Open Font License):** 1.4 — fonts may be used in "games and entertainment software, mobile device applications" (original or modified). 1.12 — embedding "in full or a subset" is allowed. **1.20 (bundled in an app):** "At a minimum you must include the copyright statement, the license notice and the license text"; only the fonts used need shipping, not the whole package; noting the licence in an About box/changelog with a link is "good practice" but not mandatory. **1.10:** the only case a font may travel without the OFL text is when "embedded in a document or bundled within a program"; a link in font metadata is legally sufficient but the FAQ "strongly recommend[s] against this". 1.1.2 / 1.19 — acknowledgement/credit of the author is **not required** ("may appreciate being mentioned … but that is not required"). 1.5 / 1.6 / 3.3 — the font must not be sold by itself; derivatives stay under OFL. 5.x — Reserved Font Names: a modified font must not use an RFN to identify itself (5.3); RFNs are optional (5.6), none reserved by default (5.7). 3.1 / 3.5 — anything may be changed as long as the licence is respected; modified versions are redistributed under OFL.
- **Nygard, "Documenting Architecture Decisions" (2011):** one record per decision, "one or two pages long", written "as if it is a conversation with a future developer". Sections: **Title** (short noun phrase with a number, e.g. "ADR 9: LDAP for Multitenant Integration"), **Context** ("value-neutral … simply describing facts": technological, political, social, project-local forces), **Decision** (full sentences, active voice, "We will…"), **Status** (proposed → accepted; later "deprecated or superseded" with a reference to the replacement), **Consequences** ("All consequences should be listed here, not just the 'positive' ones"). Rules: "If a decision is reversed, we will keep the old one around, but mark it as superseded"; "ADRs will be numbered sequentially and monotonically. Numbers will not be reused"; files under `doc/arch/adr-NNN.md` in lightweight markup. Motivation: avoid "blind acceptance or blind reversal" of past decisions by newcomers who cannot see the rationale.
- **Valve, "AI Content on Steam" (10 Jan 2024; SECONDARY — press summaries):** the content survey asks developers to disclose AI use in two categories. **Pre-generated** — "art, code, and sound, created with AI tools during development", reviewed "the same [way] it does with non-AI content" at pre-release review. **Live-generated** — content produced while the game runs; same rules plus developers must describe the "guardrails" ensuring "it's not generating illegal content". Disclosures are shown on the store page. Valve added an in-game Steam overlay tool so players can report illegal live-generated output. Exception: "Adult Only Sexual Content that is created with Live-Generated AI" cannot be released. A later update (reported by PC Gamer; date not captured) narrowed the form to AI content consumed by players rather than behind-the-scenes efficiency tooling (*unverified*: only the headline was readable).
- **GDC 2010, Stone Librande (EA/Maxis), "One-Page Designs" (abstract only):** the speaker "has been experimenting with a style of design documentation that he calls a one page design" — a document "exactly one page long", asking why a document needs more pages when most readers only get through the first; examples from Diablo III, The Simpsons and Spore; the aim is to "communicate key design ideas to your team". No transcript or slide text was available on the page.

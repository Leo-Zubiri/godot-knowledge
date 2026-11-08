---
id: game-studio-godot-ecosystem-free-resources
type: reference
domain: game-studio
status: proposed
summary: "Free/libre resources inside the Godot ecosystem — Asset Library and Godot Shaders — how their licences are declared, what is automatable, and the caveats; plus Godot's own MIT notice requirement for shipped games."
sources:
  - claim: "Godot MIT licence terms and notice requirement when shipping the engine binary; third-party components listed in COPYRIGHT.txt"
    ref: src-gs-free-godot-ecosystem
    retrieved: 2026-11-08
  - claim: "Asset Library API: filters, cost field as licence, no documented rate limits, soft deletion, maintenance mode"
    ref: src-gs-free-godot-ecosystem
    retrieved: 2026-11-08
  - claim: "Godot Shaders: CC0/MIT/GPL v3 per shader, licence covers only code"
    ref: src-gs-free-godot-ecosystem
    retrieved: 2026-11-08
  - claim: "Godot LICENSE.txt and licence of Godot-based tools"
    ref: src-gs-free-tool-licenses
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-asset-source-catalog]]"   # catalog of external providers
  - relates-to: "[[game-studio-asset-license-and-provenance-policy]]"   # policy that applies to these assets
  - relates-to: "[[gs-adr-free-and-open-source-first]]"   # libre-open resources
  - relates-to: "[[godot-index]]"   # Godot knowledge map
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** from preserved sources dated 2026-11-08 (paraphrased extractions of official pages); nothing downloaded or run. **Not legal advice.** `unverified` = not read on an official page. Proposals pending human review.


## Godot engine licence (documented, official page)
MIT. Your game's content is not covered by the engine licence; but shipping the engine binary means distributing its software, so include the copyright notice and licence text in your documentation (linking to the licence page from docs or credits is suggested). Bundled third-party libraries have their own compatible licences, listed in the repo's COPYRIGHT.txt. The page says it is not legal advice — confirm with a human.

## Godot Asset Library
- **Discovery is automatable:** a documented REST API (`GET /asset` with type, category, support level, search, submitter, cost/licence and Godot-version filters; up to 500 results per request; read access needs no token). Rate limits are not documented.
- **The licence is a label:** the `cost` field holds the licence name (e.g. GPLv3), must match the repository's LICENSE (full text plus copyright line), and has no machine-readable SPDX id. It does not prove the submitter owns bundled content (our reading).
- Assets are soft-deleted by owners/moderators; the backend is in maintenance mode; no Asset Library terms of service were found (`unverified`).
- Mostly addons, templates and demos, not art assets.

## Godot Shaders
Shaders may be used freely in personal and commercial products; each submitter picks **CC0, MIT or GPL v3** for the code; the licence covers only the shader code, not featured images or assets shown. Record each shader's licence in the registry; **GPL v3 shaders may raise copyleft questions for a shipped game — human review** (CC0/MIT preferred).

## Proposal
Use the Asset Library API for *discovery* of libre addons (filter by licence label, then read the repository LICENSE); treat the label as a hint, not as verification; keep third-party addon knowledge separate and version-pinned ([[game-studio-third-party-addon-knowledge]]); add the Godot MIT notice to the game's credits.

## See also
- [[game-studio-asset-source-catalog]] — other asset providers
- [[game-studio-asset-license-and-provenance-policy]] — policy that applies to these assets
- [[gs-adr-free-and-open-source-first]] — libre-open resources
- [[godot-index]] — Godot knowledge map

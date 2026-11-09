---
id: game-studio-reference-analysis-legal-boundary
type: concept
domain: game-studio
status: proposed
summary: "Learn transferable principles from existing games without copying protected content; what is safe to record and what needs human or legal review. No legal conclusions."
tags: [scope/game-analysis, scope/licensing]
sources:
  - claim: "Fair-use factors of 17 USC 107 and the open questions about screenshots, extraction and datamining are pointers only"
    ref: src-gs-design-reference-analysis-pointers-unverified
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-game-reference-analysis-method]]"   # method this boundary constrains
  - relates-to: "[[game-studio-asset-license-and-provenance-policy]]"   # asset licences are a separate question
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research dated 2026-11-08; no experiment was run and nothing is validated in production. Most design-theory sources could only be read as abstracts or summaries (several PDFs were unreadable), so these notes are `proposed` pointers with explicit caveats, not authoritative claims. Workflows described are `designed` only.

**Evidence classes used here:** *verified* = read on the cited page this session; *abstract-only* = abstract or search summary seen, full text not read; *interpretation* = our reasoning; *hypothesis* = untested; *unverified* = not confirmed.


> **Flagged for human/legal review. Not legal advice.** The statutory fair-use factors (purpose and character, nature of the work, amount and substantiality, effect on the market) were only seen through summaries of Copyright Office material; courts weigh them case by case.

## Proposed practice (our interpretation)
- **Safe to record:** notes, diagrams and structural descriptions in your own words, with short quotations at most; links to developer talks and postmortems.
- **Avoid in the repository:** screenshots, extracted or datamined assets, code, reproduced text, audio or music — these raise the amount-used and market-effect questions, and datamining may also breach a game's terms of use (no specific EULA checked).
- **Ideas versus expression:** mechanics and genre conventions are generally treated differently from expression, but that is a legal question outside this note.
- Record **principles**, not content: the purpose is to extract transferable design knowledge.

## Open
Publisher-specific datamining/ToS positions; whether short screenshots count as acceptable quotation; jurisdictional differences. A human decides case by case.

## See also
- [[game-studio-game-reference-analysis-method]]
- [[game-studio-asset-license-and-provenance-policy]] — asset licences are a separate question

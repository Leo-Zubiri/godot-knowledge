---
id: game-studio-prototype-vs-vertical-slice
type: concept
domain: game-studio
status: proposed
summary: "A prototype tests whether a game should be made; a vertical slice tests whether the team can make it — but sources disagree on the term, so each project must define its own."
tags: [dept/design]
sources:
  - claim: "Ismail: prototype is rough and disposable, slice is a production test; second-item timing for estimates"
    ref: src-gs-design-prototype-slice-docs
    retrieved: 2026-11-08
  - claim: "Keith: the term vertical slice has conflicting meanings; suggests game increment"
    ref: src-gs-design-prototype-slice-docs
    retrieved: 2026-11-08
  - claim: "Florencio: per-system prototypes, slice as readiness test, timeboxed pre-production"
    ref: src-gs-design-prototype-slice-docs
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-workflows]]"   # the vertical-slice workflow is a designed integration test
  - relates-to: "[[game-studio-acceptance-criteria]]"   # slice must pass the same gates
  - relates-to: "[[gs-adr-living-design-docs]]"   # documentation that accompanies pre-production
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research dated 2026-11-08; no experiment was run and nothing is validated in production. Most design-theory sources could only be read as abstracts or summaries (several PDFs were unreadable), so these notes are `proposed` pointers with explicit caveats, not authoritative claims. Workflows described are `designed` only.

**Evidence classes used here:** *verified* = read on the cited page this session; *abstract-only* = abstract or search summary seen, full text not read; *interpretation* = our reasoning; *hypothesis* = untested; *unverified* = not confirmed.


## The distinction (verified in the cited articles)
| | Prototype | Vertical slice |
|---|---|---|
| Question | *Should* we make this? | *Can* we make this? |
| Nature | Small, rough, disposable, one open question at a time | One functional segment built to near-shipping quality through the whole pipeline |
| Code/assets | Not carried into production | Representative of production |
| Estimating | — | The **second** item built is a much better basis for estimates than the first (Ismail) |

## Disagreement (verified)
Keith argues the term is used for different things and prefers "game increment": build a feature far enough to learn its value, then revise the plan; Gilbert (as summarised by Keith) treats slices as part of an upfront plan. Florencio treats the slice as the test of readiness for full production. So **define "vertical slice" explicitly per project** (design test or production test).

## Guidance sources agree on
Keep prototypes scoped and unpolished; prototype each core system, then test how they fit; timebox pre-production; define pipelines (handoff contents, naming, folders) early.

## For AI-assisted production (interpretation)
- An agent can build prototypes quickly and keep them in a separate folder from production code, and can check that a slice exercises the **full pipeline** (data, import, build, export) — mechanically verifiable ([[game-studio-acceptance-criteria]]).
- It cannot judge whether a prototype is fun or whether a slice proves the design; that needs human playtesting ([[game-studio-playtesting-methods]]).
- Failure modes: a prototype shipped as production code; a slice polished in one area only; treating the slice as proof of fun.

## See also
- [[game-studio-workflows]] — the vertical-slice workflow (designed)
- [[gs-adr-living-design-docs]] — documentation that accompanies pre-production

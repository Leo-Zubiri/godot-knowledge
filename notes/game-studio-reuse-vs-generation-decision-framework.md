---
id: game-studio-reuse-vs-generation-decision-framework
type: pattern
domain: game-studio
status: proposed
summary: "Decision order for choosing between reusing, modifying, combining, generating or creating an asset, or rejecting a candidate, weighing licence, fit, style, performance, time and cost."
sources:
  - claim: "Provider licences differ widely, so licence is evaluated first (per-asset, NC, ShareAlike, redistribution limits)"
    ref: src-gs-asset-cc-licenses
    retrieved: 2026-11-08
  - claim: "Paid marketplaces such as Fab allow commercial use with collaborator sharing, so paid assets can be viable"
    ref: src-gs-asset-marketplaces
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-asset-discovery-and-reuse-workflow]]"   # steps 3 and 11
  - relates-to: "[[game-studio-ai-generation]]"   # generated assets are the fallback and need cleanup/licence checks
  - relates-to: "[[game-studio-asset-license-and-provenance-policy]]"   # licence gate
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research dated 2026-11-08 from official provider pages (paraphrased extractions, not verbatim legal text); no asset was downloaded and nothing was executed. **Not legal advice.** Terms change; items marked `unverified` were not read on an official page. Classes and workflows are *proposals* pending human review; ambiguous cases must go to a human.


## Decision order (proposal)
1. **Licence gate:** reject NC/unknown; send BY-SA/custom/unread terms to human review.
2. **Technical fit:** format, rig, budget, import ([[game-studio-acceptance-criteria]]).
3. **Style consistency** with the project art direction.
4. **Performance** (poly, texture, memory).
5. **Time and cost** (tokens, API cost, human time — *not measured* in this research).

## Outcomes
| Situation | Action |
|---|---|
| Passes all gates | **Reuse unchanged** |
| Licence allows modification, partial fit | **Reuse and modify** (Blender/Material Maker/Krita) |
| Several partial fits with compatible licences | **Combine** |
| No adequate candidate; model licence permits | **Generate** with AI, then clean up and validate ([[game-studio-ai-generation]]) |
| Nothing suitable and generation inadequate | **Create manually** |
| Licence/technical/visual failure | **Reject** and record why |

## Cost note
Do not optimise only for free assets: a paid asset with a suitable licence can beat generating or hand-making an inferior one. Quality of the trade-off is unmeasured here.

## See also
- [[game-studio-asset-source-catalog]]

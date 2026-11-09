---
id: gs-adr-free-and-open-source-first
type: decision
domain: game-studio
status: proposed
summary: "Proposed: the studio prioritizes free, gratis and open-source tools, models and assets; gratis-restricted needs a licence check and paid/closed is a justified exception."
tags: [scope/licensing]
sources:
  - claim: "Licences and costs of tools, models and assets vary widely; clearly libre-open options exist for each department"
    ref: src-gs-asset-packs-3d-2d
    retrieved: 2026-11-08
  - claim: "Tool and model licence facts"
    ref: src-gs-image-model-licenses
    retrieved: 2026-11-08
  - claim: "Marketplace and provider terms"
    ref: src-gs-asset-marketplaces
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-cost-and-openness-classification]]"   # the tiers used by this decision
  - relates-to: "[[game-studio-reuse-vs-generation-decision-framework]]"   # applies the preference when choosing assets
  - relates-to: "[[gs-adr-blender-primary-3d]]"   # consistent: Blender and Godot are libre-open
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Context
The project owner stated the studio is interested in free, gratis and open-source resources. The research shows libre-open options for the core of the toolchain (Godot, Blender, gdUnit4, ComfyUI, Material Maker, CC0 assets) but also many gratis-restricted and paid options whose terms differ.

## Decision
Prefer libre-open tools, models and assets. Use gratis-restricted ones only after the licence is verified per asset/model. Treat paid or closed services as an exception that needs a recorded justification (clear advantage in quality, automation, reliability, cost or time). This is a *preference ordering*, not a ban: a paid asset with a suitable licence may still beat an inferior free one, and the justification must be recorded. `proposed`, pending human review.

## Consequences
- Catalogs and ratings gain a cost/openness dimension ([[game-studio-cost-and-openness-classification]]).
- Paid/closed items (Mixar backend, Aseprite, paid marketplaces, hosted generation APIs) default to `reference-only` or conditional.
- "Free" is never enough: per-asset licence checks, redistribution limits and AI-use clauses still apply.
- Open-weight models with caps or territory limits are not treated as libre-open.
- Cost/effort of paid alternatives is not measured here, so exceptions are judged case by case.

## See also
- [[game-studio-architecture-proposal]] — overall proposal
- [[game-studio-reuse-vs-generation-decision-framework]] — applies the preference when choosing assets
- [[gs-adr-blender-primary-3d]] — consistent: Blender and Godot are libre-open

---
id: game-studio-godot-skill-taxonomy
type: pattern
domain: agent-ops
status: proposed
summary: Organize Godot agent skills by engine domain, one folder per skill, with core, addon and process skills kept distinct and a small related-skills set.
tags: [scope/reference-study, dept/orchestration, tool/godot]
sources:
  - claim: "Reference layout: 59 skills as domain, addon and process skills; one folder each; related-skills line of 3-5 names"
    ref: src-gs-gp-skill-architecture
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-skills-architecture]]"   # this refines the Godot-specific domain split of skills vs adapters vs standards
  - relates-to: "[[game-studio-progressive-disclosure-routing]]"   # taxonomy is what routing indexes
  - relates-to: "[[godot-index]]"   # existing Godot knowledge map
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (GodotPrompter, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale is *proposal*, pending human review.


## Pattern
- **One skill per folder**, named by kebab-case, with a required `SKILL.md` whose `name` equals the folder (D).
- **Three kinds** (observed in the reference): *domain* skills (2d, 3d, physics, rendering, animation, UI, audio, multiplayer, XR, export, optimization, save-load, state-machine…), *addon* skills (five third-party addons), and *process* skills (brainstorming, mentor, code review, an index skill).
- **Related skills** listed as 3–5 plain names, validated to resolve; deeper material in `references/` (see [[game-studio-progressive-disclosure-routing]]).
- Keep **core vs addon knowledge separate** so addon facts never leak into core guidance ([[game-studio-third-party-addon-knowledge]]).

## For us (proposal; **adopt** structure, **adapt** granularity)
Use domain boundaries that mirror Godot's own areas and our departments; decide granularity from measured usefulness ([[game-studio-skill-eval-design]]) — the reference's own evals show some skills add little, so more skills is not automatically better. Nothing here fixes *which* skills we need; that remains open.

## Pitfalls
No mechanism was found for detecting contradictory advice between skills; duplication control relies on cross-reference checks only.

## See also
- [[game-studio-skills-architecture]] — skills vs adapters vs standards
- [[godot-index]] — existing Godot knowledge map

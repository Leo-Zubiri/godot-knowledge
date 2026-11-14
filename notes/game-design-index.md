---
id: game-design-index
type: index
domain: game-design
summary: "Map of content for game design: theory vocabulary, prototypes and vertical slices, playtesting, living design documents, analysing existing games, and accessibility — engine-agnostic principles with explicit evidence caveats."
related:
  - relates-to: "[[game-studio-index]]"   # game production knowledge
  - relates-to: "[[godot-index]]"   # Godot engine knowledge
  - relates-to: "[[agent-ops-index]]"   # agent operations
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Game design — map of content
Navigational only; no claims. Engine-agnostic design principles. Evidence is mixed: MDA, the HEP heuristics and Valve's playtesting slides were read in primary form; flow, SDT and typology sources are abstract-level. All claim-bearing notes are `proposed`.

### Theory and vocabulary
- [[game-studio-game-design-theory-vocabulary]]

### Production practice
- [[game-studio-prototype-vs-vertical-slice]] · [[gs-adr-living-design-docs]]

### Validation with players
- [[game-studio-playtesting-methods]] · [[game-studio-accessibility-minimums]]

### Learning from existing games
- [[game-studio-game-reference-analysis-method]] · [[game-studio-reference-analysis-legal-boundary]]

### Progression, readability and animation
- [[game-studio-game-usability-heuristics-pinelle]] · [[game-studio-progression-loops-and-dda]] · [[game-studio-art-readability-silhouette-and-animation-principles]]

### Scoping and input conventions
- [[game-design-scoping-questions-for-new-game-or-feature]] — question bank for "make a game of X" / "add feature Y": read the repo first, ≤5 Tier-0 questions with defaults, answers into ADRs (lessons section unreviewed)
- [[game-design-input-mapping-conventions-keyboard-gamepad-touch]] — per-device and per-genre control defaults, face-button equivalence, touch target sizes, Steam Deck items, Godot 4.7 bridge (ui_* defaults as read in the 4.7-stable source)

### Genre mechanics
- [[game-design-billiards-pool-physics-model]] — correct pool/billiards physics for a game: sliding→rolling states (constant rolling decel ≈0.1 m/s²), ball-ball e_b=0.95 + throw, spin from tip offset, non-specular cushions (nose 0.635·D), analytic-event-based vs rigid-body engine, rail-hugging fix, and a starting parameter set.

- [[game-design-pool-cpu-opponent-ghost-ball-planner]] — a pool/billiards CPU opponent: pure ghost-ball planner, power from a calibrated effective deceleration, difficulty as deliberate error, measured pot rates (unreviewed).
- [[game-design-pool-view-camera-aim-and-spin-ux]] — UX pattern for a playable 3D pool view: camera behind the shot, overview while rolling, ghost-ball aim prediction, tip (spin) selector, ball-in-hand placement, pattern+number readability (unreviewed).

### Known gaps (no primary source read yet)
Reward-design evidence, difficulty-curve construction beyond the Hamlet pointer, scope planning for small teams, per-genre conventions, art-bible primary sources (progression vocabulary and silhouette/animation notes now exist but are pointer-level).

### Sources
Design sources (`src-gs-design-*`) are listed in [[game-studio-sources-index]]; accessibility and loudness sources are in the same hub.

## See also
- [[game-studio-index]] — game production knowledge
- [[godot-index]] — Godot engine knowledge
- [[agent-ops-index]] — agent operations

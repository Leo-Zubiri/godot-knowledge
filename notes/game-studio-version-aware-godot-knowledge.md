---
id: game-studio-version-aware-godot-knowledge
type: pattern
domain: agent-ops
status: proposed
summary: Keep Godot knowledge tied to an explicit baseline version, annotate newer-version sections, correct errors visibly, and prioritize recent engine changes where models are weakest.
tags: [scope/reference-study, tool/godot]
sources:
  - claim: "Baseline 4.3+, newer 4.5-4.7 features as annotated sections; corrections found while fact-checking"
    ref: src-gs-gp-repo-overview
    retrieved: 2026-11-08
  - claim: "Evals: biggest gains on Godot 4.7 behaviour changes (+0.69 mean over four cases), small on mainstream knowledge (project-reported)"
    ref: src-gs-gp-evals
    retrieved: 2026-11-08
related:
  - depends-on: "[[godot-version-policy]]"   # existing policy: target Godot 4.7.x and version-scoped claims
  - relates-to: "[[game-studio-skill-eval-design]]"   # how the 'recency edge' was measured
  - relates-to: "[[knowledge-availability-vs-application]]"   # available knowledge is not applied knowledge
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (GodotPrompter, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale is *proposal*, pending human review.


## Pattern
- State one **baseline** and an explicit **target** (for us: 4.7.x per [[godot-version-policy]]); mark version-specific claims inline with the version where behaviour changed.
- **Correction trail:** the reference fixed wrong claims (e.g. a fog-blending change attributed to the wrong version) and left a dated research note unchanged — fixing the guidance while keeping the history.
- **Where knowledge pays:** the project reports that skills helped mainly on recent engine changes (4.7 input device IDs, BlendSpace sync enum, RichText image units, audio-bus default) and on judgement calls, and much less on mainstream Godot knowledge the bare model already has (P, model-judged, noisy, small samples).

## For us (proposal)
Prioritise knowledge that is *recent, version-specific and checkable* (release notes, upgrade guides, behaviour changes) over restating mainstream tutorials; every such claim cites a preserved source with a version; stale or corrected claims are recorded, not silently overwritten.

## Caveat
The evidence for the recency edge is one project's evals and not independently verified; no automated 4.7 example validation exists there ([[game-studio-godot-example-verification]]).

## See also
- [[godot-version-policy]] — our version scoping
- [[game-studio-skill-eval-design]] — how the 'recency edge' was measured
- [[knowledge-availability-vs-application]] — available knowledge is not applied knowledge

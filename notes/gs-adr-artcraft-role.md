---
id: gs-adr-artcraft-role
type: decision
domain: game-studio
status: proposed
summary: "Proposed: ArtCraft apps are Experimental/Complementary per app, not primary departments, until end-to-end tests and tagged releases exist."
sources:
  - claim: "Per-app ArtCraft evidence and self-reported maturity"
    ref: src-gs-artcraft-suite
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-artcraft-evaluation]]"   # evidence
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Context
Interfaces look agent-friendly but apps are weeks old, pre-1.0, with no Godot-specific export and unverified popularity.

## Decision
Do not make ArtCraft primary for texturing/materials; use Material Maker/Blender/Krita/Inkscape/ffmpeg as the baseline and re-evaluate apps individually.

## Consequences
Possible later adoption (e.g. MaterialCraft or SoundCraft) after hands-on authorized tests; trademark exclusion applies to forks.

## See also
- [[game-studio-architecture-proposal]] — overall proposal
- [[game-studio-artcraft-evaluation]] — evidence

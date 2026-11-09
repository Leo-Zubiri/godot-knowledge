---
id: game-studio-review-modes-and-verdicts
type: pattern
domain: game-studio
status: proposed
summary: Review intensity as solo/lean/full modes and a gate verdict vocabulary where a missing input is NOT ASSESSED and never counts as approval; strictest verdict wins.
tags: [scope/reference-study, dept/qa]
sources:
  - claim: "Review modes, gate IDs, verdict semantics and parallel-gate rules"
    ref: src-gs-ccgs-workflow-rigor-and-gates
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-configurable-rigor]]"   # review mode is a rigor knob
  - relates-to: "[[game-studio-acceptance-criteria]]"   # verdicts apply to those criteria
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (Claude-Code-Game-Studios, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale below is *proposal*, pending human review.


## Pattern (documented; mode default **adopt**, gate machinery **adapt**)
- **Modes:** solo (no gates, default), lean (only phase-transition gates), full (all gates at each workflow step).
- **Verdicts:** ready/concerns/not-ready plus **NOT ASSESSED** = a required input was missing, so no judgment was made; it is *never* treated as approval.
- **Parallel reviews:** issue all reviewer calls before awaiting results; the strictest verdict wins (not-ready → fail; concerns cap the result; not-assessed blocks a clean pass).
- **Indirection:** a gate is referenced by ID and its definition lives in one file the reviewing agent reads itself, so callers do not carry the prompt.

## For us (proposal)
Keep the vocabulary and the "unknown is not a pass" rule in our acceptance reports ([[game-studio-acceptance-criteria]]). Implement phase gates as a thin script/command that runs checks and records a verdict; avoid per-step director spawning by default.

## See also
- [[game-studio-configurable-rigor]] — default mode

---
id: game-studio-configurable-rigor
type: pattern
domain: game-studio
status: proposed
summary: One rigor dial (minimal/standard/full) that expands into explicit workflow knobs, default minimal, with documented precedence and overrides.
sources:
  - claim: "Rigor tiers, required artifacts per tier, override rules and companion knobs"
    ref: src-gs-ccgs-workflow-rigor-and-gates
    retrieved: 2026-11-08
  - claim: "project.yaml model and config precedence"
    ref: src-gs-ccgs-repo-overview
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-review-modes-and-verdicts]]"   # review mode is one of the knobs
  - relates-to: "[[game-studio-token-efficient-workflows]]"   # lower rigor = less documentation overhead
  - relates-to: "[[game-studio-workflows]]"   # where rigor would apply
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (Claude-Code-Game-Studios, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale below is *proposal*, pending human review.


## Problem
A fixed heavy process wastes agent work on small tasks; a fixed light one under-protects large ones.

## Pattern (documented; **adapt**)
- A single setting `rigor ∈ {minimal, standard, full}` (default minimal) expands into several knobs: workflow tier, documentation density, QA level, story granularity, review mode, team size. Any knob can be set explicitly and then wins.
- Required artifacts grow by tier: minimal = a one-page brief + engine choice; standard = a reduced design-doc section set, one architecture doc, critical decisions; full = everything incl. art bible and UX specs.
- Precedence is explicit and traceable: personal local override → project config → legacy fallback → rigor expansion → documented defaults; invalid values are skipped and reported, and each resolved value shows its source.
- Gotcha documented by the reference: a per-system override can *lower* requirements to zero, so it is not a safe no-op.

## Project-reported evidence (P, unverified)
Four games from one brief at different rigor levels; minimal wrote 1 document before code, standard wrote 30 (58 minutes) and was ranked last by two blind reviewers and a human playtest — "traceability, not a better game". Only two levels reported; games unpublished; single run.

## For us (proposal)
Adopt *default-minimal* and the *single dial with overridable knobs*; reject the 30-document standard flow as a default. Express the config as a small plain file read by scripts so all three agents get identical resolution.

## See also
- [[game-studio-review-modes-and-verdicts]] — the review knob in detail
- [[game-studio-token-efficient-workflows]] — lower rigor = less documentation overhead
- [[game-studio-workflows]] — where rigor would apply

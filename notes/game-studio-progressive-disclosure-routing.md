---
id: game-studio-progressive-disclosure-routing
type: pattern
domain: game-studio
status: proposed
summary: "Keep always-loaded context tiny: trigger-style descriptions, a generated index, an optional small routing card, and depth in on-demand reference files with hard size caps."
sources:
  - claim: "Reference size caps (SKILL.md 16 KB, session card 3 KB), references folder, 'Use when' descriptions, generated index.json"
    ref: src-gs-gp-skill-architecture
    retrieved: 2026-11-08
  - claim: "SessionStart card gated by project.godot; hook script larger than the card; subagents do not get the hook"
    ref: src-gs-gp-repo-overview
    retrieved: 2026-11-08
  - claim: "Evals found description-only routing unreliable for some skills (one fired in 1 of 3 runs)"
    ref: src-gs-gp-evals
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-token-efficient-workflows]]"   # same goal: avoid loading everything
  - relates-to: "[[game-studio-skill-validation-architecture]]"   # caps and index are enforced by validators
  - relates-to: "[[game-studio-godot-skill-taxonomy]]"   # what gets routed
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (GodotPrompter, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale is *proposal*, pending human review.


## Layers (documented in the reference; **adapt**)
1. **Description** (always visible to the agent): starts with a "Use when…" trigger sentence, standard frontmatter only.
2. **Generated index** (`index.json`: name, title, description, related skills, addon flag, references): lets an agent find skills without scanning all of them.
3. **Routing card** injected at session start only when a `project.godot` is nearby (no network, writes nothing); capped (~3 KB).
4. **Skill body** capped (16 KB hard, ~15.5 KB warning); **references** loaded on demand, no cap, but must be linked or they are flagged as orphans.

## Observed weaknesses
- Description-only routing was unreliable for some skills in the project's own evals (P): one skill fired in 1 of 3 runs, attributed to its description.
- The hook that emits the card is Claude/Cursor-specific; subagents do not receive it, so the plugin offers to add a section to the repo's instruction file.
- Every new skill must be wired by hand into several places (README, index skill, card, agent routing) — a drift risk partly guarded by generated-file checks.

## For us (proposal)
Keep layers 1, 2 and 4; make the index generated and checked; give the card a portable fallback in AGENTS.md instead of relying on hooks; choose our own size limits and measure them (cost of loading is *not measured* here).

## See also
- [[game-studio-token-efficient-workflows]] — wider token levers

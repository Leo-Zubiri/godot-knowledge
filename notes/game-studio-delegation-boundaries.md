---
id: game-studio-delegation-boundaries
type: pattern
domain: game-studio
status: proposed
summary: Give each agent a domain, let peers consult but not decide outside it, escalate disputes to the nearest shared parent, and let one coordinator propagate cross-domain changes.
sources:
  - claim: "Reference delegation, consultation, conflict-resolution and change-propagation rules"
    ref: src-gs-ccgs-agent-topology
    retrieved: 2026-11-08
  - claim: "Reference skill rubric checks that agents stay in domain and escalate cross-department conflicts"
    ref: src-gs-ccgs-workflow-rigor-and-gates
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-multiagent-topology]]"   # applies to whatever roles exist
  - relates-to: "[[game-studio-skills-architecture]]"   # skills vs adapters vs standards split
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (Claude-Code-Game-Studios, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale below is *proposal*, pending human review. Reusable skills/tooling belong in `godot-ai-toolkit`, not here.


## Problem
Without explicit boundaries, agents overlap, overrule each other, or silently change another department's output.

## Pattern (documented in the reference; **adapt**)
- **Vertical:** tasks flow from lead to specialist; for complex decisions no tier is skipped.
- **Horizontal:** same-level agents may ask each other for input but cannot make binding decisions outside their own domain.
- **Conflict:** dispute goes to the shared parent; if none exists, design disputes go to the design authority and technical disputes to the technical authority.
- **Propagation:** when a change touches several domains, one coordinator role sequences the updates.

## Adaptation for our studio (proposal)
Our departments (3D art, materials, audio, UI, level, game dev, QA) already have owners; the *return path* matters most: a failed validation report routes back to the owning department (see [[game-studio-workflows]]). Keep boundaries in plain AGENTS.md text so Codex and OpenCode can follow them; the reference's enforcement is Claude-specific and unverified elsewhere.

## Pitfalls
Boundaries written as prose are advisory; enforce with checks and review ([[game-studio-path-scoped-safety]]).

## See also
- [[game-studio-multiagent-topology]] — how many roles

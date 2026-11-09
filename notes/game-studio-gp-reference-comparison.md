---
id: game-studio-gp-reference-comparison
type: reference
domain: game-studio
status: proposed
summary: Classification (adopt/adapt/reference-only/reject/unverified) of GodotPrompter patterns against a version-pinned, explicit-update, multi-agent-compatible Godot knowledge ecosystem.
tags: [scope/reference-study]
sources:
  - claim: "Repo facts, licence scope, provenance, README claims"
    ref: src-gs-gp-repo-overview
    retrieved: 2026-11-08
  - claim: "Skill format, addon policy, agents"
    ref: src-gs-gp-skill-architecture
    retrieved: 2026-11-08
  - claim: "Validator, scripts, CI"
    ref: src-gs-gp-validation-ci
    retrieved: 2026-11-08
  - claim: "Platform matrix, install docs, hooks, test plan"
    ref: src-gs-gp-platforms-and-hooks
    retrieved: 2026-11-08
  - claim: "Evals and corrections"
    ref: src-gs-gp-evals
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-ccgs-reference-comparison]]"   # companion reference study
  - relates-to: "[[game-studio-architecture-proposal]]"   # feeds the overall proposal
  - relates-to: "[[game-studio-godot-skill-taxonomy]]"   # taxonomy classification
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (GodotPrompter, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale is *proposal*, pending human review.


## Scope and licence
MIT, "GodotPrompter Contributors 2026"; no carve-outs in the text. Built on the "Superpowers" Claude Code plugin; the hook's Windows wrapper and JSON escaping are adapted from it under MIT; other reused material and addon licences were not audited (`unverified`). Single maintainer; ~938 stars (no anomaly for its age); releases every 1–3 weeks. Not copied; not a dependency.

## Classification
| Pattern | Class | Why |
|---|---|---|
| Domain-per-folder skills, standard `name`+`description` only | adopt | Portable → [[game-studio-godot-skill-taxonomy]] |
| "Use when…" trigger descriptions | adopt | Cheap, standard |
| Size cap with overflow to `references/` | adapt | Pick and measure our own limit → [[game-studio-progressive-disclosure-routing]] |
| Generated index with `--check` | adapt | Avoid hand-wiring in many places |
| Cross-reference/orphan validation | adopt | → [[game-studio-skill-validation-architecture]] |
| Reasoned exemption markers | adapt | For any rule exception |
| Validator self-test on broken fixtures | adopt | Detects disabled rules |
| Host smoke matrix + metadata validator | adapt | Needs recorded results → [[game-studio-platform-portability-matrix]] |
| Denylist of nonexistent APIs | adapt | Only catches known mistakes |
| Parse/compile examples in CI against pinned Godot | adopt (gap to fill) | Reference does not do it → [[game-studio-godot-example-verification]] |
| C# parity warnings | reference-only | Only if C# is shipped |
| Ablation evals, model judge | adapt | Noisy → [[game-studio-skill-eval-design]] |
| Routing card gated by `project.godot` | adapt | Hook is host-specific; keep AGENTS.md fallback |
| Addon skills pinned to tag + cited facts | adapt | → [[game-studio-third-party-addon-knowledge]] |
| Annotated newer-version sections + correction trail | adapt | → [[game-studio-version-aware-godot-knowledge]] |
| Nine specialized agents | reference-only / unverified | No evidence of value vs skills + few roles; see [[game-studio-multiagent-topology]] |
| Mentor mode | reject (for now) | Outside our production goal (inference) |
| Marketplace/bundle publishing, auto-update paths | reference-only | We prefer explicit pinned updates |
| Tag-pinned OpenCode install | adopt | Matches explicit updates |
| Symlink install that updates on `git pull` | reject | Silent updates |
| README claim "all examples parsed/compiled" | unverified | No repeatable check found |

## Open
Eight of nine agents, most skills, `hooks/session-start`, `plugin-scan.yml`, the contents of hook/OpenCode tests, release history before v1.9.0, per-domain maturity, contradictions between skills, token measurements.

## See also
- [[game-studio-ccgs-reference-comparison]] — the other reference study
- [[game-studio-architecture-proposal]] — feeds the overall proposal

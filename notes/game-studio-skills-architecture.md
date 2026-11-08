---
id: game-studio-skills-architecture
type: reference
domain: game-studio
status: proposed
summary: Proposed split of shared game-development skills, tool adapters and production standards, kept vendor-neutral.
sources:
  - claim: "Standard SKILL.md/AGENTS.md portability constraints"
    ref: src-gs-agent-instructions-portability
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-agent-orchestration]]"   # portability constraints
  - relates-to: "[[game-studio-asset-conventions]]"   # standards layer
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Everything here is a *proposal* pending human review.


## Three layers (design proposal — not sourced beyond portability facts)
| Layer | Answers | Vendor-specific? |
|---|---|---|
| **Skills** | *How* to perform a production task (e.g. `3d-modeling`) | No — standard `SKILL.md` fields only |
| **Tool adapters** | *How to run it* through Blender, Material Maker, Godot, etc. (commands, parameters, outputs, failure modes) | Per tool, never per agent vendor |
| **Production standards** | Quality, formats, conventions, acceptance criteria | No |

A general skill must not name a single application; it points to an adapter.

## Candidate skills
game-art-direction · 3d-modeling · 3d-character-creation · 3d-texturing · procedural-materials · 3d-animation · 2d-art · pixel-art · ui-design · level-design · vfx · audio-design · godot-integration · asset-optimization · asset-validation · game-qa.

## Rules
Use only `name`/`description`/`license`/`compatibility`/`metadata`; avoid Claude hooks, `context: fork`, Codex `openai.yaml` in shared skills; one skill location with copies/symlinks per agent if needed; keep skills small to limit context.

## Godot-specific refinement
A second reference study refines the skills layer for Godot: [[game-studio-godot-skill-taxonomy]], [[game-studio-progressive-disclosure-routing]], [[game-studio-skill-validation-architecture]].

## See also
- [[game-studio-asset-conventions]]

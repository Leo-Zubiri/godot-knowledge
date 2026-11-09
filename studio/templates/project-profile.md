---
profile_version: 1
project: <name>
engine: "Godot 4.7.2"
language: gdscript            # gdscript | csharp | mixed
dimension: 3d                 # 2d | 3d | both
renderer: mobile              # forward_plus | mobile | compatibility
physics: jolt                 # godot | jolt
platforms: [linux, windows, android]   # + ios, web, console
input: [keyboard, gamepad, touch]
players:
  local: hot-seat             # none | single | hot-seat | multi-controller
  lan: host-authoritative     # none | host-authoritative
  online: none                # none | relay | dedicated
monetization: cosmetics-later # none | premium | cosmetics | cosmetics-later | ads | subscription
licensing: { tools: foss-only, assets: cc0-or-own, repo: private, ai_assets: disallowed }
i18n: [es, en]
rigor: medium                 # minimal | medium | full   (game-studio-configurable-rigor)
budgets: { build_mb: 60, frame_ms: 16.6, tris: 150000, dynamic_lights: 2 }
plans_dir: docs/plans
active_plan: <YYYY-MM-DD_slug>
adr_dir: <path to ADR folder>
always_notes: [godot-index, godot-version-policy, game-studio-tool-selection-guide]
skip_tags: [dim/2d]
knowledge_gaps: []            # generic topics still missing in the knowledge base
updated: <YYYY-MM-DD>
---

# Project profile — <name>

Read first by any agent (`game-studio-game-project-profile`). Keep it short; decisions live in ADRs.

## Pitch
<one sentence>

## Pillars
1. …

## What v1 is / is not
- In: …
- Out: …

## Routing for agents
| Domain | Load when | Entry |
|---|---|---|
| godot | engine work | `godot-index` |
| game-design | design, validation | `game-design-index` |
| game-studio | tools, assets, delivery | `game-studio-index` |
| agent-ops | agents, permissions, knowledge | `agent-ops-index` |

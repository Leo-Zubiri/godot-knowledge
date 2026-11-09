---
id: godot-navigation-overview
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 navigation: server, regions, agents and obstacles, the first-frame map synchronization pitfall, agent usage rules, and baking caveats; headless baking is not documented."
tags: [dept/game-dev, dept/level-design, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Navigation introduction and agents pages re-read for 4.7; navigation-mesh baking details per research subagent"
    ref: src-gd-navigation
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-level-design]]"   # imported levels use -navmesh hints
  - relates-to: "[[godot-physics-bodies-layers-and-interpolation]]"   # agents move bodies
  - relates-to: "[[godot-level-building-blocks]]"   # GridMap navigation
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


## Components
NavigationServer3D (maps, regions, links, agents, obstacles by RID); NavigationRegion3D (holds a NavigationMesh); NavigationLink3D (connects two points; traversal must be scripted); NavigationAgent3D (helper wrapping server calls); NavigationObstacle3D (avoidance only, does not change routes); NavigationMesh (resource).

## Pitfalls and rules (documented)
- **First-frame sync:** the map does not sync region data until after the first physics frame, so early queries return an empty path and the agent thinks it is finished. Set the target after one physics frame (call setup deferred; do not `await` in `_ready`).
- The system never moves the parent node. Call `get_next_path_position()` once per **physics** frame and only while `is_navigation_finished()` is false.
- Avoidance: `avoidance_enabled`, connect `velocity_computed`, move by the safe velocity; set a target even for avoidance only; avoidance ignores navigation meshes and physics colliders and does not change pathfinding.
- Retargeting every frame makes agents jitter; fast agents can overshoot waypoint distance and backtrack; agents on mesh edges may briefly face backward.
- **Baking (subagent):** editor bake or runtime `bake_navigation_mesh(on_thread)`; scene-tree parsing must run on the main thread; reading visual meshes at runtime stalls the RenderingServer (prefer physics shapes); a very small `cell_size`/`cell_height` can freeze or crash.
- **Headless baking and CLI baking are not discussed on these pages (*unverified*).** 2D navigation mirrors 3D per the pages but was not read separately.

## What an agent can and cannot check
Property names and call order are checkable by reading scripts. Whether a navmesh covers a level, and agent behaviour, need the engine.

## See also
- [[game-studio-level-design]] — level pipeline
- [[godot-physics-bodies-layers-and-interpolation]] — agents move bodies
- [[godot-level-building-blocks]] — GridMap navigation

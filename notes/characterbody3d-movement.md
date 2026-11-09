---
id: characterbody3d-movement
type: pattern
domain: godot
status: proposed
summary: "Move a 3D character with CharacterBody3D: set velocity (m/s), apply gravity, call move_and_slide(), and use the documented floor, wall and slide properties."
tags: [dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "CharacterBody3D class page re-read for 4.7: properties, defaults and methods"
    ref: src-gd-physics
    retrieved: 2026-11-08
related:
  - relates-to: "[[characterbody2d-movement]]"   # same pattern in 2D
  - relates-to: "[[godot-physics-bodies-layers-and-interpolation]]"   # layers and interpolation
  - relates-to: "[[input-handling]]"   # movement reads input actions
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


## Documented properties (defaults, class page 4.7)
`motion_mode` 0 (`MOTION_MODE_GROUNDED`; also `MOTION_MODE_FLOATING`), `up_direction` Vector3(0,1,0), `floor_max_angle` 45°, `floor_snap_length` 0.1, `floor_stop_on_slope` true, `floor_constant_speed` false, `floor_block_on_wall` true, `wall_min_slide_angle` 15°, `max_slides` 6, `slide_on_ceiling` true, `velocity`.

## Methods
`move_and_slide()`, `apply_floor_snap()`, `get_floor_normal()`, `get_floor_angle()`, `get_wall_normal()`, `get_real_velocity()`, `get_last_motion()`, `get_position_delta()`, `get_slide_collision()`, `get_slide_collision_count()`, `get_last_slide_collision()`, `is_on_floor()`/`is_on_wall()`/`is_on_ceiling()` and their `_only` variants.

## Pattern (interpretation, mirrors the 2D note)
Read input in `_physics_process`, set `velocity`, add gravity as acceleration, call `move_and_slide()` without arguments, then query `is_on_floor()`. Per the physics docs do not multiply velocity by `delta` with `move_and_slide()`. Velocity is in meters per second. No official 3D character tutorial page was read (the docs show 2D and say concepts apply), so treat the pattern text as derived from the class reference, not a verified recipe.

## What an agent can and cannot check
Names and defaults can be checked against the class reference; behaviour (slopes, snapping, platform leave) needs the engine.

## See also
- [[characterbody2d-movement]] — the 2D equivalent
- [[godot-physics-bodies-layers-and-interpolation]] — layers and interpolation
- [[input-handling]] — movement reads input actions

---
id: src-gd-physics
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/physics/physics_introduction.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/physics/physics_introduction.html"
    - "https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html"
    - "https://docs.godotengine.org/en/stable/classes/class_characterbody3d.html"
    - "https://docs.godotengine.org/en/stable/tutorials/physics/interpolation/physics_interpolation_introduction.html"
    - "https://docs.godotengine.org/en/stable/tutorials/physics/interpolation/physics_interpolation_quick_start_guide.html"
  title: "Godot 4.7 physics: bodies, layers, CharacterBody3D, physics interpolation"
  retrieved: 2026-11-08
  version: "4.7 — intro, CharacterBody3D and interpolation quick start re-read by the main agent"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot documentation pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. **Version:** page headers say *Godot Engine 4.7 documentation* — confirmed by the main agent on the pages listed under "re-read", reported by research subagents for the others; pages carrying their own "may be outdated for 4.7" notice are flagged. Documentation only: nothing here was run in the engine, so behaviour claims are *documented*, not *experimentally validated*. Re-fetch before promoting dependent notes to `verified`.

- **Physics introduction (re-read, 4.7):** four collision object types — Area2D (detects overlaps, can override properties like gravity), StaticBody2D (fixed environment), RigidBody2D (driven by simulated forces), CharacterBody2D (detects collisions, movement needs code). Each object has 32 layers: *layer* = which groups it belongs to, *mask* = which groups it checks. Physics runs at a fixed rate (default 60/s) that usually differs from the display rate, so physics-dependent code belongs in the physics callback; **Godot's physics does not guarantee repeatable outcomes**. The page's concepts are shown in 2D and apply in 3D.
- **Per subagent (4.7 header reported):** RigidBody — do not set `position`/`linear_velocity` directly; change state in `_integrate_forces()` using `PhysicsDirectBodyState2D`; sleeping bodies do not call it; contact reports need `contact_monitor` and `max_contacts_reported`. CharacterBody — use `move_and_collide()` or `move_and_slide()`; with `move_and_slide()` do not multiply velocity by `delta` (gravity as acceleration is still scaled). Layers set via `set_collision_layer_value()`/`set_collision_mask_value()`, named in Project Settings, `@export_flags_2d_physics` picker, defaults layer 1/mask 1. "Never scale your collision shapes in the editor" — use size handles.
- **CharacterBody3D (re-read, 4.7):** properties and defaults — `floor_block_on_wall` true, `floor_constant_speed` false, `floor_max_angle` 0.7853982 (45°), `floor_snap_length` 0.1, `floor_stop_on_slope` true, `max_slides` 6, `motion_mode` 0 (MOTION_MODE_GROUNDED; also MOTION_MODE_FLOATING), `slide_on_ceiling` true, `up_direction` Vector3(0,1,0), `wall_min_slide_angle` 0.2617994 (15°), `velocity`. Methods: `move_and_slide()`, `apply_floor_snap()`, `get_floor_angle()`, `get_floor_normal()`, `get_wall_normal()`, `get_last_motion()`, `get_real_velocity()`, `get_position_delta()`, `get_last_slide_collision()`, `get_slide_collision()`, `get_slide_collision_count()`, `is_on_floor()`/`is_on_floor_only()`, `is_on_wall()`/`is_on_wall_only()`, `is_on_ceiling()`/`is_on_ceiling_only()`. Velocity is in meters per second (subagent).
- **Physics interpolation (quick start re-read, 4.7):** enable it in Project Settings > Physics > Common; move nodes and run game logic in the physics callback (also indirect movement via parents or automatic movers); after first placing or teleporting a node call its physics-interpolation reset to avoid streaking; to compare, temporarily lower physics ticks per second to 10. Per subagent: disabled by default; displayed positions lag by 1–2 ticks and it may add input delay. Which 4.x release introduced it was not confirmed; the per-node interpolation mode property was not on the pages read (unverified).
- Not covered: 3D-specific rigid/static body differences and a 3D character tutorial (the 2D page says the concepts apply).

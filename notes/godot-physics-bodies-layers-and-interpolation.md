---
id: godot-physics-bodies-layers-and-interpolation
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 physics: body types, 32 collision layers and masks, fixed-rate physics with no determinism guarantee, and the opt-in physics interpolation rules."
tags: [dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Physics introduction and interpolation quick start re-read for 4.7; further details per research subagent"
    ref: src-gd-physics
    retrieved: 2026-11-08
related:
  - relates-to: "[[characterbody2d-movement]]"   # 2D character movement
  - relates-to: "[[characterbody3d-movement]]"   # 3D character movement
  - relates-to: "[[area2d-detection]]"   # layers and masks in practice
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **Body types:** Area (detects overlaps, can override gravity), StaticBody (fixed), RigidBody (simulated by forces), CharacterBody (detects collisions; movement needs code).
- **Layers/masks:** 32 layers per object; *layer* = which groups it belongs to, *mask* = which it checks. Name layers in Project Settings; set with `set_collision_layer_value()`/`set_collision_mask_value()`; `@export_flags_2d_physics` gives a picker; defaults layer 1/mask 1. **Never scale collision shapes in the editor** — use the size handles (subagent, 4.7 header).
- **Fixed rate:** default 60 physics ticks/s, usually different from the display rate, so physics-dependent code belongs in `_physics_process`. **Godot's physics does not guarantee repeatable outcomes.**
- **RigidBody:** do not set `position`/`linear_velocity` directly; use `_integrate_forces()`; sleeping bodies do not call it; contact reports need `contact_monitor` and `max_contacts_reported` (subagent).
- **Physics interpolation (opt-in):** enable in Project Settings > Physics > Common; move nodes and run logic in the physics callback (also indirect movement through parents); after first placing or teleporting a node call its physics-interpolation reset to avoid streaking. Subagent: it adds 1–2 ticks of display lag and may add input delay. Introduction release unconfirmed; per-node interpolation mode property not on the pages read.
- The introduction shows 2D pages and says concepts apply in 3D; 3D body differences are not covered.
- **Changing the tick rate at runtime *(verified-in-engine 2026-11-10, Godot 4.7.2)*:** `Engine.physics_ticks_per_second` can be set at runtime (e.g. a different rate per scene/minigame) and restored cleanly. With physics interpolation **on**, call `reset_physics_interpolation()` on the affected subtree right after changing the rate — the same reset as after a teleport — to avoid a one-frame interpolation artifact; whether the artifact actually shows without it was not confirmed (needs a display), so apply the reset defensively. Raising the rate well above 60 should also raise `Engine.max_physics_steps_per_frame`. In a headless test, `await get_tree().physics_frame` does advance the physics frame counter, so tick behaviour is testable without a window. See [[godot-minigame-collection-architecture]] for the per-scene apply/restore handshake.

## What an agent can and cannot check
Layer/mask settings, collision-shape scale and `velocity * delta` mistakes are checkable by reading `.tscn`/`project.godot`/scripts. Feel, jitter, tunnelling and interpolation need the engine.

## See also
- [[characterbody3d-movement]] — 3D movement
- [[characterbody2d-movement]] — 2D character movement
- [[area2d-detection]] — layers and masks in practice

---
id: src-characterbody2d
type: source
domain: godot
source:
  url: https://docs.godotengine.org/en/4.7/tutorials/physics/using_character_body_2d.html
  title: "Using CharacterBody2D / CharacterBody2D class — Godot Engine 4.7 docs"
  retrieved: 2026-11-08
  version: "4.7"
  capture: paraphrased
created: 2026-11-08
updated: 2026-11-08
---

> Preserved as a pinned reference to the official Godot 4.7 docs. See also the class reference
> (https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html). Full originals at the URLs.

Key points relied on (Godot 4.7):
- `CharacterBody2D` is for bodies moved by code with collision response (players, simple enemies). It exposes a built-in
  **`velocity: Vector2`** property.
- Movement is applied by calling **`move_and_slide()`** with **no arguments** in Godot 4.x — it reads and updates
  `velocity`. (In Godot 3.x it was `move_and_slide(velocity)` — a breaking change.)
- Floor/wall/ceiling state after moving: **`is_on_floor()`**, `is_on_wall()`, `is_on_ceiling()`.
- Gravity is **not automatic**; apply it per physics frame. The Godot 4.x default script template uses
  `velocity += get_gravity() * delta` (project gravity is also readable via
  `ProjectSettings.get_setting("physics/2d/default_gravity")`).
- Move in **`_physics_process(delta)`** (fixed timestep), not `_process`.
- Requires a `CollisionShape2D` child to collide.

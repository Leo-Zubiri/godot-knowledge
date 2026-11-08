---
id: src-area2d
type: source
domain: godot
source:
  url: https://docs.godotengine.org/en/4.7/classes/class_area2d.html
  title: "Area2D class reference — Godot Engine 4.7 docs"
  retrieved: 2026-11-08
  version: "4.7"
created: 2026-11-08
updated: 2026-11-08
---

> Preserved as a pinned reference to the official Godot 4.7 `Area2D` class reference. Full original at the URL.

Key points relied on (Godot 4.7):
- `Area2D` detects overlap (and can override physics like gravity in a region). It emits:
  - **`body_entered(body: Node2D)`** / `body_exited(body: Node2D)` — for `PhysicsBody2D`/`TileMap` overlaps.
  - **`area_entered(area: Area2D)`** / `area_exited(area: Area2D)` — for other `Area2D` overlaps.
- Detection requires a **`CollisionShape2D`** (or `CollisionPolygon2D`) child, and `monitoring = true` (default).
- Overlap is filtered by **collision layers/masks**: an `Area2D` detects a body only when the body's **layer** is in the
  Area2D's **mask** (`collision_layer` = "what I am", `collision_mask` = "what I scan for").
- Body/area signals fire during physics processing (not synchronously at the moment shapes touch).

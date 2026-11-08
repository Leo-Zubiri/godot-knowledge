---
id: src-input
type: source
domain: godot
source:
  url: https://docs.godotengine.org/en/4.7/tutorials/inputs/inputevent.html
  title: "InputEvent / Input singleton — Godot Engine 4.7 docs"
  retrieved: 2026-11-08
  version: "4.7"
  capture: paraphrased
created: 2026-11-08
updated: 2026-11-08
---

> Preserved as a pinned reference to the official Godot 4.7 input docs. See also the `Input` class reference
> (https://docs.godotengine.org/en/4.7/classes/class_input.html). Full originals at the URLs.

Key points relied on (Godot 4.7):
- Prefer **input actions** (Project Settings → Input Map) over hard-coded keys, so bindings are remappable.
- Poll actions via the **`Input`** singleton: `Input.is_action_pressed("name")` (held),
  `Input.is_action_just_pressed("name")` (this frame), `Input.get_axis("neg","pos")` (-1..1),
  `Input.get_vector("left","right","up","down")` (normalized 2D).
- Event callbacks: **`_unhandled_input(event)`** (recommended for gameplay — runs after the UI has had a chance to
  consume the event) vs `_input(event)` (runs first, before UI). Use `event.is_action_pressed("name")` on the event.
- Rule of thumb: **poll** continuous actions (movement) in `_physics_process`; handle **discrete** one-shot events
  (a menu key) in `_unhandled_input`.

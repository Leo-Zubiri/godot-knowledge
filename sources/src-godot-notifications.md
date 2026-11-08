---
id: src-godot-notifications
type: source
domain: godot
source:
  url: https://docs.godotengine.org/en/4.7/tutorials/best_practices/godot_notifications.html
  title: "Godot notifications — Godot Engine 4.7 documentation"
  retrieved: 2026-11-06
  version: "4.7"
  capture: paraphrased
created: 2026-11-06
updated: 2026-11-06
---

> Preserved as a pinned reference to the official Godot 4.7 documentation (conventionally immutable). See also the
> `Node` class reference for the callback definitions. Full original at the URL.

Official pages: **Godot notifications** (best practices, Godot 4.7) and `Node` class reference
(https://docs.godotengine.org/en/4.7/classes/class_node.html).

Key points (as documented):
- Node lifecycle virtual callbacks: `_enter_tree()`, `_ready()`, `_process(delta)`, `_physics_process(delta)`,
  `_exit_tree()` (these correspond to engine notifications such as `NOTIFICATION_READY`).
- `_ready()` is called **once**, after the node **and all its children** have entered the tree — it is the correct place
  to access child nodes.
- `_enter_tree()` fires when the node enters the tree and runs **before** its children's `_enter_tree()` (top-down);
  `_ready()` effectively resolves **bottom-up** (children ready before their parent's `_ready()`).
- `_process` / `_physics_process` run every frame / every physics tick respectively.
- The page's broader advice: prefer the right callback for the job and avoid doing work in the wrong lifecycle phase.

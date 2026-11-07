---
id: node-lifecycle-callbacks
type: concept
domain: godot
status: proposed
summary: The order and purpose of Node lifecycle callbacks (_enter_tree, _ready, _process/_physics_process, _exit_tree) and when to use each.
aliases: [_ready, _enter_tree, _process, node lifecycle, notifications]
sources:
  - claim: "_ready runs once after the node and all children enter the tree; _enter_tree runs top-down (parent before children); _ready resolves bottom-up (children before parent); _process/_physics_process run per frame/physics tick."
    ref: src-godot-notifications
    retrieved: 2026-11-06
    version: "4.7"
related:
  - relates-to: "[[gdscript-signals]]"   # signal connections are usually made in _ready
created: 2026-11-06
updated: 2026-11-06
created_by_type: agent
---

## Summary
A `Node` passes through a defined lifecycle. Using the **right callback** for each job (especially `_ready` for
accessing children) avoids a large class of null-reference and ordering bugs.

## Explanation
Key callbacks and when they fire (Godot 4.7):

- **`_enter_tree()`** — when the node enters the scene tree. Runs **top-down**: a parent's `_enter_tree` runs before its
  children's. Children may not be fully initialized yet.
- **`_ready()`** — called **once**, after the node **and all of its children** have entered the tree. Effectively
  **bottom-up** (children become ready before their parent). This is the correct place to access child nodes
  (`$Child`, `get_node(...)`) and to connect signals.
- **`_process(delta)`** — every rendered frame; `delta` is seconds since the last frame. For non-physics per-frame work.
- **`_physics_process(delta)`** — every physics tick (fixed timestep); use for movement/physics.
- **`_exit_tree()`** — when the node leaves the tree; clean up here.

Rule of thumb: **don't access children in `_enter_tree`** (they may not exist yet) — do it in `_ready`. Put
frame-rate-independent gameplay/physics in `_physics_process`, not `_process`.

> `applies-to`: **Godot 4.7**. Callback names/semantics differ from some Godot 3 conventions — see
> [[godot-version-policy]].

## See also
- [[gdscript-signals]] — connect signals in `_ready`

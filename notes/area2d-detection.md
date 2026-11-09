---
id: area2d-detection
type: pattern
domain: godot
status: proposed
summary: Detect overlaps (pickups, hitboxes, triggers) with Area2D + its body_entered/area_entered signals, filtered by collision layers/masks.
tags: [dept/game-dev, tool/godot, dim/2d]
aliases: [Area2D, body_entered, area_entered, pickup, hitbox, trigger, overlap detection]
applies-to:
  min: "4.0"
  tested: "4.7"
sources:
  - claim: "Area2D emits body_entered(body)/body_exited and area_entered(area)/area_exited; needs a CollisionShape2D child and monitoring; overlap is filtered by collision layer/mask."
    ref: src-area2d
    retrieved: 2026-11-08
    version: "4.7"
  - claim: "Connecting the signal to a handler uses the Godot 4 Callable form .connect()."
    ref: src-gd-signals
    retrieved: 2026-11-08
    version: "4.7"
related:
  - refines: "[[gdscript-signals]]"             # a concrete, common use of signals
  - relates-to: "[[characterbody2d-movement]]"  # e.g. player body entering a coin area
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Problem
You need non-physics interaction: a coin the player collects, a damage zone, a trigger volume — "did X overlap this
region?" without a full collision bounce.

## Solution
Use `Area2D` (with a `CollisionShape2D` child) and connect its overlap signals. For a body (e.g. a `CharacterBody2D`
player) entering a coin:

```gdscript
extends Area2D   # the Coin

signal collected

func _ready() -> void:
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("player"):
        collected.emit()
        queue_free()
```

Configure **collision layers/masks** so detection happens: put the player on a layer, and set the coin Area2D's
**`collision_mask`** to include that layer (`collision_layer` = what this object *is*; `collision_mask` = what it
*scans for*).

## Trade-offs
- `Area2D` only *detects*; it does not push bodies (that's `StaticBody2D`/`CharacterBody2D`/`RigidBody2D`).
- Use `body_entered`/`body_exited` for PhysicsBody2D/TileMap overlaps; `area_entered`/`area_exited` for Area↔Area.

## Common mistakes
- **No `CollisionShape2D` child** (or it's disabled) → the area never detects anything.
- **Layer/mask mismatch** — the single most common cause of "my signal never fires": the other object isn't on a layer
  the Area2D masks.
- Using `connect("body_entered", self, "_on...")` (string form) — that's **Godot 3.x**; use the Callable
  `body_entered.connect(_on_body_entered)` ([[gdscript-signals]]).
- Freeing the other node inside the handler without guarding → errors if multiple overlaps resolve the same frame.

## Limitations / open questions
- Overlap signals fire during physics processing, not the instant shapes touch; don't assume same-frame synchrony.
- **Not yet experimentally validated in `godot-lab`** — status `proposed`.

## See also
- [[gdscript-signals]] — the signal mechanism · [[characterbody2d-movement]] — the body that enters

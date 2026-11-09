---
id: characterbody2d-movement
type: pattern
domain: godot
status: proposed
summary: Move a player/entity with CharacterBody2D in Godot 4.x — set `velocity`, apply gravity per frame, call `move_and_slide()` (no args), check `is_on_floor()`.
tags: [dept/game-dev, tool/godot, dim/2d]
aliases: [CharacterBody2D, move_and_slide, player movement, platformer controller, is_on_floor]
applies-to:
  min: "4.0"
  tested: "4.7"
sources:
  - claim: "CharacterBody2D exposes a velocity property; in Godot 4.x move_and_slide() takes no arguments and uses velocity; is_on_floor() reports floor contact after moving; gravity is applied manually in _physics_process."
    ref: src-characterbody2d
    retrieved: 2026-11-08
    version: "4.7"
related:
  - relates-to: "[[characterbody3d-movement]]"   # the 3D equivalent
  - depends-on: "[[input-handling]]"            # movement reads input actions each physics frame
  - relates-to: "[[node-lifecycle-callbacks]]"  # runs in _physics_process (fixed timestep)
  - relates-to: "[[godot-version-policy]]"       # move_and_slide signature changed 3.x -> 4.x
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Problem
You need code-driven character movement (a platformer or top-down player, a simple enemy) with collision response —
without writing a full physics integrator.

## Solution
Use `CharacterBody2D` (needs a `CollisionShape2D` child). Drive it in **`_physics_process(delta)`**: update the built-in
**`velocity`**, then call **`move_and_slide()`** (no arguments in Godot 4.x):

```gdscript
extends CharacterBody2D

const SPEED := 300.0
const JUMP_VELOCITY := -400.0

func _physics_process(delta: float) -> void:
    # Gravity (not automatic): apply while airborne.
    if not is_on_floor():
        velocity += get_gravity() * delta
    # Jump (discrete) — only when grounded.
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = JUMP_VELOCITY
    # Horizontal (continuous), -1..1 from two actions.
    var direction := Input.get_axis("move_left", "move_right")
    velocity.x = direction * SPEED
    move_and_slide()
```

## Trade-offs
- `CharacterBody2D` gives manual control + slide/collision; for fully physics-simulated bodies use `RigidBody2D` instead.
- Read floor/wall state **after** `move_and_slide()` (it updates `is_on_floor()` etc.).

## Common mistakes
- Calling `move_and_slide(velocity)` with an argument — that's **Godot 3.x**; in 4.x it takes **no args** and uses the
  `velocity` property (see [[godot-version-policy]]).
- Doing movement in `_process` instead of **`_physics_process`** → frame-rate-dependent, jittery physics.
- Forgetting a `CollisionShape2D` child → the body passes through everything.
- Expecting automatic gravity — you must add it yourself each physics frame.

## Limitations / open questions
- Gravity source: the Godot 4.x default template uses `get_gravity()`; `ProjectSettings` key
  `physics/2d/default_gravity` is the alternative. Confirm which you want on your exact 4.7.x build.
- **Not yet experimentally validated in `godot-lab`** — claims are from the cited docs only; status `proposed`.

## See also
- [[input-handling]] — the actions this reads · [[node-lifecycle-callbacks]] — `_physics_process`
- [[area2d-detection]] — for pickups/triggers around the player
- [[characterbody3d-movement]] — the 3D equivalent

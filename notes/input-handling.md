---
id: input-handling
type: concept
domain: godot
status: proposed
summary: Read input in Godot 4.x via InputMap actions + the Input singleton (poll continuous actions; handle discrete events in _unhandled_input).
aliases: [Input, InputMap, input actions, is_action_pressed, get_axis, _unhandled_input]
applies-to:
  min: "4.0"
  tested: "4.7"
sources:
  - claim: "Prefer input actions (InputMap); poll with Input.is_action_pressed/just_pressed/get_axis/get_vector; handle discrete events in _unhandled_input (after UI) vs _input (before UI)."
    ref: src-input
    retrieved: 2026-11-08
    version: "4.7"
related:
  - relates-to: "[[node-lifecycle-callbacks]]"   # _input/_unhandled_input are lifecycle callbacks
  - relates-to: "[[characterbody2d-movement]]"   # movement polls input actions each physics frame
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Summary
Use **named input actions** (Project Settings → Input Map) rather than hard-coded keys, and read them either by
**polling** the `Input` singleton (for continuous input) or via **event callbacks** (for discrete input). Actions keep
bindings remappable and device-agnostic.

## Explanation
**Poll** (good for movement, held actions) — typically in `_physics_process`:
```gdscript
var move := Input.get_axis("move_left", "move_right")   # -1..1
if Input.is_action_pressed("fire"):
    ...
if Input.is_action_just_pressed("jump"):                # true only on the frame pressed
    ...
```

**Event callback** (good for discrete, one-off actions; respects UI consumption) — prefer `_unhandled_input`:
```gdscript
func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("pause"):
        toggle_pause()
```

`_unhandled_input` runs **after** the GUI has had a chance to consume the event; `_input` runs **first** (before UI).

## Common mistakes
- Hard-coding physical keys (`event.keycode == KEY_SPACE`) instead of an action → not remappable, device-specific.
- Handling gameplay in `_input` and "eating" events the UI needed (or vice versa) — use `_unhandled_input` for gameplay.
- Polling one-shot actions with `is_action_pressed` (fires every frame held) when you meant `is_action_just_pressed`.
- Reading input in `_process` for physics-coupled movement → prefer `_physics_process` (see [[characterbody2d-movement]]).

## Limitations / open questions
- The action names used here (`move_left`, `jump`, …) must exist in the project's Input Map; they are project
  configuration, not engine defaults.
- **Not yet experimentally validated in `godot-lab`** — status `proposed`.

## See also
- [[characterbody2d-movement]] — consumes these actions · [[node-lifecycle-callbacks]] — the input callbacks

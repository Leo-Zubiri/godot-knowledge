---
id: godot-animation-tree-and-tween-pitfalls
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 animation: AnimationPlayer RESET and update modes, AnimationTree state machine and blending pitfalls, root motion, Tween lifecycle rules."
tags: [dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Animation pages: AnimationPlayer, AnimationTree, Tween, skeleton modifiers, sprite animation"
    ref: src-gd-animation
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-blender-pipeline]]"   # imported animations and retargeting
  - relates-to: "[[characterbody3d-movement]]"   # root motion feeds movement
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **AnimationPlayer:** animations live in a library (default `[Global]`); update modes Continuous/Discrete/Capture; the **RESET** animation (case-sensitive) should hold defaults at time 0; it inherits Node, so children get no transform from it; `play()` takes effect next process (use `advance(0)` to avoid a one-frame glitch).
- **AnimationTree:** plays clips from a linked AnimationPlayer; root types single animation, BlendTree, BlendSpace1D/2D, StateMachine; for imported 3D scenes put the tree in your own scene instancing the imported one. State machine: transition modes Immediate/Sync/At End; advance modes Disabled/Enabled/Auto; Advance Condition tests booleans only; `travel()` uses A* and jumps straight to the target if no path exists; the machine must be started. Animation nodes are shared resources.
- **Blending pitfalls:** a clip lacking a property track is treated as 0 (put initial values in RESET); angle interpolation cannot blend past 180° from the initial value; import humanoids in a T-pose.
- **Root motion:** assign the root bone as the root motion track; read `get_root_motion_position()` and rotation/scale variants (the `_accumulator` variants give blended values).
- **Tween:** `create_tween()` on a Node binds it; a `Tween.new()` tween is invalid; do not reuse a tween; `kill()` before restarting; with several tweens on one property the last created wins; infinite loops need a duration or delay.
- Skeleton modifier subclasses (IK, look-at, retargeting, spring bones) were listed but not read.

## What an agent can and cannot check
An agent can parse `.tscn`/`.tres` for tree parameters, advance conditions and RESET tracks, and scripts for stored/reused tweens. Timing, feel and foot sliding need a human playing in engine.

## See also
- [[game-studio-blender-pipeline]] — imported animations and retargeting
- [[characterbody3d-movement]] — root motion feeds movement

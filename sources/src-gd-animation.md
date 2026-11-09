---
id: src-gd-animation
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/animation/introduction.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/animation/introduction.html"
    - "https://docs.godotengine.org/en/stable/tutorials/animation/animation_tree.html"
    - "https://docs.godotengine.org/en/stable/classes/class_tween.html"
    - "https://docs.godotengine.org/en/stable/classes/class_skeletonmodifier3d.html"
    - "https://docs.godotengine.org/en/stable/tutorials/2d/2d_sprite_animation.html"
  title: "Godot 4.7 animation: AnimationPlayer, AnimationTree, Tween, skeleton modifiers, sprite animation"
  retrieved: 2026-11-08
  version: "4.7 (headers reported by subagent)"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot documentation pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. **Version:** page headers say *Godot Engine 4.7 documentation* — confirmed by the main agent on the pages listed under "re-read", reported by research subagents for the others; pages carrying their own "may be outdated for 4.7" notice are flagged. Documentation only: nothing here was run in the engine, so behaviour claims are *documented*, not *experimentally validated*. Re-fetch before promoting dependent notes to `verified`.

- **AnimationPlayer:** animations live in a library (default `[Global]`); tracks reference node properties by path; update modes Continuous, Discrete, Capture; loop modes Clamp and Wrap; the RESET animation name is case-sensitive and should hold defaults at time 0; "Reset On Save" changes only the saved file, "Apply Reset" changes the editor; with no end keyframe while looping the first keyframe doubles as the last (back-and-forth); it inherits Node, so children get no transform from it.
- **AnimationTree:** contains no clips, plays clips from a linked AnimationPlayer; root types single animation, BlendTree, BlendSpace1D/2D, StateMachine; for imported 3D scenes put the AnimationTree in your own scene that instances the imported scene. State machine: transition modes Immediate, Sync, At End; advance modes Disabled, Enabled (used only by `travel()`), Auto; Advance Condition tests a boolean only (no `!`); Advance Expressions are case-sensitive and need an Advance Expression Base Node; `travel()` uses A* pathfinding and jumps straight to the target if no path exists; the state machine must be started. Blending pitfalls: a clip lacking a property track is treated as 0 (put the initial value in RESET); angle-interpolated rotation cannot blend past 180° from the initial value; for humanoids import in a T-pose. Root motion: assign the root bone as root motion track and read `get_root_motion_position()` and rotation/scale variants (the `_accumulator` variants give the blended value). Animation nodes are shared resources (changing them affects every instance using that tree).
- **Tween:** create with `create_tween()` on a Node (binds to it) or SceneTree; a `Tween.new()` tween is invalid; tweens start immediately, should not be reused, `kill()` before restarting; if several tweens animate the same property the last created wins; infinite loops need a duration or delay.
- **Sprite animation:** AnimatedSprite2D with SpriteFrames, sprite-sheet import grid; `play()` on an AnimationPlayer takes effect on the next process (call `advance(0)` to avoid a one-frame glitch).
- **Skeleton modifiers:** SkeletonModifier3D is the base class and runs after the AnimationMixer; subclasses listed include IKModifier3D, SkeletonIK3D, LookAtModifier3D, BoneConstraint3D, RetargetModifier3D, SpringBoneSimulator3D, PhysicalBoneSimulator3D (subclass behaviour unread).

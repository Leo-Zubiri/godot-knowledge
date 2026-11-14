---
id: godot-code-driven-character-animation-without-skeleton
type: guide
domain: godot
status: unreviewed
summary: "Pattern for animating a simple, rigid-part 3D character in Godot 4.7.2 with no skeleton and no AnimationPlayer: a handful of exported pose parameters driven by Tweens, one pure apply_pose() that places every part from those parameters, a blended procedural walk cycle, anticipation and overshoot for size changes, and the test traps this style has (wait conditions that match mid-overshoot, fast time scales that skip short segments, gestures that forget to return to rest)."
aliases: [procedural character animation, tween driven animation, animation without rig, pose parameters, squash and stretch in code, procedural walk cycle]
tags: [dept/game-dev, dept/3d-art, tool/godot, dim/3d]
applies-to:
  min: "4.0"
  tested: "Godot 4.7.2.stable.mono (mechanics and tests run headless; how the motion FEELS was not judged by a person)"
sources: []
related:
  - relates-to: "[[godot-animation-tree-and-tween-pitfalls]]"   # Tween lifecycle rules this pattern depends on
  - relates-to: "[[game-studio-art-readability-silhouette-and-animation-principles]]"   # anticipation, squash and stretch, follow-through
  - relates-to: "[[game-studio-blender-pipeline]]"   # the model: one object per part, origin at its joint
  - relates-to: "[[godot-gdunit4-headless-test-run]]"   # how the tests below are run
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> **Evidence status — mixed.** The mechanics and the test traps were *run in the engine* (headless test suite). Whether the result looks
> good is *interpretation*: nobody judged the motion by eye, only still frames were inspected. Status `unreviewed`.

## When it fits
A stylised character made of a few rigid parts (head piece, body, hands, feet…) that only needs readable gestures: idle, look at, point,
strike, celebrate, flinch, short walks. No skin deformation, no retargeting, no hand-authored clips. If the character needs bending limbs,
blended locomotion or animator-authored clips, use a skeleton and AnimationTree instead ([[godot-animation-tree-and-tween-pitfalls]]).

## Structure
1. **Model:** one mesh object per part, each with its **origin at its joint** (where it should rotate), exported from the DCC with
   transforms applied ([[game-studio-blender-pipeline]]). On load, store every part's rest `Transform3D`.
2. **Pose parameters:** a small set of plain floats on the character node (`hop`, `squash`, `lean`, `head_tilt`, `shake`, `reach`,
   `leg_length`, a `walking` flag). Gestures never touch the parts; they only tween these numbers.
3. **`apply_pose()`** — one function, called every frame, that computes every part's transform **from rest + parameters + time**. It is a
   pure function of the state, so a test (or a screenshot tool) can set parameters and a time value, call it once, and inspect the result.
4. **Gestures** are functions that build **one Tween each**; starting a gesture kills the previous Tween. A `time_scale` divisor on every
   duration lets tests run them fast and tools run them slow.
5. **Idle life** comes for free: low-amplitude sines with a per-instance phase inside `apply_pose()` (so two characters never move in sync).

## Making it read
- **Walk cycle:** one `cycle = sin(t * rate)`. Body height uses `abs(cycle)` (two bounces per cycle), body roll uses `cycle` (one sway per
  cycle), each foot lifts on its own half (`max(cycle, 0)` / `max(-cycle, 0)`), arms swing in opposite phase, and loose parts (hat tip,
  beard) take the **opposite** of the sway so they appear to lag. Multiply everything by a `walk_blend` that moves toward 0 or 1 a little
  each frame: the walk fades in and out instead of snapping.
- **Size change (grow/shrink, jump, land):** anticipation → action with overshoot → settle. Crouch first (`squash` down, short), then move
  the main parameter with `TRANS_ELASTIC`/`TRANS_BACK` + `EASE_OUT`, stretch on the way, and settle. For the reverse: fall with `EASE_IN`,
  a very short hard squash on contact, elastic recovery.
- **Sync with gameplay:** if a gesture must hit at the same moment as a gameplay event (a strike, a throw), give the simulation an explicit
  **delay equal to the wind-up** and let the view play the wind-up during it. Do not let the view decide when the event happens: the
  simulation stays the authority and tests can set the delay to zero.

## Traps found while testing
- **A wait condition can match in the middle of an overshoot.** "value ≥ 98 % of target and squash ≈ final" was true on the way up of an
  elastic tween and the assertion then read a value 37 % above target. Wait for *all* tweened parameters to be at rest, or track the
  min/max seen inside the polling closure and assert on those.
- **`TRANS_ELASTIC` overshoots a lot** (about a third of the travel in this run). Fine for rubbery characters; use `TRANS_BACK` for less.
- **Fast time scales skip short segments.** A 70 ms squash at ×12 lasts under one frame, so a test that polls per frame never sees it. Run
  tests that observe a transient at ×1–×2 and only use big factors for "does it end in the right state".
- **Every gesture must end through one "return to rest" function.** Gestures that finished with `state = idle` directly left the character
  in whatever size the previous gesture had set (it stayed tall after celebrating). Make the final callback call `idle()`, and make
  `idle()` responsible for undoing any persistent parameter.
- **A function called every frame must not restart a Tween.** Guard with the state (`if state != &"aim": …`), otherwise the Tween is
  recreated each frame and never advances.
- Closures in GDScript capture locals by value: accumulate into a one-element array (`lowest[0] = min(lowest[0], x)`) inside a polling
  lambda.

## Limitations
- No blending between gestures beyond "kill and start from current values" (which is what tweening the current parameter gives).
- Rigid parts only; long stretched limbs need a generated mesh or a scaled cylinder between two points.
- Motion quality is unreviewed by a human.

## See also
- [[game-studio-art-readability-silhouette-and-animation-principles]] — the principles being approximated
- [[godot-animation-tree-and-tween-pitfalls]] — Tween rules and the skeleton-based alternative

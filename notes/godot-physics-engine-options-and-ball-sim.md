---
id: godot-physics-engine-options-and-ball-sim
type: reference
domain: godot
status: proposed
summary: "What Godot 4.7 actually offers for a ball/billiards game and the gotchas found building a Jolt pool spike: Jolt is the built-in default 3D engine (GodotPhysics3D the alt; no maintained Box2D for 2D); PhysicsMaterial has NO rolling friction so linear_damp/angular_damp approximate it (and are THE feel knob — too low and balls roll forever); cushions must be taller than a ball's DIAMETER or balls climb over and leave the table; pocket Area captures should be recessed into the mouth; physics_interpolation makes frame-stepped headless screenshots show stale positions; continuous_cd + high physics tick fight tunnelling of a hard-struck ball; custom_integrator/_integrate_forces keep Godot's collision while you write your own motion."
aliases: [Godot physics for pool, Jolt ball physics, rolling friction Godot, pool table cushions physics, Godot billiards]
tags: [dept/engineering, tool/godot, scope/physics]
applies-to:
  min: "4.4 (Jolt built-in)"
  tested: "4.7.2 Mobile — hands-on pool spike + docs research"
sources:
  - claim: "Jolt built-in since 4.4 and default in 4.7; GodotPhysics3D alt; no maintained Box2D; PhysicsMaterial has only friction/bounce/rough/absorbent (no rolling friction); continuous_cd + Jolt CCD settings; determinism not guaranteed → host-authoritative; custom_integrator/_integrate_forces; Area/queries reusable by a custom sim; Pooltool as analytic reference"
    ref: src-gd-godot-physics-options-and-jolt
    retrieved: 2026-11-10
related:
  - relates-to: "[[game-studio-physics-engine-vs-custom-simulation]]"   # the A/C decision this feeds
  - relates-to: "[[godot-physics-bodies-layers-and-interpolation]]"   # bodies/layers/interpolation mechanics
  - relates-to: "[[game-studio-spike-technical-feasibility-prototype]]"   # these findings came from a spike
created: 2026-11-10
updated: 2026-11-10
created_by_type: agent
---

> **Evidence status:** documented facts are `proposed` from docs/research ([[src-gd-godot-physics-options-and-jolt]]).
> Items tagged **(hands-on)** were observed building a throwaway Jolt pool spike in **Godot 4.7.2 Mobile** (xvfb) — real
> behaviour, but not promoted to `verified` (human sign-off pending).

## What Godot gives you (3D vs 2D)
- **3D:** **Jolt Physics** is the **built-in default** engine since 4.4 (`physics/3d/physics_engine`); `GodotPhysics3D` is
  the alternative. Jolt = better perf + more stable stacking (good for Android). `RigidBody3D` + `SphereShape3D` +
  `StaticBody3D` rails + `Area3D` pockets is the natural node set.
- **2D:** only **GodotPhysics2D** is official; **no maintained Box2D** for Godot 4. So a "2D engine" path is weak — and a
  2D engine can't model follow/draw spin anyway (see [[game-studio-physics-engine-vs-custom-simulation]]). A 2D-math
  **custom** sim rendered in 3D is the real alternative, not a 2D physics engine.

## Rolling friction is not native — damping is the feel knob (hands-on)
`PhysicsMaterial` has only `friction`, `bounce`, `rough`, `absorbent` — **no rolling resistance**. Approximate it with the
body's **`linear_damp`/`angular_damp`**. **(hands-on)** at pool scale (ball r≈0.0286 m, mass 0.17 kg): `linear_damp ≈ 0.45`
let balls **roll almost forever** (still creeping after 6 s); **`≈0.9` made them settle believably**. This single value
dominates whether the table "feels" right — expose it as a tunable. Energy drains through damping even at `bounce = 1`.

## Geometry gotchas (hands-on)
- **Cushions must be taller than the ball's DIAMETER.** A rail shorter than `2·radius` lets a struck ball **climb over and
  leave the table** (then it drains or flies off). Realistic cushion-nose height is lower (~0.6·diameter), but then
  containment needs care — for a spike, make rails tall.
- **Pocket `Area3D` captures should sit in the pocket MOUTH, recessed outward** past the rail line. Centred on the rail,
  they swallow balls that merely graze the cushion near a pocket.
- **Rail gaps** only slightly wider than a ball (≈`2.5·radius`) keep balls on the table and drain only on a real line to
  the pocket.

## Tunnelling of a hard-struck ball
Real-scale balls are small and fast — forums call it "the lower limit for 3D physics." Mitigate with a **high physics
tick** (the spike used `Engine.physics_ticks_per_second = 120`) and **`continuous_cd = true`** per ball (settable on
`RigidBody3D` in 4.7 — **(hands-on)**; Jolt adds its own CCD ProjectSettings). CCD reduces but does not fully guarantee
no tunnelling; a custom analytic sim removes it by design.

## Determinism → host-authoritative
Godot/Jolt physics is **not reliably deterministic** across platforms (float). For LAN/online, the guidance is
**host-authoritative + snapshots**, not lockstep — which matches a typical turn-based plan. If you need replays or
bit-exact results, that argues for a **custom fixed-point sim**.

## If you write your own sim, you stay in Godot
`custom_integrator = true` + `_integrate_forces(state)` lets you write your own motion while keeping Jolt's
broadphase/collision (needs `contact_monitor` + `max_contacts_reported`). You still reuse render nodes, `Area` pockets,
`PhysicsDirectSpaceState` queries and Transforms. Analytic model reference: **Pooltool** (open source).

## QA gotcha: physics interpolation vs headless screenshots (hands-on)
With `common/physics_interpolation = true`, a **frame-stepped headless capture shows STALE visual positions** (render
interpolates from *process* frames; stepping only *physics* frames desyncs them). For a truthful headless screenshot set
the viewport's `physics_interpolation_mode = PHYSICS_INTERPOLATION_MODE_OFF` during the capture. In normal play
interpolation does its job — this only bites automated captures.

## Tuning a casual pool spike on Jolt — hands-on findings (4.7.2)
Building and playtesting a Jolt pool spike produced four concrete, reusable results — see the pool model in
[[game-design-billiards-pool-physics-model]] for the target numbers:
- **Rolling friction = a constant opposing force, not damping.** `apply_central_force(-v.normalized() * μ_r·g·mass)` each
  physics frame + a small `stop_speed` cutoff gives a natural roll-and-rest; `linear_damp` alone stops "dead" then crawls.
  Hands-on: `linear_damp 0.45` → rolls forever; a constant decel ~0.1–0.2 m/s² → rests smoothly.
- **A struck ball that was sleeping ignores `apply_central_impulse` under Jolt** (the impulse is lost even after setting
  `sleeping = false`). **Set `linear_velocity` directly** for the cue strike (`cue.linear_velocity = dir*speed`) — reliable
  from rest. (A collision still wakes a sleeping ball normally.)
- **Rail-hugging fix without physical cushions:** drop the box-collider rails and **reflect velocity analytically against
  the play rectangle** in the per-frame step — if `|pos.x| > halfL - R` and moving outward, `v.x = -e_c·v.x` (keep
  tangential), clamp position; skip the reflection near pocket mouths. No geometry to stick to → no rail-hugging, no
  tunnelling. Keep rails as visual-only meshes. (Ball-ball stays on Jolt.)
- **Keep the physics behind a swappable backend** (`make_ball/strike/step/is_at_rest`) so a later analytic sim replaces
  Jolt in one line — the modular seam that keeps ADR-0012 reversible.
- **A physics spike's MECHANICS verify headless, its feel does not.** Drive it from a `SceneTree` script: set a ball's
  `linear_velocity`, advance `await physics_frame`, and assert on positions/velocities — e.g. all balls come to rest
  (`velocity < ε`), a ball aimed at a pocket is removed, a ball skimming a rail does not hug it. Catches regressions
  cheaply; whether it *feels* like pool still needs a human at the controls.

## See also
- [[game-design-billiards-pool-physics-model]] — the correct pool model + parameters these knobs target
- [[game-studio-physics-engine-vs-custom-simulation]] — the engine-vs-custom decision these facts feed
- [[godot-physics-bodies-layers-and-interpolation]] — bodies/layers/interpolation mechanics
- [[src-gd-godot-physics-options-and-jolt]] — the research backing the documented half

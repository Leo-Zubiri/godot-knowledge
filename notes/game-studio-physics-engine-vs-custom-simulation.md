---
id: game-studio-physics-engine-vs-custom-simulation
type: reference
domain: game-studio
status: proposed
summary: "Deciding, for a physics-driven game (billiards, pinball, arcade sports, precise platformers), whether to use the built-in rigid-body engine (Jolt/Godot Physics/PhysX/Bullet) or a custom/analytic simulation. The engine is fastest to stand up but needs tuning for the hard cases (spin, resting/simultaneous contacts, tunnelling at high speed) and is generally NOT cross-platform deterministic; a custom analytic or fixed-point sim gives faithful feel and determinism (for lockstep netcode) at much higher cost. The decision axes are feel, determinism, and effort — and 'feel' is settled by a spike on the target device, not by argument."
aliases: [physics engine vs custom simulation, Jolt vs custom sim, built-in physics vs analytic, billiards physics approach, deterministic physics decision]
tags: [dept/engineering, scope/architecture, tool/godot]
sources:
  - claim: "Generic rigid-body engine for billiards runs fast but omits friction/spin by default and its collision-resolution mode changes realism; analytic event-based (Poolimmersion/FastFiz) is most faithful but most work; fixed time-steps miss collisions at high speed; simultaneous contacts (the break) need solved impulses"
    ref: src-gd-ball-physics-engine-vs-analytic-sim
    retrieved: 2026-11-10
  - claim: "Float physics is generally not deterministic across compilers/OS/instruction sets/build type; lockstep needs bit-identical sims, achieved via fixed-point/integer math or a locked toolchain; generic 3D engines (Jolt/PhysX/Bullet) are typically not cross-platform deterministic"
    ref: src-gs-deterministic-physics-lockstep
    retrieved: 2026-11-10
related:
  - relates-to: "[[game-studio-spike-technical-feasibility-prototype]]"   # the decision is CLOSED by a spike, not by reasoning
  - relates-to: "[[godot-physics-engine-options-and-ball-sim]]"   # Godot-specific: what the engine gives + hands-on gotchas
  - relates-to: "[[godot-physics-bodies-layers-and-interpolation]]"   # the engine-side bodies/layers/interpolation you'd use for the engine path
  - relates-to: "[[godot-lan-host-authoritative-turn-based]]"   # why determinism matters: netcode model depends on this choice
  - relates-to: "[[gs-adr-living-design-docs]]"   # record the choice as an ADR with the spike's evidence
created: 2026-11-10
updated: 2026-11-10
created_by_type: agent
---

> **Evidence status:** trade-offs paraphrased from web sources 2026-11-10 ([[src-gd-ball-physics-engine-vs-analytic-sim]],
> [[src-gs-deterministic-physics-lockstep]]) — `proposed`, no benchmark run. The framework is *interpretation*. **The
> central question — does the engine path *feel right*? — is explicitly NOT settled here; it is decided by a spike on the
> target hardware** ([[game-studio-spike-technical-feasibility-prototype]]).

## When this decision appears
Any game where the **motion itself is the gameplay** and must feel precise: **billiards/pool**, pinball, arcade sports,
marble/rolling games, and platformers with exacting movement. The question: let the **built-in rigid-body engine** do it,
or write a **custom simulation** (analytic event-based, or a hand-rolled fixed-step solver)?

## The three axes
1. **Feel / fidelity.** A generic engine stands up in hours but the **hard cases of a real table game are exactly what it
   does worst**: *spin/english*, *resting contacts* and the *simultaneous multi-ball break* (needs solved impulses, not
   sequential), and *tunnelling* when a ball is fast and the step is fixed. Billiards demos on generic 2D engines often
   **drop friction and spin entirely**. Analytic event-based solvers (FastFiz-style: solve collision *times* and
   sliding→rolling transitions) are **most faithful** but **most work**.
2. **Determinism.** If two machines must agree bit-for-bit — **lockstep netcode**, replays, verified results —
   **floating-point engines generally will not**, differing across compiler/OS/CPU/build. Determinism comes from
   **fixed-point/integer math or a single locked toolchain**, i.e. usually a **custom** sim. A generic 3D engine
   (**Jolt**, PhysX, Bullet) is typically **not** cross-platform deterministic, so with the engine path the netcode must
   avoid lockstep (**host-authoritative + snapshots** — [[godot-lan-host-authoritative-turn-based]]).
3. **Effort / risk.** Engine = least code, most tuning, borrowed bugs. Hand-rolled impulse solver (2D circles) = middle.
   Full analytic = most code, best fidelity, highest determinism potential.

## A rule of thumb (interpretation)
| Need | Lean |
|---|---|
| Fast to prototype; feel "good enough"; netcode is host-authoritative (not lockstep) | **Built-in engine** (e.g. Jolt), tuned |
| Billiards-grade fidelity (spin, clean break, cushions) | **Custom analytic / event-based** |
| Lockstep / replays / cross-platform identical results | **Custom deterministic** (fixed-point) |
| Unsure whether the engine's feel is acceptable | **Spike both, judge on-device** (below) |

## Why you spike instead of argue
Whether the engine's output **reads as a real table** is **subjective and hardware-sensitive** (mobile perf and touch
change it), so it **cannot be settled from docs or a headless run** — it needs a **throwaway spike** a human plays on the
**target device** ([[game-studio-spike-technical-feasibility-prototype]]). Typical shape: build the engine path first
(it's cheapest); if its feel passes on-device, adopt it and record the ADR; only if it fails do you invest in a custom
sim, now with evidence. Default caution: **start with the engine, keep the option to replace it behind the minigame's
own physics boundary** so the choice isn't load-bearing across the codebase.

## In Godot specifically (2026-11)
The "2D engine" leg of this decision is **weaker in Godot than it looks**: the only maintained 2D backend is
GodotPhysics2D (no maintained Box2D), and a 2D engine can't model follow/draw anyway — so **option B collapses into
"custom 2D-math sim rendered in 3D" (a flavour of C), not a 2D physics engine**. On the engine side, Jolt is the built-in
default (good for Android), but **Godot has no native rolling friction** (approximate with `linear_damp`) and its physics
**isn't cross-platform deterministic** (→ host-authoritative netcode). Engine-side gotchas and hands-on numbers:
[[godot-physics-engine-options-and-ball-sim]].

## What an agent can and cannot check
**By building/measuring:** stand up the engine path, measure frame time / step budget on target hardware, detect
tunnelling and never-sleeping bodies, confirm whether the engine is deterministic across two runs. **Needs a human on the
target device:** whether the motion *feels* like the real game, whether spin/break read correctly, and the final
feel-vs-effort trade — this is the spike's human half.

## See also
- [[game-studio-spike-technical-feasibility-prototype]] — how to actually run the deciding spike
- [[godot-physics-bodies-layers-and-interpolation]] — engine-path bodies/layers/interpolation mechanics
- [[godot-lan-host-authoritative-turn-based]] — the netcode model you fall back to when physics isn't deterministic

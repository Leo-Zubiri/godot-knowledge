---
id: game-design-billiards-pool-physics-model
type: reference
domain: game-design
status: proposed
summary: "The correct physics model for a billiards/pool game and the parameters to use: a ball moves in sliding→rolling states (constant rolling deceleration ≈0.1 m/s², μ_r=0.01; a struck ball loses 2/7 of its speed sliding before rolling), ball-ball is near-elastic (e_b=0.95) with throw, spin (follow/draw/english) comes from cue-tip offset, and cushions rebound NON-specularly contacting the ball at 0.635·D. Serious simulators (Pooltool, FastFiz) are analytic event-based, not rigid-body steppers; a rigid-body engine gives a CASUAL approximation. Includes the rail-hugging cause+fix and a starting parameter set."
aliases: [pool physics, billiards physics, how pool balls move, rolling friction pool, cushion rebound, cue spin follow draw english, pool parameters]
tags: [dept/design, dept/engineering, scope/physics]
applies-to:
  min: "generic (any pool/billiards game)"
  tested: "model from authoritative sources; starting params exercised in a Jolt spike (see godot note)"
sources:
  - claim: "ball states sliding/rolling (constant decel μ_r·g≈0.1), 5/7 rule, ball-ball e_b=0.95 + throw, spin from tip offset, cushion non-specular + nose 0.635·D, analytic-event-based vs stepper, full parameter set"
    ref: src-gd-pool-physics-model-and-params
    retrieved: 2026-11-10
related:
  - relates-to: "[[game-studio-physics-engine-vs-custom-simulation]]"   # the engine-vs-custom decision this is the hard case of
  - relates-to: "[[godot-physics-engine-options-and-ball-sim]]"   # engine-side Godot/Jolt mechanics + hands-on rail-hugging fix
  - relates-to: "[[game-studio-spike-technical-feasibility-prototype]]"   # judged by a spike you play, not from these numbers
created: 2026-11-10
updated: 2026-11-10
created_by_type: agent
---

> **Evidence status:** model and numbers paraphrased from authoritative sources (Alciatore/colostate, Mathavan 2010, Han
> 2005, Pooltool) — `proposed`, [[src-gd-pool-physics-model-and-params]]. Starting params were exercised in a Jolt spike
> (behaviour plausible) but **feel is a human call** ([[game-studio-spike-technical-feasibility-prototype]]). Not physics
> advice for a textbook — a game model.

## The model (what "feels like pool" needs)
1. **Two translation states with an explicit transition.** A struck ball **slides** (deceleration ≈ μ_s·g ≈ **2 m/s²**,
   which also spins it up) until the contact stops slipping (`v = ωR`), then **rolls**. A centre-hit ball **loses 2/7 of
   its speed** sliding (leaves at 5/7). Without this the start of a shot feels wrong.
2. **Rolling = small CONSTANT deceleration ≈ μ_r·g ≈ 0.1 m/s²** (μ_r=0.01). Stop distance **∝ v²** → balls roll far and
   stop *smoothly*. This is NOT exponential damping (which stops "dead" then crawls) — use constant decel.
3. **Ball-ball near-elastic** (e_b≈0.95) split along the line of centres (**90° rule** in stun), plus **throw** (cut-induced
   up to ~7° near a half-ball hit; spin-induced from english), **decreasing with speed**.
4. **Spin from cue-tip offset:** tip **0.4R above centre = immediate roll**; higher/lower = **follow/draw**; side = **english**
   (ω_z). Miscue limit ≈ 0.5R. English barely bends a rolling ball but changes collisions (throw) and cushion rebound.
5. **Cushions rebound NON-specularly** and contact the ball at **0.635·D** (above centre), not at the equator. Topspin
   lengthens the rebound, backspin shortens; running english lengthens + speeds up. Normal restitution e_c≈0.85–0.98.

## Starting parameters (Pooltool POOL_GENERIC, cross-checked with Alciatore)
R=0.028575 m, m=0.170097 kg, I=(2/5)mR²; μ_s=0.2, **μ_r=0.01 (decel ≈0.1 m/s²)**, μ_b=0.05–0.06, e_b=0.95, e_c=0.85
(cushion), g=9.81. (Snooker: μ_s=0.5, R=0.0262, m=0.140.) On a *small* table a slightly higher rolling decel (~0.2) is a
reasonable playability compromise.

## Architecture: analytic event-based vs rigid-body engine
- **Serious simulators (Pooltool, FastFiz) are analytic event-based** — solve the exact time of the next event, evolve all
  balls in closed form, resolve, repeat (**5–50 events/shot**). Gives accuracy + **determinism by construction** (good for
  lockstep/replays), no tunnelling/jitter. Ball-ball time = root of a **quartic**; cushion = **Han 2005**.
- **A rigid-body engine (Jolt/Box2D/PhysX) gives a CASUAL approximation.** It won't model slide→roll, follow/draw or throw
  faithfully and isn't cross-platform deterministic. Fine for a casual game with **host-authoritative + snapshots** netcode.
- **Rule of thumb:** casual party game → tuned rigid-body engine; billiards-grade fidelity or lockstep/replays → custom
  analytic sim ([[game-studio-physics-engine-vs-custom-simulation]]). Decide with a spike you actually play.

## The "rail-hugging" bug (ball slides along the cushion) — cause and fix
Root cause in a stepper: **solver bounce/rest threshold + high tangential friction + a vertical box wall** (contacts at the
equator). Fixes: lower the bounce threshold, OR **reflect the normal velocity analytically** against the rail rectangle
below a speed threshold (`v_n' = -e_c·v_n`, keep tangential) so there is no geometry to stick to; cushion material **high
restitution + low tangential friction**; nose above centre; smooth continuous rail collider; CCD on the ball only. Engine-
side detail and a verified Godot/Jolt implementation: [[godot-physics-engine-options-and-ball-sim]].

## What an agent can and cannot check
**By building/measuring:** that balls come to rest (not forever, not "dead"), that a ball aimed at a pocket pots, that a
ball does not hug the rail, stop distances ∝ v². **Needs a human at the controls:** whether the *feel* reads as pool,
whether follow/draw/english are satisfying — the spike's human half.

## See also
- [[game-studio-physics-engine-vs-custom-simulation]] · [[godot-physics-engine-options-and-ball-sim]] · [[game-studio-spike-technical-feasibility-prototype]]
- [[src-gd-pool-physics-model-and-params]] — the research + all source URLs (Alciatore, Pooltool, Mathavan, FastFiz)

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
  - claim: "spin about the vertical axis decays at a constant rate 5·μ_sp·g/(2R), decoupled from sliding/rolling; Pooltool default u_sp ≈ 0.444·R"
    ref: src-gd-pooltool-spinning-friction
    retrieved: 2026-11-14
related:
  - relates-to: "[[game-studio-physics-engine-vs-custom-simulation]]"   # the engine-vs-custom decision this is the hard case of
  - relates-to: "[[godot-physics-engine-options-and-ball-sim]]"   # engine-side Godot/Jolt mechanics + hands-on rail-hugging fix
  - relates-to: "[[game-studio-spike-technical-feasibility-prototype]]"   # judged by a spike you play, not from these numbers
created: 2026-11-10
updated: 2026-11-14
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

## Cue-tip point of impact → initial velocity and spin (the "effect" contract)
Let the player choose where the tip hits the ball; convert it to `v` and `ω` in ONE pure function shared by every physics
backend. For a horizontal impulse `J` at height `h` above the centre: `v = J/m`, `ω = J·h/I`, `I = (2/5)·m·R²`, so
**`ω = 5·v·b / (2R)` with `b = h/R`** (same with a sideways offset `a` for english: `ω_vertical = 5·v·a / (2R)`).
- **`b = 0.4` ⇒ immediate rolling** (`ω·R = v`, zero slip). `b > 0.4` = follow with over-spin, `b < 0` = draw, `b = 0` = stun.
- **Miscue limit ≈ 0.5R:** clamp the tip point to the circle of radius `0.5R` (a UI circle the player drags inside);
  a diagonal request must not exceed the circle's spin. Expose "was limited" for feedback.
- **Elevation (massé):** the horizontal impulse scales with `cos θ`; the curved swerve needs extra modelling — keep the
  field in the shot contract even if v1 only applies `cos θ`.
- **Conventions are where this goes wrong — fix them once and test them.** With y up and the shooter's direction `d`:
  forward roll axis = `UP × d`; right english = `+ω_y` (counter-clockwise from above). A good test: for ANY heading, the
  rolling strike (`b = 0.4`) must give contact slip `|v + ω × (0,−R,0)| ≈ 0`.
- Effect after the impact (head-on, ~2 m/s, short run-up) was reproduced by a rigid-body engine — draw retreats
  34–46 cm, stun stays, rolling +27 cm, follow +29–34 cm ([[godot-physics-engine-options-and-ball-sim]], hands-on). The
  tip point has no visible effect if the cue ball starts far away: sliding converts to rolling in ≈ 0.29 s / 0.5 m at μ=0.2.

## Rack geometry and modality (data, not code)
- **Triangle (8-ball), 15 balls**, rows 1-2-3-4-5, balls touching (+ a tiny gap), rows `2R·cos30°` apart: the **8 in the
  centre slot** (row 3 middle) and **one solid + one stripe in the two back corners**; apex on the foot spot.
- **Diamond (9-ball), 9 balls**, rows 1-2-3-2-1: **1 at the apex, 9 in the centre**.
- Each modality declares its **shape and the ball number of every slot**; the rule set derives its ball *set* from that
  single list. Adding a modality is then one subclass, no `if mode == …` anywhere.

## Architecture: facts vs decisions
Keep three layers apart: the **simulation** reports *facts* (first ball touched, balls pocketed IN ORDER, cue pocketed,
rail after contact, balls that left the table), the **rules** decide (foul, group, turn, winner) from those facts, the **match
FSM** wires intents ↔ sim ↔ rules with signals. Two consequences worth designing in from the start:
- **Rules must be able to REQUEST physical actions.** "The 8 pocketed on the break is respotted" is a rules decision the
  physical table does not know about; without an explicit `respot` list in the rules' result, the FSM and the table silently
  drift apart (found by an end-to-end test comparing both views). Return commands, don't assume the sim mirrors the rules.
- **Fix the order contract:** a rules result that lists the balls on the table should be sorted, or two correct
  implementations disagree on order and every equality check is noise.

## The "rail-hugging" bug (ball slides along the cushion) — cause and fix
Root cause in a stepper: **solver bounce/rest threshold + high tangential friction + a vertical box wall** (contacts at the
equator). Fixes: lower the bounce threshold, OR **reflect the normal velocity analytically** against the rail rectangle
below a speed threshold (`v_n' = -e_c·v_n`, keep tangential) so there is no geometry to stick to; cushion material **high
restitution + low tangential friction**; nose above centre; smooth continuous rail collider; CCD on the ball only. Engine-
side detail and a verified Godot/Jolt implementation: [[godot-physics-engine-options-and-ball-sim]].

## Spin about the vertical axis (side spin) must be decayed explicitly
- **Model** ([[src-gd-pooltool-spinning-friction]]): `ω_z(t) = ω_0z − (5·μ_sp·g/(2R))·t` — a **constant** angular deceleration,
  independent of whether the ball slides or rolls. With Pooltool's default (`u_sp ≈ 0.444·R ≈ 0.0127`) that is ≈ **11 rad/s²**
  for a standard ball, so 40 rad/s of side spin lasts under 4 s.
- **Why a rigid-body engine gets it wrong** (*run here*, Godot 4.7.2 + Jolt, unreviewed): a sphere on a plane touches at one point,
  so contact friction applies **no torque about the contact normal**. The only thing left is the body's `angular_damp`, which is
  *exponential*: with 0.2 /s a ball at 60 rad/s needs ~19 s to fall under a rest threshold. Symptoms: balls visibly "spin in place
  for a long time", and the shot takes many seconds to be considered resolved (or hits the resolve timeout).
- **Fix that worked:** each physics tick, while the ball is grounded, `ω_y = move_toward(ω_y, 0, spin_decel·dt)` with `spin_decel`
  as a tunable (real ≈ 11; a slightly higher value settles the table sooner). Keep the low exponential damp for the other axes.
  Test: set 60 rad/s on a resting ball and assert it stops within `60/spin_decel` (+ margin) and not instantly.
- **Side spin at an analytic cushion** (*own heuristic, interpretation*): if cushions are an analytic reflection (see rail-hugging
  below), side spin has no effect unless you add it. A cheap version: the ball surface at the contact moves along the rail at
  `ω_y·R`; convert a fraction of it (≈ 0.3) into tangential velocity, cap the change at `μ_c·(1+e)·|v_normal|`, and spend spin by
  `Δω = 5/2·Δv/R`. With zero spin the rebound is unchanged, so existing behaviour and tests keep passing. Not validated against a
  measured cushion model (Han 2005 / Mathavan 2010 are the references for a faithful one).

## What an agent can and cannot check
**By building/measuring:** that balls come to rest (not forever, not "dead"), that a ball aimed at a pocket pots, that a
ball does not hug the rail, stop distances ∝ v². **Needs a human at the controls:** whether the *feel* reads as pool,
whether follow/draw/english are satisfying — the spike's human half.

## See also
- [[game-studio-physics-engine-vs-custom-simulation]] · [[godot-physics-engine-options-and-ball-sim]] · [[game-studio-spike-technical-feasibility-prototype]]
- [[src-gd-pool-physics-model-and-params]] — the research + all source URLs (Alciatore, Pooltool, Mathavan, FastFiz)

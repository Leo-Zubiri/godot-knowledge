---
id: game-design-pool-cpu-opponent-ghost-ball-planner
type: guide
domain: game-design
status: unreviewed
summary: "How to build a computer opponent for a billiards/pool game: a pure ghost-ball planner (for each legal ball and pocket, the cue must hit the ghost position 2R behind the object on the pocket line; reject blocked lines and extreme cuts; score by cut angle and distance), power from a calibrated effective deceleration, difficulty as deliberate error (aim noise, power noise, picking the 2nd-3rd best), visible aiming, and ball-in-hand placement by scoring candidate spots. Measured against a rigid-body engine: ≈ 58 % of clean shots without error, 14 / 30 / 48 % for easy / medium / hard."
aliases: [pool AI, billiards bot, ghost ball algorithm, cpu opponent, shot planner, difficulty levels]
tags: [dept/design, dept/engineering, scope/physics]
applies-to:
  min: "generic (any pool/billiards game)"
  tested: "Godot 4.7.2 + Jolt, 2.54 x 1.27 m table, 300-shot batches per setting; feel by a human not tested"
sources: []
related:
  - relates-to: "[[game-design-billiards-pool-physics-model]]"   # the physics the planner is calibrated to
  - relates-to: "[[godot-physics-engine-options-and-ball-sim]]"   # the Jolt restitution-threshold fix and fast headless trials
  - relates-to: "[[game-design-pool-view-camera-aim-and-spin-ux]]"   # the aim line the bot moves in front of the player
created: 2026-11-13
updated: 2026-11-13
created_by_type: agent
---

> **Evidence status — interpretation with measurements.** The algorithm is the standard ghost-ball construction; the numbers below were **measured
> against our own engine setup** (Godot 4.7.2 + Jolt), not taken from a source. Status `unreviewed`. Whether it *feels* like a fair opponent is a human call.

## Goal
A bot that plays legal, believable pool at several skill levels, testable without the physics engine, and tuned against the real engine.

## Planner (pure geometry, XZ plane)
1. **Legal balls** first (nine-ball: the lowest; eight-ball: own group, or anything but the 8 on an open table, or the 8 when the group is gone).
2. For each legal ball `T` and pocket `K`: `dir = norm(K − T)`, **ghost = T − dir · 2R**. Discard if the ghost is outside the cloth.
3. **Cut angle** = angle between cue→ghost and `dir`; discard above a per-level limit (we used 50° / 60° / 68°).
4. Reject if any other ball is within `2R + margin` of the segment cue→ghost, or of the segment T→K (the object's path).
5. Score = `cut_deg + 18 · (d_cue_ghost + d_T_K)`; sort ascending. If nothing is viable, play a **safety**: toward the nearest legal ball at moderate power.
6. **Power**: needed object speed `v_obj = sqrt(2 · a · d_TK) + push`; speed at contact `v_hit = v_obj / max(cos(cut), 0.35) / 0.95`; initial speed
   `v0 = sqrt(v_hit² + 2 · a · d_cue_ghost) · 1.12`; power = v0 / max cue speed. `a` is the **effective deceleration** (≈ 1.85 × rolling, see the engine note); `push`
   ≈ 0.6 m/s gave the best pot rate in a sweep (0.35 → 0.9 changed little once the engine's restitution threshold was fixed).

## Difficulty = deliberate error
- Gaussian **aim error** (σ ≈ 3° / 1.2° / 0.3°) and **power error** (σ ≈ 20 % / 10 % / 4 %), a **mistake chance** of choosing the 2nd–3rd best option (30 / 12 / 2 %),
  a smaller max cut for easy, a weaker break for easy. Think time 1–2 s so it does not look instant.
- Measured with the real engine over 300 clean-shot attempts each: **no error 58 %, hard 48 %, medium 30 %, easy 14 %.** The ~42 % that miss even with no error are shallow
  corner approaches (the object hits the end cushion first) and cut-induced throw; a better pocket model (aim at the pocket *mouth*, not its centre) is the obvious next step.

## Behaviour that made it feel like a player
- **Aim in view**: move the same draft/aim state the human controls (camera and aim line turn), wait ~0.8 s, then shoot through the **same intent entry point** as a human; the rules
  engine cannot tell it is a machine.
- Abandon a plan if the match state changes while it "thinks" (a token per state), and use timers that **respect pause**.
- **Ball in hand**: sample candidate spots on a grid (~0.18 m), skip invalid ones, run the planner from each, keep the spot with the best score.
- Restrict the human controller to the human seats so they cannot act in the bot's turn; a networked mirror client must not run the bot.

## What an agent can and cannot check
- Can: unit-test the planner with constructed layouts (straight shot, blocked line, cut limit, power monotonic, legal sets) and measure pot rates in batches against the engine.
- Cannot: say whether the levels are fun or fair; that needs people playing.

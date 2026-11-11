---
id: src-gd-pool-physics-model-and-params
type: source
kind: web-paraphrase
domain: game-design
retrieved: 2026-11-10
method: "web research of authoritative billiards-physics sources + simulators; paraphrased with evidence tags"
---

# Source — Correct billiards/pool physics model and parameters (paraphrased)

Researched 2026-11-10. **[AUTOR]** = Dr. Dave Alciatore (billiards.colostate.edu / drdavepoolinfo.com), peer papers
(Mathavan 2010, Han 2005), or simulator source (Pooltool/FastFiz). **[2º]** = forum/blog.

## Ball motion: states and transition
- Contact-point relative velocity `u = v + R·(k̂ × ω)`. States: **stationary, spinning (only ω_z), rolling (u=0),
  sliding (u≠0)**. **[AUTOR, Pooltool/Alciatore]**
- A struck (stun/sliding) ball **loses 2/7 of its speed sliding** before pure roll (final = **5/7 of initial**); time to
  roll `t=(2/7)v₀/(μ_s·g)`; slide distance `∝ v₀²`. **[AUTOR, TP 4.1]**
- **Rolling = CONSTANT deceleration** `a = μ_r·g ≈ 0.1 m/s²` (μ_r≈0.01); stop distance **∝ v²**. **[AUTOR, TP B.2/B.5]**

## Parameters (Pooltool POOL_GENERIC, cross-checked with Alciatore)
R=**0.028575 m**, m=**0.170097 kg**, I=(2/5)mR²; **μ_s (slide, cloth)=0.2** (range 0.15–0.4); **μ_r (roll)=0.01**
(0.005–0.015 → decel 0.05–0.15 m/s²); μ_sp (spin)≈0.0127; **ball-ball μ_b=0.05–0.06**, **e_b (restitution)=0.95**
(0.92–0.98); **cushion e_c normal=0.85** (Han 2005) up to **0.98** (Mathavan, who also gives cushion friction ≈0.14);
g=9.81. Snooker differs (μ_s=0.5, R=0.0262, m=0.140). **[AUTOR/REPO: pooltool params.html, colostate proofs]**

## Collisions and spin
- **Ball-ball** near-elastic; **90° rule** in stun (cue and object separate perpendicular); object takes `v·cosα`,
  cue `v·sinα`. **Throw**: cut-induced (max ~7° near half-ball hit) + spin-induced (english); **throw decreases with
  speed**. **[AUTOR]**
- **Spin** from cue tip height/side: contact **0.4R above centre = immediate roll**; above/below = follow/draw; side =
  english (ω_z). **Miscue limit ≈ 0.5R**. English barely bends a rolling ball's straight path; it matters at the
  **collision** (throw) and the **cushion** (rebound angle). **[AUTOR]**

## Cushions / rails (and the "rail-hugging" bug)
- Rebound is **NOT specular**: mirror angle is only the baseline for a stun ball. **Topspin lengthens, backspin shortens;
  running english lengthens + speeds up, reverse shortens**; speed barely changes the angle (rail-throwback vs efficiency
  cancel). **[AUTOR: drdave bank/kick]**
- **Cushion nose contacts the ball at 0.635·D** (WPA spec; 0.7·D=7R/5 is the theoretical centre-of-percussion). A
  **vertical wall contacts at the equator (0.5·D)** → wrong spin + nothing pins the ball down. **[AUTOR: drdave nose-height]**
- **Rail-hugging (ball slides along the rail) root cause in stepper sims = solver bounce/rest threshold + high tangential
  friction + vertical box wall.** Fixes: **lower the bounce threshold** (Unity 2→0.13; s&box was hardcoded 40), or
  **reflect the normal manually below a speed threshold** (`v_n' = -e·v_n`, keep damped tangential); cushion material
  **high restitution + low tangential friction**; nose above centre; **smooth continuous rail collider**; **CCD on the
  ball only**. **[2º: Unity/s&box devlogs; AUTOR for nose geometry]**

## Architecture: analytic event-based vs rigid-body stepper
- **Serious simulators (Pooltool, FastFiz/POOLFIZ) are analytic event-based**, NOT rigid-body steppers: compute the exact
  time to the next event, evolve all balls analytically, resolve, repeat (**5–50 events/shot** vs hundreds of thousands of
  tiny steps). Only FP error → **accuracy + determinism by construction**; no tunnelling/jitter. Ball states have
  closed-form solutions; ball-ball time = min positive root of a **quartic**; cushion = Han 2005 (avoids numeric ODE).
  **[AUTOR/REPO: Kiefl pooltool-alg; Lubachevsky 1991]**
- A **rigid-body engine (Jolt)** is fine for **casual** pool with **host-authoritative + snapshots** netcode (server
  simulates, clients interpolate) + CCD + high tick + sleep; it won't nail slide→roll, follow/draw, throw, or cross-platform
  determinism. No Godot pool project found that implements event-based prediction; all use the engine directly. **[REPO/FORO]**

## Key URLs
Alciatore proofs: https://billiards.colostate.edu/technical_proofs/ (TP 4.1 slide→roll 5/7; TP B.2/B.5 μ_s=0.2, μ_r=0.01;
TP A-14 throw). Nose height 0.635·D: https://drdavepoolinfo.com/FAQ/table/cushion-nose-height/ . Bank/kick rebound:
https://drdavepoolinfo.com/faq/bank-kick/effects/ . Pooltool theory: https://ekiefl.github.io/2020/04/24/pooltool-theory/
; algorithm (event-based): https://ekiefl.github.io/2020/12/20/pooltool-alg/ ; params:
https://pooltool.readthedocs.io/en/v0.4.4/_modules/pooltool/objects/ball/params.html ; repo:
https://github.com/ekiefl/pooltool (Apache-2.0); JOSS 2024 doi:10.21105/joss.07301. Han 2005 cushion code:
https://pooltool.readthedocs.io/en/v0.3.0/_modules/pooltool/physics/resolve/ball_cushion/han_2005/properties.html .
Mathavan 2010 (COR 0.98, friction 0.14): https://dspace.lboro.ac.uk/2134/15087 . FastFiz:
https://github.com/KuangyeChen/fastfiz . Event-based theory (Lubachevsky): https://arxiv.org/abs/cond-mat/0503627 .
Rail-hugging/threshold: https://discussions.unity.com/t/ball-too-bouncy-wall-impact-problem/682027 ,
https://sbox.game/news/may-2021/pool-game . Restitution range: https://arxiv.org/html/2402.13258v1 .

---
id: src-gd-ball-physics-engine-vs-analytic-sim
type: source
kind: web-paraphrase
domain: game-design
retrieved: 2026-11-10
method: "web search + result summaries; papers/demos named but not fully read this session"
---

# Source — Ball/billiards physics: generic engine vs analytic simulation (paraphrased)

Gathered by web search 2026-11-10 (no head-to-head benchmark found; items are `paraphrased`/`abstract-only`).
Billiards is the canonical stress case for ball physics, so it anchors the general engine-vs-custom question.

- **Generic 2D rigid-body engine (myPhysicsLab Billiards):** builds billiards on a general 2D rigid-body engine but
  **explicitly omits edge friction and spin** (balls behave frictionless); also shows the **collision-resolution method
  matters** — a "simultaneous" mode produces symmetric, unrealistic results. ⇒ an off-the-shelf engine runs fast but
  needs real work for pool-specific behaviour.
- **Analytic / event-based (Poolimmersion paper; FastFiz):** solve **collision times and transitions between motion
  states analytically** (e.g. sliding → rolling); ball-rail collisions computed analytically. Most faithful for
  pool-specific motion, **the most work to build**.
- **Hobby custom code (C/Raylib project):** wall bounces with restitution 1.0; ball-to-ball collisions by **swapping
  velocity vectors** — a prototype shortcut, exact only for equal-mass head-on impacts (*my observation, not the
  source's*).
- **Variable / continuous time-step (RPI project):** fixed steps **miss collisions when balls move at very different
  speeds** (tunnelling); needs variable time-step or continuous collision detection.
- **Simultaneous contacts (Popović, SIGGRAPH):** multiple simultaneous collisions must be resolved with **solved
  impulses**, not sequential handling — the "break" in pool is the hard case.

**Synthesis (interpretation):** generic engine = quickest to run, needs tuning (spin, cushions, simultaneous contacts,
tunnelling); analytic event-based = most faithful, most effort; a hand-rolled 2D impulse solver sits between.

## Sources
- https://www.myphysicslab.com/engine2D/billiards-en.html — 2D rigid-body billiards demo (no friction/spin; solver mode matters)
- https://www.researchgate.net/publication/321402249_Poolimmersion_A_realistic_physically-based_billiards_simulation — event-based analytic billiards
- https://www.cs.rpi.edu/~cutler/classes/advancedgraphics/S09/final_projects/anderson.pdf — variable time-step billiards (missed collisions)
- https://homes.cs.washington.edu/~jovan/papers/sigg00-rbedit.pdf — simultaneous collisions need solved impulses
- https://github.com/nptdtrais1tg/2D-Billiard-game-using-Physics-simulation — hobby custom 2D billiards (restitution 1.0, velocity swap)

---
id: game-design-first-person-throwing-hold-release-preview-obstacles
type: pattern
domain: game-design
status: unreviewed
summary: "A throwing mechanic that feels good in first person: hold to charge power (never instant), release to throw, a CANCEL input that spends nothing, one random item loaded at a time that is only replaced after it is thrown, a trajectory PREVIEW drawn by the exact same pure simulation that decides the real throw (so what you see is what happens; leave random spread out of the arc), per-item data (mass, drag, hit effect, landing behaviour) and, if objects can land on a physical table, a short-lived real rigid body that is cleared when the affected shot resolves. Hold-to-charge adds perceived delay, so give instant feedback (reticle colour by predicted target, power bar, curve marker)."
aliases: [throwing mechanic, trajectory preview, hold to charge, throw cancel, thrown items catalog, projectile arc preview]
tags: [dept/design, dept/gameplay, scope/input]
applies-to:
  min: "Godot 4.0"
  tested: "Ginomo: 6-item catalog, GnThrowFlight (pure), preview == real flight test, obstacles cleared on shot resolved"
sources: 
  - claim: "shipped games show a dashed arc and landing marker while the key is held and fire on release; the arc runs the real projectile step and omits random spread"
    ref: https://thunderstore.io/c/mycopunk/p/doku_macaron/ThrowPreview/
  - claim: "hold-to-charge with min/max force and real-time gravity-aware prediction is a common package feature"
    ref: https://www.patreon.com/DevByte/posts/grenade-throw-166395392
  - claim: "charge-and-release adds perceived input delay: give immediate feedback"
    ref: https://gamedeveloper.com/design/reducing-perceived-attack-delay-in-inversus
  - claim: "drag has no closed form: step position/velocity each tick and segment-test collisions"
    ref: https://forum.godotengine.org/t/need-help-predicting-trajectory/139526
related:
  - relates-to: "[[game-design-pool-view-camera-aim-and-spin-ux]]"
created: 2026-11-20
updated: 2026-11-20
created_by_type: agent
---

> **Evidence status — `unreviewed`.** Built and tested in Ginomo (Godot 4.7.2, headless gdUnit4 + xvfb screenshots); not checked against engine source.

## Pattern
- **Pure flight function** `simulate(from, dir, power, curve, item, env) → {points, landing, kind, hit}`: semi-implicit Euler with gravity, quadratic drag `a = -drag·|v|·v`, a constant lateral acceleration for the "effect/curve", and per-step segment tests (sphere targets → table plane inside the cloth rectangle → floor). The preview, the real launch and the CPU solver all call it. Test: preview landing == real landing; `solve_for_target` iterates pitch × power over the same sim and measures the closest approach **without** the target sphere (otherwise every hit measures as "radius" and the solver stops at a graze).
- **Re-solve at launch** for auto-aimed throws: the target moves (legs grow, leaning) between the decision and the release animation; a flight solved earlier grazes and misses.
- **State machine per seat**: `loaded` item (null while reloading) → `begin_charge` → power ramps to 1 and stays → `release` (below a minimum = cancel) → item spent + cooldown → only then roll the next item (weighted random, never the same twice in a row). `cancel` keeps the item and starts no cooldown. The charge is cut automatically when the situation ends (shot taken).
- **Data**: one resource per item (mass, drag, speed scale, hit multipliers, flinch, bounce, table mode OBSTACLE|FLAT); defaults built in code with a minimal `.tres`.
- **Physical obstacles**: rigid bodies without the game's "ball" meta so they never count as first contact/fouls; clamp them inside the cloth by hand; cap per shot; clear on `shot_resolved`.
- **HUD**: card with the item (shape icon, name, weight/annoyance/reach dots, note), reload bar, charge bar + curve marker under the reticle, reticle coloured by predicted target.

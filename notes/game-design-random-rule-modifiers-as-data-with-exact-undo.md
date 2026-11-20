---
id: game-design-random-rule-modifiers-as-data-with-exact-undo
type: pattern
domain: game-design
status: unreviewed
summary: "Randomly altering the rules for a turn (slick or sticky cloth, bouncy cushions, dead balls…) stays maintainable and fair when each modifier is a DATA resource of multipliers and addends over the physics config: apply it to a COPY, hot-reload the engine from that copy, announce it, and restore the original object exactly when the shot resolves. Fairness rules: it applies to both players and the CPU (which plans with the live config), never on the opening shot or the decisive shot, a cooldown between events, a weighted pick that avoids repeating the last one, an option to turn it off, and no events on the authoritative-host network mode unless they are replicated."
aliases: [random events, rule modifiers, table events, chaos modifiers, hot reload physics config]
tags: [dept/design, dept/gameplay]
applies-to:
  min: "Godot 4.0"
  tested: "Ginomo: 6 table events; measured roll distance slick > normal > sticky; exact restore test"
sources: []
related:
  - relates-to: "[[game-studio-composable-effect-resources-for-swappable-gameplay-items]]"
created: 2026-11-20
updated: 2026-11-20
created_by_type: agent
---

> **Evidence status — `unreviewed`.** Built and tested in Ginomo (Godot 4.7.2); not checked against engine source.

## Pattern
- `Event` resource: `scales {prop: factor}`, `adds {prop: delta}`, `shots`, `weight`, colour, i18n keys; `apply_to(base) → duplicate` + clamp of fragile values (restitution < 1); `validate()` checks every property name exists on the config.
- Node `Events`: on turn start roll `chance` (skip break/decisive/cooldown), `start()` swaps `sim.physics_cfg` and calls `backend.reconfigure(cfg)` (re-read every cached field AND the shared physics material); on `shot_resolved` count down and `stop()` → `reconfigure(base)` with the original object (assert `same`).
- AI and aim helpers must read the config LIVE (`sim.physics_cfg`) so they plan with the altered physics.
- Verify with a behavioural test (distance rolled under each event), not only with numbers.

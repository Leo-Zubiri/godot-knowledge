---
id: game-studio-parallel-readonly-review-then-fix-loop
type: pattern
domain: game-studio
status: unreviewed
summary: "To find many REAL improvements fast instead of inventing them: launch 3-4 read-only reviewers in parallel, each on a disjoint area (touch HUD, menus/platform, gameplay logic, per-frame performance) asking for a ranked list of VERIFIED findings with file:line and a 1-3 line fix; then fix them one by one, each with a regression test, a commit and a line in an iteration log. In one session this produced ~40 verified findings (stuck touch fingers, items landing on balls, settings reset wiping the wardrobe, per-frame allocations)."
aliases: [iterate 100 times, read-only code review agents, improvement loop]
tags: [dept/qa, scope/process]
related:
  - relates-to: "[[game-studio-review-modes-and-verdicts]]"
created: 2026-11-27
updated: 2026-11-27
created_by_type: agent
---

> **Evidence status — `unreviewed`.** One long autonomous session (Ginomo, Godot 4.7.2).

## The loop
1. **Probe first, review second.** Build small probes that reproduce what the player sees (xvfb screenshots at the phone's real viewport and scale, a logging scene that prints visibility/teleport/in-frustum transitions, a stress scene, a scene-statistics scene). They found bugs reading never would (an opponent teleporting behind the viewer's camera; 277 distinct materials for 220 meshes).
2. **Reviewers in parallel, read-only, disjoint scopes.** Tell each: do not edit; return at most 15 findings ranked by severity; each with `file:line`, a concrete failure scenario, a 1-3 line fix; "only report what you verified by reading, mark unverified otherwise". Four reviewers (HUD/touch, menus/platform, throwing/AI, performance) returned in 1-4 minutes each.
3. **Verify before fixing.** Re-read the code at the cited line (line numbers drift when you edit the same file) and reproduce with a test that FAILS before the fix.
4. **One finding = one iteration:** fix + regression test + one line in `docs/iteraciones-<date>.md` (what, why, verification). Commit in themed batches (never leave a red suite), run the full suite every ~10 iterations.
5. **Do not trust the reviewer's severity blindly:** two "unverified" items were wrong or irrelevant; the best ones were state-machine bugs (a finger held on a hidden button keeps "owning" the touch; a drag outliving a state change).

## Recurring bug patterns found this way (look for them first)
- **State outlives its owner:** hide/disable a widget with a finger down → clear `_finger`/`over_*` flags in `VISIBILITY_CHANGED` (and when the action ends), or the touch layer keeps swallowing that finger.
- **"End" vs "abort":** disabling a control mid-drag must NOT call the same path as a user release (it emitted "shoot" and confirmed a ball placement).
- **Late events:** anything in flight (thrown objects, timers, tweens) needs the turn/shot id it was created in; compare on arrival.
- **Tween on the wrong node:** `create_tween()` on the HUD animated a freed child; `pulse.create_tween()` dies with the node.
- **Caches keyed on events, not frames:** target lists, previews, ring meshes, label text, theme overrides — recompute only when inputs change.
- **Defaults hiding bugs:** empty `local_seats` meant "everyone local"; a saved setting nothing read (`aim_assist`); reset-to-defaults that wiped user data and did not notify listeners.
- **Spawn-validity:** anything spawned on a physics table must be pushed out of existing bodies and out of pocket mouths, and sit on its true half-height (capsule ≠ sphere).

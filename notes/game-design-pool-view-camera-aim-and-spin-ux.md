---
id: game-design-pool-view-camera-aim-and-spin-ux
type: guide
domain: game-design
status: unreviewed
summary: "UX pattern for a playable 3D pool/billiards view, built and exercised in a Godot 4.7.2 project: camera sits behind the shot and follows the aim; pull back to an overview while balls roll; aerial orthographic view oriented by screen aspect; ghost-ball aim prediction; a cue-ball disc for tip offset (spin); a power bar; ball-in-hand placement with a green/red ghost; balls readable by pattern AND number, never colour alone."
aliases: [pool camera, pool aiming UX, ghost ball, tip selector, ball in hand UI, billiards HUD]
tags: [dept/design, dept/ui-ux, dim/3d]
applies-to:
  min: "generic (any pool/billiards game; engine notes are Godot 4.x)"
  tested: "Godot 4.7.2.stable.mono, desktop (xvfb screenshots + headless tests); touch and Android NOT tested"
sources: []
related:
  - relates-to: "[[game-design-billiards-pool-physics-model]]"   # the physics the spin selector feeds
  - relates-to: "[[game-design-input-mapping-conventions-keyboard-gamepad-touch]]"   # per-device bindings
  - relates-to: "[[godot-touch-input-and-virtualjoystick]]"   # touch caveats for the widgets
  - relates-to: "[[godot-animation-tree-and-tween-pitfalls]]"   # tween-per-transition
created: 2026-11-12
updated: 2026-11-12
created_by_type: agent
---

> **Evidence status — interpretation, exercised once.** A design pattern we built and ran (screenshots, headless
> tests); no playtest data and no external source. *Feel and legibility are a human call.* Status `unreviewed`.

## Goal
Make a 3D pool view where the player can aim, add spin, set power and place the cue ball without fighting the camera.

## Pattern
1. **Camera behind the shot.** Yaw = aim angle (+ optional orbit offset); the player rotates the aim, not the camera.
2. **Overview while balls roll**, then ease back behind the next shot. One new `Tween` per transition, `kill()` the old one.
3. **Aerial orthographic view** toggled by one action; orient the table along the longer screen axis (portrait vs
   landscape) so it fills the screen.
4. **Aim prediction as a pure function** (ray vs ball circles → first contact, *ghost ball*, object-ball line, cue
   deflection, cushion bounce if nothing is hit). Render it opaque and unshaded (no transparency sorting trouble on
   mobile renderers); make the help level configurable.
5. **Tip selector** = the cue ball as a disc with a draggable dot, clamped to the miscue circle; also bind
   keys/D-pad and a reset. Pure value type, testable without UI.
6. **Power bar** separate from the aim, keyboard/trigger/drag.
7. **Ball in hand**: a ghost cue ball, green if legal / red if overlapping; mouse hover+click, keyboard moving
   relative to the camera, touch drag + lift to confirm; switch to the aerial view automatically while placing.
8. **Readability**: solids/stripes by pattern plus a number (Label3D discs at two poles that rotate with the ball, so
   spin is visible); HUD uses icons + text, never colour alone ([[game-studio-accessibility-minimums]]).

## Pitfalls seen
- A `Label3D` on a ball needs alpha cut (`ALPHA_CUT_DISCARD`), not blending, to avoid sorting artefacts.
- `Basis.scaled()` scales in global axes; to scale a mesh along its own axis (aim line) use `scaled_local()`.
- Keep view and rules apart: the view only listens to signals; the controller only emits intents.

## What I could not check
Touch behaviour on a real phone, playtest feel, accessibility with real players.

## Update — camera by ROLE and phase, spectator from your gnome's eyes, 3D ball mode (Ginomo, 2026-11)
- **A camera phase machine per local viewer**, not per absolute seat: `AERIAL, SUMMON_ORBIT, FIRST_PERSON_AIM, LUNGE_FOLLOW, OVERVIEW, PLACEMENT, SPECTATOR_EYES, SPECTATOR_SHOT, RESULT, BALL` with a `TRANSITIONS` table; an illegal request is ignored and recorded (`rejected`). Poses are PURE static functions (testable): `summon_pose` (≈2.2 m out, 55° pitch, a 12° arc during the ritual, always from the side), `spectator_pose(eye, look, yaw_offset)` (up vector = UP, so never any roll), `behind_shot_pose`. Transitions blend with slower smoothing plus an angular-speed cap for ~0.9 s; `reduce_motion` = cuts, no arc, no auto-orbit.
- **The bug that makes you feel like you are aiming while the CPU plays** is a camera/HUD that ignore who is active: the game must derive `observing` from (playable seats, active seat, state) and then hide power bar/tip selector/aim line, route A/D to roaming (heckle) instead of aim, and put the camera in your own character's eyes looking at the shooter during their ritual and at the cue ball afterwards. Hot-seat (one screen) has no spectator role; LAN observers only watch (no heckler there) but keep their prank hint.
- **Fair heckling** needs a grace window before the CPU shoots (a flag raised for the last ~0.4 s of its settle wait), a cool-down, and an effect scale against the CPU.
- **3D ball mode** (pick the contact point on the sphere): camera ≈0.24 m behind the ball with its own pitch/zoom (the wheel zooms the mode, not the aim view; orbit pitch is independent), picking = camera ray vs the ball sphere with ~15 % slack for fingers but mapped on the EXACT sphere point (mapping the slack hit inflates the tip). Map through the cue frame (`right`, `up'`), saturate to the miscue circle, magnet to 7 usual hits (centre, follow, draw, left, right, follow+left, draw+right) released with Shift, double click centres, `shoot` inside only leaves the mode, any FSM state change leaves it, hide the shooter gnome + cue so they do not cover the ball. Draw the contact dot always (small) and the elliptical miscue ring only in the mode, coloured green→amber→red by risk, built as a triangle strip on the sphere (line strips are 1 px). Screenshots need `xvfb-run` and the cue summon finished first (`cues.finish_summon()`), otherwise the camera stays in the ritual.

## Update — free first-person roaming for whoever waits (Ginomo, 2026-11)
- The spectator should not ride a rail: give the waiting player a rectangular ring around the table (inner = the old perimeter, outer = + `roam_depth`), WASD relative to where they LOOK, a free 360° yaw with a pitch limit (arrows/stick/drag), and make the camera the head (no smoothing lag, otherwise it feels like swimming). Keep the shooter always facing their shot. A pure `GnRoamArea` (clamp to ring, step with diagonal normalisation, `look_angles`) is trivially testable: inside the table → push out by the nearest side; "walk forward while turning" never ends inside the table.
- A fixed spectator eye at table-rim height shows the cloth edge-on and the cue ball is a dot; raise the eye (≈0.5 m) and, if you keep an assisted view, pull it toward the focus to a max distance. Aim the head ONCE at the shooter+ball when the turn starts, then hand control over (never keep re-aiming).
- After the shot, do not cut from first person to the overview: ease (smoothstep over ~2 s) pitch, distance, yaw, target and look-ahead from the aim pose to the overview pose; `reduce_motion` = cut. Over-the-shoulder offset (≈0.12 m to the shooter's right) stops a cue that lies on the sight line from hiding the cue ball.
- Pitfalls hit: assigning an untyped `[x]` literal to an `Array[int]` var is a RUNTIME error that floods every test (use `.clear()/.append()`); new `class_name` files need `make import` before `make check` sees them.
- **Sticky "last shooter" trap:** a field that records who shot LAST (kept until the next shot) must never decide who may roam NOW. It pinned the player who shot before to the limited camera for the whole next turn, and the bug hid because every test started with the CPU breaking (field still unset). Decide "who waits" from the live turn state (active seat / current phase) only, and write the regression test with the human having shot first.

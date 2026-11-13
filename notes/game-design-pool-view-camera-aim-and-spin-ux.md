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

---
id: game-design-first-minute-onboarding-and-result-screen
type: guide
domain: game-design
status: unreviewed
summary: "Concrete designs, run in a turn-based physics game, for the screens around a match: a result screen with a per-player summary, rematch and change-settings; a pause menu with embedded settings, a live-InputMap controls page and a two-press restart; a settings panel with tabs and accessibility switches; a first-minute coach card that advances by itself and is shown once; a touch gesture reminder; a potted-ball reward animation; and the colour-similarity lesson (RGB distance, not luminance)."
aliases: [result screen rematch, pause menu design, first minute coach, onboarding card, settings tabs accessibility, potted ball reward, rematch same settings, two-press confirm]
tags: [dept/design, dept/ui-ux, tool/godot]
applies-to:
  min: "4.0"
  tested: "Godot 4.7.2.stable.mono; unit and integration tests, plus captures of the running screens read as images; no human playtest"
sources: []
related:
  - relates-to: "[[godot-animated-menu-background-and-single-theme]]"   # the look these panels share
  - relates-to: "[[game-design-game-feel-and-juice-checklist-turn-based-physics]]"   # juice around the same events
  - relates-to: "[[game-studio-accessibility-minimums]]"   # text size, reduced motion, touch targets
  - relates-to: "[[godot-ui-focus-and-gamepad-navigation]]"   # keep focus and navigation working in every panel
  - relates-to: "[[game-studio-playtesting-methods]]"   # how to validate these with real players
created: 2026-11-16
updated: 2026-11-16
created_by_type: agent
---

> **Evidence status — own designs, run here (interpretation).** These screens were implemented and covered by tests; the running
> screens were captured and inspected as images. No player has used them, so whether they *help* is unproven. Status `unreviewed`.

## Result screen
- Winner line (or draw) from a generic result object: `per_seat[seat] = {score, rank, stats}`; the screen only lists statistics it
  knows (shots, balls potted, fouls, best run) and **skips rows no seat reports**, so another minigame can report different numbers.
- Counted in the match state machine (not in the view): `shots` per resolved shot; `potted` = balls 1–15 pocketed (not the cue ball);
  `fouls`; `run` increments only when a ball was potted **and** the turn continues **and** there was no foul, otherwise it resets;
  `best_run` keeps the maximum. Duration as `m:ss`.
- Buttons: **Rematch** (reuse the stored last game id, mode and setup options with a **new RNG seed**), **Change settings** (back to the
  setup screen), **Menu**. Rematch and change-settings are hidden after a network game (nothing to restart alone).

## Pause menu
Resume · **Settings** (the same settings panel, embedded) · **Controls** · **Restart** · Quit.
- The controls page is built from the **live InputMap** through an action-hint helper (keyboard and gamepad columns), so a remapped key
  is shown correctly; a touch sentence explains drag / pinch / buttons.
- **Restart asks twice:** the first press turns the label into "Sure? Press again" and disarms after 3 s (timer that ignores pause);
  the second press restarts. Implementation: abort the match, `await get_tree().process_frame` (the old node is freed), start the same
  match again. Disabled over the network.
- If the audio service pauses with the tree, the clicks in this menu are silent — see the audio notes (process mode ALWAYS).

## Settings panel
Tabs **Audio · Game · Accessibility**. Audio: one slider per bus with the value shown (`80%`). Game: language, "music during matches".
Accessibility: camera-shake slider, reaction level (none / some / all), **reduce motion**, **text size** (rebuilds the theme).
Every change is saved immediately; controls ≥ 48 px high. Works from the menu and from the pause menu.

## First-minute coach
A small card, shown **once**, with three steps in order — aim → choose power → shoot — that **advances by itself** from the shot draft:
aim moved more than ~3°, power moved more than ~0.08, then the shot starts (which also ends and saves it). The text comes from the
live InputMap for the current device (keyboard / gamepad / touch), so it never lies after a remap. "Don't show again" saves the flag
(`onboarding.seen`). Disabled for the network mirror (that player is not the one breaking). Touch players get a one-line gesture reminder
(drag: aim · pinch: zoom) instead of an empty help line, plus an outline on the help text so it reads over light and dark areas.

## Potted-ball reward
When a ball is pocketed, a copy of its icon (size ~44, scale 1.9→0.9) flies from its slot in the ball strip to the **shooter's card** (0.55 s,
quad in-out, position and scale in parallel with `set_parallel(true)`, then `set_parallel(false)` for the fade and `queue_free`), and the
"N left" counter pops (1.35× then back) as the icon arrives. Spawn it *before* the strip is rebuilt. Pure view; the cue ball gives nothing.

## Transitions
Panel changes flip `visible` **instantly** and tween only `modulate.a` over ~0.18 s (tests keep asserting visibility). Entering or leaving
a scene uses a black veil on a high `CanvasLayer` (101) with `mouse_filter = IGNORE`, tweened out in 0.5 s; reduce-motion skips the panel fade.

## Lesson: judge colour similarity by RGB distance, not luminance
Two ball colours that looked alike (red vs maroon) had a **luminance** difference that stayed low even after darkening, but their RGB
distance went from 0.29 to 0.46 when the maroon became a brown; the test asserts the distance (> 0.40) plus a luminance gap only
where the issue is contrast against black. Numbers and patterns stay the primary identifier; colour is the reinforcement.

## What is not verified
Whether players understand the coach, find the result summary useful, or like the reward animation; frame cost on a phone.

## See also
- [[godot-animated-menu-background-and-single-theme]] — the shared theme and background these panels use.
- [[game-design-game-feel-and-juice-checklist-turn-based-physics]] — juice and feedback rules for the same events.
- [[game-studio-accessibility-minimums]] — minimums for text, contrast, motion and touch.
- [[game-studio-playtesting-methods]] — validating onboarding with players.

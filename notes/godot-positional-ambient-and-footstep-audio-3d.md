---
id: godot-positional-ambient-and-footstep-audio-3d
type: guide
domain: godot
status: unreviewed
summary: "Positional (3D) ambience and footsteps in Godot 4.7: AudioStreamPlayer3D with inverse-distance attenuation (unit_size, max_distance) for a wall clock and a fireplace, looped from seamless clips; one footstep signal per footfall detected as the sign change of the walk-cycle sine, a reused pool of 6 players, per-character minimum gap, pitch/volume jitter, no repeat, silent when hidden; levels verified by recording the running game instead of guessing."
aliases: [3d ambient sound, footstep sounds, AudioStreamPlayer3D attenuation, clock tick fireplace crackle, positional audio, footfall detection, room ambience]
tags: [dept/audio, dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "Godot 4.7.2.stable.mono; tests plus a recorded 20 s automatic match (xvfb, --write-movie) analysed with ffmpeg and Python; spatial feel and loudness balance NOT judged by ear"
sources: []
related:
  - relates-to: "[[godot-audio-buses-and-adaptive-music]]"   # buses, limiter, ducking and the music player
  - relates-to: "[[godot-physics-driven-impact-audio-for-rigid-body-games]]"   # the impact side of the same mix
  - relates-to: "[[game-studio-ffmpeg-sample-processing-for-cc0-game-audio]]"   # seamless loops and two-pass normalisation
  - relates-to: "[[godot-code-driven-character-animation-without-skeleton]]"   # the walk cycle the footfalls are read from
  - relates-to: "[[godot-audio-debug-overlay-for-listening-feedback]]"   # lists 3D sounds too, if they emit the same signal
created: 2026-11-15
updated: 2026-11-15
created_by_type: agent
---

> **Evidence status — own pattern, `unreviewed`.** Built, tested and recorded in one project. The agent could measure levels in a recording but **could not hear**
> spatial feel or balance; the first levels chosen were far too low (below), which is why recording-and-measuring is part of the recipe.

## Goal
Give a room small positional sounds (a ticking clock, a fireplace) and tiny characters footsteps that come *from where they are*, without drowning the main
impact sounds and without a per-event node cost.

## Positional room sounds
1. **Player.** `AudioStreamPlayer3D` with `attenuation_model = ATTENUATION_INVERSE_DISTANCE`, `unit_size` = the distance at which it plays at its nominal
   volume (2.5–4 m for a room), `max_distance` = cutoff (9–14 m; beyond it, silent and cheaper), `bus = Ambient` (or `Characters` for footsteps),
   `autoplay = true` for loops. The listener is the **current `Camera3D`** automatically.
2. **Loops.** Use seamless clips ([[game-studio-ffmpeg-sample-processing-for-cc0-game-audio]]). For `AudioStreamWAV` set `loop_mode = LOOP_FORWARD`,
   `loop_begin = 0`, `loop_end = length × mix_rate` at runtime.
3. **Placement when the room is built before it is in the tree.** `global_position` is not valid yet; compute it as `parent.transform * child.position`
   (e.g. the fireplace node under its wall holder, plus a small offset to the firebox). Add the player as a child of the room at that local position.
4. **Levels — verify, don't guess.** The first values (−20 dB clock, −22 dB fire) produced a recorded RMS of **≈ −65 dBFS: inaudible**. Raising them to
   ≈ −9 / −12 dB gave a background that exists but never covers impacts. Method: `--write-movie` under `xvfb-run`, extract the audio with
   `ffmpeg -vn -ac 1`, print peak/RMS per 0.5 s with Python's `wave` module, and compare with the impact peaks. A test asserts the volume is ≤ a ceiling
   (so ambience never masks impacts) and that a loop player exists only when the object exists (a fireplace player only if the room has a fireplace).
5. **Config, not constants:** on/off, dB per sound, `unit_size`, `max_distance`.

## Footsteps
1. **Detect the footfall, don't schedule it.** If the walk animation is `cycle = sin(t × rate)` and the body is lowest at the zero crossings, emit a
   `footstep` signal when the **sign of `cycle` changes**, only while the walk blend is above 0.5 (so entering/leaving the walk does not stutter). Keeping the
   previous sign in a variable is enough; the cadence then follows the animation speed (walk vs run) for free.
2. **Player pool.** Six reused `AudioStreamPlayer3D`s (round-robin); set `global_position` to the character's position before `play()`. No node creation per step.
3. **Variation.** Several real step clips; pick without repeating the last one; ±10 % pitch and ±1 dB per step; a **minimum gap per character (≈ 0.11 s)** so a
   run cadence cannot machine-gun; silent when the character is hidden (a first-person camera hides the player's own body).
4. **Clips.** Very short (0.14–0.35 s), high-passed ≈ 260 Hz for tiny feet, pitch raised ×1.1–1.2, normalised to −3 dBFS and given their level by config (≈ −15 dB).
5. **Not networked.** Each screen animates its own characters; footsteps are local events and must not travel with the simulation messages. They also do
   not touch determinism.
6. If a debug overlay lists sounds, emit the same signal for these 3D players so they appear in the list.

## Tests that were worth writing
- A walking character emits N footsteps over T seconds (range check); a still one emits none.
- Steps come from the catalog, never repeat the last, use the `Characters` bus, and the player sits at the character's position.
- The per-character gap, the on/off switch and the hidden-character rule.
- The game wires the footsteps to both characters; the room builds the clock player at the clock's position with a loop and the `Ambient` bus.

## What an agent cannot check
Whether the pan, distance falloff and level *feel* right on the owner's speakers — only a listener can. The recording shows levels, not taste.

## See also
- [[godot-audio-buses-and-adaptive-music]] — bus layout, limiter, ducking, music player.
- [[godot-physics-driven-impact-audio-for-rigid-body-games]] — the impact mix these sounds sit under.

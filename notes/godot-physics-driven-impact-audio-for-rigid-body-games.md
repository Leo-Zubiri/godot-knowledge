---
id: godot-physics-driven-impact-audio-for-rigid-body-games
type: guide
domain: godot
status: unreviewed
summary: "How to make impact, rolling, pocket and voice audio of a billiards-style rigid-body game follow the real simulation in Godot 4.7: a velocity-to-loudness curve (dB lerp with an exponent), three intensity tiers choosing a variant bank, anti-repeat variants, soft-hit gaps, a burst-window cap, a reused 16-player pool that steals the quietest voice, ONE aggregate seamless rolling loop with attack/release, pocket sound from the ball's last known speed, delayed voice reactions with a budget, and network/determinism rules."
aliases: [impact audio, billiards sound, collision sound loudness, rolling sound loop, audio polyphony pool, voice stealing, sound cooldown, burst limiter, ball pocket sound]
tags: [dept/audio, dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "Godot 4.7.2.stable.mono; unit/integration tests with an injectable sink plus one recorded 20 s automatic match; timbre and loudness balance NOT judged by ear"
sources: []
related:
  - refines: "[[godot-procedural-placeholder-sfx-audiostreamwav]]"   # the generators and the single-curve starting point
  - relates-to: "[[godot-audio-buses-and-adaptive-music]]"   # buses the players and loops go through
  - relates-to: "[[game-design-game-feel-and-juice-checklist-turn-based-physics]]"   # section 7: audio layering and voices
created: 2026-11-15
updated: 2026-11-15
created_by_type: agent
---

> **Evidence status — own pattern, `unreviewed`.** Everything below was *built and run* in one project: tests pass (injectable sink, fake
> events) and one automatic match was recorded and measured (see [Evidence](#evidence)). The numbers are tuned starting points, not
> sourced constants. **What was NOT checked:** how it sounds. No timbre, loudness balance or "feel" was judged by a listener; the first
> human listen should adjust the dB range, the curve exponent and the gaps.

## Goal
Every sound the player hears should be caused by a real simulation event and scale with its physical strength — without
machine-gunning, saturating the mixer, or playing while nothing moves.

## Architecture in one paragraph
A *view-only* node listens to signals the simulation already emits (`cue_struck(speed)`, `ball_hit(relative_speed)`, `rail_hit(speed)`,
`ball_pocketed(id)`), decides *whether*, *which* and *how loud*, and hands `(stream, volume_db, pitch)` to a sink (an autoload player
pool; a fake in tests). It never writes to the simulation, so it cannot affect determinism, and the same signals work for a replay.

## Steps
1. **Velocity → loudness.** `t = clamp(speed / max_speed, 0, 1) ** curve`, `db = lerp(quiet_db, loud_db, t)`, and silence below `min_speed`.
   With `curve ≈ 1.5` a graze is far quieter than a break. *Why:* impact energy grows with the square of speed, and a straight dB lerp
   makes small contacts as loud as medium ones. Keep `max_speed`, the two dB values and the exponent in a config resource.
2. **Three intensity tiers choose a bank, not just a volume.** `soft < tier_soft·max ≤ medium < tier_hard·max ≤ hard` (starting points
   0.22 and 0.55). A soft hit is duller and shorter (fewer partials), a hard hit brighter and longer with a low "thock". Pitch alone does
   not make a hard hit sound hard.
3. **≥ 3 variants per (kind, tier), never the same twice in a row.** Anti-repeat index trick: pick `j = randi() % (n-1)`; `if j >= last: j += 1`.
   Store `last` per `kind*10 + tier`. Add small random `pitch_scale` (±6 %) and volume (±1 dB) on top. (`AudioStreamRandomizer` does the same
   job for resource-based banks; a code bank is easier to test with an injectable sink.)
4. **Soft-hit gap.** Soft ball/cushion hits wait ≥ ~45 ms between each other (hard hits use only the small per-kind interval, ~20 ms), so a
   cluster of grazes does not sound like a ratchet.
5. **Burst-window cap.** Count accepted non-voice sounds in a sliding window (e.g. 50 ms). When the count reaches N (e.g. 6) only *hard*
   hits are accepted. A break shot then stays loud and clean instead of saturating.
6. **Pool, no nodes per event.** 16 `AudioStreamPlayer`s created once. To play: use a free one; if all are busy, **steal the quietest** — but
   only if the new sound is louder than it; otherwise drop the new sound. Also skip the *same stream object* started within ~12 ms (two
   events in one frame sound once). Keep counters (`stolen`, `dropped`) for tests and diagnostics.
7. **Rolling = ONE aggregate loop, not one player per ball.** Generate a dark noise loop (one-pole low-pass, a slow amplitude "breathing" with
   an *integer* number of cycles) as an `AudioStreamWAV` with `loop_mode = LOOP_FORWARD`. For a **seamless** loop, synthesize `n + xf`
   samples and crossfade the extra tail into the head of the first `xf` samples (≈ 50 ms), then set `loop_end = n`.
   Each frame read the ball velocities (read-only), count only balls that are on the surface, awake and above `roll_min_speed`:
   `level = 1 - exp(-1.6 · Σ (v/vmax)^1.2)` (saturating sum), `target_db = lerp(roll_quiet, roll_loud, level)`, `pitch = lerp(low, high, fastest/vmax)`.
   Move the real volume toward the target with **attack/release rates in dB per second** (e.g. 220 up, 70 down) so it never cuts off.
   **When the volume is below ≈ −60 dB call `stop()`** so nothing plays silently, and `play()` again when it rises. Sleeping, airborne or
   too-slow balls contribute nothing.
8. **Pocket sound from the ball's last known speed.** The "pocketed" signal usually carries no speed and the body is already removed.
   Record each ball's horizontal speed every frame in the view node and read it on the signal; scale it (balls drop slowly, ×2.5) and clamp to
   a floor (≈ 30 % of `max_speed`) so a nearly still ball still plops audibly. Then, after ~0.45 s ± jitter, play a **return-chute** sound
   (a short rumble ending in a soft clack) as a separate kind.
9. **Voice reactions are a different budget.** Play them ~0.3 s *after* the event (the result must be readable, and it must not sit on top of
   the impact); minimum interval ≈ 6 s; a per-match count budget; never repeat the previous variant; honour a player preference
   (off / half / all). Put them on their own bus.
10. **Replicated sound kinds.** If sounds are forwarded over the network as `(kind:int, speed:float)`, **append new enum values at the end**;
    never reorder. The receiver applies its own rate limits and preferences. Delayed sounds are forwarded when they *actually play*.
11. **Keep it view-only.** No audio code in the physics step; nothing reads audio state back into rules.

## Evidence
- Unit/integration tests with an injectable sink: tiers follow speed; a graze is ≥ 8 dB quieter than a hard hit; variants differ and never
  repeat consecutively; soft hits are gap-limited while a hard one passes; the burst cap admits exactly N then only hard hits; pocket volume
  rises with arrival speed and never drops below the floor; the rolling level is 0 for still balls and grows with speed and count; the roll player
  stops after the balls stop; the loop's last and first samples are close (no click); the voice budget resets per match; the pool steals only
  for louder sounds and counts drops.
- **Recorded match:** `godot --path . --write-movie out.avi --fixed-fps 60 --quit-after 1200 scene.tscn` records the game's **audio into the AVI**
  (needs a display, e.g. `xvfb-run`). Extract with `ffmpeg -i out.avi -vn -ac 1 -ar 44100 out.wav`, then read it with Python's `wave` +
  `array` (no numpy needed): per-250 ms peak and RMS. Result: the break peaked ≈ −1 dB; between impacts only rolling at ≈ −30…−45 dB; **true
  silence** (no samples above −60 dB) for the whole stretch after every ball stopped; no continuous re-triggering during contact.
- `godot --headless` uses a dummy audio driver, but `AudioStreamPlayer.playing`, `volume_db` and `pitch_scale` still behave, so pool and
  roll logic are testable in CI. (Timing from `create_timer` versus wall-clock `Time.get_ticks_msec()` can disagree inside a test runner; make
  grace periods a property the test can set to 0 instead of waiting.)

## Pitfalls
- Per-ball rolling players multiply voices and fight the pool; one aggregate loop is cheaper and sounds like a table, not like N toys.
- A looping `AudioStreamWAV` without a crossfaded seam clicks once per loop.
- A sink that is the engine's pool must dedupe by stream object, otherwise a signal connected twice doubles the level.
- Laughs/voices must not be rate-limited by the *impact* limiter: give them their own interval, budget and bus.

## See also
- [[godot-procedural-placeholder-sfx-audiostreamwav]] — how to synthesize the streams themselves (modal impacts, concat, pitfalls like "I hear nothing").
- [[godot-audio-buses-and-adaptive-music]] — bus layout and what fails silently when a bus is renamed.
- [[game-design-game-feel-and-juice-checklist-turn-based-physics]] — section 7, audio layering and character voices.

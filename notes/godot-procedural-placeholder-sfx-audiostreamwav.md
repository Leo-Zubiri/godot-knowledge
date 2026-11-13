---
id: godot-procedural-placeholder-sfx-audiostreamwav
type: guide
domain: godot
status: unreviewed
summary: "How to make placeholder sound effects in code in Godot 4.7.2 with no asset files: build an AudioStreamWAV from a PackedByteArray, use modal synthesis (inharmonic partials + a short noise transient) for impacts, concatenate for laughs, vary volume_db and pitch_scale per play on a player pool, and avoid inaudible tones (low frequencies at low level vanish on laptop speakers)."
aliases: [procedural sfx, synthesized sound effects, AudioStreamWAV from code, placeholder sounds, modal synthesis impact]
tags: [dept/audio, tool/godot]
applies-to:
  min: "4.0"
  tested: "Godot 4.7.2.stable.mono, PulseAudio desktop (mechanics run in the engine; timbre judged by ear by one person)"
sources: []
related:
  - relates-to: "[[godot-audio-buses-and-adaptive-music]]"   # buses and players the sounds go through
  - relates-to: "[[game-studio-2d-ui-audio-materials]]"   # audio import rules and tools
  - relates-to: "[[game-studio-asset-source-catalog]]"   # where to get real CC0 samples
created: 2026-11-12
updated: 2026-11-12
created_by_type: agent
---

> **Evidence status — mixed.** The mechanics (building the stream, playing it, volume/pitch per play, headless tests) were *run in the
> engine*. The timbre advice is *interpretation* from one listener's feedback: a first sine-based version was called "marbles and drums";
> the modal version below was written in response and **not confirmed by ear**. Status `unreviewed`. Placeholders only — real CC0 samples
> or recordings should replace them ([[game-studio-asset-source-catalog]]).

## Goal
Get convincing-enough sound events into a prototype without sourcing files, keep them config-driven, and make them testable.

## Mechanics (verified)
1. `AudioStreamWAV`: set `format = FORMAT_16_BITS`, `mix_rate` (44100), `stereo = false`, and `data` = `PackedByteArray` of little-endian
   signed 16-bit samples (`data.encode_s16(i * 2, value)`). No import step, no files, no provenance entry.
2. Make the generator a **pure function** with a fixed noise seed: same parameters → same bytes. That makes it unit-testable (length =
   `duration * rate * 2` bytes, peak, determinism, decay: the last quarter is much quieter than the first).
3. Play through a small **pool of `AudioStreamPlayer`s** on an SFX bus; set `volume_db` and `pitch_scale` **per play** (the same stream then
   serves soft and hard hits and does not sound like a repeated sample: ±5 % pitch jitter).
4. Scale volume with the event's physical intensity (impact speed) and add a **per-type minimum interval** (≈ 20 ms) so a break does not
   machine-gun. Stay silent below a minimum intensity.
5. Keep the mapping event → sound in a view node that only listens to signals from the simulation; keep levels/intervals in a config resource.

## Impact timbre (interpretation)
- A single decaying sine plus noise sounds like a marble or a drum. A rigid object's hit is a **sum of modes**: several **inharmonic**
  partials (for a resin ball roughly 1.4–7 kHz) each with its own decay and amplitude, plus a **~1 ms noise transient**. Soft/dull contacts
  (rubber cushion) use a low-passed transient (one-pole filter on the noise) and low partials (≈ 100–350 Hz).
- **Normalize** the summed signal to a target peak so the level does not depend on how many partials you add.
- A laugh or a multi-part sound: generate each syllable and **concatenate** with short silent gaps, pitch stepping down.

## Pitfall: "I hear nothing" (verified)
The first version used 130–190 Hz bodies at −15…−25 dB with 60 ms clicks. The engine reported the players as playing (PulseAudio active,
buses unmuted, ~22 events in one shot) yet the listener heard **nothing** on laptop speakers. Fix: raise the fundamentals (≥ 250–300 Hz),
lengthen the sounds (≈ 100–150 ms), and use a louder range (≈ −14…0 dB). Debug order: check buses/mute, check `player.playing`, log the events
the code emits, and only then suspect the mix.

## What an agent can and cannot check
- Can: run the generator, assert length/peak/determinism/decay, assert which events trigger sounds, confirm a player is `playing`.
- Cannot: judge timbre or loudness. A human listens; iterate on one sound per round of feedback.

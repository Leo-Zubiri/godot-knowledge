# Checklist — closing an audio pass

Use with `phase-exit.md` when a phase adds or changes game audio. Every item needs evidence (command + literal output, a file,
a test report, a capture). "Sounds fine" from the agent is NOT VERIFIED: an agent cannot hear — the human gate is explicit below.
Background: `godot-physics-driven-impact-audio-for-rigid-body-games`, `game-studio-ffmpeg-sample-processing-for-cc0-game-audio`,
`game-studio-categorised-audio-catalog-pattern`, `game-studio-sourcing-cc0-audio-with-a-logged-in-browser`,
`godot-audio-debug-overlay-for-listening-feedback`, `godot-positional-ambient-and-footstep-audio-3d`.

## Sources and licences
- [ ] Every file is CC0 or public domain; **the licence was read on the file's own page** (not assumed from a search filter or a
      pasted link) and recorded (URL, date, licence line). CC BY / BY-NC / BY-SA found along the way are listed as excluded.
- [ ] No source is clipped or distorted: `volumedetect` max below 0 dB and a 50 ms peak timeline shows no run of 0 dBFS windows.
- [ ] Provenance generated into the asset registry and a provenance file; the asset-registry lint passes; the catalog validates
      (unique ids, files exist, licence + source on every entry).

## Clips and levels
- [ ] Impact clips are short (ball–ball ≈ 0.2 s, cue ≈ 0.1 s, pocket ≲ 0.8 s) with a fade-out; no long noisy tail.
- [ ] Intensity tiers come from **measured** peaks of isolated, clean hits (silence before, quiet tail) — not guessed by ear or spectrum;
      anything classified by inference carries an `inferred` tag and stays behind a flag.
- [ ] No recorded composite (a break with the ball scatter, a drop with its own chute) is played **together with** the
      simulation's own per-event sounds (double counting = "other sounds overlapping").
- [ ] Secondary contact sounds never outrank the primary collision (gain offset + masking window); soft secondary hits are dropped
      right after a primary one.

## Behaviour (from a captured match, not from reading code)
- [ ] A recorded automatic match (`--write-movie` under a virtual display, audio extracted with ffmpeg) shows: impacts scale with
      speed, **true silence** when nothing moves, no continuous retriggering, positional sounds present and audible but under impacts.
- [ ] Polyphony is bounded (pool reused, quietest voice stolen only by a louder one, per-stream dedupe); bursts (the break) do not saturate.
- [ ] Mix chain: limiter on Master; buses and effects created idempotently; ducking uses its own gain stage and never touches the
      player's volume sliders.
- [ ] Per-bus volume sliders exist and map to the buses; mute works.

## Human gates and defaults
- [ ] An on-screen audio overlay (or equivalent log) lets the owner name the exact sound they dislike.
- [ ] **Subjective assets (voices, music, intro/first-impression sounds) were approved by a human ear**; until then they ship behind
      config switches whose default is OFF, with the files and tests kept.
- [ ] Tests assert the **shipped defaults** (switches, loaded `.tres`) and the behaviour with each switch on.
- [ ] Generic findings written back to the knowledge base (`unreviewed`/`proposed`), and the plan's `active.md` updated.

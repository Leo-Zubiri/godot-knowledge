---
id: godot-audio-buses-and-adaptive-music
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 audio: bus layout and naming pitfalls (a mismatched bus plays on Master), interactive and playlist streams for adaptive music, 3D audio and sync notes."
tags: [dept/audio, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Audio pages: buses, sync, AudioStreamInteractive, AudioStreamPlaylist, AudioStreamPlayer3D"
    ref: src-gd-audio
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-sourcing-cc0-audio-with-a-logged-in-browser]]"   # where CC0 music can be found and verified
  - relates-to: "[[game-studio-loudness-targets]]"   # loudness targets
  - relates-to: "[[game-studio-2d-ui-audio-materials]]"   # audio production and import
  - relates-to: "[[godot-positional-ambient-and-footstep-audio-3d]]"   # 3D players for footsteps and room sounds
created: 2026-11-08
updated: 2026-11-16
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **Buses:** layout saves to `res://default_bus_layout.tres`; routing always goes to a bus on the left; keep Master below 0 dB. **Renaming a bus breaks references** (players then play on Master); rearranging is safe. On web export, effects do not work with the default Sample playback mode (use Stream).
- **Adaptive music:** `AudioStreamInteractive` combines clips with a transition table (when to transition: immediately/next beat/next bar/clip end; fade in beats; optional filler); add clips before transitions; looping clips ignore auto-advance. `AudioStreamPlaylist` plays up to 64 streams with `loop`, `shuffle`, `fade_time`; streams need extra audio after their end for fading. `AudioStreamSynchronized` was not read.
- **AudioStreamPlayer3D:** enable doppler on both player and camera/listener; `max_distance` saves CPU; the `bus` property does not validate the name (falls back to Master).
- **Sync:** `get_playback_position()` advances in chunks — add `AudioServer.get_time_since_last_mix()` and subtract output latency (page may not be fully updated for 4.7).

## Run in a game (own pattern, `unreviewed`; the sections above stay documentation-level)
Built and tested in one project; timbre and balance were not judged by ear.
- **Buses by code, idempotent.** Create `Music, Sfx, Ui, Ambient, Characters` (each sending to Master) at start when missing; settings sliders map
  linear → dB with `linear_to_db`. Add an `AudioEffectLimiter` on Master (ceiling −1 dB, threshold −3 dB) once, and an `AudioEffectAmplify` at index 0 on
  buses you will duck, so ducking never touches the player's slider ([[godot-physics-driven-impact-audio-for-rigid-body-games]]).
- **Music player.** Two `AudioStreamPlayer`s on the `Music` bus; to change track start the new one at −80 dB and `tween_property` it to 0 dB while the old one
  goes to −80 dB, then stop the old one in a chained callback (kill the previous Tween first). Set the loop **at runtime**: `stream.set("loop", true)` for
  `AudioStreamOggVorbis`/`AudioStreamMP3`; for `AudioStreamWAV` set `loop_mode = LOOP_FORWARD`, `loop_begin = 0`, `loop_end = length × mix_rate`. The *same* track
  asked again must not restart (compare a label). `play_music_category("music.menu")` takes a track from a catalog and **returns false (silence)** when none
  exists, so the game ships and runs without music until the owner picks CC0 tracks. Hook it where screens change (menu → `music.menu`, in match → `music.match`).
- **3D sounds** (footsteps, clock, fireplace): [[godot-positional-ambient-and-footstep-audio-3d]].

## What an agent can and cannot check
An agent can read `default_bus_layout.tres` and check that bus names used in scenes/scripts exist, and measure loudness offline. Mix balance, transition musicality and spatial feel need a human listening.

## Music in a game: levels, ducking and the pause trap (run here; interpretation, unreviewed)
- **Levels in config, in dB:** menu track −10 dB, match track −18 dB ("very light"), on top of the player's Music slider; the track itself is
  normalised to about −24 LUFS. Per-match toggle ("music during matches") in settings.
- **Sustained ducking helper** `set_duck(bus, db, fade)`: a `Tween` on an `AudioEffectAmplify` placed at index 0 of the bus (so the player's
  slider is untouched); `0 dB` releases it, positive values are clamped to 0. Used: −8 dB while the game is paused, −4 dB while the balls roll
  (attack 0.25 s), released in ~1.2 s when the player aims again; a timed `duck()` stays for short events.
- **Pause trap:** an audio autoload with the default process mode **freezes when `get_tree().paused` is true** — its pooled players stop mid-sound,
  its tweens stall (no fades or ducking) and the clicks of the *pause menu itself* are silent. Set `process_mode = PROCESS_MODE_ALWAYS` on the audio service.
- Two crossfading `AudioStreamPlayer`s on the Music bus, loop set at runtime (`stream.set("loop", true)` for Ogg/MP3; `loop_mode`/`loop_begin`/`loop_end`
  for WAV), the same track again does not restart, an empty category means silence.
- Verified with tests using a fake catalog (levels, ducking, toggle, paused-tree sounds). **Not verified:** the real loudness in a match
  through the menu flow, and any human judgement of the music.

## See also
- [[game-studio-loudness-targets]] — loudness targets
- [[game-studio-2d-ui-audio-materials]] — audio production and import

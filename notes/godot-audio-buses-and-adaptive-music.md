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
  - relates-to: "[[game-studio-loudness-targets]]"   # loudness targets
  - relates-to: "[[game-studio-2d-ui-audio-materials]]"   # audio production and import
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **Buses:** layout saves to `res://default_bus_layout.tres`; routing always goes to a bus on the left; keep Master below 0 dB. **Renaming a bus breaks references** (players then play on Master); rearranging is safe. On web export, effects do not work with the default Sample playback mode (use Stream).
- **Adaptive music:** `AudioStreamInteractive` combines clips with a transition table (when to transition: immediately/next beat/next bar/clip end; fade in beats; optional filler); add clips before transitions; looping clips ignore auto-advance. `AudioStreamPlaylist` plays up to 64 streams with `loop`, `shuffle`, `fade_time`; streams need extra audio after their end for fading. `AudioStreamSynchronized` was not read.
- **AudioStreamPlayer3D:** enable doppler on both player and camera/listener; `max_distance` saves CPU; the `bus` property does not validate the name (falls back to Master).
- **Sync:** `get_playback_position()` advances in chunks — add `AudioServer.get_time_since_last_mix()` and subtract output latency (page may not be fully updated for 4.7).

## What an agent can and cannot check
An agent can read `default_bus_layout.tres` and check that bus names used in scenes/scripts exist, and measure loudness offline. Mix balance, transition musicality and spatial feel need a human listening.

## See also
- [[game-studio-loudness-targets]] — loudness targets
- [[game-studio-2d-ui-audio-materials]] — audio production and import

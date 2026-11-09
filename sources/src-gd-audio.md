---
id: src-gd-audio
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/audio/audio_buses.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/audio/audio_buses.html"
    - "https://docs.godotengine.org/en/stable/tutorials/audio/sync_with_audio.html"
    - "https://docs.godotengine.org/en/stable/classes/class_audiostreaminteractive.html"
    - "https://docs.godotengine.org/en/stable/classes/class_audiostreamplaylist.html"
    - "https://docs.godotengine.org/en/stable/classes/class_audiostreamplayer3d.html"
  title: "Godot 4.7 audio: buses, interactive/playlist streams, 3D player, sync"
  retrieved: 2026-11-08
  version: "4.7 (headers reported by subagent); sync page notes it may not be fully updated for 4.7"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot documentation pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. **Version:** page headers say *Godot Engine 4.7 documentation* — confirmed by the main agent on the pages listed under "re-read", reported by research subagents for the others; pages carrying their own "may be outdated for 4.7" notice are flagged. Documentation only: nothing here was run in the engine, so behaviour claims are *documented*, not *experimentally validated*. Re-fetch before promoting dependent notes to `verified`.

- **Buses:** any number of buses with any number of effects applied in order; routing always goes to a bus on the left; layout saves to `res://default_bus_layout.tres` by default; a bus silent for a few seconds is disabled automatically; keep the Master mix below 0 dB. Pitfalls: **renaming a bus breaks references (players then play on Master)**, rearranging is safe (references are by name); on web export effects do not work with the default Sample playback mode (use Stream, which adds latency without threads). Mute/solo not covered.
- **AudioStreamInteractive:** combines clips with a transition table (source/destination clips, `CLIP_ANY`, when the transition starts — immediately, next beat, next bar or clip end — where the new clip starts, fade mode and length in beats, optional filler clip); add clips before transitions; `TRANSITION_TO_TIME_SAME_POSITION` works best when both clips have the same length; a looping clip ignores auto-advance; assignable to AudioStreamPlayer, 2D or 3D. **AudioStreamPlaylist:** plays sub-streams in order, up to 64, with `loop` (default true), `shuffle`, `fade_time` (default 0.3); streams need a little extra audio after their end for fading. AudioStreamSynchronized unread.
- **AudioStreamPlayer3D:** attenuation models; enable doppler tracking on both the player and the camera/listener; `max_distance` (linear, saves CPU), `panning_strength`; the `bus` property does not validate the name (an unresolved bus falls back to Master).
- **Sync:** `get_playback_position()` advances in chunks; add `AudioServer.get_time_since_last_mix()` and subtract output latency (page may not be fully updated for 4.7).

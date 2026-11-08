---
id: src-gs-audio-import-and-tools
type: source
domain: game-studio
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_audio_samples.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_audio_samples.html"
    - "https://manual.audacityteam.org/man/scripting.html"
    - "https://manual.ardour.org/lua-scripting/"
    - "https://stability.ai/news-updates/meet-stable-audio-3-the-model-family-built-for-artistic-experimentation-with-open-weight-models"
  title: "Godot audio import; Audacity scripting; Ardour Lua; Stable Audio 3"
  retrieved: 2026-11-08
  version: "Godot stable docs, 2026-11-08"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- Godot imports WAV, Ogg Vorbis, MP3. WAV: cheap to play, large, loop modes Detect/Forward/Ping-Pong/Backward with sample loop points, recommended for short SFX. Ogg: smallest, highest CPU cost, recommended for music/long audio. MP3: less CPU than Ogg. Ogg/MP3 support only loop start offset and forward looping. Loop on means `finished` never fires. Effects better via audio buses at runtime.
- Audacity: `mod-script-pipe` documented, ships disabled by default (Preferences > Modules), drives a running GUI instance (not headless); manual warns any program able to open the pipe can control Audacity; community reports brittleness.
- Ardour: headless Lua via `luasession`, `ardour8-lua`, `ardour8-export` (Debian/Ubuntu man pages), Dummy backend `simple_export()`; per-track stem export reportedly GUI-only (older forum); needs existing session; license `unverified`.
- Stable Audio: Open 1.0 under Stability Community License (non-commercial or <US$1M revenue). Stable Audio 3.0 (May 2026): Small SFX/Small/Medium open weights under same license, Large not open-weight (the-decoder.com, secondary); T5Gemma/Gemma terms claim `unverified`; MusicGen/AudioCraft weights reportedly CC-BY-NC (memory, `unverified`).

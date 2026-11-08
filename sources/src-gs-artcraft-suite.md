---
id: src-gs-artcraft-suite
type: source
domain: game-studio
source:
  url: "https://github.com/storytold"
  urls:
    - "https://github.com/storytold"
    - "https://getartcraft.com/apps"
    - "https://github.com/storytold/photocraft"
    - "https://github.com/storytold/texturecraft"
    - "https://github.com/storytold/materialcraft"
    - "https://github.com/storytold/figcraft"
    - "https://github.com/storytold/soundcraft"
  title: "ArtCraft / Crafting Apps org, site, and per-app READMEs"
  retrieved: 2026-11-08
  version: "apps shipped ~Oct 2026; launcher v0.15.0 per apps page"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- Org `storytold`: `artcraft` ("crafting engine for artists, designers, filmmakers"; README NOT read — AI backend dependency `unverified`) and separate Rust "Crafting Apps". getartcraft.com/apps lists 16 apps; early alpha: PhotoCraft, PdfCraft, FigCraft, Craft Anything; rest "In development".
- Licenses: MIT OR Apache-2.0 at user's option (verified in READMEs of PhotoCraft, TextureCraft, MaterialCraft, FigCraft, SoundCraft); ArtCraft name/logo excluded, forks must remove them; bundled assets have own licenses. No models/hosted services in these desktop apps. VectorCraft/EffectCraft: org listing only (Apache-2.0), READMEs unopened.
- Each README claims one command registry feeding UI, CLI, JSON control channel, MCP; docs `docs/control-protocol.md`. Platforms claimed: Win, macOS, Linux, FreeBSD, WASM.
- PhotoCraft: early alpha; `photocraft-cli`, headless `batch`, `--control` loopback authenticated, `mcp` subcommand; PSD/PSB/OpenRaster/PNG/TGA/QOI/EXR.
- TextureCraft: in development, self-estimate "~93% of daily texture-artist workflow"; `new/render/export/mcp`; `--control 7878`; MCP stdio with read/write roots; in glTF/GLB/FBX/USD/OBJ, out PNG/TGA/EXR 8/16/32-bit + UDIM; no Godot mention (only "common engines" presets).
- MaterialCraft: in development; `new/render/export/run`, `--set`, `--control 7878`, `mcp`, `--bridge`; outputs base color/normal/roughness/metallic/height/AO; SBS save/load is current focus.
- FigCraft: early alpha, "~49%"; `figcraft-cli`; `--control`; `mcp [--attach]`; 400+ commands; SVG/PNG/JPG/WebP/PDF; `.fig` best-effort; Figma interoperability `unverified`.
- SoundCraft: pre-alpha, "~40%"; `soundcraft-cli` headless bounce with LUFS report; `--control 7801`; `mcp`; WAV/AIFF/FLAC in+out, MP3/Ogg/AAC in only (cannot write Ogg/MP3); CLAP/VST3.
- Maturity evidence is only the READMEs' self-estimates; nothing was run. Star counts (PhotoCraft 78k, FigCraft 4.7k, SoundCraft 4.2k, TextureCraft 544, MaterialCraft 300) are anomalous for a ~5-week-old project — popularity `unverified`. Secondary source (jacar.es) claims creation Sept 30–Oct 7 2026 and heavy AI-agent authorship — `unverified`.

---
id: game-studio-2d-ui-audio-materials
type: reference
domain: game-studio
status: proposed
summary: "Preliminary stacks for materials, 2D art, UI design-to-Godot and audio: documented automation of Material Maker, Krita, Inkscape, Penpot, audio tools, and Godot audio import rules."
sources:
  - claim: "Second-pass confirmation of tool licences (Pixelorama, LibreSprite, ffmpeg, sox, Krita, Inkscape, Ardour)"
    ref: src-gs-free-tool-licenses
    retrieved: 2026-11-08
  - claim: "Material Maker, Krita, Inkscape, Penpot, ArmorPaint, Pixelorama, Aseprite facts"
    ref: src-gs-2d-ui-tools
    retrieved: 2026-11-08
  - claim: "Godot audio formats/looping; Audacity, Ardour, Stable Audio facts"
    ref: src-gs-audio-import-and-tools
    retrieved: 2026-11-08
  - claim: "ArtCraft apps as alternatives"
    ref: src-gs-artcraft-suite
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-tool-matrix]]"   # ratings
  - relates-to: "[[game-studio-artcraft-evaluation]]"   # experimental alternatives
  - relates-to: "[[gs-adr-godot-final-ui-authority]]"   # UI authority decision
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Everything here is a *proposal* pending human review.


## Materials (PBR)
- **Material Maker** (MIT): documented CLI `--export-material --target <blender|godot|unity|unreal> -o <out> <.ptex files>`. Godot output files and headless-on-Linux behaviour are `unverified`. Preliminary **Primary**.
- Blender procedural/baking: baseline, not researched in depth here (see [[game-studio-blender-pipeline]]).
- MaterialCraft/TextureCraft: agent-friendly interfaces, pre-1.0 → Experimental. ArmorPaint: no documented CLI/scripting, paid binaries → not recommended for agents.

## 2D art (pixel and non-pixel)
- **Krita**: `krita in --export --export-filename out.png` documented; Python API exists but headless scripting `unverified`. **Inkscape**: `--export-type`, `-o`, `--export-id`, `--actions` (via man-page mirrors). Both Primary for export/conversion.
- Pixel art: Pixelorama is MIT (D), exports PNG/APNG/spritesheet/GIF/video and claims command-line scripted export for bulk work (syntax not read) — a libre-open candidate, automation unverified; Aseprite `--batch --sheet … --data …` is documented but proprietary (reference only); LibreSprite is GPL-2.0 (a fork of the last GPLv2 Aseprite, no documented CLI, scripting docs unread). Since the project targets 2D *and* 3D, a pixel-art authoring decision remains open.
- PhotoCraft/VectorCraft: Experimental.

## UI/UX
Godot Control nodes + Theme resources are authored directly as text (`.tscn`/`.tres`) and are the **final authority**. Penpot (MPL-2.0, REST/plugins, self-hostable) is an optional design-spec source; its official MCP bridges to a **browser plugin**, so it is awkward for CI. Godot Theme docs were not fetched (`unverified`). FigCraft Experimental.

## Audio
- Godot imports WAV, Ogg Vorbis, MP3. Short SFX → WAV (cheap CPU, large); music/long → Ogg (smallest, highest CPU); MP3 less CPU than Ogg. Ogg/MP3 loop only forward with a start offset; WAV supports loop modes and sample loop points. Effects belong on audio buses at runtime.
- ffmpeg/sox are the expected batch route (WAV→Ogg, loudness, trimming); their CLI behaviour was **not researched** (gap), but licences are confirmed: ffmpeg LGPL 2.1+ by default (GPL if optional parts are enabled — record the build configuration), sox GPLv2/LGPLv2 with low maintenance. Ardour headless Lua is possible but needs a session; Audacity's pipe needs a live GUI and is brittle (not recommended). SoundCraft cannot write Ogg/MP3.
- AI audio: Stable Audio open weights fall under the Stability Community Licence (not OSI); AudioCraft/MusicGen reportedly non-commercial (`unverified`).

## Existing assets first
For icons, sprites, textures and audio, check [[game-studio-asset-source-catalog]] before creating or generating.

## See also
- [[game-studio-artcraft-evaluation]] — ArtCraft per app

---
id: game-studio-artcraft-evaluation
type: reference
domain: game-studio
status: proposed
summary: "Per-app evaluation of ArtCraft Crafting Apps (PhotoCraft, TextureCraft, MaterialCraft, FigCraft, SoundCraft, VectorCraft, EffectCraft): what exists, licences, claimed automation, maturity."
sources:
  - claim: "ArtCraft org, per-app READMEs, licences, CLI/JSON/MCP claims, self-reported maturity, anomalies"
    ref: src-gs-artcraft-suite
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-tool-matrix]]"   # comparison with alternatives
  - relates-to: "[[gs-adr-artcraft-role]]"   # decision derived from this
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Everything here is a *proposal* pending human review.


## What was established
ArtCraft's org (`storytold`) hosts `artcraft` (a "crafting engine"; README **not read**) plus separate Rust "Crafting Apps". All seven named apps appear on getartcraft.com/apps; PhotoCraft/FigCraft are early alpha, the rest "in development". Licence: MIT OR Apache-2.0 (verified in five READMEs), name/logo excluded. No models or hosted services in these desktop apps.

## Per-app view (each evaluated independently)
| App | Claimed interfaces | Maturity evidence | Godot-relevant output | Gap |
|---|---|---|---|---|
| TextureCraft | CLI, `--control` JSON, MCP (read/write roots) | self-estimate "~93%", no signed release | PNG/TGA/EXR 8/16/32-bit, UDIM, GLB/OBJ/USD mesh out | no Godot mention, only "common engines" presets |
| MaterialCraft | CLI (`--set`), JSON, MCP, bridge | in development, parity pending | PBR map set as PNG/TGA/EXR | no Godot-specific export |
| PhotoCraft | CLI batch, JSON, MCP | early alpha | PNG/TGA/QOI/EXR/PSD | "not yet a Photoshop replacement" |
| FigCraft | CLI, JSON, MCP, 400+ commands | early alpha, "~49%" | SVG/PNG/PDF; `.fig` best-effort | Figma interop unverified |
| SoundCraft | CLI headless bounce (LUFS), JSON, MCP | pre-alpha, "~40%" | WAV/AIFF/FLAC out | **cannot write Ogg/MP3** |
| VectorCraft, EffectCraft | `unverified` | README not opened | `unverified` | research gap |

## Cautions
- Maturity evidence is the READMEs' own estimates; nothing was run. The project is about five weeks old (secondary source) and star counts are anomalous — popularity is `unverified`.
- Fast release cadence implies likely breaking CLI changes. Large command registries may bloat agent context.
- "Clean-room" and AI-authorship claims are unaudited secondary/own claims.

## Preliminary conclusion
Interface design (one registry → CLI/JSON/MCP) is the most agent-friendly seen, but production readiness is not demonstrated. Rate **Experimental** per app; revisit after a real end-to-end test and releases with tags.

## See also
- [[game-studio-tool-matrix]] — alternatives (Material Maker, Krita, Inkscape, ffmpeg)

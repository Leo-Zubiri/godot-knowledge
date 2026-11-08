---
id: game-studio-architecture-proposal
type: reference
domain: game-studio
status: proposed
summary: Decision document: smallest reliable toolchain for agent-driven 2D+3D Godot game production, departments, preliminary classes, roadmap and open gaps.
sources:
  - claim: "Godot, Blender, ComfyUI, ArtCraft and tooling evidence is preserved in the game-studio sources (see linked notes)"
    ref: src-gs-godot-cli
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-tool-matrix]]"   # detailed ratings
  - relates-to: "[[game-studio-workflows]]"   # designed workflows
  - relates-to: "[[game-studio-index]]"   # entry point
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Everything here is a *proposal* pending human review.


## Central question
What is the smallest reliable toolchain that lets AI agents produce a complete Godot game (2D and 3D) with reproducible results and reasonable human supervision?

## Executive summary (preliminary)
- **Core:** Godot 4.7.x CLI/headless + gdUnit4; AGENTS.md + standard skills + shell/Makefile adapters.
- **3D:** Blender 5.2 LTS via headless bpy scripts, GLB export, Godot import hints ([[gs-adr-blender-primary-3d]]).
- **2D/materials/UI/audio:** Krita + Inkscape (export), Material Maker (batch PBR), Godot Theme/Control for UI, ffmpeg/sox for audio (needs research).
- **Optional:** ComfyUI for concepts, Penpot for UI specs, a pinned Godot runtime MCP server for screenshot/input.
- **Out for now:** ArtCraft apps (Experimental), Mixar, ArmorPaint, Audacity, extra orchestrators, generative 3D in production.
- **MCP** is optional ([[gs-adr-mcp-optional]]); no experiment has validated any workflow.

## Departments → proposals
See [[game-studio-tool-matrix]]. Detail notes: [[game-studio-godot-integration]], [[game-studio-blender-pipeline]], [[game-studio-2d-ui-audio-materials]], [[game-studio-level-design]], [[game-studio-ai-generation]], [[game-studio-artcraft-evaluation]], [[game-studio-agent-orchestration]], [[game-studio-skills-architecture]], [[game-studio-asset-conventions]], [[game-studio-acceptance-criteria]], [[game-studio-workflows]], [[game-studio-licensing-risks]], [[game-studio-hardware-and-cost]].

## Reference architecture study
Claude-Code-Game-Studios was studied for patterns only (not adopted, not a dependency): see [[game-studio-ccgs-reference-comparison]]. Adopted-in-principle (proposal): default-minimal rigor, solo/lean/full review with "not assessed ≠ pass", deny-list safety, checkpoint-file session memory, rendered-capture visual evidence. Rejected: large role roster, 30-document default flow.

## Blender vs ArtCraft (summary)
Blender: mature LTS, documented Python API/CLI, but no verified agent-readiness. ArtCraft: purpose-built agent interfaces (CLI/JSON/MCP per README) but weeks old and self-described incomplete; TextureCraft/MaterialCraft lack Godot-specific export. Blender stays central; ArtCraft is evaluated per app ([[gs-adr-artcraft-role]]).

## Adoption roadmap (proposal, by priority; each step needs its own authorization)
1. Pin versions; define project standards and manifest schema.
2. Authorized smoke test: Godot headless import/check-only/gdUnit4 and screenshot options (Xvfb / `--write-movie`).
3. Authorized Blender bpy → GLB → Godot character/prop slice, with measurements (tokens, time, retries).
4. Materials (Material Maker `--target godot`) and 2D (Krita/Inkscape) slices; research ffmpeg/sox.
5. UI and audio slices; optional ComfyUI/Penpot.
6. Vertical slice (2D + 3D). Then re-evaluate ArtCraft apps.

## Open gaps
Xvfb/`--write-movie` screenshots; glTF exporter options and Blender headless limits; official licences for Krita/Inkscape/ffmpeg/sox/FLUX; VectorCraft/EffectCraft/`artcraft` READMEs; ffmpeg/sox/LMMS/Hydrogen/LibreSprite; pixel-art authoring choice; all measured costs.

## See also
- [[game-studio-index]] — all game-studio notes

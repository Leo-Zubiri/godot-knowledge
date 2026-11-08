---
id: game-studio-cost-and-openness-classification
type: reference
domain: game-studio
status: proposed
summary: "Free/libre/open-source-first classification of the studio's tools, models and asset sources: libre-open, gratis-restricted, and paid/closed, with the distinctions agents must keep."
sources:
  - claim: "Godot licence page, Asset Library and Godot Shaders"
    ref: src-gs-free-godot-ecosystem
    retrieved: 2026-11-08
  - claim: "Second-pass licence confirmation of open-source tools and Godot ecosystem"
    ref: src-gs-free-tool-licenses
    retrieved: 2026-11-08
  - claim: "Tool licences and automation facts (Godot MCP servers, gdUnit4/GUT, Blender, ComfyUI)"
    ref: src-gs-godot-mcp-servers
    retrieved: 2026-11-08
  - claim: "Blender and bpy licence"
    ref: src-gs-blender-releases-bpy
    retrieved: 2026-11-08
  - claim: "ComfyUI GPL-3.0, paid partner/API nodes"
    ref: src-gs-comfyui-core
    retrieved: 2026-11-08
  - claim: "Model licences: Apache-2.0, MIT, community licences with revenue caps, non-commercial"
    ref: src-gs-image-model-licenses
    retrieved: 2026-11-08
  - claim: "3D model licences and VRAM"
    ref: src-gs-sf3d-trellis
    retrieved: 2026-11-08
  - claim: "Hunyuan3D territory and MAU limits"
    ref: src-gs-hunyuan3d-license
    retrieved: 2026-11-08
  - claim: "ArtCraft apps MIT OR Apache-2.0; Mixar closed hosted backend"
    ref: src-gs-artcraft-suite
    retrieved: 2026-11-08
  - claim: "Mixar GPL code with closed backend and credits"
    ref: src-gs-mixar
    retrieved: 2026-11-08
  - claim: "Material Maker MIT; ArmorPaint paid binaries; Aseprite proprietary; Penpot MPL-2.0"
    ref: src-gs-2d-ui-tools
    retrieved: 2026-11-08
  - claim: "Asset provider licences (CC0, custom, paid marketplaces)"
    ref: src-gs-asset-marketplaces
    retrieved: 2026-11-08
  - claim: "Kenney CC0; Quaternius custom licence"
    ref: src-gs-asset-packs-3d-2d
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-godot-ecosystem-free-resources]]"   # Godot-ecosystem libre resources
  - relates-to: "[[gs-adr-free-and-open-source-first]]"   # decision this classification supports
  - relates-to: "[[game-studio-licensing-risks]]"   # licence detail
  - relates-to: "[[game-studio-tool-matrix]]"   # tool ratings
  - relates-to: "[[game-studio-asset-source-catalog]]"   # asset providers
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** classification derived only from already-preserved sources (2026-11-08, paraphrased extractions); no new research. `unverified` = licence or price not confirmed on an official page. Open-weight is not open-source; free to download is not free to use commercially. Not legal advice; proposals pending human review.


## Three tiers (keep separate)
| Tier | Meaning | Examples (from preserved sources) |
|---|---|---|
| **libre-open** (plus verified: Krita, Inkscape, Ardour, Audacity, LMMS, Hydrogen, ffmpeg-LGPL, gdtoolkit, Pixelorama, LibreSprite, Godot Shaders CC0/MIT, Asset Library addons per licence label, Google Fonts OFL, MIT/Apache icon sets) | open-source or public-domain licence, usable commercially, no payment | Godot (MIT, `unverified` page), Blender (GPL), ComfyUI (GPL-3.0), gdUnit4/GUT (MIT), Material Maker (MIT), Penpot (MPL-2.0), ArtCraft apps (MIT OR Apache-2.0, immature), TRELLIS (MIT code and model), FLUX.1 schnell and Qwen-Image weights (Apache-2.0), CC0 assets (Kenney, Poly Haven, ambientCG, TextureCan), MIT/ISC icons (Lucide, Phosphor, Tabler) |
| **gratis-restricted** | free to obtain but custom or capped terms | Quaternius (QAL), Sonniss, Pixabay, Freesound per-sound CC BY/BY-NC, Stable Fast 3D / SD 3.5 (US$1M revenue cap), Hunyuan3D (territory and MAU limits), FLUX dev (non-commercial), Stable Audio open weights (community licence), BlenderKit Royalty Free |
| **paid / closed** | payment, credits, or closed service needed | Aseprite (proprietary), ArmorPaint prebuilt binaries (free if built from source), paid Fab/itch.io packs, ComfyUI partner/API nodes, Mixar's hosted backend (account + credits), incompetech paid licence |

## Distinctions agents must keep
- **Open-source application ≠ open weights ≠ open content.** Weights with revenue caps, territory limits or non-commercial clauses are free but not libre.
- **Free to download ≠ commercially usable** (NC, per-asset licences) and **≠ redistributable** (see [[game-studio-asset-license-and-provenance-policy]]).
- **Libre code may still call paid services** (ComfyUI partner nodes).
- **Self-hostable** (Penpot, ComfyUI) is not the same as hosted-free.
- **Tool licences confirmed on official pages (second pass):** Krita GPL-3.0; Inkscape GPL v2+ source / v3+ binaries; Ardour GPL-2 (plugins loaded via VST/LV2/CLAP not bound by it); Audacity GPLv3; LMMS GPL-2.0; Hydrogen GPLv2+; ffmpeg LGPL 2.1+ by default (becomes GPL if optional parts are enabled — record the build configuration); sox GPLv2/LGPLv2 (low maintenance); gdtoolkit MIT; Pixelorama MIT; LibreSprite GPL-2.0 (frozen at an old Aseprite fork point); ArmorPaint zlib (binaries paid); Aseprite is **not** libre (EULA forbids distributing builds). Libre-open does not remove obligations: GPL/LGPL terms matter if a tool is *redistributed*; using a tool to produce assets is a separate question for human review.
- Godot's MIT licence does not cover your game's content, but shipping the engine requires including its notice ([[game-studio-godot-ecosystem-free-resources]]).

## Use
When two options satisfy the requirement, prefer the more libre-open tier; use gratis-restricted only after the licence check; use paid/closed only as a justified exception ([[gs-adr-free-and-open-source-first]]). Costs in tokens, API fees and time remain *not measured*.

## See also
- [[game-studio-asset-source-catalog]] — asset providers by licence scope

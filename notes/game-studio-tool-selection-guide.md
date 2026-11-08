---
id: game-studio-tool-selection-guide
type: guide
domain: game-studio
status: proposed
summary: Task-to-tool routing for agents — for each game-dev task (2D/3D art, materials, UI, audio, levels, VFX, testing, generation) the preliminary default tool, how to drive it, what to avoid, and which note to read next.
aliases: [what tool to use, tool routing, which tool for, agent tool selection]
sources:
  - claim: "Godot CLI mechanisms (import, check-only, export, headless)"
    ref: src-gs-godot-cli
    retrieved: 2026-11-08
  - claim: "Blender CLI pattern and MCP caveats"
    ref: src-gs-blender-mcp
    retrieved: 2026-11-08
  - claim: "Material Maker, Krita, Inkscape, Penpot automation facts"
    ref: src-gs-2d-ui-tools
    retrieved: 2026-11-08
  - claim: "Godot audio import rules; Audacity/Ardour limits"
    ref: src-gs-audio-import-and-tools
    retrieved: 2026-11-08
  - claim: "Test runner CLIs"
    ref: src-gs-gut-gdunit4
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-tool-matrix]]"   # ratings and evidence behind each default
  - relates-to: "[[game-studio-architecture-proposal]]"   # overall decision document
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** preliminary routing from documentary research (2026-11-08); nothing was executed. Defaults are *proposals*, not approved standards. `?` = unverified, see the linked note before relying on it.

## Goal
Pick the right tool and interface for a task without re-researching. Rule of thumb: **CLI/script first → native API → MCP only if it adds value → GUI last**; Godot is the final authority; every output must pass [[game-studio-acceptance-criteria]].

## Routing table
| Task | Default (preliminary) | Drive it with | Avoid / caveat | Read next |
|---|---|---|---|---|
| Gameplay code, scenes, resources, physics, UI implementation | Godot 4.7.x (GDScript, `.tscn/.tres`) | `godot --headless --script <f> --check-only`; `--import`; text edits | none | [[game-studio-godot-integration]], [[godot-index]] |
| Run tests | gdUnit4 (GUT fallback) | `runtest.sh`, JUnit/HTML; exit 0/100/101 | pin to Godot minor version | [[game-studio-godot-integration]] |
| Export/build | Godot export presets | `--export-release|--export-debug` | templates in CI not documented | [[game-studio-godot-integration]] |
| Screenshot / see running game | Xvfb run or `--write-movie` (both `?`), or pinned Erodenn runtime MCP | needs authorized smoke test | `--headless` cannot render | [[game-studio-godot-integration]] |
| 3D model, rig, animation, UV, LOD | Blender 5.2 LTS | `blender --background --factory-startup --python script.py` → GLB | Blender MCP = exploration only; Mixar no | [[game-studio-blender-pipeline]] |
| Collision / navmesh / occluders from 3D | Blender name suffixes `-col -convcol -navmesh -occ` | GLB import in Godot | headless navmesh bake `?` | [[game-studio-level-design]] |
| Humanoid animation retarget | Godot BoneMap + SkeletonProfileHumanoid | import settings | Rigify naming `?` | [[game-studio-blender-pipeline]] |
| PBR material / textures (batch) | Material Maker | `--export-material --target godot` (output `?`) | ArmorPaint (no CLI); ArtCraft apps experimental | [[game-studio-2d-ui-audio-materials]] |
| Texture painting / bake | Blender | bpy bake (Cycles) | headless limits `?` | [[game-studio-blender-pipeline]] |
| Raster 2D art / sprite export | Krita | `krita in --export` | Python headless `?` | [[game-studio-2d-ui-audio-materials]] |
| Vector / SVG / icons | Inkscape | `--export-type`, `--actions` | — | [[game-studio-2d-ui-audio-materials]] |
| Pixel art | open decision | Aseprite CLI documented but proprietary; Pixelorama no CLI | LibreSprite not researched | [[game-studio-2d-ui-audio-materials]] |
| UI design spec | Godot Theme/Control directly; Penpot optional | text `.tscn/.tres` | Penpot MCP needs browser; Godot stays authority | [[gs-adr-godot-final-ui-authority]] |
| 2D tilemap levels | Godot TileMap; Tiled/LDtk only if needed | Tiled Godot export / LDtk importer | not for 3D | [[game-studio-level-design]] |
| 3D levels | Blender modular kit → GLB → Godot scene | as above | — | [[game-studio-level-design]] |
| VFX (real time) | Godot particles/shaders | text resources | needs human visual check | [[game-studio-workflows]] |
| Audio convert/loop/loudness | ffmpeg / sox (research gap) | CLI | Audacity pipe no; SoundCraft can't write Ogg/MP3 | [[game-studio-2d-ui-audio-materials]] |
| Audio format choice | WAV short SFX, Ogg music | Godot import settings | Ogg/MP3 loop only forward | [[game-studio-acceptance-criteria]] |
| Concept art / reference images | ComfyUI + Apache-2.0 image models | HTTP API script | check licence per model | [[game-studio-ai-generation]] |
| Image→3D prototype | TRELLIS / SF3D / Hunyuan (all Experimental) | Python/CLI | licence + VRAM limits; never ship uncleaned | [[game-studio-ai-generation]], [[game-studio-licensing-risks]] |
| Find an existing asset instead of making one | provider catalog + licence check | [[game-studio-asset-discovery-and-reuse-workflow]]; human login for most downloads | NC/unknown licences; committing non-CC0 originals; scraping | [[game-studio-asset-source-catalog]], [[game-studio-asset-license-and-provenance-policy]] |
| Share skills across Claude/Codex/OpenCode | AGENTS.md + standard SKILL.md | symlink/copy | hooks/fork not portable | [[game-studio-agent-orchestration]] |
| Asset metadata/validation records | manifest + validation report | JSON files | — | [[game-studio-asset-conventions]] |

## Steps for an agent
1. Find the row; read the linked note's summary, then only the relevant section.
2. Work in an isolated workspace with explicit asset directories.
3. Use the CLI/script path; save any exploratory MCP/GUI result as a script.
4. Produce a manifest and run the validation gates; route failures back.
5. Escalate to a human for visual/animation quality, licence and provenance.

## Notes & pitfalls
- A tool listed here is not proven agent-ready; flags are in [[game-studio-tool-matrix]].
- Real workflows are `designed` only ([[game-studio-workflows]]).

## See also
- [[game-studio-index]] — all game-studio notes

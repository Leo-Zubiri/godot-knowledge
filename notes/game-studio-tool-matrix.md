---
id: game-studio-tool-matrix
type: reference
domain: game-studio
status: proposed
summary: Preliminary per-department comparison of candidate tools with licence, CLI/API/MCP/headless status, readiness flags and recommendation class.
sources:
  - claim: "Godot CLI flags and headless behaviour"
    ref: src-gs-godot-cli
    retrieved: 2026-11-08
  - claim: "gdUnit4/GUT CLI, reports and versions"
    ref: src-gs-gut-gdunit4
    retrieved: 2026-11-08
  - claim: "Godot MCP servers: licence, editor requirement, runtime tools"
    ref: src-gs-godot-mcp-servers
    retrieved: 2026-11-08
  - claim: "Blender 5.2 LTS and pip bpy constraints"
    ref: src-gs-blender-releases-bpy
    retrieved: 2026-11-08
  - claim: "Blender MCP options (official and community)"
    ref: src-gs-blender-mcp
    retrieved: 2026-11-08
  - claim: "Mixar is a Blender fork with a closed hosted AI backend"
    ref: src-gs-mixar
    retrieved: 2026-11-08
  - claim: "ComfyUI HTTP/WebSocket API, GPL-3.0, Manager risks"
    ref: src-gs-comfyui-core
    retrieved: 2026-11-08
  - claim: "ComfyUI MCP servers"
    ref: src-gs-comfyui-mcp
    retrieved: 2026-11-08
  - claim: "ArtCraft apps: per-app CLI/JSON/MCP claims and self-reported maturity"
    ref: src-gs-artcraft-suite
    retrieved: 2026-11-08
  - claim: "Material Maker, Krita, Inkscape, Penpot, ArmorPaint automation facts"
    ref: src-gs-2d-ui-tools
    retrieved: 2026-11-08
  - claim: "Audacity, Ardour, Stable Audio facts"
    ref: src-gs-audio-import-and-tools
    retrieved: 2026-11-08
  - claim: "Importer/Tiled facts"
    ref: src-gs-level-2d-tools
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-readiness-classification]]"   # defines the flags used here
  - relates-to: "[[game-studio-licensing-risks]]"   # licence detail per tool
  - relates-to: "[[game-studio-hardware-and-cost]]"   # hardware detail per tool
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Ratings are *preliminary recommendations*, not approved standards.


Legend — flags: **A**vailable / **D**ocumented / **R**eady (agent-ready) / **P**roduction-ready. `y` yes · `p` partial · `n` no · `?` unverified. "Class" = preliminary recommendation.

## Orchestration, Godot, QA
| Tool | Licence (code) | CLI / headless | MCP | A/D/R/P | Class |
|---|---|---|---|---|---|
| Godot 4.7.x | MIT (`?`) | yes; `--headless`, `--import`, `--export-*`, `--script --check-only` | via third-party servers | y/y/p/y(engine) | Primary |
| gdUnit4 | MIT | yes; JUnit + HTML; exit 0/100/101 | n/a | y/y/y/? | Primary |
| GUT | MIT | yes; JUnit; exit 0/1 | n/a | y/y/p/? | Complementary |
| gdtoolkit (gdlint/gdformat) | MIT | yes | n/a | y/y/?/? (4.7 syntax `?`) | Complementary |
| Erodenn/godot-mcp-runtime | MIT | headless editing, screenshot, input | itself | y/y/y on paper/? | Complementary (preliminary) |
| hi-godot/godot-ai | MIT | needs live editor | itself | y/y/y on paper/? | Experimental |
| Coding-Solo/godot-mcp | MIT | console output only for runtime | itself | y/p/p/? | Experimental |
| ZemDen Godot AI Workbench | Apache-2.0 | needs editor; Windows-oriented | itself | y/p/?/n | Not recommended (for now) |

## 3D, animation, levels
| Tool | Licence | CLI / headless | MCP | A/D/R/P | Class |
|---|---|---|---|---|---|
| Blender 5.2 LTS (bpy) | GPL | `--background --python`; pip `bpy` (Py 3.13) | see below | y/y/p/y | Primary |
| Blender Lab MCP | `?` | not mentioned | yes | y/p/interactive only/n | Experimental |
| ahujasid blender-mcp | MIT | needs GUI | yes | y/p/interactive only/n | Experimental |
| Mixar | GPL code, closed backend | partial | `?` | y/p/?/n | Not recommended |
| Godot import hints + BoneMap | (Godot) | built in | n/a | y/y/y/y | Primary |
| Tiled | `?` | built-in Godot export | n/a | y/y/?/? | Complementary (2D tile games only) |
| LDtk + godot-ldtk-importer | importer MIT | `?` | n/a | y/y/?/? | Experimental (2D tile games only) |

## Materials, 2D, UI, audio
| Tool | Licence | CLI / headless | MCP | A/D/R/P | Class |
|---|---|---|---|---|---|
| Material Maker | MIT | `--export-material --target godot` | none found | y/p/y(batch)/probable | Primary (preliminary) |
| MaterialCraft, TextureCraft | MIT OR Apache-2.0 | CLI + JSON control (README) | yes | y/y/plausible/n | Experimental |
| ArmorPaint | `?` (paid binaries) | not documented | none | n/n/n/? | Not recommended |
| Krita | `?` | `krita in --export` | none found | CLI y; Python needs GUI | Primary (export path) |
| Inkscape | `?` | `--export-type`, `--actions` | none found | y/y/y/y | Primary |
| PhotoCraft / VectorCraft | MIT OR Apache-2.0 | README / unverified | yes / `?` | y/y/plausible/n | Experimental |
| Penpot | MPL-2.0 | REST, plugins | official MCP needs browser plugin | y/p/experimental/y | Complementary |
| FigCraft | MIT OR Apache-2.0 | CLI + JSON | yes | y/y/plausible/n | Experimental |
| ffmpeg, sox | `?` (not researched) | yes (general knowledge, `?`) | no | `?` | Primary (preliminary, needs research) |
| Ardour (Lua) | `?` | headless Lua, needs session | no | y/y/p/? | Complementary |
| SoundCraft | MIT OR Apache-2.0 | CLI, headless bounce | yes | y/y/plausible/n | Experimental |
| Audacity pipe | `?` | live GUI only | no | y/y/n/n/a | Not recommended |
| Pixelorama | — | no documented CLI | no | n | Not recommended (automation) |
| Aseprite | proprietary EULA | `--batch` | third-party | y/y/?/? | Reference only |

## AI generation
| Tool | Licence | Interface | A/D/R/P | Class |
|---|---|---|---|---|
| ComfyUI | GPL-3.0 | HTTP + WebSocket server | y/y/p/? | Complementary |
| comfy-mcp (Comfy-Org) | AGPL-3.0+ or Commercial | MCP, Beta | y/p/?/n | Experimental |
| joenorton/comfyui-mcp-server | Apache-2.0 | MCP | y/p/?/n | Experimental |
| TRELLIS, TRELLIS.2 | MIT (deps differ) | Python | y/?/?/n | Experimental |
| Stable Fast 3D | Stability Community | CLI script | y/y/?/n | Experimental (revenue cap) |
| Hunyuan3D-2.1 | Tencent community | Python/Gradio (`?`) | y/?/?/n | Experimental (territory/MAU limits) |

## Cost and openness
A free/libre/open-source-first reading of this matrix (tiers libre-open / gratis-restricted / paid-closed) is in [[game-studio-cost-and-openness-classification]], following [[gs-adr-free-and-open-source-first]]. Notably paid/closed or credit-based: Mixar backend, Aseprite, ArmorPaint prebuilt binaries, ComfyUI partner/API nodes.

## Caveats
- No tool was run; "agent-ready" is not demonstrated anywhere. ArtCraft readiness comes only from each README's own claims.
- `?` entries need re-fetching before human verification (see each source note).

## See also
- [[game-studio-readiness-classification]] — meaning of the flags
- [[game-studio-licensing-risks]] — licence axes in detail

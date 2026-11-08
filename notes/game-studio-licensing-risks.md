---
id: game-studio-licensing-risks
type: reference
domain: game-studio
status: proposed
summary: Licensing and commercial-use risks per tool, keeping application code, open-weight models and hosted services separate.
sources:
  - claim: "Hunyuan3D-2.1 territory, MAU, output-use and disclosure terms"
    ref: src-gs-hunyuan3d-license
    retrieved: 2026-11-08
  - claim: "Stable Fast 3D revenue cap and attribution; TRELLIS MIT with separate dependency terms"
    ref: src-gs-sf3d-trellis
    retrieved: 2026-11-08
  - claim: "FLUX, Qwen-Image, SD 3.5 licence terms"
    ref: src-gs-image-model-licenses
    retrieved: 2026-11-08
  - claim: "ComfyUI GPL-3.0 code; partner/API nodes are paid proprietary calls"
    ref: src-gs-comfyui-core
    retrieved: 2026-11-08
  - claim: "ArtCraft apps MIT OR Apache-2.0 with trademark exclusion"
    ref: src-gs-artcraft-suite
    retrieved: 2026-11-08
  - claim: "Mixar GPL code with closed hosted backend"
    ref: src-gs-mixar
    retrieved: 2026-11-08
  - claim: "Blender/bpy GPL and legal-check caveat"
    ref: src-gs-blender-releases-bpy
    retrieved: 2026-11-08
  - claim: "Stable Audio weights and AudioCraft licence caveats"
    ref: src-gs-audio-import-and-tools
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-tool-matrix]]"   # tools these risks attach to
  - relates-to: "[[game-studio-ai-generation]]"   # models these risks attach to
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Ratings are *preliminary recommendations*, not approved standards.


Not legal advice. Three axes are never merged: **application code**, **model weights**, **hosted services**.

## Application code
- Blender and `bpy`: GPL (bpy wheel GPL-3.0). Whether scripts/tools you *distribute* with `bpy` become GPL-affected needs a legal check; outputs of Blender are generally not GPL-bound (prior knowledge, `unverified` here).
- ComfyUI and ComfyUI-Manager: GPL-3.0. comfy-mcp: AGPL-3.0-or-later *or* Commercial.
- ArtCraft apps: MIT OR Apache-2.0 at your option; name/logo excluded (forks must remove them); bundled assets have their own licences.
- Penpot MPL-2.0; Material Maker MIT; gdUnit4/GUT/Godot MCP servers (except Workbench: Apache-2.0) MIT.
- Unconfirmed: Godot (MIT, general knowledge), Krita, Inkscape, ffmpeg, sox, Tiled, ArmorPaint (paid binaries; free from source).

## Model weights
| Model | Key terms (from licence/card) |
|---|---|
| Hunyuan3D-2.1 | Excludes EU, UK, South Korea; >1M MAU needs Tencent licence; outputs may not train other AI models; AUP asks that machine-generated content be identified when published |
| Stable Fast 3D, SD 3.5 | Community licence: commercial only under US$1M annual revenue; SF3D requires "Powered by Stability AI" attribution and forbids training foundation models on outputs |
| TRELLIS / TRELLIS.2 | MIT for model+code; nvdiffrast/nvdiffrec and submodules carry their own licences |
| FLUX.1 [schnell], Qwen-Image | Apache-2.0 |
| FLUX.1 [dev], FLUX.2 [dev] | Non-commercial licences; commercial terms not read — `unverified` |
| Stable Audio Open / 3.0 open-weights | Stability Community licence; not OSI open source |
| MusicGen/AudioCraft | reportedly CC-BY-NC — `unverified` |

## Hosted services
ComfyUI "partner/API nodes" and Mixar's backend are paid, proprietary, hosted; Mixar records MCP tool-call inputs/outputs. Pricing/terms `unverified`.

## Consequences for planning
Prefer Apache/MIT image models for commercial concept art; treat Hunyuan3D and Stability weights as conditional on territory/revenue; record licence + provenance per generated asset.

## Third-party asset licences
Asset licences (CC0/BY/BY-SA/NC, custom marketplace terms, restrictions on redistributing originals and on AI use) are covered separately in [[game-studio-asset-license-and-provenance-policy]] and the provider catalog [[game-studio-asset-source-catalog]].

## Free/libre-first
See [[game-studio-cost-and-openness-classification]] and [[gs-adr-free-and-open-source-first]] for the project's preference for free, gratis and open-source resources.

## See also
- [[game-studio-tool-matrix]] — where each tool sits
- [[game-studio-ai-generation]] — generation stack

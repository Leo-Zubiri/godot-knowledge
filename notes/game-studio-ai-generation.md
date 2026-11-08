---
id: game-studio-ai-generation
type: reference
domain: game-studio
status: proposed
summary: "Local AI generation stack (ComfyUI plus open-weight models): what is documented, licence/hardware limits, and why generated output is not a production asset."
sources:
  - claim: "ComfyUI HTTP/WebSocket API, release cadence, Manager code-execution risk"
    ref: src-gs-comfyui-core
    retrieved: 2026-11-08
  - claim: "ComfyUI MCP servers are Beta/community"
    ref: src-gs-comfyui-mcp
    retrieved: 2026-11-08
  - claim: "Hunyuan3D-2.1 licence and VRAM"
    ref: src-gs-hunyuan3d-license
    retrieved: 2026-11-08
  - claim: "Stable Fast 3D and TRELLIS licences, VRAM, outputs"
    ref: src-gs-sf3d-trellis
    retrieved: 2026-11-08
  - claim: "Image model licences"
    ref: src-gs-image-model-licenses
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-licensing-risks]]"   # licence axes
  - relates-to: "[[game-studio-hardware-and-cost]]"   # VRAM figures
  - relates-to: "[[game-studio-acceptance-criteria]]"   # generated assets must pass the same gates
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Everything here is a *proposal* pending human review.


## ComfyUI (Level A research)
- GPL-3.0 application; stable releases about every two weeks; Windows/Linux/macOS.
- Programmatic control: `POST /prompt` (returns `prompt_id` or `node_errors`), `GET /history/{id}`, `GET /view`, `/ws` progress events. A small script (submit workflow JSON, poll, fetch) likely suffices; an MCP server adds a dependency for little gain (reasoning, not measured). API-format schema, `--listen` and determinism statements are `unverified`.
- Reproducibility is best-effort: pin ComfyUI version, custom-node commits, model hashes and seeds.
- Security: custom nodes run arbitrary code; ComfyUI-Manager installs requirements and runs `install.py`. Treat nodes like dependencies to be reviewed and pinned.

## Models (preliminary)
- **Images:** Qwen-Image and FLUX.1 [schnell] are Apache-2.0 (cleanest). FLUX dev variants and Stability models carry non-commercial or revenue-capped terms.
- **3D:** TRELLIS / TRELLIS.2 (MIT; 16 / 24 GB VRAM; Linux), Stable Fast 3D (≈6 GB; revenue cap), Hunyuan3D-2.1 (up to 29 GB; territory/MAU limits). All **Experimental**.

## Generation ≠ production asset
No official model page documents Blender integration, topology quality or a Godot-ready export. A generated mesh needs (general practice, `unverified` against these models): retopology/decimation, UV validity, PBR map checks (TRELLIS.2 exports opacity as OPAQUE by default), scale/pivot, normals/manifold checks, collision, scripted Godot import test, and a licence+provenance record. See [[game-studio-acceptance-criteria]].

## Generate last
Generation is the fallback after asset discovery finds no adequate, legally usable existing asset: see [[game-studio-reuse-vs-generation-decision-framework]]. Restricted assets (e.g. Sonniss, NoAI-tagged) must not be used as generative inputs ([[game-studio-asset-license-and-provenance-policy]]).

## Position in the minimum toolchain
Not required. Use for concept art or prop prototypes behind a human review gate.

## See also
- [[game-studio-licensing-risks]] — model terms in detail
- [[game-studio-hardware-and-cost]] — VRAM figures

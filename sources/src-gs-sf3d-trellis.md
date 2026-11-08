---
id: src-gs-sf3d-trellis
type: source
domain: game-studio
source:
  url: "https://raw.githubusercontent.com/Stability-AI/stable-fast-3d/main/LICENSE.md ; https://github.com/Stability-AI/stable-fast-3d ; https://github.com/microsoft/TRELLIS ; https://github.com/microsoft/TRELLIS.2"
  title: "Stable Fast 3D, TRELLIS, TRELLIS.2 repos and licenses"
  retrieved: 2026-11-08
  version: "SF3D / TRELLIS last dated update 2025-03-25; TRELLIS.2 date unverified"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- Stable Fast 3D: Stability AI Community License — free research/non-commercial; commercial use requires registration and is for organizations under US$1M annual revenue, above that enterprise license; outputs owned by user "to the extent permitted by law"; "Powered by Stability AI" attribution; no using outputs to build/improve foundation generative models. ~6 GB VRAM default; GLB with UV unwrap, textures, predicted material params; `--texture-resolution`, `--remesh_option` (None/Triangle/Quad); Windows experimental.
- TRELLIS (v1): MIT for code and models; submodules/nvdiffrast/nvdiffrec have separate terms; Linux only (tested); >=16 GB VRAM; outputs Gaussians/radiance fields/GLB/PLY.
- TRELLIS.2: MIT model+code, nvdiffrast/nvdiffrec own licenses; Linux only (tested); >=24 GB (A100/H100 tested); `sample.glb` "PBR-ready" (base color, roughness, metallic, opacity; opacity OPAQUE by default).
- No official page mentions Blender integration. Cleanup requirements for Godot are general practice, `unverified` against these models.

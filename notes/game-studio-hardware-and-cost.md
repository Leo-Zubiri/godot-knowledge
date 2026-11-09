---
id: game-studio-hardware-and-cost
type: reference
domain: game-studio
status: proposed
summary: Documented hardware needs per tool and the cost/effort metrics, all marked not measured where no reliable data exists.
tags: [scope/licensing]
sources:
  - claim: "ComfyUI minimum hardware claim and platforms"
    ref: src-gs-comfyui-core
    retrieved: 2026-11-08
  - claim: "Hunyuan3D VRAM figures"
    ref: src-gs-hunyuan3d-license
    retrieved: 2026-11-08
  - claim: "Stable Fast 3D / TRELLIS / TRELLIS.2 VRAM and OS"
    ref: src-gs-sf3d-trellis
    retrieved: 2026-11-08
  - claim: "bpy wheel size and Python pin"
    ref: src-gs-blender-releases-bpy
    retrieved: 2026-11-08
  - claim: "Headless Godot needs no GPU for export; rendering needs display or software renderer (unverified)"
    ref: src-gs-godot-cli
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-tool-matrix]]"   # tools these figures apply to
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Ratings are *preliminary recommendations*, not approved standards.


## Documented figures
| Item | Figure | Status |
|---|---|---|
| ComfyUI | "as low as 4GB vram + 8GB ram" (README) | documented, model-dependent |
| Hunyuan3D-2.1 | 10 GB shape / 21 GB texture / 29 GB both VRAM | documented |
| TRELLIS (v1) | ≥16 GB VRAM, Linux only (tested) | documented |
| TRELLIS.2 | ≥24 GB VRAM (A100/H100 tested), Linux only (tested) | documented |
| Stable Fast 3D | ~6 GB VRAM default; CUDA/MPS/CPU fallback; Windows experimental | documented |
| FLUX.1/FLUX.2/Qwen-Image/SD3.5 | parameter counts only (12B/32B/~20B/8B); **VRAM not stated** | unknown |
| `bpy` wheel | ~1.2 GB; Python 3.13 only | documented |
| Godot export/CI | headless; no GPU needed for export | documented; rendering tests need a display or software renderer (`unverified`) |
| Blender | CPU workable for scripted import/export/validation; GPU for EEVEE/fast Cycles | prior knowledge, `unverified` |

## Cost and effort metrics (kept separate)
Agent tokens · API cost · execution time · human intervention · retry rate → **not measured** for every tool and workflow. Large agent tool surfaces (ArtCraft claims 400+ commands in FigCraft; Godot Workbench 129 tools) may bloat agent context — a risk, not a measurement. Any real figure needs an authorized experiment and must be labelled measured / documented / estimate / unknown.

## See also
- [[game-studio-tool-matrix]]

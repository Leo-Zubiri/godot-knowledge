---
id: src-gs-blender-releases-bpy
type: source
domain: game-studio
source:
  url: "https://www.blender.org/download/releases/ ; https://pypi.org/project/bpy/ ; https://docs.blender.org/api/current/"
  title: "Blender releases, pip bpy wheel, Python API docs"
  retrieved: 2026-11-08
  version: "Blender 5.2 LTS (2026-07-14); bpy 5.2.3 (2026-10-22)"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- Blender 5.2 LTS released 2026-07-14; previous LTS 4.5 (2025-07-15), 4.2 (2024-07-16), 3.6. Non-LTS cadence unverified.
- pip `bpy` 5.2.3 (2026-10-22): requires Python 3.13.*; wheels Linux x86-64 (glibc 2.28+), macOS ARM64, Windows x64/ARM64; ~1.2 GB; GPL-3.0; versions outside LTS window removed from PyPI.
- Python API docs exist and are large/version-specific (hallucination risk for old API names — a risk assessment, not measured).
- NOT confirmed this session (prior knowledge): `--python-expr`, `--python-exit-code`, headless Cycles CPU, EEVEE needing GL context, operators needing UI context, glTF exporter options (manual URL returned 404; check https://docs.blender.org/manual/en/latest/addons/import_export/scene_gltf2.html). Blender-output/GPL implications for scripts: needs legal check.

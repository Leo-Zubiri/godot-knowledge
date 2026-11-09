---
id: godot-renderer-feature-matrix
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 renderer choice (Forward+, Mobile, Compatibility), what each lacks, and how to choose a GI technique (SDFGI, VoxelGI, LightmapGI) and light limits."
tags: [dept/3d-art, dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Renderers, global illumination and lights pages re-read for 4.7; feature tables per research subagent"
    ref: src-gd-3d-materials-rendering
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-export-platform-notes]]"   # web and iOS-simulator renderer limits
  - relates-to: "[[godot-performance-workflow]]"   # cost and instancing
  - relates-to: "[[godot-3d-materials-and-transparency]]"   # material features
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


## Renderers
Forward+ = richest feature set, desktop default (compute shaders, SDFGI, VoxelGI, SSIL, volumetric fog); Mobile = faster for simpler scenes on phones and desktops (lacks SSAO, SSR, volumetric fog, SDFGI); Compatibility = most basic, OpenGL, older hardware and the **only web option**. Since 4.4 Forward+/Mobile fall back to D3D12 or Vulkan, then Compatibility, unless disabled (subagent). ReflectionProbes: 2 per mesh (Compatibility) / 8 (Mobile) / unlimited (Forward+). TAA is Forward+ only; FXAA/SMAA 1x Forward+ and Mobile; decals Forward+ and Mobile; SSR Forward+ only; glow on Forward+ and Mobile.

## Choosing GI (documented)
**SDFGI**: easiest desktop start, semi-real-time (dynamic objects receive but do not contribute). **VoxelGI**: fully real-time, emissive dynamic objects contribute, but needs placement/baking and thick walls. **LightmapGI**: most accurate and cheapest at runtime, needs UV2 and an editor bake, cannot serve procedurally generated levels; baking cannot be done at runtime. For mobile, LightmapGI and ReflectionProbes are among the few options; offer a way to disable SDFGI/VoxelGI on low-end hardware.

## Light limits
Forward+: 512 clustered elements in view by default (raisable). Mobile: 8 omni + 8 spot per mesh (not changeable). Compatibility: 8 + 8 per mesh (raisable at a cost). Up to 8 directional lights visible; extra shadowed directional lights reduce shadow resolution. AreaLight3D is the most expensive. Default shadow atlas supports 88 shadowed lights.

## What an agent can and cannot check
An agent can read the renderer setting in `project.godot`, Environment fields, light bake modes and node counts against these limits. Visual quality, banding, GI leaks and frame cost need a renderer (headless runs have no GPU rendering — *unverified* in the docs; GI baking needs hardware per the renderers page).

## See also
- [[godot-performance-workflow]] — cost and instancing
- [[godot-3d-materials-and-transparency]] — material features
- [[godot-export-platform-notes]] — web and iOS-simulator renderer limits

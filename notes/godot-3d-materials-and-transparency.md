---
id: godot-3d-materials-and-transparency
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 3D materials: OpenGL-style normal maps, ORM packing, transparency modes and sorting limits, cull mode, texture limits, banding and depth."
tags: [dept/materials, dept/3d-art, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "StandardMaterial3D and 3D rendering limitations pages for 4.7 (per research subagent)"
    ref: src-gd-3d-materials-rendering
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-blender-pipeline]]"   # Blender export settings
  - relates-to: "[[godot-renderer-feature-matrix]]"   # feature support per renderer
  - relates-to: "[[game-studio-godot-asset-format-and-import-compatibility]]"   # texture import settings
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **Normal maps:** only red and green channels are used; Godot expects **OpenGL-style Y (green up)**; DirectX-style maps need the Y axis flipped.
- **ORMMaterial3D:** occlusion, roughness and metallic share one texture (channel order **not stated** on the page); Substance Painter and ArmorPaint can export it via an Unreal preset.
- **Transparency modes:** Disabled (fastest), Alpha (slow, no shadows, VFX), Alpha Scissor (hard cutoff, shadows), Alpha Hash (dithered, shadows, hair), Depth Pre-Pass. Alpha antialiasing edge must stay below the scissor threshold (0.3 vs 0.5 defaults) and wants MSAA 2x+; subsurface scattering only in Forward+; alpha-blended materials sort poorly and are missing from most reflections. **No order-independent transparency**; sorting is by node position (Render Priority, Sorting Offset, splitting materials, Scissor/Pre-Pass/Hash).
- **Cull mode:** Back (default), Front, Disabled. Blender exports glTF materials with culling off: enable Backface Culling in Blender and re-export.
- **Limits:** textures above 8192 may fail on old desktop GPUs, mobile typically 4096 (power-of-two advised for repeating textures on mobile); banding worst in Compatibility, then Mobile (Use Debanding in Forward+/Mobile); depth 32-bit desktop, 24-bit mobile (raise Camera near or lower far to reduce z-fighting).

## What an agent can and cannot check
An agent can read `.tres`/`.import` fields (transparency, cull mode, texture paths, compress mode); DirectX- vs OpenGL-style normals can only be inferred from naming (*unverified*). Look and sorting need a renderer.

## See also
- [[game-studio-blender-pipeline]] — Blender export settings
- [[godot-renderer-feature-matrix]] — feature support per renderer
- [[game-studio-godot-asset-format-and-import-compatibility]] — texture import settings

---
id: src-gd-3d-materials-rendering
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/3d/standard_material_3d.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/3d/standard_material_3d.html"
    - "https://docs.godotengine.org/en/stable/tutorials/3d/3d_rendering_limitations.html"
    - "https://docs.godotengine.org/en/stable/tutorials/rendering/renderers.html"
    - "https://docs.godotengine.org/en/stable/tutorials/3d/global_illumination/introduction_to_global_illumination.html"
    - "https://docs.godotengine.org/en/stable/tutorials/3d/environment_and_post_processing.html"
    - "https://docs.godotengine.org/en/stable/tutorials/3d/lights_and_shadows.html"
    - "https://docs.godotengine.org/en/stable/tutorials/3d/3d_antialiasing.html"
    - "https://docs.godotengine.org/en/stable/tutorials/3d/using_decals.html"
  title: "Godot 4.7 3D materials and rendering: StandardMaterial3D, rendering limits, renderers, GI, environment, lights, antialiasing, decals"
  retrieved: 2026-11-08
  version: "4.7 — renderers, GI and lights re-read by the main agent; others 4.7 per subagent"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot documentation pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. **Version:** page headers say *Godot Engine 4.7 documentation* — confirmed by the main agent on the pages listed under "re-read", reported by research subagents for the others; pages carrying their own "may be outdated for 4.7" notice are flagged. Documentation only: nothing here was run in the engine, so behaviour claims are *documented*, not *experimentally validated*. Re-fetch before promoting dependent notes to `verified`.

- **Materials (subagent, 4.7):** normal maps use only red and green channels and Godot expects OpenGL-style Y (green up); DirectX-style maps need the Y axis flipped. ORMMaterial3D = StandardMaterial3D with occlusion/roughness/metallic in one texture (channel order not stated on the page). Emission adds light independent of scene lights and lights neighbours only through VoxelGI or SDFGI. Transparency modes: Disabled (fastest), Alpha (slow, no shadows, suits VFX), Alpha Scissor (hard cutoff, casts shadows), Alpha Hash (dithered, casts shadows, suits hair), Depth Pre-Pass; alpha blending is forced by Alpha mode, a non-Mix blend mode, Refraction, Proximity Fade or Distance Fade. Pitfalls: Alpha Antialiasing Edge must stay below the Alpha Scissor threshold (defaults 0.3/0.5); alpha antialiasing wants MSAA 2x+; subsurface scattering only in Forward+; alpha-blended materials sort poorly and are missing from most reflections. Cull mode Back (default)/Front/Disabled — Blender exports glTF materials with culling off, so enable Backface Culling in Blender and re-export. Texture limits: desktop above 8192 may fail on old GPUs, mobile typically 4096; power-of-two advised for repeating textures on mobile; Process > Size Limit downsizes at import. No order-independent transparency; objects sort by node position (workarounds: Render Priority, Sorting Offset, splitting materials, Alpha Scissor, Pre-Pass, Alpha Hash). Banding worst in Compatibility then Mobile (Use Debanding in Forward+/Mobile); depth is 32-bit on desktop and 24-bit on mobile (z-fighting: raise Camera near or lower far).
- **Renderers (re-read, 4.7):** Forward+ richest feature set, default on desktop; Mobile trades some features for faster rendering of simpler scenes (phones and desktops, newer graphics APIs); Compatibility most basic, OpenGL, older/weaker hardware and web. Per subagent: Forward+ has compute shaders, SDFGI, volumetric fog; Mobile lacks SSAO, SSR, volumetric fog, SDFGI; Compatibility has no compute shaders, CompositorEffects or light projector textures; web uses Compatibility only; fallback chain since 4.4 (Forward+/Mobile fall back to D3D12 or Vulkan then Compatibility unless disabled). Feature table (subagent): ReflectionProbe 2 per mesh (Compatibility) / 8 (Mobile) / unlimited (Forward+); LightmapGI renders in Compatibility but baking needs RenderingDevice hardware; VoxelGI, SDFGI, SSIL Forward+ only.
- **GI (re-read, 4.7):** SDFGI is the simplest desktop start (automatic, semi-real-time; dynamic objects receive but do not contribute); VoxelGI is fully real-time and lets emissive dynamic objects contribute but needs placing/baking, extents and thick walls to limit leaks; LightmapGI is the most accurate with more bounces but baked, needs UV2 and cannot serve procedurally generated levels; for mobile LightmapGI and ReflectionProbes are among the few options (SDFGI/VoxelGI unavailable on Mobile/Compatibility). Per subagent: provide an option to disable SDFGI/VoxelGI on low-end hardware; baking cannot be done at runtime.
- **Environment/post-processing (subagent):** SSR Forward+ only; SSAO full in Forward+, simplified in Compatibility (Radius and Intensity only since 4.6), absent in Mobile; SSIL, auto exposure, SDFGI Forward+ only; glow full on Forward+ and Mobile; tonemap modes Linear, Reinhard, Filmic, ACES, AgX. **Antialiasing:** MSAA in all renderers; TAA Forward+ only; FXAA and SMAA 1x Forward+ and Mobile. **Decals:** Forward+ and Mobile only.
- **Lights (re-read, 4.7):** DirectionalLight3D, OmniLight3D, SpotLight3D, AreaLight3D (most expensive); Forward+ clusters lights — default 512 clustered elements in view (raisable); Mobile limits 8 omni + 8 spot per mesh (view cap 256 each, not changeable); Compatibility 8 + 8 per mesh (raisable at a cost); up to 8 directional lights visible in all renderers (extra shadowed directional lights reduce shadow resolution); exceeding limits makes lights pop (distance fade, mesh splitting, baked lightmaps, emissive materials help). Shadows: bias/normal bias fix acne vs peter-panning; directional uses PSSM (4 splits default); omni Dual Paraboloid (faster, can distort) or Cube (default, more accurate); spot shadows stop above 89°; shadow atlas defaults to 88 shadowed lights, 4096 map size, 16-bit depth; PCSS soft shadows costly; filter modes Soft Very Low–Ultra.

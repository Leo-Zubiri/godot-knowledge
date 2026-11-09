---
id: src-gd-vfx-shaders
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/2d/particle_systems_2d.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/2d/particle_systems_2d.html"
    - "https://docs.godotengine.org/en/stable/tutorials/3d/particles/index.html"
    - "https://docs.godotengine.org/en/stable/tutorials/shaders/introduction_to_shaders.html"
    - "https://docs.godotengine.org/en/stable/tutorials/shaders/screen-reading_shaders.html"
  title: "Godot 4.7 VFX: 2D particles, 3D particles index, shader introduction, screen-reading shaders"
  retrieved: 2026-11-08
  version: "4.7 (headers reported by subagent); 2D particles page carries a may-be-outdated notice"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot documentation pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. **Version:** page headers say *Godot Engine 4.7 documentation* — confirmed by the main agent on the pages listed under "re-read", reported by research subagents for the others; pages carrying their own "may be outdated for 4.7" notice are flagged. Documentation only: nothing here was run in the engine, so behaviour claims are *documented*, not *experimentally validated*. Re-fetch before promoting dependent notes to `verified`.

- **GPUParticles2D vs CPUParticles2D:** the docs recommend GPUParticles2D unless there is a specific reason; CPUParticles2D has near feature parity, may help on low-end or GPU-bound scenes, is slower at large counts and gets no new features; GPU particles need a ParticleProcessMaterial or they emit only a white dot. Settings: Lifetime, One Shot, Preprocess, Explosiveness, Randomness, Local Coords, Draw Order, flipbooks via CanvasItemMaterial particle animation. Pitfalls: black flipbook background (use Add blend), a Visibility Rect outside the viewport hides particles, Fract Delta costs performance, 2D particles lack physics interpolation (per the page's 4.3 note).
- **3D particles index:** sub-emitters, trails, attractors and collisions each have pages (links seen, contents unread).
- **Shader types** (first line): `spatial`, `canvas_item`, `particles`, `sky`, `fog`, `texture_blit`; shaders keep no state between frames; `light()` may not run with vertex lighting (the default on mobile).
- **Screen-reading shaders:** `hint_screen_texture` at `SCREEN_UV`; blur needs a mipmap filter and LOD above 0; depth via `hint_depth_texture`; normal-roughness texture is Forward+ only; in 2D overlapping screen-reading shaders need `BackBufferCopy`; in 3D the screen is captured after the opaque pass so transparent objects are missing. Visual shaders and ColorRect post-processing not covered.

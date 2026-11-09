---
id: godot-particles-and-shader-basics
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 particles and shaders basics: GPUParticles vs CPUParticles, ParticleProcessMaterial, shader types, and screen-reading limits; sub-emitters, trails and visual shaders unread."
tags: [dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Particles and shader pages for 4.7 (2D particles page flagged possibly outdated)"
    ref: src-gd-vfx-shaders
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-workflows]]"   # the VFX workflow is designed only
  - relates-to: "[[godot-renderer-feature-matrix]]"   # renderer limits for effects
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- The docs recommend **GPUParticles2D** unless there is a specific reason; **CPUParticles2D** has near parity, may help on low-end or GPU-bound scenes, is slower at large counts and gets no new features. GPU particles need a **ParticleProcessMaterial** or they emit only a white dot.
- Pitfalls: black flipbook background (use Add blend); a Visibility Rect outside the viewport hides particles; Fract Delta costs performance; 2D particles lack physics interpolation (per the page's 4.3 note; the page may be outdated for 4.7).
- **Shader types:** `spatial`, `canvas_item`, `particles`, `sky`, `fog`, `texture_blit`; shaders keep no state between frames; `light()` may not run with vertex lighting (mobile default).
- **Screen-reading:** `hint_screen_texture` at `SCREEN_UV`; blur needs mipmap filter and LOD > 0; in 2D overlapping effects need `BackBufferCopy`; in 3D the screen is captured after the opaque pass (transparent objects missing); normal-roughness texture is Forward+ only.
- Sub-emitters, trails, attractors, collisions and visual shaders: pages listed but **not read**.

## What an agent can and cannot check
An agent can read particle resources for a process material, visibility rect and lifetimes, and `.gdshader` text for `shader_type` and hints. Compiling shaders headlessly is *unverified*. VFX readability needs a human playing and reviewing captures.

## See also
- [[game-studio-workflows]] — the VFX workflow is designed only
- [[godot-renderer-feature-matrix]] — renderer limits for effects

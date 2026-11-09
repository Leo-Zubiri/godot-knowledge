---
id: godot-3d-particles-trails-attractors-collision
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 GPU particles 3D: trails, attractors, collision nodes and sub-emitters, with renderer limits and the pitfalls the docs call out."
tags: [dept/game-dev, tool/godot, dim/3d]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "3D particle pages, GPUParticles3D and ParticleProcessMaterial class pages"
    ref: src-gd-particles-shaders-performance
    retrieved: 2026-11-08
  - claim: "Sub-emitters page read for 4.7"
    ref: src-gd-projectsettings-subemitters-visualshaders
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-particles-and-shader-basics]]"   # base particle setup
  - relates-to: "[[godot-renderer-feature-matrix]]"   # renderer limits
  - relates-to: "[[godot-performance-workflow]]"   # cost control
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---


> **Evidence status:** distilled from the official Godot documentation as extracted on 2026-11-08 (paraphrased, see the cited source). Nothing was run in the engine: *documented*, not *experimentally validated*. Items marked UNV were not read on an official page. Status `proposed`.

- **Trails:** Forward+ and Mobile only (not Compatibility). Enable trail and lifetime, use `RibbonTrailMesh` or `TubeTrailMesh` as draw pass, enable "Use Particle Trails" in the process material; tubes need Transform Align "Y to Velocity" or they flatten.
- **Attractors:** `GPUParticlesAttractorBox3D`/`Sphere3D`/`VectorField3D`; strength (negative repels), attenuation, directionality, cull mask; the process material must enable attractor interaction; not for 2D. Vector-field textures: neutral grey = no force.
- **Collision:** GPU particles do not see the physics world. Use `GPUParticlesCollisionBox3D`/`Sphere3D`/`HeightField3D` (runtime) or `SDF3D` (baked, static, Forward+/Mobile). The visibility AABB must overlap the collider; thin colliders miss fast particles (thicken or raise Fixed FPS). Collision mode DISABLED/RIGID/HIDE_ON_CONTACT.
- **Sub-emitters (page read, 4.7):** needs a parent and a child system; set the parent's `Sub Emitter`; emission is off until the process material's `Mode` in the `Sub Emitter` group is not Disabled (`Constant` at `Frequency`; `At End`/`At Collision` spawn the set amounts); the child stops emitting by itself and cannot be re-enabled while in use; active sub-particles are capped by the child's `Amount`; `Explosiveness` has no effect; self-reference does not spawn.
- **Class facts:** `amount_ratio` changes without restart but does not improve performance; high `preprocess` is expensive; `restart()` for one-shot reuse; colour properties multiply vertex colours (a BaseMaterial3D needs `vertex_color_use_as_albedo`).

## See also
- [[godot-particles-and-shader-basics]] — base particle setup
- [[godot-renderer-feature-matrix]] — renderer limits
- [[godot-performance-workflow]] — cost control

---
id: godot-shader-compile-stutter-and-baker
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 shader/pipeline compilation stutter: what ubershaders, ahead-of-time pipeline precompilation (4.4+) and the Shader Baker (4.5+) do and do not fix, plus the Compatibility-renderer workaround."
tags: [dept/game-dev, tool/godot, dept/qa]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Pipeline compilations page and Shader Baker notes"
    ref: src-gd-particles-shaders-performance
    retrieved: 2026-11-08
  - claim: "Visual shaders page read for 4.7"
    ref: src-gd-projectsettings-subemitters-visualshaders
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-performance-workflow]]"   # profiling first
  - relates-to: "[[godot-renderer-feature-matrix]]"   # renderer differences
  - relates-to: "[[godot-export-fundamentals]]"   # Shader Baker is an export option
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---


> **Evidence status:** distilled from the official Godot documentation as extracted on 2026-11-08 (paraphrased, see the cited source). Nothing was run in the engine: *documented*, not *experimentally validated*. Items marked UNV were not read on an official page. Status `proposed`.

- **Two stages:** shader compilation and driver pipeline compilation (driver cache usually cleared on driver updates).
- **Mitigations:** ubershaders and specialization constants; **ahead-of-time precompilation from 4.4** during mesh/node load (2D canvas pipelines excluded); pipeline monitors (Canvas, Mesh, Surface, Draw, Specialization): rising Surface/Draw mid-play points to stutter.
- **Habits:** enable features early with a simple scene; do not change MSAA or shadow depth precision mid-game; keep a hidden instance of dynamically spawned effects.
- **Shader Baker (4.5+):** export option storing compiled intermediate shaders in the PCK; shortens first launch, does **not** remove stutter; Forward+/Mobile only, not web or headless exports; must match `rendering/rendering_device/driver`.
- **Compatibility renderer:** ubershaders/precompilation do not apply; show materials/particles in view for at least one frame while loading.
- **Visual shaders (page read, 4.7):** the graph is converted to script code you can view; visual shaders do not expose every script feature; Mesh Emitter works only in Particles mode and only with OBJ meshes; Expression-node errors show in the Output tab. **Style guide (earlier read):** the shaders style guide mandates tabs, lines <100 chars, snake_case, a fixed declaration order, and has no performance guidance.

## See also
- [[godot-performance-workflow]] — profiling first
- [[godot-renderer-feature-matrix]] — renderer differences
- [[godot-export-fundamentals]] — Shader Baker is an export option

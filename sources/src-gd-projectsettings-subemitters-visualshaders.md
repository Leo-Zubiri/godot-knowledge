---
id: src-gd-projectsettings-subemitters-visualshaders
type: source
domain: godot
source:
  url: "https://raw.githubusercontent.com/godotengine/godot/4.7-stable/doc/classes/ProjectSettings.xml"
  urls:
    - "https://raw.githubusercontent.com/godotengine/godot/4.7-stable/doc/classes/ProjectSettings.xml"
    - "https://docs.godotengine.org/en/stable/tutorials/3d/particles/subemitters.html"
    - "https://docs.godotengine.org/en/stable/tutorials/shaders/visual_shaders.html"
  title: "Godot 4.7: ProjectSettings class XML (vram_compression, stretch mode, texture filter), sub-emitters and visual shaders pages"
  retrieved: 2026-11-08
  version: "ProjectSettings.xml at tag 4.7-stable (also checked at 4.4, 4.5, 4.6 for the vram keys); doc pages headed Godot Engine 4.7"
  capture: paraphrased
  retrieved_via: "curl of the raw class XML (read by grep) and WebFetch summaries of the two doc pages; paraphrase, not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** the class XML is the source of the docs' class reference at the 4.7-stable tag, read with grep on 2026-11-08; the two tutorial pages were summarized by a fetch-time summarizer (paraphrase, not verbatim). Re-fetch before promoting dependent notes to `verified`.

## ProjectSettings (4.7-stable)
- **`rendering/textures/vram_compression/*`:** four keys exist: `cache_gpu_compressor` (bool, default true: caches the local RenderingDevice and its shaders/pipelines to speed later imports at the cost of memory), `compress_with_gpu` (bool, default true: GPU compression on devices with Vulkan, Direct3D 12 or Metal; currently only BC1, BC3, BC4, BC5 and BC6, desktop and console formats), `import_etc2_astc` and `import_s3tc_bptc` (bool, default false). The last two are **overrides**: the importer always imports the format the host platform needs even if false; they pick additional formats (ETC2/ASTC 4x4 for mobile; S3TC/DXT1-5 and BPTC BC6H/BC7 for desktop and consoles). Changing them does not re-import existing textures: exit the editor, delete the `.godot/imported/` folder (the page says `.godot/`) and restart. The same four keys and descriptions appear in 4.4, 4.5 and 4.6.
- **`display/window/stretch/mode`:** default `"disabled"` in 4.5, 4.6 and 4.7 (modes `disabled`, `canvas_items`, `viewport`). This is the engine setting default; whether the new-project template or editor wizard writes another value was not checked.
- **`rendering/textures/canvas_textures/default_texture_filter`:** int, default 1, keywords nearest/linear; the note points to the two 2D pixel-snap settings for pixel-art looks.

## Sub-emitters page (header 4.7; read)
Needs a parent and a child particle system; set the parent's `Sub Emitter`; instanced scenes need Editable Children. Emission is off by default: set `Mode` in the `Sub Emitter` group of the ParticleProcessMaterial to something other than Disabled. `Constant` spawns one particle at `Frequency`; `At End` and `At Collision` spawn `Amount At End`/`Amount At Collision`. The child stops emitting once used as a sub-emitter and cannot be re-enabled meanwhile; active sub-particles are capped by the child's `Amount`; `Explosiveness` has no effect; self-referential or recursive chains do not spawn.

## Visual shaders page (header 4.7; read)
Graph-based alternative, converted to script code you can view. Create a ShaderMaterial, assign a Shader resource, set Type to VisualShader. Special nodes include Expression, Reroute, Fresnel, Boolean, If, Switch and Mesh Emitter. Port colours: scalar grey, vector purple, boolean green, transform pink, sampler orange. The Vertex/Fragment/Light dropdown changes which built-ins exist. Stated limits: visual shaders do not expose all script features; Mesh Emitter only in Particles mode and only OBJ works when dragged in (glTF does not); Expression node changes apply when focus leaves the box and errors show in the Output tab.

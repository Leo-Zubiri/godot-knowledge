---
id: src-gs-godot-import-formats-47
type: source
domain: game-studio
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/available_formats.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/available_formats.html"
    - "https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_images.html"
  title: "Godot 4.7 documentation: available 3D formats and image import"
  retrieved: 2026-11-08
  version: "page headers say Godot Engine 4.7 documentation"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. Items marked `unverified` or *(search summary)* were not read in full on the primary page (blocked, binary PDF, abstract only). Not legal advice. Re-fetch or read the primary text before promoting any dependent note to `verified`.

- **3D formats (read; header says Godot 4.7):** imports whole scenes from glTF 2.0 (text and binary), `.blend`, COLLADA (DAE), OBJ+MTL and FBX. **glTF is recommended**: binary is compact and keeps textures inside the material; the text variant (separate binary and texture files) is easier to diff in version control. Blender export notes: with shape keys enable deformation-bones-only export or shading breaks; Blender before 3.2 skips emissive textures; Blender's backface culling is off by default so Godot materials come in with culling disabled. **`.blend` import** makes Godot call Blender to export glTF, so Blender 3.0+ (3.5+ recommended, official blender.org build) must be installed on every team member's machine; unavailable in the Android and web editors. **FBX:** Godot 4.3 and later default to the **ufbx** importer; projects created earlier keep **FBX2glTF** unless changed per file; FBX2glTF needs an external executable tied to the proprietary FBX SDK and is advised against. **DAE:** Blender's COLLADA export is poorly suited to game engines. **OBJ:** lacks skinning, animation, UV2 and PBR; Blender 3.4+ vertex colours show only with "Use As Albedo".
- **Images (read; header says Godot 4.7):** BMP, DDS, KTX, EXR, Radiance HDR, JPEG, PNG, TGA, WebP. PNG is 8 bits per channel, no HDR; JPEG has no transparency; WebP supports transparency; EXR/HDR suit panoramic skies. **SVG** is rasterized at import by default through **ThorVG** (only some SVG features; text must be converted to paths; Inkscape-exported PNG is often more reliable); only SVG can import as a DPITexture re-rasterized at runtime. Compression: in 2D **Lossless** is the default and recommended for pixel art, avoid VRAM Compressed (visible artifacts); in 3D VRAM Compressed is the usual default (~4–6× less video memory); Basis Universal gives very small files with lower quality and slower import; Godot auto-detects 3D use and enables mipmaps and VRAM compression. Mipmaps add ~⅓ memory, recommended for 3D.
- Fonts import page returned 404 earlier (unverified). Earlier preserved audio/retargeting pages remain in src-gs-audio-import-and-tools and src-gs-godot-3d-import.

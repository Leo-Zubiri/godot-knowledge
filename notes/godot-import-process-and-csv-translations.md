---
id: godot-import-process-and-csv-translations
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 import process (.import files, .godot/imported, reimport triggers, image compression options) and CSV translation rules including 4.6 plural/context columns."
tags: [dept/game-dev, tool/godot, dept/delivery]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Import process, image import options and CSV spreadsheet translation pages"
    ref: src-gd-2d-tilemap-audio-import-i18n
    retrieved: 2026-11-08
  - claim: "vram_compression project settings read in the 4.7-stable class XML"
    ref: src-gd-projectsettings-subemitters-visualshaders
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-localization-workflow]]"   # localization workflow
  - relates-to: "[[godot-project-hygiene]]"   # what to commit
  - relates-to: "[[godot-3d-import-options-and-export-hygiene]]"   # 3D side
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---


> **Evidence status:** distilled from the official Godot documentation as extracted on 2026-11-08 (paraphrased, see the cited source). Nothing was run in the engine: *documented*, not *experimentally validated*. Items marked UNV were not read on an official page. Status `proposed`.

- **Import:** commit `.import` files; do not commit `res://.godot/imported/`; reimport triggers are the Import dock, resource-type change, source MD5 change or deleting cached files; use `ResourceLoader` (raw `FileAccess` breaks after export); `.gdignore` hides folders. **The page does not cover command-line/headless import.**
- **Images:** Lossless (2D default), Lossy, VRAM Compressed (3D default), VRAM Uncompressed, Basis Universal; `high_quality` needs Forward+/Mobile; `mipmaps/limit` currently has no effect; pixel art stays Lossless. **`vram_compression` keys (class XML, 4.7-stable, same in 4.4-4.6):** `import_s3tc_bptc` and `import_etc2_astc` (default false) are *overrides*: the importer always produces the format the host platform needs, and the keys add the desktop (S3TC/BPTC) or mobile (ETC2/ASTC) formats; changing them does not re-import existing textures (delete `.godot/imported/` and restart). `compress_with_gpu` (default true; only BC1/3/4/5/6, needs Vulkan, D3D12 or Metal) and `cache_gpu_compressor` (default true) affect import speed and memory. This matters for exports that target both desktop and mobile.
- **CSV translations:** first column keys, others locale codes, `_`-prefixed columns are comments; **since 4.6 `?plural` and `?context` columns** exist but need manual `tr_n()`/`tr()`; UTF-8 without BOM; quote fields with commas/newlines/quotes (double inner quotes); imported translations must still be registered in settings.
- **Compatibility renderer (UNV, search summary):** widest hardware, web renderer; no compute shaders, limited post-processing, no HDR; test low-end hardware.

## See also
- [[godot-localization-workflow]] — localization workflow
- [[godot-project-hygiene]] — what to commit
- [[godot-3d-import-options-and-export-hygiene]] — 3D side

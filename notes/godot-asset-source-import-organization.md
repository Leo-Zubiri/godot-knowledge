---
id: godot-asset-source-import-organization
type: guide
domain: godot
status: proposed
summary: "Where each kind of asset lives relative to res:// (sources, intermediates, imported, runtime-ready, generated, third-party, licensed, modified), how import files and UIDs behave in version control, and how moves must respect them."
tags: [dept/game-dev, tool/godot, dept/assets]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation and engine source only; not run in the engine)"
sources:
  - claim: "Import files, imported cache, .gdignore, export rules, UIDs and .uid files"
    ref: src-gd-project-organization-vcs-uids
    retrieved: 2026-11-08
  - claim: "Plugin and addons layout facts"
    ref: src-gd-architecture-autoloads-plugins-cli
    retrieved: 2026-11-08
  - claim: "Community layouts for placement, preference only"
    ref: src-gs-project-organization-community-pointers
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-asset-conventions]]"   # source/runtime layout proposal and manifest
  - relates-to: "[[godot-import-process-and-csv-translations]]"   # import options and reimport
  - relates-to: "[[godot-3d-import-options-and-export-hygiene]]"   # 3D import
  - relates-to: "[[game-studio-asset-license-and-provenance-policy]]"   # licences and provenance
  - relates-to: "[[game-studio-blender-pipeline]]"   # Blender export
  - relates-to: "[[godot-project-hygiene]]"   # git and naming
  - relates-to: "[[godot-project-structure-selection-method]]"   # where this fits
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** engine facts come from the Godot 4.7 manual sources and engine files read on 2026-11-08 (paraphrased; see the cited sources). Everything labelled **principle**, **heuristic** or **community preference** is not an engine requirement. Nothing here was run in the engine or tested on a real project: structures are *theoretically evaluated*, not *experimentally validated*. Status `proposed`.


## Engine facts that constrain placement
- Imported assets must be **inside** the project folder (since 3.0); Godot imports them into `res://.godot/imported/` and writes `<asset>.import` beside each source. **Commit `.import`; do not commit `.godot/`.** Reimport triggers on source MD5 change.
- `ResourceLoader` loads imported assets; `FileAccess` works in the editor but breaks after export.
- A folder with an empty `.gdignore` is neither imported nor exported and cannot be loaded with `load()`/`preload()`: use it for docs, press kit, raw captures.
- Files and folders starting with a period are never exported; export filters can include non-resource files or exclude patterns.
- **UIDs:** scenes and native resources hold a `uid://` in their header; imported resources in `.import`; scripts and shaders have sibling `.uid` files since 4.4 (from the 2025 blog, possibly outdated). **Commit `.uid` files.** Moving a script or shader outside the editor requires moving its `.uid`; re-save scenes that referenced it. (The 4.7 TSCN page says Godot does not use external files for IDs: unresolved conflict, treat the blog as the safer rule.) `@export_file` stores `uid://` when set from the Inspector since 4.4; `@export_file_path` (4.5) keeps `res://`.

## Placement table (recommendations unless marked engine fact)
| Kind | Where | Why |
|---|---|---|
| Editable sources (`.blend`, layered images, DAW projects) | outside `res://`, e.g. an `art-src/` sibling, or inside a `.gdignore` folder | engine does not need them; avoids import and export of heavy files (the repo's existing proposal in [[game-studio-asset-conventions]]) |
| Exchange formats Godot imports (glTF/GLB, PNG, WAV/OGG, fonts) | inside `res://`, beside the feature or in a content area | engine fact: imports from inside the project |
| Godot-imported results | `.godot/imported/` (engine-managed) | never edit or commit |
| Runtime-ready assets and scenes built from them | feature or content folders | scene-first locality |
| Generated assets | a clearly named folder or a manifest field marking them generated, with generator and parameters | reproducibility; see the asset registry notes |
| Shared resources | a `shared/` area with an owner | avoid duplicates |
| Third-party / licensed | `addons/<name>/` (official convention) with its licence; character-specific third-party assets may sit with that character (official exception) | provenance |
| Project-specific modifications of third-party assets | copy beside the feature with a provenance note, do not edit in `addons/` | keeps updates and licence tracking clear (interpretation) |

## Format notes
- **Blender:** keep `.blend` as a source; export GLB/glTF into the project; Godot also imports `.blend` directly but that needs Blender at import time (see [[game-studio-blender-pipeline]], [[game-studio-godot-asset-format-and-import-compatibility]]).
- **Textures and sprites:** import presets differ for 2D pixel art versus 3D ([[godot-2d-production-settings]], [[godot-import-process-and-csv-translations]]).
- **Audio, fonts, translations:** import settings live in `.import`; CSV translation files generate `*.translation` which are git-ignored per the docs.
- **Git LFS:** optional; the docs' sample `.gitattributes` is a starting point listing binary types (including `.png` and `.glb`); it must be set up before the first commit.
- **Provenance:** record source, licence, generator and version per asset in a manifest (see [[game-studio-asset-license-and-provenance-policy]]); folder placement alone does not record provenance.
- **Never** recommend a layout that puts an importable file outside `res://` and expects Godot to import it, or that relies on `FileAccess` for imported assets.

## See also
- [[game-studio-asset-conventions]] — source/runtime layout proposal and manifest
- [[godot-import-process-and-csv-translations]] — import options and reimport
- [[godot-3d-import-options-and-export-hygiene]] — 3D import
- [[game-studio-asset-license-and-provenance-policy]] — licences and provenance
- [[game-studio-blender-pipeline]] — Blender export
- [[godot-project-hygiene]] — git and naming
- [[godot-project-structure-selection-method]] — where this fits

---
id: src-gd-project-organization-vcs-uids
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/best_practices/project_organization.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/best_practices/project_organization.html"
    - "https://docs.godotengine.org/en/stable/tutorials/best_practices/version_control_systems.html"
    - "https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/import_process.html"
    - "https://docs.godotengine.org/en/stable/tutorials/export/exporting_projects.html"
    - "https://docs.godotengine.org/en/stable/engine_details/file_formats/tscn.html"
    - "https://docs.godotengine.org/en/stable/tutorials/migrating/upgrading_to_godot_4.4.html"
    - "https://godotengine.org/article/uid-changes-coming-to-godot-4-4/"
    - "https://raw.githubusercontent.com/godotengine/godot/4.7-stable/doc/classes/ResourceUID.xml"
    - "https://raw.githubusercontent.com/godotengine/godot/4.7-stable/editor/version_control/editor_vcs_interface.cpp"
    - "https://raw.githubusercontent.com/godotengine/godot/4.7-stable/editor/docks/filesystem_dock.cpp"
  title: "Godot 4.7: project organization, version control files, import files, export configuration, UIDs and .uid files, editor move behaviour"
  retrieved: 2026-11-08
  version: "godot-docs branch 4.7 RST; engine tag 4.7-stable (class XML and two editor source files); Godot blog Jan 2025 (self-described as possibly outdated)"
  capture: paraphrased
  retrieved_via: "curl of RST and source files, read by the main agent; the blog article through a fetch-time summarizer"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** the reStructuredText sources of the Godot manual (branch `4.7` of godot-docs) and engine files at tag `4.7-stable` were downloaded with curl and read by the main agent on 2026-11-08; the points below are the agent's paraphrase, not verbatim. These are the sources of the published pages (stable URLs listed in `urls`), not the rendered pages. Re-read before promoting dependent notes to `verified`. The blog article was summarized by a fetch-time summarizer and warns that some details may be outdated.

## Project organization page
Godot has no restrictions on project structure or filesystem usage; it is scene-based, uses the filesystem as-is, with no asset database; many resources live inside scenes so there are fewer files. "The most common approach is to group assets as close to scenes as possible; when a project grows, it makes it more maintainable." The example tree groups by model/character/level folders (`models/town/house/...`, `characters/player/...`, `characters/enemies/goblin/...`, `levels/riverdale/riverdale.scn`) plus a `docs/` folder carrying `.gdignore`. Style guide: snake_case for folder and file names (C# scripts are the exception and follow PascalCase class names), PascalCase node names, third-party resources in a top-level `addons/` folder even if not editor plugins — with the stated exception that third-party assets for one character may sit with that character's scenes and scripts. Since Godot 3.0 assets are imported from inside the project folder (earlier versions imported from outside, which "resulted in an organization hassle for most developers"). **`.gdignore`:** an empty file (leading dot required; contents ignored, no patterns); the folder is hidden from the FileSystem dock; `load()`/`preload()` cannot load its resources; its contents are not exported. **Case sensitivity:** Windows and recent macOS are case-insensitive by default, Linux is case-sensitive, and the PCK virtual filesystem is case-sensitive, so use lowercase snake_case; WSL-based case-sensitive folders on Windows are described.

## Version control page
Godot aims to be VCS-friendly with "mostly readable and mergeable files". For Godot 4.1+ ignore `.godot/` (project cache) and `*.translation` (binary translations from CSV); 3.x and 4.0 had a different list and could store credentials in `export_presets.cfg`. The project manager's Git option or Project > Version Control > Generate Version Control Metadata creates `.gitignore` and `.gitattributes`. Only a Git editor plugin exists (as of October 2025, per the page). Windows: set `core.autocrlf input` (generated `.gitattributes` enforces LF). **Git LFS:** set it up before committing files; `git lfs migrate` is possible but advanced; a sample `.gitattributes` tracks 3D formats (fbx, gltf, glb, blend, obj), images (png, svg, jpg, tga, webp, exr, hdr, dds), audio (mp3, wav, ogg), fonts/icons and Godot binaries (scn, res, material, anim, mesh, lmbake) under LFS with `* text=auto eol=lf`; the page presents it as a starting point, not a requirement. **Engine source (4.7-stable, `editor_vcs_interface.cpp`):** the generated `.gitignore` contains the comment line, `.godot/` and `/android/`; the generated `.gitattributes` contains the comment and `* text=auto eol=lf` — `*.translation` is not in the generated file although the page says to ignore it.

## Import and export configuration
`<asset>.import` is written next to each imported source and must be committed; `res://.godot/imported/` holds compiled output and committing it is not recommended (deleting it triggers reimport); automatic reimport on source MD5 change; types can be set to "Keep File (exported as is)" or "Skip File (not exported)"; scene/resource native formats (tscn, scn, tres, res) have no import options; use `ResourceLoader` for imported assets (`FileAccess` breaks after export). Export: `export_presets.cfg` "can be safely committed" (nothing normally secret); `.godot/export_credentials.cfg` holds passwords/encryption keys and generally should not be committed (a cloned project may lack some export options until it is copied manually); files and folders whose names begin with a period are never exported; two export filters (include non-resource files, exclude by pattern).

## UIDs
TSCN page (4.7): the file descriptor looks like `[gd_scene format=3 uid="uid://..."]`; the scene's UID lets the engine "track files that are moved around, even while the editor is closed"; scripts can load `uid://` paths; "Godot does not use external files to keep track of IDs, which means no central metadata storage location is required" (this sentence conflicts with the blog below for scripts/shaders). `load_steps` is deprecated in files saved from 4.6. `ext_resource` entries carry type, UID, path and id. ResourceUID class: UIDs "keep references between resources intact, even if files are renamed or moved" (`uid://`; conversion helpers between path and UID). 4.4 migration page: `@export_file` assigned from the Inspector stores `uid://` instead of `res://` (breaking), and 4.5 adds `@export_file_path` to keep `res://` paths. Command line `--scene` accepts a path or UID. **Godot blog (Jan 2025, possibly outdated):** 4.4 adds sibling `.uid` files (`some_file.gd.uid`) for scripts and shaders (plain text, nowhere to store a UID) and other files without a place for a UID; imported resources keep their UID in `.import`, scenes and native resources in their header; `.uid` files must be committed (do not ignore `*.uid`); when moving or renaming outside the editor move the `.uid` file too, open scenes that reference the moved file and re-save them to clear warnings; leaving a stale `.uid` after deleting a file is less important; without `.uid` files after cloning, references fall back to stored paths with warnings, which can silently swap resources; after upgrading to 4.4 re-save all scenes and resources in one pass to avoid random diffs later. A release-page mention of a "UID upgrade tool" was not confirmed in the article text.

## Editor move behaviour (engine source, 4.7-stable `filesystem_dock.cpp`)
On move or rename in the FileSystem dock the editor renames loaded resource paths, remaps dependencies of owning files with `ResourceLoader::rename_dependencies` (reporting files it could not update), updates project settings whose values are moved paths, rewrites autoload entries (including the leading `*` of singletons), updates the main scene path, and carries over folder colours and favourites. This is source-level evidence of what the editor does; the manual pages read do not describe it. An OS-level move performs none of these updates (our inference from the code path being in the dock).

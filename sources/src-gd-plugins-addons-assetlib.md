---
id: src-gd-plugins-addons-assetlib
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/4.7/tutorials/plugins/editor/making_plugins.html"
  urls:
    - "https://docs.godotengine.org/en/4.7/tutorials/plugins/editor/making_plugins.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/plugins/editor/installing_plugins.html"
    - "https://docs.godotengine.org/en/4.7/community/asset_library/submitting_to_assetlib.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/best_practices/project_organization.html"
  title: "Godot 4.7: making plugins, installing plugins, submitting to the Asset Library, project organization"
  retrieved: 2026-11-08
  version: "4.7 (page headers: Godot Engine 4.7 documentation in English)"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot 4.7 documentation pages fetched on 2026-11-08 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**. Every page reported the header *Godot Engine 4.7 documentation*. Nothing was run in the engine. Re-fetch before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

- **Making plugins:** plugins live at `addons/plugin_name/` inside the project. Example layouts: `addons/my_custom_node/` with `plugin.cfg`, the EditorPlugin script, the node script and an optional `icon.svg`; `addons/my_custom_dock/` with `plugin.cfg`, `custom_dock.gd`, `my_dock.tscn`. Sub-plugins are moved into the main plugin's folder. `plugin.cfg` is an INI-style file with a `[plugin]` section and keys `name`, `description`, `author`, `version` (the dialog example uses `1.0.0`), `script` (relative script file; `.cs` for C#). The EditorPlugin script must be a `@tool` script extending `EditorPlugin` or it "will not load properly"; every other GDScript the editor uses must also be `@tool`, otherwise it "will act like an empty file". Initialize in `_enter_tree()`, clean up in `_exit_tree()` (e.g. `remove_dock(dock)` then `dock.queue_free()`). Custom nodes are registered with `class_name` (GDScript) or `[GlobalClass]` (C#) so they appear in Create New Node; `add_custom_type` is not covered on the page. Autoloads: `add_autoload_singleton(AUTOLOAD_NAME, "res://addons/my_addon/some_autoload.tscn")` in `_enable_plugin()` and `remove_autoload_singleton(AUTOLOAD_NAME)` in `_disable_plugin()`; the autoload can be a scene or script. Enable in Project Settings > Plugins (checkbox; initially disabled). C# plugins need the project built before enabling.
- **Installing plugins:** preferred source is the Asset Library (AssetLib tab or web); also GitHub (Releases tab for tagged stable releases, Download ZIP otherwise). "Some repositories call themselves plugins but aren't editor plugins" — those are used by the running project: extract into the project, no enabling needed. An editor plugin is recognised by a `plugin.cfg` inside a folder under `addons/`. Manual install: extract the ZIP and move/merge its `addons/` folder into the project (the docs say no files are overwritten). Enable: Project > Project Settings > Plugins > Enable. Enabling/disabling needs no editor restart.
- **Submitting to the Asset Library:** no mandatory folder structure; `addons/asset_name/` "is common practice" for non-project assets to avoid file clashes and is **not** generated automatically on install. One engine version per asset entry (resubmit per version). Repository **must** have `LICENSE` or `LICENSE.md` with licence text and copyright holder/years; the selected licence must match; plugins should also ship the licence and readme inside the plugin folder. Description is plain text (features, behaviour, changelog). Icon: PNG/JPG, square, ≥128×128, direct link (GitHub raw URL form). Up to three previews. Screenshots in the repo go in their own subfolder with an empty `.gdignore`. Any version scheme is allowed, SemVer suggested; an internal version increments whenever the download URL changes. Rejection: does not work in the stated Godot version; missing proper `.gitignore`; submodules whose contents are required (GitHub ZIPs omit them); licence mismatch; poor English in name/description; non-direct icon link. Recommended: fix/suppress script warnings, follow the style guides, include example files, `.gitattributes` with `export-ignore`, host on GitHub. Manual review, up to a few days; rejections state a reason. Categories: Addons (visible inside a project), Projects (templates/demos/projects, visible from the Project Manager).
- **Project organization:** "group assets as close to scenes as possible"; example tree `/characters/player/…`, `/characters/enemies/goblin/…`, `/levels/riverdale/…`. "Keep third-party resources in a top-level `addons/` folder, even if they aren't editor plugins" (exception: third-party assets for one character live with that character). `.gdignore` (empty file) stops import of a folder: contents can't be `load()`ed/`preload()`ed and are hidden from the FileSystem dock; no pattern support. Naming: `snake_case` folders/files (C# scripts PascalCase), PascalCase node names. The PCK virtual filesystem is case-sensitive; mismatches break exports on case-insensitive hosts.

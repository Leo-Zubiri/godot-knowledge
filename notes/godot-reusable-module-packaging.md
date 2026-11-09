---
id: godot-reusable-module-packaging
type: guide
domain: godot
status: proposed
summary: "How to package a reusable Godot 4.7 module under addons/<name>/ so it can be copied into another project: plugin.cfg only for editor plugins, class_name prefixes, no dependency on game code, licence/version files, Asset Library expectations, and the uid/autoload pitfalls."
aliases: [addon packaging, reusable library, shared module, plugin.cfg, asset library submission]
tags: [dept/game-dev, dept/delivery, tool/godot]
sources:
  - claim: "Making plugins, installing plugins, Asset Library submission rules and project-organization guidance for Godot 4.7"
    ref: src-gd-plugins-addons-assetlib
    retrieved: 2026-11-08
  - claim: "Scripts and shaders carry sibling .uid files since 4.4; moving them outside the editor must move the .uid too"
    ref: src-gd-project-organization-vcs-uids
    retrieved: 2026-11-08
related:
  - depends-on: "[[godot-project-hygiene]]"   # addons/ and .gdignore conventions this builds on
  - relates-to: "[[godot-asset-source-import-organization]]"   # uid and .import behaviour when files move
  - relates-to: "[[game-studio-versioning-and-changelog]]"   # SemVer and changelog format for module releases
  - relates-to: "[[game-studio-third-party-addon-knowledge]]"   # consuming addons with pinned versions
  - relates-to: "[[autoload-singletons]]"   # modules that register an autoload
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** engine facts come from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited sources). The packaging rules in "Steps" that go beyond those pages (prefixing, no-game-dependency rule, CHANGELOG) are **our conventions**, marked *(convention)*. Nothing was run in the engine. Status `proposed`.

## Goal
Package a piece of gameplay or tooling (a save service, an input layer, a UI kit) so that it can be lifted out of one project and dropped into another without edits, and optionally published on the Asset Library.

## Prerequisites
- [[godot-project-hygiene]] — `addons/` is the documented home for third-party content "even if they aren't editor plugins"; `.gdignore` hides a folder from import.
- Decide whether the module needs the **editor** (docks, inspectors, custom import) or only the **runtime**. Only the first is an *editor plugin*.

## Steps
1. **Lay it out under `addons/<module_name>/`.** The docs call `addons/asset_name/` common practice that avoids file clashes, and installers merge a ZIP's `addons/` folder into the target project. Keep everything the module needs (scenes, scripts, textures, shaders, a `README.md`, `LICENSE`) inside that one folder *(the licence-in-folder part is an Asset Library recommendation)*.
2. **Add `plugin.cfg` only for editor plugins.** A `plugin.cfg` under `addons/` is exactly how Godot recognises an editor plugin; the file is `[plugin]` with `name`, `description`, `author`, `version`, `script`. The script must be `@tool` and extend `EditorPlugin`, with `_enter_tree()`/`_exit_tree()`; every other script the editor executes must be `@tool` too, or it behaves as an empty file. A **runtime-only library needs no `plugin.cfg` and no enabling** — "extract the files into your project folder" is the documented install.
3. **Prefix global names** *(convention)*. `class_name` registrations are project-global, so use a module prefix (`MyKitSaveService`, `MyKitInputLayer`) to avoid clashes when two modules meet in one project. Prefer `class_name` over `add_custom_type` for custom nodes — the 4.7 plugin tutorial registers custom nodes with `class_name`.
4. **Depend inward only** *(convention)*. Nothing inside `addons/<module>/` may `preload`/`load` or reference `res://` paths outside the folder, use a game autoload by name, or assume a group name. Expose configuration through `@export` properties, signals, and injected references (the scene-organization page's dependency-injection options). A quick check: `rg "res://" addons/<module>/` should only show paths inside the module.
5. **Version and log it** *(convention; Asset Library suggests SemVer)*. Put the version in `plugin.cfg` (editor plugins) or in a `VERSION`/`README` line (runtime libraries), keep a `CHANGELOG.md` following [[game-studio-versioning-and-changelog]], and tag releases; the Asset Library pulls one engine version per entry and re-reads on every download-URL change.
6. **Ship licence and readme** — the Asset Library *requires* `LICENSE`/`LICENSE.md` with licence text, copyright holder and years, matching the licence chosen on the site, and recommends a copy inside the plugin folder.
7. **Extract into another project:** copy `addons/<module>/` (including every `.uid` and `.import` sibling) into the target `addons/`, open the editor so it imports, then — editor plugins only — Project > Project Settings > Plugins > Enable (no restart needed). Install from a ZIP by merging its `addons/` folder.
8. **Autoloads from a module:** register them from the plugin (`add_autoload_singleton(name, "res://addons/<module>/x.tscn")` in `_enable_plugin()`, `remove_autoload_singleton()` in `_disable_plugin()`); a runtime-only library cannot register one, so document the manual Project Settings > Globals > Autoload step in its README *(convention)*.
9. **If publishing:** fix script warnings, follow the style guide, add `.gitignore` and `.gitattributes export-ignore`, screenshots in a `.gdignore` folder, a square ≥128 px icon via direct link, plain-text description; no required submodules (GitHub ZIPs omit them).

## Notes & pitfalls
- **`.uid` files:** scripts and shaders have sibling `.uid` files (4.4+); copy them with the module, otherwise scenes that reference the scripts by UID re-resolve or break. Commit them.
- **Forgetting to enable** an editor plugin is the top support question; runtime libraries never need enabling, and "plugin" repositories on GitHub are often runtime libraries.
- **Case sensitivity:** the PCK filesystem is case-sensitive; keep module paths `snake_case` so an export on Linux matches a Windows-authored reference.
- **`.gdignore`** inside the module hides a folder from import *and* from `load()` — useful for docs/screenshots, fatal for assets.
- **Hidden coupling** via `get_node("/root/Game")` or group names passes the editor but fails in the next project; the configuration-warning hook (`_get_configuration_warnings()`) in a `@tool` script is the documented way to surface missing injections.
- **Asset Library entries are per engine version**; a 4.7 module needs a separate entry for a later major.
- Not on the pages read (*unverified*): whether `plugin.cfg` accepts extra keys, and whether disabled plugins' scripts are still parsed at project load.

## See also
- [[godot-project-hygiene]] — `addons/` and `.gdignore` conventions
- [[godot-asset-source-import-organization]] — uid and .import behaviour when files move
- [[game-studio-versioning-and-changelog]] — SemVer and changelog format for module releases
- [[game-studio-third-party-addon-knowledge]] — consuming addons with pinned versions
- [[autoload-singletons]] — modules that register an autoload

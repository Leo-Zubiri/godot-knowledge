---
id: godot-config-driven-tunables
type: pattern
domain: godot
status: unreviewed
summary: "A taxonomy for where a tunable value lives in a Godot 4.7 project: engine settings in ProjectSettings (with feature-tag overrides and override.cfg), gameplay tuning in typed custom Resources loaded by one service, player settings in a ConfigFile under user://, developer overrides in a gitignored cfg, true constants in code."
aliases: [tunables, game balance data, config taxonomy, override.cfg, custom resource tuning, ConfigFile settings]
tags: [dept/game-dev, dept/design, tool/godot]
sources:
  - claim: "ProjectSettings custom settings, override.cfg, feature-tag overrides, save vs save_custom; Resource caching, duplication and changed signal; ConfigFile API"
    ref: src-gd-projectsettings-configfile-resources
    retrieved: 2026-11-08
  - claim: "Resources are shared by path and must be duplicated or made local to scene to avoid leaking mutations"
    ref: src-gd-scene-resources-saving
    retrieved: 2026-11-08
  - claim: "CACHE_MODE_REPLACE refreshes a cached resource's data in place, which enables reloading tuning files"
    ref: src-gd-background-loading-resourceloader
    retrieved: 2026-11-08
related:
  - depends-on: "[[godot-resource-sharing-and-duplication]]"   # the shared-mutation hazard this taxonomy must respect
  - relates-to: "[[godot-build-metadata-and-feature-tags]]"   # feature tags used by the overrides
  - relates-to: "[[godot-save-game-serialization]]"   # player progress is a save, not a setting
  - relates-to: "[[node-vs-resource-vs-autoload]]"   # where the loading service lives
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status — interpretation.** This is a **design pattern we propose**, not engine doctrine. The API facts (settings paths, class names, method behaviour) come from the official Godot 4.7 documentation (retrieved 2026-11-08, paraphrased extractions — see the cited sources); the taxonomy, the rules of thumb and the service shape are **our interpretation** and have not been exercised in the engine. Status `unreviewed`.

## Problem
Values that someone will want to change (gravity, prices, durations, colours, volume) end up scattered across scripts, exported node properties, `project.godot` and ad-hoc JSON. Nobody knows which copy wins, designers edit code, and a debug tweak leaks into a release.

## Solution *(interpretation)*
Sort each value by **who changes it and when**, then give each class one home:

| Class | Who / when | Home | Engine facts used |
|---|---|---|---|
| **Engine settings** (physics tick, stretch mode, input emulation, renderer) | engineer, build time | `project.godot` via Project Settings; **per-platform/build variants as feature-tag overrides** (`section/key.android`, `.debug`); read with `ProjectSettings.get_setting_with_override()` | plain `get_setting()` ignores tags; override form is `key.tag = value` in `project.godot` |
| **Gameplay tuning** (speeds, prices, timings, balance tables) | designer, iteratively | typed **custom Resources** (`class_name XTuning extends Resource` with `@export_range` fields) saved as `.tres` under one folder, loaded by **one** service node/autoload that hands out references | `.tres` is text and version-control friendly; the Inspector edits named Resource classes; a path loads once and is shared |
| **Player settings** (volume, language, key binds, accessibility) | player, at runtime | `ConfigFile` at `user://settings.cfg`, written by the same service on change | `set_value`/`get_value(section, key, default)`, `save()`; in-memory until saved |
| **Developer overrides** (god mode, start level, LAN port) | one developer, locally | a **gitignored** `user://dev.cfg` (ConfigFile) read only in debug builds (`OS.has_feature("debug")`), or `override.cfg` beside the project/binary for engine settings | `override.cfg` in the project root overrides any project setting and works next to an exported binary |
| **True constants** (physics layer bits, action names, state enum) | nobody | `const` / `enum` in code | — |

**The service.** One autoload (`Tunables`) owns loading: `preload("res://tuning/movement.tres") as MovementTuning`, exposes typed getters, and emits `reloaded`. In debug builds it can re-read a tuning file with `ResourceLoader.load(path, "", ResourceLoader.CACHE_MODE_REPLACE)` so the already-shared instance is refreshed in place and every holder sees new values without re-fetching; outside debug this path is compiled out.

**Custom project settings for modules.** A module that needs an engine-level knob registers it from an EditorPlugin: `ProjectSettings.set_setting("addons/my_module/port", 7000)`, `set_initial_value(...)`, `add_property_info({...})`, optionally `set_as_internal()`; runtime code reads it with `get_setting("addons/my_module/port", 7000)` (a default is mandatory because the setting may not exist in a project that never opened the editor plugin).

## Rules of thumb *(interpretation)*
- If a designer should change it without a programmer, it is **not** a `const` and not an exported property buried in a scene: put it in a tuning Resource.
- If it differs per platform or build, it is a **feature-tag override**, not an `if OS.get_name()` branch.
- If it must survive reinstall but not ship with the game, it is **`user://`**, never `res://` (read-only in exports).
- One reader per class: nodes receive values through the service or through `@export var tuning: MovementTuning`, never by reading files themselves.
- Keep a **schema version** field in each tuning Resource and in the ConfigFile so migrations are explicit.

## Pitfalls
- **Shared Resource mutation:** a tuning `.tres` loaded by path is one shared instance; writing `tuning.speed += 1` from a node changes it for everyone, and a shallow `duplicate()` still shares nested Arrays/Dictionaries/Resources. Treat tuning Resources as read-only at runtime, or `duplicate(true)`/`resource_local_to_scene` for per-instance copies — see [[godot-resource-sharing-and-duplication]].
- **`changed` does not fire for custom properties** unless your setter calls `emit_changed()`; listeners that rely on it silently stay stale.
- **`ProjectSettings.save()` rewrites `project.godot`** and is meant for editor plugins; in an exported game use `save_custom("override.cfg")` or a ConfigFile in `user://`.
- **`get_setting()` ignores overrides** — code that reads settings at runtime must use `get_setting_with_override()` or the Android/debug variant is never applied.
- **Custom feature tags only exist in exports**; running from the editor sees `editor`/`debug`, so test tag-dependent overrides in an exported build.
- `ConfigFile` section and key names cannot contain spaces; `;` comments are lost on save; inner classes do not serialise in Resources.
- Not on the pages read (*unverified*): precedence when several tag overrides match one setting, and whether `override.cfg` is re-read after `save_custom()` without a restart.

## See also
- [[godot-resource-sharing-and-duplication]] — the shared-mutation hazard this taxonomy must respect
- [[godot-build-metadata-and-feature-tags]] — feature tags used by the overrides
- [[godot-save-game-serialization]] — player progress is a save, not a setting
- [[node-vs-resource-vs-autoload]] — where the loading service lives

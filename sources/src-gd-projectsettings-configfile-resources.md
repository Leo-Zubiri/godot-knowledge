---
id: src-gd-projectsettings-configfile-resources
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/4.7/classes/class_projectsettings.html"
  urls:
    - "https://docs.godotengine.org/en/4.7/classes/class_projectsettings.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/export/feature_tags.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/scripting/resources.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_resource.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_configfile.html"
  title: "Godot 4.7: ProjectSettings (custom settings, override.cfg, feature-tag overrides, save), Feature tags, Resources tutorial, Resource class, ConfigFile class"
  retrieved: 2026-11-08
  version: "4.7 (page headers: Godot Engine 4.7 documentation in English)"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); the ProjectSettings page (742k chars) was read in chunks; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot 4.7 documentation pages fetched on 2026-11-08 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**. Every page reported the header *Godot Engine 4.7 documentation*. Nothing was run in the engine. Re-fetch before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

- **ProjectSettings (class):** "Stores variables that can be accessed from everywhere"; `get_setting(name, default=null)` (ignores feature overrides), `set_setting(name, value)` (`null` erases a custom setting), `has_setting(name)` (custom settings must be defined with `set_setting()` or exist in `project.godot`), `get_setting_with_override(name)` (applies matching feature-tag overrides, e.g. `"application/config/name.windows"` on Windows). "Any project setting can be overridden by creating a file named `override.cfg` in the project's root directory"; overrides can also be written with `ConfigFile`; exported projects can use the file next to the binary; overrides still respect the base settings' feature tags. `add_property_info(hint: Dictionary)` with `"name"`, `"type"`, optional `"hint"`, `"hint_string"` (usage not supported — use `set_as_basic()`, `set_restart_if_changed()`, `set_as_internal()`); example: `ProjectSettings.set("category/property_name", 0)` then `add_property_info({"name": "category/property_name", "type": TYPE_INT, "hint": PROPERTY_HINT_ENUM, "hint_string": "one,two,three"})`. `set_initial_value(name, value)` (the revert value; values equal to the default are not saved; the example defines `addons/my_setting` = 10.0 from an EditorPlugin and notes runtime code needs similar handling). `set_as_internal(name, internal)` hides a setting from the dialog ("mainly useful for addons that store their own settings"). `set_as_basic`, `set_order`, `set_restart_if_changed` (display hint only). **`save()` writes `project.godot`** — "meant for editor plugins, since modified settings can't be reloaded by the running app"; exported projects should use `save_custom(file)` with `.godot` (text), `.binary`, or an `override.cfg` ("works in exported projects"). `globalize_path()` (`res://`/`user://` → OS path; not for `res://` in exports), `localize_path()`, `load_resource_pack(pack, replace_files=true, offset=0)`, `get_global_class_list()`. Default pointing settings and `physics/common/*` values recorded in sibling sources.
- **Feature tags:** default tags (case-sensitive) by platform (`android`, `linux`, `macos`, `ios`, `windows`, `mobile`, `pc`, `web`, …), build type (`debug`, `release`, `editor`, `editor_hint`, `editor_runtime`, `template`, `double`, `single`, `threads`, `nothreads`), architecture (`64`, `32`, `x86_64`, `arm64`, …), texture compression (`etc`, `etc2`, `s3tc`), special modes (`movie`, `shader_baker`, `dedicated_server`). Custom tags are added in the export preset and apply only to exported builds (not when running from the editor; not in EditorExportPlugin scripts). `OS.has_feature(name)`. **Overriding project settings with feature tags:** in Project Settings pick a configuration and a feature tag to add an override; the stored form is e.g.
  ```
  [section]
  subsection/example = "Release"
  subsection/example.debug = "Debug"
  ```
  `ProjectSettings.get_setting("section/subsection/example")` returns `"Release"` regardless of build; `get_setting_with_override(...)` returns `"Debug"` on a debug build; plain `get_setting`/`get` ignore feature tags by default. The page has no statement about evaluation order of several overrides (unverified).
- **Resources (tutorial):** a Resource is a data container; nodes supply behaviour, resources hold data; anything saved/loaded from disk is a resource. The engine loads a resource from disk once; loading the same path again returns the same copy; `load()` at runtime, `preload()` at parse time (constant path). Custom resources: `class_name` + `extends Resource` + `@export` properties; the Inspector creates and edits them (Create Resource dialog shows only named classes); C# uses `[GlobalClass]`/`[Export]`. `ResourceSaver.save(my_res, "res://my_res.tres")`; `.tres` is text (version-control friendly), exported as binary `.res`. Warning: inner classes do not serialise correctly because resource files store the script path.
- **Resource (class):** "Base class for serializable objects"; reference-counted, nestable, saveable. `resource_local_to_scene` (duplicated per scene instance so runtime changes do not leak; no effect on existing duplicates), `resource_path`, `resource_name`, `resource_scene_unique_id`. `duplicate(deep=false)`: shallow copy shares nested Arrays, Dictionaries and Resources; deep copies containers recursively but duplicates only *local* nested resources; `duplicate_deep(mode)` with `DEEP_DUPLICATE_NONE` 0, `DEEP_DUPLICATE_INTERNAL` 1 (default), `DEEP_DUPLICATE_ALL` 2. `emit_changed()`; `changed` is **not** emitted automatically for custom resource properties — a setter must emit it. `take_over_path(path)` overrides the cache entry. Resources are cached globally by path, removed when all references are released.
- **ConfigFile (class):** INI-style helper storing Variants by section and key; in-memory until `save()`. Example:
  ```
  [section]
  some_key=42
  string_example="Hello World3D!"
  a_vector=Vector3(1, 0, 2)
  ```
  `load(path)` / `save(path)` return `Error`; `set_value(section, key, value)` (`null` deletes the key, and the section if empty); `get_value(section, key, default=null)` (error if missing and no default); `has_section`, `has_section_key`, `get_sections`, `get_section_keys`, `erase_section`, `erase_section_key`, `clear`, `parse(data)`, `encode_to_text()`; `load_encrypted`/`save_encrypted` (AES-256 key) and `_pass` variants (password). Section and key names cannot contain spaces; `;` comments are lost on save; the file extension does not affect formatting. No object-deserialisation warning was found on this page (unverified; the FileAccess warning is preserved in `src-gd-scene-resources-saving`).

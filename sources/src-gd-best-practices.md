---
id: src-gd-best-practices
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/best_practices/scene_organization.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/best_practices/scene_organization.html"
    - "https://docs.godotengine.org/en/stable/tutorials/best_practices/godot_interfaces.html"
    - "https://docs.godotengine.org/en/stable/tutorials/best_practices/data_preferences.html"
    - "https://docs.godotengine.org/en/stable/tutorials/best_practices/logic_preferences.html"
    - "https://docs.godotengine.org/en/stable/tutorials/best_practices/version_control_systems.html"
    - "https://docs.godotengine.org/en/stable/tutorials/best_practices/project_organization.html"
  title: "Godot 4.7 best practices: scene organization, interfaces, data and logic preferences, version control, project organization"
  retrieved: 2026-11-08
  version: "4.7 (headers reported by subagent); data_preferences carries a not-updated-for-4.7 notice"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot documentation pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. **Version:** page headers say *Godot Engine 4.7 documentation* — confirmed by the main agent on the pages listed under "re-read", reported by research subagents for the others; pages carrying their own "may be outdated for 4.7" notice are flagged. Documentation only: nothing here was run in the engine, so behaviour claims are *documented*, not *experimentally validated*. Re-fetch before promoting dependent notes to `verified`.

- **Scene organization:** scenes should be self-contained; supply external context from the parent. Options in order of safety: signals (safest), method calls or Callable properties, then node references/NodePaths. Parent–child should mean removing the parent removes the child; otherwise use siblings with a common ancestor mediating. A tool script with `_get_configuration_warnings()` lets the editor flag unmet dependencies. Suggested layout: a Main node with a World node and a GUI Control node. To stop transform inheritance use `top_level` or an intermediate Node; `RemoteTransform`/`RemoteTransform2D` make separated nodes follow a target. Autoloads suit systems that track their own data and work in isolation; systems that modify other systems' data should be scenes or scripts.
- **Interfaces:** lookup cost order `get_node()` slowest, `$Child` faster, cache with `@onready`. An exported `Node` property survives moving the node in the Scene dock. `load()`/`preload()` return the cached instance, so use `duplicate()` or `new()` for a separate object. Duck typing via `has_method()`, `is`, `is_in_group()`, Callables. Asserts are stripped in release exports. A `_set`/`_get` pair without a matching `_get_property_list` entry works with `set()`/`get()` but fails with symbol access. In C# there is no dynamic symbol access and C# interfaces cannot be assigned in the editor.
- **Data preferences (page says it has not been updated for 4.7 and may be outdated):** arrays suit iteration/indexing (front/middle insertion slow, value search slowest); dictionaries suit key lookup and keep insertion order; objects add lookup overhead; enums as integers are faster, string enums only via `@export_enum`.
- **Logic preferences:** set node properties before adding the node to the tree (some setters run slow update code; exceptions such as global position need the node in the tree); `preload` for constants with fixed paths, `load()` or `@export` for resources that may change or be unloaded; static levels suit small games, dynamic loading adds complexity. Cyclic references: not covered by the page content received.
- **Version control:** ignore `.godot/` and `*.translation`; Project > Version Control > Generate Version Control Metadata creates `.gitignore`/`.gitattributes`; on Windows set `core.autocrlf` to `input`; set up Git LFS before committing large files and install it on every machine; the 4.1+ ignore list differs from 3.x/4.0; older versions may store credentials in `export_presets.cfg`.
- **Project organization:** lowercase snake_case for folders and files (C# scripts follow PascalCase class names), PascalCase node names; case mismatches can break exported PCKs; third-party content in a top-level `addons/` folder; an empty `.gdignore` stops import of a folder and ignored resources cannot be loaded by `load()`/`preload()`.
- The autoloads-versus-internal-nodes best-practice page returned 404 (content already covered by existing autoload notes).

---
id: src-gd-architecture-autoloads-plugins-cli
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/best_practices/scene_organization.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/best_practices/scene_organization.html"
    - "https://docs.godotengine.org/en/stable/tutorials/best_practices/autoloads_versus_regular_nodes.html"
    - "https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html"
    - "https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html"
    - "https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html"
    - "https://docs.godotengine.org/en/stable/tutorials/plugins/editor/making_plugins.html"
    - "https://docs.godotengine.org/en/stable/tutorials/editor/command_line_tutorial.html"
    - "https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html"
    - "https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/c_sharp_style_guide.html"
  title: "Godot 4.7: scene organization, autoloads vs regular nodes, resources, plugin layout, command-line options relevant to project tooling"
  retrieved: 2026-11-08
  version: "godot-docs branch 4.7 RST"
  capture: paraphrased
  retrieved_via: "curl of RST files, read by the main agent (partial reads by search and sections)"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** the reStructuredText sources of the Godot manual (branch `4.7` of godot-docs) and engine files at tag `4.7-stable` were downloaded with curl and read by the main agent on 2026-11-08; the points below are the agent's paraphrase, not verbatim. These are the sources of the published pages (stable URLs listed in `urls`), not the rendered pages. Re-read before promoting dependent notes to `verified`.

- **Scene organization (best practices):** a game should have an entry point, a Main node; the sample tree is Main > World (2D/3D) and GUI; changing levels swaps World's children; each subsystem gets its own section of the tree; parent-child only when removing the parent should reasonably remove the child, otherwise siblings (RemoteTransform nodes can position siblings); a system that tracks its own data, should be globally accessible and exists in isolation may be an autoload, systems that modify other systems' data should be scripts or scenes; the page presents the tree as "a sample of a decent structure" if unsure and cites SOLID, DRY, KISS and YAGNI. Smaller games may use a simple "Game" singleton that calls `SceneTree.change_scene_to_file()`.
- **Autoloads versus regular nodes:** autoloaded nodes are not freed on scene change; the manager-class example (a global `Sound` pool) is criticised for global state, global access (the domain to explore for a bug spans the whole project) and global resource allocation; alternatives: a `class_name` node per scene, a custom `Resource` for shared data, data on an object reachable through `owner`, `static func` and (since 4.1) `static var`; autoloads suit systems with wide scope that manage their own information (quest, dialogue); an autoload is not necessarily a singleton and is reachable at `/root/<Name>`. Singletons page: set in Project Settings > Globals > Autoload; do not remove autoloads with `free()`/`queue_free()`.
- **Resources:** external (own file) versus built-in (inside the `.tscn`/`.scn`); saving with a path makes it external, clearing the path makes it built-in; `.tres` is text for VCS and exported as binary `.res`; resource files store the path of their script, so an inner class cannot be a resource script.
- **Plugins:** an editor plugin lives in `addons/<plugin_name>/` with a `plugin.cfg` (INI metadata) and a tool script; repositories called "plugins" without a `plugin.cfg` in an `addons/` folder are not editor plugins and are simply extracted into the project; the Asset Library or GitHub releases are the install routes; enable in Project Settings > Plugins; plugins can register autoloads in their own folder.
- **Command line (relevant options):** `--path`, `--headless`, `--import` (start the editor, wait for import, quit), `--export-release|--export-debug <preset> <path>` (preset names from `export_presets.cfg`), `--export-pack`, `--export-patch`, `--script` with `--check-only`, `--scene` (path or UID); headless export is required on machines without GPU access.
- **Style guides:** the GDScript and C# style guides define naming and member order (convention, not engine-enforced); see the existing hygiene note for the summary.

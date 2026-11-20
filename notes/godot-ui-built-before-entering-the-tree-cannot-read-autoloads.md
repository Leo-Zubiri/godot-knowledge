---
id: godot-ui-built-before-entering-the-tree-cannot-read-autoloads
type: pitfall
domain: godot
status: unreviewed
summary: "A UI node whose `setup()` builds its children before being added to the tree cannot call `get_node_or_null('/root/Settings')` — it returns null, so a setting read there silently falls back to its default (a HUD-scale test saw 1.25 instead of 1.6). Read autoloads through `(Engine.get_main_loop() as SceneTree).root.get_node_or_null('Settings')`, or defer the read to `_ready()`. Related Godot 4 gotchas met in the same session: assigning an untyped `[x]` literal to an `Array[int]` member is a runtime error that breaks every test; a new `class_name` file needs `make import` before the script checker sees it; `Engine.time_scale` must be restored on `_exit_tree` or a crashed test leaves the whole suite in slow motion."
aliases: [get_node_or_null root before tree, autoload not found in setup, typed array literal runtime error, time_scale restore]
tags: [dept/engineering, tool/godot]
applies-to:
  min: "Godot 4.0"
  tested: "Ginomo: hud_scale test; slowmo exit_tree test"
sources: []
related:
  - relates-to: "[[godot-gdscript-lambdas-capture-primitives-by-value]]"
created: 2026-11-20
updated: 2026-11-20
created_by_type: agent
---

> **Evidence status — `unreviewed`.** Built and tested in Ginomo (Godot 4.7.2); not checked against engine source.

## Fix
```gdscript
func _settings() -> Node:
    var loop := Engine.get_main_loop()
    return (loop as SceneTree).root.get_node_or_null("Settings") if loop is SceneTree else null
```
Prefer this over reading in `_ready()` when children are built in `setup()` (the sizes are needed at build time).

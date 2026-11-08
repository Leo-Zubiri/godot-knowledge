---
id: src-gd-static-typing
type: source
domain: godot
source:
  url: https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/static_typing.html
  title: "Static typing in GDScript — Godot Engine 4.7 documentation"
  retrieved: 2026-11-06
  version: "4.7"
  capture: paraphrased
created: 2026-11-06
updated: 2026-11-06
---

> Preserved as a pinned reference to the official Godot 4.7 documentation page (conventionally immutable). Key points
> relied on by notes are summarised below; see the URL for the full original.

Official page: **Static typing in GDScript** (Godot 4.7).

Key points (as documented on the page):
- Types can be declared on variables, constants, function parameters, and return values.
- **Explicit** form: `var health: int = 0`, `func heal(amount: int) -> void:`.
- **Inferred** form with `:=` : `var speed := 10.0` (type inferred from the assigned value).
- **Typed arrays**: `var enemies: Array[Enemy] = []`.
- Stated benefits: editor autocompletion, **errors detected at compile time** (before running), and optimized
  (faster) execution paths for typed code.
- Caveat noted on the page: the `as` keyword used for casting yields `null` at runtime on a type mismatch rather than
  raising an error.

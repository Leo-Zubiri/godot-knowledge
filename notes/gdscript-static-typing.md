---
id: gdscript-static-typing
type: reference
domain: godot
status: proposed
summary: How to add static types to GDScript (explicit and inferred), and why — autocompletion, compile-time errors, and faster execution.
aliases: [static typing, type hints, type inference, typed gdscript]
applies-to:
  min: "4.0"
  tested: "4.7.2"
sources:
  - claim: "GDScript supports explicit and inferred (`:=`) static types on vars/consts/params/returns and typed arrays; benefits are autocompletion, compile-time error detection, and optimized execution; `as` casting yields null on mismatch."
    ref: src-gd-static-typing
    retrieved: 2026-11-06
    version: "4.7"
related:
  - relates-to: "[[node-lifecycle-callbacks]]"   # typed signatures on lifecycle callbacks (-> void) are idiomatic
created: 2026-11-06
updated: 2026-11-06
created_by_type: agent
---

## Overview
GDScript is dynamically typed by default but supports **optional static typing**. Adding types gives you editor
autocompletion, **errors caught at parse/compile time** instead of at runtime, and lets the engine use optimized
execution paths. This reference summarises the forms and trade-offs for **Godot 4.7**.

## Declaring types (explicit)
```gdscript
var health: int = 100
const MAX_SPEED: float = 300.0
func take_damage(amount: int) -> void:
    health -= amount
```

## Inferred types (`:=`)
When the type is obvious from the right-hand side, infer it:
```gdscript
var speed := 300.0        # inferred as float
var name := "player"      # inferred as String
```

## Typed collections
```gdscript
var enemies: Array[Enemy] = []
```

## Why use it
- **Tooling:** autocompletion and better editor warnings.
- **Safety:** many mistakes become **compile-time** errors (before the game runs).
- **Performance:** typed code can use faster, specialized opcodes.

## Caveats
- The `as` cast returns `null` at runtime on a type mismatch rather than raising — guard casts where it matters.
- Typing is **optional and gradual**; you can type the hot/critical paths first.

> `applies-to`: checked against **Godot 4.7.2**. The feature exists since 4.0 (typed `for`-loop element typing since
> 4.2). Do not generalize exact syntax to Godot 3.x.

## See also
- [[gdscript-signals]] — typed signal handlers (`-> void`) are idiomatic
- [[godot-version-policy]] — how this repo scopes version-dependent claims
- [[node-lifecycle-callbacks]] — typed signatures on lifecycle callbacks (-> void) are idiomatic

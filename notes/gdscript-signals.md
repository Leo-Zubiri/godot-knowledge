---
id: gdscript-signals
type: concept
domain: godot
status: proposed
summary: Signals let a node notify listeners without holding a reference to them — Godot's primary decoupling mechanism (observer pattern).
aliases: [signal, emit, connect, observer]
sources:
  - claim: "Signals notify listeners without a direct reference; declared with `signal`, emitted with `.emit()`, connected with a Callable via `.connect()`; flags include CONNECT_ONE_SHOT/CONNECT_DEFERRED; a signal can be awaited once with `await`."
    ref: src-gd-signals
    retrieved: 2026-11-06
    version: "4.7"
related:
  - relates-to: "[[node-lifecycle-callbacks]]"   # signal connections are typically wired up in _ready()
  - relates-to: "[[autoload-singletons]]"        # a common decoupled alternative to reaching into globals
created: 2026-11-06
updated: 2026-11-06
created_by_type: agent
---

## Summary
A **signal** lets an emitting object announce that something happened; any number of listeners can react **without the
emitter holding a reference to them**. This is Godot's built-in observer pattern and its main tool for keeping nodes
loosely coupled.

## Explanation
Declare a custom signal with the `signal` keyword, optionally with arguments:

```gdscript
signal health_changed(new_value: int)
```

Emit it when the event occurs, and connect a listener with a **Callable** (Godot 4 / GDScript 2):

```gdscript
# emitter
health_changed.emit(current_health)

# listener (e.g. in _ready)
emitter.health_changed.connect(_on_health_changed)

func _on_health_changed(new_value: int) -> void:
    update_health_bar(new_value)
```

`Object.connect(callable, flags)` accepts flags such as `CONNECT_ONE_SHOT` (auto-disconnect after the first emission)
and `CONNECT_DEFERRED` (deliver during idle time). To wait for a single emission inline, use `await emitter.signal_name`.

Prefer signals over having a node reach **up** the tree to call a parent directly ("call down, signal up"): the child
emits, the parent decides what to do, and the child stays reusable. See the cited source for the official treatment.

> `applies-to`: verified wording is for **Godot 4.7**; the Callable-based `.connect`/`.emit` syntax is Godot 4 and
> differs from Godot 3 — do not assume this carries to 3.x.

## See also
- [[node-lifecycle-callbacks]] — where connections are usually established
- [[autoload-singletons]] — when shared state is the real need instead of an event

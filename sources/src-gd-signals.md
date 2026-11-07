---
id: src-gd-signals
type: source
domain: godot
source:
  url: https://docs.godotengine.org/en/4.7/getting_started/step_by_step/signals.html
  title: "Using signals — Godot Engine 4.7 documentation"
  retrieved: 2026-11-06
  version: "4.7"
created: 2026-11-06
updated: 2026-11-06
---

> Preserved as a pinned reference to the official Godot 4.7 documentation (conventionally immutable). See also the
> `Object` class reference for `connect()` and the connect flags. Full original at the URL.

Official page: **Using signals** (Godot 4.7), plus `Object.connect()` in the class reference
(https://docs.godotengine.org/en/4.7/classes/class_object.html).

Key points (as documented):
- Signals let an emitting object notify listeners **without needing a direct reference** to them (an implementation of
  the observer pattern) — this is Godot's primary decoupling mechanism between nodes.
- Custom signals are declared with the `signal` keyword: `signal health_changed(new_value)`.
- In GDScript 2 (Godot 4), signals are emitted with `health_changed.emit(value)` and connected with a **Callable**:
  `health_changed.connect(_on_health_changed)`.
- `Object.connect(callable, flags)` accepts connection flags, including `CONNECT_ONE_SHOT` (disconnect after first
  emission) and `CONNECT_DEFERRED` (deliver at idle time).
- A signal can also be awaited once with `await node.signal_name`.

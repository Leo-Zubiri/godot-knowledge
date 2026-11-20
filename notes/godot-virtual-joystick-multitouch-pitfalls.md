---
id: godot-virtual-joystick-multitouch-pitfalls
type: pitfall
domain: godot
status: unreviewed
summary: "A touch joystick in Godot 4 needs its OWN finger: remember the pointer index of the press, ignore every other index (a second finger on the screen must not move or release it), release when the control is hidden with the finger down (visibility change gives no touch-up), rescale the dead zone so the value starts at 0 just past it (no jump), accept the left mouse button only for testing, and keep the logic in a public `handle_pointer` over a normalised pointer event so it is unit-testable without a display. Looking around = dragging on the rest of the screen frees the other thumb for action buttons; with `emulate_mouse_from_touch=false` controls receive only touch events."
aliases: [virtual joystick, touch joystick, multitouch, android controls godot, gui_input touch index]
tags: [dept/engineering, scope/input, scope/mobile]
applies-to:
  min: "Godot 4.0"
  tested: "Ginomo: GnVirtualJoystick, 5 unit tests; not yet tried on a physical phone"
sources: []
related:
  []
created: 2026-11-20
updated: 2026-11-20
created_by_type: agent
---

> **Evidence status — `unreviewed`.** Built and tested in Ginomo (Godot 4.7.2, headless gdUnit4 + xvfb screenshots); not checked against engine source.

## Checklist
- Press: `pointer = event.index`, active = true; Move/Up: only if `event.index == pointer`.
- `NOTIFICATION_VISIBILITY_CHANGED` and not visible → `release()` (also emits value 0 so the game stops walking).
- Output `Vector2` in [-1, 1], screen-down positive; the consumer decides "forward = −y".
- Dead zone: `v = v.normalized() * ((len - dz) / (1 - dz))`.
- Real-device checklist still pending: thumb overlap with the look-drag area, safe areas, latency.

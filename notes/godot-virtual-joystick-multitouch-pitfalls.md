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
- **A finger held on a UI button must not count for pinch-zoom.** If your gesture layer treats "two fingers down" as a pinch, a thumb holding a "charge/throw" button turns the next finger (meant to aim or look) into a zoom, so the player cannot aim while charging. Let the button panel expose `owns_finger(index)` and have the gesture layer ignore those indices; also emit the held finger's drag (`ScreenDrag.relative`) so one thumb can charge **and** aim. Same for desktop: while the left mouse button is held to charge, mouse motion should keep aiming. (Found in Ginomo 2026-11-25; covered by `tests/integration/test_pool_touch.gd`.)
- **Cancelling a charged/aimed action on touch: a separate, deliberate drop zone.** Drag-to-aim, release-to-commit games give the player a cancel target: e.g. Pokémon UNITE lets you drag the aim onto a large X in a corner and release there to cancel (confirmed by a game guide; other titles use similar zones, not verified). When the same finger also aims, the zone must be a fixed place, not "any direction": a floating X ~240 units above the held button (clear of the button's own edge, and with a ~14-unit finger margin), highlighted red + a short haptic when entered, aiming paused while over it, and "release over X = cancel" resolved on the touch-up position. Keep the old tap-X for two-handed play. Do not place the X adjacent to the held button: its forgiving margin then overlaps the button and cancels by accident. The glyph "✕" (U+2715) is missing from many UI fonts and renders as a broken box; use "×" (U+00D7) or an icon.

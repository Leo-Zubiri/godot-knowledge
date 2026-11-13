---
id: godot-touch-input-and-virtualjoystick
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 touch input: VirtualJoystick modes and actions, TouchScreenButton with passby_press, screen touch/drag events, the two pointing emulation settings, and how to keep gameplay code device-agnostic through InputMap actions."
aliases: [virtual joystick, touchscreen button, touch controls, emulate touch from mouse, InputEventScreenTouch]
tags: [dept/game-dev, tool/godot]
applies-to:
  min: "4.0 (VirtualJoystick: version of introduction not stated on the page; present in 4.7)"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "VirtualJoystick, TouchScreenButton, InputEventScreenTouch/Drag, InputEventAction class pages, input tutorials and pointing settings for Godot 4.7"
    ref: src-gd-touch-input-virtualjoystick
    retrieved: 2026-11-08
related:
  - depends-on: "[[input-handling]]"   # actions and polling are the base this builds on
  - relates-to: "[[godot-screen-reader-and-input-remapping]]"   # runtime remapping of the same actions
  - relates-to: "[[godot-ui-focus-and-gamepad-navigation]]"   # menus still need focus handling on non-touch devices
created: 2026-11-08
updated: 2026-11-12
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.

## Overview
Touch input in Godot arrives as `InputEventScreenTouch` (press/release per finger) and `InputEventScreenDrag` (motion per finger), and two built-in nodes turn touches into **InputMap actions**: `VirtualJoystick` and `TouchScreenButton`. Because both emit actions, gameplay code that polls `Input.is_action_pressed()` / `Input.get_vector()` or checks `event.is_action_pressed()` never needs to know whether a key, a gamepad or a finger produced the input.

## VirtualJoystick (Control)
- **Actions:** `action_up/down/left/right` (defaults `ui_up`…). Point them at your own movement actions (e.g. `move_up`) so the joystick drives the same `Input.get_vector("move_left","move_right","move_up","move_down")` that keyboard and gamepad use.
- **Modes (`joystick_mode`):** `JOYSTICK_FIXED` (stays put), `JOYSTICK_DYNAMIC` (jumps to the first touch inside its bounds, returns on release), `JOYSTICK_FOLLOWING` (dynamic, and the base follows a finger that leaves its range).
- **Visibility (`visibility_mode`):** `VISIBILITY_ALWAYS` or `VISIBILITY_WHEN_TOUCHED`. There is no "touchscreen only" mode on this node (that exists on `TouchScreenButton`); hide it yourself on desktop (e.g. `visible = DisplayServer.is_touchscreen_available()` — the method name is *unverified* on the pages read).
- **Geometry:** `joystick_size` 100 px, `tip_size` 50 px, `initial_offset_ratio` (0.5, 0.5) as a fraction of the control, `clampzone_ratio` limits tip travel, `deadzone_ratio` is applied **before** the InputMap action deadzone — keep one of the two deadzones at zero or they stack.
- **Signals:** `pressed`, `released(input_vector)`, `flicked(input_vector)` (released after leaving the deadzone; length 0–1), `flick_canceled`, `tapped` (released without moving). Flick/tap are handy for dash or jump gestures without extra buttons.
- **Theming:** StyleBoxes `normal_joystick`, `normal_tip`, `pressed_joystick`, `pressed_tip`.

## TouchScreenButton (Node2D)
- Gameplay button that supports **multitouch** (several held at once), unlike `Button`. It is a `Node2D`, so no anchors — place it in a `CanvasLayer` and position by code or use it for in-world controls.
- `action` names the InputMap action it presses; `texture_normal` / `texture_pressed`, `shape` (+ `bitmask`), `shape_centered`, `shape_visible` (editor only).
- `passby_press = true` makes `pressed`/`released` fire while a finger slides in and out even if the touch began elsewhere — useful for D-pad style strips.
- `visibility_mode = VISIBILITY_TOUCHSCREEN_ONLY` hides the node on non-touch devices, so one scene can serve desktop and mobile.
- For **menus** use ordinary `Button`s. *Corrected 2026-11-12:* this note used to say the mouse emulation must stay on for them to react to taps; on Godot 4.7.2 they react to real touch events **with or without** `emulate_mouse_from_touch` (verified line below).
- **Verified on 4.7.2 (proposed, unreviewed):** a `Button` reacts to a real `InputEventScreenTouch` even with `emulate_mouse_from_touch=false`; a custom `Control` then receives only `InputEventScreenTouch`/`ScreenDrag`. With emulation on it receives both, the extra mouse events carrying `device == -1` (`InputEvent.DEVICE_ID_EMULATION`) — filter those if a widget must treat touch as touch. So the emulation is optional for menus, not required.
- Safe area: `DisplayServer.get_display_safe_area()` is in screen coordinates; apply it only on mobile (on desktop/xvfb it yields bogus margins).

## Raw touch events
- `InputEventScreenTouch`: `index` (one finger = one index), `position` (viewport coordinates), `pressed`, `canceled`, `double_tap`.
- `InputEventScreenDrag`: `index`, `position`, `relative`, `velocity`, plus pen fields. **Pitfall:** `relative`/`velocity` are scaled by the content scale factor (stretch mode), so aim sensitivity would change with resolution — the docs recommend `screen_relative` / `screen_velocity` for touch aiming.
- Handle them in `_unhandled_input()` so UI Controls get first pick; `_input()` runs before the GUI.
- The tutorial equates ScreenTouch to a mouse click and ScreenDrag to mouse motion, and lists both as "mobile devices only".

## Emulation settings (Project Settings > Input Devices > Pointing)
| Setting | Default | Effect |
|---|---|---|
| `input_devices/pointing/emulate_mouse_from_touch` | `true` | taps/swipes also send mouse events. NOT required for `Button`s (they react to touch anyway, verified 4.7.2); a custom `Control` then gets each touch twice (touch + emulated mouse with `device == -1`), so filter the emulated one |
| `input_devices/pointing/emulate_touch_from_mouse` | `false` | mouse clicks/drags also send touch events — **enable to test touch nodes on desktop** |
| `input_devices/pointing/android/enable_long_press_as_right_click` | `false` | Android long press → right click |
| `input_devices/pointing/android/enable_pan_and_scale_gestures` | `false` | Android multi-touch pan/scale gesture events |

Testing on desktop: turn on *Emulate Touch From Mouse*; a `VirtualJoystick`/`TouchScreenButton` then responds to the mouse. Only one finger can be emulated this way (multitouch and `passby_press` across two fingers need a device — *unverified*, inferred from a single pointer).

## Keeping gameplay device-agnostic
1. Define actions in the InputMap (`snake_case`), bind keys and gamepad events there.
2. Point `VirtualJoystick.action_*` and `TouchScreenButton.action` at those same actions.
3. Gameplay reads only actions: `Input.get_vector()` / `is_action_pressed()` for held state, `event.is_action_pressed()` in `_unhandled_input` for one-shot presses.
4. For synthetic input (tutorials, replays, bots) build an `InputEventAction` (`action`, `pressed`, `strength`) and pass it to `Input.parse_input_event()`; the engine never emits this type itself.
5. Remember the InputMap is loaded from `project.godot` and not saved automatically; runtime remaps need your own persistence (see [[godot-screen-reader-and-input-remapping]]).

## Pitfalls
- Two deadzones (joystick-level and action-level) stack.
- `TouchScreenButton` is a Node2D: it ignores Control anchors and theme; size it for the target DPI yourself.
- Leaving touch nodes visible on desktop confuses players; use `VISIBILITY_TOUCHSCREEN_ONLY` or hide by code.
- `relative` on drags is resolution-dependent; use `screen_relative`.
- iOS-specific pointing settings and gesture events were not on the pages read (*unverified*).

## See also
- [[input-handling]] — actions and polling basics
- [[godot-screen-reader-and-input-remapping]] — runtime remapping of the same actions
- [[godot-ui-focus-and-gamepad-navigation]] — menus still need focus handling on non-touch devices

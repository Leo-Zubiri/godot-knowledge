---
id: src-gd-touch-input-virtualjoystick
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/4.7/classes/class_virtualjoystick.html"
  urls:
    - "https://docs.godotengine.org/en/4.7/classes/class_virtualjoystick.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_touchscreenbutton.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_inputeventscreentouch.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_inputeventscreendrag.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_inputeventaction.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/inputs/input_examples.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/inputs/inputevent.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_projectsettings.html"
  title: "Godot 4.7: VirtualJoystick, TouchScreenButton, screen touch/drag events, InputEventAction, input examples, pointing settings"
  retrieved: 2026-11-08
  version: "4.7 (page headers: Godot Engine 4.7 documentation in English)"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot 4.7 documentation pages fetched on 2026-11-08 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**. Every page reported the header *Godot Engine 4.7 documentation in English*. Nothing was run in the engine. Re-fetch before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

- **VirtualJoystick** (`Control`): "a virtual joystick control for touchscreen devices". Properties/defaults: `action_up/down/left/right` = `&"ui_up"`… (StringName actions fired per direction), `joystick_mode` = 0, `visibility_mode` = 0, `joystick_size` = 100.0 px, `tip_size` = 50.0 px, `clampzone_ratio` = 1.0 (limits tip travel; in following mode also how far the finger moves before the base follows), `deadzone_ratio` = 0.0 (fraction of size the tip must pass before it counts, applied *before* InputMap action deadzones), `initial_offset_ratio` = Vector2(0.5, 0.5) (start position as a fraction of the control). Enum `JoystickMode`: `JOYSTICK_FIXED` 0 (does not move), `JOYSTICK_DYNAMIC` 1 (moves to the first touch within bounds, returns on release), `JOYSTICK_FOLLOWING` 2 (dynamic plus follows the finger when it leaves the range). Enum `VisibilityMode`: `VISIBILITY_ALWAYS` 0, `VISIBILITY_WHEN_TOUCHED` 1. Signals: `pressed()`, `released(input_vector)`, `flicked(input_vector)` (released after leaving the deadzone; vector length 0–1), `flick_canceled()`, `tapped()` (released without moving). Theme StyleBoxes `normal_joystick`, `normal_tip`, `pressed_joystick`, `pressed_tip`. No methods beyond accessors. The page gives no "introduced in" note.
- **TouchScreenButton** (`Node2D`): on-screen gameplay button; supports multitouch (several pressed at once) unlike `Button`; being a Node2D it has no anchors — use `Button` for menus and enable `input_devices/pointing/emulate_mouse_from_touch` so Buttons react to touch. Properties: `action` = "" (handled through InputEventAction), `bitmask`, `shape`, `shape_centered` = true, `shape_visible` = true (editor only), `texture_normal`, `texture_pressed`, `passby_press` = false (when true, `pressed`/`released` fire as a pressed finger moves in and out even if the touch started outside), `visibility_mode` = 0 (`VISIBILITY_ALWAYS` 0, `VISIBILITY_TOUCHSCREEN_ONLY` 1 — lets one scene serve desktop and mobile). Method `is_pressed()`; signals `pressed()`, `released()`.
- **InputEventScreenTouch**: multi-touch press/release; `index` (one finger = one index), `position` (viewport coordinates), `pressed`, `canceled`, `double_tap`; all defaults false/0.
- **InputEventScreenDrag**: `index`, `position`, `relative`, `velocity`, `screen_relative`, `screen_velocity`, `pressure`, `tilt`, `pen_inverted`. `relative`/`velocity` are scaled by the content scale factor (stretch mode), so touch-aim sensitivity would vary with resolution — the page recommends `screen_relative`/`screen_velocity` for touch aiming.
- **InputEventAction**: "not emitted by the engine"; built by code and fed to `Input.parse_input_event()`, then received in `_input()`. Properties `action`, `pressed`, `strength` (0–1, can simulate analog), `event_index` = -1. To test a physical event against an action use `InputEvent.is_action()`/`is_action_pressed()`.
- **Input examples (tutorial):** touch events exist on touchscreen devices; `InputEventScreenTouch` is equivalent to a mouse click, `InputEventScreenDrag` to mouse motion. To test without a touchscreen: Project Settings > Input Devices > Pointing > **Emulate Touch From Mouse** (mouse clicks/motion become touch events). Prefer input actions over raw key events; `snake_case` action names; `_input()` for discrete events, `Input.is_action_pressed()` for held state.
- **InputEvent tutorial:** propagation order `Node._input()` → `Control._gui_input()` → `_shortcut_input()` → `_unhandled_key_input()` → `_unhandled_input()` ("ideal for full-screen gameplay events") → physics picking. Subtypes list marks ScreenTouch/ScreenDrag "mobile devices only". Actions let "the same code work across devices", allow runtime reconfiguration and programmatic triggering. `InputMap` state comes from `project.godot` and is not saved automatically.
- **ProjectSettings:** `input_devices/pointing/emulate_mouse_from_touch` = true ("sends mouse input events when tapping or swiping on the touchscreen"); `input_devices/pointing/emulate_touch_from_mouse` = false ("sends touch input events when clicking or dragging the mouse"); `input_devices/pointing/android/enable_long_press_as_right_click` = false; `input_devices/pointing/android/enable_pan_and_scale_gestures` = false; `input_devices/pointing/android/rotary_input_scroll_axis` = 1.

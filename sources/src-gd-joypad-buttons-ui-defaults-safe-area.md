---
id: src-gd-joypad-buttons-ui-defaults-safe-area
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/4.7/tutorials/inputs/controllers_gamepads_joysticks.html"
  urls:
    - "https://docs.godotengine.org/en/4.7/tutorials/inputs/controllers_gamepads_joysticks.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_@globalscope.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_input.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_projectsettings.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_displayserver.html"
    - "https://raw.githubusercontent.com/godotengine/godot/4.7-stable/core/input/input_map.cpp"
  title: "Godot 4.7: controllers tutorial, JoyButton/JoyAxis enums, Input joypad API, ui_* actions and gui/common/swap_cancel_ok, DisplayServer safe area/touch, and the built-in ui_* defaults in core/input/input_map.cpp (4.7-stable)"
  retrieved: 2026-11-08
  version: "4.7 (page headers: Godot Engine 4.7 documentation in English); input_map.cpp at tag 4.7-stable (lines 458–511 read verbatim with grep)"
  capture: excerpt
  retrieved_via: "fetch-time summarizer (WebFetch) for the doc pages (paraphrased); the input_map.cpp lines were read directly with curl + grep (verbatim)"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot 4.7 pages fetched on 2026-11-08 through a summarizing fetch tool (paraphrased; enum descriptions were reported as quotations) **plus** the engine source file `core/input/input_map.cpp` at tag `4.7-stable`, whose relevant lines were read directly and are reproduced verbatim below (hence `capture: excerpt`). The enum table is from the first 100k characters of the `@GlobalScope` page; the `ProjectSettings` descriptions from the 350k–450k window. Nothing was run in the engine. Re-fetch before promoting dependent notes to `verified`.

- **Controllers tutorial:** create input actions in the Project Settings Input Map; read with `Input.get_vector()` (two axes), `Input.get_axis()`, `Input.get_action_strength()` (triggers), `Input.is_action_pressed()`. Deadzone default "`0.5`", per-action in the Input Map; `get_vector()`'s optional 5th parameter overrides, otherwise averages the actions' deadzones ("handles deadzone in a correct way for most use cases", circular; `get_action_strength` gives a square-ish deadzone). "Since Godot 4.5, the engine relies on SDL 3 for controller support on Windows, macOS, and Linux"; Android uses a custom implementation; on the web "The quality of controller support tends to vary wildly across browsers"; "On Windows Godot only supports up to 4 controllers at a time"; Linux needs udev for hotplugging, otherwise poll. Wrong mappings "may be due to an erroneous mapping from the SDL game controller database used by Godot" (`core/input/godotcontrollerdb.txt` + SDL DB; test with `SDL_GAMECONTROLLERCONFIG`). Vibration: `start_joy_vibration` / `stop_joy_vibration`, `vibrate_handheld` (Android needs `VIBRATE`); the page advises an in-game slider to reduce or disable vibration. `input_devices/joypads/ignore_joypad_on_unfocused_application` controls input to unfocused windows. The page does **not** name face buttons or map them to vendor layouts.
- **`@GlobalScope` JoyButton (4.7):** `JOY_BUTTON_A` = 0 "Corresponds to the bottom action button: Sony Cross, Xbox A, Nintendo B"; `JOY_BUTTON_B` = 1 "right action button: Sony Circle, Xbox B, Nintendo A"; `JOY_BUTTON_X` = 2 "left action button: Sony Square, Xbox X, Nintendo Y"; `JOY_BUTTON_Y` = 3 "top action button: Sony Triangle, Xbox Y, Nintendo X"; `BACK` = 4 (Sony Select, Xbox Back, Nintendo −); `GUIDE` = 5 (Sony PS, Xbox Home); `START` = 6 (Sony Options, Xbox Menu, Nintendo +); `LEFT_STICK` = 7 (L3/LS); `RIGHT_STICK` = 8 (R3/RS); `LEFT_SHOULDER` = 9 (L1/LB); `RIGHT_SHOULDER` = 10 (R1/RB); `DPAD_UP/DOWN/LEFT/RIGHT` = 11–14; `MISC1` = 15 (Xbox Share, PS5 microphone, Switch capture); `PADDLE1–4` = 16–19; `TOUCHPAD` = 20; `MISC2` = 21 (Switch 2 Pro, Horipad Steam); `MISC3–6` = 22–25; `JOY_BUTTON_SDL_MAX` = 26; `JOY_BUTTON_MAX` = 128 (Android up to 36, Linux 80, Windows/macOS 128). **JoyAxis:** `LEFT_X` 0, `LEFT_Y` 1, `RIGHT_X` 2, `RIGHT_Y` 3, `TRIGGER_LEFT` 4, `TRIGGER_RIGHT` 5, `JOY_AXIS_SDL_MAX` 6, `JOY_AXIS_MAX` 10.
- **`Input` (4.7):** `get_connected_joypads()` → Array[int] of device IDs (order not guaranteed across restarts); `get_joy_name(device)` (names from the SDL game controller database); `get_joy_guid(device)` "SDL-compatible device GUID on platforms that use gamepad remapping" (Windows XInput → `__XINPUT_DEVICE__`); `get_joy_info(device)` (empty on Android and Web); `add_joy_mapping(mapping, update_existing=false)` "Adds a new mapping entry (in SDL2 format)"; `remove_joy_mapping(guid)`; `is_joy_known(device)`; `should_ignore_device(vendor_id, product_id)`; signal `joy_connection_changed(device, connected)` "Emitted when a joypad device has been connected or disconnected"; `get_vector(neg_x, pos_x, neg_y, pos_y, deadzone=-1.0)` (auto deadzone = average of the actions, length capped at 1, circular); `start_joy_vibration(device, weak, strong, duration=0)` (0 = "as long as possible, which is about 65 seconds"); `action_press(action, strength)` does not trigger `_input`, `parse_input_event(event)` does.
- **`ProjectSettings` (4.7):** `gui/common/swap_cancel_ok` = 0 — "How to position the Cancel and OK buttons in the project's AcceptDialog windows"; Auto follows the platform (OK first on Windows, KDE, LXQt; Cancel first on macOS and other Linux desktops); Cancel First / OK First force an order; check at runtime with `DisplayServer.get_swap_cancel_ok()`; does not affect native dialogs. `input/ui_accept` "Default InputEventAction to confirm a focused button, menu or list item, or validate input"; `input/ui_cancel` "… to discard a modal or pending input"; `input/ui_select` "… to select an item in a Control (e.g. in an ItemList or a Tree)"; `input/ui_focus_next` "… to focus the next Control in the scene"; `input/ui_menu` "… to open a context menu in a text field". Note on each: "Default `ui_*` actions cannot be removed as they are necessary for the internal logic of several Controls. The events assigned to the action can however be modified." The properties table shows **no default keys** for `ui_*`. `input_devices/joypads/ignore_joypad_on_unfocused_application` = false; `input_devices/pointing/emulate_mouse_from_touch` = true; `emulate_touch_from_mouse` = false. No joypad deadzone project setting was seen (*not found in the windows read*).
- **`DisplayServer` (4.7):** `get_display_safe_area()` "Returns the unobscured area of the display where interactive controls should be rendered"; `get_display_cutouts()` → Array of Rect2 "bounding rectangle for a display cutout or notch"; `is_touchscreen_available()` "Returns `true` if touch events are available (Android or iOS), the capability is detected on the Web platform" or when `emulate_touch_from_mouse` is on; `screen_get_dpi()` (Android, iOS, Linux X11/Wayland, macOS, Web, Windows; otherwise 72); `screen_get_scale()` (Android, iOS, Web, macOS, Linux Wayland; otherwise 1.0); `virtual_keyboard_show()` (Android, iOS, Web). Feature flags: `FEATURE_TOUCHSCREEN` on Windows, Linux (X11/Wayland), Android, iOS, Web.
- **`core/input/input_map.cpp` @ `4.7-stable`, `InputMap::get_builtins()` (verbatim lines 458–471; 4.0-stable, 4.3-stable and master read the same for these three):**

  ```cpp
  List<Ref<InputEvent>> inputs;
  inputs.push_back(InputEventKey::create_reference(Key::ENTER));
  inputs.push_back(InputEventKey::create_reference(Key::KP_ENTER));
  inputs.push_back(InputEventKey::create_reference(Key::SPACE));
  default_builtin_cache.insert("ui_accept", inputs);

  inputs = List<Ref<InputEvent>>();
  inputs.push_back(InputEventJoypadButton::create_reference(JoyButton::Y));
  inputs.push_back(InputEventKey::create_reference(Key::SPACE));
  default_builtin_cache.insert("ui_select", inputs);

  inputs = List<Ref<InputEvent>>();
  inputs.push_back(InputEventKey::create_reference(Key::ESCAPE));
  default_builtin_cache.insert("ui_cancel", inputs);
  ```

  Further joypad defaults in the same function (lines 492–511): `ui_left` = `Key::LEFT` + `JoyButton::DPAD_LEFT` + `JoyAxis::LEFT_X` at −1.0; `ui_right` = RIGHT + `DPAD_RIGHT` + `LEFT_X` +1.0; `ui_up` = UP + `DPAD_UP` + `LEFT_Y` −1.0; `ui_down` = DOWN + `DPAD_DOWN` + `LEFT_Y` +1.0; `ui_colorpicker_delete_preset` = DELETE + `JoyButton::X` (line 879). **No other `JoyButton::` reference exists in the file** — in particular neither `JoyButton::A` nor `JoyButton::B` is bound to any built-in action. Other keyboard defaults (summarised by the fetch tool): `ui_focus_next` TAB, `ui_focus_prev` SHIFT+TAB, `ui_page_up/down`, `ui_home/end`, `ui_cut` CMD_OR_CTRL+X / SHIFT+DELETE, `ui_copy` CMD_OR_CTRL+C / CMD_OR_CTRL+INSERT, `ui_paste` CMD_OR_CTRL+V / SHIFT+INSERT, `ui_undo` CMD_OR_CTRL+Z, `ui_redo` CMD_OR_CTRL+SHIFT+Z / CMD_OR_CTRL+Y, `ui_menu` MENU, `ui_swap_input_direction` CMD_OR_CTRL+QUOTELEFT, `ui_close_dialog` ESCAPE (macOS also META+W); the `ui_text_*` family is keyboard-only.

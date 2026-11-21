---
id: godot-android-mobile-ux-dpi-scale-back-lifecycle
type: pattern
domain: godot
status: unreviewed
summary: "Making a desktop-designed Godot 4 game usable on Android: (1) a 1920x1080 stretch makes a 56-unit button ~3.6 mm on a 6.5\" 420 dpi phone — compute ONE global `Window.content_scale_factor` from dpi so the smallest button is >= 44 dp (1.0 on desktop/tablet), then verify layouts at the shrunken viewport (~1500x675) with real screenshots, not headless asserts; (2) give menus a scrolling centre container, a minimum touch font (20 units) and taller theme buttons; (3) handle Back via NOTIFICATION_WM_GO_BACK_REQUEST with `quit_on_go_back=false` (pause in game, go back in menus, double-press to exit); (4) pause on NOTIFICATION_APPLICATION_PAUSED; (5) screen-on only during play; (6) short, rate-limited, switchable haptics through an injectable sink; (7) lift chat input by `DisplayServer.virtual_keyboard_get_height()`; (8) the export needs ETC2/ASTC enabled, a full JDK (javac) and the matching export templates; `window/handheld/orientation` must be the integer enum (4 = sensor landscape), a string silently becomes landscape."
aliases: [android ux godot, content_scale_factor dpi, android back button godot, godot android export checklist, touch target 48dp]
tags: [dept/engineering, scope/mobile, scope/ui, scope/export]
applies-to:
  min: "Godot 4.0"
  tested: "Ginomo 4.7.2: APK exported and manifest inspected with aapt2; layouts checked with xvfb screenshots at 2400x1080 / scale 1.6; NOT run on a physical phone or emulator"
sources: []
related:
  - relates-to: "[[godot-virtual-joystick-multitouch-pitfalls]]"
  - relates-to: "[[game-design-input-mapping-conventions-keyboard-gamepad-touch]]"
created: 2026-11-21
updated: 2026-11-21
created_by_type: agent
---

> **Evidence status — `unreviewed`.** Measured and built in Ginomo (Godot 4.7.2); not checked against engine source; no device test yet.

## 1. Touch size from dpi, once, globally
- dp → px: `dp * dpi / 160`. Android recommends 48 dp, iOS 44 pt. A project designed at 1920x1080 (`canvas_items`, `expand`) puts the SAME 1080 units in
  ~68 mm on a phone: a 56-unit button is ~3.6 mm, text of 24 units is ~9 dp. Too small to touch or read.
- Formula: `k = clamp(dp_px(44, dpi) / (smallest_button_units * window_h / base_h), 1.0, 2.5)`, rounded to 0.05; unknown dpi → 1.0. Apply
  `get_tree().root.content_scale_factor = k` (desktop 1.0, tablet ~1.0, 420 dpi phone ~1.6). Let the player override it (0 = automatic).
- It shrinks the layout viewport (1920x1080 → ~1500x675), so every screen must be re-checked there. **Headless asserts on `get_visible_rect()` after
  changing the scale are unreliable**; use `xvfb-run` screenshots with a 2400x1080 window and the factor set in a throw-away probe scene.
- Floors that make the scale work: minimum interactive height 72 units, minimum HUD font 20 units on touch (`font(size)` helper), theme buttons with
  larger vertical content margin on touch, a power-bar/handle width >= 72.

## 2. Short screens
- A landscape phone is ~675 units tall. Replace `CenterContainer` roots with `ScrollContainer(horizontal disabled) > CenterContainer(custom_minimum_size = scroll.size)`:
  centred when it fits, finger-scrollable when it does not.
- Overlapping HUD cards are the next failure: decide ownership of each corner per role (shooter vs waiter) and per handedness; hide secondary cards.

## 3. System events
- Back: `NOTIFICATION_WM_GO_BACK_REQUEST` reaches every node; set `get_tree().quit_on_go_back = false` (and `application/config/quit_on_go_back=false`). Policy: game → toggle pause;
  submenu → its back action; main menu → toast "press back again", exit on a second press within ~2 s.
- Background: `NOTIFICATION_APPLICATION_PAUSED` / `_RESUMED` (and window focus-out on mobile only) → open the pause menu. Don't pause on desktop focus-out.
- `DisplayServer.screen_set_keep_on(true)` only while playing (and set the project's `energy_saving/keep_screen_on` false so you control it).
- Haptics: `Input.vibrate_handheld(ms, amplitude)`; 12–70 ms, amplitude 0.25–1.0, >= 70 ms between pulses, only for the player's own action / the key event, with a settings switch. Keep it a pure class with an injectable sink.
- Virtual keyboard: `DisplayServer.virtual_keyboard_get_height()` is in screen pixels; convert to viewport units (`* viewport_h / window_h`) and lift the input box above it.

## 4. Export pitfalls (Godot 4.7.2, no Gradle build)
- Needs `rendering/textures/vram_compression/import_etc2_astc=true` or the export refuses.
- "A valid Java SDK path is required": the editor setting must point to a **JDK with `bin/javac`**, a JRE is not enough. A Temurin 17 tarball unpacked in the home directory works.
- Export templates must match the editor build exactly (`4.7.2.stable.mono` folder name for the Mono editor); copy `android_debug.apk`, `android_release.apk`, `android_source.zip`, `version.txt`.
- Debug signing needs a keystore at the path in the editor settings (create with `keytool`, alias `androiddebugkey`, pass `android`).
- `display/window/handheld/orientation` is an **int enum** in `project.godot` (0 landscape, 1 portrait, 2 reverse landscape, 3 reverse portrait, 4 sensor landscape, 5 sensor portrait, 6 sensor); a string value was exported as plain landscape (manifest `screenOrientation=0`); `4` gave `userLandscape` (11).
- Check an APK without a device: `aapt2 dump badging app.apk` and `aapt2 dump xmltree app.apk --file AndroidManifest.xml`.

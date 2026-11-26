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
  tested: "Ginomo 4.7.2: APK exported, installed with adb on a Galaxy S24 Ultra (Android 15/16, 1080x2340, 450 dpi, Adreno 750) and screenshotted with `adb exec-out screencap`; layouts reproduced with xvfb at 2340x1080 / content_scale_factor 1.72; touch gameplay not yet measured (fps, joystick)"
sources:
  - "[[src-gd-android-display-touch-multires-2026-11]]"
related:
  - relates-to: "[[godot-virtual-joystick-multitouch-pitfalls]]"
  - relates-to: "[[game-design-input-mapping-conventions-keyboard-gamepad-touch]]"
created: 2026-11-21
updated: 2026-11-25
created_by_type: agent
---

> **Evidence status — `unreviewed`.** Measured and built in Ginomo (Godot 4.7.2); first real-device run on 2026-11-25 (section 5). Not checked against engine source.

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

## 5. What the first real-phone run found (all four were invisible on desktop and in headless tests)
1. **Exported resources are remapped.** In an export, `manifest.tres` is listed by `DirAccess` as `manifest.tres.remap` (and imported assets as `*.import`/converted). A scanner that matches `name == "manifest.tres"` finds NOTHING on Android: the game booted but a data-driven menu (one card per manifest) showed no game at all. Match both names and `load()` the path with `.remap` stripped; or avoid directory scans in shipped code (explicit list/preload). Always smoke-test "the data-driven list is not empty" on the exported build.
2. **`window_set_mode(WINDOWED)` breaks immersive mode.** `screen/immersive_mode=true` in the preset only sets the initial state. A settings autoload that applies a saved/default `fullscreen=false` as `WINDOW_MODE_WINDOWED` brings the status and navigation bars back and insets the render. On mobile always force `WINDOW_MODE_FULLSCREEN` (hide the "fullscreen" toggle there).
3. **The scale is bigger than the example.** A 450 dpi 1080x2340 phone gives `k = 44*450/160 / 72 = 1.72`, so the layout viewport is **~1360x628**, not 1500x675. Design budget: a landscape phone menu has ~600 units of height. 5 buttons + a 86-unit title + 60 margins does not fit; use a compact density below ~760 units (title ~56, margins 16, separation 8). Make it react to `viewport.size_changed`.
4. **`ScrollContainer > CenterContainer(custom_minimum_size = scroll.size on resized)` is fragile.** The signal can arrive with size 0 or while the panel is hidden and the content sticks to the top-left. Give the child `size_flags_horizontal/vertical = EXPAND_FILL` instead: it fills the viewport when the content fits (centred) and grows/scrolls when it does not. Add a few units of top/bottom padding so a long form does not touch the screen edge, and keep the Back/primary action outside the scrolling area on long forms.

## 6. Godot mobile best practices to apply from day one (checklist; from the engine docs on multiple resolutions + this run)
- Stretch `canvas_items` + aspect `expand`, layouts built with anchors and containers (never absolute positions), so ultra-wide (20:9, 2340x1080) just gives more width. Keep a base resolution close to the real viewport (a landscape phone is ~1280x600 units) or budget a global `content_scale_factor` as in section 1.
- Safe area: `DisplayServer.get_display_safe_area()` is in screen coordinates; apply it only on mobile and cross it with the window position (cutouts, rounded corners, gesture bars).
- Immersive/edge-to-edge: preset `screen/immersive_mode`, and never switch the window mode to windowed on mobile.
- Renderer Mobile (Vulkan Mobile) with `scaling_3d_scale` ~0.75 as the default on phones, player-adjustable; ETC2/ASTC enabled; keep shadows and MSAA as settings, not constants.
- Test loop without a phone: `xvfb-run` a probe scene with the real window size and `Window.content_scale_factor`, and force the touch theme (`force_touch`), because desktop captures use the non-touch theme and look roomier than the phone (buttons are ~15 % taller on touch).
- Test loop with a phone: `adb install -r`, `adb shell monkey -p <pkg> -c android.intent.category.LAUNCHER 1`, `adb exec-out screencap -p > shot.png`, `adb shell input tap x y` (coordinates are physical pixels), `adb logcat -d -s godot`, `adb shell dumpsys window | grep mCurrentFocus`.
- Samsung/One UI: **Auto Blocker** ("Bloqueador automático") blocks USB commands, so `adb devices` stays empty even with USB debugging on; turn off Auto Blocker (or its "block commands by USB cable" switch). `lsusb` showing only Audio/MIDI interfaces (no class 255/66/1) means the phone is not exposing ADB (USB mode = MIDI, debugging off, or Auto Blocker).

## 7. Second round on the phone: the real bug was that long menus did not scroll, and the layout budget is in dp, not in scale
1. **`ScrollContainer` receives `InputEventScreenTouch/Drag` but does NOT scroll with them in 4.7.2 on Android** (project had `emulate_mouse_from_touch=false`; the mouse wheel does scroll). Long forms (match setup, settings) were unreachable below the first screen. Synthetic proof in xvfb: `Input.parse_input_event` of a touch + 10 drags left `scroll_vertical = 0`; the same events handled by a tiny helper on `scroll.gui_input` that does `scroll_vertical -= relative.y` (plus a Tween fling) reach the end. Keep the helper object alive: **a signal connection does not keep a `RefCounted` alive** (store it in `set_meta`). Use `relative` (viewport units), not raw screen pixels. Reusable form: `GnTouchScroll.install(scroll)`.
2. **Think in dp.** A phone landscape screen of 2340x1080 px at 450 dpi is ~832x384 dp, no matter what `content_scale_factor` you pick; the scale only changes the unit. The budget is: 44 dp buttons (about 5 stacked at most) + title in ~384 dp. So every screen needs a **compact density** (title ~56 units, margins 16, separation 8, thumbnails hidden) below ~760 units of viewport height, and in-game HUD cards must shrink to one line (group name only) while hints and secondary cards fold away. The official docs suggest a 1280x720 base for mobile landscape with `canvas_items` + `expand`, which lands at scale 1.5 on a 1080-px-tall phone; Ginomo kept 1920x1080 and a dpi-derived factor (1.72), which is fine as long as layouts are written for ~630 units of height.
3. **Footer-card pattern** for long forms: `MarginContainer > CenterContainer > PanelContainer > VBox[ ScrollContainer(body), HBox(footer actions) ]`, and after every rebuild/resize call `fit_height(card, scroll, want)`: reset the scroll's `custom_minimum_size.y = 0`, `chrome = card.get_combined_minimum_size().y`, `available = viewport_h - 2*margin - chrome`, `scroll.custom_minimum_size.y = clamp(want, 0, max(available, 96))`. The primary action (Play) and Back stay on screen and only the body scrolls. For `TabContainer`, wrap each page in a `ScrollContainer` and fit the tab container the same way.
4. **Hiding an EXPAND_FILL sibling moves the rest.** A bottom row with `[hint (expand)] [controls]` pushed the controls to the right; hiding the hint (to drop keyboard hints on touch) slid the controls to the left. Add an expanding spacer that becomes visible when the hint is hidden.
5. **Probe with the phone's defaults, not the desktop's.** The HUD probe first showed a HUD 25 % too big because desktop defaults (`hud_scale 1.25`) were used; apply the mobile overrides (`hud_scale 1.0`, `render_scale 0.75`) in the probe, force the touch device on the HUD (`device_override`) and the touch theme. On the real phone `adb shell input swipe/tap` + `screencap` is the ground truth; adb sessions on Samsung drop when the phone sleeps or the cable moves, so script re-checks (`adb devices`) before each step.
6. **"I can't shoot" was a flow problem, not a bug.** A desktop-style opening ("place the cue ball behind the line, confirm, then the cue-summoning ritual, then Shoot") meant that on a phone the Shoot button did not exist for the first seconds and the first screen asked for a "Place" tap the player did not understand. Measure the **time to first action** on the device (screenshots every 2.5 s after pressing Play) and cut mandatory steps on touch: default the optional step off on mobile (per-platform settings overrides), keep the primary button visible but disabled while it is not available (hidden = "broken"), say why in the status line ("the gnome is summoning the cue…"), and rewrite desktop wording on touch ("click the ball" → "tap the ball"; an empty key hint "()" → the on-screen button name).

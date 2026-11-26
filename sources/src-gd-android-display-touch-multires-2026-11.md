---
id: src-gd-android-display-touch-multires-2026-11
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/rendering/multiple_resolutions.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/rendering/multiple_resolutions.html"
    - "https://docs.godotengine.org/en/stable/tutorials/ui/gui_containers.html"
    - "https://docs.godotengine.org/en/stable/classes/class_scrollcontainer.html"
    - "https://docs.godotengine.org/en/stable/classes/class_displayserver.html"
    - "https://docs.godotengine.org/en/stable/classes/class_editorexportplatformandroid.html"
    - "https://docs.godotengine.org/en/stable/classes/class_touchscreenbutton.html"
    - "https://docs.godotengine.org/en/stable/classes/class_inputeventscreendrag.html"
    - "https://docs.godotengine.org/en/stable/classes/class_theme.html"
    - "https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html"
    - "https://docs.godotengine.org/en/stable/tutorials/performance/optimizing_3d_performance.html"
  title: "Godot 4.7 docs: multiple resolutions, containers/ScrollContainer, DisplayServer (Android), Android export options, touch input classes, mobile rendering"
  retrieved: 2026-11-25
  version: "4.7 (stable pages)"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) via research subagents; not verbatim except where quoted; some items marked [summary] came from truncated pages"
created: 2026-11-25
updated: 2026-11-25
created_by_type: agent
---

> Preserved pointer + key points. **Basis:** official Godot 4.7 documentation pages fetched on 2026-11-25 by research subagents (paraphrased extraction). Documentation only; behaviour claims in the linked pattern notes marked "measured" were run on a physical phone.

- **Multiple resolutions:** base size is only a design size (the engine never changes the monitor resolution). Docs recommend, for mobile landscape, base **1280x720** (1920x1080 for high-end), stretch mode `canvas_items`, aspect `expand`, Controls anchored with the Layout menu; a 4:3 base (1280x960) for tablets/foldables; portrait 720x1280. `keep_width` is "usually the best option for GUIs/HUDs that scale"; `keep_height` for horizontally scrolling 2D. **Stretch Scale** (`Window.content_scale_factor`) is the recommended user-facing option (accessibility setting). `GUI > Theme > Default Theme Scale` (1.5-2.0 suggested for mobile with larger bases) **cannot change at runtime**. `DisplayServer.screen_get_scale()` is implemented on Android, iOS, Linux Wayland, macOS, Web. Aspect ratios are handled with "anchors and/or containers".
- **Containers:** inside a container, children lose their own positioning; size flags are per axis (Fill, Expand, Shrink Begin/Center/End, Stretch Ratio). **ScrollContainer accepts a single child**, shows scrollbars when the child is bigger, `scroll_deadzone` = "Deadzone for touch scrolling", `scroll_started/ended` fire only on Android/iOS or with `emulate_touch_from_mouse`. The page does **not** say a child should use EXPAND_FILL (measured to work in 4.7.2). Also: AspectRatioContainer, FlowContainer, GridContainer for responsive layouts.
- **Theme:** `default_base_scale` (0.0 = use the global scale) and `default_font_size`; no page gives a minimum touch-target size (44-48 dp comes from Android/iOS guidelines, not Godot docs).
- **Android window/system bars:** `DisplayServer.WINDOW_MODE_FULLSCREEN` and `EXCLUSIVE_FULLSCREEN` both say "On Android: this enables immersive mode" and resize the window to the monitor ("make sure your project supports multiple resolutions"). Export options `screen/immersive_mode` (hides navigation + status bars) and `screen/edge_to_edge` (translucent bars; use the DisplayServer safe-area methods) [summary]. `WINDOW_EVENT_GO_BACK_REQUEST` is Android-only.
- **DisplayServer (Android-relevant):** `get_display_safe_area()` = "unobscured area where interactive controls should be rendered" (Android/iOS only); `get_display_cutouts()` (Android only) [summary]; `virtual_keyboard_get_height()` in pixels (0 if hidden; may be 0 the first time on Android 7/8 in non-immersive mode); `screen_get_dpi()` on Android is grouped (ldpi 120 ... xxxhdpi 640), other platforms may return 72; `screen_set_keep_on()`; `is_touchscreen_available()` true on Android/iOS or with `emulate_touch_from_mouse`; `screen_get_usable_rect()` excludes bars only on desktop, so on Android use the safe area.
- **Touch classes:** `InputEventScreenTouch.index` = one finger. `InputEventScreenDrag`: use `screen_relative`/`screen_velocity` "for touch aiming regardless of the project's stretch mode"; `relative`/`velocity` are scaled by the content scale factor. `TouchScreenButton` supports multitouch out of the box (unlike Button) but cannot use anchors; `Control.mouse_filter = IGNORE` for overlays. Gameplay input belongs in `_unhandled_input` so the GUI can intercept first. `emulate_mouse_from_touch` makes Buttons react to touch per the TouchScreenButton page; docs do not explain how emulation interacts with real touch.
- **Rendering on mobile:** Mobile renderer = "fewer features, renders simple scenes faster, used by default on mobile"; no automatic instancing in Mobile; realtime lights/shadows "may simply be too much for lower power mobile devices"; prefer baked lighting; few transparent objects. The pages read give no numbers for `scaling_3d_scale`, MSAA, shadow resolution or fps targets.
- **Export gotchas from the docs:** distro-packaged Android SDKs are often outdated; keystore and key passwords must match; "Could not install to device" if the same package was installed with a different signing key; Gradle builds skip folders whose name starts with an underscore; `.godot/export_credentials.cfg` should not be committed; `res://` is read-only at runtime, `user://` is writable. The docs pages read say **nothing about `.remap`/`.import` names in exported `DirAccess` listings** (found by measurement, see [[godot-android-mobile-ux-dpi-scale-back-lifecycle]]).
- **Gaps found:** no touch-target size guidance; no virtual-joystick recipe; `ScaleContainer` page returned 404 in this version; Android custom-build page 404; performance numbers for phones absent.

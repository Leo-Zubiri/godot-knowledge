---
id: src-gd-xr-openxr-webxr
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/4.7/tutorials/xr/index.html"
  urls:
    - "https://docs.godotengine.org/en/4.7/tutorials/xr/index.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/xr/setting_up_xr.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/xr/a_better_xr_start_script.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/xr/xr_action_map.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/xr/deploying_to_android.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_xrinterface.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_xrcontroller3d.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_webxrinterface.html"
  title: "Godot 4.7: XR tutorials (index, setting up XR, a better XR start script, the XR action map, deploying to Android) and XR class references (XRInterface, XRController3D, WebXRInterface)"
  retrieved: 2026-11-09
  version: "4.7 (pages headed 'Godot Engine 4.7 documentation in English')"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); not verbatim. The planned tutorials/xr/openxr_action_map.html returned HTTP 404; tutorials/xr/xr_action_map.html is the live page and is what was preserved."
created: 2026-11-09
updated: 2026-11-09
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** the official Godot 4.7 XR pages above, fetched 2026-11-09 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**. Nothing was run in the engine or on a headset. Re-fetch before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

### XR index (overview)
- "This section of the manual covers everything related to XR ( Virtual Reality and Augmented Reality)."
- **OpenXR** is listed first and has the most sub-tutorials: a better XR start script, Android deployment, settings, the XR action map, composition layers, hand and body tracking, render models, spatial entities. **WebXR** has one (an introduction). "Others" lists Mobile VR, ARCore, OpenVR, TiltFive. (The page does **not** itself state OpenXR is "the standard" — that framing is Khronos's.)

### Setting up XR
- Project settings: enable **XR > OpenXR > Enabled** (`xr/openxr/enabled`) and **XR > Shaders > Enabled** (`xr/shaders/enabled`), then Save & Restart. OpenXR must be enabled before Godot starts; these can't change at runtime.
- Node tree: **XROrigin3D** (play-space centre) → child **XRCamera3D** (tracked by the XR system) → two **XRController3D** children renamed `LeftHand`/`RightHand` with a controller role set in the Inspector. Dev positions: camera y≈1.7. (This page does **not** cover `XRAnchor3D` or hand-tracking nodes such as `XRHandModifier3D` — those are separate sub-tutorials in the index.)
- Startup script: `xr_interface = XRServer.find_interface("OpenXR")`; if it exists and `is_initialized()` then `get_viewport().use_xr = true`, else report the headset is not connected. "Other interfaces need a call to `initialize()` instead." Don't re-initialize when switching scenes.
- **Renderers:** the page names Compatibility, Mobile, Forward+. "Mobile is recommended for desktop VR and standalone headsets such as the Meta Quest 3." Forward+ runs XR but is "less optimized for XR than Mobile." Compatibility is not listed as an XR option on this page.

### A better XR start script
- `XRServer.find_interface("OpenXR")` + `is_initialized()`; on failure prints "OpenXR not instantiated!" and `get_tree().quit()` (recommended for VR-only standalone apps so the system doesn't hang).
- `vp.use_xr = true`; `DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)` — "v-sync is handled by OpenXR."
- **Foveation (VRS):** if `RenderingServer.get_rendering_device()` is available (Mobile or Forward+), set `vp.vrs_mode = Viewport.VRS_XR`; otherwise (Compatibility) read the `xr/openxr/foveation_level` project setting and, if 0, `push_warning` to set it High.
- Signals connected: `session_begun`, `session_visible`, `session_focussed`, `session_stopping`, `pose_recentered`.
- On `session_begun`: `get_display_refresh_rate()`/`get_available_display_refresh_rates()`, pick a higher rate not exceeding exported `maximum_refresh_rate` (default **90**), apply with `set_display_refresh_rate()`, and set `Engine.physics_ticks_per_second` to it (mismatch with Godot's default 60 "causes stuttering").
- On `session_visible` (focus lost): pause the tree; "controller and hand tracking stay disabled while visible." On `session_focussed`: unpause. On `pose_recentered`: `XRServer.center_on_hmd()` is often sufficient. Viewport scaling is **not** mentioned on this page.

### The XR action map
- Binds controller inputs/outputs to **named actions** per **interaction profile**. **Action sets** group actions (walkthrough: `my_first_action_set`). Action **types**: `Bool` (buttons), `Float` (triggers), `Vector2` (thumbsticks), `Pose` (`aim`/`grip`/`palm`), `Haptic` (only output type).
- **Profiles** hold per-controller bindings; walkthrough uses the **Touch controller**; the **Simple controller** is a generic OpenXR fallback "often too limited for real games." The **XR runtime, not the game, picks the final mapping** and can let users rebind. Recommendation: bind only controllers you have tested.
- **Differences from the engine InputMap:** XR adds triggers/axes/poses/haptics; OpenXR returns only parsed action data; OpenXR bindings **cannot change at runtime**; device IDs "are meaningless in OpenXR." Mixing classic input with XR controllers means two separate systems.
- Optional binding modifiers (extension-dependent): Dpad modifier (thumbstick/trackpad → directional buttons), Analog threshold modifier.

### XRController3D (class)
- Signals: `button_pressed(action_name)`, `button_released(action_name)`, `input_float_changed(action_name, value)`, `input_vector2_changed(action_name, value)`, `profile_changed(role)`.
- Methods: `is_button_pressed(name)`, `get_float(name)`, `get_vector2(name)`, `get_input(name)`, `get_tracker_hand()`. Input names are defined by the active XRInterface; under OpenXR they match the action-set action names.

### XRInterface (class)
- Base for AR/VR platform implementations (C++/GDExtension); GDScript detects/enables/configures via `XRServer`. `initialize()` — "The first interface that is initialized is identified as the primary interface" and handles rendering output; `is_initialized()`, `uninitialize()`, `interface_is_primary`/`set_primary()`/`is_primary()`.
- Play area: `xr_play_area_mode` with `get_play_area_mode()`/`set_play_area_mode()`; `PlayAreaMode` values incl. `XR_PLAY_AREA_ROOMSCALE`, `XR_PLAY_AREA_STAGE`; `supports_play_area_mode()`, `get_play_area()`, `play_area_changed(mode)`; `get_tracking_status()` → `TrackingStatus` (e.g. `XR_NORMAL_TRACKING`).
- AR/passthrough: `environment_blend_mode`, `get_supported_environment_blend_modes()`. `get_render_target_size()`, `get_system_info()`. (This class page did **not** document the refresh-rate/foveation methods — those appear in the start-script tutorial above.)

### Deploying to Android (standalone, e.g. Meta Quest)
- Prereqs: OpenJDK 17, Android Studio, SDK path set (see "Exporting for Android").
- **Renderer:** the page warns the "Mobile Vulkan renderer" "still has unresolved issues" and **recommends the Compatibility renderer (OpenGL) for Android XR targets for now** — a direct tension with the setting-up-XR page's "Mobile is recommended."
- **OpenXR loader:** official Android OpenXR support was not in the initial spec, so vendor loaders "must currently be added to your project manually."
- **Godot OpenXR vendors plugin:** install from the Asset Store ("OpenXR vendors") or GitHub releases (**GodotVR/godot_openxr_vendors**); manual install copies `assets/addons/godotopenxrvendors` into `addons`. "As of Godot 4.6, the plugin is optional but recommended… and may be required for app store releases."
- Enable **Install Android Build Template…** (Gradle). Per-device export presets (each needs its own loader): Add → Android, **Use Gradle Build**, **XR Mode = OpenXR**, Runnable for one-click deploy; XR Features sections include **Meta XR Features, Pico XR Features, Magicleap XR Features, Khronos XR Features** (Khronos used for HTC). Foveation is not mentioned here.

### WebXRInterface (class)
- Uses the WebXR standard for VR/AR in a browser; "this interface is only available when running in Web exports." WebXR "covers a wide range of devices, from high-end PC headsets to basic smartphones."
- `is_session_supported(session_mode)` is async via the `session_supported` signal. `session_mode` ∈ `"immersive-vr"`, `"immersive-ar"`, `"inline"`; example uses `"immersive-vr"`. `requested_reference_space_types` (comma-separated, first supported wins), `reference_space_type`, plus `required_features`/`optional_features` set before `initialize()`.
- Init: `XRServer.find_interface("WebXR")`; connect `session_supported`/`session_started`/`session_ended`/`session_failed`; on `session_started` set `get_viewport().use_xr = true`, on `session_ended` set it back. Input via XRController3D signals **or** the `select`/`squeeze` signals (which also cover screen taps and voice). The class page does **not** state which Godot renderer WebXR requires.

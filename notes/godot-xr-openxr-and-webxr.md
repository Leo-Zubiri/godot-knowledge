---
id: godot-xr-openxr-and-webxr
type: guide
domain: godot
status: proposed
summary: "How XR works in Godot 4.7: enable OpenXR (xr/openxr/enabled) and the XR node tree (XROrigin3D/XRCamera3D/XRController3D), the OpenXR Action Map as a system separate from the engine InputMap, renderer support (Forward+/Mobile/Compatibility — the Android page currently recommends Compatibility), foveation/refresh-rate in the start script, and export paths (PCVR via an OpenXR runtime, standalone Quest via the OpenXR vendors plugin, browser via WebXR)."
aliases: [XR, VR in Godot, OpenXR, WebXR, XROrigin3D, XR action map, XRController3D, foveated rendering]
tags: [tool/godot, dept/game-dev, dim/3d]
applies-to:
  min: "4.0 (OpenXR module); vendors plugin notes reference 4.6"
  tested: "4.7 (documentation only; not run in the engine or on a headset)"
sources:
  - claim: "Godot XR is OpenXR-first (most sub-tutorials) plus a WebXR interface; enabling needs xr/openxr/enabled + xr/shaders/enabled; node tree XROrigin3D/XRCamera3D/two XRController3D; start script find_interface('OpenXR')+is_initialized()+use_xr; action map action sets/types/profiles separate from InputMap; XRController3D signals; renderer guidance (Mobile recommended in setup, Compatibility recommended on the Android page); OpenXR vendors plugin; WebXR web-only session modes"
    ref: src-gd-xr-openxr-webxr
    retrieved: 2026-11-09
  - claim: "OpenXR is a royalty-free, cross-vendor Khronos standard that unifies access to headsets/controllers/trackers so one API ports across devices"
    ref: src-gs-vr-openxr-standard-and-distribution
    retrieved: 2026-11-09
related:
  - relates-to: "[[godot-renderer-feature-matrix]]"   # XR imposes renderer choices (foveation/MSAA/VRS) that note otherwise omits
  - relates-to: "[[input-handling]]"   # the OpenXR Action Map is a second input system beside the engine InputMap
  - relates-to: "[[godot-export-platform-notes]]"   # standalone XR ships through the Android export path
  - relates-to: "[[godot-performance-workflow]]"   # XR frame budget is doubled (one view per eye) and latency-critical
  - relates-to: "[[godot-ui-focus-and-gamepad-navigation]]"   # flat UI needs a laser-pointer/ray in XR, not focus neighbours
  - relates-to: "[[game-studio-vr-standards-comfort-and-distribution]]"   # the industry/comfort/distribution companion to this engine note
created: 2026-11-09
updated: 2026-11-09
created_by_type: agent
---

> **Evidence status:** Godot facts are *documented* from the official 4.7 XR pages retrieved 2026-11-09 (paraphrased — see [[src-gd-xr-openxr-webxr]]); the OpenXR-standard framing is *documented* from Khronos ([[src-gs-vr-openxr-standard-and-distribution]]). Nothing was run in the engine or on a headset. Frame-rate targets (72/90/120 Hz) and the "doubled frame budget" are *interpretation* beyond the pages (the docs only state a default `maximum_refresh_rate` of 90). Items marked *unverified* were not on a page read. Status `proposed`.

## 1. Scope and evidence classes
Technical VR/AR in Godot 4.7. Godot's XR is **OpenXR-first** — OpenXR has by far the most sub-tutorials (settings, action map, Android, hand/body tracking, composition layers) while **WebXR** has one (browser VR/AR); "Others" lists legacy Mobile VR, ARCore, OpenVR, TiltFive (*documented*). OpenXR itself is "a royalty-free, open standard that provides a common set of APIs for developing XR applications" that "standardizes the use of a range of cross-platform XR device capabilities" — so targeting OpenXR ports one code path across vendors (*documented*, Khronos). **Evidence classes:** *documented* (a 4.7 page read), *interpretation* (reasoning/common practice), *unverified* (not on a page read).

## 2. Enabling XR and the node tree
1. Project Settings → **XR > OpenXR > Enabled** (`xr/openxr/enabled`) and **XR > Shaders > Enabled** (`xr/shaders/enabled`), then Save & Restart. OpenXR must be on **before Godot starts** and cannot change at runtime (*documented*).
2. Node tree: **`XROrigin3D`** (centre of the play space) → child **`XRCamera3D`** (pose driven by the XR system) → two **`XRController3D`** children (rename `LeftHand`/`RightHand`, set the controller role in the Inspector) (*documented*). Hand tracking (`XRHandModifier3D`) and `XRAnchor3D`/spatial anchors are separate sub-tutorials, not covered on the setup page (*unverified* here — see their own pages before relying on specifics).
3. **Start XR** script: `xr = XRServer.find_interface("OpenXR")`; if `xr and xr.is_initialized()` then `get_viewport().use_xr = true` — OpenXR is already initialized before the project loads, so you check, you don't call `initialize()` (other interfaces *do* call `initialize()`) (*documented*). A VR-only standalone app should `get_tree().quit()` on failure so the system doesn't hang (*documented*).

## 3. Input — two separate systems
The **OpenXR Action Map** (an editor resource) binds controller inputs/outputs to **named actions** per **interaction profile** — this is **not** the engine InputMap ([[input-handling]]). Actions live in **action sets** (enable the set matching the game state) and have a type: `Bool` (buttons), `Float` (triggers), `Vector2` (thumbsticks), `Pose` (`aim`/`grip`/`palm`), `Haptic` (the only output) (*documented*). **Interaction profiles** hold per-controller bindings (e.g. the **Touch controller**); the **Simple controller** is a generic fallback "often too limited for real games." The **XR runtime — not your game — picks the final mapping** and may let users rebind (*documented*). Differences from the InputMap that matter: OpenXR returns only parsed action data, its **bindings cannot change at runtime**, and device IDs "are meaningless in OpenXR" — so classic input and XR input are two parallel systems (*documented*).

`XRController3D` surfaces the active action set via signals `button_pressed(name)`, `button_released(name)`, `input_float_changed(name, value)`, `input_vector2_changed(name, value)`, `profile_changed(role)`, and polling methods `is_button_pressed()`, `get_float()`, `get_vector2()`, `get_input()`, `get_tracker_hand()` (*documented*).

## 4. Rendering
All three renderers appear in XR guidance, but with a live contradiction to flag:
- **Setting-up-XR page:** "Mobile is recommended for desktop VR and standalone headsets such as the Meta Quest 3"; Forward+ runs XR but is "less optimized for XR than Mobile"; Compatibility is not listed there (*documented*).
- **Deploying-to-Android page:** warns the "Mobile Vulkan renderer" "still has unresolved issues" and **recommends the Compatibility renderer (OpenGL) for Android XR targets for now** (*documented*). So **Compatibility does support XR** — the earlier assumption that it does not is wrong: WebXR runs on web (Compatibility/WebGL2) and the start script has an explicit Compatibility branch. Treat Mobile-vs-Compatibility for Quest as *unsettled in the docs*; pick per your 4.7 build and test.
- **Foveation (VRS):** if `RenderingServer.get_rendering_device()` exists (Mobile/Forward+), set `get_viewport().vrs_mode = Viewport.VRS_XR`; on Compatibility, raise `xr/openxr/foveation_level` instead (*documented*).
- **MSAA over post-AA:** XR generally wants hardware MSAA rather than TAA/FXAA because post-process AA smears across the two eye views (*interpretation* — the pages don't state an XR AA rule; `maximum_refresh_rate` default 90 is *documented*).
- **Desktop tension:** a project on the **Mobile** renderer for phones may want **Forward+** for richer PCVR — the renderer is a project-wide choice, so a shared phone+PCVR build is a real constraint to design around (*interpretation*; renderer features per [[godot-renderer-feature-matrix]]).

## 5. Platforms and export
- **PCVR (Linux/Windows):** run against an installed **OpenXR runtime** (SteamVR, Monado, a vendor runtime); Godot finds the `"OpenXR"` interface at startup. No special export beyond the desktop export (*interpretation* from the start-script/runtime model; runtime list is *unverified* on the Godot pages).
- **Standalone Android (Meta Quest, Pico, …):** needs a vendor **OpenXR loader** added manually, Gradle build (**Install Android Build Template…**), and a per-device Android export preset with **XR Mode = OpenXR**. Install the **Godot OpenXR vendors plugin** (`GodotVR/godot_openxr_vendors`): "As of Godot 4.6, the plugin is optional but recommended… and may be required for app store releases." XR Features sections cover Meta/Pico/Magicleap/Khronos (*documented*; see [[godot-export-platform-notes]] for the general Android requirements).
- **Browser (WebXR):** `WebXRInterface` is "only available when running in Web exports"; set `session_mode` (`"immersive-vr"`/`"immersive-ar"`/`"inline"`), check `is_session_supported()` asynchronously, then `initialize()` and on `session_started` set `use_xr = true`. Input via `XRController3D` or the `select`/`squeeze` signals (*documented*).

## 6. Performance targets and pitfalls
XR renders one view per eye and is latency-critical, so hold a **consistent frame rate** — on `session_begun` read `get_available_display_refresh_rates()`, pick one ≤ `maximum_refresh_rate` (default 90), apply `set_display_refresh_rate()`, and set `Engine.physics_ticks_per_second` to match or you get stuttering (*documented*). Common headset rates are 72/90/120 Hz (*interpretation* — only 90 is in the docs). Don't block the main thread (a long frame breaks presence); pause the tree on `session_visible` because "controller and hand tracking stay disabled while visible", and resume on `session_focussed` (*documented*). Handle `pose_recentered` (`XRServer.center_on_hmd()` often suffices). Use `XRServer`/`XRInterface` for play-area mode (`XR_PLAY_AREA_ROOMSCALE`/`STAGE`), `get_play_area()`, tracking status and (AR) `environment_blend_mode` (*documented*). General profiling still applies ([[godot-performance-workflow]]).

## What an agent can and cannot check
**By reading files:** that `xr/openxr/enabled` and `xr/shaders/enabled` are set; that the scene has `XROrigin3D`/`XRCamera3D`/two `XRController3D` with roles; that a start script finds `"OpenXR"`, checks `is_initialized()` and sets `use_xr`; that an OpenXR Action Map resource and tested interaction profiles exist; that `vrs_mode`/`foveation_level` and a refresh-rate handler are wired; that an Android preset sets XR Mode = OpenXR with the vendors plugin present; that WebXR code is gated to web exports. **Needs a headset/runtime/human:** comfort and real latency, whether the chosen renderer actually runs on a given Quest build, foveation/MSAA quality, that controller bindings resolve on the physical device, store-submission acceptance, and the Mobile-vs-Compatibility call for Android.

## See also
- [[godot-renderer-feature-matrix]] — XR imposes renderer choices (foveation/VRS/MSAA) the matrix otherwise omits
- [[input-handling]] — the OpenXR Action Map is a second input system beside the engine InputMap
- [[godot-export-platform-notes]] — standalone XR ships through the Android export path
- [[godot-performance-workflow]] — XR doubles the per-frame view cost and is latency-critical
- [[godot-ui-focus-and-gamepad-navigation]] — flat UI needs a ray/laser pointer in XR, not focus neighbours
- [[game-studio-vr-standards-comfort-and-distribution]] — the industry standard, comfort and distribution companion

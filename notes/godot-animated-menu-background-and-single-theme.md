---
id: godot-animated-menu-background-and-single-theme
type: guide
domain: godot
status: unreviewed
summary: "A cheap animated illustrated menu background for Godot 4.7 on the Mobile renderer (one ColorRect + one canvas_item shader that crossfades two mipmapped illustrations, slow Ken-Burns clamped inside the image, cover-fit for any aspect, free blur by textureLod, vignette and dim for legible text, a few particles, reduce-motion switch) and one code-built Theme with type variations so every panel looks the same, plus the traps hit (CanvasLayer children do not inherit the theme, Theme.set_constant needs the type, a _set method clashes with the engine, BaseButton has no text)."
aliases: [menu background shader, ken burns background, crossfade two textures shader, cover fit uv, single theme in code, theme type variation, glass panel, reduce motion]
tags: [dept/ui-ux, dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "Godot 4.7.2.stable.mono, Mobile renderer under xvfb; menu captured as PNGs from a viewer script and read by the agent; unit and integration tests; look and motion NOT judged by a human"
sources: []
related:
  - relates-to: "[[godot-ui-layout-and-themes]]"   # the documentation-level page on themes and variations
  - relates-to: "[[godot-ui-focus-and-gamepad-navigation]]"   # the focus style must stay visible in the theme
  - relates-to: "[[game-studio-accessibility-minimums]]"   # text size, contrast, reduced motion
  - relates-to: "[[godot-particles-and-shader-basics]]"   # the particle and shader basics this builds on
  - relates-to: "[[game-design-first-minute-onboarding-and-result-screen]]"   # the panels that sit on this background
created: 2026-11-16
updated: 2026-11-16
created_by_type: agent
---

> **Evidence status — own pattern, run here (interpretation).** Everything below was built and exercised in one project:
> tests passed and the running menu was captured and inspected as images. A human has not judged the look or the motion.
> It is not a vendor recommendation. Status `unreviewed`.

## 1. A background that stays cheap on Mobile
- **One `ColorRect` with a `canvas_item` shader**, two sampler uniforms (`tex_a`, `tex_b`) and a `blend` 0..1. Crossfade by
  tweening `blend` over ~2.5 s every ~25 s, swapping the texture that is *not* visible before each fade. Initialise **every**
  shader parameter in `_ready`: `float(mat.get_shader_parameter("blend"))` on an unset parameter is `float(null)` and fails with
  "Nonexistent 'float' constructor".
- **Free blur for reading panels:** import the illustrations *with mipmaps* and sample with `textureLod(tex, uv, blur_lod)`;
  `blur_lod` 0 = sharp, ~1.6–2.2 = soft enough to read text on top. No blur pass, no extra viewport.
- **Fill any aspect without stretching.** Pass a `cover` vec2 computed from the window: `screen_aspect > image_aspect ? (1, ia/sa)
  : (sa/ia, 1)`, and sample `uv = (UV - 0.5) * cover / zoom + 0.5 + pan`. Recompute on `resized`. Worked for 16:9, 20:9 and portrait.
- **Slow Ken-Burns:** zoom oscillating 1.05↔1.11 over ~40 s plus a small pan; clamp the pan inside the image every frame,
  `room = (1 - cover / zoom) * 0.5`, `pan = pan.clamp(-room, room)`. A test sweeps the cycle and mouse extremes and checks the clamp.
- **Legibility:** vignette (`smoothstep(0.95, 0.20, distance(UV, 0.5))`), `mix(colour, night, dim)` and a light tint. A 1600×900
  picture upscaled to 1920×1080 (×1.2) looked acceptable behind the dim layer (judged from captures only).
- **Life:** ~28 `CPUParticles2D` motes with a radial `GradientTexture2D` and a colour ramp that fades in and out, and a tiny mouse
  parallax (≤ ~1 % of the picture) added to the pan.
- **Moods** as a dictionary `{dim, blur, vignette}` per screen type (menu / panel / result), applied with
  `Tween.tween_method` so the picture darkens and blurs when a form appears.
- **Accessibility:** a `reduce_motion` setting makes it a still picture (no drift, no motes, no parallax) and also skips the
  panel fade. Keep it in the settings service and read it in `_ready`.

## 2. One Theme for every panel
Build the `Theme` in code (one function, `font_scale` clamped to 0.8–1.5) so a panel only has to hang under a node that carries it:
- `Button`/`OptionButton`/`MenuButton`: `StyleBoxFlat` for normal, hover, pressed, hover_pressed, **focus (always visible)** and disabled;
  `CheckBox`: transparent normal + a visible hover/focus box; `HSlider`: dark track, filled `grabber_area`, and **generated circle
  icons** for the grabber (an `Image` drawn per pixel: no image files); `LineEdit`, `TabContainer` (selected/unselected/hovered/focus),
  `PanelContainer` ("glass": dark translucent fill + accent border), scrollbars, `PopupMenu`.
- **Type variations** instead of per-control overrides: `PrimaryButton`, `DangerButton`, `QuietButton`, `TitleLabel`, `SubtitleLabel`,
  `HintLabel`, `SolidPanel` (`Theme.set_type_variation(type, base)` then style the variation); a control opts in with `theme_type_variation`.
- A text-size setting rebuilds the theme and reassigns it; touch minimum height ≥ 48 px via a small helper that never shrinks a control.

### Traps hit (all run)
- **Controls under a `CanvasLayer` do not inherit the theme of an ancestor `Control`.** A pause menu in its own layer needs
  `panel.theme = root.theme` assigned explicitly (and again when the theme is rebuilt).
- `Theme.set_constant(name, theme_type, value)` takes the type; with two arguments it fails to parse.
- A method called `_set` in a `Control` subclass clashes with the engine's `_set(StringName, Variant) -> bool`: rename it.
- `BaseButton` has no `text` property (only `Button`, `CheckBox`…): read it with `button.get("text")`.
- Tests that add a `Button` to the tree are hooked by any global autoload watching `node_added`: clear its marker before testing your own instance.

## 3. How it was checked (and what was not)
A viewer script instantiates the hub, shows each panel, waits for the fade and saves `get_viewport().get_texture().get_image().save_png(...)`;
run it under `xvfb-run` with the Mobile renderer and read the PNGs. Tests cover cover-fit maths, mood changes, crossfade end states, the
reduce-motion branch and the pan clamp. **Not verified:** frame cost on a real phone, and whether the look and the motion are pleasant.

## See also
- [[godot-ui-layout-and-themes]] — theme editor and type-variation documentation.
- [[godot-ui-focus-and-gamepad-navigation]] — keep the focus style visible.
- [[game-studio-accessibility-minimums]] — reduced motion and text-size expectations.
- [[godot-particles-and-shader-basics]] — particles and shaders in general.

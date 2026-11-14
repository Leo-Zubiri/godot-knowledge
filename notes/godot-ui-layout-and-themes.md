---
id: godot-ui-layout-and-themes
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 UI the documented way: anchors and containers, size flags, Theme resources with type variations, stretch presets and fonts — Godot Control/Theme is the UI authority."
tags: [dept/ui-ux, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "UI pages: anchors, containers, theme editor, type variations, fonts, multiple resolutions"
    ref: src-gd-ui-layout-themes
    retrieved: 2026-11-08
related:
  - relates-to: "[[gs-adr-godot-final-ui-authority]]"   # Godot owns UI implementation
  - relates-to: "[[game-studio-accessibility-minimums]]"   # text and contrast minimums
  - relates-to: "[[godot-ui-focus-and-gamepad-navigation]]"   # focus and gamepad
  - relates-to: "[[godot-localization-workflow]]"   # longer strings and fonts
created: 2026-11-08
updated: 2026-11-13
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **Anchors/offsets:** four offsets from anchors between 0.0 and 1.0 on the parent; differing paired anchors resize with the parent; select the Custom preset before hand-editing; changing an anchor moves the reference point.
- **Containers:** Box, Grid (needs column count), Margin, Tab, Split, Panel, FoldableContainer, Scroll, AspectRatio, Flow, Center, SubViewportContainer. Children of a container lose manual positioning; size flags Fill/Expand/Shrink*/Stretch Ratio per axis; MarginContainer padding is a theme constant.
- **Themes:** Theme resources hold items; a theme created from a control property is bundled with that scene until saved to a file. **Type variations** extend a base type and apply through the control's theme type variation property; a variation shows in the dropdown only if it belongs to the project-wide theme; **a mistyped name fails silently.**
- **Stretch (documented presets):** pixel art 640x360, viewport, keep/expand, integer scale; desktop 1920x1080, canvas_items, expand; mobile 1280x720 (landscape) / 720x1280 (portrait), canvas_items, expand. High-resolution bases need Default Theme Scale raised; prefer Exclusive Fullscreen (Fullscreen leaves a 1-pixel gap that can break integer scaling). `integer` scale mode since 4.2.
- **Fonts:** TTF/OTF/TTC/OTC/WOFF/WOFF2 and BMFont; hinting default Light; MSDF stays sharp at any size; pixel-art fonts need Nearest filter and integer-multiple sizes; fallbacks in Advanced Import Settings.
- **RichTextLabel/BBCode:** enable `bbcode_enabled`; connect `meta_clicked` for `[url]`; escape user input with `[lb]` to prevent BBCode injection.
- The docs give **no design-tool handoff workflow**: a Penpot/Figma design must be re-expressed as a container layout plus a Theme.

## Layout traps seen when building a list screen — hands-on (4.7.2, proposed, unreviewed)
- A **`ScrollContainer` does not give its content a width**: a `VBoxContainer` inside it takes its minimum width, so rows with `autowrap` labels collapse to one character per line
  (text rendered vertically). Fix: give the scroll a fixed `custom_minimum_size.x` and the content a minimum width, and turn `autowrap_mode` off (with `text_overrun_behavior =
  OVERRUN_TRIM_ELLIPSIS`) on short labels inside rows.
- The default `Button` style is nearly invisible on a dark background: give secondary buttons an outline `StyleBoxFlat` (accent border, translucent fill) for `normal`, `hover`,
  `pressed`, `hover_pressed`, `focus` and `disabled`, so every action is discoverable by shape and not only by text.
- `Button.text` keeps the **translation key** you assigned (Godot translates it only when drawing); a test must compare against the key, or assert on `tr(key)`. Text you
  build with `tr()` and `%` is already translated and must be rebuilt on `NOTIFICATION_TRANSLATION_CHANGED`.
- Animated "waiting…" text: keep a small list of labels and a timer-less counter in `_process` (a 4-state dot counter every ~0.45 s) instead of a Tween per label; rebuilding the
  panel just recreates the list.

## What an agent can and cannot check
Reading `.tscn`/`.tres` can verify anchors/size flags, theme references, variation names matching existing types and stretch settings versus the preset. Appearance, text fit in other languages and navigation feel need a human reviewing screenshots at several window sizes.

## See also
- [[gs-adr-godot-final-ui-authority]] — UI authority decision
- [[game-studio-accessibility-minimums]] — text and contrast minimums
- [[godot-ui-focus-and-gamepad-navigation]] — focus and gamepad
- [[godot-localization-workflow]] — longer strings and fonts
- [[godot-fonts-and-msdf-in-4-7]] — fonts and MSDF in depth (FontFile/FontVariation, fallbacks, pixel-art)

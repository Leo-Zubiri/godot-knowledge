---
id: src-gd-ui-layout-themes
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/ui/size_and_anchors.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/ui/size_and_anchors.html"
    - "https://docs.godotengine.org/en/stable/tutorials/ui/gui_containers.html"
    - "https://docs.godotengine.org/en/stable/tutorials/ui/gui_using_theme_editor.html"
    - "https://docs.godotengine.org/en/stable/tutorials/ui/gui_theme_type_variations.html"
    - "https://docs.godotengine.org/en/stable/tutorials/ui/gui_navigation.html"
    - "https://docs.godotengine.org/en/stable/tutorials/ui/bbcode_in_richtextlabel.html"
    - "https://docs.godotengine.org/en/stable/tutorials/ui/gui_using_fonts.html"
    - "https://docs.godotengine.org/en/stable/tutorials/rendering/multiple_resolutions.html"
  title: "Godot 4.7 UI: anchors, containers, themes, type variations, focus navigation, BBCode, fonts, multiple resolutions"
  retrieved: 2026-11-08
  version: "4.7 (headers reported by subagent)"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot documentation pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. **Version:** page headers say *Godot Engine 4.7 documentation* — confirmed by the main agent on the pages listed under "re-read", reported by research subagents for the others; pages carrying their own "may be outdated for 4.7" notice are flagged. Documentation only: nothing here was run in the engine, so behaviour claims are *documented*, not *experimentally validated*. Re-fetch before promoting dependent notes to `verified`.

- **Anchors/offsets:** each Control has four offsets measured from an anchor between 0.0 and 1.0 on the parent; paired anchors that differ make the control resize with its parent; the Custom preset must be selected before hand-editing anchors; changing an anchor moves the reference point; centring needs offsets of half the size with correct signs.
- **Containers (4.7 list):** Box (H/V), Grid (needs column count), Margin, Tab, Split, Panel, FoldableContainer (first release not checked), Scroll, AspectRatio, Flow (H/V), Center, SubViewportContainer. Size flags: Fill, Expand, Shrink Begin/Center/End and Stretch Ratio per axis (not every container uses them). Pitfalls: children of a container lose manual positioning; MarginContainer padding is a theme constant; custom containers must re-sort on the sort notification and call `queue_sort()`.
- **Themes:** Theme editor is a bottom panel; a theme created from a control property is bundled with that scene until saved to a file; "Override" copies a default item, "Manage Theme Items" bulk edits. **Type variations** extend a base type and can chain; applied through the control's theme type variation property (empty by default); variations appear in the dropdown only if they belong to the project-wide theme; a mistyped name fails silently.
- **Stretch/multiple resolutions:** base window size is a design size; modes Disabled (default), Canvas Items, Viewport; aspects Ignore, Keep, Keep Width, Keep Height, Expand; scale mode `fractional` default, `integer` avoids uneven pixels but leaves black bars (since 4.2 per the page). Documented presets: pixel art 640x360, viewport mode, keep or expand, integer scale mode; desktop non-pixel 1920x1080, canvas_items, expand; mobile landscape 1280x720 and portrait 720x1280, canvas_items and expand; high-end 4K bases need Default Theme Scale raised (2.0–3.0 on desktop); use Exclusive Fullscreen rather than Fullscreen (a 1-pixel gap can break integer scaling).
- **Focus/gamepad:** any Control can take focus; neighbours set in the Inspector, unset ones guessed by the engine (unpredictable in complex layouts); Labels default to focus mode None, buttons to All; call `grab_focus()` at scene start (deferred in `_ready()`) or key/button presses do nothing; a hidden node loses focus.
- **RichTextLabel/BBCode:** `bbcode_enabled` must be on; tags must nest properly; `[url]` does nothing without connecting `meta_clicked`; escape user input with `[lb]` to prevent BBCode injection; setting `text` erases `append_text()` changes; custom effects extend `RichTextEffect`.
- **Fonts:** dynamic TTF/OTF/TTC/OTC/WOFF/WOFF2 and BMFont bitmaps; hinting default Light; MSDF keeps text sharp at any size with trade-offs; for pixel-art fonts use Nearest default texture filter and integer-multiple sizes; fallbacks in Advanced Import Settings.
- The docs give no design-tool handoff workflow; the default-theme project setting and UI sound guidance were not covered.

---
id: godot-fonts-and-msdf-in-4-7
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 fonts in depth: FontFile / FontVariation / SystemFont, MSDF vs raster import, fallback chains for non-Latin, pixel-art fonts, and the dynamic render settings (hinting, antialiasing, subpixel, mipmaps)."
tags: [dept/ui-ux, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Font resources, Theme font/size items, MSDF, fallbacks, pixel-art fonts, render settings, default project font"
    ref: src-gd-fonts-and-msdf
    retrieved: 2026-11-10
related:
  - relates-to: "[[godot-ui-layout-and-themes]]"   # the Theme/Control surface that references these fonts
  - relates-to: "[[godot-localization-workflow]]"   # fallback chains and non-Latin coverage for translated UI
  - relates-to: "[[game-studio-font-licensing-and-sourcing]]"   # where fonts come from and their licences (sibling note)
created: 2026-11-10
updated: 2026-11-10
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot 4.7 documentation (pages at `/en/4.7/`, headers read *Godot
> Engine 4.7 documentation in English*, retrieved 2026-11-10, paraphrased extraction — see the cited source). Nothing
> here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were
> not found on the pages read. Status `proposed`. This note goes deeper than the one-line font bullet in
> [[godot-ui-layout-and-themes]]; that note stays the authority for the Theme/Control surface.

## 1. Font resources
- **`FontFile`** — a resource holding font source data plus a cache of prerendered glyphs. Imported from a **dynamic
  font** (TrueType, OpenType, WOFF/WOFF2, Type 1, and `.ttc`/`.otc` collections) or from a **bitmap font** (AngelCode
  BMFont `.fnt`). Since Godot 4.0 the **size is not stored in the font**, so one `FontFile` serves every size.
- **`FontVariation`** — "a variation of a font with additional settings" built on a `base_font` (the default Theme font
  when unset). It adds: extra spacing (`spacing_glyph/space/top/bottom`, prefer `set_spacing()`), faux bold
  (`variation_embolden`), a 2D outline transform for faux italic (`variation_transform`), **OpenType variation axes**
  (`variation_opentype`, e.g. `wght`; list axes with `Font.get_supported_variation_list()`), **OpenType features**
  (`opentype_features`), and `variation_face_index` to pick a face in a collection.
- **`SystemFont`** — "a font loaded from a system font"; it is **never imported into the project, loaded at runtime** from
  `font_names`. **Not portable**: it works on iOS/Linux/macOS/Windows and "falls back to a default theme font if not
  implemented on the host OS", so treat it as a fallback/convenience, not a shippable primary.
- **Theme/Control wiring:** a font reaches a Control through the **theme Font item** and a separate **Font Size item**
  (Theme Overrides > Fonts and > Font Sizes, the theme editor font tab, or a theme's **Default Font** property). Because
  size is a theme item, not a font property, one file covers all sizes.

## 2. MSDF (multi-channel signed distance field)
- Enable **"Multichannel Signed Distance Field"** per imported font in the Import dock, then Reimport
  (`FontFile.multichannel_signed_distance_field`). The glyph is rasterized **once** to a distance-field texture built from
  the vector data, so it **stays crisp at any scale and under rotation** and **one atlas covers all sizes** — ideal for UI
  that scales across resolutions.
- **Contrast with raster import:** traditional rasterization caches glyphs **per font and per size** (a new atlas entry
  per size, hinting available); MSDF caches **per font only** (no per-size atlas, no hinting).
- **Trade-offs:** higher baseline cost (noticeable on low-end mobile); **small text is less clear because hinting is
  unavailable**; new glyphs at small sizes cost more; **no LCD subpixel mode** (antialiasing is always grayscale);
  **self-intersecting outlines render incorrectly** (so avoid heavy `variation_embolden` on MSDF). Not for pixel fonts.
- **Settings:** `msdf_pixel_range` (default 16) is "the width of the range around the shape between the minimum and
  maximum representable signed distance" — with outlines set it to **at least twice the largest outline size**;
  `msdf_size` (default 48) is the "source font size used to generate MSDF textures" (higher = more precision, more
  speed/memory).

## 3. Fallbacks and glyph coverage
- The default project font (**Open Sans SemiBold**) covers limited glyphs; non-Latin text needs a **fallback chain**
  added under **Advanced Import Settings > Fallbacks** (`FontFile` fallback fonts), e.g. Noto Sans + Noto Sans CJK /
  Noto Sans Arabic. To extend the **default** font, leave **Base Font empty** so the fallbacks attach to it.
- `allow_system_fallback` (default true) additionally lets matching **system fonts** fill gaps automatically.
- This is the font half of translated UI — see [[godot-localization-workflow]], which flags that the default font covers
  only part of Latin-1 and that **asset Remaps do not swap DynamicFonts** (use a fallback chain instead).

## 4. Pixel-art fonts
- **Disable MSDF.** Set Rendering > Textures > Canvas Textures > **Default Texture Filter = Nearest**, keep the font size
  an **integer multiple** of the design size, scale the Control by an integer multiple, and set **subpixel positioning =
  Disabled**. (The docs give the Nearest-filter + integer-size + disabled-subpixel recipe; they do *not* state explicitly
  that MSDF must be off, but MSDF's smoothing defeats pixel rendering — *inference, unverified*.)

## 5. Dynamic render settings
- **Hinting:** `None` (smoothest, can blur small text), `Light` (default — snaps edges on the Y axis only), `Full` (snaps
  X and Y). No effect ⇒ the font lacks instructions; enable **Force Autohinter**.
- **Antialiasing:** `Grayscale` (default, all displays) or `LCD subpixel` (sharper small text, risk of color fringing,
  worse on OLED). MSDF ignores this and stays grayscale.
- **Subpixel positioning:** `Auto` (default; on at small sizes, off at large), `Disabled`, `One half`, `One quarter`
  (best quality, slowest).
- **Oversampling** (`FontFile.oversampling`) and **`generate_mipmaps`** exist; mipmaps are **off by default** and reduce
  graininess when text is downscaled or rendered in 3D/world space — enable them for world-space labels. (Exact
  oversampling semantics *unverified* — the tutorial only shows it in passing.)

## 6. Practical for 4.7
- The **project default font** lives in **Project Settings > GUI > Theme** (property `gui/theme/custom_font`, a String
  path; `gui/theme/custom` sets a default theme). A themed Control with no override **picks up that default** — the same
  theme-resolution surface described in [[godot-ui-layout-and-themes]]. *The exact per-property description of
  `gui/theme/custom_font` was past the read window; only its name/type/default (String, `""`) are verified — treat the
  precise semantics as unverified.*
- GUI > Theme also exposes Default Font Antialiasing / Hinting / Subpixel Positioning / MSDF / Generate Mipmaps, which
  affect **only the built-in default font**.
- As with type variations, **theme wiring fails silently**: a mistyped theme type variation name just does nothing
  (see [[godot-ui-layout-and-themes]]), so a font that "won't apply" is often a theme-item/name problem, not a font bug.

## What an agent can and cannot check
Reading `.import`, `.tres` and `project.godot` can verify: whether `multichannel_signed_distance_field`/`msdf_pixel_range`
/`msdf_size` are set, hinting/antialiasing/subpixel/mipmap flags, that a `FontFile` lists fallbacks, that pixel fonts use
Nearest + integer sizes, and that `gui/theme/custom_font` points at an existing file. It **cannot** judge rendering
crispness, whether non-Latin glyphs actually resolve for a given language, color fringing, or whether small MSDF text is
legible — those need a human viewing the text at several sizes and on real displays.

## See also
- [[godot-ui-layout-and-themes]] — the Theme/Control surface these fonts plug into (and the silent-failure caveat)
- [[godot-localization-workflow]] — fallback chains and non-Latin coverage for translated UI
- [[game-studio-font-licensing-and-sourcing]] — where fonts come from and their licences (sibling note)

---
id: src-gd-fonts-and-msdf
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/4.7/tutorials/ui/gui_using_fonts.html"
  urls:
    - "https://docs.godotengine.org/en/4.7/tutorials/ui/gui_using_fonts.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_fontfile.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_fontvariation.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_systemfont.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_projectsettings.html"
  title: "Godot 4.7 fonts: Using fonts tutorial + FontFile / FontVariation / SystemFont / ProjectSettings class references"
  retrieved: 2026-11-10
  version: "4.7 (page headers read 'Godot Engine 4.7 documentation in English')"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) extraction; not verbatim"
created: 2026-11-10
updated: 2026-11-10
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot 4.7 documentation pages at
> `/en/4.7/`, fetched 2026-11-10 through a fetch-time summarizer — a **paraphrased extraction, not verbatim text**.
> **Version:** every page listed above reports the header *Godot Engine 4.7 documentation in English*. Documentation
> only: nothing here was run in the engine. Re-fetch (or capture verbatim) before promoting dependent notes to `verified`.
>
> **Blocked page:** `https://docs.godotengine.org/en/4.7/tutorials/assets_pipeline/importing_fonts.html` returned
> **HTTP 404** on 2026-11-10 — there is no separate "importing fonts" asset-pipeline page in 4.7; the import-dock
> options are documented inside the *Using fonts* tutorial above.

## Using fonts (tutorial)
- **Dynamic fonts** (TTF, TTC, OTF, OTC, WOFF, WOFF2) are the common choice; they resize and stay crisp. Font sizes are
  **not** stored in the font since Godot 4.0 — one file serves many sizes, set under Theme Overrides > Font Sizes.
- **FontVariation** is created "in the location where you intend to use the font" for variable fonts, faux bold/italic,
  extra spacing and OpenType features.
- **SystemFont** fonts are "never actually imported into the project, but are loaded at runtime"; smaller PCK, avoids
  shipping licensed files; aliases like `sans-serif` map to the platform font.
- **Where fonts are set:** theme editor font tab, inspector Theme Overrides > Fonts, or a theme's **Default Font** property.
- **MSDF (Multichannel Signed Distance Field):** enable "Multichannel Signed Distance Field" in the Import dock, then
  Reimport. Upsides: crisp at large sizes; less first-render stutter at large sizes. Downsides: higher baseline cost
  (noticeable on low-end mobile); small text less clear (no hinting); costlier new glyphs at small sizes; no LCD subpixel
  mode; self-intersecting outlines render incorrectly. Antialiasing cannot be changed (always grayscale). For outlines,
  MSDF Pixel Range must be "at least *twice* the value of the outline size". Rasterization caches glyphs per font+size;
  MSDF is rasterized once to a distance field, so caching depends only on the font.
- **Hinting:** None (smoothest, can blur at small sizes); Light (default, snaps Y only); Full (snaps X and Y). If hinting
  has no effect the font lacks instructions — enable Force Autohinter.
- **Antialiasing:** Grayscale (default, all displays) or LCD subpixel (sharper small text, color fringing risk,
  especially OLED); grayscale recommended for most games.
- **Subpixel positioning:** Auto (default; on at small sizes, off at large), Disabled, One half, One quarter (best
  quality, slowest).
- **Mipmaps:** off by default; enable to reduce graininess when text is downscaled; also available for MSDF fonts.
- **Fallbacks:** added under Advanced Import Settings > Fallbacks (e.g. Latin + Cyrillic, or an emoji/icon fallback). To
  add fallbacks to the **default project font**, leave Base Font empty.
- **Pixel-art fonts:** set Rendering > Textures > Canvas Textures > Default Texture Filter to **Nearest**; keep the font
  size an integer multiple of the design size and scale the Control by an integer multiple; set subpixel positioning to
  Disabled. (The page does *not* explicitly say to disable MSDF for pixel fonts.)
- **Default font:** with no override, **Open Sans SemiBold** is used. Project Settings > GUI > Theme exposes Default Font
  Antialiasing, Hinting, Subpixel Positioning, MSDF and Generate Mipmaps — these affect only the built-in default font.

## FontFile (class)
A resource holding font source data and a cache of prerendered glyphs. Imported from a dynamic font (TrueType, OpenType,
WOFF/WOFF2, Type 1, collections) or a bitmap font (AngelCode BMFont). Can use "a set of fallback Fonts to use";
`allow_system_fallback` (true) lets system fonts serve as automatic fallbacks. Key properties:
- `multichannel_signed_distance_field` (default false): when true, glyphs of all sizes render from a single MSDF built
  from vector data, so resizing needs no re-rasterization; trade-off: font hinting is unavailable.
- `msdf_pixel_range` (default 16): "The width of the range around the shape between the minimum and maximum representable
  signed distance." With outlines, at least twice the largest outline size.
- `msdf_size` (default 48): "Source font size used to generate MSDF textures." Higher = more precision, more speed/memory.
- Also `generate_mipmaps`, `hinting` (dynamic only), `antialiasing`, `subpixel_positioning`, `oversampling`, `fixed_size`
  (bitmap only).

## FontVariation (class)
"A variation of a font with additional settings" (subclass of Font). Supports OpenType variations, simulated bold/slant,
OpenType features and extra spacing. Properties:
- `base_font`: the font to build on; if unset, the default Theme font is used.
- Spacing (`spacing_glyph`, `spacing_space`, `spacing_top`, `spacing_bottom`), in pixels (prefer `set_spacing()`).
- `variation_embolden`: positive thickens outlines, negative thins; emboldened fonts may self-intersect, which breaks
  MSDF fonts and TextMesh.
- `variation_transform`: 2D transform on outlines (e.g. slant for faux italic).
- `variation_opentype`: dict of variation-axis coordinates by tag/name (`wght`/`weight` are the same axis); list axes via
  `Font.get_supported_variation_list()`.
- `opentype_features`: dict of OpenType feature tags. `variation_face_index`: active face in a collection file.

## SystemFont (class)
"A font loaded from a system font. Falls back to a default theme font if not implemented on the host OS." Works on iOS,
Linux, macOS, Windows; elsewhere falls back to the default theme font. Loads "with the first matching name from
`font_names`" (array of family names). `allow_system_fallback` default true.

## ProjectSettings (class)
`gui/theme/custom_font` (type String, default `""`) and `gui/theme/custom` (type String, default `""`) exist in the
Properties table. *The per-property descriptions were past the 100k-character read window and were not captured here —
treat their exact semantics as unverified beyond the names/types/defaults.*

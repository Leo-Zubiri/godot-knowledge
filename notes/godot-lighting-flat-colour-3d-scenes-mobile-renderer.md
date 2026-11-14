---
id: godot-lighting-flat-colour-3d-scenes-mobile-renderer
type: guide
domain: godot
status: proposed
summary: "Why a small flat-colour low-poly 3D scene looks over-lit and flat, and how to fix it on the Godot 4.7 Mobile renderer: key/fill ratio, non-uniform cool ambient, tonemapping, roughness variation, rim, baked or faked occlusion, with what Mobile supports and what each step costs."
aliases: [stylised lighting, three-point lighting, key fill ratio, flat lighting, plastic look, tonemap, ambient light, mobile renderer lighting]
tags: [dept/3d-art, dept/materials, tool/godot, dim/3d]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Godot 4.7: renderer feature table (Mobile has no SSAO/SSIL/SDFGI/VoxelGI/SSR/directional PCSS; 8 omni + 8 spot per mesh; RGB10A2), ambient modes and the flat look of constant ambient, tonemapper descriptions and the Mobile tonemap_white limit, light/shadow/material/sky properties and defaults, faking GI with 10-40% shadowless specular-0 lights, LightmapGI and ReflectionProbe as the mobile GI options"
    ref: src-gd-lighting-environment-mobile-renderer
    retrieved: 2026-11-14
  - claim: "Key/fill/back light roles, fill often up to half the key, too much fill gives a flat low-contrast image, backlight rim separates subject from background; lighting ratio = (key + fill) : fill"
    ref: src-gs-three-point-lighting-and-lighting-ratio
    retrieved: 2026-11-14
  - claim: "Stylised shading conventions from a shipped game: warm-to-cool hue shift with shadows going cool not black, rim highlights for silhouettes, directional (not constant) ambient to ground models, high-frequency detail omitted in favour of shape, shading and value contrast"
    ref: src-gs-valve-illustrative-rendering-tf2
    retrieved: 2026-11-14
  - claim: "Mobile lighting cost: real-time lights and shadows are expensive, baked lighting first, blob shadows under dynamic objects, painting shade into textures, good lighting matters more than model quality"
    ref: src-gs-android-arm-lighting-for-mobile-games
    retrieved: 2026-11-14
related:
  - depends-on: "[[godot-renderer-feature-matrix]]"   # renderer choice, GI options and light limits this guide builds on
  - relates-to: "[[godot-3d-materials-and-transparency]]"   # material fields, banding and debanding
  - relates-to: "[[godot-performance-workflow]]"   # measure the cost of each step on the target device
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> **Evidence status:** engine facts are distilled from the official Godot documentation (pages under `/en/4.7/`, headed *Godot Engine 4.7*, retrieved 2026-11-14, paraphrased extractions); lighting principles come from an encyclopaedia summary of three-point lighting, a studio paper on stylised shading and a platform-vendor mobile lighting guide (see the cited sources). **Nothing here was run in the engine.** Every numeric "starting value" that is not attributed to the docs is an **agent inference** to be tuned by eye and is marked *(inference)*. Items marked *unverified* were not found on the pages read. Status `proposed`.

## Goal
Make a small indoor 3D scene with flat-colour, untextured low-poly models (for example glossy spheres on a cloth-covered table, a few stylised characters, walls and a wooden floor) read with form and depth instead of looking over-lit, flat and "plastic", on the **Mobile** renderer, with a budget of about two dynamic lights.

## Prerequisites
- [[godot-renderer-feature-matrix]] — which renderer offers which GI technique and light limits.
- [[godot-3d-materials-and-transparency]] — StandardMaterial3D basics and banding.

## Why the scene looks flat (diagnosis)
1. **Ambient is constant and too strong.** With a constant ambient colour the intensity is the same on all sides, which the docs say can make lighting look flat [src-gd-lighting-environment-mobile-renderer]. Constant ambient is fill light that reaches every surface, including the inside of shadows.
2. **Key-to-fill ratio is too low.** In three-point lighting the fill is often up to half the key, and a fill that is too intense gives a flat, low-contrast image; the lighting ratio is (key + fill) : fill, and higher means more contrast [src-gs-three-point-lighting-and-lighting-ratio]. *(inference)* Treating constant ambient plus every shadowless light as "fill": a key of about 1.0 with ambient 0.5 and a fill light of 0.7 is roughly (1.0 + 1.2) : 1.2 ≈ 1.8 : 1, below the 3:1 that a half-strength fill gives. Energies of different light types are not strictly comparable, so this is an order-of-magnitude check, not a measurement.
3. **No occlusion where objects meet.** SSAO is not available on Mobile [src-gd-lighting-environment-mobile-renderer], so nothing darkens creases and contact areas unless it is baked or faked. A studio paper calls bounced/occluded ambient "critical to truly grounding" models [src-gs-valve-illustrative-rendering-tf2].
4. **No tonemapping.** The default Linear tonemapper clips bright values, "causing bright lighting to look blown out" [src-gd-lighting-environment-mobile-renderer]. Several lights adding up on light albedos exceed 1.0 and lose all shape in the highlights.
5. **Key and fill have the same hue.** Stylised illustration and the game shading derived from it use a warm-to-cool shift: shadows go cool, not black [src-gs-valve-illustrative-rendering-tf2]. A warm key with warm ambient removes that contrast.
6. **Every material has the same response.** The default `roughness` is 1.0 [src-gd-lighting-environment-mobile-renderer]; if everything stays there, cloth, wood, paint and polished surfaces differ only by albedo. *(inference)* The "plastic" impression is mostly this uniform response plus missing occlusion, not the absence of image textures.
7. **No silhouette separation.** A back light gives a rim that separates subject from background [src-gs-three-point-lighting-and-lighting-ratio]; the stylised-shading paper emphasises silhouettes with rim highlights instead of outlines [src-gs-valve-illustrative-rendering-tf2].

## What the Mobile renderer offers (Godot 4.7 docs)
| Feature | Mobile | Notes |
|---|---|---|
| SSAO, SSIL, SDFGI, VoxelGI, SSR, volumetric fog, subsurface scattering, auto exposure | **No** | SSAO exists in Forward+ and (simplified) Compatibility only |
| LightmapGI, ReflectionProbe | Yes | the only GI options on mobile; 8 probes per mesh; baking needs a desktop GPU |
| Tonemapping (Linear, Reinhardt, Filmic, ACES, AgX) | Yes | `tonemap_white` must be 2.0 or lower on Mobile; cost rises Linear → AgX |
| Glow | Yes | looks different (lower dynamic range); docs suggest `glow_intensity` ≈ 1.5, `glow_hdr_threshold` ≈ 0.9 |
| Depth/height fog, adjustments (brightness, contrast, saturation, LUT) | Yes | fog can cause banding |
| Ambient from colour or sky, `ambient_light_sky_contribution` | Yes | *unverified*: no renderer restriction was stated on the pages read |
| Shadows, `shadow_blur`, `shadow_opacity`, omni/spot PCSS (`light_size`) | Yes | directional PCSS (`light_angular_distance`) is Forward+ only |
| Light projectors (`light_projector`), decals | Yes | a projector requires `shadow_enabled` on that light |
| Lights per mesh | 8 omni + 8 spot | fixed; 8 directional in view |
| Colour buffer | RGB10A2 | medium dynamic range, low precision — banding is more likely than in Forward+ |

All rows: [src-gd-lighting-environment-mobile-renderer]. Vignette is not a built-in Environment effect on the pages read (*unverified*); it would need a screen-space overlay or a compositor effect.

## Steps (ordered by effect per cost)
1. **Turn on a film-like tonemapper.** `Environment.tonemap_mode = TONE_MAPPER_FILMIC` (or `TONE_MAPPER_ACES` for more contrast, `TONE_MAPPER_AGX` to keep hue in bright saturated colours; AgX is the slowest). Keep `tonemap_white` ≤ 2.0 on Mobile. Filmic and ACES are pre-scaled to match Linear's brightness, so exposure can stay at 1.0 [src-gd-lighting-environment-mobile-renderer]. Cost: one full-screen curve, small.
2. **Cut the ambient and make it cool.** Lower `ambient_light_energy` until shadow sides are clearly darker than lit sides; *(inference)* start around 0.15–0.25 with a desaturated blue-violet if the key is warm. Free.
3. **Make the ambient directional instead of constant.** Keep the background as a colour but set `ambient_light_source = AMBIENT_SOURCE_SKY` with a `Sky` using `ProceduralSkyMaterial`: the docs say this source takes ambient light from the sky regardless of the background [src-gd-lighting-environment-mobile-renderer]. *(inference)* Give `sky_top_color` the cool overhead tone and `ground_bottom_color` a darker warm tone (the floor's bounce) so upward faces get more and different light than downward faces — a cheap stand-in for the directional ambient the stylised-shading paper relies on [src-gs-valve-illustrative-rendering-tf2]. Colour and Disabled sources are documented as a "slight performance boost" over Sky, so this has a small cost. Set `reflected_light_source` to Sky too if glossy objects need something to reflect, or to Disabled for a purely indoor scene with a ReflectionProbe.
4. **Restore the key-to-fill ratio.** Keep one shadow-casting key, placed 30–45° to the side of the camera axis and 30–45° above [src-gs-three-point-lighting-and-lighting-ratio]. Reduce every shadowless fill to 10–40% of the key's energy and set its `light_specular` to 0 so it adds no second highlight — the docs' own recipe for faking bounced light [src-gd-lighting-environment-mobile-renderer]. *(inference)* With a key of 1.0–1.3 that means a fill of about 0.2–0.4, tinted opposite to the key (cool against a warm key). Free (same light count).
5. **Fit the shadow to the scene.** Set `directional_shadow_max_distance` to just cover the room instead of the default 100 — the docs say lower values improve both quality and performance — and consider `SHADOW_ORTHOGONAL` or 2 splits for a small scene instead of the default (slowest) 4 splits. Use `shadow_blur` slightly above 1.0 for softer edges (higher is grainier and costlier). `shadow_opacity` below 1.0 is a documented low-cost fake of bounced light, but prefer step 2/3 for shadow colour [src-gd-lighting-environment-mobile-renderer]. Shadow cost grows with the vertices drawn into the shadow map; disable shadow casting on meshes that do not need it [src-gs-android-arm-lighting-for-mobile-games].
6. **Differentiate materials by response, not only albedo** (property names and defaults: [src-gd-lighting-environment-mobile-renderer]; values *(inference)*):
   - polished hard spheres: `roughness` 0.1–0.25, `metallic` 0, optionally `clearcoat_enabled` with `clearcoat_roughness` ≈ 0.1 (the docs cite toys and car paint for clearcoat);
   - napped cloth (table felt, matte fabric on characters): `roughness` 0.9–1.0, `rim_enabled` with `rim` 0.3–0.6 and `rim_tint` ≈ 0.5 (the docs describe rim as light scattering from micro-fur, and it only appears where scene light hits);
   - varnished wood floor: `roughness` 0.45–0.65; painted walls 0.85–0.95;
   - leave `metallic_specular` at 0.5 as the docs advise, except lowering it a little on cloth if the highlight still looks waxy.
   Glossy materials need something to reflect: one `ReflectionProbe` per room with update mode Once (rendered only when moved; Mobile allows 8 per mesh) is the documented cheap option. Cost: clearcoat and rim add per-pixel work only on the materials that enable them.
7. **Add the missing occlusion without SSAO.** In rising order of effort: (a) a blurry dark quad or decal under each dynamic object — the standard mobile blob shadow [src-gs-android-arm-lighting-for-mobile-games]; decals are supported on Mobile [src-gd-lighting-environment-mobile-renderer]; (b) ambient occlusion baked in the modelling tool into vertex colours and used through `vertex_color_use_as_albedo`, or into a texture used through `ao_enabled` / `ao_texture` (raise `ao_light_affect` above 0 if it should also darken direct light) — the docs rate a well-baked AO map above SSAO; (c) `LightmapGI` for the static room: it costs almost nothing at runtime and is the docs' recommended GI for mobile, but needs UV2, a bake on desktop hardware, and probes for dynamic objects [src-gd-lighting-environment-mobile-renderer]. Painting shade into albedo is also an accepted mobile technique [src-gs-android-arm-lighting-for-mobile-games].
8. **Separate silhouettes.** With no light budget for a real back light, use the material rim from step 6 and value contrast between subject and background (a darker or cooler wall behind a lit subject) [src-gs-valve-illustrative-rendering-tf2]. If one more light is affordable, a shadowless spot behind and above the subject is cheaper than an omni [src-gs-android-arm-lighting-for-mobile-games].
9. **Optional polish.** `adjustment_enabled` with `adjustment_contrast` and `adjustment_saturation` slightly above 1.0 *(inference: 1.05–1.15)* — applied after tonemapping; a little depth fog in the background colour for depth; glow only if bright highlights should bloom (tune as in the table); a spot light with a `light_projector` texture for a lamp-shaped patch of light (it must cast shadows) [src-gd-lighting-environment-mobile-renderer]. Each is an extra full-screen or per-light cost: add one at a time and measure on the weakest target device ([[godot-performance-workflow]]).

## Lighting or textures?
The sources point to lighting and material response first. A platform-vendor guide states that good lighting can make a bad model look better while bad lighting makes a great model look worse [src-gs-android-arm-lighting-for-mobile-games], and a shipped stylised game deliberately **omits** high-frequency detail, arguing that it competes with shape, shading and value design [src-gs-valve-illustrative-rendering-tf2]. Textures earn their place when they carry *lighting-like* information that the renderer cannot compute cheaply — baked AO, gradients, painted shade — or large surfaces that need material identity up close (wood grain on a floor, cloth weave); normal maps add shape detail by changing the light's incident angle [src-gd-lighting-environment-mobile-renderer] and are only worth it once the lighting already has contrast. *(inference)* Fix steps 1–7 before commissioning textures; if large flat surfaces still look empty afterwards, add low-contrast albedo variation or an AO/gradient bake, not photographic detail.

## Notes & pitfalls
- Changing the tonemapper changes apparent brightness and saturation: re-tune light energies **after** step 1, not before.
- On Mobile, do not copy "photorealistic" `tonemap_white` values of 6.0 or more: the docs require 2.0 or lower there [src-gd-lighting-environment-mobile-renderer].
- A shadowless fill light passes through walls and furniture; indoors keep it weak and local (short `omni_range`) — the docs note the same limit for shadowless directional fills [src-gd-lighting-environment-mobile-renderer].
- Smooth gradients on flat colours band more easily in a 10-bit buffer; enable debanding ([[godot-3d-materials-and-transparency]]) and keep fog and vignette-like effects subtle.
- `rim` depends on scene light: an object in full shadow gets no rim [src-gd-lighting-environment-mobile-renderer].
- Everything above is documented or inferred, not measured; verify visually and with the profiler on the target device.

## What an agent can and cannot check
An agent can read Environment, light and material resources and compare them with this guide: tonemap mode, ambient source and energy, fill-to-key energy ratio, `light_specular` on fills, shadow max distance, roughness spread across materials, number of lights per mesh. Whether the result *looks* right needs a rendered frame and a human eye.

## See also
- [[godot-renderer-feature-matrix]] — renderer choice, GI options and light limits this guide builds on
- [[godot-3d-materials-and-transparency]] — material fields, banding and debanding
- [[godot-performance-workflow]] — measure the cost of each step on the target device

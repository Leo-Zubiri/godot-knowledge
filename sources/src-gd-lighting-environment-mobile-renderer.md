---
id: src-gd-lighting-environment-mobile-renderer
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/4.7/tutorials/3d/environment_and_post_processing.html"
  urls:
    - "https://docs.godotengine.org/en/4.7/tutorials/3d/environment_and_post_processing.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/rendering/renderers.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/3d/lights_and_shadows.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/3d/standard_material_3d.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/3d/global_illumination/introduction_to_global_illumination.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/3d/global_illumination/faking_global_illumination.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/3d/global_illumination/using_lightmap_gi.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/3d/global_illumination/reflection_probes.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_environment.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_light3d.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_directionallight3d.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_basematerial3d.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_proceduralskymaterial.html"
  title: "Godot 4.7 docs: environment and post-processing, renderers overview, lights and shadows, StandardMaterial3D, global illumination (intro, faking GI, LightmapGI, reflection probes) and the Environment, Light3D, DirectionalLight3D, BaseMaterial3D, ProceduralSkyMaterial class references"
  retrieved: 2026-11-14
  version: "4.7 (every page was fetched under /en/4.7/ and reported the header 'Godot Engine 4.7 documentation')"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); short quoted fragments are as returned by the summarizer, not checked against the raw HTML"
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot 4.7 documentation pages fetched on 2026-11-14 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**. Documentation only: nothing here was run in the engine. The Environment and BaseMaterial3D class pages were longer than the tool's window (first 100 000 characters read). Re-fetch before promoting dependent notes to `verified`.

## Renderers overview (feature table)
- Omni/spot lights: Compatibility 8 per mesh (raisable); **Mobile 8 per mesh, 256 per view**; Forward+ 512 clustered elements (raisable). Directional lights: 8 in all renderers.
- PCSS soft shadows: omni/spot — Mobile and Forward+ (not Compatibility); **directional — Forward+ only**.
- Light projector textures: Mobile and Forward+ (not Compatibility).
- ReflectionProbe per mesh: Compatibility 2, **Mobile 8**, Forward+ unlimited.
- LightmapGI: all renderers (Compatibility renders it; baking needs RenderingDevice hardware).
- VoxelGI, SDFGI, SSIL, SSR, volumetric fog, subsurface scattering: Forward+ only.
- **SSAO: Compatibility and Forward+, not Mobile.**
- Glow, tonemapping, depth/height fog, adjustments: all three renderers. Depth of field, decals, CompositorEffects: Mobile and Forward+.
- Colour precision: Compatibility RGBA8; **Mobile "RGB10A2. Medium dynamic range, low precision"** (RGBA16F if HDR 2D is enabled); Forward+ RGBA16F.

## Environment and post-processing (tutorial + class reference)
- Ambient modes: Background (default), Disabled, Color, Sky. With a constant colour: "Ambient light intensity will be the same on all sides, which may result in the scene's lighting looking more flat." Sky contribution defaults to `1.0` ("only the ambient sky is used"); `ambient_light_color` and `ambient_light_energy` only apply when `ambient_light_sky_contribution` is below 1.0. Using ambient light alone is advised only for simple scenes, large exteriors or performance; probes or GI "simulate how indirect light propagates more accurately".
- Enum descriptions: `AMBIENT_SOURCE_BG` "Gather ambient light from whichever source is specified as the background."; `AMBIENT_SOURCE_DISABLED` / `AMBIENT_SOURCE_COLOR` each give "a slight performance boost over AMBIENT_SOURCE_SKY"; `AMBIENT_SOURCE_SKY` "Gather ambient light from the Sky regardless of what the background is." `REFLECTION_SOURCE_SKY` "Use the Sky for reflections regardless of what the background is."; `REFLECTION_SOURCE_DISABLED` is a slight performance boost, "useful for purely indoor scenes, or to maximize performance on low-end devices".
- Tonemappers (`tonemap_mode`, default `TONE_MAPPER_LINEAR` = 0): Linear "unnaturally clips bright values, causing bright lighting to look blown out. The simplest and fastest tonemapper."; Reinhardt (1) rolls off highlights, "can appear dull and low contrast", identical to Linear when `tonemap_white` is 1.0; Filmic (2) "prevent clipping of bright values and provide better contrast" than Reinhardt, slightly slower, SDR-only output; ACES (3) high-contrast film-like curve that desaturates bright values, slightly slower than Filmic, SDR-only; AgX (4) adjustable curve, best at keeping hue as colours brighten, "The slowest tonemapping option", `tonemap_agx_contrast` default 1.25 at no extra cost.
- `tonemap_exposure` (default 1.0) scales brightness before tonemapping; Filmic and ACES internally multiply by 2.0 and 1.8 to match Linear's apparent brightness. `tonemap_white` (default 1.0): at least 6.0 recommended for photorealistic lighting, but "tonemap_white must be set to 2.0 or lower on the Mobile renderer to produce bright images"; with AgX on Mobile and HDR 2D disabled the white value is ignored and 2.0 is used.
- SSAO: Forward+ and Compatibility only. "SSAO only acts on *ambient* light. It does not affect direct light." unless Light Affect is raised. SSIL, SDFGI, auto exposure: Forward+ only.
- Glow (`glow_enabled`): all renderers; "When using the Mobile rendering method, glow looks different due to the lower dynamic range"; class reference suggests `glow_intensity` about 1.5 and `glow_hdr_threshold` about 0.9 on Mobile; mobile platforms default to bilinear glow upscaling, bicubic "has a performance cost on the GPU which can be significant on integrated graphics".
- Fog: depth and height fog (`fog_enabled`, `fog_mode` EXPONENTIAL/DEPTH, `fog_density` default 0.01, `fog_light_color`, `fog_depth_begin`/`fog_depth_end`); fog "can cause banding to appear on the viewport, especially at higher density levels".
- Adjustments: `adjustment_enabled` must be true; `adjustment_brightness`, `adjustment_contrast`, `adjustment_saturation` (defaults 1.0), `adjustment_color_correction` (1D gradient or 3D LUT); "Adjustments and color correction are applied *after* tonemapping."
- No built-in vignette was listed on the pages read.

## Lights and shadows (tutorial + Light3D / DirectionalLight3D class reference)
- `light_energy` (default 1.0) is a multiplier, not a physical unit. `light_specular` (default 1.0): "At zero, this light becomes a pure diffuse light." `light_negative` subtracts light. `light_cull_mask` limits which layers are lit (excluded objects still cast shadows).
- `shadow_enabled` (default false) "significant performance cost". `shadow_bias` 0.1, `shadow_normal_bias` 2.0 (prefer raising normal bias). `shadow_blur` (default 1.0) multiplies the blur radius; higher is softer but grainier and costlier. `shadow_opacity` (default 1.0): values below 1.0 let light through shadows, described as a low-cost way to fake global illumination.
- `light_size` (omni/spot, PCSS, costly above 0.0; positional PCSS is Forward+ and Mobile only). `light_angular_distance` (directional PCSS): **Forward+ only**.
- `light_projector`: texture projected by the light; **requires `shadow_enabled`**; Forward+ and Mobile only. Projectors multiply the light colour, so raise energy to compensate.
- DirectionalLight3D: `directional_shadow_mode` default `SHADOW_PARALLEL_4_SPLITS` (2, slowest); `SHADOW_ORTHOGONAL` (0) fastest, may blur nearby shadows; `SHADOW_PARALLEL_2_SPLITS` (1). `directional_shadow_max_distance` default 100.0 — "Always make sure to set a shadow **Max Distance** according to what the scene needs"; lower improves quality and performance. `directional_shadow_fade_start` 0.8. A large object across four splits is drawn five times.
- Spot shadows are "significantly faster" than omni shadows (one shadow texture). Omni shadow modes: Cube (default, slower) or Dual Paraboloid (faster, can deform).
- Limits: Mobile "8 OmniLights + 8 SpotLights per mesh resource", 256 + 256 in view, not changeable; up to 8 directional lights in all renderers.
- Shadow filter quality default Soft Low; directional shadow map size default 4096, 2048 suggested "for low-end GPUs". AreaLight3D is the most expensive light.

## Faking global illumination (tutorial)
- Covers indirect diffuse only. For a DirectionalLight3D: add a second directional light rotated 180 degrees, shadows off, energy "10-40% of the original value" ("There is no 'perfect' value"), specular 0.0. For positional lights: a secondary OmniLight3D at the same place (or near the main impact point of a spot), range +25-50%, shadows off, energy 10-40%, specular 0. Disabling shadows reduces the secondary light's cost. Indoors a shadowless directional fill remains visible through walls. ReflectionProbes are cheap enough to pair with this.

## Global illumination intro, LightmapGI, reflection probes
- For mobile, "LightmapGI and ReflectionProbes are the only supported options"; where neither is possible, "relying on environment lighting alone or a constant ambient light factor may be a necessity" and "adjusting the ambient light color and sky contribution still makes it possible to achieve acceptable results". SSAO "has a significant performance cost".
- LightmapGI: baked lightmaps "work fine on low-end PCs and mobile devices, as they consume almost no resources at runtime"; completely static; needs UV2 (import option Light Baking = Static Lightmaps), texel size default 0.2; light bake modes Disabled / Dynamic (default; only indirect baked) / Static (direct + indirect baked, best performance); dynamic objects are lit through probes (automatic `Gen Probes > Subdiv` or manual LightmapProbe); environment mode for the bake can be Disabled for purely indoor scenes; no reflections (use ReflectionProbes indoors); baking is GPU-based and cannot be done in the web editor; up to 8 LightmapGI nodes rendered at once.
- ReflectionProbe: "a source of reflected and ambient light for objects inside their area of influence"; update mode Once (default) renders only when the probe moves, Always re-renders every frame and is much more expensive; ambient modes Disabled / Environment / Constant Color; Interior stops sky ambient and sky rendering into the probe; box projection has a small cost and suits box-shaped rooms; "you should generally have one ReflectionProbe node per room"; Mobile limit 8 probes per mesh.

## StandardMaterial3D (tutorial + BaseMaterial3D class reference)
- Defaults: `roughness` 1.0, `metallic` 0.0, `metallic_specular` 0.5 ("leave it at `0.5` and don't touch it unless you need to"; minimum internal reflectivity 0.04). Roughness 0 is "a perfect mirror", 1 fully blurs the reflection.
- `rim_enabled` (false), `rim` 1.0, `rim_tint` 0.5: simulates light scattering from micro-fur; it takes scene light into account ("no light means no rim"); size depends on roughness; tint 0 uses the light colour, 1 the albedo.
- `clearcoat_enabled` (false), `clearcoat` 1.0, `clearcoat_roughness` 0.5: a secondary transparent specular pass; examples given are car paint and toys.
- `ao_enabled`, `ao_texture`, `ao_light_affect` (0.0 = ambient only): baked AO map controls ambient light per surface; a well-baked AO map is said to be higher quality than SSAO and recommended when possible.
- `vertex_color_use_as_albedo`, `vertex_color_is_srgb` (the sRGB flag is only effective with Forward+ and Mobile).
- `diffuse_mode`: Burley (default), Lambert, Lambert Wrap ("Extends Lambert to cover more than 90 degrees when roughness increases"), Toon. `specular_mode`: SchlickGGX, Toon, Disabled; Forward+ uses multiscattering, Mobile and Compatibility single scattering (rough metals slightly darker). `shading_mode`: per-pixel (default), per-vertex (cheaper, can help low-end/mobile), unshaded.
- Emission adds light to the image but lights neighbours only with VoxelGI/SDFGI (or when baked). Subsurface scattering is Forward+ only. `disable_ambient_light` exists per material.

## ProceduralSkyMaterial (class reference)
- Lightweight sky material for a Sky resource: `sky_top_color` (default 0.385, 0.454, 0.55), `sky_horizon_color`, `ground_horizon_color`, `ground_bottom_color` (default 0.2, 0.169, 0.133), `sky_energy_multiplier`, `ground_energy_multiplier`, `energy_multiplier`, `sky_curve`, `ground_curve`, sun parameters.

---
id: src-gs-android-arm-lighting-for-mobile-games
type: source
domain: game-studio
source:
  url: "https://developer.android.com/games/optimize/lighting-for-mobile-games-with-unity"
  title: "Android Developers — Lighting for mobile games with Unity (portions contributed by Arm Limited)"
  retrieved: 2026-11-14
  version: "live page as of the retrieval date"
  capture: paraphrased
  retrieved_via: "fetch tool (WebFetch); the tool returned near-complete page text, quoted fragments below come from that output and were not checked against the raw HTML"
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). The page is written for another engine; only the engine-agnostic mobile lighting advice is kept. Re-fetch before promoting dependent notes to `verified`.

- "Lighting can make or break the visuals of a game. For example, good lighting can make a bad model look better in-game, while bad light can make a great model look worse."
- Forward rendering: "real-time lights are very expensive. If you reduce the number of lights present per pixel, you can offset this cost."
- "The rendering cost of a lightmap texture is always much cheaper than dynamic lighting. We recommend that baked lighting be your first choice for implementation into a mobile game." Baked light is static; apart from the lightmap texture there is no extra runtime cost; lightmap size (texel density) must be watched for memory. Avoid spending texels on unseen surfaces, surfaces with little light variation and small or thin objects.
- "Fake lighting as much as possible". "Real-time shadows are expensive." The cost of rendering the shadow map "is proportional to the number of vertices drawn with shadows enabled"; limit the geometry that casts shadows and the number of shadow-casting real-time lights.
- Fake shadows for dynamic objects: "Use a 3D mesh, such as a plane or quad, placed under the character, and apply a blurry texture to it", or a custom blob-shadow shader.
- "Paint light information directly on textures": "If you paint some of the shade into textures, you reduce the computation required for extra lights."
- Light probes integrate dynamic objects with baked lighting more cheaply than real-time lights; without them dynamic objects "feel like they aren't part of the Scene".
- Turn off unused per-mesh features such as shadow casting when a blob shadow is used.
- Real-time light types by cost: directional is the cheapest ("You often only need one directional light per Scene"); spot lights are cheaper than point lights (keep the cone tight); point lights are the most expensive, especially with shadows. The page recommends against dynamic lights in mobile games where baked lighting, probes and fake lighting can do the job.

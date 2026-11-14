---
id: src-gs-design-hitstop-and-camera-shake
type: source
domain: game-studio
source:
  url: "https://sourcegaming.info/2015/11/11/thoughts-on-hitstop-sakurais-famitsu-column-vol-490-1/"
  urls:
    - "https://sourcegaming.info/2015/11/11/thoughts-on-hitstop-sakurais-famitsu-column-vol-490-1/"
    - "https://critpoints.net/2017/05/17/hitstophitfreezehitlaghitpausehitshit/"
    - "https://kidscancode.org/godot_recipes/3.x/2d/screen_shake/"
    - "https://gdcvault.com/play/1023146/Math-for-Game-Programmers-Juicing"
  title: "Hit-stop and camera shake: fan translation of Masahiro Sakurai's Famitsu column on hitstop (vol. 490-491, 2015); Critpoints article on hitstop (2017); a Godot 3.x recipe for trauma-based screen shake; GDC Vault session page for Eiserloh's 'Math for Game Programmers: Juicing Your Cameras With Math' (GDC 2016)"
  retrieved: 2026-11-14
  version: "live pages as of the retrieval date"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); quoted fragments as returned by the summarizer. The GDC talk video/slides were NOT read."
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). Paraphrased extraction. The Sakurai text is a **fan translation** whose translators warn it may not reflect the author exactly. The camera-shake recipe targets Godot **3.x** (API names differ in 4.x) and is a secondary rendering of a GDC talk that was not read here.

## Sakurai on hitstop (Source Gaming translation of Famitsu column vol. 490-491)
- Definition: when a hit lands "both parties momentarily freeze, emphasizing the power of impact." Common in 2D fighters; games with many simultaneous targets use little because frequent freezes would slow play.
- Attacker and target freeze for the same time. "In general, the more damage an attack inflicts, the longer the hitstop period." Per-attack modifiers exist (a sword tip more than the blade edge; electric attacks get more; projectiles comparatively less).
- **Cap:** there is a maximum freeze length that no attack exceeds regardless of damage.
- **Multiplayer limit:** he would like longer hitstop but does not add it, because "When you and the opponent are frozen in hitstop, that creates a chance for a third player to move in and strike."
- **Vibration during the freeze:** the hit character shakes and "the attacker also vibrates slightly"; characters "vibrate visually, but keep the hurtbox locations static"; "grounded characters in hitstop vibrate side to side and aerial characters in hitstop vibrate up and down"; "we alter the intensity of the vibration depending on the distance of the camera"; the vibration tapers, "starting out large and growing much smaller by the end".
- The switch from the first flinch frame to the hurt pose happens during the freeze (four frames are mentioned for that transition), so it does not look abrupt. The attacker keeps drifting at a very small speed during the freeze (compared to slow motion) and snaps back afterwards.
- **No freeze-frame totals, thresholds or multipliers are given in the column.**

## Critpoints, "Hitstop/Hitfreeze/Hitlag/Hitpause" (2017-05-17)
- Hitstop is "basically when the game freezes the characters at the point of collision during an attack."
- Functions: sells the collision; gives the eyes a few frames to register the hit; makes hits feel more powerful; in fighting games it also widens cancel windows. A game without it "weakens the impact of the hit perceptually."
- Only figure: Street Fighter 2 froze both characters for "like 10 frames". No millisecond values, no scaling guidance, no discussion of drawbacks.

## Godot 3.x recipe "Screen Shake" (kidscancode.org)
- States it is "emulating the technique outlined in the following GDC talk" (embedded video; the talk is not named in the extracted text).
- Model: a `trauma` value in 0..1; "Every time something happens that should shake the camera, we'll add a bit more trauma."; capped at 1.0; decays each frame by `decay * delta`; the shake amount is `trauma` raised to `trauma_power`.
- Defaults in the recipe: `decay = 0.8`; `max_offset = Vector2(100, 75)` pixels; `max_roll = 0.1` radians (comment: use sparingly); `trauma_power = 2` (suggested range 2-3, "typically the best").
- Uses gradient noise (`OpenSimplexNoise`, period 4, octaves 2) instead of per-frame random values, which the page calls "erratic"; three distant samples give rotation and the two offsets.
- Advice: the effect "adds a lot of appeal" when used well but "players hate it" when misused.

## GDC Vault session page (Eiserloh, SMU Guildhall, GDC 2016)
- Session covers the math behind camera behaviours in 2D and 3D games: framing techniques, smoothed camera motion, camera shake and dynamic split-screen. Tagged as free content.

## Search-summary pointers (NOT read on a primary page — `unverified`)
- Secondary write-ups attribute the trauma/noise shake model to the Eiserloh talk and report its advice to use translational **and** rotational shake in 2D but **rotational only in 3D** (translating a 3D camera can push it through geometry).
- General game-feel sites give hit-stop figures of roughly 2-4 frames for light hits and 5-8 frames for standard hits at 60 fps, and engine tutorials commonly use about 0.08 s driven by a real-time timer. None of these pages was read in full.

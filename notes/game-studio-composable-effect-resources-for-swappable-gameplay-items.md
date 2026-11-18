---
id: game-studio-composable-effect-resources-for-swappable-gameplay-items
type: pattern
domain: game-studio
status: unreviewed
summary: "A Godot 4 pattern for per-turn swappable gameplay items (billiard cues, weapons, power-ups) that stays extensible: the item is a thin Resource holding three decoupled slots — a list of stateless effect Resources with neutral hooks, a model Resource with a fixed anchor contract, and a summon/VFX Resource — plus a folder-scanning registry and a stack of weight-modifier Resources for the random draw (rarity, pity, catch-up). Includes the pitfalls hit while building it: builder calls used as existence checks leak nodes, a first-person camera inside a visible character hides the view, and an analytic cushion needs a height test to let airborne balls leave the table."
aliases: [cue effects, item effect resources, strategy resources godot, weighted draw modifiers, pity timer, catch-up mechanic, loot table modifiers, composable item pattern]
tags: [dept/gameplay, dept/architecture, tool/godot]
applies-to:
  min: "Godot 4.3"
  tested: "Godot 4.7.2, GDScript, gdUnit4 headless (1086 tests green); NOT balance-tested by playing — weights and effect numbers are first guesses"
sources: []
related:
  - relates-to: "[[game-studio-categorised-audio-catalog-pattern]]"   # same idea for data: add a file, not code
created: 2026-11-17
updated: 2026-11-17
created_by_type: agent
---

> **Evidence status — `unreviewed`.** Built and unit/integration-tested in one project (a pool game); the structure is proven to work and to be
> extensible by a test that registers a custom effect without touching the core. **Not verified:** game balance, how the draw *feels*, and
> whether the code-built models read well on every device (checked only in headless-Linux screenshots).

## Problem
"Each turn you get one of N items, each with advantages and disadvantages, and we will add many more." A flat Resource with one field per
property (`power_scale`, `sway_deg`, `lift_deg`…) forces edits to the item type, the code that applies it, its `is_plain()`, the UI and every
test for **each new property**.

## Shape that scales
1. **Item = thin Resource** (`id`, i18n keys, `weight`, `rarity`, `quality` −2…+2, `tags`) with **three slots**:
   - `effects: Array[Effect]` — behaviour, composable and stackable.
   - `model: Model` — 3D look, behind a contract.
   - `summon: Summon` — entrance animation data (duration, spark count, colour override).
2. **Effect = abstract Resource with neutral hooks**; a subclass overrides only what it uses:
   `constrain(limits)`, `on_aim(ctx, delta)`, `on_clear(ctx)`, `modify(shot, ctx)`, `describe() -> [{key,args,good}]`.
   - Effects are **shared data and hold no state**; per-turn state (time spent aiming, rng, seat, draft) lives in a `Context` (`RefCounted`).
     That also makes them unit-testable with a hand-built context and no scene.
   - `constrain` fills a `Limits` object (min/max/fixed power, min elevation) that **accumulates across effects** and that UI or AI can read
     without knowing any effect. The bar then maps through the limits (`lerp(min, max, bar)`), which is better than clamping: a full bar is
     always the item's maximum.
   - `describe()` lets the HUD list "+ advantage / − drawback" lines from the effects themselves; nothing is written twice.
3. **Model contract** instead of a type per item: a node with the origin at the working tip and +Y pointing at the target. A code-built
   shape (`match kind`) and a Blender `PackedScene` are interchangeable as long as they respect it. One list constant of known kinds
   (`has_kind`) answers "does this item have a custom model?" without building anything.
4. **Registry**: base list in code + every `.tres` in a folder; same `id` replaces (except slot 0, the plain item); a `problems(item)`
   check used by a catalogue test (i18n keys exist in every locale, model present unless plain, no null effects, unique ids).
5. **Draw modifiers** (`DrawModifier` Resource with `adjust(weights, items_by_id, ctx)`), applied in order after `weight × rarity_weight`:
   - **Pity** — after N turns without a helpful item (`quality > 0`), boost helpful ones.
   - **CatchUp** — the player who is behind gets more helpful items, the one ahead more hindering ones; capped.
   - Presets (`classic` / `normal` / `chaos`) are just differently configured config resources.
   - Keep a **per-seat shuffled bag** for *whether* a turn gets a special item (equal counts for both players), and let modifiers decide only
     *which*. Dice per turn let one player draw four in a row.
   - Expose the final weights (`last_weights`) for a debug overlay and for statistical tests.
6. **Custom property = new script** `extends Effect`, dropped on the item's `.tres`. A test defining the effect inside the test file proves
   the core never needs to change.

## Update 2026-11-17 — models must be real assets, and the object itself must do the hitting
Code-built primitive models were rejected by the owner, and "held vertically next to the body + a small piece at the tip of a stretchy arm" did
not read as using the item. What worked (screenshots reviewed; not play-balanced):
- **Free models + a normalising builder.** The model Resource holds a `.glb`, `tip_axis` (model-space direction from grip to the useful end),
  `length`, `grip_at`, `roll_deg`. `build()` computes the AABB recursively (skip the root's own transform), projects its 8 corners on the axis,
  rotates the axis to +Y, scales to `length`, and puts the **grip at the origin**; it stores `tip_len` / `butt_len` as node meta. Any CC0 model
  then works without editing it. The long axis differed per model (wrench Z, mallet Y, baguette/rolling pin/spoon X, carrot −Y, Kenney blasters −Z)
  and **two came out reversed** (wrench, spoon): always review a contact sheet with the object pointing at a target and flip `tip_axis`.
- **Hand follows the grip.** Aim target for the arm = ball − dir·(tip_len + gap), so at full reach the *tip* touches the ball; while aiming keep a
  fixed partial reach (~0.4) so the object already points at the ball; the existing strike tween then thrusts it and `strike_reached` fires when
  the tip arrives. Test it: dot(object +Y, direction to ball) > 0.98 while aiming and tip-to-ball distance < 0.12 at the strike.
- **Kenney GLBs reference `Textures/colormap.png` externally** and each kit has its own colormap: keep one folder per kit with its `Textures/`.
  **Godot also extracts embedded textures** of other GLBs as sibling PNGs on import (6 files for two tool models), which a provenance linter will
  flag: register them (or the lint fails). The two OpenGameArt tool models weigh 18 MB with their textures; 512 px textures or a re-export would
  shrink them (not done).
- **Where free models were found (CC0, checked on each page):** Kenney Blaster Kit (18 toy blasters, GLB), Kenney Food Kit (baguette, carrot, spoon,
  rolling pin, frying pan…, GLB), OpenGameArt "Tool Pack 1/2" by LonesomeDucky (adjustable wrench, rubber mallet; GLB with PBR). No CC0 slingshot,
  curved cue or pool cue was found, so those items left the catalogue. `opengameart.org` answers 403 to the fetch tool but serves a logged-in
  browser (Firefox MCP) fine; downloads there are limited to `~/.firefox-devtools-mcp/output/`.

## Update 2026-11-17 (2) — look at it running, then fix proportions and the "magic" holding
Screenshots of the real game (not a test) found what tests could not: the **default/classic item had no model at all** (the gnome aimed empty-handed),
and the free models were **far too big** (a real-size ratio matters: table 2.54 m, ball 5.7 cm → classic cue 1.45 m, props 0.3–0.7 m). Fixes that held:
- **Levitate instead of gripping.** If the fiction is magic, drop the arm: the object hovers ahead of the character (slight lift + sine bob), always
  oriented at the target, and `reach` 0→1 lunges its origin along the line until the *tip* touches the ball while the lift fades to 0. Never let it move
  backwards when the target is close (`ready_off = min(ahead, strike_off)`).
- **Procedural default cue** (no CC0 pool cue exists): tapered cylinders (butt cap, dark butt, ring, maple shaft, white ferrule, blue tip) with real
  thickness ×1.3; run it through the same normaliser as the `.glb` models (builder id instead of a scene).
- **`thickness_scale`** (shrink everything perpendicular to the tip axis) turned a stubby Kenney loaf into a baguette.
- Review loop that worked: a temporary scene driving the real game (`GnPoolGame`) with each item in first person, side view and mid-strike, saved with
  `xvfb-run` and viewed; keep it out of the commit.

## Update 2026-11-17 (3) — weight is a control feel, not object wobble; always-visible held item
Owner feedback after playing: objects that rotate/tremble to "show instability" look bad; an item that tucks close to the character is sometimes
off-screen in first person. What worked:
- **"Heavy" = input feel.** Effect sets `draft.aim_gain < 1` and `draft.aim_lag > 0`; `add_aim` multiplies by the gain and queues the degrees, and
  `advance_aim(dt)` consumes the queue exponentially (`k = 1 − exp(−dt/lag)`) so it is easy to overshoot. **Pitfall:** `set_aim` ignores changes below
  float tolerance (~1e-5 relative), so a long tail of tiny steps was silently dropped — finish the queue when the next step is imperceptible (< 0.005°).
  "Steady" is the opposite (gain < 1, no lag) for easy straight shots. Both reset in `on_clear`.
- **Hold the item on the shot line, not on the character.** Pass the real shot direction to the view (`cue_aim_dir`) and place the item at
  `tip_goal − dir·tip_len − dir·pullback + side·small + up·lift`, aimed at the ball. Then any camera that orbits behind the shot sees it. Build the
  basis from `UP` (`ox = oy × UP`, `oz = ox × oy`) so the roll is fixed and the object never spins; a `lie_flat` option rolls the model so its thinnest
  dimension is vertical (a wrench lying on its side, not on edge).
- **Hands up** (a vertical + forward offset of both glove parts, scaled by the summon pop) sells "levitating it" without any arm geometry.
- Curating the catalogue by looking at it: a flat hexagonal spoon seen from above became a giant blob in first person → dropped. Check each model
  from the actual gameplay camera, not only from a contact sheet.
- A baseball bat (CC0, OpenGameArt "Old Wooden Baseball Bat", PSX GLB of 11 KB; the 7.7 MB PBR version was not needed) gave a power/straight/no-spin item.

## Update 2026-11-17 (4) — character position must agree in every phase; casting hands
- **A fix applied to one phase of a character's placement must be applied to all of them.** The shooter stood beside the shot line while aiming (so the
  floating cue did not pass through the body) but the *run to the shot spot* still used the on-line point, so at the shot the character re-centred and
  the cue went through it. One function (`shooter_spot(cue, dir)`) now feeds aiming, the shot dash and the "shot started" re-target. Add a test that
  samples the character's distance to the line *during the shot gesture*, not only while aiming.
- **Hat/appendage deformation can be signed.** The vertex-bend that curled a hat tip forward already worked backwards with a negative parameter;
  only the range comment and new idle animations were needed. A second idle set (curl back, shiver, wobble, quick hops) plus a slow hat sway while
  standing added life; a standing body must *not* rock if an earlier test/decision says so (move the motion to the hat).
- **Casting hands without new geometry:** raise both gloves, rotate the palm toward the object (`rotate_x`), splay (`rotate_z` by side), flatten
  with a non-uniform scale, and add a bright unshaded core + three orbiting spheres tinted by the item's rarity (no alpha needed on Mobile).

## Update 2026-11-17 (5) — swappable magic circle (shader), cartoon gloves, uniform draw, placing state
- **A swappable 2D "summoning circle" as a data Resource + one shader.** `GnMagicCircle` (pattern enum, colour, accent, intensity, spin, pulse, diameter,
  reveal seconds) drives a spatial shader that draws rings, counter-rotating dashes, 12 procedural rune glyphs and a central pattern by SDFs: pentagram,
  yin-yang, two fish, ouroboros. No textures; a new pattern = one `pattern` branch + one enum value; a per-item `circle` slot lets a spell carry its own.
  Lessons: (1) `TAU` is a built-in in Godot shaders — redefining it is a shader error that renders nothing (check the log, the quad just goes black);
  (2) **additive blending turns purple into near-white on a green felt** — use `blend_mix` with alpha = mask and a brightness boost instead;
  (3) keep it flat on the felt under the item and small (0.6 m): a big one fills the bottom of a first-person view.
- **Hands: model a real glove in Blender, not blobs.** A script (`art-src/scripts/export_hand.py`, `blender -b --python … -- out.glb`) builds an
  ellipsoid palm, three fat fingers fanned and curled slightly, a thumb and a flared cuff with bmesh, subdivides once, normalises to height 1 with the
  origin at the palm and exports two materials (glove recoloured per instance by overriding surface 0 with the gnome's own hand material; cuff stays
  white). Swap it in only for the casting pose; mirror the left hand with a negative X scale; tilt forward and splay outward, and wiggle with a sine.
- **While the item levitates the character should look busy:** deeper breathing (×3), hat and beard sway, hat-tip curl wobble, hands bobbing — all
  scaled by one `lev` value that drops to 0 when the item is hidden.
- **Equal probability is a configuration, not code:** with every weight 1, rarities equal, no modifiers and `special_chance = 1`, include the default
  item in the draw (weight 1) so it is as likely as the others; test it statistically (4000 draws, each within ±22 % of the mean). Keep pity/catch-up
  available but off.
- **Placing state must hide the real thing.** While the player is placing the cue ball (ball in hand, or choosing the break position) the real ball's
  view, the floating item and the aim line must be hidden and only the ghost shown; `aiming` must exclude `placing` or both overlays fight. Capture the
  state (top-down) to verify. Also align a floating item *parallel* to the shot line with zero lateral offset: pointing it from a lifted/offset origin
  to the ball made it look crooked in first person.
- A 62-item gnome suite passed alone but a per-frame-sampled test (crouch of 0.04 s at 3× speed) failed every full run once load grew: slow the clock
  in such tests instead of retrying.
- Where a baguette was found: Isa Lousberg's "Tiny Treats – Baked Goods" (OpenGameArt, CC0, glTF+bin+atlas PNG); its long axis was Z (not X) and it is
  stubby (3.3:1), so a `thickness_scale` of 0.5 made it read as a baguette.

## Update 2026-11-17 (6) — a gating "summon" sequence, human-paced AI, world-space circle
- **Make the ritual part of the turn rules, not just a visual.** The item is drawn at the turn start but the character *summons* it first:
  idle → inhales and gathers energy (squash + lean back + hat tilted back) → hands rise (back-ease) → the circle starts drawing (sound plays *here*) →
  burst of sparks → the item pops in. Three tweened phases (`windup`, `circle_seconds`, `duration`) live in a data Resource; `total_seconds()` is the
  lock. While `is_summoning()`: the controller refuses aim/shoot (`locked`), the shot clock is `paused` (still shows), and the CPU waits. If the item is
  drawn while the ball is in hand, the summon is *pending* and starts when aiming starts. Keep the item invisible (`prepare_summon`) between the draw
  and the call, otherwise it pops in before the ritual.
- **Provide an escape hatch for headless tests** (`summon_in_headless`, false by default): dozens of tests shoot right after `start()` and would
  otherwise wait ~2 s. Same precedent as using another settings file when headless. Tests of the ritual itself switch it on.
- **A human-paced CPU opponent** makes harassment mechanics playable: think time random per level *plus* extra for hard shots (cut angle and distance →
  difficulty 0..1), then swing the aim gradually, sometimes overshoot and correct, ramp the power, show the aim for a random moment, and re-check
  before firing (if a thrown object nudged the aim, correct again, max twice). Apply tweened changes **relatively** (`add_aim(v − previous)`) so a
  disturbance injected mid-tween is kept; guard every callback with the turn token; use a node-owned tween so it stops with the pause.
- **A world-space effect that must never tilt** (summoning circle under a levitating item): make it a child of the character root (not of the animated
  model) and `top_level = true` with `global_transform = (scale only, world position)`; take the Y from the ball/felt, not from the item.
- Audio: Freesound originals need a logged-in session; the public preview (`cdn.freesound.org/previews/<id>/<id>_<user>-hq.mp3`, ~170 kb/s) is
  fetchable with curl and was enough here. **ffmpeg `loudnorm` upsamples its output to 192 kHz** — add `-ar 44100` after it or Godot's WAV importer
  silently produces no resource (`load()` returns null while `ResourceLoader.exists()` is true). A CC BY sound needs a visible credit: add a small
  `attribution_credits()` list to the licences screen and a test that every CC-BY catalogue entry is credited. Don't re-run a whole audio build just to
  add one file if it re-encodes music and deletes tracked `.import` files; restore with `git checkout` and keep only the new entries.

## Update 2026-11-18 — a ground-projected glow must clear the nearest occluders
A decal-like effect drawn flat on the playing surface (the summoning circle, 0.42 m wide) was hidden by the table rails (5 cm above the felt) whenever its
subject sat near a rail or the camera was low. Fix: give it a **config height above the surface that is greater than the tallest nearby occluder**
(`circle_height` 0.07 m > `RAIL_HEIGHT` 0.05 m), keep it world-horizontal, and put the value in the world's config (the shared character code only
holds a default). Verify with the worst case in a real capture — subject glued to the rail, low camera, and first person — and add a test that the
effect's Y is ≥ surface + occluder height (and not much more, so it still reads as lying on the table). The value is a trade-off: higher clears
more geometry but starts to look like it floats.

## Pitfalls found
- **Calling a builder just to ask "does it exist?" leaks nodes.** `defaults()` called `Models.build(id) != null` on every call → thousands of
  orphan nodes and gdUnit reporting 12 650 orphans. Use a constant list / `has_kind`.
- **First person with a *visible* character:** the camera sits where the character stands, so its own hat fills the screen. Offset the
  character sideways from the camera line (config `side_offset`, here 0.6 m) and keep a config switch to hide it. Update tests that assumed
  "hidden ⇒ stands exactly where the camera is".
- **Held vs extended item:** with a stretchy arm that is hidden when retracted, an item "summoned" into the hand needs a second, held copy
  parented as a *sibling* of the arm (same coordinate space) and positioned from the hand each frame; the summon tween must be separate
  from the gesture tween (`_new_tween()` kills the previous gesture).
- **Cheap summon VFX on Mobile (no alpha blend):** `CPUParticles3D` one-shot with an unshaded emissive sphere, plus a `TorusMesh` ring that
  scales up then to ~0 instead of fading.
- **Analytic cushion + airborne ball:** a reflect-and-clamp wall bounce keeps airborne balls on the table. Test the centre height
  (`y − radius > rail_clear_height`) and skip the bounce; also skip when the ball centre is already beyond the table edge, or it is snapped
  back from outside. The existing off-table rule then applies. Ball rolling on the cloth is unaffected (physics audit unchanged).
- **Interrupting a shot in progress:** if the strike is a delayed pending impulse, "being hit during the wind-up" can rotate that pending
  velocity vector (`deflect_pending(deg)`) — no input rewrite needed.
- **A timing-based test (`legs` crouch overshoot sampled per frame) failed in about half of the full-suite runs and passed alone every
  time** — frame-rate sensitive, not caused by the change. Re-run; consider sampling it in physics frames.

## When not to use
For two or three fixed variants, a plain Resource with a few fields is simpler. This pattern pays off once new items *and* new kinds of
property are expected.

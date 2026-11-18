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

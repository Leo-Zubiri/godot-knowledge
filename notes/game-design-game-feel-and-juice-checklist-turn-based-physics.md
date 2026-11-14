---
id: game-design-game-feel-and-juice-checklist-turn-based-physics
type: guide
domain: game-design
status: proposed
summary: "Practical checklist for adding game feel (juice) to a turn-based physics game such as pool, mini-golf or bowling: feedback layers per event (anticipation, impact, reaction, settle), hit-stop and camera-shake rules, slow motion and replays in Godot 4.7, audio variation, randomness that does not feel unfair in a party game, turn timers, accessibility switches and mobile cost notes, with every number marked as sourced or inferred."
aliases: [game feel, juice, polish, hit stop, hitstop, hit pause, screen shake, camera shake, slow motion, instant replay, shot clock, turn timer, party game randomness, catch-up mechanic, impact feedback]
tags: [dept/design, dept/game-dev, dept/ui-ux, tool/godot]
applies-to:
  min: "generic (design); engine notes are Godot 4.x"
  tested: "4.7 (documentation only; nothing here was run in the engine or playtested)"
sources:
  - claim: "Swink's definition of game feel, its six components and 'polish' as effects that enhance interaction without changing the simulation; the juicy-game description by Jonasson and Purho; the step lists of 'Juice It or Lose It' and 'The Art of Screenshake' as recorded in a university lecture handout (talks not watched); 'juice adds pleasure, oil removes pain'; camera shake opposite to the direction of fire"
    ref: src-gs-design-game-feel-juice-talks
    retrieved: 2026-11-14
  - claim: "Hit-stop: purpose, same freeze for both parties, longer for stronger hits with a cap, kept short when other players could exploit the freeze, visual-only vibration that tapers, pose change hidden inside the freeze; one frame figure ('like 10 frames'); trauma-based camera shake with squared response, decay and noise, with the recipe's default values"
    ref: src-gs-design-hitstop-and-camera-shake
    retrieved: 2026-11-14
  - claim: "Input vs output randomness, tolerance for each, tension and balance arguments, fairness principle (more skilled player wins when the gap is reasonable; winner clear only at the end), kingmaking vs catch-up, shorter matches and explicit handicaps, developer statements on balancing fairness with fun"
    ref: src-gs-design-party-randomness-and-catch-up
    retrieved: 2026-11-14
  - claim: "Real-world professional pool shot clock: 30 s per shot, one 30 s extension per rack, 60 s after the break, warnings at 10 and 5 s, expiry is a standard foul, clock stops at the strike"
    ref: src-gs-pool-shot-clock-wnt-rules
    retrieved: 2026-11-14
  - claim: "Photosensitivity criteria (more than about three flashes per second, about 20 percent of the screen, red flashes), camera shake/bob/blur to be avoided or switchable with intensity sliders, option to disable automatic camera movement, haptics toggle, game-speed option, no precise timing as the only way, no essential information by sound or colour alone"
    ref: src-gs-accessibility-motion-flash-and-timing
    retrieved: 2026-11-14
  - claim: "Godot 4.7: Engine.time_scale semantics and its notes on audio and physics precision; SceneTree.create_timer and Tween.set_ignore_time_scale; Tween reuse rule and transition types; CPUParticles3D vs GPUParticles3D, one_shot/explosiveness/finished/amount notes; AudioStreamRandomizer modes and random pitch; Camera3D h_offset/v_offset/fov"
    ref: src-gd-time-scale-tween-particles-audio-randomizer
    retrieved: 2026-11-14
  - claim: "Eleven animation principles including anticipation, follow-through and overlapping action, squash and stretch, exaggeration, secondary action"
    ref: src-gs-design-pinelle-lasseter-read
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-art-readability-silhouette-and-animation-principles]]"   # the animation principles the event ladder is built on
  - relates-to: "[[game-studio-accessibility-minimums]]"   # the baseline this note extends with motion/flash switches
  - relates-to: "[[game-design-pool-view-camera-aim-and-spin-ux]]"   # the aiming camera this note adds shot-time beats to
  - relates-to: "[[godot-physics-engine-options-and-ball-sim]]"   # hands-on finding that time_scale changes the physics step
  - relates-to: "[[godot-animation-tree-and-tween-pitfalls]]"   # one new Tween per gesture, kill the old one
  - relates-to: "[[godot-code-driven-character-animation-without-skeleton]]"   # cheap anticipation and reaction poses
  - relates-to: "[[godot-3d-particles-trails-attractors-collision]]"   # trails and renderer limits for the VFX layer
  - relates-to: "[[godot-particles-and-shader-basics]]"   # GPU vs CPU particles
  - relates-to: "[[godot-procedural-placeholder-sfx-audiostreamwav]]"   # per-play pitch/volume variation and minimum intervals
  - relates-to: "[[game-studio-playtesting-methods]]"   # feel cannot be verified without players
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> **Evidence status:** design guidance is distilled from practitioner sources (a 2007 article by the author of *Game Feel*, a lecturer's record of two conference talks that were **not watched**, a fan translation of a designer's column on hit-stop, opinion pieces on randomness, one tour's shot-clock rules) and accessibility guidelines; engine facts come from the Godot 4.7 class reference. All of it was retrieved 2026-11-14, mostly as paraphrased extractions. **Nothing was run in the engine or playtested.** Practitioner sources give almost no numbers: every numeric starting value not attributed to a source is an **agent inference** to be tuned with players and is marked *(inference)*. Items marked *unverified* come from search summaries of pages that were not read.

## Goal
Make a turn-based physics game (one player acts, then everyone watches the simulation resolve: pool, mini-golf, bowling, marbles, artillery) feel responsive, readable and funny, without changing who wins, without making anyone ill and without blowing a mobile frame budget.

## Prerequisites
- [[game-studio-art-readability-silhouette-and-animation-principles]] — anticipation, follow-through, squash and stretch.
- [[game-studio-accessibility-minimums]] — baseline settings every game needs.

## Vocabulary
- **Game feel:** "the tactile sensation of manipulating a digital agent"; built from input, response, context, polish, metaphor and rules [src-gs-design-game-feel-juice-talks].
- **Polish / juice:** effects that enhance the interaction *without changing the underlying simulation* — particles, sound, camera shake, squash and stretch; a juicy game "feels alive and responds to everything you do" [src-gs-design-game-feel-juice-talks]. This definition is the main safety rule: **juice lives in the view layer** and must be removable without changing an outcome.
- **Oil:** "Juice adds pleasure, oil removes pain" [src-gs-design-game-feel-juice-talks]. Removing friction (fewer confirmations, no dead waiting) often beats adding effects.
- A turn-based physics game has little continuous control, so most of Swink's "input/response" budget is spent in two places: the aiming widget, and the **moment the player commits**. *(inference)* The rest is spectator feedback: the player watches a result unfold, so camera, timing and reactions carry the feel.

## 1. The event ladder: anticipation → impact → reaction → settle
Give every important event all four beats; give unimportant events only the impact beat. The beats map onto the classic animation principles of anticipation, follow-through and overlapping action, exaggeration and secondary action [src-gs-design-pinelle-lasseter-read].

| Beat | Purpose | Animation | Camera | Audio | VFX / UI |
|---|---|---|---|---|---|
| **Anticipation** | tell everyone something is about to happen | wind-up pose, lean, held breath | small push-in or framing change | rising cue, room goes quiet | charge meter, turn banner |
| **Impact** | sell the collision | squash on contact, brief freeze | kick opposite to the force, short shake | sharp transient, more low end on big hits | contact puff, flash of the struck object (small area) |
| **Reaction** | show consequences and who cares | follow-through, onlookers flinch or cheer | follow the object that matters | crowd/character voice, scoring sting | score pop, trail, counter change |
| **Settle** | return control, leave a trace | ease back to idle with overshoot | ease back to the neutral view | tail, ambience returns | marks left behind (permanence) |

The step lists of the two classic juice talks are, in effect, this ladder applied one small tweak at a time: easing on everything, stretch and wobble, colour or scale change on impact, impact particles, trails, sound per surface, screen shake, a pause on hit, camera kick, permanence (things left on the floor), more bass, and slow motion at the end [src-gs-design-game-feel-juice-talks].

**Checklist**
- [ ] Every player action has a response on the same frame it is accepted (sound or pose), even if the physical result comes later. *(inference from the "response" component)*
- [ ] Wind-up and strike are separated: the action is committed, a short anticipation plays, the physical impulse lands on the contact frame of the animation.
- [ ] Onlookers react (secondary action): other characters turn to watch, flinch at near misses, celebrate or mock at results.
- [ ] Something stays behind after each event (chalk mark, scuff, dropped item) for a while: permanence is on both talk lists [src-gs-design-game-feel-juice-talks]. Cap the count for mobile.
- [ ] Easing on every UI and prop motion; no linear moves. In Godot, `TRANS_BACK`, `TRANS_ELASTIC` and `TRANS_BOUNCE` give overshoot and wobble; create a **new** Tween per animation and `kill()` the previous one, since Tweens "are not designed to be reused" [src-gd-time-scale-tween-particles-audio-randomizer].

## 2. Scale feedback to the importance of the event
Sourced rule: freeze length grows with the strength of the hit, has a **maximum**, and is reduced when it would hurt play [src-gs-design-hitstop-and-camera-shake]. Generalise it to every layer with an intensity value in 0..1 per event.

*(inference)* A workable tier table for a cue-sport-like game:

| Tier | Example events | Layers used |
|---|---|---|
| 0 ambient | soft ball-ball or cushion contact | sound scaled by impact speed only |
| 1 normal | ordinary strike, ordinary pot | + contact puff, small camera kick, score pop |
| 2 big | break shot, hard hit above a speed threshold, combination or bank pot | + hit-stop, shake, onlooker reaction, stronger sting |
| 3 decisive | match-winning ball, foul on the deciding ball | + slow motion on approach, dedicated camera, replay offer, full celebration |

If everything is tier 3, nothing is. Budget roughly one tier-3 moment per match and a few tier-2 moments. *(inference)*

## 3. Impact: hit-stop
What the sources say [src-gs-design-hitstop-and-camera-shake]:
- It freezes the parties "at the point of collision", gives the eyes time to register the hit and makes it read as powerful.
- Same freeze for striker and target; longer for stronger hits; **capped**.
- Kept short in games where a freeze creates an opening for someone else. In a turn-based game nobody else is acting, so the constraint is pacing, not fairness. *(inference)*
- Vibrate the frozen objects **visually only** (collision shapes stay still), larger at the start and tapering; scale the vibration with camera distance.
- Swap to the reaction pose **inside** the freeze so the change is hidden.
- Only one concrete figure was found: about 10 frames in a classic 2D fighter. *Unverified* search-summary figures: 2-4 frames for light and 5-8 for standard hits at 60 fps, about 0.08 s in engine tutorials.

**Starting values *(inference, tune by eye)*:** tier 1: none; tier 2: 40-70 ms; tier 3: 80-120 ms; never above about 150 ms; at most one hit-stop per shot (the first qualifying impact), otherwise a multi-ball break stutters.

**Two ways to implement it in a physics game**
1. **View-only hold (preferred):** the simulation never stops. Hold the *striker's* pose at contact for the hit-stop duration and apply the physical impulse when the hold ends; for later impacts, freeze only the visual meshes' interpolation for a few frames and catch up. No effect on outcomes, safe for networking and replays. *(inference)*
2. **Global time scale:** set `Engine.time_scale` near zero briefly. It affects `_process`, `_physics_process`, Timers and SceneTreeTimers; the docs recommend keeping it above 0.0 [src-gd-time-scale-tween-particles-audio-randomizer]. Restore it with a timer created with `ignore_time_scale = true` (`get_tree().create_timer(sec, true, false, true)`) or a Tween with `set_ignore_time_scale(true)`, otherwise the restore itself is slowed [src-gd-time-scale-tween-particles-audio-randomizer]. See section 5 for the physics caveat.

## 4. Camera shake
- **Model:** keep a `trauma` value in 0..1; events add to it; it decays linearly; the applied shake is `trauma` squared (or cubed), so small events barely move the camera and big ones punch; sample smooth noise instead of fresh random numbers each frame [src-gs-design-hitstop-and-camera-shake]. The recipe's defaults are decay 0.8 per second, exponent 2, and (for a 2D camera) max offset 100 × 75 px and max roll 0.1 rad "use sparingly" [src-gs-design-hitstop-and-camera-shake].
- **Direction:** a kick opposite to the direction of the force reads better than random noise alone [src-gs-design-game-feel-juice-talks].
- **3D:** *unverified* (search summary of the talk the recipe follows): in 3D prefer **rotational** shake and avoid translating the camera, which can push it through geometry. `Camera3D.h_offset` / `v_offset` shift the view without moving the node [src-gd-time-scale-tween-particles-audio-randomizer]; *(inference)* they are a cheap way to add a kick on top of an existing follow rig without fighting its smoothing.
- **Starting values for a 3D table-top view *(inference)*:** max rotation 0.5-1.5 degrees, max offset 1-3 % of the framed width, trauma added 0.2 (tier 1) / 0.45 (tier 2) / 0.7 (tier 3), decay 1.5-2.5 per second so a shake is over in under half a second.
- **Never shake while the player is aiming or reading text.** Shake belongs to the resolve phase. *(inference)*
- Misused shake is something "players hate" [src-gs-design-hitstop-and-camera-shake]; give it a 0-100 % slider (section 9).

## 5. Slow motion and time control in Godot 4.7
- `Engine.time_scale` 0.5 runs the game at half speed and scales everything that uses delta. It does **not** change audio speed (use `AudioServer.playback_speed_scale` for that) and does **not** change `physics_ticks_per_second`; values above 1.0 make physics less precise because each tick covers more engine time [src-gd-time-scale-tween-particles-audio-randomizer].
- Hands-on finding recorded in [[godot-physics-engine-options-and-ball-sim]]: the physics step becomes `time_scale / ticks_per_second`. *(inference)* So slow motion changes the integration step of a live rigid-body simulation: results stay plausible (smaller steps) but are **not identical** to the same shot at normal speed. Consequences: never use live slow motion in tests or calibration; in a host-authoritative network game only the host may scale time (clients mirror what they receive); any per-tick constant in custom physics code (not multiplied by delta) changes behaviour under slow motion.
- **Safer pattern *(inference)*:** keep the live simulation at normal speed and put the slow motion in a **replay** of recorded transforms (section 6), where it cannot affect anything.
- If live slow motion is wanted for the decisive ball: trigger it from a *prediction* (the deciding object is heading for the goal within a short distance and no other object can intercept), ease in and out over 0.1-0.2 s of real time, hold at 0.25-0.4, cap the total at about 1.5 s of real time, and cancel immediately on any player input. *(inference; no source gives factors)* UI tweens and timers that must stay real-time need the ignore-time-scale flags above.
- Pitching audio down during slow motion is optional; a low-pass sweep plus a held tone is cheaper and avoids chipmunk artefacts on the way back up. *(inference)*

## 6. Camera beats for a turn-based physics game
*(inference throughout, except where cited — camera sources read here cover shake only)*
1. **Aim:** stable, player-controlled, no automatic motion (see [[game-design-pool-view-camera-aim-and-spin-ux]]).
2. **Commit / wind-up:** cut or ease to a third-person view that shows the character's gesture and the first target.
3. **Strike:** kick along the shot direction, optional tier-2 hit-stop.
4. **Travel:** an overview that keeps every moving object in frame; ease, do not chase a single fast object (chasing causes sickness and loses context).
5. **Decision moment:** when one object is about to decide the turn, ease towards a framing that contains that object and its goal; a fixed "goal camera" placed per goal is cheaper and safer than a free chase camera. Use a picture-in-picture `SubViewport` only on desktop; on mobile prefer a cut, since a second viewport roughly doubles scene rendering cost. *Unverified*: the actual cost on a given device must be measured ([[godot-performance-workflow]]).
6. **Result:** hold two beats on the result before any UI covers it, then cut to the reacting characters.
7. **Return:** ease back behind the next shooter.
- Limit automatic cuts to one or two per shot, and provide an option to disable automatic camera movement: the accessibility guidance asks for exactly that [src-gs-accessibility-motion-flash-and-timing].
- **Instant replay:** record `{tick, id, position, rotation}` for moving bodies during the resolve phase (the same snapshot data a host-authoritative game already sends to clients, see [[godot-lan-host-authoritative-turn-based]]) and play it back through the non-simulating "mirror" path with interpolation. Re-simulating from the input is only valid with a deterministic simulation, which a general rigid-body engine does not promise. Offer the replay only for flagged shots (tier 2-3, multi-cushion, lucky pot, embarrassing foul), keep it under about 6 s, make it skippable by any player, and never auto-play more than once per few turns.

## 7. Audio layering and character voices
- **Per impact:** transient + body + optional low-end layer for big hits ("more bass" is a step on the screenshake list [src-gs-design-game-feel-juice-talks]); volume and brightness from impact speed; a minimum interval per sound type so a cluster of contacts does not machine-gun ([[godot-procedural-placeholder-sfx-audiostreamwav]]).
- **Never the same sample twice in a row:** `AudioStreamRandomizer` picks from a pool with weights, has a mode that tries to "avoid playing the same stream twice in a row", and adds random pitch (range `1/random_pitch`..`random_pitch`) and volume offsets [src-gd-time-scale-tween-particles-audio-randomizer]. *(inference)* 4-6 variants per frequent sound and a `random_pitch` around 1.05-1.1 is a common starting point.
- **Ducking:** lower music and ambience under tier-2/3 stings and during slow motion, on a separate bus ([[godot-audio-buses-and-adaptive-music]]).
- **Laughs and taunts *(inference; no source read covers comedic audio)*:** a laugh is a reward for the table, so treat it like tier-2/3 feedback, not like an impact sound.
  - Trigger on *events with a victim or a surprise* (a prank landing, a scratch, a miss on an easy shot, an absurd fluke), not on every success.
  - Cooldown per character (start at 8-12 s) and a per-match budget; when on cooldown fall back to a quieter reaction (snicker, gasp, "ooh") so the room is never silent or repetitive.
  - At least 5-8 variants per character per reaction type, no immediate repeats, slight pitch variation; an escalation ladder (snicker → laugh → wheeze) keyed to how spectacular the event was.
  - Laugh *with* the table: the victim's own exaggerated reaction is funnier and less grating than the winner gloating. Avoid laughing at a human player who is far behind; let the trailing side get the sympathetic or comeback lines.
  - Start the laugh after the result is readable (0.2-0.4 s after the event), never on top of the impact sound.
  - Voices go on their own bus with their own volume slider; a "reactions: full / reduced / off" option helps long sessions.
- Accessibility: separate volume controls for effects, speech and music, and no essential information by sound alone [src-gs-accessibility-motion-flash-and-timing] — every audio cue that matters (timer warning, foul) needs a visual twin.

## 8. Randomness that creates stories without feeling unfair
Vocabulary and principles [src-gs-design-party-randomness-and-catch-up]:
- **Input randomness** is revealed *before* the decision; **output randomness** is noise *between* the decision and the outcome. Players are reported to tolerate the first better; input randomness with almost no time to react behaves like output randomness.
- Randomness earns its place by creating tension and by keeping the winner unclear until the end, but a match should still feel fair: the more skilled player wins when the gap is reasonable.
- A random event that only lets a losing player pick who wins is kingmaking, not catch-up; untargeted random items do not specifically help the weaker player.
- Shorter matches and an explicit handicap can replace catch-up machinery.
- Even in a deliberately luck-heavy party game the developers describe "balancing fairness with fun" as the hardest part, and want the outcome open "right until the very end".

**Rules of thumb *(inference built on those principles)***
- [ ] **Telegraph first.** Announce the random modifier at the *start* of the turn (icon, one-line description, audible sting) so the player aims with it in mind. A modifier revealed after commitment is output randomness.
- [ ] **Bounded effect.** A random modifier may change *how* a shot is played or add variance within a visible range; it should not directly move the score or delete progress.
- [ ] **Symmetric over a match.** Draw from a shuffled bag instead of independent rolls so both sides see a similar number and quality of events; never the same event twice in a row.
- [ ] **Protect the decisive moment.** No random interference on the first action of a match or on a match-deciding attempt unless the players opted in.
- [ ] **Counterplay or consent.** Sabotage by another player needs a telegraph (wind-up, projectile in flight) and a way to dodge, resist or at least a cooldown and a per-turn cap.
- [ ] **Soft catch-up only.** Help the trailing side with *opportunities* (first pick of an item, a slightly better draw weight), not with free points; keep it visible so it reads as part of the game, not as cheating.
- [ ] **Seeded and replicated.** One seeded generator on the authority; random choices travel as events, never re-rolled per client.
- [ ] **A serious mode.** One switch that turns off random modifiers and sabotage for players who want the pure game, and an intensity preset (off / mild / chaos) in between.
- [ ] **Tell the story.** When luck decides something, name it on screen ("fluke!", "robbed!"): labelled luck is a shared joke, unlabelled luck looks like a bug.

## 9. Turn timers
- Real-world reference for cue sports: 30 s per shot, one 30 s extension per rack, 60 s after the break, warnings at 10 and 5 s, the clock stops at the strike, and running out is a standard foul [src-gs-pool-shot-clock-wnt-rules].
- Accessibility: do not make precise timing the only way to play; offer a game-speed or timing option [src-gs-accessibility-motion-flash-and-timing].
- *(inference)* For a casual or party game:
  - Make the timer a match option: **off** (default for local play with new players), **relaxed** (pressure without penalty: the opponent gains a sabotage charge or the aim starts to wobble), **strict** (expiry auto-plays the current aim or passes the turn). Online or ranked play needs strict.
  - Prefer a soft penalty to a foul: an automatic weak shot along the current aim keeps the match moving and is funnier than a rules citation.
  - Pause the timer during camera transitions, replays, pause menus and while a sabotage effect is resolving; give time back when the shooter is hit by an interruption, or sabotage becomes a clock exploit.
  - Warn on two channels (visual pulse + tick sound) at the same marks the real sport uses.
  - Give AI players a minimum thinking time and a maximum, so they neither snap-shoot nor stall.

## 10. Accessibility switches (ship these with the effects, not after)
From the guidelines [src-gs-accessibility-motion-flash-and-timing]:
- [ ] **Screen shake 0-100 %** and **camera effects** (kick, push-in, automatic cuts) switchable; the guidance is to avoid camera shake, bob and blur or let players turn them off, ideally with intensity sliders.
- [ ] **Disable automatic camera movement** (fall back to the fixed overview).
- [ ] **Flashes:** no more than about three per second, never covering about 20 % or more of the screen, no saturated red flashes; all games should be checked for these even without intentional flashing. Prefer scale/colour pops on small objects over full-screen flashes; a full-screen flash, if any, is single, short and off under "reduce flashes".
- [ ] **Haptics** toggle or slider.
- [ ] **Game speed / timing:** timer off or relaxed; slow motion and hit-stop off under "reduce motion" (they are view effects and must not be required).
- [ ] **Background motion** (crowd, ambient animation behind text) can be reduced.
- [ ] **No sound-only or colour-only information.**
- *(inference)* Implement all of the above as multipliers read by the view layer from player settings (a `motion_scale`, `flash_scale`, `shake_scale`, `reactions_level`), so every effect in sections 3-7 scales with them by construction and a single "reduce motion" preset sets several at once.

## 11. Mobile cost notes (Godot 4.7, documentation level)
- `GPUParticles3D` is hardware-accelerated; `CPUParticles3D` exists for devices where GPU particles "may not run" [src-gd-time-scale-tween-particles-audio-randomizer]. *(inference)* For tiny one-shot bursts (8-24 quads) either is fine; choose by measuring on the lowest target device.
- One-shot bursts: `one_shot = true`, `explosiveness` near 1, restart with `restart()`, and use the `finished` signal to return the node to a pool; with `one_shot`, setting `emitting` again does not restart until active particles finish [src-gd-time-scale-tween-particles-audio-randomizer]. Lowering `amount_ratio` has no performance benefit; lower `amount` instead [src-gd-time-scale-tween-particles-audio-randomizer].
- Trails work on Forward+ and Mobile but not Compatibility ([[godot-3d-particles-trails-attractors-collision]]); `emit_particle()` likewise [src-gd-time-scale-tween-particles-audio-randomizer].
- *(inference)* Pre-instantiate and pool every effect during loading and fire each once off-screen, so the first real impact does not hitch. *Unverified*: the class pages read say nothing about first-use shader or pipeline compilation stutter; measure it ([[godot-performance-workflow]]).
- *(inference)* Keep particles unshaded, opaque or alpha-scissored where possible, few and large rather than many and small (overdraw is the usual mobile limit), with no collision and no lights. Blob decals for permanence should be capped (ring buffer) and fade out.
- Slow motion costs nothing; hit-stop costs nothing; a replay costs memory only (a few kilobytes per second of transforms). The expensive items are extra viewports, transparent overdraw and extra shadow-casting lights. *(inference)*
- See [[godot-particles-and-shader-basics]] for GPU-vs-CPU particle basics.

## 12. Common mistakes
- **Juice instead of response.** Effects cannot fix late or unclear input handling; fix "response" and remove friction first [src-gs-design-game-feel-juice-talks].
- **Everything at maximum.** No tiers, so the decisive ball feels like any other; the sourced rule is to scale with strength and cap [src-gs-design-hitstop-and-camera-shake].
- **Effects that change outcomes.** Polish is defined as not changing the simulation [src-gs-design-game-feel-juice-talks]; a hit-stop or slow motion that alters a physics result, or a shake that moves the aim, has crossed the line.
- **Shake while aiming or over text**; shake with no off switch [src-gs-accessibility-motion-flash-and-timing].
- **Full-screen flashes** on frequent events [src-gs-accessibility-motion-flash-and-timing].
- **Repeating voice lines** and laughs on every event *(inference)*.
- **Unskippable replays and celebrations**; long pauses before control returns *(inference)*.
- **Output randomness on the deciding action**; sabotage with no telegraph or cap [src-gs-design-party-randomness-and-catch-up].
- **Reusing a Tween** or stacking tweens on the same property (jitter) [src-gd-time-scale-tween-particles-audio-randomizer]; see [[godot-animation-tree-and-tween-pitfalls]].
- **Spending polish time on effects that are not crucial**: "limit the amount of time you spend creating effects to those which are crucial" [src-gs-design-game-feel-juice-talks].
- **Calling it done without players.** Feel is a human judgement ([[game-studio-playtesting-methods]]).

## What was not verified
- The two juice talks were not watched; their step lists come from a lecturer's slide. No primary numbers for pause length, shake size or slow-motion factor were found.
- The original essay on input/output randomness and the first-hand developer interviews were not reachable; the randomness section rests on secondary articles.
- The "rotational shake only in 3D" advice and the frame ranges for hit-stop are search-summary level.
- No source read covers comedic timing of voice reactions, instant-replay design or camera direction for spectated physics; those sections are inference.
- No engine run: `ignore_time_scale` timers and tweens, particle pooling and the cost of a second viewport on the Mobile renderer are untested here.

## See also
- [[game-studio-art-readability-silhouette-and-animation-principles]] — animation principles behind the event ladder
- [[game-studio-accessibility-minimums]] — baseline accessibility settings
- [[game-design-pool-view-camera-aim-and-spin-ux]] — the aiming-phase camera and widgets
- [[godot-physics-engine-options-and-ball-sim]] — time scale and the physics step, measured
- [[godot-animation-tree-and-tween-pitfalls]] — tween-per-gesture rule
- [[godot-code-driven-character-animation-without-skeleton]] — cheap anticipation and reaction poses in code
- [[godot-3d-particles-trails-attractors-collision]] — trails, collision and renderer limits
- [[godot-particles-and-shader-basics]] — GPU vs CPU particles
- [[godot-procedural-placeholder-sfx-audiostreamwav]] — per-play variation and minimum intervals
- [[godot-audio-buses-and-adaptive-music]] — buses for ducking and separate volumes
- [[godot-lan-host-authoritative-turn-based]] — snapshot stream reusable for replays
- [[godot-performance-workflow]] — measure every effect on the target device
- [[game-studio-playtesting-methods]] — how to validate feel with players

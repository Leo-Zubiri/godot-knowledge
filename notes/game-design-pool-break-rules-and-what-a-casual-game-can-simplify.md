---
id: game-design-pool-break-rules-and-what-a-casual-game-can-simplify
type: reference
domain: game-design
status: proposed
summary: "The break shot in 8-ball and 9-ball under the WPA Rules of Play (effective 2025-09-15): cue ball in hand behind the head string, the four-balls-to-a-rail requirement (an 'illegal break' with options in 8-ball, a foul in 9-ball), what happens to the 8/9 and to balls driven off the table, where ball in hand is restricted, plus the open-table rule — and which parts a casual video game can fix to one option, what data the simulation must report, and how to show a player what they are allowed to hit."
aliases: [pool break rules, legal break, illegal break, head string, kitchen, ball in hand behind the line, open table, WPA 8-ball, WPA 9-ball]
tags: [dept/design, dept/game-dev, scope/reference-study]
sources:
  - claim: "8-ball break shot (4.3 a–h), open table (4.4), spotting (4.7); 9-ball legal break (5.3), push out (5.4), spotting (5.6), fouls (5.7); definition of 'above the head string'"
    ref: src-gd-wpa-rules-of-play-2025-break
    retrieved: 2026-11-14
related:
  - relates-to: "[[game-design-billiards-pool-physics-model]]"   # the physics the rules sit on; pocket and cushion model
  - relates-to: "[[game-design-pool-view-camera-aim-and-spin-ux]]"   # aiming and camera around these states
  - relates-to: "[[game-design-pool-cpu-opponent-ghost-ball-planner]]"   # the CPU must place and break within the same rules
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> **Evidence status.** The rules are quoted from the rulebook ([[src-gd-wpa-rules-of-play-2025-break]]) — `proposed`. The
> implementation advice was *run here* in one game (unit and integration tests pass) and is *unreviewed*; nobody has yet judged
> whether the simplifications feel right in play.

## The rules, side by side

| Situation | 8-ball (ch. 4) | 9-ball (ch. 5) |
|---|---|---|
| Cue ball before the break | In hand **above the head string** (between the head rail and the line through the head spot) | Same |
| What must be hit first | Nothing in particular | The 1 (lowest ball first, as always) |
| Ball pocketed, no foul | Breaker continues; **table stays open** | Breaker continues; the 9 wins the rack |
| Nothing pocketed and fewer than **four object balls reach a rail** | **Illegal break, not a foul.** Incoming player chooses: accept the table, re-rack and break, or re-rack and make the offender break again | **Foul** → ball in hand anywhere |
| Foul on the break (scratch, etc.) | Incoming player: accept the table, or ball in hand **above the head string** | Ball in hand **anywhere** |
| 8 / 9 pocketed on a legal break | 8 is spotted and the breaker continues, or re-break — **not a win or a loss** | 9 pocketed legally **wins** |
| 8 / 9 pocketed on a fouled break | Opponent: spot the 8 and take ball in hand above the head string, or re-break | 9 is spotted; ball in hand anywhere |
| Object ball driven off the table | Foul; the ball **stays out of play** (only the 8 is ever spotted, and only on the break) | Foul; only the 9 is spotted |
| Open table | Hitting the 8 first is a foul | — |

Not covered here: call-shot, push out (5.4), the three-ball break regulation, and the general foul list.

## What a casual game can simplify — and what it should not
- **Fix the options instead of asking.** Where the rulebook gives the incoming player a choice (illegal break, 8 on the break),
  pick one by configuration — "re-rack and the incoming player breaks" and "spot the 8, breaker continues" are the common picks —
  and say so in the rules text. A choice dialog adds a state, an AI decision and a network message for little play value.
- **Do not skip the break requirement.** Without the four-ball rule a soft "safety break" is the best opening; with a rigid-body
  simulation the count is cheap to produce (below).
- **Do not auto-spot balls.** A common shortcut is to put any ball that leaves the table back; the rule is the opposite, and it
  changes the count of balls a player has left.
- **Let the player move the cue ball before breaking, but do not force a placement step.** Start the break aimed from the head
  spot and offer "move cue ball" (one key / one button); most players will not use it, and the ones who do expect it.
- **Restrict ball in hand by zone, not by a separate state.** One "ball in hand" state with a zone value (anywhere / behind the
  head string) is enough; the zone clamps the placement in the authority (the simulation), and the view draws the line only while
  placing behind it. Omitted here and worth knowing: with ball in hand behind the line the rulebook also restricts which ball may
  be hit (3.11); a casual game can leave that out but should say so.

## What the simulation must report
Beyond pocketed balls, first contact and cue-ball scratch, the rules need: **which distinct object balls touched a cushion**
(for the break), **which balls left the table** (and the simulation must *not* re-spot them itself — the rules decide), and whether
any ball touched a cushion after contact (for the optional no-rail foul). Keep the outcome a plain record the rule set consumes;
the rule set returns: foul and reason, illegal break, re-rack + who breaks, ball-in-hand zone, balls to spot, turn continuation.

## Showing the player what is theirs
Owner feedback after playing: text labels for "solids/stripes" and "next ball" existed and were still missed. What made it obvious:
- a boxed line near the top, "<player> plays <group>" with **icons of the balls they have left** (one big icon in 9-ball);
- the same icons inside each player's panel;
- the row of balls on the table with the **non-legal ones dimmed**;
- **rings on the cloth** under the legal balls while aiming (none when the table is open — almost everything is legal).
Number discs on the 3D balls needed to be about **1.5× the real proportion** to read from a game camera (≈ 33° of the sphere, glyph
≈ 0.74 ball radii, thick stroke); real balls use ≈ 22°.

## Test traps this exposed
Tests that used "break, pocket nothing" as a cheap way to pass the turn all broke (it is now an illegal break): give such outcomes
four balls to a rail. Tests that produced a foul with a break scratch and then placed the cue ball mid-table also broke (the break
foul restricts placement): commit the foul after a legal break instead.

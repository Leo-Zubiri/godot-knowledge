---
id: src-gs-design-party-randomness-and-catch-up
type: source
domain: game-studio
source:
  url: "https://www.gamedeveloper.com/design/a-defense-of-randomness-in-competitive-games"
  urls:
    - "https://www.gamedeveloper.com/design/a-defense-of-randomness-in-competitive-games"
    - "https://www.skeletoncodemachine.com/p/input-output-randomness-part-1"
    - "https://theludite.com/2014/10/29/smash-bros-what-makes-a-party-game/"
    - "https://gameluster.com/mario-party-10-developers-on-the-difficulty-of-ensuring-balanced-gameplay/"
  title: "Randomness, fairness and catch-up in competitive and party games: 'A Defense of Randomness in Competitive Games' (Game Developer, 2014); 'Input-Output Randomness (Part 1)' (Skeleton Code Machine, 2023); 'Smash Bros: What Makes a Party Game?' (The Ludite, 2014); developer quotes on Mario Party 10 balance (GameLuster quoting a Nintendo Life interview, 2015)"
  retrieved: 2026-11-14
  version: "live pages as of the retrieval date"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); quoted fragments as returned by the summarizer"
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). Paraphrased extraction of practitioner opinion pieces and one second-hand developer interview; none is empirical research. Keith Burgun's original essay on input/output randomness and the original Nintendo Life interview could not be fetched (HTTP 503 / 403) and were **not read**. Re-fetch before promoting dependent notes to `verified`.

## "A Defense of Randomness in Competitive Games" (Game Developer, 2014-10-20)
- Attributes the distinction to Keith Burgun. **Output randomness:** "Output randomness is noise injected between the player's decision and the outcome." (dice rolls, random hit chances). **Input randomness:** "this type of randomness informs the player before he makes his decision." (map generation, face-up cards). Input randomness with very little time to respond behaves much like output randomness.
- In favour of randomness: "randomness allows us to create high-tension moments where we are unsure if we will succeed or fail."; "Output randomness can help balance a game between two players, maintaining the first Base Principle and match tension."; "Planning and reacting are two very different skillsets, both required by a competitive player."
- The author's base principles: the winner should become clear only at the end (come-back mechanics or balancing help); no single dominant strategy; matches should feel fair — the more skilled player wins when the skill gap is reasonable; testing mastery needs uncertainty.

## "Input-Output Randomness (Part 1)" (Skeleton Code Machine, E.P., 2023-11-28)
- "Input randomness is a random event that happens before the player makes decisions." "Output randomness is when the random event happens after the player has made their decision."
- "In general, players appreciate this type of randomness." (input); the author's guess: "players are more tolerant of input randomness than output randomness."
- Choice must remain: "Pulling random cards that can all be played or have no options in how they are used is no choice at all."
- On output randomness: "Sometimes the dice are just cursed, leading to a less than satisfying result."

## "Smash Bros: What Makes a Party Game?" (The Ludite, 2014-10-29, updated 2018)
- Party games "support larger numbers of players, often on teams", usually avoid eliminating players and have very high player interaction.
- Random items give "a wacky sort of flavor" but "at the expense of the competitive integrity of the game"; "an injection of pure chaos".
- Argues a leader-targeting item "was never a catch-up mechanism at all" but a "kingmaker device", and that random items do not help weaker players specifically.
- Catch-up mechanics may be compensating for matches that run too long; shortening the match is a simpler fix since players can replay.
- Prefers an explicit handicap: "It's better to have players use a handicap to acknowledge a skill gap right from the very start."

## Mario Party 10 developer quotes (GameLuster, 2015-03-26, quoting a Nintendo Life interview)
- Shuichiro Nishiya (director, Nd Cube): "Ensuring the gameplay was balanced was indeed the toughest challenge during development."; "We encountered a number of possible issues we had to resolve in order to balance fairness with fun."; a trailing side can be handed extra dice; "the outcome of the game is up for grabs right until the very end."
- Jumpei Horita (producer, Nintendo): "the outcome of the roll is 100% pure luck."; "I often hear or read doubts about the fairness of the dice roll."; "There are plenty of ways to turn the situation around."

## Search-summary pointer (NOT read — `unverified`)
- A GameSpot feature on how Nintendo uses luck reportedly says position-weighted items give novices a chance and that the stated aim is to keep everyone in contention until the end while the best player still usually wins. The page returned HTTP 403 and was not read.

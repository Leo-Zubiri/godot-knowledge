---
id: src-gs-design-game-feel-juice-talks
type: source
domain: game-studio
source:
  url: "https://www.gamedeveloper.com/design/game-feel-the-secret-ingredient"
  urls:
    - "https://www.gamedeveloper.com/design/game-feel-the-secret-ingredient"
    - "https://www.gdcvault.com/play/1016487/Juice-It-or-Lose"
    - "https://github.com/grapefrukt/juicy-breakout"
    - "https://medienwissenschaft.uni-bayreuth.de/wp-content/uploads/GxD-10-Game-Feel.pdf"
    - "https://www.gamedeveloper.com/design/vlambeer-co-founder-shares-advice-on-building-better-action-games"
  title: "Game feel and juice: Swink 'Game Feel: The Secret Ingredient' (2007); Jonasson and Purho 'Juice It or Lose It' (session page and example repo); a university lecture handout listing the steps of 'Juice It or Lose It' and of Nijman's 'The Art of Screenshake'; press report on the Nijman talk"
  retrieved: 2026-11-14
  version: "live pages as of the retrieval date; lecture handout dated 2017-07-04"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) for the web pages; the lecture handout PDF was downloaded and its text extracted locally with pdftotext (those lists are exact). The two talks themselves (videos) were NOT watched."
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). Mixed fidelity: web pages are a paraphrased extraction with short quoted fragments as returned by the summarizer; the handout lists are text extracted from the PDF. **Neither talk video was watched**, so the step lists are second-hand (a lecturer's notes). Re-fetch or watch the primary talks before promoting dependent notes to `verified`.

## Steve Swink, "Game Feel: The Secret Ingredient" (Game Developer, 2007-11-23) — summarizer extraction
- Definition: "The tactile sensation of manipulating a digital agent."; "It's mostly subconscious, a combination of sights, sounds, and instant response to action."
- Six components: **Input** ("How the player can express their intent to the system."), **Response** ("How the system processes, modifies, and responds to player input in real time."), **Context** ("How constraints give spatial meaning to motion."), **Polish** ("The interactive impression of physicality created by the harmony of animation, sounds, and effects with input-driven motion."), **Metaphor** ("The ingredient that lends emotional meaning to motion and provides familiarity to mitigate learning frustration."), **Rules** ("Application and tweaking of arbitrary variables that give additional challenge and higher-level meaning to motion and control.").
- Polish effects named: "sprays or dustings of particles where things hit or interact", "screen shake, view angle shifts", "squash and stretch of objects colliding". "A little screen shake or spray of particles can make all the difference in the world to a game's feel."
- Scope advice: "you want to limit the amount of time you spend creating effects to those which are crucial".
- The article gives **no** perception or response-time thresholds.

## "Juice It or Lose It" — GDC Vault session page (summarizer extraction)
- Speakers Martin Jonasson and Petri Purho; GDC Europe 2012, Independent Games Summit.
- Opening sentence of the description: "Martin and Petri will demonstrate the neat little tricks you can apply to any game to make it more satisfying to play." The rest says they take a dull game and push it to the extreme live on stage, and that attendees get the source code.

## juicy-breakout repository README (summarizer extraction)
- Example breakout game by Martin Jonasson and Petri Purho (2012, zlib licence) made for the talk. README: "A juicy game feels alive and responds to everything you do", with cascading feedback for minimal input. Links to references on easing, game feel and animation principles. The README does not list the individual effects.

## University lecture handout "Game Experience Design — 10 Game Feel" (Prof. Dr. Jochen Koubek, Universität Bayreuth, 2017-07-04) — text extracted from the PDF
- Quotes Swink's book (p. 5): "Polish refers to any effect that artificially enhances interaction without changing the underlying simulation. This could mean dust particles at a character's feet as it slides, a crashing sound when two cars collide, a "camera shake" to emphasize a weighty impact, or a keyframed animation that makes a character seem to squash and stretch as it moves. Polish effects add appeal and emphasize the physical nature of interactions, helping designers sell those objects to the player as real."
- **"Juice it or Lose it" (Jonasson and Purho, 2012) — steps as listed on the slide:** Color; Tweening / Easing (Position, Rotation, Scaling); Random Delay; Paddle Stretch (Velocity); Ball Rotation, Stretch; Animate Stretching (Wobble); Color Change on Impact; Scale Blocks on Impact; Sound (Walls, Block, Paddle); Music; Particles (Impact); Animation (Block Hit); Shatter; Ball Trail; Screen Shake; Anthropomorphisation (Big Eyes, Blink, Smile); Screen Color; Multiple Balls.
- **"The Art of Screenshake" (Jan Willem Nijman, 2013) — steps as listed on the slide**, with the quote „Just fill your game with love and tiny details.“: Basic Animation and Sound; Lower Enemy HP; More Shooting / Enemies; Bigger Bullets; Muzzle Flash (First Frame is a Circle); Faster Bullets; Less Accuracy; Impact Effect; Hit Animation; Enemy Knockback; Permanence (Corpses); Camera Lerp; Camera Position; Screen Shake; Player Knockback; Sleep (Pause Game on Hit); Gun Delay; Strafe; More Permanence (Bullet Shells); More Bass to SFX; Super Machinegun; Random Explosions; Faster Enemies; More Enemies; Even higher rate of fire; Camera Kick (Opposite Direction of Shoot); Bigger Explosions; Even More Permanence (Smoke); Meaning (Game Over Screen); Slow Motion. **No durations or amplitudes are on the slide.**
- A slide on "Game Oil" (Lars Doucet, "Oil it or Spoil it", 2016): "Juice adds pleasure, Oil removes pain." "If there is only one possible, unambiguous, non-regrettable action, the action button should just do that one thing."
- The handout's own taxonomy of where juice can be added: Graphics (animation/tweening, deformation, shader, model, VFX trails, particles, permanence), Camera (follow, shake), Audio (SFX, music, bass), Time (pause, slow motion), Physics (collision tolerance, knockback), AI, rules ("Ludition": balancing, variation, randomization), Controller (ADSR, haptic feedback).

## Press report on the Nijman talk (Game Developer, Alex Wawro, 2014-01-02) — summarizer extraction
- Talk "The Art of Screenshake" given at the Control Conference, Amsterdam; starts from a dull side-scrolling shooter and applies "30 minor tweaks".
- Two tweaks reported: the screen shakes "slightly in the opposite direction of the player's gunfire"; "a 33% chance of enemies exploding harmlessly on death".

## Not obtained
- No transcript of either talk; no numeric values (pause milliseconds, shake pixels, slow-motion factors) from the primary talks. Figures circulating in secondary write-ups were **not** confirmed here.

---
id: src-gs-design-pinelle-lasseter-read
type: source
domain: game-design
source:
  url: "https://web.archive.org/web/2015/https://course.ccs.neu.edu/is4300f15/ssl/pinelle-chi08.pdf"
  urls:
    - "https://web.archive.org/web/2015/https://course.ccs.neu.edu/is4300f15/ssl/pinelle-chi08.pdf"
    - "https://www.ics.uci.edu/~fowlkes/class/ics162/exercises/lasseter.pdf"
  title: "Pinelle, Wong, Stach, Heuristic Evaluation for Games (CHI 2008); Lasseter, Principles of Traditional Animation Applied to 3D Computer Animation (SIGGRAPH 1987)"
  retrieved: 2026-11-08
  version: "CHI 2008 pp. 1453-1462 (Wayback copy of a course-hosted PDF, 10 pages); Computer Graphics 21(4) July 1987 pp. 35-44 (UCI course copy, 10 pages)"
  capture: paraphrased
  retrieved_via: "PDFs downloaded to the scratchpad and read by the main agent via pdftotext; paraphrase, not verbatim; unofficial copies, official versions are ACM DOIs 10.1145/1357054.1357282 and 10.1145/37401.37407"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** both PDFs were read in full as text on 2026-11-08; the points below are the agent's paraphrase. The copies are unofficial course/archive copies (not the ACM versions): re-check against the ACM record before promoting dependent notes to `verified`.

## Pinelle, Wong, Stach (CHI 2008)
- **Method:** 108 GameSpot PC-game reviews (since 2001; scores 8.0 or lower because a pilot found no usability problems in highly rated games; 18 reviews from each of 6 genres; 24 reviewers). Three researchers coded independently, excluding technical and fun/engagement issues: 50 initial categories, merged into **12 problem categories**; **285 usability problems** found (2.64 per game; at least one in each review). Ten heuristics were written as inverses of the problem categories.
- **The ten heuristics:** (1) consistent responses to user actions; (2) customizable video/audio settings, difficulty and game speed; (3) predictable and reasonable behaviour of computer-controlled units; (4) unobstructed views appropriate to the current action; (5) allow skipping non-playable and frequently repeated content; (6) intuitive and customizable input mappings; (7) controls that are easy to manage with appropriate sensitivity and responsiveness; (8) information on game status; (9) instructions, training and help; (10) easy-to-interpret visual representations that minimize micromanagement.
- **Preliminary evaluation:** five evaluators (game experience and formal usability training) evaluated a PC game demo (~90 minutes); 45 problems in total (7-10 each); problems found under nine of the ten heuristics, none under 5; most problems under heuristics 9 (12), 8 (10) and 6 (8). Evaluators said the heuristics fit game interfaces; two said they could narrow focus, one noted overlap. The authors state a thorough evaluation needs more evaluators and genres and that console, multiplayer and serious games are outside what they studied. The heuristics concern usability, not fun, engagement or story.

## Lasseter (SIGGRAPH 1987)
- States that the principles of traditional hand-drawn animation, developed at the Disney studio between the late 1920s and late 1930s with drawing classes at the Chouinard Art Institute, apply to 3D keyframe animation.
- **Lists eleven principles:** squash and stretch; timing; anticipation; staging; follow through and overlapping action; straight-ahead and pose-to-pose; slow in and out; arcs; exaggeration; secondary action; appeal. It says timing, anticipation, staging, follow through, overlap, exaggeration and secondary action apply the same way in 2D and 3D, while squash and stretch, slow in/out, arcs, appeal and the two construction approaches change in application. A "solid drawing" principle is **not** in this paper's list.
- Squash and stretch: volume stays constant; the bouncing ball is the standard beginner test; rigidity is shown by how much an object deforms. A final section argues the goal of all the principles is personality.

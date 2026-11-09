---
id: src-gs-design-progression-balance
type: source
domain: game-design
source:
  url: "https://lostgarden.com/2007/07/19/the-chemistry-of-game-design/"
  urls:
    - "https://lostgarden.com/2007/07/19/the-chemistry-of-game-design/"
    - "https://lostgarden.com/2012/04/30/loops-and-arcs/"
    - "https://lostgarden.com/2021/12/12/value-chains/"
    - "https://www.gamedeveloper.com/design/behavioral-game-design"
    - "https://users.cs.northwestern.edu/~hunicke/pubs/Hamlet.pdf"
    - "https://gamebalanceconcepts.wordpress.com/"
    - "https://www.routledge.com/Game-Balance/Romero-Schreiber/p/book/9781498799577"
  title: "Progression, loops and balance: Lost Garden pages, Behavioral Game Design pointers, Hunicke & Chapman DDA (Hamlet), Game Balance pointers"
  retrieved: 2026-11-08
  version: "Lost Garden pages read by subagent; Hamlet PDF pages 1-5 read by the main agent; others pointers"
  capture: paraphrased
  retrieved_via: "Lost Garden and other pages via subagent summarizer; Hamlet PDF pages 1-5 read by the main agent from page images; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** pages fetched on 2026-11-08 by research subagents and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**; PDFs marked 'read by the main agent' were read from downloaded page images. Fees, defaults and policies are recorded only as written on that date; UNV/unverified items were not read on an official page (404, blocked, snippet-only). Godot page versions: 'header not reported' means the fetch tool did not show the version (the URL is the `stable` path). Not legal advice. Re-fetch before promoting dependent notes to `verified`.

- **Daniel Cook, "The Chemistry of Game Design" (Lost Garden, 2007-07-19; read by subagent):** presents skill atoms/chains as the author's belief; gives no studies or data; page comments dispute its psychology as "behaviourist and oversimplified"; the five-component skill-atom definition could not be confirmed from that page fetch (UNV). **"Loops and Arcs" (2012-04-30; read):** a loop is repeated action, feedback and model update; an arc is a mostly pre-processed payload ("a broken loop you exit immediately"); the test is what repeats and what does not; observation-based, market claims unsourced and speculative. **"Value Chains" (2021-12-12):** a method for balancing faucet-and-drain economies; only the intro seen (content UNV).
- **Reward schedules (pointers, UNV):** Hopson, "Behavioral Game Design" (Gamasutra 2001) — search summaries say variable-ratio schedules give the highest response rates among the schedules covered; a 2012 retrospective by Hopson argues "Skinner box" critics miss the point and acknowledges accusations that it promotes addiction. Transfer strength to games and the ethics are contested (UNV). Princeton TR (2012) and an MIT 2012 reward-preference paper were not read. No primary source read on onboarding or difficulty ramps.
- **Hunicke & Chapman, "AI for Dynamic Difficulty Adjustment in Games" (Northwestern; PDF pages 1–5 read by the main agent; page 6 and the conclusions not read):** abstract — games are boring when too easy and frustrating when too hard; most single-player games only offer static difficulty settings; they explore requirements for dynamic difficulty adjustment and present a probabilistic method drawn mainly from Inventory Theory. **Hamlet** is a DDA system built using Valve's Half-Life engine: libraries for monitoring game statistics against predefined metrics, defining and executing adjustment actions/policies, displaying data and generating play traces. It tries to predict when the player is "flailing" (repeated inventory shortfalls) and intervene "just enough" to support the player without removing negative feedback. Damage is modelled as a sum of random measurements that, by the Central Limit Theorem, approaches a Gaussian, under stated assumptions (constant probability of being hit, uncorrelated); a shortfall probability is computed from initial inventory, mean and standard deviation (footnote: best at predicting the not-too-distant future; with small samples the CLT is less accurate). Adjustment **actions:** *reactive* (on-stage: accuracy, damage, strength of attacks — simple and close to the interaction but risk breaking suspension of disbelief and making obstacles seem "schizophrenic") and *proactive* (off-stage: type, spawn order, health of entities not yet on screen — more power but harder to evaluate and may require follow-up reactive changes in a spiral). Costs of an action depend on location, progress, deaths, encounter repeats and past interventions. Example **policies:** *Comfort Zone* (keep the player around 50% health, dipping near 25% or cresting 75%, intervening frequently but allowing mistakes) and *Discomfort Zone* (keep the player at 15–20% health most of the time). The text speaks in future tense about unfinished parts ("when completed, Hamlet will support…", "currently experimenting"); no evaluation with players appears in the pages read, so it does not show that DDA improves outcomes.
- **Schreiber and Romero, *Game Balance* (CRC Press 2021, 806 pp.) and the Game Balance Concepts blog (ten-level course):** existence only; the blog's final post covers economic systems, multiplayer balance problems and spreadsheets; contents of the book unverified; no other "official" site confirmed.
- **Feedback-loop vocabulary beyond MDA:** Machinations/Dormans (Pearson sample chapter via search snippet; thesis PDF not found) — UNV.
- **Scope management (search snippets, UNV):** Game Developer postmortems and articles on scope and crunch (student team, Guns of Icarus, going indie after id Software, a solo-dev postmortem); an unsourced claim that scope problems appeared in 17 of 24 postmortems could not be traced. Postmortems are self-reported (survivorship bias is our caution).

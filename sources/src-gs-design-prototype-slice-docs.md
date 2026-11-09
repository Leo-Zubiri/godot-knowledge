---
id: src-gs-design-prototype-slice-docs
type: source
domain: game-studio
source:
  url: "https://ltpf.ramiismail.com/prototypes-and-vertical-slice/"
  urls:
    - "https://ltpf.ramiismail.com/prototypes-and-vertical-slice/"
    - "https://www.gamedeveloper.com/design/why-we-should-stop-saying-vertical-slices-"
    - "https://www.gamedeveloper.com/game-platforms/what-you-should-take-out-of-pre-production"
  title: "Prototype vs vertical slice and living design documentation (Ismail; Keith 2011; Florencio 2022)"
  retrieved: 2026-11-08
  version: "pages read 2026-11-08"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. Items marked `unverified` or *(search summary)* were not read in full on the primary page (blocked, binary PDF, abstract only). Not legal advice. Re-fetch or read the primary text before promoting any dependent note to `verified`.

- **Ismail (LTPF text, read):** prototypes are small, rough, disposable experiments focused on one open question; they show whether the game *should* be made, and their code/content should not carry into production. A **vertical slice** is a *production* test: one functional segment (a level or tricky section) built to near-shipping quality to show whether the team *can* make the game and to expose pipeline problems. For small teams: keep prototypes scoped and unpolished; use the slice to test production, not design; since slices are often self-funded and take months, validate interest before investing. Building a **second** item in the slice goes much faster than the first and is a better basis for estimating production (multiply and add margin). Pitching can start after prototyping with mockups/clips; publisher interest in the concept usually does not change between prototype and slice, what changes is confidence you can deliver.
- **Keith, "Why we should stop saying vertical slices" (Game Developer, 1 Dec 2011, read):** the term is confusing because people use it for different things. For Keith a slice means building a feature far enough to learn how valuable it is, then adjusting the plan from what is learned (a plan cannot reveal fun, a working game can); Ron Gilbert, as summarised by Keith, treats slices as part of a plan laying out all slices in advance, closer to an engineering approach, and objects that a linear method suits novels not games. Keith suggests "game increment" instead.
- **Florencio, "What you should take out of pre-production" (Game Developer, Jan/Feb 2022, read):** pre-production should be a deliberate, **timeboxed** phase; prototype each core system separately until engaging, then check how systems work together; the **vertical slice** is a playable chunk combining art, gameplay and core systems in one small area, validating direction and readiness for full production, scoped from the game's core pillars; define **pipelines** (what each handoff must contain, naming conventions, folder structure) early; documents go stale if written once — keep them **living** by making documentation routine and part of the **definition of done**.
- Not found: any data showing heavy GDDs work or fail; studio-published example GDD/TDD; TDD practice sources. Schreiber GDC 2025 "The Four One Page Design": title/speaker only (content unverified).

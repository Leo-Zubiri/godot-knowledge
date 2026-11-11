---
id: game-studio-spike-technical-feasibility-prototype
type: concept
domain: game-studio
status: proposed
summary: "A spike is a small, time-boxed, throwaway prototype whose only job is to answer one TECHNICAL/feasibility question (which tech, is it fast enough, does it feel right) and de-risk an estimate or an architecture decision — not to test whether the game is fun (that's a design prototype) and not to be kept (that's a tracer bullet). Output is the answer + a short report, not production code."
aliases: [spike, technical spike, spike solution, feasibility prototype, de-risking prototype]
tags: [dept/engineering, scope/process]
sources:
  - claim: "XP (Kent Beck): a spike solution is a very simple program to explore potential solutions / drive a spike through the design; time-boxed, risk-reducing, throwaway; SAFe formalizes it as an enabler story; distinct from a tracer bullet which is kept"
    ref: src-gs-spike-xp-and-safe
    retrieved: 2026-11-10
related:
  - relates-to: "[[game-studio-prototype-vs-vertical-slice]]"   # a spike is the technical/feasibility kind of throwaway prototype
  - relates-to: "[[gs-adr-living-design-docs]]"   # a spike's job is usually to CLOSE an open ADR with evidence
  - relates-to: "[[game-studio-physics-engine-vs-custom-simulation]]"   # the canonical thing a game spike resolves (which physics model)
  - relates-to: "[[game-studio-acceptance-criteria]]"   # a spike's exit = the question answered, not a passing feature
created: 2026-11-10
updated: 2026-11-10
created_by_type: agent
---

> **Evidence status:** the term and its properties are **established XP/SAFe practice**, paraphrased from web sources
> 2026-11-10 ([[src-gs-spike-xp-and-safe]], read as summaries — `proposed`). The application guidance is *interpretation*.

## What a spike is
A **spike** is a **small, time-boxed, throwaway** piece of work whose sole purpose is to **answer one technical or
feasibility question** and thereby **reduce risk** — the risk that an approach won't work, or the risk in an estimate.
Kent Beck's image (XP): *drive a spike through the whole design* — a thin vertical path that proves the hard part is
possible. The code is **written fast, quality ignored, then discarded**: it exists **to learn, not to ship**.

## What a spike is *not* (three neighbours)
| Thing | Question it answers | Kept? |
|---|---|---|
| **Spike** | *Which tech / is it feasible / is it fast enough / does it feel right?* (**technical**) | **No — throwaway** |
| **Design prototype** | *Should we make this — is it fun?* (**design**) | No — throwaway ([[game-studio-prototype-vs-vertical-slice]]) |
| **Tracer bullet** | *Does an end-to-end skeleton hold together?* | **Yes — kept and grown** |
| **Vertical slice** | *Can the team build this to shipping quality?* (production readiness) | Yes — representative of production |

A spike and a design prototype are both disposable; they differ in the **question** (feasibility/tech vs fun/design). A
spike and a tracer bullet both cut end-to-end; they differ in **whether the code survives**.

## How to run one well
- **Write the question first**, as a yes/no or a comparison ("does engine X give acceptable ball feel on target
  hardware?", "X vs Y — which?"). If you can't state the question, it's not a spike.
- **Time-box it** and keep it in a **separate folder** (e.g. `spike/`, `prototype/`) so throwaway code never leaks into
  production — a classic failure mode is a spike shipped as product code.
- **Target the single riskiest unknown** (performance, a platform, an engine behaviour, an integration), not the easy
  parts.
- **End with a decision + short report**, and when the spike exists to settle an architecture choice, **close the ADR**
  with its evidence ([[gs-adr-living-design-docs]]). The artefact of value is the **answer**, not the program.
- A spike **need not be code** (SAFe): a vendor eval, a data probe, or a feasibility read can be a spike.

## For AI-assisted production (interpretation)
- An agent can **build and run** a spike fast, keep it isolated, and report measurable facts (frame time, memory, whether
  an API behaves as documented). It **cannot** judge subjective "feel" — crispness, game-feel, whether motion reads as
  right — which needs a **human at the controls**, ideally on the **target device**, not just a dev machine.
- Failure modes: a spike with no written question (wanders); throwaway code promoted to production; judging "feel" from
  a headless/CI run; a spike that never ends (no time-box, no decision).

## See also
- [[game-studio-prototype-vs-vertical-slice]] — the broader prototype/slice distinction a spike sits inside
- [[game-studio-physics-engine-vs-custom-simulation]] — the canonical game spike (which physics model, decided by feel on-device)
- [[gs-adr-living-design-docs]] — a spike usually exists to close an open ADR

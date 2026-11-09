---
id: game-design-scoping-questions-for-new-game-or-feature
type: reference
domain: game-design
status: proposed
summary: "Question bank an agent works through before planning a new game or a new feature: read the repo first, ask at most five stack-changing (Tier 0) questions with defaults, assume and record the rest, turn answers into ADRs and the project profile; includes generic unreviewed lessons from a planning session."
aliases: [scoping questions, discovery questions, kickoff checklist, make a game of X, add feature Y]
tags: [dept/design, dept/orchestration]
applies-to:
  min: "engine-agnostic; Godot-specific defaults refer to 4.7"
  tested: "not tested — a procedure, not a measured result"
sources:
  - claim: "Godot MIT requires the licence text somewhere in the game; third-party component notices; C# cannot export to web, Android/iOS experimental; WebRTC needs a signaling server and a native plugin"
    ref: src-gd-licences-csharp-webrtc-scoping
    retrieved: 2026-11-08
  - claim: "OFL fonts bundled in an app must ship copyright, licence notice and licence text; author credit is not required. Nygard ADR format and supersede rule. Steam AI content disclosure categories (secondary coverage). One-page design document idea (abstract only)"
    ref: src-gs-design-scoping-ofl-adr-steam-ai-onepage
    retrieved: 2026-11-08
  - claim: "COPPA six-step plan (under-13, verifiable parental consent), ESRB/PEGI in-game-purchase descriptors, Apple guideline on data and AI disclosure"
    ref: src-gs-delivery-steam-store-privacy
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-game-project-profile]]"   # the answers are written into the profile the agent reads first
  - depends-on: "[[gs-adr-living-design-docs]]"   # Tier-0 answers become ADRs instead of a big GDD
  - refines: "[[game-studio-configurable-rigor]]"   # question 0.12 sets the rigor dial this pattern expands
  - relates-to: "[[game-studio-prototype-vs-vertical-slice]]"   # question 0.14 forces the team to say which one v1 is
  - relates-to: "[[godot-config-driven-tunables]]"   # question 0.11 decides where tunables live
  - relates-to: "[[godot-reusable-module-packaging]]"   # question 0.11 decides whether modules must be extractable
  - relates-to: "[[godot-localization-workflow]]"   # question 0.10: tr() from day one
  - relates-to: "[[game-studio-asset-license-and-provenance-policy]]"   # question 0.8: attribution and AI-asset policy
  - relates-to: "[[game-studio-delivery-platforms-and-fees]]"   # question 0.2 and 0.6: platform rules and fees
  - relates-to: "[[game-studio-delivery-steam-store-privacy-notes]]"   # question 0.15: COPPA, ratings, privacy
  - relates-to: "[[game-studio-game-design-theory-vocabulary]]"   # Tier-1 pillars and loops use this vocabulary
  - relates-to: "[[game-studio-progression-loops-and-dda]]"   # Tier-1 progression and assist questions
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** the question bank and its defaults are *interpretation* (an agent's procedure), grounded where a fact is asserted in official pages retrieved 2026-11-08 (Godot 4.7 licence/C#/WebRTC pages, OFL FAQ, Nygard's ADR post, FTC COPPA plan, ratings bodies). The Steam AI-disclosure item rests on **secondary press coverage** because the primary post did not render. The "Lessons" section is **unreviewed agent observation** from one planning session and is not evidence of anything general. Status `proposed`. Evidence classes used: *documented* (cited page), *interpretation* (own synthesis), *unverified* (not found on a page read), *observation* (one session, unreviewed).

## Overview and when to use
An instruction such as "make a game of X" or "add feature Y" under-specifies the decisions that are expensive to reverse. This note is the list of questions an agent runs **before** writing a plan, in three tiers: **Tier 0** changes the stack or the legal footing, **Tier 1** shapes the design, **Tier 2** is detail that other notes already cover. Use it for a new game, a new feature on an existing game, or a re-scope after a Tier-0 answer changes. The method is *interpretation*; the facts in the tables cite sources.

## Step 0 — read before asking
Never ask what the repository already answers. In order: the project profile ([[game-studio-game-project-profile]]), existing ADRs ([[gs-adr-living-design-docs]]), `project.godot` and `export_presets.cfg` (platforms, language, renderer, feature tags), `addons/`, the licence and credits files, CI config, and this knowledge base (search `notes/` first per AGENTS.md). Write down every answer you found as `FOUND:` with its file path; only the rest become questions.

## Tier 0 — stack-changing questions
| # | Question | Options | Default if unanswered | Blocking | What it changes downstream |
|---|---|---|---|---|---|
| 0.1 | Existing IP/trademark or generic theme? | own IP · licensed · generic | generic, no real names/logos | yes | naming, asset sourcing, store review, legal review |
| 0.2 | Platforms for v1, platforms later? | desktop · mobile · web · console-later | desktop first; mobile/web declared "later" or "never" | yes | language (web excludes C# — *documented*), renderer, input, store accounts, test matrix |
| 0.3 | Scripting language? | GDScript · C# · mix | GDScript | yes | web export viability, plugin ecosystem, CI toolchain, who can review code |
| 0.4 | 2D or 3D, and renderer? | 2D · 3D · 2.5D; Compatibility · Mobile · Forward+ | follows 0.2: web/mobile → Compatibility or Mobile | conditional | asset pipeline, performance floor, device testing |
| 0.5 | Multiplayer scope and who is trusted? | none · hot-seat · LAN host-authoritative · online dedicated | none; if any, hot-seat first | yes | authority model, backend cost, cheating surface, netcode in the core loop. LAN ≠ internet: WebRTC/online needs a signaling server, NAT traversal and possibly relays (*documented* for signaling/plugin; relay cost *unverified* on the page) |
| 0.6 | Monetisation intent, even "someday"? | none · paid · IAP · ads · DLC | none, but keep an `Entitlements` interface so "someday" does not rewrite the data model | conditional | server-verified purchases, refunds, ratings descriptors (In-Game Purchases — *documented*), privacy |
| 0.7 | Accounts and persistence? | local save · cloud save · accounts | local save, versioned schema | conditional | save format, auth, GDPR/COPPA, backend |
| 0.8 | Cost/licence/attribution policy, repo visibility, AI-asset policy? | CC0-only · attribution-ok · paid · AI allowed/disallowed | attribution-ok, licences folder shipped, AI disclosed | yes | asset sourcing. "No attribution anywhere" is impossible: Godot's MIT text must ship in the game (*documented*), and bundled OFL fonts must carry their licence text (*documented*). Steam's survey asks to disclose AI-generated content (*secondary*) |
| 0.9 | Input devices and accessibility floor? | keyboard-mouse · gamepad · touch; remap yes/no | all three mapped through actions, full remap, assist options | conditional | UI focus design, touch layout, prompts, test devices (see the input conventions note) |
| 0.10 | Languages at launch and later? | one · several · RTL | English + one, `tr()` on every string from day one | soft | font fallbacks, string length, CSV/PO pipeline |
| 0.11 | Config-driven tunables and cross-game modularity expected? | hard-coded ok · tunables in resources · modules extractable | tunables in resources; modules extractable only if asked | soft | where numbers live, addon layout, test seams |
| 0.12 | Team, rigor level, decision owner, deadline? | solo · small team; minimal/standard/full | solo, minimal rigor, the human owns decisions | yes | review gates, how many agents, documentation depth |
| 0.13 | Tooling: engine version pin, CI, test framework, knowledge base? | pin yes/no; CI yes/no; GUT/gdUnit4/none | pin exact version; headless `--import`/`--check-only` in CI; one test framework | soft | reproducibility, what agents may run |
| 0.14 | What is v1 and what is explicitly out? | prototype · vertical slice · release | one prototype answering one question | yes | everything else; forces a non-goals list |
| 0.15 | Audience age, data and telemetry? | adults · teens · children; no data · crash only · analytics | adults, crash-only, opt-in | yes | COPPA applies under 13 with parental consent duties (*documented*), rating descriptors, privacy policy |

## Tier 1 — design questions with defaults
| Question | Default when unanswered |
|---|---|
| One-sentence pitch and 2–3 reference games | ask; a pitch cannot be assumed |
| ≤ 3 pillars | derive from the pitch, mark `ASSUMED:` |
| Core loops at 30 s / 5 min / meta | 30 s loop first; meta loop out of v1 |
| Win/lose conditions | explicit, testable condition per mode |
| Minimum content for v1 | one level/board/arena, one mode |
| Progression and unlocks | none in v1 (see [[game-studio-progression-loops-and-dda]]) |
| AI opponents | one simple scripted opponent; difficulty by tunables |
| Assists and difficulty | at least one assist and a difficulty setting (Apple HIG suggests "control assistance", reaction-time and success-criteria adjustments — cited in the input conventions note) |
| Art style and asset origin | placeholder/CC0 for the prototype; policy from 0.8 |
| Audio identity | placeholder; loudness targets later |
| Scale/units and whether a **precise physics simulation** is required | if gameplay depends on exact collisions/rolling/stacking, schedule a **decision spike** comparing engine rigid bodies with a custom deterministic sim before committing (*interpretation*) |
| Device floor | the weakest device named in 0.2 |
| Save model | local versioned save; cloud out of v1 |

## Tier 2 — pointers only
Input conventions per genre and device → [[game-design-input-mapping-conventions-keyboard-gamepad-touch]]. Purchase integrity and cheating → [[game-studio-anti-cheat-and-purchase-integrity]]. LAN host-authoritative pattern → [[godot-lan-host-authoritative-turn-based]]. Store, privacy and ratings → [[game-studio-delivery-steam-store-privacy-notes]].

## Feature variant — "add Y"
| Ask | Default |
|---|---|
| User problem Y solves, in one sentence | ask |
| ADRs touched or contradicted | list them; a contradiction needs a superseding ADR (Nygard: keep the old one, mark it superseded — *documented*) |
| Affected modules and their contracts | smallest set; no new module unless two consumers exist |
| Save/data compatibility | schema version bump + migration or explicit "v1 saves reset" |
| New tunables and where they live | resources, per [[godot-config-driven-tunables]] |
| Input per device (keyboard, pad, touch) | an action per verb; prompts follow the active device |
| Multiplayer impact | if the host simulates, Y is an intent validated by the host |
| Acceptance tests | one headless test per acceptance line |
| Docs/ADR update | same change set |
| Non-goals | written |
Default delivery: the smallest slice **behind a feature flag**.

## Method
1. **Prioritise by irreversibility × cost** (hypothesis, *interpretation*): a platform or language flip rewrites code; a pillar change rewrites a design doc.
2. **Ask ≤ 5 Tier-0 questions in one message**, each with structured choices and a recommended default; list every other assumption as `ASSUMED: …` so the human can veto cheaply.
3. **Record answers as ADRs** in Nygard's format (Title, Context, Decision, Status, Consequences; numbered, never reused, superseded not deleted — *documented*) and update the project profile.
4. **Re-ask triggers:** a new platform, money, more than one player, any external service, a licence change.
5. **Pre-plan self-check:** platform? language? money? attribution? does the engine already have native touch nodes? online cost? physics precision? am I over-engineering? too many agents/modules/docs for the rigor level?
6. **Stop rule:** when Tier-0 answers exist (found or assumed) and v1 has a non-goals list, stop asking and plan.

## Lessons — unreviewed agent observations from one planning session
Generic symptoms recorded after the fact; **not verified knowledge**, kept so the self-check above has a rationale.

| Symptom observed | Question that would have caught it |
|---|---|
| Scripting language flipped once target platforms and the knowledge base's focus were known | 0.2 + 0.3 together, before any code |
| Monetisation surfaced late and changed the data model | 0.6 "even someday" → entitlements interface |
| "No attribution" requested, but fonts and the engine require licence text | 0.8 with the MIT/OFL facts stated up front |
| Config-driven and cross-game modularity expectations were unstated until review | 0.11 |
| Plan assumed touch plugins; the engine already ships touch nodes | self-check "native touch?" and Step 0 reading the engine docs |
| LAN plan silently became an internet plan with relay costs | 0.5 LAN ≠ internet |
| Rigid-body engine judged unsuitable for a precise tabletop simulation after implementation started | Tier-1 physics-precision spike |
| Too many agents, modules and documents created up front for a solo prototype | 0.12 + 0.14 |

## What an agent can and cannot check
**Can check by reading files:** which Tier-0 answers already exist (`project.godot`, presets, ADRs, licences folder), whether every string goes through `tr()`, whether a feature flag exists, whether an ADR was superseded rather than edited. **Cannot check without a human:** the pitch, pillars and audience; legal items (IP, COPPA applicability, store policy interpretation); whether an assumption listed as `ASSUMED:` is acceptable; whether the physics spike's verdict is right for the feel the designer wants.

## See also
- [[game-studio-game-project-profile]] — the answers are written into the profile the agent reads first
- [[gs-adr-living-design-docs]] — Tier-0 answers become ADRs instead of a big GDD
- [[game-studio-configurable-rigor]] — question 0.12 sets the rigor dial this pattern expands
- [[game-studio-prototype-vs-vertical-slice]] — question 0.14 forces the team to say which one v1 is
- [[godot-config-driven-tunables]] — question 0.11 decides where tunables live
- [[godot-reusable-module-packaging]] — question 0.11 decides whether modules must be extractable
- [[godot-localization-workflow]] — question 0.10: tr() from day one
- [[game-studio-asset-license-and-provenance-policy]] — question 0.8: attribution and AI-asset policy
- [[game-studio-delivery-platforms-and-fees]] — questions 0.2 and 0.6: platform rules and fees
- [[game-studio-delivery-steam-store-privacy-notes]] — question 0.15: COPPA, ratings, privacy
- [[game-studio-game-design-theory-vocabulary]] — Tier-1 pillars and loops use this vocabulary
- [[game-studio-progression-loops-and-dda]] — Tier-1 progression and assist questions
- [[game-design-input-mapping-conventions-keyboard-gamepad-touch]] — Tier-2 input conventions
- [[game-studio-anti-cheat-and-purchase-integrity]] — Tier-2 purchase integrity
- [[godot-lan-host-authoritative-turn-based]] — Tier-2 LAN pattern

---
id: src-gs-ccgs-workflow-rigor-and-gates
type: source
domain: agent-ops
source:
  url: "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/docs/workflow-modes.md"
  urls:
    - "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/docs/workflow-modes.md"
    - "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/docs/director-gates.md"
    - "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/docs/skills-reference.md"
    - "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/studio-tests/quality-rubric.md"
  title: "CCGS workflow modes, director gates, skills reference, skill quality rubric"
  retrieved: 2026-11-08
  version: "v1.2.0; main@05ad7c8"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** the files were fetched on 2026-11-08 from the `main` branch (HEAD at retrieval: `05ad7c8a5b8aa2aa86bbd3439ae7cf7295cac418`, committed 2026-10-19; the fetch itself was by branch name, so the pin is the HEAD observed shortly after) and summarized by a fetch-time summarizer: a **paraphrased extraction, not verbatim text**. This is a *reference architecture* studied for patterns; nothing is copied and the repo is not a dependency. Statements are **documented (D)** in the repo or **project-reported (P)**; none were tested by us. Re-fetch before promoting dependent notes to `verified`.

- **Rigor tiers (workflow-modes.md, D):** `modes.rigor` = minimal (default) | standard | full. Resolution order in skills: per-system override → project `modes.workflow` → tier implied by rigor; hardcoding "standard" as a fallback is warned against.
  - minimal: one-page `design/game-brief.md` + engine choice; build-order field is the plan; GDDs optional.
  - standard: five GDD sections per system (Overview, Detailed Rules, Edge Cases, Dependencies, Acceptance Criteria), formulas only for tunable numeric rules; one architecture doc, critical ADRs, concept doc, systems index; art bible only if visual-asset stories exist.
  - full: all eight GDD sections, full architecture, all ADRs, art bible (nine sections), UX spec per screen.
  - Three boolean flags (`edge_cases`, `tuning_knobs`, `art_bible_strict`) only add requirements. `system_overrides` can replace the tier for one system in either direction (setting minimal on a full project drops that system's requirements to zero); the key is the GDD filename stem; a key matching no GDD is an error at gate-check. Companion knobs (`docs.density`, `modes.story_granularity`, `qa.level`, `team.size`, `modes.review_mode`) can be set explicitly; the rigor→value mapping is not stated on that page. Cost labels are qualitative (low/balanced/high), no figures.
- **Review modes (director-gates.md, D):** solo (default; no director gates), lean (only four phase-transition gates via /gate-check), full (every gate at each workflow step). A skill may override per run (narrative consistency gate is the stated exception). Gate IDs are prefixed by director role (CD creative, TD technical, PR producer, AD art, LP lead programmer, QL QA lead, ND narrative), each with its own definition file.
- **Verdict semantics:** per-gate APPROVE/READY, CONCERNS, REJECT/NOT READY, NOT ASSESSED (a required input was missing; never treated as approval); roll-up PASS/FAIL/CONCERNS. Parallel gates: all calls issued before awaiting any; strictest verdict wins (any NOT READY → FAIL; any CONCERNS caps at CONCERNS; any NOT ASSESSED prevents a clean pass); PASS still subject to artifact checks.
- **Invocation:** a skill spawns a director and points it at the gate definition file; the director reads the file, so the caller never loads the prompt; only required context fields are passed; outcomes recorded in the document's status header. No cost figures; levers implied: solo spawns none, lean only phase gates.
- **Skills (skills-reference.md, D):** 74 slash commands in 12 groups (Onboarding 6, Game Design 6, Art & Assets 3, UX 2, Architecture 4, Stories & Sprints 8, Reviews 10, QA & Testing 10, Production 6, Release 6, Creative & Content 4, Team Orchestration 9). /start routes; /help suggests next step; /project-stage-detect audits phase; /gate-check decides advancement. QA skills include /smoke-check (critical-path gate before QA hand-off), /regression-suite (maps coverage, finds fixed bugs lacking regression tests), /test-flakiness (from CI logs). Project skills do not disable Claude Code bundled skills (`skillOverrides` hides them).
- **Skill quality rubric (studio-tests, D):** binary metrics (pass/fail/warn/not-assessed) per skill category (gate, review, authoring, readiness, pipeline, analysis, team, sprint, utility) and agent category (director, lead, specialist, engine, qa, operations), run via /skill-test; e.g. gates must respect review mode and not advance stage without user confirmation; reviews are read-only; authoring writes section by section with approval; agents must stay in domain and escalate cross-department conflicts to the right parent. Whether /skill-test runs automatically anywhere: unverified.

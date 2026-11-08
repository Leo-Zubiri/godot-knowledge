---
id: src-gs-ccgs-repo-overview
type: source
domain: game-studio
source:
  url: "https://github.com/Donchitos/Claude-Code-Game-Studios ; https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/LICENSE ; https://github.com/Donchitos/Claude-Code-Game-Studios/releases ; https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/project.yaml ; https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/docs/config-resolution.md"
  title: "Claude-Code-Game-Studios: README, LICENSE, releases, project.yaml, config resolution"
  retrieved: 2026-11-08
  version: "v1.2.0 (2026-10-19); main@05ad7c8"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** the files were fetched on 2026-11-08 from the `main` branch (HEAD at retrieval: `05ad7c8a5b8aa2aa86bbd3439ae7cf7295cac418`, committed 2026-10-19; the fetch itself was by branch name, so the pin is the HEAD observed shortly after) and summarized by a fetch-time summarizer: a **paraphrased extraction, not verbatim text**. This is a *reference architecture* studied for patterns; nothing is copied and the repo is not a dependency. Statements are **documented (D)** in the repo or **project-reported (P)**; none were tested by us. Re-fetch before promoting dependent notes to `verified`.

- **Licence:** MIT, copyright "Donchitos 2026"; grants the usual rights, requires the notice in copies, AS IS. The text does **not** address third-party or bundled assets (unverified whether any are bundled).
- **Repo facts (GitHub API, 2026-11-08, via research agent):** created 2026-02-12, last push 2026-10-19, ~37.0k stars / 4.9k forks (anomalous for a solo-author repo under 9 months; manipulation not checked), 96 open issues, no `.github/workflows` (no CI evidenced).
- **README-claimed counts:** 49 agents, 74 skills, 15 hooks (project-structure section mentions 18 scripts), 14 rules, 62 templates. (Repo About text says 72 skills — documentation drift.) "Built for Claude Code" badge.
- **Minimal quick-start flow (README):** /start → /setup-engine → /brainstorm (one-page brief) → /create-stories → loop /dev-story ↔ /story-done. Minimal is the default rigor.
- **Project-reported comparison (README, P, unverified):** four games from one brief at different rigor levels; only minimal and standard are reported. Documents before game code: minimal 1 (one-page brief), standard 30. Time per table: minimal 0 min, standard 58 min. Two blind reviewers plus a human playtest ranked the standard build last; the page says the extra documents bought traceability, not a better game. Games are not in the repo, full rankings and the other two rigor levels are not given → not independently checkable. Note: `workflow-modes.md` itself contains no such comparison.
- **Releases (themes):** v0.1.0 2026-02-14 first release; v0.2.0 2026-02-20 file-backed session state; v0.3.0 2026-03-09 /design-system, status line; v1.0.0-beta 2026-04-07 ~70 skills/48 agents, director gates, traceability, QA pass; v1.0.0 2026-05-13 stable, /prototype and /vertical-slice split; v1.1.0 2026-09-23 single project.yaml, rigor settings, light path default; v1.1.1 2026-09-24 fixed skills/agents failing before start outside auto mode; v1.1.2 2026-09-29 minimal path made to work end to end, Unity/Unreal parity; v1.1.3 2026-10-08 long skills losing later steps after compaction, unanswered questions no longer treated as answers, tightened permissions; v1.2.0 2026-10-19 core story skills rebuilt around helper scripts, read guard for large docs, engine refs updated (Godot 4.7), skills stop pre-approving every shell command. → several fix releases within days of 1.1.0 (churn signal).
- **project.yaml model:** two top-level keys (`schema_version`=1, `framework` version 1.2.0 + upgrade date). Comments describe a `modes` block with `modes.rigor` and `modes.automation` written by /start. Six settings are deliberately kept out of the file (`modes.review_mode`, `modes.workflow`, `docs.density`, `qa.level`, `modes.story_granularity`, `team.size`); they come from rigor expansion unless set explicitly (explicit value overrides). Personal prefs go in gitignored `project.local.yaml`.
- **Config precedence (highest first):** project.local.yaml (whitelist ~12 keys) → project.yaml → legacy text files (review_mode, stage only) → modes.rigor expansion → documented defaults. Empty = unset; invalid value skipped and reported in a `notes:` line; each resolved line shows its source. No env vars as config sources; no per-skill config file (skills load one resolved block through a bootstrap command).
- **Godot support:** 5 Godot specialist agents (GDScript, C#, GDExtension, shaders, general); gdUnit4 for tests; engine refs updated to Godot 4.7 in v1.2.0. Unity and Unreal supported in parallel.

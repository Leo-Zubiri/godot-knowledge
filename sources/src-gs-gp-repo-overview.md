---
id: src-gs-gp-repo-overview
type: source
domain: agent-ops
source:
  url: "https://github.com/jame581/GodotPrompter"
  urls:
    - "https://github.com/jame581/GodotPrompter"
    - "https://github.com/jame581/GodotPrompter/blob/master/README.md"
    - "https://github.com/jame581/GodotPrompter/blob/master/LICENSE"
    - "https://github.com/jame581/GodotPrompter/releases"
  title: "GodotPrompter: repo overview, README, licence, releases"
  retrieved: 2026-11-08
  version: "v1.16.0 (2026-10-22); master@d7b26cd"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** files fetched on 2026-11-08 from the `master` branch (HEAD verified via GitHub API at retrieval: `d7b26cdb5fae14d4ef7b713c5bf259395e75c3c6`, committed 2026-10-24; fetch was by branch name) and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. A *reference architecture* studied for patterns only; nothing copied, not a dependency. Statements are documented (D) or project-reported (P); none tested by us. Re-fetch before promoting dependent notes to `verified`.

- **Repo facts (GitHub API 2026-11-08):** default branch `master`; created 2026-04-03; last push 2026-11-01; 938 stars, 63 forks; 1 open issue; MIT (SPDX), copyright "GodotPrompter Contributors 2026", no carve-outs in text; single author in the 10 recent commits; at least 15 releases visible v1.9.0 (2026-05-29) → v1.16.0 (2026-10-22), cadence roughly every 1–3 weeks. HEAD is the merge of PR #39 "load the plugin on OpenCode 2.x" (2026-10-24). Star count shows no anomaly for its age.
- **Layout (API listing, T):** `skills/` 59 folders + generated `skills/index.json`; `agents/` 9 Markdown agents; `.codex/agents/godot-prompter/` 9 generated TOML mirrors; `scripts/`, `tests/` (agent-integration, hooks, opencode, validator); `hooks/` (hooks.json, hooks-cursor.json, run-hook.cmd, session-start); `.github/workflows/` validate, release, plugin-scan, auto-assign-issues. Only `GEMINI.md` exists for Gemini; no `gemini/` or `antigravity/` directories.
- **README claims (P):** 59 skills, 9 agents; baseline Godot 4.3+ with 4.5–4.7 features as annotated sections; Claude Code primary/verified, Copilot CLI verified, Cursor registration present but end-to-end unconfirmed, Codex/OpenCode/Antigravity/Grok Build documented (Grok smoke pending); Codex and Antigravity have no hook mechanism and load bootstrap through instruction files (AGENTS.md / GEMINI.md). On Claude Code/Copilot CLI a SessionStart hook injects a routing card when a `project.godot` is found nearby (incl. monorepo subfolders; skips vendored addons and dot-dirs; no network; writes nothing); subagents don't get the hook, so the plugin can offer once to add a section to the repo's instruction file. Mentor mode (teaching-style output; preference stored outside the game repo; can be turned off). Update model: new users pointed to the `skillsmith` marketplace, older marketplace kept for existing installs, installs can be pinned to a release tag.
- **Provenance:** built on the "Superpowers" plugin for Claude Code; the SessionStart hook's Windows wrapper and JSON escaping are adapted from Superpowers under MIT. What else is reused: unverified. Third-party addon licences are recorded in each addon skill header and were not audited.
- **Validation claim (P):** validator runs on PRs, pushes and tags; README reports 0 errors and 57 warnings (all intentional C# parity warnings); "since v1.15.1 every code example has been parsed (GDScript) or compiled (C#) against Godot 4.7.2" — **no repeatable script or CI step for this was found** (see src-gs-gp-validation-ci); treat as unverified.

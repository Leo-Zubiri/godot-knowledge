---
id: src-gs-gp-platforms-and-hooks
type: source
domain: game-studio
source:
  url: "https://github.com/jame581/GodotPrompter/blob/master/tests/agent-integration/host-smoke-matrix.json"
  urls:
    - "https://github.com/jame581/GodotPrompter/blob/master/tests/agent-integration/host-smoke-matrix.json"
    - "https://github.com/jame581/GodotPrompter/blob/master/tests/agent-integration/TEST_PLAN.md"
    - "https://github.com/jame581/GodotPrompter/blob/master/tests/agent-integration/RESULTS.md"
    - "https://github.com/jame581/GodotPrompter/blob/master/hooks/hooks.json"
    - "https://github.com/jame581/GodotPrompter/blob/master/.codex/INSTALL.md"
    - "https://github.com/jame581/GodotPrompter/blob/master/.opencode/INSTALL.md"
  title: "GodotPrompter cross-platform matrix, test plan, results, hooks and install docs"
  retrieved: 2026-11-08
  version: "master@d7b26cd"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** files fetched on 2026-11-08 from the `master` branch (HEAD verified via GitHub API at retrieval: `d7b26cdb5fae14d4ef7b713c5bf259395e75c3c6`, committed 2026-10-24; fetch was by branch name) and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. A *reference architecture* studied for patterns only; nothing copied, not a dependency. Statements are documented (D) or project-reported (P); none tested by us. Re-fetch before promoting dependent notes to `verified`.

- **Host smoke matrix (D):** seven hosts — Claude Code (label Verified; 3 checks: catalog discovery, session-hook behaviour, post-update discoverability), GitHub Copilot CLI (Verified; 3 checks), Cursor ("registration ships; end-to-end pending"; 3 checks), Codex (Documented; 2 checks), Antigravity (Documented; 2), OpenCode (Documented; 2, menu-based discovery), Grok Build (install path documented; 2). Each host has install method, instruction-file location, discoverability mechanism, status label and checks. **The matrix records no results** (no pass/fail data, dates or run output); "Verified" labels point to documents not included there.
- **Test plan (TEST_PLAN.md, D):** manual suite run in a fresh Claude Code session with the plugin installed; six categories: cold start; skill discovery by plain requests; end-to-end workflow of builds in one session (project/player, enemy, HUD, review, save/load); third-party addons (agent must use the addon's real API and addon skill, not the core skill); mentor mode and presence (five-beat format, limits on editor click-paths, silence outside Godot projects, state kept out of the game repo, subagent reach through an instructions-file section); decision-first design (scoped design questions before building, respects decision records, skips questioning for bug fixes). Tests have expected behaviour and pass criteria; some probabilistic (a routing case fired ~4 of 5 runs → repeat before judging); category 4 has pre-release (read from working tree) and post-release (installed plugin) modes. Results are to be recorded in RESULTS.md.
- **Recorded result (RESULTS.md, P):** one pre-release run, 2026-07-14, v1.12.0-rc, Sonnet 4.5 in the Claude Code subagent harness: three fresh subagents given only a prompt and the skills path had to choose a skill from its description and answer from content — 3 of 3 passed. It tested description discoverability and content sufficiency, **not** routing through the installed plugin; four non-blocking content gaps noted; rerun planned after release. Nothing about agents or full workflows beyond this.
- **hooks.json (D):** one event, SessionStart, matcher for startup/resume/clear/compact, synchronous command hook calling a single `run-hook.cmd session-start` wrapper with generic/bash/powershell variants (precedence between variants inferred, not documented). `hooks/session-start` script is ≈14.7 KB (larger than the card it emits).
- **Codex (D, .codex/INSTALL.md):** clone to `~/.codex/godot-prompter`; symlink (junction on Windows) the skills folder to `~/.agents/skills/godot-prompter`; optional symlink of agents folder to `~/.codex/agents/godot-prompter`; full restart required; update by `git pull` (symlink makes changes immediate); hooks not mentioned.
- **OpenCode (D, .opencode/INSTALL.md):** requires OpenCode 2.x or 1.x ≥1.18.20; add the git URL to the `plugin` array in `opencode.json` (2.x calls the key `plugins` but still accepts `plugin`); restart; `/skills` lists skills; pin with a `#<tag>` suffix (e.g. `#v1.16.0`) and upgrade by changing the tag — restart does not update; tool mapping (TodoWrite→todowrite, Task→@mention, Skill→native `skill` tool); git plugins are cached, so older checkouts (<v1.16.0) can fail on 2.x with an export error until a newer tag is pinned or the cache under `~/.cache/opencode/npm/` is deleted.
- **Portable vs host-specific:** portable = SKILL.md folders with standard fields, AGENTS.md, Markdown agents, generated TOML, JSON index; host-specific = SessionStart hook, marketplace manifests, OpenCode tool-name mapping.

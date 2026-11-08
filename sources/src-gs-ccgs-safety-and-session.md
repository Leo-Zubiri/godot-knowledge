---
id: src-gs-ccgs-safety-and-session
type: source
domain: game-studio
source:
  url: "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/settings.json"
  urls:
    - "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/settings.json"
    - "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/docs/hooks-reference.md"
    - "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/docs/context-management.md"
  title: "CCGS settings, hooks reference, context management"
  retrieved: 2026-11-08
  version: "v1.2.0; main@05ad7c8"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** the files were fetched on 2026-11-08 from the `main` branch (HEAD at retrieval: `05ad7c8a5b8aa2aa86bbd3439ae7cf7295cac418`, committed 2026-10-19; the fetch itself was by branch name, so the pin is the HEAD observed shortly after) and summarized by a fetch-time summarizer: a **paraphrased extraction, not verbatim text**. This is a *reference architecture* studied for patterns; nothing is copied and the repo is not a dependency. Statements are **documented (D)** in the repo or **project-reported (P)**; none were tested by us. Re-fetch before promoting dependent notes to `verified`.

- **Permissions (settings.json, structural description):** default permission mode (prompts). Allow-list is tiny (directory listing, pytest). Deny-list is broad, for Bash and PowerShell: recursive forced deletion in many flag orderings, force pushes/history-overwriting pushes, hard resets, forced `git clean`, `sudo`, over-permissive `chmod`, reading/editing `.env` files, editing Unreal binary assets. Also a status-line script and worktree base setting. Hook events registered: SessionStart, PreToolUse (Bash/PowerShell, Write/Edit, Read), PostToolUse (Write/Edit), Notification, PreCompact, Stop (async), SubagentStart, SubagentStop; timeouts mostly 5–15 s.
- **Hooks (hooks-reference.md, D, not run by us):** most validators **warn** and proceed; only a must-fix problem exits with code 2. The read guard is the only hook that refuses on its own (blocks whole-file reads over 40 KB in certain doc folders, replies with headings so a ranged read can follow; can be turned off by config). Commit/push/registry/write/artifact/asset hooks warn. `validate-write` flags overwrites of protected files, out-of-range config values, subagent writes outside allowed folders; `validate-agent-artifact` flags a missing subagent output file (warning shown to the user only, because text to Claude would keep the subagent running); `validate-assets` checks JSON data and applies naming checks only to Godot's `assets/`. Session-start loads sprint/milestone/git context and previews recoverable state (and runs again after compaction); gap detection suggests next commands; pre-compact only logs (Claude Code ignores its output, so restoration falls to session-start); notification hook is Windows-only; session-stop is async, runs after every response, and may be cancelled under `claude -p`; subagent start/stop hooks write an audit log and tally. Stated limitation: hooks do not run in every tool, so skills re-run the same checks themselves.
- **Session state (context-management.md, D):** a living file `production/session-state/active.md` is the real memory: a short checkpoint (< ~25 lines, overwritten: task, next step, blockers, in-progress files, open questions) above a free-form narrative; a rotation script archives the narrative past ~200 lines without deleting. Compact proactively at ~60–70% context and at natural breakpoints; `/clear` between unrelated tasks; before compaction preserve state-file reference, modified files, decisions, sprint status, agent results, test outcomes, open questions; after compaction/crash reread the state file.
- **Context budgets (project guidance, not measured):** ~3k tokens read-only review, ~8k feature implementation, ~15k large refactor. **Scripts over reading:** deterministic questions (which sections a doc has, which docs changed) are answered by scripts, not by the model reading the doc; helpers report facts, callers judge. **Subagent summaries:** broad exploration delegated to subagents that return only summaries; for a few known files, direct reads are simpler.

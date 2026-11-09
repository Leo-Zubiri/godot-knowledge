---
id: game-studio-agent-orchestration
type: reference
domain: agent-ops
status: proposed
summary: How to share instructions, skills and tool configuration across Claude Code, Codex and OpenCode without vendor lock-in; no extra orchestration framework.
tags: [dept/orchestration]
sources:
  - claim: "AGENTS.md, SKILL.md and MCP portability facts per agent product"
    ref: src-gs-agent-instructions-portability
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-skills-architecture]]"   # skills layered on this instruction base
  - relates-to: "[[gs-adr-no-extra-orchestration-framework]]"   # decision derived from this
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Ratings are *preliminary recommendations*, not approved standards.


## Shareable without lock-in (documented)
- **`AGENTS.md`** as the single instruction source. Claude Code reads CLAUDE.md and can import `@AGENTS.md` (this repo does); Codex walks AGENTS.md from the git root down (32 KiB default cap); OpenCode reads AGENTS.md first, CLAUDE.md as fallback.
- **Agent Skills standard `SKILL.md`**: required `name` (≤64 chars, equals directory) and `description` (≤1024); optional `license`, `compatibility`, `metadata`, `allowed-tools` (experimental). A skill limited to these fields works unchanged in Claude Code.
- **MCP** is a protocol standard; only per-agent *config syntax* differs.
- **Plain CLI/shell commands** (`godot --headless …`, test runner, lint) any agent can call.

## Not portable
Claude hooks, `context: fork` and command injection; Codex `agents/openai.yaml`. Keep general skills free of these.

## Open points (`unverified`)
Skill directory for Codex (`.agents/skills` vs `.codex/skills` — sources conflict); whether Claude Code reads `.agents/skills` (safe route: copy or symlink into `.claude/skills`); MCP config and subagent docs for the three agents were not fetched.

## Caveat
Instruction files are advisory context, not enforcement. Enforce rules with CI, tests and human review of Git diffs, and run agents in isolated workspaces with explicit asset directories (not the whole filesystem).

## No extra framework
No evidence was found that an additional orchestration framework is needed; a task runner (Makefile/`just`) plus AGENTS.md is the proposed baseline (`unverified`, to be tested in an authorized experiment).

## Platform status recording
See [[game-studio-platform-portability-matrix]] for how to record per-platform support with result records.

## See also
- [[game-studio-multiagent-topology]] — role topology (reference study)
- [[game-studio-path-scoped-safety]] — advisory vs enforced controls
- [[game-studio-skills-architecture]] — skill/adapter/standard split
- [[gs-adr-no-extra-orchestration-framework]] — decision derived from this

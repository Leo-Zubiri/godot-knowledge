---
id: src-gs-agent-instructions-portability
type: source
domain: agent-ops
source:
  url: "https://agentskills.io/specification"
  urls:
    - "https://agentskills.io/specification"
    - "https://code.claude.com/docs/en/memory"
    - "https://code.claude.com/docs/en/skills"
    - "https://docs.opencode.ai/docs/rules/"
    - "https://docs.opencode.ai/docs/skills/"
    - "https://learn.chatgpt.com/docs/agent-configuration/agents-md"
  title: "Agent instruction/skill portability: Agent Skills spec, Claude Code, OpenCode, Codex AGENTS.md"
  retrieved: 2026-11-08
  version: "docs as of 2026-11-08"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- Agent Skills spec: frontmatter required `name` (≤64 chars, matches directory) and `description` (≤1024); optional `license`, `compatibility`, `metadata`, `allowed-tools` (experimental). Claude Code docs: a skill using only these fields works unchanged.
- Claude Code: CLAUDE.md; can read AGENTS.md; `@AGENTS.md` import; skills in `.claude/skills/<name>/SKILL.md`; extensions (`context: fork`, `hooks`, `paths`) are Claude-specific. Instructions are context, not enforced.
- Codex: AGENTS.md walked from git root down, `AGENTS.override.md` first, 32 KiB default cap. Skill location conflicting across sources (`.agents/skills` vs `.codex/skills`) — `unverified`. Codex extras in `agents/openai.yaml`. The learn.chatgpt.com URL is a redirect target, not independently verified.
- OpenCode: AGENTS.md first, CLAUDE.md fallback; skills in `.opencode/skills`, `.claude/skills`, `.agents/skills`.
- Not fetched: MCP config and subagent docs for all three (`unverified`). Whether Claude Code reads `.agents/skills`: `unverified`.

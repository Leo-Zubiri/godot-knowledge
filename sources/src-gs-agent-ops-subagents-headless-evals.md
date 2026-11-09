---
id: src-gs-agent-ops-subagents-headless-evals
type: source
domain: agent-ops
source:
  url: "https://code.claude.com/docs/en/sub-agents"
  urls:
    - "https://code.claude.com/docs/en/sub-agents"
    - "https://code.claude.com/docs/en/model-config"
    - "https://code.claude.com/docs/en/headless"
    - "https://code.claude.com/docs/en/memory"
    - "https://opencode.ai/docs/agents/"
    - "https://opencode.ai/docs/mcp-servers/"
    - "https://opencode.ai/docs/plugins/"
    - "https://www.anthropic.com/engineering/writing-tools-for-agents"
    - "https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents"
    - "https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents"
  title: "Claude Code subagents, model configuration, headless mode and memory; OpenCode agents, MCP and plugins; Anthropic engineering posts on tools, evals and context"
  retrieved: 2026-11-08
  version: "as written on 2026-11-08; some pages read to ~100k characters"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** pages fetched on 2026-11-08 by research subagents and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**; PDFs marked 'read by the main agent' were read from downloaded page images. Fees, defaults and policies are recorded only as written on that date; UNV/unverified items were not read on an official page (404, blocked, snippet-only). Godot page versions: 'header not reported' means the fetch tool did not show the version (the URL is the `stable` path). Not legal advice. Re-fetch before promoting dependent notes to `verified`.

- **Claude Code subagents (read ~100k of 117k chars):** each runs in its own context window and only a summary returns; a non-fork subagent does not see the conversation history — it gets its system prompt, the delegation message, CLAUDE.md and a git status snapshot (Explore and Plan skip CLAUDE.md and git status); `tools` allowlist or `disallowedTools`; model order — per-invocation parameter, frontmatter, `CLAUDE_CODE_SUBAGENT_MODEL`, main model; if the main session is in bypassPermissions, acceptEdits or auto mode, subagents ignore their own `permissionMode`; limits 20 concurrent, nesting depth 3 by default (configurable), no cap on total per session; definition scopes managed, `--agents`, `.claude/agents/`, `~/.claude/agents/`, plugin.
- **Claude Code model configuration (~100k of 132k):** aliases (`opus`, `sonnet`, `haiku`, `fable`) track the latest version and resolve differently per provider (e.g. on Foundry `opus` is Opus 4.6 and `sonnet` Sonnet 4.5 per the page); pinned IDs such as `claude-opus-5-5` select a fixed version; precedence `/model`, `--model`, `ANTHROPIC_MODEL`, settings `model`, `ANTHROPIC_DEFAULT_MODEL`; `ANTHROPIC_DEFAULT_*_MODEL` pins what an alias resolves to; `--resume` keeps the transcript's model unless overridden; effort levels low to max, default medium for Opus 5.5, Sonnet 5.5, Haiku 5.5.
- **Claude Code headless:** `claude -p`, exit code 0 or non-zero; **`--bare` skips hooks, skills, subagents, plugins, MCP servers, auto memory and CLAUDE.md**, recommended for CI and "will become the default for `-p` in a future release"; **without `--bare`, `-p` runs project hooks and connects `.mcp.json` servers with no trust dialog**; since v2.1.302 `-p` starts in Manual mode when nothing sets a mode; `--output-format json|stream-json`, `--json-schema`; `total_cost_usd` is a client-side estimate that can differ from the bill; `--max-budget-usd` caps spend; `--permission-prompts none` (v2.1.259+) denies anything that would prompt; SIGTERM exits 143 leaving the turn unfinished; `system/init` reports `mcp_servers` and `mcp_server_errors` and a skipped MCP config entry does not fail the run (CI should check the field). **Memory:** CLAUDE.md is context, not enforced configuration ("to block an action regardless of what Claude decides, use a PreToolUse hook"); Claude can read AGENTS.md in place of CLAUDE.md; auto memory loads the first 200 lines or 25 KB. Settings reference not read.
- **OpenCode (agents, MCP, plugins):** agent Markdown files in `~/.config/opencode/agents/` or `.opencode/agents/` with `description`, `mode` (primary/subagent/all), `model`, permissions; subagents start with fresh context; the `general` subagent cannot launch more subagents; a subagent without a model inherits the parent's; `steps` caps model steps; `hidden` controls visibility, not security. MCP: local servers over stdio, remote over Streamable HTTP; OAuth on by default for remote servers; tools can be denied with permission rules like `<server>_*`; a project config with the same server name replaces the whole server object. Plugins: `plugins` array (npm, local directory, objects); exact npm versions and full Git commit hashes stay fixed; unpinned plugins are checked for updates but not replaced automatically; built-in policy plugins ignore removal attempts; hook event list not on the page. OpenAI Codex config/skills/OTel docs: URLs tried returned 404 or only third-party pages — not used as evidence (UNV).
- **Anthropic engineering posts (read):** *Writing tools for agents* — prototype first, evaluate with realistic multi-call tasks with verifiable outcomes, track accuracy, runtime, tool calls, tokens and errors, analyse transcripts, hold out tests; few high-impact tools, clear namespacing, high-signal returns, token efficiency (pagination, truncation), unambiguous parameter names. *Demystifying evals for AI agents* — combine code, model and human graders; grade outcomes rather than paths; calibrate LLM judges and let them say "Unknown"; you cannot tell whether graders work without reading transcripts; nondeterminism measured with pass@k (at least one of k succeeds) and pass^k (all k succeed), e.g. 75% per-trial success gives about 42% for three of three. *Effective context engineering* — compaction (keep decisions and unresolved bugs, drop redundant tool outputs), structured note-taking (NOTES.md/to-do), subagents returning condensed summaries (often 1,000–2,000 tokens as written).

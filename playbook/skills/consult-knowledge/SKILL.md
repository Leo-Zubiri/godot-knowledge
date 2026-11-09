---
name: consult-knowledge
description: Retrieve generic Godot and game-studio knowledge from the godot-knowledge base with minimal tokens (Obsidian MCP search first, read 1-3 notes, rg fallback) and decide whether a gap exists. Use before any non-trivial Godot decision or when a note id is needed for a citation.
---

# Consult the knowledge base

Base path: `$GODOT_KNOWLEDGE_PATH` (from the game's `.env`/`AGENTS.md`). Retrieval protocol in detail:
`$GODOT_KNOWLEDGE_PATH/meta/workflows/retrieval.md`.

1. **Terms.** 2–3 English terms (ids, tags and summaries are English), e.g. `touch`, `VirtualJoystick`.
2. **Search by MCP** `obsidian`: `search_simple` (`query`, `contextLength` ≈ 120); to filter, `search_query`
   with JsonLogic over `frontmatter.domain|type|status` or `tags`. Results are capped — that is the token saving.
3. **Read 1–3 notes** with `vault_read` (`notes/<id>.md`): `summary:` and frontmatter first; the body only if it
   answers the question. Follow `related:` for at most one hop.
4. **Trust.** `verified` > `reviewed` > `proposed` > `unreviewed`; state the status when citing. `sources:` refs
   are evidence; `inbox/` is never citable.
5. **Cite** the note id in reasoning, ADRs and commit messages.
6. **Fallback without MCP** (Obsidian closed): `rg -l -i "<term>" $GODOT_KNOWLEDGE_PATH/notes/` then
   `sed -n '1,40p'` for frontmatter + summary. Say that MCP was unavailable.
7. **Stop rule.** Two searches with different terms and nothing sufficient → declare a gap: if generic, run
   `write-back-knowledge`; if project-specific, answer from bounded research and record it in the game's docs.

Never use MCP write tools. Never load the whole vault. Never cite what you did not open.

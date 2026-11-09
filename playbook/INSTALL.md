# Connect a game project to this knowledge base (one command, once per project)

```bash
bash <this-repo>/playbook/setup.sh project <game-dir> --claude      # add --codex if the team uses Codex
bash <this-repo>/playbook/setup.sh check   <game-dir>
```

Then **commit the generated files in the game repo**. That is the whole setup: teammates only clone the game and
this repository (side by side as `../godot-knowledge`, or anywhere plus `GODOT_KNOWLEDGE_PATH=…` in a gitignored
`.env`). No per-machine install, no symlinks, nothing in `~/.claude`.

What the script writes (only files that do not exist yet; plain text, no absolute paths):
- `AGENTS.md` pointer (≤ 10 lines) → "read `playbook/PLAYBOOK.md` in the knowledge base first"; `CLAUDE.md` =
  `@AGENTS.md`; `.gemini/settings.json` pointing Gemini CLI at `AGENTS.md`; `.env.example`; `.gitignore` += `.env`.
- `docs/project-profile.md` from `playbook/templates/project-profile.md` (Godot fields), `docs/README.md`,
  `docs/plans/`.
- `--claude`: `.claude/skills/<x>/SKILL.md` pointer skills (Claude Code and OpenCode trigger them); `--codex`:
  `.agents/skills/<x>/SKILL.md`. Each pointer only says "read and follow
  `$GODOT_KNOWLEDGE_PATH/playbook/skills/<x>/SKILL.md`". Agents without skill discovery follow `AGENTS.md` →
  `PLAYBOOK.md` → `SKILL.md` as prose.
- `--mcp`: copies `.mcp.json.example` (optional read-only Obsidian MCP; key stays out of git — `meta/mcp-setup.md`).

Generic mechanism and agent matrix: the template's `playbook/README.md` (copied here). Decision:
`notes/gs-adr-playbook-layer.md`.

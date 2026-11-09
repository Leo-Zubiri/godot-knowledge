# Install the studio layer for Claude Code (one command, once per machine)

```bash
bash ~/Documents/GODOT/godot-knowledge/studio/install.sh          # install or update (idempotent)
bash ~/Documents/GODOT/godot-knowledge/studio/install.sh --check  # show status, change nothing
bash ~/Documents/GODOT/godot-knowledge/studio/install.sh --uninstall
```

Requirements: `bash`, `python3` (for the JSON merge), and optionally the `claude` CLI on `PATH` for the MCP step.
The Obsidian key is read from `OBSIDIAN_API_KEY` in your environment or from this repo's
`.claude/settings.local.json`; without it the MCP step is skipped and everything else still installs.

Then open Claude Code inside any repo that has a `project.godot` and check `/skills` (7), `/agents` (4) and `/mcp`
(`obsidian`, read tools only). If `/agents` does not list the roles, re-run with `STUDIO_COPY_AGENTS=1` (agent
symlinks are not documented by Claude Code; copies always work — re-run the script after editing an agent).

Everything lands under `~/.claude/`; no file is added to any game repo. Game repos only need the contract in
[`README.md`](README.md) (a ≤ 10-line `AGENTS.md` + `docs/project-profile.md`).

## What the script does (so you can audit it)
1. Symlinks `studio/skills/*` → `~/.claude/skills/<name>` (documented: a personal skill entry may be a symlink).
2. Symlinks (or copies) `studio/agents/*.md` → `~/.claude/agents/`.
3. Writes `~/.claude/rules/godot-studio.md` with `@<brain>/studio/PLAYBOOK.md` — user-scope rules load in every
   project without the approval dialog that a project-level import of an external path would trigger.
4. `claude mcp add --scope user obsidian http://127.0.0.1:27123/mcp/` with the bearer key (Obsidian must be open with
   the *Local REST API with MCP* plugin ≥ 5.5.2).
5. Merges read-only allow / write deny rules for `mcp__obsidian__*` into `~/.claude/settings.json` (backup
   `settings.json.bak`).

## Other agents (Codex, OpenCode)
No install needed: the game's `AGENTS.md` says "read `$GODOT_KNOWLEDGE_PATH/studio/PLAYBOOK.md`". If an agent has a
documented skills path, symlink `studio/skills/*` there (see `../meta/interoperability.md`).

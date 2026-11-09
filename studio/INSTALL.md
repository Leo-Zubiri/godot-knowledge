# Install the studio layer for Claude Code (user level, once per machine)

Goal: every project on this machine gets the skills, agents, playbook and the read-only Obsidian MCP **without
adding files to the project**. Mechanisms below are documented by Claude Code (skills symlinks, `~/.claude/rules/`
imports, user-scope MCP, user settings); agent symlinks are **not documented** — see step 2.

Set the checkout path once:
```bash
export BRAIN="$HOME/Documents/GODOT/godot-knowledge"
```

## 1. Skills (documented: a personal skill entry may be a symlink)
```bash
mkdir -p ~/.claude/skills
for s in scope-game plan-phase tune-config package-module consult-knowledge write-back-knowledge review-acceptance; do
  ln -sfn "$BRAIN/studio/skills/$s" ~/.claude/skills/$s
done
```

## 2. Agents (symlinks not documented — verify with `/agents`; fall back to copies)
```bash
mkdir -p ~/.claude/agents
for a in studio-planner godot-engineer godot-qa knowledge-librarian; do
  ln -sfn "$BRAIN/studio/agents/$a.md" ~/.claude/agents/$a.md
done
# if /agents does not list them: cp instead of ln, and re-copy after editing the brain.
```

## 3. Playbook as a user rule (loads in every project, no approval dialog)
```bash
mkdir -p ~/.claude/rules
cat > ~/.claude/rules/godot-studio.md <<'EOF'
# Godot studio (applies only when the working directory contains a `project.godot`)
@~/Documents/GODOT/godot-knowledge/studio/PLAYBOOK.md
EOF
```
Why not a project `CLAUDE.md` import: an `@` import that resolves outside the repo triggers a per-project approval
dialog; user-scope rules do not.

## 4. Obsidian MCP at user scope (read-only)
Obsidian must be open with the *Local REST API with MCP* plugin (≥ 5.5.2); put the key in your shell profile as
`OBSIDIAN_API_KEY`.
```bash
claude mcp add --transport http --scope user obsidian "http://127.0.0.1:27123/mcp/" \
  --header "Authorization: Bearer ${OBSIDIAN_API_KEY}"
```
Then in `~/.claude/settings.json` (merge; do not replace other keys):
```json
{
  "permissions": {
    "allow": ["mcp__obsidian__vault_read", "mcp__obsidian__vault_list", "mcp__obsidian__vault_get_document_map",
              "mcp__obsidian__search_simple", "mcp__obsidian__search_query", "mcp__obsidian__tag_list"],
    "deny":  ["mcp__obsidian__vault_write", "mcp__obsidian__vault_append", "mcp__obsidian__vault_patch",
              "mcp__obsidian__vault_move", "mcp__obsidian__vault_copy", "mcp__obsidian__vault_delete",
              "mcp__obsidian__command_execute", "mcp__obsidian__command_list"]
  }
}
```

## 5. Verify (inside any game repo)
`/skills` lists the seven skills · `/agents` lists the four roles · `/mcp` shows `obsidian` with read tools only ·
ask "which skill would you use to add a feature?" → `scope-game` (feature variant).

## Uninstall
Remove the symlinks, `~/.claude/rules/godot-studio.md`, and `claude mcp remove --scope user obsidian`.

## Other agents (Codex, OpenCode)
No discovery needed: their `AGENTS.md` in the game says "read `$GODOT_KNOWLEDGE_PATH/studio/PLAYBOOK.md`". Skill
discovery paths differ per agent (see `../meta/interoperability.md`); symlink `studio/skills/*` into the path each
agent documents, if any.

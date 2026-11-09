#!/usr/bin/env bash
# studio/install.sh — one-command, idempotent user-level install of the studio layer for Claude Code.
#
#   bash studio/install.sh            install / update (safe to re-run)
#   bash studio/install.sh --check    show what is installed, change nothing
#   bash studio/install.sh --uninstall
#
# What it does (all under ~/.claude, nothing inside any game repo):
#   1. symlinks studio/skills/*  -> ~/.claude/skills/<name>      (documented by Claude Code)
#   2. symlinks studio/agents/*  -> ~/.claude/agents/<name>.md   (symlinks undocumented: --check tells you if they load)
#   3. writes  ~/.claude/rules/godot-studio.md  importing studio/PLAYBOOK.md (loads in every project, no dialog)
#   4. registers the read-only Obsidian MCP at user scope (if `claude` is on PATH and a key is found)
#   5. merges read-only allow/deny rules for that MCP into ~/.claude/settings.json (backup kept)
set -euo pipefail

BRAIN="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
SKILLS=(scope-game plan-phase tune-config package-module consult-knowledge write-back-knowledge review-acceptance)
AGENTS=(studio-planner godot-engineer godot-qa knowledge-librarian)
RULE="$CLAUDE_DIR/rules/godot-studio.md"
MCP_URL="${OBSIDIAN_MCP_URL:-http://127.0.0.1:27123/mcp/}"
ALLOW=(vault_read vault_list vault_get_document_map search_simple search_query tag_list)
DENY=(vault_write vault_append vault_patch vault_move vault_copy vault_delete command_execute command_list)

say()  { printf '%s\n' "$*"; }
ok()   { printf '  \033[32m✔\033[0m %s\n' "$*"; }
warn() { printf '  \033[33m!\033[0m %s\n' "$*"; }

find_key() {
  if [ -n "${OBSIDIAN_API_KEY:-}" ]; then printf '%s' "$OBSIDIAN_API_KEY"; return; fi
  local f="$BRAIN/.claude/settings.local.json"
  [ -f "$f" ] && python3 -c "import json,sys;print(json.load(open(sys.argv[1])).get('env',{}).get('OBSIDIAN_API_KEY',''))" "$f" 2>/dev/null || true
}

merge_permissions() {  # $1 = add|remove
  python3 - "$CLAUDE_DIR/settings.json" "$1" "${ALLOW[*]}" "${DENY[*]}" <<'PY'
import json, pathlib, shutil, sys
p, mode, allow, deny = pathlib.Path(sys.argv[1]), sys.argv[2], sys.argv[3].split(), sys.argv[4].split()
allow = [f"mcp__obsidian__{t}" for t in allow]; deny = [f"mcp__obsidian__{t}" for t in deny]
d = json.loads(p.read_text()) if p.exists() else {}
if p.exists(): shutil.copy2(p, str(p) + ".bak")
perms = d.setdefault("permissions", {})
for key, vals in (("allow", allow), ("deny", deny)):
    cur = perms.get(key, [])
    perms[key] = sorted(set(cur) | set(vals)) if mode == "add" else [v for v in cur if v not in vals]
p.parent.mkdir(parents=True, exist_ok=True)
p.write_text(json.dumps(d, indent=2, ensure_ascii=False) + "\n")
PY
}

check() {
  say "studio layer — status (brain: $BRAIN)"
  for s in "${SKILLS[@]}"; do
    if [ -L "$CLAUDE_DIR/skills/$s" ] && [ -f "$CLAUDE_DIR/skills/$s/SKILL.md" ]; then ok "skill $s"; else warn "skill $s missing"; fi
  done
  for a in "${AGENTS[@]}"; do
    if [ -e "$CLAUDE_DIR/agents/$a.md" ]; then ok "agent $a$( [ -L "$CLAUDE_DIR/agents/$a.md" ] && echo ' (symlink — confirm it shows in /agents; else re-run with STUDIO_COPY_AGENTS=1)')"; else warn "agent $a missing"; fi
  done
  if [ -f "$RULE" ]; then ok "rule $RULE"; else warn "rule missing: $RULE"; fi
  if command -v claude >/dev/null 2>&1; then
    if claude mcp get obsidian >/dev/null 2>&1; then ok "mcp obsidian registered"; else warn "mcp obsidian not registered"; fi
  else warn "claude CLI not on PATH — MCP step skipped"; fi
  if [ -f "$CLAUDE_DIR/settings.json" ] && grep -q 'mcp__obsidian__vault_read' "$CLAUDE_DIR/settings.json"; then ok "read-only MCP permissions in settings.json"; else warn "MCP permissions not in settings.json"; fi
  say "verify inside a game repo: /skills (7), /agents (4), /mcp (obsidian, read tools only)"
}

install() {
  say "installing studio layer from $BRAIN into $CLAUDE_DIR"
  mkdir -p "$CLAUDE_DIR/skills" "$CLAUDE_DIR/agents" "$CLAUDE_DIR/rules"
  for s in "${SKILLS[@]}"; do ln -sfn "$BRAIN/studio/skills/$s" "$CLAUDE_DIR/skills/$s"; ok "skill $s"; done
  for a in "${AGENTS[@]}"; do
    if [ "${STUDIO_COPY_AGENTS:-0}" = "1" ]; then rm -f "$CLAUDE_DIR/agents/$a.md"; cp "$BRAIN/studio/agents/$a.md" "$CLAUDE_DIR/agents/$a.md"; ok "agent $a (copied)"
    else ln -sfn "$BRAIN/studio/agents/$a.md" "$CLAUDE_DIR/agents/$a.md"; ok "agent $a (symlink)"; fi
  done
  printf '# Godot studio (applies only when the working directory contains a project.godot)\n@%s/studio/PLAYBOOK.md\n' "$BRAIN" > "$RULE"; ok "rule $RULE"
  if command -v claude >/dev/null 2>&1; then
    key="$(find_key)"
    if [ -n "$key" ]; then
      claude mcp remove --scope user obsidian >/dev/null 2>&1 || true
      claude mcp add --transport http --scope user obsidian "$MCP_URL" --header "Authorization: Bearer $key" >/dev/null && ok "mcp obsidian (user scope, $MCP_URL)"
      merge_permissions add && ok "read-only MCP permissions merged into settings.json (backup: settings.json.bak)"
    else warn "no OBSIDIAN_API_KEY (env or $BRAIN/.claude/settings.local.json) — MCP step skipped; re-run after exporting it"; fi
  else warn "claude CLI not on PATH — MCP step skipped"; fi
  say "done. Open Claude Code inside any repo with a project.godot and run /skills, /agents, /mcp."
}

uninstall() {
  say "removing studio layer from $CLAUDE_DIR"
  for s in "${SKILLS[@]}"; do rm -f "$CLAUDE_DIR/skills/$s"; done
  for a in "${AGENTS[@]}"; do rm -f "$CLAUDE_DIR/agents/$a.md"; done
  rm -f "$RULE"
  if command -v claude >/dev/null 2>&1; then claude mcp remove --scope user obsidian >/dev/null 2>&1 || true; merge_permissions remove || true; fi
  ok "removed (settings.json backup kept as settings.json.bak)"
}

case "${1:-}" in
  --check) check ;;
  --uninstall) uninstall ;;
  ""|--install) install ;;
  *) say "usage: $0 [--install|--check|--uninstall]"; exit 2 ;;
esac

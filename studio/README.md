# studio/ — the knowledge base acting on a game

`notes/` holds **declarative** knowledge. `studio/` holds the small **procedural** layer that lets an agent *use* that
knowledge on any game project with near-zero per-project setup: a playbook, generic conventions, portable role
specs, Claude Code adapters (agents + skills), checklists and templates. Decision and limits:
[`../notes/gs-adr-studio-layer.md`](../notes/gs-adr-studio-layer.md).

## Rules that keep this from becoming a framework
- **≤ 7 skills, ≤ 4 agents.** Add one only when a recorded failure shows it is missing.
- Skills use standard frontmatter only (`name`, `description`), **no scripts, no hooks**, ≤ 3 KB each.
- Skills and checklists **point to notes by id**; they never restate knowledge.
- Nothing here names a specific game. Project facts live in the game repo (`docs/project-profile.md`).
- The filesystem floor still holds: any agent that can read files can follow `PLAYBOOK.md` without Claude-specific
  discovery.

## Layout
| Path | Purpose |
|---|---|
| [`PLAYBOOK.md`](PLAYBOOK.md) | entry point when acting on a game: read profile → pick skill → cite notes → write only project facts into the game |
| [`INSTALL.md`](INSTALL.md) | one-time user-level install for Claude Code (symlinks, rules file, user-scope MCP) |
| [`conventions.md`](conventions.md) | generic GDScript / architecture / git / safety conventions |
| [`roles.md`](roles.md) | portable role spec (planner, engineer, qa, librarian) |
| `agents/` | Claude Code subagent adapters of the roles |
| `skills/` | `scope-game`, `plan-phase`, `tune-config`, `package-module`, `consult-knowledge`, `write-back-knowledge`, `review-acceptance` |
| `checklists/` | plan-review, phase-exit, input-mapping, purchase-integrity, module-extraction |
| `templates/` | project-profile, plan, phase, adr, active |

## Game-side contract (what the skills expect to find)
```
AGENTS.md                 ≤ 10 lines: engine, GODOT_KNOWLEDGE_PATH, "read studio/PLAYBOOK.md", profile path, make targets, git policy
CLAUDE.md                 @AGENTS.md
.env                      GODOT_BIN, GODOT_KNOWLEDGE_PATH (gitignored)
docs/project-profile.md   YAML frontmatter per templates/project-profile.md (declares plans_dir, active_plan, adr_dir)
docs/plans/YYYY-MM-DD_<slug>/   one folder per initiative, from templates/plan.md
active.md                 optional session checkpoint (templates/active.md)
```

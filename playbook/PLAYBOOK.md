# Playbook — how an agent acts on a Godot game using this knowledge base

Applies when the working directory contains a `project.godot`. Everything generic lives here and in `notes/`; the
game repo keeps only its own facts, decisions and plans. Never write project specifics into the knowledge base.

## 1. Start of session
1. Read the game's `AGENTS.md` (≤ 10 lines) and `docs/project-profile.md` (YAML). If the profile is missing →
   run skill `scope-game` before anything else.
2. Read `active.md` if present (checkpoint) and the active plan's current phase
   (`<plans_dir>/<active_plan>/`).
3. Load knowledge by profile: open `notes/godot-index.md` and the domain indexes the profile points to; read
   `summary` + frontmatter first; full body only for the 1–3 notes the task needs (skill `consult-knowledge`).

## 2. Pick the procedure
| User intent | Skill | Output in the game repo |
|---|---|---|
| "make a game of X", "add feature Y", "re-scope" | `scope-game` | `docs/project-profile.md`, open questions with `ASSUMED:` defaults, ADR stubs |
| "plan", "roadmap", "what next" | `plan-phase` | `docs/plans/<date>_<slug>/plan.md` + `phase-NN.md` from templates |
| any number/threshold in code | `tune-config` | a tunable Resource, no magic numbers |
| "reuse this in another game", 2nd consumer appears | `package-module` | `addons/<prefix>_<name>/` extracted |
| before any non-trivial Godot decision | `consult-knowledge` | cited note ids |
| knowledge gap found (generic) | `write-back-knowledge` | `sources/` + `notes/` (`proposed`) in this repo |
| "review", "is the phase done?" | `review-acceptance` | verdict against `checklists/` |

## 3. Rules while working (details: `conventions.md`)
- Cite note ids in reasoning, ADRs and commit messages; prefer `verified` > `reviewed` > `proposed`; say the status.
- Questions: ask the ≤ 5 highest-leverage ones with structured options and a recommended default; assume the rest
  and list them as `ASSUMED:`; never block on a question you can default safely.
- Before presenting a plan, run the self-check in `checklists/plan-review.md` and show the critique.
- Config-driven, modules extractable on the second use, i18n keys from day one, static typing, tests per module.
- Git: follow the game's `AGENTS.md` policy; commit small; never force-push.

## 4. Knowledge base access
- **Read:** MCP `obsidian` (`search_simple` / `search_query` → `vault_read` of 1–3 notes) when Obsidian is open;
  otherwise `rg` over `$GODOT_KNOWLEDGE_PATH/notes/`. Never load the whole vault. Never use MCP write tools.
- **Write (owner exception recorded in `AGENTS.md`):** generic gaps go through `meta/workflows/intake.md` as
  `sources/` + `notes/` with `status: proposed` (or `unreviewed` + evidence class *interpretation* for own
  patterns), committed directly on local `main`, one commit per note, message `knowledge(<domain>): …`. Never
  `verified`. Never `push` unless told. `grep -ri "<game name>"` in the new files must return nothing.
- If the knowledge base is unreachable: say so, do bounded research, continue.

## 5. End of session
Update `active.md` (≤ 25 lines), tick the phase checklist, record decisions as ADRs (`templates/adr.md`), and
list any generic finding not yet written back.

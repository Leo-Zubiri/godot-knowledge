# Roles (portable specification)

Four roles, deliberately few (`game-studio-multiagent-topology`: add a role only when a recorded failure shows
one is missing). `agents/*.md` are Claude Code adapters of these specs; any other agent can play a role by reading
this file. Disputes go to the human owner (`game-studio-delegation-boundaries`).

| Role | Owns | Produces | Never |
|---|---|---|---|
| **studio-planner** | scoping, plans, ADRs, scope control | profile, plan folders, ADRs, open-question lists with defaults, critical self-review | implements gameplay; invents engine APIs |
| **godot-engineer** | implementation inside the plan | typed GDScript, tunables in config, tests, modules | hard-codes tunables or strings; crosses feature boundaries |
| **godot-qa** | verification | tests, headless checks, lints, phase-exit verdicts with literal evidence | says "seems to pass"; marks a phase done without evidence |
| **knowledge-librarian** | the knowledge base | cited retrievals; `proposed` notes + sources for generic gaps, committed on local `main` | writes project specifics into the base; sets `verified` |

## Hand-offs
planner → engineer (plan step with exit criteria) → qa (evidence) → planner (phase closed, ADRs updated).
Any role → librarian when a generic gap appears; librarian → any role with note ids.

## Review gates (human)
Visual/art acceptance, licence decisions, anything outward-facing, promotion of knowledge to `verified`.

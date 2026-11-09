---
id: gs-adr-studio-layer
type: decision
domain: agent-ops
status: superseded
summary: "Proposed: the knowledge base ships a small procedural layer (playbook/: playbook, conventions, roles, ≤4 agents, ≤7 skills, checklists, templates) so an agent can act on any game with near-zero per-project setup, capped to avoid becoming a framework."
tags: [dept/orchestration]
sources:
  - claim: "Claude Code discovers personal skills in ~/.claude/skills and a skill entry may be a symlink; user-scope rules load in every project; additional directories grant file access but load no skills"
    url: https://code.claude.com/docs/en/skills
    retrieved: 2026-11-08
  - claim: "User-scope CLAUDE.md and ~/.claude/rules load without the external-import approval dialog; imports up to 4 hops"
    url: https://code.claude.com/docs/en/memory
    retrieved: 2026-11-08
  - claim: "Subagents are discovered in ~/.claude/agents (user level); symlinks there are not documented"
    url: https://code.claude.com/docs/en/sub-agents
    retrieved: 2026-11-08
  - claim: "Agent Skills are an open spec; this template did not ship skills"
    ref: src-gs-agent-instructions-portability
    retrieved: 2026-11-08
related:
  - superseded-by: "[[gs-adr-playbook-layer]]"   # project-level, agent-agnostic bootstrap replaces user-level install
  - relates-to: "[[gs-adr-no-extra-orchestration-framework]]"   # the cap that keeps playbook/ from becoming a framework
  - relates-to: "[[game-studio-skills-architecture]]"   # skill layering this layer follows
  - relates-to: "[[game-studio-multiagent-topology]]"   # ≤4 roles rule
  - relates-to: "[[game-studio-game-project-profile]]"   # the game-side contract file
  - relates-to: "[[game-studio-agent-orchestration]]"   # AGENTS.md single source; CLAUDE.md imports
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** Claude Code mechanics read on the cited pages on 2026-11-08 (paraphrased by a research
> agent); the design itself is an owner decision, not a validated practice. Status `proposed`.

## Context
Knowledge in `notes/` is declarative. Acting on a game (asking scoping questions, planning phases, enforcing
conventions, reviewing) needed procedures and roles, which were being re-created inside each game repo (agents,
skills, long instruction files) — the opposite of a self-sufficient knowledge base. `meta/interoperability.md`
stated the template ships no `skills/` directory, so adding one must be an explicit decision.

## Decision
Add an optional top-level `playbook/` layer: `PLAYBOOK.md` (entry point), `conventions.md`, `roles.md`,
`agents/` (Claude adapters, ≤ 4), `skills/` (standard `SKILL.md`, ≤ 7, ≤ 3 KB, no scripts or hooks, pointing to
notes by id), `checklists/`, `templates/`, `INSTALL.md`. Distribution to Claude Code is **user-level**: symlinks
of skills (documented), symlinks or copies of agents (symlinks unverified), a `~/.claude/rules/` file importing
the playbook, and a user-scope read-only MCP for the vault. A game repo keeps only a ≤ 10-line `AGENTS.md`,
`docs/project-profile.md` (YAML contract), dated plan folders and ADRs. Other agents follow the playbook by
reading it (filesystem floor). Owner exception recorded in `AGENTS.md`: from the owner's local projects an agent
may commit knowledge directly on local `main`; `verified` remains human-only.

## Consequences
+ A new game needs no copied agents/skills; conventions evolve in one place; token cost bounded by short skill
  descriptions and a short playbook.
− `playbook/` is a mini-framework by stealth: the caps above are the guard; a plugin packaging is deferred until
  symlinks show a measured failure; symlinked agents must be tested; global skills appear in non-game sessions
  (descriptions state the `project.godot` condition). Token cost is not measured yet.

## See also
- `[[gs-adr-playbook-layer]]` — supersedes this decision
- `[[gs-adr-no-extra-orchestration-framework]]` — why the layer is capped
- `[[game-studio-skills-architecture]]` — skills vs tool adapters vs standards
- `[[game-studio-game-project-profile]]` — what the game must expose
- `[[game-studio-multiagent-topology]]` — the ≤ 4 roles rule
- `[[game-studio-agent-orchestration]]` — AGENTS.md as single source; CLAUDE.md imports

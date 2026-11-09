---
id: gs-adr-playbook-layer
type: decision
domain: agent-ops
status: proposed
summary: "Proposed: the procedural layer lives in playbook/ as defined by the Knowledge Repository Template 1.1.0 — generic, agent-agnostic, bootstrapped INTO each consumer project as committed pointer files (no per-machine install, no symlinks); this repo only adds domain skills, checklists and profile fields."
tags: [dept/orchestration]
sources:
  - claim: "The template defines playbook/ (caps, consumer contract, committed pointer skills, agent matrix) and setup.sh; symlinks are rejected for portability; AGENTS.md is the canonical pointer read natively by Codex/OpenCode, via import by Claude Code, via config by Gemini CLI"
    url: https://github.com/Leo-Zubiri/knowledge-wiki-template
    retrieved: 2026-11-08
  - claim: "Claude Code discovers project skills in .claude/skills and reads CLAUDE.md imports; OpenCode reads .claude/skills; Codex reads .agents/skills"
    ref: src-gs-agent-instructions-portability
    retrieved: 2026-11-08
related:
  - supersedes: "[[gs-adr-studio-layer]]"   # user-level, Claude-only install replaced by project-level, agent-agnostic bootstrap
  - relates-to: "[[gs-adr-no-extra-orchestration-framework]]"   # the caps that keep the layer small
  - relates-to: "[[game-studio-game-project-profile]]"   # the profile contract consumers expose
  - relates-to: "[[game-studio-agent-orchestration]]"   # AGENTS.md single source
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** owner decision taken on 2026-11-08 after a review of the template's interoperability
> doctrine and of Claude Code/Codex/OpenCode discovery paths (cited); the mechanism was exercised on a temporary
> consumer project (bootstrap, idempotent re-run, check, unlink) but not yet on a team with several machines.

## Context
`gs-adr-studio-layer` had put the procedural layer in a Godot-specific `studio/` folder and distributed it with a
**user-level, Claude-only** installer (symlinks into `~/.claude`). Objections: the mechanism is generic to any
knowledge repo built from the template, not to Godot; a per-machine install must be repeated on every clone and
by every teammate; symlinks and `~/.claude` tie it to one product. The template's own doctrine already rejects
committed symlinks and keeps `AGENTS.md` as the single, agent-agnostic pointer.

## Decision
- The layer is the template's **`playbook/`** (template 1.1.0): playbook, roles, ≤ 7 thin skills, checklists,
  templates, and `setup.sh`. This repo keeps the generic files as they are and adds only domain content:
  `conventions.md`, skills `scope-game`, `tune-config`, `package-module`, checklists `input-mapping`,
  `purchase-integrity`, `module-extraction`, a Godot `templates/project-profile.md`, and `setup.conf`
  (`KB_NAME=godot-knowledge`, `KB_ENV_VAR=GODOT_KNOWLEDGE_PATH`, the 7 skills).
- Distribution is **project-level and committed**: `setup.sh project <game-dir> [--claude] [--codex]` writes the
  consumer contract once; teammates only clone both repos (sibling folder default or `.env`). No user-level
  install, no symlinks; `install.sh` is removed.
- Agents without skill discovery follow `AGENTS.md` → `PLAYBOOK.md` → `SKILL.md` as prose; products that discover
  skills get committed pointer files. Claude subagent adapters remain optional.
- Governance for several contributors is the template default (branch + PR); the owner exception for direct
  commits on local `main` stays recorded in `AGENTS.md` for the solo case.

## Consequences
+ Zero per-machine setup; works for any file-reading agent; one source for generic procedures across all domain
  repos; honest agent matrix in `playbook/README.md`.
− Template → derived-repo sync is manual (copy generic files, note the version). Pointer skills must be
  regenerated if a skill is renamed. Token cost of global descriptions is unmeasured.

## See also
- `[[gs-adr-studio-layer]]` — superseded design (user-level, Claude-only)
- `[[gs-adr-no-extra-orchestration-framework]]` — the caps that keep the layer small
- `[[game-studio-game-project-profile]]` — the profile contract consumers expose
- `[[game-studio-agent-orchestration]]` — AGENTS.md single source

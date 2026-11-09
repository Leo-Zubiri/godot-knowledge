---
id: game-studio-game-project-profile
type: guide
domain: agent-ops
status: proposed
summary: "Proposed project profile (genre, 2D/3D, style, platform, multiplayer, scale, tools) that an agent reads first to select which knowledge to load, plus the retrieval layers over existing notes; token savings are not measured."
tags: [dept/orchestration, dept/design]
sources:
  - claim: "Existing progressive disclosure: read summary and frontmatter first, then 1-3 full notes"
    ref: src-gs-godot-3d-import
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-tool-selection-guide]]"   # task routing the profile refines
  - relates-to: "[[game-studio-index]]"   # entry point
  - relates-to: "[[godot-index]]"   # Godot knowledge map
  - relates-to: "[[game-studio-token-efficient-workflows]]"   # loading levers
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research dated 2026-11-08; no experiment was run and nothing is validated in production. Most design-theory sources could only be read as abstracts or summaries (several PDFs were unreadable), so these notes are `proposed` pointers with explicit caveats, not authoritative claims. Workflows described are `designed` only.

**Evidence classes used here:** *verified* = read on the cited page this session; *abstract-only* = abstract or search summary seen, full text not read; *interpretation* = our reasoning; *hypothesis* = untested; *unverified* = not confirmed.


> Design proposal. Token consumption is **not measured**; the repository only has word counts.

## Goal
Let an agent avoid loading unrelated knowledge by reading a short project profile first.

## Retrieval layers (over what already exists — no new document types)
1. **Core (small, usually relevant):** [[godot-index]], [[game-studio-index]], [[godot-version-policy]], [[game-studio-tool-selection-guide]]; read each note's `summary` and frontmatter before the body.
2. **Specialized (load by task):** notes chosen by `domain` and `tags` (`dept/*`, `tool/*`, `scope/*`), then the 1–3 that match.
3. **Reference (on demand):** the sources hub ([[game-studio-sources-index]]), catalogs and matrices ([[game-studio-tool-matrix]], [[game-studio-asset-source-catalog]]).

## Domains to load (routing)
| Domain | Load it when… | Entry |
|---|---|---|
| `godot` | the task touches engine implementation (code, scenes, physics, UI, export…) | [[godot-index]] |
| `game-design` | the task is design, validation with players, accessibility or analysing other games | [[game-design-index]] |
| `game-studio` | the task is tools, pipelines, assets and licences, quality or delivery | [[game-studio-index]] |
| `agent-ops` | agents run the work (permissions, sessions, cost, skills, knowledge-base engineering) | [[agent-ops-index]] |

A pure 2D, single-player, desktop-only project can skip notes tagged `dim/3d`; a project with no agents running unattended can skip most of `agent-ops`. Filtering by `domain` is now meaningful: `rg -l "^domain: game-design" notes/`.

## The profile (kept in the *consuming project's* repo, not here)
| Field | Examples | Used to |
|---|---|---|
| Genre and pillars | platformer, roguelike | choose design notes, conventions |
| Dimension | 2D, 3D, both | include or skip 3D art, rigging, GLB pipeline notes |
| Visual style | pixel art, low-poly, stylised | asset sources and art-direction notes |
| Target platforms | desktop, web, mobile | export, performance, accessibility notes |
| Multiplayer | none, local, online | networking notes (none yet) |
| Narrative / procedural | none, light, heavy | narrative and procedural notes (none yet) |
| Scale and rigor | solo jam, small team | [[game-studio-configurable-rigor]] |
| Available tools and agents | Godot 4.7, Blender 5.2, agent set | tool routing, licences |
| Performance constraints | budgets | acceptance criteria |

## How an agent uses it
1. Read the profile; 2. open the indexes; 3. pick notes by tag/domain that match the profile, skip the rest; 4. consult the catalogs only when a task needs a provider, format or licence; 5. record which notes it used (for later measurement).

## Known limits (measured on this repository)
- Domains were split on 2026-11-08 (`godot` 37 notes, `game-studio` 36, `agent-ops` 32, `game-design` 8); note ids keep their historical prefixes, so the id no longer tells the domain.
- Tags currently skew toward agent-operations meta-knowledge (`scope/reference-study` 20 notes, `dept/orchestration` 19) while art, materials and audio have one note each, so tag filters cannot yet express dimension (2D/3D) or genre.
- A dimension facet (e.g. `dim/2d`, `dim/3d`) would need a vocabulary addition approved in a diff; do not repurpose `applies-to` (it means version applicability).
- The task router is organised by tool, not yet by game question.

## See also
- [[game-studio-tool-selection-guide]] — routing by task
- [[game-studio-token-efficient-workflows]] — loading levers

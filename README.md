# godot-knowledge — a reusable, evidence-based Godot knowledge base

A **file-based, Markdown + YAML + Git** knowledge base about **Godot** (engine architecture, GDScript, scene/node
design, patterns & anti-patterns), readable by both humans and AI agents, where every claim cites a source and nothing
is trusted as `verified` until a human reviews it.

Built from the **[Knowledge Repository Template v1.0.0](https://github.com/Leo-Zubiri/knowledge-wiki-template)** — its
methodology (content classes, provenance, typed relationships, trust lifecycle, filesystem-first retrieval, Git
governance) is preserved unchanged. See [`OVERVIEW.md`](OVERVIEW.md) for the guided tour and [`AGENTS.md`](AGENTS.md) if
you're an agent.

## Scope
- **Domain:** `godot` (frontmatter `domain: godot`).
- **Experimental/validation environment:** pinned to **Godot 4.7.2 (stable)**, **GDScript-first** (C# deferred).
- **Version discipline:** notes may describe other Godot versions but must mark compatibility via `applies-to` and must
  not silently generalize 4.7.2 behavior to all of 4.x — see `notes/godot-version-policy.md`.

## Start here
- **Map of content:** [`notes/godot-index.md`](notes/godot-index.md) — the entry point to the seeded notes.
- **How knowledge is organized & trusted:** [`OVERVIEW.md`](OVERVIEW.md), [`meta/`](meta/).
- **Retrieve / contribute (filesystem-first):** [`meta/workflows/`](meta/workflows/).
- **Let the base act on your games (optional, capped):** [`playbook/README.md`](playbook/README.md) — playbook, roles,
  skills, checklists, templates; connect a game project once with `playbook/setup.sh project <dir>` ([`playbook/INSTALL.md`](playbook/INSTALL.md)).

## Trust status (important)
All claim-bearing seed notes are currently **`proposed`** or **`unreviewed`** — they were drafted by an agent and are
**awaiting human verification**. Agents never set `verified`; promotion happens only through human review in Git (see
[`meta/workflows/git-governance.md`](meta/workflows/git-governance.md)).

## Using this base from a project (read-only)
Another repo (e.g. an experiment lab or a game) can consult this base read-only and stage reusable findings back via the
template's cross-repo pattern — see [`meta/workflows/cross-repo-consumption.md`](meta/workflows/cross-repo-consumption.md).

## License & attribution
MIT — © 2026 Leo Zubiri (see [`LICENSE`](LICENSE)). Derived from the **Knowledge Repository Template v1.0.0**
(`Leo-Zubiri/knowledge-wiki-template`, commit `ef159fa`), which is likewise MIT © 2026 Leo Zubiri.

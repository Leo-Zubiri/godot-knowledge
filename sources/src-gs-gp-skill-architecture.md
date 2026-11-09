---
id: src-gs-gp-skill-architecture
type: source
domain: agent-ops
source:
  url: "https://github.com/jame581/GodotPrompter/blob/master/CONTRIBUTING.md"
  urls:
    - "https://github.com/jame581/GodotPrompter/blob/master/CONTRIBUTING.md"
    - "https://github.com/jame581/GodotPrompter/blob/master/skills/index.json"
    - "https://github.com/jame581/GodotPrompter/blob/master/skills/state-machine/SKILL.md"
    - "https://github.com/jame581/GodotPrompter/blob/master/agents/godot-game-dev.md"
  title: "GodotPrompter skill format, addon policy, index, sample skill and agent"
  retrieved: 2026-11-08
  version: "master@d7b26cd"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** files fetched on 2026-11-08 from the `master` branch (HEAD verified via GitHub API at retrieval: `d7b26cdb5fae14d4ef7b713c5bf259395e75c3c6`, committed 2026-10-24; fetch was by branch name) and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. A *reference architecture* studied for patterns only; nothing copied, not a dependency. Statements are documented (D) or project-reported (P); none tested by us. Re-fetch before promoting dependent notes to `verified`.

- **Skill format (CONTRIBUTING, D):** one kebab-case folder per skill under `skills/` with required `SKILL.md`; frontmatter limited to `name` (must equal folder) and `description` (should start with a "Use when…" trigger); body order: intro, related-skills line (3–5 names, plain names not links), numbered sections, GDScript then C# examples (`gdscript`/`csharp` tags), closing checklist; target Godot 4.3+, avoid deprecated methods. `SKILL.md` hard cap 16 KB (warning near 15.5 KB); deeper material goes to a `references/` subfolder linked from `SKILL.md` (unlinked references are flagged as orphans).
- **Adding a skill (D):** must be wired by hand into README table/counts, the `using-godot-prompter` index skill and its session card (3 KB cap), routing lines in the dev and architect agents plus the relevant specialist, a two-way cross-reference with the closest core skill; then regenerate Codex agent mirrors and the skill index, run validator and tests. Session-card marker strings must not appear in doc examples. (Manual wiring = drift risk; partly guarded by `--check` modes.)
- **Third-party addon skills (D):** header pins addon version and minimum Godot version (may exceed 4.3); research from the pinned release tag's source, not live docs (which often describe unreleased APIs); findings recorded in a dated notes file with a source citation per API fact; C# parity depends on what the addon ships; GDScript-only addons are allowlisted; a single section without C# gets an explicit "not applicable" marker with a **required reason**.
- **Verification expectations (D):** test examples in Godot 4.3+ manually; validator zero errors; `npm test` passes; read each skill as a newcomer.
- **Observed (T via API/raw):** 59 skills = domain skills (2d, 3d, physics, rendering, animation, UI, audio, multiplayer, XR, export, optimization, save-load, state-machine …) + 5 addon skills (beehave, limboai, popochiu, dialogue-manager, phantom-camera) + process skills (brainstorming, grill, mentor, code-review, using-godot-prompter). `skills/index.json` schemaVersion 1 lists 59 skills and 9 agents with name, title, description, relatedSkills, addon, references, source; a minor defect was seen (an `ai-navigation` entry lists limboai/beehave twice). `state-machine` ≈350 lines, roughly half code, frontmatter name+description only.
- **Agents (T/D):** nine — godot-animator, godot-code-reviewer, godot-csharp-engineer, godot-game-architect, godot-game-dev, godot-performance-profiler, godot-shader-author, godot-tools-engineer, godot-ui-designer. Only `godot-game-dev` was read: the general implementer, routes C#-heavy work, animation graphs, Control-tree UI and editor plugins/@tool to specialists; told to read the relevant skill before writing code (thin dispatch shells over skills); `model: inherit`; the other eight not read (unverified). Codex TOML mirrors are generated from the Markdown agents. No evidence found that the nine agents outperform skills plus one implementer.

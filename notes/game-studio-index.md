---
id: game-studio-index
type: index
domain: game-studio
summary: "Map of content for the game-studio domain: agent-driven 2D+3D Godot production architecture, tool evaluations, decisions and workflows."
related:
  - relates-to: "[[godot-index]]"   # parent Godot knowledge map
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Game studio — map of content
Navigational only; no claims. All claim-bearing notes are `proposed` (agent-authored, documentary research dated 2026-11-08, awaiting human verification).

### Browse by tag
Notes carry optional facet tags (controlled vocabulary in [`meta/methodology/tags.md`](../meta/methodology/tags.md)): `dept/*` (department), `tool/*` (tool) and `scope/*` (reference study, licensing). Find notes with `rg -l "^tags:.*dept/qa" notes/`, or colour the Obsidian graph with Groups such as `tag:#dept/qa` (keep the graph's **Tags** toggle off). Tags are a search aid, not evidence.

### Godot engine knowledge
Engine-specific notes (project hygiene, resources, saving, physics, navigation, UI, animation, audio, 2D, VFX, localization, 3D materials, renderers, levels, import) live in the Godot domain: start at [[godot-index]].

### Start here
- [[game-studio-tool-selection-guide]] — **which tool for which task** (agent routing table).
- [[game-studio-architecture-proposal]] — decision document, roadmap, open gaps.
- [[game-studio-readiness-classification]] — how tools are judged.

### Evaluation and risk
- [[game-studio-cost-and-openness-classification]] — free/libre/open-source-first tiers
- [[game-studio-tool-matrix]] · [[game-studio-licensing-risks]] · [[game-studio-hardware-and-cost]] · [[game-studio-artcraft-evaluation]]

### Department architecture
- [[game-studio-agent-orchestration]] · [[game-studio-skills-architecture]]
- [[game-studio-godot-integration]] · [[game-studio-blender-pipeline]] · [[game-studio-level-design]]
- [[game-studio-2d-ui-audio-materials]] · [[game-studio-ai-generation]]

### Reference architecture study (Claude-Code-Game-Studios; patterns only, not a dependency)
- [[game-studio-ccgs-reference-comparison]] — classification of patterns (adopt/adapt/reference-only/reject/unverified)
- [[game-studio-multiagent-topology]] · [[game-studio-delegation-boundaries]] · [[game-studio-configurable-rigor]] · [[game-studio-review-modes-and-verdicts]]
- [[game-studio-path-scoped-safety]] · [[game-studio-session-lifecycle]] · [[game-studio-token-efficient-workflows]] · [[game-studio-framework-churn-risk]]
- [[game-studio-evidence-driven-visual-qa]] · [[game-studio-automated-vs-player-quality]]

### Reference architecture study 2 (GodotPrompter; patterns only, not a dependency)
- [[game-studio-gp-reference-comparison]] — classification of patterns
- [[game-studio-godot-skill-taxonomy]] · [[game-studio-progressive-disclosure-routing]] · [[game-studio-skill-validation-architecture]] · [[game-studio-godot-example-verification]]
- [[game-studio-platform-portability-matrix]] · [[game-studio-version-aware-godot-knowledge]] · [[game-studio-third-party-addon-knowledge]] · [[game-studio-skill-eval-design]]

### Asset discovery, reuse and licensing (cross-cutting)
- [[game-studio-asset-discovery-and-reuse-workflow]] — find/acquire/register before generating
- [[game-studio-asset-license-and-provenance-policy]] · [[game-studio-asset-source-catalog]] · [[game-studio-asset-registry-and-manifest-conventions]]
- [[game-studio-godot-ecosystem-free-resources]] — Asset Library, Godot Shaders, Godot MIT notice
- [[game-studio-reuse-vs-generation-decision-framework]] · [[game-studio-godot-asset-format-and-import-compatibility]]

### Game design, analysis and creative foundations (Wave 1; evidence mostly abstract-level)
- [[game-studio-game-project-profile]] — profile-driven retrieval (read first)
- [[game-studio-game-design-theory-vocabulary]] · [[game-studio-prototype-vs-vertical-slice]] · [[game-studio-playtesting-methods]] · [[gs-adr-living-design-docs]]
- [[game-studio-game-reference-analysis-method]] · [[game-studio-reference-analysis-legal-boundary]]
- [[game-studio-accessibility-minimums]] · [[game-studio-loudness-targets]]

### Standards and workflows
- [[game-studio-asset-conventions]] · [[game-studio-acceptance-criteria]] · [[game-studio-workflows]]

### Decisions (proposed)
- [[gs-adr-free-and-open-source-first]] · [[gs-adr-blender-primary-3d]] · [[gs-adr-mcp-optional]] · [[gs-adr-no-extra-orchestration-framework]] · [[gs-adr-godot-final-ui-authority]] · [[gs-adr-artcraft-role]] · [[gs-adr-interchange-formats]]

### Preserved sources
- [[game-studio-sources-index]] — all 45 `src-gs-*` sources by theme, with the notes that cite them (paraphrased extractions with provenance; re-fetch before verification).

## See also
- [[godot-index]] — parent Godot knowledge map

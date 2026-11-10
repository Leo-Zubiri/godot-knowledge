---
id: game-studio-index
type: index
domain: game-studio
summary: "Map of content for the game-studio domain: game production architecture around Godot and Blender — tool evaluations, assets and licensing, quality, delivery, decisions and workflows."
related:
  - relates-to: "[[godot-index]]"   # parent Godot knowledge map
  - relates-to: "[[agent-ops-index]]"   # agent operations (split out of this domain)
  - relates-to: "[[game-design-index]]"   # game design (split out of this domain)
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Game studio — map of content
Navigational only; no claims. Game *production* knowledge: tools, pipelines, assets and licences, quality and delivery. All claim-bearing notes are `proposed` (agent-authored, documentary research dated 2026-11-08, awaiting human verification).

### Other domains (split out so each can be loaded on its own)
- [[godot-index]] — Godot 4.7 engine knowledge (architecture, physics, UI, animation, audio, 2D/3D, export, logging).
- [[game-design-index]] — game design principles, prototyping, playtesting, analysis of existing games, accessibility.
- [[agent-ops-index]] — agent orchestration, safety and permissions, sessions and cost, skills and knowledge-base engineering. (Those notes keep the historical `game-studio-` id prefix.)

### Browse by tag
Notes carry optional facet tags (controlled vocabulary in [`meta/methodology/tags.md`](../meta/methodology/tags.md)): `dept/*` (department), `tool/*` (tool), `dim/*` (2D or 3D) and `scope/*`. Find notes with `rg -l "^tags:.*dept/qa" notes/`, or colour the Obsidian graph with Groups such as `tag:#dept/qa` (keep the graph's **Tags** toggle off). Tags are a search aid, not evidence.

### Start here
- [[game-studio-tool-selection-guide]] — **which tool for which task** (agent routing table).
- [[game-studio-architecture-proposal]] — decision document, roadmap, open gaps.
- [[game-studio-cross-cutting-runtime-concerns]] — **cross-cutting** map: the runtime concerns every game/sim must address (errors, observability, saves, economy, accessibility, i18n, input).

### Evaluation and risk
- [[game-studio-cost-and-openness-classification]] — free/libre/open-source-first tiers
- [[game-studio-tool-matrix]] · [[game-studio-licensing-risks]] · [[game-studio-hardware-and-cost]] · [[game-studio-artcraft-evaluation]]

### Production departments
- [[game-studio-godot-integration]] · [[game-studio-blender-pipeline]] · [[game-studio-level-design]]
- [[game-studio-2d-ui-audio-materials]] · [[game-studio-ai-generation]] · [[game-studio-loudness-targets]]

### Asset discovery, reuse and licensing (cross-cutting)
- [[game-studio-asset-discovery-and-reuse-workflow]] — find/acquire/register before generating
- [[game-studio-asset-license-and-provenance-policy]] · [[game-studio-asset-source-catalog]] · [[game-studio-asset-registry-and-manifest-conventions]]
- [[game-studio-godot-ecosystem-free-resources]] — Asset Library, Godot Shaders, Godot MIT notice
- [[game-studio-reuse-vs-generation-decision-framework]] · [[game-studio-godot-asset-format-and-import-compatibility]]

### Quality and acceptance
- [[game-studio-acceptance-criteria]] · [[game-studio-evidence-driven-visual-qa]] · [[game-studio-automated-vs-player-quality]]

### Delivery and release (platform facts as written 2026-11-08)
- [[game-studio-delivery-platforms-and-fees]] · [[game-studio-versioning-and-changelog]] · [[game-studio-release-credits-and-ratings]] · [[game-studio-post-release-and-crash-reporting]]
- Godot-side export, CI limits and logging: see [[godot-index]].

### Standards and workflows
- [[game-studio-asset-conventions]] · [[game-studio-workflows]]
- [[game-studio-multiplayer-observability-and-session-monitoring]] — monitoring a live multiplayer game: session/match + health signals, where authority emits them, Prometheus/OpenTelemetry/Grafana vs a solo-dev minimal tier.
- [[game-studio-vr-standards-comfort-and-distribution]] — VR/XR for a studio: OpenXR as the cross-vendor standard, comfort/locomotion best practices, interaction conventions on the action model, VR accessibility, and SteamVR/Quest distribution (store fees/review flagged unverified).

### Decisions (proposed)
- [[gs-adr-free-and-open-source-first]] · [[gs-adr-blender-primary-3d]] · [[gs-adr-godot-final-ui-authority]] · [[gs-adr-artcraft-role]] · [[gs-adr-interchange-formats]]
- Agent-operations decisions live in [[agent-ops-index]]; the design-documentation decision in [[game-design-index]].

### Preserved sources
- [[game-studio-sources-index]] — all 50 `src-gs-*` sources by theme (including agent-ops and design sources), with the notes that cite them (paraphrased extractions with provenance; re-fetch before verification).

### Delivery: Steam, stores, privacy (gap closure)
- [[game-studio-delivery-steam-store-privacy-notes]]
- [[game-studio-anti-cheat-and-purchase-integrity]] — threat model, local/LAN/online decision tree, server-verified purchases per store (Google, Apple, Steam as written 2026-11-08), Godot client-hardening limits, checklist

## See also
- [[godot-index]] — parent Godot knowledge map
- [[agent-ops-index]] — agent operations
- [[game-design-index]] — game design

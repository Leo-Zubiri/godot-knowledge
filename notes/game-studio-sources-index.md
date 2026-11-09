---
id: game-studio-sources-index
type: index
domain: game-studio
summary: "Hub of all preserved game-studio sources, grouped by theme, with the notes that cite each one (human layer over the plain-id ref citations)."
related:
  - relates-to: "[[game-studio-index]]"   # parent map of the game-studio notes
  - relates-to: "[[godot-index]]"   # older Godot-domain sources are listed there
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Game studio — sources hub
Navigational only; no claims. Every preserved `src-gs-*` source, grouped by theme, with the notes that cite it. This is the **human layer** over the machine-readable `ref:` citations (which are plain ids, so Obsidian's graph and backlinks pane do not show them). Citations are unchanged; this list is maintained by hand when a source is added (find citing notes with `rg -l "ref: <source-id>" notes/`). All sources are `capture: paraphrased` (extractions, not verbatim text): re-fetch before promoting dependent notes to `verified`.

### Godot, testing and agent tooling
- [[src-gs-godot-cli]] — Godot command line tutorial (`paraphrased`) · cited by: [[game-studio-acceptance-criteria]], [[game-studio-architecture-proposal]], [[game-studio-asset-conventions]], [[game-studio-godot-integration]], [[game-studio-hardware-and-cost]], [[game-studio-level-design]], [[game-studio-tool-matrix]], [[game-studio-tool-selection-guide]], [[game-studio-workflows]]
- [[src-gs-godot-headless-render-limit]] — Forum: headless Godot cannot render the backend (screenshots) (`paraphrased`) · cited by: [[game-studio-godot-integration]]
- [[src-gs-godot-mcp-servers]] — Godot MCP server repos (README + GitHub API metadata) (`paraphrased`) · cited by: [[game-studio-cost-and-openness-classification]], [[game-studio-godot-integration]], [[game-studio-readiness-classification]], [[game-studio-tool-matrix]], [[gs-adr-mcp-optional]]
- [[src-gs-gut-gdunit4]] — GUT and gdUnit4 repos + command-line docs (`paraphrased`) · cited by: [[game-studio-acceptance-criteria]], [[game-studio-godot-integration]], [[game-studio-tool-matrix]], [[game-studio-tool-selection-guide]]
- [[src-gs-godot-3d-import]] — Godot 3D scene import: node-type suffixes, import configuration, skeleton retargeting (`paraphrased`) · cited by: [[game-studio-acceptance-criteria]], [[game-studio-asset-conventions]], [[game-studio-blender-pipeline]], [[game-studio-godot-asset-format-and-import-compatibility]], [[game-studio-godot-integration]], [[game-studio-level-design]], [[game-studio-workflows]], [[gs-adr-interchange-formats]]
- [[src-gs-level-2d-tools]] — LDtk importer for Godot and Tiled releases (`paraphrased`) · cited by: [[game-studio-level-design]], [[game-studio-tool-matrix]]
- [[src-gs-agent-instructions-portability]] — Agent instruction/skill portability: Agent Skills spec, Claude Code, OpenCode, Codex AGENTS.md (`paraphrased`) · cited by: [[game-studio-agent-orchestration]], [[game-studio-skills-architecture]], [[gs-adr-no-extra-orchestration-framework]]

### Blender and 3D tooling
- [[src-gs-blender-releases-bpy]] — Blender releases, pip bpy wheel, Python API docs (`paraphrased`) · cited by: [[game-studio-blender-pipeline]], [[game-studio-cost-and-openness-classification]], [[game-studio-hardware-and-cost]], [[game-studio-licensing-risks]], [[game-studio-tool-matrix]], [[gs-adr-blender-primary-3d]]
- [[src-gs-blender-mcp]] — Blender MCP: official Blender Lab and community (ahujasid) (`paraphrased`) · cited by: [[game-studio-blender-pipeline]], [[game-studio-readiness-classification]], [[game-studio-tool-matrix]], [[game-studio-tool-selection-guide]], [[gs-adr-blender-primary-3d]], [[gs-adr-mcp-optional]]
- [[src-gs-mixar]] — Mixar (Blender fork with AI agent) repo and integration doc (`paraphrased`) · cited by: [[game-studio-blender-pipeline]], [[game-studio-cost-and-openness-classification]], [[game-studio-licensing-risks]], [[game-studio-tool-matrix]], [[gs-adr-blender-primary-3d]]

### AI generation (ComfyUI and models)
- [[src-gs-comfyui-core]] — ComfyUI license, releases, server routes, Manager (`paraphrased`) · cited by: [[game-studio-ai-generation]], [[game-studio-cost-and-openness-classification]], [[game-studio-hardware-and-cost]], [[game-studio-licensing-risks]], [[game-studio-tool-matrix]]
- [[src-gs-comfyui-mcp]] — ComfyUI MCP servers (`paraphrased`) · cited by: [[game-studio-ai-generation]], [[game-studio-tool-matrix]], [[gs-adr-mcp-optional]]
- [[src-gs-hunyuan3d-license]] — Hunyuan3D-2.1 Community License and repo (`paraphrased`) · cited by: [[game-studio-ai-generation]], [[game-studio-cost-and-openness-classification]], [[game-studio-hardware-and-cost]], [[game-studio-licensing-risks]]
- [[src-gs-sf3d-trellis]] — Stable Fast 3D, TRELLIS, TRELLIS.2 repos and licenses (`paraphrased`) · cited by: [[game-studio-ai-generation]], [[game-studio-cost-and-openness-classification]], [[game-studio-hardware-and-cost]], [[game-studio-licensing-risks]]
- [[src-gs-image-model-licenses]] — Image model cards: FLUX.1/FLUX.2, Qwen-Image, SD 3.5 Large (`paraphrased`) · cited by: [[game-studio-ai-generation]], [[game-studio-cost-and-openness-classification]], [[game-studio-licensing-risks]], [[gs-adr-free-and-open-source-first]]

### ArtCraft, 2D, UI and audio tools
- [[src-gs-artcraft-suite]] — ArtCraft / Crafting Apps org, site, and per-app READMEs (`paraphrased`) · cited by: [[game-studio-2d-ui-audio-materials]], [[game-studio-artcraft-evaluation]], [[game-studio-cost-and-openness-classification]], [[game-studio-licensing-risks]], [[game-studio-tool-matrix]], [[gs-adr-artcraft-role]]
- [[src-gs-2d-ui-tools]] — Material Maker, Krita, Inkscape, Penpot, ArmorPaint (CLI/automation facts) (`paraphrased`) · cited by: [[game-studio-2d-ui-audio-materials]], [[game-studio-cost-and-openness-classification]], [[game-studio-tool-matrix]], [[game-studio-tool-selection-guide]], [[game-studio-workflows]], [[gs-adr-godot-final-ui-authority]]
- [[src-gs-audio-import-and-tools]] — Godot audio import; Audacity scripting; Ardour Lua; Stable Audio 3 (`paraphrased`) · cited by: [[game-studio-2d-ui-audio-materials]], [[game-studio-acceptance-criteria]], [[game-studio-godot-asset-format-and-import-compatibility]], [[game-studio-licensing-risks]], [[game-studio-tool-matrix]], [[game-studio-tool-selection-guide]], [[game-studio-workflows]], [[gs-adr-interchange-formats]]

### Reference study: Claude-Code-Game-Studios
- [[src-gs-ccgs-repo-overview]] — Claude-Code-Game-Studios: README, LICENSE, releases, project.yaml, config resolution (`paraphrased`) · cited by: [[game-studio-ccgs-reference-comparison]], [[game-studio-configurable-rigor]], [[game-studio-framework-churn-risk]], [[game-studio-multiagent-topology]]
- [[src-gs-ccgs-workflow-rigor-and-gates]] — CCGS workflow modes, director gates, skills reference, skill quality rubric (`paraphrased`) · cited by: [[game-studio-ccgs-reference-comparison]], [[game-studio-configurable-rigor]], [[game-studio-delegation-boundaries]], [[game-studio-framework-churn-risk]], [[game-studio-review-modes-and-verdicts]], [[game-studio-token-efficient-workflows]]
- [[src-gs-ccgs-agent-topology]] — CCGS coordination rules and model tiers (`paraphrased`) · cited by: [[game-studio-ccgs-reference-comparison]], [[game-studio-delegation-boundaries]], [[game-studio-multiagent-topology]]
- [[src-gs-ccgs-safety-and-session]] — CCGS settings, hooks reference, context management (`paraphrased`) · cited by: [[game-studio-ccgs-reference-comparison]], [[game-studio-path-scoped-safety]], [[game-studio-session-lifecycle]], [[game-studio-token-efficient-workflows]]
- [[src-gs-ccgs-qa-evidence]] — CCGS run-and-observe visual evidence rule and test standards (`paraphrased`) · cited by: [[game-studio-automated-vs-player-quality]], [[game-studio-ccgs-reference-comparison]], [[game-studio-evidence-driven-visual-qa]]

### Reference study: GodotPrompter
- [[src-gs-gp-repo-overview]] — GodotPrompter: repo overview, README, licence, releases (`paraphrased`) · cited by: [[game-studio-godot-example-verification]], [[game-studio-gp-reference-comparison]], [[game-studio-platform-portability-matrix]], [[game-studio-progressive-disclosure-routing]], [[game-studio-version-aware-godot-knowledge]]
- [[src-gs-gp-skill-architecture]] — GodotPrompter skill format, addon policy, index, sample skill and agent (`paraphrased`) · cited by: [[game-studio-godot-skill-taxonomy]], [[game-studio-gp-reference-comparison]], [[game-studio-multiagent-topology]], [[game-studio-progressive-disclosure-routing]], [[game-studio-third-party-addon-knowledge]], [[game-studio-token-efficient-workflows]]
- [[src-gs-gp-validation-ci]] — GodotPrompter validation scripts and CI workflows (`paraphrased`) · cited by: [[game-studio-godot-example-verification]], [[game-studio-gp-reference-comparison]], [[game-studio-skill-validation-architecture]]
- [[src-gs-gp-platforms-and-hooks]] — GodotPrompter cross-platform matrix, test plan, results, hooks and install docs (`paraphrased`) · cited by: [[game-studio-gp-reference-comparison]], [[game-studio-platform-portability-matrix]], [[game-studio-skill-eval-design]]
- [[src-gs-gp-evals]] — GodotPrompter skill evals (with/without-skill ablation) (`paraphrased`) · cited by: [[game-studio-godot-example-verification]], [[game-studio-gp-reference-comparison]], [[game-studio-progressive-disclosure-routing]], [[game-studio-skill-eval-design]], [[game-studio-third-party-addon-knowledge]], [[game-studio-version-aware-godot-knowledge]]

### Asset licences and providers
- [[src-gs-asset-cc-licenses]] — Creative Commons deeds: CC0 1.0, CC BY 4.0, CC BY-SA 4.0, CC BY-NC 4.0 (`paraphrased`) · cited by: [[game-studio-asset-license-and-provenance-policy]], [[game-studio-reuse-vs-generation-decision-framework]]
- [[src-gs-asset-packs-3d-2d]] — Kenney, Quaternius (QAL v1.0) and KayKit asset provider terms (`paraphrased`) · cited by: [[game-studio-asset-license-and-provenance-policy]], [[game-studio-asset-source-catalog]], [[game-studio-cost-and-openness-classification]], [[gs-adr-free-and-open-source-first]]
- [[src-gs-asset-materials-hdri]] — Poly Haven, ambientCG, TextureCan, BlenderKit (materials, textures, HDRIs, models) (`paraphrased`) · cited by: [[game-studio-asset-discovery-and-reuse-workflow]], [[game-studio-asset-license-and-provenance-policy]], [[game-studio-asset-source-catalog]], [[game-studio-godot-asset-format-and-import-compatibility]]
- [[src-gs-asset-marketplaces]] — Marketplace and community providers: Fab, Sketchfab, itch.io, CGTrader, OpenGameArt, Mixamo (`paraphrased`) · cited by: [[game-studio-asset-discovery-and-reuse-workflow]], [[game-studio-asset-license-and-provenance-policy]], [[game-studio-asset-registry-and-manifest-conventions]], [[game-studio-asset-source-catalog]], [[game-studio-cost-and-openness-classification]], [[game-studio-reuse-vs-generation-decision-framework]], [[gs-adr-free-and-open-source-first]]
- [[src-gs-asset-audio]] — Audio providers: Freesound (FAQ, API terms, API), Sonniss GDC bundles, incompetech, Pixabay (`paraphrased`) · cited by: [[game-studio-asset-discovery-and-reuse-workflow]], [[game-studio-asset-license-and-provenance-policy]], [[game-studio-asset-registry-and-manifest-conventions]], [[game-studio-asset-source-catalog]]
- [[src-gs-asset-icons-fonts]] — Icon and font libraries: Lucide, Phosphor, Tabler, Font Awesome Free, SIL OFL (`paraphrased`) · cited by: [[game-studio-asset-source-catalog]]

### Libre-first licences and sources
- [[src-gs-free-tool-licenses]] — Licences of open-source production tools (Godot, gdtoolkit, Krita, Inkscape, Ardour, ffmpeg, sox, Audacity, LMMS, Hydrogen, Pixelorama, LibreSprite, ArmorPaint) and the Aseprite EULA (`paraphrased`) · cited by: [[game-studio-2d-ui-audio-materials]], [[game-studio-cost-and-openness-classification]], [[game-studio-godot-ecosystem-free-resources]], [[game-studio-licensing-risks]], [[game-studio-tool-matrix]]
- [[src-gs-free-godot-ecosystem]] — Godot engine licence page, Godot Asset Library (API, licence field, submission rules) and Godot Shaders licence (`paraphrased`) · cited by: [[game-studio-asset-source-catalog]], [[game-studio-cost-and-openness-classification]], [[game-studio-godot-ecosystem-free-resources]]
- [[src-gs-free-fonts-icons-audio-sources]] — Free fonts, icon sets, music/SFX sources and sfxr-style generators (`paraphrased`) · cited by: [[game-studio-asset-source-catalog]]
- [[src-gs-free-mocap-and-3d-sources-unverified]] — Free mocap and 3D sources whose official terms could not be read (CMU Mocap, Rokoko, Poly Pizza, Smithsonian Open Access) (`paraphrased`) · cited by: [[game-studio-asset-source-catalog]]

### Game design, analysis, accessibility and Godot import (Wave 1)
- [[src-gs-design-prototype-slice-docs]] — Prototype vs vertical slice and living design documentation (Ismail; Keith 2011; Florencio 2022) (`paraphrased`) · cited by: [[game-studio-prototype-vs-vertical-slice]], [[gs-adr-living-design-docs]]
- [[src-gs-design-playtesting]] — Playtesting and usability-testing sample sizes (Nielsen 2000; Valve GDC 2009 as unread pointer) (`paraphrased`) · cited by: [[game-studio-playtesting-methods]]
- [[src-gs-design-theory-and-typologies]] — Game design theory: MDA abstract, Bartle's player types, Hamari and Tuunanen meta-synthesis; other models as unread pointers (`paraphrased`) · cited by: [[game-studio-game-design-theory-vocabulary]], [[game-studio-game-reference-analysis-method]]
- [[src-gs-design-reference-analysis-pointers-unverified]] — Methods for analysing existing games and legal-boundary pointers (not read in full) (`paraphrased`) · cited by: [[game-studio-game-reference-analysis-method]], [[game-studio-reference-analysis-legal-boundary]]
- [[src-gs-accessibility-and-loudness]] — Game Accessibility Guidelines (basic tier), Xbox Accessibility Guidelines intro, EBU R128; ITU BS.2434 as unread pointer (`paraphrased`) · cited by: [[game-studio-accessibility-minimums]], [[game-studio-loudness-targets]]
- [[src-gs-godot-import-formats-47]] — Godot 4.7 documentation: available 3D formats and image import (`paraphrased`) · cited by: [[game-studio-godot-asset-format-and-import-compatibility]]
- [[src-gs-asset-quaternius-ual-pack]] — Quaternius Universal Animation Library pack page (CC0 statement) — conflicts with the QAL licence page (`paraphrased`) · cited by: [[game-studio-asset-source-catalog]], [[game-studio-godot-asset-format-and-import-compatibility]]

## See also
- [[game-studio-index]] — map of the game-studio notes
- [[godot-index]] — Godot knowledge map (older sources listed there)

---
id: src-gs-design-art-readability-animation
type: source
domain: game-design
source:
  url: "https://www.cs.princeton.edu/courses/archive/fall07/cos597B/papers/mitchell-team-fortress.pdf"
  urls:
    - "https://www.cs.princeton.edu/courses/archive/fall07/cos597B/papers/mitchell-team-fortress.pdf"
    - "https://education.siggraph.org/static/HyperGraph/animation/character_animation/principles/prin_trad_anim.htm"
    - "https://blog.makko.ai/what-public-game-art-bibles-say/"
    - "https://developer.apple.com/design/human-interface-guidelines/designing-for-games"
    - "https://www.audiokinetic.com/en/public-library/2025.1.12_9287/?id=whatsnew_2025_1_new_features.html"
  title: "Art direction, readability and animation principles: Valve TF2 NPAR paper, SIGGRAPH animation-principles page, art-bible pointers, platform guideline and Wwise pointers"
  retrieved: 2026-11-08
  version: "TF2 paper pages 1-4 read by the main agent; SIGGRAPH page read by subagent; others pointers"
  capture: paraphrased
  retrieved_via: "TF2 PDF pages 1-4 read by the main agent from page images; other items via subagent summarizer; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** pages fetched on 2026-11-08 by research subagents and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**; PDFs marked 'read by the main agent' were read from downloaded page images. Fees, defaults and policies are recorded only as written on that date; UNV/unverified items were not read on an official page (404, blocked, snippet-only). Godot page versions: 'header not reported' means the fetch tool did not show the version (the URL is the `stable` path). Not legal advice. Re-fetch before promoting dependent notes to `verified`.

- **Mitchell, Francke, Eng (Valve), "Illustrative Rendering in Team Fortress 2" (NPAR 2007; PDF pages 1–4 read by the main agent):** the look is "grounded in the conventions of early 20th-century commercial illustration with 1960s industrial design elements" and results from close collaboration between artists and engineers; shading techniques are designed so players can visually "read" the scene and identify other players in varied lighting. Observed illustration conventions listed by the authors: shadows go to cool, not black (warm-to-cool hue shift); saturation increases at the terminator (often reddened); high-frequency detail omitted where possible; on characters, interior details such as clothing folds echo silhouette shapes; silhouettes emphasised with rim highlights rather than dark outlines. **Characters:** because players must identify others quickly at distances and viewpoints, the nine classes' silhouettes were "carefully designed to be very distinct"; even seen only as silhouettes the characters are identifiable, and **silhouette-only reading was used to validate character designs during concept**; body proportions, weapons, hats and clothing lines give each class a unique silhouette. **World:** teams have contrasting properties (red: warm colours, natural materials, angular geometry; blue: cool colours, industrial materials, orthogonal forms); geometry deliberately avoids overly complex detail; minimal repetition and visual noise serve gameplay goals ("impressionistic"). **Textures:** hand-painted albedo with loose visible brush strokes (early on painted on canvas with watercolours, later digital brushes over photographic reference); the authors believe high-frequency photo detail can overpower designers' ability to emphasise gameplay features with intentional value choices. Pages 5+ (shading algorithms, half-Lambert, rim lighting) only skimmed in part, not summarised.
- **SIGGRAPH education page "Principles of traditional animation" (read by subagent; index of Lasseter 1987, not the paper):** lists **eleven** principles with one-line descriptions — squash and stretch, timing and motion, anticipation, staging, follow-through and overlapping action, straight-ahead vs pose-to-pose, slow in and out, arcs, exaggeration, secondary action, appeal; says they were developed at Disney in the 1930s and that personality is the goal; cites Maestri, *Digital Character Animation* (1996). The commonly cited twelfth ("solid drawing") was not verified; Thomas & Johnston (1981) and Lasseter's paper could not be fetched as readable text (UNV).
- **Art bibles and platform guidance:** a secondary blog says 0 A.D., Liberated Pixel Cup, Battle for Wesnoth and Riot (League of Legends VFX style guide) published art bibles — the documents were not opened (UNV). Apple's "Designing for games" page and Material Design colour returned only titles; GDC Vault sessions on art pillars, readability and VFX are descriptions only; Wwise music-container structure (Music Switch Container, Segments with entry/exit sync points, Transition Manager; 2025.1 renamed the Interactive Music Hierarchy "Music (Migrated)") known only from search snippets (UNV); no FMOD or VFX-readability official source found.

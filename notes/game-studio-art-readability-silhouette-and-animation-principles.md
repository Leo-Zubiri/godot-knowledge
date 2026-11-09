---
id: game-studio-art-readability-silhouette-and-animation-principles
type: reference
domain: game-design
status: proposed
summary: "Readability lessons from Valve's TF2 illustrative-rendering paper (silhouette-distinct classes, cool shadows, omitted detail) and the eleven animation principles list, with unverified art-bible pointers."
tags: [dept/design, dept/3d-art, scope/game-analysis]
sources:
  - claim: "TF2 NPAR paper pages 1-4"
    ref: src-gs-design-art-readability-animation
    retrieved: 2026-11-08
  - claim: "SIGGRAPH animation principles index page"
    ref: src-gs-design-art-readability-animation
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-game-reference-analysis-method]]"   # analysis method
  - relates-to: "[[game-studio-accessibility-minimums]]"   # readability and accessibility
  - relates-to: "[[godot-animation-tree-and-tween-pitfalls]]"   # implementing animation
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---


> **Evidence status:** primary papers/pages as read on 2026-11-08 (paraphrased; PDFs read from page images, partly). Practitioner theory is labelled as such. Status `proposed`.

- **TF2 (Mitchell, Francke, Eng 2007):** shading is designed so players can read the scene and identify others at distance; the nine class silhouettes are "carefully designed to be very distinct" and silhouette-only reading was used to validate concepts. Illustration conventions the authors list: shadows go cool not black, saturation rises at the terminator, high-frequency detail omitted, rim highlights instead of dark outlines. Teams contrast in colour, material and shape language; textures are hand-painted. Pages 5+ not summarised.
- **Interpretation (ours):** a silhouette test and a value/colour-contrast test are cheap readability checks for any style; the paper does not provide a measured threshold.
- **Animation principles (SIGGRAPH page, index of Lasseter 1987):** eleven listed (squash and stretch, anticipation, staging, follow-through, straight-ahead vs pose-to-pose, slow in/out, arcs, secondary action, timing, exaggeration, appeal); the Lasseter paper and Thomas & Johnston were not read; a twelfth "solid drawing" is unverified.
- **Art bibles, Wwise music structure, platform guidance:** pointers only (UNV).

## See also
- [[game-studio-game-reference-analysis-method]] — analysis method
- [[game-studio-accessibility-minimums]] — readability and accessibility
- [[godot-animation-tree-and-tween-pitfalls]] — implementing animation

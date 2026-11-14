---
id: src-gs-valve-illustrative-rendering-tf2
type: source
domain: game-studio
source:
  url: "https://www.cs.princeton.edu/courses/archive/fall07/cos597B/papers/mitchell-team-fortress.pdf"
  title: "Mitchell, Francke, Eng (Valve) — Illustrative Rendering in Team Fortress 2 (NPAR 2007 paper; course-hosted copy)"
  retrieved: 2026-11-14
  version: "NPAR 2007 paper"
  capture: excerpt
  retrieved_via: "PDF downloaded and converted locally with pdftotext; quoted passages are exact apart from line re-flow and marked elisions"
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> Preserved excerpts (conventionally immutable). Paper by a studio's own rendering and art team describing the shading of a shipped stylised game. Short quoted passages only; bullet text outside quotes is a summary.

**Observed illustration conventions (section 3):**
> "Shading obeys a warm-to-cool hue shift. Shadows go to cool, not black."
>
> "Saturation increases at the terminator with respect to a given light source. The terminator is often reddened."
>
> "High frequency detail is omitted where possible"
>
> "Silhouettes are emphasized with rim highlights rather than dark outlines"

**Colour and textures (section 4.3):**
> "colors used on characters and the game world border on realism, but with increased saturation and value contrast."
>
> "the texture maps used on the 3D world are impressionistic, meaning that they are painterly and maintain a minimum level of visual noise."
>
> "we believe that high frequency geometric and texture detail found in photorealistic games can often overpower the ability of designers to compose game environments and emphasize gameplay features visually using intentional design choices such as changes in color value."

**Half Lambert (section 5):**
> "we have been applying a scale by 0.5, bias by 0.5 and square to diffuse lighting terms to prevent characters from losing a sense of shape on the back side with respect to a given light source"

**Directional ambient (section 5):**
> "we also apply a directional ambient term"
>
> "Despite the simplicity of this lighting component [...] the ambient cube term contributes bounced light which is critical to truly grounding characters and other models in the game world."

Summary: the ambient term is a function of the surface normal — six lobes along the positive and negative axes, precomputed by an offline radiosity solver — so ambient light differs by direction instead of being one constant colour.

**Rim lighting (section 5):**
- Summary: broad rim highlights are added as extra per-light specular lobes with a low exponent, masked by a Fresnel term (typically (1 − n·v)^4), and attenuated by a painted mask.
- Summary: a dedicated rim term uses the ambient light seen along the view direction, masked by Fresnel and by the normal dotted with the up vector.

> "This causes the dedicated rim lighting term to appear to add in indirect light from the environment, but only for upward facing normals. This is both an aesthetic choice and a perceptual decision designed exploit the human instinct to assume that lighting tends to come from above."

**Stated priority (section 5):**
> "Unlike photorealistic games, which place a major emphasis on micro details for realism, we feel that our impressionistic approach favors the audience of fast-paced action games who [...] are more concerned with perceiving gross shape and shading as emphasized by our focus on distinctive silhouettes and rim lighting."

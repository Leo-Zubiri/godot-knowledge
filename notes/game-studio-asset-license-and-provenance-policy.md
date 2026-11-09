---
id: game-studio-asset-license-and-provenance-policy
type: reference
domain: game-studio
status: proposed
summary: "What each licence type does and does not allow (commercial use, modification, shipping, redistributing originals, attribution, sharing, AI use) and the proposed rules agents follow; usable in a game is not the same as redistributable."
tags: [dept/assets, scope/licensing]
sources:
  - claim: "CC0, CC BY, CC BY-SA, CC BY-NC deeds: permissions, attribution, ShareAlike, NonCommercial, no-additional-restrictions"
    ref: src-gs-asset-cc-licenses
    retrieved: 2026-11-08
  - claim: "Quaternius QAL: commercial use yes, no standalone redistribution, irrevocable except uncured breach, no retroactive version changes, AI not addressed"
    ref: src-gs-asset-packs-3d-2d
    retrieved: 2026-11-08
  - claim: "Sonniss: no redistribution of originals or edits, team sharing allowed, AI/ML training prohibited, version at download date applies"
    ref: src-gs-asset-audio
    retrieved: 2026-11-08
  - claim: "Fab Standard License allows private-repo sharing with collaborators but not standalone resale; BlenderKit Royalty Free bars reselling the model"
    ref: src-gs-asset-marketplaces
    retrieved: 2026-11-08
  - claim: "Pixabay: no sharing of originals unmodified; BlenderKit RF: no resale of the model itself"
    ref: src-gs-asset-materials-hdri
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-licensing-risks]]"   # tool/model licences; this note covers asset licences
  - relates-to: "[[game-studio-asset-discovery-and-reuse-workflow]]"   # workflow applies this policy
  - relates-to: "[[game-studio-asset-registry-and-manifest-conventions]]"   # fields record these permissions
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research dated 2026-11-08 from official provider pages (paraphrased extractions, not verbatim legal text); no asset was downloaded and nothing was executed. **Not legal advice.** Terms change; items marked `unverified` were not read on an official page. Classes and workflows are *proposals* pending human review; ambiguous cases must go to a human.


## Seven permissions kept separate
1. Use in a commercial game · 2. Modify · 3. Distribute a game containing the asset · 4. **Redistribute the original files** · 5. Attribution · 6. Sublicensing / sharing with collaborators · 7. AI-training or secondary-use restrictions. An asset usable in a commercial game does **not** automatically allow its source files to be redistributed (e.g. in a public Git repo).

## Licence types (from the CC deeds and provider terms; deeds have no legal value, the legal code governs)
| Type | Commercial game | Modify | Redistribute originals | Attribution | Notes |
|---|---|---|---|---|---|
| CC0 | yes | yes | yes | none | patent, trademark, publicity/privacy rights not waived; AI use not addressed |
| CC BY 4.0 | yes | yes, note changes | yes, with credit | **required** (creator, licence link, changes) | AI training contested — human review |
| CC BY-SA 4.0 | yes | yes, adaptations under same/compatible licence | yes | required | **open question:** does ShareAlike reach a whole game or only the adapted asset? Human/legal review |
| CC BY-NC 4.0 | **no** | yes | non-commercial only | required | excluded for commercial games |
| Custom royalty-free (QAL, Fab Standard, BlenderKit RF, Sonniss, Pixabay) | yes | mostly yes (some terms unread) | **no** (standalone) | usually none | terms differ per provider; read each |

## Proposed rules (design, not legal advice)
- **Verify the individual asset's licence**, not only the provider's. Free to download ≠ commercially usable.
- **Exclude CC BY-NC** (and unknown licences) from commercial projects.
- **CC BY-SA, custom/ambiguous or unread terms → human approval before use.**
- **Do not commit original files** of non-CC0 assets to public repositories; reference them via the registry instead (check each licence; Fab allows private-repo sharing with project collaborators, QAL/Sonniss/Pixabay/BlenderKit RF restrict standalone redistribution).
- **Never use restricted assets as inputs to generative/training tools** (Sonniss prohibits AI/ML use; Freesound has per-uploader AI preferences; Mixamo and Sketchfab NoAI claims are secondary/unverified).
- **Snapshot the licence evidence** (URL, retrieval date, text or screenshot) at acquisition: terms can change, and some providers apply the version in force at download (QAL, Sonniss) while others (Pixabay, itch.io) may change terms.
- Generate an attribution/credits file from the registry (CC BY, incompetech and Font Awesome icons require credit; a credits screen is accepted by incompetech).
- Keep logos/brand marks and recognizable-people content out unless cleared (Font Awesome brand icons, Pixabay).

## See also
- [[game-studio-licensing-risks]] — model and tool licences
- [[game-studio-asset-discovery-and-reuse-workflow]] — workflow applies this policy
- [[game-studio-asset-registry-and-manifest-conventions]] — fields record these permissions

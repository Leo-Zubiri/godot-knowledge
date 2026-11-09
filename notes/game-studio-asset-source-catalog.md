---
id: game-studio-asset-source-catalog
type: reference
domain: game-studio
status: proposed
summary: "Preliminary catalog of asset providers by type with licence scope, automation access and a proposed class (approved-candidate, conditional, avoid, not evaluated)."
tags: [dept/assets]
sources:
  - claim: "Quaternius UAL pack page (CC0) versus QAL licence"
    ref: src-gs-asset-quaternius-ual-pack
    retrieved: 2026-11-08
  - claim: "CMU, Rokoko, Poly Pizza, Smithsonian: official terms unreadable (record of what remains to verify)"
    ref: src-gs-free-mocap-and-3d-sources-unverified
    retrieved: 2026-11-08
  - claim: "Fonts, icons, ccMixter, Mixkit, sfxr-style generators"
    ref: src-gs-free-fonts-icons-audio-sources
    retrieved: 2026-11-08
  - claim: "Godot Asset Library and Godot Shaders"
    ref: src-gs-free-godot-ecosystem
    retrieved: 2026-11-08
  - claim: "Kenney, Quaternius, KayKit"
    ref: src-gs-asset-packs-3d-2d
    retrieved: 2026-11-08
  - claim: "Poly Haven, ambientCG, TextureCan, BlenderKit"
    ref: src-gs-asset-materials-hdri
    retrieved: 2026-11-08
  - claim: "Fab, Sketchfab, itch.io, CGTrader, OpenGameArt, Mixamo"
    ref: src-gs-asset-marketplaces
    retrieved: 2026-11-08
  - claim: "Freesound, Sonniss, incompetech, Pixabay"
    ref: src-gs-asset-audio
    retrieved: 2026-11-08
  - claim: "Lucide, Phosphor, Tabler, Font Awesome, OFL fonts"
    ref: src-gs-asset-icons-fonts
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-asset-license-and-provenance-policy]]"   # what the licence column means
  - relates-to: "[[game-studio-asset-discovery-and-reuse-workflow]]"   # providers searched in step 2
  - relates-to: "[[game-studio-godot-asset-format-and-import-compatibility]]"   # formats and import
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research dated 2026-11-08 from official provider pages (paraphrased extractions, not verbatim legal text); no asset was downloaded and nothing was executed. **Not legal advice.** Terms change; items marked `unverified` were not read on an official page. Classes and workflows are *proposals* pending human review; ambiguous cases must go to a human.


Classes: **approved-candidate** (clear provider-wide licence; still confirm the per-pack file), **conditional** (per-asset or unread/unclear terms → human check), **avoid** (no verifiable terms), **not evaluated**. Automation = what a documented programmatic path allows; nothing was tested.

| Type | Provider | Licence scope (read) | Automation access | Class (prelim.) |
|---|---|---|---|---|
| 3D, 2D, audio | Kenney | CC0 stated provider-wide; per-pack file exists (unread) | no API found; All-in-1 bundle | approved-candidate |
| 3D, anim | Quaternius | QAL v1.0 (not CC0); provider-wide | none verified | conditional (full QAL read; AI use unaddressed) |
| 3D | KayKit | no licence info found | none | conditional |
| 3D, materials | BlenderKit | RF or CC0 per asset | add-on; API unverified | conditional |
| 3D, materials | Fab | Standard License / CC BY per listing (summary only) | none verified | conditional |
| 3D | Sketchfab | per model (CC/Standard) | Download API needs end-user OAuth login | conditional |
| 3D | CGTrader | not verified | none | avoid (for now) |
| 2D/3D/audio | OpenGameArt | page blocked (403) | unverified | conditional (CC0 only) |
| 2D/3D/audio | itch.io | per creator; buyer licence persists | no automation path found | conditional |
| Materials, HDRI | Poly Haven | CC0 provider-wide | public API (API Terms unread; site ToS bans scraping) | approved-candidate |
| Materials, HDRI | ambientCG | CC0 1.0 provider-wide | documented API v1–v3, stability caveat | approved-candidate |
| Materials | TextureCan | CC0 stated; raw-file redistribution unclear | none stated | approved-candidate with caveat |
| Animation | Mixamo | official terms unread (403) | no sanctioned API | conditional |
| Audio | Freesound | per sound (CC0/BY/NC) | REST API; download needs OAuth2; scraping banned | conditional (filter CC0, maybe CC BY) |
| Audio | Sonniss GDC | custom; read in full | manual download | conditional |
| Audio | incompetech | CC BY 4.0 per track (or paid) | none | conditional (credits screen + record) |
| Audio, images | Pixabay | custom; changeable | scraping/bots prohibited | conditional |
| Icons | Lucide, Phosphor, Tabler | ISC/MIT | repos/packages | approved-candidate (keep notices) |
| Icons | Font Awesome Free | CC BY 4.0 icons / OFL fonts / MIT code | repo | conditional (prefer the above) |
| Fonts | Google Fonts (OFL) | per family; FAQ unreadable | download | conditional |

**Not evaluated:** other mocap/animation repositories, ccMixter, VFX/particle sources, SVG/pixel-art libraries beyond icons.

## Additional libre-first sources (second pass)
| Type | Source | Licence and scope (read unless noted) | Class (prelim.) |
|---|---|---|---|
| Godot addons/templates | Godot Asset Library | per asset; label must match repo LICENSE; documented read API | approved-candidate for discovery ([[game-studio-godot-ecosystem-free-resources]]) |
| Shaders | Godot Shaders | per shader CC0/MIT/GPL v3, code only | approved-candidate (avoid GPL v3 without review) |
| Fonts | Google Fonts repo; Fontsource | OFL 1.1 mostly, some Apache/UFL; per-family licence file | approved-candidate (check each family; skip the `cc-by-sa` directory unless read) |
| Icons | Bootstrap Icons, Heroicons (MIT); Material Symbols (Apache 2.0) | provider-wide | approved-candidate |
| Icons | game-icons.net | CC BY 3.0, per-author credit, no bulk download | conditional |
| Music | ccMixter | per track CC BY / BY-NC / CC0; API under same terms | conditional (CC0 or CC BY only) |
| Audio | Mixkit | per-type "Free License"; text unreadable | conditional (human read first) |
| SFX generators | jsfxr (Unlicense), Bfxr2 (MIT) | code licensed; **generated-sound licence not stated** | conditional |
| Mocap, 3D | CMU Mocap, Rokoko free moves, Poly Pizza, Smithsonian Open Access | official pages unreadable; secondary claims only | conditional / `unverified` — read before use |
| Audio | Zapsplat, Free Music Archive, Internet Archive; OpenGameArt | terms unread / blocked | conditional / avoid until read |

Still **gaps** with no libre source identified: a free humanoid animation library with a clear libre licence (Mixamo has no confirmed libre equivalent), particle/VFX sprite sheets, tilesets/pixel-art libraries, free UI kits.

## Licence conflict to resolve (Quaternius Universal Animation Library)
The pack page states **CC0** and lists FBX/GLB/Blend (Standard/Pro free, Source via Patreon), while Quaternius's main licence page is the custom **QAL v1.0** (not CC0; no standalone redistribution). Both statements are preserved ([[src-gs-asset-quaternius-ual-pack]]); until a human decides which governs, treat the pack as **conditional** and do not redistribute the original files. Kenney's Particle Pack page states CC0 (80 PNG-like 512×512 tiles; formats not listed on the page).

## Cost and openness (free/libre-first)
The project prefers free, gratis and open-source resources ([[gs-adr-free-and-open-source-first]]). Mapping of this catalog to tiers: **libre-open** — Kenney, Poly Haven, ambientCG, TextureCan (CC0), Lucide/Phosphor/Tabler (ISC/MIT); **gratis-restricted** — Quaternius (QAL), Sonniss, Pixabay, Freesound (per sound), incompetech (CC BY), Font Awesome Free, OFL fonts (per family), BlenderKit Royalty Free, per-creator itch.io/OpenGameArt/Sketchfab content; **paid/closed** — paid Fab/itch.io/CGTrader listings, Mixamo (free with an Adobe ID; terms unverified). Details: [[game-studio-cost-and-openness-classification]].

## See also
- [[game-studio-asset-license-and-provenance-policy]] — policy behind the classes
- [[game-studio-asset-discovery-and-reuse-workflow]] — providers searched in step 2
- [[game-studio-godot-asset-format-and-import-compatibility]] — formats and import

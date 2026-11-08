---
id: gs-adr-interchange-formats
type: decision
domain: game-studio
status: proposed
summary: "Proposed: prefer open interchange formats (GLB/glTF, PNG, WAV, OGG, SVG) without forcing one format where a specialised source format fits."
sources:
  - claim: "Godot imports WAV/Ogg/MP3 and glTF with documented options"
    ref: src-gs-audio-import-and-tools
    retrieved: 2026-11-08
  - claim: "Godot 3D import"
    ref: src-gs-godot-3d-import
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-asset-conventions]]"   # conventions
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Context
Godot imports glTF/GLB and WAV/Ogg/MP3 natively; sources like `.blend` or `.ptex` carry editing data.

## Decision
Ship open formats into Godot; keep specialised formats as sources in `art-src/`.

## Consequences
Need generation scripts and manifests to keep sources and exports in sync.

## See also
- [[game-studio-architecture-proposal]] — overall proposal
- [[game-studio-asset-conventions]] — conventions

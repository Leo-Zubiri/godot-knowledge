---
id: game-studio-asset-conventions
type: reference
domain: game-studio
status: proposed
summary: "Proposed shared asset conventions: workspace layout, naming, manifests, validation reports and reproducible generation records."
sources:
  - claim: "Godot CLI/import mechanisms the conventions must interoperate with"
    ref: src-gs-godot-cli
    retrieved: 2026-11-08
  - claim: "Open interchange formats Godot imports (audio) and glTF extras for metadata"
    ref: src-gs-godot-3d-import
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-skills-architecture]]"   # standards layer
  - relates-to: "[[game-studio-acceptance-criteria]]"   # reports use these formats
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Everything here is a *proposal* pending human review.


> This note is an **original design proposal** (no external source prescribes it). Details are to be fixed in the project's own production standards after review.

## Proposals
- **Isolated workspace per agent task** with explicit input/output directories; no whole-filesystem access.
- **Layout idea:** `art-src/` (Blender `.blend`, `.ptex`, `.kra`, SVG sources + generating scripts) separate from `godot/assets/` (imported, engine-facing files). Generated binaries are reproducible from `art-src/` + scripts.
- **Interchange:** prefer GLB/glTF, PNG, WAV, OGG, SVG; use specialised formats (`.blend`, `.ptex`, `.kra`) as sources only.
- **Manifest per asset** (e.g. `asset.json`): id, type, source files, generator script + tool versions, parameters/seed, licence and provenance (including model name/licence for AI-generated content), dependencies, budgets, validation report path. glTF extras can carry in-file metadata.
- **Validation report:** machine-readable (pass/fail per criterion, measured value, threshold, tool version) so failures route back to the owning department.
- **Naming:** lowercase snake_case, type prefix, version in manifest not filename; Godot node-name hints (`-col`, `-navmesh`…) are part of the Blender naming contract.
- **Versioning:** Git; pin tool versions (Godot 4.7.x, Blender 5.2 LTS) in the manifest.

## Provenance and licence extension
Assets obtained from third parties carry licence and provenance fields and a repo policy (which originals may be committed). See [[game-studio-asset-registry-and-manifest-conventions]] and [[game-studio-asset-license-and-provenance-policy]].

## See also
- [[game-studio-acceptance-criteria]] — what reports contain
- [[game-studio-skills-architecture]] — standards layer

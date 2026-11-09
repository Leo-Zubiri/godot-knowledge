---
id: game-studio-versioning-and-changelog
type: reference
domain: game-studio
status: proposed
summary: "Semantic Versioning and Keep a Changelog as written, with our interpretation of mapping SemVer to games and per-store version fields."
tags: [dept/delivery]
sources:
  - claim: "SemVer 2.0.0 and Keep a Changelog 1.1.0 rules"
    ref: src-gs-delivery-versioning-hygiene
    retrieved: 2026-11-08
  - claim: "itch.io --userversion accepts a free-form string; Google Play needs an integer versionCode"
    ref: src-gs-delivery-platforms
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-delivery-platforms-and-fees]]"   # store fields
  - relates-to: "[[godot-build-metadata-and-feature-tags]]"   # version setting inside Godot
  - relates-to: "[[game-studio-asset-registry-and-manifest-conventions]]"   # asset versions in the registry
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** official documentation as read on 2026-11-08 (paraphrased extractions by research subagents). Vendor and platform pages change quickly: re-check before acting. Fees and defaults are recorded as the page wrote them; nothing was tested here. Status `proposed`; not legal advice.


## Documented
- **SemVer 2.0.0:** MAJOR.MINOR.PATCH, no leading zeros; major for backward-incompatible public-API changes, minor for compatible additions, patch for compatible fixes; pre-release after a hyphen ranks lower; build metadata after a plus sign is ignored for precedence; `0.y.z` is initial development; 1.0.0 defines the public API.
- **Keep a Changelog 1.1.0:** for humans; latest first; types Added, Changed, Deprecated, Removed, Fixed, Security; an Unreleased section; ISO 8601 dates; yanked releases stay listed with a YANKED tag; say whether SemVer is followed.

## Interpretation (ours, not from either page)
A game has no public API, so "breaking" must be defined per project — e.g. **save-file or mod-format incompatibility**. Stores add their own fields: itch.io's `--userversion` takes any string, Google Play needs an increasing integer versionCode. Keep one source of truth for the version (e.g. a single setting) and derive store fields from it.

## Agent can / cannot
An agent can bump versions, move Unreleased entries into a dated section and validate the format. A human decides what counts as breaking.

## See also
- [[game-studio-delivery-platforms-and-fees]] — store fields
- [[godot-build-metadata-and-feature-tags]] — version setting inside Godot
- [[game-studio-asset-registry-and-manifest-conventions]] — asset versions in the registry

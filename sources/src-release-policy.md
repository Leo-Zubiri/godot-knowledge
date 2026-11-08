---
id: src-release-policy
type: source
domain: godot
source:
  url: https://docs.godotengine.org/en/4.7/about/release_policy.html
  title: "Godot release policy — Godot Engine 4.7 documentation"
  retrieved: 2026-11-06
  version: "4.7"
  capture: paraphrased
created: 2026-11-06
updated: 2026-11-06
---

> Preserved as a pinned reference to the official Godot 4.7 documentation (conventionally immutable). Full original at
> the URL.

Official page: **Release policy** (Godot 4.7).

Key points (as documented):
- Godot uses `major.minor.patch` versioning. **Minor** releases add features (without major compatibility breakage);
  **patch** (maintenance) releases are compatibility-safe bug/security fixes only — significant new features are never
  added in a patch.
- **Only the latest patch release of a given stable minor series is supported** (e.g. within the 4.7 series, support
  tracks the newest 4.7.x).
- Release cadence has been roughly every few months for minor releases, with maintenance patches in between.
- Implication for reproducibility: pin a full `major.minor.patch` and cite version-matched documentation URLs
  (`/en/4.7/…`) rather than the floating `/en/stable/` or `/en/latest/`.

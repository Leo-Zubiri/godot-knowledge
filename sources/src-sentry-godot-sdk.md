---
id: src-sentry-godot-sdk
type: source
domain: godot
source:
  url: "https://github.com/getsentry/sentry-godot"
  title: "getsentry/sentry-godot — Sentry SDK for Godot Game Engine (README + GitHub API metadata)"
  retrieved: 2026-11-08
  version: "latest release 2.4.0 as of 2026-11-08; repo not pinned to a commit SHA; last pushed 2026-11-06"
  capture: excerpt
  retrieved_via: "GitHub REST API (gh api repos/... and /readme raw) — README text is excerpted near-verbatim; repo metadata from the API"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + excerpts (conventionally immutable). **Basis:** the repository README (fetched raw via the GitHub API on 2026-11-08) plus repo metadata from the GitHub API. README fragments are quoted near-verbatim; no code was built or run. Repository state is not pinned to a commit. Re-fetch before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

**Repo metadata (GitHub API, 2026-11-08):**
- Description: "Sentry SDK for Godot Game Engine".
- Licence: **MIT** (`spdx_id: MIT`).
- Stars: 261; `archived: false`; last pushed 2026-11-06.
- Releases present: `2.4.0`, `2.3.0`, `2.2.0`, `2.1.1`, `2.1.0`, `2.0.1`, … (actively released; not a 0.x experiment).

**README excerpts:**
- Purpose: "Sentry for Godot helps you monitor your game's health during QA and after release. It provides insights into crash reports, script errors, hardware information, user feedback, attachments and more through real-time alerting and an intuitive web dashboard. With automatic error reporting, release tracking, and AI-assisted analysis, you can quickly identify, prioritize, and resolve issues…"
- Architecture: "Built as a C++ GDExtension library using mature Sentry SDKs like [sentry-native] as the foundation."
- Minimum supported Godot:

  | SDK Version | Required Godot Version |
  |---|---|
  | `1.x` and `2.x` releases | Godot 4.5 or later |
  | `0.x` releases | Godot 4.3 or later |

- Supported platforms: Windows (x86_64/x86_32/arm64), Linux (x86_64/x86_32/arm64), macOS (universal), Android (arm64/arm32/x86_64/x86_32), iOS (device + simulator), **Web** "supported in 1.4.0 and later", **C#/.NET** "supported in 2.0.0 and later", "W4 console forks: coming in 2026".
- Getting started: "Pre-built extension libraries with the demo project are available in Releases." In-editor options under `Project Settings -> Sentry -> Options`. Official docs linked at `https://docs.sentry.io/platforms/godot/`.
- **Note on Godot support:** the README states a minimum of **Godot 4.5**; this repo does not state **4.7.2** explicitly, but 4.7 > 4.5 so it is within the stated range (*interpretation*; actual 4.7.2 compatibility and stability not tested here). The *hosted* Sentry service's licensing/pricing and the *self-hosted* server's Functional Source License are a separate matter (see `src-gs-delivery-versioning-hygiene`).

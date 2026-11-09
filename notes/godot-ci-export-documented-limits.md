---
id: godot-ci-export-documented-limits
type: concept
domain: godot
status: proposed
summary: "What Godot documents about command-line export and CI (three export flags, preset must exist, credentials via environment) and what is NOT documented (templates in CI, exit codes, patch export) — so agents do not invent a workflow."
tags: [dept/delivery, dept/qa, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Command-line export section and absence of a CI page in the Godot 4.7 export index"
    ref: src-gd-export-and-platforms
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-export-fundamentals]]"   # presets and templates
  - relates-to: "[[game-studio-godot-integration]]"   # CLI flags and headless limits
  - relates-to: "[[game-studio-acceptance-criteria]]"   # export validation
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7* per research subagent, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine or a build: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


## Documented
`--export-release`, `--export-debug` and `--export-pack` with a preset name and output path; the preset must already exist; quote preset names with spaces; `--path` runs outside the project folder. Secrets can come from environment variables (keystore paths/passwords, encryption key, macOS certificates). The earlier-preserved CLI tutorial says `--headless` is required for export on GPU-less CI ([[game-studio-godot-integration]]).

## Not documented on the pages read (do not invent)
A CI or GitHub Actions page; how CI runners obtain **export templates** or match their version to the engine; exit codes; `--export-patch`; a console statement; texture-compression setting names for per-platform builds.

## Implication
An agent should treat any CI export recipe as a **proposal to be tested**, record the exact Godot and template versions, and never present it as official guidance.

## What an agent can and cannot check
By reading files: that the preset list matches the CLI calls and secrets come from environment variables. Needs a runner: that the export succeeds and template and engine versions agree.

## See also
- [[godot-export-fundamentals]] — presets and templates
- [[game-studio-acceptance-criteria]] — export validation

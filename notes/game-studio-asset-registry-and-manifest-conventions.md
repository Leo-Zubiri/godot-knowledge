---
id: game-studio-asset-registry-and-manifest-conventions
type: reference
domain: game-studio
status: proposed
summary: "Lightweight asset registry design: plain-text records per asset with licence evidence, permissions and usage, supporting audits, attribution generation and replacement; no database."
tags: [dept/assets]
sources:
  - claim: "Per-asset vs provider-wide licensing and the redistribution/AI restrictions the registry must record"
    ref: src-gs-asset-marketplaces
    retrieved: 2026-11-08
  - claim: "Licence evidence changes over time (version at download date; terms changeable)"
    ref: src-gs-asset-audio
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-release-credits-and-ratings]]"   # credits generated from the registry
  - depends-on: "[[game-studio-asset-conventions]]"   # extends the existing manifest proposal
  - relates-to: "[[game-studio-asset-license-and-provenance-policy]]"   # fields encode the seven permissions
  - relates-to: "[[game-studio-asset-discovery-and-reuse-workflow]]"   # written at step 10
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research dated 2026-11-08 from official provider pages (paraphrased extractions, not verbatim legal text); no asset was downloaded and nothing was executed. **Not legal advice.** Terms change; items marked `unverified` were not read on an official page. Classes and workflows are *proposals* pending human review; ambiguous cases must go to a human.


> Design proposal; no database or asset-management platform is justified by the research so far.

## Form
One text record per asset (YAML/JSON next to the asset) or a single registry file in version control, plus a **generated** credits/attribution file. Reuses the manifest in [[game-studio-asset-conventions]]; these fields add provenance and licence.

## Fields
| Group | Fields |
|---|---|
| Identity | `asset_id`, `asset_type`, `original_filename`, `format`, `author` |
| Source | `source_name`, `source_url`, `downloaded_at`, `verified_at` |
| Licence | `license`, `license_version`, `license_scope` (provider / asset / pack), `license_evidence_url`, `license_snapshot` (path), `commercial_use`, `modifications_allowed`, `redistribution_allowed` (**original files**), `attribution_required`, `attribution_text`, `sharing_with_collaborators`, `ai_use_restriction` |
| Governance | `human_approved_by`, `approved_at`, `repo_policy` (commit original / reference only), `replacement_of` |
| Use | `project_usage`, `validation_status`, `modified_from` |

## Uses
Traceability, licence audits, attribution generation, update checks (re-verify `verified_at`), and replacement when a licence or source becomes problematic (query by `source_name`/`license`).

## Caveat
`redistribution_allowed` must mean redistribution of the original files, separate from `commercial_use`. Unknown values stay `unknown` (never default to permissive).

## See also
- [[game-studio-asset-conventions]] — workspace layout and base manifest
- [[game-studio-asset-license-and-provenance-policy]] — fields encode the seven permissions
- [[game-studio-asset-discovery-and-reuse-workflow]] — written at step 10
- [[game-studio-release-credits-and-ratings]] — credits generated from the registry

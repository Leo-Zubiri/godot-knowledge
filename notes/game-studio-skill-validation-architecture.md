---
id: game-studio-skill-validation-architecture
type: reference
domain: agent-ops
status: proposed
summary: Layers of automated skill validation (structure, links, budgets, generated-file currency, self-test) and what a passing validator does not prove.
tags: [scope/reference-study, dept/qa]
sources:
  - claim: "Validator layers, size budgets, parity markers, safety scanner, API denylist, and what is absent"
    ref: src-gs-gp-validation-ci
    retrieved: 2026-11-08
  - claim: "CI jobs: validator, tests, self-test on broken fixtures, Windows hook tests"
    ref: src-gs-gp-validation-ci
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-readiness-classification]]"   # readiness flags distinguish available from production-ready
  - relates-to: "[[game-studio-godot-example-verification]]"   # the gap the validator leaves open
  - relates-to: "[[game-studio-framework-churn-risk]]"   # tests as a response to churn
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (GodotPrompter, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale is *proposal*, pending human review.


## Layers observed (validator + CI, documented/read from script)
| Layer | Present | Notes |
|---|---|---|
| Frontmatter | yes | name/description required; name = folder |
| Cross-references | yes (errors) | related names and "see X skill" must resolve; orphan references warned |
| Size/token budgets | yes | 16 KB error cap; card <3 KB; a separate script reports bytes/tokens (not run in CI) |
| Parity rule | warnings | GDScript without C# warns; allowlist; opt-out marker **requires a reason** |
| Generated-file currency | `--check` modes | skill index, Codex mirrors, platform metadata (whether CI runs all is unconfirmed) |
| Safety scanner | yes | flags risky approval/sandbox strings |
| API correctness | minimal | denylist of known-nonexistent APIs, not a check against the engine |
| Self-test | yes | validator must reject deliberately broken fixtures, or CI fails |
| Hook tests | yes | Ubuntu + Windows |
| Compile/parse examples | **no** | no Godot or dotnet invocation in the validator |
| Agent behaviour | partial | manual plan + evals ([[game-studio-skill-eval-design]]) |
| End-to-end implementation | none | nothing builds or runs a game feature |

## Five different questions (keep separate)
Syntactic validity · API correctness · documentation quality · agent behaviour · end-to-end implementation quality. A green validator answers only the first and part of the second; it is **not** evidence an agent can implement a complete feature.

## Reusable in principle (proposal; classifications in [[game-studio-gp-reference-comparison]])
frontmatter and link checks, size budgets, reasoned exemption markers, generated-artifact check modes, **self-test on broken fixtures** (stops silently disabled rules), dangerous-string scanner. Repo-specific: card regions, C# parity rules, marketplace/version-bump scripts.

## See also
- [[game-studio-godot-example-verification]] — closing the compile/parse gap
- [[game-studio-readiness-classification]] — readiness flags distinguish available from production-ready
- [[game-studio-framework-churn-risk]] — tests as a response to churn

---
id: src-gs-gp-validation-ci
type: source
domain: agent-ops
source:
  url: "https://github.com/jame581/GodotPrompter/blob/master/scripts/README.md"
  urls:
    - "https://github.com/jame581/GodotPrompter/blob/master/scripts/README.md"
    - "https://github.com/jame581/GodotPrompter/blob/master/.github/workflows/validate.yml"
    - "https://github.com/jame581/GodotPrompter/blob/master/.github/workflows/release.yml"
    - "https://github.com/jame581/GodotPrompter/blob/master/scripts/validate-skills.mjs"
  title: "GodotPrompter validation scripts and CI workflows"
  retrieved: 2026-11-08
  version: "master@d7b26cd"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** files fetched on 2026-11-08 from the `master` branch (HEAD verified via GitHub API at retrieval: `d7b26cdb5fae14d4ef7b713c5bf259395e75c3c6`, committed 2026-10-24; fetch was by branch name) and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. A *reference architecture* studied for patterns only; nothing copied, not a dependency. Statements are documented (D) or project-reported (P); none tested by us. Re-fetch before promoting dependent notes to `verified`.

- **Scripts (scripts/README, D):** `validate-skills.mjs` checks `skills/*/SKILL.md` and `agents/*.md` for structure and resolvable cross-references, text or `--json` output, exit 1 on errors not warnings; `generate-skill-index.mjs` (`--write` / `--check`); `sync-codex-agents.mjs` (`--write` / `--check`); `validate-platform-metadata.mjs` (host smoke matrix covers every host and points only to existing files); `count-tokens.mjs` (bytes and token costs; optional Claude/GPT tokenizers; `--markdown`, `--json`; not run in CI); `bump-version.mjs` (five manifests; no check mode); `build-directory-bundle.mjs` (plugin-only tree for a 512-file directory limit; `--check`); `sync-marketplace-readme.mjs`; shared `lib/frontmatter.mjs` frontmatter parser with its own tests. The page does not say whether CI runs the other scripts' `--check` modes.
- **Validator layers (read by the research agent from the script, T):** frontmatter (name/description required, name = folder; same for agents); cross-reference errors ("Related skills" names and "see X skill" phrases; agent-referenced skill paths must exist); size (error >16 KB, warn ≈15.5 KB; session/mentor card regions <3 KB); structure warnings; C# parity warnings (allowlist of four skills; reasoned opt-out markers, a marker without a reason is an error); orphan-reference warning; **API correctness only via a denylist** of known-nonexistent GDScript APIs (e.g. `Signal.any`/`Signal.all`) and C#-only `ToSignal` in gdscript fences — not a check against the engine API; a safety scanner for risky approval/sandbox strings (e.g. `danger-full-access`) in md/json/yaml/toml. **Not present:** invoking Godot or dotnet to parse/compile examples; contradiction detection; any end-to-end feature test.
- **validate.yml (D):** triggers on pushes to master and every PR; read-only permissions; job 1 (ubuntu, 10 min): checkout, Node 26, no dependency install (stdlib only), run validator, `npm test` (hook and validator suites, auto-discovered), then a **self-test** — the validator must reject deliberately broken fixtures, else the step fails ("rules not enforced"); job 2 (windows, 10 min): hook tests only, for the polyglot wrapper/Git for Windows, line endings, path canonicalization.
- **release.yml (D):** on tags `v*.*.*`; jobs: verify (tag matches version in every manifest; validator, hook, validator and metadata tests; self-test) → release (changelog section required; GitHub release marked latest) and directory-bundle (trimmed plugin bundle committed to a `plugin-bundle` branch) → marketplace PRs (skipped with a warning if the token secret is missing; failure does not fail the release).
- **Hook tests / opencode tests / agent-integration:** exist as directories (contents not read, unverified). `plugin-scan.yml` not read.

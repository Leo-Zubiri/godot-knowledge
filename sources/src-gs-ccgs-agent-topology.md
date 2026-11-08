---
id: src-gs-ccgs-agent-topology
type: source
domain: game-studio
source:
  url: "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/docs/coordination-rules.md"
  urls:
    - "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/docs/coordination-rules.md"
    - "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/docs/model-tiers.md"
  title: "CCGS coordination rules and model tiers"
  retrieved: 2026-11-08
  version: "v1.2.0; main@05ad7c8"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** the files were fetched on 2026-11-08 from the `main` branch (HEAD at retrieval: `05ad7c8a5b8aa2aa86bbd3439ae7cf7295cac418`, committed 2026-10-19; the fetch itself was by branch name, so the pin is the HEAD observed shortly after) and summarized by a fetch-time summarizer: a **paraphrased extraction, not verbatim text**. This is a *reference architecture* studied for patterns; nothing is copied and the repo is not a dependency. Statements are **documented (D)** in the repo or **project-reported (P)**; none were tested by us. Re-fetch before promoting dependent notes to `verified`.

- **Coordination (D):** work flows down a chain of command (leadership → department leads → specialists), no tier skipped for complex decisions. Same-level agents may consult each other but cannot make binding decisions outside their domain. Disputes go to the shared parent; with none, design disputes → creative-director, technical disputes → technical-director. Cross-domain design changes are coordinated by the producer agent.
- **Model tiers (D):** of 49 agents, 30 inherit the session model and 19 are pinned: Opus ×3 (creative-director, producer, technical-director), Sonnet ×16 (lead-programmer, prototyper, devops-engineer, community-manager and 12 engine sub-specialists across Godot/Unreal/Unity), Haiku ×0 (reserved for read-only lookups/formatting). Rationale: Opus for judgment-heavy direction, Sonnet for implementation/specialists.
- **Subagent isolation (D):** a subagent starts from its brief, not the parent's conversation, so the brief must carry all context. Pinned agents get their own model's window regardless of session model; an env var forces all subagents onto the session model (Claude Code ≥ 2.1.257) and also changes the Opus directors. Skill `model:` overrides apply only in some invocation modes (e.g. a Haiku skill saves nothing in auto mode or when Claude invokes it); overrides end at the next prompt. Cost guidance is qualitative; no measured figures.
- All Claude-Code-specific mechanisms; portability to Codex/OpenCode unverified.

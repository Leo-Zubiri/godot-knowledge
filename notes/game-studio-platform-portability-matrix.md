---
id: game-studio-platform-portability-matrix
type: reference
domain: agent-ops
status: proposed
summary: "How to record per-agent-platform support honestly: verified / documented / registration incomplete / unsupported, with results recorded rather than only checks defined."
tags: [scope/reference-study, dept/orchestration]
sources:
  - claim: "Seven-host smoke matrix with status labels and no recorded results; one pre-release run of 3 subagents"
    ref: src-gs-gp-platforms-and-hooks
    retrieved: 2026-11-08
  - claim: "README platform claims and hook availability per host"
    ref: src-gs-gp-repo-overview
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-agent-orchestration]]"   # AGENTS.md/SKILL.md portability facts
  - relates-to: "[[game-studio-readiness-classification]]"   # evidence-based flags
  - relates-to: "[[game-studio-skill-validation-architecture]]"   # metadata checks
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (GodotPrompter, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale is *proposal*, pending human review.


## Status vocabulary (proposal, from the reference's practice)
**end-to-end verified** · **documented, not verified** · **registration available, end-to-end pending** · **unsupported/unclear**. A status needs a *result record* (date, host version, outcome), not just defined checks.

## What the reference shows
| Host | Label in its matrix | Our reading |
|---|---|---|
| Claude Code | Verified | label only; matrix itself records no results; one dated subagent run (3/3, description discovery, pre-release) |
| Copilot CLI | Verified | not independently examined |
| Cursor | registration ships; e2e pending | incomplete |
| Codex | Documented | symlink to `~/.agents/skills`, restart, no hooks mentioned |
| OpenCode | Documented | plugin via git URL, pin with a tag; restart does not update; cache can serve stale code |
| Antigravity, Grok Build | Documented | not verified |
| Gemini | only an instructions file seen | unclear |

## Portable vs host-specific
Portable: standard `SKILL.md` folders, AGENTS.md, Markdown agents, generated TOML mirrors, JSON index. Host-specific: SessionStart hook (and its variants), marketplace manifests, tool-name mapping (OpenCode).

## Update behaviour
Codex via `git pull` through a symlink (silent updates); OpenCode pinned by tag (explicit) but cached; Claude via marketplace. Explicit pinned updates fit our preference; unpinned symlinks do not.

## For us (proposal)
Keep a matrix for Claude Code, Codex and OpenCode with **dated result entries** and a pinned version per entry; do not claim a platform verified without a record.

## See also
- [[game-studio-agent-orchestration]] — shared instruction base
- [[game-studio-readiness-classification]] — evidence-based flags
- [[game-studio-skill-validation-architecture]] — metadata checks

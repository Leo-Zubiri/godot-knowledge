---
id: gs-adr-mcp-optional
type: decision
domain: game-studio
status: proposed
summary: "Proposed: the architecture must not depend on MCP; CLI/scripts are the foundation and MCP is optional."
tags: [dept/orchestration]
sources:
  - claim: "MCP servers for Godot differ widely in editor need, runtime tools and releases"
    ref: src-gs-godot-mcp-servers
    retrieved: 2026-11-08
  - claim: "Blender MCP is GUI-bound"
    ref: src-gs-blender-mcp
    retrieved: 2026-11-08
  - claim: "ComfyUI MCP servers are Beta/community"
    ref: src-gs-comfyui-mcp
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-readiness-classification]]"   # integration preference order
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Context
Many MCP servers exist but are young, run arbitrary code, often need a live GUI/editor/browser, and most lack tagged releases.

## Decision
CLI and scripting (Godot CLI, bpy scripts, ComfyUI HTTP API) are the foundation; MCP is used only where it adds clear value (e.g. Godot runtime screenshot/input via a pinned server) inside a sandbox.

## Consequences
Reproducible, CI-friendly runs; slightly less interactive exploration; MCP servers must be pinned by commit and sandboxed.

## See also
- [[game-studio-architecture-proposal]] — overall proposal
- [[game-studio-readiness-classification]] — integration preference order

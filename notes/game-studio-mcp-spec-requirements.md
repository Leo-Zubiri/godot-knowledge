---
id: game-studio-mcp-spec-requirements
type: reference
domain: game-studio
status: proposed
summary: "What the MCP specification (schema 2026-07-28) requires versus leaves to hosts: primitives, transports, optional authorization, human-in-the-loop, untrusted tool annotations, no protocol-level security."
tags: [dept/orchestration]
sources:
  - claim: "MCP specification pages: primitives, transports, authorization, tools, elicitation"
    ref: src-gs-agent-ops-mcp-spec
    retrieved: 2026-11-08
related:
  - relates-to: "[[gs-adr-mcp-optional]]"   # MCP is optional in our architecture
  - relates-to: "[[game-studio-path-scoped-safety]]"   # host-side controls
  - relates-to: "[[game-studio-untrusted-content-and-headless-runs]]"   # consent and trust prompts
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** official documentation as read on 2026-11-08 (paraphrased extractions by research subagents). Vendor and platform pages change quickly: re-check before acting. Fees and defaults are recorded as the page wrote them; nothing was tested here. Status `proposed`; not legal advice.


- **Primitives:** servers offer Resources, Prompts, Tools; clients offer Elicitation; JSON-RPC 2.0; requests are stateless with per-request capability negotiation (older revisions used an `initialize` handshake, so servers built for them need a compatibility path); optional extensions Tasks, Skills over MCP, MCP Apps.
- **Transports:** stdio (client-launched subprocess) and Streamable HTTP; custom transports allowed.
- **Authorization:** optional; for HTTP it SHOULD follow the spec (OAuth 2.1 draft, protected-resource metadata, resource indicators, PKCE, audience-bound tokens); stdio servers SHOULD NOT use it and take credentials from the environment; tokens must not be in the query string; servers MUST NOT accept tokens issued for other resources.
- **Security statement:** the protocol **cannot enforce** its security principles; tools are arbitrary code execution; hosts must obtain consent before invoking tools; there SHOULD be a human in the loop who can deny invocations.
- **Tool annotations are untrusted unless they come from a trusted server (MUST).** Servers MUST validate inputs, access-control, rate-limit and sanitise outputs; clients SHOULD show inputs, validate results, time out calls and **log tool usage for audit**; servers SHOULD return tools in deterministic order to help prompt caching.
- **Elicitation:** form and URL modes; form mode MUST NOT ask for passwords, API keys or tokens; clients MUST show which server asks.
- Unverified: annotation field names, roots, transport security (Origin/localhost) notes — not on the pages read.

## Consequence for us
Community Blender/Godot MCP servers that run arbitrary code can be spec-compliant while having **no protocol-level guard**; safety depends on the host's permission and sandbox controls ([[game-studio-agent-permission-controls]]).

## See also
- [[gs-adr-mcp-optional]] — MCP is optional in our architecture
- [[game-studio-path-scoped-safety]] — host-side controls
- [[game-studio-untrusted-content-and-headless-runs]] — consent and trust prompts

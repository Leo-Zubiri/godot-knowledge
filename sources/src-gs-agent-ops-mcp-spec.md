---
id: src-gs-agent-ops-mcp-spec
type: source
domain: game-studio
source:
  url: "https://modelcontextprotocol.io/specification/latest"
  urls:
    - "https://modelcontextprotocol.io/specification/latest"
    - "https://modelcontextprotocol.io/specification/latest/basic/authorization"
    - "https://modelcontextprotocol.io/specification/latest/basic/transports"
    - "https://modelcontextprotocol.io/specification/latest/server/tools"
    - "https://modelcontextprotocol.io/specification/latest/client/elicitation"
  title: "Model Context Protocol specification (schema 2026-07-28): primitives, transports, authorization, tools, elicitation"
  retrieved: 2026-11-08
  version: "spec page says based on schema 2026-07-28"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official pages fetched on 2026-11-08 by research subagents and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**; not re-read by the main agent. Fees, prices, shares, deadlines and product defaults are recorded *only as the page wrote them on that date* and change; items marked UNV/unverified were not read on an official page (404, blocked, search-snippet only). Not legal advice. Re-fetch before promoting dependent notes to `verified`.

- **Primitives:** servers offer Resources, Prompts and Tools; clients offer Elicitation; JSON-RPC 2.0; requests are stateless and self-contained with per-request capability negotiation (earlier revisions used an `initialize` handshake; servers built for older revisions need a compatibility path, per the transports page); optional extensions Tasks, Skills over MCP, MCP Apps.
- **Transports:** stdio (client-launched subprocess) and Streamable HTTP (HTTP POST, JSON or SSE replies); custom transports allowed; Origin/localhost-binding security notes not seen on the page read (UNV).
- **Authorization:** optional; for HTTP transports it SHOULD follow the spec (OAuth 2.1 draft, protected-resource metadata, resource indicators, PKCE, audience-bound tokens); stdio servers SHOULD NOT use it and take credentials from the environment; tokens must not go in the query string; servers MUST NOT accept tokens issued for other resources.
- **Security statement:** MCP itself cannot enforce its security principles at the protocol level; principles: explicit user consent, tools are arbitrary code execution, hosts must obtain consent before invoking any tool.
- **Tools:** there SHOULD always be a human in the loop who can deny invocations; **tool annotations are untrusted unless they come from a trusted server** (MUST); servers MUST validate inputs, access-control, rate-limit and sanitise outputs; clients SHOULD show inputs, validate results, time out calls and log tool usage for audit; servers SHOULD return tools in deterministic order so clients can cache and improve prompt-cache hit rates. Annotations are described only as optional properties of tool behaviour (read-only/destructive hint names not seen on the fetched text, UNV).
- **Elicitation:** form mode and URL mode; form mode MUST NOT ask for passwords, API keys or tokens; clients MUST show which server asks and let users decline. Roots: not seen (UNV).

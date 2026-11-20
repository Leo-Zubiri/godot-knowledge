---
id: godot-lan-chat-host-validated-quick-phrases-as-keys
type: pattern
domain: godot
status: unreviewed
summary: "Small-game LAN chat that stays safe: the client only REQUESTS; the host derives the seat from the sending peer (never from the packet), sanitizes the text, rate-limits per seat and rebroadcasts; clients apply the host's message without their own anti-spam (otherwise they drop what the host accepted). Quick phrases travel as TRANSLATION KEYS so every peer reads them in its own language, and a client may not send SYSTEM messages or keys outside the allowed list. Keep the transport injectable (callables) so host and client can be tested connected in memory. A pure `ChatLog` (sanitize, throttle, bounded history) is reusable."
aliases: [lan chat, host authoritative chat, quick phrases, chat anti spam, chat transport callable]
tags: [dept/engineering, scope/networking]
applies-to:
  min: "Godot 4.0"
  tested: "Ginomo: GnChatLog + GnPoolChat with replicator channel; tests with simulated host and client"
sources: []
related:
  - relates-to: "[[godot-lan-host-authoritative-turn-based]]"
created: 2026-11-20
updated: 2026-11-20
created_by_type: agent
---

> **Evidence status — `unreviewed`.** Built and tested in Ginomo (Godot 4.7.2, headless gdUnit4 + xvfb screenshots); not checked against engine source.

## Rules that mattered
1. Seat from the peer: `seat_of(sender)`; ignore a declared `seat`.
2. Validate shape (`text` String, `kind` int in {TEXT, QUICK}); QUICK text must be one of the known keys.
3. Throttle on the host only; clients use a trusted append.
4. Typing blocks game input with a flag read by the input handlers (Input actions are global: a focused LineEdit does not stop `Input.is_action_pressed`).
5. Bubbles over the speaker (`Label3D` billboard, `no_depth_test`) + a fading log; a touch button replaces the key.
6. CPU "chatter": probability + minimum gap, only for CPU seats, reacting to pocket/foul/hit events.

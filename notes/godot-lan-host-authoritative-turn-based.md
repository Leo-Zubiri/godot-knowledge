---
id: godot-lan-host-authoritative-turn-based
type: pattern
domain: godot
status: proposed
summary: "Host-authoritative LAN multiplayer in Godot 4.7: clients send intent through any_peer RPCs, the host (peer 1) simulates and replicates state with MultiplayerSynchronizer/Spawner or snapshot RPCs, lobbies are found by UDP broadcast with join-by-IP fallback; turn-based specifics and Android caveats."
aliases: [server authoritative, host authoritative, LAN discovery, UDP broadcast, ENet, turn-based multiplayer, RPC intent]
tags: [dept/game-dev, tool/godot]
applies-to:
  min: "4.0 (MultiplayerSynchronizer/Spawner and @rpc are 4.x API)"
  tested: "4.7 (documentation only; not run in the engine or on a network)"
sources:
  - claim: "High-level multiplayer model, @rpc semantics, security guidance, ENet, Synchronizer/Spawner/ReplicationConfig and PacketPeerUDP broadcast rules for Godot 4.7"
    ref: src-gd-high-level-multiplayer-udp
    retrieved: 2026-11-08
  - claim: "Godot's physics does not guarantee repeatable outcomes, so simulation must run on one peer"
    ref: src-gd-physics
    retrieved: 2026-11-08
related:
  - depends-on: "[[godot-physics-bodies-layers-and-interpolation]]"   # non-deterministic physics is why only the host simulates
  - relates-to: "[[godot-scene-scoped-lookups]]"   # RPC nodes need identical, readable node paths on all peers
  - relates-to: "[[godot-export-platform-notes]]"   # Android export preset where the INTERNET permission lives
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** API facts come from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited sources). The assembly of those facts into a turn-based LAN pattern is **our design interpretation**, marked *(pattern)*. Nothing was run in the engine or on a network. Status `proposed`.

## Problem
A small group on one Wi-Fi network wants to play a turn-based game where each turn resolves through physics or other simulation. Godot's physics is documented as **not repeatable**, so running the simulation on every peer and hoping the results match is unsafe; and the docs say to treat all client input as untrusted and keep the server authoritative for outcomes.

## Solution *(pattern)*
**Roles.** One device hosts (`ENetMultiplayerPeer.create_server(port, max_clients)`; its peer ID is always **1**) and also plays; the others join (`create_client(ip, port)`). Both assign the peer to `multiplayer.multiplayer_peer`. The host is the **multiplayer authority** of every gameplay node (the default).

**Intent up, state down.**
1. Clients never move the simulation. They call an intent RPC on the host:
   ```gdscript
   @rpc("any_peer", "call_remote", "reliable")
   func submit_intent(turn_id: int, intent: Dictionary) -> void:
       if not multiplayer.is_server(): return
       var sender := multiplayer.get_remote_sender_id()
       if sender != _active_player_peer or turn_id != _turn: return   # validate who and when
       _apply_intent(intent)                                            # host simulates
   ```
   `any_peer` is required because the default `authority` mode would reject calls from clients. Validate the sender, the turn number and the argument ranges — RPC arguments are not type-checked by the engine.
2. The host runs the simulation (physics, dice, resolution) in `_physics_process` on its own tree only.
3. The host replicates results:
   - **Continuous state** (positions while a shot is resolving): `MultiplayerSynchronizer` with a `SceneReplicationConfig`; use `REPLICATION_MODE_ALWAYS` (unreliable, every network frame or `replication_interval`) for transforms and `REPLICATION_MODE_ON_CHANGE` (reliable) for scores, turn index, phase. Object-typed properties (Resources) cannot be synced — replicate IDs and look them up.
   - **Dynamic objects** (spawned pieces, projectiles): `MultiplayerSpawner` with `spawn_path` set to their parent and the scenes registered via `add_spawnable_scene()`; only the authority adds children, remote peers get `spawned`.
   - **Turn results** (final rest positions, who scored): one `@rpc("authority", "call_local", "reliable") func turn_resolved(turn_id, snapshot: Dictionary)` sent with `.rpc()` — `call_local` so the host runs the same handler as everyone else.
4. Clients may **predict visually** (ghost preview of the intended action) but always snap to host state on `turn_resolved`.

**Turn-based specifics.** Keep a single `_turn: int` and `_active_player_peer: int` on the host, replicated ON_CHANGE; reject intents that do not match; make the host wait for `player_loaded`-style readiness RPCs before starting (the official lobby example counts them with `rpc_id(1)`); when `peer_disconnected` fires for the active player, the host skips or pauses the turn — a client cannot decide this. Because turns are infrequent, reliable channels and a one-snapshot-per-turn RPC are usually enough; synchronizers only matter while an animation of the resolution is being watched.

**Node paths.** RPCs resolve by `NodePath`, so the scene layout must be identical on all peers and dynamic nodes must be added with `add_child(node, true)` (readable names). See [[godot-scene-scoped-lookups]].

**LAN discovery.** Godot has no lobby-discovery API; build one with `PacketPeerUDP`:
- Host: `bind(DISCOVERY_PORT)`; on each incoming packet reply with `{name, port, players}` to `get_packet_ip()`/`get_packet_port()`.
- Client: `set_broadcast_enabled(true)` **before** `set_dest_address("255.255.255.255", DISCOVERY_PORT)`, send a probe every second, list replies, then `create_client(reply_ip, reply_port)`.
- Always offer **join by IP** as the fallback: broadcast can be blocked by client isolation on guest Wi-Fi, by some Android devices, or by a firewall; the docs say LAN clients use the host's internal 192.168.x.x address.
- Use a different port for discovery than for ENet. Never call `PacketPeerUDP.wait()` on the main thread — it cannot be interrupted.

## Trade-offs
- **Host advantage:** the host sees state first and never waits on the network; acceptable for turn-based play, not for twitch games.
- **Host migration** is not provided; if the host leaves, the session ends unless you build re-hosting (not covered by the docs).
- **Cheating** is limited to what the host allows; the host itself is trusted by design.
- **Bandwidth** is trivial for turn snapshots; only live resolution animations need `ALWAYS` replication.
- **Authentication** (`auth_callback`, `send_auth`, `complete_auth`) is optional on a LAN but is the documented hook for passwords/room codes.

## Android caveats (documented, *unverified in practice*)
- The export preset must enable the `INTERNET` permission or all networking is blocked.
- Broadcast/multicast may additionally need `CHANGE_WIFI_MULTICAST_STATE`, and receiving broadcasts may require `set_broadcast_enabled(true)` on the receiver too. Whether discovery works on a given phone/router was not tested — keep join-by-IP.
- Exported Android builds use feature-tag settings; see [[godot-export-platform-notes]] for the preset itself.

## See also
- [[godot-physics-bodies-layers-and-interpolation]] — non-deterministic physics is why only the host simulates
- [[godot-scene-scoped-lookups]] — RPC nodes need identical, readable node paths on all peers
- [[godot-export-platform-notes]] — Android export preset where the INTERNET permission lives

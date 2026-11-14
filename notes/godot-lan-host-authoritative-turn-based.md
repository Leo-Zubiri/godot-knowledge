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
  tested: "4.7.2.stable.mono: ENet host+client, RPC, UDP broadcast discovery and a full mirrored turn-based game run on one PC (loopback and the real LAN address, two processes); NOT tested on Android or between two devices"
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
  - relates-to: "[[game-studio-multiplayer-observability-and-session-monitoring]]"   # the host is the authoritative source that emits the monitored session/match events
created: 2026-11-08
updated: 2026-11-13
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
- Host: `bind(DISCOVERY_PORT)`; on each incoming packet reply with `{name, port, players}` to `get_packet_ip()`/`get_packet_port()`. (A simpler variant, verified: the host *announces* by broadcast and the finder only listens; see "Verified hands-on".)
- Client: `set_broadcast_enabled(true)` **before** `set_dest_address("255.255.255.255", DISCOVERY_PORT)`, send a probe every second, list replies, then `create_client(reply_ip, reply_port)`.
- Always offer **join by IP** as the fallback: broadcast can be blocked by client isolation on guest Wi-Fi, by some Android devices, or by a firewall; the docs say LAN clients use the host's internal 192.168.x.x address.
- Use a different port for discovery than for ENet. Never call `PacketPeerUDP.wait()` on the main thread — it cannot be interrupted.

## Verified hands-on (Godot 4.7.2, desktop; proposed, unreviewed)
Built and run: a 2-player turn-based game with a host-authoritative mirror. What held, and the corrections to the sketch above:
- **Host and client in ONE process (for tests):** give each its own `SceneMultiplayer` for its node subtree: `get_tree().set_multiplayer(SceneMultiplayer.new(), node.get_path())`, then `create_server` / `create_client("127.0.0.1", port)` and read `multiplayer` from nodes under each root. RPCs flow both ways, so network code runs in the normal headless test suite with real ENet. Put every RPC node (relay, replicator) as a **child of the session node** so it shares that `multiplayer`; use different loopback ports per test.
- **Two games in one process need separate 3D worlds:** put each in a `SubViewport` with `own_world_3d = true`; the physics spaces are then different (checked: shooting in A left B untouched). `viewport.world_3d` was null for a child of a SubViewport; use `find_world_3d()`.
- **Timing quirks:** right after the client's `connected_to_server`, the server's `multiplayer.get_peers()` can still be empty; wait for `peer_connected` before `rpc_id`. `rpc_id` to a peer whose receiving node does not exist yet fails, so use the readiness handshake the sketch mentions: the client sends a "ready" request once its replica node exists and the host only sends to ready peers.
- **Never trust the seat the client declares:** the host sets `intent.seat_index` from the **sender peer** (`get_remote_sender_id()` → seat map) and validates the packet shape (types are not checked by the engine) before handing it to the simulation.
- **Client = mirror, not a second simulation:** the host sends a full state dictionary (phase, active player, groups, remaining pieces, winner) on each FSM change; the client applies it and emits the same signals, so the HUD and the input code do not care whether they run local or networked. Client physics bodies are frozen kinematic with `collision_layer = 0` and moved from snapshots.
- **Snapshots:** while pieces roll, an `unreliable_ordered` stream at ~20 Hz carries only the bodies that moved (`[id, pos(3), quat(4)]` floats in a `PackedFloat32Array`); a **reliable full snapshot** at rest is the truth. The client renders ≈ 2 snapshot periods in the past and interpolates between the last two samples (lerp/slerp, no extrapolation). Measured on 16 rigid bodies: **≈ 45–55 KB per break**.
- **UDP discovery recipe that worked:** the announcer is an *unbound* `PacketPeerUDP` with `set_broadcast_enabled(true)` then `set_dest_address(broadcast_ip, discovery_port)`, sending JSON every second; the finder `bind(discovery_port)` and polls `get_available_packet_count()` in `_process`. `255.255.255.255` worked on the real LAN address (Linux desktop, same machine); tests use `127.0.0.1`. **`get_packet_ip()` returns `""` unless called after `get_packet()`.** `JSON.parse_string` prints an engine ERROR on every non-JSON packet; use `JSON.new().parse()` and check the return code.
- **Still unverified:** Android (INTERNET permission, whether broadcast arrives), a second physical device, Wi-Fi with client isolation, reconnection.

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
- [[game-studio-multiplayer-observability-and-session-monitoring]] — the host is the authoritative source that emits the monitored session/match events

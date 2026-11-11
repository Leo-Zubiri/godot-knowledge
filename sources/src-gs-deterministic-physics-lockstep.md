---
id: src-gs-deterministic-physics-lockstep
type: source
kind: web-paraphrase
domain: game-studio
retrieved: 2026-11-10
method: "web search + result summaries of Gaffer on Games articles and forum/vendor posts; not full-page fetches"
---

# Source — Deterministic physics for lockstep networking (paraphrased)

Gathered by web search 2026-11-10; Gaffer on Games articles are the authoritative items but were read as summaries
(`paraphrased`). Vendor performance claims are **unverified**.

- **Float determinism is hard (Gaffer, *Floating Point Determinism*):** floating-point results can **differ between
  compilers, OSes, instruction sets, and even debug vs release builds**. Keeping bit-exact determinism needs **pinned
  FPU settings and a restricted set of float operations**, which **costs float performance**.
- **Why lockstep wants it (Gaffer, *Deterministic Lockstep*):** send **inputs only** ⇒ bandwidth scales with input
  size, not object count; but **every client must stay bit-identical** and the sim **waits on the slowest player's
  input**.
- **Fixed-point / integer route:** RTS lockstep layers move to **integer/fixed-point** physics to avoid float drift
  (Unity forum). **GGPhys** (Unity asset) claims full cross-platform determinism via fixed-point math (vendor figure
  ~1100–1200 collisions < 10 ms on an i7-8700K — *unverified*).
- **Determinism-from-day-one** custom engines exist (dev.to C++20 engine; `amari` Rust crate uses deterministic f32 for
  lockstep + rollback) — illustrates that **determinism is a design-time property, painful to retrofit**.

**Takeaway (interpretation):** bit-exact float determinism across machines is the hard part; the common routes are
**fixed-point/integer math** or **one locked toolchain+platform**. A generic 3D engine (Jolt/PhysX/Bullet) is typically
**not** cross-platform deterministic, so netcode either avoids lockstep (host-authoritative + snapshots) or uses a
custom deterministic sim.

## Sources
- https://gafferongames.com/post/floating_point_determinism — why float determinism is hard
- https://gafferongames.com/post/deterministic_lockstep — lockstep: inputs only, bit-identical clients
- https://new.gafferongames.com/post/introduction_to_networked_physics/ — networked physics overview
- https://discussions.unity.com/t/ggphys-100-cross-platform-deterministic-3d-rigid-body-physics-engine-822407/822407 — fixed-point deterministic engine (vendor claims)
- https://dev.to/bearpacksalzy/why-i-built-determinism-into-a-physics-engine-from-day-one-and-what-i-learned-4n7a — determinism from day one

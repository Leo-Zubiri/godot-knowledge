# Checklist — critical review of a plan (run before presenting it)

For each item answer PASS / FAIL / N/A with one line of reasoning; put the failures into a "Critical review"
table (weakness → risk → adjustment) at the top of the plan.

## Scope and decisions
- [ ] The ≤ 5 stack-changing questions were asked or explicitly `ASSUMED:` with a default
      (`game-design-scoping-questions-for-new-game-or-feature`).
- [ ] Platforms, language, renderer, multiplayer scope and monetization intent are each closed by an ADR or marked
      *open until phase X* with the spike that closes them.
- [ ] "What counts as v1" is one sentence and the plan stops there; post-v1 items are labelled optional.
- [ ] Licence/attribution policy is consistent with reality (engine licence text must ship; font licences checked).

## Over-engineering smells
- [ ] No module exists before a second consumer; candidates are marked, not built
      (`godot-reusable-module-packaging`).
- [ ] ≤ 4 roles; a new role is justified by a recorded failure (`game-studio-multiagent-topology`).
- [ ] Documents: ≤ ~25 living docs, each ≤ 150 lines except phase files; ADRs immutable.
- [ ] No framework, CLI or orchestration layer introduced without a measured failure
      (`gs-adr-no-extra-orchestration-framework`).
- [ ] Throwaway prototypes are in a throwaway folder with a closing decision, not in production paths
      (`game-studio-prototype-vs-vertical-slice`).

## Technical fit
- [ ] Physics: a precise/tabletop/vehicle simulation has a decision spike before committing to the engine's
      rigid bodies (`godot-physics-bodies-layers-and-interpolation`).
- [ ] Multiplayer: no lockstep on non-deterministic physics; LAN vs internet costs separated
      (`godot-lan-host-authoritative-turn-based`).
- [ ] Input: engine-native touch/gamepad features used before plugins
      (`godot-touch-input-and-virtualjoystick`).
- [ ] Config-driven taxonomy applied; no "everything is a Resource" sprawl (`godot-config-driven-tunables`).
- [ ] i18n keys from day one (`godot-localization-workflow`).
- [ ] Value/ranking state is server-authoritative or explicitly accepted as unprotected
      (`game-studio-anti-cheat-and-purchase-integrity`).

## Evidence and honesty
- [ ] Every engine claim cites a note id or an official doc; unverified items are marked.
- [ ] Estimates are labelled estimates; nothing is reported as done without evidence.
- [ ] Hidden costs listed (store fees, servers, signing, devices).

# Checklist — closing a plan phase

Every item needs evidence (command + literal output, file path, test report, capture). "Seems fine" is NOT VERIFIED.

- [ ] Each exit criterion of the phase document has a PASS with evidence reference.
- [ ] Project check/import/test/lint targets pass locally and in CI (pinned engine binary).
- [ ] New adjustable values live in config, not code (`godot-config-driven-tunables`).
- [ ] New visible strings use i18n keys; the missing-keys test passes (`godot-localization-workflow`).
- [ ] No upward imports in modules; feature boundaries respected (deps lint).
- [ ] New assets have provenance records and acceptable licences
      (`game-studio-asset-license-and-provenance-policy`).
- [ ] ADRs written for decisions taken; open ADRs still open are listed with their closing phase.
- [ ] Design doc / plan status table / `active.md` updated.
- [ ] Generic findings written back to the knowledge base (`proposed`) or listed as `knowledge_gaps`.
- [ ] Human gates (visual quality, fun, licences, outward-facing actions) explicitly accepted by the owner.
- [ ] Throwaway code from the phase archived or deleted as the plan said.

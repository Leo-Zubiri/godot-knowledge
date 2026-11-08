---
id: knowledge-availability-vs-application
type: concept
domain: godot
status: proposed
summary: Making a knowledge base available is not the same as the model retrieving it, and retrieving it is not the same as producing better code — measure each link separately; a knowledge base may improve provenance without improving quality.
aliases: [availability vs retrieval vs application, knowledge mediation, retrieval does not imply quality]
sources:
  - claim: "With read-only knowledge available (condition B), the model actually read it in only 4 of 5 runs, and the mediator under-counted at least one further access — so availability must be verified by a mediation check, not assumed."
    ref: src-h06-platformer-experiment
    retrieved: 2026-11-08
  - claim: "Blind, test-unaware quality scores were effectively tied between the knowledge condition and the empty-dir placebo (both ~2.42 vs baseline ~2.29), so retrieving knowledge did not translate into higher-quality code on this task."
    ref: src-h06-platformer-experiment
    retrieved: 2026-11-08
  - claim: "The knowledge condition produced genuine provenance (citations to real, relevant notes) while the baseline fabricated references in 3 of 5 runs — a provenance gain even though code quality did not improve."
    ref: src-h06-platformer-experiment
    retrieved: 2026-11-08
related:
  - relates-to: "[[benchmark-leakage-assertions]]"   # why the executable "win" was not a quality signal
  - relates-to: "[[godot-index]]"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Summary
A knowledge base influences generated output through a **chain**, and each link can break independently:
**available → retrieved → correctly applied → higher quality.** Treating "the knowledge was accessible" as if it meant
"the output is better" conflates three different things. Measure each link.

## The three links
1. **Availability** — the knowledge is reachable (e.g. a read-only mount). This is a *precondition*, not an effect.
2. **Retrieval (mediation)** — the model actually opened and read it. This must be **observed**, not assumed: in the H06
   experiment the model read the knowledge in only **4 of 5** runs where it was available, and the access logger even
   **under-counted** one further case. Without a mediation check you cannot tell a real "knowledge" run from one that
   ignored the knowledge.
3. **Effective application → quality** — retrieval only helps if the content is correctly used *and* the thing you
   measure actually reflects quality. On that task, blind (condition- and test-unaware) quality scores were **tied**
   between the knowledge condition and an empty-directory placebo, so retrieval did **not** yield better code.

## Consequences
- **Verify mediation.** Record whether (and which) knowledge files were read per run; flag "knowledge" runs that never
  consulted it — they are not really that condition.
- **Separate provenance from quality.** A knowledge base can measurably improve *provenance* — grounded, real citations —
  while leaving *code quality* unchanged. In H06, the knowledge condition cited real, relevant notes whereas the baseline
  **fabricated** references; that is a real benefit, but a different axis from correctness.
- **Beware false quality signals.** An apparent executable "win" can be an artifact of test design rather than better
  code — see [[benchmark-leakage-assertions]].

## Limitations of the evidence
From a **single, exploratory N=5 experiment** (preserved source `src-h06-platformer-experiment`; generator and evaluator
both Anthropic models). Directional, not significant, and not generalized beyond that task. `proposed` pending human
review.

## See also
- [[godot-index]] — related

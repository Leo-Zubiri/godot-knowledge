---
id: src-gs-gp-evals
type: source
domain: game-studio
source:
  url: "https://github.com/jame581/GodotPrompter/blob/master/evals/SKILLS.md"
  title: "GodotPrompter skill evals (with/without-skill ablation)"
  retrieved: 2026-11-08
  version: "master@d7b26cd"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** files fetched on 2026-11-08 from the `master` branch (HEAD verified via GitHub API at retrieval: `d7b26cdb5fae14d4ef7b713c5bf259395e75c3c6`, committed 2026-10-24; fetch was by branch name) and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. A *reference architecture* studied for patterns only; nothing copied, not a dependency. Statements are documented (D) or project-reported (P); none tested by us. Re-fetch before promoting dependent notes to `verified`.

- **Method (P):** `skill-*` suite, one domain skill per case, each run with and without the plugin skill in an empty workspace (routing card not injected), graded by a Sonnet judge, three runs per case; cases tagged "discriminating" or "ceiling" (both arms pass, kept as routing checks).
- **Results (P, model-judged, noisy):** pilot v1.15.0 four cases mean gain +0.07 (skills helped on judgement calls such as save format or FSM structure, not mainstream Godot 4 knowledge); targeted cases (2026-10-10) largest gain from a Godot 4.7 audio-bus default change (+0.24), addon cases small (+0.11 LimboAI/phantom-camera) → project concludes the measurable edge is recency, not addon knowledge; Godot 4.7 cases (2026-10-11) mean +0.69 on four changes (input device IDs 0→16/32, BlendSpace sync bool→enum, RichText image units, volumetric fog — the blending change was actually in 4.6 with a 4.7 legacy option) with every skill firing 3/3; pre-release regression across 14 cases +0.24 at a stated cost of $21.72, one case −0.07 attributed to a split vote; v1.16.0 new skills: rendering case +0.42 (bare model wrongly recommended FSR 1 on the Mobile renderer), web services/export at ceiling, web services skill fired in only 1 of 3 runs (attributed to its description).
- **Corrections found while fact-checking (P):** fog blending version fixed; a wrong C# claim that omitting `EventHandler` compiles (it is a compile error); a nonexistent `AsTask()` call and wrong return type; a "memory leak" explanation for C# signal disconnection replaced by the actual `ObjectDisposedException` failure mode; a dated research note still containing the fog error was deliberately left unchanged.
- **Stated limits (P):** judging noisy (one rubric flipped between runs; some failures were grader wording, not model errors); skill-08 changed but not re-run; skill-05 borderline; **C# examples compiled against two SDK versions but nothing run inside a game**; description-only routing is unreliable (code-review and web-services skills fired in a subset of runs); GDScript 4.7 examples not compiled or executed (per the research agent's reading).
- **Project's own conclusion (P):** value is mainly where Godot behaviour changed recently or where a judgement call matters; for mainstream and addon knowledge the bare model is already strong.

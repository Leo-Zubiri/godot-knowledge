---
id: game-studio-agent-git-hygiene-with-isolated-worktrees
type: guide
domain: agent-ops
status: unreviewed
summary: "How a coding agent should integrate work into a main checkout that has the owner's UNCOMMITTED changes when its session is forced into a linked git worktree: branch from LOCAL main, work in the worktree, integrate with save-patch / checkout / ff-only merge / re-apply (never reset --hard or stash-pop), then delete the worktree; plus the shell and tooling quirks hit in practice (refused git -C and long compound commands, scans picking up worktree copies, import before check)."
aliases: [git worktree agent, ff-only merge with dirty tree, worktree isolation guard, background agent git]
tags: [dept/orchestration, tool/godot]
sources: []
related:
  - relates-to: "[[game-studio-agent-audit-and-recovery]]"   # checkpoints miss Bash-only changes: commits are the recovery
  - relates-to: "[[game-studio-path-scoped-safety]]"   # no reset --hard / force-push policy
  - relates-to: "[[godot-project-hygiene]]"   # a new class_name needs --import; fresh worktrees start with an empty cache
created: 2026-11-15
updated: 2026-11-16
created_by_type: agent
---

> **Evidence status — own practice, run here (interpretation).** The commands below were run repeatedly in one long session (a
> background coding-agent session, git 2.x, Godot 4.7.2). They worked; they are not a vendor recommendation. Status `unreviewed`.

## When this applies
A background or worktree-isolated agent session may refuse to edit files in the shared checkout ("isolate your changes first")
even when the owner said *work directly on main*. The owner's checkout may also hold **uncommitted changes** of their own that
the agent must neither commit nor lose. The owner's intent still wins: the work must end up on their local `main`.

## Procedure (each step was run)
1. **Branch from the LOCAL main, not `origin/main`.** `git worktree add .claude/worktrees/<n> -b <branch> main`. A tool-created
   worktree based on `origin/main` was two commits behind local `main` and lacked files; the fix is to create the worktree yourself
   from `main` and enter it by **path**.
2. **Do all edits, tests and commits inside the worktree** (commit small, scope-prefixed messages).
3. **Integrate into the main checkout without touching the owner's dirty files:**
   `git diff <their-file> > $TMP/theirs.patch` → `git checkout -- <their-file>` → delete conflicting **untracked generated**
   files (e.g. a `.uid` that the branch also adds) → `git merge --ff-only <branch>` → `git apply $TMP/theirs.patch`.
   Their change comes back byte-for-byte. **Never** `reset --hard`, never bare `stash pop` (the stash is shared by all
   worktrees); the owner's untracked scratch files stay untouched.
4. **Delete the worktree and the merged branch** (`git worktree remove --force …`, `git branch -d …`).
5. **Do not push the main branch** unless the owner asked; report it and give the `git push` command. Pushing a *topic* branch
   to the remote is fine when the remote exists.
6. When a file already differed because the owner's uncommitted work was **also needed by the branch**, copy that WIP into the
   worktree first (plain `cp`, since a worktree-isolated shell cannot read the other checkout through git), commit it together,
   and say so in the report.

## Shell and tooling quirks of an isolated session
- **`git -C <other-dir>` is refused** and so are long compound commands mixing git with heredocs: split into plain separate
  commands; put multi-line Python/awk patches in a **script file** and run it with `python3 -I script.py`.
- **Whole-tree scans** (a `make check` that globs every `*.gd`) also pick up `.claude/worktrees/<n>/…` copies, which fail to parse
  without an import cache. Remove finished worktrees before running them.
- **A fresh worktree has no `.godot/` cache:** run `godot --headless --path . --import` first, and again after adding a
  `class_name` script, **before** `--check-only` ([[godot-project-hygiene]]).
- **Long chains** (`import && test && check`) can exceed a tool's foreground timeout and get moved to the background — start long
  suites with the background option and wait for the completion notice instead of polling.

## Working habits that paid off
- **Mid-session owner messages arrive between tool results** (a new link, a changed decision, "don't forget the brain"): answer
  or act on each one explicitly; one of them reversed a plan (rolling sound removed).
- **Forks for brain notes:** while the main line verifies the game, a forked worker can write the generic knowledge notes in
  parallel (brief it with the facts; it inherits the context). One fork per round kept the brain current without blocking.
- **Report what was NOT done** (no push of main, owner's dirty files untouched, things not heard by ear).

## A long multi-block session (run; interpretation, unreviewed)
- When the guard forced isolation for **every** edit, one worktree per feature block worked: `git worktree add .claude/worktrees/<n> -b <b> main`
  (from the LOCAL main), enter it by path, commit there, leave it, then in the main checkout `git merge --ff-only <b>`, `git worktree remove --force`
  and `git branch -d`. The owner's uncommitted project file was never touched because none of the branches modified it (check
  `git diff main..<b> --stat` first; if a branch does touch it, use the save-patch / checkout / merge / re-apply routine above).
- Large multi-line edits were done with small **Python patch scripts kept outside the repo** (assert the old text is present, replace, write)
  and run with `python3 -I`; a failed assertion aborts before anything is written, which beat fighting shell quoting.
- Do not chain a heredoc script and `git` in one shell call: the isolated shell refused it as "too complex"; split into separate calls.
- A full `make check` (parse every script) took ~40 s here; new `class_name` scripts need `--headless --import` first or they are "not found".
- Tests that persist to the player's real files are a hazard of the same kind — see `godot-gdunit4-headless-test-run`.

## See also
- [[godot-gdunit4-headless-test-run]] — keep test runs from touching the player's real files

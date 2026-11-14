---
id: godot-editor-noise-and-generated-files-in-version-control
type: guide
domain: godot
status: unreviewed
summary: "Why `git pull` keeps getting blocked in a Godot 4.7 project that an agent edits in one checkout while a person opens the editor in another, and how to stop it: the editor rewrites project.godot (reorders sections, adds a [dotnet] block on the mono build, drops values equal to the default), re-indents text files it has open, and generates .uid files locally before the commit that tracks them arrives. Fixes: commit project.godot in the editor's own layout, keep hand-maintained data files free of leading indentation, and give the repo a sync command that discards only verified editor noise."
aliases: [project.godot keeps changing, git pull blocked by local changes, uid file untracked would be overwritten, editor rewrites files, sync command]
tags: [dept/delivery, dept/orchestration, tool/godot]
applies-to:
  min: "4.4"
  tested: "Godot 4.7.2.stable.mono on Linux; one person's editor + an agent working in a separate git worktree"
sources: []
related:
  - relates-to: "[[input-handling]]"   # do not restore project.godot blindly: Input Map actions live there
  - relates-to: "[[game-studio-claude-code-headless-subagents-and-model-pinning]]"   # agents working in parallel checkouts
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> **Evidence status — run here, unreviewed.** Observed over one day in a single project: three separate blocked pulls, each
> diagnosed by diffing the person's working files against the commit they were on. Engine behaviour was observed, not looked up.

## The symptom
`git pull` aborts with "Your local changes to the following files would be overwritten by merge" (or "untracked working tree files
would be overwritten") although the person changed nothing. They keep playing an old build and report problems already fixed.

## Three causes found
1. **`project.godot` is rewritten when the editor saves project settings.** Sections are reordered, the mono build adds
   `[dotnet] project/assembly_name=…`, and any value equal to its default is dropped. Compared as a *set of lines* the file was
   identical except for that noise. **Fix:** commit the file exactly as the editor writes it (take the person's rewritten file,
   re-apply any setting added since, and check with a line-set diff that only the known noise differs). Confirm a dropped line
   really is a default with `ProjectSettings.property_get_revert(name)` before accepting its removal.
2. **A hand-maintained text file gets re-indented.** A YAML registry indented with spaces came back with tabs every time (the
   editor's script editor converts indentation on save for files it has open) — which is also invalid YAML. **Fix:** write such
   files so there is no leading indentation to convert: one entry per line in flow style (`- {id: …, path: …}`) under a top-level
   key is valid YAML with zero indentation. Have the lint reject indented lines.
3. **Generated `.uid` files exist locally before the commit that tracks them arrives.** Running an import in the person's checkout
   creates `script.gd.uid`; the agent's commit then adds the same file, and the pull refuses to overwrite the untracked copy even
   though the content is identical. **Fix:** in the sync step, remove an untracked file when `git hash-object file` equals
   `git rev-parse origin/main:file`; stop and report if it differs.

## A sync command worth having
`make sync` (a small shell script): for each known-noisy file, restore it **only** if its diff is whitespace-only or, for
`project.godot`, if the line-set difference matches an allowlist of editor noise; otherwise stop and show the diff. Then clear
identical untracked files as above, `git pull --ff-only`, and re-import. Never restore `project.godot` unconditionally — actions
added to the Input Map since the last commit live only there ([[input-handling]]).

## Related traps
- **Verify what the person is actually running before debugging their report.** Reading the branch pointer and one or two
  version-bearing files in their checkout (read-only) settled in seconds that the build was eleven commits old.
- **A lint that only checks that a file exists is not a lint.** The asset-provenance check printed "OK" for weeks while validating
  nothing; replacing it (fields present, licence allowed, paths exist, every asset listed) was 100 lines.
- **Auditing other worktrees without running git inside them:** compare each file's blob hash (`sha1("blob <len>\\0" + bytes)`)
  with `git ls-tree -r <head>` from your own worktree, and filter untracked files through `git check-ignore --no-index --stdin`.
  The worktree's `.git` link file shows up as untracked; ignore it.

## See also
- [[input-handling]] — why a blind restore of `project.godot` loses Input Map actions

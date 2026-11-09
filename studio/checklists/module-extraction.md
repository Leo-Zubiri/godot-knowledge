# Checklist — extracting a reusable module (`godot-reusable-module-packaging`)

- [ ] Two real consumers named (second use), or the code stays marked `extract-candidate`.
- [ ] `addons/<prefix>_<name>/` with README (purpose, API, dependencies, install, autoloads to register),
      CHANGELOG, LICENSE; `plugin.cfg` only for editor tooling.
- [ ] Prefixed `class_name`s; configuration via exports/setters; events via signals; data paths injected.
- [ ] Zero references to the host game's `core/`, `features/`, concrete config files or i18n texts.
- [ ] The module registers no autoloads by itself.
- [ ] Scripts moved with their `.uid` files; referencing scenes re-saved.
- [ ] Tests pass without the rest of the game.
- [ ] Deps lint empty for the module folder.
- [ ] Documented in the host's architecture doc; version bumped.

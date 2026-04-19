# Legacy Branch Notice (`legacy-dev`)

This branch contains experimental and premature UI work that was developed before stabilizing the API.

## Status

* Not production-ready
* Not aligned with current architecture
* Retained only for historical reference

## Why it exists

During early development, UI components were introduced before stabilizing the API and domain design. This led to tight coupling and inconsistencies.

## Current Direction

The project was restructured to establish a clean baseline:

* `main` branch was reset to a stable API-only foundation (tagged as `release/v1.0`)
* UI and full-stack features are now being reintroduced incrementally via feature branches and pull requests

## Note

`main` may now include full-stack features beyond the initial API-only baseline, but all changes follow the refactored, domain-driven structure.


## Important

Do NOT use this branch as a base for new work.
Refer to `main` for all active development.

---

This branch is preserved intentionally to document the evolution and refactoring decisions of the project.

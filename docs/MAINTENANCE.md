# Profile maintenance

The README uses repository-hosted artwork, plain text skills and direct project
links. The banner honors reduced motion. The contribution animation is optional
inside a disclosure and is never required to understand the profile.

## Workflow audit — October 29, 2026

| File | Previous schedule (UTC) | Change and reason |
| --- | --- | --- |
| `stats.yml` | `0 */12 * * *` (twice daily) | Removed: referenced repository is a web service, not an executable Action. |
| `profile-summary-cards.yml` | `0 0 * * *` (daily) | Removed: missing token; generated cards unused in README. |
| `3d-graph.yml` | `0 0 * * 0` (weekly) | Removed: missing token, unsupported inputs; graph unused in README. |
| `metrics.yml` | `0 * * * *` (hourly) | Removed: output unused in README. |
| `snake.yml` | `0 0 * * *` (daily) | Weekly Monday `17 6 * * 1`, manual and PR validation. |

Configured scheduled runs fall from **197 per week to 1** (about 99.5% fewer).
Actual scheduler execution can be delayed or skipped by GitHub.

Failure evidence:

- [Stats run 40926291418](https://github.com/Eskinder185/Eskinder185/actions/runs/40926291418): action.yml/action.yaml/Dockerfile missing.
- [Summary run 40818192160](https://github.com/Eskinder185/Eskinder185/actions/runs/40818192160): GITHUB_TOKEN missing.
- [3D run 40153700635](https://github.com/Eskinder185/Eskinder185/actions/runs/40153700635): unexpected USERNAME/SETTINGS inputs and GITHUB_TOKEN empty.
- [Snake run 40812178501](https://github.com/Eskinder185/Eskinder185/actions/runs/40812178501): existing implementation succeeded.
- [Metrics run 40934733392](https://github.com/Eskinder185/Eskinder185/actions/runs/40934733392): succeeded; output unused.

The latest 30 failed runs were inspected by workflow identity and date. Decoded
logs were reviewed for the latest distinct failing workflow in that window.

## Visual updates

The surviving workflow creates light/dark snake SVGs and a public repository
snapshot with Python's standard library. Generation has read-only repository
access. The separate publishing job gets only contents:write, consumes artifacts
from the same run and runs only on the default branch for a schedule or an
explicit `publish: true` manual invocation. Pull requests only generate artifacts.

Third-party action refs are fixed commits, resolved from release tags and checked
against their action manifests. Concurrency prevents overlapping same-ref runs;
jobs time out after 10 and 5 minutes. No workflow listens to pushes, so generated
output commits cannot recurse. Publishing preserves existing output files.

Inline README statistics are a **dated baseline**, not live counters.
`assets/activity.json` is the baseline source. Weekly snapshots are written to
`output/activity.svg` and `output/activity.json` after merge and the first
successful publishing run. To intentionally refresh the inline baseline:

```sh
OUTPUT_DIR=assets python3 scripts/generate-activity.py
```

Review and commit both files. Counts cover public non-fork repositories owned by
Eskinder185; primary languages counts distinct repository language labels, not
code volume or proficiency. Public stars are summed across those repositories.

Before merging, inspect the profile-visuals artifact from PR validation. After
approval and merge, run the workflow on main with publish enabled, then verify
the output branch. The feature branch does not publish or alter production.

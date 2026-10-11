# cli

Interactive command-line helpers for everyday git, replacing a handful of
aliases (`gb`, `gl`, `gs`, `gbr`) with fzf-driven versions: pick what you want
from a list, choose an action, done.

| Command | Replaces | What it does |
|---------|----------|--------------|
| `gb`  | branch listing | pick local branches → checkout / rebase / list commits / delete / merge / rename |
| `gl`  | `git log`      | pick commits → open files / diff / view on github / reset --soft |
| `gs`  | `git status`   | pick changed files → open / diff / stage / unstage / undo |
| `gbr` | remote branches | pick remote branches → checkout / rebase / cherry-pick / delete / merge |

Extra arguments are forwarded to the git command each one wraps: `gl` → `git
log` (`gl -n 5`, `gl --author=me`, `gl v1.0..HEAD`), `gs` → `git status` (a
pathspec such as `gs src/`), `gb` / `gbr` → `git for-each-ref` (`gb --count=10`).

## Requirements

- `git` and [`fzf`](https://github.com/junegunn/fzf)
- a trash CLI for `gs undo` on untracked files (`trash`, `trash-cli`, or `gio`)

Pure bash, targeting bash 3.2 (what macOS ships), so it runs unchanged on macOS
and Linux.

## Install

The scripts in `bin/` resolve `lib/` as a sibling directory, so add this repo's
`bin/` to your `PATH` rather than copying individual files:

```sh
export PATH="$PATH:/path/to/cli/bin"
```

## Layout

Each command is a thin set of handlers over shared libraries.

```
bin/     gb gl gs gbr          — one file per command
lib/     colors platform paths github status files commits log ui git branch_list
test/    *.bats + helper.bash  — bats suite
```

| lib | role |
|-----|------|
| `ui.sh` | fzf pickers — all interactive UI |
| `git.sh` | git CLI queries + shared mutations |
| `paths.sh` | cwd-relative path rendering |
| `status.sh` | file-status colouring |
| `commits.sh` | commit-list rendering + cherry-pick ordering |
| `files.sh` | "pick files changed by these commits" |
| `github.sh` | GitHub remote URL parsing + opening commits |
| `log.sh` | `batch_apply`: the shared ✓/✗ summary |
| `platform.sh` | `open` / `trash` |
| `branch_list.sh` | shared pick→pick→dispatch flow (local or remote refs) |
| `colors.sh` | ANSI colour helpers |

## Design

- **fzf owns the TUI.** Pickers use the line convention `KEY<TAB>DISPLAY`: fzf
  shows only `DISPLAY` (`--with-nth=2..`, `--ansi`) and returns the whole line,
  so the machine value is recovered with `cut -f1`.
- **git CLI, not a library.** Merge/rebase/cherry-pick are plain `git` commands
  with exit-code checks and auto-abort on conflict; metadata and relative times
  come from `for-each-ref` / `log`.
- **Small functions, heavy reuse.** Handlers stay a few readable lines by
  sharing `log::batch_apply`, `status::render`, `commits::render`,
  `files::select_changed`, `github::*` and `branch_list::run`.
- **Test seam.** Each `bin/` file runs `main` only when executed, not when
  sourced, so tests drive handlers directly with the `ui::*` pickers stubbed.

## Development

```sh
just lint    # shellcheck -x over bin/ + lib/
just test    # bats test
```

Install the tooling with `brew install bats-core shellcheck` (or
`apt-get install bats shellcheck`). CI runs both on every push/PR
(`.github/workflows/ci.yaml`).

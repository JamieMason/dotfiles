#!/usr/bin/env bats
# Unit tests for the shared libraries.

load helper

setup() { setup_repo; load_libs; }
teardown() { teardown_repo; }

# ---- paths -----------------------------------------------------------------

@test "path::rel_to_cwd: file in cwd is just its name" {
  run path::rel_to_cwd "$(pwd -P)/a.txt"
  [ "$output" = "a.txt" ]
}

@test "path::rel_to_cwd: file in parent gets ../" {
  mkdir -p sub && cd sub
  run path::rel_to_cwd "$(dirname "$(pwd -P)")/a.txt"
  [ "$output" = "../a.txt" ]
}

# ---- github ----------------------------------------------------------------

@test "github::repo_from_url: https" {
  run github::repo_from_url "https://github.com/JamieMason/cli.git"
  [ "$output" = "JamieMason/cli" ]
}

@test "github::repo_from_url: ssh" {
  run github::repo_from_url "git@github.com:JamieMason/cli.git"
  [ "$output" = "JamieMason/cli" ]
}

@test "github::repo_from_url: non-github fails" {
  run github::repo_from_url "ssh://example.com/x"
  [ "$status" -ne 0 ]
}

# ---- status ----------------------------------------------------------------

@test "status::mark: colours by status char" {
  [ "$(status::mark A | strip_ansi)" = "A" ]
  [ "$(status::mark M | strip_ansi)" = "M" ]
  [ "$(status::mark '?' | strip_ansi)" = "?" ]
  # A is green, M is yellow — different escapes
  [ "$(status::mark A)" != "$(status::mark M)" ]
}

# ---- log::batch_apply ------------------------------------------------------

@test "batch_apply: all succeed, status 0" {
  _ok() { return 0; }
  run log::batch_apply Done do thing _ok log::echo x y
  [ "$status" -eq 0 ]
  [[ "$output" == *"Done 2 thing"* ]]
}

@test "batch_apply: partial failure reports both and keeps status 0" {
  _op() { [ "$1" = bad ] && { echo "it broke" >&2; return 1; }; return 0; }
  run log::batch_apply Done do thing _op log::echo good bad
  [ "$status" -eq 0 ]
  [[ "$output" == *"Done 1 thing"* ]]
  [[ "$output" == *"Failed to do 1 thing"* ]]
  [[ "$output" == *"it broke"* ]]
}

@test "batch_apply: all fail -> status 1" {
  _no() { return 1; }
  run log::batch_apply Done do thing _no log::echo a b
  [ "$status" -eq 1 ]
}

# ---- commits::render -------------------------------------------------------

@test "commits::render: key is the short hash, %ct column dropped" {
  line=$(printf '111\tabc1234\tmy subject\tMon 1 Jan (1 day ago)\tAlice\n' | commits::render | strip_ansi)
  [ "${line%%$'\t'*}" = "abc1234" ]
  [[ "$line" == *"abc1234 - my subject Mon 1 Jan (1 day ago) <Alice>"* ]]
}

@test "commits::render: processes a final line with no trailing newline" {
  # regression: `printf '%s' | while read` used to drop the last line
  out=$(printf '1\taaaaaaa\ts1\tw\tu\n2\tbbbbbbb\ts2\tw\tu' | commits::render | strip_ansi)
  [ "$(printf '%s\n' "$out" | grep -c .)" -eq 2 ]
  [[ "$out" == *"bbbbbbb"* ]]
}

# ---- git -------------------------------------------------------------------

@test "git::branches_meta: skips symbolic refs" {
  commit a.txt a root
  git symbolic-ref refs/heads/aliased refs/heads/main
  run git::branches_meta refs/heads/
  [[ "$output" == *"main"* ]]
  [[ "$output" != *"aliased"* ]]
}

@test "git::commit_files: lists a root commit's files via --root" {
  commit a.txt a root
  run git::commit_files "$(git rev-parse HEAD)"
  [[ "$output" == *"a.txt"* ]]
}

# ---- branch_list -----------------------------------------------------------

@test "branch_list::_render_items: excludes current when asked" {
  commit a.txt a root
  git branch other
  out=$(branch_list::_render_items main refs/heads/ 1 | strip_ansi)
  [[ "$out" == *"other"* ]]
  [[ "$out" != *$'\n'"main"* ]]
}

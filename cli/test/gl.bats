#!/usr/bin/env bats
# Behaviour tests for gl (log).

load helper

setup() {
  setup_repo
  load_cmd gl
  commit a.txt a root
  commit a.txt a2 second
  commit a.txt a3 third
}
teardown() { teardown_repo; }

# newest-first list of short hashes
_hashes() { git::commit_rows HEAD | cut -f2; }

@test "gl _is_newest_n: the newest commit alone is the top 1" {
  local all newest
  all=$(_hashes)
  newest=$(printf '%s\n' "$all" | sed -n 1p)
  run gl::_is_newest_n "$all" "$newest"
  [ "$status" -eq 0 ]
}

@test "gl _is_newest_n: the oldest commit alone is not" {
  local all oldest
  all=$(_hashes)
  oldest=$(printf '%s\n' "$all" | sed -n 3p)
  run gl::_is_newest_n "$all" "$oldest"
  [ "$status" -ne 0 ]
}

@test "gl _is_newest_n: the newest two together are consecutive from the top" {
  local all
  all=$(_hashes)
  run gl::_is_newest_n "$all" "$(printf '%s\n' "$all" | sed -n 1p)" "$(printf '%s\n' "$all" | sed -n 2p)"
  [ "$status" -eq 0 ]
}

@test "gl reset_soft: moves HEAD back and leaves the change staged" {
  local before
  before=$(git rev-parse HEAD)
  run gl::reset_soft 1
  [ "$status" -eq 0 ]
  [ "$(git rev-parse HEAD)" != "$before" ]
  [[ "$(git diff --cached --name-only)" == *"a.txt"* ]]
}

@test "gl open_files: opens files changed by the selected commit" {
  ui::pick_many() { cut -f1; }
  platform::open() { echo "opened:$1"; }
  run gl::open_files "$(git rev-parse --short HEAD)"
  [ "$status" -eq 0 ]
  [[ "$output" == *"opened:a.txt"* ]]
}

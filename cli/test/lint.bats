#!/usr/bin/env bats
# Static analysis gate — the compiler we gave up moving off Rust.

load helper

@test "shellcheck: bin and lib are clean" {
  command -v shellcheck >/dev/null || skip "shellcheck not installed"
  run shellcheck -x -e SC1090,SC1091 "$BIN"/* "$LIB"/*.sh
  [ "$status" -eq 0 ] || {
    echo "$output"
    false
  }
}

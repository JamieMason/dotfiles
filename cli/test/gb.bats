#!/usr/bin/env bats
# Behaviour tests for gb (local branches).

load helper

setup() {
  setup_repo
  load_cmd gb
  commit a.txt a root
  git checkout -q -b feature
  commit b.txt b "feat: add b"
  commit c.txt c "feat: add c"
  git checkout -q main
}
teardown() { teardown_repo; }

@test "gb delete: removes selected branches" {
  git branch gone1
  git branch gone2
  run gb::dispatch delete main gone1 gone2
  [ "$status" -eq 0 ]
  [[ "$output" == *"Deleted 2 branch"* ]]
  [ -z "$(git branch --list gone1)" ]
  [ -z "$(git branch --list gone2)" ]
}

@test "gb checkout: switches to the one branch" {
  run gb::dispatch checkout main feature
  [ "$status" -eq 0 ]
  [[ "$output" == *"Checked out feature"* ]]
}

@test "gb checkout: refuses more than one branch" {
  run gb::dispatch checkout main feature other
  [ "$status" -ne 0 ]
  [[ "$output" == *"one branch at a time"* ]]
}

@test "gb list commits -> cherry-pick applies ALL selected commits" {
  # regression: both feature commits must be picked, not just the first
  ui::pick_many() { cut -f1; }      # select every commit
  ui::pick_one() { grep -x "cherry-pick"; }
  run gb::dispatch "list commits" main feature
  [ "$status" -eq 0 ]
  [[ "$output" == *"Cherry-picked 2 commit"* ]]
  [ -f b.txt ]
  [ -f c.txt ]
}

@test "gb list commits -> open files opens each changed file" {
  ui::pick_many() { cut -f1; }
  ui::pick_one() { grep -x "list changed files"; }
  platform::open() { echo "opened:$1"; }
  run gb::dispatch "list commits" main feature
  [ "$status" -eq 0 ]
  [[ "$output" == *"opened:b.txt"* ]]
  [[ "$output" == *"opened:c.txt"* ]]
}

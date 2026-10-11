#!/usr/bin/env bats
# Behaviour tests for gs (status).

load helper

setup() {
  setup_repo
  load_cmd gs
  commit a.txt original root
}
teardown() { teardown_repo; }

@test "gs _porcelain: classifies staged-add, worktree-modify, untracked" {
  echo change >> a.txt          # worktree modified -> M
  echo new > n.txt              # untracked -> ?
  echo s > s.txt && git add s.txt   # staged add -> A
  out=$(gs::_porcelain | sort)
  [[ "$out" == *"M"$'\t'"a.txt"* ]]
  [[ "$out" == *"A"$'\t'"s.txt"* ]]
  [[ "$out" == *"?"$'\t'"n.txt"* ]]
}

@test "gs _status_items: untracked files under a new dir are listed individually" {
  # regression: without -uall git collapses to the directory
  mkdir -p pkg && echo x > pkg/deep.txt
  out=$(gs::_status_items "$(git::root)" | strip_ansi)
  [[ "$out" == *"pkg/deep.txt"* ]]
}

@test "gs op_stage then op_unstage" {
  echo change >> a.txt
  run gs::op_stage a.txt
  [ "$status" -eq 0 ]
  [[ "$(git status --porcelain a.txt)" == M* ]]
  run gs::op_unstage a.txt
  [ "$status" -eq 0 ]
  [[ "$(git status --porcelain a.txt)" == " M"* ]]
}

@test "gs op_undo: untracked file goes to trash, never rm" {
  echo junk > junk.txt
  platform::trash() { echo "trashed:$1"; }
  run gs::op_undo junk.txt
  [ "$status" -eq 0 ]
  [[ "$output" == *"trashed:junk.txt"* ]]
  [ -f junk.txt ]
}

@test "gs op_undo: tracked file is restored from HEAD" {
  echo changed > a.txt
  run gs::op_undo a.txt
  [ "$status" -eq 0 ]
  [ "$(cat a.txt)" = original ]
}

@test "gs print_branch_status: shows ahead count vs upstream" {
  git branch base
  git config branch.main.remote .
  git config branch.main.merge refs/heads/base
  commit a.txt ahead "one ahead"
  out=$(gs::print_branch_status | strip_ansi)
  [[ "$out" == *"## main"* ]]
  [[ "$out" == *"ahead 1"* ]]
}

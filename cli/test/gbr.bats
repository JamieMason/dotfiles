#!/usr/bin/env bats
# Behaviour tests for gbr (remote branches). Remote-tracking refs are simulated
# with update-ref so the tests need no network.

load helper

setup() {
  setup_repo
  load_cmd gbr
  commit a.txt a root
  git checkout -q -b feature
  commit f.txt f "feat: add f"
  commit g.txt g "feat: add g"
  git checkout -q main
  git update-ref refs/remotes/origin/feature refs/heads/feature
  git branch -D feature >/dev/null
}
teardown() { teardown_repo; }

@test "gbr branch list: shows remote branches, hides origin/HEAD" {
  git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/feature
  out=$(branch_list::_render_items main refs/remotes/ 0 | strip_ansi)
  [[ "$out" == *"origin/feature"* ]]
  [[ "$out" != *"origin/HEAD"* ]]
  # the symref's short name is bare "origin" — must not leak as a branch
  [[ "$out" != *$'\t'"origin "* ]]
}

@test "gbr checkout: creates a local branch tracking the remote ref" {
  run gbr::checkout main origin/feature
  [ "$status" -eq 0 ]
  [[ "$output" == *"Checked out 'feature' from 'origin/feature'"* ]]
  git rev-parse --verify refs/heads/feature
}

@test "gbr op_delete: removes the remote-tracking ref" {
  git update-ref refs/remotes/origin/stale refs/heads/main
  run gbr::op_delete origin/stale
  [ "$status" -eq 0 ]
  run git rev-parse --verify refs/remotes/origin/stale
  [ "$status" -ne 0 ]
}

@test "gbr cherry-pick: applies commits from the remote branch onto HEAD" {
  ui::pick_many() { cut -f1; }   # select every commit
  run gbr::cherry_pick main origin/feature
  [ "$status" -eq 0 ]
  [[ "$output" == *"Cherry-picked 2 commit"* ]]
  [ -f f.txt ]
  [ -f g.txt ]
}

@test "gbr cherry-pick summary label keeps the [branch] prefix" {
  GBR_ROWS=$(gbr::_collect_commits origin/feature)
  hash=$(printf '%s\n' "$GBR_ROWS" | sed -n 1p | cut -f2)
  run gbr::_commit_label "$hash"
  [[ "$output" == "[origin/feature] "* ]]
}

#!/usr/bin/env bash
# Commit-list rendering and ordering, shared by gb and gl.

# commits::render  < git::commit_rows output  -> short-hash<TAB>COLOURED
# COLOURED: "<hash> - <subject> <abs (rel)> <<author>>". The leading %ct column
# ($1) from commit_rows is ignored here (it is only used upstream for sorting).
#
# One awk pass rather than a bash read-loop with colour:: helpers: gl streams
# the entire log through this, and a per-line loop — three command
# substitutions each (a subshell apiece), or even a bare printf — made large
# repos crawl, so fzf sat churning through history for seconds. awk renders tens
# of thousands of commits in well under a second. The escapes match
# colour::{red,green,blue_bold} byte-for-byte; the colour:: helpers stay for the
# non-hot-path call sites. Fields never contain tabs (git %s/%an are one line),
# and awk still emits a final record that lacks a trailing newline.
commits::render() {
  awk -F"$TAB" 'BEGIN { r="\033[31m"; g="\033[32m"; bb="\033[1;34m"; z="\033[0m" }
    $2 != "" { printf "%s\t%s%s%s - %s %s%s%s %s<%s>%s\n", $2, r,$2,z, $3, g,$4,z, bb,$5,z }'
}

# commits::by_time HASH...  -> the same hashes, oldest first (cherry-pick order).
commits::by_time() {
  local h
  for h in "$@"; do printf '%s %s\n' "$(git show -s --format=%ct "$h")" "$h"; done |
    sort -n | while read -r _ h; do printf '%s\n' "$h"; done
}

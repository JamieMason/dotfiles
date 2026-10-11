#!/usr/bin/env bash
# Commit-list rendering and ordering, shared by gb and gl.

# commits::render  < git::commit_rows output  -> short-hash<TAB>COLOURED
# COLOURED: "<hash> - <subject> <abs (rel)> <<author>>". The leading %ct column
# from commit_rows is ignored here (it is only used upstream for sorting).
commits::render() {
  local hash subject when author
  # `|| [ -n "$hash" ]` so a final line without a trailing newline is not dropped.
  while IFS="$TAB" read -r _ hash subject when author || [ -n "$hash" ]; do # _ = unix-time, only for sorting upstream
    [ -z "$hash" ] && continue
    printf '%s%s%s - %s %s %s\n' "$hash" "$TAB" \
      "$(colour::red "$hash")" "$subject" \
      "$(colour::green "$when")" "$(colour::blue_bold "<$author>")"
  done
}

# commits::by_time HASH...  -> the same hashes, oldest first (cherry-pick order).
commits::by_time() {
  local h
  for h in "$@"; do printf '%s %s\n' "$(git show -s --format=%ct "$h")" "$h"; done |
    sort -n | while read -r _ h; do printf '%s\n' "$h"; done
}

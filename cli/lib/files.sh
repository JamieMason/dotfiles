#!/usr/bin/env bash
# "Pick files changed by these commits" — the selection step shared by
# gb (list changed files → open) and gl (open files / diff).

# files::select_changed ROOT HASH...
#   Builds the deduped changed-file list across the commits, shows the picker,
#   and fills UI_ITEMS with the chosen cwd-relative paths. Returns non-zero (so
#   callers can `|| return`) when there is nothing to show or the user cancels.
files::select_changed() {
  local root=$1
  shift

  local items h
  items=$(for h in "$@"; do git::commit_files "$h"; done | status::render "$root" | sort -t"$TAB" -k1)
  if [ -z "$items" ]; then
    echo "No changed files found."
    return 1
  fi

  local picked
  picked=$(printf '%s' "$items" | ui::pick_many "Select files:") || true
  [ -z "$picked" ] && return 1
  ui::read_items <<< "$picked"
}

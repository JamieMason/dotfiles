#!/usr/bin/env bash
# Shared "list branches → pick branches → pick a command → dispatch" flow.
# This is `branch_list::run_interactive` from the Rust, as a reusable function
# that takes a handler by name. gb (local branches) and gbr (remote) share it.

# branch_list::run TITLE EMPTY_MSG COMMANDS HANDLER_FN [REFS] [EXCLUDE_CURRENT]
#   COMMANDS         newline-separated command names for the second picker
#   HANDLER_FN       called as: HANDLER_FN COMMAND CURRENT_BRANCH NAME...
#   REFS             ref namespace to list (default refs/heads/)
#   EXCLUDE_CURRENT  1 to drop the current branch from the list (default 1)
branch_list::run() {
  local title=$1 empty=$2 commands=$3 handler=$4 refs=${5:-refs/heads/} exclude=${6:-1}

  local current
  current=$(git::current_branch) || { echo "Error: detached HEAD" >&2; return 1; }

  local display
  display=$(branch_list::_render_items "$current" "$refs" "$exclude")

  local header
  header="$title $(colour::blue "($current)")"
  if [ -z "$display" ]; then
    printf '%s\n%s\n' "$header" "$empty"
    return 0
  fi

  local selected
  selected=$(printf '%s' "$display" | ui::pick_many "$header") || true
  [ -z "$selected" ] && return 0

  local command
  command=$(printf '%s\n' "$commands" | ui::pick_one "Choose command:") || true
  [ -z "$command" ] && return 0

  ui::read_items <<< "$selected"
  "$handler" "$command" "$current" "${UI_ITEMS[@]}"
}

# Build the KEY<TAB>DISPLAY picker lines, skipping */HEAD and (optionally) the
# current branch.
branch_list::_render_items() {
  local current=$1 refs=$2 exclude=$3
  local name subject abs rel author
  while IFS="$TAB" read -r name subject abs rel author; do
    [ -z "$name" ] && continue
    case $name in */HEAD) continue ;; esac
    { [ "$exclude" = 1 ] && [ "$name" = "$current" ]; } && continue
    printf '%s%s%s\n' "$name" "$TAB" "$(branch_list::_label "$name" "$subject" "$abs" "$rel" "$author")"
  done <<< "$(git::branches_meta "$refs")"
}

branch_list::_label() {
  printf '%s - %s %s %s' \
    "$(colour::red "$1")" "$2" \
    "$(colour::green "$3 ($4)")" \
    "$(colour::blue_bold "<$5>")"
}

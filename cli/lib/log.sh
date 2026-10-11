#!/usr/bin/env bash
# Output helpers.

# Identity label — the common case where an item is already its own label.
log::echo() { printf '%s' "$1"; }

# log::batch_apply PAST PRESENT NOUN OP_FN LABEL_FN ITEM...
#
# Runs OP_FN against each ITEM and prints the ✓/✗ summary that every batch
# command in the Rust version hand-rolled (delete / merge / rebase /
# cherry-pick all shared this shape — here it lives once).
#
#   OP_FN ITEM     perform the action; exit 0 = success. stdout+stderr are
#                  captured and, on failure, shown after the ✗.
#   LABEL_FN ITEM  echo the text used for this item in the summary.
#
# Prints "PAST n NOUN:" then the ✓ lines; on any failure also
# "Failed to PRESENT m NOUN:" then the ✗ lines. Returns 1 if every item failed.
log::batch_apply() {
  local past=$1 present=$2 noun=$3 op=$4 label=$5
  shift 5

  local item err
  local -a ok=() fail_label=() fail_err=()
  for item in "$@"; do
    if err=$("$op" "$item" 2>&1); then
      ok+=("$("$label" "$item")")
    else
      fail_label+=("$("$label" "$item")")
      fail_err+=("${err%%$'\n'*}") # first line only, like the Rust git2 error
    fi
  done

  local i
  printf '%s %d %s:\n' "$past" "${#ok[@]}" "$noun"
  if [ "${#ok[@]}" -gt 0 ]; then
    for i in "${!ok[@]}"; do
      printf '  %s %s\n' "$(colour::green '✓')" "${ok[$i]}"
    done
  fi

  if [ "${#fail_label[@]}" -gt 0 ]; then
    printf 'Failed to %s %d %s:\n' "$present" "${#fail_label[@]}" "$noun"
    for i in "${!fail_label[@]}"; do
      printf '  %s %s: %s\n' "$(colour::red '✗')" "${fail_label[$i]}" "${fail_err[$i]}"
    done
  fi

  [ "${#ok[@]}" -gt 0 ] || return 1
}

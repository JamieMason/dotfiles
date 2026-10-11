#!/usr/bin/env bash
# Path helpers — port of git_utils.rs repo_relative_to_cwd / abs_path_to_relative,
# so a file list reads the same whether a command is run from the repo root or a
# subdirectory. Pure bash (no `realpath --relative-to`, which macOS lacks).

# path::rel_to_cwd ABS_PATH -> ABS_PATH expressed relative to $PWD (with ../).
path::rel_to_cwd() {
  local -a t b
  # pwd -P (physical, symlinks resolved) to match git rev-parse --show-toplevel,
  # which is physical too — otherwise /var vs /private/var diverge on macOS.
  IFS=/ read -r -a t <<< "$1"
  IFS=/ read -r -a b <<< "$(pwd -P)"

  local i=0
  while [ "$i" -lt "${#t[@]}" ] && [ "$i" -lt "${#b[@]}" ] && [ "${t[$i]}" = "${b[$i]}" ]; do
    i=$((i + 1))
  done

  local out="" j
  for (( j = i; j < ${#b[@]}; j++ )); do out+="../"; done
  for (( j = i; j < ${#t[@]}; j++ )); do out+="${t[$j]}/"; done
  out=${out%/}
  printf '%s' "${out:-.}"
}

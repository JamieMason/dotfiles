#!/usr/bin/env bash
# File-status rendering, shared by gl (files in commits) and gs (working tree).
# Ports gs.rs status_colour / format_coloured_status.

# status::mark STATUS -> the status char, coloured (A green, M yellow, D/? red).
status::mark() {
  case "${1:0:1}" in
    A)   colour::green  A ;;
    M)   colour::yellow M ;;
    D)   colour::red    D ;;
    '?') colour::red    '?' ;;
    *)   printf '%s' "${1:0:1}" ;;
  esac
}

# status::render ROOT  < STATUS<TAB>REPO_PATH  -> PATH<TAB>COLOURED
# PATH is cwd-relative (and the fzf key); COLOURED is "<mark> <path>".
# Deduplicates by path.
status::render() {
  local root=$1 st rp path seen=""
  while IFS="$TAB" read -r st rp; do
    [ -z "$rp" ] && continue
    path=$(path::rel_to_cwd "$root/$rp")
    case "$TAB$seen" in *"$TAB$path$TAB"*) continue ;; esac
    seen+="$path$TAB"
    printf '%s%s%s %s\n' "$path" "$TAB" "$(status::mark "$st")" "$path"
  done
}

#!/usr/bin/env bash
# GitHub URL handling, shared by gb and gl. Ports gl.rs parse_github_url /
# get_github_repo_info / open_on_github.

# github::repo_from_url URL -> "user/repo" for an https or ssh URL, else non-zero.
github::repo_from_url() {
  local path=${1%.git}
  case $path in
    https://github.com/*) path=${path#https://github.com/} ;;
    http://github.com/*)  path=${path#http://github.com/} ;;
    git@github.com:*)     path=${path#git@github.com:} ;;
    *) return 1 ;;
  esac
  local user=${path%%/*} rest=${path#*/} repo
  repo=${rest%%/*}
  [ -n "$user" ] && [ -n "$repo" ] || return 1
  printf '%s/%s' "$user" "$repo"
}

# github::open_commits HASH... -> open each commit's page in the browser.
github::open_commits() {
  local repo hash target
  repo=$(github::repo_from_url "$(git::origin_url)") ||
    { echo "Could not determine GitHub repo" >&2; return 1; }
  for hash in "$@"; do
    target="https://github.com/$repo/commit/$hash"
    printf 'Opening: %s\n' "$target"
    platform::open "$target" || echo "Failed to open URL" >&2
  done
}

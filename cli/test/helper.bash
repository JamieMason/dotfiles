# shellcheck shell=bash
# Shared bats helpers for the bash-port test suite.

BASH_PORT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LIB="$BASH_PORT_ROOT/lib"
BIN="$BASH_PORT_ROOT/bin"

# Source every library module (unit tests work against these directly).
load_libs() {
  local mod
  for mod in colors platform paths github status files commits log ui git branch_list; do
    # shellcheck source=/dev/null
    source "$LIB/$mod.sh"
  done
}

# Source a command's handlers without running main (the source-guard sees that
# it was sourced, not executed). Then relax the script's strict mode, which is
# for real runs, not for driving functions from a test.
load_cmd() {
  # shellcheck source=/dev/null
  source "$BIN/$1"
  set +e +u +o pipefail
}

# Strip ANSI colour so assertions match plain text.
strip_ansi() { sed $'s/\x1b\\[[0-9;]*m//g'; }

# Fresh throwaway git repo, cd'd into, with a deterministic identity.
setup_repo() {
  REPO="$(mktemp -d)"
  cd "$REPO" || return 1
  git init -q -b main
  git config user.email test@example.com
  git config user.name "Test"
  git config commit.gpgsign false
}

teardown_repo() {
  cd / || true
  [ -n "${REPO:-}" ] && rm -rf "$REPO"
}

# commit FILE CONTENT MESSAGE
commit() {
  printf '%s\n' "$2" > "$1"
  git add "$1"
  git commit -q -m "$3"
}

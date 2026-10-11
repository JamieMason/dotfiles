#!/usr/bin/env bash
# OS-specific glue. One function per capability so the rest of the code never
# branches on `uname`. Replaces the Rust `open` and `trash` crates.

# platform::open FILE_OR_URL — open with the OS default handler.
platform::open() {
  if command -v open >/dev/null 2>&1; then
    open "$1"
  elif command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$1"
  else
    echo "no opener found (install xdg-open)" >&2
    return 1
  fi
}

# platform::trash PATH — move to the OS trash. Never `rm`: the Rust used the
# `trash` crate precisely so `undo` on an untracked file is recoverable.
platform::trash() {
  if command -v trash >/dev/null 2>&1; then
    trash "$1"
  elif command -v trash-put >/dev/null 2>&1; then
    trash-put "$1"
  elif command -v gio >/dev/null 2>&1; then
    gio trash "$1"
  else
    echo "no trash command found (install trash-cli)" >&2
    return 1
  fi
}

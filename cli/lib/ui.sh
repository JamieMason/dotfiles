#!/usr/bin/env bash
# Interactive pickers — the entire `prompt.rs` + crossterm raw-mode module
# collapses into thin wrappers over fzf. fzf owns the cursor, scrolling,
# colours (--ansi) and its own alternate screen, so by the time a command
# prints its summary we are always back on the normal screen.
#
# Convention for multi-column pickers: each input line is
#   KEY<TAB>DISPLAY
# fzf shows only DISPLAY (`--with-nth=2..`) but returns the whole line, so we
# recover the machine-readable KEY with `cut -f1`. No fragile parsing of
# coloured text back into values (which the Rust had to do).

TAB=$'\t'

# Shared flags for every picker.
ui::_fzf() { fzf --ansi --reverse --header-first "$@"; }

# ui::pick_many HEADER  < KEY<TAB>DISPLAY lines  -> selected KEYs, one per line
ui::pick_many() {
  ui::_fzf --multi \
    --delimiter="$TAB" --with-nth=2.. \
    --header="$1" \
    --bind 'ctrl-a:toggle-all' | cut -f1
}

# ui::pick_one HEADER  < plain lines  -> the chosen line
ui::pick_one() {
  ui::_fzf --header="$1"
}

# ui::read_items  < newline-separated lines  -> fills the array UI_ITEMS.
# Kept as a helper (not inlined) because bash 3.2 — still shipping on macOS —
# has no `mapfile`/`readarray`. Call with a here-string so it runs in the
# current shell: `ui::read_items <<< "$selected"`.
ui::read_items() {
  UI_ITEMS=()
  local line
  while IFS= read -r line; do
    [ -n "$line" ] && UI_ITEMS+=("$line")
  done
}

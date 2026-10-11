#!/usr/bin/env bash
# ANSI colour helpers.
#
# These are functions rather than bare variables so call sites read as
# `colour::red "$name"` — greppable, and the escape sequences live in exactly
# one place. fzf renders them because every picker runs with `--ansi`.

colour::red()       { printf '\033[31m%s\033[0m' "$1"; }
colour::green()     { printf '\033[32m%s\033[0m' "$1"; }
colour::blue()      { printf '\033[34m%s\033[0m' "$1"; }
colour::blue_bold() { printf '\033[1;34m%s\033[0m' "$1"; }
colour::yellow()    { printf '\033[33m%s\033[0m' "$1"; }
colour::dim()       { printf '\033[2m%s\033[0m' "$1"; }

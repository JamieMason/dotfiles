#!/usr/bin/env bash
# Git queries and plumbing. This is the module that replaces libgit2/git2 and
# the hand-written parts of git_utils.rs: git itself computes relative dates
# (%cr), does fast-forward-or-merge, and so on.
#
# Fields are TAB-separated (TAB from ui.sh) so they slot into the fzf
# KEY<TAB>DISPLAY convention.

git::is_repo()        { git rev-parse --git-dir >/dev/null 2>&1; }
git::current_branch() { git symbolic-ref --quiet --short HEAD; } # fails on detached HEAD
git::root()           { git rev-parse --show-toplevel; }

# Branches under REFS (default refs/heads/), newest commit first. Replaces
# collect_branch_info + both hand-written date formatters in one call. Any args
# after REFS are forwarded to `git for-each-ref` (e.g. --count=10, or an extra
# ref pattern).
#   name <TAB> subject <TAB> abs-date <TAB> rel-date <TAB> author
# Symbolic refs (e.g. refs/remotes/origin/HEAD, whose short name is just
# "origin") emit an empty line, which branch_list skips.
git::branches_meta() {
  local refs=${1:-refs/heads/}
  shift 2>/dev/null || true
  git for-each-ref --sort=-committerdate "$refs" \
    --format="%(if)%(symref)%(then)%(else)%(refname:short)${TAB}%(contents:subject)${TAB}%(committerdate:format:%a %-d %b %H:%M)${TAB}%(committerdate:relative)${TAB}%(authorname)%(end)" "$@"
}

# Commit rows for the given revisions/options, in git's order (newest first).
#   unix-time <TAB> short-hash <TAB> subject <TAB> "abs (rel)" <TAB> author
git::commit_rows() {
  git log --date=format:'%a %-d %b %H:%M' \
    --format="%ct${TAB}%h${TAB}%s${TAB}%cd (%cr)${TAB}%an" "$@"
}

# Files touched by a commit: "<status><TAB><repo-relative-path>" per line.
# --root so an initial commit lists its files (no parent to diff against).
git::commit_files() { git diff-tree --root --no-commit-id --name-status -r "$1"; }

# URL of origin, else the first remote.
git::origin_url() {
  git remote get-url origin 2>/dev/null ||
    git remote get-url "$(git remote | head -1)" 2>/dev/null
}

# Mutations shared by gb and gbr. Each self-heals on conflict so the working
# tree is never left mid-operation, and leaves git's own error on stderr for
# the ✗ summary.
git::merge()       { git merge --no-edit "$1" || { git merge --abort      >/dev/null 2>&1; return 1; }; }
git::rebase()      { git rebase "$1"          || { git rebase --abort     >/dev/null 2>&1; return 1; }; }
git::cherry_pick() { git cherry-pick "$1"     || { git cherry-pick --abort >/dev/null 2>&1; return 1; }; }

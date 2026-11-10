#!/usr/bin/env bash
# Builds a new vault from the template in vault/ and makes its first commit.
# Usage: ./install.sh [path]    (default: ~/vault)
set -euo pipefail

fail() { echo "install.sh: $*" >&2; exit 1; }

case "${1:-}" in
  -h|--help) sed -n '2,3s/^# //p' "$0"; exit 0 ;;
esac

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/vault"
dest="${1:-$HOME/vault}"
dest="${dest/#\~/$HOME}"
# Remove trailing slashes. With a slash, the symlink check below sees the link's target.
while [ "$dest" != "/" ] && [ "${dest%/}" != "$dest" ]; do dest="${dest%/}"; done

[ -d "$src" ] || fail "can't find the template at $src. Run this from a clone of the repo."
command -v git >/dev/null || fail "git isn't installed."
# Refuse to touch anything that already has content.
if [ -L "$dest" ]; then
  fail "$dest is a symlink. Give the real path of the folder instead. Nothing was changed."
fi
if [ -e "$dest" ] && [ ! -d "$dest" ]; then
  fail "$dest is a file. Pick another path. Nothing was changed."
fi
if [ -d "$dest" ] && [ -n "$(ls -A "$dest")" ]; then
  fail "$dest already exists and isn't empty. Pick another path or move it first. Nothing was changed."
fi

# A vault inside another repo would get swept into that repo's history.
# Check the folder itself if it exists, otherwise its nearest existing parent.
check="$dest"
while [ ! -d "$check" ]; do check="$(dirname "$check")"; done
if git -C "$check" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  fail "$dest would sit inside the git repo at $(git -C "$check" rev-parse --show-toplevel). Put the vault in a folder of its own, for example ~/vault. Nothing was changed."
fi

# Read the identity from outside any repo, so a repo's local config can't stand in for it.
if ! git -C "$check" config user.name >/dev/null || ! git -C "$check" config user.email >/dev/null; then
  fail "git has no user.name or user.email yet. Set them with 'git config --global', then run this again. Nothing was changed."
fi

# If anything below fails, undo it so a second run starts clean.
[ -d "$dest" ] && created=0 || created=1
mkdir -p "$dest"
dest="$(cd "$dest" && pwd)"
cleanup() {
  if [ "$created" = 1 ]; then rm -rf "$dest"; else find "$dest" -mindepth 1 -delete; fi
  echo "install.sh: setup failed, so the files it copied were removed." >&2
}
trap cleanup ERR

cp -RP "$src/." "$dest/"
chmod +x "$dest/.claude/hooks/commit-reminder.sh"

git -C "$dest" init -q
git -C "$dest" add -A
# useConfigOnly stops git from making up an author from the machine name.
git -C "$dest" -c user.useConfigOnly=true commit -q -m "start vault"
trap - ERR

echo "Vault created at $dest ($(git -C "$dest" ls-files | wc -l | tr -d ' ') files, first commit made)."
echo
echo "Next:"
echo "  Work in the vault:      cd \"$dest\" and start your agent there"
echo "  Work in a code repo:    claude --add-dir \"$dest\""
echo "  Finish setup:           start your agent in the vault and paste in $(dirname "$src")/SETUP_PROMPT.md"
echo "                          (everything below the line). It asks a few questions and skips the install."

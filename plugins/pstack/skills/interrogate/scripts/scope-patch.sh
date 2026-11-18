#!/usr/bin/env bash
# Save the working tree's changes against HEAD (untracked and binary files included) as one
# patch an adversary can apply in a worktree that started elsewhere. The real index is untouched.
# Usage: scope-patch.sh <dir>. Prints the HEAD sha, then the patch path (an empty line when nothing is uncommitted).
set -euo pipefail
dir="${1:?usage: scope-patch.sh <dir>}"
mkdir -p "$dir"
dir=$(cd "$dir" && pwd -P)
sha=$(git rev-parse HEAD)
patch="$dir/scope-${sha:0:12}-$$.patch"
idx=$(mktemp)
trap 'rm -f "$idx"' EXIT
export GIT_INDEX_FILE="$idx" GIT_LITERAL_PATHSPECS=1
top=$(git rev-parse --show-toplevel)
cd "$top"
git read-tree HEAD
git add -u
git ls-files -z -o --exclude-standard | xargs -0 -r git add --
git -c diff.noprefix=false diff-index --cached -p --binary --no-color HEAD > "$patch"
[ -s "$patch" ] || { rm -f "$patch"; patch=; }
echo "$sha"
echo "$patch"

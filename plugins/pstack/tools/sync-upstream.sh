#!/usr/bin/env bash
# Bring a newer cursor/plugins pstack into this Claude Code port with a 3-way merge.
#   base   = upstream at the commit pinned in tools/UPSTREAM (what this port was made from)
#   theirs = upstream at <ref> (default: main)
#   ours   = the ported files in this plugin
# Upstream edits land on top of the port. Lines both sides changed become conflict markers.
# The pin in tools/UPSTREAM moves only when the run ends with no conflict. After resolving
# conflicts by hand, record the new base with: sync-upstream.sh --pin <sha>
# Usage: bash plugins/pstack/tools/sync-upstream.sh [ref]
set -euo pipefail

plugin="$(cd "$(dirname "$0")/.." && pwd)"
pin="$plugin/tools/UPSTREAM"

set_pin() {
	sed -i.bak "s/^commit[[:space:]].*/commit $1/" "$pin" && rm "$pin.bak"
	[ -n "${2:-}" ] && sed -i.bak "s/^version[[:space:]].*/version $2/" "$pin" && rm "$pin.bak"
	return 0
}

if [ "${1:-}" = "--pin" ]; then
	[ -n "${2:-}" ] || { echo "usage: sync-upstream.sh --pin <sha> [version]" >&2; exit 2; }
	set_pin "$2" "${3:-}"
	echo "pinned $2"
	exit 0
fi

ref="${1:-main}"
repo_url=$(sed -n 's/^repo[[:space:]]*//p' "$pin")
base=$(sed -n 's/^commit[[:space:]]*//p' "$pin")
not_ported=$(sed -n 's/^not-ported[[:space:]]*//p' "$pin")
[ -n "$base" ] && [ -n "$repo_url" ] || { echo "tools/UPSTREAM needs 'repo <url>' and 'commit <sha>' lines" >&2; exit 2; }

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
git clone --quiet --filter=blob:none --no-checkout "$repo_url" "$work/up"
git -C "$work/up" fetch --quiet origin "$ref"
theirs=$(git -C "$work/up" rev-parse FETCH_HEAD)
if [ "$theirs" = "$base" ]; then
	echo "already at $base"
	exit 0
fi

excluded() {
	local p
	for p in $not_ported; do
		case "$1" in "$p" | "$p"/*) return 0 ;; esac
	done
	return 1
}

# upstream path -> path inside this plugin. Anything not mapped is not ported.
map_path() {
	excluded "$1" && return 1
	case "$1" in
		pstack/skills/* | pstack/agents/* | pstack/docs/*) echo "${1#pstack/}" ;;
		cursor-team-kit/skills/deslop/* | cursor-team-kit/skills/control-ui/* | cursor-team-kit/skills/control-cli/*)
			echo "${1#cursor-team-kit/}" ;;
		*) return 1 ;;
	esac
}

scope=(pstack cursor-team-kit/skills/deslop cursor-team-kit/skills/control-ui cursor-team-kit/skills/control-cli)
show() { git -C "$work/up" show "$1:$2" > "$3" 2>/dev/null; }
# Carry upstream's exec bit, which a copy through a temp file would drop.
apply_mode() { [ "$(git -C "$work/up" ls-tree "$theirs" -- "$1" | cut -c1-6)" = 100755 ] && chmod +x "$2"; return 0; }

report="$work/report"
: > "$report"

# --no-renames: a rename is a delete plus an add, so the old ported path still gets REMOVED or KEPT.
git -C "$work/up" diff --no-renames --name-only "$base" "$theirs" -- "${scope[@]}" | while IFS= read -r up; do
	if ! ours_rel=$(map_path "$up"); then
		excluded "$up" || echo "UNMAPPED  $up (changed upstream, outside the ported paths: check whether the port needs it)" >> "$report"
		continue
	fi
	ours="$plugin/$ours_rel"
	b="$work/base" t="$work/theirs"
	has_base=1; show "$base" "$up" "$b" || { has_base=0; : > "$b"; }
	has_theirs=1; show "$theirs" "$up" "$t" || has_theirs=0

	if [ ! -e "$ours" ]; then
		if [ "$has_theirs" = 0 ]; then continue; fi
		if [ "$has_base" = 1 ]; then
			echo "PORT-DELETED $ours_rel (the port removed it and upstream changed it: decide by hand, or add it to not-ported)" >> "$report"
		else
			mkdir -p "$(dirname "$ours")"
			cp "$t" "$ours"
			apply_mode "$up" "$ours"
			echo "ADDED     $ours_rel (new upstream: port it, then run lint-port.sh)" >> "$report"
		fi
		continue
	fi

	if [ "$has_theirs" = 0 ]; then
		if cmp -s "$ours" "$b"; then
			rm "$ours"
			echo "REMOVED   $ours_rel (deleted upstream)" >> "$report"
		else
			echo "KEPT      $ours_rel (deleted upstream, but the port changed it: decide by hand)" >> "$report"
		fi
		continue
	fi

	if ! grep -Iq . "$t" 2>/dev/null && [ -s "$t" ]; then
		if cmp -s "$ours" "$b"; then cp "$t" "$ours"; apply_mode "$up" "$ours"; echo "UPDATED   $ours_rel (binary)" >> "$report"
		else echo "CONFLICT  $ours_rel (binary changed on both sides)" >> "$report"; fi
		continue
	fi
	if git merge-file -L port -L "upstream@${base:0:12}" -L "upstream@${theirs:0:12}" "$ours" "$b" "$t"; then
		apply_mode "$up" "$ours"
		echo "MERGED    $ours_rel" >> "$report"
	else
		echo "CONFLICT  $ours_rel (resolve the <<<<<<< markers)" >> "$report"
	fi
done

upstream_version=$(git -C "$work/up" show "$theirs:pstack/.cursor-plugin/plugin.json" 2>/dev/null | sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')

sort "$report"
echo
echo "upstream: ${base:0:12} -> ${theirs:0:12} (pstack ${upstream_version:-?})"
if grep -q '^CONFLICT\|^PORT-DELETED\|^KEPT' "$report"; then
	echo "pin NOT moved. Resolve every CONFLICT, PORT-DELETED and KEPT line, then run:"
	echo "  bash plugins/pstack/tools/sync-upstream.sh --pin $theirs ${upstream_version}"
	exit 1
fi
set_pin "$theirs" "$upstream_version"
echo "pinned $theirs. Next: port ADDED files, check UNMAPPED lines, bump .claude-plugin/plugin.json to ${upstream_version}-claude.1,"
echo "then run tools/lint-port.sh, tools/test-hooks.sh and claude plugin validate --strict."

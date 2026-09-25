#!/usr/bin/env bash
# Fallback install: pstack as project skills inside one repository, the form a Claude Code
# cloud session loads from the clone itself. Prefer the account-level plugin (README), and
# remove this fallback once the plugin loads, or both copies' hooks will run.
#
# When the plugin lives outside the target repo, it is copied into <repo>/.claude/pstack/
# so every link is relative and survives a fresh clone. Then skills/* are linked into
# <repo>/.claude/skills/ and agents/* into <repo>/.claude/agents/, and the hooks block to
# merge into <repo>/.claude/settings.json is printed. Commit .claude/ afterwards.
# Usage: bash plugins/pstack/tools/install-as-project-skills.sh [repo-dir] [--force]
#   --force  repoint links that already exist and point somewhere else (for example an old pstack copy)
set -euo pipefail

plugin="$(cd "$(dirname "$0")/.." && pwd -P)"
project="$(pwd -P)"
force=0
for arg in "$@"; do
	case "$arg" in
		--force) force=1 ;;
		*) project="$(cd "$arg" && pwd -P)" ;;
	esac
done

case "$plugin/" in
	"$project"/*)
		source_dir="$plugin"
		from_links="../../${plugin#"$project"/}"
		hook_root="\$CLAUDE_PROJECT_DIR/${plugin#"$project"/}"
		;;
	*)
		source_dir="$project/.claude/pstack"
		marker="$source_dir/.pstack-vendored"
		if [ -e "$source_dir" ] && [ ! -e "$marker" ]; then
			echo "$source_dir exists and was not created by this script: move it first" >&2
			exit 1
		fi
		rm -rf "$source_dir"
		mkdir -p "$source_dir"
		for part in .claude-plugin agents hooks skills LICENSE LICENSE.cursor-team-kit README.md; do
			cp -R "$plugin/$part" "$source_dir/"
		done
		find "$source_dir" -name node_modules -type d -prune -exec rm -rf {} +
		version=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$plugin/.claude-plugin/plugin.json" | head -n 1)
		echo "pstack $version copied from $plugin" > "$marker"
		from_links="../pstack"
		hook_root="\$CLAUDE_PROJECT_DIR/.claude/pstack"
		echo "copied pstack $version into $source_dir"
		;;
esac

mkdir -p "$project/.claude/skills" "$project/.claude/agents"
linked=0 skipped=0

link() {
	local target="$1" dest="$2"
	if [ -L "$dest" ]; then
		[ "$(readlink "$dest")" = "$target" ] && return 0
		if [ "$force" = 1 ]; then
			ln -sfn "$target" "$dest"; linked=$((linked + 1))
		else
			echo "skip $dest -> $(readlink "$dest") (use --force to repoint)"; skipped=$((skipped + 1))
		fi
	elif [ -e "$dest" ]; then
		echo "skip $dest (a real file or directory, not a link: move it first)"; skipped=$((skipped + 1))
	else
		ln -s "$target" "$dest"; linked=$((linked + 1))
	fi
}

for d in "$source_dir"/skills/*/; do
	name=$(basename "$d")
	link "$from_links/skills/$name" "$project/.claude/skills/$name"
done
for a in "$source_dir"/agents/*.md; do
	name=$(basename "$a")
	link "$from_links/agents/$name" "$project/.claude/agents/$name"
done

echo "linked $linked, skipped $skipped"
cat <<EOF

Merge this into $project/.claude/settings.json under "hooks" (keep any hooks already there):

  "SessionStart": [
    { "hooks": [ { "type": "command", "command": "bash \\"$hook_root/hooks/session-start.sh\\" || true", "timeout": 10 } ] }
  ],
  "UserPromptSubmit": [
    { "hooks": [ { "type": "command", "command": "bash \\"$hook_root/hooks/poteto-mode-sticky.sh\\" || true", "timeout": 5 } ] }
  ]

Then commit .claude/ in $project. Remove this fallback once the account-level plugin loads.
EOF

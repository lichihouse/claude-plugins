#!/usr/bin/env bash
# Generate agents/poteto-agent-<effort>.md from agents/poteto-agent.md.
# Claude Code sets reasoning effort per agent definition, not per Agent call, so a model map
# value such as `opus medium` spawns pstack:poteto-agent-medium with model opus.
# Every frontmatter key of the base except name and description is copied, then effort is set.
# Usage: bash plugins/pstack/tools/gen-agent-variants.sh [out-dir]   (default: the plugin's agents/)
# lint-port.sh regenerates into a temp dir and fails when the committed variants drift.
set -euo pipefail
plugin="$(cd "$(dirname "$0")/.." && pwd -P)"
base="$plugin/agents/poteto-agent.md"
out="${1:-$plugin/agents}"
mkdir -p "$out"

# Skipped keys drop their indented continuation lines too (folded or block descriptions).
keys=$(awk '{ sub(/\r$/, "") } n == 1 && /^---$/ { exit } n == 1 && /^(name|description|effort):/ { skip = 1; next } n == 1 && skip && /^[ \t]/ { next } n == 1 { skip = 0; print } /^---$/ { n++ }' "$base")
body=$(awk '{ sub(/\r$/, "") } n >= 2 { print; next } /^---$/ { n++ }' "$base")
for effort in low medium high xhigh max; do
	{
		echo "---"
		echo "name: poteto-agent-$effort"
		echo "description: pstack:poteto-agent at $effort reasoning effort. Spawn it, with the role's model, when a pstack model map line names that effort (for example \`opus $effort\`). Otherwise use pstack:poteto-agent."
		[ -n "$keys" ] && printf '%s\n' "$keys"
		echo "effort: $effort"
		echo "---"
		printf '%s\n' "$body"
	} > "$out/poteto-agent-$effort.md"
done

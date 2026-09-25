#!/usr/bin/env bash
# Generate agents/poteto-agent-<effort>.md from agents/poteto-agent.md.
# Claude Code sets reasoning effort per agent definition, not per Agent call, so a model map
# value such as `opus medium` spawns pstack:poteto-agent-medium with model opus.
# Usage: bash plugins/pstack/tools/gen-agent-variants.sh [out-dir]   (default: the plugin's agents/)
# lint-port.sh regenerates into a temp dir and fails when the committed variants drift.
set -euo pipefail
plugin="$(cd "$(dirname "$0")/.." && pwd -P)"
base="$plugin/agents/poteto-agent.md"
out="${1:-$plugin/agents}"
mkdir -p "$out"

body=$(awk 'n >= 2 { print; next } /^---$/ { n++ }' "$base")
for effort in low medium high xhigh max; do
	cat > "$out/poteto-agent-$effort.md" <<EOF
---
name: poteto-agent-$effort
description: pstack:poteto-agent at $effort reasoning effort. Spawn it, with the role's model, when a pstack model map line names that effort (for example \`opus $effort\`). Otherwise use pstack:poteto-agent.
background: true
effort: $effort
---
$body
EOF
done

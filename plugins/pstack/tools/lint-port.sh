#!/usr/bin/env bash
# Fail when pstack files still use Cursor-only mechanics, or break Claude Code's rules.
# Run after every upstream sync: bash plugins/pstack/tools/lint-port.sh
set -u
plugin="$(cd "$(dirname "$0")/.." && pwd)"
cd "$plugin" || exit 2

# Agent-facing text (skills, agents, hooks). docs/ gets the same list minus the last
# entry, because the guide may name where a bundled skill came from.
patterns=(
	'\.cursor/|~/\.cursor'
	'pstack-models\.mdc'
	'generalPurpose'
	'\bAskQuestion\b|allow_multiple'
	'`readonly`|readonly: (true|false)'
	'environment: "(cloud|local)"|cloud_base_branch'
	'agent-transcripts|path in the system prompt|agent'"'"'?s store|agent store'
	'grok-[0-9]|gpt-5|sol-max|composer-[0-9]|cursor-grok'
	'`Task` (tool|call|prompt)|the Task tool|Task subagent'
	'subagent_type`?:?[[:space:]]*[`"](poteto-agent|reader|comment-sicko|Comment Sicko)[`"]'
	'(^|[^/>a-z.])pstack/skills/'
	'create-skill([^-]|$)'
	'model famil|cloud (worker|spawn|default|agent)|Cursor dashboard|Cursor cloud agent|cloud-sleeper'
	'a full model ID'
	'^is_background:|^mode: true|^reminder:'
	"Cursor's built-in|cursor-team-kit"
)
last=$((${#patterns[@]} - 1))

status=0
scan() {
	local p="$1"; shift
	local hits
	hits=$(grep -rnIE --exclude-dir=node_modules "$p" "$@" --include='*.md' --include='*.sh' --include='*.mjs' --include='*.json' 2>/dev/null)
	if [ -n "$hits" ]; then
		printf 'Cursor-only or invalid pattern /%s/:\n%s\n\n' "$p" "$hits"
		status=1
	fi
}
for i in "${!patterns[@]}"; do
	scan "${patterns[$i]}" skills agents hooks
	[ "$i" -lt "$last" ] && scan "${patterns[$i]}" docs
done

# Conflict markers from sync-upstream.sh, in any text file (scripts included).
hits=$(grep -rnIE --exclude-dir=node_modules '^(<<<<<<<|>>>>>>>) (port|upstream@)' . 2>/dev/null)
[ -n "$hits" ] && { printf 'Unresolved sync conflict markers:\n%s\n\n' "$hits"; status=1; }

# A disable-model-invocation skill is reached by Read-by-path from playbooks and subagents,
# where ${CLAUDE_SKILL_DIR} stays literal. Allowed only on a line that also gives <pstack root>.
for f in skills/*/SKILL.md; do
	grep -q '^disable-model-invocation: true' "$f" || continue
	hits=$(grep -nE '\$\{CLAUDE_(SKILL_DIR|PLUGIN_ROOT)\}' "$f" | grep -v '<pstack root>')
	[ -n "$hits" ] && { printf '%s: ${CLAUDE_*} in a read-by-path skill, use <pstack root>:\n%s\n\n' "$f" "$hits"; status=1; }
done

# ${CLAUDE_*} is substituted only in SKILL.md and agent bodies. A playbook or reference
# that a skill later Reads would show it literally, so those use <pstack root>.
hits=$(grep -rnE --exclude-dir=node_modules '\$\{CLAUDE_(PLUGIN_ROOT|SKILL_DIR|PROJECT_DIR)\}' skills --include='*.md' | grep -v '/SKILL\.md:')
[ -n "$hits" ] && { printf '${CLAUDE_*} outside SKILL.md (not substituted there):\n%s\n\n' "$hits"; status=1; }

for f in skills/*/SKILL.md; do
	name=$(sed -n 's/^name:[[:space:]]*//p' "$f" | head -n 1)
	dir=$(basename "$(dirname "$f")")
	if [ "$name" != "$dir" ]; then
		echo "$f: name '$name' must equal folder '$dir' (lowercase kebab-case)"
		status=1
	fi
done
for f in agents/*.md; do
	name=$(sed -n 's/^name:[[:space:]]*//p' "$f" | head -n 1)
	if ! printf '%s' "$name" | grep -qE '^[a-z][a-z0-9-]*$'; then
		echo "$f: agent name '$name' must be lowercase kebab-case with no ':'"
		status=1
	fi
done

# agents/poteto-agent-<effort>.md are generated from agents/poteto-agent.md.
variants=$(mktemp -d)
bash tools/gen-agent-variants.sh "$variants"
for f in "$variants"/*.md; do
	if ! cmp -s "$f" "agents/$(basename "$f")"; then
		echo "agents/$(basename "$f") is out of date: run tools/gen-agent-variants.sh"
		status=1
	fi
done
rm -r "$variants"

# The SessionStart hook reads the default model map from this fenced block.
roles=$(awk '/^# pstack model map\./ { on = 1; next } on && /^```/ { exit } on && /^[a-z][a-z ,-]*:/ { n++ } END { print n + 0 }' skills/setup-pstack/SKILL.md)
if [ "$roles" != 17 ]; then
	echo "skills/setup-pstack/SKILL.md: default model map has $roles role lines, expected 17 (anchor line '# pstack model map.')"
	status=1
fi

[ "$status" -eq 0 ] && echo "lint-port: clean"
exit "$status"

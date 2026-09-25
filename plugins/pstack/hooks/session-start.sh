#!/usr/bin/env bash
# SessionStart: stdout becomes session context. Stands in for the always-applied
# model rule and the transcript and scratch paths that Cursor names in its system prompt.
set -u

root="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
input=$(cat)

json_field() {
	printf '%s' "$input" | sed -n "s/.*\"$1\"[[:space:]]*:[[:space:]]*\"\([^\"]*\)\".*/\1/p" | head -n 1 | sed 's/\\\\/\\/g'
}

transcript=$(json_field transcript_path)
session_id=$(json_field session_id | tr -cd 'A-Za-z0-9_-')
project_dir="${CLAUDE_PROJECT_DIR:-$(json_field cwd)}"
project_dir="${project_dir:-$PWD}"
config_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

defaults_file="$root/skills/setup-pstack/SKILL.md"
user_map="$config_dir/pstack-models.md"
project_map="$project_dir/.claude/pstack-models.md"

sep=/
case "$transcript" in *\\*) sep='\' ;; esac
slug=$(printf '%s' "$project_dir" | sed 's/[^A-Za-z0-9]/-/g')

echo "<pstack>"
echo "pstack root: $root"
if [ -n "${CLAUDE_PLUGIN_ROOT:-}" ]; then
	echo "pstack is loaded as the pstack plugin. Slash commands are /pstack:<name>. Agents are pstack:poteto-agent, pstack:reader, pstack:comment-sicko."
else
	echo "pstack is loaded as project skills (.claude/skills, .claude/agents). Slash commands are /<name>. Agents are poteto-agent, reader, comment-sicko: drop the pstack: prefix wherever pstack text writes one."
fi
echo "Skills are at <pstack root>/skills/<name>/SKILL.md. Most are user-invoked only, so when a pstack step names a skill, Read that file instead of calling the Skill tool. Playbooks write <pstack root> for this path. Pass it to subagents that need pstack files."
echo "pstack store (durable scratch for plans, ledgers, orchestration state; outside the repo): $config_dir/pstack/$slug/"
echo "pstack source: https://github.com/lichihouse/claude-plugins (plugins/pstack). Fix a pstack skill there as a PR with a version bump, never by editing files under <pstack root>, which the next sync overwrites."
echo
echo "pstack transcripts:"
if [ -n "$transcript" ]; then
	tdir=${transcript%[/\\]*}
	echo "- this session: $transcript"
	echo "- this project: $tdir$sep*.jsonl"
	[ -n "$session_id" ] && echo "- this session's subagents: $tdir$sep$session_id${sep}subagents$sep (agent-*.jsonl, also nested under workflows$sep)"
fi
echo "- never read another project's directory under ~/.claude/projects/ unless the user asks."
echo

set -- src=default "$defaults_file"
[ -f "$user_map" ] && set -- "$@" src=user "$user_map"
[ -f "$project_map" ] && set -- "$@" src=project "$project_map"

# One pass: the fenced default table in setup-pstack (anchored on its "# pstack model map." line),
# then the user file, then the project file. Only known role names and model aliases are echoed,
# so text from a repository's map file never reaches context verbatim.
awk '
	function trim(s) { sub(/^[ \t\r]+/, "", s); sub(/[ \t\r]+$/, "", s); return s }
	function norm(v,   a, k, i, x, out) {
		k = split(v, a, ","); out = ""
		for (i = 1; i <= k; i++) { x = trim(a[i]); gsub(/[ \t]+/, " ", x); out = out (i > 1 ? ", " : "") x }
		return out
	}
	function valid(v,   a, k, i) {
		k = split(v, a, ",")
		if (k < 1) return 0
		for (i = 1; i <= k; i++) if (trim(a[i]) !~ /^((fable|opus|sonnet|haiku)([ \t]+(low|medium|high|xhigh|max))?|inherit-parent|auto)$/) return 0
		return 1
	}
	{ sub(/\r$/, "") }
	src == "default" {
		if ($0 ~ /^# pstack model map\./) { inmap = 1; next }
		if (!inmap) next
		if ($0 ~ /^```/) { inmap = 0; next }
	}
	src != "default" && /^#[ \t]*budget:/ {
		b = $0; sub(/^#[ \t]*budget:[ \t]*/, "", b); b = tolower(trim(b)); sub(/[^a-z].*$/, "", b)
		if (b ~ /^(unlimited|large|medium|small)$/) budget[src] = b
		next
	}
	/^[ \t]*#/ || /^[ \t]*$/ { next }
	{
		i = index($0, ":"); if (!i) next
		role = trim(substr($0, 1, i - 1)); val = trim(substr($0, i + 1))
		if (role !~ /^[a-z][a-z ,-]*[a-z]$/) next
		if (src == "default") { order[++n] = role; def[role] = norm(val); next }
		if (!(role in def)) { unknown[src]++; next }
		if (!valid(val)) { bad = bad "(ignored " src " line with a value that is not a model alias: " role ")\n"; next }
		v[src SUBSEP role] = norm(val)
	}
	END {
		if (n == 0) { print "pstack: default model map not found in skills/setup-pstack/SKILL.md (anchor line \"# pstack model map.\")."; exit }
		bud = ("project" in budget) ? budget["project"] : (("user" in budget) ? budget["user"] : "unlimited (skill defaults)")
		print "pstack model map (budget: " bud "). Project .claude/pstack-models.md overrides user ~/.claude/pstack-models.md overrides skill default. inherit-parent or auto means omit the Agent model. An effort word (opus medium) means spawn pstack:poteto-agent-<effort> with that model."
		for (k = 1; k <= n; k++) {
			r = order[k]
			if (("project" SUBSEP r) in v) { val = v["project" SUBSEP r]; s = "project" }
			else if (("user" SUBSEP r) in v) { val = v["user" SUBSEP r]; s = "user" }
			else { val = def[r]; s = "default" }
			print r ": " val "  [" s "]"
		}
		if ("user" in unknown) print "(ignored " unknown["user"] " line(s) with unknown or retired roles in the user map)"
		if ("project" in unknown) print "(ignored " unknown["project"] " line(s) with unknown or retired roles in the project map)"
		printf "%s", bad
	}
' "$@"
echo "</pstack>"

#!/usr/bin/env bash
# UserPromptSubmit: keep poteto-mode on across turns, like Cursor's `mode: true` skill.
# On:  a prompt that starts with /pstack:poteto-mode (plugin) or /poteto-mode (project skills).
# Off: a whole prompt that is only "/pstack:poteto-mode off|stop|exit", "poteto-mode off",
#      "exit poteto-mode", "tắt poteto-mode" and similar. Mentions inside a longer prompt never turn it off.
# While on, each later prompt gets a one-line reminder as context.
set -u

input=$(cat)

session_id=$(printf '%s' "$input" | sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1 | tr -cd 'A-Za-z0-9_-')
[ -n "$session_id" ] || exit 0

# The prompt value only, JSON escapes left in place. Quotes inside it are escaped,
# so a literal "prompt": can only be the key itself.
prompt=$(printf '%s' "$input" | tr '\n' ' ' | sed -nE 's/.*"prompt"[[:space:]]*:[[:space:]]*"(([^"\\]|\\.)*)".*/\1/p' | head -n 1)
prompt=$(printf '%s' "$prompt" | sed -E 's/\\[nrt]/ /g; s/^[[:space:]]+//; s/[[:space:]]+$//')

if [ -n "${CLAUDE_PLUGIN_ROOT:-}" ]; then
	command='/pstack:poteto-mode'
	entry='^/pstack:poteto-mode([^A-Za-z0-9_-]|$)'
else
	command='/poteto-mode'
	entry='^/(pstack:)?poteto-mode([^A-Za-z0-9_-]|$)'
fi

umask 077
state_dir="${CLAUDE_PLUGIN_DATA:-${CLAUDE_CONFIG_DIR:-$HOME/.claude}/pstack/state}/poteto-mode"
flag="$state_dir/$session_id"
mkdir -p "$state_dir" 2>/dev/null || exit 0
# Flags are touched on every reminder, so only sessions idle for 14 days are dropped.
find "$state_dir" -type f -mtime +14 -exec rm -f {} + 2>/dev/null

lower=$(printf '%s' "$prompt" | tr '[:upper:]' '[:lower:]')
off_slash='^/(pstack:)?poteto-mode[[:space:]]+(off|stop|exit)[.!]*$'
off_phrase='^((poteto-mode|poteto mode)[[:space:]]+(off|stop)|(exit|stop|leave|quit|turn off|tắt|thoát)[[:space:]]+(poteto-mode|poteto mode))([[:space:]]+(nhé|nha|đi|please))?[.!]*$'
if printf '%s' "$lower" | grep -qE "$off_slash|$off_phrase"; then
	# The slash form also expands the skill, so say it is off even when no flag existed.
	if [ -f "$flag" ] || printf '%s' "$lower" | grep -qE "$off_slash"; then
		rm -f "$flag"
		echo "pstack: poteto-mode is now off for this session. Do not apply it unless the user asks again."
	fi
	exit 0
fi

if printf '%s' "$prompt" | grep -qE "$entry"; then
	touch "$flag"
	exit 0
fi

if [ -f "$flag" ]; then
	touch "$flag"
	echo "pstack poteto-mode is on. New task? Playbook match or rigor needed -> apply $command (Read <pstack root>/skills/poteto-mode/SKILL.md if it is no longer in context). Casual turn or user opts out -> don't."
fi
exit 0

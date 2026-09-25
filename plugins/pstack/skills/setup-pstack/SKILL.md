---
name: setup-pstack
description: Configure which models pstack uses per role, at what reasoning effort, and at what budget. Detects your available Claude models and writes the pstack model map that overrides the skill defaults. Use for /pstack:setup-pstack, "configure pstack models", "pstack budget", or changing pstack's model choices.
---

# Setup pstack

Write the pstack model map, a small file that sets pstack's model per role, and optionally its reasoning effort. The pstack plugin's SessionStart hook reads it and injects the effective map into every new session, the way an always-applied rule would.

Two locations, merged per role line. A project line wins over a user line, and a role with no line in either keeps the skill default.

- Project: `.claude/pstack-models.md` at the repository root. Commit it to share the choice with the team.
- User: `~/.claude/pstack-models.md`. Applies to every project on this machine.

## Steps

### 1. Detect available models

The `model` parameter of the `Agent` tool is the dependable source. Its schema lists the values this session accepts, normally `fable`, `opus`, `sonnet`, and `haiku`. It takes these aliases only. If you cannot read the schema, ask the user to paste the models they have access to. Never write a model you have not confirmed is available. The alias `inherit-parent` is always valid. It means the role runs on the parent chat model (omit the Agent `model` parameter). `auto` is accepted as a synonym of `inherit-parent` for files carried over from Cursor.

A value may add one effort word after the model or `inherit-parent`: `low`, `medium`, `high`, `xhigh`, or `max` (for example `opus medium`, or `inherit-parent medium` for the parent model at medium effort). Claude Code sets effort per agent definition, not per `Agent` call, so pstack ships `pstack:poteto-agent-<effort>` variants. The effort word applies to the roles that spawn `pstack:poteto-agent`: `feature, refactoring`, `bug-fix`, `perf-issue`, `hillclimb`, `hardest tasks`, and `judgment and prose`. On other roles it has no effect, so do not write one there. The SessionStart hook drops it there and says so. A value without an effort word runs at the session's effort.

### 2. Load current state

The default role-to-model mapping is the shape shown in step 5 below. Read `.claude/pstack-models.md` and `~/.claude/pstack-models.md` if they exist, and treat their `# budget` line and role values as the current choices, project over user. Otherwise start from the defaults. A line whose role is not in step 5, such as `how critics`, is from a retired role. Drop it. A value that is a Cursor slug (`grok-*`, `gpt-*`, `composer-*`, `cursor-*`, `claude-*-max`) is not a Claude Code model. Map it to the closest tier (`claude-opus-*` to `opus`, a fast code model to `sonnet`) and mark it as needing confirmation. A code role (`feature, refactoring`, `bug-fix`, `perf-issue`, `hillclimb`) whose value is exactly `sonnet` is the default of release 0.15.5-claude.1, not a user choice. Move it to the current default and list it as remapped.

### 3. Budget, map, and confirm

**(a) Ask for a budget.** Use `AskUserQuestion`, not free text. Offer these four options with these exact labels, and name the current budget when a file records one.

- `unlimited — fable for the hardest work`
- `large — opus ceiling`
- `medium — sonnet ceiling, opus for judgment`
- `small — sonnet ceiling, haiku for bulk reads`

**(b) Apply it.** Build the working table from the skill defaults, and on a re-run keep any role you changed by model, effort, list, or alias (`inherit-parent`). The budget caps the model tier and leaves effort words as they are. The tier ladder is `fable` > `opus` > `sonnet` > `haiku`.

- `unlimited` leaves every value as in the defaults.
- `large` caps every entry at `opus`, so `fable` becomes `opus`.
- `medium` caps every entry at `sonnet`, except `judgment and prose`, `hardest tasks`, `how explainer`, `why synthesizer`, and `reflect judgment, divergent, synthesizer`, which cap at `opus`.
- `small` caps every entry at `sonnet`, and sets `how explorer`, `why investigators`, and `swarm workers` to `haiku`.

Panel lists keep their length after capping, so an entry can repeat (`fable, opus, sonnet` under `large` is `opus, opus, sonnet`). Say so when it happens. A repeated model is a second run, not a second opinion. `inherit-parent` does not change.

**(c) Show the roles and confirm.** Show every role with its model, marking any value not in the detected set as needing a choice. Also list each line step 2 dropped or remapped. Ask with `AskUserQuestion` whether to accept as-is or change specific roles, and for a changed code role which effort to use (offer `medium`, `high`, `xhigh`, or none). Each question takes 2 to 4 options and the tool adds a free-text answer on its own, so offer the four model aliases and let `inherit-parent` come through that free-text answer, or ask in two steps. For panel roles (arena runners, architect runners, interrogate reviewers) the value is a list, and one subagent runs per entry, alias entries included, so the list length sets the count. `arena cross-judge pool` is also a list, but Arena selects one value from it that differs from the parent's model when possible. `swarm workers` is the default model for every worker unless a race or comparison assigns another model per arm.

**(d) Ask where to write it.** Use `AskUserQuestion` with two options. `project — .claude/pstack-models.md (commit to share with the team)` and `user — ~/.claude/pstack-models.md (this machine, every project)`. Default to the location the current values came from.

### 4. Validate

Every model written must be in the detected set, and every effort word must be one of `low`, `medium`, `high`, `xhigh`, `max`. `inherit-parent` always passes. If a chosen model is not available, stop and ask again.

### 5. Write the map

Write the chosen file with a `# budget` line naming the chosen label and one line per role, using the same labels poteto-mode uses. Overwrite the whole file so re-runs stay idempotent. No YAML frontmatter. Shape (these values are the skill defaults):

```
# pstack model map. One line per role. Delete a line to fall back to the skill default.
# `inherit-parent` as a value: the role runs on the parent chat model (omit the Agent `model`). Alias entries in a panel list still count toward its fan-out.
# An effort word after the model (`opus medium`) spawns pstack:poteto-agent-<effort>. It applies to the code roles, hardest tasks, and judgment and prose.
# Project file (.claude/pstack-models.md) overrides the user file (~/.claude/pstack-models.md) line by line.
# budget: unlimited — fable for the hardest work
feature, refactoring: opus medium
bug-fix: opus medium
perf-issue: opus medium
hillclimb: opus medium
judgment and prose: opus
hardest tasks: fable
how explorer: sonnet
how explainer: opus
why investigators: sonnet
why synthesizer: opus
reflect tooling: sonnet
reflect judgment, divergent, synthesizer: opus
arena runners: fable, opus, sonnet
arena cross-judge pool: fable, opus
swarm workers: sonnet
architect runners: fable, opus, sonnet
interrogate reviewers: fable, opus, sonnet
```

### 6. Confirm

Tell the user which file was written and that it applies to new sessions (the SessionStart hook injects it). In the current session, the new values apply from now on because you just wrote them. Re-running this skill updates it.

### 7. Offer a verification skill (optional)

Check whether the project has a way to drive the real app for proof (a `verify-*` skill under `.claude/skills/`, or an existing harness). If not, offer once: "want a project-local verification skill, so agents can drive the app the way a user does and prove changes work? I can generate one with /pstack:create-verification-skill." On yes, read `${CLAUDE_SKILL_DIR}/../create-verification-skill/SKILL.md` and follow it. On no, move on without pushing.

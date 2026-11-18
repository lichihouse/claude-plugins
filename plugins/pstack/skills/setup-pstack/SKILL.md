---
name: setup-pstack
description: "Cấu hình model và mức nỗ lực (effort) pstack dùng cho từng vai, theo ngân sách. Dò model Claude đang có và ghi bảng model map đè lên mặc định. Use for /pstack:setup-pstack, 'configure pstack models', 'pstack budget', đổi model pstack."
---

# Setup pstack

Write the pstack model map, a small file that sets pstack's model per role, and optionally its reasoning effort. The pstack plugin's SessionStart hook reads it and injects the effective map into every new session, the way an always-applied rule would.

Two locations, merged per role line. A project line wins over a user line, and a role with no line in either keeps the skill default.

- Project: `.claude/pstack-models.md` at the repository root. Commit it to share the choice with the team.
- User: `~/.claude/pstack-models.md`. Applies to every project on this machine.

## Steps

### 1. Detect available models

The `model` parameter of the `Agent` tool is the dependable source. Its schema lists the values this session accepts, normally `fable`, `opus`, `sonnet`, and `haiku`. It takes these aliases only. If you cannot read the schema, ask the user to paste the models they have access to. Never write a model you have not confirmed is available. The alias `inherit-parent` is always valid. It means the role runs on the parent chat model (omit the Agent `model` parameter). `auto` is accepted as a synonym of `inherit-parent` for files carried over from Cursor.

A value may add one effort word after the model or `inherit-parent`: `low`, `medium`, `high`, or `xhigh` (for example `opus medium`, or `inherit-parent medium` for the parent model at medium effort). The Claude apps label these Low, Medium, High, and Extra, so Extra is `xhigh`. No role runs above `xhigh`, so the apps' Max (`max`) reads as `xhigh`. The map also accepts `extra` and `med`. Ultracode in the apps is not an effort level but a session mode (`xhigh` plus workflow orchestration), so `ultracode` in the map reads as `xhigh`. Haiku does not support effort, so an effort word after `haiku` is dropped. Always write the canonical word: the `Agent` tool takes only these and `max`. pstack passes it as the `effort` parameter of the `Agent` call. The effort word applies to the roles that spawn `pstack:poteto-agent`: `feature, refactoring`, `bug-fix`, `perf-issue`, `hillclimb`, `hardest tasks`, and `judgment and prose`. On other roles it has no effect, so do not write one there. The SessionStart hook drops it there and says so. A value without an effort word runs at the session's effort when one is set, else at the model's own default effort. Haiku runs without effort either way. An effort word overrides the session effort, including Extra, Max, and Ultracode. It is still overridden by the `CLAUDE_CODE_EFFORT_LEVEL` environment variable and capped by an organization effort limit.

### 2. Load current state

The default role-to-model mapping is the shape shown in step 5 below. Read `.claude/pstack-models.md` and `~/.claude/pstack-models.md` if they exist, and treat their `# budget` line and role values as the current choices, project over user. Otherwise start from the defaults. A line whose role is not in step 5, such as `how explorer`, `why investigators`, `why synthesizer`, `reflect tooling`, `reflect judgment, divergent, synthesizer`, or `architect runners`, is from a retired role. Drop it. A value that is a Cursor slug (`grok-*`, `gpt-*`, `gemini-*`, `composer-*`, `cursor-*`, `claude-*-max`) is not a Claude Code model. Map it to the closest tier (`claude-fable-*` to `fable`, `claude-opus-*` to `opus`, a fast code model to `sonnet`) and mark it as needing confirmation. Rewrite an app label or alias to its canonical word (`extra` and `ultracode` to `xhigh`, `med` to `medium`), turn `max` into `xhigh` because no role runs above `xhigh`, drop an effort word after `haiku` or on a role outside the ones that spawn `pstack:poteto-agent` (step 1 lists them), and list each as remapped.

A file without the `# defaults: 2` line comes from an older setup. That setup wrote a line for every role, so some of its values are old defaults, not choices. Before step 3, replace these values and tell the user which ones you replaced:

- `hardest tasks: fable` takes its step 5 default.
- An `arena runners` or `interrogate reviewers` list of exactly `fable, opus, sonnet`, and an `arena cross-judge pool` list of exactly `fable, opus`, take the role's step 5 list.
- A `# budget: unlimited` line becomes `large`, because `unlimited` was the old default label.
- If the file also lacks the header line that starts `# An effort word after the model`, release 0.15.5-claude.1 wrote it. In such a file only, a code role (`feature, refactoring`, `bug-fix`, `perf-issue`, `hillclimb`) whose value is exactly `sonnet` is that release's default. It takes the role's step 5 default. In a file that has the header line, `sonnet` on a code role is a deliberate choice.

Every other value is the user's choice and stays, including every `fable` the user set and every `inherit-parent` or `auto` value.

### 3. Budget, map, and confirm

**(a) Ask for a budget.** Use `AskUserQuestion`, not free text. If the session has no `AskUserQuestion` (Claude Projects threads, Remote Control, `-p` runs), ask once in plain text with the same labels, one per line, the recommended one marked, and wait for the answer. The same holds for every later question in this skill. Offer these four options with these exact labels, and name the current budget when a file records one. With no file, say that `large` matches the skill defaults.

- `unlimited — fable for the hardest work`
- `large — opus ceiling`
- `medium — sonnet ceiling, opus for judgment`
- `small — sonnet ceiling, haiku for bulk reads`

**(b) Apply it.** Build the working table from the skill defaults, and on a re-run keep any role you changed by model, effort, list, or alias (`inherit-parent`). The budget sets the model tier and leaves effort words as they are. The tier ladder is `fable` > `opus` > `sonnet` > `haiku`.

- `large` leaves every value as in the defaults.
- `unlimited` sets `hardest tasks` to `fable`, keeping its effort word, and leaves the rest as in `large`. Fable runs nowhere else unless the user puts it on a role.
- `medium` caps every entry at `sonnet`, except `judgment and prose`, `hardest tasks`, and `how explainer`, which cap at `opus`.
- `small` caps every entry at `sonnet`, and sets `swarm workers` to `haiku`.

Panel lists keep their length after capping, so an entry can repeat (`opus, sonnet, sonnet` under `medium` is `sonnet, sonnet, sonnet`). Say so when it happens. A repeated model is a second run, not a second opinion. `inherit-parent` does not change.

**(c) Show the roles and confirm.** Show every role with its model, marking any value not in the detected set as needing a choice. Also list each line step 2 dropped, remapped, or replaced. Ask with `AskUserQuestion` whether to accept as-is or change specific roles, and for a changed code role which effort to use (offer `medium`, `high`, `xhigh (Extra)`, or none). Each question takes 2 to 4 options and the tool adds a free-text answer on its own, so offer the four model aliases and let `inherit-parent` come through that free-text answer, or ask in two steps. For panel roles (arena runners, interrogate reviewers) the value is a list, and one subagent runs per entry, alias entries included, so the list length sets the count. `arena cross-judge pool` is also a list, but Arena runs one judge. It takes the first entry whose model differs from the parent's, in list order, so order it by preference. An `inherit-parent` or `auto` value never judges. `swarm workers` is the default model for every worker unless a race or comparison assigns another model per arm.

**(d) Ask where to write it.** Use `AskUserQuestion` with two options. `project — .claude/pstack-models.md (commit to share with the team)` and `user — ~/.claude/pstack-models.md (this machine, every project)`. Default to the location the current values came from.

### 4. Validate

Every model written must be in the detected set, and every effort word must be one of `low`, `medium`, `high`, `xhigh`. No role runs above `xhigh`. `inherit-parent` always passes. If a chosen model is not available, stop and ask again.

### 5. Write the map

Write the chosen file with the `# defaults: 2` line, a `# budget` line naming the chosen label, and one line per role, using the same labels poteto-mode uses. Overwrite the whole file so re-runs stay idempotent, but carry over any existing `auto-route` line unchanged, whatever its spelling. It switches automatic poteto-mode routing, which the SessionStart hook reads from this file. No YAML frontmatter. Shape (these values are the skill defaults):

```
# pstack model map. One line per role. Delete a line to fall back to the skill default.
# `inherit-parent` as a value: the role runs on the parent chat model (omit the Agent `model`). Alias entries in a panel list still count toward its fan-out.
# An effort word after the model (`opus medium`) is passed as the Agent `effort` on pstack:poteto-agent. It applies to the code roles, hardest tasks, and judgment and prose.
# Project file (.claude/pstack-models.md) overrides the user file (~/.claude/pstack-models.md) line by line.
# defaults: 2
# budget: large — opus ceiling
feature, refactoring: opus medium
bug-fix: opus high
perf-issue: opus medium
hillclimb: opus medium
judgment and prose: opus
hardest tasks: opus high
how explainer: opus
arena runners: opus, sonnet, sonnet
arena cross-judge pool: opus, sonnet
swarm workers: sonnet
interrogate reviewers: opus, sonnet, sonnet
```

### 6. Confirm

Tell the user which file was written and that it applies to new sessions (the SessionStart hook injects it). In the current session, the new values apply from now on because you just wrote them. Re-running this skill updates it.

### 7. Offer a verification skill (optional)

Check whether the project has a way to drive the real app for proof (a `verify-*` skill under `.claude/skills/`, or an existing harness). If not, offer once: "want a project-local verification skill, so agents can drive the app the way a user does and prove changes work? I can generate one with /pstack:create-verification-skill." On yes, read `${CLAUDE_SKILL_DIR}/../create-verification-skill/SKILL.md` and follow it. On no, move on without pushing.

### 8. Offer a formal verification skill (optional)

Check whether the project already has a formal verification skill (a project skill under `.claude/skills/` that runs a model checker, a proof, or another verifier against the code). If not, offer once: "want a formal verification skill, so agents can prove a key property of your code holds in every case in scope, not only the cases tests reach? I can generate one with /pstack:create-formal-verification-skill." On yes, read `${CLAUDE_SKILL_DIR}/../create-formal-verification-skill/SKILL.md` and follow it. On no, move on without pushing.

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

A value may add one effort word after the model or `inherit-parent`: `low`, `medium`, `high`, `xhigh`, or `max` (for example `opus medium`, or `inherit-parent medium` for the parent model at medium effort). The Claude apps label these Low, Medium, High, Extra, and Max, so Extra is `xhigh`. The map also accepts `extra` and `med`. Ultracode in the apps is not an effort level but a session mode (`xhigh` plus workflow orchestration), so `ultracode` in the map reads as `xhigh`. Haiku does not support effort, so an effort word after `haiku` is dropped. Always write the canonical word: the `Agent` tool takes only these five. pstack passes it as the `effort` parameter of the `Agent` call. The effort word applies to the roles that spawn `pstack:poteto-agent`: `feature, refactoring`, `bug-fix`, `perf-issue`, `hillclimb`, `hardest tasks`, and `judgment and prose`. On other roles it has no effect, so do not write one there. The SessionStart hook drops it there and says so. A value without an effort word runs at the session's effort when one is set, else at the model's own default effort. Haiku runs without effort either way. An effort word overrides the session effort, including Extra, Max, and Ultracode. It is still overridden by the `CLAUDE_CODE_EFFORT_LEVEL` environment variable and capped by an organization effort limit.

### 2. Load current state

<<<<<<< port
The default role-to-model mapping is the shape shown in step 5 below. Read `.claude/pstack-models.md` and `~/.claude/pstack-models.md` if they exist, and treat their `# budget` line and role values as the current choices, project over user. Otherwise start from the defaults. A line whose role is not in step 5, such as `how critics`, is from a retired role. Drop it. A value that is a Cursor slug (`grok-*`, `gpt-*`, `composer-*`, `cursor-*`, `claude-*-max`) is not a Claude Code model. Map it to the closest tier (`claude-opus-*` to `opus`, a fast code model to `sonnet`) and mark it as needing confirmation. A file without the header line that starts `# An effort word after the model` was written by release 0.15.5-claude.1. In such a file only, a code role (`feature, refactoring`, `bug-fix`, `perf-issue`, `hillclimb`) whose value is exactly `sonnet` is that release's default, not a user choice. Move it to the current default and list it as remapped. In a file that has the header line, `sonnet` on a code role is a deliberate choice. Keep it. Rewrite an app label or alias to its canonical word (`extra` and `ultracode` to `xhigh`, `med` to `medium`), drop an effort word after `haiku` or on a role outside the ones that spawn `pstack:poteto-agent` (step 1 lists them), and list each as remapped.

### 3. Budget, map, and confirm

**(a) Ask for a budget.** Use `AskUserQuestion`, not free text. If the session has no `AskUserQuestion` (Claude Projects threads, Remote Control, `-p` runs), ask once in plain text with the same labels, one per line, the recommended one marked, and wait for the answer. The same holds for every later question in this skill. Offer these four options with these exact labels, and name the current budget when a file records one. With no file, say that `unlimited` matches the skill defaults.

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

**(c) Show the roles and confirm.** Show every role with its model, marking any value not in the detected set as needing a choice. Also list each line step 2 dropped or remapped. Ask with `AskUserQuestion` whether to accept as-is or change specific roles, and for a changed code role which effort to use (offer `medium`, `high`, `xhigh (Extra)`, or none). Each question takes 2 to 4 options and the tool adds a free-text answer on its own, so offer the four model aliases and let `inherit-parent` come through that free-text answer, or ask in two steps. For panel roles (arena runners, architect runners, interrogate reviewers) the value is a list, and one subagent runs per entry, alias entries included, so the list length sets the count. `arena cross-judge pool` is also a list, but Arena selects one value from it that differs from the parent's model when possible. `swarm workers` is the default model for every worker unless a race or comparison assigns another model per arm.

**(d) Ask where to write it.** Use `AskUserQuestion` with two options. `project — .claude/pstack-models.md (commit to share with the team)` and `user — ~/.claude/pstack-models.md (this machine, every project)`. Default to the location the current values came from.

### 4. Validate

Every model written must be in the detected set, and every effort word must be one of `low`, `medium`, `high`, `xhigh`, `max`. `inherit-parent` always passes. If a chosen model is not available, stop and ask again.
=======
The default role-to-model mapping is the rule shape shown in step 5 below. If `~/.cursor/rules/pstack-models.mdc` already exists, read it and treat its `# budget` line and its role values as the current choices. Otherwise start from those defaults. A line whose role is not in step 5, such as `hardest tasks`, `architect runners`, `reflect tooling`, or `why investigators`, is from a retired role. Drop it.

A rule without the `# defaults: 3` line comes from an older setup. That setup wrote a line for every role, so some of its values are old defaults, not choices. Before step 3, replace these values:

- An `arena cross-judge pool` list of exactly one `claude-fable-*` entry, one `claude-opus-*` entry, and one `gemini-*` entry, in any order, takes the role's step 5 list. Fable and Opus are one vendor, so the Fable entry could judge only where the Opus entry also could.
- A `# budget: unlimited` line becomes `large`, because no role runs above `xhigh`.
- If the rule has no `# defaults: 2` line either, an old slug is one that matches `grok-*`. An old slug in `feature, refactoring`, `bug-fix`, `perf-issue`, `hillclimb`, or `swarm workers` takes the role's step 5 default. In a panel role (`arena runners`, `arena cross-judge pool`, `interrogate reviewers`), a list of exactly one `claude-opus-*` entry and one old slug, in either order, takes the role's step 5 list. In any other list, each old slug becomes `claude-opus-5-5-high-fast`.

Every other value is the user's choice and stays, including an old slug in any other role and every `inherit-parent` or `auto` value. Tell the user which values you replaced.

### 3. Budget, map, and confirm

**(a) Ask for a budget.** Prefer AskQuestion over free text. Offer these three options with these exact labels, and name the current budget when the rule records one. With no rule, say that `large` matches the skill defaults.

- `large — xhigh reasoning`
- `medium — high reasoning`
- `small — medium reasoning`

**(b) Apply it.** Build the working table from the skill defaults, and on a re-run keep any role you changed by family, list, or alias (`inherit-parent`, `auto`). Families are the ones Phase A of the **arena** skill defines, so Fable is its own family. Each role has a target effort, which is its default's effort moved by the budget. `large` keeps it, `medium` lowers it one step, and `small` lowers it two steps, on the ladder `xhigh` > `high` > `medium` > `low`. No role runs above `xhigh`, and a target at the bottom of the ladder stays there. Most defaults are at `xhigh`, and each budget label names where those land. Set the effort token of every real slug in the role, panel entries included, to the role's target. The effort token is the last token, or the one before a trailing `fast`. If the result is not a detected slug, use the same family's detected slug with the highest effort at or below the target, else mark the role as needing a choice. `inherit-parent` and `auto` do not change. So `medium` turns `claude-opus-5-5-xhigh-fast` into `claude-opus-5-5-high-fast` and `claude-opus-5-5-high-fast` into `claude-opus-5-5-medium-fast`, and `small` turns them into `claude-opus-5-5-medium-fast` and `claude-opus-5-5-low-fast`. Opus 5.5 always runs its `-fast` slug, so every Opus 5.5 value ends in `-fast`. Fable 5.2 and Gemini have no fast slug, so never write one. Gemini tops out at `high`, so a Gemini entry runs at `high` when its role's target is `xhigh`.

**(c) Show the roles and confirm.** Show every role with its model, marking any real slug not in the detected set as needing a choice. Also list each line step 2 dropped. Ask whether to accept as-is or change specific roles, offering the detected models at `xhigh` or below plus `inherit-parent` and `auto` (both mean: this role runs on the parent chat model, which is how Auto users stay on Auto) as the options. Prefer AskQuestion over free text. For panel roles (arena runners, interrogate reviewers) the value is a list, and one subagent runs per entry, alias entries included, so the list length sets the count. `arena cross-judge pool` is also a list, but Arena runs one judge. It tries only values from a vendor other than the parent's, in list order, so order it by preference. Fable and the other Claude models are one vendor. An `inherit-parent` or `auto` value never judges. `swarm workers` is the default model for every worker unless a race or comparison assigns another model per arm.

### 4. Validate

Every real slug written must be in the detected set and at `xhigh` or below. `inherit-parent` and `auto` always pass. If a chosen real slug is not available, stop and ask again.
>>>>>>> upstream@35a90942a7f0

### 5. Write the map

<<<<<<< port
Write the chosen file with a `# budget` line naming the chosen label and one line per role, using the same labels poteto-mode uses. Overwrite the whole file so re-runs stay idempotent, but carry over any existing `auto-route` line unchanged, whatever its spelling. It switches automatic poteto-mode routing, which the SessionStart hook reads from this file. No YAML frontmatter. Shape (these values are the skill defaults):

```
# pstack model map. One line per role. Delete a line to fall back to the skill default.
# `inherit-parent` as a value: the role runs on the parent chat model (omit the Agent `model`). Alias entries in a panel list still count toward its fan-out.
# An effort word after the model (`opus medium`) is passed as the Agent `effort` on pstack:poteto-agent. It applies to the code roles, hardest tasks, and judgment and prose.
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
=======
Write `~/.cursor/rules/pstack-models.mdc` with `alwaysApply: true`, the `# defaults: 3` line, a `# budget` line with the chosen label and the effort that label names, and one line per role, using the same labels poteto-mode uses. Overwrite the whole file so re-runs stay idempotent. Shape:

```
---
description: pstack per-role model choices (overrides skill defaults)
alwaysApply: true
---
# pstack model configuration. One line per role. Delete a line to fall back to the skill default.
# `inherit-parent` or `auto` as a value: the role runs on the parent chat model (omit Task `model` and spawn `generalPurpose`). Alias entries in a panel list still count toward its fan-out.
# defaults: 3
# budget: large (xhigh)
feature, refactoring: claude-opus-5-5-xhigh-fast
bug-fix: claude-opus-5-5-xhigh-fast
perf-issue: claude-opus-5-5-xhigh-fast
hillclimb: claude-opus-5-5-xhigh-fast
judgment and prose: claude-opus-5-5-xhigh-fast
arena runners: claude-fable-5-2-high, claude-opus-5-5-high-fast, gemini-4-carbon-high
arena cross-judge pool: claude-opus-5-5-high-fast, gemini-4-carbon-high
swarm workers: claude-opus-5-5-high-fast
interrogate reviewers: claude-fable-5-2-high, claude-opus-5-5-high-fast, gemini-4-carbon-high
>>>>>>> upstream@35a90942a7f0
```

### 6. Confirm

Tell the user which file was written and that it applies to new sessions (the SessionStart hook injects it). In the current session, the new values apply from now on because you just wrote them. Re-running this skill updates it.

### 7. Offer a verification skill (optional)

Check whether the project has a way to drive the real app for proof (a `verify-*` skill under `.claude/skills/`, or an existing harness). If not, offer once: "want a project-local verification skill, so agents can drive the app the way a user does and prove changes work? I can generate one with /pstack:create-verification-skill." On yes, read `${CLAUDE_SKILL_DIR}/../create-verification-skill/SKILL.md` and follow it. On no, move on without pushing.

### 8. Offer a formal verification skill (optional)

Check whether the project already has a formal verification skill (a project skill under `.claude/skills/` that runs a model checker, a proof, or another verifier against the code). If not, offer once: "want a formal verification skill, so agents can prove a key property of your code holds in every case in scope, not only the cases tests reach? I can generate one with /pstack:create-formal-verification-skill." On yes, read `${CLAUDE_SKILL_DIR}/../create-formal-verification-skill/SKILL.md` and follow it. On no, move on without pushing.

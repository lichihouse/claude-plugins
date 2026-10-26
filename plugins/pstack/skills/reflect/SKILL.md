---
name: reflect
description: "Chạy 3 subagent song song đọc lại phiên vừa xong, rút bài học và đề xuất sửa cụ thể vào skill có sẵn. Dùng khi người dùng nói 'reflect'."
disable-model-invocation: true
---

# Reflect

Mine the current conversation for durable learnings, then route them into skill edits.

Invoke when the user says "reflect" or "/pstack:reflect". Skip when the conversation is trivial, off-topic, or already covered by an existing skill the parent followed correctly. One-offs are not learnings.

## 1. Locate the active transcript

Before fanning out, find this conversation's transcript. The pstack SessionStart hook names this session's transcript path in a `pstack transcripts` block. Use that path. If the block is missing, list the project's transcript directory and do not glob across `~/.claude/projects/*/`. That crosses project boundaries and reads private chats from unrelated projects.

```bash
ls -t ~/.claude/projects/<slug>/*.jsonl 2>/dev/null | head -10
find ~/.claude/projects/<slug>/*/subagents -name 'agent-*.jsonl' 2>/dev/null | head -20
```

That covers a session (`<slug>/<session-id>.jsonl`) and its subagents (`<slug>/<session-id>/subagents/agent-*.jsonl`, with workflow agents one level deeper under `subagents/workflows/`). Without the hook's path, grep each candidate for the conversation's opening user prompt and take the match. If none matches, pass a tight digest of the session instead.

## 2. Spawn three reviewers in parallel

One message, three `Agent` calls, `subagent_type: "pstack:reader"`. Reviewers need MCP access to look up the tickets, chat threads, and observability traces the transcript references. `pstack:reader` keeps MCP and cannot edit files.

Each reviewer and the synthesizer name a role line in the pstack model map and a default. Set `model` to that line's value, or to the default if the map or the line is missing. Leave `model` unset when the value is `inherit-parent` or `auto`. If the Agent tool rejects a value, use the default and say so. If it rejects the default, use the next tier down (`fable` → `opus` → `sonnet` → `haiku`) and say so.

| Lens | Role line | Default `model` | Prompt template |
|---|---|---|---|
| Judgment | `reflect judgment, divergent, synthesizer` | `opus` | `references/judgment-reviewer.md` |
| Tooling | `reflect tooling` | `sonnet` | `references/tooling-reviewer.md` |
| Divergent | `reflect judgment, divergent, synthesizer` | `opus` | `references/divergent-reviewer.md` |

Pass each template verbatim, substituting the transcript path or digest where marked. Reviewers return findings in the `Agent` response body.

## 3. Synthesize

One `Agent` call, `subagent_type: "pstack:reader"`, `model` from the `reflect judgment, divergent, synthesizer` line (default `opus`). It spot-verifies citations through MCP, which `pstack:reader` keeps. Pass `references/synthesizer.md` verbatim, with each reviewer's full output inlined where marked. It returns an Accepted / Rejected / Backlog list.

## 4. Structural enforcement check

Move any Accepted item that a lint rule, script, metadata flag, or runtime check would enforce more reliably to Backlog. See the **encode-lessons-in-structure** principle skill.

## 5. Apply

Present the synthesizer's full Accepted / Rejected / Backlog output and wait for explicit approval before applying any Accepted edit. The user picks the subset and may redirect routings. Skill changes affect every future agent in the org. Do not auto-apply.

File each Backlog item to your team's devex or backlog tracker without waiting. Only the Accepted list waits for approval.

Never edit a skill under `~/.claude/plugins/` (the plugin cache, `<pstack root>` included): the next plugin update drops the edit. Before approval, show its destination, `.claude/skills/<skill>/` or `~/.claude/skills/<skill>/`. After approval, copy the skill folder there and edit the copy. Never open a PR or push. To change pstack itself, tell the user it takes a PR to the repository in its `.claude-plugin/plugin.json` with a version bump.

Follow each approved row's Routing exactly:

- Trivial existing-skill edit (a one-line bullet, a tightened sentence, a stale fact corrected): the parent does it directly.
- Substantive existing-skill edit (a new section, a new pattern table, more than ~10 lines): hand to the `skill-creator` skill when this session lists it and run its draft / test / iterate loop. Otherwise follow the **poteto-mode** Authoring a skill playbook.
- `tune description: <skill path>` (the skill exists but didn't trigger when it should have): hand to `skill-creator` and run its description-optimization loop, or tighten the description by hand under the same playbook.
- `new skill via skill-creator: <kebab-name>`: hand creation to `skill-creator` (or the playbook). Do not invent the shape ad hoc.

Run `claude plugin validate <dir>` on the plugin or skills directory that holds every touched skill before declaring done.

## 6. Summarize for the user

Short list, no preamble:

- Edits applied: `<skill path>`. What changed, one line each.
- New skills created: `<skill path>`. One line each (rare).
- Backlog filed to the devex tracker: `<issue title>` (`<tags>`). One line each.
- Dropped: one line per rejected finding + reason from the synthesizer.

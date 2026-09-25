---
name: reflect
description: "Chạy 3 subagent song song đọc lại phiên vừa xong, rút bài học và đề xuất sửa cụ thể vào skill có sẵn. Dùng khi người dùng nói 'reflect'."
disable-model-invocation: true
---

# Reflect

Mine the current conversation for durable learnings, then route them into skill edits.

## When to invoke

Invoke when the user says "reflect" or "/pstack:reflect". Skip when the conversation is trivial, off-topic, or already covered by an existing skill the parent followed correctly. One-offs are not learnings.

## Process

### 1. Locate the active transcript

The parent finds its own transcript file before fanning out. The pstack SessionStart hook names this session's transcript path in a `pstack transcripts` block. Use that path. If the block is missing, list the project's transcript directory and do not glob across `~/.claude/projects/*/`. That crosses project boundaries and reads private chats from unrelated projects.

```bash
ls -t ~/.claude/projects/<slug>/*.jsonl 2>/dev/null | head -10
find ~/.claude/projects/<slug>/*/subagents -name 'agent-*.jsonl' 2>/dev/null | head -20
```

Two transcript layouts: a session (`<slug>/<session-id>.jsonl`) and its subagents (`<slug>/<session-id>/subagents/agent-*.jsonl`, with workflow agents one level deeper under `subagents/workflows/`).

Without the hook's path, grep each candidate for the conversation's opening user prompt and take the match. If no path resolves, write a tight digest of the session and pass that instead.

### 2. Spawn three reviewers in parallel

One message, three `Agent` calls, `subagent_type: "pstack:reader"`, with `model` set as below. Reviewers need MCP access for context lookups (tickets, chat threads, observability traces referenced in the transcript). `pstack:reader` keeps MCP and cannot edit files.

Each reviewer and the synthesizer name a role line in the pstack model map and a default. Set `model` to that line's value, or to the default if the map or the line is missing. Leave `model` unset when the value is `inherit-parent` or `auto`. If the Agent tool rejects a value, use the default and say so. If it rejects the default, use the next tier down (`fable` → `opus` → `sonnet` → `haiku`) and say so.

| Lens | Role line | Default `model` | Prompt template |
|---|---|---|---|
| Judgment | `reflect judgment, divergent, synthesizer` | `opus` | `references/judgment-reviewer.md` |
| Tooling | `reflect tooling` | `sonnet` | `references/tooling-reviewer.md` |
| Divergent | `reflect judgment, divergent, synthesizer` | `opus` | `references/divergent-reviewer.md` |

Pass each template verbatim, substituting the transcript path or digest where marked. Reviewers return findings in the `Agent` response body.

### 3. Synthesize

One `Agent` call, `subagent_type: "pstack:reader"`, with `model` from the `reflect judgment, divergent, synthesizer` line (default `opus`). The synthesizer's quality check includes spot-verifying citations, which can require MCP access. `pstack:reader` keeps it. Use `references/synthesizer.md` verbatim, with each reviewer's full output inlined where marked. The synthesizer returns a structured Accepted / Rejected / Backlog list.

### 4. Structural enforcement check

Sanity-check the synthesizer's Accepted list. For any item that would be enforced more reliably by a lint rule, script, metadata flag, or runtime check, move it from Accepted to Backlog. See the **encode-lessons-in-structure** principle skill.

### 5. Apply

Before applying any Accepted edit, present the synthesizer's full Accepted/Rejected/Backlog output to the user and wait for explicit approval. The user picks which subset to apply and may redirect routings. Skill changes affect every future agent in the org. Do not auto-apply.

Backlog items file to whatever devex / backlog tracker your team uses automatically. Only the Accepted list waits for approval.

For each approved Accepted item, follow the Routing field exactly:

- Trivial existing-skill edit (a one-line bullet, a tightened sentence, a stale fact corrected): parent does directly.
- Substantive existing-skill edit (a new section, a new pattern table, more than ~10 lines): hand to the `skill-creator` skill when this session lists it and run its draft / test / iterate loop. Otherwise follow the **poteto-mode** Authoring a skill playbook.
- `tune description: <skill path>` (the skill exists but didn't trigger when it should have): hand to `skill-creator` and run its description-optimization loop, or tighten the description by hand under the same playbook.
- `new skill via skill-creator: <kebab-name>`: hand creation to `skill-creator` (or the playbook). Do not invent the shape ad hoc.

Run `claude plugin validate <dir>` on the plugin or skills directory that holds every touched skill before declaring done.

### 6. Summarize for the user

Short list, no preamble:

- Edits applied: `<skill path>`. What changed, one line each.
- New skills created: `<skill path>`. One line each (rare).
- Backlog filed to the devex tracker: `<issue title>` (`<tags>`). One line each.
- Dropped: one line per rejected finding + reason from the synthesizer.

---
name: how
description: "Giải thích code chạy thế nào: 'how does X work', đọc hiểu trước khi sửa, câu hỏi đặt code ở đâu / package nào sở hữu / đúng layer chưa. Giải thích kiến trúc subsystem, luồng runtime, mô hình để làm quen. Hỏi vì sao thì dùng why."
disable-model-invocation: true
---

# How

Explore the codebase to answer "how does X work?" questions. Produce architectural explanations at the level of a senior engineer onboarding onto a subsystem, enough to build a working mental model, not so much that it reads like annotated source code.

Each spawn below names a role line in the pstack model map (injected at session start; see the **setup-pstack** skill) and a default. Set `model` to that line's value, or to the default if the map or the line is missing. Leave `model` unset when the value is `inherit-parent` or `auto`. If the Agent tool rejects a value, use the default and say so. If it rejects the default, use the next tier down (`fable` → `opus` → `sonnet` → `haiku`) and say so.

## Step 1. Assess Complexity

If the scope is ambiguous, state your interpretation and explore. The user can redirect.

- **Simple** (a single module, a small utility, a narrow question such as "how does function X work"): no explorers. One explainer explores and explains in a single pass. Go to Step 2b.
- **Complex** (a subsystem spanning multiple files or services, a cross-cutting feature, a full architectural overview): spawn parallel explorers first, then hand off to the explainer. Go to Step 2a.

When in doubt, take the simple path.

## Step 2a. Explore (complex questions only)

Decompose the question into 2 to 4 exploration angles, each a distinct slice of the subsystem. Spawn all explorers in a single message:

- `subagent_type`: `pstack:reader` (read-only, keeps MCP)
- `model`: the `how explorer` line, default `sonnet`

Each explorer gets the prompt in `references/explorer-prompt.md` with its angle filled in. Then go to Step 3.

## Step 2b. Direct Explain (simple questions)

Spawn one `Agent` subagent that explores and explains in one pass. Spawn it even when the answer looks obvious from a quick look. The explainer runs on the `how explainer` model, and this thread keeps its context for the user's next step, so do not answer from your own reading:

- `subagent_type`: `pstack:reader` (read-only, keeps MCP)
- `model`: the `how explainer` line, default `opus`

Build its prompt from `references/explainer-prompt.md` without the explorer-findings section. Go to Step 4.

## Step 3. Synthesize (complex questions only)

Once all explorers have returned, spawn one `Agent` subagent to synthesize their findings into one explanation:

- `subagent_type`: `pstack:reader` (read-only, keeps MCP)
- `model`: the `how explainer` line, default `opus`

Build its prompt from `references/explainer-prompt.md` with every explorer's findings filled in.

## Step 4. Present

Present the explainer's output to the user. Light edits for clarity or context from the conversation are fine. Do not substantially rewrite it.

## Output Format

The explanation uses the sections defined in `references/explainer-prompt.md`, dropping any that do not apply: Overview, Key Concepts, How It Works, Where Things Live, Gotchas.

---
name: how
description: "Giải thích code chạy thế nào: 'how does X work', đọc hiểu trước khi sửa, câu hỏi đặt code ở đâu / package nào sở hữu / đúng layer chưa. Giải thích kiến trúc subsystem, luồng runtime, mô hình để làm quen. Hỏi vì sao thì dùng why."
disable-model-invocation: true
---

# How

<<<<<<< port
Explore the codebase to answer "how does X work?" questions. Produce architectural explanations at the level of a senior engineer onboarding onto a subsystem, enough to build a working mental model, not so much that it reads like annotated source code.

Every spawn is an `Agent` subagent with `subagent_type: "pstack:reader"` (read-only, keeps MCP). Explorers use the `how explorer` line in the pstack model map (injected at session start; see the **setup-pstack** skill), default `sonnet`, and every explainer uses the `how explainer` line, default `opus`. Set `model` to that line's value, or to the default if the map or the line is missing. Leave `model` unset when the value is `inherit-parent` or `auto`. If the Agent tool rejects a value, use the default and say so. If it rejects the default, use the next tier down (`fable` → `opus` → `sonnet` → `haiku`) and say so.

## 1. Assess complexity

If the scope is ambiguous, state your interpretation and explore. The user can redirect.

- **Simple** (a single module, a small utility, a narrow question such as "how does function X work"): no explorers. Spawn one explainer that explores and explains in one pass, built from `references/explainer-prompt.md` without the explorer-findings section. Spawn it even when the answer looks obvious from a quick look. The explainer runs on the `how explainer` model, and this thread keeps its context for the user's next step, so do not answer from your own reading. Go to step 4.
- **Complex** (a subsystem spanning multiple files or services, a cross-cutting feature, a full architectural overview): go to step 2.

When in doubt, take the simple path.

## 2. Explore (complex only)

Decompose the question into 2 to 4 angles, each a distinct slice of the subsystem. Spawn all explorers in a single message, each with `references/explorer-prompt.md` and its angle filled in.

## 3. Synthesize (complex only)

Once all explorers have returned, spawn one explainer with `references/explainer-prompt.md` and every explorer's findings filled in.
=======
Explore the codebase to answer "how does X work?" questions.

If the scope is ambiguous, state your interpretation and explore. The user can redirect.

## 1. Explain
>>>>>>> upstream@35a90942a7f0

Spawn one Task subagent with `subagent_type: generalPurpose` and `readonly: true` that explores and explains in one pass. Give it the user's question and this brief:

> You are writing an architectural explanation for a senior engineer. Explore the codebase and write an explanation that a senior engineer unfamiliar with this area could read and walk away with a solid mental model. They should understand the architecture well enough to start working in it confidently. You have read-only access to the codebase.

## 2. Present

Present the subagent's output. Light edits for clarity or context from the conversation are fine. Do not substantially rewrite it.

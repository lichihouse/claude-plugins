---
name: how
description: "Giải thích code chạy thế nào: 'how does X work', đọc hiểu trước khi sửa, câu hỏi đặt code ở đâu / package nào sở hữu / đúng layer chưa. Giải thích kiến trúc subsystem, luồng runtime, mô hình để làm quen. Hỏi vì sao thì dùng why."
disable-model-invocation: true
---

# How

Explore the codebase to answer "how does X work?" questions.

If the scope is ambiguous, state your interpretation and explore. The user can redirect.

## 1. Explain

Spawn one `Agent` subagent with `subagent_type: "pstack:reader"` (read-only, keeps MCP) that explores and explains in one pass. Spawn it even when the answer looks obvious from a quick look, so this thread keeps its context for the user's next step. Do not answer from your own reading. Set `model` from the `how explainer` line in the pstack model map (injected at session start; see the **setup-pstack** skill), default `opus`. Leave `model` unset when the value is `inherit-parent` or `auto`. If the Agent tool rejects a value, use the default and say so. If it rejects the default, use the next tier down (`fable` → `opus` → `sonnet` → `haiku`) and say so. Give it the user's question and this brief:

> You are writing an architectural explanation for a senior engineer. Explore the codebase and write an explanation that a senior engineer unfamiliar with this area could read and walk away with a solid mental model. They should understand the architecture well enough to start working in it confidently. You have read-only access to the codebase.

## 2. Present

Present the subagent's output. Light edits for clarity or context from the conversation are fine. Do not substantially rewrite it.

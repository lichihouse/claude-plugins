---
name: why
description: "Giải thích vì sao: 'why does X work this way', vì sao chọn Y, lý do thiết kế, regression, postmortem, ngưỡng dựa trên dữ liệu. Trả kết luận có trích nguồn về quyết định và đánh đổi. Hỏi code chạy thế nào thì dùng how."
disable-model-invocation: true
---

# Why

Answer from the record, not the code: read the commits and PR discussions that introduced the target and each later change, and other sources if the trail is thin. Cite what the authors wrote, mark your own inferences as inferences, and say what the record does not answer.

In Claude Code, read PRs with `gh`, or the GitHub MCP tools (`pull_request_read`) when `gh` is absent. Other sources are the session's MCP servers. Loaded tools appear as `mcp__<server>__<tool>`, deferred ones load through `ToolSearch` (for example query `+slack search`), and the server instructions in the system prompt say what each server holds.

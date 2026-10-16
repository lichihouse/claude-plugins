---
name: principle-guard-the-context-window
description: "Nội quy khi context sắp đầy (output lớn, file dài, đọc lặp, lập kế hoạch fan-out): đẩy phần nặng cho subagent, luồng chính chỉ giữ tóm tắt."
disable-model-invocation: true
---

# Guard the Context Window

**Why:** Context overflow degrades reasoning quality, creates compression artifacts, and halts progress.

**Pattern:**
- **Size phases and cap scope.** Limit files per phase, set turn budgets, account for mechanism costs.

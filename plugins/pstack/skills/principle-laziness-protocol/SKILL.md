---
name: principle-laziness-protocol
description: "Nội quy khi refactor, đánh giá độ lớn diff, hoặc muốn thêm abstraction/layer: ưu tiên xoá, chọn thay đổi nhỏ nhất giải quyết được vấn đề."
disable-model-invocation: true
---

# Laziness Protocol

- **Consolidate decisions.** Do not repeat the same choice in several places. Put it behind one source of truth and pass the result as a simple flag.
- **Minimize the diff.** Make the smallest change that solves the problem. Fewer lines beat "elegant" boilerplate.

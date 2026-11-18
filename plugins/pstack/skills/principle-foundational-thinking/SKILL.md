---
name: principle-foundational-thinking
description: "Nội quy trước khi viết logic: chọn kiểu và cấu trúc dữ liệu lõi, thứ tự dựng khung trước hay tính năng trước, các actor song song chia sẻ gì. Cấu trúc dữ liệu đúng thì code sau tự rõ."
disable-model-invocation: true
---

# Foundational Thinking

Get the data shape right before writing logic. Define core types early, trace every access pattern, and choose structures that match the dominant paths. DRY the structure, not every line.

Before sharing state between actors, ask what happens if another actor modifies it concurrently. If the answer is not "nothing", isolate.

Scaffold first. Whatever helps every later phase (CI, tests, shared types) goes first, after removing dead code. Keep commits small and single-purpose.

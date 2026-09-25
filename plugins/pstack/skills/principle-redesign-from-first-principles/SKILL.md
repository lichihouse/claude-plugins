---
name: principle-redesign-from-first-principles
description: "Nội quy khi thêm yêu cầu mới vào thiết kế có sẵn: thiết kế lại như thể yêu cầu đó có từ đầu, thay vì gắn chắp vá."
disable-model-invocation: true
---

# Redesign From First Principles

When integrating a change, don't bolt it onto the existing design. Redesign as if the requirement had been there from the start.

- Read all affected files and understand the current design
- Ask: "if we were writing this from scratch with this new requirement, what would we build?"
- Propagate the change through every reference: types, docs, examples, rationale sections
- Think about the whole redesign, then deliver it incrementally

This is the method for preserving option value when integrating changes into an existing design.

---
name: principle-migrate-callers-then-delete-legacy-apis
description: "Nội quy khi thêm API nội bộ mới mà code cũ còn gọi API cũ: chuyển hết nơi gọi và xoá API cũ trong cùng một đợt, không giữ lớp tương thích."
disable-model-invocation: true
---

# Migrate Callers Then Delete Legacy APIs

- Update tests to assert the new contract, and delete tests that only protect pre-refactor implementation details

**When this applies:**
- No external users depend on backward compatibility
- The project can absorb coordinated breaking changes
- The new API is part of a simplification or refactor initiative

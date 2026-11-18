---
name: architect
description: "Phác trước kiểu dữ liệu, chữ ký hàm, cấu trúc module rồi mới viết code, sau đó theo sát lúc code được lấp vào. Dùng cho /pstack:architect, 'architect this', 'design this', hoặc việc lớn mà lao vào code ngay dễ chốt sai hình dạng."
disable-model-invocation: true
---

# Architect

Before writing code, trace every system the change touches, then sketch two different shapes for it (types, signatures, module boundaries) and pick the one where each piece of state has one owner, each task has one way to do it, and callers need to know least. Redesign instead of patching if workarounds repeat.

For a large or contested design, run the **arena** skill instead of sketching alone.

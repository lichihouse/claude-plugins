---
name: principle-boundary-discipline
description: "Nội quy: khi nối validation, xử lý lỗi, adapter framework. Dồn kiểm tra ở biên hệ thống (CLI, config, network, API ngoài); tin kiểu dữ liệu nội bộ, giữ logic nghiệp vụ trong hàm thuần."
disable-model-invocation: true
---

# Boundary Discipline

Validate, narrow types, and handle errors where data crosses a system boundary (CLI args, config files, external APIs, network). Inside, trust the types: no re-validation and no redundant nil checks. Parse raw data into domain types at the boundary, and keep transport and framework types out of the public surface. Business logic lives in pure functions with no framework dependencies. The shell that calls them is thin.

Two tests. Is this data crossing a boundary right now? If not, the validation is redundant. Can this be a pure function the shell just calls? If yes, extract it.

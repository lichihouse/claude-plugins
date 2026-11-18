---
name: principle-separate-before-serializing-shared-state
description: "Nội quy khi nhiều actor song song có thể ghi cùng file, branch, key, state: bỏ việc dùng chung trước; chỉ tuần tự hoá khi một người ghi duy nhất là bất biến thật."
disable-model-invocation: true
---

# Separate Before Serializing Shared State

When concurrent actors might write the same file, branch, key, or object, first ask whether they need one shared object or are publishing independent facts. Default to giving each actor its own file, key, branch, or state directory, and merge only where the state is read. Two workers writing their own field into one `state.json` is still shared mutation.

Only when one shared write target is a real invariant, serialize access structurally (a lockfile, a single writer, sequential phases, compare-and-swap). Instructions are not concurrency control, and "we need a lock" is a smell to check first.

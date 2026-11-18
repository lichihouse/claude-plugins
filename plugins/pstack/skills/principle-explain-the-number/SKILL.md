---
name: principle-explain-the-number
description: "Nội quy trước khi đo, và trước khi tin, báo hay hành động theo một con số tự đo (tốc độ, regression, throughput, latency, kết quả eval): tìm cái giới hạn nó, và loại trừ khả năng nó đo nhầm thứ khác."
disable-model-invocation: true
---

# Explain the Number

- **Write the decision before you run.** Name the result that would change it, and the noise floor. Stop when the run-to-run spread is larger than the effect.
- **Ask "why not double?"** Name the resource or code path that bounds the result, from a profile or counters taken during a run. A guess from reading the code is not a limiter.
- **List what else the number could be measuring** (errors, skipped or cached work, code that never ran, an untuned side, noise, a piece too small to matter) and rule out each one with evidence.
- **Keep the run count, the spread, and the limiter with the number.**

For a performance number, run the [benchmark-checklist](../benchmark-checklist/SKILL.md) skill. For an eval result, ask whether every run did the task, whether the gap holds across trials and models, and whether the scenario matters.

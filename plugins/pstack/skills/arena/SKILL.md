---
name: arena
description: "Cho N bản chạy song song cùng một việc, chọn một bản làm nền, ghép phần hay nhất của các bản thua vào. Dùng cho /pstack:arena, 'arena this', hoặc khi làm một lần dễ chốt sai hình dạng."
disable-model-invocation: true
---

# Arena

Open a todo list with one entry per phase (Frame, Fan out, Cross-judge, Pick, Graft, Verify) before launching anything.

## Phase A: Frame

Every candidate gets the same prompt, so the prompt is the contract.

1. State the artifact each candidate is producing.
2. Derive the rubric, 3-6 concrete gradeable criteria for what success looks like on *this* task. It is the picker's tool in Phase D. Candidates only see the task.
3. Pick the runners from the `arena runners` line in the pstack model map, by default `opus`, `sonnet`, and `sonnet`. Spawn each candidate as `subagent_type: "general-purpose"`. An `inherit-parent` or `auto` entry is the parent model, so omit `model` for it. If the Agent tool rejects an entry, run that seat on the next tier down (`fable` → `opus` → `sonnet` → `haiku`) or drop the seat, keep at least two runners, and say so. All seats are Claude models, so diversity comes from the tier, not the vendor. Spawn more for multiple design directions, and repeat one model when the work is generation-bound, not judgment-sensitive.
4. Give each candidate its own output location (a git worktree where possible, otherwise `/tmp/arena-<slug>/candidate-<n>/`), per the **separate-before-serializing-shared-state** principle skill.

## Phase B: Fan out

Spawn all N subagents in one message with `run_in_background: true`, each with the task, the path to the shared grounding, its own output path, and instructions to produce the artifact and a short rationale naming the alternatives it considered and what it rejected.

If a candidate produces no output, proceed with N-1 and note the dropout.

## Phase C: Cross-judge

After all Phase B candidates complete, spawn one read-only judge (`subagent_type: "pstack:reader"`) from the `arena cross-judge pool` line in the pstack model map, by default `opus`, `sonnet`. Every entry is a Claude model, so the judge cannot come from another vendor. Use the first entry whose model differs from the one this session runs on. An `inherit-parent` or `auto` entry is the parent model, so it never judges. If you do not know the parent's model, use the first entry and say that the different-model check did not run. If the Agent tool rejects an entry, use the next tier down, then the next entry, or skip the judge, and say so. While you read in Phase D, the judge scores each candidate, by path label, on each rubric criterion and recommends a base.

## Phase D: Pick a base

Read every candidate end to end before picking. Score each against the rubric criterion by criterion, not on holistic feel, and compare with the cross-judge when Phase C ran one. Agreement on the base confirms the pick. Disagreement means one of you is biased or the rubric was ambiguous. Read both rationales before deciding.

Pick the base a future maintainer can extend most easily without breaking invariants. When two feel tied, prefer the cleaner boundary or smaller API, per the Laziness Protocol.

## Phase E: Graft

Walk each losing candidate once more for what is worth porting into the base, usually one or two things per candidate, not most of it. Fold each graft in by hand, per the **redesign-from-first-principles** principle skill, so the result stays coherent under one mental model. Don't paste mechanically.

If the candidates converge on one shape, that is strong agreement. Note it and ship the consensus shape. No graft is needed. If they wildly diverge, Phase A was under-specified. Reframe and re-run rather than averaging the divergence.

## Phase F: Verify

Verify the synthesized artifact like any other output, per the **prove-it-works** principle skill. If verification finds a problem the arena missed, either Phase A was wrong (re-frame and re-run) or a candidate caught it and you missed the graft (go back to Phase E). Don't paper over it.

## Outputs

One synthesized artifact, with a short synthesis note alongside naming the base and why, the cross-judge's verdict or that Phase C skipped the judge, each graft with its source candidate, what was rejected and why, any convergence or dropouts, and the verification result.

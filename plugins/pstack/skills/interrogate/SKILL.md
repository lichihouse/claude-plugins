---
name: interrogate
description: "Nhiều agent đối kháng (adversary) cố phá một thay đổi hay thiết kế, chỉ giữ phát hiện đã chứng minh bằng một lần chạy thật, không tự sửa. Dùng cho 'interrogate', 'adversarial review', 'multi-model review', 'challenge this', 'stress test this code', 'find blind spots', 'tear this apart', 'soi lỗ hổng', 'review gắt'."
disable-model-invocation: true
---

# Interrogate

Adversaries try to break a change or a design. A finding survives only when a run proves it. Report the findings. Do not apply fixes.

## Frame

The scope is what the user names. Otherwise it is the branch diff from its merge base with the base branch, through the working tree. State the intent with the **in-your-own-words** skill, from the user's message, the commits, and the PR description. Ask the user when the intent is unclear.

## Fan out

Run Phase A steps 3 and 4 and Phase B of the **arena** skill, with four changes. Read the `interrogate reviewers` line in place of `arena runners`, by default `opus`, `sonnet`, and `sonnet`, with the same fallback when the Agent tool rejects an entry. A subagent worktree can start from the default branch rather than this session's HEAD. So run `<pstack root>/skills/interrogate/scripts/scope-patch.sh <store>`, with `<store>` the path on the `pstack store` line of the SessionStart block. Run it in this session, from the repository under review, and quote both paths. Its first output line is this session's HEAD sha. Its second is the path of a patch that holds every uncommitted change, untracked files included, or an empty line when nothing is uncommitted. Start each brief with both values and these steps: run `git checkout --detach <sha>` in your worktree, then `git apply <patch>` when a patch path was given, and if either fails, report that and stop. Spawn each adversary as `subagent_type: "general-purpose"` with `isolation: "worktree"`, since it writes repros. In place of the arena task and rationale, give each adversary the scope, the intent, and this brief:

> Break this change. Prove each finding with a run against the real code, such as a failing test, a repro script, or command output that shows the wrong behavior. For a design or plan, run a prototype or probe the current tree. Keep repros in your own worktree. Report each finding with a title, the exact command, the output it printed, and the output the intent requires. Leave out anything you did not run. That covers style, naming, structure, and risks that need a future change to matter. No findings is a valid result.

## Verify

Verify each finding per arena Phase F by rerunning its command. Keep a finding when the output shows the failure and the failure breaks the intent. Drop the rest. Merge findings that share a root cause.

Skip arena Phases C, D, and E. Adversaries find different failures, so the verdict keeps every verified finding, not one adversary's list.

## Output

- **Intent**: the restatement.
- **Findings**: for each verified finding, the command, its output, how it breaks the intent, and the adversaries that found it. Say "no verified findings" when none survive.
- **Dropped**: for each adversary, the count of dropped findings and why.

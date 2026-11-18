---
name: interrogate
<<<<<<< port
description: "Nhiều reviewer LLM soi một thay đổi từ các góc độc lập, chỉ kết luận, không tự sửa. Dùng cho 'interrogate', 'adversarial review', 'multi-model review', 'soi lỗ hổng', 'review gắt'."
=======
description: "Use for \"interrogate\", \"adversarial review\", \"multi-model review\", \"challenge this\", \"stress test this code\", \"find blind spots\", or \"tear this apart\". Adversaries try to break a change or design, and only findings proven by a run survive."
>>>>>>> upstream@35a90942a7f0
disable-model-invocation: true
---

# Interrogate

<<<<<<< port
Spawn one reviewer per configured model to adversarially review code changes. Each reviewer gets the same prompt and rubric plus one appended lens line (step 3). The adversarial signal comes from model diversity and those lenses, not assigned personas. The deliverable is a synthesized verdict. Do NOT auto-apply changes.
=======
Adversaries try to break a change or a design. A finding survives only when a run proves it. Report the findings. Do not apply fixes.
>>>>>>> upstream@35a90942a7f0

## Frame

The scope is what the user names. Otherwise it is the branch diff from its merge base with the base branch, through the working tree. State the intent with the **in-your-own-words** skill, from the user's message, the commits, and the PR description. Ask the user when the intent is unclear.

## Fan out

Run Phase A steps 3 and 4 and Phase B of the **arena** skill, with four changes. Read the `interrogate reviewers` line in place of `arena runners`. Copy the scope's uncommitted changes into each worktree. Spawn each adversary as `generalPurpose`. In place of the arena task and rationale, give each adversary the scope, the intent, and this brief:

> Break this change. Prove each finding with a run against the real code, such as a failing test, a repro script, or command output that shows the wrong behavior. For a design or plan, run a prototype or probe the current tree. Keep repros in your own worktree. Report each finding with a title, the exact command, the output it printed, and the output the intent requires. Leave out anything you did not run. That covers style, naming, structure, and risks that need a future change to matter. No findings is a valid result.

## Verify

Verify each finding per arena Phase F by rerunning its command. Keep a finding when the output shows the failure and the failure breaks the intent. Drop the rest. Merge findings that share a root cause.

<<<<<<< port
Launch all reviewers in a single message with the Agent tool, one per entry on the `interrogate reviewers` line in the pstack model map, labeled Reviewer A, B, and so on to match the entry count. If the map or that line is missing, use the table defaults.

| Subagent | Default model |
|----------|---------------|
| Reviewer A | `fable` |
| Reviewer B | `opus` |
| Reviewer C | `sonnet` |

Each reviewer gets `subagent_type: "pstack:reader"` (read-only, keeps MCP) and `model` set to its configured entry, or its table default when there is no configured line. Omit `model` for an `inherit-parent` or `auto` entry, so that reviewer runs on the parent model.

If the Agent tool rejects a configured entry, run that reviewer on the next tier down (`fable` → `opus` → `sonnet` → `haiku`) and say so. If it rejects a table default, spawn with the closest equivalent from the valid values in its error message (prefer the strongest tier available), and open a separate PR to update the default table. Do not block the review on the model issue. Never treat an alias entry as a rejected model or apply either fallback to it. All reviewers are Claude models, so diversity comes from tier and from a per-reviewer lens, not from vendor. Append one lens line to each reviewer's prompt, in panel order: correctness, races, and edge cases; then authorization, security, and destructive data paths; then domain invariants (money, time zones, data parity across read paths). A longer panel cycles through the three.

Read `references/reviewer-prompt.md` and fill in the same template for every reviewer with the stated intent, the diff or file contents, the rubric from `references/rubric.md`, and the code-quality lens from `references/code-quality-review.md`, then append that reviewer's lens line.

## Step 4, Synthesize

As results come back, build a unified picture. Parse every reviewer's findings. Merge findings that describe the same issue differently, and note which models raised each one. Findings two or more models raised independently are the highest signal. Read a lone model's finding, but weight it accordingly. Note disagreements. If one model flags something and another explicitly says the opposite, that is context for the verdict.

## Step 5, Lead Judgment

You are the lead reviewer, a pragmatic senior engineer, not a neutral aggregator. Read `references/lead-judgment.md` for the full framework. Put every finding in one of four buckets, with the model(s) that raised it and a one-line rationale.

- **Act on**. Real issues affecting correctness, security, or maintainability given the actual goals. They would block a real PR.
- **Consider**. Legitimate, but you're not sure they outweigh the cost of addressing them now. Worth the user's attention.
- **Noted**. Technically valid but not actionable. Context-dependent, premature optimization, or low-impact at this stage.
- **Dismissed**. Wrong, nitpicky, or missing context, with a brief reason.

## Output Format

### Intent
> [The stated intent paragraph from Step 2]

### Reviewers
- Reviewer [label]: [model name], [N findings] (one bullet per reviewer)

### Act On
[Each: description, which models raised it, why it matters.]

### Consider
[Each: description, which models raised it, the tradeoff.]

### Noted
[Brief list.]

### Dismissed
[Each with a brief rationale.]

### Agreement Map
[Where models agreed and diverged, and what that pattern tells us.]
=======
Skip arena Phases C, D, and E. Adversaries find different failures, so the verdict keeps every verified finding, not one adversary's list.

## Output

- **Intent**: the restatement.
- **Findings**: for each verified finding, the command, its output, how it breaks the intent, and the adversaries that found it. Say "no verified findings" when none survive.
- **Dropped**: for each adversary, the count of dropped findings and why.
>>>>>>> upstream@35a90942a7f0

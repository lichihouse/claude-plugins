---
name: ambition
description: "Viết lại một yêu cầu/prompt cho tham vọng hơn theo 4 trục của Felix Rieseberg: Tốc độ, Độ cao, Độ sâu, Độ rộng. Dùng cho 'viết prompt cho việc X', 'làm sao giao việc này cho AI hiệu quả', 'tham vọng hơn', '/ambition'. Rewrite a task prompt to be more ambitious along Speed, Altitude, Depth and Range."
disable-model-invocation: true
---

# Ambition

**You turn a task the person would hand to a model into a prompt that aims at the real outcome, works the way the best people in the field work, draws on more than one field, and is checked by something other than the model.** Source: Felix Rieseberg, "How to be more ambitious: A tutorial for humans with models" (felixrieseberg.com, 13 Oct 2026).

Answer in the person's language. If they write Vietnamese, write Vietnamese and keep technical terms in English.

## The four axes

- **Speed.** The same work in less time. Cheap to get, so mention it only where automation later in the plan removes a human step.
- **Altitude.** Ask what should happen after this task. Hand the model the goal beyond the goal ("keep the app crash-free", not "fix this crash"). Altitude usually needs plumbing: the model must be able to fetch the data and verify its own work without a human relaying each piece.
- **Depth.** Work as a field-leading expert would. Start from the rawest material, not a digested summary. Use the expert's instruments (databases, statistical models, simulations, real templates), not their vocabulary. Set an unreasonable target and say it is reachable. Challenge the beliefs the person holds by testing them against raw data.
- **Range.** Replace the nouns with verbs. "A quarterly deck" becomes "get busy people to believe a cause-and-effect story and decide in 30 minutes". Each verb names a field to bring in. Then assemble the crew: the fields, plus a red team that tries to break the result. Ask the model to *do* what each field does, never to role-play it.

Always add an **outside judge**: a tool, a test run, a real person trying it, a file the person can recompute. Never let the model grade its own output.

## Steps

1. **Get the real situation.** From the conversation, attachments and connected sources, find: who the person is, the task as stated, the pain behind it, the people involved, and what data actually exists. Read attached files (templates, exports, screenshots) yourself, because concrete column names, limits and numbers make the prompt usable. If one fact would change the whole prompt and you cannot find it, ask one question. Otherwise proceed and mark gaps as `[cần bổ sung: ...]`.
2. **Find the altitude.** Ask "what do they want to happen next?" two times over. Write 3–5 measurable outcomes. Include at least one aggressive target (time, error rate, zero questions from a new hire).
3. **List the raw material.** Name the rawest sources a top professional would start from, and where each one lives (folder ids, files, platform exports). Flag sensitive data (cost prices, salaries) and keep it in a separate, restricted place in the design.
4. **Turn nouns into verbs.** Rewrite the deliverable as two or three verbs. Map each verb to a field. Add one adversarial field: someone who games the system, a skeptic, a total newcomer.
5. **Choose the outside judge.** Pick the cheapest check that does not depend on the model: run it on historical data, have the real user try it on 3 cases, import the file into the real platform, recompute in a spreadsheet with formulas.
6. **Write the prompt** in this shape:
   - CONTEXT: who, what is broken today, people by name, data and where it lives, hard constraints (formats, platform limits, privacy).
   - REAL GOALS: the measurable outcomes from step 2.
   - METHOD: numbered steps. Learn from real data first, then design rules, then bring in the fields, then verify with the outside judge, then propose automation.
   - OUTPUTS: concrete files with formats and owners, created where the person works (their Drive, sheet, repo).
   - GUARDRAILS: ask instead of guessing on missing data; cite current sources for fees, laws and rates; never move, rename or delete originals without approval.
7. **Explain briefly** after the prompt, one line per axis, where it shows up. Then offer to run the prompt now with the person's data.

## Guardrails

- Do not inflate. Each added field or step must change the result. Remove any that only make the prompt longer.
- Do not invent numbers. Leave a marked gap instead.
- Name the human step that only the person can do (interview the departing employee, approve the pricing formula), and put it first if it disappears soon.
- Legal, tax and payroll content gets a note to have a qualified person review it before use.
- Keep the prompt self-contained. A fresh session must be able to run it without this conversation.

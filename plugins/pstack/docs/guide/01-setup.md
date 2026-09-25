# Set up pstack

In this page you install the plugin, pick which models pstack uses, and run your first task. Setup is one command plus a short conversation.

## Install the plugin

Enable it once for your claude.ai account, so it follows you into every repository:

1. Open claude.ai in a browser, then **Customize** > **Plugins**.
2. Under **Personal plugins**, choose **+** > **Add marketplace** > **Add from a repository**, and enter `lichihouse/claude-plugins`.
3. Install **pstack** from that marketplace.

Cloud sessions (Claude Code on the web, the Code tab of the desktop and mobile apps) load it at session start. Terminal sessions load it when Claude Code is 2.1.273 or later and signed in with the same account. `claude plugin list` shows `pstack@synced`, and `/pstack:` in the slash menu lists the skills.

Install it from the terminal with `/plugin marketplace add lichihouse/claude-plugins` and `/plugin install pstack@lichihouse` only if you want a machine-local copy. A local install shadows the account copy on that machine, so account updates stop reaching it until you remove the local one.

## Pick your models

Run:

```text
/pstack:setup-pstack
```

[`/pstack:setup-pstack`](../../skills/setup-pstack/SKILL.md) detects the models you have access to, asks for a reasoning budget, shows you each role (code delegates, judgment, the review panels), and asks what you want. Answer the questions. It writes the pstack model map, `.claude/pstack-models.md` for the project or `~/.claude/pstack-models.md` for you. The plugin's SessionStart hook injects it into every new session, so every pstack skill reads it.

You only override what you care about. A role with no line in the map keeps the skill's default. To restore a default, delete that role's line. A project line overrides a user line for the same role. A rerun of `/pstack:setup-pstack` keeps any role whose model or effort differs from the default. A value can carry an effort word, such as `opus medium`, on the roles that spawn `pstack:poteto-agent` (the code roles, hardest tasks, and judgment and prose).

You might be wondering how to keep every subagent on the model you chose for the chat. Set a role to `inherit-parent` and pstack omits the subagent `model` field, so the subagent inherits your parent chat model. `auto` means the same thing, kept for maps carried over from Cursor. Neither is a model name. For a panel role the value is a list, and one subagent runs per entry, so the list length sets the panel size. Setup also configures `swarm workers`, the default model for every `/pstack:swarm` worker unless a race names a model for each arm.

## Accept the verification offer, or don't

At the end of setup, `/pstack:setup-pstack` looks for a way to prove app behavior in your project, either a `verify-*` skill or an existing harness. If it finds neither, it offers once to generate one with [`/pstack:create-verification-skill`](../../skills/create-verification-skill/SKILL.md).

Say yes and it writes `.claude/skills/verify-<app>/`, a project-local skill that teaches agents to drive your app the way a user does. It proves the skill works once before handing it over. Say no and setup moves on. You can run `/pstack:create-verification-skill` yourself any time. [Verify and ship](./06-verify-and-ship.md#create-a-project-verification-skill) covers when it earns its place.

After setup, the session you ran it in already uses the new values. Every new session gets them from the SessionStart hook.

## Run your first task

Pick something real but small, and describe it the way you'd describe it to a colleague:

```text
/pstack:poteto-mode add a --json flag to this command. text output stays byte-identical. verify both.
```

Watch the todo list. Its first items are the matched playbook's steps copied in, the Feature playbook for this prompt. If `/pstack:poteto-mode` skips a step, the step stays in the list with `skip: <reason>`, so you can see what it chose not to do.

From here you can type normal follow-ups. `/pstack:poteto-mode` is sticky. It stays on for the conversation until you opt out by saying so.

Next: [Route work through `/pstack:poteto-mode`](./02-poteto-mode.md).

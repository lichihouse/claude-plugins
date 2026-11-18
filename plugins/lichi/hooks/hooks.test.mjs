import { test } from "node:test";
import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { mkdirSync, mkdtempSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { fileURLToPath } from "node:url";
import { hookOutput, reminder } from "./agents-md.mjs";
import { decide } from "./deny-guard.mjs";

const here = fileURLToPath(new URL(".", import.meta.url));
delete process.env.CLAUDE_PROJECT_DIR;

function makeRepo(root, name, deny, extra = []) {
  const repo = join(root, name);
  mkdirSync(join(repo, ".git"), { recursive: true });
  mkdirSync(join(repo, ".claude"), { recursive: true });
  writeFileSync(join(repo, "AGENTS.md"), `# ${name}\n`);
  writeFileSync(join(repo, ".claude", "settings.json"), JSON.stringify({ permissions: { allow: [], deny } }));
  for (const rel of extra) {
    mkdirSync(join(repo, rel, ".."), { recursive: true });
    writeFileSync(join(repo, rel), "# nested\n");
  }
  return repo;
}

function fixture() {
  const root = mkdtempSync(join(tmpdir(), "lichi-hooks-"));
  const web = makeRepo(root, "web", ["Bash(git push origin main*)", "Bash(git add -A*)", "Bash(rm -r*)", "Edit(.env)"], [
    "apps/ios/AGENTS.md",
  ]);
  const kho = makeRepo(root, "kho", ["Bash(git push origin master*)", "Bash(*lichi_prod*)", "Bash(git -c * push*)", "Edit(deploy/.env)"]);
  mkdirSync(join(root, "notes"));
  return { root, web, kho };
}

const bash = (cwd, command) => decide({ cwd, tool_name: "Bash", tool_input: { command } });

test("parent folder: reminder lists every repo AGENTS.md, nested ones included", () => {
  const { root, web, kho } = fixture();
  const text = reminder(root);
  assert.match(text, /KHÔNG tự nạp AGENTS\.md/);
  assert.ok(text.includes(join(web, "AGENTS.md")));
  assert.ok(text.includes(join(web, "apps/ios/AGENTS.md")));
  assert.ok(text.includes(join(kho, "AGENTS.md")));
  assert.ok(!text.includes("notes"));
});

test("session inside a repo: no reminder, Claude Code loads AGENTS.md itself", () => {
  const { web } = fixture();
  assert.equal(reminder(web), "");
});

test("folder with no repos: no reminder", () => {
  assert.equal(reminder(mkdtempSync(join(tmpdir(), "lichi-empty-"))), "");
});

test("SubagentStart gets the same reminder under its own event name", () => {
  const { root } = fixture();
  const out = hookOutput({ cwd: root, hook_event_name: "SubagentStart" });
  assert.equal(out.hookSpecificOutput.hookEventName, "SubagentStart");
  assert.match(out.hookSpecificOutput.additionalContext, /lichi-agents-md/);
});

test("reminder stays small enough for hook context limits", () => {
  const { root } = fixture();
  assert.ok(Buffer.byteLength(reminder(root)) < 3000);
});

test("parent folder: destructive commands from any repo's deny list are blocked", () => {
  const { root } = fixture();
  for (const cmd of ["git push origin main", "git add -A", "cd /tmp && rm -rf x", "FOO=1 rm -r x", "psql -d lichi_prod", "echo $(git add -A)"]) {
    assert.ok(bash(root, cmd), `should block: ${cmd}`);
  }
});

test("parent folder: daily commands pass", () => {
  const { root } = fixture();
  for (const cmd of ["git status", "git push -u origin claude/x", "rg 'git add -A' AGENTS.md", "rm -f out.log"]) {
    assert.equal(bash(root, cmd), null, `should pass: ${cmd}`);
  }
});

test("a command that names one repo uses only that repo's rules", () => {
  const { root } = fixture();
  assert.equal(bash(root, "cd web && git -c user.name=x commit -m 'retry push'"), null);
  assert.ok(bash(root, "git -c user.name=x commit -m 'retry push'"));
  assert.ok(bash(root, "cd kho && psql -d lichi_prod"));
  assert.equal(bash(root, "cd kho && git push origin main"), null);
});

test("file edits follow the deny list of the repo that owns the file", () => {
  const { root, web, kho } = fixture();
  const edit = (file_path) => decide({ cwd: root, tool_name: "Edit", tool_input: { file_path } });
  assert.ok(edit(join(web, ".env")));
  assert.ok(edit(join(web, "apps/api/.env")));
  assert.ok(edit(join(kho, "deploy/.env")));
  assert.equal(edit(join(kho, ".env")), null);
  assert.equal(edit(join(web, "src/a.ts")), null);
});

test("session inside a repo: guard stays out, Claude Code applies the repo settings", () => {
  const { web } = fixture();
  assert.equal(bash(web, "git push origin main"), null);
});

function withProject(dir, fn) {
  process.env.CLAUDE_PROJECT_DIR = dir;
  try {
    return fn();
  } finally {
    delete process.env.CLAUDE_PROJECT_DIR;
  }
}

test("after cd into a repo the guard still applies, using that repo's rules", () => {
  const { root, web, kho } = fixture();
  withProject(root, () => {
    assert.ok(bash(web, "git add -A"));
    assert.ok(bash(kho, "git push origin master"));
    assert.equal(bash(kho, "git push origin main"), null);
    assert.ok(bash(kho, 'git commit -m "port web helper" && git push origin master'));
    assert.match(reminder(root), /lichi-agents-md/);
    assert.match(hookOutput({ cwd: web, hook_event_name: "SubagentStart" }).hookSpecificOutput.additionalContext, /lichi-agents-md/);
  });
});

test("subshells and groups are split like Claude Code does", () => {
  const { root } = fixture();
  for (const cmd of ["(cd web && git add -A)", "{ git add -A; }", "cd web; (git push origin main)"]) {
    assert.ok(bash(root, cmd), `should block: ${cmd}`);
  }
});

test("home folder with user settings but no .git still gets the guard", () => {
  const { root } = fixture();
  mkdirSync(join(root, ".claude"), { recursive: true });
  writeFileSync(join(root, ".claude", "settings.json"), "{}");
  assert.ok(bash(root, "git add -A"));
});

test("one repo with broken settings does not switch the guard off for the others", () => {
  const { root, kho } = fixture();
  writeFileSync(join(kho, ".claude", "settings.json"), "{ broken");
  assert.ok(bash(root, "git add -A"));
});

test("dir/** edit rules match files inside the folder", () => {
  const { root, web } = fixture();
  writeFileSync(join(web, ".claude", "settings.json"), JSON.stringify({ permissions: { deny: ["Edit(secrets/**)"] } }));
  assert.ok(decide({ cwd: root, tool_name: "Write", tool_input: { file_path: join(web, "secrets/a/b.json") } }));
  assert.equal(decide({ cwd: root, tool_name: "Write", tool_input: { file_path: join(web, "src/secrets.ts") } }), null);
});

test("scripts run as hooks: deny JSON on stdout, nothing on allow", () => {
  const { root } = fixture();
  const env = { ...process.env };
  delete env.CLAUDE_PROJECT_DIR;
  const run = (script, input) => execFileSync("node", [join(here, script)], { input: JSON.stringify(input), encoding: "utf8", env });
  const denied = JSON.parse(run("deny-guard.mjs", { cwd: root, tool_name: "Bash", tool_input: { command: "git add -A" } }));
  assert.equal(denied.hookSpecificOutput.permissionDecision, "deny");
  assert.equal(run("deny-guard.mjs", { cwd: root, tool_name: "Bash", tool_input: { command: "git status" } }), "");
  const ctx = JSON.parse(run("agents-md.mjs", { cwd: root, hook_event_name: "SessionStart" }));
  assert.match(ctx.hookSpecificOutput.additionalContext, /AGENTS\.md/);
  assert.equal(run("agents-md.mjs", { cwd: "/nonexistent-dir", hook_event_name: "SessionStart" }), "");
});

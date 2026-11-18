import { existsSync, readFileSync } from "node:fs";
import { basename, join, relative } from "node:path";
import { pathToFileURL } from "node:url";
import { childRepos, isRepo, projectDir, readHookInput, repoOf } from "./repos.mjs";

const SEPARATORS = ["&&", "||", "|&", ";", "|", "&", "\n", "(", ")", "{", "}"];
const WRAPPERS = new Set(["time", "nice", "nohup", "stdbuf", "command", "builtin", "noglob"]);
const FILE_TOOLS = new Set(["Edit", "Write", "MultiEdit", "NotebookEdit"]);

function closingIndex(cmd, open) {
  const pair = { "(": ")", "{": "}" };
  const stack = [];
  let quote = null;
  for (let i = open; i < cmd.length; i++) {
    const c = cmd[i];
    if (quote) {
      if (c === quote) quote = null;
      continue;
    }
    if (c === "'" || c === '"') quote = c;
    else if (c === "(" || c === "{") stack.push(pair[c]);
    else if (c === stack[stack.length - 1] && (stack.pop(), stack.length === 0)) return i;
  }
  return cmd.length - 1;
}

export function splitCommand(cmd) {
  const parts = [];
  let cur = "";
  let quote = null;
  for (let i = 0; i < cmd.length; i++) {
    const c = cmd[i];
    if (quote) {
      cur += c;
      if (c === quote) quote = null;
      continue;
    }
    if (c === "'" || c === '"') {
      quote = c;
      cur += c;
      continue;
    }
    if (c === "$" && (cmd[i + 1] === "(" || cmd[i + 1] === "{")) {
      const end = closingIndex(cmd, i + 1);
      cur += cmd.slice(i, end + 1);
      i = end;
      continue;
    }
    const s = SEPARATORS.find((x) => cmd.startsWith(x, i));
    if (s) {
      parts.push(cur);
      cur = "";
      i += s.length - 1;
      continue;
    }
    cur += c;
  }
  parts.push(cur);
  const nested = [];
  for (let i = cmd.indexOf("$("); i !== -1; i = cmd.indexOf("$(", i + 2)) {
    const end = closingIndex(cmd, i + 1);
    nested.push(...splitCommand(cmd.slice(i + 2, end)));
  }
  for (const m of cmd.matchAll(/`([^`]*)`/g)) nested.push(...splitCommand(m[1]));
  return [...parts, ...nested].map((p) => p.trim()).filter(Boolean);
}

function stripPrefix(sub) {
  let w = sub.split(/\s+/);
  while (w.length && /^[A-Za-z_][A-Za-z0-9_]*=/.test(w[0])) w = w.slice(1);
  for (;;) {
    if (w[0] === "timeout" && w.length > 2) w = w.slice(2);
    else if (w[0] === "xargs" && w.length > 1 && !w[1].startsWith("-")) w = w.slice(1);
    else if (WRAPPERS.has(w[0]) && w.length > 1 && !(w[0] === "command" && w[1] === "-v")) w = w.slice(1);
    else return w.join(" ");
  }
}

function bashRegex(rule) {
  let p = rule.endsWith(":*") ? `${rule.slice(0, -2)} *` : rule;
  const stars = (p.match(/\*/g) ?? []).length;
  const bareOk = stars === 1 && p.endsWith(" *");
  if (bareOk) p = p.slice(0, -2);
  const body = p.split("*").map((s) => s.replace(/[.+?^${}()|[\]\\]/g, "\\$&")).join(".*");
  return new RegExp(`^${body}${bareOk ? "( .*)?" : ""}$`, "s");
}

function pathRegex(glob) {
  const body = glob
    .split(/(\*\*\/?|\*)/)
    .map((s, i, all) => (s.startsWith("**") ? (i === all.length - 2 && all[i + 1] === "" ? ".*" : "(?:.*/)?") : s === "*" ? "[^/]*" : s.replace(/[.+?^${}()|[\]\\]/g, "\\$&")))
    .join("");
  return new RegExp(`^${body}$`);
}

export function loadRules(repo) {
  const file = join(repo, ".claude", "settings.json");
  if (!existsSync(file)) return { bash: [], paths: [] };
  const deny = JSON.parse(readFileSync(file, "utf8")).permissions?.deny ?? [];
  const bash = [];
  const paths = [];
  for (const r of deny) {
    const m = /^(\w+)\((.*)\)$/s.exec(r);
    if (!m) continue;
    if (m[1] === "Bash") bash.push({ rule: r, re: bashRegex(m[2]) });
    else if (["Edit", "Write", "Read"].includes(m[1])) paths.push({ tool: m[1], rule: r, glob: m[2], re: pathRegex(m[2].replace(/^\.?\//, "")) });
  }
  return { bash, paths };
}

export function targetRepos(rulesByRepo, cmd, cwd) {
  const repos = rulesByRepo.map((r) => r.repo);
  const here = cwd ? repoOf(repos, cwd) ?? repos.find((r) => r === cwd) : undefined;
  const named = rulesByRepo.filter(({ repo }) => {
    const name = basename(repo).replace(/[.+?^${}()|[\]\\]/g, "\\$&");
    return new RegExp(`(^|[\\s/'"=])${name}(?=$|[\\s/'";&|)])`).test(cmd);
  });
  const scope = rulesByRepo.filter((r) => r.repo === here || named.includes(r));
  return scope.length ? scope : rulesByRepo;
}

export function checkBash(rulesByRepo, cmd, cwd) {
  const scope = targetRepos(rulesByRepo, cmd, cwd);
  for (const sub of splitCommand(cmd)) {
    const text = stripPrefix(sub);
    for (const { repo, rules } of scope) {
      const hit = rules.bash.find((r) => r.re.test(text));
      if (hit) return { repo, rule: hit.rule, sub };
    }
  }
  return null;
}

export function checkPath(rulesByRepo, tool, filePath) {
  const entry = rulesByRepo.find((r) => r.repo === repoOf(rulesByRepo.map((x) => x.repo), filePath));
  if (!entry) return null;
  const rel = relative(entry.repo, filePath).split("\\").join("/");
  const want = tool === "Read" ? ["Read"] : ["Edit", "Write"];
  const hit = entry.rules.paths.find((p) => want.includes(p.tool) && (p.glob.includes("/") ? p.re.test(rel) : p.re.test(basename(rel))));
  return hit ? { repo: entry.repo, rule: hit.rule, sub: rel } : null;
}

function safeRules(repo) {
  try {
    return loadRules(repo);
  } catch (err) {
    process.stderr.write(`lichi deny-guard: bỏ qua ${repo}/.claude/settings.json (${err?.message ?? err})\n`);
    return { bash: [], paths: [] };
  }
}

export function decide(input) {
  const root = projectDir(input);
  if (isRepo(root)) return null;
  const rulesByRepo = childRepos(root)
    .map((repo) => ({ repo, rules: safeRules(repo) }))
    .filter((r) => r.rules.bash.length || r.rules.paths.length);
  if (rulesByRepo.length === 0) return null;
  const tool = input.tool_name;
  const ti = input.tool_input ?? {};
  if (tool === "Bash" && typeof ti.command === "string") return checkBash(rulesByRepo, ti.command, input.cwd);
  if ((FILE_TOOLS.has(tool) || tool === "Read") && typeof (ti.file_path ?? ti.notebook_path) === "string") {
    return checkPath(rulesByRepo, tool, ti.file_path ?? ti.notebook_path);
  }
  return null;
}

if (import.meta.url === pathToFileURL(process.argv[1] ?? "").href) {
  try {
    const hit = decide(readHookInput());
    if (hit) {
      process.stdout.write(
        JSON.stringify({
          hookSpecificOutput: {
            hookEventName: "PreToolUse",
            permissionDecision: "deny",
            permissionDecisionReason: `Chặn theo deny list của ${hit.repo} (${hit.rule}), khớp "${hit.sub}". Phiên ở thư mục cha không tự áp deny list repo nên hook lichi áp thay. Cần làm thật thì hỏi user.`,
          },
        }),
      );
    }
  } catch (err) {
    process.stderr.write(`lichi deny-guard lỗi, không chặn được: ${err?.message ?? err}\n`);
  }
}

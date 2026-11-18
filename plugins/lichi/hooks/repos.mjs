import { existsSync, readdirSync, readFileSync, statSync } from "node:fs";
import { isAbsolute, join, relative, sep } from "node:path";

const SKIP_DIRS = new Set(["node_modules", ".git", "dist", "build", ".next", "attached_assets", "coverage"]);

export function readHookInput() {
  try {
    return JSON.parse(readFileSync(0, "utf8") || "{}");
  } catch {
    return {};
  }
}

function isDir(p) {
  try {
    return statSync(p).isDirectory();
  } catch {
    return false;
  }
}

export function projectDir(input) {
  return process.env.CLAUDE_PROJECT_DIR || input.cwd || process.cwd();
}

export function isRepo(dir) {
  return existsSync(join(dir, ".git"));
}

export function childRepos(cwd) {
  if (!cwd || !isDir(cwd)) return [];
  return readdirSync(cwd)
    .filter((name) => !name.startsWith(".") && !SKIP_DIRS.has(name))
    .map((name) => join(cwd, name))
    .filter((dir) => isDir(dir) && existsSync(join(dir, ".git")))
    .sort();
}

export function nestedAgentsFiles(repo, maxDepth = 4) {
  const found = [];
  const walk = (dir, depth) => {
    if (depth > maxDepth) return;
    let entries;
    try {
      entries = readdirSync(dir, { withFileTypes: true });
    } catch {
      return;
    }
    for (const e of entries) {
      if (e.isFile() && e.name === "AGENTS.md") found.push(join(dir, e.name));
      else if (e.isDirectory() && !e.name.startsWith(".") && !SKIP_DIRS.has(e.name)) walk(join(dir, e.name), depth + 1);
    }
  };
  walk(repo, 0);
  return found.sort((a, b) => a.split(sep).length - b.split(sep).length || a.localeCompare(b));
}

export function repoOf(repos, filePath) {
  return repos.find((r) => {
    const rel = relative(r, filePath);
    return rel && !rel.startsWith("..") && !isAbsolute(rel);
  });
}

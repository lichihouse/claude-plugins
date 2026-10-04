#!/usr/bin/env node
// Validate tools/forks.json, or print the fork entries for given plugin paths.
//   node tools/check-forks.mjs                 check every entry (lint-port.sh runs this)
//   node tools/check-forks.mjs <path>...       print why each path differs from upstream
import { readFileSync, readdirSync, statSync } from "node:fs";
import { dirname, join, relative } from "node:path";
import { fileURLToPath } from "node:url";

const plugin = join(dirname(fileURLToPath(import.meta.url)), "..");
const { forks } = JSON.parse(readFileSync(join(plugin, "tools/forks.json"), "utf8"));

const toRegex = (glob) =>
	new RegExp(`^${glob.replace(/[.+?^${}()|[\]\\]/g, "\\$&").replace(/\*/g, "[^/]*")}$`);

function walk(dir) {
	return readdirSync(dir).flatMap((name) => {
		const full = join(dir, name);
		if (name === "node_modules" || name === "results" || name.startsWith(".")) return [];
		return statSync(full).isDirectory() ? walk(full) : [relative(plugin, full)];
	});
}

const args = process.argv.slice(2);
if (args.length) {
	for (const path of args) {
		const hits = forks.filter((f) => f.paths.some((p) => toRegex(p).test(path)));
		for (const f of hits) console.log(`FORK      ${path} [${f.kind}, ${f.since}] ${f.why}`);
	}
	process.exit(0);
}

const files = walk(plugin);
const problems = [];
forks.forEach((f, i) => {
	const at = `forks[${i}]`;
	if (!Array.isArray(f.paths) || !f.paths.length) problems.push(`${at}: paths must be a non-empty list`);
	if (!["port-feature", "policy"].includes(f.kind)) problems.push(`${at}: kind must be port-feature or policy`);
	if (!f.why?.trim()) problems.push(`${at}: why is empty`);
	if (!/^\d+\.\d+\.\d+-claude\.\d+$/.test(f.since ?? "")) problems.push(`${at}: since must look like 0.15.9-claude.1`);
	for (const p of f.paths ?? []) {
		if (!files.some((file) => toRegex(p).test(file))) problems.push(`${at}: ${p} matches no file in the plugin`);
	}
});
if (problems.length) {
	console.log(`Fork registry (tools/forks.json):\n${problems.join("\n")}\n`);
	process.exit(1);
}

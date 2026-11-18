import { existsSync } from "node:fs";
import { join } from "node:path";
import { pathToFileURL } from "node:url";
import { childRepos, isRepo, nestedAgentsFiles, projectDir, readHookInput } from "./repos.mjs";

export function reminder(cwd) {
  if (!cwd || existsSync(join(cwd, "AGENTS.md"))) return "";
  const repos = childRepos(cwd)
    .map((repo) => ({ repo, files: nestedAgentsFiles(repo) }))
    .filter((r) => r.files.length > 0);
  if (repos.length === 0) return "";
  const lines = [
    "<lichi-agents-md>",
    `Phiên này mở ở thư mục cha (${cwd}), nên Claude Code KHÔNG tự nạp AGENTS.md của repo con, và deny list .claude/settings.json của repo cũng không tự áp${isRepo(cwd) ? " (thư mục cha là repo nên hook lichi cũng KHÔNG chặn thay: tự tránh lệnh trong deny list repo con)" : " (hook lichi chặn thay)"}.`,
    "Trước khi đọc code, sửa, chạy lệnh hay trả lời về một repo dưới đây: Read AGENTS.md gốc của repo đó, và AGENTS.md lồng trong thư mục đang làm. Luật trong đó thắng mọi hướng dẫn khác về cách làm việc ở repo đó.",
    "Giao việc cho subagent: ghi đường dẫn AGENTS.md của repo vào brief.",
  ];
  for (const { repo, files } of repos) lines.push(`- ${repo}: ${files.join(", ")}`);
  lines.push("</lichi-agents-md>");
  return lines.join("\n");
}

export function hookOutput(input) {
  const text = reminder(projectDir(input));
  if (!text) return null;
  const event = input.hook_event_name ?? "SessionStart";
  return { hookSpecificOutput: { hookEventName: event, additionalContext: text } };
}

if (import.meta.url === pathToFileURL(process.argv[1] ?? "").href) {
  const input = readHookInput();
  try {
    const out = hookOutput(input);
    if (out) process.stdout.write(JSON.stringify(out));
  } catch (err) {
    process.stdout.write(
      JSON.stringify({
        hookSpecificOutput: {
          hookEventName: input.hook_event_name ?? "SessionStart",
          additionalContext: `<lichi-agents-md>Hook lichi lỗi (${err?.message ?? err}). Tự Read AGENTS.md của repo trước khi làm, và báo user hook lichi đang lỗi.</lichi-agents-md>`,
        },
      }),
    );
  }
}

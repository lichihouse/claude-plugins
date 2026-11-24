import { execFileSync } from "node:child_process";
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

export const NEON_REMINDER = [
  "<lichi-neon-soat>",
  "Quy trình Đức chốt 24/11/2026: ở repo Kho và Booking, phiên chính nhờ Gemini 4 Neon soát thứ hai theo skill lichi:neon-soat (Read SKILL.md của skill đó khi tới lúc) ở 3 lúc: plan việc rủi ro trước khi gửi Đức, diff PR có code trước khi merge, kết luận nguyên nhân / số đo trước khi báo. Neon không phải cổng chặn: không gọi được thì ghi `- neon: bỏ qua (lý do)` rồi làm tiếp.",
  "</lichi-neon-soat>",
].join("\n");

const NEON_REPOS = /lichihouse\/(quan-ly-kho|booking)(\.git)?$/i;

// Repo Kho hoặc Booking: nhận diện theo remote origin, nên worktree và thư mục đổi tên vẫn đúng.
export function isNeonRepo(dir) {
  try {
    const url = execFileSync("git", ["-C", dir, "config", "--get", "remote.origin.url"], {
      encoding: "utf8",
      stdio: ["ignore", "pipe", "ignore"],
      timeout: 3000,
    }).trim();
    return NEON_REPOS.test(url);
  } catch {
    return false;
  }
}

function needsNeon(cwd) {
  if (!cwd) return false;
  if (isNeonRepo(cwd)) return true;
  return childRepos(cwd).some(isNeonRepo);
}

export function hookOutput(input) {
  const event = input.hook_event_name ?? "SessionStart";
  const cwd = projectDir(input);
  const text = reminder(cwd);
  const neon = event === "SessionStart" && needsNeon(cwd) ? NEON_REMINDER : "";
  const parts = [text, neon].filter(Boolean);
  if (parts.length === 0) return null;
  return { hookSpecificOutput: { hookEventName: event, additionalContext: parts.join("\n") } };
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

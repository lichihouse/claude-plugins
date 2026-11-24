1. Muc dich: hook SessionStart cua plugin Claude Code nhac phien chinh dung skill neon-soat o MOI phien lam viec voi repo Kho va Booking.
2. Dung la gi: phien chinh nao lam viec o repo Kho hoac Booking cung nhan loi nhac, du phien mo o thu muc cha chua nhieu repo hay mo thang trong 1 repo. Subagent khong nhan.
3. Luat lien quan: ham reminder(cwd) tra chuoi rong khi cwd la mot repo co AGENTS.md o goc, hoac khi khong co repo con nao.
4. Cho nghi nhat: dieu kien nao lam phien chinh khong nhan loi nhac.
5. Ngoai pham vi: noi dung chu cua loi nhac.

Code can soat (plugins/lichi/hooks/agents-md.mjs):
export function hookOutput(input) {
  const event = input.hook_event_name ?? "SessionStart";
  const text = reminder(projectDir(input));
  const parts = [text, event === "SessionStart" && text ? NEON_REMINDER : ""].filter(Boolean);
  if (parts.length === 0) return null;
  return { hookSpecificOutput: { hookEventName: event, additionalContext: parts.join("\n") } };
}

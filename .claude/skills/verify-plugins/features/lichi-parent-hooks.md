# Hook lichi ở thư mục cha

Khi phiên mở ở một thư mục cha không phải repo (như `/home/user` của thread Project), Claude Code không tự nạp AGENTS.md và deny list của repo con. Plugin lichi bù: đầu phiên và đầu mỗi subagent nó bơm danh sách AGENTS.md cần đọc, và trước mỗi lệnh Bash / Edit / Write / Read nó chặn theo deny list `.claude/settings.json` của repo con.

## Sub-features

- `agents-md-start` SessionStart bơm khối `<lichi-agents-md>` liệt kê AGENTS.md gốc và lồng của từng repo con.
- `agents-md-subagent` SubagentStart bơm cùng khối cho mỗi subagent.
- `deny-bash` PreToolUse:Bash trả `permissionDecision: deny` khi lệnh khớp deny list của repo con, kể cả sau `cd RepoA &&`.
- `deny-path` PreToolUse:Edit / Write chặn file khớp luật `Edit(...)` / `Write(...)` của repo sở hữu file.
- `pass-daily` lệnh thường (`git status`) không bị chặn.
- `inside-repo` mở phiên ngay trong một repo thì lichi im lặng (Claude Code tự áp).

## How to get to it (user POV)

- Mở thread Project có nhiều repo (cwd là thư mục cha), hỏi bất cứ gì: khối nhắc AGENTS.md có sẵn trong context.
- Yêu cầu Claude chạy một lệnh có trong deny list của repo con.
- Yêu cầu một việc khiến Claude gọi subagent (Agent tool) khi đang ở thư mục cha.

## Driving it with control-plugins

Preconditions:

- `$CP doctor --probe` in `DOCTOR OK`.
- Fixture `parent` nguyên trạng: `git -C <RUN_DIR>/work/parent/RepoA diff --cached --name-only` rỗng.

- **Nhắc AGENTS.md + chặn Bash (đã chạy 19/11/2026).** Run `$CP drive lichi-deny --fixture parent --model sonnet --tools "Bash,Read" --max-turns 4 -- "Trong RepoA, chạy đúng lệnh này bằng Bash: cd RepoA && git add -A . Rồi nói lệnh có chạy được không và vì sao. Kể tên các file AGENTS.md bạn được nhắc phải đọc."` Summary phải có: `hook SessionStart:startup ... <lichi-agents-md>` nêu `RepoA/AGENTS.md`, `RepoA/web/AGENTS.md`, `RepoB/AGENTS.md`; `hook PreToolUse:Bash ... "permissionDecision":"deny"` với lý do là luật git add của RepoA; `tool-error PreToolUse:Bash hook error: Chặn theo deny list của .../RepoA`; câu trả lời nói lệnh bị chặn và kể đủ 3 AGENTS.md.
- **Tác dụng phụ.** Run `git -C <RUN_DIR>/work/parent/RepoA diff --cached --name-only > <RUN_DIR>/evidence/lichi-deny.after-git.txt`. File rỗng: không stage gì.
- **Lệnh thường đi qua.** Run `$CP drive lichi-pass --fixture parent --model sonnet --tools "Bash" --max-turns 3 -- "Chạy git -C RepoA status --short bằng Bash và báo kết quả."` Có `hook PreToolUse:Bash ... (không in gì)` và `tool Bash git -C RepoA status --short` không kèm `tool-error`.
- **Chặn file.** Run `$CP drive lichi-edit --fixture parent --model sonnet --tools "Write" --max-turns 3 -- "Tạo file RepoA/secrets/key.txt với nội dung x."` Có `hook PreToolUse:Write ... deny` nêu `Edit(secrets/**)`, và `ls <RUN_DIR>/work/parent/RepoA/secrets` báo không tồn tại.
- **Subagent.** Run `$CP drive lichi-subagent --fixture parent --model sonnet --tools "Agent,Read" --max-turns 4 -- "Dùng Agent (general-purpose) hỏi nó: trong context của nó có khối lichi-agents-md không, có thì kể tên các AGENTS.md. Báo lại nguyên văn."` Có một `hook SubagentStart` với `<lichi-agents-md>`.
- **Trong repo thì im.** Run `$CP drive lichi-inside --fixture bare --model haiku --max-turns 1 -- "Reply OK."` Hook SessionStart thứ hai (lichi) là `(không in gì)`.

## Gotchas

- `parent` là thư mục KHÔNG có `.git`. Nếu thư mục cha là repo, lichi vẫn nhắc nhưng nói rõ guard tắt: đừng `git init` ở `work/parent`.
- Model có thể tự né lệnh bị cấm mà không gọi Bash. Khi đó không có `PreToolUse:Bash` để chứng minh deny: ghi là không kiểm được, đừng tính là đạt. Prompt "chạy đúng lệnh này" giúp model gọi thật.
- `git status --porcelain` trong RepoA luôn có `?? AGENTS.md`, `?? .claude/` vì fixture không commit. Kiểm staging bằng `diff --cached`, không phải `status`.
- Hook PreToolUse của lichi chạy cả cho Read: summary sẽ có `PreToolUse:Read (không in gì)` cho mỗi lần đọc. Bình thường.
- Phiên đang chạy skill này cũng có thể chịu guard lichi với deny list thật của các repo cạnh bên. Nếu một lệnh của bạn bị chặn, đó là guard thật đang làm việc: đừng tìm cách lách, báo người dùng.

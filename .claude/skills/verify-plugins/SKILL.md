---
name: verify-plugins
description: Chạy một phiên Claude Code con (headless) nạp pstack + lichi từ checkout claude-plugins, trong thư mục fixture dùng một lần, rồi lưu stream-json làm bằng chứng hook, slash command, skill, subagent đã chạy đúng. Dùng khi sửa hook, skill, agent, plugin.json của pstack / lichi, hoặc trước khi nói một thay đổi plugin "đã chạy".
---

# verify-plugins

Repo này không có server. "App" là Claude Code nạp plugin: người dùng mở một phiên, hook SessionStart / UserPromptSubmit / PreToolUse chạy, họ gõ `/pstack:<tên>`, model gọi skill và subagent. Skill này dựng đúng đường đó: một tiến trình `claude -p` con, `--plugin-dir` trỏ vào `plugins/pstack` và `plugins/lichi` của checkout, cwd là một fixture tạm. Bản plugin synced từ claude.ai bị bản checkout che (`synced-plugin-shadowed`), nên bằng chứng là của code đang sửa.

Mọi lệnh chạy từ gốc repo. Harness: `.claude/skills/verify-plugins/scripts/control-plugins` (gọi tắt `CP` dưới đây). Bản đồ tính năng: `features/README.md`. Đọc nó trước khi lái.

```bash
CP=.claude/skills/verify-plugins/scripts/control-plugins
```

## Launch

```bash
$CP launch
# READY fixture: /var/tmp/verify-plugins/<giờ>/work/bare, .../work/parent
# dòng cuối là RUN_DIR; /var/tmp/verify-plugins/latest trỏ vào nó
```

Không build gì. `launch` tạo `RUN_DIR` gồm:
- `work/bare`: repo git một commit, có `math.ts`. Giống repo bình thường của người dùng.
- `work/parent`: thư mục cha KHÔNG phải repo, chứa `RepoA` (AGENTS.md gốc + `web/AGENTS.md`, deny `Bash(git add -A:*)`, `Bash(rm -rf:*)`, `Edit(secrets/**)`) và `RepoB` (deny `Bash(git push origin main:*)`). Giống `/home/user` của thread Project có Booking + Quan-ly-Kho.
- `env` (đường dẫn plugin, `GIT_REV` có `+dirty` nếu `plugins/` đang sửa dở), `sessions`, `evidence/`.

READY nghĩa là fixture có đủ. Chưa chứng minh đăng nhập: việc đó là `doctor --probe`.

Nhiều run song song được: mỗi run một `RUN_DIR`, đặt `VERIFY_PLUGINS_RUN=<RUN_DIR>` để chọn run, không dựa vào `latest`.

## Doctor

```bash
$CP doctor           # chỉ đọc, miễn phí
$CP doctor --probe   # thêm một lượt haiku (~$0.005, ~5 giây)
```

Kiểm: `claude` ≥ 2.1.273, `RUN_DIR` thuộc đúng checkout này, fixture còn, `claude plugin validate --strict` cho marketplace + 2 plugin, in version + git rev. `--probe` chạy `claude -p "Reply with exactly: PONG"` và đòi cả hai điều: trả lời PONG (đăng nhập chạy) và sự kiện `init` liệt kê `pstack` + `lichi` với `path` là checkout (không phải `/root/.claude/plugins/synced/...`). Dòng cuối `DOCTOR OK` / `DOCTOR FAIL`. Chạy doctor đầu tiên, và mỗi khi kết quả drive trông lạ.

## Drive

```bash
$CP drive <tên> [--fixture bare|parent] [--model haiku|sonnet|opus] [--max-turns N] \
  [--tools "Read,Glob,..."] [--resume <session_id>] -- "<prompt người dùng gõ>"
```

- Prompt là đúng chữ người dùng gõ, kể cả slash command: `-- "/pstack:how how does add() in math.ts work?"`.
- Mặc định `--fixture bare`, `--max-turns 6`, tools `Read,Glob,Grep,Agent,Skill,TaskCreate,TaskUpdate,TodoWrite` (không Bash / Edit / Write). Muốn thử hook PreToolUse:Bash thì `--tools "Bash,Read"`.
- Mặc định model là model mặc định của tài khoản (thường opus). Mỗi lượt tốn khoảng $0.1 đến $0.3 (sonnet đo được $0.10 đến $0.28) vì phải nạp cache context plugin. Hành vi định tuyến (playbook, todo, chọn subagent) phụ thuộc model: chứng minh trên model người dùng dùng thật, chỉ hạ `--model sonnet` / `haiku` khi chỉ kiểm hook.
- `--resume <session_id>` nối lượt tiếp theo vào cùng phiên (thử poteto-mode dính qua nhiều lượt). Lấy id từ dòng `session` của summary.
- `--strict-mcp-config` luôn bật: phiên con không có MCP server nào. Biến nối thread của phiên cha (`CLAUDE_CODE_MESSAGING_*`) bị gỡ, nên phiên con không nhắn được cho người dùng.
- Lỗi nếu `evidence/<tên>.jsonl` đã có. Đặt tên mới cho mỗi lượt.

Mỗi drive in summary: plugin nạp từ đâu, từng hook (`SessionStart:startup`, `UserPromptSubmit`, `PreToolUse:Bash`...) với exit code và output, từng tool call (Read path, Bash command, Agent `subagent_type` + `model` + `effort`, Skill), tool-error, `result` + chi phí, câu trả lời cuối. Đọc lại một file bất kỳ: `$CP summary <RUN_DIR>/evidence/<tên>.jsonl`.

Bộ hồi quy có sẵn là `claude plugin eval plugins/pstack` (case ở `plugins/pstack/evals/*/case.yaml`, chấm tự động, có nhánh không plugin để so). Drive dùng cho bằng chứng một thay đổi cụ thể; eval dùng cho cả bộ. Eval chạy nhiều phiên opus, tốn tiền: chỉ chạy khi người dùng hỏi hoặc khi sửa đúng hành vi một case đang chấm.

## Evidence

Tất cả nằm ở `<RUN_DIR>/evidence/`, cleanup không đụng tới:
- `<tên>.jsonl`: stream-json đầy đủ của phiên con (sự kiện `init`, `hook_response`, mọi message). Đây là bằng chứng gốc.
- `<tên>.summary.txt`, `<tên>.prompt.txt`, `<tên>.meta.txt` (fixture, model, exit code), `<tên>.stderr`.
- Tự thêm file cho tác dụng phụ, ví dụ `git -C <RUN_DIR>/work/parent/RepoA diff --cached --name-only > evidence/<tên>.after-git.txt`.

Chuẩn bằng chứng:
- Đi đường người dùng: prompt gõ như người thật, plugin nạp qua `--plugin-dir`. Không chạy `bash plugins/pstack/hooks/*.sh` bằng tay rồi gọi đó là bằng chứng: việc đó là `tools/test-hooks.sh`, chạy riêng.
- Bằng chứng một hook có hai nửa: sự kiện `hook_response` có output mong đợi (hook chạy), VÀ hành vi model khớp (model nhận được nó). Chỉ một nửa là chưa đủ.
- Tác dụng phụ kiểm riêng: file được sửa, index git, cờ `poteto-mode/<session_id>` dưới `~/.claude/plugins/data/pstack-inline/`, không chỉ câu model kể.
- Câu trả lời của model là lời khai, không phải bằng chứng. Đối chiếu với tool call và hook output trong `.jsonl`.
- Bằng chứng ghi rõ `GIT_REV` (in trong doctor) để biết là bản nào.

## Cleanup

```bash
$CP cleanup
# CLEANED. Bằng chứng còn ở <RUN_DIR>/evidence
```

Xoá `<RUN_DIR>/work`, transcript `~/.claude/projects/<slug của fixture>` và `~/.claude/pstack/<slug>` của run này, cờ poteto-mode của các session trong `<RUN_DIR>/sessions`. Không kill tiến trình nào: `claude -p` tự thoát khi xong. Nếu một drive bị treo, kill đúng PID con của lệnh drive mình chạy, không `pkill claude` (sẽ giết luôn phiên đang chạy skill này). Sau cleanup, `ls <RUN_DIR>/evidence` vẫn phải còn file.

## Trước khi push

CI (`.github/workflows/validate.yml`) chạy các lệnh này. Chạy chúng ngoài drive, không thay được drive:

```bash
claude plugin validate --strict . && claude plugin validate --strict plugins/pstack && claude plugin validate --strict plugins/lichi
bash plugins/pstack/tools/lint-port.sh
bash plugins/pstack/tools/test-hooks.sh
node --test plugins/lichi/hooks/hooks.test.mjs
```

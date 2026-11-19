# Slash command và subagent pstack

Mỗi skill pstack là một slash command `/pstack:<tên>`. Một số skill gọi subagent riêng của plugin (`pstack:reader` chỉ đọc, `pstack:poteto-agent` để viết code, `pstack:comment-sicko`) với model và effort lấy từ model map. Người dùng thấy điều này qua kết quả và qua tên agent trong giao diện.

## Sub-features

- `slash-list` init của phiên liệt kê `pstack:<tên>` cho các thư mục trong `plugins/pstack/skills/`.
- `how-reader` `/pstack:how <câu hỏi hẹp>` gọi đúng một Agent `subagent_type: pstack:reader`, model theo vai `how explainer`.
- `code-delegate` sửa code dưới poteto-mode gọi `pstack:poteto-agent` với cả `model` và `effort` theo vai code, không dùng `general-purpose`.
- `reader-readonly` `pstack:reader` không có Write / Edit.

## How to get to it (user POV)

- Gõ `/` trong Claude Code và tìm `pstack:`.
- Gõ `/pstack:how how does add() in math.ts work?`.
- Gõ `/pstack:poteto-mode <việc sửa code nhỏ>`.

## Driving it with control-plugins

Preconditions:

- `$CP doctor --probe` in `DOCTOR OK`.
- Fixture `bare` có `math.ts` chưa sửa.

- **Danh sách slash.** Run `python3 -c 'import json,sys;e=[json.loads(l) for l in open(sys.argv[1])];i=next(x for x in e if x.get("subtype")=="init");print("\n".join(sorted(c for c in i["slash_commands"] if c.startswith("pstack:"))))' <RUN_DIR>/evidence/_doctor-probe.jsonl > <RUN_DIR>/evidence/slash.txt` rồi so với `ls plugins/pstack/skills`. Hai danh sách khớp (skill nào cố ý ẩn thì ghi lại).
- **how gọi reader.** Run `$CP drive how-reader --max-turns 8 -- "/pstack:how how does add() in math.ts work? two sentences"`. Summary có đúng một `tool Agent pstack:reader model=<như map>`; không có `Edit` / `Write`.
- **Giao việc code.** Run `$CP drive code-delegate --max-turns 20 --tools "Read,Glob,Grep,Edit,Agent,TaskCreate,TaskUpdate,TaskList" -- "/pstack:poteto-mode rename add to sum in math.ts. Behavior stays the same. No shell, no git, no PR: stop after the edit lands and reply in one line."` Có `tool Agent pstack:poteto-agent model=opus effort=medium` (hoặc low cho đổi tên vặt). Run `grep -n sum <RUN_DIR>/work/bare/math.ts` thấy hàm đã đổi tên.
- **Trả fixture.** Run `git -C <RUN_DIR>/work/bare checkout -- math.ts`.

## Gotchas

- Model map của máy này có dòng `[user]`: model mong đợi là của dòng đó, không phải mặc định của skill. Xem `hook SessionStart` trong summary trước khi chấm.
- Subagent chạy trong phiên con nên tốn thêm tiền và thời gian (vài phút với opus). Đặt `--max-turns` đủ, nếu không `result` là `error_max_turns` trước khi Agent trả về.
- Eval có sẵn cho hai việc này: `plugins/pstack/evals/how-spawns-reader`, `code-delegate-effort`. Cần chấm lặp lại thì dùng `claude plugin eval plugins/pstack --case how-spawns-reader`.

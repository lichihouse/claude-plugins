# poteto-mode

poteto-mode là chế độ làm việc chính của pstack: khớp việc với một playbook, đọc playbook, mở todo list trước khi đọc code. Hook `poteto-mode-sticky.sh` (UserPromptSubmit) giữ nó bật qua các lượt sau khi người dùng gõ `/pstack:poteto-mode`, nhắc một dòng mỗi lượt, và tắt khi người dùng nói tắt.

## Sub-features

- `on` prompt bắt đầu bằng `/pstack:poteto-mode` nhận cổng setup đầy đủ (`pstack poteto-mode is on. Before any other tool call...`) và tạo cờ tên bằng session id.
- `sticky` lượt sau trong cùng phiên nhận dòng nhắc `pstack poteto-mode is on. New task? ...`.
- `off` `/pstack:poteto-mode off|stop|exit|tắt|thoát` (tối đa hai từ lịch sự) hoặc `tắt poteto-mode` xoá cờ, hook in `poteto-mode is now off`.
- `no-false-off` nhắc tới "poteto-mode off" trong câu dài không tắt.
- `setup-gate` khi bật, model Read playbook dưới `skills/poteto-mode/` và mở todo (TaskCreate) trước khi đọc code.
- `auto-route` không gõ slash nhưng việc đủ lớn (nhiều module, bug chưa rõ nguyên nhân) thì model tự vào và nói một dòng.

## How to get to it (user POV)

- Gõ `/pstack:poteto-mode <việc>`.
- Gõ tiếp các câu khác trong cùng phiên.
- Gõ `/pstack:poteto-mode off` hoặc `tắt poteto-mode nhé`.

## Driving it with control-plugins

Preconditions:

- `$CP doctor --probe` in `DOCTOR OK`.

- **Bật (đã chạy 19/11/2026).** Run `$CP drive sticky-1 --model sonnet --max-turns 2 -- "/pstack:poteto-mode trả lời một dòng: hook báo poteto-mode đang bật hay tắt?"` Có `hook UserPromptSubmit ... pstack poteto-mode is on. Before any other tool call`. Run `ls ~/.claude/plugins/data/pstack-inline/poteto-mode/` thấy file tên bằng session id.
- **Dính (đã chạy).** Lấy `SID` từ dòng `session` của summary. Run `$CP drive sticky-2 --model sonnet --max-turns 1 --resume $SID -- "Câu hỏi nhanh: 2+2 bằng mấy? Một dòng."` Có `hook UserPromptSubmit ... New task? Playbook match or rigor needed`, và model trả lời thẳng không mở playbook (lượt vặt).
- **Tắt (đã chạy).** Run `$CP drive sticky-3 --model sonnet --max-turns 1 --resume $SID -- "/pstack:poteto-mode off"`. Có `poteto-mode is now off for this session`; `ls ~/.claude/plugins/data/pstack-inline/poteto-mode/ | grep $SID` rỗng.
- **Cổng setup.** Run `$CP drive gate --max-turns 12 -- "/pstack:poteto-mode thêm hàm sub(a, b) vào math.ts, có test."` (model mặc định). Thứ tự tool trong summary: Read `skills/poteto-mode/SKILL.md` hoặc playbook khớp, `TaskCreate`, rồi mới `Read .../math.ts`. Bất kỳ Read code nào trước TaskCreate là trượt.
- **Không tắt nhầm.** Sau khi bật (phiên mới), resume với `"Giải thích cho tôi khi nào nên gõ poteto-mode off."` Hook vẫn in dòng nhắc `is on`.

## Gotchas

- Cờ nằm ở `CLAUDE_PLUGIN_DATA` của plugin inline: `~/.claude/plugins/data/pstack-inline/poteto-mode/`, không phải `pstack-synced`. Tìm nhầm thư mục sẽ tưởng cờ không được tạo.
- `--resume` giữ nguyên session id, nên cờ và lời nhắc nối đúng phiên. Phiên mới (không resume) không có cờ.
- Tools mặc định của drive không có Bash, nên playbook đòi chạy test / git sẽ dừng ở bước đó. Kiểm cổng setup chỉ cần thứ tự tool đầu, không cần chạy hết playbook.
- Hạ model xuống haiku làm hành vi cổng setup kém đi. Chỉ hạ model cho bước `on` / `sticky` / `off` (kiểm hook), không cho `setup-gate` / `auto-route`.

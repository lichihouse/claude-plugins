# Bản đồ verify pstack + lichi

Nguồn duy trì để kiểm chứng hành vi người dùng thấy của hai plugin trong repo này. Đọc file này rồi mở file tính năng khớp với thay đổi.

## Điều kiện nền

- `$CP launch` tạo một `RUN_DIR` mới; `$CP doctor --probe` in `DOCTOR OK` và `pstack + lichi nạp từ checkout`.
- `CP=.claude/skills/verify-plugins/scripts/control-plugins`, chạy từ gốc repo.
- Fixture `bare` (repo một commit, `math.ts`) và `parent` (thư mục cha, `RepoA` + `RepoB` có AGENTS.md và deny list) như `launch` tạo, chưa bị sửa.
- Chỉ lái phiên con do run này tạo. Không thử trên phiên đang chạy skill này: nó nạp bản synced, không phải checkout.

## Quy ước lái

- Prompt là chữ người dùng gõ. Giữ nguyên slash command, dấu và cách viết.
- Mỗi lượt một tên evidence mới. Lượt nối tiếp dùng `--resume <session_id>`.
- Hạ model (`--model sonnet|haiku`) chỉ khi kiểm hook. Kiểm định tuyến (playbook, todo, subagent) thì để model mặc định.
- Sửa fixture (thêm `.claude/pstack-models.md`, file code) thì ghi lệnh đã chạy vào evidence.

## Bằng chứng và báo bỏ qua

- Mỗi khẳng định chỉ ra dòng `hook` / `tool` / `result` trong `<tên>.summary.txt`, và `<tên>.jsonl` là gốc.
- Tác dụng phụ (git index, file, cờ poteto-mode) kiểm bằng lệnh đọc riêng, lưu kết quả vào `evidence/`.
- Đường vào nào không đi được thì ghi lệnh đã thử và điều kiện thiếu. Không báo một đường vào là đã kiểm khi chỉ kiểm đường khác.

## Hợp đồng mỗi file tính năng

H1 + một đoạn mô tả, rồi đúng bốn H2 theo thứ tự: `Sub-features`, `How to get to it (user POV)`, `Driving it with control-plugins` (mở đầu bằng `Preconditions:`), `Gotchas`.

## Tính năng

- [SessionStart của pstack](./pstack-session-start.md): model map, auto-route, đường dẫn transcript và store mà pstack bơm vào đầu phiên.
- [poteto-mode](./poteto-mode.md): bật bằng slash, dính qua các lượt, tắt, tự vào khi auto-route.
- [Slash command và subagent pstack](./pstack-slash-subagents.md): `/pstack:<skill>` nạp đúng skill, gọi `pstack:reader` / `pstack:poteto-agent` với model + effort theo map.
- [Hook lichi ở thư mục cha](./lichi-parent-hooks.md): nhắc đọc AGENTS.md và chặn lệnh theo deny list repo con. **Đã chạy đầu cuối khi tạo skill (19/11/2026).**
- [Skill kiến thức lichi](./lichi-knowledge-skills.md): `shopee-open-api`, `tiktok-shop-api` được gọi khi hỏi về API sàn.

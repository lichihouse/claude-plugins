# SessionStart của pstack

Đầu mỗi phiên, hook `plugins/pstack/hooks/session-start.sh` bơm khối `<pstack>` vào context: thư mục gốc pstack, tên agent có tiền tố `pstack:`, đường dẫn transcript, store pstack, bảng model map theo vai (mặc định / user / project) và luật auto-route. Người dùng không thấy khối này, nhưng mọi skill pstack dựa vào nó.

## Sub-features

- `root` dòng `pstack root:` trỏ đúng thư mục plugin đang nạp.
- `map-default` vai không bị đè mang nhãn `[default]`.
- `map-user` dòng trong `~/.claude/pstack-models.md` mang nhãn `[user]`.
- `map-project` dòng trong `<repo>/.claude/pstack-models.md` đè user, nhãn `[project]`; vai lạ bị đếm, không in lại.
- `auto-route-on` luật auto-route có mặt; `# auto-route: off` trong map thì tắt.
- `paths` dòng transcript phiên, subagent, store `~/.claude/pstack/<slug>/`.

## How to get to it (user POV)

- Mở bất kỳ phiên Claude Code nào có plugin pstack.
- Tạo `.claude/pstack-models.md` trong repo (hoặc chạy `/pstack:setup-pstack`) rồi mở phiên mới.

## Driving it with control-plugins

Preconditions:

- `$CP doctor --probe` in `DOCTOR OK`.
- Biết `~/.claude/pstack-models.md` của máy có gì: `cp ~/.claude/pstack-models.md <RUN_DIR>/evidence/user-map.txt` (không có file thì ghi "không có").

- **Hook chạy và model nhận được.** Run `$CP drive ss-map --model sonnet --max-turns 1 --tools "" -- "Answer from your context only. Do not read files or run tools. Quote verbatim, each on its own line, the lines for the roles hardest tasks and judgment and prose from the pstack model map in your context, including the bracketed source tag. If there is no pstack model map, reply exactly NO MAP."` Summary có `hook SessionStart:startup ... <pstack>⏎ pstack root: <checkout>/plugins/pstack`, không có dòng `tool`, và câu trả lời trích đúng hai dòng với nhãn khớp `user-map.txt` (vai có trong file user thì `[user]`, không thì `[default]`).
- **Map của repo đè.** Run `mkdir -p <RUN_DIR>/work/bare/.claude && printf 'hardest tasks: sonnet low\n# auto-route: off\n' > <RUN_DIR>/work/bare/.claude/pstack-models.md`, rồi drive `ss-project` với cùng prompt, hỏi thêm "and the pstack auto-route line". Trả lời có `hardest tasks: sonnet low  [project]` và auto-route báo off.
- **Trả fixture.** Run `rm <RUN_DIR>/work/bare/.claude/pstack-models.md`.

## Gotchas

- Máy cloud của project này CÓ `~/.claude/pstack-models.md` (budget large, nhiều vai `[user]`). Eval `session-map` mong `[default]` sẽ trượt ở đây dù hook đúng. Đối chiếu với `user-map.txt`, đừng sửa hook cho khớp eval.
- `--tools ""` để chứng minh câu trả lời đến từ context chứ không phải từ đọc README / `tools/test-hooks.sh` (hai file đó cũng chứa chuỗi `[default]`).
- Init phải có `plugin_warnings` `synced-plugin-shadowed` cho pstack. Nếu thiếu và `pstack root` trỏ `/root/.claude/plugins/synced/...` thì `--plugin-dir` không ăn: dừng, đừng chấm.

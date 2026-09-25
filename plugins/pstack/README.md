# pstack cho Claude Code

Bản port của [pstack](https://github.com/cursor/plugins/tree/main/pstack) (poteto / Lauren Tan, MIT) từ Cursor sang Claude Code. Nội dung skill, playbook, principle giữ y như bản gốc. Chỉ đổi những chỗ Cursor và Claude Code chạy khác nhau (tên tool, tên model, file cấu hình, đường dẫn transcript, agent chạy cloud).

- Dựa trên upstream **0.15.5**, commit `12d587dfb207` (ghi trong [`tools/UPSTREAM`](tools/UPSTREAM)).
- Phiên bản port: `0.15.5-claude.2`.
- Hướng dẫn gốc (tiếng Anh, đã sửa lệnh cho Claude Code): [`docs/guide/`](docs/guide/README.md).

## Cài đặt: gắn vào tài khoản claude.ai (dùng cho mọi repo)

Làm **một lần trên claude.ai bằng trình duyệt** (không làm trong app Desktop / Cowork, vì ở đó plugin chỉ lưu trên máy):

1. Vào claude.ai → thanh trái **Customize** → tab **Plugins**.
2. Mục **Personal plugins** → bấm **+** → **Add marketplace** → **Add from a repository** → nhập `lichihouse/claude-plugins`.
3. Trong marketplace vừa thêm, cài **pstack**.

Cách khác nếu bước 2 không đọc được repo: cũng ở **Personal plugins**, chọn upload file plugin (`pstack-<version>.zip`, tạo bằng `bash plugins/pstack/tools/build-zip.sh`).

Sau đó plugin tự có mặt ở:

| Nơi dùng | Điều kiện | Kiểm tra |
|---|---|---|
| Claude Code trên web, tab Code trong app Desktop / mobile (cloud session) | Không cần gì thêm, mỗi phiên tự tải | Gõ `/pstack:` thấy danh sách skill |
| Claude Code ở terminal | Bản ≥ 2.1.273, đăng nhập bằng tài khoản claude.ai (`/login`) | `claude plugin list` có `pstack@synced` |

Plugin theo tài khoản nạp đủ skill, agent và hook. Có một issue mở (anthropics/claude-code#92031) nói plugin cá nhân cài từ marketplace có lúc không xuất hiện trong phiên web. Nếu gặp: thử cách upload file, hoặc cài vào repo dạng skill dự án (mục dưới).

### Dự phòng: skill dự án trong một repo

```bash
bash plugins/pstack/tools/install-as-project-skills.sh <thư-mục-repo> [--force]
```

Tạo symlink `skills/*` vào `.claude/skills/`, `agents/*` vào `.claude/agents/` của repo đó, rồi in khối `hooks` để dán vào `.claude/settings.json`. Lệnh gõ khi đó không có tiền tố (`/how`). Chỉ dùng khi cách theo tài khoản không chạy.

### Thử nhanh không cài

```bash
claude --plugin-dir plugins/pstack
```

## Bắt đầu

1. `/pstack:setup-pstack`. Chọn budget và model cho từng vai. Ghi ra `.claude/pstack-models.md` (dự án, commit để cả team dùng chung) hoặc `~/.claude/pstack-models.md` (cá nhân).
2. `/pstack:poteto-mode <việc cần làm>`. Mode tự chọn playbook, chạy skill khác khi cần. Mode "dính" qua các lượt sau. Tắt bằng `/pstack:poteto-mode off` hoặc gõ "tắt poteto-mode".

```text
/pstack:poteto-mode trang đơn hàng bị nhân đôi dòng khi retry giữa chừng. repro trước, rồi sửa và chứng minh.
```

## Skill

| Gõ | Dùng khi |
|---|---|
| `/pstack:poteto-mode` | Việc cần làm kỹ, gọn, có kiểm chứng. Điểm vào mặc định. |
| `/pstack:how` | Cái này chạy thế nào? File nào phụ trách? Nên đặt ở đâu? |
| `/pstack:why` | Sao ngày xưa làm vậy? Tra git, PR, ticket, chat, log qua MCP. |
| `/pstack:teach` | Giải thích cho tôi hiểu thật (how + why, từng sơ đồ). |
| `/pstack:recall` | Tôi đang làm dở chỗ nào? Dựng lại ngữ cảnh từ lịch sử chat. |
| `/pstack:blast-radius` | Sửa cái này thì vỡ chỗ nào? Chạy thật để chứng minh. |
| `/pstack:architect` | Phác kiểu, chữ ký hàm, module trước khi viết code. |
| `/pstack:arena` | Nhiều model làm cùng một việc, chọn bản tốt, ghép điểm hay. |
| `/pstack:swarm` | Chia nhiều việc nhỏ, chạy song song, gom một báo cáo. |
| `/pstack:interrogate` | Nhiều model soi lỗ hổng một diff. Chỉ kết luận, không tự sửa. |
| `/pstack:figure-it-out` | Việc lớn chưa có playbook. Thiết kế quy trình rồi mới làm. |
| `/pstack:show-me-your-work` | Nhật ký quyết định (TSV) để review sau. |
| `/pstack:tdd` | Viết test fail trước rồi mới sửa. |
| `/pstack:deslop` | Dọn code "rác AI" trong diff trước khi commit. |
| `/pstack:no-comments` | Xoá comment thừa (gọi agent Comment Sicko). |
| `/pstack:unslop` | Dọn văn phong AI trong chữ viết. |
| `/pstack:technical-writing` | Viết docs, README, PR, commit message. |
| `/pstack:bro` | Nói lại tin trước bằng lời dễ hiểu. |
| `/pstack:create-verification-skill` | Tạo skill `verify-<app>` để agent bấm app như người dùng. |
| `/pstack:maintain-verification-skill` | Skill verify đã lệch app, sửa lại. |
| `/pstack:control-ui` / `/pstack:control-cli` | Lái trình duyệt / CLI để lấy bằng chứng (Playwright, CDP). |
| `/pstack:typescript-best-practices` | Quy tắc TypeScript. |
| `/pstack:reflect` | Học từ phiên vừa xong, đề xuất sửa skill. |
| `/pstack:automate-me` | Tạo `<tên-bạn>-mode` từ thói quen làm việc của bạn. |
| `/pstack:setup-pstack` | Đổi model và mức nỗ lực (effort) cho từng vai. |
| `/pstack:tieng-viet` | Bảng tra tiếng Việt: lệnh nào dùng khi nào, câu tiếng Việt → lệnh. |

Ở chế độ skill dự án, bỏ tiền tố: `/how`, `/why`… 23 skill `principle-*` là nội quy, poteto-mode tự đọc khi cần.

Agent: `pstack:poteto-agent` (làm việc theo poteto-mode) và các biến thể theo mức nỗ lực `pstack:poteto-agent-low|medium|high|xhigh|max`, `pstack:reader` (chỉ đọc, vẫn dùng được MCP), `pstack:comment-sicko`. Ở chế độ skill dự án thì bỏ tiền tố `pstack:`.

## Khác gì bản Cursor

| Cursor | Claude Code (bản này) |
|---|---|
| Tool `Task` | Tool `Agent` |
| `subagent_type: generalPurpose` | `general-purpose` |
| `readonly: true` (Ask mode, mất MCP) | agent `pstack:reader` (không sửa file, vẫn giữ MCP) |
| `environment: "cloud"` | `run_in_background` + `isolation: "worktree"`, hoặc `create_session` khi có công cụ Claude Code Remote |
| `AskQuestion` | `AskUserQuestion` |
| `~/.cursor/rules/pstack-models.mdc` (rule luôn áp dụng) | `.claude/pstack-models.md` › `~/.claude/pstack-models.md`, hook SessionStart bơm vào mỗi phiên |
| Model `grok-4.7-xhigh-fast` / `claude-opus-5-5-max` / `gpt-5.6-sol-max` (slug gộp cả mức effort) | tên model Claude + effort tuỳ chọn, ví dụ `opus medium` cho code (xem bảng dưới) |
| `~/.cursor/projects/<slug>/agent-transcripts/` | `~/.claude/projects/<slug>/<session>.jsonl`, hook báo đường dẫn phiên hiện tại |
| `.cursor/skills/verify-<app>/` | `.claude/skills/verify-<app>/` |
| `create-skill` (built-in Cursor) | skill `skill-creator` nếu có, không thì playbook Authoring a skill |
| `deslop`, `control-ui`, `control-cli` (plugin `cursor-team-kit`) | đóng gói sẵn trong bản này (MIT, xem `LICENSE.cursor-team-kit`) |
| Skill `mode: true` + `reminder:` | hook UserPromptSubmit giữ poteto-mode qua các lượt |
| `/loop`, `/goal` | `/loop` giữ nguyên (agent tự gọi được). `/goal` chỉ người dùng gõ được, nên playbook in sẵn dòng `/goal …` để bạn dán |
| Cloud-sleeper wake chain | `/loop 30m …` (local) hoặc `send_later` / Routine (cloud) |

Không port: `make-bot-ui` (gắn với webhook Cursor Automations / Grok Bot) và gói automation `benny` (Cursor Automations).

## Bảng model mặc định

Mỗi dòng trong bảng model là `<model>` hoặc `<model> <effort>`. Model là `fable`, `opus`, `sonnet`, `haiku` (luôn là bản mới nhất của dòng đó) hoặc `inherit-parent` (dùng model của phiên chính). Effort là `low`, `medium`, `high`, `xhigh`, `max`.

Claude Code chỉ đặt effort trong định nghĩa agent, không đặt khi gọi `Agent`. Vì vậy plugin có sẵn `pstack:poteto-agent-<effort>`. Dòng `opus medium` nghĩa là gọi `pstack:poteto-agent-medium` với model `opus`. Effort chỉ áp dụng cho các vai gọi `pstack:poteto-agent`: 4 vai code, `hardest tasks`, `judgment and prose`. Dòng không ghi effort thì chạy theo effort của phiên.

| Vai | Mặc định |
|---|---|
| feature, refactoring · bug-fix · perf-issue · hillclimb | `opus medium` |
| judgment and prose | `opus` |
| hardest tasks | `fable` |
| how explorer · why investigators · swarm workers · reflect tooling | `sonnet` |
| how explainer · why synthesizer · reflect judgment | `opus` |
| arena runners · architect runners · interrogate reviewers | `fable, opus, sonnet` |
| arena cross-judge pool | `fable, opus` |

"Budget" của `/pstack:setup-pstack` là **trần model**, giữ nguyên effort: unlimited → fable, large → opus, medium → sonnet nhưng giữ opus cho các vai phán đoán, small → sonnet + haiku cho việc đọc hàng loạt.

Bản gốc dùng 3 hãng khác nhau cho panel review để có góc nhìn khác nhau. Ở đây cả panel là Claude, nên `interrogate` giao thêm cho mỗi reviewer một góc nhìn riêng: đúng / race / edge case · phân quyền / bảo mật / dữ liệu destructive · nghiệp vụ (tiền, múi giờ, parity giữa các đường đọc).

Đổi riêng cho một repo: chạy `/pstack:setup-pstack`, chọn ghi vào `.claude/pstack-models.md` của repo đó rồi commit. Đổi cho mọi repo trên máy: chọn `~/.claude/pstack-models.md`.

## Hook

- `SessionStart` ([`hooks/session-start.sh`](hooks/session-start.sh)): in bảng model đang áp dụng (ghi rõ nguồn project / user / default), đường dẫn transcript, gốc plugin, và chế độ nạp (plugin hay skill dự án).
- `UserPromptSubmit` ([`hooks/poteto-mode-sticky.sh`](hooks/poteto-mode-sticky.sh)): bật / tắt poteto-mode theo phiên và nhắc ở mỗi lượt sau.

## Bảo trì (cho người nâng cấp plugin)

```bash
bash plugins/pstack/tools/sync-upstream.sh [ref]     # kéo upstream mới, 3-way merge vào bản port
bash plugins/pstack/tools/lint-port.sh               # chặn từ khoá chỉ Cursor mới hiểu, tên skill sai
bash plugins/pstack/tools/test-hooks.sh              # test hành vi 2 hook
bash plugins/pstack/tools/build-zip.sh               # đóng gói zip để upload lên claude.ai
bash plugins/pstack/tools/gen-agent-variants.sh      # sinh lại poteto-agent-<effort> sau khi sửa poteto-agent.md
claude plugin validate --strict plugins/pstack       # kiểm tra manifest, hooks
claude plugin validate --strict .                    # kiểm tra marketplace
```

`sync-upstream.sh` lấy base là commit trong `tools/UPSTREAM`, merge thay đổi upstream lên bản port. Dòng nào cả hai phía cùng sửa thì để marker conflict (`<<<<<<< port`). Còn conflict thì mốc chưa dời: sửa xong chạy `sync-upstream.sh --pin <sha>`. Port file mới, xem các dòng `UNMAPPED`, chạy lint + test + validate, rồi tăng `version` trong `.claude-plugin/plugin.json` (claude.ai chỉ cập nhật plugin khi version đổi).

### Eval hành vi

Lint và validate chỉ đọc file. Eval chạy plugin thật trong một phiên Claude Code con, rồi chấm theo những gì phiên đó làm (tool gọi, output hook, file tạo ra, câu trả lời). Chạy sau mỗi lần sync upstream hoặc sửa skill.

```bash
claude plugin eval plugins/pstack --runs 1 --ablation none --scaffold --allow-tools Write --trust-plugin --no-publish
```

- Mỗi case là `evals/<case>/case.yaml`. Case cần repo mẫu có `scaffold.sh` tạo `math.js` (`add()` kẹp tổng qua `clamp()` về [-1000, 1000]), nên phải có `--scaffold`.
- `--allow-tools Write` dành cho `reader-cannot-edit`. Không cấp Bash, vì eval chỉ cho Bash khi máy có sandbox (bubblewrap + socat).
- Bỏ `--ablation none` thì mỗi case chạy thêm một nhánh không plugin và báo Δ. Nhánh đó phải điểm thấp, nếu không thì grader không đo gì.
- `--runs 1` tốn khoảng 1 phút và $0.5. Bỏ cờ này thì mỗi case chạy 3 lần. Kết quả ở `evals/results/` (đã gitignore).

| Case | Chứng minh |
|---|---|
| `how-spawns-reader` | `/pstack:how` với câu hỏi hẹp gọi đúng một `Agent` loại `pstack:reader`, model `opus` lấy từ bảng model, và câu trả lời nêu clamp. |
| `session-map` | Hook SessionStart chạy và bơm bảng model. Câu trả lời trích `hardest tasks: fable  [default]` và `judgment and prose: opus  [default]` mà không đọc file. |
| `poteto-bugfix-routing` | `/pstack:poteto-mode` với bug "repro first" đọc `playbooks/bug-fix.md`, không đọc playbook khác, rồi mở todo (`TaskCreate`) có bước repro đứng đầu. |
| `reader-cannot-edit` | `pstack:reader` từ chối tạo file dù phiên có Write. Không có lệnh Write nào, và file không xuất hiện. |
| `poteto-off` | `/pstack:poteto-mode off` trả lời một dòng. Không đọc file, không gọi agent, không mở todo. |

## License

MIT. pstack © 2026 Lauren Tan ([`LICENSE`](LICENSE)). `deslop`, `control-ui`, `control-cli` © 2026 Cursor ([`LICENSE.cursor-team-kit`](LICENSE.cursor-team-kit)).

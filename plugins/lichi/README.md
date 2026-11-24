# lichi

Kiến thức nghiệp vụ và tích hợp riêng của LICHI, dùng được trong mọi phiên Claude Code của tài khoản (Booking, Quan-ly-Kho, BigQuery...).

| Skill | Dùng khi |
|---|---|
| `shopee-open-api` | Viết code gọi Shopee, thiết kế nạp dữ liệu Shopee vào BigQuery, hỏi về API Shopee. Gồm toàn bộ tài liệu Shopee Open Platform API v2 (tải 2026-10-31), bài học từ code Booking, đề xuất bảng `raw_shopee`, và script tải lại tài liệu. |
| `neon-soat` | Repo Kho và Booking: nhờ Gemini 4 Neon (Antigravity của Đức, qua T3 Code trên Mac, script `~/.claude/neon-soat.sh`) soát thứ hai plan việc rủi ro, diff PR có code, kết luận trước khi báo. Không phải cổng chặn: không gọi được thì ghi lý do. Cài trên Mac: Đức chạy `skills/neon-soat/cai-tren-mac.sh`. |
| `tiktok-shop-api` | Viết code gọi TikTok Shop, chọn version API, thiết kế nạp dữ liệu TikTok vào BigQuery, hỏi về API TikTok Shop. Gồm toàn bộ tài liệu Partner Center (318 API, 44 webhook, changelog, Developer Guide, tải 2026-10-31), bảng endpoint Booking đang gọi và việc cần nâng, hạn khai tử, đề xuất bảng `raw_tiktok`, và script tải lại tài liệu. |

## Hook (từ 0.3.0)

Chỉ chạy khi phiên mở ở thư mục cha chứa nhiều repo (thread Project của claude.ai mở ở `/home/user`). Phiên mở trong một repo thì Claude Code tự nạp `AGENTS.md` và `.claude/settings.json`, hook đứng ngoài.

| Hook | Việc |
|---|---|
| `SessionStart`, `SubagentStart` (`hooks/agents-md.mjs`) | Thêm vào ngữ cảnh danh sách `AGENTS.md` của mọi repo con (cả file lồng như `artifacts/ios-app/AGENTS.md`) và nhắc Read trước khi làm. Subagent cũng nhận. Phiên chính (SessionStart) ở repo Kho / Booking (nhận theo remote origin), hoặc thư mục cha chứa chúng, nhận thêm lời nhắc dùng skill `neon-soat` (từ 0.4.0). |
| `PreToolUse` (`hooks/deny-guard.mjs`) | Áp phần `deny` trong `.claude/settings.json` của repo con. Lệnh Bash nêu tên đúng 1 repo (`cd Booking && …`) dùng deny list của repo đó; lệnh không nêu repo nào dùng hợp của mọi repo. Edit / Write theo repo chứa file. Hook lỗi thì không chặn (ruleset GitHub vẫn chặn nhánh chính) và ghi lỗi ra stderr. |

Test: `node --test plugins/lichi/hooks/hooks.test.mjs` (CI chạy).

Cài trên máy: `/plugin marketplace add lichihouse/claude-plugins` rồi `/plugin install lichi@lichihouse` (hoặc qua claude.ai → Customize → Plugins, xem README gốc).

Claude tự gọi skill khi việc liên quan Shopee hoặc TikTok Shop; gọi tay: `/lichi:shopee-open-api`, `/lichi:tiktok-shop-api`.

Cập nhật tài liệu Shopee: `python3 -I skills/shopee-open-api/scripts/fetch_shopee_docs.py /tmp/shopee-moi`, so `diff -r`, chép `reference/` mới vào, sửa 01–04 nếu cần, tăng `version` trong `.claude-plugin/plugin.json`.

Cập nhật tài liệu TikTok Shop (cần Node 18+, Playwright chỉ khi TikTok chặn gọi thẳng): xem mục 5 trong `skills/tiktok-shop-api/SKILL.md` (`scripts/fetch-docs.js` rồi `scripts/build.py`), tăng `version` như trên.

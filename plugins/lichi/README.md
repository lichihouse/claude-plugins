# lichi

Kiến thức nghiệp vụ và tích hợp riêng của LICHI, dùng được trong mọi phiên Claude Code của tài khoản (Booking, Quan-ly-Kho, BigQuery...).

| Skill | Dùng khi |
|---|---|
| `shopee-open-api` | Viết code gọi Shopee, thiết kế nạp dữ liệu Shopee vào BigQuery, hỏi về API Shopee. Gồm toàn bộ tài liệu Shopee Open Platform API v2 (tải 2026-10-31), bài học từ code Booking, đề xuất bảng `raw_shopee`, và script tải lại tài liệu. |
| `tiktok-shop-api` | Viết code gọi TikTok Shop, chọn version API, thiết kế nạp dữ liệu TikTok vào BigQuery, hỏi về API TikTok Shop. Gồm toàn bộ tài liệu Partner Center (318 API, 44 webhook, changelog, Developer Guide, tải 2026-10-31), bảng endpoint Booking đang gọi và việc cần nâng, hạn khai tử, đề xuất bảng `raw_tiktok`, và script tải lại tài liệu. |

Cài: `/plugin install lichi --marketplace lichihouse/claude-plugins` (hoặc qua claude.ai → Customize → Plugins, xem README gốc).

Claude tự gọi skill khi việc liên quan Shopee hoặc TikTok Shop; gọi tay: `/lichi:shopee-open-api`, `/lichi:tiktok-shop-api`.

Cập nhật tài liệu Shopee: `python3 -I skills/shopee-open-api/scripts/fetch_shopee_docs.py /tmp/shopee-moi`, so `diff -r`, chép `reference/` mới vào, sửa 01–04 nếu cần, tăng `version` trong `.claude-plugin/plugin.json`.

Cập nhật tài liệu TikTok Shop (cần Node + Playwright): xem mục 5 trong `skills/tiktok-shop-api/SKILL.md` (`scripts/fetch-docs.js` rồi `scripts/build.py`), tăng `version` như trên.

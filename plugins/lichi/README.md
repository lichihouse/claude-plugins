# lichi

Kiến thức nghiệp vụ và tích hợp riêng của LICHI, dùng được trong mọi phiên Claude Code của tài khoản (Booking, Quan-ly-Kho, BigQuery...).

| Skill | Dùng khi |
|---|---|
| `shopee-open-api` | Viết code gọi Shopee, thiết kế nạp dữ liệu Shopee vào BigQuery, hỏi về API Shopee. Gồm toàn bộ tài liệu Shopee Open Platform API v2 (tải 2026-10-31), bài học từ code Booking, đề xuất bảng `raw_shopee`, và script tải lại tài liệu. |

Cài: `/plugin install lichi --marketplace lichihouse/claude-plugins` (hoặc qua claude.ai → Customize → Plugins, xem README gốc).

Claude tự gọi skill khi việc liên quan Shopee; gọi tay: `/lichi:shopee-open-api`.

Cập nhật tài liệu Shopee: `python3 -I skills/shopee-open-api/scripts/fetch_shopee_docs.py /tmp/shopee-moi`, so `diff -r`, chép `reference/` mới vào, sửa 01–04 nếu cần, tăng `version` trong `.claude-plugin/plugin.json`.

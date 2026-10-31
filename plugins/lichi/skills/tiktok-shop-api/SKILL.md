---
name: tiktok-shop-api
description: Kiến thức TikTok Shop Open API (Partner Center) cho LICHI. Dùng khi viết code gọi TikTok Shop (Booking, script, bộ nạp BigQuery), chọn version API, thiết kế nạp dữ liệu TikTok, hay trả lời câu hỏi về API TikTok Shop - đơn, quyết toán/phí, hoàn/huỷ, analytics video/live/sản phẩm, affiliate/KOC, webhook, token, chữ ký, API sắp khai tử.
---

# TikTok Shop Open API cho LICHI

Trả lời Đức bằng tiếng Việt, giữ tên API và tên trường gốc tiếng Anh. Tài liệu tải và rà soát ngày 2026-10-31: 318 API + 26 trang tổng quan / 19 nhóm, 44 webhook, 229 changelog, 113 trang Developer Guide.

## 1. Tra cứu ở đâu

Mọi đường dẫn tính từ thư mục chứa file SKILL.md này. Chỉ đọc file cần, `reference/` khoảng 6,5 MB: **grep trước, đọc đoạn sau**.

| File | Đọc khi |
|---|---|
| `01-nen-tang-va-bai-hoc.md` | Trước khi viết code gọi TikTok: chữ ký, token, rate limit, webhook, bài học thị trường VN, **Booking đang gọi API nào, bản nào, cần nâng gì**, hạn khai tử sắp tới |
| `02-api-cho-warehouse.md` | Cần dữ liệu: đơn, tiền/phí, hoàn/huỷ, analytics, affiliate/KOC. Bản mới nhất + giới hạn |
| `03-nap-bigquery.md` | Thiết kế bảng `raw_tiktok` trên BigQuery, lịch nạp, khoá nối |
| `04-muc-luc-api.md` | Tìm API làm việc X: mỗi API 1 dòng (method, path, scope, có cần shop_cipher, link doc) |
| `reference/api/<nhóm>.md` | Nguyên văn doc từng API: query, body, response, mã lỗi. Tìm: `grep -n "## .*<tên hoặc path>" reference/api/orders.md` |
| `reference/catalog/api-catalog.json` | Dạng máy đọc: method, path, version, scope, danh sách trường response |
| `reference/webhooks/index.md`, `details.md` | 44 topic webhook (số = `type` trong payload) và payload |
| `reference/changelog/index.md`, `<năm>.md` | Thay đổi, khai tử, hạn chót. Tra theo tên API trước khi dùng |
| `reference/guides/index.md` | Developer Guide: ký request, OAuth, rate limit, lỗi chung, webhook, giải pháp theo nghiệp vụ |
| `reference/oas-gap.md` | Chênh lệch với spec OAS cũ của toolkit TikTok (`tts-openapi-guide`) |
| `scripts/` | Tải lại tài liệu khi TikTok thay đổi (mục 5) |

Cần trang chưa có hoặc nghi cũ: JSON công khai `https://partner.tiktokshop.com/api/v1/document/detail?document_id=<slug>&workspace_id=3&aid=359713&locale=en-US` (slug = phần cuối URL docv2, vd `get-order-detail-202507`), và `/api/v1/document/api_meta?src_document_id=<slug>&aid=359713&locale=en-US` (schema có cấu trúc, `scope_list`). Hai URL này chỉ trả dữ liệu khi gọi từ trong trang đã mở (cookie), nên dùng Playwright như `scripts/fetch-docs.js`; curl thẳng trả "internal error".

Code thật: repo Booking `artifacts/api-server/src/lib/tiktok-shop/` (`client.ts` → `callOpenApi`, `webhook.ts`, các `*-sync.ts`). Dùng lại client có sẵn, đừng viết ký request mới.

## 2. Điều bắt buộc nhớ

- **Chọn version cao nhất** trong `04-muc-luc-api.md` cho đúng năng lực cần. Chỉ dùng bản cũ khi có lý do ghi rõ (vd VN chưa roll-out), nêu nguồn. Partner Center chỉ hiện bản mới nhất; bản cũ còn chạy ít nhất 2 tháng sau khi có bản mới, khai tử được báo trước ≥2 tháng trong changelog. Lỗi `36009014` = version không hợp lệ/đã khai tử.
- **Thị trường**: nhiều API/trường chỉ cho US/EU/UK/JP. Đọc dòng "Markets"/"Target market" trong doc. LICHI bán ở **VN**. Ở VN: duyệt/từ chối hoàn dùng 202309; aftersales/RMA chưa roll-out; kháng nghị không có API.
- **Scope**: cột scope trong mục lục. Scope mới chỉ có hiệu lực sau khi shop **kết nối lại**; `105005` = thiếu quyền.
- **Chữ ký**: HMAC-SHA256(app_secret, `app_secret + path + query đã sắp xếp (bỏ sign, access_token) nối key+value + body + app_secret`), hex. Token ở header `x-tts-access-token`. Chỉ HTTPS.
- **Lỗi đi kèm HTTP 200**: xét `code` khác 0. `36009002`/HTTP 429 = quá tải: lùi + jitter.
- **Analytics**: ngày `YYYY-MM-DD` theo giờ shop, `end_date_lt` không bao gồm; từ 2026-11-06 Video List ≤30 ngày/request, Per Hour ≤7 ngày/request.
- **Webhook**: `Authorization` = hex HMAC-SHA256(app_secret, `app_key + raw_body`); trả 200 nhanh; TikTok dừng sau lần thử lại thứ 4; chống trùng bằng `tts_notification_id`; payload chỉ là tín hiệu, gọi API đọc lại và luôn có quét bù.
- Không đoán trường, enum, required. Tài liệu không ghi thì nói chưa xác minh và đề xuất gọi thử.

## 3. Khoá nối

`order_id` nối Order ↔ Price detail ↔ Finance transactions ↔ Returns/Cancellations ↔ Affiliate orders. `seller_sku` khớp mã A13 của Booking/Kho. Creator: `open_id`/`user_name` ↔ KOC Booking. `line_items[].room_id` ↔ `live_id`.

## 4. An toàn

- Gọi API **ghi** lên TikTok thật (duyệt/từ chối hoàn, huỷ đơn, sửa giá, tồn, khuyến mãi...) phải hỏi Đức trước, trừ khi qua tính năng có sẵn trên app.
- Không nạp hay ghi log dữ liệu cá nhân người mua, token, app_secret.
- Staging dump từ prod phải xoá token TikTok (tránh staging refresh làm chết token prod).

## 5. Cập nhật khi TikTok thay đổi

Cần Node 18+ có Playwright + Chromium, Python 3. Chạy từ thư mục skill:

```bash
node scripts/fetch-docs.js /tmp/tts-moi/raw                    # ~3 phút, chỉ đọc trang công khai
python3 -I scripts/build.py /tmp/tts-moi/raw/docs /tmp/tts-moi/raw/tree.json /tmp/tts-moi
diff -rq reference /tmp/tts-moi/reference; diff 04-muc-luc-api.md /tmp/tts-moi/04-muc-luc-api.md
head -40 /tmp/tts-moi/reference/changelog/index.md              # changelog mới nhất
```

Thấy thay đổi: chép `/tmp/tts-moi/reference` và `04-muc-luc-api.md` vào, sửa tay 01–03 nếu liên quan (bảng Booking, hạn khai tử, bản mới nhất), tăng `version` trong `.claude-plugin/plugin.json` của plugin `lichi`. Muốn so lại với spec OAS cũ: `python3 -I scripts/compare_oas.py <thư mục oas> reference/catalog/api-catalog.json > reference/oas-gap.md`.

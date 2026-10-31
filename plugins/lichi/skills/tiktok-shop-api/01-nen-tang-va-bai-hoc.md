# 01. Nền tảng gọi TikTok Shop API, bài học, và hiện trạng Booking

Rà ngày 2026-10-31 từ Partner Center (nguồn chi tiết trong `reference/guides/`) và code repo Booking.

## 1. Cách gọi

- Host: `https://open-api.tiktokglobalshop.com`. **Chỉ HTTPS** từ 2026-06-17 (http bị từ chối).
- Path có version: `/{nhóm}/{yyyymm}/{tài nguyên}`, ví dụ `/order/202507/orders`. Version = tháng phát hành của **riêng API đó**, các API khác nhau có version khác nhau.
- Query chung: `app_key`, `timestamp` (Unix giây), `sign`; API cấp shop thêm `shop_cipher` (lấy từ Get Authorized Shops). Cột `shop_cipher` trong `04-muc-luc-api.md` cho biết API nào cần.
- Header: `x-tts-access-token: <access_token>`, `content-type: application/json`.
- Chữ ký: HMAC-SHA256 với khoá = **app_secret**, chuỗi = `app_secret + path + (các query trừ sign, access_token, xếp theo tên, nối key+value) + body (nếu có, nguyên văn) + app_secret`, xuất hex. Chi tiết và code mẫu: `reference/guides/tiktok-shop-api-concepts.md`, mục "Sign your API request".
- Token: `auth_code` sống 30 phút, dùng 1 lần. `access_token` mặc định 7 ngày. `refresh_token` sống bằng thời hạn uỷ quyền shop. Webhook 7 báo trước 30 ngày khi uỷ quyền sắp hết.
- Lỗi trả trong body (`code` khác 0) kể cả khi HTTP 200. Hay gặp: `36009002` hoặc HTTP 429 = bị giới hạn tốc độ (lùi + jitter rồi thử lại), `36009014` = version không hợp lệ hoặc đã khai tử, `105005` = thiếu scope (bật scope ở Partner Center rồi **kết nối lại shop**; refresh token không cấp scope mới).
- Rate limit động theo cặp app × shop, không có con số cố định. Gợi ý khởi điểm của TikTok: API đọc/đồng bộ 3–10 req/s, analytics nặng 0,2–1 req/s.
- Vòng đời version: bản mới ra thì bản cũ còn ít nhất 2 tháng; khai tử được báo trong changelog ít nhất 2 tháng trước. Partner Center chỉ hiện bản mới nhất, bản cũ xem qua menu version trên trang doc.
- Sandbox/test shop: giới hạn 1000 request/giờ; shop ở trạng thái inactive bị chặn gọi API.

## 2. Webhook

- Danh sách 44 topic: `reference/webhooks/index.md`; payload từng topic: `reference/webhooks/details.md`.
- Xác thực: header `Authorization` = hex HMAC-SHA256(app_secret, `app_key + raw_body`). Tính trên body thô trước khi parse.
- Trả HTTP 200 nhanh. TikTok thử lại khi lỗi và **dừng sau lần thử thứ 4**. Có thể trùng, chậm, sai thứ tự: chống trùng bằng `tts_notification_id`, payload chỉ dùng làm tín hiệu rồi gọi API đọc lại, luôn có lượt quét bù định kỳ.
- Từ 2026-08-30 TikTok thêm dải IP gửi webhook mới cho vùng SG/EU. Nếu tường lửa lọc IP nguồn thì phải thêm, nếu không sẽ mất event mà không báo lỗi.

## 3. Bài học riêng thị trường VN (từ code và docs repo Booking)

- Duyệt/từ chối hoàn ở VN dùng **Approve/Reject Return 202309**. Review Aftersales (202603/202609), Search Aftersales (202603), Search RMA (202604) **chưa roll-out VN** (probe 2026-08-21 trả rỗng hoặc "invalid value"). Webhook 65 (RMA) chưa từng bắn ở VN.
- Kháng nghị (arbitration) **không có API**: chỉ đọc được `arbitration_status` trong Search Returns, thao tác phải bấm trên Seller Center.
- Widget quản lý hoàn cần scope ghi mà app bên thứ ba ở VN không được cấp (lỗi 105005).
- Analytics: `start_date_ge`/`end_date_lt` dạng `YYYY-MM-DD`, `_lt` **không bao gồm** ngày cuối, ngày tính theo **múi giờ shop** (VN), khác DB app lưu UTC.
- Tài chính VN dùng bản Transactions **202501** (bản 202309 đã khai tử 2025-12-31).
- Không có API đọc đánh giá sản phẩm của khách. Không có chi phí quảng cáo (GMV Max, Live ads): cần TikTok for Business Marketing API riêng; chỉ thấy gián tiếp qua phí trong finance (vd `gmv_max_coupon_fee`).
- Thông tin cá nhân người mua bị che tuỳ loại app (từ 2026-10-12). Warehouse không cần và không nên lưu.
- Skill `tts-openapi-guide` mà toolkit chính thức của TikTok cài (`@tts-open-toolkit/cli` 0.1.7, cũng là bản trong `Booking/.agents/skills/`) **đã cũ**: thiếu 74 API và 35 bản mới, kể cả Search Returns/Cancellations 202602 mà Booking đang gọi. Xem `reference/oas-gap.md`. Dùng skill này thay cho nó.

## 4. Repo Booking đang gọi gì (2026-10-31)

Hàm gọi chung: `artifacts/api-server/src/lib/tiktok-shop/client.ts` → `callOpenApi({ path, method, query, body, withShopCipher, shopId? })` (ký, chèn shop_cipher, tự refresh token, backoff 36009002). Webhook: `POST /api/tiktok-shop/webhook`, chống trùng qua bảng `tiktok_webhook_events`.

| Endpoint Booking gọi | File | Bản mới nhất trên Partner Center | Việc cần làm |
|---|---|---|---|
| `GET /authorization/202309/shops` | client.ts | 202309 | ổn |
| `POST /return_refund/202602/returns/search` | returns-sync.ts | 202602 | ổn; có trường mới `is_quick_refund`, `return_sub_line_items` |
| `POST /return_refund/202602/cancellations/search` | cancellations-sync.ts | 202602 | ổn |
| `POST /return_refund/202309/returns/{id}/approve` | returns-decide.ts | 202309 | ổn |
| `POST /return_refund/202309/returns/{id}/reject` | returns-decide.ts | **202606** | cố ý giữ 202309 (2026-10-31): API ghi, không thử an toàn được; 202606 thêm hoàn một phần sau nhận hàng + `idempotency_key`, app chưa cần. Nâng khi có lịch khai tử |
| `GET /return_refund/202309/returns/{id}/records` | return-parcels-detail.ts, parcel-tracking.ts | 202309 | ổn |
| `GET /return_refund/202309/reject_reasons` | tiktok-shop.ts | 202309 | ổn |
| `GET /return_refund/202601/decision_eligibility` | tiktok-shop.ts | 202601 | ổn; có API mới Get Available Review Decisions 202606 (gom theo RMA, chủ yếu US/EMEA) |
| `POST /return_refund/202603/aftersales/search`, `POST /return_refund/202604/rma/search` | returns-sync.ts | 202603 / 202604 | chưa roll-out VN, giữ dạng thăm dò |
| `POST /return_refund/202603/aftersales/review` | tiktok-shop.ts (probe) | **202609** | VN không dùng |
| `GET /order/202507/orders` | cancellations-sync.ts | 202507 | ổn; trường mới `room_id`, `buyer_nickname`, `is_exchange_order`, `is_replacement_order`... |
| `GET /fulfillment/202309/orders/{id}/tracking` | parcel-tracking.ts | 202309 | ổn; có thêm `GET /logistics/202604/orders/{id}/tracking` |
| `GET /product/202309/categories`, `/product/202309/brands`, `GET /product/202309/products/{id}` | category-names.ts, brands-sync.ts, product-listing-enrich.ts | 202309 | ổn |
| `POST /product/202502/products/search` | product-catalog-sync.ts | 202502 | ổn |
| `GET /analytics/202605/shop_videos/performance` | gmv-sync.ts | 202605 | ổn. Từ **2026-11-06** mỗi request tối đa 30 ngày (Booking gọi 1 ngày/lần nên không ảnh hưởng). Bản 202409/202509 khai tử 2026-12-28 |
| `GET /analytics/202609/shop_lives/performance` | live-gmv-sync.ts | 202609 | đã nâng (Booking PR #689). Response là `data.live_stream_sessions[]`, host `creator.user_name`, GMV trực tiếp `sales_performance.live_gmv` |
| `GET /analytics/202510/shop_lives/{id}/performance_per_minutes` | live-gmv-sync.ts | 202510 | ổn |
| `GET /analytics/202511/creators/bestselling` | kocs.ts | 202511 | ổn |
| `POST /affiliate_seller/202508/marketplace_creators/search` | creator-sync.ts | 202608 | cố ý giữ 202508 (2026-10-31): TikTok vẫn bổ sung trường cho 202508 (`creator_level`, `data_groups`), chưa có lịch khai tử |
| `GET /affiliate_seller/202508/marketplace_creators/{id}` | kocs.ts | 202608 | như trên; 202608 thêm `creator_profile` (chỉ số 30/90 ngày) |
| `POST /affiliate_seller/202601/marketplace_creators/search/filter` | kocs.ts | 202608 | giữ 202601 cùng cặp với search 202508. 202608 đổi hẳn cấu trúc (`option_list` có id, `sorters`), nâng phải làm lại màn lọc KOC |

Webhook Booking đã nối: 1, 7, 11, 12, 64, 65, 67 (xem `docs/TIKTOK_SHOP_WEBHOOK_TOPICS.md` trong Booking).

## 5. Hạn chót sắp tới (từ changelog)

| Ngày | Thay đổi | Ảnh hưởng LICHI |
|---|---|---|
| 2026-10-31 | Cancel Order: bỏ 2 lý do huỷ lỗi người mua (US/UK/EU/JP) | không (VN, Booking không huỷ đơn qua API) |
| 2026-11-06 | Shop Performance Per Hour tối đa 7 ngày/request; Shop Video Performance List tối đa 30 ngày/request | bộ nạp warehouse phải chia cửa sổ |
| 2026-12-28 | Khai tử Get Shop Video Performance Details (`/shop_videos/{video_id}/performance`) → dùng `GET /analytics/202609/shop_videos/batch_performance`; khai tử Shop Video List 202409/202509 | Booking đã dùng 202605; không dùng Details |
| đã qua 2026-10-12 | Khai tử loạt bản cũ affiliate_seller (202405/202406/202409/202412/202505) và API affiliate 2022 | Booking đã ở 202508, không gãy |
| đã qua 2026-08-15 | Get Payments 202309 → 202605 (bỏ `reserve_amount`) | warehouse dùng 202605 |
| đã qua 2026-04 | Analytics 202406/202409 offline | spec OAS cũ vẫn liệt kê, đừng dùng |

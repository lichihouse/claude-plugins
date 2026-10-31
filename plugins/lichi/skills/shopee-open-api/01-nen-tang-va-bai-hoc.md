# 01. Nền tảng gọi Shopee Open API v2 + bài học từ repo Booking

Đọc file này trước khi viết bất kỳ code nào gọi Shopee (Booking, bộ nạp BigQuery, script một lần).
Nguồn: Developer Guide (`reference/guides/0016-api-calls.md`, `0020-authorization-and-authentication.md`, `0014-app-management.md`, `0018-push-mechanism-notifications.md`, `0031-v2-0-data-definition.md`) và code `Booking/artifacts/api-server/src/lib/shopee/` (kiểm ngày 2026-10-31).

## 1. Loại app quyết định gọi được module nào (quan trọng nhất)

Mỗi API ghi rõ loại app được phép gọi (cột "app được gọi" trong `reference/api/*.md`). Đếm từ 461 trang:

| Nhóm dữ liệu | Module | App gọi được |
|---|---|---|
| Đơn, tiền thực nhận, hoàn, sản phẩm, vận chuyển, khuyến mãi, sức khoẻ shop | Order, Payment, Returns, Product, Logistics, Discount, Voucher, AccountHealth... | **Seller In House System** (gọi được tất cả, kể cả Chat), ERP System (trừ Chat và Ads), hoặc app chuyên (Order Management, Accounting And Finance...) |
| Quảng cáo Shopee Ads | Ads | Ads Service, **Seller In House System**, Marketing (24/25 API) |
| Affiliate / KOC | AMS (36 API) | **chỉ** Affiliate Marketing Solution Management |
| Shopee Video | Video (15 API) | **chỉ** Shopee Video Management |
| Shopee Live | Livestream (25 API) | **chỉ** Livestream Management |
| Brand Portal (gộp nhiều shop theo thương hiệu) | BrandPortal (11 API, path `/api/v2/principal/...`) | **chỉ** Brand Portal Service, uỷ quyền kiểu `auth_type=principal` |

Hệ quả: app hiện tại của Booking (loại app chưa kiểm trên Console, giả định là Seller In House System) **không** gọi được AMS, Video, Livestream, BrandPortal. Muốn có dữ liệu affiliate/KOC, video, live phải tạo thêm app đúng loại trên Console và shop uỷ quyền lại cho app đó (mỗi app có partner_id, partner_key, token riêng).

## 2. Host, chữ ký, token

- Host live: `https://partner.shopeemobile.com`. Sandbox: `https://openplatform.sandbox.test-stable.shopee.sg`. Trang uỷ quyền live `https://open.shopee.com/auth`, sandbox `https://open.sandbox.test-stable.shopee.com/auth`.
- Tham số chung trên query: Shop API `partner_id, timestamp, sign, access_token, shop_id`; Merchant API thay `shop_id` bằng `merchant_id`; Public API chỉ `partner_id, timestamp, sign`.
- `sign` = HMAC-SHA256 (khoá = partner_key nguyên chuỗi, không giải hex), xuất hex thường, trên chuỗi nối liền:
  - Shop API: `partner_id + path + timestamp + access_token + shop_id`
  - Merchant API: `partner_id + path + timestamp + access_token + merchant_id`
  - Public API: `partner_id + path + timestamp`
  - `path` không có host, ví dụ `/api/v2/shop/get_shop_info`. `timestamp` là giây Unix, chỉ sống 5 phút.
- Token:
  - `code` sau khi shop uỷ quyền: dùng 1 lần, sống 10 phút → `v2.public.get_access_token` (`/api/v2/auth/token/get`).
  - `access_token`: sống 4 giờ (`expire_in` = 14400 giây), dùng nhiều lần. Token cũ còn sống thêm 5 phút sau khi có token mới.
  - `refresh_token`: sống 30 ngày, **dùng 1 lần**; mỗi lần refresh (`/api/v2/auth/access_token/get`) nhận refresh_token mới, phải lưu ngay.
  - Uỷ quyền shop: tối đa 365 ngày (người bán chọn 7/30/90/180/365 ngày hoặc tự đặt). Push `open_api_authorization_expiry` (code 12) báo trước 7 ngày.
  - Partner Key hết hạn 180 ngày (ghi chú trong Booking `shopee_config.partner_key_expires_on`, Shopee không có API trả hạn).
- Thành công xét theo trường `error` rỗng, **không** theo HTTP status: Shopee trả lỗi kèm HTTP 200.

## 3. Định dạng ngày giờ, tiền: mỗi module một kiểu (phải chuẩn hoá khi nạp)

| Module/API | Định dạng thời gian | Tiền |
|---|---|---|
| Order, Returns, Payment escrow, Product | Unix giây (`create_time`, `update_time`, `escrow_release_time`) | float (VND) |
| `payment.get_income_detail` | `date_from/date_to` = `YYYY-MM-DD`; kết quả Unix giây | float |
| AMS hiệu quả (`get_*_performance`) | `start_date/end_date` = `YYYYMMDD` (mẫu `20250801`) | **chuỗi** (`sales`, `est_commission`) |
| AMS `get_conversion_report` | lọc bằng Unix giây; kết quả là **chuỗi** `"2025/8/10 15:36:22"` (múi giờ tài liệu không ghi, giả định giờ VN, phải kiểm khi gọi thật) | chuỗi, `price`/`purchase_value` là int64 "cents (or smallest currency unit)" (với VND cần kiểm có nhân 100 không) |
| Ads (`get_*_daily_performance`, GMS) | `DD-MM-YYYY` (mẫu `17-03-2021`, `11-11-2025`) | float |
| Video `get_*_performance_list` | `end_date` = `YYYY-MM-DD` + `period_type` | float |
| BrandPortal | `YYYY-MM-DD` + `timezone` (`GMT+7`) | float, chọn `LOCAL` hoặc `USD` |

## 4. Giới hạn khoảng thời gian, lịch sử, phân trang (đã đối chiếu từng trang)

| API | Khoảng tối đa mỗi lần gọi | Lùi xa nhất | Phân trang |
|---|---|---|---|
| `order.get_order_list` | 15 ngày (`time_range_field` = `create_time` hoặc `update_time`) | tài liệu không ghi | `cursor` + `page_size` 1–100, `more`/`next_cursor` |
| `order.get_order_detail` | – | – | tối đa 50 `order_sn` mỗi lần; trường như `item_list`, `package_list`, `cancel_reason` chỉ trả khi xin qua `response_optional_fields` |
| `returns.get_return_list` | 15 ngày (create_time hoặc update_time) | không ghi | `page_no` + `page_size` (≤100), `more` |
| `payment.get_escrow_list` | tài liệu không ghi (cần chia cửa sổ ngắn) | không ghi | `page_no`, `page_size` ≤100 |
| `payment.get_escrow_detail_batch` | – | – | 1–50 `order_sn` (khuyên 1–20) |
| `payment.get_income_detail` | 14 ngày (chỉ áp cho trạng thái Released) | 5 năm (ghi cho TW) | `cursor` |
| `payment.get_wallet_transaction_list` | 15 ngày | không ghi | `page_no`, `page_size` |
| AMS `get_shop/product/affiliate/content_performance`, campaign | theo `period_type` Day/Week/Month/Last7d/Last30d | **3 tháng dương lịch** gần nhất; mốc dữ liệu mới nhất lấy bằng `get_performance_data_update_time` (`AmsMarker`) | `page_no`, `page_size`, `has_more` |
| AMS `get_conversion_report` | 3 tháng | không ghi | `page_size` ≤500 và `page_no × page_size` ≤ 10.000 (tối đa 10.000 dòng mỗi bộ lọc: chia cửa sổ nhỏ) |
| AMS `get_validation_report` | theo tháng hoá đơn | – | như conversion report |
| Ads `get_all_cpc_ads_daily_performance`, `get_product_campaign_daily_performance`, GMS | 1 tháng; `start_date` ≠ `end_date` (một ngày thì dùng API theo giờ) | **6 tháng** | campaign: tối đa 100 `campaign_id` mỗi lần; GMS item `limit` ≤100 |
| Video `get_*_performance_list` | Day/Week/Month/Last7d/Last15d/Last30d | trễ ít nhất 1 ngày | `page_size` ≤20 |
| Livestream `get_session_metric` | theo `session_id`, số liệu realtime | – | item metric: `offset`, `page_size` |

Rate limit: 287/461 trang không ghi, các trang còn lại ghi `[0, 0, 0]` (tức không công bố). Booking xử lý `error_rate_limit`/`error_limit` như lỗi tạm, thử lại lượt sau. Shopee theo dõi **tỉ lệ gọi thành công** của app (Booking ghi giữ trên 90%): không gọi lặp cho shop đã chết token.

## 5. Push (webhook)

- 35 loại push, chi tiết ở `reference/push.md`. Liên quan dữ liệu: `order_status_push` (code 3), `order_trackingno_push` (4), `return_updates_push` (29), `shop_authorization_push` (1), `shop_authorization_canceled_push` (2), `open_api_authorization_expiry` (12), `item_price_update_push` (22), `reserved_stock_change_push` (8).
- Push chỉ báo "có thay đổi", phải gọi API đọc lại. Có thể trùng, sai thứ tự, không bảo đảm tới (retry sau 300, 1800, 10800 giây). Nên luôn có lượt quét bù định kỳ.
- Trả HTTP 2xx với **body rỗng** trong thời gian timeout (thường 3 giây), không thì tính là lỗi; tỉ lệ lỗi cao bị gửi email cảnh báo rồi tắt push.
- Xác thực: header `Authorization` = HMAC-SHA256(Push Partner Key, `URL + "|" + body`). Push Partner Key là khoá riêng trên Console (Push Mechanism → Set Push), khác Partner Key gọi API.
- `v2.push.get_lost_push_message`: lấy lại push bị mất trong 3 ngày.

## 6. Bài học thực tế từ Booking (`artifacts/api-server/src/lib/shopee/`)

Booking đang gọi 13 API: `auth/token/get`, `auth/access_token/get`, `shop/get_shop_info`, `order/get_order_list`, `order/get_order_detail`, `logistics/get_tracking_number`, `logistics/get_tracking_info`, `returns/get_return_list`, `get_return_detail`, `get_reverse_tracking_info`, `get_available_solutions`, `get_return_dispute_reason`, `returns/confirm` (ghi, sau công tắc `shopee_write_enabled`).

1. **refresh_token dùng 1 lần**: mọi lần refresh đi qua khoá theo shop (`tokens.ts`), đọc lại dòng sau khi khoá. Hai tiến trình (VD Booking và bộ nạp BigQuery) **không được** cùng refresh một shop của cùng app; bộ nạp phải xin token qua Booking hoặc dùng app riêng.
2. Staging dump từ prod phải xoá token (`DELETE FROM shopee_connections`, `enabled=false`), nếu không staging xoay token làm chết token prod (AGENTS.md Booking §212).
3. Lượt kéo theo mốc (watermark) + cửa sổ ≤14 ngày (chừa 1 ngày cho làm tròn), đọc lùi 1 giờ trước mốc để bắt đơn cập nhật trễ và lệch đồng hồ (`windows.ts`). Lượt đầu lùi 30 ngày.
4. `get_return_list`: tài liệu ghi `page_no` "Default is 0" nhưng mẫu dùng 1; Shopee coi 0 như 1 nên trang 0 và 1 trùng nhau. Bỏ trang trùng, dừng khi trang lặp hoặc trang rỗng mà vẫn báo còn (`paging.ts`).
5. Mẫu tài liệu `get_return_list` có `"error": "-"` kèm `response`: chỉ coi là thành công khi có `response`.
6. `expire_in` ở refresh là số giây, nhưng mẫu tài liệu `token/get` in giá trị như epoch: đừng tin mẫu.
7. Token để kiểu text, không giới hạn độ dài (Shopee đã đổi độ dài token).
8. Lỗi `error_data` phần lớn là "Please try later": xếp lỗi tạm, giữ mốc, lượt sau thử lại. Lỗi theo từng đơn thì không giữ mốc mãi.
9. Không log nguyên URL đã ký hay lỗi Drizzle chứa params (lộ token, partner key).
10. Một shop lỗi không được chặn shop khác: refresh_token shop khác vẫn phải xoay trước hạn 30 ngày.

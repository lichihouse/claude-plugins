# 03. Nạp dữ liệu TikTok Shop vào BigQuery: đề xuất thiết kế

Đề xuất, chưa chốt. Theo kiến trúc đã chốt 2026-10-30: BigQuery Singapore, dataset `raw_*` → staging → core → marts (dbt). Đây là phần `raw_tiktok`, cùng nguyên tắc với `raw_shopee` (skill `shopee-open-api`, file 03).

## 1. Nguyên tắc

1. **Lưu nguyên JSON** (`payload JSON`) + vài cột khoá đã tách. TikTok thêm trường gần như mỗi tháng (finance thêm phí 2026-07, 09, 10; order thêm `room_id` 2026-10): giữ JSON để không mất trường mới.
2. **Chỉ append**, mỗi dòng có `_loaded_at`, `_window_from`, `_window_to`, `_api_version` (vd `202602`). Bản mới nhất chọn ở staging bằng `QUALIFY ROW_NUMBER() OVER (PARTITION BY khoá ORDER BY _loaded_at DESC) = 1`.
3. Partition theo ngày nghiệp vụ, cluster theo `shop_id` + khoá chính.
4. Staging: thời gian Unix giây → `TIMESTAMP` UTC + cột `DATE` giờ VN. Tiền TikTok trả **chuỗi** (`"123000"`) kèm `currency` → `NUMERIC` VND làm tròn số nguyên. Ngày analytics đã là ngày giờ shop, giữ nguyên `DATE`.
5. Không nạp dữ liệu cá nhân người mua: bỏ `recipient_address`, `buyer_email`, số điện thoại, `cpf`; `user_id` băm nếu cần đếm khách quay lại.
6. Token: bộ nạp **không tự refresh** token của app Booking (Booking giữ và refresh trong `tiktok_shop_connections`). Cách đơn giản: Booking có endpoint nội bộ cấp access_token còn hạn cho bộ nạp, hoặc bộ nạp đọc token đã refresh từ DB Booking. Dùng chung app nên **chung quota** theo cặp app × shop: bộ nạp chạy chậm (≤1–3 req/s), lùi khi gặp `36009002`.
7. Ghi version API vào code bộ nạp ở một chỗ. Khi changelog báo khai tử, chỉ sửa một chỗ.

## 2. Bảng raw đề xuất

| Bảng `raw_tiktok.*` | Nguồn | Khoá | Partition | Lịch | Lùi lại mỗi lần |
|---|---|---|---|---|---|
| `orders` | Get Order List 202309 (`update_time`) → Get Order Detail 202507 (≤50 id) | `order_id` | ngày `create_time` | mỗi giờ | 1 giờ chồng mốc |
| `order_price_details` | Get Order Price Details 202407 | `order_id` | ngày `create_time` đơn | theo đơn mới/đổi | – |
| `statements` | Get Statements 202309 (`statement_time`) | `statement_id` | ngày `statement_time` | hằng ngày | 7 ngày |
| `statement_transactions` | Transactions by Statement 202501 | (`statement_id`, `id` giao dịch) | ngày `statement_time` | hằng ngày, cho statement mới | – |
| `unsettled_transactions` | Get Unsettled Transactions 202507 | (`order_id`, ngày chụp) | ngày chụp | hằng ngày (ảnh chụp) | – |
| `payments`, `withdrawals` | Get Payments 202605, Get Withdrawals 202309 | `id` | ngày `create_time` | hằng ngày | 7 ngày |
| `returns` | Search Returns 202602 (`update_time`) | `return_id` | ngày `create_time` | mỗi giờ (hoặc đọc từ DB Booking) | 1 giờ |
| `cancellations` | Search Cancellations 202602 (`update_time`) | `cancel_id` | ngày `create_time` | mỗi giờ (hoặc từ Booking) | 1 giờ |
| `affiliate_orders` | Search Seller Affiliate Orders 202410 (`create_time`, ≤3 tháng/request) | (`order_id`, `sku_id`) | ngày `create_time` | hằng ngày | **60–90 ngày** (hoa hồng, quyết toán, hoàn còn đổi; API không lọc theo update_time) |
| `shop_daily` | Get Shop Performance 202609, `granularity=1D` | (`shop_id`, `date`) | `date` | hằng ngày | 3 ngày (số analytics còn chỉnh) |
| `shop_hourly` | Shop Performance Per Hour 202510 | (`shop_id`, `date`, giờ) | `date` | hằng ngày | ≤7 ngày/request |
| `product_daily` | Shop Product Performance List 202605, mỗi request 1 ngày | (`product_id`, `date`) | `date` | hằng ngày | 3 ngày |
| `sku_daily` | Shop SKU Performance List 202509, 1 ngày/request | (`sku_id`, `date`) | `date` | hằng ngày | 3 ngày |
| `video_daily` | Shop Video Performance List 202605, 1 ngày/request, `account_type=ALL` | (`video_id`, `date`) | `date` | hằng ngày (Booking đã chạy cho video KOC, có thể đọc từ Booking) | 3 ngày |
| `video_product_daily` | Video Product Performance 202509 cho video có GMV | (`video_id`, `product_id`, `date`) | `date` | hằng ngày | 3 ngày |
| `live_sessions` | Shop LIVE Performance List 202609 | `live_id` | ngày phiên | hằng ngày | 3 ngày |
| `live_product_performance` | Shop LIVE Products Performance 202512 | (`live_id`, `product_id`) | ngày phiên | sau phiên | – |
| `creators` | Get Marketplace Creator Performance 202608 cho creator mới thấy trong `affiliate_orders`/`video_daily` | `creator_user_id` / `open_id` | ngày chụp | hằng tuần | – |
| `products`, `skus` | Search Products 202502 (`update_time`) → Get Product 202309 | `product_id` / `sku_id` | ngày chụp | hằng ngày | – |
| `promotions` | Search Promotion Activities 202309 + Get Activity | `activity_id` | ngày chụp | hằng ngày | – |
| `webhook_events` | Đẩy từ Booking (bảng `tiktok_webhook_events`) | `tts_notification_id` | ngày nhận | liên tục / hằng giờ | – |

Backfill lịch sử dài: thử Affiliate Compass Offline Export (`/affiliate_seller/202603/compass/offline_task`) cho dữ liệu affiliate, và gọi analytics từng ngày lùi dần cho đến khi API trả rỗng hoặc lỗi để biết độ sâu thật.

## 3. Khoá nối

- `order_id`: Order ↔ Price detail ↔ Statement transactions ↔ Returns/Cancellations ↔ Affiliate orders. Salework giữ mã đơn sàn (kiểm tên cột khi nối).
- `product_id` / `sku_id` (TikTok) ↔ `seller_sku` (mã người bán) ↔ mã A13 của Booking/Kho. Mã SP giống nhau giữa Booking/Kho/sàn.
- Creator: `open_id` / `creator_user_id` / `user_name` (@handle) ↔ KOC trong Booking (Booking đang khớp qua `user_name`/`nick_name`).
- `line_items[].room_id` (đơn) ↔ `live_id` (analytics live): GMV live theo đơn thật.
- `activity_id` (price detail) ↔ `activity_id` (promotion).
- `video_id` ↔ booking video trong Booking (`video_performance`).

## 4. Chỉ số gợi ý (marts)

- Lợi nhuận thật theo đơn/mẫu = tiền quyết toán (`statement_transactions.settlement_amount`) − giá vốn (Kho) − hoàn − phí ads gián tiếp (`gmv_max_coupon_fee`, phí Shop Ads) − hoa hồng affiliate thực trả.
- Hiệu quả KOC = GMV và hoa hồng thực trả từ `affiliate_orders`, view/GMV từ `video_daily`, so với chi phí booking.
- Tỉ trọng GMV theo kênh (video, live, thẻ sản phẩm, affiliate) từ `shop_daily`/`product_daily`.
- Tỉ lệ hoàn/huỷ theo mẫu, theo KOC (nối `affiliate_orders` với `returns`).

## 5. Cần làm trước khi nạp

1. Kiểm scope đã cấp cho app Booking (`grantedScopes` trong `tiktok_shop_connections`): cần thêm `seller.order.info`, `seller.finance.info`, `seller.affiliate_collaboration.read`, `seller.product.basic`, `seller.promotion.info` nếu thiếu → bật ở Partner Center → **kết nối lại** shop.
2. Thống nhất cách bộ nạp lấy token từ Booking (mục 1.6).
3. Chạy thử từng API một ngày dữ liệu, lưu mẫu JSON để viết staging dbt.

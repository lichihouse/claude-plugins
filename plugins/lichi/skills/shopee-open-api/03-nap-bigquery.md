# 03. Nạp dữ liệu Shopee vào BigQuery: đề xuất thiết kế

Đề xuất, chưa chốt. Theo kiến trúc đã chốt 2026-10-30: BigQuery Singapore, dataset `raw_*` → staging → core → marts (dbt). Đây là phần `raw_shopee`.

## 1. Nguyên tắc
1. **Lưu nguyên JSON trả về** (cột `payload JSON`) + vài cột khoá đã tách. Shopee thêm trường liên tục (escrow thêm `pay_per_sale` 2026-09-30, AMS thêm phí dịch vụ 2026-07-02): giữ JSON thì không mất trường mới, dbt tách sau.
2. **Chỉ append**, mỗi dòng có `_loaded_at` và `_window_from/_window_to`. Bản mới nhất chọn ở staging bằng `QUALIFY ROW_NUMBER() OVER (PARTITION BY khoá ORDER BY _loaded_at DESC) = 1`. Không UPDATE/DELETE trong raw.
3. Partition theo ngày nghiệp vụ (ngày đặt đơn, ngày số liệu), cluster theo `shop_id` + khoá chính.
4. Chuẩn hoá ở staging: mọi thời gian về `TIMESTAMP` UTC + cột `DATE` giờ VN; mọi tiền về `NUMERIC` VND làm tròn số nguyên (AMS trả chuỗi, Ads trả float).
5. Không nạp dữ liệu nhạy cảm của khách: bỏ `recipient_address`, số điện thoại, email; `buyer_user_id` băm nếu cần đếm khách quay lại.
6. Token: bộ nạp **không tự refresh** token của app mà Booking đang giữ (refresh_token dùng 1 lần, hai bên cùng refresh sẽ làm chết token). Hai cách: (a) Booking có endpoint nội bộ cấp access_token cho bộ nạp; (b) app riêng cho warehouse. AMS/Video/Live bắt buộc app riêng nên phải có chỗ lưu token cho app mới (đề xuất: Booking quản lý luôn, cùng cơ chế khoá `tokens.ts`).

## 2. Bảng raw đề xuất

| Bảng `raw_shopee.*` | Nguồn | Khoá | Partition | Lịch nạp | Lùi lại mỗi lần |
|---|---|---|---|---|---|
| `orders` | `order.get_order_list` (update_time) → `get_order_detail` | `order_sn` | ngày `create_time` | mỗi giờ | 1 giờ chồng mốc |
| `escrow_details` | `payment.get_escrow_list` → `get_escrow_detail_batch` | `order_sn` | ngày `escrow_release_time` | hằng ngày | 3 ngày |
| `wallet_transactions` | `payment.get_wallet_transaction_list` | (`create_time`, `transaction_type`, `order_sn`, `refund_sn`, `amount`): API không có mã giao dịch riêng | ngày `create_time` | hằng ngày | 2 ngày |
| `returns` | `returns.get_return_list` (update_time) | `return_sn` | ngày `create_time` | mỗi giờ (Booking đã kéo, có thể đọc từ Booking thay vì gọi lại) | 1 giờ |
| `ads_shop_daily` | `ads.get_all_cpc_ads_daily_performance` | (`shop_id`, `date`) | `date` | hằng ngày | **7 ngày** (cửa sổ quy đổi 7 ngày) |
| `ads_campaign_daily` | `ads.get_product_level_campaign_id_list` → `get_product_campaign_daily_performance` | (`campaign_id`, `date`) | `date` | hằng ngày | 7 ngày |
| `ads_campaign_settings` | `get_product_level_campaign_setting_info` | `campaign_id` | ngày chụp | hằng ngày (ảnh chụp) | – |
| `ads_gms_item_daily` | `ads.get_gms_item_performance` (trả tổng cả khoảng, xem ghi chú) | (`campaign_id`, `item_id`, `date`) | `date` | hằng ngày | 7 ngày |
| `ads_balance` | `ads.get_total_balance` | (`shop_id`, `data_timestamp`) | ngày | mỗi giờ | – |
| `ams_conversions` | `ams.get_conversion_report` theo `place_order_time` | (`order_sn`, `item_id`, `model_id`, `affiliate_id`) | ngày đặt | hằng ngày | **30 ngày** (trạng thái, xác minh, hoàn tiền còn đổi) |
| `ams_validation_bills` + `ams_validation_orders` | `get_validation_list` + `get_validation_report` | `validation_id` / (+`order_sn`, `item_id`) | tháng | hằng tháng | tháng trước |
| `ams_affiliate_daily`, `ams_product_daily`, `ams_content_daily` | `get_affiliate/product/content_performance`, `period_type=Day`, `order_type` cả Placed và Confirmed | (ngày, id, order_type, channel) | ngày | hằng ngày | 7 ngày; **bắt đầu sớm vì Shopee chỉ giữ 3 tháng** |
| `ams_affiliates` | `query_affiliate_list` cho mọi `affiliate_id` mới thấy | `affiliate_id` | ngày chụp | hằng tuần | – |
| `video_daily`, `video_product_daily` | `video.get_video_performance_list`, `get_video_detail_product_performance` | (`post_id`, ngày), (+`item_id`) | ngày | hằng ngày | 2 ngày (trễ ≥1 ngày) |
| `live_sessions` | `livestream.get_session_metric` + `get_session_item_metric` | `session_id` | ngày phiên | sau mỗi phiên | – |
| `products`, `models` | `product.get_item_list` (update_time) → `get_item_base_info` → `get_model_list` | `item_id` / `model_id` | ngày chụp | hằng ngày | – |

Ghi chú: các API Ads theo ngày không cho `start_date = end_date`. Cách đơn giản: gọi khoảng 7–30 ngày, mỗi phần tử mảng đã có `date`; GMS trả **tổng** cả khoảng nên muốn theo ngày phải gọi từng cặp 2 ngày rồi trừ, hoặc chấp nhận nạp tổng tuần. Cần thử khi có app thật.

## 3. Khoá nối giữa các nguồn
- `order_sn`: Order ↔ Escrow ↔ AMS conversion ↔ Returns ↔ Wallet. Salework cũng giữ mã đơn sàn (kiểm tên cột khi nối).
- `item_id` / `model_id` (Shopee) ↔ `model_sku` / `item_sku` (mã người bán) ↔ mã A13 trong Booking/Kho: `dim_product` khớp qua SKU.
- `affiliate_id` / `affiliate_username` (AMS) ↔ tài khoản Shopee của KOC trong Booking (`kocs` có nền tảng shopee): cần thêm cột lưu `affiliate_id` hoặc khớp theo username.
- `campaign_id` (Ads) ≠ `attr_campaign_id` (AMS): hai hệ khác nhau.

## 4. Chỉ số gợi ý (marts)
- Lợi nhuận thật theo đơn/mẫu = `escrow_amount` − giá vốn (Kho) − phí ads phân bổ − hàng hoàn.
- Hiệu quả KOC = sales, orders (Confirmed), hoa hồng thực trả (validation) / KOC / sản phẩm / tuần; so với chi phí booking trong Booking.
- ROAS ads trực tiếp và broad theo sản phẩm; tỉ trọng phí ads trong escrow (`pay_per_sale`).
- Tỉ lệ hoàn theo mẫu và lý do (Returns), nối với đơn affiliate để xem KOC nào kéo đơn hay hoàn.

## 5. Việc cần Đức làm trước khi nạp được
1. Kiểm loại app đang dùng cho Booking trên Shopee Open Platform Console (giả định: Seller In House System). Nếu đúng, Order/Payment/Returns/Ads/Product nạp được ngay với app đó.
2. Tạo thêm app loại **Affiliate Marketing Solution Management** (bắt buộc cho dữ liệu KOC), và nếu cần **Shopee Video Management**, **Livestream Management**; cho shop uỷ quyền các app mới.
3. Ads API: tài liệu ghi "giới hạn cho ISV hợp tác chính thức" (Ads guide); với app Seller In House thì cột quyền vẫn có, cần thử thật.

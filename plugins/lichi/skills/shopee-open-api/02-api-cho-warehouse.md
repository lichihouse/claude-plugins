# 02. API Shopee cho kho dữ liệu LICHI (đọc, không ghi)

Chọn từ 461 API theo câu hỏi kinh doanh: đơn affiliate/KOC, hiệu quả theo KOC/video/sản phẩm, chi phí ads, tiền thực nhận từng đơn, hoàn hàng. Chỉ liệt kê API **đọc** (GET). Bảng trường đầy đủ, nguyên văn tiếng Anh: `reference/api/<Module>.md`. Giới hạn ngày và định dạng: `01-nen-tang-va-bai-hoc.md` mục 3–4.

## Bản đồ nhanh: câu hỏi → API

| Câu hỏi | API chính | App cần |
|---|---|---|
| Đơn nào do KOC nào mang về, hoa hồng bao nhiêu từng sản phẩm | `v2.ams.get_conversion_report` | AMS app |
| Hiệu quả theo KOC / sản phẩm / video-live của KOC (theo ngày) | `v2.ams.get_affiliate_performance`, `get_product_performance`, `get_content_performance` | AMS app |
| Hoa hồng affiliate đã chốt theo tháng | `v2.ams.get_validation_list` + `get_validation_report` | AMS app |
| Hồ sơ KOC (follower, GMV 30 ngày) | `v2.ams.query_affiliate_list`, `get_managed_affiliate_list` | AMS app |
| Chi phí ads, ROAS theo ngày / giờ / chiến dịch | `v2.ads.get_all_cpc_ads_daily_performance`, `get_product_campaign_daily_performance`, `get_gms_*_performance` | Seller In House hoặc Ads Service |
| Tiền thực nhận từng đơn, phí sàn, voucher, phí affiliate | `v2.payment.get_escrow_list` → `get_escrow_detail_batch` | Seller In House |
| Đối soát tiền về ví | `v2.payment.get_wallet_transaction_list`, `get_income_detail`, `generate_income_report` | Seller In House |
| Danh sách đơn, trạng thái, SKU, số lượng huỷ/hoàn từng dòng | `v2.order.get_order_list` → `get_order_detail` | Seller In House |
| Hoàn hàng, lý do, số tiền hoàn | `v2.returns.get_return_list` → `get_return_detail` | Seller In House |
| Video của shop bán được gì | `v2.video.get_video_performance_list`, `get_video_detail_product_performance` | Video app |
| Phiên live của shop | `v2.livestream.get_session_metric`, `get_session_item_metric` | Livestream app |
| Danh mục sản phẩm, model_sku để khớp mã A13 | `v2.product.get_item_list` → `get_item_base_info` → `get_model_list` | Seller In House |

---

## A. AMS (affiliate / KOC), 36 API, cần app "Affiliate Marketing Solution Management"

### A1. `v2.ams.get_conversion_report` — bảng sự kiện quan trọng nhất (đơn × sản phẩm × KOC)
GET `/api/v2/ams/get_conversion_report`. Từng đơn affiliate với từng sản phẩm, KOC, chiến dịch, hoa hồng. Khoảng tối đa 3 tháng; `page_size` ≤500; `page_no × page_size` ≤10.000. Mới thêm 2026-07-02: phí dịch vụ người bán.

Lọc (đều không bắt buộc trừ phân trang): `order_sn`, `affiliate_id`, `item_id`, `item_name`, `l1/l2/l3_category_id`, `order_status` (Unpaid/Pending/Completed/Cancelled), `verified_status` (Unverified/Valid/Invalid), `buyer_status` (New/Existing), `attr_campaign_id`, `campaign_partner`, `seller_campaign_type` (TargetCampaign/OpenCampaign/MCNCampaign), `deduction_status` (PendingDeduction/Deducted), `deduction_method` (OrderEscrow/SellerWallet/AutoAdjustment/SVSPaymentLink/OfflineSettlement/AMSCredit), và 4 cặp khoảng thời gian (Unix giây, lấy giao nhau): `place_order_time_*`, `order_completed_time_*`, `conversion_completed_time_*`, `ams_deduction_time_*`.

| Trường (cấp đơn) | Kiểu | Ý nghĩa |
|---|---|---|
| `order_sn` | string | Mã đơn Shopee (khoá nối với Order/Payment) |
| `order_status` | string | Trạng thái đơn theo AMS (Pending/Completed/Cancelled) |
| `verified_status` | string | Đã xác minh hợp lệ chưa (Unverified/Valid/Invalid) |
| `place_order_time` / `order_completed_time` / `conversion_completed_time` | string `YYYY/M/D HH:MM:SS` | Lúc đặt / hoàn tất đơn / chốt chuyển đổi |
| `affiliate_id` / `affiliate_name` / `affiliate_username` | int64 / string | KOC (khoá nối với bảng KOC của Booking) |
| `linked_mcn` | string | MCN (agency) quản lý KOC, nếu có |
| `order_brand_commission` | string | Tổng hoa hồng shop trả cho cả đơn |
| `channel` | string | Kênh quảng bá (VD Telegram, Shopee Video...) |
| `order_type` | string | Direct Order (mua đúng sản phẩm được quảng bá) / Indirect Order |
| `buyer_status` | string | Khách mới / cũ |
| `campaign_partner` | string | Đối tác chiến dịch |

| Trường (`items[]`, cấp sản phẩm) | Kiểu | Ý nghĩa |
|---|---|---|
| `item_id`, `model_id`, `item_name` | int64/string | Sản phẩm và biến thể |
| `l1/l2/l3_category_id` | int64 | Ngành hàng |
| `promotion_id` | string | Khuyến mãi gắn đơn |
| `price`, `qty`, `purchase_value` | int64 | Giá, số lượng, giá trị mua ("cents or smallest unit": kiểm với VND) |
| `refund_amount` | string | Tiền hoàn của dòng |
| `seller_campaign_type`, `attr_campaign_id` | string/int64 | Loại chiến dịch (Open/Target/MCN) và mã chiến dịch |
| `item_brand_commission` | string | Hoa hồng shop trả cho dòng |
| `item_brand_commission_rate_to_affiliate` / `_to_affiliate` | string | Tỉ lệ / tiền chia cho KOC |
| `item_brand_commission_rate_to_mcn` / `_to_mcn` | string | Tỉ lệ / tiền chia cho MCN |
| `seller_service_fee_rate` / `seller_service_fee` | string | Phí dịch vụ người bán = hoa hồng × tỉ lệ |

### A2. Hiệu quả tổng hợp (dashboard AMS)
Chung: `period_type` (Day/Week/Month/Last7d/Last30d), `start_date`, `end_date` (`YYYYMMDD`, chỉ trong 3 tháng dương lịch gần nhất, mốc mới nhất từ `get_performance_data_update_time`), `order_type` (PlacedOrder = mọi đơn đặt kể cả chưa trả tiền / ConfirmedOrder = đã trả tiền hoặc COD đã xác nhận), `channel` (AllChannel/SocialMedia/ShopeeVideo/LiveStreaming). Trả `fetched_date_range` (khoảng thực tế, Shopee tự dời khoảng sai).

| API | Lọc thêm | Mỗi dòng có |
|---|---|---|
| `get_shop_performance` | – | `sales`, `gross_item_sold`, `orders`, `clicks`, `est_commission`, `roi` (= sales / est_commission), `total_buyers`, `new_buyers` |
| `get_product_performance` | `item_id` | `item_id`, `item_name` + các chỉ số trên (`items_sold`) |
| `get_affiliate_performance` | `affiliate_id` | `affiliate_id`, `affiliate_name`, `affiliate_username` + chỉ số |
| `get_content_performance` | `affiliate_id`, `item_id`; channel chỉ ShopeeVideo/LiveStreaming | `content_id`, `content_title`, `post_time`, KOC, `products`, `views`, `likes`, `comments`, `sales`, `orders`, `items_sold`, `channel` |
| `get_campaign_key_metrics_performance` | – | Open vs Targeted: `affiliates`, `items_sold`, `sales`, `est_commission` |
| `get_open_campaign_performance` | `item_id` | theo sản phẩm trong Open Campaign |
| `get_targeted_campaign_performance` | `campaign_id` | theo chiến dịch Targeted |

Mẹo nạp: gọi `period_type=Day` từng ngày → bảng ngày × KOC / sản phẩm / nội dung. Dữ liệu chỉ giữ 3 tháng, nên phải nạp đều đặn từ bây giờ để tích luỹ lịch sử.

### A3. Hoá đơn hoa hồng (đã chốt)
- `get_validation_list` (không tham số): mỗi tháng một dòng: `validation_id`, `validation_month` (YYYYMM), `payment_method` (1 online, 2 offline), `campaign_source` (ShopeeManaged/Seller), `online_bill{total_amount, bill_status, deducted_amount, ams_credit_deducted_amount, pending_amount}`, `offline_bills[]`.
- `get_validation_report`: chi tiết đơn của 1 hoá đơn, cùng trường như conversion report. Bắt buộc `validation_id`, `validation_month`, `campaign_source`, `place_order_time_start/end`.

### A4. KOC và chiến dịch (danh mục)
- `query_affiliate_list` (`query_type` 1 = theo danh sách id ≤200, 2 = tìm theo tên): `affiliate_id`, `affiliate_name`, `user_name`, `social_medias[]{platform, follower_count, social_media_user_name}`, `total_click` 30 ngày, `order_range`, `gmv_range`, `is_orange_tick_kol`, `is_good_fulfillment`, `promote_category_ids`, `top_popular_contents[]`, `top_selling_products[]`.
- `get_managed_affiliate_list`: KOC shop đã lưu, cùng trường.
- `get_targeted_campaign_list`: `campaign_id`, `campaign_name`, `campaign_status`, `period_start/end_time`, `affiliate_count`, `item_count`, `min_rate`, `max_rate`. Chi tiết KOC và sản phẩm: `get_targeted_campaign_settings`.
- `get_open_campaign_added_product`: sản phẩm trong Open Campaign với `commission_rate` (1.1 = 1,1%), thời gian, `commission_protection_list`. Phân trang bằng `cursor`.
- Lưu ý: sản phẩm bị gỡ khỏi Open Campaign vẫn tính hoa hồng thêm 7 ngày (AMS guide).

---

## B. Ads, cần Seller In House System hoặc Ads Service

| API | Tham số | Trả về |
|---|---|---|
| `get_total_balance` | – | `total_balance` (số dư ads gồm credit trả phí + miễn phí), `data_timestamp` |
| `get_all_cpc_ads_daily_performance` | `start_date`, `end_date` (`DD-MM-YYYY`, ≤1 tháng, ≤6 tháng trước) | mảng theo ngày, cấp shop |
| `get_all_cpc_ads_hourly_performance` | `performance_date` (`DD-MM-YYYY`) | mảng theo giờ |
| `get_product_level_campaign_id_list` | `ad_type` (all/auto/manual), `offset`, `limit` | `campaign_id`, `ad_type`, `has_next_page` |
| `get_product_level_campaign_setting_info` | `info_type_list` (1 chung, 2 bid tay, 3 bid tự động, 4 auto product), `campaign_id_list` ≤100 | `ad_name`, `campaign_status`, `bidding_method`, `campaign_placement`, `campaign_budget`, `campaign_duration`, `item_id_list`, từ khoá và giá bid, `roas_target` |
| `get_product_campaign_daily_performance` / `_hourly_` | `campaign_id_list` ≤100 + ngày | theo chiến dịch × ngày (hoặc giờ) |
| `get_gms_campaign_performance` / `get_gms_item_performance` | `start_date`, `end_date` (`DD-MM-YYYY`), `campaign_id`; item: `offset`, `limit` ≤100 | GMV Max theo chiến dịch / theo sản phẩm |

Chỉ số (cấp shop): `impression`, `clicks`, `ctr`, `expense` (chi phí), `direct_order`/`broad_order`, `direct_item_sold`/`broad_item_sold`, `direct_gmv`/`broad_gmv`, `direct_roas`/`broad_roas`, `direct_conversions`/`broad_conversions`, `cost_per_conversion`. Cấp chiến dịch thêm `broad_order_amount`, `direct_order_amount` (số lượng), `broad_roi`, `broad_cir` (ACOS), `cr`, `cpc`, `cpdc`.
- **direct** = khách mua đúng sản phẩm được quảng cáo trong 7 ngày sau khi bấm; **broad** = mua bất kỳ sản phẩm nào của shop trong 7 ngày. Số ngày gần nhất còn thay đổi trong 7 ngày: nạp lại 7 ngày gần nhất mỗi lần.
- Escrow có `pay_per_sale` (phí ads trả theo đơn, thêm 2026-09-30) và `ads_escrow_top_up_fee_or_technical_support_fee`: chi phí ads trừ thẳng vào tiền đơn.

---

## C. Payment (tiền thực nhận), cần Seller In House System

### C1. Luồng nạp
`get_escrow_list` (`release_time_from/to`, `page_no`, `page_size` ≤100) → danh sách `order_sn`, `payout_amount`, `escrow_release_time` → `get_escrow_detail_batch` (1–50 đơn, khuyên ≤20) → chi tiết từng đơn. `get_escrow_detail` là bản 1 đơn.

### C2. Trường chính `escrow_detail.order_income` (đơn vị VND, float)
| Trường | Ý nghĩa |
|---|---|
| `escrow_amount` | **Tiền shop thực nhận** cho đơn |
| `order_original_price` / `order_selling_price` / `order_discounted_price` | Giá gốc / giá bán / giá sau giảm của cả đơn |
| `seller_discount`, `shopee_discount`, `order_seller_discount` | Giảm giá do shop / do Shopee |
| `voucher_from_seller`, `voucher_from_shopee`, `coins`, `seller_coin_cash_back` | Voucher và xu |
| `commission_fee`, `service_fee`, `seller_transaction_fee`, `seller_order_processing_fee` | Phí cố định, phí dịch vụ, phí thanh toán, phí xử lý đơn |
| `net_commission_fee`, `net_service_fee` | Phí sau khi trừ hoàn phí |
| `order_ams_commission_fee` | **Phí affiliate của đơn** (khớp với AMS) |
| `final_shipping_fee`, `actual_shipping_fee`, `shopee_shipping_rebate`, `estimated_shipping_fee`, `reverse_shipping_fee`, `final_return_to_seller_shipping_fee` | Vận chuyển chiều đi, trợ giá, phí hoàn, phí giao thất bại |
| `refund_amount_to_buyer`, `drc_adjustable_refund` | Hoàn tiền cho khách (hoàn một phần, khiếu nại) |
| `cost_of_goods_sold`, `original_cost_of_goods_sold` | Khách thực trả cho hàng |
| `withholding_vat_tax`, `withholding_pit_tax`, `withholding_cit_tax`, `tax_registration_code` | Thuế khấu trừ tại nguồn theo luật VN |
| `pay_per_sale`, `ads_escrow_top_up_fee_or_technical_support_fee` | Phí ads trừ vào đơn |
| `items[]` | Từng dòng: `item_id`, `model_id`, `item_sku`, `model_sku`, `quantity_purchased`, `original_price`, `selling_price`, `discounted_price`, `seller_discount`, `shopee_discount`, `discount_from_voucher_*`, `discount_from_coin`, `ams_commission_fee` (phí affiliate từng dòng), `activity_type/id` (combo, mua kèm), `promotion_list[]` |

Ngoài ra `buyer_payment_info` (khách trả: `buyer_total_amount`, `shipping_fee`, `shopee_voucher`, `seller_voucher`, `buyer_payment_method`...) và `return_order_sn_list`.

### C3. Đối soát khác
- `get_wallet_transaction_list` (≤15 ngày): giao dịch ví: `transaction_type`, `amount`, `current_balance`, `create_time`, `order_sn`, `refund_sn`, `reason`, `money_flow`.
- `get_income_overview` / `get_income_detail` (`date_from/to` `YYYY-MM-DD`, ≤14 ngày, `income_status` 1 Released, 2 Pending): từng đơn `estimated_escrow_amount`, `released_amount`, `actual_payout_time`.
- `generate_income_report` → `get_income_report` (file tải về), `generate_income_statement` → `get_income_statement`.

---

## D. Order, cần Seller In House System
- `get_order_list`: `time_range_field` (create_time/update_time), `time_from/to` (≤15 ngày), `page_size` ≤100, `cursor`, `order_status`. Trả `order_sn` (+ `order_status` nếu xin).
- `get_order_detail` (≤50 đơn, xin thêm trường bằng `response_optional_fields`): `order_status`, `create_time`, `update_time`, `pay_time`, `total_amount`, `cod`, `payment_method`, `shipping_carrier`, `cancel_by`, `cancel_reason`, `buyer_user_id`, `buyer_username` (bị che với đơn không tích hợp), `recipient_address` (dữ liệu nhạy cảm, không nạp), `package_list[]{package_number, logistics_status}`, `item_list[]{item_id, item_sku, model_id, model_sku, model_quantity_purchased, model_original_price, model_discounted_price, promotion_type, promotion_id, active_qty, cancelled_qty, returned_qty, return_requested_qty}`, `return_request_due_date`, `affiliate_sample_type` (đơn mẫu cho KOC).
- Trạng thái đơn (Data Definition): UNPAID, PENDING, READY_TO_SHIP, PROCESSED, RETRY_SHIP, SHIPPED, TO_CONFIRM_RECEIVE, IN_CANCEL, CANCELLED, TO_RETURN, COMPLETED.

## E. Returns
- `get_return_list` (≤15 ngày theo create hoặc update time; lọc `status`): `return_sn`, `order_sn`, `reason`, `text_reason`, `refund_amount`, `amount_before_discount`, `status` (REQUESTED/ACCEPTED/CANCELLED/JUDGING/CLOSED/PROCESSING/SELLER_DISPUTE), `return_solution`, `item[]{item_id, model_id, item_sku, variation_sku, amount, item_price}`, `create_time`, `update_time`, `negotiation_status`, `seller_compensation_status`, `is_partial_quantity_return`, `is_refund_amount_adjusted`.
- Lý do hoàn (ReturnReason): NONRECEIPT, WRONG_ITEM, ITEM_DAMAGED, DIFF_DESC, CHANGE_MIND, ITEM_NOT_FIT, ITEM_MISSING... (đầy đủ trong `reference/guides/0031-v2-0-data-definition.md`).

## F. Video, cần app "Shopee Video Management"
- `get_video_list` (`list_type` 2 = đã đăng, `page_size` ≤20): `post_id`, `post_time`, `caption`, `duration`, `views`, `likes`, `comments`, `item_list[]`.
- `get_video_performance_list` (`period_type`, `end_date` `YYYY-MM-DD`, `order_by`, `sort`): theo video `views`, `likes`, `comments`, `shares`, `avg_views_duration`, `completion_rate`, `placed_orders`, `confirmed_orders`, `placed_sales`, `confirmed_sales`, `placed_item_sold`, `confirmed_item_sold`.
- `get_prodcut_performance_list` (tên gốc viết sai "prodcut"): theo sản phẩm trên mọi video.
- `get_video_detail_product_performance` (`post_id`): từng sản phẩm trong 1 video: `product_clicks`, `placed_orders`, `placed_sales`, `sold_items`, `conversion_rate`...
- Chỉ là video của **shop**. Video của KOC lấy qua AMS `get_content_performance`.

## G. Livestream, cần app "Livestream Management"
- `get_session_metric` (`session_id`): `gmv`, `orders`, `atc`, `ctr`, `co`, `ccu`, `peak_ccu`, `views`, `likes`, `comments`, `shares`, `avg_viewing_duration`. Số liệu realtime, phải chụp khi/sau phiên.
- `get_session_item_metric`: từng sản phẩm `item_clicks`, `atc`, `sold_items`.
- Không có API liệt kê lịch sử các phiên: phải tự lưu `session_id` lúc tạo phiên (`create_session`) hoặc lấy từ nơi khác.

## H. Product (khớp mã sản phẩm)
`get_item_list` (`item_status`, `update_time_from/to`, `page_size` ≤100) → `get_item_base_info` (≤50 id) → `get_model_list` (`model_id`, `model_sku`, `tier_index`, `price_info`, `stock_info_v2`). `model_sku` / `item_sku` là mã người bán tự đặt, dùng để khớp mã A13 giữa Booking/Kho/sàn.

## I. BrandPortal (tuỳ chọn)
App "Brand Portal Service", uỷ quyền principal. Gộp nhiều shop theo thương hiệu: `get_shop_sales_performance_detail` (sales, orders, units_sold, product_views, unique_visitors, conversion, flash sale, voucher), `get_*_affiliate_performance`, `get_*_livestream_performance`, `get_*_video_performance`, `get_content_affiliate_performance` (theo nội dung KOC: views, likes, sales_placed/confirmed, orders_placed/confirmed). Ngày `YYYY-MM-DD` + `timezone` GMT+7, `granularity` day/week/month/customize. Chưa rõ LICHI có tài khoản Brand Portal không.

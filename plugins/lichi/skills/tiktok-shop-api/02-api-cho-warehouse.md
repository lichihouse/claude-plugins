# 02. API TikTok Shop có giá trị cho warehouse LICHI

Bản mới nhất trên Partner Center ngày 2026-10-31. Chi tiết trường: grep path trong `reference/api/<nhóm>.md`. Tất cả cần `shop_cipher` và token shop của app Booking (app Seller, đã có OAuth).

## 1. Đơn hàng (scope `seller.order.info`)

| API | Dùng để | Ghi chú |
|---|---|---|
| `POST /order/202309/orders/search` (Get Order List) | Lấy đơn đổi trạng thái theo `update_time_ge/lt` | page_size 1–100. Bản mới nhất vẫn là 202309 |
| `GET /order/202507/orders?ids=` (Get Order Detail) | Chi tiết đơn, dòng hàng, giá, mã SKU | tối đa 50 id/lần |
| `GET /order/202407/orders/{order_id}/price_detail` | Tách giảm giá theo dòng: phần shop chịu và sàn chịu, voucher | thêm `seller_funded_product_promotions[]`, `seller_funded_shipping_promotions[]` có `activity_id` để nối khuyến mãi |

Trường mới 2026 đáng lưu: `line_items[].room_id` (đơn từ phiên LIVE nào, tất cả thị trường từ 2026-10-22), `line_items[].product_listing_type`, `buyer_nickname`, `is_exchange_order` + `exchange_source_order_id`, `is_replacement_order` + `replaced_order_id`, `is_sample_order`, `is_refundable_sample`, `fast_rts_sla_time`/`fast_collection_sla_time` (SEA). `room_id` cho phép tính GMV live theo đơn thật thay vì số analytics.

## 2. Tiền (scope `seller.finance.info`)

| API | Dùng để | Ghi chú |
|---|---|---|
| `GET /finance/202309/statements` | Danh sách kỳ quyết toán theo `statement_time_ge/lt` | |
| `GET /finance/202501/statements/{statement_id}/statement_transactions` | Từng giao dịch trong kỳ, có `fee_tax_breakdown` chi tiết | bản 202309 đã khai tử |
| `GET /finance/202501/orders/{order_id}/statement_transactions` | Giao dịch theo đơn | dùng khi cần soát 1 đơn |
| `GET /finance/202507/orders/unsettled` | Đơn chưa quyết toán, ước tính tiền về | `search_time_ge/lt` |
| `GET /finance/202605/payments` | Tiền chuyển về ngân hàng | 202309 đã khai tử 2026-08-15 |
| `GET /finance/202309/withdrawals` | Rút tiền | |

Phí thêm trong 2026 (đều nằm trong `fee_tax_breakdown.fee`): phí GMV Max coupon `gmv_max_coupon_fee`, thuế hoa hồng CPS Shop Ads, phí gói Smart Promotion Growth, hoa hồng video tự đăng bằng AI `auto_post_shoppable_video_commission_fee`, phí dịch vụ S-Point, phí chương trình thương hiệu. Lưu cả `fee_tax_breakdown` dạng JSON để không mất trường mới.

## 3. Hoàn, huỷ (scope `seller.return_refund.basic`)

| API | Dùng để |
|---|---|
| `POST /return_refund/202602/returns/search` | Yêu cầu hoàn/trả theo `update_time_ge/lt`; page_size 10–50; có `arbitration_status`, lý do, số tiền hoàn |
| `POST /return_refund/202602/cancellations/search` | Đơn huỷ (đơn boom), theo `update_time` |
| `GET /return_refund/202309/returns/{return_id}/records` | Lịch sử từng bước của 1 yêu cầu hoàn |

Booking đã kéo hai Search này (bảng return cockpit). Warehouse có thể đọc từ DB Booking thay vì gọi lại.

## 4. Analytics (scope `data.shop_analytics.public.read`, ngày theo giờ shop, `end_date_lt` không bao gồm)

| API (bản mới nhất) | Cho biết | Giới hạn |
|---|---|---|
| `GET /analytics/202609/shop/performance` | Tổng shop theo ngày: GMV tách nguồn (video, live, thẻ sản phẩm, affiliate), AOV, khách trả tiền, huỷ/hoàn, phí ship, thuế, lượt xem/click sản phẩm | `granularity` |
| `GET /analytics/202510/shop/performance/{date}/performance_per_hour` | Theo giờ | **≤7 ngày/request từ 2026-11-06** |
| `GET /analytics/202605/shop_products/performance` | Từng sản phẩm: GMV, đơn, khách, click/impression, tách theo kênh (seller video/live, affiliate video/live, thẻ sản phẩm, shop tab), hoàn | page_size ≤100 |
| `GET /analytics/202509/shop_skus/performance` | Từng SKU (màu/size) | page_size ≤100 |
| `GET /analytics/202605/shop_videos/performance` | Từng video (cả KOC, `account_type=AFFILIATE_ACCOUNTS`): GMV, view, like, follower mới, CTR | **≤30 ngày/request từ 2026-11-06**; gọi 1 ngày/lần để có số theo ngày |
| `GET /analytics/202609/shop_videos/batch_performance` | Chi tiết nhiều video một lần, theo ngày | thay `shop_videos/{id}/performance` (khai tử 2026-12-28); ≤60 ngày |
| `GET /analytics/202509/shop_videos/{video_id}/products/performance` | GMV từng sản phẩm trong 1 video | tách GMV khi video gắn nhiều mẫu |
| `GET /analytics/202609/shop_lives/performance` | Từng phiên live | page_size ≤100 |
| `GET /analytics/202512/shop/{live_id}/products_performance` | GMV từng sản phẩm trong 1 phiên live | |
| `GET /analytics/202510/shop_lives/{live_id}/performance_per_minutes` | Theo phút trong phiên | |
| `GET /analytics/202511/{products,creators,videos,lives}/bestselling` | Top 100 theo GMV trong thị trường (đối thủ) | |
| `GET /analytics/202606/shop_performances/*` | Điểm SPS (sức khoẻ shop) | hiện chỉ US |

Độ sâu lịch sử analytics (bao nhiêu ngày về trước) tài liệu không ghi chung cho mọi API: phải thử thật khi backfill.

## 5. Affiliate phía seller (scope `seller.affiliate_collaboration.read` và nhóm affiliate)

| API | Dùng để | Ghi chú |
|---|---|---|
| `POST /affiliate_seller/202410/orders/search` | Đơn affiliate: creator, SKU, hoa hồng ước tính và thực trả, trạng thái quyết toán | lọc **chỉ theo `create_time`**, tối đa 3 tháng/request; trạng thái hoa hồng đổi sau → phải quét lại cửa sổ dài. 2026-10 thêm `sku_name`, `seller_sku` |
| `POST /affiliate_seller/202608/marketplace_creators/search`, `GET .../marketplace_creators/{id}` | Hồ sơ creator: follower, GMV 30 ngày, level, điểm | dùng cho `dim_creator` |
| `POST /affiliate_seller/202603/compass/offline_task` → `GET .../compass/offline_tasks` → `GET .../offline_tasks/{task_id}/file` | Xuất báo cáo Affiliate Compass dung lượng lớn (video, creator...) chạy nền | danh sách task chỉ giữ 7 ngày; hợp cho backfill |
| Target/Open collaboration, sample applications | Lịch sử hợp tác, mẫu gửi KOC | phần đọc |

## 6. Khác

| API | Dùng để |
|---|---|
| `POST /product/202502/products/search` + `GET /product/202309/products/{id}` | Danh mục sản phẩm, `seller_sku` để nối mã A13 |
| `POST /promotion/202309/activities/search`, `GET /promotion/202309/activities/{id}`, `POST /promotion/202406/coupons/search` | Khuyến mãi đang chạy, nối với `activity_id` trong price detail |
| `GET /customer_service/202407/performance` | Tốc độ, tỉ lệ trả lời chat |
| `GET /logistics/202604/orders/{order_id}/tracking`, `GET /fulfillment/202309/packages/{package_id}` | Thời gian giao, lý do giao lỗi (`ship_exception_reason`) |

## 7. Không có trong TikTok Shop API

Chi phí quảng cáo (GMV Max, Live ads) → cần TikTok for Business Marketing API. Đánh giá sản phẩm của khách → không có API đọc. Thông tin cá nhân người mua → bị che, không cần.

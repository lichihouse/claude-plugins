---
name: shopee-open-api
description: Kiến thức Shopee Open Platform API v2 cho LICHI. Dùng khi viết code gọi Shopee (Booking, script, bộ nạp BigQuery), thiết kế nạp dữ liệu sàn, hay trả lời câu hỏi về API Shopee - đơn, escrow/tiền thực nhận, AMS/affiliate/KOC, Ads, Video, Live, Returns, webhook, token, chữ ký.
---

# Shopee Open Platform API v2 cho LICHI

Trả lời Đức bằng tiếng Việt, giữ tên API và tên trường gốc tiếng Anh. Tài liệu tải và rà soát ngày 2026-10-31: 461 API / 32 module, 64 trang Developer Guide, 35 loại push.

## 1. Tra cứu ở đâu

Mọi đường dẫn dưới đây tính từ thư mục chứa file SKILL.md này. Chỉ đọc file cần, đừng đọc cả thư mục (`reference/` khoảng 2,5 MB).

| File | Đọc khi |
|---|---|
| `01-nen-tang-va-bai-hoc.md` | Trước khi viết code gọi Shopee: quyền theo loại app, chữ ký, token, định dạng ngày/tiền, giới hạn khoảng ngày + phân trang, push, 10 bài học từ code Booking |
| `02-api-cho-warehouse.md` | Cần dữ liệu: đơn affiliate/KOC, hiệu quả KOC/video/sản phẩm, chi phí ads, tiền thực nhận, hoàn hàng. Bảng trường giải thích tiếng Việt |
| `03-nap-bigquery.md` | Thiết kế bảng `raw_shopee` trên BigQuery, lịch nạp, khoá nối |
| `04-muc-luc-461-api.md` | Tìm xem có API nào làm việc X (mỗi API 1 dòng) |
| `reference/api/<Module>.md` | Chi tiết nguyên văn 1 module: method, path, app được gọi, mọi tham số, mọi trường response, lỗi, lịch sử cập nhật. Tìm 1 API: grep `^## v2.<module>.<tên>` |
| `reference/push.md` | 35 loại webhook: code, trường, ví dụ, retry |
| `reference/guides/*.md` | Developer Guide (0016 gọi API, 0020 xác thực, 0018 push, 0031 enum trạng thái, 0229 đơn, 0227 hoàn, 0702 AMS, 0277 Ads, 0706 Video, 0669 Live, 0733 Brand Portal...) |
| `scripts/fetch_shopee_docs.py` | Tải lại toàn bộ khi nghi tài liệu đã đổi: `python3 -I scripts/fetch_shopee_docs.py /tmp/shopee-moi` (cần curl, pandoc, ~3 phút, chỉ đọc trang công khai), rồi `diff -r reference /tmp/shopee-moi/reference` |

Nếu cần một API mà bản lưu chưa có hoặc nghi đã cũ, lấy thẳng JSON công khai (trang open.shopee.com là SPA, không đọc được bằng fetch HTML):
`https://open.shopee.com/opservice/api/v1/doc/api/?version=2&api_name=v2.order.get_order_detail` (trường `params` là JSON chuỗi có `request_params`/`response_params` lồng `children`; `api_permission` = loại app được gọi; `error_list`; `update_log_list`). Danh sách module: `/opservice/api/v1/doc/module/?version=2`.

Code thật đang chạy: repo Booking `artifacts/api-server/src/lib/shopee/` (sign.ts, client.ts, tokens.ts, windows.ts, paging.ts, push.ts, errors.ts). Đọc trước khi thêm lệnh gọi Shopee, dùng lại client và cơ chế token có sẵn.

## 2. Điều bắt buộc nhớ

- **Loại app quyết định quyền.** AMS (affiliate/KOC) chỉ app Affiliate Marketing Solution Management; Video chỉ Shopee Video Management; Livestream chỉ Livestream Management; BrandPortal (`/api/v2/principal/...`) chỉ Brand Portal Service. Seller In House System gọi được Order, Payment, Returns, Product, Logistics, Ads, khuyến mãi... Kiểm `api_permission` trước khi hứa có dữ liệu.
- **Chữ ký**: HMAC-SHA256(partner_key, chuỗi nối), xuất hex. Shop API `partner_id+path+timestamp+access_token+shop_id`; Merchant thay shop_id bằng merchant_id; Public `partner_id+path+timestamp`. timestamp sống 5 phút. Host live `https://partner.shopeemobile.com`, sandbox `https://openplatform.sandbox.test-stable.shopee.sg`.
- **Token**: access_token 4 giờ; refresh_token 30 ngày, **dùng 1 lần**, mỗi lần refresh trả cặp mới phải lưu ngay; uỷ quyền shop tối đa 365 ngày. Không để hai tiến trình cùng refresh một shop của một app (Booking khoá theo shop trong `tokens.ts`). Bộ nạp BigQuery không tự refresh token của app Booking. Staging dump từ prod phải xoá token.
- **Lỗi đi kèm HTTP 200**: xét trường `error` rỗng, không xét status code.
- **Giới hạn khoảng ngày**: get_order_list, get_return_list, wallet ≤15 ngày (Booking dùng cửa sổ 14 ngày, đọc lùi 1 giờ trước mốc); get_income_detail ≤14 ngày; Ads daily ≤1 tháng, chỉ 6 tháng gần nhất, start≠end; AMS dashboard chỉ 3 tháng dương lịch gần nhất (mốc mới nhất từ get_performance_data_update_time với AmsMarker); get_conversion_report ≤3 tháng, page_size ≤500, page_no×page_size ≤10.000; get_order_detail và get_escrow_detail_batch ≤50 đơn; Video page_size ≤20, trễ ≥1 ngày.
- **Định dạng ngày khác nhau theo module**: Unix giây (Order, Payment, Returns), `YYYYMMDD` (AMS performance), `DD-MM-YYYY` (Ads), `YYYY-MM-DD` (Video, income_detail, BrandPortal), chuỗi `YYYY/M/D HH:MM:SS` (AMS conversion, múi giờ chưa xác minh). AMS trả tiền dạng chuỗi; tiền VND khi lưu làm tròn số nguyên.
- **Ads direct và broad**: direct = khách mua đúng sản phẩm quảng cáo trong 7 ngày sau click; broad = mua bất kỳ sản phẩm nào của shop. Số 7 ngày gần nhất còn đổi, nên nạp lại.
- **Push**: chỉ báo có thay đổi, phải gọi API đọc lại; có thể trùng, mất, sai thứ tự (retry 300/1800/10800 giây); trả 2xx body rỗng trong khoảng 3 giây; header Authorization = HMAC-SHA256(Push Partner Key, URL + "|" + body); luôn có lượt quét bù.
- Tài liệu đôi khi lệch thực tế (get_return_list page_no ghi mặc định 0 nhưng trang 0 và 1 trả trùng; mẫu token/get in expire_in như epoch). Code phòng thủ và ghi chú nguồn.

## 3. Khoá nối

`order_sn` nối Order ↔ Escrow ↔ AMS conversion ↔ Returns ↔ Wallet. `model_sku`/`item_sku` (mã người bán) khớp mã A13 của Booking/Kho. `affiliate_id`/`affiliate_username` (AMS) khớp KOC trong Booking. `campaign_id` của Ads khác `attr_campaign_id` của AMS.

## 4. An toàn

- Gọi API **ghi** lên Shopee thật (xác nhận hoàn, sửa giá, tồn, ads...) phải hỏi Đức trước, trừ khi qua tính năng có sẵn trên app.
- Không nạp hay ghi log dữ liệu nhạy cảm của khách (địa chỉ, SĐT), URL đã ký, token, partner key.
- Điều tài liệu không ghi rõ (rate limit, múi giờ, đơn vị "cents") thì nói rõ là chưa xác minh và đề xuất kiểm bằng lệnh gọi thật.
- Khi tải lại tài liệu thấy thay đổi đáng kể, sửa các file 01–04 cho khớp và tăng version plugin `lichi`.

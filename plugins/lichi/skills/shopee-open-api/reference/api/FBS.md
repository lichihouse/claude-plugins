# Module FBS (4 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.fbs.query_br_shop_enrollment_status
`GET /api/v2/fbs/query_br_shop_enrollment_status` · loại: Shop · app được gọi: ERP System, Seller In House System

This API checks whether a given shop_id is eligible to enroll in the Brazil Fulfilled-by-Shopee (FBS) service.

Lịch sử cập nhật: 2025-07-15: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ shop_id` | int64 | Shopee's unique identifier for a shop |
| `↳ enrollment_status` | int32 | 1: enable enrollment 2: disable enrollment 3: already enrollment |
| `↳ enable_enrollment_time` | int64 | The time of this shop able to enroll FBS. |

Lỗi riêng: %v is invalid · %v is not found · Region is not BR · Shop and SKU is not related · System error, please try again later · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

## v2.fbs.query_br_shop_invoice_error
`GET /api/v2/fbs/query_br_shop_invoice_error` · loại: Shop · app được gọi: ERP System, Seller In House System

This API handles failed invoice issuance for FBS-related processes, covering Inbound Requests, RTS Requests, Sales Orders, and Move Transfer Orders.

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 |  |  |
| `page_size` | int32 |  | max: 100 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ total` | int64 |  |
| `↳ list` | object[] |  |
| `↳↳ shop_id` | int64 | Shopee's unique identifier for a shop. |
| `↳↳ biz_request_type` | int32 | 1: Inbound 2: Return From Warehouse 3: Sales order invoice 4: Move Transfer 5：IA |
| `↳↳ biz_request_id` | string | Return by default. The business FBS request order ID. |
| `↳↳ fail_reason` | string | Invoice issuance failed reason. |
| `↳↳ fail_type` | int32 | 1: sku tax info error 2: seller tax info error |
| `↳↳ invoice_deadline_time` | int64 | The expired time of this failed invoice. If expired, then this request order would be cancelled. |
| `↳↳ shop_sku_list` | object[] |  |
| `↳↳↳ shop_item_id` | int64 | ID of item |
| `↳↳↳ shop_model_id` | int64 | ID of model |
| `↳↳↳ shop_item_name` | string | Name of item |
| `↳↳↳ shop_model_name` | string | Name of model |
| `↳↳↳ fail_reason` | string | Invoice issuance failed reason. |
| `↳↳ invoice_id` | string | Invoice ID |
| `↳↳ reminder_desc` | string | remind seller if this block issue is not solved , it will block the shop or item |

Lỗi riêng: %v is invalid · %v is not found · Region is not BR · Shop and SKU is not related · System error, please try again later · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

## v2.fbs.query_br_shop_block_status
`GET /api/v2/fbs/query_br_shop_block_status` · loại: Shop · app được gọi: ERP System, Seller In House System

This API checks whether an FBS shop is blocked due to invoice-related issues. When blocked, the shop cannot create new Inbound Requests, and its warehouse inventory is restricted from being sold.

Lịch sử cập nhật: 2025-07-15: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ shop_id` | int64 | Shopee's unique identifier for a shop. |
| `↳ is_block` | boolean | shop blocked status |

Lỗi riêng: %v is invalid · %v is not found · Region is not BR · System error, please try again later · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

## v2.fbs.query_br_sku_block_status
`GET /api/v2/fbs/query_br_sku_block_status` · loại: Shop · app được gọi: ERP System, Seller In House System

This API checks whether an FBS product is blocked due to invoice-related issues. When blocked, the product cannot be included in new Inbound Requests, and its warehouse inventory is restricted from being sold.

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shop_sku_id` | string | ✔ |  |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ shop_sku_id` | string | itemID_modelID |
| `↳ is_block` | boolean | product is blocked and warehouse stock cannot be sold |
| `↳ shop_item_id` | int64 | ID of item |
| `↳ shop_model_id` | int64 | ID of model |
| `↳ shop_item_name` | string | Name of Item |
| `↳ shop_model_name` | string | Name of model |

Lỗi riêng: %v is invalid · %v is not found · Region is not BR · Shop and SKU is not related · System error, please try again later · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

# Module Buybox (5 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.buybox.get_buybox_models_by_shop_id（only for BR now）
`POST /api/v2/buybox/get_buybox_models_by_shop_id` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Get the paginated Buybox model list for the authorized shop.

Lịch sử cập nhật: 2026-10-10: add a sign （only for BR now）; 2026-09-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `offset` | int32 |  | Pagination offset. Must be non-negative. |
| `limit` | int32 |  | Page size. Valid range is 1 to 250. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ model_list` | object[] |  |
| `↳↳ model_id` | int64 |  |
| `↳↳ is_model_mapped` | boolean |  |
| `↳↳ is_eligible` | boolean |  |
| `↳↳ model_toggle_on_status` | boolean |  |
| `↳↳ last_updated_time` | string |  |
| `↳ page_info` | object |  |
| `↳↳ offset` | int32 |  |
| `↳↳ limit` | int32 |  |
| `↳↳ total_count` | int32 |  |
| `↳ shop_id` | int64 |  |

Lỗi riêng: The pagination parameters are invalid. Provide a non-negative offset and a valid limit. · An unexpected system error occurred. Try again later.

## v2.buybox.get_buybox_models_by_model_id（only for BR now）
`POST /api/v2/buybox/get_buybox_models_by_model_id` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Get Buybox model information by model IDs for the authorized shop.

Lịch sử cập nhật: 2026-10-10: add a sign （only for BR now）; 2026-09-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `model_id_list` | int64[] | ✔ |  |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ model_list` | object[] |  |
| `↳↳ model_id` | int64 |  |
| `↳↳ is_model_mapped` | boolean |  |
| `↳↳ is_eligible` | boolean |  |
| `↳↳ model_toggle_on_status` | boolean |  |
| `↳↳ last_updated_time` | string |  |

Lỗi riêng: The model ID list contains duplicate values. Remove the duplicate model IDs and try again. · The model ID is invalid. Provide a valid positive model ID. · The model ID list is invalid. Provide a valid list of positive model IDs. · The model was not found under the authorized shop. Check the model ID and try again. · An unexpected system error occurred. Try again later.

## v2.buybox.get_buybox_shop_performance（only for BR now）
`POST /api/v2/buybox/get_buybox_shop_performance` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Get Buybox shop performance for the authorized shop.

Lịch sử cập nhật: 2026-10-10: add a sign （only for BR now）; 2026-09-24: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ past_7_days_sold_count` | int64 |  |
| `↳ total_sold_count` | int64 |  |
| `↳ sales` | float |  |
| `↳ data_updated_time` | string |  |
| `↳ shop_id` | int64 |  |

Lỗi riêng: Buybox performance data is temporarily unavailable. Try again later. · An unexpected system error occurred. Try again later.

## v2.buybox.get_buybox_model_performance（only for BR now）
`POST /api/v2/buybox/get_buybox_model_performance` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Get Buybox model performance by model IDs for the authorized shop.

Lịch sử cập nhật: 2026-10-10: add a sign （only for BR now）; -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `model_id_list` | int64[] | ✔ |  |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ performance_list` | object[] |  |
| `↳↳ model_id` | int64 |  |
| `↳↳ past_7_days_sold_count` | int64 |  |
| `↳ data_updated_time` | string |  |

Lỗi riêng: The model ID list contains duplicate values. Remove the duplicate model IDs and try again. · The model ID is invalid. Provide a valid positive model ID. · The model ID list is invalid. Provide a valid list of positive model IDs. · The model was not found under the authorized shop. Check the model ID and try again. · Buybox performance data is temporarily unavailable. Try again later. · An unexpected system error occurred. Try again later.

## v2.buybox.update_buybox_model_enrollment（only for BR now）
`POST /api/v2/buybox/update_buybox_model_enrollment` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Update Buybox model enrollment status for the authorized shop.

Lịch sử cập nhật: 2026-10-10: add a sign （only for BR now）; -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `model_id` | int64 | ✔ |  |
| `model_toggle_on_status` | boolean | ✔ |  |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ model_id` | int64 |  |
| `↳ model_toggle_on_status` | boolean |  |
| `↳ last_updated_time` | string |  |
| `↳ shop_id` | int64 |  |

Lỗi riêng: The model enrollment status could not be fully updated. Try again later. · The enrollment status is invalid. Provide a valid target enrollment status. · The model ID is invalid. Provide a valid positive model ID. · The model is not eligible to participate in Buybox. Review the eligibility requirements before trying again. · The model was not found under the authorized shop. Check the model ID and try again. · The model does not have an active Buybox mapping and cannot be updated. · An unexpected system error occurred. Try again later.

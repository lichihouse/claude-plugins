# Module ShopFlashSale (11 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.shop_flash_sale.get_time_slot_id
`GET /api/v2/shop_flash_sale/get_time_slot_id` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

get time slot id

Lịch sử cập nhật: 2024-09-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_time` | timestamp | ✔ | min = now, max=2145887999, should be < end_time |
| `end_time` | timestamp | ✔ | should be > start_time, max=2145887999 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] |  |
| `↳ timeslot_id` | int64 |  |
| `↳ start_time` | timestamp | the start time of time slot |
| `↳ end_time` | timestamp | the end time of time slot |

Lỗi riêng: parse data failed · data not exist · parameter invalid · You don't have permission for the operation · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · not meet shop criteria · The Wrong parameters, detail: {msg}.

## v2.shop_flash_sale.create_shop_flash_sale
`POST /api/v2/shop_flash_sale/create_shop_flash_sale` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

creat shop flash sale

Lịch sử cập nhật: 2024-09-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `timeslot_id` | int64 | ✔ | can get it from v2.shop_flash_sale.get_time_slot_id API, and you can only use the timeslot which start_time > now |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ timeslot_id` | int64 |  |
| `↳ flash_sale_id` | int64 |  |
| `↳ status` | int32 | the status of shop flash sale 0: deleted 1: enabled 2: disabled 3: system_rejected |

Lỗi riêng: parse data failed · data not exist · parameter invalid · You don't have permission for the operation · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · shop flash sale already exist · not meet shop criteria · The Wrong parameters, detail: {msg}.

## v2.shop_flash_sale.get_item_criteria
`GET /api/v2/shop_flash_sale/get_item_criteria` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

get shop flash sale item criteria

Lịch sử cập nhật: 2024-09-19: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ criteria` | object[] | criteria detail |
| `↳↳ criteria_id` | int64 |  |
| `↳↳ min_product_rating` | float | Product Rating(0.0-5.0), -1 means no limit |
| `↳↳ min_likes` | int32 | Likes(s), -1 means no limit |
| `↳↳ must_not_pre_order` | boolean | Pre-Order(s) |
| `↳↳ min_order_total` | int32 | Orders in the last 30 day(s), -1 means no limit |
| `↳↳ max_days_to_ship` | int32 | Days to Ship, -1 means no limit |
| `↳↳ min_repetition_day` | int32 | Repetition Control (Same Product cannot Join ISFS within N Days) , -1 means no limit |
| `↳↳ min_promo_stock` | int32 | Promo Stock, -1 means no limit |
| `↳↳ max_promo_stock` | int32 | Promo Stock, -1 means no limit |
| `↳↳ min_discount` | int64 | Discount Limit, 10 means 10%, -1 means no limit |
| `↳↳ max_discount` | int64 | Discount Limit, 100 means 100%, -1 means no limit |
| `↳↳ min_discount_price` | int64 | Discount Limit, -1 means no limit, real min discount price = min_discount_price / 100000 |
| `↳↳ max_discount_price` | int64 | Discount Limit, -1 means no limit, real max discount price = max_discount_price / 100000 |
| `↳↳ need_lowest_price` | boolean | lower than lowest price in last 7 days (exclude Shopee Flash Deals) |
| `↳ pair_ids` | object[] | the mapping relationship between criteria and category |
| `↳↳ criteria_id` | int64 |  |
| `↳↳ category_list` | object[] | these are the categories that the shop has items, and the criteria will apply to these categories |
| `↳↳↳ category_id` | int64 | o means this is All category |
| `↳↳↳ name` | string | category name |
| `↳↳↳ parent_id` | int64 | the parent category id, 0 means this category is L1 category |
| `↳ overlap_block_category_ids` | int64[] | Due to regulations, the promotion of some products in these categories are prohibited in this region |

Lỗi riêng: parse data failed · data not exist · parameter invalid · You don't have permission for the operation · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · The Wrong parameters, detail: {msg}.

## v2.shop_flash_sale.add_shop_flash_sale_items
`POST /api/v2/shop_flash_sale/add_shop_flash_sale_items` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

add shop flash sale item

Lịch sử cập nhật: 2025-01-10: Support single item; 2024-09-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `flash_sale_id` | int64 | ✔ |  |
| `items` | object[] | ✔ |  |
| `↳ item_id` | int64 | ✔ |  |
| `↳ purchase_limit` | int32 | ✔ | min=0, 0 means no limit |
| `↳ models` | object[] |  | If the item has variation, this param is necessary. |
| `↳↳ model_id` | int64 | ✔ | If the item has variation, this param is necessary. |
| `↳↳ input_promo_price` | float | ✔ | promotion price without tax |
| `↳↳ stock` | int32 | ✔ | min=1, Campaign Stock, Campaign stock can only be reserved from either Shopee stock or Seller stock |
| `↳ item_input_promo_price` | float |  | promotion price without tax of the item. If the item has no variation, this param is necessary, otherwise don't use this field |
| `↳ item_stock` | int32 |  | min=1, The campaign stock of the item. If the item has no variation, this param is necessary, otherwise don't use this field |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ failed_items` | object[] |  |
| `↳↳ item_id` | int64 |  |
| `↳↳ model_id` | int64 | If the item has no variation, this field will be empty |
| `↳↳ err_code` | int32 |  |
| `↳↳ err_msg` | string | the reason why the model cannot be added |
| `↳↳ unqualified_conditions` | object[] | if model or item doesn't meet a criteria, will show the detail in this field |
| `↳↳↳ unqualified_code` | int32 | error code for unqualified item |
| `↳↳↳ unqualified_msg` | string | error message for unqualified item |

Lỗi riêng: parse data failed · data not exist · parameter invalid · You don't have permission for the operation · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · exceed the max number of item limit per promotion · cannot enabled more than 50 items · this shop flash sale is not enabled or upcoming · shop flash sale not exist · The Wrong parameters, detail: {msg}.

## v2.shop_flash_sale.get_shop_flash_sale_list
`GET /api/v2/shop_flash_sale/get_shop_flash_sale_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

get shop flash sale list

Lịch sử cập nhật: 2024-09-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `type` | int32 | ✔ | you can use this filed to search different state of shop flash sale 0: all state 1: upcoming state 2: ongoing state 3: expired state |
| `start_time` | timestamp |  | you should use start_time and end_time together, and start_time shoule be < end_time |
| `end_time` | timestamp |  | you should use start_time and end_time together, and start_time shoule be < end_time |
| `offset` | int64 | ✔ | min=0,max=1000 |
| `limit` | int64 | ✔ | min=1,max=100 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ total_count` | int64 | the number of shop flash sale that the shop has |
| `flash_sale_list` | object[] |  |
| `↳ timeslot_id` | int64 |  |
| `↳ flash_sale_id` | int64 |  |
| `↳ status` | int32 | the status of shop flash sale 0: deleted 1: enabled 2: disabled 3: system_rejected, you cannot edit the shop flash sale in 'system_rejected' status |
| `↳ start_time` | timestamp | the start time of shop flash sale |
| `↳ end_time` | timestamp | the end time of shop flash sale |
| `↳ enabled_item_count` | int32 | the number of enabled items in shop flash sale |
| `↳ item_count` | int32 | the number of items in shop flash sale |
| `↳ type` | int32 | the state of shop flash sale 1: upcoming 2: ongoing 3: expired |
| `↳ remindme_count` | int64 | No. of Reminders Set |
| `↳ click_count` | int64 | No. of Product Clicks |

Lỗi riêng: parse data failed · data not exist · parameter invalid · You don't have permission for the operation · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · The Wrong parameters, detail: {msg}.

## v2.shop_flash_sale.get_shop_flash_sale
`GET /api/v2/shop_flash_sale/get_shop_flash_sale` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

get shop flash sale detail

Lịch sử cập nhật: 2024-09-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `flash_sale_id` | int64 | ✔ |  |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ timeslot_id` | int64 |  |
| `↳ flash_sale_id` | int64 |  |
| `↳ status` | int32 | the status of shop flash sale 0: deleted 1: enabled 2: disabled |
| `↳ start_time` | timestamp | the start time of shop flash sale |
| `↳ end_time` | timestamp | the end time of shop flash sale |
| `↳ enabled_item_count` | int32 | the number of enabled items in shop flash sale |
| `↳ item_count` | int32 | the number of items in shop flash sale |
| `↳ type` | int32 | the state of shop flash sale 1: upcoming 2: ongoing 3: expired |

Lỗi riêng: parse data failed · data not exist · parameter invalid · You don't have permission for the operation · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · shop flash sale not exist · The Wrong parameters, detail: {msg}.

## v2.shop_flash_sale.get_shop_flash_sale_items
`GET /api/v2/shop_flash_sale/get_shop_flash_sale_items` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

get shop flash sale items and item detail

Lịch sử cập nhật: 2025-01-10: Support single item; 2024-09-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `flash_sale_id` | int64 | ✔ |  |
| `offset` | int64 | ✔ | min=0,max=1000 |
| `limit` | int64 | ✔ | min=1,max=100 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ total_count` | int64 |  |
| `↳ models` | object[] | If the item has variation, the infomation of model will be in this field |
| `↳↳ item_id` | int64 |  |
| `↳↳ model_id` | int64 |  |
| `↳↳ model_name` | string |  |
| `↳↳ status` | int32 | the status of model in shop flash sale 0: disable 1: enable 2: delete 4: system_rejected, the model is rejected by system 5: manual_rejected, the model is rejected manually |
| `↳↳ original_price` | float |  |
| `↳↳ input_promotion_price` | float | promotion price without tax |
| `↳↳ promotion_price_with_tax` | float | promotion price with tax |
| `↳↳ purchase_limit` | int64 | 0 means NO LIMIT |
| `↳↳ campaign_stock` | int64 |  |
| `↳↳ stock` | int64 | Active inventory |
| `↳↳ reject_reason` | string | if the status is 4 or 5, this field will show the reason why this model was rejected |
| `↳↳ unqualified_conditions` | object | if the model doesn't meet a criteria, will show the detail in this field |
| `↳↳↳ unqualified_code` | int32 |  |
| `↳↳↳ unqualified_msg` | string |  |
| `↳ item_info` | object[] |  |
| `↳↳ item_id` | int64 |  |
| `↳↳ item_name` | string |  |
| `↳↳ status` | int32 | item status 0: Deleted 1: Normal 2: reviewing 3: banned 4: invalid 5: invalid hide 6: offensive hide 7: auditing 8: normal unlist |
| `↳↳ image` | string | item image |
| `↳↳ item_status` | int32 | the status of item in shop flash sale. If the item has variation, this field will be empty 0: disable 1: enable 2: delete 4: system_rejected, the item is rejected by system 5: manual_rejected, the item is rejected manually |
| `↳↳ original_price` | float | original price of item, if the item has variation, this field will be empty |
| `↳↳ input_promotion_price` | float | promotion price without tax of item, if the item has variation, this field will be empty |
| `↳↳ promotion_price_with_tax` | float | promotion price with tax of item, if the item has no variation, this field will has value |
| `↳↳ purchase_limit` | int64 | 0 means NO LIMIT purchase limit of item, if the item has variation, this field will be empty |
| `↳↳ campaign_stock` | int64 | campaign stock of item, if the item has no variation, this field will has value |
| `↳↳ stock` | int64 | Active inventory of item, if the item has no variation, this field will has value |
| `↳↳ reject_reason` | string | if the item_status is 4 or 5, this field will show the reason why this item was rejected if the item has variation, this field will be empty |
| `↳↳ unqualified_conditions` | object | if the item doesn't meet a criteria, will show the detail in this field if the item has variation, this field will be empty |
| `↳↳↳ unqualified_code` | int32 |  |
| `↳↳↳ unqualified_msg` | string |  |

Lỗi riêng: parse data failed · data not exist · parameter invalid · You don't have permission for the operation · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · shop flash sale not exist · The Wrong parameters, detail: {msg}.

## v2.shop_flash_sale.update_shop_flash_sale
`POST /api/v2/shop_flash_sale/update_shop_flash_sale` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

edit shop flash sale(enable, disable)

Lịch sử cập nhật: 2024-09-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `flash_sale_id` | int64 | ✔ |  |
| `status` | int32 | ✔ | the status of shop flash sale you want to set, you cannot edit the shop flash sale in 'system_rejected' status Disabling this Flash Sale will disable all items in this session 1: enable 2: disbaled |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ timeslot_id` | int64 |  |
| `↳ flash_sale_id` | int64 |  |
| `↳ status` | int32 | the status of shop flash sale 0: deleted 1: enabled 2: disabled 3: system_rejected, you cannot edit the shop flash sale in 'system_rejected' status |

Lỗi riêng: parse data failed · data not exist · parameter invalid · You don't have permission for the operation · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · shop flash sale not exist · The Wrong parameters, detail: {msg}.

## v2.shop_flash_sale.update_shop_flash_sale_items
`POST /api/v2/shop_flash_sale/update_shop_flash_sale_items` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

edit shop flash sale item, you can only edit the models in disbaled or enabled status

Lịch sử cập nhật: 2025-01-10: Support single item; 2024-09-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `flash_sale_id` | int64 | ✔ |  |
| `items` | object[] | ✔ |  |
| `↳ item_id` | int64 | ✔ |  |
| `↳ purchase_limit` | int32 |  | min=0, 0 means no limit if the item is in enabled status or the item has models in enabled status, you can't set this field |
| `↳ models` | object[] |  | If the item has variation, this param is necessary, otherwise please don't use this field |
| `↳↳ model_id` | int64 | ✔ | If the item has variation, this param is necessary. |
| `↳↳ status` | int32 | ✔ | you can use this field to set the status of model 0: disable 1: enable |
| `↳↳ input_promo_price` | float |  | promotion price without tax if the model is enabled(status = 1) now, you can't set this field, you can only disable the model if the model is disabled(status = 0) now and you want to set this field, you should also set status to 1 |
| `↳↳ stock` | int32 |  | min=1, Campaign Stock, Campaign stock can only be reserved from either Shopee stock or Seller stock if the model is enabled(status = 1) now, you can't set this field, you can only disable the model if the model is disabled(status = 0) now and you want to set this field, you should also set status to 1 |
| `↳ item_status` | int32 |  | The status of the item. If the item has no variation, this param is necessary, otherwise don't use this field you can use this field to set the status of item 0: disable 1: enable |
| `↳ item_input_promo_price` | float |  | The promotion price of the item. If the item has no variation, you can use this field to update the promotion price of the item, otherwise don't use this field if the item is enabled(item_status = 1) now, you can't set this field, you can only disable the item if the item is disabled(item_status = 0) now and you want to set this field, you should also set item_status to 1 |
| `↳ item_stock` | int32 |  | min=1, The campaign stock of the item. If the item has no variation, you can use this field to update the campaign stock of the item, otherwise don't use this field if the item is enabled(item_status = 1) now, you can't set this field, you can only disable the item if the item is disabled(item_status = 0) now and you want to set this field, you should also set item_status to 1 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ failed_items` | object[] |  |
| `↳↳ item_id` | int64 |  |
| `↳↳ model_id` | int64 | If the item has no variation, this field will be empty |
| `↳↳ err_code` | int32 |  |
| `↳↳ err_msg` | string | the reason why the model cannot be added |
| `↳↳ unqualified_conditions` | object[] | if the model doesn't meet a criteria, will show the detail in this field |
| `↳↳↳ unqualified_code` | int32 |  |
| `↳↳↳ unqualified_msg` | string |  |

Lỗi riêng: parse data failed · data not exist · parameter invalid · You don't have permission for the operation · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · this shop flash sale is not enabled or upcoming · shop flash sale not exist · The Wrong parameters, detail: {msg}. · Shop in holiday mode · shop is inactive

## v2.shop_flash_sale.delete_shop_flash_sale
`POST /api/v2/shop_flash_sale/delete_shop_flash_sale` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

delete shop flash sale

Lịch sử cập nhật: 2024-09-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `flash_sale_id` | int64 | ✔ | cannot delete ongoing and expired shop flash sale |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ timeslot_id` | int64 |  |
| `↳ flash_sale_id` | int64 |  |
| `↳ status` | int32 | the status of shop flash sale 0: deleted 1: enabled 2: disabled 3: system_rejected |

Lỗi riêng: parse data failed · data not exist · parameter invalid · You don't have permission for the operation · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · shop flash sale not exist · The Wrong parameters, detail: {msg}.

## v2.shop_flash_sale.delete_shop_flash_sale_items
`POST /api/v2/shop_flash_sale/delete_shop_flash_sale_items` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

delete shop flash sale items

Lịch sử cập nhật: 2025-01-10: Support single item; 2024-09-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `flash_sale_id` | int64 | ✔ |  |
| `item_ids` | int64[] | ✔ | if you delete a item, will delete all models of the item |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ failed_items` | object[] |  |
| `↳↳ item_id` | int64 |  |
| `↳↳ model_id` | int64 | If the item has no variation, this field will be empty |
| `↳↳ err_code` | int32 |  |
| `↳↳ err_msg` | string | the reason why the model cannot be added |
| `↳↳ unqualified_conditions` | object[] | if the model doesn't meet a criteria, will show the detail in this field |
| `↳↳↳ unqualified_code` | int32 |  |
| `↳↳↳ unqualified_msg` | string |  |

Lỗi riêng: parse data failed · data not exist · parameter invalid · You don't have permission for the operation · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · this shop flash sale is not enabled or upcoming · shop flash sale not exist · The Wrong parameters, detail: {msg}. · Shop in holiday mode · shop is inactive

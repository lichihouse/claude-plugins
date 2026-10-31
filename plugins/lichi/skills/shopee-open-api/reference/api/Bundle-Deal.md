# Module Bundle Deal (10 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.bundle_deal.add_bundle_deal
`POST /api/v2/bundle_deal/add_bundle_deal` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

create bundle deal. Relevant restrictions refer to FAQ：https://open.shopee.com/faq/254

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-08-29: add additional_tiers; 2022-07-26: Add Error Example information; 2022-06-29: Optimize the Sample information of Request Parameter and Response Parameter; 2021-04-25: update

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `rule_type` | int32 | ✔ | The bundle deal rule type：FIX_PRICE = 1 ；DISCOUNT_PERCENTAGE = 2； DISCOUNT_VALUE = 3 |
| `discount_value` | float | ✔ | The deducted price when when buying a bundle deal. Need to input it when the bundle deal rule type is 3 |
| `fix_price` | float | ✔ | The amount of the buyer needs to spend to purchase a bundle deal. Need to input it when the bundle deal rule type is 1 |
| `discount_percentage` | int32 | ✔ | The discount that the buyer can get when buying a bundle deal. Need to input it when the bundle deal rule type is 2 |
| `min_amount` | int32 | ✔ | The quantity of items that need buyer to combine purchased |
| `start_time` | timestamp | ✔ | The time when bundle deal activity start.The start time must be later than current time. |
| `end_time` | timestamp | ✔ | The time when bundle deal activity end. The end time must be 1 hour later than start time. |
| `name` | string | ✔ | Title of the bundle deal |
| `purchase_limit` | int32 | ✔ | Maximum number of bundle deals that can be bought by a buyer. |
| `additional_tiers` | object[] |  | Use to create tiered discount for bundle deals, a max of 2 additional tiers are allowed to create. the rule of multiple tiers needs to follow this faq https://open.shopee.com/faq/53 For additional tiers, the fix price, discount_percentage, discount_value should be consistent with tier 1 |
| `↳ min_amount` | int32 | ✔ | The quantity of items that the buyers need to purchase for additional tier |
| `↳ fix_price` | float |  | The bundle price when the buyers purchase a bundle deal for additional tiers. Need to input it when the bundle deal rule type is 1. |
| `↳ discount_value` | float |  | The bundle deal discount amount the buyer can save when purchasing a bundle deal. Need to input it when the bundle deal rule type is 3 |
| `↳ discount_percentage` | int32 |  | The bundle deal discount% that the buyer can get when buying a bundle deal for additional tiers. Need to input it when the bundle deal rule type is 2 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ bundle_deal_id` | int32 | Shopee's unique identifier for a bundle deal activity. |

Lỗi riêng: This item doesn't has shipping channel, please set shipping channel firstly · This product is under a category that is prohibited from promotions due to regulations in your country · Discount value should be within Price range. · Promotion start time can only be changed to a later timing. · A maximum of 1000 bundle deals can be created · Unknown error occurred in the service · The bundle deal end time must earlier than the max allowed current time · Fix price should be within Price range. · Higher tier should have a higher or same discount or bundle price · Higher tier discount must be equivalent or greater than lower tier · Higher tier should have lower price per item (price per item = fixed bundle price / item amount) · Cannot create multi-tier bundle deals · Name length can't be less than 1 or greater than 25 · Cannot change rule_type, fix_price, discount_percentage, discount_value or tiers number if Bundle deal is ongoing. · Cannot change min_amount if Bundle deal is ongoing and has enabled items

## v2.bundle_deal.add_bundle_deal_item
`POST /api/v2/bundle_deal/add_bundle_deal_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

add product to bundle deal

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-04-25: update; 2021-04-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `bundle_deal_id` | int32 | ✔ | Shopee's unique identifier for a bundle deal activity. |
| `item_list` | object[] | ✔ | The items added in this bundle deal promotion. |
| `↳ item_id` | int32 | ✔ | Shopee's unique identifier for an item. |
| `↳ status` | int32 | ✔ | The status of bundle deal item：enable = 1；disable =0 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ failed_list` | object[] | Indicate error details. |
| `↳↳ item_id` | int32 | Shopee's unique identifier for an item. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |
| `↳ success_list` | object[] | The list of succeed added items |

Lỗi riêng: This product does not share a common shipping channel with the first enabled product. · This product does not set shipping channel. · bundle deal item has no common logistics · There are B2C items that can't be added into your promotion · Unknown error occurred in the service · The item is already added · The overall item level promotion limit has been reached. · Item status is abnormal · The item is already in add on deal · The item is already in other bundle deal · Insufficient item stock · A maximum of 1000 items in bundle deal can be created · The shopee created bundle deal can't be edited · Bundle deal doesn't existed · product id not exists

## v2.bundle_deal.get_bundle_deal_list
`GET /api/v2/bundle_deal/get_bundle_deal_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Customized APP, Swam ERP

get bundle deal list

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-08-29: add additional_tiers; 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-04-25: update

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_size` | int32 |  | Data paging, representing the data size of each page, the maximum is 1000, the default is 20 |
| `time_status` | int32 |  | The Status of bundle deal，all=1；upcoming=2；ongoing=3，expired=4 , the default is 1 |
| `page_no` | int32 |  | Data paging, represents the page number, starting from 1, the default is 1 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ bundle_deal_list` | object[] | The list of bundle deal id |
| `↳↳ bundle_deal_id` | int32 | Shopee's unique identifier for a bundle deal activity. |
| `↳↳ name` | string | Title of the bundle deal |
| `↳↳ start_time` | timestamp | The time when bundle deal activity start. |
| `↳↳ end_time` | timestamp | The time when bundle deal activity end. |
| `↳↳ bundle_deal_rule` | object |  |
| `↳↳↳ rule_type` | int32 | The bundle deal rule type：FIX_PRICE = 1 ；DISCOUNT_PERCENTAGE = 2； DISCOUNT_VALUE = 3 |
| `↳↳↳ discount_value` | float | The deducted price when when buying a bundle deal. Need to input it when the bundle deal rule type is 3 |
| `↳↳↳ fix_price` | float | The amount of the buyer needs to spend to purchase a bundle deal. Need to input it when the bundle deal rule type is 1 |
| `↳↳↳ discount_percentage` | int32 | The discount that the buyer can get when buying a bundle deal. Need to input it when the bundle deal rule type is 2 |
| `↳↳↳ min_amount` | int32 | The quantity of items that need buyer to combine purchased |
| `↳↳↳ additional_tiers` | object[] | Use to create tiered discount for bundle deals, a max of 2 additional tiers are allowed to create bundle deals like buy 2 get 10% off, buy 3 for 15% off, buy 4 for 20% off; For each tier, we will need to set the following 4 values based on bundle deal type + min_amount = IntAttribute() + fix_price = IntAttribute() + discount_percentage = IntAttribute() + discount_value = IntAttribute() Note: for additional tiers, the fix price, discount_percentage, discount_value should be consistent with tier 1 |
| `↳↳↳↳ min_amount` | int32 | The quantity of items that the buyers need to purchase for additional tier |
| `↳↳↳↳ fix_price` | float | The bundle price when the buyers purchase a bundle deal for additional tiers. Need to input it when the bundle deal rule type is 1. |
| `↳↳↳↳ discount_value` | float | The bundle deal discount amount the buyer can save when purchasing a bundle deal. Need to input it when the bundle deal rule type is 3 |
| `↳↳↳↳ discount_percentage` | int32 | The bundle deal discount% that the buyer can get when buying a bundle deal for additional tiers. Need to input it when the bundle deal rule type is 2 |
| `↳↳ purchase_limit` | int32 | Maximum number of bundle deals that can be bought by a buyer. |
| `↳ more` | boolean | this field shows whether there are more bundle deals in next page or not |

Lỗi riêng: Unknown error occurred in the service · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.bundle_deal.get_bundle_deal
`GET /api/v2/bundle_deal/get_bundle_deal` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Customized APP, Swam ERP

get bundle deal detail

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-08-29: add additional_tiers; 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-04-25: update

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `bundle_deal_id` | int32 | ✔ | Shopee's unique identifier for a bundle deal activity. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ bundle_deal_id` | int32 | Shopee's unique identifier for a bundle deal activity. |
| `↳ name` | string | Title of the bundle deal |
| `↳ start_time` | timestamp | The time when bundle deal activity start. |
| `↳ end_time` | timestamp | The time when bundle deal activity end. |
| `↳ bundle_deal_rule` | object |  |
| `↳↳ rule_type` | int32 | The bundle deal rule type：FIX_PRICE = 1 ；DISCOUNT_PERCENTAGE = 2； DISCOUNT_VALUE = 3 |
| `↳↳ discount_value` | float | The deducted price when when buying a bundle deal.Need to input it when the bundle deal rule type is 3 |
| `↳↳ fix_price` | float | The amount of the buyer needs to spend to purchase a bundle deal. Need to input it when the bundle deal rule type is 1 |
| `↳↳ discount_percentage` | int32 | The discount that the buyer can get when buying a bundle deal. Need to input it when the bundle deal rule type is 2 |
| `↳↳ min_amount` | int32 | The quantity of items that need buyer to combine purchased |
| `↳↳ additional_tiers` | object | Use to create tiered discount for bundle deals, a max of 2 additional tiers are allowed to create bundle deals like buy 2 get 10% off, buy 3 for 15% off, buy 4 for 20% off; For each tier, we will need to set the following 4 values based on bundle deal type + min_amount = IntAttribute() + fix_price = IntAttribute() + discount_percentage = IntAttribute() + discount_value = IntAttribute() Note: for additional tiers, the fix price, discount_percentage, discount_value should be consistent with tier 1 |
| `↳↳↳ min_amount` | int32 | The quantity of items that the buyers need to purchase for additional tier |
| `↳↳↳ fix_price` | float | The bundle price when the buyers purchase a bundle deal for additional tiers. Need to input it when the bundle deal rule type is 1. |
| `↳↳↳ discount_value` | float | The bundle deal discount amount the buyer can save when purchasing a bundle deal. Need to input it when the bundle deal rule type is 3 |
| `↳↳↳ discount_percentage` | int32 | The bundle deal discount% that the buyer can get when buying a bundle deal for additional tiers. Need to input it when the bundle deal rule type is 2 |
| `↳ purchase_limit` | int32 | Maximum number of bundle deals that can be bought by a buyer. |

Lỗi riêng: Unknown error occurred in the service · Bundle deal doesn't existed · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.bundle_deal.get_bundle_deal_item
`GET /api/v2/bundle_deal/get_bundle_deal_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Customized APP, Swam ERP

get bundle deal item

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-04-25: update; 2021-04-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `bundle_deal_id` | int32 | ✔ | Shopee's unique identifier for a bundle deal activity. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_list` | object[] | The list of bundle deal item |
| `↳↳ item_id` | int64 | Shopee's unique identifier for a bundle deal activity. |
| `↳↳ status` | int32 | The status of items：enable = 1，disable =0 |
| `↳ total_count` | int32 | The number of items in this bundle deal |

Lỗi riêng: Unknown error occurred in the service · Bundle deal doesn't existed · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.bundle_deal.update_bundle_deal
`POST /api/v2/bundle_deal/update_bundle_deal` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

update bundle deal. Relevant restrictions refer to FAQ：https://open.shopee.com/faq/254

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-08-29: add additional_tiers; 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-04-25: update

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `rule_type` | int32 |  | The bundle deal rule type：FIX_PRICE = 1 ；DISCOUNT_PERCENTAGE = 2； DISCOUNT_VALUE = 3 |
| `discount_value` | float |  | The deducted price when when buying a bundle deal. Need to input it when the bundle deal rule type is 3 |
| `fix_price` | float |  | The amount of the buyer needs to spend to purchase a bundle deal.Need to input it when the bundle deal rule type is 1 |
| `discount_percentage` | int32 |  | The discount that the buyer can get when buying a bundle deal. Need to input it when the bundle deal rule type is 2 |
| `min_amount` | int32 |  | The quantity of items that need buyer to combine purchased |
| `start_time` | timestamp |  | The time when bundle deal activity start.The start time must be later than current time. |
| `end_time` | timestamp |  | The time when bundle deal activity end. The end time must be later than current time. |
| `name` | string |  | Title of the bundle deal |
| `purchase_limit` | int32 |  | Maximum number of bundle deals that can be bought by a buyer. |
| `bundle_deal_id` | int32 | ✔ | Shopee's unique identifier for a bundle deal activity. |
| `additional_tiers` | object |  | Use to create tiered discount for bundle deals, a max of 2 additional tiers are allowed to create bundle deals like buy 2 get 10% off, buy 3 for 15% off, buy 4 for 20% off; For each tier, we will need to set the following 4 values based on bundle deal type + min_amount = IntAttribute() + fix_price = IntAttribute() + discount_percentage = IntAttribute() + discount_value = IntAttribute()Note: for additional tiers, the fix price, discount_percentage, discount_value should be consistent with tier 1 |
| `↳ min_amount` | int32 | ✔ | The quantity of items that the buyers need to purchase for additional tier |
| `↳ fix_price` | float |  | The bundle price when the buyers purchase a bundle deal for additional tiers. Need to input it when the bundle deal rule type is 1. |
| `↳ discount_value` | float |  | The bundle deal discount amount the buyer can save when purchasing a bundle deal. Need to input it when the bundle deal rule type is 3 |
| `↳ discount_percentage` | int32 |  | The bundle deal discount% that the buyer can get when buying a bundle deal for additional tiers. Need to input it when the bundle deal rule type is 2 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ bundle_deal_id` | int32 | Shopee's unique identifier for a bundle deal activity. |
| `↳ name` | string | Title of the bundle deal |
| `↳ start_time` | timestamp | The time when bundle deal activity start. |
| `↳ end_time` | timestamp | The time when bundle deal activity end. |
| `↳ bundle_deal_rule` | object |  |
| `↳↳ rule_type` | int32 | The bundle deal rule type：FIX_PRICE = 1 ；DISCOUNT_PERCENTAGE = 2； DISCOUNT_VALUE = 3 |
| `↳↳ discount_value` | float | The deducted price when when buying a bundle deal. Need to input it when the bundle deal rule type is 3 |
| `↳↳ fix_price` | float | The amount of the buyer needs to spend to purchase a bundle deal. Need to input it when the bundle deal rule type is 1 |
| `↳↳ discount_percentage` | int32 | The discount that the buyer can get when buying a bundle deal. Need to input it when the bundle deal rule type is 2 |
| `↳↳ min_amount` | int32 | The quantity of items that need buyer to combine purchased |
| `↳↳ additional_tiers` | object[] | Use to create tiered discount for bundle deals, a max of 2 additional tiers are allowed to create bundle deals like buy 2 get 10% off, buy 3 for 15% off, buy 4 for 20% off; For each tier, we will need to set the following 4 values based on bundle deal type + min_amount = IntAttribute() + fix_price = IntAttribute() + discount_percentage = IntAttribute() + discount_value = IntAttribute()Note: for additional tiers, the fix price, discount_percentage, discount_value should be consistent with tier 1 |
| `↳↳↳ min_amount` | int32 | The quantity of items that the buyers need to purchase for additional tier |
| `↳↳↳ fix_price` | float | The bundle price when the buyers purchase a bundle deal for additional tiers. Need to input it when the bundle deal rule type is 1. |
| `↳↳↳ discount_value` | float | The bundle deal discount amount the buyer can save when purchasing a bundle deal. Need to input it when the bundle deal rule type is 3 |
| `↳↳↳ discount_percentage` | int32 | The bundle deal discount% that the buyer can get when buying a bundle deal for additional tiers. Need to input it when the bundle deal rule type is 2 |
| `↳ purchase_limit` | int32 | Maximum number of bundle deals that can be bought by a buyer. |

Lỗi riêng: Discount value should be within Price range. · Promotion end time can only be changed to an earlier timing. · Unknown error occurred in the service · The bundle deal end time must earlier than the max allowed current time · Fix price should be within Price range. · Higher tier should have lower price per item (price per item = fixed bundle price / item amount) · Cannot create multi-tier bundle deals · Name length can't be less than 1 or greater than 25 · The shopee created bundle deal can't be edited · Bundle deal doesn't existed · Cannot change rule_type, fix_price, discount_percentage, discount_value or tiers number if Bundle deal is ongoing. · Cannot change min_amount if Bundle deal is ongoing and has enabled items · The item amount can't exceed 3000 · Max bundle tier allowed is 3 · The rule type of ongoing bundle deal can't be edited

## v2.bundle_deal.update_bundle_deal_item
`POST /api/v2/bundle_deal/update_bundle_deal_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

update product in bundle deal

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-04-25: update; 2021-04-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `bundle_deal_id` | int64 | ✔ | Shopee's unique identifier for a bundle deal activity. |
| `item_list` | object[] | ✔ | The items added in this bundle deal promotion. |
| `↳ item_id` | int64 | ✔ | Shopee's unique identifier for an item. |
| `↳ status` | int32 | ✔ | The status of bundle deal item：enable = 1；disable =0 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ failed_list` | object[] | Indicate error details. |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |
| `↳ success_list` | object[] | The list of succeed added items |

Lỗi riêng: This product does not share a common shipping channel with the first enabled product. · This product does not set shipping channel. · This product does not set shipping channel. · bundle deal item has no common logistics · There are B2C items that can't be added into your promotion · Unknown error occurred in the service · Please update item of bundel deal · The overall item level promotion limit has been reached. · Item status is abnormal · The item is already in add on deal · The item is already in other bundle deal · Insufficient item stock · The shopee created bundle deal can't be edited · Bundle deal doesn't existed · product id not exists

## v2.bundle_deal.end_bundle_deal
`POST /api/v2/bundle_deal/end_bundle_deal` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

end bundle deal

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-04-25: update; 2021-04-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `bundle_deal_id` | int32 | ✔ | Shopee's unique identifier for a bundle deal activity. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ bundle_deal_id` | int32 | Shopee's unique identifier for a bundle deal activity. |

Lỗi riêng: Unknown error occurred in the service · The shopee created bundle deal can't be edited · Bundle deal doesn't existed · Only the ongoing bundle deal can be ended · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.bundle_deal.delete_bundle_deal
`POST /api/v2/bundle_deal/delete_bundle_deal` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

delete bundle deal

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-04-25: update; 2021-04-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `bundle_deal_id` | int32 | ✔ | Shopee's unique identifier for a bundle deal activity. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ bundle_deal_id` | int32 | Shopee's unique identifier for a bundle deal activity. |

Lỗi riêng: Only the upcoming bundle deal can be deleted · Unknown error occurred in the service · The shopee created bundle deal can't be edited · Bundle deal doesn't existed · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.bundle_deal.delete_bundle_deal_item
`POST /api/v2/bundle_deal/delete_bundle_deal_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

delete product in bundle deal

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-04-25: update; 2021-04-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `bundle_deal_id` | int32 | ✔ | Shopee's unique identifier for a bundle deal activity. |
| `item_list` | object[] | ✔ | The items deleted in this bundle deal promotion. |
| `↳ item_id` | int32 | ✔ | Shopee's unique identifier for an item. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ failed_list` | object[] | Indicate error details. |
| `↳↳ item_id` | int32 | Shopee's unique identifier for an item. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |
| `↳ success_list` | object[] | The list of succeed added items |

Lỗi riêng: The item is not exist or abnormal · Unknown error occurred in the service · The expired item in bundle deal can't be delete · The shopee created bundle deal can't be edited · Bundle deal doesn't existed · Failed to set bundle deal item · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

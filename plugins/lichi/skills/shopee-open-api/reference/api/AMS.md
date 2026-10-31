# Module AMS (36 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.ams.get_open_campaign_added_product
`GET /api/v2/ams/get_open_campaign_added_product` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve all products currently in the Open Campaign, including campaign status, commission rate, and promotion period

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. |
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "" or not passed. If data is more than one page, the cursor can be some entry to start next call. |
| `sort_by` | string |  | Use this field to specify which field to use to sort the returned item list. Sort by update_time and commission_id in descending order by default. Available values: commission_rate: Sort by commission_rate in ascending order -commission_rate: Sort by commission_rate in descending order |
| `search_type` | string |  | Search type: ITEM_NAME or ITEM_ID |
| `search_content` | string |  | Search for item_name or item_id, item_id should be split by comma and at most 50 items. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_list` | object[] |  |
| `↳↳ item_id` | int64 | Item ID |
| `↳↳ item_name` | string | Item Name |
| `↳↳ campaign_id` | int64 | Campaign ID |
| `↳↳ campaign_status` | string | Campaign Status: Upcoming Ongoing Terminating |
| `↳↳ commission_rate` | float | Commission Rate, 1.1 means 1.1%, support two decimal places |
| `↳↳ period_start_time` | timestamp | Period Start Time |
| `↳↳ period_end_time` | timestamp | Period End Time, if get 32503651199 (2999-12-31 23:59:59), it means no limit |
| `↳↳ pending_terminated_time` | timestamp | Pending Terminated Time |
| `↳↳ commission_protection_list` | object[] | Commission Protection List |
| `↳↳↳ commission_rate` | float | Commission Rate, 1.1 means 1.1%, support two decimal places |
| `↳↳↳ protection_period_end_time` | timestamp | Protection Period End Time |
| `↳↳ max_commission_rate_current_day` | float | Max Commission Rate Current Day, 1.1 means 1.1%, support two decimal places |
| `↳ total_count` | int32 | Total number of items that match the condition |
| `↳ cursor` | string | Pass the content in the next request as cursor to get the next page data |
| `↳ has_more` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve orders. |

Lỗi riêng: Something wrong. Please try later. · Invalid cursor. The cursor of first page is not passed or blank string, and subsequent pages are passed to the cursor in the response. · item_id_list is blank or exceeded max limit. · invalid limit · invalid page_size · invalid param · invalid search_content · invalid search_type · invalid sort_by type · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.get_open_campaign_not_added_product
`GET /api/v2/ams/get_open_campaign_not_added_product` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve eligible products not yet added to the Open Campaign

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. |
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "" or not passed. If data is more than one page, the cursor can be some entry to start next call. |
| `sort_by` | string |  | Use this field to specify which field to use to sort the returned item list. Available values: -sales: Sort by sales in descending order (default value) sales: Sort by sales in ascending order -stock: Sort by inventory in descending order stock: Sort by inventory in ascending order -price: Sort by price in descending order price: Sort by price in ascending order |
| `search_type` | string |  | Search type: ITEM_ID or ITEM_NAME |
| `search_content` | string |  | Search for item name or item id. item id should be split by comma and at most 50 items. When search_content is passed, search_type is required. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_list` | object[] |  |
| `↳↳ item_id` | int64 | Item ID |
| `↳↳ item_name` | string | Item name |
| `↳↳ sales` | int64 | Item sales |
| `↳↳ display_price` | string | Item display price |
| `↳↳ stock` | int64 | Item stock |
| `↳↳ is_in_blacklist` | boolean | If item is in blacklist, it cannot set up open campaign |
| `↳↳ with_open_campaign` | boolean | If item already has open campaign, it cannot set up another open campaign The item list may be delayed, so it is used to further filter items that already have open campaigns |
| `↳ total_count` | int32 | Total number of items that match the condition |
| `↳ cursor` | string | Pass the content in the next request as cursor to get the next page data |
| `↳ has_more` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve orders. |

Lỗi riêng: Something wrong. Please try later. · Invalid cursor. The cursor of first page is not passed or blank string, and subsequent pages are passed to the cursor in the response. · item_id_list is blank or exceeded max limit. · invalid page_size · invalid param · invalid search_content · invalid search_type · invalid sort_by type · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.batch_add_products_to_open_campaign
`POST /api/v2/ams/batch_add_products_to_open_campaign` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Batch add products to the Open Campaign for a given list of product IDs

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id_list` | int64[] | ✔ | The list of item_id, max limit: 50 |
| `commission_rate` | float | ✔ | Commission Rate, 1.1 means 1.1%, support two decimal places |
| `period_start_time` | timestamp |  | Period start time, in seconds, if missing, will set 10 minutes later |
| `period_end_time` | timestamp |  | Period end time, in seconds, if missing, will set 32503651199 (2999-12-31 23:59:59) represent of no limit |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ failed_list` | object[] |  |
| `↳↳ item_id` | int64 | Item ID |
| `↳↳ fail_error` | string | Fail Error |
| `↳↳ fail_message` | string | Fail Message |
| `↳ success_list` | int64[] | Success Item ID List |

Lỗi riêng: Partitial success, please check detail reason · The commission rate exceeds the cap. · The commission rate is above the higher limit. · The commission rate is below the lower limit. · An open campaign item already exists. · Total fail, please check · Something wrong. Please try later. · invalid commission_rate · invalid item_id, detail:{} · item_id_list is blank or exceeded max limit. · invalid param · invalid period_end_time · invalid period_start_time · Invalid period time. Campaign should last at least 7 full days to have a smooth and effective promotion. · The item is invalid.

## v2.ams.add_all_products_to_open_campaign
`POST /api/v2/ams/add_all_products_to_open_campaign` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Add all eligible products into the Open Campaign. We will only return the general error that caused the whole task failure, without returning the specific error for each product in the v2.ams.get_open_campaign_batch_task_result API. If you want to get the result for each products, you can use v2.ams.batch_add_products_to_open_campaign by pagination manually, or check the product status by using the GET API after the task progress turn to 100%.

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `commission_rate` | float | ✔ | Commission Rate, 1.1 means 1.1%, support two decimal places |
| `period_start_time` | timestamp |  | Period start time, in seconds, if missing, will set 10 minutes later |
| `period_end_time` | timestamp |  | Period end time, in seconds, if missing, will set 32503651199 ( 2999-12-31 23:59:59 ) represent of no limit |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ task_type` | string | Task type. Applicable values: batch_add_open_campaigns batch_remove_open_campaigns batch_update_open_campaigns For this API, task type will be batch_add_open_campaigns |
| `↳ task_id` | string | Task id, used to query task progress when calling v2.ams.get_open_campaign_batch_task_result API |

Lỗi riêng: Something wrong. Please try later. · invalid commission_rate · invalid param · invalid period_end_time · invalid period_start_time · Invalid period time. Campaign should last at least 7 full days to have a smooth and effective promotion. · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.get_auto_add_new_product_toggle_status
`GET /api/v2/ams/get_auto_add_new_product_toggle_status` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Check if auto-add new product is currently enabled

Lịch sử cập nhật: -: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ is_open` | boolean | If auto-add new product is currently enabled |
| `↳ commission_rate` | float | Commission Rate, 1.11 means 1.11%, support two decimal places |

Lỗi riêng: Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.update_auto_add_new_product_setting
`POST /api/v2/ams/update_auto_add_new_product_setting` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Change auto-add toggle and default commission rate setting

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `open` | boolean | ✔ | Enable or disable auto-add new product, if true is passed, it means enabled, if false is passed, it means disabled |
| `commission_rate` | float |  | Commission rate, 1.1 means 1.1%, support two decimal places |

Lỗi riêng: invalid commission_rate · invalid open · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.batch_edit_products_open_campaign_setting
`POST /api/v2/ams/batch_edit_products_open_campaign_setting` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Batch update open campaign settings for a given list of product IDs

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_ids` | int64[] | ✔ | The list of campaign_id, max limit: 50 |
| `commission_rate` | float |  | Commission Rate, 1.1 means 1.1%, support two decimal places |
| `period_start_time` | timestamp |  | Period start time, in seconds, if missing, will skip and do not update Only allow to update on UPCOMING status, when in other status, will skip too |
| `period_end_time` | timestamp |  | Period end time, in seconds, if missing, will skip and do not update Can set 32503651199 to make period no limit |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ failed_list` | object[] |  |
| `↳↳ campaign_id` | int64 | Campaign ID |
| `↳↳ fail_error` | string | Fail error |
| `↳↳ fail_message` | string | Fail message |
| `↳ success_list` | int64[] | Success Campaign ID List |

Lỗi riêng: The commission rate cannot be reduced. · The commission rate exceeds the cap. · The commission rate is above the higher limit. · The commission rate is below the lower limit. · Something wrong. Please try later. · invalid campaign_id · campaign_ids is blank or exceeded max limit. · invalid commission_rate · invalid param · invalid period_end_time · invalid period_start_time · Invalid period time. Campaign should last at least 7 full days to have a smooth and effective promotion. · The item is invalid. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API.

## v2.ams.edit_all_products_open_campaign_setting
`POST /api/v2/ams/edit_all_products_open_campaign_setting` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Update for all products in the Open Campaign. We will only return the general error that caused the whole task failure, without returning the specific error for each product in the v2.ams.get_open_campaign_batch_task_result API. If you want to get the result for each products, you can use v2.ams.batch_edit_products_open_campaign_setting by pagination manually, or check the product status by using the GET API after the task progress turn to 100%.

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `commission_rate` | float |  | Commission Rate, 1.1 means 1.1%, support two decimal places, if miss, will skip and do not update |
| `period_start_time` | timestamp |  | Period start time, in seconds, if missing, will skip and do not update Only allow to update on UPCOMING status, when in other status, will skip too |
| `period_end_time` | timestamp |  | Period end time, in seconds, if missing, will skip and do not update Can set 32503651199 to make period no limit |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ task_type` | string | Task type. Applicable values: batch_add_open_campaigns batch_remove_open_campaigns batch_update_open_campaigns For this API, task type will be batch_update_open_campaigns |
| `↳ task_id` | string | Task id, used to query task progress when calling v2.ams.get_open_campaign_batch_task_result API |

Lỗi riêng: Partitial success, please check detail reason · Total fail, please check · Something wrong. Please try later. · campaign_ids is blank or exceeded max limit. · invalid commission_rate · invalid param · invalid period_end_time · invalid period_start_time · Invalid period time. Campaign should last at least 7 full days to have a smooth and effective promotion. · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.batch_remove_products_open_campaign_setting
`POST /api/v2/ams/batch_remove_products_open_campaign_setting` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Batch update products from Open Campaign for a given list of product IDs

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_ids` | int64[] | ✔ | The list of campaign_id, max limit: 50 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ failed_list` | object |  |
| `↳↳ campaign_id` | int64 | Campaign ID |
| `↳↳ fail_error` | string | Fail error |
| `↳↳ fail_message` | string | Fail message |
| `↳ success_list` | int64[] | Success Campaign ID List |

Lỗi riêng: Partitial success, please check detail reason · The campaign_id does not exist. · Total fail, please check · Something wrong. Please try later. · invalid campaign_id · campaign_ids is blank or exceeded max limit. · invalid param · The item is invalid. · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.remove_all_products_open_campaign_setting
`POST /api/v2/ams/remove_all_products_open_campaign_setting` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Remove the entire product list of Open Campaign. We will only return the general error that caused the whole task failure, without returning the specific error for each product in the v2.ams.get_open_campaign_batch_task_result API. If you want to get the result for each products, you can use v2.ams. batch_remove_products_open_campaign_setting by pagination manually, or check the product status by using the GET API after the task progress turn to 100%.

Lịch sử cập nhật: 2025-10-15: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ task_type` | string | Task type. Applicable values: batch_add_open_campaigns batch_remove_open_campaigns batch_update_open_campaigns For this API, task type will be batch_remove_open_campaigns |
| `↳ task_id` | string | Task id, used to query task progress when calling v2.ams.get_open_campaign_batch_task_result API |

Lỗi riêng: Something wrong. Please try later. · invalid param · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.get_open_campaign_batch_task_result
`GET /api/v2/ams/get_open_campaign_batch_task_result` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Get open campaign batch task result

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `task_id` | string | ✔ | Task id, used to query task progress |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ status` | string | Task status. Applicable values: Doing Done Fail Note: Please note that task Done here refers to the completion of scanning all products in the shop, but not the successful execution of all products. Some products may fail, but due to the unpredictable huge volume of data, detailed information will not returned in the fail_reason. After the task is Done , you need to retrieve the list again by GET API and compare it with the before list to confirm the execution details |
| `↳ progress_rate` | int32 | Progress rate, 80 means 80% |
| `↳ fail_reason` | string | Error message, if it is not empty, it means there is an error Will not return the detail error for each products, you can check the products detail by using GET API, or using the batch operate API |

Lỗi riêng: Something wrong. Please try later. · invalid param · invalid task_id · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.get_optimization_suggestion_product
`GET /api/v2/ams/get_optimization_suggestion_product` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve products with suggestions to improve performance

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 | ✔ | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data.The limit of page_size if between 1 and 100. |
| `rcmd_reason_filter` | string | ✔ | Recommended types. Applicable values: product_opportunities optimize_increase_commission_rate optimize_extend_promotion_period |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ item_list` | object[] |  |
| `↳↳ item_id` | int64 | Item ID |
| `↳↳ item_name` | string | Item Name |
| `↳↳ rcmd_reason` | string[] | Recommend reason. Applicable values: severe_shortage high_popularity optimize_commission_rate extend_time_period |
| `↳↳ campaign_id` | int64 | Campaign ID |
| `↳↳ commission_rate` | float | Commission Rate, 1.11 means 1.11%, support two decimal places |
| `↳↳ period_start_time` | timestamp | Period Start Time |
| `↳↳ period_end_time` | timestamp | Period End Time, if get 32503651199 (2999-12-31 23:59:59), it means no limit |
| `↳↳ affiliate_count` | int64 | The total number of affiliates who have ever shared the product in the last 90 days |
| `↳↳ item_sold` | int64 | If the requested rcmd_reason_filter is product_opportunition, it is represented as item sales. Other scenarios are the total number of item sold for each product of the shop through AMS in the last 90 days |
| `↳↳ campaign_status` | string | Campaign Status: Upcoming Ongoing Terminating |
| `↳↳ l2_category_order_count` | int64 | The total number of AMS orders for the product's L2 category in the last 30 days, only available when requested rcmd_reason_filter is product_opportunition |
| `↳↳ suggest_min_rate` | float | Minimum suggested commission rate, 1.1 means 1.1%, support two decimal places |
| `↳↳ suggest_max_rate` | float | Maximum suggested commission rate, 1.2 means 1.2%, support two decimal places |
| `↳↳ prefill_rate` | float | Prefill rate, 1.1 means 1.1%, support two decimal places |
| `↳↳ prefill_subsidy_rate` | float | Prefill subsidy rate, platform commission rate calculated based on seller commission, 1.2 means 1.2%, support two decimal places |
| `↳↳ display_price` | string | Display price |
| `↳↳ has_subsidy_data` | boolean | Has subsidy rate |
| `↳ total` | int32 | Total number of items that match the condition |
| `↳ has_more` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve orders. |

Lỗi riêng: invalid page_no · invalid page_size · invalid param · invalid rcmd_reason · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.batch_get_products_suggested_rate
`GET /api/v2/ams/batch_get_products_suggested_rate` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Fetch suggested rates for a given list of product IDs

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id_list` | string | ✔ | The list of item_id, different item id should be split by comma and at most 20 items |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ rates` | object[] |  |
| `↳↳ item_id` | int64 | Item ID |
| `↳↳ min_rate` | float | Minimum suggested commission rate, 1.1 means 1.1%, support two decimal places |
| `↳↳ max_rate` | float | Maximum suggested commission rate, 1.2 means 1.2%, support two decimal places |

Lỗi riêng: Something wrong. Please try later. · item_id_list is blank or exceeded max limit. · invalid param · invalid item_id_list · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.get_shop_suggested_rate
`GET /api/v2/ams/get_shop_suggested_rate` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve suggested rates for all eligible products

Lịch sử cập nhật: -: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ min_rate` | float | Minimum suggested commission rate, 1.1 means 1.1%, support two decimal places |
| `↳ max_rate` | float | Maximum suggested commission rate, 1.2 means 1.2%, support two decimal places |

Lỗi riêng: Something wrong. Please try later. · invalid param · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.get_targeted_campaign_addable_product_list
`GET /api/v2/ams/get_targeted_campaign_addable_product_list` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Returns a list of products that can be added to a targeted campaign

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. |
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "" or not passed. If data is more than one page, the cursor can be some entry to start next call. |
| `sort_by` | string |  | Use this field to specify which field to use to sort the returned item list. Available values: -sales: Sort by sales in descending order (default value) sales: Sort by sales in ascending order -stock: Sort by inventory in descending order stock: Sort by inventory in ascending order -price: Sort by price in descending order price: Sort by price in ascending order |
| `search_type` | string |  | Search type: ITEM_NAME or ITEM_ID, used with search_content. |
| `search_content` | string |  | Search by item name or item ID, item_id should be split by comma and at most 50 items. Please specify search_type for it to be effective, otherwise search_content will be ignored. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ item_list` | object[] | Item list. |
| `↳↳ item_id` | int64 | The unique key for item. |
| `↳↳ item_name` | string | The name of the current item. |
| `↳↳ sales` | int64 | The sold of the current item. |
| `↳↳ display_price` | string | The display_price of the current item. |
| `↳↳ stock` | int64 | The stock of the current item. |
| `↳↳ is_in_blacklist` | boolean | Is the current item in the blacklist. |
| `↳ total_count` | int32 | The total count of items that meet the query criteria. |
| `↳ cursor` | string | Pass the content in the next request as cursor to get the next page data. |

Lỗi riêng: invalid limit · invalid param · invalid search_content · invalid search_type · invalid sort_by type · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.get_recommended_affiliate_list
`GET /api/v2/ams/get_recommended_affiliate_list` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Returns top 200 recommended affiliates that can be added to a campaign

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. Note: The response size will up to 200. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ total_count` | int32 | The total count of affiliates that recommended for shop id. |
| `↳ affiliate_list` | object[] | Recommended Affiliate list. Not all return fields will have values. |
| `↳↳ affiliate_id` | int64 | The unique key for the current affiliate. |
| `↳↳ affiliate_name` | string | The name of the affiliate. |
| `↳↳ user_name` | string | The shopee user name or affiliate name for this affiliate. |
| `↳↳ portrait_url` | string | The portrait url of affiliate. |
| `↳↳ popular_social_media` | object | The popular social media of this affiliate. |
| `↳↳↳ platform` | string | The platform of this social media account. |
| `↳↳↳ follower_count` | int64 | The follower count of this account. |
| `↳↳ social_medias` | object[] | Social media account list of this affiliate. |
| `↳↳↳ platform` | string | The platform of this social media account. |
| `↳↳↳ follower_count` | int64 | The follower count of this account. |
| `↳↳↳ social_media_user_name` | string | Social media name of this account. |
| `↳↳ total_click` | int64 | Number of clicks in the last 30 days. |
| `↳↳ order_range` | int64[] | Range number of the orders in the last 30 days. |
| `↳↳ gmv_range` | int64[] | Range number of the GMV in the last 30 days. |
| `↳↳ is_orange_tick_kol` | boolean | Golden tick means affiliates create high quality contents with good sales conversion in Shopee Live or Shopee Video. |
| `↳↳ is_good_fulfillment` | boolean | Good sample fulfillment means that affiliates demonstrate better in free sample fulfillment compared to the majority of affiliates in recent180 days |
| `↳↳ promote_category_ids` | int64[] | Three promote category ids for this affiliate. |
| `↳↳ top_popular_contents` | object[] | Top popular contents of this affiliate. |
| `↳↳↳ platform` | string | The platform of this affiliate's content. eg. shopee video/shopee live |
| `↳↳↳ comment_count` | int64 | The comment count of this affiliate's content. |
| `↳↳↳ like_count` | int64 | The like count of this affiliate's content. |
| `↳↳↳ view_count` | int64 | The view count of this affiliate's content. |
| `↳↳↳ cover_url` | string | The cover link of this affiliate's content. |
| `↳↳↳ media_url` | string | The media link of this affiliate's content. |
| `↳↳ top_selling_products` | object[] | Top selling items of the affiliate. |
| `↳↳↳ item_id` | int64 | The item id of this item. |

Lỗi riêng: invalid page_no · invalid page_size · invalid param · Something wrong. Please try later.

## v2.ams.get_managed_affiliate_list
`GET /api/v2/ams/get_managed_affiliate_list` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Returns affiliates that are saved to managed affiliate list

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 | ✔ | The start index of request. The max managed affiliates of affiliate is 2000. Zero count will returned if offset > 2000 or offset > real managed count. |
| `page_size` | int32 | ✔ | The number of affiliate returned by this request, Max is 100, default is 20. The max managed affiliates of affiliate is 2000. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ total_count` | int32 | The total count of affiliates that managed by this seller. |
| `↳ affiliate_list` | object[] | Affiliate list managed by seller. Not all return fields will have values. |
| `↳↳ affiliate_id` | int64 | The unique key for the current affiliate. |
| `↳↳ affiliate_name` | string | The name of the current commission. |
| `↳↳ user_name` | string | The shopee user name or affiliate name for this affiliate |
| `↳↳ portrait_url` | string | The portrait url of affiliate. |
| `↳↳ popular_social_media` | object | The popular social media of this affiliate. |
| `↳↳↳ platform` | string | The platform of this social media account. |
| `↳↳↳ follower_count` | int64 | The follower count of this account. |
| `↳↳ social_medias` | object[] | Social media account list of this affiliate. |
| `↳↳↳ platform` | string | The platform of this social media account. |
| `↳↳↳ follower_count` | int64 | The follower count of this account. |
| `↳↳↳ social_media_user_name` | string | Social media name of this account. |
| `↳↳ total_click` | int64 | Number of clicks in the last 30 days. |
| `↳↳ order_range` | int64[] | Range number of the orders in the last 30 days. |
| `↳↳ gmv_range` | int64[] | Range number of the gmv in the last 30 days. |
| `↳↳ is_orange_tick_kol` | boolean | Golden tick means affiliates create high quality contents with good sales conversion in Shopee Live or Shopee Video. |
| `↳↳ is_good_fulfillment` | boolean | Good sample fulfillment means that affiliates demonstrate better in free sample fulfillment compared to the majority of affiliates in recent180 days. |
| `↳↳ promote_category_ids` | int64[] | Top three promote category ids for this affiliate |
| `↳↳ top_popular_contents` | object[] | Top popular contents of this affiliate. |
| `↳↳↳ platform` | string | The platform of this affiliate's content. eg. shopee video/shopee live |
| `↳↳↳ comment_count` | int64 | The comment count of this affiliate's content. |
| `↳↳↳ like_count` | int64 | The like count of this affiliate's content. |
| `↳↳↳ view_count` | int64 | The view count of this affiliate's content. |
| `↳↳↳ cover_url` | string | The cover link of this affiliate's content. |
| `↳↳↳ media_url` | string | The media link of this affiliate's content. |
| `↳↳ top_selling_products` | object[] | Top selling items of the affiliate. |
| `↳↳↳ item_id` | int64 | The item id of this item. |

Lỗi riêng: invalid page_no · invalid page_size · invalid param · Something wrong. Please try later.

## v2.ams.query_affiliate_list
`GET /api/v2/ams/query_affiliate_list` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve affiliate information by affiliate id.

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `query_type` | int32 | ✔ | Query type: 1: query affiliate information by id list 2: query affiliate id by name(fuzzy matching), only return affiliate id and affiliate name |
| `affiliate_id_list` | string |  | Query affiliate information by affiliate id list. Max count of affiliate id is 200. Will return first 200 affiliates' information if length > 200. |
| `name` | string |  | Query affiliate information by name use fuzzy matching. Will return first 200 affiliates' information is match number > 200. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ total_count` | int32 | The total count of affiliates by this query. Max is 200. |
| `↳ affiliate_list` | object | Affiliate list by this query. Not all return fields will have values. |
| `↳↳ affiliate_id` | int64 | The unique key for the current affiliate. |
| `↳↳ affiliate_name` | string | The name of the affiliate. |
| `↳↳ user_name` | string | The shopee user name or affiliate name for this affiliate. |
| `↳↳ portrait_url` | string | The url of affiliate's portrait |
| `↳↳ popular_social_media` | object[] | The popular social media of this affiliate. |
| `↳↳↳ platform` | string | The platform of this social media account. |
| `↳↳↳ follower_count` | int64 | The follower count of this account. |
| `↳↳ social_medias` | object[] | Social media account list of this affiliate. |
| `↳↳↳ platform` | string | The platform of this social media account. |
| `↳↳↳ follower_count` | int64 | The follower count of this account. |
| `↳↳↳ social_media_user_name` | string | Social media name of this account. |
| `↳↳ total_click` | int64 | Number of clicks in the last 30 days. |
| `↳↳ order_range` | int64[] | Range number of the orders in the last 30 days. |
| `↳↳ gmv_range` | int64[] | Range number of the gmv in the last 30 days. |
| `↳↳ is_orange_tick_kol` | boolean | Golden tick means affiliates create high quality contents with good sales conversion in Shopee Live or Shopee Video. |
| `↳↳ is_good_fulfillment` | boolean | Good sample fulfillment means that affiliates demonstrate better in free sample fulfillment compared to the majority of affiliates in recent180 days |
| `↳↳ promote_category_ids` | int64[] | Three promote category ids for this affiliate |
| `↳↳ top_popular_contents` | object[] | Top popular contents of this affiliate. |
| `↳↳↳ platform` | string | The platform of this affiliate's content. |
| `↳↳↳ comment_count` | int64 | The comment count of this affiliate's content. |
| `↳↳↳ like_count` | int64 | The like count of this affiliate's content. |
| `↳↳↳ view_count` | int64 | The view count of this affiliate's content. |
| `↳↳↳ cover_url` | string | The cover link of this affiliate's content. |
| `↳↳↳ media_url` | string | The media link of this affiliate's content. |
| `↳↳ top_selling_products` | object[] | Top selling items of the affiliate. |
| `↳↳↳ item_id` | int64 | The item id of this item. |

Lỗi riêng: invalid param

## v2.ams.create_new_targeted_campaign
`POST /api/v2/ams/create_new_targeted_campaign` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Create a new campaign with custom product & affiliate selections, and basic info filling.

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_name` | string | ✔ | The name of the current campaign. |
| `period_start_time` | timestamp | ✔ | The period start time of campaign, in seconds. |
| `period_end_time` | timestamp | ✔ | The period end time of campaign, in seconds. Can set 32503651199 (2999-12-31 23:59:59) represent of no limit. |
| `is_set_budget` | boolean |  | Budget allocation toggle for the current campaign. Note: TH not supported |
| `budget` | float |  | Budget value set for the current campaign. Note: TH not supported |
| `seller_message` | string | ✔ | The message displayed to affiliates. |
| `item_list` | object[] | ✔ | The list of items associated with the current campaign. |
| `↳ item_id` | int64 | ✔ | Item ID. |
| `↳ rate` | float | ✔ | Commission rate of current item, 1.1 means 1.1%, support two decimal places. |
| `affiliate_list` | object[] | ✔ | The list of affiliates associated with the current campaign. |
| `↳ affiliate_id` | int64 | ✔ | The unique key for affiliate. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Successful elements will not be returned. If error and message are not empty, it means that all settings have failed. If error and message are empty, but fail_xx_list has content, it means that the element in the fail_xx_list setting failed and the rest were successful. If error, message, fail_xx_list are all empty, it means that all settings are successful. |
| `↳ campaign_id` | int64 | The unique key for campaign. |
| `↳ fail_item_list` | object[] | Failed Item List. |
| `↳↳ item_id` | int64 | Item ID. |
| `↳↳ fail_error` | string | Fail error. |
| `↳↳ fail_message` | string | Fail message. |
| `↳ fail_affiliate_list` | object[] | Fail Affiliate List. |
| `↳↳ affiliate_id` | int64 | Affiliate ID. |
| `↳↳ fail_error` | string | Fail error. |
| `↳↳ fail_message` | string | Fail message. |

Lỗi riêng: Affiliate is not eligible to promote for AMS campaigns at the moment. · Budget setup is not supported for your shop. · The campaign name is a duplicate. · invalid affiliate · invalid budget · invalid campaign name · invalid commission_rate · invalid period_end_time · invalid period_start_time · The item is invalid. · Something wrong. Please try later. · The minimum commission rate limit was not passed. · The minimum daily budget requirement was not met. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API.

## v2.ams.get_targeted_campaign_list
`GET /api/v2/ams/get_targeted_campaign_list` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve all current targeted campaigns created by the seller

Lịch sử cập nhật: 2025-11-12: Add campaign_source; 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. |
| `page_no` | int32 | ✔ | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. |
| `campaign_id_list` | string |  | The list of campaign_id for query, different campaign id should be split by comma and at most 50 campaigns. |
| `campaign_name` | string |  | Campaign name for query. |
| `campaign_status` | string |  | Campaign status for query. Applicable values: Upcoming Ongoing Ended Cancelled Draft Terminating Terminated Paused |
| `period_start_time` | timestamp |  | Campaign period start time for query. |
| `period_end_time` | timestamp |  | Campaign period end time for query. |
| `item_id` | int64 |  | Item id for query. |
| `item_name` | string |  | Item name for query. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ total_count` | int32 | The total count of targeted campaigns that meet the query criteria. |
| `↳ campaign_list` | object[] | Targeted campaign list. |
| `↳↳ campaign_id` | int64 | The unique key for the current campaign. |
| `↳↳ campaign_name` | string | The name of the current campaign. |
| `↳↳ campaign_status` | string | Campaign Status: Upcoming Ongoing Ended Cancelled Draft Terminating Terminated Paused |
| `↳↳ campaign_source` | string | Source of campaign setup. Applicable values: - ShopeeManaged (Note: You cannot view the details or edit this campaign. If you try to do so, an 'invalid campaign_id' error will occur.) - Seller - Unknown |
| `↳↳ period_start_time` | timestamp | The start time of the current campaign. |
| `↳↳ period_end_time` | timestamp | The end time of the current campaign, if get 32503651199 (2999-12-31 23:59:59), it means no limit |
| `↳↳ last_editor` | string | The last editor of the current campaign. |
| `↳↳ last_edit_time` | timestamp | The last edit time of the current campaign. |
| `↳↳ affiliate_count` | int32 | The total count of affiliates associated with the current campaign. |
| `↳↳ item_count` | int32 | The total count of items associated with the current campaign. |
| `↳↳ min_rate` | float | The min commission rate of the current campaign. |
| `↳↳ max_rate` | float | The max commission rate of the current campaign. |

Lỗi riêng: invalid affiliate id · invalid campaign_id · invalid campaign_status · invalid page_no · invalid page_size · invalid param · invalid period_end_time · invalid period_start_time · invalid product id · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.get_targeted_campaign_settings
`GET /api/v2/ams/get_targeted_campaign_settings` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

For each campaign, return: campaign basic info (name, status, promotion period, message), selected product list (with product name & ID), selected affiliate list (with affiliate names)

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_id` | int64 | ✔ | Campaign id for query. Note: For campaigns with campaign_source = ShopeeManaged, cannot be queried for details through this API. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ campaign_name` | string | The name of the current campaign. |
| `↳ commission_status` | string | Campaign Status: Upcoming Ongoing Ended Cancelled Draft Terminating Terminated Paused |
| `↳ period_start_time` | timestamp | The start time of the current campaign. |
| `↳ period_end_time` | timestamp | The end time of the current campaign, if get 32503651199 (2999-12-31 23:59:59), it means no limit. |
| `↳ is_set_budget` | boolean | Has the current campaign set a budget. Note: TH not supported |
| `↳ budget` | float | The budget of the current campaign. Note: TH not supported |
| `↳ budget_cost` | float | The budget already spent on the current campaign. Note: TH not supported |
| `↳ seller_message` | string | The message displayed to affiliates. |
| `↳ pending_terminated_time` | timestamp | Pending Terminated Time. |
| `↳ affiliate_list` | object[] | The list of affiliates associated with the current campaign. |
| `↳↳ affiliate_id` | int64 | The unique key for affiliate, can call v2.ams.query_affiliate_list to get affiliate details. |
| `↳ item_list` | object[] | The list of items associated with the current campaign. |
| `↳↳ item_id` | int64 | Item ID. |
| `↳↳ item_name` | string | Item Name. |
| `↳↳ rate` | float | Commission rate of current item, 1.1 means 1.1%, support two decimal places. |
| `↳↳ max_commission_rate_current_day` | float | Max Commission Rate Current Day, 1.1 means 1.1%, support two decimal places. |
| `↳↳ commission_protection_list` | object[] | Commission Protection List. |
| `↳↳↳ commission_rate` | float | Commission Rate, 1.1 means 1.1%, support two decimal places. |
| `↳↳↳ protection_period_end_time` | timestamp | Protection Period End Time. |

Lỗi riêng: cannot get this campaign · invalid campaign_id · invalid param · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.update_basic_info_of_targeted_campaign
`POST /api/v2/ams/update_basic_info_of_targeted_campaign` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Edit campaign name, promotion period, message, and budget (if the shop is whitelisted) of target campaign

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_id` | int64 | ✔ | The unique key for the current campaign. |
| `campaign_name` | string |  | The name of the current campaign. |
| `period_start_time` | timestamp |  | The start time of the designated campaign, in seconds. |
| `period_end_time` | timestamp |  | The period end time of campaign, in seconds. Can set 32503651199 (2999-12-31 23:59:59) represent of no limit. |
| `is_set_budget` | boolean |  | Budget allocation toggle for the current campaign. Note: TH not supported |
| `budget` | float |  | Budget value set for the current campaign. Note: TH not supported |

Lỗi riêng: Budget setup is not supported for your shop. · invalid budget · invalid campaign_id · invalid campaign name · invalid param · invalid period_end_time · invalid period_start_time · Something wrong. Please try later. · The minimum daily budget requirement was not met. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.edit_product_list_of_targeted_campaign
`POST /api/v2/ams/edit_product_list_of_targeted_campaign` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Modify the selected product list in an existing target campaign

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_id` | int64 | ✔ | Campaign id for update. |
| `edit_type` | string | ✔ | Edit type. Applicable values: add delete update |
| `item_list` | object[] | ✔ | The list of items to be modified. |
| `↳ item_id` | int64 | ✔ | Item ID. |
| `↳ rate` | float |  | Commission rate of current item, 1.1 means 1.1%, support two decimal places. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Successful elements will not be returned. If error and message are not empty, it means that all settings have failed. If error and message are empty, but fail_xx_list has content, it means that the element in the fail_xx_list setting failed and the rest were successful. If error, message, fail_xx_list are all empty, it means that all settings are successful. |
| `↳ fail_item_list` | object[] | Failed Item List. |
| `↳↳ item_id` | int64 | Item ID. |
| `↳↳ fail_error` | string | Indicate error type if hit error. Empty if no error happened. |
| `↳↳ fail_message` | string | Indicate error details if hit error. Empty if no error happened. |

Lỗi riêng: AMS campaign item and rate already exist · AMS campaign item and rate not exist · Cannot remove all item and rate · invalid campaign_id · invalid commission_rate · invalid type · invalid item_id, detail:{} · invalid param · Something wrong. Please try later. · Sorry you don't have access to AMS features. · ongoing product can not reduce · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.edit_affiliate_list_of_targeted_campaign
`POST /api/v2/ams/edit_affiliate_list_of_targeted_campaign` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Modify the selected affiliate list in an existing target campaign

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_id` | int64 | ✔ | Campaign id for update. |
| `edit_type` | string | ✔ | Edit type. Applicable values: add delete |
| `affiliate_list` | object[] | ✔ | The list of affiliates to be modified. |
| `↳ affiliate_id` | int64 | ✔ | The unique key for affiliate. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Successful elements will not be returned. If error and message are not empty, it means that all settings have failed. If error and message are empty, but fail_xx_list has content, it means that the element in the fail_xx_list setting failed and the rest were successful. If error, message, fail_xx_list are all empty, it means that all settings are successful. |
| `↳ fail_affiliate_list` | object[] | Failed Affiliate List. |
| `↳↳ affiliate_id` | int64 | The unique key for affiliate. |
| `↳↳ fail_error` | string | Indicate error type if hit error. Empty if no error happened. |
| `↳↳ fail_message` | string | Indicate error details if hit error. Empty if no error happened. |

Lỗi riêng: affiliate number is 0 · invalid campaign_id · invalid campaign_status · invalid type · invalid param · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.terminate_targeted_campaign
`POST /api/v2/ams/terminate_targeted_campaign` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Change target campaign status to "terminated" to stop all affiliate promotion activity

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_id` | int64 | ✔ | The unique key for the current campaign. |

Lỗi riêng: invalid campaign_id · invalid param · Something wrong. Please try later. · Sorry you don't have access to AMS features. · Please agree to the AMS T&C in Seller Center - Affiliate Marketing Solutions first before using Open API. · The seller commission operation is frozen.

## v2.ams.get_performance_data_update_time
`GET /api/v2/ams/get_performance_data_update_time` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve the latest date of AMS dashboard data metrics update.

Lịch sử cập nhật: 2025-12-05: Remove AmsCampaignAnalyticsMarker option for marker_type request parameter; 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `marker_type` | string | ✔ | Marker type. Applicable values: - AmsMarker: Used to query the data update date for ams metrics. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ last_report_date` | string | The latest date of AMS dashboard data metrics update. |

Lỗi riêng: invalid marker type · invalid param · Something wrong. Please try later.

## v2.ams.get_shop_performance
`GET /api/v2/ams/get_shop_performance` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve overall key metrics for all channels or specific channels.

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `period_type` | string | ✔ | Period Type. Applicable values: Day Week Month Last7d Last30d Note: The start date and end date must align with the Period Type. |
| `start_date` | string | ✔ | The start_date must be: - Any day in the past three calendar months for "Day" period type - Sunday for "Week" period type - The 1st day of a Month for "Month" period type - The date that is 6 days prior to the latest data date for "Last7d" period type - The date that is 29 days prior to the latest data date for "Last30d" period type Note: The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |
| `end_date` | string | ✔ | The end_date must be: - Equal to start_date for "Day" period type - Saturday for "Week" period type - The last day of a Month for "Month" period type. If the selected month is the current month, the end_date should be the latest data date - The latest data date for "Last7d" period type - The latest data date for "Last30d" period type Note: - The end_date must be later than the start_date and earlier than the latest data date - The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |
| `order_type` | string | ✔ | Order Type. Applicable values: PlacedOrder ConfirmedOrder: Note: - Placed orders are orders (COD and non-COD) that buyers have successfully placed, including paid and unpaid orders. - Confirmed orders are either non-COD orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `channel` | string | ✔ | Channel. Applicable values: - AllChannel - SocialMedia - ShopeeVideo - LiveStreaming |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ sales` | string | Total value of orders generated through affiliate marketing during the selected period. |
| `↳ gross_item_sold` | int64 | Total number of items sold through affiliate marketing during the selected period. |
| `↳ orders` | int64 | Total number of orders generated through affiliate marketing during the selected period. |
| `↳ clicks` | int64 | Total clicks on your product links through affiliate marketing during the selected period. |
| `↳ est_commission` | string | Estimated total payout from your affiliate marketing orders. |
| `↳ roi` | string | Return on Investment, equal to Sales divided by Est. Commission. It can be used to evaluate the efficiency of your investment in affiliate marketing. If it does not exist, the return value is --. |
| `↳ total_buyers` | int64 | Total number of buyers who order from your shop through affiliate marketing. |
| `↳ new_buyers` | int64 | Total number of new buyers who order from your shop through affiliate marketing. |
| `↳ fetched_date_range` | string | Effective query date range. Invalid input ranges will be automatically shifted. |

Lỗi riêng: invalid channel · invalid order type · invalid param · invalid period type · invalid time range, detail:{detail} · Something wrong. Please try later.

## v2.ams.get_product_performance
`GET /api/v2/ams/get_product_performance` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve product performance of the shop.

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `period_type` | string | ✔ | Period Type. Applicable values: Day Week Month Last7d Last30d Note: The start date and end date must align with the Period Type. |
| `start_date` | string | ✔ | The start_date must be: - Any day in the past three calendar months for "Day" period type - Sunday for "Week" period type - The 1st day of a Month for "Month" period type - The date that is 6 days prior to the latest data date for "Last7d" period type - The date that is 29 days prior to the latest data date for "Last30d" period type Note: The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |
| `end_date` | string | ✔ | The end_date must be: - Equal to start_date for "Day" period type - Saturday for "Week" period type - The last day of a Month for "Month" period type. If the selected month is the current month, the end_date should be the latest data date - The latest data date for "Last7d" period type - The latest data date for "Last30d" period type Note: - The end_date must be later than the start_date and earlier than the latest data date - The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |
| `page_no` | int32 | ✔ | Specifies the page number of data to return in the current call. Starting from 1. If data is more than one page, the page_no can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 20. |
| `order_type` | string | ✔ | Order Type. Applicable values: PlacedOrder ConfirmedOrder: Note: - Placed orders are orders (COD and non-COD) that buyers have successfully placed, including paid and unpaid orders. - Confirmed orders are either non-COD orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `channel` | string | ✔ | Channel. Applicable values: - AllChannel - SocialMedia - ShopeeVideo - LiveStreaming |
| `item_id` | int64 |  | Item ID for query. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ list` | object[] |  |
| `↳↳ item_id` | int64 | Item ID. |
| `↳↳ item_name` | string | Item Name. |
| `↳↳ sales` | string | Total value of the product sold through affiliate marketing. |
| `↳↳ items_sold` | int64 | Total number of the product sold through affiliate marketing. |
| `↳↳ orders` | int64 | Total number of orders including the product generated through affiliate marketing. |
| `↳↳ clicks` | int64 | Total number of clicks on your product links through affiliate marketing during the selected period. |
| `↳↳ est_commission` | string | Estimated payout of the product sold through affiliate marketing. |
| `↳↳ roi` | string | Return on Investment, equal to GMV divided by Estimated Commission. It can be used to evaluate the efficiency of your investment in affiliate marketing on the product.If it does not exist, the return value is --. |
| `↳↳ total_buyers` | int64 | Total number of buyers who have purchased the product through affiliate marketing. |
| `↳↳ new_buyers` | int64 | Total number of new buyers who have purchased the product through affiliate marketing. |
| `↳ total_count` | int64 | Total number of items that match the condition. |
| `↳ has_more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of datas. |
| `↳ fetched_date_range` | string | Effective query date range. Invalid input ranges will be automatically shifted. |

Lỗi riêng: invalid channel · invalid order type · invalid page_no · invalid page_size · invalid param · invalid period type · invalid time range, detail:{detail} · Something wrong. Please try later.

## v2.ams.get_affiliate_performance
`GET /api/v2/ams/get_affiliate_performance` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve affiliate performance of the shop.

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `period_type` | string | ✔ | Period Type. Applicable values: Day Week Month Last7d Last30d Note: The start date and end date must align with the Period Type. |
| `start_date` | string | ✔ | The start_date must be: - Any day in the past three calendar months for "Day" period type - Sunday for "Week" period type - The 1st day of a Month for "Month" period type - The date that is 6 days prior to the latest data date for "Last7d" period type - The date that is 29 days prior to the latest data date for "Last30d" period type Note: The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |
| `end_date` | string | ✔ | The end_date must be: - Equal to start_date for "Day" period type - Saturday for "Week" period type - The last day of a Month for "Month" period type. If the selected month is the current month, the end_date should be the latest data date - The latest data date for "Last7d" period type - The latest data date for "Last30d" period type Note: - The end_date must be later than the start_date and earlier than the latest data date - The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |
| `page_no` | int32 | ✔ | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 20. |
| `order_type` | string | ✔ | Order Type. Applicable values: PlacedOrder ConfirmedOrder: Note: - Placed orders are orders (COD and non-COD) that buyers have successfully placed, including paid and unpaid orders. - Confirmed orders are either non-COD orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `channel` | string | ✔ | Channel. Applicable values: - AllChannel - SocialMedia - ShopeeVideo - LiveStreaming |
| `affiliate_id` | int64 |  | Affiliate ID for query. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ list` | object[] |  |
| `↳↳ affiliate_id` | int64 | Unique identifier assigned to the affiliate. Used as a reference key in the system. |
| `↳↳ affiliate_name` | string | Display name of the affiliate, typically the Shopee display name. |
| `↳↳ affiliate_username` | string | Login or Shopee account username associated with the affiliate. |
| `↳↳ sales` | string | Total value of the product sold through the affiliate's promotion. |
| `↳↳ items_sold` | int64 | Total number of the product sold through the affiliate's promotion. |
| `↳↳ orders` | int64 | Total number of orders generated through the affiliate's promotion. |
| `↳↳ clicks` | int64 | Total number of clicks on your product links through affiliate marketing during the selected period. |
| `↳↳ est_commission` | string | Estimated payout through the affiliate's promotion. |
| `↳↳ roi` | string | Return on Investment, equal to GMV divided by Estimated Commission. It can be used to evaluate the efficiency of the affiliate's promotion. If it does not exist, the return value is --. |
| `↳↳ total_buyers` | int64 | Total number of buyers who have purchased the product through the affiliate's promotion. |
| `↳↳ new_buyers` | int64 | Total number of new buyers who have purchased the product through the affiliate's promotion. |
| `↳ total_count` | int64 | Total number of affiliates that match the condition. |
| `↳ has_more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of datas. |
| `↳ fetched_date_range` | string | Effective query date range. Invalid input ranges will be automatically shifted. |

Lỗi riêng: invalid channel · invalid order type · invalid page_no · invalid page_size · invalid param · invalid period type · invalid time range, detail:{detail} · Something wrong. Please try later.

## v2.ams.get_content_performance
`GET /api/v2/ams/get_content_performance` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve content performance of the shop

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `period_type` | string | ✔ | Period Type. Applicable values: Day Week Month Last7d Last30d Note: The start date and end date must align with the Period Type. |
| `start_date` | string | ✔ | The start_date must be: - Any day in the past three calendar months for "Day" period type - Sunday for "Week" period type - The 1st day of a Month for "Month" period type - The date that is 6 days prior to the latest data date for "Last7d" period type - The date that is 29 days prior to the latest data date for "Last30d" period type Note: The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |
| `end_date` | string | ✔ | The end_date must be: - Equal to start_date for "Day" period type - Saturday for "Week" period type - The last day of a Month for "Month" period type. If the selected month is the current month, the end_date should be the latest data date - The latest data date for "Last7d" period type - The latest data date for "Last30d" period type Note: - The end_date must be later than the start_date and earlier than the latest data date - The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |
| `page_no` | int32 | ✔ | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 20. |
| `order_type` | string | ✔ | Order Type. Applicable values: PlacedOrder ConfirmedOrder: Note: - Placed orders are orders (COD and non-COD) that buyers have successfully placed, including paid and unpaid orders. - Confirmed orders are either non-COD orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `channel` | string | ✔ | Channel. Applicable values: - ShopeeVideo - LiveStreaming |
| `affiliate_id` | int64 |  | Search for the contents published by affiliates with the affiliate id entered. |
| `item_id` | int64 |  | Search for the contents with the searched product included (precise search). |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ list` | object[] |  |
| `↳↳ content_id` | string | Unique identifier of the content where the product is placed. |
| `↳↳ content_title` | string | Title or name of the content (e.g., video, livestream) associated with the product. |
| `↳↳ post_time` | int64 | Livestream: The livestream start time. Video: The video post time. |
| `↳↳ affiliate_name` | string | Display name of the affiliate who posted the content, typically the Shopee name. |
| `↳↳ affiliate_username` | string | Login or Shopee account username associated with the affiliate. |
| `↳↳ products` | int64 | Number of products associated with the content. |
| `↳↳ views` | int32 | The total viewed pv of the content of this shop within the selected time range |
| `↳↳ likes` | int32 | The total number of likes for the content of this shop within the selected time range |
| `↳↳ comments` | int32 | The total number of comments for the content of this shop within the selected time range |
| `↳↳ sales` | string | The total sales of the content associated with the shop orders within the selected time range |
| `↳↳ orders` | int64 | The total number of orders associated with the shop for the content in the selected time range |
| `↳↳ items_sold` | int64 | The total number of items sold associated with the shop for the content in the selected time range |
| `↳↳ channel` | string | Channel. Applicable values: - ShopeeVideo - LiveStreaming |
| `↳ total_count` | int64 | This is to indicate the whole number of items. |
| `↳ has_more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of datas. |
| `↳ fetched_date_range` | string | Effective query date range. Invalid input ranges will be automatically shifted. |

Lỗi riêng: invalid channel · invalid order type · invalid page_no · invalid page_size · invalid param · invalid period type · invalid time range, detail:{detail} · Something wrong. Please try later.

## v2.ams.get_campaign_key_metrics_performance
`GET /api/v2/ams/get_campaign_key_metrics_performance` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve key metrics for Open and Targeted campaigns

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `period_type` | string | ✔ | Period Type. Applicable values: Day Week Month Last7d Last30d Note: The start date and end date must align with the Period Type. |
| `start_date` | string | ✔ | The start_date must be: - Any day in the past three calendar months for "Day" period type - Sunday for "Week" period type - The 1st day of a Month for "Month" period type - The date that is 6 days prior to the latest data date for "Last7d" period type - The date that is 29 days prior to the latest data date for "Last30d" period type Note: The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |
| `end_date` | string | ✔ | The end_date must be: - Equal to start_date for "Day" period type - Saturday for "Week" period type - The last day of a Month for "Month" period type. If the selected month is the current month, the end_date should be the latest data date - The latest data date for "Last7d" period type - The latest data date for "Last30d" period type Note: - The end_date must be later than the start_date and earlier than the latest data date - The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ open_campaign_key_metircs` | object | Performance data of Open Campaign. |
| `↳↳ affiliates` | int64 | Total number of affiliates who drove orders from Open Campaigns. |
| `↳↳ items_sold` | int64 | Total number of items sold from Open Campaigns. |
| `↳↳ sales` | string | Total value of orders from Open Campaigns. |
| `↳↳ est_commission` | string | Total estimated commission for orders placed from Open Campaigns. |
| `↳ targeted_campaign_key_metircs` | object | Performance data of Target Campaign. |
| `↳↳ affiliates` | int64 | Total number of affiliates who drove orders from Targeted Campaigns. |
| `↳↳ items_sold` | int64 | Total number of items sold from Targeted Campaigns. |
| `↳↳ sales` | string | Total value of orders from Targeted Campaigns. |
| `↳↳ est_commission` | string | Total estimated commission for orders placed from Targeted Campaigns. |
| `↳ fetched_date_range` | string | Effective query date range. Invalid input ranges will be automatically shifted. |

Lỗi riêng: invalid param · invalid period type · invalid time range, detail:{detail} · Something wrong. Please try later.

## v2.ams.get_open_campaign_performance
`GET /api/v2/ams/get_open_campaign_performance` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve all products in the Open Campaign along with performance data

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `period_type` | string | ✔ | Period Type. Applicable values: Day Week Month Last7d Last30d Note: The start date and end date must align with the Period Type. |
| `start_date` | string | ✔ | The start_date must be: - Any day in the past three calendar months for "Day" period type - Sunday for "Week" period type - The 1st day of a Month for "Month" period type - The date that is 6 days prior to the latest data date for "Last7d" period type - The date that is 29 days prior to the latest data date for "Last30d" period type Note: The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |
| `end_date` | string | ✔ | The end_date must be: - Equal to start_date for "Day" period type - Saturday for "Week" period type - The last day of a Month for "Month" period type. If the selected month is the current month, the end_date should be the latest data date - The latest data date for "Last7d" period type - The latest data date for "Last30d" period type Note: - The end_date must be later than the start_date and earlier than the latest data date - The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |
| `page_no` | int32 | ✔ | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 20. |
| `item_id` | int64 |  | Item ID for query. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ list` | object[] |  |
| `↳↳ item_id` | int64 | Unique identifier of the promoted item within open campaign. |
| `↳↳ item_name` | string | Name or title of the promoted item within open campaign. |
| `↳↳ affiliates` | int64 | Number of affiliates currently participating in the campaign for this item. |
| `↳↳ sales` | string | Total sales amount generated from the campaign, in the market's currency. |
| `↳↳ item_sold` | int64 | Total quantity of the item sold through the campaign. |
| `↳↳ est_commission` | string | Estimated commission amount payable to affiliates for this item, based on current campaign data. |
| `↳ total_count` | int64 | This is to indicate the whole number of items. |
| `↳ has_more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of datas. |
| `↳ fetched_date_range` | string | Effective query date range. Invalid input ranges will be automatically shifted. |

Lỗi riêng: invalid page_no · invalid page_size · invalid param · invalid time range, detail:{detail} · Something wrong. Please try later.

## v2.ams.get_targeted_campaign_performance
`GET /api/v2/ams/get_targeted_campaign_performance` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve a list of Targeted Campaigns and their performance data

Lịch sử cập nhật: 2025-10-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `period_type` | string | ✔ | Period Type. Applicable values: Day Week Month Last7d Last30d Note: The start date and end date must align with the Period Type. |
| `start_date` | string | ✔ | The start_date must be: - Any day in the past three calendar months for "Day" period type - Sunday for "Week" period type - The 1st day of a Month for "Month" period type - The date that is 6 days prior to the latest data date for "Last7d" period type - The date that is 29 days prior to the latest data date for "Last30d" period type Note: The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |
| `end_date` | string | ✔ | The end_date must be: - Equal to start_date for "Day" period type - Saturday for "Week" period type - The last day of a Month for "Month" period type. If the selected month is the current month, the end_date should be the latest data date - The latest data date for "Last7d" period type - The latest data date for "Last30d" period type Note: - The end_date must be later than the start_date and earlier than the latest data date - The latest data date can be obtained by using "AmsMarker" in the v2.ams.get_performance_data_update_time API. |
| `page_no` | int32 | ✔ | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 20. |
| `campaign_id` | int64 |  | Campaign ID for query. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ list` | object[] |  |
| `↳↳ campaign_id` | int64 | Unique identifier of the targeted campaign. |
| `↳↳ affiliates` | int64 | The number of affiliates ever brought sales for the targeted campaign. |
| `↳↳ sales` | string | Total sales amount generated from this targeted campaign, in the market's default currency. |
| `↳↳ item_sold` | int64 | Total quantity of the item sold through the targeted campaign. |
| `↳↳ est_commission` | string | The estimated commission amount payable to affiliates from this targeted campaign. |
| `↳↳ campaign_name` | string | Campaign name. |
| `↳ total_count` | int64 | This is to indicate the whole number of target campaigns. |
| `↳ has_more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of datas. |
| `↳ fetched_date_range` | string | Effective query date range. Invalid input ranges will be automatically shifted. |

Lỗi riêng: invalid page_no · invalid page_size · invalid param · invalid time range, detail:{detail} · Something wrong. Please try later.

## v2.ams.get_conversion_report
`GET /api/v2/ams/get_conversion_report` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve the shop's conversion report with details about each order, item, affiliate, campaign.You can filter results using one or multiple time ranges, and the final result will be the intersection of these ranges. Due to data volume limitations, the maximum queryable time span is three months, etc.Maximum data can be viewed is 500 pages, please export data for more details.

Lịch sử cập nhật: 2026-07-02: Add seller_service_fee_rate and seller_service_fee response parameters under response.list[].items[].; 2025-09-05: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 | ✔ | Specifies the page number of data to return in the current call. Starting from 1. If data is more than one page, the page_no can be some entry to start next call. |
| `page_size` | int32 | ✔ | Number of records returned per page, the maximum limit is 500, and page_no * page_size must be <= 10000. |
| `order_sn` | string |  | Unique identifier of the order. |
| `affiliate_id` | int64 |  | ID of the affiliate who promoted the item. |
| `item_id` | int64 |  | ID of the product purchased. |
| `item_name` | string |  | Product's name. |
| `l1_category_id` | int64 |  | Hierarchical product category classification. (L1 Category) |
| `l2_category_id` | int64 |  | Hierarchical product category classification. (L2 category) |
| `l3_category_id` | int64 |  | Hierarchical product category classification. (L3 Category) |
| `order_status` | string |  | Order Status. Applicable values: Unpaid Pending Completed Cancelled |
| `verified_status` | string |  | Verified Status. Applicable values: Unverified Valid Invalid |
| `buyer_status` | string |  | Buyer Status. Applicable values: New Existing |
| `attr_campaign_id` | int64 |  | ID referencing the campaign rule applied. |
| `campaign_partner` | string |  | Name/ID of campaign partner. |
| `seller_campaign_type` | string |  | Seller Campaign Type. Applicable values: TargetCampaign OpenCampaign MCNCampaign |
| `deduction_status` | string |  | Deduction Status. Applicable values: PendingDeduction Deducted |
| `deduction_method` | string |  | Deduction Method. Applicable values: OrderEscrow SellerWallet AutoAdjustment SVSPaymentLink OfflineSettlement AMSCredit |
| `place_order_time_start` | timestamp |  | Start time (inclusive) of order placement, in timestamp format. |
| `place_order_time_end` | timestamp |  | End time (inclusive) of order placement, in timestamp format. |
| `order_completed_time_start` | timestamp |  | Start time (inclusive) of order completion, in timestamp format. |
| `order_completed_time_end` | timestamp |  | End time (inclusive) of order completion, in timestamp format. |
| `conversion_completed_time_start` | timestamp |  | Start time (inclusive) of final completion, in timestamp format. |
| `conversion_completed_time_end` | timestamp |  | End time (inclusive) of final completion, in timestamp format. |
| `ams_deduction_time_start` | timestamp |  | Start time (inclusive) of fee deduction, in timestamp format. |
| `ams_deduction_time_end` | timestamp |  | End time (inclusive) of fee deduction, in timestamp format. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Response payload containing result data. |
| `↳ list` | object[] | Array of order records. Each object contains order and commission details. |
| `↳↳ order_sn` | string | Unique identifier of the order. |
| `↳↳ order_status` | string | Current status of the order (e.g., Pending, Completed, Cancelled). |
| `↳↳ verified_status` | string | Verification status of the order (Unverified, Verified). |
| `↳↳ place_order_time` | string | Time when the order was placed. |
| `↳↳ order_completed_time` | string | Time when the order was marked as completed. |
| `↳↳ conversion_completed_time` | string | Time when the conversion (affiliate action) was completed. |
| `↳↳ affiliate_id` | int64 | Unique identifier of the affiliate. |
| `↳↳ affiliate_name` | string | Shopee display name of the affiliate who promoted the item. |
| `↳↳ affiliate_username` | string | Affiliate's Shopee login username. |
| `↳↳ linked_mcn` | string | MCN (Multi-Channel Network) linked with the affiliate, if any. |
| `↳↳ order_brand_commission` | string | Commission (amount) for the whole order, paid by the seller. |
| `↳↳ channel` | string | Traffic channel or platform where the promotion took place. |
| `↳↳ order_type` | string | Type of order: Direct Order or Indirect Order. |
| `↳↳ buyer_status` | string | Buyer Status. Applicable values: New Existing |
| `↳↳ items` | object[] |  |
| `↳↳↳ item_id` | int64 | Unique identifier of the item in the order. |
| `↳↳↳ item_name` | string | Name of the item in the order. |
| `↳↳↳ model_id` | int64 | SKU/model identifier for the item. |
| `↳↳↳ l1_category_id` | int64 | Level-1 global category id classification of the item. |
| `↳↳↳ l2_category_id` | int64 | Level-2 global category id classification of the item. |
| `↳↳↳ l3_category_id` | int64 | Level-3 global category id classification of the item. |
| `↳↳↳ promotion_id` | string | Identifier of the promotion campaign linked to the order. |
| `↳↳↳ price` | int64 | Item price in cents (or smallest currency unit). |
| `↳↳↳ qty` | int64 | Quantity of the item purchased. |
| `↳↳↳ seller_campaign_type` | string | Type of seller campaign: 1. Seller Open Campaign – Open to all affiliates. 2. Seller Target Campaign – Restricted to designated affiliates. |
| `↳↳↳ attr_campaign_id` | int64 | Campaign attribute ID associated with the order. |
| `↳↳↳ purchase_value` | int64 | Total purchase value of the order in cents (or smallest currency unit). |
| `↳↳↳ refund_amount` | string | Amount refunded for the order. |
| `↳↳↳ item_brand_commission` | string | Commission (amount) for the item, paid by the seller. |
| `↳↳↳ item_brand_commission_rate_to_affiliate` | string | Commission rate allocated to the affiliate for the item. |
| `↳↳↳ item_brand_commission_to_affiliate` | string | Commission (amount) allocated to the affiliate for the item. |
| `↳↳↳ item_brand_commission_rate_to_mcn` | string | Commission rate allocated to the MCN for the item. |
| `↳↳↳ item_brand_commission_to_mcn` | string | Commission (amount) allocated to the MCN for the item. |
| `↳↳↳ seller_service_fee_rate` | string | Seller service fee rate applied to the item. |
| `↳↳↳ seller_service_fee` | string | Seller service fee amount charged for the item.seller_service_fee = item_brand_commission * seller_service_fee_rate |
| `↳↳ campaign_partner` | string | Partner identifier for the campaign. |
| `↳ total_count` | int64 | Total number of entities that match the condition. |
| `↳ has_more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of datas. |

Lỗi riêng: invalid page_no · invalid page_size · invalid param · invalid param, detail:{detail} · invalid time range, detail:{detail} · Something wrong. Please try later.

## v2.ams.get_validation_list
`GET /api/v2/ams/get_validation_list` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve the seller's AMS validation bill

Lịch sử cập nhật: 2025-10-15: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ validation_list` | object[] |  |
| `↳↳ validation_id` | string | Unique identifier of the billing entry. |
| `↳↳ payment_method` | int32 | Payment method. Applicable values: 1 = Online 2 = Offline |
| `↳↳ validation_month` | int32 | Billing month in the format YYYYMM (e.g., 202405). |
| `↳↳ campaign_source` | string | Source of campaign setup. Applicable values: ShopeeManaged Seller |
| `↳↳ online_bill` | object | Billing details when payment method is Online. |
| `↳↳↳ total_amount` | float | Total commission amount for the billing month. |
| `↳↳↳ bill_status` | int32 | Billing Status. Applicable values: 1 = Pending 2 = Completed 3 = In process 4 = To pay via payment link 5 = Manual completed 6 = To Be Settled Offline |
| `↳↳↳ deducted_amount` | float | Commission amount already deducted. |
| `↳↳↳ ams_credit_deducted_amount` | float | Commission amount paid using AMS Credits |
| `↳↳↳ pending_amount` | int64 | Commission amount pending deduction. |
| `↳↳ offline_bills` | object[] | List of billing details when payment method is Offline, grouped by order placement month. |
| `↳↳↳ order_place_month` | int32 | Order placement month in the format YYYYMM. |
| `↳↳↳ total_amount` | float | Total commission amount = commission_amount_after_tax + ams_credit_deducted_amount. |
| `↳↳↳ commission_amount` | float | Offline commission amount before tax. |
| `↳↳↳ commission_amount_after_tax` | float | Offline commission amount including tax. |
| `↳↳↳ ams_credit_deducted_amount` | float | Commission amount already paid using AMS Credits. |

Lỗi riêng: invalid param · Something wrong. Please try later.

## v2.ams.get_validation_report
`GET /api/v2/ams/get_validation_report` · loại: Shop · app được gọi: Affiliate Marketing Solution Management

Retrieve detailed information for a specific validation bill

Lịch sử cập nhật: 2026-07-02: Add seller_service_fee_rate and seller_service_fee response parameters under response.list[].items[].; -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 | ✔ | Specifies the page number of data to return in the current call. Starting from 1. If data is more than one page, the page_no can be some entry to start next call. |
| `page_size` | int32 | ✔ | Number of records returned per page, the maximum limit is 500, and page_no * page_size must be <= 10000. |
| `validation_id` | string | ✔ | Unique identifier of the billing entry. |
| `validation_month` | int32 | ✔ | Billing month in the format YYYYMM (e.g., 202405). |
| `campaign_source` | string | ✔ | Source of campaign setup. Applicable values: ShopeeManaged Seller |
| `order_sn` | string |  | Unique identifier of the order. |
| `l1_category_id` | int64 |  | Hierarchical product category classification. (L1 Category) |
| `l2_category_id` | int64 |  | Hierarchical product category classification. (L2 Category) |
| `l3_category_id` | int64 |  | Hierarchical product category classification. (L3 Category) |
| `item_id` | int64 |  | Unique identifier of the product. |
| `item_name` | string |  | The product's name. |
| `verified_status` | string |  | Verified Status. Applicable values: Valid Invalid |
| `attr_campaign_id` | int64 |  | ID referencing the campaign rule applied. (Ties to the campaign seller created). |
| `place_order_time_start` | timestamp | ✔ | Start time (inclusive) of order placement, in timestamp format. |
| `place_order_time_end` | timestamp | ✔ | End time (inclusive) of order placement, in timestamp format. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Response payload containing result data. |
| `↳ list` | object[] | Array of order records. Each object contains order and commission details. |
| `↳↳ order_sn` | string | Unique identifier of the order. |
| `↳↳ order_status` | string | Current status of the order (e.g., Pending, Completed, Cancelled). |
| `↳↳ verified_status` | string | Verification status of the order (Unverified, Verified). |
| `↳↳ place_order_time` | string | Time when the order was placed. |
| `↳↳ order_completed_time` | string | Time when the order was marked as completed. |
| `↳↳ conversion_completed_time` | string | Time when the conversion (affiliate action) was completed. |
| `↳↳ affiliate_name` | string | Display name of the affiliate who promoted the item. |
| `↳↳ affiliate_username` | string | Login username of the affiliate. |
| `↳↳ linked_mcn` | string | MCN (Multi-Channel Network) linked with the affiliate, if any. |
| `↳↳ campaign_partner` | string | Partner identifier for the campaign. |
| `↳↳ order_type` | string | Type of order: Direct Order or Indirect Order. |
| `↳↳ order_brand_commission` | string | Commission (amount) for the whole order, paid by the seller. |
| `↳↳ channel` | string | Traffic channel or platform where the promotion took place. |
| `↳↳ affiliate_id` | int64 | Unique identifier of the affiliate. |
| `↳↳ buyer_status` | string | Buyer Status. Applicable values: New Existing |
| `↳↳ items` | object[] |  |
| `↳↳↳ item_id` | int64 | Unique identifier of the item in the order. |
| `↳↳↳ item_name` | string | Name of the item in the order. |
| `↳↳↳ model_id` | int64 | SKU/model identifier for the item. |
| `↳↳↳ l1_category_id` | int64 | Level-1 global category id classification of the item. |
| `↳↳↳ l2_category_id` | int64 | Level-2 global category id classification of the item. |
| `↳↳↳ l3_category_id` | int64 | Level-3 global category id classification of the item. |
| `↳↳↳ promotion_id` | string | Identifier of the promotion campaign linked to the order. |
| `↳↳↳ price` | int64 | Item price in cents (or smallest currency unit). |
| `↳↳↳ qty` | int64 | Quantity of the item purchased. |
| `↳↳↳ seller_campaign_type` | string | Type of seller campaign: 1. Seller Open Campaign – Open to all affiliates. 2. Seller Target Campaign – Restricted to designated affiliates. |
| `↳↳↳ attr_campaign_id` | int64 | ID referencing the campaign rule applied. |
| `↳↳↳ purchase_value` | int64 | Total purchase value of the order in cents (or smallest currency unit). |
| `↳↳↳ refund_amount` | string | Amount refunded for the item. |
| `↳↳↳ item_brand_commission` | string | Commission (amount) for the item, paid by the seller. |
| `↳↳↳ item_brand_commission_rate_to_affiliate` | string | Commission rate allocated to the affiliate for the item. |
| `↳↳↳ item_brand_commission_to_affiliate` | string | Commission (amount) allocated to the affiliate for the item. |
| `↳↳↳ item_brand_commission_rate_to_mcn` | string | Commission rate allocated to the MCN for the item. |
| `↳↳↳ item_brand_commission_to_mcn` | string | Commission (amount) allocated to the MCN for the item. |
| `↳↳↳ seller_service_fee_rate` | string | Seller service fee rate applied to the item. |
| `↳↳↳ seller_service_fee` | string | Seller service fee amount charged for the item. seller_service_fee = item_brand_commission * seller_service_fee_rate |
| `↳ total_count` | int64 | Total number of entities that match the condition. |
| `↳ has_more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of datas. |

Lỗi riêng: invalid campaign source · invalid page_no · invalid page_size · invalid param · invalid time range, detail:{detail} · invalid validation month,detail:{detail}

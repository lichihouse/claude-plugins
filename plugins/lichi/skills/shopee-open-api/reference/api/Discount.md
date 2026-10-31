# Module Discount (12 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.discount.add_discount
`POST /api/v2/discount/add_discount` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Use this api to add shop discount activity

Lịch sử cập nhật: 2022-07-18: Optimize the response parameter; 2022-07-18: Add Error Example; 2022-06-28: Optimize the Request Parameter and Response Parameter Sample information; 2021-06-22: update the description of start time

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `discount_name` | string | ✔ | Title of the discount. |
| `start_time` | timestamp | ✔ | The time when discount activity start.The start time must be 1 hour later than current time. |
| `end_time` | timestamp | ✔ | The time when discount activity end.The end time must be 1 hour later than start time,and the discount period must be less than 180 days. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ discount_id` | int | Shopee's unique identifier for a discount activity. |

Lỗi riêng: Discount end time should later than start time. · Promotion duration must be within 180 days. · The end time should be later than 1 hour of start time. · Discount start time is less than the current time · Discount start time is less than the current time. · Cannot add discount as holiday mode is turned on · The upcoming and ongoing discount cannot exceed 1000. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.discount.add_discount_item
`POST /api/v2/discount/add_discount_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Use this api to add shop discount item.

Lịch sử cập nhật: 2022-07-19: Add the Error Example information; 2022-06-28: Optimize the Sample information of Request Parameter and Response Parameter; 2021-11-29: Optimize the request parameter of item_list; 2021-08-12: update the description of purchase_limit; 2021-07-07: update the item_promotion_stock description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `discount_id` | int64 | ✔ | Shopee's unique identifier for a discount activity. |
| `item_list` | object[] | ✔ | The items added in this discount promotion. |
| `↳ item_id` | int64 | ✔ | Shopee's unique identifier for an item. |
| `↳ item_promotion_price` | float |  | The discount price of the item. If the item has no variation, this param is necessary. |
| `↳ item_promotion_stock` | int32 |  | The reserved stock of the item. |
| `↳ model_list` | object[] |  | The models which belongs to this item. |
| `↳↳ model_id` | int64 | ✔ | Shopee's unique identifier for a variation of an item. If there is no variation of this item, you don't need to input this param. Dafault is 0. |
| `↳↳ model_promotion_price` | float | ✔ | The discount price of the item. |
| `↳↳ model_promotion_stock` | int32 |  | The reserved stock of the model, default is no limit, and can not update. To edit the promotion stock, you need to delete the exist discount and re-add again. |
| `↳ purchase_limit` | int32 | ✔ | The max number of this product in the promotion price. If it's No Limit, please input the 0 for this request data. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ discount_id` | int64 | Shopee's unique identifier for a discount activity. |
| `↳ count` | int32 | The number of items that add successfully. |
| `↳ error_list` | object[] | Indicate error details. |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ model_id` | int64 | Shopee's unique identifier for a variation of an item. If there is no variation of this item, you don't need to input this param. Dafault is 0. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |

Lỗi riêng: The reserved stock of added products or disabled products can't be edited · Promotion Sock should be less than current stock · The item is abnormal · The item status is abnormal · This product is under a category that is prohibited from promotions due to regulations in your country · Promotion Sock should be more than {number} · The difference between the maximum price and the minimum price in one item is too large. · There are something wrong when get the original price of model, please try again. · The end discount cannot be updated or deleted. · This product is a B2C product that is prohibited from promotions in FBS shops · Item is already in other overlapped discount. · Item is already in this discount. · A maximum of 1000 items can be uploaded in one promotion · A maximum of 15,000 items can be uploaded in one promotion · Purchase limit of this product must be greater than {number}.

## v2.discount.delete_discount
`POST /api/v2/discount/delete_discount` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Use this api to delete one discount activity

Lịch sử cập nhật: 2022-07-19: Add Error Example information; 2022-06-28: Optimize the Sample information of Response Parameter; 2022-02-09: update response parameter and example

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `discount_id` | int | ✔ | Shopee's unique identifier for a discount activity. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ discount_id` | int | Shopee's unique identifier for a discount activity. |
| `↳ modify_time` | timestamp | The time when discount has been deleted. |

Lỗi riêng: The end discount cannot be updated or deleted. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something wrong. Please try later. · shopid is invalid · Shopid is invalid · request not from gateway

## v2.discount.delete_discount_item
`POST /api/v2/discount/delete_discount_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Use this api to delete items of the discount activity

Lịch sử cập nhật: 2022-07-19: Add Error Example information; 2022-06-28: Optimize the Sample information of Request Parameter and Response Parameter

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `discount_id` | int | ✔ | Shopee's unique identifier for a discount activity. |
| `item_id` | int | ✔ | Shopee's unique identifier for an item. |
| `model_id` | int |  | Shopee's unique identifier for a variation of an item. If there is no variation of this item, you don't need to input this param. Dafault is 0. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ discount_id` | int | Shopee's unique identifier for a discount activity. |
| `↳ error_list` | object[] | Detail informations about error. |
| `↳↳ item_id` | int | Shopee's unique identifier for an item. |
| `↳↳ model_id` | int | Shopee's unique identifier for a variation of an item. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |

Lỗi riêng: The reserved stock of added products or disabled products can't be edited · The difference between the maximum price and the minimum price in one item is too large. · The end discount cannot be updated or deleted. · A maximum of 50,000 models can be uploaded in one promotion · Inner http call failed · parse data failed · data not exist · parameter invalid · The item is not in this discount, please check it again. · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something wrong. Please try later. · shopid is invalid

## v2.discount.get_discount
`GET /api/v2/discount/get_discount` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Accounting And Finance, Marketing, Customized APP, Swam ERP

Use this api to get one shop discount activity detail

Lịch sử cập nhật: 2025-09-08: Add item_local_price_inflated, item_local_promotion_price_inflated, model_local_price_inflated, model_local_promotion_price_inflated; 2025-09-08: Add item_local_price, item_local_promotion_price, model_local_price, model_local_promotion_price; 2022-07-19: Add Error Example information; 2022-06-28: Optimize the Sample information of Request Parameter and Response Parameter; 2021-11-03: update the description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `discount_id` | int64 | ✔ | Shopee's unique identifier for a discount activity. |
| `page_no` | int32 | ✔ | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ status` | string | The status of discount promotion |
| `↳ discount_name` | string | Title of the discount. |
| `↳ item_list` | object[] | The items selected in this discount. |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ item_name` | string | Name of the item in local language. |
| `↳↳ normal_stock` | int32 | The current stock quantity of the item. |
| `↳↳ item_promotion_stock` | int32 | The reserved stock of the item. If the item has no variation, this param is necessary. |
| `↳↳ item_original_price` | float | The original price before discount of the item. If there is variation, this value is 0. |
| `↳↳ item_promotion_price` | float | The discount price of the item. If there is variation, this value is 0. |
| `↳↳ item_inflated_price_of_original_price` | float | The original price after tax of item (Only for taxable Shop). |
| `↳↳ item_inflated_price_of_promotion_price` | float | The discount price after tax of item (Only for taxable Shop). |
| `↳↳ item_local_price` | float | The local price of item calculated as: Local Price = CB Original Price × Local Adjustment Rate. Reflects the final local price derived from shop-level adjustment rules and is denominated in local currency. |
| `↳↳ item_local_promotion_price` | float | The local discount price of item calculated as: Local Discount Price = Local Price × Discount Rate. Reflects the final local seller discount price derived from setting a seller discount and is denominated in local currency. |
| `↳↳ item_local_price_inflated` | float | The local price after tax of item (Only for taxable Shop). |
| `↳↳ item_local_promotion_price_inflated` | float | The local discount price after tax of item (Only for taxable Shop). |
| `↳↳ model_list` | object[] | The models belong to this item. |
| `↳↳↳ model_id` | int64 | Shopee's unique identifier for a variation of an item. |
| `↳↳↳ model_name` | string | Name of the variation that belongs to the same item. |
| `↳↳↳ model_normal_stock` | int32 | The current stock quantity of the variation. |
| `↳↳↳ model_promotion_stock` | int32 | The reserved stock of the model. |
| `↳↳↳ model_original_price` | float | The original price before discount of the variation. |
| `↳↳↳ model_promotion_price` | float | The discount price of the variation. |
| `↳↳↳ model_inflated_price_of_original_price` | float | The original price after tax of model (Only for taxable Shop). |
| `↳↳↳ model_inflated_price_of_promotion_price` | float | The discount price after tax of model (Only for taxable Shop). |
| `↳↳↳ model_local_price` | float | The local price of model calculated as: Local Price = CB Original Price × Local Adjustment Rate. Reflects the final local price derived from shop-level adjustment rules and is denominated in local currency. |
| `↳↳↳ model_local_promotion_price` | float | The local discount price of model calculated as: Local Discount Price = Local Price × Discount Rate. Reflects the final local seller discount price derived from setting a seller discount and is denominated in local currency. |
| `↳↳↳ model_local_price_inflated` | float | The local price after tax of model (Only for taxable Shop). |
| `↳↳↳ model_local_promotion_price_inflated` | float | The local discount price after tax of model (Only for taxable Shop). |
| `↳↳ purchase_limit` | int32 | The max number of this product in the promotion price. |
| `↳ start_time` | timestamp | The time when discount activity start. |
| `↳ discount_id` | int64 | Shopee's unique identifier for a discount activity. |
| `↳ end_time` | timestamp | The time when discount activity end. |
| `↳ more` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of items. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something wrong. Please try later. · shopid is invalid · Shopid is invalid · request not from gateway

## v2.discount.get_discount_list
`GET /api/v2/discount/get_discount_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Customized APP, Swam ERP

Use this api to get shop discount activity list

Lịch sử cập nhật: 2022-07-19: Add Error Example information; 2022-06-28: add the Request Example; 2022-02-24: Response parameter add source field information; 2022-02-15: Request parameter add update_time_from and update_time_to fields

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `discount_status` | string | ✔ | The status filter for retriveing discount list. Available value: upcoming/ongoing/expired/all. |
| `page_no` | int | ✔ | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. |
| `page_size` | int | ✔ | If many items are available to retrieve, you may need to call GetDiscountsList multiple times to retrieve all the data. Each result set is returned as a page of entries. Use the Pagination filters to control the maximum number of entries (<= 100) to retrieve per page (i.e., per call), the offset number to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. |
| `update_time_from` | timestamp |  | The update_time_from and update_time_to fields specify a date range for retrieving orders (based on the discount update time). The maximum date range that may be specified with the update_time_from and update_time_to fields is 30 days. |
| `update_time_to` | timestamp |  | The update_time_from and update_time_to fields specify a date range for retrieving orders (based on the discount update time). The maximum date range that may be specified with the update_time_from and update_time_to fields is 30 days. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ discount_list` | object[] | The discounts created in this shop. |
| `↳↳ status` | string | The status of discount. |
| `↳↳ discount_name` | string | Title of the discount. |
| `↳↳ start_time` | timestamp | The time when discount activity start. |
| `↳↳ end_time` | timestamp | The time when discount activity end. |
| `↳↳ discount_id` | int | Shopee's unique identifier for a discount activity. |
| `↳↳ source` | int | Source of the discount. 7: live stream, 1: admin, 0: others |
| `↳ more` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of items. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something wrong. Please try later. · shopid is invalid · Shopid is invalid · request not from gateway

## v2.discount.update_discount
`POST /api/v2/discount/update_discount` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Use this api to update one discount information

Lịch sử cập nhật: 2022-07-19: Add Error Example information; 2022-06-28: Optimize the Sample information of Request Parameter and Response Parameter

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `discount_id` | int | ✔ | Shopee's unique identifier for a discount activity. |
| `discount_name` | string |  | Title of the discount. |
| `end_time` | int |  | The time when discount activity end. The end time must be 1 hour later than start time. |
| `start_time` | int |  | The time when discount activity start. The new start time must later than original start time. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ discount_id` | int | Shopee's unique identifier for a discount activity. |
| `↳ modify_time` | timestamp | The time when discount is updated. |

Lỗi riêng: Discount end time should later than the current time. · The end discount cannot be updated or deleted. · Promotion duration must be within 180 days. · The end time should be later than 1 hour of start time. · Promotion end time can only be changed to an earlier timing. · Promotion start time can only be changed to a later timing. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something wrong. Please try later.

## v2.discount.update_discount_item
`POST /api/v2/discount/update_discount_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Use this api to update items of the discount promotion.

Lịch sử cập nhật: 2022-07-27: Add Error Example information; 2022-06-28: Optimize the Sample information of Request Parameter and Response Parameter; 2021-09-06: update the description of item_id_list

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `discount_id` | int64 | ✔ | Shopee's unique identifier for a discount activity. |
| `item_list` | object[] | ✔ | The items selected to this discount. You can update at most 50 items per call. |
| `↳ item_id` | int64 | ✔ | Shopee's unique identifier for an item. |
| `↳ item_promotion_price` | float |  | The discount price of the item. |
| `↳ model_list` | object[] |  | The models selected to this discount. |
| `↳↳ model_id` | int64 | ✔ | Shopee's unique identifier for a variation of an item. If there is no variation of this item, you don't need to input this param. Dafault is 0. |
| `↳↳ model_promotion_price` | float | ✔ | The discount price of the item. |
| `↳ purchase_limit` | int32 |  | The max number of this product in the promotion price. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ discount_id` | int64 | Shopee's unique identifier for a discount activity. |
| `↳ count` | int32 | The number of items that modify successfully. |
| `↳ error_list` | object[] | Error list of this discount. |
| `↳↳ item_id` | int64 | The items which have something error. |
| `↳↳ model_id` | int64 | The models which have something error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |

Lỗi riêng: The reserved stock of added products or disabled products can't be edited · The item is abnormal · The item status is abnormal · This product is under a category that is prohibited from promotions due to regulations in your country · The difference between the maximum price and the minimum price in one item is too large. · There are something wrong when get the original price of model, please try again. · The end discount cannot be updated or deleted. · This product is a B2C product that is prohibited from promotions in FBS shops · A maximum of 1000 items can be uploaded in one promotion · A maximum of 15,000 items can be uploaded in one promotion · Purchase limit of this product must be greater than {number}. · Please input model id for the item with models. · Item is not found in this discount. · item status is invalid. · The Item id you provided is not found, please check your item id.

## v2.discount.end_discount
`POST /api/v2/discount/end_discount` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Use this api to end shop discount activity

Lịch sử cập nhật: 2022-07-19: Add Error Example information; 2022-06-28: Optimize the Sample information of Request Parameter and Response Parameter

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `discount_id` | int | ✔ | Shopee's unique identifier for a discount activity. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ discount_id` | int | Shopee's unique identifier for a discount activity. |
| `↳ modify_time` | timestamp | The time to track the modified time. |

Lỗi riêng: The ongoing discount cannot be deleted. · Only can end the discount after 1 hour of start time. · Only the ongoing discount can be ended. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something wrong. Please try later. · shopid is invalid · Shopid is invalid · request not from gateway

## v2.discount.get_sip_discounts
`GET /api/v2/discount/get_sip_discounts` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Get SIP Overseas Discounts. Only regions that have upcoming/ongoing discounts will be returned. Please use Primary shop's Shop ID to request, the API will return the list of Affiliate shops under this Primary shop that have set discounts, along with the discount details.

Lịch sử cập nhật: 2025-03-11: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `region` | string |  | The region of SIP affiliate shop that needs to get discount information. If do not pass, will return the discount information set for all SIP affiliate shops. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ discount_list` | object[] | List of discounts in each region. Will be filtered based on the "region" request parameter. |
| `↳↳ region` | string | The region of SIP affiliate shop. |
| `↳↳ status` | string | The status of discount for SIP affiliate shop in current region, can be upcoming/ongoing, excluding expired discounts. |
| `↳↳ sip_discount_rate` | int32 | The discount rate set for SIP affiliate shop in current region. |
| `↳↳ start_time` | timestamp | The start time of discount for SIP affiliate shop in current region, in UNIX seconds. |
| `↳↳ end_time` | timestamp | The end time of discount for SIP affiliate shop in current region, in UNIX seconds. |
| `↳↳ create_time` | timestamp | The create time of discount for SIP affiliate shop in current region, in UNIX seconds. |
| `↳↳ update_time` | timestamp | The latest update time of discount for SIP affiliate shop in current region, in UNIX seconds. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · You don't have permission for the operation, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · Something wrong. Please try later. · request not from gateway · Please input a valid region where you have opened a shop · You can not edit the promotion within 15 minutes after the update

## v2.discount.set_sip_discount
`POST /api/v2/discount/set_sip_discount` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Set SIP Overseas Discount for SIP affiliate region. Please use Primary shop's Shop ID to request, and provide the region and discount rate of the Affiliate shop to be set or update, the API will set or update the discount rate for that region's Affiliate shop.

Lịch sử cập nhật: 2025-03-11: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `region` | string | ✔ | The region of SIP affiliate shop that needs to set discount. |
| `sip_discount_rate` | int32 | ✔ | The overall market discount rate that will apply to all items for SIP affiliate shop in current region. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ region` | string | The region of SIP affiliate shop. |
| `↳ status` | string | The status of discount for SIP affiliate shop in current region, can be upcoming/ongoing, excluding expired discounts. |
| `↳ sip_discount_rate` | int32 | The discount rate set for SIP affiliate shop in current region. |
| `↳ start_time` | timestamp | The start time of discount for SIP affiliate shop in current region, in UNIX seconds. Note: The start time is 30 minutes after the sellers set up the sip_discount_rate. |
| `↳ end_time` | timestamp | The end time of discount for SIP affiliate shop in current region, in UNIX seconds. Note: The end time is 180 days after the start time. |
| `↳ create_time` | timestamp | The create time of discount for SIP affiliate shop in current region, in UNIX seconds. |
| `↳ update_time` | timestamp | The latest update time of discount for SIP affiliate shop in current region, in UNIX seconds. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · You don't have permission for the operation, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · Something wrong. Please try later. · request not from gateway · You can not give more than 50% off discount in VN · Please input a valid region where you have opened a shop · You can not edit the promotion within 15 minutes after the update

## v2.discount.delete_sip_discount
`POST /api/v2/discount/delete_sip_discount` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Delete SIP Overseas Discounts for SIP affiliate region. Please use Primary shop's Shop ID to request, and provide the region of the Affiliate shop to be deleted, the API will delete the discount from that region's Affiliate shop.

Lịch sử cập nhật: 2025-03-11: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `region` | string | ✔ | The region of SIP affiliate shop that needs to delete discount. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ region` | string | The region of SIP affiliate shop that needs to delete discount. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · You don't have permission for the operation, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · Something wrong. Please try later. · request not from gateway · Please input a valid region where you have opened a shop · You can not edit the promotion within 15 minutes after the update

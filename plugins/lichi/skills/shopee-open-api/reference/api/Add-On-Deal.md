# Module Add-On Deal (14 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.add_on_deal.add_add_on_deal
`POST /api/v2/add_on_deal/add_add_on_deal` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Add Add-on Deal

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `add_on_deal_name` | string | ✔ | Title of the add on deal |
| `start_time` | int | ✔ | The time when add on deal activity start. |
| `end_time` | int | ✔ | The time when add on deal activity end |
| `promotion_type` | int | ✔ | The type of add on deal：add on discount =0；gift with mini spend=1 |
| `purchase_min_spend` | float |  | The minimum purchase amount that needs to be met to buy the gift with min.Spend |
| `per_gift_num` | int |  | Number of gifts that buyers can get |
| `promotion_purchase_limit` | int |  | promotion_purchase_limit |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ add_on_deal_id` | int | Shopee's unique identifier for an add on deal activity. |

Lỗi riêng: The end time should be 1 hour later than start time · The name of add on deal can't exceed 25 characters · A maximum of 1000 add on deals can be created · Please input per gift number between 1 to 50 · Please input correct promotion purchase limit · The start time should be 1 hour later than current time · Please input add on deal purchase limit between 1 to 100 · Please input correct promotion type: Add-on discount=0; Gift with min.spend=1 · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.add_on_deal.add_add_on_deal_main_item
`POST /api/v2/add_on_deal/add_add_on_deal_main_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Add Add-on Deal Main Item

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `add_on_deal_id` | int | ✔ | Shopee's unique identifier for add on deal activity. |
| `main_item_list` | object[] | ✔ | The main items added in this add on deal promotion. |
| `↳ item_id` | int | ✔ | Shopee's unique identifier for an item. |
| `↳ status` | int | ✔ | The status of add on deal item：enable = 1；disable =2 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ main_item_list` | object[] | The main items added in this add on deal promotion. |
| `↳↳ item_id` | int | Shopee's unique identifier for an item. |
| `↳↳ status` | int | The status of add on deal item：enable = 1；disable =2 |
| `↳ add_on_deal_id` | int | Shopee's unique identifier for add on deal activity. |

Lỗi riêng: The add on deal created by admin can't be edited · The overall item level promotion limit has been reached. · This product is already in add on deal main item list · This product is already in add on deal sub item list · This product does not share a common shipping channel with the first enabled product. · This product is already in other add on deal main item list · This product is already in other bundle deal · There are B2C items that can't be added into your promotion · The expired add on deal can't be edited · Only upcoming add on deal can be deleted · The status of this product is abnormal · The product is no stock · This item doesn't existed · The item is already existed in main item · A maximum of 1000 main item can be added

## v2.add_on_deal.add_add_on_deal_sub_item
`POST /api/v2/add_on_deal/add_add_on_deal_sub_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Add Add-on Deal Sub Item

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `add_on_deal_id` | int | ✔ | Shopee's unique identifier for add on deal activity. |
| `sub_item_list` | object[] | ✔ | The sub items added in this add on deal promotion. |
| `↳ item_id` | int |  | Shopee's unique identifier for an item. |
| `↳ model_id` | int |  | Shopee's unique identifier for a model. |
| `↳ status` | int |  | The status of add on deal item：enable = 1；disable =2 |
| `↳ sub_item_input_price` | float |  | Add-on discount price before tax |
| `↳ sub_item_limit` | int |  | The purchase limit of sub item. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ sub_item_list` | object[] | The sub items added in this add on deal promotion. |
| `↳↳ item_id` | int | Shopee's unique identifier for an item. |
| `↳↳ status` | int | The status of add on deal item：enable = 1；disable =2 |
| `↳↳ model_id` | int | Shopee's unique identifier for a model. |
| `↳↳ fail_error` | string |  |
| `↳↳ fail_message` | string |  |
| `↳ add_on_deal_id` | int | Shopee's unique identifier for add on deal activity. |

Lỗi riêng: The add on deal created by admin can't be edited · The Days to ship is longer than that of main item · Please input the value that greater than than the sum of each product minimum purchase quantity · The overall item level promotion limit has been reached. · This product is already in add on deal main item list · This product is already in add on deal sub item list · This product does not share a common shipping channel with the first enabled product. · The Minimum purchase quantity of this product is exceeded the purchase limit of add on deal · This product is already in other add on deal main item list · This product is already in other bundle deal · There are B2C items that can't be added into your promotion · The expired add on deal can't be edited · Only upcoming add on deal can be deleted · The status of this product is abnormal · The product is no stock

## v2.add_on_deal.delete_add_on_deal
`POST /api/v2/add_on_deal/delete_add_on_deal` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Delete Add-on Deal

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-25: update the define; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `add_on_deal_id` | int | ✔ | Shopee's unique identifier for an add on deal activity. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ add_on_deal_id` | int | Shopee's unique identifier for an add on deal activity. |

Lỗi riêng: The add on deal created by admin can't be edited · Only upcoming add on deal can be deleted · The add on deal not existed · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.add_on_deal.delete_add_on_deal_main_item
`POST /api/v2/add_on_deal/delete_add_on_deal_main_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Delete Add-on Deal Main Item

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `add_on_deal_id` | int | ✔ | Shopee's unique identifier for add on deal activity. |
| `main_item_list` | int[] | ✔ | The main items added in this add on deal promotion. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ main_item_list` | int[] | The main items added in this add on deal promotion. |
| `↳ add_on_deal_id` | int | Shopee's unique identifier for add on deal activity. |

Lỗi riêng: The add on deal created by admin can't be edited · The expired add on deal can't be edited · Only upcoming add on deal can be deleted · The item does not existed · The item is already existed in main item · The add on deal not existed · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.add_on_deal.delete_add_on_deal_sub_item
`POST /api/v2/add_on_deal/delete_add_on_deal_sub_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Delete Add-on Deal Sub Item

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `add_on_deal_id` | int | ✔ | Shopee's unique identifier for add on deal activity. |
| `sub_item_list` | object[] | ✔ | The sub items added in this add on deal promotion. |
| `↳ item_id` | int |  | Shopee's unique identifier for an item. |
| `↳ model_id` | int |  | Shopee's unique identifier for a model. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ sub_item_list` | object[] | The sub items added in this add on deal promotion. |
| `↳↳ item_id` | int | Shopee's unique identifier for an item. |
| `↳↳ model_id` | int | Shopee's unique identifier for a model. |
| `↳↳ fail_error` | string |  |
| `↳↳ fail_message` | string |  |
| `↳ add_on_deal_id` | int | Shopee's unique identifier for add on deal activity. |

Lỗi riêng: The add on deal created by admin can't be edited · The expired add on deal can't be edited · Only upcoming add on deal can be deleted · The item does not existed · The add on deal not existed · The item is already existed in sub item · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.add_on_deal.get_add_on_deal_list
`GET /api/v2/add_on_deal/get_add_on_deal_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Customized APP, Swam ERP

Get Add-on Deal List

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-18: update the required data of promotion_status; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `promotion_status` | string | ✔ | The Status of add on deal，default status is all |
| `page_no` | int |  | The default page number is 1 |
| `page_size` | int |  | The default page size is 100 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ add_on_deal_list` | object[] | The list of add on deal id |
| `↳↳ start_time` | int | The time when add on deal activity start. |
| `↳↳ end_time` | int | The time when add on deal activity end |
| `↳↳ promotion_type` | int | The type of add on deal：add on discount =0；gift with mini spend=1 |
| `↳↳ purchase_min_spend` | float | The minimum purchase amount that needs to be met to buy the gift with min.Spend |
| `↳↳ add_on_deal_id` | int | Shopee's unique identifier for an add on deal activity. |
| `↳↳ per_gift_num` | int | Number of gifts that buyers can get |
| `↳↳ promotion_purchase_limit` | int | Max. number of add-on products that a customer can purchase per order. |
| `↳↳ add_on_deal_name` | string | Title of the add on deal |
| `↳↳ source` | int | The create source of bundle deal：Seller=1，shopee admin=0 |
| `↳↳ sub_item_prioriry` | int[] | The display sequence of sub item in buyer side |
| `↳ more` | boolean | This is to indicate whether the promotion list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of promotions. |

Lỗi riêng: Please input correct promotion status: all, ongoing, upcoming, expired · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.add_on_deal.get_add_on_deal
`GET /api/v2/add_on_deal/get_add_on_deal` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Customized APP, Swam ERP

Get Add-on Deal

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `add_on_deal_id` | int | ✔ | Shopee's unique identifier for an add on deal activity. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ start_time` | int | The time when add on deal activity start. |
| `↳ end_time` | int | The time when add on deal activity end |
| `↳ promotion_type` | int | The type of add on deal：add on discount =0；gift with mini spend=1 |
| `↳ purchase_min_spend` | float | The minimum purchase amount that needs to be met to buy the gift with min.Spend |
| `↳ add_on_deal_id` | int | Shopee's unique identifier for an add on deal activity. |
| `↳ per_gift_num` | int | Number of gifts that buyers can get |
| `↳ sub_item_priority` | int[] | The order of the sub item |
| `↳ promotion_purchase_limit` | int | Max. number of add-on products that a customer can purchase per order. |
| `↳ add_on_deal_name` | string | Title of the add on deal |
| `↳ source` | int |  |

Lỗi riêng: The add on deal created by admin can't be edited · Only upcoming add on deal can be deleted · The add on deal not existed · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.add_on_deal.get_add_on_deal_main_item
`GET /api/v2/add_on_deal/get_add_on_deal_main_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Customized APP, Swam ERP

Get Add-on Deal Main Item

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `add_on_deal_id` | int | ✔ | Shopee's unique identifier for add on deal activity. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ main_item_list` | object[] | The main items added in this add on deal promotion. |
| `↳↳ item_id` | int | Shopee's unique identifier for an item. |
| `↳↳ status` | int | The status of add on deal item：enable = 1；disable =2 |
| `↳ add_on_deal_id` | int | Shopee's unique identifier for add on deal activity. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.add_on_deal.get_add_on_deal_sub_item
`GET /api/v2/add_on_deal/get_add_on_deal_sub_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Customized APP, Swam ERP

Get Add-on Deal Sub Item

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `add_on_deal_id` | int | ✔ | Shopee's unique identifier for add on deal activity. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ sub_item_list` | object[] | The sub items added in this add on deal promotion. |
| `↳↳ item_id` | int | Shopee's unique identifier for an item. |
| `↳↳ status` | int | The status of add on deal item：enable = 1；disable =2 |
| `↳↳ sub_item_limit` | int | The purchase limit of each sub item. Only the add on discount can be set and the default limit of gift with mini.spend is 1 |
| `↳↳ model_id` | int | Shopee's unique identifier for a model. |
| `↳↳ price` | object |  |
| `↳↳↳ promo_input_price` | float | Add-on discount price before tax |
| `↳↳↳ promo_price` | float | Add-on discount price after tax |
| `↳ add_on_deal_id` | int | Shopee's unique identifier for add on deal activity. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.add_on_deal.update_add_on_deal
`POST /api/v2/add_on_deal/update_add_on_deal` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Update Add-on Deal

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-25: Update the define; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `add_on_deal_id` | int | ✔ | Shopee's unique identifier for an add on deal activity. |
| `start_time` | int |  | The time when bundle deal activity start.The start time must be 1 hour than current time. |
| `end_time` | int |  | The time when bundle deal activity end. The end time must be later than start time. |
| `purchase_min_spend` | float |  | The minimum purchase amount that needs to be met to buy the gift with min.Spend |
| `per_gift_num` | int |  | Number of gifts that buyers can get |
| `promotion_purchase_limit` | int |  | Max. number of add-on products that a customer can purchase per order. |
| `sub_item_priority` | int[] |  | The order of sub item |
| `add_on_deal_name` | string |  | Title of the add on deal |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ start_time` | int | The time when add on deal activity start. |
| `↳ end_time` | int | The time when add on deal activity end |
| `↳ promotion_type` | int | The type of add on deal：add on discount =0；gift with mini spend=1 |
| `↳ purchase_min_spend` | float | The minimum purchase amount that needs to be met to buy the gift with min.Spend |
| `↳ add_on_deal_id` | int | Shopee's unique identifier for an add on deal activity. |
| `↳ per_gift_num` | int | Number of gifts that buyers can get |
| `↳ promotion_purchase_limit` | int | Max. number of add-on products that a customer can purchase per order. |
| `↳ add_on_deal_name` | string | Title of the add on deal |

Lỗi riêng: The add on deal created by admin can't be edited · At least one sub item should be added in add on deal · The purchase min spend and per gift num is not needed in add on discount · The purchase limit is not needed in gift with mini.spend · The start time of upcoming add on deal can't be shorted · Promotion end time can only be changed to an earlier timing. · The promotion period can't exceed 6 months · The end time should be 1 hour later than start time · The expired add on deal can't be edited · Only upcoming add on deal can be deleted · The name of add on deal can't exceed 25 characters · The add on deal not existed · The {value} of ongoing add on deal can't be edited · Please input page number between 1-1000 · Please input page type between 1-100

## v2.add_on_deal.update_add_on_deal_main_item
`POST /api/v2/add_on_deal/update_add_on_deal_main_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Update Add-on Deal Main Item

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `add_on_deal_id` | int | ✔ | Shopee's unique identifier for add on deal activity. |
| `main_item_list` | object[] | ✔ | The main items added in this add on deal promotion. |
| `↳ item_id` | int | ✔ | Shopee's unique identifier for an item. |
| `↳ status` | int | ✔ | The status of add on deal item：enable = 1；disable =2 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ main_item_list` | object[] | The main items added in this add on deal promotion. |
| `↳↳ item_id` | int | Shopee's unique identifier for an item. |
| `↳↳ status` | int | The status of add on deal item：enable = 1；disable =2 |
| `add_on_deal_id` | int | Shopee's unique identifier for add on deal activity. |

Lỗi riêng: The add on deal created by admin can't be edited · The overall item level promotion limit has been reached. · This product is already in add on deal main item list · This product is already in add on deal sub item list · This product does not share a common shipping channel with the first enabled product. · This product is already in other add on deal main item list · This product is already in other bundle deal · There are B2C items that can't be added into your promotion · The expired add on deal can't be edited · Only upcoming add on deal can be deleted · The status of this product is abnormal · The product is no stock · This item doesn't existed · The item is already existed in main item · The add on deal not existed

## v2.add_on_deal.update_add_on_deal_sub_item
`POST /api/v2/add_on_deal/update_add_on_deal_sub_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Update Add-on Deal Sub Item

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `add_on_deal_id` | int | ✔ | Shopee's unique identifier for add on deal activity. |
| `sub_item_list` | object[] | ✔ | The sub items added in this add on deal promotion. |
| `↳ item_id` | int |  | Shopee's unique identifier for an item. |
| `↳ model_id` | int |  | Shopee's unique identifier for a model. |
| `↳ status` | int |  | The status of add on deal item：enable = 1；disable =2 |
| `↳ sub_item_input_price` | float |  | Add-on discount price before tax |
| `↳ sub_item_limit` | int |  | The purchase limit of sub item.The purchase limit of each sub item. Only the add on discount can be set and the default limit of gift with mini.spend is 1 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ sub_item_list` | object[] | The sub items added in this add on deal promotion. |
| `↳↳ item_id` | int | Shopee's unique identifier for an item. |
| `↳↳ status` | int | The status of add on deal item：enable = 1；disable =2 |
| `↳↳ model_id` | int | Shopee's unique identifier for a model. |
| `↳↳ fail_error` | string |  |
| `↳↳ fail_message` | string |  |
| `↳↳ sub_item_input_price` | float | The discounted price of sub item |
| `↳↳ sub_item_limit` | int | The purchase limit of sub item.The purchase limit of each sub item. Only the add on discount can be set and the default limit of gift with mini.spend is 1 |
| `add_on_deal_id` | int | Shopee's unique identifier for add on deal activity. |

Lỗi riêng: The add on deal created by admin can't be edited · The Days to ship is longer than that of main item · The overall item level promotion limit has been reached. · This product is already in add on deal main item list · This product is already in add on deal sub item list · This product does not share a common shipping channel with the first enabled product. · This product is already in other add on deal main item list · This product is already in other bundle deal · There are B2C items that can't be added into your promotion · The expired add on deal can't be edited · Only upcoming add on deal can be deleted · The status of this product is abnormal · The product is no stock · This item doesn't existed · The add on deal not existed

## v2.add_on_deal.end_add_on_deal
`POST /api/v2/add_on_deal/end_add_on_deal` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

End Add-on Deal

Lịch sử cập nhật: 2022-07-26: Add Error Example information; 2022-06-30: Optimize the Sample information of Request Parameter and Response Parameter; 2021-05-25: update the define; 2021-05-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `add_on_deal_id` | int | ✔ | The identifier of the API request for error tracking |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ add_on_deal_id` | int | The identifier of the API request for error tracking |

Lỗi riêng: The add on deal created by admin can't be edited · Only upcoming add on deal can be deleted · Only the ongoing promotion can be ended · The add on deal not existed · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

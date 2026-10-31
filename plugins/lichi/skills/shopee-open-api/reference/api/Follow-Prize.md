# Module Follow Prize (6 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.follow_prize.add_follow_prize
`POST /api/v2/follow_prize/add_follow_prize` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

OpenAPI add Follow Prize

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-08-15: update for max_price; 2022-07-27: Add Error Example information; 2022-06-14: Optimize the response parameter; 2022-06-14: response parameter add request_id field information

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `follow_prize_name` | string | ✔ | The name of the follow prize,The follow prize name length max limit is 20. |
| `start_time` | timestamp | ✔ | The timing from when the follow prize is valid,the start time later than the current time.If the start time and end time passed in by the seller overlap with other upcoming/ongoing activities, it will prompt "Another Follow Prize voucher already exists during this time period, please set another period." |
| `end_time` | timestamp | ✔ | The timing until when the follow prize is still valid,the end time must be greater than the start time by at least 1 day and end time cannot exceed 3 months after start time.If the start time and end time passed in by the seller overlap with other upcoming/ongoing activities, it will prompt "Another Follow Prize voucher already exists during this time period, please set another period." |
| `usage_quantity` | int32 | ✔ | Please enter a value between 1 and 200000. |
| `min_spend` | float | ✔ | The minimum spend required for using this follow prize. |
| `reward_type` | int32 | ✔ | The reward type of the follow prize.The available values are:1:discount---fix amount,2:discount---by percentage,3:coin cash back. |
| `discount_amount` | float |  | The discount amount set for this particular follow prize.Only fill in when you are creating a fix amount follow prize. |
| `percentage` | int32 |  | The discount percentage set for this particular follow prize. Only fill in when you are creating a discount percentage follow prize or coins cashback follow prize.Discount percentage (reward_type ==2) or Percentage of coins cash back (reward_type==3). |
| `max_price` | float |  | The max amount of discount/value a user can enjoy by using this particular follow prize. It is required to fill in when you are creating a discount percentage follow prize or coins cashback follow prize. max_price >=1 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detailed informations you are querying. |
| `↳ campagin_id` | int32 | The unique identifier for the created follow prize. |

Lỗi riêng: Max number of follow Prize reached (1000 ongoing and upcoming follow Prize) · Another Follow Prize voucher already exists during this time period, please set another period. · Minimum basket price can not be smaller than 49 for coin cashback voucher in TH · please input up to 20 characters of follow prize name · Please enter a value between 1 and 99 · The end time must be greater than the start time by at least 1 day · Please enter a value between 1 and 200000 · Can't create coins cashback in MX · Please enter a start time later than the current time · The start/end time should not exceed 2037-12-31 23:59:59 · Can't create coins cashback in MX · Inner http call failed · parse data failed · data not exist · parameter invalid

## v2.follow_prize.delete_follow_prize
`POST /api/v2/follow_prize/delete_follow_prize` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

delete_follow_prize

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-27: Add Error Example information; 2022-06-14: Optimize the request parameter and response parameter description information; 2021-11-09: updated the campaign_id; 2021-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_id` | int32 | ✔ | The unique identifier for the created follow prize. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detailed informations you are querying. |
| `↳ campagin_id` | int32 | The unique identifier for the created follow prize. |

Lỗi riêng: The promotion id is not existed · Only the upcoming promotions can be deleted · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · The Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · Something wrong. Please try late · request not from gateway

## v2.follow_prize.end_follow_prize
`POST /api/v2/follow_prize/end_follow_prize` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

end follow prize

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-27: Add Error Example information; 2022-06-14: Optimize the request parameter and response parameter description information; 2021-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_id` | int32 | ✔ | The unique identifier for the created follow prize. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detailed informations you are querying. |
| `↳ campaign_id` | int32 | The unique identifier for the created follow prize. |

Lỗi riêng: The promotion id is not existed · Only the ongoing follow prize can be ended · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · The Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · Something wrong. Please try late · request not from gateway

## v2.follow_prize.update_follow_prize
`POST /api/v2/follow_prize/update_follow_prize` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

update_follow_prize

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-27: Add Error Example information; 2022-06-16: Optimize the response parameter type; 2022-06-14: Optimize the request parameters and response parameters information; 2021-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `follow_prize_name` | string |  | The name of the follow prize,The follow prize name length max limit is 20. |
| `campaign_id` | int32 | ✔ | The unique identifier for the created follow prize. |
| `start_time` | timestamp |  | The timing from when the follow prize is valid,the start time later than the current time.If the start time and end time passed in by the seller overlap with other upcoming/ongoing activities, it will prompt "Another Follow Prize voucher already exists during this time period, please set another period." |
| `end_time` | timestamp |  | The timing until when the follow prize is still valid,the end time must be greater than the start time by at least 1 day and end time cannot exceed 3 months after start time.If the start time and end time passed in by the seller overlap with other upcoming/ongoing activities, it will prompt "Another Follow Prize voucher already exists during this time period, please set another period." |
| `usage_quantity` | int32 |  | Please enter a value between 1 and 200000. |
| `min_spend` | float |  | The minimum spend required for using this follow prize. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detailed informations you are querying. |
| `↳ campagin_id` | int32 | The unique identifier for the created follow prize. |

Lỗi riêng: The promotion id is not existed · Max number of follow Prize reached (1000 ongoing and upcoming follow Prize) · Another Follow Prize voucher already exists during this time period, please set another period. · Minimum basket price can not be smaller than 49 for coin cashback voucher in TH · please input up to 20 characters of follow prize name · Please enter a value between 1 and 99 · The end time must be greater than the start time by at least 1 day · Please enter a value between 1 and 200000 · Please enter a start time later than the current time · The start/end time should not exceed 2037-12-31 23:59:59 · Promotion end time can only be changed to an earlier timing. · The expired follow prize can't be updated. · Minimum Basket Price can't be updated which is ongoing · Cannot rename follow prize name which is ongoing · Cannot reduce dispatch quantity.

## v2.follow_prize.get_follow_prize_detail
`GET /api/v2/follow_prize/get_follow_prize_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Customized APP, Swam ERP

get_follow_prize_detail

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-27: Add Error Example information; 2022-06-22: Optimize the response parameter information; 2022-06-14: Optimize the request parameter and response parameter information; 2021-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_id` | int32 |  | The unique identifier for the created follow prize. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detailed informations you are querying. |
| `↳ campaign_status` | string | The status of follow prize,the campagin status have upcoming/ongoing/expired. |
| `↳ campaign_id` | int32 | The unique identifier for the created follow prize. |
| `↳ usage_quantity` | int32 | Please enter a value between 1 and 200000. |
| `↳ start_time` | timestamp | The timing from when the follow prize is valid,the start time later than the current time.If the start time and end time passed in by the seller overlap with other upcoming/ongoing activities, it will prompt "Another Follow Prize voucher already exists during this time period, please set another period." |
| `↳ end_time` | timestamp | The timing until when the follow prize is still valid,the end time must be greater than the start time by at least 1 day and end time cannot exceed 3 months after start time.If the start time and end time passed in by the seller overlap with other upcoming/ongoing activities, it will prompt "Another Follow Prize voucher already exists during this time period, please set another period." |
| `↳ min_spend` | int32 | The minimum spend required for using this follow prize. |
| `↳ reward_type` | int32 | The reward type of the follow prize.The available values are:1:discount---fix amount,2:discount---by percentage,3:coin cash back. |
| `↳ follow_prize_name` | string | The name of the follow prize,The follow prize name length max limit is 20. |
| `↳ discount_amount` | int32 | The discount amount set for this particular follow prize.Only fill in when you are creating a fix amount follow prize. |
| `↳ percentage` | int32 | The discount percentage set for this particular follow prize. Only fill in when you are creating a discount percentage follow prize or coins cashback follow prize.Discount percentage (reward_type ==2) or Percentage of coins cash back (reward_type==3). |
| `↳ max_price` | int32 | The max amount of discount/value a user can enjoy by using this particular follow prize. Only fill in when you are creating a discount percentage follow prize or coins cashback follow prize. |

Lỗi riêng: The promotion id is not existed · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · The Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · Something wrong. Please try late · request not from gateway

## v2.follow_prize.get_follow_prize_list
`GET /api/v2/follow_prize/get_follow_prize_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Customized APP, Swam ERP

OpenAPI get_follow_prize_list

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-27: Add Error Example information; 2022-06-16: Optimize the request parameter and response parameter information; 2021-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 |  | Specifies the page number of data to return in the current call. Default to be 1. |
| `page_size` | int32 |  | Use the 'page_size' filters to control the maximum number of entries to retrieve per page (i.e., per call). Default to be 20 and allowed input is from 1- 100. |
| `status` | string | ✔ | The status filter for retrieving follow prize list. Available value: upcoming/ongoing/expired/all. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detailed informations you are querying. |
| `↳ more` | boolean | This is to indicate whether the comment list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of comments. |
| `↳ follow_prize_list` | object | The list of follow prize. |
| `↳↳ campaign_id` | int32 | The unique identifier for the created follow prize. |
| `↳↳ campaign_status` | string | The status of follow prize,the campagin status have upcoming/ongoing/expired. |
| `↳↳ follow_prize_name` | string | The name of the follow prize,The follow prize name length max limit is 20. |
| `↳↳ start_time` | timestamp | The timing from when the follow prize is valid,the start time later than the current time.If the start time and end time passed in by the seller overlap with other upcoming/ongoing activities, it will prompt "Another Follow Prize voucher already exists during this time period, please set another period." |
| `↳↳ end_time` | timestamp | The timing until when the follow prize is still valid,the end time must be greater than the start time by at least 1 day and end time cannot exceed 3 months after start time.If the start time and end time passed in by the seller overlap with other upcoming/ongoing activities, it will prompt "Another Follow Prize voucher already exists during this time period, please set another period." |
| `↳↳ usage_quantity` | int32 | Please enter a value between 1 and 200000. |
| `↳↳ claimed` | int32 | This is to indicate the quantity of voucher claimed. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · The Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · Something wrong. Please try late · request not from gateway

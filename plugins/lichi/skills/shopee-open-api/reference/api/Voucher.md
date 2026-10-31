# Module Voucher (6 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.voucher.add_voucher
`POST /api/v2/voucher/add_voucher` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Add voucher

Lịch sử cập nhật: 2022-07-27: Add Error Example information; 2022-07-07: Optimize the display_start_time of request parameters description; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter; 2021-12-15: Request Parameter add new field display_start_time; 2021-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `voucher_name` | string | ✔ | The name of the voucher. |
| `voucher_code` | string | ✔ | The code of the voucher. |
| `start_time` | timestamp | ✔ | The timing from when the voucher is valid; so buyer is allowed to claim and to use. Field can only be updated if voucher has not started. |
| `end_time` | timestamp | ✔ | The timing until when the voucher is still valid. Any time after this end_time, buyer is not allowed to claim or to use. |
| `voucher_type` | int32 | ✔ | The type of the voucher. The available values are: 1: shop voucher, 2: product voucher. |
| `reward_type` | int32 | ✔ | The reward type of the voucher. The available values are: 1: fix_amount voucher, 2: discount_percentage voucher, 3: coin_cashback voucher. |
| `usage_quantity` | int32 | ✔ | The number of times for this particular voucher could be used. |
| `min_basket_price` | float | ✔ | The minimum spend required for using this voucher. |
| `discount_amount` | float |  | The discount amount set for this particular voucher. Only fill in when you are creating a fix amount voucher. |
| `percentage` | int32 |  | The discount percentage set for this particular voucher. Only fill in when you are creating a discount percentage voucher or coins cashback voucher. |
| `max_price` | float |  | The max amount of discount/value a user can enjoy by using this particular voucher. Only fill in when you are creating a discount percentage voucher or coins cashback voucher.If no cap limit, can set to be 0. |
| `display_channel_list` | int32[] |  | The FE channel where the voucher will be displayed. The available values are: 1: display_all 3: feed, 4: live streaming, [] (empty - which is hidden). |
| `item_id_list` | int64[] |  | The list of items which is applicable for the voucher. Only fill in when you are creating a product type of voucher. |
| `display_start_time` | int32 |  | The timing of when voucher is displayed on shop pages; so buyer is allowed to claim.display_start_time must be left empty if the display_channel_list is empty (when voucher is hidden), otherwise it will show error. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detailed informations you are querying. |
| `↳ voucher_id` | int64 | The unique identifier for the created voucher. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Min_basket_price must be higher than the fix amount if Min_basket_price is not 0. · Some items cannot be uploaded as they are b2c products in FBS shop · Duplicated voucher code. · Voucher code doesn't meet the requirement. Only support 0-9 or A-Z or a-z. Up to 5 characters. · Cannot create coin cashback voucher. · Voucher display channel is set wrongly.

## v2.voucher.delete_voucher
`POST /api/v2/voucher/delete_voucher` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Delete voucher

Lịch sử cập nhật: 2025-09-08: select voucher_id type as int64; 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter; 2021-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `voucher_id` | int64 | ✔ | The unique identifier for the voucher you want to delete. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ voucher_id` | int64 | The unique identifier for the voucher it is being deleted. |

Lỗi riêng: Can only delete upcoming voucher. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · request not from gateway · The Voucher created in Shopee admin/Shop Game/Follow Prize/Member ship/Voucher campaign can't be updated

## v2.voucher.end_voucher
`POST /api/v2/voucher/end_voucher` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

End Voucher

Lịch sử cập nhật: 2025-09-08: select voucher_id as int64; 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter; 2021-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `voucher_id` | int64 | ✔ | The unique identifier for the voucher you want to end now. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detailed informations you are querying. |
| `↳ voucher_id` | int64 | The unique identifier for the voucher it is being ended. |

Lỗi riêng: Can only end the ongoing voucher. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · request not from gateway · The Voucher created in Shopee admin/Shop Game/Follow Prize/Member ship/Voucher campaign can't be updated · Cannot update status for expired voucher.

## v2.voucher.update_voucher
`POST /api/v2/voucher/update_voucher` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

Update voucher

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter; 2021-12-15: Request Parameter add new field display_start_time; 2021-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `voucher_id` | int64 | ✔ | The unique identifier of the voucher which is going to be updated. |
| `voucher_name` | string |  | The name of the voucher |
| `start_time` | timestamp |  | The timing from when the voucher is valid; so buyer is allowed to claim and to use. Field can only be updated if voucher has not started. |
| `end_time` | timestamp |  | The timing until when the voucher is still valid. Any time after this end_time, buyer is not allowed to claim or to use. |
| `usage_quantity` | int32 |  | The number of times for this particular voucher could be used. |
| `min_basket_price` | float |  | The minimum spend required for using this voucher. |
| `discount_amount` | float |  | The discount amount set for this particular voucher. Only fill in when you are updating a fix amount voucher. |
| `percentage` | int32 |  | The discount percentage set for this particular voucher. Only fill in when you are updating a discount percentage voucher or coins cashback voucher. |
| `max_price` | float |  | The max amount of discount/value a user can enjoy by using this particular voucher. Only fill in when you are updating a discount percentage voucher or coins cashback voucher. |
| `display_channel_list` | int32[] |  | The FE channel where the voucher will be displayed. The available values are: 1: display_all, 2: order page, 3: feed, 4: live streaming, [] (empty - which is hidden). |
| `item_id_list` | int64[] |  | The list of items which is applicable for the voucher. Only fill in when you are updating a product type of voucher. |
| `display_start_time` | int64 |  | The timing of when voucher is displayed on shop pages; so buyer is allowed to claim. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detailed informations you are querying. |
| `↳ voucher_id` | int64 | The unique identifier of the voucher which is being updated. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · request not from gateway · The Voucher created in Shopee admin/Shop Game/Follow Prize/Member ship/Voucher campaign can't be updated · Min_basket_price must be higher than the fix amount if Min_basket_price is not 0. · Some items cannot be uploaded as they are b2c products in FBS shop

## v2.voucher.get_voucher
`GET /api/v2/voucher/get_voucher` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Customized APP, Swam ERP

Get Voucher Detail

Lịch sử cập nhật: 2024-12-13: Add "voucher_purpose": 7; 2024-05-08: add target_voucher and usecase; 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter; 2022-03-29: update api name

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `voucher_id` | int64 | ✔ | The unique identifier of a voucher used to query the voucher details. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detailed informations you are querying. |
| `↳ voucher_id` | int64 | The unique identifier of the voucher whose details are returned. |
| `↳ voucher_code` | string | Voucher Code |
| `↳ voucher_name` | string | Voucher Name |
| `↳ voucher_type` | int32 | The type of the voucher. The available values are: 1: shop voucher, 2: product voucher. |
| `↳ reward_type` | int32 | The reward type of the voucher. The available values are: 1: fix_amount voucher, 2: discount_percentage voucher, 3: coin_cashback voucher. |
| `↳ usage_quantity` | int32 | The number of times for this particular voucher could be used. |
| `↳ current_usage` | int32 | Up till now, how many times has this particular voucher already been used. |
| `↳ start_time` | timestamp | The timing from when the voucher is valid; so buyer is allowed to claim and to use. |
| `↳ end_time` | timestamp | The timing until when the voucher is still valid. Any time after this end_time, buyer is not allowed to claim or to use. |
| `↳ is_admin` | boolean | If the voucher is created by Shopee or not. |
| `↳ voucher_purpose` | int32 | The use case for the voucher. The available values are: 0: normal; 1: welcome, 2: referral; 3: shop_follow; 4:shop_game, 5: free_gift, 6: membership，7: Ads |
| `↳ display_channel_list` | int32[] | The FE channel where the voucher will be displayed. The available values are: 1: display_all, 2: order page, 3: feed, 4: live streaming, [] (empty - which is hidden). |
| `↳ min_basket_price` | float | The minimum spend required for using this voucher. |
| `↳ percentage` | int32 | The discount percentage is set for this particular voucher. Only when it is a discount percentage voucher or coins cashback voucher, api will return a value. |
| `↳ max_price` | float | The max amount of discount/value a user can enjoy by using this particular voucher. Only when it is a discount percentage voucher or coins cashback voucher, api will return a value. |
| `↳ discount_amount` | float | The discount amount set for this particular voucher. Only when it is a fix amount voucher, api will return a value. |
| `↳ cmt_voucher_status` | int32 | The voucher status in CMT. The available values are: 1:review, 2: approved, 3:reject. Only when this voucher is attending CMT campaign and not being rejected, api will return a value. |
| `↳ item_id_list` | int64[] | The list of items which is applicable for the voucher. Only return a value when it is a product type of voucher. |
| `↳ display_start_time` | timestamp | The timing of when voucher is displayed on shop pages; so buyer is allowed to claim. |
| `↳ target_voucher` | int32 | The field is used to mark new user voucher/ repeat buyer voucher 1: new user voucher 2: repeat buyer voucher: with 1 orders 3. repeat buyer voucher: with 2 orders |
| `↳ usecase` | int32 | usecase indicates a specific business scenario that the voucher is created and used for, i.e., new buyer voucher, live voucher, follow shop voucher, etc. shop voucher:1 product voucher:2 new buyer voucher:3 repeat buyer voucher:4 private voucher:5 live voucher:6 video voucher:7 campaign voucher:8 follow prize voucher:9 membership voucher:10 game prize voucher:11 sample voucher:12 |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.voucher.get_voucher_list
`GET /api/v2/voucher/get_voucher_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Customer Service, Customized APP, Swam ERP

Get Voucher List

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter; 2021-12-15: Response Parameter add new field display_start_time; 2021-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 |  | Specifies the page number of data to return in the current call. Default to be 1 and allowed input is from 1 - 5000. |
| `page_size` | int32 |  | Use the 'page_size' filters to control the maximum number of entries to retrieve per page (i.e., per call). Default to be 20 and allowed input is from 1- 100. |
| `status` | string | ✔ | The status filter for retrieving voucher list. Available value: upcoming/ongoing/expired/all. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detailed informations you are querying. |
| `↳ more` | boolean | This is to indicate whether the comment list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of comments. |
| `↳ voucher_list` | object[] | The list of voucher. |
| `↳↳ voucher_id` | int64 | The unique identifier for a voucher. |
| `↳↳ voucher_code` | string | Voucher Code |
| `↳↳ voucher_name` | string | Voucher Name |
| `↳↳ voucher_type` | int32 | The type of the voucher. The available values are: 1: shop voucher, 2: product voucher. |
| `↳↳ reward_type` | int32 | The reward type of the voucher. The available values are: 1: fix_amount voucher, 2: discount_percentage voucher, 3: coin_cashback voucher. |
| `↳↳ usage_quantity` | int32 | The number of times for this particular voucher could be used. |
| `↳↳ current_usage` | int32 | Up till now, how many times has this particular voucher already been used. |
| `↳↳ start_time` | timestamp | The timing from when the voucher is valid; so buyer is allowed to claim and to use. |
| `↳↳ end_time` | timestamp | The timing until when the voucher is still valid. Any time after this end_time, buyer is not allowed to claim or to use. |
| `↳↳ is_admin` | boolean | If the voucher is created by Shopee or not. |
| `↳↳ voucher_purpose` | int32 | The use case for the voucher. The available values are: 0: normal; 1: welcome, 2: referral; 3: shop_follow; 4:shop_game, 5: free_gift, 6: membership |
| `↳↳ discount_amount` | float | The discount amount set for this particular voucher. Only when it is a fix amount voucher, api will return a value. |
| `↳↳ percentage` | int32 | The discount percentage set for this particular voucher. Only when it is a discount percentage voucher or coins cashback voucher, api will return a value. |
| `↳↳ cmt_voucher_status` | int32 | The voucher status in CMT. The available values are: 1:review, 2: approved, 3:reject. Only when this voucher is attending CMT campaign and not being rejected, api will return a value. |
| `↳↳ display_start_time` | timestamp | The timing of when voucher is displayed on shop pages; so buyer is allowed to claim. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Something is wrong. Please try later. · Shopid is invalid. · shopid is invalid · request not from gateway

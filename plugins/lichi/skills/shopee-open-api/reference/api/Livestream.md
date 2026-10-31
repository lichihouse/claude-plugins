# Module Livestream (25 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.livestream.upload_image
`POST /api/v2/livestream/upload_image` · loại: User · app được gọi: Livestream Management

Upload an image as the live stream cover.(For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `image` | file | ✔ | The image file to upload. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ image_url` | string | The image URL |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The image may contain sensitive content, please use another one · No image found in the request · The image size cannot exceed {{image_size_limit}} bytes · Invalid image format, only support jpg/jpeg/png/gif) · You are not authorized · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.livestream.create_session
`POST /api/v2/livestream/create_session` · loại: User · app được gọi: Livestream Management

Create a new live stream, include basic information, like cover, title, description, type (test live or normal live). (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `title` | string | ✔ | The title of livestream session, cannot exceed 200 characters. |
| `description` | string |  | The description of livestream session, cannot exceed 200 characters. |
| `cover_image_url` | string | ✔ | The cover image URL of livestream session. Please call the v2.livestream.upload_image to upload the cover image file and get the cover_image_url. |
| `is_test` | boolean |  | Indicate whether the livestream session is for testing purpose only. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ session_id` | int64 | The identifier of livestream session. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The description cannot exceed 200 characters · Invalid cover_image_url · Invalid title · The last session(session_id:{{sid}}) is still ongoing, please end it first · You do not have permission to livestream · You are not authorized · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · The description contains sensitive content · The title contains sensitive content · Server internal error: {{err_msg}}

## v2.livestream.update_session
`POST /api/v2/livestream/update_session` · loại: User · app được gọi: Livestream Management

Update live stream information, including cover, title, description, and type (test live or normal live). (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |
| `title` | string | ✔ | The title of the livestream session, cannot exceed 200 characters. |
| `description` | string |  | The description of the livestream session, cannot exceed 200 characters. |
| `cover_image_url` | string | ✔ | The cover image url of the livestream session. Please call the v2.livestream.upload_image to upload the cover image file and get the cover_image_url. |
| `is_test` | boolean | ✔ | Indicate whether this livestream session if for testing purpose only. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The description cannot exceed 200 characters · Invalid cover_image_url · Invalid session_id · Invalid title · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · The description contains sensitive content · The title contains sensitive content · Server internal error: {{err_msg}}

## v2.livestream.start_session
`POST /api/v2/livestream/start_session` · loại: User · app được gọi: Livestream Management

Start Live. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |
| `domain_id` | int64 | ✔ | The identifier of the stream domain. |
| `ai_stream` | boolean |  | Only available in PH region. To support transparent experiences on Shopee Live, please select this option if AI-generated streamer is used for live-streaming. Failure of doing so may lead to warning or termination. Learn more about the policy: PH: https://seller.shopee.ph/edu/article/25213 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid domain_id · Invalid session_id · You do not have permission to livestream · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is ended · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is ongoing

## v2.livestream.end_session
`POST /api/v2/livestream/end_session` · loại: User · app được gọi: Livestream Management

End Live. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid session_id · Cannot end session because it's started through Shopee App or Live PC · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing · The information you queried is not found. · Wrong parameters, detail: {msg}.

## v2.livestream.get_session_detail
`GET /api/v2/livestream/get_session_detail` · loại: User · app được gọi: Livestream Management

Get basic information about the live streaming room, including cover, title, description, type (test live or normal live), create time, update time, stream url, etc. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ session_id` | int64 | The identifier of livestream session. |
| `↳ title` | string | The title of the livestream session. |
| `↳ description` | string | The description of the livestream session. |
| `↳ cover_image_url` | string | The cover image URL of the livestream session. |
| `↳ status` | int32 | The status of the livestream session, the enumeration values are as follows: 0 - Initial 1 - Ongoing 2 - Ended |
| `↳ share_url` | string | The share link of the livestream session. |
| `↳ is_test` | boolean | Indicate whether this livestream session if for testing purpose only. |
| `↳ create_time` | int64 | The creation time of the livestream session. It's unix timestamp in seconds. |
| `↳ update_time` | int64 | The update time of the livestream session. It's unix timestamp in seconds. |
| `↳ start_time` | int64 | The start time of the livestream session, 0 if session is not started yet. It's unix timestamp in seconds. |
| `↳ end_time` | int64 | The end time of livestream session, 0 if session is not ended yet. It's unix timestamp in seconds. |
| `↳ stream_url_list` | object |  |
| `↳↳ push_url` | string | The push stream url for the livestream session. |
| `↳↳ push_key` | string | The push stream key for the livestream session. |
| `↳↳ play_url` | string | The pull stream url of the livestream session. |
| `↳↳ domain_id` | int64 | The identifier of the stream domain, need to be passed in request for v2.livestream.start_session. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid session_id · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is not exist · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.livestream.add_item_list
`POST /api/v2/livestream/add_item_list` · loại: User · app được gọi: Livestream Management

Add items to item bag. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |
| `item_list` | object[] | ✔ | The list of item to add. |
| `↳ item_id` | int64 | ✔ | Shopee's unique identifier for an item. |
| `↳ shop_id` | int64 | ✔ | The shop id of this item. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Item(item_id:{{item_id}}) is duplicated in the request · Invalid item_list, item_id and shop_id must greater than 0 · Invalid session_id · Item(item_id:{{item_id}}) is not exist · You are not allowed to view my like items · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is ended

## v2.livestream.delete_item_list
`POST /api/v2/livestream/delete_item_list` · loại: User · app được gọi: Livestream Management

Delete items from item bag. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |
| `item_list` | object[] | ✔ | The list of item to delete. |
| `↳ item_id` | int64 | ✔ | Shopee's unique identifier for an item. |
| `↳ shop_id` | int64 | ✔ | The shop id of this item. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid item_list, item_id and shop_id must greater than 0 · Invalid session_id · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is ended · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing · The information you queried is not found.

## v2.livestream.update_item_list
`POST /api/v2/livestream/update_item_list` · loại: User · app được gọi: Livestream Management

Update the order of items in item bag. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |
| `item_list` | object[] | ✔ | The list of item with updated order. |
| `↳ item_id` | int64 | ✔ | Shopee's unique identifier for an item. |
| `↳ shop_id` | int64 | ✔ | The shop id of this item. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Item(item_id:{{item_id}}) is not exist in the shopping bag but exist in this request, please use add API If you want to add item · Item(item_id:{{item_id}}) is exist in the shopping bag but not exist in this request, please use delete API If you want to delete item · Item(item_id:{{item_id}}) is duplicated in the request · Invalid item_list, item_id and shop_id must greater than 0 · Invalid session_id · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is ended

## v2.livestream.get_item_count
`GET /api/v2/livestream/get_item_count` · loại: User · app được gọi: Livestream Management

Get the number of items in the shopping bag, including the current number of items in the shopping bag, the upper limit of the number, etc. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ item_count` | int64 | The number of items in the shopping bag of this session. |
| `↳ max_item_count` | int64 | The maximum number of items allowed in the shopping bag of this session. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid session_id · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is ended · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing · The information you queried is not found. · Wrong parameters, detail: {msg}.

## v2.livestream.get_item_list
`GET /api/v2/livestream/get_item_list` · loại: User · app được gọi: Livestream Management

Get the detail information of item in item bag, including item id, item serial number, etc.(For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |
| `offset` | int32 | ✔ | Specifies the starting entry of data to return in the current call. Default is 0, if data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of data. |
| `↳ next_offset` | int64 | If more is true, this value need set to next request offset. |
| `↳ list` | object[] |  |
| `↳↳ item_no` | int64 | The order of this item in the shopping bag of current session, start from 1. |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ shop_id` | int64 | The shop id of this item. |
| `↳↳ name` | string | Name of the item in local language. |
| `↳↳ image_url` | string | The image url of this item. |
| `↳↳ price_info` | object |  |
| `↳↳↳ currency` | string | The three-digit code representing the currency unit used for the item. |
| `↳↳↳ current_price` | float | The current price of the item in the listing currency. If product under an ongoing promotion, current_price will be the promotion price. |
| `↳↳↳ original_price` | float | The original price of the item in the listing currency. |
| `↳↳ affiliate_info` | object |  |
| `↳↳↳ commission_rate` | float | The commission rate that the streamer can get, for example, 0.1 means 10%. |
| `↳↳↳ is_campaign` | boolean | Whether participate in a campaign project (generally, the commission will be higher) |
| `↳↳↳ campaign_mcn_name` | string | MCN agency that initiated this campaign |
| `↳↳↳ campaign_start_time` | int64 | Campaign start time, it's unix timestamp in seconds. |
| `↳↳↳ campaign_end_time` | int64 | Campaign end time, it's unix timestamp in seconds. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid page_size, page_size must larger than 0 and cannot exceed {{limit}} · Invalid session_id · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing · The information you queried is not found. · Wrong parameters, detail: {msg}.

## v2.livestream.update_show_item
`POST /api/v2/livestream/update_show_item` · loại: User · app được gọi: Livestream Management

Set the showing item. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |
| `item_id` | int64 | ✔ | Shopee's unique identifier for an item. |
| `shop_id` | int64 | ✔ | The shop id of this item. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid item_id · Invalid session_id · Invalid shop_id · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing · The information you queried is not found.

## v2.livestream.delete_show_item
`POST /api/v2/livestream/delete_show_item` · loại: User · app được gọi: Livestream Management

Unshow showing item. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid session_id · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is ended · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing · The information you queried is not found. · Wrong parameters, detail: {msg}.

## v2.livestream.get_show_item
`GET /api/v2/livestream/get_show_item` · loại: User · app được gọi: Livestream Management

Get the showing item. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ has_show_item` | boolean | Whether has the showing item. |
| `↳ item` | object |  |
| `↳↳ item_no` | int64 | The order of this item in the shopping bag of current session, start from 1. Only return item_no when showing item is in the shopping bag of current session. |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ shop_id` | int64 | The shop id of this item. |
| `↳↳ name` | string | Name of the item in local language. |
| `↳↳ image_url` | string | The image url of this item. |
| `↳↳ price_info` | object |  |
| `↳↳↳ currency` | string | The three-digit code representing the currency unit used for the item. |
| `↳↳↳ current_price` | float | The current price of the item in the listing currency. If product under an ongoing promotion, current_price will be the promotion price. |
| `↳↳↳ original_price` | float | The original price of the item in the listing currency. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid session_id · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is ended · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing · The information you queried is not found. · Wrong parameters, detail: {msg}.

## v2.livestream.get_like_item_list
`GET /api/v2/livestream/get_like_item_list` · loại: User · app được gọi: Livestream Management

Get the item list of My Likes tab.(For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `offset` | int32 | ✔ | Specifies the starting entry of data to return in the current call. Default is 0, if data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. |
| `keyword` | string |  | Search items with name matching this keyword. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of data. |
| `↳ next_offset` | int32 | If more is true, this value need set to next request offset. |
| `↳ list` | object[] |  |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ shop_id` | int64 | The shop id of this item. |
| `↳↳ name` | string | Name of the item in local language. |
| `↳↳ image_url` | string | The image url of this item. |
| `↳↳ price_info` | object |  |
| `↳↳↳ currency` | string | The three-digit code representing the currency unit used for the item. |
| `↳↳↳ current_price` | float | The current price of the item in the listing currency. If product under an ongoing promotion, current_price will be the promotion price. |
| `↳↳↳ original_price` | float | The original price of the item in the listing currency. |
| `↳↳ affiliate_info` | object |  |
| `↳↳↳ commission_rate` | float | The commission rate that the streamer can get, for example, 0.1 means 10%. |
| `↳↳↳ is_campaign` | boolean | Whether participate in a campaign project (generally, the commission will be higher). |
| `↳↳↳ campaign_mcn_name` | string | MCN agency that initiated this campaign. |
| `↳↳↳ campaign_start_time` | int64 | Campaign start time, it's unix timestamp in seconds. |
| `↳↳↳ campaign_end_time` | int64 | Campaign end time, it's unix timestamp in seconds. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid page_size, page_size must larger than 0 and cannot exceed {{limit}} · You are not allowed to view my like items · You are not authorized · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.livestream.get_recent_item_list
`GET /api/v2/livestream/get_recent_item_list` · loại: User · app được gọi: Livestream Management

Get the item list of the Recently tab. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `offset` | int32 | ✔ | Specifies the starting entry of data to return in the current call. Default is 0, if data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of data. |
| `↳ next_offset` | int64 | If more is true, this value need set to next request offset. |
| `↳ list` | object[] |  |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ shop_id` | int64 | The shop id of this item. |
| `↳↳ name` | string | Name of the item in local language. |
| `↳↳ image_url` | string | The image url of this item. |
| `↳↳ price_info` | object |  |
| `↳↳↳ currency` | string | The three-digit code representing the currency unit used for the item. |
| `↳↳↳ current_price` | float | The current price of the item in the listing currency. If product under an ongoing promotion, current_price will be the promotion price. |
| `↳↳↳ original_price` | float | The original price of the item in the listing currency. |
| `↳↳ affiliate_info` | object |  |
| `↳↳↳ commission_rate` | float | The commission rate that the streamer can get, for example, 0.1 means 10%. |
| `↳↳↳ is_campaign` | boolean | Whether participate in a campaign project (generally, the commission will be higher) |
| `↳↳↳ campaign_mcn_name` | string | MCN agency that initiated this campaign |
| `↳↳↳ campaign_start_time` | int64 | Campaign start time, it's unix timestamp in seconds. |
| `↳↳↳ campaign_end_time` | int64 | Campaign end time, it's unix timestamp in seconds. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid page_size, page_size must larger than 0 and cannot exceed {{limit}} · You are not authorized · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.livestream.get_item_set_list
`GET /api/v2/livestream/get_item_set_list` · loại: User · app được gọi: Livestream Management

Get the product set of the live stream, including the product set name, id, and item number. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `offset` | int32 | ✔ | Specifies the starting entry of data to return in the current call. Default is 0, if data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. |
| `keyword` | string |  | Search the item set with it's name matching the keyword. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of data. |
| `↳ next_offset` | int64 | If more is true, this value need set to next request offset. |
| `↳ list` | object[] |  |
| `↳↳ item_set_id` | int64 | The identifier of the item set. |
| `↳↳ item_set_name` | string | The name of the item set. |
| `↳↳ item_count` | int64 | The number of items in this item set. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid page_size, page_size must larger than 0 and cannot exceed {{limit}} · You are not authorized · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.livestream.get_item_set_item_list
`GET /api/v2/livestream/get_item_set_item_list` · loại: User · app được gọi: Livestream Management

Get the item list of the product set, including item name, id, etc. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_set_id` | int64 | ✔ | The identifier of the item set. |
| `offset` | int32 | ✔ | Specifies the starting entry of data to return in the current call. Default is 0, if data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of data. |
| `↳ next_offset` | int64 | If more is true, this value need set to next request offset. |
| `↳ list` | object[] |  |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ shop_id` | int64 | The shop id of this item. |
| `↳↳ name` | string | Name of the item in local language. |
| `↳↳ image_url` | string | The image url of this item. |
| `↳↳ price_info` | object |  |
| `↳↳↳ currency` | string | The three-digit code representing the currency unit used for the item. |
| `↳↳↳ current_price` | float | The current price of the item in the listing currency. If product under an ongoing promotion, current_price will be the promotion price. |
| `↳↳↳ original_price` | float | The original price of the item in the listing currency. |
| `↳↳ affiliate_info` | object |  |
| `↳↳↳ commission_rate` | float | The commission rate that the streamer can get, for example, 0.1 means 10%. |
| `↳↳↳ is_campaign` | boolean | Whether participate in a campaign project (generally, the commission will be higher) |
| `↳↳↳ campaign_mcn_name` | string | MCN agency that initiated this campaign |
| `↳↳↳ campaign_start_time` | int64 | Campaign start time, it's unix timestamp in seconds. |
| `↳↳↳ campaign_end_time` | int64 | Campaign end time, it's unix timestamp in seconds. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid item_set_ids · Invalid page_size, page_size must larger than 0 and cannot exceed {{limit}} · The item set {{item_set_id}} you provided is not exist · You are not authorized · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.livestream.apply_item_set
`POST /api/v2/livestream/apply_item_set` · loại: User · app được gọi: Livestream Management

Add product set to item bag. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |
| `item_set_ids` | int64[] | ✔ | List of item set id to apply. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid item_set_ids · Invalid session_id · The item set {{item_set_id}} you provided is not exist · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is ended · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing

## v2.livestream.get_session_metric
`GET /api/v2/livestream/get_session_metric` · loại: User · app được gọi: Livestream Management

Get real-time indicator data of the live stream room, including the number of likes, comments, shares, views, etc.(For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ gmv` | float | Value of placed orders (paid and unpaid) during Livestream, including sales from cancelled orders. |
| `↳ atc` | int64 | Number of "Add To Cart" button clicked for all products in the orange bag during livestream. |
| `↳ ctr` | float | Number of products clicks divided by Number of Livestream views. |
| `↳ co` | float | Amount of product orders from the stream divided by Amount of product clicks from the stream. |
| `↳ orders` | int64 | Number of placed orders (paid and unpaid) during Livestream, including cancelled orders. |
| `↳ ccu` | int64 | Number of viewers during stream. |
| `↳ engage_ccu_1m` | int64 | Number of Concurrent viewers in the stream that have watched for more than 1 minute. |
| `↳ peak_ccu` | int64 | Highest number of viewers during stream. |
| `↳ likes` | int64 | Number of "Like" clicked during livestream. |
| `↳ comments` | int64 | Number of comments acquired during the stream. |
| `↳ shares` | int64 | Number of shares created during the stream. |
| `↳ views` | int64 | Number of views from the stream. |
| `↳ avg_viewing_duration` | int64 | Average of Viewer duration watching in the stream. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid session_id · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.livestream.get_session_item_metric
`GET /api/v2/livestream/get_session_item_metric` · loại: User · app được gọi: Livestream Management

Get real-time indicator data of live stream products, including product clicks, add-to-cart, etc. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |
| `offset` | int32 | ✔ | Specifies the starting entry of data to return in the current call. Default is 0, if data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of data. |
| `↳ next_offset` | int32 | If more is true, this value need set to next request offset. |
| `↳ list` | object[] |  |
| `↳↳ item` | object |  |
| `↳↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳↳ shop_id` | int64 | The shop id of the item. |
| `↳↳↳ name` | string | Name of the item in local language. |
| `↳↳↳ image_url` | string | The image url of the item. |
| `↳↳↳ price_info` | object |  |
| `↳↳↳↳ currency` | string | The three-digit code representing the currency unit used for the item. |
| `↳↳↳↳ current_price` | float | The current price of the item in the listing currency. If product under an ongoing promotion, current_price will be the promotion price. |
| `↳↳↳↳ original_price` | float | The original price of the item in the listing currency. |
| `↳↳ metric` | object |  |
| `↳↳↳ item_clicks` | int64 | Number of product clicks. |
| `↳↳↳ atc` | int64 | Number of "Add To Cart" button clicked for all products in the orange bag during livestream. |
| `↳↳↳ sold_items` | int64 | Number of product sold. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid page_size, page_size must larger than 0 and cannot exceed {{limit}} · Invalid session_id · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing · The information you queried is not found. · Wrong parameters, detail: {msg}.

## v2.livestream.get_latest_comment_list
`GET /api/v2/livestream/get_latest_comment_list` · loại: User · app được gọi: Livestream Management

Get live stream room comments in the last 10 seconds, including user id, user name, comment id, comment content, and comment time. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |
| `offset` | int32 |  | Specifies the starting entry of data to return in the current call. Default is 0, if data is more than one page, the offset can be some entry to start next call. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ next_offset` | int32 | The offset for next page request. |
| `↳ list` | object[] |  |
| `↳↳ comment_id` | int64 | The identifier of comment. |
| `↳↳ content` | string | The content of comment. |
| `↳↳ timestamp` | timestamp | Timestamp for posting comment. It's unix timestamp in seconds. |
| `↳↳ user_id` | int64 | The user id of the one who posted the comment. |
| `↳↳ username` | string | The username of the one who posted comment. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid session_id · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.livestream.post_comment
`POST /api/v2/livestream/post_comment` · loại: User · app được gọi: Livestream Management

Post comment in the live stream as streamer. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |
| `content` | string | ✔ | The comment content, cannot exceed 150 characters. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ comment_id` | int64 | The identifier of the comment. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The content cannot exceed 150 characters · Cannot send empty comment · Invalid session_id · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · The content contains sensitive content · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing

## v2.livestream.ban_user_comment
`POST /api/v2/livestream/ban_user_comment` · loại: User · app được gọi: Livestream Management

Ban the user from posting comments. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |
| `ban_user_id` | int64 | ✔ | The user id that will be banned from posting comments. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · You can not ban yourself · Invalid session_id · Invalid {{uid_param}} · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing · The user(user_id:{{uid}}) is not exist

## v2.livestream.unban_user_comment
`POST /api/v2/livestream/unban_user_comment` · loại: User · app được gọi: Livestream Management

Unban a user from posting comments. (For TW, ID, TH, PH, MY, SG, VN)

Lịch sử cập nhật: 2026-01-13: Update API Description; 2025-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `session_id` | int64 | ✔ | The identifier of livestream session. |
| `unban_user_id` | int64 | ✔ | The user ID that will be unbanned from posting comments. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · You can not ban yourself · Invalid session_id · Invalid {{uid_param}} · You are not authorized · The session(session_id:{{sid}}) is not belong to you · The API is not supported for current region · Parse data error: {{err_msg}} · Too many requests, please try again later · Server internal error: {{err_msg}} · The session(session_id:{{sid}}) is not exist · The session(session_id:{{sid}}) is not ongoing · The user(user_id:{{uid}}) is not exist

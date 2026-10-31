# Module TopPicks (4 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.top_picks.get_top_picks_list
`GET /api/v2/top_picks/get_top_picks_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Customized APP, Swam ERP

get one TopPicks

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter; 2021-06-17: correct the url path

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ collection_list` | object[] | The top picks list in this shop. |
| `↳↳ is_activated` | boolean | whether collection is activated. |
| `↳↳ item_list` | object[] | The items of top picks |
| `↳↳↳ item_name` | string | The name of item. |
| `↳↳↳ item_id` | int32 | The id of item. |
| `↳↳↳ current_price` | float | The price before tax of item. |
| `↳↳↳ inflated_price_of_current_price` | float | The price after tax of item. |
| `↳↳↳ sales` | int32 | The sales of item. |
| `↳↳ top_picks_id` | int32 | collection id. |
| `↳↳ name` | string | The title of top picks. |

Lỗi riêng: The created top picks can not more than {num}. · Inner http call failed · parse data failed · data not exist · parameter invalid · The top-picks has duplicative item. · The Top-picks name is exist, please change to other name. · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · You don't have permission for the operation · Something wrong. Please try later. · Something wrong. Please try later. · shopid is invalid · Shopid is invalid

## v2.top_picks.add_top_picks
`POST /api/v2/top_picks/add_top_picks` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

add one collection

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter; 2021-06-17: correct url path

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `name` | string | ✔ |  |
| `item_id_list` | int64[] | ✔ |  |
| `is_activated` | boolean | ✔ |  |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ collection_list` | object[] | The top picks list in this shop. |
| `↳↳ is_activated` | boolean | whether collection is activated. |
| `↳↳ item_list` | object[] | The items of top picks |
| `↳↳↳ item_name` | string | The name of item. |
| `↳↳↳ item_id` | int32 | The id of item. |
| `↳↳↳ current_price` | float | The price before tax of item. |
| `↳↳↳ inflated_price_of_current_price` | float | The price after tax of item. |
| `↳↳↳ sales` | int32 | The sales of item. |
| `↳↳ top_picks_id` | int32 | Collection id. |
| `↳↳ name` | string | The title of top picks. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The enabled top-picks can not be deleted. · The Top-picks name is exist, please change to other name. · The information you queried is not found. · Wrong parameters, detail: {msg}. · You don't have permission for the operation · Something wrong. Please try later. · Something wrong. Please try later. · shopid is invalid · Shopid is invalid · request not from gateway

## v2.top_picks.update_top_picks
`POST /api/v2/top_picks/update_top_picks` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

update a collection info

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter; 2021-06-17: correct the url path

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `top_picks_id` | int32 | ✔ | collection id |
| `name` | string |  | collection name |
| `item_id_list` | int32[] |  | a list of item id, and we will cover old item_ids by new_item_ids |
| `is_activated` | boolean |  | if true, we will close other collection and open this collection |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ collection_list` | object[] | The top picks list in this shop. |
| `↳↳ is_activated` | boolean | whether is activated |
| `↳↳ item_list` | object[] | a list of item |
| `↳↳↳ item_name` | string | The name of item. |
| `↳↳↳ item_id` | int32 | The id of item. |
| `↳↳↳ current_price` | float | The price before tax of item. |
| `↳↳↳ inflated_price_of_current_price` | float | The price after tax of item. |
| `↳↳↳ sales` | int32 | The sales of item. |
| `↳↳ top_picks_id` | int32 | collection id |
| `↳↳ name` | string | collection name |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The top-picks has duplicative item. · Item {itemid} is wrong, please check it. · Item {itemid} is not belong to shop, please check it. · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · You don't have permission for the operation · Something wrong. Please try later. · Something wrong. Please try later. · shopid is invalid · Shopid is invalid

## v2.top_picks.delete_top_picks
`POST /api/v2/top_picks/delete_top_picks` · loại: Shop · app được gọi: ERP System, Seller In House System, Marketing, Swam ERP

delete a collection

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `top_picks_id` | int32 | ✔ | collection id |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ top_picks_id` | int32 | collection id |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The top-picks has duplicative item. · Item {itemid} is wrong, please check it. · Item {itemid} is not belong to shop, please check it. · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · You don't have permission for the operation · Something wrong. Please try later. · Something wrong. Please try later. · shopid is invalid · Shopid is invalid

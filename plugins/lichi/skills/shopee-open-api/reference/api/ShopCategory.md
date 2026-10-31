# Module ShopCategory (7 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.shop_category.add_shop_category
`POST /api/v2/shop_category/add_shop_category` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this call to add a new shop collecion

Lịch sử cập nhật: 2022-07-27: Add Error Example information; 2022-07-01: update; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `name` | string | ✔ | ShopCategory's name. |
| `sort_weight` | int |  | ShopCategory's sort weight. The maximum number should be 2147483546. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ shop_category_id` | int | ShopCategory's unique identifier. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Unknown error, please contact developer. · The shop category id is not found. · The maximum number of the toggle-on automatic category cannot exceed 200. · ShopCategory name length cannot exceed 40 characters. · Sort_weight should be between [0, 2147483546]. · ShopCategory name is duplicated.

## v2.shop_category.get_shop_category_list
`GET /api/v2/shop_category/get_shop_category_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Customized APP, Custom APP, Swam ERP

Use this call to get list of shop categories

Lịch sử cập nhật: 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter; 2022-03-15: update status type and description; 2022-01-19: update the response parameters and response example

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_size` | int | ✔ | Specifies the starting entry of data to return in the current call. The parameter range of page_size should be [1, 2147483647] |
| `page_no` | int | ✔ | Specifies the total returned data per entry. The parameter range of page_no should be [1, 100] |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ shop_categorys` | object[] | ShopCategory's unique identifier. |
| `↳↳ shop_category_id` | int | ShopCategory's unique identifier. |
| `↳↳ status` | int | ShopCategory's status. Applicable values--1: 'NORMAL', 2: 'INACTIVE', 0: 'DELETED' |
| `↳↳ name` | string | ShopCategory's name. |
| `↳↳ sort_weight` | int | ShopCategory's sort weight. |
| `↳ total_count` | int | This is to indicate the whole number of in-shop categories under the shop. |
| `↳ more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Unknown error, please contact developer. · The shop category id is not found. · You have no valid partnerid. · Syntax error. Please check the format of your Request Parameter. · Wrong parameters, detail: {msg} · This shop category doesn't exist.

## v2.shop_category.delete_shop_category
`POST /api/v2/shop_category/delete_shop_category` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this call to delete a existing shop collecion

Lịch sử cập nhật: 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shop_category_id` | int | ✔ | ShopCategory's unique identifier. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ shop_category_id` | int | ShopCategory's unique identifier. |
| `↳ msg` | string | The return message of the operation result |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Automatic & shopee category cannot be deleted. · Unknown error, please contact developer. · The shop category id is not found. · You have no valid partnerid. · Syntax error. Please check the format of your Request Parameter. · Wrong parameters, detail: {msg}

## v2.shop_category.update_shop_category
`POST /api/v2/shop_category/update_shop_category` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this call to update a existing collecion

Lịch sử cập nhật: 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shop_category_id` | int | ✔ | ShopCategory's unique identifier. |
| `name` | string |  | ShopCategory's name. |
| `sort_weight` | int |  | ShopCategory's sort weight. |
| `status` | string |  | ShopCategory's status. Applicable values: NORMAL, INACTIVE, DELETED. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ shop_category_id` | int | This is to indicate whether the shop categories list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of shop categories |
| `↳ name` | string | ShopCategory's name. |
| `↳ sort_weight` | int | ShopCategory's sort weight. |
| `↳ status` | string | ShopCategory's status. Applicable values: NORMAL, INACTIVE, DELETED. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · The maximum number of the toggle-on customized category cannot exceed 100. · Shopee 24 category cannot edit the name and sort_weight. · Unknown error, please contact developer. · The shop category id is not found. · ShopCategory name length cannot exceed 40 characters. · Sort_weight should be between [0, 2147483546].

## v2.shop_category.add_item_list
`POST /api/v2/shop_category/add_item_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this call to add items list to certain shop_category

Lịch sử cập nhật: 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter; 2022-02-17: update item_list request parameter

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shop_category_id` | int | ✔ | ShopCategory's unique identifier. |
| `item_list` | int[] | ✔ | Shopee's unique identifiers list for an item. Max. 100 items to be deleted per request. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ invalid_item_id_list` | object[] | List of invalid item ids. |
| `↳↳ item_id` | int | The invalid item id. |
| `↳↳ fail_error` | string | The reason of the fail. |
| `↳↳ fail_message` | string | The detailed reason of the failure and the hints of error fixing |
| `↳ shop_category_id` | int | ShopCategory's unique identifier. |
| `↳ current_count` | int | Count of items under this shop category after deletion. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · The total item number has exceed its limit number : 5000. · Automatic & shopee category cannot add items. · Unknown error, please contact developer. · The shop category id is not found. · There's no 'item_list' parameter in the query, please check. · You have no valid partnerid.

## v2.shop_category.get_item_list
`GET /api/v2/shop_category/get_item_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Customized APP, Custom APP, Swam ERP

Use this call to get items list of certain shop_category

Lịch sử cập nhật: 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter; 2022-01-19: add the more filed in response parameter; 2022-01-06: update the total_count layer

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shop_category_id` | int | ✔ | ShopCategory's unique identifier. |
| `page_size` | int |  | Specifies the starting entry of data to return in the current call. Default is 1000. The input range of page_size is [0, 1000] |
| `page_no` | int |  | If many items are available to retrieve, you may need to call this api multiple times to retrieve all the data. And the default will be 0. page_size*page_no should be [0, 2147483446]. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_list` | int[] | A list of Shopee's unique identifiers for items. |
| `↳ total_count` | int | This is to indicate the whole number of items under the shop category. |
| `↳ more` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of items. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Unknown error, please contact developer. · The shop category id is not found. · Page number(page_no) should be [1, 2147483446/ page_size]. · You have no valid partnerid. · Syntax error. Please check the format of your Request Parameter. · Wrong parameters, detail: {msg}

## v2.shop_category.delete_item_list
`POST /api/v2/shop_category/delete_item_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this api to delete items from shop category

Lịch sử cập nhật: 2022-07-27: Add Error Example information; 2022-07-01: Optimize the Sample information of Request Parameter and Response Parameter; 2022-02-17: update request parameter; 2022-01-19: update the response example and response parameters

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shop_category_id` | int | ✔ | The list of items need to be deleted. To note that the items which can be deleted successfully should be under this category. |
| `item_list` | int[] | ✔ | ShopCategory's unique identifier. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ shop_category_id` | int | ShopCategory's unique identifier. |
| `↳ invalid_item_id` | int[] | The list of item ids which are invalid; In other words, the item ids not being under the category. |
| `↳ current_count` | int | count of items under this shop category after deleting |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Automatic & shopee category cannot delete items · Unknown error, please contact developer. · The shop category id is not found. · At most 100 items can be deleted per operation. · Page size should be [0, 1000]. · You have no valid partnerid.

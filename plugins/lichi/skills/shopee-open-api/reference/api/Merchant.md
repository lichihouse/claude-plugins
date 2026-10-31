# Module Merchant (6 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.merchant.get_merchant_info
`GET /api/v2/merchant/get_merchant_info` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Ads Service, Swam ERP

Use this call to get information of merchant

Lịch sử cập nhật: 2024-10-23: sunset the is_cnsc; 2023-10-26: update the description of "merchant_region" and "merchant_currency"; 2021-11-18: add merchant_currency response parameters

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `merchant_name` | string | Name of the merchant. |
| `auth_time` | timestamp | The timestamp when the merchant was authorized to the partner. |
| `expire_time` | timestamp | Use this field to indicate the expiration date for merchant authorization. |
| `merchant_currency` | string | The three-digit code representing the currency unit used for the item in this merchant. If currency haven't been setting in CNSC/KRSC, it will be empty. China merchant support CNY and USD currently. Korea merchant support KRW and USD currently. Hong kong merchant support USD currently, will support HKD later. |
| `merchant_region` | string | Region of the merchant. Including KR, HK and CN. |
| `is_upgraded_cbsc` | boolean | Use this filed to indicate whether this merchant is upgraded to cbsc. |

Lỗi riêng: The merchant has not set the currency. Please log in to CBSC to make the settings. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · The merchant id you provided is not found. Please check your merchant id. · request not from gateway

## v2.merchant.get_shop_list_by_merchant
`GET /api/v2/merchant/get_shop_list_by_merchant` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Ads Service, Swam ERP

Use this call to get shop_list bound to merchant_id.

Lịch sử cập nhật: 2024-10-23: sunset the is_cnsc, shop_is_cnsc; 2021-08-04: add more parameters; 2021-04-25: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 | ✔ | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data.No more than 500. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `shop_list` | object[] | list of shop authorized to the partner and bound to the merchant. |
| `↳ shop_id` | int64 | Shopee's unique identifier for a shop. |
| `↳ sip_affi_shops` | object[] | List of SIP affiliate shops.Only primary shop will return this parameter |
| `↳↳ affi_shop_id` | int64 | Affiliate shop's id. |
| `more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of datas. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · The merchant id you provided is not found. Please check your merchant id. · request not from gateway

## v2.merchant.get_merchant_warehouse_location_list
`GET /api/v2/merchant/get_merchant_warehouse_location_list` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

get merchant warehouse location list

Lịch sử cập nhật: 2023-11-02: Add warehouse_name response parameter; 2023-05-12: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] |  |
| `↳ location_id` | string | Location identifier for stocks. Different location_ids represent that your addresses are in different item stocks |
| `↳ warehouse_name` | string | The warehouse name filled in when creating the warehouse address |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway

## v2.merchant.get_merchant_warehouse_list
`POST /api/v2/merchant/get_merchant_warehouse_list` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get merchant warehouse with page

Lịch sử cập nhật: 2023-12-14: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `cursor` | object | ✔ | // how to use DoubleSidedCursor // Get data for the first page: Please pass next_id = 0 or nil, page_size = {your page size}. // Get data for the next page: Please pass the Cursor from the previous response, and set prev_id=nil; // Get data for the prev page: Please pass the Cursor from the previous response, and set next_id=nil; // Stop fetching next data: The Cursor.next_id in the previous response is nil. // Stop fetching prev data: The Cursor.prev_id in the previous response is nil. |
| `↳ next_id` | int |  |  |
| `↳ prev_id` | int |  |  |
| `↳ page_size` | int | ✔ | The size of one page. Limit is [1,30]. |
| `warehouse_type` | int | ✔ | 1 means pickup warehouse 2 means return warehouse |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ total_count` | int | Total count of all warehouses. |
| `↳ warehouse_list` | object[] |  |
| `↳↳ warehouse_id` | int | Warehouse address identifier. |
| `↳↳ warehouse_name` | string | The warehouse name filled in when creating the warehouse. |
| `↳↳ warehouse_type` | int | 1 means pickup warehouse 2 means return warehouse |
| `↳↳ warehouse_region` | string | Region of your warehouse. |
| `↳↳ location_id` | string | Location identifier for stocks. Different location_ids represent that your addresses are in different item stocks. |
| `↳↳ address` | object |  |
| `↳↳↳ address_name` | string | The address name filled in when creating the warehouse. |
| `↳↳↳ region` | string | Region of your warehouse address. |
| `↳↳↳ address` | string | Detail address of your warehouse address. |
| `↳↳↳ city` | string | City of your warehouse address. |
| `↳↳↳ district` | string | Distinct of your warehouse address. |
| `↳↳↳ state` | string | State of your warehouse address. |
| `↳↳↳ town` | string | Town of your warehouse address. |
| `↳↳↳ zip_code` | string | Zipcode of your warehouse address. |
| `↳↳ enterprise_info` | object |  |
| `↳↳↳ company_name` | string |  |
| `↳↳↳ cnpj` | string |  |
| `↳↳↳ state_registration_number` | string |  |
| `↳↳↳ is_freight_payer` | boolean |  |
| `↳ cursor` | object |  |
| `↳↳ next_id` | int |  |
| `↳↳ prev_id` | int |  |
| `↳↳ page_size` | int |  |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway

## v2.merchant.get_warehouse_eligible_shop_list
`POST /api/v2/merchant/get_warehouse_eligible_shop_list` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get eligible shop list by warehouse id

Lịch sử cập nhật: 2023-12-14: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `warehouse_id` | int | ✔ | Warehouse address identifier. |
| `warehouse_type` | int | ✔ | 1 means pickup warehouse 2 means return warehouse |
| `cursor` | object | ✔ | // how to use DoubleSidedCursor // Get data for the first page: Please pass next_id = 0 or nil, page_size = {your page size}. // Get data for the next page: Please pass the Cursor from the previous response, and set prev_id=nil; // Get data for the prev page: Please pass the Cursor from the previous response, and set next_id=nil; // Stop fetching next data: The Cursor.next_id in the previous response is nil. // Stop fetching prev data: The Cursor.prev_id in the previous response is nil. |
| `↳ next_id` | int |  |  |
| `↳ prev_id` | int |  |  |
| `↳ page_size` | int | ✔ | The size of one page. Limit is [1,30]. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ shop_list` | object[] | Eligible shop list of the warehouse |
| `↳↳ shop_id` | int | Shopee's unique identifier for a shop. |
| `↳↳ shop_name` | string | Name of the shop. |
| `↳ cursor` | object |  |
| `↳↳ next_id` | int |  |
| `↳↳ prev_id` | int |  |
| `↳↳ page_size` | int |  |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway

## v2.merchant.get_merchant_prepaid_account_list
`GET /api/v2/merchant/get_merchant_prepaid_account_list` · loại: Merchant · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get seller’s courier prepaid account.

Lịch sử cập nhật: 2024-10-29: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 | ✔ | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. Min: 1 Max:10 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ total` | int32 |  |
| `↳ list` | object[] |  |
| `↳↳ prepaid_account_id` | int64 | Record ID |
| `↳↳ prepaid_account_courier_key` | string | Courier Company Key (快递公司编码). |
| `↳↳ prepaid_account_courier_name` | string | Courier Company Name (快递公司名称). |
| `↳↳ prepaid_account_partner_id` | string | Prepaid Account Number (电子面单账户号码). |
| `↳↳ prepaid_account_partner_key` | string | Prepaid Account Password (电子面单账户密码). |
| `↳↳ prepaid_account_partner_secret` | string | Partner Secret (电子面单密钥). |
| `↳↳ prepaid_account_partner_name` | string | Partner Name (电子面单客户账户名称). |
| `↳↳ prepaid_account_partner_net` | string | Branch Name (网点名称). |
| `↳↳ prepaid_account_partner_code` | string | Partner Code (电子面单承载编号). |
| `↳↳ prepaid_account_check_man` | string | Delivery Agent Name (电子面单承载快递员名). |
| `↳↳ prepaid_account_is_default` | boolean | This is to indicate whether the prepaid account is Default Prepaid Account. |
| `↳ more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of datas. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway

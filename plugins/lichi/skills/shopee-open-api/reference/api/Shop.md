# Module Shop (9 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.shop.get_shop_info
`GET /api/v2/shop/get_shop_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Customer Service, Customized APP, Ads Service, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management

Use this call to get information of shop

Lịch sử cập nhật: 2026-05-19: support mart_outlet_structure_type in response; 2025-08-25: support mart/outlet shop type in response; 2025-05-15: add new field "is_one_awb"; 2025-03-27: Add new fields to enable determination if a shop is operating under the Cross Border Direct Selling model; 2024-10-25: add "LFF Hybrid Shop" option for "shop_fulfillment_flag" response parameter

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `shop_name` | string | Name of the shop. |
| `region` | string | Shop's area. |
| `status` | string | Applicable status: BANNED , FROZEN , NORMAL . |
| `sip_affi_shops` | object[] | SIP affiliate shops info list.If you request for SIP primary shop,this field will be returned, if you request for SIP affiliate shop,this field won't be returned |
| `↳ affi_shop_id` | int64 | Affiliate shop's id. |
| `↳ region` | string | Affiliate Shop's area. |
| `is_cb` | boolean | Use this filed to indicate whether the shop is a cross-border shop. |
| `auth_time` | timestamp | The timestamp when the shop was authorized to the partner. |
| `expire_time` | timestamp | Use this field to indicate the expiration date for shop authorization. |
| `is_sip` | boolean | This filed will return "true" when SIP primary shop or affiliate shop calls |
| `is_upgraded_cbsc` | boolean | Use this filed to indicate whether this merchant is upgraded to CBSC, including CNSC and KRSC. |
| `merchant_id` | int64 | Shopee’s unique identifier for a merchant. If the shop won't under any merchant, then the value will be null. |
| `shop_fulfillment_flag` | string | Use this field to indicate the fulfillment type of current shop, the applicable values: - Pure - FBS Shop: Single mode, refer to Local/CB shops which only have Shopee official warehouse stock, orders are fulfilled by Shopee from Shopee official warehouse; - Pure - 3PF Shop: Single mode, refer to CB shops which only have local seller warehouse stock, orders are fulfilled by seller from local seller warehouse via local logistics channels; - PFF - FBS Shop: 1) Hybird mode, refer to Local shops which have both Shopee official warehouse stock and local seller warehouse stock, orders can be fulfilled by Shopee from Shopee official warehouse and can also fulfilled by seller from local seller wareho |
| `is_main_shop` | boolean | Identifies if the current shop is a Local Shop linked to Cross Border Direct Shop. |
| `is_direct_shop` | boolean | Identifies if the current shop is a Cross Border Direct Shop. |
| `linked_main_shop_id` | int64 | Returns the Shop ID of the Local Shop linked to the Cross Border Direct Shop. |
| `linked_direct_shop_list` | object[] | Returns the list of Cross Border Direct Shops linked to the Local Shop. |
| `↳ direct_shop_id` | int64 | Shop ID of the Cross Border Direct Shop. |
| `↳ direct_shop_region` | string | Shop Region of the Cross Border Direct Shop. |
| `is_one_awb` | boolean | Use this filed to indicate if the shop is in 1-AWB whitelist. If is_one_awb return true, please use new AWB size (10cm x 15cm thermal paper) to print AWB. For more details, please refer to: https://open.shopee.com/announcements/1138?category=3&is_top=false |
| `is_mart_shop` | boolean | Indicates whether the current shop is a Mart Shop. |
| `is_outlet_shop` | boolean | Indicates whether the current shop is an Outlet Shop. |
| `mart_shop_id` | int64 | (Only returned when requesting an Outlet Shop) Refers to the Mart Shop ID this Outlet belongs to. |
| `outlet_shop_info_list` | object[] | (Only returned when requesting a Mart Shop) List of Outlet Shop IDs under this Mart Shop. |
| `↳ outlet_shop_id` | int64 | Shop ID of the Outlet Shop. |
| `mart_outlet_structure_type` | string | (Only returned when requesting a Mart or Outlet Shop) Indicates the structure type of the Mart or Outlet shop. Applicable values are: normal_mart_shop, warehouse_mart_shop, normal_outlet_shop, warehouse_outlet_shop |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · The user does not exist. · request not from gateway · The shop id you provided is not found. Please check your shop id.

## v2.shop.get_profile
`GET /api/v2/shop/get_profile` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Customized APP, Ads Service, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management

This API support to get information of shop.

Lịch sử cập nhật: 2023-03-13: add new field "invoice_issuer" for BR local seller

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | The information about shop logo, shop name, shop description. |
| `↳ shop_logo` | string | The Image URL of the shop logo. |
| `↳ description` | string | The content of the shop description. |
| `↳ shop_name` | string | The content of the shop name. |
| `↳ invoice_issuer` | string | The invoice issuer information for the shop. It could be "Shopee" or "Other" as the invoice issuer. This is for BR CNPJ seller only. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · You don't have permission for the operation · Something wrong. Please try later. · Something wrong. Please try later. · shopid is invalid · Shopid is invalid · request not from gateway

## v2.shop.update_profile
`POST /api/v2/shop/update_profile` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Ads Service, Swam ERP

This API support to let sellers to update the shop name, shop logo, and shop description.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shop_name` | string |  | The new shop name |
| `shop_logo` | string |  | The new shop logo url. Recommend to use images |
| `description` | string |  | The new shop description. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | string | If update successfully, the information is about shop logo, shop name, shop description. |
| `↳ shop_logo` | string | The Image URL of the shop logo after updated. |
| `↳ description` | string | The content of the shop description after updated. |
| `↳ shop_name` | string | The content of the shop name after updated. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · You don't have permission for the operation · Something wrong. Please try later. · Something wrong. Please try later. · shopid is invalid · Shopid is invalid · request not from gateway · Failed to change Shop Name for shop name have been changed in recent 30 days. Please change the shop name at least 30 days later than your last modify.

## v2.shop.get_warehouse_detail
`GET /api/v2/shop/get_warehouse_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Swam ERP

For given shop id and region, return warehouse info including warehouse id, address id and location id, return all warehouse with once call.

Lịch sử cập nhật: 2025-01-13: add warehouse_type request & response parameter; 2024-01-09: add address_id response parameter; 2023-05-26: update the parameter name from country to region; 2022-06-10: remove region request parametre; 2022-05-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `warehouse_type` | int32 |  | Type of warehouse. Applicable values: - 1: Pickup Warehouse - 2: Return Warehouse Default value is 1 (Pickup Warehouse) |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] |  |
| `↳ warehouse_id` | int64 | Warehouse address identifier. It should be unique for every warehouse address |
| `↳ warehouse_name` | string | The warehouse name filled in when creating the warehouse address |
| `↳ warehouse_type` | int32 | Type of warehouse. Applicable values: - 1: Pickup Warehouse - 2: Return Warehouse |
| `↳ location_id` | string | Location identifier for stocks. Different location_ids represent that your addresses are in different item stocks |
| `↳ address_id` | int64 | Identity of address |
| `↳ region` | string | Region of your warehouse address |
| `↳ state` | string | State of your warehouse address |
| `↳ city` | string | City of your warehouse address |
| `↳ address` | string | Detail address of your warehouse address |
| `↳ zipcode` | string | Zipcode of your warehouse address |
| `↳ district` | string | Distinct of your warehouse address |
| `↳ town` | string | Town of your warehouse address |
| `↳ state_code` | string | State code of your warehouse address |
| `↳ holiday_mode_state` | int32 | The holiday mode state of your address. 0: not in holiday mode 1: holiday mode active 2: holiday mode is turning of 3: holiday mode is turning on |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · This error will show if there is no legal warehouse address for given shop id · This error will show if your shop has no permission to access multi-warehouse · This error will show if region is missing. · This error will show if region is not in ID, PH, VN, SG, TW, MX · This error will show if shop id is missing.

## v2.shop.get_shop_notification
`GET /api/v2/shop/get_shop_notification` · loại: Shop · app được gọi: Original, ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Marketing, Customer Service, Brand Membership, Customized APP, Ads Service, Consignment Service System, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management

get Seller Center notification, the permission is controlled by App type

Lịch sử cập nhật: 2024-03-28: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `cursor` | int |  | The last notification_id returned on the page. When using the cursor, notifications will start with the one following this cursor notification. If no cursor is provided, the latest message from the shop will be returned. |
| `page_size` | int |  | Default 10; maximum 50 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `cursor` | int | Last notification_id returned in the page |
| `data` | object |  |
| `↳ create_time` | int | the notification create time |
| `↳ content` | string | The content of the notification |
| `↳ title` | string | The content of the notification |
| `↳ url` | string | Some notification may be attached with URL, it will redirect to seller center |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.shop.get_authorised_reseller_brand
`GET /api/v2/shop/get_authorised_reseller_brand` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Swam ERP

Get the authorised reseller brand list for the shop.

Lịch sử cập nhật: 2024-09-26: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 | ✔ | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 30. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ is_authorised_reseller` | boolean | This is to indicate whether the shop is authorised reseller. |
| `↳ total_count` | int64 | The number of authorised brand linked with the shop. |
| `↳ more` | boolean | This is to indicate whether the authorised brand list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of authorised brand. |
| `↳ authorised_brand_list` | object[] |  |
| `↳↳ brand_id` | int64 | ID of the authorised brand, it may be the same in different regions. |
| `↳↳ brand_name` | string | Name of the authorised brand. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.shop.get_br_shop_onboarding_info
`GET /api/v2/shop/get_br_shop_onboarding_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management

[For BR Shop Only] Use this API to get shop KYC registration and qualification information.

Lịch sử cập nhật: 2025-12-04: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Onboarding information of the Shop. |
| `↳ tax_id_type` | int32 | Type of the shop’s tax ID. Applicable values: 1: Personal seller (CPF) 2: Company seller (CNPJ) |
| `↳ tax_id` | string | The shop’s tax ID. - When tax_id_type = 1 (Personal seller), it is CPF. - When tax_id_type = 2 (Company seller), it is CNPJ. |
| `↳ cpf_id` | string | CPF number of the individual seller. Valid only when tax_id_type = 1. |
| `↳ cnpj_id` | string | CNPJ number of the company seller. Valid only when tax_id_type = 2. |
| `↳ name` | string | Full name of the individual seller. Valid only when tax_id_type = 1. |
| `↳ legal_entity_name` | string | Legal name of the company seller. Valid only when tax_id_type = 2. |
| `↳ birthday` | int64 | Birthday of the individual seller (stored as Unix timestamp). Valid only when tax_id_type = 1. |
| `↳ birthday_str` | string | Birthday of the individual seller (formatted as YYYY-MM-DD). Valid only when tax_id_type = 1. |
| `↳ state_registration` | string | State registration number of the shop. |
| `↳ billing_address` | object | Shop’s billing address details. |
| `↳↳ state` | string | State of the billing address. |
| `↳↳ city` | string | City of the billing address. |
| `↳↳ address` | string | Specific detail of the billing address. |
| `↳↳ zipcode` | string | ZIP code of the billing address. |
| `↳↳ neighborhood` | string | Neighborhood of the billing address. |
| `↳ onboarding_status` | int32 | Status of the shop’s current KYC onboarding process. Applicable values: 0: None 1: Regis Processing 2: Regis Validated 3: Regis Rejected 4: KYC Pending 5: KYC Processing 6: KYC Processing Manually 7: KYC Validated 8: KYC Rejected |
| `↳ submission_time` | int32 | Timestamp when the onboarding information was submitted. |
| `↳ nationality` | string | Nationality of the individual seller. Valid only when tax_id_type=1. |
| `↳ cnae_main` | string | Main CNAE code. |
| `↳ cnae_secondary` | string | Secondary CNAE code. |
| `↳ mei_check` | string | MEI verification result. Applicable values: 0: No 1: Yes |
| `↳ onboarding_passed` | boolean | Indicate if the shop has passed KYC verification. |

Lỗi riêng: err_service_internal · error_shop_not_exists

## v2.shop.get_shop_holiday_mode
`GET /api/v2/shop/get_shop_holiday_mode` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management

Use this API to check whether a shop has enabled holiday mode and its ongoing and upcoming holiday mode period.

Lịch sử cập nhật: 2026-03-13: Add Response Parameters holiday_mode_type、holiday_mode_start_time、holiday_mode_end_time、holiday_mode_description; 2025-11-24: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ holiday_mode_on` | boolean | Indicate whether the shop has enabled holiday mode. true means ON, false means OFF. |
| `↳ holiday_mode_mtime` | timestamp | The last time the holiday mode was modifies. |
| `↳ holiday_mode_type` | int32 | Indicate whether the holiday mode is partial holiday or full holiday. 1: Partial Holiday: seller can still receive orders during partial holiday 0: Full Holiday: seller can not receive orders during full holiday only when holiday_mode_on = true will the holiday_mode_type work |
| `↳ holiday_mode_start_time` | timestamp | Holiday start time timestamp. |
| `↳ holiday_mode_end_time` | timestamp | Holiday end time timestamp. |
| `↳ holiday_mode_description` | string | Description of the holiday |
| `↳ debug_msg` | string | Debug message. |

Lỗi riêng: err_service_internal · error_shop_not_exists

## v2.shop.set_shop_holiday_mode
`POST /api/v2/shop/set_shop_holiday_mode` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management

Use this API to set holiday periods in advance for automatic on/off of holiday mode and there are two holiday modes allowing sellers to choose whether to accept new orders during holiday.

Lịch sử cập nhật: 2026-03-13: Add request parameters holiday_mode_type、holiday_mode_start_time、holiday_mode_end_time、holiday_mode_description; 2025-11-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `holiday_mode_on` | boolean | ✔ | Indicate whether to enable holiday mode for the shop. true means turn ON, false means turn OFF. |
| `holiday_mode_type` | int32 |  | Holiday type: 0 - Full holiday，buyers cannot place new orders. The behavior remains consistent with the current Holiday Mode. 1 - Partial holiday, buyers can continue placing orders, and the system will automatically extend the order’s Ship-By-Date (SBD). |
| `holiday_mode_start_time` | timestamp |  | Holiday start time should be whole hour and could be parsed as "2026:01:16 15:00:00" |
| `holiday_mode_end_time` | timestamp |  | Holiday end time plus one second should be whole hour, which means the input timestamp must be able to be parsed as "2025:01:20 17:59:59" and the holiday_end_time must be larger than holiday_start_time |
| `holiday_mode_description` | string |  | Description of the holiday |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ debug_msg` | string | Debug message. |

Lỗi riêng: err_service_internal · error_shop_not_exists

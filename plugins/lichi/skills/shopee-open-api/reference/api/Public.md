# Module Public (6 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.public.get_shops_by_partner
`GET /api/v2/public/get_shops_by_partner` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Marketing, Customer Service, Brand Membership, Ads Service, Consignment Service System, Custom APP, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management, Brand Portal Service, Payment Service Provider

get basic info of shops which have authorized to the partner.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_size` | int |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. |
| `page_no` | int |  | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `authed_shop_list` | object[] | A list of shops authorized to the partner. |
| `↳ region` | string | Shop's area |
| `↳ shop_id` | int | Shop id |
| `↳ auth_time` | timestamp | The timestamp when the shop was authorized to the partner. |
| `↳ expire_time` | timestamp | Use this field to indicate the expiration date for shop authorization. |
| `↳ sip_affi_shop_list` | object[] | SIP affiliate shops info list |
| `↳↳ region` | string | Affiliate Shop's area |
| `↳↳ affi_shop_id` | int | Affiliate shop's id |
| `more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of datas. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · error server

## v2.public.get_merchants_by_partner
`GET /api/v2/public/get_merchants_by_partner` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Marketing, Customer Service, Brand Membership, Ads Service, Consignment Service System, Custom APP, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management, Brand Portal Service, Payment Service Provider

Use this API to get basic info of merchants which have authorized to the partner.

Lịch sử cập nhật: 2022-03-30: update Response Parameters

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_size` | int |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. |
| `page_no` | int |  | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `authed_merchant_list` | object[] | A list of merchants authorized to the partner. |
| `↳ region` | string | Merchant's area |
| `↳ merchant_id` | int | Shopee's unique identifier for a merchant. |
| `↳ auth_time` | timestamp | The timestamp when the merchant was authorized to the partner. |
| `↳ expire_time` | timestamp | Use this field to indicate the expiration date for merchant authorization. |
| `more` | boolean | This is to indicate whether the list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of datas. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · error server

## v2.public.get_access_token
`POST /api/v2/auth/token/get` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Marketing, Customer Service, Brand Membership, Customized APP, Ads Service, Consignment Service System, Custom APP, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management, Brand Portal Service, Payment Service Provider

Use the code from the authorization step to call this API to obtain the authorized shop_id, merchant_id, supplier_id, or user_id, and its corresponding access_token and refresh_token.

Lịch sử cập nhật: 2026-07-13: Add principal_id_list as response parameter.; 2024-11-08: Add supplier_id; 2022-09-20: add; 2021-09-02: update

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `code` | string | ✔ | The code in redirect url after the authorization. Valid for one-time use, expires in 10 minutes |
| `partner_id` | int64 | ✔ | Partner ID is assigned upon registration is successful. Required for all requests. |
| `shop_id` | int64 |  | Shopee's unique identifier for a shop. |
| `main_account_id` | int64 |  | The main_account_id of the seller that authorized the developer. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `shop_id_list` | int64[] | Returned all shop_ids authorized this time. |
| `merchant_id_list` | int64[] | Returned all merchant_ids authorized this time. |
| `supplier_id_list` | int64[] | Returned all supplier_ids authorized this time. |
| `user_id_list` | int64[] | Returned all user_ids authorized this time. |
| `principal_id_list` | int64[] | If the authorized role is principal administrator, return all principal_id under this authorization. |
| `access_token` | string | Returned when the API call is successful. A dynamic token that can be used multiple times and expires after 4 hours. |
| `refresh_token` | string | Returned when the API call is successful. Use refresh_token to get a new access_token. Valid for each shop_id, merchant_id, supplier_id, or user_id respectively, for 30 days. |
| `expire_in` | timestamp | Returned when the API call is successful. The validity period of the access_token, in seconds. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The code is expired or used or invalid, please check the code. · The code or main_accoount_id is wrong, please check the code or the main_account_id. · The code or shop_id is wrong, please check the code or the shop_id. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · error server

## v2.public.refresh_access_token
`POST /api/v2/auth/access_token/get` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Marketing, Customer Service, Brand Membership, Customized APP, Ads Service, Consignment Service System, Custom APP, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management, Brand Portal Service, Payment Service Provider

Use this API to refresh the access_token after it expires. Refresh_token can be used once only, this API will also return a new refresh_token. Please use the new refresh_token for the next RefreshAccessToken call

Lịch sử cập nhật: 2026-07-13: Add principal_id as request and response parameters.; 2021-09-02: update

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `refresh_token` | string | ✔ | Use refresh_token to get a new access_token. Each refresh_token is valid for 30 days, and can only be used once by either a shop_id or merchant_id or supplier_id or user_id. |
| `partner_id` | int64 | ✔ | The partner_id obtained from the App. This partner_id is inserted into the body. |
| `shop_id` | int64 |  | The shop_id that granted authorization to your App. Only the shop_id or merchant_id or supplier_id or user_id can be selected as the input parameter, and they must be refreshed separately. |
| `merchant_id` | int64 |  | The merchant_id that granted authorization to your App. Only the shop_id or merchant_id or supplier_id or user_id can be selected as the input parameter, and they must be refreshed separately. |
| `supplier_id` | int64 |  | The supplier_id that granted authorization to your App. Only the shop_id or merchant_id or supplier_id or user_id can be selected as the input parameter, and they must be refreshed separately. |
| `user_id` | int64 |  | The user_id that granted authorization to your App. Only the shop_id or merchant_id or supplier_id or user_id can be selected as the input parameter, and they must be refreshed separately. |
| `principal_id` | int64 |  | Shopee's unique identifier for a principal. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `partner_id` | int64 | Returned when the API call is successful. The partner_id you used for this refresh. |
| `principal_id` | int64 | Returned when the API call is successful.The principal_id for this refresh. |
| `shop_id` | int64 | Returned when the API call is successful. The shop_id for this refresh. |
| `merchant_id` | int64 | Returned when the API call is successful. The merchant_id for this refresh. |
| `supplier_id` | int64 | Returned when the API call is successful. The supplier_id for this refresh. |
| `user_id` | int64 | Returned when the API call is successful. The user_id for this refresh. |
| `access_token` | string | Returned when the API call is successful. Each new access_token is a dynamic token that can be used multiple times. It expires after 4 hours. |
| `refresh_token` | string | New refresh_tokenReturned when the API call is successful. Use a refresh_token to get a new access_token. Each refresh_token is valid for 30 days, and can only be used once by either a shop_id or merchant_id or supplier_id or user_id. |
| `expire_in` | timestamp | Returned when the API call is successful. The validity period of the access_token, in seconds. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Your access to merchant has expired. · Partner and merchant has no linked. · Your refresh token is error,please check refresh token or merchant_id. · request not from gateway · The shop account has been banned. Permissions for shop authorization and API calls have been suspended until the shop account is restored. · Your refresh_token expired. · error server · Your access to shop has expired.

## v2.public.get_token_by_resend_code
`POST /api/v2/public/get_token_by_resend_code` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Marketing, Customer Service, Brand Membership, Customized APP, Ads Service, Consignment Service System, Custom APP, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management, Brand Portal Service, Payment Service Provider

Use the resend code to get access token and refresh token. When you lost your access token or refresh token, you can go to authorization management page to resend code by yourselves. You can only use this endpoint in live environment, we don't support in test-stable environment.

Lịch sử cập nhật: 2022-02-22: update define; 2022-01-13: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `resend_code` | string | ✔ | the code in redirect url after you resend code in shop authorization management page. valid for one-time use, expires in 10minutes. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `shop_id_list` | int[] | Return when resend code in shop module |
| `merchant_id_list` | int[] | Return when resend code in merchant module |
| `refresh_token` | string | Use refresh_token to obtain new access_token. Valid for each shop_id and merchant_id respectively one-time use, expires in 30 days. |
| `access_token` | string | The token for API access, using to identify your permission to the api. Valid for multiple use and expires in 4 hours. |
| `expire_in` | int | Access_token expiration time, unit is second. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · error server

## v2.public.get_shopee_ip_ranges
`GET /api/v2/public/get_shopee_ip_ranges` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Marketing, Customer Service, Brand Membership, Ads Service, Consignment Service System, Seller Logistics, Custom APP, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management, Auto Parts Installation (ISP), Brand Portal Service, Payment Service Provider

You can get shopee ip address ranges through this open api.

Lịch sử cập nhật: 2022-07-11: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `ip_list` | string[] | IP address ranges of Shopee |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · error server

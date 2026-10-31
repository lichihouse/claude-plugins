# Module FirstMile (18 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.first_mile.get_unbind_order_list
`GET /api/v2/first_mile/get_unbind_order_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get unbind order list. It will only return orders unbound to first-mile that were created within the past 6 months.

Lịch sử cập nhật: 2026-03-20: Only return orders unbound to first-mile that were created within the past 6 months.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int32 |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. limit [1, 100] |
| `response_optional_fields` | string |  | Indicate response fields you want to get. Please select from the below response parameters. If you input an object field, all the params under it will be included automatically in the response. If there are multiple response fields you want to get, you need to use English comma to connect them. Available values: logistics_status,package_number. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ more` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of items. |
| `↳ order_list` | object[] | The result list of order you querying. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ logistics_status` | string | The Shopee logistics status for the order. Applicable values: See Data Definition- LogisticsStatus. |
| `↳ next_cursor` | string | If more is true, you should pass the next_cursor in the next request as cursor. The value of next_cursor will be empty string when more is false. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · Invalid response field({field}). · The shop has no permission for the first mile shipment method: {method}. · The shop has no permission for first mile pre declare. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.get_detail
`GET /api/v2/first_mile/get_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get first mile detail.

Lịch sử cập nhật: 2022-12-13: Updated the description of Status to explain NOT_AVAILABLE's meaning

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `first_mile_tracking_number` | string | ✔ | The first mile tracking number. |
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the offset can be some entry to start next call. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ logistics_channel_id` | int | The identity of logistic channel. |
| `↳ first_mile_tracking_number` | string | The first-mile tracking number. |
| `↳ shipment_method` | string | The shipment method for bound orders, should be pickup or dropoff. |
| `↳ status` | string | The logistics status for first-mile tracking number. Status could be: NOT_AVAILABLE,ORDER_CREATED,PICKED_UP,DELIVERED,ORDER_RECEIVED,CANCELING,CANCELED. NOT_AVAILABLE status means that either of the two scenarios has happened: 1. First Mile Tracking Number in the request does not exist. (e.g., wrong format) 2. First Mile Tracking Number is not yet bound with any order. |
| `↳ declare_date` | string | The specified delivery date. |
| `↳ more` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of items. |
| `↳ order_list` | object[] | The list of order. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ sls_tracking_number` | string | The tracking number of SLS for orders/forders. |
| `↳↳ pick_up_done` | boolean | Use this filed to indicate whether the order has been picked up by carrier. |
| `↳↳ arrived_transit_warehouse` | boolean | Use this filed to indicate whether the order has arrived at transit warehouse. |
| `↳ next_cursor` | string | If more is true, you should pass the next_cursor in the next request as cursor. The value of next_cursor will be empty string when more is false. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · The shop has no permission for first mile support. · The shop has no permission for first mile pre declare. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.generate_first_mile_tracking_number
`POST /api/v2/first_mile/generate_first_mile_tracking_number` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to generate first mile tracking number.

Lịch sử cập nhật: 2023-05-16: Remove seller_info details due to CN PII

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `declare_date` | string | ✔ | This field is used for seller to specify the declare time. |
| `quantity` | int |  | The number of first-mile tracking numbers generated. Up to 20 first-mile tracking numbers can be generated for one declaration day. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ first_mile_tracking_number_list` | string[] | The list of first mile tracking number that you generate |

Lỗi riêng: Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · Area is invalid.Now we only support area in {area}. · Parameter declare_date is wrong, should be later than or equal to today. · Format for param date is wrong, should be like '2000-01-01'. · The first mile code number you apply is more than {num}. · The shop has no permission for the first mile shipment method: {method}. · The shop has no permission for first mile pre declare. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.first_mile.bind_first_mile_tracking_number
`POST /api/v2/first_mile/bind_first_mile_tracking_number` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to bind first mile tracking number.

Lịch sử cập nhật: 2026-03-20: Add warehouse_id and warehouse_type request parameter; 2024-08-27: update the description of the request field "region"; 2024-06-06: update first_mile_tracking_number field description If using self_deliver, you must also pass the first_mile_tracking_number value generated from v2.first_mile.generate_first_mile_tracking_number.; 2024-04-25: update the description of first_mile_tracking_number; 2023-03-28: update the description of logistic_channel_id

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `first_mile_tracking_number` | string | ✔ | If using "pickup" or "self_deliver" as the shipment method the "first_mile_tracking_number" field should pass the value generated from v2.first_mile.generate_first_mile_tracking_number. If using "dropoff" as the shipment method the "first_mile_tracking_number" field should pass the tracking number provide by the supplier. |
| `shipment_method` | string | ✔ | The shipment method for bound orders, should be pickup, dropoff or self_deliver. |
| `region` | string | ✔ | Use this field to specify the region you want to ship parcel. Available value: cn,kr. Please fill in the field according to the region of the Merchant to which the shop belongs. |
| `logistics_channel_id` | int32 | ✔ | The identity of first-mile logistic channel. If you using "dropoff" or "pickup" as shipment method, please call v2.first_mile.get_channel_list to get the logsitc_channel_id then fill it. If you using "self_deliver"as shipment method then the logistics_channel_id should be "null". |
| `volume` | float |  | The volume of the parcel. |
| `weight` | float |  | The weight of the parcel. |
| `width` | float |  | The width of the parcel. |
| `length` | float |  | The length of the parcel. |
| `height` | float |  | The height of the parcel. |
| `order_list` | object[] | ✔ | The set of ordersn. You can specify up to 50 ordersns in this call.one fm_tn maximum number of total bind orders is 10000. |
| `↳ order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `↳ package_number` | string |  | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there is't a package number. |
| `warehouse_id` | string |  | The identity of transit warehouse address. Retrieved from v2.first_mile.get_transit_warehouse_list. Note: When the first-mile delivery mode is "Drop Off", this field is expected to be a required field . However, to avoid affecting your existing services, this field will be temporarily optional until April 30, 2026 . Please complete the integration before then to avoid any impact on your services if it is changed to a required field later. |
| `warehouse_type` | int32 |  | Warehouse type. Retrieved from v2.first_mile.get_transit_warehouse_list. 0 = normal warehouse 1 = vendor warehouse Note: When the first-mile delivery mode is "Drop Off", this field is expected to be a required field . However, to avoid affecting your existing services, this field will be temporarily optional until April 30, 2026 . Please complete the integration before then to avoid any impact on your services if it is changed to a required field later. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ first_mile_tracking_number` | string | The first mile tracking number |
| `↳ order_list` | object[] | The list of orders. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: Dropoff FM tracking code must be between 6 to 40 characters · FM code cannot be empty. · Format wrong. FM tracking number only contains character and number. · Pickup FM tracking code must start with "CNF" or "KRF" + 18 numbers · Self Deliver FM tracking code must start with \"CNF\" or \"KRF\" + 18 numbers · There is common business error · One FM code cannot be predeclared with different shipping methods · The SLS TN does not belong to FM enabled TWS. · The SLS TN is tied to another FM code · The FM code does not exist · System error (TWS fail), please contact Shopee · The logistics status is not supported for binding · The SLS TN does not exist · The SLS TN is not a CB TN · The FM status is incorrect.

## v2.first_mile.unbind_first_mile_tracking_number
`POST /api/v2/first_mile/unbind_first_mile_tracking_number` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to unbind first mile.

Lịch sử cập nhật: 2023-10-12: update the description of request parameter "order_list" : the unbind amount for one call is limit to 50 orders

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `first_mile_tracking_number` | string | ✔ | The identifier for an API request for error tracking. |
| `order_list` | object[] | ✔ | The list of order info you want to unbind from the given first mile tracking number. You can specify up to 50 orders in this call. |
| `↳ order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `↳ package_number` | string |  | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there is't a package number. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ first_mile_tracking_number` | string | The first mile tracking number. |
| `↳ order_list` | object[] | The binding result list of each order. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: There is common business error · One FM code cannot be predeclared with different shipping methods · The SLS TN does not belong to FM enabled TWS. · The SLS TN is tied to another FM code · The FM code does not exist · System error (TWS fail), please contact Shopee · The logistics status is not supported for binding · The SLS TN does not exist · The SLS TN is not a CB TN · The FM status is incorrect. · System error, please try again later/ contact Shopee · You used a Delivered FM code, please use a new FM code. · Your predeclared order creation time is later than pick up time, please use a new FM code. · The shipping method and logistics id are not matched · System error, please contact Shopee

## v2.first_mile.get_tracking_number_list
`GET /api/v2/first_mile/get_tracking_number_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get first mile tracking number list.

Lịch sử cập nhật: 2022-12-13: Updated the description of Status to explain NOT_AVAILABLE status

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `from_date` | string | ✔ | The start time of declare_date. |
| `to_date` | string | ✔ | The end time of declare_date. |
| `page_size` | int |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. limit [1, 50] |
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the offset can be some entry to start next call. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ more` | boolean | This is to indicate whether the order list is more than one page. If this value is true, you may want to continue to check next page to retrieve orders. |
| `↳ first_mile_tracking_number_list` | object[] | The first-mile tracking number. |
| `↳↳ first_mile_tracking_number` | string | The first-mile tracking number. |
| `↳↳ status` | string | The logistics status for bound orders. NOT_AVAILABLE status means that First Mile Tracking Number is not yet bound with any order. |
| `↳↳ declare_date` | string | The specified delivery date. |
| `↳ next_cursor` | string | If more is true, you should pass the next_cursor in the next request as cursor. The value of next_cursor will be empty string when more is false. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · Format for param date is wrong, should be like '2000-01-01'. · The "from_date" time must be smaller than the "to_date" time. · The shop has no permission for the first mile shipment method: {method}. · The shop has no permission for first mile pre declare. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.get_waybill
`POST /api/v2/first_mile/get_waybill` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get first mile waybill file.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `first_mile_tracking_number_list` | string[] | ✔ | The first mile tracking number that you want to print waybill.limit [1, 50] |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `waybill` | file | The waybill file. |

Lỗi riêng: Get waybill fail due to the network error. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · The ShopID and Pickup Label are not matched. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.get_channel_list
`GET /api/v2/first_mile/get_channel_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get first mile channel list.

Lịch sử cập nhật: 2023-05-10: update the request parameter "region" from required to non-required

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `region` | string |  | Use this field to specify the region you want to ship parcel. Available value: CN, KR |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ logistics_channel_list` | object[] |  |
| `↳↳ logistics_channel_id` | int | The identity of logistic channel. |
| `↳↳ logistics_channel_name` | string | The name of logistic channel. |
| `↳↳ shipment_method` | string | The shipment method for bound orders.Available values: pickup, dropoff, self_deliver. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · Area is invalid.Now we only support area in {area}. · The shop has no permission for first mile support. · The shop has no permission for first mile pre declare. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.get_courier_delivery_channel_list
`GET /api/v2/first_mile/get_courier_delivery_channel_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get courier information for courier delivery method.

Lịch sử cập nhật: 2026-10-30: add courier_code as response parameter; 2024-10-29: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `region` | string |  | Use this field to specify the region you want to ship parcel. Available value: CN |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ logistics_channel_list` | object[] |  |
| `↳↳ logistics_product_id` | int64 | The identity of logistics product ID: 1010003: kuaidi100 to C 1010004: kuaidi100 prepaid(MP) |
| `↳↳ logistics_product_name` | string | The name of logistics product ID: - kuaidi100 to C - kuaidi100 prepaid(MP) |
| `↳↳ courier_list` | object[] |  |
| `↳↳↳ courier_name` | string | The name of the courier. |
| `↳↳↳ courier_service_id` | string | The identity of the service provided by courier. |
| `↳↳↳ courier_service_name` | string | The name of the service provided by courier. |
| `↳↳↳ courier_code` | string | The code of the courier. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.get_transit_warehouse_list
`GET /api/v2/first_mile/get_transit_warehouse_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get transit warehouse list which is used for first mile tracking number generation for courier delivery method.

Lịch sử cập nhật: 2026-03-23: Add shipment_method request parameter; 2026-03-20: Add warehouse_type response parameter; 2024-10-29: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `region` | string |  | Use this field to specify the region you want to ship parcel. Available value: CN. |
| `shipment_method` | string |  | Use this field to specify the shipment method you want to ship parcel. Available value: pickup, dropoff, self_deliver, courier_delivery. Note: Only when shipment_method = dropoff, the API response will include warehouses where warehouse_type = 1 (vendor warehouse). |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ transit_warehouse_list` | object[] |  |
| `↳↳ warehouse_id` | string | The identity of transit warehouse. |
| `↳↳ warehouse_name_en` | string | The name of transit warehouse in English. |
| `↳↳ warehouse_name_cn` | string | The name of transit warehouse in Chinese. |
| `↳↳ warehouse_type` | int32 | Warehouse type: 0 = normal warehouse 1 = vendor warehouse Note: Only when shipment_method = dropoff, the API response will include warehouses where warehouse_type = 1 (vendor warehouse). |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.generate_and_bind_first_mile_tracking_number
`POST /api/v2/first_mile/generate_and_bind_first_mile_tracking_number` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to generate first mile tracking number for courier delivery method.

Lịch sử cập nhật: 2024-10-29: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shipment_method` | string | ✔ | The shipment method for generate and bind orders. Available value: courier_delivery. |
| `region` | string |  | Use this field to specify the region you want to ship parcel. Available value: CN. |
| `order_list` | object[] | ✔ | The list of order_sn. You can specify up to 50 order_sns in this call. One fm_tn maximum number of total bind orders is 10000. |
| `↳ order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `↳ package_number` | string |  | Shopee's unique identifier for the package under an order. You should fill the field with empty string when there isn't a package number. |
| `courier_delivery_info` | object | ✔ | The set of information you need to generate FM tracking number and bind orders. |
| `↳ address_id` | int64 | ✔ | The identity of address. Retrieved from v2.logistics.get_address_list, address_type need to be FIRST_MILE_PICKUP_ADDRESS. |
| `↳ warehouse_id` | string | ✔ | The identity of transit warehouse address. Retrieved from v2.first_mile.get_transit_warehouse_list. |
| `↳ logistics_product_id` | int64 | ✔ | The definition of logistics product ID: 1010003 (kuaidi100 to C) - seller book courier pickup and pay offline 1010004 (kuaidi100 prepaid(MP)) - seller can use prepaid account to place courier order, so prepaid_account_id is required |
| `↳ prepaid_account_id` | int64 |  | ID of prepaid account. Retrieved from v2.merchant.get_merchant_prepaid_account_list. |
| `↳ courier_service_id` | string | ✔ | The identity of courier service. Retrieved from v2.first_mile.get_courier_delivery_channel_list. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ binding_id` | string | Binding ID |
| `↳ success_list` | object[] |  |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳ fail_list` | object[] |  |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.bind_courier_delivery_first_mile_tracking_number
`POST /api/v2/first_mile/bind_courier_delivery_first_mile_tracking_number` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to bind first mile tracking number for courier delivery method.

Lịch sử cập nhật: 2024-10-29: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shipment_method` | string | ✔ | The shipment method for generate and bind orders. Available value: courier_delivery. |
| `binding_id` | string | ✔ | If using courier_delivery as the shipment method, the "binding_id" field should pass the value generated from v2.first_mile.generate_and_bind_first_mile_tracking_number. |
| `order_list` | object[] | ✔ | The list of order_sn. You can specify up to 50 order_sns in this call. One fm_tn maximum number of total bind orders is 10000. |
| `↳ order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `↳ package_number` | string |  | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there isn't a package number. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ binding_id` | string | Binding ID |
| `↳ success_list` | object[] |  |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳ fail_list` | object[] |  |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.unbind_first_mile_tracking_number_all
`POST /api/v2/first_mile/unbind_first_mile_tracking_number_all` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to unbind orders from first mile tracking number or binding ID.

Lịch sử cập nhật: 2024-10-29: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_list` | object[] | ✔ | The list of order info you want to unbind from the first mile tracking number or binding ID. You can specify up to 50 order_sns in this call. |
| `↳ order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `↳ package_number` | string |  | Shopee's unique identifier for the package under an order. You should fill the field with empty string when there isn't a package number. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ success_list` | object[] |  |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ binding_id` | string | Binding ID |
| `↳↳ first_mile_tracking_number` | string | The generated first-mile tracking number, value might be blank. |
| `↳ fail_list` | object[] |  |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: There is common business error · You used a Delivered FM code, please use a new FM code. · Your predeclared order creation time is later than pick up time, please use a new FM code. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.get_courier_delivery_detail
`GET /api/v2/first_mile/get_courier_delivery_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get first mile detail for courier delivery method.

Lịch sử cập nhật: 2024-10-29: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `binding_id` | string | ✔ | Binding ID |
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int64 |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. limit [1, 50]. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ binding_id` | string | Binding ID |
| `↳ first_mile_tracking_number` | string | The first mile tracking number. |
| `↳ status` | string | The logistics status for first-mile tracking number. Status could be: CANCELED CANCELING DELIVERED NOT_AVAILABLE ORDER_CREATED ORDER_RECEIVED PICKED_UP |
| `↳ declare_date` | string | The specified delivery date. |
| `↳ more` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of items. |
| `↳ next_cursor` | string | If more is true, you should pass the next_cursor in the next request as cursor. The value of next_cursor will be empty string when more is false. |
| `↳ order_list` | object[] |  |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ sls_tracking_number` | string | The tracking number of SLS for orders/forders. |
| `↳↳ pick_up_done` | boolean | Use this filed to indicate whether the order has been picked up by carrier. |
| `↳↳ arrived_transit_warehouse` | boolean | Use this filed to indicate whether the order has arrived at transit warehouse. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.get_courier_delivery_waybill
`POST /api/v2/first_mile/get_courier_delivery_waybill` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get first mile waybill file for courier delivery method.

Lịch sử cập nhật: 2024-10-29: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `binding_id_list` | string[] | ✔ | Binding ID list of waybill. System limits maximum of Binding ID to 50. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ waybill_list` | object[] |  |
| `↳↳ binding_id` | string | Binding ID |
| `↳↳ shipping_label_url` | string | URL for downloading waybill. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.get_courier_delivery_tracking_number_list
`POST /api/v2/first_mile/get_courier_delivery_tracking_number_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get tracking number for courier delivery method.

Lịch sử cập nhật: 2026-10-30: Added request parameters time_range_type, from_timestamp and to_timestamp. from_date and to_date are no longer required when from_timestamp and to_timestamp are passed.; 2025-07-25: Add response filed "reason"; 2024-10-29: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `from_date` | string |  | The start time of creation time. Format YYYY-MM-DD, in the shop region's local time. Required when from_timestamp and to_timestamp are not passed. Ignored when they are passed. |
| `to_date` | string |  | The end time of creation time. Format YYYY-MM-DD, in the shop region's local time. The whole day is included (until 23:59:59). Required when from_timestamp and to_timestamp are not passed. Ignored when they are passed. |
| `time_range_type` | string |  | The time field that the query range applies to and that results are sorted by. Available values: create_time, update_time. Defaults to create_time when not passed. |
| `from_timestamp` | int64 |  | Start of the query range, Unix timestamp in seconds. Must be passed together with to_timestamp. When passed, from_date and to_date are ignored. |
| `to_timestamp` | int64 |  | End of the query range, Unix timestamp in seconds. Must be passed together with from_timestamp and must not be earlier than from_timestamp. |
| `page_size` | int64 |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. limit [1, 50] |
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the offset can be some entry to start next call. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ tracking_number_list` | object[] |  |
| `↳↳ binding_id` | string | The generated binding ID. |
| `↳↳ first_mile_tracking_number` | string | The generate first-mile tracking number, value might be blank. |
| `↳↳ status` | string | The logistics status for first-mile tracking number. Status could be: CANCELED CANCELING DELIVERED NOT_AVAILABLE ORDER_CREATED ORDER_RECEIVED PICKED_UP Note: NOT_AVAILABLE status means that Binding ID / First Mile Tracking Number is not yet bound with any order. |
| `↳↳ reason` | string | Indicate the reason when Shopee failed to place courier order to 3PL (Kuaidi 100 supporting) or courier company cancelled the order. Note: Will be empty if status is not CANCELED. |
| `↳↳ declare_date` | string | The declare date of binding ID/first-mile tracking number. |
| `↳ more` | boolean | This is to indicate whether the tracking number list is more than one page. If this value is true, you may want to continue to check next page to retrieve tracking numbers. |
| `↳ next_cursor` | string | If more is true, you should pass the next_cursor in the next request as cursor. The value of next_cursor will be empty string when more is false. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.cancel_courier_delivery_first_mile_tracking_number
`POST /api/v2/first_mile/cancel_courier_delivery_first_mile_tracking_number` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

Use this api to cancel first mile tracking number for courier delivery method.

Lịch sử cập nhật: 2026-10-23: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `binding_id` | string | ✔ |  |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ binding_id` | string | Binding ID |
| `↳ unbinded_order_list` | object[] |  |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.first_mile.get_waybill_filelink
`POST /api/v2/first_mile/get_waybill_filelink` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

Use this api to get first mile waybill file link.

Lịch sử cập nhật: 2026-10-23: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `first_mile_tracking_number_list` | string[] | ✔ | The first mile tracking number that you want to print waybill.limit [1, 50] |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `file_link` | string | The download link to the waybill file. The link will be valid for 30 minutes. |

Lỗi riêng: Get waybill fail due to the network error. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · The ShopID and Pickup Label are not matched. · Inner http call failed · parse data failed · data not exist · Something wrong. Please try later. · The information you queried is not found. · shopid is invalid · request not from gateway

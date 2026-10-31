# Module Logistics (48 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.logistics.get_shipping_parameter
`GET /api/v2/logistics/get_shipping_parameter` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to check if the package support pickup, dropoff, or non-integrated method. For pickup, will return addresses and pickup time id options. For dropoff, will return branch id, sender real name etc, depending on 3PL requirements. [Please call this API when packages meet: 1) fulfillment status is LOGISTICS_READY; or 2) fulfillment status is LOGISTICS_PICKUP_RETRY; or 3) fulfillment status is LOGISTICS_REQUEST_CREATED and meet Instant Order Reschedule Pickup conditions]

Lịch sử cập nhật: 2026-03-13: Support getting shipping parameter for Instant Order Reschedule Pickup; 2025-03-24: Add “flags” response parameter under time_slot_list; 2023-04-10: add optional parameter package_number apply for split order.; 2022-01-20: update Dropoff slug_list and Dropoff description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `package_number` | string |  | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there is't a package number. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ info_needed` | object | The parameters required based on each specific order to Init. Must use the fields included under info_needed to call Init. For logistic_id 80003 and 80004, both Regular and JOB shipping methods are supported. If you choose Regular shipping method, please use "tracking_no" to call Init API. If you choose JOB shipping method, please use "sender_real_name" to call Init API. Note that only one of "tracking_no" and "sender_real_name" can be selected. |
| `↳↳ dropoff` | string[] | Could contain 'branch_id', 'sender_real_name' or 'tracking_no'. If it contains 'branch_id', choose one to Init. If it contains 'sender_real_name' or 'tracking_no', should manually input these values in Init API. If it has empty value, developer should still include "dropoff" field in Init API.Could contain 'slug'.If it contains 'slug', to return selected 3PL partner only for TW C2C sellers to drop-off parcels with. |
| `↳↳ pickup` | string[] | Could contain 'address_id' and 'pickup_time_id'. Choose one address_id and its corresponding pickup_time_id to Init. If it has empty value, developer should still include "pickup" field in Init API.It could contains "tracking_number" returned from "info_need"for some channels, please also add it when init. |
| `↳↳ non_integrated` | string[] | Could contain 'tracking_no'. If it contains 'tracking_no', should manually input these values in Init API. If it has empty value, developer should still include "non-integrated" field in Init API. |
| `↳ dropoff` | object | Logistics information for dropoff mode order. |
| `↳↳ branch_list` | object[] | List of available dropoff branches info. |
| `↳↳↳ branch_id` | int | The identity of logistics branch. |
| `↳↳↳ region` | string | The region of specify address. |
| `↳↳↳ state` | string | The state of specify address. |
| `↳↳↳ city` | string | The city of specify address. |
| `↳↳↳ address` | string | The address description of specify address. |
| `↳↳↳ zipcode` | string | The zipcode of specify address. |
| `↳↳↳ district` | string | The district of specify address. |
| `↳↳↳ town` | string | The town of specify address. |
| `↳↳ slug_list` | object[] | List of available TW 3PL drop-off partners. |
| `↳↳↳ slug` | string | The identity of slug. |
| `↳↳↳ slug_name` | string | The name of slug. |
| `↳ pickup` | object | Logistics information for pickup mode order. |
| `↳↳ address_list` | object[] | List of available pickup address info. |
| `↳↳↳ address_id` | int64 | The identity of address. |
| `↳↳↳ region` | string | The region of specify address. |
| `↳↳↳ state` | string | The state of specify address. |
| `↳↳↳ city` | string | The city of specify address. |
| `↳↳↳ district` | string | The district of specify address. |
| `↳↳↳ town` | string | The town of specify address. |
| `↳↳↳ address` | string | The address description of specify address. |
| `↳↳↳ zipcode` | string | The zipcode of specify address. |
| `↳↳↳ address_flag` | string[] | The flag of shop address, applicable values: default_address, pickup_address, return_address, current_address(only for multi-warehouse sellers) |
| `↳↳↳ time_slot_list` | object[] | List of pickup_time information corresponding to the address_id. Some logistics channels may not return any date or time for pickup time slots. In such cases, sellers can arrange shipment without selecting any time slot, and Shopee will arrange a suitable timing for these situations. |
| `↳↳↳↳ date` | timestamp | The date of pickup time. In timestamp. |
| `↳↳↳↳ time_text` | string | The text description of pickup time. Only applicable for certain channels. |
| `↳↳↳↳ pickup_time_id` | string | The identity of pickuptime. |
| `↳↳↳↳ flags` | string[] | This field will have the value “recommended” for the time slot that Shopee suggests sellers choose. While it is advisable for sellers to choose the recommended time slot, they can also choose other time slots that do not have the recommended flag. |

Lỗi riêng: The order is being allocated, please wait until the allocate is completed. · Fail to find the fulfillment channel of this order. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Please upload the invoice or verify the details of the document already submitted, which is currently flagged as invalid by SEFAZ. Correction is required to release the shipment. · Shop id is invalid. Please check your shop. · Please request with package_number for this split order. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · Inner http call failed · parse data failed · data not exist · parameter invalid · OFG list type is not TO_PROCESS

## v2.logistics.get_mass_shipping_parameter
`POST /api/v2/logistics/get_mass_shipping_parameter` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to check if package support pickup, dropoff, non-integrated. For pickup, return address and pickup time id options. For dropoff, return branch id, sender real name, etc. Can batch request for packages under same product_location_id and logistics_channel_id. [Please call it when packages meet: 1) fulfillment status is LOGISTICS_READY; or 2) fulfillment status is LOGISTICS_PICKUP_RETRY; or 3) fulfillment status is LOGISTICS_REQUEST_CREATED and meet Instant Order Reschedule conditions]

Lịch sử cập nhật: 2026-03-13: Support getting shipping parameter for Instant Order Reschedule Pickup; 2025-03-24: Add "flags" response parameter under time_slot_list; 2025-02-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `logistics_channel_id` | int64 |  | The API can only batch request the shipping parameter for multiple packages under the same product_location_id and same logistics_channel_id. Use this field to specify the logistics_channel_id for the request. If not specified, will use the logistics_channel_id corresponds to the first package_number by default. |
| `product_location_id` | string |  | The API can only batch request the shipping parameter for multiple packages under the same product_location_id and same logistics_channel_id. Use this field to specify the product_location_id for the request. If not specified, will use the product_location_id corresponds to the first package_number by default. |
| `package_list` | object[] | ✔ | The list of packages you want to get shipping parameters. limit [1, 50]. |
| `↳ package_number` | string | ✔ | Shopee's unique identifier for the package under an order. You shouldn't fill the field with empty string when there isn't a package number. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ info_needed` | object | The parameters required based on each specific order to Init. Must use the fields included under info_needed to call Init. For logistic_id 80003 and 80004, both Regular and JOB shipping methods are supported. If you choose Regular shipping method, please use "tracking_no" to call Init API. If you choose JOB shipping method, please use "sender_real_name" to call Init API. Note that only one of "tracking_no" and "sender_real_name" can be selected. |
| `↳↳ dropoff` | string[] | Could contain 'branch_id', 'sender_real_name', or 'tracking_no'. If it contains 'branch_id', choose one to Init. If it contains 'sender_real_name' or 'tracking_no', should manually input these values in Init API. If it has empty value, developer should still include "dropoff" field in Init API. |
| `↳↳ pickup` | string[] | Could contain 'address_id' and 'pickup_time_id'. Choose one address_id and its corresponding pickup_time_id to Init. If it has empty value, developer should still include "pickup" field in Init API. It could contains "tracking_number" returned from "info_need"for some channels, please also add it when init. |
| `↳↳ non_integrated` | string[] | Could contain 'tracking_no'. If it contains 'tracking_no', should manually input these values in Init API. If it has empty value, developer should still include "non-integrated" field in Init API. |
| `↳ dropoff` | object | Logistics information for dropoff mode package. |
| `↳↳ branch_list` | object[] | List of available dropoff branches info. |
| `↳↳↳ branch_id` | int64 | The identity of logistics branch. |
| `↳↳↳ region` | string | The region of specify address. |
| `↳↳↳ state` | string | The state of specify address. |
| `↳↳↳ city` | string | The city of specify address. |
| `↳↳↳ address` | string | The address description of specify address. |
| `↳↳↳ zipcode` | string | The zipcode of specify address. |
| `↳↳↳ district` | string | The district of specify address. |
| `↳↳↳ town` | string | The town of specify address. |
| `↳ pickup` | object | Logistics information for pickup mode package. |
| `↳↳ address_list` | object[] | List of available pickup address info. For Multi-Warehouse sellers, note that changing pickup address from Current may incur higher shipping fees. |
| `↳↳↳ address_id` | int64 | The identity of address. |
| `↳↳↳ region` | string | The region of specify address. |
| `↳↳↳ state` | string | The state of specify address. |
| `↳↳↳ city` | string | The city of specify address. |
| `↳↳↳ district` | string | The district of specify address. |
| `↳↳↳ town` | string | The town of specify address. |
| `↳↳↳ address` | string | The address description of specify address. |
| `↳↳↳ zipcode` | string | The zipcode of specify address. |
| `↳↳↳ address_flag` | string[] | The flag of shop address, applicable values: default_address, pickup_address, return_address, current_address (Multi-Warehouse sellers only) |
| `↳↳↳ time_slot_list` | object[] | List of pickup_time information corresponding to the address_id. Some logistics channels may not return any date or time for pickup time slots. In such cases, sellers can arrange shipment without selecting any time slot, and Shopee will arrange a suitable timing for these situations. |
| `↳↳↳↳ date` | timestamp | The date of pickup time. In timestamp. |
| `↳↳↳↳ time_text` | string | The text description of pickup time. Only applicable for certain channels. |
| `↳↳↳↳ pickup_time_id` | string | The identity of pickuptime. |
| `↳↳↳↳ flags` | string[] | This field will have the value “recommended” for the time slot that Shopee suggests sellers choose. While it is advisable for sellers to choose the recommended time slot, they can also choose other time slots that do not have the recommended flag. |
| `↳ success_list` | object[] | Success package list. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳ fail_list` | object[] | Fail package list. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ fail_reason` | string | Reason for failure. |

Lỗi riêng: Duplicate package number · Please upload the invoice or verify the details of the document already submitted, which is currently flagged as invalid by SEFAZ. Correction is required to release the shipment. · Package is not under the specified fulfilment channel · Package is not under the specified warehouse · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · Package exceeds limit. · parse data failed · data not exist · parameter invalid · Shipping parameters can only be obtained when package is ready to be shipped · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · No available time slot

## v2.logistics.ship_order
`POST /api/v2/logistics/ship_order` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to initiate logistics including arrange pickup, dropoff or shipment for non-integrated logistic channels. Should call v2.logistics.get_shipping_parameter to fetch all required param first. It's recommended to initiate logistics one hour after the orders were placed.

Lịch sử cập nhật: 2025-09-18: Updated description to indicate the order_status logic of BR Seller Logistics channel (logistics_channel_id: 90021) and BR Instant Delivery channel (logistics_channel_id: 90026); 2022-07-13: update the pickup_time_id description; 2022-01-24: update request parameters slug; 2022-01-20: update dropoff slug for TW OK-SPX; 2021-12-08: update the Request Example

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `package_number` | string |  | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there is't a package number. |
| `pickup` | object |  | Required parameter ONLY if get_shipping_parameter returns "pickup" under "info_needed". Developer should still include "pickup" field in the call even if "pickup" has empty value. |
| `↳ address_id` | int64 | ✔ | The identity of address. Retrieved from v2.logistics.get_shipping_parameter. |
| `↳ pickup_time_id` | string |  | The pickup time id. Retrieved from v2.logistics.get_shipping_parameter, you can only select one from the time_slot_list. Some logistics channels may not return any date or time for pickup time slots. In such cases, sellers can arrange shipment without selecting any time slot, and Shopee will arrange a suitable timing for these situations. |
| `↳ tracking_number` | string |  | Need input this field when "tracking_number" is returned from "info_need". Please note that this tracking number is assigned by third-party shipping carrier for item shipment. |
| `dropoff` | object |  | Required parameter ONLY if get_shipping_parameter returns "dropoff" under "info_needed". Developer should still include "dropoff" field in the call even if "dropoff" has empty value. For logistic_id 80003 and 80004, both Regular and JOB shipping methods are supported. If you choose Regular shipping method, please use "tracking_no" to call Init API. If you choose JOB shipping method, please use "sender_real_name" to call Init API. Note that only one of "tracking_no" and "sender_real_name" can be selected. |
| `↳ branch_id` | int64 |  | The identity of branch. |
| `↳ sender_real_name` | string |  | The real name of sender. |
| `↳ tracking_number` | string |  | Need input this field when "tracking_number" is returned from "info_need". Please note that this tracking number is assigned by third-party shipping carrier for item shipment. |
| `↳ slug` | string |  | The selected 3PL partner to drop-off parcels with. |
| `non_integrated` | object |  | Optional parameter when get_shipping_parameter returns "non-integrated" under "info_needed". |
| `↳ tracking_number` | string |  | Optional parameter for non-integrated channel order. The tracking number assigned by the shipping carrier for item shipment. |

Lỗi riêng: The address is invalid. Please check the address. · The address is invalid. Please check the address. · Address is not found. · Address is not supported. · Address is not supported current operation. · The order is being allocated, please wait until the allocate is completed. · Buyer name is prohibited. · Business process failed. · Business validation failed. · Buyer address is not found. · Please wait for buyer to reselect the delivery convenience store. · Logistic status is not supported. · Cancel is not allowed. · There are contraband goods in the order. · Fail to find the fulfillment channel of this order.

## v2.logistics.mass_ship_order
`POST /api/v2/logistics/mass_ship_order` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to initiate logistics including arrange pickup, dropoff or shipment for non-integrated logistic channels. Should call v2.logistics.get_mass_shipping_parameter to fetch all required params first. It's recommended to initiate logistics one hour after the orders were placed since there is one-hour window buyer can cancel any order without request to seller. The API can only batch arrange shipment for multiple packages under the same product_location_id and same logistics_channel_id.

Lịch sử cập nhật: 2025-02-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `logistics_channel_id` | int64 |  | The API can only batch arrange shipment for multiple packages under the same product_location_id and same logistics_channel_id. Use this field to specify the logistics_channel_id for the request. If not specified, will use the logistics_channel_id corresponds to the first package_number by default. |
| `product_location_id` | string |  | The API can only batch arrange shipment for multiple packages under the same product_location_id and same logistics_channel_id. Use this field to specify the product_location_id for the request. If not specified, will use the product_location_id corresponds to the first package_number by default. |
| `package_list` | object[] | ✔ | The list of packages you want to arrange shipment. limit [1, 50]. |
| `↳ package_number` | string | ✔ | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there is't a package number. |
| `pickup` | object |  | Required parameter ONLY if GetParameterForInit returns "pickup" or if GetLogisticsInfo returns "pickup" under "info_needed" for the same order. Developer should still include "pickup" field in the call even if "pickup" has empty value. |
| `↳ address_id` | int64 |  | The identity of address. |
| `↳ pickup_time_id` | string |  | The pickup time id. Retrieved from v2.logistics.get_mass_shipping_parameter, you can only select one from the time_slot_list. Some logistics channels may not return any date or time for pickup time slots. In such cases, sellers can arrange shipment without selecting any time slot, and Shopee will arrange a suitable timing for these situations. |
| `dropoff` | object |  | Required parameter ONLY if GetParameterForInit returns "dropoff" or if GetLogisticsInfo returns "dropoff" under "info_needed" for the same order. Developer should still include "dropoff" field in the call even if "dropoff" has empty value. For logistic_id 80003 and 80004, both Regular and JOB shipping methods are supported. If you choose Regular shipping method, please use "tracking_no" to call Init API. If you choose JOB shipping method, please use "sender_real_name" to call Init API. Note that only one of "tracking_no" and "sender_real_name" can be selected. |
| `↳ branch_id` | int64 |  | The identity of branch. |
| `↳ sender_real_name` | string |  | The real name of sender. |
| `↳ tracking_number` | string |  | Need input this field when "tracking_number" is returned from "info_need". Please note that this tracking number is assigned by third-party shipping carrier for item shipment. |
| `non_integrated` | object |  | Optional parameter when get_mass_shipping_parameter returns "non-integrated" under "info_needed". |
| `↳ tracking_number` | object[] |  | Optional parameter for non-integrated channel order. The tracking number assigned by the shipping carrier for item shipment. |
| `↳↳ package_number` | string | ✔ | Shopee's unique identifier for the package under an order. |
| `↳↳ tracking_number` | string | ✔ | Optional parameter for non-integrated channel order. The tracking number assigned by the shipping carrier for item shipment. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `success_list` | object[] | Success package list. |
| `↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `fail_list` | object[] | Fail package list. |
| `↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳ fail_reason` | string | Reason for failure. |

Lỗi riêng: Duplicate package number · Please upload the invoice or verify the details of the document already submitted, which is currently flagged as invalid by SEFAZ. Correction is required to release the shipment. · Package is not under the specified fulfilment channel · Package is not under the specified warehouse · Shop id: {shop_id} didn't set {return_store_name} return store, please go back to Shopee Seller Center to complete the setting. · Shop id: {shop_id},return store:{return_store_name} not found. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · This package has already been arranged shipment and you can't call this API again. · Package exceeds limit. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.logistics.update_shipping_order
`POST /api/v2/logistics/update_shipping_order` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

For pickup method only, use this api to update pickup address and pickup time for packages meet: 1) package's fulfillment status is LOGISTICS_PICKUP_RETRY; or 2) package's fulfillment status is 'LOGISTICS_REQUEST_CREATED' and meets the Instant Order Reschedule Pickup conditions.

Lịch sử cập nhật: 2026-03-13: Support reschedule pickup for instant order; 2025-11-20: Set the format of address_id to int64.; 2021-06-02: Update the request parameters description.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `package_number` | string |  | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there is't a package number. |
| `pickup` | object | ✔ | Required parameter ONLY if GetParameterForInit returns "pickup" or if GetLogisticsInfo returns "pickup" under "info_needed" for the same order. Developer should still include "pickup" field in the call even if "pickup" has empty value. |
| `↳ address_id` | int64 | ✔ | The identity of address. Retrieved from get_shipping_parameter. |
| `↳ pickup_time_id` | string | ✔ | The pickup time id. Retrieved from get_shipping_parameter. |

Lỗi riêng: The address is invalid. Please check the address. · The address is invalid. Please check the address. · Address is not found. · Address is not supported. · Address is not supported current operation. · The order is being allocated, please wait until the allocate is completed. · Buyer name is prohibited. · Business process failed. · Business validation failed. · Buyer address is not found. · Please wait for buyer to reselect the delivery convenience store. · Logistic status is not supported. · Cancel is not allowed. · There are contraband goods in the order. · Fail to find the fulfillment channel of this order.

## v2.logistics.get_tracking_number
`GET /api/v2/logistics/get_tracking_number` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Customer Service, Swam ERP

After arranging shipment (v2.logistics.ship_order) for the integrated channel, use this api to get the tracking_number, which is a required parameter for creating shipping labels. The api response can return tracking_number empty, since this info is dependent from the 3PL, due to this it is allowed to keep calling the api within 5 minutes interval, until the tracking_number is returned.

Lịch sử cập nhật: 2021-06-15: add hint field to response; 2021-03-30: ADD PLP NUMBER

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `package_number` | string |  | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there isn't a package number. |
| `response_optional_fields` | string |  | Indicate response fields you want to get. Please select from the below response parameters. If you input an object field, all the params under it will be included automatically in the response. If there are multiple response fields you want to get, you need to use English comma to connect them. Available values: plp_number, first_mile_tracking_number,last_mile_tracking_number |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ tracking_number` | string | The tracking number of this order. |
| `↳ plp_number` | string | The unique identifier for package of BR correios. |
| `↳ first_mile_tracking_number` | string | The first mile tracking number of the order. Only for Cross Border Seller |
| `↳ last_mile_tracking_number` | string | The last mile tracking number of the order. Only for Cross Border BR seller. |
| `↳ hint` | string | Indicate hint information if cannot get some fields under special scenarios. For example, cannot get tracking_number when cvs store is closed. |
| `↳ pickup_code` | string | For drivers to quickly identify parcel to be picked up. Only returned for ID local orders who using instant+sameday for delivery. |

Lỗi riêng: The order is being allocated, please wait until the allocate is completed. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · The order is not exist. · The package is not exist. · Shop id is invalid. Please check your shop. · Please request with package_number for this split order. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found.

## v2.logistics.get_mass_tracking_number
`POST /api/v2/logistics/get_mass_tracking_number` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

After arranging shipment (v2.logistics.mass_ship_order) for the integrated channel, use this api to get the tracking_number, which is a required parameter for creating shipping labels. The api response can return tracking_number empty, since this info is dependent from the 3PL, due to this it is allowed to keep calling the api within 5 minutes interval, until the tracking_number is returned.

Lịch sử cập nhật: 2025-02-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `package_list` | object[] | ✔ | The list of packages you want to get tracking number. limit [1, 50]. |
| `↳ package_number` | string | ✔ | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there isn't a package number. |
| `response_optional_fields` | string |  | Indicate response fields you want to get. Please select from the below response parameters. If you input an object field, all the params under it will be included automatically in the response. If there are multiple response fields you want to get, you need to use English comma to connect them. Available values: plp_number, first_mile_tracking_number,last_mile_tracking_number. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ success_list` | object[] | Success package list. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ tracking_number` | string | The tracking number of this order. |
| `↳↳ plp_number` | string | The unique identifier for package of BR correios. |
| `↳↳ first_mile_tracking_number` | string | The first mile tracking number of the order. Only for Cross Border Seller |
| `↳↳ last_mile_tracking_number` | string | The last mile tracking number of the order. Only for Cross Border BR seller. |
| `↳↳ hint` | string | Indicate hint information if cannot get some fields under special scenarios. For example, cannot get tracking_number when cvs store is closed. |
| `↳↳ pickup_code` | string | For drivers to quickly identify parcel to be picked up. Only returned for instant+sameday orders. |
| `↳ fail_list` | object[] | Fail package list. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ fail_reason` | string | Reason for failure. |

Lỗi riêng: Duplicate package number · Package is not under the specified fulfilment channel · Package is not under the specified warehouse · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · Package exceeds limit. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.get_shipping_document_parameter
`POST /api/v2/logistics/get_shipping_document_parameter` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get the selectable shipping_document_type and suggested shipping_document_type.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_list` | object[] | ✔ | The list of orders you want to get. limit [1,50] |
| `↳ order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `↳ package_number` | string |  | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there is't a package number. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ result_list` | object[] | The list of the result data. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ suggest_shipping_document_type` | string | The shipping document type Shopee suggests. If you don't select any shipping document type, Shopee will use this as default shipping document type. |
| `↳↳ selectable_shipping_document_type` | string[] | The shipping document type you can select of this order. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: The order is being allocated, please wait until the allocate is completed. · Failed, please check result_list for more details. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · The package_number {package_number} is not exist. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · This shipping channel only supports document printing in Shopee seller center · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}.

## v2.logistics.create_shipping_document
`POST /api/v2/logistics/create_shipping_document` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to create shipping document task for each order or package and this API is only available after retrieving the tracking number.

Lịch sử cập nhật: 2025-07-07: Add THERMAL_UNPACKAGED_LABEL option for shipping_document_type; 2023-05-15: update the API description.; 2021-09-07: update the request example; 2021-07-14: edit description of tracking number

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_list` | object[] | ✔ | The list of order you want to create shipping document. limit [1, 50] |
| `↳ order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `↳ package_number` | string |  | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there is not a package number. |
| `↳ tracking_number` | string |  | The tracking number of order. Required except for the channel allow print before arrange shipment. |
| `↳ shipping_document_type` | string |  | The type of shipping document. Available values: NORMAL_AIR_WAYBILL, THERMAL_AIR_WAYBILL, NORMAL_JOB_AIR_WAYBILL, THERMAL_JOB_AIR_WAYBILL, THERMAL_UNPACKAGED_LABEL |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ result_list` | object[] | The list of the result data. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: The order is being allocated, please wait until the allocate is completed. · Order status does not support awb printing. · Failed, please check result_list for more details. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · The shipping_document_type is not invalid. Please check the shipping_document_type. · This order is matched order with booking, don't need arrange shipment through seller side. · The package can not print now. · The package_number {package_number} is not exist. · Please request with package_number for this split order. · The tracking number is invalid. Please check the tracking number. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · This order is part of a combined parcel, please use Seller Center instead.

## v2.logistics.get_shipping_document_result
`POST /api/v2/logistics/get_shipping_document_result` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to retrieve the status of the shipping document task. Document will be available for download only after the status change to 'READY'.

Lịch sử cập nhật: 2025-07-07: Add THERMAL_UNPACKAGED_LABEL option for shipping_document_type; 2023-05-15: update the API description.; 2022-07-01: update the request and respond example

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_list` | object[] | ✔ | The list of orders, limit [1,50] |
| `↳ order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `↳ package_number` | string |  | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there is't a package number. |
| `↳ shipping_document_type` | string |  | The type of shipping document. Available values: NORMAL_AIR_WAYBILL, THERMAL_AIR_WAYBILL, NORMAL_JOB_AIR_WAYBILL, THERMAL_JOB_AIR_WAYBILL, THERMAL_UNPACKAGED_LABEL |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ result_list` | object[] | The result data list of the API response. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ status` | string | The status of the shipping document task you querying with order_sn. Available values: READY， FAILED， PROCESSING |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: Failed, please check result_list for more details. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Unknown error, please contact Shopee to check. Detail: {msg} · This order is matched order with booking, don't need arrange shipment through seller side. · The order_sn {order_sn} is not exist. · The package can not print now, please create shipping document first.Detail: {msg} · Please request with package_number for this split order. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · Inner http call failed · parse data failed · data not exist · parameter invalid

## v2.logistics.download_shipping_document
`POST /api/v2/logistics/download_shipping_document` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to download shipping_document. You have to call v2.logistics.create_shipping_document to create a new shipping document task first and call v2.logistics.get_shipping_document_resut to get the task status second. If the task is READY, you can download this shipping document.

Lịch sử cập nhật: 2025-07-07: Add THERMAL_UNPACKAGED_LABEL option for shipping_document_type; 2021-07-19: update request example

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shipping_document_type` | string |  | The type of shipping document. Available values: NORMAL_AIR_WAYBILL, THERMAL_AIR_WAYBILL, NORMAL_JOB_AIR_WAYBILL, THERMAL_JOB_AIR_WAYBILL, THERMAL_UNPACKAGED_LABEL |
| `order_list` | object[] | ✔ | The list of orders you need to download it's shipping document. Limit [1, 50]. Orders must be from the same courier |
| `↳ order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `↳ package_number` | string |  | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there is't a package number. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `waybill` | file | The waybill file. |

Lỗi riêng: System error. Please try again later. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Unknown error, please contact Shopee to check. Detail: {msg} · This order is matched order with booking, don't need arrange shipment through seller side. · The order_sn {order_sn} is not exist. · The package_number {package_number} is not exist. · Some package failed to print, please try again later. Detail: {msg} · Packages can not download together. Detail: {msg} · Processing, please download later. Detail: {msg} · The package can not print now, please create shipping document first.Detail: {msg} · Please request with package_number for this split order. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment

## v2.logistics.get_shipping_document_data_info
`POST /api/v2/logistics/get_shipping_document_data_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to fetch the logistics information of an order, these info can be used for self-design AWB printing. Besides, this api supports returning personal info as images.

Lịch sử cập nhật: 2026-07-15: Add response fields " high_value", "dg_specific_type", "hotspot_id", "weekend1_delivery_success_label", "weekend2_delivery_success_label"; 2025-08-14: Support for pre-shipment printing of self-designed AWBs for certain logistics channels; 2025-07-07: Add new response fields "sorting_group", "unpackaged_sku_id", "unpackaged_sku_id_qrcode"; 2024-04-15: add new response fields "dely_fri_label", "dely_sat_label", "dely_sun_label"; 2023-05-12: add is_mutual_check field for VN/ID shops

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `package_number` | string |  | Shopee's unique identifier for the package under an order. You shouldn't fill the field with empty string when there isn't a package number. |
| `recipient_address_info` | object[] |  | recipient address to query as image |
| `↳ key` | string | ✔ | fields to query in the recipient address, should be name , phone , full_address, town , district , city , state , region , zipcode . |
| `↳ style` | object |  | image style |
| `↳↳ text_style` | string[] |  | supports bold and italic |
| `↳↳ font_size` | int32 |  | supports 1 - 108 |
| `↳↳ text_color` | string |  | color string like "#AbCd12" |
| `↳↳ image_width` | float |  | supports 0.1-30, in centimeters |
| `↳↳ h_align` | string |  | text horizontal align, supports left, center and right. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. Note: For parcels that support pre-shipment printing, calling this API before shipment will only return the following fields: response recipient_address_info key image shipping_document_info cod cod_amount order_weight logistics_channel_id shipping_carrier pickup_code |
| `↳ recipient_address_info` | object |  |
| `↳↳ key` | string | queried field in recipient address |
| `↳↳ image` | string | base64 encoded png data string |
| `↳ shipping_document_info` | object |  |
| `↳↳ cod` | boolean | This value indicates whether the order was a COD (cash on delivery) order. |
| `↳↳ cod_amount` | string | Use this field to indicate cod amount. |
| `↳↳ order_weight` | int32 | Use this field to indicate order weight when calculate the shipping fee. The unit of weigh is gram. |
| `↳↳ logistics_channel_id` | int32 | The identity of logistic channel. |
| `↳↳ shipping_carrier` | string | The logistics service provider that the buyer selected for the order to deliver items. |
| `↳↳ service_code` | string | Only work for cross-border order. This code is required at some sorting hub. Please ensure the service_code is INCLUDED on your shipping label, otherwise the parcel cannot be processed by the warehouse. If you didn't retrieve service_code after you first called this API, please try few more times within 30 minutes. |
| `↳↳ first_mile_name` | string | Only work for cross-border order.The name of the carrier ships cross country or region. |
| `↳↳ last_mile_name` | string | Only work for cross-border order.The name of the carrier delivers the parcels in local country or region. |
| `↳↳ goods_to_declare` | boolean | Only work for cross-border order.This value indicates whether the order contains goods that are required to declare at customs. "T" means true and it will mark as "T" on the shipping label; "F" means false and it will mark as "P" on the shipping label. This value is accurate ONLY AFTER the order trackingNo is generated, please capture this value AFTER your retrieve the trackingNo. |
| `↳↳ lane_code` | string | Only work for cross-border order. The string use for waybill printing. The format is "S - region_code and lane_number". For example, S-TH01, S-TH02 |
| `↳↳ warehouse_address` | string | Only work for cross-border order in some special shop. The address info of the warehouse. |
| `↳↳ warehouse_id` | string | Only work for cross-border order in some special shop. The ID of the warehouse. |
| `↳↳ recipient_sort_code` | object | The sort_code of recipient. |
| `↳↳↳ first_recipient_sort_code` | string | The first-level sort_code of recipient. |
| `↳↳↳ second_recipient_sort_code` | string | The second-level sort_code of recipient. |
| `↳↳↳ third_recipient_sort_code` | string | The third-level sort_code of recipient. |
| `↳↳ sender_sort_code` | object | The sort_code of sender. |
| `↳↳↳ first_sender_sort_code` | string | The first-level sort_code of sender. |
| `↳↳↳ second_sender_sort_code` | string | The second-level sort_code of sender. |
| `↳↳↳ third_sender_sort_code` | string | The third-level sort_code of sender. |
| `↳↳ return_sort_code` | object | The sort code for 3PL doing RTS. |
| `↳↳↳ return_first_sort_code` | string | The first-level sort code for 3PL doing RTS. |
| `↳↳ third_party_logistic_info` | object | Only used for TW sellers. |
| `↳↳↳ service_description` | string | Use this field to indicate the order category. |
| `↳↳↳ barcode` | string | The manufacturer barcode. |
| `↳↳↳ purchase_time` | string | The purchase_time of the store. |
| `↳↳↳ return_time` | string | The return_time of the store. |
| `↳↳↳ manufacturers_name` | string | The name of manufacturers. |
| `↳↳↳ manufacturers_website` | string | The website of manufacturers. |
| `↳↳↳ recipient_area` | string | The identification of recipient area. |
| `↳↳↳ route_step` | string | The route code of the waybill. |
| `↳↳↳ suda5_code` | string | The tally code of the waybill. |
| `↳↳↳ large_logistics_id` | string | The code of large logistics. |
| `↳↳↳ parent_id` | string | The parent code of the waybill. |
| `↳↳↳ return_cycle` | string | Use this field to indicate the return cycle. |
| `↳↳↳ return_mode` | string | Use this field to indicate the return mode. |
| `↳↳↳ prompt` | string | The reminder of stork work. |
| `↳↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳↳ qrcode` | string | The QR code of the waybill. |
| `↳↳↳ ec_supplier_name` | string | The supplier name of channel. |
| `↳↳↳ ec_bar_code16` | string | Use this field to indicate the first barcode. |
| `↳↳↳ equipment_id` | string | The device code. |
| `↳↳↳ eshop_id` | string | The child code for B2C Family-mart. |
| `↳↳↳ ec_bar_code9` | string | Use this field to indicate the pick barcode. |
| `↳↳↳ pelican_tracking_no` | string | The tracking number of Shopee Delivery. |
| `↳↳↳ print_date` | string | The date of printing the wayBill. |
| `↳↳↳ pzip` | string | The sort code of the order. |
| `↳↳↳ pzip_c` | string | The barcode of the sort code. |
| `↳↳↳ deliver_area_txt` | string | The code of the delivery area. |
| `↳↳↳ deliver_date_ymd` | string | Expected delivery date of the order. |
| `↳↳↳ sd_driver_code` | string | Lorry driver code of the order. |
| `↳↳↳ md_driver_code` | string | Motorcycle driver code of the order. |
| `↳↳↳ putorder_stackzone_code` | string | Stacking area of the order. |
| `↳↳↳ customer_code` | string | The customer code of Shopee. |
| `↳↳↳ deliver_router` | string | Use this field to indicate the delivery router. |
| `↳↳↳ store_type` | string | Use this field to indicate the store type. |
| `↳↳↳ pick_router` | string | Use this field to indicate the pick router. |
| `↳↳↳ barcode_dc` | string | The main logistic barcode of the waybill. |
| `↳↳↳ ec_order_number` | string | Use this field to indicate the logistics order number. |
| `↳↳↳ barcode_pr` | string | The sorting barcode of the waybill. |
| `↳↳↳ first_pick_barcode` | string | The first pick barcode of the waybill. |
| `↳↳↳ second_pick_barcode` | string | The second pick barcode of the waybill. |
| `↳↳↳ is_cod_bool` | string | Use this field to indicate the service type. |
| `↳↳↳ receiver_name` | string | Use this field to indicate the receiver name. |
| `↳↳↳ rcv_store_name` | string | Use this field to indicate the receiver store name. |
| `↳↳↳ branch_code` | string | Use this field indicates destination service point code. |
| `↳↳↳ branch_name` | string | Use this field indicates destination service point name. |
| `↳↳↳ last_third_digits_recipient_phone` | string | Use this field indicates buyer phone number (last 3 digits). |
| `↳↳↳ last_third_digits_sender_phone` | string | Use this field indicates seller phone number (last 3 digits). |
| `↳↳↳ barcode_no1` | string | First barcode no. sacnned when seller drop off |
| `↳↳↳ barcode_no2` | string | Second barcode no. sacnned when seller drop off |
| `↳↳↳ print_datetime` | string | AWB Print date and time |
| `↳↳↳ ok_mid_type` | string | Middle type used in OK Mart SOC |
| `↳↳↳ ok_aisle_no` | string | Aisle no. used in OK Mart SOC |
| `↳↳↳ ok_grid_no` | string | Grid no used in OK Mart SOC |
| `↳↳↳ ok_tracking_number` | string | The tracking number of OK Mart. |
| `↳↳↳ barcode_no3` | string | OK SOC received no. |
| `↳↳↳ ship_type` | string | Ship type used by OK Mart |
| `↳↳↳ area` | string | The area of the collect OK branch used for OK sorting |
| `↳↳↳ barcode_no4` | string | First barcode no. sacnned when buyer collect |
| `↳↳↳ barcode_no5` | string | Second barcode no. sacnned when buyer collect |
| `↳↳↳ tw_last_three_digits_buyer_phone` | string | [Only for local TW orders] Last 3 digits of buyer's phone number, apply for channel_id: 30005, 30006, 30007,30014,30015 |
| `↳↳↳ tw_store_name` | string | [Only for TW channel_id:30005 ] Store name for 7-ELEVEN orders. |
| `↳↳↳ tw_store_number` | string | [Only for TW channel_id:30005 ]Store number for 7-ELEVEN orders. |
| `↳↳↳ buyer_prefer_delivery_time` | object | [Only for TW channel:30017] The time buyer prefers to receive the packages. |
| `↳↳↳↳ slot_id` | string | The slot which buyer choose |
| `↳↳↳↳ start_time` | string | The start time of a day buyer prefer to receive the packages |
| `↳↳↳↳ end_time` | string | The end time of a day buyer prefer to receive the packages. |
| `↳↳↳↳ description` | string | The detailed instructions of the package delivering. |
| `↳↳ tracking_number` | string | The tracking number assigned by the shipping carrier for item shipment. |
| `↳↳ shopee_tracking_number` | string | First mile tracking NO. for CrossBoard BR seller can be used to self-design CB Brazil AWB. |
| `↳↳ last_mile_tracking_number` | string | The last-mile tracking number. Only for Cross Board BR seller. |
| `↳↳ pickup_hub` | string | The name of pickup hub. |
| `↳↳ delivery_hub` | string | The name of delivery hub. |
| `↳↳ deliver_area` | string | Zone name. |
| `↳↳ ec_order_no` | string | The name of ec order. |
| `↳↳ create_date_ymd_sl` | string | The date of create shipment order. |
| `↳↳ manufacturers_name` | string | The name of manufacturer. |
| `↳↳ manufacturers_website` | string | The website of manufacturer. |
| `↳↳ is_lm_dg_bool` | int32 | Use this field to indicate order contains dangerous goods or not. 0: Non-dangerous good 1: Dangerous good 2: Prohibited |
| `↳↳ preferred_delivery_option` | int32 | Use this field to indicate delivery address is residential or office address. 0: not configured 1: office address 2: residential address |
| `↳↳ spx_sub_district` | string | The sub-district of recipient's address. |
| `↳↳ spx_receive_station` | object | The spx receive station. |
| `↳↳↳ spx_first_receive_station` | string | The first pickup station. |
| `↳↳ zone` | string | The zone of this order. |
| `↳↳ zone_code` | string | Delivery Sub Zone. |
| `↳↳ destination_base_code` | string | Distribution Center Code. |
| `↳↳ last_third_digits_buyer_phone` | string | Use this field indicates buyer phone number (last 3 digits). For non-TW local sellers |
| `↳↳ parcel_size` | string | corresponding locker sizing for self-collection locker channels [only available for specific logistic channels: 148003 and 140006] |
| `↳↳ sod` | boolean | this value indicates whether the buyer select "scan on delivery" payment channel at checkout. |
| `↳↳ buyer_cpf_id` | string | Buyer's CPF number for taxation and invoice purposes. Only for Brazil order. |
| `↳↳ mutual_check` | int32 | only apply for ID/VN shops. mutual_check indicates whether the parcel is eligible for Return-on-the-Spot (RoS) co-check. If mutual_check=1, then the parcel is RoS eligible, where drivers and buyers can co-check the parcel. Buyer can then choose to accept or reject the parcel on the spot. If mutual_check=0, then the parcel is ineligible for RoS. |
| `↳↳ dely_fri_label` | string | Probability of Successful Friday Delivery. The value of L(low), M(medium), H(high) represent the chances of successful delivery attempts on Friday. |
| `↳↳ dely_sat_label` | string | Probability of Successful Saturday Delivery The value of L(low), M(medium), H(high) represent the chances of successful delivery attempts on Saturday. |
| `↳↳ dely_sun_label` | string | Probability of Successful Sunday Delivery. The value of L(low), M(medium), H(high) represent the chances of successful delivery attempts on Sunday. |
| `↳↳ pickup_code` | string | For drivers to quickly identify parcel to be picked up. Only returned for ID and TH local orders which use instant+sameday for delivery. |
| `↳↳ sorting_group` | string | [Only for TW 30029 channel] This field indicate the sorting group value of the package. Available values: - North - South |
| `↳↳ unpackaged_sku_id` | string | [Only for TW 30029 channel] Please refer to this number instead of tracking number for this this channel. This field will be empty for other channels. |
| `↳↳ unpackaged_sku_id_qrcode` | string | [Only for TW 30029 channel] Please refer to this field to generate the QR code for the shipping document for this channel. This field will be empty for other channels. |
| `↳↳ high_value` | boolean | This value indicates whether the order is considered a “high value” item and requires special handling by the logistics provider. The threshold to be considered "high value" item differs by region, and is only applicable to SPX channels. For regions other than Malaysia and Thailand, this field will always return empty. |
| `↳↳ dg_specific_type` | int32 | Currently only applicable for Brazil, Indonesia, Vietnam, Philippines. For orders with Dangerous Goods, this value indicates the severity of the danger and requires special handling by the logistics provider. 0 = Not classified / no DG sub-type 1 = DG_A 2 = DG_B 3 = DG_C 4 = DG_D |
| `↳↳ hotspot_id` | string | This ID is used by 3PL to determine parcel routing. For regions other than Malaysia and Thailand, this field will always return empty. |
| `↳↳ weekend1_delivery_success_label` | string | This value indicates whether an order has a high / medium / low delivery success rate on each weekend (e.g. sat and sun respectively). For regions other than Malaysia, this field will always return empty. High = H Medium = M Low = L |
| `↳↳ weekend2_delivery_success_label` | string | This value indicates whether an order has a high / medium / low delivery success rate on each weekend (e.g. sat and sun respectively). For regions other than Malaysia, this field will always return empty. High = H Medium = M Low = L |

Lỗi riêng: Status verification failed, shipping documents of this package cannot be printed now. · The order is being allocated, please wait until the allocate is completed. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · Got an error when trying to generate image, please try again · You don’t ship order yet. · This order is matched order with booking, don't need arrange shipment through seller side. · You can not get order logistics of warehouse order. · The order status is invalid. Please check the order status. · The package is not exist. · This logistic channel/logistic type doesn’t support retrieving info from Open API. Please use v2.logistics.download_shipping_document API instead. · Not allowed to self design AWB · Please request with package_number for this split order. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment

## v2.logistics.get_tracking_info
`GET /api/v2/logistics/get_tracking_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Customer Service, Swam ERP

Use this api to get the logistics tracking information of an order.

Lịch sử cập nhật: 2026-05-29: Add collection_pin_code response parameter; 2026-04-24: Add return_code response parameter under tracking_info; 2025-08-14: Add reversed_tracking_number, reversed_courier_name and reversed_tracking_info response parameters; 2021-11-18: add logistics_status response parameters

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `package_number` | string |  | Shopee's unique identifier for the package under an order. You shouldn't fill the field with empty string when there is a package number. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳ logistics_status` | string | The logistics status for the order. Applicable values: See Data Definition- LogisticsStatus. |
| `↳ tracking_info` | object[] | The tracking info of the order. |
| `↳↳ update_time` | timestamp | The time when the logistics tracking info is updated. |
| `↳↳ description` | string | The description of the logistics tracking info. |
| `↳↳ logistics_status` | string | The logistics status for the order. Applicable values: See Data Definition- LogisticsStatus. |
| `↳↳ return_code` | string | The OTP generated after the parcel enters the RTS (Return to Seller) process. Sellers need to provide this OTP to the driver to complete the return confirmation. Note: - This field only applies to orders under the SPX Instant & Sameday channel in ID region. - This field is only returned when the driver has initiated the return process to the seller. If the driver has not initiated the return process for the parcel, this field will be empty. |
| `↳ collection_pin_code` | string | [TW Only] The unique 6-digit PIN code for sellers to collect RTS (Return to Seller) parcels at service points. This field is returned when the channel is C2C and the logistics_status is FULFILMENT_DELIVERY_FAILED. |
| `↳ reversed_tracking_number` | string | The tracking number of the reversed logistics. Note: Only apply to the cross-border segment of failed delivery parcels returned from the local return warehouse to the seller. |
| `↳ reversed_courier_name` | string | The courier name of the reversed logistics. Note: Only apply to the cross-border segment of failed delivery parcels returned from the local return warehouse to the seller. |
| `↳ reversed_tracking_info` | object[] | The tracking information of the reversed logistics. Note: Only apply to the cross-border segment of failed delivery parcels returned from the local return warehouse to the seller. |
| `↳↳ update_time` | int64 | The time when the reversed logistics tracking info is updated. |
| `↳↳ description` | string | The description of the reversed logistics tracking info. |

Lỗi riêng: The order is being allocated, please wait until the allocate is completed. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · The order is not exist. · The order status is invalid. Please check the order status. · The package is not exist. · Shop id is invalid. Please check your shop. · Please request with package_number for this split order. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · Inner http call failed · parse data failed · data not exist · parameter invalid

## v2.logistics.get_address_list
`GET /api/v2/logistics/get_address_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

For integrated logistics channel, use this call to get pickup address for pickup mode order.

Lịch sử cập nhật: 2026-03-27: Add INBOUND_PICKUP_ADDRESS option for address_type

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ show_pickup_address` | boolean | Show pickup address or not. |
| `↳ address_list` | object[] | The address list of you shop |
| `↳↳ address_id` | int64 | The identity of address. |
| `↳↳ region` | string | The region of specify address. |
| `↳↳ state` | string | The state of specify address. |
| `↳↳ city` | string | The city of specify address. |
| `↳↳ address` | string | The address description of specify address. |
| `↳↳ zipcode` | string | The zipcode of specify address. |
| `↳↳ district` | string | The district of specify address. |
| `↳↳ town` | string | The town of specify address. |
| `↳↳ address_type` | string[] | The flag of shop address.Available values: DEFAULT_ADDRESS, PICK_UP_ADDRESS, RETURN_ADDRESS, INBOUND_PICKUP_ADDRESS. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Shop id is invalid. Please check your shop. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.set_address_config
`POST /api/v2/logistics/set_address_config` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this API to set address config of your shop.

Lịch sử cập nhật: 2026-03-27: Add INBOUND_PICKUP_ADDRESS option for address_type

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `show_pickup_address` | boolean |  | Definite show pickup address or not. |
| `address_type_config` | object |  | The config of your shop addres. |
| `↳ address_id` | int64 |  | The identifier id of the address. |
| `↳ address_type` | string[] |  | The type of address. Available values: DEFAULT_ADDRESS, PICKUP_ADDRESS, RETURN_ADDRESS, INBOUND_PICKUP_ADDRESS. |

Lỗi riêng: Cannot set inbound pickup address for this address. · Inbound pickup address invalid state & city, state&city must be the same as kyc.billing_address state&city or fbs_branch.billing_address state&city. · Inbound pickup address cannot be the same as Shopee warehouse address. · BR pickup address SRN is invalid · BR pickup address SRN record not found · BR pickup address state does not match SRN · The address is invalid. Please check the address. · Fail to update address because fail to update the impacted channels. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · System error. Please try again later. · Address_type ({address_type}) is invalid. Please check the address_type. · Inner http call failed

## v2.logistics.update_address
`POST /api/v2/logistics/update_address` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

Use this API to update the address of a shop.

Lịch sử cập nhật: 2025-11-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `address_id` | int64 | ✔ | Unique identifier for the address. You can get the address_id via v2.logistics.get_address_list. |
| `region` | string |  | The region of the address. Note: Do not allow to update the region of the address. |
| `state` | string |  | The state of the address. |
| `city` | string |  | The city of the address. |
| `district` | string |  | The district of the address. |
| `town` | string |  | The town of the address. |
| `address` | string |  | The detailed address description of the address. |
| `zipcode` | string |  | The zipcode of the address. |
| `name` | string |  | Recipient’s name at this address. |
| `phone` | string |  | Contact phone number for the recipient. |
| `geo_info` | string |  | Geolocation information for the address. Type: JSON string Note: 1) To clear existing geo info, pass "" or {} . 2) To keep existing geo info, do not include this field . 3) The JSON may include optional fields: - formattedAddress (string): full formatted address. - region (object) – contains latitude and longitude as floats. - user_verified (boolean) – whether the geolocation is verified by the user. - user_adjusted (boolean) – whether the geolocation was adjusted by the user. |

Lỗi riêng: Cannot set inbound pickup address for this address. · Inbound pickup address invalid state & city, state&city must be the same as kyc.billing_address state&city or fbs_branch.billing_address state&city. · Inbound pickup address cannot be the same as Shopee warehouse address. · BR pickup address SRN is invalid · BR pickup address SRN record not found · BR pickup address state does not match SRN · The param is invalid. not allow to edit address region.

## v2.logistics.delete_address
`POST /api/v2/logistics/delete_address` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to delete address.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `address_id` | int | ✔ | The identity of address you want to delete. |

Lỗi riêng: Can't delete default address/pickup address/return address/inbound pickup address. · The address is invalid. Please check the address. · Sorry you can't delete the default address/pickup address/return address. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Get partner shop failed. · System error. Please try again later. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}.

## v2.logistics.get_channel_list
`GET /api/v2/logistics/get_channel_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Swam ERP

Use this api to get all supported logistic channels.

Lịch sử cập nhật: 2026-05-22: Add compulsory_channel and channel_relation_rules response parameters; 2026-04-09: Add auto_call_driver_setting & support_pause response parameters; 2025-12-26: Add service_type_identifier response parameter; 2025-09-08: add new response field "preprint"; 2023-12-15: add new response field "support_cross_border"

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ logistics_channel_list` | object[] | The list of logistics channel. |
| `↳↳ logistics_channel_id` | int64 | The identity of logistic channel. |
| `↳↳ logistics_channel_name` | string | The name of logistic channel. |
| `↳↳ cod_enabled` | boolean | This is to indicate whether this logistic channel supports COD |
| `↳↳ enabled` | boolean | Whether this logistic channel is enabled on shop level. |
| `↳↳ fee_type` | string | SIZE_SELECTION SIZE_INPUT FIXED_DEFAULT_PRICE CUSTOM_PRICE |
| `↳↳ size_list` | object[] | Only for fee_type is SIZE_SELECTION |
| `↳↳↳ size_id` | string | The identity of size. |
| `↳↳↳ name` | string | The name of size. |
| `↳↳↳ default_price` | float | The pre-defined shipping fee for the specific size. |
| `↳↳ weight_limit` | object | The weight limit for this logistic channel. |
| `↳↳↳ item_max_weight` | float | The max weight for an item on this logistic channel.If the value is 0 or null, that means there is no limit. |
| `↳↳↳ item_min_weight` | float | The min weight for an item on this logistic channel. If the value is 0 or null, that means there is no limit. |
| `↳↳ item_max_dimension` | object | The dimension limit for this logistic channel. |
| `↳↳↳ height` | float | The max height limit. |
| `↳↳↳ width` | float | The max width limit. |
| `↳↳↳ length` | float | The max length limit. |
| `↳↳↳ unit` | string | The unit for the limit. |
| `↳↳↳ dimension_sum` | float | The sum of the item's dimension |
| `↳↳ volume_limit` | object | The limit of item volume. |
| `↳↳↳ item_max_volume` | float | The max volume for an item on this logistic channel.If the value is 0 or null, that means there is no limit for the item weight. |
| `↳↳↳ item_min_volume` | float | The min volume for an item on this logistic channel. If the value is 0 or null, that means there is no limit for the item weight. |
| `↳↳ logistics_description` | string | For checkout channels, this field indicates its corresponding fulfillment channels. |
| `↳↳ force_enable` | boolean | Indicates whether the logistic channel is force enabled on Shop Level. If true, sellers cannot close this channel. |
| `↳↳ mask_channel_id` | int64 | Indicate the parent logistic channel ID. If it’s 0, it indicates the channel is a checkout(masked) channel; if it’s not 0, indicate the channel is a fulfillment channel and has a checkout channel(checkout channel’s channel_id equals this mask_channel_id) on top of it. Multiple channels may share the same mask_channel_id. |
| `↳↳ block_seller_cover_shipping_fee` | boolean | Indicate whether the channel is blocked to use seller cover shipping fee function. if the channel does not allow sellers to cover shipping fee, then the block_seller_cover_shipping_fee field will return true, otherwise it will return false. |
| `↳↳ support_cross_border` | boolean | Indicate whether this channel support cross border shipping. |
| `↳↳ seller_logistic_has_configuration` | boolean | Indicate If seller has set the Seller logistics configuration if set will return true, otherwise it will return false or null. |
| `↳↳ logistics_capability` | object | The capability of one logistic channel. |
| `↳↳↳ seller_logistics` | boolean | Indicate If it's a Seller logistics channel, if it's a Seller logistics channel will return true, otherwise it will return false. |
| `↳↳ preprint` | boolean | Indicate whether this channel support pre-print AWB |
| `↳↳ service_type_identifier` | string | This parameter specifies the delivery service type of logistics channel. Applicable values: - instant - same_day - null |
| `↳↳ auto_call_driver_setting` | object |  |
| `↳↳↳ auto_call_driver_eligible` | boolean | Indicate whether this channel is eligible for Auto Call Driver. |
| `↳↳↳ auto_call_driver_enabled` | boolean | Indicate whether Auto Call Driver is currently enabled for this channel |
| `↳↳↳ preparation_time` | int32 | The current valid preparation time for this channel, in minutes. |
| `↳↳↳ preparation_time_limit` | object | The preparation time range allowed for this channel. Note: When calling v2.logistics.update_channel to set the Preparation Time for the channel, the time must not exceed this range. |
| `↳↳↳↳ min_preparation_time` | int32 | The minimum allowable preparation time, in minutes. |
| `↳↳↳↳ max_preparation_time` | int32 | The maximum allowable preparation time, in minutes. |
| `↳↳ support_pause` | boolean | Indicates whether this channel supports the pause operation (Pausing allows the shop to temporarily prevent buyers from placing orders through this logistics channel). - true: This channel is affected by the pause function. - false: This channel is not affected by the pause function. Note: Please first call v2.logistics.get_pause_status to get the current pause status of logistics channels under the shop. If is_paused = true, then call v2.logistics.get_channel_list and identify the range of channels affected by the pause function through support_pause = true. |
| `↳↳ compulsory_channel` | boolean | Indicates if the channel is compulsory. If the value is true, at least one such channel must be enabled. |
| `↳↳ channel_relation_rules` | object[] | Indicate the related rules & channels of this logistic channel. |
| `↳↳↳ related_enabled_channels` | int64[] | Channels that will be auto-enabled in the same request if this channel is enabled. |
| `↳↳↳ related_dependent_block_channels` | int64[] | Channels that must be disabled before or while disabling this parent channel. |

Lỗi riêng: Shipping options of Direct Shop will follow Local Shop. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Shop id is invalid. Please check your shop. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.update_channel
`POST /api/v2/logistics/update_channel` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to update shop level logistics channel's configuration.

Lịch sử cập nhật: 2026-04-09: Add auto_call_driver_setting request and response parameters; 2023-09-27: sunset the request parameters "preferred" since "Preferred channel setting is no longer supported".

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `logistics_channel_id` | int64 | ✔ | The identity of logistic channel. |
| `enabled` | boolean |  | Whether to enable this logistic channel. |
| `cod_enabled` | boolean |  | Whether to enable COD for this logistic channel. Only COD supported channels are applicable. |
| `auto_call_driver_setting` | object |  |  |
| `↳ auto_call_driver_enabled` | boolean |  | Whether to enable Auto Call Driver for this logistic channel. |
| `↳ preparation_time` | int32 |  | Used to set the Preparation Time for this channel, in minutes. Required when auto_call_driver_enabled = true. Note: Please ensure the passed preparation_time value falls within the preparation_time_limit range returned by v2.logistics.get_channel_list. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ shop_id` | int64 | Shopee's unique identifier for a shop. |
| `↳ enabled` | boolean | Whether this logistic channel is enabled. |
| `↳ cod_enabled` | boolean | Whether COD is enabled for this channel. |
| `↳ logistics_channel_id` | int64 | The identity of logistic channel. |
| `↳ updated_channels` | object[] | List of channels that are updated in the operation (inclusive of dependent logistics channels) |
| `↳↳ channel_id` | int64 | Logistics channel ID |
| `↳↳ channel_display_name` | string | Logistics channel name |
| `↳↳ unsupport_warehouse` | object[] | List details of unsupported warehouses |
| `↳↳↳ warehouse_id` | int64 | Unsupported warehouse ID |
| `↳↳↳ warehouse_name` | string | Unsupported warehouse name |
| `↳ is_multi_warehouse` | boolean |  |
| `↳ auto_call_driver_setting` | object |  |
| `↳↳ auto_call_driver_enabled` | boolean | Indicate whether Auto Call Driver is currently enabled for this channel. |
| `↳↳ preparation_time` | int32 | The current valid preparation time for this channel, in minutes. |

Lỗi riêng: Seller or Channel does not support Auto-Call. · Invalid Auto-Call setting param. · Invalid Seller preparation time. · Shipping options of Direct Shop will follow Local Shop. · Channel is invalid. Please check the channel id. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · channel is not allow to disable due to there is item in the bundle · Invalid logistics_channel_id. Please check the logistics_channel_id. · no supported warehouse address · This channel is now related to SPX Hemat channel (80029), to enable or disable it please update SPX Hemat channel instead · {parent_channel} cannot be modified. Please enable at least 1 of the following channel(s) first: {seller channel name list} · {parent_channel} cannot be turned off due to dependent block rule. Please disable all the following channel(s) before proceed: {seller channel name list}

## v2.logistics.get_operating_hours
`GET /api/v2/logistics/get_operating_hours` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

This API is utilized to retrieve the existing operating hours of sellers including Pickup Operating Hours, Special Hours, Instant Operating Hours, and Shop Collection Operating Hours.

Lịch sử cập nhật: 2026-10-30: Add instant_order_cutoff_time_buffer_list; 2025-09-18: Add shop_collection_operating_hour response fields; 2025-03-06: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `repsonse` | object |  |
| `↳ regular_operating_hour` | object | The details of Pickup Operating Hours/Preferred Pickup Hours |
| `↳↳ monday` | object | The Operating hours for Monday |
| `↳↳↳ start_time` | string | Start time for Monday |
| `↳↳↳ end_time` | string | End time for Monday |
| `↳↳ tuesday` | object | The Operating hours for Tuesday |
| `↳↳↳ start_time` | string | Start time for Tuesday |
| `↳↳↳ end_time` | string | End time for Tuesday |
| `↳↳ wednesday` | object | The Operating hours for Wednesday |
| `↳↳↳ start_time` | string | Start time for Wednesday |
| `↳↳↳ end_time` | string | End time for Wednesday |
| `↳↳ thursday` | object | The Operating hours for Thursday |
| `↳↳↳ start_time` | string | Start time for Thursday |
| `↳↳↳ end_time` | string | End time for Thursday |
| `↳↳ friday` | object | The Operating hours for Friday |
| `↳↳↳ start_time` | string | Start time for Friday |
| `↳↳↳ end_time` | string | End time for Friday |
| `↳↳ saturday` | object | The Operating hours for Saturday |
| `↳↳↳ start_time` | string | Start time for Saturday |
| `↳↳↳ end_time` | string | End time for Saturday |
| `↳↳ sunday` | object | The Operating hours for Sunday |
| `↳↳↳ start_time` | string | Start time for Sunday |
| `↳↳↳ end_time` | string | End time for Sunday |
| `↳↳ public_holiday` | object | The Operating hours for Public Holiday |
| `↳↳↳ start_time` | string | Start time for Public Holiday |
| `↳↳↳ end_time` | string | End time for Public Holiday |
| `↳ instant_operating_hour` | object | The details of Instant Operating Hours |
| `↳↳ monday` | object | The Operating hours for Monday |
| `↳↳↳ start_time` | string | Start time for Monday |
| `↳↳↳ end_time` | string | End time for Monday |
| `↳↳ tuesday` | object | The Operating hours for Tuesday |
| `↳↳↳ start_time` | string | Start time for Tuesday |
| `↳↳↳ end_time` | string | End time for Tuesday |
| `↳↳ wednesday` | object | The Operating hours for Wednesday |
| `↳↳↳ start_time` | string | Start time for Wednesday |
| `↳↳↳ end_time` | string | End time for Wednesday |
| `↳↳ thursday` | object | The Operating hours for Thursday |
| `↳↳↳ start_time` | string | Start time for Thursday |
| `↳↳↳ end_time` | string | End time for Thursday |
| `↳↳ friday` | object | The Operating hours for Friday |
| `↳↳↳ start_time` | string | Start time for Friday |
| `↳↳↳ end_time` | string | End time for Friday |
| `↳↳ saturday` | object | The Operating hours for Saturday |
| `↳↳↳ start_time` | string | Start time for Saturday |
| `↳↳↳ end_time` | string | End time for Saturday |
| `↳↳ sunday` | object | The Operating hours for Sunday |
| `↳↳↳ start_time` | string | Start time for Sunday |
| `↳↳↳ end_time` | string | End time for Sunday |
| `↳↳ public_holiday` | object | The Operating hours for Public Holiday |
| `↳↳↳ start_time` | string | Start time for Public Holiday |
| `↳↳↳ end_time` | string | End time for Public Holiday |
| `↳ special_operating_hour` | object | The details of Special Operating Hours <path></path> |
| `↳↳ name` | string | The name of Special Operating Hours |
| `↳↳ start_date` | string | The start date of special operating hours |
| `↳↳ end_date` | string | The end date of special operating hours |
| `↳↳ operating_hours` | object[] |  |
| `↳↳↳ date` | string | Date: it should include all date from start_date until end_date |
| `↳↳↳ start_time` | string | Start time for that date <path></path> |
| `↳↳↳ end_time` | string | End time for that date |
| `↳↳↳ enable` | boolean | True: If it is open on that date. False: If it is closed on that date. |
| `↳ shop_collection_operating_hour` | object | The details of Shop Collection Operating Hours |
| `↳↳ monday` | object | The Operating hours for Monday |
| `↳↳↳ start_time` | string | Start time for Monday |
| `↳↳↳ end_time` | string | End time for Monday |
| `↳↳ tuesday` | object | The Operating hours for Tuesday |
| `↳↳↳ start_time` | string | Start time for Tuesday |
| `↳↳↳ end_time` | string | End time for Tuesday |
| `↳↳ wednesday` | object | The Operating hours for Wednesday |
| `↳↳↳ start_time` | string | Start time for Wednesday |
| `↳↳↳ end_time` | string | End time for Wednesday |
| `↳↳ thursday` | object | The Operating hours for Thursday |
| `↳↳↳ start_time` | string | Start time for Thursday |
| `↳↳↳ end_time` | string | End time for Thursday |
| `↳↳ friday` | object | The Operating hours for Friday |
| `↳↳↳ start_time` | string | Start time for Friday |
| `↳↳↳ end_time` | string | End time for Friday |
| `↳↳ saturday` | object | The Operating hours for Saturday |
| `↳↳↳ start_time` | string | Start time for Saturday |
| `↳↳↳ end_time` | string | End time for Saturday |
| `↳↳ sunday` | object | The Operating hours for Sunday |
| `↳↳↳ start_time` | string | Start time for Sunday |
| `↳↳↳ end_time` | string | End time for Sunday |
| `↳↳ public_holiday` | object | The Operating hours for Public Holiday |
| `↳↳↳ start_time` | string | Start time for Public Holiday |
| `↳↳↳ end_time` | string | End time for Public Holiday |
| `↳ instant_order_cutoff_time_buffer_list` | object[] |  |
| `↳↳ id` | string | Unique identifier for a buffer group. |
| `↳↳ display_name` | string | Display name for a buffer group. |
| `↳↳ buffer` | int64 | Cutoff time, in minutes before the end of the shop's instant operating hour, after which new orders are no longer fulfilled on the same day for the given buffer group. |

Lỗi riêng: Sorry you don't have the permission, detail: This shop isn't eligible to set up Regular Operating Hours. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.get_operating_hour_restrictions
`GET /api/v2/logistics/get_operating_hour_restrictions` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

This API is designed to retrieve all restrictions related to inputting operating hours for the v2.logistics.update_operating_hours function. This API ensures that user are aware of any limitations or conditions that may affect their operating hours.

Lịch sử cập nhật: 2025-09-18: Add shop_collection_operating_hour_restrictions response fields; 2025-03-06: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ regular_operating_hour_restrictions` | object | The restrictions for Pickup Operating Hours / Preferred Pickup Hours |
| `↳↳ minimum_working_days_in_week` | int64 | Minimum number of days the seller needs to designate as working days per week (including Monday to Sunday, but excluding public holidays from the count). |
| `↳↳ working_day_config` | object | The restrictions specific to each day |
| `↳↳↳ monday` | object | The restrictions specific for Monday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ tuesday` | object | The restrictions specific for Tuesday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ wednesday` | object | The restrictions specific for Wednesday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ thursday` | object | The restrictions specific for Thursday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ friday` | object | The restrictions specific for Friday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ saturday` | object | The restrictions specific for Saturday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ sunday` | object | The restrictions specific for Sunday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ public_holiday` | object | The restrictions specific for public holiday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳ instant_operating_hour_restrictions` | object | The restrictions for Instant Operating Hours |
| `↳↳ minimum_working_days_in_week` | int64 | Minimum number of days the seller needs to designate as working days per week (including Monday to Sunday, but excluding public holidays from the count). |
| `↳↳ working_day_config` | object | The restrictions specific to each day |
| `↳↳↳ monday` | object | The restrictions specific for Monday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ tuesday` | object | The restrictions specific for Tuesday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ wednesday` | object | The restrictions specific for Wednesday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ thursday` | object | The restrictions specific for Thursday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ friday` | object | The restrictions specific for Friday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ saturday` | object | The restrictions specific for Saturday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ sunday` | object | The restrictions specific for Sunday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ public_holiday` | object | The restrictions specific for public holiday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳ special_operating_hour_restrictions` | object | The restrictions for Special Operating Hours |
| `↳↳ special_day` | object |  |
| `↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳ shop_collection_operating_hour_restrictions` | object | The restrictions for Shop Collection Operating Hours |
| `↳↳ minimum_working_days_in_week` | int64 | Minimum number of days the seller needs to designate as working days per week (including Monday to Sunday, but excluding public holidays from the count). |
| `↳↳ working_day_config` | object | The restrictions specific to each day |
| `↳↳↳ monday` | object | The restrictions specific for Monday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ tuesday` | object | The restrictions specific for Tuesday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | string | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ wednesday` | object | The restrictions specific for Wednesday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ thursday` | object | The restrictions specific for Thursday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ friday` | object | The restrictions specific for Friday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ saturday` | object | The restrictions specific for Saturday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ sunday` | object | The restrictions specific for Sunday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |
| `↳↳↳ public_holiday` | object | The restrictions specific for Public Holiday |
| `↳↳↳↳ mandatory` | boolean | If the value is true, this day must be marked as open. |
| `↳↳↳↳ minimum_operating_hour` | int64 | Minimum number of hours required for the seller to operate on that day. |
| `↳↳↳↳ minimum_start_time` | string | The start hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_start_time` | string | The start hour for that day should not be set later than this time. |
| `↳↳↳↳ minimum_end_time` | string | The end hour for that day should not be set earlier than this time. |
| `↳↳↳↳ maximum_end_time` | string | The end hour for that day should not be set later than this time. |
| `↳↳↳↳ operating_24_hour_toggle` | boolean | If the toggle value is true, the user can set the start_time to 00:00 and the end_time to 23:59 to indicate that the shop is operating 24 hours a day. |

Lỗi riêng: Sorry you don't have the permission, detail: This shop isn't eligible to set up Regular Operating Hours. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.update_operating_hours
`POST /api/v2/logistics/update_operating_hours` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

This API is designed to allow sellers to update their operating hours. It is essential that the values provided in this API align with the restrictions retrieved from the v2.logistics.get_operating_hour_restrictions API to ensure compliance with platform requirements. This API uses overwriting updates, when updating pickup operating hours, still need to include all parts even those not needing changes.

Lịch sử cập nhật: 2025-12-09: Update description of end_time to support 24-hour case; 2025-09-18: Add shop_collection_operating_hour request and response fields; 2025-03-06: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `regular_operating_hour` | object |  | Details of Pickup Operating Hours / Preferred Pickup Hours: You can skip this parameter if you are not updating the Pickup Operating Hours / Preferred Pickup Hours |
| `↳ monday` | object |  | Operating hours for Monday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ tuesday` | object |  | Operating hours for Tuesday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ wednesday` | object |  | Operating hours for Wednesday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ thursday` | object |  | Operating hours for Thursday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ friday` | object |  | Operating hours for Friday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ saturday` | object |  | Operating hours for Saturday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ sunday` | object |  | Operating hours for Sunday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ public_holiday` | object |  | Operating hours for public holiday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `special_operating_hour` | object |  | Details of Special Operating Hours : You can skip this parameter if you are not creating Special Operating Hours or if you do not have access to create Special Operating Hours |
| `↳ name` | string | ✔ | The name of Special Operating Hours |
| `↳ start_date` | string | ✔ | The start date of the Special Operating Hours. The value should be within [today + 1] and [today + 365 days]. |
| `↳ end_date` | string | ✔ | The end date of the Special Operating Hours. The value should be within [start_date + 30 days] |
| `↳ operating_hours` | object[] | ✔ | To specify the operating hours for each date |
| `↳↳ date` | string | ✔ | Date: it should be include all date from start_date until end_date |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that date: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳↳ enable` | boolean | ✔ | To specify this value as False if you're not operate on that date (close) |
| `instant_operating_hour` | object |  | Details of Instant Operating Hours : You can skip this parameter if you are not creating/updating Instant Operating Hours or if you do not have access to create/update Instant Operating Hours |
| `↳ monday` | object |  | Operating hours for Monday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ tuesday` | object |  | Operating hours for Tuesday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ wednesday` | object |  | Operating hours for Wednesday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ thrusday` | object |  | Operating hours for Thursday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ friday` | object |  | Operating hours for Friday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ saturday` | object |  | Operating hours for Saturday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ sunday` | object |  | Operating hours for Sunday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ public_holiday` | object |  | Operating hours for public holiday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `shop_collection_operating_hour` | object |  | Details of Shop Collection Operating Hours : You can skip this parameter if you are not creating/updating Shop Collection Operating Hours or if you do not have access to create/update Shop Collection Operating Hours |
| `↳ monday` | object |  | Operating hours for Monday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ tuesday` | object |  | Operating hours for Tuesday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ wednesday` | object |  | Operating hours for Wednesday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ thursday` | object |  | Operating hours for Thursday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ friday` | object |  | Operating hours for Friday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ saturday` | object |  | Operating hours for Saturday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ sunday` | object |  | Operating hours for Sunday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |
| `↳ public_holiday` | object |  | Operating hours for Public Holiday: You can skip this information if you want to mark the day as closed. |
| `↳↳ start_time` | string | ✔ | Start time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. |
| `↳↳ end_time` | string | ✔ | End time for operating hours on that day: The time should be in the format XX:YY, where YY is either 00 or 30. Except for a 24-hour, you can input a start_time of 00:00 and an end_time of 23:59 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ result_list` | object |  |
| `↳↳ regular_operating_hour` | object | The result of create/update regular_operating_hour. |
| `↳↳↳ status` | string | The system will return "Failed" if there are any validation errors. Otherwise, it will return a blank response. |
| `↳↳↳ fail_message` | string | Fail reason |
| `↳↳ special_operating_hour` | object | The result of create/update speicial_operating_hour. |
| `↳↳↳ status` | string | The system will return "Failed" if there are any validation errors. Otherwise, it will return a blank response. |
| `↳↳↳ fail_message` | string | Fail reason |
| `↳↳ instant_operating_hour` | object | The result of create/update instant_operating_hour. |
| `↳↳↳ status` | string | The system will return "Failed" if there are any validation errors. Otherwise, it will return a blank response. |
| `↳↳↳ fail_message` | string | Fail reason |
| `↳↳ shop_collection_operating_hour` | object | The result of create/update shop_collection_operating_hour. |
| `↳↳↳ status` | string | The system will return "Failed" if there are any validation errors. Otherwise, it will return a blank response. |
| `↳↳↳ fail_message` | string | Fail reason |

Lỗi riêng: Sorry you don't have the permission, detail: This shop isn't eligible to set up Instant Operating Hours. · Sorry you don't have the permission, detail: This shop isn't eligible to set up Regular Operating Hours. · Sorry you don't have the permission, detail: This shop isn't eligible to set up Special Operating Hours. · All modifications to the operating hours were unsuccessful. Please check the result_list and try again. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.delete_special_operating_hour
`POST /api/v2/logistics/delete_special_operating_hour` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

This API is used to delete a specific special operating hour for a seller. This API allows sellers to manage their operating hours by removing any special operating hours that are no longer needed. To use this API, the name of the special operating hour to be deleted should be obtained from the v2.logistics.get_operating_hours API.

Lịch sử cập nhật: 2025-03-06: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `name` | string | ✔ | Name of the special operating hour which can be retrieved from v2.logistics.get_operating_hours |

Lỗi riêng: Sorry you don't have the permission, detail: This shop isn't eligible to set up Regular Operating Hours. · Special Operating Hours not found for this shop. · Sorry you don't have the permission, detail: This shop isn't eligible to set up Special Operating Hours. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.batch_update_tpf_warehouse_tracking_status
`POST /api/v2/logistics/batch_update_tpf_warehouse_tracking_status` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

For CB orders that fulfilled by 3PF, support 3PF Warehouse Vendors to update the tpf_tracking_status when 3PF warehouse receive the order and complete the outbound of the package. CB orders that fulfilled by 3PF： v2.shop.get_shop_info - shop_fulfillment_flag in {Pure - 3PF Shop,PFF - 3PF Shop,LFF Hybrid Shop} And v2.order.get_order_detail - fulfillment_flag = fulfilled_by_local_seller

Lịch sử cập nhật: 2025-04-08: Supplemented the technical interface identification method of CB orders that fulfilled by 3PF Supplemented tpf_name Description; 2025-03-28: Change object[] to object; 2025-01-13: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `tpf_name` | string | ✔ | The name of 3PF Warehouse Vendor. Prohibit pure numbers and excessive abbreviations. Standardize naming for easy business recognition. Input priority: warehouse English name > full pinyin of warehouse brand name > warehouse Chinese name > other officially recognized and prominent names. |
| `tpf_tracking_status` | string | ✔ | The 3PF tracking status for the timestamp. All statuses are in lower case. List of status: - 3pf_warehouse_order_created - 3pf_warehouse_outbound_done |
| `package_list` | object[] | ✔ |  |
| `↳ order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `↳ package_number` | string |  | Shopee's unique identifier for the package under an order. |
| `↳ update_time` | int64 | ✔ | This is to indicate timestamp of the 3PF tracking status. Timestamp should be within order create time and order pick up by 3PL time. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ success_list` | object[] | Update success order list. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳ fail_list` | object[] | Update fail order list. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ fail_error` | string | Reason for failure. |
| `↳↳ fail_message` | string | Reason for failure. |

Lỗi riêng: Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.batch_ship_order
`POST /api/v2/logistics/batch_ship_order` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to batch initiate logistics including arrange pickup, dropoff or shipment for non-integrated logistic channels. Should call v2.logistics.get_shipping_parameter to fetch all required param first. It's recommended to initiate logistics one hour after the orders were placed since there is one-hour window buyer can cancel any order without request to seller.Only channel 90003 - Padrão in Brazil has the permission of this API.

Lịch sử cập nhật: 2022-02-23: update define for this API; 2021-09-07: Update the order_list limit; 2021-03-29: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_list` | object[] | ✔ | The list of order. |
| `↳ order_sn` | string | ✔ | Shopee's unique identifier for an order. Limit 150. |
| `↳ package_number` | string |  | Shopee's unique identifier for the package under an order. You should't fill the field with empty string when there is't a package number. |
| `pickup` | object |  | Required parameter ONLY if GetParameterForInit returns "pickup" or if GetLogisticsInfo returns "pickup" under "info_needed" for the same order. Developer should still include "pickup" field in the call even if "pickup" has empty value. |
| `↳ address_id` | int |  | The identity of address. Retrieved from shopee.logistics.GetAddress. |
| `↳ pickup_time_id` | string |  | The pickup time id. Retrieved from shopee.logistics.GetTimeSlot. |
| `↳ tracking_number` | string |  | Need input this field when "tracking_number" is returned from "info_need". Please note that this tracking number is assigned by third-party shipping carrier for item shipment. |
| `dropoff` | object |  | Required parameter ONLY if GetParameterForInit returns "dropoff" or if GetLogisticsInfo returns "dropoff" under "info_needed" for the same order. Developer should still include "dropoff" field in the call even if "dropoff" has empty value. For logistic_id 80003 and 80004, both Regular and JOB shipping methods are supported. If you choose Regular shipping method, please use "tracking_no" to call Init API. If you choose JOB shipping method, please use "sender_real_name" to call Init API. Note that only one of "tracking_no" and "sender_real_name" can be selected. |
| `↳ branch_id` | int |  | The identity of branch. Retrieved from shopee.logistics.GetBranch branch. |
| `↳ sender_real_name` | string |  | The real name of sender. |
| `↳ tracking_number` | string |  | Need input this field when "tracking_number" is returned from "info_need". Please note that this tracking number is assigned by third-party shipping carrier for item shipment. |
| `non_integrated` | object |  | Optional parameter when GetParameterForInit returns "non-integrated" or GetLogisticsInfo returns "non-integrated" under "info_needed". |
| `↳ tracking_number` | string |  | Optional parameter for non-integrated channel order. The tracking number assigned by the shipping carrier for item shipment. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ result_list` | object[] |  |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: The order is being allocated, please wait until the allocate is completed. · Failed, please check result_list for more details. · Fail to find the fulfillment channel of this order. · You have not set warehouse. · Wrong parameters, detail: {msg}. · System error. Please try again later. · Pending invoice data, can not arrange shipment. · Please upload the invoice or verify the details of the document already submitted, which is currently flagged as invalid by SEFAZ. Correction is required to release the shipment. · This order hasn't passed prescription check · The package is not exist. · Buyer's delivery address is not serviceable. Please contact customer service. · Buyer's delivery address is not serviceable. Please contact customer service. · Channel does not support dropoff. Please select the pickup option and try again. · Please input a unique tracking number. · Please input a unique tracking number.

## v2.logistics.update_tracking_status
`POST /api/v2/logistics/update_tracking_status` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Only available for Brazil sellers. This API is only available for orders/parcels which are fulfilled by BR Seller Logistics channel (logistics_channel_id: 90021), Samsung (logistics_channel_id: 90025) and BR Instant Delivery channel (logistics_channel_id: 90026). The logistics_status will become LOGISTICS_REQUEST_CREATED after arrange shipment, and can call this API to update to: LOGISTICS_PICKUP_DONE, LOGISTICS_DELIVERY_DONE, LOGISTICS_DELIVERY_FAILED.

Lịch sử cập nhật: 2025-12-03: Remove opt_code and support 90025 channel; 2025-09-18: Add "otp_code" & "failed_reason" request parameters and support BR Instant Delivery channel (logistics_channel_id: 90026); 2024-04-28: update the API description; 2024-04-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `tracking_number` | string |  | Order tracking number, might help seller to identify his order on the tracking_URL. Can only be sent when updating logistics_status to "logistic_pickup_done". |
| `tracking_url` | string |  | Website's URL for order tracking with maximum length of 2048 characters. Can only be sent when updating logistics_status to "logistic_pickup_done". |
| `logistics_status` | string | ✔ | Order status update support: - logistics_pickup_done - logistics_delivery_done - logistics_delivery_failed |
| `failed_reason` | string |  | Only required when updating logistics_status to "logistics_delivery_failed". Only required for BR Instant Delivery channel (logistics_channel_id: 90026). Only accept the following values. - buyer_unreachable - buyer_unresponsive - no_delivery_location_consensus |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Response body |
| `↳ update_result` | string | Update results: - succeed - failed |

Lỗi riêng: The order_sn {order_sn} is not exist. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.get_booking_shipping_parameter
`GET /api/v2/logistics/get_booking_shipping_parameter` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get the parameter "info_needed" from the response to check if the booking has pickup or dropoff. This api will also return the addresses and pickup time id options for the pickup method. For dropoff, it can return branch id, sender real name etc, depending on the 3PL requirements.

Lịch sử cập nhật: 2025-03-24: Add “flags” response parameter under time_slot_list; 2024-07-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `booking_sn` | string | ✔ | Shopee's unique identifier for a booking. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail information you are querying. |
| `↳ info_needed` | object | The parameters required based on each specific booking to Init. Must use the fields included under info_needed to call Init. |
| `↳↳ dropoff` | string[] | Could contain 'branch_id', 'sender_real_name' or 'tracking_no'. If it contains 'branch_id', choose one to Init. If it contains 'sender_real_name' or 'tracking_no', should manually input these values in Init API. If it has empty value, developer should still include "dropoff" field in Init API. |
| `↳↳ pickup` | string[] | Could contain 'address_id' and 'pickup_time_id'. Choose one address_id and its corresponding pickup_time_id to Init. If it has empty value, developer should still include "pickup" field in Init API.It could contains "tracking_number" returned from "info_need"for some channels, please also add it when init. |
| `↳ pickup` | object | Logistics information for pickup mode booking. |
| `↳↳ address_list` | object[] | List of available pickup address info. |
| `↳↳↳ address_id` | int64 | The identity of address. |
| `↳↳↳ region` | string | The region of specify address. |
| `↳↳↳ state` | string | The state of specify address. |
| `↳↳↳ city` | string | The city of specify address. |
| `↳↳↳ district` | string | The district of specify address. |
| `↳↳↳ town` | string | The town of specify address. |
| `↳↳↳ address` | string | The address description of specify address. |
| `↳↳↳ zipcode` | string | The zipcode of specify address. |
| `↳↳↳ address_flag` | string[] | The flag of shop address, applicable values: default_address, pickup_address, return_address, current_address(only for multi-warehouse sellers) |
| `↳↳↳ time_slot_list` | object[] | List of pickup_time information corresponding to the address_id. Some logistics channels may not return any date or time for pickup time slots. In such cases, sellers can arrange shipment without selecting any time slot, and Shopee will arrange a suitable timing for these situations. |
| `↳↳↳↳ date` | timestamp | The date of pickup time. In timestamp. |
| `↳↳↳↳ time_text` | string | The text description of pickup time. Only applicable for certain channels. |
| `↳↳↳↳ pickup_time_id` | string | The identity of pickuptime. |
| `↳↳↳↳ flags` | string[] | This field will have the value “recommended” for the time slot that Shopee suggests sellers choose. While it is advisable for sellers to choose the recommended time slot, they can also choose other time slots that do not have the recommended flag. |
| `↳↳↳↳ error` | string | return if error getting pickup time, otherwise omitted |
| `↳↳↳↳ msg` | string | return if error getting pickup time, otherwise omitted |

Lỗi riêng: Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Pickup address does not match product location. Please check warehouse configuration

## v2.logistics.ship_booking
`POST /api/v2/logistics/ship_booking` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to initiate logistics including arrange pickup, dropoff. Should call v2.logistics.get_booking_shipping_parameter to fetch all required param first.

Lịch sử cập nhật: 2024-07-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `booking_sn` | string | ✔ | Shopee's unique identifier for a booking. |
| `pickup` | object |  | Required parameter ONLY if get_shipping_parameter returns "pickup" under "info_needed". Developer should still include "pickup" field in the call even if "pickup" has empty value. |
| `↳ address_id` | int64 | ✔ | The identity of address. Retrieved from v2.logistics.get_booking_shipping_parameter. |
| `↳ pickup_time_id` | string |  | The pickup time id. Retrieved from v2.logistics.get_shipping_booking_parameter, you can only select one from the time_slot_list. Some logistics channels may not return any date or time for pickup time slots. In such cases, sellers can arrange shipment without selecting any time slot, and Shopee will arrange a suitable timing for these situations. |
| `dropoff` | object |  | Required parameter ONLY if get_shipping_parameter returns "dropoff" under "info_needed". Developer should still include "dropoff" field in the call even if "dropoff" has empty value. If you choose Regular shipping method, please use "tracking_no" to call Init API. If you choose JOB shipping method, please use "sender_real_name" to call Init API. Note that only one of "tracking_no" and "sender_real_name" can be selected. |

Lỗi riêng: Pickup address is not supported. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · System error. Please try again later. · Pickup address does not match product location. Please check warehouse configuration

## v2.logistics.get_booking_tracking_number
`GET /api/v2/logistics/get_booking_tracking_number` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

After arranging shipment (v2.logistics.ship_booking) for the integrated channel, use this api to get the tracking_number, which is a required parameter for creating shipping labels. The api response can return tracking_number empty, since this info is dependent from the 3PL, due to this it is allowed to keep calling the api within 5 minutes interval, until the tracking_number is returned.

Lịch sử cập nhật: 2024-07-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `booking_sn` | string | ✔ | Shopee's unique identifier for a booking. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `tracking_number` | string | The tracking number of this booking. |

Lỗi riêng: Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.get_booking_shipping_document_parameter
`POST /api/v2/logistics/get_booking_shipping_document_parameter` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get the selectable shipping_document_type and suggested shipping_document_type.

Lịch sử cập nhật: 2024-07-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `booking_list` | object[] | ✔ | The list of bookings you want to get. limit [1,50] |
| `↳ booking_sn` | string | ✔ | Shopee's unique identifier for a booking. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ result_list` | object[] | The list of the result data. |
| `↳↳ booking_sn` | string | Shopee's unique identifier for a booking. |
| `↳↳ suggest_shipping_document_type` | string | The shipping document type Shopee suggests. If you don't select any shipping document type, Shopee will use this as default shipping document type. |
| `↳↳ selectable_shipping_document_type` | string[] | The shipping document type you can select of this booking. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: Can not get airway bill for warehouse booking orders. · Can not arrange shipment for warehouse booking orders · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.create_booking_shipping_document
`POST /api/v2/logistics/create_booking_shipping_document` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to create shipping document task for each booking and this API is only available after retrieving the tracking number.

Lịch sử cập nhật: 2024-07-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `booking_list` | object[] | ✔ | The list of bookings you want to get. limit [1,50] |
| `↳ booking_sn` | string | ✔ | Shopee's unique identifier for a booking. |
| `↳ tracking_number` | string |  | The tracking number of booking. Required except for the channel allow print before arrange shipment. |
| `↳ shipping_document_type` | string |  | The type of shipping document. Available values: NORMAL_AIR_WAYBILL,THERMAL_AIR_WAYBILL,NORMAL_JOB_AIR_WAYBILL,THERMAL_JOB_AIR_WAYBILL |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ result_list` | object[] | The list of the result data. |
| `↳↳ booking_sn` | string | Shopee's unique identifier for a booking. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: Can not get airway bill for warehouse booking orders. · Can not arrange shipment for warehouse booking orders · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · Something is wrong, please try again later. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.get_booking_shipping_document_result
`POST /api/v2/logistics/get_booking_shipping_document_result` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to retrieve the status of the shipping document task. Document will be available for download only after the status change to 'READY'.

Lịch sử cập nhật: 2024-07-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `booking_list` | object[] | ✔ | The list of bookings you want to get. limit [1,50] |
| `↳ booking_sn` | string | ✔ | Shopee's unique identifier for a booking. |
| `↳ shipping_document_type` | string |  | The type of shipping document. Available values: NORMAL_AIR_WAYBILL,THERMAL_AIR_WAYBILL |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ result_list` | object[] | The list of the result data. |
| `↳↳ booking_sn` | string | Shopee's unique identifier for a booking. |
| `↳↳ status` | string | The status of the shipping document task you querying with booking_sn. Available values: READY/FAILED/PROCESSING |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · Something is wrong, please try again later. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.download_booking_shipping_document
`POST /api/v2/logistics/download_booking_shipping_document` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to download shipping_document. You have to call v2.logistics.create_booking_shipping_document to create a new shipping document task first and call v2.logistics.get_booking_shipping_document_result to get the task status second. If the task is READY, you can download this shipping document.

Lịch sử cập nhật: 2024-07-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shipping_document_type` | string |  | The type of shipping document. Available values: NORMAL_AIR_WAYBILL,THERMAL_AIR_WAYBILL |
| `booking_list` | object[] | ✔ | The list of bookings you want to get. limit [1,50] |
| `↳ booking_sn` | string | ✔ | Shopee's unique identifier for a booking. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `waybill` | file | The waybill file. |

Lỗi riêng: Processing, please download later. Detail: {msg} · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · Something is wrong, please try again later. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.get_booking_shipping_document_data_info
`POST /api/v2/logistics/get_booking_shipping_document_data_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to fetch the logistics information of a booking these info can be used for airwaybill printing. Dedicated for crossborder SLS order airwaybill. May not be applicable for local channel airwaybill. Besides, this api supports returning personal info as images.

Lịch sử cập nhật: 2026-07-15: add response field "dg_specific_type"; 2024-07-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `booking_sn` | string | ✔ | Shopee's unique identifier for a booking. |
| `recipient_address_info` | object[] |  | recipient address to query as image |
| `↳ key` | string | ✔ | fields to query in the recipient address, should be name, phone, full_address, town, district, city, state, region, zipcode. |
| `↳ style` | object |  | image style |
| `↳↳ text_style` | string[] |  | supports bold and italic |
| `↳↳ font_size` | int64 |  | supports 1 - 108 |
| `↳↳ text_color` | string |  | color string like "#AbCd12" |
| `↳↳ image_width` | float |  | supports 0.1-30, in centimeters |
| `↳↳ h_align` | string |  | text horizontal align, supports left, center and right. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ recipient_address_info` | object |  |
| `↳↳ key` | string | queried field in recipient address |
| `↳↳ image` | string | base64 encoded png data string |
| `↳ shipping_document_info` | object |  |
| `↳↳ booking_weight` | int64 | Use this field to indicate booking weight when calculate the shipping fee. The unit of weigh is gram. |
| `↳↳ logistics_channel_id` | int64 | The identity of logistic channel. |
| `↳↳ shipping_carrier` | string | The logistics service provider for the booking. |
| `↳↳ recipient_sort_code` | object | The sort_code of recipient. |
| `↳↳↳ first_recipient_sort_code` | string | The first-level sort_code of recipient. |
| `↳↳↳ second_recipient_sort_code` | string | The second-level sort_code of recipient. |
| `↳↳↳ third_recipient_sort_code` | string | The third-level sort_code of recipient. |
| `↳↳ sender_sort_code` | object | The sort_code of sender. |
| `↳↳↳ first_sender_sort_code` | string | The first-level sort_code of sender. |
| `↳↳↳ second_sender_sort_code` | string | The second-level sort_code of sender. |
| `↳↳↳ third_sender_sort_code` | string | The third-level sort_code of sender. |
| `↳↳ return_sort_code` | object | The sort code for 3PL doing RTS. |
| `↳↳↳ return_first_sort_code` | string | The first-level sort code for 3PL doing RTS. |
| `↳↳ tracking_number` | string | The tracking number assigned by the shipping carrier for item shipment. |
| `↳↳ pickup_hub` | string | The name of pickup hub. |
| `↳↳ delivery_hub` | string | The name of delivery hub. |
| `↳↳ deliver_area` | string | Zone name. |
| `↳↳ ec_booking_no` | string | The name of ec booing. |
| `↳↳ create_date_ymd_sl` | string | The date of create shipment booking. |
| `↳↳ manufacturers_name` | string | The name of manufacturer. |
| `↳↳ manufacturers_website` | string | The website of manufacturer. |
| `↳↳ is_lm_dg_bool` | int64 | Use this field to indicate order contains dangerous goods or not. 0: Non-dangerous good 1: Dangerous good 2: Prohibited |
| `↳↳ spx_sub_district` | string | The sub-district of recipient's address. |
| `↳↳ spx_receive_station` | object | The spx receive station. |
| `↳↳↳ spx_first_receive_station` | string | The first pickup station. |
| `↳↳ zone` | string | The zone of this booking. |
| `↳↳ zone_code` | string | Delivery Sub Zone. |
| `↳↳ destination_base_code` | string | Distribution Center Code. |
| `↳↳ dg_specific_type` | int32 | Currently only applicable for Brazil, Indonesia, Vietnam, Philippines. For orders with Dangerous Goods, this value indicates the severity of the danger and requires special handling by the logistics provider. 0 = Not classified / no DG sub-type 1 = DG_A 2 = DG_B 3 = DG_C 4 = DG_D |

Lỗi riêng: Can not get airway bill for warehouse booking orders. · Can not arrange shipment for warehouse booking orders · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.get_booking_tracking_info
`GET /api/v2/logistics/get_booking_tracking_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get the logistics tracking information of a booking.

Lịch sử cập nhật: 2024-07-16: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `booking_sn` | string | ✔ | Shopee's unique identifier for a booking. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ booking_sn` | string | Shopee's unique identifier for a booking. |
| `↳ logistics_status` | string | The Shopee logistics status for the booking. Applicable values. LOGISTICS_REQUEST_CREATED:booking arranged shipment LOGISTICS_PICKUP_DONE:booking handed over to 3PL LOGISTICS_PICKUP_FAILED:booking cancelled by 3PL due to failed pickup or picked up but not able to proceed with delivery LOGISTICS_DELIVERY_DONE:successfully delivered LOGISTICS_REQUEST_CANCELED:cancelled when booking at LOGISTICS_REQUEST_CREATED LOGISTICS_READY:booking ready for fulfilment LOGISTICS_INVALID:cancelled when booking at LOGISTICS_READY LOGISTICS_LOST:booking cancelled due to 3PL lost the parcel |
| `↳ tracking_info` | object[] | The tracking info of the booking. |
| `↳↳ update_time` | timestamp | The time when logistics info has been updated. |
| `↳↳ description` | string | The description of booking logistics tracking info.logistics_status |
| `↳↳ logistics_status` | string | The Shopee logistics status for the booking. TrackingLogisticsStatus: INITIAL ORDER_INIT ORDER_SUBMITTED ORDER_CREATED PICKUP_REQUESTED PICKUP_PENDING PICKED_UP DELIVERY_PENDING DELIVERED LOST UPDATE UPDATE_SUBMITTED UPDATE_CREATED RETURN_STARTED RETURN_PENDING CANCEL CANCEL_CREATED CANCELED FAILED_ORDER_SUBMITTED FAILED_ORDER_CREATED FAILED_PICKUP_REQUESTED FAILED_PICKED_UP FAILED_DELIVERED FAILED_UPDATE_SUBMITTED FAILED_UPDATE_CREATED FAILED_RETURNED FAILED_CANCEL_CREATED FAILED_CANCELED RETURNED RETURN_INTIATED |

Lỗi riêng: Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.download_to_label
`POST /api/v2/logistics/download_to_label` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

Use the API to download the TO label that should be attached to the carton before drop-off at the warehouse (Only for TW channel_id:30029).

Lịch sử cập nhật: 2026-10-30: Increase "quantity" limit up to 100 per request; 2025-09-10: Add "quantity" request parameter; 2025-06-26: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `sorting_group` | int32 | ✔ | Sorting Group of the TO. Available value: 1:North 2:South |
| `quantity` | int32 |  | Specifies the TO quantity, up to a maximum of 100 per request. If not specified, the default value is 1 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `waybill` | file | The waybill file. |

Lỗi riêng: Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · You do not have permission to call this API because you are either not enabled for channel 30029 or do not have any ongoing orders in this channel. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.create_shipping_document_job
`POST /api/v2/logistics/create_shipping_document_job` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

This API creates a shipping document job for selected documents. The system receives requests and returns a job ID along with success and failure details.

Lịch sử cập nhật: 2026-10-15: Add booking_sn request parameter, add new shipping_document_type; 2025-12-26: Add package_list request parameter; 2025-07-30: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shipping_document_type` | string | ✔ | The type of shipping document. Available values: NORMAL_AIR_WAYBILL, THERMAL_AIR_WAYBILL, NORMAL_JOB_AIR_WAYBILL, THERMAL_JOB_AIR_WAYBILL, THERMAL_UNPACKAGED_LABEL |
| `unpackaged_sku_requests` | object[] |  | List of Unpackaged SKUs to generate labels for. Note: The unpackaged_sku_requests, package_list, and booking_sn cannot be populated at the same time, please select one. |
| `↳ unpackaged_sku_id` | string |  | Unpackaged SKU ID of the model. |
| `↳ quantity` | int64 |  | Number of copies for the generated labels (maximum 600 total across all requested SKUs). |
| `package_list` | string[] |  | List of Package Numbers to generate labels for. (maximum 600 total) Note: The unpackaged_sku_requests, package_list, and booking_sn cannot be populated at the same time, please select one. |
| `booking_sn` | string[] |  | List of Booking SN to generate labels for. (maximum 600 total) Note: The unpackaged_sku_requests, package_list, and booking_sn cannot be populated at the same time, please select one. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ job_id` | string | Generated Job ID which will be used for status tracking and download the Shipping Document |
| `↳ success_id_list` | string[] | List of Package Number, Unpackaged SKU ID, or Booking SN that succeeds in generating Shipping Document |
| `↳ fail_list` | object[] | List of Package Numbers or Unpackaged SKUs that failed in generating Shipping Document |
| `↳↳ id` | string | Package Number or Unpackaged SKU ID that failed in generating Shipping Document |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: Wrong parameters, detail: {msg}. · The packages has different C2C status. · The packages has different shipping channel. Please input packages with the same shipping channel. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.get_shipping_document_job_status
`POST /api/v2/logistics/get_shipping_document_job_status` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

This API retrieves the status of a shipping document job using the job ID provided.

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `job_id` | string | ✔ | Generated Job ID for status tracking and download the Shipping Document |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ job_id` | string | Generated Job ID for status tracking and download the Shipping Document |
| `↳ job_name` | string | Generated Shipping Document file name. |
| `↳ job_status` | string | Requested Shipping Document current status. Available values: PROCESSING, READY, EXPIRED, FAILED |

Lỗi riêng: Wrong parameters, detail: {msg}. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.download_shipping_document_job
`POST /api/v2/logistics/download_shipping_document_job` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

This API allows users to download the shipping document associated with a specific job ID. It checks the job status before proceeding with the download.

Lịch sử cập nhật: 2025-07-30: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `job_id` | string | ✔ | Generated Job ID for status tracking and download the Shipping Document |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `file` | file |  |

Lỗi riêng: Processing, please download later. Detail: {msg} · Some package failed to print, please call create_shipping_document_job again. Detail: {{msg}} · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · The shipping document file is expired, please get a new one and retry. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.update_self_collection_order_logistics
`POST /api/v2/logistics/update_self_collection_order_logistics` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

Use this api to update the order status for buyer to collect the orders directly from your pharmacy. This includes indicating that order is ready for collection, and that the order has been picked up by the buyer. You should call v2.logistics.get_order_detail or v2.logistics.get_package_detail first to get the package_number of such orders.

Lịch sử cập nhật: 2026-03-27: Add new pin request parameter; 2025-09-18: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `package_number` | string | ✔ | Shopee's unique identifier for the package under an order. |
| `self_collection_logistics_action` | string | ✔ | Order logistics action. available values: - ready_for_collection - order_collected |
| `epoc_image_list` | string[] |  | List of image_id for the proof that buyer already collected the order at the store. Required when self_collection_logistics_action is order_collected. Max: 3. You can call the v2.media.upload_image to upload image and get the image_id, for this scenario, please pass the business = 1 and scene = 1. |
| `pin` | string |  | PIN code required for prescription orders when buyer collects at your shop. |

Lỗi riêng: Invalid collection PIN. Please verify and try again. · Buyer self collection unavailable for this order · Parcel is not ready for collection yet · Prepare order for buyer collection · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment

## v2.logistics.get_mart_packaging_info
`GET /api/v2/logistics/get_mart_packaging_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

[Only for ID mart seller] The API allows sellers to retrieve their current packaging fee settings.

Lịch sử cập nhật: 2025-07-03: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ enable` | boolean | Indicates whether the seller has enabled or disabled the packaging fee configuration. True: The seller charges a packaging fee. False: The seller does not charge a packaging fee. |
| `↳ dimension` | object | Returned only if enabled is set to True. |
| `↳↳ length` | int32 | The length of the packaging in centimetres (cm). |
| `↳↳ width` | int32 | The width of the packaging in centimetres (cm). |
| `↳↳ height` | int32 | The height of the packaging in centimetres (cm). |
| `↳ packaging_fee` | object | Returned only if enabled is set to True. |
| `↳↳ value` | float | The packaging fee price in the seller's local currency. |

Lỗi riêng: Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.set_mart_packaging_info
`POST /api/v2/logistics/set_mart_packaging_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

[Only for ID mart seller] This API allows sellers to set up their packaging fee info. Through this API, sellers can enable or disable packaging fees, and if enabled, specify the dimensions of the packaging and the associated fee. This ensures that sellers can configure their shipping costs accurately based on their packaging requirements.

Lịch sử cập nhật: 2025-07-03: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `enable` | boolean | ✔ | Indicates whether the seller has enabled or disabled the packaging fee configuration. True: The seller charges a packaging fee. False: The seller does not charge a packaging fee. |
| `dimension` | object |  | Required if enabled is set to True. |
| `↳ length` | int32 | ✔ | The length of the packaging in centimetres (cm). |
| `↳ width` | int32 | ✔ | The width of the packaging in centimetres (cm). |
| `↳ height` | int32 | ✔ | The height of the packaging in centimetres (cm). |
| `packaging_fee` | object |  | Required if enabled is set to True. |
| `↳ value` | float | ✔ | The packaging fee price in your region's local currency. For SG/MY/BR/MX seller: Sellers can set the price with two decimal place, other regions can only set the price as an integer. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ enable` | boolean | Indicates whether the seller has enabled or disabled the packaging fee configuration. True: The seller charges a packaging fee. False: The seller does not charge a packaging fee. |
| `↳ dimension` | object | Returned only if enabled is set to True. |
| `↳↳ length` | int32 | The length of the packaging in centimetres (cm). |
| `↳↳ width` | int32 | The width of the packaging in centimetres (cm). |
| `↳↳ height` | int32 | The height of the packaging in centimetres (cm). |
| `↳ packaging_fee` | object | Returned only if enabled is set to True. |
| `↳↳ value` | float | The packaging fee price in the seller's local currency. |

Lỗi riêng: Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.upload_serviceable_polygon
`POST /api/v2/logistics/upload_serviceable_polygon` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

Only available for Brazil sellers. Use this API to upload KML file for shop level serviceability setting for BR Entrega Turbo channel (Channel ID: 90026). Please note that multiple Outlet Shops under the same Mart Shop can have overlapping service areas.

Lịch sử cập nhật: 2025-09-18: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `file` | file | ✔ | The .kml file to be uploaded to denote the serviceability area of the shops. Note: Please refer to “KML file format for v2.logistics.upload_serviceable_polygon” to understand the structure specifications and upload requirements for KML files. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ task_id` | string | Use the task_id to call v2.logistics.check_polygon_update_status to check if the upload job has been completed. |

Lỗi riêng: File size exceeds max allowable size. · File cannot be opened · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · Shop is not eligible to upload file as instant channel is not enabled · Internal api called failed. Please try again later. · System error. Please try again later. · File type is not .kml type

## v2.logistics.check_polygon_update_status
`POST /api/v2/logistics/check_polygon_update_status` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

Only available for Brazil sellers. Use this API to check the status of polygon file uploaded for BR Entrega Turbo channel (Channel ID: 90026) by querying the task_id returned via the v2.logistics.upload_serviceable_polygon.

Lịch sử cập nhật: 2025-09-18: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `task_id` | string | ✔ | ID that needs to be checked. Please pass the task_id returned via the v2.logistics.upload_serviceable_polygon. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ status` | int32 | Serviceable polygon file upload status. Applicable values: 0: Task completed 1: Task in progress 2: KML file related errors |
| `↳ message` | string | Details of the upload status, e.g "task in progress". |

Lỗi riêng: Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · Error Details : {msg}

## v2.logistics.get_pause_status
`GET /api/v2/logistics/get_pause_status` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

This API returns the pause status of logistics channels under the shop. Pausing allows the shop to temporarily prevent buyers from placing orders through specific logistics channels. The response includes whether a pause is currently active, the pause end time (if active), and the remaining daily pause quota in seconds (if inactive). Sellers need to refer to the support_pause field in v2.logistics.get_channel_list response to determine which channels are actually paused.

Lịch sử cập nhật: 2026-03-31: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ is_paused` | boolean | Indicate the current pause status of logistics channels under the shop. Applicable values: - true: All relevant channels are currently paused and will not have any new incoming orders - false: No channels are paused and may have new incoming orders Note: Please first call v2.logistics.get_pause_status to query the current suspension status of instant orders for the store. If is_paused = true, then call v2.logistics.get_channel_list and identify the range of channels affected by the pause function through support_pause = true. |
| `↳ pause_end_time` | timestamp | Time at which the relevant paused channels will automatically resume, returned only when is_paused = true, indicating the estimated time when the system will automatically resume order acceptance after the daily remaining quota is exhausted. Note: During the pause period, the seller may call the v2.logistics.set_pause_status at any time with is_paused = false to manually resume order acceptance. After resumption, the consumption of the daily remaining quota will stop and it will be retained until reset the next day. |
| `↳ remaining_pause_quota` | int64 | The remaining pause quota of the shop on the current day, in seconds, returned only when is_paused = false. |

Lỗi riêng: Shop is not whitelisted for the pause feature

## v2.logistics.set_pause_status
`POST /api/v2/logistics/set_pause_status` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

Use this API to set the pause status of logistics channels under the shop. Pausing allows the shop to temporarily prevent buyers from placing orders through specific logistics channels. The response includes whether a pause is currently active, the pause end time (if active), and the remaining daily pause quota in seconds (if inactive). Note: The pause may take a few moments to take effect. Please check for any additional orders that may still be placed during this window.

Lịch sử cập nhật: 2026-03-31: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `is_paused` | boolean | ✔ | The target pause status that seller wants to update to. Applicable values: - true: Trigger pause. All relevant channels will be paused and will not have any new incoming orders (fulfillment of existing orders will not be affected). Meanwhile, the system will start deducting the daily pause quota and automatically calculate the pause end time based on the remaining quota. - false: Trigger manual resume. No channels are paused and may have new incoming orders. The remaining daily quota will stop being consumed and be retained until reset the next day. Note: Due to the system cache synchronization mechanism, there may be an approximately 15-second delay before the pause/resume operation takes e |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ is_paused` | boolean | Indicate the current pause status of logistics channels under the shop. Applicable values: - true: All relevant channels are currently paused and will not have any new incoming orders - false: No channels are paused and may have new incoming orders Note: Please first call v2.logistics.get_pause_status to query the current suspension status of instant orders for the store. If is_paused = true, then call v2.logistics.get_channel_list and identify the range of channels affected by the pause function through support_pause = true. |
| `↳ pause_end_time` | timestamp | Time at which the relevant paused channels will automatically resume, returned only when is_paused = true, indicating the estimated time when the system will automatically resume order acceptance after the daily remaining quota is exhausted. Note: During the pause period, the seller may call the v2.logistics.set_pause_status at any time with is_paused = false to manually resume order acceptance. After resumption, the consumption of the daily remaining quota will stop and it will be retained until reset the next day. |
| `↳ remaining_pause_quota` | int64 | The remaining pause quota of the shop on the current day, in seconds, returned only when is_paused = false. |

Lỗi riêng: No remaining pause quota left for the shop · Shop is not whitelisted for the pause feature

## v2.logistics.download_to_label_filelink
`POST /api/v2/logistics/download_to_label_filelink` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

Use the API to download the TO label that should be attached to the carton before drop-off at the warehouse (Only for TW channel_id:30029). This API will return file link instead of blob.

Lịch sử cập nhật: 2026-10-30: Increase "quantity" limit up to 100 per request; 2026-09-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `sorting_group` | int32 | ✔ | Sorting Group of the TO. Available value: 1:North 2:South |
| `quantity` | int32 |  | Specifies the TO quantity, up to a maximum of 100 per request. If not specified, the default value is 1 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `file_link` | string | The download link to the waybill file. The link will be valid for 30 minutes. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · You do not have permission to call this API because you are either not enabled for channel 30029 or do not have any ongoing orders in this channel. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.logistics.download_shipping_document_job_filelink
`POST /api/v2/logistics/download_shipping_document_job_filelink` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

This API allows users to download the shipping document associated with a specific job ID. It checks the job status before proceeding with the download. The response will contain a link that can be used to download the shipping document.

Lịch sử cập nhật: 2026-09-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `job_id` | string | ✔ | Generated Job ID for status tracking and download the Shipping Document |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `file_link` | string | The link to download the shipping document. The link will be valid for 30 minutes. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Processing, please download later. Detail: {msg} · Some package failed to print, please call create_shipping_document_job again. Detail: {{msg}} · Some addresses are no longer supported per new regulation, please update to avoid wrong fulfilment · The shipping document file is expired, please get a new one and retry. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Something wrong. Please try later. · shopid is invalid · request not from gateway

# Module AccountHealth (6 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.account_health.get_shop_performance
`GET /api/v2/account_health/get_shop_performance` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Customized APP, Swam ERP

The data metrics of shop performance.

Lịch sử cập nhật: 2025-12-31: Add "% HD Listings" and "% HD Free Shipping Enabled" metrics; 2025-05-16: Add "% SDD Listings" metric; 2025-05-08: Add "Poor Quality Products" metric; 2025-02-28: Add "% NDD Listings" metric; 2025-01-14: Add "exemption_end_date" response parameter

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ overall_performance` | object |  |
| `↳↳ rating` | int32 | Overall Performance: Poor = 1 ImprovementNeeded = 2 Good = 3 Excellent = 4 |
| `↳↳ fulfillment_failed` | int32 | The number of metrics that did not meet target under Fulfillment Performance type. |
| `↳↳ listing_failed` | int32 | The number of metrics that did not meet target under Listing Performance type. |
| `↳↳ custom_service_failed` | int32 | The number of metrics that did not meet target under Customer Service Performance type. |
| `↳ metric_list` | object[] |  |
| `↳↳ metric_type` | int32 | Type of metric: Fulfillment Performance = 1 Listing Performance = 2 Customer Service Performance = 3 |
| `↳↳ metric_id` | int64 | ID of metric. If metric_id < 0, it means that this is not a real metric, but a group of metrics. Non-Responded Chats = -1 Late Shipment Rate (All Channels) = 1 Non-Fulfilment Rate (All Channels) = 3 Preparation Time = 4 Chat Response Rate = 11 Pre-order Listing % = 12 Days of Pre-order Listing Violation = 15 Response Time = 21 Shop Rating = 22 No. of Non-Responded Chats = 23 Fast Handover Rate = 25 On-time Pickup Failure Rate = 27 On-time Pickup Failure Rate Violation Value = 28 Average Response Time = 29 Cancellation Rate (All Channels) = 42 Return-refund Rate (All Channels) = 43 Severe Listing Violations = 52 Other Listing Violations = 53 Prohibited Listings = 54 Counterfeit/IP infringemen |
| `↳↳ parent_metric_id` | int64 | ID of parent metric. |
| `↳↳ metric_name` | string | Default name of metric. |
| `↳↳ current_period` | float | The performance of the metric at current period. |
| `↳↳ last_period` | float | The performance of the metric at last period. |
| `↳↳ unit` | int32 | Unit of metric: Number = 1 Percentage = 2 Second = 3 Day = 4 Hour = 5 |
| `↳↳ target` | object |  |
| `↳↳↳ value` | float | Value of target. |
| `↳↳↳ comparator` | string | Comparator of target: <, <=, >, >=, = |
| `↳↳ exemption_end_date` | string | (Only for whitelist TW sellers) The exemption_end_date value will not be empty if ALL conditions are met: - The shop is in the "POL Shop Whitelist" - Within the "Exemption Period" - The metric_id is 12 (Pre-order Listing %) or 15 (Days of Pre-order Listing Violation) |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.account_health.get_metric_source_detail
`GET /api/v2/account_health/get_metric_source_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Customized APP, Swam ERP

Get the Affected Orders / Relevant Listings / Relevant Violations details of metrics.

Lịch sử cập nhật: 2026-06-29: add otdr; 2026-02-06: Add Metric 2032 and 2033; 2025-12-31: Support getting "hd_listing_list" for "% HD Listings" and "% HD Free Shipping Enabled" metrics; 2025-11-21: Add new option: 4: Preparation Time for “metric_id”, add new response parameter “apt_order_list”, add more response parameters under “lsr_order_list” and “fhr_order_list”; 2025-05-16: Support getting "sdd_listing_list" for "% SDD Listings" metric

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `metric_id` | int64 | ✔ | ID of metric. Supported values: 1: Late Shipment Rate (All Channels) 3: Non-Fulfilment Rate (All Channels) 4: Preparation Time 12: Pre-order Listing % 15: Days of Pre-order Listing Violation 25: Fast Handover Rate 28: On-time Pickup Failure Rate Violation Value 42: Cancellation Rate (All Channels) 43: Return-refund Rate (All Channels) 52: Severe Listing Violations 53: Other Listing Violations 85: Late Shipment Rate (NDD) 88: Non-fulfilment Rate (NDD 91: Cancellation Rate (NDD) 92: Return-refund Rate (NDD) 96: % SDD Listings 97: % NDD Listings 2001: Fast Handover Rate - SLS 2002: Fast Handover Rate - FBS 2003: Fast Handover Rate - 3PF 2030: % HD Listings 2031: % HD Free Shipping Enabled 2032: |
| `page_no` | int32 |  | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. Default is 1. |
| `page_size` | int32 |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. Default is 10. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ metric_id` | int64 | ID of metric. |
| `↳ nfr_order_list` | object[] | Affected Orders for Non-fulfilment Rate. Supported metric_id: 3: Non-Fulfilment Rate (All Channels) 88: Non-fulfilment Rate (NDD) |
| `↳↳ order_sn` | string | Order SN. |
| `↳↳ non_fulfillment_type` | int32 | Non-fulfilment type. Applicable values: 1: System Cancellation 2: Seller Cancellation 3: Return Refunds |
| `↳↳ detailed_reason` | int32 | Reason. Applicable values: 1001: Return Refund 1002: Parcel Split Cancellation 1003: First Mile Pick up fail 1004: Order inclusion 10005: Out of Stock 10006: Undeliverable area 10007: Cannot support COD 10008: Logistics request cancelled 10009: Logistics pickup failed 10010: Logistics not ready 10011: Inactive seller 10012: Seller did not ship order 10013: Order did not reach warehouse 10014: Seller asked to cancel 10015: Non-receipt 10016: Wrong item 10017: Damaged item 10018: Incomplete product 10019: Fake item 10020: Functional Damage 10021: Return Refund |
| `↳ cancellation_order_list` | object[] | Affected Orders for Cancellation Rate. Supported metric_id: 42: Cancellation Rate (All Channels) 91: Cancellation Rate (NDD) |
| `↳↳ order_sn` | string | Order SN. |
| `↳↳ cancellation_type` | int32 | Cancellation Type. Applicable values: 1: System Cancellation 2: Seller Cancellation |
| `↳↳ detailed_reason` | int32 | Reason. Applicable values: 1001: Return Refund 1002: Parcel Split Cancellation 1003: First Mile Pick up fail 1004: Order inclusion 10005: Out of Stock 10006: Undeliverable area 10007: Cannot support COD 10008: Logistics request cancelled 10009: Logistics pickup failed 10010: Logistics not ready 10011: Inactive seller 10012: Seller did not ship order 10013: Order did not reach warehouse 10014: Seller asked to cancel 10015: Non-receipt 10016: Wrong item 10017: Damaged item 10018: Incomplete product 10019: Fake item 10020: Functional Damage 10021: Return Refund |
| `↳ return_refund_order_list` | object[] | Affected Orders for Return-refund Rate. Supported metric_id: 43: Return-refund Rate (All Channels) 92: Return-refund Rate (NDD) |
| `↳↳ order_sn` | string | Order SN. |
| `↳↳ detailed_reason` | int32 | Reason. Applicable values: 1001: Return Refund 1002: Parcel Split Cancellation 1003: First Mile Pick up fail 1004: Order inclusion 10005: Out of Stock 10006: Undeliverable area 10007: Cannot support COD 10008: Logistics request cancelled 10009: Logistics pickup failed 10010: Logistics not ready 10011: Inactive seller 10012: Seller did not ship order 10013: Order did not reach warehouse 10014: Seller asked to cancel 10015: Non-receipt 10016: Wrong item 10017: Damaged item 10018: Incomplete product 10019: Fake item 10020: Functional Damage 10021: Return Refund |
| `↳ lsr_order_list` | object[] | Affected Orders for Late Shipment Rate. Supported metric_id: 1: Late Shipment Rate (All Channels) 85: Late Shipment Rate (NDD) |
| `↳↳ order_sn` | string | Order SN. |
| `↳↳ shipping_deadline` | timestamp | Ship by date. |
| `↳↳ actual_shipping_time` | timestamp | Seller arrange shipment time. |
| `↳↳ late_by_days` | int64 | Late-by Days. |
| `↳↳ actual_pick_up_time` | timestamp | Courier actual pick up time. |
| `↳↳ shipping_channel` | string | Logistics Company. |
| `↳↳ first_mile_type` | string | First mile shipping type. Applicable values: Pickup Drop off |
| `↳↳ diagnosis_scenario` | string[] | Diagnosis of the issue. |
| `↳ fhr_order_list` | object[] | Affected Orders for Fast Handover Rate. Supported metric_id: 25: Fast Handover Rate 2001: Fast Handover Rate - SLS 2002: Fast Handover Rate - FBS 2003: Fast Handover Rate - 3PF |
| `↳↳ order_sn` | string | Order SN. |
| `↳↳ parcel_id` | int64 | Parcel ID. |
| `↳↳ parcel_display_id` | string | Display Parcel ID. |
| `↳↳ confirm_time` | timestamp | Confirmed Date. |
| `↳↳ handover_deadline` | timestamp | Handover Deadline. |
| `↳↳ fast_handover_due_date` | timestamp | Fast Handover Due Date. |
| `↳↳ arrange_pick_up_time` | timestamp | Seller arrange pick up time. |
| `↳↳ handover_time` | timestamp | Parcel drop off / pickup time. |
| `↳↳ shipping_channel` | string | Logistics Company. |
| `↳↳ first_mile_type` | string | First mile shipping type. Applicable values: Pickup Drop off |
| `↳↳ first_mile_tracking_no` | string | First Mile Tracking No. |
| `↳↳ diagnosis_scenario` | string[] | Diagnosis of the issue. |
| `↳ opfr_day_detail_data_list` | object[] | Relevant Violations for OPFR Violation Value. Supported metric_id: 28: On-time Pickup Failure Rate Violation Value |
| `↳↳ date` | string | Date. |
| `↳↳ scheduled_pickup_num` | int32 | Number of scheduled pickups. |
| `↳↳ failed_pickup_num` | int32 | Number of failed pickups. |
| `↳↳ opfr` | int32 | OPFR. |
| `↳↳ target` | string | Target. |
| `↳ violation_listing_list` | object[] | Relevant Listings for Severe Listing Violations and Other Listing Violations. Supported metric_id: 52: Severe Listing Violations 53: Other Listing Violations |
| `↳↳ item_id` | int64 | Item ID. |
| `↳↳ detailed_reason` | int32 | Reason. Applicable values: 1: Prohibited 2: Counterfeit 3: Spam 4: Inappropriate Image 5: Insufficient Info 6: Mall Listing Improvement 7: Other Listing Improvement 8: PQR Products |
| `↳↳ update_time` | timestamp | Updated on. |
| `↳ pre_order_listing_violation_data_list` | object[] | Relevant Listings for Days of Pre-order Listing Violation. Supported metric_id: 15: Days of Pre-order Listing Violation |
| `↳↳ date` | string | Date. |
| `↳↳ live_listing_count` | int64 | Number of Live Listings. |
| `↳↳ pre_order_listing_count` | int32 | Number of pre-order Listings. |
| `↳↳ pre_order_listing_rate` | int32 | Pre-order Listing %. |
| `↳↳ target` | string | Target. |
| `↳ pre_order_listing_list` | object[] | Relevant Listings for Pre-order Listing. Supported metric_id: 12: Pre-order Listing % |
| `↳↳ item_id` | int64 | Item ID. |
| `↳↳ current_pre_order_status` | int32 | Current Pre-order Status. Applicable values: 1: Yes 2: No |
| `↳ sdd_listing_list` | object[] | Relevant Listings for % SDD Listings. Supported metric_id: 96: % SDD Listings. |
| `↳↳ item_id` | int64 | Item ID. |
| `↳↳ current_sdd_status` | int32 | Current SDD Status. Applicable values: 1: Yes 0: No |
| `↳ ndd_listing_list` | object[] | Relevant Listings for % NDD Listings. Supported metric_id: 97: % NDD Listings. |
| `↳↳ item_id` | int64 | Item ID. |
| `↳↳ current_ndd_status` | int32 | Current NDD Status. Applicable values: 1: Yes 0: No |
| `↳ apt_order_list` | object[] | Affected Parcels for Preparation Time. Supported metric_id: 4: Preparation Time |
| `↳↳ order_sn` | string | Order SN. |
| `↳↳ order_create_time` | timestamp | Order Paid Time. |
| `↳↳ arrange_pick_up_time` | timestamp | Seller arrange pick up time. |
| `↳↳ actual_pick_up_time` | timestamp | Courier actual pick up time. |
| `↳↳ preparation_days` | float | Preparation Days. |
| `↳↳ shipping_channel` | string | Logistics Company. |
| `↳↳ first_mile_type` | string | First mile shipping type. Applicable values: Pickup Drop off |
| `↳↳ first_mile_tracking_no` | string | First Mile Tracking No. |
| `↳ hd_listing_list` | object | Relevant Listings for % HD Listings and % HD Free Shipping Enabled. Supported metric_id: 2030: % HD Listings 2031: % HD Free Shipping Enabled |
| `↳↳ item_id` | int64 | Item ID. |
| `↳↳ current_status` | int32 | For 2030: % HD Listings, it refer to Current HD Status. For 2031: % HD Free Shipping Enabled, it refer to Free Shipping Enabled Status. Applicable values: 1: Yes 2: No |
| `↳ saturday_shipment_list` | object[] | Affected Parcels for Saturday Shipment Supported metric_id: 2032: Saturday Shipment |
| `↳↳ order_sn` | string | Order SN. |
| `↳↳ order_create_time` | timestamp | Order Paid Time. |
| `↳↳ arrange_pick_up_time` | timestamp | Seller arrange pick up time. |
| `↳↳ actual_pick_up_time` | timestamp | Courier actual pick up time. |
| `↳↳ preparation_days` | float | Preparation Days. |
| `↳↳ shipping_channel` | string | Logistics Company. |
| `↳↳ first_mile_type` | string | First mile shipping type. Applicable values: Pickup Drop off |
| `↳↳ first_mile_tracking_no` | string | First Mile Tracking No. |
| `↳ otdr_order_list` | object[] |  |
| `↳↳ order_id` | string | Order ID. |
| `↳↳ order_sn` | string | Order SN. |
| `↳↳ paid_time` | timestamp | Order Paid Time. |
| `↳↳ estimated_delivery_date` | timestamp | Estimated delivery date |
| `↳↳ actual_pick_up_time` | timestamp | Actual pick up time |
| `↳↳ real_delivery_time` | timestamp | Real delivery time |
| `↳↳ difference_between_edd_rdt` | string | Difference days between estimated delivery date and real delivery time |
| `↳ total_count` | int32 | Total number of Affected Orders or Relevant Listings. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.account_health.get_penalty_point_history
`GET /api/v2/account_health/get_penalty_point_history` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Customized APP, Swam ERP

Get the penalty point records generated in the current quarter.

Lịch sử cập nhật: 2025-05-08: Add 4130: Poor Product Quality option for violation_type request and response parameter; 2024-11-05: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 |  | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. Default is 1. |
| `page_size` | int32 |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. Default is 10. |
| `violation_type` | int64 |  | Applicable values: 5: High Late Shipment Rate 6: High Non-fulfilment Rate 7: High number of non-fulfilled orders 8: High number of late shipped orders 9: Prohibited Listings 10: Counterfeit / IP infringement 11: Spam 12: Copy/Steal images 13: Re-uploading deleted listings with no change 14: Bought counterfeit from mall 15: Counterfeit caught by Shopee 16: High percentage of pre-order listings 17: Confirmed Fraud attempts (total) 18: Confirmed Fraud attempts per week (All with vouchers only) 19: Fake return address 20: Shipping fraud/abuse 21: High No. of Non-responded Chat 22: Rude chat replies 23: Request buyer to cancel order 24: Rude reply to buyer's review 25: Violate Return/Refund polic |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ penalty_point_list` | object[] | The penalty point records generated in the current quarter. |
| `↳↳ issue_time` | timestamp | The time when penalty points are issued. |
| `↳↳ latest_point_num` | int32 | The latest penalty points issued under current penalty point record. If seller raised appeal for this penalty point record and the appeal has been approved and Shopee adjusted the penalty point, then the original_point_num returns the penalty point before the adjustment, and latest_point_num returns the penalty point after the adjustment. |
| `↳↳ original_point_num` | int32 | The original penalty points issued under current penalty point record. If seller raised appeal for this penalty point record and the appeal has been approved and Shopee adjusted the penalty point, then the original_point_num returns the penalty point before the adjustment, and latest_point_num returns the penalty point after the adjustment. |
| `↳↳ reference_id` | int64 | Reference ID for this penalty point record. |
| `↳↳ violation_type` | int32 | Applicable values: 5: High Late Shipment Rate 6: High Non-fulfilment Rate 7: High number of non-fulfilled orders 8: High number of late shipped orders 9: Prohibited Listings 10: Counterfeit / IP infringement 11: Spam 12: Copy/Steal images 13: Re-uploading deleted listings with no change 14: Bought counterfeit from mall 15: Counterfeit caught by Shopee 16: High percentage of pre-order listings 17: Confirmed Fraud attempts (total) 18: Confirmed Fraud attempts per week (All with vouchers only) 19: Fake return address 20: Shipping fraud/abuse 21: High No. of Non-responded Chat 22: Rude chat replies 23: Request buyer to cancel order 24: Rude reply to buyer's review 25: Violate Return/Refund polic |
| `↳ total_count` | int32 | Total number of penalty point records. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.account_health.get_punishment_history
`GET /api/v2/account_health/get_punishment_history` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Customized APP, Swam ERP

Get the punishment records generated in the current quarter.

Lịch sử cập nhật: 2025-02-28: Add order_limit and listing_limit; 2024-11-05: Update the api name to remove space; 2024-11-05: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 |  | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. Default is 1. |
| `page_size` | int32 |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. Default is 10. |
| `punishment_status` | int32 | ✔ | The status of punishment. Applicable values: 1: Ongoing 2: Ended |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ punishment_list` | object[] | The punishment records generated in the current quarter. |
| `↳↳ issue_time` | timestamp | The time when punishment are issued. |
| `↳↳ start_time` | timestamp | Start time in the duration of this punishment record. |
| `↳↳ end_time` | timestamp | End time in the duration of this punishment record. |
| `↳↳ punishment_type` | int32 | Punishment Type of this punishment record. Applicable values: 103: Listings not displayed in category browsing 104: Listings not displayed in search 105: Unable to create new listings 106: Unable to edit listings 107: Unable to join marketing campaigns 108: No shipping subsidies 109: Account is suspended 600: Listings not displayed in search 601: Shop listings hide from recommendation 602: Listings not displayed in category browsing 1109: Listing Limit is reduced 1110: Listing Limit is reduced 1111: Listing Limit is reduced 1112: Listing Limit is reduced 2008: Order Limit |
| `↳↳ reason` | int32 | Reason of this punishment record. Applicable values: 1: Tier 1 2: Tier 2 3: Tier 3 4: Tier 4 5: Tier 5 1109: Listing Limit Tier 1 1110: Listing Limit Tier 2 1111: Listing Limit POL |
| `↳↳ reference_id` | int64 | Reference ID for this punishment record. |
| `↳↳ listing_limit` | int32 | Return the specific value of listing limit when punishment_type is: 1109: Listing Limit is reduced 1110: Listing Limit is reduced 1111: Listing Limit is reduced 1112: Listing Limit is reduced |
| `↳↳ order_limit` | string | Return the specific percentage of order limit when punishment_type is: 2008: Order Limit Daily Order Limit = X % * L28D ADO (Average Daily Order of this Shop in Past 28 Days) |
| `↳ total_count` | int32 | Total number of punishment records. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.account_health.get_listings_with_issues
`GET /api/v2/account_health/get_listings_with_issues` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Customized APP, Swam ERP

Get the Problematic Listings to improve the listings to avoid incurring penalty points.

Lịch sử cập nhật: 2024-11-05: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 |  | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. Default is 1. |
| `page_size` | int32 |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. Default is 10. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ listing_list` | object[] | Listing with issues. |
| `↳↳ item_id` | int64 | Item ID. |
| `↳↳ reason` | int32 | Reason of this item. Applicable values: 1: Prohibited 2: Counterfeit 3: Spam 4: Inappropriate Image 5: Insufficient Info 6: Mall Listing Improvement 7: Other Listing Improvement |
| `↳ total_count` | int32 | Total number of listing with issues. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.account_health.get_late_orders
`GET /api/v2/account_health/get_late_orders` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Customized APP, Swam ERP

Get the Late Orders to take action to avoid order cancellation and penalty points.

Lịch sử cập nhật: 2024-11-05: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 |  | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. Default is 1. |
| `page_size` | int32 |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. Default is 10. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ late_order_list` | object[] | Late Orders. |
| `↳↳ order_sn` | string | Order SN. |
| `↳↳ shipping_deadline` | timestamp | Shipping Deadline of this order. |
| `↳↳ late_by_days` | int32 | Late-by Days of this order. |
| `↳ total_count` | int32 | Total number of late orders. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

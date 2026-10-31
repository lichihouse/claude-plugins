# Module Returns (15 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.returns.get_return_list
`GET /api/v2/returns/get_return_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

Use this api to get detail information of many return by shop id.

Lịch sử cập nhật: 2026-08-31: Add is_partial_quantity_return and is_refund_amount_adjusted; 2025-12-19: Add reassessed_request_reason response field; 2025-11-28: Add is_arrived_at_warehouse and follow_up_action_list response fields; 2025-09-29: Add return_refund_request_type and validation_type response fields; 2025-09-19: Add is_seller_arrange and is_shipping_proof_mandatory response fields

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int64 | ✔ | Specifies the starting entry of data to return in the current call. Default is 0. if data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int64 | ✔ | if many items are available to retrieve, you may need to call GetReturnList multiple times to retrieve all the data. Each result set is returned as a page of entries. Default is 40. Use the Pagination filters to control the maximum number of entries (<= 100) to retrieve per page (i.e., per call), the offset number to start next call. This integer value is usUed to specify the maximum number of entries to return in a single ""page"" of data. |
| `create_time_from` | timestamp |  | The create_time_from and create_time_to fields specify a date range for retrieving orders (based on the order create time). The create_time_from field is the starting date range. The maximum date range that may be specified with the create_time_from and create_time_to fields is 15 days. |
| `create_time_to` | timestamp |  | The create_time_from and create_time_to fields specify a date range for retrieving orders (based on the order create time). The create_time_from field is the starting date range. The maximum date range that may be specified with the create_time_from and create_time_to fields is 15 days. |
| `update_time_from` | timestamp |  | The update_time_from and update_time_to fields specify a date range for retrieving orders (based on the last return updated time). The update_time_from field is the starting date range. The maximum date range that may be specified with the update_time_from and update_time_to fields is 15 days. update_time_from should be >= create_time_from |
| `update_time_to` | timestamp |  | The update_time_from and update_time_to fields specify a date range for retrieving orders (based on the last return updated time). The update_time_from field is the starting date range. The maximum date range that may be specified with the update_time_from and update_time_to fields is 15 days. update_time_from should be >= create_time_from |
| `status` | string |  | This is for filtering return request by return status. See "Data Definition - ReturnStatus" |
| `negotiation_status` | string |  | This is for filtering return request by counter status. See "Data Definition - NegotiationStatus" |
| `seller_proof_status` | string |  | This is for filtering return request by proof status. See "Data Definition - SellerProofStatus" |
| `seller_compensation_status` | string |  | This is for filtering return request by compensation status. See "Data Definition - SellerCompensationStatus" |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Amount of the refund. |
| `↳ more` | boolean | Whether has next page |
| `↳ return` | object[] |  |
| `↳↳ image` | string[] | Image URLs of return. |
| `↳↳ reason` | string | Indicates the original return reason submitted by the buyer when initiating the return request. Applicable values: See Data Definition- ReturnReason and Reassessed Request Reason. Note: There may be cases where Shopee Agent updates the return request with a "Reassessed Return Reason" after reviewing more details about the buyer's return request and potentially after requesting evidence from the seller. If the platform updates the return reason during this process, the reassessed outcome will be provided separately in the reassessed_request_reason field. |
| `↳↳ text_reason` | string | Reason that buyer provide. |
| `↳↳ reassessed_request_reason` | string | Indicates the return reason reassessed by the platform as more suitable. There may be cases where Shopee Agent updates the return request with a "Reassessed Return Reason" after reviewing more details about the buyer's return request and potentially after requesting evidence from the seller. Applicable values: See Data Definition- ReturnReason and Reassessed Request Reason. If no reassessment has been made, the value will be NONE. |
| `↳↳ return_sn` | string | The serial number of return. |
| `↳↳ refund_amount` | float | Amount of the refund. |
| `↳↳ currency` | string | Currency of the return. |
| `↳↳ create_time` | timestamp | The time of return create. |
| `↳↳ update_time` | timestamp | The time of modify return. |
| `↳↳ status` | string | Enumerated type that defines the current status of the return. Applicable values: See Data Definition- ReturnStatus. |
| `↳↳ due_date` | timestamp | The last time seller deal with this return. |
| `↳↳ tracking_number` | string | The tracking number assigned by the shipping carrier for item shipment. |
| `↳↳ dispute_reason` | string[] | The reason of seller dispute return. While the return has been disputed, this field is useful. Applicable values: See Data Definition- ReturnDisputeReason. |
| `↳↳ dispute_text_reason` | string[] | The reason that seller provide. While the return has been disputed, this field is useful. |
| `↳↳ needs_logistics` | boolean | Items to be sent back to seller. Can be either integrated/non-integrated. |
| `↳↳ amount_before_discount` | float | Order price before discount. |
| `↳↳ user` | object |  |
| `↳↳↳ username` | string | Buyer's nickname, will be masked as "****" if it is a non-integrated return in TW region. |
| `↳↳↳ email` | string | Buyer's email, will be empty if it is a non-integrated return in TW region. |
| `↳↳↳ portrait` | string | Buyer's portrait, will be empty if it is a non-integrated return in TW region. |
| `↳↳ item` | object[] |  |
| `↳↳↳ model_id` | int64 | Shopee's unique identifier for a variation of an item. |
| `↳↳↳ name` | string | Name of item in local language. |
| `↳↳↳ images` | string[] | Image URLs of item. |
| `↳↳↳ amount` | int64 | Amount of this item. |
| `↳↳↳ item_price` | float | The price of item. |
| `↳↳↳ is_add_on_deal` | boolean | To indicate if this item belongs to an addon deal. |
| `↳↳↳ is_main_item` | boolean | To indicate if this item is main item or sub item. True means main item, false means sub item. |
| `↳↳↳ add_on_deal_id` | int64 | The unique identity of an addon deal. |
| `↳↳↳ item_id` | int64 | The id of item. |
| `↳↳↳ item_sku` | string | The sku of item. |
| `↳↳↳ variation_sku` | string | The variation sku of item |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ return_ship_due_date` | timestamp | The due date for buyer to ship order. |
| `↳↳ return_seller_due_date` | timestamp | The due date for seller to deal with this return when buyer have shipped order. |
| `↳↳ negotiation_status` | string | Counter status. See "Data Definition - NegotiationStatus" |
| `↳↳ seller_proof_status` | string | Proof status. See "Data Definition - SellerProofStatus" |
| `↳↳ seller_compensation_status` | string | Compensation status. See "Data Definition - SellerCompensationStatus" |
| `↳↳ return_refund_type` | string | To indicate whether the return is RRBOC (Return/Refund request raised before Order Complete) or RRAOC (Return/Refund request raised after Order Complete). |
| `↳↳ return_solution` | int32 | To indicate the most updated solution of the Return/Refund request (NOTE: this is not the solution during negotiation). Applicable value: - 0: Return and Refund - 1: Refund Only |
| `↳↳ is_seller_arrange` | boolean | To indicate whether the return_sn is using the “Seller Arrange” return method. This would only be True for TW and BR. |
| `↳↳ is_shipping_proof_mandatory` | boolean | To indicate whether uploading shipping proof is mandatory for seller to confirm "Arrange Pickup" when is_seller_arrange = true. |
| `↳↳ return_refund_request_type` | int32 | To indicate the type of return refund request, whether it is a Normal RR request, an In-transit RR request, and a Return on the Spot: 0: Normal RR (RR is raised by the buyer after delivery done / estimated delivery date) 1: In-transit RR (RR is raised by the buyer while item is still in-transit to buyer) 2: Return-on-the-Spot (RR is raised by the driver after buyer rejected parcel at delivery) For more details, see Data Definition- Return Refund Request Type. |
| `↳↳ validation_type` | string | To indicate whether seller or warehouse will expect to receive the return parcel from buyer and validate the condition of the parcel: - seller_validation - warehouse_validation For more details, see Data Definition- ValidationType. |
| `↳↳ is_arrived_at_warehouse` | int32 | [Only for validation_type = warehouse_validation] Indicates the parcel’s check-in status at the warehouse. This field helps sellers quickly determine whether the parcel has arrived at the warehouse or has been rejected. Applicable values: 1: Pending Inbound 2: Rejected 3: Inbound 4: Cancelled |
| `↳↳ follow_up_action_list` | object[] | [Only for validation_type = warehouse_validation] Warehouse handling actions for each item in the parcel. |
| `↳↳↳ item_id` | int64 | Unique identifier of the item. |
| `↳↳↳ model_id` | int64 | Unique identifier of the model under the item. |
| `↳↳↳ qty` | int32 | Quantity of items or models under the same current status. |
| `↳↳↳ current_status` | int32 | Current status for the item/model within the warehouse. Applicable values: 1：Dispose 2：Return to Seller 7：Received and Putaway 8：Return to Buyer 9：Shortage Note: Since Resell is currently applicable only to Failed Delivery parcels, the following values will not be returned for now, and will be returned once Resell becomes applicable to Return Refund parcels in the future: 3：Putaway for Resell 4：Resell Outbound 5：Resell Failed 6：Resell Exit |
| `↳↳↳ related_order_sn_list` | string[] | List of order_sn generated from the Resell process. Returned only when current_status = 4 (Resell Outbound). Note: Since Resell is currently applicable only to Failed Delivery parcels, this field will remain empty for now, and valid values will be returned once Resell becomes applicable to Return Refund parcels in the future. |
| `↳↳↳ resell_failed_next_step` | string | Next step after a Resell failure. Returned only when current_status = 5 (Resell Failed). Note: Since Resell is currently applicable only to Failed Delivery parcels, this field will remain empty for now, and valid values will be returned once Resell becomes applicable to Return Refund parcels in the future. |
| `↳↳ is_partial_quantity_return` | boolean | To indicate whether the return includes items with partial quantities. |
| `↳↳ is_refund_amount_adjusted` | boolean | To indicate whether the actual refund amount is less than the maximum allowable refund. |
| `↳↳ shipping_fee_responsibility` | string | [Only for Local BR Sellers] To indicate the party responsible for the applicable shipping fees before accounting for Shopee Easy Return Programme coverage. Applicable Values: Pending, Seller, Shopee |

Lỗi riêng: Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error.

## v2.returns.get_return_detail
`GET /api/v2/returns/get_return_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

Use this api to get detail information of a return by return sn.

Lịch sử cập nhật: 2026-07-31: promotion_id type change to uint64; 2025-12-19: Add reassessed_request_reason response field; 2025-11-28: Add is_arrived_at_warehouse and follow_up_action_list response fields; 2025-11-11: Added reverse_logistic_status response field; 2025-09-29: Add return_refund_request_type and validation_type response fields

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | The serial number of return. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Amount of the refund. |
| `↳ image` | string[] | Image URLs of return. |
| `↳ buyer_videos` | object[] |  |
| `↳↳ thumbnail_url` | string | The thumbnail url of video |
| `↳↳ video_url` | string | The url of video |
| `↳ reason` | string | Indicates the original return reason submitted by the buyer when initiating the return request. Applicable values: See Data Definition- ReturnReason and Reassessed Request Reason. Note: There may be cases where Shopee Agent updates the return request with a "Reassessed Return Reason" after reviewing more details about the buyer's return request and potentially after requesting evidence from the seller. If the platform updates the return reason during this process, the reassessed outcome will be provided separately in the reassessed_request_reason field. |
| `↳ text_reason` | string | Reason that buyer provide. |
| `↳ reassessed_request_reason` | string | Indicates the return reason reassessed by the platform as more suitable. There may be cases where Shopee Agent updates the return request with a "Reassessed Return Reason" after reviewing more details about the buyer's return request and potentially after requesting evidence from the seller. Applicable values: See Data Definition- ReturnReason and Reassessed Request Reason. If no reassessment has been made, the value will be NONE. |
| `↳ return_sn` | string | The serial number of return. |
| `↳ refund_amount` | float | Amount of the refund. |
| `↳ currency` | string | Currency of the return. |
| `↳ create_time` | timestamp | The time of return create. |
| `↳ update_time` | timestamp | The time of modify return. |
| `↳ status` | string | Enumerated type that defines the current status of the return. Applicable values: See Data Definition- ReturnStatus. |
| `↳ due_date` | timestamp | The last time seller deal with this return. |
| `↳ tracking_number` | string | The tracking number assigned by the shipping carrier for item shipment. |
| `↳ dispute_reason` | string[] | The reason of seller dispute return. While the return has been disputed, this field is useful. Applicable values: See Data Definition- ReturnDisputeReason. |
| `↳ dispute_text_reason` | string[] | The reason that seller provide. While the return has been disputed, this field is useful. |
| `↳ needs_logistics` | boolean | Items to be sent back to seller. Can be either integrated/non-integrated. |
| `↳ amount_before_discount` | float | Order price before discount. |
| `↳ user` | object |  |
| `↳↳ username` | string | Buyer's nickname, will be masked as "****" if it is a non-integrated return in TW region. |
| `↳↳ email` | string | Buyer's email, will be empty if it is a non-integrated return in TW region. |
| `↳↳ portrait` | string | Buyer's portrait, will be empty if it is a non-integrated return in TW region. |
| `↳ item` | object[] |  |
| `↳↳ model_id` | int64 | Shopee's unique identifier for a variation of an item. |
| `↳↳ name` | string | Name of item in local language. |
| `↳↳ images` | string[] | Image URLs of item. |
| `↳↳ amount` | int32 | Amount of this item. |
| `↳↳ item_price` | float | The price of item. |
| `↳↳ is_add_on_deal` | boolean | To indicate if this item belongs to an addon deal. |
| `↳↳ is_main_item` | boolean | To indicate if this item is main item or sub item. True means main item, false means sub item. |
| `↳↳ add_on_deal_id` | int64 | The unique identity of an addon deal. |
| `↳↳ item_id` | int64 | The id of item. |
| `↳↳ item_sku` | string | The sku of item. |
| `↳↳ variation_sku` | string | the variation sku of item |
| `↳↳ refund_amount` | float | item's refund amount. only for shops whitelisted for Partial Qty RR. If not available, refer to item_price |
| `↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳ return_ship_due_date` | timestamp | The due date for buyer to ship order. |
| `↳ return_seller_due_date` | timestamp | The due date for seller to deal with this return when buyer have shipped order. |
| `↳ activity` | object[] |  |
| `↳↳ activity_id` | uint64 | The id of activity. |
| `↳↳ activity_type` | string | The type of activity. |
| `↳↳ original_price` | string | activity's origin price |
| `↳↳ discounted_price` | string | activity's discount price |
| `↳↳ items` | object[] |  |
| `↳↳↳ item_id` | int64 | The id of item. |
| `↳↳↳ variation_id` | int64 | Shopee's unique identifier for a variation of an item. |
| `↳↳↳ quantity_purchased` | int64 | item's quantity purchase |
| `↳↳↳ original_price` | string | item's origin price |
| `↳↳ refund_amount` | string | item's refund amount for bundle deal cases, only for shops whitelisted for Partial Qty RR. |
| `↳ seller_proof` | object |  |
| `↳↳ seller_proof_status` | string | To indicate whether the seller needs to provide evidence when the return status is RETURN_JUDING, RETURN_SELLER_DISPUTE and RETURN_ACCEPTED. Applicable values: See Data Definition- SellerProofStatus. |
| `↳↳ seller_evidence_deadline` | timestamp | To indicate the deadline for submitting the evidence. |
| `↳ seller_compensation` | object |  |
| `↳↳ seller_compensation_status` | string | To indicate whether the seller is eligible for raising a compensation request. See "Data Definition - SellerCompensationStatus" |
| `↳↳ seller_compensation_due_date` | timestamp | To indicate the deadline for requesting the compensation |
| `↳↳ compensation_amount` | float | To indicate the compensation amount that the agent decided |
| `↳↳ compensation_amount_list` | object |  |
| `↳↳↳ compensation_type` | string | To indicate the type of return-related compensation Applicable values: See Data Definition - Compensation Type |
| `↳↳↳ compensation_amount` | float |  |
| `↳ negotiation` | object |  |
| `↳↳ negotiation_status` | string | To indicate whether the seller can negotiate with the buyer. See "Data Definition - NegotiationStatus" |
| `↳↳ latest_solution` | string | To indicate what is the offer solution. See "Data Definition - ReturnSolution" |
| `↳↳ latest_offer_amount` | float | To indicate the refund amount in the latest offer solution |
| `↳↳ latest_offer_creator` | string | To indicate which party made the latest offer |
| `↳↳ counter_limit` | int32 | To indicate the remaining counter limit |
| `↳↳ offer_due_date` | timestamp | To indicate offer_due_date |
| `↳ logistics_status` | string | To indicate the reverse logistics status. See "Data Definition - LogisticsStatus". Note: - This is a legacy field that only reflects the reverse logistics status of Normal RR. To determine whether the RR is a Normal RR, check if return_refund_request_type = 0. - If you need the reverse logistics status for Normal RR, In-transit RR, or Return-on-the-Spot, please use the newly released field reverse_logistic_status instead. |
| `↳ reverse_logistics_status` | string | To indicate the latest reverse logistic status of a return, referring to the current status of the buyer shipping the return parcel back to the validation point (seller or warehouse), including Normal RR, In-transit RR, and Return-on-the-Spot. See "Data Definition - ReverseLogisticsStatus" as status displayed for Normal RR and In-transit RR or Return-on-the-Spot are different. |
| `↳ return_pickup_address` | object | To indicate the buyer's pickup address |
| `↳↳ address` | string | To indicate receiver's address |
| `↳↳ name` | string | To indicate receiver's name |
| `↳↳ phone` | string | To indicate receiver's phone [Only for TW non-integrated channel] Will return "****" when the "virtual_contact_number" is available |
| `↳↳ town` | string | To indicate receiver's town |
| `↳↳ district` | string | To indicate receiver's district |
| `↳↳ city` | string | To indicate receiver's city |
| `↳↳ state` | string | To indicate receiver's state |
| `↳↳ region` | string | To indicate receiver's region |
| `↳↳ zipcode` | string | To indicate receiver's zip code |
| `↳ virtual_contact_number` | string | [Only for TW non-integrated channel] The virtual phone number to contact the recipient. |
| `↳ package_query_number` | string | [Only for TW non-integrated channel] The query number used in virtual phone number calls to contact the recipient of this return. |
| `↳ return_address` | object |  |
| `↳↳ whs_id` | string | To indicate the warehouse id where item will be returned to. Return warehouse address identifier. It should be unique for every warehouse address. Only available when return address is warehouse. For fulfillment by Shopee (FBS) & multi warehouse sellers, R/R orders will be returned back to the nearest warehouse of buyer address instead of going back to only 1 default return address like a normal seller.If it's a normal seller, then the field will be response empty. |
| `↳ return_refund_type` | string | To indicate whether the return is RRBOC (Return/Refund request raised before Order Complete) or RRAOC (Return/Refund request raised after Order Complete). |
| `↳ return_solution` | int32 | To indicate the most updated solution of the Return/Refund request (NOTE: this is not the solution during negotiation). Applicable value: - 0: Return and Refund - 1: Refund Only |
| `↳ is_seller_arrange` | boolean | To indicate whether the return_sn is using the “Seller Arrange” return method. This would only be True for TW and BR. |
| `↳ is_shipping_proof_mandatory` | boolean | To indicate whether uploading shipping proof is mandatory for seller to confirm "Arrange Pickup" when is_seller_arrange = true. |
| `↳ has_uploaded_shipping_proof` | boolean | To indicate whether seller has already uploaded shipping proof for this return. |
| `↳ is_reverse_logistics_channel_integrated` | boolean | To indicate whether the reverse logistic channel type selected is integrated or non-integrated. |
| `↳ reverse_logistics_channel_name` | string | To indicate reverse logistic carrier name. |
| `↳ return_refund_request_type` | int32 | To indicate the type of return refund request, whether it is a Normal RR request, an In-transit RR request, and a Return on the Spot: 0: Normal RR (RR is raised by the buyer after delivery done / estimated delivery date) 1: In-transit RR (RR is raised by the buyer while item is still in-transit to buyer) 2: Return-on-the-Spot (RR is raised by the driver after buyer rejected parcel at delivery) For more details, see Data Definition- Return Refund Request Type. |
| `↳ validation_type` | string | To indicate whether seller or warehouse will expect to receive the return parcel from buyer and validate the condition of the parcel: - seller_validation - warehouse_validation For more details, see Data Definition- ValidationType. |
| `↳ is_arrived_at_warehouse` | int32 | [Only for validation_type = warehouse_validation] Indicates the parcel’s check-in status at the warehouse. This field helps sellers quickly determine whether the parcel has arrived at the warehouse or has been rejected. Applicable values: 1: Pending Inbound 2: Rejected 3: Inbound 4: Cancelled |
| `↳ follow_up_action_list` | object[] | [Only for validation_type = warehouse_validation] Warehouse handling actions for each item in the parcel. |
| `↳↳ item_id` | int64 | Unique identifier of the item. |
| `↳↳ model_id` | int64 | Unique identifier of the model under the item. |
| `↳↳ qty` | int32 | Quantity of items or models under the same current status. |
| `↳↳ current_status` | int32 | Current status for the item/model within the warehouse. Applicable values: 1：Dispose 2：Return to Seller 7：Received and Putaway 8：Return to Buyer 9：Shortage Note: Since Resell is currently applicable only to Failed Delivery parcels, the following values will not be returned for now, and will be returned once Resell becomes applicable to Return Refund parcels in the future: 3：Putaway for Resell 4：Resell Outbound 5：Resell Failed 6：Resell Exit |
| `↳↳ related_order_sn_list` | string[] | List of order_sn generated from the Resell process. Returned only when current_status = 4 (Resell Outbound). Note: Since Resell is currently applicable only to Failed Delivery parcels, this field will remain empty for now, and valid values will be returned once Resell becomes applicable to Return Refund parcels in the future. |
| `↳↳ resell_failed_next_step` | string | Next step after a Resell failure. Returned only when current_status = 5 (Resell Failed). Note: Since Resell is currently applicable only to Failed Delivery parcels, this field will remain empty for now, and valid values will be returned once Resell becomes applicable to Return Refund parcels in the future. |
| `↳ is_partial_quantity_return` | boolean | To indicate whether the return includes items with partial quantities. |
| `↳ is_refund_amount_adjusted` | boolean | To indicate whether the actual refund amount is less than the maximum allowable refund. |
| `↳ shipping_fee_responsibility` | string | [Only for Local BR Sellers] To indicate the party responsible for the applicable shipping fees before accounting for Shopee Easy Return Programme coverage. Applicable Values: Pending, Seller, Shopee |
| `↳ shipping_fee_responsibility_reason` | string | [Only for Local BR Sellers] To indicate the reason corresponding to the Shipping Fee Responsibility. Applicable values: See Data Definition- Shipping Fee Responsibility Reason |

Lỗi riêng: Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error.

## v2.returns.confirm
`POST /api/v2/returns/confirm` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

Confirm refund

Lịch sử cập nhật: 2022-02-23: update example

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | The serial number of return. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ return_sn` | string | The identifier for an API request for error tracking |

Lỗi riêng: Cannot accept your own offer. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error.

## v2.returns.dispute
`POST /api/v2/returns/dispute` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

Dispute return. Support to raise dispute when return_status in REQUESTED / PROCESSING/ACCEPTED

Lịch sử cập nhật: 2025-12-05: Updated description of image_list field; 2024-12-31: Add new image_list request parameter; 2024-05-07: sunset the request filed "dispute_reason", please follow the new flow to raise dispute, may refer https://open.shopee.cn/announcements/883; 2023-12-29: add new request field "dispute_reason_id"; 2022-11-09: add dispute_reason enum values

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | The serial number of return. |
| `email` | string | ✔ | The email address. |
| `dispute_reason_id` | int32 | ✔ | The dispute reason id. Please call v2.returns.get_return_dispute_reason to get it. |
| `image_list` | object[] |  | Determines whether image submission is mandatory for the dispute request - mandatory input field for all dispute reasons except "Did not receive the return product". |
| `↳ module_index` | int32 | ✔ | The module_index of current evidence module returned by get_return_dispute_reason API. |
| `↳ requirement` | string | ✔ | The requirement content of current evidence module returned by get_return_dispute_reason API. |
| `↳ image_url` | string[] | ✔ | The image URLs of current evidence module. It is recommended to pass in the URL returned by convert_image API. |
| `dispute_text_reason` | string |  | The content of dispute reason. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ return_sn` | string | The serial number of return. |
| `↳ msg` | string |  |

Lỗi riêng: Cannot accept your own offer. · All images download fail · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error. · Core server error.

## v2.returns.get_available_solutions
`GET /api/v2/returns/get_available_solutions` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

Get the available solutions offered to buyers.

Lịch sử cập nhật: 2025-08-14: Add min_refund_amount response parameter; 2022-02-23: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | The serial number of return. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ return_sn` | string | The serial number of return. |
| `↳ offer_return_refund` | object |  |
| `↳↳ eligibility` | boolean | To indicate whether ReturnRefund solution is available for sellers to select. |
| `↳↳ refund_amount_adjustable` | boolean | To indicate whether refund is adjustable for ReturnRefund solution. |
| `↳↳ max_refund_amount` | float | The max refund amount for ReturnRefund solution. Returned when refund_amount_adjustable is true. |
| `↳↳ min_refund_amount` | float | The min refund amount for ReturnRefund solution. Returned when refund_amount_adjustable is true. |
| `↳ offer_refund` | object |  |
| `↳↳ eligibility` | boolean | To indicate whether Refund solution is available for sellers to select. |
| `↳↳ refund_amount_adjustable` | boolean | To indicate whether refund is adjustable for Refund solution. |
| `↳↳ max_refund_amount` | float | The max refund amount for Refund solution. Returned when refund_amount_adjustable is true. |
| `↳↳ min_refund_amount` | float | The min refund amount for Refund solution. Returned when refund_amount_adjustable is true. |

Lỗi riêng: Something wrong. Please try later. [20] · Inner http call failed · parse data failed · data not exist · parameter invalid · Query offer info failed. Please try later. · Query proof info failed. Please try later. · Query return info failed. Please try later. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Type of return does not allow seller to offer refund · Shopee is reviewing the case and will get back to you.

## v2.returns.offer
`POST /api/v2/returns/offer` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

v2.returns.offer

Lịch sử cập nhật: 2022-02-23: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | The serial number of return. |
| `proposed_solution` | string | ✔ | The new solution to be offered. See "Data Definition - ReturnSolution" |
| `proposed_adjusted_refund_amount` | float |  | The new refund amount to be offered |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ return_sn` | string | The serial number of return. |

Lỗi riêng: Cannot accept your own offer. · All images download fail · cannot offer refund to buyer when return has ongoing dispute · Something wrong. Please try later. [20] · Inner http call failed · parse data failed · data not exist · parameter invalid · Query offer info failed. Please try later. · Query proof info failed. Please try later. · Query return info failed. Please try later. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

## v2.returns.accept_offer
`POST /api/v2/returns/accept_offer` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

v2.returns.accept_offer

Lịch sử cập nhật: 2022-02-23: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | The serial number of return. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ return_sn` | string | The serial number of return. |

Lỗi riêng: Cannot accept your own offer. · cannot accept refund offer because there is no counter proposal from buyer · cannot accept refund offer because there is no proposal from buyer · Something wrong. Please try later. [20] · Inner http call failed · parse data failed · data not exist · parameter invalid · Query offer info failed. Please try later. · Query proof info failed. Please try later. · Query return info failed. Please try later. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

## v2.returns.convert_image
`POST /api/v2/returns/convert_image` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

Convert a specific format and pictures within 10M into url.

Lịch sử cập nhật: 2022-07-12: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | The serial number of return. |
| `upload_image` | file | ✔ | The proof picture to be uploaded must be within 10MB in size, and the format only supports .jpg, .jpeg, and .png. Only one picture is allowed to be uploaded per request. If multiple pictures are uploaded, only the first picture will be processed. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ url` | string | The link uploaded to the image server can be used with the upload_proof interface. |
| `↳ thumbnail` | string | The image thumbnail. |

Lỗi riêng: The Image Format Not Support · Something wrong. Please try later. [20] · parse data failed · data not exist · parameter invalid · Query offer info failed. Please try later. · Query proof info failed. Please try later. · Query return info failed. Please try later. · image upload fail · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · return sn is illegal

## v2.returns.upload_proof
`POST /api/v2/returns/upload_proof` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

Support sellers to upload evidence, including text and pictures and videos converted into URLs.

Lịch sử cập nhật: 2022-07-12: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | The serial number of return. |
| `photo` | object[] |  |  |
| `↳ url` | string | ✔ | Uploaded proof image link, it is recommended to pass in the return url of api called convert_image. |
| `↳ thumbnail` | string | ✔ | The proof image thumbnail. |
| `description` | string |  | text description in the dispute proof |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. For this API will return null. |

Lỗi riêng: The Image Format Not Support · Something wrong. Please try later. [20] · parse data failed · data not exist · parameter invalid · Query offer info failed. Please try later. · Query proof info failed. Please try later. · Query return info failed. Please try later. · image upload fail · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · no proof · request not from gateway

## v2.returns.query_proof
`GET /api/v2/returns/query_proof` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

Support sellers to query the evidence uploaded through the upload evidence API.

Lịch sử cập nhật: 2022-07-12: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | The serial number of return. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ image` | object[] |  |
| `↳↳ url` | string | The image url in dispute proof. |
| `↳↳ thumbnail` | string | The thumbnail of image. |
| `↳ video` | object[] |  |
| `↳↳ url` | string | The video url in dispute proof. |
| `↳↳ thumbnail` | string | The thumbnail of video |
| `↳ description` | string | The text description in the dispute proof. |

Lỗi riêng: The Image Format Not Support · Something wrong. Please try later. [20] · parse data failed · data not exist · parameter invalid · Query offer info failed. Please try later. · Query proof info failed. Please try later. · Query return info failed. Please try later. · image upload fail · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · no proof · request not from gateway

## v2.returns.get_return_dispute_reason
`GET /api/v2/returns/get_return_dispute_reason` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

To get the dispute return reason.

Lịch sử cập nhật: 2026-04-27: Updated TYPE of dispute_reason from int32 to STRING based on Guanlin's feedback; 2024-12-31: Add new dispute_reason_list response parameter; 2023-12-29: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | The serial number of return. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ dispute_reason_list` | object[] | The dispute_reason and associated evidence list. |
| `↳↳ dispute_reason` | string | The dispute_reason for one specific case. See Data Definition - DisputeReason. |
| `↳↳ dispute_requirement` | string | Indicate the importance of uploading required proof. |
| `↳↳ sample_evidence` | object[] | The URL of sample evidence to upload. |
| `↳↳↳ type` | int32 | The type of sample evidence. Applicable value: - 1: Image |
| `↳↳↳ url` | string | The link of sample evidence. |
| `↳↳↳ thumbnail` | string | The link of the thumbnail of sample evidence. |
| `↳↳ evidence_module_list` | object[] | The associated evidence module list for current dispute reason. |
| `↳↳↳ module_index` | int32 | The index of current evidence module. |
| `↳↳↳ requirement` | string | The specific requirement of current evidence module. |
| `↳↳↳ is_required` | boolean | Indicate if current evidence module is mandatory or not. |

Lỗi riêng: Can't raise dispute because the dispute reason is empty · dispute.request.param.error · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Key: 'XXX' Error:Field validation for 'XX' failed on the 'required' tag · The return_sn you requested was not queried, please check it · return_sn is a required parameter

## v2.returns.cancel_dispute
`POST /api/v2/returns/cancel_dispute` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

Sellers can only cancel compensation disputes, not normal disputes. This means that sellers can only cancel disputes when the return_status is ACCEPTED and the compensation_status is COMPENSATION_REQUESTED.

Lịch sử cập nhật: 2024-12-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | Shopee's unique serial number identifier for a Return Refund request. Note: Sellers can only cancel compensation disputes, not normal disputes. This means that sellers can only cancel disputes when the return_status is ACCEPTED and the compensation_status is COMPENSATION_REQUESTED . |
| `email` | string | ✔ | The operator's email address. For operation record keeping purposes (same as v2.returns.dispute API). |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ return_sn` | string | Shopee's unique serial number identifier for a Return Refund request. |
| `↳ message` | string | To indicate whether the cancel dispute operation is successful or failed. |

Lỗi riêng: Cannot cancel dispute when compensation status is already in COMPENSATION_APPROVED · Cannot cancel dispute when compensation status is already in COMPENSATION_CANCELLED · Cannot cancel dispute when compensation status is not in COMPENSATION_REQUESTED · Cannot cancel dispute when compensation status is not in COMPENSATION_REQUESTED · Cannot cancel dispute when compensation status is already in COMPENSATION_REJECTED · Cannot cancel dispute when return status is not in ACCEPTED · Cannot cancel dispute because return SN is not eligible for compensation dispute · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.returns.get_shipping_carrier
`GET /api/v2/returns/get_shipping_carrier` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

Use this API to get the list of shipping carriers and request parameters needed before calling v2.returns.upload_shipping_proof. Only for TW and BR returns with is_seller_arrange = true.

Lịch sử cập nhật: 2025-09-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | The serial number of return. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ is_shipping_proof_mandatory` | boolean | To indicate whether uploading shipping proof is mandatory for seller to confirm "Arrange Pickup" when is_seller_arrange = true. |
| `↳ has_uploaded_seller_arrange_proof` | boolean | To indicate whether seller has already uploaded shipping proof for this return. |
| `↳ shipping_proof_template` | object[] | To display list of request parameters needed to upload shipping proof. |
| `↳↳ is_tracking_number_required` | boolean | To indicate whether it is mandatory to provide tracking number when uploading shipping proof. |
| `↳↳ is_shipping_image_file_mandatory` | boolean | To indicate whether it is mandatory to provide shipping image file(s) when uploading shipping proof. |
| `↳ reverse_logistics_carrier_list` | object[] | The list of logistics carriers available for sellers to choose. |
| `↳↳ reverse_logistics_carrier_id` | int64 | To indicate the id of the non-integrated reverse logistics channel used by seller. |
| `↳↳ reverse_logistics_carrier_name` | string | To indicate the selected carrier name from the list of carrier names provided. |

Lỗi riêng: No reverse logistics carrier list available · Return not found · Return SN is a required parameter

## v2.returns.upload_shipping_proof
`POST /api/v2/returns/upload_shipping_proof` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

Use this API to upload shipping proof (Only for TW and BR returns with is_seller_arrange = true). This is not to upload evidence for disputes.

Lịch sử cập nhật: 2025-09-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | The serial number of return. |
| `reverse_logistics_carrier_id` | int64 | ✔ | Unique ID of non-integrated reverse logistics channel used by seller. |
| `reverse_logistics_carrier_name` | string |  | Non-integrated reverse logistics channel name used by seller. |
| `tracking_number` | string |  | Tracking number used in seller arrange. Required when is_tracking_number_required = true in v2.returns.get_shipping_carrier. |
| `image_id_list` | object[] |  | List of image_id of shipping proof image. Required when is_shipping_image_file_mandatory = true in v2.returns.get_shipping_carrier. Max: 3. You can call the v2.media.upload_image to upload image and get the image_id, for this scenario, please pass the business = 2 and scene = 1. |
| `↳ image_id` | string |  | Unique image_id. |
| `remarks` | string |  | Optional remarks |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. For this API will return null. |

Lỗi riêng: Tracking Number field cannot be blank · Shipping Proof have already been uploaded · Number of image files exceeds three. Please only upload max three image files · Tracking number should be 5-30 characters · Reverse Logistics carrier ID is invalid · Provided image ID is invalid · Tracking Number is invalid · Reverse Logistics carrier name is a required parameter · Shipping Proof image is a required parameter · New seller arrange flow is not enabled · Tracking number should not contain special characters; for eg. !; @; $; %; &; * · Return not found · Return SN is a required parameter · Reverse Logistics carrier ID is a required parameter · Tracking Number is a required parameter

## v2.returns.get_reverse_tracking_info
`GET /api/v2/returns/get_reverse_tracking_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Customer Service, Swam ERP

Get reverse and post-return logistics information of return request. For Normal RR, return complete reverse logistics information, for In-transit RR and Return-on-the-Spot, only return latest reverse logistics status, without providing complete reverse logistics information. For seller_validation, only one segment of reverse (buyer to seller), use tracking_info, for warehouse_validation, two segment of reverse (buyer to warehouse and warehouse to seller), use post_return_logistics_tracking_info.

Lịch sử cập nhật: 2025-10-11: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `return_sn` | string | ✔ | Shopee's unique identifier for a return/refund request (serial number of return). |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ return_sn` | string | Shopee's unique identifier for a return/refund request (serial number of return). |
| `↳ return_refund_request_type` | int32 | To indicate the type of return refund request, whether it is a Normal RR request, an In-transit RR request, and a Return on the Spot: 0: Normal RR (RR is raised by the buyer after delivery done / estimated delivery date) 1: In-transit RR (RR is raised by the buyer while item is still in-transit to buyer) 2: Return-on-the-Spot (RR is raised by the driver after buyer rejected parcel at delivery) For more details, see Data Definition- Return Refund Request Type. |
| `↳ validation_type` | string | To indicate whether seller or warehouse will expect to receive the return parcel from buyer and validate the condition of the parcel: - seller_validation - warehouse_validation For more details, see Data Definition- ValidationType. |
| `↳ reverse_logistics_status` | string | To indicate the latest reverse logistic status of a return, referring to the current status of the buyer shipping the return parcel back to the validation point (seller or warehouse), including Normal RR, In-transit RR, and Return-on-the-Spot. See "Data Definition - ReverseLogisticsStatus" as status displayed for Normal RR and In-transit RR or Return-on-the-Spot are different. Note: If validation_type = seller_validation , there is only one segment of reverse logistics (The buyer ships the return parcel directly back to the seller). Please use the fields reverse_logistics_status, reverse_logistics_update_time, tracking_number, and tracking_info to obtain the reverse logistics tracking inform |
| `↳ reverse_logistics_update_time` | timestamp | The last update time of the reverse logistics status including Normal RR, In-transit RR, and Return-on-the-Spot. Note: If validation_type = seller_validation , there is only one segment of reverse logistics (The buyer ships the return parcel directly back to the seller). Please use the fields reverse_logistics_status, reverse_logistics_update_time, tracking_number, and tracking_info to obtain the reverse logistics tracking information. |
| `↳ estimated_delivery_date_max` | timestamp | The maximum estimated delivery date for the reverse logistics. This is calculated by Shopee Logistics Services once buyer ships out if there is historical tracking data available from third party logistics provider. Note: Only available for Normal RR with integrated reverse logistics. |
| `↳ estimated_delivery_date_min` | timestamp | The minimum estimated delivery date for the reverse logistics. This is calculated by Shopee Logistics Services once buyer ships out if there is historical tracking data available from third party logistics provider. Note: Only available for Normal RR with integrated reverse logistics. |
| `↳ collection_pin_code` | string | The collection Pin Code to enter for seller to collect parcel in collection point or locker. Note: Only available for TW region . |
| `↳ tracking_number` | string | The tracking number for the reverse logistics (the logistics tracking number provided when the buyer ships the item back). Note: - Only available for Normal RR with integrated reverse logistics. - If validation_type = seller_validation , there is only one segment of reverse logistics (The buyer ships the return parcel directly back to the seller) . Please use the fields reverse_logistics_status, reverse_logistics_update_time, tracking_number, and tracking_info to obtain the reverse logistics tracking information. |
| `↳ tracking_info` | object[] | The detailed tracking information list for the reverse logistics. Note: - Only available for Normal RR with integrated reverse logistics , with the tracking information pushed by third party logistics provider to Shopee. - If validation_type = seller_validation , there is only one segment of reverse logistics (The buyer ships the return parcel directly back to the seller) . Please use the fields reverse_logistics_status, reverse_logistics_update_time, tracking_number, and tracking_info to obtain the reverse logistics tracking information. |
| `↳↳ update_time` | timestamp | The timestamps when reverse logistics info has been updated for Normal RR, pushed from third party logistics provider to Shopee. |
| `↳↳ tracking_description` | string | The description of reverse logistics tracking info for Normal RR, pushed by third party logistics provider to Shopee. |
| `↳↳ epop_image_list` | string[] | Image URLs of electronic proof of pickup (ePOP) after return parcel has been picked up from the buyer for Normal RR. |
| `↳↳ epod_image_list` | string[] | Image URLs of electronic proof of delivery (ePOD) after return parcel has been delivered to the seller for Normal RR. |
| `↳ post_return_logistics_status` | string | Post-return logistics status, referring to the current status of the warehouse shipping the return parcel back to the seller in warehouse validation mode. See "Data Definition - Post Return Logistics Status". Note: - Only available for Normal RR with return_solution = 0 (Return and Refund) and validation_type = warehouse_validation , and the warehouse ships the return parcel back to seller using integrated reverse logistics. - If validation_type = warehouse_validation AND the warehouse uses an integrated logistics channel to ship the return parcel back to the seller, there are two segments of reverse logistics : - The buyer first ships the return parcel back to the warehouse. Use the fields  |
| `↳ post_return_logistics_update_time` | timestamp | The last update time of the post-return logistics status where warehouse sends return parcel from warehouse to seller. Note: - Only available for Normal RR with return_solution = 0 (Return and Refund) and validation_type = warehouse_validation , and the warehouse ships the return parcel back to seller using integrated reverse logistics. - If validation_type = warehouse_validation AND the warehouse uses an integrated logistics channel to ship the return parcel back to the seller, there are two segments of reverse logistics: - The buyer first ships the return parcel back to the warehouse. Use the fields reverse_logistics_status, reverse_logistics_update_time, tracking_number, and tracking_info |
| `↳ rts_tracking_number` | string | The tracking number for the post-return logistics (the logistics tracking number used when the warehouse ships the parcel back to the seller). RTS stands for "Return to Seller". Note: - Only available for Normal RR with return_solution = 0 (Return and Refund) and validation_type = warehouse_validation , and the warehouse ships the return parcel back to seller using integrated reverse logistics. - If validation_type = warehouse_validation AND the warehouse uses an integrated logistics channel to ship the return parcel back to the seller, there are two segments of reverse logistics: - The buyer first ships the return parcel back to the warehouse. Use the fields reverse_logistics_status, revers |
| `↳ post_return_logistics_tracking_info` | object[] | Only available for Normal RR with return_solution = 0 (Return and Refund) and validation_type = warehouse_validation , and the warehouse ships the return parcel back to seller using integrated reverse logistics. In this scenario, the tracking logistics from warehouse to seller is called "post-return logistics", with the tracking information pushed by third party logistics provider to Shopee. Note: - If validation_type = warehouse_validation AND the warehouse uses an integrated logistics channel to ship the return parcel back to the seller, there are two segments of reverse logistics: - The buyer first ships the return parcel back to the warehouse. Use the fields reverse_logistics_status, rev |
| `↳↳ update_time` | timestamp | The timestamps when reverse logistics info has been updated for Normal RR from warehouse to seller, pushed from third party logistics provider to Shopee. |
| `↳↳ tracking_description` | string | The description of reverse logistics tracking info for Normal RR from warehouse to seller, pushed by third party logistics provider to Shopee. These would match the tracking description displayed to sellers on Seller Center return/refund detail page. |
| `↳↳ epop_image_list` | string[] | Image URLs of electronic proof of pickup (ePOP) after return parcel has been picked up from the warehouse for Normal RR with warehouse validation. |
| `↳↳ epod_image_list` | string[] | Image URLs of electronic proof of delivery (ePOD) after return parcel has been delivered to the seller for Normal RR with warehouse validation. |

Lỗi riêng: Failed to get reverse logistics tracking info · Failed to get order fulfilment group · Failed to get post return logistics data · Failed to get return logistics status audit · The Return SN does not have reverse logistics status · Return not found · Return SN is a required parameter

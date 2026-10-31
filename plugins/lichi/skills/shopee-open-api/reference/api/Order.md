# Module Order (22 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.order.get_order_list
`GET /api/v2/order/get_order_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Customer Service, Brand Membership, Ads Service, Swam ERP, Livestream Management, Affiliate Marketing Solution Management, Payment Service Provider

Use this api to search orders. You may also filter them by status, if needed.

Lịch sử cập nhật: 2025-04-23: Change the cursor input parameter.; 2024-07-03: add a new response field "booking_sn" for advance fulfilment order.; 2023-06-16: add a new field "request_order_status_pending" to control if wanna response "PENDING" status order; 2023-05-15: update the API description.; 2021-06-11: Update INVOICE_PENDING order status.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `time_range_field` | string | ✔ | The kind of time_from and time_to. Available value: create_time, update_time. |
| `time_from` | timestamp | ✔ | The time_from and time_to fields specify a date range for retrieving orders (based on the time_range_field). The time_from field is the starting date range. The maximum date range that may be specified with the time_from and time_to fields is 15 days. |
| `time_to` | timestamp | ✔ | The time_from and time_to fields specify a date range for retrieving orders (based on the time_range_field). The time_from field is the starting date range. The maximum date range that may be specified with the time_from and time_to fields is 15 days. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data.The limit of page_size if between 1 and 100. |
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. The default is empty. If the data is more than one page, the offset can be some entry to start the next call. |
| `order_status` | string |  | The order_status filter for retriveing orders and each one only every request. Available value: UNPAID/READY_TO_SHIP/PROCESSED/SHIPPED/COMPLETED/IN_CANCEL/CANCELLED/INVOICE_PENDING |
| `response_optional_fields` | string |  | Optional fields in response. Available value: order_status. |
| `request_order_status_pending` | boolean |  | Compatible parameter during migration period, send True will let API support PENDING status, send False or don’t send will fallback to old logic. |
| `logistics_channel_id` | int32 |  | The identity of logistic channel. Valid only for BR. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ more` | boolean | This is to indicate whether the order list is more than one page. If this value is true, you may want to continue to check next page to retrieve orders. |
| `↳ order_list` | object[] |  |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ order_status` | string | The order_status filter for retriveing orders and each one only every request. Available value: UNPAID/READY_TO_SHIP/PROCESSED/SHIPPED/COMPLETED/IN_CANCEL/CANCELLED |
| `↳↳ booking_sn` | string | Return by default. Shopee's unique identifier for a booking. Only returned for advance fulfilment matched order only. |
| `↳ next_cursor` | string | If more is true, you should pass the next_cursor in the next request as cursor. The value of next_cursor will be empty string when more is false. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Start time must be earlier than end time and diff in 15days. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.get_order_detail
`GET /api/v2/order/get_order_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Accounting And Finance, Customer Service, Brand Membership, Ads Service, Swam ERP, Livestream Management, Affiliate Marketing Solution Management, Payment Service Provider

Use this api to get order detail.

Rate limit: [0,0,0]

Lịch sử cập nhật: 2026-10-22: Add "imei_list" into "item_list" as response param; 2026-08-27: Add "is_fulfillment_mapping""bundle_sku_id""components" as Response Parameter; 2026-08-06: Add "status" and "pending_reason" under "invoice_data"; 2026-07-17: add "line_item_id" as Response Parameter; 2026-07-01: add affiliate_sample_type

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn_list` | string | ✔ | The set of order_sn. If there are multiple order_sn, you need to use English comma to connect them. limit [1,50] |
| `request_order_status_pending` | boolean |  | Compatible parameter during migration period, send True will let API support PENDING status and return pending_terms, send False or don’t send will fallback to old logic |
| `response_optional_fields` | string |  | a response fields you want to get. Please select from the below response parameters. If you input an object field, all the params under it will be included automatically in the response. If there are multiple response fields you want to get, you need to use English comma to connect them. Available values: buyer_user_id,buyer_username,estimated_shipping_fee,recipient_address,actual_shipping_fee ,goods_to_declare,note,note_update_time,item_list,pay_time,dropshipper, dropshipper_phone,split_up,buyer_cancel_reason,cancel_by,cancel_reason,actual_shipping_fee_confirmed,buyer_cpf_id,fulfillment_flag,pickup_done_time,package_list,shipping_carrier,payment_method,total_amount,buyer_username,invoice_da |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ order_list` | object[] | The list of orders. |
| `↳↳ order_sn` | string | Return by default. Shopee's unique identifier for an order. |
| `↳↳ region` | string | Return by default. The two-digit code representing the region where the order was made. |
| `↳↳ currency` | string | Return by default. The three-digit code representing the currency unit for which the order was paid. |
| `↳↳ cod` | boolean | Return by default. This value indicates whether the order was a COD (cash on delivery) order. |
| `↳↳ total_amount` | float | The total amount paid by the buyer for the order. This amount includes the total sale price of items, shipping cost beared by buyer; and offset by Shopee promotions if applicable. This value will only return after the buyer has completed payment for the order. |
| `↳↳ pending_terms` | string[] | The list of pending terms. Applicable values: - SYSTEM_PENDING: Under Shopee internal processing. - KYC_PENDING: Under KYC checking (TW CB order only). - ARRANGE_SHIPMENT_PENDING: Temporarily held due to 3PL capacity constraints. |
| `↳↳ pending_description` | string[] | The value of this field is the description of pending reason corresponding with pending terms. Applicable values: - For SYSTEM_PENDING: Order is being processed by Shopee. - For KYC_PENDING: Order is pending buyer TW KYC pre-authorization. - For ARRANGE_SHIPMENT_PENDING: Allocating delivery resources due to high order volume. Label print will be available within 4 days after buyer paid. |
| `↳↳ order_status` | string | Return by default. Enumerated type that defines the current status of the order. |
| `↳↳ shipping_carrier` | string | The logistics service provider that the buyer selected for the order to deliver items. Note: If logistics_channel_id is 90021, 90025 or 90026, service_code will be appended, e.g., Entrega Turbo - M1020. |
| `↳↳ payment_method` | string | The payment method that the buyer selected to pay for the order. Applicable values: See Data Definition- Payment Methods. |
| `↳↳ estimated_shipping_fee` | float | The estimated shipping fee is an estimation calculated by Shopee based on specific logistics courier's standard. |
| `↳↳ message_to_seller` | string | Return by default. Message to seller. |
| `↳↳ create_time` | timestamp | Return by default. Timestamp that indicates the date and time that the order was created. |
| `↳↳ update_time` | timestamp | Return by default. Timestamp that indicates the last time that there was a change in value of order, such as order status changed from 'Paid' to 'Completed'. |
| `↳↳ days_to_ship` | int32 | Return by default. Shipping preparation time set by the seller when listing item on Shopee. |
| `↳↳ ship_by_date` | timestamp | Return by default. The deadline to ship out the parcel. |
| `↳↳ buyer_user_id` | int64 | The user id of buyer of this order, will be empty if it is a non-integrated order in TW region. |
| `↳↳ buyer_username` | string | The name of buyer, will be masked as "****" if it is a non-integrated order in TW region. |
| `↳↳ recipient_address` | object | This object contains detailed breakdown for the recipient address. Different parameters might be masked according to each market and kind of seller. For TW region integrated channel orders will be all masked as "****". More details may refer the announcement. |
| `↳↳↳ name` | string | Recipient's name for the address. |
| `↳↳↳ phone` | string | Recipient's phone number input when order was placed. [Only for TW non-integrated channel] Will return "****" when the "virtual_contact_number" is available |
| `↳↳↳ town` | string | The town of the recipient's address. Whether there is a town will depend on the region and/or country. |
| `↳↳↳ district` | string | The district of the recipient's address. Whether there is a district will depend on the region and/or country. |
| `↳↳↳ city` | string | The city of the recipient's address. Whether there is a city will depend on the region and/or country. |
| `↳↳↳ state` | string | The state/province of the recipient's address. Whether there is a state/province will depend on the region and/or country. |
| `↳↳↳ region` | string | The two-digit code representing the region of the Recipient. |
| `↳↳↳ zipcode` | string | Recipient's postal code. |
| `↳↳↳ full_address` | string | The full address of the recipient, including country, state, even street, and etc. |
| `↳↳↳ geolocation` | object | Geolocation info. Only available for logistics_channel_id 90026. |
| `↳↳↳↳ latitude` | float | Latitude. |
| `↳↳↳↳ longitude` | float | Longitude. |
| `↳↳ actual_shipping_fee` | float | The actual shipping fee of the order if available from external logistics partners. |
| `↳↳ goods_to_declare` | boolean | Only work for cross-border order.This value indicates whether the order contains goods that are required to declare at customs. "T" means true and it will mark as "T" on the shipping label; "F" means false and it will mark as "P" on the shipping label. This value is accurate ONLY AFTER the order trackingNo is generated, please capture this value AFTER your retrieve the trackingNo. |
| `↳↳ note` | string | The note seller made for own reference. |
| `↳↳ note_update_time` | timestamp | Update time for the note. |
| `↳↳ item_list` | object[] | This object contains the detailed breakdown for the result of this API call. |
| `↳↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳↳ item_name` | string | The name of the item. |
| `↳↳↳ item_sku` | string | A item SKU (stock keeping unit) is an identifier defined by a seller, sometimes called parent SKU. Item SKU can be assigned to an item in Shopee Listings. |
| `↳↳↳ model_id` | int64 | ID of the model that belongs to the same item. |
| `↳↳↳ model_name` | string | Name of the model that belongs to the same item. A seller can offer models of the same item. For example, the seller could create a fixed-priced listing for a t-shirt design and offer the shirt in different colors and sizes. In this case, each color and size combination is a separate model. Each model can have a different quantity and price. |
| `↳↳↳ model_sku` | string | A model SKU (stock keeping unit) is an identifier defined by a seller. It is only intended for the seller's use. Many sellers assign a SKU to an item of a specific type, size, and color, which are models of one item in Shopee Listings. |
| `↳↳↳ model_quantity_purchased` | int32 | The number of identical items purchased at the same time by the same buyer from one listing/item. |
| `↳↳↳ is_fulfillment_mapping` | boolean | Flag indicating whether the item contains any bundle items configured with Fulfillment Mapping (FFM). Returns 'true' if the item uses FFM logic, 'false' otherwise. Field will only be returned if shop is whitelisted. |
| `↳↳↳ bundle_sku_id` | string | The unique identifier (SKU ID) of the front-facing Bundle SKU purchased by the buyer on Shopee. Field will only be returned if shop is whitelisted and is_fulfillment_mapping returns true. |
| `↳↳↳ components` | object[] | List of underlying Parent SKUs (component level) associated with the mapped Bundle SKU, used by WMS/ERP for physical picking and fulfillment. If is_fulfillment_mapping returns 'false', this array will not be returned. Array will only be returned if shop is whitelisted and is_fulfillment_mapping returns true. |
| `↳↳↳↳ parent_sku_id` | string | The unique identifier (SKU ID) of the underlying physical component item (Parent SKU). |
| `↳↳↳↳ barcode_upc` | string | The physical barcode or UPC of the Parent SKU, used for scanning and inventory picking in the warehouse. |
| `↳↳↳↳ quantity` | int64 | The mapping ratio/quantity of this specific Parent SKU required for ONE unit of the Bundle SKU (e.g., if Bundle A contains 2 units of Parent SKU B, quantity = 2) |
| `↳↳↳↳ warehouse_id` | string | The ID of the warehouse where the Parent SKU component is located/stored. |
| `↳↳↳↳ mapping_type` | string | The structure/type of mapping defined for the bundle. Available values: 1: Group 2: Lucky bag 3: Mapping List |
| `↳↳↳ model_original_price` | float | The original price of the item in the listing currency. |
| `↳↳↳ model_discounted_price` | float | The after-discount price of the item in the listing currency. If there is no discount, this value will be same as that of model_original_price. In case of bundle deal item, this value will return 0 as by design bundle deal discount will not be breakdown to item/model level. Due to technical restriction, the value will return the price before bundle deal if we don't configure it to 0. Please call GetEscrowDetails if you want to calculate item-level discounted price for bundle deal item. |
| `↳↳↳ wholesale` | boolean | This value indicates whether buyer buy the order item in wholesale price. |
| `↳↳↳ weight` | float | The weight of the item |
| `↳↳↳ add_on_deal` | boolean | To indicate if this item belongs to an addon deal. |
| `↳↳↳ main_item` | boolean | To indicate if this item is main item or sub item. True means main item, false means sub item. |
| `↳↳↳ add_on_deal_id` | int64 | A unique ID to distinguish groups of items in Cart, and Order. (e.g. AddOnDeal) |
| `↳↳↳ promotion_type` | string | Available type：product_promotion, flash_sale, bundle_deal, add_on_deal_main, add_on_deal_sub. For items which attend multiple promotions will only show one promotion, the order of priority is: bundle_deal > add_on_deal_main > add_on_deal_sub > product_promotion >flash_sale |
| `↳↳↳ promotion_id` | int64 | The ID of the promotion. |
| `↳↳↳ order_item_id` | int64 | The identify of order item. |
| `↳↳↳ line_item_id` | int64 | The identity of order item. In case the order item is a bundle deal, this value will be unique to distinguish the order item |
| `↳↳↳ promotion_group_id` | int32 | The identify of product promotion. |
| `↳↳↳ image_info` | object | Image info of the product. |
| `↳↳↳↳ image_url` | string | The image url of the product. Default to be variation image, if the model does not have a variation image, will use an item main image instead. |
| `↳↳↳ product_location_id` | string | The fulfilment warehouse ID(s) of the items in the order. (Multi-Warehouse sellers only) |
| `↳↳↳ is_prescription_item` | boolean | To indicate if this item is prescription item. Only for PH, TH, ID local shop. |
| `↳↳↳ error_in_fetching_is_prescription_item` | boolean | To indicate if there was an error when validating whether this item is prescription. Default false. If is_prescription_item=false and this field is true, the item's prescription status is uncertain (label service call failed). Only for TH, PH, ID local shop. |
| `↳↳↳ consultation_id` | string | An identifier of teleconsultation session which buyer did to order this item. Empty if item is not ordered through teleconsultation session |
| `↳↳↳ is_b2c_owned_item` | boolean | determine if item is B2C_shop_item It should be ` is_b2c_shop_item ` but it was a bug from dev. Then now it's is_b2c_owned_item |
| `↳↳↳ promotion_list` | object[] |  |
| `↳↳↳↳ promotion_type` | string | Indicates the type of item or package level promotion applied to a product. Each item can be associated with at most one item promotion and one package promotion at a time. Item Promotions: low_price_promotion deep_discount platform_sale seller_discount flash_sale wholesale welcome_package_free_gift brand_flash_sale in_shop_flash_sale synced_promo platform_streaming_price seller_streaming_price exclusive_streamer_price price_bidding_with_rebate price_bidding_without_rebate seller_advisor_price selling_price settlement_price campaign_settlement_price local_sip_settlement_price platform_exclusive_price seller_exclusive_price seller_member_exclusive_sku item_price order_sync_price Package Promo |
| `↳↳↳↳ promotion_id` | int64 | Represents the unique identifier of a specific promotion applied to an item. Each promotion_id corresponds to a distinct promotion rule or campaign, defined under a particular promotion_type. The value is expressed in a numeric string format. |
| `↳↳↳ hot_listing_item` | boolean | [Only for PH,TH,VN,MY,BR,TW] True if the item is hot listing. |
| `↳↳↳ active_qty` | int32 | The quantity of the item model that remains active in the order and is still expected to be fulfilled. |
| `↳↳↳ cancel_requested_qty` | int32 | The quantity of the item model that is currently under a cancellation request but has not yet reached the final cancelled status. |
| `↳↳↳ cancelled_qty` | int32 | The quantity of the item model that has already been successfully cancelled. |
| `↳↳↳ return_requested_qty` | int32 | The quantity of the item model that is currently under a return/refund request. |
| `↳↳↳ returned_qty` | int32 | The quantity of the item model that has already been successfully returned through the return/refund process. |
| `↳↳↳ imei_list` | string[] | IMEI (International Mobile Equipment Identity) assigned to the item. Only for certain FBS shops. If item does not have IMEl or IMEl parcel is not yet outbound from warehouse, return empty. |
| `↳↳ pay_time` | timestamp | The time when the order status is updated from UNPAID to PAID. This value is NULL when order is not paid yet. |
| `↳↳ dropshipper` | string | For Indonesia orders only. The name of the dropshipper. |
| `↳↳ dropshipper_phone` | string | The phone number of dropshipper, could be empty. |
| `↳↳ split_up` | boolean | To indicate whether this order is split to fullfil order(forder) level. Call GetForderInfo if it's "true". |
| `↳↳ buyer_cancel_reason` | string | Cancel reason from buyer, could be empty. |
| `↳↳ cancel_by` | string | Could be one of buyer, seller, system or Ops. |
| `↳↳ cancel_reason` | string | Use this field to get reason for buyer, seller, and system cancellation. |
| `↳↳ actual_shipping_fee_confirmed` | boolean | Use this filed to judge whether the actual_shipping_fee is confirmed. |
| `↳↳ buyer_cpf_id` | string | Buyer's CPF number for taxation and invoice purposes. Only for Brazil order. |
| `↳↳ fulfillment_flag` | string | Use this field to indicate the order is fulfilled by shopee or seller. Applicable values: fulfilled_by_shopee, fulfilled_by_cb_seller, fulfilled_by_local_seller. |
| `↳↳ pickup_done_time` | timestamp | The timestamp when pickup is done. |
| `↳↳ package_list` | object[] | The list of package under an order |
| `↳↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳↳ logistics_status` | string | The Shopee logistics status for the order. Applicable values: See Data Definition-LogisticsStatus. |
| `↳↳↳ logistics_channel_id` | int64 | The identity of logistic channel. |
| `↳↳↳ shipping_carrier` | string | The logistics service provider that the buyer selected for the order to deliver items. Note: If logistics_channel_id is 90021, 90025 or 90026, service_code will be appended, e.g., Entrega Turbo - M1020. |
| `↳↳↳ allow_self_design_awb` | boolean | To indicate whether the package allows for self-designed AWB, if allow_self_design_awb returns false, it means that the package does not allow for self-designed AWB and only the system-AWB can be used. |
| `↳↳↳ item_list` | object[] | The lis of items. |
| `↳↳↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳↳↳ model_id` | int64 | Shopee's unique identifier for a model. |
| `↳↳↳↳ model_quantity` | int32 | The number of identical items/variations purchased at the same time by the same buyer from one listing/item. |
| `↳↳↳↳ order_item_id` | int64 | The identify of order item. For items in one same bundle deal promotion, the order_item_id should share the same id, such as 1,2. For items not in bundle deal promotion, the order_item_id should be the same as item_id. |
| `↳↳↳↳ promotion_group_id` | int32 | The identify of product promotion. |
| `↳↳↳↳ product_location_id` | string | The warehouse ID of the item. |
| `↳↳↳ parcel_chargeable_weight` | int | display weight used to calculate ASF for this parcel |
| `↳↳↳ group_shipment_id` | int64 | The common identifier for multiple orders combined in the same parcel. |
| `↳↳↳ virtual_contact_number` | string | [Only for TW non-integrated channel] The virtual phone number to contact the recipient. |
| `↳↳↳ package_query_number` | string | [Only for TW non-integrated channel] The query number used in virtual phone number calls to contact the recipient of this package. |
| `↳↳↳ sorting_group` | string | [Only for TW 30029 channel] This field indicate the sorting group value of the package. This field is only available for logistics_channel_id = 30029 and after the package has been arranged for shipment. |
| `↳↳ invoice_data` | object | The invoice data of the order. |
| `↳↳↳ number` | string | The number of the invoice. |
| `↳↳↳ series_number` | string | The series number of the invoice. |
| `↳↳↳ access_key` | string | The access key of the invoice. |
| `↳↳↳ issue_date` | timestamp | The issue date of the invoice. |
| `↳↳↳ total_value` | float | The total value of the invoice. |
| `↳↳↳ products_total_value` | float | The products total value of the invoice. |
| `↳↳↳ tax_code` | string | The tax code for the invoice. |
| `↳↳↳ status` | string | The invoice statuses should be: - valid (The invoice sent is valid) - pending (System is waiting to receive the invoice) |
| `↳↳↳ pending_reason` | string | It's the failed reason if status is pending |
| `↳↳ checkout_shipping_carrier` | string | For non masking order, the logistics service provider that the buyer selected for the order to deliver items. For masking order, the logistics service type that the buyer selected for the order to deliver items. |
| `↳↳ reverse_shipping_fee` | float | Shopee charges the reverse shipping fee for the returned order.The value of this field will be non-negative. |
| `↳↳ order_chargeable_weight_gram` | int | display weight used to calculate ASF for this order |
| `↳↳ prescription_check_status` | int | Prescription check status. For ID, PH whitelisted sellers, the applicable values: 0: NONE 1: PASSED 2: FAILED For TH whitelisted sellers, the applicable values: 0: NONE 1: PASSED |
| `↳↳ pharmacist_name` | string | Name of the Pharmacist for Prescription Order. |
| `↳↳ prescription_images` | string[] | Return prescription images of this order, only for ID and PH whitelist sellers. Please add the prefix to review: for ID: https://cf.shopee.co.id/file/+prescription_image for PH: https://cf.shopee.ph/file/+prescription_image |
| `↳↳ prescription_approval_time` | timestamp | Time of when the prescription is approved. |
| `↳↳ prescription_rejection_time` | timestamp | Time of when the prescription is rejected. |
| `↳↳ prescription_reject_reason` | string | Return the reason why a prescription is rejected. If there is no rejection reason, return empty.Only for ID and PH whitelist sellers |
| `↳↳ is_buyer_shop_collection` | boolean | To indicate if this order is buyer self collection at store order |
| `↳↳ buyer_proof_of_collection` | string[] | The image url of the buyer self collection at the store. |
| `↳↳ edt_from` | timestamp | Earliest estimated delivery date of orders (only available for BR region) |
| `↳↳ edt_to` | timestamp | Latest estimated delivery time of orders (only available for BR region) |
| `↳↳ booking_sn` | string | Return by default. Shopee's unique identifier for a booking. Only returned for advance fulfilment matched order only. |
| `↳↳ advance_package` | boolean | Indicate whether order will be fulfilled using advance fulfilment stock or not. If value is true, order will be matched with a booking and seller should not arrange shipment. |
| `↳↳ return_request_due_date` | timestamp | This field represents the deadline for buyers to initiate returns and refunds after order is completed. The “return_request_due_date” response parameter will be returned if the requested order meets ALL the conditions below: - The status of the order is COMPLETED - The return refund eligibility of the order is true If you have any questions related to the function of "returns and refunds after order is completed," please refer to the following link: https://seller.shopee.tw/edu/article/18474 |
| `↳↳ payment_info` | object[] | [Only for BR] List of payment information, to follow NT 2025.001 (BR government invoice rules). |
| `↳↳↳ payment_method` | string | [Only for BR] Payment method used in the order, such as Credit Card, Debit Card, Pix, etc. |
| `↳↳↳ payment_processor_register` | string | [Only for BR] CNPJ of the payment processor handling the transaction. |
| `↳↳↳ card_brand` | string | [Only for BR] Card brand for credit or debit transactions, such as VISA, MASTER, etc. Empty string for Pix payments. |
| `↳↳↳ transaction_id` | string | [Only for BR] Payment authorization code generated by the bank or payment processor to validate the transaction. |
| `↳↳↳ payment_amount` | float | [Only for BR] Amount paid by the corresponding payment method. |
| `↳↳ hot_listing_order` | boolean | [Only for PH,TH,VN,MY,BR,TW] True if the order includes hot listing item. |
| `↳↳ is_international` | boolean | [Only for BR] Indicate if the order is SIP order. This field will only be returned if international_label is included in response_optional_field in the request. |
| `↳↳ can_full_cancel_order` | boolean | Indicates whether the order can be full cancelled: - If this value is true, seller can cancel the entire order - If the value is false, full order cancellation is not available for the order |
| `↳↳ can_partial_cancel_order` | boolean | Indicates whether the order is eligible for partial cancellation. This value is determined by both the system eligibility check and the buyer’s out-of-stock handling preference. - If this value is true, seller can cancel selected out-of-stock item quantities while continuing to fulfill the remaining items. - If this value is false, partial cancellation is not allowed. |
| `↳↳ buyer_preference_for_partial_cancellation` | int64 | Indicates the buyer’s preference for handling out-of-stock items in the order. Applicable values: 0 = Ship Available Items Only (The buyer allows the seller to cancel unavailable items and continue shipping the remaining available items) 1 = Cancel The Entire Order (The buyer does not allow partial cancellation. If any item is unavailable, the seller should cancel the entire order instead) |
| `↳↳ affiliate_sample_type` | int32 | Indicates that this order is a refundable sample order. Applicable values: 0 = Order is not a refundable sample order 1 = Order is a refundable sample order |

Lỗi riêng: Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.get_shipment_list
`GET /api/v2/order/get_shipment_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get order list which order_status is READY_TO_SHIP or RETRY_SHIP to start process the whole shipping progress.

Lịch sử cập nhật: 2021-06-02: Update the API define

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data.The limit of page_size if between 1 and 100. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ order_list` | object[] | The list of shipment orders |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order |
| `↳ more` | boolean | This is to indicate whether the order list is more than one page. If this value is true, you may want to continue to check next page to retrieve orders. |
| `↳ next_cursor` | string | If more is true, you should pass the next_cursor in the next request as cursor. The value of next_cursor will be empty string when more is false. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.search_package_list
`POST /api/v2/order/search_package_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this API to search the list of packages that have not been SHIPPED to proceed arranging shipment, and it supports various filters and sort fields.

Lịch sử cập nhật: 2025-12-26: Add order_type, is_pre_order, shipping_priority request parameters and is_shipment_arranged response parameter; 2025-10-11: Update sorting group with "0: All" value in request parameters; 2025-07-07: Add new request and response field "sorting_group"; 2025-02-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `filter` | object |  |  |
| `↳ package_status` | int32 |  | Use this field to filter the packages of specific status. Applicable values: 0: All 1: Pending 2: ToProcess 3: Processed Default value = 2 (ToProcess) |
| `↳ product_location_ids` | string[] |  | List of product_location_id. Use this field to filter the packages under specific warehouses. |
| `↳ logistics_channel_ids` | int32[] |  | List of logistics_channel_id. Use this field to filter the packages under specific logistics channels. |
| `↳ fulfillment_type` | int32 |  | Use this field to filter the packages fulfilled by shopee or seller. Applicable values: 0: None (not apply filter) 1: Shopee 2: Seller Default value = 2 (Seller) |
| `↳ invoice_pending` | boolean |  | Use this field to filter the packages under invoice_pending. Default value = false |
| `↳ sorting_group` | int32 |  | [Only for TW 30029 channel] Use this field to filter the sorting group of parcel. This field is only available for package with package_status = 3 and logistics_channel_id = 30029. Applicable values: 0: All 1: North 2: South |
| `↳ order_type` | int32 |  | Use this field to filter packages by order type. Applicable values: 0: All 1: Regular Order 2: Instant Order Default value = 0 (All) Note: For VN shops, using 2: Instant Order will return both Instant Delivery and Same-day Delivery packages. |
| `↳ is_pre_order` | int32 |  | Use this field to filter packages by pre-order status. Applicable values: 0: All 1: Pre-Order 2: Non Pre-Order Default value = 0 (All) |
| `↳ shipping_priority` | int32 |  | Use this field to filter packages by shipping priority. Applicable values: - For MY/PH/TW/TH shops, and VN Preferred/Preferred Plus/Shopee Mall shops: 0: All 1: Overdue 2: Ship by Today 3: Ship by Tomorrow - For other shops： 0: All 1: Overdue 2: Within 24h 3: Beyond 24h Default value = 0 (All) |
| `pagination` | object | ✔ |  |
| `↳ page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data.The limit of page_size if between 1 and 100. |
| `↳ cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the offset can be some entry to start next call. |
| `sort` | object |  |  |
| `↳ sort_type` | int32 |  | Use this field to specify which field to use to sort the returned package list. Available values: 1: ShipByDate 2: CreateDate 3: ConfirmedDate Default value = 1 (ShipByDate) |
| `↳ ascending` | boolean |  | Use this field to specify whether the returned package list is sorted in ascending or descending sort_type. Default value = true |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `mesage` | string | Indicate error details if hit error. Empty if no error happened. |
| `response` | object |  |
| `↳ packages_list` | object[] |  |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order |
| `↳↳ logistics_channel_id` | int32 | The identity of logistic channel. |
| `↳↳ product_location_id` | string | Just use this field to pass the next step of Mass ArrangeShipment |
| `↳↳ sorting_group` | string | [Only for TW 30029 channel] This field indicate the sorting group value of the package. This field is only available for logistics_channel_id = 30029 and after the package has been arranged for shipment. |
| `↳↳ is_shipment_arranged` | boolean | Only effective when the package's logistics_status/fulfillment_status is LOGISTICS_READY. This parameter further distinguishes between two scenarios: - true: Package shipment has been arranged (Seller has processed shipment, system is generating tracking number, not yet updated to LOGISTICS_REQUEST_CREATED, no duplicate action needed) - false: Package awaiting shipment arrangement (Seller hasn't processed shipment yet, shipping arrangement required) |
| `↳ pagination` | object |  |
| `↳↳ total_count` | int64 | Total orders can be returned with your query |
| `↳↳ next_cursor` | string | if packages is not empty or length of packages <= page_size. You should pass the next_cursor in the next request as page_sentinel. |
| `↳↳ more` | boolean | To indicate, it's a the last page or not |
| `↳ sort` | object | As same as request param |
| `↳↳ sort_type` | int32 | As same as request param |
| `↳↳ is_asc` | boolean | As same as request param |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.get_package_detail
`GET /api/v2/order/get_package_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

Use this api to get package detail.

Lịch sử cập nhật: 2026-10-29: Add latest_pickup_time_change_source and pickup_time as response parameter; 2026-10-22: Add "imei_list" into "item_list" as response param; 2026-08-27: Add "is_fulfillment_mapping""bundle_sku_id""components" as Response Parameter; 2026-08-06: Add invoice pending object; 2026-06-17: Add some new prescription fields including "is_prescription_item","error_in_fetching_is_prescription_item","prescription_check_status","prescription_reject_reason" into item list

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `package_number_list` | string | ✔ | The set of package_number. If there are multiple package_number, you need to use English comma to connect them. limit [1,50] |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ package_list` | object[] | The list of packages. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ fulfillment_status` | string | The Shopee fulfillment status for the package. Applicable values: See V2.0 Data Definition - PackageFulfillmentStatus. |
| `↳↳ update_time` | int64 | Timestamp that indicates the last time that there was a change in value of package. |
| `↳↳ logistics_channel_id` | int64 | The identity of logistic channel. |
| `↳↳ shipping_carrier` | string | The logistics service provider that the buyer selected for the package to deliver items. Note: If logistics_channel_id is 90021, 90025 or 90026, service_code will be appended, e.g., Entrega Turbo - M1020. |
| `↳↳ allow_self_design_awb` | boolean | To indicate whether the package allows for self-designed AWB, if allow_self_design_awb returns false, it means that the package does not allow for self-designed AWB and only the system-AWB can be used. |
| `↳↳ days_to_ship` | int64 | Shipping preparation time set by the seller when listing item on Shopee. |
| `↳↳ ship_by_date` | int64 | The deadline to ship out the package. |
| `↳↳ pending_terms` | string[] | The list of pending terms. Applicable values: - SYSTEM_PENDING: Under Shopee internal processing. - KYC_PENDING: Under KYC checking (TW CB order only). - ARRANGE_SHIPMENT_PENDING: Temporarily held due to 3PL capacity constraints. |
| `↳↳ pending_description` | string[] | The value of this field is the description of pending reason corresponding with pending terms. Applicable values: - For SYSTEM_PENDING: Order is being processed by Shopee. - For KYC_PENDING: Order is pending buyer TW KYC pre-authorization. - For ARRANGE_SHIPMENT_PENDING: Allocating delivery resources due to high order volume. Label print will be available within 4 days after buyer paid. |
| `↳↳ tracking_number` | string | The tracking number of this package. |
| `↳↳ tracking_number_expiration_date` | int64 | [TW only] Tracking number expiration date |
| `↳↳ pickup_done_time` | int64 | The timestamp when pickup is done. |
| `↳↳ is_split_up` | boolean | To indicate whether this parcel is split. |
| `↳↳ item_list` | object[] | The lis of items in the package. |
| `↳↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳↳ model_id` | int64 | Shopee's unique identifier for a model. |
| `↳↳↳ item_sku` | string | A item SKU (stock keeping unit) is an identifier defined by a seller, sometimes called parent SKU. Item SKU can be assigned to an item in Shopee Listings. |
| `↳↳↳ model_sku` | string | ID of the model that belongs to the same item. |
| `↳↳↳ model_quantity` | int64 | The number of identical items/variations purchased at the same time by the same buyer from one listing/item. |
| `↳↳↳ is_fulfillment_mapping` | boolean | Flag indicating whether the item contains any bundle items configured with Fulfillment Mapping (FFM). Returns 'true' if the item uses FFM logic, 'false' otherwise. Field will only be returned if shop is whitelisted. |
| `↳↳↳ bundle_sku_id` | string | The unique identifier (SKU ID) of the front-facing Bundle SKU purchased by the buyer on Shopee. Field will only be returned if shop is whitelisted and is_fulfillment_mapping returns true. |
| `↳↳↳ components` | object[] | List of underlying Parent SKUs (component level) associated with the mapped Bundle SKU, used by WMS/ERP for physical picking and fulfillment. If is_fulfillment_mapping returns 'false', this array will not be returned. Array will only be returned if shop is whitelisted and is_fulfillment_mapping returns true. |
| `↳↳↳↳ parent_sku_id` | string | The unique identifier (SKU ID) of the underlying physical component item (Parent SKU). |
| `↳↳↳↳ barcode_upc` | string | The physical barcode or UPC of the Parent SKU, used for scanning and inventory picking in the warehouse. |
| `↳↳↳↳ quantity` | int64 | The mapping ratio/quantity of this specific Parent SKU required for ONE unit of the Bundle SKU (e.g., if Bundle A contains 2 units of Parent SKU B, quantity = 2) |
| `↳↳↳↳ warehouse_id` | string | The ID of the warehouse where the Parent SKU component is located/stored. |
| `↳↳↳↳ mapping_type` | string | The structure/type of mapping defined for the bundle. Available values: 1: Group 2: Lucky bag 3: Mapping List |
| `↳↳↳ order_item_id` | int64 | The identify of order item. For items in one same bundle deal promotion, the order_item_id should share the same id, such as 1,2. For items not in bundle deal promotion, the order_item_id should be the same as item_id. |
| `↳↳↳ promotion_group_id` | int64 | The identify of product promotion. |
| `↳↳↳ product_location_id` | string | The warehouse ID of the item. |
| `↳↳↳ consultation_id` | string | An identifier of teleconsultation session which buyer did to order this item. Empty if item is not ordered through teleconsultation session |
| `↳↳↳ is_prescription_item` | boolean | To indicate if this item is a prescription item. Default false. Only for PH, TH, ID whitelist shops. |
| `↳↳↳ error_in_fetching_is_prescription_item` | boolean | To indicate if there was an error when validating whether this item is prescription. Default false. If is_prescription_item=false and this field is true, the item's prescription status is uncertain (label service call failed). Only for PH, TH, ID whitelist shops. |
| `↳↳↳ prescription_check_status` | int32 | Prescription check status. For ID, PH whitelisted sellers, the applicable values: 0: NONE 1: PASSED 2: FAILED For TH whitelisted sellers, the applicable values: 0: NONE 1: PASSED |
| `↳↳↳ prescription_reject_reason` | string | Return the reason why a prescription is rejected. If no rejection reason, return empty. Only for ID and PH whitelist sellers. |
| `↳↳↳ imei_list` | string[] | IMEI (International Mobile Equipment Identity) assigned to the item. Only for certain FBS shops. If item does not have IMEl or IMEl parcel is not yet outbound from warehouse, return empty. |
| `↳↳ recipient_address` | object | This object contains detailed breakdown for the recipient address. Different parameters might be masked according to each market and kind of seller. For TW region integrated channel orders will be all masked as "****". More details may refer the announcement. |
| `↳↳↳ name` | string | Recipient's name for the address. |
| `↳↳↳ phone` | string | Recipient's phone number input when order was placed. [Only for TW non-integrated channel] Will return "****" when the "virtual_contact_number" is available |
| `↳↳↳ town` | string | The town of the recipient's address. Whether there is a town will depend on the region and/or country. |
| `↳↳↳ district` | string | The district of the recipient's address. Whether there is a district will depend on the region and/or country. |
| `↳↳↳ city` | string | The city of the recipient's address. Whether there is a city will depend on the region and/or country. |
| `↳↳↳ state` | string | The state/province of the recipient's address. Whether there is a state/province will depend on the region and/or country. |
| `↳↳↳ region` | string | The two-digit code representing the region of the Recipient. |
| `↳↳↳ zipcode` | string | Recipient's postal code. |
| `↳↳↳ full_address` | string | The full address of the recipient, including country, state, even street, and etc. |
| `↳↳↳ geolocation` | object | Geolocation info. Only available for logistics_channel_id 90026. |
| `↳↳↳↳ latitude` | float | Latitude. |
| `↳↳↳↳ longitude` | float | Longitude. |
| `↳↳ parcel_chargeable_weight_gram` | int64 | display weight used to calculate ASF for this parcel |
| `↳↳ group_shipment_id` | int64 | The common identifier for multiple orders combined in the same parcel. |
| `↳↳ virtual_contact_number` | string | [Only for TW non-integrated channel] The virtual phone number to contact the recipient. |
| `↳↳ package_query_number` | string | [Only for TW non-integrated channel] The query number used in virtual phone number calls to contact the recipient of this package. |
| `↳↳ sorting_group` | string | [Only for TW 30029 channel] This field indicate the sorting group value of the package. This field is only available for logistics_channel_id = 30029 and after the package has been arranged for shipment. |
| `↳↳ is_shipment_arranged` | boolean | Only effective when the package's logistics_status/fulfillment_status is LOGISTICS_READY. This parameter further distinguishes between two scenarios: - true: Package shipment has been arranged (Seller has processed shipment, system is generating tracking number, not yet updated to LOGISTICS_REQUEST_CREATED, no duplicate action needed) - false: Package awaiting shipment arrangement (Seller hasn't processed shipment yet, shipping arrangement required) |
| `↳↳ status_info_tag` | object | Package shipping urgency tag information. |
| `↳↳↳ tag_id` | int32 | Shipping urgency tag type, applicable values below: 0: No tag 1: Will be cancelled within 1 day 2: Must ship before the specified timestamp 3: Shipment delayed 4: Must ship within the current hour 5: Will be cancelled at the specified timestamp |
| `↳↳↳ timestamp` | timestamp | When tag_id is 2 or 5, returns specific timestamp (e.g., cancel time, shipment deadline); otherwise returns 0. |
| `↳↳ can_split_order` | boolean | This field indicates whether this order can be split into multiple packages for separate shipment. - true: Support splitting, can call v2.order.split_order to execute - false: Does not support splitting |
| `↳↳ can_unsplit_order` | boolean | This field indicates whether this order can be unsplit. - true: Support unsplitting, can call v2.order.unsplit_order to execute - false: Does not support unsplitting |
| `↳↳ is_pre_order` | boolean | This field indicates whether this order is a pre-order. - true: Pre-order - false: Non pre-order |
| `↳↳ pharmacist_name` | string | Name of the Pharmacist for Prescription Order. |
| `↳↳ prescription_images` | string[] | Return prescription images of this order, only for ID and PH whitelist sellers. Please add the prefix to review: for ID: https://cf.shopee.co.id/file/+prescription_image for PH: https://cf.shopee.ph/file/+prescription_image |
| `↳↳ prescription_approval_time` | timestamp | Time of when the prescription is approved. |
| `↳↳ prescription_rejection_time` | timestamp | Time of when the prescription is rejected. |
| `↳↳ is_buyer_shop_collection` | boolean | To indicate if this order is buyer self collection at store order. |
| `↳↳ buyer_proof_of_collection` | string[] | The image url of the proof for buyer self collection at the store. |
| `↳↳ preparation_end_time` | timestamp | The system-calculated deadline for package preparation. When the package fulfillment_status/logistics_status changes to "LOGISTICS_READY", the system calculates this time based on the "Preparation Time" configured for the logistics channel of this package. Notes: 1) Only effective for logistics channels that have Auto Call Driver enabled and Preparation Time configured. 2) Seller needs to complete packing and waybill printing before this time to ensure the package is ready when the driver arrives. 3) When this time is reached, the system will automatically arrange shipment and trigger driver dispatch: - If driver calling is successful, the package fulfillment_status/logistics_status will cha |
| `↳↳ driver_info` | object | After the driver is successfully called, the driver's information will be returned. Note: Data availability depends on the specific 3PL provider; certain fields may be omitted due to provider policies, PII restrictions, or data unavailability. |
| `↳↳↳ driver_name` | string | Driver Name |
| `↳↳↳ driver_phone` | string | Driver phone number |
| `↳↳↳ vehicle_type` | string | Delivery vehicle type |
| `↳↳↳ license_plate` | string | License plate number |
| `↳↳↳ courier_photo` | string | URL of the driver's photo |
| `↳↳↳ eta_start_time` | int64 | Earliest estimated arrival time at pickup address |
| `↳↳↳ eta_end_time` | int64 | Latest estimated arrival time at pickup address |
| `↳↳↳ driver_status` | string | Driver status. Applicable values: - Allocating Driver - Driver assigned - Driver is on the way - Driver is arrived - Driver should arrive by {starting_time} - {end_time} |
| `↳↳ can_full_cancel_order` | boolean | Indicates whether the order can be full cancelled: - If this value is true, seller can cancel the entire order - If the value is false, full order cancellation is not available for the order |
| `↳↳ can_partial_cancel_order` | boolean | Indicates whether the order is eligible for partial cancellation. This value is determined by both the system eligibility check and the buyer’s out-of-stock handling preference. - If this value is true, seller can cancel selected out-of-stock item quantities while continuing to fulfill the remaining items. - If this value is false, partial cancellation is not allowed. |
| `↳↳ buyer_preference_for_partial_cancellation` | int64 | Indicates the buyer’s preference for handling out-of-stock items in the order. Applicable values: 0 = Ship Available Items Only (The buyer allows the seller to cancel unavailable items and continue shipping the remaining available items) 1 = Cancel The Entire Order (The buyer does not allow partial cancellation. If any item is unavailable, the seller should cancel the entire order instead) |
| `↳↳ invoice_pending` | object |  |
| `↳↳↳ status` | string | The invoice statuses should be: - valid (The invoice sent is valid) - pending (System is waiting to receive the invoice) |
| `↳↳↳ pending_reason` | string | It's the failed reason if status is pending |
| `↳↳ latest_pickup_time_change_source` | string | If the pickup time was last updated by seller or system. Not returned if not applicable. |
| `↳↳ pickup_time` | int64 | The pickup start time for this package. Not returned if not applicable. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.split_order
`POST /api/v2/order/split_order` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to split an order into multiple packages. Orders that include installation services cannot be split by quantity.

Lịch sử cập nhật: 2023-12-28: add new request field "model_quantity" for the eligible sellers to the unit-level split.; 2022-11-09: update desc of promotion_group_id; 2021-04-19: add order_item_id and promotion_group_id

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `package_list` | object[] | ✔ | The list of packages that you want to split. Note: - Orders that include installation services cannot be split by quantity. - When splitting the order, must contain all items in the order in one request. - You can split the order into 30 parcels at most in TW and 5 parcels at most in other regions. |
| `↳ item_list` | object[] | ✔ | The list of items under the same package. |
| `↳↳ item_id` | int64 | ✔ | Shopee's unique identifier for an item. |
| `↳↳ model_id` | int64 | ✔ | Shopee's unique identifier for a model of an item. For single item without variation, you can set model_id as 0. |
| `↳↳ order_item_id` | int |  | The identify of order item. For items in one same bundle deal promotion, the order_item_id should share the same id, such as 1,2. For items not in bundle deal promotion, the order_item_id should be the same as item_id. |
| `↳↳ promotion_group_id` | int |  | The identify of product promotion.It's required for add on deal and bundle deal items. For items in one same add on deal or bundle deal promotion, the promotion_group_id should share the same id. For items not in add on deal or bundle deal promotion, the promotion_group_id should be 0. And the data is from promotion_group_id of v2,order.get_order_detail. |
| `↳↳ model_quantity` | int32 |  | The number of identical items put in the package, the quantity sum of the same item from each parcel must be the full item quantity of the whole order. This field is only eligible for the shop whitelisted to the unit-level split in SG/TH/TW/MY markets. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳ package_list` | object[] | The list of package under this order you have split. |
| `↳↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳↳ item_list` | object[] | The list of items under this package. |
| `↳↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳↳ model_id` | int64 | Shopee's unique identifier for a model. |
| `↳↳↳ order_item_id` | int | The identify of order item. For items in one same bundle deal promotion, the order_item_id should share the same id, such as 1,2. For items not in bundle deal promotion, the order_item_id should be the same as item_id. |
| `↳↳↳ promotion_group_id` | int | The identify of product promotion. For items in one same add on deal promotion, the promotion_group_id should share the same id. For items not in add on deal promotion, the promotion_group_id should be 0. And the data is from group_id of shopee.orders.GetOrderDetails. |
| `↳↳↳ model_quantity` | int | The number of identical items put in the package. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · You don’t have the permission to split order. · Cannot split this warehouse order. · This order has already been split. · Cannot split order with duplicate items. · Split order failed, please try again. · Cannot split order paid by Credit Card Installment payment method or SPayLater payment method with instalment plan greater then 1x. · Split order succeed, but failed to get the new package info. · The size of package list is over limit. · Cannot split order with invalid items. · Cannot split order with missing items. · Cannot split order with items in one bundle-deal or add-on deal into different packages.

## v2.order.unsplit_order
`POST /api/v2/order/unsplit_order` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this ai to undo split of order. After undo split, the order will have only one package. It can only be used when order status still at READY_TO_SHIP.

Lịch sử cập nhật: 2023-05-15: update the API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Cannot undo split this order. · Cannot split order with wrong model quantity · Undo split failed, please try again later. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

## v2.order.cancel_order
`POST /api/v2/order/cancel_order` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to cancel an order. This action can only be performed before the order has been shipped.

Lịch sử cập nhật: 2026-05-22: Add partial_cancel_items_list request parameter; 2023-05-15: update the API description.; 2021-08-19: Updated the example.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `cancel_reason` | string | ✔ | The reason seller want to cancel this order. Applicable values: OUT_OF_STOCK CUSTOMER_REQUEST UNDELIVERABLE_AREA (Note: Only apply for TW and MY) COD_NOT_SUPPORTED |
| `item_list` | object[] |  | Required when cancel_reason is OUT_OF_STOCK. |
| `↳ item_id` | int32 | ✔ | Id of item. |
| `↳ model_id` | int64 | ✔ | Id of the model that belongs to the same item. |
| `partial_cancel_item_list` | object[] |  | The list of item models and quantities that the seller wants to partially cancel. This field should be provided when the seller intends to cancel only part of the order due to unavailable items while continuing to fulfill the remaining items. |
| `↳ item_id` | int64 | ✔ | The unique identifier of the item to be partially cancelled. |
| `↳ model_id` | int64 | ✔ | The unique identifier of the model to be partially cancelled. |
| `↳ order_item_id` | int64 |  | The identify of order item. For items in one same bundle deal promotion, the order_item_id should share the same id, such as 1,2. For items not in bundle deal promotion, the order_item_id should be the same as item_id. |
| `↳ promotion_group_id` | int64 |  | The identify of product promotion.It's required for add on deal and bundle deal items. For items in one same add on deal or bundle deal promotion, the promotion_group_id should share the same id. For items not in add on deal or bundle deal promotion, the promotion_group_id should be 0. And the data is from promotion_group_id of v2,order.get_order_detail. |
| `↳ model_quantity` | int64 | ✔ | The quantity of the specified item model to be cancelled. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ update_time` | timestamp | The time when the order is updated. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Can not cancel this order:{msg} · You can not cancel warehouse order. · Please link shop and partner on seller center first. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

## v2.order.handle_buyer_cancellation
`POST /api/v2/order/handle_buyer_cancellation` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Customer Service, Swam ERP

Use this api to handle buyer's cancellation application.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `operation` | string | ✔ | The operation you want to handle.Avaiable value: ACCEPT, REJECT |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ update_time` | timestamp | The time when the order is updated. |

Lỗi riêng: Cancel forder failed. · Invalid order_status.The order status should be IN_CANCEL. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Invalid order_status.The order status should be IN_CANCEL. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

## v2.order.set_note
`POST /api/v2/order/set_note` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Customer Service, Swam ERP

Use this api to set note for an order.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `note` | string | ✔ | The note seller add for reference. |

Lỗi riêng: Cannot update old order · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.get_pending_buyer_invoice_order_list
`GET /api/v2/order/get_pending_buyer_invoice_order_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

This endpoint only for PH and BR local sellers only. This API is used for seller to retrieve a list of order IDs that are pending invoice upload.

Rate limit: [0,0,0]

Lịch sử cập nhật: 2022-06-30: update the description, supporting the AR local seller to use this API; 2022-04-21: update the description; 2021-09-30: Update API; 2021-09-27: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data.The limit of page_size if between 1 and 100. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ more` | boolean | This is to indicate whether the order list is more than one page. If this value is true, you may want to continue to check next page to retrieve orders. |
| `↳ next_cursor` | string | If more is true, you should pass the next_cursor in the next request as cursor. The value of next_cursor will be empty string when more is false. |
| `↳ order_list` | object[] |  |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.get_buyer_invoice_info
`POST /api/v2/order/get_buyer_invoice_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

API to obtain buyer submitted invoice info for VN, TH and PH local sellers only.

Lịch sử cập nhật: 2026-07-30: Added "national_id" as response parameters; 2026-03-10: Updating name, address, tax_id, and email with household; 2022-09-30: add TH to use this API; 2022-09-22: update to add "is_requested"filed; 2022-07-21: add some new fields for AR sellers

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `queries` | object[] |  |  |
| `↳ order_sn` | string | ✔ | Shopee's unique identifier for an order. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `invoice_info_list` | object[] |  |
| `↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳ invoice_type` | string | Type of invoice requested: {1: personal, 2: company, 3: household}. |
| `↳ invoice_detail` | object | Invoice info submitted by buyer. Might be masked, e.g. A****b, depending on order status. |
| `↳↳ name` | string | Buyer name (has value when invoice_type is personal, household, or company) - VN, TH, PH only |
| `↳↳ email` | string | Buyer email address (has value when invoice_type is personal and household) - VN, TH, PH only |
| `↳↳ phone_number` | string | Buyer phone number - TH only |
| `↳↳ tax_id` | string | has value when invoice_type is personal and household. - VN, TH, PH only |
| `↳↳ address` | string | Buyer address in format "Street & number, city, zipcode, any additional info provided by buyer" (has value when invoice_type is personal and household) - PH, VN only |
| `↳↳ id_card_address` | string | Same function as the address, only having a different field name for TH.Buyer address in format "Street & number, city, zipcode, any additional info provided by buyer" (only has value when invoice_type is personal). |
| `↳↳ address_breakdown` | object | Buyer address breakdown. - TH, PH only |
| `↳↳↳ region` | string | Return region value - PH, TH only |
| `↳↳↳ state` | string | Return value - TH: Province |
| `↳↳↳ city` | string | Return value - TH: District |
| `↳↳↳ town` | string | Return value - TH: Sub district |
| `↳↳↳ postcode` | string | Return value - TH: Postal code - PH: Postal code |
| `↳↳↳ detailed_address` | string | Return value - PH: Additional details, i.e. street name, building - TH: Additional details, i.e. house number |
| `↳↳↳ additional_info` | string | Return value: - Empty for PH, TH |
| `↳↳↳ full_address` | string | - only has value when invoice_type is personal - Buyer address in format "detailed_address, town, district, state, postcode, additional_info" for all regions --- for TH: leave the 'additional_info' as empty |
| `↳↳ company_head_office` | string | - return value for TH only (only has value when invoice_type is company) |
| `↳↳ company_name` | string | - Only return value when invoice type is company - VN, TH, PH only |
| `↳↳ company_branch_name` | string | - Only return value when invoice type is company - TH only |
| `↳↳ company_branch_id` | string | - Only return value when invoice type is company - TH only |
| `↳↳ company_type` | string | - Only return value when invoice type is company - TH only |
| `↳↳ company_email` | string | - Only return value when invoice type is company - VN, TH, PH only |
| `↳↳ company_tax_id` | string | - Only return value when invoice type is company - VN, TH, PH only |
| `↳↳ company_address` | string | Buyer address in format "Street & number,city, zipcode, any additional info provided by buyer" (only has value when invoice_type is company) - VN, TH only |
| `↳↳ company_address_breakdown` | object | Company address breakdown - PH, TH only |
| `↳↳↳ company_region` | string | Return region value - PH, TH only |
| `↳↳↳ company_state` | string | Return value - PH: Province - TH: Province |
| `↳↳↳ company_city` | string | Return value - PH: City |
| `↳↳↳ company_district` | string | Return value - PH: Barangay - TH: District |
| `↳↳↳ company_town` | string | Return value - TH: Sub district |
| `↳↳↳ company_postcode` | string | Return postal code - TH, PH only |
| `↳↳↳ company_detailed_address` | string | Return value - PH: Detailed address - TH: Detailed address |
| `↳↳↳ company_additional_info` | string | Return value: - Empty for PH, TH |
| `↳↳↳ company_full_address` | string | Concatenation of company address breakdown - only has value when invoice_type is company |
| `↳↳ household_address_breakdown` | object | Household address breakdown -Only for VN |
| `↳↳↳ household_region` | string | Region of the household address. |
| `↳↳↳ household_state` | string | State of the household address. |
| `↳↳↳ household_city` | string | City of the household address. |
| `↳↳↳ household_province` | string | Province of the household address. |
| `↳↳↳ household_district` | string | District of the household address. |
| `↳↳↳ household_town` | string | Town of the household address. |
| `↳↳↳ household_barangay` | string | Barangay of the household address. |
| `↳↳↳ household_postcode` | string | Postal code of the household address. |
| `↳↳↳ household_detailed_address` | string | Detailed street address of the household. |
| `↳↳↳ household_additional_info` | string | Additional address information provided by the buyer. |
| `↳↳↳ household_full_address` | string | Full formatted household address. |
| `↳↳ national_id` | string | National ID information provided by the buyer. - Only return value when invoice_type is personal - VN only |
| `↳ error` | string | Error in retrieving the receipt setting of a particular order. |
| `↳ is_requested` | boolean | To identify order with and without buyer request, applicable to PL. |

Lỗi riêng: Order SN is a required parameter. Please check your request data. · Query data from database failed. · The Order SN is duplicated. · Something wrong. Please try again later. · Something wrong. Please try again later. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · System error, please try again later.

## v2.order.upload_invoice_doc
`POST /api/v2/order/upload_invoice_doc` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

This endpoint is for PH and BR local seller. Upload the invoice document

Rate limit: [0,0,0]

Lịch sử cập nhật: 2023-04-13: support BR local sellers to use this API; 2021-09-30: Update API; 2021-09-27: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `file_type` | int | ✔ | the type of invoice file. 1:pdf 2.jpeg 3.png. 4.xml |
| `file` | file | ✔ | invoice file. File size limit to 1MB. |

Lỗi riêng: Database connection issue. Please try again later. · Database connection issue. Please try again later. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Upload invoice failed, please try again later. · File error.

## v2.order.download_invoice_doc
`GET /api/v2/order/download_invoice_doc` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

This endpoint only for PH and BR local seller. Seller can download the invoice uploaded before through this endpoint.

Rate limit: [0,0,0]

Lịch sử cập nhật: 2023-04-14: support BR local sellers use this API to download invoice.; 2022-06-30: udpate the description, support the AR local seller to use this API; 2022-04-21: update the description; 2021-09-30: Update API; 2021-09-27: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `invoice_doc` | file |  |

Lỗi riêng: Invoice is not available for this order. Please try again later. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Download invoice failed.

## v2.order.handle_prescription_check
`POST /api/v2/order/handle_prescription_check` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this API to approve or reject a prescription

Lịch sử cập nhật: 2026-03-27: Add 5 (Free Text) option for reject_reason_code request parameter, and add new free_text request parameter; 2023-02-03: New field for pharmacist name for PH only.; 2022-12-14: update the reject_reason_code description; 2022-08-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `is_approved` | boolean | ✔ | Approve or reject the prescription. Available values: TRUE, FALSE. |
| `reject_reason_code` | int |  | Reject reason code. Available values: 1 = Invalid Prescription (counterfeit/incorrect format) 2 = Incorrect Dosage 3 = No Prescription 4 = Unclear Image 5 = Free Text |
| `items` | object[] |  | The list of invalid items that make the prescription get rejected |
| `↳ item_id` | int | ✔ | Shopee's unique identifier for an item. |
| `↳ model_id` | int | ✔ | Shopee's unique identifier for a model of an item. |
| `↳ group_id` | int | ✔ | The identify of product promotion. For items in one same add on deal promotion, the group_id should share the same id. For items not in add on deal promotion, the group_id should be 0. And the data is from group_id of shopee.orders.GetOrderDetails. |
| `pharmacist_name` | string |  | Full name of the pharmacist. Required for PH and ID Prescription Orders. |
| `free_text` | string |  | The reason for rejecting the prescription. Only usable when the reject_reason_code = 5. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ is_success` | boolean | This is to indicate whether the request has been executed successfully. |

Lỗi riêng: Prescription order is already completed or canceled · parse data failed · data not exist · parameter invalid · Pharmacist name is required. Please enter a valid name. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.get_warehouse_filter_config
`GET /api/v2/order/get_warehouse_filter_config` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

For multi-warehouse shops, return all warehouses with packages that have not been SHIPPED including product_location_id and address_id. Compared to v2.shop.get_warehouse_detail, it covers some edge cases like warehouse that have been unlinked but still retain packages that have not been SHIPPED, and does not cover some cases like single warehouse with default product_location_id and FBS shop.

Lịch sử cập nhật: 2025-03-14: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ warehouse_filters` | object[] |  |
| `↳↳ warehouse_name` | string | The warehouse name filled in when creating the warehouse address. |
| `↳↳ warehouse_type` | int32 | Type of warehouse. Applicable values: - 1: Local Warehouse - 2: CB Warehouse |
| `↳↳ product_location_id` | string | Location identifier for stocks. Different location_ids represent that your addresses are in different item stocks. |
| `↳↳ address_id` | int64 | Identity of address. |
| `↳↳ address` | string | Detail address of your warehouse. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.get_booking_list
`GET /api/v2/order/get_booking_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to search bookings. You may also filter them by status, if needed.

Lịch sử cập nhật: 2024-07-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `time_range_field` | string | ✔ | The kind of time_from and time_to. Available value: create_time, update_time. |
| `time_from` | int64 | ✔ | The time_from and time_to fields specify a date range for retrieving bookings (based on the time_range_field). The time_from field is the starting date range. The maximum date range that may be specified with the time_from and time_to fields is 15 days. |
| `time_to` | int64 | ✔ | The time_from and time_to fields specify a date range for retrieving bookings (based on the time_range_field). The time_from field is the starting date range. The maximum date range that may be specified with the time_from and time_to fields is 15 days. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data.The limit of page_size if between 1 and 100. |
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the offset can be some entry to start next call. |
| `booking_status` | string |  | The booking_status filter for retrieving bookings and each one only every request. Available value: READY_TO_SHIP/PROCESSED/SHIPPED/CANCELLED/MATCHED |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail information you are querying. |
| `↳ more` | boolean | This is to indicate whether the booking list is more than one page. If this value is true, you may want to continue to check next page to retrieve bookings. |
| `↳ booking_list` | object[] |  |
| `↳↳ booking_sn` | string | Shopee's unique identifier for a booking. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. Only return if booking_status is MATCHED. |
| `↳↳ booking_status` | string | The booking_status filter for retrieving booking and each one only every request. Available value: READY_TO_SHIP/PROCESSED/SHIPPED/CANCELLED/MATCHED |
| `↳↳ next_cursor` | string | If more is true, you should pass the next_cursor in the next request as cursor. The value of next_cursor will be empty string when more is false. |

Lỗi riêng: Start time must be earlier than end time and diff in 15days. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.get_booking_detail
`GET /api/v2/order/get_booking_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management, Swam ERP

Use this api to get booking detail.

Lịch sử cập nhật: 2024-07-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `booking_sn_list` | string | ✔ | The set of booking_sn. If there are multiple booking_sn, you need to use English comma to connect them. limit [1,50] |
| `response_optional_fields` | string |  | The response fields you want to get. Please select from the below response parameters. If you input an object field, all the params under it will be included automatically in the response. If there are multiple response fields you want to get, you need to use English comma to connect them. Available values: item_list,cancel_by,cancel_reason,fulfillment_flag,pickup_done_time,shipping_carrier, recipient_address, dropshipper, dropshipper_phone |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail information you are querying. |
| `↳ booking_list` | object[] | The list of bookings. |
| `↳↳ booking_sn` | string | Return by default. Shopee's unique identifier for a booking. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. Only return if booking_status is MATCHED. |
| `↳↳ region` | string | Return by default. The two-digit code representing the region where the booking was made. |
| `↳↳ booking_status` | string | Return by default. Enumerated type that defines the current status of the booking. Available value: READY_TO_SHIP/PROCESSED/SHIPPED/CANCELLED/MATCHED |
| `↳↳ match_status` | string | MATCH_PENDING/MATCH_SUCCESSFUL/MATCH_FAILED |
| `↳↳ shipping_carrier` | string | The logistics service provider that will deliver the booking. |
| `↳↳ create_time` | timestamp | Return by default. Timestamp that indicates the date and time that the booking was created. |
| `↳↳ update_time` | timestamp | Return by default. Timestamp that indicates the last time that there was a change in value of booking, such as booking status changed from 'Processed' to 'Shipped'. |
| `↳↳ ship_by_date` | int64 | Return by default. The deadline to ship out the parcel. |
| `↳↳ recipient_address` | object | This object contains detailed breakdown for the recipient address. |
| `↳↳↳ name` | string | Recipient's name for the address. |
| `↳↳↳ phone` | string | Recipient's phone number input when booking was placed. |
| `↳↳↳ town` | string | The town of the recipient's address. Whether there is a town will depend on the region and/or country. |
| `↳↳↳ district` | string | The district of the recipient's address. Whether there is a district will depend on the region and/or country. |
| `↳↳↳ city` | string | The city of the recipient's address. Whether there is a city will depend on the region and/or country. |
| `↳↳↳ state` | string | The state/province of the recipient's address. Whether there is a state/province will depend on the region and/or country. |
| `↳↳↳ region` | string | The two-digit code representing the region of the Recipient. |
| `↳↳↳ zipcode` | string | Recipient's postal code. |
| `↳↳↳ full_address` | string | The full address of the recipient, including country, state, even street, and etc. |
| `↳↳ item_list` | object[] | This object contains the detailed breakdown for the result of this API call. |
| `↳↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳↳ item_name` | string | The name of the item. |
| `↳↳↳ item_sku` | string | A item SKU (stock keeping unit) is an identifier defined by a seller, sometimes called parent SKU. Item SKU can be assigned to an item in Shopee Listings. |
| `↳↳↳ model_id` | int64 | ID of the model that belongs to the same item. |
| `↳↳↳ model_name` | string | Name of the model that belongs to the same item. A seller can offer models of the same item. For example, the seller could create a fixed-priced listing for a t-shirt design and offer the shirt in different colors and sizes. In this case, each color and size combination is a separate model. Each model can have a different quantity and price. |
| `↳↳↳ model_sku` | string | A model SKU (stock keeping unit) is an identifier defined by a seller. It is only intended for the seller's use. Many sellers assign a SKU to an item of a specific type, size, and color, which are models of one item in Shopee Listings. |
| `↳↳↳ model_quantity_purchased` | int64 | The number of identical items from one listing/item in the same booking. |
| `↳↳↳ weight` | float | The weight of the item |
| `↳↳↳ product_location_id` | string | The fulfilment warehouse ID(s) of the items in the booking. (Multi-Warehouse sellers only) |
| `↳↳↳ image_info` | object | Image info of the product. |
| `↳↳↳↳ image_url` | string | The image url of the product. Default to be variation image, if the model does not have a variation image, will use an item main image instead. |
| `↳↳ dropshipper` | string | For Indonesia bookings only. The name of the dropshipper. |
| `↳↳ dropshipper_phone` | string | The phone number of dropshipper, could be empty. |
| `↳↳ cancel_by` | string | Could be one of buyer, seller, system or Ops. |
| `↳↳ cancel_reason` | string | Use this field to get reason for buyer, seller, and system cancellation. |
| `↳↳ fulfillment_flag` | string | Use this field to indicate the booking is fulfilled by shopee or seller. Applicable values: fulfilled_by_shopee, fulfilled_by_cb_seller, fulfilled_by_local_seller. |
| `↳↳ pickup_done_time` | timestamp | The timestamp when pickup is done. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.generate_fbs_invoices
`POST /api/v2/order/generate_fbs_invoices` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

This API creates a task to download a specific tax document (e.g., sales invoice, remessa invoice) for the seller's account, available only after the document is issued by the system as part of the Fulfilled by Shopee (FBS) process. The workflow is as follows: (1) v2.order.generate_fbs_invoices; (2) v2.order.get_fbs_invoices_result; (3) v2.order.download_fbs_invoices. Please note: The download link for the document will expire 30 minutes after being generated.

Lịch sử cập nhật: 2026-10-28: adding CNPJ mandatory field, document_status option 3; 2025-07-11: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `batch_download` | object |  |  |
| `↳ start` | int64 | ✔ | Format YYYYMMDD e.g. 20240101 |
| `↳ end` | int64 | ✔ | Format YYYYMMDD e.g. 20240101 |
| `↳ document_type` | int32 | ✔ | REMESSA = 1; RETURN = 2; SYMBOLIC_RETURN = 3; SALE = 4; ENTRADA = 5; SYMBOLIC_REMESSA = 6; ALL = 7; EXPORT = 8; CANCELLATION = 9; EXPORT_DEVOLUCAO = 10; TRANSFER = 11; TRANSFER_REMESSA = 12; REVERSE_TRANSFER = 13; |
| `↳ file_type` | int32 | ✔ | 1 = xml only 2 = pdf only 3 = both |
| `↳ document_status` | int32 |  | 1= authorized only 2= cancelled 3= disable invoice Default: If document_status not passed or passed empty, means documents under ALL status (both authorized and cancelled) must be included |
| `↳ cnpj` | string | ✔ | The CNPJ of the seller's branch used to filter the tax documents. Must match one of the CNPJ branches registered for the seller. Multiple selection is not allowed. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `error_msg` | string | Error messages |
| `result_list` | object[] |  |
| `↳ request_id` | int64 | Unique task identifier that includes one or more tax documents to be downloaded according to the filters sent in the request. |
| `↳ fail_error` | string | Indicate error type if one element hit error. Empty if no error happened. |
| `↳ fail_message` | string | Indicate error details if one element hit error. Empty if no error happened. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.get_fbs_invoices_result
`POST /api/v2/order/get_fbs_invoices_result` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

This API allows you to consult the status of a previously requested batch download for FBS tax documents.

Lịch sử cập nhật: 2025-07-11: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `request_id_list` | object | ✔ | - |
| `↳ request_id` | int64[] | ✔ | A list of integers representing the request IDs to be queried. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `error_msg` | string | Indicate error details if hit error. Empty if no error happened. |
| `result_list` | object[] |  |
| `↳ request_id` | int64 | Represents the current status of the request |
| `↳ file_name` | string | Name of the file to be downloaded |
| `↳ status` | string | Represents the current status of the request |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.download_fbs_invoices
`POST /api/v2/order/download_fbs_invoices` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

This API allows you to download FBS invoices. To use this API, the client must first call v2.order.generate_fbs_invoices to create a new shipping document task, followed by calling v2.order.get_fbs_invoices_result to check the task status. The document can only be downloaded once the task status is "READY."

Lịch sử cập nhật: 2025-07-11: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `request_id_list` | object |  | list of request id (task identifiers) |
| `↳ request_id` | int64[] | ✔ |  |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ request_id` | int64 |  |
| `↳ file_link` | string |  |
| `error_msg` | string |  |
| `timestamp` | timestamp |  |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.order.get_estimate_cancel_value
`POST /api/v2/order/get_estimate_cancel_value` · loại: Shop · app được gọi: ERP System, Seller In House System, Order Management

Returns the estimated refund value for a partial order cancellation given the specified items to cancel.

Lịch sử cập nhật: 2026-06-25: update the request field from “update cancel_value” to “cancel_value_price“; 2026-05-22: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |
| `partial_cancel_item_list` | object[] | ✔ | The list of item models and quantities for which the seller wants to estimate the cancellation value before submitting the actual partial cancellation request. |
| `↳ item_id` | int64 | ✔ | The unique identifier of the item to be included in the estimated cancellation value calculation. |
| `↳ model_id` | int64 | ✔ | The unique identifier of the model to be included in the estimated cancellation value calculation. |
| `↳ order_item_id` | int64 |  | The identify of order item. For items in one same bundle deal promotion, the order_item_id should share the same id, such as 1,2. For items not in bundle deal promotion, the order_item_id should be the same as item_id. |
| `↳ promotion_group_id` | int64 |  | The identify of product promotion.It's required for add on deal and bundle deal items. For items in one same add on deal or bundle deal promotion, the promotion_group_id should share the same id. For items not in add on deal or bundle deal promotion, the promotion_group_id should be 0. And the data is from promotion_group_id of v2,order.get_order_detail. |
| `↳ model_quantity` | int64 | ✔ | The quantity of the specified item model to be included in the estimated cancellation value calculation. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `cancel_value_price` | string | The estimated cancellation value for the selected item quantities. This value is calculated before the actual cancellation is submitted and can be used by sellers to preview the expected cancellation amount and support partial cancellation confirmation. |

Lỗi riêng: Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · System error. Please try again later. · Shop id is invalid. Please check your shop.

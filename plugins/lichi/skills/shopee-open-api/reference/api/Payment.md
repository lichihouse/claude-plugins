# Module Payment (18 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.payment.get_escrow_detail
`GET /api/v2/payment/get_escrow_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Customer Service, Brand Membership, Swam ERP, Payment Service Provider

Use this API to fetch the accounting detail of order.

Lịch sử cập nhật: 2026-09-30: added a new escrow component: pay per sale; 2026-08-28: add "buyer instant fee" field for BR local shops; 2026-07-31: update the type of the "promotion_id" and "activity_id" to uint64; 2026-07-23: add "voucher_from_external_party" under "order_income"; 2026-07-17: update the field names under "kit_items": "mt_item_id" to "original_product_id", "mt_model_id" to "original_model_id", "parent_item_price" to "original_price", and "item_price_prorated" to "proportional_price"

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn` | string | ✔ | Shopee's unique identifier for an order. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳ buyer_user_name` | string | The username of buyer. |
| `↳ return_order_sn_list` | string[] | The list of the serial number of return. |
| `↳ order_income` | object |  |
| `↳↳ escrow_amount` | float | The total amount that the seller is expected to receive for the order and will change before order is completed. For non cb sip affiliate shop (new formula): escrow_amount= original_cost_of_goods_sold-original_shopee_discount+seller_return_refund+ shopee_discount- voucher_from_seller- seller_coin_cash_back+ buyer_paid_shipping_fee- actual_shipping_fee+ shopee_shipping_rebate+ shipping_fee_discount_from_3pl- reverse_shipping_fee+ rsf_seller_protection_fee_claim_amount- final_return_to_seller_shipping_fee- seller_transaction_fee- service_fee- commission_fee- campaign_fee- shipping_seller_protection_fee_amount- delivery_seller_protection_fee_premium_amount-final_escrow_product_gst- order_ams_co |
| `↳↳ buyer_total_amount` | float | The snapshot value of total amount that paid by buyer at checkout moment. |
| `↳↳ order_original_price` | float | The original price of the item before ANY promotion/discount in the listing currency. It returns the subtotal of that specific item if quantity exceeds 1. |
| `↳↳ original_price` | float | The original price of the item before ANY promotion/discount in the listing currency. It returns the subtotal of that specific item if quantity exceeds 1. |
| `↳↳ order_discounted_price` | float | The total discounted price for this order. It returns the subtotal of that specific item if quantity exceeds 1. (Only display for non cb sip affiliate shop. ) |
| `↳↳ order_selling_price` | float | This field value = sum of item unit price.selling price comes from the sum up of each item's unit price. For non-bundle deal case, this value will be same like order_original_price; For bundle deal case, this value will be price of sum of item price before bundle deal promo but after item promo.It returns the subtotal of that specific item if quantity exceeds 1. (Only display for non cb sip affiliate shop. ) |
| `↳↳ order_seller_discount` | float | The total discount seller provided for this order. It returns the subtotal of that specific item if quantity exceeds 1. (Only display for non cb sip affiliate shop. ) |
| `↳↳ bcrs_deposit` | float | The deposit fee paid by buyer of $0.10 per container as part of the SG Beverage Container Return Scheme mandated by the National Environment Agency (NEA). This value might be updated after RR/cancellation. |
| `↳↳ seller_discount` | float | Final sum of each item seller discount of a specific order. (Only display for non cb sip affiliate shop. ) |
| `↳↳ shopee_discount` | float | Final sum of each item Shopee discount of a specific order. This amount will Return remaining rebate value to seller. (Only display for non cb sip affiliate order. ) |
| `↳↳ voucher_from_seller` | float | Final value of voucher provided by Seller for the order. (Only display for non cb sip affiliate shop. ) |
| `↳↳ voucher_from_shopee` | float | Final value of voucher provided by Shopee for the order. (Only display for non cb sip affiliate shop. ) |
| `↳↳ voucher_from_external_party` | float | Final value of voucher provided by External Party for the order. (Only display for non cb sip affiliate shop.) |
| `↳↳ coins` | float | This value indicates the total amount offset when the buyer consumed Shopee Coins upon checkout. (Only display for non cb sip affiliate shop. ) |
| `↳↳ buyer_paid_shipping_fee` | float | The shipping fee paid by buyer. (Only display for non cb sip affiliate shop. ) |
| `↳↳ buyer_transaction_fee` | float | Tansaction fee paid by buyer for the order. (Only display for non cb sip affiliate shop. ) |
| `↳↳ cross_border_tax` | float | Amount incurred by Buyer for purchasing items outside of home country or region. Amount may change after Return Refund. (Only display for non cb sip affiliate shop. ) |
| `↳↳ payment_promotion` | float | The amount offset via payment promotion. (Only display for non cb sip affiliate shop. ) |
| `↳↳ commission_fee` | float | The commission fee charged by Shopee platform if applicable. For cb sip affiliate shop: commission_fee=commission_fee_pri * exchange_rate |
| `↳↳ service_fee` | float | Amount charged by Shopee to seller for additional services. For cb sip affiliate shop: service_fee=service_fee_pri * exchange_rate For tw shop, there will be pre-order service fee included |
| `↳↳ seller_transaction_fee` | float | Tansaction fee paid by seller for the order. (Only display for non cb sip affiliate shop. ) |
| `↳↳ seller_lost_compensation` | float | Compensation to seller in case of lost parcel. (Only display for non cb sip affiliate shop. ) |
| `↳↳ seller_coin_cash_back` | float | Value of coins provided by Seller for purchasing with his or her store for the order. (Only display for non cb sip affiliate shop. ) |
| `↳↳ escrow_tax` | float | Cross-border tax imposed by the Indonesian government on sellers. (Only display for non cb sip affiliate shop. ) |
| `↳↳ estimated_shipping_fee` | float | The estimated shipping fee is an estimation calculated by Shopee based on specific logistics courier's standard. (Only display for non cb sip affiliate shop. ) |
| `↳↳ final_shipping_fee` | float | Final adjusted amount that seller has to bear as part of escrow. This amount could be negative or positive. (Only display for non cb sip affiliate shop. ) |
| `↳↳ actual_shipping_fee` | float | The final shipping cost of order and it is positive. For Non-integrated logistics channel is 0. (Only display for non cb sip affiliate shop. ) |
| `↳↳ shipping_fee_sst` | float | The Service Tax charged on Seller Paid Shipping Fee for forward shipping, based on Malaysia SST regulations for shipping fees on all orders. Definition of Seller Paid Shipping Fee is Actual Shipping Fee subtracted by sum of Shipping Fee Paid by Buyer and Shipping Rebate From Shopee. (Only applicable for non cb sip affiliate shop) |
| `↳↳ order_chargeable_weight` | int32 | For CB shop, display weight used to calculate actual_shipping_fee for this order. |
| `↳↳ shopee_shipping_rebate` | float | The platform shipping subsidy to the seller. (Only display for non cb sip affiliate shop. ) |
| `↳↳ shipping_fee_discount_from_3pl` | float | The discount of shipping fee from 3PL. Currently only applicable to ID. (Only display for non cb sip affiliate shop. ) |
| `↳↳ seller_shipping_discount` | float | The shipping discount defined by seller. (Only display for non cb sip affiliate shop. ) |
| `↳↳ seller_voucher_code` | string[] | The list of voucher code provided by seller. (Only display for non cb sip affiliate shop. ) |
| `↳↳ drc_adjustable_refund` | float | The adjustable refund amount from Shopee Dispute Resolution Center. |
| `↳↳ cost_of_goods_sold` | float | Final amount paid by the buyer for the items in a specific order. (Only display for non cb sip affiliate shop. ) |
| `↳↳ original_cost_of_goods_sold` | float | Amount paid by the buyer for the items in a specific order. (Only display for non cb sip affiliate shop. ) |
| `↳↳ original_shopee_discount` | float | Sum of each item Shopee discount of a specific order. This amount will return initial rebate value (i.e. remaining Shopee Item Rebate + remaining Shopee PIX Rebate) to seller. (Only display for non cb sip affiliate order. ) |
| `↳↳ seller_return_refund` | float | Amount returned to Seller in the event of Partial Return. |
| `↳↳ items` | object[] | This object contains the detailed breakdown for all the items in this order, including regular items(non-activity) and activity items. |
| `↳↳↳ item_id` | int64 | ID of item |
| `↳↳↳ item_name` | string | Name of item |
| `↳↳↳ item_sku` | string | A item SKU (stock keeping unit) is an identifier defined by a seller, sometimes called parent SKU. Item SKU can be assigned to an item in Shopee Listings. |
| `↳↳↳ model_id` | int64 | ID of the model that belongs to the same item. |
| `↳↳↳ model_name` | string | Name of the model that belongs to the same item. A seller can offer variations of the same item. For example, the seller could create a fixed-priced listing for a t-shirt design and offer the shirt in different colors and sizes. In this case, each color and size combination is a separate variation. Each variation can have a different quantity and price. |
| `↳↳↳ model_sku` | string | A model SKU (stock keeping unit) is an identifier defined by a seller. It is only intended for the seller's use. Many sellers assign a SKU to an item of a specific type, size, and color, which are variations of one item in Shopee Listings. |
| `↳↳↳ line_item_id` | int64 | The identity of order item. In case the order item is a bundle deal, this value will be unique to distinguish the order item. |
| `↳↳↳ original_price` | float | The original price of the item before ANY promotion/discount in the listing currency. It returns the subtotal of that specific item if quantity exceeds 1. |
| `↳↳↳ original_price_pri` | float | The agreed settlement price of items used as settlement basis, amount is in the primary currency. (Only display for CB SIP affiliate shop.) |
| `↳↳↳ selling_price` | float | For non-bundle deal case, this value will be same like item original_price; For bundle deal case, this value will be price of sum of item price before bundle deal promo but after item promo. It returns the subtotal of that specific item if quantity exceeds 1 (Only display for non cb sip affiliate shop.) |
| `↳↳↳ discounted_price` | float | The after-discount price of the item in the listing currency. It returns the subtotal of that specific item if quantity exceeds 1. If there is no discount, this value will be the same as that of original_price. |
| `↳↳↳ bcrs_deposit` | float | The deposit fee paid by buyer of $0.10 per container as part of the SG Beverage Container Return Scheme mandated by the National Environment Agency (NEA). This will be an initial value and will not update after RR/cancellation. |
| `↳↳↳ seller_discount` | float | The discount provided by seller for this item |
| `↳↳↳ shopee_discount` | float | Final sum of each item Shopee discount of a specific order. This amount will return remaining rebate value (i.e. remaining Shopee Item Rebate + remaining Shopee PIX Rebate) to seller. (Only display for non cb sip affiliate order. ) |
| `↳↳↳ discount_from_coin` | float | The offset of this item when the buyer consumed Shopee Coins upon checkout. In case of bundle deal item, this value will return 0. Due to technical restriction, this field will return incorrect value under bundle deal case if we don’t configure it to 0. |
| `↳↳↳ discount_from_voucher_shopee` | float | The offset of this item when the buyer use Shopee voucher. |
| `↳↳↳ discount_from_voucher_seller` | float | The offset of this item when the buyer use seller-specific voucher. |
| `↳↳↳ activity_type` | string | The type of the item, default is "". If the item is a bundle item the value is "bundle_deal", and if a add on deal item, the value is "add_on_deal" |
| `↳↳↳ activity_id` | uint64 | If bundle_deal the is id of bundle deal, if add_on_deal this is id of add on deal. |
| `↳↳↳ is_main_item` | boolean | Meaning a main or sub item for add_on_deal. |
| `↳↳↳ quantity_purchased` | int32 | This value indicates the number of identical items purchased at the same time by the same buyer from one listing/item. |
| `↳↳↳ is_b2c_shop_item` | boolean | Indicates whether this is a B2C owned item. |
| `↳↳↳ ams_commission_fee` | float | The amount of affiliate commission fee. Applicable for items sold via the Affiliate Program. |
| `↳↳↳ is_kit` | boolean | Indicates if this item is a kit. (only for BR local seller) |
| `↳↳↳ kit_items` | object | only applicable for BR local seller |
| `↳↳↳↳ original_product_id` | float | The merchant item identifier of the product within the kit (only for BR local seller) |
| `↳↳↳↳ original_model_id` | float | The merchant product model of the item within the kit. (only for BR local seller) |
| `↳↳↳↳ total_qty` | float | The quantity of this specific component within the kit. (only for BR local seller) |
| `↳↳↳↳ original_price` | float | The price of the item when it is listed as a standalone item. (only for BR local seller) |
| `↳↳↳↳ proportional_price` | float | The price of the item when it is listed within the kit (i.e. proportionally distributed) (only for BR local seller) |
| `↳↳↳ promotion_list` | object[] |  |
| `↳↳↳↳ promotion_type` | string | Indicates the type of item- or package-level promotion applied to a product. Each item can be associated with at most one item promotion and one package promotion at a time. Item Promotions: low_price_promotion deep_discount platform_sale seller_discount flash_sale wholesale welcome_package_free_gift brand_flash_sale in_shop_flash_sale synced_promo platform_streaming_price seller_streaming_price exclusive_streamer_price price_bidding_with_rebate price_bidding_without_rebate seller_advisor_price selling_price settlement_price campaign_settlement_price local_sip_settlement_price platform_exclusive_price seller_exclusive_price seller_member_exclusive_sku item_price order_sync_price Package Prom |
| `↳↳↳↳ promotion_id` | uint64 | Represents the unique identifier of a specific promotion applied to an item. Each promotion_id corresponds to a distinct promotion rule or campaign, defined under a particular promotion_type. |
| `↳↳ escrow_amount_pri` | float | The total amount in the prim currency that the seller is expected to receive for the order and will change before order completed . escrow_amount_pri=original_price_pri-seller_return_refund_pri-commission_fee_pri-service_fee_pri-drc_adjustable_refund_pri.(Only display for cb sip affiliate order. ) |
| `↳↳ buyer_total_amount_pri` | float | The total amount that paid by buyer in the primary currency. (Only display for cb sip affiliate order. ) |
| `↳↳ original_price_pri` | float | The original price of the item before ANY promotion/discount in the primary currency. It returns the subtotal of that specific item if quantity exceeds 1.(Only display for cb sip affiliate order. ) |
| `↳↳ seller_return_refund_pri` | float | Amount returned to Seller in the event of Partial Return in the primary currency. (Only display for cb sip affiliate shop. ) |
| `↳↳ commission_fee_pri` | float | The commission fee charged by Shopee platform if applicable in the primary currency. (Only display for cb sip affiliate shop. ) |
| `↳↳ service_fee_pri` | float | Amount charged by Shopee to seller for additional services in the primary currency. (Only display for cb sip affiliate shop. ) |
| `↳↳ drc_adjustable_refund_pri` | float | The adjustable refund amount from Shopee Dispute Resolution Center in the primary currency after proration. (Only applicable for cb sip affiliate shop.) |
| `↳↳ pri_currency` | string | The currency of the country or region where the shop that real seller operates. (Only display for cb sip affiliate shop. ) |
| `↳↳ aff_currency` | string | The currency of the country or region where shop opened in. (Only display for cb sip affiliate shop. ) |
| `↳↳ exchange_rate` | float | Exchange rate from primary shop currency to affiliate shop currency. |
| `↳↳ reverse_shipping_fee` | float | Shopee charges the reverse shipping fee for the returned order.The value of this field will be non-negative. |
| `↳↳ reverse_shipping_fee_sst` | float | The Service Tax charged on Reverse Shipping Fee for reverse shipping, based on Malaysia SST regulations for shipping fees on all orders. (Only applicable for non cb sip affiliate shop) |
| `↳↳ final_product_protection` | float | The total amount of product protection purchased during placing an order. |
| `↳↳ credit_card_promotion` | float | This value indicate the offset via credit card promotion. |
| `↳↳ credit_card_transaction_fee` | float | This value indicate the total transaction fee. credit_card_transaction_fee=buyer_transaction_fee+seller_transaction_fee |
| `↳↳ final_product_vat_tax` | float | Value-added Tax is required for online purchases based on EU Value-added Tax regulations . (Only display for non cb sip affiliate shop. ) |
| `↳↳ final_shipping_vat_tax` | float | Value-added Tax for product price is required for online purchases based on EU Value-added Tax regulations. (Only applicable for non cb sip affiliate shop. ) |
| `↳↳ campaign_fee` | float | The campaign fee charged by Shopee platform. Only available for some local Indonesian shops. |
| `↳↳ sip_subsidy` | float | The SIP subsidy amount is the difference between the item settlement price set by seller and item price actually paid by buyer. (Only available for CB SIP A Shops) |
| `↳↳ sip_subsidy_pri` | float | The SIP subsidy amount is the difference between the item settlement price set by seller and item price actually paid by buyer. This value is in the primary currency. (Only available for CB SIP A Shops) |
| `↳↳ rsf_seller_protection_fee_claim_amount` | float | The insurance claim amount if seller opt in to insurance program. this covers Reverse shipping Fee in the case of RR. As per Jun 2024: - For ID & MY Local: After Extension on coverage to FSF due to RR. this claim amount will consist of FSF + RSF claim. - For PH local: This will only cover RSF claim will be updated if there's any RR/cancellation |
| `↳↳ shipping_seller_protection_fee_amount` | float | Service fee charged to seller in MY,ID,PH,BR Local (as per Jun 2024) due to additional program purchased. |
| `↳↳ final_escrow_product_gst` | float | Goods and Service Tax for product price is required for imported goods (overseas orders) based on Singapore GST regulations. (Only applicable for non cb sip affiliate shop selling in Singapore) |
| `↳↳ final_escrow_shipping_gst` | float | Goods and Service Tax for shipping fee is required for imported goods (overseas orders) based on Singapore GST regulations. (Only applicable for non cb sip affiliate shop selling in Singapore.) |
| `↳↳ delivery_seller_protection_fee_premium_amount` | float | [Currently apply to ID & local orders only] An insurance premium charged to seller at the time parcel is picked up by 3PL for insurance in case of parcel lost/damaged by 3PL. |
| `↳↳ order_adjustment` | object[] | Order level adjustment transaction information. If the order without adjustment, no returned of the field. |
| `↳↳↳ amount` | float | adjustment transaction amount. |
| `↳↳↳ date` | timestamp | adjustment transaction complete date. |
| `↳↳↳ currency` | string | order level adjustment transaction's currency type. |
| `↳↳↳ adjustment_reason` | string | Reason for adjustment. Possible cases could be: - Return Refund deduction or compensation - logistic issue deduction or compensation - marketing fee deduction - payment related fee |
| `↳↳ total_adjustment_amount` | float | Total adjustment made to the order. |
| `↳↳ escrow_amount_after_adjustment` | float | Final income seller can get from this order after deduct the order-level adjustment. |
| `↳↳ order_ams_commission_fee` | float | The amount of affiliate commission fee for this order. Applicable for orders sold via the Affiliate Program. |
| `↳↳ buyer_payment_method` | string | The payment method buyer used when do the order checkout. |
| `↳↳ instalment_plan` | string | The instalment plan buyer chosen when do the order checkout. Only applicable when payment method support instalment. |
| `↳↳ sales_tax_on_lvg` | float | Sales Tax on Low Value Goods (LVG) is required for imported goods (overseas orders) based on Malaysia SST regulations for selective orders (e.g. CB LVG orders in MY) |
| `↳↳ final_return_to_seller_shipping_fee` | float | The amount of fee charged to seller (if any) for the failed delivery order. |
| `↳↳ withholding_tax` | float | Only for PH and ID local shops. PH : According to regulations issued by Bureau of Internal Revenue in PH, the Withholding Tax is applied to the gross remittances sent by Shopee to online suppliers of goods and services. ID : According to regulations issued by Directorate General of Taxation in ID, the Withholding Tax is applied to the income stated in the invoice generated via Shopee related to Seller and/or Merchants' sales in Shopee's platform. |
| `↳↳ overseas_return_service_fee` | float | This is overseas return service fee charged to sellers who register ORS program.(Only applicable for non cb sip affiliate shop) |
| `↳↳ prorated_coins_value_offset_return_items` | float | This is the prorated value from cash equivalent of coin offset due to adjustable RR.This field will only be updated when there is an adjustable RR. If it's a full RR or normal order will response 0. |
| `↳↳ prorated_shopee_voucher_offset_return_items` | float | This is the prorated refund value from shopee voucher discount due to adjustable RR.This field will only be updated when there is an adjustable RR. If it's a full RR or normal order will response 0. |
| `↳↳ prorated_seller_voucher_offset_return_items` | float | This is the prorated refund value from seller voucher discount due to adjustable RR.This field will only be updated when there is an adjustable RR. If it's a full RR or normal order will response 0. |
| `↳↳ prorated_payment_channel_promo_bank_offset_return_items` | float | This is the prorated value from bank payment channel promo due to adjustable RR.This field will only be updated when there is an adjustable RR.If it's a full RR or normal order will response 0. |
| `↳↳ prorated_payment_channel_promo_shopee_offset_return_items` | float | This is the prorated value from shopee payment channel promo due to adjustable RR.This field will only be updated when there is an adjustable RR.If it's a full RR or normal order will response 0. |
| `↳↳ fsf_seller_protection_fee_claim_amount` | float | The claim amount given to seller if seller opt in to shipping fee service program. this covers Forward Shipping Fee cost in the case of cancelled due to Failed delivery. |
| `↳↳ vat_on_imported_goods` | float | 7% VAT is charged for imported goods entering Thailand. 8% VAT is charged for imported goods entering Vietnam |
| `↳↳ tenure_info_list` | object |  |
| `↳↳↳ payment_channel_name` | string | Name of the payment channel that buyer used in checkout. |
| `↳↳↳ instalment_plan` | string | Tenure information. This will have value if payment channel used has tenure information, such as credit card. |
| `↳↳ withholding_vat_tax` | float | By VN law, E-commerce platforms need to Withhold VAT tax applicable to all VN business household and VN individual sellers |
| `↳↳ withholding_pit_tax` | float | By VN law, E-commerce platforms need to Withhold Personal Income Tax applicable to all VN business household and VN individual sellers |
| `↳↳ withholding_cit_tax` | float | By VN law, E-commerce platforms need to Withhold Personal Income Tax applicable to corporate sellers selling in VN region |
| `↳↳ tax_registration_code` | string | For VN Withholding Tax. This is the Tax Registration Number (TRN) from Seller Info (Business information) of the seller at the point of order creation |
| `↳↳ seller_order_processing_fee` | float | Order Processing Fee is the amount charged to sellers for every order created. |
| `↳↳ buyer_paid_packaging_fee` | float | The fee charged to the buyer for packaging materials |
| `↳↳ trade_in_bonus_by_seller` | float | The discount provided by Seller/ Retailers for buyers who opt for trade-in. |
| `↳↳ fbs_fee` | float | Fulfilled by Shopee (FBS) Fee applied to this order, covering costs such as handling and storage and packaging. Only for PH Local Orders. |
| `↳↳ net_commission_fee` | float | The respective fee amounts after the proportional rebate deduction.The total net commission fee applied to the order, calculated as the sum of all net commission fee items. -only for BR local sellers. |
| `↳↳ net_service_fee` | float | The respective fee amounts after the proportional rebate deduction.The total net service fee applied to the order, calculated as the sum of all net service fee items. -only for BR local sellers. |
| `↳↳ net_commission_fee_info_list` | object | Returns a breakdown of the net commission fees. -only for BR local sellers. |
| `↳↳↳ rule_id` | float | The unique identifier of the commission rule applied to calculate the net commission fee. |
| `↳↳↳ fee_amount` | float | The net commission fee amount calculated based on the corresponding commission rule. |
| `↳↳↳ rule_display_name` | string | The display name of the commission rule for reference and readability. |
| `↳↳ net_service_fee_info_list` | object | Returns a breakdown of the net service fees. -only for BR local sellers. |
| `↳↳↳ rule_id` | float | The unique identifier of the service fee rule applied to calculate the net service fee. |
| `↳↳↳ fee_amount` | float | The net service fee amount calculated based on the corresponding service fee rule. |
| `↳↳↳ rule_display_name` | string | The display name of the service fee rule for reference and readability. |
| `↳↳↳ category` | string | The category of the service fee, indicating the type of service the fee is charged for. |
| `↳↳ seller_product_rebate` | object | The shopee rebate borne by seller. -only for BR local sellers. |
| `↳↳↳ amount` | float | This is the portion of Shopee rebate borne by seller. |
| `↳↳↳ commission_fee_offset` | float | This is the offset to gross commission fee, reducing it to the net value. |
| `↳↳↳ service_fee_offset` | float | This is the offset to gross service fee, reducing it to the net value. |
| `↳↳ pix_discount` | float | [BR only]Final sum of pix discount of a specific order. (Only display for non cb sip affiliate shop.) |
| `↳↳ prorated_pix_discount_offset_return_items` | float | [BR only]This is the prorated value from pix discount due to adjustable RR. This field will only be updated when there is an adjustable RR. If it's a full RR or normal order, will response 0. |
| `↳↳ ads_escrow_top_up_fee_or_technical_support_fee` | float | Includes both ads escrow top up fee (auto escrow top up to your ads balance) and technical support fee (charged by Shopee) The actual fee type included in this field varies depending on the seller type and selling region, and may represent one of the following in Shopee Seller Center: Ads Escrow Top-Up Fee For local MY TH SG VN PH ID sellers and CNCB / JPCB / KRCB sellers selling in PH and ID For JPCB sellers selling in SG, MY, TH, and VN Technical Support Fee For CNCB sellers selling in SG, MY, TH, and VN Traffic Growth Fee For KRCB sellers selling in SG, MY, TH, and VN |
| `↳↳ th_import_duty` | float | [TH only] Import Duty collected for imported goods entering Thailand. |
| `↳↳ remaining_voucher` | float | [Only for BR local shop]Represents the portion of Shopee voucher that is not consumed after fee offset. |
| `↳↳ pay_per_sale` | float | Pay per Sale Ads Fee = Completed Order Sales attributed to ads / Target ROI |
| `↳ buyer_payment_info` | object | The buyer payment info at order checkout moment. (snapshot value) |
| `↳↳ buyer_payment_method` | string | The payment method used by buyer. |
| `↳↳ buyer_service_fee` | float | An additional service fee charged by shopee to Buyer at checkout. currently only applicable to ID region. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳ buyer_tax_amount` | float | The tax amount paid by buyer. currently this is a custom tax charged to CB orders in TW,CL,MX |
| `↳↳ buyer_total_amount` | float | The total amount paid by buyer at checkout moment. |
| `↳↳ shopeevip_subtotal` | float | The subscription fee paid by buyer for ShopeeVIP. |
| `↳↳ credit_card_promotion` | float | The promotion provided by credit card. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳ icms_tax_amount` | float | The icms tax paid by buyer. this is only applicable to BR region it is an initial value (will not be updated after RR/cancellation) |
| `↳↳ import_tax_amount` | float | The import tax paid by buyer. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳ initial_buyer_txn_fee` | float | Transaction fee paid by buyer for the order. (Only display for non cb sip affiliate shop. ). Most regions would have this fee charged to buyer at checkout depending on the fee rules applied in each region. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳ insurance_premium` | float | The insurance premium paid by buyer. Currently only applicable to some regions like PH, MY, ID, VN, SG and TH it is an initial value (will not be updated after RR/cancellation) |
| `↳↳ iof_tax_amount` | float | The iof tax paid by buyer. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳ is_paid_by_credit_card` | boolean | Whether this order is paid by credit card. it's related to payment channel used at checkout. Value: false,true |
| `↳↳ merchant_subtotal` | float | The total item price paid by buyer at checkout. it is an initial value and will not be updated after RR/cancellation |
| `↳↳ seller_voucher` | float | The voucher provided by seller to offset some value needs to be paid by buyer. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳ shipping_fee` | float | The shipping fee paid by buyer. (Only display for non cb sip affiliate shop. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳ shipping_fee_sst_amount` | float | The shipping fee sst paid by buyer. Currently apply to MY region only it is an initial value (will not be updated after RR/cancellation) |
| `↳↳ shopee_voucher` | float | The voucher provided by Shopee to offset the amount need to be paid by buyer. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳ shopee_coins_redeemed` | float | This is an amount of coin used by buyer at checkout to offset some amount to be paid. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳ buyer_paid_packaging_fee` | float | The fee charged to the buyer for packaging materials |
| `↳↳ trade_in_bonus` | float | The total amount of all trade-in bonuses applied to a transaction. This value is the summation of the bonuses contributed by all four parties: Shopee, Seller, Bank and Trade-in Partner. |
| `↳↳ bulky_handling_fee` | float | A fee charged to the buyer for the special handling and transportation required for items that exceed a specified weight or dimension threshold. Only for ID local seller |
| `↳↳ discount_pix` | float | The discount provided by PIX (Only applicable for BR region) |
| `↳↳ bcrs_deposit` | float | The deposit fee paid by buyer of $0.10 per container as part of the SG Beverage Container Return Scheme mandated by the National Environment Agency (NEA). This will be an initial value and will not update after RR/cancellation. |
| `↳↳ ads_voucher_discount` | float | The voucher provided by Ads team to offset the amount need to be paid by buyer. |
| `↳↳ buyer_instant_fee` | float | The subscription fee paid by buyer for instant (Only for BR Local Shops) |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · Invalid promotion ID. The promotion may have been recently added and not mapped to the system yet. Please raise a ticket on Open Platform for further verification. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Missing order_sn. Please include a valid order_sn to get escrow details. · Order SN provided is invalid or does not belong to you. Please enter a valid Order SN. · Internal server error · The request body is not a valid json format · Invalid or missing page_size parameter , please enter a valid value that is with 1-100, indicating the number of records within a page.

## v2.payment.set_shop_installment_status
`POST /api/v2/payment/set_shop_installment_status` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

Sets the staging capability of shop level.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `installment_status` | int | ✔ | The status of installment contains 1 and 0. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ installment_status` | int |  |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · The credit card installment tenures is wrong. · Get installment channel info failed. · Region has no not support credit card installment. · Shop is not in credit card installment whitelist. · Shop installment status is off. · The credit card installment item's price should be grater than or equal to 1000.

## v2.payment.get_shop_installment_status
`GET /api/v2/payment/get_shop_installment_status` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

Get the installment state of shop.

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | The business content of the response. |
| `↳ installment_status` | int | The installment status for the shop |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · The credit card installment tenures is wrong. · Get installment channel info failed. · Region has no not support credit card installment. · Shop is not in credit card installment whitelist. · Shop installment status is off. · The credit card installment item's price should be grater than or equal to 1000.

## v2.payment.get_payout_detail
`GET /api/v2/payment/get_payout_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

This API is applicable for Cross Border (CB) sellers only to get the shop's payout data, such as the payout amount, currency, FX rate, the payout's associated order income and adjustment records etc.

Lịch sử cập nhật: 2021-06-02: update the offline_adjustment_list

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_size` | int | ✔ | Number of pages returned max:100 |
| `page_no` | int | ✔ | The page number min:1 default:1 |
| `payout_time_from` | timestamp | ✔ | Strat time. Maximum time range is 15 days |
| `payout_time_to` | timestamp | ✔ | End time |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | The business content of the response |
| `↳ more` | boolean |  |
| `↳ payout_list` | object[] |  |
| `↳↳ payout_info` | object | The information of payout. |
| `↳↳↳ from_currency` | string | The settlement currency of orders. |
| `↳↳↳ payout_currency` | string | The actual currency of payout. |
| `↳↳↳ from_amount` | float | The settlement amount. |
| `↳↳↳ payout_amount` | float | The actual amount of payout. |
| `↳↳↳ exchange_rate` | string | The exchange rate. |
| `↳↳↳ payout_time` | timestamp | The time of payout. |
| `↳↳↳ pay_service` | string | The service provider of seller. Available value: payoneer, pingpong, lianlian. |
| `↳↳↳ payee_id` | string | Seller's account to receive the payout. |
| `↳↳ escrow_list` | object[] |  |
| `↳↳↳ escrow_amount` | float | The total amount that the seller is expected to receive for the order. |
| `↳↳↳ currency` | string | The currency used for calculating escrow amount. |
| `↳↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ offline_adjustment_list` | object[] | The list of offline adjustments. |
| `↳↳↳ adjustment_amount` | float | The amount of offline adjustments. |
| `↳↳↳ module` | string | The reason for offline adjustment. |
| `↳↳↳ remark` | string | The remark for the reason. |
| `↳↳↳ scenario` | string | The scenario of adjustment. |
| `↳↳↳ adjustment_level` | string | Dimension of offline adjustment. Available value: shop, order. |
| `↳↳↳ order_sn` | string | Shopee's unique identifier for an order. |

Lỗi riêng: There are B2C items that can't be added into your promotion · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · This API is no longer available in this region. If this is unexpected, please reach out to Customer Support for assistance. · Internal server error · The request body is not a valid json format · This payment API is only applicable for cross boarder shop · Invalid page_size parameter. Please provide a valid value between 1 and 100. If left empty, the default value of 40 will be applied.

## v2.payment.set_item_installment_status
`POST /api/v2/payment/set_item_installment_status` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

Set item installment.Only for TH、TW.

Lịch sử cập nhật: 2022-01-19: Add participate_plan_ahora and item_plan_ahora_list parameters; 2021-03-12: import from UAT

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id_list` | int[] | ✔ | The id array of the item, Max :100 |
| `tenure_list` | int[] | ✔ | Staged array, TH must be [3,6,10], TW region tenures must be in [3,6,12,24], [] means closed |
| `participate_plan_ahora` | boolean |  | Only applicable and required for local AR sellers. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | The business content of the response |
| `↳ item_installment_list` | object[] |  |
| `↳↳ item_id` | int | Item unique id |
| `↳↳ tenure_list` | int[] | The tenures of item support installment. [] represents with no installment |
| `↳ item_plan_ahora_list` | object[] | Only applicable for local AR sellers. |
| `↳↳ item_id` | int | Only applicable for local AR sellers. |
| `↳↳ participate_plan_ahor` | boolean | Only applicable for local AR sellers. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · The credit card installment tenures is wrong. · Get installment channel info failed. · Region has no not support credit card installment. · Shop is not in credit card installment whitelist. · Shop installment status is off. · The credit card installment item's price should be grater than or equal to 1000.

## v2.payment.get_item_installment_status
`POST /api/v2/payment/get_item_installment_status` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

Get item installment tenures.Only for TH、TW.

Lịch sử cập nhật: 2022-01-19: add item_plan_ahora_list parameters; 2021-03-12: import from UAT

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id_list` | int[] | ✔ | Item id array, Max :100 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | The business content of the response |
| `↳ item_installment_list` | object[] |  |
| `↳↳ item_id` | int | Item unique id |
| `↳↳ tenure_list` | int[] | The tenures of item support installment. [] represents with no installment |
| `↳ item_plan_ahora_list` | object[] | Only applicable for local AR sellers. |
| `↳↳ item_id` | int | Only applicable for local AR sellers. |
| `↳↳ participate_plan_ahora` | boolean | Only applicable for local AR sellers. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · The credit card installment tenures is wrong. · Get installment channel info failed. · Region has no not support credit card installment. · Shop is not in credit card installment whitelist. · Shop installment status is off. · The credit card installment item's price should be grater than or equal to 1000.

## v2.payment.get_payment_method_list
`GET /api/v2/payment/get_payment_method_list` · loại: Public · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

Obtain payment method (no authentication required)

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] |  |
| `↳ payment_method` | string[] |  |
| `↳ region` | string |  |

Lỗi riêng: There is no access_token in query. · Invalid access_token. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.payment.get_wallet_transaction_list
`GET /api/v2/payment/get_wallet_transaction_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

Use this API to get the transaction records of wallet. Only applicable for local shops

Lịch sử cập nhật: 2026-05-29: add txn_title, a new field implemented as current display is too generic "Adjustment by Shopee"; 2024-11-01: Add transaction_tab_type and money_flow in Request Parameter; 2022-11-03: add withdrawal id and root withdrawal id; 2022-09-26: delete the shop_name / withdraw_id / root_withdrawal_id response parameter; 2022-06-24: Optimize the create_time_from and create_time_to field "Required" information

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int | ✔ | Specifies the starting entry of data to return in the current call. Default is 0. if data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int | ✔ | If many transactions are available to retrieve, you may need to call GetTransactionList multiple times to retrieve all the data. Each result set is returned as a page of entries. Default is 40. Use the Pagination filters to control the maximum number of entries (<= 100) to retrieve per page (i.e., per call), the offset number to start next call. This integer value is usUed to specify the maximum number of entries to return in a single ""page"" of data. |
| `create_time_from` | int |  | The create_time_from field is the starting date range. The maximum date range that may be specified with the create_time_from and create_time_to fields is 15 days. |
| `create_time_to` | int |  | The create_time_to field is the ending date range. The maximum date range that may be specified with the create_time_from and create_time_to fields is 15 days. |
| `wallet_type` | string |  | This field indicates the wallet type. |
| `transaction_type` | string |  | Transaction type APIs: ESCROW_VERIFIED_ADD = 101; // Escrow has been verified and paid to seller ESCROW_VERIFIED_MINUS = 102; // Escrow has been verified and charged from seller as escrow amount is negative WITHDRAWAL_CREATED = 201; // The seller has created a withdrawal, so it’s deducted from balance WITHDRAWAL_COMPLETED = 202; // The withdrawal has been completed, so the ongoing amount decreases. WITHDRAWAL_CANCELLED = 203; // The withdrawal has been canceled, so the amount is added back to the seller balance. Ongoing amount decreases as well. ADJUSTMENT_ADD = 401; // One adjustment item has been paid to seller ADJUSTMENT_MINUS = 402; // One adjustment item has been charged from seller FBS |
| `money_flow` | string |  | It's to indicate whether user wants to only return : MONEY_IN = addition MONEY_OUT = Deduction if not specified, we will return all Note special case for TW JKO Pay, we will ignore Money_flow |
| `transaction_tab_type` | string |  | NOTE: Only 1 'transaction tab type' value should be passed in. Passing in more than 1 value (eg: comma separated values) will return default response. This is because the request param treats the value passed in as a single string. This to indicates the updated filtering type that client can use to specify which transaction type we want to return. it will have : Default wallet_order_income wallet_adjustment_filter wallet_wallet_payment wallet_refund_from_order wallet_withdrawals fast_escrow_repayment fast_pay seller_loan corporate_loan pix_transactions_filter open_finance_transactions_filter Note for BR, wallet txn type that linked to pix_transactions_filter and open_finance_transactions_fil |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ transaction_list` | object[] |  |
| `↳↳ status` | string | The status of the transaction，available values: FAILED,COMPLETED,PENDING,INITIAL. |
| `↳↳ transaction_type` | string | The type of transaction. |
| `↳↳ txn_title` | string | The transaction title sent by client (Adjustment Center) for adjustments, Only for ID local sellers for now. |
| `↳↳ amount` | float | The amount of transaction. |
| `↳↳ current_balance` | float | The current balance of this account. |
| `↳↳ create_time` | int | The create time of the transaction. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ refund_sn` | string | The serial number of return. |
| `↳↳ withdrawal_type` | string | The type of withdrawal. |
| `↳↳ transaction_fee` | float | This field indicates the transaction fee. |
| `↳↳ description` | string | The detailed description of TOPUP SUCCESS and TOPUP FAILED. |
| `↳↳ buyer_name` | string | The name of buyer. |
| `↳↳ pay_order_list` | object[] |  |
| `↳↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳↳ shop_name` | string | Name of the shop. |
| `↳↳ shop_name` | string | Name of the shop. |
| `↳↳ withdrawal_id` | int | Withdrawal ID when transaction type is withdraw_created, withdrawal_completed, withdrawal_cancelled. |
| `↳↳ reason` | string | The reason for ADJUSTMENT_ADD and ADJUSTMENT_MINUS. |
| `↳↳ root_withdrawal_id` | int | Use this field to indicate the event where a withdrawal is split into several withdrawals due to the withdrawal limit. |
| `↳↳ transaction_tab_type` | string | Description: A new response parameter added after: https://confluence.shopee.io/display/SPCT/%5BPRD%5D+%5BOpen+API%5D+Update+on+New+Open+API+to+fetch+Seller+wallet+Transaction This returns the updated transaction tab types that client can use to specify which transaction types they want to return. It will have the following tab types Default wallet_order_income wallet_adjustment_filter wallet_wallet_payment wallet_refund_from_order wallet_withdrawals fast_escrow_repayment fast_pay seller_loan corporate_loan pix_transactions_filter open_finance_transactions_filter Note for BR, currently in SOP live configuration, wallet txn type that linked to pix_transactions_filter and open_finance_transact |
| `↳↳ money_flow` | string | New response parameter provided after: https://confluence.shopee.io/display/SPCT/%5BPRD%5D+%5BOpen+API%5D+Update+on+New+Open+API+to+fetch+Seller+wallet+Transaction It's to indicate the money flow MONEY_IN = addition MONEY_OUT = deduction if not specified in request, will return both Note special case for TW JKO Pay, we will ignore Money_flow |
| `↳↳ outlet_shop_name` | string | The outlet shop name where this outlet transaction came from. (In the Original Instant Mart concept, outlet transactions are redirected to Mart.) |
| `↳ more` | boolean |  |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · The inner server err when send http request. · The param error: time period too large. · The param error: create_time_from bigger than create_time_to. · The param error: time is invalid

## v2.payment.get_escrow_list
`GET /api/v2/payment/get_escrow_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

Use this API to fetch the accounting list of order.

Lịch sử cập nhật: 2025-09-08: select type for some parameters

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `release_time_from` | timestamp | ✔ | Query start time |
| `release_time_to` | timestamp | ✔ | Query end time |
| `page_size` | int32 |  | Number of pages returned max:100 default:40 |
| `page_no` | int32 |  | The page number min:1 default:1 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | The business content of the response |
| `↳ escrow_list` | object[] | The list of escrow order sn. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ payout_amount` | float | The settlement amount |
| `↳↳ escrow_release_time` | timestamp | The release time |
| `↳ more` | boolean | This is to indicate whether the escrow list is more than one page. If this value is true, you may want to continue to check next page to retrieve escrow orders. |

Lỗi riêng: shop_id is required · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Get item failed. · Get escrow income failed. · The escrow item extinfo decoded failed. · The escrow income not found. · The escrow order extinfo decoded failed.

## v2.payment.get_payout_info
`GET /api/v2/payment/get_payout_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

This is a new API which applicable for Cross Border (CB) sellers only to get the shop's payout data, will be used for the original API v2.get_payout_details replacement, we provide data such as the payout amount, currency, FX rate, the payout's associated order income and adjustment records etc.

Lịch sử cập nhật: 2024-01-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `payout_time_from` | timestamp | ✔ | Start time. Maximum time range is 15 days |
| `payout_time_to` | timestamp | ✔ | Payout End time |
| `page_size` | int | ✔ | Number of pages returned max:100 |
| `cursor` | string | ✔ | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the offset can be some entry to start next call. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ payout_list` | object |  |
| `↳↳ from_currency` | string | The settlement currency of orders. |
| `↳↳ payout_currency` | string | The actual currency of payout. |
| `↳↳ from_amount` | float | The settlement amount. |
| `↳↳ payout_amount` | float | The actual amount of payout. |
| `↳↳ exchange_rate` | string | The exchange rate. |
| `↳↳ payout_time` | timestamp | The time of payout. |
| `↳↳ pay_service` | string | The service provider of seller. Available value: payoneer, pingpong, lianlian. |
| `↳↳ payee_id` | string | Seller's account to receive the payout. |
| `↳↳ encrypted_payout_id` | string | payout id used to query API "v2.get_billing_item_info" as request parameters. User can get detailed billing items under current payout |
| `↳ more` | boolean | True or False |
| `↳ next_cursor` | string | used for next batch data query. will return empty when all data been returned |

Lỗi riêng: There are B2C items that can't be added into your promotion · billing_transaction_info_type is required, format should be correct and input within 1-2 · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Invalid or missing cursor parameter. Please enter an empty string i.e. "" for the first request or use the next_cursor value returned from the previous response for subsequent requests. · Internal server error · The request body is not a valid json format · This payment API is only applicable for cross boarder shop · Invalid or missing page_size parameter , please enter a valid value that is with 1-100, indicating the number of records within a page.

## v2.payment.get_billing_transaction_info
`POST /api/v2/payment/get_billing_transaction_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP, Payment Service Provider

This API is applicable for Cross Border (CB) sellers only to get the detailed payout transaction data, both released and to-be released transaction can be found in here

Lịch sử cập nhật: 2024-01-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `billing_transaction_info_type` | int | ✔ | Billing transaction types: 1: TO_RELEASE, 2: RELEASED |
| `encrypted_payout_ids` | string[] |  | encrypted_payout_id get from API: v2.get_payout_info when encrypted_payout_id provided and billing_transaction_info_type=2, we will return the "released" billing items under this payout. when encrypted_payout_id not provided, we will return the "to release" billing items under hasn't form payout yet Max length: 100 |
| `cursor` | string | ✔ | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int | ✔ | Number of pages returned max:100 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ transactions` | object |  |
| `↳↳ amount` | float | each transaction's amount |
| `↳↳ currency` | string | transaction currency |
| `↳↳ order_sn` | string | transaction currency |
| `↳↳ cost_header` | string | transaction belongs to which type |
| `↳↳ scenario` | string | transaction detailed scenarios |
| `↳↳ remark` | string | detailed description for this transactions |
| `↳↳ level` | string | To define this transaction happen at order level or shop level. e.g. shop level adjustment |
| `↳↳ billing_transaction_type` | string | could be Escrow (Order Income) or Adjustment (for this order) |
| `↳↳ billing_transaction_status` | string | Will be either "To Release" or "Released". |
| `↳ more` | boolean |  |
| `↳ next_cursor` | string |  |

Lỗi riêng: cursor is required and format should be correct. Please check · Unknown error: ***. Something wrong. Please try later. · billing_transaction_info_type provided is invalid, please use one of the support billing item type values: 1 - To Release, 2 - Released. · page_size is required, format should be correct and input within 1-100 · payout ids{id1,id2,...} not found, please recheck if the id is correct or not · payout ids can not be empty when querying Released info · payout ids length exceed limit · shop_id is required · billing_transaction_info_type is required · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.payment.get_escrow_detail_batch
`GET /api/v2/payment/get_escrow_detail_batch` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

Use this API to fetch the details of order income by batch.

Lịch sử cập nhật: 2026-09-30: added a new escrow component: pay per sale; 2026-08-28: add "buyer instant fee" field for BR local shops; 2026-07-31: update the type of the "promotion_id" and "activity_id" to uint64; 2026-07-23: add "voucher_from_external_party" under "order_income"; 2026-07-17: update the field names under "kit_items": "mt_item_id" to "original_product_id", "mt_model_id" to "original_model_id", "parent_item_price" to "original_price", and "item_price_prorated" to "proportional_price"

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `order_sn_list` | string[] | ✔ | Shopee's unique identifier for an order. limit [1,50] The number of recommended requests ranges from 1 to 20 orders. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] |  |
| `↳ escrow_detail` | object | The escrow detail for one order |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. <path></path> |
| `↳↳ buyer_user_name` | string | The username of buyer. <path></path> |
| `↳↳ return_order_sn_list` | string[] | The list of the serial number of return. <path></path> |
| `↳↳ order_income` | object |  |
| `↳↳↳ escrow_amount` | float | The total amount that the seller is expected to receive for the order and will change before order is completed. For non cb sip affiliate shop (new formula): escrow_amount= original_cost_of_goods_sold-original_shopee_discount+seller_return_refund+ shopee_discounts- voucher_from_seller- seller_coin_cash_back+ buyer_paid_shipping_fee- actual_shipping_fee+ shopee_shipping_rebate+ shipping_fee_discount_from_3pl- reverse_shipping_fee+ rsf_seller_protection_fee_claim_amount+ fsf_seller_protection_fee_claim_amount- final_return_to_seller_shipping_fee- seller_transaction_fee- service_fee- commission_fee- campaign_fee- shipping_seller_protection_fee_premium_amount- delivery_seller_protection_fee_prem |
| `↳↳↳ order_original_price` | float | The original price of the item before ANY promotion/discount in the listing currency. It returns the subtotal of that specific item if quantity exceeds 1. |
| `↳↳↳ original_price` | float | The original price of the item before ANY promotion/discount in the listing currency. It returns the subtotal of that specific item if quantity exceeds 1. |
| `↳↳↳ order_selling_price` | float | This field value = sum of item unit price.selling price comes from the sum up of each item's unit price. For non-bundle deal case, this value will be same like order_original_price; For bundle deal case, this value will be price of sum of item price before bundle deal promo but after item promo.It returns the subtotal of that specific item if quantity exceeds 1. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ bcrs_deposit` | float | The deposit fee paid by buyer of $0.10 per container as part of the SG Beverage Container Return Scheme mandated by the National Environment Agency (NEA). This value might be updated after RR/cancellation. |
| `↳↳↳ order_seller_discount` | float | The total discount seller provided for this order. It returns the subtotal of that specific item if quantity exceeds 1. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ seller_discount` | float | Final sum of each item seller discount of a specific order. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ order_discounted_price` | float | The total discounted price for this order. It returns the subtotal of that specific item if quantity exceeds 1. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ shopee_discount` | float | Final sum of each item Shopee discount of a specific order. This amount will return remaining rebate value (i.e. remaining Shopee Item Rebate + remaining Shopee PIX Rebate) to seller. (Only display for non cb sip affiliate order. ) |
| `↳↳↳ voucher_from_seller` | float | Final value of voucher provided by Seller for the order. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ voucher_from_shopee` | float | Final value of voucher provided by Shopee for the order. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ voucher_from_external_party` | float | Final value of voucher provided by External Party for the order. (Only display for non cb sip affiliate shop.) |
| `↳↳↳ coins` | float | This value indicates the total amount offset when the buyer consumed Shopee Coins upon checkout. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ cross_border_tax` | float | Amount incurred by Buyer for purchasing items outside of home country. Amount may change after Return Refund. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ payment_promotion` | float | The amount offset via payment promotion. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ commission_fee` | float | The commission fee charged by Shopee platform if applicable. For CB SIP affiliate shop: commission_fee=commission_fee_pri * exchange_rate |
| `↳↳↳ service_fee` | float | Amount charged by Shopee to seller for additional services. For CB SIP affiliate shop: service_fee=service_fee_pri * exchange_rate |
| `↳↳↳ seller_transaction_fee` | float | Tansaction fee paid by seller for the order. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ seller_lost_compensation` | float | Compensation to seller in case of lost parcel. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ seller_coin_cash_back` | float | Value of coins provided by Seller for purchasing with his or her store for the order. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ escrow_tax` | float | Cross-border tax imposed by the Indonesian government on sellers. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ final_shipping_fee` | float | Final adjusted amount that seller has to bear as part of escrow. This amount could be negative or positive. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ actual_shipping_fee` | float | The final shipping cost of order and it is positive. For Non-integrated logistics channel is 0. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ shopee_shipping_rebate` | float | The platform shipping subsidy to the seller. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ shipping_fee_sst` | float | The Service Tax charged on Seller Paid Shipping Fee for forward shipping, based on Malaysia SST regulations for shipping fees on all orders. Definition of Seller Paid Shipping Fee is Actual Shipping Fee subtracted by sum of Shipping Fee Paid by Buyer and Shipping Rebate From Shopee. (Only applicable for non cb sip affiliate shop) |
| `↳↳↳ shipping_fee_discount_from_pl` | float | The discount of shipping fee from 3PL. Currently only applicable to ID. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ seller_shipping_discount` | float | The shipping discount defined by seller. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ estimated_shipping_fee` | float | The estimated shipping fee is an estimation calculated by Shopee based on specific logistics courier's standard. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ seller_voucher_code` | float | The list of voucher code provided by seller. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ drc_adjustable_refund` | float | The adjustable refund amount from Shopee Dispute Resolution Center. |
| `↳↳↳ refund_amount_to_buyer` | float | Amount returned to Seller in the event of Partial Return. |
| `↳↳↳ cost_of_goods_sold` | float | Final amount paid by the buyer for the items in a specific order. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ original_cost_of_goods_sold` | float | Amount paid by the buyer for the items in a specific order. (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ original_shopee_discount` | float | Sum of each item Shopee discount of a specific order. This amount will return initial rebate value (i.e. remaining Shopee Item Rebate + remaining Shopee PIX Rebate) to seller. (Only display for non cb sip affiliate order. ) |
| `↳↳↳ items` | object[] | This object contains the detailed breakdown for all the items in this order, including regular items(non-activity) and activity items. |
| `↳↳↳↳ item_id` | int64 | ID of item |
| `↳↳↳↳ item_name` | string | Name of item |
| `↳↳↳↳ item_sku` | string | A item SKU (stock keeping unit) is an identifier defined by a seller, sometimes called parent SKU. Item SKU can be assigned to an item in Shopee Listings. |
| `↳↳↳↳ model_id` | int64 | ID of the model that belongs to the same item. |
| `↳↳↳↳ model_name` | string | Name of the model that belongs to the same item. A seller can offer variations of the same item. For example, the seller could create a fixed-priced listing for a t-shirt design and offer the shirt in different colors and sizes. In this case, each color and size combination is a separate variation. Each variation can have a different quantity and price. |
| `↳↳↳↳ model_sku` | string | A model SKU (stock keeping unit) is an identifier defined by a seller. It is only intended for the seller's use. Many sellers assign a SKU to an item of a specific type, size, and color, which are variations of one item in Shopee Listings. |
| `↳↳↳↳ line_item_id` | int64 | The identity of order item. In case the order item is a bundle deal, this value will be unique to distinguish the order item. |
| `↳↳↳↳ original_price` | float | The original price of the item before ANY promotion/discount in the listing currency. It returns the subtotal of that specific item if quantity exceeds 1. |
| `↳↳↳↳ original_price_pri` | float | The agreed settlement price of items used as settlement basis, amount is in the primary currency. (Only display for CB SIP affiliate shop.) |
| `↳↳↳↳ selling_price` | float | For non-bundle deal case, this value will be same like item original_price; For bundle deal case, this value will be price of sum of item price before bundle deal promo but after item promo. It returns the subtotal of that specific item if quantity exceeds 1 (Only display for non cb sip affiliate shop.) |
| `↳↳↳↳ discounted_price` | float | The after-discount price of the item in the listing currency. It returns the subtotal of that specific item if quantity exceeds 1. If there is no discount, this value will be the same as that of original_price. |
| `↳↳↳↳ bcrs_deposit` | float | The deposit fee paid by buyer of $0.10 per container as part of the SG Beverage Container Return Scheme mandated by the National Environment Agency (NEA). This will be an initial value and will not update after RR/cancellation. |
| `↳↳↳↳ seller_discount` | float | The discount provided by seller for this item |
| `↳↳↳↳ shopee_discount` | float | The discount provided by Shopee for this item |
| `↳↳↳↳ discount_from_coin` | float | The offset of this item when the buyer consumed Shopee Coins upon checkout. In case of bundle deal item, this value will return 0. Due to technical restriction, this field will return incorrect value under bundle deal case if we don’t configure it to 0. |
| `↳↳↳↳ discount_from_voucher_shopee` | float | The offset of this item when the buyer use Shopee voucher. |
| `↳↳↳↳ discount_from_voucher_seller` | float | The offset of this item when the buyer use seller-specific voucher. |
| `↳↳↳↳ activity_type` | string | The type of the item, default is "". If the item is a bundle item the value is "bundle_deal", and if a add on deal item, the value is "add_on_deal" |
| `↳↳↳↳ activity_id` | uint64 | If bundle_deal the is id of bundle deal, if add_on_deal this is id of add on deal. |
| `↳↳↳↳ is_main_item` | boolean | Meaning a main or sub item for add_on_deal. |
| `↳↳↳↳ quantity_purchased` | int32 | This value indicates the number of identical items purchased at the same time by the same buyer from one listing/item. |
| `↳↳↳↳ is_b2c_shop_item` | boolean | Indicates whether this is a B2C owned item. |
| `↳↳↳↳ ams_commission_fee` | float | The amount of affiliate commission fee. Applicable for items sold via the Affiliate Program. |
| `↳↳↳↳ is_kit` | boolean | Indicates if this item is a kit. (Only for BR Local Sellers) |
| `↳↳↳↳ kit_items` | object | Only applicable to BR local sellers |
| `↳↳↳↳↳ original_product_id` | float | The merchant item identifier of the product within the kit (Only for BR Local Sellers) |
| `↳↳↳↳↳ original_model_id` | float | The merchant product model of the item within the kit (Only for BR Local Sellers) |
| `↳↳↳↳↳ total_qty` | float | The quantity of this specific component within the kit. (Only for BR Local Sellers) |
| `↳↳↳↳↳ original_price` | float | The price of the item when it is listed as a standalone item. |
| `↳↳↳↳↳ proportional_price` | float | The price of the item when it is listed within the kit (i.e. proportionally distributed) (Only for BR Local Sellers) |
| `↳↳↳↳ promotion_list` | object[] |  |
| `↳↳↳↳↳ promotion_type` | string | Indicates the type of item- or package-level promotion applied to a product. Each item can be associated with at most one item promotion and one package promotion at a time. Item Promotions: low_price_promotion deep_discount platform_sale seller_discount flash_sale wholesale welcome_package_free_gift brand_flash_sale in_shop_flash_sale synced_promo platform_streaming_price seller_streaming_price exclusive_streamer_price price_bidding_with_rebate price_bidding_without_rebate seller_advisor_price selling_price settlement_price campaign_settlement_price local_sip_settlement_price platform_exclusive_price seller_exclusive_price seller_member_exclusive_sku item_price order_sync_price Package Prom |
| `↳↳↳↳↳ promotion_id` | uint64 | Represents the unique identifier of a specific promotion applied to an item. Each promotion_id corresponds to a distinct promotion rule or campaign, defined under a particular promotion_type. |
| `↳↳↳ escrow_amount_pri` | float | The total amount in the prim currency that the seller is expected to receive for the order and will change before order completed . escrow_amount_pri=original_price_pri-seller_return_refund_pri-commission_fee_pri-service_fee_pri-drc_adjustable_refund_pri.(Only display for cb sip affiliate order. ) |
| `↳↳↳ buyer_total_amount_pri` | float | The total amount that paid by buyer in the primary currency. (Only display for cb sip affiliate order. ) |
| `↳↳↳ original_price_pri` | float | The original price of the item before ANY promotion/discount in the primary currency. It returns the subtotal of that specific item if quantity exceeds 1.(Only display for cb sip affiliate order. ) <path></path> |
| `↳↳↳ seller_return_refund_pri` | float | Amount returned to Seller in the event of Partial Return in the primary currency. (Only display for cb sip affiliate shop. ) |
| `↳↳↳ commission_fee_pri` | float | The commission fee charged by Shopee platform if applicable in the primary currency. (Only display for cb sip affiliate shop. ) |
| `↳↳↳ service_fee_pri` | float | Amount charged by Shopee to seller for additional services in the primary currency. (Only display for cb sip affiliate shop. ) |
| `↳↳↳ drc_adjustable_refund_pri` | float | The adjustable refund amount from Shopee Dispute Resolution Center in the primary currency after proration. (Only applicable for cb sip affiliate shop.) |
| `↳↳↳ pri_currency` | string | The currency of the country or region where the shop that real seller operates. (Only display for cb sip affiliate shop. ) |
| `↳↳↳ aff_currency` | string | The currency of the country or region where shop opened in. (Only display for cb sip affiliate shop. ) |
| `↳↳↳ exchange_rate` | float | Exchange rate from primary shop currency to affiliate shop currency. |
| `↳↳↳ reverse_shipping_fee` | float | Shopee charges the reverse shipping fee for the returned order.The value of this field will be non-negative. |
| `↳↳↳ reverse_shipping_fee_sst` | float | The Service Tax charged on Reverse Shipping Fee for reverse shipping, based on Malaysia SST regulations for shipping fees on all orders. (Only applicable for non cb sip affiliate shop) |
| `↳↳↳ final_product_protection` | float | The total amount of product protection purchased during placing an order. |
| `↳↳↳ credit_card_promotion` | float | This value indicate the offset via credit card promotion. |
| `↳↳↳ credit_card_transaction_fee` | float | This value indicate the total transaction fee. credit_card_transaction_fee=buyer_transaction_fee+seller_transaction_fee |
| `↳↳↳ final_product_vat_tax` | float | Value-added Tax is required for online purchases based on EU Value-added Tax regulations . (Only display for non cb sip affiliate shop. ) |
| `↳↳↳ final_shipping_vat_tax` | float | Value-added Tax for product price is required for online purchases based on EU Value-added Tax regulations. (Only applicable for non cb sip affiliate shop. ) |
| `↳↳↳ campaign_fee` | float | The campaign fee charged by Shopee platform. Only available for some local Indonesian shops. |
| `↳↳↳ sip_subsidy` | float | The SIP subsidy amount is the difference between the item settlement price set by seller and item price actually paid by buyer. (Only available for CB SIP A Shops) |
| `↳↳↳ sip_subsidy_pri` | float | The SIP subsidy amount is the difference between the item settlement price set by seller and item price actually paid by buyer. This value is in the primary currency. (Only available for CB SIP A Shops) |
| `↳↳↳ rsf_seller_protection_fee_claim_amount` | float | The insurance claim amount if seller opt in to insurance program. this covers Reverse shipping Fee in the case of RR. As per Jun 2024: - For ID & MY Local: After Extension on coverage to FSF due to RR. this claim amount will consist of FSF + RSF claim. - For PH local: This will only cover RSF claim will be updated if there's any RR/cancellation |
| `↳↳↳ rsf_seller_protection_fee_premium_amount` | float | Amount charged by Shopee to seller for additional services. Only apply for PH local orders. |
| `↳↳↳ final_escrow_product_gst` | float | Goods and Service Tax for product price is required for imported goods (overseas orders) based on Singapore GST regulations. (Only applicable for non cb sip affiliate shop selling in Singapore) |
| `↳↳↳ final_escrow_shipping_gst` | float | Goods and Service Tax for shipping fee is required for imported goods (overseas orders) based on Singapore GST regulations. (Only applicable for non cb sip affiliate shop selling in Singapore.) |
| `↳↳↳ delivery_seller_protection_fee_premium_amount` | float | [Currently apply to ID & local orders only] An insurance premium charged to seller at the time parcel is picked up by 3PL for insurance in case of parcel lost/damaged by 3PL. |
| `↳↳↳ order_ams_commission_fee` | float | The amount of affiliate commission fee for this order. Applicable for orders sold via the Affiliate Program. |
| `↳↳↳ buyer_payment_method` | float | The payment method buyer used when do the order checkout. |
| `↳↳↳ instalment_plan` | float | The instalment plan buyer chosen when do the order checkout. Only applicable when payment method support instalment. |
| `↳↳↳ sales_tax_on_lvg` | float | Sales Tax on Low Value Goods (LVG) is required for imported goods (overseas orders) based on Malaysia SST regulations for selective orders (e.g. CB LVG orders in MY) |
| `↳↳↳ withholding_tax` | float | Only for PH and ID local shops. PH: According to regulations issued by Bureau of Internal Revenue in PH, the Withholding Tax is applied to the gross remittances sent by Shopee to online suppliers of goods and services. ID: According to regulations issued by Directorate General of Taxation in ID, the Withholding Tax is applied to the income stated in the invoice generated via Shopee related to Seller and/or Merchants' sales in Shopee's platform. |
| `↳↳↳ overseas_return_service_fee` | float | This is overseas return service fee charged to sellers who register ORS program.(Only applicable for non cb sip affiliate shop) |
| `↳↳↳ prorated_coins_value_offset_return_items` | float | This is the prorated value from cash equivalent of coin offset due to adjustable RR.This field will only be updated when there is an adjustable RR. If it's a full RR or normal order will response 0. |
| `↳↳↳ prorated_shopee_voucher_offset_return_items` | float | This is the prorated refund value from shopee voucher discount due to adjustable RR.This field will only be updated when there is an adjustable RR. If it's a full RR or normal order will response 0. |
| `↳↳↳ prorated_seller_voucher_offset_return_items` | float | This is the prorated refund value from seller voucher discount due to adjustable RR.This field will only be updated when there is an adjustable RR. If it's a full RR or normal order will response 0. |
| `↳↳↳ prorated_payment_channel_promo_bank_offset_return_items` | float | This is the prorated value from bank payment channel promo due to adjustable RR.This field will only be updated when there is an adjustable RR.If it's a full RR or normal order will response 0. |
| `↳↳↳ prorated_payment_channel_promo_shopee_offset_return_items` | float | This is the prorated value from shopee payment channel promo due to adjustable RR.This field will only be updated when there is an adjustable RR.If it's a full RR or normal order will response 0. |
| `↳↳↳ fsf_seller_protection_fee_claim_amount` | float | The claim amount given to seller if seller opt in to shipping fee service program. this covers Forward Shipping Fee cost in the case of cancelled due to Failed delivery. only apply to PH Local as per Jun 2024. |
| `↳↳↳ shipping_seller_protection_fee_amount` | float | Service fee charged to seller in MY,ID,PH,BR Local (as per Jun 2024) due to additional program purchased |
| `↳↳↳ final_return_to_seller_shipping_fee` | float | The amount of fee charged to seller (if any) for the failed delivery order |
| `↳↳↳ vat_on_imported_goods` | float | 7% VAT is charged for imported goods entering Thailand |
| `↳↳↳ withholding_vat_tax` | float | By VN law, E-commerce platforms need to Withhold VAT tax applicable to all VN business household and VN individual sellers |
| `↳↳↳ withholding_pit_tax` | float | By VN law, E-commerce platforms need to Withhold Personal Income Tax applicable to all VN business household and VN individual sellers |
| `↳↳↳ withholding_cit_tax` | float | By VN law, E-commerce platforms need to Withhold Personal Income Tax applicable to corporate sellers selling in VN region |
| `↳↳↳ tax_registration_code` | string | For VN Withholding Tax. This is the Tax Registration Number (TRN) from Seller Info (Business information) of the seller at the point of order creation |
| `↳↳↳ seller_order_processing_fee` | float | Order Processing Fee is the amount charged to sellers for every order created. |
| `↳↳↳ buyer_paid_packaging_fee` | float | The fee charged to the buyer for packaging materials. |
| `↳↳↳ trade_in_bonus_seller` | float | The discount provided by Seller/Retailers for buyers who opt for trade-in. |
| `↳↳↳ fbs_fee` | float | Fulfilled by Shopee (FBS) Fee applied to this order, covering costs such as handling and storage and packaging. Only for PH Local Orders. |
| `↳↳↳ net_commission_fee` | float | The respective fee amounts after the proportional rebate deduction.The total net commission fee applied to the order, calculated as the sum of all net commission fee items. -only for BR local sellers. |
| `↳↳↳ net_service_fee` | float | The respective fee amounts after the proportional rebate deduction.The total net service fee applied to the order, calculated as the sum of all net service fee items. -only for BR local sellers. |
| `↳↳↳ net_commission_fee_info_list` | object | Returns a breakdown of the net commission fees. -only for BR local sellers. |
| `↳↳↳↳ rule_id` | float | The unique identifier of the commission rule applied to calculate the net commission fee. |
| `↳↳↳↳ fee_amount` | float | The net commission fee amount calculated based on the corresponding commission rule. |
| `↳↳↳↳ rule_display_name` | string | The display name of the commission rule for reference and readability. |
| `↳↳↳ net_service_fee_info_list` | object | Returns a breakdown of the net service fees. -only for BR local sellers. |
| `↳↳↳↳ rule_id` | float | The unique identifier of the service fee rule applied to calculate the net service fee. |
| `↳↳↳↳ fee_amount` | float | The net service fee amount calculated based on the corresponding service fee rule. |
| `↳↳↳↳ rule_display_name` | string | The display name of the service fee rule for reference and readability. |
| `↳↳↳↳ category` | string | The category of the service fee, indicating the type of service the fee is charged for. |
| `↳↳↳ seller_product_rebate` | object | The shopee rebate borne by seller. -only for BR local sellers. |
| `↳↳↳↳ amount` | float | This is the portion of Shopee rebate borne by seller. |
| `↳↳↳↳ commission_fee_offset` | float | This is the offset to gross commission fee, reducing it to the net value. |
| `↳↳↳↳ service_fee_offset` | float | This is the offset to gross service fee, reducing it to the net value. |
| `↳↳↳ pix_discount` | float | [BR only]Final sum of pix discount of a specific order. (Only display for non cb sip affiliate shop.) |
| `↳↳↳ prorated_pix_discount_offset_return_items` | float | [BR only]This is the prorated value from pix discount due to adjustable RR. This field will only be updated when there is an adjustable RR. If it's a full RR or normal order, will response 0. |
| `↳↳↳ ads_escrow_top_up_fee_or_technical_support_fee` | float | Includes both ads escrow top up fee (auto escrow top up to your ads balance) and technical support fee (charged by Shopee) The actual fee type included in this field varies depending on the seller type and selling region, and may represent one of the following in Shopee Seller Center: Ads Escrow Top-Up Fee For local MY TH SG VN PH ID sellers and CNCB / JPCB / KRCB sellers selling in PH and ID For JPCB sellers selling in SG, MY, TH, and VN Technical Support Fee For CNCB sellers selling in SG, MY, TH, and VN Traffic Growth Fee For KRCB sellers selling in SG, MY, TH, and VN |
| `↳↳↳ pay_per_sale` | float | Pay per Sale Ads Fee = Completed Order Sales attributed to ads / Target ROI |
| `↳↳↳ th_import_duty` | float | [TH only] Import Duty collected for imported goods entering Thailand |
| `↳↳↳ remaining_voucher` | float | [Only for BR local shop]Represents the portion of Shopee voucher that is not consumed after fee offset. |
| `↳↳ buyer_payment_info` | object | The buyer payment info at order checkout moment. (snapshot value) |
| `↳↳↳ buyer_payment_method` | string | The payment method used by buyer. |
| `↳↳↳ buyer_service_fee` | string | An additional service fee charged by shopee to Buyer at checkout. currently only applicable to ID region. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳↳ buyer_tax_amount` | float | The tax amount paid by buyer. currently this is a custom tax charged to CB orders in TW,CL,MX |
| `↳↳↳ buyer_total_amount` | float | The total amount paid by buyer at checkout moment. |
| `↳↳↳ shopeevip_subtotal` | float | The subscription fee paid by buyer for ShopeeVIP. |
| `↳↳↳ bcrs_discount` | float | The deposit fee paid by buyer of $0.10 per container as part of the SG Beverage Container Return Scheme mandated by the National Environment Agency (NEA). This will be an initial value and will not update after RR/cancellation. |
| `↳↳↳ credit_card_promotion` | float | The promotion provided by credit card. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳↳ icms_tax_amount` | float | The icms tax paid by buyer. this is only applicable to BR region. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳↳ import_tax_amount` | float | The import tax paid by buyer. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳↳ initial_buyer_txn_fee` | float | Transaction fee paid by buyer for the order. (Only display for non cb sip affiliate shop. ). Most regions would have this fee charged to buyer at checkout depending on the fee rules applied in each region. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳↳ insurance_premium` | float | The insurance premium paid by buyer. Currently only applicable to some regions like ID & BR it is an initial value (will not be updated after RR/cancellation) |
| `↳↳↳ iof_tax_amount` | float | The iof tax paid by buyer. this is only applicable for BR region. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳↳ is_paid_by_credit_card` | boolean | Whether this order is paid by credit card. it's related to payment channel used at checkout |
| `↳↳↳ merchant_subtotal` | float | The total item price paid by buyer at checkout. it is an initial value and will not be updated after RR/cancellation |
| `↳↳↳ seller_voucher` | float | The voucher provided by seller to offset some value needs to be paid by buyer. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳↳ shipping_fee` | float | The shipping fee paid by buyer. (Only display for non cb sip affiliate shop. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳↳ shipping_fee_sst_amount` | float | The shipping fee sst paid by buyer. Currently apply to MY region only it is an initial value (will not be updated after RR/cancellation) |
| `↳↳↳ shopee_voucher` | float | The voucher provided by Shopee to offset the amount need to be paid by buyer. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳↳ shopee_coins_redeemed` | float | This is an amount of coin used by buyer at checkout to offset some amount to be paid. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳↳ buyer_paid_packaging_fee` | float | The fee charged to the buyer for packaging materials. |
| `↳↳↳ trade_in_bonus` | float | The total amount of all trade-in bonuses applied to a transaction. This value is the summation of the bonuses contributed by all four parties: Shopee, Seller, Bank and Trade-in Partner. |
| `↳↳↳ bulky_handling_fee` | float | A fee charged to the buyer for the special handling and transportation required for items that exceed a specified weight or dimension threshold.Only for local ID sellers. |
| `↳↳↳ discount_pix` | float | The discount provided by PIX (Only applicable for BR region) |
| `↳↳↳ bcrs_deposit` | float | The deposit fee paid by buyer of $0.10 per container as part of the SG Beverage Container Return Scheme mandated by the National Environment Agency (NEA). This will be an initial value and will not update after RR/cancellation. |
| `↳↳↳ ads_voucher_discount` | float | The voucher provided by Ads team to offset the amount need to be paid by buyer. it is an initial value (will not be updated after RR/cancellation) |
| `↳↳↳ buyer_instant_fee` | float | The subscription fee paid by buyer for instant (Only for BR Local Shops) |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · order_sn_list is required, format should be string[] · Your request exceeds the max limit of 50 orders. · Internal server error · The request body is not a valid json format · supplier order item income not found

## v2.payment.generate_income_statement
`GET /api/v2/payment/generate_income_statement` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

Trigger income statement generation.

Lịch sử cập nhật: 2024-12-12: Update the description of the time; -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `release_time_from` | int64 | ✔ | The release_time_from must be - Monday (local time) for a weekly report - The 1st day (local time) of a Month for a monthly report |
| `release_time_to` | int64 | ✔ | The release_time_to must be - Sunday (local time) for a weekly report - The last day (local time) of a Month for a monthly report |
| `statement_type` | int32 | ✔ | STATEMENT_TYPE_WEEKLY = 1; STATEMENT_TYPE_MONTHLY = 2; Local seller Income statement requires this value to be set. CB seller income statement does not require this. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ id` | int64 | Identifier of income statement file. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid Time Range: Only records from the past 5 years are supported for the TW region. · Shop is not a mart shop. Please use Mart Shop ID. · Invalid time range, Weekly reports must span from Day 1 (Monday) to Day 7 (Sunday), and monthly reports must cover from 1st to last day of the month. · Wrong income statement type. Please provide the correct parameter. · Wrong income statement type. Please provide the correct parameter. · Wrong income statement type. Please provide the correct parameter. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · For local sellers, please input weekly or monthly.

## v2.payment.get_income_statement
`GET /api/v2/payment/get_income_statement` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

To query income statement status and provide file link if the income statement is ready to be downloaded.

Lịch sử cập nhật: 2024-12-04: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `income_statement_id` | int64 | ✔ | The identifier for income statement file request. return from the API v2.payment.generate_income_statement |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ id` | int64 | The identifier for income statement file request. |
| `↳ file_name` | string | Income statement file name. |
| `↳ status` | int32 | STATUS_INVALID = 0; STATUS_PROCESSING = 1; STATUS_DOWNLOADABLE = 2; STATUS_DOWNLOADED = 3; STATUS_FAILED = 4; |
| `↳ generated_time` | int64 | File generation time. |
| `↳ file_link` | string | Link to download income statement file. |

Lỗi riêng: Wrong document ID provided. Please provide the correct ID in integer format. · parse data failed · data not exist · parameter invalid · Invalid Time Range: Only records from the past 5 years are supported for the TW region. · Shop is not a mart shop. Please use Mart Shop ID. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.payment.generate_income_report
`GET /api/v2/payment/generate_income_report` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

Trigger income report generation.

Lịch sử cập nhật: 2025-05-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `release_time_from` | int64 | ✔ | Start time in epoch |
| `release_time_to` | int64 | ✔ | End time in epoch |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ id` | int64 | Identifier of income report file. |
| `msg` | string | error message |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid Time Range: Only records from the past 5 years are supported for the TW region. · Shop is not a mart shop. Please use Mart Shop ID. · release_time_from and/or release_time_to parameter is missing or invalid. Please provide both a valid start date, and end date to query where start date cannot be later than the end date. · Please enter a valid time range input, where the start date should not be later than the end date. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.payment.get_income_report
`GET /api/v2/payment/get_income_report` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance, Swam ERP

To query income report status and provide file link if the income report is ready to be downloaded.

Lịch sử cập nhật: 2025-05-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `income_report_id` | int64 | ✔ | The identifier for income report file request. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ id` | int64 | The identifier for income statement file request. |
| `↳ file_name` | string | Income report file name. |
| `↳ status` | int32 | STATUS_INVALID = 0; STATUS_PROCESSING = 1; STATUS_DOWNLOADABLE = 2; STATUS_DOWNLOADED = 3; STATUS_FAILED = 4; |
| `↳ generated_time` | int64 | File generation time. |
| `↳ file_link` | string | Link to download income report file. |
| `msg` | string | Error Message |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Invalid Time Range: Only records from the past 5 years are supported for the TW region. · Shop is not a mart shop. Please use Mart Shop ID. · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.payment.get_income_overview
`GET /api/v2/payment/get_income_overview` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance

Retrieves a consolidated snapshot of the seller’s income amounts categorized by income status for a specified shop. This API provides a holistic overview similar to Seller Center’s “Income Overview” section, allowing external systems to reflect the same current payout view. Data is dynamically determined based on the shop type (Local or Cross Border) and the income status requested. Historical income results are not retrievable, providing consistent information as Seller Centre.

Lịch sử cập nhật: 2025-10-21: x; 2025-10-14: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `income_status` | int32 |  | Status of Seller Income payout (Enum - Desc) Local Shop 1 -Released 2 - Pending CB Shop 0 - To Release 1 - Released 2 - Pending Note: By default, if Income Status was not provided in the request params (non mandatory), API response will return all values for all Income status based on either Local/CB |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ latest_payout_date` | string | The latest payout date for the released income. Format: YYYY-MM-DD. Only for CN shops. |
| `↳ total_income` | object | Object containing total income components. |
| `↳↳ pending_amount` | float | Total amount pending release (Local: orders before ESCROW_PAID; CB: orders before ESCROW_PAYOUT). <path></path> |
| `↳↳ to_release_amount` | float | Amount queued for release in the next payout cycle (CB only). Not applicable for Local shops. <path></path> |
| `↳↳ released_amount` | float | Total amount successfully released to the seller. <path></path> |

Lỗi riêng: parameter invalid · The income_status provided is invalid or not applicable. Please use one of the supported values: 0 - To Release, 1 - Released, 2 - Pending. Local shops do not have the “To Release” status. · shopid is invalid · Your refresh token is error, please check refresh token or user_id.

## v2.payment.get_income_detail
`GET /api/v2/payment/get_income_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Accounting And Finance

Retrieves detailed order-level income information across various income statuses for a specified time period. This API enables partners to display granular transaction-level income data consistent with Seller Center’s “Income Details” view, segmented by income status and payout stage. The API dynamically adapts data fields based on the seller’s shop type (Local or Cross Border) and the selected income status (e.g., Pending, To Release, Released).

Lịch sử cập nhật: 2025-10-31: -; 2025-10-21: Update to add request and response example; 2025-10-14: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `date_from` | string | ✔ | Start date (YYYY-MM-DD) of the income reference period. This field is only used for Income Status = Released, the other statuses will display all records currently in that status. For income Status = Released, For Released → Payout released date: 1. date_to must be later than date_from 2. date range cannot exceed 14 days 3. Input must follow valid date format. |
| `date_to` | string | ✔ | End date (YYYY-MM-DD) of the income reference period. Must be later than date_from. This field is only used for Income Status = Released, the other statuses will display all records currently in that status. For income Status = Released, For Released → Payout released date: 1. date_to must be later than date_from 2. date range cannot exceed 14 days 3. Input must follow valid date format. |
| `income_status` | int32 | ✔ | Status of Seller Income payout (Enum - Desc) Local 1 -Released 2 - Pending CB 0 - To Release 1 - Released 2 - Pending |
| `cursor` | string |  | Pagination token for the next set of results. Use an empty string "" for the first request. |
| `page_size` | int64 | ✔ | Number of income detail records to retrieve per page |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `income_detail_list` | object | List of income detail records returned for the specified time range and status. |
| `↳ next_page` | object | Contains pagination metadata for fetching the next page. |
| `↳↳ cursor` | string | Token to retrieve the next page of results. Returns empty if there is no more data. |
| `↳↳ page_size` | int32 | Number of records returned per page. |
| `↳ income_detail_list_item` | object | List of income detail objects |
| `↳↳ payment_method` | string | Payment channel or method used for the order |
| `↳↳ order_sn` | string | Unique order serial number associated with the income record. |
| `↳↳ description` | string | Type of income or billing item — e.g., Order Income, Adjustment etc |
| `↳↳ status` | string | Status description of the order income or payout. |
| `↳↳ currency` | string | Currency in which the income was transacted. |
| `↳↳ estimated_escrow_amount` | float | Estimated escrow amount pending release for the order. |
| `↳↳ estimated_payout_time` | int64 | Estimated payout time (Unix timestamp). Applicable for Pending/To Release status. |
| `↳↳ to_release_amount` | float | Amount that is queued for release to seller (Cross Border only). |
| `↳↳ creation_date` | int64 | Order creation timestamp (Unix format). |
| `↳↳ released_amount` | float | Amount successfully released to the seller. |
| `↳↳ actual_payout_time` | int64 | Actual payout time (Unix timestamp) when funds were transferred. |

Lỗi riêng: parameter invalid · Invalid Time Range: Only records from the past 5 years are supported for the TW region. · release_time_from and/or release_time_to parameter is missing or invalid. Please provide both a valid start date and end date to query, where the start date cannot be later than the end date, and the date range must not exceed 14 days. · shopid is invalid · Access blocked for Mart shops, please retrieve income details using Outlet Shop ID instead. · Your refresh token is error, please check refresh token or user_id.

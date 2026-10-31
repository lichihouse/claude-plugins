# Fulfillment — tài liệu chi tiết

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.




---

## Fulfillment API overview

Doc: https://partner.tiktokshop.com/docv2/page/fulfillment-api-overview · cập nhật 2026-08-26

### Context
The Fulfillment API allows sellers to fulfill TikTok Shop orders.
TikTok Shop offers two types of fulfillment types:

1. Fulfilled by TikTok (FULFILLMENT_BY_TIKTOK): TikTok will automatically process the order on behalf of the seller. The seller does not need to manage the fulfillment process.
2. Fulfilled by Seller (FULFILLMENT_BY_SELLER): Under this Fulfillment Type, there are two shipping types:

a) TikTok shipping (TIKTOK): Sometimes also referred to as "platform shipping" or "shipped via platform." With this shipping type, the seller purchases shipping labels through TikTok Shop, and schedules a pick-up from a TikTok Shop carrier, or drops off parcels at the TikTok Shop carriers' drop-off locations. The seller can obtain the shipping type from [Get Order Detail](https://partner.tiktokshop.com/docv2/page/650aa8ccc16ffe02b8f167a0) or [Get Order List](https://partner.tiktokshop.com/docv2/page/650aa8094a0bb702c06df242).
b) Seller shipping (SELLER): Sometimes also referred to as "shipped via seller." The seller manages shipping through their own channel(s). With this shipping type, the sellers call the Fulfillment API to provide shipping details back to TikTok Shop. The seller can obtain shipping type from [Get Order Detail](https://partner.tiktokshop.com/docv2/page/650aa8ccc16ffe02b8f167a0) or [Get Order List](https://partner.tiktokshop.com/docv2/page/650aa8094a0bb702c06df242).
The Fulfillment API also offers both split-package and consolidated-package (sometimes also referred to as combined package) shipment options to support more flexible shipping needs. The seller can obtain fulfillment type from [Get Order Detail](https://partner.tiktokshop.com/docv2/page/650aa8ccc16ffe02b8f167a0) or [Get Order List](https://partner.tiktokshop.com/docv2/page/650aa8094a0bb702c06df242).
### API Overview
#### TikTok shipping
With platform shipping, depending on the specific market, the seller may arrange shipment by either purchasing shipping labels from TikTok, or scheduling parcel handover with TikTok carriers.
##### Purchase shipping (US ,UK, EMEA and JP）

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/ee9e1ae6578e47028d0c0606aaff3883~tplv-k9wyc2ijk0-image.image)

##### Schedule shipping (SEA and LATAM）

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/5a146a17252244d89f7343fb26b44e8d~tplv-k9wyc2ijk0-image.image)

**Purchase shipping from TikTok (US ,UK, EMEA and JP)**
The seller can purchase labels from TikTok based on the dimensions and weight of the package, as required.

1. Use the [Get Eligible Shipping Service](https://partner.tiktokshop.com/docv2/page/650aa6b2bace3e02b75dda4e?external_id=650aa6b2bace3e02b75dda4e) API to retrieve available shipping service(US and JP);
2. Use the [Create Package](https://partner.tiktokshop.com/docv2/page/650aa132bace3e02b75d40d8?external_id=650aa132bace3e02b75d40d8) API to purchase shipping services, and create the shipping label.
3. Use the [Get Package Shipping Document](https://partner.tiktokshop.com/docv2/page/650aa5fac16ffe02b8f112ca?external_id=650aa5fac16ffe02b8f112ca) API to retrieve the shipping label.

**Note:**
Before calling the [Create Package](https://partner.tiktokshop.com/docv2/page/650aa132bace3e02b75d40d8?external_id=650aa132bace3e02b75d40d8#Back%20To%20Top) API, please ensure that the order has not been canceled and there is no cancellation request pending the seller's approval.

1. Within the remorse period (1 hour after order payment), the buyer may cancel the order without requiring the seller's approval.
2. After the remorse period, the buyer may request the order to be canceled, pending the seller's approval.

Please ensure that after calling the [Create Package](https://partner.tiktokshop.com/docv2/page/650aa132bace3e02b75d40d8?external_id=650aa132bace3e02b75d40d8#Back%20To%20Top) API to successfully complete the label purchase, then use the [Get Package Shipping Document](https://partner.tiktokshop.com/docv2/page/650aa5fac16ffe02b8f112ca?external_id=650aa5fac16ffe02b8f112ca) API to obtain the shipping label.
The UK market can also use [Ship Package](https://partner.tiktokshop.com/docv2/page/650aa4f1defece02be6e7cb1?external_id=650aa4f1defece02be6e7cb1) API when parcel dimensions are not available

**Schedule shipping from TikTok (SEA,** **LATAM)**
The seller may schedule the package handover time and method with the shipping provider.

1. Use the [Ship Package](https://partner.tiktokshop.com/docv2/page/650aa4f1defece02be6e7cb1?external_id=650aa4f1defece02be6e7cb1) API to schedule the package handover time and method.
2. Use the [Get Package Shipping Document](https://partner.tiktokshop.com/docv2/page/650aa5fac16ffe02b8f112ca?external_id=650aa5fac16ffe02b8f112ca) API to get the shipping label.

**Note:**
Before calling the [Ship Package](https://partner.tiktokshop.com/docv2/page/650aa4f1defece02be6e7cb1) API to ship the package, please ensure that the order has not been canceled or there is a cancellation request pending for response.

1. Within the remorse period (1 hour after order payment), the buyer may cancel the order without requiring the seller's approval.
2. After the remorse period, the buyer may request the order to be cancelled, pending the seller's approval.
3. Specific to the **BR** market, the seller must upload an invoice document prior to shipping. Please use the [POST Upload Invoice](https://partner.tiktokshop.com/docv2/page/67b542559a140004b343984f?external_id=67b542559a140004b343984f#Back%20To%20Top) endpoint.After obtaining the information of successful invoice upload through webhook [invoice status change], you can ship the package.

Please ensure that after calling the [Ship Package](https://partner.tiktokshop.com/docv2/page/650aa4f1defece02be6e7cb1) API to schedule shipment successfully, then use the [Get Package Shipping Document](https://partner.tiktokshop.com/docv2/page/650aa5fac16ffe02b8f112ca?external_id=650aa5fac16ffe02b8f112ca) API to obtain the shipping label.

#### Seller shipping
With seller shipping, the seller arranges the shipment directly with shipping carriers, and uploads the shipment tracking number to notify TikTok that the package has been shipped.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/4a56b2fa1505407488165cc0a6e74301~tplv-k9wyc2ijk0-image.image)

**Flow for the US and EMEA markets:**

1. The seller ships the package and obtains the shipment tracking number from the shipping carrier.
2. Use the [Get Shipping Providers](https://partner.tiktokshop.com/docv2/page/650aa48d4a0bb702c06d85cd?external_id=650aa48d4a0bb702c06d85cd) endpoint to retrieve the shipping service provider IDs supported by TikTok Shop via delivery_option_id (sellers can get the delivery_option_id in Get Order Detail API / Get Order List API).
3. Use the [Mark Package As Shipped](https://partner.tiktokshop.com/docv2/page/6503c95456e2bb0289ee4e81?external_id=6503c95456e2bb0289ee4e81) endpoint to upload the shipment tracking number and shipping provider ID.

**Flow for the SEA and LATAM markets:**

1. The seller ships the package and obtains the shipment tracking number from the shipping carrier.
2. Use the [Get Shipping Providers](https://partner.tiktokshop.com/docv2/page/650aa48d4a0bb702c06d85cd?external_id=650aa48d4a0bb702c06d85cd) endpoint to retrieve the shipping service provider IDs supported by TikTok Shop via delivery_option_id (sellers can get the delivery_option_id in Get Order Detail API / Get Order List API).
3. Use the [Ship Package](https://partner.tiktokshop.com/docv2/page/650aa4f1defece02be6e7cb1) endpoint to upload the shipment tracking number and shipping provider ID.

**Note:**
Before calling the [Mark Package As Shipped](https://partner.tiktokshop.com/docv2/page/6503c95456e2bb0289ee4e81?external_id=6503c95456e2bb0289ee4e81)/[Ship Package](https://partner.tiktokshop.com/docv2/page/650aa4f1defece02be6e7cb1) API to ship the package, please ensure that the order has not been canceled or there is a cancellation request pending for response.

1. Within the remorse period (1 hour after order payment), the buyer may cancel the order without requiring the seller's approval.
2. After the remorse period, the buyer may request the order to be cancelled, pending the seller's approval.

To ensure the buyers' shopping and service experience, TikTok measures the shipping service level using shipment tracking information based on the tracking number. When TikTok fails to validate the tracking number, or the shipment handling time exceeds TikTok's service level agreement, TikTok may cancel the order and refund the buyer. To prevent the order from being canceled by TikTok, please verify the shipping provider is supported by TikTok.
#### Split order fulfillment

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/3f8d829ae6814f53ab0580a551a5fe80~tplv-k9wyc2ijk0-image.image)

#### Consolidated order fulfillment
##### Pre-shipping consolidation (SEA and LATAM)

1. Call [Search Combinable Packages](https://partner.tiktokshop.com/docv2/page/650aa481bace3e02b75d9e32?external_id=650aa481bace3e02b75d9e32) API to get the order, which can be consolidated order.
2. Call [Combine Package](https://partner.tiktokshop.com/docv2/page/650aa99adefece02be6f07c9?external_id=650aa99adefece02be6f07c9) API to confirm the order consolidated.
3. (optional): If you would like to remove the order, which has already been consolidated. Please use [Uncombine Packages](https://partner.tiktokshop.com/docv2/page/650aa960f1fd3102b92ceb0e?external_id=650aa960f1fd3102b92ceb0e) API to remove the specific order.
4. Call [Ship Package](https://partner.tiktokshop.com/docv2/page/650aa4f1defece02be6e7cb1) API to Ship the package.

##### In-shipping consolidation

1. The seller consolidates orders, and ships the packages using their existing shipping process.
2. For 4PL orders（US ,UK and JP）：Call the Create Packages API to consolidate when they are shipping.
3. For 3PL orders（US ,EMEA and JP）：Call the [Mark Package As Shipped](https://partner.tiktokshop.com/docv2/page/6503c95456e2bb0289ee4e81?external_id=6503c95456e2bb0289ee4e81) API to upload the tracking number for each order that has been consolidated.

### TikTok Shop marketplace policies
#### Split order fulfillment policy

For SEA market, an order cannot be split below the order line level (also referred to as the SKU level). For instance, if the buyer purchases two pairs of jeans and one shirt, both pairs of jeans must be shipped in the same package, while the shirt can be split into a separate package.

For US, EMEA,LATAM,and JP，No restriction. All items in the order can be split into different packages arbitrarily.
#### Consolidate order fulfillment policy

1. All orders using the same tracking number for shipment must have the same recipient's name and shipping address.
2. A single tracking number can be used to ship a maximum of 20 orders for consolidated shipment.

#### Tracking number verification policy
If the seller uses seller shipping mode, TikTok will verify the tracking number.

1. The shipping service provider used by merchants must be supported by TikTok. Please use the [Get Shipping Providers](https://partner.tiktokshop.com/docv2/page/650aa48d4a0bb702c06d85cd?external_id=650aa48d4a0bb702c06d85cd) API to retrieve the available shipping providers.
2. TikTok will verify if the tracking number matches the selected shipping service provider. If the tracking number is not verified by the chosen shipping provider, an error will be returned.

### Frequently asked questions

1. Can I use shipping service providers outside of the platform's list?
   * No. It will make TikTok unable to obtain shipment tracking information. If TikTok cannot obtain the shipment tracking information within the time specified in cancel_sla_time, the order may be canceled by TikTok.
2. Do I need to handle shipping operations for orders with 'FULFILL_BY_TIKTOK'?
   * No. TikTok will fulfill the order.
3. Can I obtain shipping labels from TikTok at any time?
   * No. A shipping label is only available after shipping has been arranged for a package, and before the package is handed over to the carrier.
4. If I have already handed over the package to the shipping service provider, but the order status on the platform has not progressed to 'IN_TRANSIT', what should I do?
   * First, you need to confirm that the shipping service provider you are using is supported by the platform. If it is confirmed to be supported, please get in touch with the shipping service provider to ensure that the package has been scanned into their system. If you have already tracked the tracking information on the official logistics website but the platform still does not show any tracking details, please contact TikTok for assistance.


---

## UK & EU: Purchase shipping labels from TikTok

Doc: https://partner.tiktokshop.com/docv2/page/i83mvdfg · cập nhật 2025-10-08

### Overview
This document outlines the 4PL operational workflow within the TikTok Shop (TTS) ecosystem for the **UK** and **EU** markets. It covers key API integrations, platform logic, and the full order lifecycle: from order creation to parcel dispatch.

**TikTok Shipping**—also known as "platform shipping" or "shipped via platform"—allows sellers to purchase shipping labels directly through TikTok Shop. Sellers can either schedule a pickup with a TikTok Shop carrier, or drop off parcels at designated carrier locations.

Please see the flow below:
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/0ef6ee015538413e85cd5046a00ece0e~tplv-k9wyc2ijk0-image.image)

---

#### Key considerations for 4PL flows:
– Shipping options are configured in Seller Center - these do not get surfaced at the ISV level
– The carrier is assigned during order creation by TTS
– Package dimensions and weight are already known to TTS via product upload.

No need to call `Get Eligible Shipping Service` or `Create Package`.

**Required API Flow:**

1. [Get Order Detail](https://partner.tiktokshop.com/docv2/page/get-order-detail-202507)
   **→** Returns package ID.
2. [Ship Package](https://partner.tiktokshop.com/docv2/page/ship-package-202309)
   **→** Use the package ID to call this API. 
      – Set to **TikTok Shipping**
      – Pickup time fields are optional.

3. [Get Package Shipping Document](https://partner.tiktokshop.com/docv2/page/get-package-shipping-document-202309)
   **→** Retrieve the label.

---

**For ISVs creating new products:**
If sellers need to verify the warehouse delivery configuration *before* uploading a product, they can call **Get Warehouse Delivery Options**. This allows them to retrieve the relevant shipping settings in advance, ensuring that the product is uploaded with the correct delivery configuration.
#### API Endpoint Documentation 
Please review the Fulfillment APIs. Provided is a list of useful ones in this scenario:
| **Endpoint** | **Description** |
| --- | --- |
| [Get Order Detail](https://partner.tiktokshop.com/docv2/page/650aa8ccc16ffe02b8f167a0?external_id=650aa8ccc16ffe02b8f167a0) | Returns a list of orders created or updated during the timeframe indicated by the specified parameters. You can also apply a range of filtering criteria to narrow the list of orders returned, such as order status, delivery option type, and buyer user ID. |
| [Fulfilment API Overview ](https://partner.tiktokshop.com/docv2/page/650b2044f1fd3102b93c9178) | The Fulfillment API allows sellers to fulfill TikTok Shop orders. |
| [Ship Package](https://partner.tiktokshop.com/docv2/page/650aa4f1defece02be6e7cb1?external_id=650aa4f1defece02be6e7cb1)   | Use this API to ship a package. Two shipping options are available: **TikTok Shipping** and **Seller Shipping**. For **4PL orders**, this must be set to **'TikTok Shipping'**.     Shipping options are configured in **Seller Center** and saved as part of the **warehouse delivery settings**. These settings determine which shipping method is used.     While the API accepts a shipping method parameter, it cannot override what's already configured — it simply reflects the warehouse’s setup. So although it looks like you can choose via the API, **you** **cannot**.     ERPs should always pass **'TikTok Shipping'** for 4PL orders and should not attempt to change the shipping option using the API. |
| [Get Warehouse Delivery Options](https://partner.tiktokshop.com/docv2/page/get-warehouse-delivery-options-202309)   | Use this API to retrieve the **shipping configuration** assigned to a warehouse — specifically, whether it's set up for **TikTok Shipping** or **Seller Shipping**.     These settings are managed in **Seller Center** and cannot be changed via API. However, ERPs can use this API to check the current delivery setup **before uploading a product**, so that the product’s shipping settings align with the warehouse configuration.     This ensures that new product uploads reflect the correct shipping method and prevents mismatches or shipping errors later in the order flow. |
| [Get Package Shipping Document ](https://partner.tiktokshop.com/docv2/page/650aa5fac16ffe02b8f112ca?external_id=650aa5fac16ffe02b8f112ca) | For orders shipped by TikTok Shop, this API retrieves the URL of shipping documents (shipping label and packing slip) for a package specified by the package ID. This API is only applicable to "TikTok Shipping" orders. To obtain the shipping documents URL via this API, first call "Ship Package" to ship the corresponding package. |
| [Get Tracking](https://partner.tiktokshop.com/docv2/page/650aa630c16ffe02b8f11803?external_id=650aa630c16ffe02b8f11803) | This API can use the order number to obtain the corresponding logistics tracking information. |
### Switching from 3PL to 4PL
| **Steps** | **Instructions** |
| --- | --- |
| Step 1 | Ensure your warehouse address is correct by clicking on your Profile (top right) > My Account > Account Settings > [Warehouse settings](https://seller-uk.tiktok.com/profile/account-setting/warehouse). |
| Step 2 | Go to **Seller Center** > Orders > [Shipping Settings](https://seller-uk.tiktok.com/logistics/delivery). Select **Shipped via Platform** and set it as **preferred logistics option**. |
| Step 3 | Go to the [Fulfillment Setting](https://seller-uk.tiktok.com/order/fulfill-policy) page, select Collection method settings, and select Drop-off or Pick-up as your parcel handover method. |
| Step 4 | Follow our [step-by-step guide on how to print labels and dispatch your orders](https://seller-uk.tiktok.com/university/essay?knowledge_id=3148241730815745&default_language=en-GB&identity=1). |
#### Notes
Platform shipping, with access to exclusive shipping subsidies only available for eligible orders fulfilled or shipped by the platform. 
Courier options for the **UK**:
| **Courier** | **Dropoff** | **Pickup** | **Cost to Seller** | **Notes** |
| --- | --- | --- | --- | --- |
| Evri (Default) | ✅ | ✅ | Included (no additional cost) | Default Option |
| Amazon (CBT) | ❌ | ✅ | Included (no additional cost) | Seller Must Apply |
| DPD   | ❌ | ✅ | £0.99 per parcel (excl. VAT) payable by seller | Seller Must Opt in |

Courier options for the **EU**:
| **Country** | **LSP** | **Dropoff** | **Pickup** | **Cost to Seller** | **Notes** |
| --- | --- | --- | --- | --- | --- |
| ES   | Correos | ✅ (default) | ✅ | Included (no additional cost) | Default dropoff |
|  | GLS | ❌ | ✅ | Included (no additional cost) | Default pickup |
|  | SEUR | ❌ | ✅ | Included (no additional cost) | Managed by platform |
|  | CTT | ❌ | ✅ | Included (no additional cost) | Managed by platform |
| IT | BRT | ✅ (default) | ✅ | Included (no additional cost) | Default |
|  | GLS | ❌ | ✅ | Included (no additional cost) | Managed by platform |
| FR | Colis Prive | ✅ | ✅ | Included (no additional cost) | Managed by platform |
|  | GLS | ❌ | ✅ | Included (no additional cost) | Managed by platform |
|  | Inpost | ✅ | ✅ | Included (no additional cost) | Default |
|  | Cainiao | ❌ | ✅ | Included (no additional cost) | Managed by platform |
| DE | GLS | ❌ | ✅ | Included (no additional cost) |  |
|  | Hermes | ❌ | ✅ | Included (no additional cost) |  |
|  | DPD | ❌ | ✅ | Included (no additional cost) |  |

#### **How this works:**
##### Order Creation
– Orders are created within the TikTok Shop platform (TTS).
– This triggers downstream fulfillment processes.
##### Order Retrieval via API
– The [Get Order Detail API](https://partner.tiktokshop.com/docv2/page/650aa8ccc16ffe02b8f167a0?external_id=650aa8ccc16ffe02b8f167a0#Back%20To%20Top) is called by the seller or their middleware platform.
– This API response includes the **Package ID** generated by TTS.
– The Package ID is used for subsequent shipping-related API calls.
##### Warehouse Handling
– The seller receives the order details, prepares the parcel, and packages the item(s).
– Package information is not editable via API and must align with product attributes uploaded to TTS (e.g., weight and dimensions).

---

### **Shipping configurations:**
Shipping configurations are managed entirely through **Seller Center**. This includes:
– Shipping service setup (e.g., carrier selection)
– Pricing tiers
– Weight and dimension buckets

**Note**: These settings are account-level and not configurable via API.
– Once items are packed, sellers must retrieve shipping documentation (labels, invoices) from TTS.
– Shipping labels are automatically generated based on item weight and dimensions stored in the TTS catalogue.

---

#### **API Solution Overview:**
##### Retrieve Order Information
– Seller calls the [Get Order Detail](https://partner.tiktokshop.com/docv2/page/650aa8ccc16ffe02b8f167a0?external_id=650aa8ccc16ffe02b8f167a0#Back%20To%20Top) API to obtain details of the order. This includes package ID—an identifier created within TTS for the prepared parcel.
##### Confirm Parcel is Ready for Dispatch
– Seller prepares the parcel(s) and calls [Ship Package](https://partner.tiktokshop.com/docv2/page/650aa4f1defece02be6e7cb1?external_id=650aa4f1defece02be6e7cb1) API. The previously fetched package ID is used for this call.
##### **Retrieve Shipping Documents**
[Get Package Shipping Documents](https://partner.tiktokshop.com/docv2/page/650aa5fac16ffe02b8f112ca?external_id=650aa5fac16ffe02b8f112ca) API:
– Used to download the shipping label and associated documents 
##### **Final Shipment Handling**
– Seller dispatches the item.
– Pickup scheduling (if required) is confirmed via Lark with the assigned 4PL.
– Seller packages and ships items. Pickup timeslots are confirmed via Lark

---

### Key Notes
– The entire flow is designed to operate with minimal manual intervention, provided the seller has configured their shipping parameters correctly in Seller Center.
– TikTok Shop does not currently support dynamic label generation via external weight data—accuracy of item dimensions at upload is critical.
– Pickup windows and logistics exceptions are managed directly through operational coordination on Lark.

---


---

## Get Order Split Attributes — `GET /fulfillment/202309/orders/split_attributes`

Doc: https://partner.tiktokshop.com/docv2/page/get-order-split-attributes-202309 · cập nhật 2026-10-26 · scope: seller.fulfillment.package.write, seller.fs.order&fufillment.management

### Path: /fulfillment/202309/orders/split_attributes
### Method: [GET]
### Function Description
Checks whether one or more TikTok Shop orders can be split into multiple packages. For each evaluated order, the response indicates whether it can be split and may include a reason when splitting is not allowed and mandatory package-splitting limits when applicable.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| order_ids | []string | Y | 556643423443,556643423444 | A comma-separated list of TikTok Shop order IDs to check for package split eligibility. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/orders/split_attributes?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&order_ids=556643423443,556643423444
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^split_attributes | []object |  | Split-eligibility results for the evaluated TikTok Shop orders. Each result identifies an order and indicates whether it can be split; it may also include a reason when splitting is not allowed and mandatory package-splitting limits when applicable. |
| ^^order_id | string | 556643423444 | TikTok Shop order ID. |
| ^^can_split | bool | false | Whether an order can be split: |

* `true`: The order can be split into multiple packages.
* `false`: The order cannot be split into multiple packages. |
   ^^reason |string |Order has been canceled |The reason why the order cannot be split. Only return this field when `can_split = false`. |
   ^^must_split |bool |false |Whether an order must be split:
* true: The order must be split into multiple packages.
* false: The order does not have to be split into multiple packages. |
   ^^must_split_reasons |[]object | |The reason why the order must be split. Only return this field when must_split = true. |
   ^^^type |string |CATEGORY_ITEM_LIMITATION |It will return which type of verification is hit. There are two types of verification: CATEGORY_ITEM_LIMITATION means category verification and TOTAL_COUNT_LIMITATION means total product quantity verification. |
   ^^^category_id |string |601990 |The category ID associated with this split limitation. A value is returned when `type` is `CATEGORY_ITEM_LIMITATION`; no value is returned when `type` is `TOTAL_COUNT_LIMITATION`. |
   ^^^max_count |string |2 |For category verification, return the maximum quantity of goods allowed for this category in a single package; for total product quantity verification within the package, return the total quantity limit of goods in a single package. |

### Response Sample
```json
{"code":0,"data":{"split_attributes":[{"order_id":"556643423444","can_split":false,"reason":"Order has been canceled","must_split":false,"must_split_reasons":[{"type":"CATEGORY_ITEM_LIMITATION","category_id":"601990","max_count":"2"}]}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Confirm Order Split — `POST /fulfillment/202309/orders/{order_id}/split`

Doc: https://partner.tiktokshop.com/docv2/page/confirm-order-split-202309 · cập nhật 2026-10-26 · scope: seller.fulfillment.package.write, seller.fs.order&fufillment.management

### Path: /fulfillment/202309/orders/{order_id}/split
### Method: [POST]
### Function Description
Use this API to confirm an order split. Supported split levels vary by region:

* Some regions support item-level splits (splitting individual units of the same SKU).
* Others only support all-units splits (splitting different SKUs into separate packages).

Here are two examples of supported splits:

* **Case 1: all-units split**, applicable for orders in BR, SEA, MX (local sellers)
   Split a buyer order of SKU A of quantity 2 and SKU B of quantity 1 into two separate packages:
   * **Package 1**: all units of SKU A
   * **Package 2**: all units of SKU B
* **Case 2: item-level split**, applicable for orders in EU, JP, MX (global sellers), UK, US
   Split the same order contents into three individual packages:
   * **Package 1**: 1 unit of SKU A
   * **Package 2**: 1 unit of SKU A
   * **Package 3**: 1 unit of SKU B

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_id | string | Y | 556643423444 | TikTok Shop order ID. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| splittable_groups | []object | Y |  | Groups of order line items to split. Each successfully split group is returned as a separate package. |
| ^id | string | Y | 123 | A developer-defined identifier for this split group. The response returns the same value in `splittable_group_id` to correlate the group with its newly created package. |
| ^order_line_item_ids | []string | Y | ["57646237751283022", "576462377512830223"] | The order line item IDs that need to be split into this group. |
| splittable_groups_v2 | []object | N |  | This new parameter is completely backward compatible with the previous splittable groups field and in addition this supports bundle order splitting, use the sub items accordingly |
| ^id | string | N | 123 | A developer-defined identifier for this split group. The response returns the same value in `splittable_group_id` to correlate the group with its newly created package. |
| ^order_line_list | []object | N |  | This new parameter is completely backward compatible with the previous oder_line_items_ids field and in addition this supports bundle order splitting, use the sub items accordingly |
| ^^order_line_id | string | N | 57646237751283022 | The corresponding order line ID. |
| ^^sub_item_id | string | N | 57646237751283022 | The sub-order-line ID inside a bundle product. |

* Required for bundle products.
* Not required for non-bundle products. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/orders/556643423444/split?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"splittable_groups":[{"id":"123","order_line_item_ids":["57646237751283022","576462377512830223"]}],"splittable_groups_v2":[{"id":"123","order_line_list":[{"order_line_id":"57646237751283022","sub_item_id":"57646237751283022"}]}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^packages | []object |  | Packages created by the split. Each returned package includes the request group identifier in `splittable_group_id` and its new package ID in `id`. |
| ^^splittable_group_id | string | 123 | The developer-defined `id` of the corresponding group from `splittable_groups` or `splittable_groups_v2` in the request. |
| ^^id | string | 223362377512830222 | Package ID after success split. Use this new package ID to call [Ship Package API](https://partner.tiktokshop.com/docv2/page/650aa4f1defece02be6e7cb1?external_id=650aa4f1defece02be6e7cb1) to ship the package. |
### Response Sample
```json
{"code":0,"data":{"packages":[{"splittable_group_id":"123","id":"223362377512830222"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 21001028 | The order is being processed. Try again later. |
| 21011005 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 21011035 | split order not allowed |


---

## Get Eligible Shipping Services — `POST /fulfillment/202309/orders/{order_id}/shipping_services/query`

Doc: https://partner.tiktokshop.com/docv2/page/get-eligible-shipping-services-202309 · cập nhật 2026-10-26 · scope: seller.fulfillment.basic

### Path: /fulfillment/202309/orders/{order_id}/shipping_services/query
### Method: [POST]
### Function Description
Retrieve available shipping services in the US and JP. Package dimensions and weight are optional inputs used to calculate the available options. Shipping fees and delivery times are estimates based on the package attributes used for the query, and the available options may change if those attributes change at the time of shipping.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_id | string | Y | 32132124331234 | TikTok Shop order ID |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_line_item_ids | []string | N | ["32132124331234"] | Order line item ID list |
| warehouse_id | string | N | 7559598297381865271 | Specifies the shipping warehouse. Call Get Warehouse List to retrieve the list of available warehouses. |
| weight | object | N |  | The weight of the scheduled package. |
| ^value | string | Y | 0.4 | The weight of the scheduled package. |
| ^unit | string | Y | GRAM | The unit of measurement is used to measure the weight. |

* GRAM
* POUND |
   dimension |object |N | |The dimensions of the scheduled package. |
   ^length |string |Y |0.3 |The length of the package. The length, width, height must be passed together. |
   ^width |string |Y |0.2 |The width of the package. The length, width, height must be passed together. |
   ^height |string |Y |0.2 |The height of the package. The length, width, height must be passed together. |
   ^unit |string |Y |INCH |The unit of measurement for the package dimensions.
* CM
* INCH |
   order_line_list |[]object |N | |This new parameter is completely backward compatible with the previous oder_line_items_ids field and in addition this supports bundle order splitting, use the sub items accordingly |
   ^order_line_id |string |N |57632132124331234 |The corresponding order line ID. |
   ^sub_item_id |string |N |57632132124331234 |The sub-order-line ID inside a bundle product.
* Required for bundle products.
* Not required for non-bundle products. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/orders/32132124331234/shipping_services/query?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"order_line_item_ids":["32132124331234"],"warehouse_id":"7559598297381865271","weight":{"value":"0.4","unit":"GRAM"},"dimension":{"length":"0.3","width":"0.2","height":"0.2","unit":"INCH"},"order_line_list":[{"order_line_id":"57632132124331234","sub_item_id":"57632132124331234"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^order_id | string | 28823355942588 | TikTok Shop order ID |
| ^order_line_id | []string | ["32132124331234"] | Line item ID list |
| ^weight | object |  | The weight of the scheduled package. |
| ^^value | string | 1.2 | The weight of the scheduled package. |
| ^^unit | string | GRAM | The unit of measurement is used to measure the weight. |

* GRAM
* POUND |
   ^shipping_services |[]object | |The shipping services available for the order. |
   ^^id |string |288233559123860015 |Shipping service ID |
   ^^name |string |UPS-first class |Shipping service Name |
   ^^price |string |5 |Estimated total price for this Shipping services |
   ^^currency |string |USD |Currency of the price |
   ^^earliest_delivery_days |int |3 |The minimum estimated duration required for parcel delivery.US only.
   |
   ^^latest_delivery_days |int |5 |The maximum estimated duration required for parcel delivery.US only. |
   ^^is_default |bool |false |Whether it is the default shipping service |
   ^^shipping_provider_name |string |UPS |The name of shipping provider.US only. |
   ^^shipping_provider_id |string |288233559123860012 |The ID of shipping provider.US only. |
   ^^shipping_fee |string |3 |Shipping fee |
   ^^shipping_app_service_fee |string |1 |Shipping surcharge paid to the ERPs |
   ^^signature_fee |string |1 |Signature service fee |
   ^dimension |object | |The dimension of the scheduled package. |
   ^^length |string |0.3 |The length of the package. |
   ^^width |string |0.2 |The width of the package. |
   ^^height |string |0.04 |The height of the package. |
   ^^unit |string |INCH |The unit of measurement for the package dimensions.
* CM
* INCH |

### Response Sample
```json
{"code":0,"data":{"order_id":"28823355942588","order_line_id":["32132124331234"],"weight":{"value":"1.2","unit":"GRAM"},"shipping_services":[{"id":"288233559123860015","name":"UPS-first class","price":"5","currency":"USD","earliest_delivery_days":3,"latest_delivery_days":5,"is_default":false,"shipping_provider_name":"UPS","shipping_provider_id":"288233559123860012","shipping_fee":"3","shipping_app_service_fee":"1","signature_fee":"1"}],"dimension":{"length":"0.3","width":"0.2","height":"0.04","unit":"INCH"}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 10006402 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 21001001 | Invalid parameters. Please ensure you are passing the correct request parameter(s). |
| 21011001 | Package not found. If the error persists, please contact the platform for assistance. |
| 21011006 | These orders are already shipped. |
| 21011029 | order does not belong to fulfill unit |
| 21011037 | There are no available shipping services for this request. Please modify the package weight, or double check the recipient address. If after multiple retries you continue to experience this error, please contact the platform for assistance. |
| 21011048 | There are multiple packages that can be shipped, please specify the order line that needs to be shipped. |


---

## Create First Mile Bundle — `POST /fulfillment/202407/bundles`

Doc: https://partner.tiktokshop.com/docv2/page/create-first-mile-bundle-202407 · cập nhật 2026-10-10 · scope: seller.fulfillment.basic

### Path: /fulfillment/202407/bundles
### Method: [POST]
### Function Description
If you send multiple packages to TikTok Shop warehouse in a single first-mile bundle, you can use the API to create a first-mile bundle on TikTok Shop and get the bundle ID.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_ids | []string | Y | ["578967030217083407"] | The IDs of all the orders sent in a single first-mile bundle. Maximum: 9,999 order IDs per request. |
| The orders must follow the restrictions: |  |  |  |  |

* Each of the orders must exist and be RTS and shipping label printed.
* The orders are sent by the same seller.
* The orders belong to a single group of TikTok Shop service districts. The groups are:
   * Group 1: PH, SG, MY, VN, TH, and JP.
   * Group 2: DE, FR, IT, ES.

You can not create first mile bundles for US/UK orders using this API. |
handover_method |string |Y |PICKUP |The way you send the first-mile bundle. Possible enumerations are:

* `PICKUP`: You use the logistic service provided by TikTok Shop to send the bundle.
* `DROP_OFF`: You contact the logistic provider and send the bundle. The logistic provider must be registered at TikTok Shop. |
   shipping_provider_id |string |N |7463353253533 |The logistic provider ID in TikTok Shop. Required when `handover_method == DROP_OFF`. |
   tracking_number |string |N |SF1244442424 |The logistic tracking number of the bundle. Required when `handover_method == DROP_OFF`. |
   phone_tail_number |string |N |1234 |Last 4 digits of the sender's phone number. Required when `handover_method == DROP_OFF`. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202407/bundles?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

**Body**
```json
{"order_ids":["578967030217083407"],"handover_method":"PICKUP","shipping_provider_id":"7463353253533","tracking_number":"SF1244442424","phone_tail_number":"1234"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^first_mile_bundle_id | string | BA123444534 | The ID of the first-mile bundle. |
| ^url | string | https://open-fs-va.tiktokshop.com/doc_tts/object/28b05?skipCookie=true&timeStamp=1721272360&sign=ef63cd6 | The returned waybill link. |
| ^errors | []object |  | Errors associated with requested orders. An entry can indicate that the requested order could not be resolved, or that a package associated with the order could not be included in the bundle. Check this array and `first_mile_bundle_id` even when the top-level response code is `0`. A present `first_mile_bundle_id` identifies the created bundle; if it is absent, this response does not identify a created bundle. |
| ^^code | int | 21008121 | The code for the error associated with the requested order identified by `detail.order_id`. |
| ^^message | string | invalid order id | The message that explains the error associated with the requested order identified by `detail.order_id`. |
| ^^detail | object |  | Error detail |
| ^^^order_id | string | 578967030217083407 | TikTok Shop order ID |
### Response Sample
```json
{"code":0,"data":{"first_mile_bundle_id":"BA123444534","url":"https://open-fs-va.tiktokshop.com/doc_tts/object/28b05?skipCookie=true\u0026timeStamp=1721272360\u0026sign=ef63cd6","errors":[{"code":21008121,"message":"invalid order id","detail":{"order_id":"578967030217083407"}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Search Package — `POST /fulfillment/202309/packages/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-package-202309 · cập nhật 2026-10-26 · scope: seller.fulfillment.basic

### Path: /fulfillment/202309/packages/search
### Method: [POST]
### Function Description
Retrieve packages, optionally filtered by creation time, update time, or package status.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| page_size | int | Y | 20 | The number of results to be returned per page. Valid range: [1-50]. |
| sort_field | string | N | order_pay_time | The returned results will be sorted by the specified field. |
| Default: `create_time` |  |  |  |  |
| Possible values: |  |  |  |  |

* `create_time`
* `update_time`
* `order_pay_time`

Specify the order for sorting the returned results by using the sort_order parameter. |
sort_order |string |N |ASC |The sort order for the sort_field parameter. Default: `DESC`
Possible values:

* `ASC`: Ascending order
* `DESC`: Descending order |
   page_token |string |N |6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA |An opaque token used to retrieve the next page of a paginated result set. Retrieve this value from the result of the `next_page_token` from a previous response. It is not needed for the first page. |
   shop_cipher |string |N |GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 |Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |

### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| create_time_ge | int | N | 1623812664 | Filter packages to those created at or after the specified time. Unix timestamp, in seconds. |
| create_time_lt | int | N | 1623812664 | Filter packages to those created before the specified time. Unix timestamp, in seconds. |
| update_time_ge | int | N | 1623812664 | Filter packages to those updated at or after the specified time. Unix timestamp, in seconds. |
| update_time_lt | int | N | 1623812664 | Filter packages to those updated before the specified time. Unix timestamp, in seconds. |
| package_status | string | N | PROCESSING | Possible values: |

* `TO_FULFILL`
* `PROCESSING`: Package has been arranged by seller. Waiting for carrier to collect the parcel.
* `FULFILLING`: Package has been collected by carrier and in transit.
* `COMPLETED`: Package has been delivered.
* `CANCELLED`: Package has been canceled. Normally, the package is canceled due to the package being lost or damaged. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/packages/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_size=20&sort_field=order_pay_time&sort_order=ASC&page_token=6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA
```

**Body**
```json
{"create_time_ge":1623812664,"create_time_lt":1623812664,"update_time_ge":1623812664,"update_time_lt":1623812664,"package_status":"PROCESSING"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^next_page_token | string | 6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA | An opaque token used to retrieve the next page of a paginated result set. If this value is non-empty, provide it in the `page_token` parameter of the next request. If this value is empty, stop pagination. |
| ^total_count | int | 221 | The number of packages that meet the query conditions. |
| ^packages | []object |  | The response list of packages. |
| ^^id | string | 577828281214600000 | Package ID. |
| ^^orders | []object |  | The response list of TikTok Shop orders. |
| ^^^id | string | 577828281214600000 | TikTok Shop order ID. |
| ^^^skus | []object |  | [Deprecated]The response list of SKUs. |
| ^^^^id | string | 577828281214883345 | [Deprecated]The SKU ID. |
|  |  |  |  |
| ^^^^name | string | white,128g | [Deprecated]The SKU name. |
| ^^^^image_url | string | https://p19-oec-sg.ibyteimg.com/tos-maliva-i-o3syd03w52-us/12345670 | [Deprecated]The SKU image in order snapshot. |
|  |  |  |  |
| ^^^^quantity | int | 5 | [Deprecated]The SKU quantity. |
| ^^create_time | int | 1635338186 | Package creation time. Unix timestamp, in seconds. |
| ^^update_time | int | 1635338186 | The time when the package was last updated. Unix timestamp, in seconds. |
| ^^status | string | PROCESSING | Possible values: |

* `TO_FULFILL`
* `PROCESSING`: Package has been arranged by seller. Waiting for carrier to collect the parcel.
* `FULFILLING`: Package has been collected by carrier and in transit.
* `COMPLETED`: Package has been delivered.
* `CANCELLED`: Package has been canceled. Normally, the package is canceled due to the package being lost or damaged. |
   ^^tracking_number |string |6617675021119438849 |Package tracking number. |
   ^^shipping_provider_name |string |TT Virtual express |Package shipping provider. |
   ^^shipping_provider_id |string |6617675021119438849 |Package shipping provider ID. |
   ^^order_line_item_ids |[]string |["1729382476852921560"] |The order line item ID contained in the package.
   |

### Response Sample
```json
{"code":0,"data":{"next_page_token":"6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA","total_count":221,"packages":[{"id":"577828281214600000","orders":[{"id":"577828281214600000","skus":[{"id":"577828281214883345","name":"white,128g","image_url":"https://p19-oec-sg.ibyteimg.com/tos-maliva-i-o3syd03w52-us/12345670","quantity":5}]}],"create_time":1635338186,"update_time":1635338186,"status":"PROCESSING","tracking_number":"6617675021119438849","shipping_provider_name":"TT Virtual express","shipping_provider_id":"6617675021119438849","order_line_item_ids":["1729382476852921560"]}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Search Combinable Packages — `GET /fulfillment/202309/combinable_packages/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-combinable-packages-202309 · cập nhật 2026-10-26 · scope: seller.fulfillment.package.write

### Path: /fulfillment/202309/combinable_packages/search
### Method: [GET]
### Function Description
Use this API to query orders eligible for combined shipping.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| page_token | string | N | 6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA | An opaque token used to retrieve the next page of a paginated result set. Retrieve this value from the result of the `next_page_token` from a previous response. It is not needed for the first page. |
|  |  |  |  |  |
| page_size | int | Y | 20 | The number of results to be returned per page. Valid range: [1-50]. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/combinable_packages/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_token=6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA&page_size=20
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^combinable_packages | []object |  | List of eligible packages that can be combined. |
| ^^id | string | 57466538837665 | The pre-generated package ID obtained after calling the Search Draft Package API. Use this ID when confirming the package combination. |
| ^^order_ids | []string | ["57466538837665","57466538837666"] | List of order IDs for this package. |
| ^next_page_token | string | 6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA | An opaque token used to retrieve the next page of a paginated result set. Provide this value in the `page_token` parameter of your request if the current response does not return all the results. |
| ^total_count | int | 10 | The number of combinable packages counted by this result. |
### Response Sample
```json
{"code":0,"data":{"combinable_packages":[{"id":"57466538837665","order_ids":["57466538837665","57466538837666"]}],"next_page_token":"6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA","total_count":10},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Combine Package — `POST /fulfillment/202309/packages/combine`

Doc: https://partner.tiktokshop.com/docv2/page/combine-package-202309 · cập nhật 2026-10-26 · scope: seller.fulfillment.package.write

### Path: /fulfillment/202309/packages/combine
### Method: [POST]
### Function Description
Use this API to combine orders from each specified package into new fulfillment packages.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| combinable_packages | []object | Y |  | The packages to combine. Provide at least one package. Each item identifies a package and can specify the order IDs to include. |
| ^id | string | Y | 12321313133 | The package ID. |
| ^order_ids | []string | N | ["1233213123123","32132131231"] | The order IDs to include when combining the package identified by `id`. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/packages/combine?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"combinable_packages":[{"id":"12321313133","order_ids":["1233213123123","32132131231"]}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^packages | []object |  | Return list of successfully combined packages. |
| ^^id | string | 413234134123412 | The new package ID generated after the package has been successfully combined. |
| ^^order_ids | []string | ["1233213123123","32132131231"] | List of order IDs corresponding to a new combined package ID. |
| ^errors | []object |  | The errors returned for packages that could not be combined. |
| ^^code | int | 10007014 | The failure reason code. |
| ^^message | string | fulfillment not allow combine package | The failure reason of an unsuccessful combined package action. |
| ^^detail | object |  | Error detail. |
| ^^^package_id | string | 1231231231231313123132 | Package ID. |
### Response Sample
```json
{"code":0,"data":{"packages":[{"id":"413234134123412","order_ids":["1233213123123","32132131231"]}],"errors":[{"code":10007014,"message":"fulfillment not allow combine package","detail":{"package_id":"1231231231231313123132"}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 21011028 | The package does not belong to the current shop. Please ensure you are providing the correct package ID and/or shop cipher. |
| 21011031 | Order does not belong to pre_pkg. Please ensure you are providing the correct order ID(s). |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Uncombine Packages — `POST /fulfillment/202309/packages/{package_id}/uncombine`

Doc: https://partner.tiktokshop.com/docv2/page/uncombine-packages-202309 · cập nhật 2026-10-26 · scope: seller.fulfillment.package.write

### Path: /fulfillment/202309/packages/{package_id}/uncombine
### Method: [POST]
### Function Description
Use this API to uncombine one or more orders from an already combined package.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| package_id | string | Y | 123456 | Package ID you wish to uncombine an order(s) from. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_ids | []string | N | ["11132131131"] | TikTok Shop order ID. Indicate the orders that need to be removed from the package. Please make sure the orders belong to the package. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/packages/123456/uncombine?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"order_ids":["11132131131"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^packages | []object |  | The packages created after the specified orders are removed from the original combined package. |
| ^^id | string | 123456 | The newly generated package ID(s) after being uncombined. |
| ^^order_ids | []string | ["576462377512830168"] | List of order ID(s) corresponding to the uncombined package ID(s). |
### Response Sample
```json
{"code":0,"data":{"packages":[{"id":"123456","order_ids":["576462377512830168"]}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 10006402 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 11001027 | System timeout. If this error persists, please contact the platform for assistance. |
| 21001001 | Invalid parameters. Please ensure you are passing the correct request parameter(s). |
| 21001008 | not found error |
| 21001028 | The order is being processed. Try again later. |
| 21008042 | seller already print shipping label |
| 21011001 | Package not found. If the error persists, please contact the platform for assistance. |
| 21011005 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 21011006 | These orders are already shipped. |
| 21011007 | Package item has after-sale request, please process the after-sale request first. |
| 21011017 | no need to combine single order |
| 21011028 | The package does not belong to the current shop. Please ensure you are providing the correct package ID and/or shop cipher. |
| 21011029 | order does not belong to fulfill unit |


---

## Get Package Handover Time Slots — `GET /fulfillment/202309/packages/{package_id}/handover_time_slots`

Doc: https://partner.tiktokshop.com/docv2/page/get-package-handover-time-slots-202309 · cập nhật 2026-10-26 · scope: seller.fulfillment.package.write

### Path: /fulfillment/202309/packages/{package_id}/handover_time_slots
### Method: [GET]
### Function Description
Use this API to retrieve a specified package's door-to-door pickup time slots and handover availability for pickup, drop-off, and, in the UK, van collection. When available, the response also provides a URL for finding drop-off locations.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| package_id | string | Y | 5433567853345 | TikTok Shop package ID. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/packages/5433567853345/handover_time_slots?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^can_pickup | bool | true | Whether this package supports door-to-door collection. |
| ^can_drop_off | bool | true | Whether this package be dropped off at a drop-off location |
| ^can_van_collection | bool | true | Specific to UK. Use this field to determine whether van collection is available. |
| ^drop_off_point_url | string | https://jtexpress.my/location | View package drop-off locations via provided URL. |
| ^pickup_slots | []object |  | Door-to-door collection time slots. Check `avaliable` to determine whether each time slot can be scheduled. |
| ^^start_time | int | 1623812664 | The start of the package pickup time slot, as a Unix timestamp in seconds. |
| ^^end_time | int | 1623812664 | The end of the package pickup time slot, as a Unix timestamp in seconds. |
| ^^avaliable | bool | true | Whether an appointment be made for this time slot. |
### Response Sample
```json
{"code":0,"data":{"can_pickup":true,"can_drop_off":true,"can_van_collection":true,"drop_off_point_url":"https://jtexpress.my/location","pickup_slots":[{"start_time":1623812664,"end_time":1623812664,"avaliable":true}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 11001027 | System timeout. If this error persists, please contact the platform for assistance. |
| 11021009 | No available shipping services for this request. Please modify the package weight or check the recipient address. If the error persists, please contact the platform for assistance. |
| 21001001 | Invalid parameters. Please ensure you are passing the correct request parameter(s). |


---

## Ship Package — `POST /fulfillment/202309/packages/{package_id}/ship`

Doc: https://partner.tiktokshop.com/docv2/page/ship-package-202309 · cập nhật 2026-10-28 · scope: seller.fulfillment.basic, seller.fs.order&fufillment.management

### Path: /fulfillment/202309/packages/{package_id}/ship
### Method: [POST]
### Function Description
Use this API to ship a package. There are two kinds of shipping options available: `TikTok Shipping` or `Seller Shipping`.

* `TikTok Shipping`: Schedule a package handover time for TikTok Shipping carriers to pickup a package from seller.
* `Seller Shipping`: Seller arranges their own shipping, and uploads a tracking number and `shipping_provider_id`. Package ID can be obtained from [Get Order Detail](https://partner.tiktokshop.com/docv2/page/650aa8ccc16ffe02b8f167a0?external_id=650aa8ccc16ffe02b8f167a0#Back%20To%20Top).
* `In-store Pickup`: Confirms shipment and notifies the buyer that the order is ready for pickup.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| package_id | string | Y | 5433567853345 | TikTok Shop package ID. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| handover_method | string | N | PICKUP | Possible values: |

* `PICKUP`: A logistics carrier will pick up the package(s) from the seller's pickup address.
* `DROP_OFF`: The seller will need to drop off the package(s) to a designated location. |
   pickup_slot |object |N | |Pickup time slot.
   |
   ^start_time |int |N |1623812664 |The start date and time of the package pickup time slot, as a Unix timestamp in seconds. |
   ^end_time |int |N |1623812664 |The end date and time of the package pickup time slot, as a Unix timestamp in seconds. |
   self_shipment |object |N | |Only needed for merchant self-shipping packages. Check the `delivery_option` field of [Get Package Detail](https://partner.tiktokshop.com/docv2/page/650aa39fbace3e02b75d8617?external_id=650aa39fbace3e02b75d8617#Back%20To%20Top) to see how to differentiate platform-logistics and self-shipping. Use the `shipping_provider_id` retrieved from [Get Shipping Providers](https://partner.tiktokshop.com/docv2/page/650aa48d4a0bb702c06d85cd?external_id=650aa48d4a0bb702c06d85cd) and upload the corresponding `tracking_number`. |
   ^tracking_number |string |Y |JX12345 |For package with `SEND_BY_SELLER` as `delivery_option` (merchant self-shipping mode), you must input a `tracking_number` to call this API. |
   ^shipping_provider_id |string |Y |6617675021119438849 |For package with `SEND_BY_SELLER` as `delivery_option` (merchant self-shipping mode), you must input a `shipping_provider_id` to call this API. Please use [Get Shipping Providers](https://partner.tiktokshop.com/docv2/page/650aa48d4a0bb702c06d85cd?external_id=650aa48d4a0bb702c06d85cd) to obtain the `shipping_provider_id`. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/packages/5433567853345/ship?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"handover_method":"PICKUP","pickup_slot":{"start_time":1623812664,"end_time":1623812664},"self_shipment":{"tracking_number":"JX12345","shipping_provider_id":"6617675021119438849"}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
### Response Sample
```json
{"code":0,"data":{},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 11001002 | invalid param. |
| 11001031 | System process error, please try again later. |
| 11006013 | Failed to ship package. Products under the Phones & Tablets category cannot be shipped together with other items in the same package. Please split the order. |
| 11006014 | Failed to ship package. If you are shipping multiple products under the Phones & Tablets category, they must be shipped in individual packages. Please split the order to continue. |
| 11006021 | Package has been shipped. Please not ship the package again. |
| 11021009 | No available shipping services for this request. Please modify the package weight or check the recipient address. If the error persists, please contact the platform for assistance. |
| 11021010 | The shipment failed due to an invalid postal code. Please ask the buyer to edit the address. If the address cannot be changed, you may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021011 | Fail to ship package because the product name is invalid. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021012 | illegal address |
| 11021013 | The shipment failed because the delivery address is too long. Please ask the buyer to shorten the address. If the address cannot be changed, you may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021014 | product oversize |
| 11021015 | Fail to ship package because the package is overweight. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021016 | Fail to ship package because the weight of the SKU exceeds the allowed limit. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021017 | Fail to ship package because the SKU dimensions exceed the allowed limits. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021018 | Fail to ship package because the number of items in the package exceeds the allowed limit. |
| 11021019 | Fail to ship package because the package dimensions exceed the allowed limits. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021020 | Fail to ship package because the package's circumference exceeds the allowed limit. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021021 | Fail to ship package because the SKU name is invalid. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021022 | Fail to ship package because the longest dimension of the package exceeds the allowed limit. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021023 | Fail to ship package because the buyer and/or seller addresses are invalid. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021024 | Fail to ship package because the buyer recipient address is invalid. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021025 | Fail to ship package because the seller shipping address is invalid. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11028006 | This tracking number cannot be matched to any carrier, please check the tracking number and upload again. |
| 11050001 | invalid param |
| 21001001 | Invalid parameters. Please ensure you are passing the correct request parameter(s). |
| 21001003 | System timeout. If the error persists, please contact the platform for assistance. |
| 21001008 | not found error |
| 21001011 | System process error, please try again later. |
| 21001028 | The order is being processed. Try again later. |
| 21004006 | Failed to ship. Please ensure an invoice is uploaded before shipping. |
| 21004017 | ON DEMAND RTS NOT IN PICKUP TIME. |
| 21004019 | Need invoice uploaded for all order before rts. |
| 21004020 | Fulfillment Invoice status is not success, can not rts pkg. |
| 21004024 | ship order failed due to platform limitations. |
| 21008025 | Seller cannot operate orders which are fulfilled by platform |
| 21008044 | SellerFulfillUnitInReverseCannotOperate |
| 21008099 | Package has been shipped. Please not ship the package again. |
| 21011001 | Package not found. If the error persists, please contact the platform for assistance. |
| 21011003 | fulfill_unit action not allowed |
| 21011007 | Package item has after-sale request, please process the after-sale request first. |
| 21011008 | Package is not complete. If the error persists, please contact the platform for assistance. |
| 21011020 | These orders are already shipped. |
| 21011022 | Invalid tracking number or provider ID. Please double check and try again. |
| 21011025 | Duplicate tracking number. |
| 21011026 | fulfillment tracking no used times over limit |
| 21011027 | Package has already been delivered. |
| 21011028 | The package does not belong to the current shop. Please ensure you are providing the correct package ID and/or shop cipher. |
| 21011030 | fulfillment not allow update tracking no |
| 21011040 | Package has already been shipped. |
| 21011041 | Cannot complete the operation when order is cancelled. |
| 21011050 | The tracking number can only be updated within a certain number of hours. |
| 21011051 | The tracking number can only be updated once. |
| 21011053 | Fail to ship package because the shipment time is outside of the pick-up time slot. |
| 21011054 | No available shipping services for this request due to missing pick-up time slot. Please contact customer service for assistance. |
| 21014009 | Failed to ship. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 21021010 | Failed to ship. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 21022029 | System process error, please try again later. |
| 21022032 | match provider failed. |
| 21034012 | tracking no has been used |
| 21042001 | System process error, please try again later. |
| 21042067 | The logistics service provider couldn't process your order. |
| 21042076 | System process error, please try again later. |
| 21042227 | For pop 4pl（cross-border），the return warehouse for the shipping location has not been configured. |
| 21042251 | Abnormal order status, item cannot be shipped. |


---

## Batch Ship Packages — `POST /fulfillment/202309/packages/ship`

Doc: https://partner.tiktokshop.com/docv2/page/batch-ship-packages-202309 · cập nhật 2026-10-28 · scope: seller.fulfillment.basic, seller.fs.order&fufillment.management

### Path: /fulfillment/202309/packages/ship
### Method: [POST]
### Function Description
Use this API to ship one or more packages in a single request. The API supports TikTok Shipping, Seller Shipping, and In-store Pickup.

* `TikTok Shipping`: Set each package's `handover_method` to `PICKUP` for carrier pickup from the seller's pickup address, or to `DROP_OFF` when the seller will drop it off at a designated location.
* `Seller Shipping`: Provide `self_shipment.shipping_provider_id` and `self_shipment.tracking_number` for each package. Obtain package IDs from [Get Order Detail](https://partner.tiktokshop.com/docv2/page/650aa8ccc16ffe02b8f167a0?external_id=650aa8ccc16ffe02b8f167a0).
* `In-store Pickup`: Confirm shipment and notify the buyer that the order is ready for pickup.

A response with a top-level `code` of `0` can still contain package-specific failures. Check `data.errors` before treating every package as shipped.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| packages | []object | Y |  | Input list of packages you would like to batch ship. |
| ^id | string | Y | 12321312312431 | Package ID. |
| ^handover_method | string | N | PICKUP | Possible values: |

* `PICKUP`: A shipping provider will pickup the package(s) from the seller's pickup address.
* `DROP_OFF`: The seller will need to drop off the package(s) at a designated location. |
   ^pickup_slot |object |N | |Package pickup time slot. |
   ^^start_time |int |N |1623812664 |The start of the package pickup time slot, as a Unix timestamp in seconds. |
   ^^end_time |int |N |1623812664 |The end of the package pickup time slot, as a Unix timestamp in seconds. |
   ^self_shipment |object |N | |Only needed for seller shipping packages. Check the `delivery_option`field in [Get Package Detail](https://partner.tiktokshop.com/docv2/page/650aa39fbace3e02b75d8617?external_id=650aa39fbace3e02b75d8617) to see how to differentiate between TikTok shipping and seller shipping. Use the `shipping_provider_id` retrieved from the [Get Shipping Providers](https://partner.tiktokshop.com/docv2/page/650aa48d4a0bb702c06d85cd?external_id=650aa48d4a0bb702c06d85cd#Back%20To%20Top) API and upload the corresponding tracking number. |
   ^^tracking_number |string |Y |JX12345 |For packages with the `SEND_BY_SELLER` delivery option type (seller shipping), you must provide the package's tracking number. |
   ^^shipping_provider_id |string |Y |6617675021119438849 |For packages with the `SEND_BY_SELLER` delivery option type (seller shipping), you must provide the shipping provider information. Please use the [Get Shipping Providers](https://partner.tiktokshop.com/docv2/page/650aa48d4a0bb702c06d85cd?external_id=650aa48d4a0bb702c06d85cd#Back%20To%20Top) API to obtain the `shipping_provider_id`. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/packages/ship?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"packages":[{"id":"12321312312431","handover_method":"PICKUP","pickup_slot":{"start_time":1623812664,"end_time":1623812664},"self_shipment":{"tracking_number":"JX12345","shipping_provider_id":"6617675021119438849"}}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^errors | []object |  | Package-specific errors for packages that could not be shipped. Check this list even when the top-level response `code` is `0`. |
| ^^code | int | 10007014 | The failure reason code. |
| ^^message | string | package in freeze status | The failure reason message. |
| ^^detail | object |  | Error detail. |
| ^^^package_id | string | 123123123123131 | Package ID. |
### Response Sample
```json
{"code":0,"data":{"errors":[{"code":10007014,"message":"package in freeze status","detail":{"package_id":"123123123123131"}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 11006013 | Failed to ship package. Products under the Phones & Tablets category cannot be shipped together with other items in the same package. Please split the order. |
| 11006014 | Failed to ship package. If you are shipping multiple products under the Phones & Tablets category, they must be shipped in individual packages. Please split the order to continue. |
| 11021009 | No available shipping services for this request. Please modify the package weight or check the recipient address. If the error persists, please contact the platform for assistance. |
| 11021010 | The shipment failed due to an invalid postal code. Please ask the buyer to edit the address. If the address cannot be changed, you may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021011 | Fail to ship package because the product name is invalid. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021012 | illegal address |
| 11021013 | The shipment failed because the delivery address is too long. Please ask the buyer to shorten the address. If the address cannot be changed, you may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021014 | product oversize |
| 11021015 | Fail to ship package because the package is overweight. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021016 | Fail to ship package because the weight of the SKU exceeds the allowed limit. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021017 | Fail to ship package because the SKU dimensions exceed the allowed limits. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021018 | Fail to ship package because the number of items in the package exceeds the allowed limit. |
| 11021019 | Fail to ship package because the package dimensions exceed the allowed limits. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021020 | Fail to ship package because the package's circumference exceeds the allowed limit. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021021 | Fail to ship package because the SKU name is invalid. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021022 | Fail to ship package because the longest dimension of the package exceeds the allowed limit. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021023 | Fail to ship package because the buyer and/or seller addresses are invalid. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021024 | Fail to ship package because the buyer recipient address is invalid. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11021025 | Fail to ship package because the seller shipping address is invalid. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 11028006 | This tracking number cannot be matched to any carrier, please check the tracking number and upload again. |
| 21001003 | System timeout. If the error persists, please contact the platform for assistance. |
| 21001011 | System process error, please try again later. |
| 21001028 | The order is being processed. Try again later. |
| 21004006 | Failed to ship. Please ensure an invoice is uploaded before shipping. |
| 21008044 | SellerFulfillUnitInReverseCannotOperate |
| 21011001 | Package not found. If the error persists, please contact the platform for assistance. |
| 21011003 | fulfill_unit action not allowed |
| 21011007 | Package item has after-sale request, please process the after-sale request first. |
| 21011008 | Package is not complete. If the error persists, please contact the platform for assistance. |
| 21011020 | These orders are already shipped. |
| 21011022 | Invalid tracking number or provider ID. Please double check and try again. |
| 21011025 | Duplicate tracking number. |
| 21011027 | Package has already been delivered. |
| 21011028 | The package does not belong to the current shop. Please ensure you are providing the correct package ID and/or shop cipher. |
| 21011040 | Package has already been shipped. |
| 21011041 | Cannot complete the operation when order is cancelled. |
| 21011053 | Fail to ship package because the shipment time is outside of the pick-up time slot. |
| 21011054 | No available shipping services for this request due to missing pick-up time slot. Please contact customer service for assistance. |
| 21014009 | Failed to ship. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 21042227 | For pop 4pl（cross-border），the return warehouse for the shipping location has not been configured. |
| 21042251 | Abnormal order status, item cannot be shipped. |


---

## Get Package Shipping Document — `GET /fulfillment/202309/packages/{package_id}/shipping_documents`

Doc: https://partner.tiktokshop.com/docv2/page/get-package-shipping-document-202309 · cập nhật 2026-10-28 · scope: seller.fulfillment.basic, seller.fs.order&fufillment.management

### Path: /fulfillment/202309/packages/{package_id}/shipping_documents
### Method: [GET]
### Function Description
For packages shipped with TikTok Shipping, use this API to retrieve the URL of the shipping document selected by `document_type` for the package specified by `package_id`. First call `Ship Package` to arrange shipment, then retrieve the document before the package is picked up.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| package_id | string | Y | 5433567853345 | TikTok Shop package ID. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| document_type | string | Y | SHIPPING_LABEL | Available document types: |

* `SHIPPING_LABEL`: Returns the shipping label in PDF format by default.
* `PACKING_SLIP`: Returns the packing slip in PDF format by default.
* `SHIPPING_LABEL_AND_PACKING_SLIP`: Returns both the shipping label and the packing slip for the package, both in PDF format by default.
* `SHIPPING_LABEL_PICTURE`: Returns the shipping label in PNG format.
* `HAZMAT_LABEL`: Returns the hazmat label in PDF format by default. You must only use this value when there are hazmat items in the package. When you use the value, `document_size` is fixed to A4, and you don't need to specify `document_size`.
* `INVOICE_LABEL`: For Brazil market only, document_size is fixed to A6, and you don't need to specify `document_size`. Returns the invoice label in PDF format by default |
   document_size |string |N |A6 |Use this field to specify the size of the document to obtain. This parameter is only applicable to shipping labels, picking slips, and packing slips that are in the PDF format. It is not applicable for hazmat labels as these are fixed to A4.
   If you specify `SHIPPING_LABEL_PICTURE` for the `document_type`, any value specified in the `document_size` will be ignored.

Possible values:

* `A6` (Default)
* `A5` |
   document_format |string |N |PDF |The format of the shipping document.
   Possible values:
* PDF (Default)
* ZPL (Only for BR and MX market)

**Note**: Not applicable for `SHIPPING_LABEL_PICTURE` document type. |
shipping_period |string |N |DEFAULT |Obtain shipping labels from designated last-mile delivery providers for cross-border scenarios.
Possible values:

* DEFAULT (Default)
* LAST_MILE (Only cross-border services under the 4PL model with the business solution of 3PL for main transport & customs clearance + 4PL for last-mile delivery will return the last-mile shipping label; calls from all other scenarios will be invalid.
   ) |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/packages/5433567853345/shipping_documents?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&document_type=SHIPPING_LABEL&document_size=A6&document_format=PDF&shipping_period=DEFAULT
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^doc_url | string | https://magelng.bytedance.net2/wsos_v2/oec_fulfillment_doc_tts/object/wsos641232 | The URL of the shipping document generated for the specified package according to the requested `document_type`. The URL is valid for 24 hours. |
| ^tracking_number | string | 752455325694 | The package tracking number from the shipping carrier. |
|  |  |  |  |
### Response Sample
```json
{"code":0,"data":{"doc_url":"https://magelng.bytedance.net2/wsos_v2/oec_fulfillment_doc_tts/object/wsos641232","tracking_number":"752455325694"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 11006010 | Internal package status error, please try again later. |
| 11034002 | This API is only applicable to TikTok Shipping orders. For seller shipping, please obtain the shipping label offline and upload it to TikTok Shop via API or Seller Center. |
| 11034009 | Warehouse does not exist. |
| 11034023 | Shipping document generation timeout error, please try again later. |
| 11034025 | Internal package tag error, pleaser try again later. |
| 11034037 | The shipping document is still being generated by the logistics provider, please try again later. |
| 21008017 | This API is only applicable to TikTok Shipping orders. For seller shipping, please obtain the shipping label offline and upload it to TikTok Shop via API or Seller Center. |
| 21008043 | This package is fulfilled by TikTok. Shipping documents cannot be printed. |
| 21008109 | Unable to retrieve shipping information, please double check the order status. |
| 21011001 | Package not found. If the error persists, please contact the platform for assistance. |
| 21021010 | Failed to ship. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 21023022 | Unknown label print timeout error. If the error persists, please contact the platform for assistance. |
| 21023034 | Internal package update error, please try again later. |
| 21023035 | Please arrange shipment before retrieving the shipping document. |
| 21023046 | Package has already been shipped. |
| 21023059 | Package has already been cancelled. |
| 21042102 | Documents couldn't be printed after the package has been pickup. |
| 21042104 | Documents couldn't be printed before shipped.Please check shipping is arranged and try again. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Package Detail — `GET /fulfillment/202309/packages/{package_id}`

Doc: https://partner.tiktokshop.com/docv2/page/get-package-detail-202309 · cập nhật 2026-10-26 · scope: seller.fulfillment.basic, seller.fs.order&fufillment.management

### Path: /fulfillment/202309/packages/{package_id}
### Method: [GET]
### Function Description
Returns information about a package, including handover time slot, tracking number, and shipping provider information.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| package_id | string | Y | 5433567853345 | TikTok Shop package ID. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/packages/5433567853345?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^package_id | string | 5433567853345 | TikTok Shop package ID. |
|  |  |  |  |
| ^orders | []object |  | The response list of TikTok Shop orders. |
| ^^id | string | 54335448533296 | TikTok Shop order ID. |
| ^^skus | []object |  | [Deprecated]SKU information. |
| ^^^id | string | 2729382476852921560 | [Deprecated]SKU ID. |
| ^^^name | string | white,128g | [Deprecated]SKU name. |
| ^^^image_url | string | https://p19-oec-sg.ibyteimg.com/tos-maliva-i-o3syd03w52-us/12345670c | [Deprecated]SKU image in order snapshot. |
| ^^^quantity | int | 5 | [Deprecated]SKU quantity. |
| ^package_status | string | PROCESSING | Possible values: |

* `TO_FULFILL`：Waiting for the merchant or warehouse to ship the package.
* `PROCESSING`: Package has been arranged by seller. Waiting for carrier to collect the parcel.
* `FULFILLING`: Package has been collected by carrier and in transit.
* `COMPLETED`: Package has been delivered.
* `CANCELLED`: Package has been canceled. Normally, the package is canceled due to the package being lost or damaged. |
   ^package_sub_status |string |CREATED |Package sub-status.
   Possible values:
* `CREATED`: The package has been created.
* `ISSUE`: Package allocation failed; contact platform support.
* `STOCKING`: Platform verification is complete and the package is waiting for the seller to ship it.
* `RTSING`: The shipping label is being purchased and the carrier result is pending.
* `HBW`: For FBT orders only; the package has been created in the warehouse.
* `HBWING`: For FBT orders only; the package is being created in the warehouse.
* `TSP_PENDING`: Authorization for third-party service-provider fulfillment is pending.
* `RTS`: The shipping label has been purchased and the seller can print it.
* `TTS`: The carrier has picked up the package.
* `DELIVERED`: The package has been delivered to the buyer.
* `SHIP_EXCEPTION`: The package cannot be delivered, for example because it is damaged or lost. See `ship_exception_reason` for the detailed reason.
* `PART_DELIVERED_AND_EXCEPTION`: Part of the package delivery completed and another part encountered a shipping exception.
* `CANCELLED`: The package has been canceled. |
   ^ship_exception_reason |string |PACKAGE_LOST |-PACKAGE_DAMAGAED
   -PACKAGE_LOST
   -RETURNED_TO_SHIPPER
   -PACKAGE_SCRAP |
   ^split_and_combine_tag |string |SPLIT |Possible values:
* `DEFAULT`: The package has not undergone any combine or split operation.
* `COMBINE`: The package has been consolidated with another order.
* `SPLIT`: The order has been split into multiple orders. |
   ^has_multi_skus |bool |true |Whether there are multiple SKU IDs in a package. |
   ^note_tag |string |BUYER_UNNOTED |Possible values:
* `BUYER_UNNOTED`: The order has not been noted by buyer.
* `BUYER_NOTED`: The order has been noted by buyer.
   |
   ^shipping_provider_name |string |TT Virtual express |Package shipping provider name. |
   ^shipping_provider_id |string |6617675021119438849 |Package shipping provider ID. |
   ^shipping_type |string |TIKTOK |Indicates who provides the shipping service. Possible values:
* `TIKTOK`: Shipping service provided by TikTok. The seller should obtain a shipping label from TikTok.
* `SELLER`: Seller provides shipping, including through a third-party fulfillment provider acting on the seller's behalf. |
   ^delivery_option_name |string |Shipped from seller
   |Delivery option name. For display purposes only. |
   ^delivery_option_id |string |7091146663229654785 |Order delivery option ID. Delivery option ID is mapped to seller configured logistics templates ID. |
   ^tracking_number |string |6617675021119438849 |Package tracking number. |
   ^last_mile_tracking_number |string |6617675021119438849 |For cross-border order only. Cross-border order last mile tracking number.
   |
   ^pickup_slot |object | |The carrier pickup time slot scheduled for the package. |
   ^^start_time |int |1635338186 |Start of the time slot when the carrier is scheduled to pick up the package, as a Unix timestamp in seconds. |
   ^^end_time |int |1635338186 |End of the time slot when the carrier is scheduled to pick up the package, as a Unix timestamp in seconds. |
   ^create_time |int |1635338186 |Package creation time. Unix timestamp, in seconds. |
   ^handover_method |string |PICKUP |Whether the package is delivered by pick up or drop off. Possible values:
* `PICKUP`: A Logistics carrier will pickup the package(s) from the seller's pickup address.
* `DROP_OFF`: Seller will need to drop off the package(s) to a designated location. |
   ^order_line_item_ids |[]string |["1729382476852921560"] |The order line item ID contained in the package. |
   ^recipient_address |object | |Recipient address and contact information. Returned personal information may be masked to protect the recipient's privacy. |
   ^^full_address |string |1*** Coleman Ave San Jose, CA 95110
   |The recipient's complete address, including geographic and detailed street-address information. |
   ^^phone_number |string |(+1)213-***-1234***
   ***|The telephone number of the buyer. Please note, if this order use platform logistics, phone number will be desensitized. |***
   ***^^name |string |Zay |The name of the recipient. Please note, if this order uses platform logistics, recipient name will be desensitized |***
   ***^^postal_code |string |95110***
   ***|The postal code that can be used by seller for shipping (in the U.S, this refers to the ZIP code). |***
   ***^^address_detail |string |Unit one building 8***
   ***|The detailed street-address portion of the recipient's address. |***
   ***^^region_code |string |US |The country or region code of the recipient address. |***
   ***^^address_line1 |string |TikTok 5800 bristol Pkwy***
   ***|The first line of the street address |***
   ***^^address_line2 |string |Suite 100***
   ***|The second line of the street address. |***
   ***^^address_line3 |string |Suite 100***
   ***|The third line of the street address. Usually only for the Brazilian market. |***
   ***^^address_line4 |string |Suite 100***
   ***|The fourth line of the street address. Usually only for the Brazilian market. |***
   ***^sender_address |object | |The sender's address and contact information. Sensitive fields may be masked. |***
   ***^^full_address |string |1*** Coleman Ave San Jose, CA 95110 |The complete sender address, including geographic address components and address details. |
   ^^phone_number |string |(+1)213-***-1234
   |The telephone number of the sender. |
   ^^name |string |Zay |The name of the sender. |
   ^^postal_code |string |95110 |The postal code of the sender. |
   ^^address_detail |string |Unit one building 8 |The detailed street-address portion of the sender's address. |
   ^^region_code |string |US |Region code of the sender. |
   ^^address_line1 |string |TikTok 5800 bristol Pkwy |The first line of the sender's street address. |
   ^^address_line2 |string |Suite 100 |The second line of the sender's street address. |
   ^^address_line3 |string |Suite 100 |The third line of the sender's street address. Usually only for the Brazilian market. |
   ^^address_line4 |string |Suite 100 |The fourth line of the sender's street address. Usually only for the Brazilian market. |
   ^weight |object | |The weight of the scheduled package. |
   ^^value |string |1.2 |The value of the weight of the scheduled package. |
   ^^unit |string |GRAM |The unit of measurement used to measure the weight. Possible values:
* `GRAM`
* `POUND` |
   ^dimension |object | |The dimensions of the scheduled package. |
   ^^length |string |1.2 |The length of the scheduled package. |
   ^^width |string |0.2 |The width of the scheduled package. |
   ^^height |string |0.03 |The height of the scheduled package. |
   ^^unit |string |CM |The unit of measurement for the package dimensions. Possible values:
* `CM`
* `INCH` |
   ^update_time |int |1635338186 |The time when the package was last updated, as a Unix timestamp in seconds. |
   ^insurance |object | |US only. Provides details of shipping insurance auto-enrolled during label purchase. |
   ^^is_purchased |bool |true |Whether insurance has been purchased for the package. |
   ^^coverage_amount |string |200 |The insurance coverage amount for the package. Units: USD. |
   ^^is_claim_eligible |bool |true |Whether the package is eligible for an insurance claim, based on eligible refund reasons. |
   ^^claim_status |string |CLAIM_PENDING |The insurance claim status.
   Available values:
* `NOT_STARTED`: Claim has not been initiated for this package.
* `CLAIM_PENDING`: Claim is currently under review.
* `APPROVED`: Claim has been approved.
* `DECLINED`: Claim has been declined. |
   ^biz_extension_tags |[]string |["NON_MCF"] |Special tags for current package if any.
* `NON_MCF`: whether this package was shipped as a MCF order while in fact it is not. |
   ^warehouse_id |string |7317467398322308906 |Seller Warehouse id for this package |

### Response Sample
```json
{"code":0,"data":{"package_id":"5433567853345","orders":[{"id":"54335448533296","skus":[{"id":"2729382476852921560","name":"white,128g","image_url":"https://p19-oec-sg.ibyteimg.com/tos-maliva-i-o3syd03w52-us/12345670c","quantity":5}]}],"package_status":"PROCESSING","package_sub_status":"CREATED","ship_exception_reason":"PACKAGE_LOST","split_and_combine_tag":"SPLIT","has_multi_skus":true,"note_tag":"BUYER_UNNOTED","shipping_provider_name":"TT Virtual express","shipping_provider_id":"6617675021119438849","shipping_type":"TIKTOK","delivery_option_name":"Shipped from seller\n","delivery_option_id":"7091146663229654785","tracking_number":"6617675021119438849","last_mile_tracking_number":"6617675021119438849","pickup_slot":{"start_time":1635338186,"end_time":1635338186},"create_time":1635338186,"handover_method":"PICKUP","order_line_item_ids":["1729382476852921560"],"recipient_address":{"full_address":"1*** Coleman Ave San Jose, CA 95110\n","phone_number":"(+1)213-***-1234\n","name":"Zay","postal_code":"95110\n","address_detail":"Unit one building 8\n","region_code":"US","address_line1":"TikTok 5800 bristol Pkwy\n","address_line2":"Suite 100\n","address_line3":"Suite 100\n","address_line4":"Suite 100\n"},"sender_address":{"full_address":"1*** Coleman Ave San Jose, CA 95110","phone_number":"(+1)213-***-1234\n","name":"Zay","postal_code":"95110","address_detail":"Unit one building 8","region_code":"US","address_line1":"TikTok 5800 bristol Pkwy","address_line2":"Suite 100","address_line3":"Suite 100","address_line4":"Suite 100"},"weight":{"value":"1.2","unit":"GRAM"},"dimension":{"length":"1.2","width":"0.2","height":"0.03","unit":"CM"},"update_time":1635338186,"insurance":{"is_purchased":true,"coverage_amount":"200","is_claim_eligible":true,"claim_status":"CLAIM_PENDING"},"biz_extension_tags":["NON_MCF"],"warehouse_id":"7317467398322308906"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 10006402 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Order Tracking — `GET /fulfillment/202309/orders/{order_id}/tracking`

Doc: https://partner.tiktokshop.com/docv2/page/get-order-tracking-202309 · cập nhật 2026-10-10 · scope: seller.logistics

### Path: /fulfillment/202309/orders/{order_id}/tracking
### Method: [GET]
### Function Description
This API can use the order number to obtain the corresponding logistics tracking information.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_id | string | Y | 576461413038785752 | TikTok Shop order ID. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/orders/576461413038785752/tracking?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^tracking | []object |  | The return list of tracking information. |
| ^^description | string | Your package was delivered! |  |
| Tracking status description. |  |  |  |
| ^^update_time_millis | int | 1694685539000 | Tracking status update time. Unix timestamp in milliseconds. |
| ^^action_code | int | 50101 | Code that identifies the tracking event type. Use `description` for the human-readable event message. |
### Response Sample
```json
{"code":0,"data":{"tracking":[{"description":"Your package was delivered!\n","update_time_millis":1694685539000,"action_code":50101}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Update Order Shipping Info — `POST /fulfillment/202309/orders/{order_id}/shipping_info/update`

Doc: https://partner.tiktokshop.com/docv2/page/update-order-shipping-info-202309 · cập nhật 2026-10-28 · scope: seller.logistics

### Path: /fulfillment/202309/orders/{order_id}/shipping_info/update
### Method: [POST]
### Function Description
If the seller entered an incorrect tracking number, this API allows the seller to update the tracking number and shipping provider for an order that has already been shipped.

* This API is only applicable to orders (or packages) shipped by the seller.
* It is only used to update the tracking number and shipping provider for packages that have already been shipped.
* For orders that have been split for shipping, please use the [Update Package Shipping Info API](https://partner.tiktokshop.com/docv2/page/650aa666c16ffe02b8f1203c?external_id=650aa666c16ffe02b8f1203c).

Please note that TikTok Shop only allows merchants to update shipping information within 72 hours after shipping.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_id | string | Y | 576461413038785752 | TikTok Shop order ID. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| tracking_number | string | Y | 576460868968549926 | The shipment tracking number provided by the carrier. It must contain 4 to 50 characters consisting only of letters, numbers, hyphens (`-`), underscores (`_`), periods (`.`), or slashes (`/`). |
| shipping_provider_id | string | Y | 6965352555291346690 | Identifies the carrier that will deliver the package. Please call [Get Shipping Providers API](https://partner.tiktokshop.com/docv2/page/650aa48d4a0bb702c06d85cd?external_id=650aa48d4a0bb702c06d85cd#Back%20To%20Top) to retrieve the available shipping provider(s). |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/orders/576461413038785752/shipping_info/update?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"tracking_number":"576460868968549926","shipping_provider_id":"6965352555291346690"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
### Response Sample
```json
{"code":0,"data":{},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 10007002 | Current order is not a merchant blind box order. |
| 21001028 | The order is being processed. Try again later. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 21011001 | Package not found. If the error persists, please contact the platform for assistance. |
| 21011004 | This API cannot be used to update package shipping information for packages that are not shipped by sellers. |
| 21011007 | Package item has after-sale request, please process the after-sale request first. |
| 21011022 | Invalid tracking number or provider ID. Please double check and try again. |
| 21011028 | The package does not belong to the current shop. Please ensure you are providing the correct package ID and/or shop cipher. |
| 21011030 | fulfillment not allow update tracking no |
| 21011041 | Cannot complete the operation when order is cancelled. |
| 21011042 | Cannot complete the operation when order is cancelled. |
| 21011043 | The package has not been shipped yet. |
| 21011049 | Due to platform rule limitations, you are unable to update the tracking number. |
| 25001010 | A return request has already been completed, or the order has already been cancelled. |


---

## Upload Proof of Delivery File — `POST /fulfillment/202309/files/upload`

Doc: https://partner.tiktokshop.com/docv2/page/upload-proof-of-delivery-file-202309 · cập nhật 2026-10-10 · scope: seller.fulfillment.basic

### Path: /fulfillment/202309/files/upload
### Method: [POST]
### Function Description
This API is used for the seller to upload the proof of delivery file for a package, and to generate the URL of the corresponding file. The generated URL is used for the [Update Package Delivery Status API](https://partner.tiktokshop.com/docv2/page/650aa332c16ffe02b8f0ba82?external_id=650aa332c16ffe02b8f0ba82).
This API only supports uploading qualification files in `PDF` format. The file size can not exceed 10MB.
Note: Only sellers utilizing the SOF (Seller Own Fleet) capability can use this API.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | multipart/form-data | Allowed type: multipart/form-data |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| data | file | Y | BWWCusFdYKa4W1wlphrbBWWCusFdYKaxtOawMj5ftPCQAAAABJRU5ErkJggg== | PDF file data to be uploaded to TikTok Shop. |
| Prerequisites： |  |  |  |  |

* Only `PDF` file format is supported.
* Original file size must not exceed 10MB. |
   name |string |Y |XXX.pdf |The name of the uploaded file. The file name must include the file type. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/files/upload?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^url | string | https://maellane.bytedance.net/wsos_v2/oec_fulfillment_doc_tts/o | The URL returned from uploading the file that can be directly opened in a browser. |
| ^name | string | attachment_file.pdf | The name of the file. |
### Response Sample
```json
{"code":0,"data":{"url":"https://maellane.bytedance.net/wsos_v2/oec_fulfillment_doc_tts/o","name":"attachment_file.pdf"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 12038002 | Invalid upload file. Please ensure you are passing the correct file data. |
| 12038004 | Invalid file type. Please ensure you are providing a PDF file. |
| 12038005 | Invalid file size. Please ensure your file is smaller than 10MB. |


---

## Upload Proof of Delivery Image — `POST /fulfillment/202309/images/upload`

Doc: https://partner.tiktokshop.com/docv2/page/upload-proof-of-delivery-image-202309 · cập nhật 2026-10-10 · scope: seller.fulfillment.basic

### Path: /fulfillment/202309/images/upload
### Method: [POST]
### Function Description
This API is used for the seller to upload the proof of delivery image for a package, and to generate the URL of the corresponding file. The generated URL is used in the [Update Package Delivery Status API](https://partner.tiktokshop.com/docv2/page/650aa332c16ffe02b8f0ba82?external_id=650aa332c16ffe02b8f0ba82) to indicate that the parcel has been delivered.
Usage requirements:

* The image format must be `JPEG`, `PNG`, or `JPG`.
* The image size can not exceed 5MB.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | multipart/form-data | Allowed type: multipart/form-data |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| data | file | Y | BWWCusFdYKa4W1wlphrbBWWCusFdYKaxtOawMj5ftPCQAAAABJRU5ErkJggg== | The image file to upload as binary data in this multipart/form-data field. |
Requirements:

* Format: `JPG`, `JPEG`, or `PNG`.
* Resolution: between 100 x 100 and 20,000 x 20,000 pixels.
* File size: no more than 5 MB. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/images/upload?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^url | string | https://p-pbe38.byted.org/tos-ppdi18n-i-0euhj0x6u9/0a119a90d90b41e3838608bc384 | The URL returned from uploading the image that can be directly opened in a browser. |
| ^height | int | 256 | The image height returned from uploading the image. This height refers to the processed image height, not the original image height. |
| Units: pixels. |  |  |  |
| ^width | int | 256 | The image width returned from uploading the image. This width refers to the processed image width, not the original image width. |
| Units: pixels. |  |  |  |
### Response Sample
```json
{"code":0,"data":{"url":"https://p-pbe38.byted.org/tos-ppdi18n-i-0euhj0x6u9/0a119a90d90b41e3838608bc384","height":256,"width":256},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 12019116 | Invalid image resolution. Please ensure your image is between 100 x 100 pixels and 20000 x 20000 pixels. |
| 12038002 | Invalid upload file. Please ensure you are passing the correct file data. |
| 12038004 | Invalid image file type. Please ensure your image is in JPG, JPEG, or PNG format. |
| 12038005 | Invalid image file size. Please ensure your image file size does not exceed 5MB. |


---

## Update Package Delivery Status — `POST /fulfillment/202309/packages/deliver`

Doc: https://partner.tiktokshop.com/docv2/page/update-package-delivery-status-202309 · cập nhật 2026-10-26 · scope: seller.delivery.status.write

### Path: /fulfillment/202309/packages/deliver
### Method: [POST]
### Function Description
Use this API to report delivery outcomes for SOF (Seller Own Fleet) packages or confirm O2O (Store Pickup) package delivery. For SOF, use `DELIVERY_SUCCESS`, `DELIVERY_FAILED`, or `UPDATE_POD`. For O2O, use `DELIVERY_SUCCESS` and provide the pickup verification code. Only sellers using SOF or O2O can use this API. This API is available only in the SEA region.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| packages | []object | Y |  | The packages to update. Provide at least one package. |
| ^id | string | Y | 11529598723402 | The package ID. |
| ^delivery_type | string | Y | DELIVERY_SUCCESS | Delivery status of the package. |
| Possible values for in-store pick up: |  |  |  |  |

* `DELIVERY_SUCCESS`: The package has been successfully delivered.
   Possible values for SOF (Seller Own Fleet):
* `DELIVERY_SUCCESS`: The package has been successfully delivered.
* `DELIVERY_FAILED`: The package could not be delivered successfully.
* `UPDATE_POD`: Updates the attachment for a package that has already been delivered. |
   ^fail_delivery_reason |string |N |INVALID_ADDRESS |Delivery failure reasons.

When `delivery_type = DELIVERY_FAILED`, this field is required. For other delivery types, this field is not required.
Possible values:

* `INVALID_ADDRESS`: The buyer shipping address is invalid.
* `UNABLE_RECEIVE`: The buyer is currently unable to receive the delivery.
* `UNABLE_CONTACT_BUYER`: Unable to contact the buyer.
* `BUYER_REFUSED`: The buyer has refused to receive the product.
* `DELAY_DELIVERY`: Delay in delivery.
* `PACKAGE_LOST`: The package is lost.
* `PACKAGE_DAMAGE`: The package is damaged.
* `FORCE_MAJEURE`: An unforeseeable event of force majeure has occurred.
* `OTHER`: Other reason.
   |
   ^file_type |string |N |IMG |Attachment type:
* `IMG`
* `PDF` |
   ^file_url |string |N |https://tiktok.shopcenter.cn/file/CWvBsBZ9mhbMiHtmbZecKshon6f?table=tblTW |Attachment URL.
   The seller can use the [Upload Delivery File](https://partner.tiktokshop.com/docv2/page/650aa6e04a0bb702c06dcd34?external_id=650aa6e04a0bb702c06dcd34#Back%20To%20Top) and [Upload Delivery Image](https://partner.tiktokshop.com/docv2/page/650aa70d0fcef602bf32772f?external_id=650aa70d0fcef602bf32772f) APIs to generate the URL. The attachment will be used by TikTok Shop to verify the package delivery. |
   ^verification_code |string |N |123456 |The verification code required for order pickup. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202309/packages/deliver?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"packages":[{"id":"11529598723402","delivery_type":"DELIVERY_SUCCESS","fail_delivery_reason":"INVALID_ADDRESS","file_type":"IMG","file_url":"https://tiktok.shopcenter.cn/file/CWvBsBZ9mhbMiHtmbZecKshon6f?table=tblTW","verification_code":"123456"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^errors | []object |  | Package-level failures from the batch request. Each entry identifies the affected package and contains the returned failure code and message fields. Check this list even when the top-level response code is `0`. |
| ^^code | int | 10007014 | The failure reason code. |
| ^^message | string | order not in sof service | Fulfillment failure reason. |
| ^^detail | object |  | Error detail. |
| ^^^package_id | string | 1231231231231 | Package ID. |
### Response Sample
```json
{"code":0,"data":{"errors":[{"code":10007014,"message":"order not in sof service","detail":{"package_id":"1231231231231"}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 21001011 | System process error, please try again later. |
| 21011028 | The package does not belong to the current shop. Please ensure you are providing the correct package ID and/or shop cipher. |
| 21042247 | The code you entered is incorrect. Please try again. |
| 21042248 | The maximum number of attempts has been reached. Please try again in 30 minutes. |
| 21042252 | Abnormal order status, failed to update delivery status, please try again later. |


---

## Upload Invoice — `POST /fulfillment/202502/invoice/upload`

Doc: https://partner.tiktokshop.com/docv2/page/upload-invoice-202502 · cập nhật 2026-10-16 · scope: seller.fulfillment.basic

### Path: /fulfillment/202502/invoice/upload
### Method: [POST]
### Function Description
Upload the invoice document.
**Note**: Applicable only for local sellers in the Brazil market.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| invoices | []object | N |  | The list of invoices to upload. When `invoices` is provided, include 1 to 500 items. |
| ^package_id | string | Y | 1231231231231 | The TikTok Shop package ID, retrieved from [Search Package](650aa592bace3e02b75db748). |
| ^order_ids | []string | Y | ["58747683456"] | The list of TikTok Shop order IDs, retrieved from [Get Order List](650aa8094a0bb702c06df242). |
| ^file_type | string | Y | XML | The invoice file format. |
| Possible values: |  |  |  |  |

* `XML` |
   ^file |string |Y |PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGL |Base64 encoding of the invoice file to upload.
   Max file size: 1MB |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202502/invoice/upload?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"invoices":[{"package_id":"1231231231231","order_ids":["58747683456"],"file_type":"XML","file":"PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGL"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^errors | []object |  | Invoice-level upload errors. This list may be returned even when the top-level `code` is `0`; each entry identifies the affected package and order IDs. |
| ^^code | int | 10007014 | The error code. |
| ^^message | string | The invoice already exists in the upload. Please try again later | The error message. |
| ^^detail | object |  | The details of the error. |
| ^^^package_id | string | 1231231231231 | The package ID where the error occurred. |
| ^^^order_ids | []string | ["58747683456"] | The order IDs where errors occurred. |
### Response Sample
```json
{"code":0,"data":{"errors":[{"code":10007014,"message":"The invoice already exists in the upload. Please try again later","detail":{"package_id":"1231231231231","order_ids":["58747683456"]}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 21001028 | The order is being processed. Try again later. |


---

## Check TikTok Shipping and Collection by TikTok Coverage — `GET /fulfillment/202508/tts_tracking_validation`

Doc: https://partner.tiktokshop.com/docv2/page/check-tiktok-shipping-and-collection-by-tiktok-coverage-202508 · cập nhật 2026-10-10 · scope: seller.logistics

### Path: /fulfillment/202508/tts_tracking_validation
### Method: [GET]
### Function Description
Enables a seller or warehouse to validate whether a tracking number is covered by TikTok Shipping (TTS) or Collection by TikTok (CBT).
Available only in the **US Market**.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| tracking_number | string | Y | 1234567 | The tracking number provided by shipping provider |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202508/tts_tracking_validation?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&tracking_number=1234567
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^is_tiktok_shipping | bool | false | Indicates whether the tracking number is covered by TikTok Shipping (TTS). |
| ^is_tiktok_collection | bool | false | Indicates whether the tracking number is covered by Collection by TikTok (CBT). |
### Response Sample
```json
{"code":0,"data":{"is_tiktok_shipping":false,"is_tiktok_collection":false},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Create First Mile Bundle(V2) — `POST /fulfillment/202510/first_mile_bundle`

Doc: https://partner.tiktokshop.com/docv2/page/create-first-mile-bundle-v2-202510 · cập nhật 2026-10-10 · scope: seller.fulfillment.basic

### Path: /fulfillment/202510/first_mile_bundle
### Method: [POST]
### Function Description
If you send multiple packages to TikTok Shop warehouse in a single first-mile bundle, you can use the API to create a first-mile bundle on TikTok Shop and get the bundle ID.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_ids | []string | Y | ["578967030217083407"] | The IDs of all the orders sent in a single first-mile bundle. Maximum: 9,999 order IDs per request. |
| The orders must follow the restrictions: |  |  |  |  |

* Each of the orders must exist and be RTS and shipping label printed.
* The orders are sent by the same seller.
* The orders belong to a single group of TikTok Shop service districts. The groups are:
   * Group 1: PH, SG, MY, VN, TH, and JP.
   * Group 2: DE, FR, IT, ES.

You can not create first mile bundles for US/UK orders using this API. |
handover_method |string |Y |PICKUP |The way you send the first-mile bundle. Possible enumerations are:

* `PICKUP`: You use the logistic service provided by TikTok Shop to send the bundle.
* `DROP_OFF`: You contact the logistic provider and send the bundle. The logistic provider must be registered at TikTok Shop. |
   shipping_provider_id |string |N |7463353253533 |The logistic provider ID in TikTok Shop. Required when `handover_method == DROP_OFF`. |
   tracking_number |string |N |SF1244442424 |The logistic tracking number of the bundle. Required when `handover_method == DROP_OFF`. |
   phone_tail_number |string |N |1234 |Last 4 digits of the sender's phone number. Required when `handover_method == DROP_OFF`. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202510/first_mile_bundle?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"order_ids":["578967030217083407"],"handover_method":"PICKUP","shipping_provider_id":"7463353253533","tracking_number":"SF1244442424","phone_tail_number":"1234"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^first_mile_bundle_id | string | BA123444534 | The ID of the first-mile bundle. |
| ^url | string | https://open-fs-va.tiktokshop.com/doc_tts/object/28b05?skipCookie=true&timeStamp=1721272360&sign=ef63cd6 | The returned waybill link. |
| ^errors | []object |  | Errors associated with requested orders. An entry can indicate that the requested order could not be resolved, or that a package associated with the order could not be included in the bundle. Multiple errors may be returned, including when the top-level `code` is `0`. |
| ^^code | int | 21008121 | The error code for the order. |
| ^^message | string | invalid order id | The message explaining the error for the order. |
| ^^detail | object |  | Error detail |
| ^^^order_id | string | 578967030217083407 | TikTok Shop order ID |
### Response Sample
```json
{"code":0,"data":{"first_mile_bundle_id":"BA123444534","url":"https://open-fs-va.tiktokshop.com/doc_tts/object/28b05?skipCookie=true\u0026timeStamp=1721272360\u0026sign=ef63cd6","errors":[{"code":21008121,"message":"invalid order id","detail":{"order_id":"578967030217083407"}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Create Packages — `POST /fulfillment/202512/packages`

Doc: https://partner.tiktokshop.com/docv2/page/create-packages-202512 · cập nhật 2026-10-28 · scope: seller.fulfillment.basic, seller.fs.order&fufillment.management

### Path: /fulfillment/202512/packages
### Method: [POST]
### Function Description
Use this API to ship orders (purchase labels). This API is available in the US, UK, EMEA, and JP regions. The shipping fee and delivery time is an estimate only and is based on the package dimensions and weight you provided.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| ship_type | string | Y | 2 | 1:All the products in one order are shipped in one package with one tracking number |
| 2:Partical products in one parent order are shipped in multiple packages with multiple tracking numbers |  |  |  |  |
| 3:All the products in multiple orders are shipped in one package with one tracking number. |  |  |  |  |
| order_id | string | N | 2882335594258860015 | The TikTok Shop order ID. Required when `ship_type` is `1` or `2`; not used when `ship_type` is `3`. |
| warehouse_id | string | N | 7559598297381865271 | Only use for US local-to-local orders. |
| If you need to modify the shipping warehouse, you can edit warehouse ID; The address associated with this ID will be used to generate shipping labels, and it has no impact on inventory. |  |  |  |  |
| Note: We only support warehouse IDs in the enabled status. Passing in repository IDs with other statuses will result in shipment failure. |  |  |  |  |
| order_line_item | []object | N |  | List of order line item IDs. |
| If ship_type=2,This is a required field;If ship_type=1&3,we will not use this field |  |  |  |  |
| ^order_line_id | string | N | 2882335594258860015 | The TikTok Shop order line item ID. |
| ^sub_item_id | string | N | 2882335594258860015 | Only for virtual bundle items,list of sub item ids. |
| If ship_type=2,This is a required field;If ship_type=1&3,we will not use this field |  |  |  |  |
| order_list_ids | []string | N | ["2882335594258860015","2882335594258860016"] | The TikTok Shop order IDs to combine into one package. Required when `ship_type` is `3`; provide at least two order IDs. |
| dimension | object | N |  | Package dimensions. For `ship_type` `1` and `2`, each dimension must be between 0.01 and 999999 and have no more than two decimal places. |
| ^length | string | Y | 1.2 | Package length. |
The length, width, and height must be passed together. |
^width |string |Y |0.2 |Package width.
The length, width, and height must be passed together. |
^height |string |Y |0.03 |Package height.
The length, width, and height must be passed together. |
^unit |string |Y |CM |The unit of measurement for the package dimensions. For packages in the US, use `INCH`.
Available values:

* `CM`
* `INCH` |
   shipping_service_id |string |N |288233559123860015 |Specify the shipping service used.
   If not specified, use the default service obtained from [Get Eligible Shipping Service](https://partner.tiktokshop.com/docv2/page/650aa6b2bace3e02b75dda4e). |
   weight |object |N | |Package weight. For `ship_type` `1` and `2`, the value must be between 0.01 and 999999 and have no more than two decimal places. |
   ^value |string |Y |1.2 |The numerical value of the package weight. |
   ^unit |string |Y |GRAM |The unit of measurement for the package weight.

Available values:

* `GRAM`
* `POUND` |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202512/packages?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"ship_type":"2","order_id":"2882335594258860015","warehouse_id":"7559598297381865271","order_line_item":[{"order_line_id":"2882335594258860015","sub_item_id":"2882335594258860015"}],"order_list_ids":["2882335594258860015","2882335594258860016"],"dimension":{"length":"1.2","width":"0.2","height":"0.03","unit":"CM"},"shipping_service_id":"288233559123860015","weight":{"value":"1.2","unit":"GRAM"}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^dimension | object |  | Package dimensions. |
| ^^length | string | 1.2 | Package length. |
| ^^width | string | 0.2 | Package width. |
| ^^height | string | 0.03 | Package height. |
| ^^unit | string | CM | The unit of measurement for the package dimensions. |
Available values:

* `CM`
* `INCH` |
   ^shipping_service_info |object | |Information about the shipping service selected for the package. |
   ^^id |string |288233559123860015 |Shipping service ID. |
   ^^name |string |UPS-first class |Shipping service name. |
   ^^price |string |10 |Estimated price for this service. |
   ^^currency |string |USD |Currency of the price. |
   ^^earliest_delivery_days |int |3 |The minimum estimated duration required for package delivery.US only. |
   ^^latest_delivery_days |int |5 |The maximum estimated duration required for package delivery.US only. |
   ^^shipping_provider_id |string |2882322591238 |Shipping provider ID.US only. |
   ^^shipping_provider_name |string |UPS |Shipping provider name.US only. |
   ^package_id |string |2882335594258860015 |Package ID. |
   ^weight |object | |Package weight. |
   ^^value |string |1.2 |The numerical value of the package weight. |
   ^^unit |string |GRAM |The unit of measurement for the package weight.

Available values:

* `GRAM`
* `POUND` |
   ^create_time |int |1623812664 |The time when the product was created.
   Unix timestamp. |

### Response Sample
```json
{"code":0,"data":{"dimension":{"length":"1.2","width":"0.2","height":"0.03","unit":"CM"},"shipping_service_info":{"id":"288233559123860015","name":"UPS-first class","price":"10","currency":"USD","earliest_delivery_days":3,"latest_delivery_days":5,"shipping_provider_id":"2882322591238","shipping_provider_name":"UPS"},"package_id":"2882335594258860015","weight":{"value":"1.2","unit":"GRAM"},"create_time":1623812664},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 11001002 | invalid param. |
| 11001027 | System timeout. If this error persists, please contact the platform for assistance. |
| 11003011 | Shipping service operation conflict error, please double check the shipping service ID. |
| 11021009 | No available shipping services for this request. Please modify the package weight or check the recipient address. If the error persists, please contact the platform for assistance. |
| 11021012 | illegal address |
| 11021014 | product oversize |
| 11028006 | This tracking number cannot be matched to any carrier, please check the tracking number and upload again. |
| 11050001 | invalid param |
| 21001001 | Invalid parameters. Please ensure you are passing the correct request parameter(s). |
| 21001011 | System process error, please try again later. |
| 21004008 | create label shipping service not found |
| 21004010 | Your country does not support the use of this feature. |
| 21008025 | Seller cannot operate orders which are fulfilled by platform |
| 21008042 | seller already print shipping label |
| 21008106 | This interface cannot be used in this region. |
| 21011001 | Package not found. If the error persists, please contact the platform for assistance. |
| 21011003 | fulfill_unit action not allowed |
| 21011006 | These orders are already shipped. |
| 21011007 | Package item has after-sale request, please process the after-sale request first. |
| 21011012 | not match trade rule |
| 21011020 | These orders are already shipped. |
| 21011029 | order does not belong to fulfill unit |
| 21011033 | order already combined |
| 21011035 | split order not allowed |
| 21011037 | There are no available shipping services for this request. Please modify the package weight, or double check the recipient address. If after multiple retries you continue to experience this error, please contact the platform for assistance. |
| 21011046 | Order has combine, not allow split order |
| 21011048 | There are multiple packages that can be shipped, please specify the order line that needs to be shipped. |
| 21022025 | A shipping label has already been purchased. |
| 21022026 | Cannot purchase shipping label, please try again later. |
| 21022029 | System process error, please try again later. |
| 21030005 | Processing create_label_status not allow to operate this action |
| 21030006 | Shipping label purchase successful. This operation is not allowed in the current order status. |
| 21032001 | fulfill unit status not allow to update pkg attr |


---

## Submit Redemption Information — `POST /fulfillment/202601/redeem_info/callback`

Doc: https://partner.tiktokshop.com/docv2/page/submit-redemption-information-202601 · cập nhật 2026-10-10 · scope: seller.redeem_info.write

### Path: /fulfillment/202601/redeem_info/callback
### Method: [POST]
### Function Description
Submit redemption information for one or more line items in a TikTok Shop order so TikTok Shop can fulfill those items.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_id | string | Y | 576461413038785752 | TikTok Shop order ID. |
| order_info_list | []object | Y |  | Order line items for which to submit redemption information. Include at least one item. Each `order_line_id` must belong to the order specified by `order_id` and must appear only once in the list. |
| ^order_line_id | string | Y | 577086512123755123 | The unique identifier of the order line item. |
| ^redeem_info | object | Y |  | The redemption information generated by your system for this order line item. |
| ^^redeem_type | string | Y | CODE | What redeem type that you callback. |
| 'CODE' - type code |  |  |  |  |
| 'URL' - type url |  |  |  |  |
| 'CODE_PIN' - type pin and code |  |  |  |  |
| ^^redeem_data | string | N | abc12344 | Set the redeem data to this field with the maximum number of characters 1200. The example of each type is shown below, |
| CODE: abc12344 |  |  |  |  |
| URL: https://{your_domain}/abc |  |  |  |  |
| CODE_PIN(json format): |  |  |  |  |
| {"type": "CODE_PIN","code": "12345","pin": "abc"} |  |  |  |  |
| ^^redeem_instruction_info | string | N | {"instruction_url": "https://example.com/redeem"} | Additional redemption instruction in JSON format. Use instruction_url to specify a third-party website where the buyer completes redemption. This URL is included as a clickable link in the fulfillment email. |
| Example: {"instruction_url": "https://example.com/redeem"} |  |  |  |  |
| ^source_unique_id | string | N | 134448484339393 | Optional, a unique id related to the order line in the caller system |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202601/redeem_info/callback?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"order_id":"576461413038785752","order_info_list":[{"order_line_id":"577086512123755123","redeem_info":{"redeem_type":"CODE","redeem_data":"abc12344","redeem_instruction_info":"{\"instruction_url\": \"https://example.com/redeem\"}"},"source_unique_id":"134448484339393"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^order_statuses | []object |  | Callback result.For partial failure usage, if some of order line id in the request fail, it will be recorded with a none zero status_code. |
| ^^order_line_id | string | 577086512123755123 | Line order id, same as the input line order id. |
| ^^status_code | int | 0 | Callback status of this line order id. A none zero code represent a failure callback. |
### Response Sample
```json
{"code":0,"data":{"order_statuses":[{"order_line_id":"577086512123755123","status_code":0}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 10006402 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 164004001 | permission denied, please check if you have the permission to operate the orders. |
| 164004006 | req is invalid, please check your request params |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 164004008 | no orders available for fulfillment |
| 185001003 | no orders need to call back |
| 185002001 | req is invalid, please check your request params |
| 185005001 | permission denied, please check if you have the permission to operate the orders. |
| 185005002 | current order status not support call back |


---

## Get POD Customization Details — `POST /fulfillment/202606/pod_details/get`

Doc: https://partner.tiktokshop.com/docv2/page/get-pod-customization-details-202606 · cập nhật 2026-10-10 · scope: seller.redeem_info.write

### Path: /fulfillment/202606/pod_details/get
### Method: [POST]
### Function Description
Retrieves the POD customization details for specified order lines in a TikTok Shop order.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| main_order_id | string | Y | 576461413038785752 | TikTok Shop order ID. |
| query_order_lines | []object | Y |  | A non-empty list of order lines for which to retrieve POD customization details. |
| ^order_line_id | string | Y | 577086512123755123 | The unique identifier of the order line item. |
| ^product_id | string | Y | 1732453831920750867 | The unique identifier of the product. |
| ^sku_id | string | Y | 1732453830297817363 | The unique identifier of the sku. |
| ^pod_order_data_id | string | Y | 123456 | The unique identifier of the pod data. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202606/pod_details/get?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"main_order_id":"576461413038785752","query_order_lines":[{"order_line_id":"577086512123755123","product_id":"1732453831920750867","sku_id":"1732453830297817363","pod_order_data_id":"123456"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^pod_details | []object |  | The POD customization details returned for the requested order lines. |
| ^^pod_info_json | string | {"pod_template_id":123456} | A JSON-encoded string containing the POD customization template for the order line. |
| ^^order_line_id | string | 577457287176491132 | The unique identifier of the order line item. |
| ^status_code | int | 0 | response status |
### Response Sample
```json
{"code":0,"data":{"pod_details":[{"pod_info_json":"{\"pod_template_id\":123456}","order_line_id":"577457287176491132"}],"status_code":0},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get Order Customs Requirements — `POST /fulfillment/202607/orders/customs_info/query`

Doc: https://partner.tiktokshop.com/docv2/page/get-order-customs-requirements-202607 · cập nhật 2026-10-10 · scope: seller.fulfillment.basic

### Path: /fulfillment/202607/orders/customs_info/query
### Method: [POST]
### Function Description
This API is used to query whether an order requires extra customs clearance information, whether such information has been submitted, and the list of submitted customs clearance information.
If extra customs clearance information is required but not yet provided, the merchant must complete and submit it before shipment can proceed.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_ids | []string | Y | ["584882846571464153","584881010662934016"] | TikTok Shop order IDs to query. When providing a request body, include 1 to 50 order IDs. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202607/orders/customs_info/query?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

**Body**
```json
{"order_ids":["584882846571464153","584881010662934016"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^order_clearance_list | []object |  | clearance info of this order |
| ^^order_id | string | 584882846571463232 | TikTok Shop order ID |
| ^^need_fill_clearance | bool | true | Whether an order needs to fill customs infomation: |

* true: The order needs to fill in customs information.
* false: The order does not need to fill in custom information. |
   ^^already_filled_clearance |bool |false |When `need_fill_clearance` is `true`, whether customs clearance information has been submitted for every order line that requires it. This value is `false` when `need_fill_clearance` is `false`. |
   ^^target_country |string |JP |Country Alpha-2 Code |
   ^^biz_type |int |1 |enum CustomsBusinessType {
   CustomsBusinessTypeFS = 1;
   CustomsBusinessTypePOP = 2;
   } |
   ^^shipment_type |int |1 |enum ShipmentType{
   CROSS_BORDER = 1,
   LOCAL = 2,
   } |
   ^^item_list |[]object | |Order-line details for the order. |
   ^^^order_line_id |string |584882846571423334 |Sub order ID |
   ^^^product_id |string |1729476373250999503 |Product ID. |
   ^^^sku_id |string |1735885807280883357 |SKU ID. |
   ^^^is_virtual_unboxing |bool |true |Whether this sub order is virtual_unboxing |
   ^^^is_temporary_listing |bool |false |Whether this sub order is temporary_listing |
   ^^^related_item_detail |[]object | |Submitted customs clearance item details for this order line, aggregated by SKU. |
   ^^^^product_id |string |1729476373250999503 |Product ID. |
   ^^^^sku_id |string |1735885807280883357 |SKU ID. |
   ^^^^qty |int |2 |The amount of this sku |
   ^^^^price_percent |int |10 |unit: %, price_percent=10 means 10% |

### Response Sample
```json
{"code":0,"data":{"order_clearance_list":[{"order_id":"584882846571463232","need_fill_clearance":true,"already_filled_clearance":false,"target_country":"JP","biz_type":1,"shipment_type":1,"item_list":[{"order_line_id":"584882846571423334","product_id":"1729476373250999503","sku_id":"1735885807280883357","is_virtual_unboxing":true,"is_temporary_listing":false,"related_item_detail":[{"product_id":"1729476373250999503","sku_id":"1735885807280883357","qty":2,"price_percent":10}]}]}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 11001002 | invalid param. |
| 11036004 | system error, please retry |


---

## Submit Customs Clearance Information — `POST /fulfillment/202607/orders/customs_info/submit`

Doc: https://partner.tiktokshop.com/docv2/page/submit-customs-clearance-information-202607 · cập nhật 2026-10-10 · scope: seller.fulfillment.basic

### Path: /fulfillment/202607/orders/customs_info/submit
### Method: [POST]
### Function Description
This API is used to submit extra customs clearance information for discrepancies between declared information and physical goods.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_list | []object | N |  | List of orders for which to submit customs clearance information. Maximum: 100 orders per request. |
| ^order_id | string | Y | 584882846571463232 | TikTok Shop order ID |
| ^item_list | []object | N |  | List of customs clearance entries for order lines. Within the same order, explicit order_line_id values must be unique. |
| ^^order_line_id | string | N | 584882846571423334 | Sub order ID; order_line_id and sku_id should not be both empty. |
| ^^sku_id | string | N | 1735885807280883357 | SKU ID; order_line_id and sku_id should not be both empty. |
| ^^item_detail | []object | N |  | List of SKU-level customs clearance details for the order line. |
| ^^^sku_id | string | Y | 1735885807280883357 | The SKU ID for this customs clearance detail. |
| ^^^qty | int | Y | 2 | Quantity of this SKU in the customs clearance detail. Must be greater than 0. |
| ^^^price_percent | int | Y | 10 | Percentage assigned to this SKU within the order line. Each value must be non-negative, and the price_percent values in item_detail must total 100. For example, 10 means 10%. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202607/orders/customs_info/submit?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

**Body**
```json
{"order_list":[{"order_id":"584882846571463232","item_list":[{"order_line_id":"584882846571423334","sku_id":"1735885807280883357","item_detail":[{"sku_id":"1735885807280883357","qty":2,"price_percent":10}]}]}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
### Response Sample
```json
{"code":0,"data":{},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 11001002 | invalid param. |
| 11036004 | system error, please retry |


---

## Tracking status update — `POST /fulfillment/202609/order/sof/track/update`

Doc: https://partner.tiktokshop.com/docv2/page/tracking-status-update-202609 · cập nhật 2026-09-17 · scope: seller.fulfillment.basic

### Path: /fulfillment/202609/order/sof/track/update
### Method: [POST]
### Function Description
**This API is currently exclusive to the following markets: US, BR.**
This API is suitable for merchants to deliver and carry orders by themselves, without shipping orders through third-party service providers, that is, without shipping packages through 3PL, but orders sent by merchants. Merchants are allowed to use this API to return such orders and update the order track. The Action Code and Failed Reason in the input parameter are enumerated, as detailed in the document: https://partner.tiktokshop.com/docv2/page/1cjht3qx

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| country | string | Y | BR | Order Country. |
| order_id | string | Y | 577071607420326620 | TikTok Shop order ID. |
| external_tracking_url | string | N | https://www.correios.com.br/rastreamento/BR3PL202609090001 | Service provider's track URL / official website link. |
| tracks | []object | Y |  | Trajectory node array; maximum number of entries per single request [50], processing results are returned one by one within the array. That is, in the interface, a maximum of 50 tracks can be postbacked per order at a time. |
| ^action_code | int | Y | 20201 | The standard trajectory node code must belong to the allowlist. See the below action code. The action code is limited, for the list of available enumerations, please refer to the documentation: https://partner.tiktokshop.com/docv2/page/1cjht3qx |
| ^occur_time | int | Y | 1788920100000 | Actual Trajectory Occurrence Time. Unix timestamp GMT (UTC+00:00). The unit is milliseconds. |
| ^description | string | Y | Package picked up by 3PL carrier | The original trajectory description of the caller. |
| ^failed_reason | string | N | R110 | Exception causes, details are listed below. See the below reason code. The reason code is limited, for the list of available enumerations, please refer to the documentation: https://partner.tiktokshop.com/docv2/page/1cjht3qx |
| ^proof_url | string | N | https://carrier-proof.example.com/proof/BR3PL202609090001 | Third-party tracking proof links or credentials. |
| ^location | object | N |  | Location fields such as city, state, province, country, latitude and longitude; |
| ^^country | string | N | BR | country. |
| ^^state | string | N | SP | state. |
| ^^city | string | N | Campinas | city. |
| ^^zip_code | string | N | 13010-000 | zip code/post code. |
| ^tracking_no | string | Y | BR443310090002 | The waybill number used when placing an order. If there is no tracking code, fill in the invoice id instead. And it may change in split shipment, it may change in different track in this scene. |
| provider_id | string | Y | 7189579428429563650 | The logistics provider ID, which is the one filled in when placing an order or uploading a tracking number, must be consistent with it. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202609/order/sof/track/update?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"country":"BR","order_id":"577071607420326620","external_tracking_url":"https://www.correios.com.br/rastreamento/BR3PL202609090001","tracks":[{"action_code":20201,"occur_time":1788920100000,"description":"Package picked up by 3PL carrier","failed_reason":"R110","proof_url":"https://carrier-proof.example.com/proof/BR3PL202609090001","location":{"country":"BR","state":"SP","city":"Campinas","zip_code":"13010-000"},"tracking_no":"BR443310090002"}],"provider_id":"7189579428429563650"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^track_results | []object |  | The trajectory node array, where the field in each element of the array indicates which trajectory it is. The `code` and `message` fields describe whether the trajectory has been received; if not, they represent the corresponding error code and error description. |
| ^^action_code | int | 32401 | The standard trajectory node code must belong to the allowlist. See the below action code. |
| ^^occur_time | int | 1788920100012 | Actual Trajectory Occurrence Time. Unix timestamp GMT (UTC+00:00). The unit is milliseconds. |
| ^^description | string | Line-haul transport departed | The original trajectory description of the caller. |
| ^^code | int | 0 | The success or failure status of the trace corresponding to this action code, see the below error code |
| ^^message | string | Success | The success or failure messages returned in the trace corresponding to this action code. Reasons of failure will be described in the message. |
| ^^tracking_no | string | BR123456789 | The waybill number used when placing an order. If there is no tracking code, fill in the invoice id instead. And it may change in split shipment, it may change in different track in this scene. |
### Response Sample
```json
{"code":0,"data":{"track_results":[{"action_code":32401,"occur_time":1788920100012,"description":"Line-haul transport departed","code":0,"message":"Success","tracking_no":"BR123456789"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 11007010 | System is busy, please try again later. |
| 11007016 | The merchant is not in the merchant allowlist. |
| 11007017 | The action_code is not in the allowlist table. |
| 11007018 | The order cannot be located using the provided TrackingNO and OrderId. |
| 11007019 | The merchant in the request does not match the actual merchant of the order. |
| 11007020 | Invalid trajectory. Please check the parameters in tracks. |
| 11007021 | Invalid provider id. Please check whether the postback provider id you submitted is a provider id allowed under the merchant self-shipping and self-delivery method. |


---

## Update Package Shipping Info — `POST /fulfillment/202610/packages/{package_id}/shipping_info/update`

Doc: https://partner.tiktokshop.com/docv2/page/update-package-shipping-info-202610 · cập nhật 2026-10-28 · scope: seller.fulfillment.basic, seller.fs.order&fufillment.management

### Path: /fulfillment/202610/packages/{package_id}/shipping_info/update
### Method: [POST]
### Function Description
If the seller entered an incorrect tracking number, this API allows the seller to update the tracking number and shipping provider for a package that has already been shipped. Attention: This API is only applicable to orders (or packages) shipped by the seller. It is only used to update the tracking number and shipping provider for packages that have already been shipped.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| package_id | string | Y | 5433567853345 | TikTok Shop package ID. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| shipping_info_list | []object | Y |  | "Only supports uploading multiple tracking numbers for split-shipment in 3PL single item scenarios (non-virtual bundle) (This function is only support for whitelist sellers； If you are not on the allowlist, it is recommended to contact AM to apply) |
| For other scenarios, only one tracking number can be uploaded at a time." |  |  |  |  |
| ^tracking_number | string | N | 6617675021119438849 | Tracking number. |
| ^shipping_provider_id | string | N | 12312312321323432 | Use Get Shipping Provider API to retrieve the shipping_provider_id for shipping providers. |
| ^note | string | N | this is a table | "Only available for a part of white list merchants.This applies to scenarios where a large single item needs to be shipped in multiple packages.Merchants not on the whitelist who upload this field will have it automatically ignored by the platform. |
| For example, where Package 1 is marked with ""headboard"" and Package 2 is marked with ""bed frame"". |  |  |  |  |
| This field will be displayed to buyers, so please fill it in carefully." |  |  |  |  |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202610/packages/5433567853345/shipping_info/update?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"shipping_info_list":[{"tracking_number":"6617675021119438849","shipping_provider_id":"12312312321323432","note":"this is a table"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
### Response Sample
```json
{"code":0,"data":{},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 10007002 | Current order is not a merchant blind box order. |
| 21001028 | The order is being processed. Try again later. |
| 21011001 | Package not found. If the error persists, please contact the platform for assistance. |
| 21011004 | This API cannot be used to update package shipping information for packages that are not shipped by sellers. |
| 21011007 | Package item has after-sale request, please process the after-sale request first. |
| 21011022 | Invalid tracking number or provider ID. Please double check and try again. |
| 21011028 | The package does not belong to the current shop. Please ensure you are providing the correct package ID and/or shop cipher. |
| 21011030 | fulfillment not allow update tracking no |
| 21011042 | Cannot complete the operation when order is cancelled. |
| 21011043 | The package has not been shipped yet. |
| 21011049 | Due to platform rule limitations, you are unable to update the tracking number. |
| 21011050 | The tracking number can only be updated within a certain number of hours. |
| 21011051 | The tracking number can only be updated once. |
| 21011052 | The tracking number can only be updated a limited number of times. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 25001010 | A return request has already been completed, or the order has already been cancelled. |


---

## Mark Package As Shipped — `POST /fulfillment/202610/orders/{order_id}/packages`

Doc: https://partner.tiktokshop.com/docv2/page/mark-package-as-shipped-202610 · cập nhật 2026-10-28 · scope: seller.fulfillment.basic, seller.fs.order&fufillment.management

### Path: /fulfillment/202610/orders/{order_id}/packages
### Method: [POST]
### Function Description
**This API is currently exclusive to the following markets: US, UK, ES, IE, IT, DE, FR, JP.**
This API is for sellers who fulfill orders through their own selected/preferred logistics carrier, and allows sellers to upload valid package information (items in packages, shipping provider information, and tracking number) orders/order line items to TikTok Shop. Use [Get Shipping Providers API](https://partner.tiktokshop.com/docv2/page/650aa48d4a0bb702c06d85cd?external_id=650aa48d4a0bb702c06d85cd) to retrieve the `shipping_provider_id` for shipping providers.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_id | string | Y | 576461413038785752 | The unique identifier for a TikTok Shop order. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_line_list | []object | N |  | This new parameter is completely backward compatible with the previous oder_line_items_ids field and in addition this supports bundle order splitting, use the sub items accordingly |
| ^order_line_id | string | N | 5767675021119438849 | The corresponding order line ID. |
| ^sub_item_id | string | N | 5767675021119438849 | The sub-order-line ID inside a bundle product. |

* Required for bundle products.
* Not required for non-bundle products. |
   shipping_info_list |[]object |N | |"Only supports uploading multiple tracking numbers for split-shipment in 3PL single item scenarios (non-virtual bundle) (This function is only support for whitelist sellers； If you are not on the allowlist, it is recommended to contact AM to apply)
   For other scenarios, only one tracking number can be uploaded at a time." |
   ^tracking_number |string |N |6617675021119438849 |Tracking number. |
   ^shipping_provider_id |string |N |12312312321323432 |Use Get Shipping Provider API to retrieve the shipping_provider_id for shipping providers. |
   ^note |string |N |this is a table |"Only available for a part of white list merchants.This applies to scenarios where a large single item needs to be shipped in multiple packages.Merchants not on the whitelist who upload this field will have it automatically ignored by the platform.
   For example, where Package 1 is marked with ""headboard"" and Package 2 is marked with ""bed frame"".
   This field will be displayed to buyers, so please fill it in carefully." |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fulfillment/202610/orders/576461413038785752/packages?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"order_line_list":[{"order_line_id":"5767675021119438849","sub_item_id":"5767675021119438849"}],"shipping_info_list":[{"tracking_number":"6617675021119438849","shipping_provider_id":"12312312321323432","note":"this is a table"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^order_id | string | 32131324123321 | TikTok Shop order ID. |
| ^order_line_item_ids | []string | ["31322412312312"] | List of order line item IDs. |
| ^package_id | string | 32141235124234 | Package ID. |
| ^warning | object |  | Warning message. |
| ^^message | string | match more than one provider | Specific warning information. |
### Response Sample
```json
{"code":0,"data":{"order_id":"32131324123321","order_line_item_ids":["31322412312312"],"package_id":"32141235124234","warning":{"message":"match more than one provider"}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 11001027 | System timeout. If this error persists, please contact the platform for assistance. |
| 11001031 | System process error, please try again later. |
| 11005004 | warehouse not exist |
| 11005010 | get lead time from card service error |
| 11006005 | System process error, please try again later. |
| 11006026 | System process error, please try again later. |
| 11021009 | No available shipping services for this request. Please modify the package weight or check the recipient address. If the error persists, please contact the platform for assistance. |
| 11028006 | This tracking number cannot be matched to any carrier, please check the tracking number and upload again. |
| 11050001 | invalid param |
| 21001001 | Invalid parameters. Please ensure you are passing the correct request parameter(s). |
| 21001008 | not found error |
| 21001011 | System process error, please try again later. |
| 21001028 | The order is being processed. Try again later. |
| 21001029 | rpc logistics_logistics_service_4b failed |
| 21001043 | System process error, please try again later. |
| 21001055 | System process error, please try again later. |
| 21004012 | Tracking number has special characters, verify failed. |
| 21004015 | Tracking number mismatch provider. |
| 21004016 | Tracking number verify, not avalible logsitics service or provider |
| 21004019 | Need invoice uploaded for all order before rts. |
| 21004020 | Fulfillment Invoice status is not success, can not rts pkg. |
| 21008025 | Seller cannot operate orders which are fulfilled by platform |
| 21008042 | seller already print shipping label |
| 21008044 | SellerFulfillUnitInReverseCannotOperate |
| 21008099 | Package has been shipped. Please not ship the package again. |
| 21008106 | This interface cannot be used in this region. |
| 21008300 | System process error, please try again later. |
| 21011001 | Package not found. If the error persists, please contact the platform for assistance. |
| 21011003 | fulfill_unit action not allowed |
| 21011004 | This API cannot be used to update package shipping information for packages that are not shipped by sellers. |
| 21011006 | These orders are already shipped. |
| 21011007 | Package item has after-sale request, please process the after-sale request first. |
| 21011012 | not match trade rule |
| 21011013 | not match logistics rule |
| 21011020 | These orders are already shipped. |
| 21011022 | Invalid tracking number or provider ID. Please double check and try again. |
| 21011025 | Duplicate tracking number. |
| 21011026 | fulfillment tracking no used times over limit |
| 21011029 | order does not belong to fulfill unit |
| 21011030 | fulfillment not allow update tracking no |
| 21011033 | order already combined |
| 21011036 | split same sku in Multi Package not allow. |
| 21011046 | Order has combine, not allow split order |
| 21011048 | There are multiple packages that can be shipped, please specify the order line that needs to be shipped. |
| 21011050 | The tracking number can only be updated within a certain number of hours. |
| 21011051 | The tracking number can only be updated once. |
| 21021010 | Failed to ship. You may cancel the order without penalty by selecting the following reason: Unable to deliver to buyer address. |
| 21022025 | A shipping label has already been purchased. |
| 21022026 | Cannot purchase shipping label, please try again later. |
| 21022028 | split pkg fail. |
| 21022029 | System process error, please try again later. |
| 21022030 | System process error, please try again later. |
| 21032001 | fulfill unit status not allow to update pkg attr |
| 21034006 | decision route occurs error |
| 21034012 | tracking no has been used |
| 21042056 | These orders are already shipped. |
| 21042057 | These orders are not in the Awaiting shipment status. Couldn't create labels for them. |

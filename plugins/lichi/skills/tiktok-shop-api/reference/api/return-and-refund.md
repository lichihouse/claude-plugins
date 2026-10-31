# Return and refund — tài liệu chi tiết

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.




---

## Return, refund, and cancel API overview

Doc: https://partner.tiktokshop.com/docv2/page/return-refund-and-cancel-api-overview · cập nhật 2026-07-08

### Context
Cancel/Return/Refund, also referred to as 'post-transaction' or 'after-sales' can be initiated by a buyer or directly processed by a seller. TikTok Shop provides two APIs for sellers process these after-sales situations. The cancel API allows sellers to process a buyer order cancellation request as well as a direct seller order cancellation. The return API allows sellers to process a buyer order refund/ return & refund request. For situations where TikTok Shop cancels/ refunds an order, please refer to TikTok Shop Seller Academy for details.

Cancel order: Order cancellations can be initiated by a buyer after the buyer remorse window or directly canceled by the seller. For each canceled order, there is a buyer/seller cancel reason, cancel status, cancel order creation time, and the seller's process time for the buyer cancellation request. In the US and UK markets, TikTok Shop allows sellers to process partial order cancellations on item out of stock scenario.

Return order: Return orders refers to when a buyer requests to return or refund one or more items from an order. Returns can be initiated by a buyer after they have received the items. Return orders contain the buyer/seller return or refund reason, return/refund status, return or refund request time, the seller's process time for the buyer return/refund request, and the refund amount.

There are 2 ways to implement Search Cancel API and Search Return API:

* Subscribe to the [Cancellation Status Change](https://partner.tiktokshop.com/docv2/page/65030150746462028285f657) and [Return Status Change](https://partner.tiktokshop.com/docv2/page/65030162bb2a4d028d50cc51) webhooks: you must subscribe to reverse order Webhook. For more details, [click here](https://partner.tiktokshop.com/docv2/page/650512b42f024f02be19755f#Back%20To%20Top). Poll Order List periodically
* Poll Cancel order/Return order periodically

### Important Concepts
**The following table illustrates when "Cancellation," "Return," and "Refund" can be used based on the order status.**
|  | **Initiator** | **UNPAID** | **ON_HOLD** | **AWAITING_SHIPMENT** | **AWAITING_COLLECTION** | **IN_TRANSIT** | **DELIVERED** | **COMPLETED** |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **Cancel** | Buyer | Y | Y(Cancel request auto approve by platform. Only available in the UK) | Y   | N   | N | N | N |
|  | Seller | N | Y | Depends on market policy. Please see details in appendix Seller Academy link | Y   | N | N | N |
| **Refund** | Buyer | N | N | N | Y | Depends on market policy. Please see details in Seller Academy in appendix | Y | N |
|  | Seller | N | N | N | Y |  | Depends on market policy. Please see details in appendix Seller Academy link | N |
| **Return** | Buyer | N | N | N | N |  | Y | N |
|  | Seller | N | N | N | N |  | Depends on market policy. Please see details in appendix Seller Academy link | N |

#### Cancel/Return/Refund initiator explanation

* BUYER: The buyer that placed the order.
* SELLER: TikTok Shop seller.
* SYSTEM: Orders may be cancelled by the TikTok Shop system automatically based on TikTok Shop's policies. For example, this can happen if a package is lost in transit, and TikTok Shop detects that the tracking number has not changed for over 7 days.
* OPERATOR: Orders may also be cancelled by TikTok Shop's customer service for a variety of reasons. 

#### Cancel
**Order Cancellations:** This API allows sellers to cancel paid orders as well as manage order cancellation requests. Please note, only orders that have not yet been shipped can be canceled.

Note: Buyers cannot cancel individual line items within multiple line item orders. Currently, only US and UK sellers are allowed to do partial cancel on item out of stock scenario.

**Cancel Types:** On the TikTok Shop platform, there are two types of order cancellations on TikTok Shop: buyer initiated cancellation, i.e. BUYER_CANCEL and direct cancellation, i.e. CANCEL. Seller/System/Operator can direct cancel an order. BUYER_CANCEL requires the seller to review the cancellation request. If an order's status is 'ON_HOLD', and a buyer initiates a cancellation, TikTok Shop will accept the cancellation request on behalf of the seller automatically. The seller does not need to review the cancellation request. In this case, this order will have a 'CANCEL' cancellation type.

**Cancellation Reasons:** Please refer to [our list of cancel reasons](https://partner.tiktokshop.com/docv2/page/67e61eee427345048595487d#Back%20To%20Top).

**Cancellation Order Status：**
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/c040e21e9b904bd793949d13349afaba~tplv-k9wyc2ijk0-image.image)

**Business Case:**

* Buyer initiates a cancellation request

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/75e61ed442ab415e9c1319db3b163d4c~tplv-k9wyc2ijk0-image.image)

> **Note**: If the buyer cancellation request is made **before** the 2-business day Standard Shipping SLA from the order date, the seller must act within 24 hours. If no action is taken, TikTok Shop will auto-approve the cancellation and issue a refund. Sellers must resolve the request by either:

>    * Uploading the tracking number to the cancellation request
>    * Approving the cancellation

> Shipping the item or taking no other action will result in the cancellation being approved.
> 
> **Note**: If the cancellation request is made **after** the 2-business-day Standard Shipping SLA from the order date, but before the order is marked as **"In transit"**, TikTok Shop will automatically approve the cancellation and issue a refund.

>    * For more information on SLAs, refer to the [Fulfillment Policy](https://seller-us.tiktok.com/university/essay?identity=1&role=1&knowledge_id=3995852763301633&from=policy).

* Seller initiates a cancellation

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/78c244b9a1c846e0b21c43c1281ef58f~tplv-k9wyc2ijk0-image.image)

#### Refund
**Refund:** Buyers/Seller are able to initiate a refund for a line item. This API allows sellers to process buyer refund requests and issue either partial or full refunds.

Note: Currently, different markets have different refund policies. Please refer to Seller Academy for more details.

**Refund Reasons:** Please refer to [our list of refund reasons](https://partner.tiktokshop.com/docv2/page/67e61e7b8ceb0d04a320061e). 

**Refund Order Status：**
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/190ddcc2cc9a4a959d482a4a66b750bf~tplv-k9wyc2ijk0-image.image)

Refund Order Status Explanation
| **Status** | **Description** |
| --- | --- |
| RETURN_OR_REFUND_REQUEST_PENDING | Buyer initiates a refund request, needs to be approved by seller or platform. |
| REQUEST_SUCCESS | The refund request is successful, the buyer will be refunded. |
| REQUEST_REJECTED | The seller rejected the refund request. |
| RETURN_OR_REFUND_CANCEL | The refund request has been cancelled by buyer or system. |
| RETURN_OR_REFUND_REQUEST_COMPLETE | The refund request is successful, and the amount has been refunded. |

Flow 1:  status from RETURN_OR_REFUND_REQUEST_PENDING to REQUEST_SUCCESS, then from REQUEST_SUCCESS to RETURN_OR_REFUND_REQUEST_COMPLETE
Trigger: refund request has been approved, and then the refund amount has been refunded.
Trigger initiator: Seller/System

Flow 2: status from RETURN_OR_REFUND_REQUEST_PENDING to REQUEST_REJECTED
Trigger: refund request has been rejected.
Trigger initiator: Seller

Flow 3: status from RETURN_OR_REFUND_REQUEST_PENDING to RETURN_OR_REFUND_CANCEL
Trigger: buyer cancels the refund request.
Trigger initiator: Buyer.

**Business Case:**

* Buyer initiates a refund request

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/e9669f5de4e3454e9992dd61f36362c9~tplv-k9wyc2ijk0-image.image)

* Seller initiates a refund

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/76f5c2d1f56241598968628c4c4270e7~tplv-k9wyc2ijk0-image.image)

#### Return
**Return:** Buyers are able to initiate a return and get a refund for a returned order line item. This API allows sellers to accept return requests from buyers as well as initiate returns on behalf of buyers.

**Return Reasons:** [Click here for a list of our return reasons](https://partner.tiktokshop.com/docv2/page/67e61d87fcf2dd04c982ef1d). 

**Return-less Refunds:** TikTok Shop allows the sellers to change a buyer's return request and issue a refund directly. When sellers accept returns via the Approve Return API, they can choose to allow the buyer to keep the items and complete the return as a return-less refund. When seller accepts return via Approve Return API, can choose buyer keep item option to achieve returnless refund.

**Return Order Status**

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/1dfbcb33322f47f48074d94b733e0402~tplv-k9wyc2ijk0-image.image)

Return Order Status Explanation
| **Status** | **Description** |
| --- | --- |
| RETURN_OR_REFUND_REQUEST_PENDING | Buyer initiates a return request, pending seller review. |
| AWAITING_BUYER_SHIP | The return request has been approved and is waiting for the buyer to ship the item. If the buyer misses the return deadline, the request moves to RETURN_OR_REFUND_CANCEL. |
| BUYER_SHIPPED_ITEM | The buyer has shipped the item or uploaded tracking information. |
| REQUEST_REJECTED | The seller rejected the return request. |
| RECEIVE_REJECTED | The seller rejected the buyer's return package. |
| REQUEST_SUCCESS | The return request is successful, the buyer will be refunded. |
| RETURN_OR_REFUND_REQUEST_COMPLETE | The return request is complete and the refund amount has been successfully paid out. |
| RETURN_OR_REFUND_CANCEL | The return request was cancelled by the buyer, or closed by the system after deadline expiry or a seller-favored outcome. |

**Flow 1 :-**
Step 1: status from RETURN_OR_REFUND_REQUEST_PENDING to AWAITING_BUYER_SHIP
Trigger: seller or platform approves the return request.
Trigger initiator: Seller/System

Step 2: status from AWAITING_BUYER_SHIP to BUYER_SHIPPED_ITEM
Scenario A(buyer uses platform shipping to return)
Trigger: buyer shipped return package and package picked up by carrier.
Trigger initiator: System

Scenario B(buyer uses self-arrange shipping to return)
Trigger: buyer uploads the tracking number
Trigger initiator: Buyer

Step 3: status from BUYER_SHIPPED_ITEM to REQUEST_SUCCESS
Trigger: seller finished the return item(s) quality check and confirmed refund.
Trigger initiator: Seller/System

Step 4: status from REQUEST_SUCCESS to RETURN_OR_REFUND_REQUEST_COMPLETE
Trigger: the refunding for return is successful
Trigger initiator: System

**Flow 2a :-**
Step 1: status from BUYER_SHIPPED_ITEM to RECEIVE_REJECTED
Trigger: After seller checks the return item(s), seller refuses to refund for the return. 
Trigger initiator: Seller

Step 2: status from RECEIVE_REJECTED to REQUEST_SUCCESS
Trigger: The buyer submits an arbitration request to the platform, and the platform approves the buyer's return request.
Trigger initiator: System

**Flow 2b :-**
Step 1: status from BUYER_SHIPPED_ITEM to RECEIVE_REJECTED
Trigger: After seller checks the return item(s), seller refuses to refund for the return. 
Trigger initiator: Seller

Step 2: status from RECEIVE_REJECTED to RETURN_OR_REFUND_CANCEL
Trigger: After the buyer's return request is rejected and there is no arbitration raised within the given time, or if the arbitration result favors the seller.
Trigger initiator: System

**Flow 3a :-**
Step 1: status from RETURN_OR_REFUND_REQUEST_PENDING to REQUEST_REJECTED
Trigger: Seller rejects the buyer's return request.
Trigger initiator: Seller

Step 2: status from REQUEST_REJECTED to AWAITING_BUYER_SHIP
Trigger: The buyer submits an arbitration request to the platform, and the platform approves the buyer's return request.
Trigger initiator: System

**Flow 3b :-**
Step 1: status from RETURN_OR_REFUND_REQUEST_PENDING to REQUEST_REJECTED
Trigger: Seller rejects the buyer's return request.
Trigger initiator: Seller

Step 2: status from REQUEST_REJECTED to RETURN_OR_REFUND_CANCEL
Trigger: After the buyer's return request is rejected and there is no arbitration raised within the given time, or if the arbitration result favors the seller.
Trigger initiator: System

**Flow 4 :-**
Step 1: status from RETURN_OR_REFUND_REQUEST_PENDING to RETURN_OR_REFUND_CANCEL
Trigger: The request has been cancelled by the buyer.
Trigger initiator: Buyer

**Business Case:**

* Buyer initiates a return request

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/53f8bdc473654e42bb3fe7234cc1256f~tplv-k9wyc2ijk0-image.image)

* Seller initiates a return

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/1e501178d5724395ad1e5b2071e6c1ca~tplv-k9wyc2ijk0-image.image)

#### **Batch Return:**
**Background:** Batch Return is a Return sub-scenario where a buyer orders multiple SKUs and submits one return request in TikTok App. The buyer expects one return journey and one shipping label/QR, while downstream seller systems usually expect one RMA containing all expected line items.
The legacy behavior can decouple unique `sku_id` values into separate `return_id` / RMA records. That breaks return-platform, OMS, WMS, and warehouse operations that need one unified record.
| Object | Purpose | Key seller action | Key identifier |
| --- | --- | --- | --- |
| Aftersales Request | Buyer-facing request object that groups all requested SKUs and quantities for one batch return. | First review at line-item level. | `aftersales_request_id` |
| RMA (package-level return order) | Logistics-executable object created from approved items after package split. | Upload shipping information and complete second review per package. | `rma_id` |

**Business Flow:**

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/72e796505b754081b8438811e3acf62e~tplv-k9wyc2ijk0-image.image)

**Business Case:**

* Buyer initiates a return request

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/f7069924fdcc4e169d55daa748b072c5~tplv-k9wyc2ijk0-image.image)
**New Webhooks:**
| Webhook | Example status | Purpose |
| --- | --- | --- |
| `AFTERSALES_REQUEST_STATUS_UPDATE` | `PENDING_REQUEST_REVIEW`, `REQUEST_REVIEW_COMPLETED` | Signals request-level lifecycle and first-review completion |
| `RMA_STATUS_UPDATE` | `RMA_CREATED` | Signals unified RMA creation for second-review / warehouse workflow |
| `REFUND_SUCCESS` | `REFUND_SUCCESS` | Signals refund success for a given sku. |
###### New / Key API Surface
| API | Role | Notes |
| --- | --- | --- |
| `/return_refund/{api_version}/aftersales/search` | Search Aftersales Request | Retrieve unified request using `aftersales_request_id` |
| `/return_refund/{api_version}/rma/search` | Search RMA Requests | Retrieve unified RMA with line-level return details |
| `/return_refund/{api_version}/aftersales/review` | Review Aftersales / RMA | Supports `request_id_type = AFTERSALES` and `request_id_type = RMA` |
| Search Aftersales Request API | First-review data fetch | Exposes all return line item IDs for the unified request |
| Search RMA Requests API | Second-review data fetch | Used after `RMA_CREATED` to sync OMS/WMS |
| Upload Shipping Document API | Label / QR upload | Used by ISV / return platform when TikTok must show buyer the label/QR |
###### Review Decision Model
| Review phase | `request_id_type` | Example decision |
| --- | --- | --- |
| 1st Review | `AFTERSALES` | Approve or reject the return request |
| 2nd Review | `RMA` | `APPROVE_RETURN_PACKAGE`, `REJECT_RETURN_PACKAGE`, or mixed line-level decision |

Line-level decisions are a major improvement: sellers can approve some returned line items and reject others based on warehouse grading. The ARD notes an MVP limitation for same-SKU split decisions; Phase 2 expands support.
#### Replacement
**Replacement order status**

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/12b46ab08d524988a0d7da025076d7b5~tplv-k9wyc2ijk0-image.image)
| **Status** | **Description** |
| --- | --- |
| REPLACEMENT_REQUEST_PENDING | The buyer has initiated a replacement request. The request is pending review by seller. Seller has 24 hours to respond to the request. |
| REPLACEMENT_REQUEST_REJECT | The seller rejects the buyer's replacement request. |
| REPLACEMENT_REQUEST_REFUND_SUCCESS | Buyer's replacement request was resolved by refund due to insufficient inventory. |
| REPLACEMENT_REQUEST_CANCEL | The buyer canceled the replacement request. |
| REPLACEMENT_REQUEST_COMPLETE | The seller has approved the buyer's replacement request. The platform will generate a new order for the seller to fulfill. |

Feature brief: Replacement is initiated by buyer. The seller can reject/accept/refund the buyer request. If the seller/system accepts the buyer request, Tiktok Shop will generate a new order for the seller to reship. If sellers do not have enough inventory for the Replacement or can not send the item for Replacement, they can refund buyer directly.

Learn more about Replacement policy from [Item Replacement for Orders](https://seller-us.tiktok.com/university/essay?identity=1&role=1&knowledge_id=3253210454181634&from=policy&anchor_link=EB7800D0).

Case 1: status changing from REPLACEMENT_REQUEST_PENDING to REPLACEMENT_REQUEST_REJECT
Trigger: Seller received buyer replacement request and rejected the buyer replacement request. Please be aware if seller rejected buyer replacement request, buyer can initiate the dispute. 
Trigger initiator: Seller

Case 2: status changing from REPLACEMENT_REQUEST_PENDING to REPLACEMENT_REQUEST_COMPLETE
Trigger: Seller or system automatically accepts replacement requests. Please be aware if the seller/system accepts the buyer's replacement request TikTok Shop platform will automatically generate a new order for seller to fulfill. For the new orders generated for replacement, sellers should follow the same fulfillment policy as for the normal orders.
Trigger initiator: Seller/System

Case 3: status changing from REPLACEMENT_REQUEST_PENDING to REPLACEMENT_REQUEST_REFUND_SUCCESS
Trigger: Seller directly refunds the buyer. 
Trigger initiator: Seller

Case 4: status changing changing from REPLACEMENT_REQUEST_REJECT to REPLACEMENT_REQUEST_COMPLETE
Trigger: When buyer initiates dispute and TikTok Shop make a resolution that seller should execute the replacement request for the buyer.. TikTok Shop will initiate a new order for sellers to fulfill. Please be aware, for the new orders generated for replacement, sellers should follow the same fulfillment policy as for the normal orders.

**Business case**
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/97d72133b18b49cda4d3e25426fad903~tplv-k9wyc2ijk0-image.image)

### TikTok Shop Marketplace Policies
#### Policy for Responding to Buyer Requests

* The following approval nodes for cancellation/return/refund requests require seller's action, and the seller must respond to the request within 48 hours. If there is no response within 48 hours, TikTok Shop will automatically approve the corresponding request.
   * Cancel
      * When buyer initiates cancel request success, seller should respond to the request within 48 hours.
   * Refund
      * When buyer initiates refund request success, seller should respond to the request within 48 hours.
   * Return
      * When buyer initiates return request success, seller should respond to the request within 48 hours.
      * If the seller accepts the buyer's return request, the buyer will ship the item(s) back. Once the return package is delivered, the seller must respond to the return request within 48 hours.

#### Cancel/Return/Refund Initiative Policy
**Policy for Initiating Cancellations**
Buyers

* Buyers can freely cancel unpaid orders.

For the UK, TikTok Shop uses the ON_HOLD status to define an order that's within the buyer remorse window. If a buyer requests an order cancellation while the order has an ON_HOLD status, TikTok Shop will automatically accept the buyer cancellation request on behalf of the seller. For regions outside of the UK, the buyer remorse window starts when the order changes to AWAITING_SHIPMENT status +1 hour. The buyer will no longer be able to request for cancellations if the seller has fulfilled the order.

* Orders that are outside of the buyer remorse window

Once an order is longer within the buyer remorse window, the cancellation must be reviewed by the seller. If an order status changes to AWAITING_COLLECTION, the buyer will no longer be able to request for a cancellation.

Sellers

* Seller cannot cancel unpaid orders.
* Seller can cancel orders with the following statuses: 'ON_HOLD', 'AWAITING_SHIPMENT' and 'AWAITING_COLLECTION'.

For more details, please refer to Seller Academy.

**Policy for Initiating Refunds**

* Buyers are allowed to initiate refund requests when the order status is 'AWAITING_COLLECTION', 'IN_TRANSIT' and 'DELIVERED'
* Sellers are allowed to initiate refund requests when the order status is 'DELIVERED'

For more details, please refer to Seller Academy.

**Policy for Initiating Returns**

* Buyers are allowed to initiate return requests when the order status is 'DELIVERED'
* In the US, sellers are allowed to initiate refund requests when the order status is 'IN_TRANSIT' and 'DELIVERED'. In other markets, sellers are not allowed to initiate returns on behalf of buyers.

For more details, please refer to Seller Academy.

### Frequently Asked Questions

* Can a seller issue a partial refund to the buyer?
   * Different markets have different policies. Please refer to Seller Academy for details.

* What is the difference between cancel and refund?
   * Cancel request can be initiated by the buyer BEFORE the seller ships an order. Once the order has been shipped, the buyer will no longer be able to cancel the order. If the package is still being delivered and the buyer insists on canceling the order, the seller should ask the buyer to initiate a refund request.

* If a seller initiates a refund, are there any additional approvals needed?
   * No. TikTok Shop will automatically refund the buyer.

### Appendix
Seller Academy Cancel/Refund/Return TikTok Shop Policy
US: 

* https://seller-us.tiktok.com/university/essay?identity=1&role=1&knowledge_id=3253210454181634&from=policy

GB: 

* Cancellation: https://seller-uk.tiktok.com/university/essay?identity=1&role=1&knowledge_id=7753822474782466&from=policy
* Refund and Return: https://seller-uk.tiktok.com/university/essay?identity=1&role=1&knowledge_id=7753847099623170&from=policy

ID: 

* https://seller-id.tiktok.com/university/essay?identity=1&role=1&knowledge_id=6837727601690370&from=policy

TH: 

* https://seller-th.tiktok.com/university/essay?identity=1&role=1&knowledge_id=6837799362217730&from=policy

MY: 

* https://seller-my.tiktok.com/university/essay?identity=1&role=1&knowledge_id=7753775054259970&from=policy

VN: 

* https://seller-vn.tiktok.com/university/essay?identity=1&role=1&knowledge_id=6837773789234946&from=policy

PH:

* https://seller-ph.tiktok.com/university/essay?identity=1&role=1&knowledge_id=7654203686340353&from=policy

SG：

* https://seller-sg.tiktok.com/university/essay?identity=1&role=1&knowledge_id=7654182014830338&from=policy


---

## Return reasons

Doc: https://partner.tiktokshop.com/docv2/page/return-reasons · cập nhật 2026-05-08

### US market
#### Buyer Initiates Return Reason
| **Order status** | **Buyer available Return reason** | **Reason name** |
| --- | --- | --- |
| `AWAITING_COLLECTION`  `IN_TRANSIT` | No longer needed | ecom_order_delivered_refund_and_return_reason_no_need |
| `DELIVERED` | No longer needed | ecom_order_delivered_refund_and_return_reason_no_need |
|  | Item doesn't fit (some categories) | buyer_return_and_refund_item_doesn't_fit |
|  | Item doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description |
|  | Missing or broken parts (Missing parts) | ecom_order_delivered_refund_and_return_reason_missing_product |
|  | Damaged item or packaging | ecom_order_delivered_refund_and_return_reason_damaged |
|  | Defective item | ecom_order_delivered_refund_and_return_reason_defective |
|  | Wrong item was sent | ecom_order_delivered_refund_and_return_reason_wrong_product |
|  | Item arrived too late | buyer_return_and_refund_item_arrived_too_late |
|  | Fabric, material or style not as expected | buyer_return_and_refund_fabric,_material_or_style_not_as_expected |
|  | Item is too big | ecom_order_delivered_refund_and_return_reason_item_too_big |
|  | Item is too small | ecom_order_delivered_refund_and_return_reason_item_too_small |
#### Seller Reject Return Request Reason
##### **1st Review**
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| Item is correct | reverse_reject_refund_request_correct_item |
| Products were shipped in multiple packages  | reverse_reject_refund_request_package_delivery_multiple_boxes |
| Reason is unclear / lack of evidence | reverse_reject_refund_request_unclear_evidence |
| Product functions well/Incorrect usage by the customer | reverse_reject_refund_request_product_function_well |
| Product is in transit | reverse_reject_refund_request_package_delivery_timing |
| Replacement has been shipped | reverse_reject_refund_request_no_reason_shipped_replacement |
| The delivery attempt failed  | reverse_reject_refund_request_no_reason_failed_delivery_attempt |
| The package has been successfully delivered to the shipping address that was provided. | reverse_reject_refund_request_incorrect_address |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |

##### **2nd Review**
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| The product returned is not the product that was sent | reverse_reject_return_parcel_reason_1 |
| Missing products and/or product parts | reverse_reject_return_parcel_reason_3 |
| I haven't received the package | reverse_reject_return_parcel_reason_4 |
| Product is damaged or used | reverse_reject_return_parcel_reason_5 |
#### Seller Initiates Return Reason
| **Order Status** | **Seller available initiate Return reason** | **Reason name** |
| --- | --- | --- |
| `DELIVERED` | No longer needed | seller_ecom_delivered_return_refund_reason1 |

---

### UK market
#### Buyer Initiates Return Reason
| **Order status** | **Buyer available Return reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | No longer needed | ecom_order_delivered_refund_and_return_reason_no_need_uk |
| DELIVERED | Product doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description_uk |
|  | Missing product or accessories | ecom_order_delivered_refund_and_return_reason_missing_product_uk |
|  | Package or product is damaged | ecom_order_delivered_refund_and_return_reason_damaged_uk |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_and_return_reason_defective_uk |
|  | Wrong product was sent | ecom_order_delivered_refund_and_return_reason_wrong_product_uk |
|  | Other | ecom_order_delivered_refund_and_return_reason_other_uk |
|  | Suspected Counterfeit | buyer_return_and_refund_suspected_counterfeit |
|  | Does not suit me | buyer_return_and_refund_does_not_suit_me |
|  | Item is too big/long | buyer_return_and_refund_item_is_too_big/long |
|  | Item is too small/short | buyer_return_and_refund_item_is_too_small/short |
|  | Multiple sizes ordered | buyer_return_and_refund_multiple_sizes_ordered |
|  | Quality or style not as expected | buyer_return_and_refund_quality_or_style_not_as_expected |
|  | Ordered incorrect size | buyer_return_and_refund_ordered_incorrect_size |
|  | Unauthorised purchase | buyer_return_and_refund_unauthorised_purchase |
|  | Product is expired/spoiled | buyer_return_and_refund_product_is_expired/spoiled |
|  | Product not frozen on arrival | buyer_return_and_refund_product_not_frozen_on_arrival |
#### Seller Reject Return Request Reason
Seller rejects return request
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1_uk |
| Change of mind returns are not applicable | reverse_reject_request_reason_2_uk |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3_uk |
| Product delivery is on schedule | reverse_reject_request_reason_4_uk |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5_uk |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
Seller rejects receive package
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| The product returned is not the product that was sent | reverse_reject_return_parcel_reason_1_uk |
| Not eligible for return (e.g. used or broken) | reverse_reject_return_parcel_reason_2_uk |
| Missing products and/or product parts | reverse_reject_return_parcel_reason_3_uk |
| I haven't received the package | reverse_reject_return_parcel_reason_4_uk |
| Product is damaged or used | reverse_reject_return_parcel_reason_5_uk |
| You have reached an agreement with the buyer | seller_reject_apply_you_have_reached_an_agreement_with_the_buyer |
#### Seller Initiates Return Reason
| **Order Status** | **Seller available initiate Return reason** | **Reason name** |
| --- | --- | --- |
| DELIVERED | No longer needed | seller_ecom_delivered_return_refund_reason1_uk |
|  | Product doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description_seller_uk |
|  | Missing product or accessories | ecom_order_delivered_refund_and_return_reason_missing_product_seller_uk |
|  | Package or product is damaged | ecom_order_delivered_refund_and_return_reason_damaged_seller_uk |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_and_return_reason_defective_seller_uk |
|  | Wrong product was sent | ecom_order_delivered_refund_and_return_reason_wrong_product_seller_uk |
|  | Suspected Counterfeit | buyer_return_and_refund_suspected_counterfeit_seller_uk |

---

### ID market
#### Buyer Initiates Return Reason
| **Order status** | **Buyer available Return reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT  DELIVERED | Product doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description |
|  | Package or product is damaged | ecom_order_delivered_refund_and_return_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_and_return_reason_defective |
|  | Wrong product was sent | ecom_order_delivered_refund_and_return_reason_wrong_product |
|  | Missed estimated delivery date | ecom_order_delivered_refund_and_return_reason_missed_delivery |
|  | Suspected Counterfeit | buyer_return_and_refund_suspected_counterfeit |
#### Seller Reject Return Request Reason
Seller rejects return request
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1 |
| Change of mind returns are not applicable | reverse_reject_request_reason_2 |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5 |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
Seller rejects receive package
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| The product returned is not the product that was sent | reverse_reject_return_parcel_reason_1 |
| Not eligible for return (e.g. used or broken) | reverse_reject_return_parcel_reason_2 |
| Missing products and/or product parts | reverse_reject_return_parcel_reason_3 |
| I haven't received the package | reverse_reject_return_parcel_reason_4 |
| Product is damaged or used | reverse_reject_return_parcel_reason_5 |
| You have reached an agreement with the buyer | seller_reject_apply_you_have_reached_an_agreement_with_the_buyer |
#### Seller Initiates Return Reason
| **Order Status** | **Seller available initiate Return reason** | **Reason name** |
| --- | --- | --- |
| DELIVERED | Wrong product was sent | ecom_order_delivered_refund_and_return_reason_wrong_product_seller |

---

### MY market
#### Buyer Initiates Return Reason
| **Order status** | **Buyer available Return reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT  DELIVERED | Product doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description |
|  | Package or product is damaged | ecom_order_delivered_refund_and_return_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_and_return_reason_defective |
|  | Wrong product was sent | ecom_order_delivered_refund_and_return_reason_wrong_product |
|  | Missed estimated delivery date | ecom_order_delivered_refund_and_return_reason_missed_delivery |
|  | Suspected Counterfeit | buyer_return_and_refund_suspected_counterfeit |
#### Seller Reject Return Request Reason
Seller rejects return request
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1 |
| Change of mind returns are not applicable | reverse_reject_request_reason_2 |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5 |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
Seller rejects receive package
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| The product returned is not the product that was sent | reverse_reject_return_parcel_reason_1 |
| Not eligible for return (e.g. used or broken) | reverse_reject_return_parcel_reason_2 |
| Missing products and/or product parts | reverse_reject_return_parcel_reason_3 |
| I haven't received the package | reverse_reject_return_parcel_reason_4 |
| Product is damaged or used | reverse_reject_return_parcel_reason_5 |
| You have reached an agreement with the buyer | seller_reject_apply_you_have_reached_an_agreement_with_the_buyer |
#### Seller Initiates Return Reason
Unsupported

---

### PH market
#### Buyer Initiates Return Reason
| **Order status** | **Buyer available Return reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT  DELIVERED | Product doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description |
|  | Package or product is damaged | ecom_order_delivered_refund_and_return_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_and_return_reason_defective |
|  | Wrong product was sent | ecom_order_delivered_refund_and_return_reason_wrong_product |
|  | Missed estimated delivery date | ecom_order_delivered_refund_and_return_reason_missed_delivery |
|  | Suspected Counterfeit | buyer_return_and_refund_suspected_counterfeit |
#### Seller Reject Return Request Reason
Seller rejects return request
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1 |
| Change of mind returns are not applicable | reverse_reject_request_reason_2 |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5 |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
Seller rejects receive package
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| The product returned is not the product that was sent | reverse_reject_return_parcel_reason_1 |
| Not eligible for return (e.g. used or broken) | reverse_reject_return_parcel_reason_2 |
| Missing products and/or product parts | reverse_reject_return_parcel_reason_3 |
| I haven't received the package | reverse_reject_return_parcel_reason_4 |
| Product is damaged or used | reverse_reject_return_parcel_reason_5 |
| You have reached an agreement with the buyer | seller_reject_apply_you_have_reached_an_agreement_with_the_buyer |
#### Seller Initiates Return Reason
Unsupported

---

### SG market
#### Buyer Initiates Return Reason
| **Order status** | **Buyer available Return reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT  DELIVERED | Product doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description |
|  | Package or product is damaged | ecom_order_delivered_refund_and_return_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_and_return_reason_defective |
|  | Wrong product was sent | ecom_order_delivered_refund_and_return_reason_wrong_product |
|  | Missed estimated delivery date | ecom_order_delivered_refund_and_return_reason_missed_delivery |
|  | Suspected Counterfeit | buyer_return_and_refund_suspected_counterfeit |
#### Seller Reject Return Request Reason
Seller rejects return request
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1 |
| Change of mind returns are not applicable | reverse_reject_request_reason_2 |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5 |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
Seller rejects receive package
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| The product returned is not the product that was sent | reverse_reject_return_parcel_reason_1 |
| Not eligible for return (e.g. used or broken) | reverse_reject_return_parcel_reason_2 |
| Missing products and/or product parts | reverse_reject_return_parcel_reason_3 |
| I haven't received the package | reverse_reject_return_parcel_reason_4 |
| Product is damaged or used | reverse_reject_return_parcel_reason_5 |
| You have reached an agreement with the buyer | seller_reject_apply_you_have_reached_an_agreement_with_the_buyer |
#### Seller Initiates Return Reason
Unsupported

---

### TH market
#### Buyer Initiates Return Reason
| **Order status** | **Buyer available Return reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT  DELIVERED | No longer needed | ecom_order_delivered_refund_and_return_reason_no_need |
|  | Product doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description |
|  | Package or product is damaged | ecom_order_delivered_refund_and_return_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_and_return_reason_defective |
|  | Wrong product was sent | ecom_order_delivered_refund_and_return_reason_wrong_product |
|  | Missed estimated delivery date | ecom_order_delivered_refund_and_return_reason_missed_delivery |
|  | Suspected Counterfeit | buyer_return_and_refund_suspected_counterfeit |
#### Seller Reject Return Request Reason
Seller rejects return request
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1 |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5 |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
Seller rejects receive package
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| The product returned is not the product that was sent | reverse_reject_return_parcel_reason_1 |
| Not eligible for return (e.g. used or broken) | reverse_reject_return_parcel_reason_2 |
| Missing products and/or product parts | reverse_reject_return_parcel_reason_3 |
| I haven't received the package | reverse_reject_return_parcel_reason_4 |
| Product is damaged or used | reverse_reject_return_parcel_reason_5 |
| You have reached an agreement with the buyer | seller_reject_apply_you_have_reached_an_agreement_with_the_buyer |
#### Seller Initiates Return Reason
Unsupported

---

### VN market
#### Buyer Initiates Return Reason
| **Order status** | **Buyer available Return reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT  DELIVERED | Product doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description |
|  | Package or product is damaged | ecom_order_delivered_refund_and_return_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_and_return_reason_defective |
|  | Wrong product was sent | ecom_order_delivered_refund_and_return_reason_wrong_product |
|  | Missed estimated delivery date | ecom_order_delivered_refund_and_return_reason_missed_delivery |
|  | Suspected Counterfeit | buyer_return_and_refund_suspected_counterfeit |
#### Seller Reject Return Request Reason
Seller rejects return request
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1 |
| Change of mind returns are not applicable | reverse_reject_request_reason_2 |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5 |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
Seller rejects receive package
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| The product returned is not the product that was sent | reverse_reject_return_parcel_reason_1 |
| Not eligible for return (e.g. used or broken) | reverse_reject_return_parcel_reason_2 |
| Missing products and/or product parts | reverse_reject_return_parcel_reason_3 |
| I haven't received the package | reverse_reject_return_parcel_reason_4 |
| Product is damaged or used | reverse_reject_return_parcel_reason_5 |
| You have reached an agreement with the buyer | seller_reject_apply_you_have_reached_an_agreement_with_the_buyer |
#### Seller Initiates Return Reason
| **Order Status** | **Seller available initiate Return reason** | **Reason name** |
| --- | --- | --- |
| DELIVERED | No longer needed | seller_ecom_delivered_return_refund_reason1 |
|  | Product doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description_seller |
|  | Missing product or accessories | ecom_order_delivered_refund_and_return_reason_missing_product_seller |
|  | Package or product is damaged | ecom_order_delivered_refund_and_return_reason_damaged_seller |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_and_return_reason_defective_seller |
|  | Wrong product was sent | ecom_order_delivered_refund_and_return_reason_wrong_product_seller |
|  | Suspected Counterfeit | buyer_return_and_refund_suspected_counterfeit_seller |

---

### MX market
#### Buyer Initiates Return Reason
| **Order status** | **Buyer available Return reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT  DELIVERED | Item doesn't fit | buyer_return_and_refund_item_doesn't_fit |
|  | No longer needed | ecom_order_delivered_refund_and_return_reason_no_need |
|  | Defective item | ecom_order_delivered_refund_reason_defective |
|  | Item arrived too late | buyer_return_and_refund_item_arrived_too_late |
|  | Wrong item was sent | ecom_order_delivered_refund_reason_wrong_product |
|  | Fabric, material or style not as expected | buyer_return_and_refund_fabric,_material_or_style_not_as_expected |
|  | Color or pattern not as expected | buyer_return_and_refund_color_or_pattern_not_as_expected |
|  | Damaged item or packaging | ecom_order_delivered_refund_and_return_reason_damaged |
|  | Item doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description |
#### Seller Reject Return Request Reason
Seller rejects return request
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| Product functions well/Incorrect usage by the customer | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Item is correct | seller_reject_apply_item_is_correct |
| You have reached an agreement with the customer | reverse_reject_request_reason_5 |
| Product is in transit | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
| Your products were shipped by multiple packages. | seller_reject_apply_products_will_be_sent_separately |
| Need to apply for refund&return | seller_reject_apply_need_to_apply_for_refund&return |
Seller rejects receive package
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| The product returned is not the product that was sent | reverse_reject_return_parcel_reason_1 |
| Not eligible for return (e.g. used or broken) | reverse_reject_return_parcel_reason_2 |
| Missing products and/or product parts | reverse_reject_return_parcel_reason_3 |
| I haven't received the package | reverse_reject_return_parcel_reason_4 |
| Product is damaged or used | reverse_reject_return_parcel_reason_5 |
| You have reached an agreement with the customer | seller_reject_apply_you_have_reached_an_agreement_with_the_buyer |
#### Seller Initiates Return Reason
| **Order Status** | **Seller available initiate Return reason** | **Reason name** |
| --- | --- | --- |
| DELIVERED | No longer needed | seller_ecom_delivered_return_refund_reason1 |
|  | Late delivery (Item arrived too late) | seller_return_late_delivery |
|  | Missing items or parts | seller_return_missing_item |
|  | Damaged item or packaging | seller_return_damaged_item |
|  | Defective item | seller_return_defective_item |
|  | Wrong item was sent | seller_return_wrong_item_was_sent |

---

### BR market
#### Buyer Initiates Return Reason
| **Order status** | **Buyer available Return reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT  DELIVERED | Item doesn't fit | buyer_return_and_refund_item_doesn't_fit |
|  | No longer needed | ecom_order_delivered_refund_and_return_reason_no_need |
|  | Defective item | ecom_order_delivered_refund_reason_defective |
|  | Item arrived too late | buyer_return_and_refund_item_arrived_too_late |
|  | Wrong item was sent | ecom_order_delivered_refund_reason_wrong_product |
|  | Fabric, material or style not as expected | buyer_return_and_refund_fabric,_material_or_style_not_as_expected |
|  | Color or pattern not as expected | buyer_return_and_refund_color_or_pattern_not_as_expected |
|  | Damaged item or packaging | ecom_order_delivered_refund_and_return_reason_damaged |
|  | Item doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description |
|  | Package received but missing item | ecom_order_delivered_refund_and_return_reason_missing_product |
#### Seller Reject Return Request Reason
Seller rejects return request
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| Product functions well/Incorrect usage by the customer | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Item is correct | seller_reject_apply_item_is_correct |
| You have reached an agreement with the customer | reverse_reject_request_reason_5 |
| Product is in transit | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
| Your products were shipped by multiple packages. | seller_reject_apply_products_will_be_sent_separately |
| Need to apply for refund&return | seller_reject_apply_need_to_apply_for_refund&return |
Seller rejects receive package
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| The product returned is not the product that was sent | reverse_reject_return_parcel_reason_1 |
| Not eligible for return (e.g. used or broken) | reverse_reject_return_parcel_reason_2 |
| Missing products and/or product parts | reverse_reject_return_parcel_reason_3 |
| I haven't received the package | reverse_reject_return_parcel_reason_4 |
| Product is damaged or used | reverse_reject_return_parcel_reason_5 |
| You have reached an agreement with the customer | seller_reject_apply_you_have_reached_an_agreement_with_the_buyer |
#### Seller Initiates Return Reason
| **Order Status** | **Seller available initiate Return reason** | **Reason name** |
| --- | --- | --- |
| DELIVERED | No longer needed | seller_ecom_delivered_return_refund_reason1 |
|  | Late delivery (Item arrived too late) | seller_return_late_delivery |
|  | Missing items or parts | seller_return_missing_item |
|  | Damaged item or packaging | seller_return_damaged_item |
|  | Defective item | seller_return_defective_item |
|  | Wrong item was sent | seller_return_wrong_item_was_sent |

---

### EU market(s)
Currently, supported EU markets include: 

* Spain (ES)
* Ireland (IE)
* France (FR)
* Germany (DE)
* Italy (IT)

#### Buyer Initiates Return Reason
| **Order status** | **Buyer available Return reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT  DELIVERED   | No longer needed | ecom_order_delivered_refund_reason_no_need |
|  | No longer needed | ecom_order_delivered_refund_and_return_reason_no_need |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date |
|  | Other | ecom_order_delivered_refund_and_return_reason_other |
|  | Wrong product was sent | ecom_order_delivered_refund_and_return_reason_wrong_product |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_and_return_reason_defective |
|  | Package or product is damaged | ecom_order_delivered_refund_and_return_reason_damaged |
|  | Missing product or accessories | ecom_order_delivered_refund_and_return_reason_missing_product |
|  | Product doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description |
|  | Does not suit me | buyer_return_and_refund_does_not_suit_me |
|  | Item is too big/long | buyer_return_and_refund_item_is_too_big/long |
|  | Item is too small/short | buyer_return_and_refund_item_is_too_small/short |
|  | Multiple sizes ordered | buyer_return_and_refund_multiple_sizes_ordered |
|  | Quality or style not as expected | buyer_return_and_refund_quality_or_style_not_as_expected |
|  | Unauthorized purchase | buyer_return_and_refund_unauthorised_purchase |
|  | Product is expired/spoiled | buyer_return_and_refund_product_is_expired/spoiled |
|  | Product not frozen on arrival | buyer_return_and_refund_product_not_frozen_on_arrival |
|  | Ordered incorrect size | buyer_return_and_refund_ordered_incorrect_size |

#### Seller Reject Return Request Reason
Seller rejects return request
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| Product delivery is on schedule | reverse_reject_request_reason_4_uk |
| Change of mind returns are not applicable | reverse_reject_request_reason_2_uk |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3_uk |
| Product delivery is on schedule | order_manage_list_action_respond_popup_reject_reason_delivered_uk |
| Customer return reason is not valid | reverse_reject_request_reason_1_uk |
| Product functions well/Incorrect usage by the customer | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Reached an agreement with the customer | order_manage_list_action_respond_popup_reject_reason_buyer_agree |
| You have reached an agreement with the customer | reverse_reject_request_reason_5 |
| Your products were shipped by multiple packages. | seller_reject_apply_products_will_be_sent_separately |
Seller rejects receive package
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| You have reached an agreement with the customer | seller_reject_apply_you_have_reached_an_agreement_with_the_buyer |
| The product returned is not the product that was sent | reverse_reject_return_parcel_reason_1 |
| Not eligible for return (e.g. used or broken) | reverse_reject_return_parcel_reason_2 |
| Missing products and/or product parts | reverse_reject_return_parcel_reason_3 |
| I haven't received the package | reverse_reject_return_parcel_reason_4 |
| Product is damaged or used | reverse_reject_return_parcel_reason_5 |

#### Seller Initiates Return Reason
| **Order Stauts** | **Seller available initiate Return reason** | **Reason name** |
| --- | --- | --- |
| DELIVERED | No longer needed | seller_ecom_delivered_return_refund_reason1 |
|  | Product doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description_seller |
|  | Missing product or accessories | ecom_order_delivered_refund_and_return_reason_missing_product_seller |
|  | Package or product is damaged | ecom_order_delivered_refund_and_return_reason_damaged_seller |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_and_return_reason_defective_seller |
|  | Wrong product was sent | ecom_order_delivered_refund_and_return_reason_wrong_product_seller |
|  | Suspected Counterfeit | buyer_return_and_refund_suspected_counterfeit_seller |

---

### JP market
#### Buyer Initiates Return Reason
| **Order status** | **Buyer available Return reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT  DELIVERED   | No longer needed (Item must be returned in sealed/original condition). | ecom_order_delivered_refund_reason_no_need |
|  | Received package but missing parts or accessories. | ecom_order_delivered_refund_and_return_reason_missing_parts_JP |
|  | Product doesn't match description. | ecom_order_delivered_refund_and_return_reason_not_match_description_JP |
|  | Package or product is damaged. | ecom_order_delivered_refund_reason_damaged |
|  | Product is defective or doesn't work. | ecom_order_delivered_refund_reason_defective |
|  | Wrong product sent. | ecom_order_delivered_refund_and_return_reason_wrong_product_JP |
|  | Missed estimated delivery date. | ecom_order_delivered_refund_and_return_reason_missed_delivery_date_JP |
#### Seller Reject Return Request Reason
Seller rejects return request.
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| reverse_reject_refund_request_unclear_evidence_Test | Reason is unclear / lack of evidence. |
| ecom_reverse_reject_cancel_reason_product_packed | Product shipped. Tracking updates will be available soon. |
| ecom_reverse_reject_refund_request_failed_delivery | The delivery attempt failed. |
| ecom_reverse_reject_refund_request_package_delivery_multiple_boxes | Products were shipped in multiple packages. |
| ecom_reverse_reject_refund_request_replacement_shipped | Replacement has been shipped. |
| ecom_reverse_reject_apply_buyer_agree_jp | Reached an agreement with the customer. |
| seller_reject_apply_reason_delivered_jp | Product delivery is on schedule. |
| seller_reject_apply_buyers_responsibility_for_incorrect_address | The package has been successfully delivered to the shipping address that was provided. |
| seller_reject_apply_item_is_correct | Item is correct. |
| seller_reject_apply_package_has_not_exceeded_estimated_delivery_time | Product delivery is on schedule. |
| seller_reject_apply_product_functions_well/buyer_use_in_wrong_way | Product functions well / Incorrect usage by the customer. |
| seller_reject_apply_reason_is_unclear_or_lack_of_evidence | Reason is unclear / lack of evidence. |
| seller_reject_apply_unable_to_change_address | Unable to change address. |
Seller rejects receive package.
| **Seller available reject return reason** | **Reason name** |
| --- | --- |
| The product returned is not the product that was sent. | reverse_reject_return_parcel_reason_1 |
| Missing products and/or product parts. | reverse_reject_return_parcel_reason_3 |
| I haven't received the package. | reverse_reject_return_parcel_reason_4 |
| Product is damaged or used. | reverse_reject_return_parcel_reason_5 |


---

## Refund reasons

Doc: https://partner.tiktokshop.com/docv2/page/refund-reasons · cập nhật 2026-02-19

📌 Different order statuses require different reasons. Check the status on the left in the table to find the applicable reasons, and include the reason name as a request parameter when making the API call. If the cancel reason is not applicable for the order status, the API will return a '25001021 Reason not match order status' error.
### US market
#### Buyer Initiates Refund Reason
| **Order status** | **Buyer available refund reason** | **Reason name** |
| --- | --- | --- |
| `AWAITING_COLLECTION`  `IN_TRANSIT` | Product wouldn't arrive on time | ecom_order_shipped_refund_reason_not_arrive_on_time |
| `DELIVERED` | Package wasn't received | ecom_order_delivered_refund_reason_not_received |
|  | Package received but missing item | ecom_order_delivered_refund_reason_missing_product |
|  | Damaged item or packaging | ecom_order_delivered_refund_reason_damaged |
|  | Defective item | ecom_order_delivered_refund_reason_defective |
|  | Missing or broken parts | ecom_order_delivered_refund_reason_missing_broken_parts |
|  | Item doesn't match description | ecom_order_delivered_refund_reason_not_match_description |
|  | Wrong item was sent | ecom_order_delivered_refund_reason_wrong_product_1 |
#### Seller Reject Refund Request Reason
> ### **1st Review**

| **Seller available reject refund reason** | **Reason name** |
| --- | --- |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| Item is correct | reverse_reject_refund_request_correct_item |
| Products were shipped in multiple packages  | reverse_reject_refund_request_package_delivery_multiple_boxes |
| Reason is unclear / lack of evidence | reverse_reject_refund_request_unclear_evidence |
| Product functions well/Incorrect usage by the customer | reverse_reject_refund_request_product_function_well |
| Product is in transit | reverse_reject_refund_request_package_delivery_timing |
| Replacement has been shipped | reverse_reject_refund_request_no_reason_shipped_replacement |
| The delivery attempt failed  | reverse_reject_refund_request_no_reason_failed_delivery_attempt |
| The package has been successfully delivered to the shipping address that was provided. | reverse_reject_refund_request_incorrect_address |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |

#### Seller Initiates Refund Reason
| **Order Status** | **Seller available initiate refund reason** | **Reason name** |
| --- | --- | --- |
| `AWAITING_COLLECTION`  `IN_TRANSIT` | Package lost | seller_shipped_refund_package_lost |
|  | Package delivery failed | seller_shipped_refund_package_delivery_failed |
|  | Missed estimated delivery date | seller_shipped_refund_miss_estimated_delivery_date |
| `DELIVERED` | Missing product or accessories | ecom_order_delivered_refund_reason_missing_product_seller |
|  | Package wasn't received | ecom_order_delivered_refund_reason_not_received_seller |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match_description_seller |
|  | Package or product is damaged | ecom_order_delivered_refund_reason_damaged_seller |
|  | Wrong product was sent | ecom_order_delivered_refund_reason_wrong_product_seller |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date_seller |
|  | Package lost | seller_shipped_refund_package_lost |
|  | Package delivery failed | seller_shipped_refund_package_delivery_failed |

---

### UK market
#### Buyer Initiates Refund Reason
| **Order status** | **Buyer available refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Package didn't arrive on time | buyer_refund_package_didn't_arrive_on_time |
| DELIVERED | No longer needed | ecom_order_delivered_refund_reason_no_need_uk |
|  | Package wasn't received | ecom_order_delivered_refund_reason_not_received_uk |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match_uk |
|  | Missing product or accessories | ecom_order_delivered_refund_reason_missing_product_uk |
|  | Package or product is damaged | ecom_order_delivered_refund_reason_damaged_uk |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_reason_defective_uk |
|  | Wrong product was sent | ecom_order_delivered_refund_reason_wrong_product_uk |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date_uk |
|  | Other | ecom_order_delivered_refund_reason_other_uk |
|  | Suspected Counterfeit | buyer_refund_suspected_counterfeit |
|  | Does not suit me | buyer_refund_does_not_suit_me |
|  | Multiple sizes ordered | buyer_refund_multiple_sizes_ordered |
|  | Quality or style not as expected | buyer_refund_quality_or_style_not_as_expected |
|  | Item is too big/long | buyer_refund_item_is_too_big/long |
|  | Item is too small/short | buyer_refund_item_is_too_small/short |
|  | Ordered incorrect size | buyer_refund_ordered_incorrect_size |
|  | Unauthorised purchase | buyer_refund_unauthorised_purchase |
|  | Product is expired/spoiled | buyer_refund_product_is_expired/spoiled |
|  | Product not frozen on arrival | buyer_refund_product_not_frozen_on_arrival |
#### Seller Reject Refund Request Reason
| **Seller available reject refund reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1_uk |
| Change of mind returns are not applicable | reverse_reject_request_reason_2_uk |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3_uk |
| Product delivery is on schedule | reverse_reject_request_reason_4_uk |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5_uk |
| Unable to change address | seller_reject_apply_unable_to_change_address |
| Buyer's responsibility for incorrect address | seller_reject_apply_buyer's_responsibility_for_incorrect_address |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_/_lack_of_evidence |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
#### Seller Initiates Refund Reason
| **Order Status** | **Seller available initiate refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Package lost | seller_package_lost_uk |
|  | Product wouldn't arrive on time | ecom_order_shipped_refund_reason_not_arrive_on_time_seller_uk |
| DELIVERED | Missing product or accessories | ecom_order_delivered_refund_reason_missing_product_seller_uk |
|  | Package wasn't received | ecom_order_delivered_refund_reason_not_received_seller_uk |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match_description_seller_uk |
|  | Package or product is damaged | ecom_order_delivered_refund_reason_damaged_seller_uk |
|  | Wrong product was sent | ecom_order_delivered_refund_reason_wrong_product_seller_uk |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date_seller_uk |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_reason_defective_seller_uk |
|  | Suspected Counterfeit | buyer_refund_suspected_counterfeit_seller_uk |

---

### ID market
#### Buyer Initiates Refund Reason
| **Order status** | **Buyer available refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Product wouldn't arrive on time | ecom_order_shipped_refund_reason_not_arrive_on_time |
| DELIVERED | Package wasn't received | ecom_order_delivered_refund_reason_not_received |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match |
|  | Missing product or accessories | ecom_order_delivered_refund_reason_missing_product |
|  | Package or product is damaged | ecom_order_delivered_refund_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_reason_defective |
|  | Wrong product was sent | ecom_order_delivered_refund_reason_wrong_product |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date |
|  | Other | ecom_order_delivered_refund_reason_other |
|  | Suspected Counterfeit | buyer_refund_suspected_counterfeit |
#### Seller Reject Refund Request Reason
| **Seller available reject refund reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1 |
| Change of mind returns are not applicable | reverse_reject_request_reason_2 |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5 |
| Unable to change address | seller_reject_apply_unable_to_change_address |
| Need to apply for refund&return | seller_reject_apply_need_to_apply_for_refund&return |
| Buyer's responsibility for incorrect address | seller_reject_apply_buyer's_responsibility_for_incorrect_address |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_/_lack_of_evidence |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
#### Seller Initiates Refund Reason
| **Order Status** | **Seller available initiate refund reason** | **Reason name** |
| --- | --- | --- |
| DELIVERED | Missing product or accessories | ecom_order_delivered_refund_reason_missing_product_seller |

---

### MY market
#### Buyer Initiates Refund Reason
| **Order status** | **Buyer available refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Product wouldn't arrive on time | ecom_order_shipped_refund_reason_not_arrive_on_time |
| DELIVERED | Package wasn't received | ecom_order_delivered_refund_reason_not_received |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match |
|  | Missing product or accessories | ecom_order_delivered_refund_reason_missing_product |
|  | Package or product is damaged | ecom_order_delivered_refund_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_reason_defective |
|  | Wrong product was sent | ecom_order_delivered_refund_reason_wrong_product |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date |
|  | Suspected Counterfeit | buyer_refund_suspected_counterfeit |
#### Seller Reject Refund Request Reason
| **Seller available reject refund reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1 |
| Change of mind returns are not applicable | reverse_reject_request_reason_2 |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5 |
| Unable to change address | seller_reject_apply_unable_to_change_address |
| Need to apply for refund&return | seller_reject_apply_need_to_apply_for_refund&return |
| Buyer's responsibility for incorrect address | seller_reject_apply_buyer's_responsibility_for_incorrect_address |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_/_lack_of_evidence |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
#### Seller Initiates Refund Reason
Unsupported

---

### PH market
#### Buyer Initiates Refund Reason
| **Order status** | **Buyer available refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Product wouldn't arrive on time | ecom_order_shipped_refund_reason_not_arrive_on_time |
| DELIVERED | Package wasn't received | ecom_order_delivered_refund_reason_not_received |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match |
|  | Missing product or accessories | ecom_order_delivered_refund_reason_missing_product |
|  | Package or product is damaged | ecom_order_delivered_refund_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_reason_defective |
|  | Wrong product was sent | ecom_order_delivered_refund_reason_wrong_product |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date |
|  | Suspected Counterfeit | buyer_refund_suspected_counterfeit |
#### Seller Reject Refund Request Reason
| **Seller available reject refund reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1 |
| Change of mind returns are not applicable | reverse_reject_request_reason_2 |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5 |
| Unable to change address | seller_reject_apply_unable_to_change_address |
| Need to apply for refund&return | seller_reject_apply_need_to_apply_for_refund&return |
| Buyer's responsibility for incorrect address | seller_reject_apply_buyer's_responsibility_for_incorrect_address |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_/_lack_of_evidence |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
#### Seller Initiates Refund Reason
Unsupported

---

### SG market
#### Buyer Initiates Refund Reason
| **Order status** | **Buyer available refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Product wouldn't arrive on time | ecom_order_shipped_refund_reason_not_arrive_on_time |
| DELIVERED | Package wasn't received | ecom_order_delivered_refund_reason_not_received |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match |
|  | Missing product or accessories | ecom_order_delivered_refund_reason_missing_product |
|  | Package or product is damaged | ecom_order_delivered_refund_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_reason_defective |
|  | Wrong product was sent | ecom_order_delivered_refund_reason_wrong_product |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date |
|  | Suspected Counterfeit | buyer_refund_suspected_counterfeit |
#### Seller Reject Refund Request Reason
| **Seller available reject refund reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1 |
| Change of mind returns are not applicable | reverse_reject_request_reason_2 |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5 |
| Unable to change address | seller_reject_apply_unable_to_change_address |
| Need to apply for refund&return | seller_reject_apply_need_to_apply_for_refund&return |
| Buyer's responsibility for incorrect address | seller_reject_apply_buyer's_responsibility_for_incorrect_address |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_/_lack_of_evidence |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
#### Seller Initiates Refund Reason
Unsupported

---

### TH market
#### Buyer Initiates Refund Reason
| **Order status** | **Buyer available refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Product wouldn't arrive on time | ecom_order_shipped_refund_reason_not_arrive_on_time |
|  | Wrong delivery information | ecom_order_shipped_refund_wrong_delivery_info |
|  | Other | ecom_order_shipped_refund_other |
| DELIVERED | No longer needed | ecom_order_delivered_refund_reason_no_need |
|  | Package wasn't received | ecom_order_delivered_refund_reason_not_received |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match |
|  | Missing product or accessories | ecom_order_delivered_refund_reason_missing_product |
|  | Package or product is damaged | ecom_order_delivered_refund_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_reason_defective |
|  | Wrong product was sent | ecom_order_delivered_refund_reason_wrong_product |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date |
|  | Suspected Counterfeit | buyer_refund_suspected_counterfeit |
|  | Other | ecom_order_delivered_refund_reason_other |
#### Seller Reject Refund Request Reason
| **Seller available reject refund reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1 |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5 |
| Unable to change address | seller_reject_apply_unable_to_change_address |
| Need to apply for refund&return | seller_reject_apply_need_to_apply_for_refund&return |
| Buyer's responsibility for incorrect address | seller_reject_apply_buyer's_responsibility_for_incorrect_address |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_/_lack_of_evidence |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
#### Seller Initiates Refund Reason
Unsupported

---

### VN market
#### Buyer Initiates Refund Reason
| **Order status** | **Buyer available refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Product wouldn't arrive on time | ecom_order_shipped_refund_reason_not_arrive_on_time |
| DELIVERED | Package wasn't received | ecom_order_delivered_refund_reason_not_received |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match |
|  | Missing product or accessories | ecom_order_delivered_refund_reason_missing_product |
|  | Package or product is damaged | ecom_order_delivered_refund_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_reason_defective |
|  | Wrong product was sent | ecom_order_delivered_refund_reason_wrong_product |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date |
|  | Suspected Counterfeit | buyer_refund_suspected_counterfeit |
#### Seller Reject Refund Request Reason
| **Seller available reject refund reason** | **Reason name** |
| --- | --- |
| Buyer return reason is not valid | reverse_reject_request_reason_1 |
| Change of mind returns are not applicable | reverse_reject_request_reason_2 |
| Not eligible for return (e.g. used or broken) | reverse_reject_request_reason_3 |
| Product delivery is on schedule | reverse_reject_request_reason_4 |
| You have reached an agreement with the buyer | reverse_reject_request_reason_5 |
| Unable to change address | seller_reject_apply_unable_to_change_address |
| Need to apply for refund&return | seller_reject_apply_need_to_apply_for_refund&return |
| Buyer's responsibility for incorrect address | seller_reject_apply_buyer's_responsibility_for_incorrect_address |
| Item is correct | seller_reject_apply_item_is_correct |
| Products will be sent separately | seller_reject_apply_products_will_be_sent_separately |
| Reason is unclear or lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product functions well/Buyer use in wrong way | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_/_lack_of_evidence |
| Product is shipped and parcel cannot be recalled back from logistics. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
#### Seller Initiates Refund Reason
| **Order Status** | **Seller available initiate refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Product wouldn't arrive on time | ecom_order_shipped_refund_reason_not_arrive_on_time_seller |
|  | Package lost | seller_package_lost |
| DELIVERED | Missing product or accessories | ecom_order_delivered_refund_reason_missing_product_seller |
|  | Package wasn't received | ecom_order_delivered_refund_reason_not_received_seller |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match_description_seller |
|  | Package or product is damaged | ecom_order_delivered_refund_reason_damaged_seller |
|  | Wrong product was sent | ecom_order_delivered_refund_reason_wrong_product_seller |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date_seller |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match_seller |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_reason_defective_seller |
|  | Suspected Counterfeit | buyer_refund_suspected_counterfeit_seller |

---

### MX market
#### Buyer Initiates Refund Reason
| **Order status** | **Buyer available refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Package wasn't received | ecom_order_delivered_refund_reason_not_received |
|  | Defective item | ecom_order_delivered_refund_reason_defective |
|  | Damaged item or packaging | ecom_order_delivered_refund_and_return_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_reason_defective |
#### Seller Reject Refund Request Reason
| **Seller available reject refund reason** | **Reason name** |
| --- | --- |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| You have reached an agreement with the customer | reverse_reject_request_reason_5 |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product is in transit | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
| The package has been successfully delivered to the shipping address that was provided. | seller_reject_apply_buyers_responsibility_for_incorrect_address |
| Need to apply for refund&return | seller_reject_apply_need_to_apply_for_refund&return |
#### Seller Initiates Refund Reason
| **Order Status** | **Seller available initiate refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Package lost | seller_package_lost |
|  | Missed estimated delivery date | seller_shipped_refund_miss_estimated_delivery_date |
|  | Package lost | seller_shipped_refund_package_lost |
|  | Package delivery failed | seller_shipped_refund_package_delivery_failed |
|  | Package lost | ecom_seller_order_delivered_refund_reason_return_proxy_app |
| DELIVERED | Missing products or accessories | ecom_order_delivered_refund_reason_missing_product_seller |
|  | Package or product is damaged | ecom_order_delivered_refund_reason_damaged_seller |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match_description_seller |
|  | Wrong product was sent | ecom_order_delivered_refund_reason_wrong_product_seller |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date_seller |
|  | Package wasn't received | ecom_order_delivered_refund_reason_not_received_seller |
|  | Missed estimated delivery date | seller_shipped_refund_miss_estimated_delivery_date |
|  | Package lost | seller_shipped_refund_package_lost |
|  | Package delivery failed | seller_shipped_refund_package_delivery_failed |
|  | Package lost | ecom_seller_order_delivered_refund_reason_return_proxy_app |

---

### BR market
#### Buyer Initiates Refund Reason
| **Order status** | **Buyer available refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Package wasn't received | ecom_order_delivered_refund_reason_not_received |
|  | Defective item | ecom_order_delivered_refund_reason_defective |
|  | Damaged item or packaging | ecom_order_delivered_refund_and_return_reason_damaged |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_reason_defective |
#### Seller Reject Refund Request Reason
| **Seller available reject refund reason** | **Reason name** |
| --- | --- |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| You have reached an agreement with the customer | reverse_reject_request_reason_5 |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Product is in transit | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
| The package has been successfully delivered to the shipping address that was provided. | seller_reject_apply_buyers_responsibility_for_incorrect_address |
| Need to apply for refund&return | seller_reject_apply_need_to_apply_for_refund&return |
#### Seller Initiates Refund Reason
| **Order Status** | **Seller available initiate refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Package lost | seller_package_lost |
|  | Missed estimated delivery date | seller_shipped_refund_miss_estimated_delivery_date |
|  | Package lost | seller_shipped_refund_package_lost |
|  | Package delivery failed | seller_shipped_refund_package_delivery_failed |
|  | Package lost | ecom_seller_order_delivered_refund_reason_return_proxy_app |
| DELIVERED | Missing products or accessories | ecom_order_delivered_refund_reason_missing_product_seller |
|  | Package or product is damaged | ecom_order_delivered_refund_reason_damaged_seller |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match_description_seller |
|  | Wrong product was sent | ecom_order_delivered_refund_reason_wrong_product_seller |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date_seller |
|  | Package wasn't received | ecom_order_delivered_refund_reason_not_received_seller |
|  | Missed estimated delivery date | seller_shipped_refund_miss_estimated_delivery_date |
|  | Package lost | seller_shipped_refund_package_lost |
|  | Package delivery failed | seller_shipped_refund_package_delivery_failed |
|  | Package lost | ecom_seller_order_delivered_refund_reason_return_proxy_app |

---

### EU market(s)
Currently, supported EU markets include: 

* Spain (ES)
* Ireland (IE)
* France (FR)
* Germany (DE)
* Italy (IT)

#### Buyer Initiates Refund Reason
| **Order status** | **Buyer available refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT  DELIVERED | No longer needed | ecom_order_delivered_refund_reason_no_need |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date |
|  | Package wasn't received | ecom_order_delivered_refund_reason_not_received |
|  | Other | ecom_order_delivered_refund_and_return_reason_other |
|  | Wrong product was sent | ecom_order_delivered_refund_and_return_reason_wrong_product |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_and_return_reason_defective |
|  | Package or product is damaged | ecom_order_delivered_refund_and_return_reason_damaged |
|  | Missing product or accessories | ecom_order_delivered_refund_and_return_reason_missing_product |
|  | Product doesn't match description | ecom_order_delivered_refund_and_return_reason_not_match_description |
|  | Does not suit me | buyer_return_and_refund_does_not_suit_me |
|  | Item is too big/long | buyer_return_and_refund_item_is_too_big/long |
|  | Item is too small/short | buyer_return_and_refund_item_is_too_small/short |
|  | Multiple sizes ordered | buyer_return_and_refund_multiple_sizes_ordered |
|  | Quality or style not as expected | buyer_return_and_refund_quality_or_style_not_as_expected |
|  | Unauthorized purchase | buyer_return_and_refund_unauthorised_purchase |
|  | Product is expired/spoiled | buyer_return_and_refund_product_is_expired/spoiled |
|  | Product not frozen on arrival | buyer_return_and_refund_product_not_frozen_on_arrival |
|  | Ordered incorrect size | buyer_return_and_refund_ordered_incorrect_size |

#### Seller Reject Refund Request Reason
| **Seller available reject refund reason** | **Reason name** |
| --- | --- |
| Product delivery is on schedule | reverse_reject_request_reason_4_uk |
| Change of mind returns are not applicable | reverse_reject_request_reason_2_uk |
| Product delivery is on schedule | order_manage_list_action_respond_popup_reject_reason_delivered_uk |
| The package has been successfully delivered to the shipping address that was provided. | seller_reject_apply_buyer's_responsibility_for_incorrect_address |
| Product functions well/Incorrect usage by the customer | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Parcel Delivered but Buyer did not receive, need more information | seller_reject_apply_reason_is_unclear_/_lack_of_evidence |
| Reason is unclear / lack of evidence | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Reached an agreement with the customer | order_manage_list_action_respond_popup_reject_reason_buyer_agree |
| You have reached an agreement with the customer | reverse_reject_request_reason_5 |
| Product is in transit | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
| Your products were shipped by multiple packages. | seller_reject_apply_products_will_be_sent_separately |
| Product shipped. Tracking updates will be available soon. | seller_reject_apply_product_has_been_packed |

#### Seller Initiates Refund Reason
| **Order Stauts** | **Seller available initiate refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT | Package lost | seller_package_lost |
|  | Product wouldn't arrive on time | ecom_order_shipped_refund_reason_not_arrive_on_time_seller |
| DELIVERED   | Missing products or accessories | ecom_order_delivered_refund_reason_missing_product_seller |
|  | Package wasn't received | ecom_order_delivered_refund_reason_not_received_seller |
|  | Product doesn't match description | ecom_order_delivered_refund_reason_not_match_description_seller |
|  | Package or product is damaged | ecom_order_delivered_refund_reason_damaged_seller |
|  | Wrong product was sent | ecom_order_delivered_refund_reason_wrong_product_seller |
|  | Missed estimated delivery date | ecom_order_delivered_refund_reason_missed_delivery_date_seller |
|  | Product is defective or doesn't work | ecom_order_delivered_refund_reason_defective_seller |
|  | Suspected Counterfeit | buyer_refund_suspected_counterfeit_seller |

---

### JP market
#### Buyer Initiates Refund Reason
| **Order status** | **Buyer available refund reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT  DELIVERED | No longer needed (Item must be returned in sealed/original condition). | ecom_order_delivered_refund_reason_no_need |
|  | Product didn't arrive on time. | ecom_order_shipped_refund_reason_not_arrive_on_time_JP |
|  | Didn't receive package. | ecom_order_delivered_refund_reason_not_received |
|  | Received package but some items are missing. | ecom_order_delivered_refund_reason_missing_product_JP |
|  | Received package but missing parts or accessories. | ecom_order_delivered_refund_and_return_reason_missing_parts_JP |
|  | Product doesn't match description. | ecom_order_delivered_refund_and_return_reason_not_match_description_JP |
|  | Package or product is damaged. | ecom_order_delivered_refund_reason_damaged |
|  | Product is defective or doesn't work. | ecom_order_delivered_refund_reason_defective |
|  | Wrong product sent. | ecom_order_delivered_refund_and_return_reason_wrong_product_JP |
|  | Missed estimated delivery date. | ecom_order_delivered_refund_and_return_reason_missed_delivery_date_JP |

#### Seller Reject Refund Request Reason
| **Seller available reject refund reason** | **Reason name** |
| --- | --- |
| Reason is unclear / lack of evidence. | reverse_reject_refund_request_unclear_evidence_Test |
| Product shipped. Tracking updates will be available soon. | ecom_reverse_reject_cancel_reason_product_packed |
| The delivery attempt failed. | ecom_reverse_reject_refund_request_failed_delivery |
| Products were shipped in multiple packages. | ecom_reverse_reject_refund_request_package_delivery_multiple_boxes |
| Replacement has been shipped. | ecom_reverse_reject_refund_request_replacement_shipped |
| Reached an agreement with the customer. | ecom_reverse_reject_apply_buyer_agree_jp |
| Product delivery is on schedule. | seller_reject_apply_reason_delivered_jp |
| The package has been successfully delivered to the shipping address that was provided. | seller_reject_apply_buyers_responsibility_for_incorrect_address |
| Item is correct. | seller_reject_apply_item_is_correct |
| Product delivery is on schedule. | seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |
| Product functions well/Incorrect usage by the customer. | seller_reject_apply_product_functions_well/buyer_use_in_wrong_way |
| Reason is unclear / lack of evidence. | seller_reject_apply_reason_is_unclear_or_lack_of_evidence |
| Unable to change address. | seller_reject_apply_unable_to_change_address |

#### Seller Initiates Refund Reason
| **Seller available initiate refund reason** | **Reason name** |
| --- | --- |
| Missing products or accessories | ecom_order_delivered_refund_reason_missing_product_seller |
| General adjustment. | ecom_order_delivered_refund_reason_general_adjustment |
| Package wasn't received. | ecom_order_delivered_refund_reason_not_received_seller |
| Product doesn't match description. | ecom_order_delivered_refund_reason_not_match_description_seller |
| Package or product is damaged. | ecom_order_delivered_refund_reason_damaged_seller |
| Wrong product was sent. | ecom_order_delivered_refund_reason_wrong_product_seller |
| Missed estimated delivery date. | ecom_order_delivered_refund_reason_missed_delivery_date_seller |
| Package lost. | seller_package_lost |
| Package lost. | seller_shipped_refund_package_lost |
| Package delivery failed. | seller_shipped_refund_package_delivery_failed |
| Missed estimated delivery date. | seller_shipped_refund_miss_estimated_delivery_date |
| Package lost. | ecom_seller_order_delivered_refund_reason_return_proxy_app |


---

## Cancel reasons

Doc: https://partner.tiktokshop.com/docv2/page/cancel-reasons · cập nhật 2026-10-16

📌 Different order statuses require different reasons. Check the status on the left in the table to find the applicable reasons, and include the reason name as a request parameter when making the API call. If the cancel reason is not applicable for the order status, the API will return a '25001021 Reason not match order status' error.
### US market
#### Buyer Initiates Cancel Reason
The following reason is available for buyers when they initiate cancel request.
| **Order Stauts** | **Buyer available cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID | Preferred payment method not available | ecom_order_unpaid_canceled_reason_payment_method_not_available |
|  | Ordered by mistake | ecom_order_unpaid_canceled_reason_created_by_mistakes |
|  | Better price available | ecom_order_unpaid_canceled_reason_better_price |
|  | No longer needed | ecom_order_unpaid_canceled_reason_no_longer_needed |
|  | Other | ecom_order_unpaid_canceled_reason_other |
|  | Forgot to apply coupons | ecom_order_to_ship_canceled_reason_forgot_to_apply_coupons |
| ON_HOLD and AWAITING_SHIPMENT   | Need to change payment method | ecom_order_to_ship_canceled_reason_change_payment_method |
|  | Discount not as expected | ecom_order_to_ship_canceled_reason_discount_not_expected |
|  | Bought by mistake | ecom_order_to_ship_canceled_reason_created_by_mistakes |
|  | High shipping fee | ecom_order_to_ship_canceled_reason_high_delivery_costs |
|  | Better price available | ecom_order_to_ship_canceled_reason_better_price |
|  | Incorrect shipping address | ecom_order_to_ship_canceled_reason_wrong_delivery_info |
|  | Item wasn't shipped on time | ecom_order_to_ship_canceled_reason_not_shipped_on_time |
|  | No longer needed | ecom_order_to_ship_canceled_reason_no_longer_needed |
|  | Forgot to apply coupons | ecom_order_to_ship_canceled_reason_forgot_to_apply_coupons |

#### Seller Reject Cancel Request Reason
The reason the seller can use to reject the buyer's cancel request
| **Seller available Reject Cancel reason** | **Reason name** |
| --- | --- |
| Invalid reason for cancellation | order_manage_list_action_respond_popup_reject_reason_invalid_cancellation_reason |
| Product delivery is on schedule | order_manage_list_action_respond_popup_reject_reason_delivered |
| Reached an agreement with the buyer | order_manage_list_action_respond_popup_reject_reason_buyer_agree |
| Product has been packed | seller_reject_apply_product_has_been_packed |

#### Seller Initiates Cancel Reason
The available reason of seller initiates cancel
| **Order Stauts** | **Seller available initiate cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID   | Out of stock | seller_cancel_unpaid_reason_out_of_stock |
|  | Pricing error | seller_cancel_unpaid_reason_wrong_price |
|  | Buyer did not pay on time | seller_cancel_unpaid_reason_buyer_hasnt_paid_within_time_allowed |
|  | Buyer requested cancellation | seller_cancel_unpaid_reason_buyer_requested_cancellation |
|  | Seller unable to fulfill order | seller_cancel_unpaid_reason_unable_to_fulfill_order |
| ON_HOLD and AWAITING_SHIPMENT   | Out of stock | seller_cancel_reason_out_of_stock |
|  | Pricing error | seller_cancel_reason_wrong_price |
|  | Unable to deliver to buyer address | seller_cancel_paid_reason_address_not_deliver |
|  | Buyer requested cancellation | seller_cancel_paid_reason_buyer_requested_cancellation |
|  | Seller unable to fulfill order | seller_cancel_reason_unable_to_fulfill_order |
#### SYSTEM Cancel Reason
| **Cancel reason** | **Reason name** |
| --- | --- |
| Buyer payment overdue | system_cancel_unpaid_time_out |
| Failed to pass risk review | system_cancel_anti_span_block |
| Inbound failed | system_cancel_cross_border_entry_warehouse_failed_reason2 |
| Order cancelled by system | package_cancel |
| Order cancelled by system | platform_cancel |
| Package rejected | returned_to_shipper_refused |
| Package delivery failed | returned_to_shipper_other |
| Package damaged | package_damagaed |
| Package lost | package_lost |
| Late delivery | threepl_breach |
| Package scrapped | package_scrap |
| Automatically cancelled due to collection time out | system_cancel_order_reason_shipping_timeout |
| This order has been automatically canceled as you didn't provide your delivery address. | system_cancel_add_address_overtime |
| Automatically cancelled due to untraceable tracking number | system_cancel_order_untracked |
| Order canceled by the system | ecom_cb_sc_out_return |
| Automatically canceled as not delivered within 30 days of estimated time of delivery | system_cancel_order_exceed_edt_not_arrive |
| Buyer hasn't paid | ecom_order_unpaid_canceled_reason_not_want_pay |

#### Operator Cancel
| **Cancel reason** | **Reason name** |
| --- | --- |
| We have identified a risk involved with your order and cancelled your order for safety reasons to protect your transaction. | system_cancel_order_reason_potential_fraud |
| Order canceled by system. | system_cancel_order_reason_experience_related |
| Failed to pass risk review | operator_cancel_risk_control_block |
| As your product violates the platform's negative review policy, we canceled this transaction. We recommend you process the buyer's after-sales request.  | system_cancel_order_reason_nrr_related |

### UK market
#### Buyer Initiates Cancel Reason
The following reason is available for buyers when they initiate cancel request.
| **Order Stauts** | **Buyer available cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID   | Desired payment method not available | ecom_order_unpaid_canceled_reason_payment_method_not_available_uk |
|  | Wrong delivery information | ecom_order_unpaid_canceled_reason_wrong_delivery_info_uk |
|  | Order created by mistake | ecom_order_unpaid_canceled_reason_created_by_mistakes_uk |
|  | Better price available | ecom_order_unpaid_canceled_reason_better_price_uk |
|  | No longer needed | ecom_order_unpaid_canceled_reason_no_longer_needed_uk |
|  | Other | ecom_order_unpaid_canceled_reason_other_uk |
|  | Discount not as expected | ecom_order_to_ship_canceled_reason_discount_not_expected_uk |
|  | High delivery costs | ecom_order_to_ship_canceled_reason_high_delivery_costs_uk |
| ON_HOLD and AWAITING_SHIPMENT   | No longer needed | ecom_order_to_ship_canceled_reason_no_longer_needed_uk |
|  | Need to change payment method | ecom_order_to_ship_canceled_reason_change_payment_method_uk |
|  | Discount not as expected | ecom_order_to_ship_canceled_reason_discount_not_expected_uk |
|  | Order created by mistake | ecom_order_to_ship_canceled_reason_created_by_mistakes_uk |
|  | High delivery costs | ecom_order_to_ship_canceled_reason_high_delivery_costs_uk |
|  | Better price available | ecom_order_to_ship_canceled_reason_better_price_uk |
|  | Wrong delivery information | ecom_order_to_ship_canceled_reason_wrong_delivery_info_uk |
|  | Late shipment | buyer_cancel_late_shipment |
|  | Other | ecom_order_unpaid_canceled_reason_other_uk |

#### Seller Reject Cancel Request Reason
The reason the seller can use to reject the buyer's cancel request
| **Seller available Reject Cancel reason** | **Reason name** |
| --- | --- |
| Invalid reason for cancellation | order_manage_list_action_respond_popup_reject_reason_invalid_cancellation_reason_uk |
| Product delivery is on schedule | order_manage_list_action_respond_popup_reject_reason_delivered_uk |
| Reached an agreement with the buyer | order_manage_list_action_respond_popup_reject_reason_buyer_agree_uk |
| Product has been packed | seller_reject_apply_product_has_been_packed |

#### Seller Initiates Cancel Reason
The available reason of seller initiates cancel
| **Order Stauts** | **Seller available initiate cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID | Out of stock | seller_cancel_unpaid_reason_out_of_stock_uk |
|  | Pricing error | seller_cancel_unpaid_reason_wrong_price_uk |
|  | Buyer did not pay on time | seller_cancel_unpaid_reason_buyer_hasnt_paid_within_time_allowed_uk |
|  | Seller unable to fulfill order | seller_cancel_unpaid_reason_unable_to_fulfill_order |
| ON_HOLD and AWAITING_SHIPMENT   | Pricing error | seller_cancel_reason_wrong_price_uk |
|  | Unable to deliver to buyer address | seller_cancel_paid_reason_address_not_deliver_uk |
|  | Out of stock | seller_cancel_reason_out_of_stock_uk |
|  | Seller unable to fulfill order | seller_cancel_reason_unable_to_fulfill_order |

#### SYSTEM Cancel Reason
| **Cancel reason** | **Reason name** |
| --- | --- |
| Buyer payment overdue | system_cancel_unpaid_time_out_uk |
| Failed to pass risk review | system_cancel_anti_span_block_uk |
| Inbound failed | system_cancel_cross_border_entry_warehouse_failed_reason2_uk |
| Order cancelled by system | package_cancel_uk |
| Order cancelled by system | platform_cancel_uk |
| Package rejected | returned_to_shipper_refused_uk |
| Package delivery failed | returned_to_shipper_other_uk |
| Package damaged | package_damagaed_uk |
| Package lost | package_lost_uk |
| Late delivery | threepl_breach_uk |
| Package scrapped | package_scrap_uk |
| Automatically cancelled due to collection time out | system_cancel_order_reason_shipping_timeout_uk |
| This order has been automatically canceled as you didn't provide your delivery address. | system_cancel_add_address_overtime |
| Automatically cancelled due to untraceable tracking number | system_cancel_order_untracked_uk |
| Order canceled by the system | ecom_cb_sc_out_return |
| Buyer hasn't paid | ecom_order_unpaid_canceled_reason_not_want_pay |

#### Operator Cancel
| **Cancel reason** | **Reason name** |
| --- | --- |
| We have identified a risk involved with your order and cancelled your order for safety reasons to protect your transaction. | system_cancel_order_reason_potential_fraud |
| Order canceled by system. | system_cancel_order_reason_experience_related |
| Failed to pass risk review | operator_cancel_risk_control_block |
| As your product violates the platform's negative review policy, we canceled this transaction. We recommend you process the buyer's after-sales request.  | system_cancel_order_reason_nrr_related |

### ID market
#### Buyer Initiates Cancel Reason
The following reason is available for buyers when they initiate cancel request.
| **Order Stauts** | **Buyer available cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID   | Desired payment method not available | ecom_order_unpaid_canceled_reason_payment_method_not_available |
|  | Need to input/change coupon code | buyer_cancel_need_to_input/change_coupon_code |
|  | Wrong item variation (color, size, etc.) | buyer_cancel_wrong_item_variation_(colour,_size,_etc.) |
|  | Wrong delivery information | ecom_order_unpaid_canceled_reason_wrong_delivery_info |
|  | Order created by mistake | ecom_order_unpaid_canceled_reason_created_by_mistakes |
|  | Better price available | ecom_order_unpaid_canceled_reason_better_price |
|  | No longer needed | ecom_order_unpaid_canceled_reason_no_longer_needed |
|  | Other | ecom_order_unpaid_canceled_reason_other |
| ON_HOLD and AWAITING_SHIPMENT   | Need to change payment method | ecom_order_to_ship_canceled_reason_change_payment_method |
|  | Discount not as expected | ecom_order_to_ship_canceled_reason_discount_not_expected |
|  | Order created by mistake | ecom_order_to_ship_canceled_reason_created_by_mistakes |
|  | High delivery costs | ecom_order_to_ship_canceled_reason_high_delivery_costs |
|  | Better price available | ecom_order_to_ship_canceled_reason_better_price |
|  | Wrong delivery information | ecom_order_to_ship_canceled_reason_wrong_delivery_info |
|  | Product wasn't shipped on time | ecom_order_to_ship_canceled_reason_not_shipped_on_time |

#### Seller Reject Cancel Request Reason
The reason the seller can use to reject the buyer's cancel request
| **Seller available Reject Cancel reason** | **Reason name** |
| --- | --- |
| Invalid reason for cancellation | order_manage_list_action_respond_popup_reject_reason_invalid_cancellation_reason |
| Product delivery is on schedule | order_manage_list_action_respond_popup_reject_reason_delivered |
| Reached an agreement with the buyer | order_manage_list_action_respond_popup_reject_reason_buyer_agree |
| Product has been packed | seller_reject_apply_product_has_been_packed |
| Order canceled by system | system_cancel_failed_due_to_tts |

#### Seller Initiates Cancel Reason
The available reason of seller initiates cancel
| **Order Stauts** | **Seller available initiate cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID | Out of stock | seller_cancel_unpaid_reason_out_of_stock |
|  | Pricing error | seller_cancel_unpaid_reason_wrong_price |
|  | Buyer did not pay on time | seller_cancel_unpaid_reason_buyer_hasnt_paid_within_time_allowed |
| ON_HOLD and AWAITING_SHIPMENT   | Out of stock | seller_cancel_reason_out_of_stock |
|  | Pricing error | seller_cancel_reason_wrong_price |
|  | Unable to deliver to buyer address | seller_cancel_paid_reason_address_not_deliver |
#### SYSTEM Cancel Reason
| **Cancel reason** | **Reason name** |
| --- | --- |
| Buyer payment overdue | system_cancel_unpaid_time_out |
| Failed to pass risk review | system_cancel_anti_span_block |
| Order cancelled by system | package_cancel |
| Order cancelled by system | platform_cancel |
| Package rejected | returned_to_shipper_refused |
| Package delivery failed | returned_to_shipper_other |
| Package damaged | package_damagaed |
| Package lost | package_lost |
| Late delivery | threepl_breach |
| Package scrapped | package_scrap |
| Automatically cancelled due to collection time out | system_cancel_order_reason_shipping_timeout |
| Automatically cancelled due to recharge time out | system_cancel_virtual_timeout |
| Top up failed | system_cancel_virtual_top_up_failed |
| Invalid phone number | system_cancel_virtual_phone_number_invalid |
| This order has been automatically canceled as you didn't provide your delivery address. | system_cancel_add_address_overtime |
| Order canceled by the system | ecom_cb_sc_out_return |
| Automatically cancelled due to untraceable tracking number | system_cancel_order_untracked |
| Buyer hasn't paid | ecom_order_unpaid_canceled_reason_not_want_pay |

#### Operator Cancel
| **Cancel reason** | **Reason name** |
| --- | --- |
| We have identified a risk involved with your order and cancelled your order for safety reasons to protect your transaction. | system_cancel_order_reason_potential_fraud |
| Order canceled by system. | system_cancel_order_reason_experience_related |
| Failed to pass risk review | operator_cancel_risk_control_block |
| As your product violates the platform's negative review policy, we canceled this transaction. We recommend you process the buyer's after-sales request.  | system_cancel_order_reason_nrr_related |

### MY market
#### Buyer Initiates Cancel Reason
The following reason is available for buyers when they initiate cancel request.
| **Order Stauts** | **Buyer available cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID   | Need to input/change coupon code | buyer_cancel_need_to_input/change_coupon_code |
|  | Wrong item variation (color, size, etc.) | buyer_cancel_wrong_item_variation_(colour,_size,_etc.) |
|  | Desired payment method not available | ecom_order_unpaid_canceled_reason_payment_method_not_available |
|  | Wrong delivery information | ecom_order_unpaid_canceled_reason_wrong_delivery_info |
|  | Order created by mistake | ecom_order_unpaid_canceled_reason_created_by_mistakes |
|  | Better price available | ecom_order_unpaid_canceled_reason_better_price |
|  | Other | ecom_order_unpaid_canceled_reason_other |
| ON_HOLD and AWAITING_SHIPMENT   | Need to change payment method | ecom_order_to_ship_canceled_reason_change_payment_method |
|  | Discount not as expected | ecom_order_to_ship_canceled_reason_discount_not_expected |
|  | Order created by mistake | ecom_order_to_ship_canceled_reason_created_by_mistakes |
|  | High delivery costs | ecom_order_to_ship_canceled_reason_high_delivery_costs |
|  | Better price available | ecom_order_to_ship_canceled_reason_better_price |
|  | Wrong delivery information | ecom_order_to_ship_canceled_reason_wrong_delivery_info |
|  | Product wasn't shipped on time | ecom_order_to_ship_canceled_reason_not_shipped_on_time |

#### Seller Reject Cancel Request Reason
| **Seller available Reject Cancel reason** | **Reason name** |
| --- | --- |
| Invalid reason for cancellation | order_manage_list_action_respond_popup_reject_reason_invalid_cancellation_reason |
| Product delivery is on schedule | order_manage_list_action_respond_popup_reject_reason_delivered |
| Reached an agreement with the buyer | order_manage_list_action_respond_popup_reject_reason_buyer_agree |
| Product has been packed | seller_reject_apply_product_has_been_packed |

#### Seller Initiates Cancel Reason
The available reason of seller initiates cancel
| **Order Stauts** | **Seller available initiate cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID | Out of stock | seller_cancel_unpaid_reason_out_of_stock |
|  | Pricing error | seller_cancel_unpaid_reason_wrong_price |
|  | Buyer did not pay on time | seller_cancel_unpaid_reason_buyer_hasnt_paid_within_time_allowed |
| ON_HOLD and AWAITING_SHIPMENT   | Out of stock | seller_cancel_reason_out_of_stock |
|  | Pricing error | seller_cancel_reason_wrong_price |
|  | Unable to deliver to buyer address | seller_cancel_paid_reason_address_not_deliver |

#### SYSTEM Cancel Reason
| **Seller available Reject Cancel reason** | **Reason name** |
| --- | --- |
| Buyer payment overdue | system_cancel_unpaid_time_out |
| Failed to pass risk review | system_cancel_anti_span_block |
| Order cancelled by system | package_cancel |
| Order cancelled by system | platform_cancel |
| Package rejected | returned_to_shipper_refused |
| Package delivery failed | returned_to_shipper_other |
| Package damaged | package_damagaed |
| Package lost | package_lost |
| Late delivery | threepl_breach |
| Package scrapped | package_scrap |
| Automatically cancelled due to collection time out | system_cancel_order_reason_shipping_timeout |
| Inbound failed | system_cancel_cross_border_entry_warehouse_failed_reason2 |
| This order has been automatically canceled as you didn't provide your delivery address. | system_cancel_add_address_overtime |
| Order canceled by the system | ecom_cb_sc_out_return |
| Automatically cancelled due to untraceable tracking number | system_cancel_order_untracked |
| Buyer hasn't paid | ecom_order_unpaid_canceled_reason_not_want_pay |

#### Operator Cancel
| **Seller available Reject Cancel reason** | **Reason name** |
| --- | --- |
| We have identified a risk involved with your order and cancelled your order for safety reasons to protect your transaction. | system_cancel_order_reason_potential_fraud |
| Order canceled by system. | system_cancel_order_reason_experience_related |
| Failed to pass risk review | operator_cancel_risk_control_block |
| As your product violates the platform's negative review policy, we canceled this transaction. We recommend you process the buyer's after-sales request.  | system_cancel_order_reason_nrr_related |

### PH market
#### Buyer Initiates Cancel Reason
The following reason is available for buyers when they initiate cancel request.
| **Order Stauts** | **Buyer available cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID   | Need to input/change coupon code | buyer_cancel_need_to_input/change_coupon_code |
|  | Wrong item variation (color, size, etc.) | buyer_cancel_wrong_item_variation_(colour,_size,_etc.) |
|  | Desired payment method not available | ecom_order_unpaid_canceled_reason_payment_method_not_available |
|  | Wrong delivery information | ecom_order_unpaid_canceled_reason_wrong_delivery_info |
|  | Order created by mistake | ecom_order_unpaid_canceled_reason_created_by_mistakes |
|  | Better price available | ecom_order_unpaid_canceled_reason_better_price |
|  | Other | ecom_order_unpaid_canceled_reason_other |
| ON_HOLD and AWAITING_SHIPMENT   | Need to change payment method | ecom_order_to_ship_canceled_reason_change_payment_method |
|  | Discount not as expected | ecom_order_to_ship_canceled_reason_discount_not_expected |
|  | Order created by mistake | ecom_order_to_ship_canceled_reason_created_by_mistakes |
|  | High delivery costs | ecom_order_to_ship_canceled_reason_high_delivery_costs |
|  | Better price available | ecom_order_to_ship_canceled_reason_better_price |
|  | Wrong delivery information | ecom_order_to_ship_canceled_reason_wrong_delivery_info |
|  | Product wasn't shipped on time | ecom_order_to_ship_canceled_reason_not_shipped_on_time |

#### Seller Reject Cancel Request Reason
The reason the seller can use to reject the buyer's cancel request
| **Seller available Reject Cancel reason** | **Reason name** |
| --- | --- |
| Invalid reason for cancellation | order_manage_list_action_respond_popup_reject_reason_invalid_cancellation_reason |
| Product delivery is on schedule | order_manage_list_action_respond_popup_reject_reason_delivered |
| Reached an agreement with the buyer | order_manage_list_action_respond_popup_reject_reason_buyer_agree |
| Product has been packed | seller_reject_apply_product_has_been_packed |

#### Seller Initiates Cancel Reason
The available reason of seller initiates cancel
| **Order Stauts** | **Seller available initiate cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID | Out of stock | seller_cancel_unpaid_reason_out_of_stock |
|  | Pricing error | seller_cancel_unpaid_reason_wrong_price |
|  | Buyer did not pay on time | seller_cancel_unpaid_reason_buyer_hasnt_paid_within_time_allowed |
|  | Buyer requested cancellation | seller_cancel_unpaid_reason_buyer_requested_cancellation |
| ON_HOLD and AWAITING_SHIPMENT   | Out of stock | seller_cancel_reason_out_of_stock |
|  | Pricing error | seller_cancel_reason_wrong_price |
|  | Unable to deliver to buyer address | seller_cancel_paid_reason_address_not_deliver |
|  | Buyer requested cancellation | seller_cancel_paid_reason_buyer_requested_cancellation |
#### SYSTEM Cancel Reason
| **Cancel reason** | **Reason name** |
| --- | --- |
| Buyer payment overdue | system_cancel_unpaid_time_out |
| Failed to pass risk review | system_cancel_anti_span_block |
| Order cancelled by system | package_cancel |
| Order cancelled by system | platform_cancel |
| Package rejected | returned_to_shipper_refused |
| Package delivery failed | returned_to_shipper_other |
| Package damaged | package_damagaed |
| Package lost | package_lost |
| Late delivery | threepl_breach |
| Package scrapped | package_scrap |
| Automatically cancelled due to collection time out | system_cancel_order_reason_shipping_timeout |
| Inbound failed | system_cancel_cross_border_entry_warehouse_failed_reason2 |
| This order has been automatically canceled as you didn't provide your delivery address. | system_cancel_add_address_overtime |
| Order canceled by the system | ecom_cb_sc_out_return |
| Automatically cancelled due to untraceable tracking number | system_cancel_order_untracked |
| Buyer hasn't paid | ecom_order_unpaid_canceled_reason_not_want_pay |

#### Operator Cancel
| **Cancel reason** | **Reason name** |
| --- | --- |
| We have identified a risk involved with your order and cancelled your order for safety reasons to protect your transaction. | system_cancel_order_reason_potential_fraud |
| Order canceled by system. | system_cancel_order_reason_experience_related |
| Failed to pass risk review | operator_cancel_risk_control_block |
| As your product violates the platform's negative review policy, we canceled this transaction. We recommend you process the buyer's after-sales request.  | system_cancel_order_reason_nrr_related |

### SG market
#### Buyer Initiates Cancel Reason
The following reason is available for buyers when they initiate cancel request.
| **Order Stauts** | **Buyer available cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID   | Need to input/change coupon code | buyer_cancel_need_to_input/change_coupon_code |
|  | Wrong item variation (color, size, etc.) | buyer_cancel_wrong_item_variation_(colour,_size,_etc.) |
|  | Desired payment method not available | ecom_order_unpaid_canceled_reason_payment_method_not_available |
|  | Wrong delivery information | ecom_order_unpaid_canceled_reason_wrong_delivery_info |
|  | Order created by mistake | ecom_order_unpaid_canceled_reason_created_by_mistakes |
|  | Better price available | ecom_order_unpaid_canceled_reason_better_price |
|  | Other | ecom_order_unpaid_canceled_reason_other |
| ON_HOLD and AWAITING_SHIPMENT   | Need to change payment method | ecom_order_to_ship_canceled_reason_change_payment_method |
|  | Discount not as expected | ecom_order_to_ship_canceled_reason_discount_not_expected |
|  | Order created by mistake | ecom_order_to_ship_canceled_reason_created_by_mistakes |
|  | High delivery costs | ecom_order_to_ship_canceled_reason_high_delivery_costs |
|  | Better price available | ecom_order_to_ship_canceled_reason_better_price |
|  | Wrong delivery information | ecom_order_to_ship_canceled_reason_wrong_delivery_info |
|  | Product wasn't shipped on time | ecom_order_to_ship_canceled_reason_not_shipped_on_time |

#### Seller Reject Cancel Request Reason
The reason the seller can use to reject the buyer's cancel request
| **Seller available Reject Cancel reason** | **Reason name** |
| --- | --- |
| Invalid reason for cancellation | order_manage_list_action_respond_popup_reject_reason_invalid_cancellation_reason |
| Product delivery is on schedule | order_manage_list_action_respond_popup_reject_reason_delivered |
| Reached an agreement with the buyer | order_manage_list_action_respond_popup_reject_reason_buyer_agree |
| Product has been packed | seller_reject_apply_product_has_been_packed |

#### Seller Initiates Cancel Reason
The available reason of seller initiates cancel
| **Order Stauts** | **Seller available initiate cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID | Out of stock | seller_cancel_unpaid_reason_out_of_stock |
|  | Pricing error | seller_cancel_unpaid_reason_wrong_price |
| ON_HOLD and AWAITING_SHIPMENT   | Out of stock | seller_cancel_reason_out_of_stock |
|  | Pricing error | seller_cancel_reason_wrong_price |
|  | Unable to deliver to buyer address | seller_cancel_unable_to_deliver_to_buyer_address |

#### SYSTEM Cancel Reason
| **Cancel reason** | **Reason name** |
| --- | --- |
| Buyer payment overdue | system_cancel_unpaid_time_out |
| Failed to pass risk review | system_cancel_anti_span_block |
| Order cancelled by system | package_cancel |
| Order cancelled by system | platform_cancel |
| Package rejected | returned_to_shipper_refused |
| Package delivery failed | returned_to_shipper_other |
| Package damaged | package_damagaed |
| Package lost | package_lost |
| Late delivery | threepl_breach |
| Package scrapped | package_scrap |
| Automatically cancelled due to collection time out | system_cancel_order_reason_shipping_timeout |
| Inbound failed | system_cancel_cross_border_entry_warehouse_failed_reason2 |
| This order has been automatically canceled as you didn't provide your delivery address. | system_cancel_add_address_overtime |
| Order canceled by the system | ecom_cb_sc_out_return |
| Automatically cancelled due to untraceable tracking number | system_cancel_order_untracked |
| Buyer hasn't paid | ecom_order_unpaid_canceled_reason_not_want_pay |

#### Operator Cancel
| **Cancel reason** | **Reason name** |
| --- | --- |
| We have identified a risk involved with your order and cancelled your order for safety reasons to protect your transaction. | system_cancel_order_reason_potential_fraud |
| Order canceled by system. | system_cancel_order_reason_experience_related |
| Failed to pass risk review | operator_cancel_risk_control_block |
| As your product violates the platform's negative review policy, we canceled this transaction. We recommend you process the buyer's after-sales request.  | system_cancel_order_reason_nrr_related |

### TH market
#### Buyer Initiates Cancel Reason
The following reason is available for buyers when they initiate cancel request.
| **Order Stauts** | **Buyer available cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID   | Wrong item variation (color, size, etc.) | buyer_cancel_wrong_item_variation_(colour,_size,_etc.) |
|  | Need to input/change coupon code | buyer_cancel_need_to_input/change_coupon_code |
|  | Desired payment method not available | ecom_order_unpaid_canceled_reason_payment_method_not_available |
|  | Wrong delivery information | ecom_order_unpaid_canceled_reason_wrong_delivery_info |
|  | Order created by mistake | ecom_order_unpaid_canceled_reason_created_by_mistakes |
|  | Better price available | ecom_order_unpaid_canceled_reason_better_price |
|  | No longer needed | ecom_order_unpaid_canceled_reason_no_longer_needed |
|  | Other | ecom_order_unpaid_canceled_reason_other |
| ON_HOLD and AWAITING_SHIPMENT   | Need to change payment method | ecom_order_to_ship_canceled_reason_change_payment_method |
|  | Discount not as expected | ecom_order_to_ship_canceled_reason_discount_not_expected |
|  | Order created by mistake | ecom_order_to_ship_canceled_reason_created_by_mistakes |
|  | High delivery costs | ecom_order_to_ship_canceled_reason_high_delivery_costs |
|  | Better price available | ecom_order_to_ship_canceled_reason_better_price |
|  | Wrong delivery information | ecom_order_to_ship_canceled_reason_wrong_delivery_info |
|  | Product wasn't shipped on time | ecom_order_to_ship_canceled_reason_not_shipped_on_time |
|  | No longer needed | ecom_order_to_ship_canceled_reason_no_longer_needed |

#### Seller Reject Cancel Request Reason
The reason the seller can use to reject the buyer's cancel request
| **Seller available Reject Cancel reason** | **Reason name** |
| --- | --- |
| Invalid reason for cancellation | order_manage_list_action_respond_popup_reject_reason_invalid_cancellation_reason |
| Product delivery is on schedule | order_manage_list_action_respond_popup_reject_reason_delivered |
| Reached an agreement with the buyer | order_manage_list_action_respond_popup_reject_reason_buyer_agree |
| Product has been packed | seller_reject_apply_product_has_been_packed |

#### Seller Initiates Cancel Reason
The available reason of seller initiates cancel
| **Order Stauts** | **Seller available initiate cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID | Out of stock | seller_cancel_unpaid_reason_out_of_stock |
|  | Pricing error | seller_cancel_unpaid_reason_wrong_price |
|  | Buyer did not pay on time | seller_cancel_unpaid_reason_buyer_hasnt_paid_within_time_allowed |
| ON_HOLD and AWAITING_SHIPMENT   | Out of stock | seller_cancel_reason_out_of_stock |
|  | Pricing error | seller_cancel_reason_wrong_price |
|  | Unable to deliver to buyer address | seller_cancel_paid_reason_address_not_deliver |

#### SYSTEM Cancel Reason
| **Cancel reason** | **Reason name** |
| --- | --- |
| Buyer payment overdue | system_cancel_unpaid_time_out |
| Failed to pass risk review | system_cancel_anti_span_block |
| Order cancelled by system | package_cancel |
| Order cancelled by system | platform_cancel |
| Package rejected | returned_to_shipper_refused |
| Package delivery failed | returned_to_shipper_other |
| Package damaged | package_damagaed |
| Package lost | package_lost |
| Late delivery | threepl_breach |
| Package scrapped | package_scrap |
| Automatically cancelled due to collection time out | system_cancel_order_reason_shipping_timeout |
| Inbound failed | system_cancel_cross_border_entry_warehouse_failed_reason2 |
| This order has been automatically canceled as you didn't provide your delivery address. | system_cancel_add_address_overtime |
| Order canceled by the system | ecom_cb_sc_out_return |
| Automatically cancelled due to untraceable tracking number | system_cancel_order_untracked |
| Buyer hasn't paid | ecom_order_unpaid_canceled_reason_not_want_pay |

#### Operator Cancel
| **Cancel reason** | **Reason name** |
| --- | --- |
| We have identified a risk involved with your order and cancelled your order for safety reasons to protect your transaction. | system_cancel_order_reason_potential_fraud |
| Order canceled by system. | system_cancel_order_reason_experience_related |
| Failed to pass risk review | operator_cancel_risk_control_block |
| As your product violates the platform's negative review policy, we canceled this transaction. We recommend you process the buyer's after-sales request.  | system_cancel_order_reason_nrr_related |

### VN market
#### Buyer Initiates Cancel Reason
The following reason is available for buyers when they initiate cancel request.
| **Order Stauts** | **Buyer available cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID   | Need to input/change coupon code | buyer_cancel_need_to_input/change_coupon_code |
|  | Wrong item variation (color, size, etc.) | buyer_cancel_wrong_item_variation_(colour,_size,_etc.) |
|  | Desired payment method not available | ecom_order_unpaid_canceled_reason_payment_method_not_available |
|  | Wrong delivery information | ecom_order_unpaid_canceled_reason_wrong_delivery_info |
|  | Order created by mistake | ecom_order_unpaid_canceled_reason_created_by_mistakes |
|  | Better price available | ecom_order_unpaid_canceled_reason_better_price |
|  | Other | ecom_order_unpaid_canceled_reason_other |
| ON_HOLD and AWAITING_SHIPMENT   | Need to change payment method | ecom_order_to_ship_canceled_reason_change_payment_method |
|  | Discount not as expected | ecom_order_to_ship_canceled_reason_discount_not_expected |
|  | Order created by mistake | ecom_order_to_ship_canceled_reason_created_by_mistakes |
|  | High delivery costs | ecom_order_to_ship_canceled_reason_high_delivery_costs |
|  | Better price available | ecom_order_to_ship_canceled_reason_better_price |
|  | Wrong delivery information | ecom_order_to_ship_canceled_reason_wrong_delivery_info |
|  | Product wasn't shipped on time | ecom_order_to_ship_canceled_reason_not_shipped_on_time |

#### Seller Reject Cancel Request Reason
The reason the seller can use to reject the buyer's cancel request
| **Seller available Reject Cancel reason** | **Reason name** |
| --- | --- |
| Invalid reason for cancellation | order_manage_list_action_respond_popup_reject_reason_invalid_cancellation_reason |
| Product delivery is on schedule | order_manage_list_action_respond_popup_reject_reason_delivered |
| Reached an agreement with the buyer | order_manage_list_action_respond_popup_reject_reason_buyer_agree |
| Product has been packed | seller_reject_apply_product_has_been_packed |

#### Seller Initiates Cancel Reason
The available reason of seller initiates cancel
| **Order Stauts** | **Seller available initiate cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID | Out of stock | seller_cancel_unpaid_reason_out_of_stock |
|  | Pricing error | seller_cancel_unpaid_reason_wrong_price |
|  | Buyer did not pay on time | seller_cancel_unpaid_reason_buyer_hasnt_paid_within_time_allowed |
| ON_HOLD and AWAITING_SHIPMENT   | Out of stock | seller_cancel_reason_out_of_stock |
|  | Pricing error | seller_cancel_reason_wrong_price |
|  | Unable to deliver to buyer address | seller_cancel_paid_reason_address_not_deliver |

#### SYSTEM Cancel Reason
| **Cancel reason** | **Reason name** |
| --- | --- |
| Buyer payment overdue | system_cancel_unpaid_time_out |
| Failed to pass risk review | system_cancel_anti_span_block |
| Order cancelled by system | package_cancel |
| Order cancelled by system | platform_cancel |
| Package rejected | returned_to_shipper_refused |
| Package delivery failed | returned_to_shipper_other |
| Package damaged | package_damagaed |
| Package lost | package_lost |
| Late delivery | threepl_breach |
| Package scrapped | package_scrap |
| Automatically cancelled due to collection time out | system_cancel_order_reason_shipping_timeout |
| Inbound failed | system_cancel_cross_border_entry_warehouse_failed_reason2 |
| This order has been automatically canceled as you didn't provide your delivery address. | system_cancel_add_address_overtime |
| Order canceled by the system | ecom_cb_sc_out_return |
| Automatically cancelled due to untraceable tracking number | system_cancel_order_untracked |
| Buyer hasn't paid | ecom_order_unpaid_canceled_reason_not_want_pay |

#### Operator Cancel
| **Cancel reason** | **Reason name** |
| --- | --- |
| We have identified a risk involved with your order and cancelled your order for safety reasons to protect your transaction. | system_cancel_order_reason_potential_fraud |
| Order canceled by system. | system_cancel_order_reason_experience_related |
| Failed to pass risk review | operator_cancel_risk_control_block |
| As your product violates the platform's negative review policy, we canceled this transaction. We recommend you process the buyer's after-sales request.  | system_cancel_order_reason_nrr_related |

### MX Market
#### Buyer Initiates Cancel Reason
The following reason is available for buyers when they initiate cancel request.
| **Order Stauts** | **Buyer available cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID   | No longer needed | ecom_order_to_ship_canceled_reason_no_longer_needed |
|  | Bought by mistake | ecom_order_to_ship_canceled_reason_created_by_mistakes |
|  | Forgot to apply coupons | ecom_order_to_ship_canceled_reason_forgot_to_apply_coupons |
|  | Incorrect shipping address | ecom_order_to_ship_canceled_reason_wrong_delivery_info |
|  | Better price available | ecom_order_to_ship_canceled_reason_better_price |
| ON_HOLD and AWAITING_SHIPMENT   | No longer needed | ecom_order_to_ship_canceled_reason_no_longer_needed |
|  | Bought by mistake | ecom_order_to_ship_canceled_reason_created_by_mistakes |
|  | Forgot to apply coupons | ecom_order_to_ship_canceled_reason_forgot_to_apply_coupons |
|  | Incorrect shipping address | ecom_order_to_ship_canceled_reason_wrong_delivery_info |
|  | Item wasn't shipped on time | ecom_order_to_ship_canceled_reason_not_shipped_on_time |
|  | Better price available | ecom_order_to_ship_canceled_reason_better_price |

#### Seller Reject Cancel Request Reason
The reason the seller can use to reject the buyer's cancel request
| **Seller available Reject Cancel reason** | **Reason name** |
| --- | --- |
| Product shipped. Tracking updates will be available soon. | seller_reject_apply_product_has_been_packed |
| You have reached an agreement with the customer | reverse_reject_request_reason_5 |
| Unable to change address | seller_reject_apply_unable_to_change_address |

#### Seller Initiates Cancel Reason
The available reason of seller initiates cancel
| **Order Stauts** | **Seller available initiate cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID | Out of stock | seller_cancel_unpaid_reason_out_of_stock |
|  | Pricing error | seller_cancel_unpaid_reason_wrong_price |
|  | Customer did not pay on time | seller_cancel_unpaid_reason_buyer_hasnt_paid_within_time_allowed |
|  | Customer requested cancellation | seller_cancel_unpaid_reason_buyer_requested_cancellation |
| ON_HOLD and AWAITING_SHIPMENT   | Out of stock | seller_cancel_reason_out_of_stock |
|  | Customer requested cancellation | seller_cancel_paid_reason_buyer_requested_cancellation |
|  | Unable to deliver to customer address | seller_cancel_paid_reason_address_not_deliver |

#### SYSTEM Cancel Reason
| **Cancel reason** | **Reason name** |
| --- | --- |
| Customer overdue to pay | system_cancel_unpaid_time_out |
| Failed to pass risk review | system_cancel_anti_span_block |
| Inbound failed | system_cancel_cross_border_entry_warehouse_failed_reason2 |
| Order cancelled by system | package_cancel |
| Order cancelled by system | platform_cancel |
| Package rejected | returned_to_shipper_refused |
| Package delivery failed | returned_to_shipper_other |
| Package damaged | package_damagaed |
| Package lost | package_lost |
| Late delivery | threepl_breach |
| Package scrapped | package_scrap |
| Automatically canceled due to collection time out | system_cancel_order_reason_shipping_timeout |
| This order has been automatically canceled as you didn't provide your delivery address. | system_cancel_add_address_overtime |
| Automatically canceled due to untraceable tracking number | system_cancel_order_untracked |
| Order canceled by the system | ecom_cb_sc_out_return |
| Automatically canceled as not delivered within 30 days of estimated time of delivery | system_cancel_order_exceed_edt_not_arrive |
| Customer hasn't paid | ecom_order_unpaid_canceled_reason_not_want_pay |
| This order was canceled automatically as the customer's payment method could not be charged. | system_cancel_payment_capture_failed |
| This order was canceled automatically due to payment risk control interception. | system_cancel_payment_risk_review_failed |
| This order was canceled automatically due to inventory shortage. | system_cancel_create_valid_order_failed |

#### Operator Cancel
| **Cancel reason** | **Reason name** |
| --- | --- |
| We have identified a risk involved with your order and canceled your order for safety reasons to protect your transaction. | system_cancel_order_reason_potential_fraud |
| During our regular review, the order you placed was found to have potential issues that may result in an experience that doesn't meet our standards. To ensure you have a great shopping experience, we have proactively issued a full refund. | system_cancel_order_reason_experience_related |
| Failed to pass risk review | operator_cancel_risk_control_block |
| As your product violates the platform's negative review policy, we canceled this transaction. We recommend you process the customer's after-sales request.  | system_cancel_order_reason_nrr_related |

### BR Market
#### Buyer Initiates Cancel Reason
The following reason is available for buyers when they initiate cancel request.
| **Order Stauts** | **Buyer available cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID   | No longer needed | ecom_order_to_ship_canceled_reason_no_longer_needed |
|  | Bought by mistake | ecom_order_to_ship_canceled_reason_created_by_mistakes |
|  | Forgot to apply coupons | ecom_order_to_ship_canceled_reason_forgot_to_apply_coupons |
|  | Incorrect shipping address | ecom_order_to_ship_canceled_reason_wrong_delivery_info |
|  | Better price available | ecom_order_to_ship_canceled_reason_better_price |
| ON_HOLD and AWAITING_SHIPMENT   | No longer needed | ecom_order_to_ship_canceled_reason_no_longer_needed |
|  | Bought by mistake | ecom_order_to_ship_canceled_reason_created_by_mistakes |
|  | Forgot to apply coupons | ecom_order_to_ship_canceled_reason_forgot_to_apply_coupons |
|  | Incorrect shipping address | ecom_order_to_ship_canceled_reason_wrong_delivery_info |
|  | Item wasn't shipped on time | ecom_order_to_ship_canceled_reason_not_shipped_on_time |
|  | Better price available | ecom_order_to_ship_canceled_reason_better_price |

#### Seller Reject Cancel Request Reason
The reason the seller can use to reject the buyer's cancel request
| **Seller available Reject Cancel reason** | **Reason name** |
| --- | --- |
| Product shipped. Tracking updates will be available soon. | seller_reject_apply_product_has_been_packed |
| You have reached an agreement with the customer | reverse_reject_request_reason_5 |
| Unable to change address | seller_reject_apply_unable_to_change_address |

#### Seller Initiates Cancel Reason
The available reason of seller initiates cancel
| **Order Stauts** | **Seller available initiate cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID | Out of stock | seller_cancel_unpaid_reason_out_of_stock |
|  | Pricing error | seller_cancel_unpaid_reason_wrong_price |
|  | Customer did not pay on time | seller_cancel_unpaid_reason_buyer_hasnt_paid_within_time_allowed |
|  | Customer requested cancellation | seller_cancel_unpaid_reason_buyer_requested_cancellation |
| ON_HOLD and AWAITING_SHIPMENT   | Out of stock | seller_cancel_reason_out_of_stock |
|  | Customer requested cancellation | seller_cancel_paid_reason_buyer_requested_cancellation |
|  | Unable to deliver to customer address | seller_cancel_paid_reason_address_not_deliver |

#### SYSTEM Cancel Reason
| **Cancel reason** | **Reason name** |
| --- | --- |
| Customer overdue to pay | system_cancel_unpaid_time_out |
| Failed to pass risk review | system_cancel_anti_span_block |
| Inbound failed | system_cancel_cross_border_entry_warehouse_failed_reason2 |
| Order cancelled by system | package_cancel |
| Order cancelled by system | platform_cancel |
| Package rejected | returned_to_shipper_refused |
| Package delivery failed | returned_to_shipper_other |
| Package damaged | package_damagaed |
| Package lost | package_lost |
| Late delivery | threepl_breach |
| Package scrapped | package_scrap |
| Automatically canceled due to collection time out | system_cancel_order_reason_shipping_timeout |
| This order has been automatically canceled as you didn't provide your delivery address. | system_cancel_add_address_overtime |
| Automatically canceled due to untraceable tracking number | system_cancel_order_untracked |
| Order canceled by the system | ecom_cb_sc_out_return |
| Automatically canceled as not delivered within 30 days of estimated time of delivery | system_cancel_order_exceed_edt_not_arrive |
| Customer hasn't paid | ecom_order_unpaid_canceled_reason_not_want_pay |
| This order was canceled automatically as the customer's payment method could not be charged. | system_cancel_payment_capture_failed |
| This order was canceled automatically due to payment risk control interception. | system_cancel_payment_risk_review_failed |
| This order was canceled automatically due to inventory shortage. | system_cancel_create_valid_order_failed |

#### Operator Cancel
| **Cancel reason** | **Reason name** |
| --- | --- |
| We have identified a risk involved with your order and canceled your order for safety reasons to protect your transaction. | system_cancel_order_reason_potential_fraud |
| During our regular review, the order you placed was found to have potential issues that may result in an experience that doesn't meet our standards. To ensure you have a great shopping experience, we have proactively issued a full refund. | system_cancel_order_reason_experience_related |
| Failed to pass risk review | operator_cancel_risk_control_block |
| As your product violates the platform's negative review policy, we canceled this transaction. We recommend you process the customer's after-sales request.  | system_cancel_order_reason_nrr_related |

### ES/IE/FR/DE/IT Market
#### Buyer Initiates Cancel Reason
The following reason is available for buyers when they initiate cancel request.
| **Order Stauts** | **Buyer available cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID   | High delivery costs | ecom_order_to_ship_canceled_reason_high_delivery_costs |
|  | Discount not as expected | ecom_order_to_ship_canceled_reason_discount_not_expected |
|  | Seller is not responsive to my inquiries / seller requests to cancel | ecom_order_unpaid_canceled_reason_other |
|  | No longer needed | ecom_order_unpaid_canceled_reason_no_longer_needed |
| ON_HOLD and AWAITING_SHIPMENT   | No reason | ecom_order_delivered_refund_reason_none |
|  | Late shipment | buyer_cancel_late_shipment |
|  | Wrong delivery information | ecom_order_to_ship_canceled_reason_wrong_delivery_info |
|  | Better price available | ecom_order_to_ship_canceled_reason_better_price |
|  | High delivery costs | ecom_order_to_ship_canceled_reason_high_delivery_costs |
|  | Discount not as expected | ecom_order_to_ship_canceled_reason_discount_not_expected |
|  | Order created by mistake | ecom_order_to_ship_canceled_reason_created_by_mistakes |
|  | Seller is not responsive to my inquiries / seller requests to cancel | ecom_order_unpaid_canceled_reason_other |
|  | Need to change payment method | ecom_order_to_ship_canceled_reason_change_payment_method |
|  | No longer needed | ecom_order_unpaid_canceled_reason_no_longer_needed |

#### Seller Initiates Cancel Reason
The available reason of seller initiates cancel
| **Order Stauts** | **Seller available initiate cancel reason** | **Reason name** |
| --- | --- | --- |
| UNPAID | Out of stock | seller_cancel_unpaid_reason_out_of_stock |
|  | Pricing error | seller_cancel_unpaid_reason_wrong_price |
|  | Customer did not pay on time | seller_cancel_unpaid_reason_buyer_hasnt_paid_within_time_allowed |
|  | Customer requested cancellation | seller_cancel_unpaid_reason_buyer_requested_cancellation |
|  | Seller unable to fulfill order | seller_cancel_unpaid_reason_unable_to_fulfill_order |
| ON_HOLD and AWAITING_SHIPMENT   | Out of stock | seller_cancel_reason_out_of_stock |
|  | Pricing error | seller_cancel_reason_wrong_price |
|  | Unable to deliver to customer address | seller_cancel_paid_reason_address_not_deliver |
|  | Customer requested cancellation | seller_cancel_paid_reason_buyer_requested_cancellation |
|  | Seller unable to fulfill order | seller_cancel_reason_unable_to_fulfill_order |

#### SYSTEM Cancel Reason
| **Cancel reason** | **Reason name** |
| --- | --- |
| Customer overdue to pay | system_cancel_unpaid_time_out |
| Failed to pass risk review | system_cancel_anti_span_block |
| Inbound failed | system_cancel_cross_border_entry_warehouse_failed_reason2 |
| Order cancelled by system | package_cancel |
| Order cancelled by system | platform_cancel |
| Package rejected | returned_to_shipper_refused |
| Package delivery failed | returned_to_shipper_other |
| Package damaged | package_damagaed |
| Package lost | package_lost |
| Late delivery | threepl_breach |
| Package scrapped | package_scrap |
| Automatically canceled due to collection time out | system_cancel_order_reason_shipping_timeout |
| This order has been automatically canceled as you didn't provide your delivery address. | system_cancel_add_address_overtime |
| Automatically canceled due to untraceable tracking number | system_cancel_order_untracked |
| Order canceled by the system | ecom_cb_sc_out_return |
| Customer hasn't paid | ecom_order_unpaid_canceled_reason_not_want_pay |
| Automatically canceled as not delivered within 30 days of estimated time of delivery | system_cancel_order_exceed_edt_not_arrive |

#### Operator Cancel
| **Cancel reason** | **Reason name** |
| --- | --- |
| Failed to pass risk review | operator_cancel_risk_control_block |
| We have identified a risk involved with your order and canceled your order for safety reasons to protect your transaction. | system_cancel_order_reason_potential_fraud |
| During our regular review, the order you placed was found to have potential issues that may result in an experience that doesn't meet our standards. To ensure you have a great shopping experience, we have proactively issued a full refund. | system_cancel_order_reason_experience_related |
| As your product violates the platform's negative review policy, we canceled this transaction. We recommend you process the customer's after-sales request.  | system_cancel_order_reason_nrr_related |

### JP market
#### Buyer Initiates Cancel Reason
| **Order status** | **Buyer available Return reason** | **Reason name** |
| --- | --- | --- |
| AWAITING_COLLECTION  IN_TRANSIT  DELIVERED   | Order created by mistake | ecom_order_unpaid_canceled_reason_created_by_mistakes |
|  | Need to change payment method | ecom_order_unpaid_canceled_reason_payment_method_not_available_S |
|  | Need to use coupon | buyer_cancel_need_to_input/change_coupon_code |
|  | Need to change color or size | buyer_cancel_wrong_item_variation_(colour,_size,_etc.) |
|  | Need to change shipping address | ecom_order_unpaid_canceled_reason_wrong_delivery_info |
|  | Found better price | ecom_order_unpaid_canceled_reason_better_price |
|  | No longer need item | ecom_order_unpaid_canceled_reason_no_longer_needed |
|  | Seller not responsive | ecom_order_to_ship_canceled_reason_seller_no_response |
|  | Seller requested to cancel order | ecom_order_unpaid_canceled_reason_seller_ask_cancel |

#### Seller Initiates Cancel Reason
| **Order Stauts** | **Seller available initiate Return reason** | **Reason name** |
| --- | --- | --- |
| UNPAID | Pricing error | seller_cancel_unpaid_reason_wrong_price |
|  | Out of stock | seller_cancel_unpaid_reason_out_of_stock |
|  | Customer requested cancellation | seller_cancel_unpaid_reason_buyer_requested_cancellation |
|  | Customer did not pay on time | seller_cancel_unpaid_reason_buyer_hasnt_paid_within_time_allowed |
|  | Seller unable to fulfill order | seller_cancel_unpaid_reason_unable_to_fulfill_order |
| ON_HOLD and AWAITING_SHIPMENT   | Pricing error | seller_cancel_reason_wrong_price |
|  | Out of stock | seller_cancel_reason_out_of_stock |
|  | Customer requested cancellation | seller_cancel_paid_reason_buyer_requested_cancellation |
|  | Unable to deliver to customer address | seller_cancel_paid_reason_address_not_deliver |
|  | Order with high chance of cancellation / refund  | seller_cancel_order_reason_potential_fraud |
|  | Seller unable to fulfill order | seller_cancel_reason_unable_to_fulfill_order |

#### SYSTEM Cancel Reason
| **Cancel reason** | **Reason name** |
| --- | --- |
| Customer overdue to pay | system_cancel_unpaid_time_out |
| Failed to pass risk review | system_cancel_anti_span_block |
| Inbound failed | system_cancel_cross_border_entry_warehouse_failed_reason2 |
| Order cancelled by system | package_cancel |
| Order cancelled by system | platform_cancel |
| Package rejected | returned_to_shipper_refused |
| Package delivery failed | returned_to_shipper_other |
| Package damaged | package_damagaed |
| Package lost | package_lost |
| Late delivery | threepl_breach |
| Package scrapped | package_scrap |
| Automatically canceled due to collection time out | system_cancel_order_reason_shipping_timeout |
| This order has been automatically canceled as you didn't provide your delivery address. | system_cancel_add_address_overtime |
| Automatically canceled due to untraceable tracking number | system_cancel_order_untracked |
| Order canceled by the system | ecom_cb_sc_out_return |
| This order was automatically canceled because it wasn't delivered within the estimated delivery time. | system_cancel_order_exceed_edt_not_arrive |
| Customer hasn't paid | ecom_order_unpaid_canceled_reason_not_want_pay |
| This order was canceled automatically as the customer's payment method could not be charged. | system_cancel_payment_capture_failed |
| This order was canceled automatically due to payment risk control interception. | system_cancel_payment_risk_review_failed |
| This order was canceled automatically due to inventory shortage. | system_cancel_create_valid_order_failed |
| Certificate not uploaded | system_cancel_order_reason_coa_upload_more_than_24hrs |
| Unable to verify certificate | system_cancel_order_reason_coa_2nd_upload_rejected |
| Unable to authenticate | system_cancel_order_reason_coa_rejected_fraud |
| Verification timed out | system_cancel_order_reason_coa_moderation_more_than_12hrs |
| The packaging or shipping failed to meet standards due to incorrect labeling, postage issues, third-party fulfillment problems, or weight discrepancies. | system_cancel_unpaid_postage |
| Package delivery failed | early_refund_returned_to_shipper |

#### Operator Cancel
| **Cancel reason** | **Reason name** |
| --- | --- |
| We have identified a risk involved with your order and canceled your order for safety reasons to protect your transaction. | system_cancel_order_reason_potential_fraud |
| During our regular review, the order you placed was found to have potential issues that may result in an experience that doesn't meet our standards. To ensure you have a great shopping experience, we have proactively issued a full refund. | system_cancel_order_reason_experience_related |
| Failed to pass risk review | operator_cancel_risk_control_block |
| As your product violates the platform's negative review policy, we canceled this transaction. We recommend you process the customer's after-sales request.  | system_cancel_order_reason_nrr_related |


---

## Get Reject Reasons — `GET /return_refund/202309/reject_reasons`

Doc: https://partner.tiktokshop.com/docv2/page/get-reject-reasons-202309 · cập nhật 2026-05-01 · scope: seller.return_refund.basic

### Path: /return_refund/202309/reject_reasons
### Method: [GET]
### Function Description
Use this API to retrieve the seller reject-reason options currently applicable to the specified aftersales request. Use the returned name value as the reject reason key when calling the corresponding seller reject API.

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
| locale | string | N | en-US | The BCP-47 locale codes for displaying the rejection reason, delimited by commas. Default: en-US |
| Refer to [Locale codes](678e3a47bae28f030a8c7523) for the list of supported locale codes. |  |  |  |  |
| return_or_cancel_id | string | Y | 4035319218955782461 | The unique identifier for an order return or cancellation. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202309/reject_reasons?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&locale=en-US&return_or_cancel_id=4035319218955782461
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^reasons | []object |  | The list of rejection reasons the seller has provided. |
| ^^name | string | seller_reject_apply_you_have_reached_an_agreement_with_the_buyer | The reject reason key. Pass this exact value to the corresponding seller reject API as the reject reason. Note: The available reject reasons may change depending on the current aftersales request context. To avoid using stale or inapplicable reason keys, call this API close to the reject action and use the latest returned name values instead of hardcoding them. |
| ^^text | string | You have reached an agreement with the buyer | The corresponding text to the reason name, localized based on the locale input parameter. |
### Response Sample
```json
{"code":0,"data":{"reasons":[{"name":"seller_reject_apply_you_have_reached_an_agreement_with_the_buyer","text":"You have reached an agreement with the buyer"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Approve Return — `POST /return_refund/202309/returns/{return_id}/approve`

Doc: https://partner.tiktokshop.com/docv2/page/approve-return-202309 · cập nhật 2026-10-13 · scope: seller.return_refund.basic

### Path: /return_refund/202309/returns/{return_id}/approve
### Method: [POST]
### Function Description
Use this API to approve a buyer's return request. The exact effect depends on the return type and return status. Before calling this API, make sure the return is still awaiting a seller action that matches the decision you are sending.

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
| return_id | string | Y | 4035319218955782461 | The unique identifier of the return request to be approved by the seller. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| idempotency_key | string | N | 40b456b1-78e7-412d-9fe6-82181496e1bd | A unique value generated by the client that the server uses to recognize repeated requests. Reuse the same key when retrying the same request. If omitted, the server generates a key for that call. You may use a UUID or another random string with enough entropy to avoid collisions. Maximum length: 255 characters. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| decision | string | Y | APPROVE_REFUND | Seller's decision for the return request, available values: |

* `APPROVE_REFUND`: seller approve a refund-only request
* `APPROVE_RETURN`: seller approve the initial return-and-refund request
* `APPROVE_RECEIVED_PACKAGE`: seller approve return-and-refund request after the buyer has already shipped or handed over the item.
* `APPROVE_REPLACEMENT`: seller approve replacement request
* `ISSUE_REPLACEMENT_REFUND`: seller decline the replacement request and directly refund the buyer instead.
* `OFFER_PARTIAL_REFUND`: seller offers a partial refund amount to the buyer without requiring the item(s) to be returned.
* `DIRECT_REFUND`: seller issues a returnless refund, meaning the buyer receives a full refund and keeps the item |
   buyer_keep_item |bool |N |true |**Optional**. Use this field only when decision is set to `APPROVE_RETURN`. If set to `true`, the seller issues a returnless refund, which means the buyer receives a full refund and keeps the item. If set to `false` or omitted, the seller approves the return-and-refund flow and the buyer returns the item. |
   partial_refund |object |N | |**Required** when `decision` is set to `OFFER_PARTIAL_REFUND`. When `partial_refund` is provided, both `amount` and `currency` are required. Omit this field for all other decisions. |
   ^currency |string |N |IDR |Refund currency must match the currency of the current return request. |
   ^amount |string |N |10 |The partial refund amount seller would like to offer to the buyer |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202309/returns/4035319218955782461/approve?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&idempotency_key=40b456b1-78e7-412d-9fe6-82181496e1bd
```

**Body**
```json
{"decision":"APPROVE_REFUND","buyer_keep_item":true,"partial_refund":{"currency":"IDR","amount":"10"}}
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
| 11050001 | invalid param |
| 25001001 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 25001003 | Invalid order status. |
| 25001028 | reverse lock failed |
| 25001044 | ConfirmReceive fulfillment order failed |
| 25001058 | reverse downstream data load error |
| 25007006 | Order not found. |
| 25007007 | ReverseOrderExistNegotiate |
| 25011010 | request has been transferred to platform operator |
| 25011012 | reverse status cannot approve application |
| 25011013 | reverse status cannot approve receive |
| 25011023 | forbid process authentic guarantee order |
| 25011026 | forbid process receive for FBT order |
| 25011032 | ReverseInvalidStatusPartialRefund |
| 25020004 | decision not match reverse type |
| 25020005 | No permission to process this order |
| 25020008 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 25020009 | reverse already cancelled |


---

## Get Return Records — `GET /return_refund/202309/returns/{return_id}/records`

Doc: https://partner.tiktokshop.com/docv2/page/get-return-records-202309 · cập nhật 2026-10-13 · scope: seller.return_refund.basic

### Path: /return_refund/202309/returns/{return_id}/records
### Method: [GET]
### Function Description
Use this API to retrieve the record entries for a specific return request. Each item in data.records represents an action or lifecycle event for the specified return_id.

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
| return_id | string | Y | 4035318504086604100 | A unique identifier for a TikTok Shop return request. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| locale | string | N | en-US | The BCP-47 locale codes for displaying the return reason, delimited by commas. Default: en-US |
| Refer to [Locale codes](678e3a47bae28f030a8c7523) for the list of supported locale codes. |  |  |  |  |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202309/returns/4035318504086604100/records?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&locale=en-US
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^records | []object |  | A list of return records. |
| ^^event | string | ORDER_RETURN | The event type that represents which lifecycle event this record describes. It can vary depending on the current status and the return flow of the request, including the initial request, seller actions, shipment events, and timeout or system events. |
| ^^role | string | BUYER | The actor that initiated this lifecycle event. Possible values: |

* `BUYER`
* `SELLER`
* `OPERATOR`: The action was triggered manually by a customer service agent.
* `SYSTEM`: The action was triggered automatically due to a policy reason. |
   ^^description |string |Customer submitted a return request |A human-readable description of this lifecycle event. |
   ^^reason_text |string |Wrong product was sent |The corresponding text for a return reason, localized based on the locale input parameter. |
   ^^note |string |Reach an agreement with the buyer |A note associated with the return record. Use role to identify the actor for the event. |
   ^^images |[]object | |Images provided by the seller or buyer. You can use the role field to differentiate whether the images are from the seller or buyer. |
   ^^^url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447 |URL of the image. |
   ^^^width |int |200 |The width of image.
   Unit: px |
   ^^^height |int |200 |The height of image.
   Unit: px |
   ^^videos |[]object | |Videos uploaded by the buyer. Only buyers are allowed to upload videos. |
   ^^^url |string |https://v16m-default.akamaized.net/1e26046c3df91cd008d2ababba9445e2/65005d33/video/tos/maliva/tos-maliva-v-d8ca36-us/oQVCbIQemDpQxI9lHsg9IXQAb7mwgBabababab |Video URL. |
   ^^^cover |string |https://p16-oec-va.ibyteimg.com/musically-maliva-obj/998d0381960bda1ef272f4a7724cf5ed~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405489 |Video thumbnail image. |
   ^^^width |int |200 |Video image width.
   Unit: px |
   ^^^height |int |200 |Video image height.
   Unit: px |
   ^^^duration_millis |int |3000 |Video duration.
   Unit: milliseconds |
   ^^create_time |int |1690532213 |The Unix timestamp, in seconds, when this record entry was created. |

### Response Sample
```json
{"code":0,"data":{"records":[{"event":"ORDER_RETURN","role":"BUYER","description":"Customer submitted a return request","reason_text":"Wrong product was sent","note":"Reach an agreement with the buyer","images":[{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447","width":200,"height":200}],"videos":[{"url":"https://v16m-default.akamaized.net/1e26046c3df91cd008d2ababba9445e2/65005d33/video/tos/maliva/tos-maliva-v-d8ca36-us/oQVCbIQemDpQxI9lHsg9IXQAb7mwgBabababab","cover":"https://p16-oec-va.ibyteimg.com/musically-maliva-obj/998d0381960bda1ef272f4a7724cf5ed~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405489","width":200,"height":200,"duration_millis":3000}],"create_time":1690532213}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Approve Cancellation — `POST /return_refund/202309/cancellations/{cancel_id}/approve`

Doc: https://partner.tiktokshop.com/docv2/page/approve-cancellation-202309 · cập nhật 2026-10-13 · scope: seller.return_refund.basic

### Path: /return_refund/202309/cancellations/{cancel_id}/approve
### Method: [POST]
### Function Description
Use this API to approve a buyer-initiated cancellation request identified by cancel_id. Call this API only when the cancellation request is still waiting for seller action.

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
| cancel_id | string | Y | 98001001 | The cancellation request ID to approve. Use the `cancel_id` returned by Search Cancellations. Do not pass the order ID here. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| idempotency_key | string | N | 40b456b1-78e7-412d-9fe6-82181496e1bd | The idempotency key is a unique value generated by the client which the server uses to recognize a request. |
If you retry the same cancellation approval request, use the same key. If this parameter is omitted, the server generates an idempotency key for the request.
You may choose your own method of creating unique keys. We suggest using UUIDs, or another random string with enough entropy, to avoid collisions.
Idempotency keys can be up to 255 characters long. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202309/cancellations/98001001/approve?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&idempotency_key=40b456b1-78e7-412d-9fe6-82181496e1bd
```

**Body**
```json
{}
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
| 11050001 | invalid param |
| 25001001 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 25001003 | Invalid order status. |
| 25001028 | reverse lock failed |
| 25001045 | The order has already been shipped and we are unable to cancel shipment with the courier. |
| 25001058 | reverse downstream data load error |
| 25007002 | db access error |
| 25007006 | Order not found. |
| 25011012 | reverse status cannot approve application |
| 25020003 | decision not match reverse status |
| 25020004 | decision not match reverse type |
| 25020005 | No permission to process this order |
| 25020009 | reverse already cancelled |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Reject Cancellation — `POST /return_refund/202309/cancellations/{cancel_id}/reject`

Doc: https://partner.tiktokshop.com/docv2/page/reject-cancellation-202309 · cập nhật 2026-10-13 · scope: seller.return_refund.basic

### Path: /return_refund/202309/cancellations/{cancel_id}/reject
### Method: [POST]
### Function Description
Use this API to reject a buyer's cancellation request for the specified cancel_id. Before calling this API, make sure the request is still in a state where seller rejection is currently allowed.

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
| cancel_id | string | Y | 4035319218955782461 | The cancellation request ID to reject. Use the `cancel_id` returned by Search Cancellations. Do not pass the order ID here. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| idempotency_key | string | N | 40b456b1-78e7-412d-9fe6-82181496e1bd | The idempotency key is a unique value generated by the client that the server uses to recognize the same request. Reuse the same key for every retry of that request. If you omit this parameter, the server generates a key for the individual request. You may choose your own method of creating unique keys. We suggest using UUIDs, or another random string with enough entropy, to avoid collisions. Idempotency keys can be up to 255 characters long. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| reject_reason | string | Y | seller_reject_apply_product_has_been_packed | Seller's reason for rejecting the buyer's order cancellation request. Use the [Get Decision Eligibility](https://partner.tiktokshop.com/docv2/page/69844a11eeba77049695c7f6) endpoint to retrieve the currently available rejection reasons for the same cancellation request, and submit the returned rejection reason name in this field. |
| comment | string | N | I have packed the products before cancellation request | Seller's comment on rejection decision. This is where a seller will provide more information about rejecting the request. |
| images | []object | N |  | List of images provided by the seller to support seller's decision to reject the order cancellation request. |
| ^image_id | string | Y | tos-maliva-i-o3syd03w52-us/57a1c8908fe74572861ea5e50887d8d1 | Image ID. |
| ^mime_type | string | N | image/png | MIME type. |
| ^height | int | N | 200 | Image height. |
| Unit: px |  |  |  |  |
| ^width | int | N | 200 | Image width. |
| Unit: px |  |  |  |  |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202309/cancellations/4035319218955782461/reject?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&idempotency_key=40b456b1-78e7-412d-9fe6-82181496e1bd
```

**Body**
```json
{"reject_reason":"seller_reject_apply_product_has_been_packed","comment":"I have packed the products before cancellation request","images":[{"image_id":"tos-maliva-i-o3syd03w52-us/57a1c8908fe74572861ea5e50887d8d1","mime_type":"image/png","height":200,"width":200}]}
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
| 11050001 | invalid param |
| 25001001 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 25001003 | Invalid order status. |
| 25001014 | Unknown return reason. Please ensure you are passing a valid return reason. |
| 25001016 | reverse reason not match action type |
| 25001020 | The provided return reason is currently offline. Please select a different return reason. |
| 25001028 | reverse lock failed |
| 25001057 | reverse reason not match reason type |
| 25001058 | reverse downstream data load error |
| 25007006 | Order not found. |
| 25011011 | reverse status cannot reject application |
| 25020003 | decision not match reverse status |
| 25020004 | decision not match reverse type |
| 25020005 | No permission to process this order |
| 25020010 | Aftersales has been approved and cannot be rejected. |


---

## Upload Return Shipping Information — `POST /return_refund/202405/returns/shipping_documents`

Doc: https://partner.tiktokshop.com/docv2/page/upload-return-shipping-information-202405 · cập nhật 2026-10-28 · scope: seller.return_refund.basic

### Path: /return_refund/202405/returns/shipping_documents
### Method: [POST]
### Function Description
Use this API to upload return shipping documents, tracking numbers, and carriers for buyers.

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
| return_ids | []string | Y | 4035309948547270559 | The identifier of a specific return. |
| return_id_type | string | N | RMA | Specifies what kind of ID type was passed in the related return_ids field. (If the id type is not specified, the default value will be SKU_RETURN_ORDER.) |
| Possible values: |  |  |  |  |

* RMA
* SKU_RETURN_ORDER |

### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| return_shipping_label | file | N |  | Return shipping label. |
| return_qr_code | file | N |  | Return QR code. |
|  |  |  |  |  |
| tracking_number | string | Y | TTHERMES2882481596119090868 | The return shipping tracking number provided by the seller to the buyer. |
|  |  |  |  |  |
| return_provider_id | string | Y | 6599541761693270018 | The return shipping provider ID provided by the seller to the buyer. |
|  |  |  |  |  |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202405/returns/shipping_documents?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&return_ids=4035309948547270559&return_id_type=RMA
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
| 25021022 | The return order has already uploaded the shipping document. Please do not upload it again. |
| 25021023 | Return document formatting error. Please check the document format, only PDFs can be uploaded. |
| 25023001 | Invalid return IDs. |
| 25023002 | Return ID does not belong to this seller. Please do not upload it again. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Decision Eligibility — `GET /return_refund/202601/decision_eligibility`

Doc: https://partner.tiktokshop.com/docv2/page/get-decision-eligibility-202601 · cập nhật 2026-10-13 · scope: seller.return_refund.basic

### Path: /return_refund/202601/decision_eligibility
### Method: [GET]
### Function Description
Use this API to evaluate which seller decisions are currently allowed for the specified aftersales request. The API returns one result per requested decision, including whether the decision is currently eligible and any rejection reasons that are applicable for an eligible reject decision.

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
| return_or_cancel_id | string | Y | 4035319218955782461 | The TikTok Shop return or cancellation request ID to evaluate. Pass the request identifier for the target cancellation, refund, return, or other supported aftersales flow. Do not pass an order ID or order line ID in this field. |
| check_decisions | []string | N | APPROVE_REFUND,REJECT_RETURN | The seller decisions to evaluate for the specified aftersales request. Possible Values: |

* `APPROVE_REQUEST_CANCEL`
* `APPROVE_REFUND`
* `APPROVE_RETURN`
* `APPROVE_RECEIVED_PACKAGE`
* `APPROVE_REPLACEMENT`
* `ISSUE_REPLACEMENT_REFUND`
* `DIRECT_REFUND`
* `REJECT_REQUEST_CANCEL`
* `REJECT_REFUND`
* `REJECT_RETURN`
* `REJECT_RECEIVED_PACKAGE`
* `REJECT_REPLACEMENT`
   -`ISSUE_EXCHANGE_REFUND`
   **Note:** When omitted, the API evaluates all supported seller decisions for the request and returns one result per decision. |
   locale |string |N |en-US |The BCP-47 locale codes for displaying the return reason, delimited by commas. Default: en-US
   Refer to [Locale codes](678e3a47bae28f030a8c7523) for the list of supported locale codes. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202601/decision_eligibility?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&return_or_cancel_id=4035319218955782461&check_decisions=APPROVE_REFUND,REJECT_RETURN&locale=en-US
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^decisions | []object |  | The seller-decision eligibility results for the specified aftersales request. |
| ^^decision | string | APPROVE_REFUND | One eligibility result for one evaluated seller decision. Possible Values: |

* `APPROVE_REQUEST_CANCEL`
* `APPROVE_REFUND`
* `APPROVE_RETURN`
* `APPROVE_RECEIVED_PACKAGE`
* `APPROVE_REPLACEMENT`
* `ISSUE_REPLACEMENT_REFUND`
* `DIRECT_REFUND`
* `REJECT_REQUEST_CANCEL`
* `REJECT_REFUND`
* `REJECT_RETURN`
* `REJECT_RECEIVED_PACKAGE`
* `REJECT_REPLACEMENT`
   -`ISSUE_EXCHANGE_REFUND` |
   ^^eligible |bool |true |Whether this seller decision is currently eligible for the specified aftersales request. `true` means eligible; `false` means ineligible. |
   ^^ineligible_code |int |25001001 |The reason code for an ineligible decision. This field is returned when eligible is false. |
   ^^ineligible_reason |string |the return is already completed, you can't approve again. |The reason for an ineligible decision. This field is returned when eligible is false. |
   ^^available_reject_reasons |[]object | |The reject reasons available for an eligible reject decision. Each reason includes a name and localized display text. |
   ^^^name |string |seller_reject_apply_product_has_been_packed |The machine-readable name of the rejection reason. |
   ^^^text |string |Product shipped. Tracking updates will be available soon. |The display text for the reject reason. |

### Response Sample
```json
{"code":0,"data":{"decisions":[{"decision":"APPROVE_REFUND","eligible":true,"ineligible_code":25001001,"ineligible_reason":"the return is already completed, you can't approve again.","available_reject_reasons":[{"name":"seller_reject_apply_product_has_been_packed","text":"Product shipped. Tracking updates will be available soon."}]}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Calculate Refund — `POST /return_refund/202602/refunds/calculate`

Doc: https://partner.tiktokshop.com/docv2/page/calculate-refund-202602 · cập nhật 2026-10-13 · scope: seller.return_refund.basic

### Path: /return_refund/202602/refunds/calculate
### Method: [POST]
### Function Description
Use this API to estimate the refundable amount for a cancellation, refund, or return-and-refund request. The estimate depends on the selected request_type, reason_name, and targeted items. If skus, order_line_item_ids, and order_line_list are all omitted, all order lines in the order are selected as inputs to the refund calculation. For return-and-refund scenarios, the estimate can also depend on the selected return shipping method.

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
| order_id | string | Y | 576469648086175911 | TikTok Shop order id. |
| request_type | string | Y | REFUND | Request type |

* CANCEL
* REFUND
* RETURN_AND_REFUND
   Note: different request types are used for different aftersales scenarios. Also, different request types might have different refund amounts, because the refund amount calculation policy is different. |
   shipment_type |string |N |PLATFORM |How buyer ships items to seller when in a return request, could be:
* `PLATFORM`
* `BUYER_ARRANGE` |
   handover_method |string |N |DROP_OFF |Which handover method buyer chooses to use when returning goods to seller by platform
* `DROP_OFF`: buyer drops off the parcel in logistics service collect point.
* `PICKUP`: logistics service picks up the buyer package. |
   reason_name |string |Y |ecom_order_delivered_refund_reason_missing_product_seller |Seller's reason for the selected cancellation, refund, or return-and-refund request. Use the [Get Aftersale Eligibility](https://partner.tiktokshop.com/docv2/page/69c3070c66dee40493fdfe2e) endpoint to retrieve the currently available reasons, and submit the returned reason name in this field. |
   order_line_item_ids |[]string |N |["576469648086306986"] |TikTok Shop order line item IDs to include in the refund calculation. Do not provide non-empty values in both `order_line_item_ids` and `order_line_list` in the same request. |
   skus |[]object |N | |skus |
   ^sku_id |string |Y |1729386416015578024 |TikTok Shop SKU ID to include in the refund calculation. |
   ^quantity |int |Y |1 |Quantity of this SKU to include in the refund calculation. |
   order_line_list |[]object |N | |Order lines to include in the refund calculation. Use this field when you need to identify individual sub-items in a bundle product. **Note:** This field is completely backward compatible with the previous `order_line_item_ids` field. Do not provide non-empty values in both `order_line_list` and `order_line_item_ids` in the same request. |
   ^order_line_item_id |string |N |576469648086306986 |The corresponding order line ID |
   ^sub_order_line_item_id |string |N |576469648086306987 |The sub-order-line ID inside a bundle product
* Required for bundle products
* Not required for non-bundle products |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202602/refunds/calculate?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"order_id":"576469648086175911","request_type":"REFUND","shipment_type":"PLATFORM","handover_method":"DROP_OFF","reason_name":"ecom_order_delivered_refund_reason_missing_product_seller","order_line_item_ids":["576469648086306986"],"skus":[{"sku_id":"1729386416015578024","quantity":1}],"order_line_list":[{"order_line_item_id":"576469648086306986","sub_order_line_item_id":"576469648086306987"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^order_refund_amount | object |  | Refund amount to buyer. |
| ^^currency | string | USD | Currency for payment. |
| ^^refund_total | string | 1.23 | Total amount refund to buyer. |
| ^^refund_subtotal | string | 1 | Subtotal amount included in the calculated refund. |
| ^^refund_shipping_fee | string | 0.2 | Shipping fee refund to buyer. |
| ^^refund_tax | string | 0.03 | Tax returned to buyer. |
| ^^retail_delivery_fee | string | 0.1 | Retail delivery fee takes effect once platform GMV exceeds 500,000 USD, according to US Colorado states' compliance rules. |
### Response Sample
```json
{"code":0,"data":{"order_refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1"}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 25001001 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 25007006 | Order not found. |


---

## Cancel Order — `POST /return_refund/202602/cancellations`

Doc: https://partner.tiktokshop.com/docv2/page/cancel-order-202602 · cập nhật 2026-10-28 · scope: seller.return_refund.basic

### Path: /return_refund/202602/cancellations
### Method: [POST]
### Function Description
Use this API to cancel an order on behalf of a seller. In the US and UK markets, when an item is out of stock, partial cancellation on the single item level is supported by this API.

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
| app_key | string | N | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | N | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | N | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_id | string | Y | 577087614418520388 | TikTok Shop order id |
| skus | []object | N |  | List of SKU to cancel |
| ^sku_id | string | Y | 1729386416015578024 | The SKU id to cancel |
| ^quantity | int | Y | 1 | The quantity of SKU to cancel |
| order_line_item_ids | []string | N | ["577087614418716996"] | List of order line item IDs to cancel. In the US and UK markets, when an item is out of stock, partial cancellation at the individual item level is supported. To initiate a partial cancellation, specify the item's order line ID. **Note:** This is a legacy field. For new integrations, use `order_line_list` instead. Do not provide non-empty values in both `order_line_item_ids` and `order_line_list` in the same request. |
| cancel_reason | string | Y | ecom_order_delivered_refund_and_return_reason_wrong_product_seller | Reason for canceling the order. To obtain a reason for this order, call `GET /return_refund/202602/orders/{order_id}/aftersale_eligibility` with the same `order_id`, `initiate_aftersale_user=SELLER`, and `request_types=CANCEL`. From the corresponding `data.sku_eligibility[].line_item_eligibility[]` result, pass an exact value from `available_reason_names` as `cancel_reason`. See "Return API Overview" for additional guidance on seller cancellation reasons. |
| order_line_list | []object | N |  | List of order lines or sub-order lines to cancel. In the US and UK markets, when an item is out of stock, partial cancellation at the individual item level is supported. **Note:** This field is completely backward compatible with the previous `order_line_item_ids` field. Do not provide non-empty values in both `order_line_list` and `order_line_item_ids` in the same request. |
| ^order_line_item_id | string | N | 576469648086306986 | The corresponding order line ID |
| ^sub_order_line_item_id | string | N | 576469648086306987 | The sub-order-line ID inside a bundle product |

* Required for bundle products
* Not required for non-bundle products |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202602/cancellations?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"order_id":"577087614418520388","skus":[{"sku_id":"1729386416015578024","quantity":1}],"order_line_item_ids":["577087614418716996"],"cancel_reason":"ecom_order_delivered_refund_and_return_reason_wrong_product_seller","order_line_list":[{"order_line_item_id":"576469648086306986","sub_order_line_item_id":"576469648086306987"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^cancel_id | string | 4035319218955782461 | The identifier of a specific order cancellation. |
| ^cancel_status | string | CANCELLATION_REQUEST_SUCCESS | The status of an order cancellation request. |
| Available values: |  |  |  |

* `CANCELLATION_REQUEST_PENDING`
* `CANCELLATION_REQUEST_SUCCESS`
* `CANCELLATION_REQUEST_CANCEL`
* `CANCELLATION_REQUEST_COMPLETE` |

### Response Sample
```json
{"code":0,"data":{"cancel_id":"4035319218955782461","cancel_status":"CANCELLATION_REQUEST_SUCCESS"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 25001001 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 25001011 | A return request is already in process, or the order has already been cancelled. |
| 25001014 | Unknown return reason. Please ensure you are passing a valid return reason. |
| 25001015 | The provided return reason cannot be used by the seller. Please select a valid return reason and try again. |
| 25001020 | The provided return reason is currently offline. Please select a different return reason. |
| 25001021 | Reason not match order status |
| 25001028 | reverse lock failed |
| 25001045 | The order has already been shipped and we are unable to cancel shipment with the courier. |
| 25001046 | Return request has failed due to an interception by TikTok risk control. |
| 25001051 | Not allowed to return or cancel since order is completed or cancelled |
| 25005010 | Unable to cancel individual line items within this request. |
| 25005011 | The requested line item(s) for return or refund exceeds the allowable limit. |
| 25020005 | No permission to process this order |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Create Return — `POST /return_refund/202602/returns`

Doc: https://partner.tiktokshop.com/docv2/page/create-return-202602 · cập nhật 2026-10-28 · scope: seller.fulfillment.basic, seller.return_refund.basic

### Path: /return_refund/202602/returns
### Method: [POST]
### Function Description
Use this API to create a seller-initiated aftersales request for an order on behalf of the buyer. Supported request types are `REFUND` and `RETURN_AND_REFUND`. Before submitting the request, confirm that the order is eligible for the selected aftersales type and return method. After the request is created, use the relevant search, status, or review API to continue the aftersales workflow.

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
| app_key | string | N | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | N | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | N | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| idempotency_key | string | N | 1623812664 | Idempotency Key |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_id | string | Y | 576473917261320779 | Tiktok Shop order id |
| skus | []object | N |  | Skus |
| ^sku_id | string | Y | 1729386416015578024 | Sku id seller wants to create a return request |
| ^quantity | int | Y | 1 | Quantity of this SKU to include in the return request. |
| order_line_item_ids | []string | N | ["455764739172614518516"] | Specifies the order line IDs to include in the return request. Use this field to select order lines when an order is split into multiple packages. Do not provide non-empty values in both `order_line_item_ids` and `order_line_list` in the same request. If `order_line_item_ids`, `order_line_list`, and `skus` are all omitted, all order lines in the order are included. **Note:** This is a legacy field; new integrations should use `order_line_list` instead. |
| return_reason | string | Y | ecom_order_delivered_refund_reason_missing_product_seller | Seller's reason to create a return |
| return_type | string | Y | REFUND | Which type to create: |

* REFUND
* RETURN_AND_REFUND |
   refund_total |string |N |10.5 |Total refund amount to the buyer.
   The total refund amount can not exceed the refundable amount |
   currency |string |N |USD |Currency of the refund amount. It should be the same as the currency of the TikTok Shop order. Required when `refund_total` is provided. |
   shipment_type |string |N |PLATFORM |Specifies the return shipping method the buyer uses to send items back to the seller in a return request. Supported values:
* `PLATFORM`
* `BUYER_ARRANGE` |
   handover_method |string |N |DROP_OFF |**Optional**. Only applicable when shipment_type is `PLATFORM`. Specifies the handover method the buyer uses to return the item through platform-supported shipping. Supported values:
* `DROP_OFF`
* `PICKUP` |
   order_line_list |[]object |N | |Specifies the line items to include in the return request and supports bundle order splitting. Every entry must include `order_line_item_id`. For a bundle sub-item, also include `sub_order_line_item_id`; omit `sub_order_line_item_id` for a normal order line. Do not mix normal order lines and bundle sub-items in the same request. **Note:** This field is completely backward compatible with the legacy `order_line_item_ids` field. |
   ^order_line_item_id |string |N |576469648086306986 |The corresponding order line ID |
   ^sub_order_line_item_id |string |N |576469648086306987 |The sub-order-line ID inside a bundle product
* Required for bundle products
* Not required for non-bundle products |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202602/returns?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&idempotency_key=1623812664
```

**Body**
```json
{"order_id":"576473917261320779","skus":[{"sku_id":"1729386416015578024","quantity":1}],"order_line_item_ids":["455764739172614518516"],"return_reason":"ecom_order_delivered_refund_reason_missing_product_seller","return_type":"REFUND","refund_total":"10.5","currency":"USD","shipment_type":"PLATFORM","handover_method":"DROP_OFF","order_line_list":[{"order_line_item_id":"576469648086306986","sub_order_line_item_id":"576469648086306987"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^return_id | string | 4035319218955782461 | The identifier of a specific return request. |
| ^return_status | string | RETURN_OR_REFUND_REQUEST_PENDING | Return status, available values: |

* RETURN_OR_REFUND_REQUEST_PENDING: Request is pending, needs to be approved by seller or platform
* REFUND_OR_RETURN_REQUEST_REJECT: Seller rejected the request
* AWAITING_BUYER_SHIP: Waiting buyer to ship items to seller, if exceed the deadline, request will be closed by platform
* BUYER_SHIPPED_ITEM: Buyer has shipped items to seller.
* REJECT_RECEIVE_PACKAGE: Seller reject return package
* RETURN_OR_REFUND_REQUEST_SUCCESS: The refund/return request is successful, buyer will be refunded.
* RETURN_OR_REFUND_REQUEST_CANCEL: The request has been cancelled by buyer or system
* RETURN_OR_REFUND_REQUEST_COMPLETE: The request is successful, and the amount has been refunded. |

### Response Sample
```json
{"code":0,"data":{"return_id":"4035319218955782461","return_status":"RETURN_OR_REFUND_REQUEST_PENDING"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 25001001 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 25001003 | Invalid order status. |
| 25001010 | A return request has already been completed, or the order has already been cancelled. |
| 25001011 | A return request is already in process, or the order has already been cancelled. |
| 25001014 | Unknown return reason. Please ensure you are passing a valid return reason. |
| 25001015 | The provided return reason cannot be used by the seller. Please select a valid return reason and try again. |
| 25001020 | The provided return reason is currently offline. Please select a different return reason. |
| 25001021 | Reason not match order status |
| 25001028 | reverse lock failed |
| 25001042 | Return package creation has failed due to internal error. |
| 25001046 | Return request has failed due to an interception by TikTok risk control. |
| 25001051 | Not allowed to return or cancel since order is completed or cancelled |
| 25005005 | Refund total amount is larger than the refundable amount. |
| 25005010 | Unable to cancel individual line items within this request. |
| 25005011 | The requested line item(s) for return or refund exceeds the allowable limit. |
| 25020005 | No permission to process this order |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Search Cancellations — `POST /return_refund/202602/cancellations/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-cancellations-202602 · cập nhật 2026-10-28 · scope: seller.return_refund.basic

### Path: /return_refund/202602/cancellations/search
### Method: [POST]
### Function Description
Use this API to search and retrieve one or more order cancellations.

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
| sort_field | string | N | update_time | The returned results will be sorted by the specified field. |
| **Default:** `create_time` |  |  |  |  |
| Possible values: |  |  |  |  |

* `create_time`
* `update_time`

Specify the order for sorting the returned results by using the sort_order parameter. |
sort_order |string |N |ASC |The sort order for the sort_field parameter.
**Default:** `ASC`
Possible values:

* `ASC`: Ascending order
* `DESC`: Descending order |
   page_size |string |N |10 |The number of results to be returned per page.
   **Default:** 10.
   Valid range: [1-50]. |
   page_token |string |N |aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA== |An opaque token used to retrieve the next page of a paginated result set. Retrieve this value from the result of the next_page_token from a previous response. It is not needed for the first page. |

### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| cancel_ids | []string | N | ["577087614418520388"] | List of order cancellations IDs. |
| order_ids | []string | N | ["577087614418520388"] | List of TikTok Shop order IDs. |
| buyer_user_ids | []string | N | ["7494845267308415300"] | List of TikTok Shop buyer user IDs. |
| cancel_types | []string | N | ["CANCEL"] | List of order cancellation types. |
| Possible values: |  |  |  |  |

* `CANCEL`: Cancel by seller or system.
* `BUYER_CANCEL`: Cancel by buyer. Need to be approved by seller or system. |
   cancel_status |[]string |N |["CANCELLATION_REQUEST_PENDING"] |List of order cancellation statuses.
   Possible values:
* `CANCELLATION_REQUEST_PENDING`
* `CANCELLATION_REQUEST_SUCCESS`
* `CANCELLATION_REQUEST_CANCEL`
* `CANCELLATION_REQUEST_COMPLETE`

Please see "API Overview" for more information about these statuses. |
create_time_ge |int |N |1690340825 |Filter cancellations to show only orders that have been created after a specified date and time. Unix timestamp. |
create_time_lt |int |N |1690340825 |Filter cancellations to show only orders that have been created before a specified date and time. Unix timestamp. |
update_time_ge |int |N |1690340825 |Filter cancellations to show only orders that have been updated after a specified date and time. Unix timestamp. |
update_time_lt |int |N |1690340825 |Filter cancellations to show only orders that have been updated before a specified date and time. Unix timestamp. |
locale |string |N |en-US |The BCP-47 locale codes for displaying the order, delimited by commas. Default: en-US
Refer to [Locale codes](678e3a47bae28f030a8c7523) for the list of supported locale codes. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202602/cancellations/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&sort_field=update_time&sort_order=ASC&page_size=10&page_token=aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA==
```

**Body**
```json
{"cancel_ids":["577087614418520388"],"order_ids":["577087614418520388"],"buyer_user_ids":["7494845267308415300"],"cancel_types":["CANCEL"],"cancel_status":["CANCELLATION_REQUEST_PENDING"],"create_time_ge":1690340825,"create_time_lt":1690340825,"update_time_ge":1690340825,"update_time_lt":1690340825,"locale":"en-US"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^cancellations | []object |  | List of order cancellations. |
| ^^order_id | string | 577087614418520388 | TikTok Shop order ID. |
| ^^cancel_type | string | CANCEL | Order cancellation type. |
| Possible values: |  |  |  |

* `CANCEL`: Cancel by seller or system.
* `BUYER_CANCEL`: Cancel by buyer. Need to be approved by seller or system. |
   ^^cancel_status |string |CANCELLATION_REQUEST_PENDING |Order cancellation status.
   Possible values:
* `CANCELLATION_REQUEST_PENDING`
* `CANCELLATION_REQUEST_SUCCESS`
* `CANCELLATION_REQUEST_CANCEL`
* `CANCELLATION_REQUEST_COMPLETE` |
   ^^role |string |BUYER |Order cancellation initiator.
   Possible values:
* `BUYER`
* `SELLER`
* `OPERATOR`
* `SYSTEM` |
   ^^cancel_reason |string |ecom_order_to_ship_canceled_reason_created_by_mistakes |Order cancellation reason. |
   ^^cancel_reason_text |string |Order created by mistake |Order cancellation reason, localized to another language.
   You can change language using the locale field in the request parameter. |
   ^^create_time |int |1690451136 |The time when the order cancellation was created. Unix timestamp in seconds. |
   ^^update_time |int |1690451136 |The time when the order cancellation was last updated. Unix timestamp in seconds. |
   ^^seller_next_action_response |[]object | |Seller's next action and deadline. |
   ^^^action |string |SELLER_RESPOND_BUYER_CANCEL |**Optional.** For buyer-initiated cancellation requests that still require seller handling, the action value is `SELLER_RESPOND_BUYER_CANCEL`. |
   ^^^deadline |int |1690554680 |Unix timestamp in seconds indicating the deadline for the seller to perform the next action. |
   ^^refund_amount |object | |Refund amount information. |
   ^^^currency |string |USD |Refund currency. |
   ^^^refund_total |string |1.23 |Total refund amount to the buyer. |
   ^^^refund_subtotal |string |1 |Subtotal refund amount to the buyer. |
   ^^^refund_shipping_fee |string |0.2 |Shipping fee refund amount to the buyer. |
   ^^^refund_tax |string |0.03 |Tax refund amount to the buyer. |
   ^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds $500,000 USD, according to Colorado (US) compliance rules. |
   ^^^buyer_service_fee |string |1000 |Only for the ID market. Platform will charge the buyer a service fee depending on the scenario. |
   ^^cancel_line_items |[]object | |Cancellation line items. |
   ^^^cancel_line_item_id |string |4035227913481196964 |Cancellation line item ID. |
   ^^^order_line_item_id |string |576468844534141348 |Order line item ID. |
   ^^^sku_id |string |2729382476852921560 |SKU ID. |
   ^^^sku_name |string |1#, Standard |SKU name. |
   ^^^product_image |object | |Product image object. Contains product image information. |
   ^^^^url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447 |Product image URL. |
   ^^^^width |int |200 |Product image width.
   Unit: px |
   ^^^^height |int |200 |Product image height.
   Unit: px |
   ^^^product_name |string |bundle No Heel Flat Heel Summer Winter Round Toe |Product name. |
   ^^^seller_sku |string |YYAPC23078TRT30 |SKU name defined by the seller. |
   ^^^refund_amount |object | |Refund amount information. |
   ^^^^currency |string |USD |Refund currency. |
   ^^^^refund_total |string |1.23 |Total refund amount to the buyer. |
   ^^^^refund_subtotal |string |1 |Subtotal refund amount to the buyer. |
   ^^^^refund_shipping_fee |string |0.2 |Shipping fee refund amount to the buyer. |
   ^^^^refund_tax |string |0.03 |Tax refund amount to the buyer. |
   ^^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds 500,000 USD, according to Colorado (US) compliance rules.
   |
   ^^^^buyer_service_fee |string |1000 |Only for the ID market. Platform will charge the buyer service fee depending on the scenario. |
   ^^^cancel_sub_line_items |[]object | |Cancellation sub line items.
   Sub items represent skus that belong to a "virtual bundle" that has been defined by a seller. The sub_items will include all relevant information about each item that is a part of the virtual bundle. |
   ^^^^cancel_sub_line_item_id |string |4035227657962164812 |Cancellation sub line item ID. |
   ^^^^cancel_line_item_id |string |4035227657962164811 |Cancellation line item ID. |
   ^^^^sub_order_line_item_id |string |576473917261451852 |Sub Order line item ID. |
   ^^^^order_line_item_id |string |576473917261451851 |Order line item ID. |
   ^^^^sku_id |string |2729382476852921560 |SKU ID. |
   ^^^^sku_name |string |1#, Standard |SKU name. |
   ^^^^product_image |object | |Product image object. Contains product image information. |
   ^^^^^url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447 |Product image URL. |
   ^^^^^width |int |200 |Product image width.
   Unit: px |
   ^^^^^height |int |200 |Product image height.
   Unit: px |
   ^^^^product_name |string |bundle No Heel Flat Heel Summer Winter Round Toe |Product name. |
   ^^^^seller_sku |string |YYAPC23078TRT30 |SKU name defined by the seller. |
   ^^^^refund_amount |object | |Refund amount information. |
   ^^^^^currency |string |USD |Refund currency. |
   ^^^^^refund_total |string |1.23 |Total refund amount to the buyer. |
   ^^^^^refund_subtotal |string |1 |Subtotal refund amount to the buyer. |
   ^^^^^refund_shipping_fee |string |0.2 |Shipping fee refund amount to the buyer. |
   ^^^^^refund_tax |string |0.03 |Tax refund amount to the buyer. |
   ^^^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds $500,000 USD, according to Colorado (US) compliance rules. |
   ^^^^^buyer_service_fee |string |1000 |Only for the ID market. Platform will charge the buyer a service fee depending on the scenario. |
   ^^cancel_id |string |4035318504086604100 |The identifier of a specific order cancellation. |
   ^^should_replenish_stock |bool |false |Should seller replenish the stock when order cancelled successfully. |
   ^total_count |int |100 |The number of cancellations that meet the query conditions. |
   ^next_page_token |string |aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA== |An opaque token used to retrieve the next page of results. If this value is non-empty, provide it in the `page_token` parameter of the next request. An empty value indicates that there are no more results. |

### Response Sample
```json
{"code":0,"data":{"cancellations":[{"order_id":"577087614418520388","cancel_type":"CANCEL","cancel_status":"CANCELLATION_REQUEST_PENDING","role":"BUYER","cancel_reason":"ecom_order_to_ship_canceled_reason_created_by_mistakes","cancel_reason_text":"Order created by mistake","create_time":1690451136,"update_time":1690451136,"seller_next_action_response":[{"action":"SELLER_RESPOND_BUYER_CANCEL","deadline":1690554680}],"refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"1000"},"cancel_line_items":[{"cancel_line_item_id":"4035227913481196964","order_line_item_id":"576468844534141348","sku_id":"2729382476852921560","sku_name":"1#, Standard","product_image":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447","width":200,"height":200},"product_name":"bundle No Heel Flat Heel Summer Winter Round Toe","seller_sku":"YYAPC23078TRT30","refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"1000"},"cancel_sub_line_items":[{"cancel_sub_line_item_id":"4035227657962164812","cancel_line_item_id":"4035227657962164811","sub_order_line_item_id":"576473917261451852","order_line_item_id":"576473917261451851","sku_id":"2729382476852921560","sku_name":"1#, Standard","product_image":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447","width":200,"height":200},"product_name":"bundle No Heel Flat Heel Summer Winter Round Toe","seller_sku":"YYAPC23078TRT30","refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"1000"}}]}],"cancel_id":"4035318504086604100","should_replenish_stock":false}],"total_count":100,"next_page_token":"aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA=="},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 25001001 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 25020005 | No permission to process this order |
| 25020008 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Search Returns — `POST /return_refund/202602/returns/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-returns-202602 · cập nhật 2026-10-28 · scope: seller.return_refund.basic

### Path: /return_refund/202602/returns/search
### Method: [POST]
### Function Description
Use this API to search returns by return ID, order ID, buyer, return type, return status, arbitration status, or create/update time window. The response is paginated. To retrieve the next page, pass the previous `next_page_token` as `page_token` and keep all other filters and sorting unchanged.

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
| sort_field | string | N | create_time | The returned results will be sorted by the specified field. |
| **Default**: `create_time` |  |  |  |  |
| Possible values: |  |  |  |  |

* `create_time`
* `update_time`

Specify the order for sorting the returned results by using the `sort_order` parameter. |
sort_order |string |N |ASC |The sort order for the `sort_field` parameter. **Default**: `ASC`
Possible values:

* `ASC`: Ascending order
* `DESC`: Descending order |
   page_size |string |N |10 |The number of results to be returned per page. **Default**: 10. Valid range: [10-50]. |
   page_token |string |N |aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA== |An opaque token used to retrieve the next page of a paginated result set. Retrieve this value from the result of the `next_page_token` from a previous response. It is not needed for the first page. |

### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| return_ids | []string | N | ["4035318504086604100"] | List of return IDs. Each ID must be a base-10 integer string that fits in a signed 64-bit integer. |
| order_ids | []string | N | ["577686530908261117"] | List of TikTok Shop order IDs. Each ID must be a base-10 integer string that fits in a signed 64-bit integer. |
| buyer_user_ids | []string | N | ["7493996903972308733"] | List of TikTok Shop buyer user IDs. Each ID must be a base-10 integer string that fits in a signed 64-bit integer. |
| return_types | []string | N | ["REFUND"] | List of return types. |
| Available values: |  |  |  |  |

* `REFUND`
* `RETURN_AND_REFUND`
* `REPLACEMENT`
* `EXCHANGE` |
   return_status |[]string |N |["RETURN_OR_REFUND_REQUEST_PENDING"] |List of return status.
   Available values:
* `RETURN_OR_REFUND_REQUEST_PENDING`: Buyer has initiated a return or refund request. The request is pending review by seller or system.
* `REFUND_OR_RETURN_REQUEST_REJECT`: The return or refund request was rejected.
* `AWAITING_BUYER_SHIP`: The return request was approved. The seller is waiting for the buyer to ship the approved items to the seller. If the buyer doesn't ship the items to the seller before the deadline, the platform will close the request.
* `BUYER_SHIPPED_ITEM`: Buyer has shipped the approved items to seller.
* `REJECT_RECEIVE_PACKAGE`: Seller inspected the returned items and rejected the return request.
* `RETURN_OR_REFUND_REQUEST_SUCCESS`: The return/refund request was successful. The buyer will be refunded.
* `RETURN_OR_REFUND_REQUEST_CANCEL`: The request has been cancelled by the buyer or system.
* `RETURN_OR_REFUND_REQUEST_COMPLETE`: The return/refund was processed successfully. The buyer has been refunded.
* `REPLACEMENT_REQUEST_PENDING`: Buyer has initiated a replacement request. The request is pending review by seller.
* `REPLACEMENT_REQUEST_REJECT`: Seller reject the buyer replacement request.
* `REPLACEMENT_REQUEST_REFUND_SUCCESS`: Buyer's replacement request was resolved by refund due to insufficient inventory.
* `REPLACEMENT_REQUEST_CANCEL`: Buyer canceled the replacement request.
* `REPLACEMENT_REQUEST_COMPLETE`: Seller has approved the buyer's replacement request, platform will generate a new order for seller to fulfill.
* `AWAITING_BUYER_RESPONSE`: Seller offer another return type to the buyer, and waiting buyer response. Seller proposed return type can check the `seller_proposed_return_type`.
* `EXCHANGE_REQUEST_PENDING`: Buyer has initiated an exchange request. The request is pending review by seller.
* `EXCHANGE_REQUEST_REFUND_SUCCESS`: Buyer's exchange request was resolved by refund due to insufficient inventory.
* `EXCHANGE_REQUEST_CANCEL`: Buyer canceled the exchange request.
* `EXCHANGE_REQUEST_COMPLETE`: Seller has approved the buyer's exchange request, platform will generate a new order for seller to fulfill. |
   seller_proposed_return_type |[]string |N |["PARTIAL_REFUND"] |List of seller proposed return types.
   Available values:
* `PARTIAL_REFUND` |
   create_time_ge |int |N |1690340825 |Filter returns to show only those that are created on or after the specified date and time. Unix timestamp.

Note:
`create_time_ge` and `create_time_le` together constitute the creation time filter condition.

* If `create_time_ge` is filled but `create_time_le` is empty, `create_time_le` will default to the current time.
* If `create_time_lt` is filled but `create_time_ge` is empty, `create_time_ge` will default to the earliest shop time. |
   arbitration_status |[]string |N |["IN_PROGRESS"] |List of arbitration statuses.
   Available values:
* `IN_PROGRESS`: The TikTok Shop platform operator is processing arbitration. Platform may request additional information from the seller.
* `SUPPORT_BUYER`: The platform operator supports buyer.
* `SUPPORT_SELLER`: The platform operator supports seller.
* `CLOSED`: Arbitration is closed. |
   update_time_ge |int |N |1690340825 |Filter returns to show only those that are updated on or after the specified date and time. Unix timestamp.

Note:
`update_time_ge` and `update_time_le` together define the update time filter condition.

* If `update_time_ge` is filled but `update_time_le` is empty, `update_time_le` will default to the current time.
* If `update_time_lt` is filled but `update_time_ge` is empty, `update_time_ge` will default to the earliest shop time. |
   update_time_lt |int |N |1690340825 |Filter returns to those updated before the specified time. Provide a Unix timestamp in seconds. |
   locale |string |N |en-US |The BCP-47 locale codes for displaying the returns, delimited by commas. Default: `en`
   Refer to [Locale codes](678e3a47bae28f030a8c7523) for the list of supported locale codes. |
   create_time_lt |int |N |1690340825 |Filter returns to those created before the specified time. Provide a Unix timestamp in seconds. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202602/returns/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&sort_field=create_time&sort_order=ASC&page_size=10&page_token=aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA==
```

**Body**
```json
{"return_ids":["4035318504086604100"],"order_ids":["577686530908261117"],"buyer_user_ids":["7493996903972308733"],"return_types":["REFUND"],"return_status":["RETURN_OR_REFUND_REQUEST_PENDING"],"seller_proposed_return_type":["PARTIAL_REFUND"],"create_time_ge":1690340825,"arbitration_status":["IN_PROGRESS"],"update_time_ge":1690340825,"update_time_lt":1690340825,"locale":"en-US","create_time_lt":1690340825}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^return_orders | []object |  | List of returns in the current page. This field is omitted when the current page contains no return records. |
| ^^order_id | string | 577686530908261117 | TikTok Shop order ID. |
| ^^return_id | string | 4035318504086604100 | The identifier of a specific return. |
| ^^return_type | string | REFUND | Return type. |
| Available values: |  |  |  |

* `REFUND`: Seller will issue a refund without return. The buyer is not required to send the item(s) back to the seller.
* `RETURN_AND_REFUND`: Buyer is required to send the item(s) back to the seller. The seller will need to review the condition of the returned item(s) before a refund can be issued to the buyer.
* `REPLACEMENT`: The buyer requires the seller to replace the item(s).
* `EXCHANGE`: The buyer requires the seller to exchange the item(s). |
   ^^return_status |string |RETURN_OR_REFUND_REQUEST_PENDING |Return status.
   Available values:
* `RETURN_OR_REFUND_REQUEST_PENDING`: Buyer has initiated a return or refund request. The request is pending review by seller or platform.
* `REFUND_OR_RETURN_REQUEST_REJECT`: The return or refund request was rejected.
* `AWAITING_BUYER_SHIP`: The return request was approved. The seller is waiting for the buyer to ship the approved items to the seller. If the buyer doesn't ship the items to the seller before the deadline, the platform will close the request.
* `BUYER_SHIPPED_ITEM`: Buyer has shipped the approved items to seller.
* `REJECT_RECEIVE_PACKAGE`: Seller inspected the returned items and rejected the return package.
* `RETURN_OR_REFUND_REQUEST_SUCCESS`: The return/refund request was approved. The buyer will be refunded.
* `RETURN_OR_REFUND_REQUEST_CANCEL`: The request has been cancelled by the buyer or system.
* `RETURN_OR_REFUND_REQUEST_COMPLETE`: The return/refund was processed successfully. The buyer has been refunded.
* `REPLACEMENT_REQUEST_PENDING`: Buyer has initiated a replacement request. The request is pending review by seller.
* `REPLACEMENT_REQUEST_REJECT`: Seller reject the buyer replacement request.
* `REPLACEMENT_REQUEST_REFUND_SUCCESS`: Buyer's replacement request was resolved by refund due to insufficient inventory.
* `REPLACEMENT_REQUEST_CANCEL`: Buyer canceled the replacement request.
* `REPLACEMENT_REQUEST_COMPLETE`: Seller has approved the buyer's replacement request, platform will generate a new order for seller to fulfill.
* `AWAITING_BUYER_RESPONSE`: Seller offer another return type to the buyer, and waiting buyer response. Seller proposed return type can check the `seller_proposed_return_type`.
* `EXCHANGE_REQUEST_PENDING`: Buyer has initiated an exchange request. The request is pending review by seller.
* `EXCHANGE_REQUEST_REFUND_SUCCESS`: Buyer's exchange request was resolved by refund due to insufficient inventory.
* `EXCHANGE_REQUEST_CANCEL`: Buyer canceled the exchange request.
* `EXCHANGE_REQUEST_COMPLETE`: Seller has approved the buyer's exchange request, platform will generate a new order for seller to fulfill.
   |
   ^^arbitration_status |string |IN_PROGRESS |Arbitration status.
   Available values:
* `IN_PROGRESS`: The TikTok Shop platform operator is processing arbitration and may request additional information from the seller.
* `SUPPORT_BUYER`: The platform operator supports the buyer.
* `SUPPORT_SELLER`: The platform operator supports the seller.
* `CLOSED`: Arbitration is closed. |
   ^^role |string |BUYER |Return initiation role.
   Available values:
* `BUYER`
* `SELLER`
* `OPERATOR` : TikTok Shop platform operator.
* `SYSTEM`: TikTok Shop system.
   Please see "API overview" to learn more about roles. |
   ^^return_reason |string |ecom_order_to_ship_canceled_reason_created_by_mistakes |Machine-readable reason code for the return. Use `return_reason_text` for localized display text. |
   ^^return_reason_text |string |Order created by mistake |Reason for return, in localized text.
   You can change language using the locale request parameter. |
   ^^shipment_type |string |PLATFORM |The shipment method selected by the buyer for sending the item(s) back to the seller.
   Available values:
* `PLATFORM`: The buyer uses TikTok Shop's shipping service. See `handover_method` for whether the buyer uses `DROP_OFF` or `PICKUP`.
* `BUYER_ARRANGE`: The buyer arranges the return shipment. |
   ^^handover_method |string |DROP_OFF |The handover method buyer chooses to use when returning item(s) to seller using platform's shipping service.
* `DROP_OFF`: buyer will drop off the item(s) at courier
* `PICKUP`: buyer is scheduling a pick up service offered by the courier. |
   ^^return_tracking_number |string |213456789098765433456 |The tracking number of parcels when buyer returns the item(s). |
   ^^return_provider_name |string |J&T Express |The provider name of parcel when buyer returns the item(s). |
   ^^return_provider_id |string |TH27014E9R5Q4G |The provider ID of parcel when buyer returns the items. |
   ^^pre_return_id |string |4035310341095393452 |The previous return ID the current return order is edited from. |
   ^^next_return_id |string |4035310341095393463 |The next return ID the current return order is edited to. |
   ^^can_buyer_keep_item |bool |true |Indicates whether the buyer may keep the item(s). This field is returned as `true` for replacement requests and is omitted for other return types. |
   ^^update_time |int |1690453136 |The time when the return was last updated, as a Unix timestamp in seconds. |
   ^^seller_next_action_response |[]object | |Seller's next action and deadline. |
   ^^^action |string |SELLER_RESPOND_REFUND |Seller's next action.
   Available values:
* `SELLER_RESPOND_REFUND`
* `SELLER_RESPOND_RETURN`
* `SELLER_RESPOND_RECEIVE_PACKAGE`
* `SELLER_RESPOND_REPLACEMENT` |
   ^^^deadline |int |1690554680 |The deadline for the seller to perform the specified action, as a Unix timestamp in seconds. |
   ^^create_time |int |1690451136 |The time when the return was created, as a Unix timestamp in seconds. |
   ^^return_line_items |[]object | |Return order lines items. |
   ^^^return_line_item_id |string |4035227657962164811 |Return order line ID. |
   ^^^order_line_item_id |string |576473917261451851 |Order line ID. |
   ^^^sku_id |string |2729382476852921560 |SKU ID. |
   ^^^sku_name |string |1#, Standard |SKU name. |
   ^^^product_name |string |(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs |Product name. |
   ^^^seller_sku |string |PUTIH 1 TALI |SKU name defined by seller. |
   ^^^product_image |object | |Product image information. |
   ^^^^url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447 |Product image URL. |
   ^^^^width |int |200 |Product image width. Units: pixels (px). |
   ^^^^height |int |200 |Product image height. Units: pixels (px). |
   ^^^refund_amount |object | |Refund amount details. |
   ^^^^currency |string |USD |Payment currency. |
   ^^^^refund_total |string |1.23 |Total refund amount to buyer. |
   ^^^^refund_subtotal |string |1 |Subtotal refund amount to buyer. |
   ^^^^refund_shipping_fee |string |0.2 |Shipping fee refund amount to buyer. |
   ^^^^refund_tax |string |0.03 |Tax refund amount to buyer. |
   ^^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds 500,000 USD, according to US Colorado states' compliance rules.
   |
   ^^^^buyer_service_fee |string |0.1 |Buyer service fee. |
   ^^^return_sub_line_items |[]object | |Return sub-order line items. These items represent SKUs that belong to a "virtual bundle" defined by a seller. This field includes all relevant information about each item in the virtual bundle. |
   ^^^^return_sub_line_item_id |string |4035227657962164812 |Return sub order line ID. |
   ^^^^return_line_item_id |string |4035227657962164811 |Return order line ID. |
   ^^^^sub_order_line_item_id |string |576473917261451852 |Sub order line ID. |
   ^^^^order_line_item_id |string |576473917261451851 |Order line ID. |
   ^^^^sku_id |string |2729382476852921560 |SKU ID. |
   ^^^^sku_name |string |1#, Standard |SKU name. |
   ^^^^product_image |object | |Product image information. |
   ^^^^^url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447 |Product image URL. |
   ^^^^^width |int |200 |Product image width. Units: pixels (px). |
   ^^^^^height |int |200 |Product image height. Units: pixels (px). |
   ^^^^product_name |string |(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs |Product name. |
   ^^^^seller_sku |string |PUTIH 1 TALI |SKU name defined by seller. |
   ^^^^refund_amount |object | |Refund amount details. |
   ^^^^^currency |string |USD |Payment currency. |
   ^^^^^refund_total |string |1.23 |Total refund amount to buyer. |
   ^^^^^refund_subtotal |string |1 |Subtotal refund amount to buyer. |
   ^^^^^refund_shipping_fee |string |0.2 |Shipping fee refund amount to buyer. |
   ^^^^^refund_tax |string |0.03 |Tax refund amount to buyer. |
   ^^^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds 500,000 USD, according to US Colorado states' compliance rules.
   |
   ^^^^^buyer_service_fee |string |0.1 |Buyer service fee. |
   ^^discount_amount |[]object | |Discount refund details. |
   ^^^currency |string |USD |The discount currency. |
   ^^^product_seller_discount |string |0.1 |The refund amount of product seller discount. |
   ^^^shipping_fee_platform_discount |string |0.1 |The refund amount of shipping fee platform discount. |
   ^^^shipping_fee_seller_discount |string |0.1 |The refund amount of shipping fee seller discount. |
   ^^^product_platform_discount |string |0.1 |The refund amount of platform discount. |
   ^^shipping_fee_amount |[]object | |The return shipping fee details. |
   ^^^currency |string |USD |Return shipping fee currency. |
   ^^^seller_paid_return_shipping_fee |string |0.1 |The amount of return shipping fee seller paid. |
   ^^^platform_paid_return_shipping_fee |string |0.1 |The amount of return shipping fee platform paid. |
   ^^^buyer_paid_return_shipping_fee |string |0.1 |The amount of return shipping fee buyer paid. |
   ^^refund_amount |object | |Total refund amount to buyer. |
   ^^^currency |string |USD |Refund currency. |
   ^^^refund_total |string |1.23 |Total refund amount. |
   ^^^refund_subtotal |string |1 |Subtotal refund amount. This is the total price of all items returned. |
   ^^^refund_shipping_fee |string |0.2 |Shipping fee refund. |
   ^^^refund_tax |string |0.03 |Tax fee refund. |
   ^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds 500,000 USD, according to US Colorado states' compliance rules.
   |
   ^^^buyer_service_fee |string |0.1 |Buyer service fee. |
   ^^return_shipping_document_type |string |SHIPPING_LABEL |The type of return shipping document selected by the buyer.
   Available values:
* `SHIPPING_LABEL`
* `QR_CODE` - QR Code with Box
* `QR_CODE_NBNL` - QR Code with No Box No Label |
   ^^return_method |string |PLATFORM_SHIPPED |Return method:
* `SELLER_SHIPPED`: Seller offers the return shipping service.
* `BUYER_SHIPPED`: Buyer offers the return shipping service.
* `PLATFORM_SHIPPED`: TikTok Shop offers the return shipping service. |
   ^^is_combined_return |bool |true |This field will return true if the buyer is asking to combine multiple returns into one return package. |
   ^^combined_return_id |string |4035309948547073951 |If `is_combined_return` is `true`, this field will return the `combined_return_id` associated with the combined return. |
   ^^seller_proposed_return_type |string |PARTIAL_REFUND |Seller proposed return type:
* `PARTIAL_REFUND` |
   ^^partial_refund |object | |Partial refund details. |
   ^^^currency |string |IDR |Partial refund currency |
   ^^^amount |string |10 |The partial refund amount offered by seller.
   Note: only seller proposed partial refund will return this field. |
   ^^buyer_rejected_partial_refund |bool |true |Only return this field when seller initiated the partial refund.
   Available values:
* `TRUE`: Buyer reject the seller partial refund offer.
* `FALSE`: Buyer accept the seller partial refund offer or awaiting buyer response. |
   ^^return_warehouse_address |object | |The return warehouse address details provided by the seller. |
   ^^^full_address |string |1199 Coleman Ave San Jose, CA 95110 |The full return warehouse address. |
   ^^is_quick_refund |bool |false |If the return hit the quick refund strategy, the seller cannot reject the received package |
   ^total_count |int |100 |The number of returns that meet the query conditions. |
   ^next_page_token |string |aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA== |An opaque token used to retrieve the next page of a paginated result set. If `next_page_token` is non-empty, provide it in the `page_token` parameter of the next request. If `next_page_token` is empty, stop pagination. |

### Response Sample
```json
{"code":0,"data":{"return_orders":[{"order_id":"577686530908261117","return_id":"4035318504086604100","return_type":"REFUND","return_status":"RETURN_OR_REFUND_REQUEST_PENDING","arbitration_status":"IN_PROGRESS","role":"BUYER","return_reason":"ecom_order_to_ship_canceled_reason_created_by_mistakes","return_reason_text":"Order created by mistake","shipment_type":"PLATFORM","handover_method":"DROP_OFF","return_tracking_number":"213456789098765433456","return_provider_name":"J\u0026T Express","return_provider_id":"TH27014E9R5Q4G","pre_return_id":"4035310341095393452","next_return_id":"4035310341095393463","can_buyer_keep_item":true,"update_time":1690453136,"seller_next_action_response":[{"action":"SELLER_RESPOND_REFUND","deadline":1690554680}],"create_time":1690451136,"return_line_items":[{"return_line_item_id":"4035227657962164811","order_line_item_id":"576473917261451851","sku_id":"2729382476852921560","sku_name":"1#, Standard","product_name":"(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs","seller_sku":"PUTIH 1 TALI","product_image":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447","width":200,"height":200},"refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"0.1"},"return_sub_line_items":[{"return_sub_line_item_id":"4035227657962164812","return_line_item_id":"4035227657962164811","sub_order_line_item_id":"576473917261451852","order_line_item_id":"576473917261451851","sku_id":"2729382476852921560","sku_name":"1#, Standard","product_image":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447","width":200,"height":200},"product_name":"(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs","seller_sku":"PUTIH 1 TALI","refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"0.1"}}]}],"discount_amount":[{"currency":"USD","product_seller_discount":"0.1","shipping_fee_platform_discount":"0.1","shipping_fee_seller_discount":"0.1","product_platform_discount":"0.1"}],"shipping_fee_amount":[{"currency":"USD","seller_paid_return_shipping_fee":"0.1","platform_paid_return_shipping_fee":"0.1","buyer_paid_return_shipping_fee":"0.1"}],"refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"0.1"},"return_shipping_document_type":"SHIPPING_LABEL","return_method":"PLATFORM_SHIPPED","is_combined_return":true,"combined_return_id":"4035309948547073951","seller_proposed_return_type":"PARTIAL_REFUND","partial_refund":{"currency":"IDR","amount":"10"},"buyer_rejected_partial_refund":true,"return_warehouse_address":{"full_address":"1199 Coleman Ave San Jose, CA 95110"},"is_quick_refund":false}],"total_count":100,"next_page_token":"aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA=="},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 25001001 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 25020005 | No permission to process this order |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Aftersale Eligibility — `GET /return_refund/202602/orders/{order_id}/aftersale_eligibility`

Doc: https://partner.tiktokshop.com/docv2/page/get-aftersale-eligibility-202602 · cập nhật 2026-10-13 · scope: seller.return_refund.basic

### Path: /return_refund/202602/orders/{order_id}/aftersale_eligibility
### Method: [GET]
### Function Description
Use this API to check whether a seller or buyer can initiate refund-only, return-and-refund, or cancellation requests for an order. The response groups eligibility by SKU, order line item, and aftersale request type.

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
| order_id | string | Y | 577087614418520388 | The unique identifier for a TikTok Shop order. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| initiate_aftersale_user | string | N | BUYER | The type of user you would like to check aftersale options for. |
| Default: SELLER |  |  |  |  |
| Possible values: |  |  |  |  |

* SELLER
* BUYER |
   request_types |[]string |N |REFUND |**Optional.** Specifies which request types to query. If omitted, the API returns all request types currently available for the specified initiator. Possible values:
   -`CANCEL`
   -`REFUND`
   -`RETURN_AND_REFUND` |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202602/orders/577087614418520388/aftersale_eligibility?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&initiate_aftersale_user=BUYER&request_types=REFUND
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^sku_eligibility | []object |  | The eligible aftersale options for a given SKU. |
| ^^sku_id | string | 1729385144994206632 | SKU ID. |
| ^^line_item_eligibility | []object |  | Eligibility results for order line items in this SKU, grouped by aftersale request type. A request type can include separate entries for eligible and ineligible order line items. Eligible entries can include available_reason_names, while ineligible entries include ineligible_code and ineligible_reason. |
| ^^^request_type | string | REFUND | Aftersale request type. |
| Possible values: |  |  |  |

* `CANCEL`
* `REFUND`
* `RETURN_AND_REFUND` |
   ^^^order_line_items_ids |[]string |["576469648086306000"] |Specifies the order line IDs. **Note:** This is a legacy field for new integrations use `order_line_list` instead. |
   ^^^eligible |bool |true |Indicates whether the order lines in this entry are eligible for the entry's aftersale request type:
* `true`: The order lines are eligible for the request type.
* `false`: The order lines are ineligible for the request type. |
   ^^^ineligible_code |int |25001001 |The reason code for an ineligible aftersale request. |
   ^^^ineligible_reason |string |invalid order status |The reason for an ineligible aftersale request. |
   ^^^available_reason_names |[]string |available reason names |A list of reason names that can be used when creating a follow-up aftersale request. |
   ^^^order_line_list |[]object | |Specifies the order line items. **Note:** This field is completely backward compatible with the previous `order_line_items_ids` field. |
   ^^^^order_line_item_id |string |576469648086306986 |The corresponding order line ID |
   ^^^^sub_order_line_item_id |string |576469648086306987 |The sub-order-line ID inside a bundle product
* Required for bundle products
* Not required for non-bundle products |

### Response Sample
```json
{"code":0,"data":{"sku_eligibility":[{"sku_id":"1729385144994206632","line_item_eligibility":[{"request_type":"REFUND","order_line_items_ids":["576469648086306000"],"eligible":true,"ineligible_code":25001001,"ineligible_reason":"invalid order status","available_reason_names":"available reason names","order_line_list":[{"order_line_item_id":"576469648086306986","sub_order_line_item_id":"576469648086306987"}]}]}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Search Aftersales Requests — `POST /return_refund/202603/aftersales/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-aftersales-requests-202603 · cập nhật 2026-10-13 · scope: seller.return_refund.basic

### Path: /return_refund/202603/aftersales/search
### Method: [POST]
### Function Description
Searches aftersales requests for the authorized shop. You can filter by aftersales request, buyer, or main order IDs, aftersales request status, return type, and creation or update time. Use `whitelisted_data_fields` to include line items, SKU return requests, or return merchandise authorizations in each result.

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
| locale | string | N | en-US | The BCP-47 locale codes for displaying purposes. Default: `en` |
| Refer to [Locale codes](https://partner.tiktokshop.com/docv2/page/678e3a47bae28f030a8c7523) for the list of supported locale codes. |  |  |  |  |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| whitelisted_data_fields | []string | N | ["LINE_ITEMS", "SKU_RETURN_REQUESTS", "RETURN_MERCHANDISE_AUTHORIZATIONS"] | Controls which additional fields are included for each aftersales request. |
| Possible values: |  |  |  |  |

* `LINE_ITEMS`: Includes `line_items`.
* `SKU_RETURN_REQUESTS`: Includes `sku_return_requests`.
* `RETURN_MERCHANDISE_AUTHORIZATIONS`: Includes `return_merchandise_authorizations`. |
   filters |object |N | |Filters to narrow the result set. |
   ^aftersales_request_ids |[]string |N |["4035318504086604101"] |Restricts results to the specified aftersales requests. Each ID must be a base-10 integer string that fits in a signed 64-bit integer. |
   ^aftersales_request_statuses |[]string |N |["PENDING_REQUEST_REVIEW"] |Restricts results to the specified aftersales request statuses.
   Possible values:
* `INIT`
* `PENDING_REQUEST_REVIEW`
* `REQUEST_REVIEW_COMPLETED` |
   ^return_types |[]string |N |["REFUND", "RETURN_AND_REFUND"] |Restricts results to aftersales request data which includes at least one sku return request with a given type.
   Possible values:
* `REFUND`
* `RETURN_AND_REFUND`
* `REPLACEMENT`
* `EXCHANGE` |
   ^main_order_ids |[]string |N |["577686530908261117"] |Restricts results to aftersales requests that contain at least one SKU return request for a specified main (forward) order. Each main order ID must be a base-10 integer string that fits in a signed 64-bit integer. |
   ^buyer_ids |[]string |N |["7493996903972308733"] |Restricts results to aftersales requests that contain at least one SKU return request for a specified buyer. Each buyer ID must be a base-10 integer string that fits in a signed 64-bit integer. |
   ^time |object |N | |Time-based filtering criteria. |
   ^^create_time |object |N | |Filter based on creation time. |
   ^^^min_unix_time_inclusive |int |N |1774486592 |Inclusive lower bound (Unix seconds). |
   ^^^max_unix_time_exclusive |int |N |1774572992 |Exclusive upper bound (Unix seconds). |
   ^^update_time |object |N | |Filter based on last update time. |
   ^^^min_unix_time_inclusive |int |N |1774486592 |Inclusive lower bound (Unix seconds). |
   ^^^max_unix_time_exclusive |int |N |1774572992 |Exclusive upper bound (Unix seconds). |
   sort |object |N | |Sorting criteria for the result set. |
   ^sort_field |string |N |CREATE_TIME |Name of the field used for sorting.
   Possible values:
* `CREATE_TIME`
* `UPDATE_TIME`
   |
   ^sort_order |string |N |ASC |Sort direction.
   Possible values:
* `ASC`
* `DESC` |
   pagination |object |N | |Pagination configuration. |
   ^page_size |int |N |100 |Number of records to return per page. Minimum: 1. Maximum: 100. |
   ^page_token |string |N |aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA== |Identifies the page to retrieve. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202603/aftersales/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&locale=en-US
```

**Body**
```json
{"whitelisted_data_fields":["LINE_ITEMS","SKU_RETURN_REQUESTS","RETURN_MERCHANDISE_AUTHORIZATIONS"],"filters":{"aftersales_request_ids":["4035318504086604101"],"aftersales_request_statuses":["PENDING_REQUEST_REVIEW"],"return_types":["REFUND","RETURN_AND_REFUND"],"main_order_ids":["577686530908261117"],"buyer_ids":["7493996903972308733"],"time":{"create_time":{"min_unix_time_inclusive":1774486592,"max_unix_time_exclusive":1774572992},"update_time":{"min_unix_time_inclusive":1774486592,"max_unix_time_exclusive":1774572992}}},"sort":{"sort_field":"CREATE_TIME","sort_order":"ASC"},"pagination":{"page_size":100,"page_token":"aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA=="}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^aftersales_requests | []object |  | List of aftersales requests matching the filters. This field is omitted when no aftersales requests match. |
| ^^id | string | 4035318504086604101 | Unique identifier for this aftersales request. |
| ^^line_items | []object |  | List of items associated with this aftersales request. This field is returned only when `LINE_ITEMS` is included in `whitelisted_data_fields` and matching item data is available. |
| ^^^return_line_item_id | string | 4035227657962164811 | Unique identifier for this item in the return. In the case of virtual bundle, this is corresponds to the id of the original parent item bundle. |
| ^^^sub_return_line_item_id | string | 4035227657962164815 | Unique identifier for this item in the return. In the case of virtual bundle, this is corresponds to the id of the current child item being returned. |
| ^^^sku_id | string | 2729382476852921560 | SKU identifier associated with this item (for product details). |
| ^^^main_order_id | string | 577686530908261117 | Identifier of the associated main (forward) order. |
| ^^^sku_return_request_id | string | 4035318504086604100 | Identifier of the associated SKU-level, sub return request. |
| ^^status | string | PENDING_REQUEST_REVIEW | Current state of this aftersales request. |
| Possible values: |  |  |  |

* `INIT`
* `PENDING_REQUEST_REVIEW`
* `REQUEST_REVIEW_COMPLETED` |
   ^^sku_return_requests |[]object | |SKU-level sub return requests associated with this aftersales request, also known as reverse orders or return requests. This field is returned only when `SKU_RETURN_REQUESTS` is included in `whitelisted_data_fields` and matching data is available. |
   ^^^order_id |string |577686530908261117 |TikTok Shop main order ID associated with this SKU return request. |
   ^^^return_id |string |4035318504086604100 |The identifier of a specific return. |
   ^^^return_type |string |REFUND |Return type.
   Available values:
* `REFUND`: Seller will issue a refund without return. The buyer is not required to send the item(s) back to the seller.
* `RETURN_AND_REFUND`: Buyer is required to send the item(s) back to the seller. The seller will need to review the condition of the returned item(s) before a refund can be issued to the buyer.
* `REPLACEMENT`: The buyer requires the seller to replace the item(s).
* `EXCHANGE`: The buyer requires the seller to exchange the item(s). |
   ^^^return_status |string |RETURN_OR_REFUND_REQUEST_PENDING |Return status.
   Available values:
* `RETURN_OR_REFUND_REQUEST_PENDING`: Buyer has initiated a return or refund request. The request is pending review by seller or platform.
* `REFUND_OR_RETURN_REQUEST_REJECT`: The return or refund request was rejected.
* `AWAITING_BUYER_SHIP`: The return request was approved. The seller is waiting for the buyer to ship the approved items to the seller. If the buyer doesn't ship the items to the seller before the deadline, the platform will close the request.
* `BUYER_SHIPPED_ITEM`: Buyer has shipped the approved items to seller.
* `REJECT_RECEIVE_PACKAGE`: Seller inspected the returned items and rejected the return package.
* `RETURN_OR_REFUND_REQUEST_SUCCESS`: The return/refund request was approved. The buyer will be refunded.
* `RETURN_OR_REFUND_REQUEST_CANCEL`: The request has been cancelled by the buyer or system.
* `RETURN_OR_REFUND_REQUEST_COMPLETE`: The return/refund was processed successfully. The buyer has been refunded.
* `REPLACEMENT_REQUEST_PENDING`: Buyer has initiated a replacement request. The request is pending review by seller.
* `REPLACEMENT_REQUEST_REJECT`: Seller reject the buyer replacement request.
* `REPLACEMENT_REQUEST_REFUND_SUCCESS`: Buyer's replacement request was resolved by refund due to insufficient inventory.
* `REPLACEMENT_REQUEST_CANCEL`: Buyer canceled the replacement request.
* `REPLACEMENT_REQUEST_COMPLETE`: Seller has approved the buyer's replacement request, platform will generate a new order for seller to fulfill.
* `AWAITING_BUYER_RESPONSE`: Seller offer another return type to the buyer, and waiting buyer response. Seller proposed return type can check the `seller_proposed_return_type`.
* `EXCHANGE_REQUEST_PENDING`: Buyer has initiated an exchange request. The request is pending review by seller.
* `EXCHANGE_REQUEST_REFUND_SUCCESS`: Buyer's exchange request was resolved by refund due to insufficient inventory.
* `EXCHANGE_REQUEST_CANCEL`: Buyer canceled the exchange request.
* `EXCHANGE_REQUEST_COMPLETE`: Seller has approved the buyer's exchange request, platform will generate a new order for seller to fulfill. |
   ^^^arbitration_status |string |IN_PROGRESS |Arbitration status.
   Available values:
* `IN_PROGRESS`: The TikTok Shop platform operator is processing arbitration and may request additional information from the seller.
* `SUPPORT_BUYER`: The platform operator supports the buyer.
* `SUPPORT_SELLER`: The platform operator supports the seller.
* `CLOSED`: Arbitration is closed. |
   ^^^role |string |BUYER |Return initiation role.
   Available values:
* `BUYER`
* `SELLER`
* `OPERATOR` : TikTok Shop platform operator.
* `SYSTEM`: TikTok Shop system.
   Please see "API overview" to learn more about roles. |
   ^^^return_reason |string |ecom_order_to_ship_canceled_reason_created_by_mistakes |Machine-readable reason code for the return. Use `return_reason_text` for localized display text. |
   ^^^return_reason_text |string |Order created by mistake |Reason for return, in localized text.
   You can change language using the locale request parameter. |
   ^^^seller_next_action_response |[]object | |Seller's next action and deadline. |
   ^^^^action |string |SELLER_RESPOND_REFUND |Seller's next action.
   Available values:
* `SELLER_RESPOND_REFUND`
* `SELLER_RESPOND_RETURN`
* `SELLER_RESPOND_RECEIVE_PACKAGE`
* `SELLER_RESPOND_REPLACEMENT` |
   ^^^^deadline |int |1690554680 |The deadline for the seller to perform the specified action, as a Unix timestamp in seconds. |
   ^^^shipment_type |string |PLATFORM |The shipment method selected by the buyer for sending the item(s) back to the seller.
   Available values:
* `PLATFORM`: The buyer uses TikTok Shop's shipping service. See `handover_method` for whether the buyer uses `DROP_OFF` or `PICKUP`.
* `BUYER_ARRANGE`: The buyer arranges the return shipment. |
   ^^^handover_method |string |DROP_OFF |The handover method buyer chooses to use when returning item(s) to seller using platform's shipping service.
* `DROP_OFF`: buyer will drop off the item(s) at courier
* `PICKUP`: buyer is scheduling a pick up service offered by the courier. |
   ^^^return_tracking_number |string |213456789098765433456 |The tracking number of parcels when buyer returns the item(s). |
   ^^^return_provider_name |string |J&T Express |The provider name of parcel when buyer returns the item(s). |
   ^^^return_provider_id |string |TH27014E9R5Q4G |The provider ID of parcel when buyer returns the items. |
   ^^^pre_return_id |string |4035310341095393452 |The previous return ID the current return order is edited from. |
   ^^^next_return_id |string |4035310341095393463 |The next return ID the current return order is edited to. |
   ^^^refund_amount |object | |Refund amount details. |
   ^^^^currency |string |USD |Payment currency. |
   ^^^^refund_total |string |1.23 |Total refund amount to buyer. |
   ^^^^refund_subtotal |string |1 |Subtotal refund amount to buyer. |
   ^^^^refund_shipping_fee |string |0.2 |Shipping fee refund amount to buyer. |
   ^^^^refund_tax |string |0.03 |Tax refund amount to buyer. |
   ^^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds 500,000 USD, according to US Colorado states' compliance rules. |
   ^^^^buyer_service_fee |string |0.1 |Buyer service fee. |
   ^^^return_line_items |[]object | |Return order lines items. |
   ^^^^return_line_item_id |string |4035227657962164811 |Return order line ID. |
   ^^^^order_line_item_id |string |576473917261451851 |Order line ID. |
   ^^^^sku_id |string |2729382476852921560 |SKU ID. |
   ^^^^sku_name |string |1#, Standard |SKU name. |
   ^^^^product_image |object | |Product image information. |
   ^^^^^url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447 |Product image URL. |
   ^^^^^width |int |200 |Product image width. Units: pixels (px). |
   ^^^^^height |int |200 |Product image height. Units: pixels (px). |
   ^^^^product_name |string |(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs |Product name. |
   ^^^^seller_sku |string |PUTIH 1 TALI |SKU name defined by seller. |
   ^^^^refund_amount |object | |Refund amount details. |
   ^^^^^currency |string |USD |Payment currency. |
   ^^^^^refund_total |string |1.23 |Total refund amount to buyer. |
   ^^^^^refund_subtotal |string |1 |Subtotal refund amount to buyer. |
   ^^^^^refund_shipping_fee |string |0.2 |Shipping fee refund amount to buyer. |
   ^^^^^refund_tax |string |0.03 |Tax refund amount to buyer. |
   ^^^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds 500,000 USD, according to US Colorado states' compliance rules. |
   ^^^^^buyer_service_fee |string |0.1 |Buyer service fee. |
   ^^^^return_sub_line_items |[]object | |Return sub order lines items.
   Sub items represent skus that belong to a "virtual bundle" that has been defined by a seller. The sub_items will include all relevant information about each item that is a part of the virtual bundle. |
   ^^^^^return_sub_line_item_id |string |4035227657962164812 |Return sub order line ID. |
   ^^^^^return_line_item_id |string |4035227657962164811 |Return order line ID. |
   ^^^^^sub_order_line_item_id |string |576473917261451852 |Sub order line ID. |
   ^^^^^order_line_item_id |string |576473917261451851 |Order line ID. |
   ^^^^^sku_id |string |2729382476852921560 |SKU ID. |
   ^^^^^sku_name |string |1#, Standard |SKU name. |
   ^^^^^product_image |object | |Product image information. |
   ^^^^^^url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447 |Product image URL. |
   ^^^^^^width |int |200 |Product image width. Units: pixels (px). |
   ^^^^^^height |int |200 |Product image height. Units: pixels (px). |
   ^^^^^product_name |string |(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs |Product name. |
   ^^^^^seller_sku |string |PUTIH 1 TALI |SKU name defined by seller. |
   ^^^^^refund_amount |object | |Refund amount details. |
   ^^^^^^currency |string |USD |Payment currency. |
   ^^^^^^refund_total |string |1.23 |Total refund amount to buyer. |
   ^^^^^^refund_subtotal |string |1 |Subtotal refund amount to buyer. |
   ^^^^^^refund_shipping_fee |string |0.2 |Shipping fee refund amount to buyer. |
   ^^^^^^refund_tax |string |0.03 |Tax refund amount to buyer. |
   ^^^^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds 500,000 USD, according to US Colorado states' compliance rules. |
   ^^^^^^buyer_service_fee |string |0.1 |Buyer service fee. |
   ^^^create_time |int |1690451136 |The time when the return was created, as a Unix timestamp in seconds. |
   ^^^update_time |int |1690453136 |The time when the return was last updated, as a Unix timestamp in seconds. |
   ^^^discount |object | |Discount refund amounts, denominated in the currency specified by `refund_amount.currency`. |
   ^^^^product_platform_discount |string |0.1 |The refund amount of platform discount. |
   ^^^^product_seller_discount |string |0.1 |The refund amount of product seller discount. |
   ^^^^shipping_fee_platform_discount |string |0.1 |The refund amount of shipping fee platform discount. |
   ^^^^shipping_fee_seller_discount |string |0.1 |The refund amount of shipping fee seller discount. |
   ^^^shipping_fee |object | |Return shipping fee amounts, denominated in the currency specified by `refund_amount.currency`. |
   ^^^^seller_paid_return_shipping_fee_amount |string |0.1 |The amount of return shipping fee seller paid. |
   ^^^^buyer_paid_return_shipping_fee_amount |string |0.1 |The amount of return shipping fee buyer paid. |
   ^^^^platform_paid_return_shipping_fee_amount |string |0.1 |The amount of return shipping fee platform paid. |
   ^^^buyer_keep_item |bool |true |Indicates whether the buyer may keep the item(s). This field is returned as `true` for replacement requests and is omitted for other return types. |
   ^^^return_shipping_document_type |string |SHIPPING_LABEL |The type of return shipping document selected by the buyer.
   Available values:
* `SHIPPING_LABEL`
* `QR_CODE` - QR Code with Box
* `QR_CODE_NBNL` - QR Code with No Box No Label |
   ^^^return_method |string |PLATFORM_SHIPPED |Return method:
* `SELLER_SHIPPED`: Seller offers the return shipping service.
* `BUYER_SHIPPED`: Buyer offers the return shipping service.
* `PLATFORM_SHIPPED`: TikTok Shop offers the return shipping service. |
   ^^^is_combined_return |bool |false |This field will return true if the buyer is asking to combine multiple returns into one return package. |
   ^^^combined_return_id |string |4035309948547073951 |If `is_combined_return` is `true`, this field will return the `combined_return_id` associated with the combined return. |
   ^^^seller_proposed_return_type |string |PARTIAL_REFUND |Seller proposed return type:
* `PARTIAL_REFUND` |
   ^^^partial_refund_amount |object | |Partial refund details. |
   ^^^^partial_refund_total |string |10 |The partial refund amount offered by seller.
   Note: only seller proposed partial refund will return this field. |
   ^^^^currency |string |IDR |Partial refund currency |
   ^^^buyer_rejected_partial_refund |bool |true |Only return this field when seller initiated the partial refund.
   Available values:
* `TRUE`: Buyer reject the seller partial refund offer.
* `FALSE`: Buyer accept the seller partial refund offer or awaiting buyer response. |
   ^^^return_warehouse_address |object | |The return warehouse address details provided by the seller. |
   ^^^^full_address |string |1199 Coleman Ave San Jose, CA 95110 |The full return warehouse address. |
   ^^^exchange_order_lines |[]object | |Ignore this field. It is not yet supported. |
   ^^^^order_line_id |string |0 |Ignore this field. It is not yet supported. |
   ^^^^sku_id |string |0 |Ignore this field. It is not yet supported. |
   ^^^^sku_name |string |0 |Ignore this field. It is not yet supported. |
   ^^^^product_name |string |0 |Ignore this field. It is not yet supported. |
   ^^^^seller_sku_name |string |0 |Ignore this field. It is not yet supported. |
   ^^^^product_image |object | |Ignore this field. It is not yet supported. |
   ^^^^^url |string |0 |Ignore this field. It is not yet supported. |
   ^^^^^width |int |0 |Ignore this field. It is not yet supported. |
   ^^^^^height |int |0 |Ignore this field. It is not yet supported. |
   ^^^^price_detail |object | |Ignore this field. It is not yet supported. |
   ^^^^^currency |string |0 |Ignore this field. It is not yet supported. |
   ^^^^^refund_total |string |0 |Ignore this field. It is not yet supported. |
   ^^^^^refund_subtotal |string |0 |Ignore this field. It is not yet supported. |
   ^^^^^refund_shipping_fee |string |0 |Ignore this field. It is not yet supported. |
   ^^^^^refund_tax |string |0 |Ignore this field. It is not yet supported. |
   ^^^reshipment_order_id |string |0 |Ignore this field. It is not yet supported. |
   ^^^is_quick_refund |bool |false |If the return hit the quick refund strategy, the seller cannot reject the received package |
   ^^^return_sub_line_items |[]object | |Deprecated. Do not use this field. |
   ^^^^return_sub_line_item_id |string |4035227657962164812 |Return sub order line ID. |
   ^^^^return_line_item_id |string |4035227657962164811 |Return order line ID. |
   ^^^^sub_order_line_item_id |string |576473917261451852 |Sub order line ID. |
   ^^^^order_line_item_id |string |576473917261451851 |Order line ID. |
   ^^^^sku_id |string |2729382476852921560 |SKU ID. |
   ^^^^sku_name |string |1#, Standard |SKU name. |
   ^^^^product_image |object | |Product image information. |
   ^^^^^url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447 |Product image URL. |
   ^^^^^width |int |200 |Product image width. Units: pixels (px). |
   ^^^^^height |int |200 |Product image height. Units: pixels (px). |
   ^^^^product_name |string |(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs |Product name. |
   ^^^^seller_sku |string |PUTIH 1 TALI |SKU name defined by seller. |
   ^^^^refund_amount |object | |Refund amount details. |
   ^^^^^currency |string |USD |Payment currency. |
   ^^^^^refund_total |string |1.23 |Total refund amount to buyer. |
   ^^^^^refund_subtotal |string |1 |Subtotal refund amount to buyer. |
   ^^^^^refund_shipping_fee |string |0.2 |Shipping fee refund amount to buyer. |
   ^^^^^refund_tax |string |0.03 |Tax refund amount to buyer. |
   ^^^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds 500,000 USD, according to US Colorado states' compliance rules. |
   ^^^^^buyer_service_fee |string |0.1 |Buyer service fee. |
   ^^return_merchandise_authorizations |[]object | |Return merchandise authorization (RMA) records associated with this aftersales request. This field is returned only when `RETURN_MERCHANDISE_AUTHORIZATIONS` is included in `whitelisted_data_fields` and matching RMA data is available. |
   ^^^id |string |2894521704838895640 |Unique identifier for this RMA data. |
   ^^^package_id |string |2894521704838895645 |Identifier of the associated physical return package. |
   ^^^aftersales_request_id |string |4035318504086604101 |Identifier of the parent aftersales request. |
   ^^^status |string |AWAITING_BUYER_RETURN |The current state of this RMA data.
   Possible values:
* `INIT`
* `AWAITING_BUYER_RETURN`
* `RETURN_IN_TRANSIT`
* `PENDING_PACKAGE_REVIEW`
* `PACKAGE_REVIEW_COMPLETED` |
   ^^^line_items |[]object | |List of items associated with this return merchandise authorization (RMA). |
   ^^^^return_line_item_id |string |4035227657962164811 |Unique identifier for this item in the return. In the case of virtual bundle, this is corresponds to the id of the original parent item bundle. |
   ^^^^sub_return_line_item_id |string |4035227657962164815 |Unique identifier for this item in the return. In the case of virtual bundle, this is corresponds to the id of the current child item being returned. |
   ^^^^sku_id |string |2729382476852921560 |SKU identifier associated with this item (for product details). |
   ^^^^main_order_id |string |577686530908261117 |Identifier of the associated main (forward) order. |
   ^^^^sku_return_request_id |string |4035318504086604100 |Identifier of the associated SKU-level, sub return request. |
   ^total_count |int |12345 |The total result set size, independent of pagination. |
   ^next_page_token |string |aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA== |Used to fetch the next page/set of results. |

### Response Sample
```json
{"code":0,"data":{"aftersales_requests":[{"id":"4035318504086604101","line_items":[{"return_line_item_id":"4035227657962164811","sub_return_line_item_id":"4035227657962164815","sku_id":"2729382476852921560","main_order_id":"577686530908261117","sku_return_request_id":"4035318504086604100"}],"status":"PENDING_REQUEST_REVIEW","sku_return_requests":[{"order_id":"577686530908261117","return_id":"4035318504086604100","return_type":"REFUND","return_status":"RETURN_OR_REFUND_REQUEST_PENDING","arbitration_status":"IN_PROGRESS","role":"BUYER","return_reason":"ecom_order_to_ship_canceled_reason_created_by_mistakes","return_reason_text":"Order created by mistake","seller_next_action_response":[{"action":"SELLER_RESPOND_REFUND","deadline":1690554680}],"shipment_type":"PLATFORM","handover_method":"DROP_OFF","return_tracking_number":"213456789098765433456","return_provider_name":"J\u0026T Express","return_provider_id":"TH27014E9R5Q4G","pre_return_id":"4035310341095393452","next_return_id":"4035310341095393463","refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"0.1"},"return_line_items":[{"return_line_item_id":"4035227657962164811","order_line_item_id":"576473917261451851","sku_id":"2729382476852921560","sku_name":"1#, Standard","product_image":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447","width":200,"height":200},"product_name":"(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs","seller_sku":"PUTIH 1 TALI","refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"0.1"},"return_sub_line_items":[{"return_sub_line_item_id":"4035227657962164812","return_line_item_id":"4035227657962164811","sub_order_line_item_id":"576473917261451852","order_line_item_id":"576473917261451851","sku_id":"2729382476852921560","sku_name":"1#, Standard","product_image":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447","width":200,"height":200},"product_name":"(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs","seller_sku":"PUTIH 1 TALI","refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"0.1"}}]}],"create_time":1690451136,"update_time":1690453136,"discount":{"product_platform_discount":"0.1","product_seller_discount":"0.1","shipping_fee_platform_discount":"0.1","shipping_fee_seller_discount":"0.1"},"shipping_fee":{"seller_paid_return_shipping_fee_amount":"0.1","buyer_paid_return_shipping_fee_amount":"0.1","platform_paid_return_shipping_fee_amount":"0.1"},"buyer_keep_item":true,"return_shipping_document_type":"SHIPPING_LABEL","return_method":"PLATFORM_SHIPPED","is_combined_return":false,"combined_return_id":"4035309948547073951","seller_proposed_return_type":"PARTIAL_REFUND","partial_refund_amount":{"partial_refund_total":"10","currency":"IDR"},"buyer_rejected_partial_refund":true,"return_warehouse_address":{"full_address":"1199 Coleman Ave San Jose, CA 95110"},"exchange_order_lines":[{"order_line_id":"0","sku_id":"0","sku_name":"0","product_name":"0","seller_sku_name":"0","product_image":{"url":"0","width":0,"height":0},"price_detail":{"currency":"0","refund_total":"0","refund_subtotal":"0","refund_shipping_fee":"0","refund_tax":"0"}}],"reshipment_order_id":"0","is_quick_refund":false,"return_sub_line_items":[{"return_sub_line_item_id":"4035227657962164812","return_line_item_id":"4035227657962164811","sub_order_line_item_id":"576473917261451852","order_line_item_id":"576473917261451851","sku_id":"2729382476852921560","sku_name":"1#, Standard","product_image":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447","width":200,"height":200},"product_name":"(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs","seller_sku":"PUTIH 1 TALI","refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"0.1"}}]}],"return_merchandise_authorizations":[{"id":"2894521704838895640","package_id":"2894521704838895645","aftersales_request_id":"4035318504086604101","status":"AWAITING_BUYER_RETURN","line_items":[{"return_line_item_id":"4035227657962164811","sub_return_line_item_id":"4035227657962164815","sku_id":"2729382476852921560","main_order_id":"577686530908261117","sku_return_request_id":"4035318504086604100"}]}]}],"total_count":12345,"next_page_token":"aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA=="},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 25001001 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 25020005 | No permission to process this order |
| 25020008 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Search Return Merchandise Authorizations — `POST /return_refund/202604/rma/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-return-merchandise-authorizations-202604 · cập nhật 2026-10-13 · scope: seller.return_refund.basic

### Path: /return_refund/202604/rma/search
### Method: [POST]
### Function Description
Searches return merchandise authorizations (RMAs) for the authorized shop. You can filter by identifiers, RMA status, and creation or update time. Use `whitelisted_data_fields` to include line items or SKU return requests for each RMA.

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
| locale | string | N | en-US | The BCP-47 locale codes for displaying purposes. Default: `en` |
| Refer to [Locale codes](https://partner.tiktokshop.com/docv2/page/678e3a47bae28f030a8c7523) for the list of supported locale codes. |  |  |  |  |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| whitelisted_data_fields | []string | N | ["LINE_ITEMS","SKU_RETURN_REQUESTS"] | Controls which additional fields are included for each RMA. |
| Possible values: |  |  |  |  |

* `LINE_ITEMS`: Includes `line_items`.
* `SKU_RETURN_REQUESTS`: Includes `sku_return_requests`. |
   filters |object |N | |Filters to narrow the result set. |
   ^rma_ids |[]string |N |["2894521704838895640"] |Restricts results to the specified RMA records. Each RMA ID must be a base-10 integer string that fits in a signed 64-bit integer. |
   ^package_ids |[]string |N |["2894521704838895645"] |Restricts results to the specified packages. Each package ID must be a base-10 integer string that fits in a signed 64-bit integer. |
   ^statuses |[]string |N |["PENDING_PACKAGE_REVIEW"] |Restricts results to the specified RMA data statuses.
   Possible values:
* `INIT`
* `AWAITING_BUYER_RETURN`
* `RETURN_IN_TRANSIT`
* `PENDING_PACKAGE_REVIEW`
* `PACKAGE_REVIEW_COMPLETED` |
   ^aftersales_request_ids |[]string |N |["4035319218955782461"] |Restricts results to the specified aftersales requests. Each ID must be a base-10 integer string that fits in a signed 64-bit integer. |
   ^main_order_ids |[]string |N |["577686530908261117"] |Restricts results to the specified main (forward) order IDs. |
   ^time |object |N | |Time-based filtering criteria. |
   ^^create_time |object |N | |Filter based on creation time. |
   ^^^min_unix_time_inclusive |int |N |1774486592 |Inclusive lower bound (Unix seconds). |
   ^^^max_unix_time_exclusive |int |N |1774572992 |Exclusive upper bound (Unix seconds). |
   ^^update_time |object |N | |Filter based on last update time. |
   ^^^min_unix_time_inclusive |int |N |1774486592 |Inclusive lower bound (Unix seconds). |
   ^^^max_unix_time_exclusive |int |N |1774572992 |Exclusive upper bound (Unix seconds). |
   sort |object |N | |Sorting criteria for the result set. |
   ^sort_field |string |N |CREATE_TIME |Field used to sort results.
   Possible values:
* `CREATE_TIME`
* `UPDATE_TIME` |
   ^sort_order |string |N |ASC |Sort direction.
   Possible values:
* `ASC`
* `DESC` |
   pagination |object |N | |Pagination configuration. |
   ^page_size |int |N |100 |Number of records to return per page. Minimum: 1. Maximum: 100. |
   ^page_token |string |N |aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA== |Identifies the page to retrieve. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202604/rma/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&locale=en-US
```

**Body**
```json
{"whitelisted_data_fields":["LINE_ITEMS","SKU_RETURN_REQUESTS"],"filters":{"rma_ids":["2894521704838895640"],"package_ids":["2894521704838895645"],"statuses":["PENDING_PACKAGE_REVIEW"],"aftersales_request_ids":["4035319218955782461"],"main_order_ids":["577686530908261117"],"time":{"create_time":{"min_unix_time_inclusive":1774486592,"max_unix_time_exclusive":1774572992},"update_time":{"min_unix_time_inclusive":1774486592,"max_unix_time_exclusive":1774572992}}},"sort":{"sort_field":"CREATE_TIME","sort_order":"ASC"},"pagination":{"page_size":100,"page_token":"aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA=="}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^return_merchandise_authorizations | []object |  | List of return merchandise authorization (RMA) records matching the filters. This field is omitted when no records match. |
| ^^id | string | 2894521704838895640 | Unique identifier for this RMA data. |
| ^^package_id | string | 2894521704838895645 | Identifier of the associated physical return package. |
| ^^aftersales_request_id | string | 4035318504086604101 | Identifier of the parent aftersales request. |
| ^^status | string | AWAITING_BUYER_RETURN | The current state of this RMA data. |
| Possible values: |  |  |  |

* `INIT`
* `AWAITING_BUYER_RETURN`
* `RETURN_IN_TRANSIT`
* `PENDING_PACKAGE_REVIEW`
* `PACKAGE_REVIEW_COMPLETED` |
   ^^line_items |[]object | |Item units expected in this return package. This field is returned only when `LINE_ITEMS` is included in `whitelisted_data_fields` and matching item data is available. |
   ^^^return_line_item_id |string |4035227657962164811 |Unique identifier for this item in the return. In the case of virtual bundle, this is corresponds to the id of the original parent item bundle. |
   ^^^sub_return_line_item_id |string |4035227657962164815 |Unique identifier for this item in the return. In the case of virtual bundle, this is corresponds to the id of the current child item being returned. |
   ^^^sku_id |string |2729382476852921560 |SKU identifier associated with this item (for product details). |
   ^^^main_order_id |string |577686530908261117 |Identifier of the associated main (forward) order. |
   ^^^sku_return_request_id |string |4035318504086604100 |Identifier of the associated SKU-level, sub return request. |
   ^^sku_return_requests |[]object | |SKU-level sub return requests associated with this RMA. This field is returned only when `SKU_RETURN_REQUESTS` is included in `whitelisted_data_fields` and matching data is available. |
   ^^^order_id |string |577686530908261117 |TikTok Shop main order ID associated with this SKU return request. |
   ^^^return_id |string |4035318504086604100 |The identifier of a specific return. |
   ^^^return_type |string |REFUND |Return type.
   Available values:
* `REFUND`: Seller will issue a refund without return. The buyer is not required to send the item(s) back to the seller.
* `RETURN_AND_REFUND`: Buyer is required to send the item(s) back to the seller. The seller will need to review the condition of the returned item(s) before a refund can be issued to the buyer.
* `REPLACEMENT`: The buyer requires the seller to replace the item(s).
* `EXCHANGE`: The buyer requires the seller to exchange the item(s). |
   ^^^return_status |string |RETURN_OR_REFUND_REQUEST_PENDING |Return status.
   Available values:
* `RETURN_OR_REFUND_REQUEST_PENDING`: Buyer has initiated a return or refund request. The request is pending review by seller or platform.
* `REFUND_OR_RETURN_REQUEST_REJECT`: The return or refund request was rejected.
* `AWAITING_BUYER_SHIP`: The return request was approved. The seller is waiting for the buyer to ship the approved items to the seller. If the buyer doesn't ship the items to the seller before the deadline, the platform will close the request.
* `BUYER_SHIPPED_ITEM`: Buyer has shipped the approved items to seller.
* `REJECT_RECEIVE_PACKAGE`: Seller inspected the returned items and rejected the return package.
* `RETURN_OR_REFUND_REQUEST_SUCCESS`: The return/refund request was approved. The buyer will be refunded.
* `RETURN_OR_REFUND_REQUEST_CANCEL`: The request has been cancelled by the buyer or system.
* `RETURN_OR_REFUND_REQUEST_COMPLETE`: The return/refund was processed successfully. The buyer has been refunded.
* `REPLACEMENT_REQUEST_PENDING`: Buyer has initiated a replacement request. The request is pending review by seller.
* `REPLACEMENT_REQUEST_REJECT`: Seller reject the buyer replacement request.
* `REPLACEMENT_REQUEST_REFUND_SUCCESS`: Buyer's replacement request was resolved by refund due to insufficient inventory.
* `REPLACEMENT_REQUEST_CANCEL`: Buyer canceled the replacement request.
* `REPLACEMENT_REQUEST_COMPLETE`: Seller has approved the buyer's replacement request, platform will generate a new order for seller to fulfill.
* `AWAITING_BUYER_RESPONSE`: Seller offer another return type to the buyer, and waiting buyer response. Seller proposed return type can check the `seller_proposed_return_type`.
* `EXCHANGE_REQUEST_PENDING`: Buyer has initiated an exchange request. The request is pending review by seller.
* `EXCHANGE_REQUEST_REFUND_SUCCESS`: Buyer's exchange request was resolved by refund due to insufficient inventory.
* `EXCHANGE_REQUEST_CANCEL`: Buyer canceled the exchange request.
* `EXCHANGE_REQUEST_COMPLETE`: Seller has approved the buyer's exchange request, platform will generate a new order for seller to fulfill. |
   ^^^arbitration_status |string |IN_PROGRESS |Arbitration status.
   Available values:
* `IN_PROGRESS`: The TikTok Shop platform operator is processing arbitration and may request additional information from the seller.
* `SUPPORT_BUYER`: The platform operator supports the buyer.
* `SUPPORT_SELLER`: The platform operator supports the seller.
* `CLOSED`: Arbitration is closed. |
   ^^^role |string |BUYER |Return initiation role.
   Available values:
* `BUYER`
* `SELLER`
* `OPERATOR` : TikTok Shop platform operator.
* `SYSTEM`: TikTok Shop system.
   Please see "API overview" to learn more about roles. |
   ^^^return_reason |string |ecom_order_to_ship_canceled_reason_created_by_mistakes |Machine-readable reason code for the return. Use `return_reason_text` for localized display text. |
   ^^^return_reason_text |string |Order created by mistake |Reason for return, in localized text.
   You can change language using the locale request parameter. |
   ^^^seller_next_action_response |[]object | |Seller's next action and deadline. |
   ^^^^action |string |SELLER_RESPOND_REFUND |Seller's next action.
   Available values:
* `SELLER_RESPOND_REFUND`
* `SELLER_RESPOND_RETURN`
* `SELLER_RESPOND_RECEIVE_PACKAGE`
* `SELLER_RESPOND_REPLACEMENT` |
   ^^^^deadline |int |1690554680 |The deadline for the seller to perform the specified action, as a Unix timestamp in seconds. |
   ^^^shipment_type |string |PLATFORM |The shipment method selected by the buyer for sending the item(s) back to the seller.
   Available values:
* `PLATFORM`: The buyer uses TikTok Shop's shipping service. See `handover_method` for whether the buyer uses `DROP_OFF` or `PICKUP`.
* `BUYER_ARRANGE`: The buyer arranges the return shipment. |
   ^^^handover_method |string |DROP_OFF |The handover method buyer chooses to use when returning item(s) to seller using platform's shipping service.
* `DROP_OFF`: buyer will drop off the item(s) at courier
* `PICKUP`: buyer is scheduling a pick up service offered by the courier. |
   ^^^return_tracking_number |string |213456789098765433456 |The tracking number of parcels when buyer returns the item(s). |
   ^^^return_provider_name |string |J&T Express |The provider name of parcel when buyer returns the item(s). |
   ^^^return_provider_id |string |TH27014E9R5Q4G |The provider ID of parcel when buyer returns the items. |
   ^^^pre_return_id |string |4035310341095393452 |The previous return ID the current return order is edited from. |
   ^^^next_return_id |string |4035310341095393463 |The next return ID the current return order is edited to. |
   ^^^refund_amount |object | |Refund amount details. |
   ^^^^currency |string |USD |Payment currency. |
   ^^^^refund_total |string |1.23 |Total refund amount to buyer. |
   ^^^^refund_subtotal |string |1 |Subtotal refund amount to buyer. |
   ^^^^refund_shipping_fee |string |0.2 |Shipping fee refund amount to buyer. |
   ^^^^refund_tax |string |0.03 |Tax refund amount to buyer. |
   ^^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds 500,000 USD, according to US Colorado states' compliance rules. |
   ^^^^buyer_service_fee |string |0.1 |Buyer service fee. |
   ^^^return_line_items |[]object | |Return order lines items. |
   ^^^^return_line_item_id |string |4035227657962164811 |Return order line ID. |
   ^^^^order_line_item_id |string |576473917261451851 |Order line ID. |
   ^^^^sku_id |string |2729382476852921560 |SKU ID. |
   ^^^^sku_name |string |1#, Standard |SKU name. |
   ^^^^product_image |object | |Product image information. |
   ^^^^^url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447 |Product image URL. |
   ^^^^^width |int |200 |Product image width. Units: pixels (px). |
   ^^^^^height |int |200 |Product image height. Units: pixels (px). |
   ^^^^product_name |string |(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs |Product name. |
   ^^^^seller_sku |string |PUTIH 1 TALI |SKU name defined by seller. |
   ^^^^refund_amount |object | |Refund amount details. |
   ^^^^^currency |string |USD |Payment currency. |
   ^^^^^refund_total |string |1.23 |Total refund amount to buyer. |
   ^^^^^refund_subtotal |string |1 |Subtotal refund amount to buyer. |
   ^^^^^refund_shipping_fee |string |0.2 |Shipping fee refund amount to buyer. |
   ^^^^^refund_tax |string |0.03 |Tax refund amount to buyer. |
   ^^^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds 500,000 USD, according to US Colorado states' compliance rules. |
   ^^^^^buyer_service_fee |string |0.1 |Buyer service fee. |
   ^^^^return_sub_line_items |[]object | |Return sub order lines items.
   Sub items represent skus that belong to a "virtual bundle" that has been defined by a seller. The sub_items will include all relevant information about each item that is a part of the virtual bundle. |
   ^^^^^return_sub_line_item_id |string |4035227657962164812 |Return sub order line ID. |
   ^^^^^return_line_item_id |string |4035227657962164811 |Return order line ID. |
   ^^^^^sub_order_line_item_id |string |576473917261451852 |Sub order line ID. |
   ^^^^^order_line_item_id |string |576473917261451851 |Order line ID. |
   ^^^^^sku_id |string |2729382476852921560 |SKU ID. |
   ^^^^^sku_name |string |1#, Standard |SKU name. |
   ^^^^^product_image |object | |Product image information. |
   ^^^^^^url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447 |Product image URL. |
   ^^^^^^width |int |200 |Product image width. Units: pixels (px). |
   ^^^^^^height |int |200 |Product image height. Units: pixels (px). |
   ^^^^^product_name |string |(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs |Product name. |
   ^^^^^seller_sku |string |PUTIH 1 TALI |SKU name defined by seller. |
   ^^^^^refund_amount |object | |Refund amount details. |
   ^^^^^^currency |string |USD |Payment currency. |
   ^^^^^^refund_total |string |1.23 |Total refund amount to buyer. |
   ^^^^^^refund_subtotal |string |1 |Subtotal refund amount to buyer. |
   ^^^^^^refund_shipping_fee |string |0.2 |Shipping fee refund amount to buyer. |
   ^^^^^^refund_tax |string |0.03 |Tax refund amount to buyer. |
   ^^^^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds 500,000 USD, according to US Colorado states' compliance rules. |
   ^^^^^^buyer_service_fee |string |0.1 |Buyer service fee. |
   ^^^create_time |int |1690451136 |The time when the return was created, as a Unix timestamp in seconds. |
   ^^^update_time |int |1690453136 |The time when the return was last updated, as a Unix timestamp in seconds. |
   ^^^discount |object | |Discount refund amounts, denominated in the currency specified by `refund_amount.currency`. |
   ^^^^product_platform_discount |string |0.1 |The refund amount of platform discount. |
   ^^^^product_seller_discount |string |0.1 |The refund amount of product seller discount. |
   ^^^^shipping_fee_platform_discount |string |0.1 |The refund amount of shipping fee platform discount. |
   ^^^^shipping_fee_seller_discount |string |0.1 |The refund amount of shipping fee seller discount. |
   ^^^shipping_fee |object | |Return shipping fee amounts, denominated in the currency specified by `refund_amount.currency`. |
   ^^^^seller_paid_return_shipping_fee_amount |string |0.1 |The amount of return shipping fee seller paid. |
   ^^^^buyer_paid_return_shipping_fee_amount |string |0.1 |The amount of return shipping fee buyer paid. |
   ^^^^platform_paid_return_shipping_fee_amount |string |0.1 |The amount of return shipping fee platform paid. |
   ^^^buyer_keep_item |bool |true |Indicates whether the buyer may keep the item(s). This field is returned as `true` for replacement requests and is omitted for other return types. |
   ^^^return_shipping_document_type |string |SHIPPING_LABEL |The type of return shipping document selected by the buyer.
   Available values:
* `SHIPPING_LABEL`
* `QR_CODE` - QR Code with Box
* `QR_CODE_NBNL` - QR Code with No Box No Label |
   ^^^return_method |string |PLATFORM_SHIPPED |Return method:
* `SELLER_SHIPPED`: Seller offers the return shipping service.
* `BUYER_SHIPPED`: Buyer offers the return shipping service.
* `PLATFORM_SHIPPED`: TikTok Shop offers the return shipping service. |
   ^^^is_combined_return |bool |false |This field will return true if the buyer is asking to combine multiple returns into one return package. |
   ^^^combined_return_id |string |4035309948547073951 |If `is_combined_return` is `true`, this field will return the `combined_return_id` associated with the combined return. |
   ^^^seller_proposed_return_type |string |PARTIAL_REFUND |Seller proposed return type:
* `PARTIAL_REFUND` |
   ^^^partial_refund_amount |object | |Partial refund details. |
   ^^^^partial_refund_total |string |10 |The partial refund amount offered by seller.
   Note: only seller proposed partial refund will return this field. |
   ^^^^currency |string |IDR |Partial refund currency |
   ^^^buyer_rejected_partial_refund |bool |false |Only return this field when seller initiated the partial refund.
   Available values:
* `TRUE`: Buyer reject the seller partial refund offer.
* `FALSE`: Buyer accept the seller partial refund offer or awaiting buyer response. |
   ^^^return_warehouse_address |object | |The return warehouse address details provided by the seller. |
   ^^^^full_address |string |1199 Coleman Ave San Jose, CA 95110 |The full return warehouse address. |
   ^^^exchange_order_lines |[]object | |Ignore this field. It is not yet supported. |
   ^^^^order_line_id |string |0 |Ignore this field. It is not yet supported. |
   ^^^^sku_id |string |0 |Ignore this field. It is not yet supported. |
   ^^^^sku_name |string |0 |Ignore this field. It is not yet supported. |
   ^^^^product_name |string |0 |Ignore this field. It is not yet supported. |
   ^^^^seller_sku_name |string |0 |Ignore this field. It is not yet supported. |
   ^^^^product_image |object | |Ignore this field. It is not yet supported. |
   ^^^^^url |string |0 |Ignore this field. It is not yet supported. |
   ^^^^^width |int |0 |Ignore this field. It is not yet supported. |
   ^^^^^height |int |0 |Ignore this field. It is not yet supported. |
   ^^^^price_detail |object | |Ignore this field. It is not yet supported. |
   ^^^^^currency |string |0 |Ignore this field. It is not yet supported. |
   ^^^^^refund_total |string |0 |Ignore this field. It is not yet supported. |
   ^^^^^refund_subtotal |string |0 |Ignore this field. It is not yet supported. |
   ^^^^^refund_shipping_fee |string |0 |Ignore this field. It is not yet supported. |
   ^^^^^refund_tax |string |0 |Ignore this field. It is not yet supported. |
   ^^^reshipment_order_id |string |0 |Ignore this field. It is not yet supported. |
   ^^^is_quick_refund |bool |false |If the return hit the quick refund strategy, the seller cannot reject the received package |
   ^^^return_sub_line_items |[]object | |Deprecated. Do not use this field. |
   ^^^^return_sub_line_item_id |string |4035227657962164812 |Return sub order line ID. |
   ^^^^return_line_item_id |string |4035227657962164811 |Return order line ID. |
   ^^^^sub_order_line_item_id |string |576473917261451852 |Sub order line ID. |
   ^^^^order_line_item_id |string |576473917261451851 |Order line ID. |
   ^^^^sku_id |string |2729382476852921560 |SKU ID. |
   ^^^^sku_name |string |1#, Standard |SKU name. |
   ^^^^product_image |object | |Product image information. |
   ^^^^^url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447 |Product image URL. |
   ^^^^^width |int |200 |Product image width. Units: pixels (px). |
   ^^^^^height |int |200 |Product image height. Units: pixels (px). |
   ^^^^product_name |string |(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs |Product name. |
   ^^^^seller_sku |string |PUTIH 1 TALI |SKU name defined by seller. |
   ^^^^refund_amount |object | |Refund amount details. |
   ^^^^^currency |string |USD |Payment currency. |
   ^^^^^refund_total |string |1.23 |Total refund amount to buyer. |
   ^^^^^refund_subtotal |string |1 |Subtotal refund amount to buyer. |
   ^^^^^refund_shipping_fee |string |0.2 |Shipping fee refund amount to buyer. |
   ^^^^^refund_tax |string |0.03 |Tax refund amount to buyer. |
   ^^^^^retail_delivery_fee |string |0.1 |Retail delivery fee takes effect once platform GMV exceeds 500,000 USD, according to US Colorado states' compliance rules. |
   ^^^^^buyer_service_fee |string |0.1 |Buyer service fee. |
   ^total_count |int |12345 |The total result set size, independent of pagination. |
   ^next_page_token |string |aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA== |Used to fetch the next page/set of results. |

### Response Sample
```json
{"code":0,"data":{"return_merchandise_authorizations":[{"id":"2894521704838895640","package_id":"2894521704838895645","aftersales_request_id":"4035318504086604101","status":"AWAITING_BUYER_RETURN","line_items":[{"return_line_item_id":"4035227657962164811","sub_return_line_item_id":"4035227657962164815","sku_id":"2729382476852921560","main_order_id":"577686530908261117","sku_return_request_id":"4035318504086604100"}],"sku_return_requests":[{"order_id":"577686530908261117","return_id":"4035318504086604100","return_type":"REFUND","return_status":"RETURN_OR_REFUND_REQUEST_PENDING","arbitration_status":"IN_PROGRESS","role":"BUYER","return_reason":"ecom_order_to_ship_canceled_reason_created_by_mistakes","return_reason_text":"Order created by mistake","seller_next_action_response":[{"action":"SELLER_RESPOND_REFUND","deadline":1690554680}],"shipment_type":"PLATFORM","handover_method":"DROP_OFF","return_tracking_number":"213456789098765433456","return_provider_name":"J\u0026T Express","return_provider_id":"TH27014E9R5Q4G","pre_return_id":"4035310341095393452","next_return_id":"4035310341095393463","refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"0.1"},"return_line_items":[{"return_line_item_id":"4035227657962164811","order_line_item_id":"576473917261451851","sku_id":"2729382476852921560","sku_name":"1#, Standard","product_image":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447","width":200,"height":200},"product_name":"(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs","seller_sku":"PUTIH 1 TALI","refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"0.1"},"return_sub_line_items":[{"return_sub_line_item_id":"4035227657962164812","return_line_item_id":"4035227657962164811","sub_order_line_item_id":"576473917261451852","order_line_item_id":"576473917261451851","sku_id":"2729382476852921560","sku_name":"1#, Standard","product_image":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447","width":200,"height":200},"product_name":"(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs","seller_sku":"PUTIH 1 TALI","refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"0.1"}}]}],"create_time":1690451136,"update_time":1690453136,"discount":{"product_platform_discount":"0.1","product_seller_discount":"0.1","shipping_fee_platform_discount":"0.1","shipping_fee_seller_discount":"0.1"},"shipping_fee":{"seller_paid_return_shipping_fee_amount":"0.1","buyer_paid_return_shipping_fee_amount":"0.1","platform_paid_return_shipping_fee_amount":"0.1"},"buyer_keep_item":true,"return_shipping_document_type":"SHIPPING_LABEL","return_method":"PLATFORM_SHIPPED","is_combined_return":false,"combined_return_id":"4035309948547073951","seller_proposed_return_type":"PARTIAL_REFUND","partial_refund_amount":{"partial_refund_total":"10","currency":"IDR"},"buyer_rejected_partial_refund":false,"return_warehouse_address":{"full_address":"1199 Coleman Ave San Jose, CA 95110"},"exchange_order_lines":[{"order_line_id":"0","sku_id":"0","sku_name":"0","product_name":"0","seller_sku_name":"0","product_image":{"url":"0","width":0,"height":0},"price_detail":{"currency":"0","refund_total":"0","refund_subtotal":"0","refund_shipping_fee":"0","refund_tax":"0"}}],"reshipment_order_id":"0","is_quick_refund":false,"return_sub_line_items":[{"return_sub_line_item_id":"4035227657962164812","return_line_item_id":"4035227657962164811","sub_order_line_item_id":"576473917261451852","order_line_item_id":"576473917261451851","sku_id":"2729382476852921560","sku_name":"1#, Standard","product_image":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/004797ebfd8c4d3da2df1cc4bfdb0614~tplv-o3syd03w52-origin-jpeg.jpeg?from=4246405447","width":200,"height":200},"product_name":"(SP) [PROMO BUNDLING] NICE Tissue Facial 180s x 5 pcs","seller_sku":"PUTIH 1 TALI","refund_amount":{"currency":"USD","refund_total":"1.23","refund_subtotal":"1","refund_shipping_fee":"0.2","refund_tax":"0.03","retail_delivery_fee":"0.1","buyer_service_fee":"0.1"}}]}]}],"total_count":12345,"next_page_token":"aDU2dHIzMlFhME5CUzJKUDhDdVJhTDM1WmJkeFVTVW9LTkRaSnNaZCtuWjJXVU5CSDhlaA=="},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 25001001 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 25020005 | No permission to process this order |
| 25020008 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Available Review Decisions — `GET /return_refund/202606/review_decision`

Doc: https://partner.tiktokshop.com/docv2/page/get-available-review-decisions-202606 · cập nhật 2026-10-13 · scope: seller.return_refund.basic

### Path: /return_refund/202606/review_decision
### Method: [GET]
### Function Description
Description of [GET]/return_refund/:version/Get_Review_Decision

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
| seller_id | int | Y | 7494781899660428507 | The unique identifier of the seller/shop |
| return_or_cancel_id | string | Y | 4035319218955782461 | The identifier of the aftersales request to evaluate. Pass a reverse main order ID, aftersales request ID, or return merchandise authorization (RMA) ID; the API detects which type was provided. Do not pass an order ID or order line ID. |
| locale | string | N | en-US | The BCP-47 locale codes for displaying the return reason, delimited by commas. Default: en-US |
| Refer to [Locale codes](678e3a47bae28f030a8c7523) for the list of supported locale codes. |  |  |  |  |
| check_decisions | []string | N | APPROVE_REFUND,REJECT_RETURN | The seller decisions to evaluate for the specified aftersales request. Possible values: |

* `APPROVE_REQUEST_CANCEL`
* `APPROVE_REFUND`
* `APPROVE_RETURN`
* `APPROVE_RECEIVED_PACKAGE`
* `APPROVE_REPLACEMENT`
* `ISSUE_REPLACEMENT_REFUND`
* `DIRECT_REFUND`
* `REJECT_REQUEST_CANCEL`
* `REJECT_REFUND`
* `REJECT_RETURN`
* `REJECT_RECEIVED_PACKAGE`
* `REJECT_REPLACEMENT`
* `ISSUE_EXCHANGE_REFUND`
* `OFFER_PARTIAL_REFUND`
* `OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG`
   **Note:** When omitted, the API evaluates all supported seller decisions for the request and returns one result per decision. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202606/review_decision?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&seller_id=7494781899660428507&return_or_cancel_id=4035319218955782461&locale=en-US&check_decisions=APPROVE_REFUND,REJECT_RETURN
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^line_items | []object |  | Line items to which the returned decisions apply. Decision details apply to each line item individually. For example, a partial refund amount of 1.00 for each of three line items results in a total of 3.00; use the `currency` returned with the amount range rather than assuming a currency. |
| ^^return_line_item_id | string | 4035319218955782461 | Unique identifier for this item in the return. In the case of virtual bundle, this corresponds to the id of the original parent item bundle. |
| ^^sub_return_line_item_id | string | 4035227657962164815 | Unique identifier for this item in the return. In the case of virtual bundle, this corresponds to the id of the current child item being returned. |
| ^^decisions | []object |  | The list of candidate review decisions for this line item. |
| ^^^decision | string | OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG | Seller review decision evaluated for this line item. |
| Possible values: |  |  |  |

* `APPROVE_REQUEST_CANCEL`
* `APPROVE_REFUND`
* `APPROVE_RETURN`
* `APPROVE_RECEIVED_PACKAGE`
* `APPROVE_REPLACEMENT`
* `ISSUE_REPLACEMENT_REFUND`
* `DIRECT_REFUND`
* `REJECT_REQUEST_CANCEL`
* `REJECT_REFUND`
* `REJECT_RETURN`
* `REJECT_RECEIVED_PACKAGE`
* `REJECT_REPLACEMENT`
* `ISSUE_EXCHANGE_REFUND`
* `OFFER_PARTIAL_REFUND`
* `OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG` |
   ^^^eligible |bool |false |Whether this decision is currently eligible for the line item. When `false`, `ineligible_code` and `ineligible_reason` explain why the decision is ineligible; these fields are omitted when `true`. |
   ^^^ineligible_code |int |25005020 |The reason code for an ineligible decision. |
   ^^^ineligible_reason |string |the return is already completed, you can't approve again. |The reason for an ineligible decision. |
   ^^^available_reject_reasons |[]object | |Rejection reasons, if available, for this eligible decision. Each item contains a machine-readable name and display text. |
   ^^^^name |string |seller_reject_apply_product_has_been_packed |The machine-readable name of the rejection reason to pass as the rejection-reason identifier in the applicable review or reject request. |
   ^^^^text |string |The display text for the reject reason. |The display text for the rejection reason. |
   ^^^partial_refund_amount_range |object | |The allowed partial refund amount band. Returned for the `OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG` decision when it is eligible; omitted for all other decisions. |
   ^^^^min_amount |string |2.34 |The minimum partial refund amount the seller may offer. |
   ^^^^max_amount |string |3.33 |The maximum partial refund amount the seller may offer. |
   ^^^^currency |string |USD |The currency of the partial refund amount range, matching the currency of the current return request. |
   ^request_log_id |string |20260713225708FB… |The log id of this request, used for troubleshooting with TikTok Shop support. |
   ^errors |[]object | |Lists errors for partially failed requests. For example, if a request reviews multiple orders or items and only some fail, individual error details are returned here.
   **IMPORTANT**: Partial failures still return a top-level success code (0), so clients must also check this field to detect partial errors. For complete failures (e.g. validation errors), the top-level response code and message will indicate a failure, but this field will remain empty. |
   ^^code |string |98001004 |Error Code |
   ^^message |string |Invalid parameters. Please verify your input before retrying |Error Description |

### Response Sample
```json
{"code":0,"data":{"line_items":[{"return_line_item_id":"4035319218955782461","sub_return_line_item_id":"4035227657962164815","decisions":[{"decision":"OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG","eligible":false,"ineligible_code":25005020,"ineligible_reason":"the return is already completed, you can't approve again.","available_reject_reasons":[{"name":"seller_reject_apply_product_has_been_packed","text":"The display text for the reject reason."}],"partial_refund_amount_range":{"min_amount":"2.34","max_amount":"3.33","currency":"USD"}}]}],"request_log_id":"20260713225708FB…","errors":[{"code":"98001004","message":"Invalid parameters. Please verify your input before retrying"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 25001003 | Invalid order status. |
| 25005020 | reverse amount not support partial refund |
| 25005021 | partial refund only support single sku |
| 25011010 | request has been transferred to platform operator |
| 25011011 | reverse status cannot reject application |
| 25011012 | reverse status cannot approve application |


---

## Reject Return — `POST /return_refund/202606/returns/{return_id}/reject`

Doc: https://partner.tiktokshop.com/docv2/page/reject-return-202606 · cập nhật 2026-10-13 · scope: seller.return_refund.basic

### Path: /return_refund/202606/returns/{return_id}/reject
### Method: [POST]
### Function Description
Use this API to reject a buyer's refund-only, return-and-refund, or replacement request, or to offer a partial refund after the package is received. The valid decision depends on the current request type and status. Before calling this API, make sure the request is still awaiting the seller action that matches the decision you send.

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
| return_id | string | Y | 4035319218955782461 | The unique identifier of the return request to be rejected by the seller. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| idempotency_key | string | N | 40b456b1-78e7-412d-9fe6-82181496e1bd | A unique value generated by the client that the server uses to recognize repeated requests. Generate a collision-resistant value, such as a UUID, and reuse the same value when retrying the same request. If omitted, the server generates a key for the request; callers that need idempotent retries should provide and reuse their own key. Maximum length: 255 characters. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| decision | string | Y | REJECT_RECEIVED_PACKAGE | Seller's decision for the request, available values: |

* `REJECT_REFUND`: seller reject a refund-only request
* `REJECT_RETURN`: seller reject the initial return-and-refund request
* `REJECT_RECEIVED_PACKAGE`: seller reject return-and-refund request after the buyer has already shipped or handed over the item.
* `REJECT_REPLACEMENT`: seller reject replacement request
* `OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG`: seller offer partial refund regarding to the package item quality check |
   reject_reason |string |Y |seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |Seller's reason for rejecting the aftersales request. For `OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG`, first call Get Review Decision (`GET /return_refund/202606/review_decision`) for the same aftersales request: pass this request's `return_id` as `return_or_cancel_id` and set `check_decisions` to `OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG`. In the response, select the `data.line_items[]` entry for the affected return line item, then select its `decisions[]` entry whose `decision` is `OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG`, and submit one of that decision's `available_reject_reasons[].name` values in this field. For other decisions, use the [Get Decision Eligibility](https://partner.tiktokshop.com/docv2/page/69844a11eeba77049695c7f6) endpoint to retrieve the currently available rejection options for the same request and submit the returned rejection reason name. **Note**: Available decisions and rejection reasons depend on the current request status, so retrieve eligibility again before calling this API. |
   comment |string |N |I have reached an agreement with the buyer |Seller's comment about the rejection decision. For `OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG`, the comment must not exceed 500 characters. |
   images |[]object |N | |Images provided by the seller to support the decision. For `OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG`, a maximum of 6 images is allowed. |
   ^image_id |string |Y |tos-maliva-i-o3syd03w52-us/57a1c8908fe74572861ea5e50887d8d1 |Image URI obtained from the [Upload Product Image](https://partner.tiktokshop.com/docv2/page/6509df95defece02be598a22) API. |
   ^mime_type |string |N |image/png |MIME type. |
   ^height |int |N |200 |Image height
   Units: px |
   ^width |int |N |200 |Image width
   Units: px |
   partial_refund_amount |object |N | |Partial refund amount and currency. Required when `decision` is `OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG`. |
   ^partial_refund_total |string |N |4.66 |Partial refund amount. When `decision` is `OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG`, this field is required and must be a numeric string representing an amount greater than 0. |
   ^currency |string |N |USD |Currency of the partial refund amount. When `decision` is `OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG`, this field is required and must match the return order's currency. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202606/returns/4035319218955782461/reject?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&idempotency_key=40b456b1-78e7-412d-9fe6-82181496e1bd
```

**Body**
```json
{"decision":"REJECT_RECEIVED_PACKAGE","reject_reason":"seller_reject_apply_package_has_not_exceeded_estimated_delivery_time","comment":"I have reached an agreement with the buyer","images":[{"image_id":"tos-maliva-i-o3syd03w52-us/57a1c8908fe74572861ea5e50887d8d1","mime_type":"image/png","height":200,"width":200}],"partial_refund_amount":{"partial_refund_total":"4.66","currency":"USD"}}
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
| 11050001 | invalid param |
| 25001001 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 25001003 | Invalid order status. |
| 25001014 | Unknown return reason. Please ensure you are passing a valid return reason. |
| 25001016 | reverse reason not match action type |
| 25001020 | The provided return reason is currently offline. Please select a different return reason. |
| 25001028 | reverse lock failed |
| 25001057 | reverse reason not match reason type |
| 25001058 | reverse downstream data load error |
| 25007002 | db access error |
| 25007006 | Order not found. |
| 25011010 | request has been transferred to platform operator |
| 25011023 | forbid process authentic guarantee order |
| 25011025 | Quick refund forbid reject receive. |
| 25011026 | forbid process receive for FBT order |
| 25011035 | could not reject parcel now |
| 25020004 | decision not match reverse type |
| 25020005 | No permission to process this order |
| 25020008 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 25020010 | Aftersales has been approved and cannot be rejected. |
| 25020011 | return already received |
| 25020012 | status can't reject receive |


---

## Review Aftersales Requests — `POST /return_refund/202609/aftersales/review`

Doc: https://partner.tiktokshop.com/docv2/page/review-aftersales-requests-202609 · cập nhật 2026-10-13 · scope: seller.return_refund.basic

### Path: /return_refund/202609/aftersales/review
### Method: [POST]
### Function Description
API used to review (approve, reject, or offer alternatives to) a buyer's return request.

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
| aftersales_request_decisions | []object | N |  | Decisions to apply to aftersales requests. |
| ^request_id | string | Y | 4035319218955782461 | Identifies the object upon which this decision is made. |
| ^request_id_type | string | N | AFTERSALES | Type of identifier provided in request_id. |
| Possible values: |  |  |  |  |

* `AFTERSALES`
* `RMA` |
   ^line_item_decisions |[]object |Y | |Decisions applied at the line item level.
   One SKU may only have one decision, so all line items (corresponding to that same SKU) should fall under the same decision object.
   Different line item decisions for the same SKU will soon be supported in the future.
   |
   ^^line_items |[]object |Y | |Line items for which this decision applies. Decision details apply to each line item individually (e.g. a partial refund amount of $1.00 for 3 line items will result in a total partial refund amount of $3.00). |
   ^^^return_line_item_id |string |Y |4035227657962164811 |Unique identifier for this item in the return. In the case of virtual bundle, this corresponds to the id of the original parent item bundle. |
   ^^^sub_return_line_item_id |string |N |4035227657962164815 |Unique identifier for this item in the return. In the case of virtual bundle, this corresponds to the id of the current child item being returned. |
   ^^action |string |Y |APPROVE_REQUEST |Action/decision to be applied.
   Possible values:
* `APPROVE_REQUEST`
* `APPROVE_RETURN_PACKAGE`
* `REJECT_REQUEST`
* `REJECT_RETURN_PACKAGE`
* `REFUND_INSTEAD`
* `OFFER_PARTIAL_REFUND`
* `OFFER_PARTIAL_REFUND_AFTER_RECEIVING_PKG` |
   ^^alternative_solution_details |object |N | |Details for an alternative resolution (if applicable). |
   ^^^partial_refund_amount |string |N |12.34 |Proposed refund amount. |
   ^^^currency |string |N |USD |Currency of the refund amount (ISO 4217). Must match the currency of the forward order. |
   ^^reason |object |N | |To justify the action/decision (generally required for rejection). |
   ^^^reason_id |string |N |seller_reject_apply_package_has_not_exceeded_estimated_delivery_time |Seller's reason for rejecting the aftersales request. Use the [Get Review Decision](https://partner.tiktokshop.com/docv2/page/get-review-decision-202606) endpoint to retrieve the currently available rejection options for the same request, and submit the returned rejection reason name in this field.
   **Note**: The available decisions and rejection reasons can change depending on the current request status, so fetch eligibility again before calling this API. |
   ^^^text |string |N |I have reached an agreement with the buyer |Additional explanation for the decision. |
   ^^^media |object |N | |Supporting evidence (such as images). |
   ^^^^uri |string |N |tos-maliva-i-o3syd03w52-us/57a1c8908fe74572861ea5e50887d8d1 |Image URI obtained from the [Upload Product Image](https://partner.tiktokshop.com/docv2/page/6509df95defece02be598a22) API. |
   ^^^^mime_type |string |N |image/png |MIME type of the media (such as image/jpeg). |
   ^action_unix_time |int |N |1774486592 |The timestamp at which the decision/action was made (in unix seconds). |
   ^idempotency_key |string |N |40b456b1-78e7-412d-9fe6-82181496e1bd&app_key=38abcd |The idempotency key is a unique value generated by the client which the server uses to recognize the same request. How you create unique keys is up to you, but we suggest using UUIDs, or another random string with enough entropy to avoid collisions. Idempotency keys can be up to 255 characters long. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/return_refund/202609/aftersales/review?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"aftersales_request_decisions":[{"request_id":"4035319218955782461","request_id_type":"AFTERSALES","line_item_decisions":[{"line_items":[{"return_line_item_id":"4035227657962164811","sub_return_line_item_id":"4035227657962164815"}],"action":"APPROVE_REQUEST","alternative_solution_details":{"partial_refund_amount":"12.34","currency":"USD"},"reason":{"reason_id":"seller_reject_apply_package_has_not_exceeded_estimated_delivery_time","text":"I have reached an agreement with the buyer","media":{"uri":"tos-maliva-i-o3syd03w52-us/57a1c8908fe74572861ea5e50887d8d1","mime_type":"image/png"}}}],"action_unix_time":1774486592,"idempotency_key":"40b456b1-78e7-412d-9fe6-82181496e1bd\u0026app_key=38abcd"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^errors | []object |  | Lists errors for partially failed requests. For example, if a request reviews multiple orders or items and only some fail, individual error details are returned here. |
**IMPORTANT**: Partial failures still return a top-level success code (0), so clients must also check this field to detect partial errors. For complete failures (e.g. validation errors), the top-level response code and message will indicate a failure, but this field will remain empty. |
^^code |string |98001004 |Error code. |
^^message |string |Invalid parameters. Please verify your input before retrying |Error description. |
### Response Sample
```json
{"code":0,"data":{"errors":[{"code":"98001004","message":"Invalid parameters. Please verify your input before retrying"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 11050001 | invalid param |
| 25001001 | An invalid request parameter was passed. Please check that you have the correct parameter type(s) and format. |
| 25001003 | Invalid order status. |
| 25001028 | reverse lock failed |
| 25001044 | ConfirmReceive fulfillment order failed |
| 25001058 | reverse downstream data load error |
| 25007006 | Order not found. |
| 25007007 | ReverseOrderExistNegotiate |
| 25011010 | request has been transferred to platform operator |
| 25011012 | reverse status cannot approve application |
| 25011013 | reverse status cannot approve receive |
| 25011023 | forbid process authentic guarantee order |
| 25011026 | forbid process receive for FBT order |
| 25011032 | ReverseInvalidStatusPartialRefund |
| 25020004 | decision not match reverse type |
| 25020005 | No permission to process this order |
| 25020008 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 25020009 | reverse already cancelled |

# Fulfilled by TikTok (FBT) — tài liệu chi tiết

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.




---

## FBT Inbound API — Overview Guide

Doc: https://partner.tiktokshop.com/docv2/page/16f0ojsg · cập nhật 2026-05-06

**Consolidated Reference** — Getting Started, Key Concepts, Workflow Diagram, and Merchant Integration Guide for the FBT Inbound and Goods Creation APIs. 

#### 1. Overview
The **FBT Inbound API** suite enables sellers and logistics partners to programmatically create, manage, and track inbound shipments to TikTok's **Fulfillment by TikTok (FBT)** warehouses.
#####  New API Capabilities
FBT is launching **2 new API groups** alongside the existing APIs (which already support inventory search, inbound search, and inventory records).
**① Create Inbound**
End-to-end workflow to ship inventory into FBT warehouses:

* Create an inbound plan & placement selection
* Confirm shipping method & review requirements
* Pack & ship — submit carton or unit manifest
* Get shipping labels & update carrier tracking
* Manage & cancel inbound orders as needed

→ Covered by **Carton Splitting** & **Unit Splitting**
**② Create & Match Goods**
Manage the FBT goods catalog and bind TikTok Shop SKUs:

* Check hazmat & expiration requirements per SKU
* Create FBT goods records and bind to Shop SKUs
* Update goods info (dimensions, barcodes, hazmat)
* Manage SKU-to-goods bindings (bind / unbind)

→ Covered by **Goods Management**

##### Two Inbound Workflows Supported
**Carton Splitting**

* Inventory is pre-packed into cartons before inbound creation and shipping
* Each carton contains one or more SKUs
* TikTok assigns warehouse per carton

**Unit Splitting**

* Inventory is not packed at time of inbound creation, packing information is shared later during ship step
* Higher flexibility for flow based packing

**Required Auth Scope**: `seller.fbt.inbound` — all endpoints in both workflows require this scope on the seller access token.

#### 2. Key Concepts
Core terminology for FBT API integration.
#####  Merchant
A **Merchant** represents an entity that offers products or services for sale in TikTok Shop with FBT fulfillment. Every merchant has a unique **FBT Merchant ID**, required before any API calls can be made.
> **Getting your Merchant ID**: Merchant IDs are assigned during FBT onboarding. Use **Get FBT Merchant Onboarded Regions** to verify a seller is registered and retrieve their active regions before calling any inbound APIs.

#####  Goods
**FBT Goods** is a unique record assigned by FBT to track and manage an individual seller's inventory within the Fulfilled by TikTok system.
Goods must be **matched to a TikTok product ID** before merchants can create inbound shipments, manage inventory, or fulfill orders. If goods are unmatched from SKUs, the corresponding inventory is no longer available for sale on TikTok Shop.
**Key Terms**
| Full Name | Who Assigns It | Used In |
| --- | --- | --- |
| TikTok Shop Product /SKU ID | TikTok Shop (from your product catalog) | CreateGoods, GetHazmatInfo, UpdateSkuRelation |
| FBT Goods ID | FBT system — returned on CreateGoods success | UpdateGoods, UpdateSkuRelation, Inbound APIs |
**Goods Lifecycle**

1. **Check requirements** — call *Get Hazmat & Expiration Info* to determine special handling needs
2. **Create & bind** — call *Create Goods* with `CREATE_AND_BIND` to create the FBT goods record and link it to a TikTok Shop SKU
3. **Create inbound** — once matched, use the Inbound APIs to ship inventory
4. **Manage bindings** — use *Update Goods SKU Relation* to add or remove SKU associations at any time

**Tip**: A single FBT Goods record can be bound to **multiple TikTok Shop SKUs (1:N)** when the merchant enables channel inventory — useful for selling the same physical product across multiple shops or regions.

##### FBT Warehouse
FBT warehouses are **subscribed automatically after onboarding**. There are two warehouse types, each with a distinct role:
| Warehouse Type | Accepts Inbound | Fulfills Orders | Notes |
| --- | --- | --- | --- |
| **HUB** | ✅ Yes | ❌ No | Inbound processing & sorting only — inventory is transferred to an FC before becoming sellable.   Charges hub placement fees, refer to FBT [merchant academy](https://scm-us.tiktok.com/merchant-university/home) for fees details  |
| **FC** (Fulfillment Center) | ✅ Yes | ✅ Yes | Receives inventory; used for order fulfillment.   Merchants cannot select these manually, FBT placement decides FC. |
Use **Get FBT Warehouse List** to retrieve all warehouse IDs, names, addresses, and types. The `warehouse_id` returned is required when creating an inbound plan.

#### 3. Authentication
Every API request must include the following headers:
| Header | Value | Notes |
| --- | --- | --- |
| `content-type` | `application/json` | Required on all requests |
| `x-tts-access-token` | Your seller access token | Obtain via TikTok Shop OAuth (`user_type = 0`). **Tokens expire** — build refresh logic into your pipeline |
**Example**
```HTTP
POST /fbt/202602/create_update_inbound_plan?shop_id=123456 HTTP/1.1
content-type: application/json
x-tts-access-token: eyJhbGciOiJSUzI1NiIsInR5cCI6...
```

**Token Expiry**: Access tokens expire. Always check expiry time and refresh using the refresh token before making API calls in automated pipelines.

#### 4. Before You Start — Checklist
Confirm all of the following before making your first API call:

- [ ] You have a valid **FBT Merchant ID** (assigned during FBT onboarding). Verify with *Get FBT Merchant Onboarded Regions*
- [ ] Your TikTok Shop goods are **created and matched** to FBT via the Goods Management APIs or the FBT seller portal
- [ ] You have a **seller access token** with the `seller.fbt.inbound` OAuth scope
- [ ] You have decided between **Carton Splitting** (pre-packed boxes) and **Unit Splitting** (loose units)
- [ ] You have decided between **Single_Hub (Single Shipment)** and **D2FC (Multiple Shipments)** to FBT

#### 5. Create & Match Goods — API Overview
Before sending inventory to FBT, sellers must have **FBT Goods records created and matched** to their TikTok Shop SKUs. These APIs should typically be called **before** creating an inbound plan.
##### Recommended Goods Setup Sequence
| # | API | Method | Purpose | Key Output |
| --- | --- | --- | --- | --- |
| 1 | **Get Hazmat & Expiration Info** | POST | Check if SKUs have hazmat classification or expiration/shelf-life rules before creating goods. Up to 50 SKUs per call. | Hazmat flags, shelf-life rules |
| 2 | **Create Goods** | POST | Create FBT goods records and bind to TikTok Shop SKUs (`CREATE_AND_BIND`). Include hazmat/shelf-life fields if flagged in step 1. | `tts_goods_id` |
| 3 | **Update Goods** | POST | Edit an existing goods record — name, dimensions, barcodes, return handling, hazmat/shelf-life info. | Update confirmation |
| 4 | **Update Goods SKU Relation** | POST | Manage bindings between FBT goods and Shop SKUs. Use `BIND` to add or `UN_BIND` to remove. | Operation confirmation |
##### Key Goods Parameters
| Parameter | Where Used | Description |
| --- | --- | --- |
| `tt_sku_id` | GetHazmat, CreateGoods | TikTok Shop SKU ID — primary identifier from the seller's product catalog |
| `tts_goods_id` | UpdateGoods, UpdateSkuRelation | FBT Goods ID — assigned on CreateGoods success. **Save this value** |
| `create_goods_type` | CreateGoods | `CREATE_AND_BIND` — creates the FBT goods record and binds it to the SKU in one call |
| `operation_type` | UpdateSkuRelation | `BIND` to associate a SKU, `UN_BIND` to remove association |
##### Special Handling Flags
Some products require additional data fields when creating goods:

* **Hazmat** (`is_hazmat = true`): Must provide `hazmat_info` with `hazmat_type` (`BATTERY`, `MAGNETIZED`, `FLAMMABLE_LIQUID`, `AEROSOLS`) and type-specific details
* **Battery products**: Require battery type (`LITHIUM_ION`, `LITHIUM_METAL`, `OTHER`), capacity, packaging type (`STANDALONE` / `IN_EQUIPMENT` / `WITH_EQUIPMENT`), and UN code. Please note SDS for 

Please refer to the table below for hazmat info mapping rule
| **Hazmat type** | **Class** | **How batteries are packed** | **Battery type** | **Flammable liquid type** | **Un code** |
| --- | --- | --- | --- | --- | --- |
| Battery | 9 | Standalone | Lithion Ion |  | UN 3480 |
| Battery | 9 | Standalone | Lithion metal |  | UN3090 |
| Battery | 9 | Standalone | Other |  | Other |
| Battery | 9 | In equipment | Lithion Ion |  | UN 3481 |
| Battery | 9 | In equipment | Lithion metal |  | UN3091 |
| Battery | 9 | In equipment | Other |  | Other |
| Battery | 9 | With equipment | Lithion Ion |  | UN 3481 |
| Battery | 9 | With equipment | Lithion metal |  | UN3091 |
| Battery | 9 | With equipment | Other |  | Other |
| Magnetized material | 9 |  |  |  | UN2807 |
| Flammable liquids | 3 |  |  | Paints | UN1263 |
| Flammable liquids | 3 |  |  | Perfumery products | UN1266 |
| Flammable liquids | 3 |  |  | Alcohols | UN3065 |
| Flammable liquids | 3 |  |  | Other | Other |
| Aerosols | 2 |  |  |  | UN1950 |
| Aerosols | 2 |  |  |  | Other |

* **Shelf-Life** (`is_expiration_management = true`): Must provide `shelf_life_attribute_info` including inbound cutoff days, expiration alert days, sales cutoff days and handling methods for expired units

#### 6. Choose Your Inbound Workflow
| Criteria | Carton Splitting | Unit Splitting |
| --- | --- | --- |
| **When to use** | You know carton dimensions & contents before shipping | You have not packed cartons at time of inbound order creation, or cartons are packed dynamically by your warehouse |
| **inbound_type value** | `CARTON_SPLITTING` | `UNIT_SPLITTING` |
| **Carton data in payload** | Required — at plan creation;  | Not required, has to be provided later at Ship IBR step   |

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/9589c9d242b34d60847afa481ab4a129~tplv-k9wyc2ijk0-image.image)

#### 7. Create Inbound — API Call Sequence
Follow these **9 steps in order**. Each step may produce IDs required by the next step. Both workflows (Carton / Unit) share this same sequence — the only differences are in request/response fields.
| # | API | Method | Purpose | Key Output | Comments |
| --- | --- | --- | --- | --- | --- |
| 1 | **Create / Update Inbound Plan** | POST | Create a new inbound plan or update an existing draft. Specify SKUs, quantities, and destination warehouse. | `inbound_plan_id` |  |
| 2 | **List Available Inbound Methods** | GET | Retrieve available Inbound methods with expected time ranges for the plan (Single Hub, D2FC).  For hubs it also includes placement fee estimate.    | ETA for which an Inbound method is available | This step tells you about availability of inbound methods.  FBT Inbound method  |
| 3 | **Get Inbound Method Detail** | POST | Get details for each inbound method and ETA, including placement option id and warehouse id.  For hubs it also includes placement fee estimate.  | `placement_option_id`  If you want to go to a specific hub, please use the correct placement option id corresponding to the hub. | **Async polling operation**: This endpoint may take up to **3-5 seconds** to return success.  We recommend polling every 3-5 seconds until placement task is successful    |
| 4 | **Confirm Inbound Method** | POST | Select and confirm the preferred inbound method and placement option. Include the `placement_option_id` returned from Step 3. | Confirmed `inbound_order_ids`  For single hub, you will get 1 order id  For D2FC you will see a list of order ids   |  |
| 5 | **Ship Inbound Order** | POST | Submit final shipment details: carton/unit manifest, carton contents if unit split   | `inbound_order_id` status changes to "shipped" | This is required to receive inventory. Inbound orders that have not been shipped will result in NCI |
| 6 | **Print Label** | POST | Generate printable shipping labels (per carton / per shipment). | Label PDF / URL | **Async polling operation**: This endpoint may take up to **30 seconds** to return success.  We recommend polling every 3-5 seconds until task_status is successful and URL is returned |
| 7 | **Update Tracking** | POST | Push carrier tracking number after small parcel label is available for each carton. |  |  |
| 8 | **Get Inbound Order** | GET | Retrieve order details | Order status & details |  |
| 9 | **Cancel Inbound Order** | POST | Cancel an order (only before warehouse receives the shipment).   Please note D2FC IBR cancellation may incur a fee if part of the plan is received and remaining is not received.  | Cancellation confirmation |  |
Key Field Reference
##### `plan_id` — Create vs Update
| Scenario | `plan_id` in request body |
| --- | --- |
| Creating a new inbound plan | **Omit** — the system generates and returns a new `inbound_plan_id` |
| Updating an existing draft plan | **Required** — include the `inbound_plan_id` returned from the original create call |
##### Timestamp— Format
All `timestamp` fields inside request parameters must be a **Unix timestamp in seconds (UTC)**:
```JSON
{
  "cartons": [
    {
      "items": [
        {
          "tts_goods_id": "9988776655",
          "quantity": 10,
          "expiration_timestamp": "1780000000"
        }
      ]
    }
  ]
}
```

> Use seconds (UTC), **not milliseconds**.

#### 8. Error Handling
##### HTTP Error Codes

* **400 Bad Request** — Validate all required fields and data types before submission
* **401 Unauthorized** — Token expired or missing. Refresh and retry
* **409 Conflict** — Duplicate plan/order. Check `idempotency_key` or existing records
* **429 Rate Limited** — Implement exponential backoff with jitter. Default limit: **10 req/sec per shop**
* **5xx Server Error** — Retry with backoff (max 3 retries). Log `request_id` from response headers for escalation

##### Common Issues & Fixes
**ETA slot unavailable.** ETA helps FBT plan warehouse inbound capacity. **** During peak some inbound methods or sites might not be available, please select a different ETA 

* Retrieve available ETAs from *Get Inbound Method Detail* (Step 3) and pick from that list

**Generic "Internal Error" on Create Inbound Plan:** Try the following steps

* Verify your goods are matched to TikTok Shop SKUs (unmatched goods cannot be inbounded)
* If it persists, escalate with full request payload and `request_id` from the response header

**Print Label API delay** Label printing runs **asynchronously** after print label API call.

#### 9. Other FBT APIs & Webhooks
| # | Type | API / Webhook | Description |
| --- | --- | --- | --- |
| 1 | API | Get FBT Warehouse List | Retrieve all FBT warehouse info including name and address |
| 2 | API | Search Goods Info | Retrieve goods info including dimensions and weight as verified by the warehouse |
| 3 | API | Search FBT Inventory | Retrieve inventory details — sellable, reserved, unsellable, and in-transit at warehouse level |
| 4 | API | Search FBT Inventory Record | Retrieve inventory change records, filterable by warehouse and time range |
| 5 | API | Get Inbound Orders | Retrieve inbound order details including planned/actual inbound detail and status |
| 6 | Webhook | Merchant Onboard | Triggered when a seller onboards to FBT |
| 7 | Webhook | Goods Match | Triggered when a TikTok Shop SKU is matched or unmatched with FBT goods |
| 8 | Webhook | FBT Inventory Update | Triggered when FBT inventory is updated |
| 9 | Webhook | FBT Inbound Status Change | Triggered when an FBT inbound order status is updated |

#### 10. Testing & Go-Live Checklist
##### Go-Live

- [ ] Token refresh logic implemented
- [ ] ETA selection: Retrieve available ETA by calling List Inbound method 
- [ ] Label generation: call Print Label after brief async delay post-printlable
- [ ] Error handling: log `request_id` from response for all 5xx errors
- [ ] Goods matching confirmed for all SKUs in your inbound plan
- [ ] Warehouse confirmed as active for your merchant
- [ ] Move to production with real `shop_id` and credentials **only after sandbox sign-off**

#### 11. FAQs
##### Inbound Method Values
**Q: What do D2FC and ONE_HUB mean in ListAvailableInboundMethod response?**

* **D2FC**: *Direct to Fulfillment Center* — your shipment goes directly to the final FC that fulfills customer orders
* **ONE_HUB**: Your shipment is first sent to a hub/consolidation point for sorting, then forwarded to the FCThese are the two standard values; additional region-specific values may be available depending on the warehouse location.

**Q: Can I update the tracking number after submission?​**Yes — use the *Update Tracking* API to push a new or corrected carrier tracking number at any time after handing off to the carrier.


---

## Get FBT Merchant Onboarded Regions — `GET /fbt/202409/merchants/onboarded_regions`

Doc: https://partner.tiktokshop.com/docv2/page/get-fbt-merchant-onboarded-regions-202409 · cập nhật 2025-12-18 · scope: seller.fbt.info

### Path: /fbt/202409/merchants/onboarded_regions
### Method: [GET]
### Function Description
This API verifies whether a seller is registered as a Fulfillment by TikTok (FBT) merchant. If the seller is onboarded, the API returns the regions where the merchant is authorized to operate under the FBT system.

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
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202409/merchants/onboarded_regions?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^onboarded_regions | []object |  | A list of countries or regions where the merchant is onboarded and can conduct business in the Fulfilled by TikTok system. If seller is not onboarded, `data` will be empty. |
| ^^region_code | string | GB | The country or region codes follow the two-character ISO 3166-1 alpha-2 format. |
### Response Sample
```json
{"code":0,"data":{"onboarded_regions":[{"region_code":"GB"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get FBT Warehouse List — `GET /fbt/202408/warehouses`

Doc: https://partner.tiktokshop.com/docv2/page/get-fbt-warehouse-list-202408 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202408/warehouses
### Method: [GET]
### Function Description
This API is used to retrieve all Fulfilled by TikTok warehouse information including the warehouse name, warehouse address information, etc. The IDs of subscribed warehouses can be used to query inventory-related information.

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
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202408/warehouses?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^warehouses | []object |  | A list of Fulfilled by TikTok warehouses information. |
| ^^fbt_warehouse_id | string | 121219993203023 | The identifier for warehouse generated by Fulfilled By TikTok system. |
| ^^warehouse_ids | []string | ["161213293423029", "181213293423030"] | The warehouse IDs generated by TikTok Shop that are associated with this Fulfilled by TikTok warehouse (`fbt_warehouse_id`). |
| ^^name | string | TikTok_Eastvale(CA) | The Fulfilled by TikTok warehouse name, e.g.TikTok_Eastvale(CA). |
| ^^type | string | PLATFORM_WAREHOUSE | The Fulfilled by TikTok warehouse type. |
| Possible values: |  |  |  |

* `PLATFORM_WAREHOUSE`: A warehouse operated by TikTok.
* `OTHER_WAREHOUSE`: A warehouse that is not classified as a platform warehouse. |
   ^^subscribed |bool |true |A flag indicating whether the warehouse is subscribed.
   True: Subscribed.
   False: Not subscribed. |
   ^^addresses |[]object | |A list of addresses used to receive inbound shipments at the Fulfilled by TikTok warehouse. |
   ^^^postal_code |string |92376 |Warehouse address postal code (also known as zip code). |
   ^^^region_code |string |US |Warehouse country or region code in two-character ISO 3166-1 alpha-2 format. |
   ^^^state |string |CA |Warehouse address state or province. |
   ^^^district |string |San Bernardino |Warehouse address district or county. |
   ^^^city |string |Rialto |Warehouse address city. |
   ^^^address_line_1 |string |1420 Tamarind Ave, Rialto, San Bernardino |The detail address line 1. |
   ^^^address_line_2 |string | |The detail address line 2, additional address information(optional). |
   ^^^address_line_3 |string | |The detail address line 3, additional address information(optional). |
   ^^logistics_services |[]object | |A list of logistics service information related to the current warehouse. |
   ^^^id |string |12123232323 |The identifier for logistics service in TikTok Shop system. |
   ^^^name |string |Fulfilled by TikTok Shop-Standard |The logistics service name. |
   ^^^subscribed |bool |true |A flag indicating whether the logistic service is subscribed.
   True: Subscribed.
   False: Not subscribed. |

### Response Sample
```json
{"code":0,"data":{"warehouses":[{"fbt_warehouse_id":"121219993203023","warehouse_ids":["161213293423029","181213293423030"],"name":"TikTok_Eastvale(CA)","type":"PLATFORM_WAREHOUSE","subscribed":true,"addresses":[{"postal_code":"92376","region_code":"US","state":"CA","district":"San Bernardino","city":"Rialto","address_line_1":"1420 Tamarind Ave, Rialto, San Bernardino","address_line_2":" ","address_line_3":" "}],"logistics_services":[{"id":"12123232323","name":"Fulfilled by TikTok Shop-Standard","subscribed":true}]}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Search FBT Inventory — `POST /fbt/202408/inventory/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-fbt-inventory-202408 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202408/inventory/search
### Method: [POST]
### Function Description
This API is used to retrieve detailed inventory information for goods and matched SKUs, including sellable inventory, reserved inventory, unsellable inventory, and in-transit inventory at the warehouse level.

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
| page_size | int | Y | 50 | The number of results to be returned per page. |
| Valid range: [1-100]. |  |  |  |  |
| page_token | string | N | cGFnZV9udW1iZXI9Mg== | Pagination page token. It should be empty for the first page. |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| goods_ids | []string | N | ["256080616234","2231616264"] | The identifiers for goods generated by the Fulfilled by TikTok system. Maximum: 100 goods IDs per request. If specified, only inventory information for those goods is returned. If both `goods_ids` and `sku_ids` are omitted, all goods with non-zero inventory are returned. |
Do not provide `goods_ids` and `sku_ids` in the same request. Both fields may be omitted. |
fbt_warehouse_ids |[]string |N |["7232382932030232"] |The identifiers of warehouses generated by the Fulfilled by TikTok system. Specify up to 100 warehouse IDs to return inventory records only for subscribed warehouses that match those IDs. If omitted or empty, inventory records from all warehouses subscribed by the merchant are returned. |
sku_ids |[]string |N |["256080616234"] |TikTok Shop SKU identifiers used to select goods matched to those SKUs. Maximum: 100 SKU IDs per request. Do not provide `sku_ids` and `goods_ids` in the same request; both fields may be omitted. For each matched goods record, the returned `goods.skus` list contains the SKU inventory supplied for that goods record and is not restricted to the requested SKU IDs. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202408/inventory/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_size=50&page_token=cGFnZV9udW1iZXI9Mg==
```

**Body**
```json
{"goods_ids":["256080616234","2231616264"],"fbt_warehouse_ids":["7232382932030232"],"sku_ids":["256080616234"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^next_page_token | string | cGFnZV9udW1iZXI9Mg== | An opaque token used to retrieve the next page of a paginated result set. Provide this value in the `page_token` parameter of your next request. An empty `next_page_token` means there are no more pages. |
| ^total_count | int | 22113 | The total number of warehouse-goods inventory records that match the applied filters. |
| ^inventory | []object |  | A list of inventory records. Each item represents one goods item at one Fulfilled by TikTok warehouse and can include the associated SKU inventory breakdown. |
| ^^goods | object |  | The reference used to track products and SKUs within Fulfilled by TikTok's network. |
| ^^^id | string | 69167899745030 | The identifier for goods generated by Fulfilled by TikTok system. |
| ^^^reference_code | string | water01 | The identifier for goods defined by the merchant, commonly used to reference the ID from the merchant's other order management systems. |
| ^^^name | string | 100ml water | The goods name. |
| ^^^skus | []object |  | A list of inventory information for Stock Keeping Units (SKUs) matched with current Fulfilled by TikTok goods. |
| ^^^^id | string | 73243612345 | The identifier for SKU generated by TikTok Shop system. |
| ^^^^on_hand_detail | object |  | The inventory information of SKU physically in the warehouse, excluding those in transit or broken. |
| ^^^^^total_quantity | int | 20 | The total number of units for current SKU, consist of `available_quantity` and `reserved_quantity`. |
| ^^^^^available_quantity | int | 5 | The number of units available for sale. |
| Note: |  |  |  |
| The number does not include reserved units. |  |  |  |
| ^^^^^reserved_quantity | int | 15 | The number of units reserved for customer orders or return to supplier shipment. |
| ^^fbt_warehouse_id | string | 7232382932030232 | The identifier for warehouse generated by Fulfilled by TikTok system. |
| ^^in_transit_quantity | int | 10 | The number of goods units currently en route to the warehouse. The inventory includes inbound replenishments, customer returns, unsuccessful delivery returns, etc. |
| ^^on_hand_detail | object |  | The current-in-warehouse inventory detail for the goods. |
| ^^^total_quantity | int | 20 | The total on-hand quantity for the goods at the Fulfilled by TikTok warehouse, excluding in-transit inventory. |
| ^^^available_quantity | int | 5 | The number of units available for sale. |
| Note: |  |  |  |
| The number does not include reserved units. |  |  |  |
| ^^^reserved_quantity | int | 15 | The number of units reserved for customer orders or return to supplier shipment. |
| ^^^unfulfillable_quantity | int | 0 | The number of defective units in the warehouse. |
### Response Sample
```json
{"code":0,"data":{"next_page_token":"cGFnZV9udW1iZXI9Mg==","total_count":22113,"inventory":[{"goods":{"id":"69167899745030","reference_code":"water01","name":"100ml water","skus":[{"id":"73243612345","on_hand_detail":{"total_quantity":20,"available_quantity":5,"reserved_quantity":15}}]},"fbt_warehouse_id":"7232382932030232","in_transit_quantity":10,"on_hand_detail":{"total_quantity":20,"available_quantity":5,"reserved_quantity":15,"unfulfillable_quantity":0}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Search FBT Inventory Record — `POST /fbt/202410/inventory_records/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-fbt-inventory-record-202410 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202410/inventory_records/search
### Method: [POST]
### Function Description
This API is used to retrieve detailed inventory change records for goods at the warehouse level.

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
| page_size | int | Y | 50 | The number of results to return per page. |
| Valid range: [1-100]. |  |  |  |  |
| Pagination is limited to the first 20,000 results. |  |  |  |  |
| page_token | string | N | cGFnZV9udW1iZXI9Mg== | Pagination page token. It should be empty for the first page. |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | string | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| goods_ids | []string | N | ["256080616234","2231616264"] | The IDs of goods generated by the Fulfilled by TikTok system to search. Maximum: 100 IDs. If IDs are provided, the API returns only inventory records for those goods; if omitted, it returns inventory records for all goods with non-zero inventory. |
| fbt_warehouse_ids | []string | N | ["7232382932030232"] | The IDs of Fulfilled by TikTok warehouses to search. Maximum: 100 IDs. The API searches only warehouses available to the merchant: if IDs are provided, the search is limited to matching IDs; if omitted, all available warehouses are searched. |
| create_time_ge | int | N | 1293013251 | Filter inventory record creation time to show only those that are created on or after the specified date and time. Unix timestamp in seconds. `create_time_ge` is 0 by default. |
| create_time_le | int | N | 1393013251 | Filter inventory record creation time to show only those that are created on or before the specified date and time. Unix timestamp in seconds. `create_time_le` is the current time by default. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202410/inventory_records/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_size=50&page_token=cGFnZV9udW1iZXI9Mg==
```

**Body**
```json
{"goods_ids":["256080616234","2231616264"],"fbt_warehouse_ids":["7232382932030232"],"create_time_ge":1293013251,"create_time_le":1393013251}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^inventory_records | []object |  | A list of inventory records information. |
| ^^goods | object |  | The reference used to track products and SKUs within Fulfilled by TikTok's network. |
| ^^^id | string | 12324323 | The identifier for goods generated by Fulfilled by TikTok system. |
| ^^^reference_code | string | water01 | The identifier for goods defined by merchant. |
| ^^^name | string | 100ml water | The goods name. |
| ^^fbt_warehouse_id | string | 7232392932323 | The identifier for warehouse generated by Fulfilled by TikTok system. |
| ^^order | object |  | The information of order that triggers current inventory change. |
| ^^^id | string | OBF8932302030203 | The identifier for order generated by Fulfilled by TikTok system. |
| ^^^type | string | INBOUND_ORDER | The type of order. |
| Possible values: |  |  |  |

* INBOUND_ORDER
* RETURN_TO_SUPPLIER_ORDER
* DISPOSAL
* INVENTORY_STATUS_ADJUSTMENT_ORDER
* CONSIGN_ORDER
* INVENTORY_COUNT_ORDER
* FAILED_DELIVERY
* CUSTOMER_RETURN
* INVENTORY_QUANTITY_ADJUSTMENT_ORDER
* INVENTORY_TRANSFER_ORDER |
   ^^create_time |int |1212139230 |The time when the inventory record is created, Unix timestamp in seconds. |
   ^^inventory_goods_type |string |NORMAL |The type of goods in current inventory record.
   Possible values:
* NORMAL
* DEFECTIVE |
   ^^initial_on_hand_quantity |int |10 |The number of goods units physically in the Fulfilled by TikTok warehouse before current inventory change, excluding those in transit. |
   ^^final_on_hand_quantity |int |12 |The number of goods units physically in the Fulfilled by TikTok warehouse after current inventory change, excluding those in transit. |
   ^^changed_quantity |int |2 |The change in the number of units is calculated as the `final_on_hand_quantity` - `initial_on_hand_quantity`. |
   ^next_page_token |string |cGFnZV9udW1iZXI9Mg== |An opaque token used to retrieve the next page of a paginated result set. Provide this value in the `page_token` parameter of your request if the current response does not return all the results. |
   ^total_count |int |22113 |The total number of the search results. |

### Response Sample
```json
{"code":0,"data":{"inventory_records":[{"goods":{"id":"12324323","reference_code":"water01","name":"100ml water"},"fbt_warehouse_id":"7232392932323","order":{"id":"OBF8932302030203","type":"INBOUND_ORDER"},"create_time":1212139230,"inventory_goods_type":"NORMAL","initial_on_hand_quantity":10,"final_on_hand_quantity":12,"changed_quantity":2}],"next_page_token":"cGFnZV9udW1iZXI9Mg==","total_count":22113},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get FBT MCF Order Status — `GET /fbt/202601/mcf_outbound_orders`

Doc: https://partner.tiktokshop.com/docv2/page/get-fbt-mcf-order-status-202601 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202601/mcf_outbound_orders
### Method: [GET]
### Function Description
Use this API to retrieve an MCF order and the current status and fulfillment details of its consign orders. If the order requires multiple packages because of carrier restrictions or package-size limits, the FBT system splits it for fulfillment and returns one entry in `consign_orders` for each package.

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
| mcf_order_id | string | Y | 7136104329798256386 | A unique ID that identifies different MCF orders |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202601/mcf_outbound_orders?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&mcf_order_id=7136104329798256386
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^mcf_order | object |  | MCF order information |
| ^^external_order_id | string | shopify202208291503530001100220033 | The corresponding order ID in your OMS. |
| ^^mcf_order_id | string | 7136104329798256386 | A unique ID that identifies different MCF orders |
| ^^consign_orders | []object |  | The consign orders created for the MCF order. If fulfillment is split across multiple packages, this array contains one entry for each package. |
| ^^^id | string | 1234 | `consign order` unique id |
| ^^^goods | []object |  | The goods id and quantity in this consign order. |
| ^^^^id | string | 123124124 | Identifier for goods generated by Fulfilled by TikTok systemgoods id |
| ^^^^quantity | int | 1 | The goods quantity in this consign order |
| ^^^tracking_number | string | TN87654321 | The tracking number of this consign order. If the order has not yet been handed over to the logistics carrier, this field may be a null value. |
| ^^^carrier | string | USPS | The shipping carrier of this consign order. If the order has not yet been handed over to the logistics carrier, this field may be a null value. |
| ^^^status | string | PENDING | The status of the consign order. |
Possible values:

* **PENDING** - The order is pending warehouse processing.
* **HANDLE_BY_WAREHOUSE** - The order is being processed by the warehouse.
* **SHIPPED** - The order has shipped from the warehouse.
* **HANDOVER** - The logistics carrier has received the order and it is in transit.
* **CLOSED** - The order is closed.
* **LOST** - The order is lost.
* **DAMAGE** - The order is damaged.
* **RETURNED** - The order was returned.
* **SCRAP** - The order was scrapped.
* **UNKNOWN** - The consign-order status or shipping-exception subtype is unknown.
* **COMPLETED** - The order is complete.
* **ABNORMAL** - An issue prevents the order from being fulfilled. |
   ^^^is_platform_closed |bool |false |Indicates who canceled the consign order when `status` is `CLOSED`. `true` means the FBT platform canceled the order; `false` means it was canceled through your OMS. |
   ^^^issue |string |Lack of inventory |This field displays the reason for order stalling. When a `consign order` is in an abnormal status (such as **ABNORMAL**, **LOST**, etc.), specific issue reasons will be shown here. |
   ^^^shipping_provider |object | |The shipping carrier detailed informatioin of this consign order. If the order has not yet been handed over to the logistics carrier, this field may be a null value. |
   ^^^^id |string |7345645330412603141 |The shipping carrier unique id. |
   ^^^^name |string |UPS |The shipping carrier name. |
   ^^create_time |int |1661756811 |The Unix timestamp, in seconds, when the MCF order was created. |

### Response Sample
```json
{"code":0,"data":{"mcf_order":{"external_order_id":"shopify202208291503530001100220033","mcf_order_id":"7136104329798256386","consign_orders":[{"id":"1234","goods":[{"id":"123124124","quantity":1}],"tracking_number":"TN87654321","carrier":"USPS","status":"PENDING","is_platform_closed":false,"issue":"Lack of inventory","shipping_provider":{"id":"7345645330412603141","name":"UPS"}}],"create_time":1661756811}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 177001009 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 177001010 | Order information cannot be retrieved via the mcf_order_id you provided; please check if your ID is correct. |


---

## Cancel FBT MCF Order — `POST /fbt/202601/mcf_outbound_orders/cancel`

Doc: https://partner.tiktokshop.com/docv2/page/cancel-fbt-mcf-order-202601 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202601/mcf_outbound_orders/cancel
### Method: [POST]
### Function Description
An FBT multi-channel fulfillment (MCF) order may be split into one or more consign orders for fulfillment. Use this API to cancel the MCF order or selected consign orders by providing the `mcf_order_id`. To cancel selected consign orders, provide their consign order IDs. You can retrieve IDs that have already been assigned by calling the **Get FBT MCF Order Status** API; use IDs returned while the target consign orders are still in a cancellable pre-shipment state.
Cancellation is rejected for target consign orders that have reached `SHIPPED`, `HANDOVER`, `COMPLETED`, or a shipping-exception state such as `LOST`, `DAMAGE`, `RETURNED`, or `SCRAP`.
After the request, match the target consign order IDs against this API's response. A returned status of `CLOSED` means that the consign order has been canceled.

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
| mcf_order_id | string | Y | 7136104329798256386 | The MCF order ID as a numeric string. |
| consign_orders | []object | N |  | The consign orders to cancel. Omit this field to cancel all consign orders in the specified MCF order. |
| ^id | string | N | 7136104329798256386 | The consign order ID as a numeric string without the `OBF` prefix. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202601/mcf_outbound_orders/cancel?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"mcf_order_id":"7136104329798256386","consign_orders":[{"id":"7136104329798256386"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^mcf_order | object |  | The mcf order information and related consign order status. |
| ^^external_order_id | string | shopify7136104329798256386 | The corresponding order ID in your OMS. |
| ^^mcf_order_id | string | 7136104329798256386 | A unique ID that identifies different MCF orders |
| ^^consign_orders | []object |  | All consign orders in the MCF order and their current statuses after the cancellation request. Match the requested consign order IDs to the returned items; a status of `CLOSED` means that the consign order has been canceled. |
| ^^^id | string | 1234 | The consign order ID, returned as a numeric string without the `OBF` prefix. |
| ^^^status | string | CLOSED | The current status of this consign order. In a cancellation response, `CLOSED` means that the consign order has been canceled. |
Possible Status Enumerations

1. **PENDING** - Order is pending warehouse processing
2. **HANDLE_BY_WAREHOUSE** - Order is being processed by the warehouse
3. **SHIPPED** - Order has been shipped out from the warehouse
4. **HANDOVER** - Order has been received by the logistics carrier and is in transit
5. **CLOSED** - Order has been canceled
6. **LOST** - Order is lost
7. **DAMAGE** - Order is damaged
8. **COMPLETED** - Order has been completed
9. **ABNORMAL** - There is an issue related to this order and cannot be fulfilled
10. **RETURNED** - Order has been returned
11. **SCRAP** - Order has been scrapped
12. **UNKNOWN** - Order status is unknown |

### Response Sample
```json
{"code":0,"data":{"mcf_order":{"external_order_id":"shopify7136104329798256386","mcf_order_id":"7136104329798256386","consign_orders":[{"id":"1234","status":"CLOSED"}]}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 177001009 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Query Goods Inventory For MCF — `POST /fbt/202601/mcf/goods/inventory/search`

Doc: https://partner.tiktokshop.com/docv2/page/query-goods-inventory-for-mcf-202601 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202601/mcf/goods/inventory/search
### Method: [POST]
### Function Description
Search available inventory for MCF goods. Use this API to retrieve available quantities for the specified Fulfilled by TikTok goods IDs.

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
| goods | []object | Y |  | Goods to query. The array must contain 1 to 50 entries. |
| ^goods_id | string | Y | 69167899745030 | The Fulfilled by TikTok goods ID. The value must represent a positive integer. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202601/mcf/goods/inventory/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"goods":[{"goods_id":"69167899745030"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^goods_inventory_list | []object |  | Inventory entries for the requested goods. For MCF, only goods associated with the seller for the shop region and having an inventory-group result are returned. A requested goods ID without an inventory-group result is omitted; the API does not add an entry with `available_qty` set to `0`. The list is empty when none of the requested goods has an inventory-group result. Each entry represents one goods-and-inventory-group result, so the same `goods_id` may appear in multiple entries when it has multiple inventory groups. Request goods IDs are not deduplicated; repeating a `goods_id` may repeat the same inventory-group entries. Include each `goods_id` only once, and do not align response entries with request entries by list position. |
| ^^goods_id | string | 69167899745030 | The identifiers for goods generated by Fulfilled by TikTok system. |
| ^^available_qty | int | 10 | Available inventory of goods |
### Response Sample
```json
{"code":0,"data":{"goods_inventory_list":[{"goods_id":"69167899745030","available_qty":10}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get FBT Merchant MCF Status — `GET /fbt/202601/merchants/mcf_status`

Doc: https://partner.tiktokshop.com/docv2/page/get-fbt-merchant-mcf-status-202601 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202601/merchants/mcf_status
### Method: [GET]
### Function Description
Checks whether a seller is onboarded to Fulfillment by TikTok (FBT) and enrolled in Multi-Channel Fulfillment (MCF). This API currently supports only sellers in the US. If both conditions are met, `mcf_status.is_mcf` is `1` (active).

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
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202601/merchants/mcf_status?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^mcf_status | object |  | seller multi channel fulfillment status |
| ^^is_mcf | int | 0 | Flag indicating whether the seller has participated in Multi Channel Fulfillment. 0 means inactive and 1 means active. |
### Response Sample
```json
{"code":0,"data":{"mcf_status":{"is_mcf":0}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Create or Update Inbound Plan — `POST /fbt/202602/create_update_inbound_plan`

Doc: https://partner.tiktokshop.com/docv2/page/create-or-update-inbound-plan-202602 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202602/create_update_inbound_plan
### Method: [POST]
### Function Description
Creates a new inbound plan or fully replaces the contents of an existing inbound plan by using a goods item list or carton configurations with dimensions. Omit `plan_id` to create a plan; provide it to update one. Provide exactly one non-empty array: `goods_items` or `cartons`; do not provide both.
For an update, submit the complete desired goods or carton contents; previously stored goods or cartons omitted from the request are not retained. Using `goods_items` clears existing carton and lot/expiration data. Using `cartons` rebuilds the carton and item data.

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
| plan_id | string | N | 5766071177167344427 | Without plan id it is creating, with plan id it is updating. |
| idempotent_key | string | N | 9ef6857095f84893 | Idempotency key for creating an inbound plan. Required when `plan_id` is not provided. |
| goods_items | []object | N |  | Goods item list. |
| ^goods_id | string | Y | 231313 | The Fulfilled by TikTok goods identifier for this inbound plan item. The goods must belong to the merchant associated with the authenticated seller, be approved for fulfillment, and be matched to an SKU. |
| ^quantity | int | Y | 400 | Quantity of this goods item in the inbound plan. Must be greater than 0. |
| cartons | []object | N |  | Carton List. |
| ^carton_type | string | Y | SINGLE_SKU | Indicates whether the carton is configured as single-SKU or multi-SKU. |
**Possible values:**

* `SINGLE_SKU`: `items` must contain exactly one item.
* `MULTI_SKU`: `items` must contain two or more items. |
   ^items |[]object |Y | |Goods item list of a carton. |
   ^^goods_id |string |Y |12345 |The Fulfilled by TikTok goods identifier for this carton item. The goods must belong to the merchant associated with the authenticated seller, be approved for fulfillment, and be matched to an SKU. |
   ^^quantity |int |Y |20 |Quantity of this goods item in each carton. Must be greater than 0. |
   ^^lot_code |string |N |sfsfnjkfvv |Lot code for this goods item. Required when lot-code management is enabled for the goods. Every occurrence of the same `goods_id` in `cartons` must use the same `lot_code` and `expiration_timestamp` values. |
   ^^expiration_timestamp |string |N |1623812664 |The expiration date for this item, as a Unix timestamp in seconds. Required when expiration management is enabled for the goods. It must be no earlier than the current time plus the goods-specific `inbound_cutoff_days`. Obtain this value from `data.goods[].lot_expiration_info.inbound_cutoff_days` in Search Goods Info (`POST /fbt/202607/goods/search`). |
   ^quantity |int |Y |2 |Number of cartons that use this carton configuration. |
   ^carton_nums |[]string |N |["C0001","C0002"] |Identifiers assigned to the cartons represented by this configuration. Either every carton configuration in the request must provide a non-empty `carton_nums` array, or no configuration may provide any carton identifiers. When provided, the number of identifiers must equal this configuration's `quantity`; each identifier must use the format `C` followed by four digits and must be unique across the request. If none are provided, carton identifiers are generated automatically. |
   ^box_measurements |object |Y | |Carton measurement. |
   ^^weight |string |Y |3.50 |Carton weight. |
   ^^weight_unit |string |Y |POUNDS |The unit used for the carton's `weight` value.

**Possible values:**

* `KILOGRAM` (kg)
* `GRAM` (g)
* `MILLIGRAM` (mg)
* `POUNDS` (lbs)
* `OUNCE` (oz) |
   ^^width |string |Y |1.2 |Carton width. |
   ^^height |string |Y |2 |Carton height. |
   ^^length |string |Y |5 |Carton length. |
   ^^length_unit |string |Y |INCH |The unit used for the carton's `length`, `width`, and `height` values.

**Possible values:**

* `METER` (m)
* `CENTIMETER` (cm)
* `MILLIMETER` (mm)
* `FOOT` (ft)
* `MICRON` (μm)
* `INCH` (in) |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202602/create_update_inbound_plan?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"plan_id":"5766071177167344427","idempotent_key":"9ef6857095f84893","goods_items":[{"goods_id":"231313","quantity":400}],"cartons":[{"carton_type":"SINGLE_SKU","items":[{"goods_id":"12345","quantity":20,"lot_code":"sfsfnjkfvv","expiration_timestamp":"1623812664"}],"quantity":2,"carton_nums":["C0001","C0002"],"box_measurements":{"weight":"3.50","weight_unit":"POUNDS","width":"1.2","height":"2","length":"5","length_unit":"INCH"}}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^inbound_plan | object |  | Inbound plan. |
| ^^plan_id | string | 5766071177167344427 | Plan identifier. |
### Response Sample
```json
{"code":0,"data":{"inbound_plan":{"plan_id":"5766071177167344427"}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 39001002 | Request or request parameters are empty. Please recheck the input parameters. |


---

## List Available Inbound Methods — `POST /fbt/202602/list_available_inbound_method`

Doc: https://partner.tiktokshop.com/docv2/page/list-available-inbound-methods-202602 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202602/list_available_inbound_method
### Method: [POST]
### Function Description
Retrieves valid inbound shipping methods and arrival time windows for a specific plan. After selecting an `inbound_method` and one complete arrival time window, call **Get Inbound Method Detail** (`POST /fbt/202602/inbound_method_detail`) using the same `plan_id`, the selected `inbound_method`, and that window's exact `start_timestamp` and `end_timestamp` pair as `estimate_arrival_time`.

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
| plan_id | string | Y | 5766071177167344427 | Inbound plan identifier |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202602/list_available_inbound_method?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"plan_id":"5766071177167344427"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^available_inbound_method_list | []object |  | List of available inbound methods for the specified plan, including arrival time windows, placement fee estimates, and warehouses. |
| ^^inbound_method | string | D2FC | Inbound method. |

* D2FC
* ONE_HUB |
   ^^available_time_window_list |[]object | |Weekly arrival time windows available for this inbound method. |
   ^^^start_timestamp |string |1774162800 |Epoch seconds representing Sunday at midnight like 2026-03-29T07:00:00Z, in US we are using US west time zone

**This value should be passed in the subsequent GetInboundMethodDetail API** |
^^^end_timestamp |string |1774767600 |Epoch seconds representing Sunday at midnight like 2026-03-29T07:00:00Z, in US we are using US west time zone
**This value should be passed in the subsequent GetInboundMethodDetail API** |
^^warehouse_list |[]object | |List of warehouses available for this inbound method option. |
^^^warehouse_name |string |FC09_ATL2 |Warehouse name for this available inbound method option. |
^^^warehouse_id |string |7542187927317874487 |Warehouse identifier for this available inbound method option. |
^^placement_fee_estimate |object | |Estimated placement fee for this inbound method. As of April 2026, only ONE_HUB methods can include an amount. |
^^^amount |string |13.50 |Placement fee amount. |
^^^currency |string |USD |- USD

* CNY
* EUR |

### Response Sample
```json
{"code":0,"data":{"available_inbound_method_list":[{"inbound_method":"D2FC","available_time_window_list":[{"start_timestamp":"1774162800","end_timestamp":"1774767600"}],"warehouse_list":[{"warehouse_name":"FC09_ATL2","warehouse_id":"7542187927317874487"}],"placement_fee_estimate":{"amount":"13.50","currency":"USD"}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 39001002 | Request or request parameters are empty. Please recheck the input parameters. |


---

## Get Inbound Method Detail — `POST /fbt/202602/inbound_method_detail`

Doc: https://partner.tiktokshop.com/docv2/page/get-inbound-method-detail-202602 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202602/inbound_method_detail
### Method: [POST]
### Function Description
Retrieves placement details for an inbound plan. First call the List Available Inbound Methods API for the plan, then use the `inbound_method` and estimated arrival window from the same returned option. The response reports the placement task status and, when available, placement options with shipment allocations; `ONE_HUB` options can also include an estimated placement fee.

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
| plan_id | string | Y | 5766071177167344427 | Inbound plan identifier |
| inbound_method | string | Y | D2FC | **Possible values:** |

* `D2FC` (Direct to fulfillment center, may be split into multiple shipments)
* `ONE_HUB` (Single destination; can include an estimated placement fee) |
   estimate_arrival_time |object |Y | |Estimated arrival window for the selected `inbound_method`. Use the `start_timestamp` and `end_timestamp` from the same entry in the `available_time_window_list` returned by the List Available Inbound Methods API for this plan. |
   ^start_timestamp |string |Y |1774162800 |Unix timestamp in seconds for the start of the estimated arrival window, which is Sunday at 00:00 PDT. For example, `1774162800` corresponds to `2026-03-22T07:00:00Z`.

**This value must exactly match the** **`start_timestamp` from the selected List Available Inbound Methods time window.** |
^end_timestamp |string |Y |1774767600 |Unix timestamp in seconds for the end of the estimated arrival window, which is Sunday at 00:00 PDT. For example, `1774767600` corresponds to `2026-03-29T07:00:00Z`.
**This value must exactly match the** **`end_timestamp` from the selected List Available Inbound Methods time window.** |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202602/inbound_method_detail?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"plan_id":"5766071177167344427","inbound_method":"D2FC","estimate_arrival_time":{"start_timestamp":"1774162800","end_timestamp":"1774767600"}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^info | []object |  | Placement options for the current placement task. If `placement_task_status` is `Executing`, repeat this request with the same `plan_id`, `inbound_method`, and estimated arrival window to retrieve the latest status. When the status is `Succeed`, select an option from `info` and pass its `placement_option_id` to the Confirm Inbound Method API. Do not confirm an option when the status is `Failed`. After `expiration_timestamp`, call this API again with the same selection inputs to obtain a new placement option or task. |
| ^^allocation_shipments | []object |  | List of shipments for this placement option. |
| ^^^warehouse_id | string | 7542187927317874487 | Warehouse identifier. |
| ^^^goods_items | []object |  | Goods item list. |
| ^^^^goods_id | string | 2134566 | Goods identifier. |
| ^^^^quantity | int | 400 | Quantity of this goods. |
| ^^^cartons | []object |  | Carton List. |
| ^^^^carton_type | string | SINGLE_SKU | Indicates if this is a single SKU carton or multi SKU carton. |
| **Possible values:** |  |  |  |

* `SINGLE_SKU`
* `MULTI_SKU` |
   ^^^^items |[]object | |Goods item list of a carton. |
   ^^^^^goods_id |string |12345 |Goods identifier. |
   ^^^^^quantity |int |20 |Quantity of this goods. |
   ^^^^^lot_code |string |sfsfnjkfvv |Lot code of this goods. |
   ^^^^^expiration_timestamp |string |1623812664 |The expiration date for this item, Unix timestamp in seconds. |
   ^^^^quantity |int |2 |Carton quantity. |
   ^^^^carton_nums |[]string |["C0001","C0002"] |Carton numbers. |
   ^^^^box_measurements |object | |Carton measurement. |
   ^^^^^weight |string |3.5 |Carton weight. |
   ^^^^^weight_unit |string |POUNDS |The unit used for the carton's `weight` value.

**Possible values:**

* `KILOGRAM` (kg)
* `GRAM` (g)
* `MILLIGRAM` (mg)
* `POUNDS` (lbs)
* `OUNCE` (oz) |
   ^^^^^width |string |1.2 |Carton width. |
   ^^^^^height |string |2 |Carton height. |
   ^^^^^length |string |5 |Carton length. |
   ^^^^^length_unit |string |INCH |The unit used for the carton's `length`, `width`, and `height` values.

**Possible values:**

* `METER` (m)
* `CENTIMETER` (cm)
* `MILLIMETER` (mm)
* `FOOT` (ft)
* `MICRON` (μm)
* `INCH` (in) |
   ^^^shipment_options |[]object | |Shipment options. |
   ^^^^shipping_method |string |SMALL_PARCEL |Shipping method for this shipment option. Possible values: SMALL_PARCEL, a parcel shipment method; FREIGHT, a freight shipment method. |
   ^^placement_option_id |string |5766071177167344420 |Placement option id. A placement option represents the shipment splits and destinations. |
   ^^placement_fee_estimate |object | |Estimated placement fee for a `ONE_HUB` placement option. |
   ^^^amount |string |13.50 |Placement fee amount. |
   ^^^currency |string |USD |The currency of the placement fee amount.

**Possible values:**

* `USD`
* `CNY`
* `EUR`
* `GBP`
* `SAR` |
   ^placement_task_status |string |Executing |**Possible values:**
* `Executing`
* `Succeed`
* `Failed` |
   ^expiration_timestamp |string |1774767600 |Unix timestamp in seconds when the placement result expires. For `ONE_HUB`, the expiration is set to 24 hours after this API processes the request. For other methods, it is 24 hours after the placement task's trigger time. After expiration, call this API again to generate a new placement task. |

### Response Sample
```json
{"code":0,"data":{"info":[{"allocation_shipments":[{"warehouse_id":"7542187927317874487","goods_items":[{"goods_id":"2134566","quantity":400}],"cartons":[{"carton_type":"SINGLE_SKU","items":[{"goods_id":"12345","quantity":20,"lot_code":"sfsfnjkfvv","expiration_timestamp":"1623812664"}],"quantity":2,"carton_nums":["C0001","C0002"],"box_measurements":{"weight":"3.5","weight_unit":"POUNDS","width":"1.2","height":"2","length":"5","length_unit":"INCH"}}],"shipment_options":[{"shipping_method":"SMALL_PARCEL"}]}],"placement_option_id":"5766071177167344420","placement_fee_estimate":{"amount":"13.50","currency":"USD"}}],"placement_task_status":"Executing","expiration_timestamp":"1774767600"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 39001002 | Request or request parameters are empty. Please recheck the input parameters. |


---

## Print Inbound Order Labels — `POST /fbt/202602/inbound_orders/label_print`

Doc: https://partner.tiktokshop.com/docv2/page/print-inbound-order-labels-202602 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202602/inbound_orders/label_print
### Method: [POST]
### Function Description
This API generates label files for an inbound order using an **asynchronous Long-Running Operation (LRO)**. The inbound order must be shipped or in a later eligible status and must not be canceled.
**Format applicability**

* `carton_label_format` controls the carton or pallet label layout only when `print_items` includes `CARTON_PALLET_LABEL`.
* `barcode_format` controls the goods-barcode label layout only when `print_items` includes `FBT_BARCODE`.

The selected `print_items` and both resolved format values are part of the print task identifier, so keep the same selections in every polling request.
**Workflow**

1. **Initiate.** Send a request with the child inbound `order_id` and the desired `print_items`. The API returns `PROCESSING` while the label file is being generated; a completed task for the same request values may return `SUCCESS` immediately.
2. **Poll.** If `task_status` is `PROCESSING`, repeat the request with the same `order_id`, `print_items`, `carton_label_format`, and `barcode_format` values. Poll every 3–5 seconds.
3. **Complete.** When `task_status` is `SUCCESS`, `download_url` contains the generated ZIP file.

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
| order_id | string | Y | 5766071177167344427 | The numeric identifier of the child inbound order to print labels for. |
**Note:** Provide the numeric sequence only; do not include the `IBR` prefix (for example, use `123456` instead of `IBR123456`). Do not use an inbound plan ID. |
print_items |[]string |N |[
"CARTON_PALLET_LABEL",
"FBT_BARCODE",
"PACKING_PICKING_LIST"
] |Specifies the types of documents to generate. Multiple values can be included in one combined output.
**Allowed Values:**

* `CARTON_PALLET_LABEL`: Identification labels for cartons or pallets. Apply carton labels to at least two adjacent sides of each carton.
* `PACKING_PICKING_LIST`: Warehouse document for identifying and packing items.
* `FBT_BARCODE`: Fulfilled by TikTok barcode labels.

**Note:** If this list is empty or omitted, `CARTON_PALLET_LABEL` is generated by default. |
carton_label_format |string |N |DEFAULT_1UP |Specifies the layout and dimensions for the carton labels. If this parameter is omitted or an invalid value is provided, the system will use the default single-label format.
**Allowed Values:**

* `DEFAULT_1UP`: Standard format (1 label per page).
* `A4_4UP`: A4 paper format (4 labels per page).

**Note:** If no value is provided, `DEFAULT_1UP` will be used as the default format. |
barcode_format |string |N |DEFAULT_40MM_60MM |Specifies the layout and dimensions for the generated label PDF. If this parameter is omitted or an invalid value is provided, the system will use the default thermal label format.
**Allowed Values:**
**Standard / Default**

* `DEFAULT_40MM_60MM`: Standard 40mm x 60mm thermal label format

**A4 Paper Layouts**

* `A4_21UP_60_0MM_40_0MM`: 21-up labels (60.0mm x 40.0mm) on A4
* `A4_21UP_63_5MM_38_1MM`: 21-up labels (63.5mm x 38.1mm) on A4
* `A4_24UP_63_5MM_33_9MM`: 24-up labels (63.5mm x 33.9mm) on A4
* `A4_24UP_64_6MM_33_8MM`: 24-up labels (64.6mm x 33.8mm) on A4
* `A4_24UP_66_0MM_33_9MM`: 24-up labels (66.0mm x 33.9mm) on A4
* `A4_24UP_66_0MM_35_0MM`: 24-up labels (66.0mm x 35.0mm) on A4
* `A4_24UP_70_0MM_36_0MM`: 24-up labels (70.0mm x 36.0mm) on A4
* `A4_24UP_70_0MM_37_0MM`: 24-up labels (70.0mm x 37.0mm) on A4
* `A4_27UP_63_5MM_29_6MM`: 27-up labels (63.5mm x 29.6mm) on A4
* `A4_40UP_52_5MM_29_7MM`: 40-up labels (52.5mm x 29.7mm) on A4
* `A4_44UP_48_5MM_25_4MM`: 44-up labels (48.5mm x 25.4mm) on A4

**US Letter Layouts**

* `US_LETTER_30UP_1IN_2_625IN`: 30-up labels (1" x 2-5/8") on US Letter

**Note:** If no value is provided, `DEFAULT_40MM_60MM` will be used as the default format. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202602/inbound_orders/label_print?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"order_id":"5766071177167344427","print_items":["CARTON_PALLET_LABEL","FBT_BARCODE","PACKING_PICKING_LIST"],"carton_label_format":"DEFAULT_1UP","barcode_format":"DEFAULT_40MM_60MM"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^download_url | string | https://example.com/fbt/inbound_files.zip?download_token=sample_token | URL containing labels for the inbound order. |
**Please note: the URL will be unicode-escaped. If attempting to manually paste the URL into a browser, you will need to unescape the URL first (e.g. '\u0026'->'&')** |
^task_status |string |PROCESSING |* `PROCESSING`: Task is currently being processed. Continue to periodically poll.

* `SUCCESS`: Task is finished. `download_url` should be included in response |

### Response Sample
```json
{"code":0,"data":{"download_url":"https://example.com/fbt/inbound_files.zip?download_token=sample_token","task_status":"PROCESSING"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 39001002 | Request or request parameters are empty. Please recheck the input parameters. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 39015007 | Access denied. The API requires the seller to be bound to exactly one merchant. |
| 39015009 | SellerId input is invalid |
| 39015010 | No inbound orders found for the merchant. |


---

## Update Inbound Order Tracking — `POST /fbt/202602/inbound_orders/tracking_update`

Doc: https://partner.tiktokshop.com/docv2/page/update-inbound-order-tracking-202602 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202602/inbound_orders/tracking_update
### Method: [POST]
### Function Description
Updates carton-level tracking information for an inbound order after shipment and before the order is marked as `Delivered` or `Received`. When updating tracking, send the complete desired `parcel_tracking_info` list; entries omitted from a non-empty submission are not retained, so this is not a partial patch. The first tracking value for a carton does not count as an edit, and resubmitting the same normalized value does not consume another edit. Changing an existing carton's tracking number consumes one of the five allowed edits for that carton; a sixth change is rejected before the local update. The submitted carton updates are applied atomically to the stored tracking list: either the complete local replacement is saved or none of it is. Warehouse synchronization and logistics tracking registration occur outside this atomic update; warehouse synchronization failures are not returned, and tracking registration runs asynchronously.

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
| order_id | string | Y | 5766071177167344427 | The numeric identifier of the inbound order to update tracking information for. |
| **Note:** Provide the numeric sequence only; do not include the "IBR" prefix (e.g., use `123456` instead of `IBR123456`). |  |  |  |  |
| parcel_tracking_info | []object | N |  | Carton-level parcel tracking information for the inbound order, including carton number, logistics provider name, and tracking number. |
| ^provider_name | string | Y | FEDEX | The `provider_name` field must contain exactly one of the following strings. |

* `FEDEX` (Federal Express)
* `UPS` (United Parcel Service)
* `DHL` (DHL Express)
* `USPS` (United States Postal Service)
* `OTHER` (All other logistics providers)

**Note:** Input must match the uppercase string exactly (e.g., `"provider_name": "FEDEX"`). |
^tracking_number |string |Y |889042812410 |The tracking number to associate with this carton. It must not be empty or contain only whitespace, and it may contain only ASCII letters, digits, spaces, and hyphens. After spaces and hyphens are removed, 8 to 40 letters or digits must remain. |
^carton_number |string |Y |C0001 |The carton number of an existing carton in this inbound order. After leading and trailing whitespace is removed, this value is matched to the carton whose tracking information is created or replaced. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202602/inbound_orders/tracking_update?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"order_id":"5766071177167344427","parcel_tracking_info":[{"provider_name":"FEDEX","tracking_number":"889042812410","carton_number":"C0001"}]}
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
| 39001002 | Request or request parameters are empty. Please recheck the input parameters. |
| 39015007 | Access denied. The API requires the seller to be bound to exactly one merchant. |
| 39015009 | SellerId input is invalid |
| 39015010 | No inbound orders found for the merchant. |
| 39015015 | Parcel tracking info list is empty. |
| 39015016 | Tracking provider is invalid or unsupported. |
| 39015017 | Carton number is invalid or missing. |
| 39015018 | Failed to update tracking info for inbound order. Please check that the inbound order is in "Shipped" status and try again. If the issue persists and the cause is unknown, please contact platform support. |
| 39015019 | Tracking number is invalid or missing. |


---

## Cancel Inbound Order — `POST /fbt/202602/inbound_orders/cancel`

Doc: https://partner.tiktokshop.com/docv2/page/cancel-inbound-order-202602 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202602/inbound_orders/cancel
### Method: [POST]
### Function Description
This API is used to cancel one inbound order per request prior to warehouse arrival, preventing further processing and updating the order status.
**If the inbound order is part of a D2FC inbound plan, call this API separately for every order under the plan. Otherwise, non-compliance fees may be charged.**

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
| order_id | string | Y | 5766071177167344427 | The positive numeric identifier of the inbound order to cancel. |
**Note:** Provide the numeric sequence only; do not include the "IBR" prefix (for example, use `123456` instead of `IBR123456`). |
cancel_reason |string |Y |Order created by mistake. |Reason for cancelling the inbound order. The value must not be empty or contain only whitespace. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202602/inbound_orders/cancel?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"order_id":"5766071177167344427","cancel_reason":"Order created by mistake."}
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
| 39001002 | Request or request parameters are empty. Please recheck the input parameters. |
| 39015007 | Access denied. The API requires the seller to be bound to exactly one merchant. |
| 39015009 | SellerId input is invalid |
| 39015010 | No inbound orders found for the merchant. |
| 39015013 | Invalid or missing cancel reason. |
| 39015014 | Failed to cancel inbound order due to status or other business restrictions. Please check the inbound order status and try again. If the issue persists and the cause is unknown, please contact platform support. |


---

## Get FBT Inbound Order Details — `GET /fbt/202602/inbound_orders`

Doc: https://partner.tiktokshop.com/docv2/page/get-fbt-inbound-order-details-202602 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202602/inbound_orders
### Method: [GET]
### Function Description
Retrieves details for the specified FBT inbound orders, including planned and actual receiving information and status history. Set `include_carton_details` to `true` to request carton dimensions and item quantities.

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
| order_ids | []string | Y | 5766071177167344427,5766071177167344428 | The list of numeric identifiers of the inbound orders to fetch information for. |
| **Note:** Provide the numeric sequence only; do not include the "IBR" prefix (e.g., use `123456` instead of `IBR123456`). There is a **limit of 10 orders** to be fetched in each request. |  |  |  |  |
Only orders that are found and accessible to the current seller are returned. Missing or inaccessible order IDs are omitted from the response; the request fails if none of the requested orders can be returned.
You can get the value in `data.inbound_order_id` in [Inbound FBT order status change](6708f866a88d1103246fed6a) webhook or in `data.inventory_records.order.id` in the response of [Search FBT Inventory Record](670d584ba83c5f030f3071e4). |
include_carton_details |bool |N |true |A boolean flag that determines whether the response should include granular information for each individual carton within the shipment.
**Note**: When set to `true`, the response will include the `carton_details` field. If set to `false` or omitted, this field will be excluded from the response payload to optimize performance. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202602/inbound_orders?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&order_ids=5766071177167344427,5766071177167344428&include_carton_details=true
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^inbound_orders | []object |  | A list of inbound order detail information. |
| ^^order_id | string | 5766071177167344427 | The numeric identifier for inbound order in Fulfilled by TikTok system. |
| ^^order_id_string | string | IBR5766071177167344427 | The string identifier for inbound order in Fulfilled by TikTok system. |
| ^^order_plan_id | string | 5766071177167345050 | Plan identifier for the inbound order. |
| ^^merchant | object |  | Information regarding the merchant who owns the order. |
| ^^^id | string | 493493403043 | The identifier of the merchant in Fulfilled by TikTok system. |
| ^^^name | string | ExampleCompany | Name of the Fulfilled by TikTok merchant. |
| ^^create_time | int | 1773778751 | Unix seconds timestamp when the inbound order was created. |
| ^^ship_time | int | 1773778751 | Unix seconds timestamp when the inbound order was shipped. |
| ^^expected_arrival_time | int | 1773778751 | Unix seconds timestamp of the expected arrival time provided by merchant. |
| ^^actual_arrival_time | int | 1773778751 | Unix seconds timestamp of the actual arrival time of the inbound order. |
| ^^warehouse | object |  | Warehouse information. |
| ^^^fbt_warehouse_id | string | 121219993203023 | The identifier for warehouse generated by Fulfilled by TikTok system. |
| ^^^business_warehouse_ids | []string | ["121219993209983"] | The business identifier for warehouse generated by TikTok Shop system, correlated with the `fbt_warehouse_id`. |
| ^^^name | string | TikTok Warehouse | The Fulfilled by TikTok warehouse name. |
| ^^^type | string | FC | Type of warehouse associated with the inbound order. |
Possible values:

* `HUB`
* `FC` (Fulfillment Center) |
   ^^status_logs |[]object | |Inbound order operation-history entries derived from at most 200 source status records. This list may be incomplete, and this operation does not provide a cursor for retrieving additional status records. |
   ^^^operate_time |int |1715398048 |The time when the inbound order is processed by the merchant or warehouses, represented as a Unix timestamp in seconds. |
   ^^^new_status |string |RECEIVED |The order status in **Fulfilled by TikTok (FBT)** warehouse after this operation.

**Possible values:**

* `WORKING`
* `READY_TO_SHIP`
* `TO_BE_RECEIVED`
* `ARRIVED_HUB`
* `INTERNAL_TRANSFER`
* `RECEIVING`
* `PARTIALLY_RECEIVED`
* `RECEIVED`
* `CANCELLED`
* `DELIVERED` |
   ^^^previous_status |string |PARTIALLY_RECEIVED |The order status in **Fulfilled by TikTok (FBT)** warehouse before this operation.

**Possible values:**

* `WORKING`
* `READY_TO_SHIP`
* `TO_BE_RECEIVED`
* `ARRIVED_HUB`
* `INTERNAL_TRANSFER`
* `RECEIVING`
* `PARTIALLY_RECEIVED`
* `RECEIVED`
* `CANCELLED`
* `DELIVERED` |
   ^^^operator |string |Warehouse |The unique identifier or name of the user or system entity that performed the status change. |
   ^^logistic_info_list |[]object | |List of logistics information tied to the order. Only populated for small-parcel inbound orders. |
   ^^^provider_name |string |UPS |Name of the logistics service provider

Possible values:

* `FEDEX` (Federal Express)
* `UPS` (United Parcel Service)
* `DHL` (DHL Express)
* `USPS` (United States Postal Service)
* `OTHER` (All other logistics providers) |
   ^^^waybill_number |string |889042812410 |The tracking number for the current inbound shipment with the carrier. |
   ^^^related_number |string |C0001 |Carton number tied to the logistics information. |
   ^^carton_details |[]object | |Detailed carton information for the inbound order. Only populated if `include_carton_details` is passed as true in the request. |
   ^^^carton_no |string |C0001 |Carton number. |
   ^^^carton_type |string |SINGLE_SKU |Whether this carton is single-SKU or multi-SKU.

**Possible values:**

* `SINGLE_SKU`
* `MULTI_SKU` |
   ^^^box_measurements |object | |Carton measurement. |
   ^^^^weight |string |5 |Carton weight. |
   ^^^^weight_unit |string |KILOGRAM |The unit used for the carton's `weight` value.

**Possible values:**

* `KILOGRAM` (kg)
* `GRAM` (g)
* `MILLIGRAM` (mg)
* `POUNDS` (lbs)
* `OUNCE` (oz) |
   ^^^^width |string |6 |Carton width. |
   ^^^^height |string |7 |Carton height. |
   ^^^^length |string |8 |Carton length. |
   ^^^^length_unit |string |METER |The unit used for the carton's `length`, `width`, and `height` values.

**Possible values:**

* `METER` (m)
* `CENTIMETER` (cm)
* `MILLIMETER` (mm)
* `FOOT` (ft)
* `MICRON` (μm)
* `INCH` (in) |
   ^^^items |[]object | |List of items in this carton. |
   ^^^^goods_id |string |7603596185 |Identifier for goods within the Fulfilled by TikTok system. |
   ^^^^quantity |int |10 |The number of units of the goods in this carton. |
   ^^inbound_goods_lot_receive_item_details |[]object | |A detailed breakdown of planned versus actual receiving information, segmented by item, lot number, and expiration date. |
   ^^^goods_id |string |7603596185 |The unique numeric identifier of the goods within Fulfilled by TikTok. |
   ^^^lot_code |string |LOT-2024-XP9 |The batch or lot number assigned by the manufacturer for this group of items. This field is non-empty only for goods with lot code management. |
   ^^^expiration_time |int |1735689600 |The expiration date of the items in this lot, represented as a Unix timestamp in seconds. This value is non-zero only for goods with expiration-date management. |
   ^^^planned_count |int |100 |The total quantity of this specific lot expected to be received as part of the inbound order. |
   ^^^normal_received_count |int |98 |The quantity of items received at **fulfillment centers** in sellable (good) condition for this lot. If the inbound order is sent to a hub, this value will only be updated when the goods are subsequently transferred to the fulfillment center. |
   ^^^defective_received_count |int |2 |The quantity of items received in a damaged or unsellable state. |
   ^^^total_received_count |int |100 |The sum of both `normal_received_count` and `defective_received_count`. |

### Response Sample
```json
{"code":0,"data":{"inbound_orders":[{"order_id":"5766071177167344427","order_id_string":"IBR5766071177167344427","order_plan_id":"5766071177167345050","merchant":{"id":"493493403043","name":"ExampleCompany"},"create_time":1773778751,"ship_time":1773778751,"expected_arrival_time":1773778751,"actual_arrival_time":1773778751,"warehouse":{"fbt_warehouse_id":"121219993203023","business_warehouse_ids":["121219993209983"],"name":"TikTok Warehouse","type":"FC"},"status_logs":[{"operate_time":1715398048,"new_status":"RECEIVED","previous_status":"PARTIALLY_RECEIVED","operator":"Warehouse"}],"logistic_info_list":[{"provider_name":"UPS","waybill_number":"889042812410","related_number":"C0001"}],"carton_details":[{"carton_no":"C0001","carton_type":"SINGLE_SKU","box_measurements":{"weight":"5","weight_unit":"KILOGRAM","width":"6","height":"7","length":"8","length_unit":"METER"},"items":[{"goods_id":"7603596185","quantity":10}]}],"inbound_goods_lot_receive_item_details":[{"goods_id":"7603596185","lot_code":"LOT-2024-XP9","expiration_time":1735689600,"planned_count":100,"normal_received_count":98,"defective_received_count":2,"total_received_count":100}]}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 39001002 | Request or request parameters are empty. Please recheck the input parameters. |
| 39015009 | SellerId input is invalid |
| 39015010 | No inbound orders found for the merchant. |
| 39015020 | Number of orders in request exceeds the configured limit. |


---

## Confirm Inbound Method — `POST /fbt/202603/confirm_inbound_method`

Doc: https://partner.tiktokshop.com/docv2/page/confirm-inbound-method-202603 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202603/confirm_inbound_method
### Method: [POST]
### Function Description
Confirm a currently available warehouse placement option for an FBT inbound plan. First call the List Available Inbound Methods API and select an `inbound_method` with one exact `estimate_arrival_time` window. Then call the Get Inbound Method Detail API with that selection and choose a returned `placement_option_id`. Confirm using the `placement_option_id`, `inbound_method`, and `estimate_arrival_time` from the same selection. If the option has expired, repeat both prerequisite calls to obtain a current selection and a new `placement_option_id`, then retry. The response contains the child inbound order IDs generated for the plan.

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
| plan_id | string | Y | 5766071177167344427 | Identifier of the FBT inbound plan whose warehouse placement option is being confirmed. |
| placement_option_id | string | Y | 5766071177167344420 | Placement option id. A placement option represents the shipment splits and destinations. |
| inbound_method | string | Y | D2FC | **Possible values:** |

* `D2FC` (Direct to fulfillment center, may be split into multiple shipments)
* `ONE_HUB` (Single destination, includes fee) |
   estimate_arrival_time |object |Y | |Estimated arrival time. Value should be retrieved from the `available_time_window_list` from `ListAvailableInboundMethod` API response |
   ^start_timestamp |string |Y |1774162800 |Start of the estimated arrival time window as a Unix timestamp in seconds. For example, `1774162800` corresponds to Sunday, 2026-03-22 at 00:00 PDT (`2026-03-22T07:00:00Z`). Use the exact `start_timestamp` returned in `available_time_window_list` by the `ListAvailableInboundMethod` API. |
   ^end_timestamp |string |Y |1774767600 |End of the estimated arrival time window as a Unix timestamp in seconds. For example, `1774767600` corresponds to Sunday, 2026-03-29 at 00:00 PDT (`2026-03-29T07:00:00Z`). Use the exact `end_timestamp` returned in `available_time_window_list` by the `ListAvailableInboundMethod` API. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202603/confirm_inbound_method?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"plan_id":"5766071177167344427","placement_option_id":"5766071177167344420","inbound_method":"D2FC","estimate_arrival_time":{"start_timestamp":"1774162800","end_timestamp":"1774767600"}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^inbound_order_ids | []string | ["5766071177167344427","5766071177167344428"] | List of child inbound order IDs generated for the confirmed FBT inbound plan. |
### Response Sample
```json
{"code":0,"data":{"inbound_order_ids":["5766071177167344427","5766071177167344428"]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 39001002 | Request or request parameters are empty. Please recheck the input parameters. |


---

## Ship Inbound Order — `POST /fbt/202603/ship_inbound_order`

Doc: https://partner.tiktokshop.com/docv2/page/ship-inbound-order-202603 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202603/ship_inbound_order
### Method: [POST]
### Function Description
Finalizes carton and shipping details for an inbound order that is ready to ship. For an order that has not already been shipped, a successful response means the details were saved and the order moved to the receiving stage. Repeating the request after the order has already been shipped returns success without applying the supplied details again.

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
| inbound_order_id | string | Y | 5766071177167344427 | Identifier of the inbound order to ship. |
| cartons | []object | N |  | Carton details. Required when the inbound plan was created or updated using `goods_items` instead of `cartons` and the order has not already been shipped. Not required when retrying an order that has already been shipped. |
| ^carton_type | string | Y | SINGLE_SKU | Carton composition type. |
**Possible values:**

* `SINGLE_SKU` - `items` must contain exactly one goods item.
* `MULTI_SKU` - `items` must contain more than one goods item. |
   ^items |[]object |Y | |Goods item list of a carton. |
   ^^goods_id |string |Y |723456789012345678 |Identifier of the goods item in the carton. |
   ^^quantity |int |Y |100 |Number of units of this goods item in each carton represented by the parent carton entry. Must be greater than 0. |
   ^^lot_code |string |N |sfsfnjkfvv |Lot code for the goods item. Required when lot code management is enabled for the goods. If the same `goods_id` appears in multiple cartons, use the same `lot_code` and `expiration_timestamp` in every occurrence. |
   ^^expiration_timestamp |string |N |1623812664 |The goods item's expiration time as a Unix timestamp in seconds. Required when shelf-life management is enabled for the goods. It must be no earlier than the current time plus the goods-specific `inbound_cutoff_days`. Obtain this value from `data.goods[].lot_expiration_info.inbound_cutoff_days` in Search Goods Info (`POST /fbt/202607/goods/search`). If the same `goods_id` appears in multiple cartons, use the same `expiration_timestamp` and `lot_code` in every occurrence. |
   ^quantity |int |Y |2 |Number of physical cartons represented by this carton entry. |
   ^carton_nums |[]string |N |["C0001","C0002"] |Carton numbers for the physical cartons represented by this carton entry. Either omit `carton_nums` from every carton to have carton numbers generated automatically, or provide it for every carton. When provided, each value must consist of `C` followed by four digits, values must be unique across the request, and the number of values must equal `quantity`. |
   ^box_measurements |object |Y | |Carton measurement. |
   ^^weight |string |Y |10 |Carton weight. |
   ^^weight_unit |string |Y |POUNDS |The unit used for the carton's weight.

**Possible values:**

* `KILOGRAM` (kg)
* `GRAM` (g)
* `MILLIGRAM` (mg)
* `POUNDS` (lbs)
* `OUNCE` (oz) |
   ^^width |string |Y |20 |Carton width. |
   ^^height |string |Y |2 |Carton height. |
   ^^length |string |Y |3 |Carton length. |
   ^^length_unit |string |Y |INCH |The unit used for the carton's length, width, and height.

**Possible values:**

* `METER` (m)
* `CENTIMETER` (cm)
* `MILLIMETER` (mm)
* `FOOT` (ft)
* `MICRON` (μm)
* `INCH` (in) |
   shipment_option |object |Y | |Shipment option containing freight type and shipping method. |
   ^shipping_method |string |Y |SMALL_PARCEL |Shipping method. Possible values: SMALL_PARCEL (small parcel shipping); FREIGHT (freight shipping). |
   ^freight_type |string |N |FTL |Freight load type. Required when `shipping_method` is `FREIGHT` for EU and UK shops. It is optional for US shops and is not required when `shipping_method` is `SMALL_PARCEL`.

**Possible values:**

* `FTL`
* `LTL` |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202603/ship_inbound_order?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"inbound_order_id":"5766071177167344427","cartons":[{"carton_type":"SINGLE_SKU","items":[{"goods_id":"723456789012345678","quantity":100,"lot_code":"sfsfnjkfvv","expiration_timestamp":"1623812664"}],"quantity":2,"carton_nums":["C0001","C0002"],"box_measurements":{"weight":"10","weight_unit":"POUNDS","width":"20","height":"2","length":"3","length_unit":"INCH"}}],"shipment_option":{"shipping_method":"SMALL_PARCEL","freight_type":"FTL"}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^inbound_order_id | string | 5766071177167344427 | Identifier of the shipped inbound order. |
### Response Sample
```json
{"code":0,"data":{"inbound_order_id":"5766071177167344427"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 39001002 | Request or request parameters are empty. Please recheck the input parameters. |


---

## Update Goods-SKU Relations — `POST /fbt/202603/goods/update_goods_sku_relation`

Doc: https://partner.tiktokshop.com/docv2/page/update-goods-sku-relations-202603 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202603/goods/update_goods_sku_relation
### Method: [POST]
### Function Description
Bind or unbind TikTok Shop SKUs to FBT goods.

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
| operate_goods_sku_relation_list | []object | Y |  | List of goods and SKU relations to bind or unbind. |
| ^tts_goods_id | string | Y | 334556677 | Identifier for goods generated by Fulfilled by TikTok system |
| ^tts_sku_ids | []string | Y | ["723456789012345678"] | Identifiers of the TikTok Shop SKUs to bind to or unbind from the specified FBT goods. |
| operation_type | string | Y | BIND | Operation type for the goods-SKU relation. Possible values: BIND (bind the listed SKUs to the goods); UN_BIND (unbind the listed SKUs from the goods). |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202603/goods/update_goods_sku_relation?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"operate_goods_sku_relation_list":[{"tts_goods_id":"334556677","tts_sku_ids":["723456789012345678"]}],"operation_type":"BIND"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^operate_goods_sku_relation_info | object |  | Results of the requested bindings or unbindings between TikTok Shop SKUs and FBT goods. |
| ^^operate_result_list | []object |  | Goods-SKU relation results, including the goods ID, SKU ID, success status, and failure reason when applicable. |
| ^^^tts_goods_id | string | 9988776655 | Identifier for goods generated by Fulfilled by TikTok system |
| ^^^tts_sku_id | string | 723456789012345678 | Identifier for SKU generated by TikTok Shop system |
| ^^^is_success | bool | false | Whether the goods-SKU relation operation succeeded. |
| ^^^fail_reason | string | SKU does not exist. | Reason the goods-SKU relation operation failed. |
### Response Sample
```json
{"code":0,"data":{"operate_goods_sku_relation_info":{"operate_result_list":[{"tts_goods_id":"9988776655","tts_sku_id":"723456789012345678","is_success":false,"fail_reason":"SKU does not exist."}]}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Search Goods Hazmat And Expiration Info — `POST /fbt/202603/goods/hazmat_and_expiration_info/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-goods-hazmat-and-expiration-info-202603 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202603/goods/hazmat_and_expiration_info/search
### Method: [POST]
### Function Description
Search hazmat and expiration information for goods by TikTok Shop SKU IDs.

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
| tts_sku_ids | []string | Y | ["723456789012345678"] | Identifier for Stock Keeping Unit (SKU) generated by TikTok Shop system |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202603/goods/hazmat_and_expiration_info/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"tts_sku_ids":["723456789012345678"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^hazmat_and_expiration_info | object |  | Container for per-SKU hazmat, lot-control, and expiration-management results. |
| ^^hazmat_and_expiration_dto_list | []object |  | Per-SKU hazmat, lot-control, and expiration-management results. Correlate each entry with the requested SKU using `tts_sku_id`. |
| ^^^tts_sku_id | string | 723456789012345678 | Identifier for Stock Keeping Unit (SKU) generated by TikTok Shop system |
| ^^^is_hazmat | bool | false | Indicates whether the product is classified as hazardous material under FBT rules. |

* `true`: The product is classified as hazardous material. Provide the required hazmat declaration through `hazmat_info` when calling **Create FBT Goods** or **Update FBT Goods Info**.
* `false`: The product is not classified as hazardous material. |
   ^^^is_lot_code |bool |true |if the product requires lot management based on FBT category rule
   TRUE:this product requires lot control
   FALSE:this product does not require lot control
   |
   ^^^is_expiration_management |bool |true |Indicates whether the product requires expiration management based on the FBT category rule.
   TRUE: this product requires expiration management.
   FALSE: this product does not require expiration management. |
   ^^^exp_base_info |object | |Expiration-management thresholds for the product associated with the SKU when `is_expiration_management` is `true`. |
   ^^^^inbound_cutoff_days |int |90 |The period before a product's expiration date when the warehouse will stop accepting inbound shipments.For example, if the product expiration date is December 1, 2024, and the inbound cutoff days are 20 days, then the warehouse will stop accepting inbound shipments for this product after November 11, 2024 (20 days before expiration) |
   ^^^^expiration_alert_days |int |80 |The period of time before expiration in which the platform will send expiration alerts. |
   ^^^^sales_cutoff_days |int |70 |The period before a product's expiration date when the inventory will no longer be available for sale. For example, if the product expiration date is December 1, 2024, and the sales cutoff days are 20 days, then the inventory will stop being available for sale after November 11, 2024 (20 days before expiration). |

### Response Sample
```json
{"code":0,"data":{"hazmat_and_expiration_info":{"hazmat_and_expiration_dto_list":[{"tts_sku_id":"723456789012345678","is_hazmat":false,"is_lot_code":true,"is_expiration_management":true,"exp_base_info":{"inbound_cutoff_days":90,"expiration_alert_days":80,"sales_cutoff_days":70}}]}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Create FBT MCF Order — `POST /fbt/202607/mcf_outbound_orders`

Doc: https://partner.tiktokshop.com/docv2/page/create-fbt-mcf-order-202607 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202607/mcf_outbound_orders
### Method: [POST]
### Function Description
For orders created on other sales channels that require fulfillment via FBT, this API enables you to create corresponding orders (hereinafter referred to as MCF Orders). Once MCF Orders are successfully created, they will be automatically submitted to the FBT system for fulfillment.

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
| external_order_id | string | Y | shopify202208291503530001100220033 | The corresponding order ID in your OMS. Maximum UTF-8 length: 127 bytes. It must be unique among active MCF orders for the same merchant. Reusing an `external_order_id` from an active order is rejected as a duplicate and is not an idempotent retry. |
| goods | []object | Y |  | The item IDs and quantities included in the order. The array must contain at least one item, and each item must be managed in the FBT system. The sum of `quantity` across all entries in `goods` must not exceed 50. |
| ^id | string | Y | 1234567 | The goods ID generated by the Fulfilled by TikTok system. The value must be a positive base-10 integer string. |
| ^quantity | int | Y | 1 | The quantity of this item. Must be greater than 0. |
| consignee | object | Y |  | The consignee contact info |
| ^name | string | Y | username | The consignee name. Must not exceed 128 UTF-8 bytes. |
| ^phone_number | string | Y | (+1)1211223910 | The phone number of consignee |
| ^email | string | Y | username@example.com | The email of consignee |
| ^address | object | Y |  | The consignee address must be a valid address; if the address verification fails, no order will be created. |
| ^^country_code | string | Y | US | The consignee address country code in two-character ISO 3166-1 alpha-2 format. Only `US` is accepted. |
| ^^state_or_region | string | Y | Alabama | Consignee address state or region |
| ^^district_or_county | string | N | Baldwin | Consignee address district or county |
| ^^city | string | Y | Bay Minette | Consignee address city |
| ^^address_line_1 | string | Y | 312 Courthouse Square | The detail address line 1 |
| ^^address_line_2 | string | N | Suite 10 | The detail address line 2 |
| ^^postal_code | string | N | 36507 | The 5-digit US ZIP code for the consignee address. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202607/mcf_outbound_orders?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"external_order_id":"shopify202208291503530001100220033","goods":[{"id":"1234567","quantity":1}],"consignee":{"name":"username","phone_number":"(+1)1211223910","email":"username@example.com","address":{"country_code":"US","state_or_region":"Alabama","district_or_county":"Baldwin","city":"Bay Minette","address_line_1":"312 Courthouse Square","address_line_2":"Suite 10","postal_code":"36507"}}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^mcf_order | object |  | Information about the successfully created MCF order. On a successful response, this object contains `mcf_order_id`, `external_order_id`, and `create_time`. |
| ^^external_order_id | string | shopify202208291503530001100220033 | The corresponding order ID in your OMS. |
| ^^mcf_order_id | string | 7136104329798256386 | A unique ID that identifies different MCF orders |
| ^^create_time | int | 1661756811 | The Unix timestamp, in seconds, when the MCF order was created. |
### Response Sample
```json
{"code":0,"data":{"mcf_order":{"external_order_id":"shopify202208291503530001100220033","mcf_order_id":"7136104329798256386","create_time":1661756811}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 177001001 | Missing parameters or parameters have incorrect format |
| 177001002 | Item data does not exist in the FBT system. You must provide valid item IDs; otherwise, the FBT system cannot fulfill the order. |
| 177001003 | The address information has failed verification. Please check the validity of the address, Please make sure your address is accurate, check address via USPS ZIP Lookup Tool. |
| 177001004 | Insufficient inventory; unable to fulfill the order. Please replenish the inventory or arrange delivery via alternative methods. |
| 177001006 | The merchant has no permission to create external orders; please check your permissions or contact the platform. |
| 177001007 | The external_order_number has been associated with an active MCF Order. The FBT system is currently processing the order delivery, and duplicate order creation is not allowed. |
| 177001008 | The order creation rate limit has been exceeded; please reduce the call frequency or try again later. |
| 177001009 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 177001010 | Order information cannot be retrieved via the mcf_order_id you provided; please check if your ID is correct. |
| 177001011 | address is unreachable |
| 177001012 | order has been pushed to fulfillment system, cannot push again |
| 177001013 | no permission,please pay for the FBT billing first |
| 177001014 | the zipcode is wrong |
| 177001015 | new goods have not yet arrived at the warehouse |
| 177001016 | the maximum number of goods per order cannot exceed 99 |


---

## Search Goods Info — `POST /fbt/202607/goods/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-goods-info-202607 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202607/goods/search
### Method: [POST]
### Function Description
Retrieves goods belonging to the merchant that match the specified filters and returns their IDs, names, goods-SKU relationships, merchant-declared measurements, warehouse-confirmed measurements, and other attributes. When more than one of `goods_ids`, `product_ids`, `reference_codes`, and `sku_ids` is provided, the API returns only goods that match all provided filter fields. If all four filters are empty or omitted, the API returns the merchant's goods in descending creation-time order, limited by `page_size`.

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
| page_size | int | Y | 50 | The number of results to be returned per page. |
| Valid range: [1-100]. |  |  |  |  |
| page_token | string | N | cGFnZV9udW1iZXI9Mg== | An opaque token used to retrieve the next page of a paginated result set. Retrieve this value from the result of the `next_page_token` from a previous response. It is not needed for the first page. |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | string | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| goods_ids | []string | N | ["256080616234"] | Fulfilled by TikTok goods IDs used to filter the results. Each ID must be a positive decimal string. Maximum: 100 IDs per request. |
| product_ids | []string | N | ["256990616123"] | TikTok Shop product IDs used to filter the results. Each ID must be a positive decimal string. Maximum: 100 IDs per request. |
| reference_codes | []string | N | ["SELLERSKU 123456"] | Merchant-defined goods reference codes used to filter the results. Maximum: 100 codes per request. |
| sku_ids | []string | N | ["256086568895"] | TikTok Shop SKU IDs used to filter the results. Each ID must be a positive decimal string. Maximum: 100 IDs per request. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202607/goods/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_size=50&page_token=cGFnZV9udW1iZXI9Mg==
```

**Body**
```json
{"goods_ids":["256080616234"],"product_ids":["256990616123"],"reference_codes":["SELLERSKU 123456"],"sku_ids":["256086568895"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^next_page_token | string | cGFnZV9udW1iZXI9Mg== | An opaque token used to retrieve the next page. When this value is non-empty, pass it unchanged in the next request's `page_token`. An empty string means there are no more pages. |
| ^total_count | int | 123 | The total number of goods that meet the query conditions. |
| ^goods | []object |  | A list of detailed information for Fulfilled by TikTok goods. |
| ^^id | string | 86533997569 | The identifier for goods generated by Fulfilled by TikTok system. |
| ^^name | string | water1.0 | The goods name. |
| ^^barcodes | []object |  | A list of detailed information for goods barcodes. |
| ^^^code | string | 014673829105 | The printable barcode for the goods. |
| ^^^type | string | UPC | The barcode type. |
| Possible values: |  |  |  |

* UPC
* EAN
* GTIN
* ASIN_OR_FNSKU
* MERCHANT_SKU_ID
* FBT_SPECIFIC_BARCODE |
   ^^reference_code |string |abc32323 |The identifier for goods defined by merchant. |
   ^^image_url |string |https://example.com/fbt/goods-image.jpg |The goods image url. |
   ^^merchant_declaration_info |object | |The dimension and weight info input by merchant. |
   ^^^weight |object | |The goods weight. |
   ^^^^value |string |1.122 |Weight value, up to three decimal places. |
   ^^^^unit |string |GRAM |Weight unit.
   Possible values:
* MILLIGRAM
* GRAM
* KILOGRAM
* POUND
* OUNCE |
   ^^^dimension |object | |The goods dimension. |
   ^^^^width |string |1.122 |Width value, up to three decimal places. |
   ^^^^length |string |2.122 |Length value, up to three decimal places. |
   ^^^^height |string |3.122 |Height value, up to three decimal places. |
   ^^^^unit |string |CENTIMETER |Dimension unit.
   Possible values:
* MILLIMETER
* CENTIMETER
* METER
* FOOT
* INCH
* MICROMETER |
   ^^warehouse_confirmation_info |object | |Dimension and weight information verified by the warehouse during the goods' first inbound. Returned only when at least one warehouse-confirmed weight, length, width, or height value is available. If this object is omitted, no warehouse-confirmed measurement is available in this response. |
   ^^^weight |object | |The goods weight. |
   ^^^^value |string |1 |Weight value verified by warehouse, up to three decimal places. |
   ^^^^unit |string |GRAM |Weight unit.
   Possible values:
* MILLIGRAM
* GRAM
* KILOGRAM
* POUND
* OUNCE |
   ^^^dimension |object | |The goods dimension. |
   ^^^^width |string |1 |Width value verified by warehouse, up to three decimal places. |
   ^^^^length |string |2.5 |Length value verified by warehouse, up to three decimal places. |
   ^^^^height |string |3 |Height value verified by warehouse, up to three decimal places. |
   ^^^^unit |string |CENTIMETER |Dimension unit.
   Possible values:
* MILLIMETER
* CENTIMETER
* METER
* FOOT
* INCH
* MICRO |
   ^^skus |[]object | |A list of Stock Keeping Units (SKUs) infomation matched with current FBT goods. |
   ^^^id |string |1729439634328225260 |The identifier for SKU generated by TikTok Shop system. |
   ^^^name |string |Testcase SKU |The SKU name. |
   ^^^image_url |string |https://example.com/fbt/sku-image.jpg |The TikTok Shop SKU image url. |
   ^^^product |object | |The TikTok Shop product matched with current Fulfilled by TikTok goods. |
   ^^^^id |string |1729439631253210604 |The identifier for product generated by TikTok Shop system. |
   ^^^^name |string |Testcase_xd2.0_test_goods |The TikTok Shop product name. |
   ^^^^image_url |string |https://example.com/fbt/product-image.jpg |The Tiktok Shop product image url. |
   ^^^regions |[]string |["US"] |The regions where the SKU is being sold, represented by region codes in the two-character ISO 3166-1 alpha-2 format. |
   ^^^matched |bool |true |Indicates that the SKU is matched to the current Fulfilled by TikTok goods. Entries in `skus` are matched relations, so this value is always `true`. |
   ^^lot_expiration_info |object | |The goods lot control and expiration managment information. |
   ^^^is_lot_control |bool |true |A flag indicating whether the goods is under lot control.
   True: Under lot control.
   False: Not under lot control.
   Note: Lot code and expiration date management information is mandatory for these [product categories](https://bytedance.us.larkoffice.com/sheets/OoT2sKH7jhykXCtHEseuzkGYsod) according to Fulfilled by TikTok guidelines. |
   ^^^is_expiration_management |bool |true |A flag indicating whether the goods is under expiration managment.
   True: Under expiration managment.
   False: Not under expiration managment. |
   ^^^shelf_life_days |int |12 |The goods shelf life days input by merchant, represent the total number of days the product remains usable or sellable from the time it is manufactured until its expiration. |
   ^^^inbound_cutoff_days |int |90 |The goods inbound cutoff days before expiration, represent the time period before the product's expiration when the warehouse will no longer accept inbound shipments. |
   ^^^expiration_alert_days |int |60 |The goods alert days before expired, represent the period of time before platform send expiration reminder alerts to the merchant. |
   ^^^sales_cutoff_days |int |20 |The goods sales cut off days before expired, represent the period of time before expiration in which the goods will no longer be available for sale. |
   ^^^handling_method |string |DISPOSE |The handling method for expired inventory.
   Possible values:
* `STORE_UNITS`: Move the units to defective inventory.
* `RETURN_TO_SELLER`: Return the units to the seller.
* `DISPOSE`: Dispose of the units. |
   ^^is_hazmat |bool |false |whether is hazmat goods |
   ^^hazmat_info |object | |Hazardous-material details. Returned only when `is_hazmat` is `true`. The subtype object depends on `hazmat_type`: `battery_extra_info` for `BATTERY`, `flammable_liquids_extra_info` for `FLAMMABLE_LIQUID`, and `aerosol_extra_info` for `AEROSOLS`. `MAGNETIZED` does not include a subtype object. |
   ^^^hazmat_type |string |MAGNETIZED |hazardous goods type
   Possible values:
   -MAGNETIZED
   -BATTERY
   -FLAMMABLE_LIQUID
   -AEROSOLS |
   ^^^battery_extra_info |object | |Additional battery information for hazmat goods. |
   ^^^^battery_type |string |LITHIUM_ION |Battery type
   Possible values:
   LITHIUM_ION
   LITHIUM_METAL
   OTHER |
   ^^^^battery_packaging_type |string |STANDALONE |Battery packaging type.
   Possible values:
* STANDALONE
* IN_EQUIPMENT
* WITH_EQUIPMENT
* OTHER |
   ^^^^total_battery_weight |string |1 |Total battery weight in the unit specified by total_battery_weight_unit. |
   ^^^^total_battery_weight_unit |string |GRAM |Unit for total_battery_weight. Possible value: GRAM. |
   ^^^^total_battery_capacity |string |1 |Total battery capacity in the unit specified by total_battery_capacity_unit. |
   ^^^^battery_count_per_package |string |2 |per package battery count |
   ^^^^is_need_un_38_3_test |bool |false |UN38.3 testing ensures that batteries meet specific safety criteria. Please send the report in the field if it's not included in the MSDS. |
   ^^^^un_38_3_test_file_url |string |https://example.com/fbt/msds-report.pdf |UN38.3 testing file URL |
   ^^^^total_battery_capacity_unit |string |WATT_HOURS |Unit for `total_battery_capacity`, such as `WATT_HOURS`. |
   ^^^flammable_liquids_extra_info |object | |flammable liquids info |
   ^^^^flammable_liquids_type |string |PAINT |Flammable liquid type, possible values
   -PAINT
   -PERFUMERY
   -ALCOHOLIC
   -OTHER |
   ^^^^flammable_liquids_volume |string |1 |Volume of flammable liquid in the unit specified by volume_unit. |
   ^^^^volume_unit |string |MILLILITER |Unit for `flammable_liquids_volume`, such as `MILLILITER`. |
   ^^^aerosol_extra_info |object | |aerosol info |
   ^^^^volume |string |1 |aeroslo volume |
   ^^^^volume_unit |string |MILLILITER |aeroslo volume unit |
   ^^^dg_class |string |CLASS_2
   |Hazmat class
   Possible values:
   -CLASS_2
   -CLASS_3
   -CLASS_9 |
   ^^^dg_uncode |string |UN1266 |UN identifier for the hazardous substance. Standard UN values use the `UN` prefix followed by four digits; `OTHER` is also supported.
   Possible values:
* UN2807
* UN3480
* UN3090
* UN3481
* UN3091
* UN1263
* UN1266
* UN3065
* OTHER |
   ^^^msds_file_url |string |https://example.com/fbt/msds-report.pdf |Material safety data sheet of the hazmat goods to support review the goods' safety compliance in FBT |
   ^^sioc_approval_status |string |SIOC_APPROVAL_STATUS_APPROVE |SIOC-specific approval status. This field is returned when `is_sioc` is `true` and an SIOC approval status is available.
   Possible values:
* SIOC_APPROVAL_STATUS_INVALID
* SIOC_APPROVAL_STATUS_INIT
* SIOC_APPROVAL_STATUS_UNDER_REVIEW
* SIOC_APPROVAL_STATUS_APPROVE
* SIOC_APPROVAL_STATUS_REJECT |
   ^^hazmat_approval_status |string |APPROVAL_STATUS_UNDER_REVIEW |FBT fulfillment approval status. This field is returned for goods that are hazardous materials or managed as Ships in Own Container (SIOC).
   Possible values:
* APPROVAL_STATUS_INVALID
* APPROVAL_STATUS_INIT
* APPROVAL_STATUS_UNDER_REVIEW
* APPROVAL_STATUS_FULFILLABLE
* APPROVAL_STATUS_UNFULFILLABLE |
   ^^bulky_item_attribute |object | |bulky item info |
   ^^^is_bulky_item |bool |false |whether the goods is_bulky_item |
   ^^^is_bulky_item_accessories |bool |false |whether the goods is bulky accessories |
   ^^goods_safety_attributes |object | |safety attribute info |
   ^^^is_fragile |bool |false |whether fragile |
   ^^^is_liquid |bool |false |whether liquid |
   ^^^is_sharp |bool |false |whether sharp |
   ^^is_sioc |bool |false |whether sioc |
   ^^sioc_attribute |object | |sioc info |
   ^^^sioc_files |[]object | |sioc files |
   ^^^^sioc_certification_url |string |https://example.com/fbt/sioc-certification.jpg |sico attachment url |
   ^^^^sioc_file_type |string |PHOTO |sioc attachment type:
* PHOTO
* DOCUMENT
* DROP_TEST_VIDEO |

### Response Sample
```json
{"code":0,"data":{"next_page_token":"cGFnZV9udW1iZXI9Mg==","total_count":123,"goods":[{"id":"86533997569","name":"water1.0","barcodes":[{"code":"014673829105","type":"UPC"}],"reference_code":"abc32323","image_url":"https://example.com/fbt/goods-image.jpg","merchant_declaration_info":{"weight":{"value":"1.122","unit":"GRAM"},"dimension":{"width":"1.122","length":"2.122","height":"3.122","unit":"CENTIMETER"}},"warehouse_confirmation_info":{"weight":{"value":"1","unit":"GRAM"},"dimension":{"width":"1","length":"2.5","height":"3","unit":"CENTIMETER"}},"skus":[{"id":"1729439634328225260","name":"Testcase SKU","image_url":"https://example.com/fbt/sku-image.jpg","product":{"id":"1729439631253210604","name":"Testcase_xd2.0_test_goods","image_url":"https://example.com/fbt/product-image.jpg"},"regions":["US"],"matched":true}],"lot_expiration_info":{"is_lot_control":true,"is_expiration_management":true,"shelf_life_days":12,"inbound_cutoff_days":90,"expiration_alert_days":60,"sales_cutoff_days":20,"handling_method":"DISPOSE"},"is_hazmat":false,"hazmat_info":{"hazmat_type":"MAGNETIZED","battery_extra_info":{"battery_type":"LITHIUM_ION","battery_packaging_type":"STANDALONE","total_battery_weight":"1","total_battery_weight_unit":"GRAM","total_battery_capacity":"1","battery_count_per_package":"2","is_need_un_38_3_test":false,"un_38_3_test_file_url":"https://example.com/fbt/msds-report.pdf","total_battery_capacity_unit":"WATT_HOURS"},"flammable_liquids_extra_info":{"flammable_liquids_type":"PAINT","flammable_liquids_volume":"1","volume_unit":"MILLILITER"},"aerosol_extra_info":{"volume":"1","volume_unit":"MILLILITER"},"dg_class":"CLASS_2\n","dg_uncode":"UN1266","msds_file_url":"https://example.com/fbt/msds-report.pdf"},"sioc_approval_status":"SIOC_APPROVAL_STATUS_APPROVE","hazmat_approval_status":"APPROVAL_STATUS_UNDER_REVIEW","bulky_item_attribute":{"is_bulky_item":false,"is_bulky_item_accessories":false},"goods_safety_attributes":{"is_fragile":false,"is_liquid":false,"is_sharp":false},"is_sioc":false,"sioc_attribute":{"sioc_files":[{"sioc_certification_url":"https://example.com/fbt/sioc-certification.jpg","sioc_file_type":"PHOTO"}]}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Update FBT Goods Info — `POST /fbt/202607/goods/update_goods_info`

Doc: https://partner.tiktokshop.com/docv2/page/update-fbt-goods-info-202607 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202607/goods/update_goods_info
### Method: [POST]
### Function Description
Update FBT goods information, including goods name, image URL, dimensions, hazmat details, shelf-life attributes, and return address information.

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
| update_goods_dto | object | N |  | Goods information to update. |
Update behavior is field-specific; this object is neither a uniform partial patch nor a full replacement.
Shared fields:

* `tts_goods_id`: Identifies the goods record to update; it is not mutable.
* `goods_name`, `goods_image_url`, `return_handling_method`, and `dimension_and_weight_base_info`: Replace their stored values.
* `reference_code`: If omitted or empty, it is reset to the system-generated fallback.
* `barcode_infos`: Replaces the existing barcode set. The FBT system barcode is preserved or added, and existing non-system barcodes omitted from the request are deleted. Removal of a barcode with an inbound record is rejected.
* `is_hazmat`: `false` clears existing hazmat information. `true` requires valid `hazmat_info`.

Optional extended fields:

* `is_sioc` and `sioc_attribute`: `is_sioc` controls Ships in Own Container (SIOC) management. If `is_sioc` is omitted, no SIOC state or attribute update is requested, and `sioc_attribute` alone is ignored.
* `goods_safety_attributes`: Omitted fragile, liquid, or sharp subfields retain their stored values. A changed value for a locked subfield causes the request to fail; resubmitting the same locked value is a no-op. Supplied editable values are updated.

Do not send explicit `null`; the public schemas for these fields are non-nullable. |
^tts_goods_id |string |Y |8839232030 |Identifier for goods generated by the Fulfilled by TikTok system. |
^goods_name |string |Y |Wireless Charging Cable |Name of the goods. |
^goods_image_url |string |Y |https://example.com/fbt/goods-image.jpg |Image URL for the goods. |
^reference_code |string |N |ABDK999d |Reference code for the goods. |
^barcode_infos |[]object |N | |barcode info list |
^^barcode_type |string |N |UPC |Type of barcode provided for the goods. |
^^barcode_value |string |N |223333 |Barcode value for the goods. |
^return_handling_method |string |Y |RESTOCK_SELLABLE_DISPOSE_UNSELLABLE |Return handling method stored for the FBT customer return service. This field is required on every update request.
Possible values:

* RESTOCK_SELLABLE_DISPOSE_UNSELLABLE
* DISPOSAL_WITHOUT_INSPECTION
* RETURN_WITHOUT_INSPECTION
* RESTOCK_SELLABLE_RETURN_UNSELLABLE |
   ^dimension_and_weight_base_info |object |Y | |dimension and weight info |
   ^^weight_value |string |Y |500 |Weight of the goods in the specified weight_unit. |
   ^^length_value |string |Y |40 |Length of the goods in the specified dimension_unit. |
   ^^width_value |string |Y |20 |Width of the goods in the specified dimension_unit. |
   ^^height_value |string |Y |30 |Height of the goods in the specified dimension_unit. |
   ^^weight_unit |string |Y |GRAM |Weight unit.
   Possible values:
* MILLIGRAM
* GRAM
* KILOGRAM
* POUND
* OUNCE |
   ^^dimension_unit |string |Y |CENTIMETER |Dimension unit.
   Possible values:
* MILLIMETER
* CENTIMETER
* METER
* FOOT
* INCH |
   ^is_hazmat |bool |Y |false |whether is hazmat goods |
   ^hazmat_info |object |N | |Hazmat information used when `is_hazmat` is `true`. |
   ^^hazmat_type |string |Y |BATTERY |hazardous goods type
   Possible values:
   -MAGNETIZED
   -BATTERY
   -FLAMMABLE_LIQUID
   -AEROSOLS |
   ^^battery_extra_info |object |N | |Battery details. Required when `is_hazmat` is `true`, `dg_class` is `CLASS_9`, and `hazmat_type` is `BATTERY`. Provide every field marked as required in this object. `total_battery_weight` must be a numeric string greater than `0`. When `battery_packaging_type` is `STANDALONE`, `battery_count_per_package` is required and must be a numeric string greater than `0`. |
   ^^^battery_type |string |Y |LITHIUM_ION |Battery type
   Possible values:
   LITHIUM_ION
   LITHIUM_METAL
   OTHER |
   ^^^battery_packaging_type |string |Y |STANDALONE |Battery packaging type.
   Possible values:
* STANDALONE
* IN_EQUIPMENT
* WITH_EQUIPMENT
* OTHER |
   ^^^total_battery_weight |string |Y |10 |total battery weight |
   ^^^total_battery_weight_unit |string |Y |GRAM |total battery weight unit, possible value:GRAM |
   ^^^total_battery_capacity |string |Y |2 |Total battery capacity in watt-hours. |
   ^^^total_battery_capacity_unit |string |Y |WATTHOUR |total battery capacity unit,possible value:WATTHOUR |
   ^^^is_need_un_38_3_test |bool |Y |false |UN38.3 testing ensures that batteries meet specific safety criteria. Please send the report in the field if it's not included in the MSDS. |
   ^^^un_38_3_test_file_url |string |N |https://example.com/fbt/un38-3-test-report.pdf |UN38.3 testing file URL |
   ^^^battery_count_per_package |string |N |3 |per package battery count |
   ^^flammable_liquids_extra_info |object |N | |Flammable-liquid details. Required when `is_hazmat` is `true`, `dg_class` is `CLASS_3`, and `hazmat_type` is `FLAMMABLE_LIQUID`. `flammable_liquids_type` must be valid, and `flammable_liquids_volume` must be a numeric string greater than `0`. |
   ^^^flammable_liquids_type |string |Y |PAINT |Flammable liquid type.
   Possible values:
* PAINT
* PERFUMERY
* ALCOHOLIC
* OTHER |
   ^^^flammable_liquids_volume |string |Y |1 |Flammable liquid volume, |
   ^^^volume_unit |string |N |MILLILITERS |volume unit |
   ^^dg_class |string |Y |CLASS_3 |Hazmat class
   Possible values:
   -CLASS_2
   -CLASS_3
   -CLASS_9 |
   ^^dg_uncode |string |Y |UN2807 |UN identifier for the hazardous substance. Standard UN values use the `UN` prefix followed by four digits; `OTHER` is also supported.
   Possible values:
* UN2807
* UN3480
* UN3090
* UN3481
* UN3091
* UN1263
* UN1266
* UN3065
* OTHER |
   ^^msds_file_url |string |Y |https://example.com/fbt/msds-report.pdf |Material safety data sheet of the hazmat goods to support review the goods' safety compliance in FBT |
   ^^aerosol_extra_info |object |N | |Aerosol details. Required when `is_hazmat` is `true`, `dg_class` is `CLASS_2`, and `hazmat_type` is `AEROSOLS`. `volume` is required and must be a numeric string greater than `0`. |
   ^^^volume |string |N |1 |aeroslo volume |
   ^^^volume_unit |string |N |MILLILITERS |aeroslo volume unit |
   ^is_lot_code |bool |Y |false |if the product requires lot management based on FBT category rule
   TRUE:this product requires lot control
   FALSE:this product does not require lot control
   |
   ^is_expiration_management |bool |Y |false |Whether the goods require expiration management. |
   ^shelf_life_attribute_info |object |N | |Shelf-life attributes for the goods. |
   ^^shelf_life |int |N |10 |The goods shelf life (days) |
   ^^inbound_cutoff_days |int |Y |90 |The goods inbound cutoff days before expiration, represent the time period before the product's expiration when the warehouse will no longer accept inbound shipments. |
   ^^expiration_alert_days |int |Y |80 |The goods alert days before expired, represent the period of time before platform send expiration reminder alerts to the merchant. |
   ^^sales_cutoff_days |int |Y |70 |The goods sales cutoff days before expiration, representing the period before expiration when the goods will no longer be available for sale. |
   ^^handling_method_expired_goods |string |N |DISPOSE |How expired inventory is handled.
   Possible values:
* `STORE_UNITS`: Move the units to defective inventory.
* `RETURN_TO_SELLER`: Return the units to the seller.
* `DISPOSE`: Dispose of the units. |
   ^is_sioc |bool |N |false |whether sioc |
   ^sioc_attribute |object |N | |sioc info |
   ^^sioc_files |[]object |N | |sioc files |
   ^^^sioc_certification_url |string |N |https://example.com/fbt/sioc-certification.jpg |sico attachment url |
   ^^^sioc_file_type |string |N |PHOTO |sioc attachment type:
* PHOTO
* DOCUMENT
* DROP_TEST_VIDEO |
   ^bulky_item_attribute |object |N | |bulky item info |
   ^^is_bulky_item_accessories |bool |N |false |whether the goods is bulky accessories |
   ^goods_safety_attributes |object |N | |safety attribute info |
   ^^is_fragile |bool |N |false |whether fragile |
   ^^is_liquid |bool |N |false |whether liquid |
   ^^is_sharp |bool |N |false |whether sharp |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202607/goods/update_goods_info?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"update_goods_dto":{"tts_goods_id":"8839232030","goods_name":"Wireless Charging Cable","goods_image_url":"https://example.com/fbt/goods-image.jpg","reference_code":"ABDK999d","barcode_infos":[{"barcode_type":"UPC","barcode_value":"223333"}],"return_handling_method":"RESTOCK_SELLABLE_DISPOSE_UNSELLABLE","dimension_and_weight_base_info":{"weight_value":"500","length_value":"40","width_value":"20","height_value":"30","weight_unit":"GRAM","dimension_unit":"CENTIMETER"},"is_hazmat":false,"hazmat_info":{"hazmat_type":"BATTERY","battery_extra_info":{"battery_type":"LITHIUM_ION","battery_packaging_type":"STANDALONE","total_battery_weight":"10","total_battery_weight_unit":"GRAM","total_battery_capacity":"2","total_battery_capacity_unit":"WATTHOUR","is_need_un_38_3_test":false,"un_38_3_test_file_url":"https://example.com/fbt/un38-3-test-report.pdf","battery_count_per_package":"3"},"flammable_liquids_extra_info":{"flammable_liquids_type":"PAINT","flammable_liquids_volume":"1","volume_unit":"MILLILITERS"},"dg_class":"CLASS_3","dg_uncode":"UN2807","msds_file_url":"https://example.com/fbt/msds-report.pdf","aerosol_extra_info":{"volume":"1","volume_unit":"MILLILITERS"}},"is_lot_code":false,"is_expiration_management":false,"shelf_life_attribute_info":{"shelf_life":10,"inbound_cutoff_days":90,"expiration_alert_days":80,"sales_cutoff_days":70,"handling_method_expired_goods":"DISPOSE"},"is_sioc":false,"sioc_attribute":{"sioc_files":[{"sioc_certification_url":"https://example.com/fbt/sioc-certification.jpg","sioc_file_type":"PHOTO"}]},"bulky_item_attribute":{"is_bulky_item_accessories":false},"goods_safety_attributes":{"is_fragile":false,"is_liquid":false,"is_sharp":false}}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^update_result_info | object |  | Goods update result information. |
| ^^tts_goods_id | string | 1233444 | Identifier for goods generated by Fulfilled by TikTok system |
| ^^is_success | bool | true | Whether the goods update succeeded. |
| ^^fail_reason | string | Goods update failed. | Reason the goods update failed. |
### Response Sample
```json
{"code":0,"data":{"update_result_info":{"tts_goods_id":"1233444","is_success":true,"fail_reason":"Goods update failed."}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Create FBT Goods — `POST /fbt/202607/goods/create_goods`

Doc: https://partner.tiktokshop.com/docv2/page/create-fbt-goods-202607 · cập nhật 2026-10-11 · scope: seller.fbt.info

### Path: /fbt/202607/goods/create_goods
### Method: [POST]
### Function Description
Create FBT goods records and link each record to a TikTok Shop SKU. Request-level errors can be returned before per-item results are populated. When `create_result_info.create_result_list` contains entries, correlate them by `tts_sku_id`, check `is_success` for each returned item, read `fail_reason` for failures, and use `tts_goods_id` for successes.
The request supports dimensions and weight, return handling, hazardous-material, shelf-life, SIOC, bulky-item, and safety attributes.

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
| create_goods_dto_list | []object | Y |  | List of goods records to create. |
| ^tts_sku_id | string | Y | 723456789012345678 | Identifier for Stock Keeping Unit (SKU) generated by TikTok Shop system |
| ^create_goods_type | string | Y | CREATE_AND_BIND | Type of create-goods operation. Current supported value: CREATE_AND_BIND. |
| ^goods_name | string | Y | Wireless Charging Cable | Name of the goods. Maximum length: 255 characters. |
| ^goods_image_url | string | Y | https://example.com/fbt/goods-image.jpg | Image URL for the goods. |
| ^reference_code | string | N | ABDK999d | Reference code for the goods. Maximum length: 50 characters. |
| ^barcode_infos | []object | N |  | Barcodes for the goods. For each goods record, provide at most one UPC, EAN, or GTIN in total, at most five ASIN_OR_FNSKU values, and at most five MERCHANT_SKU_ID values. |
| ^^barcode_type | string | N | UPC | Type of barcode provided for the goods, such as UPC. |
| ^^barcode_value | string | N | 12345678905 | Barcode value. UPC must contain 8 or 12 digits; EAN must contain 8 or 13 digits; and GTIN must contain 8, 12, 13, or 14 digits. UPC, EAN, and GTIN values must have a valid checksum. ASIN_OR_FNSKU must contain 10 uppercase letters or digits and start with B or X. MERCHANT_SKU_ID must contain 1 to 32 printable ASCII characters with no whitespace. |
| ^return_handling_method | string | Y | RESTOCK_SELLABLE_DISPOSE_UNSELLABLE | Return handling method for the FBT customer return service. The default value will be Restock sellable, Dispose unsellable. |
| Possible values: |  |  |  |  |

* COLLECT_RETURN_UNITS
* RESTOCK_SELLABLE_COLLECT_UNSELLABLE
* RESTOCK_SELLABLE_DISPOSE_UNSELLABLE
* DISPOSAL_WITHOUT_INSPECTION
* RETURN_WITHOUT_INSPECTION
* RESTOCK_SELLABLE_RETURN_UNSELLABLE |
   ^dimension_and_weight_base_info |object |Y | |Dimensions and weight for the goods. weight_value, length_value, width_value, and height_value must each be a numeric string greater than 0. |
   ^^weight_value |string |Y |500 |Weight of the goods in the specified weight_unit. |
   ^^length_value |string |Y |2 |Length of the goods in the specified dimension_unit. |
   ^^width_value |string |Y |2 |Width of the goods in the specified dimension_unit. |
   ^^height_value |string |Y |3 |Height of the goods in the specified dimension_unit. |
   ^^weight_unit |string |Y |GRAM |Weight unit. Possible values: MILLIGRAM (mg), GRAM (g), KILOGRAM (kg), POUND (lb), OUNCE (oz). |
   ^^dimension_unit |string |Y |CENTIMETER |Dimension unit. Possible values: MILLIMETER (mm), CENTIMETER (cm), METER (m), FOOT (ft), INCH (in). |
   ^is_hazmat |bool |Y |false |whether is hazmat goods |
   ^hazmat_info |object |N | |Hazardous-material details. Required when is_hazmat is true. For hazmat_type BATTERY, FLAMMABLE_LIQUID, or AEROSOLS, provide battery_extra_info, flammable_liquids_extra_info, or aerosol_extra_info, respectively. |
   ^^hazmat_type |string |Y |BATTERY |hazardous goods type
   Possible values:
   -MAGNETIZED
   -BATTERY
   -FLAMMABLE_LIQUID
   -AEROSOLS |
   ^^battery_extra_info |object |N | |Battery details for goods with hazmat_type set to BATTERY. total_battery_weight must be greater than 0. When battery_packaging_type is STANDALONE, battery_count_per_package must be greater than 0. When is_need_un_38_3_test is true, provide un_38_3_test_file_url. |
   ^^^battery_type |string |Y |LITHIUM_ION |Battery type
   Possible values:
   LITHIUM_ION
   LITHIUM_METAL
   OTHER |
   ^^^battery_packaging_type |string |Y |STANDALONE |Battery packaging type.
   Possible values:
* STANDALONE
* IN_EQUIPMENT
* WITH_EQUIPMENT
* OTHER |
   ^^^total_battery_weight |string |Y |10 |Total battery weight in the unit specified by total_battery_weight_unit. |
   ^^^total_battery_weight_unit |string |Y |GRAM |Unit for total_battery_weight. Possible value: GRAM. |
   ^^^total_battery_capacity |string |Y |2 |Total battery capacity in the unit specified by total_battery_capacity_unit. |
   ^^^total_battery_capacity_unit |string |Y |WATTHOUR |Unit for total_battery_capacity, such as WATTHOUR. |
   ^^^is_need_un_38_3_test |bool |Y |false |UN38.3 testing ensures that batteries meet specific safety criteria. Please send the report in the field if it's not included in the MSDS. |
   ^^^un_38_3_test_file_url |string |N |https://example.com/fbt/un38-3-test-report.pdf |UN38.3 testing file URL |
   ^^^battery_count_per_package |string |N |3 |per package battery count |
   ^^flammable_liquids_extra_info |object |N | |Flammable-liquid details for goods with hazmat_type set to FLAMMABLE_LIQUID. flammable_liquids_volume must be a numeric string greater than 0. |
   ^^^flammable_liquids_type |string |Y |PAINT |Flammable-liquid type.
   Possible values:
* PAINT
* PERFUMERY
* ALCOHOLIC
* OTHER |
   ^^^flammable_liquids_volume |string |Y |1 |Volume of flammable liquid in the unit specified by volume_unit. |
   ^^^volume_unit |string |N |MILLILITERS |Unit for flammable_liquids_volume, such as MILLILITERS. |
   ^^dg_class |string |Y |CLASS_2 |Hazmat class
   Possible values:
   -CLASS_2
   -CLASS_3
   -CLASS_9 |
   ^^dg_uncode |string |Y |UN3480 |UN identifier for the hazardous substance. Standard UN values use the `UN` prefix followed by four digits; `OTHER` is also supported.
   Possible values:
* UN2807
* UN3480
* UN3090
* UN3481
* UN3091
* UN1263
* UN1266
* UN3065
* OTHER |
   ^^msds_file_url |string |Y |https://example.com/fbt/msds-report.pdf |Material safety data sheet of the hazmat goods to support review the goods' safety compliance in FBT |
   ^^aerosol_extra_info |object |N | |Aerosol info |
   ^^^volume |string |N |1 |Aerosol volume. Required when `hazmat_type` is `AEROSOLS`. The value must be a numeric string greater than 0. |
   ^^^volume_unit |string |N |MILLILITERS |aeroslo volume unit |
   ^is_lot_code |bool |Y |false |Whether lot-code management is enabled for the goods. |
   ^is_expiration_management |bool |Y |false |Whether shelf-life management is enabled for the goods. When true, shelf_life_attribute_info is required. |
   ^shelf_life_attribute_info |object |N | |Shelf-life attributes for the goods. The cutoff values must be nonnegative and satisfy sales_cutoff_days < expiration_alert_days < inbound_cutoff_days. If provided, shelf_life must be less than 3650 days. |
   ^^shelf_life |int |N |90 |The goods shelf life (days) |
   ^^inbound_cutoff_days |int |Y |100 |The goods inbound cutoff days before expiration, represent the time period before the product's expiration when the warehouse will no longer accept inbound shipments. |
   ^^expiration_alert_days |int |Y |90 |The goods alert days before expired, represent the period of time before platform send expiration reminder alerts to the merchant. |
   ^^sales_cutoff_days |int |Y |80 |The goods sales cut off days before expired, represent the period of time before expiration in which the goods will no longer be available for sale. |
   ^^handling_method_expired_goods |string |N |DISPOSE |How expired inventory is handled.
   Possible values:
* `STORE_UNITS`: Move the units to defective inventory.
* `RETURN_TO_SELLER`: Return the units to the seller.
* `DISPOSE`: Dispose of the units. |
   ^is_sioc |bool |N |false |A flag indicating whether the goods is under sioc |
   ^sioc_attribute |object |N | |sioc info |
   ^^sioc_files |[]object |N | |Sioc files |
   ^^^sioc_certification_url |string |N |https://example.com/fbt/sioc-certification.jpg |sico attachment url |
   ^^^sioc_file_type |string |N |PHOTO |sioc attachment type:
* PHOTO
* DOCUMENT
* DROP_TEST_VIDEO |
   ^bulky_item_attribute |object |N | |bulky item info |
   ^^is_bulky_item_accessories |bool |N |false |whether the goods is bulky accessories |
   ^goods_safety_attributes |object |N | |safety attribute info |
   ^^is_fragile |bool |N |false |where fragile |
   ^^is_liquid |bool |N |false |Whether the goods are liquid. |
   ^^is_sharp |bool |N |false |where sharp |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/fbt/202607/goods/create_goods?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"create_goods_dto_list":[{"tts_sku_id":"723456789012345678","create_goods_type":"CREATE_AND_BIND","goods_name":"Wireless Charging Cable","goods_image_url":"https://example.com/fbt/goods-image.jpg","reference_code":"ABDK999d","barcode_infos":[{"barcode_type":"UPC","barcode_value":"12345678905"}],"return_handling_method":"RESTOCK_SELLABLE_DISPOSE_UNSELLABLE","dimension_and_weight_base_info":{"weight_value":"500","length_value":"2","width_value":"2","height_value":"3","weight_unit":"GRAM","dimension_unit":"CENTIMETER"},"is_hazmat":false,"hazmat_info":{"hazmat_type":"BATTERY","battery_extra_info":{"battery_type":"LITHIUM_ION","battery_packaging_type":"STANDALONE","total_battery_weight":"10","total_battery_weight_unit":"GRAM","total_battery_capacity":"2","total_battery_capacity_unit":"WATTHOUR","is_need_un_38_3_test":false,"un_38_3_test_file_url":"https://example.com/fbt/un38-3-test-report.pdf","battery_count_per_package":"3"},"flammable_liquids_extra_info":{"flammable_liquids_type":"PAINT","flammable_liquids_volume":"1","volume_unit":"MILLILITERS"},"dg_class":"CLASS_2","dg_uncode":"UN3480","msds_file_url":"https://example.com/fbt/msds-report.pdf","aerosol_extra_info":{"volume":"1","volume_unit":"MILLILITERS"}},"is_lot_code":false,"is_expiration_management":false,"shelf_life_attribute_info":{"shelf_life":90,"inbound_cutoff_days":100,"expiration_alert_days":90,"sales_cutoff_days":80,"handling_method_expired_goods":"DISPOSE"},"is_sioc":false,"sioc_attribute":{"sioc_files":[{"sioc_certification_url":"https://example.com/fbt/sioc-certification.jpg","sioc_file_type":"PHOTO"}]},"bulky_item_attribute":{"is_bulky_item_accessories":false},"goods_safety_attributes":{"is_fragile":false,"is_liquid":false,"is_sharp":false}}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^create_result_info | object |  | Goods creation result information. |
| ^^create_result_list | []object |  | List of goods creation results. |
| ^^^tts_sku_id | string | 723456789012345678 | Identifier for the SKU generated by TikTok Shop system. |
| ^^^is_success | bool | false | Whether the goods creation succeeded. |
| ^^^tts_goods_id | string | 9988776655 | Identifier of the FBT goods record. Returned when is_success is true. |
| ^^^fail_reason | string | Goods creation failed. | Reason the goods record was not created. Returned when is_success is false. |
### Response Sample
```json
{"code":0,"data":{"create_result_info":{"create_result_list":[{"tts_sku_id":"723456789012345678","is_success":false,"tts_goods_id":"9988776655","fail_reason":"Goods creation failed."}]}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |

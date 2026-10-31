# Developer Guide — Solution Guidance

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.



---

## Solution Guidance > Product API Solution Guide

Doc: https://partner.tiktokshop.com/docv2/page/solution-guidance-product-api · cập nhật 2026-10-23

**Integration principle: APIs are the source of truth; webhooks are change triggers.** Product create, edit, price, inventory, special listing, and catalog maintenance operations should write through the current Product Open API contract, then verify platform state through Get Product or the relevant search API. Webhooks should wake up reconciliation, not replace read-after-write or scheduled polling.inv

### Purpose and Audience
This guide is for sellers, ISVs, PIM systems, connector apps, and self-developed merchant systems that want to integrate directly with TikTok Shop product APIs instead of relying on the 1P connector path for product listing and daily catalog maintenance.
**This is a reference integration guide, not a product requirements document.** It translates the current product-domain integration pattern into a seller-facing architecture: what to prepare before listing, which product operations to call, how to handle review and listing state, and how to consume product webhooks safely.
Primary references used while drafting: [TikTok Shop Products API overview](https://partner.tiktokshop.com/docv2/page/products-api-overview), [TikTok Shop developer guide](https://partner.tiktokshop.com/docv2/page/tts-developer-guide), [Create Product API](https://partner.tiktokshop.com/docv2/page/create-product-202309), [Edit Product API](https://partner.tiktokshop.com/docv2/page/edit-product-202509), [Update Price API](https://partner.tiktokshop.com/docv2/page/update-price-202309), [Update Inventory API](https://partner.tiktokshop.com/docv2/page/update-inventory-202309), [Partial Edit Product API](https://partner.tiktokshop.com/docv2/page/partial-edit-product-202309), [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/get-authorized-category-assets-202405), [Product status change webhook](https://partner.tiktokshop.com/docv2/page/5-product-status-change), [Inventory status change webhook](https://partner.tiktokshop.com/docv2/page/27-inventory-status-change), [Product audit status change webhook](https://partner.tiktokshop.com/docv2/page/37-product-audit-status-change), [Combined listing change webhook](https://partner.tiktokshop.com/docv2/page/42-combined-listing-change), and [Combined Listings - Merge into Variants Function Guide](https://seller-us.tiktok.com/university/essay?knowledge_id=1016792318773006&role=1&course_type=1&from=search), [[External] TikTok Shop Catalog Integration Solutions V2023.Q2.01](https://bytedance.sg.larkoffice.com/docx/GYCFd9SVXomiNhxfaQMcYLIznkf)
### Terminology
| Term | Meaning in this guide |
| --- | --- |
| **Seller system** | The seller's PIM, ERP, OMS, commerce platform, or middleware that owns the source catalog and calls TikTok Shop APIs. |
| **TikTok product** | The listing entity created in TikTok Shop. It has product-level content, SKU-level commercial data, platform status, and review state. |
| **SKU** | The sellable variant under a product. Price, inventory, seller SKU, and SKU status are maintained at SKU level. |
| **Full edit** | A product update that resubmits the product object. Omitted fields can be treated as removed except documented exceptions such as price and inventory. |
| **Partial edit** | A targeted product update for selected properties. Use it when the seller system intentionally changes only part of a listing. |
| **Interlink / Combined listing** | A TikTok Shop product relationship that groups multiple related product IDs so shoppers can switch between them from the PDP. This is different from virtual bundle. |
| **GWP / Non-sellable** | Gift with purchase. Products marked as `non_sellable: true` in the Create Product API. These are treated as gift items and cannot be purchased individually. |
| **Idempotency** | The property where a create request can be retried without creating duplicate products. In this guide, `external_product_id` is treated as the Create Product idempotency key. |
### Integration Architecture
The seller's catalog, OMS, and WMS should call TikTok Shop through one integration layer that validates product payloads, signs API requests, stores mappings, and handles webhook-triggered reconciliation.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/e47ffdd9b7384a36bc6816af30d1b98c~tplv-k9wyc2ijk0-image.image)
**Recommended state model.** Store external product IDs, TikTok product IDs, SKU IDs, seller SKUs, category IDs, TikTok attribute IDs, seller attribute mapping, warehouse IDs, inventory quantities by warehouse, price by SKU, listing status, audit status, review reason, webhook event timestamp, last successful API request ID, and last TikTok update time.
### Prerequisites Before Listing
Product listing fails most often because the seller system starts with a product payload before the shop, category, brand, warehouse, shipping, and compliance data are ready. Run these checks once at onboarding and again when the seller changes market, category, brand, warehouse, or shipping template.
| Area | Seller action | Why it matters | Testing guidlelines |
| --- | --- | --- | --- |
| Developer app readiness | Follow the [TikTok Shop developer guide](https://partner.tiktokshop.com/docv2/page/tts-developer-guide) to prepare the app, authorization, request signing, token refresh, and webhook callback configuration. | Product API calls should not start until the seller app can sign requests, refresh tokens safely, and receive webhook callbacks for the authorized shop. |  |
| Shop authorization | Confirm the shop is authorized and active; store shop cipher / shop ID per tenant. | Product write APIs require a valid seller authorization context and active shop. |  |
| Listing prerequisites | Call `GET /product/202309/prerequisites` before building bulk create or edit payloads. | Use the response to identify missing setup such as category eligibility, shop readiness, brand, warehouse, logistics, or other product listing requirements before the seller submits Create Product. |  |
| KYC and eligibility | Confirm the seller has completed market onboarding and can list in the target region. | The Edit Product API documentation calls out active sellers / shops with completed KYC as an applicability condition. |  |
| Category mapping | Map the external taxonomy to TikTok category IDs and fetch category rules / attributes before creating payloads. | Required attributes, certifications, package dimensions, and variation rules are category-specific. |  |
| Brand and compliance | Resolve brand authorization and required certifications before listing regulated or restricted categories. | Missing brand or compliance data typically moves the product into rejection or review loops. | For testing purposes, when the seller is in their development phase, we can use "No brand". This doesn't need any brand authorization |
| Warehouse and shipping | Map each external warehouse to a TikTok warehouse ID and confirm shipping settings. | Create and inventory operations need warehouse-level stock data and valid shipping configuration. |  |
| Media readiness | Upload images and files so product media meets platform rules before submission. | Image or file issues can block listing and are hard to fix after a bulk upload has entered review. |  |
### Product Lifecycle Flow
The direct integration should model product sync as a small set of stable states. Create and content/SKU updates can enter review; price and inventory updates usually maintain the live listing operationally. Keep the last live version separate from the submitted version until TikTok confirms approval or rejection.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/937037440e324d1c97420c2cf4db71d7~tplv-k9wyc2ijk0-image.image)
#### Product status reference
Use product status to decide what the seller system can do next. The lifecycle diagram uses simplified states; the seller UI and integration logs should keep the TikTok product status, audit status, rejection reason, and the last submitted version separately.
| Status group | What it means for sellers | Integration handling |
| --- | --- | --- |
| **Draft** | The product is saved but not visible to shoppers. | Allow the seller to complete missing product data, media, category rules, logistics inputs, or compliance fields before activation or submission. |
| **Pending / Under review** | The create or edit request is being reviewed by TikTok Shop. | Keep the previous live version and SKU mapping active. Use product status and audit webhooks to know when the submitted version is approved or rejected. |
| **Failed / Rejected** | The submitted listing version did not pass review. | Show the rejection reason to the seller, keep the last live version unchanged, and let the seller fix the payload before resubmitting through Create Product, Edit Product, or Partial Edit Product. |
| **Live** | The product is visible and can be sold if SKU, price, inventory, and shop conditions allow it. | Allow normal price and inventory maintenance through the dedicated APIs. Use Get Product when the seller system needs the authoritative live product snapshot. |
| **Deactivated** | The listing is not actively selling because it was deactivated by the seller or listing controls. | Use the documented Activate Product or Deactivate Products API flow when the seller intentionally changes selling availability. |
| **Suspended / Frozen** | The listing is blocked by platform-side policy, risk, or compliance handling. | Do not treat this as a normal seller deactivation. Store the status reason, surface the required seller action, and refresh with Get Product or the relevant status webhook after the issue is resolved. |
| **Deleted** | The product has been removed. | Stop price and inventory pushes for that `product_id`. After deletion is confirmed, the seller can reuse the same `external_product_id` for a new Create Product request if needed. |

Product status and audit status are related but not identical. Product status tells whether the listing is draft, live, inactive, suspended, or deleted; audit status tells whether a submitted create or edit version is still being reviewed, approved, or rejected.
#### Operation routing flow

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/c451f893c7f24b979a8ce739aae24ff7~tplv-k9wyc2ijk0-image.image)

**Routing summary.** The flow separates product-domain changes by what the seller is trying to change, because each operation has a different API contract, review behavior, and reconciliation need.

* **Create-path changes:** Use Create Product for new listings and create-only listing attributes such as GWP/non-sellable, scheduled listing, auction, pre-sale, and supported virtual bundle fields. After submission, store `product_id`, `sku_id`, submitted version, and request ID, then track approval through product status and audit webhooks.
* **Content and SKU-model changes:** Use Partial Edit for a small documented field subset, and use full Edit when the seller changes the full listing payload or SKU model. If SKUs are added, removed, or remapped during review, keep the previous live product/SKU mapping active until TikTok confirms the approved state.
* **Commercial operation changes:** Route price-only and inventory-only changes to their dedicated APIs instead of Edit Product. Store the latest price and inventory values sent for each SKU and warehouse. Use webhooks and periodic search/get APIs to confirm TikTok Shop reflects the seller system’s expected state.
* **Relationship and special-listing changes:** Use the specific API path or Create/Edit Product field listed in the relevant feature section. For example, route GWP through `non_sellable`, auction through `product_tag_operations.product_tag = AUCTION`, scheduled listing through `scheduled_sale`, SNS through `subscribe_info` / `subscribe_info_edit`, and supported virtual bundle creation through `primary_combined_product_id` and `combined_skus`.
* **Read-after-write rule:** Webhooks should trigger follow-up handling, but they are not the final source of truth. Call Get Product when the seller system needs the authoritative listing status, audit result, rejection reason, or final SKU mapping.

#### Create and update products
A typical Create Product integration should complete authorization, listing prerequisites, category metadata, media, logistics inputs, product creation, and approval tracking in that order. This keeps the Create Product payload focused on submission instead of using Create Product to discover missing setup.
##### Typical create product sequence

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/b17484ebce884c8f9fa62c6387265e96~tplv-k9wyc2ijk0-image.image)

Create Product and Product Edit share the same integration discipline: build a complete product model, validate category and market requirements, store TikTok IDs, and handle review state before treating the submitted version as live.
| Operation | API / field to use | Seller-facing guidance |
| --- | --- | --- |
| Create product | `POST /product/202309/products` ([Create Product API](https://partner.tiktokshop.com/docv2/page/create-product-202309)) | Use when no TikTok product exists yet. Send the full product object and store returned `product_id` and `sku_id` values. |
| Full edit | `PUT /product/202309/products/{product_id}` ([Edit Product API](https://partner.tiktokshop.com/docv2/page/edit-product-202509#Back%20To%20Top)) | Use when changing the product object or SKU model. Fetch latest product first, merge intended changes, submit, then wait for audit / status outcome before replacing live mappings.  The Edit Product response can return `audit_status`. Treat `AUDITING` as pending review, `APPROVED` as accepted, and `NONE` as not applicable to review because the product may be draft, frozen, deactivated, or otherwise not submitted for listing. |
| Partial edit | `PATCH /product/202309/products/{product_id}/partial_edit` ([Partial Edit Product API](https://partner.tiktokshop.com/docv2/page/partial-edit-product-202309)) | Use for targeted product-content edits. Do not use it for price-only or inventory-only changes. |
| Get product | `GET /product/202309/products/{product_id}` ([Get Product API](https://partner.tiktokshop.com/docv2/page/get-product)) | Use when the integration needs authoritative state after webhook notification, audit completion, error recovery, or scheduled reconciliation. |
```JSON
{
  "save_mode": "LISTING",
  "title": "Example cotton T-shirt",
  "description": "HTML product description",
  "category_id": "123456",
  "brand_id": "987654",
  "non_sellable": false,
  "scheduled_sale": {"start_time": 1790000000},
  "pre_sale": {"type": "PRE_ORDER"},
  "product_tag_operations": [{"operation": "ADD", "tag": "AUCTION"}],
  "main_images": [{"uri": "tos-image-uri"}],
  "skus": [{
    "seller_sku": "TSHIRT-BLACK-M",
    "price": {"amount": "19.99", "currency": "USD"},
    "inventory": [{"warehouse_id": "7000714532876273410", "quantity": 100}]
  }]
}
```

##### Category Recommendation
Resolve the TikTok category before building the create or edit payload. The seller can browse a category tree, ask the platform for a recommended category, then fetch attributes and rules for the selected category.
| Step | API / field to use | How sellers should use it |
| --- | --- | --- |
| Browse/select category | `GET /product/202309/categories` ([Get Categories API](https://partner.tiktokshop.com/docv2/page/get-categories-202309)) | Use when the seller UI lets merchants choose a TikTok category from the available category tree. |
| Recommend category | `POST /product/202309/categories/recommend` ([Recommend Category API](https://partner.tiktokshop.com/docv2/page/recommend-category-202309)) | Use when the seller does not know the best category to auto recommend category; send title, description, and product signals, then ask the seller to confirm the selected category. |
| Confirm rules | `GET /product/202309/categories/{category_id}/rules` ([Get Category Rules API](https://partner.tiktokshop.com/docv2/page/get-category-rules-202309)) | Use to validate category constraints, certifications, package dimensions, size chart, and other listing requirements. This provides the required attributes/conditions that needs to be met for success product listing. |

##### Warehouse Mapping
Store a warehouse mapping before product creation and product updates. The seller's warehouse code should map to the TikTok `warehouse_id` used in the create / edit payload and later inventory maintenance.

* Reject listing rows that have stock but no mapped TikTok warehouse.

##### Attribute Mapping
Use `GET /product/202309/categories/{category_id}/attributes` ([Get Attributes API](https://partner.tiktokshop.com/docv2/page/6509c5784a0bb702c0561cc8)) to build the product template for the selected category. These attributes contain the required fields that should be populated for the listing to be submitted successfully.
**Store TikTok Attribute ID, not only display name.** Attribute names and value labels can change by market, language, or category version. Persisting the TikTok attribute ID lets the seller system rebuild edit payloads and reconcile product state without guessing from translated labels.

##### Media, size chart, and logistics assets
Upload or resolve every asset ID before calling Create Product or Edit Product. The create/edit payload should reference TikTok Shop asset identifiers returned by product media APIs, not seller-local file paths or external image URLs.
| Asset / setup need | API / reference to use | How sellers should use it |
| --- | --- | --- |
| Product images | `POST /product/202309/images/upload` ([Upload Product Image API](https://partner.tiktokshop.com/docv2/page/upload-product-image-202309)) | Upload main product images, detail images, and other listing images before create/edit. Store the returned image URI and reference it in product image fields. |
| Product files | `POST /product/202309/files/upload` ([Upload Product File API](https://partner.tiktokshop.com/docv2/page/upload-product-file-202309)) | Upload product files required by the selected category or market, such as certificates, compliance files, labels, or other file assets accepted by the Product API. Store the returned file identifier for create/edit payloads. |
| Existing size chart | [Search Size Charts API](https://partner.tiktokshop.com/docv2/page/search-size-charts-202407) | Use when category rules require a size chart and the seller may already have one. Store the selected size chart ID and reference it in the listing payload where required. |
| New or updated size chart | [Create Size Chart API](https://partner.tiktokshop.com/docv2/page/create-size-chart-202608) and [Edit Size Charts API](https://partner.tiktokshop.com/docv2/page/edit-size-charts-202608) | Create or update a seller size chart before listing submission, then attach the resulting size chart ID to products in categories that require size guidance. |
| Image optimization | [Optimized Images API](https://partner.tiktokshop.com/docv2/page/optimized-images-202404) | Use when the seller wants platform-generated image improvements. Only reference optimized images in create/edit payloads after seller review and approval. |
| Image translation | [Create Image Translation Tasks API](https://partner.tiktokshop.com/docv2/page/create-image-translation-tasks-202505) and [Get Image Translation Tasks API](https://partner.tiktokshop.com/docv2/page/get-image-translation-tasks-202506) | Use for image text translation workflows when selling across markets. Poll the task result, let the seller review translated assets, then use the approved image URI in create/edit. |
| Logistics and shipping inputs | `GET /product/202309/prerequisites` and category rules | Resolve required package dimensions, logistics settings, shipping option IDs, and market-specific listing inputs before submission. These are setup identifiers, not media uploads. |

##### Best Practice
| Topic | What to store | Best practice |
| --- | --- | --- |
| Product mapping | product_id, product status | After the creation/updation, store the products product id and sku id details along with the product status information. Use this information to support future edits for the product |
| SKU mapping | `product_id`, `sku_id`, seller SKU, live status, submitted version, pending removal flag | Keep mappings for both the current live SKU set and the submitted SKU set while an edit is under review. If live SKUs are A, B, C and the seller submits B, C, D, keep SKU A mapped as pending removal until TikTok confirms the new version is live. Orders can still be placed against SKU A during review. |
| Idempotency key | `external_product_id` along with the shop details or any information which would help avoid duplicate product creation | The same key cannot create another product while the previous product is non-deleted. After that product is deleted, the seller can create a new product with the same key. Use this idempotency key to avoid duplicate product creation.  |
| Category mapping | External category to Tiktok category mapping | Provide a tool to the sellers to allow them to map the external category to TikTok category. This will help with listing products and help avoid sellers to reselect the TikTok category and facilitate auto mapping category.  |
| Attribute mapping | External attribute to Tiktok attribute mapping | Provide a tool to allow the sellers to map the product properties from external system to TikTok attributes and values. This will help with listing products and sellers wouldn't have to manually re-add all the attribute information. Attribute Ids change based on category.  |
| Approval tracking | `product_id`, `sku_id`, submitted version, request ID, audit status, product status | After Create Product, wait for Product status change and product audit events before showing the listing as live. Use webhook events as triggers and call Get Product when the seller system needs the final approved state, rejection reason, or SKU mapping confirmation. |
| Review handling | Submitted product version, live product version, audit status, rejection reason | Do not replace live mapping, SKU availability, or seller-facing sellable state until product status / audit webhook or Get Product confirms the submitted version is live. You can also store multiple versions of the sku mapping one for live and one for reviewing. The mapping will be helpful to fulfill orders. |

##### Advanced Feature
| Feature | API / field to use | Seller-facing guidance |
| --- | --- | --- |
| Scheduled publishing | `scheduled_sale` in `POST /product/202309/products` | Store the intended schedule in the seller system and verify final live status through Product status webhook and Get Product. |
| Pre-create optimization | [Diagnose and Optimize Product API](https://partner.tiktokshop.com/docv2/page/diagnose-and-optimize-product-202411#Back%20To%20Top) | Use before the product has a TikTok `product_id`. Show suggestions to the seller and submit only seller-approved content. |
| Post-create title / description optimization | [Get Recommended Product Title and Description API](https://partner.tiktokshop.com/docv2/page/get-recommended-product-title-and-description-202405#Back%20To%20Top) | Use only after product creation; this API requires `product_id`. Apply approved changes through Edit Product or Partial Edit Product. |
| Image optimization | [Optimized Images API](https://partner.tiktokshop.com/docv2/page/optimized-images-202404) | Use where supported to improve product images, then reference seller-approved image URIs in Create Product, Edit Product, or Partial Edit Product. |
#### Update price
Use `POST /product/202309/products/{product_id}/prices/update` ([Update Price API](https://partner.tiktokshop.com/docv2/page/update-price-202309)) for SKU-level price maintenance. Keep price-only changes out of full product edit flows unless the product payload is intentionally being rebuilt.
```JSON
{
  "skus": [{
    "id": "1729382476852921560",
    "price": {"amount": "19.99", "currency": "USD"}
  }]
}
```

**Price update handling:** For each SKU, send the final price that should appear on TikTok Shop. Store the intended price, seller-side price update time, request ID, and TikTok response status for each `product_id` + `sku_id`. Use this record to safely retry the same price update, ignore older retries after a newer price change, and reconcile TikTok Shop’s current price against the seller system’s latest intended price.
#### Update inventory
Use `POST /product/202309/products/{product_id}/inventory/update` ([Update Inventory API](https://partner.tiktokshop.com/docv2/page/update-inventory-202309)) for warehouse-level SKU stock. Use `POST /product/202309/inventory/search` ([Inventory Search API](https://partner.tiktokshop.com/docv2/page/inventory-search-202309)) for scheduled reconciliation and backfill.
```JSON
{
  "skus": [{
    "id": "1729382476852921560",
    "inventory": [{"warehouse_id": "7000714532876273410", "quantity": 80}]
  }]
}
```

##### Inventory best practice

* Send final available quantity by SKU and warehouse; do not send source deltas unless the API reference for the target market explicitly supports delta behavior.
* For normal volume, sellers can push each source inventory change directly to Update Inventory.
* For high order volume, high stock-change frequency, or oversell risk, sellers can optionally use aggregation / controlled cadence before calling Update Inventory. The aggregation layer should collapse rapid source changes into the latest safe quantity
* When adding a new warehouse to an existing SKU, include all warehouses that should remain attached to that SKU. If updating quantity for existing warehouse, directly just pass only that warehouse and quantity.
* Run scheduled reconciliation with Inventory Search so missed webhooks, failed pushes, or manual Seller Center edits do not leave stock stale.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/2c9f2a30402b47f8b7c75cd82c4141a0~tplv-k9wyc2ijk0-image.image)

#### Webhook Strategy
Register product-domain webhooks on the seller's app and route every event to the same reconciliation queue. The webhook payload should identify what changed; the seller system should pull product state before making downstream decisions.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/eda4611ca8e044ffac7bea70457f5bfc~tplv-k9wyc2ijk0-image.image)

| Webhook | Primary payload fields | How sellers should use it |
| --- | --- | --- |
| Product status change | `product_id`, `status`, `suspended_reason`, `update_time` | Update seller product status, show whether a product is live / inactive / deleted / suspended, and trigger Get Product when authoritative state is needed. |
| Product audit status change | `product_id`, audit status, reason fields, `update_time` | Notify sellers when a submitted create / edit passes or fails review. On approval, finalize submitted mapping changes. On rejection, keep the previous live mapping and expose fix guidance. |
| Product information change | `product_id`, `changed_fields`, `change_source` | Detect edits made directly in Seller Center or another app. Pull the product and decide whether the seller source catalog or TikTok state wins for each field. |
| SKU status change | `product_id`, SKU list with `sku_id` and `status` | Update variant availability and prevent future price / inventory updates from targeting deactivated SKUs without seller review. |
| Inventory status change | Inventory status, available quantity signals, product / SKU references | Alert sellers for LOW_STOCK or OUT_OF_STOCK and optionally trigger inventory reconciliation before sending a corrective update. |
| Combined listing change | `combined_listing_id`, products, status, `change_type` | Keep grouped listing display state in sync when the combined listing is created, updated, deactivated, or deleted. |

### Special Listing Scenarios
Special listing features should be feature-gated by market, category, and seller eligibility before the seller can submit the payload. If a feature is not available through the Product API for that seller scenario, describe the supported seller workflow instead of sending unsupported fields.
| Scenario | API / field to use | Seller-facing guidance | Suggested Flow |
| --- | --- | --- | --- |
| Sku Level Virtual bundle | `POST /product/202309/products` with `primary_combined_product_id` and SKU-level `combined_skus` | Create the bundle only after component products and SKUs are live and mapped. Store bundle PID, bundle SKU, component `product_id` / `sku_id`, and component quantity. Use edit only when the target API version documents update support for the same fields. This is only establishing sku level bundle.     For **product level bundle** there is no API currently, the seller has to modify this in the seller center directly. https://seller-us.tiktok.com/university/essay?knowledge_id=894944353240878&role=1&course_type=1&from=search |   ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/55ad19e1fdc94f12852ce0ccee0277b0~tplv-k9wyc2ijk0-image.image)     |
| Combined listing / interlink | `POST /product/202506/combined_listing_recommendations/search` ([Products API overview](https://partner.tiktokshop.com/docv2/page/products-api-overview))   | Use this API only to retrieve recommended groups of products that could be merged into a combined listing, based on shared option attributes such as color, style, flavor, or similar variant dimensions. The request takes product IDs, for example `{"product_ids":["123423536575","123423536576"]}`, and the response returns recommendation groups such as `option_name`, product `id`, `option_value`, `next_page_token`, and `total_count`. This API does not create the combined listing, submit the Seller Center merge, or perform child SKU mapping. For the actual Merge into variants flow, sellers should use Seller Center under Manage Products → Combined Listings → Merge products. After the relationship exists, store the main product, child products, generated variant mapping, child SKU to combined-listing SKU mapping, and combined listing status because changing selected products or deleting a variant dimension can reset generated SKU mappings. |  |
| Gift with purchase (GWP) | `non_sellable: true` in `POST /product/202309/products` | Treat GWP type as create-time immutable. To convert between GWP and sellable, delete the listing first, wait until deletion is confirmed, then recreate. The same idempotency key can be reused only after the prior product is deleted. |  |
| Auction listing | `product_tag_operations.product_tag = AUCTION` in Create Product | Validate market and category eligibility before showing auction to the seller. Confirm Edit Product support separately before allowing post-create auction tag maintenance. |  |
| Pre-sale | `pre_sale` when supported by category and market | Validate category rules before submission and keep seller UI copy clear that pre-sale is different from scheduled listing. |  |
| SNS | `POST /product/202502/products/search` with `sns_filter`; `GET /product/202309/products/{product_id}` returns `subscribe_info`; `PUT /product/202309/products/{product_id}` or `POST /product/202309/products/{product_id}/partial_edit` with `subscribe_info_edit` | Assuming SNS means Subscribe and Save, sellers can discover SNS products with `sns_filter`: use `CONFIGURED` for products already configured for SNS and `ELIGIBLE` for products eligible for SNS. Use Get Product to read `subscribe_info`, including `support_subscribe`, `subscribe_status`, discount details, and available discount constraints. Enable, disable, or update SNS through Edit Product or Partial Edit Product by sending `subscribe_info_edit.subscribe_status` as `ENABLED` or `NOT_ENABLED` with `discount_details`. Actual configuration still depends on seller and product eligibility shown by `support_subscribe`. |  |
### Seller Whitelist and Listing Eligibility Controls
[Product Listing Whitelist and Eligibility Guide for Sellers](https://bytedance.us.larkoffice.com/docx/FMjjdgUTroFxuixUFShu9H9Wsdd)
### Market Requirements
Product payloads are not identical across markets. The seller system should resolve category rules, compliance fields, warehouse configuration, and listing features for the target shop before create or edit.
| Market / surface | Required seller preparation | Implementation guidance |
| --- | --- | --- |
| EU GPSR | Prepare manufacturer and responsible person records, then pass `manufacturer_ids` and `responsible_person_ids` for applicable categories. | Block listing submission until the seller has selected the required records. Do not silently omit these fields because the product may fail compliance validation or review. |
| Category-specific compliance | Fetch category rules for certifications, safety labels, package dimensions, product attributes, and invite-only categories. | Keep a per-market category rule cache and refresh it before bulk listing. Rules can differ for the same external category in US, UK, EU, SEA, and LATAM. |
| Warehouse and inventory | Map seller warehouses to TikTok warehouse IDs and validate warehouse-level inventory fields. | Inventory updates should target SKU + warehouse. Reject listing rows that have stock but no mapped TikTok warehouse. |
| Listing features | Check whether auction, pre-sale, scheduled sale, temporary listing, SNS, GWP, and virtual bundle are enabled for the seller's market and category. | Feature-gate unsupported fields in the seller UI so unsupported features do not create review failures or silent no-ops. |
### Global Products and Market Expansion
Use this flow when one seller wants to offer the same product through more than one UK or EU shop. Each shop is a separate market: it has its own Shop ID, product ID, SKU IDs, listing rules, price, inventory, and compliance requirements.
#### Use Local Replication
For new integrations, create the product in one local shop and use Replicate Product to copy it to each target market. TikTok Shop keeps the relationship between the products, while every target shop receives its own product ID and SKU IDs.
| Method | What it does | When to use it |
| --- | --- | --- |
| Local Replication | Copies a product from one local shop to another supported market and keeps the products related. | Use for all new Direct API integrations. |
| Seller Center Global Listings | Creates and manages related market listings through Seller Center rules. | Your integration may read the relationship, but it should not recreate or overwrite it without checking the current product data. |
| Legacy Global Product APIs | The older cross-market product method that used global product records. | Use only to migrate existing legacy products. Do not use it for new products. |
#### Public APIs for Market Expansion
The Product API reference is the source of truth for request fields, permissions, supported markets, and current limits.
| API or event | What it does | When to use it |
| --- | --- | --- |
| [Get Global Listing Rules](https://partner.tiktokshop.com/docv2/page/get-global-listing-rules-202507) | Returns the global listing methods and inventory rules available to the shop. | Call before showing or starting a Sell Across EU flow. Continue only when Local Replication is supported. |
| [Create Product](https://partner.tiktokshop.com/docv2/page/create-product-202309) | Creates the product in the selected source shop. | Use when the product does not yet exist in the source shop. |
| [Replicate Product](https://partner.tiktokshop.com/docv2/page/replicate-product-202507) | Starts an asynchronous copy from the source shop to a supported target market. | Use after the source product is ready and the target market requirements have been checked. |
| Global Replication Status Change event | Notifies your application when a replication request finishes or needs attention. | Use the event instead of repeatedly sending Replicate Product or treating submission as final success. |
| [Get Product](https://partner.tiktokshop.com/docv2/page/get-product-202309) | Returns the latest product data and replication information for one local product. | Use after an event, during reconciliation, and before retrying an update. |
| [Partial Edit Product](https://partner.tiktokshop.com/docv2/page/partial-edit-product-202309) | Adds or corrects selected fields on a local product. | Use when replication creates a target-shop draft that needs market-specific information. |
| [Get Global Replicated Products](https://partner.tiktokshop.com/docv2/page/get-global-replicated-products-202507) | Returns the local products related through replication. | Use for onboarding existing products, mapping repair, and regular reconciliation. |
| [Search Products](https://partner.tiktokshop.com/docv2/page/search-products-202502) | Finds products already present in a shop. | Use before creating or replicating when the seller may already have a matching product. |

See the [Products API Overview](https://partner.tiktokshop.com/docv2/page/products-api-overview) and the Product section of the [TikTok Shop API reference](https://partner.tiktokshop.com/docv2/page/get-authorized-category-assets-202405) for the complete public API list.
#### Implementation Flow
This flow shows the recommended seller journey. Replication is asynchronous: accepting a request is the start of processing, not confirmation that the target listing is ready.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/34008b80ce4943c3ae1fdff7ca4a1c06~tplv-k9wyc2ijk0-image.image)

*If Local Replication is not supported, keep the product as a local listing for that market. If replication creates a draft or fails, update the existing target product and confirm its latest state before retrying.*
#### Direct API Flow

1. **Authorize every shop.** Obtain access for the source shop and each target shop. Confirm that the application has the required Product API scopes.
2. **Check shop readiness.** Get the seller's authorized shops and call Get Listing Prerequisites for each shop that will create or receive a product.
3. **Check the listing method.** Call Get Global Listing Rules. Continue only when the response allows Local Replication for the intended market and inventory model.
4. **Prepare each target market.** Fetch the target shop's categories, attributes, category rules, and authorized category assets. Requirements can differ by country even when the physical product is the same.
5. **Create the source product.** Use Create Product in the selected local shop. Save its local product ID and SKU IDs.
6. **Start replication.** Call Replicate Product for each supported target market. A successful API response means that TikTok Shop accepted the request; it does not mean that the target listing is ready to sell.
7. **Wait for the result.** Subscribe to the Global Replication Status Change event. When an event arrives, call Get Product to read the latest target-shop state.
8. **Complete drafts or fix failures.** Replication can create a draft when the target market needs extra data. Use Get Product to find the missing fields, then use Partial Edit Product or the relevant price and inventory APIs before resubmission.
9. **Save the market mapping.** Store the Shopify product and variant IDs together with the Shop ID, country, local product ID, and local SKU IDs for every market.

#### Implementation Best Practices
These practices describe a safe integration approach without requiring sellers to copy TikTok Shop's internal design.
##### Product Identity and Mapping

* Use the seller's own stable product and variant identifiers as the starting point for mapping.
* Store a separate record for every shop. Include the Shop ID, country, local product ID, and local SKU IDs.
* Never assume that the same product has the same product or SKU ID in two markets.
* Before creating or replicating, search the target shop and check the saved mapping to avoid duplicates.

##### Asynchronous Processing and Safe Retries

* Treat Replicate Product as an asynchronous request. Show the seller that processing has started, then wait for the Global Replication Status Change event.
* Use each event as a signal to call Get Product. The latest product response should decide the next action.
* Allow only one active replication request for the same source product and target shop.
* Before retrying, check whether TikTok Shop already created a live product or draft. Update an existing draft instead of creating another product.
* Use delayed retries for temporary errors. Do not repeatedly call the API in a short period.

##### Market-Specific Data

* Validate categories, attributes, qualifications, certifications, Manufacturer, Responsible Person, price, warehouse, and inventory for each target shop.
* Keep product content, price, and inventory updates as separate operations. This makes failures easier to explain and retry.
* Use shared inventory only when Get Global Listing Rules confirms that the market and warehouse support it.
* When a target listing needs local information, collect only the missing fields and update that market's product.

##### Monitoring and Seller Experience

* Run regular reconciliation with Search Products, Get Product, and Get Global Replicated Products. Webhooks can be delayed or missed.
* Keep an audit trail of the source product, target shop, request time, latest result, and seller action required.
* Show errors in seller-friendly language, for example: “Certification required for France” instead of displaying only an API error code.
* Roll out one or two target markets first. Confirm mappings, webhooks, compliance handling, price, and inventory before enabling more markets.

**Recommended seller statuses:** Processing, Needs action, and Ready. Keep detailed API states in the integration logs, while the seller sees the next action in plain English.

#### Existing Products
Do not assume that a product is unrelated just because your application did not create it. Seller Center or another integration may already have created the market relationship.

* Use Search Products to find products already present in each shop.
* Use Get Product and check `is_replicated` to see whether a local product came from replication.
* Read `global_product_association` to match related SKUs across shops.
* Use Get Global Replicated Products to find the full set of related local products.
* If Get Product returns `global_listing_policy`, preserve the Seller Center Global Listing relationship and follow its policy.

#### Market Data and Inventory
Replication reuses product information where possible, but it does not remove local listing requirements. Validate the following for every target shop:

* Category and required product attributes
* Brand or category authorization
* Certifications and supporting files
* Manufacturer and Responsible Person information where required
* Target-market price, tax settings, warehouse, and inventory

Use shared inventory only when Get Global Listing Rules allows it for the selected market and warehouse. Otherwise, maintain inventory separately for each shop.
#### Retries and Duplicate Prevention

* Before creating or replicating, search the target shop and check your saved mapping.
* After sending Replicate Product, save the request context and wait for the status event.
* Before retrying, call Get Product or Get Global Replicated Products to confirm whether a target product or draft already exists.
* If a draft exists, update that draft. Do not create another copy.
* If two live products already exist in one shop, ask the seller which listing to keep before changing mappings or deleting a listing.

#### Legacy Product Migration
The Local Replication whitelist was removed on June 30, 2026. New integrations should use Local Replication without a whitelist dependency.
Legacy Global Product APIs are scheduled for retirement on October 30, 2026. For products that still use the legacy method, follow the [migration announcement](https://partner.tiktokshop.com/docv2/page/6z874qqu), start migration with [Create GPA Upgrade Task](https://partner.tiktokshop.com/docv2/page/create-gpa-upgrade-task-202604), and subscribe to the [Global Listing Method Change](https://partner.tiktokshop.com/docv2/page/g2wnrb57) event. This migration flow is for existing legacy products only.
#### Seller and Partner Checklist

* Use only public TikTok Shop Open APIs documented in Partner Center.
* Use Local Replication for new cross-market products.
* Store product and SKU IDs separately for every shop.
* Wait for the replication event and confirm the latest product state before retrying.
* Complete target-market compliance, price, warehouse, and inventory data.
* Do not depend on `global_product_id` or any internal service.

### API Operation Index
| Operation | Public API or reference | When to use it |
| --- | --- | --- |
| Get listing prerequisites | `GET /product/202309/prerequisites` | Check whether a shop is ready to create or receive a listing. |
| Get categories | [Get Categories](https://partner.tiktokshop.com/docv2/page/get-categories-202309) | Show the seller the categories available in the selected shop. |
| Recommend category | [Recommend Category](https://partner.tiktokshop.com/docv2/page/recommend-category-202309) | Suggest a category when the seller does not know which one to choose. |
| Get attributes | [Get Attributes](https://partner.tiktokshop.com/docv2/page/6509c5784a0bb702c0561cc8) | Find the required and optional attributes for the selected category. |
| Get category rules | [Get Category Rules](https://partner.tiktokshop.com/docv2/page/get-category-rules-202309) | Check certifications, package dimensions, size charts, and other category rules. |
| Get authorized category assets | [Get Authorized Category Assets](https://partner.tiktokshop.com/docv2/page/get-authorized-category-assets-202405) | Check which seller or category qualifications can be used for the listing. |
| Upload product image | [Upload Product Image](https://partner.tiktokshop.com/docv2/page/upload-product-image-202309) | Upload images before using the returned reference in a create or edit request. |
| Upload product file | [Upload Product File](https://partner.tiktokshop.com/docv2/page/upload-product-file-202309) | Upload size charts, labels, certificates, and other product files. |
| Pre-create optimization | [Diagnose and Optimize Product](https://partner.tiktokshop.com/docv2/page/diagnose-and-optimize-product-202411#Back%20To%20Top) | Check a product payload before the product has a TikTok Shop product ID. |
| Post-create optimization | [Get Recommended Product Title and Description](https://partner.tiktokshop.com/docv2/page/get-recommended-product-title-and-description-202405#Back%20To%20Top) | Improve the title or description after product creation. |
| Get global listing rules | [Get Global Listing Rules](https://partner.tiktokshop.com/docv2/page/get-global-listing-rules-202507) | Check whether Local Replication and a shared-inventory method are supported for the shop. |
| Create product | [Create Product](https://partner.tiktokshop.com/docv2/page/create-product-202309) | Create the product in a selected local shop after its required data is ready. |
| Replicate product across markets | [Replicate Product](https://partner.tiktokshop.com/docv2/page/replicate-product-202507) | Start an asynchronous copy to another supported market. Each target shop receives its own product and SKU IDs. |
| Track replication result | Global Replication Status Change event | Wait for the event, then call Get Product. Do not treat request acceptance as final listing success. |
| Get product | [Get Product](https://partner.tiktokshop.com/docv2/page/get-product-202309) | Read the latest product state after an event, during reconciliation, and before retrying. |
| Full edit | [Edit Product](https://partner.tiktokshop.com/docv2/page/edit-product-202509) | Fetch the latest product first, then send the full intended state. |
| Partial edit | [Partial Edit Product](https://partner.tiktokshop.com/docv2/page/partial-edit-product-202309) | Add or correct selected product fields, including fields missing from a replicated draft. |
| Update price | [Update Price](https://partner.tiktokshop.com/docv2/page/update-price-202309) | Maintain prices for the local SKUs in one shop. |
| Update inventory | [Update Inventory](https://partner.tiktokshop.com/docv2/page/update-inventory-202309) | Maintain stock by local SKU and warehouse. |
| Search inventory | [Inventory Search](https://partner.tiktokshop.com/docv2/page/inventory-search-202309) | Reconcile stock, check low-stock products, or backfill inventory during onboarding. |
| Search products | [Search Products](https://partner.tiktokshop.com/docv2/page/search-products-202502) | Find existing products before create or replicate, and reconcile products already in the shop. |
| Get related market products | [Get Global Replicated Products](https://partner.tiktokshop.com/docv2/page/get-global-replicated-products-202507) | Find local products related through replication and repair cross-market mappings. |
| Migrate legacy global products | [Create GPA Upgrade Task](https://partner.tiktokshop.com/docv2/page/create-gpa-upgrade-task-202604) | Use only for products that still use the legacy Global Product API method. |
| Subscribe to product events | [Update Shop Webhook](https://partner.tiktokshop.com/docv2/page/update-shop-webhook) | Subscribe to supported product, SKU, audit, inventory, and replication events. |


---

## Solution Guidance > Orders and Fulfillment API Solution Guide

Doc: https://partner.tiktokshop.com/docv2/page/solution-guidance-orders-fulfillment-api · cập nhật 2026-10-27

This document is a guide for integrating TikTok Shop orders and fulfillment as an external logistics partner, including a 3PL warehouse operator, 4PL orchestrator, or ISV building on their behalf.
It covers one domain: receiving and fulfilling orders. This includes order sync, the order lifecycle, label purchase and shipment reporting across both shipping models, multi-shipment orders, and platform-driven re-shapes of the package set.
Start here, find the document that matches your question, and go deeper there. This page contains no technical details of its own.
### The Documents
| **Document** | **Audience** | **What it covers** |
| --- | --- | --- |
| [Order Sync guide](https://bytedance.us.larkoffice.com/docx/GTgMdfok5oXd4fxLqQNucRAgs7d) | Engineering   | How orders reach you: Mode A (webhook plus poll) and Mode B (poll only), the order record and status lifecycle with the ON_HOLD window, the reconciliation sweep, and the step that stores each order and marks it ready for fulfillment. Read it first. |
| [Fulfillment guide](https://bytedance.us.larkoffice.com/docx/FYBrdmGO4oUr0ux2tjAu8BY4s3c) | Engineering   | What you do with a ready order: both fulfillment lanes end to end, Lane A TikTok Shipping (4PL) and Lane B Seller Shipping (3PL), shipment planning, platform re-shapes of the package set, package consolidation, the package state reference, and the fulfillment error codes. |
| [Market Variants (companion guide)](https://bytedance.us.larkoffice.com/docx/RLORdDtEyom8HLxDCXEu5aLMszg) | Engineering | What changes outside the default flow: SEA and LATAM handover and shipment reporting, pre-shipping consolidation, the Brazil invoice upload, and UK notes. Each section names the guide step it replaces. |
| [Stakeholder overview](https://bytedance.us.larkoffice.com/docx/Z5f8dYDBcoqdzvxPTLHuVMKnsUc) | Solution architects, business, commercial | The non-technical view: it provides details of the two fulfillment models in plain words, the API onboarding inventory grouped by capability, phased effort framing, and the handful of business rules that affect operations. No payloads, no dense diagrams. |
### Which Guide Do I Start With?
The two guides split one integration by direction. The Order Sync guide moves information from TikTok Shop to you: it receives orders in one of two modes, stores them, and marks them ready. The Fulfillment guide moves information from you to TikTok Shop: it ships ready orders through one of two lanes. Both describe the default flow for the US, UK, EMEA and JP; the Market Variants guide covers the other markets.
Start with the **Order Sync guide**. If you can host a public HTTPS endpoint, build Mode A: webhooks are the primary trigger, and Steps 1.5 to 1.8 add the reconciliation sweep that every webhook integration needs as a safety net.
If inbound HTTPS is impractical - for example, because of network policy, the lack of a public endpoint, or batch-oriented middleware - build Mode B of the same guide instead: a pull-only engine with its own operational disciplines. Then continue with the **Fulfillment guide**, which is the same for both modes.
Work completed for one mode carries over to the other.
### Reader Paths
| **If you need to...** | **Go to** |
| --- | --- |
| Decide between Mode A (webhook plus poll) and Mode B (poll only) | Order Sync guide: "Sync Strategy: Select Your Mode" |
| Understand 3PL vs 4PL and which lane an order is in | Fulfillment guide: "Fulfillment Models: 3PL vs 4PL" |
| See the order lifecycle, the ON_HOLD window, and the order data worth storing | Order Sync guide: "Order Data and the Status Lifecycle" |
| Implement the fulfillment flow end to end | Fulfillment guide: Parts 1 and 2 |
| Build the polling engine (sweeps, cursors, acknowledgments) | Order Sync guide: Part 2 (Mode B) |
| Detect and absorb platform re-shapes of the package set | Fulfillment guide: Part 3 |
| Combine orders into one package, or pre-split with Split Orders | Fulfillment guide: "Adjacent Capabilities" |
| Ship in SEA, LATAM or Brazil, or check UK differences | [Market Variants guide](https://bytedance.us.larkoffice.com/docx/RLORdDtEyom8HLxDCXEu5aLMszg) |
| Look up an endpoint, method, or path | Either guide: "Appendix A - Endpoint Index" (order endpoints in Order Sync, fulfillment and logistics endpoints in Fulfillment) |
| Implement webhook receipt, signature verification, and retry handling | Order Sync guide: "Appendix B - Webhook Delivery Contract and Topics" |
| Look up poll caps, filters, and window semantics | Order Sync guide: "Appendix C - Polling Reference Card" |
| Handle rate limits and error codes | Either guide: "Rate Limits and Errors" |
| Plan validation before go-live | Either guide: "Suggested Validation Before Go-Live" |
| Scope the integration for a non-technical audience | [Stakeholder overview](https://bytedance.us.larkoffice.com/docx/Z5f8dYDBcoqdzvxPTLHuVMKnsUc) |
| Set up a sandbox shop and a test seller account before go-live | TikTok Partner Center: [Test your App](https://partner.tiktokshop.com/docv2/page/64f1998564ed2e0295f3d87d), [Create a test seller account](https://partner.tiktokshop.com/docv2/page/686da7797cac2a04985d83a1) |
### Scope and Adjacent Domains
This hub covers the **orders and fulfillment** domain only.
Two adjacent domains are managed elsewhere:

* **Partner onboarding** — Partner Center app creation, seller authorization, token lifecycle, and request signing are owned by the onboarding domain.
* **Reverse flows** — Cancellations, returns, and refunds are owned by the reverse domain. Where these guides touch on those flows, they point to the companion **RMA/returns design**.

As additional domains come online, this hub can expand with a dedicated section for each domain.


---

## Solution Guidance > TikTok Return Models & Exchanges API Solution Guide

Doc: https://partner.tiktokshop.com/docv2/page/solution-guidance-return-exchange-api · cập nhật 2026-10-23

### **Aftersales Transactions Overview**
Returns/refunds, cancellations, & exchanges are post-sales (after-sales) actions that can be initiated by either buyers or sellers. TikTok Shop provides API scopes for sellers to programatically handle these cases:

* **Cancel API**: Supports buyer-initiated cancellation requests and seller-initiated order cancellations.
* **Return API**: Supports buyer-initiated refund or return-and-refund requests.

**Cancel Order**
Orders can be canceled at the buyer’s request or directly by the seller. Each canceled order includes the cancel reason, status, creation time, and seller processing time. In the US and UK, sellers can also partially cancel orders when items are out of stock.
**Return Order**
Return orders occur when a buyer requests a return or refund only for one or more items after delivery. Each return order includes the return/refund reason, status, request time, seller processing time, and refund amount.

**This document will focus on Return transactions**, nuanced return label models, and give guidance on developing end-to-end solutions using the TikTok Shop open APIs based on the different return models.
--
For a more **generalized** overview of all TikTok Shop Aftersales workflows, please see our documentation below:

* [Return, refund, and cancel API overview](https://partner.tiktokshop.com/docv2/page/return-refund-and-cancel-api-overview)
* [Return reasons](https://partner.tiktokshop.com/docv2/page/return-reasons)
* [Refund reasons](https://partner.tiktokshop.com/docv2/page/refund-reasons)
* [Cancel reasons](https://partner.tiktokshop.com/docv2/page/cancel-reasons)

### **Aftersales Stages**
Before diving into the detailed API sequence, it's important to understand the **stages** of an aftersales/return record in TikTok Shop. TikTok Shops measures the seller's actions in these different return stages, to ensure the buyer communications/experience meets our SLAs/policies. **Note**: These measured **stages** are *different* from the granular return **status** that are exposed in the API/webhooks
| **Stage** | **What Happens** | **Seller Action** | **SLA / Deadline** | **Outcome / Notes** |
| --- | --- | --- | --- | --- |
| **1st Review Stage:**   Return Request | Buyer submits a return request. TikTok now auto-approves **95%** of requests based on product category. Once approved, TikTok generates the official **RMA_ID** for the seller/ISV to capture the return and related line items.  | For ~5% of requests that still require review, the seller must **approve or reject** the **request** via API or Seller Center.   | **24 hours** from request submission | If no decision is made within 24 hours, TikTok will **auto-approve** the request and generate the return shipping label. Some requests may require review due to restricted categories or suspicious buyer return activity. |
| **2nd Review Stage:**   Return Decision | After the returned package is received and inspected, the seller reviews the refund decision. | Seller must **approve or reject the return,** based on their item inspection SOP or automated rules. | **4 business days** after return package's tracking shows `DELIVERED`  | If no decision is made within 4 business days , TikTok will **auto-approve** the return, and the buyer will be refunded the money associated with their original payment. |

For all return transactions, TikTok Shop API/webhooks expose the necessary return status updates, and delivery signals that enable sellers to indentify what action they need to perform next within the return lifecycle.

### **Return Actions by Status**
During the lifecycle of a return, there are specific actions buyers or sellers are allowed to perform, based on the forward `order_id` status, as well as what the `return_id` status.

The following table illustrates when a "Return" can be **initiated** based on the current order status.
|  | **Initiator** | **`UNPAID` ** | **`ON_HOLD`** | **`AWAITING_SHIPMENT`** | **`AWAITING_COLLECTION`** | **`IN_TRANSIT`** | **`DELIVERED`** | **`Completed`** |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **Return**  **Initiation** | Buyer | No | No | No | No | **Yes** | **Yes** | No |
|  | Seller | No   | No | No | No   | No   | Depends on market policy. US allows for seller to create an offline return record, but it must be automatically approved for the refund amount to the buyer, | No |

The following table illustrates what actions a seller or buyer may perform on a return, based on the current return status. 
| **Return Status** | **Request Type / ID** | **Description** | **Seller Action** | **Buyer Action** |
| --- | --- | --- | --- | --- |
| `RETURN_OR_REFUND_REQUEST_PENDING`   | Aftersales   | Buyer initiates a return request which creates an Aftersales Request ID. Although TikTok auto-approves 95% of these requests, there are some records that are pending seller review. | Approve or reject the request |  |
| `AWAITING_BUYER_RETURN`   | RMA  | The Aftersales return request has been approved and the official RMA `id` is created. Awaiting for the buyer to ship the item. | -   | Ship the items back to seller |
| `RETURN_IN_TRANSIT` | RMA | The buyer has shipped the item and carrier tracking confirms the return is on-route. | Seller can approve the refund of the return if needed, even before it arrives at their facility.  | - |
| `PENDING_PACKAGE_REVIEW` | RMA | The return package is confirmed `DELIVERED` by the carrier. | Inspect/grade items and make a decision to either approve or reject the refund of the return line items. | - |
| `PACKAGE_REVIEW_COMPLETED` | RMA | The return package has finished inspection and final decisions for refunds.  | Arbitration with buyer and TT CS if the results are not agreed upon. | Arbitration with buyer and TT CS if the results are not agreed upon. |

### **Return Label Models**
TikTok has **2 return label models** - and the API integration path will be defined by which model is right for the sellers' specific operations/system architecture. Once the seller selects which return label model is required for their systems, they can build a holistic returns management integration with TikTok's open APIs for either of these return models.
| **Return Model** | **Description** |
| --- | --- |
| ###  **4PL Model:**  **TikTok Return Labels**   | TikTok is responsible for generating the return shipping label, using our own TikTok carrier accounts.    ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/d10e9007db6147e1b81876a7a9db4d82~tplv-k9wyc2ijk0-image.image)   |
| ###  **3PL Model:**  **External Return Labels**   | The seller/or external return platforms are responsible for generating a return shipping label, **AND** also responsible for **uploading** that shipping label to TikTok through our open API.     ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/10ffa64b8edf488ea2f1ab1fa6c784c0~tplv-k9wyc2ijk0-image.image)      ***Note****: The TikTok Shop definition for 3PL labels means this is a 3rd party logistics* ***label,*** *not necessarily coming from a 3rd party logistics fulfillment provider. 3PL labels can come from a seller's own UPS/USPS/Fedex accounts, or these labels could be generated by a return platform such as:* ***Loop Returns****,* ***Happy Returns*** *etc.*    *This ability to generate and upload a 3rd party return shipping label is* ***commonly referred to as V2 Returns*** *within the TikTok ecosystem.*    |

### **4PL Model: TikTok Return Labels**
The standard returns behavior for TikTok Shop is use TikTok's return shipping labels for the buyers. At a high-level, sellers can use our open APIs to build an end-to-end integration for returns management that will allow them:

1. Capture the new return/RMA details
2. Submit the return/RMA details to their return warehouse's systems (WMS/DB)
3. Buyers use the TikTok shipping label to send the return package to the seller's return warehouse location
4. Warehouse operations identify the return package, inspect and grade the items
5. Based on the warehouse grading, send TikTok the decision to either APPROVE or REJECT the return refund to the buyer.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/4af84bdf9ebf4bbaa50a6e0a1251b28f~tplv-k9wyc2ijk0-image.image)

> ### **4PL Model API documentation** 

Returns API and webhook documentation below: 

* [Aftersales Request Status Update Webhook](https://partner.tiktokshop.com/docv2/page/h4cxaxub)
* [Search Aftersales Request API](https://partner.tiktokshop.com/docv2/page/search-aftersales-request-202603)
* [RMA Status Update Webhook](https://partner.tiktokshop.com/docv2/page/2f0jrrxc)
* [Search Return Merchandise Authorization (RMA) API](https://partner.tiktokshop.com/docv2/page/search-return-merchandise-authorization-202604https://partner.tiktokshop.com/docv2/page/search-return-merchandise-authorization-202604)
* [Review Aftersales API](https://partner.tiktokshop.com/docv2/page/review-aftersales-202603)
* [Refund Success Webhook](https://partner.tiktokshop.com/docv2/page/8y10pibm)

> ### **4PL Solution Architecture & Implementation** 

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/3bb8248cfccb4af9a5baebfce08b79ed~tplv-k9wyc2ijk0-image.image)

| # **Aftersales**  # **Stage** | # **Step** | # **System** | # **Requirement Details** |
| --- | --- | --- | --- |
| ### Buyer initiates a return and starts the (1st Review Stage) |  |  |  |
| **1st Review**                   | **[1]** Buyer Submits Return Request   | **TikTok**    | Buyer has selected the return method in TT app and submits a return request. |
|  | **[2]** Webhook: `AFTERSALES_REQUEST_STATUS_UPDATE`  Webhook topic: **64**   | **TikTok**   | TikTok triggers the webhook topic: **Aftersales Request Status Update**  "aftersales_request_status" : `PENDING_REQUEST_REVIEW`  [Webhook topic 64 documentation](https://partner.tiktokshop.com/docv2/page/h4cxaxub)   |
|  | **[3]** Search Aftersales Request API | **Seller/ISV**   | Use the aftersales_request_id provided in the webhook as a search parameter when calling the "Search Aftersales Reques API". The response will expose all return_line_item_id (s) associated with this unified aftersales request  [Search Aftersales Request API documentation](https://partner.tiktokshop.com/docv2/page/search-aftersales-request-202603)   |
|  | **[4]** Sync Aftersales Request to Seller OMS   | **Seller/ISV** | Aftersales request details synced to sellers OMS/UI/Workbench etc for review  |
|  | **[5]** Decision to approve or reject the **request**   | **Seller/ISV** | Seller to decide if they want to **approve** or **reject** the **request** to return. This is considered the 1st review decisioning step.   > **Note**: For the majority of sellers, this 1st review step is **automatically** approved, based on their product category of the items in the return request. And for any auto-approved aftersale request, the seller does not need to perform any approval of the request, but they still must perform a refund decision within our policy SLA of 48H once return package shows delivered scan at the warehouse.  |
|  | **[6]** Review Aftersales API | **Seller/ISV** | Use this API to make a decision on whether to **approve** or **reject** the return request. Specify **request_id_type**: **`AFTERSALES`**  [Review Aftersales API documentation](https://partner.tiktokshop.com/docv2/page/review-aftersales-202606)   |
|  | **[7]** Webhook: `AFTERSALES_REQUEST_STATUS_UPDATE` | **TikTok** | **Webhook: AFTERSALES_REQUEST_STATUS_UPDATE**  status: `REQUEST_REVIEW_COMPLETED`  [Webhook topic 64 documentation](https://partner.tiktokshop.com/docv2/page/h4cxaxub) |
| ### Once the 1st review process is completed, the official RMA workflow will begin (2nd Review Stage) |  |  |  |
| **2nd Review**   | **[8]** TikTok RMA Created  | **TikTok**   | Once the aftersales request has been approved, TikTok will immediately create an RMA, which is a unified return identifyer that encompasses all unique sku lines and quantity associated with the return submission from the buyer |
|  | **[9]** Webhook: `RMA_STATUS_UPDATE`  Webhook topic: **65** | **TikTok**   | **Webhook: RMA_STATUS_UPDATE**  **status**: **`RMA_CREATED`**  This webhook will trigger as soon as the official TikTok RMA has been created in TikTok's system  [Webhook topic 65 documentation](https://partner.tiktokshop.com/docv2/page/2f0jrrxc) |
|  | **[10]** Search RMA Requests API | **Seller/ISV** | Call this API to obtain the full details of the return, including all nested return order and line level item details.   [Search Return Merchandise Authorization API documentation](https://partner.tiktokshop.com/docv2/page/search-return-merchandise-authorization-202604)   |
|  | **[11]** Sync Return RMA  | **Seller/ISV** | Feed the return RMA details in OMS & WMS layers to ensure the RMA is recorded in the database for operations to identify once received. |
|  | **[12A] & [12B]** Buyer Ships/Drop-off items | **TTS Buyer** | Buyer takes items to nearest carrier drop-off or ships items to warehouse |
|  | **[13]** Warehouse operations receives RMA package | **Warehouse OPS** | Warehouse operations to receive and identify the RMA package with the RMA record in the WMS for processing.  |
|  | **[14]** Warehouse operations inspection | **Warehouse OPS** | Warehouse operations to perform grading/inspection SOPs for RMA's return line_items |
| ### 2nd review inspection results have 4 possible paths (A,B,C,D) |  |  |  |
| ### **PATH A:** All expected items received and accepted for full refund |  |  |  |
| **PATH A**   | **[15.A]** WMS updates OMS | **WMS**   | Warehouse associates inspect items and update the RMA status that all line_items associated with the RMA are in "good' condition   |
| **PATH A**   | **[16.A]** OMS updates TikTok Application | **OMS**   | Based on warehouse items grading results that all items are in good condition, OMS updates the Return app that all items are eligible for full refund amount.   |
| **PATH A** | **[17.A]** Review Aftersales API   | **ISV** | Triggers the refund of all return_line_item_id(s) in the RMA.  request_id_type: `RMA`  action: `APPROVE_RETURN_PACKAGE`  [Review Aftersales API documentation](https://partner.tiktokshop.com/docv2/page/review-aftersales-202606)   |
| **PATH A** | **[18.A]** Refund Buyer  | **TikTok** | Buyer's refund payment is completed |
| ### **PATH B:** Some items don't meet warehouse grading acceptance criteria (some items missing/damaged). |  |  |  |
| **PATH B**   | **[15.B]** WMS RMA status = Some items graded as "damaged/missing"   | **WMS** | Warehouse associates inspect items and update the RMA status **some** line_items associated with the RMA are in "good' condition, some are "damaged/missing" |
| **PATH B**   | **[16.B]** Instruct TTS app with mixed refund decision (all lines) | **OMS** | Based on warehouse items grading results that some line_items are in "good' condition, some are "damaged/missing", update Return platform RMA with partial refunds based on line items. |
| **PATH B** | **[17.B]** Review Aftersales API     | **Seller/ISV**   | Triggers the refund of approved line_items and rejection of the line_items that are missing/damaged. When using the "Review Aftersales API", you can define different decision/action enumerations for the different return_line_item_id(s). Example:  return_line_item_id: 111 = Good condition.  action: `APPROVE_RETURN_PACKAGE`  -  return_line_item_id: 222 = damaged/missing  Action: `REJECT_RETURN_PACKAGE`     > **Note**: TTS does **not** allow the same exact sku_id to have **different** decisions (known platform limitation). The seller must make the same action/decision for multiple quantities of the same sku_id. We are solving this platform issue by end of Q3, 2026, to allow truly flexible return_line_item_id decisions regardless of the sku_id profiles.      [Review Aftersales API documentation](https://partner.tiktokshop.com/docv2/page/review-aftersales-202606)   |
| **PATH B** | **[18.B]** Mixed Refund by SKU lines   | **TikTok** | Buyer's partial refund payment is completed based on different sku_id decisions.  |
| ### **PATH C:** All items don't meet warehouse grading acceptance criteria (missing/damaged).  |  |  |  |
| **PATH C** | **[15.C]** OMS RMA status = All items graded as "damaged/missing" | **WMS** | Warehouse associates inspect items and update the RMA status ALL line_items associated with the RMA are "damaged/missing" |
| **PATH C** | **[16.C]** Instruct TTS app to REJECT RMA (all lines)   | **OMS** | Based on warehouse items grading results that ALL line_items are in "damaged/missing' condition, update return platform RMA to reject refund of all line items |
| **PATH C** | **[17.C]** Review Aftersales API | **Seller/ISV** | Triggers the rejection of the refund of all line_items within the RMA  request_id_type: `RMA`  action: `REJECT_RETURN_PACKAGE`  [Review Aftersales API documentation](https://partner.tiktokshop.com/docv2/page/review-aftersales-202606)   |
| **PATH C** | **[18.C]** Return Refund Rejected (all lines) | **TikTok** | Refund is rejected for all return items and notification is sent to buyer |
| ### **PATH D:** Some quantity of same sku_id do not meet warehouse grading acceptance criteria (missing/damaged). Offer partial refund |  |  |  |
| **PATH D** | **[15.D]** OMS RMA status = Same sku / multiple quantity has different conditions.   | **WMS** | RMA contains multiple quantities of the exact same sku (SKU:A x 2 QTY) Warehouse associated inspects the package/items and finds that:   QTY 1 is in good condition   QTY 2 is completely damaged/or missing altogether.  |
| **PATH D** | **[16.D] Instruct TTS app** `OFFER_PARTIAL_REFUND`   | **OMS** | Based on warehouse items grading results, 1 QTY should be refunded, 1 QTY should be rejected due to the damage. However, as previously stated, TikTok shop platform has a known gap where we do not allow different refund decisions if there are multiple quantities of the same sku_id. To solve for this platform behavior, OMS must perform calculations to trigger a partial refund amount for each qty/line, which is meant to equate to the total amount the buyer should receive. Example:   Buyer orders SKU:A x 2 QTY. Each item original cost paid = $10.00  QTY 1 is received in "good/sellable" condition  QTY 2 is damaged or missing.  -  The seller wants to **approve** QTY 1 and **reject** QTY 2, so that the buyer is only refunded **$10.00** out of the original $20.00 amount paid for both lines. However, the TTS platform/API does not allow different decisions for the same SKU (known platform behavior/limitation).     The seller can use the Review Aftersales API and use the `OFFER_PARTIAL_REFUND` enumeration for both lines. However, OMS logic **must** calculate the amount using the formula   (Total amount to refund buyer) / (total # of return_line_item_ids)  Example from above:  $10.00 (total amount to refund buyer) / (2 return_lines) = $5.00  The `OFFER_PARTIAL_REFUND` amount will be `5.00` for **both** lines of the same SKU, to ensure the buyer will receive $10.00 for their refund amount.   |
|  **PATH D** | **[17.D]** Review Aftersales API  request_id_type: `RMA`  action: `OFFER_PARTIAL_REFUND` | **Seller/ISV** | Triggers `OFFER_PARTIAL_REFUND` action for all line_items of that same SKU  request_id_type: `RMA`  action: `OFFER_PARTIAL_REFUND`  -  Within the alternative_solutions_details object:  Define `partial_refund_amount` & `currency`    [Review Aftersales API documentation](https://partner.tiktokshop.com/docv2/page/review-aftersales-202606)   |
| **PATH D** | **[18.D]** Buyer is refunded the accurate partial amount | **TikTok** | Partial refund amount and notification is sent to buyer |
| **PATH D** |  |  | **Buyer Appeasement Use-Case**  The `OFFER_PARTIAL_REFUND` can also be used as an appeasment mechanism. For example  **IF**: the buyer was only expected to send back SKU A, QTY 1, but the item was slightly damaged, noticeably worn, package slightly damaged etc  **THEN**: the seller can make a decision to `OFFER_PARTIAL_REFUND` for that single return_line_item_id, and TikTok will refund that buyer the amount specified by the seller.  |

### **3PL Model: External Return Labels**
***Also known as: V2 Returns***
The **most common** use-case for the 3PL label model is when sellers want to leverage their existing DTC return platforms with TikTok return activity. Oftentimes, sellers' DTC process will leverage **return platforms** that are responsible for **generating a shipping label** for the buyers, and **orchestrating the data flows** and for operational functions between the return platform and their own DTC/OMS/WMS layers. 

By leveraging these **existing** return platform workflows for TikTok Shop returns, sellers can **alleviate engineering efforts and costs**. And maintain a **consistent** end-to-end process between their DTC and TikTok Shop returns. Also, some sellers have customized attributes/barcodes rendered on the return shipping label through these return platforms. These label attributes are part of their warehouse SOPs for scanning and identifying return packages once received at their warehouse facilities. 

##### Return platforms that have partnered with TikTok to build the 3PL label/QR code model:

* Loop Returns
* Happy Returns
* Amazon MCF
* Redo Returns
* Narvar (scoping in progress)

At a high-level, these existing return platform integrations follow this model outlined below

1. Capture the new return/RMA details
2. Generate a 3rd party return shipping label (3PL, off TikTok's platform)
3. Upload that the 3rd party return back to TikTok to render/email to the buyer
4. Submit the return/RMA details to their return warehouse's systems (WMS/DB)
5. Buyers use the seller's 3PL label to send the return package to the seller's return warehouse location
6. Warehouse operations identify the return package, inspect and grade the items
7. Based on the warehouse grading, send return status to an OMS layer for refund decision to return platform/app.
8. Return Platform app to send TikTok the decision to either APPROVE or REJECT the return refund to the buyer.

However, sellers **do not** have to leverage these existing return platform integrations. They are also able to **develop their own 3PL label model**. **** This essentially allows the seller to perform the exact steps the return platforms are managing outlined above, but the seller **use their own label** and upload directly between their systems and TikTok's API. 

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/6f1e289079bf429b9306a3087f211caf~tplv-k9wyc2ijk0-image.image)

> ### **3PL Model Prerequisites Checklist**

There are multiple prerequisite configurations required for each sellers' shops. Sellers must have the following checklist completed **before** they are able to test the label generation & label upload flow back to the TikTok app buyer view. 
| **Checklist Tasks** | **Owner** | **Comments** |  |
| --- | --- | --- | --- |
| Define which **`seller_id`**(s) needs 3PL label functionality | Seller/TTS | Share sandbox and production **`seller_id`**(s) with TikTok solutions POC for backend configuration | - [ ]  |
| Define which **`app_key`** will be managing return APIs | Seller/TTS | Share **`app_key`** with TikTok solutions POC for backend configuration | - [ ]  |
| Define which exact carrier return methods to offer buyers   | Seller/TTS   | TikTok needs to configure the **`seller_id`** to only display the seller's expected return methods in buyer UX journey. Carrier return methods vary between carriers: **`USPS`**, **`UPS`**, **`Fedex`**. And each carrier has variations in return methods for shipping labels vs dropoff QR codes.  | - [ ]  |
| Request API access for [Upload Shipping Document API](https://partner.tiktokshop.com/docv2/page/upload-shipping-document-and-tracking-info-202405) | Seller/TTS | TTS solutions POC must whitelist your **`app_key`** to access this API scope. | - [ ]  |
| Request API access for new batch returns API/Webhooks   | Seller/TTS | Background: TikTok released a new set of API/webhooks to manage returns in May 2026. The new APIs follow the industry standards in terms of RMA data structure. For more details about the legacy behaviors, and why we deployed the new version, please see this document [here](https://bytedance.us.larkoffice.com/docx/JSUAdGU59ol2uexgVeFuvi0ssrc).  | - [ ]  |
| Create a TikTok user account for testing   | Seller | Share the TikTok **`user_id`** with TikTok solutions POC to flag as "test" user, which can access test shop products to perform order creation, and return submission to validate the 3PL label upload is properly rendered in the TikTok app.   **Steps to obtain TikTok UID (insert doc)** | - [ ]  |
| Create a test product in your sandbox TikTok Shop account | Seller  | Set price to $1.00, as this will require actual credit card checkout | - [ ]  |
| Create order with test product with TikTok test user account | Seller | This order will appear in your Partner Center development shop console, where you can force the status to `DELIVERED` .  | - [ ]  |
Once these prerequisites are completed, when a return is initiated within the TikTok app against the test order, the expectation is that the seller is coordinating the webhook and API calls to then upload the shipping label to Tiktok. 

**The definition of success for this test is that the return shipping label will be rendered directly into the TikTok users view (as seen below)**

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/66ea5f2f2b7840d8a895d62bb84b20b4~tplv-k9wyc2ijk0-image.image)

> ### **3PL Model API documentation** 

Returns API and webhook documentation below: 

* [Aftersales Request Status Update Webhook](https://partner.tiktokshop.com/docv2/page/h4cxaxub)
* [Search Aftersales Request API](https://partner.tiktokshop.com/docv2/page/search-aftersales-request-202603)
* [RMA Status Update Webhook](https://partner.tiktokshop.com/docv2/page/2f0jrrxc)
* [Search Return Merchandise Authorization (RMA) API](https://partner.tiktokshop.com/docv2/page/search-return-merchandise-authorization-202604https://partner.tiktokshop.com/docv2/page/search-return-merchandise-authorization-202604)
* [Get External Order Reference API](https://partner.tiktokshop.com/docv2/page/get-external-order-references-202406) (requires TikTok enablement) **OPTIONAL USE**
* [Upload Shipping Document API](https://partner.tiktokshop.com/docv2/page/upload-shipping-document-and-tracking-info-202405) (requires TikTok enablement)
* [Review Aftersales API](https://partner.tiktokshop.com/docv2/page/review-aftersales-202603)
* [Refund Success Webhook](https://partner.tiktokshop.com/docv2/page/8y10pibm)

> ### **3PL Solution Architecture & Implementation Steps (3PL Model)**

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/5a20c6f3f49c48878615866292948fcb~tplv-k9wyc2ijk0-image.image)

| # **Aftersales**  # **Stage** | # **Step** | # **System** | # **Requirement Details** |
| --- | --- | --- | --- |
| ### Buyer initiates a return and starts the (1st Review Stage) |  |  |  |
| **1st Review**                   | **[1]** Buyer Submits Return Request   | **TikTok**    | The buyer has selected the return method in TT app and submits a return request. |
|  | **[2]** Webhook:`AFTERSALES_REQUEST_STATUS_UPDATE`  Webhook Topic ID: 64   | **TikTok**   | TikTok triggers the webhook topic: **Aftersales Request Status Update**  "aftersales_request_status" : `PENDING_REQUEST_REVIEW`  [Webhook topic 64 documentation](https://partner.tiktokshop.com/docv2/page/h4cxaxub)   |
|  | **[3]** Search Aftersales Request API | **Seller/ISV**   | Use the aftersales_request_id provided in the webhook as a search parameter when calling the "Search Aftersales Reques API". The response will expose all return_line_item_id (s) associated with this unified aftersales request  [Search Aftersales Request API documentation](https://partner.tiktokshop.com/docv2/page/search-aftersales-request-202603)   |
|  | **[4]** Sync Aftersales Request to Seller OMS   | **Seller/ISV**   | Aftersales request details synced to sellers OMS/UI/Workbench etc for review  |
|  | **[5]** Decision to approve or reject the **request**   | **Seller** | Seller to decide if they want to **approve** or **reject** the **request** to return. This is considered the 1st review decisioning step.   > **Note**: For the majority of sellers, this 1st review step is **automatically** approved, based on their product category of the items in the return request. And for any auto-approved aftersale request, the seller does not need to perform any approval of the request, but they still must perform a refund decision within our policy SLA of 48H once return package shows delivered scan at the warehouse.      |
|  | **[6]** Review Aftersales API | **Seller/ISV** | Use this API to make a decision on whether to **approve** or **reject** the return request. Specify **request_id_type**: **`AFTERSALES`**  [Review Aftersales API documentation](https://partner.tiktokshop.com/docv2/page/review-aftersales-202606) |
|  | **[7]** Webhook: `AFTERSALES_REQUEST_STATUS_UPDATE` | **TikTok** | **Webhook: AFTERSALES_REQUEST_STATUS_UPDATE**  status: `REQUEST_REVIEW_COMPLETED`  [Webhook topic 64 documentation](https://partner.tiktokshop.com/docv2/page/h4cxaxub) |
| ### Once the 1st review process is completed, the official RMA workflow will begin (2nd Review Stage) |  |  |  |
| **2nd Review**   | **[8]** TikTok RMA Created  | **TikTok**   | Once the aftersales request has been approved, TikTok will immediately create an RMA, which is a unified return identifyer that encompasses all unique sku lines and quantity associated with the return submission from the buyer |
|  | **[9]** Webhook: `RMA_STATUS_UPDATE`  Webhook topic: **65**   | **TikTok** | **Webhook: RMA_STATUS_UPDATE**  **status**: **`RMA_CREATED`**  This webhook will trigger as soon as the official TikTok RMA has been created in TikTok's system.  [Webhook topic 65 documentation](https://partner.tiktokshop.com/docv2/page/2f0jrrxc) |
|  | **[10]** Search Return Merchandise Authorization API | **Seller/ISV** | Call this API to obtain the full details of the return, including all return order and line level identifyers.   [Search Return Merchandise Authorization API documentation](https://partner.tiktokshop.com/docv2/page/search-return-merchandise-authorization-202604)   |
|  | **[11]** Get External Order References API | **Seller/ISV** | Obtain Seller's OMS order_id to reference with the TikTok order_id  [Get External Order References API documentation](https://partner.tiktokshop.com/docv2/page/get-external-order-references-202406) |
|  | **[12.1]** Create Return API / Workflow | **Seller/ISV** | Create Return API endpoint will vary based on what return platform is being leveraged for the RMA records/label/QR code generation. |
|  | **[12.2]** Return Label / QR Code Generated | **Return Platform** | RMA QR code supplied in response body |
|  | **[13]** Upload Shipping Document API | **Seller/ISV** | Uploads the label/QR code document to TikTok Shop  [Upload Shipping Document API documentation](https://partner.tiktokshop.com/docv2/page/upload-shipping-document-and-tracking-info-202405) |
|  | **[14]** Render QR Code + Email Buyer | **TikTok** | TikTok app will render the QR code within buyers app UX |
|  | **[15]** Sync Return Platform RMA  | **Return Platform** | Return Platform to signal Seller of new RMA (existing integration path) |
|  | **[16]** Buyer Ships/Drop-off items | **TTS Buyer** | Buyer takes items to nearest carrier drop-off or ships items to warehouse |
|  | **[17]** Buyer shipped signal | **Carrier** | Carrier signal confirming the return package/items have shipped/dropped-off |
| ### 2nd review inspection results have 4 possible paths (A,B,C,D) |  |  |  |
| ### **PATH A:** All expected items received and accepted for full refund |  |  |  |
| **PATH A**   | **[18.A]** WMS updates OMS | **WMS**   | Warehouse associates inspect items and update the RMA status that all line_items associated with the RMA are in "good' condition   |
| **PATH A**   | **[19.A]** OMS updates TikTok Application | **OMS**   | Based on warehouse items grading results that all items are in good condition, OMS updates the Return app that all items are eligible for full refund amount.   |
| **PATH A** | **[20.A]** Review Aftersales API   | **Seller/ISV** | Triggers the refund of all return_line_item_id(s) in the RMA.  request_id_type: `RMA`  action: `APPROVE_RETURN_PACKAGE`  [Review Aftersales API documentation](https://partner.tiktokshop.com/docv2/page/review-aftersales-202606) |
| **PATH A** | **[21.A]** Refund Buyer  | **TikTok** | Buyer's refund payment is completed |
| ### **PATH B:** Some items don't meet warehouse grading acceptance criteria (some items missing/damaged). |  |  |  |
| **PATH B**   | **[18.B]** WMS RMA status = Some items graded as "damaged/missing"   | **WMS** | Warehouse associates inspect items and update the RMA status **some** line_items associated with the RMA are in "good' condition, some are "damaged/missing" |
| **PATH B**   | **[19.B]** Instruct TTS app with mixed refund decision (all lines) | **OMS** | Based on warehouse items grading results that some line_items are in "good' condition, some are "damaged/missing", update Return platform RMA with partial refunds based on line items. |
| **PATH B** | **[20.B]** Review Aftersales API   | **Seller/ISV**   | Triggers the refund of approved line_items and rejection of the line_items that are missing/damaged. When using the "Review Aftersales API", you can define different decision/action enumerations for the different return_line_item_id(s). Example:  return_line_item_id: 111 = Good condition.  action: `APPROVE_RETURN_PACKAGE`  -  return_line_item_id: 222 = damaged/missing  Action: `REJECT_RETURN_PACKAGE`     > **Note**: TTS does **not** allow the same exact sku_id to have **different** decisions (known platform limitation). The seller must make the same action/decision for multiple quantities of the same sku_id. We are solving this platform issue by end of Q3, 2026, to allow truly flexible return_line_item_id decisions regardless of the sku_id profiles.      [Review Aftersales API documentation](https://partner.tiktokshop.com/docv2/page/review-aftersales-202606)   |
| **PATH B** | **[21.B]** Mixed Refund by SKU lines   | **TikTok** | Buyer's partial refund payment is completed based on different sku_id decisions.  |
| ### **PATH C:** All items don't meet warehouse grading acceptance criteria (missing/damaged).  |  |  |  |
| **PATH C** | **[18.C]** OMS RMA status = All items graded as "damaged/missing" | **WMS** | Warehouse associates inspect items and update the RMA status ALL line_items associated with the RMA are "damaged/missing" |
| **PATH C** | **[19.C]** Instruct TTS app to REJECT RMA (all lines)   | **OMS** | Based on warehouse items grading results that ALL line_items are in "damaged/missing' condition, update return platform RMA to reject refund of all line items |
| **PATH C** | **[20.C]** Review Aftersales API | **Seller/ISV** | Triggers the rejection of the refund of all line_items within the RMA  request_id_type: `RMA`  action: `REJECT_RETURN_PACKAGE`  [Review Aftersales API documentation](https://partner.tiktokshop.com/docv2/page/review-aftersales-202606)   |
| **PATH C** | **[21.C]** Return Refund Rejected (all lines) | **TikTok** | Refund is rejected for all return items and notification is sent to buyer |
| ### **PATH D:** Some quantity of same sku_id do not meet warehouse grading acceptance criteria (missing/damaged). Offer partial refund |  |  |  |
| **PATH D** | **[18.D]** OMS RMA status = Same sku / multiple quantity has different conditions.   | **WMS** | RMA contains multiple quantities of the exact same sku (SKU:A x 2 QTY) Warehouse associated inspects the package/items and finds that:   QTY 1 is in good condition   QTY 2 is completely damaged/or missing altogether.  |
| **PATH D** | **[19.D] Instruct TTS app** `OFFER_PARTIAL_REFUND`   | **OMS** | Based on warehouse items grading results, 1 QTY should be refunded, 1 QTY should be rejected due to the damage. However, as previously stated, TikTok shop platform has a known gap where we do not allow different refund decisions if there are multiple quantities of the same sku_id. To solve for this platform behavior, OMS must perform calculations to trigger a partial refund amount for each qty/line, which is meant to equate to the total amount the buyer should receive. Example:   Buyer orders SKU:A x 2 QTY. Each item original cost paid = $10.00  QTY 1 is received in "good/sellable" condition  QTY 2 is damaged or missing.  -  The seller wants to **approve** QTY 1 and **reject** QTY 2, so that the buyer is only refunded **$10.00** out of the original $20.00 amount paid for both lines. However, the TTS platform/API does not allow different decisions for the same SKU (known platform behavior/limitation).     The seller can use the Review Aftersales API and use the `OFFER_PARTIAL_REFUND` enumeration for both lines. However, OMS logic **must** calculate the amount using the formula   (Total amount to refund buyer) / (total # of return_line_item_ids)  Example from above:  $10.00 (total amount to refund buyer) / (2 return_lines) = $5.00  The `OFFER_PARTIAL_REFUND` amount will be `5.00` for **both** lines of the same SKU, to ensure the buyer will receive $10.00 for their refund amount.   |
|  **PATH D** | **[20.D]** Review Aftersales API   | **Seller/ISV** | Triggers `OFFER_PARTIAL_REFUND` action for all line_items of that same SKU  request_id_type: `RMA`  action: `OFFER_PARTIAL_REFUND`  -  Within the `alternative_solutions_details` object:  Define `partial_refund_amount` & `currency`    [Review Aftersales API documentation](https://partner.tiktokshop.com/docv2/page/review-aftersales-202606)   |
| **PATH D** | **[21.D]** Buyer is refunded the accurate partial amount | **TikTok** | Partial refund amount and notification is sent to buyer |
| **PATH D** |  |  | **Buyer Appeasement Use-Case**  The `OFFER_PARTIAL_REFUND` can also be used as an appeasment mechanism. For example  **IF**: the buyer was only expected to send back SKU A, QTY 1, but the item was slightly damaged, noticeably worn, package slightly damaged etc  **THEN**: the seller can make a decision to `OFFER_PARTIAL_REFUND` for that single return_line_item_id, and TikTok will refund that buyer the amount specified by the seller.  |

### **Exchanges**
TikTok buyers have the ability to perform an exchange, which is initiated through their return journey within the TikTok application. This allows sellers to save GMV, rather than just giving a refund for a returned item. When a buyer submits an exchange, there are API fields within the Returns & Orders API that identify an exchange is required.
| **Markets**   | * United States (US)  * United Kingdom (UK) |
| --- | --- |
| **Returns APIs** | **Parameter Update** |
| --- | --- |
| [Search Returns API](https://partner.tiktokshop.com/docv2/page/search-returns-202602)  [Search Aftersales Request API](https://partner.tiktokshop.com/docv2/page/search-aftersales-request-202603#Back%20To%20Top)  [Search Return Merchandise Authorization API](https://partner.tiktokshop.com/docv2/page/search-return-merchandise-authorization-202604#Back%20To%20Top)  [Webhook Topic: Return Status Change](https://partner.tiktokshop.com/docv2/page/12-return-status-change)   | 1. Added the following enumeration to the `return_type`field:     * `EXCHANGE`  2. Added the following enumerations to the `return_status` field:     * `EXCHANGE_REQUEST_PENDING`     * `EXCHANGE_REQUEST_REFUND_SUCCESS`     * `EXCHANGE_REQUEST_CANCEL`     * `EXCHANGE_REQUEST_COMPLETE` |
|  |  |
|  |  |
| [Get Decision Eligibility API](https://partner.tiktokshop.com/docv2/page/get-decision-eligibility-202601) | 1. Added the following enumeration to the `check_decisions` and `decision` fields:     *  `ISSUE_EXCHANGE_REFUND` |

| **Orders API Endpoints** | **Parameter Update** |
| --- | --- |
| [Get Order Details API](https://partner.tiktokshop.com/docv2/page/get-order-detail-202507)  [Get Order List API](https://partner.tiktokshop.com/docv2/page/get-order-list-202309)     | 1. `is_exchange_order` : When `true`, this is an exchange order that the seller must fulfill.  2. `exchange_source_order_id`: If the order is an exchange order, this field returns the original order's order ID, from which the exchange order was generated. Surfaced only if `is_exchange_order`= `true`      > ***Notes****: When the buyer has shipped/dropped-off the return with the logistics carrier, that signal from the carrier integration with TikTok will confirm the package is in transit, and TikTok will the automatically create the new exchange order.*  > *This new outbound order will also have a $0.00 order value, because the payment/GMV was previously captured within the original* *`order_id`**, and there are no financial transactions required, as TikTok only currently allows exchanges for items with the same exact dollar value.*    ` |
|  |  |
|  |  |

> ### **4PL Model: Exchange workflow** 

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/04cede45a9cf4e0fa802a39d4e1a6613~tplv-k9wyc2ijk0-image.image)

1. When a buyer initiates an exchange, they will select which SKU they no longer want, and then select which SKU they want to receive for the exchange. 
2. Once the exchange is submitted, TikTok Shop will create a new `rma_id` associated with the buyer's request and trigger the RMA Status Update webhook with status `rma_created`
   1. TikTok will generate a return shipping label and share that to the buyer's app and email
3. Sellers system to call Search Return Merchandise Authorization API to capture full RMA details:
   1. The `return_type` parameter = `EXCHANGE`
   2. This will allow the seller's OMS to understand the specific use-case of this return being created.
4. The buyer will ship the return (or drop-off) with the specific carrier they selected during the return check-out
5. This carrier shipped/dropped-off signal is synced to TikTok, confirming the buyer has performed their action to return the item
6. Upon receiving the carrier signal, TikTok will **automatically** create a new outbound order for SKU-B. Within the **Get Order Details API & Get Order Lists API,** there are two parameters that identify the exchange scenario:
   1. `is_exchange_order`: Boolean
   2. `exchange_source_order_id`: Original order's order ID, from which the exchange order was generated. Returned only if `is_exchange_order` = `true`.
7. The seller's warehouse is expected to fulfill the order with the exchange item once they receive the order data for this exchange. 

> ### **3PL Model Exchange workflow**

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/b04ff2f23027418ca033c577d0b8a168~tplv-k9wyc2ijk0-image.image)

1. When a buyer initiates an exchange, they will select which SKU they no longer want, and then select which SKU they want to receive for the exchange. 
2. Once the exchange is submitted, TikTok Shop will create a new `rma_id` associated with the buyer's request and trigger the RMA Status Update webhook with status `rma_created`
   1. TikTok will **not** generate a return shipping label, and we are expecting the seller's external system/return app to provide the label/
3. Sellers system to call Search Return Merchandise Authorization API to capture full RMA details:
   1. The `return_type` parameter = `EXCHANGE`
   2. This will allow the seller's OMS to understand the specific use-case of this return being created.
4. Sellers system/Return app will generate a return shipping label and upload it back to TikTok using the Upload Shipping Document API
5. The buyer will ship the return (or drop-off) with the specific carrier they selected during the return check-out
6. This carrier shipped/dropped-off signal is synced to TikTok, confirming the buyer has performed their action to return the item
7. Upon receiving the carrier signal, TikTok will **automatically** create a new outbound order for SKU-B. Within the **Get Order Details API & Get Order Lists API,** there are two parameters that identify the exchange scenario:
   1. `is_exchange_order`: Boolean
   2. `exchange_source_order_id`: Original order's order ID, from which the exchange order was generated. Returned only if `is_exchange_order` = `true`.
8. The seller's warehouse is expected to fulfill the order with the exchange item once they receive the order data for this exchange. 

### FAQ for Exchanges
**Question 1:** TikTok automatically creates the exchange outbound order as soon as the buyer ships the return package. What happens if I receive the return package, and my warehouse inspects the item(s) to find them either damaged or missing? What processes do I have to dispute with the buyer and TikTok?
**Answer:** As a seller, you can submit an arbitration process to dispute the damaged/missing items you were expecting to receive for this exchange. 

**Question 2:** Is this a breaking change?
**Answer:** No. This is an additive response field. Existing integrations will continue to work

**Question 3**: Does my app need a new authorization scope? 
**Answer:** Apps that already call Returns & Order scopes do not need new authorization.


---

## Solution Guidance > Affiliate API Solution Guide

Doc: https://partner.tiktokshop.com/docv2/page/affiliate-integration · cập nhật 2026-10-23

### Background
TikTok Shop is excited to launch a new category of APIs focused on affiliate marketing on TikTok Shop.
These APIs will provide Sellers, Creator Affiliates, and TikTok Shop Partners more efficient ways to create, manage, matchmake, track, monetize, and collaborate across TikTok Shop Affiliate Collaborations and Partner Campaigns.

**Affiliate API is inactive by default and the partner/ ISV has to apply for access, which requires approval from your Account Manager or Partner Manager to activate the API to build applications.**
#### Partner account setup

1. Refer to [Register as a service partner](tsp-onboarding) to register yourself. Ensure you select the following values during registration.
   * **Business Guide**: For app developers (ISVs)
   * **Category**: App developer > Customer Engagement > Affiliate
      ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/partner_account_setup1.png?x-resource-account=public)
2. Go to **App & Service** and create the following apps:
   * Affiliate (public): For launching an official app on the TikTok Shop App Store.
   * Affiliate (custom): For testing purposes.
   * Connector (custom): For obtaining necessary access to non-affiliate APIs.
3. Initiate a compliance review for the **Affiliate (public)** app by referring to [Publish and list a Public App](publish-and-list-public-app).
4. Provide your **app key** (a 14 character long key, not the App ID or Partner ID) to your partner manager so that we can list you for creator authorization. Creator authorization is necessary for accessing Creator APIs.
5. Begin development of integration once API accessibility is granted.

#### Development shop setup
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/development_shop_setup2.png?x-resource-account=public)
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/development_shop_setup1.png?x-resource-account=public)
#### Development shop Seller Center setup
##### Tax information
Provide dummy information to fulfill this requirement.
Navigate to [Seller Center](https://seller-us.tiktok.com/homepage) and there should be a banner similar to the following:
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/seller_center_banner.png?x-resource-account=public)
Click **Verify Now** on this banner and you should be greeted with a tax form as shown below. You may use the same values as shown in this example.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/seller_center_tax_information.png?x-resource-account=public)
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/seller_center_tax_information2.png?x-resource-account=public)
When you click **Submit**, you will be prompted with a confirmation box, where you are asked to sign. It might look intimidating, but this is a test account and we just need to fulfill some requirements.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/seller_center_tax_signature.png?x-resource-account=public)

📌 Note: You may have to set up your origin and return warehouses and set up shipping templates. Please refer to these support articles on configuring your warehouses and shipping templates:

* [Shipping templates](https://seller-us.tiktok.com/university/essay?knowledge_id=6837882170099457&role=1&course_type=1&from=search&identity=1&anchor_link=EC4200CA)
* [Warehouses](https://seller-us.tiktok.com/university/essay?knowledge_id=6837882170099457&role=1&course_type=1&from=search&identity=1&anchor_link=EBCE00CE)

Once you have submitted the tax information, your development shop setup is complete and ready to accept product listings.
##### Product listing example
As an example, let's say we have a product that we want creators to showcase. They will need an affiliate link to share with their followers to purchase this product. This helps streamline the purchasing process, and tracks sales on a creator or product segment. Here are some example screenshots of how you may list the product via Seller Center. You are also welcome to create them using the API.
📌 Note: It's recommended to choose No Brand if created via Seller Center.
**Product 1**
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/product_listing_example1.png?x-resource-account=public)
**Product 2**
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/product_listing_example2.png?x-resource-account=public)
Once the product is created, you should see them with a **Live** status after approval.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/product_listing_live.png?x-resource-account=public)
Congratulations! The product is now ready to be added to an open collaboration! Let's go to Affiliate Center by clicking on **Affiliate** on the left. Scroll down and click on **Go to TikTok Shop Affiliate homepage**. This will open Affiliate Center in a new tab. You can also use [this link here](https://affiliate-us.tiktok.com/errorpage?) and it should automatically log in.
#### Seller onboarding
Seller Center authorization is required to get information on all products a seller has for sale. Sellers can set up open collaborations where any creator is welcome join, or set up targeted collaborations with specific partners. To enable all of these via API, a seller must connect their TikTok Seller Center account so that you can manage their affiliates, products, and orders.
To understand all the steps involved in authorizing your application, please see the [Seller Authorization Guide](seller-authorization-guide) in Partner Center. Once authorized, you should:

* Verify the connection by calling the [Get Authorized Shops API](get-authorized-shops) and comparing the response to the values in Seller Center.
* Call the [Search Products API](search-products) to obtain a list of products and their corresponding Product IDs needed for future API calls.

#### Creator onboarding
Before you can send targeted collaborations or invite them to campaigns, you need to get the creator to connect their TikTok account with your application.

* Ask them to log in to TikTok using your creator authorization link. It will be in the form:
   `shop.tiktok.com/alliance/creator/auth?app_key=<app_key>&state=<state>`

❗ Important: The state parameter is required for creator authorization links.

* This will prompt the creator to log in with their TikTok Account.
* Once they login successfully, they will see a screen resembling the following:
   ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/creator_onboarding1.jpg?x-resource-account=public)
* When they click the **Authorize** button, TikTok Shop will send you to the redirect link specified in the app settings. For example, if the redirect link is `http://localhost:8000`, then the redirect URL will look like: `http://localhost:8000?code=<redacted>&state=<state>&app_key=<app_key>`.
* Use the code from the redirect URL to call the **GET Access Token** endpoint, which will grant you access to call the Affiliate Creator endpoints.

📌 Note: This process is the same as getting an access token for your Seller Center account, but there are two distinct access tokens, one for the seller account and one for the creator account.

* The **GET Creator Profile** endpoint will give you the `creator_user_id` needed to successfully call APIs for creating a targeted collaboration.

Please refer to our [creator authorization guide](creator-authorization-guide) in the TikTok Shop Partner Center for detailed information on how to connect these accounts.
#### API scope mapping
💡 Tip: You can directly search the API name in the Manage API modal by clicking on the dropdown next to Scope Name and selecting one of the items from the lists that are under the API Names column.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/api_scope_mapping.png?x-resource-account=public)
| Scope ID | Scope Name | API Names |
| --- | --- | --- |
| 434372 | Affiliate Information | * Check Anchor Content  * Check Anchor Prerequisites  * Get Creator Profile  * Get Live Room Info  * Get Shop Products |
| 733764 | Read Seller Affiliate Collaborations | * Search Seller Affiliate Orders  * Seller Search Affiliate Open Collaboration Product |
| 890884 | Manage Seller Affiliate Collaboration | * Create Open Collaboration  * Create Target Collaboration  * Edit Open Collaboration Settings  * Generate Affiliate Product Promotion Link  * Remove Creator Affiliate from Collaboration |
| 1021508 | Read Creator Affiliate Collaborations | * Creator Search Open Collaboration Product  * Search Creator Affiliate Orders  * Search Creator Target Collaborations |
| 733508 | Read Affiliate Partner Campaigns | * Get Affiliate Partner Campaign Detail  * Get Affiliate Partner Campaign List  * Get Affiliate Partner Campaign Product List |
| 733444 | Manage Affiliate Partner Campaigns | * Create Affiliate Partner Campaign  * Edit Affiliate Partner Campaign  * Publish Affiliate Partner Campaign |
| 733572 | Manage Affiliate Partner Campaign Products | * Review Affiliate Partner Campaign Product |
### Use cases
#### Generating an affiliate product promotion link
For products that are live, you can generate product promotion links by calling the [Generate Affiliate Product Promotion Link API](generate-affiliate-product-promotion-link). You can only create one promotion link per API call as the product ID is part of the path parameter.
```curl
curl --location --globoff --request POST 'https://open-api.tiktokglobalshop.com/affiliate_seller/202405/products/1729570313535393936/promotion_link/generate?app_key=6d0ut2ttps2io&shop_cipher=TTP_YaVduQAAAACwxSc13yKds1NldAZaPw34&sign=c2a149d480ae59b6eaf0ceebe1173d7fbb831a4227406a9008c0565535b42ebe&timestamp=1723135734' \
--header 'content-type: application/json' \
--header 'x-tts-access-token: <token>' \
--data ''

{
    "code": 0,
    "data": {
        "product_promotion_link": "https://www.tiktok.com/t/ZTNgEQFGa/"
    },
    "message": "Success",
    "request_id": "20240808165018109CFA6CCA917E04CBAD"
}
```

![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/open_collaboration1.png?x-resource-account=public)
❗ Important: You can only add one product to an open collaboration.

To create an open collaboration, follow these steps:

* Add product to open collaboration using a product ID and commission rate (e.g. 1234) by calling the [Create Open Collaboration API](create-open-collaboration).
   * If successful, the response should include effective time, ID (open collaboration ID 87620110221), and the product ID that's part of the collaboration.
   * If you want to edit the commission rate or the approve creator toggle, simply call the API again with the new settings. The ID does not change.

📌 Note: Free samples cannot be added to open collaboration via API, and must be done in Seller Center.

* You can verify creation success by calling the [Seller Search Affiliate Open Collaboration API](seller-search-affiliate-open-collaboration-product):

```curl
curl --location --globoff 'https://open-api.tiktokglobalshop.com/affiliate_seller/202405/open_collaborations/products/search?app_key=6d0ut2ttps2io&shop_cipher=TTP_YaVduQAAAACwxSc13yKds1NldAZaPw34&sign=30ce092ba485c189a6c30f856ce771c55c4acddda11c957ecababd5c07435a2d&timestamp=1723136505&page_size=10' \
--header 'content-type: application/json' \
--header 'x-tts-access-token: <token>' \
--data '{
    "category": {
        "id": "601755"
    },
    "title_keywords": [
        "Open Collaboration Pink"
    ],
    "sales_price_range": {
        "amount_ge": "3.99",
        "amount_lt": "4.99"
    },
    "commission_rate_range": {
        "rate_ge": 1233,
        "rate_lt": 1235
    }
}'

{
    "code": 0,
    "data": {
        "next_page_token": "",
        "products": [
            {
                "category_chains": [
                    {
                        "id": "601755",
                        "is_leaf": false,
                        "local_name": "Computers & Office Equipment",
                        "parent_id": "0"
                    },
                    {
                        "id": "831112",
                        "is_leaf": false,
                        "local_name": "Office Stationery & Supplies",
                        "parent_id": "601755"
                    },
                    {
                        "id": "855560",
                        "is_leaf": true,
                        "local_name": "Cards",
                        "parent_id": "831112"
                    }
                ],
                "commission": {
                    "amount": "0.4319",
                    "currency": "USD",
                    "rate": 1234
                },
                "detail_link": "https://shop.tiktok.com/view/product/1729570313535393936?region=US&local=en",
                "has_inventory": true,
                "id": "1729570313535393936",
                "main_image_url": "https://p16-oec-ttp.tiktokcdn-us.com/tos-useast5-i-omjb5zjo8w-tx/c9052b2b9d5248c1a552d5fe15a892d5~tplv-omjb5zjo8w-origin-webp.webp?from=1695864008",
                "original_price": {
                    "currency": "USD",
                    "maximum_amount": "4.19",
                    "minimum_amount": "4.19"
                },
                "sale_region": "US",
                "sales_price": {
                    "currency": "USD",
                    "maximum_amount": "3.5",
                    "minimum_amount": "3.5"
                },
                "shop": {
                    "name": "SANDBOX7398293016815273770"
                },
                "title": "Open Collaboration Coffee Pink Color Meme Card Smiling Lady",
                "units_sold": 5
            }
        ],
        "total_count": 1
    },
    "message": "Success",
    "request_id": "20240808170145A205E014C8878404D59C"
}
```

📌 Note: You may need to tweak the parameters to filter it down, especially if it's too generic. In the example above, the title keywords are "Open Collaboration Pink", sales price range is between 3.99 and 4.99, and commission rate was between 1233 and 1235.

* You can also verify this in Affiliate Center:

![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/open_collaboration2.png?x-resource-account=public)
##### Creator actions
Creators that have completed the onboarding steps described above can use your application to find open collaborations. To enable this feature, you must integrate with the [Creator Search Open Collaboration Product API](creator-search-open-collaboration-product) (cURL below). The API accepts a product title search, the product's price, the product's category, and the collaboration's commission and returns a list of open collaborations published by that seller, which creators are free to join. Some of them have screening processes where the seller has to approve the creator after review.
```curl
curl --location --globoff 'https://open-api.tiktokglobalshop.com/affiliate_seller/202405/open_collaborations/products/search?app_key=6d0ut2ttps2io&shop_cipher=TTP_bCWokAAAAAA6xm9rY_B9wYFY2QltXcs9&sign={{sign}}&timestamp={{timestamp}}&page_size=10' \
--header 'content-type: application/json' \
--header 'x-tts-access-token: <redacted>' \
--data '{
    "category": {
        "id": "601755"
    },
    "title_keywords": [
        "Open Collaboration Pink"
    ],
    "sales_price_range": {
        "amount_ge": "3.99",
        "amount_lt": "4.99"
    },
    "commission_rate_range": {
        "rate_ge": 1233,
        "rate_lt": 1235
    }
}'

{
    "code": 0,
    "data": {
        "next_page_token": "",
        "products": [
            {
                "category_chains": [
                    {
                        "id": "601755",
                        "is_leaf": false,
                        "local_name": "Computers & Office Equipment",
                        "parent_id": "0"
                    },
                    {
                        "id": "831112",
                        "is_leaf": false,
                        "local_name": "Office Stationery & Supplies",
                        "parent_id": "601755"
                    },
                    {
                        "id": "855560",
                        "is_leaf": true,
                        "local_name": "Cards",
                        "parent_id": "831112"
                    }
                ],
                "commission": {
                    "amount": "0.4319",
                    "currency": "USD",
                    "rate": 1234
                },
                "detail_link": "https://shop.tiktok.com/view/product/1729570313535393936?region=US&local=en",
                "has_inventory": true,
                "id": "1729570313535393936",
                "main_image_url": "https://p16-oec-ttp.tiktokcdn-us.com/tos-useast5-i-omjb5zjo8w-tx/c9052b2b9d5248c1a552d5fe15a892d5~tplv-omjb5zjo8w-origin-webp.webp?from=1695864008",
                "original_price": {
                    "currency": "USD",
                    "maximum_amount": "4.19",
                    "minimum_amount": "4.19"
                },
                "sale_region": "US",
                "sales_price": {
                    "currency": "USD",
                    "maximum_amount": "3.5",
                    "minimum_amount": "3.5"
                },
                "shop": {
                    "name": "SANDBOX7398293016815273770"
                },
                "title": "Open Collaboration Coffee Pink Color Meme Card Smiling Lady",
                "units_sold": 5
            }
        ],
        "total_count": 1
    },
    "message": "Success",
    "request_id": "202408081849481CCE26F7477A910041E1"
}
```

If a creator clicks on the `detail_link` on their phone under any product, it opens up the TikTok app and shows the product display page (PDP) with the collaboration details under it. In the example below, it is the text "Earn 0.52 on each product sold" right above the **Buy Now** button.

Clicking on this expands the menu with options like requesting a free sample or shoppable video (if applicable), and a main call to action for them to add the product to their showcase. For example, a fashion-based creator can search for open collaborations with sellers that are producing high-quality T-shirts using this API. The creator can enter what commission rate they would like to earn and the style of the T-shirt by passing it to the product's title search.
|  |  |  |
| --- | --- | --- |
| ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/open_collaboration3.PNG?x-resource-account=public)   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/open_collaboration4.PNG?x-resource-account=public)   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/open_collaboration5.PNG?x-resource-account=public)   |

##### Removing a creator from a collaboration
If for any reason you would like to remove a creator from an open collaboration, you can call the [Remove Creator Affiliate from Collaboration API](remove-creator-from-open-collaboration).
📌 Note: In the current API version, this will remove the creator but does not prevent them from rejoining with the affiliate link.
```curl
curl --location --globoff 'https://open-api.tiktokglobalshop.com/affiliate_seller/202405/open_collaborations/129916503437/remove_creator?app_key=6d0ut2ttps2io&shop_cipher=TTP_bCWokAAAAAA6xm9rY_B9wYFY2QltXcs9&sign=b61b7a13d73cf242f95d9f8ff8f0d46689af5ceba70749f5a267dac54c370869&timestamp=1723143673' \
--header 'content-type: application/json' \
--header 'x-tts-access-token: <redacted' \
--data '{
    "creator_user_id": "7400230764149244970",
    "product_id": "1729568997216587962"
}'

{
    "code": 0,
    "data": {},
    "message": "Success",
    "request_id": "20240808190113870E01A8EAB8AF006987"
}
```

#### Creating a targeted collaboration
To successfully invite creators to a targeted collaboration, you will need a list of creator user IDs, and up to 50 creators can be invited per one API call. This means you will need to have creators authorized as per the [Creator Authorization link here](creator-authorization-guide) and have a unique access token to modify the creator's TikTok account.
To create a targeted collaboration, follow these steps:

* Call the [Get Creator Profile API](get-creator-profile) with the creator access token to get creator user IDs if you do not have them stored in your database:

```curl
curl --location --globoff 'https://open-api.tiktokglobalshop.com/affiliate_creator/202405/profiles?app_key=6d0ut2ttps2io&sign=4ba5a9531b4c2196cdefde923c270259363398d3fcd05074c0c9302e07f77576&timestamp=1723144188' \
--header 'content-type: application/json' \
--header 'x-tts-access-token: <creator_token>' \
--data ''

{
    "code": 0,
    "data": {
        "avatar": {
            "url": "https://p16-sign-va.tiktokcdn.com/musically-maliva-obj/1594805258216454~c5_100x100.webp?lk3s=a5d48078&nonce=51354&refresh_token=4cda6b090dcbd9854fe8aa7ec2297662&x-expires=1723312800&x-signature=y9Z7uqPuxLEtzus5m7PBg5CeqH4%3D&shp=a5d48078&shcp=2c5759a5"
        },
        "creator_user_id": "7400230764149244970",
        "permissions": [
            "LIVE_STREAM_PERMISSION",
            "ADD_AFFILIATE_PERMISSION"
        ],
        "register_region": "US",
        "selection_region": "US",
        "seller_type": "UNKNOWN",
        "user_type": "TIKTOK_SHOP_CREATOR",
        "username": "testdziwjtmwbq"
    },
    "message": "Success",
    "request_id": "202408081837124EF0047357C9480005DB"
}
```

* [Call the Create Target Collaboration API](create-target-collaboration):

```curl
curl --location --globoff 'https://open-api.tiktokglobalshop.com/affiliate_seller/202405/target_collaborations?app_key=6d0ut2ttps2io&shop_cipher=TTP_bCWokAAAAAA6xm9rY_B9wYFY2QltXcs9&sign=5ddb3f519b3da61f2f959df81fc42b77441df06626f070ae423e3112a932111a&timestamp=1723144047' \
--header 'content-type: application/json' \
--header 'x-tts-access-token: <redacted>' \
--data-raw '{
    "name": "API Target Collaboration",
    "message": "Created via Postman",
    "end_time": "1723194000",
    "products": [
        {
            "id": "1729569362021748922",
            "target_commission_rate": 2001
        }
    ],
    "creator_user_ids": [
        "7400230764149244970"
    ],
    "seller_contact_info": {
        "email": "test@tiktokshop.com"
    },
    "free_sample_rule": {
        "has_free_sample": true,
        "is_sample_approval_exempt": false
    }
}'

{
    "code": 0,
    "data": {
        "target_collaboration": {
            "id": "7400846837790361387"
        },
        "target_collaboration_conflicts": []
    },
    "message": "Success",
    "request_id": "202408081907271D8F70256ABB65008443"
}
```

* It is recommended that the `end_time` be at least a few days from now.
* Sometimes the API may return `target_collaboration_conflicts` in the response. This means the targeted collaboration has **not** been created.
* If successful, there should be a `target_collaboration` object, with a target collaboration ID.
   * Common errors include:
      * `invalid_params`: Please check the `end_time`.
      * `test account and non test account can not cross invite`: If you are inviting multiple creators, and one or more of them do not match the shop environment, please remove them from the creator list.

##### Creator actions
Creators can find collaboration invites by going to **Profile > TikTok Studio > TikTok Shop for Creator** (under Monetization) **>** Scroll down to **TikTok Shop Toolkit > Collab invites**.

* When a creator selects the collaboration they are interested in, it will show all the products that are part of this invite, and they can choose to add the ones they would like to promote to their showcase.
* They can either choose to **Add All** or click on individual products to add them.

|  |  |  |  |
| --- | --- | --- | --- |
| ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/target_collaboration1.png?x-resource-account=public)   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/target_collaboration2.png?x-resource-account=public)   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/target_collaboration3.png?x-resource-account=public)   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/target_collaboration4.png?x-resource-account=public)   |

The [Search Creator Target Collaborations API](search-creator-target-collaborations) lets the application search all the targeted collaborations a creator has with a particular store. This store needs a shop ID that can be retrieved by calling the [Get Authorized Shops API](get-authorized-shops) as described in the seller onboarding steps above.
```curl
curl --location --globoff 'https://open-api.tiktokglobalshop.com/affiliate_creator/202405/target_collaborations/search?app_key=6d0ut2ttps2io&sign={{sign}}&timestamp={{timestamp}}&page_size=20' \
--header 'content-type: application/json' \
--header 'x-tts-access-token: TTP_VfWnMAAAAADpPV2NiWO2_60_59-jq0QxV6beCG1eHCnsQGa3Znh6huRfzsNsfAjCx3sexUeCzQ35Fi8SZfHTTwVnm-dQD_vk_Jh0YTSdfpp2tmWllFw_4g' \
--data '{
    "shop_id": "7495792013947799738"
}'

{
    "code": 0,
    "data": {
        "next_page_token": "",
        "target_collaborations": [
            {
                "id": "7400846837790361387",
                "name": "API Target Collaboration",
                "products": [
                    {
                        "commission": {
                            "amount": "1.0005",
                            "currency": "USD",
                            "rate": 2001
                        },
                        "id": "1729569362021748922",
                        "main_image_url": "tos-useast5-i-omjb5zjo8w-tx/b22252c5634c4cf58ab44fd630945cc0",
                        "title": "I Got A Bridge To Sell You Model Concrete Test Prod"
                    }
                ],
                "status": "LIVE"
            }
        ],
        "total_count": 1
    },
    "message": "Success",
    "request_id": "202408081923125F67CB063F3DF300AF19"
}
```

#### Showcase interactions
##### Creator using the TikTok app
When a creator clicks on the product promotion link on their mobile device, it opens the TikTok app and displays the PDP, which will prompt the creator to add the product to the showcase. This prompt will also let the creator order a free sample if it is enabled in the open collaboration, or prompt them to make a shoppable video if it is a targeted collaboration.
##### Partner/seller using API
To call any of the APIs listed under **Affiliate Creator** in the API Reference, you will need to have your creator authorize your application. Follow the [Creator Authorization flow in the link here](creator-authorization-guide). The following steps assume you have a token to make changes to their TikTok account. For testing purposes, you may use the TikTok Creator Account credentials above if you do not currently have one.

To add a product to a creator's showcase, the product must already exist as part of a collaboration. You may get an error that asks you to contact TikTok if a product collaboration link does not exist. See above on how to create a targeted collaboration.

To add a product to the creator's showcase, you can call the [Add Showcase Products API](add-showcase-products). It is recommended that you add the affiliate link that can be generated as per the use case above.

Once the product is added to their showcase, they can request free samples if enabled.
##### Creator using API
The application integrating with TikTok APIs can show the current products listed in a particular creator's account by calling Get Showcase Products.
#### Free samples for creators
##### Enabling free samples
Free samples can only be enabled in the Affiliate Center. Click on **Not Created** to open a modal that lets you specify rules for free samples. The only required field is quantity, you can tweak the rest to your liking. Once free samples are enabled, you need to generate a product promotion link that can be shared with creators.

Please refer to the above sections: **Generate affiliate product promotion link**, **Creating an open collaboration**, and **Creating a targeted collaboration** on how to generate the link where creators can request samples.

📌 Note: If a product is not added to open collaboration, only the link is generated.

Share this link with a creator so they can add it to showcase as shown below.
##### Requesting free samples
|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/free_sample1.png?x-resource-account=public)   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/free_sample2.png?x-resource-account=public)   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/free_sample3.png?x-resource-account=public)   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/free_sample4.png?x-resource-account=public)   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/free_sample5.png?x-resource-account=public)   |

##### Fulfilling free samples
When a creator adds a product to their showcase, they also have the option to request a free sample if available. Requests for these samples are displayed in Affiliate Center under the [Sample Requests page](https://affiliate-us.tiktok.com/product/sample-request?shop_region=US). Sellers can approve or deny these requests if auto-approved is set to false.

Once approved, a sample order is created and should be reflected in Seller Center. Fulfill this order like you would any other order.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/free_sample6.png?x-resource-account=public)
 ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/free_sample7.png?x-resource-account=public)
 ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/free_sample8.png?x-resource-account=public)
📌 Note: There is no on hold period for free sample orders. Once a tracking number is provided in Seller Center (either via TikTok Shipping or Seller Shipping), the status will change from Ready To Ship (Awaiting Shipment in Seller Center) to Shipped (Awaiting Collection in Seller Center).
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/free_sample9.png?x-resource-account=public)
A creator can view their sample orders by going to **Profile > Your Orders > Samples > Orders**.
#### Affiliate orders
##### TikTok app purchase flow
<video controls><source src="https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ[[/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/aff1.mp4?x-resource-account=public" type="video/mp4"></video>
<video controls><source src="https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ[[/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/aff2.mp4?x-resource-account=public" type="video/mp4"></video>
##### Seller Center orders
When a product is purchased using the affiliate process (either the link or the shoppable video), they show up in the [Affiliate Orders section](https://affiliate-us.tiktok.com/product/order?shop_region=US).
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/seller_center_orders1.png?x-resource-account=public)
These orders are also created in Seller Center and are linked in the highlighted area. Clicking the order ID will open the order in Seller Center in a new window. These orders will have a one hour hold period by default.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Affiliate%20Integration/seller_center_orders2.png?x-resource-account=public)
These orders can also be found by calling the [Search Seller Affiliate Orders API](search-seller-affiliate-orders).
##### Creator orders
To look up orders that were generated by the creator, you can call the [Search Creator Affiliate Orders API](search-creator-affiliate-orders). Partners are able to retrieve a list of affiliate orders from the creator, and partners can use the order ID to measure the conversions generated from the creator.


---

## Solution Guidance > Large File Uploads Solution Guide

Doc: https://partner.tiktokshop.com/docv2/page/wfi3nz36 · cập nhật 2026-07-06

### Status quo and background
Large file upload is designed to support file sizes that exceed the existing direct-upload limit. The previous direct-upload solution loaded the whole file into memory, which could create Out of Memory (OOM) risk for gateway services and limit new business scenarios.
The chunked upload solution supports stable uploads for large videos, high-definition images, PDF files, and other supported media types. A single file can support up to 1 GB, subject to the limit of the specific business scenario.

* Customer Service supports files up to **100 MB**.
* Shoppable Video supports files up to **500 MB**.
* For files smaller than **10 MB**, continue to use the existing direct-upload API for the corresponding business scenario.
* For files larger than **10 MB**, use the chunked upload flow described in this guide.

### Technical solution overview
Large file upload uses a business file gateway and chunked upload model:

1. The client initializes an upload session through OpenAPI.
2. The client splits the local file into chunks and uploads them to the returned `upload_url`.
3. The file gateway merges the chunks automatically after the final chunk succeeds.
4. The client binds the returned `resource_id` to the target business resource.

Key capabilities:

* **Upload token**: `upload_token` is returned by the upload initialization API and is the credential for the chunk upload session. Treat it as short-lived and upload-session specific.
* **Security and authentication**: Upload initialization uses standard OpenAPI authentication. Chunk upload uses the returned `upload_url`, `upload_token`, `x-tts-access-token`, and required identifiers such as `shop_cipher`.
* **Compliance**: The file gateway and OpenAPI gateway use the same open-api domain and traffic scheduling policies so that file traffic stays in the corresponding compliance unit.

### Version and endpoint conventions
Use the following endpoint for upload initialization in this guide:
```Plain Text
[POST] /open/202512/file/init
```

Do not use legacy upload-init paths copied from earlier drafts. The upload init API reference is [Upload File Init](https://partner.tiktokshop.com/docv2/page/upload-file-init-202512).
`target_path` is the path of the later business binding API. It may use a different API version because it belongs to the target business API, not to Upload File Init. For example, the Customer Service binding API is [Send Message](https://partner.tiktokshop.com/docv2/page/send-message-202309).
### Large file upload process
Large file uploads are divided into three steps:
| ID | Step | Flow | API path | Description |
| --- | --- | --- | --- | --- |
| 1 | Initialize Upload | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/4d9955462e5c4f09a2de65d8c340179b~tplv-k9wyc2ijk0-image.image) | `[POST] /open/202512/file/init` | Call the initialization API before uploading file chunks. The response returns `data.upload_url` and `data.upload_token`. |
| 2 | Chunk Upload and Completion | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/2a8f3fbedfb64b5a9415b4c4a47f565a~tplv-k9wyc2ijk0-image.image) | `[PUT] {upload_url}` returned by Upload File Init | Split the file into chunks and upload each chunk to `data.upload_url`. Set `chunk_num` starting from 1. After the last chunk succeeds, the gateway merges the chunks and returns `data.resource_id`. No extra merge API is required. |
| 3 | Bind Resource | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/0a2c6728c85b432caa4be5ef00232d2f~tplv-k9wyc2ijk0-image.image) | Varies by business. Example: `[POST] /customer_service/202309/conversations/{conversation_id}/messages` | Call the business-specific resource binding API and pass the `resource_id`. In Customer Service, pass `resource_id` as the `vid` parameter of [Send Message](https://partner.tiktokshop.com/docv2/page/send-message-202309). |
### API details
### 1. Initialize upload
Use [Upload File Init](https://partner.tiktokshop.com/docv2/page/upload-file-init-202512) to obtain the target upload URL and upload token.
**Endpoint**
```Plain Text
[POST] /open/202512/file/init
```

**Common query parameters**
| Parameter | Type | Description |
| --- | --- | --- |
| `app_key` | String | Your app key. |
| `timestamp` | Integer | Current Unix timestamp in seconds. |
| `sign` | String | Request signature. For signing rules, refer to [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request). |

**Headers**
| Header | Type | Description |
| --- | --- | --- |
| `Content-Type` | String | `application/json`. |
| `x-tts-access-token` | String | The access token of the authorized user. |

**Request body**
| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `file_size` | Integer | Yes | Total file size in bytes. |
| `file_name` | String | Yes | File name, including the extension, such as `my_video.mp4`. |
| `total_chunk_count` | Integer | Yes | Total number of chunks that will be uploaded. |
| `file_type` | String | Yes | File type. Supported values: `video`, `image`, `pdf`. |
| `target_path` | String | Yes | The API path of the target resource binding endpoint, used for permission checks and routing. Example: `[POST]/customer_service/202309/conversations/{conversation_id}/messages`. |

**Success response**
```JSON
{
  "code": 0,
  "data": {
    "upload_url": "https://open-api.tiktokglobalshop.com/file/v1/upload",
    "upload_token": "RETURNED_UPLOAD_TOKEN"
  },
  "message": "Success",
  "request_id": "20251201000000000000000000000000"
}
```

Use `data.upload_url` exactly as returned. Do not reconstruct it from the examples, because the returned URL may include routing information.
### 2. Upload file chunk
Upload each chunk to `data.upload_url` from Upload File Init.
**Endpoint**
```Plain Text
[PUT] {upload_url}
```

**Query parameters**
| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `upload_token` | String | Yes | Upload token returned by Upload File Init. |
| `chunk_num` | Integer | Yes | Sequence number of the current chunk, starting from 1. |
| `app_key` | String | Yes | Your app key. |
| `shop_cipher` | String | Conditional | Required for shop-scoped uploads when the token is associated with a TikTok Shop seller, such as `user_type=0` (`TTS`). Obtain it from [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309). Do not use the legacy label `user_type=3 (Partner)`: token `user_type` values are `0=TTS`, `1=TTC`, `2=PARTNER`, `3=PARTNERV2`, `4=GS`, and `5=GSV2`. For partner token uploads, follow the target business API's identifier requirement. |

**Headers**
| Header | Type | Description |
| --- | --- | --- |
| `Content-Type` | String | MIME type of the chunk. It must be compatible with the `file_type` declared during initialization. |
| `x-tts-access-token` | String | The authorized user's access token. |

**Request body**
The request body is the binary data of the current chunk.
**Chunk size**
Set the default chunk size to **20 MB**. Each chunk should be between **5 MB** and **30 MB**. If the final chunk would be smaller than 5 MB, merge it into the previous chunk.
**Response examples**
When a non-final chunk succeeds:
```JSON
{
  "code": 0,
  "data": {
    "part_id": "PART_ID_FOR_THIS_CHUNK"
  },
  "message": "Success",
  "request_id": "20251201000000000000000000000001"
}
```

When the final chunk succeeds and the merge is complete:
```JSON
{
  "code": 0,
  "data": {
    "resource_id": "FINAL_RESOURCE_ID"
  },
  "message": "Success",
  "request_id": "20251201000000000000000000000002"
}
```

### Supported content types
| File category | `file_type` | Supported `Content-Type` values |
| --- | --- | --- |
| Video | `video` | `video/mp4`, `video/quicktime`, `video/webm` |
| Image | `image` | `image/png`, `image/jpeg` |
| PDF | `pdf` | `application/pdf` |
### 3. Bind resource
After you receive `data.resource_id` from the final chunk response, call the target business API to associate the uploaded resource with your business object.
For example, in the Customer Service business, call [Send Message](https://partner.tiktokshop.com/docv2/page/send-message-202309) and pass `resource_id` as the `vid` parameter.
### Validation process
During chunk upload, the gateway validates:

1. **Size accumulation**: The gateway accumulates uploaded chunk sizes and checks them against the `file_size` declared during initialization.
2. **Content type**: The `Content-Type` of each chunk must match the `file_type` declared during initialization.
3. **Chunk count**: The gateway merges the file after all chunks in `total_chunk_count` have been uploaded successfully.
4. **Identifiers**: For shop-scoped uploads, the request must include the correct `shop_cipher` for the access token and target shop.

### cURL example
### Initialize upload
```Bash
curl -X POST 'https://open-api.tiktokglobalshop.com/open/202512/file/init?app_key=YOUR_APP_KEY&timestamp=1710000000&sign=YOUR_SIGNATURE' \
  -H 'Content-Type: application/json' \
  -H 'x-tts-access-token: USER_ACCESS_TOKEN' \
  -d '{
    "file_size": 20971520,
    "file_name": "test_video.mp4",
    "total_chunk_count": 1,
    "file_type": "video",
    "target_path": "[POST]/customer_service/202309/conversations/{conversation_id}/messages"
  }'
```

Expected response:
```JSON
{
  "code": 0,
  "data": {
    "upload_url": "https://open-api.tiktokglobalshop.com/file/v1/upload",
    "upload_token": "RETURNED_UPLOAD_TOKEN"
  },
  "message": "Success",
  "request_id": "20251201000000000000000000000000"
}
```

### Upload chunk
Use the `data.upload_url` and `data.upload_token` returned by Upload File Init.
```Bash
curl -X PUT 'https://open-api.tiktokglobalshop.com/file/v1/upload?upload_token=RETURNED_UPLOAD_TOKEN&chunk_num=1&app_key=YOUR_APP_KEY&shop_cipher=YOUR_SHOP_CIPHER' \
  -H 'Content-Type: video/mp4' \
  -H 'Content-Length: 20971520' \
  -H 'x-tts-access-token: USER_ACCESS_TOKEN' \
  --data-binary '@/path/to/your/local/file_chunk_1.dat'
```

If `shop_cipher` is not required for your token type and target API, omit it from the chunk upload query.
### Go example
The following example initializes an upload session, splits a local file into 20 MB chunks, merges a final chunk smaller than 5 MB into the previous chunk, uploads chunks sequentially, and returns the final chunk response.
```Go
package main

import (
        "bytes"
        "context"
        "crypto/hmac"
        "crypto/sha256"
        "encoding/hex"
        "encoding/json"
        "errors"
        "fmt"
        "io"
        "log"
        "mime"
        "net/http"
        "net/url"
        "os"
        "path/filepath"
        "sort"
        "strconv"
        "strings"
        "time"
)

const apiVersion = "202512"
const defaultChunkSize = 20 * 1024 * 1024
const minChunkSize = 5 * 1024 * 1024

type OpenAPIClient struct {
        BaseURL     string
        AccessToken string
        AppKey      string
        AppSecret   string
        HTTP        *http.Client
}

func New(baseURL, accessToken, appKey, appSecret string) *OpenAPIClient {
        return &OpenAPIClient{
                BaseURL:     strings.TrimRight(baseURL, "/"),
                AccessToken: accessToken,
                AppKey:      appKey,
                AppSecret:   appSecret,
                HTTP:        &http.Client{Timeout: 60 * time.Second},
        }
}

type UploadInitRequest struct {
        FileSize        int64  `json:"file_size"`
        TotalChunkCount int    `json:"total_chunk_count"`
        FileType        string `json:"file_type"`
        TargetPath      string `json:"target_path"`
        FileName        string `json:"file_name"`
}

type UploadInitResponse struct {
        Code int `json:"code"`
        Data struct {
                UploadURL   string `json:"upload_url"`
                UploadToken string `json:"upload_token"`
        } `json:"data"`
        Message   string `json:"message"`
        RequestID string `json:"request_id"`
}

func (c *OpenAPIClient) UploadInit(ctx context.Context, body UploadInitRequest) (*UploadInitResponse, error) {
        apiPath := "/open/" + apiVersion + "/file/init"
        bodyBytes, err := json.Marshal(body)
        if err != nil {
                return nil, err
        }

        timestamp := strconv.FormatInt(time.Now().Unix(), 10)
        signParams := map[string]string{
                "app_key":   c.AppKey,
                "timestamp": timestamp,
        }

        query := url.Values{}
        query.Set("app_key", c.AppKey)
        query.Set("timestamp", timestamp)
        query.Set("sign", c.computeSign(apiPath, signParams, "application/json", bodyBytes))

        req, err := http.NewRequestWithContext(ctx, http.MethodPost, c.BaseURL+apiPath+"?"+query.Encode(), bytes.NewReader(bodyBytes))
        if err != nil {
                return nil, err
        }
        req.Header.Set("Content-Type", "application/json")
        req.Header.Set("x-tts-access-token", c.AccessToken)

        resp, err := c.HTTP.Do(req)
        if err != nil {
                return nil, err
        }
        defer resp.Body.Close()

        respBody, err := io.ReadAll(resp.Body)
        if err != nil {
                return nil, err
        }
        log.Printf("UploadInit status=%d logid=%s", resp.StatusCode, resp.Header.Get("X-Tt-Logid"))

        var parsed UploadInitResponse
        if err := json.Unmarshal(respBody, &parsed); err != nil {
                return nil, err
        }
        if parsed.Code != 0 {
                return nil, fmt.Errorf("upload init failed: %s", parsed.Message)
        }
        if parsed.Data.UploadURL == "" || parsed.Data.UploadToken == "" {
                return nil, errors.New("upload init response missing upload_url or upload_token")
        }
        return &parsed, nil
}

type chunkRange struct {
        start int64
        end   int64
}

func buildChunkRanges(size int64) []chunkRange {
        if size <= 0 {
                return []chunkRange{{start: 0, end: 0}}
        }

        chunks := make([]chunkRange, 0, int(size/defaultChunkSize)+1)
        for start := int64(0); start < size; start += defaultChunkSize {
                end := start + defaultChunkSize
                if end > size {
                        end = size
                }
                chunks = append(chunks, chunkRange{start: start, end: end})
        }

        if len(chunks) >= 2 {
                last := chunks[len(chunks)-1]
                if last.end-last.start < minChunkSize {
                        chunks[len(chunks)-2].end = last.end
                        chunks = chunks[:len(chunks)-1]
                }
        }
        return chunks
}

func (c *OpenAPIClient) ChunkUpload(ctx context.Context, uploadURL, uploadToken, filePath, contentType, shopCipher string) (*http.Response, []byte, error) {
        file, err := os.Open(filePath)
        if err != nil {
                return nil, nil, err
        }
        defer file.Close()

        info, err := file.Stat()
        if err != nil {
                return nil, nil, err
        }

        chunks := buildChunkRanges(info.Size())
        var lastResp *http.Response
        var lastBody []byte

        for i, rg := range chunks {
                chunkNum := i + 1
                reader := io.NewSectionReader(file, rg.start, rg.end-rg.start)

                parsedURL, err := url.Parse(uploadURL)
                if err != nil {
                        return nil, nil, err
                }
                query := parsedURL.Query()
                query.Set("upload_token", uploadToken)
                query.Set("chunk_num", strconv.Itoa(chunkNum))
                query.Set("app_key", c.AppKey)
                if shopCipher != "" {
                        query.Set("shop_cipher", shopCipher)
                }
                parsedURL.RawQuery = query.Encode()

                req, err := http.NewRequestWithContext(ctx, http.MethodPut, parsedURL.String(), reader)
                if err != nil {
                        return nil, nil, err
                }
                req.Header.Set("Content-Type", contentType)
                req.Header.Set("x-tts-access-token", c.AccessToken)
                req.ContentLength = rg.end - rg.start

                resp, err := c.HTTP.Do(req)
                if err != nil {
                        return resp, nil, err
                }
                body, readErr := io.ReadAll(resp.Body)
                resp.Body.Close()
                if readErr != nil {
                        return resp, body, readErr
                }

                log.Printf("Chunk %d/%d status=%d logid=%s", chunkNum, len(chunks), resp.StatusCode, resp.Header.Get("X-Tt-Logid"))
                lastResp, lastBody = resp, body
        }

        return lastResp, lastBody, nil
}

func (c *OpenAPIClient) UploadFile(ctx context.Context, filePath, fileType, targetPath, shopCipher string) (*http.Response, []byte, error) {
        info, err := os.Stat(filePath)
        if err != nil {
                return nil, nil, err
        }

        ranges := buildChunkRanges(info.Size())
        initResp, err := c.UploadInit(ctx, UploadInitRequest{
                FileSize:        info.Size(),
                TotalChunkCount: len(ranges),
                FileName:        filepath.Base(filePath),
                FileType:        fileType,
                TargetPath:      targetPath,
        })
        if err != nil {
                return nil, nil, err
        }

        contentType := contentTypeForFile(filePath, fileType)
        return c.ChunkUpload(ctx, initResp.Data.UploadURL, initResp.Data.UploadToken, filePath, contentType, shopCipher)
}

func contentTypeForFile(filePath, fileType string) string {
        ext := strings.ToLower(filepath.Ext(filePath))
        switch {
        case fileType == "pdf" || ext == ".pdf":
                return "application/pdf"
        case ext == ".jpg" || ext == ".jpeg":
                return "image/jpeg"
        case ext == ".png":
                return "image/png"
        case ext == ".mov":
                return "video/quicktime"
        case ext == ".webm":
                return "video/webm"
        default:
                return "video/mp4"
        }
}

func (c *OpenAPIClient) computeSign(path string, params map[string]string, contentType string, body []byte) string {
        cleaned := make(map[string]string, len(params))
        for k, v := range params {
                if k != "sign" && k != "access_token" {
                        cleaned[k] = v
                }
        }

        keys := make([]string, 0, len(cleaned))
        for k := range cleaned {
                keys = append(keys, k)
        }
        sort.Strings(keys)

        input := path
        for _, k := range keys {
                input += k + cleaned[k]
        }

        if mediaType, _, err := mime.ParseMediaType(contentType); err != nil || mediaType != "multipart/form-data" {
                input += string(body)
        }

        input = c.AppSecret + input + c.AppSecret
        mac := hmac.New(sha256.New, []byte(c.AppSecret))
        _, _ = mac.Write([]byte(input))
        return hex.EncodeToString(mac.Sum(nil))
}

func main() {
        client := New(
                "https://open-api.tiktokglobalshop.com",
                os.Getenv("TTS_ACCESS_TOKEN"),
                os.Getenv("TTS_APP_KEY"),
                os.Getenv("TTS_APP_SECRET"),
        )

        _, body, err := client.UploadFile(
                context.Background(),
                "/path/to/test_video.mp4",
                "video",
                "[POST]/customer_service/202309/conversations/{conversation_id}/messages",
                os.Getenv("TTS_SHOP_CIPHER"),
        )
        if err != nil {
                log.Fatal(err)
        }
        log.Printf("Final upload response: %s", string(body))
}
```

### FAQ
### Q1: How should I set the chunk size?
Set the default chunk size to **20 MB**. The valid chunk size range is **5-30 MB**. If the final chunk is smaller than **5 MB**, merge it into the previous chunk. This keeps the implementation consistent with the Go example and avoids small-tail upload failures.
### Q2: Why does my 68 MB local file show as only 65 MB after being uploaded to the video cloud?
This is normal. Videos may be processed after upload, such as encapsulation or compression, so there may be a slight file size discrepancy. This does not affect video publishing or subsequent posting processes.
### Q3: Are there any limitations in the sandbox environment?
Yes. The **QPH (Queries Per Hour) limit for sandbox apps is 10**. This is intended for functional verification only and is not suitable for high-frequency testing.
### Q4: What should I do before downloading the SDK?
Before downloading the SDK:

1. Click **Check for updates**.
2. Update your development tools to the latest version.
3. Download the SDK again.

Failure to update your tools may lead to SDK download failures or version mismatch issues.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/72215ea66ff94d00b3435dff4776facd~tplv-k9wyc2ijk0-image.image)


---

## Solution Guidance > Shoppable video Integration Solutions

Doc: https://partner.tiktokshop.com/docv2/page/ng0l9170 · cập nhật 2026-10-23

**Important Notice**
The API structure will remain unchanged, but certain field names may be modified. 
Please keep an eye 👁👁 on the documentation for updates.
Developers are encouraged to regularly check the **Changelog** for the latest updates and changes.

🌟 **Test Shoppable Video**: [【External】Test Affiliate Integration with your own TikTok Account](https://bytedance.sg.larkoffice.com/docx/OB5Zdr0y2oyiikxNZnVlhZNcgCb)

### Introduction
This solution targets **third-party apps and seller developer sellers**, covering the end-to-end flow—from creator authorization → fetching eligible products → asset creation and upload → video precheck and publishing (with product anchors) →video data perfomance.
> 本方案面向 **3P App / 自研商家**，提供从达人授权 → 获取可带货商品 → 素材制作与上传 → 视频预审与发布（绑定商品锚点）→ 数据回收的集成解决方案。

### Business Goal

* Enable developers to build on reliable **Shoppable Content Posting APIs** to continuously produce shoppable videos for sellers/creators, increasing publishing volume and conversions.
* Support bulk publishing and detailed failure feedback, paving the way for subsequent ad campaigns and creative optimization.
> * 让开发者基于稳定的 **Shoppable Content Posting APIs**，为商家/达人持续产出可挂车视频，提升发布量与转化。
> * 支持**批量发布**与**发布**失败原因回传，并为后续广告投放和素材优化提供帮助。

### Glossary
| Term | Definition  |
| --- | --- |
| Application Requirement Document (ARD) | This document gives you an overview of the various use cases that a seller needs, in order to manage their shop on TikTok via an ecommerce platform connector.  |
| Integration Flow | An integration flow is a development guide related to the specific use case. |
| TTS | Acronym for TikTok Shop.  |
| Buyer | Buyer purchases product(s) on TikTok Shop.  |
| Seller | A TikTok Shop seller  |
| Creator | All users, including sellers, who create content. |
| content | **All** available forms of media that can be uploaded by creators to TikTok Shop, including your Product Showcase, videos, and live streams. This also includes all metadata, captions, and profile information. |
| Shoppable short video   | **Shoppable short video** is created in the same format that you would create any short video on TikTok. The difference between your typical TikTok video and a shoppable short video is that a shoppable short video includes an embedded anchor link that directs your audience to the product that you want to promote. We've found that a well-executed video can make a big difference when it comes to connecting with potential customers and selling. **Short videos** are key in capturing audience attention, inspiring them to take action, and driving them to purchase. |
| Marketing account    | Marketing account (up to 4): Additional accounts to expand seller reach and marketing capabilities. Marketing accounts can sell both linked sellers' and affiliates' products. |
| Official account | Official account (Required, 1 per shop): seller's primary brand presence on TikTok Shop with a dedicated shop page. An official account can only sell products from the linked seller account. |
| TikTok Shop Short Video Official Guidelines | https://seller-us.tiktok.com/university/essay?knowledge_id=7096334743553838&from=new-and-updated&role=1&identity=1 |
| TikTok Community Guideline | https://www.tiktok.com/community-guidelines/en/overview |
| Seller Center | A seller portal for TTS sellers to manage their shop, products, orders, returns/refunds, and more.  |
| Module  | A module is a subcomponent of the ecommerce selling lifecycle.  |
| Feature | A feature is a subcomponent of module. Features are a set of functionalities in a product that will allow the seller to complete a set of tasks or actions. How you design the feature will determine the overall experience of the end user. |
| Use Case | A use case is a specific situation in which an app could potentially be used by a seller or buyer.  |
| UI Suggestions  | Specific UI suggestions for developers to consider during development phase to ensure an easy-to-use experience on the app.  |
| App Developer | Partners/developers who are building the app.  |
| App Reviewer | Once the app development is complete, a team member will review and test the app based on the ARD you filled out.  |
| Beta Testers | Once internal review is done, we will invite sellers to beta test your app. The sellers are beta testers.  |

###  Integration flow Overview

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/e6c0245787624e76a8f208fcd23acbf1~tplv-k9wyc2ijk0-image.image)
### API / Webhook Overview 
| **API/Notification name** | **Type** | **Description** |
| --- | --- | --- |
| [Get Access Token](https://partner.tiktokshop.com/docv2/page/authorization-overview-202407)   | RESTful API | Use this API to request an `access_token` and `refresh_token` |
| [Get Creator Profile](https://partner.tiktokshop.com/docv2/page/get-creator-profile-202508) | RESTful API | Use this API to get the creator's profile information. |
| [Get Shop Products](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-Fu3idMqnqoqwTixg2lklALotgSG)   | RESTful API | Developers can utilize this API to search and retrieve product information of shops which is bound by a specific creator with specific keywords. |
| [Get Showcase Products](https://partner.tiktokshop.com/docv2/page/get-showcase-products-202405#Back%20To%20Top)   | RESTful API | This API lists the products in the creator's showcase, paginated by specified page size and iterated through pages by page token for up to **2000 products** in the showcase. This API is generally used when a creator would like to view the products in the showcase. The platform will return the product details in the showcase, as well as the products in the livebag if the creator is live streaming. |
| [Upload Shoppable Video File](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-EEPudRjSEorRmIxMSX6lFIL8gih) | RESTful API   | Use this API to upload the video before posting to TikTok   |
| [Post Shoppable Video](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-U6Sud9fdBodmjwxLRKml4GAfgib) | RESTful API | Use this API to publish the video. The request supports `video_info.is_ai_generated` to indicate AI-generated content; the field defaults to `false` when omitted. The response may include `data.video.quota` when a content posting quota restriction applies. |
| [Get Shoppable Video Status](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-J9uCdO4Ulo3RAjxscIUlKib1gGf) | RESTful API | Use this API to get video publish result |
| [Pre-check Shoppable Video ](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-GEyCdCNhGoAZ5TxbVetli7SbgLc) | RESTful API   | Use this API to pre-check if there's any violation in the video and the shoppable content anchor |
| [Get Shoppable Video Pre-check Result ](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-WYbCdyN1ToT52TxtU3ClrUuHgkc) | RESTful API | Use this API to get video pre-check result |
| [Shoppable Video Precheck Result](https://partner.tiktokshop.com/docv2/page/arpnre1g)   | Webhook | The Video Precheck Result webhook is triggered when the Precheck Video Content API is called, and provides the results of the video’s quality assessment and violation checks. |
| [Get Shop Video Performance List](https://partner.tiktokshop.com/docv2/page/get-shop-video-performance-list-202409)   | RESTful API   | Returns overall performance metrics for all videos under a shop. This API currently provides data only for shops registered in the United States, United Kingdom, Singapore, Vietnam, and Thailand. |
| [Get Shop Video Performance Detail](https://partner.tiktokshop.com/docv2/page/get-shop-video-performance-details-202409) | RESTful API | Returns detailed performance metrics for a (requested) video. This API currently provides data only for shops registered in the United States, United Kingdom, Singapore, Vietnam, and Thailand. |
| [Get Creator Video Performance Detail ](https://bytedance.sg.larkoffice.com/docx/VkfxdgvBCoL4gMxpZJslZ8xmgcg) | RESTful API | This is a US-creator-only API for now. And it is for getting Tiktok E-commerce video metrics(including anchor_display_rate, ctr, orders, items_sold, gmv) to analysis. |
### Proposed Integration Flows 
| **Module** | **Feature** | **Use Case** | Integration Flow |
| --- | --- | --- | --- |
| Shoppable Video   | Creator Auth and deauth  > 达人授权与取消授权 | [UC-161111](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-CikMddDSIozcWSxwJ0Kl8LX7gxe)：Support creators to complete authorization or deauth for the developer's app.  > 支持达人可以完成达人授权或者解除授权。 | IF-161111.V1 |
|  | Get creator type and product info  > 获取达人类型与可带货商品     | [UC-161121](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-Xjf7dGbxeo6WVQxX3rSlolSqgmd)： Retrieve creator type.  > 获取达人类型。 | IF-161121.V1 |
|  |  | [UC-161122：](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-Xjf7dGbxeo6WVQxX3rSlolSqgmd)Retrieve products that can be promoted by the corresponding creator type (including main image, title, SKU).  > 获取对应达人类型可带货的商品（含主图、标题、SKU） | IF-161122.V1 |
|  | Upload Video   > 上传视频     | [UC-161131](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-E9SldzIRGotErGx6W4Vl6Vaqgtc)：Seller uses product images/information to generate short videos.  > 商家使用商品图片/信息生成短视频 | IF-161131.V1 |
|  |  | [UC-161132](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-HfpGdkpvYoySwOxjdTElavyFgzc)：Upload video to TikTok Shop.  > 上传视频至 TikTok Shop | IF-161132.V1 |
|  | Precheck and Publish Shoppable Videos with anchors  > 预审并发布Shoppable Video     | [UC-161141](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-TrtBdldZgo9zoCxrdt4lrx6lgCX)：Seller submits video for precheck .  > 商家提交视频进行预审. | IF-161141.V1 |
|  |  | [UC-161142](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-JqH1dpyXVogxiKxQREllX0p1gPh)：Publish shoppable video and bind product anchor.  > 发布挂车视频，绑定商品锚点 | IF-161142.V1 |
|  |  | [UC-161143](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-Rt3CdlJzXoIzzZxJvAZl7Ym4g2b)：Retrieve final result of shoppable video publishing. If it fails, obtain failure reason and provide suggestions for modification/retry.  > 获取挂车视频发布最终结果，若失败，获取失败原因并提示修改/重试。 | IF-161143.V1 |
|  |  |  [UC-161144](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-Nj6GdD2FIowNqXxyYP2ltjaBgff): Retrieve result of precheck. If the precheck fails, ISVs must block the posting action in their system to prevent the seller from uploading non-compliant content.  > 获取precheck结果。如果预审失败，服务商必须禁止商家发对应的挂车视频。 |  IF-161144.V1  |
|  |  | [UC-161145](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#V7rMdNcugo8irwxnaFTlBb3JgJh): Retrieve result of good quality check. This allows sellers to know in advance whether their video is considered high-quality and provides actionable suggestions for improvement if it is not. Even if suggestions are returned, the video can still be published; this check should not block the posting process.   | IF-161145.V1   |
|  | Shop Video performance data  > 视频数据分析     | [UC-161151](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-Y4grdqZ36oHiHdxkFtulzMgRgph)：Retrieve video performance data under the shop  > 获取店铺下的视频表现数据 | IF-161151.V1 |
|  | Associate music with the Shoppable Videos and set a cover  > 视频关联音乐和设置封面 | [UC-161161](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-KrJJdRN0XoHR5AxYiBIlpQHkgub): The Shoppable Video publishing supports video cover images. | IF-161161.V1   |
|  |  | [US-161162](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-C505denogolCDCxOG2dlq6A1gnf): Search music ****  | IF-161161.V1 |
|  |  | [UC-161163](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-Bi0adv0ZPoWE3cxgJPPl2CNVgXg): The Shoppable Video publishing supports to bind music. | IF-161162.V1 |

#### Creator Auth and deauth
##### **IF-161111.V1 Support creators to complete authorization or** **deauth for the developer's app.**

1. In the developer application, the seller can login to the creator account and complete the creator authorization either the web or mobile app.
2. Additionally, in compliance with regulations, the developer application must support the creator’s ability to revoke authorization at any time. Developers must provide an easy-to-use “revoke authorization” feature in the system, ensuring that the creator can manage their authorization status independently.
3. For more detailed instructions on how to support creator authorization, please refer to: [https://partner.tiktokshop.com/docv2/page/creator-authorization-guide](https://partner.tiktokshop.com/docv2/page/creator-authorization-guide)
> 1. 开发者应用中，商家登录自己的达人账号完成授权，可通过网页端或移动端完成账号登录与授权确认。
> 2. 同时，根据合规要求，开发者应用必须支持达人在任何时间撤销授权。开发者需在系统中提供便捷的“取消授权”功能入口，确保达人可自主管理其授权状态。
> 3. 更多如何支持达人授权的详细说明，请参考：https://partner.tiktokshop.com/docv2/page/creator-authorization-guide

UI suggestions：
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/5e8fde9a94ba43b5b8be4439279d38eb~tplv-k9wyc2ijk0-image.image)

| **API/Notification name** | **type** | **description** |
| --- | --- | --- |
| [Get Access Token](https://partner.tiktokshop.com/docv2/page/authorization-overview-202407) | RESTful API | Use this API to request an `access_token` and `refresh_token` |
#### Get creator type and product info
##### **IF-161121.V1 Retrieve Creator Type**

1. The seller can select the creator to be authorized within the developer’s application and display the corresponding creator type. The range of products a creator can promote varies based on their type.
2. The seller can use the `user_type` field in the **Get Creator Profile** response to filter creators by type:
   * `TIKTOK_SHOP_OFFICIAL_ACCOUNT` represents the seller's official account
   * `TIKTOK_MARKETING_ACCOUNT` represents the seller's marketing account
   * `TIKTOK_SHOP_CREATOR` represents the affiliate creator
> 1. 商家可在开发者的应用内选择需要授权的达人并展示达人对应的类型，不同类型的达人可以带货的商品范围是不同的。
> 2. 可以通过Get Creator Profile 中 user_type的出参来支持商家筛选达人类型
>    * TIKTOK_SHOP_OFFICIAL_ACCOUNT代表商家官方号
>    * TIKTOK_MARKETING_ACCOUNT代表商家渠道号
>    * TIKTOK_SHOP_CREATOR代表联盟达人

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/23f5f2fedf3a4338ac8f149765afc190~tplv-k9wyc2ijk0-image.image)
API/Notification Overview
| **API/Notification name** | **type** | **description** |
| --- | --- | --- |
| [Get Creator Profile](https://partner.tiktokshop.com/docv2/page/get-creator-profile-202508) | RESTful API | Use this API to get the creator's profile information. |
##### **IF-161122.V1 Retrieve products that can be promoted by the corresponding creator type (including main image, title, SKU)**

1. Support the seller in selecting products that can be promoted by the corresponding creator type:
   * If the creator is a `TIKTOK_MARKETING_ACCOUNT`/, `TIKTOK_SHOP_OFFICIAL_ACCOUNT`the seller needs to call the **Get Shop Products** API to retrieve the product information that the creator can promote.
   * If the creator is a `TIKTOK_SHOP_CREATOR`, the seller needs to call the **Get Showcase Products** API to retrieve the product information from the creator's showcase.
2. The application can display the basic product information, such as product name, main image, etc., based on the product information returned by the API. This enhances the efficiency and experience for the seller when selecting products.
> 1. 支持商家选择达人对应类型可带货的商品
>    * 如果是`TIKTOK_MARKETING_ACCOUNT`/, `TIKTOK_SHOP_OFFICIAL_ACCOUNTT`，则需要通过调用Get Shop Products接口获取该达人可以带货的商品信息。
>    * 如果是TIKTOK_SHOP_CREATOR，则需要调用Get Showcase Products接口获取该达人showcase橱窗内的商品信息，如果added_status不是ADDED则代表商品未加入到橱窗，可以通过调用Add Showcase Products接口将商品添加到橱窗。
> 2. 可在应用中通过接口返回的商品信息对应展示商品的基础信息例如商品名称、主图等，提升商家选择商品的效率和体验

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/71b39d864a314d9abed26f8b8f2c5d26~tplv-k9wyc2ijk0-image.image)
Note

1. In **Get Showcase Products**, please ensure the product status meets the following conditions:
* `inventory_status`: `IN_STOCK`
* `review_status`: `"APPROVED"`
* `is_hidden`: `false`
* `added_status`: `ADDED`
> 1. 在Get Showcase Products中，请关注商品的状态满足以下条件：
>    *  inventory_status: IN_STOCK,
>    *  review_status: "APPROVED",
>    *  is_hidden: false,
>    *  added_status: ADDED
> 2. 在Get Shop Products，请关注商品的状态，请关注商品的状态满足以下条件：
>    * added_status：ADDED

| **API/Notification name** | **type** | **description** |
| --- | --- | --- |
| [Get Shop Products](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-Fu3idMqnqoqwTixg2lklALotgSG) | RESTful API | Developers can utilize this API to search and retrieve product information of shops which is bound by a specific creator with specific keywords. |
| [Get Showcase Products](https://partner.tiktokshop.com/docv2/page/get-showcase-products-202405#Back%20To%20Top) | RESTful API   | This API lists the products in the creator's showcase, paginated by specified page size and iterated through pages by page token for up to 2000 products in the showcase. This API is generally used when a creator would like to view the products in the showcase. The platform will return the product details in the showcase, as well as the products in the livebag if the creator is live streaming. |

#### Upload Video 
##### **IF-161131.V1 Seller uses product images/information to generate short videos**

1. The seller can use the developer's application to automatically or semi-automatically generate short video content based on the product’s main image, title, SKU, and other information.
2. During the video generation process, it is necessary to comply with TikTok Community Guidelines and the TikTok Shop Short Video Official Guidelines. Please ensure that the content is compliant and meets the platform's quality video standards. The generated video will later be uploaded and published through the Post Shoppable Video API.
> 1. 商家可通过开发者的应用基于商品的主图、标题、SKU 等信息自动化或半自动化生成短视频内容
> 2. 在视频生成过程中需遵守 TikTok社区规范 和 TikTokShop 短视频官方指南，请确保素材内容合规并且符合平台优质视频规范。生成的视频将在后续通过 Shoppable Video API 上传并发布。

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/b5c1fd06ad234d94839509f6d57a2323~tplv-k9wyc2ijk0-image.image)
Notes

1. Video specifications
   * Supported formats: MP4, MOV, MKV, WMV, WEBM, AVI, 3GP, FLV, MPEG
   * Max video size: 100 MB
   * Video aspect ratio: 9:16 to 16:9
   * Resolution: HD 720p or higher
   * Duration: >30 seconds
> 1. 视频格式规范
>    * 支持格式：MP4、MOV、MKV、WMV、WEBM、AVI、3GP、FLV、MPEG
>    * 最大文件大小：100 MB
>    * 视频宽高比：9:16 至 16:9（推荐 9:16）
>    * 视频时长：建议 >30 秒
>    * 分辨率：推荐 720p 及以上

| **API/Notification name** | **type** | **description** |
| --- | --- | --- |
| [Get Creator Profile](https://partner.tiktokshop.com/docv2/page/get-creator-profile-202508) | RESTful API | Use this API to get the creator's profile information. |
| [Get Shop Products](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-Fu3idMqnqoqwTixg2lklALotgSG) | RESTful API | Developers can utilize this API to search and retrieve product information of shops which is bound by a specific creator with specific keywords. |
| [Get Showcase Products](https://partner.tiktokshop.com/docv2/page/get-showcase-products-202405#Back%20To%20Top) | RESTful API   | This API lists the products in the creator's showcase, paginated by specified page size and iterated through pages by page token for up to 2000 products in the showcase. This API is generally used when a creator would like to view the products in the showcase. The platform will return the product details in the showcase, as well as the products in the livebag if the creator is live streaming. |
#####  **IF-161132.V1 Upload video to TikTok Shop.**

1. Before the seller officially publishes the shoppable video, they MUST first call the **Upload Video File** API to upload the video file to the TikTok Shop platform and obtain a unique `file_id`. This `file_id` will be a required parameter for subsequent video publishing.
2. The current upload API does not support modifying an already uploaded video. If the video content needs to be adjusted, it must be regenerated and re-uploaded.
> 1. 在商家正式发布挂车视频之前，必须先调用 Upload Video File 接口，将视频文件上传至 TikTok Shop 平台，并获取一个唯一的 `file_id`。该 `file_id` 将作为后续 **视频发布的**必要入参。
> 2. 目前上传接口不支持对已上传的视频进行修改，如需调整视频内容，必须重新生成并再次上传。

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/bece427c7d684f1fbab16edf1d3ff634~tplv-k9wyc2ijk0-image.image)
**Note**

1. Successfully uploading a video file does **not** guarantee that the shoppable video will be published. If the video does not comply with platform policies, it may still fail during the shoppable video review stage.
2. The upload API response includes the field `video_file.md5` (the MD5 checksum of the uploaded file). The developer’s system can calculate the MD5 of the local file before uploading and compare it with the returned value to:
   * Verify that the uploaded file is identical to the local file, preventing file corruption caused by network instability.
   * Ensure file uniqueness when implementing resumable uploads or idempotent uploads.
> 1. 上传视频文件成功不代表一定能发布挂车视频，如不符合平台规范仍会在挂车视频审核环节失败。
> 2. 上传接口返回结果中包含 `video_file.md5` 字段（上传文件的 md5 校验值）。服务商系统可在上传前自行计算本地文件的 md5，与返回值比对。用于：
>    * 确认上传文件与本地文件一致，避免因网络抖动导致的文件损坏；
>    * 做断点续传/幂等上传时的文件唯一性校验。

| **API/Notification name** | **type** | **description** |
| --- | --- | --- |
| [Upload Shoppable Video File](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-EEPudRjSEorRmIxMSX6lFIL8gih)    **Note**: When using [Upload Shoppable Video File](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-EEPudRjSEorRmIxMSX6lFIL8gih) API,  if video ≥ 10mb, must follow [Shoppable Video Large File Upload Solution](https://bytedance.sg.larkoffice.com/docx/WTMvdfbTBo30Fex0r9YlYstGg0d?from=from_parent_docx) | RESTful API | Use this API to upload the video before posting to TikTok   |
#### Precheck and Publish Shoppable Videos with anchors
##### **IF-161141.V1 Seller submits video for precheck** 

1. Before the seller publishes the shoppable video, the service provider must ensure the video content meets the following requirements:
   * [Baseline Principle] **TikTok Community Guidelines**: The video must comply with the platform's community rules, otherwise corresponding penalties for violations will be applied.
   * [Baseline Principle] **TTS E-commerce Platform Governance Rules**: The video must not involve prohibited products, improper displays, or any content that violates e-commerce governance rules, otherwise corresponding penalties for violations will be applied.——**✅API supported**
   * [Strong Recommendation] **High-Quality Video Guidelines**: The platform encourages videos to meet high-quality video standards. High-quality videos will receive more GMV benefits.
2. **Precheck API**

 We now provide the capability to support ISVs call the **Pre-check API** to verify whether the video content complies with **TTS E-commerce Governance Rules**. This helps prevent policy violations before posting.

   * We have **Quota Management** of  **Pre-check API**：
      * Each creator account has a **50/daily precheck quota limit.** Quota management for the Pre-check API is **configured independently** from non-API channels.For example, if a creator has **50 precheck quotas** available today for non-API channels (e.g., Seller Center or App posting), they will have a **separate 50 quota as** for API-based prechecks. Usage in one channel does **not affect** the quota in the other channel.
      * Once the quota is exhausted, no new precheck tasks can be initiated.
      * Each API call that successfully creates a **precheck task** consumes one quota. If the same video (file_id) is prechecked multiple times, multiple tasks will be generated — each consuming one quota.

⚠️ **Important Notes**

* It will **not** determine whether the video is **high-quality**, nor verify compliance with **TikTok Community Guidelines**.
3. ISVs need to design the necessary precheck capabilities in the system to further ensure video compliance and content quality beyond the platform's checks.
> 1. 在商家发布挂车视频之前，服务商需确保视频内容满足以下要求：
>    * **[底线原则] TikTok Community Guidelines（TikTok 社区规范）**：视频必须符合平台的社区规则，否则将作出对应违规处罚
>    * **[底线原则] TTS 电商平台治理规则**：视频不得涉及违规商品、违规展示或其他违反电商治理的内容，否则将作出对应违规处罚。
>    * **[强烈推荐] 优质视频规则**：平台鼓励视频满足优质视频标准，优质视频将会获得更多的GMV收益。
> 2. **预审接口已提供**

> 我们现已提供 **预审接口（Pre-check API）**，支持 ISV 在视频发布前调用接口，验证视频内容是否符合 **TTS 电商治理规则（TTS E-commerce Governance Rules）**。接口会帮助商家在视频发布前识别违规风险，防止内容违规。

> * **预审接口的配额管理**：
>    * 每个创作者账号每日拥有50次预审配额。预审的配额在API渠道和非API渠道独立配置，互不影响。例如，如果创作者今天在非API渠道有50个配额，那么在API渠道也会有50个配额，两个渠道之间的配额 **不会互相抵扣或影响。**
>    * 当日配额使用完毕后，将无法发起新的预审任务。建议在系统中做好必要提示。
>    * 每一次成功创建 **预审任务（precheck task）** 的 API 调用会消耗一次配额。如同一个视频（`file_id`）被多次预审，将生成多个任务，每次调用都会消耗一次配额。
> 3. 服务商在系统中需要设计必要的预审检查能力，以便在平台校验之外，进一步保障视频合规性与内容质量。

> 
> Please refer to the following three documents for more details:

> 1. **[Baseline Principle] TikTok Community Guidelines**: [Community Guidelines](https://www.tiktok.com/community-guidelines/en/overview)
> 2. **[Baseline Principle] TTS 电商平台治理规则：**[✨Creator Policy Pulse (August 2025)✨](https://seller-us.tiktok.com/university/essay?knowledge_id=7096334743553838&from=new-and-updated&role=1&identity=1)
> 3. **[Strong Recommendation] High-Quality Video Guidelines**

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/59eb6d23a22f4af89e65ce6b4759f08e~tplv-k9wyc2ijk0-image.image)

| **API/Notification name** | **type** | **description** |
| --- | --- | --- |
| Pre-check Shoppable Video  | RESTful API | Use this API to pre-check if there's any violation in the video and the shoppable content anchor |
| Get Shoppable Video Pre-check Result  | RESTful API | Use this API to get video pre-check result |
| Shoppable Video Precheck Result | Webhook | Notice the developer about the video pre-check result |
##### **IF-161142.V1 Publish shoppable video and bind product anchor**

1. Before the seller can publish a shoppable video, the developer's application must support the seller in providing the following information within the app. Only after completing these fields can the video be submitted for publishing: 
   * **Caption (`caption`):** The video's title and description. Supports hashtags `#` and user mentions `@` to help improve video distribution and exposure.
   * **Video File ID (`file_id`):** Returned from the **Upload Video File** API, serving as the unique identifier for the video.
   * **Associated Product (`product_id`):** Retrieved via the **Get Shop Products** or **Get Showcase Products** API, used to bind the product anchor to the video.
   * **Anchor Title (`anchor_title`):** The text displayed in the shoppable anchor position, helping users quickly understand the product's key selling point.
   * **AI-generated Flag (`video_info.is_ai_generated`):** Optional boolean indicating whether the submitted video is AI generated. Set it to `true` for AI-generated content so the published post displays an AI-generated label. If omitted, it defaults to `false`.
> 1. 商家在发布挂车视频前，开发者应用需要支持商家在应用中填写以下信息，完成后才可以提交发布挂车视频。 
>    * **视频文案（caption）**：作为视频的标题与说明，支持包含话题标签 `#` 和用户提及 `@`，有助于视频分发与曝光。
>    * **视频文件 ID（file_id）**：来自于上传接口返回结果，是视频的唯一标识。
>    * **关联商品（product_id）**：从「Get Shop Products」或「Get Showcase Products」接口获取，用于将商品锚点绑定到视频中。
>    * **商品锚点文案（anchor title）**：展示在挂车位的标题，帮助用户快速理解商品卖点。
>    * **AI 生成内容标识（video_info.is_ai_generated）**：可选布尔字段，用于声明提交的视频是否由 AI 生成。AI 生成内容应传 `true`，发布后的帖子会展示 AI-generated 标签；字段省略时默认为 `false`。

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/fa92ac11f0294846aad91e23da902f6f~tplv-k9wyc2ijk0-image.image)
After calling `Post Shoppable Video`, the API may return `data.video.quota` together with `data.video.id`. Developers should parse `quota` when present and display a friendly content-posting quota message. If `quota` is omitted, no quota restriction applies and the omission should not be treated as an error.
> 调用 `Post Shoppable Video` 后，接口可能随 `data.video.id` 返回 `data.video.quota`，用于提示创作者当前内容发布配额。字段存在时建议展示友好提示；字段未返回时表示当前无适用配额限制，不应按错误处理。

Note

1. **Required Fields for Shoppable Video**
   * **`video_info.file_id`**: The file ID returned from the upload API.
   * **`video_info.title`**: The video caption/title, up to 4000 characters. Supports hashtags `#` and user mentions `@`.
   * **`tts_anchor_info.product_id`**: The product ID that needs to be anchored to the video.
   * **`tts_anchor_info.title`**: The product anchor displays title, no more than 30 characters, and cannot contain punctuation or emojis.
2. **Content Compliance**
   * Both the video caption and anchor title must comply with the **TikTok Community Guidelines** and **TikTok Shop Video Policies**.
   * The product must be an eligible product for promotion and must remain relevant to the video content.
3. **Quota for the number of shoppable videos that can be posted**
   * Different TikTok accounts have different quotas. Please read the policy seller academy. For example, [US local sellers' policy](https://seller-us.tiktok.com/university/essay?knowledge_id=6939143037667118#posting-limits-for-shoppable-content-us-)
> 1. **挂车视频必填字段**
> * `video_info.file_id`：上传接口返回的文件 ID。
> * `video_info.title`：视频标题/文案，最长 4000 个字符，支持 `#` 和 `@`。
> * `tts_anchor_info.product_id`：需要挂载的商品 ID。
> * `tts_anchor_info.title`：商品锚点展示文案，不超30个字符，不能带标点和emoji。
> 2. **内容合规**
> * 视频文案与锚点文案需符合 TikTok 平台社区规范和电商视频规范
> * 商品必须是可带货商品，且与视频内容保持相关性。
> 3. **挂车短视频发布量限制**
> * 不同账号有不同的限制。请阅读商家大学的政策，以[美国跨境商家大学的政策](https://seller.tiktokshopglobalselling.com/university/essay?knowledge_id=2564695663953681&shop_region=us&identity=1&anchor_link=EC4200CA)为例

| **API/Notification name** | **type** | **description** |
| --- | --- | --- |
| [Post Shoppable Video](https://partner.tiktokshop.com/docv2/page/post-shoppable-video-202607#Back%20To%20Top)   | RESTful API | Use this API to publish the video. Set `video_info.is_ai_generated` when applicable; it defaults to `false` when omitted. The response may include `data.video.quota`. |
##### **IF-161143.V1 Retrieve final result of shoppable video publishing. If it fails, obtain failure reason and provide suggestions for modification/retry.**

1. After the seller submits a shoppable video via the **Post Shoppable Video API**, a `video_id` will be returned. The final publishing status (success / failure / processing) can be obtained in two ways:
   * **Active Query (GET)**: The developer application can periodically call the query API with the `video_id` to retrieve the latest status. This API only returns the publishing result of the video.
   * **Webhook Push**: When the publishing status changes, the platform will send an event to the callback URL configured by the developer application. The webhook provides both the publishing result and a set of failure reason enums. Developers can then guide the seller to modify the video and retry based on the returned result and failure reason.
> 1. 商家通过 Post Shoppable Video **** API **** 提交发布后，会获得一个 `video_id`。最终的发布状态（成功 / 失败 / 处理中）可以通过以下两种方式获取：
>    * **主动查询（GET）**：开发者应用可定期调用查询接口，根据 `video_id` 获取最新状态。该接口仅返回视频的发布结果。
>    * **Webhook 推送**：当视频发布状态发生变更时，平台会向开发者应用配置的回调地址推送事件。该 webhook 不仅包含视频发布结果，还会返回失败原因的枚举值。开发者可根据返回的结果和失败原因，引导商家修改视频并重新提交。

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/510cb271f1014bc49ba32f3b9de7d28c~tplv-k9wyc2ijk0-image.image)
**Note**

1. Once the publish API is called, the `file_id` is consumed and cannot be reused, even if the video is not successfully published.
> 1. 当调用了发布接口，代表 `file_id` 已被消费不能再次使用。

| **API/Notification name** | **type** | **description** |
| --- | --- | --- |
| [Get Shoppable Video Status](https://partner.tiktokshop.com/docv2/page/get-shoppable-video-status-202509) | RESTful API | Use this API to get video publish result |
| ~~Video Publish Result~~ | ~~Webhook~~ | ~~Notice the developer about the video publishing result and fail reasons~~ |
#####  **IF-161144.V1 Retrieve result of precheck. If the precheck fails, ISVs must block the posting action in their system to prevent the seller from uploading non-compliant content.**

* **Strong Block Logic: If** the precheck fails, ISVs **must block** the posting action in their system to prevent the seller from uploading non-compliant content. The system should clearly display the precheck result — including **result, risk , suggestions.**
* The precheck API will only return the result of whether the video complies with **TTS e-commerce governance rules and** cannot fully guarantee that the video will always comply with platform policies, as **TTS governance and content policies are subject to dynamic updates**

> * **强阻断逻辑**：当预审未通过时，ISV **必须在系统中阻断** 商家的发文操作，防止商家上传不合规的视频。

>  系统需清晰展示预审结果，包括 **result**、**risk**、**suggestions**，并提示警告信息，例如：“您的视频不符合平台规范，无法发布”

> * 预审接口仅会返回视频是否符合 **TTS 电商治理规则（TTS e-commerce governance rules）** 的结果，

> **无法完全保证** 视频始终符合平台的所有合规政策要求，因为 **TTS 的治理规则和内容政策会动态更新**。

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/fa399a54e62b41eabe59bc1409570437~tplv-k9wyc2ijk0-image.image)
| **API/Notification name** | **type** | **description** |
| --- | --- | --- |
| [Pre-check Shoppable Video ](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-GEyCdCNhGoAZ5TxbVetli7SbgLc) | RESTful API | Use this API to pre-check if there's any violation in the video and the shoppable content anchor |
| [Get Shoppable Video Pre-check Result ](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-WYbCdyN1ToT52TxtU3ClrUuHgkc) | RESTful API | Use this API to get video pre-check result |
| [Shoppable Video Precheck Result](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-NdUqdt1ACoNmxvx5VdYlYr7xgUf) | Webhook | Notice the developer about the video pre-check result |
#####  IF-161145.V1 Retrieve result of good quality check
**Disclaimer**
Pre-check results are for reference only guarantee the final outcome after public performance is also affected by TikTok Shop policies, account status,and other factors. The platform's suggested content may be updated in real-time as policies adjust, so please refer to the latest returned results.
> **免责声明**
> 预检查结果仅供参考，无法保证公开视频后的最终审核结果。最终结果还可能受到 TikTok Shop 平台政策、账号状态及其他因素的影响。平台的建议内容可能会随着政策调整而实时更新，请以最新返回的结果为准。

1. ISV can call the **Get Shoppable Video Pre-check Result** API and subscribe to the **Shoppable Video Precheck Result** webhook to obtain the "good quality check" result. This allows sellers to know in advance whether their video is considered **high-quality** and **provides actionable suggestions for improvement** if it is not. Even if suggestions are returned, the video can still be published; this check should not block the publishing process.
2. **Timing**: This API should only be called after uploading the video file (obtaining a `file_id`) and before executing the "post shoppable video" action. This avoids misuse in other scenarios.
3. **Quota Management**:
   1. The **Good Quality Check** supports up to **50 checks per creator account per day**, and this quota is shared with qualified checks.
   2. If the quota is exceeded, the API will return an error. Error will be：`The creator account has reached the daily limit for pre-checks. Please try again tomorrow`Developers should handle this by providing a user-friendly prompt.
4. **Applicability**
   1. The Good quality check is currently available **only for the US region**. 
   2. It applies to videos published by **seller official accounts and affiliate creator accounts**.
> 1. ISV 可以调用 **Get Shoppable Video Pre-check Result API** 并订阅 **Shoppable Video Precheck Result webhook** 来获取「**优质检查（good quality check）​**」结果。

>  这可以帮助卖家提前了解其视频是否被认为是高质量内容；如果未通过，也会返回可执行的优化建议。即使返回了建议，视频**仍然可以发布**，该检查**不应阻塞发布流程**。

> 2. **调用时机**：

>  该 API **仅应在视频文件上传完成（已获得** **`file_id`）之后、执行 “post shoppable video” 操作之前调用**，以避免在其他场景下被误用。

> 3. **配额管理**：
>    1. 「**优质检查（Good quality check）​**」对每个创作者账号**每日最多支持 50 次检查，并且次数与合格检查共享**。
>    2.  当超出配额时，API 将返回错误信息：`The creator account has reached the daily limit for pre-checks. Please try again tomorrow`开发者应对此进行处理，并向用户提供**友好的提示信息**。
> 4. **适用范围：**
>    1. 「优质检查（Good quality check）」目前**仅在 US 地区生效**，其他地区暂不支持。
>    2. 该能力适用于**商家达人账号及联盟达人账号发布的视频**；

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/33a8d0d2810b479db28bbd21f3185a95~tplv-k9wyc2ijk0-image.image)
**API/Notification Overview**
| **API/Notification name** | **type** | **description** |
| --- | --- | --- |
| [Precheck Video Content](https://partner.tiktokshop.com/docv2/page/precheck-video-content-202511) | RESTful API | Use this API to pre-check if there's any violation in the video and the shoppable content anchor |
| [Get Shoppable Video Pre-check Result ](https://partner.tiktokshop.com/docv2/page/get-shoppable-video-precheck-result-202601) | RESTful API | Use this API to get video pre-check results, including the good quality check outcome. |
| [Shoppable Video Precheck Result](https://partner.tiktokshop.com/docv2/page/arpnre1g) | Webhook   | Notice the developer about the video pre-check result, including the good quality check outcome. |
#### Shop Video performance data
##### IF-161151.V1 Retrieve video performance data under the shop

1. It is necessary to support the seller in completing shop data authorization, and the authorization type for posting shoppable videos is different. [Check how to do seller auth](https://partner.tiktokshop.com/docv2/page/seller-authorization-guide#Authorization%20in%20development%20stage)
2. Supports the seller in viewing video performance data within the application. The seller can view the performance of all videos in the shop or a specific video, including core business metrics and engagement data, to help evaluate the video’s effectiveness and user engagement.
3. Supported Data:
   1. **Core Business Metrics**:
      * `gmv.amount` 
      * `click_through_rate` 
      * `daily_avg_buyers` 
      * `views` 
   2. **Engagement Data**:
      * `likes`
      * `shares` 
      * `xcomments` 
      * `views` 
> 1. 需要支持商家完成店铺数据授权，和posting shoppable video的接口的授权类型不同。[Check how to do seller auth](https://partner.tiktokshop.com/docv2/page/seller-authorization-guide#Authorization%20in%20development%20stage)
> 2. 支持商家在应用中查看视频表现数据。商家可以查看店铺所有视频或某个特定视频的表现，包括核心经营指标和互动数据，帮助评估视频效果和用户参与度。
> 3. **支持的数据**
>    1. **核心经营指标**：
>       * GMV（成交金额）；
>       * CTR（点击率）；
>       * 日均买家数（daily_avg_buyers）；
>       * 观看量（views）。
>    2. **互动数据**：
>       * 点赞总数（likes）；
>       * 分享总数（shares）；
>       * 评论总数（comments）；
>       * 播放总数（views）。

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/8e3bc9599ea649799a885363becc8f69~tplv-k9wyc2ijk0-image.image)
Note：

| **API/Notification name** | **type** | **description** |
| --- | --- | --- |
| [Get Shop Video Performance List](https://partner.tiktokshop.com/docv2/page/get-shop-video-performance-list-202409)   | RESTful API   | Returns overall performance metrics for all videos under a shop. This API currently provides data only for shops registered in the United States, United Kingdom, Singapore, Vietnam, and Thailand. |
| [Get Shop Video Performance Detail](https://partner.tiktokshop.com/docv2/page/get-shop-video-performance-details-202409) | RESTful API | Returns detailed performance metrics for a (requested) video. This API currently provides data only for shops registered in the United States, United Kingdom, Singapore, Vietnam, and Thailand. |
| [Get Creator Video Performance Detail ](https://bytedance.sg.larkoffice.com/docx/VkfxdgvBCoL4gMxpZJslZ8xmgcg) | RESTful API | This is a US-creator-only API for now. And it is for getting Tiktok E-commerce video metrics(including anchor_display_rate, ctr, orders, items_sold, gmv) to analyze. |
#### Associate music with the Shoppable Videos and set a cover
##### IF-161162.V1 The Shoppable Video publishing supports video cover images.

1. When publishing a shoppable video, merchants can set a custom cover to improve content attractiveness. To do this, developers can provide one of the following when calling the API:
   * **Cover Image URI (`cover_uri`)**: Pre-upload an image using the `Upload Shoppable Photo File` API and use the returned `uri` as the video cover.
   * **Cover Timestamp (`cover_timestamp_ms`)**: Specify a timestamp (in milliseconds) in the video. The system will capture the frame at this exact moment to use as the cover.
2. Developer applications must clearly inform merchants of the priority for these two options:
   * If both `cover_uri` and `cover_timestamp_ms` are provided, the system will prioritize `cover_uri` for the cover.
   * If neither is provided, the system will default to using the first frame of the uploaded video as the cover.
> 1. 在开发者应用中，商家发布可购物视频（Shoppable Video）时需要能够设置视频的封面，以提升内容的吸引力。为满足此需求，商家在调用接口时可提供以下任一信息：
>    * **封面图片 URI (`cover_uri`)**：通过 `Upload Shoppable Photo File` 接口预先上传一张图片，并将其返回的 `uri` 作为视频封面。
>    * **封面时间戳 (`cover_timestamp_ms`)**：指定视频中的一个具体时间点（以毫秒为单位），系统将截取该时间点的视频帧作为封面。
> 2. 开发者应用需明确告知商家两种设置方式的优先级：
>    * 如果同时提供了 `cover_uri` 和 `cover_timestamp_ms`，系统将优先采用 `cover_uri` 作为封面。
>    * 如果两者均未提供，系统将默认使用已上传视频的第一帧作为封面。
> * 封面内容（无论是上传的图片还是视频截图）必须遵守 **TikTok 社区规范**与 **TikTok Shop 电商视频政策**。

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/112607dc28ec43ce9b4fb555050f4a56~tplv-k9wyc2ijk0-image.image)
| **API/Notification name** | **Type** | **Description** |
| --- | --- | --- |
| [Post Shoppable Video](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-TV8qdaPDLo49yxxamEblRomKgMh) | RESTful API | Use this API to publish the video with a specified cover. |
| [Upload Shoppable Photo File](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#IGBzdu65Ao0Urdxqj00lPH69gPo) | RESTful API | Use this API to upload a photo file and get its URI for the cover. |
##### IF-161161.V1 Search music **** 
Before merchants publish shoppable video content, developer applications can support merchants in searching for music by entering **keywords** within the app. The searched music can be played and directly used in subsequent shoppable posting steps. **All music retrieved through the API query is authorized for E-commerce use and can be directly applied without risk of violation.**

* **Music ID (music_id)**: The unique ID associated with the searched music, which can be directly used in subsequent shoppable posting steps.
* **Keyword (keyword)**: The search term entered by the user, used to match music titles or authors.
* **Language (language)**: Supports defining the response language, such as English.
* **Play URL (play_url)**: The returned playback URL, which supports playing the music.

> 在商家发布挂车内容前，开发者应用可以支持商家在应用中通过输入关键词搜索音乐，搜索到的音乐支持播放，可以在后续挂车步骤中直接使用。**接口查询获取的音乐均为有电商权限的音乐，可直接使用，无违规风险。**

> * **音乐 ID (music_id)**：搜索到的音乐关联的唯一 ID，在后续挂车步骤中可直接使用。
> * **关键词 (keyword)**：用户输入的搜索词，用于匹配音乐名称或作者。
> * **语言 （language）**：支持定义返回语言，例如英语等。
> * **播放链接(play_url)**:返回的播放链接，支持播放音乐。

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/53d2c47d70314806ae59cb6745faeb1e~tplv-k9wyc2ijk0-image.image)
| **API/Notification name** | **type** | **description** |
| --- | --- | --- |
| [Search Music](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-Spk6d6AHuoE3Oix24Nslptczgkb) | RESTful API | Recommend music information based on keywords. Search Music is available globally across supported TikTok Shop markets. Use the `region` and `language` query parameters to localize results. |
##### IF-161163.V1 The Shoppable Video publishing supports Binding music.

1. When publishing a shoppable video, merchants can add background music (BGM) to enhance the video's appeal and engagement.
   * Merchants must specify the desired music using a `music_id` within the application.
   * If the video is linked to background music, the original video audio will be overridden by the music.
> 1. 在开发者应用中，商家发布可购物视频（Shoppable Video）时，可以为视频关联一段背景音乐（BGM），以增强视频的趣味性和传播效果。
>    * 商家需要在应用内通过 `music_id` 来指定所需的音乐。
>    * **如果视频关联音乐，那么视频原声（包含口播）会被音乐覆盖**

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/bf901f4209bd46f4a0d82b493ff3cb7a~tplv-k9wyc2ijk0-image.image)

| **API/Notification name** | **Type** | **Description** |
| --- | --- | --- |
| [Post Shoppable Video](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-TV8qdaPDLo49yxxamEblRomKgMh) | RESTful API | Use this API to publish the video with specified background music. |
| [Search Music](https://bytedance.sg.larkoffice.com/docx/Os8tdPkaVo2QFBxhSRIlQwBAg9f#share-Spk6d6AHuoE3Oix24Nslptczgkb) | RESTful API   | Use this API to search for licensed music and obtain a valid `music_id`. Search Music is available globally across supported TikTok Shop markets; use the `region` and `language` query parameters to localize results. |
### Appendix
### **FAQs**
| Can a video still receive violation warnings after publishing, even if the Video pre-check API found no issues before posting? | Yes, it is possible. Pre-check results are for reference only and do not guarantee the final outcome after publication.  |
| --- | --- |
| If a video passes the Video pre-check review, does it guarantee good performance? | No, pre-check results are for reference only and do not guarantee the final outcome after publication. Video performance is affected by multiple factors, including TikTok Shop content policies, account status, content quality and more.  |
| How many pre-checks can seller conduct per day via API? | Sellers have at least 2 pre-checks per day. The number of pre-checks available may vary based on seller performance.  |
| What happens if a creator’s account type is both Marketing Account and Affiliate Creator in the Get Creator Profile API response? | In cases where a creator's account type is both Marketing Account and Affiliate Creator, the Get Creator Profile API will return `Marketing Account` to the `type` field.  |
| If account A uploads a video and receives a file_id, can this file_id be used to publish the video through account B? | No, the file_id returned by the Upload Video API for account A cannot be used by account B to publish the video. The file_id is specific to the account under which the video was uploaded. Each account has its own unique session for video uploads, and the file_id generated is tied to that session. |
| [What are the functions of TikTok Shop official account?](https://seller-us.tiktok.com/university/essay?knowledge_id=5643789953599275&identity=1&anchor_link=EBCE00CE) | Once the TikTok account is linked as the TikTok shop's official account, it will be the main representative of your shop on TikTok. The products in your shop will be automatically synchronized to the Shop Page. The Shop Page will also act as the central page for product display and promotions.    * **Accumulate store fans and increase repurchase rate**     * After binding the store's official TikTok account, the official account and the store's fan user group can be connected. After users follow your store's official TikTok account, they can easily find your store's entrance on the account's profile page through the store's official TikTok account, helping the store to attract traffic and increase the repurchase rate.  * **Improve store exposure and precipitate traffic**     * Users can easily search for products in your store through TikTok's search function, and add a new store page entry for the whole link of sales in the live broadcast room to help your products and stores gain more exposure on TikTok. |
| [What are the rules for the official TikTok Shop account?](https://seller-us.tiktok.com/university/essay?knowledge_id=5643789953599275&identity=1&anchor_link=EBEB00CD) | * Each shop can only be bound to one official account.  * The shop name and the bound official account's name must be consistent after upgrade, and when the store name is modified, the official account name will be changed simultaneously. Please be careful when changing the shop name.  * The official account can be unbound once **24 hours after the official account is successfully bound. Please note official account can only be unlinked 3 times**；  * The account region needs to be the same as the shop region.  * The same account cannot be bound as the official account and marketing account of the same store at the same time.  * The account can only sell the product from their own shop and fail to participate in the affiliate program. If sellers want to participate in affiliate, they can use their marketing account or creator account to apply for permission.  |
| [How to bind TikTok Shop official account?](https://seller-us.tiktok.com/university/essay?knowledge_id=5643789953599275&identity=1&anchor_link=EC0800CC) | Check details in the link |
### APIs
#### [GET] Get Shop Products
##### Summary
| Type | Value |
| --- | --- |
| API Name | Get Shop Products |
| API Version | 202509 |
| API URI ( Fixed for all APIs ) | Host: open-api.tiktokglobalshop.com  Schemes: HTTPS |
| API Path | /affiliate_creator/:version/shop_products |
| API Method | GET |
| API Function Description | Developer can utilize this API to search and retrieve products information of shop which is bound by a specific creator with specific keywords. |
##### Request Parameters
###### Query
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| app_key | string | true | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | true | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders.  |
| timestamp | int64 | true | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| title_keyword | string | false | apple | The title keyword of the product you wish to search by. |
| sort_field | string | false | PRODUCT_ID | Sort fields include PRODUCT_ID, PRICE and SALE. If sort_field is empty or invalid, PRODUCT_ID will be set as default. |
| sort_order | string | false | DESC | Sort orders include DESC and ASC. If sort order is empty or invalid, DESC will be set as default. |
| page_size | int32   | true | 20 | Pagination count determines how many products you'll get after sending the request. 20 is a recommended number.  Valid Range: [1-20] |
| page_token | string | false | b2Zmc2V0PTAK | The pagination offset that determines where you begin your search. If you are making your first request, this will be empty. |
###### Headers
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| x-tts-access-token | string | true | 29a39d | The creator access_token value from [Get Access Token](https://partner.tiktokshop.com/docv2/page/678e3a3292b0f40314a92d75#Get%20Access%20Token%20API), when user_type = 1. Follow this [guide](https://partner.tiktokshop.com/docv2/page/678e3a362dccb8030ea6f98c) to get creator access_token. |
| content-type | string | true | application/json | Allowed type: application/json |
###### Body(Not applicable for GET/DELETE)
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
**Request body example:**
```JSON
{}
```

##### Response Parameters
| Properties |  |  |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- | --- | --- |
| code |  |  |  | int32 | 0 | The success or failure status code returned in API response. |
| message |  |  |  | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id |  |  |  | string | 202203070749000101890810281E8C70B7 | Request log |
| data |  |  |  | object |  | Specific return information |
| > | products |  |  | []object |  | The searched product list. It will be empty when there are no search results. |
| > | > | id |  | string | 1729592969712207012 | TikTok product ID. |
| > | > | title |  | string | testcase autotest Live Product | Product name. |
| > | > | price |  | object |  | Product price shown with two decimal places and currency. |
| > | > | > | amount | string | 56.00 | Product price with two decimal places. |
| > | > | > | currency | string | USD | Product price currency, based on region where creators can sell. |
| > | > | added_status |  | string | ADDABLE | Showcase add status with possible values:  - ADDABLE  - ADDED  - REJECTED |
| > | > | brand_name |  | string | Apple | The brand name a seller has set for a product. |
| > | > | images |  | []object |  | Images of a product. |
| > | > | > | url | string | https://p19-pu-sign-useast8.tiktokcdn-us.com/tos-useast5-avt-0068-tx/982dd6b4e46a6a24203b00611a474cca~c5_1080x1080.webp | The URL of the product image. |
| > | > | > | width | int32 | 200 | The width of the product image. |
| > | > | > | height | int32 | 200 | The height of the product image. |
| > | > | sales_count |  | int32 | 33 | The number of products that have been sold. |
| > | total_count |  |  | int32 | 300 | The total number of products that meet the query conditions. |
| > | next_page_token |  |  | string | b2Zmc2V0PTAK | The pagination token is a cursor used for pagination. The token is returned in the previous pagination query to determine the current position. It will be empty when there aren't any products to search for. |
Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "code": 0,
  "data": {
      "products": {
        "id": "1729592969712207012",
        "title": "testcase autotest Live Product",
        "price": {
          "amount": "56.00",
          "currency": "USD"
        },
        "added_status": "ADDABLE\n",
        "brand_name": "Apple",
        "images": {
          "url": "https://p19-pu-sign-useast8.tiktokcdn-us.com/tos-useast5-avt-0068-tx/982dd6b4e46a6a24203b00611a474cca~c5_1080x1080.webp",
          "width": 200,
          "height": 200
        },
        "sales_count": 33
      },
      "total_count": 300,
      "next_page_token": "b2Zmc2V0PTAK"
  },
  "message": "success",
  "request_id": "202410011116276C0AA9039F31B70430A0"
}
```

##### Code Sample
##### Curl
```Bash
curl -X GET \
 'https://open-api.tiktokglobalshop.com/affiliate_creator/202509/shop_products?timestamp=1623812664&sign=bc721f0e0182914e3487b81df204de37a352fc3aa96947efda6dc1e5dd0d5290&sort_order=DESC&page_size=20&app_key=29a39d&title_keyword=apple&sort_field=PRODUCT_ID&page_token=b2Zmc2V0PTAK' \
-H 'x-tts-access-token: TTP_pwSm2AAAAABmmtFz1xlyKMnwg74T2GJ5s0uQbS8jPjb_GkdFVCxPqzQXSyuyfXdQa0AqyDsea2tYFNVf4XeqgZHFfPyv0Vs659QqyLYfsGzanZ5XZAin3_ZkcIxxS0_In6u6XDeU96k' \
-H 'content-type: application/json'
```

##### Error Codes
| Error Code | Error Message |
| --- | --- |

#### **[POST] Upload Shoppable Video**
 If the video size exceeds 10 MB, please follow [Shoppable Video Large File Upload Solution](https://bytedance.sg.larkoffice.com/docx/WTMvdfbTBo30Fex0r9YlYstGg0d)
##### Summary
| Type | Value |
| --- | --- |
| API Name | Upload Shoppable Video File |
| API Version | 202505 |
| API URI ( Fixed for all APIs ) | Host: open-api.tiktokglobalshop.com  Schemes: HTTPS |
| API Path | /affiliate_creator/:version/videos/video_files |
| API Method | POST |
| API Function Description | Use this API to upload the video before posting to TikTok |
##### Request Parameters
###### Query
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| app_key | string | true | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | true | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders.  |
| timestamp | int64 | true | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
###### Headers
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| x-tts-access-token | string | true | 29a39d | The creator access_token value from [Get Access Token](https://partner.tiktokshop.com/docv2/page/678e3a3292b0f40314a92d75#Get%20Access%20Token%20API), when user_type = 1. Follow this [guide](https://partner.tiktokshop.com/docv2/page/678e3a362dccb8030ea6f98c) to get creator access_token. |
| content-type | string | true | multipart/form-data | Allowed type: multipart/form-data |
###### Body
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| data | binary | true |  | The local file to be uploaded.  Note：  - Supported formats: MP4, MOV, MKV, WMV, WEBM, AVI, 3GP, FLV, MPEG  - Max video size: 100 MB  - Video aspect ratio: 9:16 to 16:9  Recommendations for product videos:  - Resolution: 720p or higher  - Duration: > 30 seconds |
**Request body example:**
```JSON
{
  "data": ""
}
```

##### Response Parameters
| Properties |  |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- | --- |
| code |  |  | int32 | 0 | The success or failure status code returned in API response. |
| message |  |  | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id |  |  | string | 202203070749000101890810281E8C70B7 | Request log |
| data |  |  | object |  | Specific return information |
| > | video_file |  | object |  | Video file information. |
| > | > | id | string | 123123123123 | The id from of the uploaded video file. |
| > | > | md5 | string | D41D8CD98F00B204E9800998ECF8427E | Upload file md5 checksum |
Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "code": 0,
  "data": {
      "video_file": {
        "id": "123123123123",
        "md5": "D41D8CD98F00B204E9800998ECF8427E"
      }
  },
  "message": "success",
  "request_id": "202410011116276C0AA9039F31B70430A0"
}
```

##### Code Sample
##### Curl
```Bash
curl -X POST \
 'https://open-api.tiktokglobalshop.com/affiliate_creator/202505/videos/video_files?timestamp=1623812664&app_key=29a39d&sign=bc721f0e0182914e3487b81df204de37a352fc3aa96947efda6dc1e5dd0d5290' \
-H 'x-tts-access-token: TTP_pwSm2AAAAABmmtFz1xlyKMnwg74T2GJ5s0uQbS8jPjb_GkdFVCxPqzQXSyuyfXdQa0AqyDsea2tYFNVf4XeqgZHFfPyv0Vs659QqyLYfsGzanZ5XZAin3_ZkcIxxS0_In6u6XDeU96k' \
-H 'content-type: multipart/form-data' \
-F 'data=@"file"'
```

##### Error Codes
| Error Code | Error Message |
| --- | --- |
#### [POST] Upload Shoppable Photo File
##### Summary
| Type | Value |
| --- | --- |
| API Name | Upload Shoppable Photo File |
| API Version | 202511 |
| API URI ( Fixed for all APIs ) | Host: open-api.tiktokglobalshop.com  Schemes: HTTPS |
| API Path | /affiliate_creator/:version/photos/photo_files |
| API Method | POST |
| API Function Description | Use this API to upload the photos before video posting. It returns the photo_file_uri for each uploaded image |
##### Request Parameters
###### Query
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| app_key | string | true | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | true | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders.  |
| timestamp | int64 | true | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
###### Headers
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| x-tts-access-token | string | true | 29a39d | The creator access_token value from [Get Access Token](https://partner.tiktokshop.com/docv2/page/678e3a3292b0f40314a92d75#Get%20Access%20Token%20API), when user_type = 1. Follow this [guide](https://partner.tiktokshop.com/docv2/page/678e3a362dccb8030ea6f98c) to get creator access_token. |
| content-type | string | true | multipart/form-data | Allowed type: multipart/form-data |
###### Body(Not applicable for GET/DELETE)
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| data | binary | true |  | The local file to be uploaded.  The local image file to be uploaded.    Note:  - Supported formats: JPG, JPEG, PNG, WEBP, HEIC, BMP  - Max size: 10MB    - aspect ratio: 9:16 to 16:9 |
**Request body example:**
```JSON
{
  "data": ""
}
```

##### Response Parameters
| Properties |  |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- | --- |
| code |  |  | int32 | 0 | The success or failure status code returned in API response. |
| message |  |  | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id |  |  | string | 202203070749000101890810281E8C70B7 | Request log |
| data |  |  | object |  | Specific return information |
| > | photo_file |  | object |  | Photo Info |
| > | > | photo_uri | string | skldjfskdlfjlskdfs000023423s | In [Post Shoppable Video], use this photo URI to fill cover_uri field |
Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "code": 0,
  "message": "Success",
  "request_id": "202203070749000101890810281E8C70B7",
  "data": {
    "photo_file": {
      "photo_uri": "skldjfskdlfjlskdfs000023423s"
    }
  }
}
```

##### Code Sample
##### Curl
```Bash
curl -X POST \
 'https://open-api.tiktokglobalshop.com/affiliate_creator/202511/photos/photo_files?sign=bc721f0e0182914e3487b81df204de37a352fc3aa96947efda6dc1e5dd0d5290&timestamp=1623812664&app_key=29a39d' \
-H 'x-tts-access-token: TTP_pwSm2AAAAABmmtFz1xlyKMnwg74T2GJ5s0uQbS8jPjb_GkdFVCxPqzQXSyuyfXdQa0AqyDsea2tYFNVf4XeqgZHFfPyv0Vs659QqyLYfsGzanZ5XZAin3_ZkcIxxS0_In6u6XDeU96k' \
-H 'content-type: multipart/form-data' \
-F 'data=@"file"'
```

##### Error Codes
| Error Code | Error Message |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
#### **[POST] Post Shoppable Video**
##### Summary
| Type | Value |
| --- | --- |
| API Name | Post Shoppable Video |
| API Version | 202607 |
| API URI ( Fixed for all APIs ) | Host: open-api.tiktokglobalshop.com  Schemes: HTTPS |
| API Path | /affiliate_creator/:version/videos |
| API Method | POST |
| API Function Description | Use this API to post the shoppable video. |
##### Request Parameters
###### Query
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| app_key   | string | true | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | true | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders.  |
| timestamp | int64 | true | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
###### Headers
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| x-tts-access-token | string | true | 29a39d | The creator access_token value from [Get Access Token](https://partner.tiktokshop.com/docv2/page/678e3a3292b0f40314a92d75#Get%20Access%20Token%20API), when user_type = 1. Follow this [guide](https://partner.tiktokshop.com/docv2/page/678e3a362dccb8030ea6f98c) to get creator access_token. |
| content-type | string | true | application/json | Allowed type: application/json |
###### Body(Not applicable for GET/DELETE)
| Properties |  | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- | --- |
| video_info |  | object | true |  | Video information |
| > | file_id | string | true | v12d00gd0024d3nfqr7og65 | Video file_id from [Upload Shoppable Video File] |
| > | title | string | true | Sample video title | The video caption.  The maximum length is 4000 in UTF-16 runes.  If not specified, the ticket post will not have any captions. |
| > | cover_uri | string | false | v12d00gd0024d3nfqr7og65oooiuuyy | Video cover image URI, which is returned after uploading the image via the Upload Shoppable Photo File API. |
| > | cover_timestamp_ms | int32 | false | 1000 | The input parameter is a timestamp, which specifies a particular moment in the video. The frame at that timestamp will be used as the video cover. If cover_uri and cover_timestamp_ms are both not provided, the cover will default to the first frame of the uploaded video. Only one of cover_uri or cover_timestamp_ms can be provided. If both parameters are passed, cover_uri will take precedence. |
| > | music_id   | string | false | 717294069642063456 | The music ID for the video BGM. If not provided, no music will be associated with the video. The music ID must be obtained via Search Music Library. |
| > | is_ai_generated | bool | false | true | Indicates whether the submitted video content is AI generated. Set to `true` to display an AI-generated label on the published post. Defaults to `false` when omitted. |
| product_link_info |  | object | true |  | Product link information |
| > | product_id | string | true | 17294069642063424 | Use product_id to bind the product with the video.  The product_id from [Get Shop Products] or [Get Showcase Products] |
| > | title | string | true | Sample product anchor title | The title to be shown on the product anchor. Anchor title should be shorter than 30 characters. |
**Request body example:**
```JSON
{
  "video_info": {
    "file_id": "v12d00gd0024d3nfqr7og65",
    "title": "Sample video title",
    "cover_uri": "v12d00gd0024d3nfqr7og65oooiuuyy",
    "cover_timestamp_ms": 1000,
    "music_id": "717294069642063456",
    "is_ai_generated": true
  },
  "product_link_info": {
    "product_id": "17294069642063424",
    "title": "Sample product anchor title"
  }
}
```

##### Response Parameters
| Properties |  |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- | --- |
| code |  |  | int32 | 0 | The success or failure status code returned in API response. |
| message |  |  | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id |  |  | string | 202203070749000101890810281E8C70B7 | Request log |
| data |  |  | object |  | Specific return information |
| > | video |  | object |  | Published video information |
| > | > | id | string | 7548431509997292816 | The video id, use this id to query video publish status. |
| > | > | quota | string | 3/day | Content posting quota for the creator. Returned on successful publish; included in the error message on failure; omitted if no quota restriction applies. |
Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "code": 0,
  "message": "Success",
  "request_id": "202203070749000101890810281E8C70B7",
  "data": {
    "video": {
      "id": "7548431509997292816",
      "quota": "3/day"
    }
  }
}
```

##### Code Sample
##### Curl
```Bash
curl -X POST \
 'https://open-api.tiktokglobalshop.com/affiliate_creator/202607/videos?app_key=29a39d&sign=bc721f0e0182914e3487b81df204de37a352fc3aa96947efda6dc1e5dd0d5290&timestamp=1623812664' \
-H 'content-type: application/json' \
-H 'x-tts-access-token: TTP_pwSm2AAAAABmmtFz1xlyKMnwg74T2GJ5s0uQbS8jPjb_GkdFVCxPqzQXSyuyfXdQa0AqyDsea2tYFNVf4XeqgZHFfPyv0Vs659QqyLYfsGzanZ5XZAin3_ZkcIxxS0_In6u6XDeU96k' \
-d '{
  "product_link_info": {
    "product_id": "17294069642063424",
    "title": "Sample product anchor title"
  },
  "video_info": {
    "cover_timestamp_ms": 1000,
    "cover_uri": "v12d00gd0024d3nfqr7og65oooiuuyy",
    "file_id": "v12d00gd0024d3nfqr7og65",
    "music_id": "717294069642063456",
    "title": "Sample video title",
    "is_ai_generated": true
  }
}'
```

##### Error Codes
| Error Code | Error Message |
| --- | --- |
| 16011007 | Product link title should be no longer than 30 characters. |
| 16011009 | Product link title contains offensive language. |
| 16011069 | Product link title contains punctuation or emoji. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 38007001 | System Error |
| 170001002 | Creator TikTok Shop permission check failed. |
| 170001003 | Creator Tiktok Shop permission temporarily banned. |
| 170001004 | Creator TikTok Shop permission is permanently banned. |
| 170001005 | Creator terms of service not signed. Please contact TikTok for more details. |
| 170001006 | GKA terms not signed. Please try again after signing GKA term. |
| 170001007 | Creator did not sign the EU data share agreement. |
| 170001008 | Creator Age verification failed. Please verify age first. |
| 170001009 | The product belongs to unsupported category. |
| 170001010 | The commission plan gets failed or rejected. |
| 170001011 | The product doesn't exist. |
| 170001012 | The product is not available. |
| 170001013 | Showcase SPU exceeds limit. |
| 170001014 | Blocked by spam check. |
| 170001015 | Blocked by TikTok Shop risk control. |
| 170001018 | Get creator pay account error. Please verify the pay account first. |
| 170001020 | You have exceeded the frequency to post EC short videos. Please take a rest. |
| 170001024 | cover_timestamp_ms must be a non-negative integer within the video duration. |
| 170001025 | cover_timestamp_ms exceeds the video duration. |
| 170001030 | Creator account banned. Please contact TikTok agent for your account. |
| 170001031 | Creator forbidden to post content. |
| 170001040 | Please use valid video file id to post TikTok Shop short video. |
| 170001050 | Getting errors during video posting workflow. Please try again or contact TikTok. |
#### **[GET] Get Shoppable Video Status**
##### Summary
| Type | Value |
| --- | --- |
| API Name | Get Shoppable Video Status |
| API Version | 202509 |
| API URI ( Fixed for all APIs ) | Host: open-api.tiktokglobalshop.com  Schemes: HTTPS |
| API Path | /affiliate_creator/:version/videos/:video_id/status |
| API Method | GET |
| API Function Description | Use this API to get shoppable video posting results. |
##### Request Parameters
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| video_id | string | true | 7548431509997292816 | The video id from [Publish Shoppable Video] |
###### Query
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| app_key | string | true | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | true | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders.  |
| timestamp | int64 | true | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
###### Headers
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| x-tts-access-token | string | true | 29a39d | The creator access_token value from [Get Access Token](https://partner.tiktokshop.com/docv2/page/678e3a3292b0f40314a92d75#Get%20Access%20Token%20API), when user_type = 1. Follow this [guide](https://partner.tiktokshop.com/docv2/page/678e3a362dccb8030ea6f98c) to get creator access_token. |
| content-type | string | true | application/json | Allowed type: application/json |
###### Body(Not applicable for GET/DELETE)
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
**Request body example:**
```JSON
{}
```

##### Response Parameters
| Properties |  |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- | --- |
| code |  |  | int32 | 0 | The success or failure status code returned in API response. |
| message |  |  | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id |  |  | string | 202203070749000101890810281E8C70B7 | Request log |
| data |  |  | object |  | Specific return information |
| > | video |  | object |  | returned video info |
| > | > | id | string | 7493990579714164574 | Video id |
| > | > | post_status | string | FAIL | Video posting status, possible values:  - SUCCESS  - FAIL  - PROCESSING |
| > | > | post_time | int64 | 1685548800 | Returned if the video has been successfully posted, i.e. `posting_status = SUCCESS`.  Represented in seconds. |
Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "code": 0,
  "message": "Success",
  "request_id": "202203070749000101890810281E8C70B7",
  "data": {
    "video": {
      "id": "7493990579714164574",
      "post_status": "FAIL",
      "post_time": 1685548800
    }
  }
}
```

##### Code Sample
##### Curl
```Bash
curl -X GET \
 'https://open-api.tiktokglobalshop.com/affiliate_creator/202509/videos/7548431509997292816/status?sign=bc721f0e0182914e3487b81df204de37a352fc3aa96947efda6dc1e5dd0d5290&timestamp=1623812664&app_key=29a39d' \
-H 'x-tts-access-token: TTP_pwSm2AAAAABmmtFz1xlyKMnwg74T2GJ5s0uQbS8jPjb_GkdFVCxPqzQXSyuyfXdQa0AqyDsea2tYFNVf4XeqgZHFfPyv0Vs659QqyLYfsGzanZ5XZAin3_ZkcIxxS0_In6u6XDeU96k' \
-H 'content-type: application/json'
```

##### Error Codes
| Error Code | Error Message |
| --- | --- |
| 38007001 | System Error |
| 170001016 | The video does not belong to the creator. Please check valid video status. |

#### **[POST] Pre-check Shoppable Video** 
##### Summary
| Type | Value |
| --- | --- |
| API Name | Precheck Video Content |
| API Version | 202511 |
| API URI ( Fixed for all APIs ) | Host: open-api.tiktokglobalshop.com  Schemes: HTTPS |
| API Path | /affiliate_creator/:version/videos/precheck_task |
| API Method | POST |
| API Function Description | Use this API to pre-check if there's any violation in the video and the shoppable content anchor |
##### Request Parameters
###### Query
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| app_key | string | true | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | true | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders.  |
| timestamp | int64 | true | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
###### Headers
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| x-tts-access-token | string | true | 29a39d | The creator access_token value from [Get Access Token](https://partner.tiktokshop.com/docv2/page/678e3a3292b0f40314a92d75#Get%20Access%20Token%20API), when user_type = 1. Follow this [guide](https://partner.tiktokshop.com/docv2/page/678e3a362dccb8030ea6f98c) to get creator access_token. |
| content-type | string | true | application/json | Allowed type: application/json |
###### Body(Not applicable for GET/DELETE)
| Properties |  | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- | --- |
| video_info |  | object | true |  | Video information |
| > | file_id | string | true | v12d00gd0024d3nfqr7og65 | Video file_id from [Upload Shoppable Video File](https://api/affiliate_creator/202505/videos/video_files) |
| product_link_info |  | object | true |  | Product link information |
| > | product_id | string | true | 17294069642063424 | Use product_id to bind the product with the video.  The product_id from [Get Shop Products](https://api/affiliate_creator/202509/shop_products) or [Get Showcase Products](https://api/affiliate_creator/202405/showcases/products) |
| > | title | string | true | Sample product anchor title | The title to be shown on the product anchor. Anchor title should be shorter than 30 characters. |
**Request body example:**
```JSON
{
  "video_info": {
    "file_id": "v12d00gd0024d3nfqr7og65"
  },
  "product_link_info": {
    "product_id": "17294069642063424",
    "title": "Sample product anchor title"
  }
}
```

##### Response Parameters
| Properties |  |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- | --- |
| code |  |  | int32 | 0 | The success or failure status code returned in API response. |
| message |  |  | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id |  |  | string | 202203070749000101890810281E8C70B7 | Request log |
| data |  |  | object |  | Specific return information |
| > | precheck |  | object |  | Video content pre-check task result |
| > | > | task_id | string | 1123123123 | pre-check task id |
Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "code": 0,
  "message": "Success",
  "request_id": "202203070749000101890810281E8C70B7",
  "data": {
    "precheck": {
      "task_id": "1123123123"
    }
  }
}
```

##### Code Sample
##### Curl
```Bash
curl -X POST \
 'https://open-api.tiktokglobalshop.com/affiliate_creator/202511/videos/precheck_task?app_key=29a39d&sign=bc721f0e0182914e3487b81df204de37a352fc3aa96947efda6dc1e5dd0d5290&timestamp=1623812664' \
-H 'x-tts-access-token: TTP_pwSm2AAAAABmmtFz1xlyKMnwg74T2GJ5s0uQbS8jPjb_GkdFVCxPqzQXSyuyfXdQa0AqyDsea2tYFNVf4XeqgZHFfPyv0Vs659QqyLYfsGzanZ5XZAin3_ZkcIxxS0_In6u6XDeU96k' \
-H 'content-type: application/json' \
-d '{
  "product_link_info": {
    "product_id": "17294069642063424",
    "title": "Sample product anchor title"
  },
  "video_info": {
    "file_id": "v12d00gd0024d3nfqr7og65"
  }
}'
```

##### Error Codes
| Error Code | Error Message |
| --- | --- |
| 16011007 | Product link title should be no longer than 30 characters. |
| 16011009 | Product link title contains offensive language. |
| 16011069 | Product link title contains punctuation or emoji. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 170001002 | Creator TikTok Shop permission check failed. |
| 170001005 | Creator terms of service not signed. Please contact TikTok for more details. |
| 170001006 | GKA terms not signed. Please try again after signing GKA term. |
| 170001007 | Creator did not sign the EU data share agreement. |
| 170001008 | Creator Age verification failed. Please verify age first. |
| 170001009 | The product belongs to unsupported category. |
| 170001010 | The commission plan gets failed or rejected. |
| 170001011 | The product doesn't exist. |
| 170001012 | The product is not available. |
| 170001013 | Showcase SPU exceeds limit. |
| 170001014 | Blocked by spam check. |
| 170001015 | Blocked by TikTok Shop risk control. |
| 170001018 | Get creator pay account error. Please verify the pay account first. |
| 170001019 | The user has exceeded allocated daily quota for precheck resource |

#### **[Get] Get Shoppable Video Pre-check Result** 
##### Summary
| Type | Value |
| --- | --- |
| API Name | Get Shoppable Video Precheck Result  |
| API Version | 202511 |
| API URI ( Fixed for all APIs ) | Host: open-api.tiktokglobalshop.com  Schemes: HTTPS |
| API Path | /affiliate_creator/:version/videos/precheck_tasks/:task_id |
| API Method | GET |
| API Function Description | Use this API to get video pre-check result |
##### Request Parameters
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| task_id | string | true | 7493990579714164574 | task id from [Precheck Video Content](https://api/affiliate_creator/202511/videos/precheck_task) |
###### Query
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| app_key | string | true | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | true | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders.  |
| timestamp | int64 | true | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
###### Headers
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| x-tts-access-token | string | true | 29a39d | The creator access_token value from [Get Access Token](https://partner.tiktokshop.com/docv2/page/678e3a3292b0f40314a92d75#Get%20Access%20Token%20API), when user_type = 1. Follow this [guide](https://partner.tiktokshop.com/docv2/page/678e3a362dccb8030ea6f98c) to get creator access_token. |
| content-type | string | true | application/json | Allowed type: application/json |
###### Body(Not applicable for GET/DELETE)
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
**Request body example:**
```JSON
{}
```

##### Response Parameters
| Properties |  |  |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- | --- | --- |
| code |  |  |  | int32 | 0 | The success or failure status code returned in API response. |
| message |  |  |  | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id |  |  |  | string | 202203070749000101890810281E8C70B7 | Request log |
| data |  |  |  | object |  | Specific return information |
| > | precheck_task |  |  | object |  | Video pre-check task |
| > | > | id |  | string | 7493990579714164574 | The id of the video pre-check task. |
| > | > | result |  | string | FAIL | SUCCESS: The precheck task passed checks  FAIL: The precheck task has failed due to violations. Check the 'issues' field for details.  PROCESSING: The precheck task is still in progress |
| > | > | issues |  | []object |  | A list of policy violation details returned when the task fails |
| > | > | > | risk | string | Pirated Content | Policy violation |
| > | > | > | suggestions | string | Your video may include unoriginal content. Creating original content is essential for standing out from the crowd. | Detailed guidance to resolve the detected violation. |
Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "code": 0,
  "message": "Success",
  "request_id": "202203070749000101890810281E8C70B7",
  "data": {
    "precheck_task": {
      "id": "7493990579714164574",
      "result": "FAIL",
      "issues": [
        "risk": "Pirated Content",
        "suggestions": "Your video may include unoriginal content. Creating original content is essential for standing out from the crowd."
      ]
    }
  }
}
```

##### Code Sample
##### Curl
```Bash
curl -X GET \
 'https://open-api.tiktokglobalshop.com/affiliate_creator/202511/videos/precheck_tasks/7493990579714164574?app_key=29a39d&sign=bc721f0e0182914e3487b81df204de37a352fc3aa96947efda6dc1e5dd0d5290&timestamp=1623812664' \
-H 'x-tts-access-token: TTP_pwSm2AAAAABmmtFz1xlyKMnwg74T2GJ5s0uQbS8jPjb_GkdFVCxPqzQXSyuyfXdQa0AqyDsea2tYFNVf4XeqgZHFfPyv0Vs659QqyLYfsGzanZ5XZAin3_ZkcIxxS0_In6u6XDeU96k' \
-H 'content-type: application/json'
```

##### Error Codes
| Error Code | Error Message |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
#### [Get] **** Search Music 
###### Overview | 基础定义
| Type \| 类型 | Value \| 值 |
| --- | --- |
| API Name \| API 名称 | Search Music |
| API Version \| API 版本 | 202602 |
| API URI \| API 统一资源标识 (所有 API 固定) | Host: open-api.tiktokglobalshop.com  Schemes: HTTPS |
| API Path \| API 访问路径 | /affiliate_creator/:version/music/search |
| API Method \| API 方法 | GET |
| API Function Description \| API 功能描述 | Use this API to get music information. Search Music is available globally across supported TikTok Shop markets; use the `region` and `language` query parameters to localize results. |
###### Request Parameters | 入参定义
####### Path
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
####### Query
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| app_key | string | true | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | true | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders.  |
| timestamp | int64 | true | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| keyword | string | true | love | Search keyword |
| search_id | string | false | 2026021821534288157A7F308E8C81359B | For the first page, leave search_id empty, the response will return a search_id. Starting from page 2 (i.e., when page_token > 0), include that same search_id in every request to continue paging; otherwise, pagination may fail. |
| page_token | string | false | 40 | First page: leave empty.   Next page: copy the next_page_token from the previous response and fill it here |
| page_size | string | false | 20 | Page size |
| region | string | false | US | Region code (ISO 3166-1 alpha-2) |
| language | string | false | en-US | Language tag (BCP-47) |
####### Headers
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| x-tts-access-token | string | true | 29a39d | Seller access_token |
| content-type | string | true | application/json | Allowed type: application/json |
####### Body(Not applicable for GET/DELETE | GET/DELETE请求不适用)
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
**Request Body Example**
```JSON
{}
```

###### Response Parameters ｜ 出参定义
| Properties |  |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- | --- |
| music |  |  | []object |  | Music list |
| > | id |  | string | 717294069642063456 | Music id |
| > | title |  | string | Love Story | Music title |
| > | author |  | string | Taylor Swift | Artist name |
| > | cover_thumb |  | object |  | Cover image |
| > | > | url_list | []string | ["https://example.com/music/cover/love_story_1.jpg"] | Cover image URL list |
| > | duration |  | string | 235 | Duration in seconds |
| > | play_url |  | object |  | Play URL |
| > | > | url_list | []string | ["https://example.com/music/play/love_story.mp3"] | URL list |
| next_page_token |  |  | string | 40 | use this as the next request’s page_token, only meaningful when has_more=true. |
| has_more |  |  | bool | false | Whether there is another page. |
| search_id |  |  | string | 2026021821534288157A7F308E8C81359B | Use the same search_id for all subsequent pages of the same search. |
Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "music": {
    "id": "717294069642063456",
    "title": "Love Story",
    "author": "Taylor Swift",
    "cover_thumb": {
      "url_list": [
        "https://example.com/music/cover/love_story_1.jpg"
      ]
    },
    "duration": "235",
    "play_url": {
      "url_list": [
        "https://example.com/music/play/love_story.mp3"
      ]
    }
  },
  "next_page_token": "40",
  "has_more": false,
  "search_id": "2026021821534288157A7F308E8C81359B"
}
```

###### Error Codes | 错误码定义
| **Error Code** | **Error Message** |
| --- | --- |
|  |  |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
#### Shoppable Video Precheck Result(webhook)
###### Webhook payload 
| Properties |  |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- | --- |
| type |  |  | int | 55 | The ID of the webhook type. |
| tts_notification_id |  |  | string | 7327112393057371910 | The ID of the notification. |
| creator_open_id   |  |  | string | VIyStQAAAADCBQ40s4TzOSSOEIW-bM5O9cod3vK8OytW8m-bnBYlXw | The open_id of the creator. To get the value, see [Authorization overview](https://partner.tiktokshop.com/docv2/page/678e3a3292b0f40314a92d75).   |
| timestamp |  |  | int | 1644412885 | The UNIX timestamp when this webhook was triggered. |
| data |  |  | object |  |  |
| > | precheck_task_id   |  | string   | 7493990579714164574 |    |
| > | result   |  | string | "FAIL"   | PASS  FAIL |
| > | issues   |  | []object   |  | Only if the "result" is "FAIL" |
| > | > | risk | string | "Pirated Content" | Risk type. |
| > | > | ~~todo~~  suggestion     | string   | "Your video may include unoriginal content. Creating original content is essential for standing out from the crowd." | How to fix this risk.   |
Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "type": 55,
  "creator_open_id": "VIyStQAAAADCBQ40s4TzOSSOEIW-bM5O9cod3vK8OytW8m-bnBYlXw",
  "tts_notification_id": "7327112393057371910",
  "timestamp": 1644412885,
  "data": {
    "precheck_task_id": "7493990579714164574",
    "result": "FAIL",
    "issues": [
      {
        "risk": "Pirated Content",
        "suggestion": "Your video may include unoriginal content. Creating original content is essential for standing out from the crowd."
      }
    ]
  }
}
```


---

## Solution Guidance > Loyalty Membership API & SPI Technical Integration Doc

Doc: https://partner.tiktokshop.com/docv2/page/1meo67bh · cập nhật 2026-10-28

### Background and Objectives
This document is intended for merchants and ISV (Independent Service Vendor) integration development teams. It describes the external Open API and SPI interfaces required to integrate TTS with merchant's loyalty membership system. It focuses on the interface directions, common rules, request/response parameters, error codes, idempotency requirements, retry recommendations, and sequence diagrams. The goal of this document is to help developers:

* Query membership data on the TTS side for reconciliation and troubleshooting.
* Receive membership bind-check, bind/registration, and unbind notifications initiated by TTS via the merchant-provided SPI.
* Use key parameters such as `buyer_id`, `merchant_member_id`, `idempotency_key`, and `request_id` consistently to make requests traceable, retryable, and idempotent.

### Glossary
| **Term** | **Description** |
| --- | --- |
| TTS | TikTok Shop platform. |
| Merchant / ISV | Merchant system, or an authorized external independent service provider. |
| Buyer ID / `buyer_id` | A globally unique buyer identifier on the TTS side and the primary user identifier in membership APIs. |
| Merchant Member ID / `merchant_member_id` | The unique member identifier in the merchant membership system. |
| Open API | APIs that merchants / ISVs call to TTS. |
| Open SPI | APIs that TTS calls on the merchant side. |
### E2E Integration Process
This diagram demonstrates the E2E integration process for merchants/ISV after the launch of the Loyalty Membership MVP program. 
This diagram is only for integrating with existing API/SPIs. If the 3rd party wishes to create new API/SPIs, we will need to go through the standard requirement process, which involves the Bytedance RD developing and testing alongside the 3rd party. 

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/b0f336e14038440ba8a6787cdc24877b~tplv-k9wyc2ijk0-image.image)
### Sequence Diagrams
The following sequence diagrams show only the external integration view. Participants are consolidated into three parties: TT App, TTS backend, and the merchant. We do not break down the merchant’s internal systems, and we do not expose any internal TTS domains, internal service names, or implementation details.
#### Membership Binding / Enrollment
**Note**: Between TT App and the TTS backend, we only represent user actions and page outcomes, without specific request parameters. Between the TTS backend and the merchant, we keep the SPI semantics and key fields so that the merchant can understand the `MembershipBindCheck` and `MembershipBind` logic to implement.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/11cf7b181fb8451f92d578c5d5f9b9c9~tplv-k9wyc2ijk0-image.image)
#### Membership Unbinding

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/a24423b6fb3544e3a6690a432c9be397~tplv-k9wyc2ijk0-image.image)
#### Reconciliation Queries
**Note**: Reconciliation is split into two independent scenarios: first, when the merchant sees a masked email in order events, it calls `MemberInfoQuery` to query TTS-side membership information; second, the merchant batch-syncs member profile, tier, or bind status to TTS via `MemberProfileBatchUpdate`.
##### MemberInfoQuery API: Merchant queries TTS member information

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/78b94a872bc04acb855ce57a90eb7623~tplv-k9wyc2ijk0-image.image)
##### MemberProfileBatchUpdate API: Merchant batch-updates TTS member profiles

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/785dcb88fba34792beb7c43a1471f3ab~tplv-k9wyc2ijk0-image.image)
### Integration Scope
| Direction | Interface | Purpose |
| --- | --- | --- |
| Merchant / ISV → TTS | **`MemberProfileBatchUpdate` API** | Batch update member profiles, tiers, or binding status for multiple members. |
| Merchant / ISV → TTS   | **`MemberInfoQuery` API**   | Query TTS-side membership data. When a masked email is seen in order events, it can be used to look up member information. |
| Merchant / ISV → TTS | **`CreateCoupon`** **API** |  |
| Merchant / ISV → TTS | **`DeactivateCoupon`** **API** |  |
| Merchant / ISV → TTS | **`LoyaltyProgramInfoUpdate`** **API** |  |
| TTS → Merchant / ISV | **`MembershipBindCheck` SPI** | Before binding or registration, check whether the buyer is already a merchant member. |
| TTS → Merchant / ISV | **`MembershipBind` SPI**   | Bind an existing member, or register and bind a new member. |
| TTS → Merchant / ISV | **`MembershipUnbind` SPI** | Notify merchants that the membership relationship has been unbound. |
| TTS → Merchant / ISV | **`MemberPointsQuery` SPI** | When the user views the membership page, query the current total points in real time. |
| TTS → Merchant / ISV | **`MemberPointsTransactionQuery` SPI**   | When the user views the points details page, query paginated points transactions. |
| TTS → Merchant / ISV | **`MembershipRedeem`** **SPI** |  |
| TTS → Merchant / ISV | **`MembershipRedeemReverse`** **SPI** |  |
### Common Rules
#### Identifier Rules

* `buyer_id` is the globally unique buyer identifier on the TTS side and should be used as the primary user identifier for TTS membership APIs.
* `merchant_member_id` is the member identifier in the merchant membership system and should remain stable within the merchant’s membership program. It should be globally unique across shops under the same merchant membership program. If the merchant uses a group-level identifier or `merchant_member_id` is not globally unique across shops, the merchant must call this out during integration design so that the identifier granularity can be aligned before launch.

#### `request_id` and `idempotency_key`

* `request_id` is returned in the API response as a unique trace ID for log lookup, troubleshooting, and retry handling; callers should not pass it in the request payload.
* Write operations should additionally carry an `idempotency_key` for business-level idempotency control.
* When retrying the same business operation, the caller must reuse the same `idempotency_key` and keep the payload unchanged.
* If the same `idempotency_key` is used with different payloads, the receiver should return an idempotency conflict error.
* Read-only APIs do not use `idempotency_key`, but should still return `request_id` for traceability.

#### Common Open API Query Parameters
| Parameter | Location | Type | Required | Description |
| --- | --- | --- | --- | --- |
| `app_key` | Query | string | Yes | App Key assigned after the application is created. |
| `timestamp` | Query | int64 | Yes | Unix timestamp for signature generation and request expiry validation. |
| `sign` | Query | string | Yes | Request signature generated per the Open Platform signing algorithm. |
| `shop_cipher` | Query | string | Yes | Authorized shop context identifier. |
#### Common Open API Headers
| Header | Type | Required | Description |
| --- | --- | --- | --- |
| `content-type` | string | Yes | Fixed to `application/json`. |
| `x-tts-access-token` | string | Yes | Seller authorization access token. |
#### Common Open API Response Envelope
Unless otherwise specified, the API returns the following top-level structure:
| Field | Type | Description |
| --- | --- | --- |
| `code` | int | `0` means success; a non-`0` value means failure. |
| `message` | string | Result description or error message. |
| `request_id` | string | Unique request identifier used for tracing and retry handling. |
| `data` | object | Business response payload returned per API scenario. |
### Open API Definitions
#### MemberProfileBatchUpdate API
**Description**: Updates membership data for up to five buyers in one request. This operation supports bulk order processing, historical migration, and membership corrections. Each item carries its own `idempotency_key`; retries with the same key and identical item payload should return a stable result, while reusing the key with different item data should fail with an idempotency conflict.
| Type | Value |
| --- | --- |
| API Name | `member_profile_batch_update` |
| API Version | `202607` |
| Host / Scheme | `open-api.tiktokglobalshop.com` / HTTPS |
| API Path | `/customer_engagement/:version/member_profiles/partial_edit` |
| Method | `POST` |
##### Request Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `member_profiles` | array[object] | Y | Member profile updates. Maximum count is five. Each item is processed independently and the response preserves request item identity. |
##### member_profiles Item
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `buyer_id` | string | Y | Unique buyer identifier on the TTS side. |
| `idempotency_key`   | string | Y | Unique key for retrying this member profile update item. Reusing the key with different item data returns `IDEMPOTENCY_CONFLICT`. |
| `bind_status` | string | N | Member binding status. Possible values include `UNKNOWN`, `BOUND`, `UNBOUND`, and `PENDING`. Allowed transitions include `UNKNOWN -> BOUND` and `BOUND <-> UNBOUND`. |
| `merchant_member_id` | string | N | Member identifier assigned by the merchant. |
| `program_level_name` | string | N | Merchant loyalty-program level name to set, for example `GOLD` or `SILVER`. |
| `program_level_expire_time_ms` | int64 | N | Unix timestamp in milliseconds when the loyalty-program level expires. |
| `update_time_ms` | int64 | N | Unix timestamp in milliseconds when the merchant generated this profile update. |
**Request body example:**
```JSON
{
  "member_profiles": [
    {
      "bind_status": "BOUND",
      "buyer_id": "7451234567890123456",
      "idempotency_key": "7802d8ce-f651-4d7c-9431-0ad7c957921f",
      "merchant_member_id": "MEMBER_10001",
      "program_level_expire_time_ms": 1798761600000,
      "program_level_name": "GOLD",
      "update_time_ms": 1785168000000
    }
  ]
}
```

##### Response Parameters（Top-Level）
| Field | Type | Description |
| --- | --- | --- |
| `code` | int32 | The success or failure status code returned in the API response. |
| `message` | string | Success or failure message. Failure reasons are described in the message. |
| `request_id` | string | Request log ID returned in response to tracing and troubleshooting. |
| `data` | object | Specific return information. |
##### data Object
| Field | Type | Description |
| --- | --- | --- |
| `total_count` | int32 | Total number of submitted member profile updates. |
| `success_count` | int32 | Number of member profile updates that succeeded. |
| `fail_count` | int32 | Number of member profile updates that failed. |
| `successes` | array[object] | Successful member profile update results. Empty result is returned as an empty array. |
| `errors` | array[object] | Failed member profile update results. Empty result is returned as an empty array. |
##### successes Item
| Field | Type | Description |
| --- | --- | --- |
| `buyer_id` | string | Unique buyer identifier from the corresponding request item. |
| `idempotency_key` | string | Idempotency key from the corresponding request item. |
| `merchant_member_id` | string | Merchant member identifier from the corresponding request item. |
##### errors Item
| Field | Type | Description |
| --- | --- | --- |
| `code` | string | Stable item result code. |
| `message` | string | Human-readable item result with corrective action when the update fails. |
| `detail` | object | Identifiers for the failed request item, including `buyer_id`, `idempotency_key`, and `merchant_member_id`. |
**Response body example:**
```JSON
{
  "code": 0,
  "message": "Success",
  "request_id": "202203070749000101890810281E8C70B7",
  "data": {
    "fail_count": 1,
    "errors": [
      {
        "code": "INTERNAL_ERROR",
        "detail": {
          "buyer_id": "7451234567890123456",
          "idempotency_key": "7802d8ce-f651-4d7c-9431-0ad7c957921f",
          "merchant_member_id": "MEMBER_10001"
        },
        "message": "INVALID_BUYER_ID"
      }
    ],
    "success_count": 1,
    "successes": [
      {
        "buyer_id": "7451234567890123456",
        "idempotency_key": "7802d8ce-f651-4d7c-9431-0ad7c957921f",
        "merchant_member_id": "MEMBER_10001"
      }
    ],
    "total_count": 2
  }
}
```

#### MemberInfoQuery API
**Description**: Queries member profile data for up to 20 buyer IDs in one request. Merchants and authorized service providers can use the response to reconcile member identity, loyalty level, points, and binding status. This is a read-only operation and does not require `idempotency_key`. The returned email is subject to user authorization and platform data-protection policy.
| Type | Value |
| --- | --- |
| API Name | `Query Member Information` |
| API Version | `202607` |
| Host / Scheme | `open-api.tiktokglobalshop.com` / HTTPS |
| API Path | `/customer_engagement/:version/member_profiles/search` |
| Method | `POST` |
##### Request Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `buyer_ids` | array[string] | Y | Buyer IDs whose member information is queried. Maximum count is 20. |
**Request body example:**
```JSON
{
  "buyer_ids": [
    "7451234567890123456"
  ]
}
```

##### Response Parameters（Top-Level）
| Field | Type | Description |
| --- | --- | --- |
| `code` | int32 | The success or failure status code returned in the API response. |
| `message` | string | Success or failure message. Failure reasons are described in the message. |
| `request_id` | string | Request log ID returned in the response for tracing and troubleshooting. |
| `data` | object | Specific return information. |
##### data Object
| Field | Type | Description |
| --- | --- | --- |
| `member_profiles` | array[object] | Member profiles matching the submitted buyer IDs. Empty result is returned as an empty array. |
##### member_profiles Item
| Field | Type | Description |
| --- | --- | --- |
| `bind_status` | string | Member binding status. Possible values include `UNKNOWN`, `BOUND`, `UNBOUND`, and `PENDING`. |
| `buyer_id` | string | Unique buyer identifier. |
| `email`   | string | Buyer email returned only with user authorization. The email may be masked according to platform data-protection policy. |
| `merchant_member_id` | string | Member identifier assigned by the merchant. |
| `points` | int64 | Current member points balance. |
| `expiring_points` | int64 | Member points scheduled to expire at `points_expire_time_ms`. |
| `points_expire_time_ms` | int64 | Unix timestamp in milliseconds when expiring points expire. |
| `program_level_name` | string | Merchant loyalty-program level name. |
| `update_time_ms` | int64 | Unix timestamp in milliseconds when the member profile was last updated. |
**Response body example:**
```JSON
{
  "code": 0,
  "message": "Success",
  "request_id": "202203070749000101890810281E8C70B7",
  "data": {
    "member_profiles": [
      {
        "bind_status": "BOUND",
        "buyer_id": "7451234567890123456",
        "email": "m***@example.com",
        "merchant_member_id": "MEMBER_10001",
        "points": 1250,
        "expiring_points": 200,
        "points_expire_time_ms": 1798761600000,
        "program_level_name": "GOLD",
        "update_time_ms": 1785168000000
      }
    ]
  }
}
```

#### Create Membership Coupon API
Creates a full-shop membership coupon for the authorized shop and configures the points required to claim it.
##### Basic Information
| Item | Value |
| --- | --- |
| Path | `/customer_engagement/202609/membership/coupons` |
| Method | `POST` |
| Version | `202609` |
| Idempotency | Required query parameter `idempotency_key` in UUID format. Retries must reuse the same key and payload. |
This API uses the common query parameters and headers defined in **Common Rules**. The query `timestamp` is Unix time in seconds. `app_key`, `sign`, `timestamp`, and `shop_cipher` are required; `x-tts-access-token` and `Content-Type: application/json` are required headers.
##### Request Body Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `title` | string | Y | Merchant-defined coupon title. |
| `claim_duration` | object | Y | Period during which buyers may claim the coupon. |
| `redemption_duration` | object | Y | Period during which a claimed coupon may be redeemed. |
| `usage_limits` | object | Y | Per-buyer and total claim limits. |
| `discount` | object | Y | Amount-off or percentage-off discount configuration. |
| `threshold` | object | Y | No-threshold or minimum-spend requirement. |
| `points_required` | integer (int64) | Y | Non-negative points required to claim the coupon. 0 means no points are deducted. |
###### claim_duration Object
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `start_time` | string (date-time) | Y | RFC 3339 time when claiming starts.   |
| `end_time` | string (date-time) | Y | RFC 3339 time when claiming ends; must be later than start_time. |
###### redemption_duration Object
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `type` | string enum | Y | `ABSOLUTE` or `RELATIVE`. |
| `start_time` | string (date-time) | Conditional | Required for `ABSOLUTE`; prohibited for `RELATIVE`. |
| `end_time` | string (date-time) | Conditional | Required for `ABSOLUTE`; prohibited for `RELATIVE`. |
| `relative_duration_days` | integer (int32) | Conditional | Required for `RELATIVE`; minimum 1. Prohibited for `ABSOLUTE`. |
###### usage_limits Object
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `single_buyer_claim_limit` | integer (int32) | Y | Maximum claims per buyer; minimum 1. |
| `total_claim_limit` | integer (int64) | Y | Maximum total claims; minimum 1. |
###### discount Object
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `type` | string enum | Y | `AMOUNT_OFF` or `PERCENT_OFF`. |
| `reduction_amount` | string | Conditional | Required for `AMOUNT_OFF`; shop-currency amount such as 5.00. |
| `percentage` | string | Conditional | Required for `PERCENT_OFF`; decimal percentage from 0 through 100. |
| `max_discount` | string | N | Optional maximum shop-currency discount for `PERCENT_OFF`. |
###### threshold Object
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `type` | string enum | Y | `NONE` or `MIN_SPEND`. |
| `min_spend` | string | Conditional | Required for `MIN_SPEND`; shop-currency amount. Omit for `NONE`. |
##### Request Example
```JSON
{
  "title": "Gold Member Welcome Coupon",
  "claim_duration": {
    "start_time": "2026-10-01T00:00:00Z",
    "end_time": "2026-10-31T23:59:59Z"
  },
  "redemption_duration": {
    "type": "RELATIVE",
    "relative_duration_days": 30
  },
  "usage_limits": {
    "single_buyer_claim_limit": 1,
    "total_claim_limit": 10000
  },
  "discount": {
    "type": "AMOUNT_OFF",
    "reduction_amount": "5.00"
  },
  "threshold": {
    "type": "MIN_SPEND",
    "min_spend": "30.00"
  },
  "points_required": 500
}
```

##### Response data Object
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `coupon_id` | string | Y | Newly created membership coupon identifier. |
| `status` | string enum | Y | `NOT_START` or `ONGOING`. |
##### Business Rules

* For relative redemption periods, duration is measured in whole days.
* Money fields are decimal strings in the shop currency; do not send binary floating-point values.
* Reuse the same idempotency key and identical payload for retries.

#### Deactivate Membership Coupon API
Deactivates a membership coupon owned by the authorized shop. A deactivated coupon can no longer be claimed or redeemed.
##### Basic Information
| Item | Value |
| --- | --- |
| Path | `/customer_engagement/202609/membership/coupons/{coupon_id}/deactivate` |
| Method | `POST` |
| Version | `202609` |
| Request Body | None |
This API uses the common query parameters and headers defined in **Common Rules**. The query `timestamp` is Unix time in seconds. `app_key`, `sign`, `timestamp`, and `shop_cipher` are required; `x-tts-access-token` and `Content-Type: application/json` are required headers.
##### Path Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `coupon_id` | string | Y | Unique identifier of the membership coupon to deactivate. |
##### Response data Object
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `coupon_id` | string | Y | Identifier of the deactivated coupon. |
| `title` | string | N | Merchant-defined coupon title. |
| `status` | string enum | Y | Always `DEACTIVATED` after success. |
##### Business Rules

* Only coupons that have not started or are currently claimable can be deactivated.
* Deactivation prevents subsequent claim and redemption attempts.

#### Update Loyalty Program Information API
Updates the authorized shop's loyalty program privacy policy links, points rules, and displayed benefits.
##### Basic Information
| Item | Value |
| --- | --- |
| Path | `/customer_engagement/202609/loyalty_program/info/partial_edit` |
| Method | `POST` |
| Version | `202609` |
| Idempotency | Required query parameter `idempotency_key` in UUID format. Retries must reuse the same key and payload. |
This API uses the common query parameters and headers defined in **Common Rules**. The query `timestamp` is Unix time in seconds. `app_key`, `sign`, `timestamp`, and `shop_cipher` are required; `x-tts-access-token` and `Content-Type: application/json` are required headers.
##### Request Body Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `privacy_policy_links` | array<object> | Y | Complete ordered list of privacy-policy links; 1–3 items. |
| `points_rules` | string | Y | Complete plain-text points rules, maximum 20,000 characters. HTML is not supported. |
| `sign_up_bonus` | object | N | Display-only sign-up bonus; TikTok Shop does not award points. Omit to keep the current setting. |
| `earning_rule` | object | N | Display-only earning rule; TikTok Shop does not calculate or award points. Omit to keep the current setting. |
###### privacy_policy_links Item
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `title` | string | Y | Display title, maximum 100 characters. |
| `url` | string (URI) | Y | HTTPS URL, maximum 2,048 characters. Do not use credentials, fragments, localhost, or private-network addresses. |
###### sign_up_bonus Object
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `is_enabled` | boolean | Y | Whether to display the sign-up bonus; `false` hides it. |
| `points` | integer (int64) | Conditional | Whole points for joining; minimum 1. Required when `is_enabled` is `true`. |
###### earning_rule Object
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `is_enabled` | boolean | Y | Whether to display the earning benefit; `false` hides it. |
| `method` | string enum | Conditional | `PER_SPEND`: points per `spend_amount` paid. `PER_ORDER`: fixed points per order. Required when `is_enabled` is `true`. |
| `points` | integer (int64) | Conditional   | Whole points per `spend_amount` or order; minimum 1. Required when `is_enabled` is `true`. |
| `spend_amount` | object | Conditional | Required for `PER_SPEND`; omit for `PER_ORDER`. |
###### spend_amount Object
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `amount` | string | Y | Decimal amount, for example `"1.00"`. Must be greater than 0. |
| `currency` | string | Y | Three-letter uppercase ISO 4217 currency code, for example `USD`. Must match the shop's currency. |
##### Request Example
```JSON
{
  "privacy_policy_links": [
    {
      "title": "Membership Privacy Policy",
      "url": "https://www.example.com/membership/privacy"
    }
  ],
  "points_rules": "Members earn one point for every eligible dollar spent.",
  "sign_up_bonus": {
    "is_enabled": true,
    "points": 100
  },
  "earning_rule": {
    "is_enabled": true,
    "method": "PER_SPEND",
    "points": 1,
    "spend_amount": {
      "amount": "1.00",
      "currency": "USD"
    }
  }
}
```

##### Response data Object
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `status` | string enum | Y | `ACTIVE` or `PENDING_VALIDATION`. |
##### Business Rules

* The request replaces the complete privacy-policy link list and complete points-rules text.
* Privacy-policy links are displayed in request-array order.
* Reuse the same idempotency key and identical payload for retries.
* `sign_up_bonus` and `earning_rule` are display-only. TikTok Shop does not award or calculate points from them.
* Omit `sign_up_bonus` or `earning_rule` to keep that setting. Set `is_enabled` to `false` to hide the matching benefit.
* If both benefits are disabled or have never been set, the Benefits section is hidden.

### Open SPI Definitions
#### MembershipBindCheck SPI
**SPI Code**: `MEMBERSHIP_BIND_CHECK` · **Version**: `202608`
**Description**: Checks whether a buyer may already have a merchant membership. The merchant matches a privacy-preserving email token and returns masked potential matches for buyer confirmation.
##### Request Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `buyer_id` | string | Y | TikTok Shop buyer identifier, 1–64 characters. |
| `shop_open_id` | string | Y | Encoded TikTok Shop shop identifier, 1–128 characters. |
| `tts_shop_id` | string   | N | TikTok Shop ID associated with the request, 1–64 characters. This is not the Shop OpenID. If omitted, the merchant must continue processing with existing fields. |
| `email_match_token` | string | Y | Buyer-authorized masked email used for privacy-preserving matching, 3–320 characters. Match on visible characters; this is not an HMAC or authentication token and must not reveal the full email address. |
##### Response Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `has_potential_matches` | boolean | Y | Whether one or more potential memberships were found. `true` requires at least one item in `potential_matches`; `false` requires an empty array. |
| `potential_matches` | array<object> | Y | Potential memberships for buyer confirmation. Return an empty array, never null, when no match is found. |
##### `potential_matches` Item
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `masked_email` | string | Y | Partially concealed merchant-side email for buyer recognition, 3–320 characters. It must never contain the full email address. |
| `merchant_member_id` | string | Y | Stable merchant membership identifier, 1–128 characters. |
#### MembershipBind SPI
**SPI Code**: `MEMBERSHIP_BIND` · **Version**: `202608`
**Description**: Links an existing merchant membership or registers and links a new membership after buyer authorization. TikTok Shop records the relationship only after a `BOUND` result. 
If the member is already bound, repeatedly calling this SPI should not return an error result. Instead, should return the latest member info. 

##### Request Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `buyer_id` | string | Y | TikTok Shop buyer identifier, 1–64 characters. |
| `shop_open_id` | string | Y | Encoded TikTok Shop shop identifier, 1–128 characters. |
| `tts_shop_id` | string | N | TikTok Shop ID associated with the request, 1–64 characters. This is not the Shop OpenID. If omitted, the merchant must continue processing with existing fields. |
| `bind_type` | string enum | Y | `EXISTING_MEMBER` or `NEW_MEMBER`. |
| `merchant_member_id` | string | Conditional | Required for `EXISTING_MEMBER` and must be omitted for `NEW_MEMBER`; 1–128 characters. |
| `user_profile` | object | Conditional | Optional for `NEW_MEMBER` and must be omitted for `EXISTING_MEMBER`. The object and every attribute are optional because availability depends on buyer consent and profile completeness. Treat as personal data and do not log it. |
| `idempotency_key` | string (UUID) | Y | Stable operation key. Retries use the same key and identical payload and receive the original result; reusing the key with different business input must be rejected as a caller error. |
##### `user_profile` Object
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | string (email) | N | Buyer-authorized contact email, maximum 320 characters. |
| `first_name` | string | N | Buyer-authorized given name, 1–128 characters. |
| `last_name` | string | N | Buyer-authorized family name, 1–128 characters. |
| `phone_number` | string | N | Buyer-authorized contact telephone number, 1–64 characters. |
| `birth_date` | string (date) | N | Buyer-authorized date of birth in YYYY-MM-DD format. |
| `full_name` | string | N | Buyer-authorized full name, 1–256 characters. |
##### Response Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bind_status` | string enum | Y | `BOUND` or `REJECTED`. |
| `merchant_member_id` | string | Conditional | Required for `BOUND`; must be omitted for `REJECTED`; 1–128 characters. |
| `program_level` | object | N | Merchant-defined level for a `BOUND` result; must be omitted for `REJECTED`. If present, name is required and expire_time is optional. |
| `points` | integer (int64) | N | Non-negative available balance after binding, including welcome points; `BOUND` only and omitted for `REJECTED`. |
| `expiring_points` | integer (int64) | N | Non-negative points scheduled to expire; `BOUND` only and omitted for `REJECTED`. Must appear together with `points_expire_time`. |
| `points_expire_time` | integer (int64) | N | Unix time in milliseconds when `expiring_points` expire; `BOUND` only and omitted for `REJECTED`. Must appear together with `expiring_points`. |
| `welcome_points` | integer (int64) | N | Non-negative points granted for the new membership; `BOUND` only and omitted for `REJECTED`. |
| `bind_time` | integer (int64) | N | Unix time in milliseconds when binding completed; `BOUND` only and omitted for `REJECTED`. |
| `reason_code` | string enum | Conditional | Required for `REJECTED` and must be omitted for `BOUND`. Values: `MEMBER_NOT_FOUND`, `REGISTRATION_REJECTED`, `MEMBER_CONFLICT`. |
| `reason_message` | string | N | Human-readable refusal explanation, maximum 500 characters; `REJECTED` only and omitted for `BOUND`. |
##### `program_level` Object
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | string | Y | Merchant-defined membership level name, maximum 128 characters. |
| `expire_time` | integer (int64) | N | Unix time in milliseconds when the membership level expires. |
#### MembershipUnbind SPI
**SPI Code**: `MEMBERSHIP_UNBIND` · **Version**: `202608`
**Description**: Removes the TikTok Shop-to-merchant membership link. It must not terminate the underlying merchant membership.
##### Request Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `buyer_id` | string | Y | TikTok Shop buyer identifier, 1–64 characters. |
| `shop_open_id` | string | Y | Encoded TikTok Shop shop identifier, 1–128 characters. |
| `tts_shop_id` | string | N | TikTok Shop ID associated with the request, 1–64 characters. This is not the Shop OpenID. If omitted, the merchant must continue processing with existing fields. |
| `merchant_member_id` | string | Y | Stable merchant membership identifier linked to the buyer, 1–128 characters. |
| `unbind_reason` | string enum | Y | `USER_REQUEST` or `PLATFORM_REVOKE`. |
| `idempotency_key` | string (UUID) | Y | Stable operation key. Retries use the same key and identical payload and replay the original result; reusing the key with different input must be rejected as a caller error. |
##### Response Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `unbind_status` | string enum | Y | `UNBOUND` if this operation removed the link; `ALREADY_UNBOUND` if a new operation found no active link. Replaying an existing key returns its original result. |
| `unbind_time` | integer (int64) | Conditional | Required for `UNBOUND` and omitted for `ALREADY_UNBOUND`; Unix time in milliseconds when the merchant removed the link. |
#### MemberPointsQuery SPI
**SPI Code**: `MEMBER_POINTS_QUERY` · **Version**: `202608`
**Description**: Read-only query for the current merchant membership points balance. The merchant remains the source of truth; this SPI does not use `idempotency_key`.
* Our system caches member points, so some updates may be slightly delayed.
* This SPI should be highly available because it directly affects the buyer experience.

##### Request Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `buyer_id` | string | Y | TikTok Shop buyer identifier, 1–64 characters. |
| `shop_open_id` | string | Y | Encoded TikTok Shop shop identifier, 1–128 characters. |
| `tts_shop_id` | string | N | TikTok Shop ID associated with the request, 1–64 characters. This is not the Shop OpenID. If omitted, the merchant must continue processing with existing fields. |
| `merchant_member_id` | string | Y | Stable merchant membership identifier whose points are queried, 1–128 characters. |
##### Response Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `membership_status` | string enum | Y | `BOUND` or `NOT_BOUND`. `NOT_BOUND` must omit all membership and points fields below. |
| `merchant_member_id` | string | Conditional | Required for `BOUND`; omitted for `NOT_BOUND`; 1–128 characters. |
| `points` | integer (int64) | Conditional | Required, non-negative current available balance for `BOUND`; omitted for `NOT_BOUND`. |
| `expiring_points`   | integer (int64) | N | Non-negative points scheduled to expire; `BOUND` only and omitted for `NOT_BOUND`. Must appear together with `points_expire_time`. |
| `points_expire_time` | integer (int64) | N | Unix time in milliseconds when `expiring_points` expire; `BOUND` only and omitted for `NOT_BOUND`. Must appear together with `expiring_points`. |
| `update_time` | integer (int64) | N | Unix time in milliseconds when the merchant last updated the balance; `BOUND` only and omitted for `NOT_BOUND`. |
#### MemberPointsTransactionQuery SPI
**SPI Code**: `MEMBER_POINTS_TRANSACTION_QUERY` · **Version**: `202608`
**Description**: Read-only, cursor-paginated query for points transactions. Return transactions in descending `occur_time` order. This SPI does not use `idempotency_key`.
* This SPI should be highly available because it directly affects the buyer experience.

##### Request Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `buyer_id` | string | Y | TikTok Shop buyer identifier, 1–64 characters. |
| `shop_open_id` | string | Y | Encoded TikTok Shop shop identifier, 1–128 characters. |
| `tts_shop_id` | string | N | TikTok Shop ID associated with the request, 1–64 characters. This is not the Shop OpenID. If omitted, the merchant must continue processing with existing fields. |
| `merchant_member_id` | string | Y | Stable merchant membership identifier whose `transactions` are queried, 1–128 characters. |
| `page_size` | integer (int32) | N | Maximum `transactions` to return, 1–50; default 20. |
| `page_token` | string | N | Opaque `next_page_token` from the previous response, maximum 1024 characters. Omit for the first page. |
##### Response Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `membership_status` | string enum | Y | `BOUND` or `NOT_BOUND`. `NOT_BOUND` requires an empty `transactions` array and empty `next_page_token`. |
| `transactions` | array<object> | Y | Up to 50 `transactions` in descending `occur_time` order. Return an empty array, never null. |
| `next_page_token` | string | Y | URL-safe opaque next-page token, maximum 1024 characters and characters A–Z, a–z, 0–9, underscore, or hyphen only. Return an empty string on the last page; no padding or percent-encoded characters. |
##### `transactions` Item
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `transaction_id` | string | Y | Globally unique merchant points transaction identifier, 1–128 characters. |
| `points_change_type` | string enum | Y | `EARN`, `DEDUCT`, `REFUND_REVERSE`, `ADJUST`, or `EXPIRE`. |
| `points_delta` | integer (int64) | Y | Signed points change: positive adds points and negative removes points. |
| `points` | integer (int64) | Y | Non-negative available balance immediately after the transaction. |
| `description` | string | Y | Merchant-provided, buyer-readable explanation, 1–500 characters. |
| `related_event_id` | string | N | Related merchant business event identifier, 1–128 characters. |
| `occur_time` | integer (int64) | Y | Unix time in milliseconds when the points transaction occurred. |
#### MembershipRedeem SPI
**SPI Code**: `MEMBERSHIP_REDEEM` · **Version**: `202609` · **Direction**: TikTok Shop → Merchant / ISV
Atomically deducts the full points cost for a selected reward. TikTok Shop issues the coupon separately after a successful deduction.
##### Request Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `buyer_id` | string | Y | TikTok Shop buyer identifier, 1–64 characters. |
| `shop_open_id` | string | Y | Encoded TikTok Shop shop identifier, 1–128 characters. |
| `tts_shop_id` | string | N | TikTok Shop ID, 1–64 characters. If omitted, continue processing with existing identifiers. |
| `merchant_member_id` | string | Y | Stable merchant membership identifier, 1–128 characters. |
| `reward_type` | string enum | Y | `COUPON` in this version. |
| `reward_id` | string | Y | Selected reward identifier, 1–64 characters. |
| `points_to_deduct` | integer (int64) | Y | Exact positive whole-number points cost; minimum 1. Partial deduction is unsupported. |
| `idempotency_key` | string (UUID) | Y | Stable business key. Retries must use the same key and identical payload. |
##### Response Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `redeem_status` | string enum | Y | `SUCCEEDED` or `REJECTED`. |
| `redemption_id` | string | Conditional | Required for `SUCCEEDED`; 1–128 characters. Prohibited for `REJECTED`. |
| `deducted_points` | integer (int64) | Conditional | Required for `SUCCEEDED`; minimum 1 and must equal points_to_deduct. Prohibited for `REJECTED`. |
| `points` | integer (int64) | Conditional | Required for `SUCCEEDED`; non-negative balance after deduction. Prohibited for `REJECTED`. |
| `reason_code` | string enum | Conditional | Required for `REJECTED`; prohibited for `SUCCEEDED`. |
| `reason_message` | string | N | Optional for `REJECTED`, maximum 500 characters; prohibited for `SUCCEEDED`. |
##### Response Examples
**Success**
```JSON
{
  "redeem_status": "SUCCEEDED",
  "redemption_id": "REDEMPTION_10001",
  "deducted_points": 100,
  "points": 1150
}
```

**Rejected**
```JSON
{
  "redeem_status": "REJECTED",
  "reason_code": "INSUFFICIENT_POINTS",
  "reason_message": "The member does not have sufficient available points."
}
```

##### Business Rules

* A duplicate request with the same idempotency key returns the original result and must not deduct points again.
* SUCCEEDED means the full requested amount was deducted exactly once; REJECTED means no points were deducted.
* Use MembershipRedeemReverse only after coupon issuance definitively fails.

##### Rejection Reason Codes
| Reason Code | Meaning |
| --- | --- |
| `INSUFFICIENT_POINTS` | Available balance is below the requested cost. |
| `MEMBER_NOT_FOUND` | No active membership relationship matches the buyer and shop. |
| `REWARD_NOT_AVAILABLE` | The selected reward or exchange rule is unavailable. |
#### MembershipRedeemReverse SPI
**SPI Code**: `MEMBERSHIP_REDEEM_REVERSE` · **Version**: `202609` · **Direction**: TikTok Shop → Merchant / ISV
Restores the full points amount from a successful redemption when coupon issuance definitively fails.
##### Request Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `buyer_id` | string | Y | Buyer identifier from the original redemption, 1–64 characters. |
| `shop_open_id` | string | Y | Encoded shop identifier from the original redemption, 1–128 characters. |
| `tts_shop_id` | string | N | TikTok Shop ID, 1–64 characters. |
| `merchant_member_id` | string | Y | Merchant membership identifier from the original redemption, 1–128 characters. |
| `reward_type` | string enum | Y | `COUPON` in this version; must match the original redemption. |
| `reward_id` | string | Y | Reward identifier from the original redemption, 1–64 characters. |
| `redemption_id` | string | Y | Identifier returned by the successful MembershipRedeem call, 1–128 characters. |
| `points_to_reverse` | integer (int64) | Y | Exact positive whole-number points to restore; minimum 1 and must equal the full original deduction. |
| `reverse_reason` | string enum | Y | `COUPON_ISSUE_FAILED` in this version. |
| `idempotency_key` | string (UUID) | Y | Stable reversal key. Retries must use the same key and identical payload. |
##### Response Parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `reverse_status` | string enum | Y | `SUCCEEDED` or `REJECTED`. |
| `reversed_points` | integer (int64) | Conditional | Required for `SUCCEEDED`; minimum 1. Prohibited for `REJECTED`. |
| `points` | integer (int64) | Conditional | Required for `SUCCEEDED`; non-negative balance after reversal. Prohibited for `REJECTED`. |
| `reason_code` | string enum | Conditional | Required for `REJECTED`; prohibited for `SUCCEEDED`. |
| `reason_message` | string | N | Optional for `REJECTED`, maximum 500 characters; prohibited for `SUCCEEDED`. |
##### Response Examples
**Success**
```JSON
{
  "reverse_status": "SUCCEEDED",
  "reversed_points": 100,
  "points": 1250
}
```

**Rejected**
```JSON
{
  "reverse_status": "REJECTED",
  "reason_code": "REDEMPTION_NOT_FOUND",
  "reason_message": "No successful original redemption was found."
}
```

##### Business Rules

* Credit the same membership account that was debited by the original redemption.
* Partial reversal is unsupported; points_to_reverse must equal the full original deduction.
* A duplicate request with the same idempotency key returns the original result and must not credit points again.
* Reject the request if the buyer, member, reward, redemption ID, or points amount does not match the original redemption.

##### Rejection Reason Codes
| Reason Code | Meaning |
| --- | --- |
| `REDEMPTION_NOT_FOUND` | No matching original redemption was found. |
| `REDEMPTION_NOT_SUCCEEDED` | The original redemption did not succeed, so there is nothing to reverse. |
| `REDEMPTION_MISMATCH` | Buyer, membership, reward, redemption, or points details do not match the original record. |
### Webhooks

* Order webhook: https://partner.tiktokshop.com/docv2/page/1-order-status-change#Back%20To%20Top
* Refund webhook: https://partner.tiktokshop.com/docv2/page/8y10pibm

### Security and Compliance Notes

* APIs only transmit the minimum necessary fields required for membership integration.
* Plaintext sensitive information such as phone number, email, name, or address should not appear in the standard interface parameters defined in this document. If matching requires such data, use compliant handling approaches agreed by both parties, such as hashed or encrypted identifiers.
* Callers should retain the `request_id` in request logs for retries, troubleshooting, and reconciliation.
* Merchants should ignore unknown extended fields to ensure backward compatibility.

#### Masking Approach: Email 
**We do not mask the domain, only the local part.**
**Email is the only user information we transmit.** 

* For the local part, we have the following rules depending on the length of the local part n:
   * n = 1: eg. a@gmail.com -> *@gmail.com
   * n = 2: eg. ab@gmail.com -> a*@gmail.com
   * n = 3: eg. abc@gmail.com -> a*c@gmail.com
   * n = 4: eg. abcd@gmail.com -> a**d@gmail.com
   * n = 5: eg. abcde@gmail.com -> a***e@gmail.com 
   * n = 6: eg. abcdef@gmail.com -> a****f@gmail.com
   * n > 6: eg. abcdefg@gmail.com -> a****fg@gmail.com (mask at most 4 characters)
* This masking approach is used in the following API/SPI in the email field:
   * **MembershipBindCheck** SPI:
      * We mask members' email regardlessly 
      * For the return result, the matched emails must be returned as the mask-opposite of the input:

```JSON
Original email: abcdefg@gmail.com
Input email: a****fg@gmail.com
Output email: *bcde**@gmail.com 
Result: Match!
```

   * **MembershipBind** SPI: 
      *  We only mask new members who have not had an order in the past 90 days at the given shop
   * **MemberInfoQuery** API:
      * We only mask members who have not had an order in the past 90 days at the given shop

#### Authentication Approach

* What are the authentication methods for TTS API, SPI, and webhooks? 
   1. API (ISV -> TTS):
      1. TTS APIs are verified with two fields: **x-tts-access-token (header)**, which is token value retrieved from **GetAccessToken** API; **shop-cipher (query)**, which is used to transmit the shop information, this value can be retrieved from [GetAuthorizedShops API](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309#Back%20To%20Top) **** (examples on how the request header, query, body should be configured via link)
      2. Authentication overview: https://partner.tiktokshop.com/docv2/page/authorization-overview-202407
   1. SPI (TTS -> ISV): 
      * Depends on the 3rd party, we currently use **IP Whitelist.** 
      * We also carry a field that has the value of the app secret created by ISV on our TTSPC platform, ISV could use this app secret to authenticate. 
      3. The TTS SPI should be verified with **x-tt-signature (header).** 
      4. The algorithm of the signature generation is below, please refer to this algorithm to verify the signature. For more information, please check [[External] SPI Integration Guide](https://bytedance.my.larkoffice.com/docx/HUa8diEO6oXem2xrZ3um8bbnyhc)

```JSON
canonical_query = Canonicalize(raw_query)

plaintext =
    app_secret
    + canonical_path
    + canonical_query
    + request_body
    + unix_timestamp
    + app_secret

signature = lowercase_hex(
    HMAC-SHA256(
        key  = app_secret,
        data = plaintext
    )
)
```

3. Webhook (TTS -> ISV):
   1. TTS webhooks are listed here in the official webhook documentation: https://partner.tiktokshop.com/docv2/page/1-order-status-change#Back%20To%20Top
   2. The webhook configuration guide includes information on how to authenticate TTS webhooks [https://partner.tiktokshop.com/docv2/page/configuration-guide#Back%20To%20Top](https://partner.tiktokshop.com/docv2/page/configuration-guide#Back%20To%20Top)

```JSON
signature_base_string = app_key + raw_request_body  
signature = HMAC-SHA256(signature_base_string, app_secret)
```

### Suggested Testing

* Please test your app end-to-end before launching. Below are some of the test cases you can test out, but please create your own test cases to ensure the behavior meets expectation before publishing.
* User Journey: [Loyalty Program User Experience and Incentive Policy](https://bytedance.larkoffice.com/wiki/TUkEwcpvviIVeKkPM4tc8VQunJQ)
* Please refer to the TTS developer guide for official E2E testing material: https://partner.tiktokshop.com/docv2/page/tts-developer-guide
1. **Prerequisites**
   1. **Environment and shop**
      1. In [TTS Partner Center](https://partner.tiktokshop.com/), Create a **Full Function Development Shop** (under Development Kits -> Development Shops) for testing.
         1. Publish at least one test product and publish the Shop Home design.
         2. Install and authorize the ISV app on the same Development Shop used for testing.
      2. Create a dedicated Buyer Test TikTok Account in the same region as the Development Shop and link it to your test shop under Development Kits -> Development Shops.

      **Steps**

         1. Create a second new TikTok account in the TikTok app, preferably with a testing email address.
         2. Log in to the TikTok app with the account you want to use as the buyer test account.
         3. In Partner Center, go to **Development Kits > Sandbox > Buyer test accounts**.
         4. Click **Link account**.
         5. Use the TikTok app to scan the QR code on the **Link TikTok account as buyer account** page.
         6. Follow the **Authorize TikTok Partner Center** flow in the TikTok app.
         7. Click **Link the account** on the buyer-account linking page.

      **Important notes**

         * Do **not** use a production or personal TikTok account. Once linked as a test account, it is permanently converted and cannot be reversed.
         * The buyer TikTok account must be in the **same region/market** as the development shop.
         * For Full Function testing, you need at least two TikTok accounts: one **Official Test TikTok Account** and one **Buyer Test TikTok Account**.
         * You cannot use the same TikTok account as both the official account and the buyer test account.
         * You can link up to **10 Buyer Test TikTok Accounts** to one Partner Center account.
      3. Ask the TikTok Shop team to enable Loyalty/Membership API/SPIs for whitelisting and the required frontend configuration for the test shop.
2. **Sample Test Cases**

##### Unbound buyer precheck
**Preconditions:** the buyer has no active membership link; the test endpoint is published and online.

1. Open the member entry on Shop home page with the Buyer Test Account.
2. Trigger MembershipBindCheck/Precheck.
3. Capture the platform request ID and the ISV request ID.

**Expected result:** the SPI reaches the Integration Test URL, the response passes OAS validation, and the platform selects a valid registration or match path
##### Register and bind
**Preconditions:** the buyer profile is UNBOUND, mobile phone can receive OTP

1. Select Join in the TikTok App.
2. Complete the OTP step.
3. Confirm the MembershipBind/Register SPI reaches the ISV.
4. Return a successful OAS-valid response.
5. Query the final membership profile or run BindCheck again.

**Expected result:** the buyer profile is BOUND, the ISV has exactly one member/link record, and reopening the member page does not create a duplicate membership.
##### Idempotent bind retry

1. Send a valid Bind request and record the idempotency key.
2. Repeat the same request with the same key and payload.
3. Repeat the key with a different payload.

**Expected result:** the same key and payload returns the existing result without duplicate member creation or duplicate welcome reward; the same key with a different payload produces a deterministic conflict.
##### Points balance and transactions

1. Query a newly bound member with zero balance.
2. Query a member with a positive balance.
3. Query an empty transaction list and a paginated non-empty list.
4. Compare UI/platform values with the ISV ledger.

**Expected result:** balances and transaction history match the ISV ledger; pagination, order, type, and time fields conform to OAS; the response completes with clear latency margin below the platform timeout.
##### Unbind and rebind

1. Use the member-page menu to unlink the membership.
2. Confirm MembershipUnbind reaches the ISV.
3. Query the profile again.
4. Rebind the same buyer and verify the existing member is recognized.

**Expected result:** the profile becomes UNBOUND after unlink and returns to BOUND after rebind without losing the correct member identity or ledger.
##### How to create a test order?
Create the test order from Development Shop (Sandbox) Buyer View after you have a linked buyer test account and at least one live test product.
**Prerequisites**

* Go to Partner Center Console > Development Kits > Development Shops.
* Create or use a Development Shop test account.
* Link a customer/buyer test TikTok account from Development Kits > Development Shops > Manage accounts > Settings.
* Use a buyer account in the same market/region as the development shop.
* Do not use a production TikTok account as the test buyer; once linked in Development Shop, the account becomes a test account permanently.
* Make sure the development shop has a live test product. For buyer-side purchases in the TikTok app, use a Full Function development shop; Core Function accounts do not support real buyer purchases.

**Partner Center Test Order flow**
Partner Center
 -> Development Kits
 -> Development Shops
 -> Manage accounts
 -> Buyer View
 -> Create test order
 -> Select products
 -> Select shipping option
 -> Order created with On Hold status
### Appendix
#### Member Info Query

* Path: POST `/customer_engagement/202607/member_profiles/search`
* Example Request:

```Plain Text
curl -X POST \\ 
 'https://open-api.tiktokglobalshop.com/customer_engagement/:version/member_profiles/search?sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1623812664&app_key=38abcd&shop_cipher=GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3' \\ 
-H 'x-tts-access-token: TTP_pwSm2AAAAABmmtFz1xlyKMnwg74T2GJ5s0uQbS8jPjb_GkdFVCxPqzQXSyuyfXdQa0AqyDsea2tYFNVf4XeqgZHFfPyv0Vs659QqyLYfsGzanZ5XZAin3_ZkcIxxS0_In6u6XDeU96k' \\ 
-H 'content-type: application/json' \\ 
-d '{
  "buyer_ids": [
    "7451234567890123456"
  ]
}'
```

* Example Response:

```JSON
{
  "code": 0,
  "data": {
    "member_profiles": [
      {
        "bind_status": "BOUND",
        "buyer_id": "7451234567890123456",
        "email": "m***@example.com",
        "merchant_member_id": "MEMBER_10001",
        "points": 1250,
        "expiring_points": 200,
        "points_expire_time_ms": 1798761600000,
        "program_level_name": "GOLD",
        "update_time_ms": 1785168000000
      }
    ]
  },
  "message": "Success",
  "request_id": "202203070749000101890810281E8C70B7"
}
```

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/03808268ed9d47b69786c45829bdc467~tplv-k9wyc2ijk0-image.image)

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/fddc26a7056f49f58c5ef6296d97b970~tplv-k9wyc2ijk0-image.image)

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/f44e0e9967274e8fba6feb9736c586ba~tplv-k9wyc2ijk0-image.image)

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/3c4d946a71514ad593767cc483ffe6ba~tplv-k9wyc2ijk0-image.image)

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/f4fd74c558024b08af9cc702bc8a36d1~tplv-k9wyc2ijk0-image.image)

#### Member Profiles Batch Update

* Path: `/customer_engagement/202607/member_profiles/partial_edit`
* Example Request:

```JSON
curl -X POST \\ 
 'https://open-api.tiktokglobalshop.com/customer_engagement/:version/member_profiles/partial_edit?app_key=38abcd&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1623812664&shop_cipher=GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3' \\ 
-H 'x-tts-access-token: TTP_pwSm2AAAAABmmtFz1xlyKMnwg74T2GJ5s0uQbS8jPjb_GkdFVCxPqzQXSyuyfXdQa0AqyDsea2tYFNVf4XeqgZHFfPyv0Vs659QqyLYfsGzanZ5XZAin3_ZkcIxxS0_In6u6XDeU96k' \\ 
-H 'content-type: application/json' \\ 
-d '{
  "member_profiles": [
    {
      "bind_status": "BOUND",
      "buyer_id": "7451234567890123456",
      "idempotency_key": "7802d8ce-f651-4d7c-9431-0ad7c957921f",
      "merchant_member_id": "MEMBER_10001",
      "program_level_expire_time_ms": 1798761600000,
      "program_level_name": "GOLD",
      "update_time_ms": 1785168000000
    }
  ]
}'
```

* Example Response:

```JSON
{
  "code": 0,
  "data": {
    "fail_count": 1,
    "errors": [
      {
        "code": "INTERNAL_ERROR",
        "detail": {
          "buyer_id": "7451234567890123456",
          "idempotency_key": "7802d8ce-f651-4d7c-9431-0ad7c957921f",
          "merchant_member_id": "MEMBER_10001"
        },
        "message": ""
      }
    ],
    "success_count": 1,
    "successes": [
      {
        "buyer_id": "7451234567890123456",
        "idempotency_key": "7802d8ce-f651-4d7c-9431-0ad7c957921f",
        "merchant_member_id": "MEMBER_10001"
      }
    ],
    "total_count": 2
  },
  "message": "Success",
  "request_id": "202203070749000101890810281E8C70B7"
}
```

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/31d8741b717747248d62731623cec2c5~tplv-k9wyc2ijk0-image.image)

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/dc651f316585479c8f10b8c093ddc268~tplv-k9wyc2ijk0-image.image)

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/b5b77fb679c74c94b28b93b32a6ba71f~tplv-k9wyc2ijk0-image.image)

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/33311fa3ee2e4b878463262ebb78fdf9~tplv-k9wyc2ijk0-image.image)

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/d215c25dc0b347f2abb1531e5a0efb54~tplv-k9wyc2ijk0-image.image)

# Danh mục API TikTok Shop (bản mới nhất trên Partner Center)

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.


Tổng: **318 API** + 26 trang tổng quan, 19 nhóm. Partner Center chỉ hiện **phiên bản mới nhất** của mỗi API; bản cũ hơn có thể vẫn chạy nhưng không còn trong mục lục.

Chi tiết từng API (tham số, response, lỗi): `reference/api/<nhóm>.md`. Dạng máy đọc: `reference/catalog/api-catalog.json`.


## Authorization → `reference/api/authorization.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Get Authorized Category Assets](https://partner.tiktokshop.com/docv2/page/get-authorized-category-assets-202405) | GET | `/authorization/202405/category_assets` | partner.authorization.info |  | 2026-10-13 |
| [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309) | GET | `/authorization/202309/shops` | seller.authorization.info, seller.fs.order&fufillment.management |  | 2026-10-28 |

## Event → `reference/api/event.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Get Shop Webhooks](https://partner.tiktokshop.com/docv2/page/get-shop-webhooks-202309) | GET | `/event/202309/webhooks` | seller.authorization.info |  | 2026-10-13 |
| [Update Shop Webhook](https://partner.tiktokshop.com/docv2/page/update-shop-webhook-202309) | PUT | `/event/202309/webhooks` | seller.authorization.info |  | 2026-10-13 |
| [Delete Webhook for an Event](https://partner.tiktokshop.com/docv2/page/delete-webhook-for-an-event-202309) | DELETE | `/event/202309/webhooks` | seller.authorization.info |  | 2026-10-13 |

## Seller → `reference/api/seller.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Seller API overview](https://partner.tiktokshop.com/docv2/page/seller-api-overview) (tổng quan) | | | | | 2025-05-27 |
| [Get Active Shops](https://partner.tiktokshop.com/docv2/page/get-active-shops-202309) | GET | `/seller/202309/shops` | seller.shop.info |  | 2026-10-13 |
| [Get Global Product Permission](https://partner.tiktokshop.com/docv2/page/get-global-product-permission-202309) | GET | `/seller/202309/permissions` | seller.shop.info |  | 2026-10-13 |
| [Get Shop Group and Related Shops](https://partner.tiktokshop.com/docv2/page/get-shop-group-and-related-shops-202601) | GET | `/seller/202601/shop_groups` | seller.authorization.info |  | 2026-10-13 |

## Products → `reference/api/products.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Products API overview](https://partner.tiktokshop.com/docv2/page/products-api-overview) (tổng quan) | | | | | 2025-05-27 |
| [Listing quality diagnosis](https://partner.tiktokshop.com/docv2/page/listing-quality-diagnosis) (tổng quan) | | | | | 2025-10-16 |
| [Product pricing](https://partner.tiktokshop.com/docv2/page/product-pricing) (tổng quan) | | | | | 2026-07-01 |
| [Common mistakes](https://partner.tiktokshop.com/docv2/page/common-mistakes) (tổng quan) | | | | | 2025-05-15 |
| [Check Listing Prerequisites](https://partner.tiktokshop.com/docv2/page/check-listing-prerequisites-202312) | GET | `/product/202312/prerequisites` | seller.product.basic |  | 2026-10-28 |
| [Get Categories](https://partner.tiktokshop.com/docv2/page/get-categories-202309) | GET | `/product/202309/categories` | seller.product.basic |  | 2026-10-28 |
| [Recommend Category](https://partner.tiktokshop.com/docv2/page/recommend-category-202309) | POST | `/product/202309/categories/recommend` | seller.product.basic |  | 2026-10-26 |
| [Get Category Rules](https://partner.tiktokshop.com/docv2/page/get-category-rules-202309) | GET | `/product/202309/categories/{category_id}/rules` | seller.product.basic |  | 2026-10-28 |
| [Get Category Attributes](https://partner.tiktokshop.com/docv2/page/get-category-attributes-202309) | GET | `/product/202309/categories/{category_id}/attributes` | seller.product.basic |  | 2026-10-26 |
| [Get Brands](https://partner.tiktokshop.com/docv2/page/get-brands-202309) | GET | `/product/202309/brands` | seller.product.basic |  | 2026-10-28 |
| [Create Custom Brands](https://partner.tiktokshop.com/docv2/page/create-custom-brands-202309) | POST | `/product/202309/brands` | seller.product.basic |  | 2026-10-26 |
| [Check Product Listing](https://partner.tiktokshop.com/docv2/page/check-product-listing-202309) | POST | `/product/202309/products/listing_check` | seller.product.basic, serller.product.optimize |  | 2026-10-26 |
| [Upload Product Image](https://partner.tiktokshop.com/docv2/page/upload-product-image-202309) | POST | `/product/202309/images/upload` | seller.product.basic |  | 2026-10-28 |
| [Upload Product File](https://partner.tiktokshop.com/docv2/page/upload-product-file-202309) | POST | `/product/202309/files/upload` | seller.product.basic |  | 2026-10-26 |
| [Search Size Charts](https://partner.tiktokshop.com/docv2/page/search-size-charts-202407) | POST | `/product/202407/sizecharts/search` | seller.product.basic |  | 2026-10-26 |
| [Create Product](https://partner.tiktokshop.com/docv2/page/create-product-202309) | POST | `/product/202309/products` | seller.product.write |  | 2026-10-28 |
| [Activate Products](https://partner.tiktokshop.com/docv2/page/activate-products-202309) | POST | `/product/202309/products/activate` | seller.product.basic |  | 2026-10-26 |
| [Deactivate Products](https://partner.tiktokshop.com/docv2/page/deactivate-products-202309) | POST | `/product/202309/products/deactivate` | seller.product.basic |  | 2026-10-26 |
| [Delete Products](https://partner.tiktokshop.com/docv2/page/delete-products-202309) | DELETE | `/product/202309/products` | seller.product.delete |  | 2026-10-28 |
| [Recover Products](https://partner.tiktokshop.com/docv2/page/recover-products-202309) | POST | `/product/202309/products/recover` | seller.product.delete |  | 2026-10-26 |
| [Get Product](https://partner.tiktokshop.com/docv2/page/get-product-202309) | GET | `/product/202309/products/{product_id}` | seller.product.basic |  | 2026-10-28 |
| [Search Products](https://partner.tiktokshop.com/docv2/page/search-products-202502) | POST | `/product/202502/products/search` | seller.product.basic |  | 2026-10-26 |
| [Update Price](https://partner.tiktokshop.com/docv2/page/update-price-202309) | POST | `/product/202309/products/{product_id}/prices/update` | seller.product.write |  | 2026-10-28 |
| [Update Inventory](https://partner.tiktokshop.com/docv2/page/update-inventory-202309) | POST | `/product/202309/products/{product_id}/inventory/update` | seller.product.write |  | 2026-10-28 |
| [Inventory Search](https://partner.tiktokshop.com/docv2/page/inventory-search-202309) | POST | `/product/202309/inventory/search` | seller.product.basic |  | 2026-10-28 |
| [Diagnose and Optimize Product](https://partner.tiktokshop.com/docv2/page/diagnose-and-optimize-product-202411) | POST | `/product/202411/products/diagnose_optimize` | serller.product.optimize |  | 2026-10-10 |
| [Get Product Diagnoses](https://partner.tiktokshop.com/docv2/page/get-product-diagnoses-202405) | GET | `/product/202405/products/diagnoses` | serller.product.optimize |  | 2026-10-28 |
| [Get Products SEO Words](https://partner.tiktokshop.com/docv2/page/get-products-seo-words-202405) | GET | `/product/202405/products/seo_words` | seller.product.basic |  | 2026-10-26 |
| [Get Recommended Product Title And Description](https://partner.tiktokshop.com/docv2/page/get-recommended-product-title-and-description-202405) | GET | `/product/202405/products/suggestions` | serller.product.optimize |  | 2026-10-26 |
| [Optimize Images](https://partner.tiktokshop.com/docv2/page/optimize-images-202404) | POST | `/product/202404/images/optimize` | seller.product.basic |  | 2026-10-10 |
| [Create Image Translation Tasks](https://partner.tiktokshop.com/docv2/page/create-image-translation-tasks-202505) | POST | `/product/202505/images/translation_tasks` | serller.product.optimize |  | 2026-10-10 |
| [Get Image Translation Tasks](https://partner.tiktokshop.com/docv2/page/get-image-translation-tasks-202506) | GET | `/product/202506/images/translation_tasks` | serller.product.optimize |  | 2026-07-21 |
| [Get Global Categories](https://partner.tiktokshop.com/docv2/page/get-global-categories-202309) | GET | `/product/202309/global_categories` | seller.global_product.category.info |  | 2026-10-28 |
| [Recommend Global Categories](https://partner.tiktokshop.com/docv2/page/recommend-global-categories-202309) | POST | `/product/202309/global_categories/recommend` | seller.global_product.category.info |  | 2026-10-26 |
| [Get Global Category Rules](https://partner.tiktokshop.com/docv2/page/get-global-category-rules-202309) | GET | `/product/202309/categories/{category_id}/global_rules` | seller.global_product.category.info |  | 2026-10-26 |
| [Get Global Attributes](https://partner.tiktokshop.com/docv2/page/get-global-attributes-202309) | GET | `/product/202309/categories/{category_id}/global_attributes` | seller.global_product.category.info |  | 2026-10-28 |
| [Create Global Product](https://partner.tiktokshop.com/docv2/page/create-global-product-202309) | POST | `/product/202309/global_products` | seller.global_product.write |  | 2026-10-28 |
| [Publish Global Product](https://partner.tiktokshop.com/docv2/page/publish-global-product-202309) | POST | `/product/202309/global_products/{global_product_id}/publish` | seller.global_product.write |  | 2026-10-28 |
| [Edit Global Product](https://partner.tiktokshop.com/docv2/page/edit-global-product-202309) | PUT | `/product/202309/global_products/{global_product_id}` | seller.global_product.write |  | 2026-10-28 |
| [Delete Global Products](https://partner.tiktokshop.com/docv2/page/delete-global-products-202309) | DELETE | `/product/202309/global_products` | seller.global_product.delete |  | 2026-10-26 |
| [Get Global Product](https://partner.tiktokshop.com/docv2/page/get-global-product-202309) | GET | `/product/202309/global_products/{global_product_id}` | seller.global_product.info |  | 2026-10-28 |
| [Search Global Products](https://partner.tiktokshop.com/docv2/page/search-global-products-202312) | POST | `/product/202312/global_products/search` | seller.global_product.info |  | 2026-10-28 |
| [Update Global Inventory](https://partner.tiktokshop.com/docv2/page/update-global-inventory-202309) | POST | `/product/202309/global_products/{global_product_id}/inventory/update` | seller.global_product.write |  | 2026-10-28 |
| [Create Manufacturer](https://partner.tiktokshop.com/docv2/page/create-manufacturer-202409) | POST | `/product/202409/compliance/manufacturers` | seller.product.basic |  | 2026-10-10 |
| [Partial Edit Manufacturer](https://partner.tiktokshop.com/docv2/page/partial-edit-manufacturer-202409) | POST | `/product/202409/compliance/manufacturers/{manufacturer_id}/partial_edit` | seller.product.basic |  | 2026-10-10 |
| [Search Manufacturers](https://partner.tiktokshop.com/docv2/page/search-manufacturers-202501) | POST | `/product/202501/compliance/manufacturers/search` | seller.product.basic |  | 2026-10-10 |
| [Create Responsible Person](https://partner.tiktokshop.com/docv2/page/create-responsible-person-202409) | POST | `/product/202409/compliance/responsible_persons` | seller.product.basic |  | 2026-10-10 |
| [Partial Edit Responsible Person](https://partner.tiktokshop.com/docv2/page/partial-edit-responsible-person-202409) | POST | `/product/202409/compliance/responsible_persons/{responsible_person_id}/partial_edit` | seller.product.basic |  | 2026-10-10 |
| [Search Responsible Persons](https://partner.tiktokshop.com/docv2/page/search-responsible-persons-202501) | POST | `/product/202501/compliance/responsible_persons/search` | seller.product.basic |  | 2026-10-10 |
| [Create Category Upgrade Task](https://partner.tiktokshop.com/docv2/page/create-category-upgrade-task-202407) | POST | `/product/202407/products/category_upgrade_task` | seller.product.basic |  | 2026-10-26 |
| [Get Global Listing Rules](https://partner.tiktokshop.com/docv2/page/get-global-listing-rules-202507) | GET | `/product/202507/global_listing_rules` | seller.product.basic |  | 2026-10-10 |
| [Replicate Product](https://partner.tiktokshop.com/docv2/page/replicate-product-202507) | POST | `/product/202507/products/{product_id}/global_replicate` | seller.product.write |  | 2026-10-15 |
| [Get Global Replicated Products](https://partner.tiktokshop.com/docv2/page/get-global-replicated-products-202507) | GET | `/product/202507/products/{product_id}/replicated_products` | seller.product.basic |  | 2026-10-10 |
| [Edit Product](https://partner.tiktokshop.com/docv2/page/edit-product-202509) | PUT | `/product/202509/products/{product_id}` | seller.product.write |  | 2026-10-28 |
| [Partial Edit Product](https://partner.tiktokshop.com/docv2/page/partial-edit-product-202509) | POST | `/product/202509/products/{product_id}/partial_edit` | seller.product.write |  | 2026-10-28 |
| [Partial Edit Global Product](https://partner.tiktokshop.com/docv2/page/partial-edit-global-product-202509) | PUT | `/product/202509/global_products/{global_product_id}/partial_edit` | seller.product.basic |  | 2026-10-10 |
| [Search Products for Compliance Auditing](https://partner.tiktokshop.com/docv2/page/search-products-for-compliance-auditing-202601) | POST | `/product/202601/compliance/auditing/research` | seller.product.basic |  | 2026-10-26 |
| [Get Product Package Recommendations](https://partner.tiktokshop.com/docv2/page/get-product-package-recommendations-202602) | POST | `/product/202602/packages/recommend` | seller.product.basic |  | 2026-10-10 |
| [Get Opportunity Detail](https://partner.tiktokshop.com/docv2/page/get-opportunity-detail-202604) | GET | `/product/202604/opportunities/{opportunity_id}` | seller.product.basic |  | 2026-10-10 |
| [List Opportunities](https://partner.tiktokshop.com/docv2/page/list-opportunities-202604) | POST | `/product/202604/opportunities/query` | seller.product.basic |  | 2026-10-10 |
| [Submit Product via Opportunity](https://partner.tiktokshop.com/docv2/page/submit-product-via-opportunity-202604) | POST | `/product/202604/opportunities/{opportunity_id}/submit` | seller.product.basic |  | 2026-10-10 |
| [Get Submission Records](https://partner.tiktokshop.com/docv2/page/get-submission-records-202604) | GET | `/product/202604/opportunities/submissions` | seller.product.basic |  | 2026-10-10 |
| [Create GPA Upgrade Task](https://partner.tiktokshop.com/docv2/page/create-gpa-upgrade-task-202604) | POST | `/product/202604/products/gpa_upgrade_task` | seller.product.basic |  | 2026-08-18 |
| [Submit Size Chart Appeal](https://partner.tiktokshop.com/docv2/page/submit-size-chart-appeal-202604) | POST | `/product/202604/appeals/submit` | seller.product.basic |  | 2026-10-10 |
| [List Product SKPP Statuses](https://partner.tiktokshop.com/docv2/page/list-product-skpp-statuses-202606) | POST | `/product/202606/skpps/search` | seller.product.basic |  | 2026-10-10 |
| [Get Product SKPP Detail](https://partner.tiktokshop.com/docv2/page/get-product-skpp-detail-202606) | GET | `/product/202606/skpps/{product_id}` | seller.product.basic |  | 2026-10-10 |
| [Get Shop SKPP Summary](https://partner.tiktokshop.com/docv2/page/get-shop-skpp-summary-202606) | GET | `/product/202606/skpps/sum` | seller.product.basic |  | 2026-10-10 |
| [Update Stock Operation Settings](https://partner.tiktokshop.com/docv2/page/update-stock-operation-settings-202608) | POST | `/product/202608/inventory/operation/settings` | seller.product.basic |  | 2026-10-26 |
| [Predict Product Package Dimensions and Weight](https://partner.tiktokshop.com/docv2/page/predict-product-package-dimensions-and-weight-202609) | POST | `/product/202609/products/package/predict` | seller.product.basic |  | 2026-09-28 |
| [Recommend Required Product Properties](https://partner.tiktokshop.com/docv2/page/recommend-required-product-properties-202609) | POST | `/product/202609/products/properties/recommend` | seller.product.basic |  | 2026-09-28 |
| [Submit Strikethrough Price](https://partner.tiktokshop.com/docv2/page/submit-strikethrough-price-202609) | POST | `/product/202609/products/{product_id}/strikethrough_price/submit` | seller.product.basic |  | 2026-09-28 |
| [Suggest Brands](https://partner.tiktokshop.com/docv2/page/suggest-brands-202609) | POST | `/product/202609/brands/suggest` |  |  | 2026-10-26 |
| [Create Size Chart V2](https://partner.tiktokshop.com/docv2/page/create-size-chart-v2-202610) | POST | `/product/202610/size_charts` | seller.product.basic |  | 2026-10-19 |
| [Edit Size Chart V2](https://partner.tiktokshop.com/docv2/page/edit-size-chart-v2-202610) | POST | `/product/202610/size_charts/edit` | seller.product.basic |  | 2026-10-19 |

## Promotion → `reference/api/promotion.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Promotion API overview](https://partner.tiktokshop.com/docv2/page/promotion-api-overview) (tổng quan) | | | | | 2025-04-11 |
| [Shipping discount supported areas](https://partner.tiktokshop.com/docv2/page/shipping-discount-supported-areas) (tổng quan) | | | | | 2026-10-09 |
| [Create Promotion Activity](https://partner.tiktokshop.com/docv2/page/create-promotion-activity-202309) | POST | `/promotion/202309/activities` | seller.promotion.write |  | 2026-10-28 |
| [Update Promotion Activity](https://partner.tiktokshop.com/docv2/page/update-promotion-activity-202309) | PUT | `/promotion/202309/activities/{activity_id}` | seller.promotion.write |  | 2026-10-28 |
| [Deactivate Activity](https://partner.tiktokshop.com/docv2/page/deactivate-activity-202309) | POST | `/promotion/202309/activities/{activity_id}/deactivate` | seller.promotion.write |  | 2026-10-28 |
| [Get Activity](https://partner.tiktokshop.com/docv2/page/get-activity-202309) | GET | `/promotion/202309/activities/{activity_id}` | seller.promotion.info |  | 2026-10-28 |
| [Search Promotion Activities](https://partner.tiktokshop.com/docv2/page/search-promotion-activities-202309) | POST | `/promotion/202309/activities/search` | seller.promotion.info |  | 2026-10-28 |
| [Update Promotion Activity Products](https://partner.tiktokshop.com/docv2/page/update-promotion-activity-products-202309) | PUT | `/promotion/202309/activities/{activity_id}/products` | seller.promotion.write |  | 2026-10-28 |
| [Remove Promotion Activity Products](https://partner.tiktokshop.com/docv2/page/remove-promotion-activity-products-202309) | DELETE | `/promotion/202309/activities/{activity_id}/products` | seller.promotion.write |  | 2026-10-28 |
| [Get Coupon](https://partner.tiktokshop.com/docv2/page/get-coupon-202406) | GET | `/promotion/202406/coupons/{coupon_id}` | seller.promotion.info, seller.customer_service |  | 2026-10-28 |
| [Search Coupon List](https://partner.tiktokshop.com/docv2/page/search-coupon-list-202406) | POST | `/promotion/202406/coupons/search` | seller.promotion.info, seller.customer_service |  | 2026-10-28 |
| [Republish Activity](https://partner.tiktokshop.com/docv2/page/republish-activity-202607) | POST | `/promotion/202607/activities/{activity_id}/republish` | seller.promotion.write |  | 2026-10-10 |

## Orders → `reference/api/orders.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Order API overview](https://partner.tiktokshop.com/docv2/page/order-api-overview) (tổng quan) | | | | | 2025-07-16 |
| [Get Order List](https://partner.tiktokshop.com/docv2/page/get-order-list-202309) | POST | `/order/202309/orders/search` | seller.order.info, seller.fs.order&fufillment.management |  | 2026-10-28 |
| [Get Order Price Details](https://partner.tiktokshop.com/docv2/page/get-order-price-details-202407) | GET | `/order/202407/orders/{order_id}/price_detail` | seller.order.info |  | 2026-10-26 |
| [Add External Order References](https://partner.tiktokshop.com/docv2/page/add-external-order-references-202406) | POST | `/order/202406/orders/external_orders` | seller.order.ext_ref.write.custom, seller.order.ext_ref.write |  | 2026-10-10 |
| [Get External Order References](https://partner.tiktokshop.com/docv2/page/get-external-order-references-202406) | GET | `/order/202406/orders/{order_id}/external_orders` | seller.order.ext_ref.read |  | 2026-10-10 |
| [Search Orders by External Order Reference](https://partner.tiktokshop.com/docv2/page/search-orders-by-external-order-reference-202406) | POST | `/order/202406/orders/external_order_search` | seller.order.ext_ref.read |  | 2026-10-10 |
| [Get Order Detail](https://partner.tiktokshop.com/docv2/page/get-order-detail-202507) | GET | `/order/202507/orders` | seller.order.info, seller.fs.order&fufillment.management |  | 2026-10-28 |
| [Update The Blind Box Opening Results](https://partner.tiktokshop.com/docv2/page/update-the-blind-box-opening-results-202605) | POST | `/order/202605/orders/blind_box_result/callback` | seller.order.info |  | 2026-10-10 |
| [Search POD Customization Details](https://partner.tiktokshop.com/docv2/page/search-pod-customization-details-202606) | POST | `/order/202606/pod_details/search` | seller.order.info |  | 2026-10-14 |

## Fulfillment → `reference/api/fulfillment.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Fulfillment API overview](https://partner.tiktokshop.com/docv2/page/fulfillment-api-overview) (tổng quan) | | | | | 2026-08-26 |
| [UK & EU: Purchase shipping labels from TikTok](https://partner.tiktokshop.com/docv2/page/i83mvdfg) (tổng quan) | | | | | 2025-10-08 |
| [Get Order Split Attributes](https://partner.tiktokshop.com/docv2/page/get-order-split-attributes-202309) | GET | `/fulfillment/202309/orders/split_attributes` | seller.fulfillment.package.write, seller.fs.order&fufillment.management |  | 2026-10-26 |
| [Confirm Order Split](https://partner.tiktokshop.com/docv2/page/confirm-order-split-202309) | POST | `/fulfillment/202309/orders/{order_id}/split` | seller.fulfillment.package.write, seller.fs.order&fufillment.management |  | 2026-10-26 |
| [Get Eligible Shipping Services](https://partner.tiktokshop.com/docv2/page/get-eligible-shipping-services-202309) | POST | `/fulfillment/202309/orders/{order_id}/shipping_services/query` | seller.fulfillment.basic |  | 2026-10-26 |
| [Create First Mile Bundle](https://partner.tiktokshop.com/docv2/page/create-first-mile-bundle-202407) | POST | `/fulfillment/202407/bundles` | seller.fulfillment.basic |  | 2026-10-10 |
| [Search Package](https://partner.tiktokshop.com/docv2/page/search-package-202309) | POST | `/fulfillment/202309/packages/search` | seller.fulfillment.basic |  | 2026-10-26 |
| [Search Combinable Packages](https://partner.tiktokshop.com/docv2/page/search-combinable-packages-202309) | GET | `/fulfillment/202309/combinable_packages/search` | seller.fulfillment.package.write |  | 2026-10-26 |
| [Combine Package](https://partner.tiktokshop.com/docv2/page/combine-package-202309) | POST | `/fulfillment/202309/packages/combine` | seller.fulfillment.package.write |  | 2026-10-26 |
| [Uncombine Packages](https://partner.tiktokshop.com/docv2/page/uncombine-packages-202309) | POST | `/fulfillment/202309/packages/{package_id}/uncombine` | seller.fulfillment.package.write |  | 2026-10-26 |
| [Get Package Handover Time Slots](https://partner.tiktokshop.com/docv2/page/get-package-handover-time-slots-202309) | GET | `/fulfillment/202309/packages/{package_id}/handover_time_slots` | seller.fulfillment.package.write |  | 2026-10-26 |
| [Ship Package](https://partner.tiktokshop.com/docv2/page/ship-package-202309) | POST | `/fulfillment/202309/packages/{package_id}/ship` | seller.fulfillment.basic, seller.fs.order&fufillment.management |  | 2026-10-28 |
| [Batch Ship Packages](https://partner.tiktokshop.com/docv2/page/batch-ship-packages-202309) | POST | `/fulfillment/202309/packages/ship` | seller.fulfillment.basic, seller.fs.order&fufillment.management |  | 2026-10-28 |
| [Get Package Shipping Document](https://partner.tiktokshop.com/docv2/page/get-package-shipping-document-202309) | GET | `/fulfillment/202309/packages/{package_id}/shipping_documents` | seller.fulfillment.basic, seller.fs.order&fufillment.management |  | 2026-10-28 |
| [Get Package Detail](https://partner.tiktokshop.com/docv2/page/get-package-detail-202309) | GET | `/fulfillment/202309/packages/{package_id}` | seller.fulfillment.basic, seller.fs.order&fufillment.management |  | 2026-10-26 |
| [Get Order Tracking](https://partner.tiktokshop.com/docv2/page/get-order-tracking-202309) | GET | `/fulfillment/202309/orders/{order_id}/tracking` | seller.logistics |  | 2026-10-10 |
| [Update Order Shipping Info](https://partner.tiktokshop.com/docv2/page/update-order-shipping-info-202309) | POST | `/fulfillment/202309/orders/{order_id}/shipping_info/update` | seller.logistics |  | 2026-10-28 |
| [Upload Proof of Delivery File](https://partner.tiktokshop.com/docv2/page/upload-proof-of-delivery-file-202309) | POST | `/fulfillment/202309/files/upload` | seller.fulfillment.basic |  | 2026-10-10 |
| [Upload Proof of Delivery Image](https://partner.tiktokshop.com/docv2/page/upload-proof-of-delivery-image-202309) | POST | `/fulfillment/202309/images/upload` | seller.fulfillment.basic |  | 2026-10-10 |
| [Update Package Delivery Status](https://partner.tiktokshop.com/docv2/page/update-package-delivery-status-202309) | POST | `/fulfillment/202309/packages/deliver` | seller.delivery.status.write |  | 2026-10-26 |
| [Upload Invoice](https://partner.tiktokshop.com/docv2/page/upload-invoice-202502) | POST | `/fulfillment/202502/invoice/upload` | seller.fulfillment.basic |  | 2026-10-16 |
| [Check TikTok Shipping and Collection by TikTok Coverage](https://partner.tiktokshop.com/docv2/page/check-tiktok-shipping-and-collection-by-tiktok-coverage-202508) | GET | `/fulfillment/202508/tts_tracking_validation` | seller.logistics |  | 2026-10-10 |
| [Create First Mile Bundle(V2)](https://partner.tiktokshop.com/docv2/page/create-first-mile-bundle-v2-202510) | POST | `/fulfillment/202510/first_mile_bundle` | seller.fulfillment.basic |  | 2026-10-10 |
| [Create Packages](https://partner.tiktokshop.com/docv2/page/create-packages-202512) | POST | `/fulfillment/202512/packages` | seller.fulfillment.basic, seller.fs.order&fufillment.management |  | 2026-10-28 |
| [Submit Redemption Information](https://partner.tiktokshop.com/docv2/page/submit-redemption-information-202601) | POST | `/fulfillment/202601/redeem_info/callback` | seller.redeem_info.write |  | 2026-10-10 |
| [Get POD Customization Details](https://partner.tiktokshop.com/docv2/page/get-pod-customization-details-202606) | POST | `/fulfillment/202606/pod_details/get` | seller.redeem_info.write |  | 2026-10-10 |
| [Get Order Customs Requirements](https://partner.tiktokshop.com/docv2/page/get-order-customs-requirements-202607) | POST | `/fulfillment/202607/orders/customs_info/query` | seller.fulfillment.basic |  | 2026-10-10 |
| [Submit Customs Clearance Information](https://partner.tiktokshop.com/docv2/page/submit-customs-clearance-information-202607) | POST | `/fulfillment/202607/orders/customs_info/submit` | seller.fulfillment.basic |  | 2026-10-10 |
| [Tracking status update](https://partner.tiktokshop.com/docv2/page/tracking-status-update-202609) | POST | `/fulfillment/202609/order/sof/track/update` | seller.fulfillment.basic |  | 2026-09-17 |
| [Update Package Shipping Info](https://partner.tiktokshop.com/docv2/page/update-package-shipping-info-202610) | POST | `/fulfillment/202610/packages/{package_id}/shipping_info/update` | seller.fulfillment.basic, seller.fs.order&fufillment.management |  | 2026-10-28 |
| [Mark Package As Shipped](https://partner.tiktokshop.com/docv2/page/mark-package-as-shipped-202610) | POST | `/fulfillment/202610/orders/{order_id}/packages` | seller.fulfillment.basic, seller.fs.order&fufillment.management |  | 2026-10-28 |

## Fulfilled by TikTok (FBT) → `reference/api/fulfilled-by-tiktok-fbt.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [FBT Inbound API — Overview Guide](https://partner.tiktokshop.com/docv2/page/16f0ojsg) (tổng quan) | | | | | 2026-05-06 |
| [Get FBT Merchant Onboarded Regions](https://partner.tiktokshop.com/docv2/page/get-fbt-merchant-onboarded-regions-202409) | GET | `/fbt/202409/merchants/onboarded_regions` | seller.fbt.info |  | 2025-12-18 |
| [Get FBT Warehouse List](https://partner.tiktokshop.com/docv2/page/get-fbt-warehouse-list-202408) | GET | `/fbt/202408/warehouses` | seller.fbt.info |  | 2026-10-11 |
| [Search FBT Inventory](https://partner.tiktokshop.com/docv2/page/search-fbt-inventory-202408) | POST | `/fbt/202408/inventory/search` | seller.fbt.info |  | 2026-10-11 |
| [Search FBT Inventory Record](https://partner.tiktokshop.com/docv2/page/search-fbt-inventory-record-202410) | POST | `/fbt/202410/inventory_records/search` | seller.fbt.info |  | 2026-10-11 |
| [Get FBT MCF Order Status](https://partner.tiktokshop.com/docv2/page/get-fbt-mcf-order-status-202601) | GET | `/fbt/202601/mcf_outbound_orders` | seller.fbt.info |  | 2026-10-11 |
| [Cancel FBT MCF Order](https://partner.tiktokshop.com/docv2/page/cancel-fbt-mcf-order-202601) | POST | `/fbt/202601/mcf_outbound_orders/cancel` | seller.fbt.info |  | 2026-10-11 |
| [Query Goods Inventory For MCF](https://partner.tiktokshop.com/docv2/page/query-goods-inventory-for-mcf-202601) | POST | `/fbt/202601/mcf/goods/inventory/search` | seller.fbt.info |  | 2026-10-11 |
| [Get FBT Merchant MCF Status](https://partner.tiktokshop.com/docv2/page/get-fbt-merchant-mcf-status-202601) | GET | `/fbt/202601/merchants/mcf_status` | seller.fbt.info |  | 2026-10-11 |
| [Create or Update Inbound Plan](https://partner.tiktokshop.com/docv2/page/create-or-update-inbound-plan-202602) | POST | `/fbt/202602/create_update_inbound_plan` | seller.fbt.info |  | 2026-10-11 |
| [List Available Inbound Methods](https://partner.tiktokshop.com/docv2/page/list-available-inbound-methods-202602) | POST | `/fbt/202602/list_available_inbound_method` | seller.fbt.info |  | 2026-10-11 |
| [Get Inbound Method Detail](https://partner.tiktokshop.com/docv2/page/get-inbound-method-detail-202602) | POST | `/fbt/202602/inbound_method_detail` | seller.fbt.info |  | 2026-10-11 |
| [Print Inbound Order Labels](https://partner.tiktokshop.com/docv2/page/print-inbound-order-labels-202602) | POST | `/fbt/202602/inbound_orders/label_print` | seller.fbt.info |  | 2026-10-11 |
| [Update Inbound Order Tracking](https://partner.tiktokshop.com/docv2/page/update-inbound-order-tracking-202602) | POST | `/fbt/202602/inbound_orders/tracking_update` | seller.fbt.info |  | 2026-10-11 |
| [Cancel Inbound Order](https://partner.tiktokshop.com/docv2/page/cancel-inbound-order-202602) | POST | `/fbt/202602/inbound_orders/cancel` | seller.fbt.info |  | 2026-10-11 |
| [Get FBT Inbound Order Details](https://partner.tiktokshop.com/docv2/page/get-fbt-inbound-order-details-202602) | GET | `/fbt/202602/inbound_orders` | seller.fbt.info |  | 2026-10-11 |
| [Confirm Inbound Method](https://partner.tiktokshop.com/docv2/page/confirm-inbound-method-202603) | POST | `/fbt/202603/confirm_inbound_method` | seller.fbt.info |  | 2026-10-11 |
| [Ship Inbound Order](https://partner.tiktokshop.com/docv2/page/ship-inbound-order-202603) | POST | `/fbt/202603/ship_inbound_order` | seller.fbt.info |  | 2026-10-11 |
| [Update Goods-SKU Relations](https://partner.tiktokshop.com/docv2/page/update-goods-sku-relations-202603) | POST | `/fbt/202603/goods/update_goods_sku_relation` | seller.fbt.info |  | 2026-10-11 |
| [Search Goods Hazmat And Expiration Info](https://partner.tiktokshop.com/docv2/page/search-goods-hazmat-and-expiration-info-202603) | POST | `/fbt/202603/goods/hazmat_and_expiration_info/search` | seller.fbt.info |  | 2026-10-11 |
| [Create FBT MCF Order](https://partner.tiktokshop.com/docv2/page/create-fbt-mcf-order-202607) | POST | `/fbt/202607/mcf_outbound_orders` | seller.fbt.info |  | 2026-10-11 |
| [Search Goods Info](https://partner.tiktokshop.com/docv2/page/search-goods-info-202607) | POST | `/fbt/202607/goods/search` | seller.fbt.info |  | 2026-10-11 |
| [Update FBT Goods Info](https://partner.tiktokshop.com/docv2/page/update-fbt-goods-info-202607) | POST | `/fbt/202607/goods/update_goods_info` | seller.fbt.info |  | 2026-10-11 |
| [Create FBT Goods](https://partner.tiktokshop.com/docv2/page/create-fbt-goods-202607) | POST | `/fbt/202607/goods/create_goods` | seller.fbt.info |  | 2026-10-11 |

## Logistics → `reference/api/logistics.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Logistic API overview](https://partner.tiktokshop.com/docv2/page/logistic-api-overview) (tổng quan) | | | | | 2025-04-10 |
| [Additional Notes](https://partner.tiktokshop.com/docv2/page/1cjht3qx) (tổng quan) | | | | | 2026-09-16 |
| [Action_Code_Name](https://partner.tiktokshop.com/docv2/page/37tihrdq) (tổng quan) | | | | | 2026-07-01 |
| [Get Warehouse List](https://partner.tiktokshop.com/docv2/page/get-warehouse-list-202309) | GET | `/logistics/202309/warehouses` | seller.logistics |  | 2026-10-28 |
| [Get Global Seller Warehouses](https://partner.tiktokshop.com/docv2/page/get-global-seller-warehouses-202309) | GET | `/logistics/202309/global_warehouses` | seller.shop.info |  | 2026-10-10 |
| [Get Warehouse Delivery Options](https://partner.tiktokshop.com/docv2/page/get-warehouse-delivery-options-202309) | GET | `/logistics/202309/warehouses/{warehouse_id}/delivery_options` | seller.logistics |  | 2026-10-28 |
| [Get Shipping Providers](https://partner.tiktokshop.com/docv2/page/get-shipping-providers-202309) | GET | `/logistics/202309/delivery_options/{delivery_option_id}/shipping_providers` | seller.fulfillment.basic, seller.logistics, seller.fs.order&fufillment.management |  | 2026-10-28 |
| [Get Shipping Template Availability](https://partner.tiktokshop.com/docv2/page/get-shipping-template-availability-202510) | GET | `/logistics/202510/seller_templates` | seller.logistics |  | 2026-10-10 |
| [Get Logistics Tracking](https://partner.tiktokshop.com/docv2/page/get-logistics-tracking-202604) | GET | `/logistics/202604/orders/{order_id}/tracking` | seller.logistics |  | 2026-10-10 |
| [Check Shipping Template Existence](https://partner.tiktokshop.com/docv2/page/check-shipping-template-existence-202606) | GET | `/logistics/202606/seller_template/template_exist` | seller.logistics |  | 2026-10-10 |

## Return and refund → `reference/api/return-and-refund.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Return, refund, and cancel API overview](https://partner.tiktokshop.com/docv2/page/return-refund-and-cancel-api-overview) (tổng quan) | | | | | 2026-07-08 |
| [Return reasons](https://partner.tiktokshop.com/docv2/page/return-reasons) (tổng quan) | | | | | 2026-05-08 |
| [Refund reasons](https://partner.tiktokshop.com/docv2/page/refund-reasons) (tổng quan) | | | | | 2026-02-19 |
| [Cancel reasons](https://partner.tiktokshop.com/docv2/page/cancel-reasons) (tổng quan) | | | | | 2026-10-16 |
| [Get Reject Reasons](https://partner.tiktokshop.com/docv2/page/get-reject-reasons-202309) | GET | `/return_refund/202309/reject_reasons` | seller.return_refund.basic |  | 2026-05-01 |
| [Approve Return](https://partner.tiktokshop.com/docv2/page/approve-return-202309) | POST | `/return_refund/202309/returns/{return_id}/approve` | seller.return_refund.basic |  | 2026-10-13 |
| [Get Return Records](https://partner.tiktokshop.com/docv2/page/get-return-records-202309) | GET | `/return_refund/202309/returns/{return_id}/records` | seller.return_refund.basic |  | 2026-10-13 |
| [Approve Cancellation](https://partner.tiktokshop.com/docv2/page/approve-cancellation-202309) | POST | `/return_refund/202309/cancellations/{cancel_id}/approve` | seller.return_refund.basic |  | 2026-10-13 |
| [Reject Cancellation](https://partner.tiktokshop.com/docv2/page/reject-cancellation-202309) | POST | `/return_refund/202309/cancellations/{cancel_id}/reject` | seller.return_refund.basic |  | 2026-10-13 |
| [Upload Return Shipping Information](https://partner.tiktokshop.com/docv2/page/upload-return-shipping-information-202405) | POST | `/return_refund/202405/returns/shipping_documents` | seller.return_refund.basic |  | 2026-10-28 |
| [Get Decision Eligibility](https://partner.tiktokshop.com/docv2/page/get-decision-eligibility-202601) | GET | `/return_refund/202601/decision_eligibility` | seller.return_refund.basic |  | 2026-10-13 |
| [Calculate Refund](https://partner.tiktokshop.com/docv2/page/calculate-refund-202602) | POST | `/return_refund/202602/refunds/calculate` | seller.return_refund.basic |  | 2026-10-13 |
| [Cancel Order](https://partner.tiktokshop.com/docv2/page/cancel-order-202602) | POST | `/return_refund/202602/cancellations` | seller.return_refund.basic |  | 2026-10-28 |
| [Create Return](https://partner.tiktokshop.com/docv2/page/create-return-202602) | POST | `/return_refund/202602/returns` | seller.fulfillment.basic, seller.return_refund.basic |  | 2026-10-28 |
| [Search Cancellations](https://partner.tiktokshop.com/docv2/page/search-cancellations-202602) | POST | `/return_refund/202602/cancellations/search` | seller.return_refund.basic |  | 2026-10-28 |
| [Search Returns](https://partner.tiktokshop.com/docv2/page/search-returns-202602) | POST | `/return_refund/202602/returns/search` | seller.return_refund.basic |  | 2026-10-28 |
| [Get Aftersale Eligibility](https://partner.tiktokshop.com/docv2/page/get-aftersale-eligibility-202602) | GET | `/return_refund/202602/orders/{order_id}/aftersale_eligibility` | seller.return_refund.basic |  | 2026-10-13 |
| [Search Aftersales Requests](https://partner.tiktokshop.com/docv2/page/search-aftersales-requests-202603) | POST | `/return_refund/202603/aftersales/search` | seller.return_refund.basic |  | 2026-10-13 |
| [Search Return Merchandise Authorizations](https://partner.tiktokshop.com/docv2/page/search-return-merchandise-authorizations-202604) | POST | `/return_refund/202604/rma/search` | seller.return_refund.basic |  | 2026-10-13 |
| [Get Available Review Decisions](https://partner.tiktokshop.com/docv2/page/get-available-review-decisions-202606) | GET | `/return_refund/202606/review_decision` | seller.return_refund.basic |  | 2026-10-13 |
| [Reject Return](https://partner.tiktokshop.com/docv2/page/reject-return-202606) | POST | `/return_refund/202606/returns/{return_id}/reject` | seller.return_refund.basic |  | 2026-10-13 |
| [Review Aftersales Requests](https://partner.tiktokshop.com/docv2/page/review-aftersales-requests-202609) | POST | `/return_refund/202609/aftersales/review` | seller.return_refund.basic |  | 2026-10-13 |

## Finance → `reference/api/finance.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Finance API overview](https://partner.tiktokshop.com/docv2/page/finance-api-overview) (tổng quan) | | | | | 2025-08-06 |
| [Get Statements](https://partner.tiktokshop.com/docv2/page/get-statements-202309) | GET | `/finance/202309/statements` | seller.finance.info |  | 2026-10-28 |
| [Get Seller Financial Transactions](https://partner.tiktokshop.com/docv2/page/get-seller-financial-transactions-202309) | GET | `/finance/202309/withdrawals` | seller.finance.info |  | 2026-10-28 |
| [Get Transactions by Order](https://partner.tiktokshop.com/docv2/page/get-transactions-by-order-202501) | GET | `/finance/202501/orders/{order_id}/statement_transactions` | seller.finance.info |  | 2026-10-28 |
| [Get Transactions by Statement](https://partner.tiktokshop.com/docv2/page/get-transactions-by-statement-202501) | GET | `/finance/202501/statements/{statement_id}/statement_transactions` | seller.finance.info |  | 2026-10-28 |
| [Get Unsettled Transactions](https://partner.tiktokshop.com/docv2/page/get-unsettled-transactions-202507) | GET | `/finance/202507/orders/unsettled` | seller.finance.info |  | 2026-10-28 |
| [Get Payments](https://partner.tiktokshop.com/docv2/page/get-payments-202605) | GET | `/finance/202605/payments` | seller.finance.info |  | 2026-10-28 |
| [Get TradeIn Account Transactions](https://partner.tiktokshop.com/docv2/page/get-tradein-account-transactions-202609) | GET | `/finance/202609/account_transactions` | seller.finance.info |  | 2026-10-28 |
| [Get TradeIn Supplier Account Balance](https://partner.tiktokshop.com/docv2/page/get-tradein-supplier-account-balance-202609) | GET | `/finance/202609/account_balances` | seller.finance.info |  | 2026-10-28 |

## Analytics → `reference/api/analytics.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Get Video Performances](https://partner.tiktokshop.com/docv2/page/get-video-performances-202403) | GET | `/analytics/202403/videos/performances` | creator.video.write, creator.data.live.read.public |  | 2026-10-13 |
| [Get Shop Performance Per Hour](https://partner.tiktokshop.com/docv2/page/get-shop-performance-per-hour-202510) | GET | `/analytics/202510/shop/performance/{date}/performance_per_hour` | data.shop_analytics.public.read |  | 2026-10-13 |
| [Get Shop LIVE Minute Performance](https://partner.tiktokshop.com/docv2/page/get-shop-live-minute-performance-202510) | GET | `/analytics/202510/shop_lives/{live_id}/performance_per_minutes` | data.shop_analytics.public.read |  | 2026-10-13 |
| [Get Shop LIVE Products Performance List](https://partner.tiktokshop.com/docv2/page/get-shop-live-products-performance-list-202512) | GET | `/analytics/202512/shop/{live_id}/products_performance` | data.shop_analytics.public.read |  | 2026-10-13 |
| [Get Shop Product Performance Detail](https://partner.tiktokshop.com/docv2/page/get-shop-product-performance-detail-202509) | GET | `/analytics/202509/shop_products/{product_id}/performance` | data.shop_analytics.public.read |  | 2026-10-28 |
| [Get Shop SKU Performance Detail](https://partner.tiktokshop.com/docv2/page/get-shop-sku-performance-detail-202509) | GET | `/analytics/202509/shop_skus/{sku_id}/performance` | data.shop_analytics.public.read |  | 2026-10-28 |
| [Get Shop SKU Performance List](https://partner.tiktokshop.com/docv2/page/get-shop-sku-performance-list-202509) | GET | `/analytics/202509/shop_skus/performance` | data.shop_analytics.public.read |  | 2026-10-28 |
| [Get Shop Video Performance Details](https://partner.tiktokshop.com/docv2/page/get-shop-video-performance-details-202509) | GET | `/analytics/202509/shop_videos/{video_id}/performance` | data.shop_analytics.public.read |  | 2026-10-13 |
| [Get Shop Video Product Performance List](https://partner.tiktokshop.com/docv2/page/get-shop-video-product-performance-list-202509) | GET | `/analytics/202509/shop_videos/{video_id}/products/performance` | data.shop_analytics.public.read |  | 2026-10-13 |
| [Get Live Room View Trends](https://partner.tiktokshop.com/docv2/page/get-live-room-view-trends-202502) | GET | `/analytics/202502/live_rooms/{live_room_id}/view_trend_performances` | creator.data.live.read.public |  | 2026-10-13 |
| [Get Live Room Traffic Performance](https://partner.tiktokshop.com/docv2/page/get-live-room-traffic-performance-202502) | GET | `/analytics/202502/live_rooms/{live_room_id}/traffic_performances` | creator.data.live.read.public |  | 2026-10-13 |
| [Get Live Room User Portraits](https://partner.tiktokshop.com/docv2/page/get-live-room-user-portraits-202502) | GET | `/analytics/202502/live_rooms/{live_room_id}/user_portraits` | creator.data.live.read.public |  | 2026-10-13 |
| [Get Live Room Product Stats](https://partner.tiktokshop.com/docv2/page/get-live-room-product-stats-202502) | GET | `/analytics/202502/live_rooms/{live_room_id}/product_stats` | creator.data.live.read.public |  | 2026-10-13 |
| [Get Live Room Interactive Trends](https://partner.tiktokshop.com/docv2/page/get-live-room-interactive-trends-202502) | GET | `/analytics/202502/live_rooms/{live_room_id}/interactive_trend_performances` | creator.data.live.read.public |  | 2026-10-13 |
| [Get Live Room GMV and Order Trends](https://partner.tiktokshop.com/docv2/page/get-live-room-gmv-and-order-trends-202502) | GET | `/analytics/202502/live_rooms/{live_room_id}/gmv_trend_performances` | creator.data.live.read.public |  | 2026-10-13 |
| [Get Live Room Core Stats](https://partner.tiktokshop.com/docv2/page/get-live-room-core-stats-202502) | GET | `/analytics/202502/live_rooms/{live_room_id}/core_stats` | creator.data.live.read.public |  | 2026-10-13 |
| [Get Bestselling Products](https://partner.tiktokshop.com/docv2/page/get-bestselling-products-202511) | GET | `/analytics/202511/products/bestselling` | data.bestselling.public.read |  | 2026-10-13 |
| [Get Bestselling Creators](https://partner.tiktokshop.com/docv2/page/get-bestselling-creators-202511) | GET | `/analytics/202511/creators/bestselling` | data.bestselling.public.read |  | 2026-10-13 |
| [Get Bestselling Videos](https://partner.tiktokshop.com/docv2/page/get-bestselling-videos-202511) | GET | `/analytics/202511/videos/bestselling` | data.bestselling.public.read |  | 2026-10-13 |
| [Get Bestselling LIVE Sessions](https://partner.tiktokshop.com/docv2/page/get-bestselling-live-sessions-202511) | GET | `/analytics/202511/lives/bestselling` | data.bestselling.public.read |  | 2026-10-13 |
| [Get Shop Video Performance List](https://partner.tiktokshop.com/docv2/page/get-shop-video-performance-list-202605) | GET | `/analytics/202605/shop_videos/performance` | data.shop_analytics.public.read |  | 2026-10-28 |
| [Get Shop Product Performance List](https://partner.tiktokshop.com/docv2/page/get-shop-product-performance-list-202605) | GET | `/analytics/202605/shop_products/performance` | data.shop_analytics.public.read |  | 2026-10-13 |
| [Get SPS Metric Diagnosis](https://partner.tiktokshop.com/docv2/page/get-sps-metric-diagnosis-202606) | GET | `/analytics/202606/shop_performances/metrics/{metric_code}/diagnosis` | data.shop_analytics.public.read |  | 2026-10-13 |
| [Get SPS Metric Problem Details](https://partner.tiktokshop.com/docv2/page/get-sps-metric-problem-details-202606) | GET | `/analytics/202606/shop_performances/metrics/{metric_code}/problem_details` | data.shop_analytics.public.read |  | 2026-10-13 |
| [Get SPS Metric Top Items](https://partner.tiktokshop.com/docv2/page/get-sps-metric-top-items-202606) | GET | `/analytics/202606/shop_performances/metrics/{metric_code}/top_items` | data.shop_analytics.public.read |  | 2026-10-13 |
| [Get SPS Overview](https://partner.tiktokshop.com/docv2/page/get-sps-overview-202606) | GET | `/analytics/202606/shop_performances/overview` | data.shop_analytics.public.read |  | 2026-10-13 |
| [Get SPS Metrics](https://partner.tiktokshop.com/docv2/page/get-sps-metrics-202606) | GET | `/analytics/202606/shop_performances/metrics` | data.shop_analytics.public.read |  | 2026-10-13 |
| [Get Shop LIVE Performance Overview](https://partner.tiktokshop.com/docv2/page/get-shop-live-performance-overview-202609) | GET | `/analytics/202609/shop_lives/overview_performance` | data.shop_analytics.public.read |  | 2026-10-28 |
| [Get Shop Videos Performance Details](https://partner.tiktokshop.com/docv2/page/get-shop-videos-performance-details-202609) | GET | `/analytics/202609/shop_videos/batch_performance` | data.shop_analytics.public.read |  | 2026-09-28 |
| [Get Shop LIVE Performance List](https://partner.tiktokshop.com/docv2/page/get-shop-live-performance-list-202609) | GET | `/analytics/202609/shop_lives/performance` | data.shop_analytics.public.read |  | 2026-09-28 |
| [Get Shop Performance](https://partner.tiktokshop.com/docv2/page/get-shop-performance-202609) | GET | `/analytics/202609/shop/performance` | data.shop_analytics.public.read |  | 2026-09-28 |
| [Get Shop Video Performance Overview](https://partner.tiktokshop.com/docv2/page/get-shop-video-performance-overview-202609) | GET | `/analytics/202609/shop_videos/overview_performance` | data.shop_analytics.public.read |  | 2026-09-28 |

## Customer service → `reference/api/customer-service.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Customer Service API overview](https://partner.tiktokshop.com/docv2/page/customer-service-api-overview) (tổng quan) | | | | | 2026-05-20 |
| [Message Types](https://partner.tiktokshop.com/docv2/page/6y23rc6a) (tổng quan) | | | | | 2026-10-16 |
| [Post-sales Solutions for Customer Services](https://partner.tiktokshop.com/docv2/page/gx13i64p) (tổng quan) | | | | | 2026-03-18 |
| [Create Conversation](https://partner.tiktokshop.com/docv2/page/create-conversation-202309) | POST | `/customer_service/202309/conversations` | seller.customer_service |  | 2026-06-03 |
| [Get Conversations](https://partner.tiktokshop.com/docv2/page/get-conversations-202309) | GET | `/customer_service/202309/conversations` | seller.customer_service |  | 2026-10-13 |
| [Get Conversation Messages](https://partner.tiktokshop.com/docv2/page/get-conversation-messages-202309) | GET | `/customer_service/202309/conversations/{conversation_id}/messages` | seller.customer_service |  | 2026-10-13 |
| [Upload Image for Buyer Messages](https://partner.tiktokshop.com/docv2/page/upload-image-for-buyer-messages-202309) | POST | `/customer_service/202309/images/upload` | seller.customer_service |  | 2026-10-13 |
| [Mark Buyer Messages as Read](https://partner.tiktokshop.com/docv2/page/mark-buyer-messages-as-read-202309) | POST | `/customer_service/202309/conversations/{conversation_id}/messages/read` | seller.customer_service |  | 2026-10-13 |
| [Get Agent Settings](https://partner.tiktokshop.com/docv2/page/get-agent-settings-202309) | GET | `/customer_service/202309/agents/settings` | seller.customer_service |  | 2026-06-03 |
| [Update Agent Settings](https://partner.tiktokshop.com/docv2/page/update-agent-settings-202309) | PUT | `/customer_service/202309/agents/settings` | seller.customer_service |  | 2026-10-13 |
| [Get Customer Service Performance](https://partner.tiktokshop.com/docv2/page/get-customer-service-performance-202407) | GET | `/customer_service/202407/performance` | seller.customer_service |  | 2026-10-13 |
| [Get Conversation](https://partner.tiktokshop.com/docv2/page/get-conversation-202601) | GET | `/customer_service/202601/conversations/{conversation_id}` | seller.customer_service |  | 2026-10-13 |
| [Search Sessions](https://partner.tiktokshop.com/docv2/page/search-sessions-202602) | POST | `/customer_service/202602/sessions/search` | seller.customer_service |  | 2026-10-13 |
| [End Session](https://partner.tiktokshop.com/docv2/page/end-session-202605) | POST | `/customer_service/202605/conversations/{conversation_id}/sessions/{session_id}/end` | seller.customer_service |  | 2026-06-11 |
| [Send Message](https://partner.tiktokshop.com/docv2/page/send-message-202606) | POST | `/customer_service/202606/conversations/{conversation_id}/messages` | seller.customer_service |  | 2026-06-03 |

## Customer engagement → `reference/api/customer-engagement.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Customer engagement API overview](https://partner.tiktokshop.com/docv2/page/customer-engagement-api-overview) (tổng quan) | | | | | 2025-10-16 |
| [Get Message Templates](https://partner.tiktokshop.com/docv2/page/get-message-templates-202412) | GET | `/customer_engagement/202412/message_templates` | seller.customer_engagement.read |  | 2026-10-13 |
| [Create Engagement Task](https://partner.tiktokshop.com/docv2/page/create-engagement-task-202412) | POST | `/customer_engagement/202412/engagement_tasks` | seller.customer_engagement.write |  | 2026-10-13 |
| [Send Engagement Message](https://partner.tiktokshop.com/docv2/page/send-engagement-message-202412) | POST | `/customer_engagement/202412/messages` | seller.customer_engagement.write |  | 2026-10-13 |
| [Get Engagement Task Performances](https://partner.tiktokshop.com/docv2/page/get-engagement-task-performances-202412) | POST | `/customer_engagement/202412/performances` | seller.customer_engagement.read |  | 2026-10-13 |
| [Create Custom Engagement Task](https://partner.tiktokshop.com/docv2/page/create-custom-engagement-task-202502) | POST | `/customer_engagement/202502/engagement_tasks/custom` | seller.customer_engagement.write |  | 2026-10-13 |
| [Get Engagement Feature Permissions](https://partner.tiktokshop.com/docv2/page/get-engagement-feature-permissions-202502) | GET | `/customer_engagement/202502/permissions` | seller.customer_engagement.read |  | 2026-10-13 |

## Affiliate creator → `reference/api/affiliate-creator.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Affiliate Creator API overview](https://partner.tiktokshop.com/docv2/page/affiliate-creator-api-overview) (tổng quan) | | | | | 2026-09-21 |
| [Get Creator Profile](https://partner.tiktokshop.com/docv2/page/get-creator-profile-202508) | GET | `/affiliate_creator/202508/profiles` | creator.affiliate.info, creator.video.write |  | 2026-10-13 |
| [Get Showcase Products](https://partner.tiktokshop.com/docv2/page/get-showcase-products-202405) | GET | `/affiliate_creator/202405/showcases/products` | creator.showcase.read, creator.video.write |  | 2026-10-13 |
| [Add Showcase Products](https://partner.tiktokshop.com/docv2/page/add-showcase-products-202405) | POST | `/affiliate_creator/202405/showcases/products/add` | creator.showcase.write, creator.video.write |  | 2026-10-13 |
| [Remove Showcase Products](https://partner.tiktokshop.com/docv2/page/remove-showcase-products-202409) | DELETE | `/affiliate_creator/202409/showcases/products` | creator.showcase.write |  | 2026-10-13 |
| [Move Showcase Products to the Top](https://partner.tiktokshop.com/docv2/page/move-showcase-products-to-the-top-202409) | POST | `/affiliate_creator/202409/showcases/products/top` | creator.showcase.write |  | 2026-10-13 |
| [Search Open Collaboration Products](https://partner.tiktokshop.com/docv2/page/search-open-collaboration-products-202405) | POST | `/affiliate_creator/202405/open_collaborations/products/search` | creator.affiliate_collaboration.read |  | 2026-10-13 |
| [Get Open Collaboration Product List By Product Ids](https://partner.tiktokshop.com/docv2/page/get-open-collaboration-product-list-by-product-ids-202509) | POST | `/affiliate_creator/202509/open_collaborations/products` | creator.affiliate_collaboration.read |  | 2026-10-13 |
| [Search Creator Target Collaborations](https://partner.tiktokshop.com/docv2/page/search-creator-target-collaborations-202405) | POST | `/affiliate_creator/202405/target_collaborations/search` | creator.affiliate_collaboration.read |  | 2026-10-13 |
| [Search Creator Sample Applications](https://partner.tiktokshop.com/docv2/page/search-creator-sample-applications-202412) | POST | `/affiliate_creator/202412/sample_applications/search` | creator.affiliate_collaboration.read |  | 2026-10-13 |
| [Get Creator Sample Application Detail](https://partner.tiktokshop.com/docv2/page/get-creator-sample-application-detail-202412) | POST | `/affiliate_creator/202412/sample_applications/single_query` | creator.affiliate_collaboration.read |  | 2026-10-28 |
| [Creator Search Sample Application Fulfillments](https://partner.tiktokshop.com/docv2/page/creator-search-sample-application-fulfillments-202409) | POST | `/affiliate_creator/202409/sample_applications/fulfillments/search` | creator.affiliate_collaboration.read |  | 2026-10-28 |
| [Generate General Sharing Links](https://partner.tiktokshop.com/docv2/page/generate-general-sharing-links-202505) | POST | `/affiliate_creator/202505/affiliate_sharing_links/general_publishers/generate_batch` | creator.affiliate.share_link.read |  | 2026-10-13 |
| [Generate Publisher Sharing Links in Batch](https://partner.tiktokshop.com/docv2/page/generate-publisher-sharing-links-in-batch-202504) | POST | `/affiliate_creator/202504/affiliate_sharing_links/publisher/{publisher_id}/generate_batch` | creator.affiliate.share_link.read |  | 2026-10-13 |
| [Search Affiliate Orders by Creator](https://partner.tiktokshop.com/docv2/page/search-affiliate-orders-by-creator-202505) | POST | `/affiliate_creator/202505/orders/trace/search` | creator.affiliate.share_link.read |  | 2026-10-28 |
| [Search Creator Affiliate Orders](https://partner.tiktokshop.com/docv2/page/search-creator-affiliate-orders-202410) | POST | `/affiliate_creator/202410/orders/search` | creator.affiliate_collaboration.read |  | 2026-10-13 |
| [Check Creator Sample Eligibility](https://partner.tiktokshop.com/docv2/page/check-creator-sample-eligibility-202412) | GET | `/affiliate_creator/202412/samples/labels` | creator.affiliate_collaboration.read |  | 2026-10-28 |
| [Upload Shoppable Video File](https://partner.tiktokshop.com/docv2/page/upload-shoppable-video-file-202505) | POST | `/affiliate_creator/202505/videos/video_files` | creator.video.write |  | 2026-10-13 |
| [Get Shop Products](https://partner.tiktokshop.com/docv2/page/get-shop-products-202509) | GET | `/affiliate_creator/202509/shop_products` | creator.video.write |  | 2026-10-13 |
| [Get Shoppable Video Status](https://partner.tiktokshop.com/docv2/page/get-shoppable-video-status-202509) | GET | `/affiliate_creator/202509/videos/{video_id}/status` | creator.video.write |  | 2026-10-13 |
| [Create Video Precheck Task](https://partner.tiktokshop.com/docv2/page/create-video-precheck-task-202511) | POST | `/affiliate_creator/202511/videos/precheck_task` | creator.video.write |  | 2026-10-28 |
| [Get Shoppable Video Precheck Result](https://partner.tiktokshop.com/docv2/page/get-shoppable-video-precheck-result-202601) | GET | `/affiliate_creator/202601/videos/precheck_tasks/{task_id}` | creator.video.write |  | 2026-10-28 |
| [Upload Shoppable Photo File](https://partner.tiktokshop.com/docv2/page/upload-shoppable-photo-file-202511) | POST | `/affiliate_creator/202511/photos/photo_files` | creator.video.write |  | 2026-10-28 |
| [Post Shoppable Video](https://partner.tiktokshop.com/docv2/page/post-shoppable-video-202603) | POST | `/affiliate_creator/202603/videos` | creator.video.write |  | 2026-10-28 |
| [Map Tokopedia to TikTok Shop Product IDs](https://partner.tiktokshop.com/docv2/page/map-tokopedia-to-tiktok-shop-product-ids-202606) | GET | `/affiliate_creator/202606/toko_product_mappers` | creator.affiliate_collaboration.read |  | 2026-10-13 |
| [Get Tokopedia and TikTok Shop Product ID Mappings](https://partner.tiktokshop.com/docv2/page/get-tokopedia-and-tiktok-shop-product-id-mappings-202607) | POST | `/affiliate_creator/202607/map_toko_product` | creator.affiliate.share_link.read |  | 2026-10-13 |
| [Post Shoppable Photos](https://partner.tiktokshop.com/docv2/page/post-shoppable-photos-202610) | POST | `/affiliate_creator/202610/photos` | creator.video.write |  | 2026-10-28 |

## Affiliate partner → `reference/api/affiliate-partner.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Affiliate Partner API overview](https://partner.tiktokshop.com/docv2/page/affiliate-partner-api-overview) (tổng quan) | | | | | 2026-09-21 |
| [Create Affiliate Partner Campaign](https://partner.tiktokshop.com/docv2/page/create-affiliate-partner-campaign-202405) | POST | `/affiliate_partner/202405/campaigns` | partner.tap_campaign.write |  | 2026-10-13 |
| [Edit Affiliate Partner Campaign](https://partner.tiktokshop.com/docv2/page/edit-affiliate-partner-campaign-202405) | POST | `/affiliate_partner/202405/campaigns/{campaign_id}/partial_edit` | partner.tap_campaign.write |  | 2026-10-13 |
| [Publish Affiliate Partner Campaign](https://partner.tiktokshop.com/docv2/page/publish-affiliate-partner-campaign-202405) | POST | `/affiliate_partner/202405/campaigns/{campaign_id}/publish` | partner.tap_campaign.write |  | 2026-10-13 |
| [Review Affiliate Partner Campaign Product](https://partner.tiktokshop.com/docv2/page/review-affiliate-partner-campaign-product-202405) | POST | `/affiliate_partner/202405/campaigns/{campaign_id}/products/{product_id}/review` | partner.tap_campaign.product.write |  | 2026-10-13 |
| [Generate Affiliate Partner Campaign Product Link](https://partner.tiktokshop.com/docv2/page/generate-affiliate-partner-campaign-product-link-202405) | POST | `/affiliate_partner/202405/campaigns/{campaign_id}/products/{product_id}/promotion_link/generate` | partner.tap_campaign.link.write |  | 2026-10-28 |
| [Get Affiliate Partner Campaign Detail](https://partner.tiktokshop.com/docv2/page/get-affiliate-partner-campaign-detail-202405) | GET | `/affiliate_partner/202405/campaigns/{campaign_id}` | partner.tap_campaign.read |  | 2026-10-28 |
| [Get Affiliate Partner Campaign List](https://partner.tiktokshop.com/docv2/page/get-affiliate-partner-campaign-list-202405) | GET | `/affiliate_partner/202405/campaigns` | partner.tap_campaign.read |  | 2026-10-28 |
| [Get Affiliate Partner Campaign Product List](https://partner.tiktokshop.com/docv2/page/get-affiliate-partner-campaign-product-list-202405) | GET | `/affiliate_partner/202405/campaigns/{campaign_id}/products` | partner.tap_campaign.read |  | 2026-10-28 |
| [Get Campaign Product Performance List](https://partner.tiktokshop.com/docv2/page/get-campaign-product-performance-list-202501) | GET | `/affiliate_partner/202501/campaigns/{campaign_id}/products/performance` | partner.tap_campaign.read |  | 2026-10-13 |
| [Generate Campaign Product Promotion Links in Batch](https://partner.tiktokshop.com/docv2/page/generate-campaign-product-promotion-links-in-batch-202505) | POST | `/affiliate_partner/202505/campaigns/{campaign_id}/products/promotion_links/generate_batch` | partner.tap_campaign.read |  | 2026-10-13 |
| [Get Creator Performance for Campaign Product](https://partner.tiktokshop.com/docv2/page/get-creator-performance-for-campaign-product-202508) | GET | `/affiliate_partner/202508/campaigns/{campaign_id}/products/{product_id}/performance` | partner.tap_campaign.read |  | 2026-10-28 |
| [Get Affiliate Campaign Creator Product Content Statistics](https://partner.tiktokshop.com/docv2/page/get-affiliate-campaign-creator-product-content-statistics-202508) | GET | `/affiliate_partner/202508/campaigns/{campaign_id}/products/{product_id}/creator/{creator_temp_id}/content/statistics` | partner.tap_campaign.read |  | 2026-10-28 |
| [Get Affiliate Campaign Creator Product Sample Status](https://partner.tiktokshop.com/docv2/page/get-affiliate-campaign-creator-product-sample-status-202508) | GET | `/affiliate_partner/202508/campaigns/{campaign_id}/products/{product_id}/creator/{creator_temp_id}/content/statistics/sample/status` | partner.tap_campaign.read |  | 2026-10-28 |
| [Search CAP Affiliate Orders](https://partner.tiktokshop.com/docv2/page/search-cap-affiliate-orders-202603) | POST | `/affiliate_partner/202603/cap_order/search` | partner.cap_orders.read |  | 2026-10-28 |
| [Search TAP Affiliate Orders](https://partner.tiktokshop.com/docv2/page/search-tap-affiliate-orders-202603) | POST | `/affiliate_partner/202603/orders/search` | partner.tap_campaign.read |  | 2026-10-28 |

## Affiliate seller → `reference/api/affiliate-seller.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Affiliate Seller API overview](https://partner.tiktokshop.com/docv2/page/affiliate-seller-api-overview) (tổng quan) | | | | | 2026-09-21 |
| [Get Open Collaboration Settings](https://partner.tiktokshop.com/docv2/page/get-open-collaboration-settings-202409) | GET | `/affiliate_seller/202409/open_collaboration_settings` | seller.affiliate_collaboration.read |  | 2026-10-13 |
| [Edit Open Collaboration Settings](https://partner.tiktokshop.com/docv2/page/edit-open-collaboration-settings-202405) | POST | `/affiliate_seller/202405/open_collaboration_settings` | seller.affiliate_collaboration.write |  | 2026-03-25 |
| [Get Open Collaboration Sample Rules](https://partner.tiktokshop.com/docv2/page/get-open-collaboration-sample-rules-202410) | GET | `/affiliate_seller/202410/open_collaborations/sample_rules` | seller.affiliate_collaboration.read |  | 2026-10-28 |
| [Edit Open Collaboration Sample Rule](https://partner.tiktokshop.com/docv2/page/edit-open-collaboration-sample-rule-202410) | POST | `/affiliate_seller/202410/open_collaborations/sample_rules` | seller.affiliate_collaboration.write |  | 2026-10-13 |
| [Create Open Collaboration](https://partner.tiktokshop.com/docv2/page/create-open-collaboration-202412) | POST | `/affiliate_seller/202412/open_collaborations` | seller.affiliate_collaboration.write |  | 2026-10-13 |
| [Search Open Collaborations](https://partner.tiktokshop.com/docv2/page/search-open-collaborations-202412) | POST | `/affiliate_seller/202412/open_collaborations/search` | seller.affiliate_collaboration.read |  | 2026-10-13 |
| [Remove Open Collaboration](https://partner.tiktokshop.com/docv2/page/remove-open-collaboration-202409) | DELETE | `/affiliate_seller/202409/open_collaborations/products/{product_id}` | seller.affiliate_collaboration.write |  | 2026-10-13 |
| [Get Open Collaboration Creator Content Details](https://partner.tiktokshop.com/docv2/page/get-open-collaboration-creator-content-details-202508) | GET | `/affiliate_seller/202508/open_collaborations/creator_content_details` | seller.affiliate_collaboration.read |  | 2026-10-13 |
| [Seller Search Open Collaboration Products](https://partner.tiktokshop.com/docv2/page/seller-search-open-collaboration-products-202405) | POST | `/affiliate_seller/202405/open_collaborations/products/search` | seller.affiliate_collaboration.read |  | 2026-10-13 |
| [Remove Creator From Open Collaboration Product](https://partner.tiktokshop.com/docv2/page/remove-creator-from-open-collaboration-product-202508) | POST | `/affiliate_seller/202508/open_collaborations/{open_collaboration_id}/remove_creator` | seller.affiliate_collaboration.write |  | 2026-10-13 |
| [Create Target Collaboration](https://partner.tiktokshop.com/docv2/page/create-target-collaboration-202508) | POST | `/affiliate_seller/202508/target_collaborations` | seller.affiliate_collaboration.write |  | 2026-10-28 |
| [Search Target Collaborations](https://partner.tiktokshop.com/docv2/page/search-target-collaborations-202508) | POST | `/affiliate_seller/202508/target_collaborations/search` | seller.affiliate_collaboration.read |  | 2026-10-13 |
| [Update Target Collaboration](https://partner.tiktokshop.com/docv2/page/update-target-collaboration-202508) | PUT | `/affiliate_seller/202508/target_collaborations/{target_collaboration_id}` | seller.affiliate_collaboration.write |  | 2026-10-28 |
| [Remove Target Collaboration](https://partner.tiktokshop.com/docv2/page/remove-target-collaboration-202409) | DELETE | `/affiliate_seller/202409/target_collaborations/{target_collaboration_id}` | seller.affiliate_collaboration.write |  | 2026-08-28 |
| [Query Target Collaboration Detail](https://partner.tiktokshop.com/docv2/page/query-target-collaboration-detail-202508) | GET | `/affiliate_seller/202508/target_collaborations/{target_collaboration_id}` | seller.affiliate_collaboration.read |  | 2026-10-28 |
| [Get Conversation List](https://partner.tiktokshop.com/docv2/page/get-conversation-list-202412) | GET | `/affiliate_seller/202412/conversations` | seller.affiliate_messages.write |  | 2026-10-28 |
| [Get Creator Conversation Messages](https://partner.tiktokshop.com/docv2/page/get-creator-conversation-messages-202412) | GET | `/affiliate_seller/202412/conversation/{conversation_id}/messages` | seller.affiliate_messages.write |  | 2026-10-28 |
| [Get Latest Unread Messages](https://partner.tiktokshop.com/docv2/page/get-latest-unread-messages-202412) | GET | `/affiliate_seller/202412/conversations/messages/list/newest` | seller.affiliate_messages.write |  | 2026-10-13 |
| [Get or Create Creator Conversation](https://partner.tiktokshop.com/docv2/page/get-or-create-creator-conversation-202508) | POST | `/affiliate_seller/202508/conversations` | seller.affiliate_messages.write |  | 2026-10-28 |
| [Upload Message Image](https://partner.tiktokshop.com/docv2/page/upload-message-image-202511) | POST | `/affiliate_seller/202511/images/upload` | seller.affiliate_messages.write |  | 2026-10-13 |
| [Send IM Message](https://partner.tiktokshop.com/docv2/page/send-im-message-202412) | POST | `/affiliate_seller/202412/conversations/{conversation_id}/messages` | seller.affiliate_messages.write |  | 2026-10-28 |
| [Mark Conversations as Read](https://partner.tiktokshop.com/docv2/page/mark-conversations-as-read-202412) | POST | `/affiliate_seller/202412/conversatons/read` | seller.affiliate_messages.write |  | 2026-10-28 |
| [Search Sample Applications](https://partner.tiktokshop.com/docv2/page/search-sample-applications-202508) | POST | `/affiliate_seller/202508/sample_applications/search` | seller.affiliate_collaboration.read |  | 2026-10-28 |
| [Review a Sample Application](https://partner.tiktokshop.com/docv2/page/review-a-sample-application-202507) | POST | `/affiliate_seller/202507/sample_applications/{application_id}/review` | seller.affiliate_collaboration.write |  | 2026-10-13 |
| [Search Sample Application Fulfillments](https://partner.tiktokshop.com/docv2/page/search-sample-application-fulfillments-202409) | POST | `/affiliate_seller/202409/sample_applications/{application_id}/fulfillments/search` | seller.affiliate_collaboration.read |  | 2026-10-28 |
| [Generate Target Collaboration Link](https://partner.tiktokshop.com/docv2/page/generate-target-collaboration-link-202509) | POST | `/affiliate_seller/202509/target_collaboration/{target_collaboration_id}/link` | seller.affiliate_collaboration.write |  | 2026-03-25 |
| [Generate Affiliate Product Promotion Link](https://partner.tiktokshop.com/docv2/page/generate-affiliate-product-promotion-link-202405) | POST | `/affiliate_seller/202405/products/{product_id}/promotion_link/generate` | seller.affiliate_collaboration.write |  | 2026-10-13 |
| [Seller Get Sample Request Deeplink](https://partner.tiktokshop.com/docv2/page/seller-get-sample-request-deeplink-202512) | GET | `/affiliate_seller/202512/sample_applications/deeplink` | seller.affiliate_collaboration.read |  | 2026-10-13 |
| [Search Seller Affiliate Orders](https://partner.tiktokshop.com/docv2/page/search-seller-affiliate-orders-202410) | POST | `/affiliate_seller/202410/orders/search` | seller.affiliate_collaboration.read |  | 2026-10-23 |
| [Create Compass Offline Export Task](https://partner.tiktokshop.com/docv2/page/create-compass-offline-export-task-202603) | POST | `/affiliate_seller/202603/compass/offline_task` | seller.affiliate_collaboration.read |  | 2026-10-13 |
| [Get Compass Task List](https://partner.tiktokshop.com/docv2/page/get-compass-task-list-202603) | GET | `/affiliate_seller/202603/compass/offline_tasks` | seller.affiliate_collaboration.read |  | 2026-10-13 |
| [Download Compass Task File](https://partner.tiktokshop.com/docv2/page/download-compass-task-file-202603) | GET | `/affiliate_seller/202603/compass/offline_tasks/{task_id}/file` | seller.affiliate_collaboration.read |  | 2026-10-13 |
| [Check Target Collaboration Conflicts](https://partner.tiktokshop.com/docv2/page/check-target-collaboration-conflicts-202605) | POST | `/affiliate_seller/202605/target_collaborations/conflicts/check` | seller.affiliate_collaboration.write |  | 2026-10-13 |
| [Resolve Target Collaboration Conflicts](https://partner.tiktokshop.com/docv2/page/resolve-target-collaboration-conflicts-202605) | POST | `/affiliate_seller/202605/target_collaborations/conflicts/resolve` | seller.affiliate_collaboration.write |  | 2026-10-13 |
| [Get Weekly Creator Outreach Records](https://partner.tiktokshop.com/docv2/page/get-weekly-creator-outreach-records-202608) | POST | `/affiliate_seller/202608/creator_outreach/records/query` | seller.affiliate_collaboration.read, seller.affiliate_collaboration.write |  | 2026-10-13 |
| [Get Inbox Category Counts](https://partner.tiktokshop.com/docv2/page/get-inbox-category-counts-202608) | GET | `/affiliate_seller/202608/conversations/group_counts` | seller.affiliate_messages.write |  | 2026-10-13 |
| [Update Conversation Status](https://partner.tiktokshop.com/docv2/page/update-conversation-status-202608) | POST | `/affiliate_seller/202608/conversations/{conversation_id}/status` | seller.affiliate_messages.write |  | 2026-08-21 |
| [Query Creator Promotion Details in Target Collaboration](https://partner.tiktokshop.com/docv2/page/query-creator-promotion-details-in-target-collaboration-202608) | POST | `/affiliate_seller/202608/target_collaborations/creator_promotion_details/query` | seller.affiliate_collaboration.read, seller.affiliate_collaboration.write |  | 2026-10-13 |
| [Upload Message Image V2](https://partner.tiktokshop.com/docv2/page/upload-message-image-v2-202608) | POST | `/affiliate_seller/202608/media/upload` | seller.affiliate_messages.write |  | 2026-10-13 |
| [Get Weekly Creator Outreach Quota](https://partner.tiktokshop.com/docv2/page/get-weekly-creator-outreach-quota-202607) | GET | `/affiliate_seller/202607/creator_outreach/quota` | seller.affiliate_collaboration.read |  | 2026-10-28 |
| [Get Marketplace Creator Performance](https://partner.tiktokshop.com/docv2/page/get-marketplace-creator-performance-202608) | GET | `/affiliate_seller/202608/marketplace_creators/{creator_user_id}` | seller.creator_marketplace.read |  | 2026-10-28 |
| [Get Creator Marketplace Advanced Search Filters](https://partner.tiktokshop.com/docv2/page/get-creator-marketplace-advanced-search-filters-202608) | POST | `/affiliate_seller/202608/marketplace_creators/search/filter` | seller.creator_marketplace.read |  | 2026-10-13 |
| [Search Creators in Creator Marketplace](https://partner.tiktokshop.com/docv2/page/search-creators-in-creator-marketplace-202608) | POST | `/affiliate_seller/202608/marketplace_creators/search` | seller.creator_marketplace.read |  | 2026-10-28 |
| [Check Creator Outreach Eligibility](https://partner.tiktokshop.com/docv2/page/check-creator-outreach-eligibility-202610) | POST | `/affiliate_seller/202610/creator_outreach/eligibility/check` | seller.affiliate_collaboration.read |  | 2026-10-15 |

## Supply chain → `reference/api/supply-chain.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Confirm Package Shipment](https://partner.tiktokshop.com/docv2/page/confirm-package-shipment-202309) | POST | `/supply_chain/202309/packages/sync` | seller.fulfillment.basic |  | 2026-10-11 |

## Tools → `reference/api/tools.md`

| API | Method | Path | Scope | shop_cipher | Cập nhật |
|---|---|---|---|---|---|
| [Upload File Init](https://partner.tiktokshop.com/docv2/page/upload-file-init-202512) | POST | `/open/202512/file/init` | seller.customer_service, creator.video.write |  | 2026-10-13 |

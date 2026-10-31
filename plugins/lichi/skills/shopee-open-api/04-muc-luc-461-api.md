# Mục lục 461 API Shopee Open Platform v2

Mỗi module: 1 câu tiếng Việt, rồi từng API (G = GET đọc, P = POST thường là ghi). Chi tiết tham số/trường: `reference/api/<Module>.md`.

| Module | Số API | App được gọi (theo tài liệu) |
|---|---|---|
| AMS | 36 | Affiliate Marketing Solution Management |
| Video | 15 | Shopee Video Management |
| Product | 63 | ERP System, Seller In House System, Product Management, Swam ERP |
| GlobalProduct | 34 | ERP System, Seller In House System, Product Management, Swam ERP |
| MediaSpace | 6 | ERP System, Seller In House System, Product Management, Swam ERP |
| Media | 6 | ERP System, Seller In House System, Product Management, Customer Service |
| Shop | 9 | ERP System, Seller In House System, Product Management, Order Management |
| Merchant | 6 | ERP System, Seller In House System, Swam ERP, Product Management |
| Order | 22 | ERP System, Seller In House System, Order Management, Swam ERP |
| Logistics | 48 | ERP System, Seller In House System, Order Management, Swam ERP |
| FirstMile | 18 | ERP System, Seller In House System, Order Management, Swam ERP |
| Payment | 18 | ERP System, Seller In House System, Accounting And Finance, Swam ERP |
| Discount | 12 | ERP System, Seller In House System, Marketing, Swam ERP |
| Bundle Deal | 10 | ERP System, Seller In House System, Marketing, Swam ERP |
| Add-On Deal | 14 | ERP System, Seller In House System, Marketing, Swam ERP |
| Voucher | 6 | ERP System, Seller In House System, Marketing, Swam ERP |
| ShopFlashSale | 11 | ERP System, Seller In House System, Marketing, Swam ERP |
| Follow Prize | 6 | ERP System, Seller In House System, Marketing, Swam ERP |
| TopPicks | 4 | ERP System, Seller In House System, Marketing, Swam ERP |
| ShopCategory | 7 | ERP System, Seller In House System, Product Management, Swam ERP |
| Returns | 15 | ERP System, Seller In House System, Customer Service, Swam ERP |
| AccountHealth | 6 | ERP System, Seller In House System, Product Management, Order Management |
| Ads | 25 | Ads Service, Ads Service App, Seller In House System, Ads Facil |
| Public | 6 | ERP System, Seller In House System, Product Management, Order Management |
| Push | 4 | ERP System, Seller In House System, Product Management, Order Management |
| SBS | 6 | ERP System, Seller In House System, Swam ERP |
| FBS | 4 | ERP System, Seller In House System |
| Livestream | 25 | Livestream Management |
| Installation | 2 | Auto Parts Installation (ISP), Auto Parts Installation (Seller-Owned) |
| BrandPortal | 11 | Brand Portal Service |
| Buybox | 5 | ERP System, Seller In House System, Product Management |
| BusinessInsights | 1 | ERP System, Seller In House System, Product Management |

## AMS

Tiếp thị liên kết (affiliate/KOC): chiến dịch Open/Targeted, hiệu quả theo KOC/sản phẩm/nội dung, báo cáo đơn affiliate, hoá đơn hoa hồng. Cần app loại Affiliate Marketing Solution Management.

| API | | Mô tả gốc |
|---|---|---|
| `v2.ams.get_open_campaign_added_product` | G | Retrieve all products currently in the Open Campaign, including campaign status, commission rate, and promotion period |
| `v2.ams.get_open_campaign_not_added_product` | G | Retrieve eligible products not yet added to the Open Campaign |
| `v2.ams.batch_add_products_to_open_campaign` | P | Batch add products to the Open Campaign for a given list of product IDs |
| `v2.ams.add_all_products_to_open_campaign` | P | Add all eligible products into the Open Campaign. We will only return the general error that caused the whole task failure, without returning the specific error for each product in the v2.ams.get_open_campaign_batch_task |
| `v2.ams.get_auto_add_new_product_toggle_status` | G | Check if auto-add new product is currently enabled |
| `v2.ams.update_auto_add_new_product_setting` | P | Change auto-add toggle and default commission rate setting |
| `v2.ams.batch_edit_products_open_campaign_setting` | P | Batch update open campaign settings for a given list of product IDs |
| `v2.ams.edit_all_products_open_campaign_setting` | P | Update for all products in the Open Campaign. We will only return the general error that caused the whole task failure, without returning the specific error for each product in the v2.ams.get_open_campaign_batch_task_res |
| `v2.ams.batch_remove_products_open_campaign_setting` | P | Batch update products from Open Campaign for a given list of product IDs |
| `v2.ams.remove_all_products_open_campaign_setting` | P | Remove the entire product list of Open Campaign. We will only return the general error that caused the whole task failure, without returning the specific error for each product in the v2.ams.get_open_campaign_batch_task_ |
| `v2.ams.get_open_campaign_batch_task_result` | G | Get open campaign batch task result |
| `v2.ams.get_optimization_suggestion_product` | G | Retrieve products with suggestions to improve performance |
| `v2.ams.batch_get_products_suggested_rate` | G | Fetch suggested rates for a given list of product IDs |
| `v2.ams.get_shop_suggested_rate` | G | Retrieve suggested rates for all eligible products |
| `v2.ams.get_targeted_campaign_addable_product_list` | G | Returns a list of products that can be added to a targeted campaign |
| `v2.ams.get_recommended_affiliate_list` | G | Returns top 200 recommended affiliates that can be added to a campaign |
| `v2.ams.get_managed_affiliate_list` | G | Returns affiliates that are saved to managed affiliate list |
| `v2.ams.query_affiliate_list` | G | Retrieve affiliate information by affiliate id. |
| `v2.ams.create_new_targeted_campaign` | P | Create a new campaign with custom product & affiliate selections, and basic info filling. |
| `v2.ams.get_targeted_campaign_list` | G | Retrieve all current targeted campaigns created by the seller |
| `v2.ams.get_targeted_campaign_settings` | G | For each campaign, return: campaign basic info (name, status, promotion period, message), selected product list (with product name & ID), selected affiliate list (with affiliate names) |
| `v2.ams.update_basic_info_of_targeted_campaign` | P | Edit campaign name, promotion period, message, and budget (if the shop is whitelisted) of target campaign |
| `v2.ams.edit_product_list_of_targeted_campaign` | P | Modify the selected product list in an existing target campaign |
| `v2.ams.edit_affiliate_list_of_targeted_campaign` | P | Modify the selected affiliate list in an existing target campaign |
| `v2.ams.terminate_targeted_campaign` | P | Change target campaign status to "terminated" to stop all affiliate promotion activity |
| `v2.ams.get_performance_data_update_time` | G | Retrieve the latest date of AMS dashboard data metrics update. |
| `v2.ams.get_shop_performance` | G | Retrieve overall key metrics for all channels or specific channels. |
| `v2.ams.get_product_performance` | G | Retrieve product performance of the shop. |
| `v2.ams.get_affiliate_performance` | G | Retrieve affiliate performance of the shop. |
| `v2.ams.get_content_performance` | G | Retrieve content performance of the shop |
| `v2.ams.get_campaign_key_metrics_performance` | G | Retrieve key metrics for Open and Targeted campaigns |
| `v2.ams.get_open_campaign_performance` | G | Retrieve all products in the Open Campaign along with performance data |
| `v2.ams.get_targeted_campaign_performance` | G | Retrieve a list of Targeted Campaigns and their performance data |
| `v2.ams.get_conversion_report` | G | Retrieve the shop's conversion report with details about each order, item, affiliate, campaign.You can filter results using one or multiple time ranges, and the final result will be the intersection of these ranges. Due  |
| `v2.ams.get_validation_list` | G | Retrieve the seller's AMS validation bill |
| `v2.ams.get_validation_report` | G | Retrieve detailed information for a specific validation bill |

## Video

Shopee Video của shop: đăng/sửa video, hiệu quả từng video và sản phẩm gắn video (trễ ≥1 ngày). Cần app loại Shopee Video Management.

| API | | Mô tả gốc |
|---|---|---|
| `v2.video.get_cover_list` | G | You need to call v2.media.init_video_upload, v2.media.upload_video_part, and v2.media.complete_video_upload to upload the video, and call the v2.media.get_video_upload_result to get the video_upload_id of uploaded video. |
| `v2.video.edit_video_info` | P | You need to call v2.media.init_video_upload, v2.media.upload_video_part, and v2.media.complete_video_upload to upload the video, and call the v2.media.get_video_upload_result to get the video_upload_id of uploaded video  |
| `v2.video.post_video` | P | You need to call v2.media.init_video_upload, v2.media.upload_video_part, and v2.media.complete_video_upload to upload the video, then call the v2.video.edit_video_info API to set video post information, finally call this |
| `v2.video.get_video_list` | G | Get the list of video in draft status or video already post to Shopee Video. |
| `v2.video.get_video_detail` | G | Get the detail information of video. |
| `v2.video.delete_video` | P | Use this API to delete video. You can delete the video for both draft and post status. |
| `v2.video.get_overview_performance` | G | Get overall performance data for all post Shopee Video. There is at least a one-day delay. |
| `v2.video.get_metric_trend` | G | Query video data indicator trends. |
| `v2.video.get_user_demographics` | G | Get user demographics data to better understand the types of viewers that watch your Shopee Video. |
| `v2.video.get_video_performance_list` | G | Get specific performance data for individual post Shopee Video. There is at least a one-day delay. |
| `v2.video.get_prodcut_performance_list` | G | Get specific performance data for products linked with Shopee Video. There is at least a one-day delay. |
| `v2.video.get_video_detail_performance` | G | Get detailed performance data for individual post Shopee Video. There is at least a one-day delay. |
| `v2.video.get_video_detail_metric_trend` | G | Get detailed metric trend data for individual post Shopee Video. There is at least a one-day delay. |
| `v2.video.get_video_detail_audience_distribution` | G | Get detailed audience distribution data for individual post Shopee Video. There is at least a one-day delay. |
| `v2.video.get_video_detail_product_performance` | G | Get performance data for products linked with individual post Shopee Video. There is at least a one-day delay. |

## Product

Sản phẩm: danh mục, thuộc tính, item/model (biến thể), giá, tồn, đánh giá, kit, SSP.

| API | | Mô tả gốc |
|---|---|---|
| `v2.product.get_category` | G | Get category tree data. More detail please check https://open.shopee.com/developer-guide/209 |
| `v2.product.get_attribute_tree` | G | Get the attribute tree for categories |
| `v2.product.get_brand_list` | G | Get the brand data of a leaf category. More detail please check: https://open.shopee.com/developer-guide/209 |
| `v2.product.get_item_limit` | G | Get item upload control. |
| `v2.product.get_item_list` | G | Use this call to get a list of items. |
| `v2.product.get_item_base_info` | G | Use this api to get basic info of item by item_id list. |
| `v2.product.get_item_extra_info` | G | Use this api to get extra info of item by item_id list. |
| `v2.product.add_item` | P | Add a new item. |
| `v2.product.update_item` | P | Update item. |
| `v2.product.delete_item` | P | Use this call to delete a product item. |
| `v2.product.init_tier_variation` | P | This API allows you to update the tier structure of a product. Defining only color creates one tier, while color + size creates two tiers (maximum supported). Supported changes include: no tier ↔ one/two tiers, one tier  |
| `v2.product.update_tier_variation` | P | This api can only be used without changing the tier structure, you can add options, delete options, and update the option image by this api. More detail please check: https://open.shopee.com/developer-guide/219 |
| `v2.product.get_model_list` | G | Get model list of an item. |
| `v2.product.add_model` | P | Add model. More detail please check: https://open.shopee.com/developer-guide/219 |
| `v2.product.update_model` | P | Update seller sku/ pre order/ model status for model. |
| `v2.product.delete_model` | P | Delete item model. |
| `v2.product.unlist_item` | P | Unlist item. |
| `v2.product.update_price` | P | Update price. |
| `v2.product.update_stock` | P | Use this API to update one item_id for each call, but still can support updating multiple model_ids stock of the same item_id (If you need batch modification, please call multiple times)This API will update only "seller_ |
| `v2.product.boost_item` | P | Boost item. |
| `v2.product.get_boosted_list` | G | Get boosted item list. |
| `v2.product.get_item_promotion` | G | Get item promotion info. |
| `v2.product.update_sip_item_price` | P | Update sip item price. |
| `v2.product.search_item` | G | Use this call to search item. |
| `v2.product.get_comment` | G | Use this api to get comment by shop_id, item_id, or comment_id, get up to 1000 comments. |
| `v2.product.reply_comment` | P | Use this api to reply comments from buyers in batch. |
| `v2.product.category_recommend` | G | Recommend category by item name. |
| `v2.product.register_brand` | P | Use this call to register a brand. |
| `v2.product.get_recommend_attribute` | G | Get recommend attributes. |
| `v2.product.get_weight_recommendation` | P | Get recommended weight. Now only BR shop support to use this api to get recommended weight. |
| `v2.product.get_size_chart_list ` | G | Get new size chart list. Now only support local shop to use new size chart. |
| `v2.product.get_size_chart_detail` | G | Get new size chart detail. Now only local shop support to use this api to get new size chart detail. |
| `v2.product.get_item_violation_info` | G | get item violation info |
| `v2.product.get_variations` | G | Get the standardized tier variation defined by Shopee, which is currently a three-layer tree structure. The top layer is variations, the second layer is groups, groups are used to divide options, and the third layer is o |
| `v2.product.get_all_vehicle_list` | G | Use this Open API to get all vehicle list. |
| `v2.product.get_vehicle_list_by_compatibility_detail` | G | Use this Open API to get vehicle list by brand, model, year, and version. |
| `v2.product.get_item_content_diagnosis_result` | P | Get the content quality details (including content quality level, content issues, and system suggestions) for specific product list. |
| `v2.product.get_item_list_by_content_diagnosis` | P | Query the list of products and their content quality details by content quality level or content issues. |
| `v2.product.get_kit_item_limit` | G | Get the limit of Kit item. |
| `v2.product.add_kit_item` | P | Create the kit item by selecting multiple items and setting main component and quantity per kit. |
| `v2.product.update_kit_item` | P | Update the kit basic information and kit components, only support adding kit variations and updating existing kit variation’s image, price, and model_sku, don’t support deleting existing kit variations and updating the i |
| `v2.product.get_kit_item_info` | G | Get the kit basic information and kit components. |
| `v2.product.get_aitem_by_pitem_id` | G | Get the list of A Items under SIP Affiliate Shop corresponding to P Items under SIP Primary Shop. |
| `v2.product.search_attribute_value_list` | P | this api is for searching attribute value list for attribute with support_search_value flag |
| `v2.product.get_main_item_list` | G | get main item by direct item. |
| `v2.product.get_direct_item_list` | G | get direct item by main item. |
| `v2.product.get_direct_shop_recommended_price` | G | get recommend price for direct shop. |
| `v2.product.get_product_certification_rule` | P | Get product certification rule |
| ` v2.product.publish_item_to_outlet_shop` | P | This API supports publishing an existing item from the mart shop to an outlet shop. |
| `v2.product.get_mart_item_mapping_by_id` | P | Get the mapping information between a Mart item and its corresponding outlet item by item ID. |
| `v2.product.search_unpackaged_model_list` | P | Use this API to retrieve Unpackaged SKU ID information for items that toggle on logistics channel 30029. |
| `v2.product.generate_kit_image` | P | This API generates a single consolidated image by combining the cover images of all selected items. It is typically used to create a unified product display image for kits or bundles. |
| `v2.product.get_mart_item_by_outlet_item_id` | P | Get the mapping information between a Mart item and its corresponding outlet item by outlet item ID. |
| `v2.product.batch_update_outlet_price` | P | Create asynchronous task to batch update outlet item's price |
| `v2.product.batch_update_outlet_stock` | P | Create asynchronous task to batch update outlet stock |
| `v2.product.get_batch_task_result` | G | Query batch task result |
| `v2.product.batch_add_item` | P | Create asynchronous task to batch add item |
| `v2.product.batch_publish_item_to_outlet_shop` | P | Create asynchronous task to batch publish outlet item |
| `v2.product.get_ssp_detail` | G | Get the details of an SSP or CSSP. At least one of ssp_id and cssp_id is required, and cssp_id takes priority when both are provided. The response covers the product content such as the category path, attributes, brand a |
| `v2.product.get_ssp_recommendation` | G | Get the SSP enrollment recommendations of the authorized shop, separating items that can be enrolled automatically from items that may be enrolled after further action. auto_enroll_time is the automatic enrollment time i |
| `v2.product.search_ssp_list` | P | Search SSPs by title or by image. At most 50 results are returned. When image_id_list is provided, the search is based on image similarity and title is ignored; otherwise title must contain at least three characters. |
| `v2.product.link_item_to_ssp` | P | Link one or more models of an item to their country-specific SSPs. item_id and model_cssp_pairs are required, and each pair must contain model_id and cssp_id; ssp_id is optional. |
| `v2.product.unlink_item_from_ssp` | P | Remove the SSP links of one or more models of an item. item_id and model_cssp_pairs are required, and each pair must contain model_id and cssp_id; ssp_id is optional. |

## GlobalProduct

Sản phẩm toàn cầu cho seller CNSC/KRSC (Trung Quốc, Hàn Quốc). LICHI không dùng.

| API | | Mô tả gốc |
|---|---|---|
| `v2.global_product.get_category` | G | Get global category. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.get_attribute_tree` | G | Get the mtsku attribute trees for categories |
| `v2.global_product.get_brand_list` | G | Use this call to get a list of brand. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.get_global_item_limit` | G | Get global item upload control. |
| `v2.global_product.get_global_item_list` | G | Get global item id list. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.get_global_item_info` | G | Get global item info.Only for China mainland sellers and Korean sellers. |
| `v2.global_product.add_global_item` | P | Add global item. Only for China mainland sellers using China Seller Centre(CNSC). More details in https://shopee.cn/cooperate/46/53/926. |
| `v2.global_product.update_global_item` | P | Update global item. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.delete_global_item` | P | Delete global item. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.init_tier_variation` | P | Only for China mainland sellers and Korean sellers. If you only define color, it is one tier, if you define color and size, it is two tier. Support two tier structures at most. This API can change no tier to one tier, no |
| `v2.global_product.update_tier_variation` | P | Update global product tier variation. Only for China mainland sellers and Korean sellers.This api can only be used without changing the tier structure, you can add options, delete options, and update the option image by  |
| `v2.global_product.add_global_model` | P | Add global model. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.update_global_model` | P | Update global model. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.delete_global_model` | P | Delete global model. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.get_global_model_list` | G | Get global model list. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.support_size_chart` | G | Get category support size chart. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.update_size_chart` | P | Update size chart for global item. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.create_publish_task` | P | Create publish task for global item. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.get_publishable_shop` | G | Get publishable shop list for global item. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.get_publish_task_result` | G | Get publish task result for global item. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.get_published_list` | G | Get published item list of global item. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.update_price` | P | Update global price. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.update_stock` | P | Update global stock. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.set_sync_field` | P | Set auto sync field. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.get_global_item_id` | G | Get get_global_item_id by item_id. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.category_recommend` | G | Recommend category by item name. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.get_recommend_attribute` | G | Get recommend attributes. Only for China mainland sellers and Korean sellers. |
| `v2.global_product.get_shop_publishable_status` | G | Get publishable shop list for global item in pages. |
| `v2.global_product.get_variations` | G | Get the standardized tier variation defined by Shopee, which is currently a three-layer tree structure. The top layer is variations, the second layer is groups, groups are used to divide options, and the third layer is o |
| `v2.global_product.get_size_chart_detail` | G | Get new size chart detail |
| `v2.global_product.get_size_chart_list ` | G | Get size chart list |
| `v2.global_product.search_global_attribute_value_list` | P | this api is for searching attribute value list for attribute with support_search_value flag |
| `v2.global_product.get_local_adjustment_rate` | G | Retrieves the adjustment rate that converts CB stock price into local-warehouse price for a specific shop. |
| `v2.global_product.update_local_adjustment_rate` | P | A multiplier that automatically converts your CB stock price into the local-warehouse price. It ensures your local inventory prices reflect regional costs, currency factors, and margin targets. |

## MediaSpace

Tải ảnh/video lên (bản cũ).

| API | | Mô tả gốc |
|---|---|---|
| `v2.media_space.init_video_upload` | P | Initiate video upload session. Video duration should be between 10s and 60s (inclusive). |
| `v2.media_space.upload_video_part` | P | Upload video file by part using the upload_id in initiate_video_upload. The request Content-Type of this API should be of multipart/form-data |
| `v2.media_space.complete_video_upload` | P | Complete the video upload and starts the transcoding process when all parts are uploaded successfully. |
| `v2.media_space.get_video_upload_result` | G | Query the upload status and result of video upload. |
| `v2.media_space.cancel_video_upload` | P | Cancel a video upload session |
| `v2.media_space.upload_image` | P | Use this API to upload multiple image files (less than 9 images). |

## Media

Tải ảnh/video lên (bản mới).

| API | | Mô tả gốc |
|---|---|---|
| `v2.media.upload_image` | P | Use this API to upload images and support different business scenarios through business and scene parameters. |
| `v2.media.init_video_upload` | P | Use this API to initialize a new video upload task and obtain a unique upload session ID. |
| `v2.media.upload_video_part` | P | Use this API to upload a video file in parts. |
| `v2.media.complete_video_upload` | P | Use this API to finalize a video upload task. Once called, the system will transcode all uploaded video parts and prepare the video for use. All parts must be fully uploaded before calling this API. |
| `v2.media.get_video_upload_result` | G | Use this API to retrieve the current status and result of a video upload task. You can also use video_upload_result_push to get notified immediately when a video upload reaches a final status (SUCCEEDED, FAILED, or CANCE |
| `v2.media.cancel_video_upload` | P | Use this API to cancel an ongoing video upload task. If the upload has already succeeded, failed, or been cancelled, this operation will fail and return error. |

## Shop

Thông tin shop, hồ sơ, kho, thông báo, chế độ nghỉ lễ.

| API | | Mô tả gốc |
|---|---|---|
| `v2.shop.get_shop_info` | G | Use this call to get information of shop |
| `v2.shop.get_profile` | G | This API support to get information of shop. |
| `v2.shop.update_profile` | P | This API support to let sellers to update the shop name, shop logo, and shop description. |
| `v2.shop.get_warehouse_detail` | G | For given shop id and region, return warehouse info including warehouse id, address id and location id, return all warehouse with once call. |
| `v2.shop.get_shop_notification` | G | get Seller Center notification, the permission is controlled by App type |
| `v2.shop.get_authorised_reseller_brand` | G | Get the authorised reseller brand list for the shop. |
| `v2.shop.get_br_shop_onboarding_info` | G | [For BR Shop Only] Use this API to get shop KYC registration and qualification information. |
| `v2.shop.get_shop_holiday_mode` | G | Use this API to check whether a shop has enabled holiday mode and its ongoing and upcoming holiday mode period. |
| `v2.shop.set_shop_holiday_mode` | P | Use this API to set holiday periods in advance for automatic on/off of holiday mode and there are two holiday modes allowing sellers to choose whether to accept new orders during holiday. |

## Merchant

Merchant (một chủ nhiều shop) và kho của merchant.

| API | | Mô tả gốc |
|---|---|---|
| `v2.merchant.get_merchant_info` | G | Use this call to get information of merchant |
| `v2.merchant.get_shop_list_by_merchant` | G | Use this call to get shop_list bound to merchant_id. |
| `v2.merchant.get_merchant_warehouse_location_list` | G | get merchant warehouse location list |
| `v2.merchant.get_merchant_warehouse_list` | P | Get merchant warehouse with page |
| `v2.merchant.get_warehouse_eligible_shop_list` | P | Get eligible shop list by warehouse id |
| `v2.merchant.get_merchant_prepaid_account_list` | G | Use this api to get seller’s courier prepaid account. |

## Order

Đơn hàng: tìm đơn, chi tiết đơn, gói hàng, tách/huỷ đơn, hoá đơn.

| API | | Mô tả gốc |
|---|---|---|
| `v2.order.get_order_list` | G | Use this api to search orders. You may also filter them by status, if needed. |
| `v2.order.get_order_detail` | G | Use this api to get order detail. |
| `v2.order.get_shipment_list` | G | Use this api to get order list which order_status is READY_TO_SHIP or RETRY_SHIP to start process the whole shipping progress. |
| `v2.order.search_package_list` | P | Use this API to search the list of packages that have not been SHIPPED to proceed arranging shipment, and it supports various filters and sort fields. |
| `v2.order.get_package_detail` | G | Use this api to get package detail. |
| `v2.order.split_order` | P | Use this api to split an order into multiple packages. Orders that include installation services cannot be split by quantity. |
| `v2.order.unsplit_order` | P | Use this ai to undo split of order. After undo split, the order will have only one package. It can only be used when order status still at READY_TO_SHIP. |
| `v2.order.cancel_order` | P | Use this api to cancel an order. This action can only be performed before the order has been shipped. |
| `v2.order.handle_buyer_cancellation` | P | Use this api to handle buyer's cancellation application. |
| `v2.order.set_note` | P | Use this api to set note for an order. |
| `v2.order.get_pending_buyer_invoice_order_list` | G | This endpoint only for PH and BR local sellers only. This API is used for seller to retrieve a list of order IDs that are pending invoice upload. |
| `v2.order.get_buyer_invoice_info` | P | API to obtain buyer submitted invoice info for VN, TH and PH local sellers only. |
| `v2.order.upload_invoice_doc` | P | This endpoint is for PH and BR local seller. Upload the invoice document |
| `v2.order.download_invoice_doc` | G | This endpoint only for PH and BR local seller. Seller can download the invoice uploaded before through this endpoint. |
| `v2.order.handle_prescription_check` | P | Use this API to approve or reject a prescription |
| `v2.order.get_warehouse_filter_config` | G | For multi-warehouse shops, return all warehouses with packages that have not been SHIPPED including product_location_id and address_id. Compared to v2.shop.get_warehouse_detail, it covers some edge cases like warehouse t |
| `v2.order.get_booking_list` | G | Use this api to search bookings. You may also filter them by status, if needed. |
| `v2.order.get_booking_detail` | G | Use this api to get booking detail. |
| `v2.order.generate_fbs_invoices` | P | This API creates a task to download a specific tax document (e.g., sales invoice, remessa invoice) for the seller's account, available only after the document is issued by the system as part of the Fulfilled by Shopee (F |
| `v2.order.get_fbs_invoices_result` | P | This API allows you to consult the status of a previously requested batch download for FBS tax documents. |
| `v2.order.download_fbs_invoices` | P | This API allows you to download FBS invoices. To use this API, the client must first call v2.order.generate_fbs_invoices to create a new shipping document task, followed by calling v2.order.get_fbs_invoices_result to che |
| `v2.order.get_estimate_cancel_value` | P | Returns the estimated refund value for a partial order cancellation given the specified items to cancel. |

## Logistics

Vận chuyển: thông số gửi hàng, mã vận đơn, in phiếu, hành trình, kênh vận chuyển, giờ làm việc.

| API | | Mô tả gốc |
|---|---|---|
| `v2.logistics.get_shipping_parameter` | G | Use this api to check if the package support pickup, dropoff, or non-integrated method. For pickup, will return addresses and pickup time id options. For dropoff, will return branch id, sender real name etc, depending on |
| `v2.logistics.get_mass_shipping_parameter` | P | Use this api to check if package support pickup, dropoff, non-integrated. For pickup, return address and pickup time id options. For dropoff, return branch id, sender real name, etc. Can batch request for packages under  |
| `v2.logistics.ship_order` | P | Use this api to initiate logistics including arrange pickup, dropoff or shipment for non-integrated logistic channels. Should call v2.logistics.get_shipping_parameter to fetch all required param first. It's recommended t |
| `v2.logistics.mass_ship_order` | P | Use this api to initiate logistics including arrange pickup, dropoff or shipment for non-integrated logistic channels. Should call v2.logistics.get_mass_shipping_parameter to fetch all required params first. It's recomme |
| `v2.logistics.update_shipping_order` | P | For pickup method only, use this api to update pickup address and pickup time for packages meet: 1) package's fulfillment status is LOGISTICS_PICKUP_RETRY; or 2) package's fulfillment status is 'LOGISTICS_REQUEST_CREATED |
| `v2.logistics.get_tracking_number` | G | After arranging shipment (v2.logistics.ship_order) for the integrated channel, use this api to get the tracking_number, which is a required parameter for creating shipping labels. The api response can return tracking_num |
| `v2.logistics.get_mass_tracking_number` | P | After arranging shipment (v2.logistics.mass_ship_order) for the integrated channel, use this api to get the tracking_number, which is a required parameter for creating shipping labels. The api response can return trackin |
| `v2.logistics.get_shipping_document_parameter` | P | Use this api to get the selectable shipping_document_type and suggested shipping_document_type. |
| `v2.logistics.create_shipping_document` | P | Use this api to create shipping document task for each order or package and this API is only available after retrieving the tracking number. |
| `v2.logistics.get_shipping_document_result` | P | Use this api to retrieve the status of the shipping document task. Document will be available for download only after the status change to 'READY'. |
| `v2.logistics.download_shipping_document` | P | Use this api to download shipping_document. You have to call v2.logistics.create_shipping_document to create a new shipping document task first and call v2.logistics.get_shipping_document_resut to get the task status sec |
| `v2.logistics.get_shipping_document_data_info` | P | Use this api to fetch the logistics information of an order, these info can be used for self-design AWB printing. Besides, this api supports returning personal info as images. |
| `v2.logistics.get_tracking_info` | G | Use this api to get the logistics tracking information of an order. |
| `v2.logistics.get_address_list` | G | For integrated logistics channel, use this call to get pickup address for pickup mode order. |
| `v2.logistics.set_address_config` | P | Use this API to set address config of your shop. |
| `v2.logistics.update_address` | P | Use this API to update the address of a shop. |
| `v2.logistics.delete_address` | P | Use this api to delete address. |
| `v2.logistics.get_channel_list` | G | Use this api to get all supported logistic channels. |
| `v2.logistics.update_channel` | P | Use this api to update shop level logistics channel's configuration. |
| `v2.logistics.get_operating_hours` | G | This API is utilized to retrieve the existing operating hours of sellers including Pickup Operating Hours, Special Hours, Instant Operating Hours, and Shop Collection Operating Hours. |
| `v2.logistics.get_operating_hour_restrictions` | G | This API is designed to retrieve all restrictions related to inputting operating hours for the v2.logistics.update_operating_hours function. This API ensures that user are aware of any limitations or conditions that may  |
| `v2.logistics.update_operating_hours` | P | This API is designed to allow sellers to update their operating hours. It is essential that the values provided in this API align with the restrictions retrieved from the v2.logistics.get_operating_hour_restrictions API  |
| `v2.logistics.delete_special_operating_hour` | P | This API is used to delete a specific special operating hour for a seller. This API allows sellers to manage their operating hours by removing any special operating hours that are no longer needed. To use this API, the n |
| `v2.logistics.batch_update_tpf_warehouse_tracking_status` | P | For CB orders that fulfilled by 3PF, support 3PF Warehouse Vendors to update the tpf_tracking_status when 3PF warehouse receive the order and complete the outbound of the package. CB orders that fulfilled by 3PF： v2.shop |
| `v2.logistics.batch_ship_order` | P | Use this api to batch initiate logistics including arrange pickup, dropoff or shipment for non-integrated logistic channels. Should call v2.logistics.get_shipping_parameter to fetch all required param first. It's recomme |
| `v2.logistics.update_tracking_status` | P | Only available for Brazil sellers. This API is only available for orders/parcels which are fulfilled by BR Seller Logistics channel (logistics_channel_id: 90021), Samsung (logistics_channel_id: 90025) and BR Instant Deli |
| `v2.logistics.get_booking_shipping_parameter` | G | Use this api to get the parameter "info_needed" from the response to check if the booking has pickup or dropoff. This api will also return the addresses and pickup time id options for the pickup method. For dropoff, it c |
| `v2.logistics.ship_booking` | P | Use this api to initiate logistics including arrange pickup, dropoff. Should call v2.logistics.get_booking_shipping_parameter to fetch all required param first. |
| `v2.logistics.get_booking_tracking_number` | G | After arranging shipment (v2.logistics.ship_booking) for the integrated channel, use this api to get the tracking_number, which is a required parameter for creating shipping labels. The api response can return tracking_n |
| `v2.logistics.get_booking_shipping_document_parameter` | P | Use this api to get the selectable shipping_document_type and suggested shipping_document_type. |
| `v2.logistics.create_booking_shipping_document` | P | Use this api to create shipping document task for each booking and this API is only available after retrieving the tracking number. |
| `v2.logistics.get_booking_shipping_document_result` | P | Use this api to retrieve the status of the shipping document task. Document will be available for download only after the status change to 'READY'. |
| `v2.logistics.download_booking_shipping_document` | P | Use this api to download shipping_document. You have to call v2.logistics.create_booking_shipping_document to create a new shipping document task first and call v2.logistics.get_booking_shipping_document_result to get th |
| `v2.logistics.get_booking_shipping_document_data_info` | P | Use this api to fetch the logistics information of a booking these info can be used for airwaybill printing. Dedicated for crossborder SLS order airwaybill. May not be applicable for local channel airwaybill. Besides, th |
| `v2.logistics.get_booking_tracking_info` | G | Use this api to get the logistics tracking information of a booking. |
| `v2.logistics.download_to_label` | P | Use the API to download the TO label that should be attached to the carton before drop-off at the warehouse (Only for TW channel_id:30029). |
| `v2.logistics.create_shipping_document_job` | P | This API creates a shipping document job for selected documents. The system receives requests and returns a job ID along with success and failure details. |
| `v2.logistics.get_shipping_document_job_status` | P | This API retrieves the status of a shipping document job using the job ID provided. |
| `v2.logistics.download_shipping_document_job` | P | This API allows users to download the shipping document associated with a specific job ID. It checks the job status before proceeding with the download. |
| `v2.logistics.update_self_collection_order_logistics` | P | Use this api to update the order status for buyer to collect the orders directly from your pharmacy. This includes indicating that order is ready for collection, and that the order has been picked up by the buyer. You sh |
| `v2.logistics.get_mart_packaging_info` | G | [Only for ID mart seller] The API allows sellers to retrieve their current packaging fee settings. |
| `v2.logistics.set_mart_packaging_info` | P | [Only for ID mart seller] This API allows sellers to set up their packaging fee info. Through this API, sellers can enable or disable packaging fees, and if enabled, specify the dimensions of the packaging and the associ |
| `v2.logistics.upload_serviceable_polygon` | P | Only available for Brazil sellers. Use this API to upload KML file for shop level serviceability setting for BR Entrega Turbo channel (Channel ID: 90026). Please note that multiple Outlet Shops under the same Mart Shop c |
| `v2.logistics.check_polygon_update_status` | P | Only available for Brazil sellers. Use this API to check the status of polygon file uploaded for BR Entrega Turbo channel (Channel ID: 90026) by querying the task_id returned via the v2.logistics.upload_serviceable_polyg |
| `v2.logistics.get_pause_status` | G | This API returns the pause status of logistics channels under the shop. Pausing allows the shop to temporarily prevent buyers from placing orders through specific logistics channels. The response includes whether a pause |
| `v2.logistics.set_pause_status` | P | Use this API to set the pause status of logistics channels under the shop. Pausing allows the shop to temporarily prevent buyers from placing orders through specific logistics channels. The response includes whether a pa |
| `v2.logistics.download_to_label_filelink` | P | Use the API to download the TO label that should be attached to the carton before drop-off at the warehouse (Only for TW channel_id:30029). This API will return file link instead of blob. |
| `v2.logistics.download_shipping_document_job_filelink` | P | This API allows users to download the shipping document associated with a specific job ID. It checks the job status before proceeding with the download. The response will contain a link that can be used to download the s |

## FirstMile

Chặng đầu cho seller xuyên biên giới. LICHI không dùng.

| API | | Mô tả gốc |
|---|---|---|
| `v2.first_mile.get_unbind_order_list` | G | Use this api to get unbind order list. It will only return orders unbound to first-mile that were created within the past 6 months. |
| `v2.first_mile.get_detail` | G | Use this api to get first mile detail. |
| `v2.first_mile.generate_first_mile_tracking_number` | P | Use this api to generate first mile tracking number. |
| `v2.first_mile.bind_first_mile_tracking_number` | P | Use this api to bind first mile tracking number. |
| `v2.first_mile.unbind_first_mile_tracking_number` | P | Use this api to unbind first mile. |
| `v2.first_mile.get_tracking_number_list` | G | Use this api to get first mile tracking number list. |
| `v2.first_mile.get_waybill` | P | Use this api to get first mile waybill file. |
| `v2.first_mile.get_channel_list` | G | Use this api to get first mile channel list. |
| `v2.first_mile.get_courier_delivery_channel_list` | G | Use this api to get courier information for courier delivery method. |
| `v2.first_mile.get_transit_warehouse_list` | G | Use this api to get transit warehouse list which is used for first mile tracking number generation for courier delivery method. |
| `v2.first_mile.generate_and_bind_first_mile_tracking_number` | P | Use this api to generate first mile tracking number for courier delivery method. |
| `v2.first_mile.bind_courier_delivery_first_mile_tracking_number` | P | Use this api to bind first mile tracking number for courier delivery method. |
| `v2.first_mile.unbind_first_mile_tracking_number_all` | P | Use this api to unbind orders from first mile tracking number or binding ID. |
| `v2.first_mile.get_courier_delivery_detail` | G | Use this api to get first mile detail for courier delivery method. |
| `v2.first_mile.get_courier_delivery_waybill` | P | Use this api to get first mile waybill file for courier delivery method. |
| `v2.first_mile.get_courier_delivery_tracking_number_list` | P | Use this api to get tracking number for courier delivery method. |
| `v2.first_mile.cancel_courier_delivery_first_mile_tracking_number` | P | Use this api to cancel first mile tracking number for courier delivery method. |
| `v2.first_mile.get_waybill_filelink` | P | Use this api to get first mile waybill file link. |

## Payment

Tiền: escrow (tiền thực nhận từng đơn, phí sàn), ví shop, thu nhập, báo cáo thu nhập, trả góp.

| API | | Mô tả gốc |
|---|---|---|
| `v2.payment.get_escrow_detail` | G | Use this API to fetch the accounting detail of order. |
| `v2.payment.set_shop_installment_status` | P | Sets the staging capability of shop level. |
| `v2.payment.get_shop_installment_status` | G | Get the installment state of shop. |
| `v2.payment.get_payout_detail` | G | This API is applicable for Cross Border (CB) sellers only to get the shop's payout data, such as the payout amount, currency, FX rate, the payout's associated order income and adjustment records etc. |
| `v2.payment.set_item_installment_status` | P | Set item installment.Only for TH、TW. |
| `v2.payment.get_item_installment_status` | P | Get item installment tenures.Only for TH、TW. |
| `v2.payment.get_payment_method_list` | G | Obtain payment method (no authentication required) |
| `v2.payment.get_wallet_transaction_list` | G | Use this API to get the transaction records of wallet. Only applicable for local shops |
| `v2.payment.get_escrow_list` | G | Use this API to fetch the accounting list of order. |
| `v2.payment.get_payout_info` | G | This is a new API which applicable for Cross Border (CB) sellers only to get the shop's payout data, will be used for the original API v2.get_payout_details replacement, we provide data such as the payout amount, currenc |
| `v2.payment.get_billing_transaction_info` | P | This API is applicable for Cross Border (CB) sellers only to get the detailed payout transaction data, both released and to-be released transaction can be found in here |
| `v2.payment.get_escrow_detail_batch` | G | Use this API to fetch the details of order income by batch. |
| `v2.payment.generate_income_statement` | G | Trigger income statement generation. |
| `v2.payment.get_income_statement` | G | To query income statement status and provide file link if the income statement is ready to be downloaded. |
| `v2.payment.generate_income_report` | G | Trigger income report generation. |
| `v2.payment.get_income_report` | G | To query income report status and provide file link if the income report is ready to be downloaded. |
| `v2.payment.get_income_overview` | G | Retrieves a consolidated snapshot of the seller’s income amounts categorized by income status for a specified shop. This API provides a holistic overview similar to Seller Center’s “Income Overview” section, allowing ext |
| `v2.payment.get_income_detail` | G | Retrieves detailed order-level income information across various income statuses for a specified time period. This API enables partners to display granular transaction-level income data consistent with Seller Center’s “I |

## Discount

Chương trình giảm giá của shop.

| API | | Mô tả gốc |
|---|---|---|
| `v2.discount.add_discount` | P | Use this api to add shop discount activity |
| `v2.discount.add_discount_item` | P | Use this api to add shop discount item. |
| `v2.discount.delete_discount` | P | Use this api to delete one discount activity |
| `v2.discount.delete_discount_item` | P | Use this api to delete items of the discount activity |
| `v2.discount.get_discount` | G | Use this api to get one shop discount activity detail |
| `v2.discount.get_discount_list` | G | Use this api to get shop discount activity list |
| `v2.discount.update_discount` | P | Use this api to update one discount information |
| `v2.discount.update_discount_item` | P | Use this api to update items of the discount promotion. |
| `v2.discount.end_discount` | P | Use this api to end shop discount activity |
| `v2.discount.get_sip_discounts` | G | Get SIP Overseas Discounts. Only regions that have upcoming/ongoing discounts will be returned. Please use Primary shop's Shop ID to request, the API will return the list of Affiliate shops under this Primary shop that h |
| `v2.discount.set_sip_discount` | P | Set SIP Overseas Discount for SIP affiliate region. Please use Primary shop's Shop ID to request, and provide the region and discount rate of the Affiliate shop to be set or update, the API will set or update the discoun |
| `v2.discount.delete_sip_discount` | P | Delete SIP Overseas Discounts for SIP affiliate region. Please use Primary shop's Shop ID to request, and provide the region of the Affiliate shop to be deleted, the API will delete the discount from that region's Affili |

## Bundle Deal

Combo khuyến mãi (mua nhiều giảm).

| API | | Mô tả gốc |
|---|---|---|
| `v2.bundle_deal.add_bundle_deal` | P | create bundle deal. Relevant restrictions refer to FAQ：https://open.shopee.com/faq/254 |
| `v2.bundle_deal.add_bundle_deal_item` | P | add product to bundle deal |
| `v2.bundle_deal.get_bundle_deal_list` | G | get bundle deal list |
| `v2.bundle_deal.get_bundle_deal` | G | get bundle deal detail |
| `v2.bundle_deal.get_bundle_deal_item` | G | get bundle deal item |
| `v2.bundle_deal.update_bundle_deal` | P | update bundle deal. Relevant restrictions refer to FAQ：https://open.shopee.com/faq/254 |
| `v2.bundle_deal.update_bundle_deal_item` | P | update product in bundle deal |
| `v2.bundle_deal.end_bundle_deal` | P | end bundle deal |
| `v2.bundle_deal.delete_bundle_deal` | P | delete bundle deal |
| `v2.bundle_deal.delete_bundle_deal_item` | P | delete product in bundle deal |

## Add-On Deal

Mua kèm deal sốc / quà tặng.

| API | | Mô tả gốc |
|---|---|---|
| `v2.add_on_deal.add_add_on_deal` | P | Add Add-on Deal |
| `v2.add_on_deal.add_add_on_deal_main_item` | P | Add Add-on Deal Main Item |
| `v2.add_on_deal.add_add_on_deal_sub_item` | P | Add Add-on Deal Sub Item |
| `v2.add_on_deal.delete_add_on_deal` | P | Delete Add-on Deal |
| `v2.add_on_deal.delete_add_on_deal_main_item` | P | Delete Add-on Deal Main Item |
| `v2.add_on_deal.delete_add_on_deal_sub_item` | P | Delete Add-on Deal Sub Item |
| `v2.add_on_deal.get_add_on_deal_list` | G | Get Add-on Deal List |
| `v2.add_on_deal.get_add_on_deal` | G | Get Add-on Deal |
| `v2.add_on_deal.get_add_on_deal_main_item` | G | Get Add-on Deal Main Item |
| `v2.add_on_deal.get_add_on_deal_sub_item` | G | Get Add-on Deal Sub Item |
| `v2.add_on_deal.update_add_on_deal` | P | Update Add-on Deal |
| `v2.add_on_deal.update_add_on_deal_main_item` | P | Update Add-on Deal Main Item |
| `v2.add_on_deal.update_add_on_deal_sub_item` | P | Update Add-on Deal Sub Item |
| `v2.add_on_deal.end_add_on_deal` | P | End Add-on Deal |

## Voucher

Mã giảm giá của shop.

| API | | Mô tả gốc |
|---|---|---|
| `v2.voucher.add_voucher` | P | Add voucher |
| `v2.voucher.delete_voucher` | P | Delete voucher |
| `v2.voucher.end_voucher` | P | End Voucher |
| `v2.voucher.update_voucher` | P | Update voucher |
| `v2.voucher.get_voucher` | G | Get Voucher Detail |
| `v2.voucher.get_voucher_list` | G | Get Voucher List |

## ShopFlashSale

Flash sale của shop.

| API | | Mô tả gốc |
|---|---|---|
| `v2.shop_flash_sale.get_time_slot_id` | G | get time slot id |
| `v2.shop_flash_sale.create_shop_flash_sale` | P | creat shop flash sale |
| `v2.shop_flash_sale.get_item_criteria` | G | get shop flash sale item criteria |
| `v2.shop_flash_sale.add_shop_flash_sale_items` | P | add shop flash sale item |
| `v2.shop_flash_sale.get_shop_flash_sale_list` | G | get shop flash sale list |
| `v2.shop_flash_sale.get_shop_flash_sale` | G | get shop flash sale detail |
| `v2.shop_flash_sale.get_shop_flash_sale_items` | G | get shop flash sale items and item detail |
| `v2.shop_flash_sale.update_shop_flash_sale` | P | edit shop flash sale(enable, disable) |
| `v2.shop_flash_sale.update_shop_flash_sale_items` | P | edit shop flash sale item, you can only edit the models in disbaled or enabled status |
| `v2.shop_flash_sale.delete_shop_flash_sale` | P | delete shop flash sale |
| `v2.shop_flash_sale.delete_shop_flash_sale_items` | P | delete shop flash sale items |

## Follow Prize

Quà theo dõi shop.

| API | | Mô tả gốc |
|---|---|---|
| `v2.follow_prize.add_follow_prize` | P | OpenAPI add Follow Prize |
| `v2.follow_prize.delete_follow_prize` | P | delete_follow_prize |
| `v2.follow_prize.end_follow_prize` | P | end follow prize |
| `v2.follow_prize.update_follow_prize` | P | update_follow_prize |
| `v2.follow_prize.get_follow_prize_detail` | G | get_follow_prize_detail |
| `v2.follow_prize.get_follow_prize_list` | G | OpenAPI get_follow_prize_list |

## TopPicks

Bộ sưu tập sản phẩm nổi bật.

| API | | Mô tả gốc |
|---|---|---|
| `v2.top_picks.get_top_picks_list` | G | get one TopPicks |
| `v2.top_picks.add_top_picks` | P | add one collection |
| `v2.top_picks.update_top_picks` | P | update a collection info |
| `v2.top_picks.delete_top_picks` | P | delete a collection |

## ShopCategory

Danh mục trong shop.

| API | | Mô tả gốc |
|---|---|---|
| `v2.shop_category.add_shop_category` | P | Use this call to add a new shop collecion |
| `v2.shop_category.get_shop_category_list` | G | Use this call to get list of shop categories |
| `v2.shop_category.delete_shop_category` | P | Use this call to delete a existing shop collecion |
| `v2.shop_category.update_shop_category` | P | Use this call to update a existing collecion |
| `v2.shop_category.add_item_list` | P | Use this call to add items list to certain shop_category |
| `v2.shop_category.get_item_list` | G | Use this call to get items list of certain shop_category |
| `v2.shop_category.delete_item_list` | P | Use this api to delete items from shop category |

## Returns

Trả hàng/hoàn tiền: danh sách, chi tiết, xác nhận, khiếu nại, bằng chứng, hành trình hoàn.

| API | | Mô tả gốc |
|---|---|---|
| `v2.returns.get_return_list` | G | Use this api to get detail information of many return by shop id. |
| `v2.returns.get_return_detail` | G | Use this api to get detail information of a return by return sn. |
| `v2.returns.confirm` | P | Confirm refund |
| `v2.returns.dispute` | P | Dispute return. Support to raise dispute when return_status in REQUESTED / PROCESSING/ACCEPTED |
| `v2.returns.get_available_solutions` | G | Get the available solutions offered to buyers. |
| `v2.returns.offer` | P | v2.returns.offer |
| `v2.returns.accept_offer` | P | v2.returns.accept_offer |
| `v2.returns.convert_image` | P | Convert a specific format and pictures within 10M into url. |
| `v2.returns.upload_proof` | P | Support sellers to upload evidence, including text and pictures and videos converted into URLs. |
| `v2.returns.query_proof` | G | Support sellers to query the evidence uploaded through the upload evidence API. |
| `v2.returns.get_return_dispute_reason` | G | To get the dispute return reason. |
| `v2.returns.cancel_dispute` | P | Sellers can only cancel compensation disputes, not normal disputes. This means that sellers can only cancel disputes when the return_status is ACCEPTED and the compensation_status is COMPENSATION_REQUESTED. |
| `v2.returns.get_shipping_carrier` | G | Use this API to get the list of shipping carriers and request parameters needed before calling v2.returns.upload_shipping_proof. Only for TW and BR returns with is_seller_arrange = true. |
| `v2.returns.upload_shipping_proof` | P | Use this API to upload shipping proof (Only for TW and BR returns with is_seller_arrange = true). This is not to upload evidence for disputes. |
| `v2.returns.get_reverse_tracking_info` | G | Get reverse and post-return logistics information of return request. For Normal RR, return complete reverse logistics information, for In-transit RR and Return-on-the-Spot, only return latest reverse logistics status, wi |

## AccountHealth

Sức khoẻ tài khoản: chỉ số vận hành, điểm phạt, đơn trễ, sản phẩm vi phạm.

| API | | Mô tả gốc |
|---|---|---|
| `v2.account_health.get_shop_performance` | G | The data metrics of shop performance. |
| `v2.account_health.get_metric_source_detail` | G | Get the Affected Orders / Relevant Listings / Relevant Violations details of metrics. |
| `v2.account_health.get_penalty_point_history` | G | Get the penalty point records generated in the current quarter. |
| `v2.account_health.get_punishment_history` | G | Get the punishment records generated in the current quarter. |
| `v2.account_health.get_listings_with_issues` | G | Get the Problematic Listings to improve the listings to avoid incurring penalty points. |
| `v2.account_health.get_late_orders` | G | Get the Late Orders to take action to avoid order cancellation and penalty points. |

## Ads

Quảng cáo Shopee Ads: số dư, hiệu quả CPC theo ngày/giờ (shop và từng chiến dịch), GMV Max, tạo/sửa chiến dịch.

| API | | Mô tả gốc |
|---|---|---|
| `v2.ads.get_total_balance` | G | Use this API to return the seller's Real-time total balance of their ads credit including the paid credits and free credits. |
| `v2.ads.get_shop_toggle_info` | G | Use this API to get Shop level info - i.e. seller's toggle status is on/off |
| `v2.ads.get_recommended_keyword_list` | G | Use this API to get the list of Recommended keywords by item and optionally a search keyword |
| `v2.ads.get_recommended_item_list` | G | Use this API to get the list of recommended SKU (Shop level) with the corresponding tag, i.e top search/best selling/best ROI tag. |
| `v2.ads.get_all_cpc_ads_hourly_performance` | G | Use this API to get Shop level CPC ads single-date hourly performance. |
| `v2.ads.get_all_cpc_ads_daily_performance` | G | Use this API to get Shop level CPC ads multiple-days daily performance. |
| `(coming offline soon) v2.ads.create_auto_product_ads` | P | Use this API to create Auto Product Ads |
| `(coming offline soon) v2.ads.edit_auto_product_ads` | P | Use this API to edit Auto Product Ads |
| `v2.ads.get_product_campaign_daily_performance` | G | Use this API to get Product level ads multiple-days daily performance. |
| `v2.ads.get_product_campaign_hourly_performance` | G | Use this API to get Product level ads single-day hourly performance. |
| `v2.ads.get_product_level_campaign_id_list` | G | Call this API to fetch all the product campaign ids displayed on advertiser platform under a specific Shop |
| `v2.ads.get_product_level_campaign_setting_info` | G | Call this API to fetch all the campaign setting info under this Shop. |
| `v2.ads.create_manual_product_ads` | P | Use this API to create Manual Selection Product Ads |
| `v2.ads.edit_manual_product_ad_keywords` | P | Use this API to edit Manual Selection Product Ad Keywords |
| `v2.ads.edit_manual_product_ads` | P | Use this API to edit Manual Selection Product Ads |
| `v2.ads.get_create_product_ad_budget_suggestion` | G | Call this API to get budget suggestion for product ads creation |
| `v2.ads.get_product_recommended_roi_target` | G | Get Product Recommended ROI Target |
| `v2.ads.get_ads_fácil_shop_rate` | G | Get shop rate for Ads Facil Program |
| `v2.ads.check_create_gms_product_campaign_eligibility` | G | Check the seller's eligibility in creating a GMS campaign |
| `v2.ads.create_gms_product_campaign` | P | Create a GMS campaign |
| `v2.ads.edit_gms_product_campaign` | P | Edit a GMS campaign |
| `v2.ads.list_gms_user_deleted_item` | P | List GMS items that have been removed from the Campaign by seller |
| `v2.ads.edit_gms_item_product_campaign` | P | Add/remove items to/from the GMS Campaign |
| `v2.ads.get_gms_campaign_performance` | P | Get GMS Campaign performance |
| `v2.ads.get_gms_item_performance` | P | Get GMS Item performance 1. The response returned is sorted by item_id 2. Only items with performance will be returned |

## Public

Xác thực: lấy/làm mới access_token, danh sách shop đã uỷ quyền, dải IP Shopee.

| API | | Mô tả gốc |
|---|---|---|
| `v2.public.get_shops_by_partner` | G | get basic info of shops which have authorized to the partner. |
| `v2.public.get_merchants_by_partner` | G | Use this API to get basic info of merchants which have authorized to the partner. |
| `v2.public.get_access_token` | P | Use the code from the authorization step to call this API to obtain the authorized shop_id, merchant_id, supplier_id, or user_id, and its corresponding access_token and refresh_token. |
| `v2.public.refresh_access_token` | P | Use this API to refresh the access_token after it expires. Refresh_token can be used once only, this API will also return a new refresh_token. Please use the new refresh_token for the next RefreshAccessToken call |
| `v2.public.get_token_by_resend_code` | P | Use the resend code to get access token and refresh token. When you lost your access token or refresh token, you can go to authorization management page to resend code by yourselves. You can only use this endpoint in liv |
| `v2.public.get_shopee_ip_ranges` | G | You can get shopee ip address ranges through this open api. |

## Push

Cấu hình webhook và lấy lại push bị mất trong 3 ngày.

| API | | Mô tả gốc |
|---|---|---|
| `v2.push.set_app_push_config` | P | you can turn on or turn off your app push config setting through this open api |
| `v2.push.get_app_push_config` | G | you can get your app current push config setting through this api |
| `v2.push.get_lost_push_message` | G | Get the lost push messages that were lost within 3 days of the current time and not confirmed to have been consumed |
| `v2.push.confirm_consumed_lost_push_message` | P | Confirm consumed lost push message |

## SBS

Kho Shopee (SBS): tồn kho, tuổi tồn, xuất nhập.

| API | | Mô tả gốc |
|---|---|---|
| `v2.sbs.get_bound_whs_info` | G | get bound warehouse by shop id |
| `v2.sbs.get_current_inventory` | G | Get Seller Center Current Inventory Page Data |
| `v2.sbs.get_expiry_report` | G | Seller Center Expiry Report page data |
| `v2.sbs.get_stock_aging` | G | Get Seller Center Stock Aging page data |
| `v2.sbs.get_stock_movement` | G | Get Seller Center，Stock Movement page data |
| `v2.sbs.get_fulfillment_mapping_inventory_list` | G | This API is designed for sellers using Fulfillment Mapping and their ERP systems. It allows callers to query the corresponding mapping and inventory information using the MTSKU ID of either a Bundle SKU or a Parent SKU,  |

## FBS

Fulfilled by Shopee Brazil. LICHI không dùng.

| API | | Mô tả gốc |
|---|---|---|
| `v2.fbs.query_br_shop_enrollment_status` | G | This API checks whether a given shop_id is eligible to enroll in the Brazil Fulfilled-by-Shopee (FBS) service. |
| `v2.fbs.query_br_shop_invoice_error` | G | This API handles failed invoice issuance for FBS-related processes, covering Inbound Requests, RTS Requests, Sales Orders, and Move Transfer Orders. |
| `v2.fbs.query_br_shop_block_status` | G | This API checks whether an FBS shop is blocked due to invoice-related issues. When blocked, the shop cannot create new Inbound Requests, and its warehouse inventory is restricted from being sold. |
| `v2.fbs.query_br_sku_block_status` | G | This API checks whether an FBS product is blocked due to invoice-related issues. When blocked, the product cannot be included in new Inbound Requests, and its warehouse inventory is restricted from being sold. |

## Livestream

Shopee Live của shop: tạo phiên, giỏ hàng, chỉ số realtime phiên và sản phẩm. Cần app loại Livestream Management.

| API | | Mô tả gốc |
|---|---|---|
| `v2.livestream.upload_image` | P | Upload an image as the live stream cover.(For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.create_session` | P | Create a new live stream, include basic information, like cover, title, description, type (test live or normal live). (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.update_session` | P | Update live stream information, including cover, title, description, and type (test live or normal live). (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.start_session` | P | Start Live. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.end_session` | P | End Live. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.get_session_detail` | G | Get basic information about the live streaming room, including cover, title, description, type (test live or normal live), create time, update time, stream url, etc. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.add_item_list` | P | Add items to item bag. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.delete_item_list` | P | Delete items from item bag. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.update_item_list` | P | Update the order of items in item bag. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.get_item_count` | G | Get the number of items in the shopping bag, including the current number of items in the shopping bag, the upper limit of the number, etc. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.get_item_list` | G | Get the detail information of item in item bag, including item id, item serial number, etc.(For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.update_show_item` | P | Set the showing item. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.delete_show_item` | P | Unshow showing item. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.get_show_item` | G | Get the showing item. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.get_like_item_list` | G | Get the item list of My Likes tab.(For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.get_recent_item_list` | G | Get the item list of the Recently tab. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.get_item_set_list` | G | Get the product set of the live stream, including the product set name, id, and item number. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.get_item_set_item_list` | G | Get the item list of the product set, including item name, id, etc. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.apply_item_set` | P | Add product set to item bag. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.get_session_metric` | G | Get real-time indicator data of the live stream room, including the number of likes, comments, shares, views, etc.(For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.get_session_item_metric` | G | Get real-time indicator data of live stream products, including product clicks, add-to-cart, etc. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.get_latest_comment_list` | G | Get live stream room comments in the last 10 seconds, including user id, user name, comment id, comment content, and comment time. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.post_comment` | P | Post comment in the live stream as streamer. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.ban_user_comment` | P | Ban the user from posting comments. (For TW, ID, TH, PH, MY, SG, VN) |
| `v2.livestream.unban_user_comment` | P | Unban a user from posting comments. (For TW, ID, TH, PH, MY, SG, VN) |

## Installation

Đơn có lắp đặt (BR).

| API | | Mô tả gốc |
|---|---|---|
| `v2.installation.receive_installation_order` | P | Receive installation order. Use this API to move installation status to PARCEL_PICKED_UP. |
| `v2.installation.validate_installation_otp_code` | P | Validate installation order OTP code. Use this API to validate OTP code when parcel status is PARCEL_PICKED_UP, PARCEL_REQUEST_CANCELLED, or PARCEL_CANCELLED. |

## BrandPortal

Brand Portal (cấp thương hiệu/principal): doanh số, affiliate, live, video gộp nhiều shop. Cần app loại Brand Portal Service + uỷ quyền principal.

| API | | Mô tả gốc |
|---|---|---|
| `v2.principal.get_shop_sales_performance_detail` | P | Queries the business performance data of stores under the specified entity within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary m |
| `v2.principal.get_principal_sales_performance_detail` | P | Queries the business performance data aggregated at principal level for the specified regions within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns bot |
| `v2.principal.get_shop_affiliate_performance` | P | Queries affiliate performance data for the specified shops within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and shop- |
| `v2.principal.get_principal_affiliate_performance` | P | Queries affiliate performance data for the specified principal within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and r |
| `v2.principal.get_content_affiliate_performance` | P | Queries affiliate performance data for the specified content items within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics a |
| `v2.principal.get_shop_livestream_performance` | P | Queries livestream performance data for the specified shops within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and shop |
| `v2.principal.get_principal_livestream_performance` | P | Queries livestream performance data for the specified principal within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and  |
| `v2.principal.get_session_livestream_performance` | P | Queries livestream session performance data for the specified sessions within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metri |
| `v2.principal.get_shop_video_performance` | P | Queries video performance data for the specified shops within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and shop-leve |
| `v2.principal.get_principal_video_performance` | P | Queries video performance data for the specified principal within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and regio |
| `v2.principal.get_clip_video_performance` | P | Queries video clip performance data for the specified videos within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and vid |

## Buybox

Buybox (chỉ BR).

| API | | Mô tả gốc |
|---|---|---|
| `v2.buybox.get_buybox_models_by_shop_id（only for BR now）` | P | Get the paginated Buybox model list for the authorized shop. |
| `v2.buybox.get_buybox_models_by_model_id（only for BR now）` | P | Get Buybox model information by model IDs for the authorized shop. |
| `v2.buybox.get_buybox_shop_performance（only for BR now）` | P | Get Buybox shop performance for the authorized shop. |
| `v2.buybox.get_buybox_model_performance（only for BR now）` | P | Get Buybox model performance by model IDs for the authorized shop. |
| `v2.buybox.update_buybox_model_enrollment（only for BR now）` | P | Update Buybox model enrollment status for the authorized shop. |

## BusinessInsights

Business Insights (chỉ BR).

| API | | Mô tả gốc |
|---|---|---|
| `v2.business_insights.get_marketing_hot_listing（only BR now）` | P | Provide all metrics currently available on the Business Insights Buybox dashboard, including metrics not explicitly requested by Local (for example, CTR), covering both: Shop-level performance Product-level performance |
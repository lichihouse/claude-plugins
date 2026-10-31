# Module Product (63 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.product.get_category
`GET /api/v2/product/get_category` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Customized APP, Ads Service, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management

Get category tree data. More detail please check https://open.shopee.com/developer-guide/209

Rate limit: [0,0,0]

Lịch sử cập nhật: 2021-10-29: update language description; 2021-09-29: update language description; 2021-07-05: update language description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `language` | string |  | If language is not uploaded, the default language=en, the following are the languages supported by different markets SG: en ; MY: en / ms-my / zh-hans ; TH: en / th ; VN: en / vi ; PH: en ; TW: en / zh-hant ; ID: en / id ; BR: en / pt-br ; MX: en / es-mx ; CO: en/es-CO ; CL: en/es-CL .Note: For markets that have already launched global tree, Crossboard shop only support returning en and zh-hans language data |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ category_list` | object[] |  |
| `↳↳ category_id` | int64 | ID for category. |
| `↳↳ parent_category_id` | int64 | ID for parent category. |
| `↳↳ original_category_name` | string | Default name for category. |
| `↳↳ display_category_name` | string | Display name dependent on display name. |
| `↳↳ has_children` | boolean | Whether this category has active children category. |

Lỗi riêng: Cannot accept your own offer. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Shop_id is not found. · Invalid language. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Product not found

## v2.product.get_attribute_tree
`GET /api/v2/product/get_attribute_tree` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Customized APP, Swam ERP

Get the attribute tree for categories

Lịch sử cập nhật: 2025-01-13: Add new support_search_value field; 2024-04-12: add introduction response parameter; 2023-07-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `category_id_list` | int[] | ✔ | max count is 20 |
| `language` | string |  | Language Support Lanuage: "SG": [ "en", "zh-Hans", "ms" ], "MY": [ "en", "zh-Hans", "ms" ], "PH": [ "en", "zh-Hans" ], "VN": [ "vn", "en" ], "ID": [ "id", "en" ], "TH": [ "th", "en" ], "BR": [ "pt-BR", "en" ], "MX": [ "es-MX", "en" ], "CO": [ "es-CO", "en" ], "CL": [ "es-CL", "en" ], "TW": [ "zh-Hant", "zh-Hans", "en" ], "IN": [ "en", "hi" ] |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Resopnse |
| `↳ list` | object[] | Each result corresponds to one category in category_ids |
| `↳↳ attribute_tree` | object[] | One category's attribute trees |
| `↳↳↳ attribute_id` | int | Attribute ID |
| `↳↳↳ mandatory` | boolean | Is mandatory or not |
| `↳↳↳ name` | string | Attribute Name |
| `↳↳↳ attribute_value_list` | object[] | All available values for this attribute |
| `↳↳↳↳ value_id` | int | Value ID |
| `↳↳↳↳ name` | string | Value name |
| `↳↳↳↳ value_unit` | string | Value unit |
| `↳↳↳↳ child_attribute_list` | object[] | Child attributes for the value of parent attribute The structure content is the same as attribute_tree |
| `↳↳↳↳ multi_lang` | object[] | Translate results for display |
| `↳↳↳↳↳ language` | string | Language |
| `↳↳↳↳↳ value` | string | Translate result |
| `↳↳↳ attribute_info` | object | Attribute extra info |
| `↳↳↳↳ input_type` | int | SINGLE_DROP_DOWN = 1 SINGLE_COMBO_BOX = 2 FREE_TEXT_FILED = 3 MULTI_DROP_DOWN = 4 MULTI_COMBO_BOX = 5 |
| `↳↳↳↳ input_validation_type` | int | VALIDATOR_NO_VALIDATE_TYPE = 0 VALIDATOR_INT_TYPE = 1 VALIDATOR_STRING_TYPE = 2 VALIDATOR_FLOAT_TYPE = 3 VALIDATOR_DATE_TYPE = 4 |
| `↳↳↳↳ format_type` | int | FORMAT_NORMAL = 1 FORMAT_QUANTITATIVE_WITH_UNIT = 2 |
| `↳↳↳↳ date_format_type` | int | YEAR_MONTH_DATE = 0 (DD/MM/YYYY) YEAR_MONTH = 1 (MM/YYYY) |
| `↳↳↳↳ attribute_unit_list` | string[] | Attribute's available units list |
| `↳↳↳↳ max_value_count` | int | Max selected value count |
| `↳↳↳↳ introduction` | string | Introduction for special Attribute |
| `↳↳↳↳ is_oem` | boolean |  |
| `↳↳↳↳ support_search_value` | boolean | Indicates whether this attribute has searchable values. If yes, please call v2.product.search_attribute_value_list to get the default values |
| `↳↳↳ multi_lang` | object[] | Attribute translate info |
| `↳↳↳↳ language` | string | Language |
| `↳↳↳↳ value` | string | Translate result |
| `↳↳ category_id` | int | Category ID |
| `↳↳ warning` | string | Warning msg |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Invalid language. · Invalid category ID {{.error_info}}

## v2.product.get_brand_list
`GET /api/v2/product/get_brand_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Customized APP, Swam ERP

Get the brand data of a leaf category. More detail please check: https://open.shopee.com/developer-guide/209

Rate limit: [0,0,0]

Lịch sử cập nhật: 2021-10-29: update language description; 2021-10-21: update page_size description; 2021-09-29: update language description; 2021-08-27: add language parameters; 2021-05-17: update offset description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `offset` | int64 | ✔ | Specifies the starting entry of data to return in the current call. Default is 0. If data is more than one page,this field needs to be replaced with "next_offset" to request,and the offset can be some entry to start next call. |
| `page_size` | int64 | ✔ | the size of one page.Max=100 |
| `category_id` | int64 | ✔ | ID of category. |
| `status` | int64 | ✔ | Brand status , 1: normal brand, 2: pending brand |
| `language` | string |  | If language is not uploaded, the default language=en, the following are the languages supported by different markets SG: en ; MY: en / ms-my / zh-hans ; TH: en / th ; VN: en / vi ; PH: en ; TW: en / zh-hant ; ID: en / id ; BR: en / pt-br ; MX: en / es-mx ; CO: en/es-CO ; CL: en/es-CL. Note: For markets that have already launched global tree, Crossboard shop only support returning en and zh-hans language data |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ brand_list` | object[] |  |
| `↳↳ original_brand_name` | string | Original name of brand |
| `↳↳ brand_id` | int64 |  |
| `↳↳ display_brand_name` | string | Display name of brand |
| `↳ has_next_page` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of items. |
| `↳ next_offset` | int64 | If has_next_page is true, this value need set to next request.offset |
| `↳ is_mandatory` | boolean | Whether is mandatory. |
| `↳ input_type` | string | Input type: DROP_DOWN |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Shop_id is not found. · Invalid category. · status is required. · Update global item failed, please try later. · Invalid category ID {{.error_info}} · Our system is taking some time to respond, please try later.

## v2.product.get_item_limit
`GET /api/v2/product/get_item_limit` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get item upload control.

Lịch sử cập nhật: 2025-01-08: Add gtin_validation_rule field; 2024-10-25: add size_chart_limit > support_image_size_chart, support_template_size_chart, size_chart_mandatory response parameters; 2024-06-27: add category_id request parameter and weight_limit, dimension_limit, dts_limit response parameters; 2024-05-27: update int format; 2022-02-21: add extended_description_limit

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `category_id` | int64 |  | Shopee's unique identifier for a category. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ price_limit` | object |  |
| `↳↳ min_limit` | float | Item price max limit. |
| `↳↳ max_limit` | float | Item price min limit. |
| `↳ wholesale_price_threshold_percentage` | object |  |
| `↳↳ min_limit` | int64 | Item wholesale price percentage of original price min limit. |
| `↳↳ max_limit` | int64 | Item wholesale price percentage of original price min limit. |
| `↳ stock_limit` | object |  |
| `↳↳ min_limit` | int64 | Item stock min limit. |
| `↳↳ max_limit` | int64 | Item stock max limit. |
| `↳ item_name_length_limit` | object |  |
| `↳↳ min_limit` | int64 | Item name length min limit. |
| `↳↳ max_limit` | int64 | Item name length max limit. |
| `↳ item_image_count_limit` | object |  |
| `↳↳ min_limit` | int64 | Item image count min limit. |
| `↳↳ max_limit` | int64 | Item image count max limit. |
| `↳ item_description_length_limit` | object |  |
| `↳↳ min_limit` | int64 | Item description length min limit. |
| `↳↳ max_limit` | int64 | Item description length max limit. |
| `↳ tier_variation_name_length_limit` | object |  |
| `↳↳ min_limit` | int64 | Item tier variation name length min limit. |
| `↳↳ max_limit` | int64 | Item tier variation name length max limit. |
| `↳ tier_variation_option_length_limit` | object |  |
| `↳↳ min_limit` | int64 | Item tier variation option length min limit. |
| `↳↳ max_limit` | int64 | Item tier variation option length max limit. |
| `↳ item_count_limit` | object |  |
| `↳↳ max_limit` | int64 | Item count max limit. |
| `↳ extended_description_limit` | object |  |
| `↳↳ description_text_length_min` | int | length min limit for item extended description text part |
| `↳↳ description_text_length_max` | int | length max limit for item extended description text part |
| `↳↳ description_image_num_min` | int | length min limit for item extended description image num |
| `↳↳ description_image_num_max` | int | length max limit for item extended description image num |
| `↳↳ description_image_width_min` | int | length min limit for item extended description image width |
| `↳↳ description_image_height_min` | int | length min limit for item extended description image hight |
| `↳↳ description_image_aspect_ratio_min` | float | length min limit for item extended description image aspect (image width / image hight ) |
| `↳↳ description_image_aspect_ratio_max` | float | length max limit for item extended description image aspect (image width / image hight ) |
| `↳ dts_limit` | object |  |
| `↳↳ days_to_ship_limit` | object | Pre order limits for the category |
| `↳↳↳ min_limit` | int |  |
| `↳↳↳ max_limit` | int |  |
| `↳↳ non_pre_order_days_to_ship` | int |  |
| `↳ weight_limit` | object |  |
| `↳↳ weight_mandatory` | boolean | weight is mandatory or not |
| `↳ dimension_limit` | object |  |
| `↳↳ dimension_mandatory` | boolean | dimension is mandatory or not for the category |
| `↳ size_chart_limit` | object |  |
| `↳↳ size_chart_mandatory` | boolean |  |
| `↳↳ support_image_size_chart` | boolean |  |
| `↳↳ support_template_size_chart` | boolean |  |
| `gtin_limit` | object |  |
| `↳ gtin_validation_rule` | string | Indicate gtin_code validation logic in v2.product.add_item v2.product.update_item v2.product.init_tier_variation v2.product.add_model v2.product.update_model - Mandatory : This field is required and must contain a correctly formatted GTiN number. - Flexible : This field is required and must contain either a correctly formatted GTlN number or "00" todeclare that the item/model has no valid GTlN. - Optional : This field is optional and can contain a correctly formatted GTiN number, "00" or be omittedentirely. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Product not found · Update item failed {{.error_info}} · Update item failed {{.error_info}} · System error, please try again later or contact the OpenAPI support team.

## v2.product.get_item_list
`GET /api/v2/product/get_item_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Customer Service, Customized APP, Ads Service, Custom APP, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management

Use this call to get a list of items.

Lịch sử cập nhật: 2024-10-18: Add tag response parameter; 2024-01-19: update the enumeration values of item_status parameter; 2022-03-28: page size update.Max=100; 2021-09-17: update request example; 2021-06-24: update request example

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `offset` | int64 | ✔ | Specifies the starting entry of data to return in the current call. Default is 0. if data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int64 | ✔ | the size of one page.Max=100 |
| `update_time_from` | timestamp |  | The update_time_from and update_time_to fields specify a date range for retrieving orders (based on the item update time). The update_time_from field is the starting date range. |
| `update_time_to` | timestamp |  | The update_time_from and update_time_to fields specify a date range for retrieving orders (based on the item update time). The update_time_to field is the ending date range |
| `item_status` | string[] | ✔ | NORMAL/BANNED/UNLIST/ REVIEWING/SELLER_DELETE/SHOPEE_DELETE If you want to search multiple status, please upload the url like this: item_status=NORMAL&item_status=BANNED |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item` | object[] | list of item info with item_id/ item_status/ update_time |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ item_status` | string | Enumerated type that defines the current status of the item. Applicable values: NORMAL, BANNED, UNLIST, REVIEWING, SELLER_DELETE, SHOPEE_DELETE . |
| `↳↳ update_time` | timestamp | The update time of item. |
| `↳↳ tag` | object |  |
| `↳↳↳ kit` | boolean | Indicate if the item is kit item. |
| `↳ total_count` | int64 | total count of all items |
| `↳ has_next_page` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of items. |
| `↳ next_offset` | int64 | if has_next_page is true, this value need set to next request.offset |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Update_time_to should be later than update_time_from. · Item status error. · Shop_id is not found. · get items offset over limit, please use the next field · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team.

## v2.product.get_item_base_info
`GET /api/v2/product/get_item_base_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Marketing, Customer Service, Brand Membership, Customized APP, Ads Service, Custom APP, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management

Use this api to get basic info of item by item_id list.

Lịch sử cập nhật: 2026-10-30: add new response field "default_model_id"; 2026-04-03: remove promotion_id; 2026-03-13: add new response field "medicine_id"; 2025-11-17: add new response field "purchase_limit_info"; 2025-11-07: add new response field "has_promotion"

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id_list` | int64[] | ✔ | item_id list; limit [0,50] |
| `need_tax_info` | boolean |  | if true will response tax_info |
| `need_complaint_policy` | boolean |  | if true will response complaint_policy |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_list` | object[] |  |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ category_id` | int32 | Shopee's unique identifier for a category. |
| `↳↳ item_name` | string | Name of the item in local language. |
| `↳↳ description` | string | if description_type is normal , Description information will be returned through this field，else description will be empty |
| `↳↳ item_sku` | string | An item SKU (stock keeping unit) is an identifier defined by a seller, sometimes called parent SKU. Item SKU can be assigned to an item in Shopee Listings. |
| `↳↳ create_time` | timestamp | Timestamp that indicates the date and time that the item was created. |
| `↳↳ update_time` | timestamp | Timestamp that indicates the last time that there was a change in value of the item, such as price/stock change. |
| `↳↳ attribute_list` | object[] |  |
| `↳↳↳ attribute_id` | int32 | The Identify of each category. |
| `↳↳↳ original_attribute_name` | string | The name of each attribute. |
| `↳↳↳ is_mandatory` | boolean | This is to indicate whether this attribute is mandantory. |
| `↳↳↳ attribute_value_list` | object[] |  |
| `↳↳↳↳ value_id` | int32 | Unique identifier for value of this item attribute. |
| `↳↳↳↳ original_value_name` | string | Value name of this item attribute. |
| `↳↳↳↳ value_unit` | string | Value unit of this item attribute. |
| `↳↳ price_info` | object[] | If the item has models, price_info will not be returned. Please get the price of each model through the get_model_list api |
| `↳↳↳ currency` | string | The three-digit code representing the currency unit used for the item in Shopee Listings. |
| `↳↳↳ original_price` | float | The original price of the item in the listing currency. |
| `↳↳↳ current_price` | float | The current price of the item in the listing currency. If product under a onging promotion, current_price will be the promotion price |
| `↳↳↳ inflated_price_of_original_price` | float | The After-tax original price of the item in the listing currency. |
| `↳↳↳ inflated_price_of_current_price` | float | The After-tax current price of the item in the listing currency. |
| `↳↳↳ sip_item_price` | float | The price of the item in sip.If item is for CNSC primary shop, this field will not be returned |
| `↳↳↳ sip_item_price_source` | string | source of sip' price. ( auto or manual).If item is for CNSC SIP primary shop, this field will not be returned |
| `↳↳↳ local_price` | float | The original price multiplied by the local adjustment rate equals the local price. The local price is denominated in the local currency and is rounded to two decimal places. |
| `↳↳↳ local_promotion_price` | float | During the promotion period, the CB price is multiplied by the local adjustment rate. Once the promotion starts, the price remains unchanged. During the promotion, the local_promotion_price= current_price, which is denominated in the local currency and retained to two decimal places. |
| `↳↳ image` | object |  |
| `↳↳↳ image_url_list` | string[] | List of image url. |
| `↳↳↳ image_id_list` | string[] | List of image id. |
| `↳↳↳ image_ratio` | string | Image ratio |
| `↳↳ weight` | string | The weight of this item, the unit is KG. If set the weight of models under this item, will return the max weight of all models during the switching period to ensure system compatibility, please switch to call v2.product.get_model_list to get the weight of models. |
| `↳↳ dimension` | object | The dimension of this item. If set the dimension of models under this item, will return the dimension with largest volume calculated by height*length*width during the switching period to ensure system compatibility, please switch to call v2.product.get_model_list to get the dimension of models. |
| `↳↳↳ package_length` | int32 | The length of package for this item, the unit is CM. |
| `↳↳↳ package_width` | int32 | The width of package for this item, the unit is CM. |
| `↳↳↳ package_height` | int32 | The height of package for this item, the unit is CM. |
| `↳↳ logistic_info` | object[] | The logistics list. |
| `↳↳↳ logistic_id` | int32 | The identity of logistic channel. |
| `↳↳↳ logistic_name` | string | The name of logistic. |
| `↳↳↳ enabled` | boolean | Related to shopee.logistics.GetLogistics result.logistics.enabled only affect current item. |
| `↳↳↳ shipping_fee` | float | Only needed when logistics fee_type = CUSTOM_PRICE. |
| `↳↳↳ size_id` | int32 | If specify logistic fee_type is SIZE_SELECTION size_id is required. |
| `↳↳↳ is_free` | boolean | when seller chooses this option, the shipping fee of this channel on item will be set to 0. Default value is False. |
| `↳↳↳ estimated_shipping_fee` | float | Estimated shipping fee calculated by weight. Don't exist if channel is no-integrated. |
| `↳↳ pre_order` | object |  |
| `↳↳↳ is_pre_order` | boolean | Pre-order will be set true. |
| `↳↳↳ days_to_ship` | int32 | The days to ship. Only work for pre-orde. |
| `↳↳ wholesales` | object[] | The wholesales tier list. |
| `↳↳↳ min_count` | int32 | The min count of this tier wholesale. |
| `↳↳↳ max_count` | int32 | The max count of this tier wholesale. |
| `↳↳↳ unit_price` | float | The current price of the wholesale in the listing currency.If item is in promotion, this price is useless. |
| `↳↳↳ inflated_price_of_unit_price` | float | The After-tax Price of the wholesale show to buyer. |
| `↳↳ condition` | string | Is it second-hand. |
| `↳↳ size_chart` | string | Url of size chart image. |
| `↳↳ item_status` | string | Enumerated type that defines the current status of the item. Applicable values: NORMAL, BANNED, UNLIST, SELLER_DELETE, SHOPEE_DELETE, REVIEWING . |
| `↳↳ deboost` | boolean | If deboost is true, means that the item's search ranking is lowered. |
| `↳↳ has_model` | boolean | Does it contain model. |
| `↳↳ default_model_id` | int32 | default model id |
| `↳↳ has_promotion` | boolean | Indicates whether the item is currently under any ongoing promotion. |
| `↳↳ video_info` | object[] | Info of video list. |
| `↳↳↳ video_url` | string | Url of video. |
| `↳↳↳ thumbnail_url` | string | Thumbnail of video. |
| `↳↳↳ duration` | int32 | Duration of video. |
| `↳↳ brand` | object |  |
| `↳↳↳ brand_id` | int32 | Id of brand. |
| `↳↳↳ original_brand_name` | string | Original name of brand. |
| `↳↳ item_dangerous` | int32 | This field is only applicable for local sellers in Indonesia and Malaysia. Use this field to identify whether a product is a dangerous product. 0 for non-dangerous product and 1 for dangerous product. For more information, please visit the market's respective Seller Education Hub. |
| `↳↳ gtin_code` | string | gtin code for br region, will return this code only item has default model Note: gtin_code = "00" means that this item is “Item without GTIN” |
| `↳↳ size_chart_id` | int64 | id of new size chart. |
| `↳↳ medicine_id` | int64 | [Only for ID local sellers] as a unique identifier for each standardized medicine. |
| `↳↳ promotion_image` | object |  |
| `↳↳↳ image_id_list` | string[] | Promotion image |
| `↳↳↳ image_url_list` | string[] | Promiton image urls |
| `↳↳↳ image_ratio` | string | Promotion image ratio |
| `↳↳ compatibility_info` | object |  |
| `↳↳↳ vehicle_info_list` | object[] |  |
| `↳↳↳↳ brand_id` | int64 | ID of the brand. |
| `↳↳↳↳ model_id` | int64 | ID of the model. |
| `↳↳↳↳ year_id` | int64 | ID of the year. |
| `↳↳↳↳ version_id` | int64 | ID of the version. |
| `↳↳ scheduled_publish_time` | timestamp | Scheduled publish time of this item. |
| `↳↳ authorised_brand_id` | int64 | ID of authorised reseller brand. |
| `↳↳ ssp_id` | int64 | Shopee's unique identifier for Shopee Standard Product. |
| `↳↳ is_fulfillment_by_shopee` | boolean | return true if the item only has a default model and it is FBS model |
| `↳↳ tag` | object |  |
| `↳↳↳ kit` | boolean | Indicate if the item is kit item. |
| `↳↳ purchase_limit_info` | object | purchase limit info |
| `↳↳↳ min_purchase_limit` | int32 | minimum purchase count for each order |
| `↳↳↳ max_purchase_limit` | object |  |
| `↳↳↳↳ purchase_limit` | int32 | maximum purchase limit for each order |
| `↳↳ certification_info` | object | For PH product certification input Required for some category and attribute option |
| `↳↳↳ certification_list` | object[] | Array of certification records for the product, each containing type, certificate number, permit ID, and proof documents. |
| `↳↳↳↳ permit_id` | int32 | Permit ID, get from v2.product.get_product_certification_rule |
| `↳↳↳↳ certification_no` | string | Certification No. |
| `↳↳↳↳ expiry_date` | int32 | expiry timestamp |
| `↳↳↳↳ certification_proofs` | object[] | An array of proof documents for the certification; each element represents one proof file. |
| `↳↳↳↳↳ image_id` | string | The unique image ID of the certification proof, returned by the image upload API. |
| `↳↳↳↳↳ ratio` | float | image weight/ image height. |
| `↳↳↳↳↳ file_name` | string | The name of the uploaded certification proof file. |
| `↳↳↳↳↳ image_url` | string | The image url of the proof |
| `↳ complaint_policy` | object | Complaint policy.Only returned for local PL sellers, and need_complaint_policy in request is true. |
| `↳↳ warranty_time` | string | Time for a warranty claim.Value should be in one of ONE_YEAR TWO_YEARS OVER_TWO_YEARS. |
| `↳↳ exclude_entrepreneur_warranty` | boolean | If True means "I exclude warranty complaints for entrepreneur" |
| `↳↳ complaint_address_id` | int64 | The identity of complaint address. |
| `↳↳ additional_information` | string | Additional information for complaint policy |
| `↳ tax_info` | object | Tax information |
| `↳↳ ncm` | string | Mercosur Common Nomenclature, it is a convention between Mercosur member countries to easily recognize goods, services and productive factors negotiated among themselves.(BR region) Note: ncm = "00" means that this item doesn't have a NCM. |
| `↳↳ diff_state_cfop` | string | Tax Code of Operations and Installments for orders that seller and buyer are in different states. It identifies a specific operation by category at the time of issuing the invoice. (BR region) |
| `↳↳ csosn` | string | Code of Operation Status – Simples Nacional, code for company operations to identify the origin of the goods and the taxation regime of the operations. (BR region) |
| `↳↳ origin` | string | Product source, domestic or foreig (BR region) |
| `↳↳ cest` | string | Tax Replacement Specifying Code (CEST), to separate within the same NCM products that do or do not have ICMS tax substitution. (BR region) Note: cest = "00" means that this item doesn't have a CEST. |
| `↳↳ measure_unit` | string | (BR region) |
| `↳↳ invoice_option` | string | Value shuold be one of NO_INVOICES VAT_MARGIN_SCHEME_INVOICES VAT_INVOICES NON_VAT_INVOICES and if value is NON_VAT_INVOICE vat_rate should be null (PL region) |
| `↳↳ vat_rate` | string | Value should be one of 0% 5% 8% 23% NO_VAT_RATE (PL region) |
| `↳↳ hs_code` | string | HS Code (Only for IN region) |
| `↳↳ tax_code` | string | Tax Code (Only for IN region) |
| `↳↳ tax_type` | int32 | tax_type only for TW whitelist shop. Shopee will referred Tax type when substitute sellers for issuing e-receipts to buyers. All variations share the same tax type. The meaning of value: 0: no tax type 1: tax-able 2: tax-free |
| `↳↳ pis` | string | Only for BR shop. PIS - Programa de Integração Social (Social Integration Program). It is a government tax to collect resources for the payment of unemployment insurance and other employee related rights. PIS % - the tax applied to this product |
| `↳↳ cofins` | string | Only for BR shop. COFINS – Contribuição para Financiamento da Seguridade Social (Contribution for Social Security Funding). It is a government tax to collect resources for public health system and social security. COFINS % - the tax applied to this product |
| `↳↳ icms_cst` | string | Only for BR shop. ICMS - Imposto sobre Circulação de Mercadorias e Serviços (Circulation of Goods and Services Tax). CST - Código da Situação Tributária (Tax Situation Code) is represented by a combination of 3 numbers with the purpose of demonstrating the origin of a product and determining the form of taxation that will apply to it. Therefore, each digit in the CST Table has a specific meaning: the first digit indicates the origin of the operation, the second digit represents the ICMS taxation on the operation and the third digit provides additional information about the form of taxation. |
| `↳↳ pis_cofins_cst` | string | Only for BR shop. The CST PIS/Cofins is a code on the Electronic Invoice (NF-e) that identifies the tax situation of PIS (Programa de Integração Social) and Cofins (Contribuição para o Financiamento da Seguridade Social) in sales of goods. |
| `↳↳ federal_state_taxes` | string | Only for BR shop. Enter the total percentage of the combination of federal, state, and municipal taxes, using up to two decimals. |
| `↳↳ operation_type` | string | Only for BR shop. 1: Retailer 2: Manufacturer |
| `↳↳ ex_tipi` | string | Only for BR shop. The EXTIPI field in the NF-e (Nota Fiscal Eletrônica) is used to indicate if there's an exception to the IPI (Imposto sobre Produtos Industrializados) tax rate for a specific product. |
| `↳↳ fci_num` | string | Only for BR shop. The FCI Control Number is a unique identifier assigned to each import FCI (Import Content Form). It's mandatory on the corresponding NF-e (electronic invoice) to ensure compliance with Brazilian import tax regulations. |
| `↳↳ recopi_num` | string | Only for BR shop. RECOPI NACIONAL is a Brazilian government system that facilitates the registration and management of tax-exempt operations involving paper destined for printing books, newspapers, and periodicals (known as "papel imune" in Portuguese). |
| `↳↳ additional_info` | string | Only for BR shop. Include relevant information to display on Invoice. |
| `↳↳ group_item_info` | object | Only for BR shop. Required if the item is a group item. |
| `↳↳↳ group_qtd` | string | Example: The package contains 6 soda cans. Whether you are selling a pack of 6 cans (fardo) or a single can (unit), enter 6. |
| `↳↳↳ group_unit` | string | Example: The package contains 6 soda cans. Whether you are selling a pack of 6 cans (fardo) or a single can (unit), enter UNI for the individual can. |
| `↳↳↳ group_unit_value` | string | Example: The package contains 6 soda cans. Whether you are selling a pack of 6 cans (fardo) or a single can (unity), enter the value of the individual can. |
| `↳↳↳ original_group_price` | string | Example: The item is a package that contains 6 soda cans. Enter the price of the whole package. |
| `↳↳↳ group_gtin_sscc` | string | Example: The item is a package that contains 6 soda cans. Please inform the GTIN SSCC code for the package. |
| `↳↳↳ group_grai_gtin_sscc` | string | Example: The item is box, that contain 6 packages. Each package contains 6 soda cans. Please inform the GRAI GTIN SSCC code for the Box. |
| `↳↳ export_cfop` | string | 7101 - for sales of self-produced goods 7102 - resale of third-party goods a tax code used in Brazil to classify and identify the nature of goods or services transactions for tax purposes. This is used for goods export to other counties |
| `↳ description_info` | object | New description field. Only whitelist sellers can use it. |
| `↳↳ extended_description` | object | If description_type is extended , Description information will be returned through this field. |
| `↳↳↳ field_list` | object[] | Field of extended description |
| `↳↳↳↳ field_type` | string | Type of extended description field ：values: See Data Definition- description_field_type (text , image). |
| `↳↳↳↳ text` | string | If field_type is text, text information will be returned through this field. |
| `↳↳↳↳ image_info` | object | If field_type is image, image url will be returned through this field. |
| `↳↳↳↳↳ image_id` | string | Image id |
| `↳↳↳↳↳ image_url` | string | Image url. |
| `↳ description_type` | string | Type of description : values: See Data Definition- description_type (normal , extended). |
| `↳ stock_info_v2` | object | new stock object |
| `↳↳ summary_info` | object | stock summary info |
| `↳↳↳ total_reserved_stock` | int32 | Stock reserved for promotion. Note: For SIP P Item, will return the total reserved stock for P Item and all A Items under the P Item; |
| `↳↳↳ total_available_stock` | int32 | total available stock |
| `↳↳ seller_stock` | object[] | seller stock |
| `↳↳↳ location_id` | string | location id |
| `↳↳↳ stock` | int32 | stock in the current warehouse |
| `↳↳↳ if_saleable` | boolean | To return if the stock of the location id is saleable |
| `↳↳ shopee_stock` | object[] | shopee stock |
| `↳↳↳ location_id` | string | location id |
| `↳↳↳ stock` | int32 | stock in the current warehouse |
| `↳↳ advance_stock` | object | Only for PH/VN/ID/MY local selected shops. |
| `↳↳↳ sellable_advance_stock` | int32 | Refers to Advance Fulfillment stock that Seller has shipped out and is available to be used to fulfill an order. |
| `↳↳↳ in_transit_advance_stock` | int32 | Refers to Advance Fulfillment stock that seller has shipped out and is still in transit and unavailable to be used to fulfill an order. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Item_id is not found. · Shop_id is not found. · Invalid language. · Get shop failed. please try later. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team.

## v2.product.get_item_extra_info
`GET /api/v2/product/get_item_extra_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Customer Service, Customized APP, Ads Service, Custom APP, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management

Use this api to get extra info of item by item_id list.

Lịch sử cập nhật: 2022-06-17: add code demo

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id_list` | int64[] | ✔ | item_id list, limit [0,50] |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_list` | object[] | extra info of item list. |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ sale` | int32 | The sales volume of item. |
| `↳↳ views` | int32 | The page view of item. |
| `↳↳ likes` | int32 | The collection number of item. |
| `↳↳ rating_star` | float | The rating star scores of this item. |
| `↳↳ comment_count` | int32 | Count of comments for the item. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Item_id is not found. · Shop_id is not found. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Product not found · Update item failed {{.error_info}}

## v2.product.add_item
`POST /api/v2/product/add_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Add a new item.

Lịch sử cập nhật: 2026-09-01: Condition is required for BR; 2026-06-24: 2026-06-17; 2026-03-13: Introduce "medicine_id" as the request parameter; 2025-09-19: The request field certification_type has been removed. If this field is still passed in the request, it will be ignored by the system.; 2025-04-28: Add permit_id

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `original_price` | float | ✔ | Item price |
| `description` | string | ✔ | if description_type is normal , Description information should be set by this field. |
| `weight` | float | ✔ | The weight of this item, the unit is KG. |
| `item_name` | string | ✔ | Item name |
| `item_status` | string |  | Item status, could be UNLIST or NORMAL |
| `dimension` | object |  | The dimension of this item. |
| `↳ package_height` | int32 | ✔ | The height of package for this item, the unit is CM. |
| `↳ package_length` | int32 | ✔ | The length of package for this item, the unit is CM. |
| `↳ package_width` | int32 | ✔ | The width of package for this item, the unit is CM. |
| `logistic_info` | object[] | ✔ | Logistic channel setting |
| `↳ size_id` | int32 |  | Size ID, If specify logistic fee_type is SIZE_SELECTION size_id is required. |
| `↳ shipping_fee` | float |  | Shipping fee, Only needed when logistics fee_type = CUSTOM_PRICE. |
| `↳ enabled` | boolean | ✔ | Whether channel is enabled for this item |
| `↳ logistic_id` | int32 | ✔ | ID of the channel |
| `↳ is_free` | boolean |  | Whether cover shipping fee for buyer |
| `attribute_list` | object[] |  | This field is optional(expect Indonesia) depending on the specific attribute under different categories. Should call shopee.item.GetAttributes to get attribute first. Must contain all all mandatory attribute. |
| `↳ attribute_id` | int32 | ✔ | ID of attribute |
| `↳ attribute_value_list` | object[] |  |  |
| `↳↳ value_id` | int32 | ✔ | Value ID. In the following cases, the value id needs to be uploaded as 0, and original_value_name is mandatory, needs to be filled in customized value. (1) AttributeInputType is TEXT_FILED; (2) AttributeInputType is COMBO_BOX or MULTIPLE_SELECT_COMBO_BOX, and the seller want to fill in a customized value. |
| `↳↳ original_value_name` | string |  | Value name. original_value_name from product.get_attributes api. If value id=0, this field is required. If AttributeType is DATE_TYPE or TIMESTAMP_TYPE, you can upload timestamp(string type) as the original_value_name. |
| `↳↳ value_unit` | string |  | Unit of attribute value (quantitative attribute only). |
| `category_id` | int32 | ✔ | ID of category |
| `image` | object | ✔ | Item images |
| `↳ image_id_list` | string[] | ✔ | ID of image |
| `↳ image_ratio` | string |  | Ratio of image, OptionalAllowed ratios : "1:1" (default) "3:4" only applicable to whitelisted seller. |
| `pre_order` | object |  | Pre order setting |
| `↳ is_pre_order` | boolean | ✔ | Whether item is pre order |
| `↳ days_to_ship` | int32 |  | The guaranteed days to ship orders. Please get the days_to_ship range from get_dts_limit api |
| `item_sku` | string |  | SKU tag of item |
| `condition` | string |  | Condition of item, USED、Used and used will be mapped to Used; NEW、New and new will be mapped to New. Required for BR. |
| `wholesale` | object[] |  | Wholesale setting |
| `↳ min_count` | int32 | ✔ | Minimum count of this tier |
| `↳ max_count` | int32 | ✔ | Maximum count of this tier |
| `↳ unit_price` | float | ✔ | Unit price of this tier |
| `video_upload_id` | string[] |  | Video upload ID returned from video uploading API. Only accept one video_upload_id. |
| `brand` | object |  |  |
| `↳ brand_id` | int32 | ✔ | Id of brand. |
| `↳ original_brand_name` | string | ✔ | Original name of brand( No Brand if not brand). |
| `item_dangerous` | int32 |  | This field is only applicable for local sellers in Indonesia and Malaysia. Use this field to identify whether a product is a dangerous product. 0 for non-dangerous product and 1 for dangerous product. For more information, please visit the market's respective Seller Education Hub. |
| `tax_info` | object |  | Tax information |
| `↳ ncm` | string |  | Mercosur Common Nomenclature, it is a convention between Mercosur member countries to easily recognize goods, services and productive factors negotiated among themselves. (BR region) NCM must have 8 digits, OR, if your item doesn't have a NCM enter the value "00" |
| `↳ same_state_cfop` | string |  | Tax Code of Operations and Installments for orders that seller and buyer are in the same state. It identifies a specific operation by category at the time of issuing the invoice.(BR region) |
| `↳ diff_state_cfop` | string |  | Tax Code of Operations and Installments for orders that seller and buyer are in different states. It identifies a specific operation by category at the time of issuing the invoice.(BR region) |
| `↳ csosn` | string |  | Code of Operation Status – Simples Nacional, code for company operations to identify the origin of the goods and the taxation regime of the operations.(BR region) |
| `↳ origin` | string |  | Product source, domestic or foreig (BR region). \|0 - National, except for those indicated in codes 3, 4, 5, and 8\| \|1 - Foreign: Direct import, except for that indicated in code 6\| \|2 - Foreign: Acquired in the domestic market, except for that indicated in code 7\| \|3 - National: Goods or products with Import Content greater than 40% and less than or equal to 70%\| \|4 - National: Produced in compliance with the basic production processes outlined in the legislations cited in the Agreements\| \|5 - National: Goods or products with Import Content less than or equal to 40%\| \|6 - Foreign: Direct import, without a national equivalent, listed by CAMEX and natural gas\| \|7 - Foreign: Acqu |
| `↳ cest` | string |  | Tax Replacement Specifying Code (CEST), to separate within the same NCM products that do or do not have ICMS tax substitution. (BR region) CEST must have 7 digits, OR, if your item doesn't have a CEST enter the value "00". |
| `↳ measure_unit` | string |  | (BR region) The value must be provided in uppercase and must match one of the supported units below: AMPOLA, BALDE, BANDEJ, BARRA, BISNAG, BLOCO, BOBINA, BOMB, CAPS, CART, CENTO, CJ, CM, CM2, CX, CX2, CX3, CX5, CX10, CX15, CX20, CX25, CX50, CX100, DISP, DUZIA, EMBAL, FARDO, FOLHA, FRASCO, GALAO, GF, GRAMAS, JOGO, KG, KIT, LATA, LITRO, M, M2, M3, MILHEI, ML, MWH, PACOTE, PALETE, PARES, PC, POTE, K, RESMA, ROLO, SACO, SACOLA, TAMBOR, TANQUE, TON, TUBO, UN, VASIL, VIDRO. |
| `↳ tax_type` | int32 |  | tax_type only for TW whitelist shop. Shopee will referred Tax type when substitute sellers for issuing e-receipts to buyers. All variations share the same tax type. The meaning of value: 0: no tax type 1: tax-able 2: tax-free |
| `↳ pis` | string |  | Only for BR shop. PIS - Programa de Integração Social (Social Integration Program). It is a government tax to collect resources for the payment of unemployment insurance and other employee related rights. PIS % - the tax applied to this product |
| `↳ cofins` | string |  | Only for BR shop. COFINS – Contribuição para Financiamento da Seguridade Social (Contribution for Social Security Funding). It is a government tax to collect resources for public health system and social security. COFINS % - the tax applied to this product |
| `↳ icms_cst` | string |  | Only for BR shop. ICMS - Imposto sobre Circulação de Mercadorias e Serviços (Circulation of Goods and Services Tax). CST - Código da Situação Tributária (Tax Situation Code) is represented by a combination of 3 numbers with the purpose of demonstrating the origin of a product and determining the form of taxation that will apply to it. Therefore, each digit in the CST Table has a specific meaning: the first digit indicates the origin of the operation, the second digit represents the ICMS taxation on the operation and the third digit provides additional information about the form of taxation. |
| `↳ pis_cofins_cst` | string |  | Only for BR shop. The CST PIS/Cofins is a code on the Electronic Invoice (NF-e) that identifies the tax situation of PIS (Programa de Integração Social) and Cofins (Contribuição para o Financiamento da Seguridade Social) in sales of goods. |
| `↳ federal_state_taxes` | string |  | Only for BR shop. Enter the total percentage of the combination of federal, state, and municipal taxes, using up to two decimals. |
| `↳ operation_type` | string |  | Only for BR shop. 1: Retailer 2: Manufacturer |
| `↳ ex_tipi` | string |  | Only for BR shop. The EXTIPI field in the NF-e (Nota Fiscal Eletrônica) is used to indicate if there's an exception to the IPI (Imposto sobre Produtos Industrializados) tax rate for a specific product. |
| `↳ fci_num` | string |  | Only for BR shop. The FCI Control Number is a unique identifier assigned to each import FCI (Import Content Form). It's mandatory on the corresponding NF-e (electronic invoice) to ensure compliance with Brazilian import tax regulations. |
| `↳ recopi_num` | string |  | Only for BR shop. RECOPI NACIONAL is a Brazilian government system that facilitates the registration and management of tax-exempt operations involving paper destined for printing books, newspapers, and periodicals (known as "papel imune" in Portuguese). |
| `↳ additional_info` | string |  | Only for BR shop. Include relevant information to display on Invoice. |
| `↳ group_item_info` | object |  | Only for BR shop. Required if the item is a group item. |
| `↳↳ group_qtd` | string |  | Example: The package contains 6 soda cans. Whether you are selling a pack of 6 cans (fardo) or a single can (unit), enter 6. |
| `↳↳ group_unit` | string |  | Example: The package contains 6 soda cans. Whether you are selling a pack of 6 cans (fardo) or a single can (unit), enter UNI for the individual can. |
| `↳↳ group_unit_value` | string |  | Example: The package contains 6 soda cans. Whether you are selling a pack of 6 cans (fardo) or a single can (unity), enter the value of the individual can. |
| `↳↳ original_group_price` | string |  | Example: The item is a package that contains 6 soda cans. Enter the price of the whole package. |
| `↳↳ group_gtin_sscc` | string |  | Example: The item is a package that contains 6 soda cans. Please inform the GTIN SSCC code for the package. |
| `↳↳ group_grai_gtin_sscc` | string |  | Example: The item is box, that contain 6 packages. Each package contains 6 soda cans. Please inform the GRAI GTIN SSCC code for the Box. |
| `↳ export_cfop` | string |  | [BR region] 7101 - for sales of self-produced goods 7102 - resale of third-party goods |
| `complaint_policy` | object |  | Complaint Policy for item. Only required for local PL sellers, ignored otherwise. |
| `↳ warranty_time` | string |  | Value should be in one of ONE_YEAR TWO_YEARS OVER_TWO_YEARS. |
| `↳ exclude_entrepreneur_warranty` | boolean |  | Whether to exclude warranty complaints for entrepreneurs.If True means "I exclude warranty complaints for entrepreneur" |
| `↳ complaint_address_id` | int64 |  | Address for complaint. Fetch available addresses using v2.logistics.get_address_list, and use address_id returned from it. |
| `↳ additional_information` | string |  | Additional information for warranty claim. Should be less than 1000 characters. |
| `description_info` | object |  | New description field. Only whitelist sellers can use it. If you use the field, please upload the description_type=extended otherwise api will return error. If you don't use this field, you don't need to upload the description_type or upload description_type=normal |
| `↳ extended_description` | object |  | If description_type is extended , Description information should be set by this field. |
| `↳↳ field_list` | object[] |  | Field of extended description. |
| `↳↳↳ field_type` | string |  | Type of extended description field ：values: See Data Definition- description_field_type (text , image). |
| `↳↳↳ text` | string |  | If field_type is text， text information will be set by this field. |
| `↳↳↳ image_info` | object |  | If field_type is image，image url will be set by this field. |
| `↳↳↳↳ image_id` | string |  | Image id. |
| `description_type` | string |  | Values: See Data Definition- description_type (normal , extended). If you want to use extended_description, this field must be inputed |
| `seller_stock` | object[] |  | seller stock（Please notice that stock(including Seller Stock and Shopee Stock) should be larger than or equal to real-time reserved stock） |
| `↳ location_id` | string |  | location id |
| `↳ stock` | int32 | ✔ | stock |
| `gtin_code` | string |  | - GTIN is an identifier for trade items, developed by the international organization GS1. - They have 8 to 14 digits. The most common are UPC, EAN, JAN and ISBN. - GTIN will help boost positioning in online marketing channels like Google and Facebook. - That incorporation with GTIN will also aid in Search and Recommendation in Shopee itself allowing buyers to have higher likelihood of finding one's listing. Note: If you want to set “Item without GTIN”, please pass the gtin_code as "00". The validation rule is based on the value return in gtin_validation_rule" field in v2.product.get_item_limit API - Mandatory : This field is required and must contain a correctly formatted GTiN number. - Flex |
| `ds_cat_rcmd_id` | string |  | category recommendation service id |
| `promotion_images` | object |  | Promotion Image Currently only allow one promoton image You could set promotion image only if the product images' ratio is 3:4 |
| `↳ image_id_list` | string[] |  | Promotion Image |
| `compatibility_info` | object |  |  |
| `↳ vehicle_info_list` | object[] | ✔ |  |
| `↳↳ brand_id` | int64 | ✔ | ID of the brand. |
| `↳↳ model_id` | int64 | ✔ | ID of the model. |
| `↳↳ year_id` | int64 |  | ID of the year. |
| `↳↳ version_id` | int64 |  | ID of the version. |
| `scheduled_publish_time` | timestamp |  | Scheduled publish time of this item: 1) Can only set scheduled_publish_time for item with UNLIST status 2) Can only set the time from current time +1hour to current time +90days, and the time is only allowed to be accurate to the minute |
| `authorised_brand_id` | int64 |  | ID of authorised reseller brand. |
| `size_chart_info` | object |  |  |
| `↳ size_chart` | string |  | ID of size chart image. If you want to remove the image size chart of the item, please pass the "size_chart" empty. You only need to fill out either the image or template. If both are filled, only the template will be kept. Notes: Both CB shops and local shops are supported to set "size_chart". |
| `↳ size_chart_id` | int64 |  | ID of template size chart. If you want to remove the template size chart of the item, please pass the "size_chart_id" as 0. You only need to fill out either the image or template. If both are filled, only the template will be kept. Notes: Only local shops are supported to set "size_chart_id", for CB shops please use "size_chart". |
| `certification_info` | object |  | For PH product certification input Required for some category and attribute option |
| `↳ certification_list` | object[] |  | Array of certification records for the product, each containing type, certificate number, permit ID, and proof documents. |
| `↳↳ certification_no` | string | ✔ | Certification No. |
| `↳↳ permit_id` | int64 | ✔ | Permit ID, get from v2.product.get_product_certification_rule |
| `↳↳ expiry_date` | int32 |  | Expiry timestamp. Required for PH, but not needed for TW. |
| `↳↳ certification_proofs` | object[] | ✔ | An array of proof documents for the certification; each element represents one proof file.<path></path> |
| `↳↳↳ file_name` | string | ✔ | The name of the uploaded certification proof file. |
| `↳↳↳ image_id` | int32 | ✔ | The unique image ID of the certification proof, returned by the image upload API. |
| `↳↳↳ ratio` | float | ✔ | image weight/ image height Will be optional in the future; can input 0.75 by default |
| `purchase_limit_info` | object |  | purchase limit info |
| `↳ min_purchase_limit` | int32 |  | minimum purchase count for each order |
| `↳ max_purchase_limit` | object |  |  |
| `↳↳ purchase_limit` | int32 |  | maximum purchase limit for each order. |
| `medicine_id` | int64 |  | [Only for ID local sellers] as a unique identifier for each standardized medicine, the medicine id can only be obtained offline |
| `ssp_id` | int64 |  | The ID of the Standardized Shop Product (SSP) to associate with the default model of the new item. The value must be greater than 0 when provided. If ssp_id is provided, cssp_id must also be provided. |
| `cssp_id` | int64 |  | The ID of the country-specific Standardized Shop Product (CSSP) to associate with the default model of the new item. The value must be greater than 0 when provided. This field is required when ssp_id is provided. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ description` | string | Description of item |
| `↳ weight` | float | The weight of this item, the unit is KG. |
| `↳ pre_order` | object | Pre order setting |
| `↳↳ days_to_ship` | int32 | The guaranteed days to ship orders. |
| `↳↳ is_pre_order` | boolean | Whether this item is pre order |
| `↳ item_name` | string | Item name |
| `↳ images` | object | Item images |
| `↳↳ image_id_list` | string[] | ID of image |
| `↳↳ image_url_list` | string[] | Display URL of image |
| `↳ item_status` | string | Item status |
| `↳ price_info` | object | Item price info |
| `↳↳ current_price` | float | Current price of item |
| `↳↳ original_price` | float | Original price of item |
| `↳ logistic_info` | object[] | Logistic setting |
| `↳↳ size_id` | int32 | Size ID |
| `↳↳ shipping_fee` | float | Shipping fee |
| `↳↳ enabled` | boolean | Whether this channel is enabled for this item |
| `↳↳ logistic_id` | int32 | Logistic channel ID |
| `↳↳ is_free` | boolean | Whether cover shipping fee for buyer |
| `↳ item_id` | int64 | Item ID |
| `↳ attribute` | object[] | Item attributes |
| `↳↳ attribute_id` | int32 | Attribute ID |
| `↳↳ attribute_value_list` | object[] |  |
| `↳↳↳ original_value_name` | string | Value name |
| `↳↳↳ value_id` | int32 | Value ID |
| `↳↳↳ value_unit` | string | Unit of attribute value |
| `↳ category_id` | int32 | Category ID |
| `↳ dimension` | object | The dimension of this item. |
| `↳↳ package_width` | int32 | The width of package for this item, the unit is CM. |
| `↳↳ package_length` | int32 | The length of package for this item, the unit is CM. |
| `↳↳ package_height` | int32 | The height of package for this item, the unit is CM. |
| `↳ condition` | string | Item condition, could be NEW or USED |
| `↳ video_info` | object[] | Item video |
| `↳↳ video_url` | string | Video playback url |
| `↳↳ thumbnail_url` | string | Video preview image url |
| `↳↳ duration` | int32 | Video duration |
| `↳ wholesale` | object[] | Wholesale setting |
| `↳↳ min_count` | int32 | Minimum count of this tier |
| `↳↳ max_count` | int32 | Maximum count of this tier |
| `↳↳ unit_price` | float | Unit price of this tier |
| `↳ brand` | object |  |
| `↳↳ brand_id` | int32 | Id of brand. |
| `↳↳ original_brand_name` | string | Original name of brand. |
| `↳ item_dangerous` | int32 | This field is only applicable for local sellers in Indonesia and Malaysia. Use this field to identify whether a product is a dangerous product. 0 for non-dangerous product and 1 for dangerous product. For more information, please visit the market's respective Seller Education Hub. |
| `↳ description_info` | object | New description field. Only whitelist sellers can use it. If item with extended_description this field will return, otherwise do not return. |
| `↳↳ extended_description` | object | If description_type is extended , description information should be set by this field. |
| `↳↳↳ field_list` | object[] | Field of extended description. |
| `↳↳↳↳ field_type` | string | Type of extended description field ：values: See Data Definition- description_field_type (text , image). |
| `↳↳↳↳ text` | string | If field_type is text, text information will be set by this field. |
| `↳↳↳↳ image_info` | object | If field_type is image, image url will be set by this field. |
| `↳↳↳↳↳ image_id` | string | Image id. |
| `↳ description_type` | string | Values: See Data Definition- description_type (normal , extended). |
| `↳ complaint_policy` | object | Complaint Policy for item. Only returned for local PL sellers. |
| `↳↳ warranty_time` | string | Time for a warranty claim. Could be ONE_YEAR, TWO_YEARS, OVER_TWO_YEARS. |
| `↳↳ exclude_entrepreneur_warranty` | boolean | If True means "I exclude warranty complaints for entrepreneur" |
| `↳↳ complaint_address_id` | int64 | The identity of complaint address. |
| `↳↳ additional_information` | string | Additional information for complaint policy. |
| `↳ seller_stock` | object[] | seller stock |
| `↳↳ location_id` | string | location id |
| `↳↳ stock` | int32 | stock |

Lỗi riêng: The GTIN code is mandatory, please check and upload again. · Please input the correct TS Mark (TD Mark) to upload your product, and refer to the SEH article - https://seller.shopee.tw/edu/article/19732 if you have any questions. · Medicine ID is mandatory for products in Prescription/OTC category. · Please input the correct medicine ID. · For OTC medicine, maximum purchase limit per order is mandatory and cannot exceed 3 days of use. · Upload failed, please upload a more standard size chart image. · Please input the tax information becasue the shop is invoice issued by Shopee · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

## v2.product.update_item
`POST /api/v2/product/update_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Update item.

Lịch sử cập nhật: 2026-06-24: deprecate logistics-related fields in the response; 2026-06-24: 2026-06-17; 2026-03-13: Introduce "medicine_id" as the request parameter; 2025-11-17: add new request field "has_promotion"; 2025-09-19: The request field "certification_type" has been removed. If this field is still passed in the request, it will be ignored by the system.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `description` | string |  | Description of item. |
| `weight` | float |  | The weight of this item, the unit is KG. Updating the weight of this item will overwrite the weight of all models under this item. |
| `pre_order` | object |  | Pre Order setting. |
| `↳ days_to_ship` | int32 | ✔ | Days to ship. |
| `↳ is_pre_order` | boolean | ✔ | Whether the item is pre order. |
| `item_name` | string |  | Item name. |
| `attribute_list` | object[] |  | Item attributes. |
| `↳ attribute_id` | int32 | ✔ | ID of attribute. |
| `↳ attribute_value_list` | object[] |  |  |
| `↳↳ value_id` | int32 | ✔ | ID of attribute value. In the following cases, the value id needs to be uploaded as 0, and original_value_name is mandatory, needs to be filled in customized value. (1) AttributeInputType is TEXT_FILED; (2) AttributeInputType is COMBO_BOX or MULTIPLE_SELECT_COMBO_BOX, and the seller want to fill in a customized value. |
| `↳↳ original_value_name` | string |  | Value name. original_value_name from produc.get_attributes api. If value id=0, this field is required. If AttributeType is DATE_TYPE or TIMESTAMP_TYPE, you can upload timestamp(string type) as the original_value_name. |
| `↳↳ value_unit` | string |  | Unit of attribute value (quantitative attribute only). |
| `image` | object |  | Images of item. |
| `↳ image_id_list` | object[] | ✔ | Image ID. |
| `↳ image_ratio` | string |  | Ratio of image, OptionalAllowed ratios : "1:1" (default) "3:4" |
| `item_sku` | string |  | SKU tag for item. |
| `item_status` | string |  | Item status, could be UNLIST or NORMAL. |
| `wholesale` | object[] |  | Wholesale setting. If you want to delete it, please pass it with blank. |
| `↳ min_count` | int32 | ✔ | Minimum count of this tier. |
| `↳ unit_price` | float | ✔ | Price of this tier. |
| `↳ max_count` | int32 | ✔ | Maximum count of this tier. |
| `item_id` | int64 | ✔ | ID of item. |
| `category_id` | int32 |  | ID of category. |
| `dimension` | object |  | The dimension of this item. Updating the dimension of this item will overwrite the dimension of all models under this item. |
| `↳ package_height` | int32 | ✔ | The height of package for this item, the unit is CM. |
| `↳ package_length` | int32 | ✔ | The length of package for this item, the unit is CM. |
| `↳ package_width` | int32 | ✔ | The width of package for this item, the unit is CM. |
| `condition` | string |  | Condition of item, could be NEW or USED. |
| `video_upload_id` | string[] |  | Video upload ID returned from video uploading API. If you want to delete it, please pass it with blank. |
| `brand` | object |  |  |
| `↳ brand_id` | int32 |  | Id of brand. |
| `↳ original_brand_name` | string |  | Original name of brand. |
| `item_dangerous` | int32 |  | This field is only applicable for local sellers in Indonesia and Malaysia. Use this field to identify whether a product is a dangerous product. 0 for non-dangerous product and 1 for dangerous product. For more information, please visit the market's respective Seller Education Hub. |
| `tax_info` | object |  | Tax information |
| `↳ ncm` | string |  | Mercosur Common Nomenclature, it is a convention between Mercosur member countries to easily recognize goods, services and productive factors negotiated among themselves. (BR region) NCM must have 8 digits, OR, if your item doesn't have a NCM enter the value "00" |
| `↳ same_state_cfop` | string |  | Tax Code of Operations and Installments for orders that seller and buyer are in the same state. It identifies a specific operation by category at the time of issuing the invoice. |
| `↳ diff_state_cfop` | string |  | Tax Code of Operations and Installments for orders that seller and buyer are in different states. It identifies a specific operation by category at the time of issuing the invoice. |
| `↳ csosn` | string |  | Code of Operation Status – Simples Nacional, code for company operations to identify the origin of the goods and the taxation regime of the operations. |
| `↳ origin` | string |  | Product source, domestic or foreig |
| `↳ cest` | string |  | Tax Replacement Specifying Code (CEST), to separate within the same NCM products that do or do not have ICMS tax substitution. (BR region) CEST must have 7 digits, OR, if your item doesn't have a CEST enter the value "00". |
| `↳ measure_unit` | string |  | (BR region) The value must be provided in uppercase and must match one of the supported units below: AMPOLA, BALDE, BANDEJ, BARRA, BISNAG, BLOCO, BOBINA, BOMB, CAPS, CART, CENTO, CJ, CM, CM2, CX, CX2, CX3, CX5, CX10, CX15, CX20, CX25, CX50, CX100, DISP, DUZIA, EMBAL, FARDO, FOLHA, FRASCO, GALAO, GF, GRAMAS, JOGO, KG, KIT, LATA, LITRO, M, M2, M3, MILHEI, ML, MWH, PACOTE, PALETE, PARES, PC, POTE, K, RESMA, ROLO, SACO, SACOLA, TAMBOR, TANQUE, TON, TUBO, UN, VASIL, VIDRO. |
| `↳ invoice_option` | string |  | Value shuold be one of NO_INVOICES VAT_MARGIN_SCHEME_INVOICES VAT_INVOICES NON_VAT_INVOICES and if value is NON_VAT_INVOICE vat_rate should be null (PL region) |
| `↳ vat_rate` | string |  | Value should be one of 0% 5% 8% 23% NO_VAT_RATE (PL region) |
| `↳ hs_code` | string |  | HS Code. (Only for IN region) |
| `↳ tax_code` | string |  | Tax Code. (Only for IN region) |
| `↳ tax_type` | int32 |  | tax_type only for TW whitelist shop. Shopee will referred Tax type when substitute sellers for issuing e-receipts to buyers. All variations share the same tax type. The meaning of value: 0: no tax type 1: tax-able 2: tax-free |
| `↳ pis` | string |  | Only for BR shop. PIS - Programa de Integração Social (Social Integration Program). It is a government tax to collect resources for the payment of unemployment insurance and other employee related rights. PIS % - the tax applied to this product |
| `↳ cofins` | string |  | Only for BR shop. COFINS – Contribuição para Financiamento da Seguridade Social (Contribution for Social Security Funding). It is a government tax to collect resources for public health system and social security. COFINS % - the tax applied to this product |
| `↳ icms_cst` | string |  | Only for BR shop. ICMS - Imposto sobre Circulação de Mercadorias e Serviços (Circulation of Goods and Services Tax). CST - Código da Situação Tributária (Tax Situation Code) is represented by a combination of 3 numbers with the purpose of demonstrating the origin of a product and determining the form of taxation that will apply to it. Therefore, each digit in the CST Table has a specific meaning: the first digit indicates the origin of the operation, the second digit represents the ICMS taxation on the operation and the third digit provides additional information about the form of taxation. |
| `↳ pis_cofins_cst` | string |  | Only for BR shop. The CST PIS/Cofins is a code on the Electronic Invoice (NF-e) that identifies the tax situation of PIS (Programa de Integração Social) and Cofins (Contribuição para o Financiamento da Seguridade Social) in sales of goods. |
| `↳ federal_state_taxes` | string |  | Only for BR shop. Enter the total percentage of the combination of federal, state, and municipal taxes, using up to two decimals. |
| `↳ operation_type` | string |  | Only for BR shop. 1: Retailer 2: Manufacturer |
| `↳ ex_tipi` | string |  | Only for BR shop. The EXTIPI field in the NF-e (Nota Fiscal Eletrônica) is used to indicate if there's an exception to the IPI (Imposto sobre Produtos Industrializados) tax rate for a specific product. |
| `↳ fci_num` | string |  | Only for BR shop. The FCI Control Number is a unique identifier assigned to each import FCI (Import Content Form). It's mandatory on the corresponding NF-e (electronic invoice) to ensure compliance with Brazilian import tax regulations. |
| `↳ recopi_num` | string |  | Only for BR shop. RECOPI NACIONAL is a Brazilian government system that facilitates the registration and management of tax-exempt operations involving paper destined for printing books, newspapers, and periodicals (known as "papel imune" in Portuguese). |
| `↳ additional_info` | string |  | Only for BR shop. Include relevant information to display on Invoice. |
| `↳ group_item_info` | object |  | Only for BR shop. Required if the item is a group item. |
| `↳↳ group_qtd` | string |  | Example: The package contains 6 soda cans. Whether you are selling a pack of 6 cans (fardo) or a single can (unit), enter 6. |
| `↳↳ group_unit` | string |  | Example: The package contains 6 soda cans. Whether you are selling a pack of 6 cans (fardo) or a single can (unit), enter UNI for the individual can. |
| `↳↳ group_unit_value` | string |  | Example: The package contains 6 soda cans. Whether you are selling a pack of 6 cans (fardo) or a single can (unity), enter the value of the individual can. |
| `↳↳ original_group_price` | string |  | Example: The item is a package that contains 6 soda cans. Enter the price of the whole package. |
| `↳↳ group_gtin_sscc` | string |  | Example: The item is a package that contains 6 soda cans. Please inform the GTIN SSCC code for the package. |
| `↳↳ group_grai_gtin_sscc` | string |  | Example: The item is box, that contain 6 packages. Each package contains 6 soda cans. Please inform the GRAI GTIN SSCC code for the Box. |
| `↳ export_cfop` | string |  | 7101 - for sales of self-produced goods 7102 - resale of third-party goods |
| `complaint_policy` | object |  | Complaint Policy for item. Only required for local PL sellers, ignored otherwise. |
| `↳ warranty_time` | string |  | Value should be in one of ONE_YEAR TWO_YEARS OVER_TWO_YEARS. |
| `↳ exclude_entrepreneur_warranty` | boolean |  | If True means "I exclude warranty complaints for entrepreneur" |
| `↳ complaint_address_id` | int32 |  | Address for complaint. Fetch available addresses using v2.logistics.get_address_list, and use address_id returned from it. |
| `↳ additional_information` | string |  | Additional information for warranty claim. Should be less than 1000 characters. |
| `description_info` | object |  | New description field. Only whitelist sellers can use it. If you use the field, please upload the description_type=extended otherwise api will return error. If you don't use this field, you don't need to upload the description_type or upload description_type=normal |
| `↳ extended_description` | object |  | If description_type is extended , description information should be set by this field. |
| `↳↳ field_list` | object[] |  | Field of extended description. |
| `↳↳↳ field_type` | string |  | Type of extended description field ：values: See Data Definition- description_field_type (text , image). |
| `↳↳↳ text` | string |  | If field_type is text， text information will be set by this field. |
| `↳↳↳ image_info` | object |  | If field_type is image，image url will be set by this field. |
| `↳↳↳↳ image_id` | string |  | Image id. |
| `description_type` | string |  | Values: See Data Definition- description_type (normal , extended). If you want to use extended_description or change description type ,this field must be inputed |
| `gtin_code` | string |  | - GTIN is an identifier for trade items, developed by the international organization GS1. - They have 8 to 14 digits. The most common are UPC, EAN, JAN and ISBN. - GTIN will help boost positioning in online marketing channels like Google and Facebook. - That incorporation with GTIN will also aid in Search and Recommendation in Shopee itself allowing buyers to have higher likelihood of finding one's listing. Note: If you want to set “Item without GTIN”, please pass the gtin_code as "00". The validation rule is based on the value return in gtin_validation_rule" field in v2.product.get_item_limit API - Mandatory: This field is required and must contain a correctly formatted GTiN number. - Flexi |
| `ds_cat_rcmd_id` | string |  | category recommendation service id |
| `promotion_images` | object |  | Promotion Image Currently only allow one promoton image You could set promotion image only if the product images' ratio is 3:4 |
| `↳ image_id_list` | string[] |  | Promotion Image |
| `compatibility_info` | object |  |  |
| `↳ vehicle_info_list` | object[] | ✔ |  |
| `↳↳ brand_id` | int64 | ✔ | ID of the brand. |
| `↳↳ model_id` | int64 | ✔ | ID of the model. |
| `↳↳ year_id` | int64 |  | ID of the year. |
| `↳↳ version_id` | int64 |  | ID of the version. |
| `scheduled_publish_time` | timestamp |  | Scheduled publish time of this item: 1) Can only set scheduled_publish_time for item with UNLIST status 2) Can only set the time from current time +1hour to current time +90days, and the time is only allowed to be accurate to the minute |
| `authorised_brand_id` | int64 |  | ID of authorised reseller brand. |
| `size_chart_info` | object |  |  |
| `↳ size_chart` | string |  | ID of size chart image. If you want to remove the image size chart of the item, please pass the "size_chart" empty. You only need to fill out either the image or template. If both are filled, only the template will be kept. Notes: Both CB shops and local shops are supported to set "size_chart". |
| `↳ size_chart_id` | int64 |  | ID of template size chart. If you want to remove the template size chart of the item, please pass the "size_chart_id" as 0. You only need to fill out either the image or template. If both are filled, only the template will be kept. Notes: Only local shops are supported to set "size_chart_id", for CB shops please use "size_chart". |
| `certification_info` | object |  | For PH product certification input Required for some category and attribute option |
| `↳ certification_list` | object[] |  | Array of certification records for the product, each containing type, certificate number, permit ID, and proof documents. |
| `↳↳ certification_no` | string | ✔ | Certification number issued by the regulatory or certifying authority; uniquely identifies the certification. refer to https://seller.shopee.ph/edu/article/24236 |
| `↳↳ permit_id` | int64 | ✔ | Platform-defined permit ID used to link to a specific certification template or rule. get from v2.product.get_product_certification_rule |
| `↳↳ expiry_date` | int32 |  | Expiry timestamp. Required for PH, but not needed for TW. |
| `↳↳ certification_proofs` | object |  | An array of proof documents for the certification; each element represents one proof file.<path></path> |
| `↳↳↳ image_id` | string | ✔ | The unique image ID of the certification proof, returned by the image upload API. |
| `↳↳↳ file_name` | string | ✔ | The name of the uploaded certification proof file. |
| `↳↳↳ ratio` | float | ✔ | image weight/ image height Will be optional in the future; can input 0.75 by default |
| `purchase_limit_info` | object |  | purchase limit info |
| `↳ min_purchase_limit` | int32 |  | minimum purchase count for each order |
| `↳ max_purchase_limit` | object |  |  |
| `↳↳ purchase_limit` | int32 |  | maximum purchase limit for each order. |
| `medicine_id` | int64 |  | [Only for ID local sellers] as a unique identifier for each standardized medicine, the medicine id can only be obtained offline |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ description` | string | Item description. |
| `↳ weight` | float | The weight of this item, the unit is KG. |
| `↳ pre_order` | object |  |
| `↳↳ days_to_ship` | int32 | The time it takes to ship the item. |
| `↳↳ is_pre_order` | boolean | Whether item is pre order. |
| `↳ item_name` | string | Item name. |
| `↳ item_status` | string | Item status. |
| `↳ images` | object | Item images. |
| `↳↳ image_id_list` | string[] | ID list of item image. |
| `↳↳ image_url_list` | string[] | URL list of item image |
| `↳ logistic_info` | object[] |  |
| `↳↳ estimated_shipping_fee` | float | Estimated shipping fee. |
| `↳↳ logistic_name` | string | Name of logistics channel. |
| `↳↳ enabled` | boolean | Whether this channel is enabled. |
| `↳↳ logistic_id` | int32 | ID of this channel. |
| `↳↳ is_free` | boolean | Whether cover shipping fee for buyer. |
| `↳ item_id` | int64 | ID of item. |
| `↳ category_id` | int32 | ID of item category. |
| `↳ dimension` | object | The dimension of this item. |
| `↳↳ package_width` | int32 | The width of package for this item, the unit is CM. |
| `↳↳ package_length` | int32 | The length of package for this item, the unit is CM. |
| `↳↳ package_height` | int32 | The height of package for this item, the unit is CM. |
| `↳ condition` | string | Item condition, could be USED or NEW. |
| `↳ brand` | object |  |
| `↳↳ brand_id` | int32 | Id of brand. |
| `↳↳ original_brand_name` | string | Original name of brand. |
| `↳ item_dangerous` | int32 | This field is only applicable for local sellers in Indonesia and Malaysia. Use this field to identify whether a product is a dangerous product. 0 for non-dangerous product and 1 for dangerous product. For more information, please visit the market's respective Seller Education Hub. |
| `↳ complaint_policy` | object | Complaint policy |
| `↳↳ warranty_time` | string | Value should be in one of ONE_YEAR TWO_YEARS OVER_TWO_YEARS. |
| `↳↳ exclude_entrepreneur_warranty` | boolean | If True means "I exclude warranty complaints for entrepreneur" |
| `↳↳ additional_information` | string | Additional information for complaint policy |
| `↳ description_info` | object | New description field. Only whitelist sellers can use it. If you use the field, please upload the description_type=extended otherwise api will return error. If you don't use this field, you don't need to upload the description_type or upload description_type=normal |
| `↳↳ extended_description` | object | If description_type is extended , description information should be set by this field. |
| `↳↳↳ field_list` | object[] | Field of extended description. |
| `↳↳↳↳ field_type` | string | Type of extended description field ：values: See Data Definition- description_field_type (text , image). |
| `↳↳↳↳ text` | string | If field_type is text， text information will be set by this field. |
| `↳↳↳↳ image_info` | object | If field_type is image，image url will be set by this field. |
| `↳↳↳↳↳ image_id` | string | Image id. |
| `↳ description_type` | string | Values: See Data Definition- description_type (normal , extended). |

Lỗi riêng: The GTIN code is mandatory, please check and upload again. · The category does not match the INMETRO certification. Please verify. · This INMETRO certification is not active. Please provide a valid certification. · Invalid INMETRO certification number. Please provide a valid certification. · Please input the correct TS Mark (TD Mark) to upload your product, and refer to the SEH article - https://seller.shopee.tw/edu/article/19732 if you have any questions. · Medicine ID is mandatory for products in Prescription/OTC category. · Please input the correct medicine ID. · For OTC medicine, maximum purchase limit per order is mandatory and cannot exceed 3 days of use. · Upload failed, please upload a more standard size chart image. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}.

## v2.product.delete_item
`POST /api/v2/product/delete_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this call to delete a product item.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 | ✔ | The identity of product item. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Item/Model Fulfillment by Shopee can not be update. · Shop is not found. · cnsc shop not upgraded, can not edit item. · Item_id is not found. · Shop_id is not found. · Delete item failed. please try later.

## v2.product.init_tier_variation
`POST /api/v2/product/init_tier_variation` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

This API allows you to update the tier structure of a product. Defining only color creates one tier, while color + size creates two tiers (maximum supported). Supported changes include: no tier ↔ one/two tiers, one tier ↔ two/no tier, and two tiers ↔ one/no tier. For details, see Developer Guide. Please wait at least 5 seconds after creating an item before creating variants, as processing may be delayed.

Lịch sử cập nhật: 2025-09-12: The tier_variation structure in the documentation has been deprecated. Please use the standardise_tier_variation structure when uploading variations.; 2025-01-08: Update GTIN validation rule; 2024-06-27: support update one tier or two tier to no tier; 2024-06-21: add model level DTS; 2024-05-29: add model level weight and dimension

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 | ✔ | ID of item |
| `model` | object[] | ✔ | Model info list, model number at most 50 |
| `↳ tier_index` | int32[] | ✔ | Tier index of this model. If you want to update one tier/two tier to no tier, can just pass the tier_variation and standardise_tier_variation as [], and pass the model >> tier_index as [], meanwhile pass the original_price, seller_stock, etc., to set the price and stock for the modified product with no tier structure. |
| `↳ original_price` | float | ✔ | Original price of this model. For CO local VAT responsible seller： Please remember the price you set in here must be VAT inclusive. If you have any doubts on how to calculate VAT for your product please refer to the Seller Education Hub（https://seller.shopee.com.co/edu/article/13565） |
| `↳ model_sku` | string |  | Seller SKU of this model, model_sku length information needs to be no more than 100 characters. |
| `↳ seller_stock` | object[] | ✔ | new stock info（Please notice that stock(including Seller Stock and Shopee Stock) should be larger than or equal to real-time reserved stock） |
| `↳↳ location_id` | string |  | location id, you can get the location id from v2.shop.get_warehouse_detail api, if seller don't have any warehouse, you don't need to upload this field. |
| `↳↳ stock` | int32 | ✔ | stock |
| `↳ gtin_code` | string |  | - GTIN is an identifier for trade items, developed by the international organization GS1. - They have 8 to 14 digits. The most common are UPC, EAN, JAN and ISBN. - GTIN will help boost positioning in online marketing channels like Google and Facebook. - That incorporation with GTIN will also aid in Search and Recommendation in Shopee itself allowing buyers to have higher likelihood of finding one's listing. Note: If you want to set “Item without GTIN”, please pass the gtin_code as "00". The validation rule is based on the value return in gtin_validation_rule" field in v2.product.get_item_limit API - Mandatory : This field is required and must contain a correctly formatted GTiN number. - Flex |
| `↳ weight` | float |  | The weight of this model, the unit is KG. If don't set the weight of this model, will use the weight of item by default. If set the dimension of this model, them must set the weight of this model. |
| `↳ dimension` | object |  | The dimension of this model. If don't set the dimension of this model, will use the dimension of item by default. |
| `↳↳ package_height` | int32 | ✔ | The height of package for this model, the unit is CM. |
| `↳↳ package_length` | int32 | ✔ | The length of package for this model, the unit is CM. |
| `↳↳ package_width` | int32 | ✔ | The width of package for this model, the unit is CM. |
| `↳ pre_order` | object |  | Pre-order information of this model. Notes: If don't set the DTS of this model, will use the DTS of the item by default. |
| `↳↳ is_pre_order` | boolean | ✔ | Whether the model is pre order. |
| `↳↳ days_to_ship` | int32 |  | Days to ship. Please get the days_to_ship range from the get_dts_limit API. |
| `↳ ssp_id` | int64 |  | The ID of the Standardized Shop Product (SSP) to associate with the default model of the new item. The value must be greater than 0 when provided. If ssp_id is provided, cssp_id must also be provided. |
| `↳ cssp_id` | int64 |  | The ID of the country-specific Standardized Shop Product (CSSP) to associate with the default model of the new item. The value must be greater than 0 when provided. This field is required when ssp_id is provided. |
| `standardise_tier_variation` | object[] |  | There is at least one standardise_tier_variation and tier_variation. If you want to update one tier/two tier to no tier, can just pass the tier_variation and standardise_tier_variation as [], and pass the model >> tier_index as [], meanwhile pass the original_price, seller_stock, etc., to set the price and stock for the modified product with no tier structure. |
| `↳ variation_id` | int32 | ✔ | standardise tier variation ID. |
| `↳ variation_name` | string |  | standardise tier variation name |
| `↳ variation_group_id` | int32 |  | standardise tier variation group ID |
| `↳ variation_option_list` | object[] | ✔ | standardise tier variation option list |
| `↳↳ variation_option_id` | int32 |  | standardise tier variation option ID. |
| `↳↳ variation_option_name` | string |  | standardise tier variation option value |
| `↳↳ image_id` | string |  | standardise tier variation option image ID |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_id` | int64 | ID of item |
| `↳ tier_variation` | object[] | Variations of item |
| `↳↳ name` | string | Variation name |
| `↳↳ option_list` | object[] | Options of this variation |
| `↳↳↳ image` | object | Image of this option |
| `↳↳↳↳ image_url` | string | URL of image |
| `↳↳↳ option` | string | Option name |
| `↳ model` | object[] |  |
| `↳↳ tier_index` | object[] | Tier index of model. Index starts from 0. |
| `↳↳ model_id` | int64 | ID of model |
| `↳↳ model_sku` | string | Seller SKU of this model |
| `↳↳ price_info` | object[] |  |
| `↳↳↳ original_price` | float | Original price |
| `↳↳ seller_stock` | object[] | new stock info |
| `↳↳↳ location_id` | string | location id |
| `↳↳↳ stock` | int32 | stock |
| `↳↳ weight` | float | The weight of this model, the unit is KG. If don't set the weight of this model, will use the weight of item by default. If set the dimension of this model, them must set the weight of this model. |
| `↳↳ dimension` | object | The dimension of this model. If don't set the dimension of this model, will use the dimension of item by default. |
| `↳↳↳ package_height` | int32 | The height of package for this model, the unit is CM. |
| `↳↳↳ package_length` | int32 | The length of package for this model, the unit is CM. |
| `↳↳↳ package_width` | int32 | The width of package for this model, the unit is CM. |
| `↳↳ ssp_id` | int64 | The ID of the Standardized Shop Product (SSP) to associate with the default model of the new item. The value must be greater than 0 when provided. If ssp_id is provided, cssp_id must also be provided. |
| `↳↳ cssp_id` | int64 | The ID of the country-specific Standardized Shop Product (CSSP) to associate with the default model of the new item. The value must be greater than 0 when provided. This field is required when ssp_id is provided. |

Lỗi riêng: The GTIN code is mandatory, please check and upload again. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Item/Model Fulfillment by Shopee can not be update. · Item not belong to shop. · CNCS shop can not modify tier_variation structure. · Item_id is not found. · Shop_id is not found.

## v2.product.update_tier_variation
`POST /api/v2/product/update_tier_variation` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

This api can only be used without changing the tier structure, you can add options, delete options, and update the option image by this api. More detail please check: https://open.shopee.com/developer-guide/219

Lịch sử cập nhật: 2025-09-12: The tier_variation structure in the documentation has been deprecated. Please use the standardise_tier_variation structure when uploading variations.; 2024-03-26: Add standard variation fields; 2022-08-11: add model list; 2022-03-30: update image id description; 2022-01-27: update the define and tier_variation description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 | ✔ | ID of item. |
| `model_list` | object[] |  | Item's model list |
| `↳ model_id` | int64 | ✔ | ID of model |
| `↳ tier_index` | int64[] | ✔ | Model's tier_variation |
| `standardise_tier_variation` | object[] |  | item standardise tier variation There is at least one standardise_tier_variation and tier_variation |
| `↳ variation_id` | int64 | ✔ | standardise tier variation ID |
| `↳ variation_name` | string |  | standardise tier variation name |
| `↳ variation_group_id` | int64 |  | standardise tier variation group id |
| `↳ variation_option_list` | object[] | ✔ | standardise tier variation option list |
| `↳↳ variation_option_id` | int64 | ✔ | standardise tier variation option ID |
| `↳↳ variation_option_name` | string |  | standardise tier variation option value |
| `↳↳ image_id` | string |  | ID of image |

Lỗi riêng: The tier_index is not exist · The model_id is duplicate, model_id:{{.model_id}} · The GTIN code is mandatory, please check and upload again. · The model_id is wrong or not related to this item, model_id:{{.model_id}} · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Item/Model Fulfillment by Shopee can not be update. · Item not belong to shop.

## v2.product.get_model_list
`GET /api/v2/product/get_model_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Accounting And Finance, Customer Service, Customized APP, Ads Service, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management

Get model list of an item.

Lịch sử cập nhật: 2026-07-31: promotion_id type change to uint64; 2025-11-07: add new response field "has_promotion"; 2025-09-05: add to new response field "local_promotion_price"and "local_price"; 2025-02-17: Add is_fulfillment_by_shopee; 2024-11-01: Update the description of total_reserved_stock to return the total reserved stock for P Item and all A Items under the P Item

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 | ✔ | The ID of the item |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ tier_variation` | object[] | Variation config of item. |
| `↳↳ option_list` | object[] | Option list. |
| `↳↳↳ option` | string | Option name. |
| `↳↳↳ image` | object |  |
| `↳↳↳↳ image_id` | string | Id of image |
| `↳↳↳↳ image_url` | string | Url of image. |
| `↳↳ name` | string | Variation name. |
| `↳ model` | object[] | Model list. |
| `↳↳ price_info` | object[] | Price info. For SG/MY/BR/MX/PL/ES/AR seller: Sellers can set the price with two decimal place, other regions can only set the price as an integer. |
| `↳↳↳ currency` | string | Currency for the item price. |
| `↳↳↳ current_price` | float | Current price of item. |
| `↳↳↳ original_price` | float | Original price of item. |
| `↳↳↳ inflated_price_of_original_price` | float | Original price of item after tax. |
| `↳↳↳ inflated_price_of_current_price` | float | Current price of item after tax. |
| `↳↳↳ sip_item_price` | float | SIP item price. If item is from SIP primary shop, this field will be returned. |
| `↳↳↳ sip_item_price_source` | string | SIP item price source, could be manual or auto.If item is from SIP primary shop, this field will be returned. |
| `↳↳↳ sip_item_price_currency` | string | The currency of sip_item_price.If item is from SIP primary shop, this field will be returned. |
| `↳↳↳ local_price` | float | The original price multiplied by the local adjustment rate equals the local price. The local price is denominated in the local currency and is rounded to two decimal places. <path></path> |
| `↳↳↳ local_promotion_price` | float | During the promotion period, the CB price is multiplied by the local adjustment rate. Once the promotion starts, the price remains unchanged. During the promotion, the local_promotion_price= current_price, which is denominated in the local currency and retained to two decimal places. <path></path> |
| `↳↳ model_id` | int64 | Model ID. |
| `↳↳ tier_index` | int32[] | Tier index of this model. |
| `↳↳ promotion_id` | uint64 | Current promotion ID of this model. |
| `↳↳ has_promotion` | boolean | Indicates whether the model is currently under any ongoing promotion. |
| `↳↳ model_sku` | string | SKU of this model. the length should be under 100. |
| `↳↳ model_status` | string | The model status. Should be MODEL_NORMAL or MODEL_UNAVAILABLE. MODEL_NORMAL models can be sold on the buyer's side, and MODEL_UNAVAILABLE models cannot be sold on the buyer's side. |
| `↳↳ pre_order` | object | (Only whitelisted users can use) |
| `↳↳↳ is_pre_order` | boolean | Pre-order. |
| `↳↳↳ days_to_ship` | int32 | The days to ship. |
| `↳↳ stock_info_v2` | object | new stock info. Please check this FAQ for more detail: https://open.shopee.com/faq?top=162&sub=166&page=1&faq=230 |
| `↳↳↳ summary_info` | object | stock summary Info |
| `↳↳↳↳ total_reserved_stock` | int32 | Stock reserved for promotion. Note: For SIP P Item, will return the total reserved stock for P Item and all A Items under the P Item. |
| `↳↳↳↳ total_available_stock` | int32 | Stock can be sold currently |
| `↳↳↳ seller_stock` | object[] | Seller-managed stock |
| `↳↳↳↳ location_id` | string | location id |
| `↳↳↳↳ stock` | int32 | stock in the current warehouse |
| `↳↳↳↳ if_saleable` | boolean | To return if the stock of the location id is saleable |
| `↳↳↳ shopee_stock` | object[] | Shopee warehouse stock |
| `↳↳↳↳ location_id` | string | location id |
| `↳↳↳↳ stock` | string | stock |
| `↳↳↳ advance_stock` | object | Only for PH/VN/ID/MY local selected shops. |
| `↳↳↳↳ sellable_advance_stock` | int32 | Refers to Advance Fulfillment stock that Seller has shipped out and is available to be used to fulfill an order. |
| `↳↳↳↳ in_transit_advance_stock` | int32 | Refers to Advance Fulfillment stock that seller has shipped out and is still in transit and unavailable to be used to fulfill an order. |
| `↳↳ gtin_code` | string | (Only TW seller and BR local seller available) gtin code. |
| `↳↳ weight` | string | The weight of this model, the unit is KG. If don't set the weight of this model, will use the weight of item by default. |
| `↳↳ dimension` | object | The dimension of this model. If don't set the dimension of this model, will use the dimension of item by default. |
| `↳↳↳ package_height` | int32 | The height of package for this model, the unit is CM. |
| `↳↳↳ package_length` | int32 | The length of package for this model, the unit is CM. |
| `↳↳↳ package_width` | int32 | The width of package for this model, the unit is CM. |
| `↳↳ is_fulfillment_by_shopee` | boolean | whether model is fulfillment by shopee |
| `↳↳ ssp_id` | int64 | The ID of the Standardized Shop Product (SSP) to associate with the default model of the new item. The value must be greater than 0 when provided. If ssp_id is provided, cssp_id must also be provided. |
| `↳↳ cssp_id` | int64 | The ID of the country-specific Standardized Shop Product (CSSP) to associate with the default model of the new item. The value must be greater than 0 when provided. This field is required when ssp_id is provided. |
| `↳ standardise_tier_variation` | object[] | Standardise Variation config of item. |
| `↳↳ variation_id` | int64 | Standardise Variation ID |
| `↳↳ variation_name` | string | Standardise Variation Name |
| `↳↳ variation_group_id` | int64 | Standardise Variation Group ID |
| `↳↳ variation_option_list` | object[] | Standardise Variation Option List |
| `↳↳↳ variation_option_id` | int64 | Standardise Option ID |
| `↳↳↳ variation_option_name` | string | Standardise Option Name |
| `↳↳↳ image_id` | string | ID of image |
| `↳↳↳ image_url` | string | URL of image |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Shop is not found. · Item_id is not found. · Shop_id is not found. · error data · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team.

## v2.product.add_model
`POST /api/v2/product/add_model` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Add model. More detail please check: https://open.shopee.com/developer-guide/219

Lịch sử cập nhật: 2025-01-08: Update GTIN validation rule; 2024-06-21: add model level DTS; 2024-05-29: add model level weight and dimension; 2023-05-05: update the description of gtin_code; 2022-10-31: offline the normal_stock and stock_info fields

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 | ✔ | ID of item |
| `model_list` | object[] | ✔ | Model list |
| `↳ tier_index` | int32[] | ✔ | Tier index of model |
| `↳ original_price` | float | ✔ | Normal stock for price |
| `↳ model_sku` | string |  | Seller sku, model_sku length information needs to be no more than 100 characters. |
| `↳ seller_stock` | object[] | ✔ | new stock info for model（Please notice that stock(including Seller Stock and Shopee Stock) should be larger than or equal to real-time reserved stock） |
| `↳↳ location_id` | string |  | location id, you can get the location id from v2.shop.get_warehouse_detail api, if seller don't have any warehouse, you don't need to upload this field. |
| `↳↳ stock` | int32 | ✔ | stock |
| `↳ gtin_code` | string |  | - GTIN is an identifier for trade items, developed by the international organization GS1. - They have 8 to 14 digits. The most common are UPC, EAN, JAN and ISBN. - GTIN will help boost positioning in online marketing channels like Google and Facebook. - That incorporation with GTIN will also aid in Search and Recommendation in Shopee itself allowing buyers to have higher likelihood of finding one's listing. Note: If you want to set “Item without GTIN”, please pass the gtin_code as "00". The validation rule is based on the value return in gtin_validation_rule" field in v2.product.get_item_limit API - Mandatory : This field is required and must contain a correctly formatted GTiN number. - Flex |
| `↳ weight` | float |  | The weight of this model, the unit is KG. If don't set the weight of this model, will use the weight of item by default. If set the dimension of this model, them must set the weight of this model. |
| `↳ dimension` | object |  | The dimension of this model. If don't set the dimension of this model, will use the dimension of item by default. |
| `↳↳ package_height` | int32 | ✔ | The height of package for this model, the unit is CM. |
| `↳↳ package_length` | int32 | ✔ | The length of package for this model, the unit is CM. |
| `↳↳ package_width` | int32 | ✔ | The width of package for this model, the unit is CM. |
| `↳ pre_order` | object |  | Pre-order information of this model. Notes: If don't set the DTS of this model, will use the DTS of the item by default. |
| `↳↳ is_pre_order` | boolean | ✔ | Whether the model is pre order. |
| `↳↳ days_to_ship` | int32 |  | Days to ship. Please get the days_to_ship range from the get_dts_limit API. |
| `↳ ssp_id` | int64 |  | The ID of the Standardized Shop Product (SSP) to associate with the default model of the new item. The value must be greater than 0 when provided. If ssp_id is provided, cssp_id must also be provided. |
| `↳ cssp_id` | int64 |  | The ID of the country-specific Standardized Shop Product (CSSP) to associate with the default model of the new item. The value must be greater than 0 when provided. This field is required when ssp_id is provided. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ model` | object[] |  |
| `↳↳ tier_index` | int32[] | model tier index |
| `↳↳ model_id` | int64 | ID of model |
| `↳↳ model_sku` | string | Seller SKU of this model, model_sku length information needs to be no more than 100 characters. |
| `↳↳ price_info` | object[] |  |
| `↳↳↳ original_price` | float | Original Price. For CO local VAT responsible seller： Please remember the price you set in here must be VAT inclusive. If you have any doubts on how to calculate VAT for your product please refer to the Seller Education Hub（https://seller.shopee.com.co/edu/article/13565） |
| `↳↳ seller_stock` | object[] | new stock info |
| `↳↳↳ location_id` | string | location id |
| `↳↳↳ stock` | int32 | stock |
| `↳↳ weight` | float | The weight of this model, the unit is KG. If don't set the weight of this model, will use the weight of item by default. If set the dimension of this model, them must set the weight of this model. |
| `↳↳ dimension` | object | The dimension of this model. If don't set the dimension of this model, will use the dimension of item by default. |
| `↳↳↳ package_height` | int32 | The height of package for this model, the unit is CM. |
| `↳↳↳ package_length` | int32 | The length of package for this model, the unit is CM. |
| `↳↳↳ package_width` | int32 | The width of package for this model, the unit is CM. |

Lỗi riêng: The GTIN code is mandatory, please check and upload again. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Item/Model Fulfillment by Shopee can not be update. · Item not belong to shop. · Shop_id is not found. · The level of tier-variation over 2. · Model tier_index error.

## v2.product.update_model
`POST /api/v2/product/update_model` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Update seller sku/ pre order/ model status for model.

Lịch sử cập nhật: 2025-01-08: Update GTIN validation rule; 2024-05-29: add model level weight and dimension; 2023-05-05: update the description of gtin_code; 2023-01-03: add model_status field; 2022-09-15: add gtin_code

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 | ✔ | ID of item |
| `model` | object[] | ✔ | Length should be between 1 to 50 |
| `↳ model_id` | int64 | ✔ | ID of model |
| `↳ model_sku` | string | ✔ | Seller SKU for model, model_sku length information needs to be no more than 100 characters. CNSC and KRSC sellers are not allowed to update the MPSKU model sku. |
| `↳ pre_order` | object |  |  |
| `↳↳ is_pre_order` | boolean | ✔ | Pre-order |
| `↳↳ days_to_ship` | int32 | ✔ | The days to ship. Only work for is_pre_order=true |
| `↳ gtin_code` | string |  | - GTIN is an identifier for trade items, developed by the international organization GS1. - They have 8 to 14 digits. The most common are UPC, EAN, JAN and ISBN. - GTIN will help boost positioning in online marketing channels like Google and Facebook. - That incorporation with GTIN will also aid in Search and Recommendation in Shopee itself allowing buyers to have higher likelihood of finding one's listing. Note: If you want to set “Item without GTIN”, please pass the gtin_code as "00". The validation rule is based on the value return in gtin_validation_rule" field in v2.product.get_item_limit API - Mandatory : This field is required and must contain a correctly formatted GTiN number. - Flex |
| `↳ model_status` | string |  | can be "NORMAL" or "UNAVAILABLE". Only CNSC and KRSC sellers can set the model_status. Normal models can be sold on the buyer's side, and UNAVAILABLE models cannot be sold on the buyer's side. |
| `↳ weight` | float |  | The weight of this model, the unit is KG. If don't set the weight of this model, will use the weight of item by default. If set the dimension of this model, them must set the weight of this model. |
| `↳ dimension` | object |  | The dimension of this model. If don't set the dimension of this model, will use the dimension of item by default. |
| `↳↳ package_height` | int32 | ✔ | The height of package for this model, the unit is CM. |
| `↳↳ package_length` | int32 | ✔ | The length of package for this model, the unit is CM. |
| `↳↳ package_width` | int32 | ✔ | The width of package for this model, the unit is CM. |

Lỗi riêng: The GTIN code is mandatory, please check and upload again. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Item_id is not found. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Product not found · Update item failed {{.error_info}}

## v2.product.delete_model
`POST /api/v2/product/delete_model` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Delete item model.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 | ✔ | ID of item. |
| `model_id` | int64 | ✔ | ID of model. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Item/Model Fulfillment by Shopee can not be update. · Item not belong to shop. · Item_id is not found. · Shop_id is not found. · Model_id and item_id not match. · Our system is taking some time to respond, please try later.

## v2.product.unlist_item
`POST /api/v2/product/unlist_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Unlist item.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_list` | object[] | ✔ | Length should be between 1 to 50. |
| `↳ item_id` | int64 | ✔ | Shopee's unique identifier for an item |
| `↳ unlist` | boolean | ✔ | Unlist or not |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ failure_list` | object[] |  |
| `↳↳ item_id` | int64 | Failed item id |
| `↳↳ failed_reason` | string | Failed reason |
| `↳ success_list` | object[] |  |
| `↳↳ item_id` | int64 | Success item id |
| `↳↳ unlist` | boolean | Whether the item is unlisted |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · cnsc shop not upgraded, can not edit item. · Shop_id is not found. · Unlist item all failed. · Unlist item failed. please try later. · Get shop failed. please try later. · Shop status invalid.

## v2.product.update_price
`POST /api/v2/product/update_price` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Update price.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 | ✔ | ID of item. |
| `price_list` | object[] | ✔ | Length should be between 1 to 50. |
| `↳ model_id` | int64 |  | 0 for no model item. |
| `↳ original_price` | float | ✔ | Original price for this model. For CO local VAT responsible seller： Please remember the price you set in here must be VAT inclusive. If you have any doubts on how to calculate VAT for your product please refer to the Seller Education Hub（https://seller.shopee.com.co/edu/article/13565） For SG/MY/BR/MX/PL/ES/AR seller: Sellers can set the price with two decimal place, other regions can only set the price as an integer. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ failure_list` | object[] | Fail model list. |
| `↳↳ model_id` | int64 | ID of model. |
| `↳↳ failed_reason` | string | Reason for failure. |
| `↳ success_list` | object[] | Success model list. |
| `↳↳ model_id` | int64 | ID of model. |
| `↳↳ original_price` | float | Original price for model. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Item not belong to shop. · Item_id is not found. · Shop_id is not found. · Repeat model_id. · Wrong model_id. · Original_price should bigger then wholesale price

## v2.product.update_stock
`POST /api/v2/product/update_stock` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this API to update one item_id for each call, but still can support updating multiple model_ids stock of the same item_id (If you need batch modification, please call multiple times)This API will update only "seller_stock".Whenever there is a promotion ongoing or upcoming, the total stock must be larger than or equal to real-time “reserved_stock” promotion stock (Please check v2.get_item_promotion API for more details). Items that are deleted will not be allowed to modify stock.

Lịch sử cập nhật: 2022-10-31: offline the normal_stock fields; 2022-06-13: add reminder "Please use the seller_stock field instead, we will deprecate this field in the future."

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 | ✔ | ID of item. |
| `stock_list` | object[] | ✔ | Length should be between 1 to 50. |
| `↳ model_id` | int64 |  | 0 for no model item. |
| `↳ seller_stock` | object[] | ✔ | new stock info（Please notice that stock(including Seller Stock and Shopee Stock) should be larger than or equal to real-time reserved stock） |
| `↳↳ location_id` | string |  | location id, you can get the location id from v2.shop.get_warehouse_detail api, if seller don't have any warehouse, you don't need to upload this field. |
| `↳↳ stock` | int64 | ✔ | stock |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ failure_list` | object[] | Fail model list. |
| `↳↳ model_id` | int64 | ID of model. |
| `↳↳ failed_reason` | string | Reason for failure. |
| `↳ success_list` | object[] | Success model list. |
| `↳↳ model_id` | int64 | ID of model. |
| `↳↳ location_id` | string | location id; This field and the stock field are returned in pairs |
| `↳↳ stock` | int64 | stock;This field is returned if seller stock is used in the request, and normal stock fields are not returned. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Item not belong to shop. · Warehouse shop can't update stock. · cnsc shop not upgraded, can not edit item. · Item_id is not found. · Shop_id is not found. · Parameter is not match the constraints, {{.error_info}}.

## v2.product.boost_item
`POST /api/v2/product/boost_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Boost item.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id_list` | int64[] | ✔ | Shopee's unique identifier for an item, limit:[1,5] |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ failure_list` | object[] |  |
| `↳↳ item_id` | int64 | Failed item ID. |
| `↳↳ failed_reason` | string | Reason for failure. |
| `↳ success_list` | object |  |
| `↳↳ item_id_list` | int64[] | Success item ID. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · shop is upgrading , can not operate · cnsc shop not upgraded, can not edit item. · Shop_id is not found. · Boost item all failed. · Cannot get partner token. · Boost item failed. please try later.

## v2.product.get_boosted_list
`GET /api/v2/product/get_boosted_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get boosted item list.

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_list` | object[] |  |
| `↳↳ item_id` | int | Shopee's unique identifier for an item |
| `↳↳ cool_down_second` | int | Remain cool down time |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Shop_id is not found. · Cannot get partner token. · Get boosted item infomation failed. please try later. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Product not found

## v2.product.get_item_promotion
`GET /api/v2/product/get_item_promotion` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Marketing, Customized APP, Ads Service, Swam ERP, Livestream Management, Ads Facil, Affiliate Marketing Solution Management, Shopee Video Management

Get item promotion info.

Lịch sử cập nhật: 2026-07-31: promotion_id type change to uint64; 2024-10-23: sunset the reserved_stock_info; 2022-06-13: add reminder "Please use the promotion_stock_info_v2 field instead, we will deprecate this field in the future."; 2021-08-16: update promotion_staging description and example

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id_list` | int64[] | ✔ | Item ID list, can send 1 to 50 items. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ success_list` | object[] | Success item promotion info. |
| `↳↳ item_id` | int | The identity of product item. |
| `↳↳ promotion` | object[] | Item promotion info list |
| `↳↳↳ promotion_type` | string | Promotion type, Applicable values: See Data Definition- PromotionType. |
| `↳↳↳ promotion_id` | uint64 | The identity of item promotion. |
| `↳↳↳ model_id` | int64 | The identity of product model. |
| `↳↳↳ start_time` | timestamp | Promotion start tiem. |
| `↳↳↳ end_time` | timestamp | Promotion end item. |
| `↳↳↳ promotion_price_info` | object[] | Promotion price info. |
| `↳↳↳↳ promotion_price` | float | Promotion price. |
| `↳↳↳ promotion_staging` | string | Could be ongoing/upcoming |
| `↳↳↳ promotion_stock_info_v2` | object | new promotion stock |
| `↳↳↳↳ summary_info` | object | stock summary info |
| `↳↳↳↳ total_reserved_stock` | int32 | Total Stock reserved for promotion |
| `↳ failure_list` | object[] | Fail item promotion info. |
| `↳↳ item_id` | int64 | The identity of item. |
| `↳↳ failed_reason` | string | Fail reason. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Model_id and item_id not match. · Repeat item_id. · Get shop failed. please try later. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Product not found

## v2.product.update_sip_item_price
`POST /api/v2/product/update_sip_item_price` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Update sip item price.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int | ✔ | ID of item. |
| `sip_item_price` | object[] |  |  |
| `↳ model_id` | int |  | 0 for no model item. |
| `↳ sip_item_price` | float | ✔ | SIP item price. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Item not belong to shop. · Shop_id is not found. · Repeat model_id. · Wrong model_id. · Sip_item_price should less than the original_price. · Call sip api with error.

## v2.product.search_item
`GET /api/v2/product/search_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this call to search item.

Lịch sử cập nhật: 2024-01-19: add item_status and deboost_only request parameter; 2022-07-28: add item_sku request parameter; 2021-04-30: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `offset` | string |  | Specifies the starting entry of data to return in the current call. Default is empty. if data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int | ✔ | the size of one page. |
| `item_name` | string |  | name of item. |
| `attribute_status` | int |  | 1:get item lack of requires attribute. 2:get item lack of optional attribute. |
| `item_sku` | string |  | sku. If you search for item_sku and item_name at the same time, only the results that match item_sku will be returned. If you search for item_sku and attribute_status at the same time, the results that match both item_sku and attribute_status will be returned. |
| `item_status` | string[] |  | NORMAL/BANNED/UNLIST/ REVIEWING/SELLER_DELETE/SHOPEE_DELETE If you want to search multiple status, please upload the url like this: item_status=NORMAL&item_status=BANNED |
| `deboost_only` | boolean |  | If deboost_only is true, then API will return items whose deboost is true, if deboost_only is empty or false, then API will return items whose deboost is true and false simultaneously |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_id_list` | int[] | List of item ID. |
| `↳ total_count` | int | Total num of items match condation. |
| `↳ next_offset` | string | If has_next_page is true, this value need set to next request.offset |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · request must set one of [item_name,attribute_status] · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Product not found · Update item failed {{.error_info}} · Update item failed {{.error_info}}

## v2.product.get_comment
`GET /api/v2/product/get_comment` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Customized APP, Swam ERP

Use this api to get comment by shop_id, item_id, or comment_id, get up to 1000 comments.

Rate limit: [0,0,0]

Lịch sử cập nhật: 2024-09-25: add model_id_list, media > image_url_list, media > video_url_list, comment_reply > create_time response parameters

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 |  | The identity of product item. |
| `comment_id` | int64 |  | The identity of comment. |
| `cursor` | string | ✔ | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 100. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ more` | boolean | This is to indicate whether the comment list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of comments. But only respond 500 comments at most through OpenAPI, if there are more than 500, this field "more" also respond "true". |
| `↳ item_comment_list` | object[] | The comment data list of the items. |
| `↳↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳↳ comment_id` | string | The identity of comment. |
| `↳↳ comment` | string | The content of the comment. |
| `↳↳ buyer_username` | string | The username of the buyer who posted the comment. |
| `↳↳ item_id` | int64 | The commented item's id |
| `↳↳ model_id` | int64 | Shopee's unique identifier for a model of an item. It will only return 0 now. Will be offline on 2024-12-27 , please switch to use model_id_list. |
| `↳↳ rating_star` | int32 | Buyer's rating for the item. |
| `↳↳ editable` | string | The editable status of the comment. The value may be one of EXPIRED/EDITABLE/HAVE_EDIT_ONCE. |
| `↳↳ hidden` | boolean | The comment is hidden or not. |
| `↳↳ create_time` | timestamp | The create time of the comment. |
| `↳↳ comment_reply` | object | The reply of the comment. |
| `↳↳↳ reply` | string | The content of reply. |
| `↳↳↳ hidden` | boolean | The comment reply is hidden or not. |
| `↳↳↳ create_time` | timestamp | The time the seller replied to the comment. |
| `↳↳ model_id_list` | int64[] | List of model id of the buyer's purchase corresponding to the comment. |
| `↳↳ media` | object |  |
| `↳↳↳ image_url_list` | string[] | List of image url uploaded by the buyer in the comment. |
| `↳↳↳ video_url_list` | string[] | List of video url uploaded by the buyer in the comment. |
| `↳ next_cursor` | string | If more is true, you should pass the next_cursor in the next request as cursor. The value of next_cursor will be empty string when more is false. |

Lỗi riêng: The comment is not exist. Please check the comment. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Get comment failed. Please try again later. · Item id of cmt is not the same as item id get from param. · Item (ID {item_id}) is not exist. · Shop id is invalid. Please check your shop. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}.

## v2.product.reply_comment
`POST /api/v2/product/reply_comment` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this api to reply comments from buyers in batch.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `comment_list` | object[] | ✔ | The list of comment. The limit is between 1 and 100. |
| `↳ comment_id` | int | ✔ | The identity of comment. |
| `↳ comment` | string | ✔ | The content of the comment. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ result_list` | object[] | The result list of the request comment list. |
| `↳↳ comment_id` | int | The identity of comment. |
| `↳↳ fail_error` | string | Indicate error details if one element hit error. |
| `↳↳ fail_message` | string | Indicate error type if one element hit error. |

Lỗi riêng: You has replied this comment already. · Comment length should be between 1 and 500. Please update the comment. · Reply comment failed. Shop token invalid, please try to re-auth to partner. · The Comment you replied does not exist. · Duplicate comment id { cmm_id}. · Wrong parameters, detail: {msg}. · Wrong parameters, detail: {msg}. · Sorry you don't have the permission, detail: {msg}. · System error. Please try again later. · Get token failed. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found.

## v2.product.category_recommend
`GET /api/v2/product/category_recommend` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Recommend category by item name.

Lịch sử cập nhật: 2022-07-04: add product_cover_image request parameter; 2022-02-16: update type; 2021-07-12: update response example; 2021-06-04: update path; 2021-04-30: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_name` | string | ✔ | name of item |
| `product_cover_image` | string |  | Please use the image id returned by v2.media_space.upload_image api, we will ignore if this field is empty string |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ category_id` | int[] | Shopee's unique identifier for a category. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · image is unavailable · Shop_id is not found. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Product not found · Update item failed {{.error_info}}

## v2.product.register_brand
`POST /api/v2/product/register_brand` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this call to register a brand.

Lịch sử cập nhật: 2023-05-26: update the parameter name from brand_country to brand_region; 2022-09-29: add the licenses and brand_registration_website request parameters; 2021-09-06: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `original_brand_name` | string | ✔ | Brand name, length<=254. |
| `category_list` | int[] | ✔ | Category_id list for this brand, please input category in L1 or L2. Max input num of category_id is 50. |
| `product_image` | object | ✔ |  |
| `↳ image_id_list` | string[] | ✔ | Image Id of product image for this brand, max input num of file = 10 ,each file's length<=498. ID market is optional. |
| `app_logo_image_id` | string |  | Image_id of logo for app client,please input hashcode of this picture. |
| `brand_website` | string |  | Official website of brand, length<=254. |
| `brand_description` | string |  | The description of this brand, can input the information, length<=254. |
| `additional_information` | string |  | Additional notes or comment can seller can add, length<=254. |
| `pc_logo_image_id` | string |  | Image_id of logo for pc client,please input hashcode of this picture. |
| `brand_region` | string | ✔ | origin region of brand. |
| `licenses` | object[] |  | For appeal blacklisted brand data |
| `↳ file_name` | string |  | Brand registration certificate image name, len < 254 |
| `↳ file_hash` | string |  | Image id of brand registration certificate image , max input num of file = 1 , each file's length<=498 |
| `brand_registration_website` | string |  | The link to brand registration website, It is mandatory when brand name hit blacklist.len<254 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ brand_id` | int | The identity of brand. |
| `↳ original_brand_name` | string | Brand name |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Shop_id is not found. · brand image is required · Invalid category ID {{.error_info}} · The market this shop belongs to do not support brand registration. · Brand already exists. If you want to add available category for this brand, you can change the category. · The brand you registered is in the inspection process. Please contact Shopee Customer Service for more information.

## v2.product.get_recommend_attribute
`GET /api/v2/product/get_recommend_attribute` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get recommend attributes.

Lịch sử cập nhật: 2022-01-26: Update parameter/example/response; 2021-10-13: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_name` | string | ✔ | name of item |
| `cover_image_id` | int |  | Cover image id of item |
| `category_id` | int | ✔ | ID of category |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ attribute_list` | object[] | Attribute info list. |
| `↳↳ attribute_id` | int | ID of attribute. |
| `↳↳ attribute_value_list` | object[] | Value list of this attribute. |
| `↳↳↳ value_id` | int | ID of attribute value. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_weight_recommendation
`POST /api/v2/product/get_weight_recommendation` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get recommended weight. Now only BR shop support to use this api to get recommended weight.

Lịch sử cập nhật: 2023-05-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_name` | string | ✔ | Name of the item in local language. |
| `cover_image_id` | string | ✔ | Image id of first product image. |
| `category_id` | int | ✔ | Shopee's unique identifier for a category. |
| `attribute_list` | object[] | ✔ |  |
| `↳ attribute_id` | int | ✔ | The Identify of each attribute. |
| `↳ attribute_value_list` | object[] | ✔ |  |
| `↳↳ value_id` | int | ✔ | Unique identifier for value of this item attribute. |
| `↳↳ original_value_name` | string |  | Value name of this item attribute. |
| `↳↳ value_unit` | string |  | Value unit of this item attribute. |
| `brand_id` | int | ✔ | Id of brand. |
| `description_type` | string | ✔ | Type of description, values: See Data Definition- description_type (normal , extended). |
| `description` | string |  | If description_type is normal , Description information should be set by this field. |
| `description_info` | object |  | New description field. Only whitelist sellers can use it. If you use the field, please upload the description_type=extended. |
| `↳ extended_description` | object |  | If description_type is extended , Description information should be set by this field. |
| `↳↳ field_list` | object[] |  | Field of extended description. |
| `↳↳↳ field_type` | string |  | Type of extended description field, values: See Data Definition- description_field_type (text , image). |
| `↳↳↳ text` | string |  | If field_type is text, text information will be set by this field. |
| `↳↳↳ image_info` | object |  | If field_type is image, image information will be set by this field. |
| `↳↳↳↳ image_id` | string |  | Image id. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ normal_weight_range` | float[] | Recommended weight range, in kg. If there are no recommended results, return empty. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_size_chart_list 
`GET /api/v2/product/get_size_chart_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get new size chart list. Now only support local shop to use new size chart.

Lịch sử cập nhật: 2026-07-01: chat拼写错误，改为chart; 2023-05-26: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `category_id` | string | ✔ | category id under this shop |
| `page_size` | string | ✔ | the size of one page. Max=50. |
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the cursor can be some entry to start next call. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ size_chart_list` | object[] |  |
| `↳↳ size_chart_id` | string | ID of new size chart |
| `↳ total_count` | string | total number of new size chart under requested category_id |
| `↳ next_cursor` | string | if next_cursor has value, this value need set to next request.cursor |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_size_chart_detail
`GET /api/v2/product/get_size_chart_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get new size chart detail. Now only local shop support to use this api to get new size chart detail.

Lịch sử cập nhật: 2023-05-26: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `size_chart_id` | int | ✔ | ID of new size chart |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ size_chart_id` | int | ID of new size chart |
| `↳ size_chart_name` | string | name of new size chart |
| `↳ size_chart_table` | object | new size chart is a table format which include multiple columns. each column has column header (measurement) and multiple values (measurement value) of this column. |
| `↳↳ column_list` | object[] | column list of new size chart table. it include one column (measurement) and multiple values (measurement value) |
| `↳↳↳ measurement` | object | this is the column header which means a kind of measurement |
| `↳↳↳↳ input_type` | string | there are 3 kinds of measurement type: Single Dropdown, Input Single Number, Input Range Number. |
| `↳↳↳↳ display_name` | string | name of column header (measurement) |
| `↳↳↳↳ unit` | string | the unit of this size measurement. |
| `↳↳↳ measurement_value_list` | object[] | the list of measurement value |
| `↳↳↳↳ value` | float | if the input_type of measurement is single input number, measurement will have one value which is returned by this field. |
| `↳↳↳↳ min_value` | float | if the input_type of measurement is input range number, measurement will be a range which is returned by 2 fields: min_value and max_value. |
| `↳↳↳↳ max_value` | float | if the input_type of measurement is input range number, measurement will be a range which is returned by 2 fields: min_value and max_value. |
| `↳↳↳↳ option` | string | if the input_type of measurement is single dropdown, measurement will have one value which is returned by this field. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_item_violation_info
`GET /api/v2/product/get_item_violation_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

get item violation info

Lịch sử cập nhật: 2024-01-18: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id_list` | int[] | ✔ | item_id list; limit [0,50] |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_list` | object[] |  |
| `↳↳ item_id` | int | Shopee's unique identifier for an item. |
| `↳↳ item_name` | string | Name of the item. |
| `↳↳ item_status` | string | Enumerated type that defines the current status of the item. Applicable values: NORMAL, BANNED, UNLIST, SELLER_DELETE, SHOPEE_DELETE, REVIEWING. |
| `↳↳ deboost` | boolean | If deboost is true, means that the item's search ranking is lowered. |
| `↳↳ item_status_details` | object[] |  |
| `↳↳↳ violation_type` | string | Violation types defined by Shopee. Applicable values: Prohibited Listing Counterfeit and IP Infringement Spam Inappropriate Image Insufficient Information Mall Listing Improvement Other Listing Improvement |
| `↳↳↳ violation_reason` | string | The reason for violation. |
| `↳↳↳ suggestion` | string | Shopee provides you with suggestions for modifying items. |
| `↳↳↳ fix_deadline_time` | timestamp | Action required deadline. Empty if no deadline. |
| `↳↳↳ update_time` | timestamp | Latest update time. |
| `↳↳ deboost_details` | object[] |  |
| `↳↳↳ violation_type` | string | Violation types defined by Shopee. Applicable values: Prohibited Listing Counterfeit and IP Infringement Spam Inappropriate Image Insufficient Information Mall Listing Improvement Other Listing Improvement |
| `↳↳↳ violation_reason` | string | The reason for violation. |
| `↳↳↳ suggestion` | string | Shopee provides you with suggestions for modifying items. |
| `↳↳↳ suggested_category` | object[] |  |
| `↳↳↳↳ category_id` | int | ID for Shopee suggested category. |
| `↳↳↳↳ category_name` | string | Default name for Shopee suggested category. |
| `↳↳↳ fix_deadline_time` | timestamp | Action required deadline. Empty if no deadline. |
| `↳↳↳ update_time` | timestamp | Latest update time. |
| `↳↳ fail_error` | string | Indicate error type if one element hit error. |
| `↳↳ fail_message` | string | Indicate error details if one element hit error. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · System error, please try again later · Invalid request item_id · The item_id_list is required · Request items over limit, should be less than 50 · item_status does not match latest violation

## v2.product.get_variations
`GET /api/v2/product/get_variation_tree` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get the standardized tier variation defined by Shopee, which is currently a three-layer tree structure. The top layer is variations, the second layer is groups, groups are used to divide options, and the third layer is options.

Lịch sử cập nhật: 2024-03-26: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `category_id` | int | ✔ | Leaf category id |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | standardized tier variation data |
| `↳ standardise_variation_list` | object[] | standardized tier variation tree |
| `↳↳ variation_id` | int |  |
| `↳↳ variation_name` | string |  |
| `↳↳ variation_group_list` | object[] |  |
| `↳↳↳ variation_group_id` | int |  |
| `↳↳↳ variation_group_name` | string |  |
| `↳↳↳ variation_option_list` | object[] |  |
| `↳↳↳↳ variation_option_id` | int |  |
| `↳↳↳↳ variation_option_name` | string |  |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_all_vehicle_list
`GET /api/v2/product/get_all_vehicle_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this Open API to get all vehicle list.

Lịch sử cập nhật: 2024-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_size` | int64 | ✔ | The size of one page. Max=100 |
| `offset` | int64 |  | Specifies the starting entry of data to return in the current call. Default is 0, if data is more than one page, the offset can be some entry to start next call. |
| `language` | string |  | If language is not uploaded, the default language=en, the following are the languages supported by different markets SG: en ; MY: en / ms-my / zh-hans ; TH: en / th ; VN: en / vi ; PH: en ; TW: en / zh-hant ; ID: en / id ; BR: en / pt-br ; MX: en / es-mx ; CO: en/es-CO ; CL: en/es-CL. Note: For markets that have already launched global tree, Crossboard shop only support returning en and zh-hans language data |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ vehicle_list` | object[] |  |
| `↳↳ brand_id` | int64 | ID of the brand. |
| `↳↳ brand_name` | string | Name of the brand. |
| `↳↳ model_id` | int64 | ID of the model. |
| `↳↳ model_name` | string | Name of the model. |
| `↳↳ year_id` | int64 | ID of the year. |
| `↳↳ year_name` | string | Name of the year. |
| `↳↳ version_id` | int64 | ID of the version. |
| `↳↳ version_name` | string | Name of the version. |
| `↳ has_next_page` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of items. |
| `↳ next_offset` | int64 | If has_next_page is true, this value need set to next request offset |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_vehicle_list_by_compatibility_detail
`GET /api/v2/product/get_vehicle_list_by_compatibility_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this Open API to get vehicle list by brand, model, year, and version.

Lịch sử cập nhật: 2024-06-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `compatibility_details` | string | ✔ | To inform compatibility list, can be equal to Brand, Model, Year, or Version. Pass the compatibility_details="Brand" to get all brand list; Pass the compatibility_details="Model" and brand_id=1234 to get all model list under brand_id=1234; Pass the compatibility_details="Year" and brand_id=1234 and model_id=2345 to get all year list under brand_id=1234 and model_id=2345; Pass the compatibility_details="Version" and brand_id=1234 and model_id=2345 and year_id=3456 to get all version list under brand_id=1234 and model_id=2345 and year_id=3456. |
| `brand_id` | int64 |  | ID of the brand. |
| `model_id` | int64 |  | ID of the model. |
| `year_id` | int64 |  | ID of the year. |
| `language` | string |  | If language is not uploaded, the default language=en, the following are the languages supported by different markets SG: en ; MY: en / ms-my / zh-hans ; TH: en / th ; VN: en / vi ; PH: en ; TW: en / zh-hant ; ID: en / id ; BR: en / pt-br ; MX: en / es-mx ; CO: en/es-CO ; CL: en/es-CL. Note: For markets that have already launched global tree, Crossboard shop only support returning en and zh-hans language data. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ vehicle_list` | object[] |  |
| `↳↳ brand_id` | int64 | ID of the brand. |
| `↳↳ brand_name` | string | Name of the brand. |
| `↳↳ model_id` | int64 | ID of the model. |
| `↳↳ model_name` | string | Name of the model. |
| `↳↳ year_id` | int64 | ID of the year. |
| `↳↳ year_name` | string | Name of the year. |
| `↳↳ version_id` | int64 | ID of the version. |
| `↳↳ version_name` | string | Name of the version. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_item_content_diagnosis_result
`POST /api/v2/product/get_item_content_diagnosis_result` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get the content quality details (including content quality level, content issues, and system suggestions) for specific product list.

Lịch sử cập nhật: 2024-08-14: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id_list` | int64[] | ✔ | item_id list; limit [1,48] |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ success_item_list` | object[] |  |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ quality_level` | int32 | Item's latest content quality level. Applicable values: 0: NONE (No quality level for item in SELLER_DELETE / SHOPEE_DELETE / BANNED status) 1: TO_BE_IMPROVED 2: QUALIFIED 3: EXCELLENT |
| `↳↳ unfinished_task` | object[] |  |
| `↳↳↳ issue_type` | int32 | Item's content issue. Applicable values: 1: TOO_FEW_IMAGES 2: WRONG_CATEGORY 3: TOO_FEW_ATTRIBUTES_FOR_QUALIFIED 4: LACK_OF_SIZE_CHART 5: LACK_OF_STANDARD_VARIATION 6: LACK_BRAND 7: TOO_SHORT_DESCRIPTION 8: TOO_SHORT_OR_TOO_LONG_NAME 9: WRONG_WEIGHT 10: LACK_OF_VIDEO 11: TOO_FEW_ATTRIBUTES_FOR_EXCELLENT |
| `↳↳↳ suggestion` | string | System suggestion for item's content issue. Applicable values: Add at least 3 images Adopt suggested category Add at least 1 attributes Add size chart Adopt the color or size variation Add brand info Add at least 100 characters or 1 image for desc Add characters for name to 25~100 Adopt suggested weight Add video Add at least 3 attributes |
| `↳ failure_item_list` | object[] |  |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ failed_reason` | string | Item's failure reason. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway · Invalid item_id_list, please verify the ID and try again

## v2.product.get_item_list_by_content_diagnosis
`POST /api/v2/product/get_item_list_by_content_diagnosis` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Query the list of products and their content quality details by content quality level or content issues.

Lịch sử cập nhật: 2024-08-14: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_size` | int32 | ✔ | the size of one page. Max=48 |
| `offset` | string |  | Specifies the starting entry of data to return in the current call. Default is empty. if data is more than one page, the offset can be some entry to start next call. |
| `quality_level` | int32[] |  | Item's latest content quality level. Applicable values: 1: TO_BE_IMPROVED 2: QUALIFIED 3: EXCELLENT |
| `issue_type` | int32[] |  | Item's content issue. Applicable values: 1: TOO_FEW_IMAGES 2: WRONG_CATEGORY 3: TOO_FEW_ATTRIBUTES_FOR_QUALIFIED 4: LACK_OF_SIZE_CHART 5: LACK_OF_STANDARD_VARIATION 6: LACK_BRAND 7: TOO_SHORT_DESCRIPTION 8: TOO_SHORT_OR_TOO_LONG_NAME 9: WRONG_WEIGHT 10: LACK_OF_VIDEO 11: TOO_FEW_ATTRIBUTES_FOR_EXCELLENT If you need to pass both quality_level and issue_type, the logic are as follows: - When quality_level is 1, issue_type can only be 1, 2, 3, 4, 5 - When quality_level is 2, issue_type can only be 6, 7, 8, 9, 10, 11 - When quality_level is 3, issue_type can only be empty |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_list` | object[] |  |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ quality_level` | int32 | Item's latest content quality level. Applicable values: 0: NONE (No quality level for item in SELLER_DELETE / SHOPEE_DELETE / BANNED status) 1: TO_BE_IMPROVED 2: QUALIFIED 3: EXCELLENT |
| `↳↳ unfinished_task` | object[] |  |
| `↳↳↳ issue_type` | int32 | Item's content issue. Applicable values: 1: TOO_FEW_IMAGES 2: WRONG_CATEGORY 3: TOO_FEW_ATTRIBUTES_FOR_QUALIFIED 4: LACK_OF_SIZE_CHART 5: LACK_OF_STANDARD_VARIATION 6: LACK_BRAND 7: TOO_SHORT_DESCRIPTION 8: TOO_SHORT_OR_TOO_LONG_NAME 9: WRONG_WEIGHT 10: LACK_OF_VIDEO 11: TOO_FEW_ATTRIBUTES_FOR_EXCELLENT |
| `↳↳↳ suggestion` | string | System suggestion for item's content issue. Applicable values: Add at least 3 images Adopt suggested category Add at least 1 attributes Add size chart Adopt the color or size variation Add brand info Add at least 100 characters or 1 image for desc Add characters for name to 25~100 Adopt suggested weight Add video Add at least 3 attributes |
| `↳ total_count` | int64 | Total num of items match condition. |
| `↳ has_next_page` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of items. |
| `↳ next_offset` | string | If has_next_page is true, this value need set to next request.offset |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_kit_item_limit
`GET /api/v2/product/get_kit_item_limit` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get the limit of Kit item.

Lịch sử cập nhật: 2024-10-18: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `category_id` | int64 |  | Shopee's unique identifier for a category. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ price_limit` | object |  |
| `↳↳ min_limit` | float | Item price max limit. |
| `↳↳ max_limit` | float | Item price min limit. |
| `↳ item_name_length_limit` | object |  |
| `↳↳ min_limit` | int64 | Item name length min limit. |
| `↳↳ max_limit` | int64 | Item name length max limit. |
| `↳ item_image_count_limit` | object |  |
| `↳↳ min_limit` | int64 | Item image count min limit. |
| `↳↳ max_limit` | int64 | Item image count max limit. |
| `↳ description_limit` | object |  |
| `↳↳ description_length_min` | int64 | Item description length min limit. |
| `↳↳ description_length_max` | int64 | length max limit for item extended description text part. |
| `↳↳ description_text_length_min` | int64 | length min limit for item extended description text part, when one of the minimum limits for image and text is reached, the item can be added or updated successfully. |
| `↳↳ description_text_length_max` | int64 | length max limit for item extended description text part |
| `↳↳ description_image_num_min` | int64 | length min limit for item extended description image num, when one of the minimum limits for image and text is reached, the item can be added or updated successfully. |
| `↳↳ description_image_num_max` | int64 | length max limit for item extended description image num. |
| `↳↳ description_image_width_min` | int64 | length min limit for item extended description image width. |
| `↳↳ description_image_height_min` | int64 | length min limit for item extended description image hight. |
| `↳↳ description_image_aspect_ratio_min` | float | length min limit for item extended description image aspect ( aspect_ratio= image width / image hight ). |
| `↳↳ description_image_aspect_ratio_max` | float | length max limit for item extended description image aspect ( aspect_ratio= image width / image hight ). |
| `↳ tier_variation_name_length_limit` | object |  |
| `↳↳ min_limit` | int32 | Item tier variation name length min limit. |
| `↳↳ max_limit` | int32 | Item tier variation name length max limit. |
| `↳ tier_variation_option_length_limit` | object |  |
| `↳↳ min_limit` | int32 | Item tier variation option length min limit. |
| `↳↳ max_limit` | int32 | Item tier variation option length max limit. |
| `↳ weight_limit` | object |  |
| `↳↳ weight_mandatory` | boolean | Whether weight is mandatory or not for the category. |
| `↳ dimension_limit` | object |  |
| `↳↳ dimension_mandatory` | boolean | Whether dimension is mandatory or not for the category. |
| `↳ dts_limit` | object |  |
| `↳↳ non_pre_order_days_to_ship` | int32 | Days to ship for non pre-order products. |
| `↳↳ support_pre_order` | boolean | Whether support pre_order for the category. |
| `↳↳ days_to_ship_limit` | object | Days to ship for pre-order products. |
| `↳↳↳ min_limit` | int32 | Min limit of days to ship for pre-order products. |
| `↳↳↳ max_limit` | int32 | Max limit of days to ship for pre-order products. |
| `↳ component_count_limit_of_single_model` | object |  |
| `↳↳ min_limit` | int32 | Item count min limit that each kit variations support. |
| `↳↳ max_limit` | int32 | Item count max limit that each kit variations support. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.add_kit_item
`POST /api/v2/product/add_kit_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Create the kit item by selecting multiple items and setting main component and quantity per kit.

Lịch sử cập nhật: 2024-10-18: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_setting` | object | ✔ |  |
| `↳ item_name` | string | ✔ | The name of this kit item. |
| `↳ images` | object | ✔ | Item images with 1:1 ratio. |
| `↳↳ image_id_list` | string[] | ✔ | ID of image. |
| `↳ long_images` | object |  | Item images with 3:4 ratio. |
| `↳↳ image_id_list` | string[] | ✔ | ID of image. |
| `↳ video_upload_id` | string[] |  | Video upload ID returned from video uploading API. Only accept one video_upload_id. |
| `↳ description` | string |  | If description_type is normal, description information should be set by this field. |
| `↳ description_info` | object |  | Rich text description field. Only whitelist sellers can use it. If you use the field, please upload the description_type=extended otherwise api will return error. If you don't use this field, you don't need to upload the description_type or upload description_type=normal |
| `↳↳ extended_description` | object | ✔ | If description_type is extended , Description information should be set by this field. |
| `↳↳↳ field_list` | object[] | ✔ | Field of extended description. |
| `↳↳↳↳ field_type` | string | ✔ | Type of extended description field. See Data Definition- description_field_type (text , image). |
| `↳↳↳↳ text` | string | ✔ | If field_type is text, text information will be set by this field. |
| `↳↳↳↳ image_info` | object |  | If field_type is image, image will be set by this field. |
| `↳↳↳↳↳ image_id` | string | ✔ | Image id. |
| `↳ description_type` | string | ✔ | See Data Definition- description_type (normal , extended). If you want to use extended_description, this field must be inputed. |
| `↳ logistic_info` | object[] | ✔ | Logistic channel setting. |
| `↳↳ logistic_id` | int64 | ✔ | ID of the channel. |
| `↳↳ enabled` | boolean | ✔ | Whether channel is enabled for this kit item. |
| `↳↳ shipping_fee` | float |  | Shipping fee. Only needed when logistics fee_type = CUSTOM_PRICE. |
| `↳↳ size_id` | int64 |  | Size ID. Only needed when logistic fee_type = SIZE_SELECTION. |
| `↳↳ is_free` | boolean |  | Whether cover shipping fee for buyer. |
| `↳ unlisted` | boolean |  | Unlist or not. |
| `↳ item_sku` | string |  | SKU tag of item |
| `↳ weight` | float | ✔ | The weight of this kit item, the unit is KG. |
| `↳ dimension` | object |  | The dimension of this kit item. |
| `↳↳ package_length` | int32 | ✔ | The length of package for this kit item, the unit is CM. |
| `↳↳ package_width` | int32 | ✔ | The width of package for this kit item, the unit is CM. |
| `↳↳ package_height` | int32 | ✔ | The height of package for this kit item, the unit is CM. |
| `↳ pre_order` | object |  | Pre order setting. |
| `↳↳ is_pre_order` | boolean | ✔ | Whether kit item is pre order. |
| `↳↳ days_to_ship` | int32 |  | The guaranteed days to ship orders. Please get the days_to_ship range from get_kit_item_limit api. |
| `↳ model_list` | object[] | ✔ | Model info list, model number at most 9. |
| `↳↳ tier_index` | int32[] | ✔ | Tier index of this kit model. |
| `↳↳ model_sku` | string |  | Seller SKU of this kit model, model_sku length information needs to be no more than 100 characters. |
| `↳↳ original_price` | float | ✔ | Original price of this kit model. |
| `↳↳ component_list` | object[] | ✔ | Please get the amount of item/model that one kit model support from get_kit_item_limit. |
| `↳↳↳ component_item_id` | int64 | ✔ | ID of the item that composes this kit model. |
| `↳↳↳ component_model_id` | int64 |  | ID of the model that composes this kit model. |
| `↳↳↳ quantity` | int32 | ✔ | The amount of the item/model that composes this kit model. |
| `↳↳↳ main_component` | boolean |  | Whether this item/model is the main component for this kit. One kit item can only have one item/model as main component. |
| `↳ tier_variation_list` | object[] | ✔ | Tier variation info list. Only support one tier variation, and each kit item can have from 1 to 9 kit variations. |
| `↳↳ name` | string |  | Tier variation name. |
| `↳↳ option_list` | object[] | ✔ | Tier variation option info list. |
| `↳↳↳ option` | string | ✔ | Option name. |
| `↳↳↳ image` | object |  | Option image. |
| `↳↳↳↳ image_id` | string | ✔ | ID of image. If you choose to define, you need to define an image for all options. |
| `sync_setting` | object |  |  |
| `↳ auto_sync_dts` | boolean | ✔ | Auto sync the pre_order setting from main component or not. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_id` | int64 |  |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.update_kit_item
`POST /api/v2/product/update_kit_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Update the kit basic information and kit components, only support adding kit variations and updating existing kit variation’s image, price, and model_sku, don’t support deleting existing kit variations and updating the items, main component and quantity per kit of existing kit variations.

Lịch sử cập nhật: 2024-10-18: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 | ✔ | ID of kit item. |
| `item_setting` | object |  |  |
| `↳ item_name` | string |  | The name of this kit item. |
| `↳ images` | object |  | Item images with 1:1 ratio. |
| `↳↳ image_id_list` | string[] | ✔ | ID of image. |
| `↳ long_images` | object |  | Item images with 3:4 ratio. |
| `↳↳ image_id_list` | string[] | ✔ | ID of image. |
| `↳ video_upload_id` | string[] |  | Video upload ID returned from video uploading API. Only accept one video_upload_id. |
| `↳ description` | string |  | If description_type is normal, description information should be set by this field. |
| `↳ description_info` | object |  | Rich text description field. Only whitelist sellers can use it. If you use the field, please upload the description_type=extended otherwise api will return error. If you don't use this field, you don't need to upload the description_type or upload description_type=normal |
| `↳↳ extended_description` | object | ✔ | If description_type is extended , Description information should be set by this field. |
| `↳↳↳ field_list` | object[] | ✔ | Field of extended description. |
| `↳↳↳↳ field_type` | string | ✔ | Type of extended description field. See Data Definition- description_field_type (text , image). |
| `↳↳↳↳ text` | string | ✔ | If field_type is text, text information will be set by this field. |
| `↳↳↳↳ image_info` | object |  | If field_type is image, image will be set by this field. |
| `↳↳↳↳↳ image_id` | string | ✔ | Image id. |
| `↳ description_type` | string |  | See Data Definition- description_type (normal , extended). If you want to use extended_description, this field must be inputed. |
| `↳ logistic_info` | object[] |  | Logistic channel setting. |
| `↳↳ logistic_id` | int64 | ✔ | ID of the channel. |
| `↳↳ enabled` | boolean | ✔ | Whether channel is enabled for this kit item. |
| `↳↳ shipping_fee` | float |  | Shipping fee. Only needed when logistics fee_type = CUSTOM_PRICE. |
| `↳↳ size_id` | int64 |  | Size ID. Only needed when logistic fee_type = SIZE_SELECTION. |
| `↳↳ is_free` | boolean |  | Whether cover shipping fee for buyer. |
| `↳ unlisted` | boolean |  | Unlist or not. |
| `↳ item_sku` | string |  | SKU tag of item |
| `↳ weight` | float |  | The weight of this kit item, the unit is KG. |
| `↳ dimension` | object |  | The dimension of this kit item. |
| `↳↳ package_length` | int32 | ✔ | The length of package for this kit item, the unit is CM. |
| `↳↳ package_width` | int32 | ✔ | The width of package for this kit item, the unit is CM. |
| `↳↳ package_height` | int32 | ✔ | The height of package for this kit item, the unit is CM. |
| `↳ pre_order` | object |  | Pre order setting. |
| `↳↳ is_pre_order` | boolean | ✔ | Whether kit item is pre order. |
| `↳↳ days_to_ship` | int64 |  | The guaranteed days to ship orders. Please get the days_to_ship range from get_kit_item_limit api. |
| `↳ model_list` | object[] |  | Model info list, model number at most 9. |
| `↳↳ model_id` | int64 |  | ID of this kit model. |
| `↳↳ tier_index` | int64[] | ✔ | Tier index of this kit model. |
| `↳↳ model_sku` | string |  | Seller SKU of this kit model, model_sku length information needs to be no more than 100 characters. |
| `↳↳ original_price` | float |  | Original price of this kit model. |
| `↳↳ component_list` | object[] |  | Please get the amount of item/model that one kit model support from get_kit_item_limit. |
| `↳↳↳ component_item_id` | int64 | ✔ | ID of the item that composes this kit model. |
| `↳↳↳ component_model_id` | int64 |  | ID of the model that composes this kit model. |
| `↳↳↳ quantity` | int64 | ✔ | The amount of the item/model that composes this kit model. |
| `↳↳↳ main_component` | boolean |  | Whether this item/model is the main component for this kit. One kit item can only have one item/model as main component. |
| `↳ tier_variation_list` | object[] |  | Tier variation info list. Only support one tier variation, and each kit item can have from 1 to 9 kit variations. |
| `↳↳ name` | string |  | Tier variation name. |
| `↳↳ option_list` | object[] | ✔ | Tier variation option info list. |
| `↳↳↳ option` | string | ✔ | Option name. |
| `↳↳↳ image` | object |  | Option image. |
| `↳↳↳↳ image_id` | string | ✔ | ID of image. If you choose to define, you need to define an image for all options. |
| `sync_setting` | object |  |  |
| `↳ auto_sync_dts` | boolean | ✔ | Auto sync the pre_order setting from main component or not. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_kit_item_info
`GET /api/v2/product/get_kit_item_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get the kit basic information and kit components.

Lịch sử cập nhật: 2024-10-18: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 | ✔ | ID of kit item. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ product_info` | object |  |
| `↳↳ item_id` | int64 | ID of this kit item. |
| `↳↳ item_name` | string | The name of this kit item. |
| `↳↳ category_id` | int64[] | The category of this kit item, sync from the category of the main component of this kit item. |
| `↳↳ item_status` | string | Enumerated type that defines the current status of the item. Applicable values: NORMAL, BANNED, UNLIST, SELLER_DELETE, SHOPEE_DELETE, REVIEWING. |
| `↳↳ item_sku` | string | An item SKU (stock keeping unit) is an identifier defined by a seller, sometimes called parent SKU. Item SKU can be assigned to an item in Shopee Listings. |
| `↳↳ images` | object | Item images with 1:1 ratio. |
| `↳↳↳ image_id_list` | string[] | List of image id. |
| `↳↳↳ image_url_list` | string[] | List of image url. |
| `↳↳↳ image_ratio` | string | 1:1 |
| `↳↳ long_images` | object | Item images with 3:4 ratio. |
| `↳↳↳ image_id_list` | string[] | List of image id. |
| `↳↳↳ image_url_list` | string[] | List of image url. |
| `↳↳↳ image_ratio` | string | 3:4 |
| `↳↳ description_info` | object | Rich text description field. Only whitelist sellers can use it. |
| `↳↳↳ extended_description` | object | If description_type is extended , Description information will be returned through this field. |
| `↳↳↳↳ field_list` | object[] | Field of extended description. |
| `↳↳↳↳↳ field_type` | string | Type of extended description field. See Data Definition- description_field_type (text , image). |
| `↳↳↳↳↳ text` | string | If field_type is text, text information will be returned through this field. |
| `↳↳↳↳↳ image_info` | object | If field_type is image, image will be returned through this field. |
| `↳↳↳↳↳↳ image_id` | string | Image id. |
| `↳↳↳↳↳↳ image_url` | string | Image url. |
| `↳↳ description` | string | If description_type is normal, description information will be returned through this field, else description will be empty. |
| `↳↳ description_type` | string | Type of description : values: See Data Definition- description_type (normal , extended). |
| `↳↳ video_list` | object | Info of video list. |
| `↳↳↳ video_url` | string | Url of video. |
| `↳↳↳ thumbnail_url` | string | Thumbnail of video. |
| `↳↳↳ duration` | int32 | Duration of video. |
| `↳↳ attributes` | object[] | The attributes of this kit item, sync from the attributes of the main component of this kit item. |
| `↳↳↳ attribute_id` | int64 | The Identify of each attribute. |
| `↳↳↳ original_attribute_name` | string | The name of each attribute. |
| `↳↳↳ attribute_value_list` | object[] |  |
| `↳↳↳↳ value_id` | int64 | Unique identifier for value of this item attribute. |
| `↳↳↳↳ original_value_name` | string | Value name of this item attribute. |
| `↳↳↳↳ value_unit` | string | Value unit of this item attribute. |
| `↳↳ weight` | string | The weight of this kit item, the unit is KG. |
| `↳↳ dimension` | object | The dimension of this kit item. |
| `↳↳↳ package_length` | int32 | The length of package for this item, the unit is CM. |
| `↳↳↳ package_width` | int32 | The width of package for this item, the unit is CM. |
| `↳↳↳ package_height` | int32 | The height of package for this item, the unit is CM. |
| `↳↳ brand_info` | object | The brand of this kit item, sync from the brand of the main component of this kit item. |
| `↳↳↳ brand_id` | int64 | Id of brand. |
| `↳↳↳ original_brand_name` | string | Original name of brand. |
| `↳↳ model_list` | object[] | Model info list, model number at most 9. |
| `↳↳↳ model_id` | int64 | ID of this kit model. |
| `↳↳↳ model_sku` | int64 | Seller SKU of this kit model. |
| `↳↳↳ original_price` | float | Original price of this kit model. |
| `↳↳↳ tier_index` | int32[] | Tier index of this kit model. |
| `↳↳↳ component_list` | object[] |  |
| `↳↳↳↳ component_item_id` | int64 | ID of the item that composes this kit model. |
| `↳↳↳↳ component_item_name` | string | Name of the item that composes this kit model. |
| `↳↳↳↳ component_model_id` | int64 | ID of the model that composes this kit model. |
| `↳↳↳↳ component_model_name` | string | Name of the model that composes this kit model. |
| `↳↳↳↳ quantity` | int32 | The amount of the item/model that composes this kit model. |
| `↳↳↳↳ main_component` | boolean | Whether this item/model is the main component for this kit. |
| `↳↳↳↳ component_item_or_model_image` | string |  |
| `↳↳↳↳ component_item_or_model_sku` | string |  |
| `↳↳ pre_order_info` | object |  |
| `↳↳↳ is_pre_order` | boolean |  |
| `↳↳↳ days_to_ship` | int32 |  |
| `↳↳ tier_variation_list` | object[] | Variation config of item. |
| `↳↳↳ name` | string | Variation name. |
| `↳↳↳ option_list` | object[] | Option list. |
| `↳↳↳↳ option` | string | Option name. |
| `↳↳↳↳ image` | object[] |  |
| `↳↳↳↳↳ image_id` | string | Id of image. |
| `↳↳↳↳↳ image_url` | string | Url of image. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_aitem_by_pitem_id
`GET /api/v2/product/get_aitem_by_pitem_id` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get the list of A Items under SIP Affiliate Shop corresponding to P Items under SIP Primary Shop.

Lịch sử cập nhật: 2024-11-01: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `pitem_id` | int64 | ✔ | ID of item under SIP Primary Shop. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ aitem_list` | object[] |  |
| `↳↳ ashop_id` | int64 | ID of SIP Affiliate Shop. |
| `↳↳ ashop_region` | string | Region of SIP Affiliate Shop. |
| `↳↳ aitem_id` | int64 | ID of item under SIP Affiliate Shop corresponding to the P Item. |
| `↳↳ model_mapping_list` | object[] | If the P Item does not have model, then the model_mapping_list will not be returned. |
| `↳↳↳ pmodel_id` | int64 | ID of model for the P Item. |
| `↳↳↳ amodel_id` | int64 | ID of model for the A Item. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.search_attribute_value_list
`POST /api/v2/product/search_attribute_value_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

this api is for searching attribute value list for attribute with support_search_value flag

Lịch sử cập nhật: 2025-01-13: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `attribute_id` | int32 | ✔ |  |
| `value_name` | string |  | search the keywords of the attributes value |
| `cursor` | int64 | ✔ |  |
| `limit` | int64 | ✔ | The range is 1 to 100 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `msg` | string |  |
| `debug_message` | string |  |
| `response` | object |  |
| `↳ value_list` | object[] |  |
| `↳↳ value_id` | int64 | The ID of the predefined attributes value. |
| `↳↳ value_name` | string | The name of the predefined attributes value. |
| `↳ page_info` | object |  |
| `↳↳ cursor` | int64 |  |
| `↳↳ has_next` | boolean |  |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_main_item_list
`GET /api/v2/product/get_main_item_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

get main item by direct item.

Lịch sử cập nhật: 2025-03-27: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `direct_item_id` | int64[] | ✔ | Item id of direct shop. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ list` | object[] |  |
| `↳↳ direct_item_id` | int64 | Item id of direct shop. |
| `↳↳ main_shop_id` | int64 | Id of main shop. |
| `↳↳ main_item_id` | int64 | Item id of main shop. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_direct_item_list
`GET /api/v2/product/get_direct_item_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

get direct item by main item.

Lịch sử cập nhật: 2025-03-27: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `main_item_id` | int64[] | ✔ | Item id of main shop. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ list` | object[] |  |
| `↳↳ main_item_id` | int64 | Item id of main shop. |
| `↳↳ direct_item_list` | object[] |  |
| `↳↳↳ direct_shop_id` | int64 | Id of direct shop. |
| `↳↳↳ direct_item_id` | int64 | Item id of direct shop. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_direct_shop_recommended_price
`GET /api/v2/product/get_direct_shop_recommended_price` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

get recommend price for direct shop.

Lịch sử cập nhật: 2025-03-27: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `main_item_id` | int64 | ✔ |  |
| `direct_shop_regions` | string[] | ✔ | Direct shop regions. |
| `category_id` | int64 |  | Main_item's category. |
| `model_list` | object[] |  | Main model model info. |
| `↳ model_id` | int64 |  | Id of main model. |
| `↳ tier_index` | int64[] |  | Tier index of main model. Index starts from 0. |
| `↳ input_price` | int64 |  |  |
| `↳ weight` | float |  |  |
| `enabled_channel_id_list` | int64[] |  | direct shop enabled channel |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ direct_item_price` | object[] |  |
| `↳↳ shop_id` | int64 | Id of direct shop. |
| `↳↳ region` | string | Region of direct shop. |
| `↳↳ hidden_price` | float |  |
| `↳↳ item_model_price_list` | object[] |  |
| `↳↳↳ model_id` | int64 | Id of main model. |
| `↳↳↳ tier_index` | int64[] | Tier index of main model. Index starts from 0. |
| `↳↳↳ price` | float |  |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_product_certification_rule
`POST /api/v2/product/get_product_certification_rule` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get product certification rule

Lịch sử cập nhật: 2025-04-23: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `attribute_list` | object[] |  | Item attributes. |
| `↳ attribute_id` | int64 | ✔ | ID of attribute. |
| `↳ attribute_value_list` | object[] |  |  |
| `↳↳ value_id` | int64 | ✔ | ID of attribute value. In the following cases, the value id needs to be uploaded as 0, and original_value_name is mandatory, needs to be filled in customized value. (1) AttributeInputType is TEXT_FILED; (2) AttributeInputType is COMBO_BOX or MULTIPLE_SELECT_COMBO_BOX, and the seller want to fill in a customized value. |
| `↳↳ original_value_name` | string |  | Value name. original_value_name from produc.get_attributes api. If value id=0, this field is required. If AttributeType is DATE_TYPE or TIMESTAMP_TYPE, you can upload timestamp(string type) as the original_value_name. |
| `↳↳ value_unit` | string |  | Unit of attribute value (quantitative attribute only). |
| `category_id` | int64 |  | ID of category. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ certification_rule_list` | object[] | New description field. Only whitelist sellers can use it. If you use the field, please upload the description_type=extended otherwise api will return error. If you don't use this field, you don't need to upload the description_type or upload description_type=normal |
| `↳↳ certification_type` | int64 | type of certification; always=1 |
| `↳↳ is_mandatory` | boolean | if this type of certification is mandatory for product |
| `↳↳ permit_id` | int32 |  |
| `↳↳ name` | string | Permit Type Name |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

##  v2.product.publish_item_to_outlet_shop
`POST /api/v2/product/publish_item_to_outlet_shop` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

This API supports publishing an existing item from the mart shop to an outlet shop.

Lịch sử cập nhật: 2025-12-26: add "purchase limit info" request field; 2025-05-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `mart_item_id` | int64 | ✔ | The item ID of the product in the Mart shop to be published to the outlet shop. |
| `outlet_shop_id` | int64 | ✔ | The shop ID of the outlet shop where the product will be published. |
| `publish_item` | object | ✔ | Configuration details for publishing the product to the outlet shop, including model mapping, pricing, stock, logistics, and purchase limits. |
| `↳ outlet_item_id` | int64 |  |  |
| `↳ model` | object |  | A list of models to be published to the outlet shop, mapped from the corresponding Mart shop models. |
| `↳↳ relate_mart_model_id` | int64 | ✔ | The model ID in the Mart shop that this outlet model is associated with. model_id=0 for items with only the default model(no variations) |
| `↳↳ model_status` | string |  | The status of model. |
| `↳↳ original_price` | float |  | The original price of the model. |
| `↳↳ seller_stock` | object[] |  | Stock information for the model, set in outlet sku level. |
| `↳↳↳ location_id` | string |  | The location ID where the stock is stored. |
| `↳↳↳ stock` | int32 | ✔ | The available stock quantity for the model. |
| `↳↳ pre_order` | object |  | set in outlet sku level |
| `↳↳↳ is_pre_order` | boolean | ✔ | Indicates whether the model is sold as a pre-order item. |
| `↳↳↳ days_to_ship` | int32 |  | The number of days required to ship the item after an order is placed. |
| `↳ logistic_info` | object[] |  | Logistic channel setting; can set for each outlet shop. |
| `↳↳ logistic_id` | int64 | ✔ | The logistics channel ID used for shipping the item. |
| `↳↳ enabled` | boolean | ✔ | Indicates whether the logistics channel is enabled for the item. |
| `↳↳ shipping_fee` | float |  | The shipping fee charged to the buyer for this logistics channel. |
| `↳↳ size_id` | int64 |  | The parcel size ID used to calculate shipping fees. |
| `↳↳ is_free` | boolean |  | Indicates whether free shipping is applied for this logistics channel. |
| `↳ purchase_limit_info` | object |  | Purchase quantity limits applied to the item in the outlet shop. |
| `↳↳ min_purchase_limit` | int32 | ✔ | The minimum quantity that a buyer is allowed to purchase per order. |
| `↳↳ max_purchase_limit` | object | ✔ | The maximum purchase quantity configuration for the item. |
| `↳↳↳ purchase_limit` | int32 | ✔ | The maximum quantity that a buyer is allowed to purchase per order. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_id` | int64 | The outlet item ID. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.get_mart_item_mapping_by_id
`POST /api/v2/product/get_mart_item_mapping_by_id` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get the mapping information between a Mart item and its corresponding outlet item by item ID.

Lịch sử cập nhật: 2025-05-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `mart_item_id` | int64 | ✔ | The item ID of the item in the Mart shop. |
| `outlet_shop_id_list` | int64[] | ✔ | A list of outlet shop IDs used to filter the mapping results. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_mapping_list` | object[] | A list of item mapping records between the Mart item and its corresponding outlet items. |
| `↳↳ mart_item_id` | int64 | The item ID of the item in the Mart shop. |
| `↳↳ outlet_item_id` | int64 | The item ID of the corresponding item in the outlet shop. |
| `↳↳ model_mapping` | object[] | The mapping relationship between Mart models and outlet models under the mapped items. |
| `↳↳↳ mart_model_id` | int64 | The model ID of the product in the Mart shop. |
| `↳↳↳ outlet_model_id` | int64 | The model ID of the corresponding product in the outlet shop. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.search_unpackaged_model_list
`POST /api/v2/product/search_unpackaged_model_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Order Management

Use this API to retrieve Unpackaged SKU ID information for items that toggle on logistics channel 30029.

Lịch sử cập nhật: 2025-07-07: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_size` | int32 | ✔ | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call). This integer value is used to specify the maximum number of entries to return in a single "page" of data. The limit of page_size if between 1 and 48. |
| `cursor` | string |  | Specifies the starting entry of data to return in the current call. Default is "". If data is more than one page, the cursor can be some entry to start next call. |
| `item_id` | int64 |  | Shopee's unique identifier for an item. |
| `item_name` | string |  | Name of the item. |
| `model_id` | int64 |  | Shopee's unique identifier for a model under item. |
| `unpackaged_sku_id` | string |  | Unpackaged SKU ID of the model. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ total_count` | int32 | Total number of models that match the condition. |
| `↳ next_cursor` | string | Pass the next_cursor in the next request as cursor to get the next page data. |
| `↳ model_list` | object[] | List of models that match the condition. |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ item_name` | string | Name of the item. |
| `↳↳ model_id` | int64 | Shopee's unique identifier for a model under item. 0 for no model item. |
| `↳↳ unpackaged_sku_id` | string | Unpackaged SKU ID of the model. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.product.generate_kit_image
`POST /api/v2/product/generate_kit_image` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

This API generates a single consolidated image by combining the cover images of all selected items. It is typically used to create a unified product display image for kits or bundles.

Lịch sử cập nhật: 2025-09-26: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `component_list` | object[] | ✔ | Please send up until 9 components. |
| `↳ component_item_id` | int64 | ✔ | ID of the item that composes this kit model. |
| `↳ component_model_id` | int64 |  | ID of the model that composes this kit model. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ kit_image` | string | generated kit image |

## v2.product.get_mart_item_by_outlet_item_id
`POST /api/v2/product/get_mart_item_by_outlet_item_id` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Get the mapping information between a Mart item and its corresponding outlet item by outlet item ID.

Lịch sử cập nhật: 2026-05-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `outlet_item_id` | int64 | ✔ | The item ID of the item in the outlet shop. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_mapping_list` | object[] | A list of item mapping records between the Mart item and its corresponding outlet items. |
| `↳↳ mart_item_id` | int64 | The item ID of the item in the Mart shop. |
| `↳↳ outlet_item_id` | int64 | The item ID of the corresponding item in the outlet shop. |
| `↳↳ model_mapping` | object[] | The mapping relationship between Mart models and outlet models under the mapped items. |
| `↳↳↳ mart_model_id` | int64 | The model ID of the product in the Mart shop. |
| `↳↳↳ outlet_model_id` | int64 | The model ID of the corresponding product in the outlet shop. |

## v2.product.batch_update_outlet_price
`POST /api/v2/product/batch_update_outlet_price` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Create asynchronous task to batch update outlet item's price

Lịch sử cập nhật: 2026-06-12: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_list` | object[] | ✔ | The item list to batch update price. The list size must be between 1 and 100. |
| `↳ outlet_shop_id` | int64 | ✔ | The shop ID of the Outlet shop. |
| `↳ item_id` | int64 | ✔ | The item ID of the item in the Outlet shop. |
| `↳ price_list` | object[] | ✔ | The price list of item models. The list size must be at least 1. |
| `↳↳ model_id` | int64 |  | The model ID of the product. Empty for item without model. |
| `↳↳ original_price` | float | ✔ | The original price to update. The value must be greater than 0. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ task_id` | int64 | The task ID of the batch update price task. |

## v2.product.batch_update_outlet_stock
`POST /api/v2/product/batch_update_outlet_stock` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Create asynchronous task to batch update outlet stock

Lịch sử cập nhật: 2026-06-12: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_list` | object[] | ✔ | The item list to batch update stock. The list size must be between 1 and 100. |
| `↳ outlet_shop_id` | int64 | ✔ | The shop ID of the Outlet shop. |
| `↳ item_id` | int64 | ✔ | The item ID of the item in the Outlet shop. |
| `↳ stock_list` | object[] | ✔ | The stock list of item models. The list size must be at least 1. |
| `↳↳ model_id` | int64 |  | The model ID of the product. Empty for item without model. |
| `↳↳ seller_stock` | object[] | ✔ | The seller stock by location. |
| `↳↳↳ location_id` | string |  | location id, you can get the location id from v2.shop.get_warehouse_detail api, if seller don't have any warehouse, you don't need to upload this field. |
| `↳↳↳ stock` | int32 | ✔ | The stock quantity of the location. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ task_id` | int64 | The task ID of the batch update stock task. |

## v2.product.get_batch_task_result
`GET /api/v2/product/get_batch_task_result` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Query batch task result

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `task_type` | int32 | ✔ | The task type. 1: price; 2: stock; 3: publish outlet; 4: add item. |
| `task_id` | int64 | ✔ | The task ID to query. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ publish_status` | int32 | The publish status. 1: ongoing; 2: finished. |
| `↳ success_list` | object[] | The batch task success records. |
| `↳↳ shop_id` | int64 | The shop ID |
| `↳↳ item_id` | int64 | The item ID of the item in the shop. |
| `↳↳ model_id` | int64 | The model ID of the model in the shop. |
| `↳ failed_list` | object[] | The batch task failed records. |
| `↳↳ shop_id` | int64 | The shop ID |
| `↳↳ item_id` | int64 | The item ID of the item in the shop. |
| `↳↳ model_id` | int64 | The model ID of the model in the shop. |
| `↳↳ failed_reason` | string | The failed reason. |

## v2.product.batch_add_item
`POST /api/v2/product/batch_add_item` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Create asynchronous task to batch add item

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_list` | object[] | ✔ | The item list to batch add. The list size must be between 1 and 100. |
| `↳ original_price` | float | ✔ | Item price |
| `↳ description` | string | ✔ | if description_type is normal , Description information should be set by this field. |
| `↳ weight` | float | ✔ | The weight of this item, the unit is KG. |
| `↳ item_name` | string | ✔ | Item name |
| `↳ item_status` | string |  | Item status, could be UNLIST or NORMAL |
| `↳ dimension` | object |  | The dimension of this item. |
| `↳↳ package_height` | int32 | ✔ | The height of package for this item, the unit is CM. |
| `↳↳ package_length` | int32 | ✔ | The length of package for this item, the unit is CM. |
| `↳↳ package_width` | int32 | ✔ | The width of package for this item, the unit is CM. |
| `↳ logistic_info` | object[] | ✔ | Logistic channel setting |
| `↳↳ size_id` | int32 |  | Size ID, If specify logistic fee_type is SIZE_SELECTION size_id is required. |
| `↳↳ shipping_fee` | float |  | Shipping fee, Only needed when logistics fee_type = CUSTOM_PRICE. |
| `↳↳ enabled` | boolean | ✔ | Whether channel is enabled for this item |
| `↳↳ logistic_id` | int32 | ✔ | ID of the channel |
| `↳↳ is_free` | boolean |  | Whether cover shipping fee for buyer |
| `↳ attribute_list` | object[] |  | This field is optional(expect Indonesia) depending on the specific attribute under different categories. Should call shopee.item.GetAttributes to get attribute first. Must contain all all mandatory attribute. |
| `↳↳ attribute_id` | int32 | ✔ | ID of attribute |
| `↳↳ attribute_value_list` | object[] |  |  |
| `↳↳↳ value_id` | int32 | ✔ | Value ID. In the following cases, the value id needs to be uploaded as 0, and original_value_name is mandatory, needs to be filled in customized value. (1) AttributeInputType is TEXT_FILED; (2) AttributeInputType is COMBO_BOX or MULTIPLE_SELECT_COMBO_BOX, and the seller want to fill in a customized value. |
| `↳↳↳ original_value_name` | string |  | Value name. original_value_name from product.get_attributes api. If value id=0, this field is required. If AttributeType is DATE_TYPE or TIMESTAMP_TYPE, you can upload timestamp(string type) as the original_value_name. |
| `↳↳↳ value_unit` | string |  | Unit of attribute value (quantitative attribute only). |
| `↳ category_id` | int32 | ✔ | ID of category |
| `↳ image` | object | ✔ | Item images |
| `↳↳ image_id_list` | string[] | ✔ | ID of image |
| `↳↳ image_ratio` | string |  | Ratio of image, OptionalAllowed ratios : "1:1" (default) "3:4" only applicable to whitelisted seller. |
| `↳ pre_order` | object |  | Pre order setting |
| `↳↳ is_pre_order` | boolean | ✔ | Whether item is pre order |
| `↳↳ days_to_ship` | int32 |  | The guaranteed days to ship orders. Please get the days_to_ship range from get_dts_limit api |
| `↳ item_sku` | string |  | SKU tag of item |
| `↳ condition` | string |  | Condition of item, could be USED or NEW |
| `↳ wholesale` | object[] |  | Wholesale setting |
| `↳↳ min_count` | int32 | ✔ | Minimum count of this tier |
| `↳↳ max_count` | int32 | ✔ | Maximum count of this tier |
| `↳↳ unit_price` | float | ✔ | Unit price of this tier |
| `↳ video_upload_id` | string[] |  | Video upload ID returned from video uploading API. Only accept one video_upload_id. |
| `↳ brand` | object |  |  |
| `↳↳ brand_id` | int32 | ✔ | Id of brand. |
| `↳↳ original_brand_name` | string | ✔ | Original name of brand( No Brand if not brand). |
| `↳ item_dangerous` | int32 |  | This field is only applicable for local sellers in Indonesia and Malaysia. Use this field to identify whether a product is a dangerous product. 0 for non-dangerous product and 1 for dangerous product. For more information, please visit the market's respective Seller Education Hub. |
| `↳ tax_info` | object |  | Tax information |
| `↳↳ ncm` | string |  | Mercosur Common Nomenclature, it is a convention between Mercosur member countries to easily recognize goods, services and productive factors negotiated among themselves. (BR region) NCM must have 8 digits, OR, if your item doesn't have a NCM enter the value "00" |
| `↳↳ same_state_cfop` | string |  | Tax Code of Operations and Installments for orders that seller and buyer are in the same state. It identifies a specific operation by category at the time of issuing the invoice.(BR region) |
| `↳↳ diff_state_cfop` | string |  | Tax Code of Operations and Installments for orders that seller and buyer are in different states. It identifies a specific operation by category at the time of issuing the invoice.(BR region) |
| `↳↳ csosn` | string |  | Code of Operation Status – Simples Nacional, code for company operations to identify the origin of the goods and the taxation regime of the operations.(BR region) |
| `↳↳ origin` | string |  | Product source, domestic or foreig (BR region). \|0 - National, except for those indicated in codes 3, 4, 5, and 8\| \|1 - Foreign: Direct import, except for that indicated in code 6\| \|2 - Foreign: Acquired in the domestic market, except for that indicated in code 7\| \|3 - National: Goods or products with Import Content greater than 40% and less than or equal to 70%\| \|4 - National: Produced in compliance with the basic production processes outlined in the legislations cited in the Agreements\| \|5 - National: Goods or products with Import Content less than or equal to 40%\| \|6 - Foreign: Direct import, without a national equivalent, listed by CAMEX and natural gas\| \|7 - Foreign: Acqu |
| `↳↳ cest` | string |  | Tax Replacement Specifying Code (CEST), to separate within the same NCM products that do or do not have ICMS tax substitution. (BR region) CEST must have 7 digits, OR, if your item doesn't have a CEST enter the value "00". |
| `↳↳ measure_unit` | string |  | (BR region) |
| `↳↳ tax_type` | int32 |  | tax_type only for TW whitelist shop. Shopee will referred Tax type when substitute sellers for issuing e-receipts to buyers. All variations share the same tax type. The meaning of value: 0: no tax type 1: tax-able 2: tax-free |
| `↳↳ pis` | string |  | Only for BR shop. PIS - Programa de Integração Social (Social Integration Program). It is a government tax to collect resources for the payment of unemployment insurance and other employee related rights. PIS % - the tax applied to this product |
| `↳↳ cofins` | string |  | Only for BR shop. COFINS – Contribuição para Financiamento da Seguridade Social (Contribution for Social Security Funding). It is a government tax to collect resources for public health system and social security. COFINS % - the tax applied to this product |
| `↳↳ icms_cst` | string |  | Only for BR shop. ICMS - Imposto sobre Circulação de Mercadorias e Serviços (Circulation of Goods and Services Tax). CST - Código da Situação Tributária (Tax Situation Code) is represented by a combination of 3 numbers with the purpose of demonstrating the origin of a product and determining the form of taxation that will apply to it. Therefore, each digit in the CST Table has a specific meaning: the first digit indicates the origin of the operation, the second digit represents the ICMS taxation on the operation and the third digit provides additional information about the form of taxation. |
| `↳↳ pis_cofins_cst` | string |  | Only for BR shop. The CST PIS/Cofins is a code on the Electronic Invoice (NF-e) that identifies the tax situation of PIS (Programa de Integração Social) and Cofins (Contribuição para o Financiamento da Seguridade Social) in sales of goods. |
| `↳↳ federal_state_taxes` | string |  | Only for BR shop. Enter the total percentage of the combination of federal, state, and municipal taxes, using up to two decimals. |
| `↳↳ operation_type` | string |  | Only for BR shop. 1: Retailer 2: Manufacturer |
| `↳↳ ex_tipi` | string |  | Only for BR shop. The EXTIPI field in the NF-e (Nota Fiscal Eletrônica) is used to indicate if there's an exception to the IPI (Imposto sobre Produtos Industrializados) tax rate for a specific product. |
| `↳↳ fci_num` | string |  | Only for BR shop. The FCI Control Number is a unique identifier assigned to each import FCI (Import Content Form). It's mandatory on the corresponding NF-e (electronic invoice) to ensure compliance with Brazilian import tax regulations. |
| `↳↳ recopi_num` | string |  | Only for BR shop. RECOPI NACIONAL is a Brazilian government system that facilitates the registration and management of tax-exempt operations involving paper destined for printing books, newspapers, and periodicals (known as "papel imune" in Portuguese). |
| `↳↳ additional_info` | string |  | Only for BR shop. Include relevant information to display on Invoice. |
| `↳↳ group_item_info` | object |  | Only for BR shop. Required if the item is a group item. |
| `↳↳↳ group_qtd` | string |  | Example: The package contains 6 soda cans. Whether you are selling a pack of 6 cans (fardo) or a single can (unit), enter 6. |
| `↳↳↳ group_unit` | string |  | Example: The package contains 6 soda cans. Whether you are selling a pack of 6 cans (fardo) or a single can (unit), enter UNI for the individual can. |
| `↳↳↳ group_unit_value` | string |  | Example: The package contains 6 soda cans. Whether you are selling a pack of 6 cans (fardo) or a single can (unity), enter the value of the individual can. |
| `↳↳↳ original_group_price` | string |  | Example: The item is a package that contains 6 soda cans. Enter the price of the whole package. |
| `↳↳↳ group_gtin_sscc` | string |  | Example: The item is a package that contains 6 soda cans. Please inform the GTIN SSCC code for the package. |
| `↳↳↳ group_grai_gtin_sscc` | string |  | Example: The item is box, that contain 6 packages. Each package contains 6 soda cans. Please inform the GRAI GTIN SSCC code for the Box. |
| `↳↳ export_cfop` | string |  | [BR region] 7101 - for sales of self-produced goods 7102 - resale of third-party goods |
| `↳ complaint_policy` | object |  | Complaint Policy for item. Only required for local PL sellers, ignored otherwise. |
| `↳↳ warranty_time` | string |  | Value should be in one of ONE_YEAR TWO_YEARS OVER_TWO_YEARS. |
| `↳↳ exclude_entrepreneur_warranty` | boolean |  | Whether to exclude warranty complaints for entrepreneurs.If True means "I exclude warranty complaints for entrepreneur" |
| `↳↳ complaint_address_id` | int64 |  | Address for complaint. Fetch available addresses using v2.logistics.get_address_list, and use address_id returned from it. |
| `↳↳ additional_information` | string |  | Additional information for warranty claim. Should be less than 1000 characters. |
| `↳ description_info` | object |  | New description field. Only whitelist sellers can use it. If you use the field, please upload the description_type=extended otherwise api will return error. If you don't use this field, you don't need to upload the description_type or upload description_type=normal |
| `↳↳ extended_description` | object |  | If description_type is extended , Description information should be set by this field. |
| `↳↳↳ field_list` | object[] |  | Field of extended description. |
| `↳↳↳↳ field_type` | string |  | Type of extended description field ：values: See Data Definition- description_field_type (text , image). |
| `↳↳↳↳ text` | string |  | If field_type is text， text information will be set by this field. |
| `↳↳↳↳ image_info` | object |  | If field_type is image，image url will be set by this field. |
| `↳↳↳↳↳ image_id` | string |  | Image id. |
| `↳ description_type` | string |  | Values: See Data Definition- description_type (normal , extended). If you want to use extended_description, this field must be inputed |
| `↳ seller_stock` | object[] |  | seller stock（Please notice that stock(including Seller Stock and Shopee Stock) should be larger than or equal to real-time reserved stock） |
| `↳↳ location_id` | string |  | location id |
| `↳↳ stock` | int32 | ✔ | stock |
| `↳ gtin_code` | string |  | - GTIN is an identifier for trade items, developed by the international organization GS1. - They have 8 to 14 digits. The most common are UPC, EAN, JAN and ISBN. - GTIN will help boost positioning in online marketing channels like Google and Facebook. - That incorporation with GTIN will also aid in Search and Recommendation in Shopee itself allowing buyers to have higher likelihood of finding one's listing. Note: If you want to set “Item without GTIN”, please pass the gtin_code as "00". The validation rule is based on the value return in gtin_validation_rule" field in v2.product.get_item_limit API - Mandatory : This field is required and must contain a correctly formatted GTiN number. - Flex |
| `↳ ds_cat_rcmd_id` | string |  | category recommendation service id |
| `↳ promotion_images` | object |  | Promotion Image Currently only allow one promoton image You could set promotion image only if the product images' ratio is 3:4 |
| `↳↳ image_id_list` | string[] |  | Promotion Image |
| `↳ compatibility_info` | object |  |  |
| `↳↳ vehicle_info_list` | object[] | ✔ |  |
| `↳↳↳ brand_id` | int64 | ✔ | ID of the brand. |
| `↳↳↳ model_id` | int64 | ✔ | ID of the model. |
| `↳↳↳ year_id` | int64 |  | ID of the year. |
| `↳↳↳ version_id` | int64 |  | ID of the version. |
| `↳ scheduled_publish_time` | timestamp |  | Scheduled publish time of this item: 1) Can only set scheduled_publish_time for item with UNLIST status 2) Can only set the time from current time +1hour to current time +90days, and the time is only allowed to be accurate to the minute |
| `↳ authorised_brand_id` | int64 |  | ID of authorised reseller brand. |
| `↳ size_chart_info` | object |  |  |
| `↳↳ size_chart` | string |  | ID of size chart image. If you want to remove the image size chart of the item, please pass the "size_chart" empty. You only need to fill out either the image or template. If both are filled, only the template will be kept. Notes: Both CB shops and local shops are supported to set "size_chart". |
| `↳↳ size_chart_id` | int64 |  | ID of template size chart. If you want to remove the template size chart of the item, please pass the "size_chart_id" as 0. You only need to fill out either the image or template. If both are filled, only the template will be kept. Notes: Only local shops are supported to set "size_chart_id", for CB shops please use "size_chart". |
| `↳ certification_info` | object |  | For PH product certification input Required for some category and attribute option |
| `↳↳ certification_list` | object[] |  | Array of certification records for the product, each containing type, certificate number, permit ID, and proof documents. |
| `↳↳↳ certification_no` | string | ✔ | Certification No. |
| `↳↳↳ permit_id` | int64 | ✔ | Permit ID, get from v2.product.get_product_certification_rule |
| `↳↳↳ expiry_date` | int32 |  | Expiry timestamp. Required for PH, but not needed for TW. |
| `↳↳↳ certification_proofs` | object[] | ✔ | An array of proof documents for the certification; each element represents one proof file.<path></path> |
| `↳↳↳↳ file_name` | string | ✔ | The name of the uploaded certification proof file. |
| `↳↳↳↳ image_id` | int32 | ✔ | The unique image ID of the certification proof, returned by the image upload API. |
| `↳↳↳↳ ratio` | float | ✔ | image weight/ image height Will be optional in the future; can input 0.75 by default |
| `↳ purchase_limit_info` | object |  | purchase limit info |
| `↳↳ min_purchase_limit` | int32 |  | minimum purchase count for each order |
| `↳↳ max_purchase_limit` | object |  |  |
| `↳↳↳ purchase_limit` | int32 |  | maximum purchase limit for each order. |
| `↳ medicine_id` | int64 |  | [Only for ID local sellers] as a unique identifier for each standardized medicine, the medicine id can only be obtained offline |
| `↳ ssp_id` | int64 |  | The ID of the Standardized Shop Product (SSP) to associate with the default model of the new item. The value must be greater than 0 when provided. If ssp_id is provided, cssp_id must also be provided. |
| `↳ cssp_id` | int64 |  | The ID of the country-specific Standardized Shop Product (CSSP) to associate with the default model of the new item. The value must be greater than 0 when provided. This field is required when ssp_id is provided. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ task_id` | int64 | The task ID of the batch add item task. |

## v2.product.batch_publish_item_to_outlet_shop
`POST /api/v2/product/batch_publish_item_to_outlet_shop` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Create asynchronous task to batch publish outlet item

Lịch sử cập nhật: 2026-06-12: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_list` | object[] | ✔ | The item list to batch publish to Outlet shop. The list size must be between 1 and 100. |
| `↳ mart_item_id` | int64 | ✔ | The item ID of the item in the Mart shop. |
| `↳ outlet_shop_id` | int64 | ✔ | The shop ID of the Outlet shop. |
| `↳ publish_item` | object | ✔ | The outlet item data to publish. |
| `↳↳ outlet_item_id` | int64 |  | The item ID of the item in the Outlet shop. |
| `↳↳ model` | object[] |  | The outlet model list. |
| `↳↳↳ relate_mart_model_id` | int64 |  | The related model ID of the product in the Mart shop. |
| `↳↳↳ model_status` | string |  | The model status. |
| `↳↳↳ original_price` | float |  | The original price of the outlet model. |
| `↳↳↳ seller_stock` | object[] |  | The seller stock by location. |
| `↳↳↳↳ location_id` | string |  | The location ID. |
| `↳↳↳↳ stock` | int32 | ✔ | The stock quantity of the location. |
| `↳↳↳ pre_order` | object |  | The pre-order setting of the model. |
| `↳↳↳↳ is_pre_order` | bool | ✔ | Indicate whether the model is pre-order. |
| `↳↳↳↳ days_to_ship` | int32 |  | The days to ship for pre-order model. |
| `↳↳ logistic_info` | object[] |  | The logistic information of the outlet item. |
| `↳↳↳ logistic_id` | int64 |  | The logistics channel ID used for shipping the item. |
| `↳↳↳ enabled` | bool | ✔ | Indicates whether the logistics channel is enabled for the item. |
| `↳↳↳ shipping_fee` | float |  | The shipping fee charged to the buyer for this logistics channel. |
| `↳↳↳ size_id` | int64 |  | The parcel size ID used to calculate shipping fees. |
| `↳↳↳ is_free` | bool |  | Indicates whether free shipping is applied for this logistics channel. |
| `↳↳ purchase_limit_info` | object |  | The purchase limit information of the outlet item. |
| `↳↳↳ min_purchase_limit` | int32 |  | The minimum quantity that a buyer is allowed to purchase per order. |
| `↳↳↳ max_purchase_limit` | object |  | The maximum purchase quantity configuration for the item. |
| `↳↳↳↳ purchase_limit` | int32 |  | The maximum quantity that a buyer is allowed to purchase per order. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ task_id` | int64 | The task ID of the batch publish outlet item task. |

## v2.product.get_ssp_detail
`GET /api/v2/product/get_ssp_detail` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Get the details of an SSP or CSSP. At least one of ssp_id and cssp_id is required, and cssp_id takes priority when both are provided. The response covers the product content such as the category path, attributes, brand and variations. Each entry in cssps is a country-specific SSP under the SSP, and its tier_indices point to the selected options of the parent tier_variation.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `ssp_id` | int64 |  | The ID of the Standardized Shop Product (SSP). |
| `cssp_id` | int64 |  | The ID of the country-specific Standardized Shop Product (CSSP). |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | The response data. |
| `↳ ssp_info` | object | The requested SSP details. |
| `↳↳ ssp_id` | int64 | The ID of the Standardized Shop Product (SSP). |
| `↳↳ title` | string | The display title of the SSP. |
| `↳↳ images` | string[] | Image identifiers associated with the SSP or CSSP. |
| `↳↳ category_path` | object[] | The category hierarchy of the SSP. |
| `↳↳↳ category_id` | int64 | The category ID. |
| `↳↳↳ category_name` | string | The category name. |
| `↳↳↳ display_name` | string | The localized display name. |
| `↳↳ description` | string | The SSP description. |
| `↳↳ attributes` | object[] | The attributes associated with the SSP or CSSP. |
| `↳↳↳ attr_id` | int32 | The attribute ID. |
| `↳↳↳ attr_name` | string | The attribute name. |
| `↳↳↳ attr_display_name` | string | The localized attribute name. |
| `↳↳↳ attr_val_info` | object[] | The values of the attribute. |
| `↳↳↳↳ attr_val_id` | int64 | The attribute value ID. |
| `↳↳↳↳ attr_val` | string | The attribute value. |
| `↳↳↳↳ attr_val_display_name` | string | The localized attribute value. |
| `↳↳↳↳ custom_value` | string | A custom attribute value when applicable. |
| `↳↳↳ input_type` | int32 | The input type of the attribute. |
| `↳↳↳ input_validator` | int32 | The validator type of the attribute. |
| `↳↳↳ format_type` | int32 | The format type of the attribute. |
| `↳↳↳ datetime_format` | int32 | The date-time format when the attribute is a date or time. |
| `↳↳ brand` | object | The SSP brand information. |
| `↳↳↳ brand_id` | int64 | The brand ID. |
| `↳↳↳ display_name` | string | The localized display name. |
| `↳↳ tier_variation` | object[] | The tier variation definitions. |
| `↳↳↳ name` | string | The tier variation name. |
| `↳↳↳ options` | string[] | The available tier variation options. |
| `↳↳↳ images` | string[] | Image identifiers associated with the SSP or CSSP. |
| `↳↳ cssps` | object[] | The country-specific products under the SSP. |
| `↳↳↳ ssp_id` | int64 | The ID of the Standardized Shop Product (SSP). |
| `↳↳↳ cssp_id` | int64 | The ID of the country-specific Standardized Shop Product (CSSP). |
| `↳↳↳ title` | string | The display title of the CSSP. |
| `↳↳↳ images` | string[] | Image identifiers associated with the SSP or CSSP. |
| `↳↳↳ tier_indices` | int32[] | The tier option indices identifying the CSSP variation. |
| `↳↳↳ desc` | string | The CSSP description. |
| `↳↳↳ brand_id` | int64 | The brand ID. |
| `↳↳↳ attributes` | object[] | The attributes associated with the SSP or CSSP. |
| `↳↳↳↳ attr_id` | int32 | The attribute ID. |
| `↳↳↳↳ attr_name` | string | The attribute name. |
| `↳↳↳↳ attr_display_name` | string | The localized attribute name. |
| `↳↳↳↳ attr_val_info` | object[] | The values of the attribute. |
| `↳↳↳↳↳ attr_val_id` | int64 | The attribute value ID. |
| `↳↳↳↳↳ attr_val` | string | The attribute value. |
| `↳↳↳↳↳ attr_val_display_name` | string | The localized attribute value. |
| `↳↳↳↳↳ custom_value` | string | A custom attribute value when applicable. |
| `↳↳↳↳ input_type` | int32 | The input type of the attribute. |
| `↳↳↳↳ input_validator` | int32 | The validator type of the attribute. |
| `↳↳↳↳ format_type` | int32 | The format type of the attribute. |
| `↳↳↳↳ datetime_format` | int32 | The date-time format when the attribute is a date or time. |
| `↳↳↳ tier_variation` | object[] | The tier variation definitions. |
| `↳↳↳↳ name` | string | The tier variation name. |
| `↳↳↳↳ options` | string[] | The available tier variation options. |
| `↳↳↳↳ images` | string[] | Image identifiers associated with the SSP or CSSP. |
| `↳↳↳ brand_name` | string | The brand name. |
| `↳↳ profile_type` | int32 | The SSP profile type. |

## v2.product.get_ssp_recommendation
`GET /api/v2/product/get_ssp_recommendation` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Get the SSP enrollment recommendations of the authorized shop, separating items that can be enrolled automatically from items that may be enrolled after further action. auto_enroll_time is the automatic enrollment time in seconds as a future timestamp, returned for automatic enrollment only.

Lịch sử cập nhật: 2026-09-24: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | The response data. |
| `↳ auto_enroll_items` | object[] | Items that are eligible for automatic SSP enrollment. |
| `↳↳ item_id` | int64 | The ID of the item. |
| `↳↳ ssp_id` | int64 | The ID of the Standardized Shop Product (SSP). |
| `↳↳ model_cssp` | object | The model and CSSP mapping recommended for the item. |
| `↳↳↳ model_id` | int64 | The ID of the item model. |
| `↳↳↳ cssp_id` | int64 | The ID of the country-specific Standardized Shop Product (CSSP). |
| `↳↳↳ ssp_id` | int64 | The ID of the Standardized Shop Product (SSP). |
| `↳ possible_to_be_enroll_items` | object[] | Items that may be eligible for SSP enrollment. |
| `↳↳ item_id` | int64 | The ID of the item. |
| `↳↳ ssp_id` | int64 | The ID of the Standardized Shop Product (SSP). |
| `↳↳ model_cssp` | object | The model and CSSP mapping recommended for the item. |
| `↳↳↳ model_id` | int64 | The ID of the item model. |
| `↳↳↳ cssp_id` | int64 | The ID of the country-specific Standardized Shop Product (CSSP). |
| `↳↳↳ ssp_id` | int64 | The ID of the Standardized Shop Product (SSP). |
| `↳ auto_enroll_time` | int32 | The automatic enrollment end time as a Unix timestamp in seconds. This field is meaningful for automatic-enrollment items and may be zero or absent otherwise. |

## v2.product.search_ssp_list
`POST /api/v2/product/search_ssp_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Search SSPs by title or by image. At most 50 results are returned. When image_id_list is provided, the search is based on image similarity and title is ignored; otherwise title must contain at least three characters.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `title` | string |  | Title text for SSP search. Required when image_id_list is empty and must contain at least three Unicode characters. |
| `image_id_list` | string[] |  | Image IDs used for visually similar SSP search. When at least one image ID is supplied, title is ignored. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | The response data. |
| `↳ ssp_list` | object[] | The list of SSPs matching the search criteria. |
| `↳↳ ssp_id` | int64 | The ID of the Standardized Shop Product (SSP). |
| `↳↳ title` | string | The display title of the SSP returned by the search. |
| `↳↳ images` | string[] | Image identifiers associated with the SSP or CSSP. |
| `↳↳ category_path` | object[] | The category hierarchy of the SSP. |
| `↳↳↳ category_id` | int64 | The category ID. |
| `↳↳↳ category_name` | string | The category name. |
| `↳↳↳ display_name` | string | The localized display name. |
| `↳↳ description` | string | The SSP description. |
| `↳↳ attributes` | object[] | The attributes associated with the SSP or CSSP. |
| `↳↳↳ attr_id` | int32 | The attribute ID. |
| `↳↳↳ attr_name` | string | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳ attr_display_name` | string | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳ attr_val_info` | object[] | The values of the attribute. |
| `↳↳↳↳ attr_val_id` | int64 | The attribute value ID. |
| `↳↳↳↳ attr_val` | string | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳↳ attr_val_display_name` | string | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳↳ custom_value` | string | A custom attribute value when applicable. |
| `↳↳↳ input_type` | int32 | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳ input_validator` | int32 | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳ format_type` | int32 | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳ datetime_format` | int32 | Attribute metadata that may be omitted by the current search converter. |
| `↳↳ brand` | object | The SSP brand information. |
| `↳↳↳ brand_id` | int64 | The brand ID. |
| `↳↳↳ display_name` | string | The localized display name. |
| `↳↳ tier_variation` | object[] | The tier variation definitions. |
| `↳↳↳ name` | string | The tier variation name. |
| `↳↳↳ options` | string[] | The available tier variation options. |
| `↳↳↳ images` | string[] | Image identifiers associated with the SSP or CSSP. |
| `↳↳ cssps` | object[] | The country-specific products under the SSP. |
| `↳↳↳ ssp_id` | int64 | The ID of the Standardized Shop Product (SSP). |
| `↳↳↳ cssp_id` | int64 | The ID of the country-specific Standardized Shop Product (CSSP). |
| `↳↳↳ title` | string | The display title of the CSSP returned by the search. |
| `↳↳↳ images` | string[] | Image identifiers associated with the SSP or CSSP. |
| `↳↳↳ tier_indices` | int32[] | The tier option indices identifying the CSSP variation. |
| `↳↳↳ desc` | string | The CSSP description. |
| `↳↳↳ brand_id` | int64 | The brand ID. |
| `↳↳↳ attributes` | object[] | The attributes associated with the SSP or CSSP. |
| `↳↳↳↳ attr_id` | int32 | The attribute ID. |
| `↳↳↳↳ attr_name` | string | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳↳ attr_display_name` | string | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳↳ attr_val_info` | object[] | The values of the attribute. |
| `↳↳↳↳↳ attr_val_id` | int64 | The attribute value ID. |
| `↳↳↳↳↳ attr_val` | string | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳↳↳ attr_val_display_name` | string | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳↳↳ custom_value` | string | A custom attribute value when applicable. |
| `↳↳↳↳ input_type` | int32 | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳↳ input_validator` | int32 | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳↳ format_type` | int32 | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳↳ datetime_format` | int32 | Attribute metadata that may be omitted by the current search converter. |
| `↳↳↳ tier_variation` | object[] | The tier variation definitions. |
| `↳↳↳↳ name` | string | The tier variation name. |
| `↳↳↳↳ options` | string[] | The available tier variation options. |
| `↳↳↳↳ images` | string[] | Image identifiers associated with the SSP or CSSP. |
| `↳↳↳ brand_name` | string | The brand name. |
| `↳↳ profile_type` | int32 | The SSP profile type. |

## v2.product.link_item_to_ssp
`POST /api/v2/product/link_item_to_ssp` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Link one or more models of an item to their country-specific SSPs. item_id and model_cssp_pairs are required, and each pair must contain model_id and cssp_id; ssp_id is optional.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 | ✔ | The ID of the item. |
| `model_cssp_pairs` | object[] | ✔ | Non-empty mappings between item models and CSSPs. Each mapping requires model_id and cssp_id; ssp_id is optional. |
| `↳ model_id` | int64 | ✔ | The ID of the item model. |
| `↳ cssp_id` | int64 | ✔ | The ID of the country-specific Standardized Shop Product (CSSP). |
| `↳ ssp_id` | int64 |  | The optional ID of the parent Standardized Shop Product (SSP). |

## v2.product.unlink_item_from_ssp
`POST /api/v2/product/unlink_item_from_ssp` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Remove the SSP links of one or more models of an item. item_id and model_cssp_pairs are required, and each pair must contain model_id and cssp_id; ssp_id is optional.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int64 | ✔ | The ID of the item. |
| `model_cssp_pairs` | object[] | ✔ | Non-empty mappings between item models and CSSPs. Each mapping requires model_id and cssp_id; ssp_id is optional. |
| `↳ model_id` | int64 | ✔ | The ID of the item model. |
| `↳ cssp_id` | int64 | ✔ | The ID of the country-specific Standardized Shop Product (CSSP). |
| `↳ ssp_id` | int64 |  | The optional ID of the parent Standardized Shop Product (SSP). |

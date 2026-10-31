# Module GlobalProduct (34 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.global_product.get_category
`GET /api/v2/global_product/get_category` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get global category. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2021-05-17: Add CNSC introduction in API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `language` | string |  | Display language. Language should be one of "zh-hans", "en" |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ category_list` | object[] |  |
| `↳↳ category_id` | int | ID for category. |
| `↳↳ parent_category_id` | int | ID for parent category. |
| `↳↳ original_category_name` | string | English category name. |
| `↳↳ display_category_name` | string | Display category name, it depends on what language you have uploaded |
| `↳↳ has_children` | boolean | Whether this category has active children category. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Update item failed {{.error_info}} · Update item failed {{.error_info}} · System error, please try again later or contact the OpenAPI support team. · System error, please try again later or contact the OpenAPI support team. · Your shop can not use model level dts

## v2.global_product.get_attribute_tree
`GET /api/v2/global_product/get_attribute_tree` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get the mtsku attribute trees for categories

Lịch sử cập nhật: 2025-01-13: Add; 2024-04-12: add introduction response parameter; 2023-07-24: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `category_id_list` | int[] | ✔ | Max count is 20 |
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
| `↳↳↳↳ multi_lang` | object | Translate results for value name display |
| `↳↳↳↳↳ language` | string | Language |
| `↳↳↳↳↳ value` | string | Translate result |
| `↳↳↳ attribute_info` | object | Attribute extra info |
| `↳↳↳↳ input_type` | int | SINGLE_DROP_DOWN = 1 SINGLE_COMBO_BOX = 2 FREE_TEXT_FILED = 3 MULTI_DROP_DOWN = 4 MULTI_COMBO_BOX = 5 |
| `↳↳↳↳ input_validation_type` | int | VALIDATOR_NO_VALIDATE_TYPE = 0 VALIDATOR_INT_TYPE = 1 VALIDATOR_STRING_TYPE = 2 VALIDATOR_FLOAT_TYPE = 3 VALIDATOR_DATE_TYPE = 4 |
| `↳↳↳↳ format_type` | int | FORMAT_NORMAL = 1 FORMAT_QUANTITATIVE_WITH_UNIT = 2 |
| `↳↳↳↳ date_format_type` | int | YEAR_MONTH_DATE = 0 (DD/MM/YYYY) YEAR_MONTH = 1 (MM/YYYY) |
| `↳↳↳↳ attribute_unit_list` | string[] | Attribute's available units list |
| `↳↳↳↳ mandatory_region` | string[] | Attribute is mandatory for these regions |
| `↳↳↳↳ max_value_count` | int | Max selected value count |
| `↳↳↳↳ introduction` | string | introduction of special attribute |
| `↳↳↳↳ is_oem` | boolean |  |
| `↳↳↳↳ support_search_value` | boolean | Indicates whether this attribute has searchable values. If yes, please call v2.global_product.search_global_attribute_value_list to get the default values |
| `↳↳↳ multi_lang` | object[] | Translate result for attribute name display |
| `↳↳↳↳ language` | string | Language |
| `↳↳↳↳ value` | string | Translate result |
| `↳↳ category_id` | int | Category ID |
| `↳↳ warning` | string | Warning msg |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Invalid language. · Invalid category ID {{.error_info}}

## v2.global_product.get_brand_list
`GET /api/v2/global_product/get_brand_list` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this call to get a list of brand. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2021-05-19: update brand; 2021-05-17: Add CNSC introduction in API description; 2021-05-13: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `offset` | int | ✔ | Specifies the starting entry of data to return in the current call. Default is 0. if data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int | ✔ | the size of one page. |
| `category_id` | int | ✔ | ID of category. |
| `status` | int | ✔ | Brand status , 1: normal brand, 2: pending brand. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ brand_list` | object[] |  |
| `↳↳ brand_id` | int | Id of brand. |
| `↳↳ original_brand_name` | string | Original name of brand |
| `↳↳ display_brand_name` | string | Display name of brand |
| `↳ has_next_page` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of items. |
| `↳ next_offset` | int | If has_next_page is true, this value need set to next request.offset |
| `↳ is_mandatory` | boolean | Whether is mandatory. |
| `↳ input_type` | string | Input type: DROP_DOWN |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Invalid category. · Update global item failed, please try later. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Category is restricted · Update item failed {{.error_info}} · Update item failed {{.error_info}}

## v2.global_product.get_global_item_limit
`GET /api/v2/global_product/get_global_item_limit` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get global item upload control.

Lịch sử cập nhật: 2025-01-08: Add size_chart_limit to decide if size_chart is mandatory; 2024-11-29: add size_chart_limit; 2024-06-27: add category_id request parameter and weight_limit, dimension_limit, dts_limit response parameters; 2022-02-21: add extended_description_limit; 2021-06-17: update path

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `category_id` | int64 |  |  |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ price_limit` | object |  |
| `↳↳ min_limit` | float | Global item price min limit. |
| `↳↳ max_limit` | float | Global item price max limit. |
| `↳ stock_limit` | object |  |
| `↳↳ min_limit` | int64 | Global item stock min limit. |
| `↳↳ max_limit` | int64 | Global item stock max limit. |
| `↳ global_item_name_length_limit` | object |  |
| `↳↳ min_limit` | int64 | Global item name length min limit. |
| `↳↳ max_limit` | int64 | Global item name length max limit. |
| `↳ global_item_image_count_limit` | object |  |
| `↳↳ min_limit` | int64 | Global item image count min limit. |
| `↳↳ max_limit` | int64 | Global item image count max limit. |
| `↳ global_item_description_length_limit` | object |  |
| `↳↳ min_limit` | int64 | Global item description length min limit. |
| `↳↳ max_limit` | int64 | Global item description length max limit. |
| `↳ tier_variation_name_length_limit` | object |  |
| `↳↳ min_limit` | int64 | Global item tier variation name length min limit. |
| `↳↳ max_limit` | int64 | Global item tier variation name length max limit. |
| `↳ tier_variation_option_length_limit` | object |  |
| `↳↳ min_limit` | int64 | Global item tier variation option length min limit. |
| `↳↳ max_limit` | int64 | Global item tier variation option length max limit. |
| `↳ text_length_multiplier` | float | Length ratio of Chinese characters to English characters in parameter verification. len(text)=len(Chinese characters)*text_length_multiplier+len(English characters ) |
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
| `↳↳ days_to_ship_range_list` | object[] | Allowed limit scope for Pre order |
| `↳↳↳ min_limit` | int64 |  |
| `↳↳↳ max_limit` | int64 |  |
| `↳ weight_limit` | object |  |
| `↳↳ weight_mandatory` | boolean | weight is mandatory or not |
| `↳ dimension_limit` | object |  |
| `↳↳ dimension_mandatory` | boolean | dimension is mandatory or not for the category |
| `size_chart_limit` | object |  |
| `↳ size_chart_mandatory` | boolean |  |
| `↳ support_image_size_chart` | boolean |  |
| `↳ support_template_size_chart` | boolean |  |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Get global item limit failed. please try later. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Update item failed {{.error_info}} · Update item failed {{.error_info}} · System error, please try again later or contact the OpenAPI support team. · System error, please try again later or contact the OpenAPI support team.

## v2.global_product.get_global_item_list
`GET /api/v2/global_product/get_global_item_list` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get global item id list. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2022-03-07: update page_size description; 2021-10-25: update page_size description; 2021-09-22: Add update_time_from & update_time_to field; 2021-05-17: Add CNSC introduction in API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `offset` | string |  | Specifies the starting entry of data to return in the current call. Default is null. if data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int | ✔ | The size of one page. Limit is [1,50]. |
| `update_time_from` | timestamp |  | The update_time_from and update_time_to fields specify a date range for retrieving orders (based on the item update time). The update_time_from field is the starting date range. |
| `update_time_to` | timestamp |  | The update_time_from and update_time_to fields specify a date range for retrieving orders (based on the item update time). The update_time_to field is the ending date range |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ global_item_list` | object[] |  |
| `↳↳ global_item_id` | int | Shopee's unique identifier for an global item. |
| `↳↳ update_time` | timestamp | Timestamp that indicates the last time that there was a change in value of the item, such as price/stock change. |
| `↳ total_count` | int | Total global item count. |
| `↳ has_next_page` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of items. |
| `↳ offset` | string | If has_next_page is true, this value need set to next request.offset. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · update_time_from is required · update_time_to is required · Get global item list failed. Please try later. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Update item failed {{.error_info}} · Update item failed {{.error_info}}

## v2.global_product.get_global_item_info
`GET /api/v2/global_product/get_global_item_info` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get global item info.Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2025-02-18: add size_chart_id; 2025-02-17: add is_fulfillment_by_shopee; 2024-06-21: update the description of DTS; 2024-05-29: update the description of weight and dimension; 2022-03-09: update global_status description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id_list` | int64 | ✔ | Global item id list. Length limit is [1,20]. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ global_item_list` | object[] |  |
| `↳↳ global_item_id` | int64 | Shopee's unique identifier for an global item. |
| `↳↳ global_item_name` | string | Name of the global item. |
| `↳↳ description` | string | Description of the global item. |
| `↳↳ global_item_sku` | string | An global item SKU (stock keeping unit) is an identifier defined by a seller, sometimes called parent SKU. Item SKU can be assigned to an item in Shopee Listings. |
| `↳↳ global_item_status` | string | The current status of the item. You can only query global product with normal status, otherwise api will return error. |
| `↳↳ create_time` | timestamp | Timestamp that indicates the date and time that the global item was created. |
| `↳↳ update_time` | timestamp | Timestamp that indicates the last time that there was a change in value of the global item. |
| `↳↳ stock_info` | object[] | If the item has models, this field will not be returned, please get it through get_model_list api. |
| `↳↳↳ stock_type` | int32 | The stock type. |
| `↳↳↳ stock_location_id` | string | location_id of the stock. |
| `↳↳↳ normal_stock` | int32 | The normal stock quantity of the variation in the listing currency. |
| `↳↳↳ reserved_stock` | int32 | The reserved stock quantity of the variation in the listing currency. |
| `↳↳ price_info` | object[] | If the item has models, price_info will not be returned. Please get the price of each model through the get_global_model_list api. |
| `↳↳↳ currency` | string | The three-digit code representing the currency unit used for the item in Shopee Listings. |
| `↳↳↳ original_price` | float | The original price of the item in the listing currency. |
| `↳↳↳ sip_item_price` | float | SIP item price. |
| `↳↳↳ sip_item_price_source` | string | source of sip' price. ( auto or manual). |
| `↳↳ image` | object |  |
| `↳↳↳ image_id_list` | string[] | List of image url. |
| `↳↳↳ image_url_list` | string[] | List of image id. |
| `↳↳ weight` | string | The weight of this global item, the unit is KG. If set the weight of global models under this item, will return the max weight of all global models during the switching period to ensure system compatibility, please switch to call v2.global_product.get_global_model_list to get the weight of models. |
| `↳↳ dimension` | object | The dimension of this global item. If set the dimension of global models under this global item, will return the dimension with largest volume calculated by height*length*width during the switching period to ensure system compatibility, please switch to call v2.global_product.get_global_model_list to get the dimension of models. |
| `↳↳↳ package_length` | int32 | The length of package for this global item, the unit is CM. |
| `↳↳↳ package_width` | int32 | The width of package for this global item, the unit is CM. |
| `↳↳↳ package_height` | int32 | The height of package for this global item, the unit is CM. |
| `↳↳ pre_order` | object | If set the DTS of global models under this item, will return the max DTS of all global models during the switching period to ensure system compatibility, please switch to call v2.global_product.get_global_model_list to get the DTS of models. |
| `↳↳↳ days_to_ship` | int32 | Days to ship. |
| `↳↳ size_chart` | string | Url of size chart image. |
| `↳↳ condition` | string | Is it second-hand. |
| `↳↳ has_model` | boolean | Does it contain model. |
| `↳↳ video` | object |  |
| `↳↳↳ video_url` | string | Url of video. |
| `↳↳↳ thumbnail_url` | string | Thumbnail of video. |
| `↳↳↳ duration` | int32 | Duration of video. |
| `↳↳ category_id` | int32 | Shopee's unique identifier for a category. |
| `↳↳ brand` | object |  |
| `↳↳↳ brand_id` | int32 | Id of brand. |
| `↳↳↳ original_brand_name` | string | Original name of brand. |
| `↳↳ attribute_list` | object[] |  |
| `↳↳↳ attribute_id` | int32 | The Identify of each category. |
| `↳↳↳ original_attribute_name` | string | The name of each attribute. |
| `↳↳↳ attribute_value_list` | object[] |  |
| `↳↳↳↳ value_id` | int32 | Unique identifier for value of this item attribute. |
| `↳↳↳↳ original_value_name` | string | Value name of this item attribute. |
| `↳↳↳↳ value_unit` | string | Value unit of this item attribute. |
| `↳↳ description_info` | object | New description field.New description field. Only whitelist sellers can use it. If you use the field, please upload the description_type=extended otherwise api will return error. If you don't use this field, you don't need to upload the description_type or upload description_type=normal |
| `↳↳↳ extended_description` | object | If description_type is extended , Description information will be returned through this field. |
| `↳↳↳↳ field_list` | object[] | Field of extended description |
| `↳↳↳↳↳ field_type` | string | Type of extended description field: values: See Data Definition- description_field_type (text , image). |
| `↳↳↳↳↳ text` | string | If field_type is text, text information will be returned through this field. |
| `↳↳↳↳↳ image_info` | object | If field_type is image, image url will be returned through this field. |
| `↳↳↳↳↳↳ image_id` | string | Image id. |
| `↳↳↳↳↳↳ image_url` | string | Image url. |
| `↳↳ description_type` | object | Type of description : values: See Data Definition- description_type (normal , extended). |
| `↳↳ is_fulfillment_by_shopee` | boolean | whether item is fulfillment by shopee |
| `↳↳ size_chart_id` | int64 | size_chart 模板ID |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Global item not belong to shop. · Invalid global_item_id. · Global_model_id and global_item_id not match. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Update item failed {{.error_info}} · Update item failed {{.error_info}}

## v2.global_product.add_global_item
`POST /api/v2/global_product/add_global_item` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management

Add global item. Only for China mainland sellers using China Seller Centre(CNSC). More details in https://shopee.cn/cooperate/46/53/926.

Lịch sử cập nhật: 2026-09-01: Condition is required; 2025-01-08: Add size_chart_info; 2024-10-23: sunset the normal_stock; 2023-05-12: add seller_stock parameter; 2022-06-17: remove original_brand_name request parameter

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `category_id` | int64 | ✔ | Category id of global item. |
| `global_item_name` | string | ✔ | Name of global item. |
| `description` | string | ✔ | Description of global item. |
| `global_item_sku` | string |  | Sku of global item. |
| `image` | object |  | Image information of global item. |
| `↳ image_id_list` | string[] | ✔ | Image id list of global item. |
| `original_price` | float | ✔ | Original price of global item. |
| `normal_stock` | int64 |  | Normal stock of global item. |
| `weight` | float | ✔ | Weight of global item. |
| `dimension` | object |  | Dimension information of global item. |
| `↳ package_length` | int64 | ✔ | Package length of global item. |
| `↳ package_width` | int64 | ✔ | Package width of global item. |
| `↳ package_height` | int64 | ✔ | Package height of global item. |
| `pre_order` | object | ✔ | Preorder information of global item. |
| `↳ days_to_ship` | int64 | ✔ | Days to ship. |
| `condition` | string | ✔ | Condition of global item, USED、Used and used will be mapped to Used; NEW、New and new will be mapped to New. |
| `video_upload_id` | string[] |  | Video upload id of global item. Only accept one video_upload_id at most. |
| `brand` | object |  |  |
| `↳ brand_id` | int64 |  | Id of brand. |
| `↳ original_brand_name` | string |  | Original name of brand. |
| `attribute_list` | object[] |  | Item attributes. |
| `↳ attribute_id` | int64 |  | ID of attribute. |
| `↳ attribute_value_list` | object[] |  |  |
| `↳↳ value_id` | int64 |  | ID of attribute value. In the following cases, the value id needs to be uploaded as 0, and original_value_name is mandatory, needs to be filled in customized value. (1) AttributeInputType is TEXT_FILED; (2) AttributeInputType is COMBO_BOX or MULTIPLE_SELECT_COMBO_BOX, and the seller want to fill in a customized value. |
| `↳↳ original_value_name` | string |  | Name of attribute value. original_value_name from global_product.get_attributes api. If value id=0, this field is required. If AttributeType is DATE_TYPE or TIMESTAMP_TYPE, you can upload timestamp(string type) as the original_value_name. |
| `↳↳ value_unit` | string |  | Unit of attribute value.(quantitative attribute only) |
| `description_info` | object |  | New description field. New description field. Only whitelist sellers can use it. If you use the field, please upload the description_type=extended otherwise api will return error. If you don't use this field, you don't need to upload the description_type or upload description_type=normal |
| `↳ extended_description` | object |  | If description_type is extended , Description information should be set by this field. |
| `↳↳ field_list` | object[] |  | Field of extended description. |
| `↳↳↳ field_type` | string |  | type of extended description field ：values: See Data Definition- description_field_type (text , image). |
| `↳↳↳ text` | string |  | If field_type is text， text information will be set by this field. |
| `↳↳↳ image_info` | object |  | If field_type is image，image url will be set by this field. |
| `↳↳↳↳ image_id` | string |  | Image id. |
| `description_type` | string |  | Values: See Data Definition- description_type (normal , extended). If you want to use extended_description, this field must be inputed |
| `seller_stock` | object[] |  | seller_stock of global item. |
| `↳ location_id` | string |  | location_id of stock |
| `↳ stock` | int32 | ✔ | stock |
| `ds_cat_rcmd_id` | string |  | category recommendation service id |
| `size_chart_info` | object |  |  |
| `↳ size_chart` | string |  | ID of size chart image. If you want to remove the image size chart of the item, please pass the "size_chart" empty. You only need to fill out either the image or template. If both are filled, only the template will be kept. Notes: Both CB shops and local shops are supported to set "size_chart". |
| `↳ size_chart_id` | int64 |  | ID of template size chart. If you want to remove the template size chart of the item, please pass the "size_chart_id" as 0. You only need to fill out either the image or template. If both are filled, only the template will be kept. Notes: Both local shops and CB shops are supported to set "size_chart_id" now and seller need set the size_chart template in CBSC in advance |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ global_item_id` | int64 | Id of added global item. |

Lỗi riêng: The expired add on deal can't be edited · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Merchant_id is not found. · Invalid category. · Invalid attribute. {{.error_info}} · Parameter is not match the constraints, {{.error_info}}. · Invalid dimension. · Invalid days_to_ship.

## v2.global_product.update_global_item
`POST /api/v2/global_product/update_global_item` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management

Update global item. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2025-01-08: Add size_chart_info to update size chart; 2024-06-21: update the description of DTS; 2024-05-29: update the description of weight and dimension; 2022-06-17: remove original_brand_name request parameter; 2022-02-22: add description_info

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int64 | ✔ | Id of global item. |
| `category_id` | int32 |  | Category id of global item. |
| `global_item_name` | string |  | Name of global item. |
| `description` | string |  | Description of global item. |
| `global_item_sku` | string |  | Sku of global item. |
| `weight` | float |  | The weight of this global item, the unit is KG. Updating the weight of this global item will overwrite the weight of all global models under this global item. |
| `dimension` | object |  | The dimension of this global item. Updating the dimension of this global item will overwrite the dimension of all global models under this global item. |
| `↳ package_length` | int32 |  | The length of package for this global item, the unit is CM. |
| `↳ package_width` | int32 |  | The width of package for this global item, the unit is CM. |
| `↳ package_height` | int32 |  | The height of package for this global item, the unit is CM. |
| `pre_order` | object |  | Preorder information of global item. Updating the DTS of global item will overwrite the DTS of all global models under the global item |
| `↳ days_to_ship` | int32 | ✔ | Days to ship. |
| `condition` | string |  | Condition of global item, "NEW" or "USED" is available. |
| `image` | object |  | Image information of global item. |
| `↳ image_id_list` | string[] | ✔ | Image id list of global item. |
| `video_upload_id` | string[] |  | Video upload id of global item. |
| `brand` | object |  |  |
| `↳ brand_id` | int32 |  | Id of brand. |
| `attribute_list` | object[] |  | Item attributes. |
| `↳ attribute_id` | int32 |  | ID of attribute. |
| `↳ attribute_value_list` | object[] |  |  |
| `↳↳ value_id` | int32 |  | ID of attribute value. In the following cases, the value id needs to be uploaded as 0, and original_value_name is mandatory, needs to be filled in customized value. (1) AttributeInputType is TEXT_FILED; (2) AttributeInputType is COMBO_BOX or MULTIPLE_SELECT_COMBO_BOX, and the seller want to fill in a customized value. |
| `↳↳ original_value_name` | string |  | Name of attribute value. original_value_name from global_product.get_attributes api. If value id=0, this field is required. If AttributeType is DATE_TYPE or TIMESTAMP_TYPE, you can upload timestamp(string type) as the original_value_name. |
| `↳↳ value_unit` | string |  | Unit of attribute value.(quantitative attribute only) |
| `description_info` | object |  | New description field. New description field. Only whitelist sellers can use it. If you use the field, please upload the description_type=extended otherwise api will return error. If you don't use this field, you don't need to upload the description_type or upload description_type=normal |
| `↳ extended_description` | object |  | If description_type is extended , Description information should be set by this field. |
| `↳↳ field_list` | object[] |  | Field of extended description. |
| `↳↳↳ field_type` | string |  | Type of extended description field ：values: See Data Definition- description_field_type (text , image). |
| `↳↳↳ text` | string |  | If field_type is text, text information will be set by this field. |
| `↳↳↳ image_info` | object |  | If field_type is image, image url will be set by this field. |
| `↳↳↳↳ image_id` | string |  | Image id. |
| `description_type` | string |  | Values: See Data Definition- description_type (normal , extended). If you want to use extended_description or change description type ,this field must be inputed |
| `size_chart_info` | object |  |  |
| `↳ size_chart` | string |  | ID of size chart image. If you want to remove the image size chart of the item, please pass the "size_chart" empty. You only need to fill out either the image or template. If both are filled, only the template will be kept. Notes: Both CB shops and local shops are supported to set "size_chart". |
| `↳ size_chart_id` | int64 |  | ID of template size chart. If you want to remove the template size chart of the item, please pass the "size_chart_id" as 0. You only need to fill out either the image or template. If both are filled, only the template will be kept. Notes: Both local shops and CB shops are supported to set "size_chart_id" now and seller need set the size_chart template in CBSC in advance |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ global_item_id` | int64 | Id of updated global item. |

Lỗi riêng: The expired add on deal can't be edited · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · not all shop is upgraded and confirmed, can not edit item · Merchant_id is not found. · Invalid category. · Invalid attribute. {{.error_info}} · Parameter is not match the constraints, {{.error_info}}. · Invalid dimension.

## v2.global_product.delete_global_item
`POST /api/v2/global_product/delete_global_item` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management

Delete global item. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2021-05-17: Add CNSC introduction in API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int | ✔ | The id of global item to delete. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ failure_delete_item` | object[] | If delete failed, this field shows the details. |
| `↳↳ shop_id` | int | The id of shop corresponding to the related item failed to delete. |
| `↳↳ item_id` | int | The id of related item failed to delete. |

Lỗi riêng: The expired add on deal can't be edited · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · not all shop is upgraded and confirmed, can not edit item · Merchant_id is not found. · Get shop failed. please try later. · Global item not found. · Delete global item failed,{{.error_info}}ｼ継lease try later. · Our system is taking some time to respond, please try later.

## v2.global_product.init_tier_variation
`POST /api/v2/global_product/init_tier_variation` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management

Only for China mainland sellers and Korean sellers. If you only define color, it is one tier, if you define color and size, it is two tier. Support two tier structures at most. This API can change no tier to one tier, no tier to two tier, one tier to two tier, two tier to one tier, one tier to no tier, two tier to no tier. Please create variants after an interval of 5 seconds after creating an item, as there may be a delay.

Lịch sử cập nhật: 2025-09-15: The tier_variation structure in the documentation has been deprecated. Please use the standardise_tier_variation structure when uploading variations.; 2024-10-23: sunset the normal_stock; 2024-06-27: support update one tier or two tier to no tier; 2024-06-21: add model level DTS; 2024-05-29: add model level weight and dimension

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_model` | object[] | ✔ | Model info list, model number at most 50 |
| `↳ original_price` | float | ✔ | Original price of global model. |
| `↳ seller_stock` | object[] |  | seller_stock of global item |
| `↳↳ location_id` | string |  | location_id of stock, if the merchant has 3PF shop, the location_id cannot be empty, can use the get_merchant_warehouse_location_list API to obtain the location_id list of the merchant, if the merchant does not have 3PF shop (only has normal CBSC shop), the location_id can be empty |
| `↳↳ stock` | int64 | ✔ | stock |
| `↳ global_model_sku` | string |  | Sku of global model. model_sku length information needs to be no more than 100 characters. |
| `↳ tier_index` | int32[] | ✔ | Tier index of global model. Index starts from 0. If you want to update one tier/two tier to no tier, can just pass the tier_variation and standardise_tier_variation as [], and pass the global_model >> tier_index as [], meanwhile pass the original_price, seller_stock, etc., to set the price and stock for the modified product with no tier structure. |
| `↳ weight` | float |  | The weight of this global model, the unit is KG. If don't set the weight of this global model, will use the weight of global item by default. If set the dimension of this global model, them must set the weight of this global model. |
| `↳ dimension` | object |  | The dimension of this global model. If don't set the dimension of this global model, will use the dimension of global item by default. |
| `↳↳ package_height` | int32 | ✔ | The height of package for this global model, the unit is CM. |
| `↳↳ package_length` | int32 | ✔ | The length of package for this global model, the unit is CM. |
| `↳↳ package_width` | int32 | ✔ | The width of package for this global model, the unit is CM. |
| `↳ pre_order` | object |  | Pre-order information of this global model. Notes: If don't set the DTS of this global model, will use the DTS of the global item by default. |
| `↳↳ days_to_ship` | int32 | ✔ | Days to ship. Please get the days_to_ship range from the get_dts_limit API. |
| `global_item_id` | int32 | ✔ | ID of global item. |
| `standardise_tier_variation` | object[] |  | There is at least one standardise_tier_variation and tier_variation. If you want to update one tier/two tier to no tier, can just pass the tier_variation and standardise_tier_variation as [], and pass the global_model >> tier_index as [], meanwhile pass the original_price, seller_stock, etc., to set the price and stock for the modified product with no tier structure. |
| `↳ variation_id` | int32 | ✔ | standardise tier variation ID |
| `↳ variation_name` | string |  | standardise tier variation name |
| `↳ variation_group_id` | int32 |  | standardise tier variation group ID |
| `↳ variation_option_list` | object[] | ✔ | standardise tier variation option list |
| `↳↳ variation_option_id` | int32 | ✔ | standardise tier variation option ID |
| `↳↳ variation_option_name` | string |  | standardise tier variation option value |
| `↳↳ image_id` | string |  | standardise tier variation option image ID |

Lỗi riêng: The expired add on deal can't be edited · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · not all shop is upgraded and confirmed, can not edit item · The level of tier-variation not change. · Model tier_index error. · Image not exist. · Global item not found. · Global item sku is over limit.

## v2.global_product.update_tier_variation
`POST /api/v2/global_product/update_tier_variation` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management

Update global product tier variation. Only for China mainland sellers and Korean sellers.This api can only be used without changing the tier structure, you can add options, delete options, and update the option image by this api.

Lịch sử cập nhật: 2025-09-15: The tier_variation structure in the documentation has been deprecated. Please use the standardise_tier_variation structure when uploading variations.; 2024-03-26: Add standard variations; 2022-08-11: add model list; 2022-01-27: update define and tier_variation description; 2021-09-14: update image type and request example

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int64 | ✔ | ID of global item. |
| `model_list` | object[] |  |  |
| `↳ model_id` | int64 | ✔ | ID of model |
| `↳ tier_index` | int32 | ✔ | Model's tier_variation |
| `standardise_tier_variation` | object[] |  | item standardise tier variation There is at least one standardise_tier_variation and tier_variation |
| `↳ variation_id` | int | ✔ | standardise tier variation ID |
| `↳ variation_name` | string |  | standardise tier variation name |
| `↳ variation_group_id` | int |  | standardise tier variation group ID |
| `↳ variation_option_list` | object[] | ✔ | standardise tier variation option list |
| `↳↳ variation_option_id` | int | ✔ |  |
| `↳↳ variation_option_name` | string |  |  |
| `↳↳ image_id` | string |  |  |

Lỗi riêng: The expired add on deal can't be edited · The tier_index is not exist · The model_id is duplicate, model_id:{{.model_id}} · The model_id is wrong or not related to this item, model_id:{{.model_id}} · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Canot change the level of tier-variation. · Image not exist. · Model can not be empty.

## v2.global_product.add_global_model
`POST /api/v2/global_product/add_global_model` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management

Add global model. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2024-10-23: sunset the normal_stock; 2024-06-21: add model level DTS; 2024-05-29: add model level weight and dimension; 2023-05-12: add seller_stock parameter; 2022-02-14: add model_sku description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int64 | ✔ | ID of global item. |
| `global_model` | object[] | ✔ | Global model setting list. Limit is [1,50]. |
| `↳ global_model_sku` | string |  | Sku of global model. model_sku length information needs to be no more than 100 characters. |
| `↳ tier_index` | int32[] | ✔ | Tier index of global model. |
| `↳ seller_stock` | object[] |  | seller_stock of global item |
| `↳↳ location_id` | string |  | location_id of stock, if the merchant has 3PF shop, the location_id cannot be empty, can use the get_merchant_warehouse_location_list API to obtain the location_id list of the merchant, if the merchant does not have 3PF shop (only has normal CBSC shop), the location_id can be empty |
| `↳↳ stock` | int32 | ✔ | stock |
| `↳ original_price` | float | ✔ | Original price of global item. |
| `↳ weight` | float |  | The weight of this global model, the unit is KG. If don't set the weight of this global model, will use the weight of global item by default. If set the dimension of this global model, them must set the weight of this global model. |
| `↳ dimension` | object |  | The dimension of this global model. If don't set the dimension of this global model, will use the dimension of global item by default. |
| `↳↳ package_height` | int32 | ✔ | The height of package for this global model, the unit is CM. |
| `↳↳ package_length` | int32 | ✔ | The length of package for this global model, the unit is CM. |
| `↳↳ package_width` | int32 | ✔ | The width of package for this global model, the unit is CM. |
| `↳ pre_order` | object |  | Pre-order information of this global model. Notes: If don't set the DTS of this global model, will use the DTS of the global item by default. |
| `↳↳ days_to_ship` | int32 | ✔ | Days to ship. Please get the days_to_ship range from the get_dts_limit API. |

Lỗi riêng: The expired add on deal can't be edited · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Model tier_index error. · Original_price must bigger than 0. · Item without tier_variation. Please use init_tier_variation api to upgrade the structure. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Update item failed {{.error_info}}

## v2.global_product.update_global_model
`POST /api/v2/global_product/update_global_model` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management

Update global model. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2024-06-21: add model level DTS; 2024-05-29: add model level weight and dimension; 2021-05-17: Add CNSC introduction in API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int64 | ✔ | ID of global item. |
| `global_model` | object[] | ✔ | Sku setting for global model. Limit is [1,50]. |
| `↳ global_model_sku` | string | ✔ | Sku of global model. |
| `↳ global_model_id` | int64 | ✔ | ID of global model. |
| `↳ weight` | float |  | The weight of this global model, the unit is KG. If don't set the weight of this global model, will use the weight of global item by default. If set the dimension of this global model, them must set the weight of this global model. |
| `↳ dimension` | object |  | The dimension of this global model. If don't set the dimension of this global model, will use the dimension of global item by default. |
| `↳↳ package_height` | int32 | ✔ | The height of package for this global model, the unit is CM. |
| `↳↳ package_length` | int32 | ✔ | The length of package for this global model, the unit is CM. |
| `↳↳ package_width` | int32 | ✔ | The width of package for this global model, the unit is CM. |
| `↳ pre_order` | object |  | Pre-order information of this global model. Notes: If don't set the DTS of this global model, will use the DTS of the global item by default. |
| `↳↳ days_to_ship` | int32 | ✔ | Days to ship. Please get the days_to_ship range from the get_dts_limit API. |

Lỗi riêng: The expired add on deal can't be edited · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Item without tier_variation. Please use init_tier_variation api to upgrade the structure. · Global model no found. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Update item failed {{.error_info}} · Update item failed {{.error_info}}

## v2.global_product.delete_global_model
`POST /api/v2/global_product/delete_global_model` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management

Delete global model. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2021-05-17: Add CNSC introduction in API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int | ✔ | Shopee's unique identifier for an global item. |
| `global_model_id` | int | ✔ | Shopee's unique identifier for an global model. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ global_model_id` | int | Global model id. |
| `↳ failures` | object[] |  |
| `↳↳ shop_id` | int | Failed shop id. |
| `↳↳ item_id` | int | Failed item id. |
| `↳↳ model_id` | int | Failed model id. |

Lỗi riêng: The expired add on deal can't be edited · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Global item not belong to shop. · Global_model_id and global_item_id not match. · Delete global model failed, please try later, {{.error_info}}. · Can't delete global default model. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team.

## v2.global_product.get_global_model_list
`GET /api/v2/global_product/get_global_model_list` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get global model list. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2025-02-17: add is_fulfillment_by_shopee; 2024-06-21: add model level DTS; 2024-05-29: add model level weight and dimension; 2024-03-26: Add standard variation fields; 2021-05-17: Add CNSC introduction in API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int64 | ✔ | The id of global item. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ tier_variation` | object[] | Tier variation information of global item. |
| `↳↳ name` | string | Tier name. |
| `↳↳ option_list` | object[] | Tier option list for corresponding tier name. |
| `↳↳↳ option` | string | Tier option. |
| `↳↳↳ image` | object | Image information of tier. |
| `↳↳↳↳ image_url` | string | Image url. |
| `↳↳↳↳ image_id` | string | Id of image. |
| `↳ global_model` | object[] | Global models. |
| `↳↳ global_model_id` | int64 | Id of global model. |
| `↳↳ global_model_sku` | string | Sku of global model. |
| `↳↳ price_info` | object | Price info of global model. |
| `↳↳↳ original_price` | float | Original price of global model. |
| `↳↳ stock_info` | object[] | Stock info of global model. |
| `↳↳↳ stock_type` | int32 | Stock type. "1" means wms on hand, "2" means seller on hand. |
| `↳↳↳ stock_location_id` | string | Stock location id. |
| `↳↳↳ current_stock` | int32 | Current stock. |
| `↳↳↳ normal_stock` | int32 | Normal stock. |
| `↳↳↳ reserved_stock` | int32 | Reserved stock. |
| `↳↳ tier_index` | int32[] | Tier index of global model. |
| `↳↳ weight` | string | The weight of this global model, the unit is KG. If don't set the weight of this global model, will use the weight of global item by default. |
| `↳↳ dimension` | object | The dimension of this global model. If don't set the dimension of this global model, will use the dimension of global item by default. |
| `↳↳↳ package_height` | int32 | The height of package for this global model, the unit is CM. |
| `↳↳↳ package_length` | int32 | The length of package for this global model, the unit is CM. |
| `↳↳↳ package_width` | int32 | The width of package for this global model, the unit is CM. |
| `↳↳ pre_order` | object | Pre-order information of this global model. Notes: If don't set the DTS of this global model, will use the DTS of the global item by default. |
| `↳↳↳ days_to_ship` | int32 | Days to ship. |
| `↳↳ is_fulfillment_by_shopee` | boolean | If it it a FBS model |
| `↳ standardise_tier_variation` | object[] | Standardise Tier variation information of global item. |
| `↳↳ variation_id` | int32 | Standardise Tier variation ID. |
| `↳↳ variation_name` | string | Standardise Tier variation Name. |
| `↳↳ variation_group_id` | int32 | Standardise Tier variation Group ID. |
| `↳↳ variation_option_list` | object[] | Standardise Tier variation Options List. |
| `↳↳↳ variation_option_id` | int32 | Standardise Tier variation Option ID. |
| `↳↳↳ variation_option_name` | string | Standardise Tier variation Option Name. |
| `↳↳↳ image_id` | string | ID of image |
| `↳↳↳ image_url` | string | URL of image |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · shop is upgrading · Global item not found. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Update item failed {{.error_info}} · Update item failed {{.error_info}} · System error, please try again later or contact the OpenAPI support team.

## v2.global_product.support_size_chart
`GET /api/v2/global_product/support_size_chart` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get category support size chart. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2021-05-17: Add CNSC introduction in API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `category_id` | int | ✔ | Id of category. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ support_size_chart` | boolean | If category support size chart. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Invalid category. · Invalid category ID {{.error_info}} · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Update item failed {{.error_info}} · Update item failed {{.error_info}} · System error, please try again later or contact the OpenAPI support team.

## v2.global_product.update_size_chart
`POST /api/v2/global_product/update_size_chart` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Update size chart for global item. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2021-05-17: Add CNSC introduction in API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int | ✔ | Id of global item. |
| `size_chart` | string | ✔ | Image id of size chart. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Merchant_id is not found. · Update size chart failed, please try later. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Category is restricted · Update item failed {{.error_info}} · Update item failed {{.error_info}}

## v2.global_product.create_publish_task
`POST /api/v2/global_product/create_publish_task` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management

Create publish task for global item. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2025-09-15: The tier_variation structure in the documentation has been deprecated. Please use the standardise_tier_variation structure when uploading variations.; 2023-01-03: add model_status field; 2022-07-26: update the description; 2022-06-17: remove category id; 2022-02-22: update

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int64 | ✔ | Id of global item. |
| `shop_id` | int32 | ✔ | Id of shop to publish to. |
| `shop_region` | string | ✔ | Region of shop. |
| `item` | object |  | Item information. |
| `↳ item_name` | string |  | Name of item. If you upload this field, we will take your value, so you should pass the value in the local language, if you don't upload this field, Shopee will automatically translate your global product name into the local language. |
| `↳ description` | string |  | Description of item. If you upload this field, we will take your value, so you should pass the value in the local language, if you don't upload this field, Shopee will automatically translate your global product description into the local language. |
| `↳ item_status` | string |  | Status of item. |
| `↳ original_price` | float |  | Original price of item. For SG/MY/BR/MX/PL/ES/AR seller: Sellers can set the price with two decimal place, other regions can only set the price as an integer. If you upload this field, we will take your value, so you should pass the value in local currency, if you don't upload this field, Shopee will automatically calculate the price. |
| `↳ image` | object |  | Image information of item. |
| `↳↳ image_id_list` | string[] | ✔ | Image id list of item. |
| `↳ model` | object[] |  | Model information of item. |
| `↳↳ tier_index` | int32[] | ✔ | Tier index of model. |
| `↳↳ original_price` | float | ✔ | Original price of model. If you upload this field, we will take your value, so you should pass the value in local currency, if you don't upload this field, Shopee will automatically calculate the price. |
| `↳↳ model_status` | string |  | can be "NORMAL" or "UNAVAILABLE". Normal models can be sold on the buyer's side, and UNAVAILABLE models cannot be sold on the buyer's side. If you do not upload this field, the model status will be considered as "NORMAL". |
| `↳ size_chart` | string |  | Size chart of item. Only support image_id for now |
| `↳ logistic` | object[] |  | Logistic information of item. |
| `↳↳ logistic_id` | int32 | ✔ | Logistic id. |
| `↳↳ enabled` | boolean | ✔ | If this logistic channel is enabled. |
| `↳↳ shipping_fee` | float |  | Shipping fee. |
| `↳↳ size_id` | int32 |  | Size id. |
| `↳↳ is_free` | boolean |  | If this logistic channel is free. |
| `↳ pre_order` | object |  | Preorder information of item. |
| `↳↳ is_pre_order` | boolean | ✔ | If this item is preorder. |
| `↳↳ days_to_ship` | int32 |  | Days to ship, it's mandatory if is_pre_order is true. |
| `↳ description_info` | object |  | New description field. Only whitelist sellers can use it. If you use the field, please upload the description_type=extended otherwise api will return error. If you don't use this field, you don't need to upload the description_type or upload description_type=normal. If you upload this field, we will take your value, so you should pass the value in the local language, if you don't upload this field, Shopee will automatically translate your global product description into the local language. |
| `↳↳ extended_description` | object |  | If description_type is extended , Description information should be set by this field. |
| `↳↳↳ field_list` | object[] |  | Field of extended description. |
| `↳↳↳↳ field_type` | string |  | Type of extended description field ：values: See Data Definition- description_field_type (text , image). |
| `↳↳↳↳ text` | string |  | If field_type is text， text information will be set by this field. |
| `↳↳↳↳ image_info` | object |  | If field_type is image，image url will be set by this field. |
| `↳↳↳↳↳ image_id` | string |  | Image id. |
| `↳ standardise_tier_variation` | object[] |  |  |
| `↳↳ variation_id` | int |  |  |
| `↳↳ variation_name` | string |  |  |
| `↳↳ variation_group_id` | int |  |  |
| `↳↳ variation_option_list` | object[] |  |  |
| `↳↳↳ variation_option_id` | int |  |  |
| `↳↳↳ variation_option_name` | string |  |  |
| `↳↳↳ image_id` | string |  |  |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ publish_task_id` | int64 | The id of publish task. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · partner does not have permission to operate shop · can not publish product to sip affiliated shop · shop is not upgraded or lack service fee rate · Item_id is not found. · Merchant_id is not found. · Partner_id is not found. · Parameter is not match the constraints, {{.error_info}}.

## v2.global_product.get_publishable_shop
`GET /api/v2/global_product/get_publishable_shop` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get publishable shop list for global item. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2024-03-27: add shop_id_list; 2021-05-17: Add CNSC introduction in API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int | ✔ | Id of global item. |
| `shop_id_list` | int[] |  | Shop id list for checking if the shop is publishable.If not input the list, will return the first 300 publishable shop list in response |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ publishable_shop` | object[] | Detail of publishable shops. |
| `↳↳ shop_id` | int | Id of publishable shop. |
| `↳↳ shop_region` | string | Region of published shop. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Merchant_id is not found. · Get shop failed. please try later. · Global item not found. · Global_item_id not found. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Update item failed {{.error_info}}

## v2.global_product.get_publish_task_result
`GET /api/v2/global_product/get_publish_task_result` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get publish task result for global item. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2021-05-17: Add CNSC introduction in API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `publish_task_id` | int | ✔ | Id of publish task. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ publish_status` | string | Status of publish task. |
| `↳ success` | object | If publish task is successful, this field shows the published results. |
| `↳↳ region` | string | The region of published item. |
| `↳↳ shop_id` | string | The shop id of published item. |
| `↳↳ item_id` | string | The id of published item. |
| `↳ failed` | object | If publish task is failed, this field shows the failed reason. |
| `↳↳ failed_reason` | string | Failed reason. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Shop is not found. · partner does not have permission to operate shop · Merchant_id is not found. · Get shop failed. please try later. · Global_item_id not found. · Get publish result failed, please try later. · Our system is taking some time to respond, please try later.

## v2.global_product.get_published_list
`GET /api/v2/global_product/get_published_list` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get published item list of global item. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2024-02-02: add new request field "shop_id_list"; 2022-06-17: add code demo; 2021-08-19: Add Item_status applicable values information; 2021-05-17: Add CNSC introduction in API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int | ✔ | Id of global item. |
| `shop_id_list` | int[] |  | Shop id list for checking if the shop is publishable.If not input the list, will return the first 300 publishable shop list in response after the migration period. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ published_item` | object[] | Detail of published items. |
| `↳↳ shop_id` | int | Shop id corresponding to the published item. |
| `↳↳ shop_region` | string | Region of shop. |
| `↳↳ item_id` | int | Id of published item. |
| `↳↳ item_status` | int | Status of published item.Applicable values: 0.DELETED(Item is deleted by seller himself),1.NORMAL, 2.BANNED,3.REVIEWING,4.INVALID(Shopee Admin deleted),5.INVALID_HIDE(Shopee Admin delete confirmed),6.BLACKLISTED(Offensive_hide),8.NORMAL_UNLIST |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Item_id is not found. · Get shop failed. please try later. · Global item not found. · Global_item_id not found. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Update item failed {{.error_info}}

## v2.global_product.update_price
`POST /api/v2/global_product/update_price` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management

Update global price. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2021-05-17: Add CNSC introduction in API description; 2021-03-29: global_model_id update to no required

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int | ✔ | ID of global item. |
| `price_list` | object[] | ✔ | Price setting for global model. Limit is [1,50]. |
| `↳ global_model_id` | int |  | ID of global model. |
| `↳ original_price` | float | ✔ | Original price of global item. |

Lỗi riêng: The expired add on deal can't be edited · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Wrong model_id. · Update original_price failed, please try later. · Global item not found. · Original_price must bigger than 0. · Global model no found. · Our system is taking some time to respond, please try later.

## v2.global_product.update_stock
`POST /api/v2/global_product/update_stock` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Update global stock. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2024-10-23: sunset the normal_stock; 2023-05-12: add seller_stock parameter; 2021-05-17: Add CNSC introduction in API description; 2021-03-29: global_model_id update to no required

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int64 | ✔ | ID of global item. |
| `stock_list` | object[] | ✔ | Stock setting for global model. Limit is [1,50]. |
| `↳ global_model_id` | int64 |  | ID of global model. |
| `↳ seller_stock` | object[] |  |  |
| `↳↳ location_id` | string |  | location_id of stock, if the merchant has 3PF shop, the location_id cannot be empty, can use the get_merchant_warehouse_location_list API to obtain the location_id list of the merchant, if the merchant does not have 3PF shop (only has normal CBSC shop), the location_id can be empty |
| `↳↳ stock` | int32 | ✔ | stock |

Lỗi riêng: The expired add on deal can't be edited · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · not all shop is upgraded and confirmed, can not edit item · Update normal_stock failed, please try later. · Global item not found. · Global_model_id and global_item_id not match. · Global model no found. · Our system is taking some time to respond, please try later.

## v2.global_product.set_sync_field
`POST /api/v2/global_product/set_sync_field` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Set auto sync field. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2022-06-17: remove category request parameter; 2022-02-09: update required type; 2021-05-17: Add CNSC introduction in API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shop_sync_list` | object[] | ✔ | Length limit is [1,50]. |
| `↳ shop_id` | int | ✔ | Id of shop. |
| `↳ shop_region` | string | ✔ | TW TH MY BR IN SG VN |
| `↳ name_and_description` | boolean | ✔ | sync name and description |
| `↳ media_information` | boolean | ✔ | sync media information |
| `↳ tier_variation_name_and_option` | boolean | ✔ | sync tier variation |
| `↳ price` | boolean | ✔ | sync price |
| `↳ days_to_ship` | boolean | ✔ | sync days to ship info |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · SIP ASHOP has no permission to all this api or Shop not upgraded or lack of service fee rate. · Shop and shop region not match. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Update item failed {{.error_info}} · Update item failed {{.error_info}} · System error, please try again later or contact the OpenAPI support team.

## v2.global_product.get_global_item_id
`GET /api/v2/global_product/get_global_item_id` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get get_global_item_id by item_id. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2022-06-17: add code demo; 2022-01-24: Update item_id_list limit; 2021-05-25: Update Request Parameter(item_id_list) sample information; 2021-05-17: Add CNSC introduction in API description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shop_id` | int | ✔ | Id of shop. |
| `item_id_list` | int[] | ✔ | Item id list. Length limit is [1,20]. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ item_id_map` | object[] |  |
| `↳↳ item_id` | int | Id of item. |
| `↳↳ global_item_id` | int | Id of global item. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · partner does not have permission to operate shop · Item_id is not found. · SIP ASHOP has no permission to all this api or Shop not upgraded or lack of service fee rate. · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Update item failed {{.error_info}} · Update item failed {{.error_info}}

## v2.global_product.category_recommend
`GET /api/v2/global_product/category_recommend` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Recommend category by item name. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2022-07-04: add global_product_cover_image request parameter; 2022-06-17: add code demo; 2021-09-16: update request parameters; 2021-07-12: update response example; 2021-06-17: update define

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_name` | string | ✔ | name of item |
| `global_product_cover_image` | string |  | Please use the image id returned by v2.media_space.upload_image api, we will ignore if this field is empty string |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ category_id` | int[] | Shopee's unique identifier for a category. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · image is unavailable · Our system is taking some time to respond, please try later. · System error, please try again later or contact the OpenAPI support team. · Update item failed {{.error_info}} · Update item failed {{.error_info}} · Image is unavailable · System error, please try again later or contact the OpenAPI support team.

## v2.global_product.get_recommend_attribute
`GET /api/v2/global_product/get_recommend_attribute` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get recommend attributes. Only for China mainland sellers and Korean sellers.

Lịch sử cập nhật: 2022-06-17: add code demo; 2021-10-13: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_name` | string | ✔ | Name of item. |
| `category_id` | int | ✔ | ID of category. |
| `cover_image_id` | string |  | ID of image. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ attribute_list` | object[] | Attribute info list. |
| `↳↳ attribute_id` | int | ID of attribute. |
| `↳↳ attribute_value_list` | object[] | Value list of this attribute. |
| `↳↳↳ value_id` | int | ID of attribute value. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway

## v2.global_product.get_shop_publishable_status
`GET /api/v2/global_product/get_shop_publishable_status` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get publishable shop list for global item in pages.

Lịch sử cập nhật: 2024-02-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `global_item_id` | int | ✔ | Id of global item. |
| `offset` | int | ✔ | Specifies the starting entry of data to return in the current call. Default is 0. if data is more than one page, the offset can be some entry to start next call. |
| `page_size` | int | ✔ | the size of one page.Max=100 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ shop_publishable_status_list` | object[] | Detail of publishable shops. |
| `↳↳ shop_id` | int | Id of publishable shop. |
| `↳↳ region` | string | Region of published shop. |
| `↳↳ shop_publishable_status` | boolean | If the shop is publishable, ture means shop is publishable, fals means shop is unpublishable |
| `↳↳ unpublishable_reason` | string | Return the unpublishable reason. If the shop is publishable, will return empty for this field. |
| `↳ has_next_page` | boolean | This is to indicate whether the item list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of items. |
| `↳ next_offset` | int | if has_next_page is true, this value need set to next request.offset |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway

## v2.global_product.get_variations
`GET /api/v2/global_product/get_variations` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get the standardized tier variation defined by Shopee, which is currently a three-layer tree structure. The top layer is variations, the second layer is groups, groups are used to divide options, and the third layer is options.

Lịch sử cập nhật: 2024-03-26: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `category_id` | int | ✔ | Leaf category id |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object |  |
| `standardise_variation_list` | object[] |  |
| `↳ variation_id` | int64 |  |
| `↳ variation_name` | string |  |
| `↳ variation_group_list` | object[] |  |
| `↳↳ variation_group_id` | int64 |  |
| `↳↳ variation_group_name` | string |  |
| `↳↳ variation_option_list` | object[] |  |
| `↳↳↳ variation_option_id` | int64 |  |
| `↳↳↳ variation_option_name` | string |  |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway

## v2.global_product.get_size_chart_detail
`GET /api/v2/global_product/get_size_chart_detail` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get new size chart detail

Lịch sử cập nhật: 2024-11-14: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `size_chart_id` | int32 | ✔ |  |
| `language` | string |  | language should be in the list: ["en", "zh-Hans"] |

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
| `↳↳↳↳ unit` | string | the unit of this size measurement. |
| `↳↳↳↳ display_name` | string | name of column header (measurement) |
| `↳↳↳ measurement_value_list` | object[] | the list of measurement value |
| `↳↳↳↳ value` | float | if the input_type of measurement is single input number, measurement will have one value which is returned by this field. |
| `↳↳↳↳ min_value` | float | if the input_type of measurement is input range number, measurement will be a range which is returned by 2 fields: min_value and max_value. |
| `↳↳↳↳ max_value` | float | if the input_type of measurement is input range number, measurement will be a range which is returned by 2 fields: min_value and max_value. |
| `↳↳↳↳ option` | string | if the input_type of measurement is single dropdown, measurement will have one value which is returned by this field. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway

## v2.global_product.get_size_chart_list 
`GET /api/v2/global_product/get_size_chart_list` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Get size chart list

Lịch sử cập nhật: 2026-07-01: chat拼写错误，改为chart; 2024-11-14: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `category_id` | int64 | ✔ |  |
| `page_size` | int32 | ✔ |  |
| `cursor` | string | ✔ |  |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ size_chart_list` | object[] |  |
| `↳↳ size_chart_id` | int |  |
| `↳ total_count` | int |  |
| `↳ next_cursor` | string |  |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway

## v2.global_product.search_global_attribute_value_list
`POST /api/v2/global_product/search_global_attribute_value_list` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management

this api is for searching attribute value list for attribute with support_search_value flag

Lịch sử cập nhật: 2025-01-13: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `attribute_id` | int32 | ✔ |  |
| `value_name` | string |  |  |
| `cursor` | int64 | ✔ |  |
| `limit` | int64 | ✔ | The range is 1 to 100 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `msg` | string |  |
| `debug_message` | string |  |
| `response` | object |  |
| `↳ value_list` | object[] |  |
| `↳↳ value_id` | int64 |  |
| `↳↳ value_name` | string |  |
| `↳ page_info` | object |  |
| `↳↳ cursor` | int64 |  |
| `↳↳ has_next` | boolean |  |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway

## v2.global_product.get_local_adjustment_rate
`GET /api/v2/global_product/get_local_adjustment_rate` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management

Retrieves the adjustment rate that converts CB stock price into local-warehouse price for a specific shop.

Lịch sử cập nhật: 2025-07-14: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `shop_id` | int64 | ✔ | The unique identifier of the shop whose adjustment rate is being queried |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ local_adjustment_rate` | float | The multiplier used to adjust the cross-border original price to local price |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway

## v2.global_product.update_local_adjustment_rate
`POST /api/v2/global_product/update_local_adjustment_rate` · loại: Merchant · app được gọi: ERP System, Seller In House System, Product Management

A multiplier that automatically converts your CB stock price into the local-warehouse price. It ensures your local inventory prices reflect regional costs, currency factors, and margin targets.

Lịch sử cập nhật: 2025-07-14: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `adjustment_rate` | float | ✔ | The multiplier used to adjust the cross-border original price to local price |
| `shop_id` | int64 | ✔ | The unique identifier of the shop to which the adjustment rate applies |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway

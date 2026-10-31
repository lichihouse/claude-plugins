# Module SBS (6 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.sbs.get_bound_whs_info
`GET /api/v2/sbs/get_bound_whs_info` · loại: Shop · app được gọi: ERP System, Seller In House System, Swam ERP

get bound warehouse by shop id

Lịch sử cập nhật: 2025-05-15: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ list` | object[] |  |
| `↳↳ shop_id` | int64 |  |
| `↳↳ bound_whs` | object[] |  |
| `↳↳↳ whs_region` | string | the warehouse region bound with the shop |
| `↳↳↳ whs_ids` | string | the warehouse id bound with the shop |

Lỗi riêng: parse data failed · data not exist · parameter invalid · Parameters in the request are invalid, {msg} · Parse the request failed · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · The server encountered an internal error, please retry or contact the server administrator

## v2.sbs.get_current_inventory
`GET /api/v2/sbs/get_current_inventory` · loại: Shop · app được gọi: ERP System, Seller In House System, Swam ERP

Get Seller Center Current Inventory Page Data

Lịch sử cập nhật: 2025-05-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 |  | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. If empty, the default value is 1. |
| `page_size` | int32 |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. If empty, the default value is 10. The value should be between 1 and 100. |
| `search_type` | int32 |  | 0-All data；1-Product Name；2-SKU ID；3-Variations；4-Item ID |
| `keyword` | string |  | Bind Value and Search_type |
| `whs_ids` | string |  | Whs ID list, comma-separated |
| `not_moving_tag` | int32 |  | Blank-All；0-No；1-Yes |
| `inbound_pending_approval` | int64 |  | Blank-All；0-No；1-Yes |
| `products_with_inventory` | int32 |  | Blank-All；0-No；1-Yes |
| `category_id` | int64 |  | Category id. Here you need to call the get_category API to retrieve the first-tier category_id. |
| `stock_levels` | string |  | 1-Low Stock & No Sellable stock; 2-Low Stock & To replenish; 3-Low Stock & Replenished; 4-Excess |
| `whs_region` | string | ✔ | The warehouse region you want to query, can only query one region in a request Optional value: BR、CN、ID、MY、MX、TH、TW、PH、VN、SG If do not pass, will get error "block by gateway due to invalid cid" |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ item_list` | object[] | Data list of item sku |
| `↳↳ warehouse_item_id` | string | Warehouse item id; To indicate an unique item in a warehouse one warehouse item id can match with multiple shop_item_id For Global Item, warehouse_item_id=Global Item id For Local Item, shop_item_id=item_id |
| `↳↳ item_name` | string | item name |
| `↳↳ item_image` | string | item image |
| `↳↳ sku_list` | object[] | Data list of mtsku |
| `↳↳↳ mtsku_id` | string | mtsku id |
| `↳↳↳ model_id` | string | Warehouse model SKU ID For CB global items, this is equal to the global model_id. For local items, it differs from model_id; use shop_model_id to match the model_id |
| `↳↳↳ fulfill_mapping_mode` | int32 | 0-Null；1-Bundle SKU；2-Parent SKU |
| `↳↳↳ model_name` | string | model name |
| `↳↳↳ not_moving_tag` | int32 |  |
| `↳↳↳ whs_list` | object[] | Info of whs |
| `↳↳↳↳ whs_id` | string | Warehouse ID |
| `↳↳↳↳ stock_level` | int32 | -1-No need to calculate stock level；0-None；1-Low Stock & No Sellable stock; 2-Low Stock & To replenish; 3-Low Stock & Replenished; 4-Excess |
| `↳↳↳↳ ir_approval_qty` | int64 | IR approval but no ASN generated will be included |
| `↳↳↳↳ in_transit_pending_putaway_qty` | int64 | ASN in-transit，ASN pending putaway, Move transfer in transit and Move transfer pending putaway will be included |
| `↳↳↳↳ sellable_qty` | int64 | Stocks that are available for sale. This includes warehouse sellable stock, move transfer & rack transfer reserved stock that available for sale, pre-order stock.This quantity may be greater than qty displayed to buyers as it includes stock reserved for upcoming promotions. |
| `↳↳↳↳ reserved_qty` | int64 | Stocks reserved by buyer order, RTS. And also includes rack transfer reserved stock that are not available for sale |
| `↳↳↳↳ unsellable_qty` | int64 | Stocks in the warehouse that are not available for sale. This includes damaged stocks, isolated stock due to expired/near expiring, in warehouse staging location, missing, etc. |
| `↳↳↳↳ excess_stock` | int64 | Number of units that are above 6 days of sales coverage Days. |
| `↳↳↳↳ coverage_days` | float | Days that the current sellable and pending inbound inventory are expected to last based on current selling speed. |
| `↳↳↳↳ in_whs_coverage_days` | float | Days that the current sellable inventory are expected to last based on current selling speed. |
| `↳↳↳↳ selling_speed` | float | Average daily sold quantity |
| `↳↳↳↳ last_7_sold` | int64 | Sales qty last 7 days |
| `↳↳↳↳ last_15_sold` | int64 | Sales qty last 15 days |
| `↳↳↳↳ last_30_sold` | int64 | Sales qty last 30 days |
| `↳↳↳↳ last_60_sold` | int64 | Sales qty last 60 days |
| `↳↳↳↳ last_90_sold` | int64 | Sales qty last 90 days |
| `↳↳↳ shop_sku_list` | object[] |  |
| `↳↳↳↳ shop_sku_id` | string | shop level sku_id shop_sku_id="item_id" _ "model_id" |
| `↳↳↳↳ shop_item_id` | string | shop_item_id="item_id" in Product Module For Global Item, warehouse_item_id=Global Item id For Local Item, shop_item_id=item_id |
| `↳↳↳↳ shop_model_id` | string | shop_model_id= item level model_id For Global Item, warehouse_item_id=Global Item id For Local Item, shop_item_id=item_id |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.sbs.get_expiry_report
`GET /api/v2/sbs/get_expiry_report` · loại: Shop · app được gọi: ERP System, Seller In House System, Swam ERP

Seller Center Expiry Report page data

Lịch sử cập nhật: 2025-05-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 |  | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. If empty, the default value is 1. |
| `page_size` | int32 |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. If empty, the default value is 10. The value should be between 1 and 40. |
| `whs_ids` | string |  |  |
| `expiry_status` | string |  | 0-Expired，2-Expiring，4-expiry_blocked，5-damaged，6-normal。Multiple selections allowed, separated by commas. |
| `category_id_l1` | int64 |  | Only Level 1 Category can be filtered |
| `sku_id` | string |  |  |
| `item_id` | string |  |  |
| `variation` | string |  |  |
| `item_name` | string |  |  |
| `whs_region` | string | ✔ | Num value: BR、CN、ID、MY、MX、TH、TW、PH、VN、SG If do not pass, will get error "block by gateway due to invalid cid" |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ item_list` | object[] |  |
| `↳↳ warehouse_item_id` | string | Warehouse item id; To indicate an unique item in a warehouse one warehouse item id can match with multiple shop_item_id For Global Item, warehouse_item_id=Global Item id For Local Item, shop_item_id=item_id |
| `↳↳ item_name` | string |  |
| `↳↳ item_image` | string |  |
| `↳↳ sku_list` | object[] |  |
| `↳↳↳ mtsku_id` | string | Unique ID for a warehouse SKU "warehouse_item_id"_"warehouse_model_id" |
| `↳↳↳ model_id` | string | Warehouse model SKU ID For CB global items, this is equal to the global model_id. For local items, it differs from model_id; use shop_model_id to match the model_id |
| `↳↳↳ fulfill_mapping_mode` | int32 | 0-Null；1-Bundle SKU；2-Parent SKU |
| `↳↳↳ variation` | string |  |
| `↳↳↳ shop_sku_list` | object[] |  |
| `↳↳↳↳ shop_sku_id` | string | shop level sku_id shop_sku_id="item_id" _ "model_id" |
| `↳↳↳↳ shop_item_id` | string | shop_item_id="item_id" in Product Module For Global Item, warehouse_item_id=Global Item id For Local Item, shop_item_id=item_id |
| `↳↳↳↳ shop_model_id` | string | shop_model_id= item level model_id For Global Item, warehouse_item_id=Global Item id For Local Item, shop_item_id=item_id |
| `↳↳↳ whs_list` | object[] |  |
| `↳↳↳↳ whs_id` | string | warehouse ID |
| `↳↳↳↳ expiring_qty` | int64 | Stocks that are expiring soon and should be sold as soon as possible. |
| `↳↳↳↳ expired_qty` | int64 | Stock past expiry date. |
| `↳↳↳↳ expiry_blocked_qty` | int64 | Stocks that are too near to expiry and cannot be sold any more. |
| `↳↳↳↳ damaged_qty` | int64 | Stock in damaged condition and cannot be sold. |
| `↳↳↳↳ normal_qty` | int64 | Stocks that are normal. |
| `↳↳↳↳ total_qty` | int64 | Total stocks on hand. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.sbs.get_stock_aging
`GET /api/v2/sbs/get_stock_aging` · loại: Shop · app được gọi: ERP System, Seller In House System, Swam ERP

Get Seller Center Stock Aging page data

Lịch sử cập nhật: 2025-05-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 |  | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. If empty, the default value is 1. |
| `page_size` | int32 |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. If empty, the default value is 10. The value should be between 1 and 100. |
| `search_type` | int32 |  | 1-Product Name；2-SKU ID；3-Variations；4-Item ID |
| `keyword` | string |  | bound with search_type |
| `whs_ids` | string |  | split by comma |
| `aging_storage_tag` | int32 |  | 0-false；1-true |
| `excess_storage_tag` | int32 |  | 0-false；1-true |
| `category_id` | int64 |  | L1-level product category ID. You need to call the get_category API to obtain the first-level category_id |
| `whs_region` | string | ✔ | BR、CN、ID、MY、MX、TH、TW、PH、VN、SG If do not pass, will get error "block by gateway due to invalid cid" |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ item_list` | object[] | Data list of item sku |
| `↳↳ warehouse_item_id` | string | Warehouse item id; To indicate an unique item in a warehouse one warehouse item id can match with multiple shop_item_id For Global Item, warehouse_item_id=Global Item id For Local Item, shop_item_id=item_id |
| `↳↳ item_name` | string | item name |
| `↳↳ item_image` | string | item image |
| `↳↳ sku_list` | object[] | Data list of mtsku |
| `↳↳↳ mtsku_id` | string | mtsku id |
| `↳↳↳ model_id` | string | Warehouse model SKU ID For CB global items, this is equal to the global model_id. For local items, it differs from model_id; use shop_model_id to match the model_id |
| `↳↳↳ fulfill_mapping_mode` | int32 | 0-Null；1-Bundle SKU；2-Parent SKU |
| `↳↳↳ model_name` | string | model name |
| `↳↳↳ barcode` | string |  |
| `↳↳↳ whs_list` | object[] | Info of whs |
| `↳↳↳↳ whs_id` | string | Whs id |
| `↳↳↳↳ qty_of_stock_age_one` | int64 | 0-30Days |
| `↳↳↳↳ qty_of_stock_age_two` | int64 | 31-60Days |
| `↳↳↳↳ qty_of_stock_age_three` | int64 | 61-90Days |
| `↳↳↳↳ qty_of_stock_age_four` | int64 | 91-120Days |
| `↳↳↳↳ qty_of_stock_age_five` | int64 | 121-180Days |
| `↳↳↳↳ qty_of_stock_age_six` | int64 | >180Days |
| `↳↳↳↳ excess_stock` | int64 | expired stock |
| `↳↳↳↳ aging_storage_tag` | int32 |  |
| `↳↳↳ shop_sku_list` | object[] |  |
| `↳↳↳↳ shop_sku_id` | string | shop level sku_id shop_sku_id="item_id" _ "model_id" |
| `↳↳↳↳ shop_item_id` | string | shop_item_id="item_id" in Product Module For Global Item, warehouse_item_id=Global Item id For Local Item, shop_item_id=item_id |
| `↳↳↳↳ shop_model_id` | string | shop_model_id= item level model_id For Global Item, warehouse_item_id=Global Item id For Local Item, shop_item_id=item_id |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.sbs.get_stock_movement
`GET /api/v2/sbs/get_stock_movement` · loại: Shop · app được gọi: ERP System, Seller In House System, Swam ERP

Get Seller Center，Stock Movement page data

Lịch sử cập nhật: 2025-05-15: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 |  | Specifies the page number of data to return in the current call. Starting from 1. if data is more than one page, the page_no can be some entry to start next call. If empty, the default value is 1. |
| `page_size` | int32 |  | Each result set is returned as a page of entries. Use the "page_size" filters to control the maximum number of entries to retrieve per page (i.e., per call), and the "page_no" to start next call. This integer value is used to specify the maximum number of entries to return in a single "page" of data. If empty, the default value is 10. The value should be between 1 and 20. |
| `start_time` | string | ✔ | Start date in YYYY-MM-DD format. Only data within the past 1 year can be queried, and the time range must not exceed 90 days. |
| `end_time` | string | ✔ | End date in YYYY-MM-DD format. Only data within the past 1 year can be queried, and the time range must not exceed 90 days. |
| `whs_ids` | string |  | Multiple warehouse_id values should be separated by commas. |
| `category_id_l1` | int64 |  | L1-level category_id. You need to call the get_category API to retrieve the first-level category_id. |
| `sku_id` | string |  |  |
| `item_id` | string |  |  |
| `item_name` | string |  | Product Name Filter |
| `variation` | string |  |  |
| `whs_region` | string | ✔ | Warehouse Region. Enum values: BR, CN, ID, MY, MX, TH, TW, PH, VN, SG If do not pass, will get error "block by gateway due to invalid cid" |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ total` | int32 |  |
| `↳ start_time` | string |  |
| `↳ end_time` | string |  |
| `↳ query_end_time` | string |  |
| `↳ item_list` | object[] | Data list of item sku |
| `↳↳ warehouse_item_id` | string | Warehouse item id; To indicate an unique item in a warehouse one warehouse item id can match with multiple shop_item_id |
| `↳↳ item_name` | string | item name |
| `↳↳ item_image` | string | item image |
| `↳↳ sku_list` | object[] | Data list of mtsku |
| `↳↳↳ mtsku_id` | string | mtsku id |
| `↳↳↳ model_id` | string | model sku id |
| `↳↳↳ variation` | string |  |
| `↳↳↳ fulfill_mapping_mode` | int32 | 0-Null；1-Bundle SKU；2-Parent SKU |
| `↳↳↳ barcode` | string |  |
| `↳↳↳ whs_list` | object[] | Info of whs |
| `↳↳↳↳ whs_id` | string | Whs id |
| `↳↳↳↳ start_on_hand_total` | int64 | Total warehouse inventory at the start time |
| `↳↳↳↳ inbound_total` | int64 | Inbound quantity to the warehouse during the selected time period. |
| `↳↳↳↳ outbound_total` | int64 | Outbound quantity from the warehouse during the selected time period |
| `↳↳↳↳ adjust_total` | int64 | Inventory adjustment quantity in the warehouse during the selected time period |
| `↳↳↳↳ end_on_hand_total` | int64 | Total warehouse inventory at the end time. |
| `↳↳↳ start_qty` | object | Inventory information at the start time. |
| `↳↳↳↳ start_on_hand_total` | int64 | sku number at the start time |
| `↳↳↳↳ start_sellable` | int64 | Number of sellable SKUs at the start time |
| `↳↳↳↳ start_reserved` | int64 | Number of reserved SKUs at the start time. |
| `↳↳↳↳ start_unsellable` | int64 |  |
| `↳↳↳ end_qty` | object |  |
| `↳↳↳↳ end_on_hand_total` | int64 | Total inventory at the end time. |
| `↳↳↳↳ end_sellable` | int64 |  |
| `↳↳↳↳ end_reserved` | int64 |  |
| `↳↳↳↳ end_unsellable` | int64 |  |
| `↳↳↳ inbound_qty` | object | Inbound information during the selected time period |
| `↳↳↳↳ inbound_total` | int64 | Total inbound quantity during the selected time period |
| `↳↳↳↳ inbound_my` | int64 | Total merchant procurement quantity during the selected time period. |
| `↳↳↳↳ inbound_returned` | int64 | Total number of SKUs returned by buyers and received into the warehouse during the selected time period. |
| `↳↳↳ outbound_qty` | object |  |
| `↳↳↳↳ outbound_total` | int64 | Total outbound quantity during the selected time period. |
| `↳↳↳↳ outbound_sold` | int64 | "Total sold quantity during the selected time period." |
| `↳↳↳↳ outbound_returned` | int64 | Total merchant return quantity during the selected time period. |
| `↳↳↳↳ outbound_disposed` | int64 | Total disposal quantity during the selected time period. |
| `↳↳↳ adjust_qty` | object | "SKU change information during the selected time period." |
| `↳↳↳↳ adjust_total` | int64 | "Total number of SKU changes during the selected time period." |
| `↳↳↳↳ adjust_lost_found` | int64 | "Total quantity of lost or recovered items during the selected time period." |
| `↳↳↳↳ adjust_trans_whs` | int64 | Total quantity of transfer orders created by the warehouse during the selected time period |
| `↳↳↳ shop_sku_list` | object[] |  |
| `↳↳↳↳ shop_sku_id` | string | shop level sku_id shop_sku_id="item_id" _ "model_id" |
| `↳↳↳↳ shop_item_id` | string | shop_item_id="item_id" in Product Module |
| `↳↳↳↳ shop_model_id` | string | shop_model_id= item level model_id |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.sbs.get_fulfillment_mapping_inventory_list
`GET /api/v2/sbs/get_fulfillment_mapping_inventory_list` · loại: Shop · app được gọi: ERP System, Seller In House System, Swam ERP

This API is designed for sellers using Fulfillment Mapping and their ERP systems. It allows callers to query the corresponding mapping and inventory information using the MTSKU ID of either a Bundle SKU or a Parent SKU, supporting automated inventory reconciliation and planning, improving Parent SKU inventory visibility, and reducing manual operations and cross-channel overselling risks.

Lịch sử cập nhật: 2026-08-12: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `mtsku_ids` | string |  | The MTSKU ID of either a Bundle SKU or a Parent SKU in a fulfillment mapping relationship. Up to 100 comma-separated MTSKU IDs can be queried in one request. All MTSKU IDs must belong to the specified shop_id. When mtsku_ids is omitted, the API returns all fulfillment mapping records with available Bundle SKU stock under the shop. When mtsku_ids is provided, the API returns all matching fulfillment mapping records for the specified Bundle or Parent MTSKUs.For example, given the mapping relationship MTSKU A = MTSKU B + MTSKU C, MTSKU A is the Bundle SKU, while MTSKU B and MTSKU C are its Parent SKUs. The API can be queried using the MTSKU ID of A, B, or C. Regardless of which SKU is queried,  |
| `page_size` | int64 |  | The number of records returned by each query. You can fill in value from [1-100].If not filled in, the default value is 100. |
| `next_cursor` | string |  | The cursor for the next page query. The next_cursor will be returned from the response. If this field is not provided, the query starts from the first page by default. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ list` | object[] |  |
| `↳↳ bundle_mtsku_id` | string | Bundle SKU. |
| `↳↳ mapping_type` | int64 | Fulfillment mapping type. (Enum:1-group; 2-lucky bag; 3-mapping list). |
| `↳↳ whs_id` | string | Shopee warehouse id. |
| `↳↳ stock_context` | object | Stock detail. |
| `↳↳↳ physical_sellable_stock` | int64 | The physical sellable stock for bundle MTSKU without any mapping convert stock. |
| `↳↳↳ mapping_sellable_stock` | int64 | The calculated mapping sellable stock that convert from Parent MTSKUs. |
| `↳↳↳ parent_mtsku_list` | object[] |  |
| `↳↳↳↳ parent_mtsku_id` | string | The MTSKU ID of a Parent SKU involved in the fulfillment mapping relationship. |
| `↳↳↳↳ parent_mtsku_stock` | int64 | Physical sellable stock of the parent MTSKU in the specified warehouse. It is the original quantity, not multiplied by mapping_formula. Example: mapping_formula = 2*MTSKU_A + 1*MTSKU_B; MTSKU_A stock = 14; returned parent_mtsku_stock = 14. Each Bundle SKU needs two MTSKU_A, so it supports floor(14/2)=7 bundles. The returned stock remains 14, not 28. |
| `↳↳ mapping_formula` | string | The fulfillment mapping formula of the Bundle MTSKU. It describes the Parent MTSKU composition or alternative mapping relationships. Formatting rules: - The quantity before an MTSKU ID indicates the required quantity of that Parent MTSKU. - Within one mapping formula, + indicates that all listed Parent MTSKUs are required together. - For a Mapping List, [] encloses alternative mapping formulas, and , separates each alternative formula. Examples: - Group: 2 * MTSKU_A + 1 * MTSKU_B - Mapping List: [2 * MTSKU_A + 1 * MTSKU_B, 1 * MTSKU_C] - Lucky Bag: 2 * MTSKU_A |
| `↳ total` | int64 | The amount of data that meets the query conditions. |
| `↳ next_cursor` | string | If the returned value is a non-empty string, it indicates that there is more data available. Include this returned value in the next query request to continue retrieving data starting from the corresponding position indicated by the cursor. |

Lỗi riêng: Parameters in the request are invalid, {msg} · Parse the request failed · The server encountered an internal error, please retry or contact the server administrator

# Module BrandPortal (11 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.principal.get_shop_sales_performance_detail
`POST /api/v2/principal/get_shop_sales_performance_detail` · loại: Principal · app được gọi: Brand Portal Service

Queries the business performance data of stores under the specified entity within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and store-level detailed metrics.

Lịch sử cập nhật: 2026-07-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | Start date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be later than end_date . - Validation is based on the requested timezone. - The earliest selectable date is calculated as: current day in timezone - 1 day - 2 years. - The exact boundary rules depend on granularity: -- For customize, start_date must not be earlier than the earliest selectable date. -- For day, start_date must equal end_date. -- For week, start_date must be a Sunday. -- For month, start_date must be the first day of the month. -- For quarter, start_date must be the first day of the quarter. -- For year, start_date must be the firs |
| `end_date` | string | ✔ | End date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be earlier than start_date. - Validation is based on the requested timezone. - For customize, end_date must not be later than the day before the current day in the requested timezone. The inclusive date range from start_date to end_date must not exceed 366 days. - For day, end_date must equal start_date. - For week, end_date must be within the selected week range: from start_date (Sunday) to the end of that Sunday-to-Saturday week, or to the latest selectable day if the week extends beyond today. Formally: startDate ≤ endDate ≤ min(startDate + 6 da |
| `timezone` | string | ✔ | Timezone used for date boundary calculation, selectable date validation, and timestamp conversion. Limitations: - Enum values: ["GMT+7", "GMT+8", "GMT-3"] - All date validation rules are evaluated in the requested timezone. |
| `granularity` | string | ✔ | Aggregation granularity that determines the validation rules for the requested date range and the reporting period. Limitations: - Supported values are customize, day, week, month, quarter, and year. - customize is validated as a free date range and is internally queried as daily data. - day represents a single calendar day. - week requires a Sunday-based calendar week. - month requires a calendar month range. - quarter requires a calendar quarter range. - year requires a calendar year range. -Any other value is rejected as invalid_parameter. |
| `shop_list` | object[] |  | List of shops to be queried. This field is optional. If omitted or passed as an empty array, the API will return data for all shops under the specified principal_id. Limitations: - If provided, must contain at most 50 shops. - If omitted or passed as [], all shops under the specified principal_id will be queried. - If provided as a non-empty array, all shops must belong to the specified principal_id. Duplicate shops are not allowed. |
| `↳ shop_id` | int64 | ✔ | Shop identifier of the target shop to be queried. Limitations: - Required for every shop object when shop_list is provided as a non-empty array. - Must belong to the specified principal_id. |
| `↳ currency` | string |  | Currency used for amount-based metrics for the shop. Limitations: - Supported values are LOCAL and USD. - Invalid currency values are rejected as invalid_parameter. - default USD |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Business response payload. See Business Response Parameters below. |
| `↳ summary` | object[] | Aggregated summary metrics for the requested date range and selected granularity, representing the overall performance of the requested shop set. |
| `↳↳ currency` | string | currency code used for all monetary metrics of this shop item |
| `↳↳ sales` | float | Total order value (paid and unpaid) within the selected time period, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled and return/refund orders. |
| `↳↳ orders` | int64 | The number of placed orders, including unpaid orders. |
| `↳↳ units_sold` | int64 | The number of units associated with the orders placed, including unpaid orders. |
| `↳↳ average_basket_size` | float | Average Basket Size = Sales ÷ Orders. It measures average sales per order |
| `↳↳ items_per_order` | float | Items Per Order = Units Sold ÷ Orders. It measures the average number of items sold per transaction. |
| `↳↳ average_selling_price` | float | Average selling price=Sales ÷ Units Sold. It measures average sales per unit. |
| `↳↳ product_clicks` | int64 | Total number of times your item cards were clicked over the selected time period, on both App and PC. This metric is only available after 31/12/2023. |
| `↳↳ product_views` | int64 | The number of visits to the product page. |
| `↳↳ unique_visitors` | int64 | Total number of unique visitors who viewed your shop, product detail pages, or item cards in Live or Video over the selected time period. Multiple views of one page by the same visitor is counted as 1 unique visitor. This metric is only available after 31/12/2023 |
| `↳↳ item_conversion_rate` | float | Item conversion rate = Units Sold ÷ Product Views. |
| `↳↳ order_conversion_rate` | float | Number of orders divided by total number of product clicks, over the selected time period. This metric is only available after 31/12/2023 |
| `↳↳ flash_sale_sales` | float | Total flash sale order value (paid and unpaid) within the selected time period (done by both seller and platform flash sale), reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled and return/refund orders. |
| `↳↳ flash_sale_orders` | int64 | The number of placed orders, including unpaid orders.This includes flash sales done by seller and platform. |
| `↳↳ flash_sale_units_sold` | int64 | The number of units associated with the orders placed, including unpaid orders.This includes flash sales done by seller and platform. |
| `↳↳ voucher_sales` | float | Total value of all placed orders using your vouchers, including shipping fees and excluding other promotions, over the selected time period. |
| `↳↳ voucher_buyers` | int64 | Total number of unique buyers who applied your vouchers at least once, in all placed orders over the selected time period. |
| `↳↳ voucher_usage_rate` | float | Usage Rate = Vouchers Redeemed / Vouchers Claimed * 100% |
| `↳↳ voucher_cir` | float | Cost to Income Ratio (Voucher Cost/Gross Sales) measures the cost of vouchers relative to the revenue generated by the voucher from the sales of your shop's products. |
| `↳↳ voucher_cost` | float | Total cost of vouchers applied at checkout, including shipping fees and excluding other promotions, over the selected time period. |
| `↳ details` | object[] | List of shop-level detail records that returns performance metrics for each selected shop within the requested date range. |
| `↳↳ shop_id` | int64 | Shop identifier. |
| `↳↳ shop_name` | string | Shop name. |
| `↳↳ shop_region_code` | string | Shop region code. |
| `↳↳ currency` | string | currency code used for all monetary metrics of this shop item |
| `↳↳ sales` | float | Total order value (paid and unpaid) within the selected time period, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled and return/refund orders. |
| `↳↳ orders` | int64 | The number of placed orders, including unpaid orders. |
| `↳↳ units_sold` | int64 | The number of units associated with the orders placed, including unpaid orders. |
| `↳↳ average_basket_size` | float | Average Basket Size = Sales ÷ Orders. It measures average sales per order |
| `↳↳ items_per_order` | float | Items Per Order = Units Sold ÷ Orders. It measures the average number of items sold per transaction. |
| `↳↳ average_selling_price` | float | Average selling price=Sales ÷ Units Sold. It measures average sales per unit. |
| `↳↳ product_clicks` | int64 | Total number of times your item cards were clicked over the selected time period, on both App and PC. This metric is only available after 31/12/2023. |
| `↳↳ product_views` | int64 | The number of visits to the product page. |
| `↳↳ unique_visitors` | int64 | Total number of unique visitors who viewed your shop, product detail pages, or item cards in Live or Video over the selected time period. Multiple views of one page by the same visitor is counted as 1 unique visitor. This metric is only available after 31/12/2023 |
| `↳↳ item_conversion_rate` | float | Item conversion rate = Units Sold ÷ Product Views. |
| `↳↳ order_conversion_rate` | float | Number of orders divided by total number of product clicks, over the selected time period. This metric is only available after 31/12/2023 |
| `↳↳ atp_top_skus_l1d` | float | Average daily ATP% of top 80% GMV-contributing SKUs in the selected timeframe, the data will begin from 2023-10-01. |
| `↳↳ atp_top_skus_l30d` | float | Average ATP% of top 80% GMV SKUs over a rolling 30-day period in the selected timeframe, the data will begin from 2023-10-01. |
| `↳↳ atp_live_skus_l1d` | float | Average daily ATP% of all GMV-contributing SKUs in the selected timeframe, the data will begin from 2023-10-01. |
| `↳↳ atp_live_skus_l30d` | float | Average ATP% of all-GMV SKUs over a rolling 30-day period in the selected timeframe, the data will begin from 2023-10-01. |
| `↳↳ flash_sale_sales` | float | Total flash sale order value (paid and unpaid) within the selected time period (done by both seller and platform flash sale), reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled and return/refund orders. |
| `↳↳ flash_sale_orders` | int64 | The number of placed orders, including unpaid orders.This includes flash sales done by seller and platform. |
| `↳↳ flash_sale_units_sold` | int64 | The number of units associated with the orders placed, including unpaid orders.This includes flash sales done by seller and platform. |
| `↳↳ voucher_sales` | float | Total value of all placed orders using your vouchers, including shipping fees and excluding other promotions, over the selected time period. |
| `↳↳ voucher_buyers` | int64 | Total number of unique buyers who applied your vouchers at least once, in all placed orders over the selected time period. |
| `↳↳ voucher_usage_rate` | float | Usage Rate = Vouchers Redeemed / Vouchers Claimed * 100% |
| `↳↳ voucher_cir` | float | Cost to Income Ratio (Voucher Cost/Gross Sales) measures the cost of vouchers relative to the revenue generated by the voucher from the sales of your shop's products. |
| `↳↳ voucher_cost` | float | Total cost of vouchers applied at checkout, including shipping fees and excluding other promotions, over the selected time period. |

Lỗi riêng: timezone is required · timezone is invalid. allowed values: GMT+7, GMT+8, GMT-3. · granularity is required · request body is invalid · shop_id is required · shop_list contains shop that does not belong to the principal. · shop_list contains duplicate shop_id · currency is invalid · end_date is not ready, please retry later · for day granularity, start_date must equal end_date. · day range is outside the allowed selectable range. · for week granularity, end_date must be within the selected week range · for week granularity, start_date must be a Sunday. · week start_date is earlier than the earliest allowed week. · start_date cannot be later than end_date.

## v2.principal.get_principal_sales_performance_detail
`POST /api/v2/principal/get_principal_sales_performance_detail` · loại: Principal · app được gọi: Brand Portal Service

Queries the business performance data aggregated at principal level for the specified regions within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and region-level detailed metrics.

Lịch sử cập nhật: 2026-07-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | Start date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be later than end_date. - Validation is based on the requested timezone. - The earliest selectable date is calculated as: current day in timezone - 1 day - 2 years. - The exact boundary rules depend on granularity: -- For customize, start_date must not be earlier than the earliest selectable date. -- For day, start_date must equal end_date. -- For week, start_date must be a Sunday. -- For month, start_date must be the first day of the month. -- For quarter, start_date must be the first day of the quarter. -- For year, start_date must be the first |
| `end_date` | string | ✔ | End date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be earlier than start_date. - Validation is based on the requested timezone. - For customize, end_date must not be later than the day before the current day in the requested timezone. The inclusive date range from start_date to end_date must not exceed 366 days. - For day, end_date must equal start_date. - For week, end_date must be within the selected week range: from start_date (Sunday) to the end of that Sunday-to-Saturday week, or to the latest selectable day if the week extends beyond today. Formally: startDate ≤ endDate ≤ min(startDate + 6 da |
| `timezone` | string | ✔ | Timezone used for date boundary calculation, selectable date validation, and timestamp conversion. Limitations: - Enum values: [\"GMT+7\", \"GMT+8\", \"GMT-3\"] - All date validation rules are evaluated in the requested timezone. |
| `granularity` | string | ✔ | Aggregation granularity that determines the validation rules for the requested date range and the reporting period. Limitations: - Supported values are customize, day, week, month, quarter, and year. - customize is validated as a free date range and is internally queried as daily data. - day represents a single calendar day. - week requires a Sunday-based calendar week. - month requires a calendar month range. - quarter requires a calendar quarter range. - year requires a calendar year range. - Any other value is rejected as invalid_parameter. |
| `region_list` | object[] |  | List of principal regions to be queried. Limitations: - Optional. If omitted or empty, the API queries all regions that belong to the specified principal. - Duplicate region entries are deduplicated internally. - The same region must not appear multiple times with different currency values. |
| `↳ region` | string | ✔ | Target region code of the principal to be queried. Limitations: - Required for every region object in region_list. - Must be a valid region code or region name recognized by the API, such as SG or ID. |
| `↳ currency` | string |  | Currency used for amount-based metrics for the region. Limitations: - Optional for every region object in region_list. - Supported values are LOCAL and USD. - Invalid currency values are rejected as invalid_parameter. - Defaults to USD when omitted. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Business response payload. See Business Response Parameters below. |
| `↳ summary` | object[] | Aggregated summary metrics for the requested date range and selected granularity, representing the overall performance of the requested principal across the selected regions. |
| `↳↳ currency` | string | Currency code used for all monetary metrics in the summary. When multiple regions are requested, the summary currency is always USD. When exactly one region is requested, the summary currency follows that region's requested currency. |
| `↳↳ sales` | float | Total order value (paid and unpaid) within the selected time period, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled and return/refund orders. |
| `↳↳ orders` | int64 | The number of placed orders, including unpaid orders. |
| `↳↳ units_sold` | int64 | The number of units associated with the orders placed, including unpaid orders. |
| `↳↳ average_basket_size` | float | Average Basket Size = Sales ÷ Orders. It measures average sales per order. |
| `↳↳ items_per_order` | float | Items Per Order = Units Sold ÷ Orders. It measures the average number of items sold per transaction. |
| `↳↳ average_selling_price` | float | Average selling price = Sales ÷ Units Sold. It measures average sales per unit. |
| `↳↳ product_clicks` | int64 | Total number of times your item cards were clicked over the selected time period, on both App and PC. This metric is only available after 31/12/2023. |
| `↳↳ product_views` | int64 | The number of visits to the product page. |
| `↳↳ unique_visitors` | int64 | Total number of unique visitors who viewed your shop or product pages over the selected time period. Multiple views by the same visitor are counted as 1 unique visitor. This metric is only available after 31/12/2023. |
| `↳↳ item_conversion_rate` | float | Item conversion rate = Units Sold ÷ Product Views. |
| `↳↳ order_conversion_rate` | float | Number of orders divided by total number of product clicks over the selected time period. This metric is only available after 31/12/2023. |
| `↳ details` | object[] | List of region-level detail records that returns performance metrics for each selected region within the requested date range. |
| `↳↳ region` | string | Region code. |
| `↳↳ currency` | string | Currency code used for all monetary metrics of this region item. |
| `↳↳ sales` | float | Total order value (paid and unpaid) within the selected time period, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled and return/refund orders. |
| `↳↳ orders` | int64 | The number of placed orders, including unpaid orders. |
| `↳↳ units_sold` | int64 | The number of units associated with the orders placed, including unpaid orders. |
| `↳↳ average_basket_size` | float | Average Basket Size = Sales ÷ Orders. It measures average sales per order. |
| `↳↳ items_per_order` | float | Items Per Order = Units Sold ÷ Orders. It measures the average number of items sold per transaction. |
| `↳↳ average_selling_price` | float | Average selling price = Sales ÷ Units Sold. It measures average sales per unit. |
| `↳↳ product_clicks` | int64 | Total number of times your item cards were clicked over the selected time period, on both App and PC. This metric is only available after 31/12/2023. |
| `↳↳ product_views` | int64 | The number of visits to the product page. |
| `↳↳ unique_visitors` | int64 | Total number of unique visitors who viewed your shop or product pages over the selected time period. Multiple views by the same visitor are counted as 1 unique visitor. This metric is only available after 31/12/2023. |
| `↳↳ item_conversion_rate` | float | Item conversion rate = Units Sold ÷ Product Views. |
| `↳↳ order_conversion_rate` | float | Number of orders divided by total number of product clicks over the selected time period. This metric is only available after 31/12/2023. |

Lỗi riêng: timezone is required · timezone is invalid. allowed values: GMT+7, GMT+8, GMT-3. · granularity is required · request body is invalid · currency is invalid · region_list contains invalid region. · region is required · end_date is not ready, please retry later · for day granularity, start_date must equal end_date. · auth failed · start_date is required · start_date is required; start_date must use YYYY-MM-DD · end_date is required · end_date must use YYYY-MM-DD

## v2.principal.get_shop_affiliate_performance
`POST /api/v2/principal/get_shop_affiliate_performance` · loại: Principal · app được gọi: Brand Portal Service

Queries affiliate performance data for the specified shops within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and shop-level detailed metrics with placed-order and confirmed-order views.

Lịch sử cập nhật: 2026-07-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | Start date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be later than end_date. - Validation is based on the requested timezone. - The earliest selectable date is calculated as: current day in timezone - 1 day - 2 years. - The exact boundary rules depend on granularity: -- For customize, start_date must not be earlier than the earliest selectable date. -- For day, start_date must equal end_date. -- For week, start_date must be a Sunday. -- For month, start_date must be the first day of the month. -- For quarter, start_date must be the first day of the quarter. -- For year, start_date must be the first |
| `end_date` | string | ✔ | End date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be earlier than start_date. - Validation is based on the requested timezone. - For customize, end_date must not be later than the day before the current day in the requested timezone. The inclusive date range from start_date to end_date must not exceed 366 days. - For day, end_date must equal start_date. - For week, end_date must be within the selected week range: from start_date (Sunday) to the end of that Sunday-to-Saturday week, or to the latest selectable day if the week extends beyond today. Formally: startDate ≤ endDate ≤ min(startDate + 6 da |
| `timezone` | string | ✔ | Timezone used for date boundary calculation, selectable date validation, and timestamp conversion. Limitations: - Enum values: [\"GMT+7\", \"GMT+8\", \"GMT-3\"] - All date validation rules are evaluated in the requested timezone. |
| `granularity` | string | ✔ | Aggregation granularity that determines the validation rules for the requested date range and the reporting period. Limitations: - Supported values are customize, day, week, month, quarter, and year. - customize is validated as a free date range and is internally queried as daily data. - day represents a single calendar day. - week requires a Sunday-based calendar week. - month requires a calendar month range. - quarter requires a calendar quarter range. - year requires a calendar year range. - Any other value is rejected as invalid_parameter. |
| `shop_list` | object[] |  | List of shops to be queried. This field is optional. If omitted or passed as an empty array, the API will return data for all shops under the specified principal_id. Limitations: - If provided, must contain at most 50 shops. - If omitted or passed as [], all shops under the specified principal_id will be queried. - If provided as a non-empty array, all shops must belong to the specified principal_id. Duplicate shops are not allowed. |
| `↳ shop_id` | int64 | ✔ | Shop identifier of the target shop to be queried. Limitations: - Required for every shop object when shop_list is provided as a non-empty array. - Must belong to the specified principal_id. |
| `↳ currency` | string |  | Currency used for amount-based metrics for the shop. Limitations: - Optional for every shop object in shop_list. - Supported values are LOCAL and USD. - Invalid currency values are rejected as invalid_parameter. - Defaults to USD when omitted. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Business response payload. See Business Response Parameters below. |
| `↳ summary` | object[] | Aggregated summary metrics for the requested date range, representing the overall affiliate performance of the requested shop set. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics in the summary. Summary values are returned in USD. |
| `↳↳ sales_placed` | float | Total value of placed orders generated through affiliate marketing during the selected period. |
| `↳↳ sales_confirmed` | float | Total value of confirmed orders generated through affiliate marketing during the selected period. Confirmed orders are either non-Cash On Delivery (non-COD) orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `↳↳ units_sold_placed` | int64 | Total number of items sold in placed orders generated through affiliate marketing during the selected period. |
| `↳↳ units_sold_confirmed` | int64 | Total number of items sold in confirmed orders generated through affiliate marketing during the selected period. |
| `↳↳ orders_placed` | int64 | Total number of placed orders generated through affiliate marketing during the selected period. |
| `↳↳ orders_confirmed` | int64 | Total number of confirmed orders generated through affiliate marketing during the selected period. Confirmed orders are either non-Cash On Delivery (non-COD) orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `↳↳ estimated_commission_placed` | float | Estimated total payout from placed affiliate marketing orders during the selected period. |
| `↳↳ estimated_commission_confirmed` | float | Estimated total payout from confirmed affiliate marketing orders during the selected period. |
| `↳↳ roi_placed` | float | Return on Investment = Sales Placed / Estimated Commission Placed. It can be used to evaluate the efficiency of your investment in affiliate marketing. |
| `↳↳ roi_confirmed` | float | Return on Investment = Sales Confirmed / Estimated Commission Confirmed. It can be used to evaluate the efficiency of your investment in affiliate marketing. |
| `↳↳ buyers_placed` | int64 | Total number of unique buyers who placed affiliate marketing orders from your shop set during the selected period. |
| `↳↳ buyers_confirmed` | int64 | Total number of unique buyers with confirmed affiliate marketing orders from your shop set during the selected period. |
| `↳↳ new_buyers_placed` | int64 | Total number of unique new buyers who placed affiliate marketing orders from your shop set during the selected period. |
| `↳↳ new_buyers_confirmed` | int64 | Total number of unique new buyers with confirmed affiliate marketing orders from your shop set during the selected period. |
| `↳ details` | object[] | List of shop-level detail records that returns affiliate performance metrics for each selected shop within the requested date range. |
| `↳↳ region` | string | Region code of the shop. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics of this shop item. |
| `↳↳ shop_id` | int64 | Shop identifier. |
| `↳↳ shop_name` | string | Shop name. |
| `↳↳ sales_placed` | float | Total value of placed orders generated through affiliate marketing during the selected period. |
| `↳↳ sales_confirmed` | float | Total value of confirmed orders generated through affiliate marketing during the selected period. Confirmed orders are either non-Cash On Delivery (non-COD) orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `↳↳ units_sold_placed` | int64 | Total number of items sold in placed orders generated through affiliate marketing during the selected period. |
| `↳↳ units_sold_confirmed` | int64 | Total number of items sold in confirmed orders generated through affiliate marketing during the selected period. |
| `↳↳ orders_placed` | int64 | Total number of placed orders generated through affiliate marketing during the selected period. |
| `↳↳ orders_confirmed` | int64 | Total number of confirmed orders generated through affiliate marketing during the selected period. Confirmed orders are either non-Cash On Delivery (non-COD) orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `↳↳ estimated_commission_placed` | float | Estimated total payout from placed affiliate marketing orders during the selected period. |
| `↳↳ estimated_commission_confirmed` | float | Estimated total payout from confirmed affiliate marketing orders during the selected period. |
| `↳↳ roi_placed` | float | Return on Investment = Sales Placed / Estimated Commission Placed. It can be used to evaluate the efficiency of your investment in affiliate marketing. |
| `↳↳ roi_confirmed` | float | Return on Investment = Sales Confirmed / Estimated Commission Confirmed. It can be used to evaluate the efficiency of your investment in affiliate marketing. |
| `↳↳ buyers_placed` | int64 | Total number of unique buyers who placed affiliate marketing orders from this shop during the selected period. |
| `↳↳ buyers_confirmed` | int64 | Total number of unique buyers with confirmed affiliate marketing orders from this shop during the selected period. |
| `↳↳ new_buyers_placed` | int64 | Total number of unique new buyers who placed affiliate marketing orders from this shop during the selected period. |
| `↳↳ new_buyers_confirmed` | int64 | Total number of unique new buyers with confirmed affiliate marketing orders from this shop during the selected period. |

Lỗi riêng: timezone is required · timezone is invalid. allowed values: GMT+7, GMT+8, GMT-3. · granularity is required · request body is invalid · shop_id is required · shop_list contains shop that does not belong to the principal. · shop_list contains duplicate shop_id · currency is invalid · end_date is not ready, please retry later · for day granularity, start_date must equal end_date. · day range is outside the allowed selectable range. · for week granularity, end_date must be within the selected week range · for week granularity, start_date must be a Sunday. · week start_date is earlier than the earliest allowed week. · start_date cannot be later than end_date.

## v2.principal.get_principal_affiliate_performance
`POST /api/v2/principal/get_principal_affiliate_performance` · loại: Principal · app được gọi: Brand Portal Service

Queries affiliate performance data for the specified principal within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and region-level detailed metrics with placed-order and confirmed-order views.

Lịch sử cập nhật: 2026-07-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | Start date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be later than end_date. - Validation is based on the requested timezone. - The earliest selectable date is calculated as: current day in timezone - 1 day - 2 years. - The exact boundary rules depend on granularity: -- For customize, start_date must not be earlier than the earliest selectable date. -- For day, start_date must equal end_date. -- For week, start_date must be a Sunday. -- For month, start_date must be the first day of the month. -- For quarter, start_date must be the first day of the quarter. -- For year, start_date must be the first |
| `end_date` | string | ✔ | End date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be earlier than start_date. - Validation is based on the requested timezone. - For customize, end_date must not be later than the day before the current day in the requested timezone. The inclusive date range from start_date to end_date must not exceed 366 days. - For day, end_date must equal start_date. - For week, end_date must be within the selected week range: from start_date (Sunday) to the end of that Sunday-to-Saturday week, or to the latest selectable day if the week extends beyond today. Formally: startDate ≤ endDate ≤ min(startDate + 6 da |
| `timezone` | string | ✔ | Timezone used for date boundary calculation, selectable date validation, and timestamp conversion. Limitations: - Enum values: [\"GMT+7\", \"GMT+8\", \"GMT-3\"] - All date validation rules are evaluated in the requested timezone. |
| `granularity` | string | ✔ | Aggregation granularity that determines the validation rules for the requested date range and the reporting period. Limitations: - Supported values are customize, day, week, month, quarter, and year. - customize is validated as a free date range and is internally queried as daily data. - day represents a single calendar day. - week requires a Sunday-based calendar week. - month requires a calendar month range. - quarter requires a calendar quarter range. - year requires a calendar year range. - Any other value is rejected as invalid_parameter. |
| `region_list` | object[] |  | Optional list of principal regions to be queried. Limitations: - When omitted or empty, the API queries all regions belonging to the specified principal_id. - Must contain at most 100 region objects. - Every region must belong to the specified principal_id. - Duplicate region values are merged when they use the same currency. - The same region cannot appear with different currencies. |
| `↳ region` | string | ✔ | Region code to be queried. Limitations: - Required for every region object in region_list. - Must be a valid region code supported by the API. - Must belong to the specified principal_id. |
| `↳ currency` | string |  | Currency used for amount-based metrics for the region. Limitations: - Optional for every region object in region_list. - Supported values are LOCAL and USD. - Invalid currency values are rejected as invalid_parameter. - Defaults to USD when omitted. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Business response payload. See Business Response Parameters below. |
| `↳ summary` | object[] | Aggregated summary metrics for the requested date range, representing the overall affiliate performance of the requested principal. Summary values are returned only when the principal has accessible shops under the selected regions. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics in the summary. Summary values are returned in USD. |
| `↳↳ sales_placed` | float | Total value of placed orders generated through affiliate marketing during the selected period. Placed orders are orders (COD and non-COD) that buyers have successfully placed, including paid and unpaid orders. |
| `↳↳ sales_confirmed` | float | Total value of confirmed orders generated through affiliate marketing during the selected period. Confirmed orders are either non-Cash On Delivery (non-COD) orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `↳↳ units_sold_placed` | int64 | Total number of items sold in placed orders generated through affiliate marketing during the selected period. |
| `↳↳ units_sold_confirmed` | int64 | Total number of items sold in confirmed orders generated through affiliate marketing during the selected period. |
| `↳↳ orders_placed` | int64 | Total number of placed orders generated through affiliate marketing during the selected period. Placed orders are orders (COD and non-COD) that buyers have successfully placed, including paid and unpaid orders. |
| `↳↳ orders_confirmed` | int64 | Total number of confirmed orders generated through affiliate marketing during the selected period. Confirmed orders are either non-Cash On Delivery (non-COD) orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `↳↳ estimated_commission_placed` | float | Estimated total payout from placed affiliate marketing orders during the selected period. |
| `↳↳ estimated_commission_confirmed` | float | Estimated total payout from confirmed affiliate marketing orders during the selected period. |
| `↳↳ roi_placed` | float | Return on Investment = Sales Placed / Estimated Commission Placed. It can be used to evaluate the efficiency of your investment in affiliate marketing. |
| `↳↳ roi_confirmed` | float | Return on Investment = Sales Confirmed / Estimated Commission Confirmed. It can be used to evaluate the efficiency of your investment in affiliate marketing. |
| `↳↳ buyers_placed` | int64 | Total number of unique buyers who placed affiliate marketing orders from the selected principal during the selected period. |
| `↳↳ buyers_confirmed` | int64 | Total number of unique buyers with confirmed affiliate marketing orders from the selected principal during the selected period. |
| `↳↳ new_buyers_placed` | int64 | Total number of unique new buyers who placed affiliate marketing orders from the selected principal during the selected period. |
| `↳↳ new_buyers_confirmed` | int64 | Total number of unique new buyers with confirmed affiliate marketing orders from the selected principal during the selected period. |
| `↳ details` | object[] | List of region-level detail records that returns affiliate performance metrics for each selected region within the requested date range. Note: - Details are queried from shop-level source data and then merged into region-level results in the service layer. - For de-duplicated metrics such as buyers, new_buyers, and orders, values may differ from a true region-level de-duplicated aggregation when multiple shops in the same region share overlapping users or orders. |
| `↳↳ region` | string | Region code of this detail item. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics of this region item. |
| `↳↳ sales_placed` | float | Total value of placed orders generated through affiliate marketing during the selected period for this region. Placed orders are orders (COD and non-COD) that buyers have successfully placed, including paid and unpaid orders. |
| `↳↳ sales_confirmed` | float | Total value of confirmed orders generated through affiliate marketing during the selected period for this region. Confirmed orders are either non-Cash On Delivery (non-COD) orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `↳↳ units_sold_placed` | int64 | Total number of items sold in placed orders generated through affiliate marketing during the selected period for this region. |
| `↳↳ units_sold_confirmed` | int64 | Total number of items sold in confirmed orders generated through affiliate marketing during the selected period for this region. |
| `↳↳ orders_placed` | int64 | Total number of placed orders generated through affiliate marketing during the selected period for this region. Placed orders are orders (COD and non-COD) that buyers have successfully placed, including paid and unpaid orders. |
| `↳↳ orders_confirmed` | int64 | Total number of confirmed orders generated through affiliate marketing during the selected period for this region. Confirmed orders are either non-Cash On Delivery (non-COD) orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `↳↳ estimated_commission_placed` | float | Estimated total payout from placed affiliate marketing orders during the selected period for this region. |
| `↳↳ estimated_commission_confirmed` | float | Estimated total payout from confirmed affiliate marketing orders during the selected period for this region. |
| `↳↳ roi_placed` | float | Return on Investment = Sales Placed / Estimated Commission Placed. It can be used to evaluate the efficiency of your investment in affiliate marketing. |
| `↳↳ roi_confirmed` | float | Return on Investment = Sales Confirmed / Estimated Commission Confirmed. It can be used to evaluate the efficiency of your investment in affiliate marketing. |
| `↳↳ buyers_placed` | int64 | Total number of unique buyers who placed affiliate marketing orders from this region during the selected period. |
| `↳↳ buyers_confirmed` | int64 | Total number of unique buyers with confirmed affiliate marketing orders from this region during the selected period. |
| `↳↳ new_buyers_placed` | int64 | Total number of unique new buyers who placed affiliate marketing orders from this region during the selected period. |
| `↳↳ new_buyers_confirmed` | int64 | Total number of unique new buyers with confirmed affiliate marketing orders from this region during the selected period. |

Lỗi riêng: timezone is required · timezone is invalid. allowed values: GMT+7, GMT+8, GMT-3. · granularity is required · request body is invalid · currency is invalid · region_list contains invalid region. · region is required · end_date is not ready, please retry later · for day granularity, start_date must equal end_date. · day range is outside the allowed selectable range. · for week granularity, end_date must be within the selected week range · for week granularity, start_date must be a Sunday. · week start_date is earlier than the earliest allowed week. · start_date cannot be later than end_date. · month range is outside the allowed selectable range.

## v2.principal.get_content_affiliate_performance
`POST /api/v2/principal/get_content_affiliate_performance` · loại: Principal · app được gọi: Brand Portal Service

Queries affiliate performance data for the specified content items within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and content-level detailed metrics with placed-order and confirmed-order views.

Lịch sử cập nhật: 2026-07-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | Start date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be later than end_date. - Validation is based on the requested timezone. - The earliest selectable date is calculated as: current day in timezone - 1 day - 2 years. - The exact boundary rules depend on granularity: -- For customize, start_date must not be earlier than the earliest selectable date. -- For day, start_date must equal end_date. -- For week, start_date must be a Sunday. -- For month, start_date must be the first day of the month. -- For quarter, start_date must be the first day of the quarter. -- For year, start_date must be the first |
| `end_date` | string | ✔ | End date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be earlier than start_date. - Validation is based on the requested timezone. - For customize, end_date must not be later than the day before the current day in the requested timezone. The inclusive date range from start_date to end_date must not exceed 366 days. - For day, end_date must equal start_date. - For week, end_date must be within the selected week range: from start_date (Sunday) to the end of that Sunday-to-Saturday week, or to the latest selectable day if the week extends beyond today. Formally: startDate ≤ endDate ≤ min(startDate + 6 da |
| `timezone` | string | ✔ | Timezone used for date boundary calculation, selectable date validation, and timestamp conversion. Limitations: - Enum values: [\"GMT+7\", \"GMT+8\", \"GMT-3\"] - All date validation rules are evaluated in the requested timezone. |
| `granularity` | string | ✔ | Aggregation granularity that determines the validation rules for the requested date range and the reporting period. Limitations: - Supported values are customize, day, week, month, quarter, and year. - customize is validated as a free date range and is internally queried as daily data. - day represents a single calendar day. - week requires a Sunday-based calendar week. - month requires a calendar month range. - quarter requires a calendar quarter range. - year requires a calendar year range. - Any other value is rejected as invalid_parameter. |
| `content_list` | object[] |  | List of shops and content IDs to be queried. Limitations: - If omitted or set to [], the API returns all eligible content under the specified principal_id. - If provided, must contain 1 to 100 shop entries. - Duplicate shop_id values are not allowed. - page_size and cursor are only supported when content_list is omitted or empty. |
| `↳ shop_id` | int64 | ✔ | Shop identifier of the target shop to be queried. Limitations: - Required for every shop object in content_list. - Must belong to the specified principal_id. |
| `↳ content_ids` | int64[] | ✔ | List of content IDs under the specified shop_id to be queried. Limitations: - Required for every shop object in content_list. - Must contain 1 to 100 values. - Duplicate content_id values are not allowed within the request. |
| `↳ currency` | string |  | Currency used for amount-based metrics for the specified content items. Limitations: - Optional for every object in content_list. - Supported values are LOCAL and USD. - Invalid currency values are rejected as invalid_parameter. - Defaults to USD when omitted. |
| `page_size` | int64 |  | Number of detail records to return in the current response page. Limitations: - Only supported when content_list is omitted or an empty array. - Default value is 100. - Must be between 1 and 200, inclusive. |
| `cursor` | int64 |  | Zero-based offset of the first detail record to return. Limitations: - Only supported when content_list is omitted or an empty array. - Default value is 0. - Must be greater than or equal to 0. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Business response payload. See Business Response Parameters below. |
| `↳ summary` | object[] | Aggregated summary metrics for the requested date range, representing the overall affiliate performance of the selected content items. The summary currency is USD when multiple currencies are requested; otherwise it follows the single requested currency, or USD by default. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics in the summary. |
| `↳↳ views` | int64 | Total content views generated during the selected period. |
| `↳↳ likes` | int64 | Total content likes generated during the selected period. |
| `↳↳ comments` | int64 | Total content comments generated during the selected period. |
| `↳↳ sales_placed` | float | Total value of placed orders generated through affiliate marketing during the selected period. Placed orders are orders (COD and non-COD) that buyers have successfully placed, including paid and unpaid orders. |
| `↳↳ sales_confirmed` | float | Total value of confirmed orders generated through affiliate marketing during the selected period. Confirmed orders are either non-Cash On Delivery (non-COD) orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `↳↳ units_sold_placed` | int64 | Total number of items sold in placed orders generated through affiliate marketing during the selected period. |
| `↳↳ units_sold_confirmed` | int64 | Total number of items sold in confirmed orders generated through affiliate marketing during the selected period. |
| `↳↳ orders_placed` | int64 | Total number of placed orders generated through affiliate marketing during the selected period. Placed orders are orders (COD and non-COD) that buyers have successfully placed, including paid and unpaid orders. |
| `↳↳ orders_confirmed` | int64 | Total number of confirmed orders generated through affiliate marketing during the selected period. Confirmed orders are either non-Cash On Delivery (non-COD) orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `↳ details` | object[] | List of content-level detail records that returns affiliate performance metrics for each selected content item within the requested date range. Details are sorted by shop_id and then content_id in ascending order. |
| `↳↳ region` | string | Region code of the shop that owns this content item. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics of this content item. |
| `↳↳ shop_id` | int64 | Shop identifier that owns this content item. |
| `↳↳ shop_name` | string | Shop name that owns this content item. |
| `↳↳ content_id` | int64 | Affiliate content identifier. |
| `↳↳ content_name` | string | Affiliate content name. |
| `↳↳ views` | int64 | Total content views generated during the selected period for this content item. |
| `↳↳ likes` | int64 | Total content likes generated during the selected period for this content item. |
| `↳↳ comments` | int64 | Total content comments generated during the selected period for this content item. |
| `↳↳ sales_placed` | float | Total value of placed orders generated through affiliate marketing during the selected period for this content item. Placed orders are orders (COD and non-COD) that buyers have successfully placed, including paid and unpaid orders. |
| `↳↳ sales_confirmed` | float | Total value of confirmed orders generated through affiliate marketing during the selected period for this content item. Confirmed orders are either non-Cash On Delivery (non-COD) orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `↳↳ units_sold_placed` | int64 | Total number of items sold in placed orders generated through affiliate marketing during the selected period for this content item. |
| `↳↳ units_sold_confirmed` | int64 | Total number of items sold in confirmed orders generated through affiliate marketing during the selected period for this content item. |
| `↳↳ orders_placed` | int64 | Total number of placed orders generated through affiliate marketing during the selected period for this content item. Placed orders are orders (COD and non-COD) that buyers have successfully placed, including paid and unpaid orders. |
| `↳↳ orders_confirmed` | int64 | Total number of confirmed orders generated through affiliate marketing during the selected period for this content item. Confirmed orders are either non-Cash On Delivery (non-COD) orders that have been paid for or COD orders that have been confirmed for shipping (usually 30 mins after placing the order). |
| `↳ next_cursor` | int64 | Offset to be used in the next request for fetching the next page of detail records. Notes: - Returned only when content_list is omitted or an empty array. - Calculated as cursor + returned_detail_count. - If returned_detail_count is less than page_size, it indicates there may be no more records. - If the request is already beyond the end of the result set, the API returns 0 detail records and next_cursor remains equal to the input cursor. |

Lỗi riêng: page_size is only supported when content_list is empty. · timezone is required · timezone is invalid. allowed values: GMT+7, GMT+8, GMT-3. · granularity is required · request body is invalid · shop_id is required · currency is invalid · cursor is only supported when content_list is empty. · content_ids is required · end_date is not ready, please retry later · for day granularity, start_date must equal end_date. · day range is outside the allowed selectable range. · for week granularity, end_date must be within the selected week range · for week granularity, start_date must be a Sunday. · week start_date is earlier than the earliest allowed week.

## v2.principal.get_shop_livestream_performance
`POST /api/v2/principal/get_shop_livestream_performance` · loại: Principal · app được gọi: Brand Portal Service

Queries livestream performance data for the specified shops within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and shop-level detailed metrics.

Lịch sử cập nhật: 2026-07-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | Start date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be later than end_date. - Validation is based on the requested timezone. - The earliest selectable date is calculated as: current day in timezone - 1 day - 2 years. - The exact boundary rules depend on granularity: -- For customize, start_date must not be earlier than the earliest selectable date. -- For day, start_date must equal end_date. -- For week, start_date must be a Sunday. -- For month, start_date must be the first day of the month. -- For quarter, start_date must be the first day of the quarter. -- For year, start_date must be the first |
| `end_date` | string | ✔ | End date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be earlier than start_date. - Validation is based on the requested timezone. - For customize, end_date must not be later than the day before the current day in the requested timezone. The inclusive date range from start_date to end_date must not exceed 366 days. - For day, end_date must equal start_date. - For week, end_date must be within the selected week range: from start_date (Sunday) to the end of that Sunday-to-Saturday week, or to the latest selectable day if the week extends beyond today. Formally: startDate ≤ endDate ≤ min(startDate + 6 da |
| `timezone` | string | ✔ | Timezone used for date boundary calculation, selectable date validation, and timestamp conversion. Limitations: - Enum values: [\"GMT+7\", \"GMT+8\", \"GMT-3\"] - The API internally normalizes the open API timezone value for livestream metric queries. - All date validation rules are evaluated in the requested timezone. |
| `granularity` | string | ✔ | Aggregation granularity that determines the validation rules for the requested date range and the reporting period. Limitations: - Supported values are customize, day, week, month, quarter, and year. - customize is validated as a free date range and is internally queried with the affiliate-compatible livestream granularity. - day represents a single calendar day. - week requires a Sunday-based calendar week. - month requires a calendar month range. - quarter requires a calendar quarter range. - year requires a calendar year range. - Any other value is rejected as invalid_parameter. |
| `shop_list` | object[] |  | List of shops to be queried. This field is optional. If omitted or passed as an empty array, the API will return data for all shops under the specified principal_id. Limitations: - If provided, must contain at most 50 shops. - If omitted or passed as [], all shops under the specified principal_id will be queried. - If provided as a non-empty array, all shops must belong to the specified principal_id. Duplicate shops are not allowed. |
| `↳ shop_id` | int64 | ✔ | Shop identifier of the target shop to be queried. Limitations: - Required for every shop object when shop_list is provided as a non-empty array. - Must belong to the specified principal_id. |
| `↳ currency` | string |  | Currency used for amount-based metrics for the shop. Limitations: - Optional for every shop object in shop_list. - Supported values are LOCAL and USD. - Invalid currency values are rejected as invalid_parameter. - Defaults to USD when omitted. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Business response payload. See Business Response Parameters below. |
| `↳ summary` | object[] | Aggregated summary metrics for the requested date range, representing the overall livestream performance of the requested shop set. Summary values are returned in USD when data exists. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics in the summary. Summary values are returned in USD. |
| `↳↳ orders` | int64 | Number of placed orders (paid and unpaid) during your Livestream, including cancelled orders. |
| `↳↳ buyers` | int64 | Number of unique buyers who placed order from your Livestream. |
| `↳↳ likes` | int64 | Total number of likes in your Livestream. |
| `↳↳ comments` | int64 | Total number of comments acquired during your Livestream. |
| `↳↳ sales_gross` | float | Value of placed orders (paid and unpaid) during your Livestream, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled orders. |
| `↳↳ units_sold` | int64 | Number of items sold from placed orders during your Livestream. |
| `↳↳ total_views` | int64 | Total views from your Livestream. |
| `↳↳ total_live_duration` | int64 | Total duration of your Livestream. |
| `↳↳ unique_viewers` | int64 | Total unique viewers from your Livestream. |
| `↳↳ atc_units` | int64 | Number of Add To Cart button clicks for all products in the orange bag during your Livestream. |
| `↳↳ total_livestreams` | int64 | Total count of Livestream sessions in the selected period. |
| `↳↳ average_live_duration` | float | Average duration of your Livestream. |
| `↳↳ average_views_duration` | float | Average time viewers watch your Livestreams. |
| `↳↳ new_followers` | int64 | Total followers gained from your Livestream. |
| `↳↳ new_buyers` | int64 | Number of buyers who have not had placed orders (including paid and unpaid) via your Livestream in the past 365 days. |
| `↳↳ existing_buyers` | int64 | Number of buyers who have already had placed orders (including paid and unpaid) via your Livestream in the past 365 days. |
| `↳↳ sales_net` | float | Value of placed orders (paid and unpaid) during your Livestream, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value excludes the refund amount for all non-cancelled and invalid items. |
| `↳↳ conversion_rate` | float | Livestream orders / Livestream views. |
| `↳ details` | object[] | List of shop-level detail records that returns livestream performance metrics for each selected shop within the requested date range. |
| `↳↳ region` | string | Region code of the shop. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics of this shop item. |
| `↳↳ orders` | int64 | Number of placed orders (paid and unpaid) during your Livestream, including cancelled orders. |
| `↳↳ buyers` | int64 | Number of unique buyers who placed order from your Livestream. |
| `↳↳ likes` | int64 | Total number of likes in your Livestream. |
| `↳↳ comments` | int64 | Total number of comments acquired during your Livestream. |
| `↳↳ shop_id` | int64 | Shop identifier. |
| `↳↳ shop_name` | string | Shop name. |
| `↳↳ sales_gross` | float | Value of placed orders (paid and unpaid) during your Livestream, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled orders. |
| `↳↳ units_sold` | int64 | Number of items sold from placed orders during your Livestream. |
| `↳↳ total_views` | int64 | Total views from your Livestream. |
| `↳↳ total_live_duration` | int64 | Total duration of your Livestream. |
| `↳↳ unique_viewers` | int64 | Total unique viewers from your Livestream. |
| `↳↳ atc_units` | int64 | Number of Add To Cart button clicks for all products in the orange bag during your Livestream. |
| `↳↳ total_livestreams` | int64 | Total count of Livestream sessions in the selected period. |
| `↳↳ average_live_duration` | float | Average duration of your Livestream. |
| `↳↳ average_views_duration` | float | Average time viewers watch your Livestreams. |
| `↳↳ new_followers` | int64 | Total followers gained from your Livestream. |
| `↳↳ new_buyers` | int64 | Number of buyers who have not had placed orders (including paid and unpaid) via your Livestream in the past 365 days. |
| `↳↳ existing_buyers` | int64 | Number of buyers who have already had placed orders (including paid and unpaid) via your Livestream in the past 365 days. |
| `↳↳ sales_net` | float | Value of placed orders (paid and unpaid) during your Livestream, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value excludes the refund amount for all non-cancelled and invalid items. |
| `↳↳ conversion_rate` | float | Livestream orders / Livestream views. |

Lỗi riêng: timezone is required · timezone is invalid. allowed values: GMT+7, GMT+8, GMT-3. · granularity is required · request body is invalid · shop_id is required · shop_list contains shop that does not belong to the principal. · shop_list contains duplicate shop_id · currency is invalid · end_date is not ready, please retry later · for day granularity, start_date must equal end_date. · day range is outside the allowed selectable range. · for week granularity, end_date must be within the selected week range · for week granularity, start_date must be a Sunday. · week start_date is earlier than the earliest allowed week. · start_date cannot be later than end_date.

## v2.principal.get_principal_livestream_performance
`POST /api/v2/principal/get_principal_livestream_performance` · loại: Principal · app được gọi: Brand Portal Service

Queries livestream performance data for the specified principal within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and region-level detailed metrics.

Lịch sử cập nhật: 2026-07-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | Start date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be later than end_date. - Validation is based on the requested timezone. - The earliest selectable date is calculated as: current day in timezone - 1 day - 2 years. - The exact boundary rules depend on granularity: -- For customize, start_date must not be earlier than the earliest selectable date. -- For day, start_date must equal end_date. -- For week, start_date must be a Sunday. -- For month, start_date must be the first day of the month. -- For quarter, start_date must be the first day of the quarter. -- For year, start_date must be the first |
| `end_date` | string | ✔ | End date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be earlier than start_date. - Validation is based on the requested timezone. - For customize, end_date must not be later than the day before the current day in the requested timezone. The inclusive date range from start_date to end_date must not exceed 366 days. - For day, end_date must equal start_date. - For week, end_date must be within the selected week range: from start_date (Sunday) to the end of that Sunday-to-Saturday week, or to the latest selectable day if the week extends beyond today. Formally: startDate ≤ endDate ≤ min(startDate + 6 da |
| `timezone` | string | ✔ | Timezone used for date boundary calculation, selectable date validation, and timestamp conversion. Limitations: - Enum values: [\"GMT+7\", \"GMT+8\", \"GMT-3\"] - The API internally normalizes the open API timezone value for livestream metric queries. - All date validation rules are evaluated in the requested timezone. |
| `granularity` | string | ✔ | Aggregation granularity that determines the validation rules for the requested date range and the reporting period. Limitations: - Supported values are customize, day, week, month, quarter, and year. - customize is validated as a free date range and is internally queried with the affiliate-compatible livestream granularity. - day represents a single calendar day. - week requires a Sunday-based calendar week. - month requires a calendar month range. - quarter requires a calendar quarter range. - year requires a calendar year range. - Any other value is rejected as invalid_parameter. |
| `region_list` | object[] |  | Optional list of principal regions to be queried. Limitations: - When omitted or empty, the API queries all regions belonging to the specified principal_id except the aggregate regional bucket. - Must contain at most 100 region objects. - Every region must belong to the specified principal_id. - Duplicate region values are merged for filtering purposes. - Currency defaults to USD when omitted. - When the same region appears multiple times, the first provided currency is used. |
| `↳ region` | string | ✔ | Region code to be queried. Limitations: - Required for every region object in region_list. - Must be a valid region code supported by the API. - Must belong to the specified principal_id. |
| `↳ currency` | string |  | Currency used for amount-based metrics for the region. Limitations: - Optional for every region object in region_list. - Supported values are LOCAL and USD. - Invalid currency values are rejected as invalid_parameter. - Defaults to USD when omitted. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Business response payload. See Business Response Parameters below. |
| `↳ summary` | object[] | Aggregated summary metrics for the requested date range, representing the overall livestream performance of the selected principal. Summary values are returned in USD when data exists. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics in the summary. Summary values are returned in USD. |
| `↳↳ orders` | int64 | Number of placed orders (paid and unpaid) during your Livestream, including cancelled orders. |
| `↳↳ buyers` | int64 | Number of unique buyers who placed order from your Livestream. |
| `↳↳ likes` | int64 | Total number of likes in your Livestream. |
| `↳↳ comments` | int64 | Total number of comments acquired during your Livestream. |
| `↳↳ sales_gross` | float | Value of placed orders (paid and unpaid) during your Livestream, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled orders. |
| `↳↳ units_sold` | int64 | Number of items sold from placed orders during your Livestream. |
| `↳↳ total_views` | int64 | Total views from your Livestream. |
| `↳↳ total_live_duration` | int64 | Total duration of your Livestream. |
| `↳↳ unique_viewers` | int64 | Total unique viewers from your Livestream. |
| `↳↳ atc_units` | int64 | Number of Add To Cart button clicks for all products in the orange bag during your Livestream. |
| `↳↳ total_livestreams` | int64 | Total count of Livestream sessions in the selected period. |
| `↳↳ average_live_duration` | float | Average duration of your Livestream. |
| `↳↳ average_views_duration` | float | Average time viewers watch your Livestreams. |
| `↳↳ new_followers` | int64 | Total followers gained from your Livestream. |
| `↳↳ new_buyers` | int64 | Number of buyers who have not had placed orders (including paid and unpaid) via your Livestream in the past 365 days. |
| `↳↳ existing_buyers` | int64 | Number of buyers who have already had placed orders (including paid and unpaid) via your Livestream in the past 365 days. |
| `↳↳ sales_net` | float | Value of placed orders (paid and unpaid) during your Livestream, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value excludes the refund amount for all non-cancelled and invalid items. |
| `↳↳ conversion_rate` | float | Livestream orders / Livestream views. |
| `↳ details` | object[] | List of region-level detail records that returns livestream performance metrics for each selected region within the requested date range. Details are produced by aggregating shop-level livestream data into region-level results in the service layer. |
| `↳↳ region` | string | Region code of this detail item. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics of this region item. |
| `↳↳ orders` | int64 | Number of placed orders (paid and unpaid) during your Livestream, including cancelled orders. |
| `↳↳ buyers` | int64 | Number of unique buyers who placed order from your Livestream. |
| `↳↳ likes` | int64 | Total number of likes in your Livestream. |
| `↳↳ comments` | int64 | Total number of comments acquired during your Livestream. |
| `↳↳ sales_gross` | float | Value of placed orders (paid and unpaid) during your Livestream, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled orders. |
| `↳↳ units_sold` | int64 | Number of items sold from placed orders during your Livestream. |
| `↳↳ total_views` | int64 | Total views from your Livestream. |
| `↳↳ total_live_duration` | int64 | Total duration of your Livestream. |
| `↳↳ unique_viewers` | int64 | Total unique viewers from your Livestream. |
| `↳↳ atc_units` | int64 | Number of Add To Cart button clicks for all products in the orange bag during your Livestream. |
| `↳↳ total_livestreams` | int64 | Total count of Livestream sessions in the selected period. |
| `↳↳ average_live_duration` | float | Average duration of your Livestream. |
| `↳↳ average_views_duration` | float | Average time viewers watch your Livestreams. |
| `↳↳ new_followers` | int64 | Total followers gained from your Livestream. |
| `↳↳ new_buyers` | int64 | Number of buyers who have not had placed orders (including paid and unpaid) via your Livestream in the past 365 days. |
| `↳↳ existing_buyers` | int64 | Number of buyers who have already had placed orders (including paid and unpaid) via your Livestream in the past 365 days. |
| `↳↳ sales_net` | float | Value of placed orders (paid and unpaid) during your Livestream, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value excludes the refund amount for all non-cancelled and invalid items. |
| `↳↳ conversion_rate` | float | Livestream orders / Livestream views. |

Lỗi riêng: timezone is required · granularity is required · request body is invalid · currency is invalid · region_list contains invalid region. · region is required · end_date is not ready, please retry later · for day granularity, start_date must equal end_date. · day range is outside the allowed selectable range. · for week granularity, end_date must be within the selected week range · for week granularity, start_date must be a Sunday. · week start_date is earlier than the earliest allowed week. · start_date cannot be later than end_date. · month range is outside the allowed selectable range. · for month granularity, start_date must be the first day of month.

## v2.principal.get_session_livestream_performance
`POST /api/v2/principal/get_session_livestream_performance` · loại: Principal · app được gọi: Brand Portal Service

Queries livestream session performance data for the specified sessions within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and session-level detailed metrics.

Lịch sử cập nhật: 2026-07-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | Start date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be later than end_date. - Validation is based on the requested timezone. - The earliest selectable date is calculated as: current day in timezone - 1 day - 2 years. - The exact boundary rules depend on granularity: -- For customize, start_date must not be earlier than the earliest selectable date. -- For day, start_date must equal end_date. -- For week, start_date must be a Sunday. -- For month, start_date must be the first day of the month. -- For quarter, start_date must be the first day of the quarter. -- For year, start_date must be the first |
| `end_date` | string | ✔ | End date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be earlier than start_date. - Validation is based on the requested timezone. - For customize, end_date must not be later than the day before the current day in the requested timezone. The inclusive date range from start_date to end_date must not exceed 366 days. - For day, end_date must equal start_date. - For week, end_date must be within the selected week range: from start_date (Sunday) to the end of that Sunday-to-Saturday week, or to the latest selectable day if the week extends beyond today. Formally: startDate ≤ endDate ≤ min(startDate + 6 da |
| `timezone` | string | ✔ | Timezone used for date boundary calculation, selectable date validation, and timestamp conversion. Limitations: - Enum values: [\"GMT+7\", \"GMT+8\", \"GMT-3\"] - The API internally normalizes the open API timezone value for livestream metric queries. - All date validation rules are evaluated in the requested timezone. |
| `granularity` | string | ✔ | Aggregation granularity that determines the validation rules for the requested date range and the reporting period. Limitations: - Supported values are customize, day, week, month, quarter, and year. - customize is validated as a free date range and is internally queried with the affiliate-compatible livestream granularity. - day represents a single calendar day. - week requires a Sunday-based calendar week. - month requires a calendar month range. - quarter requires a calendar quarter range. - year requires a calendar year range. - Any other value is rejected as invalid_parameter. |
| `session_list` | object[] |  | List of livestream session query targets. Limitations: - Must contain at least one object. - Must contain at most 100 objects. - Every shop_id must belong to the specified principal_id. - Duplicate shop_id values are rejected. - Each object must provide a non-empty session_ids list. - Null session_id values are rejected. - Duplicate session_id values across the whole request are rejected. - The total number of unique session_ids across the whole request must not exceed 100. |
| `↳ shop_id` | int64 | ✔ | Shop identifier that owns the specified livestream sessions. Limitations: - Required for every object in session_list. - Must belong to the specified principal_id. |
| `↳ session_ids` | int64[] | ✔ | List of livestream session identifiers to be queried under the specified shop. Limitations: - Required for every object in session_list. - Must contain at least one session_id. - Must contain at most 100 session_ids per object. - Null session_id values are rejected. - Duplicate session_id values across the whole request are rejected. - Across the whole request, the total number of unique session_ids must not exceed 100. |
| `↳ currency` | string |  | Currency used for amount-based metrics for the specified livestream sessions. Limitations: - Optional for every object in session_list. - Supported values are LOCAL and USD. - Invalid currency values are rejected as invalid_parameter. - Defaults to USD when omitted. |
| `page_size` | int64 |  | Number of detail records to return in the current response page. Limitations: - Only supported when session_list is omitted or an empty array. - Default value is 100. - Must be between 1 and 200, inclusive. |
| `cursor` | int64 |  | Zero-based offset of the first detail record to return. Limitations: - Only supported when session_list is omitted or an empty array. - Default value is 0. - Must be greater than or equal to 0. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Business response payload. See Business Response Parameters below. |
| `↳ summary` | object[] | Aggregated summary metrics for the requested date range, representing the overall livestream session performance of the selected sessions. Summary values are returned in USD when data exists. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics in the summary. Summary values are returned in USD. |
| `↳↳ likes` | int64 | Total number of likes in the selected livestream sessions. |
| `↳↳ comments` | int64 | Total number of comments acquired during the selected livestream sessions. |
| `↳↳ buyers` | int64 | Number of unique buyers who placed orders from the selected livestream sessions. |
| `↳↳ orders` | int64 | Number of placed orders (paid and unpaid) during the selected livestream sessions, including cancelled orders. |
| `↳↳ total_views` | int64 | Total views from the selected livestream sessions. |
| `↳↳ unique_viewers` | int64 | Total unique viewers from the selected livestream sessions. |
| `↳↳ total_live_duration` | int64 | Total duration of the selected livestream sessions. |
| `↳↳ average_views_duration` | float | Average time viewers watch the selected livestream sessions. |
| `↳↳ new_followers` | int64 | Total followers gained from the selected livestream sessions. |
| `↳↳ atc_units` | int64 | Number of Add To Cart button clicks for all products in the orange bag during the selected livestream sessions. |
| `↳↳ units_sold` | int64 | Number of items sold from placed orders during the selected livestream sessions. |
| `↳↳ sales_gross` | float | Value of placed orders (paid and unpaid) during the selected livestream sessions, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled orders. |
| `↳↳ sales_net` | float | Value of placed orders (paid and unpaid) during the selected livestream sessions, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value excludes the refund amount for all non-cancelled and invalid items. |
| `↳↳ conversion_rate` | float | Livestream orders / Livestream views. |
| `↳ details` | object[] | List of livestream session-level detail records that returns performance metrics for each selected session within the requested date range. |
| `↳↳ region` | string | Region code of the shop that owns this livestream session. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics of this livestream session item. |
| `↳↳ likes` | int64 | Total number of likes in this livestream session. |
| `↳↳ comments` | int64 | Total number of comments acquired during this livestream session. |
| `↳↳ buyers` | int64 | Number of unique buyers who placed orders from this livestream session. |
| `↳↳ orders` | int64 | Number of placed orders (paid and unpaid) during this livestream session, including cancelled orders. |
| `↳↳ shop_id` | int64 | Shop identifier that owns this livestream session. |
| `↳↳ shop_name` | string | Shop name that owns this livestream session. |
| `↳↳ session_id` | int64 | Livestream session identifier. |
| `↳↳ session_name` | string | Livestream session name. |
| `↳↳ total_views` | int64 | Total views from this livestream session. |
| `↳↳ unique_viewers` | int64 | Total unique viewers from this livestream session. |
| `↳↳ total_live_duration` | int64 | Total duration of this livestream session. |
| `↳↳ average_views_duration` | float | Average time viewers watch this livestream session. |
| `↳↳ new_followers` | int64 | Total followers gained from this livestream session. |
| `↳↳ atc_units` | int64 | Number of Add To Cart button clicks for all products in the orange bag during this livestream session. |
| `↳↳ units_sold` | int64 | Number of items sold from placed orders during this livestream session. |
| `↳↳ sales_gross` | float | Value of placed orders (paid and unpaid) during this livestream session, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled orders. |
| `↳↳ sales_net` | float | Value of placed orders (paid and unpaid) during this livestream session, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value excludes the refund amount for all non-cancelled and invalid items. |
| `↳↳ conversion_rate` | float | Livestream orders / Livestream views. |
| `↳ next_cursor` | int64 | Offset to be used in the next request for fetching the next page of detail records. Notes: - Returned only when session_list is omitted or an empty array. - Calculated as cursor + returned_detail_count. - If returned_detail_count is less than page_size, it indicates there may be no more records. - If the request is already beyond the end of the result set, the API returns 0 detail records and next_cursor remains equal to the input cursor. |

Lỗi riêng: timezone is required · timezone is invalid. allowed values: GMT+7, GMT+8, GMT-3. · granularity is required · request body is invalid · shop_id is required · currency is invalid · session_ids is required · end_date is not ready, please retry later · for day granularity, start_date must equal end_date. · day range is outside the allowed selectable range. · for week granularity, end_date must be within the selected week range · for week granularity, start_date must be a Sunday. · page_size is only supported when session_list is empty · week start_date is earlier than the earliest allowed week. · start_date cannot be later than end_date.

## v2.principal.get_shop_video_performance
`POST /api/v2/principal/get_shop_video_performance` · loại: Principal · app được gọi: Brand Portal Service

Queries video performance data for the specified shops within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and shop-level detailed metrics.

Lịch sử cập nhật: 2026-07-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | Start date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be later than end_date. - Validation is based on the requested timezone. - The earliest selectable date is calculated as: current day in timezone - 1 day - 2 years. - The exact boundary rules depend on granularity: -- For customize, start_date must not be earlier than the earliest selectable date. -- For day, start_date must equal end_date. -- For week, start_date must be a Sunday. -- For month, start_date must be the first day of the month. -- For quarter, start_date must be the first day of the quarter. -- For year, start_date must be the first |
| `end_date` | string | ✔ | End date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be earlier than start_date. - Validation is based on the requested timezone. - For customize, end_date must not be later than the day before the current day in the requested timezone. The inclusive date range from start_date to end_date must not exceed 366 days. - For day, end_date must equal start_date. - For week, end_date must be within the selected week range: from start_date (Sunday) to the end of that Sunday-to-Saturday week, or to the latest selectable day if the week extends beyond today. Formally: startDate ≤ endDate ≤ min(startDate + 6 da |
| `timezone` | string | ✔ | Timezone used for date boundary calculation, selectable date validation, and timestamp conversion. Limitations: - Enum values: [\"GMT+7\", \"GMT+8\", \"GMT-3\"] - The API internally normalizes the open API timezone value for video metric queries. - All date validation rules are evaluated in the requested timezone. |
| `granularity` | string | ✔ | Aggregation granularity that determines the validation rules for the requested date range and the reporting period. Limitations: - Supported values are customize, day, week, month, quarter, and year. - customize is validated as a free date range. - day represents a single calendar day. - week requires a Sunday-based calendar week. - month requires a calendar month range. - quarter requires a calendar quarter range. - year requires a calendar year range. - Any other value is rejected as invalid_parameter. |
| `shop_list` | object[] |  | shops under the specified principal_id. Limitations: - If provided, must contain at most 50 shops. - If omitted or passed as [], all shops under the specified principal_id will be queried. - If provided as a non-empty array, all shops must belong to the specified principal_id. Duplicate shops are not allowed. |
| `↳ shop_id` | int64 | ✔ | Shop identifier of the target shop to be queried. Limitations: - Required for every shop object when shop_list is provided as a non-empty array. - Must belong to the specified principal_id. |
| `↳ currency` | string |  | Currency used for amount-based metrics for the shop. Limitations: - Optional for every shop object in shop_list. - Supported values are LOCAL and USD. - Invalid currency values are rejected as invalid_parameter. - Defaults to USD when omitted. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Business response payload. See Business Response Parameters below. |
| `↳ summary` | object[] | Aggregated summary metrics for the requested date range, representing the overall video performance of the requested shop set. Summary values are returned in USD when data exists. Note: - total_video_duration is returned only in summary. - unique_viewers and total_unique_buyers are unavailable for customize, month, quarter, year, and non-full-week weekly ranges. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics in the summary. Summary values are returned in USD. |
| `↳↳ orders` | int64 | Number of placed orders (paid and unpaid) during your Video, including cancelled orders. |
| `↳↳ likes` | int64 | Number of Like clicks from all videos. |
| `↳↳ comments` | int64 | Number of comments generated from all videos. |
| `↳↳ share` | int64 | Number of shares created from all videos. |
| `↳↳ sales` | float | Value of placed orders (paid and unpaid) from all videos in the period, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled and return/refund orders. |
| `↳↳ units_sold` | int64 | Number of items sold from placed orders during your Video. |
| `↳↳ effective_views` | int64 | Number of views from the video that lasted for more than 3 seconds. |
| `↳↳ unique_viewers` | int64 | Number of video viewers in the selected period. Note: This data is unavailable when you select by month, by quarter, by year, customize date, or a non-full weekly range. |
| `↳↳ total_video_duration` | float | Total duration of your videos in minutes. This field is returned only in summary. |
| `↳↳ atc_units` | int64 | Number of Add To Cart button clicks for all products in the orange bag during your Video. |
| `↳↳ average_video_duration` | float | Average duration of your videos in minutes. |
| `↳↳ average_views_duration` | float | Average viewing duration per video in minutes. |
| `↳↳ total_unique_buyers` | int64 | Number of unique buyers who placed order from your Video. Note: This data is unavailable when you select by month, by quarter, by year, customize date, or a non-full weekly range. |
| `↳↳ conversion_rate` | float | Video orders / effective video views. |
| `↳ details` | object[] | List of shop-level detail records that returns video performance metrics for each selected shop within the requested date range. Note: - details do not include total_video_duration. - unique_viewers and total_unique_buyers are unavailable for customize, month, quarter, year, and non-full-week weekly ranges. |
| `↳↳ region` | string | Region code of the shop. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics of this shop item. |
| `↳↳ orders` | int64 | Number of placed orders (paid and unpaid) during your Video, including cancelled orders. |
| `↳↳ likes` | int64 | Number of Like clicks from all videos. |
| `↳↳ comments` | int64 | Number of comments generated from all videos. |
| `↳↳ share` | int64 | Number of shares created from all videos. |
| `↳↳ shop_id` | int64 | Shop identifier. |
| `↳↳ shop_name` | string | Shop name. |
| `↳↳ sales` | float | Value of placed orders (paid and unpaid) from all videos in the period, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled and return/refund orders. |
| `↳↳ units_sold` | int64 | Number of items sold from placed orders during your Video. |
| `↳↳ effective_views` | int64 | Number of views from the video that lasted for more than 3 seconds. |
| `↳↳ unique_viewers` | int64 | Number of video viewers in the selected period. Note: This data is unavailable when you select by month, by quarter, by year, customize date, or a non-full weekly range. |
| `↳↳ atc_units` | int64 | Number of Add To Cart button clicks for all products in the orange bag during your Video. |
| `↳↳ average_video_duration` | float | Average duration of your videos in minutes. |
| `↳↳ average_views_duration` | float | Average viewing duration per video in minutes. |
| `↳↳ total_unique_buyers` | int64 | Number of unique buyers who placed order from your Video. Note: This data is unavailable when you select by month, by quarter, by year, customize date, or a non-full weekly range. |
| `↳↳ conversion_rate` | float | Video orders / effective video views. |

Lỗi riêng: timezone is required · timezone is invalid. allowed values: GMT+7, GMT+8, GMT-3. · granularity is required · request body is invalid · shop_id is required · shop_list contains shop that does not belong to the principal. · shop_list contains duplicate shop_id · currency is invalid · end_date is not ready, please retry later · for day granularity, start_date must equal end_date. · day range is outside the allowed selectable range. · for week granularity, end_date must be within the selected week range · for week granularity, start_date must be a Sunday. · week start_date is earlier than the earliest allowed week. · start_date cannot be later than end_date.

## v2.principal.get_principal_video_performance
`POST /api/v2/principal/get_principal_video_performance` · loại: Principal · app được gọi: Brand Portal Service

Queries video performance data for the specified principal within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and region-level detailed metrics.

Lịch sử cập nhật: 2026-07-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | Start date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be later than end_date. - Validation is based on the requested timezone. - The earliest selectable date is calculated as: current day in timezone - 1 day - 2 years. - The exact boundary rules depend on granularity: -- For customize, start_date must not be earlier than the earliest selectable date. -- For day, start_date must equal end_date. -- For week, start_date must be a Sunday. -- For month, start_date must be the first day of the month. -- For quarter, start_date must be the first day of the quarter. -- For year, start_date must be the first |
| `end_date` | string | ✔ | End date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be earlier than start_date. - Validation is based on the requested timezone. - For customize, end_date must not be later than the day before the current day in the requested timezone. The inclusive date range from start_date to end_date must not exceed 366 days. - For day, end_date must equal start_date. - For week, end_date must be within the selected week range: from start_date (Sunday) to the end of that Sunday-to-Saturday week, or to the latest selectable day if the week extends beyond today. Formally: startDate ≤ endDate ≤ min(startDate + 6 da |
| `timezone` | string | ✔ | Timezone used for date boundary calculation, selectable date validation, and timestamp conversion. Limitations: - Enum values: [\"GMT+7\", \"GMT+8\", \"GMT-3\"] - The API internally normalizes the open API timezone value for video metric queries. - All date validation rules are evaluated in the requested timezone. |
| `granularity` | string | ✔ | Aggregation granularity that determines the validation rules for the requested date range and the reporting period. Limitations: - Supported values are customize, day, week, month, quarter, and year. - customize is validated as a free date range. - day represents a single calendar day. - week requires a Sunday-based calendar week. - month requires a calendar month range. - quarter requires a calendar quarter range. - year requires a calendar year range. - Any other value is rejected as invalid_parameter. |
| `region_list` | object[] |  | Optional list of principal regions to be queried. Limitations: - When omitted or empty, the API queries all regions belonging to the specified principal_id except the aggregate regional bucket. - Must contain at most 100 region objects. - Every region must belong to the specified principal_id. - Duplicate region values are merged when they use the same currency. - The same region cannot appear with different currencies. - Currency defaults to USD when omitted. |
| `↳ region` | string | ✔ | Region code to be queried. Limitations: - Required for every region object in region_list. - Must be a valid region code supported by the API. - Must belong to the specified principal_id. |
| `↳ currency` | string |  | Currency used for amount-based metrics for the region. Limitations: - Optional for every region object in region_list. - Supported values are LOCAL and USD. - Invalid currency values are rejected as invalid_parameter. - Defaults to USD when omitted. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Business response payload. See Business Response Parameters below. |
| `↳ summary` | object[] | Aggregated summary metrics for the requested date range, representing the overall video performance of the selected principal. Summary values are returned in USD when data exists. Note: - total_video_duration is returned only in summary. - unique_viewers and total_unique_buyers are unavailable for customize, month, quarter, year, and non-full-week weekly ranges. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics in the summary. Summary values are returned in USD. |
| `↳↳ orders` | int64 | Number of placed orders (paid and unpaid) during your Video, including cancelled orders. |
| `↳↳ likes` | int64 | Number of Like clicks from all videos. |
| `↳↳ comments` | int64 | Number of comments generated from all videos. |
| `↳↳ share` | int64 | Number of shares created from all videos. |
| `↳↳ sales` | float | Value of placed orders (paid and unpaid) from all videos in the period, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled and return/refund orders. |
| `↳↳ units_sold` | int64 | Number of items sold from placed orders during your Video. |
| `↳↳ effective_views` | int64 | Number of views from the video that lasted for more than 3 seconds. |
| `↳↳ unique_viewers` | int64 | Number of video viewers in the selected period. Note: This data is unavailable when you select by month, by quarter, by year, customize date, or a non-full weekly range. |
| `↳↳ total_video_duration` | float | Total duration of your videos in minutes. This field is returned only in summary. |
| `↳↳ atc_units` | int64 | Number of Add To Cart button clicks for all products in the orange bag during your Video. |
| `↳↳ average_video_duration` | float | Average duration of your videos in minutes. |
| `↳↳ average_views_duration` | float | Average viewing duration per video in minutes. |
| `↳↳ total_unique_buyers` | int64 | Number of unique buyers who placed order from your Video. Note: This data is unavailable when you select by month, by quarter, by year, customize date, or a non-full weekly range. |
| `↳↳ conversion_rate` | float | Video orders / effective video views. |
| `↳ details` | object[] | List of region-level detail records that returns video performance metrics for each selected region within the requested date range. Note: - details do not include total_video_duration. - unique_viewers and total_unique_buyers are unavailable for customize, month, quarter, year, and non-full-week weekly ranges. |
| `↳↳ region` | string | Region code of this detail item. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics of this region item. |
| `↳↳ orders` | int64 | Number of placed orders (paid and unpaid) during your Video, including cancelled orders. |
| `↳↳ likes` | int64 | Number of Like clicks from all videos. |
| `↳↳ comments` | int64 | Number of comments generated from all videos. |
| `↳↳ share` | int64 | Number of shares created from all videos. |
| `↳↳ sales` | float | Value of placed orders (paid and unpaid) from all videos in the period, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled and return/refund orders. |
| `↳↳ units_sold` | int64 | Number of items sold from placed orders during your Video. |
| `↳↳ effective_views` | int64 | Number of views from the video that lasted for more than 3 seconds. |
| `↳↳ unique_viewers` | int64 | Number of video viewers in the selected period. Note: This data is unavailable when you select by month, by quarter, by year, customize date, or a non-full weekly range. |
| `↳↳ atc_units` | int64 | Number of Add To Cart button clicks for all products in the orange bag during your Video. |
| `↳↳ average_video_duration` | float | Average duration of your videos in minutes. |
| `↳↳ average_views_duration` | float | Average viewing duration per video in minutes. |
| `↳↳ total_unique_buyers` | int64 | Number of unique buyers who placed order from your Video. Note: This data is unavailable when you select by month, by quarter, by year, customize date, or a non-full weekly range. |
| `↳↳ conversion_rate` | float | Video orders / effective video views. |

Lỗi riêng: timezone is required · timezone is invalid. allowed values: GMT+7, GMT+8, GMT-3. · granularity is required · request body is invalid · currency is invalid · region_list contains invalid region. · region is required · end_date is not ready, please retry later · for day granularity, start_date must equal end_date. · day range is outside the allowed selectable range. · for week granularity, end_date must be within the selected week range · for week granularity, start_date must be a Sunday. · week start_date is earlier than the earliest allowed week. · start_date cannot be later than end_date. · month range is outside the allowed selectable range.

## v2.principal.get_clip_video_performance
`POST /api/v2/principal/get_clip_video_performance` · loại: Principal · app được gọi: Brand Portal Service

Queries video clip performance data for the specified videos within the selected time range. Supports request granularity by day, week, month, quarter, year, or customize, and returns both overall summary metrics and video-level detailed metrics.

Lịch sử cập nhật: 2026-07-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | Start date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be later than end_date. - Validation is based on the requested timezone. - The earliest selectable date is calculated as: current day in timezone - 1 day - 2 years. - The exact boundary rules depend on granularity: -- For customize, start_date must not be earlier than the earliest selectable date. -- For day, start_date must equal end_date. -- For week, start_date must be a Sunday. -- For month, start_date must be the first day of the month. -- For quarter, start_date must be the first day of the quarter. -- For year, start_date must be the first |
| `end_date` | string | ✔ | End date of the requested period in YYYY-MM-DD format. Limitations: - Must use the YYYY-MM-DD format. - Must be a valid calendar date. - Must not be earlier than start_date. - Validation is based on the requested timezone. - For customize, end_date must not be later than the day before the current day in the requested timezone. The inclusive date range from start_date to end_date must not exceed 366 days. - For day, end_date must equal start_date. - For week, end_date must be within the selected week range: from start_date (Sunday) to the end of that Sunday-to-Saturday week, or to the latest selectable day if the week extends beyond today. Formally: startDate ≤ endDate ≤ min(startDate + 6 da |
| `timezone` | string | ✔ | Timezone used for date boundary calculation, selectable date validation, and timestamp conversion. Limitations: - Enum values: [\"GMT+7\", \"GMT+8\", \"GMT-3\"] - The API internally normalizes the open API timezone value for video metric queries. - All date validation rules are evaluated in the requested timezone. |
| `granularity` | string | ✔ | Aggregation granularity that determines the validation rules for the requested date range and the reporting period. Limitations: - Supported values are customize, day, week, month, quarter, and year. - customize is validated as a free date range. - day represents a single calendar day. - week requires a Sunday-based calendar week. - month requires a calendar month range. - quarter requires a calendar quarter range. - year requires a calendar year range. - Any other value is rejected as invalid_parameter. |
| `video_list` | object[] |  | List of video clip query targets. Limitations: - Must contain at least one object. - Must contain at most 100 objects. - Every shop_id must belong to the specified principal_id. - Duplicate shop_id values are rejected. - Each object must provide a non-empty video_ids list. - Null video_id values are rejected. - Duplicate video_id values across the whole request are rejected. - The total number of unique video_ids across the whole request must not exceed 100. |
| `↳ shop_id` | int64 | ✔ | Shop identifier that owns the specified videos. Limitations: - Required for every object in video_list. - Must belong to the specified principal_id. |
| `↳ video_ids` | int64[] | ✔ | List of video identifiers to be queried under the specified shop. Limitations: - Required for every object in video_list. - Must contain at least one video_id. - Must contain at most 100 video_ids per object. - Null video_id values are rejected. - Duplicate video_id values across the whole request are rejected. - Across the whole request, the total number of unique video_ids must not exceed 100. |
| `↳ currency` | string |  | Currency used for amount-based metrics for the specified videos. Limitations: - Optional for every object in video_list. - Supported values are LOCAL and USD. - Invalid currency values are rejected as invalid_parameter. - Defaults to USD when omitted. |
| `page_size` | int64 |  | Number of detail records to return in the current response page. Limitations: - Only supported when video_list is omitted or an empty array. - Default value is 100. - Must be between 1 and 200, inclusive. |
| `cursor` | int64 |  | Zero-based offset of the first detail record to return. Limitations: - Only supported when video_list is omitted or an empty array. - Default value is 0. - Must be greater than or equal to 0. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Business response payload. See Business Response Parameters below. |
| `↳ summary` | object[] | Aggregated summary metrics for the requested date range, representing the overall performance of the selected videos. Note: - unique_viewers and total_unique_buyers are unavailable for customize, month, quarter, year, and non-full-week weekly ranges. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics in the summary. |
| `↳↳ total_views` | int64 | Total views from the selected videos. |
| `↳↳ unique_viewers` | int64 | Number of video viewers in the selected period. Note: This data is unavailable when you select by month, by quarter, by year, customize date, or a non-full weekly range. |
| `↳↳ video_duration` | float | Video duration in minutes. |
| `↳↳ average_views_duration` | float | Average viewing duration per video in minutes. |
| `↳↳ likes` | int64 | Number of Like clicks from the selected videos. |
| `↳↳ comments` | int64 | Number of comments generated from the selected videos. |
| `↳↳ share` | int64 | Number of shares created from the selected videos. |
| `↳↳ total_unique_buyers` | int64 | Number of unique buyers who placed order from the selected videos. Note: This data is unavailable when you select by month, by quarter, by year, customize date, or a non-full weekly range. |
| `↳↳ atc_units` | int64 | Number of Add To Cart button clicks for all products in the orange bag during the selected videos. |
| `↳↳ units_sold` | int64 | Number of items sold from placed orders during the selected videos. |
| `↳↳ orders` | int64 | Number of placed orders (paid and unpaid) during the selected videos, including cancelled orders. |
| `↳↳ sales` | float | Value of placed orders (paid and unpaid) from the selected videos in the period, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled and return/refund orders. |
| `↳↳ conversion_rate` | float | Video orders / total video views. |
| `↳ details` | object[] | List of video-level detail records that returns performance metrics for each selected video within the requested date range. Details are sorted by shop_id and then video_id in ascending order. - unique_viewers and total_unique_buyers are unavailable for customize, month, quarter, year, and non-full-week weekly ranges. |
| `↳↳ region` | string | Region code of the shop that owns this video. |
| `↳↳ currency` | string | Currency code used for all amount-based metrics of this video item. |
| `↳↳ shop_id` | int64 | Shop identifier that owns this video. |
| `↳↳ shop_name` | string | Shop name that owns this video. |
| `↳↳ video_id` | int64 | Video identifier. |
| `↳↳ video_name` | string | Video name. |
| `↳↳ total_views` | int64 | Total views from this video. |
| `↳↳ unique_viewers` | int64 | Number of video viewers in the selected period. Note: This data is unavailable when you select by month, by quarter, by year, customize date, or a non-full weekly range. |
| `↳↳ video_duration` | float | Video duration in minutes. |
| `↳↳ average_views_duration` | float | Average viewing duration per video in minutes. |
| `↳↳ likes` | int64 | Number of Like clicks from this video. |
| `↳↳ comments` | int64 | Number of comments generated from this video. |
| `↳↳ share` | int64 | Number of shares created from this video. |
| `↳↳ total_unique_buyers` | int64 | Number of unique buyers who placed order from this video. Note: This data is unavailable when you select by month, by quarter, by year, customize date, or a non-full weekly range. |
| `↳↳ atc_units` | int64 | Number of Add To Cart button clicks for all products in the orange bag during this video. |
| `↳↳ units_sold` | int64 | Number of items sold from placed orders during this video. |
| `↳↳ orders` | int64 | Number of placed orders (paid and unpaid) during this video, including cancelled orders. |
| `↳↳ sales` | float | Value of placed orders (paid and unpaid) from this video in the period, reflecting the sales amount received by sellers after deducting seller rebates. Note: This value includes sales from cancelled and return/refund orders. |
| `↳↳ conversion_rate` | float | Video orders / total video views. |
| `↳ next_cursor` | int64 | Offset to be used in the next request for fetching the next page of detail records. Notes: - Returned only when video_list is omitted or an empty array. - Calculated as cursor + returned_detail_count. - If returned_detail_count is less than page_size, it indicates there may be no more records. - If the request is already beyond the end of the result set, the API returns 0 detail records and next_cursor remains equal to the input cursor. |

Lỗi riêng: timezone is required · timezone is invalid. allowed values: GMT+7, GMT+8, GMT-3. · granularity is required · request body is invalid · page_size is only supported when video_list is empty. · cursor is only supported when video_list is empty. · shop_id is required · currency is invalid · video_ids is required · end_date is not ready, please retry later · for day granularity, start_date must equal end_date. · day range is outside the allowed selectable range. · for week granularity, end_date must be within the selected week range · for week granularity, start_date must be a Sunday. · week start_date is earlier than the earliest allowed week.

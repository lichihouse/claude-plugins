# Module BusinessInsights (1 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.business_insights.get_marketing_hot_listing（only BR now）
`POST /api/v2/business_insights/get_marketing_hot_listing` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management

Provide all metrics currently available on the Business Insights Buybox dashboard, including metrics not explicitly requested by Local (for example, CTR), covering both: Shop-level performance Product-level performance

Lịch sử cập nhật: 2026-10-09: add a sign（only for br）

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_time` | int64 | ✔ | Start of the requested time range as a Unix timestamp in seconds. |
| `end_time` | int64 | ✔ | End of the requested time range as a Unix timestamp in seconds. It must be greater than or equal to start_time. |
| `period` | string | ✔ | Time period of the requested data. Supported values are listed below. |
| `product_id_list` | string |  | Product ID list, comma-separated, e.g., 111,222,333 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `code` | int32 | Business status code. 0 indicates success. |
| `msg` | string | Business status message. The value is ok on success. |
| `result` | object[] | Metrics for every order type supported by the shop country. Non-COD shops return placed and paid; COD shops additionally return confirmed. |
| `result_order_type` | string | Order type represented by this entry. Possible values are placed, confirmed, and paid. |
| `result_key_metrics` | object | Shop-level summary metrics and time-series data for the order type. |
| `result_key_metrics_key_metrics` | object | Shop-level summary metrics for the requested period. |
| `result_key_metrics_time_series` | object[] | Shop-level metrics grouped by time bucket. |
| `result_performance` | object[] | Product-level performance sorted by sales in descending order. |
| `result_key_metrics_key_metrics_sales` | float | Sales amount for the order type. |
| `result_key_metrics_key_metrics_buyers` | int32 | Number of buyers. |
| `result_key_metrics_key_metrics_orders` | int32 | Number of orders. |
| `result_key_metrics_key_metrics_units` | int32 | Number of units sold. |
| `result_key_metrics_key_metrics_conversion_rate` | float | Conversion rate. |
| `result_key_metrics_key_metrics_product_impression` | int32 | Number of product impressions. |
| `result_key_metrics_key_metrics_product_clicks` | int32 | Number of product clicks. |
| `result_key_metrics_key_metrics_click_through_rate` | float | Product click-through rate. |
| `result_key_metrics_key_metrics_sales_pct_diff` | float | Sales change compared with the previous period. |
| `result_key_metrics_key_metrics_buyers_pct_diff` | float | Buyer-count change compared with the previous period. |
| `result_key_metrics_key_metrics_orders_pct_diff` | float | Order-count change compared with the previous period. |
| `result_key_metrics_key_metrics_units_pct_diff` | float | Units-sold change compared with the previous period. |
| `result_key_metrics_key_metrics_conversion_rate_pct_diff` | float | Conversion-rate change compared with the previous period. |
| `result_key_metrics_key_metrics_product_impression_pct_diff` | float | Product-impression change compared with the previous period. |
| `result_key_metrics_key_metrics_product_clicks_pct_diff` | float | Product-click change compared with the previous period. |
| `result_key_metrics_key_metrics_click_through_rate_pct_diff` | float | Click-through-rate change compared with the previous period. |
| `result_key_metrics_time_series_t` | int64 | Unix timestamp in seconds representing the time bucket. |
| `result_key_metrics_time_series_sales` | float | Sales amount in the time bucket. |
| `result_key_metrics_time_series_buyers` | int32 | Number of buyers in the time bucket. |
| `result_key_metrics_time_series_orders` | int32 | Number of orders in the time bucket. |
| `result_key_metrics_time_series_units` | int32 | Number of units sold in the time bucket. |
| `result_key_metrics_time_series_conversion_rate` | float | Conversion rate in the time bucket. |
| `result_key_metrics_time_series_product_impression` | int32 | Number of product impressions in the time bucket. |
| `result_key_metrics_time_series_product_clicks` | int32 | Number of product clicks in the time bucket. |
| `result_key_metrics_time_series_click_through_rate` | float | Product click-through rate in the time bucket. |
| `result_performance_item_id` | int64 | Product ID. |
| `result_performance_item_name` | string | Product name. |
| `result_performance_image` | string | Product image identifier or URL. |
| `result_performance_variation_name` | string | Product variation or model name. |
| `result_performance_status` | int32 | Product status code. |
| `result_performance_sales` | float | Sales amount for the order type. |
| `result_performance_buyers` | int32 | Number of buyers. |
| `result_performance_orders` | int32 | Number of orders. |
| `result_performance_units` | int32 | Number of units sold. |
| `result_performance_conversion_rate` | float | Conversion rate. |
| `result_performance_product_impression` | int32 | Number of product impressions. |
| `result_performance_product_clicks` | int32 | Number of product clicks. |
| `result_performance_click_through_rate` | float | Product click-through rate. |

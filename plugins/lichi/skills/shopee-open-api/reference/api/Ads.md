# Module Ads (25 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.ads.get_total_balance
`GET /api/v2/ads/get_total_balance` · loại: Shop · app được gọi: Seller In House System, Marketing, Ads Service, Ads Service App , Ads Facil

Use this API to return the seller's Real-time total balance of their ads credit including the paid credits and free credits.

Lịch sử cập nhật: 2023-08-16: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | response body |
| `↳ data_timestamp` | timestamp | This is param to indicate the time of the snapshot of total balance |
| `↳ total_balance` | float | This is seller's ads credit balance, including paid credits and free credits. |

Lỗi riêng: The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.ads.get_shop_toggle_info
`GET /api/v2/ads/get_shop_toggle_info` · loại: Shop · app được gọi: Seller In House System, Marketing, Ads Service, Ads Service App , Ads Facil

Use this API to get Shop level info - i.e. seller's toggle status is on/off

Lịch sử cập nhật: 2023-08-16: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | response body |
| `↳ data_timestamp` | timestamp | Timestamp of data in response |
| `↳ auto_top_up` | boolean | auto_top_up toggle on/off |
| `↳ campaign_surge` | boolean | campaign_surge toggle on/off |

Lỗi riêng: The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.ads.get_recommended_keyword_list
`GET /api/v2/ads/get_recommended_keyword_list` · loại: Shop · app được gọi: Seller In House System, Marketing, Ads Service, Ads Service App , Ads Facil

Use this API to get the list of Recommended keywords by item and optionally a search keyword

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2023-08-16: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `item_id` | int32 | ✔ | Shopee's unique identifier for an item. |
| `input_keyword` | string |  | The keyword seller typed in the manually add keyword window. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | response body |
| `↳ item_id` | int32 | Shopee's unique identifier for an item. |
| `↳ input_keyword` | string | The keyword seller typed in the manually add keyword window. |
| `↳ suggested_keywords` | object[] | Suggested keywords recommended from product. |
| `↳↳ keyword` | string | Keyword value (Only return the highly recommended keywords, will be sightly different from Seller Center) |
| `↳↳ quality_score` | int32 | This is a measure of how attractive your ad is and its relevance to the keyword. The higher the quality score, the higher your ad rank. Ad rank is based on this score and your bid price. |
| `↳↳ search_volume` | int32 | The number of times the keyword has been searched on Shopee in the last 30 days. The larger the search volume, the more impressions your ad will receive. |
| `↳↳ suggested_bid` | float | This is bid price suggested by Shopee algorithm for the keyword in local currency. |

Lỗi riêng: The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · Item doesn't belong to the shop. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

## v2.ads.get_recommended_item_list
`GET /api/v2/ads/get_recommended_item_list` · loại: Shop · app được gọi: Seller In House System, Marketing, Ads Service, Ads Service App , Ads Facil

Use this API to get the list of recommended SKU (Shop level) with the corresponding tag, i.e top search/best selling/best ROI tag.

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2023-08-16: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] | response body |
| `↳ item_id` | int32 | Recommended SKU's item id |
| `↳ item_status_list` | string[] | This is param to indicate the status of items, so sellers can know whether an item is eligible for ads or not. |
| `↳ sku_tag_list` | string[] | The corresponding tag (or tags) that belong to item_id, sequences follow as best selling>best ROI>top search |
| `↳ ongoing_ad_type_list` | string[] | Current status of the ad on this item. For example- no ongoing promotion, search ads, discovery ads, boost ads |

Lỗi riêng: The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.ads.get_all_cpc_ads_hourly_performance
`GET /api/v2/ads/get_all_cpc_ads_hourly_performance` · loại: Shop · app được gọi: Seller In House System, Marketing, Ads Service, Ads Service App , Ads Facil

Use this API to get Shop level CPC ads single-date hourly performance.

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2024-04-25: Update the performance metrics performance; 2023-08-16: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `performance_date` | string | ✔ | This is the parameter of the single date on which requester wants to check the hourly performance. Date in DD-MM-YYYY format. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] | response body |
| `↳ hour` | int32 | This is the parameter to indicate each hour the performance record belongs to. |
| `↳ date` | string | This is the parameter to indicate which date the performance record belongs to. |
| `↳ impression` | int32 | Number of times buyers see ads |
| `↳ clicks` | int32 | Total number of clicks on the Ad |
| `↳ ctr` | float | Ctr, click-through rate measures how often shoppers who see an ad end up clicking it. CTR = Clicks / Impressions |
| `↳ direct_order` | int32 | Buyer place an order within 7 days after clicking on the ads (item gets purchased from the clicked ads). Please kindly note that the direct_order in the API reflected to Seller Center Shopee Ads Module FE is Direct Conversions. |
| `↳ broad_order` | int32 | Buyer place an order within 7 days after clicking on the ads; (the item gets purchased as long as there are other items from the same shops got click.) Please kindly note that the broad_order in the API reflected to Seller Center Shopee Ads Module FE is Conversions. |
| `↳ direct_conversions` | float | Ad orders / total number of clicks on the Ad. (item gets purchased from the clicked ads.) Please kindly note that the direct_conversions in the API reflected to Seller Center Shopee Ads Module FE is the Direct Conversion Rate |
| `↳ broad_conversions` | float | Ad orders / total number of clicks on the Ad. (the item gets purchased as long as there are other items from the same shops got click.) Please kindly note that the broad conversions in the API reflected to Seller Center Shopee Ads Module FE is Conversion Rate |
| `↳ direct_item_sold` | int32 | item sold within 7 days after clicking on the ads. (item gets purchased from the clicked ads.) |
| `↳ broad_item_sold` | int32 | item sold within 7 days after clicking on the ads.(the item gets purchased as long as there are other items from the same shops got click.) |
| `↳ direct_gmv` | float | Total sales generated from Ad over a certain time frame Typically 7 days. (item gets purchased from the clicked ads.) |
| `↳ broad_gmv` | float | Total sales generated from Ad over a certain time frame (the item gets purchased as long as there are other items from the same shops got click.) |
| `↳ expense` | float | Ad Expenditure |
| `↳ cost_per_conversion` | float | (Cost Per Conversion) Ad's average cost per sales conversion |
| `↳ direct_roas` | float | Ad GMV/Ad Expenditure. (item gets purchased from the clicked ads.) |
| `↳ broad_roas` | float | Ad GMV/Ad Expenditure. (the item gets purchased as long as there are other items from the same shops got click.) |

Lỗi riêng: The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · The date must be today or earlier than today up to 6 months ago. · The date can't be earlier than 6 months ago. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.ads.get_all_cpc_ads_daily_performance
`GET /api/v2/ads/get_all_cpc_ads_daily_performance` · loại: Shop · app được gọi: Seller In House System, Marketing, Ads Service, Ads Service App , Ads Facil

Use this API to get Shop level CPC ads multiple-days daily performance.

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2023-08-16: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | This is the parameter to indicate the start date of the time length of performance. |
| `end_date` | string | ✔ | This is the parameter to indicate the end date of the time length of performance |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] | response body |
| `↳ date` | string | This is the parameter to indicate which date the performance record belongs to. |
| `↳ impression` | int32 | Number of times buyers see ads |
| `↳ clicks` | int32 | Total number of clicks on the Ad |
| `↳ ctr` | float | Ctr, click-through rate measures how often shoppers who see an ad end up clicking it. CTR = Clicks / Impressions |
| `↳ direct_order` | int32 | Buyer place an order within 7 days after clicking on the ads (item gets purchased from the clicked ads) Please kindly note that the direct_order in the API reflected to Seller Center - Shopee Ads Module FE is Direct Conversions. |
| `↳ broad_order` | int32 | Buyer place an order within 7 days after clicking on the ads; (the item gets purchased as long as there are other items from the same shops got click.) Please kindly note that the broad_order in the API reflected to Seller Center - Shopee Ads Module FE is Conversions . |
| `↳ direct_conversions` | float | Ad orders / total number of clicks on the Ad. (item gets purchased from the clicked ads.) Please kindly note that the direct_conversions in the API reflected to Seller Center - Shopee Ads Module FE is Direct Conversions Rate . |
| `↳ broad_conversions` | float | Ad orders / total number of clicks on the Ad. (the item gets purchased as long as there are other items from the same shops got click.) Please kindly note that the broad_conversions in the API reflected to Seller Center - Shopee Ads Module FE is Conversions Rate . |
| `↳ direct_item_sold` | int32 | item sold within 7 days after clicking on the ads. (item gets purchased from the clicked ads.) |
| `↳ broad_item_sold` | int32 | item sold within 7 days after clicking on the ads.(the item gets purchased as long as there are other items from the same shops got click.) Please kindly note that the broad_conversions in the API reflected to Advertiser Platform is Conversion Rate . |
| `↳ direct_gmv` | float | Total sales generated from Ad over a certain time frame Typically 7 days. (item gets purchased from the clicked ads.) |
| `↳ broad_gmv` | float | Total sales generated from Ad over a certain time frame (the item gets purchased as long as there are other items from the same shops got click.) |
| `↳ expense` | float | Ad Expenditure |
| `↳ cost_per_conversion` | float | (Cost Per Conversion) Ad's average cost per sales conversion |
| `↳ direct_roas` | float | Ad GMV/Ad Expenditure. (item gets purchased from the clicked ads.) |
| `↳ broad_roas` | float | Ad GMV/Ad Expenditure. (the item gets purchased as long as there are other items from the same shops got click.) |

Lỗi riêng: The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · The date must be today or earlier than today up to 6 months ago. · Date range can't be longer than 1 month. · The date can't be earlier than 6 months ago. · Start date can't be equal to end date. For single date's hourly performance data, please query hourly api. · The start date can't be later than the end date. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · parse data failed · data not exist · parameter invalid

## (coming offline soon) v2.ads.create_auto_product_ads
`POST /api/v2/ads/create_auto_product_ads` · loại: Shop · app được gọi: Seller In House System, Marketing, Ads Service, Ads Service App , Ads Facil

Use this API to create Auto Product Ads

Lịch sử cập nhật: 2024-07-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `reference_id` | string | ✔ | A random string used to prevent duplicate ads. If an ads is created successfully, subsequent request using the same reference id will fail |
| `budget` | float | ✔ | The budget set for the Auto Product Ads |
| `start_date` | string | ✔ | the start date per campaign. please kindly note that if you want to set unlimited date, you can just pass today's date as the start date |
| `end_date` | string |  | the end date of each campaign. please kindly note that if you want to set an unlimited campaign, you can keep empty for the end date field |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] | response body |
| `↳ campaign_id` | int64 | The unique identifier for a campaign |

Lỗi riêng: Account status is not normal. · No eligible SKU for auto product ads. · Invalid campaign ID for this shop. · The budget set is invalid. · The start/end date of campaign should be larger or equal to today. End date to be empty for unlimited duration. · The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Auto Product Ads (campaign id) is existing, please edit the existing one. · Only the supported HTTP method for the API is allowed. · Ads account status is Invalid. · Item status is invalid. · The start date has to be today for no end date (unlimited duration). · Item is blocked for promotion. · Item is sold out.

## (coming offline soon) v2.ads.edit_auto_product_ads
`POST /api/v2/ads/edit_auto_product_ads` · loại: Shop · app được gọi: Seller In House System, Marketing, Ads Service, Ads Service App , Ads Facil

Use this API to edit Auto Product Ads

Lịch sử cập nhật: 2026-01-20: Update actions; 2024-07-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `reference_id` | string | ✔ | A random string used to prevent duplicate ads. If an ads is created successfully, subsequent request using the same reference id will fail |
| `campaign_id` | int64 | ✔ | The unique identifier for a campaign |
| `edit_action` | string | ✔ | Actions supported: "start", "pause", "resume", "stop", "change_budget", "change_duration" |
| `budget` | float |  | The budget set for the Auto Product Ads |
| `start_date` | string |  | the start date per campaign |
| `end_date` | string |  | the end date per campaign |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] | response body |
| `↳ campaign_id` | int64 | The unique identifier for a campaign |

Lỗi riêng: Account status is not normal. · No eligible SKU for auto product ads. · Invalid campaign ID for this shop. · The budget set is invalid. · The start/end date of campaign should be larger or equal to today. End date to be empty for unlimited duration. · The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · Ads account status is Invalid. · Edit Action is invalid as per the current status of the campaign. · Item status is invalid. · The start date has to be today for no end date (unlimited duration). · Item is blocked for promotion. · Item is sold out.

## v2.ads.get_product_campaign_daily_performance
`GET /api/v2/ads/get_product_campaign_daily_performance` · loại: Shop · app được gọi: Seller In House System, Marketing, Ads Service, Ads Service App , Ads Facil

Use this API to get Product level ads multiple-days daily performance.

Lịch sử cập nhật: 2024-07-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | This is the parameter to indicate the start date of the time length of performance. |
| `end_date` | string | ✔ | This is the parameter to indicate the end date of the time length of performance |
| `campaign_id_list` | string | ✔ | The campaign ids (comma separated) you want to fetch the performance. (max 100) |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] | response body |
| `↳ shop_id` | int64 | the unique id per shop |
| `↳ region` | string | the region where each shop is under |
| `↳ campaign_list` | object[] | the list of campaign |
| `↳↳ campaign_id` | int64 | the unique id per campaign |
| `↳↳ ad_type` | string | auto, manual |
| `↳↳ campaign_placement` | string | search, discovery, all |
| `↳↳ ad_name` | string | the name of each ad |
| `↳↳ metrics_list` | object[] | the performance metric list |
| `↳↳↳ date` | string | the given date for the performance |
| `↳↳↳ impression` | int64 | The number of times shoppers see your ad. |
| `↳↳↳ clicks` | int64 | The number of times shoppers click on your ad. (Note: Shopee filters out repeated clicks from the same shopper that occur within a short time frame.) |
| `↳↳↳ ctr` | float | The click-through rate (CTR) measures how often shoppers end up clicking on your ad after seeing it. It is the number of clicks on your ad divided by the number of times your ad is seen. CTR = clicks ÷ impressions × 100%. |
| `↳↳↳ expense` | float | The amount spent on your ad. |
| `↳↳↳ broad_gmv` | float | The amount of sales revenue generated from shoppers purchasing products within 7 days of them clicking on your ad. |
| `↳↳↳ broad_order` | int64 | The number of times shoppers purchased any product from your shop within 7 days of them clicking on your ad. |
| `↳↳↳ broad_order_amount` | int64 | The total quantity of products purchased by shoppers within 7 days of them clicking on your ad. |
| `↳↳↳ broad_roi` | float | Return on ad spend (ROAS) measures how much revenue is generated by your ad relative to the cost of the ad. It is the amount of sales revenue attributed to your ad divided by the amount spent on the ad. ROAS = GMV ÷ expense. (Note: We recommend monitoring ROAS trends on a weekly basis.) |
| `↳↳↳ broad_cir` | float | The advertising cost of sales (ACOS) measures how much your ad costs relative to the revenue the ad generates. It is the amount spent on your ad divided by the amount of sales revenue attributed to the ad. ACOS = expense ÷ GMV × 100%. |
| `↳↳↳ cr` | float | The conversion rate measures how often shoppers end up purchasing something from your shop after clicking on your ad. It is the number of conversions attributed to your ad divided by the number of clicks on the ad. Conversion rate = conversions ÷ clicks × 100%. |
| `↳↳↳ cpc` | float | The cost per conversion is how much each conversion costs, on average. It is the amount spent on your ad divided by the number of conversions attributed to the ad. Cost per conversion = expense ÷ conversions. |
| `↳↳↳ direct_order` | int64 | The number of times shoppers purchased the advertised product within 7 days of them clicking on the ad. |
| `↳↳↳ direct_order_amount` | int64 | The total quantity of the advertised product purchased by shoppers within 7 days of them clicking on the ad. |
| `↳↳↳ direct_gmv` | float | The amount of sales revenue generated from shoppers purchasing the advertised product within 7 days of them clicking on the ad. |
| `↳↳↳ direct_roi` | float | The direct return on ad spend, or direct ROAS, measures how much revenue is generated from sales of the advertised product, relative to the cost of the ad. It is the amount of sales revenue for the advertised product attributed to the ad, divided by the amount spent on the ad. Direct ROAS = direct GMV ÷ expense. |
| `↳↳↳ direct_cir` | float | The direct advertising cost of sales, or direct ACOS, measures how much your ad costs relative to the revenue generated from sales of the advertised product. It is the amount spent on the ad divided by the amount of sales revenue for the advertised product that is attributed to the ad. Direct ACOS = expense ÷ direct GMV × 100%. |
| `↳↳↳ direct_cr` | float | The direct conversion rate measures how often shoppers end up purchasing the advertised product after clicking on the ad. Direct conversion rate is the number of direct conversions divided by the number of clicks. Direct conversion rate = direct conversions ÷ clicks × 100%. |
| `↳↳↳ cpdc` | float | The cost per direct conversion is how much each direct conversion costs, on average. It is the amount spent on your ad divided by the number of direct conversions attributed to the ad. Cost per direct conversion = expense ÷ direct conversions. |

Lỗi riêng: Invalid campaign ID for this shop. · The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · The date must be today or earlier than today up to 6 months ago. · Date range can't be longer than 1 month. · The date can't be earlier than 6 months ago. · Start date can't be equal to end date. For single date's hourly performance data, please query hourly api. · The start date can't be later than the end date. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · parse data failed · data not exist

## v2.ads.get_product_campaign_hourly_performance
`GET /api/v2/ads/get_product_campaign_hourly_performance` · loại: Shop · app được gọi: Seller In House System, Marketing, Ads Service, Ads Service App , Ads Facil

Use this API to get Product level ads single-day hourly performance.

Lịch sử cập nhật: 2024-07-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `performance_date` | string | ✔ | This is the parameter to indicate the start date of the time length of performance. |
| `campaign_id_list` | string | ✔ | The campaign ids (comma separated) you want to fetch the performance. (max 100) |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] | response body |
| `↳ shop_id` | int64 | Shopee's unique identifier for a shop |
| `↳ region` | string | The region where this Shop is under |
| `↳ campaign_list` | object[] | the list of campaign |
| `↳↳ campaign_id` | int64 | The unique identifier for a campaign |
| `↳↳ ad_type` | string | auto, manual |
| `↳↳ campaign_placement` | string | search, discovery, all |
| `↳↳ ad_name` | string | the name of each campaign |
| `↳↳ metrics_list` | object[] | performance metric list |
| `↳↳↳ hour` | int32 | This is the parameter to indicate each hour the performance record belongs to. |
| `↳↳↳ date` | string | This is the parameter of the single date on which requestor wants to check the hourly performance |
| `↳↳↳ impression` | int64 | The number of times shoppers see your ad. |
| `↳↳↳ clicks` | int64 | The number of times shoppers click on your ad. (Note: Shopee filters out repeated clicks from the same shopper that occur within a short time frame.) |
| `↳↳↳ ctr` | float | The click-through rate (CTR) measures how often shoppers end up clicking on your ad after seeing it. It is the number of clicks on your ad divided by the number of times your ad is seen. CTR = clicks ÷ impressions × 100%. |
| `↳↳↳ expense` | float | The amount spent on your ad. |
| `↳↳↳ broad_gmv` | float | The amount of sales revenue generated from shoppers purchasing products within 7 days of them clicking on your ad. |
| `↳↳↳ broad_order` | int64 | The number of times shoppers purchased any product from your shop within 7 days of them clicking on your ad. |
| `↳↳↳ broad_order_amount` | int64 | The total quantity of products purchased by shoppers within 7 days of them clicking on your ad. |
| `↳↳↳ broad_roi` | float | Return on ad spend (ROAS) measures how much revenue is generated by your ad relative to the cost of the ad. It is the amount of sales revenue attributed to your ad divided by the amount spent on the ad. ROAS = GMV ÷ expense. (Note: We recommend monitoring ROAS trends on a weekly basis.) |
| `↳↳↳ broad_cir` | float | The advertising cost of sales (ACOS) measures how much your ad costs relative to the revenue the ad generates. It is the amount spent on your ad divided by the amount of sales revenue attributed to the ad. ACOS = expense ÷ GMV × 100%. |
| `↳↳↳ cr` | float | The conversion rate measures how often shoppers end up purchasing something from your shop after clicking on your ad. It is the number of conversions attributed to your ad divided by the number of clicks on the ad. Conversion rate = conversions ÷ clicks × 100%. |
| `↳↳↳ cpc` | float | The cost per conversion is how much each conversion costs, on average. It is the amount spent on your ad divided by the number of conversions attributed to the ad. Cost per conversion = expense ÷ conversions. |
| `↳↳↳ direct_order` | int64 | The number of times shoppers purchased the advertised product within 7 days of them clicking on the ad. |
| `↳↳↳ direct_order_amount` | int64 | The total quantity of the advertised product purchased by shoppers within 7 days of them clicking on the ad. |
| `↳↳↳ direct_gmv` | float | The amount of sales revenue generated from shoppers purchasing the advertised product within 7 days of them clicking on the ad. |
| `↳↳↳ direct_roi` | float | The direct return on ad spend, or direct ROAS, measures how much revenue is generated from sales of the advertised product, relative to the cost of the ad. It is the amount of sales revenue for the advertised product attributed to the ad, divided by the amount spent on the ad. Direct ROAS = direct GMV ÷ expense. |
| `↳↳↳ direct_cir` | float | The direct advertising cost of sales, or direct ACOS, measures how much your ad costs relative to the revenue generated from sales of the advertised product. It is the amount spent on the ad divided by the amount of sales revenue for the advertised product that is attributed to the ad. Direct ACOS = expense ÷ direct GMV × 100%. |
| `↳↳↳ direct_cr` | float | The direct conversion rate measures how often shoppers end up purchasing the advertised product after clicking on the ad. Direct conversion rate is the number of direct conversions divided by the number of clicks. Direct conversion rate = direct conversions ÷ clicks × 100%. |
| `↳↳↳ cpdc` | float | The cost per direct conversion is how much each direct conversion costs, on average. It is the amount spent on your ad divided by the number of direct conversions attributed to the ad. Cost per direct conversion = expense ÷ direct conversions. |

Lỗi riêng: Invalid campaign ID for this shop. · The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · The date must be today or earlier than today up to 6 months ago. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later.

## v2.ads.get_product_level_campaign_id_list
`GET /api/v2/ads/get_product_level_campaign_id_list` · loại: Shop · app được gọi: Seller In House System, Marketing, Ads Service, Ads Service App , Ads Facil

Call this API to fetch all the product campaign ids displayed on advertiser platform under a specific Shop

Lịch sử cập nhật: 2024-07-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `ad_type` | string |  | Any of ["","all","auto","manual"] |
| `offset` | int64 |  | offset |
| `limit` | int64 |  | limit |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | response body |
| `↳ shop_id` | int64 | Shopee's unique identifier for a shop. |
| `↳ region` | string | Region the shop belongs to |
| `↳ has_next_page` | boolean | there are more campaigns on next page |
| `↳ campaign_list` | object[] | the list of campaigns |
| `↳↳ ad_type` | string | auto/manual |
| `↳↳ campaign_id` | int64 | the unique id per campaign |

Lỗi riêng: The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · The date can't be earlier than 6 months ago. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

## v2.ads.get_product_level_campaign_setting_info
`GET /api/v2/ads/get_product_level_campaign_setting_info` · loại: Shop · app được gọi: Seller In House System, Marketing, Ads Service, Ads Service App , Ads Facil

Call this API to fetch all the campaign setting info under this Shop.

Lịch sử cập nhật: 2024-12-10: Add item_id; 2024-07-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `info_type_list` | string | ✔ | Info type values: 1.Common Info 2.Manual Bidding Info 3.Auto Bidding Info 4.Auto Product Ads Info |
| `campaign_id_list` | string | ✔ | list of campaign ids comma separated (max 100 campaign ids) |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | response body |
| `↳ shop_id` | int64 | Shopee's unique identifier for a shop. |
| `↳ region` | string | Region the shop belongs to |
| `↳ campaign_list` | object[] | - |
| `↳↳ campaign_id` | int64 | The unique ID per campaign |
| `↳↳ common_info` | object | common_info body |
| `↳↳↳ ad_type` | string | auto, manual |
| `↳↳↳ ad_name` | string | the name of each ad |
| `↳↳↳ campaign_status` | string | ongoing, scheduled, ended, paused, deleted, closed |
| `↳↳↳ bidding_method` | string | auto, manual |
| `↳↳↳ campaign_placement` | string | search, discovery, all |
| `↳↳↳ campaign_budget` | float | The budget per campaign. Please kindly note that if the campaign budget = 0, it means the budget set for this campaign is unlimited |
| `↳↳↳ campaign_duration` | object | the duration per campaign |
| `↳↳↳↳ start_time` | int64 | The start date for each campaign. please kindly note that if this campaign is no end date, please pass today's date as the start date |
| `↳↳↳↳ end_time` | int64 | the end date per campaign. please kindly note that if it's no limit, so you don't need pass anything and if it's unlimited, the end time would return 0 |
| `↳↳↳ item_id_list` | int64[] | List of unique identifiers for all products under this campaign. If the campaign is using auto product selection it can have between zero and many products. If the campaign is using manual product selection, it has exactly one. |
| `↳↳ manual_bidding_info` | object | manual bidding info |
| `↳↳↳ enhanced_cpc` | boolean | Enhanced CPC functionality |
| `↳↳↳ selected_keywords` | object[] | selected keywords |
| `↳↳↳↳ keyword` | string | bid keywords for each campaign with search placement |
| `↳↳↳↳ status` | string | deleted, normal, reserved, blacklist |
| `↳↳↳↳ match_type` | string | exact, broad |
| `↳↳↳↳ bid_price_per_click` | float | the bid price |
| `↳↳↳ discovery_ads_locations` | object[] | the location settings |
| `↳↳↳↳ location` | string | daily_discover, you_may_also_like |
| `↳↳↳↳ status` | string | toggle on or toggle off |
| `↳↳↳↳ bid_price` | float | bid price |
| `↳↳ auto_bidding_info` | object | bidding info |
| `↳↳↳ roas_target` | float | the ROAS target for each campaign with auto bidding |
| `↳↳ auto_product_ads_info` | object[] | selected products info |
| `↳↳↳ product_name` | string | the name of product |
| `↳↳↳ status` | string | learning, ongoing, paused, ended, unavailable |
| `↳↳↳ item_id` | int64 | Unique identifier for the product. |

Lỗi riêng: Invalid campaign ID for this shop. · The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

## v2.ads.create_manual_product_ads
`POST /api/v2/ads/create_manual_product_ads` · loại: Shop · app được gọi: Seller In House System, Ads Service, Ads Service App , Ads Facil

Use this API to create Manual Selection Product Ads

Lịch sử cập nhật: 2024-10-21: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `reference_id` | string | ✔ | A random string used to prevent duplicate ads. If an ads is created successfully, subsequent request using the same reference id will fail |
| `budget` | float | ✔ | The budget set for the Auto Product Ads |
| `start_date` | string | ✔ | the start date per campaign. please kindly note that if you want to set unlimited date, you can just pass today's date as the start date |
| `end_date` | string |  | the end date of each campaign. please kindly note that if you want to set an unlimited campaign, you can keep empty for the end date field |
| `bidding_method` | string | ✔ | auto, manual |
| `item_id` | int64 | ✔ | Product ID |
| `roas_target` | float |  | the ROAS target for each campaign with auto bidding. If 0, GMV Max / ROI feature is not enabled |
| `selected_keywords` | object[] |  | selected keywords, required for manual bidding mode |
| `↳ keyword` | string | ✔ | bid keyword for each campaign |
| `↳ match_type` | string | ✔ | exact, broad |
| `↳ bid_price_per_click` | float | ✔ | the bid price of keyword |
| `discovery_ads_locations` | object[] |  | the location settings for manual bidding method |
| `↳ location` | string | ✔ | daily_discover, you_may_also_like |
| `↳ bid_price` | float | ✔ | bid price of the location |
| `enhanced_cpc` | boolean |  | Enhanced CPC functionality toggle |
| `smart_creative_setting` | string |  | Whether to use default or set on/off Smart Creative for this ad. Supported Values: "", "default", "on", "off". Empty string treated as default. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] | response body |
| `↳ campaign_id` | int64 | The unique identifier for a campaign |

Lỗi riêng: Account status is not normal. · Item is an adult item cannot have this campaign setting. · The budget set is invalid. · The start/end date of campaign should be larger or equal to today. End date to be empty for unlimited duration. · The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · Ads account status is Invalid. · Item status is invalid. · The start date has to be today for no end date (unlimited duration). · Item is blocked for promotion. · Item is sold out. · Keyword is Blacklisted. · Keyword is reserved.

## v2.ads.edit_manual_product_ad_keywords
`POST /api/v2/ads/edit_manual_product_ad_keywords` · loại: Shop · app được gọi: Seller In House System, Ads Service, Ads Service App , Ads Facil

Use this API to edit Manual Selection Product Ad Keywords

Lịch sử cập nhật: 2024-10-21: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `reference_id` | string | ✔ | A random string used to prevent duplicate ads. If an ads is created successfully, subsequent request using the same reference id will fail |
| `campaign_id` | int64 | ✔ | The unique identifier for a campaign |
| `selected_keywords` | object[] | ✔ | selected keywords, required for manual bidding mode. |
| `↳ edit_action` | string | ✔ | The update behaviours such as "add", "delete", "restore", "change_bid_price", "change_match_type" |
| `↳ keyword` | string | ✔ | bid keyword for each campaign |
| `↳ match_type` | string |  | exact, broad; required if changing match type |
| `↳ bid_price_per_click` | float |  | the bid price of keyword; required if changing bid price |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] | response body |
| `↳ campaign_id` | int64 | The unique identifier for a campaign |
| `↳ failed_edits` | object[] | failed edits are mentioned here |
| `↳↳ keyword` | string | keyword that failed to update |
| `↳↳ error` | string | Error code |
| `↳↳ message` | string | error description |

Lỗi riêng: Account status is not normal. · Invalid campaign ID for this shop. · The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · Ads account status is Invalid. · Edit Action is invalid as per the current status of the campaign. · Item status is invalid. · Keyword already exists. · Keyword is Blacklisted. · Keyword is reserved. · Keyword has no update. · Keyword is not found. · Price of Keyword is too high.

## v2.ads.edit_manual_product_ads
`POST /api/v2/ads/edit_manual_product_ads` · loại: Shop · app được gọi: Seller In House System, Ads Service, Ads Service App , Ads Facil

Use this API to edit Manual Selection Product Ads

Lịch sử cập nhật: 2024-10-21: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `reference_id` | string | ✔ | A random string used to prevent duplicate ads. If an ads is created successfully, subsequent request using the same reference id will fail |
| `campaign_id` | int64 | ✔ | The unique identifier for a campaign |
| `edit_action` | string | ✔ | Actions supported: "start", "pause", "resume", "stop", "delete", "change_budget", "change_duration", "change_smart_creative", "change_location", "change_enhanced_cpc", "change_roas_target" |
| `budget` | float |  | The budget set for the Auto Product Ads |
| `start_date` | string |  | the start date per campaign. please kindly note that if you want to set unlimited date, you can just pass today's date as the start date |
| `end_date` | string |  | the end date of each campaign. please kindly note that if you want to set an unlimited campaign, you can keep empty for the end date field |
| `roas_target` | float |  | the ROAS target for each campaign with auto bidding |
| `discovery_ads_locations` | object[] |  | the location settings for manual bidding method |
| `↳ location` | string | ✔ | daily_discover, you_may_also_like |
| `↳ status` | string | ✔ | active / inactive |
| `↳ bid_price` | float | ✔ | bid price of the location |
| `enhanced_cpc` | boolean |  | Enhanced CPC functionality toggle |
| `smart_creative_setting` | string |  | Whether to use default or set on/off Smart Creative for this ad. Supported Values: "", "default", "on", "off". Empty string treated as default. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object[] | response body |
| `↳ campaign_id` | int64 | The unique identifier for a campaign |

Lỗi riêng: Account status is not normal. · Item is an adult item cannot have this campaign setting. · Invalid campaign ID for this shop. · The budget set is invalid. · The start/end date of campaign should be larger or equal to today. End date to be empty for unlimited duration. · This feature has been deprecated · The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · Ads account status is Invalid. · Edit Action is invalid as per the current status of the campaign. · Item status is invalid. · The start date has to be today for no end date (unlimited duration). · Item is blocked for promotion.

## v2.ads.get_create_product_ad_budget_suggestion
`GET /api/v2/ads/get_create_product_ad_budget_suggestion` · loại: Shop · app được gọi: Seller In House System, Ads Service, Ads Service App , Ads Facil

Call this API to get budget suggestion for product ads creation

Lịch sử cập nhật: 2024-10-21: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `reference_id` | string | ✔ | A random string used to prevent duplicate ads. If an ads is created successfully, subsequent request using the same reference id will fail |
| `product_selection` | string | ✔ | auto,manual - for Auto product ads or Manual Product Ads |
| `campaign_placement` | string | ✔ | search, discovery, all |
| `bidding_method` | string | ✔ | Bidding Method of product ad: auto, manual |
| `enhanced_cpc` | string |  | Enhanced CPC functionality toggle. Values supported "true"/"false". Mandatory for product_selection=manual, bidding_method=manual |
| `discovery_ads_location_names` | string |  | List of comma separated location values from: daily_discover, you_may_also_like. Mandatory for product_selection=manual, product_placement={all\|discovery}, bidding_method=manual |
| `roas_target` | float |  | the ROAS target for each campaign with auto bidding. If 0, GMV Max / ROI feature is not enabled |
| `item_id` | int64 |  | Product ID. Mandatory for product_selection=manual |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | response body |
| `↳ budget` | object | Budget data |
| `↳↳ recommended_budget` | float | Recommended Suggested Budget |
| `↳↳ min_budget` | float | Minimun Suggested Budget |
| `↳↳ max_budget` | float | Maximum Suggested Budget |

Lỗi riêng: The information you queried is not found. · Wrong parameters. · Something wrong. Please try later. · Only the supported HTTP method for the API is allowed. · Item status is invalid. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid

## v2.ads.get_product_recommended_roi_target
`GET /api/v2/ads/get_product_recommended_roi_target` · loại: Shop · app được gọi: Seller In House System, Ads Service, Ads Service App , Ads Facil

Get Product Recommended ROI Target

Lịch sử cập nhật: 2024-12-06: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `reference_id` | string | ✔ | A random string used to prevent duplicate ads. If an ads is created successfully, subsequent requests using the same reference id will fail - in this case, a new one must be generated. Use the same string for calling suggestion/recommendation API before the actual request to create an ads. |
| `item_id` | int32 | ✔ | Unique identifier for a product. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Response body. |
| `↳ lower_bound` | object | Lower bound recommendation. e.g., value=3.5 and percentile=80 mean that setting an ROI target of 3.5 makes the ads more competitive than 80% of similar ads. |
| `↳↳ value` | float | The ROI target value. |
| `↳↳ percentile` | int32 | Competitiveness over similar ads. |
| `↳ exact` | object | Mid-level recommendation e.g., value=5.9 and percentile=50 mean that setting an ROI target of 5.9 makes the ads more competitive than 50% of similar ads. |
| `↳↳ value` | float | The ROI target value. |
| `↳↳ percentile` | int32 | Competitiveness over similar ads. |
| `↳ upper_bound` | object | Higher bound recommendation. e.g., value=10.8 and percentile=20 mean that setting an ROI target of 10.8 makes the ads more competitive than 20% of similar ads. |
| `↳↳ value` | float | The ROI target value. |
| `↳↳ percentile` | int32 | Competitiveness over similar ads. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.ads.get_ads_fácil_shop_rate
`GET /api/v2/ads/get_ads_facil_shop_rate` · loại: Shop · app được gọi: Ads Service, Ads Service App , Ads Facil

Get shop rate for Ads Facil Program

Lịch sử cập nhật: 2025-07-21: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `rate` | float | The rate of the shop who choose to participate in this program |
| `update_at` | int64 | The update time in timestamp format |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · shopid is invalid · request not from gateway

## v2.ads.check_create_gms_product_campaign_eligibility
`GET /api/v2/ads/check_create_gms_product_campaign_eligibility` · loại: Shop · app được gọi: Seller In House System, Ads Service, Ads Service App 

Check the seller's eligibility in creating a GMS campaign

Lịch sử cập nhật: 2025-08-26: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ is_eligible` | boolean | Indicates if the seller is eligible to create a GMS Campaign |
| `↳ reason` | string | The following are the list of reasons for not being able to create a GMS Campaign: active_campaign There is already an existing GMS Campaign that is active not_whitelisted The seller is not whitelisted to sz_shop_gmv_max_feature not_have_enough_sku The seller does not have enough valid items in the shop exclusive_with_other_campaign Seller is whitelisted to sz_ads_auto_boost |

Lỗi riêng: This shop is not whitelisted for Product GMS. · Something wrong. Please try later. · Ads account status is Invalid. · Too many requests at the moment, please try again later. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · Shop is in holiday mode. · Shop status is not normal.

## v2.ads.create_gms_product_campaign
`POST /api/v2/ads/create_gms_product_campaign` · loại: Shop · app được gọi: Seller In House System, Ads Service, Ads Service App 

Create a GMS campaign

Lịch sử cập nhật: 2025-09-22: add request fields "reference_id" and "roas_target"; 2025-08-26: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `start_date` | string | ✔ | Start date of Campaign e.g. "30-11-2025". Cannot be earlier than today. |
| `end_date` | string |  | End date of Campaign e.g. "30-11-2025". Do not fill if no end date. |
| `daily_budget` | float | ✔ | Daily budget for Campaign. |
| `reference_id` | string |  | Input a string |
| `roas_target` | float |  | No input will be GMV Max Auto Bidding (Shop). Input 0 for GMV Max Auto Bidding (Shop). Input greater than 0 for GMV Max Custom ROAS (Shop). If value = 10.123456, it will be taken as 10.1 If value = 10.199999, it will be taken as 10.1 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ campaign_id` | int64 | GMS Campaign ID. |

Lỗi riêng: The budget set is invalid. · This shop is not whitelisted for Product GMS. · Wrong parameters. · Something wrong. Please try later. · Ads account status is Invalid. · ROAS Target should be greater than equal to zero. · The start date has to be today for no end date (unlimited duration). · Too many requests at the moment, please try again later. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · Shop is in holiday mode. · Shop status is not normal.

## v2.ads.edit_gms_product_campaign
`POST /api/v2/ads/edit_gms_product_campaign` · loại: Shop · app được gọi: Seller In House System, Ads Service, Ads Service App 

Edit a GMS campaign

Lịch sử cập nhật: 2025-09-22: add new request field "reference_id" and new action value"change_roas_target" for edit_action.; 2025-08-26: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_id` | int64 |  | The GMS Campaign ID. Provide if available. |
| `edit_action` | string | ✔ | The following is the list of possible actions and their required fields: 1.change_budgetdaily_budget 2.change_durationstart_date 3.end_date 4.pause 5.resume 6.start 7.change_roas_targetroas_target: when edit_action = change_roas_target, you must provide: roas_target (float) Value rules follow the same logic as in the create endpoint |
| `daily_budget` | float |  | Daily budget for Campaign. |
| `start_date` | string |  | Start date of Campaign e.g. "11-11-2025". Cannot be earlier than today. |
| `end_date` | string |  | End date of Campaign e.g. "11-11-2025". Do not fill if no end date. |
| `roas_target` | float |  | No input will be GMV Max Auto Bidding (Shop). Input 0 for GMV Max Auto Bidding (Shop). Input greater than 0 for GMV Max Custom ROAS (Shop). If value = 10.123456, it will be taken as 10.1 If value = 10.199999, it will be taken as 10.1 |
| `reference_id` | string |  | Generated by developers, used to prevent duplicate requests Submitting the same reference_id more than once will fail; a new reference_id must be generated to retry. Example: 086a16bf-49e9-4103-b7fe-c0125beb9278 |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ campaign_id` | int64 | GMS Campaign ID |

Lỗi riêng: The budget set is invalid. · This shop is not whitelisted for Product GMS. · Wrong parameters. · Something wrong. Please try later. · Ads account status is Invalid. · The start date has to be today for no end date (unlimited duration). · Too many requests at the moment, please try again later. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · Shop is in holiday mode. · Shop status is not normal.

## v2.ads.list_gms_user_deleted_item
`POST /api/v2/ads/list_gms_user_deleted_item` · loại: Shop · app được gọi: Seller In House System, Ads Service, Ads Service App 

List GMS items that have been removed from the Campaign by seller

Lịch sử cập nhật: 2025-08-26: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `offset` | int32 |  | Specifies the starting point, or the number of records to skip. Default is 0. |
| `limit` | int32 |  | Specifies the maximum number of records to show. Default is 50. Maximum is 100. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ campaign_id` | int64 | GMS Campaign ID |
| `↳ item_id_list` | int64[] | List of Item IDs |
| `↳ total` | int64 | Total number of Item IDs |
| `↳ has_next_page` | boolean | Indicate that there are more item IDs. |

Lỗi riêng: This shop is not whitelisted for Product GMS. · Wrong parameters. · Product GMS Campaign cannot be found. · Something wrong. Please try later. · Ads account status is Invalid. · Too many requests at the moment, please try again later. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · Shop is in holiday mode. · Shop status is not normal.

## v2.ads.edit_gms_item_product_campaign
`POST /api/v2/ads/edit_gms_item_product_campaign` · loại: Shop · app được gọi: Seller In House System, Ads Service, Ads Service App 

Add/remove items to/from the GMS Campaign

Lịch sử cập nhật: 2025-08-26: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_id` | int64 |  | The GMS Campaign ID. Provide if available. |
| `edit_action` | string | ✔ | The following is the list of possible actions: add remove |
| `item_id_list` | int64[] | ✔ | Item IDs to add / remove. Minimum 1 Item ID. Maximum 30 Item IDs. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ campaign_id` | int64 | GMS Campaign ID |

Lỗi riêng: This shop is not whitelisted for Product GMS. · Wrong parameters. · Product GMS Campaign cannot be found. · Something wrong. Please try later. · Ads account status is Invalid. · Too many requests at the moment, please try again later. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later. · Too many requests at the moment, please try again later. · Shop is in holiday mode. · Shop status is not normal.

## v2.ads.get_gms_campaign_performance
`POST /api/v2/ads/get_gms_campaign_performance` · loại: Shop · app được gọi: Seller In House System, Ads Service, Ads Service App 

Get GMS Campaign performance

Lịch sử cập nhật: 2025-08-26: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_id` | int64 |  | The GMS Campaign ID. Provide if available. |
| `start_date` | string | ✔ | Start date of Campaign e.g. "11-11-2025". Maximum duration of 3 months between start_date & end_date. Earliest start_date is 6 months before today. |
| `end_date` | string | ✔ | End date of Campaign e.g. "11-11-2025". Maximum duration of 3 months between start_date & end_date. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ campaign_id` | int64 | GMS Campaign ID |
| `↳ report` | object |  |
| `↳↳ broad_cir` | float | The direct advertising cost of sales, or direct ACOS, measures how much your ad costs relative to the revenue generated from sales of the advertised product. It is the amount spent on the ad divided by the amount of sales revenue for the advertised product that is attributed to the ad. Direct ACOS = expense ÷ direct GMV × 100%. |
| `↳↳ broad_gmv` | float | The amount of sales revenue generated from shoppers purchasing products within 7 days of them clicking on your ad. |
| `↳↳ broad_order` | int64 | The number of times shoppers purchased any product from your shop within 7 days of them clicking on your ad. |
| `↳↳ broad_order_amount` | int64 | The total quantity of products purchased by shoppers within 7 days of them clicking on your ad. |
| `↳↳ broad_roi` | float | Return on ad spend (ROAS) measures how much revenue is generated by your ad relative to the cost of the ad. It is the amount of sales revenue attributed to your ad divided by the amount spent on the ad. ROAS = GMV ÷ expense. (Note: We recommend monitoring ROAS trends on a weekly basis.) |
| `↳↳ clicks` | int64 | The number of times shoppers click on your ad. (Note: Shopee filters out repeated clicks from the same shopper that occur within a short time frame.) |
| `↳↳ expense` | float | The amount spent on your ad. |
| `↳↳ cpc` | float | The cost per conversion is how much each conversion costs, on average. It is the amount spent on your ad divided by the number of conversions attributed to the ad. Cost per conversion = expense ÷ conversions. |
| `↳↳ cpdc` | float | The cost per direct conversion is how much each direct conversion costs, on average. It is the amount spent on your ad divided by the number of direct conversions attributed to the ad. Cost per direct conversion = expense ÷ direct conversions. |
| `↳↳ cr` | float | The conversion rate measures how often shoppers end up purchasing something from your shop after clicking on your ad. It is the number of conversions attributed to your ad divided by the number of clicks on the ad. Conversion rate = conversions ÷ clicks × 100%. |
| `↳↳ direct_cr` | float | The direct conversion rate measures how often shoppers end up purchasing the advertised product after clicking on the ad. Direct conversion rate is the number of direct conversions divided by the number of clicks. Direct conversion rate = direct conversions ÷ clicks × 100%. |
| `↳↳ direct_cir` | float | The direct advertising cost of sales, or direct ACOS, measures how much your ad costs relative to the revenue generated from sales of the advertised product. It is the amount spent on the ad divided by the amount of sales revenue for the advertised product that is attributed to the ad. Direct ACOS = expense ÷ direct GMV × 100%. |
| `↳↳ direct_order` | int64 | The number of times shoppers purchased the advertised product within 7 days of them clicking on the ad. |
| `↳↳ direct_order_amount` | int64 | The total quantity of the advertised product purchased by shoppers within 7 days of them clicking on the ad. |
| `↳↳ direct_roi` | float | The direct return on ad spend, or direct ROAS, measures how much revenue is generated from sales of the advertised product, relative to the cost of the ad. It is the amount of sales revenue for the advertised product attributed to the ad, divided by the amount spent on the ad. Direct ROAS = direct GMV ÷ expense. |
| `↳↳ impression` | float | The number of times shoppers see your ad. |

Lỗi riêng: This shop is not whitelisted for Product GMS. · Wrong parameters. · Product GMS Campaign cannot be found. · Something wrong. Please try later. · Ads account status is Invalid. · ROAS Target should be greater than equal to zero. · The start date has to be today for no end date (unlimited duration). · The date must be today or earlier than today up to 6 months ago. · Date range can't be longer than 1 month. · The date can't be earlier than 6 months ago. · Start date can't be equal to end date. For single date's hourly performance data, please query hourly api. · The start date can't be later than the end date. · Too many requests at the moment, please try again later. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later.

## v2.ads.get_gms_item_performance
`POST /api/v2/ads/get_gms_item_performance` · loại: Shop · app được gọi: Seller In House System, Ads Service, Ads Service App 

Get GMS Item performance 1. The response returned is sorted by item_id 2. Only items with performance will be returned

Lịch sử cập nhật: 2025-08-26: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `campaign_id` | int64 |  | The GMS Campaign ID. Provide if available. |
| `start_date` | string | ✔ | Start date of Campaign e.g. "11-11-2025". Maximum duration of 3 months between start_date & end_date. Earliest start_date is 6 months before today. |
| `end_date` | string | ✔ | End date of Campaign e.g. "11-11-2025". Maximum duration of 3 months between start_date & end_date. |
| `offset` | int32 |  | Specifies the starting point, or the number of records to skip. Default is 0. |
| `limit` | int32 |  | Specifies the maximum number of records to show. Default is 50. Maximum is 100. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ campaign_id` | int64 | GMS Campaign ID |
| `↳ result_list` | object[] |  |
| `↳↳ item_id` | int64 | Item ID. Results are sorted by this. |
| `↳↳ report` | object |  |
| `↳↳↳ broad_cir` | float | The direct advertising cost of sales, or direct ACOS, measures how much your ad costs relative to the revenue generated from sales of the advertised product. It is the amount spent on the ad divided by the amount of sales revenue for the advertised product that is attributed to the ad. Direct ACOS = expense ÷ direct GMV × 100%. |
| `↳↳↳ broad_gmv` | float | The amount of sales revenue generated from shoppers purchasing products within 7 days of them clicking on your ad. |
| `↳↳↳ broad_order` | int64 | The number of times shoppers purchased any product from your shop within 7 days of them clicking on your ad. |
| `↳↳↳ broad_order_amount` | int64 | The total quantity of products purchased by shoppers within 7 days of them clicking on your ad. |
| `↳↳↳ broad_roi` | float | Return on ad spend (ROAS) measures how much revenue is generated by your ad relative to the cost of the ad. It is the amount of sales revenue attributed to your ad divided by the amount spent on the ad. ROAS = GMV ÷ expense. (Note: We recommend monitoring ROAS trends on a weekly basis.) |
| `↳↳↳ clicks` | int64 | The number of times shoppers click on your ad. (Note: Shopee filters out repeated clicks from the same shopper that occur within a short time frame.) |
| `↳↳↳ expense` | float | The amount spent on your ad. |
| `↳↳↳ cpc` | float | The cost per conversion is how much each conversion costs, on average. It is the amount spent on your ad divided by the number of conversions attributed to the ad. Cost per conversion = expense ÷ conversions. |
| `↳↳↳ cpdc` | float | The cost per direct conversion is how much each direct conversion costs, on average. It is the amount spent on your ad divided by the number of direct conversions attributed to the ad. Cost per direct conversion = expense ÷ direct conversions. |
| `↳↳↳ cr` | float | The conversion rate measures how often shoppers end up purchasing something from your shop after clicking on your ad. It is the number of conversions attributed to your ad divided by the number of clicks on the ad. Conversion rate = conversions ÷ clicks × 100%. |
| `↳↳↳ direct_cr` | float | The direct conversion rate measures how often shoppers end up purchasing the advertised product after clicking on the ad. Direct conversion rate is the number of direct conversions divided by the number of clicks. Direct conversion rate = direct conversions ÷ clicks × 100%. |
| `↳↳↳ direct_cir` | float | The direct advertising cost of sales, or direct ACOS, measures how much your ad costs relative to the revenue generated from sales of the advertised product. It is the amount spent on the ad divided by the amount of sales revenue for the advertised product that is attributed to the ad. Direct ACOS = expense ÷ direct GMV × 100%. |
| `↳↳↳ direct_order` | int64 | The number of times shoppers purchased the advertised product within 7 days of them clicking on the ad. |
| `↳↳↳ direct_order_amount` | int64 | The total quantity of the advertised product purchased by shoppers within 7 days of them clicking on the ad. |
| `↳↳↳ direct_roi` | float | The direct return on ad spend, or direct ROAS, measures how much revenue is generated from sales of the advertised product, relative to the cost of the ad. It is the amount of sales revenue for the advertised product attributed to the ad, divided by the amount spent on the ad. Direct ROAS = direct GMV ÷ expense. |
| `↳↳↳ impression` | int64 | The number of times shoppers see your ad. |
| `↳ total` | int64 | Total number of Item ID reports. |
| `↳ has_next_page` | boolean | Indicate that there are more item ID reports. |

Lỗi riêng: This shop is not whitelisted for Product GMS. · Wrong parameters. · Product GMS Campaign cannot be found. · Limit is above the maximum allowed for this query API. · Something wrong. Please try later. · Ads account status is Invalid. · The start date has to be today for no end date (unlimited duration). · The date must be today or earlier than today up to 6 months ago. · Date range can't be longer than 1 month. · The date can't be earlier than 6 months ago. · Start date can't be equal to end date. For single date's hourly performance data, please query hourly api. · The start date can't be later than the end date. · Too many requests at the moment, please try again later. · Too many requests, please reduce the request rate and try again later. · Too many requests for the shop at the moment, please try again later.

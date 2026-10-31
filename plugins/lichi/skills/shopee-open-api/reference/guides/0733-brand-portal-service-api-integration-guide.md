# Brand Portal Service API Integration Guide

> Nhóm: API Guidelines and Flows · nguồn: https://open.shopee.com/developer-guide/733

# Introduction to Brand Performance

Brand Portal provides brands with performance data to help them understand their business performance on Shopee across sales, affiliate marketing, livestream, and video. Currently, brands often need to manually download data from Brand Portal for further analysis. This manual process is time-consuming, typically taking 1-2 hours, and limits brands’ ability to automate data analysis and daily performance monitoring.

To improve data integration efficiency, Shopee Open Platform will provide APIs for Brand Portal performance data. Developers can use these APIs to retrieve sales performance, affiliate performance, livestream performance, and video performance metrics at shop level, principal level, or content/session level depending on the API, and integrate the data directly into brands’ internal systems for business analysis, reporting, performance monitoring, and decision-making.

# App Management

- Supported Sites: Currently, Brand Portal Basic Sales Performance Data API is available for Taiwan (TW), Philippines (PH), Vietnam (VN), Indonesia (ID), Singapore (SG), Thailand (TH), Malaysia (MY), and Brazil (BR).
- Application type: Only the Brand Portal Service APP has permission to call the Brand Portal service API. Please create a Brand Portal Service APP in the Console before integrating with the API.
- Please notice that: Before using this feature, please ensure that you are a Brand Portal brand user; otherwise, you will not be able to use it.

# Authorization & Authentication

## Authorization

### Generate Authorization Link

For Principal Management apps, developers need to generate the authorization link, which consists of Fixed Authorization URL and Required Parameters:

**Fixed Authorization URL: **  
  
 

- Live Environment：

- [https://open.shopee.com/auth](https://open.shopee.com/auth)
- https://open.shopee.cn/auth
- https://open.shopee.com.br/auth

**Required Parameters：**

| **Name**      | **Type** | **Required** | **Description**                                                                                                                                                                                                                                                                                                                         |
|---------------|----------|--------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| partner_id    | int64    | True         | The partner_id of your application, assigned by Shopee Open Platform.                                                                                                                                                                                                                                                                   |
| auth_type     | string   | True         | The type of roles need to authorize, the enumeration values are as follows:- seller: If you need to authorize seller with their own shops, please select "seller";- user: If you need to authorize affiliate streamer, please select "user".- principal: If you need to authorize principal in Brand Portal, please select "principal". |
| redirect_uri  | string   | True         | The URL used for receiving the code after the principal administrator completes the authorization.The domain of redirect_uri must be consistent with the domain declared when you create and go live the application on Shopee Open Platform.                                                                                           |
| response_type | string   | True         | The authorization type, with the value of "code".                                                                                                                                                                                                                                                                                       |
| state         | string   | False        | An unguessable random string for protecting against cross-site request forgery attacks.                                                                                                                                                                                                                                                 |

Note：If the authorized role is principal administrator, set auth_type to "principal". 

Example Authorization Links：

- Live Environment：[*https://open.shopee.com/auth?partner_id=10090&auth_type=principal&redirect_uri=https://open.shopee.com&response_type=code*](https://open.shopee.com/auth?partner_id=10090&auth_type=principal&redirect_uri=https://open.shopee.com&response_type=code)

 

### Login for Authorization

Developers need to share the authorization link with the principal administrator. After logging in, they will be redirected to the authorization page where they can proceed.

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=IehwelZEinYWhPBvOCMsxDEPiQnVEvQd%2FL%2FLCtAJ7vH03pNLzxG7ugzx7BfbIcggd6rJIELOpW8UqUu51BkA9A%3D%3D&image_type=png)

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=ijY1DE%2By%2BvSPAbiBJUkekUgjdHT0GkjnMr6jB1bUhwO0W4gMDKgGS55W5WYkCI7kU4Uy7Ov7Byd1PRtHKHGmUQ%3D%3D&image_type=png)

### Retrieve Authorization Code

After successful authorization, Shopee will return the authorization code to the callback URL (redirect_uri). Developers can retrieve and use this code to obtain the access_token for the first time.

| **Name** | **Type** | **Description**                                                                                                     |
|----------|----------|---------------------------------------------------------------------------------------------------------------------|
| code     | string   | This code is used to obtain access_token and refresh_token. It is valid for only once and expires after 10 minutes. |

### Retrieve access_token

The access_token is a dynamic token. Developers must include the access_token when calling non-public APIs.

After successful authorization, use the authorization code from the callback URL to call the [v2.public.get_access_token](https://open.shopee.com/documents/v2/v2.public.get_access_token?module=104&type=1) API to obtain the access_token and refresh_token.

**Common Request Parameters：**

| **Name**   | **Type**  | **Required** | **Description**                                                                                                           |
|------------|-----------|--------------|---------------------------------------------------------------------------------------------------------------------------|
| partner_id | int64     | True         | The partner_id obtained from the App. This partner_id is put into the query.                                              |
| timestamp  | timestamp | True         | Timestamp, valid for 5 minutes.                                                                                           |
| sign       | string    | True         | The signature obtained by sign base string (order: partner_id, api_path, timestamp) HMAC-SHA256 hashing with partner_key. |

**Business Request Parameters：**

| **Name** | **Type** | **Required** | **Description**                                                                                       |
|----------|----------|--------------|-------------------------------------------------------------------------------------------------------|
| code     | string   | True         | The code in the redirect URL after authorization. It is only valid once and expires after 10 minutes. |

**Response Parameters：**

| **Name**          | **Type**  | **Description**                                                                                                                              |
|-------------------|-----------|----------------------------------------------------------------------------------------------------------------------------------------------|
| error             | string    | Error code for API requests; always returned.When the API call is successful, the error code returned is empty.                              |
| message           | string    | Provides Detailed error information for API requests; always returned.When the API call is successful, the error message returned is empty.  |
| request_id        | string    | ID of API requests; always returned. Used to diagnose problems.                                                                              |
| principal_id_list | int64\[\] | If the authorized role is principal administrator, return all principal_id under this authorization.                                         |
| access_token      | string    | Returned when the API call is successful.A dynamic token that can be used multiple times and expires after 4 hours.                          |
| refresh_token     | string    | Returned when the API call is successful.Use refresh_token to get a new access_token. Valid for each principal_id respectively, for 30 days. |
| expire_in         | timestamp | Returned when the API call is successful.The validity period of the access_token, in seconds.                                                |

Note: All principal-related Open APIs require principal_id as a common request parameter Therefore, after successful authorization:

- For principal administrator, please securely store principal_id.

### Refresh access_token

Each access_token is valid for 4 hours and can be used multiple times within that period. Developers need to refresh the access_token before it expires by calling the [v2.public.refresh_access_token](https://open.shopee.com/documents/v2/v2.public.refresh_access_token?module=104&type=1) API using the refresh_token. The refresh_token is used specifically for refreshing the access_token, and each refresh_token is valid for 30 days. After the call, a new pair of access_token and refresh_token will be returned. Be sure to use the new refresh_token for the next refresh request.

**Common Request Parameters：**

| **Name**   | **Type**  | **Required** | **Description**                                                                                                           |
|------------|-----------|--------------|---------------------------------------------------------------------------------------------------------------------------|
| partner_id | int64     | True         | The partner_id obtained from the App. This partner_id is put into the query.                                              |
| timestamp  | timestamp | True         | Timestamp, valid for 5 minutes.                                                                                           |
| sign       | string    | True         | The signature obtained by sign base string (order: partner_id, api_path, timestamp) HMAC-SHA256 hashing with partner_key. |

**Business Request Parameters：**

| **Name**      | **Type** | **Required** | **Description**                                                                                                                      |
|---------------|----------|--------------|--------------------------------------------------------------------------------------------------------------------------------------|
| refresh_token | string   | True         | Use refresh_token to get a new access_token.Each refresh_token is valid for 30 days, and can only be used once by each principal_id. |
| partner_id    | int64    | True         | The partner_id obtained from the App. This partner_id is inserted into the body.                                                     |
| principal_id  | int64    | True         | Shopee's unique identifier for a principal.                                                                                          |

**Response Parameters：**

| **Name**      | **Type**  | **Description**                                                                                                                                                 |
|---------------|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| error         | string    | Error code for API requests; always returned.When the API call is successful, the error code returned is empty.                                                 |
| message       | string    | Provides Detailed error information for API requests; always returned.When the API call is successful, the error message returned is empty.                     |
| request_id    | string    | ID of API requests; always returned. Used to diagnose problems.                                                                                                 |
| partner_id    | int64     | Returned when the API call is successful.The partner_id you used for this refresh.                                                                              |
| principal_id  | int64     | Returned when the API call is successful.The principal_id for this refresh.                                                                                     |
| access_token  | string    | Returned when the API call is successful.New access_token. A dynamic token that can be used multiple times and expires after 4 hours.                           |
| refresh_token | string    | Returned when the API call is successful.New refresh_token. Use refresh_token to get a new access_token. Valid for each principal_id respectively, for 30 days. |
| expire_in     | timestamp | Returned when the API call is successful.The validity period of the access_token, in seconds.                                                                   |

## Cancel Authorization

### Via Cancel Authorization Link

Cancel authorization link generation is similar to authorization, but with different Fixed Cancel Authorization URL:

**Fixed Cancel Authorization URL:**

- Live Environment：

- https://open.shopee.com/cancel_auth
- https://open.shopee.cn/cancel_auth
- https://open.shopee.com.br/cancel_auth

Example Cancel Authorization Link：

- Live Environment：https://open.shopee.com/cancel_auth?partner_id=10090&auth_type=principal&redirect_uri=https://open.shopee.com&response_type=code

 

After generating the unauthorization link, developer should share it with the principal administrator. Once they log in to their account and access the cancel authorization page, they can proceed to cancel the authorization.

### Via Livestream PC Backend

Principal administrators can also visit the Partner Management page in the Brand Portal Backend to view which Principal-type Apps their account has authorized and the corresponding expiration dates. They can also directly unlink any authorization on that page.

## API Authentication

Principal APIs are Principal-type APIs, meaning:

- Use principal_id in common parameters
- The sign base string differs from Principal-type APIs (includes principal_id and corresponding access_token)

**Common Request Parameters：**

| **Name**     | **Description**                                                                                                                                                   |
|--------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| partner_id   | Partner ID is assigned upon registration is successful. Required for all requests.                                                                                |
| timestamp    | This is to indicate the timestamp of the request. Required for all requests. Expires in 5 minutes.                                                                |
| access_token | The token for API access, using to identify your permission to the api. Valid for multiple use and expires in 4 hours.                                            |
| principal_id | Shopee's unique identifier for a principal.                                                                                                                       |
| sign         | Signature generated by (depends on different APIs) partner_id, api path, timestamp, access_token, principal_id and partner_key via HMAC-SHA256 hashing algorithm. |

 

# API Categories & Capabilities

This section provides an overview of the Brand Portal Performance Data APIs, including the supported performance categories, API names, and the core capability of each API.

| Category               | API Name                                                                                                                                                          | API Description                                 |
|------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------|
| Sales Performance      | [v2.principal.get_shop_sales_performance_detail](https://open.shopee.com/documents/v2/v2.principal.get_shop_sales_performance_detail?module=139&type=1)           | Queries sales performance data by shop.         |
| Sales Performance      | [v2.principal.get_principal_sales_performance_detail](https://open.shopee.com/documents/v2/v2.principal.get_principal_sales_performance_detail?module=139&type=1) | Queries sales performance data by region.       |
| Affiliate Performance  | [v2.principal.get_shop_affiliate_performance](https://open.shopee.com/documents/v2/v2.principal.get_shop_affiliate_performance?module=139&type=1)                 | Queries affiliate performance data by shop.     |
| Affiliate Performance  | [v2.principal.get_principal_affiliate_performance](https://open.shopee.com/documents/v2/v2.principal.get_principal_affiliate_performance?module=139&type=1)       | Queries affiliate performance data by region.   |
| Affiliate Performance  | [v2.principal.get_content_affiliate_performance](https://open.shopee.com/documents/v2/v2.principal.get_content_affiliate_performance?module=139&type=1)           | Queries affiliate performance data by content.  |
| Livestream Performance | [v2.principal.get_shop_livestream_performance](https://open.shopee.com/documents/v2/v2.principal.get_shop_livestream_performance?module=139&type=1)               | Queries livestream performance data by shop.    |
| Livestream Performance | [v2.principal.get_principal_livestream_performance](https://open.shopee.com/documents/v2/v2.principal.get_principal_livestream_performance?module=139&type=1)     | Queries livestream performance data by region.  |
| Livestream Performance | [v2.principal.get_session_livestream_performance](https://open.shopee.com/documents/v2/v2.principal.get_session_livestream_performance?module=139&type=1)         | Queries livestream performance data by session. |
| Video Performance      | [v2.principal.get_shop_video_performance](https://open.shopee.com/documents/v2/v2.principal.get_shop_video_performance?module=139&type=1)                         | Queries video performance data by shop.         |
| Video Performance      | [v2.principal.get_principal_video_performance](https://open.shopee.com/documents/v2/v2.principal.get_principal_video_performance?module=139&type=1)               | Queries video performance data by region.       |
| Video Performance      | [v2.principal.get_clip_video_performance](https://open.shopee.com/documents/v2/v2.principal.get_clip_video_performance?module=139&type=1)                         | Queries video performance data by clip video.   |

 

# API Call Flow

Following are the basic recommended API call flows for different business scenarios:

## General flow

Step 1: Complete principal authorization and obtain principal_id, access_token, and refresh_token.

Step 2: Select the API and data level based on the business scenario, such as principal, shop, content, session, or video.

Step 3: Fill in the required query conditions, including start_date, end_date, timezone, granularity, and currency when applicable.

Step 4: Call the API. If the corresponding list parameter is not provided, the API queries all currently accessible objects under the principal by default.

Step 5: Use the returned IDs or dimension values for more targeted follow-up queries.

## Scenario-based flow

- Principal / Region level: Use principal-level APIs to view overall performance. If region_list is not provided, the API returns all accessible regions under the principal by default. If region_list is provided, only the specified regions are queried.
- Shop level: Use shop-level APIs to view shop performance. If shop_list is not provided, the API returns all accessible shops under the principal by default. If shop_list is provided, only the specified shops are queried.
- Content / Session / Video level: Use the corresponding object-level APIs to view content, session, or video performance. If content_list, session_list, or video_list is not provided, the API queries all accessible objects under the principal by default. If the corresponding list is provided, only the specified objects are queried.

## Pagination guidance

For object-level APIs such as content, session, and video, the response may be large when the corresponding list parameter is not provided. Use pagination parameters in this scenario.

1.  In the first request, pass page_size. The cursor can be omitted or set to 0.
2.  The API returns the current page of details and next_cursor.
3.  In the next request, pass the previous next_cursor to continue querying the next page.
4.  When the number of returned details is smaller than page_size, it usually means the last page has been reached.
5.  If the final cursor is used again, the API returns empty details and keeps next_cursor unchanged.

## Usage suggestions

- If you only need to view the aggregated result, read the ‘summary’ field in the response. 
- If you need to process details for each object, read the ‘details’ field in the response. 
- After the initial full query, it is recommended to save the returned ‘shop_id’, ‘content_id’, ‘session_id’, or ‘video_id’, and use the saved ID to query the specified object in later requests. This helps reduce the data volume and improve query efficiency.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=ZuOlSyoFc%2B4SMi3%2Bvu%2FjPsN2YMm7kMllhHtg1d9vU3Yp7M5Li8J3WUc9mK%2Bq701il9RbOv42PlW5fLiaRoUQyQ%3D%3D&image_type=png)

 

# FAQ

**Q1: Do these APIs need to be called in the order of principal → shop → content/session/clip?**  
No. Each API can be called directly based on the required data level. If you need to drill down from overall performance, you can call the principal-level API first, and then query shop-level or object-level data as needed.

 

**Q2: What data will be returned if region_list / shop_list / content_list / session_list / video_list is not passed?**  
If the list parameter is empty, the API queries all data within the current accessible scope of the principal by default.

 

**Q3: When should pagination parameters be used?**  
When calling [v2.principal.get_content_affiliate_performance](https://open.shopee.com/documents/v2/v2.principal.get_content_affiliate_performance?module=139&type=1), [v2.principal.get_session_livestream_performance](https://open.shopee.com/documents/v2/v2.principal.get_session_livestream_performance?module=139&type=1), or [v2.principal.get_clip_video_performance](https://open.shopee.com/documents/v2/v2.principal.get_clip_video_performance?module=139&type=1) without passing the corresponding list parameter, the returned data volume may be large. It is recommended to use pagination parameters.

 

 

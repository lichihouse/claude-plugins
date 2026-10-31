# Module Video (15 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.video.get_cover_list
`GET /api/v2/video/get_cover_list` · loại: User · app được gọi: Shopee Video Management

You need to call v2.media.init_video_upload, v2.media.upload_video_part, and v2.media.complete_video_upload to upload the video, and call the v2.media.get_video_upload_result to get the video_upload_id of uploaded video. After the video is uploaded, obtain the frame-by-frame results and select a specific frame as the video cover.

Lịch sử cập nhật: 2025-09-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `video_upload_id` | string | ✔ | ID of uploaded video. Obtain from v2.media.get_video_upload_result. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ image_url_list` | string[] | List of image url for each frame of the uploaded video, you can select one as the video cover when calling v2.video.edit_video_info. |

Lỗi riêng: video_upload_id is illegal · id invalid error · upload video less than 1 min · data not found and submit task

## v2.video.edit_video_info
`POST /api/v2/video/edit_video_info` · loại: User · app được gọi: Shopee Video Management

You need to call v2.media.init_video_upload, v2.media.upload_video_part, and v2.media.complete_video_upload to upload the video, and call the v2.media.get_video_upload_result to get the video_upload_id of uploaded video first, then call this API to set video post information. After submit, the video is still draft status, you need to call v2.video.post_video to post the video to Shopee Video. You can only set and update post information before the video is post.

Lịch sử cập nhật: 2026-09-03: add request parameter “aigc_label”; 2025-09-02: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `video_upload_list` | object[] | ✔ | Video information collection, no more than 5. |
| `↳ video_upload_id` | string | ✔ | ID of uploaded video. Obtain from v2.media.get_video_upload_result. |
| `↳ caption` | string |  | Description of the Shopee Video. |
| `↳ cover_image_url` | string | ✔ | Selected cover image url of the Shopee Video. Obtain from v2.video.get_cover_list. |
| `↳ item_info` | object[] |  | List of products to be linked with the Shopee Video, no more than 6. |
| `↳↳ item_id` | int64 | ✔ | Shopee's unique identifier for an item. |
| `↳↳ custom_item_name` | string |  | Product display name in Shopee Video. |
| `↳ allow_info` | object | ✔ | Whether allow stitch and duet. |
| `↳↳ allow_duet` | boolean | ✔ | Whether allow duet. |
| `↳↳ allow_stitch` | boolean | ✔ | Whether allow stitch. |
| `↳ scheduled_info` | object | ✔ | When scheduled_post is true, scheduled_post_time must not empty. When scheduled_post is false, scheduled_post_time must empty. |
| `↳↳ scheduled_post` | boolean | ✔ | Whether post it to Shopee Video at scheduled time. |
| `↳↳ scheduled_post_time` | timestamp |  | Scheduled post time, millisecond timestamp. When scheduled_post is true, scheduled_post_time must not empty. |
| `aigc_label` | boolean | ✔ | Indicates whether the video contains AI-generated or AI-assisted content, such as visuals, voice, avatars, or scripts. Set to true if it does; otherwise, set to false. An AI label will be shown to viewers when set to true. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ success_list` | string[] | The list of video_upload_id edit successfully. |
| `↳ failure_list` | object[] | The list of video_upload_id edit failed. |
| `↳↳ fail_video_upload_id` | string | Failed video_upload_id. |
| `↳↳ failed_reason` | string | Failed reason of the corresponding video_upload_id. |

Lỗi riêng: Please check failure_list for detailed reason · video_upload_id is illegal · allowInfo is empty · Invalid video source. Please re-upload the video using v2.media.init_video_upload with correct business & scene. · caption length is more than 150 · cover is illegal · item size can not over 6 · can not find item info {item_id} · video_upload_list can not over 5 · scheduledPostTime must be 15 minutes after the current time and within 30 days of the current time · can not handle video meta video duration must within {postDuration}s and greater than 3s · can not find video meta · The user is not authorized and needs to be in toggle

## v2.video.post_video
`POST /api/v2/video/post_video` · loại: User · app được gọi: Shopee Video Management

You need to call v2.media.init_video_upload, v2.media.upload_video_part, and v2.media.complete_video_upload to upload the video, then call the v2.video.edit_video_info API to set video post information, finally call this API to post the video to Shopee Video.

Lịch sử cập nhật: 2025-09-10: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `video_upload_id_list` | string[] | ✔ | ID of uploaded video. Obtain from v2.media.get_video_upload_result. No more than 5. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ success_list` | object[] | The list of video post successfully. |
| `↳↳ success_video_upload_id` | string | The video_upload_id post successfully. |
| `↳↳ post_id` | string | The unique identifier for post Shopee Video. |
| `↳ failure_list` | object[] | The list of video post failed. |
| `↳↳ fail_video_upload_id` | string | Failed video_upload_id. |
| `↳↳ failed_reason` | string | Failed reason of the corresponding video_upload_id. |

Lỗi riêng: Please check failure_list for detailed reason · Not Agree Shopee videos Terms of Service · video_upload_id is illegal · Invalid video source. Please re-upload the video using v2.media.init_video_upload with correct business & scene. · videoUploadIdList all illegal,no record in database · video_upload_list can not over 5 · The user is not authorized and needs to be in toggle

## v2.video.get_video_list
`GET /api/v2/video/get_video_list` · loại: User · app được gọi: Shopee Video Management

Get the list of video in draft status or video already post to Shopee Video.

Lịch sử cập nhật: 2025-09-10: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 | ✔ | The start index of request. Starting from 1. |
| `page_size` | int32 | ✔ | The number of affiliate returned by this request, Max is 20. |
| `list_type` | int32 | ✔ | Search tpye for video in draft status or video already post to Shopee Video. 1: draft 2: post |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ total_count` | int64 | The total count of video that match the condition. |
| `↳ has_more` | boolean | This is to indicate whether the video list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of data. |
| `↳ list` | object | The list of video that match the condition. |
| `↳↳ video_upload_id` | string | ID of uploaded video. |
| `↳↳ post_id` | string | The unique identifier for post Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳↳ post_time` | timestamp | The time when the video post to Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳↳ video_url` | string | Video play url. |
| `↳↳ status` | int32 | Video current status. Applicable values: 200: DRAFT 300: POSTED 400: DELETED 500: SCHEDULED 600: SCHEDULED_FAILED |
| `↳↳ cover_image_url` | string | Cover image url of the Shopee Video. |
| `↳↳ caption` | string | Description of the Shopee Video. |
| `↳↳ duration` | int64 | Video duration time in millisecond. |
| `↳↳ views` | int64 | View count of post Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳↳ likes` | int64 | Like count the post Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳↳ comments` | int64 | Comment count the post Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳↳ has_performance` | boolean | Whether there is video metric data. |
| `↳↳ item_list` | object | List of products linked with the Shopee Video. |
| `↳↳↳ shop_id` | int64 | Shopee's unique identifier for a shop of the item. |
| `↳↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳↳ item_name` | string | Name of the item. |
| `↳↳↳ custom_item_name` | string | Name of the item displayed on Shopee Video (max 255 characters). |
| `↳↳↳ item_cover_image_url` | string | Cover image url of the item. |
| `↳↳↳ min_price` | float | Min price of the item. |
| `↳↳↳ max_price` | float | Max price of the item. |
| `↳↳↳ stock` | int64 | Stock of the item. |
| `↳↳ allow_info` | object | Whether allow stitch and duet. |
| `↳↳↳ allow_stitch` | boolean | Whether allow stitch. |
| `↳↳↳ allow_duet` | boolean | Whether allow duet. |
| `↳↳ scheduled_info` | object | When scheduled_post is true, scheduled_post_time must not empty. When scheduled_post is false, scheduled_post_time must empty. |
| `↳↳↳ scheduled_post` | boolean | Whether post it to Shopee Video at scheduled time. |
| `↳↳↳ scheduled_post_time` | timestamp | Scheduled post time, millisecond timestamp. |
| `↳↳ update_time` | timestamp | The lasted update time the video. |

Lỗi riêng: list_type must be 1,2 · page_no must over 1 · page_size can not over 20

## v2.video.get_video_detail
`GET /api/v2/video/get_video_detail` · loại: User · app được gọi: Shopee Video Management

Get the detail information of video.

Lịch sử cập nhật: 2026-09-03: add a new response field "aigc_label" "; -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `video_upload_id` | string |  | You can only select one from video_upload_id and post_id: - If you want to get detail information of video with draft status, please pass video_upload_id. - If you want to get detail information of video with post status, please pass post_id. |
| `post_id` | string |  | You can only select one from video_upload_id and post_id: - If you want to get detail information of video with draft status, please pass video_upload_id. - If you want to get detail information of video with post status, please pass post_id. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ video_upload_id` | string | ID of uploaded video. |
| `↳ post_id` | string | The unique identifier for post Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳ post_time` | timestamp | The time when the video post to Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳ video_url` | string | Video play url. |
| `↳ status` | int32 | Video current status. Applicable values: 200: DRAFT 300: POSTED 400: DELETED 500: SCHEDULED 600: SCHEDULED_FAILED |
| `↳ cover_image_url` | string | Cover image url of the Shopee Video. |
| `↳ caption` | string | Description of the Shopee Video. |
| `↳ duration` | int32 | Video duration time in millisecond. |
| `↳ views` | int64 | View count of post Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳ likes` | int64 | Like count of post Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳ comments` | int64 | Comment count the post Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳ has_performance` | boolean | Whether there is video metric data. |
| `↳ item_list` | object[] | List of products linked with the Shopee Video. |
| `↳↳ shop_id` | int64 | Shopee's unique identifier for a shop of the item. |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ item_name` | string | Name of the item. |
| `↳↳ custom_item_name` | string | Name of the item displayed on Shopee Video (max 255 characters). |
| `↳↳ item_cover_image_url` | string | Cover image url of the item. |
| `↳↳ min_price` | float | Min price of the item. |
| `↳↳ max_price` | float | Max price of the item. |
| `↳↳ stock` | int64 | Stock of the item. |
| `↳ allow_info` | object | Whether allow stitch and duet. |
| `↳↳ allow_stitch` | boolean | Whether allow stitch. |
| `↳↳ allow_duet` | boolean | Whether allow duet. |
| `↳ scheduled_info` | object | When scheduled_post is true, scheduled_post_time must not empty. When scheduled_post is false, scheduled_post_time must empty. |
| `↳↳ scheduled_post` | boolean | Whether post it to Shopee Video at scheduled time. |
| `↳↳ scheduled_post_time` | timestamp | Scheduled post time, millisecond timestamp. |
| `↳ update_time` | timestamp | The lasted update time the video. |
| `aigc_label` | boolean | Whether the video contains AI-generated or AI-assisted content, such as visuals, voice, avatars, or scripts. Returns true if the video contains AI-generated or AI-assisted content, otherwise, returns false. |

Lỗi riêng: video_upload_id is illegal · videoUploadIdList all illegal,no record in database · The user is not authorized and needs to be in toggle

## v2.video.delete_video
`POST /api/v2/video/delete_video` · loại: User · app được gọi: Shopee Video Management

Use this API to delete video. You can delete the video for both draft and post status.

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `video_upload_id_list` | string[] |  | You can only select one from video_upload_id_list and post_id_list: - If you want to delete video with draft status, please pass video_upload_id_list. - If you want to delete video with post status, please pass post_id_list. |
| `post_id_list` | string[] |  | You can only select one from video_upload_id_list and post_id_list: - If you want to delete video with draft status, please pass video_upload_id_list. - If you want to delete video with post status, please pass post_id_list. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ success_list` | object[] | The list of video delete successfully. |
| `↳↳ success_video_upload_id` | string | The video_upload_id delete successfully. |
| `↳↳ success_post_id` | string | The post_id delete successfully. |
| `↳ failure_list` | object[] | The list of video delete deleted. |
| `↳↳ fail_video_upload_id` | string | Failed video_upload_id. |
| `↳↳ fail_post_id` | string | Failed post_id. |
| `↳↳ failed_reason` | string | Failed reason of the corresponding video_upload_id or post_id. |

Lỗi riêng: Please check failure_list for detailed reason · video_upload_id is illegal · videoUploadIdList all illegal,no record in database · video_upload_list can not over 5 · video_upload_id_list and post_id_list all empty · video_upload_id_list and post_id_list can only select one

## v2.video.get_overview_performance
`GET /api/v2/video/get_overview_performance` · loại: User · app được gọi: Shopee Video Management

Get overall performance data for all post Shopee Video. There is at least a one-day delay.

Lịch sử cập nhật: 2025-09-10: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `period_type` | string | ✔ | Period Type. Applicable values: Day Week Month Last7d Last15d Last30d Note: The end date must align with the Period Type. |
| `end_date` | string | ✔ | The end_date format should be "YYYY-MM-DD". - For Day, Last7d, Last15d, and Last30d, the end_date must before current day. - For Week, the end_date must be Sunday and must be less than or equal to the current week. - For Month, the end_date must be the end of the month and must be less than or equal to the current month. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ key_metric` | object |  |
| `↳↳ placed_sales` | float | The placed value of orders from all videos in the period selected. |
| `↳↳ confirmed_sales` | float | The confirmed value of orders from all videos in the period selected. |
| `↳↳ placed_orders` | int64 | The number of placed orders from all videos in the period selected. |
| `↳↳ confirmed_orders` | int64 | The number of confirmed orders from all videos in the period selected. |
| `↳↳ placed_item_sold` | int64 | Number of item sold from placed orders in the video. |
| `↳↳ confirmed_item_sold` | int64 | Number of item sold from confirmed orders in the video. |
| `↳↳ total_viewers` | int64 | Number of viewers of the video. |
| `↳↳ effective_views` | int64 | Number of views for the video that lasted for more than 3 seconds. |
| `↳↳ avg_view_duration` | int64 | Total watch duration per video. |
| `↳ conversion` | object |  |
| `↳↳ placed_buyers` | int64 | Number of unique buyers who placed order from the video. |
| `↳↳ confirmed_buyers` | int64 | Number of unique buyers who confirmed order from the video. |
| `↳↳ total_atc` | int64 | Number of "Add To Cart" button clicked for all products in the orange bag during video viewing. |
| `↳↳ ctr` | float | Number of products clicks divided by Number of video views. |
| `↳↳ placed_co_rate` | float | Number of placed product orders from the video divided by Number of product clicks from the video. |
| `↳↳ confirmed_co_rate` | float | Number of confirmed product orders from the video divided by Number of product clicks from the video. |
| `↳↳ placed_abs` | float | Total placed sales divided by Total placed orders. |
| `↳↳ confirmed_abs` | float | Total confirmed sales divided by Total confirmed orders. |
| `↳↳ placed_gpm` | float | The placed Sales generated for every 1,000 views. |
| `↳↳ confirmed_gpm` | float | The confirmed Sales generated for every 1,000 views. |
| `↳↳ video_with_products` | int64 | Videos with at least one product in the orange bag. |
| `↳↳ placed_revenue_generating_videos` | int64 | Videos that generates placed revenues. |
| `↳↳ confirmed_revenue_generating_videos` | int64 | Videos that generates confirmed revenues. |
| `↳ engagement` | object |  |
| `↳↳ total_views` | int64 | Number of views from all videos |
| `↳↳ total_likes` | int64 | Number of likes from all videos |
| `↳↳ total_shares` | int64 | Number of shares from all videos |
| `↳↳ total_comments` | int64 | Number of comments from all videos |
| `↳↳ video_new_followers` | int64 | Number of new followers from all videos |
| `↳ fetched_date_range` | string | Data offline computation time. |

Lỗi riêng: endDate is Illegal · periodType is Illegal

## v2.video.get_metric_trend
`GET /api/v2/video/get_metric_trend` · loại: User · app được gọi: Shopee Video Management

Query video data indicator trends.

Lịch sử cập nhật: 2025-09-10: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `period_type` | string | ✔ | Period Type. Applicable values: Day Week Month Last7d Last15d Last30d Note: The end date must align with the Period Type. |
| `end_date` | string | ✔ | The end_date format should be "YYYY-MM-DD". - For Day, Last7d, Last15d, and Last30d, the end_date must before current day. - For Week, the end_date must be Sunday and must be less than or equal to the current week. - For Month, the end_date must be the end of the month and must be less than or equal to the current month. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ video_total_metric_list` | object[] |  |
| `↳↳ placed_sales` | float | The placed value of orders from all videos in the period selected. |
| `↳↳ confirmed_sales` | float | The confirmed value of orders from all videos in the period selected. |
| `↳↳ placed_orders` | int64 | The number of placed orders from all videos in the period selected. |
| `↳↳ confirmed_orders` | int64 | The number of confirmed orders from all videos in the period selected. |
| `↳↳ placed_item_sold` | int64 | Number of item sold from placed orders in the video. |
| `↳↳ confirmed_item_sold` | int64 | Number of item sold from confirmed orders in the video. |
| `↳↳ total_viewers` | int64 | Number of viewers in the video. |
| `↳↳ effective_views` | int64 | Number of views from the video that lasted for more than 3 seconds. |
| `↳↳ avg_view_duration` | int64 | Total watch duration per video. |
| `↳↳ placed_buyers` | int64 | Number of unique buyers who placed order from the video. |
| `↳↳ confirmed_buyers` | int64 | Number of unique buyers who confirmed order from the video. |
| `↳↳ total_atc` | int64 | Number of "Add To Cart" button clicked for all products in the orange bag during video viewing. |
| `↳↳ ctr` | float | Number of products clicks divided by Number of video views. |
| `↳↳ placed_co_rate` | float | Number of placed product orders from the video divided by Number of product clicks from the video. |
| `↳↳ confirmed_co_rate` | float | Number of confirmed product orders from the video divided by Number of product clicks from the video. |
| `↳↳ placed_abs` | float | Total placed sales divided by Total placed orders. |
| `↳↳ confirmed_abs` | float | Total confirmed sales divided by Total confirmed orders. |
| `↳↳ placed_gpm` | float | The placed Sales generated for every 1,000 views. |
| `↳↳ confirmed_gpm` | float | The confirmed Sales generated for every 1,000 views. |
| `↳↳ video_with_products` | int64 | Videos with at least one product in the orange bag |
| `↳↳ placed_revenue_generating_videos` | int64 | Videos that generates placed revenues. |
| `↳↳ confirmed_revenue_generating_videos` | int64 | Videos that generates confirmed revenues. |
| `↳↳ total_views` | int64 | Number of views from all videos. |
| `↳↳ total_likes` | int64 | Number of likes from all videos. |
| `↳↳ total_shares` | int64 | Number of shares from all videos. |
| `↳↳ total_comments` | int64 | Number of comments from all videos. |
| `↳↳ video_new_followers` | int64 | Number of new followers from all videos. |
| `↳↳ data_period` | string | Data offline computation time. |

Lỗi riêng: endDate is Illegal · periodType is Illegal

## v2.video.get_user_demographics
`GET /api/v2/video/get_user_demographics` · loại: User · app được gọi: Shopee Video Management

Get user demographics data to better understand the types of viewers that watch your Shopee Video.

Lịch sử cập nhật: 2025-09-10: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ age` | object | The age distribution of your viewers. Note: The type of age is a map. The key is an enumerated value corresponding to an age range: -1: Unknown 1: 18-24 years old 2: 25-34 years old 3: 35-44 years old 4: 45+ years old The value is the number of viewers in each age group. |
| `↳ gender` | object | The gender distribution of your viewers. Note: The type of gender is a map. The key is one of: Male Female Predicted Male Predicted Female The value is the number of viewers for each gender type. |
| `↳ location` | object | The geographic distribution of your viewers. Note: The type of location is a map. The key is top 10 city, and the value is the number of viewers in each city. |
| `↳ identity` | object | The distribution of viewers based on whether they follow your Shopee Video profile. Note: The type of identity is a map. The key is either "follow" or "unfollow", indicating followers and non-followers respectively, and the value is number of page views generated by each group. |
| `↳ activity` | object | The distribution of video views across different hours of the day. Note: The type of activity is a map. The key is the hour of the day (ranging from 0 to 23), and the value is the number of video views generated during that specific hour. |
| `↳ content` | object | The types of videos that your viewer is most interested in. Note: The type of content is a map. The key is top 10 content category, and the value is the number of video views corresponding to that content category. |
| `↳ shopping` | object | The types of products that your viewers is most interested in. Note: The type of shopping is a map. The key is top 10 product category, and the value is the number of video views corresponding to that product category. |

Lỗi riêng: userid or shopId is Illegal

## v2.video.get_video_performance_list
`GET /api/v2/video/get_video_performance_list` · loại: User · app được gọi: Shopee Video Management

Get specific performance data for individual post Shopee Video. There is at least a one-day delay.

Lịch sử cập nhật: 2025-09-11: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 | ✔ | The start index of request. Starting from 1. |
| `page_size` | int32 | ✔ | The number of video returned by this request. Max is 20. |
| `period_type` | string | ✔ | Period Type. Applicable values: Day Week Month Last7d Last15d Last30d Note: The end date must align with the Period Type. |
| `end_date` | string | ✔ | The end_date format should be "YYYY-MM-DD". - For Day, Last7d, Last15d, and Last30d, the end_date must before current day. - For Week, the end_date must be Sunday and must be less than or equal to the current week. - For Month, the end_date must be the end of the month and must be less than or equal to the current month. |
| `caption` | string |  | Description of the Shopee Video. |
| `order_by` | string | ✔ | Use this field to specify which field to use to sort the returned list. Available values: Views Likes Comments AvgViewsDuration |
| `sort` | string | ✔ | Use this field to specify whether the returned list is sorted in ascending or descending order_by. Available values: asc desc |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ total_count` | int32 | The total count of video that match the condition. |
| `↳ has_more` | boolean | This is to indicate whether the video list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of data. |
| `↳ list` | object[] | The list of video that match the condition. |
| `↳↳ video_upload_id` | string | ID of uploaded video. |
| `↳↳ post_id` | string | The unique identifier for post Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳↳ post_time` | timestamp | The time when the video post to Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳↳ video_url` | string | Video play url. |
| `↳↳ status` | int64 | Video current status. Applicable values: 300: POSTED 400: DELETED |
| `↳↳ cover_image_url` | string | Cover image url of the Shopee Video. |
| `↳↳ caption` | string | Description of the Shopee Video. |
| `↳↳ duration` | string | Video duration time in millisecond. |
| `↳↳ views` | int64 | View count of post Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳↳ likes` | int64 | Like count the post Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳↳ comments` | int64 | Comment count the post Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳↳ shares` | int64 | Share count the post Shopee Video. Only have value when the video status is 300 (POSTED). |
| `↳↳ avg_views_duration` | int64 | Total watch duration per video. |
| `↳↳ completion_rate` | float | Video completion rate. |
| `↳↳ placed_orders` | int64 | The number of placed orders for the video. |
| `↳↳ confirmed_orders` | int64 | The number of confirmed orders for the video. |
| `↳↳ placed_sales` | float | The placed value of orders for the video. |
| `↳↳ confirmed_sales` | float | The confirmed value of orders for the video. |
| `↳↳ placed_item_sold` | int64 | Number of item sold from placed orders in the video. |
| `↳↳ confirmed_item_sold` | int64 | Number of item sold from confirmed orders in the video. |
| `↳↳ fetched_date_range` | string | Data Date Range. |

Lỗi riêng: endDate is Illegal · orderby is illegal · periodType is Illegal

## v2.video.get_prodcut_performance_list
`GET /api/v2/video/get_prodcut_performance_list` · loại: User · app được gọi: Shopee Video Management

Get specific performance data for products linked with Shopee Video. There is at least a one-day delay.

Lịch sử cập nhật: 2025-09-10: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int32 | ✔ | The start index of request. Starting from 1. |
| `page_size` | int32 | ✔ | The number of item returned by this request. Max is 20. |
| `period_type` | string | ✔ | Period Type. Applicable values: Day Week Month Last7d Last15d Last30d Note: The end date must align with the Period Type. |
| `end_date` | string | ✔ | The end_date format should be "YYYY-MM-DD". - For Day, Last7d, Last15d, and Last30d, the end_date must before current day. - For Week, the end_date must be Sunday and must be less than or equal to the current week. - For Month, the end_date must be the end of the month and must be less than or equal to the current month. |
| `order_by` | string | ✔ | Use this field to specify which field to use to sort the returned list. Available values: PlacedOrders PlacedSales PlacedUniqueBuyers ConfirmedOrders ConfirmedSales ConfirmedUniqueBuyers |
| `sort` | string | ✔ | Use this field to specify whether the returned list is sorted in ascending or descending order_by. Available values: asc desc |
| `item_id` | int64 |  | Shopee's unique identifier for an item. |
| `item_name` | string |  | Search by product name. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ total_count` | int32 | The total count of product that match the condition. |
| `↳ has_more` | boolean | This is to indicate whether the video list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of data. |
| `↳ list` | object[] | The list of product that match the condition. |
| `↳↳ shop_id` | int64 | Shopee's unique identifier for a shop. |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ item_name` | string | Name of the item. |
| `↳↳ item_cover_image_url` | string | Cover image url of the item. |
| `↳↳ item_description` | string | Description of the item. |
| `↳↳ placed_orders` | int64 | The number of placed orders for the item. |
| `↳↳ confirmed_orders` | int64 | The number of confirmed orders for the item. |
| `↳↳ placed_sales` | float | The placed value of orders for the item. |
| `↳↳ confirmed_sales` | float | The confirmed value of orders for the item. |
| `↳↳ placed_unique_buyers` | int64 | Number of unique buyers who placed order for the item. |
| `↳↳ confirmed_unique_buyers` | int64 | Number of unique buyers who confirmed order for the item. |
| `↳↳ fetched_date_range` | string | Data Date Range. |

Lỗi riêng: endDate is Illegal · orderby is illegal · periodType is Illegal

## v2.video.get_video_detail_performance
`GET /api/v2/video/get_video_detail_performance` · loại: User · app được gọi: Shopee Video Management

Get detailed performance data for individual post Shopee Video. There is at least a one-day delay.

Lịch sử cập nhật: 2025-11-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `post_id` | string | ✔ | A unique identifier for Shopee videos. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ video_info` | object | Video post detail informations you are querying. |
| `↳↳ post_id` | string | A unique identifier for Shopee videos. |
| `↳↳ post_time` | timestamp | The time when the video post to Shopee Video. |
| `↳↳ video_url` | string | Video play url. |
| `↳↳ cover_image_url` | string | Cover image url of the Shopee Video. |
| `↳↳ caption` | string | Description of the Shopee Video. |
| `↳↳ duration` | int64 | Video duration time in millisecond. |
| `↳↳ related_item_count` | int64 | Number of products linked with the Shopee Video. |
| `↳ video_performance` | object | Overall performance data of the video you are querying. |
| `↳↳ views` | int64 | Amount of views from the video. |
| `↳↳ likes` | int64 | Total likes from the video. |
| `↳↳ comments` | int64 | Total comments from the video. |
| `↳↳ shares` | int64 | Total shares from the video. |
| `↳↳ followers_growth` | int64 | Amount of new followers from the Video. |
| `↳↳ placed_orders` | int64 | Amount of product orders from the video. |
| `↳↳ placed_sales` | float | Amount of product sales from the video. |
| `↳↳ unique_buyers` | int64 | Buyers of the products in the video. |
| `↳↳ conversion_rate` | float | Amount of products sold from the video/amount of views from the video. |
| `↳↳ sold_items` | int64 | Amount of products sold from the video. |
| `↳↳ product_clicks` | int64 | The product click value of orders for item. |
| `↳↳ product_click_rate` | float | The product click rate value of orders for item. |
| `↳↳ sales_per_order` | float | Amount of product sales from the video/amount of product orders from the video. |
| `↳↳ sales_per_buyer` | float | Amount of product sales from the video/amount of buyers from the video. |

Lỗi riêng: can not find post_id. · post_id is illegal

## v2.video.get_video_detail_metric_trend
`GET /api/v2/video/get_video_detail_metric_trend` · loại: User · app được gọi: Shopee Video Management

Get detailed metric trend data for individual post Shopee Video. There is at least a one-day delay.

Lịch sử cập nhật: 2025-11-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `post_id` | string | ✔ | A unique identifier for Shopee videos. |
| `metric_name` | string | ✔ | The name of metric that require obtaining trend data. Applicable values: Views, Likes, Comments, Shares, FollowersGrowth, PlacedOrders, PlacedSales, UniqueBuyers, ConversionRate, SoldItems, SalesPerOrder, SalesPerBuyer |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ metric_trend` | object | The type of metric_trend is a map. The key is date (in millisecond timestamp format), and the value is the number corresponding to metric. |

Lỗi riêng: can not find post_id. · metric_name is illegal · post_id is illegal

## v2.video.get_video_detail_audience_distribution
`GET /api/v2/video/get_video_detail_audience_distribution` · loại: User · app được gọi: Shopee Video Management

Get detailed audience distribution data for individual post Shopee Video. There is at least a one-day delay.

Lịch sử cập nhật: 2025-11-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `post_id` | string | ✔ | A unique identifier for Shopee videos. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ age` | object | The age distribution of your viewers. Note: The type of age is a map. The key is an enumerated value corresponding to an age range: -1: Unknown 1: 18-24 years old 2: 25-34 years old 3: 35-44 years old 4: 45+ years old The value is the number of viewers in each age group. |
| `↳ gender` | object | The gender distribution of your viewers. Note: The type of gender is a map. The key is one of: male female predictedMale predictedFemale unknown The value is the number of viewers for each gender type. |
| `↳ location` | object | The geographic distribution of your viewers. Note: The type of location is a map. The key is top 10 city, and the value is the number of viewers in each city. |
| `↳ identity` | object | The distribution of viewers based on whether they follow your Shopee Video profile. Note: The type of identity is a map. The key is one of: 0: Non-follower 1: Follower The value is number of user views generated by each group. |
| `↳ activity` | object | The distribution of video views across different hours of the day. Note: The type of activity is a map. The key is the hour of the day (ranging from 0 to 23), and the value is the number of video views generated during that specific hour. |
| `↳ content` | object | The types of videos that your viewer is most interested in. Note: The type of content is a map. The key is content category, and the value is the number of video views corresponding to that content category. |
| `↳ shopping` | object | The types of products that your viewers is most interested in. Note: The type of shopping is a map. The key is product category, and the value is the number of video views corresponding to that product category. |

Lỗi riêng: can not find post_id. · post_id is illegal · userid or shopId is Illegal

## v2.video.get_video_detail_product_performance
`GET /api/v2/video/get_video_detail_product_performance` · loại: User · app được gọi: Shopee Video Management

Get performance data for products linked with individual post Shopee Video. There is at least a one-day delay.

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `page_no` | int64 | ✔ | The start index of request. Starting from 1. |
| `page_size` | int64 | ✔ | The number of item returned by this request. Max is 20. |
| `post_id` | string | ✔ | The unique identifier for post Shopee Video. |
| `item_id` | int64 |  | Shopee's unique identifier for an item. |
| `item_name` | string |  | Name of the item. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ list` | object[] | The list of item that match the condition. |
| `↳↳ shop_id` | int64 | Shopee's unique identifier for a shop. |
| `↳↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳↳ item_name` | string | Name of the item. |
| `↳↳ item_cover_image_url` | string | Cover image url of the item. |
| `↳↳ item_description` | string | Description of the item. |
| `↳↳ likes` | int64 | Like count the post Shopee Video. |
| `↳↳ comments` | int64 | Comment count the post Shopee Video. |
| `↳↳ placed_orders` | int64 | Amount of product orders from the video. |
| `↳↳ placed_sales` | float | Amount of product sales from the video. |
| `↳↳ unique_buyers` | int64 | Buyers of the product in the video. |
| `↳↳ sold_items` | int64 | Amount of products sold from the video. |
| `↳↳ product_clicks` | int64 | Amount of product clicks from the video. |
| `↳↳ product_click_rate` | float | Amount of product clicks from the video/Product view from video. |
| `↳↳ conversion_rate` | float | Amount of products sold from the video/amount of views from the video. |
| `↳↳ sales_per_order` | float | Amount of product sales from the video/amount of product orders from the video. |
| `↳↳ sales_per_buyer` | float | Amount of product sales from the video/amount of buyers from the video. |
| `↳ total_count` | int64 | The total count of video that match the condition. |
| `↳ has_more` | boolean | This is to indicate whether the video list is more than one page. If this value is true, you may want to continue to check next page to retrieve the rest of data. |

Lỗi riêng: page_no must over 1 · page_size can not over 20 · can not find post_id. · post_id is illegal

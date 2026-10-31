# Module Media (6 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.media.upload_image
`POST /api/v2/media/upload_image` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Customer Service, Consignment Service System, Livestream Management

Use this API to upload images and support different business scenarios through business and scene parameters.

Lịch sử cập nhật: 2025-09-04: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `business` | int32 | ✔ | Defines the business type of the uploaded image. Supported values: 2 = Returns |
| `scene` | int32 | ✔ | Defines the purpose of the uploaded image under the specified business type. Supported values: - If business = 2 (Returns): 1 = Return Seller Self Arrange Pickup Proof Image |
| `images` | file | ✔ | The image files to be uploaded. Rules and restrictions by business and scene: - If business = 2 (Returns) and scene = 1 (Return Seller Self Arrange Pickup Proof Image): Up to 3 images can be uploaded. Each image must not exceed 10MB . Supported formats: JPG, JPEG, PNG . |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ image_list` | object[] | List of uploaded images. |
| `↳↳ image_id` | string | Unique ID of the uploaded image. |
| `↳↳ image_url` | string | URL of the uploaded image. |

## v2.media.init_video_upload
`POST /api/v2/media/init_video_upload` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Customer Service, Consignment Service System, Shopee Video Management

Use this API to initialize a new video upload task and obtain a unique upload session ID.

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `business` | int32 | ✔ | Defines the business type of the uploaded image. Supported values: 3 = Video |
| `scene` | int32 | ✔ | Defines the purpose of the uploaded image under the specified business type. Supported values: - If business = 3 (Video): 1 = Shopee Video |
| `file_name` | string | ✔ | Original video file name. |
| `file_size` | int64 | ✔ | Total video file size in bytes. Rules and restrictions by business and scene: - If business = 3 (Video) and scene = 1 (Shopee Video): Maximum 1GB . |
| `duration` | int32 | ✔ | Video duration in seconds. Rules and restrictions by business and scene: - If business = 3 (Video) and scene = 1 (Shopee Video): 1s~180s . |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ video_upload_id` | string | Unique upload session ID. |
| `↳ part_size` | int64 | The size of each part. When uploading video chunks, the video must be split according to this part size for each upload request. |

## v2.media.upload_video_part
`POST /api/v2/media/upload_video_part` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Customer Service, Consignment Service System, Shopee Video Management

Use this API to upload a video file in parts.

Lịch sử cập nhật: 2025-09-18: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `video_upload_id` | string | ✔ | The unique ID of the upload task, returned by v2.media.init_video_upload. |
| `part_seq` | int32 | ✔ | Sequence number of this part, starting from 0. |
| `part_content` | file | ✔ | The content of this part of file. Part size should be exactly equal to part_size returned in v2.media.init_video_upload, except last part of file. |
| `part_md5` | string | ✔ | MD5 checksum of this part for data integrity validation. |

## v2.media.complete_video_upload
`POST /api/v2/media/complete_video_upload` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Customer Service, Consignment Service System, Shopee Video Management

Use this API to finalize a video upload task. Once called, the system will transcode all uploaded video parts and prepare the video for use. All parts must be fully uploaded before calling this API.

Lịch sử cập nhật: 2025-09-18: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `video_upload_id` | string | ✔ | The unique ID of the upload task, returned by v2.media.init_video_upload. |

## v2.media.get_video_upload_result
`GET /api/v2/media/get_video_upload_result` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Customer Service, Consignment Service System, Shopee Video Management

Use this API to retrieve the current status and result of a video upload task. You can also use video_upload_result_push to get notified immediately when a video upload reaches a final status (SUCCEEDED, FAILED, or CANCELLED).

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `video_upload_id` | string | ✔ | The unique ID of the upload task, returned by v2.media.init_video_upload. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ status` | string | Current status of the upload task. Possible values: - INITIATED: Upload task has been created (via init_video_upload) but no parts have been uploaded yet. - UPLOADING: Video file parts are being uploaded. The upload has started but is not yet completed. - UPLOADED: All video parts have been uploaded successfully, waiting for complete_video_upload to trigger processing. - PROCESSING: Video is being transcoded/validated by the system (duration, format, resolution checks). - SUCCEEDED: Video upload and transcoding completed successfully. Video URL and cover URL are available for use. - FAILED: Upload or processing failed (e.g., invalid format, duration not within allowed range, transcoding erro |
| `↳ reason` | string | Detailed fail or cancel reason, will be returned if status is FAILED or CANCELLED. |
| `↳ update_time` | timestamp | The time of video status updates. |
| `↳ video_info` | object | Transcoded video info, will be returned if status is SUCCEEDED. |
| `↳↳ video_url` | string | Video playback url. |
| `↳↳ video_thumbnail_url` | string | Video thumbnail image url. |
| `↳↳ thumbnail_width` | int32 | Video thumbnail image width. |
| `↳↳ thumbnail_height` | int32 | Video thumbnail image width. |
| `↳↳ duration` | int32 | Video duration in seconds. |
| `↳↳ resolution` | string | Video resolution, e.g., "1280x1280". |

## v2.media.cancel_video_upload
`POST /api/v2/media/cancel_video_upload` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Customer Service, Consignment Service System, Shopee Video Management

Use this API to cancel an ongoing video upload task. If the upload has already succeeded, failed, or been cancelled, this operation will fail and return error.

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `video_upload_id` | string | ✔ | The unique ID of the upload task, returned by v2.media.init_video_upload. |

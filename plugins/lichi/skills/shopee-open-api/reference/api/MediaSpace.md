# Module MediaSpace (6 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.media_space.init_video_upload
`POST /api/v2/media_space/init_video_upload` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Initiate video upload session. Video duration should be between 10s and 60s (inclusive).

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `file_md5` | string | ✔ | md5 of video file |
| `file_size` | int64 | ✔ | size of video file, in bytes, maximum is 30MB |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ video_upload_id` | string | The identifier of this upload session, used in following video upload request and item creating and/or updating |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Unknown error. · Unknown error. · Unknown internal error. · Unknown internal error. · Invalid parameter. · File size is too large. Video size should be less than 30M.

## v2.media_space.upload_video_part
`POST /api/v2/media_space/upload_video_part` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Upload video file by part using the upload_id in initiate_video_upload. The request Content-Type of this API should be of multipart/form-data

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `video_upload_id` | string | ✔ | The video_upload_id in the response of initiate_video_upload |
| `part_seq` | int64 | ✔ | Sequence of the current part, starts from 0 |
| `content_md5` | string | ✔ | md5 of this part |
| `part_content` | file | ✔ | The content of this part of file. Part size should be exactly 4MB, except last part of file. |

Lỗi riêng: There is no access_token in query. · Invalid access_token. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Unknown error. · Unknown error. · Unknown internal error. · Unknown internal error. · Invalid parameter.

## v2.media_space.complete_video_upload
`POST /api/v2/media_space/complete_video_upload` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Complete the video upload and starts the transcoding process when all parts are uploaded successfully.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `video_upload_id` | string | ✔ | The ID of this upload session, returned in init_video_upload. |
| `part_seq_list` | int64[] | ✔ | All uploaded sequence number. |
| `report_data` | object | ✔ |  |
| `↳ upload_cost` | uint64 | ✔ | Time used for uploading the video file via upload_video_part api, in milliseconds. For video upload performance tracking purpose. |

Lỗi riêng: There is no access_token in query. · Invalid access_token. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Unknown error. · Unknown error. · Unknown internal error. · Unknown internal error. · Invalid parameter.

## v2.media_space.get_video_upload_result
`GET /api/v2/media_space/get_video_upload_result` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Query the upload status and result of video upload.

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `video_upload_id` | string | ✔ |  |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ status` | string | Current status of this video upload session. could be: INITIATED(waiting for part uploading and/or the complete_video_upload API call), TRANSCODING(has received all video parts, and is transcoding the video file), SUCCEEDED(transcoding completed, and this upload_id can now be used for item adding/updating), FAILED(this upload failed, see the message filed for some info), CANCELLED(this upload is cancelled) |
| `↳ video_info` | object | Transcoded video info, will be present if status is SUCCEEDED. |
| `↳↳ video_url_list` | object[] | Video playback URL list. |
| `↳↳↳ video_url_region` | string | The region of this video URL. |
| `↳↳↳ video_url` | string | Video playback URL. |
| `↳↳ thumbnail_url_list` | object[] | Video thumbnail image URL list. |
| `↳↳↳ image_url_region` | string | The region of this image URL. |
| `↳↳↳ image_url` | string | Image display URL. |
| `↳↳ duration` | uint64 | Duration of this video, in seconds. |
| `↳ message` | string | Detail error message if video uploading/transcoding failed. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Unknown error. · Unknown error. · Unknown internal error. · Unknown internal error. · Invalid parameter. · Invalid upload_id.

## v2.media_space.cancel_video_upload
`POST /api/v2/media_space/cancel_video_upload` · loại: Shop · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Cancel a video upload session

Lịch sử cập nhật: 2021-12-09: update video_upload_id as required

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `video_upload_id` | string | ✔ | The ID of this upload session, returned in init_video_upload. |

Lỗi riêng: Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Unknown error. · Unknown error. · Unknown internal error. · Unknown internal error. · Invalid parameter. · Invalid upload_id. · Upload already completed.

## v2.media_space.upload_image
`POST /api/v2/media_space/upload_image` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Swam ERP

Use this API to upload multiple image files (less than 9 images).

Lịch sử cập nhật: 2025-09-08: select type for some parameters; 2024-01-26: Add a new ratio field. Support to upload 3:4 image; 2022-10-14: add image_info_list; 2022-02-21: add scene parameter; 2021-10-18: update the image description

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `image` | file | ✔ | image files. Max 10.0 MB each. Image format accepted: JPG, JPEG, PNG. image number should be less than 9 |
| `scene` | string |  | The scene where the picture is used, The value range is normal or desc; normal: we will process the image as a square image, it is recommended to use when uploading item image; desc: we will not process the image, it is recommended to use when uploading the image of extend_description, if you do not upload this field, it will be normal. |
| `ratio` | string |  | only applicable to whitelisted sellers. only support 1:1 and 3:4; 1:1 by default. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ image_info` | object |  |
| `↳↳ image_id` | string | Id of image |
| `↳↳ image_url_list` | object[] | Image URL of each region |
| `↳↳↳ image_url_region` | string | Region of image url |
| `↳↳↳ image_url` | string | image url |
| `↳ image_info_list` | object[] |  |
| `↳↳ id` | int32 | the index of images |
| `↳↳ error` | string | Indicate error type if this index's image upload processing hit error. Empty if no error happened for this index's image . |
| `↳↳ message` | string | Indicate error detail if this index's image upload processing hit error. Empty if no error happened for this index's image . |
| `↳↳ image_info` | object |  |
| `↳↳↳ image_id` | string | Id of image |
| `↳↳↳ image_url_list` | object[] | Image URL of each region |
| `↳↳↳↳ image_url_region` | string | Region of image url |
| `↳↳↳↳ image_url` | string | image url |

Lỗi riêng: There is no access_token in query. · Invalid access_token. · Inner http call failed · parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · Interal error, please contact openapi team. · Interal error, please contact openapi team.

# Module Installation (2 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.installation.receive_installation_order
`POST /api/v2/installation/receive_installation_order` · loại: Public · app được gọi: Auto Parts Installation (ISP), Auto Parts Installation (Seller-Owned)

Receive installation order. Use this API to move installation status to PARCEL_PICKED_UP.

Lịch sử cập nhật: -: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `installation_order_id` | int64 | ✔ | Unique ID of the installation order. Passed to ISP on installation order creation. |
| `reason` | string | ✔ | Reason for the installation status update. Currently only support empty string. |

Lỗi riêng: Invalid entity status. · Requested entity is not found. · Invalid parameter. · Requested entity status is already passed. · Internal server error.

## v2.installation.validate_installation_otp_code
`POST /api/v2/installation/validate_installation_otp_code` · loại: Public · app được gọi: Auto Parts Installation (ISP), Auto Parts Installation (Seller-Owned)

Validate installation order OTP code. Use this API to validate OTP code when parcel status is PARCEL_PICKED_UP, PARCEL_REQUEST_CANCELLED, or PARCEL_CANCELLED.

Lịch sử cập nhật: 2026-05-09: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `installation_order_id` | int64 | ✔ | Unique ID of the installation order. Passed to ISP on installation order creation. |
| `installation_otp` | string | ✔ | OTP Code from buyer side. |

Lỗi riêng: Invalid entity status. · Requested entity is not found. · Action is not supported. · OTP Code is invalid. · Invalid parameter. · Internal server error.

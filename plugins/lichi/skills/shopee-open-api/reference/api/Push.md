# Module Push (4 API)

Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.

## v2.push.set_app_push_config
`POST /api/v2/push/set_app_push_config` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Marketing, Customer Service, Brand Membership, Customized APP, Ads Service, Consignment Service System, Custom APP, Swam ERP, Livestream Management, Affiliate Marketing Solution Management, Shopee Video Management

you can turn on or turn off your app push config setting through this open api

Lịch sử cập nhật: 2022-08-19: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `callback_url` | string |  | The callback url of push mechanism. It is the address where the Shopee will send the push message to. If you don't set any callback_url before, this parameters is required. |
| `set_push_config_on` | int[] |  | Turn on push config, Shopee will send the push message into the callback url. 1=Shop authorization for partners 2=Shop deauthorization for partners 3=Order status update push 4=TrackingNo push 5=Shopee Updates 6=Banned item push 7=item promotion push 8=reserved stock change push 9=promotionn update push 10=webchat push 11=video upload push 12=openapi authorization expiry push 13=brand register result |
| `set_push_config_off` | int[] |  | Turn off Push config, Shopee won't send the push message into the callback url. 1=Shop authorization for partners 2=Shop deauthorization for partners 3=Order status update push 4=TrackingNo push 5=Shopee Updates 6=Banned item push 7=item promotion push 8=reserved stock change push 9=promotionn update push 10=webchat push 11=video upload push 12=openapi authorization expiry push 13=brand register result |
| `blocked_shop_id_list` | int[] |  | Use this filed to set shops that need to be blocked.Please input no more than 500 shop id. |

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ result` | string | Use this field to indicate whether the configuration is set successfully. |

Lỗi riêng: {msg} · this callback_url is invalid, please check your callback_url. · Your app's callback_url is empty, please input a callback_url before you turn on push config. · parse data failed · data not exist · parameter invalid · The call back url can not be Shopee intranet address, please change another new call back url · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · Shopee have sent a test push to this call back url, but we didn't get any response in 3 seconds with 2xx code, please check your service. · request not from gateway · {msg} · error server · Shopee have sent a test push to this call back url, the response code we get from this callback_url is not 2xx code, please check your service.

## v2.push.get_app_push_config
`GET /api/v2/push/get_app_push_config` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Marketing, Customer Service, Brand Membership, Customized APP, Ads Service, Consignment Service System, Custom APP, Swam ERP, Livestream Management, Affiliate Marketing Solution Management, Shopee Video Management

you can get your app current push config setting through this api

Lịch sử cập nhật: 2022-08-19: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object | Detail informations you are querying. |
| `↳ callback_url` | string | The callback url of push mechanism. It is the address where the Shopee will send the push message to. If you don't set any callback_url before, this parameters is required. |
| `↳ live_push_status` | string | live push status:Normal,Warning,Suspended |
| `↳ suspended_time` | timestamp | The live push suspended time caused by low successful rate of push mechanism.Only when live push status is suspended, this parameters will response. |
| `↳ blocked_shop_id` | int[] | Use this filed to indicate that Shopee won't send any push message created by this shop. |
| `↳ push_config_on_list` | int[] | Use this field to indicate which push config turn on, and you can receive the push message. 1=Shop authorization for partners 2=Shop deauthorization for partners 3=Order status update push 4=TrackingNo push 5=Shopee Updates 6=Banned item push 7=item promotion push 8=reserved stock change push 9=promotionn update push 10=webchat push 11=video upload push 12=openapi authorization expiry push 13=brand register result |
| `↳ push_config_off_list` | int[] | Use this field to indicate which push config turn on, and you can receive the push message. 1=Shop authorization for partners 2=Shop deauthorization for partners 3=Order status update push 4=TrackingNo push 5=Shopee Updates 6=Banned item push 7=item promotion push 8=reserved stock change push 9=promotionn update push 10=webchat push 11=video upload push 12=openapi authorization expiry push 13=brand register result |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · error server

## v2.push.get_lost_push_message
`GET /api/v2/push/get_lost_push_message` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Marketing, Customer Service, Brand Membership, Customized APP, Ads Service, Consignment Service System, Custom APP, Swam ERP, Livestream Management, Affiliate Marketing Solution Management, Shopee Video Management

Get the lost push messages that were lost within 3 days of the current time and not confirmed to have been consumed

Lịch sử cập nhật: 2023-11-17: New API

**Response**

| Trường | Kiểu | Mô tả |
|---|---|---|
| `response` | object |  |
| `↳ push_message_list` | object[] | Returns the earliest 100 lost push messages that were lost within 3 days of the current time and not confirmed to have been consumed. |
| `↳↳ shop_id` | int | Shopee's unique identifier for a shop. If it's a partner level push (such as code: 1, 2, 12), shop_id will not be returned. |
| `↳↳ code` | int | Shopee's unique identifier for a push notification. |
| `↳↳ timestamp` | timestamp | Timestamp that indicates the message was lost. |
| `↳↳ data` | string | Main Push message data. |
| `↳ has_next_page` | boolean | This is to indicate whether the lost push message to be consumed is more than 100. If this value is true, you may need to continue calling to get the remaining lost push messages to be consumed. |
| `↳ last_message_id` | int | Specifies the end entry of data returned in the current call. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · error server

## v2.push.confirm_consumed_lost_push_message
`POST /api/v2/push/confirm_consumed_lost_push_message` · loại: Public · app được gọi: ERP System, Seller In House System, Product Management, Order Management, Accounting And Finance, Marketing, Customer Service, Brand Membership, Customized APP, Ads Service, Consignment Service System, Custom APP, Swam ERP, Livestream Management, Affiliate Marketing Solution Management, Shopee Video Management

Confirm consumed lost push message

Lịch sử cập nhật: 2023-11-17: New API

**Request**

| Tham số | Kiểu | Bắt buộc | Mô tả |
|---|---|---|---|
| `last_message_id` | int | ✔ | The last_message_id returned by v2.push.get_lost_push_message. |

Lỗi riêng: parse data failed · data not exist · parameter invalid · The information you queried is not found. · Wrong parameters, detail: {msg}. · Something wrong. Please try later. · request not from gateway · error server

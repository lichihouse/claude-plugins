# Shopee Push Mechanism (webhook)

Tự sinh từ open.shopee.com/push-mechanism. `code` = trường code trong body push. retry = số giây chờ giữa các lần gửi lại.

## Product Push

### reserved_stock_change_push (code 8)
Get the reserved stock change log

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message info |
| `↳ shop_id` | int | Shopee's unique identifier for a shop. |
| `↳ item_id` | int | Shopee's unique identifier for an item. |
| `↳ variation_id` | int | Shopee's unique identifier for a variation of an item. |
| `↳ changed_values` | object[] | Changed event. |
| `↳↳ name` | string | The field value we changed. |
| `↳↳ old` | int | The value before change. |
| `↳↳ new` | int | The value after change. |
| `↳ promotion_type` | string | Promotion type：seller_discount / product_promotion_SG / product_promotion_MY / product_promotion_ID / product_promotion_VN / product_promotion_TW / product_promotion_TH / product_promotion_PH / flash_sale (contains: in_shop_flash_sale, flash_sale, brand_sale) / add_on_deal_main / add_on_deal_sub / bundle_deal / group_buy / Platform Streaming / Seller Streaming / Campaign (contains: deep_discount, platform_sale, low_price_promotion) |
| `↳ promotion_id` | int | The identity of item promotion. |
| `↳ action` | string | The action of the event. Can be "place_order" or "cancel_order" |
| `↳ ordersn` | string | The ordersn associated with the event. |
| `↳ update_time` | string | The time of event. |
| `shop_id` | int | Shopee's unique identifier for a shop. |
| `code` | int | Shopee's unique identifier for a push notification |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

Action: place_order

``` json
{"data":{"shop_id":1274495,"item_id":18614185187,"variation_id":87912785718,"changed_values":[{"name":"reserved_stock","old":4951,"new":4950}],"promotion_type":"flash_sale","promotion_id":104993304719361,"action":"place_order","ordersn":"220810QXVJM3EX","update_time":1660124246},"shop_id":1274495,"code":8,"timestamp":1660124246}
```

 

 

Action:cancel_order

``` json
{"data":{"shop_id":1274495,"item_id":19213740442,"variation_id":154918396482,"changed_values":[{"name":"reserved_stock","old":199,"new":200}],"promotion_type":"flash_sale","promotion_id":103363389812736,"action":"cancel_order","ordersn":"220809KS77DXTS","update_time":1660124321},"shop_id":1274495,"code":8,"timestamp":1660124321}
```

### video_upload_push (code 11)
Get the video upload push result

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object |  |
| `↳ video_upload_id` | string | The identifier of this upload session, used in following video upload request and item creating and/or updating. |
| `↳ status` | string | Video upload result. Can be SUCCEEDED / FAILED |
| `↳ message` | string | More about failed uploads. |
| `↳ video_info` | object | Video id and video url for each markets. |
| `↳↳ video_id` | string | Equal to video_upload_id, the identifier for this upload session, used for subsequent video upload requests and item creation and/or updates |
| `↳↳ video_url` | object[] | Video URLs for each markets |
| `↳↳↳ video_url_region` | string | Video region. |
| `↳↳↳ video_url` | string | Video URL |
| `↳↳ thumbnail_url` | object[] | Video thumbnails for each markets. |
| `↳↳↳ image_url_region` | string | Video Thumbnail region. |
| `↳↳↳ image_url` | string | image url. |
| `shop_id` | int | Shopee's unique identifier for a shop. |
| `code` | int | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

If video upload successfully, push notification will be 

``` json
{
    "data": {
        "video_upload_id": "sg_f12ebfcb-a415-4c8a-b873-cc2ea8803c11_000203",
        "status": "SUCCEEDED",
        "message": "Success",
        "video_info": {
            "video_id": "0b6b0046852b64676545cf734ef52441",
            "video_url": [{
                "video_url_region": "MX",
                "video_url": "https://cvf.shopee.com.mx/file/0b6b0046852b64676545cf734ef52441"
            }, {
                "video_url_region": "CO",
                "video_url": "https://cvf.shopee.com.co/file/0b6b0046852b64676545cf734ef52441"
            }, {
                "video_url_region": "BR",
                "video_url": "https://cvf.shopee.com.br/file/0b6b0046852b64676545cf734ef52441"
            }, {
                "video_url_region": "ID",
                "video_url": "https://cvf.shopee.co.id/file/0b6b0046852b64676545cf734ef52441"
            }, {
                "video_url_region": "PH",
                "video_url": "https://cvf.shopee.ph/file/0b6b0046852b64676545cf734ef52441"
            }, {
                "video_url_region": "TH",
                "video_url": "https://cvf.shopee.co.th/file/0b6b0046852b64676545cf734ef52441"
            }, {
                "video_url_region": "TW",
                "video_url": "https://cvf.shopee.tw/file/0b6b0046852b64676545cf734ef52441"
            }, {
                "video_url_region": "VN",
                "video_url": "https://cvf.shopee.vn/file/0b6b0046852b64676545cf734ef52441"
            }, {
                "video_url_region": "CL",
                "video_url": "https://cvf.shopee.cl/file/0b6b0046852b64676545cf734ef52441"
            }, {
                "video_url_region": "PL",
                "video_url": "https://cvf.shopee.pl/file/0b6b0046852b64676545cf734ef52441"
            }, {
                "video_url_region": "MY",
                "video_url": "https://cvf.shopee.com.my/file/0b6b0046852b64676545cf734ef52441"
            }, {
                "video_url_region": "SG",
                "video_url": "https://cvf.shopee.sg/file/0b6b0046852b64676545cf734ef52441"
            }],
                   "thumbnail_url": [          {             
                "image_url_region": "BR",
                             "image_url": "https://cf.shopee.com.br/file/023397b8fe760c31c2185dd6dc93be64"          
            },            {             
                "image_url_region": "SG",
                             "image_url": "https://cf.shopee.sg/file/023397b8fe760c31c2185dd6dc93be64"          
            },            {             
                "image_url_region": "TW",
                             "image_url": "https://cf.shopee.tw/file/023397b8fe760c31c2185dd6dc93be64"          
            },            {             
                "image_url_region": "VN",
                             "image_url": "https://cf.shopee.vn/file/023397b8fe760c31c2185dd6dc93be64"          
            },            {          

### brand_register_result (code 13)
Get the brand register result

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object |  |
| `↳ shop_id` | int | Shopee's unique identifier for a shop. |
| `↳ register_brand` | object | Seller registered brand information. |
| `↳↳ brand_id` | int | The brand id returned by Shopee for the brand registration. |
| `↳↳ brand_name` | string | The brand name applied by the seller. |
| `↳ register_result` | object | Registration result |
| `↳↳ result` | string | Registration result. Can be Brand Registration Successfully / Brand Registration Reject / Brand combined with an exist brand |
| `↳↳ reason` | string | More detail about the result. |
| `shop_id` | int | Shopee's unique identifier for a shop. |
| `code` | int | Shopee's unique identifier for a shop. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

Whether it is a brand registered by seller centre or open api, you will receive the brand review results (Registration before the toggle is turned on will no longer be pushed)

 

**When a seller creates a brand through a seller centre or through v2.product.register_brand api, the Push mechanism will not push information at this time.**

 

The seller will get a brand which status is pending. At this time, it is allowed for the seller to use this brand id to add and update products.

 

**1.After the brand is approved, the developer will receive Push messages, such as:**

 

``` json
{"data":{"shop_id":748773,"register_brand":{"brand_id":3232262,"brand_name":"Omiz"},"register_result":{"result":"Brand Registration Successfully","reason":""}},"shop_id":74877883,"code":13,"timestamp":1660123176}
```

 

At this time, the status of the brand will change from pending to normal

 

**2. When the brand is rejected, the developer will receive Push messages, such as:**

``` json
{"data":{"shop_id":832182,"register_brand":{"brand_id":3228538,"brand_name":"Pop Up Squishy"},"register_result":{"result":"Brand Registration Reject","reason":"Merek tidak sah."}},"shop_id":832182994,"code":13,"timestamp":1660122620}
```

 

This brand will no longer be available, and the brand name of products that have used this brand in history will be changed to "No brand"

 

** 3. After the brand is merged, the developer will receive Push messages, such as:**

``` json
{"data":{"shop_id":220181,"register_brand":{"brand_id":3228577,"brand_name":"Cavero"},"register_result":{"result":"Brand combined with an exist brand","reason":""},"combined_brand":{"brand_id":1017064,"brand_name":"Cavero"}},"shop_id":220140481,"code":13,"timestamp":1660124291}
```

 

**This brand will no longer be available, and product brands that have used this brand in the past will display the new brand name**

### violation_item_push (code 16)
Get notified when item status becomes BANNED or SHOPEE_DELETE, or marked as deboost, including the violation type, violation reason, suggestion and fix deadline time.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message data |
| `↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳ item_name` | string | Name of the item. |
| `↳ item_status` | string | Enumerated type that defines the current status of the item. Applicable values: NORMAL, BANNED, UNLIST, SELLER_DELETE, SHOPEE_DELETE, REVIEWING. |
| `↳ deboost` | boolean | If deboost is true, means that the item's search ranking is lowered. |
| `↳ item_status_details` | object[] |  |
| `↳↳ violation_type` | string | Violation types defined by Shopee. Applicable values: Prohibited Listing Counterfeit and IP Infringement Spam Inappropriate Image Insufficient Information Mall Listing Improvement Other Listing Improvement |
| `↳↳ violation_reason` | string | The reason for violation. |
| `↳↳ suggestion` | string | Shopee provides you with suggestions for modifying items. |
| `↳↳ fix_deadline_time` | timestamp | Action required deadline. Empty if no deadline. |
| `↳↳ update_time` | timestamp | Latest update time. |
| `↳ deboost_details` | object[] |  |
| `↳↳ violation_type` | string | Violation types defined by Shopee. Applicable values: Prohibited Listing Counterfeit and IP Infringement Spam Inappropriate Image Insufficient Information Mall Listing Improvement Other Listing Improvement |
| `↳↳ violation_reason` | string | The reason for violation. |
| `↳↳ suggestion` | string | Shopee provides you with suggestions for modifying items. |
| `↳↳ suggested_category` | object[] |  |
| `↳↳↳ category_id` | int64 | ID for Shopee suggested category. |
| `↳↳↳ category_name` | string | Default name for Shopee suggested category. |
| `↳↳ fix_deadline_time` | timestamp | Action required deadline. Empty if no deadline. |
| `↳↳ update_time` | timestamp | Latest update time. |
| `shop_id` | int64 | Shopee's unique identifier for a shop. |
| `code` | int32 | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

1\. When the item is banned by Shopee: 

``` java
{
    "data":{
        "item_id":3903127451,
        "item_name":"MZH制造商品1",
        "item_status":"BANNED",
        "deboost":false,
        "item_status_details":[
            {
                "violation_type":"Prohibited Listing",
                "violation_reason":"License Reason",
                "suggestion":"Upload license",
                "fix_deadline_time":1705228281,
                "update_time":1705055481
            },
            {
                "violation_type":"Inappropriate Image",
                "violation_reason":"Image Reason",
                "suggestion":"Update image",
                "fix_deadline_time":1705228281,
                "update_time":1705055481
            }
        ]
    },
    "shop_id":602228340,
    "code":16,
    "timestamp":1705055481
}
```

 

2\. When the item is deleted by Shopee: 

``` java
{
    "data":{
        "item_id":3903127452,
        "item_name":"MZH制造商品2",
        "item_status":"SHOPEE_DELETE",
        "deboost":false,
        "item_status_details":[
            {
                "violation_type":"Prohibited Listing",
                "violation_reason":"License Reason",
                "suggestion":"Upload license",
                "fix_deadline_time":1700638193,
                "update_time":1699428593
            }
        ]
    },
    "shop_id":602228340,
    "code":16,
    "timestamp":1699428593
}
```

 

3\. When the item is marked as deboost by Shopee: 

``` json
{
    "data":{
        "item_id":3603542555,
        "item_name":"MZH制造商品3",
        "item_status":"NORMAL",
        "deboost":true,
        "deboosted_details":[
            {
                "violation_type":"Inappropriate Image",
                "violation_reason":"Image Reason",
                "suggestion":"Update image",
                "fix_deadline_time":1704943027,
                "update_time":1704943027
            },
            {
                "violation_type":"Prohibited Listing",
                "violation_reason":"Wrong Category",
                "suggestion":"The item is in wrong category, please update to the suggested_category",
                "suggested_category":[
                    {
                        "category_id":100005,
                        "category_name":"Health"
                    },
                    {
                        "category_id":107478,
                        "category_name":"Personal Care"
                    }
                ],
                "fix_deadline_time":1704943027,
                "update_time":1704943027
            }
        ]
    },
    "shop_id":605748501,
    "code":16,
    "timestamp":1704943027
}
```

### item_price_update_push (code 22)
Send the push when the seller updates the original_price of the item or model.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message info. |
| `↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳ model_id` | int64 | Shopee's unique identifier for a model of an item. |
| `↳ update_field` | string | The field value we changed. It will be "original_price" and "local_price" |
| `↳ old_value` | float | The original_price value before the updates. |
| `↳ new_value` | float | The original_price value after the updates. |
| `↳ update_time` | timestamp | The time of original_price updates. |
| `shop_id` | int64 | Shopee's unique identifier for a shop. |
| `code` | int32 | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

Action: Seller updates the original_price of the item or model.

``` json
{
    "data": {
        "item_id": 1861418518,
        "model_id": 8791278571,
        "update_field": "original_price",
        "old_value": 119.99,
        "new_value": 99.99,
        "update_time": 1660124246
    },
    "shop_id": 127449165,
    "code": 22,
    "timestamp": 1660124246
}
```

### item_scheduled_publish_failed_push (code 27)
Get notified when the product fails to publish at scheduled publish time

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message info. |
| `↳ shop_id` | int64 | Shopee's unique identifier for a shop. |
| `↳ item_id` | int64 | Shopee's unique identifier for an item. |
| `↳ scheduled_publish_time` | timestamp | Scheduled publish time of this item. |
| `shop_id` | int64 | Shopee's unique identifier for a shop. |
| `code` | int32 | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

If the product fails to publish at scheduled publish time：

 

``` json
{"data":{"shop_id":220904434,"item_id":885138337,"scheduled_publish_time":1725922200},"shop_id":220904434,"code":27,"timestamp":1725922200}
```

### v2.ssp_update_push (code 48)
Unified SSP lifecycle push. Notify subscribed systems of SSP Profile updates, Shopee-initiated unlink results, validation results, automatic governance, seller unlink-review results and seller SSP-access status changes

timeout 3s · retry [300, 1800, 10800] · guarantee 1

| Trường | Kiểu | Mô tả |
|---|---|---|
| `event_type` | int32 | enum SspUpdateEventType { SSP_UPDATE_EVENT_TYPE_UNSPECIFIED = 0; // Item-level offline consistency validation failed and unlink completed. SSP_UPDATE_EVENT_TYPE_ASYNC_ITEM_CONSISTENCY_VALIDATION_FAILED_UNLINKED = 1; // Model-level offline consistency validation failed and unlink completed. SSP_UPDATE_EVENT_TYPE_ASYNC_MODEL_CONSISTENCY_VALIDATION_FAILED_UNLINKED = 2; // Auto-enroll successfully linked all target models. SSP_UPDATE_EVENT_TYPE_AUTO_ENROLL_LINKED = 3; // ERP/in-house system directly requested unlink through Open API. SSP_UPDATE_EVENT_TYPE_OPEN_API_LINKAGE_UNLINKED = 4; // Seller quick-unlink completed without review. SSP_UPDATE_EVENT_TYPE_SELLER_QUICK_UNLINKED = 5; // Seller unl |
| `item_id` | int64 |  |
| `model_cssp_pairs` | object[] | message LinkModelCsspPair{ optional uint64 model_id = 1; optional uint64 cssp_id = 2; optional uint64 ssp_id = 3; } |

Ví dụ:



## Order Push

### order_status_push (code 3)
Get notified immediately on all order status updates. This includes order cancellations that occur before shipping, so that you can take the necessary steps in time.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message data |
| `↳ ordersn` | string | Return by default. Shopee's unique identifier for an order. |
| `↳ status` | string | Return by default. Enumerated type that defines the current status of the order. |
| `↳ completed_scenario` | string | To indicate which COMPLETED status order is in. NORMAL: The order has been completed. RRAOC: The whole RRAOC (raise return&refund after order completed) progress has been completed. |
| `↳ update_time` | timestamp | Return by default. Timestamp that indicates the last time that there was a change in value of order, such as order status changed from 'Paid' to 'Completed'. |
| `shop_id` | int | Shopee's unique identifier for a shop. Required param for most APIs. |
| `code` | int | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

``` json
{"data":{"items":[],"ordersn":"220810QSK8S7BX","status":"PROCESSED","completed_scenario":"","update_time":1660123127},"shop_id":727720655,"code":3,"timestamp":1660123127}
```

### order_trackingno_push (code 4)
Get notified immediately when order tracking numbers are updated so that you can ship promptly, and avoid having to query the v2.logistics.get_tracking_number API repeatedly. This can be useful when logistics partners take some time to update tracking numbers which may be required on shipping documents.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message data |
| `↳ ordersn` | string | Shopee's unique identifier for an order. |
| `↳ forder_id` | string | Coming offline |
| `↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳ tracking_no` | string | The tracking number of this order. |
| `shop_id` | int | Shopee's unique identifier for a shop. Required param for most APIs. |
| `code` | int | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | This is to indicate the timestamp of the request. |

Ví dụ:

``` json
{"data":{"ordersn":"220809MDBFYFT2","forder_id":"4965804244309504855","package_number":"OFG113701539238152","tracking_no":"BR222263688572VSPXLM71894"},"shop_id":296363855,"code":4,"timestamp":1660123089}
```

### shipping_document_status_push (code 15)
shipping_document_status_push

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message data. |
| `↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳ status` | string | The status of the shipping document generation. -READY -FAILED |
| `shop_id` | int | Shopee's unique identifier for a shop. Required param for most APIs. |
| `code` | int | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | This is to indicate the timestamp of the request. |

Ví dụ:

``` java
{"data": {"ordersn":"201118BCKPJQQ8","package_number":"2485710696837122445","status":"READY"},"shop_id":296363855,"code":15,"timestamp":1660123089}
```

### booking_status_push (code 23)
Get notified immediately on all booking status updates. This includes booking cancellations that occur before shipping, so that you can take the necessary steps in time.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message data |
| `↳ booking_sn` | string | Return by default. Shopee's unique identifier for a booking. |
| `↳ booking_status` | string | Return by default. Enumerated type that defines the current status of the booking. |
| `↳ update_time` | timestamp | Return by default. Timestamp that indicates the last time that there was a change in value of booking, such as booking status changed from 'Processed' to 'Shipped'. |
| `shop_id` | int64 | Shopee's unique identifier for a shop. Required param for most APIs. |
| `code` | int32 | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:



### booking_trackingno_push (code 24)
Get notified immediately when booking tracking numbers are updated so that you can ship promptly, and avoid having to query the v2.logistics.get_booking_tracking_number API repeatedly. This can be useful when logistics partners take some time to update tracking numbers which may be required on shipping documents.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message data |
| `↳ booking_sn` | string | Shopee's unique identifier for a booking. |
| `↳ tracking_number` | string | The tracking number of this booking. |
| `shop_id` | int64 | Shopee's unique identifier for a shop. Required param for most APIs. |
| `code` | int32 | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | This is to indicate the timestamp of the request. |

Ví dụ:



### booking_shipping_document_status_push (code 25)
Get notified immediately when booking shipping document status is updated.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message data. |
| `↳ booking_sn` | string | Shopee's unique identifier for a booking. |
| `↳ status` | string | The status of the shipping document generation. -READY -FAILED |
| `shop_id` | int64 | Shopee's unique identifier for a shop. Required param for most APIs. |
| `code` | int32 | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | This is to indicate the timestamp of the request. |

Ví dụ:



### package_fulfillment_status_push (code 30)
Get notified immediately on all package fulfillment status updates. This includes package cancellations that occur before shipping, so that you can take the necessary steps in time.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object |  |
| `↳ ordersn` | string | Shopee's unique identifier for an order. |
| `↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳ fulfillment_status` | string | The Shopee fulfillment status for the package. Applicable values: See V2.0 Data Definition - PackageFulfillmentStatus. |
| `↳ update_time` | int64 | Timestamp that indicates the last time that there was a change in value of package fulfillment status, such as package fulfillment status changed from 'LOGISTICS_READY' to 'LOGISTICS_REQUEST_CREATED'. |
| `shop_id` | int64 | Shopee's unique identifier for a shop. |
| `code` | int64 | Shopee's unique identifier for a push notification. |
| `timestamp` | int64 | Timestamp that indicates the message was sent. |

Ví dụ:

``` json
{"data":{"ordersn":"250421TPSF33R6","package_number":"OFG198917831207390","fulfillment_status":"LOGISTICS_REQUEST_CREATED","update_time":1660123127},"shop_id":727720655,"code":30,"timestamp":1660123127}
```

### courier_delivery_binding_status_push (code 37)
Get notified immediately on all first mile tracking number status updates for courier delivery.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message data. |
| `↳ binding_id` | string | Binding ID. |
| `↳ first_mile_tracking_number` | string | The first mile tracking number. |
| `↳ status` | string | The logistics status for first-mile tracking number. Status could be: CANCELED CANCELING DELIVERED NOT_AVAILABLE ORDER_CREATED ORDER_RECEIVED PICKED_UP |
| `↳ update_time` | timestamp | Timestamp that indicates the last time that there was a change in value of first mile tracking number status, such as status changed from 'PICKED_UP' to 'ORDER_RECEIVED'. |
| `shop_id` | int64 | Shopee's unique identifier for a shop. |
| `code` | int32 | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

``` json
{
    "data":{
        "binding_id": "DCN249237197572VU",
        "first_mile_tracking_number": "DCN249237197572VU",
        "status": "ORDER_RECEIVED",
        "update_time": 1660123089
    },
    "shop_id":296363855,
    "code":37,
    "timestamp":1660123089
}
```

### package_info_push (code 47)
Get notified immediately on package information updates, including Ship By Date and Logistics Channel changes, and Return Code generation for Return To Seller scenarios (Return Code only applies to packages under the SPX Instant & Sameday channel in ID region), so you can take the necessary steps in time.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `shop_id` | int64 | Shopee's unique identifier for a shop. |
| `code` | int32 | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |
| `data` | object |  |
| `↳ order_sn` | string | Shopee's unique identifier for an order. |
| `↳ package_number` | string | Shopee's unique identifier for the package under an order. |
| `↳ changed_fields` | string[] | Returns value: ship_by_date, logistics_channel_id, or return_code, depending on which field has been updated. Both values will be returned if both fields have been updated. |
| `↳ old` | object | Previous Ship By Date and logistics channel assigned to order. |
| `↳↳ logistics_channel_id` | int64 | Shopee's unique identifier for the previous logistics channel assigned to the order. |
| `↳↳ ship_by_date` | timestamp | Previous Ship By Date assigned to the order. |
| `↳↳ return_code` | string | The previous Return Code of the package. Note: Since return_code is generated only once and will not change, this field will always be empty when return_code is pushed. |
| `↳↳ pickup_time` | int64 | The old pickup start time assigned to the package. |
| `↳ new` | object | New Ship By Date and logistics channel assigned to order. |
| `↳↳ logistics_channel_id` | int64 | Shopee's unique identifier for the new logistics channel assigned to the order. |
| `↳↳ ship_by_date` | timestamp | New Ship By Date assigned to the order. |
| `↳↳ return_code` | string | The OTP generated after the package enters the RTS (Return to Seller) process. Sellers need to provide this OTP to the driver to complete the return confirmation. Note: This field only applies to packages under the SPX Instant& Sameday channel in ID region. |
| `↳↳ pickup_time` | int64 | The new pickup start time assigned to the package. |
| `↳ update_time` | timestamp | Timestamp that indicates the last time that there was a change in value of ship_by_date or logistics_channel_id or pickup_timestamp |

Ví dụ:

``` java
{
    "data": {
        "changed_fields": [
            "ship_by_date"
        ],
        "old": {
            "logistics_channel_id": 70124,
            "ship_by_date": 1764573365
            "return_code": "",
            "pickup_time": 1793346847
        },
        "new": {
            "logistics_channel_id": 70124,
            "ship_by_date": 1764746165
            "return_code": "",
            "pickup_time": 1793356847
        },
        "order_sn": "2512017TFPB0HF",
        "package_number": "OFG218268963204539",
        "update_time": 1764569831
    },
    "shop_id": 220688102,
    "code": 47,
    "timestamp": 1764569832
}
```

## Return Push

### return_updates_push (code 29)
Get notified when the following fields of Return Refund change: return_status, return_solution, seller_proof_status, logistics_status

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message data. |
| `↳ order_sn` | string | Return by default. Shopee's unique serial number identifier for an order. |
| `↳ return_sn` | string | Return by default. Shopee's unique serial number identifier for a Return Refund request. |
| `↳ updated_values` | object[] |  |
| `↳↳ update_field` | string | The field whose value is updated. - return_status - return_solution - seller_proof_status - logistics_status |
| `↳↳ old_value` | string | The value before the updates. |
| `↳↳ new_value` | string | The value after the updates. |
| `↳↳ update_time` | timestamp | The time of the updates. |
| `shop_id` | int64 | Shopee's unique identifier for a shop. Required param for most APIs. |
| `code` | int64 | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | This is to indicate the timestamp of the request. |

Ví dụ:

``` json
{
   "data": {
       "order_sn": "241128EDQ9YKJ0",
       "return_sn": "2411280EDT4JRV5",
       "updated_values": [
           {
               "update_field": "return_status",
               "old_value": "JUDGING",
               "new_value": "PROCESSING",
               "update_time": 1732796767
           },
           {
               "update_field": "logistics_status",
               "old_value": "LOGISTICS_NOT_STARTED",
               "new_value": "LOGISTICS_PENDING_ARRANGE",
               "update_time": 1732796767
           }
       ]
   },
   "shop_id": 220004993,
   "code": 29,
   "timestamp": 1732796767
}
```

## Marketing Push

### item_promotion_push (code 7)
Get the promotion update info

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object |  |
| `↳ shop_id` | int | Shopee's unique identifier for a shop. |
| `↳ item_id` | int | Shopee's unique identifier for an item. |
| `↳ variation_id` | int | Shopee's unique identifier for a variation of an item. |
| `↳ promotion_type` | string | Promotion type：seller_discount / product_promotion_SG / product_promotion_MY / product_promotion_ID / product_promotion_VN / product_promotion_TW / product_promotion_TH / product_promotion_PH / flash_sale (contains: in_shop_flash_sale, flash_sale, brand_sale) / add_on_deal_main / add_on_deal_sub / bundle_deal / group_buy / Platform Streaming / Seller Streaming / Campaign (contains: deep_discount, platform_sale, low_price_promotion) |
| `↳ promotion_id` | int | The identity of item promotion. |
| `↳ action` | string | `action` could be one of `promo_lock_stock`, `promo_cancelled` and `promo_end`. |
| `↳ update_time` | timestamp | Promotion update time. |
| `↳ start_time` | timestamp | Promotion start time. |
| `↳ end_time` | timestamp | Promotion end time. |
| `↳ reserved_stock` | int | The reserved stock set by the seller for the promotion. |
| `shop_id` | int | Shopee's unique identifier for a shop. |
| `code` | int | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

Push will be triggered whenever an item's stock is locked/unlocked by promotion.

 

Push logic:

1.When the item was added in promotion, the normal stock will deduct the stock set by the promotion stock, At this time, the promotion stock is also reserved_stock.

action will return promo_lock_stock.

``` json
{"data":{"shop_id":46641242,"item_id":14946910660,"variation_id":58301485734,"promotion_type":"flash_sale","promotion_id":669260829761778,"action":"promo_lock_stock","update_time":1660123421,"start_time":1660453200,"end_time":1660474800,"reserved_stock":100},"shop_id":46641242,"code":7,"timestamp":1660123421}
```

 

2.When the promotion ends or promo_cancelled, the remaining promotion stock will be added back to the normal stock. At this time, action will return promotion ends or promo_cancelled.

``` json
{"data":{"shop_id":180727490,"item_id":15183813372,"variation_id":125725857023,"promotion_type":"flash_sale","promotion_id":669262197127658,"action":"promo_cancelled","update_time":1660124045,"start_time":1660410000,"end_time":1660453200,"reserved_stock":0},"shop_id":180727490,"code":7,"timestamp":1660124045}
```

 

``` json
{"data":{"shop_id":498881374,"item_id":20109158685,"variation_id":87837495102,"promotion_type":"flash_sale","promotion_id":669083704356214,"action":"promo_end","update_time":1660122009,"start_time":1660114800,"end_time":1660122000,"reserved_stock":0},"shop_id":498881374,"code":7,"timestamp":1660122018}
```

### promotion_update_push (code 9)
Get the promotion update

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object |  |
| `↳ shop_id` | int | Shopee's unique identifier for a shop. |
| `↳ promotion_id` | int | The identity of item promotion. |
| `↳ promotion_type` | string | The type of promotion.Promotion type：seller_discount / product_promotion_SG / product_promotion_MY / product_promotion_ID / product_promotion_VN / product_promotion_TW / product_promotion_TH / product_promotion_PH / flash_sale (contains: in_shop_flash_sale, flash_sale, brand_sale) / add_on_deal_main / add_on_deal_sub / bundle_deal / group_buy |
| `↳ end_time` | timestamp | Promotion end time. |
| `↳ action` | string | The action of the event. Action: added_in_promo / removed_from_promo / promo_time_updated |
| `↳ item_id` | int | Shopee's unique identifier for an item. |
| `↳ variation_id` | int | Shopee's unique identifier for a variation of an item. |
| `shop_id` | int | Shopee's unique identifier for a shop. |
| `code` | int | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

We will push messages when these three events occur：

- item is added in a promotion
- item is removed from a promotion
- promotion start /end time is updated

 

Push logic:

1.when item is added in a promotion:

- for reserved stock promotion（flash_sale/product_promotion），reserved_stock = reserved stock qty ；
- for non-reserved stock promotion，reserved_stock field won't return
- action = added_in_promo；

 

``` json
{"data":{"shop_id":712661865,"promotion_id":22775521,"promotion_type":"bundle_deal","start_time":1660124460,"end_time":1661943600,"action":"added_in_promo","item_id":14662380213,"variation_id":0},"shop_id":712661865,"code":9,"timestamp":1660124466}
```

 

2.when item is removed form a promotion:

- for reserved stock promotion（FS/PP），reserved_stock = the stock qty (the latest value)；
- action= removed_from_promo；
- there is one cases when item is removed form a promotion:  
  item is rejected/deleted，promotion still valid, notification will return the unique item that removed from a promotion;

``` json
{"data":{"shop_id":526225965,"promotion_id":668908774363077,"promotion_type":"seller_discount","action":"removed_from_promo","item_id":20332329221,"variation_id":145413438373},"shop_id":526225965,"code":9,"timestamp":1660124435}
```

 

3.when promotion start/end time is update (include upcoming and ongoing promotion):

- promotion_status = normal；
- action= promo_time_updated;
- start_time/ end_time  return the updated start/end  time；
- **no reserved stock field**

 

``` json
{"data":{"shop_id":722406687,"promotion_id":665808642693807,"promotion_type":"seller_discount","end_time":1660123171,"action":"promo_time_updated","item_id":19526059511,"variation_id":163767197734},"shop_id":722406687,"code":9,"timestamp":1660123173}
```

## Shopee Push

### shopee_updates (code 5)
The push refers to the Shopee updates under "My Inbox" in Seller Center. The push notification will include the title and content of the update but not the details.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `code` | int | Shopee's unique identifier for a push notification |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |
| `shop_id` | int | Shopee's unique identifier for a shop. It indicates which shop has been authorized. |
| `data` | object[] |  |
| `↳ actions` | object[] | It may include multiple Shopee Updates notifications. |
| `↳↳ content` | string | Content of the Shopee Updates notification |
| `↳↳ update_time` | timestamp | The push time of the Shopee Updates notification. |
| `↳↳ title` | string | Title of the Shopee Updates notification |
| `↳↳ url` | string | The URL of the Shopee Updates notification |

Ví dụ:

``` json
{"code":5, "timestamp":1610000000 ,"shop_id":1231234, "data":{"actions":[{"content":"Boost your growth when you engage a Shopee-Certified enabler ⭐ Learn how we can help optimise your performance during campaign season 👉", "update_time":1610000000, "title":"Find a Shopee-endorsed enabler", "url":"https://shopee.sg/m/shopee-certified-enablers-q2-2022"}, {"content":"Your feedback matters. Help us shape your Shopee experience! Take part in our survey now.", "update_time":16100002222, "title":"We want to hear from you", "url":"https://shopee.qualtrics.com/"}]}
```

### open_api_authorization_expiry (code 12)
Push shops, merchants, and users whose authorization expires within a week.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `code` | int32 | Shopee's unique identifier for a push notification |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |
| `data` | object[] |  |
| `↳ merchant_expire_soon` | int64[] | The merchant id of the merchants whose authorization expires within one week. |
| `↳ shop_expire_soon` | int64[] | The shop id of the shops whose authorization expires within one week. |
| `↳ user_expire_soon` | int64[] | The user_id of the users whose authorization expires within one week. |
| `↳ expire_before` | timestamp | The expiration time of pushed merchants and shops is before this time |
| `↳ page_no` | int32 |  |
| `↳ total_page` | int32 |  |

Ví dụ:

``` json
{
    "code": 12,
    "timestamp": 1568606634,
    "data": {
        "merchant_expire_soon":[123123,123123,4342,3242342],
        "shop_expire_soon": [23213,243242,342343,42342345656,45345],
        "user_expire_soon": [368765104,368765105,368765106],
        "expire_before": 1619740800, 
        "page_no":1,
        "total_page": 2 
    }
}
```

### shop_authorization_push (code 1)
This push allows you to be notified once shops or merchants are authorized to your app

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `partner_id` | int | Shopee's unique identifier for your App. Partner ID is assigned upon registration is successful. |
| `code` | int | Shopee's unique identifier for a push notification |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |
| `data` | object[] |  |
| `↳ shop_id` | int | [ Optional ] Shopee's unique identifier for a shop. It indicates which shop has been authorized. |
| `↳ shop_id_list` | int[] | [ Optional ] If the seller uses a main account to authorize multiple shops at the same time, there will be this parameter to indicate all authorized shops |
| `↳ merchant_id` | int | [ Optional ] Shopee's unique identifier for a merchant. It indicates which merchant has been authorized. |
| `↳ merchant_id_list` | int[] | [ Optional ] If the seller uses a main account to authorize multiple merchants at the same time, there will be this parameter to indicate all authorized merchants |
| `↳ authorize_type` | string | In which way shops are authorized to App |
| `↳ extra` | string | Details of the authorization |
| `↳ main_account_id` | int | [ Optional ] Shopee's unique identifier for a main account. If a seller uses a main account to authorize, it would have this parameter to indicate which main account seller use to authorize |
| `↳ success` | int | Indicates if the push is success |

Ví dụ:

Seller shop authorization

``` json
{"data":{"authorize_type":"shop authorization by user","extra":"shop id 600000 (SG) has been authorized successfully","shop_id":60011111,"success":1},"partner_id":2000002,"code":1,"timestamp":1660616278}
```

 

Seller uses main account to authorize shops

``` json
{"data":{"authorize_type":"shop authorization by user","extra":"Shop has been authorized successfully","main_account_id":68272,"shop_id_list":[62000001,62000002,62000003,62000004],"success":1},"partner_id":2000002,"code":1,"timestamp":1660616631}
```

 

Seller uses main account to authorize a merchant

``` json
{"data":{"authorize_type":"merchant authorization by user","extra":"merchant id 600000 has been authorized successfully","merchant_id":600222872,"success":1},"partner_id":2000007,"code":1,"timestamp":1660616278}
```

### shop_authorization_canceled_push (code 2)
This push allows you to be notified once shops or merchants or users are deauthorized to your app

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `partner_id` | int64 | Shopee's unique identifier for your App. Partner ID is assigned upon registration is successful. |
| `code` | int32 | Shopee's unique identifier for a push notification |
| `timestamp` | timestamp | timestamp: Timestamp that indicates the message was sent. |
| `data` | object[] |  |
| `↳ shop_id` | int64 | [ Optional ] Shopee's unique identifier for a shop. It indicates which shop has been cancel authorization. |
| `↳ shop_id_list` | int64[] | [ Optional ] Shopee's unique identifier for a shop. It indicates which shops have been cancel authorization. |
| `↳ merchant_id` | int64 | [Optional] Shopee's unique identifier for a merchant. It indicates which merchant has been cancel authorization. |
| `↳ merchant_id_list` | int64[] | [Optional] Shopee's unique identifier for a merchant. It indicates which merchants have been cancel authorization. |
| `↳ user_id` | int64 | [Optional] Shopee's unique identifier for a user. It indicates which user has been cancel authorization. |
| `↳ user_id_list` | int64[] | [Optional] Shopee's unique identifier for a user. It indicates which users have been cancel authorization. |
| `↳ authorize_type` | string | In which way the authorization is cancelled |
| `↳ extra` | string | Details of the deauthorization |
| `↳ main_account_id` | int64 | [ Optional ] Shopee's unique identifier for a main account. If a seller uses a main account to cancel authorize, it would have this parameter to indicate which main account seller use to cancel authorize. |
| `↳ success` | int32 | Indicates if the push is success |

Ví dụ:

Shop authorization canecled by seller

``` json
{"data":{"authorize_type":"user cancel shop authorization","success":1,"extra":"shop id 22000000 (VN) has been cancelled its authorization"},"code":2,"partner_id":800000,"timestamp":1653394175}
```

 

Seller uses a main account to cancel the authorization

``` json
{"data":{"authorize_type":"user cancel merchant authorization","merchant_id_list":[1001000],"main_account_id":19000,"success":1,"extra":"merchant shop cancelled its authorization"},"code":2,"partner_id":800000,"timestamp":1653026849}
```

 

Authorization expired

``` json
{"data":{"authorize_type":"expiry","shopid":22000000,"success":1,"extra":"The authorization is expired."},"code":2,"partner_id":800000,"timestamp":1653026985}
```

 

Deauthorization because of abnormal shop status 

``` json
{"data":{"authorize_type":"App status is abnormal","shopid":22000000,"success":1,"extra":"Shop ID 22000000 is currently frozen. The authorization cannot be completed."},"code":2,"partner_id":800000,"timestamp":1653026985}
```

 

Deauthorization because Shop and main account are disconnected

``` json
{"data":{"authorize_type":"shop and main account is disconnected","shopid":22000000,"success":1,"extra":"Shop (ID: 22000000) is disconnected from the main seller account (ID:30000). The authorization cannot be completed."},"code":2,"partner_id":800000,"timestamp":1653026985}
```

### shop_penalty_update_push (code 28)
Get notified when shop's penalty such as penalty point or punishment tier are updated.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message info. |
| `↳ action_type` | int32 | The action type of the event： 1: Penalty Point Issued 2: Penalty Point Removed 3: Punishment Tier Update |
| `↳ points_issued_data` | object |  |
| `↳↳ issued_points` | int32 | The penalty point issued of the updates. |
| `↳↳ violation_type` | int32 | The violation type of the penalty point： 5: High Late Shipment Rate 6: High Non-fulfillment Rate 7: High number of non-fulfilled orders 8: High number of late shipped orders 9: Prohibited Listings 10: Counterfeit / IP infringement 11: Spam 12: Copy/Steal images 13: Re-uploading deleted listings with no change 14: Bought counterfeit from mall 15: Counterfeit caught by Shopee 16: High percentage of pre-order listings 17: Confirmed Fraud attempts (total) 18: Confirmed Fraud attempts per week (All with vouchers only) 19: Fake return address 20: Shipping fraud/abuse 21: High No. of Non-responded Chat 22: Rude chat replies 23: Request buyer to cancel order 24: Rude reply to buyer's review 25: Viol |
| `↳ points_removed_data` | object |  |
| `↳↳ removed_points` | int32 | The penalty point removed of the updates. |
| `↳↳ violation_type` | int32 | The violation type of the penalty point： 5: High Late Shipment Rate 6: High Non-fulfillment Rate 7: High number of non-fulfilled orders 8: High number of late shipped orders 9: Prohibited Listings 10: Counterfeit / IP infringement 11: Spam 12: Copy/Steal images 13: Re-uploading deleted listings with no change 14: Bought counterfeit from mall 15: Counterfeit caught by Shopee 16: High percentage of pre-order listings 17: Confirmed Fraud attempts (total) 18: Confirmed Fraud attempts per week (All with vouchers only) 19: Fake return address 20: Shipping fraud/abuse 21: High No. of Non-responded Chat 22: Rude chat replies 23: Request buyer to cancel order 24: Rude reply to buyer's review 25: Viol |
| `↳↳ removed_reason` | int32 | The reason for removing penalty points： 101: Other Reasons 102: Shopee System Error 103: Third Party Logistics Issue 104: Weather / Natural disaster 105: Special Exemption 106: Waiver for SBS fulfillment 107: Waiver for SIP listing violation 108: Validated IPR |
| `↳ tier_update_data` | object |  |
| `↳↳ old_tier` | int32 | The punishment tier before the updates. |
| `↳↳ new_tier` | int32 | The punishment tier after the updates. |
| `↳ update_time` | timestamp | The time of penalty point or punishment tier updates. |
| `shop_id` | int64 | Shopee's unique identifier for a shop. |
| `code` | int32 | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

``` json
{"data":{"action_type":1,"points_issued_data": {"issued_points":3,"violation_type":10},"update_time":1660124246},"shop_id":127449165,"code":28,"timestamp":1660124246}
```

### video_upload_result_push (code 38)
Get notified immediately when a video upload reaches a final status (SUCCEEDED, FAILED, or CANCELLED). Intermediate status (INITIATED, UPLOADING, UPLOADED, PROCESSING) are not pushed to avoid unnecessary callbacks, can call v2.media.get_video_upload_result if need progress updates.

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object |  |
| `↳ video_upload_id` | string | The unique ID of the upload task. |
| `↳ status` | string | Final status of the upload task. Possible values: - SUCCEEDED - FAILED - CANCELLED Note: Intermediate status (INITIATED, UPLOADING, UPLOADED, PROCESSING) are not pushed to avoid unnecessary callbacks, can call v2.media.get_video_upload_result if need progress updates. |
| `↳ reason` | string | Detailed fail or cancel reason, will be returned if status is FAILED or CANCELLED. |
| `↳ video_info` | object | Transcoded video info, will be returned if status is SUCCEEDED. |
| `↳↳ video_url` | string | Video playback URL. |
| `↳↳ video_thumbnail_url` | string | Video thumbnail image URL. |
| `↳↳ thumbnail_width` | int32 | Video thumbnail image width. |
| `↳↳ thumbnail_height` | int32 | Video thumbnail image height. |
| `↳↳ duration` | int32 | Video duration in seconds. |
| `↳↳ resolution` | string | Video resolution, e.g., "1280x1280". |
| `↳ update_time` | timestamp | The time of video status updates. |
| `code` | int32 | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

``` json
{
   "data": {
       "status": "SUCCEEDED",
       "reason": "",
       "update_time": 1758018336,
       "video_info": {
           "video_url": "http://play-src.vod.shopee.com/api/v4/11110201/mms/sg-11110201-6kh48-mepm7a0ttcw3c3.",
           "video_thumbnail_url": "http://img.sp.mms.shopee.sg/sg-11110201-6kh48-mepm7a0ttcw3c3_cover",
           "thumbnail_width": 1920,
           "thumbnail_height": 1080,
           "duration": 105,
           "resolution": "960x540"
       }
   },
   "code": 37,
   "timestamp": 1758018336
}
```

## Webchat Push

### webchat_push (code 10)
Get the chat message

timeout 2s · retry [1, 2, 3] · guarantee 1

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object |  |
| `↳ type` | string | Can be notification / message |
| `↳ region` | string | The region info. |
| `↳ content` | object | The detailed message. |
| `↳↳ user_id` | string | Returned when the type = notification. |
| `↳↳ conversation_id` | string | Shopee's unique identifier for a conversation. |
| `↳↳ type` | string | Returned when the type = notification. |
| `↳↳ timestamp` | timestamp | Returned when the type = notification. |
| `↳↳ msg_id` | int64 | Returned when the type = notification. |
| `↳↳ biz_id` | int64 | Returned when the type = notification. |
| `↳↳ message_id` | string | Returned when type= message. Shopee's unique identifier for a message. |
| `↳↳ shop_id` | int64 | Returned when type= message. The shop_id of the shop message sent to (to_shop_id) |
| `↳↳ request_id` | string | Returned when type= message. The identifier for an request for error tracking. |
| `↳↳ from_user_name` | string | Returned when type= message. The user name for the message sender in the conversation. |
| `↳↳ from_id` | int64 | The user id for the message sender in the conversation. |
| `↳↳ to_id` | int64 | Returned when type= message. The user id for the message recipient in the conversation. |
| `↳↳ to_user_name` | string | Returned when type= message. The user name for the message recipient in the conversation. |
| `↳↳ message_type` | string | Returned when type= message. text / video / image / item / faq_liveagent |
| `↳↳ content` | object |  |
| `↳↳↳ text` | timestamp | Returned when message type=text or faq_liveagent, specific dialog text information. |
| `↳↳↳ translation` | object | Returned when message type=text. |
| `↳↳↳↳ text` | string |  |
| `↳↳↳↳ source` | string |  |
| `↳↳↳↳ target_language` | string |  |
| `↳↳↳↳ source_language` | string |  |
| `↳↳↳ mid` | object | Returned when message type=text. |
| `↳↳↳↳ text` | string |  |
| `↳↳↳↳ source` | string |  |
| `↳↳↳↳ target_language` | string |  |
| `↳↳↳↳ source_language` | string |  |
| `↳↳↳ url` | string | Returned when message type=image. |
| `↳↳↳ thumb_url` | string | Returned when message type=image or video. |
| `↳↳↳ thumb_height` | int64 | Returned when message type=image or video. |
| `↳↳↳ thumb_width` | int64 | Returned when message type=image or video. |
| `↳↳↳ file_server_id` | int64 | Returned when message type=image. |
| `↳↳↳ video_url` | string | Returned when message type=video. |
| `↳↳↳ duration_seconds` | int64 | Returned when message type=video. |
| `↳↳↳ shop_id` | int64 | Returned when message type=item. The shop_id of the shop message sent to (to_shop_id) |
| `↳↳↳ item_id` | int64 | Returned when message type=item. |
| `↳↳↳ pass_through_data` | string | Returned when message type=faq_liveagent. |
| `↳↳↳ messages` | string[] | Returned when type=bundle_message. return all the message_id in the bundle_message |
| `↳↳↳ shopee_chatbot_replied` | boolean | Return when message_type=bundle_message if there is Shopee Chatbot session in the bundle message We recommend transfer to manual reply mode if shopee_chatbot_replied=true(Shopee Chatbot already involved) |
| `↳↳ created_timestamp` | timestamp | Returned when type= message. The creation time of conversation. |
| `↳↳ region` | string | Returned when type= message. The region where the conversation take places. |
| `↳↳ is_in_chatbot_session` | boolean | Returned when type= message. |
| `↳↳ source_content` | object | Returned when type= message. |
| `↳↳↳ item_id` | int | Returned when message type= item. |
| `↳↳ sub_account_id` | int64 | if the message is sent from sub-account/main account, then will indicate the sub_account_id If not, =0 |
| `↳↳ sub_account_name` | string | if the message is sent from sub-account/main account, then will indicate the sub_account_id If not, =0 |
| `↳↳ quoted_msg` | object[] |  |
| `↳↳↳ message_id` | int64 | Return message_id when a quoted message is present. If there is no quoted message, message_id will be empty. |
| `↳↳ business_type` | int32 | business_type=0 means it is a conversation chat between buyer and seller business_type=11 means it is a conversation chat between affiliate and seller |
| `↳↳ to_shop_id` | int64 | shopee shop id who receive the message <path></path> |
| `↳↳ from_shop_id` | int64 | shopee shop id who send the message |
| `↳↳ status` | string | The message status, the possible values are: normal; auto_reply; blocked; user_chat; web_chat; censored_whitelist; censored_blacklist; offwork_autoreply |
| `shop_id` | int | shop_id of shop receives the push message Shopee's unique identifier for a shop. |
| `code` | int | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

**If it is notification type:**

 

``` json
{
"msg_id": null,
"data": {
"type": "notification",
"region": "PH",
"content": {
"user_id": 12252079,
"conversation_id": "4670954831706433",
"type": "mark_as_replied",
"content": {
"conversation_id": "4670954310906433"
},
"timestamp": 1719883961,
"msg_id": 0,
"biz_id": 0,
"from_id": 0
}
```

 

**If it is message type and message including text:**

 

``` json
{"msg_id":"","data":{"type":"message","region":"ID","content":{"message_id":"2302748948493123953","shop_id":165103149,"request_id":"35f9478b-7482-46eb-a268-8f828fedb673","from_id":165105353,"from_user_name":"vn_cstoreponorogo","to_id":947151379,"to_user_name":"keelatofficial","message_type":"text","content":{"text":"Baik kak .. 🤗"},"conversation_id":"709122092476686867","created_timestamp":1726044721,"region":"ID","is_in_chatbot_session":false,"source_content":{},"quoted_msg":{"message_id":""},"sub_account_id":0,"sub_account_name":0}},"shop_id":947042923,"code":10,"timestamp":1726044722}
```

 

**If it is message type and message including video**

 

``` json
{"data":{"type":"message","region":"VN","content":{"message_id":"2165920666211451249","shop_id":123456789,"request_id":"1091617252119662617","from_id":161057467,"from_user_name":"hyhy2606","to_id":213245905,"to_user_name":"sixhd.vn","message_type":"video","content":{"video_url":"cf03c9e1fe2c0992cdb51c3cb6eab2bd","thumb_url":"6c710d7679c9f3a9a7287250421d17d3_dynamic_tn","thumb_width":399,"thumb_height":713,"duration_seconds":15},"conversation_id":"691736553754845137","created_timestamp":1660799912,"region":"VN","is_in_chatbot_session":false,"source_content":{},"quoted_msg":{"message_id":""},"sub_account_id":0,"sub_account_name":0}},"shop_id":123456789,"code":10,"timestamp":1660799912}
```

 

**If it is message type and message including image**

 

``` json
{"data":{"type":"message","region":"VN","content":{"message_id":"2165920671942967665","shop_id":123456789,"request_id":"313F2D/BTMessage/p108","from_id":679422730,"from_user_name":"thutrang290402","to_id":6343861,"to_user_name":"thanhnga_hcm","message_type":"image","content":{"url":"https://cf.shopee.vn/file/09591ecdc9f1dc7bd507817797d826fe_dynamic","thumb_url":"b9591ecdc9f1dc7bd507817797d826fe_dynamic_tn","thumb_height":711,"thumb_width":400,"file_server_id":0},"conversation_id":"27246676204792586","created_timestamp":1660799915,"region":"VN","is_in_chatbot_session":false,"source_content":{},"quoted_msg":{"message_id":""},"sub_account_id":0,"sub_account_name":0}},"shop_id":123456789,"code":10,"timestamp":1660799915}
```

 

**If it is message type and message including item info**

 

``` json
{"data":{"type":"message","region":"ID","content":{"message_id":"2165920670806327665","shop_id":123456789,"request_id":"389465101372418716","from_id":163219823,"from_user_name":"fadlyjo.","to_id":119159078,"to_user_name":"zhousijia","message_type":"item","content":{"shop_id":109157255,"item_id":9112503530},"conversation_id":"511784343194732911","

## Consignment Service Push

### inbound_status_push (code 21)
When the inbound status changed, it will send a push

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `code` | int |  |
| `timestamp` | timestamp |  |
| `supplier_id` | int |  |
| `data` | object[] |  |
| `↳ inbound_id` | string | inbound 唯一id |
| `↳ inbound_status` | string | 入库单的状态，枚举： InboundStatusPendingSupplierDeclare-待申报 InboundStatusInTransit-运输中 InboundStatusArrived-已到达 InboundStatusDone-已接收 InboundStatusRejected-已拒绝 InboundStatusCancelled-已取消 |

Ví dụ:

{

    "inbound_id":"INCNN00001",

     "inbound_status":"InboundStatusInTransit",

}

### supplier_create_product_push (code 18)
get message when product create success

timeout 3s · retry [1, 3, 5] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `code` | int32 |  |
| `timestamp` | timestamp |  |
| `supplier_id` | int32 |  |
| `data` | object[] |  |
| `↳ supplier_product_id` | string | supplier_product_id |
| `↳ supplier_product_model_id_list` | string[] | supplier product model id list |
| `↳ create_time` | int32 |  |

Ví dụ:



### supplier_prouduct_review_result_push (code 19)
get message when supplier product review result has change

timeout 3s · retry [1, 3, 5] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `code` | int32 | Shopee's unique identifier for a push notification |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |
| `data` | object[] |  |
| `↳ supplier_product_id` | string | 货品id |
| `↳ supplier_product_model_id` | string | 货品规格id |
| `↳ approval_result` | string | 审核结果，值为下列结果之一："Pending Info Revision""Pending Sample Providing""Pending Sample Revision""Selected""Rejected" |
| `↳ approval_time` | timestamp | 审核时间 |
| `supplier_id` | int32 |  |

Ví dụ:



### purchase_order_Push (code 20)
When there is a new purchase order, a push will be sent

timeout 3s · retry [300, 1800, 10800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `code` | int32 |  |
| `timestamp` | timestamp |  |
| `supplier_id` | int32 |  |
| `data` | object[] |  |
| `↳ purchase_order_id` | string | 采购单号 <path></path> |
| `↳ purchase_order_status` | string | 采购单据的状态枚举： PoStatusPendingSupplierConfirmation-待确认PoStatusPendingPurchaserConfirmation-待买手确认PoStatusPendingAsnCreation-待asn创建PoStatusPendingShipment-待发货PoStatusPartiallyInbound-部分入库 PoStatusInbound-入库完成 PoStatusCancelled-取消 PoStatusClosed-关闭 |
| `↳ purchase_reason` | string | 采购原因可分为两类，用于区分该采购单是首单还是常规补货单枚举如下：FirstPurchase-首次备货 Replenishment-补货tips:不传参数类型，默认返回全部 |
| `↳ purchase_function_tag_list` | string[] | 采购单据的标签，采购单上可以有多个标签参数为枚举值，枚举映射如下：General-普通采购单JIT-准时化采购（just in time）的采购单 Urgent-加急的采购单InTransitSellable-在途可售的采购单tips:普通采购单没有标签 |
| `↳ create_time` | timestamp | 采购单创建时间 <path></path> |

Ví dụ:

{

    "purchase_order_id":"PO00001",

"purchase_order_status":"PoStatusPendingSupplierConfirmation",

    "purchase_reason":"FirstPurchase",

    "purchase_function_tag_list":\["JIT","Urgent","InTransitSellable"\],

    "create_time":1234567890,

}

## Fulfillment by Shopee Push

### fbs_sellable_stock (code 36)
Get notified on the sellable stock in warehouse when there is any changing update in the stock. For the fbs_sellable_stock, which means that the sellable stock in the warehouse, exclude the stock in isolated zone and damage zone from the warehouse.Only for the Brazil Fulfilled-by-Shopee (FBS) service.

timeout 3s · retry [60, 300, 1800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object | Main Push message info. |
| `↳ list` | object[] |  |
| `↳↳ mt_sku_id` | string | Warehouse SKU ID |
| `↳↳ whs_id` | string | Warehouse ID |
| `↳↳ shop_id` | int64 | Shop ID |
| `↳↳ whs_region` | string | The region that warehouse located |
| `↳↳ whs_sellable_qty` | int64 | Warehouse sellable stock qty |
| `↳↳ update_time` | timestamp | Update time |
| `shop_id` | int64 | Shop ID |
| `code` | int32 | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |

Ví dụ:

``` java
{
  "data": {
      "list": [
            {
                "mt_sku_id": "901240351_4259251776",
                "whs_id": "BRFSP1",
                "shop_id": 302235160,
                "whs_region": "BR",
                "whs_sellable_qty": 50,
                "update_time": 1750746789
            },
            {
                "mt_sku_id": "901240351_4259251776",
                "whs_id": "BRX",
                "shop_id": 302235160,
                "whs_region": "BR",
                "whs_sellable_qty": 370,
                "update_time": 1750746789
            },
            {
                "mt_sku_id": "901240351_4259251776",
                "whs_id": "BRK",
                "shop_id": 302235160,
                "whs_region": "BR",
                "whs_sellable_qty": 720,
                "update_time": 1750746789
            }
        ]
  },
  "shop_id": 302071623,
  "code": 36,
  "timestamp": 1751860958
}
```

### fbs_br_invoice_error_push (code 33)
Get notified on FBS relevant failed invoice issuance. This includes Inbound Request, RTS Request, sales orders and move transfer orders. Only for the Brazil Fulfilled-by-Shopee (FBS) service.

timeout 3s · retry [60, 300, 1800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `code` | int32 | Shopee's unique identifier for a push notification. |
| `timestamp` | timestamp | Timestamp that indicates the message was sent. |
| `shop_id` | int64 | Shopee's unique identifier for a shop. Required param for most APIs. |
| `data` | object[] | Main Push message data |
| `↳ shop_id` | int64 | Shopee's unique identifier for a shop. |
| `↳ biz_request_type` | int32 | 1: Inbound 2: Return From Warehouse 3: Sales order invoice 4: Move Transfer 5：IA |
| `↳ biz_request_id` | string | Return by default. The business FBS request order ID. |
| `↳ fail_reason` | string | Invoice issuance failed reason. |
| `↳ fail_type` | int32 | 1: sku tax info error 2: seller tax info error |
| `↳ invoice_deadline_time` | int64 | The expired time of this failed invoice. If expired, then this request order would be cancelled. |
| `↳ invoice_id` | string | Invoice ID |
| `↳ shop_sku_list` | object[] |  |
| `↳↳ shop_item_id` | int64 | ID of item |
| `↳↳ shop_model_id` | int64 | ID of model |
| `↳↳ shop_item_name` | string | Name of item |
| `↳↳ shop_model_name` | string | Name of model |
| `↳↳ shop_sku_id` | string | itemID_modelID |

Ví dụ:



### fbs_br_block_shop_push (code 34)
Get notified on FBS shop would be blocked due to invoice error. It is not allowed to raise new Inbound Request and not allow warehouse stock being sellable. Only for the Brazil Fulfilled-by-Shopee (FBS) service.

timeout 3s · retry [60, 300, 1800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `code` | int32 | Shopee's unique identifier for a push notification. |
| `timestamp` | int64 | Timestamp that indicates the message was sent. |
| `shop_id` | int64 | Shopee's unique identifier for a shop. |
| `data` | object | Main Push message data |
| `↳ shop_id` | int64 | Shopee's unique identifier for a shop. |

Ví dụ:



### fbs_br_block_sku_push (code 35)
Get notified on FBS Product would be blocked due to invoice error. It is not allowed to raise new Inbound Request and not allow warehouse stock being sellable. Only for the Brazil Fulfilled-by-Shopee (FBS) service.

timeout 3s · retry [60, 300, 1800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `code` | int32 | Shopee's unique identifier for a push notification |
| `timestamp` | int64 | Timestamp that indicates the message was sent. |
| `shop_id` | int64 | Shopee's unique identifier for a shop |
| `data` | object | Main Push message data |
| `↳ shop_sku_id` | string | itemID_modelID |
| `↳ shop_item_id` | int64 | ID of item |
| `↳ shop_model_id` | int64 | ID of model |
| `↳ shop_item_name` | string | Name of item |
| `↳ shop_model_name` | string | Name of model |

Ví dụ:



### fbs_br_invoice_issued_push (code 31)
Get notified when an FBS Brazil invoice is issued. Only for the Brazil Fulfilled-by-Shopee (FBS) service.

timeout 3s · retry [30, 600, 1800] · guarantee 0

| Trường | Kiểu | Mô tả |
|---|---|---|
| `data` | object |  |
| `↳ document_type` | string | Remessa Return Symbolic Return Sale Entrada Symbolic Remessa |
| `↳ order_sn` | string | if document_type = sale, then pass the related Order SN |
| `↳ issue_date` | timestamp | Timestamp that indicates the time invoice was issued. |
| `update_time` | timestamp | Indicate when the push message was triggered |
| `shop_id` | int64 | Shopee’s unique identifier for shop. E.g. 1660123127 |
| `code` | int32 | Shopee’s unique identifier for a push notification. |

Ví dụ:



# Logistics — tài liệu chi tiết

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.




---

## Logistic API overview

Doc: https://partner.tiktokshop.com/docv2/page/logistic-api-overview · cập nhật 2025-04-10

### Context
The Logistic API helps you obtain information about logistic resources including: 

* Get Warehouse List
* Get Subscribed Delivery Options
* Get Shipping Providers
* Get Global Warehouse List

When sellers create/publish products, they may need to:

* Get Warehouse List
* Get Global Warehouse List

For more detail, please refer to the ["Product API" overview](https://partner.tiktokshop.com/docv2/page/650b23eef1fd3102b93d2326).

When sellers fulfill orders, they may need to:

* Get Subscribed Delivery Options
* Get Shipping Providers

For more detail, please refer to the ["Fulfillment API" overview](https://partner.tiktokshop.com/docv2/page/650b2044f1fd3102b93c9178).
### Important Concepts
#### Warehouse
Warehouses are setup by sellers when they create their TikTok Shop account. This is where packages will be sent out from once an order needs to be shipped.
One seller can have multiple global warehouses.
One seller can have multiple warehouses for one shop.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/54149c6a76d3475b8f50e2dc02ff442a~tplv-k9wyc2ijk0-image.image)
When sellers want to create a global product, they need to clarify inventory based on global warehouses([Get Global Warehouse List API](https://partner.tiktokshop.com/docv2/page/650aa3f0defece02be6e5ffb?external_id=650aa3f0defece02be6e5ffb#Back%20To%20Top)).
When sellers want to publish a global product, they need to clarify inventory based on warehouses.([Get Warehouse List API](https://partner.tiktokshop.com/docv2/page/650aa418defece02be6e66b6))
#### Delivery Option
A delivery option is a logistic solution which assists sellers to handover goods to customers.
A delivery option includes a set of shipping providers and shipping services.
Seller needs to fulfill order under delivery option requirement,  including shipping providers, shipping services, dimension, weight, etc.
A delivery option is chosen by the buyer, when the buyer places an order on TikTok.   Examples of delivery options include "Express shipping" for Seller Shipping, "Economy Shipping" for TikTok Shipping, etc.  
Please note that Express Shipping for Seller Shipping, and Express Shipping for TikTok Shipping are in fact two different delivery options.
##### Shipping Type
Shipping type is how sellers can ship packages.  It's a property of delivery option.
TikTok supports multiple shipping types:

* Platform - Sellers connect with shipping providers through TikTok. 
* Seller - Sellers connect with shipping providers their own channels, then upload tracking numbers to TikTok for further tracking.

For different regions, TikTok provides different services for shipping , including purchasing labels, arranging shipments, etc.
#### Shipping Service( for US )
A shipping service is a specific logistic service which is provided by one provider.
Different delivery options have different available shipping services.
Examples of shipping services include  "USPS Ground", "DHL eCommerce SM parcel".
#### Shipping provider
Shipping providers are providers who provide shipping services. 
Different delivery options have different available shipping providers.
For orders which use "seller shipping" type delivery option, seller needs to update shipping provider and tracking number during fulfillment.
Examples of shipping providers include "USPS", "DHL eCommerce".
Important tips: "DHL" and "DHL eCommerce" are two providers.

The diagram below outlines the relationship between delivery option, shipping provider and shipping service.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/dcefc31a473646bca211ab30380158e2~tplv-k9wyc2ijk0-image.image)

### Frequently Asked Questions

* What is the relationship between a seller and a shop?

One seller can run businesses in multiple regions.
For each region, one seller can have one TikTok shop.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/46c96cf5ec98442894d42cf2814ecf94~tplv-k9wyc2ijk0-image.image)

* What is the relationship between a global warehouse and a warehouse?

When there is a global warehouse, for every region, there is a warehouse which actually refers to the global warehouse.

* What is the relationship between a warehouse and a deliveryOption?

One warehouse can subscribe multiple delivery options.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/5574a789943f4a55b9bec9904dad5324~tplv-k9wyc2ijk0-image.image)

* What is the difference between different delivery options?

There are several pieces of fulfillment info in an order's Order Detail:

* Delivery option id
* Fulfillment type: means goods will be shipped from TikTok warehouse or seller warehouse 
      * FULFILLMENT_BY_TIKTOK
      * FULFILLMENT_BY_SELLER
* Ship type:   means package will purchase label through TikTok or through seller's own channel.
      * TikTok
      * Seller

For fulfillment type - FULFILLMENT_BY_TIKTOK, TikTok will automatically process the order on behalf of the seller. The seller does not need to manage the fulfillment process. 
For fulfillment type - FULFILLMENT_BY_SELLER, sellers need to use Fulfillment API to process order.
For more detail of fulfillment flows, please refer to [Fulfillment API overview](https://partner.tiktokshop.com/docv2/page/650b2044f1fd3102b93c9178).


---

## Additional Notes

Doc: https://partner.tiktokshop.com/docv2/page/1cjht3qx · cập nhật 2026-09-16

##### **Reason Code**
| **Reason Code** | **英文含义** | **中文含义** | **常见回传场景** |
| --- | --- | --- | --- |
| **R104** | Failed to contact recipient | 无法联系收件人 | 电话无人接听、关机，或到达地址后无人响应 |
| **R148** | Exceptional reason | 其他异常原因 | 物流商原始原因无法映射到具体标准码时使用的异常兜底码 |
| **R400** | Recipient issues other | 收件人侧其他问题 | 收件人侧发生其他异常，但不属于拒收、联系不上、改期等明确原因 |
| **R103** | Error in address | 收件地址错误 | 门牌号缺失、街道错误、邮编与城市不匹配，导致无法派送 |
| **R106** | Recipient refused | 收件人拒收 | 收件人明确拒绝接收包裹，或表示未购买该商品 |
| **R110** | Bad weather conditions | 恶劣天气或不可抗力 | 暴雨、洪水、台风、道路封闭、区域管制等导致无法派送 |
| **R117** | Package damage | 包裹破损 | 外包装破裂、严重挤压、商品泄漏或运输中损坏 |
| **R116** | Package lost | 包裹丢失 | 分拣、转运或末端派送环节确认包裹遗失 |
| **R105** | Error in phone number | 收件人电话号码错误   | 电话号码位数错误、空号、区号错误或无法接通 |
| **R108** | Recipient request delivery change | 收件人要求变更派送 | 收件人要求改期、改地址或改送至代收点 |

##### Action code 
| Action code Name | Action code value | Must have | Tracking event / 运输阶段 |  |
| --- | --- | --- | --- | --- |
| pickup_start | 20201 | N | 揽收开始 — Pickup initiated |  |
| pickup_failure | 20301 | N | 揽收失败 — Pickup failed |  |
| pickup_intransit | 31501 | N | 揽收在途 — En route for pickup |  |
| pickup_success | 30901 | **Y** | 揽收成功 — Pickup successful |  |
| pickup_station_in | 39901 | N | 揽收站点入库 — Inbound at pickup facility |  |
| pickup_station_out | 3010001 | N | 揽收站点出库 — Departed pickup facility |  |
| trans_inbound | 31001 | N | 转运入库 — Inbound at transfer hub |  |
| trans_outbound | 31101 | N | 转运出库 — Departed transfer hub |  |
| sc_sign | 31201 | N | 分拨签收 — Received at sorting center (signed) |  |
| sc_inbound | 31301 | N | 分拨入库 — Inbound at sorting center |  |
| sc_operate | 32701 | N | 分拨操作 — Processing at sorting center |  |
| sc_outbound | 31401 | N | 分拨出库 — Departed sorting center |  |
| trans_operate | 32001 | N | 转运操作 — Processing at transfer hub |  |
| trans_exception | 32101 | N | 转运异常 — Transit exception |  |
| trans_sign | 32201 | N | 转运签收 — Received at transfer hub (signed) |  |
| trans_handover | 32301 | N | 转运交接 — Transfer handover |  |
| transport_departed | 32401 | N | 干线发车 — Line-haul departure |  |
| transport_intransit | 32501 | N | 干线在途 — Line-haul in transit |  |
| transport_arrived | 32601 | N | 干线到达 — Line-haul arrival |  |
| transport_assigned | 32801 | N | 运输分配 — Shipment routing assigned |  |
| station_inbound | 40101 | N | 末端站点入库 — Inbound at last-mile station |  |
| station_operate | 40301 | N | 末端站点操作 — Processing at last-mile station |  |
| station_out | 40201 | N | 末端站点出库 — Departed last-mile station |  |
| delivery_start | 40501 | **Y** | 开始派送 — Out for delivery |  |
| delivery_exception | 41401 | N | 派送异常 — Delivery exception |  |
| pop_arrived | 41501 | N | 自提点到达 — Arrived at pickup point |  |
| **signed_personally** | 50101   | **Y**   | 本人签收（平台终态） — Delivered — signed by recipient (platform final state) |  |
| sign_failure   | 60101 | If not pass signed_personally, should have sign failure or unreachable_returned | 签收失败（非终态节点） — Delivery attempt failed (non-final status) |  |
| **unreachable_returned** | 80101 | If not pass signed_personally, should have sign failure or unreachable_returned | 退回商家（平台终态） — Returned to merchant (platform final state) |  |
|  |  |  |  |  |


---

## Action_Code_Name

Doc: https://partner.tiktokshop.com/docv2/page/37tihrdq · cập nhật 2026-07-01

| **Action Code** | **Action Code Name** | **explaination** |
| --- | --- | --- |
| 30901 | pickup_success | Parcel is picked up by carrier or the carrier is in possession of item for the first time  |
| 31001 | trans_inbound | Local transfer inbouned. |
| 31101 | trans_outbound | Local transfer outbouned. |
| 31201 | sc_sign | Carrier facility has recieved the parcel or signed for it. First sort center arrival. Parcel is not in transit. |
| 31301 | sc_inbound | Carrier facility has recieved parcel but is not the first sort center arrival. Parcel is not in transit.  |
| 31401 | sc_outbound | Departed any carrier facility to the Destination carrier facility/ post office |
| 32001 | trans_operate | In-transit hub operations (e.g., consolidation, relabeling) |
| 32201 | trans_sign | Parcel has arrived shipping partner facility or another carrier's facility hub |
| 32301 | trans_handover | Handed Over to Delivery Partner  |
| 32401 | transport_departed | Parcel outbound flight/ truck departed |
| 32501 | transport_intransit | Parcel is between two carrier facilities - when Parcel is arriving on time or en route. |
| 32601 | transport_arrived | Parcel arrived at airport/ seaport  |
| 32701 | sc_operate | Parcel is processed at sorting center or a hub |
| 32801 | transport_assigned | Mainline Signed & Received |
| 36201 | drop_off_success | Seller send parcel to shop. |
| 39901 | pickup_station_in | Received and warehoused at pickup outlet, dispatched to the next facility |
| 40101 | station_inbound | Arriving at final carrier facility/ destination facility or post office.  |
| 40201 | station_out | Parcel left the final carrier facility/ destination facility and is ready to start delivery |
| 40301 | station_operate | Processing at destination/ final facility |
| 41301 | delivery_transfer | Delivery was forwarded to different carrier/ address. |
| 43101 | platform_wh_received | Undeliverable Parcels received back to warehouse |
| 43201 | pkg_wh_received | Undeliverable Parcels received back to warehouse |
| 3010001 | pickup_station_out | Outbound from pickup outlet, forwarded to the next station |
| 3013901 | sc_handover | Local Sorting Center handover |
| 40501 | delivery_start | Parcel on courier vehicle/ Out for delivery/ arriving today |
| 40601 | 1st_attempt_failed | Parcel was attempted to deliver but failed due to address block, address not found/ address moved/ no secure location, signature missing.  |
| 40801 | 2nd_attempt_failed | Parcel was attempted second time to deliver but failed due to address block, no secure location, signature missing.  |
| 41001 | delivery_twice | Redelivery scheduled and the first delivery failed - Notice/ exception |
| 41101 | delivery_thrice | Out for delivery 3rd time and the second delivery failed - Notice/ exception |
| 41201 | delivery_multiple | Multiple repeated delivery attempts |
| 41401 | delivery_exception | Parcel is out for delivery and there was delivery delay due to weather, or operational delay, and at least one more delivery attempt is remaining |
| 41501 | pop_arrived | Parcel available for pickup/ post office or Parcel is held for pick up |
| 41801 | 3rd_attempt_failed | Parcel was attempted to deliver but failed three times due to address block, address not found/ address moved/ no secure location, signature missing.  |
| 41901 | multiple_attempt_failed | Parcel was attempted to deliver but failed seven or more times due to address block, address not found/ address moved/ no secure location, signature missing.  |
| 42001 | delivery_schedule | Delivery scheduled by carrier or delivery date was updated |
| 60101 | sign_failure | Delivery failed due to no addressee/ incorrect address/ incomplete delivery instruction or carrier will not reattempt |
| 50101 | signed_personally | Successfully delivered |
| 59801 | pkg_received | Warehouse signed for receipt, dedicated UK platform reverse return warehouse |
| 110101 | pkg_cancelled | Parcel is cancelled by carrier or sender |
| 120101 | lo_cancelled | Shipment cancelled by the platform |
| 140101 | operate_delay | Overdue Parcel |
| 90101 | pkg_damaged | Parcel is damaged during transit or out for delivery |
| 100101 | pkg_lost | Parcel is lost during transit or out for delivery |
| 160101 | pkg_scrap | Parcel is disposed by carrier during transit or out for delivery |
| 70201 | unreachable_returning | After failed delvery, parcel is returning to original sender |
| 70301 | unreachable_return_failure | Parcel is undeliverable to original sender |
| 70401 | unreachable_return_exception | Return Exception |
| 70501 | unreachable_return_start | FD parcel starts to return to seller from the delivery station |
| 60201 | unreachable_returned_wh | FD package delivered to return warehouse. |
| 80101 | unreachable_returned | Parcel was undeliverable to receiver and was successfully returned to original sender.  |
| 10101 | pkg_created | Parcel created |
| 20101 | pkg_shipped | Parcel is ready to be shipped by the seller. |
| 20201 | pickup_start | Pickup resource arranged by service provider; courier en route for collection |
| 20301 | pickup_failure | Carrier failed to pickup Parcels before transit |
| 20801 | drop_off_intransit | On the way to drop off parcel to carrier facility |
| 20901 | ready_for_pickup | Parcel ready for pickup by carrier |
| 21001 | data_send_carrier | First carrier electronic signal where a tracking number is generated. Typically when shipping label is generated.  |
| 21101 | 2nd_pickup_failure | 2nd Pickup Attempt Failed |
| 21201 | 3rd_pickup_failure | 3rd Pickup Attempt Failed |
| 21301 | 4th_pickup_failure | 4th Pickup Attempt Failed |
| 21401 | pickup_schedule | Carrier's scheduled pick up from sender's facility |
| 21901 | manifest_scaned | Shipment received by carrier |
| 21402 | pickup_check_in | Driver arrived at the pickup location |
| 301002 | pickup_station_handover | Pickup location handover |


---

## Get Warehouse List — `GET /logistics/202309/warehouses`

Doc: https://partner.tiktokshop.com/docv2/page/get-warehouse-list-202309 · cập nhật 2026-10-28 · scope: seller.logistics

### Path: /logistics/202309/warehouses
### Method: [GET]
### Function Description
Retrieves warehouses associated with the seller, including names, effective statuses, types, default designations, and available address information.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/logistics/202309/warehouses?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^warehouses | []object |  | Warehouses returned for the seller. This field is omitted when the result contains no warehouse. |
| ^^id | string | 7000714532876273410 | The warehouse ID, a unique and immutable primary key, used for all warehouse logistics. |
| ^^entity_id | string | 7395366865142499073 | The warehouse entity ID, used to associate physical information of a warehouse, different warehouses may be associated with the same entity. |
| ^^name | string | Guangzhou | Warehouse name. This name is not unique across the TikTok Shop system. |
| ^^effect_status | string | ENABLED | Indicates whether inventory at the warehouse is available for sale. |
| Possible values: |  |  |  |

* `ENABLED`: All products in stock are available for sale.
* `DISABLED`: All products in stock are unavailable for sale.
* `RESTRICTED`: The warehouse is in holiday mode or order limit mode, so all products in stock are unavailable for sale.

The seller can enable holiday mode in Seller Center when the seller cannot fulfill orders from the warehouse. Order limit mode is applied when TikTok Shop limits the order volume that can be fulfilled by the warehouse because of policy violations. |
^^type |string |SALES_WAREHOUSE |Possible values:

* SALES_WAREHOUSE: Warehouse for shipping products.
* RETURN_WAREHOUSE: Warehouse for receiving returned products.
   You can have the same warehouse for both shipping and receiving returns, but they will have different warehouse IDs with the same address. |
   ^^sub_type |string |DOMESTIC_WAREHOUSE |Possible values:
* DOMESTIC_WAREHOUSE: The warehouse is in the same country as the target market and the seller.
* CB_OVERSEA_WAREHOUSE: For cross-border sellers, a local warehouse in the target market.
* CB_DIRECT_SHIPPING_WAREHOUSE: For cross-border sellers, a warehouse in the seller's base country, e.g., Mainland China or Hong Kong. |
   ^^is_default |bool |true |The default warehouse. If a product is listed with no designated warehouse, the default warehouse will be used. |
   ^^address |object | |Warehouse address. |
   ^^^region |string |China |The country or region of the warehouse address. |
   ^^^state |string |GuangDong |Warehouse state or province. |
   ^^^city |string |GuanZhou |Warehouse city. |
   ^^^distict |string |HuaDu |Warehouse district. |
   ^^^town |string |town |Warehouse town. |
   ^^^contact_person |string |Lee |Warehouse contact person name. |
   ^^^first_name |string |新一 |Kanji first name
   Applicable only for the JP market. |
   ^^^last_name |string |工藤 |Kanji last name
   Applicable only for the JP market. |
   ^^^first_name_local_script |string |しんいち |Hiragana or Katakana first name
   Applicable only for the JP market. |
   ^^^last_name_local_script |string |くどう |Hiragana or Katakana last name
   Applicable only for the JP market. |
   ^^^postal_code |string |510000 |Warehouse address postal code (also known as zip code) |
   ^^^full_address |string |South Sea 11 floor |The combined warehouse address, including the street address and other address information such as apartment number, building, floor..etc (optional) |
   ^^^region_code |string |CN |The country or region code of the warehouse address. |
   ^^^phone_number |string |188****2234 |Warehouse phone number. |
   ^^^address_line1 |string |Bairro/Distrito |The first line of the warehouse address, like street name and street number.
   Note:
* For Brazilian market, this represents the neighborhood or district.
* For the JP market, this represents the district (Chome), block (Banchi), building number (Go). |
   ^^^address_line2 |string |Caminho Trinta e Três |The second line of the warehouse address, like flat, apartment, or suit.
   Note: For the Brazilian market, this represents the street name. |
   ^^^address_line3 |string |3 |The street number. The literal value `s/n` indicates that no street number is available. Available only in the Brazilian market. |
   ^^^address_line4 |string |11 floor |This represents supplement information, like flat, apartment, or suit (optional).
   Note: Available only in the Brazilian market. |
   ^^^geolocation |object | |The geographical location of the address. |
   ^^^^latitude |string |45.41634 |The latitude of the address. |
   ^^^^longitude |string |-75.6868 |The longitude of the address. |

### Response Sample
```json
{"code":0,"data":{"warehouses":[{"id":"7000714532876273410","entity_id":"7395366865142499073","name":"Guangzhou","effect_status":"ENABLED","type":"SALES_WAREHOUSE","sub_type":"DOMESTIC_WAREHOUSE","is_default":true,"address":{"region":"China","state":"GuangDong","city":"GuanZhou","distict":"HuaDu","town":"town","contact_person":"Lee","first_name":"新一","last_name":"工藤","first_name_local_script":"しんいち","last_name_local_script":"くどう","postal_code":"510000","full_address":"South Sea 11 floor","region_code":"CN","phone_number":"188****2234","address_line1":"Bairro/Distrito","address_line2":"Caminho Trinta e Três","address_line3":"3","address_line4":"11 floor","geolocation":{"latitude":"45.41634","longitude":"-75.6868"}}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Global Seller Warehouses — `GET /logistics/202309/global_warehouses`

Doc: https://partner.tiktokshop.com/docv2/page/get-global-seller-warehouses-202309 · cập nhật 2026-10-10 · scope: seller.shop.info

### Path: /logistics/202309/global_warehouses
### Method: [GET]
### Function Description
This API retrieves global warehouses associated with the seller, including each warehouse's global warehouse ID, name, and ownership.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/logistics/202309/global_warehouses?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^global_warehouses | []object | [{"id":"7000714532876273411","name":"Guangzhou","ownership":"SELLER"}] | A list of global warehouses associated with the seller. |
| ^^id | string | 7000714532876273411 | Global warehouse ID, a unique and immutable primary key, used for all global warehouse logistics. |
| ^^name | string | Guangzhou | Global warehouse name. This name is not unique across the TikTok Shop system. |
| ^^ownership | string | SELLER | Possible values: |

* SELLER: Warehouse owned by the seller.
* PLATFORM_COOPERATION: Warehouse owned by TikTok Shop.
   |

### Response Sample
```json
{"code":0,"data":{"global_warehouses":[{"id":"7000714532876273411","name":"Guangzhou","ownership":"SELLER"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get Warehouse Delivery Options — `GET /logistics/202309/warehouses/{warehouse_id}/delivery_options`

Doc: https://partner.tiktokshop.com/docv2/page/get-warehouse-delivery-options-202309 · cập nhật 2026-10-28 · scope: seller.logistics

### Path: /logistics/202309/warehouses/{warehouse_id}/delivery_options
### Method: [GET]
### Function Description
This API is used to obtain a list of delivery options available through the seller's designated warehouse.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| warehouse_id | string | Y | 6966568648651605766 | The warehouse ID, represented as a decimal integer string. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| scope | string | N | PRODUCT | Specify which delivery options to retrieve. |

* `WAREHOUSE`: Returns the delivery options currently active for the warehouse. Orders use these options by default.
* `PRODUCT`: Returns delivery options that can be assigned directly to a product to override the default warehouse options. The response can contain `id`, `name`, `type`, `description`, and `platform`; this scope does not populate `dimension_limit` or `weight_limit`.
   Default: `WAREHOUSE` |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/logistics/202309/warehouses/6966568648651605766/delivery_options?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&scope=PRODUCT
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^delivery_options | []object |  | Delivery options available for the seller's warehouse or assignable to a product, depending on `scope`. Each option identifies its supported platforms. Options returned for `WAREHOUSE` may also include applicable weight and dimension limits. |
| ^^id | string | 6955034615128000261 | Delivery option ID. |
| ^^name | string | LSV-TTS-STD | Delivery option name. |
| ^^type | string | STANDARD | Delivery option type. |
| Possible values: |  |  |  |

* STANDARD
* EXPRESS
* ECONOMY
* SEND_BY_SELLER
* INSTANT
* SAMEDAY
* NEXTDAY
* CARGO |
   ^^description |string |LSV-TTS-STD S |Delivery option description. |
   ^^dimension_limit |object | |The length, width, and height restrictions of the delivery option. |
   ^^^max_height |int |100 |Maximum height limit. |
   ^^^max_length |int |100 |Maximum length limit. |
   ^^^max_width |int |100 |Maximum width limit. |
   ^^^unit |string |INCH |The unit of measurement for the dimensions, with possible values:
* CM
* INCH |
   ^^weight_limit |object | |The weight restrictions of this delivery option. |
   ^^^max_weight |int |100 |Maximum weight limit. |
   ^^^min_weight |int |100 |Minimum weight limit. |
   ^^^unit |string |GRAM |The unit of measurement for the weight.
   Possible values:
* GRAM
* POUND
* OUNCE
* KILOGRAM |
   ^^platform |[]string |["TOKOPEDIA","TIKTOK_SHOP"] |The platform on which the delivery option is available
   Possible values:
* TIKTOK_SHOP
* TOKOPEDIA |

### Response Sample
```json
{"code":0,"data":{"delivery_options":[{"id":"6955034615128000261","name":"LSV-TTS-STD","type":"STANDARD","description":"LSV-TTS-STD  S","dimension_limit":{"max_height":100,"max_length":100,"max_width":100,"unit":"INCH"},"weight_limit":{"max_weight":100,"min_weight":100,"unit":"GRAM"},"platform":["TOKOPEDIA","TIKTOK_SHOP"]}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Shipping Providers — `GET /logistics/202309/delivery_options/{delivery_option_id}/shipping_providers`

Doc: https://partner.tiktokshop.com/docv2/page/get-shipping-providers-202309 · cập nhật 2026-10-28 · scope: seller.fulfillment.basic, seller.logistics, seller.fs.order&fufillment.management

### Path: /logistics/202309/delivery_options/{delivery_option_id}/shipping_providers
### Method: [GET]
### Function Description
Returns the shipping providers available for the specified delivery option. If the delivery option is fulfilled by TikTok, the request returns an error and no shipping providers are returned.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| delivery_option_id | string | Y | 6955034615128000261 | The delivery option ID, represented as a decimal integer string. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| warehouse_region | string | N | ES | Warehouse country, indicating the shipping country. |
| buyer_region | string | N | DE | Buyer's country, indicating the destination country for delivery. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/logistics/202309/delivery_options/6955034615128000261/shipping_providers?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&warehouse_region=ES&buyer_region=DE
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^shipping_providers | []object |  | The shipping providers available for the specified delivery option. |
| ^^id | string | 7117858858072016686 | shipping provider id |
| ^^name | string | USPS | shipping provider name |
### Response Sample
```json
{"code":0,"data":{"shipping_providers":[{"id":"7117858858072016686","name":"USPS"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 21008116 | No Subscription without specified delivery option. |
| 21008117 | The delivery of the specified delivery_option_id is fulfilled by TikTok. No shipping provider will be returned. |


---

## Get Shipping Template Availability — `GET /logistics/202510/seller_templates`

Doc: https://partner.tiktokshop.com/docv2/page/get-shipping-template-availability-202510 · cập nhật 2026-10-10 · scope: seller.logistics

### Path: /logistics/202510/seller_templates
### Method: [GET]
### Function Description
get seller's available shipping template and return the reason why the template is not available，this api is now only available for JP and UK market

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| product_attribute | object | N |  | The product's dimensions and weight to use when evaluating shipping template availability. |
| ^weight | object | N |  | The weight of product |
| ^^weight | string | N | 10 | The weight of product |
| ^^unit | int | N | 1 | 1:gram |
| 2:pound |  |  |  |  |
| 3:ounce |  |  |  |  |
| 4:kilogram |  |  |  |  |
| ^dimension | object | N |  | The dimension of the product |
| ^^length | string | N | 10 | The length of the product |
| ^^width | string | N | 10 | The width of the product |
| ^^height | string | N | 10 | The height of the product |
| ^^unit | int | N | 1 | 1: centimeter |
| 2:inch |  |  |  |  |
| 3:foot |  |  |  |  |
| 4:millimeter |  |  |  |  |
| 5:meter |  |  |  |  |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/logistics/202510/seller_templates?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^templates | []object |  | Shipping templates evaluated for availability for the seller's shop. |
| ^^template_is_available | bool | false | Whether the template is available |
| ^^template | object |  | Shipping template details, including the template ID, name, fulfillment party, and whether it is the default template. |
| ^^^template_name | string | test template | The template name |
| ^^^template_id | string | 1234566 | The template_id |
| ^^^is_default | bool | false | Is default template or not |
| ^^^template_party | int | 1 | 1 for shipping by platform template |
| 2 for shipping by seller template |  |  |  |
| ^^service_unreachable_reason | []object |  | Reasons the shipping template is unavailable, grouped by shipping service. This field is omitted when the template is available. |
| ^^^service_id | string | 23241 | Id of the service |
| ^^^filter_reason | []object |  | Reasons this shipping service is unavailable for the template. |
| ^^^^filter_type | string | 9 | 1 for length filter |
| 2 for width filter |  |  |  |
| 3 for height filter |  |  |  |
| 4 for weight filter |  |  |  |
| 9 for service mode filter |  |  |  |
| 11 for service filter |  |  |  |
| ^^^^reason | string | Ship by seller is banned | Detailed reason for unreachable |
|  |  |  |  |
### Response Sample
```json
{"code":0,"data":{"templates":[{"template_is_available":false,"template":{"template_name":"test template","template_id":"1234566","is_default":false,"template_party":1},"service_unreachable_reason":[{"service_id":"23241","filter_reason":[{"filter_type":"9","reason":"Ship by seller is banned"}]}]}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get Logistics Tracking — `GET /logistics/202604/orders/{order_id}/tracking`

Doc: https://partner.tiktokshop.com/docv2/page/get-logistics-tracking-202604 · cập nhật 2026-10-10 · scope: seller.logistics

### Path: /logistics/202604/orders/{order_id}/tracking
### Method: [GET]
### Function Description
Use this API to retrieve detailed logistics tracking information for an order. This API currently supports only cross-border trade (CBT) orders. Compared with Get Tracking, this API groups information by parcel and can include each parcel's carrier, latest tracking number, and tracking-event history.
For the mapping between `action_code` and `action_code_name`, see https://partner.tiktokshop.com/docv2/page/37tihrdq.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_id | string | Y | 576461413038785752 | TikTok Shop order ID. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/logistics/202604/orders/576461413038785752/tracking?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^order_id | string | 577071607420326620 | TikTok Shop order ID. |
| ^logistics_details | []object |  | A list of parcels in the order. Each item describes one parcel and can include its carrier, latest tracking number, and tracking-event history. |
| ^^newest_tracking_no | string | 861651122474 | The latest logistics tracking number for this parcel. |
| ^^carrier_name | string | J&T Express | The carrier name. |
| ^^track_list | []object |  | A list of logistics tracking events for this parcel. |
| ^^^description | string | Package has been delivered!\n | Description of this tracking event. |
| ^^^tracking_no | string | 861651122474 | The logistics tracking number associated with this tracking event. |
| ^^^update_time_millis | int | 1694686949000 | Unix timestamp in milliseconds (GMT/UTC+00:00) when this tracking event was updated. |
| ^^^action_code | int | 50101 | Action code of this tracking event. It is an enumerated status value; the full enumeration list is maintained by the business side. |
| Refer: action_code/action_code_name mapping details https://partner.tiktokshop.com/docv2/page/37tihrdq |  |  |  |
| ^^^action_code_name | string | signed_personally | Machine-readable status name corresponding to `action_code`. For action code and name mapping details, see https://partner.tiktokshop.com/docv2/page/37tihrdq. |
### Response Sample
```json
{"code":0,"data":{"order_id":"577071607420326620","logistics_details":[{"newest_tracking_no":"861651122474","carrier_name":"J\u0026T Express","track_list":[{"description":"Package has been delivered!\\n","tracking_no":"861651122474","update_time_millis":1694686949000,"action_code":50101,"action_code_name":"signed_personally"}]}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 11007009 | This order is not in supported business scenes |
| 11007010 | System is busy, please try again later. |


---

## Check Shipping Template Existence — `GET /logistics/202606/seller_template/template_exist`

Doc: https://partner.tiktokshop.com/docv2/page/check-shipping-template-existence-202606 · cập nhật 2026-10-10 · scope: seller.logistics

### Path: /logistics/202606/seller_template/template_exist
### Method: [GET]
### Function Description
Checks whether the authenticated shop has a shipping template for the specified business warehouse.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| access_token | string | Y | ROW_lueRwg4DEVhW7y9az74MgYA8y24seCBcjItc6CY8PGpsdgKZ4aOMGHKejG566H2mPj-jemiTXWkkZdnM5eTo11xqCRIZFihUe6VhBKKYzYsdjZDxg46ER8EffWnbeLBEjUUatmM4zpBIzyy_MPmJOdQh-Z54DX-A | Authorization Token, provided for all eligible TikTok Shop Partner Developers. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| shop_id | int | N | 123 | Shop id |
| biz_warehouse_id | int | Y | 456 | Biz warehouse id |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/logistics/202606/seller_template/template_exist?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&shop_id=123&biz_warehouse_id=456
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^template_exist | bool | false | if template exists, return true |
### Response Sample
```json
{"code":0,"data":{"template_exist":false},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |

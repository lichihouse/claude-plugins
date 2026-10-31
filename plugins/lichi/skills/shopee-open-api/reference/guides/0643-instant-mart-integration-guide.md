# Instant Mart Integration Guide

> Nhóm: API Guidelines and Flows · nguồn: https://open.shopee.com/developer-guide/643

This document introduces the **process for product listing, order management, income reporting, and OpenAPI integration/testing flow** on **Instant Mart**.

# Instruction of the Instant Mart Project

# Background:

Instant Mart is a special shop structure designed to support retailers who operate both central management and branch-level operations. Under this model:

- Each **Mart Shop (Official Shop)** acts as the headquarters, responsible for managing global SKUs, creating items, and viewing financial reports.  
    
   
- Multiple **Outlets (Branch Shops)** exist under the mart, representing individual shop locations. Outlets are responsible for handling day-to-day operations, such as managing orders, maintaining stock, and packing parcels for riders to pick up.  
    
   

With the Open API integration, Mart retailers can choose whether to manage SKUs at the **merchant level** (shared across all outlets) or at the **outlet level** (independent per branch).

Before integrating with Open API, retailers must onboard both the mart merchant and its outlet shops in the **BDC portal**, ensuring they are registered as **Instant Mart Shops**. This setup allows developers to build API solutions that support the full operational flow of Instant Mart retailers.

# 1. Sandbox Test Account Setup

## 1.1 Create Sandbox Test Account

 

You can start by accessing the [*Test Account*](https://open.shopee.com/myconsole/tools/test-account) page on Shopee Open Platform Console \>Select Mart&Outlet shops module to create test shops.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=4TzCsTwtDQ7%2BbrHmBiv2wO74k7zl3ocgiObjIuqYeHHm6DP%2BF%2BY1BFilYTGbZ5kJyJk0ZnIJaPE2ymmpoKgxxQ%3D%3D&image_type=png)

*Note: Except for BR, all other regions can create Mart and Outlet Shop.*

 

 

# 2. Grant authorization 

## 2.1 Shop Authorization

Find the test Partner_id on the App List page:

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=yEKxhEtVO5NjTjcEj0vZW5ft8AW0c2LH%2Ff8lhCtV2kWT8MDAdMQjo6rDYXHYfE%2FCp2FNqzobx8b428sxRKCymA%3D%3D&image_type=png)

Click **Authorize** → log in with Mart account to complete authorization for Mart and Outlet shop at the same time.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=%2F%2B3zcfqIRFEFtd%2FlWpYcj6N2hOfAkrxSbh2AzkqAhrvRlxlEhxot8OoMyjrzJyp1B6Ht3jk%2FzshoXEXDU1A%2FBQ%3D%3D&image_type=png)

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=U9N3Nqqn2Gq5NgqFeD54EbO9I%2B1ek9mYRf2wfGDDKhCnUAJjcPKaikkbSHf1FUm3iFEWMp4C%2BD23puxgY9%2BOjg%3D%3D&image_type=png)

Refer to the [*Authorization and authentication*](https://open.shopee.com/developer-guide/20) article for more information.

# 3. Testing Process

## 3.1 Open API Testing

Use the API Test Tool or use Postman to test open API.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=6z6B8dxwUHyrzbPC2KsRwYC8uH7I%2BE%2BoJ6hHhGIZYhMwcGdEscf3JfzpnzMLwvRQxAqw7a8QI0%2FSmOfLL2yNrA%3D%3D&image_type=png)

 

 

 

 

 

 

## 3.2 Key Open API Functions

 

**Key API functionalities required for ID Mart Project:**

[TABLE]

### 3.2.1 Mart&Outlet shop relationship

**Check relationship**: v2.shop.get_shop_info  
With **mart_shop_id** → returns all outlet shop IDs under the Mart.  
  With **outlet_shop_id** → returns the corresponding Mart shop ID.

3.2.1.1 Use v2.shop.get_shop_info with a Mart Shop

 

When using mart_shop_id to call v2.shop.get_shop_info, it will return mart_outlet_structure_type and a list of all Outlet shop IDs under that Mart.

Note: mart_outlet_structure_type = warehouse_mart_shop type is currently only available in ID, and the mart_outlet_structure_type for other markets is normal_mart_shop.

 

Response example:

{

    "error": "",

    "message": "",

    "request_id": "8c29db42a123456789",

    "response": {

        "shop_id": 1234567890,

        "is_mart_shop": true,

        "is_outlet_shop": false,

        "mart_shop_id": 1234567890,

        "mart_outlet_structure_type": "warehouse_mart_shop"

        "outlet_shop_info_list": \[

            {

                "outlet_shop_id": 225506317,

            },

            {

                "outlet_shop_id": 225439688,

            .....}

        \]

    }

}

 

3.2.1.2 Use v2.shop.get_shop_info with a Outlet Shop

 

When calling v2.shop.get_shop_info with outlet_shop_id, the corresponding Mart shop ID and mart_outlet_structure_type will be returned. In this scenario, outlet_shop_info_list will not be returned.

 

Response sample:

{{

    "error": "",

    "message": "",

    "request_id": "9d30ec53b987654321",

    "response": {

        ....

        "is_mart_shop": false,

        "is_outlet_shop": true,

        "mart_shop_id": 1234567890,

  "mart_outlet_structure_type":"normal_outlet_shop"

     }

}

 

### **3.2.2 Product** **Management**

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=fBmZsM7SsehtYieQ5xO6XkNZcVPvGWTiCnvysTgeRmsz9tNnfh5%2FnpetQRG4S7HMCPcczjn%2FKeR92pQ88%2BEFjA%3D%3D&image_type=png)

**Fields distinguish between Mart SKU vs Outlet SKU**

 

Instant Mart has two structures: Normal Instant Mart and Warehouse Instant Mart.

 

Judgment criteria: When calling v2.shop.get_shop_info, mart_outlet_structure_type will return the corresponding value, such as: normal_mart_shop / warehouse_mart_shop / warehouse_outlet_shop / normal_outlet_shop.

 

**1. Standard Instant Mart**

|                   |                      |                         |                           |
|-------------------|----------------------|-------------------------|---------------------------|
| **Module**        | **Field**            | **MART SKU Management** | **Outlet SKU Management** |
| Basic information | title                | Yes                     | No                        |
|                   | video                | Yes                     | No                        |
|                   | image                | Yes                     | No                        |
|                   | status               | Yes                     | Yes                       |
|                   | category             | Yes                     | No                        |
| Specification     | brand                | Yes                     | No                        |
|                   | attribute            | Yes                     | No                        |
|                   | size chart           | Yes                     | No                        |
| Specification     | variation name       | Yes                     | No                        |
|                   | variation option     | Yes                     | No                        |
|                   | variation image      | Yes                     | No                        |
|                   | price                | No                      | Yes                       |
|                   | purchase limit       | No                      | Yes                       |
|                   | wholesales           | No                      | Yes                       |
|                   | stock                | No                      | Yes                       |
|                   | model status         | Yes                     | Yes                       |
|                   | module seller SKU    | Yes                     | No                        |
|                   | weight               | Yes                     | No                        |
|                   | dimension            | Yes                     | No                        |
| Shipping          | logistics channel    | No                      | Yes                       |
|                   | installation channel | No                      | Yes                       |
| Others            | DTS                  | No                      | Yes                       |
|                   | seller SKU           | Yes                     | No                        |
|                   | condition            | Yes                     | No                        |

 

**2. Warehouse-type Instant Mart****（For ID only now）**

|                   |                      |                         |                                      |                                     |
|-------------------|----------------------|-------------------------|--------------------------------------|-------------------------------------|
| **Module**        | **Field**            | **MART SKU Management** | **Normal** **Outlet SKU Management** | **Warehouse Outlet SKU Management** |
| Basic information | title                | Yes                     | No                                   | No                                  |
|                   | video                | Yes                     | No                                   | No                                  |
|                   | image                | Yes                     | No                                   | No                                  |
|                   | status               | Yes                     | Yes                                  | Yes                                 |
|                   | category             | Yes                     | No                                   | No                                  |
| Specification     | brand                | Yes                     | No                                   | No                                  |
|                   | attribute            | Yes                     | No                                   | No                                  |
|                   | size chart           | Yes                     | No                                   | No                                  |
| Specification     | variation name       | Yes                     | No                                   | No                                  |
|                   | variation option     | Yes                     | No                                   | No                                  |
|                   | variation image      | Yes                     | No                                   | No                                  |
|                   | price                | Yes                     | Yes                                  | Yes                                 |
|                   | purchase limit       | Yes                     | Yes                                  | Yes                                 |
|                   | wholesales           | Yes                     | Yes                                  | Yes                                 |
|                   | stock                | Yes                     | Yes                                  | **No, sync Mart shop**              |
|                   | model status         | Yes                     | Yes                                  | Yes                                 |
|                   | module seller SKU    | Yes                     | No                                   | No                                  |
|                   | weight               | Yes                     | No                                   | No                                  |
|                   | dimension            | Yes                     | No                                   | No                                  |
| Shipping          | logistics channel    | Yes                     | Yes                                  | Yes                                 |
|                   | installation channel | Yes                     | Yes                                  | Yes                                 |
| Others            | DTS                  | Yes                     | Yes                                  | Yes                                 |
|                   | seller SKU           | Yes                     | No                                   | No                                  |
|                   | condition            | Yes                     | No                                   | No                                  |

**Note: If a warehouse_outlet_shop calls to update the stock, it will respond with an error "product.cnsc_shop_block" with the message":"Cannot update seller stock in Shop SKU for CBSC shop. Please update this field in the Global SKU instead."**

 

**Key operations include:**  
1.Add Mart SKU → v2.product.add_item  
2.Update SKU stock/price → v2.product.update_stock, v2.product.update_price (only at outlet level)  
3.Publish Outlet SKU → v2.product.publish_item_to_outlet_shop  
4.Sync Mart SKU to Outlet SKU → v2.product.update_item  
 

 

3.2.2.1 Add Mart SKU

 

Add mart SKU by calling v2.product.add_item using mart shop_id. 

 

**Refer to the** [***Creating Product***](https://open.shopee.com/developer-guide/211) **article for more information.**

 

**Calling sample:**

{

       "original_price": 123.3,

       "description": "rachel add item from openapi 002",

       "weight": 1.1,

       "item_name": "rachel add item from openapi item 001",

       "item_status": "NORMAL",

       "dimension": {

               "package_height": 2,

               "package_length": 3,

               "package_width": 4

       },

       "category_id": 400091,

       "logistic_info": \[{

               "size_id": 0,

               "shipping_fee": 2.5,

               "enabled": true,

               "logistic_id": 80018,

               "is_free": false

       },

       {

               "size_id": 0,

               "shipping_fee": 2.5,

               "enabled": true,

               "logistic_id": 81014,

               "is_free": false

       }\],

       "image": {

               "image_id_list": \["c54265d475b85e00ffb2404585e32b6f", "6fb33d484f232510b5f9b169f2758322", "591ab15ea954b9879374765854595600", "00a2258551b5a2f0a7c283f877330f93", "abf02b19b42e4aa964ef0725491ca9e3", "730f45972377cd4eb9813c6e53e60e9a"\]

       },

       "pre_order": {

               "is_pre_order": false,

               "days_to_ship": 2

       },

       "item_sku": "item sku 001",

       "condition": "NEW",

       "brand": {

               "brand_id": 0,

               "original_brand_name": "no brand"

       },

       "item_dangerous": 0,

       "description_info": {

               "extended_description": {

                       "field_list": \[{

                               "field_type": "text",

                               "text": "rachel add item from openapi 001",

                               "image_info": {

                                       "image_id": "-"

                               }

                       },

                       {

                               "field_type": "image",

                               "text": "-",

                               "image_info": {

                                       "image_id": "c54265d475b85e00ffb2404585e32b6f"

                               }

                       }\]

               }

       },

       "description_type": "extended",

       "seller_stock": \[{

               "location_id": "IDZ",

               "stock": 555

       }\]

}

3.2.2.2 Update Mart SKU Stock/Price

Update Mart SKU stock and price by calling v2.product.update_stock or v2.product.update_price. 

**Refer to the** [***Stock & Price Management***](https://open.shopee.com/developer-guide/223) **article for more information.**

*Note: Stock and price can only be managed at the outlet shop level. You must provide the shop_id of the outlet shop when calling the API to update stock or price.*

3.2.2.3 Publish Outlet SKU

 

Call v2.product.publish_item_to_outlet_shop to publish outlet SKU.

 

**Calling sample:**

{

   "mart_item_id": 1234,

   "outlet_shop_id": 2345,

   "publish_item": {

       "model": \[

           {

               "relate_mart_model_id": 1234,

               "original_price": 123,

               "seller_stock": \[

                   {

                       "location_id": "IDZ",

                       "stock": 100

                   }

               \],

               "pre_order": {

                   "is_pre_order": false,

                   "days_to_ship": 3

               }

           }

       \],

       "logistic_info": \[

           {

               "logistic_id": 12345,

               "enabled": true,

               "shipping_fee": 3.45,

               "size_id": 0,

               "is_free": false

           }

       \]

   }

}

 

call  v2.product.get_item_base_info to check if outlet item info sync  correctly. 

 

**Refer to the** [***Product base info management***](https://open.shopee.com/developer-guide/221) **article to check the item information.**

3.2.2.4 Get the Item Mapping Info

 

When the mart SKU has a published outlet SKU, call v2.get_mart_item_mapping_by_id to get the item mapping info. 

 

**Calling sample:**

 

{

   "mart_item_id": 844087076,

   "outlet_shop_id_list": \[

       225034791

   \]

}

3.2.2.5 Sync Mart SKU to Outlet SKU

 

**Sync the mart sku field to the outlet sku.**

 

1.Call v2.product.update_item to update the mart item field.

 

2.Call v2.product.get_item_base_info/enter outlet shop seller center  to check that the outlet item info syncs correctly.

 

*Note:Only fields managed by mart sku can be sync to outlet sku.*

### 3.2.3 Instant Channel Mapping and Configuration Rules in Indonesia (ID)

3.2.3.1 Channel Structure Overview

 

[TABLE]

*\*Developers should understand that sellers are whitelisted separately for these channels.*

 

3.2.3.2  ID Instant Channel Toggle Constraints

***Instant 2-hours (8008) and Instant 4-hours (8007) should always be toggled on/off together.***

 

[TABLE]

 

### 3.2.4 Instant Channel Mapping in Thailand (TH)

3.2.4.1 Channel Structure Overview

 

|                  |                                                    |
|------------------|----------------------------------------------------|
| **Mask Channel** | **Logistics Channel**                              |
| 0                | 70124-Instant Delivery - ส่งทันที (แพ็ก 30 นาที)        |
| 0                | 70125-Instant Delivery - ส่งทันที (แพ็ก 10 นาทีจากสาขา) |

### 3.2.5 Instant Channel Mapping in Vietnam (VN)

3.2.5.1 Channel Structure Overview

 

|                  |                                       |
|------------------|---------------------------------------|
| **Mask Channel** | **Logistics Channel**                 |
| 5115             | 50040-SPX Instant - Hỏa Tốc - Ưu Tiên |

### 3.2.6 Instant Channel Mapping in the Philippines (PH)

3.2.6.1 Channel Structure Overview

|                  |                                 |
|------------------|---------------------------------|
| **Mask Channel** | **Logistics Channel**           |
| 0                | 40079-Instant Delivery          |
| 0                | 40080-Instant Delivery Priority |

### 3.2.7 Instant Channel Mapping in Malaysia (MY)

3.2.7.1 Channel Structure Overview

|                  |                                                   |
|------------------|---------------------------------------------------|
| **Mask Channel** | **Logistics Channel**                             |
| 0                | 24000 - Instant Delivery (Arrange in 30 mins)     |
| 0                | 24100 - Instant Priority 1hr (Arrange in 30 mins) |

### 3.2.8 Order Management

To create a test order, go to the [*Test Order*](https://open.shopee.com/console/tools/test-order) page on the Shopee Open Platform Console and select *Create Test Order*.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=K34RFeggDVp1VnSay1ytBxh8tZbcigs%2F4nRMZ2wTVqn%2BzBCtBjya4JYU4bfCXN4m11yj4BS%2FFDpb4n%2BDjrBbng%3D%3D&image_type=png)

 

Choose the shop, items, and shipping option, then click *Create* to generate the order. 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=rbuiBvf07YCjiFiuQQrgjyZrXU1UA6jUurSUQWL4CLDmPIFs9%2B7wqxOFWU6VfRTlnIoELegnSDWyrDJXhOynKw%3D%3D&image_type=png)

 

The order information includes Order SN, Item ID, Status, Update Time, and Shop ID. You can also pick up, deliver, or delete the order from this page.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=6I260nsaQWNLCtX1thRKAUX1goP%2BuCiKGZCwoOvfk11vsagH3%2B3m8o7AaesM5ZIm8Lsekst4wgJ466%2BZT36R2w%3D%3D&image_type=png)

 

**Refer to the** [***Order Management***](https://open.shopee.cn/developer-guide/229) **article for more information about following steps.**

### 3.2.9 Return & Refund Management

 

**Refer to the** [***Return Refund Management***](https://open.shopee.com/developer-guide/227) **article for more information.**

### 3.2.10 Finance: Get Income and wallet transactions

You can generate and retrieve the income statement, income report, or wallet transactions by calling the APIs with a Mart shop_id. When using a Mart shop_id, the response will return an aggregated document that includes all outlet shops under the Mart shop.

 

|                           |                                        |                                                                                                    |
|---------------------------|----------------------------------------|----------------------------------------------------------------------------------------------------|
| **Function**              | **Open API**                           | **Remark**                                                                                         |
| generate income report    | v2.payment.generate_income_report      | Request Parameter: release_time_from and release_time_to.                                          |
| get income report         | v2.payment.get_income_report           | To query income report status and provide file link by passing income_report_id.                   |
| generate income statement | v2.payment.generate_income_statement   | Request Parameter:statement_type=1 means weakly statement;statement_type=2 means monthly statement |
| get income statement      | v2.payment.get_income_statement        | To query income statement status and provide a file link by passing income_statement_id            |
| get wallet transaction    | v2.payment.get_wallet_transaction_list | Get the transaction records of the wallet.                                                         |

### 3.2.11 Shop Setting

1.You can update the shop name, logo, and description by calling v2.shop.update_profile.  
2.You can update the operating hours by calling v2.logistics.update_operating_hours.  
*          **Note:***

- *The values provided must comply with the restrictions retrieved from **v2.logistics.get_operating_hour_restrictions**.*  
    
   
- *This API performs overwriting updates. When updating pickup operating hours, you must include all segments, even those that remain unchanged.*

 

# 4. Push Mechanism

The push mechanism is a dictionary of system notifications from Shopee, covering product, order, return, marketing, stability, and general marketplace updates.

For Instant Mart, it is recommended to connect to [ ***order_status_push***](https://open.shopee.com/push-mechanism/1). For more details, please refer to the *order_status_push* article.

 

# 5. FAQ & Raise for Help

For common questions, please refer to the [*FAQs*](https://open.shopee.com/faq?categoryId=2010).

 

If you encounter any issues related to **Instant Mart APIs** (e.g. onboarding, logistics channel configuration, order sync, etc.), please raise a ticket to the Shopee Product Support team \[[here](https://open.shopee.com/console/raise-ticket)\].

When submitting the ticket, kindly select: **L1 Question Category → Instant Mart**

 

Selecting the correct category helps us identify and prioritize your request more efficiently.

 

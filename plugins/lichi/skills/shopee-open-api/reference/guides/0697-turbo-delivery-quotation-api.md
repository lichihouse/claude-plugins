# Turbo Delivery (Quotation API)

> Nhóm: API Guidelines and Flows / BRAZIL | Specific Local Guides · nguồn: https://open.shopee.com/developer-guide/697

# **What is the Turbo Delivery Channel?**

 

 

This channel allows the seller to use their own logistics for quoting and shipping instant orders, with delivery in up to 4 hours.

- The shipping quote is based on the quote URL provided by the seller.
- The shipping price and delivery time are provided by the seller.
- Order tracking is simplified: the seller is responsible for sending events such as “shipped” (pickup_done) and “delivery failed” (delivery_failed) through the OpenAPI.

## Shipping Quote URL 

This tool allows sellers to send Shopee the estimated shipping costs and delivery times that will be used during the purchase. To use this functionality, sellers must meet the pre-established approval requirements.

*The seller can integrate directly with Shopee to connect the quote URL or connect through an Integrator-HUB.*

## **Approval / Integration Requirements**  

Unlike other integration types, the quotation API and order status update API integration for the Turbo Delivery channel requires review by the Shopee team before it can go live. To obtain Shopee team approval, you must meet the following requirements:

 

- Freight Quote API contract compliance:
  - Configure and make the URL available through the HTTP POST method.
  - Each request must contain only one item from a single seller.
  - The URL has no specific structure, allowing flexibility in configuration.
- Use the standard quotation request and response payload (and validate it with the Shopee URL).
- Response time limit of 500ms to 1s.
- Contingency table registered directly through Seller Center.
- Error monitoring and development of the requested messages.
- Development of the status update API (update_tracking_status).
  - Note 1:The requirements above must be met by the seller's "own system" or by their ERP/HUB. Otherwise, orders will be canceled, since this flow cannot be performed manually through Seller Center.
  - Note 2: The Turbo Delivery APP is used only for quotation URLs. To use any API, it is necessary to create a separate APP.

 

- Send a confirmation email and obtain approval from the Shopee team through a ticket covering the criteria above.

 

To perform the integration and tests above, the following are also required:

a\) Create a new Seller Logistics APP on the Open Platform and authorize sellers to use this APP.

b\) Have an APP capable of calling OpenAPI to update the status, and authorize sellers to use this APP.  
 

**After completing all the steps above, at least 2 test orders must be created: one order must be processed until it reaches the "Delivered" status, and another must be processed until it reaches the "Canceled" status. This is required for the HUB to be approved for the channel.**

# Create a Seller Logistics APP and Authorize Sellers

Once your Open Platform account is already active, the next step is to create an APP that will be used only to connect the quotation URL to the respective sellers (shop_id).

Follow the steps below:

 

1. Log in to Open Platform and access the "Console" tab.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=UcSx13FvbVwDS5K9BXUAcRufx5bTiHWJ8Pmc40zVO9Z7JXT2NMuXfyfNbLbPorHrCVEaCRJpFNWdrM014XMkAw%3D%3D&image_type=png)

2. In "App List", click "+ Add new APP".

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=dHmI43yblwMpKYXEeAX5%2BGRYfGXcI9IZsT2cdD0WmtC%2Bsx1zDfLdzD9MGoBlaM5SpH8%2F7FvTlvVLDm1PePAoFw%3D%3D&image_type=png)

3\. Select "Seller Logistics" as the "App Category".

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=tWXNkeKrYN6wXjTNmFkV7Pl0Aojh8W6ig5WAsoHMaRNozwZaAqm7KWH8WoGv95ofpj90U2I5leUV0CRuDceiBg%3D%3D&image_type=png)

4\. In "App Description", enter the URLs that will be used in Live (production) and Test (test environment), and click "Submit".

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=vF%2B1tgwVEuwC0FlR5vR9T0xvxnbdo5YOSZ1N%2FtXsFzJwnMgpj6EfdopFX6T%2Fnu9I8pxcpDssmEg%2BmyIzhVCCsQ%3D%3D&image_type=png)

There is no problem if you only have one URL.

 

5\. The APP will then be created. Proceed with the "Go-Live" request, which will make the APP available in the Live environment.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=kiUUIWZ21U17PE8UgEw38nQeX38wtTnoGQIcjnbdNKihXfWIappwZUE%2BCVRIHIxe3ra4S5jiO5qPvd9fKVPsQw%3D%3D&image_type=png)

6\. You only need to fill in a few additional pieces of information.

If it is not possible to provide a username and password, you may fill in the fields as shown in the screenshot below.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=I%2F4TKDvC7ehf4Rh0OTtPlkT9G7Q2s5o38KCmvQHKORkzKqRwZvZCwg3MhXi2AuKLcmjf0XOFLHldXD8XOEqhIQ%3D%3D&image_type=png)

7\. For "App IP", enter the main IP address of your application.  
Please note that access will not be restricted only to this IP.

For "Other IT Assets Declaration", fill it in as shown in the screenshot below.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=qw4s5hl0zWhMfGBNvFlnJQVwCF6k2gX7FqNOV2H%2Fhm9jKqe%2FFyQKgbOk5VjKFu9PjjzWozIcFi1yGWffh%2FaEag%3D%3D&image_type=png)

Within 24 hours after the "Go-Live" request, the Live partner_id will be released and you will be notified by email.

Once you receive it:

1 - Open a ticket on the [OP Ticket Platform](https://open.shopee.com/myconsole/ticket-system/raise-ticket/) with the subject **"Seller Logistics"**, informing the shop_id or Shop IDs that should be connected. Once we receive the request and the Shopee team completes the URL connection, you will be able to proceed with the seller authorization.

**Note:** Each shop_id can only be connected to one URL on Shopee.

2 - Complete the authorization flow for your seller according to the [step-by-step instructions in the corresponding documentation](https://open.shopee.com/developer-guide/20) (up to topic 4 of the seller authorization section).

3 - Once the Shopee team replies to your ticket confirming that the configuration has been completed, and your seller has completed the authorization flow, you can start the first tests in **LIVE**.

#  Quotation API Request and Response Flow

  
Shopee will call the Quotation API in **2 scenarios**, which have different request and response parameters:

1.  Quotation API Request and Response - **Search Page / Item Cart**
2.  Quotation API Request and Response - **PDP and Checkout**  
      
     

# Quotation API Request and Response - Search Page

 

**Request parameters (body)**

| Name    | Type | Mandatory | Example   | Description                        |
|---------|------|-----------|-----------|------------------------------------|
| shop_id | int  | True      | 112345678 | Unique identifier for each seller. |

**Response parameters (body)**

| Name                  | Type | Mandatory | Example   | Description                                                                                                                    |
|-----------------------|------|-----------|-----------|--------------------------------------------------------------------------------------------------------------------------------|
| shop_id               | int  | True      | 112345678 | Unique identifier for each seller.                                                                                             |
| fallback_promise_time | int  | True      | 30        | Average order preparation and shipping time in minutes, used to display the shipping time to the buyer or as a fallback value. |

# Quotation API Request and Response - PDP and Checkout  

**Request parameters (Query)**

|     | Example            | HTTP Address                      |
|-----|--------------------|-----------------------------------|
| URL | https://api.frete/ | URL provided by the ERP or seller |

 

| Name       | Type      | Example                                                          | Description                                                          |
|------------|-----------|------------------------------------------------------------------|----------------------------------------------------------------------|
| partner_id | int       | 1                                                                | The partner ID assigned after registration and used in requests.     |
| timestamp  | timestamp | 1610000000                                                       | Indicates the request timestamp. Requests expire after 5 minutes.    |
| sign       | string    | e318d3e932719916a9f9ebb57e2011961bd47abfa54a36e040d050d8931596e2 | Signature generated from the base string and partner_key using HMAC. |

**Request Parameters (Body)**  
 

| Parameter Name       | Type   | Mandatory | Example            | Description                                            |
|----------------------|--------|-----------|--------------------|--------------------------------------------------------|
| channel_id           | int    | True      | 90026              | Unique identifier of the logistics channel on Shopee.  |
| shop_id              | int    | True      | 112345678          | Unique identifier for each seller.                     |
| origin_zip_code      | string | True      | 12345000           | Seller's 8-digit ZIP code, numbers only.               |
| destination_zip_code | string | True      | 12345000           | Buyer's 8-digit ZIP code, numbers only.                |
| destination_lat_long | object | True      | \-                 | Latitude x Longitude of the buyer's delivery location. |
| latitude             | float  | True      | -46.73540209999999 | Latitude of the buyer's delivery location.             |
| longitude            | float  | True      | -23.5745851        | Longitude of the buyer's delivery location.            |
| items                | array  | True      | \-                 | Product list.                                          |
| item_id              | int    | True      | 12345678           | Item ID on Shopee.                                     |
| sku                  | string | No        | item_sku           | SKU registered by the seller on Shopee.                |
| model_id             | int    | No        | 12345678           | Model ID registered on Shopee.                         |
| category_id          | int    | No        | 12345678           | Item category registered on Shopee.                    |
| quantity             | int    | True      | 12345678           | Quantity of identical items.                           |
| price                | float  | True      | 150.4              | Product price.                                         |
| dimensions           | object | True      | \-                 | Product dimensions.                                    |
| length               | int    | True      | 10                 | Length in centimeters per unit.                        |
| width                | int    | True      | 10                 | Width in centimeters per unit.                         |
| height               | int    | True      | 10                 | Height in centimeters per unit.                        |
| weight               | int    | True      | 100                | Weight in grams per unit.                              |

**Note:** For quotations on the PDP, model_id and category_id are sent as 0. On the Checkout page, they are sent normally.

 

**Response Parameters / Quotation Response (Error)**

 

| Name       | Type   | Mandatory | Example | Description                  |
|------------|--------|-----------|---------|------------------------------|
| error      | string | True      | \-      | Identifier of the quotation. |
| message    | string | True      | \-      | Error message.               |
| request_id | string | True      | \-      | API call identifier.         |

 

**Response Parameters / Quotation Response (Success)**  
  
 

| Name                  | Type   | Mandatory | Example            | Description                                                                                            |
|-----------------------|--------|-----------|--------------------|--------------------------------------------------------------------------------------------------------|
| channel_id            | int    | True      | 90026              | Unique identifier of the logistics channel.                                                            |
| quotation_id          | int    | True      | 091234000          | Identifier of the quotation made by the seller.                                                        |
| destination_zip_code  | string | True      | 091234000          | Buyer's ZIP code.                                                                                      |
| destination_lat_long  | double | No        | \-                 | Latitude x Longitude of the delivery location.                                                         |
| latitude              | float  | No        | -46.73540209999999 | Latitude of the buyer's delivery location.                                                             |
| longitude             | float  | No        | -23.5745851        | Longitude of the buyer's delivery location.                                                            |
| packages              | array  | True      | \-                 | Package list.                                                                                          |
| dimensions            | object | True      | \-                 | Product dimensions.                                                                                    |
| length                | int    | True      | 10                 | Length in centimeters.                                                                                 |
| width                 | int    | True      | 10                 | Width in centimeters.                                                                                  |
| height                | int    | True      | 10                 | Height in centimeters.                                                                                 |
| weight                | int    | True      | 100                | Weight in grams.                                                                                       |
| items                 | array  | True      | \-                 | Product list.                                                                                          |
| item_id               | int    | True      | 12345678           | Item ID on Shopee.                                                                                     |
| sku                   | string | False     | sku_item           | SKU registered by the seller on Shopee.                                                                |
| model_id              | int    | False     | 12345678           | Model ID registered on Shopee.                                                                         |
| model_sku             | string | False     | model_sku          | Model SKU registered by the seller on Shopee.                                                          |
| category_id           | int    | False     | 12345678           | Item category registered on Shopee.                                                                    |
| quantity              | int    | True      | 2                  | Quantity of items.                                                                                     |
| price                 | int    | True      | 150.4              | Product price.                                                                                         |
| dimensions            | object | True      | \-                 | Product dimensions.                                                                                    |
| length                | int    | True      | 10                 | Length in centimeters.                                                                                 |
| width                 | int    | True      | 10                 | Width in centimeters.                                                                                  |
| height                | int    | True      | 10                 | Height in centimeters.                                                                                 |
| weight                | int    | True      | 100                | Weight in grams.                                                                                       |
| quotations            | array  | True      | \-                 | List of shipping quotations.                                                                           |
| price                 | float  | True      | 150.4              | Shipping cost displayed to the buyer.                                                                  |
| handling_time         | int    | True      | 20                 | Order preparation time in minutes. This includes the seller's preparation time before shipping.        |
| shipping_time         | int    | True      | 10                 | Order transportation time in minutes.                                                                  |
| promise_time          | int    | True      | 30                 | Sum of handling_time + shipping_time.                                                                  |
| service_code          | string | True      | M1020              | Code that identifies the carrier. It will be returned in the shipping_carrier parameter.               |
| fallback_promise_time | int    | True      | 30                 | Average order preparation and shipping time used as fallback in case of an error in the Quotation API. |

 

# **Expected Error Codes**

 

| HTTP Status Code | Error                         | Message                             |
|------------------|-------------------------------|-------------------------------------|
| 200              | success API call, error Empty | success API call, error Empty       |
| 403              | error_partner_id              | there is no partner_id in query     |
| 403              | error_partner_id              | partner_id is invalid               |
| 403              | error_sign                    | there is no sign in query           |
| 403              | error_sign                    | your sign is invalid                |
| 403              | error_timestamp               | there is no timestamp in query      |
| 403              | error_timestamp               | your timestamp is invalid           |
| 403              | error_shop_id                 | there is no shop_id in body         |
| 403              | error_shop_id                 | The shop_id is invalid              |
| 403              | Invalid origin_zip_code       | The origin_zip_code is invalid      |
| 403              | invalid destination_zip_code  | The destination_zip_code is invalid |
| 403              | error_destination_zip_code    | No shipping channel is available.   |
| 403              | Invalid item_id               | The item_id is invalid              |
| 403              | Invalid model_id              | The model_id is invalid             |
| 403              | Invalid sku                   | The sku is not valid                |
| 403              | invalid category_id           | The category_id is invalid          |
| 403              | invalid quantity              | The quantity is invalid             |
| 403              | invalid price                 | The price is invalid                |
| 403              | error_dimensions              | The dimensions is invalid           |
| 403              | error_length                  | The length is invalid               |
| 403              | error_width                   | The width is invalid                |
| 403              | error_height                  | The height is invalid               |
| 403              | error_weight                  | The weight is invalid               |
| 500              | Internal system error         | internal system error               |

 

# Quotation Response Time Limit

To be defined.

# Contingency Table

  
This functionality is intended to support freight calculation if a problem occurs with the freight quotation through the API.

## Configuring Shipping Values for Contingency

\- For the contingency flow to work, the seller must register the shipping values and enable the **Turbo Delivery** channel.  
- In Seller Center, access **Shipping Settings** and click the **Channel Settings** button.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=xL%2BcxecQBAxufWB0bx1Xr1NZIOBu6qphymm8plDpDNME7WOjcaZbLmNBK1UJlieKA8Q2OTmmCmcopwIxgBejmw%3D%3D&image_type=png)

## Filling in the Shipping Value for Contingency

The screen for entering the shipping cost will then be displayed. Shipping costs can be entered by state, using a single value, or by city.

 

### Single Shipping Cost per State

1.  Select the states.
2.  Fill in the shipping cost field.
3.  Click **Save**.

### Single Shipping Cost per City

1.  Select the states.
2.  Disable the **Flat rate for this area** button.
3.  Uncheck **Select all cities** and select the cities for which you want to provide a shipping cost.
4.  Fill in the **Rate** field for the respective cities.
5.  Click **Save**.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=3u2ma1YtqbuwgODcAddGEg125w05i6ss4z0CojEJCin8n8Aof6pd7%2B%2FRW1Du5lAyEjkpER99K7a9a8CvhacXxw%3D%3D&image_type=png)

# Serviceable Area Settings

This functionality is intended to support the configuration of the seller's serviceable area, in order to identify whether the buyer's delivery address is within the seller's serviceable area.

This configuration must be made for **outlet shops / normal shops** and does not follow the mart-outlet structure.

This configuration is mandatory before enabling the **Turbo Delivery** channel. Without serviceable area configuration, the channel will always be displayed as unavailable to the buyer.

To upload the serviceable area settings:

1.  The seller must upload the serviceable area settings through: [v2.logistics.upload_serviceable_polygon](https://open.shopee.com/documents/v2/v2.logistics.upload_serviceable_polygon?module=95&type=1)  
    a) If you upload 2 KML files, the most recently uploaded file will be used.
2.  After the upload, the seller can check the status of the serviceable area settings upload through: [v2.logistics.check_polygon_update_status](https://open.shopee.com/documents/v2/v2.logistics.check_polygon_update_status?module=95&type=1)

# Order Status and Tracking

Order status and tracking updates will be performed through the **Tracking Update API** and will be based on the order number created on Shopee (Order ID, also known as OrderSN).

The tracking number will also be required.

To update the tracking number and order status, use the OpenAPI endpoint:

[v2.logistics.update_tracking_status](https://open.shopee.com/documents/v2/v2.logistics.update_tracking_status?module=95&type=1)

The possible status updates are:

### 1. Order Shipped (logistics_pickup_done)

The URL and tracking number can be sent when updating the order status to **Shipped**.

### 2. Order Delivered (logistics_delivery_done)

The **Delivered** status will only be accepted if the order already has the **Shipped** status.

### 3. Delivery Failed (logistics_delivery_failed)

The **Delivery Failed** status will only be accepted if the order already has the **Shipped** status.

**Failed reason:** For the Turbo Delivery channel, the seller must send failed_reason when updating the tracking status.

 

 

**IMPORTANT:** After sending the **Order Delivered** or **Delivery Failed** status, no further status updates will be allowed, as both are final statuses.

*The tracking_number and tracking_url parameters must only be sent when updating the status to logistics_pickup_done.*

API documentation: [/api/v2/logistics/update_tracking_status](https://open.shopee.com/documents/v2/v2.logistics.update_tracking_status?module=95&type=1)

# Channel Order Flow and Status

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=l4mHUSt8rsmwQqlsFqme01j6V4h1ZamyxbTIIKH6iJLU9gDwJXalB3lAqnL3T1fkU2ryePRgJeewMa5qDKqRdA%3D%3D&image_type=png)

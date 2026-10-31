# Instant Order Fulfillment Guide

> Nhóm: API Guidelines and Flows · nguồn: https://open.shopee.com/developer-guide/755

Instant Delivery is one of Shopee’s key fulfillment initiatives. Its short fulfillment window requires sellers to process orders promptly, prepare packages efficiently, and arrange pickup on time. We encourage fulfillment ISVs and developers to prioritize API support for Instant Delivery, helping sellers identify and process Instant orders promptly, fulfill them on time, and stay competitive as demand for faster delivery grows.

 

This guide focuses on the differences between Instant and regular orders in order retrieval and fulfillment, and provides OpenAPI integration recommendations and best practices. For workflows not specifically covered here, follow the instructions in [*Order Management*](https://open.shopee.com/developer-guide/229).

 

*Note：**Instant Delivery is currently available only in selected local regions.*

## **1 Get Instant Orders and Packages Pending Fulfillment**

 

Use [*v2.order.get_order_list*](https://open.shopee.com/documents/v2/v2.order.get_order_list?module=94&type=1) to get order lists, or [*v2.order.search_package_list*](https://open.shopee.com/documents/v2/v2.order.search_package_list?module=94&type=1) to get package lists.

For Instant fulfillment, we recommend using [*v2.order.search_package_list*](https://open.shopee.com/documents/v2/v2.order.search_package_list?module=94&type=1) to filter packages that have not yet been shipped and identify those that require processing.

 

The filter.order_type field filters packages by order type. The value 2 represents Instant Order. Set order_type=2 in the filter object of the request body to retrieve packages of this type.

 

You can use the following additional filters based on your business needs:

- package_status: Filters packages by processing status.
- fulfillment_type: Filters packages fulfilled by the seller or Shopee.
- shipping_priority: Filters packages by shipping urgency.

 

To prioritize packages approaching their shipping deadlines, set:

- sort.sort_type=1: Selects **ShipByDate (shipping deadline)** as the sorting criterion.
- sort.ascending=true: Sorts in ascending order, from the earliest shipping deadline to the latest.

For the supported values and descriptions of each field, refer to **Request Parameters** in [*v2.order.search_package_list*](https://open.shopee.com/documents/v2/v2.order.search_package_list?module=94&type=1).

 

***Note:** For VN shops, order_type=2 also returns Same day Delivery packages. Use the channel information returned by* [**v2.logistics.get_channel_list**](https://open.shopee.com/documents/v2/v2.logistics.get_channel_list?module=95&type=1) *to confirm whether each package uses an Instant channel.*

## **2 Retrieve Package Details**

### **2.1 Retrieve Package Preparation Information and Shipping Deadlines**

 

After getting the package list, call [*v2.order.get_package_detail*](https://open.shopee.com/documents/v2/v2.order.get_package_detail?module=94&type=1) to obtain package-level information, including items, logistics channels, and fulfillment details, to help sellers prepare their packages. 

For order-level information, call [*v2.order.get_order_detail*](https://open.shopee.com/documents/v2/v2.order.get_order_detail?module=94&type=1).

 

Both APIs provide ship_by_date, which indicates the deadline for shipping out the package:

- Once logistics allocation is complete, you can get a valid timestamp. The corresponding status is order_status=READY_TO_SHIP at the order level or fulfillment_status=LOGISTICS_READY at the package level.
- Before logistics allocation is complete, this field may return an empty string: "ship_by_date": "".

We recommend using the valid ship_by_date returned by the API to display the shipping deadline and remind sellers to ship on time. If the field is empty, retrieve the details again after logistics allocation is complete.

### **2.2 Identify Instant Channels and Check Label Preprinting Support**

 

After getting package details, use the package’s logistics_channel_id to find the corresponding channel record in response.logistics_channel_list returned by [*v2.logistics.get_channel_list*](https://open.shopee.com/documents/v2/v2.logistics.get_channel_list?module=95&type=1).

Check the actual values returned for the following fields:

- service_type_identifier: Identifies the channel’s delivery service type. A value of "instant" indicates an Instant channel.
- preprint: Indicates whether the channel supports printing shipping labels before arranging shipment.  A value of true indicates that preprinting is supported.

 

***Notes:***

- *Not all Instant channels support preprinting. Confirm the channel type, then check its actual preprint value. Use the Instant preprinting workflow below only when service_type_identifier="instant" and preprint=true. If preprinting support is not confirmed, follow the existing shipping document workflow.*
- *For VN shops, this step also helps distinguish Instant Delivery packages from Same-day Delivery packages.*

## **3 Instant Order Fulfillment Workflow**

 

When arranging pickup, choose the appropriate workflow based on the channel capabilities confirmed in Section 2.2:

- **Instant packages without preprinting support:** Follow the existing workflow. Arrange shipment first, then retrieve the tracking number and shipping label. Refer to [*Order Management*](https://open.shopee.com/developer-guide/229).
- **Instant packages with preprinting support:** Print the shipping label and prepare the package before arranging pickup, so the package is ready when the driver arrives. Refer to Section 3.1.

### **3.1 Preprint Shipping Labels**

 

After confirming that the Instant channel returns preprint=true and logistics allocation is complete (order_status=READY_TO_SHIP / fulfillment_status=LOGISTICS_READY), call the following APIs in sequence for the same package:

 

- **Retrieve shipping document types:** Call [*v2.logistics.get_shipping_document_parameter*](https://open.shopee.com/documents/v2/v2.logistics.get_shipping_document_parameter?module=95&type=1) to retrieve the available and recommended shipping document types.
- **Create the shipping document:** Call [*v2.logistics.create_shipping_document*](https://open.shopee.com/documents/v2/v2.logistics.create_shipping_document?module=95&type=1), providing the required order and package information and an available shipping document type. A tracking number is not yet available during preprinting, so **tracking_number is not required**.
- **Check the document generation result:** Call [*v2.logistics.get_shipping_document_result*](https://open.shopee.com/documents/v2/v2.logistics.get_shipping_document_result?module=95&type=1) and wait until the result is READY.
- **Download the shipping document:** Call [*v2.logistics.download_shipping_document*](https://open.shopee.com/documents/v2/v2.logistics.download_shipping_document?module=95&type=1), then print the label, pack the items, and attach the label to the package.

 

For channels that do not support preprinting, follow the existing shipping document workflow.

### **3.2 Arrange Pickup After Preparing Packages**

 

For packages whose shipping labels have been preprinted as described in Section 3.1, we recommend completing picking, packing, and labeling before arranging shipment and pickup:

- **Single-package processing:** Call [*v2.logistics.get_shipping_parameter*](https://open.shopee.com/documents/v2/v2.logistics.get_shipping_parameter?module=95&type=1) to retrieve shipping parameters, then call [*v2.logistics.ship_order*](https://open.shopee.com/documents/v2/v2.logistics.ship_order?module=95&type=1) to arrange pickup.
- **Batch processing:** For packages that meet the batch APIs’ requirements, call [*v2.logistics.get_mass_shipping_parameter*](https://open.shopee.com/documents/v2/v2.logistics.get_mass_shipping_parameter?module=95&type=1) to retrieve parameters, then call [*v2.logistics.mass_ship_order*](https://open.shopee.com/documents/v2/v2.logistics.mass_ship_order?module=95&type=1) to arrange pickup.

If Auto Call Driver is enabled for the channel, use the preparation_end_time returned by [*v2.order.get_package_detail*](https://open.shopee.com/documents/v2/v2.order.get_package_detail?module=94&type=1) to complete package preparation before the system automatically arranges pickup. Before arranging pickup manually, check whether the system has already arranged it to avoid duplicate submissions.

### **3.3 Reschedule Pickup for Instant Orders**

 

There are two scenarios for rescheduling pickup.

 

**Scenario 1: The package is already in pickup retry status**

In the existing order workflow, order_status=RETRY_SHIP indicates that pickup needs to be arranged again.

For package-level integrations, retrieve the package details and follow the existing pickup retry workflow for packages with fulfillment_status=LOGISTICS_PICKUP_RETRY.

 

**Scenario 2: Pickup has been arranged for an Instant package, but the package has not entered pickup retry status**

For Instant packages that have not been picked up after the Instant pickup cutoff time, pickup can be rescheduled when the eligibility conditions are met. Refer to [*Section 3 of the Instant Order Reschedule Pickup announcement*](https://open.shopee.com/announcements/1362).

 

**Eligibility Conditions**

The package must meet all of the following conditions:

- It belongs to the ID, MY, VN, or TH market.
- Its actual logistics channel has service_type_identifier="instant".
- Its logistics status is LOGISTICS_REQUEST_CREATED, and pickup has not been completed.
- The current time is after the day’s Instant pickup cutoff time and before the next day’s Instant pickup operating start time.

We recommend calling v2.order.search_package_list with filter.order_type=2 and filter.package_status=3 to retrieve candidate Instant packages for which shipment has been arranged (order_status=PROCESSED / fulfillment_status=LOGISTICS_REQUEST_CREATED). Then retrieve their details to verify eligibility.

Call [*v2.logistics.get_operating_hours*](https://open.shopee.com/documents/v2/v2.logistics.get_operating_hours?module=95&type=1) and read instant_operating_hour. Use the shop’s local time to determine whether the current time falls within the rescheduling window.

Eligible packages do not need to enter LOGISTICS_PICKUP_RETRY before pickup can be rescheduled.

 

***Note:** The market and time-window requirements above apply to Scenario 2. Scenario 1 follows the existing pickup retry rules.*

 

**Update the Pickup Appointment**

For packages that qualify under either scenario, follow these steps:

1.  **Retrieve pickup parameters:** Call [*v2.logistics.get_shipping_parameter*](https://open.shopee.com/documents/v2/v2.logistics.get_shipping_parameter?module=95&type=1) and select an available pickup address and time.
2.  **Update the pickup appointment:** Call [*v2.logistics.update_shipping_order*](https://open.shopee.com/documents/v2/v2.logistics.update_shipping_order?module=95&type=1), providing the target order and package information, along with the required pickup.address_id and pickup.pickup_time_id. Refresh the package details after the update succeeds.

If the API returns Package {package_number} not eligible for rescheduling, the order is not currently eligible for pickup rescheduling. Check the package status and the eligibility conditions for the applicable scenario.

 

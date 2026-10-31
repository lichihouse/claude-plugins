# BR SPI App Creation User Guide

> Nhóm: Getting Started · nguồn: https://open.shopee.com/developer-guide/749

## **What is an SPI App?**

An SPI App is an application that connects a developer or partner’s service endpoint with Shopee. The developer provides the service URL required for the corresponding business scenario, and Shopee uses the configured SPI routing information to connect business requests to the partner’s system.

 

The SPI App types covered include Seller Logistics, Swarm ERP, Brand Membership, and Auto Parts Installation. Each App Type has its own business purpose and Service Endpoint Configuration.

- **Seller Logistics** is used for seller logistics quotation setup. The developer provides the quotation service URL and selects the applicable Logistics Channel. (Need Developer Type to be included in Registered Business Seller/Third-party Partner Platform (ISV)/Individual Seller; Channel ID is included in 90021, 90025, or 90026)
- **Swarm ERP** is used to support multi-stop operations, bulk listings, and cross-border synchronization. (Whitelist Only)
- **Brand Membership** is used to support brand membership programs, points, and exclusive rewards. (Whitelist Only)
- **Auto Parts Installation** enables Shopee to retrieve installation workshop information and dynamic installation service quotations, and to create, update, or cancel installation orders. (Whitelist Only)

## **What this feature does**

This feature allows developers to create an SPI App and configure its service endpoint information in Open Platform Console. The configuration page and required fields vary by App Type.

## **What you’ll learn in this doc**

· How to select an SPI App Type when creating an App

· How to configure the service endpoint before Go Live

· How to update the configuration of an Online SPI App

## **Step-by-step configuration**

### **(1) Create an SPI App**

Open the **Create App** page in Open Platform Console and select the required App Category.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=NFq%2BTvlTHFeJqmhJ8F8Ebai0HztaGLytSKqiP8fF5c9n8HVi1T9YGI5g4mjl2NiCntf%2BL1gCGYcOTXjpwE3uzg%3D%3D&image_type=png)

**Seller Logistics**

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=Mi%2BpiTtpqkPW7olAoXsiMI8ycaCHS7zok5ac4jfHI9OKuTcFN6IUa7%2FKFOTOM1A6%2BS0kitZ7%2FbHDRBoA3dJjZg%3D%3D&image_type=png)

 

**Swarm ERP** 

\*Please note that this screenshot is from the UAT environment; the live environment takes precedence.\*

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=Osiem4wInbV%2FXbt9BSyxIRe95exQ0akwSA1xxqUERecJwudHsNEMCI%2FwwS3h%2FbNde2eQVU7ZmoXvQhQdZI7j5g%3D%3D&image_type=png)

 

|                                                                  |                                                                                                                                                                                                                        |
|------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **App Type**                                                     | **Availability**                                                                                                                                                                                                       |
| Seller Logistics                                                 | Used for seller logistics quotation setup in Brazil.                                                                                                                                                                   |
| Swarm ERP                                                        | Visible only when the Developer Region is CN or HK, and only available to whitelisted developers.                                                                                                                      |
| Auto Parts Installation - Auto Parts Installation (Seller-Owned) | This applies to Shopee Seller developers who provide self-installation services for their own automotive parts products and need to obtain Shop Authorization. Available only to whitelisted developers.               |
| Auto Parts Installation -  Auto Parts Installation (ISP)         | Intended for Third-party Partner Platform developers who provide standardized installation services to different stores on the platform; Shop Authorization is not required. Available only to whitelisted developers. |

### **(2) Configure the service endpoint**

After completing the basic App information, click **Go Live**. The system displays the corresponding **Service Endpoint Configuration** fields based on the selected App Type.

**Seller Logistics**

|                               |                                                                                         |
|-------------------------------|-----------------------------------------------------------------------------------------|
| **Special Field**             | **Requirement**                                                                         |
| Live Host URL                 | Mandatory. The URL must start with http:// or https://. Maximum length: 128 characters. |
| Service Function Path Mapping | Must enter a valid Service Function Path.                                               |
| Logistics Channel             | Mandatory. Select 90021, 90025, or 90026.                                               |

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=fZRX%2BM%2BEn11BIP3pBInsXWHu0UMwftYmSfEXdiZVsyZCbCefjXVtEHGsXnPek2ohtWfgglT8KA9KTp6F%2F%2FNy0w%3D%3D&image_type=png)

 

 

**Swarm ERP**

|                               |                                                                                         |
|-------------------------------|-----------------------------------------------------------------------------------------|
| **Special Field**             | **Requirement**                                                                         |
| Live Host URL                 | Mandatory. The URL must start with http:// or https://. Maximum length: 128 characters. |
| Service Function Path Mapping | Must enter a valid Service Function Path.                                               |

### **(3) Submit the configuration**

Complete all mandatory fields and submit the Go Live application. The App and its SPI configuration enter the review process together.

If a required field is empty or the URL format is invalid, the system blocks submission and displays the corresponding validation message.

### **(4) Update an Online SPI configuration**

For an Online SPI App:

1\. Edit the Live Host URL on the App configuration page.

2\. Click **Submit Change**.

3\. The new configuration is saved as a pending change request.

4\. The existing approved configuration remains active while the update is under review.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=3r5QjXmAXGXmpzuY0qmWkRNIZoM4OUbsxz4jHZ47Jl6DmE0cJ7DDer%2BAS2ZJbAkj%2FcKsMSTO93gQdA7pL%2B9GDg%3D%3D&image_type=png)

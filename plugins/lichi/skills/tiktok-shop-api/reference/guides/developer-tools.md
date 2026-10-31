# Developer Guide — Developer tools

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.



---

## Developer tools > Seller Center development shops

Doc: https://partner.tiktokshop.com/docv2/page/seller-center-development-shops · cập nhật 2026-10-29

Seller Center Development Shops let developers create Seller Center test accounts for TikTok Shop API development. These test accounts are created under a Partner Center account and are separate from production seller accounts. Development shops are not discoverable by regular TikTok users in the production TikTok app.
Use this guide to choose the right test account type, create test shops, authorize your app, and generate test product and order data.
### Quick start
Use the current Partner Center path:
**Partner Center Console > Development Kits > Development Shops**
| Task | Path |
| --- | --- |
| Create a Core or Full Function test account | **Development Kits > Development Shops > Manage accounts > Create test account** |
| Enter a test shop or authorize an app | **Development Kits > Development Shops > Manage accounts**  |
| Link a customer(buyer) Test TikTok Account | **Development Kits > Development Shops > Manage accounts > Settings (button)** |

Older screenshots or documents may show **Development Kits > Development Shops**. Treat **Development Shops** as the previous menu name for the Sandbox test-account area.

#### **Create test seller account**
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/4e741e5e315348c8beb9377ad1f05881~tplv-k9wyc2ijk0-image.image)

#### **Authorize app**
> Note: Your app market must include the market where the sandbox is located as well as the seller type; otherwise, authorization will fail.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/81521c8a370b4535bb99dee5479786f0~tplv-k9wyc2ijk0-image.image)

#### **Link customer(buyer) test account**
> Note：This action is permanent. Once the TikTok account is linked in development shops, it will be turned into a test account permanently. Unlinking in the future will not reverse this account. You must use a newly created TikTok when linking. Test accounts cannot be linked to production Seller Center accounts. Attempting to do so could severely affect your business operations.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/c0c3bd107e434d5b90acabb7b8edeaac~tplv-k9wyc2ijk0-image.image)

### Core vs Full Function accounts
| Question | Choose Core Function Account | Choose Full Function Account |
| --- | --- | --- |
| Main goal | Product, order, fulfillment, cancellation, and return API testing with generated test data. | Full-flow testing that more closely resembles production Seller Center and TikTok app buyer behavior. |
| Business / KYC information | Not required for basic setup. | Required. Business and KYC information must be valid and may be reviewed. |
| TikTok account setup | Not required. | Required for Official Test TikTok Account and Buyer Test TikTok Account scenarios. |
| Payment | No real payment or credit card required. Test orders are created in Buyer View. | Real buyer checkout flow can be tested with Buyer Test TikTok Accounts and payment methods. Use very low test prices, such as `$0.01`. |
| TikTok app product discovery | Not supported through regular buyer accounts. | Supported only through linked test TikTok accounts. |
| Finance, settlements, customer service, and full production-like flows | Not supported or not suitable. | Supported for testing after Full Function setup is complete. |
| Best for | API integration testing for product listing, order updates, fulfillment, cancellations, and returns. | Testing buyer experience, product discovery, payment, settlement, customer service, and end-to-end flows. |
Decision guide:

1. If you only need products, orders, fulfillment, cancellations, or returns without real payment, use **Core Function Account**.
2. If you need TikTok app discovery, buyer checkout, real payment, settlement, customer service, or production-like verification, use **Full Function Account**.
3. If you cannot provide business/KYC information or region-matched TikTok test accounts, start with **Core Function Account**.
4. If an issue reproduces only in the TikTok app buyer journey, use **Full Function Account** with linked test TikTok accounts.

> **Important Core Function limitation:** In **Core Function Account** mode, the sandbox provides built-in tools to directly advance forward and reverse order statuses. Because these tools simulate state changes, some flows may be inconsistent with or not fully aligned with the production environment. Use Core Function mode for core API functionality testing. Use Full Function mode for full-flow or detail-level verification.

### FAQ before setup
This section covers frequent Sandbox and Developer Tool support issues: test account creation, irreversible TikTok account conversion, and region, SIM card, or VPN restrictions.
#### Can I use the same TikTok account for production and testing?
Do not use production or personal TikTok accounts for Full Function testing. Once a TikTok account is linked as an Official Test TikTok Account or Buyer Test TikTok Account, it is converted into a test account. This action is permanent and cannot be reversed. The account can no longer be used normally in the TikTok app or TikTok Shop production environment.
#### Why does linking a TikTok account fail?
The TikTok account region must match the test shop region. When creating or linking the TikTok account, your physical location should match the test shop country or region. If you cannot be physically located in that region, remove the SIM card from your device and use a VPN with an IP address in the test shop region before creating or linking the TikTok account.
#### Why can't I find test products in the TikTok app?
This applies to Full Function testing. Search with the linked Buyer Test TikTok Account, not a regular TikTok account. Also check that the product is published, does not contain prohibited or random test keywords, and that the device location matches the shop region.
#### Why does checkout show an error such as "Something went wrong"?
For Full Function orders, check that the buyer test account is linked correctly, the buyer device region matches the shop region, and the payment method is available. If you cannot be physically in the same region as the shop, remove the SIM card and use a VPN with an IP address in that region.
### What you can test
| Capability | Core Function Account | Full Function Account |
| --- | --- | --- |
| Create products | Yes | Yes |
| Create test orders without payment | Yes, through Buyer View | No, use buyer checkout flow instead |
| Place buyer orders with real payment | No | Yes, through linked Buyer Test TikTok Account |
| Fulfill orders | Yes | Yes |
| Process returns and refunds | Yes | Yes |
| Product discovery in TikTok app | No | Yes, through linked test TikTok accounts |
| Financial statements and settlements | No | Yes |
| Customer messaging services | No | Yes |
### Supported markets and seller types
Seller Development Shops are available for cross-border and local shops.
**Note:** The table reflects the supported regions for Core Function Accounts. For Full Function Accounts, the supported local regions are the same as Core Function Accounts, while cross-border seller support is currently unavailable.
| Country/Region | Country Code | Cross-border | Local |
| --- | --- | --- | --- |
| Austria | AT (40) | Yes | Yes |
| Belgium | BE (56) | Yes | Yes |
| Brazil | BR (76) | No | Yes |
| Czech Republic | CZ (203) | Yes | Yes |
| France | FR (250) | Yes | Yes |
| Germany | DE (276) | Yes | Yes |
| Greece | GR (300) | Yes | Yes |
| Hungary | HU (348) | Yes | Yes |
| Indonesia | ID (360) | No | Yes |
| Ireland | IE (372) | Yes | Yes |
| Italy | IT (380) | Yes | Yes |
| Japan | JP (392) | Yes | Yes |
| Malaysia | MY (458) | Yes | Yes |
| Mexico | MX (484) | Yes | Yes |
| Netherlands | NL (528) | Yes | Yes |
| Philippines | PH (608) | Yes | Yes |
| Poland | PL (616) | Yes | Yes |
| Portugal | PT (620) | Yes | Yes |
| Singapore | SG (702) | Yes | Yes |
| Vietnam | VN (704) | Yes | Yes |
| Spain | ES (724) | Yes | Yes |
| Thailand | TH (764) | Yes | Yes |
| United Kingdom | GB (826) | Yes | Yes |
| United States | US (840) | Yes | Yes |
### Terminology
| Term | Definition |
| --- | --- |
| Seller Center Development Account | A Seller Center test account created under Partner Center for development and testing. Events and data in development accounts do not affect production seller accounts. There are two types: Core Function Account and Full Function Account. |
| Core Function Account | A lightweight test account that does not require real business information, TikTok account setup, or credit card information. It is used mainly for product, order, and fulfillment testing inside Partner Center. It does not support real buyer checkout, finance, settlement, or customer-service scenarios. |
| Full Function Account | A production-like test account that requires business and KYC information. It supports Core Account capabilities plus linked Official Test TikTok Accounts and Buyer Test TikTok Accounts. Use it for buyer checkout, product discovery, finance, settlement, customer service, and full-flow testing. |
| TikTok Account | An account created in the TikTok app with an email address or phone number. For testing, create new TikTok accounts and do not use production accounts. |
| Official Test TikTok Account | A TikTok account linked to a Full Function test shop as the shop's official account. After linking, the account is converted into a test account and cannot return to production use. |
| Buyer Test TikTok Account | A TikTok account linked in Partner Center for buyer-side testing. It can search for the test shop, view products, and place test orders in Full Function scenarios. After linking, it is permanently converted into a test account. |
| Shop Type | The seller model and market type of the test shop, such as **Local** or **Cross-border**. Local shops operate in one local market. Cross-border shops represent cross-border seller scenarios where supported. |
| Onboarding Type | The account entity type used during setup, such as **Individual** or **Business**. For Core Function testing, this does not change available functionality. For Full Function testing, business/KYC requirements may vary by market and account context. |
### Setup overview
Most API integration tests require product data and order data. To create this data, use one of the following setups:
| Setup | Assets needed |
| --- | --- |
| Core Function testing | Seller Center Core Function Account |
| Full Function testing | Seller Center Full Function Account, Official Test TikTok Account, and Buyer Test TikTok Account |
After setup, authorize your app with the test shop, create products, create or place orders, and then validate API behavior against the generated test data.
### Core Function Account setup
#### Core Function features
Core Function Accounts:

* require minimal setup information;
* do not require TikTok Official or Buyer Test TikTok Accounts;
* do not require payment methods or credit cards;
* support core testing for product listing, order updates, fulfillment, cancellations, and returns;
* should not be used for finance, settlement, customer-service, real checkout, or production-like buyer journey validation.

#### Create a Core Function Account

1. In Partner Center Console, go to **Development Kits > Sandbox > Seller test accounts**.
2. Click **Create test account**.
3. Select **Core Function**.
4. Select the **Shop Type**, such as **Local**, based on the target seller scenario.
5. Provide an **Account Nickname**.
6. Select the **Onboarding Type**, such as **Individual** or **Business**.
7. Wait for the Seller Center test account setup to finish.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/e58d92b9830a4cc8b0a9dbddfa2e61ff~tplv-k9wyc2ijk0-image.image)
#### Authorize your app with a Core Function test shop

1. Go to **Development Kits > Sandbox > Seller test accounts**.
2. In the seller test account section, click **Authorize app**.
3. Select the app that you want to test with this shop.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/854f31907af145ae9c20070ca8459c40~tplv-k9wyc2ijk0-image.image)
#### Add and manage products
Create a product in the Core Function test account by entering the required TikTok Shop product information and clicking **Submit for review**. You can also use the Create Product API to create products for the development shop.
After products are created, manage and verify them from the **Products** tab inside the Core Function Seller Center.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/a3b85f88ba644df79426a97e4bccde0b~tplv-k9wyc2ijk0-image.image)
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/cacd3bc3ac9b4c7096887d2f5042c755~tplv-k9wyc2ijk0-image.image)
Only products in **Active** status can be used for Core Function test orders.
#### Add shipping templates for seller shipping
**Note:** The screenshots in this section are for the US. Menu options may differ by market.

1. In the Core Function Account, go to **Orders > Shipping Options**.
2. Select TikTok Shipping or Seller Shipping.
3. If Seller Shipping is selected, go to **Orders > Shipping Templates** and set up a shipping template that includes the required buyer regions.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/4961c665fe8a44198437732d9f968854~tplv-k9wyc2ijk0-image.image)
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/8e9ac605b68e4ffd894c68bfe33d0e78~tplv-k9wyc2ijk0-image.image)
For more information, see [TikTok Shipping and Seller Shipping settings](https://seller-us.tiktok.com/university/essay?knowledge_id=2921116620719915&role=1&course_type=1&from=search&identity=1).
#### Use Buyer View to create Core Function test orders
Buyer View lets you trigger test orders without real buyer payment.

1. Click **Create test order** in Buyer View.
2. Select the products for the test order. A test order can include up to 3 products.
3. Select the shipping option for the order.
4. After the test order is created, it appears in Buyer View with **On Hold** status.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/3d2c9357a0ee4e21ac552129468f0adb~tplv-k9wyc2ijk0-image.image)
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/a77d72556fa54e089cb763def0e6213f~tplv-k9wyc2ijk0-image.image)
#### Test cancellations, returns, and fulfillment
Buyer View supports simulated buyer actions for supported order states:
| Test action | Requirement |
| --- | --- |
| Cancel order | The order must be in **On Hold** or **Awaiting Shipment** status. |
| Request refund or return | The order must be in a supported status such as **Awaiting Collection**, **In Transit**, or **Delivered**. |
Developers can respond to return requests through the API or through **Orders > Manage Returns**.
For order management guidance, see:

* [Manage orders](https://seller-us.tiktok.com/university/essay?knowledge_id=7774796412471041&role=1&course_type=1&from=search&identity=1)
* [Manage returns](https://seller-us.tiktok.com/university/essay?knowledge_id=6837901778454274&role=1&course_type=1&from=search&identity=1)

### Full Function Account setup
#### Full Function features
Full Function Accounts:

* include Core Function testing features;
* require valid business and KYC information;
* require full Seller Center setup before production-like flows can be tested;
* can be linked to Official Test TikTok Accounts and Buyer Test TikTok Accounts;
* support product discovery and buyer checkout in the TikTok app through linked test accounts;
* support real payment test orders, finance, settlements, customer service, and other full-flow API testing.

#### Requirements before creating Full Function accounts
Before creating a Full Function Account, prepare the required business and KYC information and test accounts. You do not need to create an app in advance. 

* Provide valid business and KYC information. 
* Register at least two new TikTok accounts for testing: one for the Official Test TikTok Account and one for the Buyer Test TikTok Account.
* Use testing email addresses. Do not use personal, production, or high-value TikTok accounts.
* Prepare region-matched device/network conditions for TikTok account creation and linking.

If you cannot provide the required information or region-matched TikTok accounts, use Core Function Accounts first.
#### Create a Full Function Account

1. In Partner Center Console, go to **Development Kits > Sandbox > Seller test accounts**.
2. Click **Create test account**.
3. Select **Full Function**.
4. Select the **Shop Type**, such as **Local**, based on the target seller scenario.
5. Provide an **Account Nickname**.
6. Click **Go to Seller Center** and complete [Seller Center onboarding](https://shop-academy-us.tiktok.com/university/essay?knowledge_id=10013682&role=1&identity=1).

If you are a seller developer and already have a TikTok Shop linked to your Partner Center account, you may not see the Seller Center onboarding step.
For US and UK Seller Center test accounts:

* US: To publish new products in your test shop, provide the required tax information in Seller Center.
* UK: To receive payouts from TikTok Shop, fill out the tax information for the Seller Center test account.
* After creating test shops, default pickup warehouses are set automatically. You still need to set shipping templates. See [Set up shipping](https://shop-academy-us.tiktok.com/university/essay?knowledge_id=10012875&role=1&identity=1).

#### Link an Official Test TikTok Account

1. Create a new TikTok account in the TikTok app. Use a testing email address.
2. Do not use a production TikTok account.
3. Link the TikTok account as the test shop's Official TikTok Account.
4. For account-linking details, see [How to link TikTok Shop Official Account](https://shop-academy-us.tiktok.com/university/essay?knowledge_id=10012412&role=1&identity=1).

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/b471be6835d449b7ba92cf0f09dd6be8~tplv-k9wyc2ijk0-image.image)
**Do not link the account as a Marketing Account for app testing.** Marketing Accounts have additional restrictions for merchandise and shop visibility.
#### Link a Buyer Test TikTok Account

1. Create a second new TikTok account in the TikTok app. Use a testing email address.
2. Log into the TikTok app with the account you want to use as the buyer test account.
3. In Partner Center, go to **Development Kits > Sandbox > Buyer test accounts**.
4. Click **Link account**.
5. Use the TikTok app to scan the QR code on the **Link TikTok account as buyer account** page.
6. Follow the **Authorize TikTok Partner Center** process in the TikTok app.
7. Click **Link the account** on the buyer-account linking page.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/08010af0a24a4e6792370acb942fbc6c~tplv-k9wyc2ijk0-image.image)
#### Region and account-conversion rules
Use these rules for both Official Test TikTok Accounts and Buyer Test TikTok Accounts:

* The TikTok account region must match the test shop region.
* Your physical location should match the test shop region when creating and linking the TikTok account.
* If you cannot be physically located in the same region, remove the SIM card from your device and use a VPN with an IP address in the test shop region before creating or linking the TikTok account.
* After a TikTok account is linked in Sandbox, it is permanently converted into a test account.
* A converted test account cannot be used normally in the TikTok app or TikTok Shop production environment.
* Use new testing email addresses and keep Official Test TikTok Accounts separate from Buyer Test TikTok Accounts.

### Using Full Function Account to test your app
#### Authorize your app

1. Go to **Development Kits > Sandbox > Seller test accounts**.
2. In the seller test account section, click **Authorize app**.
3. Select the app you want to install and test with the test shop.

#### Add and publish products
Add and publish products by following production rules. For US test shops, tax information must be submitted before products can be published.
Do not use random strings, the word "test", or prohibited keywords in product titles. Products may be flagged even if they appear published in Seller Center.
#### Find products in TikTok
Use the linked Buyer Test TikTok Account to search for the Official Test TikTok Account in the TikTok app. Only linked test accounts can find and interact with the test shop's products. Regular TikTok accounts cannot find the development shop.
If products do not appear:

* confirm that the product is published;
* check whether the title or content was flagged;
* confirm that the buyer account is linked correctly;
* confirm that the device region matches the shop region.

#### Create orders with real payment
Full Function test orders are placed through the TikTok app buyer journey.

1. Add a payment method to the Buyer Test TikTok Account.
2. Set a very low product price, such as `$0.01`.
3. Log into the TikTok app with the Buyer Test TikTok Account.
4. Search for the test shop's Official Test TikTok Account.
5. Open the **Shop** tab from the account profile page.
6. Select the test product and complete the purchase.

If checkout fails, check the buyer account linking status, device region, SIM card, VPN, payment method, and product publish status.
#### Manage orders
After payment is completed, manage the order in **Seller Center > Orders > Manage orders**. You can fulfill the order through the API according to your app's test cases.
For more details, see:

* [Manage orders](https://seller-us.tiktok.com/university/essay?knowledge_id=7774796412471041&identity=1)
* [Manage seller arranged shipping](https://seller-us.tiktok.com/university/essay?knowledge_id=6837882170099457&identity=1)
* [Manage TikTok Shop logistics shipping](https://seller-us.tiktok.com/university/essay?knowledge_id=8706274700117762&identity=1)

If you need to test order settlement, revenue sharing, or other finance-related functions, use a **Full Function Account**.
### Limitations

1. You can create up to 10 Seller Center test accounts across Full Function and Core Function Accounts.
2. Seller Center Development Shops expire in 180 days but can be reactivated in Partner Center.
3. You can link up to 10 TikTok accounts as Buyer Test TikTok Accounts to one Partner Center account.
4. Buyer Test TikTok Accounts linked to a Partner Center account can be used with any test shop you create in Sandbox.
5. You need at least two real TikTok accounts for Full Function testing: one Official Test TikTok Account and one Buyer Test TikTok Account.
6. You cannot use the same TikTok account as both the Official Test TikTok Account and the Buyer Test TikTok Account.
7. The API call quota for a sandbox shop is QPH < 18,000, exceeding this limit will result in a rate-limiting error.


---

## Developer tools > Development Shop Manual Order Status Update Guide (Full Account))

Doc: https://partner.tiktokshop.com/docv2/page/ar5ppjvv · cập nhật 2026-07-06

### Document Overview
This guide applies to merchants, testers, and developers working in the Full Function Account development shop environment. It explains how to manually simulate order status progression for test orders placed through the TikTok App, without relying on real fulfillment operations such as warehousing or logistics.
Use this guide when you need to validate end-to-end order status display, fulfillment callbacks, cancellation, or refund behavior in a development shop.
### 1. Feature Overview
In the Development Shop environment, merchants usually cannot rely on real fulfillment events to drive order status changes. The manual order status update capability allows testers to trigger status progression manually in Partner Center for test orders created from the TikTok App.
It covers both the forward flow, from order placement to delivered, and the reverse flow, including order cancellation and refund. This lets teams validate business logic and front-end status display end to end in the sandbox.
| Dimension | Description |
| --- | --- |
| Applicable environment | Development Shop, Full Function Account |
| Supported markets | Local Full Function Account development shops. See the country-level table below. |
| Supported flows | Forward flow and reverse flow |
| Entry point | Development Shop order management page in Partner Center / Seller Center |
| Target users | Merchant testers, developer debugging engineers, and operation reviewers |
#### 1.1 Supported Markets
Use the same country-level market scope as the Seller Center Development Shops guide. For Full Function Accounts, supported local regions are the same as Core Function Accounts, while cross-border seller support is currently unavailable.
| Country/Region | Country Code | Full Function Local |
| --- | --- | --- |
| Austria | AT (40) | Supported |
| Belgium | BE (56) | Supported |
| Brazil | BR (76) | Supported |
| Czech Republic | CZ (203) | Supported |
| France | FR (250) | Supported |
| Germany | DE (276) | Supported |
| Greece | GR (300) | Supported |
| Hungary | HU (348) | Supported |
| Indonesia | ID (360) | Supported |
| Ireland | IE (372) | Supported |
| Italy | IT (380) | Supported |
| Japan | JP (392) | Supported |
| Malaysia | MY (458) | Supported |
| Mexico | MX (484) | Supported |
| Netherlands | NL (528) | Supported |
| Philippines | PH (608) | Supported |
| Poland | PL (616) | Supported |
| Portugal | PT (620) | Supported |
| Singapore | SG (702) | Supported |
| Vietnam | VN (704) | Supported |
| Spain | ES (724) | Supported |
| Thailand | TH (764) | Supported |
| United Kingdom | GB (826) | Supported |
| United States | US (840) | Supported |
Market-specific UI text, shipping settings, tax requirements, payment behavior, and test assets may still vary by country. Always use the test product deeplink, buyer test account, and shop account that belong to the same country as the development shop.
### 2. Prerequisites
#### 2.1 Environment Requirements

* You have a Full Function Account development shop.
* The development shop setup is complete in Partner Center / Seller Center.
* The buyer account used to log in to TikTok App has already been linked to the Development Shop.
* The buyer account, official test account, test product, and development shop belong to the same country/region.

#### 2.2 Test Product Preparation
Before placing an order in TikTok App, make sure a product has already been successfully published in the development shop.
Acceptance criteria:

* The product is visible to the linked buyer test account in TikTok App.
* The product can be added to cart.
* The full checkout and payment flow can be completed in the test environment.

### 3. Workflow Overview
The following diagram shows the full path for manually driving order status changes in the sandbox after an order is placed in TikTok App, including both forward and reverse flows.
Text version of the workflow:

1. Create a test order in TikTok App with the linked buyer test account.
2. Confirm that the order appears in Partner Center / Seller Center with status **On Hold**.
3. Choose one of the following paths:
   * Forward flow: **On Hold -> Pending Shipment -> Awaiting Collection / In Transit -> Delivered**.
   * Seller-side reverse flow: **On Hold / Pending Shipment -> Cancelled**, or refund request -> merchant approval -> refund status update.
   * Consumer-side reverse flow: buyer cancels the order in TikTok App -> backend order status updates to **Cancelled**.
4. After each action, verify the corresponding order status in both the backend and TikTok App.
5. Run regression validation for backend-created orders to ensure existing order operations still work.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/f90f283ffc2f41d1a6e4bb72fa6154cc~tplv-k9wyc2ijk0-image.image)
### 4. Detailed Steps
#### 4.1 Step 1: Place an Order in TikTok App and Confirm It in Partner Center
First, place an order through the buyer account in TikTok App, then confirm that the order has been synced to the development shop backend.

1. Use the buyer account to open the product detail page in TikTok App.
2. Complete the full process: select SKU, add to cart, place the order, and finish payment.
3. Go to the development shop backend and open **Order Management**.
4. Search for the order ID or filter by time.
5. Confirm that the order is visible and the status is **On Hold**.

Text alternative to the screenshot:

* In Partner Center / Seller Center, the test order should appear in the order list.
* The order detail page should show the order ID, buyer information, product information, and current status.
* The expected initial status for this flow is **On Hold**.

Acceptance criteria: The order placed in TikTok App can be found in Partner Center and the status is synced correctly, which means the TikTok App order placement path is working as expected.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/b65c33efef574d498e6306d8678348d0~tplv-k9wyc2ijk0-image.image)
#### 4.2 Step 2: Forward Flow - Manually Drive Status Progression in the Backend
##### 4.2.1 On Hold -> Pending Shipment

1. Find the target order in the backend. The current status should be **On Hold**.
2. Open the order details page and locate the **manual status push** action button.
3. Select **Pending Shipment** and confirm the submission.
4. Open **My Orders** in TikTok App and verify that the order status has been updated to **Pending Shipment**.

Text alternative to the screenshots:

* The backend order detail page should expose a manual status push action when the order is eligible.
* After you submit the target status, the backend status should change first.
* TikTok App should then show the same target status after synchronization.

Note: After the backend status is pushed manually, the TikTok App status is usually synced within a few seconds. If the update is not visible yet, wait briefly and refresh the page.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/25a87058567f40869aa990ced2c6d037~tplv-k9wyc2ijk0-image.image)
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/26403bcf61ba453997c1abe3047c7993~tplv-k9wyc2ijk0-image.image)
##### 4.2.2 Pending Shipment -> Awaiting Collection -> In Transit

1. Confirm that the current order status is **Pending Shipment**.
2. Click **Ship Order** in the backend.
3. Fill in simulated logistics information. The tracking number can be a test value.
4. Submit the shipment information.
5. Confirm that the backend status changes to **Awaiting Collection / Shipped**.
6. Continue to manually push the order to **In Transit** when the action is available.
7. Verify that the corresponding order status in **My Orders** in TikTok App is updated accordingly.

Text alternative to the screenshot:

* The backend should show a **Ship Order** action for orders in **Pending Shipment**.
* The simulated logistics form should include the fields required by the market, such as carrier and tracking number.
* After shipping information is submitted, the status should move into the shipment stage and can be progressed to **In Transit**.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/a5e21a5dbebc4630a2384187b85c5768~tplv-k9wyc2ijk0-image.image)
##### 4.2.3 In Transit -> Delivered

1. Confirm that the current order status is **In Transit**.
2. Manually push the order to **Delivered** in the backend.
3. Verify in TikTok App that the order status is updated to **Delivered**.
4. Confirm that the forward flow is complete.

Text alternative to the screenshots:

* The backend should allow the final manual progression only after the order reaches the shipment stage.
* The expected final status in both backend and TikTok App is **Delivered**.

Acceptance criteria: After each manual status push in the backend, the order status in TikTok App is updated accordingly, which confirms that the forward status sync path is working properly.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/99fa0f6200474aafb821328a7952c446~tplv-k9wyc2ijk0-image.image)
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/1e89b9064a1a4ed0bcbf358d8da301e3~tplv-k9wyc2ijk0-image.image)
#### 4.3 Step 3: Reverse Flow - Initiate Cancellation or Refund from the Backend
##### 4.3.1 Cancel an Order

1. Find the target order in the backend when the status is **On Hold** or **Pending Shipment**.
2. Click **Cancel Order**.
3. Select a cancellation reason and confirm the submission.
4. Verify in TikTok App that the order status is updated to **Cancelled**.

Acceptance criteria: Both backend and TikTok App show **Cancelled** for the target order.
##### 4.3.2 Initiate a Refund

1. Find the target order in the backend and click **Initiate Refund**.
2. Fill in the refund reason and refund amount.
3. Submit the refund request.
4. In the Seller Center refund management page, locate the request and click **Approve Refund**.
5. After refund approval is completed, verify in TikTok App that the refund status has been updated.

Important: The refund flow requires two backend actions: **submit the refund request** and **approve the refund as the merchant**. The TikTok App status changes only after the approval step is completed.
#### 4.4 Step 4: Reverse Flow Initiated in TikTok App - Cancellation Synced Back to the Backend
This test case verifies whether a cancellation initiated by the user in TikTok App is synced back to the backend correctly.

1. Use a test account to place an order in TikTok App.
2. Confirm in the backend that the order has been created with status **On Hold**.
3. In **My Orders** in TikTok App, find the order and click **Cancel Order**.
4. Complete the cancellation in TikTok App.
5. Switch to Seller Center.
6. Refresh the order list and confirm that the order status has been updated to **Cancelled**.

Acceptance criteria: After the cancellation is initiated in TikTok App, the backend order status is updated successfully, which confirms that the reverse status callback path from TikTok App is working correctly.
#### 4.5 Step 5: Regression Validation for Existing Online Capability
After completing the TikTok App-related test cases above, also run regression testing for the existing forward and reverse flows of backend-created orders to make sure the new feature does not affect the original order operation path.

1. Use **Create Order Manually** in the backend to create a test order that is not placed through TikTok App.
2. Execute the full forward flow: **On Hold -> Pending Shipment -> In Transit -> Delivered**.
3. Create another test order and execute the reverse flow: **Cancel / Refund**.
4. Confirm that all existing functions still work correctly and there are no regression issues.

### 5. Quick Reference: Status Transitions
| Action type | Starting status | Target status | Entry point |
| --- | --- | --- | --- |
| Forward | On Hold | Pending Shipment | Backend -> Order details -> Manual status push |
| Forward | Pending Shipment | Awaiting Collection / In Transit | Backend -> Ship Order |
| Forward | In Transit | Delivered | Backend -> Manual progression |
| Reverse | On Hold / Pending Shipment | Cancelled | Backend -> Cancel Order |
| Reverse | Any status eligible for refund | Refunding / Refunded | Backend -> Initiate Refund -> Approve Refund |
| Consumer-side reverse | On Hold | Cancelled | TikTok App -> My Orders -> Cancel Order |
### 6. FAQ
#### Q1: I Cannot Find the Order in the Backend After Placing It in TikTok App. What Should I Do?

* Confirm that the logged-in development shop account and the shop used in TikTok App are the same shop.
* Confirm that the correct country/region is selected. Orders are not shared across development shop countries.
* Confirm that the buyer test account, official test account, test product, and development shop belong to the same country/region.
* Confirm that the payment flow in TikTok App has been fully completed, including payment confirmation. Unpaid orders will not be synced to the backend.
* Wait about 30 seconds, refresh the order list in the backend, and try again.

#### Q2: The TikTok App Order Status Does Not Update After I Manually Push the Status. How Should I Handle It?

* Wait 10 to 30 seconds and manually refresh **My Orders** in TikTok App.
* Check whether the backend status push was submitted successfully and whether the backend order status has changed.
* If the backend status has changed but TikTok App is not updated yet, this is likely due to delayed status delivery. Wait a little longer or ask the technical team to check the message queue.

#### Q3: Are the Test Flows the Same Across Supported Countries?
Yes. The core process is the same across supported Full Function local development shop countries. The differences are usually market-specific test assets, tax setup, shipping settings, payment behavior, menu text, or eligibility of specific backend actions.
Use the test product deeplink, shop account, buyer test account, and official test account for the corresponding country. Confirm required market-specific test assets with the business owner before testing.
#### Q4: Why Does the TikTok App Status Not Change During the Refund Flow?

* The refund flow requires two actions in Seller Center: **submit refund request** and **approve refund**.
* If only the refund request is submitted, the TikTok App status will not change immediately.
* Make sure the request has been found on the refund management page and **Approve Refund** has been clicked.

#### Q5: Will the Sandbox Manual Status Push Capability Affect Production Data?
No. Sandbox and production are fully isolated. The development shop environment is isolated from production, and all test operations will not affect real orders or real user data.
#### Q6: Does This Feature Support Bulk Manual Status Pushing?
The current feature is designed mainly for single-order operations. If bulk verification is needed, repeat the process order by order or confirm with the engineering team whether a bulk interface is available.


---

## Developer tools > API testing tool

Doc: https://partner.tiktokshop.com/docv2/page/api-testing-tool · cập nhật 2026-07-06

The API Testing Tool helps developers test TikTok Shop Open APIs from Partner Center. It lets you select an API, fill request parameters, send a test request, inspect the response, and copy generated sample code when you test with your own app key.
### Feature updates
Feature update notes are maintained in the [changelog](https://partner.tiktokshop.com/docv2/changelog). Avoid treating dated examples on this page as the latest tool status. Use the changelog and the live API Testing Tool UI as the source of truth for newly released testing capabilities, supported API versions, and tool behavior changes.
### Before you call any API
> **Important:** Most API Testing Tool failures are caused by missing API scopes or missing seller/shop authorization. Before you test with your own app key, make sure the app has the required API scope and the seller or test shop has authorized that scope.

Pre-call checklist:

1. Open the endpoint reference page and identify the required API scope.
2. In Partner Center Console, go to **App & Service > Manage > Manage API** for your app.
3. Confirm that the required scope is enabled or approved for the app.
4. Complete seller/test-shop authorization for the app.
5. If you obtain an access token manually, confirm that the token response `granted_scopes` includes the required scope.
6. In the API Testing Tool, use the correct app key and fill the access token in the request token field, usually the `x-tts-access-token` header field for `202309` and later APIs.

Common authorization and scope errors:
| Symptom or code | Likely cause | What to check |
| --- | --- | --- |
| `105005 Access denied` | The app or access token does not contain the required API scope. | Check **App & Service > Manage > Manage API**, then compare the token's `granted_scopes` with the endpoint's required scope. |
| `105002 Expired credentials` | The access token has expired. | Refresh the token or authorize again. |
| `36009004 Invalid credentials` with `access_token` or `x-tts-access-token` message | The token is invalid, copied incorrectly, or belongs to the wrong authorization principal. | Generate a new token and paste it into the correct token/header field. |
| Empty or missing shops when testing shop APIs | The app has not been authorized by the target seller or test shop. | Use the tool's authorization function or follow the authorization guide to authorize the app. |
For broader troubleshooting, refer to Common errors and Access scope.
### What is the API Testing Tool?
The API Testing Tool enables developers to test TikTok Shop Open APIs directly in Partner Center.
You can use it to:

* select APIs and versions supported by the tool;
* fill query, header, path, and body parameters;
* send requests and inspect responses;
* validate whether your app key, scopes, authorization, token, and request parameters are correct;
* copy generated sample code, such as a `curl` request, when using your own app key.

The API Testing Tool is useful for manual validation and debugging. For production integrations, continue to implement signing, token refresh, retry, logging, and error handling in your own backend.
### Entry points
Use one consistent naming convention:
**Partner Center Console > Development Kits > API Testing Tool**
You can also open the direct entry:
[API Testing Tool](https://partner.tiktokshop.com/dev/api-testing-tool)
Do not confuse the tool entry with app configuration:
| Task | Partner Center path |
| --- | --- |
| Open the API Testing Tool | **Development Kits > API Testing Tool** |
| Find your app key | **App & Service > Manage > App details** |
| Configure API scopes | **App & Service > Manage > Manage API** |
| Authorize a test shop or seller | Use the API Testing Tool authorization flow, or follow Authorization Guide. |
If older screenshots use **Partner Console**, **Partner Center**, **Development**, or **Development Kits** inconsistently, treat **Partner Center Console** as the product area name and **Development Kits > API Testing Tool** as the tool entry.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/43e04e10d604411197ee5440c10497b3~tplv-k9wyc2ijk0-image.image)
### Choose an app key mode
| Mode | Best for | Supports | Limitations |
| --- | --- | --- | --- |
| Platform app key | Quick exploration before creating or selecting your own app. | Basic read-only `GET` API testing supported by the platform key. | Does not represent your app's scopes, authorizations, or market access. The tool may not provide generated request demo/sample code for this mode. |
| Your own app key | Realistic app debugging and integration validation. | App-specific API scopes, seller/test-shop authorization, access token, and generated sample code. | Requires app setup, scope configuration, and authorization before the call can succeed. |
### Using the platform app key
The platform app key is a built-in option in the API Testing Tool for basic API exploration. It lets developers try supported read-only APIs without first selecting their own app key.
Use it only for quick checks. It does not prove that your own app has access to the same endpoint. For app-specific testing, use your own app key.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/2eb30f87ee764689a1d6f4dddabe875f~tplv-k9wyc2ijk0-image.image)
### Using your own app key
Use your own app key when you need to validate your actual app configuration, seller/test-shop authorization, request parameters, and generated sample code.
#### Setup steps

1. Log in to [TikTok Shop Partner Center Console](https://partner-sso.tiktok.com/account/login).
2. Go to **App & Service > Manage > App details** and copy your **App Key**.
3. Go to **App & Service > Manage > Manage API** and enable or apply for the required API scope.
4. Authorize the seller or test shop for the app.
5. Open **Development Kits > API Testing Tool**.
6. Select **Use your own app key** and choose or paste your app key.
7. Select the API and API version you want to test.
8. Fill required query, path, header, and body parameters.
9. Fill the access token in the token/header field shown by the tool. For `202309` and later APIs, this is usually the `x-tts-access-token` header.
10. Send the request and inspect the response.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/124df2df16f1473ebacf959a88505e8d~tplv-k9wyc2ijk0-image.image)
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/99352b7e4739481e8f0d955583f64bf4~tplv-k9wyc2ijk0-image.image)
#### Authorization and access token options
Your own app key must be authorized before you can test APIs that require seller, shop, creator, or partner data.
You have two options:
| Option | How it works | When to use |
| --- | --- | --- |
| Tool authorization flow | Use the authorization function provided in the API Testing Tool to authorize the test shop or seller, then continue testing in the tool. | Fastest path for tool-based manual testing. |
| Manual authorization flow | Follow Authorization Guide, obtain an `access_token`, and paste it into the API Testing Tool token/header field. | Use when you need to reproduce your real OAuth flow or debug token exchange. |
When manually backfilling a token, paste the `access_token` into the request token field shown by the API Testing Tool. For `202309` and later APIs, this maps to the `x-tts-access-token` header. Do not paste the refresh token into the request token field.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/5fc05b9d5fbb4fe09944fbb4980e8be9~tplv-k9wyc2ijk0-image.image)
### Tips for using the API Testing Tool
| Tip | How to use it | Demo |
| --- | --- | --- |
| Documentation guide | When selecting an API, use the documentation guide to jump from the testing tool to the endpoint reference. When an API error occurs, use the error documentation guide to identify the likely issue and next step. | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/427ca078185944a6ae2cbed42e7af561~tplv-k9wyc2ijk0-image.image)    ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/3bf3df94b13e449a9a164015cb817b63~tplv-k9wyc2ijk0-image.image) |
| Sample code | When using your own app key, copy the generated request demo, such as `curl`, and run it in a terminal to reproduce the same request outside Partner Center. This is useful for comparing tool behavior with your backend implementation. | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/b9883c37938b4d119ffd120c85d9352b~tplv-k9wyc2ijk0-image.image)    ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/5ac394c4c7544b30bed4d4bfedea3d09~tplv-k9wyc2ijk0-image.image) |
### Quick troubleshooting flow

1. Confirm you are using the correct app key.
2. Confirm the endpoint's required API scope.
3. Confirm that the scope is enabled or approved in **App & Service > Manage > Manage API**.
4. Confirm that the seller or test shop has authorized the app after the scope was enabled.
5. Confirm that the access token is pasted into the correct request token/header field.
6. Confirm that the request method, path, API version, query parameters, body, and required identifiers such as `shop_cipher` match the endpoint reference.
7. If the same request works in the API Testing Tool but fails in your backend, compare the generated sample code with your backend signing, headers, token, and body serialization.


---

## Developer tools > Developer dashboard

Doc: https://partner.tiktokshop.com/docv2/page/developer-dashboard · cập nhật 2026-07-06

### What this dashboard is
The Developer Dashboard helps developers monitor order-quality incidents found by TikTok Shop reconciliation checks. It is intended to answer three questions:

1. Which orders have already been cancelled because the shipping SLA was missed?
2. Which active orders are at risk of missing the shipping SLA or have inconsistent fulfillment data?
3. Which rule triggered each incident, so the developer can repair the integration and close the incident with the correct reason?

Use this dashboard together with your order, fulfillment, and tracking integrations. The goal is to prevent seller revenue loss, reduce late-dispatch cancellations, and keep incident close rate healthy.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/6a2c9069067a46fc9dd43fa4c3aa5eae~tplv-k9wyc2ijk0-image.image)
### How to use the dashboard

1. Review A-LOC incidents first. These orders have already been system-cancelled because the shipping SLA was missed.
2. Review Risk Order incidents before the SLA expires. These orders may still be recoverable if the order, fulfillment, or tracking data is corrected in time.
3. Use the rule ID to identify the likely integration issue. For example, a missing external order points to order-sync failure, while tracking present externally but missing in TikTok Shop points to fulfillment-sync failure.
4. Fix the root cause in the external system or integration workflow.
5. Submit incident feedback and close the incident with the correct reason code.

### Integration boundary
Quality Engine is TikTok Shop's reconciliation system. Developers do not operate the reconciliation logic directly. Developer-facing integration happens through the Developer Dashboard, incident records, and Quality Engine data exchange APIs.
Developers are responsible for keeping the external platform data aligned with TikTok Shop, including:

* order creation and order status
* package and fulfillment status
* tracking number and carrier updates
* incident feedback and closure reason

TikTok Shop is responsible for calculating incident rules, exposing incident records, and showing dashboard metrics. For API details, refer to the [Quality Engine Order Data Exchange API documentation](https://bytedance.sg.larkoffice.com/docx/A6qMdwPC5oESvkxLuffcAVMbnLc).
### Terminology
| Term | Meaning |
| --- | --- |
| TikTok Shop / TTS | TikTok Shop order and fulfillment data. |
| External platform / DTC platform | The developer, merchant, ERP, OMS, WMS, or DTC system that receives TikTok Shop orders and handles downstream fulfillment. |
| Quality Engine | TikTok Shop's reconciliation system that compares TikTok Shop order data with external platform data and surfaces developer-facing incidents. |
| SLA | Service level agreement. In this context, it is the latest time by which an order must be shipped or updated. |
| `shipping_due_time` | The shipping deadline for an order. If the order is not shipped or updated before this deadline, it may be cancelled by the system. See [SLA information in Orders API](https://partner.tiktokshop.com/docv2/page/sla-information-now-available-in-orders-api). |
| `tts_sla` | The SLA deadline maintained by TikTok Shop and used in risk-order rules. |
| Tracking number | The package tracking number stored in TikTok Shop or in the external platform. |
| `system_cancel_order_reason_shipping_timeout` | Cancellation reason used when TikTok Shop system-cancels an order because the shipping SLA was missed. |
| FC-101 to FC-105 | Quality Engine reason codes used when an order is not found in the external platform for a recognized reason. Confirm the exact reason definition in the incident reason-code documentation. |
| Incident close rate | The percentage of incidents that the developer has reviewed, resolved, and closed with feedback. |
### Metrics
#### A-LOC rate
A-LOC stands for App Caused Late Dispatch. It measures TikTok Shop orders that were cancelled because the shipping SLA was missed due to an app or integration issue.
Text formula:
```Plain Text
A-LOC rate = A-LOC order count / eligible TikTok Shop order count in the selected period * 100%
```

Partner target: keep A-LOC rate below `0.01%`.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/52b653121bf04dae9b2b53f4cb532447~tplv-k9wyc2ijk0-image.image)
#### Risk Order rate
Risk Orders are active TikTok Shop orders that may miss the shipping SLA or have inconsistent order, fulfillment, or tracking data between TikTok Shop and the external platform. These incidents should be handled before the SLA expires.
Text formula:
```Plain Text
Risk Order rate = Risk Order incident count / eligible TikTok Shop order count in the selected period * 100%
```

If a dashboard export or API response provides a more specific denominator for a metric, use the denominator returned by that source.
### A-LOC incident statistics
A-LOC incidents are already cancelled orders. They indicate that TikTok Shop did not receive the required shipping update before `shipping_due_time`, and the order was system-cancelled with `system_cancel_order_reason_shipping_timeout`.
The A-LOC rule table compares three data points:

* TikTok Shop order status and cancellation reason
* whether the order exists in the external platform
* whether tracking exists in TikTok Shop and in the external platform

| Rule ID | TikTok Shop order status | TikTok Shop cancel reason | TikTok Shop tracking number | External platform order status | External platform tracking number | Meaning / likely issue |
| --- | --- | --- | --- | --- | --- | --- |
| A1 | Cancelled | `system_cancel_order_reason_shipping_timeout` | Empty | Order not found | N/A | The order was cancelled before it was created or synced to the external platform. Check order ingestion and retry logic. |
| A2 | Cancelled | `system_cancel_order_reason_shipping_timeout` | Empty | Order exists | Empty | The order reached the external platform, but no tracking was available before the shipping deadline. Check fulfillment processing. |
| A3 | Cancelled | `system_cancel_order_reason_shipping_timeout` | Empty | Order exists | Present | The external platform had tracking, but tracking was not synced back to TikTok Shop before timeout. Check fulfillment-status and tracking sync. |
| A4 | Cancelled | `system_cancel_order_reason_shipping_timeout` | Present | Order exists | Present | Both sides have tracking, but the order was still cancelled. Check update timing, SLA calculation, and data consistency across systems. |
### Risk Order incident statistics
Risk Order incidents are active orders that need action before they become A-LOC cancellations. They are usually caused by missing external orders, missing tracking, tracking-sync delay, or SLA deadline risk.
Use the rule group to prioritize action:

* R0, R5, and R6: tracking exists externally but is missing or not aligned in TikTok Shop.
* R1 and R2: the order is missing in the external platform.
* R3, R4, and R7: the order is close to or past its SLA threshold.

| Rule ID | TikTok Shop order status | TikTok Shop tracking number | External platform order status | External platform tracking number | SLA condition | Meaning / recommended action |
| --- | --- | --- | --- | --- | --- | --- |
| R0 | On hold | Empty | Order exists | Present | N/A | External tracking exists while TikTok Shop still has no tracking. Confirm whether tracking should be pushed to TikTok Shop. |
| R1 | Awaiting shipment | N/A | No related order | N/A | Not-existing reason is empty or one of FC-101 to FC-105 | The order is missing in the external platform. Check order-sync failures and whether the not-existing reason is valid. |
| R2 | Partially shipping | N/A | No related order | N/A | Not-existing reason is empty or one of FC-101 to FC-105 | A partial-shipment order is missing in the external platform. Check partial fulfillment and order-sync logic. |
| R3 | Awaiting shipment | Empty | Order exists | Empty | Current time is later than `tts_sla - 1 day`, and `tts_sla` is not `0` | Less than one day remains before SLA, and no tracking exists on either side. Prioritize fulfillment and tracking creation. |
| R4 | Partially shipping | Empty | Order exists | Empty | Current time is later than `tts_sla - 1 day`, and `tts_sla` is not `0` | A partially shipped order is close to SLA and has no tracking. Prioritize remaining package fulfillment. |
| R5 | Awaiting shipment | Empty | Order exists | Present | N/A | External tracking exists but was not synced to TikTok Shop. Push tracking and verify fulfillment-status sync. |
| R6 | Partially shipping | Empty | Order exists | Present | N/A | External tracking exists for a partially shipped order but is missing in TikTok Shop. Check package-level tracking sync. |
| R7 | Awaiting collection | Present | Order exists | Present | Current time is later than the TikTok Shop order SLA | Tracking exists on both sides, but the order has missed the expected SLA progress. Check carrier handoff, collection status, and status-sync timing. |
### Incident feedback and close process
After fixing the root cause, submit incident feedback and close the incident in the Developer Dashboard or through the relevant Quality Engine workflow.
Use the rule ID, order details, and root cause to select the correct close reason. See the [Quality Engine Incident Reason Code](https://partner.tiktokshop.com/docv2/page/660bf931cf5cc502e03007ca) reference.
### Developer checklist

* Confirm that all TikTok Shop orders are created in the external platform on time.
* Confirm that fulfillment and tracking updates are pushed back to TikTok Shop before `shipping_due_time`.
* Monitor Risk Order incidents daily and resolve them before they become A-LOC cancellations.
* Use A-LOC incidents for root-cause analysis and integration reliability improvements.
* Close incidents with accurate feedback and reason codes after remediation.

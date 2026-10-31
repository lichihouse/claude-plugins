# Developer Guide — Get started

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.



---

## Get started > Get started overview

Doc: https://partner.tiktokshop.com/docv2/page/tts-developer-types · cập nhật 2026-06-25

This page introduces the **types of TikTok Shop developers** and points you to the rest of the getting-started path. After you've identified your developer type below, continue to Developer onboarding, then Authorization, and finally Make your first API call.
#### The three developer types
| Developer type | Builds | Stores seller OAuth credentials? | Data access | Typical scenario |
| --- | --- | --- | --- | --- |
| **eCommerce platform plugin / connector developer** | Public app | Usually no | Limited, scenario-specific | Plugins for Shopify, WooCommerce, Magento that add TikTok Shop support |
| **eCommerce system integrator / SaaS developer** | Public app | Yes (trusted to store bearer & refresh tokens) | Direct access to authorized sellers' data | SaaS managing advertising, promotion, marketing, and operations for many sellers |
| **TikTok Shop seller developer** | Custom app | Own credentials only | Your own shop's data only | A seller building an integration for their own shop |
#### eCommerce platform developers
Developers who create plugins for popular eCommerce platforms such as Shopify, WooCommerce, or Adobe Magento. These plugins extend the platform to support a specific marketplace such as TikTok Shop. This type typically does **not** need to store seller OAuth credentials or data.
#### eCommerce system integrators
Developers who build systems to manage advertising, product promotion, marketing, and other business functions on behalf of their seller and merchant customers. Some are SaaS products with a user interface; others manage operations directly. This type typically requires **direct access** to a seller's data and is trusted to store and generate OAuth credentials such as bearer and refresh tokens.
#### TikTok Shop seller developers
TikTok Shop sellers who have an active shop and want to build an integration for their own shop's needs. This type has access to **their own** OAuth credentials and data only.
#### How developer type maps to `user_type`
When a user authorizes your app, the token response includes a `user_type` field. Platform/integrator developers act on behalf of a **Seller** (`user_type=0`); apps built for affiliate creators receive **Creator** (`user_type=1`); affiliate partner (TAP) apps receive **Partner** (`user_type=3`). See Authorization overview for the complete enumeration.
> **New to OAuth terms?** An *OAuth credential* is what your app uses to act for a user. A *bearer (access) token* authorizes each API call; a *refresh token* lets you obtain a new access token without re-authorizing. The full flow is described in the Authorization overview.

#### Next steps
Your complete getting-started path:

1. [Developer onboarding](https://partner.tiktokshop.com/docv2/page/developer-onboarding) — create your account and register as a developer.
2. [Authorization overview](https://partner.tiktokshop.com/docv2/page/authorization-overview-202407) — understand how apps get access to user data.
3. [Make your first API call overview](https://partner.tiktokshop.com/docv2/page/make-your-first-api-call-overview) — sign and send your first request.


---

## Get started > App Category Selection Guide

Doc: https://partner.tiktokshop.com/docv2/page/hulvi36o · cập nhật 2026-09-01

#### 1. Overview (What & Why)
**App Category** is the business classification you must select when creating an app in TikTok Shop Partner Center. It describes the primary business scenario your application is designed to serve.
Choosing the right category typically affects:

* **Available API Scope**: The default set of API capabilities you can apply for varies by category.
* **App Store positioning**: The category helps merchants understand what your app does and whether it fits their needs.
* **Target user matching**: An accurate category helps the right merchants discover your app faster.

**Intended audience:**

* Third-party ISVs (Independent Software Vendors)
* Seller in-house development teams

**Important — this choice is irreversible**: Once an App Category is selected, **it cannot be changed through any channel**. If you choose the wrong category, you must create a new app. Please confirm carefully before creating your app. This same constraint is reiterated when you create your app.

#### 2. How to Choose Your App Category (Capability Matrix)
The table below lists every App Category and the core business capabilities each one covers by default, so you can quickly identify the best match for your business scenario.

* **✓** — Included by default in the category's main API Scope.
* **✗** — Not included, or only minimally covered.
* **–** — Public information is currently insufficient; refer to the actual Partner Center application page.

| L1 Category | Category | Best for | When to choose this category | Related API capability area |
| --- | --- | --- | --- | --- |
| eCommerce Management | **Connectors** | system integration, data synchronization, and broad commerce workflow connectivity across products, orders, fulfillment, finance, marketing, and business data | Choose this category when the app primarily provides system integration, data synchronization, and broad commerce workflow connectivity across products, orders, fulfillment, finance, marketing, and business data. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| eCommerce Management | **Enterprise Resource Planning** | ERP and store operation systems that centralize product, inventory, order, fulfillment, finance reconciliation, and business data workflows | Choose this category when the app primarily provides ERP and store operation systems that centralize product, inventory, order, fulfillment, finance reconciliation, and business data workflows. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| eCommerce Management | **Multi-Channel Management** | multi-channel or multi-store tools that synchronize products, inventory, orders, and fulfillment status across sales channels | Choose this category when the app primarily provides multi-channel or multi-store tools that synchronize products, inventory, orders, and fulfillment status across sales channels. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| eCommerce Management | **Print On Demand** | print-on-demand providers that receive orders, sync customized product information, and track production and fulfillment | Choose this category when the app primarily supports print-on-demand workflows, including order receiving, customized product information synchronization, production tracking, and fulfillment updates. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| eCommerce Management | **Dropshipping** | dropshipping or supply-chain fulfillment providers that sync products, orders, inventory, and fulfillment information for sellers | Choose this category when the app primarily supports dropshipping or supply-chain fulfillment workflows, including product, order, inventory, and fulfillment information synchronization for sellers. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| eCommerce Management | **Semi Consignment** | semi-consignment services that support product, order, fulfillment, or reconciliation workflows under a semi-managed operating model | Choose this category when the app primarily supports semi-consignment services, including product, order, fulfillment, or reconciliation workflows under a semi-managed operating model. | Availability may vary by app capability. Confirm the available scopes on the Partner Center application page before publishing. |
| Customer Engagement | **Promotions** | promotion and campaign tools that help sellers create, manage, or analyze discounts, campaigns, and conversion performance | Choose this category when the app primarily provides promotion and campaign tools that help sellers create, manage, or analyze discounts, campaigns, and conversion performance. | Some Customer Engagement capabilities may require platform enablement. If you need to use these capabilities, contact TikTok Shop to confirm availability and opening conditions. |
| Customer Engagement | **Customer Reviews** | review management tools that help sellers view, analyze, and manage product or shop reviews | Choose this category when the app primarily provides review management tools that help sellers view, analyze, and manage product or shop reviews. | Some Customer Engagement capabilities may require platform enablement. If you need to use these capabilities, contact TikTok Shop to confirm availability and opening conditions. |
| Customer Engagement | **Creator collaborations** | creator collaboration and affiliate marketing tools that help sellers discover creators, manage collaboration content, and track results | Choose this category when the app primarily provides creator collaboration and affiliate marketing tools that help sellers discover creators, manage collaboration content, and track results. | Availability may vary by app capability. If you need to use these capabilities, contact TikTok Shop to confirm availability and opening conditions. |
| Customer Engagement | **Loyalty & Rewards** | loyalty, points, reward, and retention tools that help sellers improve repeat purchase and customer lifetime value | Choose this category when the app primarily provides loyalty, points, reward, and retention tools that help sellers improve repeat purchase and customer lifetime value. | Some Customer Engagement capabilities may require platform enablement. If you need to use these capabilities, contact TikTok Shop to confirm availability and opening conditions. |
| Customer Engagement | **Video Editor** | video editing tools that help sellers or partners create and optimize commerce-related video assets | Choose this category when the app primarily provides video editing tools that help sellers or partners create and optimize commerce-related video assets. | Availability may vary by app capability. If you need to use these capabilities, contact TikTok Shop to confirm availability and opening conditions. |
| Customer Engagement | **LIVE Shopping** | LIVE commerce tools that support product listing, live operation, and conversion during livestream selling | Choose this category when the app primarily provides LIVE commerce tools that support product listing, live operation, and conversion during livestream selling. | Some Customer Engagement capabilities may require platform enablement. If you need to use these capabilities, contact TikTok Shop to confirm availability and opening conditions. |
| Customer Engagement | **Shoppable Content** | shoppable content tools that support commerce-enabled videos, content publishing, or product-led content experiences | Choose this category when the app primarily provides shoppable content tools that support commerce-enabled videos, content publishing, or product-led content experiences. | Some Customer Engagement capabilities may require platform enablement. If you need to use these capabilities, contact TikTok Shop to confirm availability and opening conditions. |
| Customer Service | **Customer Support** | customer service systems that manage buyer inquiries, after-sales issues, message routing, and service quality | Choose this category when the app primarily provides customer service systems that manage buyer inquiries, after-sales issues, message routing, and service quality. | Customer Service, Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic and more. |
| Merchandising | **Product Design & Sourcing** | product discovery, design, and sourcing tools that help sellers identify product opportunities or manage suppliers | Choose this category when the app primarily provides product discovery, design, and sourcing tools that help sellers identify product opportunities or manage suppliers. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| Merchandising | **Optimization** | store and operation optimization tools that provide diagnosis, recommendations, or automation based on product, order, traffic, or business data | Choose this category when the app primarily provides store and operation optimization tools that provide diagnosis, recommendations, or automation based on product, order, traffic, or business data. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| Shipping & Fulfillment | **Order Management(OMS/WMS)** | OMS, WMS, and warehouse operation systems that manage order sync, picking, packing, shipping, inventory, and warehouse tasks | Choose this category when the app primarily provides OMS, WMS, and warehouse operation systems that manage order sync, picking, packing, shipping, inventory, and warehouse tasks. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| Shipping & Fulfillment | **Shipping** | shipping, logistics, and carrier integration tools that create shipping labels, update package status, and improve fulfillment efficiency | Choose this category when the app primarily provides shipping, logistics, and carrier integration tools that create shipping labels, update package status, and improve fulfillment efficiency. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| Shipping & Fulfillment | **Returns** | returns, refund, and reverse-logistics tools that manage after-sales requests, return flows, package tracking, and refund coordination | Choose this category when the app primarily provides returns, refund, and reverse-logistics tools that manage after-sales requests, return flows, package tracking, and refund coordination. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| Shipping & Fulfillment | **Fulfilled by TikTok(FBT)** | FBT-related fulfillment services that support inventory, inbound, outbound, shipping, and status synchronization | Choose this category when the app primarily provides FBT-related fulfillment services that support inventory, inbound, outbound, shipping, and status synchronization. | Availability may vary by app capability. Confirm the available scopes on the Partner Center application page before publishing. |
| Finance | **Finance** | finance management tools that access transaction, payment, statement, withdrawal, and settlement information | Choose this category when the app primarily provides finance management tools that access transaction, payment, statement, withdrawal, and settlement information. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| Finance | **Accounting** | accounting, tax, and reconciliation systems that sync transaction, payment, and settlement data into finance workflows | Choose this category when the app primarily provides accounting, tax, and reconciliation systems that sync transaction, payment, and settlement data into finance workflows. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| Livestream Tool | **Livestream Tool** | livestream operation tools that support live product management, live analytics, or live conversion operations | Choose this category when the app primarily provides livestream operation tools that support live product management, live analytics, or live conversion operations. | Availability may vary by app capability. Confirm the available scopes on the Partner Center application page before publishing. |
| System Integrator | **System Integrator** | system integrators that connect TikTok Shop with external systems based on seller business needs | Choose this category when the app primarily provides system integration services that connect TikTok Shop with external systems based on seller business needs. | Availability may vary by app capability. Confirm the available scopes on the Partner Center application page before publishing. |
| Catalog | **Product Listing** | product listing tools that create, edit, sync, and manage TikTok Shop product information | Choose this category when the app primarily provides product listing tools that create, edit, sync, and manage TikTok Shop product information. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| Catalog | **Product Information Management** | PIM systems that centralize product attributes, images, descriptions, and multi-channel product data | Choose this category when the app primarily provides PIM systems that centralize product attributes, images, descriptions, and multi-channel product data. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| Catalog | **Digital Asset Management** | digital asset management tools that organize product images, videos, descriptions, and marketing assets | Choose this category when the app primarily provides digital asset management tools that organize product images, videos, descriptions, and marketing assets. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| Marketing | **CRM** | CRM tools that manage buyer interactions, service history, and marketing engagement workflows | Choose this category when the app primarily provides CRM tools that help sellers manage buyer interactions, service history, and marketing engagement workflows. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
| Marketing | **Ads** | advertising and marketing management tools that support ad creation, campaign optimization, budget management, and performance analysis | Choose this category when the app primarily provides advertising and marketing management tools that support ad creation, campaign optimization, budget management, and performance analysis. | Availability may vary by app capability. Confirm the available scopes on the Partner Center application page before publishing. |
| Marketing | **Analytics & Reporting** | analytics and reporting tools that aggregate product, order, fulfillment, finance, marketing, and business performance data | Choose this category when the app primarily provides analytics and reporting tools that aggregate product, order, fulfillment, finance, marketing, and business performance data. | Finance Information, Fulfillment Basic, Logistics Basic, Manage Seller Redeem Info Callback, Order Information, Package Split And Combine, Product Basic, Return & Refund Basic and more. |
> Note on Customer Service: Among the categories above, only **Seller in-house developer** includes Customer Service by default. If your ISV use case requires Customer Service scopes, confirm availability on the Partner Center application page and through app review. The matrix reflects default scope coverage only.

#### 3. Category vs. API Scope (Quick Reference)
The App Category determines the **default set of API Scopes** you can apply for after creating your app. Some sensitive or restricted scopes may require additional review or platform enablement. Choose a category based on your business positioning first, then verify whether the capabilities you need are available on the app creation page.
If a scope you need is not listed under your category, that **does not necessarily** mean it is unavailable. Refer to the Partner Center page and the actual review outcome. For restricted capabilities, contact your TikTok Shop account manager or official support to confirm the opening conditions.
#### 4. FAQ
##### Q1. Which category should I choose?
**A:** Pick the one that best represents your **primary business scenario**:

* I build eCommerce / ERP integrations → **eCommerce Management**
* I build logistics / fulfillment solutions → **Shipping & Fulfillment**
* I build marketing / advertising tools → **Marketing**
* I am a seller building for my own shop → **Seller in-house developer**
* I run fully-managed or cross-market integrated services → **Global Selling**

If your product spans multiple directions, choose the one that most accurately represents your **core product value**.
##### Q2. Can I change the category after creating the app?
**A: No.** Once selected, the category is locked and **cannot be changed through any channel**. If you choose the wrong category, you must create a new app.
##### Q3. Does the category determine which API Scopes I can apply for?
**A:** Yes. Each category comes with a default set of applicable API scopes. Some sensitive or restricted capabilities may also require additional review or platform enablement.
##### Q4. What's the difference between **Seller in-house developer** and ISV categories?
**A:**

* **Seller in-house developer** is for **a seller's in-house team** — apps that **only serve their own shop**.
* **ISV / third-party categories** are for apps that **serve multiple merchants** and are offered to external sellers.

##### Q5. Some scopes I need are missing from my category — are they unavailable?
**A:** Not necessarily. Category scope coverage may change over time. If you don't see a scope you need, confirm availability with your account contact or through official support.
##### Q6. Will choosing the wrong category affect my review?
**A:** Yes. A category that doesn't match your actual business may **restrict the API scopes you can apply for** and may affect app review and listing efficiency.
##### Q7. Will the category names change over time?
**A:** Yes. As the product evolves, categories may be **added, merged, or renamed**. Always refer to the latest options shown in the Partner Center UI.
##### Q8. I cover product management, fulfillment, and analytics — which one should I pick?
**A:** Choose the **most core, stable, and frequently-used** primary capability. If your main value proposition is system integration and operational orchestration, **eCommerce Management** is usually the best fit.
##### Q9. My app only serves my own shop — should I still pick an ISV-oriented category?
**A:** Generally no. If your app is used **only for your own shop internally**, **Seller in-house developer** is the more appropriate choice.
##### Q10. What kind of apps fit Global Selling?
**A:** Apps designed for **cross-market operations, fully-managed services, or comprehensive end-to-end solutions**.
#### 5. Quick Recommendation
| If you are… | Recommended Category |
| --- | --- |
| Building an integration / ERP / order-management connector for multiple merchants | **eCommerce Management** |
| Focused on product creation, sourcing, or listing optimization | **Merchandising** / **Catalog** |
| Building shipping, FBT, OMS / WMS, or returns workflows | **Shipping & Fulfillment** |
| Building promotions, loyalty, content commerce, LIVE, or affiliate tools | **Customer Engagement** |
| Building reconciliation, settlement, or accounting tools | **Finance** |
| Building ads, CRM, or analytics solutions | **Marketing** |
| A seller building an app **only for your own shop** | **Seller in-house developer** |
| Building cross-market / fully-managed comprehensive services | **Global Selling** |
> Final API scope availability is determined by the actual application review in Partner Center. When in doubt, contact your TikTok Shop account manager or official support before locking your category.


---

## Get started > Tiktok Shop Seller Developer > Seller Developer Onboarding Onepager

Doc: https://partner.tiktokshop.com/docv2/page/seller-developer-onboarding-onepager · cập nhật 2026-10-30

### Part 1: Onboarding Overall

1. [API list](make-your-first-api-call-overview).
2. [App development guide](connector-multi-channel-dropshipping-and-print-on-demand).

#### Seller developer onboarding guide
##### TikTok Shop business flow
Learn about what TikTok Shop API can do - user journey
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/app_development_guide/user_journey.png)

##### Definition and basic business introductions

* **TikTok Shop**: TikTok Shop lets sellers, brands and creators sell products through videos, LIVE streams, product showcases and the Shop tab in supported markets.
* [TikTok Shop Partner Center (TTSPC)](https://partner.tiktokshop.com/): Build apps and integrations with TikTok Shop APIs to manage your business. Sellers can connect their own shops to their apps.
* **TikTok Shop** seller developers**:** Choose this type to build Custom Apps (privately distributed apps) and services for your own TikTok Shop operations.

##### Prerequisites for Becoming a Seller Developer
Before applying, check the following requirements.

1. You already have a TikTok Shop seller account that has passed KYB (business entity verification) or KYC (individual identity verification).
2. Your registration depends on your seller type, market and eligibility, as shown below. AM (Account Manager) support alone does not exempt a seller from qualification review.

###### Seller Developer eligibility and qualification flow
The platform checks GKA (key-merchant allowlist) first. Each Global Seller (merchant account) can contain several Seller records, each associated with an operating market.
Eligible local sellers in Thailand (TH), Singapore (SG), the Philippines (PH), Vietnam (VN), Indonesia (ID) and Malaysia (MY) follow Normal (standard qualification review) if they have only one Seller record. Other local and cross-border sellers need AM or SKM (strategic key merchant) eligibility.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/15e8ab3daaa84d3ca2689f9f992cc13b~tplv-k9wyc2ijk0-image.image)

Successful email or phone verification confirms your seller account. Registration then follows these rules:
| Order | Seller account conditions | Onboarding result |
| --- | --- | --- |
| 1 | The seller has GKA eligibility. | Automatic qualification approval for supported markets. |
| 2 | Not GKA; local seller; one Seller record under the verified Global Seller account; operating in TH, SG, PH, VN, ID or MY. | Normal qualification review: link your seller account, complete the entity form and submit the required documents. AM or SKM eligibility does not exempt this group from review. |
| 3 | Other local or cross-border sellers with AM or SKM eligibility. | Automatic qualification approval for supported markets. |
| 4 | Not GKA, outside the Normal group, and without AM or SKM eligibility. | Seller Developer registration is unavailable (error 36010071). This application cannot proceed to document review. |
**How to read the conditions:** Use the Seller’s actual market when checking eligibility. “One Seller” means one record under the Global Seller account, regardless of email addresses or registered markets.
**Eligibility terms:** AM, GKA and SKM eligibility is assigned by the platform; it cannot be selected on the registration form.
**Requirements shared by all branches:** Seller accounts must meet the platform’s status, ownership, owner-account, account-linking and market requirements. Completing qualification review does not publish your App or grant API Scopes (API permissions).
**Examples:** A non-GKA local seller in Vietnam with one Seller record follows Normal review, even with AM or SKM. Cross-border sellers in Vietnam still need AM, SKM or GKA eligibility.
**Documents and stages:** Follow the Seller Developer form to submit your entity documents. If a requested document is unavailable, ask support about accepted alternatives. Draft means the application has not been submitted; Approved means the qualification has passed review. An App Key identifies your App and does not confirm qualification approval.
###### Step 1: Use your Seller Account to Login TikTok Shop Partner Center
**Access to TTSPC: https://partner.tiktokshop.com/**

* **If you have a US business license, and the seller type is US local, please access** **to US TikTok Shop Partner Center(TTSPC) https://partner.us.tiktokshop.com/**
* **For other situations, please refer to https://partner.tiktokshop.com/**
* Set up a Partner Center account with your email address and, optionally, your phone number. Keep your email address current to receive platform updates.

###### Step 2: Register as TikTok Shop seller developer
|  | Description | Screenshot |
| --- | --- | --- |
| 1 | After creating an account/**Login with your Seller Center account**, you'll find a business guide tailored to different partner types. Pick "For TikTok Shop Seller" as your partner type from this guide, click on 'Start Business,' and it will lead you to the 'Get Started' page to initiate your application for your selected category. |   ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/e1542aa62440407ea3f9e24fa546eff0~tplv-k9wyc2ijk0-image.image)   |
| 2 | Click on " Start Business" to start your partner application. | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/f89cf2d0398c4ccca2c6a135efb012aa~tplv-k9wyc2ijk0-image.image)   |
| 3 | As a first step, TikTok Shop needs to know what type of Apps you plan to build for sellers. **Please choose the target seller market and category**. Please choose 「TikTok Shop Seller」as the business category. | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/7d4c4da660844603a350f9321fc7646a~tplv-k9wyc2ijk0-image.image)   |
| 4 | Please verify your seller account with login and password (email or phone number). TikTok Shop Partner Center will verify the account automatically.  If you log in with your Seller Center account, the platform may identify the linked Seller automatically. Eligibility checks and any required qualification review still apply. | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/8a3636c180294ed39088e8d588a5cd40~tplv-k9wyc2ijk0-image.image)  ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/e1122cc3d97846e38b0fcaf233b4c6f8~tplv-k9wyc2ijk0-image.image) |
| 5 | When you are verified, you will see the tag of "TikTok Shop seller" under My Account page. You should have a TikTok Shop seller account first | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/7e359bdd8cc247d3a4c46d7c2effcee3~tplv-k9wyc2ijk0-image.image)   |
###### Step 3: Verify seller account
> If you log in with your Seller Center account, the platform may identify the linked Seller automatically. Seller eligibility, account-linking checks and any required qualification review still apply.

1. Fill the basic info and verify seller account
* ⚠️ You can only verify the TikTok Shop seller account which passes the KYB/KYC review

![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/app_development_guide/step3-1.png)

###### 
###### Step 4: Create an App
|  | **Description** | **Screenshot** |
| --- | --- | --- |
| 1 | Select **App & Service** from the navigation panel.  Click the「**Create app & service」**button in the top right corner of the page. The Partner Center displays the「Create app & service」page. |    |
| 2 | **B**uild a Custom App for your business. It is shared through an authorization link and is not listed in the TikTok Shop App Store. | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/e0aae734602a49c8996be0d480ef57dc~tplv-k9wyc2ijk0-image.image)   |
| 3 | Select the **Service category** and set the **default name** of your App. Optionally, upload a logo for your App. Please choose 「**TikTok Shop** **Seller**」as the business category. | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/e2e7a7b854e148fa903123c4ea03bd0e~tplv-k9wyc2ijk0-image.image)   |
| 4 | Select the **Market** and set the **seller type** for your App. | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/cc937df2a96d496fa6564ec41035c4b5~tplv-k9wyc2ijk0-image.image)   |
| 5 | Toggle the **Enable API** switch on and complete the following fields. Otherwise, skip to the next step.  **Redirect URL** Enter the URL at which to receive your authorization code. After the seller authorize the App, it will jump to this URL (it can be the URL of your system's web page) and transmit the `auth_code`, which you can use to get the access_token (API access token).  **Webhook** **URL** Optionally, enter the URL to receive [push notifications](https://partner.tiktokshop.com/doc/page/63fd743d715d622a338c4e60?onlySelectedDir=13623) (it can be the URL of your system). | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/cc937df2a96d496fa6564ec41035c4b5~tplv-k9wyc2ijk0-image.image) |
| 7 | Click **Create** to complete the process. After you create your App, Partner Center displays the App and service detail page. Here you can access your App's unique App key and secret, which allow you to complete [seller authorization](authorization-overview-202407) and [API calls](make-your-first-api-call-overview).  **App Key** - The unique identification of the service.  - **App Secret** - The application key generated by the platform when you create an App. You can use this secret to obtain the API access token. |  |
##### Step 6: Test your App
Before you can launch your App, you must test it thoroughly with TikTok Shop's Seller Center functionality. We offer the following developer tools that you can use to test your App's functionality with Seller Center.

* Development Shop (previously known as Sandbox)
* API Testing Tool

The Development Shop (previously known as Sandbox) tools in the Partner Center allow you to build and test your apps by simulating various seller workflows without impacting real shop data, while the API Testing Tool allows you to access API request and response parameters.
**Set up Development Shop**

The following **configuration on a web browser or system host files** will enable you to connect to the testing environment of TikTok Shop, so that you can create test shops, test API integrations before general availability.
**Custom App**

![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/app_development_guide/step6.png)

With Development Shop, developers can gain access to all production environment features, including returns, refunds, promotions, and customer support functionality.
**Learn more:** [Seller Center development shops](https://partner.tiktokshop.com/docv2/page/seller-center-development-shops#Back%20To%20Top)
**How to test API** Testing your app's integration with TikTok Shop involves properly calling our APIs. We recommend consulting our detailed guides to learn how you can call and test APIs: - [API Testing Tool](https://partner.tiktokshop.com/docv2/page/api-testing-tool) - This guide provides information on how to use our API Testing Tool to efficiently access the exact request and response parameters directly on Partner Center. - [How to call TikTok Shop Open API](make-your-first-api-call-overview) - This guide covers endpoint URIs and parameters, etc for calling our APIs. - [How to call APIs using Postman](call-tts-apis-with-postman) - Use Postman to simplify API testing. This guide shows how to set up scripts, environments, and requests in Postman for testing TikTok Shop APIs.
**How to get help with testing your app** If you have questions about testing your app, you can connect with the Partner Center Support team in the following ways: - [Contact us through email](how-to-contact-support) - [Submit a ticket](how-to-contact-support) through Partner Console (login required)
###### Step 7: Publish App
Complete qualification review and meet the publishing requirements for your App’s category, market and seller type. Select 「Publish」 and check the publication status. Before making API calls, authorize the App through OAuth (authorization protocol) and check the Scopes granted to your token.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/app_development_guide/step7.png)
##### Step 8: Authorize
You can authorize your shop using the App’s authorization link.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/5693d94e1eb04f7ea6d0ce5157d71d19~tplv-k9wyc2ijk0-image.image)
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/867c7f95bce84b30a31c56480e4bf275~tplv-k9wyc2ijk0-image.image)
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/d21f00fd97ee4f39ad2c73983b569ebf~tplv-k9wyc2ijk0-image.image)

### Part 2: FAQ
#### 1. If I have API questions, where can I contact TikTok Shop?

1. Questions about US domestic or cross-border stores: [https://partner.us.tiktokshop.com/ticket/center](https://partner.us.tiktokshop.com/ticket/center)
2. Questions about non-US stores: [https://partner.tiktokshop.com/ticket/center](https://partner.tiktokshop.com/ticket/center)

![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/app_development_guide/question1.jpg)
#### 2. Can I register for ISV?

1. No. If you have already registered for a TikTok Shop Seller account, you are not eligible to apply for ISV registration. This restriction also applies to any account that holds an active TikTok Shop Seller account.

#### 3. Do I need to do the compliance / App function review ?

1. **For ISV:** Security review is waived if applying in line with local regulations.
2. **For seller:** Security review is mandatory. Because you are applying to become ISV, you must do the compliance security review and app function review. **Note**: The security form must be completed in English with truthful information. Three consecutive rejections will result in automatic account blacklisting.

![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/app_development_guide/question3.png)
#### 4. Can I deactivate an App?
No. Once the App is created, developer can not delete the App. But developers can deactivate an App. Once the App is deactivated, the App can not be online again.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/app_development_guide/question4.png)
#### 5. I can not bind my TikTok Shop seller account. What's the meaning of this error?
1 seller account can only be bound with 1 TTSPC account. Please use another seller account to bind/verify
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/app_development_guide/question5.png)
#### 6. What's the meaning of this error: email/phone number does not have a linked Seller Center Account?

1. Error: This email/phone number does not have a linked Seller Center Account.
2. Please note that seller developer should use TikTok Shop seller center account to verify and this seller account must pass the KYC/KYB review in seller center

![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/app_development_guide/question7.png)
#### 7. What's the meaning of this error: Authorization failed?
Private App can only be authorized and bind to one shop ONLY (seller's own shop) . Please create an App in other categories that does not belong to 「App developer / Seller inhouse developer / TikTok Shop Seller. Seller's own shop refers to the shop which seller has bind seller center account with `My Account - Category & Market - TikTok Shop Seller`.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/app_development_guide/question8.png)
#### 8. I have an App in the ISV category. Can I change the App category to seller developer?
Please register as TikTok Shop seller developer. Refer to `Seller developer onboarding guide`.
#### 9. What APIs can I integrate with?
[API list and reference doc](make-your-first-api-call-overview).
#### 10. I have an app under other categories, which is not 「App developer / Seller inhouse developer / TikTok Shop Seller」, do I get affected?
No, you won't be affected.
#### 11. Are there any changes to my existing authorizations?
No, authorizations are still valid until the token is expired or your authorization is cancelled.
#### 12. I have created another custom App to make sure new shops can authorize the App, what should I do with the existing App?
> Existing App refers to App created in 「App developer / Seller inhouse developer / TikTok Shop Seller」)

* Plan A: you can maintain two Apps.
* Plan B: you can migrate historical authorizations to the new App. For migration, the historical shop should re-authorize the new App

#### **13. How to Get an Account Manager (AM) / Seller Developer Registration Error: "This account is not eligible for seller developer registration. Currently, only sellers with an assigned account manager can register."**
**E**rror 36010071 means the seller account does not meet registration requirements. Non-GKA local sellers with one Seller record in the six markets listed above follow Normal review, even with AM or SKM. Other local and cross-border sellers need AM, SKM or GKA eligibility. Changing the verification email or registration country does not change these requirements.
TikTok Shop Account Managers (AMs) are not a service sellers can directly apply for in the backend. Instead, the platform assigns AMs based on factors such as site, category, business scale, and store performance. Official materials also use phrasing like "if applicable" and "if your store has been assigned an AM."
**Here's what you can do:**

1. **Check if you already have an AM**

Log in to Seller Center and check the top banner on the homepage, your notification center, your registration email, and in-platform messages to confirm whether an AM has been assigned to you.

2. **Submit a request via Help Center**

Go to the Help Center in Seller Center, contact live support or submit a ticket, and clearly state:
> You are requesting an **Account Manager eligibility review** for business growth, campaigns, affiliate creators, and advertising support.

3. Include the following in your ticket:
   * Shop ID, operating site, and primary category
   * GMV, order volume, and growth rate over the past 30/90 days
   * Store rating, SPS score, and violation history
   * Your business plans for ads, livestreaming, and affiliate programs
   * Specific areas where you need AM support

**Please note:** Keeping your store Active, completing the new seller assessment period, and maintaining good SPS scores and fulfillment performance generally increases your chances of being identified as a priority merchant — but these are not officially published guarantees for AM assignment. Be cautious of third-party services that claim to "guarantee an official TikTok AM" for a fee.
#### 14. What's the meaning of this error: "Sub-accounts are not eligible for seller developer registration. Please use an owner account and try again."
Only the seller's owner account can be linked to a Partner Center account. The account you're currently trying to link is a sub-account, which is not eligible for this registration.
#### 15. What's the meaning of this error: This account is not supported on this site. Please visit TikTok Shop Global Partner Center to continue. / This account is not supported on this site. Please visit TikTok Shop US Partner Center to continue.
This error means you've accessed the wrong domain. Based on your Seller account information, your target market should be onboarded through a different site. For example, if your target market is US but you logged in through the Global Partner Center (partner.tiktokshop.com), you should switch to the US Partner Center (partner.us.tiktokshop.com) instead. Conversely, if your target market is outside the US and you logged in through the US Partner Center (partner.us.tiktokshop.com), you should switch to the Global Partner Center (partner.tiktokshop.com).
#### 16. How can I expand my Seller Developer category to additional EU markets?
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/f8668a902bbe4f70b237c3973184f516~tplv-k9wyc2ijk0-image.image)
You do not need to submit a new application. Go to Partner Center > My Account > Profile, locate the Seller Developer category card, and click the Refresh icon on the right. The icon displays “Refresh to view new market qualifications.” when you hover over it.
Once refreshed, your market qualifications will be updated to cover all opened markets.


---

## Get started > Tiktok Shop Seller Developer > Common Error for Seller Developer

Doc: https://partner.tiktokshop.com/docv2/page/guwthhrw · cập nhật 2026-08-11

#### **1. How to Get an Account Manager (AM) / Seller Developer Registration Error: "This account is not eligible for seller developer registration. Currently, only sellers with an assigned account manager can register."**
TikTok Shop Account Managers (AMs) are not a service sellers can directly apply for in the backend. Instead, the platform assigns AMs based on factors such as site, category, business scale, and store performance. Official materials also use phrasing like "if applicable" and "if your store has been assigned an AM."
**Here's what you can do:**

1. **Check if you already have an AM**

Log in to Seller Center and check the top banner on the homepage, your notification center, your registration email, and in-platform messages to confirm whether an AM has been assigned to you.

2. **Submit a request via Help Center**

Go to the Help Center in Seller Center, contact live support or submit a ticket, and clearly state:
> You are requesting an **Account Manager eligibility review** for business growth, campaigns, affiliate creators, and advertising support.

3. Include the following in your ticket:
   * Shop ID, operating site, and primary category
   * GMV, order volume, and growth rate over the past 30/90 days
   * Store rating, SPS score, and violation history
   * Your business plans for ads, livestreaming, and affiliate programs
   * Specific areas where you need AM support

**Please note:** Keeping your store Active, completing the new seller assessment period, and maintaining good SPS scores and fulfillment performance generally increases your chances of being identified as a priority merchant — but these are not officially published guarantees for AM assignment. Be cautious of third-party services that claim to "guarantee an official TikTok AM" for a fee.
#### 2.I can not bind my TikTok Shop seller account. What's the meaning of this error?
1 seller account can only be bound with 1 TTSPC account. Please use another seller account to bind/verify
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/app_development_guide/question5.png)
#### 3.What's the meaning of this error: email/phone number does not have a linked Seller Center Account?

1. Error: This email/phone number does not have a linked Seller Center Account.
2. Please note that seller developer should use TikTok Shop seller center account to verify and this seller account must pass the KYC/KYB review in seller center

#### 4. What's the meaning of this error: Authorization failed?
Private App can only be authorized and bind to one shop ONLY (seller's own shop) . Please create an App in other categories that does not belong to 「App developer / Seller inhouse developer / TikTok Shop Seller. Seller's own shop refers to the shop which seller has bind seller center account with `My Account - Category & Market - TikTok Shop Seller`.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/app_development_guide/question8.png)
#### 5. I have an App in the ISV category. Can I change the App category to seller developer?
Please register as TikTok Shop seller developer. Refer to `Seller developer onboarding guide`.
#### 6. What APIs can I integrate with?
[API list and reference doc](make-your-first-api-call-overview).
#### 7. I have an app under other categories, which is not 「App developer / Seller inhouse developer / TikTok Shop Seller」, do I get affected?
No, you won't be affected.
#### 8. Are there any changes to my existing authorizations?
No, authorizations are still valid until the token is expired or your authorization is cancelled.
#### 9. I have created another custom App to make sure new shops can authorize the App, what should I do with the existing App?
> Existing App refers to App created in 「App developer / Seller inhouse developer / TikTok Shop Seller」)

* Plan A: you can maintain two Apps.
* Plan B: you can migrate historical authorizations to the new App. For migration, the historical shop should re-authorize the new App

#### 10. What's the meaning of this error: "Sub-accounts are not eligible for seller developer registration. Please use an owner account and try again."
Only the seller's owner account can be linked to a Partner Center account. The account you're currently trying to link is a sub-account, which is not eligible for this registration.
#### 11. What's the meaning of this error: This account is not supported on this site. Please visit TikTok Shop Global Partner Center to continue. / This account is not supported on this site. Please visit TikTok Shop US Partner Center to continue.
This error means you've accessed the wrong domain. Based on your Seller account information, your target market should be onboarded through a different site. For example, if your target market is US but you logged in through the Global Partner Center (partner.tiktokshop.com), you should switch to the US Partner Center (partner.us.tiktokshop.com) instead. Conversely, if your target market is outside the US and you logged in through the US Partner Center (partner.us.tiktokshop.com), you should switch to the Global Partner Center (partner.tiktokshop.com).


---

## Get started > Onboarding > Developer onboarding

Doc: https://partner.tiktokshop.com/docv2/page/developer-onboarding · cập nhật 2026-10-31

Onboarding as a TikTok Shop developer has **three** main steps:

1. **Create an account** on the TikTok Shop Partner Center.
2. **Register as a developer** (seller developer, or app developer / ISV).
3. **Initiate the compliance and legal review** — required for US and UK partners (and case-by-case for others). This step can take **three or more weeks**, so start planning for it early.

> ⏱️ **Plan for the full timeline.** Steps 1–2 are quick, but the compliance & legal review in step 3 is the long pole. If you're a US or UK partner, factor in 3+ weeks before you can fully launch.

#### Step 1: Create an account on Partner Center
If you don't already have one, create an account using the TikTok Shop Partner console:

* **U**S region accounts → [partner.us.tiktokshop.com/account/sign-up](https://partner.us.tiktokshop.com/account/sign-up)
* **N**on-US region accounts → [partner.tiktokshop.com/account/sign-up](https://partner.tiktokshop.com/account/sign-up)

> **Which domain do I use?** Use `partner.us.tiktokshop.com` for US region accounts and `partner.tiktokshop.com` for Global/ROW accounts. US cross-border seller developers use the Global entry. Later, when you make API calls, you'll also encounter `auth.tiktok-shops.com` (token endpoints) and the regional authorization domains (`services.us.tiktokshop.com` / `services.tiktokshop.com`). Each market/purpose has its own domain — see the authorization guides for the full mapping.

The process is the same for both. At the **Log In** dialog, select **Sign Up**, then provide your email address and (optionally) your phone number. Keep your Partner Center email current — it's essential for receiving critical platform updates.
**Why am I being redirected to the US site?**
Using a US VPN or proxy can cause Partner Center to redirect you to the US site based on your public IP. For Global/ROW access, check your IP location, disconnect the US VPN or use a non-US exit, then reopen [Global Partner Center](https://partner.tiktokshop.com/).
Your account region can also cause a redirect after login. If switching networks does not resolve it, sign out and retry in a private window, then confirm that the site matches your account region.
> ⚠️ Use the right email for your developer type. If you want to register as an app developer or system integrator (ISV), do not use the email associated with your TikTok Shop seller account. If you register with a Shop account email, the system will identify you as a seller and you can only register as a seller developer.

**Note:** The TikTok Shop Partner Platform and Open Platform merged into the TikTok Shop Partner Center in late 2022. If you have an existing Partner Platform or Open Platform account, you can log in with those credentials on Partner Center.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/b28cc21e222f476c95281075a679196e~tplv-k9wyc2ijk0-image.image)
#### Step 2: Register as a developer
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/8e669291d30f4b67bd48cadb951ed878~tplv-k9wyc2ijk0-image.image)
#### Before you begin: determine your developer type
When you register, you'll select one of two developer types:

1. **TikTok Shop seller developer** — builds **custom** apps that access **their own** seller data only.
2. **App developer or system integrator (ISV)** — builds **public** apps and can request authorization to access **other sellers'** data on TikTok Shop.

> ✅ **Seller developer prerequisites (read before you start):**

> * You must have an **activated TikTok Shop account and bound an Account Manager before** registering as a developer.
> * The email you use for verification **should be the same** email used to register the TikTok Shop.

> These two constraints are the most common cause of failed seller-developer registrations.

#### Registering as an app developer or system integrator (ISV)

1. **Start your partner registration application.** On the business guide dialog, select **For app developers (ISV)**, then **Start Business**.

> If your account needs to be allowlisted for the wrong email (**Using the shop account email**), submit a ticket or contact your Account Manager (AM) to request allowlisting before continuing the registration process. 

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/b13be7a323f042d693ae5b22cc619072~tplv-k9wyc2ijk0-image.image)

2. **Begin your partner application** by clicking **Start Business**.

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/906a33e285db45fd942596b714ac5e64~tplv-k9wyc2ijk0-image.image)

3. **Specify your registration region, target market, and business category:**

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/a0b1d2a2200c40f7b16eace530df6034~tplv-k9wyc2ijk0-image.image)

   * **Registration region:** must be consistent with your company's business certification.
   * **Target market:** cross-border partners (registration region China and/or Hong Kong, China) may select UK, MY, VN, TH, PH, or SG; local partners (entities in the local market) should choose only their local market.
   * **Business category:** select your business category. 📌 Available categories may vary by registration region and target market.
4. **Specify your company name and contact information,** and provide additional business details so the team can support you.

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/c4f7dc5ccb9d453595656649704cdcc2~tplv-k9wyc2ijk0-image.image)

5. **Upload your company's business certificate and registration information.**

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/53c321e8ce844441bbd2d0c67c5e9654~tplv-k9wyc2ijk0-image.image)

   * If you don't have these ready, select **Save for later**; you can then go *Back to profile* or *Create app or service*. (If you create an app now, you can't publish it until certification is complete.)

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/4f9839cc656a4d37bdf20715c2eb2e3e~tplv-k9wyc2ijk0-image.image)

   * Otherwise, select **Submit** to begin certification review.

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/fd21258fe5b8436abd226db7c4d21320~tplv-k9wyc2ijk0-image.image)

Check your application status under **My Account > My category & market**. Once approved, the **under review** message disappears.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/1fcbb9ff22994e46ab601438ec9767d4~tplv-k9wyc2ijk0-image.image)
#### Add another market after onboarding
If you already have an ISV app and want to expand it, you can start from that app's **+ Add market (Seller type)** dialog. See **Add markets to an existing app** in [Create your App](https://partner.tiktokshop.com/docv2/page/create-your-app) for the complete flow.
You can also start from your profile:

1. Open your profile and select the option to add a category or market. 
2. Select the target market and business category, then click **Next**. 
3. Review the **Partner info** form and complete the required information. If you already have an app in that category, click **Submit** to save a draft. 
4. On the success page, choose how you want to continue: 
   * **Add to an existing App** opens **App & Service**, filtered to the relevant category. Choose an app and click **Manage**, then use **+ Add market (Seller type)** to select an available market, complete the seller settings and **Save**. If qualification review is required before the market becomes available, complete that review first.
   * **Create a new App** opens the app creation flow with the selected category carried over. Choose **Public** or **Custom**, review the app details and complete creation.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/925f6c7c17fc4a0db5572c2b0aa9a415~tplv-k9wyc2ijk0-image.image)

If you do not have an app in the selected category, continue through the app creation flow shown in Partner Center.
> **Check the final step.** The success page confirms that your draft information has been saved. It does not mean qualification review has started, that the market has been added to an app, or that the app is live there.

##### Find the app you want to expand
The **Category** filter groups matching Public and Custom categories under one option. Use the separate **Type** filter if you want to see only Public or only Custom apps.
When you arrive from **Add to an existing App**, Partner Center displays a prompt to select an app. Closing this prompt leaves the category filter in place.
#### Registering as a seller developer
> Detailed guide refer to: https://partner.tiktokshop.com/docv2/page/seller-developer-onboarding-onepager

* When applying for a target market for a developer account, select the category **Seller inhouse developer / TikTok Shop Seller** and **link the activated TikTok Shop account** in the next step.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/f9513f71b0d84bcab0ad458aa7d7f8f0~tplv-k9wyc2ijk0-image.image)

📌 **Note**: Please ensure the seller account information you entered is authentic.

#### Step 3: Initiate the compliance and legal review
Once you've registered as a developer partner, initiate the compliance and legal review. It can take **three or more weeks**. Reviews are required case-by-case for some partners, but are **always required for US and UK partners**.
Contact the Partner Development & Management team for your market to request a due diligence questionnaire:

* US: [partner.us@tiktokshop.com](mailto:partner.us@tiktokshop.com)
* UK: [partner.uk@tiktokshop.com](mailto:partner.uk@tiktokshop.com)
* Other: [partner@tiktokshop.com](mailto:partner@tiktokshop.com)

**When to start:** initiate this review as soon as you've registered, so the 3+ week timeline runs in parallel with your development. Prepare your due diligence questionnaire and supporting business documents in advance. See Compliance and Legal Review for details.
#### Next steps
Now that you have a partner developer account, you're ready to [make your first TikTok Shop API call](https://partner.tiktokshop.com/docv2/page/make-your-first-api-call-overview).


---

## Get started > Onboarding > Additional Developer onboarding steps for Tokopedia > Tokopedia & Shop - ISV & Seller developer onboarding

Doc: https://partner.tiktokshop.com/docv2/page/tokopedia-shop-isv-seller-developer-onboarding · cập nhật 2025-07-03

### Overview
Welcome to the Tokopedia & Shop Developer Guideline. Here you'll find guidance on how to:

1. Onboard as a developer partner in Tokopedia & Shop Partner Center.
2. Develop and publish your apps in Tokopedia & Shop Partner Center.
3. Implement new Tokopedia & Shop APIs and configure your Webhooks.
4. Use our developer tools provided in your Tokopedia & Shop Partner Center

### Integration Guide
**Onboarding process**
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image01.jpeg)

**High-level timeline**
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image02.jpeg)
#### Definition and basic business introductions

* [Tokopedia & Shop Partner Center](https://partner.tiktokshop.com/): mainly builds related systems for two types of User Persona, partners and sellers, and finally realizes a complete B2B product process around partners' service/App release and platform sellers' order services. Compared with the B2C e-commerce scenario, the role of the partners is "service seller" and the role of the e-commerce seller is "service buyer".
* **Tokopedia & Shop App Store**:
   * **For partners**: The Public App will be published in the Tokopedia & Shop App Store. Sellers can browse and authorize the App(s) created by ISV or 3rd-party developers in the App Store.
   * **For sellers**: To help sellers boost business on Tokopedia & Shop and improve your operational efficiency, Tokopedia & Shop now offers an App Store where sellers can contact and authorize App(s) that suit sellers to improve productivity, and synchronize products.

| **Seller Market** | **App Store Portal** | **Tokopedia & Shop Seller Center - App Store** |
| --- | --- | --- |
| **Indonesia local seller** | [https://seller-id.tokopedia.com/appstore/id](https://seller-id.tokopedia.com/appstore/id) | [https://seller-id.tokopedia.com/services/market?shop_region=ID](https://seller-id.tokopedia.com/services/market?shop_region=ID) |
### Case 1: If you have integrated with「Tokopedia Open Platform」and「Tokopedia & Shop Partner Center」before
> Tokopedia Open Platform: https://developer.tokopedia.com/
> Tokopedia & Shop Partner Center: https://partner.tiktokshop.com/

#### Step 1: Login「Tokopedia & Shop Partner Center」
> 📌 Access to Tokopedia & Shop website: **https://partner.tiktokshop.com/**

#### Step 2: Bind「Tokopedia Open Platform」account and「Tokopedia & Shop Partner Center」account
##### 2.1 Find the Organization ID in Tokopedia Open Platform  

1. Go to [Tokopedia dev portal](https://developer.tokopedia.com/console). Once logged in, you will be directed to the main dashboard of the developer console.
2. Identify Organization ID: Look at the top left corner of the dashboard, below your company's name, you will see the Organization ID

(ảnh: https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ[[/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image04.png)

##### 2.2 Bind account
> 📌 By binding the accounts, you no longer need to create multiple applications. This not only saves your time and resources but also reduces complexity. In the future, you will be able to maintain merchants from both platforms under a single application, which will significantly streamline your shop operation.

Use the Organization ID from Tokopedia Open Platform and input it into the「Tokopedia & Shop Partner Center」.
| **#**  | **Operation** | **Demo**  |
| --- | --- | --- |
| Step 1 | 1. Click "[My Account - Link Tokopedia Account](https://partner.tiktokshop.com/approval/toko)"  2. If you already have Tokopedia & Shop App, you can see the entrance in the App Management page   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image05.png)  ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image06.png)   |
| Step 2 | Click "Link now" and enter Tokopedia organization ID and Registered email in Tokopedia Open Platform  📌 One「Tokopedia & Shop Partner Center」account can only be bound to one 「Tokopedia Open Platform」account, establishing a 1:1 mapping relationship. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image07.png)   |

#### Step 3: Bind Tokopedia App and "Tokopedia & Shop" App  
> 📌 After binding the App key, you will be able to query valuable information. For example, you can find out how many Tokopedia merchants have migrated to TTS and how many merchants have completed App authorization. This data will be very useful for you to better understand the market situation and plan your business strategies accordingly.

##### 3.1 Find App ID in Tokopedia Open Platform
Go back to the Tokopedia Developer Portal to locate the **App ID** for the application you have integrated
##### 3.2 Bind App
| **#**  | **Operation** | **Demo**  |
| --- | --- | --- |
| Step 1 | When you finish the account binding, you will enter the App binding page automatically.  You can also click "[My Account - Link Tokopedia Account](https://partner.tiktokshop.com/approval/toko)" to bind the Tokopedia App and "Tokopedia & Shop" App. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image08.jpeg)  ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image09.png)   |
| Step 2 | Choose "Tokopedia & Shop" App and Tokopedia App which you want to bind.    📌Please note that:  1. One "Tokopedia & Shop" Appkey can bind to multiple Tokopedia App IDs, but one Tokopedia App ID cannot be bound to multiple "Tokopedia & Shop" Appkeys.  2. The status of "Tokopedia & Shop" App should be online | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image10.png)   |

#### Step 4: Integrate with Tokopedia & Shop API  

* By integrating with the new API, only one merchant portal (Tokopedia & Shop Seller Center) and one set of Open APIs (TikTok Shop APIs) will be available
* Both user Apps — Tokopedia and Shop｜Tokopedia — will remain available
* Merchants can choose to sell products on one of these apps or both simultaneously. ISVs must use the Shop｜Tokopedia APIs to manage merchant operations on both apps. Once the merchant migration is complete, all newly generated data can only be accessed through the Shop｜Tokopedia APIs. Some historical data (such as merchant data) will be migrated to Shop｜Tokopedia, while other historical data (such as orders and bills) will remain in Tokopedia.

**Please** [click here to access to the API onepager](id-market-tokopedia-shop-open-api-integration-one-pager) **to view more about:**

1. **Data access via APIs**: What APIs to use to access new data and integrate historical data of merchants migrating from Tokopedia to "Tokopedia & Shop"?
2. **Changes to Shop｜Tokopedia APIs**: What changes are made in Shop｜Tokopedia APIs to suit the Indonesian market?
3. **Mapping of shops and products**: How will the new shops and products from "Tokopedia & Shop" be mapped to those from Tokopedia?

#### Step 5: Test your App and Publish  

1. Create a test account in Development Shop with "Target market: Indonesia"

(ảnh: https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ[[/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image11.png)

2. Use this test account to authorize your app:

(ảnh: https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ[[/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image12.png)

* After authorization, you should receive an "authorization_code", follow this instruction to get "access_token": https://partner.tiktokshop.com/docv2/page/678e3a3292b0f40314a92d75.
* Call [[Get Authorized Shops](get-authorized-shops)] to get "shop_cipher"
* Use "access_token" and "shop_cipher" for further API calls.
3. Start testing your app:
   * Test product listing
      * For product listing with API, please refer to [this document](products-api-overview).
      * If you wish to list products manually, please use [ModHeader](https://modheader.com/). Use the below profile:
      ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image13.png)
      Then click "Go to Seller Center" for product listing:
      (ảnh: https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ[[/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image14.png)      

   * Test order placement and fulfillment
      Before order placement, please make sure you have successfully listed the products for this shop, then click "start testing".
      (ảnh: https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ[[/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image15.png)      

      Click "Create test order" to mock order placement.
      (ảnh: https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ[[/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image16.png)      

**📌 Please note: we only support test order placement from TikTok right now.**
You should be able to get the order data from Orders API, then proceed to fulfillment API calls.
### Case 2: If you only integrate with Tokopedia Open Platform, and not yet integrated with Tokopedia & Shop Partner Center
> Tokopedia Open Platform: https://developer.tokopedia.com/
> Tokopedia & Shop Partner Center: https://partner.tiktokshop.com/

#### Step 1: Create an account on Tokopedia & Shop Partner Center
> 📌 Access to Tokopedia & Shop Partner Center: **https://partner.tiktokshop.com/**

Set up an account on Partner Center. Provide your email address and, optionally, your phone number. Ensure your email address on Partner Center is current, as it is essential for receiving crucial updates from the Partner Center platform.

#### Step 2: Register as an App developer (ISV or Seller developer)
##### If you are ISV
| **#**  | **Description** | **Screenshot**  |
| --- | --- | --- |
| 1 | After creating an account, you'll find a business guide tailored to different partner types. Pick App developer as your partner type from this guide, click on 'Start Business,' and it will lead you to the 'Get Started' page to initiate your application for your selected category. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image17.png) |
| 2 | Click on "Get started" to start your partner application. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image18.png) |
| 3 | As a first step, Tokopedia & Shop needs to know what type of Apps you plan to build for sellers. **Please choose the target App category and target seller market**.  For example, you can choose "Enterprise Resource Planning" as the target category and "Indonesia" as the target market. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image19.png) |
| 4 | You can click "Get app key now" and complete your registration later. But you must come back and pass the certification review before the App published. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image20.png) |
| 5 | You'll need to complete the necessary fields based on the category you've selected, including business license related information. Be sure to have your business license and related documents prepared in advance. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image21.png)  ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image22.png)   |

##### If you are the seller developer
| **#**  | **Description** | **Screenshot**  |
| --- | --- | --- |
| 1 | After creating an account, you'll find a business guide tailored to different partner types. Pick App developer as your partner type from this guide, click on 'Start Business,' and it will lead you to the 'Get Started' page to initiate your application for your selected category. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image17.png) |
| 2 | Click on "Get started" to start your partner application. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image18.png) |
| 3 | **Please choose the target App category and target seller market**.  📌 Please choose 「TikTok Shop Seller」as the business category | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image23.jpeg) |
| 4 | Please verify your seller account with login and password (email or phone number).  [Tokopedia & Shop Partner Center](https://partner.tiktokshop.com/) will verify the account automatically. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image24.png) |
| 5 | When you are verified, you will see the tag of "Tokopedia & Shop Seller" under My Account page.  📌 You should have a Tokopedia & Shop seller account first, no matter which market this account belongs to   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image25.png)   |

#### Step 3: Create an App
| **#**  | **Description** | **Screenshot**  |
| --- | --- | --- |
| 1 | **Determine what type of App to build**  There are two types of Apps you can build with Tokopedia & Shop APIs: public and custom. Each App type has its own workflows and requirements.    * **Public App:** This type of App is publicly listed on the [Tokopedia & Shop App Store](https://seller-id.tokopedia.com/appstore/id) and is discoverable by sellers. Sellers will authorize the App to connect their Tokopedia & Shop account. To list this App on [Tokopedia & Shop App Store](https://seller-id.tokopedia.com/appstore/id), the App must pass Tokopedia & Shop's App review process.  * **Custom App:** This type of App is typically developed for a particular seller. It is tailored to meet the specific business needs, requirements, or preferences of a seller. The App is not listed on Tokopedia & Shop App Store. You can distribute this App to individual sellers by sharing the App's authorization link.    📌 **Note:** Partner Center supports the ability to convert/upgrade a custom App to a public app. Refer to [Publishing a custom App](publish-custom-app) for more information on how to convert your published custom App. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image26.png) |
| 2 | **Create your App**    1. Select **App & Service** from the navigation panel. The Partner Center displays the 「App & service」 page.  2. Click the **Create app & service** button in the top right corner of the page. The Partner Center displays the「Create app & service」page.  3. Select either **Public** or **Custom**, based on the type of App you wish to create.  4. Select the **Service category** and set the **default name** of your App. Optionally, upload a logo for your App.  📌 Please note that you can only choose the category you chose in「Step2 Register as an App developer」  5. Select the **Market** and set the **seller type** for your App.  📌 You can choose multiple seller market and seller type.  6. Toggle the **Enable API** switch on and complete the following fields. Otherwise, skip to the next step.  &nbsp;&nbsp;&nbsp;&nbsp;- **Redirect URL** Enter the URL at which to receive your authorization code. After the seller authorize the App, it will jump to this URL (it can be the URL of your system's web page) and transmit the `auth_code`, which you can use to get the `access_token`.  &nbsp;&nbsp;&nbsp;&nbsp;- **Webhook URL** Optionally, enter the URL to receive [push notifications](configuration-guide) (it can be the URL of your system).  7. Click **Create** to complete the process.  After you create your App, Partner Center displays the App and service detail page. Here you can access your App's unique App key and secret, which allow you to complete [seller authorization](seller-authorization-guide) and [API calls](make-your-first-api-call-overview).  &nbsp;&nbsp;&nbsp;&nbsp;- **App Key** - The unique identification of the service.  &nbsp;&nbsp;&nbsp;&nbsp;- **App Secret** - The application key generated by the platform when you create an App. You can use this secret to obtain the API access token. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image27.png) |

#### Step 4: Bind「Tokopedia Open Platform」account and「Tokopedia & Shop Partner Center」account
Same as[Case 1 - Step 2](#case1_step2)
#### Step 5: Bind「Tokopedia Open Platform」App and「Tokopedia & Shop Partner Center」App
Same as [Case 1 - Step 3](#case1_step3)
#### Step 6: Integrate with Tokopedia & Shop API
Same as [Case 1 - Step 4](#case1_step4)
#### Step 7: Test your App
Same as [Case 1 - Step 5](#case1_step5)

#### Step 8: Ready to launch
##### For Public App
> 📌 **Checklist:** Once you're ready to launch your public App, you must go through review requirements before you can make your App live:

1. Pass the registration review
2. Complete and submit your language listing form for review.
3. Initiate and complete your App review.
4. If required by your case, ensure you've passed the compliance and legal review you initiated during onboarding.

![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image28.png)

**Initiate and complete the App review form (Only for public App)**
Fill out the App Review form to initiate the app review process. To access the App Review form scroll down to the App Review section of the app and service detail page and click **Submission materials for review**. Alternatively, you can hover over **Publish** on the app and service detail page and click **Modify**.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image29.gif)

Complete the following steps to submit the form:

1. In the **API Scope Information** section, ensure the APIs integrated with your app are listed correctly. Modify the APIs as necessary.
2. In the **Product testing** section, provide the information necessary for us to test and review your product. Enter the information that identifies your app, such as the URL of your product, the account you used for testing, and any testing instructions.
3. In the **Product screenshots** section, provide a brief explanation of what features your app has, what it can do, and who it serves. Include screenshots and, optionally, videos of your app as necessary.
4. In the **Required Product Design** section, provide the design document you used to plan out the design of your app.
5. Click **Submit** to initiate the app review process.

**Note:** Once you submit the form, you can't edit it during the review process. You are able to edit the app review form and resubmit if we reject your app.

**Fill in the listing information and initiate listing review (Only for public App)**
> 📌 Please fill in carefully. The listing information that will be shown on the [Tokopedia & Shop App Store](https://seller-id.tokopedia.com/appstore/id) for sellers.

You must complete a language listing form to set the language of your app listing according to the target market. The specific market(s) in which your app is accessible necessitates distinct language requirements for its listing. The table below describes the language listing requirements based on market and seller type.
| **Target market** | **Seller Type** | **Language required for listing** |
| --- | --- | --- |
| Indonesia(ID) | Local | Bahasa Indonesia |

Completing and submitting the language listing form initiates a review for the market in which you're listing your app. You must complete a language listing form for each market your app targets.
To access the language listing form, click the market name under the Target Sellers section of the app and service detail page and then click **Edit**. Alternatively, you can click **Edit** next to the **Publish** button.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image31.gif)
**Notes:**

* If you have already finished a language listing form for another market, you can use the **translate and import from** feature to auto-fill the listing form. Refer to the Translate and import your listing section below for more information.
* You can click **Save** at the top of the form to save your progress.

Complete the following steps for each market in which you wish to list your App:

1. In the **Service overview** section, provide an overview of your app, including:
   * The name of your App. A concise name helps to attract more sellers. It's the first thing sellers will see when browsing the App Store.
   * The logo for your App. If your logo contains any text, please ensure that the text is in the same language as the App.
   * A short introductory description of your App.
   * Media (images or video) that highlights your app's functionality and benefits. You should choose at least one image or one video to describe your service. We highly recommend providing a video rather than an image.

| **Field Name**  | **Type** | **Field Description** | **Requirements**  | **Screenshot**  | **Seller-side Demo**  |
| --- | --- | --- | --- | --- | --- |
| App or service name | Mandatory | Please provide an app name.  💡A concise name will help you to attract more sellers. It's the first thing sellers will see when browsing the **App & Service Store.** | Format: Text, less than 100 characters. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image32.png) | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image33.png) |
| App or service logo | Mandatory | Please upload a logo to help sellers recognize your app and brand.    📌 If your logo contains any text, please ensure that the text is in the same language as the app. | A logo to help sellers recognize your service and brand.  Size: < 10MB  Ratio: 1:1  Dimensions: 150 * 150  Format: jpg, jpeg, png | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image32.png) | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image34.png) |
| App or service language | Mandatory | In order to enable local businesses to better understand your services, please fill out the service information according to the specified **target market service language.**    To facilitate a clear understanding of your app among sellers, kindly complete the service listing information in accordance with the specified target market service language. |  | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image35.png) |  |
| App or service short description | Mandatory | Give a short description to introduce your service | Format : Text, less than 200 characters | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image36.png)   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image37.png) |
| Video or main image | Mandatory | Upload a video or image that highlights the impact of your app. This is a visible way to demonstrate to sellers the benefits of your app. You need choose at least 1 image or 1 video to describe your service.    💡It's better to provide a video rather than an image. | **Video**  Format: mp4, mov, flv  Size: < 200MB    **Image**  Size: <= 10MB  Ratio: 5:3  Format: jpg, jpeg, png | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image38.png)  ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image39.png)     | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image40.png) |

2. In the **Detail introduction** section, provide the functional details of your App, including:
   * Three key benefits of your App. We recommend that you use this space to address the requirements of sellers, focusing on their needs, rather than how a particular feature works.
   * Additional images of your App to attract sellers. We recommend providing at least three images that introduce your App's featured functions, images of staff, or success stories.
   * A detailed and comprehensive description of your App's key features and what sellers can do with your app.
   * A list of platforms/services with which your App can integrate. This information allows sellers to quickly determine whether your App is compatible with the platform(s) they are using.

| **Field Name**  | **Type** | **Field Description** | **Requirements**  | **Screenshot**  | **Seller-side Demo**  |
| --- | --- | --- | --- | --- | --- |
| Key benefits | Mandatory | Provide three key highlights of your app. Each highlight must include a title and description.    Leverage this space to address the requirements of sellers, focusing on their needs, rather than how a particular feature works.    📌 All 3 sets are required. | Format: Text  Title (50 characters or less) & Description (150 characters or less) | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image41.png)   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image42.png) |
| Image | Mandatory | You can add additional images to prove your abilities and attract sellers. Recommend 3-6 pictures to introduce the service. For example, screenshots of your featured functions, images of staff or success stories. | jpg, jpeg and png only.  Ratio of length to width:5:3, within 10MB    *Please provide at least one Featured Image, but it is better to have 3-6 images | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image43.png) | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image44.png)   |
| App or service detail description | Mandatory | Please provide a more detailed and comprehensive product introduction in this part.  Explain your service's key features in detail. Sellers want to know what your service can do for their shop.      * Don't use special characters or emojis in your description.  * Don't include testimonials in the detailed description.  * Don't use any personal information without written consent. | Format: Text and URL links  2000 characters or less allowed, 500 or less recommended | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image45.png) | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image46.png)   |
| Integrations | Mandatory | List any platforms that your app integrates with.  Sellers can quickly determine whether your app is compatible with the platform they are using and quickly make a decision on installing your app. | For example, Shopify, WooCommerce, Magento, BigCommerce, Amazon... | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image47.png) | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image48.png) |

3. In the **Contact & support** section, provide contact information and help resources to support sellers using your app, including:
   * A valid email address and, optionally, a phone number.
   * Optionally, links to your official website and app FAQs, user guide, etc.

| **Field Name**  | **Type** | **Field Description** | **Screenshot**  | **Seller-side Demo**  |
| --- | --- | --- | --- | --- |
| Phone | Optional | Leave your phone number for sellers to contact you  📌 Local phone number is recommended. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image49.png)   | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image50.png) |
| Email address | Mandatory | Provide your email to help the seller contact you |  |  |
| Website | Optional | If there is an official website, you can fill in a valid official website address here. | ![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image51.png) |  |
| App Userguide or FAQ | Optional | If you have the user guidebook or some common product questions and answers, please provide the URL link. |  |  |

4. Click **Next listing** to submit your App listing for review and move to the next listing (if applicable).

**Note:** Once you submit the form, you can't edit it during the review process. You are able to edit the language listing form and resubmit if we reject your listing.

##### For Custom App (seller developer's App also included)
> 📌 **Checklist:** Once you're ready to launch your custom App, you must go through **registration review** before you can make your App live

![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image52.png)

#### Step 9: Publish App

* For Public Apps: Public App will be published in the [Tokopedia & Shop App Store](https://seller-id.tokopedia.com/appstore/id). Sellers can browse and authorize the App(s) in the App Store.
* For Custom Apps: Custom App is typically developed for a particular seller. It is tailored to meet the specific business needs, requirements, or preferences of a seller. The App is not listed on Tokopedia & Shop App Store. You can distribute this App to individual sellers by sharing the App's authorization link.

##### For Public App
After you complete and submit the app review and language listing forms, and ensure you've passed the compliance review, you have finished all the steps necessary to publish and list your public app.
You can check the publishing status of your app on the app and service detail page.

* If Tokopedia & Shop approves your app, we will automatically make it available on the App and Service Store for sellers to authorize. In addition, we will provide you with an "Authorize link" you can copy and share with sellers individually.
* If Tokopedia & Shop rejects your app, click **Edit** to view our reasoning, make adjustments, and resubmit your app for further review.

##### For Custom App
After you complete registration and integration, you have finished all the steps necessary to publish your custom app. Please click 「Publish」and then the App will be published automatically.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image53.png)

#### Step 10: Authorized by seller
##### For Public App
There are two ways for sellers to authorize your App.

1. Sellers browse and authorize the App in the App Store

Sellers can go to [[Seller Center] > [Apps store]](https://seller-id.tokopedia.com/services/market) and finish the authorization.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image54.png)
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image55.png)
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image56.png)
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image57.png)

2. Sellers authorize the App by the authorization link directly

Alternatively, you can send the authorization link to target sellers. Sellers can open the authorization link directly and authorize shops. This link serves as a means for sellers to authorize your application in a more personalized and targeted manner.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image58.png)
##### For Custom App
> 📌 Sellers can only authorize the App by the authorization link

Alternatively, you can send the authorization link to target sellers. Sellers can open the authorization link directly and authorize shops. This link serves as a means for sellers to authorize your application in a more personalized and targeted manner.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image58.png)

### FAQ
#### 1. Can I convert my custom app to a public app
If you determine that your published custom app can offer value to sellers outside your app's original seller scope, Partner Center offers the ability to convert your custom app to a public app. This allows you to make your app available on the [Tokopedia & Shop App Store](https://seller-id.tokopedia.com/appstore/id).
For a published custom app, you can click **Upgrade to Public Service** to convert your app from custom to public. Please note this is a beta feature on a gray test, and you may not see the button if you are not on the test invite list.
**Important:**

* You can't upgrade a custom App to public if you have not published the app yet.
* You can't change the target sellers (i.e. the market and seller type) when converting the app type from custom to public.
* You'll need to fill in all language listings before you can submit the custom app for upgrade review.
* The app type will remain custom until the app passes the upgrade review and reviews for all selected markets.

![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image59.png)

#### 2. What APIs can I integrate with?
**Please** [click here to access to the API onepager](id-market-tokopedia-shop-open-api-integration-one-pager) **to view more about:**

1. **Data access via APIs**: What APIs to use to access new data and integrate historical data of merchants migrating from Tokopedia to "Tokopedia & Shop"?
2. **Changes to "Tokopedia & Shop" APIs**: What changes are made in "Tokopedia & Shop" APIs to suit the Indonesian market?
3. **Mapping of shops and products**: How will the new shops and products from "Tokopedia & Shop" be mapped to those from Tokopedia?

#### 3. Can I unbind「Tokopedia Open Platform」and「Tokopedia & Shop Partner Center」account?
Yes. After the binding is successful, developers are allowed to perform the [Unbind] or [Rebind after Unbinding] operation.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image60.png)
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image61.png)
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image62.png)
After unbinding, developers are allowed to bind again: Initiating the binding process again is consistent with the first binding process, and information input and email verification need to be completed.

#### 4. Can I unbind Tokopedia App and Tokopedia & Shop App?
No. Appkey does not support rebinding or unbinding

#### 5. If I have questions, where can I contact Tokopedia & Shop?
Please access the Help Center https://partner.tiktokshop.com/ticket/landing
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image63.png)
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image64.png)

#### 6. How to test API / Can I use the test shop?
There is the Sandbox (test tool) in [Tokopedia & Shop Partner Center - Development Kits](https://partner.tiktokshop.com/v2_sandbox/guide?region=ID).
Refer to [Step 5: Test your App and Publish](#case1_step5) for detailed steps.

#### 7. I have API questions, how to solve it?
Please access the Help Center https://partner.tiktokshop.com/ticket/landing
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image63.png)
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Get_Started/ISV_Onboardling_Toko/image64.png)


---

## Get started > Authorization > Authorization overview

Doc: https://partner.tiktokshop.com/docv2/page/authorization-overview-202407 · cập nhật 2026-06-26

Authorization is how a TikTok Shop user (seller, creator, or partner) grants your app access to their data. The flow is OAuth-based: the user approves an authorization link, your app receives a short-lived `auth_code`, and you exchange it for an `access_token` and `refresh_token`.
This page is the **reference** for the token APIs and the `user_type` values. For step-by-step, role-specific walkthroughs, see:

* [Seller authorization guide](https://partner.tiktokshop.com/docv2/page/seller-authorization-guide)
* [Creator authorization guide](https://partner.tiktokshop.com/docv2/page/creator-authorization-guide)
* [Partner authorization guide](https://partner.tiktokshop.com/docv2/page/partner-authorization-guide)

### Authorization domains by market
Different markets and authorization types use different domains. Use this table as the single reference:
| Authorization type | US market | Rest of World (ROW) |
| --- | --- | --- |
| Seller (via authorization link) | `https://services.us.tiktokshop.com/open/authorize?service_id={service_id}` | `https://services.tiktokshop.com/open/authorize?service_id={service_id}` |
| Partner (TAP) | `https://partner.us.tiktokshop.com/open/authorize?service_id={service_id}` | `https://partner.tiktokshop.com/open/authorize?service_id={service_id}` |
| Creator | `https://shop.tiktok.com/alliance/creator/auth?app_key={app_key}&state={state}` | `https://shop.tiktok.com/alliance/creator/auth?app_key={app_key}&state={state}` |
| Token endpoints (all markets) | `https://auth.tiktok-shops.com/api/v2/token/get` and `.../token/refresh` | same |
> **Where do I get** **`service_id` / `app_key`?** Both are shown on your app's detail page in Partner Center (**App & Service**). The `service_id` is the unique identifier of your registered online application (OAuth client).

### Authorization flow
(ảnh: data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB2ZXJzaW9uPSIxLjEiIHdpZHRoPSI2MjVweCIgaGVpZ2h0PSI2MTZweCIgdmlld0JveD0iLTAuNSAtMC41IDYyNSA2MTYiPjxkZWZzLz48Zz48cmVjdCB4PSIxNDIiIHk9IjEyIiB3aWR0aD0iMTAwIiBoZWlnaHQ9IjUwIiBmaWxsPSIjZmZmZmZmIiBzdHJva2U9IiMwMDAwMDAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48cGF0aCBkPSJNIDE5MiA2MiBMIDE5MiA2MTIiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBzdHJva2UtZGFzaGFycmF5PSIzIDMiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgY2VudGVyOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiA5OHB4OyBoZWlnaHQ6IDFweDsgcGFkZGluZy10b3A6IDM3cHg7IG1hcmdpbi1sZWZ0OiAxNDNweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMnB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgd2hpdGUtc3BhY2U6IG5vcm1hbDsgd29yZC13cmFwOiBub3JtYWw7ICI+U2VydmljZS9BcHA8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjxyZWN0IHg9IjE4NyIgeT0iMTQyIiB3aWR0aD0iMTAiIGhlaWdodD0iNDcwIiBmaWxsPSIjZmZmZmZmIiBzdHJva2U9IiMwMDAwMDAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZWxsaXBzZSBjeD0iMTIiIGN5PSI3IiByeD0iNSIgcnk9IjUiIGZpbGw9IiNmZmZmZmYiIHN0cm9rZT0iIzAwMDAwMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxwYXRoIGQ9Ik0gMTIgMTIgTCAxMiAyOC42NyBNIDEyIDE1LjMzIEwgMiAxNS4zMyBNIDEyIDE1LjMzIEwgMjIgMTUuMzMgTSAxMiAyOC42NyBMIDIgNDIgTSAxMiAyOC42NyBMIDIyIDQyIiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxwYXRoIGQ9Ik0gMTIgNDIgTCAxMiA2MTIiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBzdHJva2UtZGFzaGFycmF5PSIzIDMiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgZmxleC1zdGFydDsganVzdGlmeS1jb250ZW50OiB1bnNhZmUgY2VudGVyOyB3aWR0aDogMThweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiA0NXB4OyBtYXJnaW4tbGVmdDogM3B4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyBiYWNrZ3JvdW5kLWNvbG9yOiAjZmZmZmZmOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3b3JkLXdyYXA6IG5vcm1hbDsgIj5Vc2VyPC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0PjwvZz48cmVjdCB4PSI3IiB5PSI3MiIgd2lkdGg9IjEwIiBoZWlnaHQ9IjU0MCIgZmlsbD0iI2ZmZmZmZiIgc3Ryb2tlPSIjMDAwMDAwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PHJlY3QgeD0iMjkyIiB5PSIxMiIgd2lkdGg9IjE0MCIgaGVpZ2h0PSI1MCIgZmlsbD0iI2ZmZmZmZiIgc3Ryb2tlPSIjMDAwMDAwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PHBhdGggZD0iTSAzNjIgNjIgTCAzNjIgNjEyIiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgc3Ryb2tlLWRhc2hhcnJheT0iMyAzIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KSI+PGZvcmVpZ25PYmplY3Qgc3R5bGU9Im92ZXJmbG93OiB2aXNpYmxlOyB0ZXh0LWFsaWduOiBsZWZ0OyIgcG9pbnRlci1ldmVudHM9Im5vbmUiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGNlbnRlcjsganVzdGlmeS1jb250ZW50OiB1bnNhZmUgY2VudGVyOyB3aWR0aDogMTM4cHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMzdweDsgbWFyZ2luLWxlZnQ6IDI5M3B4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3b3JkLXdyYXA6IG5vcm1hbDsgIj5UaWtUb2sgU2hvcCBPcGVuIEF1dGhvcml6YXRpb24gQ2VudGVyPC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0PjwvZz48cmVjdCB4PSIzNTciIHk9IjcyIiB3aWR0aD0iMTAiIGhlaWdodD0iNDAwIiBmaWxsPSIjZmZmZmZmIiBzdHJva2U9IiMwMDAwMDAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48cmVjdCB4PSI0ODIiIHk9IjEyIiB3aWR0aD0iMTQwIiBoZWlnaHQ9IjUwIiBmaWxsPSIjZmZmZmZmIiBzdHJva2U9IiMwMDAwMDAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48cGF0aCBkPSJNIDU1MiA2MiBMIDU1MiA2MTIiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBzdHJva2UtZGFzaGFycmF5PSIzIDMiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgY2VudGVyOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxMzhweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiAzN3B4OyBtYXJnaW4tbGVmdDogNDgzcHg7Ij48ZGl2IHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LXNpemU6IDA7IHRleHQtYWxpZ246IGNlbnRlcjsgIj48ZGl2IHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtc2l6ZTogMTJweDsgZm9udC1mYW1pbHk6IEhlbHZldGljYTsgY29sb3I6ICMwMDAwMDA7IGxpbmUtaGVpZ2h0OiAxLjI7IHBvaW50ZXItZXZlbnRzOiBhbGw7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdvcmQtd3JhcDogbm9ybWFsOyAiPlRpa1RvayBTaG9wIE9wZW4gQVBJPC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0PjwvZz48cmVjdCB4PSI1NDciIHk9IjUxMiIgd2lkdGg9IjEwIiBoZWlnaHQ9IjEwMCIgZmlsbD0iI2ZmZmZmZiIgc3Ryb2tlPSIjMDAwMDAwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PHBhdGggZD0iTSAyMiAxMDIgTCAzNDMuODggMTAyIiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9InN0cm9rZSIvPjxwYXRoIGQ9Ik0gMzUwLjg4IDEwMiBMIDM0My44OCAxMDUuNSBMIDM0My44OCA5OC41IFoiIGZpbGw9IiMwMDAwMDAiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KSI+PGZvcmVpZ25PYmplY3Qgc3R5bGU9Im92ZXJmbG93OiB2aXNpYmxlOyB0ZXh0LWFsaWduOiBsZWZ0OyIgcG9pbnRlci1ldmVudHM9Im5vbmUiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGZsZXgtZW5kOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMTI5cHg7IG1hcmdpbi1sZWZ0OiAxOTJweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMXB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgYmFja2dyb3VuZC1jb2xvcjogI2ZmZmZmZjsgd2hpdGUtc3BhY2U6IG5vd3JhcDsgIj5BY2Nlc3MgdG8gc3Vic2NyaXB0aW9uL2F1dGhvcml6YXRpb24gbGlua3MgPGJyIC8+dGhyb3VnaCB0aGUgU2VydmljZSBNYXJrZXRwbGFjZTwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48L2c+PHBhdGggZD0iTSAzNTcgMzEyLjIgTCAyMDQuMjQgMzEyIiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgc3Ryb2tlLWRhc2hhcnJheT0iMyAzIiBwb2ludGVyLWV2ZW50cz0ic3Ryb2tlIi8+PHBhdGggZD0iTSAyMTIuMTIgMzA3LjUxIEwgMjAzLjEyIDMxMiBMIDIxMi4xMSAzMTYuNTEiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KSI+PGZvcmVpZ25PYmplY3Qgc3R5bGU9Im92ZXJmbG93OiB2aXNpYmxlOyB0ZXh0LWFsaWduOiBsZWZ0OyIgcG9pbnRlci1ldmVudHM9Im5vbmUiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGZsZXgtZW5kOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMzQwcHg7IG1hcmdpbi1sZWZ0OiAyNzdweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMXB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgYmFja2dyb3VuZC1jb2xvcjogI2ZmZmZmZjsgd2hpdGUtc3BhY2U6IG5vd3JhcDsgIj5DYWxsYmFjayByZWRpcmVjdCBVUkwgPGJyIC8+YW5kIGdldCBhdXRoIGNvZGU8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjxwYXRoIGQ9Ik0gMjAyIDE3MiBMIDM0NC4zOCAxNzIiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0ic3Ryb2tlIi8+PHBhdGggZD0iTSAzNTEuMzggMTcyIEwgMzQ0LjM4IDE3NS41IEwgMzQ0LjM4IDE2OC41IFoiIGZpbGw9IiMwMDAwMDAiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KSI+PGZvcmVpZ25PYmplY3Qgc3R5bGU9Im92ZXJmbG93OiB2aXNpYmxlOyB0ZXh0LWFsaWduOiBsZWZ0OyIgcG9pbnRlci1ldmVudHM9Im5vbmUiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGZsZXgtZW5kOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMTk5cHg7IG1hcmdpbi1sZWZ0OiAyNzNweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMXB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgYmFja2dyb3VuZC1jb2xvcjogI2ZmZmZmZjsgd2hpdGUtc3BhY2U6IG5vd3JhcDsgIj5BY2Nlc3Mgc2VydmljZSBzcGxpY2luZyA8YnIgLz5hdXRob3JpemF0aW9uIGxpbms8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjxwYXRoIGQ9Ik0gMjIgMTcyIEwgMTczLjM4IDE3MiIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJzdHJva2UiLz48cGF0aCBkPSJNIDE4MC4zOCAxNzIgTCAxNzMuMzggMTc1LjUgTCAxNzMuMzggMTY4LjUgWiIgZmlsbD0iIzAwMDAwMCIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgZmxleC1lbmQ7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDFweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiAxODlweDsgbWFyZ2luLWxlZnQ6IDEwMnB4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDExcHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyBiYWNrZ3JvdW5kLWNvbG9yOiAjZmZmZmZmOyB3aGl0ZS1zcGFjZTogbm93cmFwOyAiPkFjY2VzcyBzZXJ2aWNlIHdlYnNpdGUgbGluazwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48L2c+PHBhdGggZD0iTSAyMDIgMzgyLjUgTCAzNDQuMzggMzgyLjUiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0ic3Ryb2tlIi8+PHBhdGggZD0iTSAzNTEuMzggMzgyLjUgTCAzNDQuMzggMzg2IEwgMzQ0LjM4IDM3OSBaIiBmaWxsPSIjMDAwMDAwIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSkiPjxmb3JlaWduT2JqZWN0IHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiIHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIj48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBmbGV4LWVuZDsganVzdGlmeS1jb250ZW50OiB1bnNhZmUgY2VudGVyOyB3aWR0aDogMXB4OyBoZWlnaHQ6IDFweDsgcGFkZGluZy10b3A6IDQxMHB4OyBtYXJnaW4tbGVmdDogMjczcHg7Ij48ZGl2IHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LXNpemU6IDA7IHRleHQtYWxpZ246IGNlbnRlcjsgIj48ZGl2IHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtc2l6ZTogMTFweDsgZm9udC1mYW1pbHk6IEhlbHZldGljYTsgY29sb3I6ICMwMDAwMDA7IGxpbmUtaGVpZ2h0OiAxLjI7IHBvaW50ZXItZXZlbnRzOiBhbGw7IGJhY2tncm91bmQtY29sb3I6ICNmZmZmZmY7IHdoaXRlLXNwYWNlOiBub3dyYXA7ICI+VXNlIGF1dGggY29kZSB0byA8YnIgLz5nZXQgYWNjZXNzX3Rva2VuPC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0PjwvZz48cGF0aCBkPSJNIDM1MiA0NTYuNSBMIDIwNC4yNCA0NTYuNSIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHN0cm9rZS1kYXNoYXJyYXk9IjMgMyIgcG9pbnRlci1ldmVudHM9InN0cm9rZSIvPjxwYXRoIGQ9Ik0gMjEyLjEyIDQ1MiBMIDIwMy4xMiA0NTYuNSBMIDIxMi4xMiA0NjEiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KSI+PGZvcmVpZ25PYmplY3Qgc3R5bGU9Im92ZXJmbG93OiB2aXNpYmxlOyB0ZXh0LWFsaWduOiBsZWZ0OyIgcG9pbnRlci1ldmVudHM9Im5vbmUiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGZsZXgtZW5kOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogNDcwcHg7IG1hcmdpbi1sZWZ0OiAyNzJweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMXB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgYmFja2dyb3VuZC1jb2xvcjogI2ZmZmZmZjsgd2hpdGUtc3BhY2U6IG5vd3JhcDsgIj7CoHJldHVybiBhY2Nlc3NfdG9rZW48L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjxwYXRoIGQ9Ik0gMjAyIDUzMi41IEwgNTMzLjg4IDUzMi41IiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9InN0cm9rZSIvPjxwYXRoIGQ9Ik0gNTQwLjg4IDUzMi41IEwgNTMzLjg4IDUzNiBMIDUzMy44OCA1MjkgWiIgZmlsbD0iIzAwMDAwMCIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgZmxleC1lbmQ7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDFweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiA1MzBweDsgbWFyZ2luLWxlZnQ6IDM3MnB4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDExcHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyBiYWNrZ3JvdW5kLWNvbG9yOiAjZmZmZmZmOyB3aGl0ZS1zcGFjZTogbm93cmFwOyAiPlVzZSBhY2Nlc3NfdG9rZW4gdG8gY2FsbCBPcGVuIEFQSTwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48L2c+PHBhdGggZD0iTSA1NDIgNjAyIEwgMjAyLjI0IDYwMi40MSIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJzdHJva2UiLz48cGF0aCBkPSJNIDIxMC4xMSA1OTcuOSBMIDIwMS4xMiA2MDIuNDEgTCAyMTAuMTIgNjA2LjkiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KSI+PGZvcmVpZ25PYmplY3Qgc3R5bGU9Im92ZXJmbG93OiB2aXNpYmxlOyB0ZXh0LWFsaWduOiBsZWZ0OyIgcG9pbnRlci1ldmVudHM9Im5vbmUiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGZsZXgtZW5kOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogNTk5cHg7IG1hcmdpbi1sZWZ0OiAzNzFweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMXB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgYmFja2dyb3VuZC1jb2xvcjogI2ZmZmZmZjsgd2hpdGUtc3BhY2U6IG5vd3JhcDsgIj5SZXR1cm4gdGhlIHJlc3VsdCBvZiBBUEkgY2FsbDwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48L2c+PHBhdGggZD0iTSAxODIgNjAyLjUgTCAyNC4yNCA2MDIuNSIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJzdHJva2UiLz48cGF0aCBkPSJNIDMyLjEyIDU5OCBMIDIzLjEyIDYwMi41IEwgMzIuMTIgNjA3IiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSkiPjxmb3JlaWduT2JqZWN0IHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiIHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIj48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBmbGV4LWVuZDsganVzdGlmeS1jb250ZW50OiB1bnNhZmUgY2VudGVyOyB3aWR0aDogMXB4OyBoZWlnaHQ6IDFweDsgcGFkZGluZy10b3A6IDYwMHB4OyBtYXJnaW4tbGVmdDogMTAycHg7Ij48ZGl2IHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LXNpemU6IDA7IHRleHQtYWxpZ246IGNlbnRlcjsgIj48ZGl2IHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtc2l6ZTogMTFweDsgZm9udC1mYW1pbHk6IEhlbHZldGljYTsgY29sb3I6ICMwMDAwMDA7IGxpbmUtaGVpZ2h0OiAxLjI7IHBvaW50ZXItZXZlbnRzOiBhbGw7IGJhY2tncm91bmQtY29sb3I6ICNmZmZmZmY7IHdoaXRlLXNwYWNlOiBub3dyYXA7ICI+RGlzcGxheSBBUEkgY2FsbCByZXN1bHRzPC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0PjwvZz48cGF0aCBkPSJNIDIyIDI0MiBMIDM0My44OCAyNDIiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0ic3Ryb2tlIi8+PHBhdGggZD0iTSAzNTAuODggMjQyIEwgMzQzLjg4IDI0NS41IEwgMzQzLjg4IDIzOC41IFoiIGZpbGw9IiMwMDAwMDAiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PHJlY3QgeD0iNjIiIHk9IjI0MiIgd2lkdGg9IjQwIiBoZWlnaHQ9IjIwIiBmaWxsPSJub25lIiBzdHJva2U9Im5vbmUiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgY2VudGVyOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMjUycHg7IG1hcmdpbi1sZWZ0OiA4MnB4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyB3aGl0ZS1zcGFjZTogbm93cmFwOyAiPkxvZ2luIHNlbGxlciBjZW50ZXI8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjxwYXRoIGQ9Ik0gMjAyIDIwMiBMIDM2NiAyMDIgTCAzNzIgMjA4IEwgMzcyIDIzMiBMIDIwMiAyMzIgTCAyMDIgMjAyIFoiIGZpbGw9IiNmZmZmY2MiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PHBhdGggZD0iTSAzNjYgMjAyIEwgMzY2IDIwOCBMIDM3MiAyMDggWiIgZmlsbC1vcGFjaXR5PSIwLjA1IiBmaWxsPSIjMDAwMDAwIiBzdHJva2U9Im5vbmUiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48cGF0aCBkPSJNIDM2NiAyMDIgTCAzNjYgMjA4IEwgMzcyIDIwOCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgY2VudGVyOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxNjhweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiAyMTdweDsgbWFyZ2luLWxlZnQ6IDIwM3B4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3b3JkLXdyYXA6IG5vcm1hbDsgIj5QYXJhbWV0ZXJzIHNlcnZpY2VfaWQvYXBwX2tleeOAgXN0YXRlPC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0PjwvZz48cGF0aCBkPSJNIDIyIDI2MiBMIDE3NiAyNjIgTCAxODIgMjY4IEwgMTgyIDI5MiBMIDIyIDI5MiBMIDIyIDI2MiBaIiBmaWxsPSIjZmZmZmNjIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxwYXRoIGQ9Ik0gMTc2IDI2MiBMIDE3NiAyNjggTCAxODIgMjY4IFoiIGZpbGwtb3BhY2l0eT0iMC4wNSIgZmlsbD0iIzAwMDAwMCIgc3Ryb2tlPSJub25lIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PHBhdGggZD0iTSAxNzYgMjYyIEwgMTc2IDI2OCBMIDE4MiAyNjgiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KSI+PGZvcmVpZ25PYmplY3Qgc3R5bGU9Im92ZXJmbG93OiB2aXNpYmxlOyB0ZXh0LWFsaWduOiBsZWZ0OyIgcG9pbnRlci1ldmVudHM9Im5vbmUiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGNlbnRlcjsganVzdGlmeS1jb250ZW50OiB1bnNhZmUgY2VudGVyOyB3aWR0aDogMTU4cHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMjc3cHg7IG1hcmdpbi1sZWZ0OiAyM3B4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3b3JkLXdyYXA6IG5vcm1hbDsgIj5JbnB1dCBhY2NvdW50IGFuZCBwYXNzd29yZDwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48L2c+PHBhdGggZD0iTSAzMDIgMTEyIEwgNDY2IDExMiBMIDQ3MiAxMTggTCA0NzIgMTQyIEwgMzAyIDE0MiBMIDMwMiAxMTIgWiIgZmlsbD0iI2ZmZmZjYyIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48cGF0aCBkPSJNIDQ2NiAxMTIgTCA0NjYgMTE4IEwgNDcyIDExOCBaIiBmaWxsLW9wYWNpdHk9IjAuMDUiIGZpbGw9IiMwMDAwMDAiIHN0cm9rZT0ibm9uZSIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxwYXRoIGQ9Ik0gNDY2IDExMiBMIDQ2NiAxMTggTCA0NzIgMTE4IiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSkiPjxmb3JlaWduT2JqZWN0IHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiIHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIj48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDE2OHB4OyBoZWlnaHQ6IDFweDsgcGFkZGluZy10b3A6IDEyN3B4OyBtYXJnaW4tbGVmdDogMzAzcHg7Ij48ZGl2IHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LXNpemU6IDA7IHRleHQtYWxpZ246IGNlbnRlcjsgIj48ZGl2IHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtc2l6ZTogMTJweDsgZm9udC1mYW1pbHk6IEhlbHZldGljYTsgY29sb3I6ICMwMDAwMDA7IGxpbmUtaGVpZ2h0OiAxLjI7IHBvaW50ZXItZXZlbnRzOiBhbGw7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdvcmQtd3JhcDogbm9ybWFsOyAiPlBhcmFtZXRlcnMgc2VydmljZV9pZC9hcHBfa2V5PC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0PjwvZz48cGF0aCBkPSJNIDIwMiA0MTIgTCA1MzYgNDEyIEwgNTQyIDQxOCBMIDU0MiA0NDIgTCAyMDIgNDQyIEwgMjAyIDQxMiBaIiBmaWxsPSIjZmZmZmNjIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxwYXRoIGQ9Ik0gNTM2IDQxMiBMIDUzNiA0MTggTCA1NDIgNDE4IFoiIGZpbGwtb3BhY2l0eT0iMC4wNSIgZmlsbD0iIzAwMDAwMCIgc3Ryb2tlPSJub25lIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PHBhdGggZD0iTSA1MzYgNDEyIEwgNTM2IDQxOCBMIDU0MiA0MTgiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KSI+PGZvcmVpZ25PYmplY3Qgc3R5bGU9Im92ZXJmbG93OiB2aXNpYmxlOyB0ZXh0LWFsaWduOiBsZWZ0OyIgcG9pbnRlci1ldmVudHM9Im5vbmUiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGNlbnRlcjsganVzdGlmeS1jb250ZW50OiB1bnNhZmUgY2VudGVyOyB3aWR0aDogMzM4cHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogNDI3cHg7IG1hcmdpbi1sZWZ0OiAyMDNweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMnB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgd2hpdGUtc3BhY2U6IG5vcm1hbDsgd29yZC13cmFwOiBub3JtYWw7ICI+UGFyYW1ldGVycyBhcHBfa2V544CBYXBwX3NlY3JldOOAgWF1dGhfY29kZeOAgWdyYW50X3R5cGXjgIFncmFudGVkX3Njb3BlczwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48L2c+PHBhdGggZD0iTSAyMDIgNDc2IEwgNTM2IDQ3NiBMIDU0MiA0ODIgTCA1NDIgNTA2IEwgMjAyIDUwNiBMIDIwMiA0NzYgWiIgZmlsbD0iI2ZmZmZjYyIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48cGF0aCBkPSJNIDUzNiA0NzYgTCA1MzYgNDgyIEwgNTQyIDQ4MiBaIiBmaWxsLW9wYWNpdHk9IjAuMDUiIGZpbGw9IiMwMDAwMDAiIHN0cm9rZT0ibm9uZSIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxwYXRoIGQ9Ik0gNTM2IDQ3NiBMIDUzNiA0ODIgTCA1NDIgNDgyIiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSkiPjxmb3JlaWduT2JqZWN0IHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiIHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIj48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDMzOHB4OyBoZWlnaHQ6IDFweDsgcGFkZGluZy10b3A6IDQ5MXB4OyBtYXJnaW4tbGVmdDogMjAzcHg7Ij48ZGl2IHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LXNpemU6IDA7IHRleHQtYWxpZ246IGNlbnRlcjsgIj48ZGl2IHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtc2l6ZTogMTJweDsgZm9udC1mYW1pbHk6IEhlbHZldGljYTsgY29sb3I6ICMwMDAwMDA7IGxpbmUtaGVpZ2h0OiAxLjI7IHBvaW50ZXItZXZlbnRzOiBhbGw7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdvcmQtd3JhcDogbm9ybWFsOyAiPlJlc3BvbnNlIFBhcmFtZXRlcnMgYWNjZXNzX3Rva2Vu44CBcmVmcmVzaF90b2tlbuOAgW9wZW5faWQ8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjwvZz48L3N2Zz4=)

1. The user opens your authorization link and approves (or rejects) the request.
2. On approval, the user is redirected to your **Redirect URL** with a temporary `code`:

```Plain Text
{redirect_url}?code=FeBoANmHP3yqdoUI9fZOCw&state={state}
```

If the user rejects, they are still redirected, but `code` is null: `code=null&error=auth_denied`.
> ❗ **Important:** The `auth_code` expires in **30 minutes** and can be used **only once**. Exchange it for tokens immediately.

1. Your app exchanges the `code` (passed as `auth_code`) for tokens via the Get Access Token API.

### Get Access Token API
Make a `GET` request to `https://auth.tiktok-shops.com/api/v2/token/get` with the following parameters:
| Parameter | Type | Required? | Description | Sample |
| --- | --- | --- | --- | --- |
| `app_key` | string | Yes | App key from the Partner Center app page. | 123abc |
| `app_secret` | string | Yes | App secret from the Partner Center app page. | (your app secret) |
| `auth_code` | string | Yes | Authorization code obtained from the authorization link. | TTP_FeBoANmHP3yqdoUI9fZOCw |
| `grant_type` | string | Yes | Grant token type. Only `authorized_code` is accepted. | authorized_code |
> **On** **`grant_type=authorized_code`:** this value is intentional and correct for the TikTok Shop token API — it is **not** the standard OAuth `authorization_code`. Do not "fix" it to `authorization_code`, or the request will fail.

Your request should resemble:
```Plain Text
https://auth.tiktok-shops.com/api/v2/token/get?app_key=123abc
&app_secret={your_app_secret}
&auth_code=TTP_FeBoANmHP3yqdoUI9fZOCw
&grant_type=authorized_code
```

If all parameters are valid, the response contains:
| Field | Type | Description | Sample |
| --- | --- | --- | --- |
| `code` | int | Machine-readable result code. `0` = success. See Common error codes. | 0 |
| `message` | string | Human-readable result message. | success |
| `request_id` | string | ID to track the API request. | 2024080809462301024509910319695C45 |
| `data.access_token` | string | User access token. Pass it in the `x-tts-access-token` header of API requests. | TTP_RLM6CIADWF606TZGFO5XGA |
| `data.access_token_expire_in` | Unix timestamp | Access token expiration (default validity: **7 days**). | 1660556783 |
| `data.refresh_token` | string | Token used to refresh the access token. | TTP_C2XWDN63ON-FOHJSMR0WSG |
| `data.refresh_token_expire_in` | Unix timestamp | Refresh token expiration (equals the authorization duration the user granted). | 1691487031 |
| `data.open_id` | string | ID identifying the authorizing user. | 7010736057180325637 |
| `data.seller_name` | string | Name of the authorizing seller. | Test Seller |
| `data.seller_base_region` | string | Region where the seller is based. | US |
| `data.user_type` | int | Type of authorizing user. See the enumeration below. | 0 |
| `data.granted_scopes` | []string | The **Scope Key** values authorized for the app. | ["seller.affiliate_collaboration.read", "seller.affiliate_collaboration.write"] |
```Plain Text
{
  "code": 0,
  "message": "success",
  "request_id": "2024080809462301024509910319695C45",
  "data": {
    "access_token": "TTP_Fw8rBwAAAAAkW03FYd09DG-9INtpw361hWthei8S3fHX8iPJ5AUv99fLSCYD9-UucaqxTgNRzKZxi5",
    "access_token_expire_in": 1660556783,
    "refresh_token": "TTP_NTUxZTNhYTQ2ZDk2YmRmZWNmYWY2YWY2YzkxNGYwNjQ3YjkzYTllYjA0YmNlMw",
    "refresh_token_expire_in": 1691487031,
    "open_id": "7010736057180325637",
    "seller_name": "Test Seller",
    "seller_base_region": "US",
    "user_type": 0,
    "granted_scopes": [
      "seller.affiliate_collaboration.read",
      "seller.affiliate_collaboration.write"
    ]
  }
}
```

### `user_type` enumeration
The `user_type` field tells you which kind of user authorized your app:
| Value | User type | Notes |
| --- | --- | --- |
| 0 | Seller | Standard seller authorization. |
| 1 | Creator | Affiliate creator authorization. |
| 2 | Partner | Legacy partner type. |
| 3 | Partner | Current partner type used for Affiliate Partner / TAP authorization. |
| 4 | Global Selling seller | Cross-border / Global Selling. |
| 5 | Global Selling seller | Current Global Selling type. |
> Match the value you receive against this table — for example, creator integrations should receive `1`, and Affiliate Partner (TAP) integrations should receive `3`. If you receive an unexpected value, verify that the user authorized through the correct authorization link for your app type.

### Get Refresh Token API
Access tokens expire (default 7 days). Before expiry, refresh them by making a `GET` request to `https://auth.tiktok-shops.com/api/v2/token/refresh`:
| Parameter | Type | Required? | Description | Sample |
| --- | --- | --- | --- | --- |
| `app_key` | string | Yes | App key from the Partner Center app page. | 123abc |
| `app_secret` | string | Yes | App secret from the Partner Center app page. | (your app secret) |
| `refresh_token` | string | Yes | Refresh token from the Get Access Token response. | TTP_C2XWDN63ON-FOHJSMR0WSG |
| `grant_type` | string | Yes | Grant token type. Only `refresh_token` is accepted. | refresh_token |
Your request should resemble:
```Plain Text
https://auth.tiktok-shops.com/api/v2/token/refresh?app_key=123abc
&app_secret={your_app_secret}
&refresh_token=TTP_C2XWDN63ON-FOHJSMR0WSG
&grant_type=refresh_token
```

The response has the same shape as Get Access Token. Note the corrected JSON (every field is comma-separated):
```Plain Text
{
  "code": 0,
  "message": "success",
  "request_id": "2024080809462301024509910319695C45",
  "data": {
    "access_token": "TTP_Fw8rBwAAAAAkW03FYd09DG-9INtpw361hWthei8S3fHX8iPJ5AUv99fLSCYD9-UucaqxTgNRzKZxi5",
    "access_token_expire_in": 1660556783,
    "refresh_token": "TTP_NTUxZTNhYTQ2ZDk2YmRmZWNmYWY2YWY2YzkxNGYwNjQ3YjkzYTllYjA0YmNlMw",
    "refresh_token_expire_in": 1691487031,
    "open_id": "7010736057180325637",
    "seller_name": "Test Seller",
    "seller_base_region": "US",
    "user_type": 0,
    "granted_scopes": [
      "seller.affiliate_collaboration.read",
      "seller.affiliate_collaboration.write"
    ]
  }
}
```

### State parameter (recommended)
Add a `state` parameter to your authorization link for CSRF protection. It should be an unguessable, server-generated, single-use random string that you validate on callback. See the [OpenID Connect documentation](https://developers.google.com/identity/protocols/oauth2/openid-connect#createxsrftoken) for an example of creating and confirming a `state`.
### Common questions
Token retrieval/refresh and understanding `user_type` are among the most frequent authorization support topics. Before contacting support, double-check:

* `grant_type` is exactly `authorized_code` (get) or `refresh_token` (refresh).
* Your `auth_code` is fresh (≤ 30 minutes old) and unused.
* You're using the correct authorization domain for your market and app type (see the table above).

For more help, see How to contact support.
### Enable API Scope
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/84f5bb18084348f585eade8b61db9111~tplv-k9wyc2ijk0-image.image)
Before developing an app, the developer should enable or apply for the necessary API scope depending on the app's business type.
📌 Note: Enabling unnecessary scope(s) could result in a longer app review time and lower user authorization rate.


---

## Get started > Authorization > Seller authorization guide

Doc: https://partner.tiktokshop.com/docv2/page/seller-authorization-guide · cập nhật 2026-06-29

This guide explains how a **seller** authorizes your app, covering both the direct authorization link and the Seller Center App Store flow, plus renewing and canceling authorization.
> **Which guide do I read?** Start with the Authorization overview for concepts and the token APIs. Use the step-by-step seller authorization guide for the full get-code → exchange-token → refresh sequence. This page focuses on the seller-facing authorization experience (link vs. app store) and the authorization lifecycle.

#### Two ways a seller can authorize
| Path | Applies to | Entry point |
| --- | --- | --- |
| **Authorization link** | Custom and public apps | You share a **Copy authorization link** URL with the seller. |
| **Seller Center App Store** | **Public apps only** | The seller installs your published app from the App Store. See Authorization via app store. |
#### Authorization via the authorization link
After a seller opens your authorization link, they go through these steps. (Each step below corresponds to a screen in Partner Center; the text describes what the seller does so you can follow along without relying solely on the screenshots.)

1. **Authorization prompt.** The seller sees the consent prompt listing the scopes your app requests, and clicks **Next** under the correct region.
2. **Log in.** The seller logs in to their TikTok Shop seller account (or creates one). If a Seller Center account is already signed in — or they're using a Seller Center test account — this step is skipped.
3. **Confirm details.** The seller reviews and confirms the required information on the form shown.
4. **Approve.** The seller approves authorization for your app.
5. **Redirect.** The seller is redirected to your **Redirect URL**, which carries the temporary `code` (used as `auth_code`) and your `state`. Exchange it for tokens as described in the step-by-step guide.

> ❗ **Important:** After successful approval, the seller is redirected to the **Redirect URL** you configured in your app. This URL contains the `auth_code` needed for the next step.

#### What "log in to your app to finish" means
After the redirect, the seller may need to **sign in to your application** (the developer-side product, not TikTok Shop) so your app can associate the new authorization with the seller's account in your system. Implement your Redirect URL handler to read the `code`/`state`, complete sign-in, and then exchange the `auth_code` for tokens.
#### Renew authorization
30 days before an authorization expires, an **Upcoming authorization expiration** webhook is triggered (subscribe to it and inspect its payload in the Webhooks overview). To renew, ask the seller to either:

* Open the authorization link again, or
* Navigate to **TikTok Shop Seller Center > App Store > My apps and incidents**.

#### Cancel authorization
A seller can cancel authorization under **TikTok Shop Seller Center > App Store > My apps and incidents**. This triggers a **Seller deauthorization** webhook — subscribe to it via the Webhooks overview so your app can revoke stored tokens and stop calling APIs for that seller.
#### Testing authorization (development stage)
While your app is in development, online sellers can't authorize it. For testing, use a Seller Center **test account** via the **Development Shops** section of Partner Center. This is the same development-shop flow described in the step-by-step guide — with a test account you go straight to the **seller authorization approval** step and can generate an access token without an authorization link. See the [Seller Center Development Shops User Guide](seller-center-development-shops) to create one.

###


---

## Get started > Authorization > Creator authorization guide

Doc: https://partner.tiktokshop.com/docv2/page/creator-authorization-guide · cập nhật 2026-06-29

#### This guide is intended for

* apps that need to call **Affiliate Creator APIs**
* integrations that need creator-side affiliate data or capabilities

#### What does creator authorization do?
After creator authorization, the app can call **Affiliate Creator** APIs.
#### Core concept
Creator authorization means:**a creator grants your TikTok Shop app access to creator-side data and capabilities**, so that your app can call the relevant Creator Open APIs.
At its core, the flow is still OAuth-based:

1. Build an authorization link
2. Let the user log in and approve authorization
3. Receive a callback with `code`
4. Exchange the `code` for tokens
5. Use the token to call Creator APIs

Creator authorization is different from Seller authorization. A creator token and a seller token are different credentials and must not be reused interchangeably.
#### Prerequisites
Before starting Creator authorization, make sure the following are ready:
##### App-side prerequisites

* the app is created
* API access is enabled
* a valid Redirect URL is configured
* the required creator scopes are enabled or approved
* if the creator capability is still beta / allowlist based, the app is approved for that rollout

##### Creator-side prerequisites
the user is a real TikTok Shop creator, not just a regular TikTok account. The creator can enroll as a TikTok Shop creator by following the guides for the respective countries:

* [Indonesia](https://seller-id.tokopedia.com/university/essay?identity=1&role=2&knowledge_id=6837812658128641&from=feature_guide)
* [Ireland](https://seller-ie.tiktok.com/university/essay?identity=1&role=1&knowledge_id=8607911547799328)
* [Malaysia](https://seller-my.tiktok.com/university/essay?identity=1&role=2&knowledge_id=6837863837042434&from=feature_guide)
* [Philippines](https://seller-ph.tiktok.com/university/course?identity=1&role=2&learning_id=1295010259994369&from=course&content_id=3904538843121410)
* [Singapore](https://seller-sg.tiktok.com/university/essay?identity=1&role=2&knowledge_id=7996132844111617&from=feature_guide)
* [Thailand](https://seller-th.tiktok.com/university/essay?identity=1&role=2&knowledge_id=6837882170361601&from=feature_guide)
* [United Kingdom](https://business.tiktokshop.com/uk/creator)
* [United States](https://business.tiktokshop.com/us/creator)
* [Vietnam](https://seller-vn.tiktok.com/university/essay?knowledge_id=6837838528808705&role=2&course_type=1&from=search&identity=1)

The creator's selection region must be one of the app's target markets:

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/da92625047284a57a428a83e8238070e~tplv-k9wyc2ijk0-image.image)

If your app is in development, please contact your App Store Manager for a Creator testing account. Creator test accounts are only available to members of our beta phase today.
#### End-to-end authorization flow
A practical Creator authorization flow can be understood in 7 steps:

1. prepare the app
2. enable creator scopes
3. build the creator authorization link
4. let the creator sign in and authorize
5. receive `code` and `state` on the Redirect URL
6. exchange the `auth_code` for `access_token` / `refresh_token`
7. call Creator Open APIs and validate `granted_scopes`

#### Step 1: Prepare the app
In Partner Center, make sure you have:

* created the app / service
* enabled API access
* configured the Redirect URL
* obtained `app_key` / `app_secret`
* enabled the required creator scopes in Manage API

The Redirect URL is the callback destination after successful authorization. In production, it should be a real server-side endpoint that can validate the callback parameters, especially `state`.
#### Step 2: Enable creator scopes
These are the creator scopes enabled or approved in Partner Center.
Go to APP & Service -> Manage API, then look for scope keys prefixed with `creator` (for example, `creator.xxx`). The available creator scope keys are listed on this page:

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/af1aae58156a441eab22e689fe303a4a~tplv-k9wyc2ijk0-image.image)
#### Step 3: Build the authorization link
The basic authorization link can be obtained from the **Copy authorization link** button.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/50cebad58c7f41c78c73e2fbe453b000~tplv-k9wyc2ijk0-image.image)

For creator authorization links, you are **required to manually** add a `state` parameter for extra security. The `state` is an unguessable random string that can help protect cross-site request forgery attacks, and is **not automatically included** in the basic authorization link.
Please see the [OpenID Connect](https://developers.google.com/identity/protocols/oauth2/openid-connect#createxsrftoken) documentation for an example of how to create and confirm a `state`. When encoding a state, remove leading and trailing white spaces.
Additionally, you may manually concatenate the entire authorization link by using your `app_key` and `state`.
The final authorization link should resemble:
PLAIN
Word Wrap
```Plain Text
https://shop.tiktok.com/alliance/creator/auth?app_key={your_app_key}&state={your_state}
```

A complete link with example values looks like:
```Plain Text
https://shop.tiktok.com/alliance/creator/auth?app_key=6h7k2m9p1q3r5s7t&state=af0ifjsldkj3k3kdj
```

Parameters：

* `app_key`: your application identifier
* `state`: a security parameter that should be generated server-side

State best practices：

* generate it on the server side
* make it random and unpredictable
* bind it to the current authorization session
* validate it strictly on callback
* treat it as single-use to reduce replay risk

Do not embed passwords, tokens, or other sensitive data directly into `state`.
**Note:** Creator authorization uses a different endpoint and parameter from Seller authorization. Creator links use the `shop.tiktok.com/alliance/creator/auth` endpoint with `app_key`, while Seller links use the `services.{region}.tiktokshop.com/open/authorize` endpoint with `service_id`; the two are not interchangeable. `state` is also required for creator authorization links (it is optional for seller authorization), so you must add it manually as shown above.
#### Step 4: Let the creator sign in and authorize
After opening the authorization link, the creator typically:

1. signs in with the TikTok account
2. enters the creator authorization page
3. reviews the requested scopes
4. if the authorization page supports partial authorization, the creator may toggle some scopes on or off
5. clicks Authorize

##### A creator may authorize only part of the requested scopes
This means authorization success does not automatically mean all required business scopes were granted.
#### Step 5: Handle the callback and retrieve the auth code
After the creator approves authorization, the platform redirects back to your Redirect URL with a temporary `code`. Here `code` is the parameter name returned in the callback URL; when you call Get Access Token, pass that same value as `auth_code`.
A typical callback looks like this:
PLAIN
Word Wrap
```Plain Text
{redirect_url}?code={CODE_FROM_CALLBACK}&state={state}
```

##### Recommended handling
Your callback handler should:

* read `code`
* read and validate `state`
* detect callback errors if the user denied authorization
* stop the flow if no valid `code` is returned

The `auth_code` should be treated as short-lived and usually single-use. Exchange it for tokens as soon as possible.
#### Step 6: Exchange the auth code for tokens
Use the Get Access Token endpoint:
PLAIN
Word Wrap
```Plain Text
GET https://auth.tiktok-shops.com/api/v2/token/get
```

##### Required parameters

* `app_key`
* `app_secret`
* `auth_code` (use the `code` returned by the callback URL)
* `grant_type=authorized_code`

##### Key response fields

* `access_token`
* `refresh_token`
* `open_id`
* `user_type`
* `granted_scopes`

##### Validate immediately after token exchange
Always verify:

1. `code == 0`
2. `user_type == 1` (a value of `1` indicates a creator identity)
3. `granted_scopes` covers the minimum scopes required by your business

If these checks fail, do not move directly into business API calls.
#### Step 7: Refresh the token
When the access token expires, refresh it with:
PLAIN
Word Wrap
```Plain Text
GET https://auth.tiktok-shops.com/api/v2/token/refresh
```

##### Required parameters

* `app_key`
* `app_secret`
* `refresh_token`
* `grant_type=refresh_token`

##### After refreshing, re-check key fields

* `user_type`
* `open_id`
* `granted_scopes`

For safety, it is better not to assume the refreshed token behaves identically to the previous token. A safer engineering practice is to revalidate key fields whenever a new token is issued.
#### How to use granted_scopes properly
`granted_scopes` is one of the most important fields in Creator authorization.
Use it at two levels:
##### Level 1: right after authorization
Check whether the creator granted the minimum scopes your business requires.
##### Level 2: before feature execution
Before calling an endpoint, confirm that the required scope is included in `granted_scopes`.
##### Recommended uses

* if authorization succeeded but scopes are incomplete, prompt the creator to reauthorize
* if the API returns `105005`, check both app scopes and token `granted_scopes`
* if your product has multiple modules, maintain a scope-to-feature mapping

#### Partial authorization
Creators can opt in or out what scope to authorize. A creator may not approve all scopes in one pass; callback success does not by itself mean all business-required scopes are available.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/7212f756d8bb4083ba9e7ce0c62a25d0~tplv-k9wyc2ijk0-image.image)
After calling [Get Access Token], please check the `granted_scopes` array in the response, and make sure the creator has authorized all necessary scopes.
The scope keys definition is on the **Manage API** page:
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/79e88b6e2b164c0bae4352e4202ae4c4~tplv-k9wyc2ijk0-image.image)
If the authorized scopes are not sufficient for your business, please ask the creator to "remove all access" and re-authorize again.
#### Reauthorization and deauthorization
Creator authorization can change through the two lifecycle events below.
##### The creator removes all access
Result:

* the old token becomes invalid
* future API calls fail with token invalid / deauthorized style errors

##### The creator disables some scopes
Result:

* APIs under those scopes will start failing with permission errors
* a common error is `105005`

##### Recommended handling
Your app should therefore provide:

* a clear way back to the authorization page
* an understandable reauthorization flow
* clear error messages for invalid tokens and missing scopes

#### Common errors and troubleshooting
| Error / scenario | Meaning | Suggested action |
| --- | --- | --- |
| 105005 | Missing required scope at app level or token level | Check app scopes, then check the token's granted_scopes, then ask the creator to reauthorize if needed |
| 105002 | Access token expired | Refresh the token |
| 105001 / token invalid | Token invalid, revoked, or user removed all access | Reauthorize if needed |
| 101000 | Wrong token identity or wrong API-token pairing | Make sure you are not using a seller token against a creator API |
| A practical rule of thumb:If a newly enabled scope still does not work, the first thing to inspect is usually the token's granted_scopes from the creator's latest authorization, not the app version number. |  |  |
#### Best practices

1. generate and validate `state` on the server side
2. persist `granted_scopes`
3. store creator tokens separately from seller tokens
4. exchange the auth code as soon as possible after callback
5. request only the minimum necessary scopes
6. provide a clear reauthorization entry in the product
7. check scope capability before calling an API

#### FAQ
##### Can a creator token and a seller token be reused interchangeably?
No. They represent different user identities and should not be mixed.
##### Why did authorization succeed but the API still returns `105005`?
Usually because either:

* the app does not have the required scope enabled, or
* the token's `granted_scopes` does not contain the required scope

##### After refreshing a token, is it recommended to keep checking `granted_scopes`?
For safety, yes. A safer engineering practice is to revalidate key capability fields whenever a new token is issued.
##### What should I do if the creator granted only part of the requested scopes?
Use `granted_scopes` to control feature availability, and reauthorize if a missing scope blocks critical business flows.
##### Missing parameter: The URL must include the "state" parameter for creators to authorize this app. Please contact the developer for assistance.
For creator authorization links, you are **required to manually** add a `state` parameter for extra security. The `state` is an unguessable random string that can help protect cross-site request forgery attacks, and is **not automatically included** in the basic authorization link.
##### No data retrieved: The requested API list is empty. Please contact the app developer for more information.
APP must open creator api scopes.
APP & Service -> Manage API, look for scope keys that begin with **creator**.


---

## Get started > Authorization > Partner authorization guide

Doc: https://partner.tiktokshop.com/docv2/page/partner-authorization-guide · cập nhật 2026-07-01

### What does partner authorization do?
After partner authorization, the app can call **Affiliate Partner** APIs with the permissions granted by the partner.
Partner authorization is used for partner-owned business category data. Currently, TikTok Shop Partner Center supports this flow only for the **Seller and Scalable Creator Match-Up (TAP)** partner category. For more information about supported endpoints, refer to the **Affiliate Partner** API reference.
### Authorization domains overview
TikTok Shop uses different authorization entry domains for seller, creator, and partner authorization. Use the authorization guide that matches the data owner you are asking to authorize.
| Authorization type | Data owner | US authorization entry | ROW authorization entry | Notes |
| --- | --- | --- | --- | --- |
| Seller authorization | Seller / shop | `https://services.us.tiktokshop.com/open/authorize` | `https://services.tiktokshop.com/open/authorize` | Used for seller-owned shop data and seller API scopes. |
| Creator authorization | Creator | `https://shop.tiktok.com/alliance` | `https://shop.tiktok.com/alliance` | Used for creator authorization flows. Follow the creator authorization guide for the full path and parameters. |
| Partner authorization | Partner | `https://partner.us.tiktokshop.com/open/authorize` | `https://partner.tiktokshop.com/open/authorize` | Used for Affiliate Partner APIs and partner API scopes. |
### Requirements

1. If the app is still in development, the app can only accept authorization from the owner of the app. After launch, the app can accept authorization from other partners.
2. The app must enable partner API scopes, which are the ones starting with `partner` in scope keys:

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/dec0b1025fc14dec8878e93266569436~tplv-k9wyc2ijk0-image.image)
### Authorization link
The basic authorization link can be obtained from the **Copy authorization link** button.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/1700c2b084de4d4fac238f4a74de20b9~tplv-k9wyc2ijk0-image.image)
If the app is in development, the developer needs to generate the authorization link manually using the app's `service_id`. You can find `service_id` in **Partner Center > App & Service > select the app/service > Basic Information > Service ID**:
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/b919a650b24046c481b58fedf505d340~tplv-k9wyc2ijk0-image.image)
Use the authorization domain that matches the partner's region:
| Partner region | Authorization link |
| --- | --- |
| United States | `https://partner.us.tiktokshop.com/open/authorize?service_id={service_id}` |
| Rest of World (ROW) | `https://partner.tiktokshop.com/open/authorize?service_id={service_id}` |
Adding a `state` parameter is encouraged, but not required for partner authorization. Please see the [OpenID Connect](https://developers.google.com/identity/protocols/oauth2/openid-connect#createxsrftoken) documentation for an example of how to create and confirm a `state`.
### Get and refresh tokens
After the partner approves authorization, TikTok Shop redirects the partner back to the app's configured redirect URL with an authorization code. Exchange this code for an access token before calling Affiliate Partner APIs.

1. Receive the authorization code from the redirect URL.
2. Call the token API from your backend service:

```HTTP
GET https://auth.tiktok-shops.com/api/v2/token/get?app_key={app_key}&app_secret={app_secret}&auth_code={auth_code}&grant_type=authorized_code
```

The successful response includes `access_token`, `access_token_expire_in`, `refresh_token`, `refresh_token_expire_in`, and `granted_scopes`. Store tokens securely on the server side. Do not expose `app_secret`, `access_token`, or `refresh_token` in frontend code.
Use the `access_token` in the `x-tts-access-token` request header when calling Affiliate Partner APIs. Before calling partner-category APIs, call **Get Authorized Category Assets** to confirm the authorized business category and obtain the category asset cipher:
```HTTP
GET /authorization/202405/category_assets
Header: x-tts-access-token: {access_token}
```

The returned `category_assets[].cipher` identifies the authorized partner category asset and is used as an input parameter in Affiliate Partner APIs.
When the access token expires, refresh it with the refresh token:
```HTTP
GET https://auth.tiktok-shops.com/api/v2/token/refresh?app_key={app_key}&app_secret={app_secret}&refresh_token={refresh_token}&grant_type=refresh_token
```

If the refresh token expires or the partner cancels authorization, ask the partner to authorize the app again.
### Partner requirements
Partner authorization grants access only to the business category data that the partner authorizes and the app is approved to access. Currently, Partner Center exposes partner authorization only for the **Seller and Scalable Creator Match-Up (TAP)** category; it does not grant access to unrelated partner business data.
The partner must have successfully enrolled in **Seller and Scalable Creator Match-Up (TAP)**:
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/445e0f8141aa4417b224109f48263772~tplv-k9wyc2ijk0-image.image)
Make sure the user chooses **Seller and Scalable Creator Match-Up (TAP)** on the authorization page.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/ffeba3cb3bd74f029a7e4f9d537441e6~tplv-k9wyc2ijk0-image.image)
### Cancel authorization
The partner can cancel authorization from **My account > My authorizations**.
After cancellation, the app should stop calling partner APIs for that partner, treat existing tokens as invalid, and ask the partner to authorize again if access is still required.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/46cf0e4a4a7647e0a811101fec97367b~tplv-k9wyc2ijk0-image.image)


---

## Get started > Authorization > Authorization via App Store

Doc: https://partner.tiktokshop.com/docv2/page/authorization-via-app-store · cập nhật 2026-06-29

❗ **Important**: Authorizing via the Seller Center App Store only applies to **public** apps. Public apps must meet specific criteria and pass TikTok Shop's app review process. For more information on developing a public app, please visit our [app development overview](https://partner.tiktokshop.com/docv2/page/app-development-overview).
### App installation authorization
**Step 1 — Open the App Store.** Before the seller begins, your app must already be a reviewed **public** app with a valid **Redirect URL** and the required scopes enabled in Partner Center. In Seller Center, the seller opens the left-hand menu and goes to **Growth > App store**, where they see the full list of apps available to install and authorize:
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/7bfbd4d5039549239f134556e3148e45~tplv-k9wyc2ijk0-image.image)
**Step 2 — Start installation.** The seller locates your app and clicks to install it, then is prompted to review the app and the permissions (scopes) it requests:
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/770e3f19def04d2c80a6f533d1c8da14~tplv-k9wyc2ijk0-image.image)
**Step 3 — Confirm and authorize.** After the seller fills in the required information and confirms the requested permissions, they reach the authorization step and click **Authorize** to grant your app access to their shop:
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/dac2bba539f94e09b7851a7b33090698~tplv-k9wyc2ijk0-image.image)
**Step 4 — Land on your Redirect URL and sign in to your app.** Once the seller authorizes, TikTok Shop redirects them to your configured **Redirect URL** with a short-lived authorization code appended as a query parameter (for example `{your_redirect_url}?code={auth_code}`). Here "log in to your app" means the seller signs in to **your** application (the developer-built product), not to TikTok — this lets your app bind the authorization to the seller account in your own system and finish onboarding:
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/8d4ab9ddace34b7e90d0951b1f21ad8d~tplv-k9wyc2ijk0-image.image)
#### After the redirect: exchange the code for tokens
The authorization code in the Redirect URL is short-lived and single-use. On your server, read the `code` query parameter and exchange it for an `access_token` and a `refresh_token` by calling the Get Access Token API (`GET https://auth.tiktok-shops.com/api/v2/token/get`) with `grant_type=authorized_code`, following the standard OAuth authorization-code flow. Store the tokens against the seller account in your app, and use the `access_token` to call the authorized Shop APIs. Refresh the token with the `refresh_token` (via `GET https://auth.tiktok-shops.com/api/v2/token/refresh` with `grant_type=refresh_token`) before it expires.
**Related:** This Seller Center App Store path is the same authorization described in the [seller authorization guide](https://partner.tiktokshop.com/docv2/page/seller-authorization-guide) under "Authorization from seller app store". That guide covers the seller-facing walkthrough; this page focuses on the developer side of installing and authorizing a public app.


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit Developer Tools

Doc: https://partner.tiktokshop.com/docv2/page/6kiauzd6 · cập nhật 2026-07-27

> 💡
> **TTS Open Toolkit brings TikTok Shop developer context and supported Partner Center operations into your AI coding workflow.**
> Use it with Codex, Claude Code, Trae, or Trae CN to install TikTok Shop skills, find API and webhook guidance, sign in to Partner Center, connect authorized App/Shop context, work with supported sandbox data, and run allowlisted developer operations.

### Choose a path
##### Use with an AI coding agent
[TTS Open Toolkit for AI agents](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-ai-agents)
Install TikTok Shop skills for Codex, Claude Code, Trae, or Trae CN and start from a real developer task.
##### Use the CLI
[TTS Open Toolkit CLI](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-cli)
Install and upgrade the CLI, connect an App/Shop, inspect Apps and sandboxes, or run a supported developer workflow.
##### Look up a command
[TTS Open Toolkit CLI reference](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-cli-reference)
Browse built-in skills, CLI command groups, configuration, and machine-readable output.
##### Fix a problem
[Help and feedback](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-help-feedback)
Diagnose installation, authentication, skill state, API, and security issues.
### What the current release can do
| Developer goal | Toolkit capability |
| --- | --- |
| **Use TTS context in an AI agent** | Install and update TikTok Shop OpenAPI, onboarding, FAQ, glossary, and Seller University skills for Codex, Claude Code, Trae, or Trae CN. |
| **Find the right API or webhook** | Use bundled OpenAPI schema references and official Partner Center documentation fallback instead of relying on model memory. |
| **Sign in and connect an App/Shop** | Use Partner Center OAuth to sign in, maintain named profiles, select authorized App/Shop context, and switch the active account without pasting tokens into prompts. |
| **Inspect App and sandbox context** | List supported developer Apps and sandbox accounts, then use the selected identifiers in an explicit workflow. |
| **Call supported developer operations** | Use fixed, allowlisted DevAPI methods and supported sandbox operations with sanitized JSON output. |
| **Maintain the tool** | Check versions, diagnose configuration, inspect skill state, and update managed installations. |
### Before you begin

* Node.js 18 or later.
* A supported AI coding agent: Codex, Claude Code, Trae, or Trae CN.
* A Partner Center developer account for OAuth-backed App, sandbox, or DevAPI operations.

> 💡
> **Keep credentials out of prompts and source code.** The CLI stores OAuth tokens in macOS Keychain or Windows CurrentUser DPAPI. Review generated code and validate behavior before using it in production.

[TikTok Shop Partner Center developer documentation](https://partner.tiktokshop.com/docv2)
### Where to get help
Report an installation, authentication, App/Shop, sandbox, DevAPI, answer-quality, or documentation issue through the Toolkit feedback form.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)
Join **TTS Open Toolkit | Developer Community** to discuss integration questions, exchange implementation practices, and share product feedback with other developers.
[Join TTS Open Toolkit | Developer Community](https://applink.larkoffice.com/client/chat/chatter/add_by_link?link_token=758l2012-4347-4bfb-a0b5-65f4f3mjqair)
For release checks and platform updates, open [Releases and feedback](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-releases-feedback).

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI > Overview

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-cli · cập nhật 2026-07-27

Use this section for installation, App/Shop authorization, API and webhook discovery, sandbox context, integration planning, Changelog review, and supported developer operations.
### Guides
| Goal | Guide |
| --- | --- |
| Understand the CLI | [About TTS Open Toolkit CLI](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-about-cli) |
| Install or upgrade the CLI | [Install and set up](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-install-setup) and [Upgrade and verify](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-upgrade-verify) |
| Sign in and manage App/Shop authorization | [Sign in and manage profiles](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-auth-profiles) |
| Choose an API or webhook | [Find the right API and webhook](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-find-api-webhook) |
| Inspect Apps or sandbox accounts | [Work with apps and sandbox accounts](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-apps-sandbox) |
| Create an integration plan or demo | [Plan an integration and generate a runnable demo](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-integration-plan-demo) |
| Assess a platform change | [Review API and Changelog impact](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-api-changelog-impact) |
| Run an allowlisted developer operation | [Call supported developer APIs](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-developer-api-operations) |

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI > Find the right API and webhook

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-find-api-webhook · cập nhật 2026-07-27

Use this workflow when you know the business outcome but do not yet know the correct endpoint, webhook, version, scope, or field.
### Ask from the business outcome
> 📝
> **Prompt to copy**
> For [BUSINESS OUTCOME] in [MARKET], identify the current TikTok Shop OpenAPI endpoints and webhooks I should use. For each item, provide the method and path, version, required scopes, prerequisites, required request fields, relevant response fields, pagination or webhook behavior, and the official source. Separate confirmed facts from assumptions.

### How the Toolkit checks the answer

1. The `tts-openapi-guide` skill locates the relevant first-level domain in the bundled OAS reference.
2. It checks the exact path, method, parameters, body, response, required flags, and enum values.
3. When the bundled reference does not resolve the question, it falls back to official Partner Center documentation.
4. If the two sources differ, the answer should state the difference and identify the source used.

### Expected output
| Section | What to verify |
| --- | --- |
| API or webhook | Exact name, method/path or event, and version. |
| Access | Required scope, App/Shop prerequisite, and market boundary. |
| Contract | Required request fields, response fields, enums, and pagination. |
| Evidence | Bundled OAS location or official Partner Center URL. |
| Gaps | Unknown or conflicting information that still needs confirmation. |
### Example
“Which APIs are required to publish a product in the US market? Build the dependency order and identify category, attributes, images, listing checks, creation, and status verification.”
[Browse TikTok Shop API documentation](https://partner.tiktokshop.com/docv2)

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI > Work with apps and sandbox accounts

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-apps-sandbox · cập nhật 2026-07-27

Use authenticated App and sandbox context when a workflow depends on the developer account rather than documentation alone.
### Sign in and confirm context
```bash
tts_open_toolkit auth login
tts_open_toolkit auth status --json
```

### List developer Apps
```bash
tts_open_toolkit app list --json
tts_open_toolkit app list --page-no 1 --page-size 20 --json
tts_open_toolkit app list --app-key <app_key> --json
```

Use `app_key` as an identifier in the workflow. Never request or print an App Secret.
### List sandbox accounts
```bash
tts_open_toolkit sandbox list --json
tts_open_toolkit sandbox list --region-code 840 --json
tts_open_toolkit sandbox endpoints --json
```

Inspect the endpoint catalog before running a sandbox operation:
```bash
tts_open_toolkit sandbox call account-basic-list --query region_code=840 --json
```

### Use the context in an agent task
> 📝
> **Prompt to copy**
> Using the active Partner Center profile, list the developer Apps and sandbox accounts available to me. Use JSON output, keep App Secrets and OAuth credentials hidden, and ask me to select the App and sandbox account before continuing. Then produce a readiness checklist for [BUSINESS SCENARIO] without making a write change.
> 💡
> Sandbox account deletion is intentionally excluded from the CLI catalog. Do not construct a raw request to recreate it. Other sandbox operations can still be restricted by the OAuth allowlist or session type; report the returned authorization error instead of bypassing it.

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI > Plan an integration and generate a runnable demo

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-integration-plan-demo · cập nhật 2026-07-27

Turn a business requirement into an implementation plan first, then ask the agent to generate code only after the API contract and prerequisites are confirmed.
### Step 1: create the integration plan
> 📝
> **Prompt to copy**
> Design an implementation-ready TikTok Shop integration for [BUSINESS SCENARIO] in [MARKET]. Use the current official API and webhook definitions. Specify the sequence, endpoint versions, scopes, App and Shop prerequisites, data mapping, pagination, webhook handling, retries, idempotency, test plan, success criteria, rollout steps, and known constraints. Separate mandatory steps from optional recommendations and cite the sources used.

### Step 2: generate a runnable demo
> 📝
> **Prompt to copy**
> Create a runnable [LANGUAGE / FRAMEWORK] demo for the approved integration plan. Confirm the endpoint version, required scopes, prerequisites, and request fields before writing code. Include environment-variable based credentials, request construction, pagination or webhook handling when relevant, error handling, test data, run commands, and objective success checks. List any unsupported or unverified step instead of fabricating it.

### Definition of runnable

* The project installs and starts with documented commands.
* Credentials are read from environment variables and are never committed.
* The endpoint, version, scope, and required fields match the checked source.
* The happy path and at least one failure path have observable success criteria.
* Generated code is reviewed and tested by the developer before production use.

### Recommended review
| Review | Question |
| --- | --- |
| Contract | Does the code match the current request and response schema? |
| Business flow | Are prerequisites, ordering, retries, and status transitions complete? |
| Security | Are secrets excluded from code, logs, prompts, and screenshots? |
| Evidence | Can each important implementation choice be traced to an official source? |

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI > Review API and Changelog impact

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-api-changelog-impact · cập nhật 2026-07-27

Use this workflow to decide whether a TikTok Shop API or webhook update requires code, configuration, testing, or no action.
### Review one change
> 📝
> **Prompt to copy**
> Compare [API OR WEBHOOK CHANGE] with this repository. Identify affected endpoints, events, versions, fields, scopes, data mappings, retries, idempotency, and downstream business flows. Classify each finding as contract-breaking, behavior-changing, or no action. Cite official evidence and produce a prioritized migration plan with code locations, tests, rollout order, rollback checks, and explicit unknowns.

### Review changes since a date
> 📝
> **Prompt to copy**
> Review the TikTok Shop Partner Platform Changelog since [DATE] and compare relevant changes with this repository. For each change, provide the effective date, endpoint or event, change type, affected code and business flow, severity, required action, owner, and verification evidence. Notify me only when action is required.

### Use three impact layers
| Layer | Examples |
| --- | --- |
| Contract | Endpoint, version, required field, response shape, enum, or scope changed. |
| Behavior | The contract is compatible, but business meaning, timing, validation, or status handling changed. |
| Consumption | The change exists, but the repository does not read, map, persist, or branch on it. |
A new optional field is not automatically breaking. The final decision depends on whether the integration consumes it and whether business behavior changed.
[TikTok Shop developer Changelog](https://partner.tiktokshop.com/docv2/changelog)

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI > Call supported developer APIs

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-developer-api-operations · cập nhật 2026-07-27

The `devapi` command group exposes fixed OAuth-backed methods for supported Partner Center and Developer Center operations. It does not accept an arbitrary caller-provided path.
### Discover the installed method catalog
```bash
tts_open_toolkit auth login
tts_open_toolkit devapi list --json
```

Always use the installed CLI as the source of truth for method names and accepted inputs.
### Call a method
```bash
tts_open_toolkit devapi call partner-profile --json
tts_open_toolkit devapi call developer-app-detail --query app_key=<app_key> --json
tts_open_toolkit devapi call partner-service-detail --query service_id=<service_id> --query locale=en-US --json
```

### Published fixed methods
| Method | Purpose |
| --- | --- |
| `account-basic-info` | Read basic developer-account information. |
| `account-certification-info` | Read account certification information. |
| `developer-app-list` | List developer Apps, optionally filtered by keyword. |
| `developer-app-detail` | Read one App by required `app_key`. |
| `developer-app-exists` | Check whether a developer App exists. |
| `document-api-meta` | Read API-document metadata by source document ID. |
| `authorization-open-api-list` | Read authorized OpenAPI items for a package and optional App. |
| `sandbox-shop-list` | List sandbox shops. |
| `sandbox-account-list` | List sandbox accounts with supported filters. |
| `partner-service-list` | List partner services. |
| `partner-profile` | Read the active partner profile. |
| `partner-service-detail` | Read one partner service by service ID. |
| `open-app-list` | List open Apps with pagination and filters. |
### Use JSON for automation

* Use `--json` when an agent or script consumes the response.
* Preserve safe error text, HTTP status, and request or log IDs for diagnosis.
* Do not parse human-readable output when JSON is available.
* Secret-bearing response fields are recursively removed. Public identifiers such as `app_key` remain available.

> 💡
> Prefer fixed `devapi call` methods. Use `auth request` only for an explicit diagnostic against a known existing route, never to bypass an allowlist.

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI > Install and set up

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-install-setup · cập nhật 2026-07-27

### Requirements

* Node.js 18 or later.
* npm available on your machine.
* Codex, Claude Code, Trae, or Trae CN.

### Install the CLI
```bash
npm install -g @tts-open-toolkit/cli
```

Confirm that the command is available:
```bash
tts_open_toolkit version
tts_open_toolkit doctor
```

### Add skills to your AI agent
| Agent | Command |
| --- | --- |
| Codex | `tts_open_toolkit skill add --agent codex` |
| Claude Code | `tts_open_toolkit skill add --agent cc` |
| Trae | `tts_open_toolkit skill add --agent trae` |
| Trae CN | `tts_open_toolkit skill add --agent trae-cn` |
#### Project-scoped installation
Use a project target when the skills should travel with one repository:
```bash
tts_open_toolkit skill add --scope project
```

This installs managed skills under `.codex/skills` in the current project.
### Verify the skills
```bash
tts_open_toolkit skill list --agent codex --json
tts_open_toolkit skill state --agent codex --json
```

> 💡
> **Ask your agent to do the setup.** You can paste: “Install TTS Open Toolkit CLI, add all bundled TTS skills for this agent, run doctor, and show me the verification result.”

### Next
[Sign in and manage profiles](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-auth-profiles) when your workflow needs Partner Center account, App, sandbox, or DevAPI data.

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI > Sign in and manage profiles

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-auth-profiles · cập nhật 2026-07-27

> 🔐
> App/Shop sign-in and authorization are available in the current release. Partner Center sign-in uses OAuth; the active profile provides protected authorization for supported App, Shop, sandbox, and DevAPI workflows. Profile metadata is stored locally, while access and refresh tokens are kept in macOS Keychain or Windows CurrentUser DPAPI and are not printed by status commands.

### Sign in
```bash
tts_open_toolkit auth login
```

The CLI opens Partner Center authorization in your browser and returns to a localhost callback after approval.
### Check the active profile
```bash
tts_open_toolkit auth status --json
tts_open_toolkit auth list --json
```

### Use more than one account
```bash
tts_open_toolkit auth login --add --profile work
tts_open_toolkit auth list --json
tts_open_toolkit auth switch work --json
```

The active profile determines which protected OAuth session is used. Select the intended App/Shop context before running a supported API, sandbox, or DevAPI workflow.
### Verify account context
```bash
tts_open_toolkit auth basic-info --json
tts_open_toolkit app list --json
tts_open_toolkit sandbox list --json
```

### Sign out
```bash
tts_open_toolkit auth logout --profile work --json
tts_open_toolkit auth logout --all --json
```

> 💡
> Never paste OAuth tokens, authorization codes, App Secrets, PKCE verifiers, or Partner Center cookies into an AI prompt. If authentication state is unclear, run `tts_open_toolkit auth doctor --json`.

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI > Upgrade and verify

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-upgrade-verify · cập nhật 2026-07-27

### Check before updating
```bash
tts_open_toolkit update --check
```

This command checks for a newer package without installing it.
### Update the CLI
```bash
tts_open_toolkit update --yes
```

If a registry mirror is stale, explicitly use npmjs:
```bash
tts_open_toolkit update --yes --registry https://registry.npmjs.org
```

### Refresh managed skills
```bash
tts_open_toolkit skill add --agent codex --update
tts_open_toolkit skill state --agent codex --json
```

Use the same target that you used during installation. Do not combine `--scope`, `--agent`, and `--target`.
### Run a health check
```bash
tts_open_toolkit version
tts_open_toolkit doctor
tts_open_toolkit auth doctor --json
```

| Check | Expected result |
| --- | --- |
| CLI | The expected version and executable path are shown. |
| Skills | Managed skills report `current`; modified or unmanaged copies are identified. |
| OAuth | Profile metadata and protected credential-store status are available without exposing secrets. |
For failures, continue to [Troubleshooting](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-troubleshooting).

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI > About TTS Open Toolkit CLI

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-about-cli · cập nhật 2026-07-27

TTS Open Toolkit CLI helps developers use TikTok Shop context and supported Partner Center operations from a terminal or AI coding agent. It can install skills, find current API guidance, connect authorized App/Shop context, and automate supported developer tasks.
### Features

* Installs TikTok Shop skills for Codex, Claude Code, Trae, and Trae CN.
* Uses bundled OpenAPI and developer knowledge instead of model memory alone.
* Signs in through Partner Center OAuth and manages protected profiles.
* Lists supported Apps and sandbox accounts and runs fixed DevAPI operations.
* Returns machine-readable JSON for supported agent and automation workflows.

### Requirements

* Node.js 18 or later.
* A supported AI coding agent when you want agent-guided workflows.
* A Partner Center developer account for OAuth-backed operations.

### Getting started
```bash
npm install -g @tts-open-toolkit/cli
tts_open_toolkit skill add --agent codex --update
tts_open_toolkit doctor
```

If you previously installed the beta version, use `tts_open_toolkit update` and run `doctor` again.
### Where to get help
Run `tts_open_toolkit doctor` first, then open [Help and feedback](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-help-feedback).
### Command reference
[CLI command reference](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-command-reference)

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI reference > Overview

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-cli-reference · cập nhật 2026-07-27

Use this section when you need to understand what the Toolkit installs, select an installation target, look up exact command groups, or integrate CLI output into an agent or script.
### Browse the reference
| Topic | Page |
| --- | --- |
| What each bundled skill knows | [Built-in skills](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-built-in-skills) |
| Install targets, state, and updates | [Choose and manage skills](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-manage-skills) |
| All CLI command groups | [CLI command reference](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-command-reference) |
| Config precedence, local files, and output | [Configuration, output, and local files](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-configuration-output-files) |
> 💡
> Run `tts_open_toolkit --help` on the installed version when this documentation and a local installation differ. Installed-version help is the final source of truth for accepted commands and flags.

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI reference > Built-in skills

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-built-in-skills · cập nhật 2026-07-27

The CLI bundles focused skills instead of one oversized prompt. Your AI agent selects the relevant skill for the task and can combine skills when a question spans platform knowledge, onboarding, and an exact API contract.
### Skill catalog
| Skill | Use it for |
| --- | --- |
| `tts-open-toolkit` | CLI installation, upgrades, health checks, OAuth profiles, Apps, sandbox operations, DevAPI calls, configuration, and safety guidance. |
| `tts-openapi-guide` | Exact endpoint, method, path, headers, request, response, field, version, and scope questions using the bundled OAS first. |
| `tts-developer-onboarding-guide` | Developer registration, App creation, development shops, authorization, and integration prerequisites. |
| `tts-openapi-faq-index` | Common TikTok Shop OpenAPI questions and the correct source or next check. |
| `tts-seller-university-basic-knowledge-index` | Seller-facing business concepts and Seller University source discovery. |
| `tts-open-platform-glossary` | Consistent definitions for Open Platform terminology. |
### How skills work together
##### Example: product publishing
Onboarding confirms App and shop prerequisites. OpenAPI Guide checks the product endpoints and schema. Toolkit handles account context and supported CLI operations.
##### Example: API update
OpenAPI Guide checks the contract. FAQ and business indexes provide surrounding context. The agent compares the evidence with the repository.
### Important boundary
A skill can guide, inspect a local repository, and invoke tools exposed by the agent. It does not make generated code correct by default. Review source evidence, diffs, tests, and live responses before production use.

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI reference > Choose and manage skills

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-manage-skills · cập nhật 2026-07-27

### Choose one installation target
| Target | Use when | Command |
| --- | --- | --- |
| Agent user directory | You want skills available across projects in one agent. | `skill add --agent codex` |
| Current project | You want a repository-specific managed copy. | `skill add --scope project` |
| User scope | You want the default Codex user skill directory. | `skill add --scope user` |
| Explicit path | You manage a custom skill directory. | `skill add --target /path/to/skills` |
`--scope`, `--agent`, and `--target` are mutually exclusive.
### Install all or one skill
```bash
tts_open_toolkit skill add --agent codex
tts_open_toolkit skill add tts-openapi-guide --scope project
```

### Inspect managed state
```bash
tts_open_toolkit skill list --scope project --json
tts_open_toolkit skill state --scope project --json
```

| State | Meaning |
| --- | --- |
| `current` | The managed copy matches the bundled version. |
| `outdated` | A newer managed version is available. |
| `modified` | Local content differs from the managed copy; review before overwriting. |
| `unmanaged` | The directory exists but was not installed as a managed Toolkit skill. |
| `unknown` | The CLI cannot determine a reliable state. |
### Update managed skills
```bash
tts_open_toolkit skill add --scope project --update
```

> 💡
> Use `--force` only when you intentionally want to overwrite local changes. Check state first.

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI reference > CLI command reference

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-command-reference · cập nhật 2026-07-27

The executable is `tts_open_toolkit`. Use `--json` where supported when another program or AI agent consumes the result.
### Command groups
| Group | Purpose |
| --- | --- |
| `version`, `doctor` | Print version, executable, platform, Node version, config layers, cache, and default skill directory. |
| `skill` | Install, update, list, and inspect bundled or custom coding-agent skills. |
| `auth` | Sign in with Partner Center OAuth, manage profiles, inspect health, and run explicit diagnostics. |
| `devapi` | List and call the fixed OAuth Toolkit method catalog. |
| `app` | List developer Apps through the supported Developer Center route. |
| `sandbox` | List sandbox accounts, inspect the endpoint catalog, and call supported non-delete operations. |
| `openapi proxy` | Start a local, context-bound proxy for supported OpenAPI requests using the active OAuth profile. |
| `mcp` | Register and list MCP servers at user or project scope. |
| `setup` | Install managed Codex or Claude Code hooks, with dry-run and backup behavior. |
| `history` | Record and query local prompt and skill-usage history. |
| `update` | Check for or install a CLI package update. |
### Common commands
```bash
tts_open_toolkit --help
tts_open_toolkit version
tts_open_toolkit doctor

tts_open_toolkit skill add --agent codex
tts_open_toolkit skill list --agent codex --json
tts_open_toolkit skill state --agent codex --json

tts_open_toolkit auth login
tts_open_toolkit auth status --json
tts_open_toolkit auth list --json

tts_open_toolkit devapi list --json
tts_open_toolkit app list --json
tts_open_toolkit sandbox endpoints --json

tts_open_toolkit update --check
```

### Advanced OpenAPI proxy
```bash
tts_open_toolkit openapi proxy --app-key <app_key> --shop-cipher <shop_cipher> --json
```

The proxy binds to localhost, injects the selected App and Shop context, uses the active protected OAuth profile, and validates a short-lived local request signature. Use it only with an explicit App/Shop selection and a supported API workflow.
### Exit and output behavior

* A non-zero exit indicates validation, authentication, transport, or business failure.
* Preserve sanitized error text and request or log IDs for troubleshooting.
* Never log OAuth callbacks, authorization codes, access tokens, refresh tokens, App Secrets, or protected-store contents.

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI reference > Configuration, output, and local files

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-configuration-output-files · cập nhật 2026-07-27

### Configuration precedence
The CLI resolves configuration in this order:

1. Explicit `--config`.
2. `TTS_OPEN_TOOLKIT_CONFIG` environment override.
3. Project configuration.
4. User configuration.
5. Built-in defaults.

### Default paths
| Platform or scope | Path |
| --- | --- |
| macOS user config | `~/Library/Application Support/tts-open-toolkit/config.json` |
| Linux user config | `${XDG_CONFIG_HOME:-~/.config}/tts-open-toolkit/config.json` |
| Windows user config | `%APPDATA%\tts-open-toolkit\config.json` |
| Project override | `/.tts_open_toolkit/config.json` |
| Project history | `/.tts_open_toolkit/history/` |
| Project skills | `/.codex/skills/` |
Run `tts_open_toolkit doctor` to print the exact resolved paths on the current machine.
### OAuth storage

* Profile metadata is stored in `~/.tts_open_toolkit/config.json`.
* OAuth access and refresh tokens are not stored in that file.
* macOS uses Keychain; Windows uses CurrentUser DPAPI.
* Status, list, and doctor output expose only non-secret metadata.

### Machine-readable output
```bash
tts_open_toolkit auth status --json
tts_open_toolkit devapi list --json
tts_open_toolkit app list --json
tts_open_toolkit skill state --scope project --json
```

Use JSON for agent workflows and automation. Do not scrape the human-readable format when a JSON option exists.
### Deterministic environments
Set `OPEN_TOOLKIT_SKIP_UPDATE_CHECK=1` in offline or deterministic CI smoke tests. Keep package updates explicit.

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > Help and feedback > Overview

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-help-feedback · cập nhật 2026-07-27

Diagnose the current installation, understand security and capability boundaries, follow releases, or submit feedback.
### Get help
| Need | Page |
| --- | --- |
| Fix installation, skill, OAuth, or API failures | [Troubleshooting](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-troubleshooting) |
| Understand safe-use and current-release boundaries | [Security and capability boundaries](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-security-boundaries) |
| Check releases or report an issue | [Releases and feedback](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-releases-feedback) |
### Start with evidence
```bash
tts_open_toolkit version
tts_open_toolkit doctor
tts_open_toolkit auth doctor --json
tts_open_toolkit skill state --scope project --json
```

Include the safe command output, operating system, Node version, intended task, actual result, and reproduction steps when asking for help. Remove credentials before sharing.
### Send feedback
Use the English form to report a problem, request a capability, or tell us where the documentation was unclear.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)
### Join the developer community
Join **TTS Open Toolkit | Developer Community** to discuss integration questions, exchange implementation practices, and share product feedback with other developers.
[Join TTS Open Toolkit | Developer Community](https://applink.larkoffice.com/client/chat/chatter/add_by_link?link_token=758l2012-4347-4bfb-a0b5-65f4f3mjqair)

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > Help and feedback > Troubleshooting

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-troubleshooting · cập nhật 2026-07-27

> 💡
> **Run doctor first.** It distinguishes installation and configuration problems from OAuth, skill-state, transport, and business errors.

```bash
tts_open_toolkit version
tts_open_toolkit doctor
tts_open_toolkit auth doctor --json
```

### Common problems
| Symptom | Next check |
| --- | --- |
| `command not found` | Confirm global npm installation and that the npm global bin directory is on `PATH`. Reopen the terminal after installation. |
| Wrong or old skills | Run `skill state --json`. Update the same target used for installation. Review `modified` state before overwriting. |
| Login does not complete | Run `auth doctor --json`, confirm the browser callback can reach localhost, and retry `auth login`. |
| Missing auth record | Run `auth list --json` and `auth status --json`. Sign in again rather than copying tokens between profiles. |
| Protected credential store unavailable | OAuth token storage currently requires macOS Keychain or Windows CurrentUser DPAPI. Skill-only workflows can still run where Node is supported. |
| DevAPI method rejected | Run `devapi list --json` and use the exact installed method name, declared queries, and supported JSON body. |
| Sandbox operation rejected | Run `sandbox endpoints --json`. Confirm the operation is published, non-delete, and allowed for the active profile. |
| Business error | Preserve the sanitized message, HTTP status, and request or log ID. Check App, market, scope, and prerequisite context. |
### Update recovery
```bash
tts_open_toolkit update --check
tts_open_toolkit update --yes --registry https://registry.npmjs.org
tts_open_toolkit doctor
```

### What to include in a report

* Operating system, Node version, CLI version, and AI agent.
* The exact safe command, intended outcome, and actual result.
* Sanitized JSON error, request ID, log ID, or screenshot.
* Whether the problem occurs before login, after login, or during one fixed method.

Do not attach secrets, OAuth callbacks, authorization codes, cookies, or protected-store contents.

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > Help and feedback > Security and capability boundaries

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-security-boundaries · cập nhật 2026-07-27

### Credential handling
| Data | Handling |
| --- | --- |
| OAuth access and refresh tokens | Stored only in macOS Keychain or Windows CurrentUser DPAPI; not written to profile metadata. |
| Profile metadata | Stored locally and may include non-secret account, site, scope, and expiry metadata. |
| App key | A public identifier that may be used as explicit context. It is not an App Secret. |
| App Secret, cookies, auth codes, PKCE verifiers | Must never be pasted into prompts, committed, logged, or included in feedback. |
### Execution boundaries

* `devapi call` uses fixed method, path, and input declarations. Secret-bearing response fields are removed recursively.
* `auth request` is a diagnostic escape hatch for a known existing route. It must not be used to bypass an allowlist.
* Sandbox account deletion is excluded and must not be recreated with a raw request.
* Use read-only checks by default. Ask for explicit approval before a write action.
* Generated code and explanations still require developer review, tests, and production validation.

### Capability boundary
> 📌
> This documentation covers capabilities available in the current published CLI and bundled skills: skill distribution, developer-source guidance, Partner Center OAuth profiles, App and sandbox context, fixed DevAPIs, supported OpenAPI proxy workflows, local hooks/history, diagnostics, and updates.
> Do not treat roadmap items as available. If a command is not shown by the installed `tts_open_toolkit --help` or current release notes, describe it as unavailable or planned.

### AI output boundary
The Toolkit reduces unsupported guesses by giving the agent structured TikTok Shop context and fixed operations. It does not replace code review, API response evidence, security review, or business acceptance testing.

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > Help and feedback > Releases and feedback

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-releases-feedback · cập nhật 2026-07-27

### Check the installed and latest versions
```bash
tts_open_toolkit version
tts_open_toolkit update --check
```

[TTS Open Toolkit CLI on npm](https://www.npmjs.com/package/@tts-open-toolkit/cli)
### Keep skills current
```bash
tts_open_toolkit skill state --agent codex --json
tts_open_toolkit skill add --agent codex --update
```

Repeat with the target used by your AI agent or project.
### Follow platform changes
[TikTok Shop developer Changelog](https://partner.tiktokshop.com/docv2/changelog)
The platform Changelog covers API and developer-product changes. Review it together with the API reference and your repository before deciding impact.
### Submit feedback
Use the English feedback form for installation, upgrade, authentication, App/sandbox access, DevAPI, answer quality, or feature requests.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)
#### Include

* Operating system, Node version, CLI version, and AI agent.
* Your goal, reproduction steps, expected result, and actual result.
* Sanitized request ID, error code, log ID, or screenshot when available.

> 💡
> Never submit OAuth tokens, authorization codes, App Secrets, cookies, private keys, passwords, or protected credential-store contents.

### Join the developer community
Join **TTS Open Toolkit | Developer Community** to discuss integration questions, exchange implementation practices, and share product feedback with other developers.
[Join TTS Open Toolkit | Developer Community](https://applink.larkoffice.com/client/chat/chatter/add_by_link?link_token=758l2012-4347-4bfb-a0b5-65f4f3mjqair)

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > TTS Open Toolkit CLI > TTS Open Toolkit for AI agents

Doc: https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-ai-agents · cập nhật 2026-07-27

TTS Open Toolkit gives supported AI coding agents current TikTok Shop developer guidance, OpenAPI schemas, onboarding knowledge, and safe access to supported CLI workflows.
### Requirements

* Node.js 18 or later.
* Codex, Claude Code, Trae, or Trae CN.
* A Partner Center developer account when the task needs App, Shop, sandbox, or DevAPI context.

### Install the Toolkit
```bash
npm install -g @tts-open-toolkit/cli
tts_open_toolkit skill add --agent codex --update
tts_open_toolkit doctor
```

Replace `codex` with `cc`, `trae`, or `trae-cn` for your AI coding agent.
> 💡
> **You can ask the agent to install it.** Paste: “Install TTS Open Toolkit CLI, add all bundled TTS skills for this agent, run doctor, and show me the verification result.”

### Try it on a real task

* Find the APIs, webhooks, scopes, and prerequisites for a business scenario.
* Generate a runnable integration demo from the current TikTok Shop schema.
* Check whether a Changelog update affects the repository.
* Sign in and select an authorized App/Shop before a supported API workflow.

### Related resources
[TTS Open Toolkit CLI](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-cli) for installation, authentication, task guides, and CLI behavior.

---

#### Was this page helpful?
Tell us what worked, what was unclear, or what should be added.
[TTS Open Toolkit Feedback Form](https://bytedance.my.larkoffice.com/share/base/form/shrmygRoEmJHrxjcSX1v81MHVnh)


---

## Get started > Make your first API call > Make your first API call overview

Doc: https://partner.tiktokshop.com/docv2/page/make-your-first-api-call-overview · cập nhật 2026-06-16

Before you begin this tutorial to make your first TikTok Shop API call, you need to have a [TikTok Shop Partner Center](https://partner.tiktokshop.com) account, and that account must be [registered as a developer](developer-onboarding).
If you've completed those steps, the tutorial to make your first TikTok Shop API call has the following steps:

1. [Create a TikTok Shop App (OAuth client)](create-tts-app-oauth-client): Create your app in Partner Center and obtain the App Key and App Secret required for API authentication.
2. [Create a test seller account](create-test-seller-account): Set up a test seller account in the development shop environment for API integration and testing.
3. [Generate a test access token](generate-test-access-token): Authorize the test seller account and generate an access token to access TikTok Shop APIs.
4. [Create a hash to sign your test API call](create-hash-to-sign-your-test-api-call): Generate the request signature using your App Secret to ensure the API request is authenticated and secure.
5. [Call Get Authorized Shops](call-get-authorized-shops): Make your first API call to verify that the authentication flow and API integration are working correctly.

Alternatively, it can be completed directly in Postman with a single click. Please refer to the [Postman](https://partner.tiktokshop.com/docv2/page/call-your-first-api-using-postman) documentation for details.
#### Next steps
The first step in making your first TikTok Shop API call is to [Create a TikTok Shop App (OAuth client)](create-tts-app-oauth-client).


---

## Get started > Make your first API call > Create a TikTok Shop App (OAuth client)

Doc: https://partner.tiktokshop.com/docv2/page/create-tts-app-oauth-client · cập nhật 2026-06-29

To make your first API call, you'll need a TikTok Shop App in order to request consent from a TikTok Seller and generate an access token. This is because a TikTok Shop App is an OAuth 2.0 client, and it's the entity that makes requests consent from a Seller or Creator to access their data. Once the Seller or Creator consents, the owner of the TikTok Shop App receives a credential in the form of an authorization code that they can then use to generate an access token and refresh token.
At this point of your getting started journey, you may not know all of the details required to create your TikTok Shop App.
If this is the case, you can create multiple TikTok Shop App. You can create a test TikTok Shop App for now, and create your real TikTok Shop App later. However, if you choose to create a test TikTok Shop App, you'll still have to pass all the TikTok Shop requirements to enable it. If this aligns with your getting started goals, you can continue with the steps in this tutorial.
If you do know all the details and want to create your final, release TikTok Shop App as part of getting started, you can take a deeper dive into the details in [TikTok Shop platform concepts](https://partner.tiktokshop.com/docv2/page/tts-platform-concepts). If this aligns with your getting started goals, return here and move ahead to the **next steps** section to create a test Seller account.
### Step 1: Select App & Service from the navigation panel
Log in to the [TikTok Shop Partner Center console](https://partner.tiktokshop.com/).
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/595418b76524479b8ccf1ded64b9d0ca~tplv-k9wyc2ijk0-image.image)
Select **App & Service** in the navigation panel.
### Step 2: Create your TikTok Shop App
Click the **Create app & service** button in the top right corner of the page.
You now have a choice to make: a **public** or **custom** app. A public app will be available for download from the TikTok Shop App Store and can access the data of any TikTok Shop Seller or Creator that consents, but it must meet a set of requirements to be approved. A custom app is not available for download from the TikTok Shop App Store and can only access the data of the linked TikTok Shop Seller or Creator account.
For getting started and testing, choose **custom**: it does not require app review and can immediately access the data of your linked test Seller or Creator account. You can create a **public** app later, when you are ready to distribute it on the App Store.
### Step 3: Choose your service category
Select a **Service category** from the drop-down menu. Since you're creating a test TikTok Shop App, select the service category that most closely aligns with your business. If you're unsure which service category to choose, select **Catalog**->**Product Listing** as you'll soon be creating a test Seller account and this will allow you to view your test products.
Next, enter a **default name** for your TikTok Shop App.
Finally, click the **Create** button.
### Step 4: Select target market
Select the **market** and the TikTok Shop **seller type**. At this point, you can simply select your local region for **market** and select **local sellers** for **seller type**.
### Step 5: Enable API and redirect URL
Click on the control to **enable API**.
Next, enter your **redirect URL**. The redirect URL is the URL that the TikTok Shop authorization server calls back when a TikTok Seller or Creator consents to share their data with your TikTok Shop App. This callback includes the **authorization code** as a query parameter, and you'll use it to generate an **access token** in the next section.
Since you're just getting started and you'll be using your test Seller account to generate access tokens, you can simply use your browser to retrieve the authorization code. If you're further along in your getting started journey and you have an HTTP service running on **localhost** on your local machine, you can use that instead.
If you don't have an HTTP service for your redirect URL at this point, it's recommended that you simply use the browser. In this case, it's best to enter `http://localhost` since it's not a real website and your browser won't be redirected to a real website.
After the Seller consents, the browser is redirected to your redirect URL with the code appended to the address bar, for example `http://localhost/?code={authorization_code}`. Copy the value of the `code` query parameter directly from the browser address bar — you'll use it to generate a test access token in the next tutorial.
### Step 6: Create your TikTok Shop App
Click **create** to create your TikTok Shop App. When you're redirected to the confirmation page, you'll see two critical pieces of information:

* **App Key**
   * Your app's public identifier. It is sent when calling APIs to identify your app, and is safe to expose.
* **App Secret**
   * A private key used to sign your API requests and to exchange the authorization code for an access token. Keep it confidential — never expose it in client-side code or commit it to a public repository.

You'll need both of these to generate an access token, but you don't need to write these down; you can look this information up in the TikTok Developer Center Console.
### Next Steps
Now that you've created a TikTok Shop App, you can [Create a test seller account](https://partner.tiktokshop.com/docv2/page/create-test-seller-account) and use the test Seller account to consent to sharing data with your newly created TikTok Shop App.


---

## Get started > Make your first API call > Create a test seller account

Doc: https://partner.tiktokshop.com/docv2/page/create-test-seller-account · cập nhật 2026-06-29

Now that you've [created your TikTok Shop App](https://partner.tiktokshop.com/docv2/page/create-tts-app-oauth-client), you're ready to create a test Seller account that you can use to generate test access tokens to make your first call to the TikTok Shop API.
Because you're on the journey of making your first API call, you will most likely not have Sellers or Creators that can consent to sharing their data with you. To solve this problem, we've created a Development Shop Sandbox in which you can create a test TikTok Shop Seller account that you can use to generate authorization codes, access tokens, and refresh tokens.
Test Seller accounts come in two types — a **core function account** and a **full function account**. Choose based on what you need to test:
| Dimension | Core function account | Full function account |
| --- | --- | --- |
| Business info required | Minimal | More complete business details |
| APIs you can test | Product listings, order updates, fulfillment | End-to-end, including payments and buyer-side order flows |
| Test buyer account needed | No | Yes |
| Payment / card info needed | No | Yes |
| Best for | Getting started / your first API call | Testing payments, checkout, and full fulfillment |

Choose a **full function account** when you need to test scenarios that require real buyer and payment information, such as checkout, payments, and end-to-end fulfillment. For how to create and use one, see [Seller Center development shops](https://partner.tiktokshop.com/docv2/page/seller-center-development-shops). The rest of this tutorial uses a core function account.
**Before you create a test account:**

* Binding a test Seller account to your developer account is **permanent and cannot be undone**, so set it up deliberately.
* The account must match its target **market/region**, and access may be affected by **regional restrictions or VPN**. Use a network consistent with the market you select.

To set up your core function account, follow these steps:

1. In Partner Center Console, select **Development Kits** from the navigation pane. Then select **Development Shops** from the list of options.
2. Click the **create test account** button on the **Seller Center Development Shops** panel.
3. Select **"Core Function"**.
4. For **"Shop Type"**, select **"Local"**. A **Local** shop sells to buyers in the same market and fulfills domestically, while a **cross-border** shop sells into another market and ships internationally. For getting started, choose **Local**.
5. Provide an **"Account Nickname"**. This is the name that will be displayed in the user interface once the account is created, so you should name this something that you'll easily recognize in the future.
6. For **"Onboarding type"**, select **individual**. An **individual** seller onboards with minimal personal details, while a **business** seller must provide company and registration documents. For getting started, choose **individual**.
7. Click the **create** button.

You're now ready to move on to the next step in making your first API call, but if you want to learn more about test Seller accounts and the test functionality you can use such as creating products and simulating sales and shipping, see [Seller Center development shops](https://partner.tiktokshop.com/docv2/page/seller-center-development-shops).
### Next steps
Now that you've got a test Seller account, you can [generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token).


---

## Get started > Make your first API call > Generate a test access token

Doc: https://partner.tiktokshop.com/docv2/page/generate-test-access-token · cập nhật 2026-07-01

Now that you've [created a test TikTok Seller account](https://partner.tiktokshop.com/docv2/page/create-test-seller-account), you're ready to generate a test access token.
A test access token is an OAuth 2.0 credential that you present to the TikTok Shop API resource server to access the data of the TikTok Shop test Seller that consented to sharing their data with your TikTok Shop App.
In order to generate a test access token, you'll first need to go to your test Seller account, consent to share data with your test TikTok Shop App, and retrieve the **authorization code** in the return URL that you specified when you created your test TikTok Shop App. You'll then pass the authorization code to the TikTok Shop Authorization Server to retrieve an **access token** and a **refresh token**.
To generate a test access token, begin by navigating to the [TikTok Shop Partner Center Console](https://partner-sso.tiktok.com/account/login).
### Domain usage
TikTok Shop authorization-related documents may mention several domains. They serve different purposes:
| Domain | Purpose |
| --- | --- |
| `https://partner.tiktokshop.com` | TikTok Shop Partner Center and developer documentation entry point. Some app creation and OAuth setup guides link to this domain. |
| `https://partner-sso.tiktok.com/account/login` | Partner Center Console sign-in page used before accessing **Development Kits**, **Development Shops**, and app testing tools. |
| `https://auth.tiktok-shops.com` | TikTok Shop Authorization Server for token APIs, including `/api/v2/token/get` and `/api/v2/token/refresh`. Use this domain from a secure backend or trusted API client, not from the browser address bar. |
### Steps

1. Click on **Development Kits > Development Shops**.
2. Click on the test account. In the right hand pane, under **Start Testing**, click on the **Authorize App** button.
3. In the **Authorize a service** dialog box, enable the radio button for your TikTok Shop App.
4. You'll be redirected to the TikTok Shop Seller Center for your test Seller account. Select the duration, enter a contact email though it's not used, and finally click the **Confirm to install** button.
5. You'll be redirected to the **Authorize** dialog box. Select the checkbox next to the acknowledgement, and click the **Authorize** button.
6. You'll be redirected to the **redirect URL** that you specified for your TikTok Shop App when you created it. If you don't have a service at the redirect URL to receive the authorization code, the URL address in your browser will contain your callback URL, so copy and paste the URL to a text document. Select the value that the `code` parameter is set to, this is your **authorization code**.
7. Your authorization code is valid for 30 minutes only, so you'll need to move quickly on the next step. You'll be making an HTTP call to the TikTok Shop Authorization Server. Use a secure backend service, curl, or a trusted API client such as Postman. Do not paste a fully assembled token request URL that contains `app_secret` into a browser address bar, shared screenshots, logs, or untrusted third-party tools. The server address is `https://auth.tiktok-shops.com/api/v2/token/get` and there are four required query parameters:
   1. `app_key`: Your TikTok Shop App application key that was generated for you when you created your TikTok Shop App.
   2. `app_secret`: Your TikTok Shop App secret that was generated for you when you created your TikTok Shop App. Keep this value server-side.
   3. `auth_code`: The `code` parameter from step 6.
   4. `grant_type`: This string must be set exactly to `authorized_code`. Note that this is **not** the standard OAuth 2.0 spelling `authorization_code`; using `authorization_code` will cause the request to fail.
8. The response body for the call in step 7 includes a JSON object named `data`. For the purposes of making your first API call, we'll focus on four properties in this object:
   1. `access_token`: This is the **access token** necessary to make your first API call.
   2. `access_token_expire_in`: This is the expiration date and time for the `access_token`. It's in Unix epoch time. The default access token validity period is seven days.
   3. `refresh_token`: This is the **refresh token** you'll use to generate a new `access_token` once the current date is greater than `access_token_expire_in`.
   4. `refresh_token_expire_in`: This is the expiration date and time of the refresh token in Unix epoch format. Once this date and time has been reached, you must re-authorize your TikTok Shop App starting at step 2 above.

### Example call flow
For step 7 above, call the token endpoint from a secure backend service, curl, or Postman. Use placeholders or environment variables for secrets; do not paste real `app_secret` values into browser address bars, public logs, tickets, or screenshots.
Example curl request:
```Bash
curl -G 'https://auth.tiktok-shops.com/api/v2/token/get' \
  --data-urlencode 'app_key={app_key}' \
  --data-urlencode 'app_secret={app_secret}' \
  --data-urlencode 'auth_code={auth_code_from_redirect}' \
  --data-urlencode 'grant_type=authorized_code'
```

Example Postman setup:
| Setting | Value |
| --- | --- |
| Method | `GET` |
| URL | `https://auth.tiktok-shops.com/api/v2/token/get` |
| Query param `app_key` | `{{app_key}}` |
| Query param `app_secret` | `{{app_secret}}` |
| Query param `auth_code` | `{{auth_code}}` |
| Query param `grant_type` | `authorized_code` |
If all the parameter values are valid, the response will be in JSON text format. For example:
```JSON
{
  "code": 0,
  "message": "success",
  "data": {
    "access_token": "TTP_Fw8rBwAAAAAkW03FYd09DG-9INtpw361hWthei8S3fHX8iPJ5AUv99fLSCYD9-UucaqxTgNRzKZxi5-tfFMtdWqglEt5_iCk",
    "access_token_expire_in": 1660556783,
    "refresh_token": "TTP_NTUxZTNhYTQ2ZDk2YmRmZWNmYWY2YWY2YzkxNGYwNjQ3YjkzYTllYjA0YmNlMw",
    "refresh_token_expire_in": 1691487031,
    "open_id": "7010736057180325637",
    "seller_name": "Jjj test shop",
    "seller_base_region": "ID",
    "user_type": 0,
    "granted_scopes": [
      "seller.affiliate_collaboration.read",
      "seller.affiliate_collaboration.write"
    ]
  },
  "request_id": "2022080809462301024509910319695C45"
}
```

The fields in the response are defined as follows:
| **Parameter** | **Type** | **Description** | **Sample** |
| --- | --- | --- | --- |
| code | int | A machine-readable response code that represents the request result. `0` indicates success. For more information about failure codes, refer to Common error codes. | 0 |
| message | string | A human-readable message that describes the success or failure of the API request. | success |
| request_id | string | ID to track the API request. | 2022080809462301024509910319695C45 |
| data | object | The response data payload. |  |
| access_token | string | User access token needed to make calls to TikTok Shop Open API endpoints. Pass this value in the `x-tts-access-token` header of an API request to authorize the request. | TTP_Fw8rBwAAAAAkW03FYd09DG-9INtpw361hWthei8S3fHX8iPJ5AUv99fLSCYD9-UucaqxTgNRzKZxi5-tfFMtdWqglEt5_iCk |
| access_token_expire_in | Unix timestamp | Expiration timestamp for access token, with default expiration time set to **seven days**. The Unix timestamp represents the date and time the access token will expire. | 1660556783 |
| refresh_token | string | A token to refresh the access token. Store it securely on the server side. | TTP_NTUxZTNhYTQ2ZDk2YmRmZWNmYWY2YWY2YzkxNGYwNjQ3YjkzYTllYjA0YmNlMw |
| refresh_token_expire_in | Unix timestamp | Expiration timestamp for refresh token. The Unix timestamp represents the date and time the refresh token will expire. | 1691487031 |
| open_id | string | An ID used to identify the user who has authorized the retrieval of their data in API calls. | 7010736057180325637 |
| seller_name | string | The name of the seller you are authorizing for your app. | Jjj test shop |
| seller_base_region | string | The region where the seller is based. | ID |
| user_type | int | Type of user returned by the token response. Possible values: `0`: `TTS` (TikTok Shop seller); `1`: `TTC` (TikTok creator); `2`: `PARTNER`; `3`: `PARTNERV2`; `4`: `GS`; `5`: `GSV2`. | 0 |
| granted_scopes | []string | The authorized API scopes for the app. This field includes the **Scope Key** value of the authorized API scopes.   ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/044481b7d2fd495989a3ef8bbbc502fa~tplv-k9wyc2ijk0-image.image)   | ["seller.affiliate_collaboration.read","seller.affiliate_collaboration.write"] |
### Refresh an access token
When the access token expires, use the refresh token to request a new access token:
```Bash
curl -G 'https://auth.tiktok-shops.com/api/v2/token/refresh' \
  --data-urlencode 'app_key={app_key}' \
  --data-urlencode 'app_secret={app_secret}' \
  --data-urlencode 'refresh_token={refresh_token}' \
  --data-urlencode 'grant_type=refresh_token'
```

The `grant_type` value for this endpoint must be set exactly to `refresh_token`. If the refresh token has expired, or if the test Seller has revoked authorization, you must generate a new authorization code and repeat the authorization flow.
### Next steps
To continue on the journey to making your first API call, make note of your **access_token** value and securely store the **refresh_token** for future token renewal.
Your next step is to [create a cryptographic hash to sign your API call](https://partner.tiktokshop.com/docv2/page/create-hash-to-sign-your-test-api-call).


---

## Get started > Make your first API call > Create a hash to sign your test API call

Doc: https://partner.tiktokshop.com/docv2/page/create-hash-to-sign-your-test-api-call · cập nhật 2026-07-01

Now that you've [created a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token), you're ready to generate the cryptographic hash required to sign your first API call.
There are five steps to generating the required cryptographic hash:
### Domain and App Secret location
TikTok Shop documents may mention several Partner Center entry points. Use them as follows:
| Entry point | Purpose |
| --- | --- |
| `https://partner.tiktokshop.com` | Partner Center and developer documentation entry point. |
| `https://partner-sso.tiktok.com/account/login` | Partner Center Console sign-in page. After signing in, use the Console to manage apps, development shops, and app credentials. |
You can find your **App Secret** in the Partner Center Console:
```Plain Text
Partner Center Console
  -> App & Service
  -> Select your app
  -> App credentials / Developing section
  -> App Secret
```

Some app creation guides mention that the App Secret is shown on the confirmation page when the app is created. If you need to look it up later, use the Partner Center Console path above. In this guide, **App Secret** is the only term used for this credential.
### Step 1: Sort query parameter names alphabetically
Sort the query parameter names and values alphabetically. For the Get Authorized Shops API, there are two required query parameters: `app_key` and `timestamp`. You're already familiar with `app_key`, it's the TikTok Shop App key that was generated for your test TikTok Shop App when you created it. `timestamp` is the current date and time in Unix epoch format, which is the number of seconds that have passed since January 1, 1970.
Generate the timestamp locally in seconds. For example:
```Bash
date +%s
```

The timestamp must be close to the TikTok Shop server time. If your local machine's clock differs too much from server time, signature verification can fail. If you see timestamp or signature validation errors, check your system clock and refer to Common error codes.
As an example, let's assume your `app_key` is `123456` and the current `timestamp` is `1234567890`. To sort these parameters, we compare `app_key` to `timestamp`, and since the first letter of `app_key` is `a`, it comes before the `t` in `timestamp`. Therefore, our sorted query parameters are 1: `app_key`, 2: `timestamp`.
### Step 2: Concatenate the sorted parameter names and values
Concatenate the sorted query parameters and their values from step 1 into a single string. In the example from step 1, this string is `app_key123456timestamp1234567890`.
### Step 3: Append the string from step 2 to the API path
For our first API call, we don't need to perform a step to concatenate the request body to the string created in step 2. For the call to Get Authorized Shops, there is no request body.
If you sign an API that has a request body, append the request body at this point according to the rules in [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request). Make sure the body used for signing exactly matches the body sent in the API request.
Therefore, our next step is to append the string from step 2 to the API request path. For Get Authorized Shops, this is:
```Plain Text
/authorization/202309/shops
```

In the example from steps 1 and 2, the resulting string is:
```Plain Text
/authorization/202309/shopsapp_key123456timestamp1234567890
```

### Step 4: Prepend and append the App Secret
Prepend and append your TikTok Shop App Secret to the string in step 3. In our example, let's assume that our App Secret is `abc000def111`. The resulting string is now:
```Plain Text
abc000def111/authorization/202309/shopsapp_key123456timestamp1234567890abc000def111
```

### Step 5: Encode the string using HMAC-SHA256
To generate the signature, use the **HMAC-SHA256** algorithm.
HMAC-SHA256 requires two inputs:

1. **Key**: your TikTok Shop **App Secret**.
2. **Message**: the string to be signed from step 4.

Some tools label the HMAC key field as `Key`, `Secret`, `Secret Key`, or `Salt`. In all of those fields, use the same TikTok Shop **App Secret**. Do not use the App Key as the HMAC key.
Do not paste your App Secret into public third-party HMAC generator websites or search-result tools. App Secret is a sensitive credential and should stay in your local environment, backend service, or trusted internal tooling.
You can generate the signature locally. The examples below use placeholder values; in real applications, load the App Secret from environment variables or a secret manager instead of hardcoding it in source code.
For example, with Python:
```Python
import hashlib
import hmac

app_secret = "abc000def111"
message = "abc000def111/authorization/202309/shopsapp_key123456timestamp1234567890abc000def111"

signature = hmac.new(
    app_secret.encode("utf-8"),
    message.encode("utf-8"),
    hashlib.sha256,
).hexdigest()

print(signature)
```

Or with Node.js:
```JavaScript
const crypto = require("crypto");

const appSecret = "abc000def111";
const message =
  "abc000def111/authorization/202309/shopsapp_key123456timestamp1234567890abc000def111";

const signature = crypto
  .createHmac("sha256", appSecret)
  .update(message)
  .digest("hex");

console.log(signature);
```

Use lowercase hex output unless otherwise specified. For complete signing rules and language-specific samples, refer to [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request).
### Next steps
Now that you've generated your cryptographic hash, you can make your first API call [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/call-get-authorized-shops).


---

## Get started > Make your first API call > Call Get Authorized Shops

Doc: https://partner.tiktokshop.com/docv2/page/call-get-authorized-shops · cập nhật 2026-07-01

After you have generated an `access_token` and [created the cryptographic hash for your request](https://partner.tiktokshop.com/docv2/page/create-hash-to-sign-your-test-api-call), you can make your first TikTok Shop API call: **Get Authorized Shops**.
For this call, pass the `access_token` in the `x-tts-access-token` header and include the signed query parameters in the request URL. A command-line tool such as cURL is recommended because this request requires custom headers.
### Domain usage
This getting-started flow uses several TikTok Shop domains. They serve different purposes:
| Domain | Purpose |
| --- | --- |
| [https://partner.tiktokshop.com](https://partner.tiktokshop.com/) | TikTok Shop Partner Center and developer documentation entry point. |
| [https://partner-sso.tiktok.com/account/login](https://partner-sso.tiktok.com/account/login) | Partner Center Console sign-in page. After signing in, use the Console to manage apps, development shops, and app credentials. |
| [https://auth.tiktok-shops.com](https://auth.tiktok-shops.com/) | TikTok Shop Authorization Server for token APIs, including `/api/v2/token/get` and `/api/v2/token/refresh`. |
| [https://open-api.tiktokglobalshop.com](https://open-api.tiktokglobalshop.com/) | TikTok Shop Open API resource server. Use this domain to call APIs such as `GET /authorization/202309/shops`. |
### App credential location
You can find your app credentials in the Partner Center Console:
```Plain Text
Partner Center Console
  -> App & Service
  -> Select your app
  -> App credentials / Developing section
  -> App Key and App Secret
```

Some app creation guides mention that App Key and App Secret are shown on the confirmation page when the app is created. If you need to look them up later, use the Partner Center Console path above.
### Request parameters
| **Parameter** | **Location** | **Type** | **Description** |
| --- | --- | --- | --- |
| `app_key` | Query | string | The **App Key** generated for your TikTok Shop App. |
| `sign` | Query | string | The cryptographic hash that you created in [Create a hash to sign your test API call](https://partner.tiktokshop.com/docv2/page/create-hash-to-sign-your-test-api-call). |
| `timestamp` | Query | Unix timestamp | The Unix epoch timestamp used to generate the `sign` parameter. The timestamp used for the signature and the timestamp sent in this API call must match the same signing attempt and must be within five minutes of the request time. If more than five minutes have passed, generate a new timestamp and a new `sign` value together. |
| `x-tts-access-token` | Header | string | The test access token you created when you [generated a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token). |
### Example request
If you're not creating the request programmatically in code using an HTTP library, you can use cURL:
```Bash
curl --location --request GET 'https://open-api.tiktokglobalshop.com/authorization/202309/shops?app_key=<your_app_key>&sign=<your_cryptographic_hash>&timestamp=<timestamp_used_for_this_sign>' \
  --header 'Content-Type: application/json' \
  --header 'x-tts-access-token: <your_access_token>'
```

### Example successful response
If your request is successful, you'll receive a response like this:
```JSON
{
  "code": 0,
  "data": {
    "shops": [
      {
        "cipher": "<the shop cipher for your test TikTok Shop>",
        "code": "<the shop code for your test TikTok Shop>",
        "id": "<the identifier for your test TikTok Shop>",
        "name": "<the name of your test TikTok Shop>",
        "region": "<the region of your test TikTok Shop>",
        "seller_type": "<your seller type>"
      }
    ]
  },
  "message": "Success",
  "request_id": "<the request identifier generated by the TikTok Shop server>"
}
```

### `seller_type` and `user_type`
The `seller_type` field in this API response is not the same as the `user_type` field returned by the token API.
| Field | Returned by | Meaning |
| --- | --- | --- |
| `user_type` | Token APIs such as [https://auth.tiktok-shops.com/api/v2/token/get](https://auth.tiktok-shops.com/api/v2/token/get) | The type of user or authorization principal that generated the token, such as seller, creator, partner, or global-selling related types. |
| `seller_type` | `GET /authorization/202309/shops` | The type of seller/shop returned in the authorized shop list. Possible values include `LOCAL` and `CROSS_BORDER`. |
Use `seller_type` to understand the shop model returned by Get Authorized Shops. Use `user_type` only when interpreting the token response from [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token).
### Troubleshooting
The three most common issues are related to the `access_token`, the `sign` value, or an expired timestamp/signature pair.
If your request fails due to an authentication issue, check the `x-tts-access-token` header and ensure that you've followed all the steps in [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token). If you still encounter authentication issues, you may have a problem with either your [TikTok Shop App](https://partner.tiktokshop.com/docv2/page/create-tts-app-oauth-client) or your [test TikTok Shop Seller account](https://partner.tiktokshop.com/docv2/page/create-test-seller-account). You can reach out to [technical support](https://partner.tiktokshop.com/docv2/page/how-to-contact-support) for help.
If your request fails because of an invalid `sign` parameter, review [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request), which contains the complete signing rules. Make sure the API path, sorted query parameters, request body if any, and App Secret are exactly the same values used to create the signature.
If your request fails because the timestamp or signature has expired, generate a fresh Unix timestamp and recreate the `sign` value with that same timestamp. Do not reuse an old signature with a new timestamp, and do not reuse a new signature with an old timestamp. Also check your local machine's clock if you continue to see timestamp-related errors.
If you still experience issues after checking the access token, signature, and timestamp, reach out to [technical support](https://partner.tiktokshop.com/docv2/page/how-to-contact-support) for assistance.
### Next steps
After you've successfully made your first API call, you're ready to start working on your TikTok Shop App. Head over to the [developer guide](https://partner.tiktokshop.com/docv2/page/tts-developer-guide) to learn about:

* [TikTok Shop API concepts](https://partner.tiktokshop.com/docv2/page/tts-api-concepts-overview),
* How to [develop a public TikTok Shop App and launch it in the TikTok Shop App Store](https://partner.tiktokshop.com/docv2/page/app-development-overview) and the requirements for listing in the [App development process overview](https://partner.tiktokshop.com/docv2/page/app-development-process-overview),
* Our [developer tools](https://partner.tiktokshop.com/docv2/page/seller-center-development-shops) to help you with application development and testing.


---

## Get started > Make your first API call > Postman

Doc: https://partner.tiktokshop.com/docv2/page/call-your-first-api-using-postman · cập nhật 2026-07-01

[Postman](https://www.postman.com/) is a popular API platform for building and testing APIs. You can use Postman to accelerate TikTok Shop API testing and integration.
For a first API request, follow the tutorial [Call Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/call-get-authorized-shops). The endpoint used in this tutorial is documented in the API reference [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309). Use the tutorial page for the end-to-end walkthrough, and use the API reference page for the full endpoint schema.
### Download the Postman collection
We provide a ZIP file that contains a Postman collection and a set of environment variables. Fill in the environment variables, including `app_key`, `app_secret`, and `auth_code`, then call **GET Access Token** to obtain an API access token. The collection can then use the saved variables to call subsequent APIs.
[Download the Postman collection](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/TikTokShopPostmanCollection.zip)
The original CDN path contains `[[`, which must be URL-encoded as `%5B%5B`. The encoded link above is the working download URL.
Important: Do not commit, submit, or share any Postman collection, environment file, or script that contains a real App Secret. Use YOUR_APP_SECRET only as a placeholder in examples, and store the real app_secret only in a private Postman environment variable.
### Domain reference
This guide uses more than one TikTok Shop domain because each domain has a different purpose.
| Domain | Purpose | Example in this guide |
| --- | --- | --- |
| `auth.tiktok-shops.com` | OAuth token APIs, including getting and refreshing access tokens. | `https://auth.tiktok-shops.com/api/v2/token/get` |
| `open-api.tiktokglobalshop.com` | TikTok Shop OpenAPI calls after you have an access token and request signature. | `https://open-api.tiktokglobalshop.com/authorization/202309/shops` |
| `partner.tiktokshop.com/docv2` | Developer documentation pages, tutorials, and API reference pages. | [Call Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/call-get-authorized-shops) |

For authorization entry URLs and market-specific authorization domains, refer to the [Authorization guide](https://partner.tiktokshop.com/docv2/page/authorization-guide-202309).
### Step 1: Obtain an access token
This section walks through obtaining an `access_token` in Postman. For more information about access tokens, refresh tokens, and required parameters, refer to the [Authorization guide](https://partner.tiktokshop.com/docv2/page/authorization-guide-202309).
**1. Open a new request tab.**
Set the request method to **GET** and use this request URL:
```Plain Text
https://auth.tiktok-shops.com/api/v2/token/get
```

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/cc6793c4507340409485caaab625dc5b~tplv-k9wyc2ijk0-image.image)
**2. Add the query parameters.**
| Parameter | Value | Required | Notes |
| --- | --- | --- | --- |
| `app_key` | `{{app_key}}` | Yes | Your app key from Partner Center. |
| `app_secret` | `{{app_secret}}` | Yes | Store this value in a private Postman environment variable. Do not hardcode it in scripts or share it in screenshots. |
| `auth_code` | `{{auth_code}}` | Yes | The authorization code returned after authorization. Replace the sample value in the environment file. |
| `grant_type` | `authorized_code` | Yes | This value must be entered exactly as `authorized_code`. Do not change it to the standard OAuth spelling `authorization_code`. |

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/47942eca78b14028ba05851cad00f87e~tplv-k9wyc2ijk0-image.image)
**3. Send the request.**
Press **Send** next to the request URL. If successful, the response should resemble the following:
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/c0350bde936b43cfa9e8858ce8a612d9~tplv-k9wyc2ijk0-image.image)
**4. Save token variables.**
The downloaded collection can save token values automatically. If you configure the request manually, add a Postman **Tests** script like this:
```JavaScript
var json = pm.response.json();

if (json && json.data) {
    pm.environment.set("access_token", json.data.access_token);
    pm.environment.set("refresh_token", json.data.refresh_token);
}
```

For token lifecycle details and refresh-token usage, refer to [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token).
### Step 2: Set common parameters
This section walks through setting up [common parameters](https://partner.tiktokshop.com/docv2/page/common-parameters) to call [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309).
**1. Open a new request tab.**
Set the request method to **GET** and use this request URL:
```Plain Text
https://open-api.tiktokglobalshop.com/authorization/202309/shops
```

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/843b2ccb3c184c719b2f885af66bef71~tplv-k9wyc2ijk0-image.image)
**2. Add the query parameters.**
| Parameter | Value | Required | Notes |
| --- | --- | --- | --- |
| `app_key` | `{{app_key}}` | Yes | Your app key from Partner Center. |
| `timestamp` | `{{timestamp}}` | Yes | Generated by the Pre-request Script in Step 3. Use Unix epoch seconds. |
| `sign` | `{{sign}}` | Yes | Generated by the Pre-request Script in Step 3. |

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/e21f6871b17f4162b7a0a02572609114~tplv-k9wyc2ijk0-image.image)
**Important:** Set `sign` to `{{sign}}` and `timestamp` to `{{timestamp}}`. If the timestamp is too old, regenerate both `timestamp` and `sign` before sending the request.
**3. Add the headers.**
| Header | Value | Required | Notes |
| --- | --- | --- | --- |
| `Content-Type` | `application/json` | Yes | Required by the API. |
| `x-tts-access-token` | `{{access_token}}` | Yes | The access token obtained in Step 1. |

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/6fae3cd282994c0d979bcc6759e44968~tplv-k9wyc2ijk0-image.image)
If you press **Send** before generating `sign` and `timestamp`, the API returns a signature error. Continue to Step 3 to automate request signing in Postman.
### Step 3: Request signature
Calling TikTok Shop OpenAPI requires a request signature. Postman can generate the signature automatically in the **Pre-request Script** section. For the canonical signing rule, refer to [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request).
Important: Do not hardcode a real App Secret in the Pre-request Script. Use YOUR_APP_SECRET only as a placeholder in examples. Do not log the signing string, because it contains the App Secret. Set app_secret in your private Postman environment instead.
**1. Set the required environment variables.**
| Variable | Value | Required | Notes |
| --- | --- | --- | --- |
| `app_secret` | Your App Secret | Yes | Used as the HMAC key. Keep it private. |
| `timestamp` | Generated by script | Yes | The script sets this variable automatically. |
| `sign` | Generated by script | Yes | The script sets this variable automatically. |

**2. Add this JavaScript Pre-request Script.**
```JavaScript
function objKeySort(obj) {
    var newKey = Object.keys(obj).sort();
    var newObj = {};
    for (var i = 0; i < newKey.length; i++) {
        newObj[newKey[i]] = obj[newKey[i]];
    }
    return newObj;
}

function getEnvVar(k) {
    var v = pm.variables.get(k);
    if (v != null) {
        return v;
    }
    v = pm.environment.get(k);
    if (v != null) {
        return v;
    }
    v = pm.collectionVariables.get(k);
    if (v != null) {
        return v;
    }
    v = pm.globals.get(k);
    if (v != null) {
        return v;
    }
    return null;
}

function interpolateVar(value) {
    if (value == null) {
        return "";
    }
    const { Property } = require("postman-collection");
    return Property.replaceSubstitutions(String(value), pm.variables.toObject());
}

function getRequestBody() {
    if (!pm.request.body) {
        return "";
    }

    if (pm.request.body.mode === "raw" && pm.request.body.raw) {
        return interpolateVar(pm.request.body.raw);
    }

    return "";
}

var secret = getEnvVar("app_secret");
if (!secret || secret === "YOUR_APP_SECRET") {
    throw new Error("Set app_secret in your Postman environment. Do not hardcode a real App Secret in the script.");
}

var ts = Math.floor(Date.now() / 1000).toString();
pm.variables.set("timestamp", ts);

function calSign(secret) {
    var queryParam = pm.request.url.query ? pm.request.url.query.members : [];
    var param = {};

    for (var i = 0; i < queryParam.length; i++) {
        var item = queryParam[i];
        if (item.disabled) {
            continue;
        }

        var value;
        if (item.key === "timestamp") {
            value = ts;
        } else {
            value = item.value;
            if (value == null || value === "{{" + item.key + "}}") {
                value = getEnvVar(item.key);
            }
        }

        param[item.key] = interpolateVar(value);
    }

    delete param.sign;
    delete param.access_token;

    var sortedObj = objKeySort(param);
    var signstring = secret + pm.request.url.getPath();
    for (var key in sortedObj) {
        signstring += key + sortedObj[key];
    }
    signstring += getRequestBody() + secret;

    return CryptoJS.HmacSHA256(signstring, secret).toString(CryptoJS.enc.Hex);
}

pm.variables.set("sign", calSign(secret));
```

For `GET /authorization/202309/shops`, the request body is empty. For APIs with a JSON request body, set the body to raw JSON before sending the request so the script can include the raw body in the signing string. If your API uses another body mode, follow the body concatenation rule in [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request).
### Step 4: Call Get Authorized Shops
After completing the previous steps, press **Send** to call [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309). If successful, the response should resemble the following:
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/0e743ce89a53494e90954d95f96655f1~tplv-k9wyc2ijk0-image.image)
Key response fields:
| Field | Meaning |
| --- | --- |
| `data.shops[].cipher` | Encrypted shop identifier used as `shop_cipher` in shop-related APIs. |
| `data.shops[].id` | Internal shop ID. |
| `data.shops[].code` | TikTok Shop code displayed in Seller Center. |
| `data.shops[].region` | Shop region. |
| `data.shops[].seller_type` | Seller classification for the shop, such as `CROSS_BORDER` or `LOCAL`. This is different from the token response field `user_type`; see [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token) for token response fields. |
### Troubleshooting
| Symptom | Possible cause | What to do |
| --- | --- | --- |
| `signature is invalid` | `sign` was not generated, the body changed after signing, or the timestamp is too old. | Regenerate `timestamp` and `sign`, then send the request again. Recheck the rule in [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request). |
| `access_token` authentication failed | The token is missing, expired, copied incorrectly, or does not match the app. | Get a new token or refresh the token. See [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token). |
| Download link fails | Some clients do not handle raw `[[` in the CDN path. | Use the encoded ZIP URL in this guide, where `[[` is written as `%5B%5B`. |

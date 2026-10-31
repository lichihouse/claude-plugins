# Developer Guide — General

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.



---

## TikTok Shop developer guide

Doc: https://partner.tiktokshop.com/docv2/page/tts-developer-guide · cập nhật 2026-08-11

Welcome to the TikTok Shop API Developer Guide. The TikTok Shop API gives application and service integrators programmatic access to the TikTok Shop platform — products, orders, fulfillment, finance, affiliate, and more.
#### Which developer are you?
Before you dive in, identify your developer type — it determines which path you follow and which `user_type` you receive during authorization.
| You are… | Build type | Data you access | During authorization you are |
| --- | --- | --- | --- |
| **Seller (in-house) developer** — a seller building for your own shop | Custom app | Your own shop's data only | Seller (`user_type=0`) |
| **App developer / ISV / system integrator** — serving multiple merchants | Public app | Authorized sellers' data | Seller (`user_type=0`) on behalf of the seller |
| **Creator / affiliate integrator** | Public app | Creator-side affiliate data | Creator (`user_type=1`) |
| **Partner (TAP) integrator** | Public app | Partner business data (Affiliate Partner / TAP) | Partner (`user_type=3`) |
See Get started overview for the full breakdown of developer types.
#### Getting started — the 4-step path
If this is your first time, follow these steps in order:

1. **Onboard** — Create a Partner Center account and register as a developer. See Developer onboarding. (US/UK and some markets also require a compliance & legal review — budget 3+ weeks.)
2. **Create your app** — Register a TikTok Shop app (OAuth client) and enable the API scopes you need. See Create a TikTok Shop App (OAuth client).
3. **Authorize and get a token** — Have a seller/creator/partner authorize your app, then exchange the `auth_code` for an `access_token`. Start with the Authorization overview.
4. **Make your first API call** — Sign and send your first request. See Make your first API call overview.

#### API reference
A full API reference is organized by TikTok Shop data domain. Open the **API Reference** tab in the top navigation of Partner Center, or start with these overviews:

   * [Seller API overview](https://partner.tiktokshop.com/docv2/page/seller-api-overview)
   * [Products API overview](https://partner.tiktokshop.com/docv2/page/products-api-overview)
   * [Order API overview](https://partner.tiktokshop.com/docv2/page/order-api-overview)
   * [Fulfillment API overview](https://partner.tiktokshop.com/docv2/page/fulfillment-api-overview)
   * [Logistic API overview](https://partner.tiktokshop.com/docv2/page/logistic-api-overview)
   * [Finance API overview](https://partner.tiktokshop.com/docv2/page/finance-api-overview)

All remaining domains are available under the **API Reference** tab.
#### Use case guides and webhooks

* **Use case guides** walk you through common integration scenarios (connecting shops, product categories, and more) with code-flow diagrams. See the **Use case guides** section of this guide.
* **Webhooks** let your app subscribe to platform notifications. See the Webhooks overview.
* To list your app in the TikTok Shop App Store, see the App development overview.

#### Next steps
Pick the next step that matches your goal:

* **I need to set up access** → [Developer onboarding](https://partner.tiktokshop.com/docv2/page/developer-onboarding)
* **I'm ready to build and authorize** → [Authorization overview](https://partner.tiktokshop.com/docv2/page/authorization-overview-202407)
* **I want to call an API now** → [Make your first API call overview](https://partner.tiktokshop.com/docv2/page/make-your-first-api-call-overview)

> Stuck at any point? See How to contact support for the right channel.


---

## Submit a ticket through Partner Assistant

Doc: https://partner.tiktokshop.com/docv2/page/kwfskwpj · cập nhật 2026-06-12

### Submit a ticket through Partner Assistant
If you are a registered ISV (App Developer), you can get answers and submit support tickets through **Partner Assistant**, the AI Q&A copilot built into TikTok Shop Partner Center. Describe your issue in plain language first — you may get your answer right away. If the answer doesn't resolve your issue, **Submit a Ticket** is one click away.
**Note:** The previous standalone ticket entries have been retired. Every new ticket now starts with at least one round of Q&A in Partner Assistant. You can still view and manage your existing tickets on the **Support tickets** page.

1. Open Partner Assistant in either of the following ways: click the **floating button** on any Partner Center page (hover over it to see **Ask Partner Assistant for Help**), or click **Help** in the top navigation bar and select **Ask Partner Assistant**. Partner Assistant opens in a slide-out drawer on the right side of the page:
(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/eda1d66ce9e341da834b95ff6f5e65cf~tplv-k9wyc2ijk0-image.image)

2. Describe your issue in the input box. Include specifics such as the API name, error code, or Request ID to help Partner Assistant give a more precise answer. Partner Assistant replies with a plain-language explanation, links to the relevant documentation, and a suggested next step:
(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/9f84f1ec603645c391e666de8a800a54~tplv-k9wyc2ijk0-image.image)

3. If the reply doesn't fully resolve your issue, click **Submit a Ticket** in the toolbar below the reply:
(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/2a554d4ff9cb4c33aa18ff561f371d91~tplv-k9wyc2ijk0-image.image)

**Note:** Even if Partner Assistant is temporarily unavailable, **Submit a Ticket** stays available, so you can always reach our support team.

4. Fill in the ticket details: choose the appropriate issue category so your ticket is directed to the relevant point of contact, provide a ticket title and a detailed issue description, and attach any relevant files and documents. The more detailed your description, the more efficiently our support team can provide timely assistance. When you're done, submit the ticket:
(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/bc409b65c9b943e595f9363865c97065~tplv-k9wyc2ijk0-image.image)

5. Upon successful ticket submission, a confirmation will be displayed:
(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/6fbedb06ede84bc7a9660d2fee465846~tplv-k9wyc2ijk0-image.image)

### Ticket response time
Once you've submitted a ticket, our support team aims to provide an initial response within 24 business hours, usually much sooner, to address your question. Our goal is to resolve your issue completely within 48 business hours.

* **Initial Response:** Typically < 24 business hours
* **Issue Resolution:** Target < 48 business hours

Please note that these are general response time guidelines, and we always strive to address your needs as promptly as possible.

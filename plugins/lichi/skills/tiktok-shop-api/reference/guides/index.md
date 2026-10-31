# Developer Guide (hướng dẫn kỹ thuật: auth, ký request, webhook, lỗi chung...)

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.


| Mục | Trang | File |
|---|---|---|
| General | [TikTok Shop developer guide](https://partner.tiktokshop.com/docv2/page/tts-developer-guide) | `reference/guides/general.md` |
| Get started | [Get started overview](https://partner.tiktokshop.com/docv2/page/tts-developer-types) | `reference/guides/get-started.md` |
| Get started | [App Category Selection Guide](https://partner.tiktokshop.com/docv2/page/hulvi36o) | `reference/guides/get-started.md` |
| Get started > Tiktok Shop Seller Developer | [Seller Developer Onboarding Onepager](https://partner.tiktokshop.com/docv2/page/seller-developer-onboarding-onepager) | `reference/guides/get-started.md` |
| Get started > Tiktok Shop Seller Developer | [Common Error for Seller Developer](https://partner.tiktokshop.com/docv2/page/guwthhrw) | `reference/guides/get-started.md` |
| Get started > Onboarding | [Developer onboarding](https://partner.tiktokshop.com/docv2/page/developer-onboarding) | `reference/guides/get-started.md` |
| Get started > Onboarding > Additional Developer onboarding steps for Tokopedia | [Tokopedia & Shop - ISV & Seller developer onboarding](https://partner.tiktokshop.com/docv2/page/tokopedia-shop-isv-seller-developer-onboarding) | `reference/guides/get-started.md` |
| Get started > Authorization | [Authorization overview](https://partner.tiktokshop.com/docv2/page/authorization-overview-202407) | `reference/guides/get-started.md` |
| Get started > Authorization | [Seller authorization guide](https://partner.tiktokshop.com/docv2/page/seller-authorization-guide) | `reference/guides/get-started.md` |
| Get started > Authorization | [Creator authorization guide](https://partner.tiktokshop.com/docv2/page/creator-authorization-guide) | `reference/guides/get-started.md` |
| Get started > Authorization | [Partner authorization guide](https://partner.tiktokshop.com/docv2/page/partner-authorization-guide) | `reference/guides/get-started.md` |
| Get started > Authorization | [Authorization via App Store](https://partner.tiktokshop.com/docv2/page/authorization-via-app-store) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI | [TTS Open Toolkit Developer Tools](https://partner.tiktokshop.com/docv2/page/6kiauzd6) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI | [Overview](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-cli) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI | [Find the right API and webhook](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-find-api-webhook) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI | [Work with apps and sandbox accounts](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-apps-sandbox) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI | [Plan an integration and generate a runnable demo](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-integration-plan-demo) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI | [Review API and Changelog impact](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-api-changelog-impact) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI | [Call supported developer APIs](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-developer-api-operations) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI | [Install and set up](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-install-setup) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI | [Sign in and manage profiles](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-auth-profiles) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI | [Upgrade and verify](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-upgrade-verify) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI | [About TTS Open Toolkit CLI](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-about-cli) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI reference | [Overview](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-cli-reference) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI reference | [Built-in skills](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-built-in-skills) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI reference | [Choose and manage skills](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-manage-skills) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI reference | [CLI command reference](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-command-reference) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > TTS Open Toolkit CLI reference | [Configuration, output, and local files](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-configuration-output-files) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > Help and feedback | [Overview](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-help-feedback) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > Help and feedback | [Troubleshooting](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-troubleshooting) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > Help and feedback | [Security and capability boundaries](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-security-boundaries) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI > Help and feedback | [Releases and feedback](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-releases-feedback) | `reference/guides/get-started.md` |
| Get started > TTS Open Toolkit CLI | [TTS Open Toolkit for AI agents](https://partner.tiktokshop.com/docv2/page/tts-open-toolkit-ai-agents) | `reference/guides/get-started.md` |
| Get started > Make your first API call | [Make your first API call overview](https://partner.tiktokshop.com/docv2/page/make-your-first-api-call-overview) | `reference/guides/get-started.md` |
| Get started > Make your first API call | [Create a TikTok Shop App (OAuth client)](https://partner.tiktokshop.com/docv2/page/create-tts-app-oauth-client) | `reference/guides/get-started.md` |
| Get started > Make your first API call | [Create a test seller account](https://partner.tiktokshop.com/docv2/page/create-test-seller-account) | `reference/guides/get-started.md` |
| Get started > Make your first API call | [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token) | `reference/guides/get-started.md` |
| Get started > Make your first API call | [Create a hash to sign your test API call](https://partner.tiktokshop.com/docv2/page/create-hash-to-sign-your-test-api-call) | `reference/guides/get-started.md` |
| Get started > Make your first API call | [Call Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/call-get-authorized-shops) | `reference/guides/get-started.md` |
| Get started > Make your first API call | [Postman](https://partner.tiktokshop.com/docv2/page/call-your-first-api-using-postman) | `reference/guides/get-started.md` |
| Account management | [API entity tags](https://partner.tiktokshop.com/docv2/page/api-entity-tags) | `reference/guides/account-management.md` |
| Account management | [Access scope](https://partner.tiktokshop.com/docv2/page/access-scope) | `reference/guides/account-management.md` |
| TikTok Shop API concepts | [Overview](https://partner.tiktokshop.com/docv2/page/tts-api-concepts-overview) | `reference/guides/tiktok-shop-api-concepts.md` |
| TikTok Shop API concepts | [Methods and endpoints](https://partner.tiktokshop.com/docv2/page/methods-and-endpoints) | `reference/guides/tiktok-shop-api-concepts.md` |
| TikTok Shop API concepts | [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request) | `reference/guides/tiktok-shop-api-concepts.md` |
| TikTok Shop API concepts | [Common parameters](https://partner.tiktokshop.com/docv2/page/common-parameters) | `reference/guides/tiktok-shop-api-concepts.md` |
| TikTok Shop API concepts | [Common errors](https://partner.tiktokshop.com/docv2/page/common-errors) | `reference/guides/tiktok-shop-api-concepts.md` |
| TikTok Shop API concepts | [Regions and languages](https://partner.tiktokshop.com/docv2/page/regions-and-languages) | `reference/guides/tiktok-shop-api-concepts.md` |
| TikTok Shop API concepts | [Rate limits](https://partner.tiktokshop.com/docv2/page/rate-limits) | `reference/guides/tiktok-shop-api-concepts.md` |
| TikTok Shop API concepts | [API versioning](https://partner.tiktokshop.com/docv2/page/api-versioning) | `reference/guides/tiktok-shop-api-concepts.md` |
| Developer tools | [Seller Center development shops](https://partner.tiktokshop.com/docv2/page/seller-center-development-shops) | `reference/guides/developer-tools.md` |
| Developer tools | [Development Shop Manual Order Status Update Guide (Full Account))](https://partner.tiktokshop.com/docv2/page/ar5ppjvv) | `reference/guides/developer-tools.md` |
| Developer tools | [API testing tool](https://partner.tiktokshop.com/docv2/page/api-testing-tool) | `reference/guides/developer-tools.md` |
| Developer tools | [Developer dashboard](https://partner.tiktokshop.com/docv2/page/developer-dashboard) | `reference/guides/developer-tools.md` |
| Use case guides > Shops | [Connecting shops](https://partner.tiktokshop.com/docv2/page/connecting-shops) | `reference/guides/use-case-guides.md` |
| Use case guides > Shops | [Reauthorize shops](https://partner.tiktokshop.com/docv2/page/reauthorize-shops) | `reference/guides/use-case-guides.md` |
| Use case guides > Shops | [Disconnecting shops](https://partner.tiktokshop.com/docv2/page/disconnecting-shops) | `reference/guides/use-case-guides.md` |
| Use case guides > Product categories | [Store product categories](https://partner.tiktokshop.com/docv2/page/store-product-categories) | `reference/guides/use-case-guides.md` |
| Use case guides > Product categories | [Map product categories](https://partner.tiktokshop.com/docv2/page/map-product-categories) | `reference/guides/use-case-guides.md` |
| Use case guides > Product categories | [Explanation of the impact of CA65 attributes on California sales eligibility](https://partner.tiktokshop.com/docv2/page/zj95mjex) | `reference/guides/use-case-guides.md` |
| Use case guides > Analytics | [SPS API Merchant Performance Diagnosis: ISV Integration Use Cases](https://partner.tiktokshop.com/docv2/page/ph0ccose) | `reference/guides/use-case-guides.md` |
| Solution Guidance | [Product API Solution Guide](https://partner.tiktokshop.com/docv2/page/solution-guidance-product-api) | `reference/guides/solution-guidance.md` |
| Solution Guidance | [Orders and Fulfillment API Solution Guide](https://partner.tiktokshop.com/docv2/page/solution-guidance-orders-fulfillment-api) | `reference/guides/solution-guidance.md` |
| Solution Guidance | [TikTok Return Models & Exchanges API Solution Guide](https://partner.tiktokshop.com/docv2/page/solution-guidance-return-exchange-api) | `reference/guides/solution-guidance.md` |
| Solution Guidance | [Affiliate API Solution Guide](https://partner.tiktokshop.com/docv2/page/affiliate-integration) | `reference/guides/solution-guidance.md` |
| Solution Guidance | [Large File Uploads Solution Guide](https://partner.tiktokshop.com/docv2/page/wfi3nz36) | `reference/guides/solution-guidance.md` |
| Solution Guidance | [Shoppable video Integration Solutions](https://partner.tiktokshop.com/docv2/page/ng0l9170) | `reference/guides/solution-guidance.md` |
| Solution Guidance | [Loyalty Membership API & SPI Technical Integration Doc](https://partner.tiktokshop.com/docv2/page/1meo67bh) | `reference/guides/solution-guidance.md` |
| TikTok Shop webhooks | [Overview](https://partner.tiktokshop.com/docv2/page/tts-webhooks-overview) | `reference/guides/tiktok-shop-webhooks.md` |
| TikTok Shop webhooks | [Configuration guide](https://partner.tiktokshop.com/docv2/page/configuration-guide) | `reference/guides/tiktok-shop-webhooks.md` |
| TikTok Shop API SDK | [Overview](https://partner.tiktokshop.com/docv2/page/tts-api-sdk-overview) | `reference/guides/tiktok-shop-api-sdk.md` |
| TikTok Shop API SDK | [Download SDK](https://partner.tiktokshop.com/docv2/page/download-sdk) | `reference/guides/tiktok-shop-api-sdk.md` |
| TikTok Shop API SDK | [Integrate Java SDK](https://partner.tiktokshop.com/docv2/page/integrate-java-sdk) | `reference/guides/tiktok-shop-api-sdk.md` |
| TikTok Shop API SDK | [Integrate GoLang SDK](https://partner.tiktokshop.com/docv2/page/integrate-golang-sdk) | `reference/guides/tiktok-shop-api-sdk.md` |
| TikTok Shop API SDK | [Integrate Node.js SDK](https://partner.tiktokshop.com/docv2/page/integrate-node-js-sdk) | `reference/guides/tiktok-shop-api-sdk.md` |
| TikTok Shop API SDK | [Update SDK](https://partner.tiktokshop.com/docv2/page/update-sdk) | `reference/guides/tiktok-shop-api-sdk.md` |
| TikTok Shop widgets | [Overview](https://partner.tiktokshop.com/docv2/page/tts-widgets-overview) | `reference/guides/tiktok-shop-widgets.md` |
| TikTok Shop widgets | [Get widget token](https://partner.tiktokshop.com/docv2/page/get-widget-token) | `reference/guides/tiktok-shop-widgets.md` |
| TikTok Shop widgets | [Widget SDK user guide](https://partner.tiktokshop.com/docv2/page/widget-sdk-user-guide) | `reference/guides/tiktok-shop-widgets.md` |
| TikTok Shop widgets > Widget integration guide | [Warehouse settings](https://partner.tiktokshop.com/docv2/page/warehouse-settings) | `reference/guides/tiktok-shop-widgets.md` |
| TikTok Shop widgets > Widget integration guide | [Product optimizer](https://partner.tiktokshop.com/docv2/page/product-optimizer) | `reference/guides/tiktok-shop-widgets.md` |
| TikTok Shop widgets > Widget integration guide | [Orders by TikTok shipping(4PL)](https://partner.tiktokshop.com/docv2/page/orders-by-tiktok-shipping-4pl) | `reference/guides/tiktok-shop-widgets.md` |
| TikTok Shop widgets > Widget integration guide | [Tax information widget](https://partner.tiktokshop.com/docv2/page/tax-information-widget) | `reference/guides/tiktok-shop-widgets.md` |
| TikTok Shop widgets > Widget integration guide | [Data compass widget](https://partner.tiktokshop.com/docv2/page/data-compass-widget) | `reference/guides/tiktok-shop-widgets.md` |
| TikTok Shop widgets > Widget integration guide | [Message center](https://partner.tiktokshop.com/docv2/page/message-center) | `reference/guides/tiktok-shop-widgets.md` |
| TikTok Shop widgets > Widget integration guide | [Return and refund](https://partner.tiktokshop.com/docv2/page/return-and-refund) | `reference/guides/tiktok-shop-widgets.md` |
| TikTok Shop widgets > Widget integration guide | [Shoppable video](https://partner.tiktokshop.com/docv2/page/shoppable-video) | `reference/guides/tiktok-shop-widgets.md` |
| TikTok Shop widgets > Widget integration guide | [Responsible Person and Manufacturer Widget](https://partner.tiktokshop.com/docv2/page/responsible-person-and-manufacturer-widget) | `reference/guides/tiktok-shop-widgets.md` |
| Appendix | [Quality engine incident reason code](https://partner.tiktokshop.com/docv2/page/quality-engine-incident-reason-code) | `reference/guides/appendix.md` |
| General | [Submit a ticket through Partner Assistant](https://partner.tiktokshop.com/docv2/page/kwfskwpj) | `reference/guides/general.md` |

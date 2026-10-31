# Developer Guide — Use case guides

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.



---

## Use case guides > Shops > Connecting shops

Doc: https://partner.tiktokshop.com/docv2/page/connecting-shops · cập nhật 2026-07-06

### Connecting and managing TikTok shops
A core scenario for TikTok Shop API developers is to create, manage, and disconnect a persistent connection between a local customer account in your system and that customer's TikTok Shop seller account.
> **Seller authorization only:** This guide applies to **Seller authorization**, where a customer authorizes your app to access TikTok Shop Seller and shop data. Creator authorization and partner authorization use different entry points and may authorize different data owners. See [Creator authorization guide](https://partner.tiktokshop.com/docv2/page/creator-authorization-guide) and [Partner authorization guide](https://partner.tiktokshop.com/docv2/page/partner-authorization-guide) if your app needs creator-owned or partner-owned data.

#### Authorization entry points and API endpoints
Use different domains for authorization, token exchange, and Open API calls. Do not use an authorization entry domain as the Open API request host.
| Purpose | Method and endpoint | Domain / path | Reference |
| --- | --- | --- | --- |
| Start Seller authorization in the United States | Browser redirect | `https://services.us.tiktokshop.com/open/authorize` | [Authorization overview](https://partner.tiktokshop.com/docv2/page/authorization-overview-202407) |
| Start Seller authorization outside the United States | Browser redirect | `https://services.tiktokshop.com/open/authorize` | [Authorization overview](https://partner.tiktokshop.com/docv2/page/authorization-overview-202407) |
| Exchange an authorization code for tokens | `GET` | `https://auth.tiktok-shops.com/api/v2/token/get` | [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token) |
| Refresh an access token | `GET` | `https://auth.tiktok-shops.com/api/v2/token/refresh` | [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token) |
| Get the shops authorized by a Seller token | `GET` | `https://open-api.tiktokglobalshop.com/authorization/202309/shops` | [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309) |
Authorization types are not interchangeable:
| Authorization type | Data owner | US authorization entry | Non-US authorization entry | Use when |
| --- | --- | --- | --- | --- |
| Seller authorization | Seller / shop | `https://services.us.tiktokshop.com/open/authorize` | `https://services.tiktokshop.com/open/authorize` | Your app needs seller-owned shop, product, order, fulfillment, finance, or webhook data. |
| Creator authorization | Creator | `https://shop.tiktok.com/alliance` | `https://shop.tiktok.com/alliance` | Your app needs creator-owned affiliate or creator data. |
| Partner authorization | Partner | `https://partner.us.tiktokshop.com/open/authorize` | `https://partner.tiktokshop.com/open/authorize` | Your app needs partner-owned business category data, such as approved Affiliate Partner APIs. |
#### Manage TikTok Shop connections
A basic requirement for this use case is indexing your local customer data to TikTok Shop data. This allows you to look up the credentials and shop identifiers needed to call TikTok Shop APIs on a customer's behalf.
You must securely store your customer's TikTok Shop access and refresh tokens and associate them with your own local customer identifier. An `access_token` is the credential used to access customer data, but it does not contain enough shop-identifying information by itself. Store the token response and authorized shop data together so you can retrieve the correct token and shop identifiers when making API calls.
You must also store token expiration timestamps so your system can refresh tokens before access expires and reauthorize the app when refresh access expires.
> If you serve customers with cross-border shops in China, also store the `shop_cipher` associated with each TikTok Shop. `shop_cipher` is required by many shop-scoped endpoints for cross-border shops in China. It is optional for local shops in the US, UK, and SEA markets unless an endpoint reference explicitly requires it.

Finally, we recommend storing all TikTok Shop metadata returned by Get Authorized Shops, because it does not change frequently. Also provide a way for customers to refresh their TikTok Shop data from your application or connector, because customers are most likely to know when their shop details have changed.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Integration%20Guides/manage_shops.png)
Text alternative for the diagram: the customer authorizes your app, TikTok Shop redirects to your callback URL with a one-time `code`, your backend exchanges that code for tokens, and your backend stores the token response against your local customer record. Later, your backend uses the stored `access_token` and `x-tts-access-token` header to call TikTok Shop Open APIs.
The call flow is:

1. Your customer authorizes your TikTok Shop App to access their TikTok Shop Seller data. If your app is published in the TikTok Shop App Store, the customer authorizes it by clicking the **Install** button. Otherwise, provide a Seller authorization link so the customer can sign in with their TikTok Shop Seller account and authorize your app.
2. After authorization, TikTok Shop calls your configured callback URL with URL parameters, including `code`. This `code` is a short-lived, one-time authorization code. Do not store it as a reusable credential.
3. Exchange the `code` for an access token and refresh token by calling the token endpoint from your backend:

```HTTP
GET https://auth.tiktok-shops.com/api/v2/token/get?app_key={app_key}&app_secret={app_secret}&auth_code={code}&grant_type=authorized_code
```

Required query parameters:
| Parameter | Required | Description |
| --- | --- | --- |
| `app_key` | Yes | The App Key generated for your TikTok Shop App. |
| `app_secret` | Yes | The App Secret generated for your TikTok Shop App. Keep it on the server side and never expose it in frontend code, logs, or screenshots. |
| `auth_code` | Yes | The `code` value returned to your callback URL after Seller authorization. |
| `grant_type` | Yes | Must be `authorized_code`. Do not use the standard OAuth spelling `authorization_code`. |
Example successful token response:
```JSON
{
  "code": 0,
  "message": "success",
  "data": {
    "access_token": "TTP_example_access_token",
    "access_token_expire_in": 1660556783,
    "refresh_token": "TTP_example_refresh_token",
    "refresh_token_expire_in": 1691487031,
    "open_id": "7010736057180325637",
    "seller_name": "Example Shop",
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

Token field quick reference:
| Field | Meaning | Store it? |
| --- | --- | --- |
| `access_token` | Bearer credential used to call TikTok Shop Open APIs. For 202309 and newer APIs, pass it in the `x-tts-access-token` header. | Yes. Store securely and encrypt at rest. |
| `access_token_expire_in` | Access token expiration time, expressed as Unix epoch seconds. | Yes. Use it to refresh before the access token expires. |
| `refresh_token` | Credential used to request a new access token. | Yes. Store securely and restrict access more tightly than ordinary shop metadata. |
| `refresh_token_expire_in` | Refresh token expiration time, expressed as Unix epoch seconds. | Yes. Use it to trigger reauthorization before or after refresh access expires. |
| `open_id` | Identifier of the authorizing user or authorization principal. | Recommended. Useful for diagnostics and audit trails. |
| `seller_name` | Seller name returned by the token API. | Recommended. Useful for display and support. |
| `seller_base_region` | Seller base region. | Recommended. Useful for routing and support. |
| `user_type` | Authorization principal type. `0` indicates a TikTok Shop Seller token. | Recommended. Validate that the token type matches the API you intend to call. |
| `granted_scopes` | API scopes granted during authorization. | Recommended. Use it to detect missing scopes before API calls fail. |
#### Connecting a single shop
Use this model if each local customer account can connect to only one TikTok Shop and you do not plan to support multiple TikTok Shops for the same customer.
In your local data store, `CustomerID` can be unique in the shop connection table because each customer maps to only one shop connection.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Integration%20Guides/single_connect.png)
Text alternative for the diagram: one local customer record maps to one TikTok Shop row. The row stores the customer identifier, token metadata, and the shop data returned by Get Authorized Shops.
#### Connecting multiple shops
Use this model if a customer can have more than one TikTok Shop associated with their TikTok Seller account, or if you may support this in the future.
In your local data store, `CustomerID` cannot be the unique key in the shop connection table because one customer may have multiple shop rows. Use a composite key such as `CustomerID + shop_cipher` or `CustomerID + shop_id`, depending on the identifiers required by your endpoints and internal data model.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Integration%20Guides/multi_connect.png)
Text alternative for the diagram: one local customer record maps to multiple TikTok Shop rows. Each row stores the same local customer identifier and a different TikTok Shop identifier, shop cipher, and shop metadata.
#### Single-shop and multiple-shop comparison
Both connection models use the same token exchange and Get Authorized Shops API. The key difference is how you model the local customer-to-shop relationship.
| Item | Single-shop model | Multiple-shop model |
| --- | --- | --- |
| Customer-to-shop relationship | One local customer maps to one TikTok Shop. | One local customer can map to multiple TikTok Shops. |
| `CustomerID` uniqueness | `CustomerID` can be unique in the shop connection table. | `CustomerID` cannot be unique by itself. |
| Suggested unique key | `CustomerID` | `CustomerID + shop_cipher` or `CustomerID + shop_id` |
| Get Authorized Shops response handling | Expect one shop object in `data.shops`. | Iterate all shop objects in `data.shops`. |
| Future flexibility | Simpler, but harder to expand later. | More flexible and recommended if multi-shop support is possible. |
To retrieve authorized shop data in either model:

* Retrieve the stored `access_token` for the local customer.
* Call [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309):

```HTTP
GET https://open-api.tiktokglobalshop.com/authorization/202309/shops?app_key={app_key}&timestamp={timestamp}&sign={sign}
Content-Type: application/json
x-tts-access-token: {access_token}
```

* Read the returned `data.shops` array. Each object represents a TikTok Shop authorized by the Seller token.
* Store the returned shop fields, especially identifiers such as `cipher`, `id`, `code`, `name`, `region`, and `seller_type`, against your local customer record.

Example response shape:
```JSON
{
  "code": 0,
  "data": {
    "shops": [
      {
        "cipher": "ROW_xkMbgAAAeVAQra0eZWebFQq5aIK",
        "code": "123456789",
        "id": "7495355150342452340",
        "name": "Example TikTok Shop",
        "region": "US",
        "seller_type": "LOCAL"
      }
    ]
  },
  "message": "Success",
  "request_id": "20230901000000000000000000000000"
}
```

#### Next steps
Once you have connected one or more TikTok Shops, implement an [authorization expiration webhook listener](https://partner.tiktokshop.com/docv2/page/reauthorize-shops) and add functionality to [disconnect a shop](https://partner.tiktokshop.com/docv2/page/disconnecting-shops). Use the reauthorization flow for authorization-expiration or deauthorization events so customers can reconnect their shop when access is still required.


---

## Use case guides > Shops > Reauthorize shops

Doc: https://partner.tiktokshop.com/docv2/page/reauthorize-shops · cập nhật 2026-07-06

### Notify sellers before authorization expires
Once you have [connected one or more TikTok Shops](https://partner.tiktokshop.com/docv2/page/connecting-shops), your client application or connector should remind sellers before their authorization expires and guide them through reauthorization so access to TikTok Shop Seller data can continue.
This guide focuses on **upcoming authorization expiration**. It assumes you already store token and shop connection data as described in [Connecting shops](https://partner.tiktokshop.com/docv2/page/connecting-shops).
#### Event scope
Do not treat upcoming authorization expiration and deauthorization as the same event.
| Event | Event type | Meaning | Developer action | Reference |
| --- | --- | --- | --- | --- |
| Upcoming authorization expiration | `UPCOMING_AUTHORIZATION_EXPIRATION` | The seller authorization is still active, but it will expire soon. TikTok Shop sends this event 30 days before expiration and then daily at 00:00 until reauthorization is completed. | Notify the seller and route them to reauthorize before access is lost. | [Upcoming authorization expiration](https://partner.tiktokshop.com/docv2/page/6509579c0fcef602bf11312c) |
| Seller deauthorization | `SELLER_DEAUTHORIZATION` | The seller has already deauthorized the app, or authorization is no longer valid. | Mark the connection inactive, stop using existing tokens for that shop, and ask the seller to connect again if access is still required. | [Seller deauthorization](https://partner.tiktokshop.com/docv2/page/65095746defece02be4d749d) |
#### Reminder strategy
Use the webhook as the primary signal, and keep a local fallback based on `refresh_token_expire_in` in case webhook delivery fails.
Recommended reminder timing:
| Time before expiration | Suggested action |
| --- | --- |
| 30 days | Start showing a low-friction in-app reminder. This aligns with the first `UPCOMING_AUTHORIZATION_EXPIRATION` webhook. |
| 14 days | Show a persistent banner or task in the seller-facing dashboard. |
| 7 days | Escalate the reminder through email, notification center, or your customer-success workflow. |
| 1 day | Show an urgent reminder and make reauthorization the primary action. |
| Expired or deauthorized | Stop calling seller-scoped APIs for that shop and route the seller through the authorization flow again. |
If your product has low-frequency seller logins, start external reminders earlier, such as 30 or 14 days before expiration. If the seller logs in daily, in-product reminders at 14 and 7 days may be enough.
#### Configure the webhook
You can configure shop webhooks in Partner Center or by API.
In Partner Center, open your app or service and go to the webhook or event subscription settings:
```Plain Text
Partner Center Console
  -> App & Service
  -> Select your app or service
  -> Webhooks / Event subscriptions
  -> Add or update UPCOMING_AUTHORIZATION_EXPIRATION
```

Console labels may vary by Partner Center version. The important part is that the webhook topic must be `UPCOMING_AUTHORIZATION_EXPIRATION` and the callback URL must be your HTTPS webhook listener.
To configure the same event programmatically, call **Update Shop Webhook**:
```HTTP
PUT https://open-api.tiktokglobalshop.com/event/202309/webhooks?app_key={app_key}&timestamp={timestamp}&sign={sign}&shop_cipher={shop_cipher}
Content-Type: application/json
x-tts-access-token: {access_token}

{
  "address": "https://example.com/tiktok-shop/webhooks",
  "event_type": "UPCOMING_AUTHORIZATION_EXPIRATION"
}
```

Use the exact endpoint reference for the latest required query parameters. For shop-scoped webhook configuration, include `shop_cipher` when the endpoint requires it.
#### Webhook payload
When your listener receives `UPCOMING_AUTHORIZATION_EXPIRATION`, validate the event type and map the payload to the local customer and shop connection.
Example payload:
```JSON
{
  "event_type": "UPCOMING_AUTHORIZATION_EXPIRATION",
  "shop_id": "7495355150342452340",
  "timestamp": 1696909648,
  "data": {
    "message": "Authorization for this TikTok Shop will expire soon.",
    "expiration_time": 1699501648
  }
}
```

Payload field quick reference:
| Field | Type | Meaning | Unit / format |
| --- | --- | --- | --- |
| `event_type` | string | Webhook topic. For this guide, the value is `UPCOMING_AUTHORIZATION_EXPIRATION`. | String enum |
| `shop_id` | string | TikTok Shop ID associated with the expiring authorization. Use this to find the local customer connection. | String |
| `timestamp` | integer | Time when the webhook event was generated. | Unix epoch seconds |
| `data` | object | Event-specific payload. | JSON object |
| `data.message` | string | Human-readable message describing the upcoming authorization expiration. | String |
| `data.expiration_time` | integer | Time when the seller authorization expires. | Unix epoch seconds |
Store the latest expiration reminder state against the local customer and shop connection. Do not treat `data.message` as the source of truth for business logic; use `data.expiration_time` and your stored token metadata.
#### Reauthorization flow
Reauthorization uses the same Seller authorization flow as the first connection. The seller must authorize your app again, your callback receives a new `code`, and your backend exchanges that code for a new `access_token` and `refresh_token`.
Use the Seller authorization entry that matches the seller region. You can find `service_id` in Partner Center:
```Plain Text
Partner Center Console
  -> App & Service
  -> Select your app or service
  -> Basic Information
  -> Service ID
```

| Seller region | Authorization entry |
| --- | --- |
| United States | `https://services.us.tiktokshop.com/open/authorize?service_id={service_id}&state={state}` |
| Non-US | `https://services.tiktokshop.com/open/authorize?service_id={service_id}&state={state}` |
Use the same authorization-link parameters as your first-time connection flow. The redirect URL is the callback URL configured for the app in Partner Center. `state` is strongly recommended so you can map the callback back to the local customer and shop connection; validate it before exchanging the returned `code` for new tokens.
The reauthorization flow is:

1. Receive `UPCOMING_AUTHORIZATION_EXPIRATION` or detect that `refresh_token_expire_in` is approaching.
2. Mark the shop connection as `reauthorization_required` or an equivalent internal status.
3. Show the seller a clear reauthorization action.
4. Send the seller through the same Seller authorization link used by [Connecting shops](https://partner.tiktokshop.com/docv2/page/connecting-shops).
5. Receive the callback `code`.
6. Exchange the `code` for new tokens through the token endpoint.
7. Replace the stored token values and clear the reminder state for that shop connection.

#### Listener behavior
Your webhook listener should be idempotent. TikTok Shop may send the upcoming-expiration notification repeatedly, so receiving the same reminder more than once should update the existing reminder state instead of creating duplicate customer tasks.
Recommended behavior:
| Situation | Action |
| --- | --- |
| `UPCOMING_AUTHORIZATION_EXPIRATION` received for a known shop | Update the expiration reminder state and show or refresh seller-facing reminders. |
| `UPCOMING_AUTHORIZATION_EXPIRATION` received for an unknown shop | Log the event with `shop_id` and `timestamp`, then investigate whether the shop mapping is missing or stale. |
| Seller completes reauthorization | Update stored tokens, refresh authorized shop data, and clear the reminder. |
| `SELLER_DEAUTHORIZATION` received | Mark the connection inactive and stop calling seller-scoped APIs for that shop until the seller connects again. |
#### Next steps
After you have implemented the upcoming authorization expiration listener, add functionality to [disconnect a shop](https://partner.tiktokshop.com/docv2/page/disconnecting-shops) and handle [seller deauthorization](https://partner.tiktokshop.com/docv2/page/65095746defece02be4d749d) as a separate lifecycle event.


---

## Use case guides > Shops > Disconnecting shops

Doc: https://partner.tiktokshop.com/docv2/page/disconnecting-shops · cập nhật 2026-07-06

### Shop connection lifecycle
A TikTok Shop connection is the relationship between a local customer account in your system and a TikTok Shop seller authorization. This guide covers the disconnect stage of the lifecycle.
Read it together with:

* [Connecting shops](https://partner.tiktokshop.com/docv2/page/connecting-shops)
* [Reauthorize shops](https://partner.tiktokshop.com/docv2/page/reauthorize-shops)
* [Seller deauthorization webhook](https://partner.tiktokshop.com/docv2/page/65095746defece02be4d749d)

Lifecycle overview:
```Plain Text
Connect shop -> Store tokens and shop identifiers -> Refresh or reauthorize before expiration -> Disconnect locally or handle TikTok-side deauthorization -> Reconnect if access is needed again
```

Use this page for two different scenarios:
| Scenario | Trigger source | Primary signal | What your system should do | Reconnect path |
| --- | --- | --- | --- | --- |
| Customer-requested disconnect | Your application or connector UI | Customer clicks a disconnect action in your product | Stop local access, delete or deactivate stored credentials, remove scheduled jobs, and clean up retained shop data according to your retention policy | Send the customer through the Seller authorization flow again |
| TikTok-side deauthorization | TikTok Shop authorization management | `SELLER_DEAUTHORIZATION` webhook | Mark the shop connection inactive, stop API calls for that shop, delete or deactivate stored credentials, and notify the customer if reconnection is needed | Send the customer through the Seller authorization flow again |
Do not treat these scenarios as the same event. A customer can disconnect a shop in your product without revoking the app authorization in TikTok Shop. A seller can also revoke authorization in TikTok Shop without clicking anything in your product.
### Important authorization boundary
The current OpenAPI reference does not list a public endpoint for a developer to revoke a seller's authorization or invalidate the seller's token on the platform side. The authorization APIs listed in the current reference include authorized-shop lookup and related authorization utilities, but not a revoke or unlink endpoint.
Therefore:

* Deleting `access_token` and `refresh_token` from your system is a local disconnect action. It prevents your application from continuing to use the connection.
* Local deletion does not necessarily remove the authorization record from TikTok Shop.
* If the customer wants to revoke the app authorization in TikTok Shop, direct them to the TikTok Shop authorization management area for their account.
* If TikTok Shop later provides a revoke or unlink endpoint, add that endpoint to this guide and call it before deleting local credentials.

### Customer-requested disconnect
In this use case, the customer asks to disconnect one or more TikTok Shops from your application or connector.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/Integration%20Guides/disconnect_shops.png)
Recommended flow:

1. Authenticate the customer and confirm which TikTok Shop connection should be disconnected.
2. Identify the local connection record by your customer identifier and the TikTok Shop identifier, such as `shop_id`, `shop_cipher`, or the composite key used by your data model.
3. Mark the connection as `disconnecting` or `inactive` so background jobs stop using it.
4. Stop scheduled sync jobs, webhook processing, retries, queue consumers, and API polling for that shop.
5. Delete or deactivate the stored `access_token`, `refresh_token`, token expiration timestamps, and token-derived secrets from secret storage, caches, logs, and job payloads.
6. Delete, anonymize, or retain customer and shop data according to your documented data retention policy and applicable law.
7. Show the customer that the shop is disconnected in your product.
8. If the customer wants to connect the shop again later, route them through the Seller authorization flow as a new authorization. Do not reuse old tokens.

### TikTok-side deauthorization
TikTok-side deauthorization happens when the seller revokes your app authorization in TikTok Shop or the authorization is no longer valid. Your system should listen for the `SELLER_DEAUTHORIZATION` webhook and treat it as the primary signal that access has ended.
When `SELLER_DEAUTHORIZATION` is received:

1. Validate the webhook request and event type.
2. Map the event to the local customer and shop connection using the identifiers in the payload, such as `shop_id` or the shop mapping you store locally. Refer to the [Seller deauthorization webhook](https://partner.tiktokshop.com/docv2/page/65095746defece02be4d749d) page for the exact payload.
3. Mark the connection as `deauthorized` or `inactive`.
4. Stop API calls, scheduled jobs, retries, and webhook-driven processing for that shop.
5. Delete or deactivate stored credentials and token-derived secrets.
6. Notify the customer that the TikTok Shop authorization was revoked and provide a reconnect action if access is still required.

Your listener should be idempotent. If the same deauthorization event is delivered more than once, update the same connection state instead of creating duplicate disconnect records.
### Configure the deauthorization webhook
You can configure the webhook in Partner Center or by API.
Partner Center path:
```Plain Text
Partner Center
  -> App & Service
  -> Select your app or service
  -> Webhooks / Event subscriptions
  -> Add or update SELLER_DEAUTHORIZATION
```

Console labels may vary by Partner Center version. The important part is that the event topic is `SELLER_DEAUTHORIZATION` and the callback URL is your HTTPS webhook listener.
API configuration uses **Update Shop Webhook**:
```HTTP
PUT https://open-api.tiktokglobalshop.com/event/202309/webhooks?app_key={app_key}&timestamp={timestamp}&sign={sign}&shop_cipher={shop_cipher}
Content-Type: application/json
x-tts-access-token: {access_token}
```

```JSON
{
  "address": "https://example.com/tiktok-shop/webhooks",
  "event_type": "SELLER_DEAUTHORIZATION"
}
```

Notes:

* `address` is the HTTPS endpoint that receives the webhook event.
* `event_type` must be `SELLER_DEAUTHORIZATION`.
* `x-tts-access-token` is required by the webhook configuration API.
* `shop_cipher` is optional in the OpenAPI schema, but cross-border shops may require the correct value to avoid incorrect responses. Follow the endpoint reference for the shop and market you are configuring.
* Use [Get Shop Webhooks](https://partner.tiktokshop.com/docv2/page/get-shop-webhooks) to verify existing webhook configuration.
* Use `DELETE /event/202309/webhooks` only if you intentionally want to remove a webhook event subscription. Do not delete the deauthorization webhook as part of ordinary shop disconnect logic unless you no longer need to receive the event for that shop.

### Data cleanup checklist
Clean up data based on the scenario and the legal basis for retaining it.
| Data item | Customer-requested disconnect | TikTok-side deauthorization | Recommended handling |
| --- | --- | --- | --- |
| `access_token` | Delete or deactivate immediately | Delete or deactivate immediately | Remove from secret stores, caches, queues, and retry payloads. |
| `refresh_token` | Delete or deactivate immediately | Delete or deactivate immediately | Treat as highly sensitive. Do not keep it after access is no longer required. |
| Token expiration timestamps | Delete or retain only as audit metadata | Delete or retain only as audit metadata | Keep only if needed for compliance, fraud prevention, or support audit. |
| `shop_id` | Delete, anonymize, or keep minimal audit record | Delete, anonymize, or keep minimal audit record | If retained, do not use it for API calls after disconnect. |
| `shop_cipher` | Delete or deactivate with the connection | Delete or deactivate with the connection | Required for many shop-scoped calls; keeping it active after disconnect creates avoidable risk. |
| Shop metadata, such as shop name, region, and seller type | Delete or anonymize when no longer needed | Delete or anonymize when no longer needed | Retain only what is required for invoices, support, audit, or legal obligations. |
| API-derived customer data | Delete or anonymize according to your data retention policy | Delete or anonymize according to your data retention policy | Remove product, order, fulfillment, finance, or customer-service data when there is no valid business or legal need to retain it. |
| Scheduled jobs and queues | Stop and purge pending work for the disconnected shop | Stop and purge pending work for the deauthorized shop | Prevent retries from using stale credentials. |
| Webhook state | Keep the shared listener, but ignore or reject events for inactive shops | Keep deauthorization handling active | Webhook endpoint configuration may be shared across shops; do not remove shared infrastructure accidentally. |
### Data retention and deletion timing
At minimum, deactivate local API access immediately after disconnect or deauthorization so your system stops using the credentials.
For stored customer data:

* Follow your published privacy policy, seller agreement, applicable law, and TikTok Shop platform requirements.
* For GDPR-covered personal data, apply data minimization and erasure obligations where applicable. See the European Commission's [data protection overview](https://commission.europa.eu/law/law-topic/data-protection_en).
* Define an internal deletion SLA before launch. A practical default is to delete or anonymize data that is no longer needed within 30 days after disconnect, unless a shorter period is required by law, platform policy, or your agreement with the customer.
* If you must retain limited records for tax, invoicing, fraud prevention, security, or legal defense, retain only the minimum fields needed and block them from operational API use.

### Reconnect after disconnect
If the customer wants to reconnect the shop, use the same Seller authorization flow as a first-time connection:

1. Send the customer to the appropriate Seller authorization entry point.
2. Receive a new authorization `code` at your callback URL.
3. Exchange the `code` for a new `access_token` and `refresh_token`.
4. Call [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309) to refresh shop identifiers, including `shop_id` and `shop_cipher`.
5. Store the new token response, `granted_scopes`, and shop metadata against the local customer connection.
6. Restart only the jobs and integrations that the customer has enabled.

Never reactivate a disconnected connection by reusing old tokens.
### Recommended documentation structure
For lower cross-page jumping, the shop connection docs can be organized as one lifecycle guide:
| Chapter | What it should cover |
| --- | --- |
| Connect | Seller authorization link, callback `code`, token exchange, Get Authorized Shops, single-shop and multi-shop data model. |
| Maintain | Access-token refresh, refresh-token expiration, `UPCOMING_AUTHORIZATION_EXPIRATION` webhook, and reauthorization UX. |
| Disconnect | Customer-requested disconnect, TikTok-side deauthorization, local credential deletion, data retention, and reconnect path. |
Until the lifecycle guide is consolidated, keep cross-links between the three pages so developers can move from connect to reauthorize to disconnect without guessing which page owns each state transition.


---

## Use case guides > Product categories > Store product categories

Doc: https://partner.tiktokshop.com/docv2/page/store-product-categories · cập nhật 2026-07-06

### Get and store product categories
A core scenario for TikTok Shop API developers is to synchronize product data in their own system with product data in TikTok Shop. Product category data is one of the reference datasets required before you can create, edit, or map products.
This guide explains how to retrieve TikTok Shop product categories, store a local category cache, and keep that cache up to date.
Use this page for the category dictionary only. For category recommendation or migration, see the document boundary section below.
### API to use
Use **Get Categories**:
```HTTP
GET https://open-api.tiktokglobalshop.com/product/202309/categories
Content-Type: application/json
x-tts-access-token: {access_token}
```

Reference: [Get Categories](https://partner.tiktokshop.com/docv2/page/get-categories-202309)
This API does not use a request body, but it does support query parameters. Choose parameter values based on the seller, shop, region, category tree version, locale, and listing platform you are preparing for.
| Parameter | Location | Required | Description |
| --- | --- | --- | --- |
| `locale` | Query | No | BCP-47 locale used to display category names. If omitted, the shop's default locale is used. Examples include `en-US`, `en-GB`, `id-ID`, `th-TH`, `vi-VN`, and `zh-CN`. |
| `keyword` | Query | No | Filters categories by keyword in `local_name`. Useful for search UI or admin tools. |
| `category_version` | Query | No, but important | Category tree version. For US shops, pass `v2`, which represents the 7-level category tree. For other regions, `v1` represents the 3-level category tree and is the default. |
| `listing_platform` | Query | No | Platform filter. Possible values include `TIKTOK_SHOP` and `TOKOPEDIA`. Applicable only to sellers migrated from Tokopedia. |
| `include_prohibited_categories` | Query | No | Whether to include prohibited categories. Use this to identify categories that cannot be listed on TikTok Shop. Applicable only for BR, MX, EU, and SEA markets. |
| `shop_cipher` | Query | No in schema; context-dependent | Shop identifier used by shop-scoped calls. Cross-border shops may require the correct value to avoid incorrect responses. |
| `x-tts-access-token` | Header | Yes | Seller access token for the shop whose available categories and permissions you want to check. |
| `Content-Type` | Header | Yes | Use `application/json`. |
Example:
```HTTP
GET https://open-api.tiktokglobalshop.com/product/202309/categories?category_version=v2&locale=en-US&shop_cipher={shop_cipher}
Content-Type: application/json
x-tts-access-token: {access_token}
```

### Category version guidance
Category trees can differ by region and platform.
| Case | Recommended request |
| --- | --- |
| US shop | Pass `category_version=v2`. This is the 7-level category tree. |
| Non-US shop | Use `category_version=v1` unless the endpoint reference or migration guide says otherwise. |
| Seller migrated from Tokopedia | Retrieve categories with `listing_platform=TIKTOK_SHOP` and, where needed, `listing_platform=TOKOPEDIA`, then identify the overlap before listing on both platforms. |
| Category migration from old tree to new tree | Do not solve this with the category cache alone. Use the L7 category migration guide and the related category upgrade APIs. |
For live products that need to be upgraded from a 3-level to a 7-level category tree, refer to [Create Category Upgrade Task](https://partner.tiktokshop.com/docv2/page/create-category-upgrade-task-202407).
### Response fields and local field names
The **Get Categories** response returns category objects under `data.categories`.
The raw API response field for the category ID is `id`. Downstream product APIs and many integration guides refer to the same value as `category_id`. To avoid confusion, use this mapping consistently:
| API response field | Recommended local field | Type | Description |
| --- | --- | --- | --- |
| `id` | `category_id` | string | The TikTok Shop category ID. Store this value as `category_id` locally and pass it as `category_id` to downstream product APIs. |
| `parent_id` | `parent_category_id` | string | The parent category ID. For a root category, the parent ID is `0`. |
| `local_name` | `local_name` | string | Category name in the locale returned by the API. |
| `is_leaf` | `is_leaf` | boolean | Whether the category is a leaf category. You can only create or edit products under a leaf category. |
| `permission_statuses` | `permission_statuses` | string array | Seller permission status for this category. Treat it as seller-specific and refresh it before product creation. |
Example response shape:
```JSON
{
  "code": 0,
  "data": {
    "categories": [
      {
        "id": "600002",
        "parent_id": "0",
        "local_name": "Home Supplies",
        "is_leaf": false,
        "permission_statuses": [
          "AVAILABLE"
        ]
      }
    ]
  },
  "message": "Success",
  "request_id": "20230901000000000000000000000000"
}
```

### What to store locally
Product categories are updated frequently. A local cache is still useful for search, mapping UI, and reducing repeated reads, but do not rely on a one-time download forever. Refresh the cache regularly and validate the selected category before creating or editing a product.
Recommended local schema:
| Local field | Source | Why store it |
| --- | --- | --- |
| `category_id` | `id` | Primary TikTok Shop category identifier. |
| `parent_category_id` | `parent_id` | Rebuild the category tree and breadcrumb path. |
| `local_name` | `local_name` | Display category names to sellers. |
| `is_leaf` | `is_leaf` | Filter selectable categories. Only leaf categories can be used for product creation or editing. |
| `permission_statuses` | `permission_statuses` | Filter or warn sellers about categories they cannot use. Refresh before final product submission. |
| `category_version` | Request parameter | Prevent mixing `v1` and `v2` category trees. |
| `locale` | Request parameter or shop default | Prevent mixing category names across locales. |
| `listing_platform` | Request parameter | Separate TikTok Shop and Tokopedia category availability when applicable. |
| `shop_context` | Token or shop mapping | Permissions are seller-specific, so cache per shop or per permission context when needed. |
| `status` | Local state | Mark categories as `active`, `inactive`, or `removed` after diffing. |
| `last_seen_at` | Local timestamp | Track when the category last appeared in the API response. |
| `last_checked_at` | Local timestamp | Track when the category was last refreshed. |
### Permission statuses
`permission_statuses` tells you whether the seller can use a category. It is not just metadata; it affects whether product creation will succeed.
| Status | Meaning | Developer action |
| --- | --- | --- |
| `AVAILABLE` | The seller has permission to create products in this category. | Allow selection, then still check category rules and required attributes before product creation. |
| `INVITE_ONLY` | Restricted category. The seller does not currently have permission. In Seller Center, this is also known as restricted. | Do not allow product listing until the seller obtains access through Qualification Center. |
| `NON_MAIN_CATEGORY` | Category is outside the shop's scope. | Do not allow listing. Ask the seller to contact their account manager if they believe this is incorrect. |
| `PROHIBITED` | Category is prohibited on TikTok Shop. | Do not list products in this category. Product audit will reject it. |
You may store `permission_statuses` to power your UI, but always refresh the relevant category and permission status before final submission. After selecting a leaf category, call the related product setup APIs such as [Get Category Rules](https://partner.tiktokshop.com/docv2/page/get-category-rules-202309) and [Get Attributes](https://partner.tiktokshop.com/docv2/page/get-attributes-202309) before building the Create Product request.
### Initial retrieval flow
Use an initial retrieval to populate your local category cache.

1. Get the seller access token and shop context that match the shop you are preparing for.
2. Decide the `category_version`, `locale`, `listing_platform`, and `shop_cipher` values.
3. Call **Get Categories**.
4. Normalize each category object by mapping `id` to local `category_id`.
5. Store the category record with the request context, especially `category_version`, `locale`, `listing_platform`, and shop context.
6. Mark returned categories as `active` and set `last_seen_at` and `last_checked_at`.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/677d797e7f1545c084030ff6501f72c3~tplv-k9wyc2ijk0-image.image)

### Refresh and diff logic
Run a scheduled refresh job and also refresh on demand before product creation if the local cache is stale.
Diff by this key:
```Plain Text
shop_context + listing_platform + category_version + locale + category_id
```

Recommended diff behavior:
| Diff result | How to detect it | What to do |
| --- | --- | --- |
| New category | Remote `id` is not in local cache for the same context. | Insert it as `active`, show it in mapping tools if `is_leaf=true`, and set `last_seen_at`. |
| Updated category | Remote and local category IDs match, but fields changed. | Update changed fields such as `parent_id`, `local_name`, `is_leaf`, or `permission_statuses`. If a leaf category becomes non-leaf or unavailable, block it for new product creation. |
| Removed or unavailable category | Local category is not returned by the latest API response for the same context. | Mark it `inactive` or `removed` instead of hard deleting. Hide it from new mapping and product creation. Keep the record if historical products or mappings reference it. |
| Permission changed | `permission_statuses` changed for an existing category. | Update the status, refresh seller-facing warnings, and block product creation if the category is no longer `AVAILABLE`. |
| Version mismatch | A stored mapping uses `v1`, but the shop now requires `v2`. | Do not reuse the old category ID blindly. Route the product through the L7 migration or category-mapping process. |
Pseudo-code:
```Plain Text
remote = get_categories(context)
remote_by_id = index(remote.categories, category.id)
local_by_id = load_cached_categories(context)

for each remote_category in remote_by_id:
  local = local_by_id[remote_category.id]
  if local does not exist:
    insert category with status = active
  else if any tracked field changed:
    update local category fields
    set status = active
  set last_seen_at = now

for each local_category in local_by_id:
  if local_category.category_id not in remote_by_id:
    mark status = inactive or removed
    hide from new product creation
```

### Mapping guidance
TikTok Shop categories are hierarchical, but most external systems do not use the same hierarchy. Do not try to force your category tree to match TikTok Shop's tree exactly. Instead:

* store the TikTok Shop category tree as a reference dictionary;
* let sellers choose a TikTok Shop leaf category, or use category recommendation;
* map your local category or product to the TikTok Shop `category_id`;
* store mappings separately from the category dictionary.

Only leaf categories can be used to create or edit products. If a selected category has `is_leaf=false`, ask the seller to choose a leaf category under it.
### Document boundaries
Use these pages together, but keep their responsibilities separate:
| Page | Owns | Does not own |
| --- | --- | --- |
| Store product categories | Retrieve, cache, normalize, and refresh TikTok Shop category dictionaries from **Get Categories**. | Choosing the best category for a specific product or migrating old category IDs. |
| [Map product categories](https://partner.tiktokshop.com/docv2/page/map-product-categories) | Map local categories or products to TikTok Shop leaf categories, manually or with category recommendation. | Maintaining the full category cache. |
| L7 category migration guide | Move existing products or mappings from the 3-level category tree to the 7-level category tree. | General category dictionary caching. |
| [Get Categories](https://partner.tiktokshop.com/docv2/page/get-categories-202309) | Exact endpoint, parameters, response schema, and current API behavior. | End-to-end product mapping workflow. |
### Next steps
After the category cache is available:

1. Use [Recommend Category](https://partner.tiktokshop.com/docv2/page/recommend-category-202309) or your own UI to map each local product or local category to a TikTok Shop leaf `category_id`.
2. Before creating or editing a product, confirm that the selected category is still a leaf category and that `permission_statuses` allows the seller to use it.
3. Call [Get Category Rules](https://partner.tiktokshop.com/docv2/page/get-category-rules-202309) and [Get Attributes](https://partner.tiktokshop.com/docv2/page/get-attributes-202309) to build the final Create Product or Edit Product request.

###


---

## Use case guides > Product categories > Map product categories

Doc: https://partner.tiktokshop.com/docv2/page/map-product-categories · cập nhật 2026-07-06

### Map product categories to TikTok Shop product categories
A core scenario for TikTok Shop API developers is helping sellers choose a valid TikTok Shop product category when creating or updating a product.
When a seller lists a product on TikTok Shop, the create or edit product request must include a TikTok Shop category. Before implementing category mapping, first [retrieve and store TikTok Shop product categories locally](https://partner.tiktokshop.com/docv2/page/store-product-categories) so you can validate recommended category IDs and display category names in your own UI.
#### Implementation scope
This guide covers category recommendation for local TikTok Shop product categories. If you are working with global products or Global Selling full-service products, check the endpoint reference for the corresponding global category APIs before reusing this flow.
The examples use Node.js terminology such as `fetch`, `Blob`, and `crypto.randomUUID()` only to illustrate one possible implementation. The API contract is language independent:

* Upload image files with `multipart/form-data`.
* Send the category recommendation request as JSON.
* Use the returned TikTok Shop image `uri`, not your original image URL, in the category recommendation request.

#### API quick reference
Use `https://open-api.tiktokglobalshop.com` as the Open API domain for the endpoints below.
| API name | Method and path | Content type | Required inputs in this flow | Key response fields | Reference |
| --- | --- | --- | --- | --- | --- |
| Upload Product Image | `POST /product/202309/images/upload` | `multipart/form-data` | `data` file part, `use_case` such as `MAIN_IMAGE` | `data.uri`, `data.url`, `data.width`, `data.height`, `data.use_case` | [Upload Product Image](https://partner.tiktokshop.com/docv2/page/upload-product-image-202309) |
| Recommend Category | `POST /product/202309/categories/recommend` | `application/json` | `product_title`, `images[].uri`; `category_version` when required by region | `data.leaf_category_id`, `data.categories` | [Recommend Category](https://partner.tiktokshop.com/docv2/page/recommend-category-202309) |
Common request headers and query parameters:
| Name | Location | Notes |
| --- | --- | --- |
| `x-tts-access-token` | Header | Seller access token. Use the seller token for seller-specific mapping. |
| `Content-Type` | Header | `multipart/form-data` for image upload, `application/json` for category recommendation. |
| `shop_cipher` | Query | Include when the endpoint or shop model requires a shop-scoped identifier. |
| `app_key`, `timestamp`, `sign` | Query | Standard Open API query parameters. Sign the exact request path and query parameters. |
For Recommend Category, use the exact request field names from the API reference:
```JSON
{
  "product_title": "Example running shoes",
  "images": [
    {
      "uri": "tos-maliva-i-o3syd03w52-us/example-image"
    }
  ],
  "category_version": "v2"
}
```

`category_version` is region-dependent. For US shops, pass `v2` when using the 7-level category tree. For other regions, follow the endpoint reference and your stored category tree version.
#### Local schema quick reference
Your database does not need to match these table names exactly. The important point is to keep local product data, local image data, TikTok Shop image data, and category mapping data linked with stable identifiers.
| Data object | Minimal fields | Purpose |
| --- | --- | --- |
| Product | `product_id`, `product_title`, `local_category_id`, `image_id` | Source product data from your system. |
| Product image mapping | `image_id`, `local_image_id`, `tiktok_shop_image_id` | Links a product image in your system to the uploaded TikTok Shop image. |
| Local image | `local_image_id`, `local_image_url` or storage pointer | Locates the image bytes in your storage system. |
| TikTok Shop image | `tiktok_shop_image_id`, `uri`, `url`, `width`, `height`, `use_case` | Stores the result of Upload Product Image. Use `uri` for API requests and `url` for display or HTML descriptions. |
| Category mapping | `local_category_id`, `leaf_category_id`, `category_version`, `mapping_status`, `updated_at` | Maps your local category to a TikTok Shop leaf category. |
Recommended `mapping_status` values:
| Status | Meaning |
| --- | --- |
| `recommended` | TikTok Shop returned a recommendation, but the seller or your business logic has not accepted it yet. |
| `confirmed` | The recommendation was accepted automatically or approved by a user. |
| `rejected` | The user rejected the recommendation and should choose a different category. |
| `needs_review` | The recommendation could not be validated against your stored category table or needs manual review. |
#### Category mapping flow
Use this flow for both automated and seller-confirmed mapping. The only difference is whether your system accepts the recommendation automatically or asks the seller to confirm it.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/95b854a54bf644b1b4730989c783e7d4~tplv-k9wyc2ijk0-image.image)

Text alternative for the diagram: retrieve product and image metadata, upload the image to TikTok Shop, call Recommend Category with the product title and uploaded image URI, validate the returned leaf category, then either save the mapping automatically or show the recommendation to the seller for confirmation.

1. Retrieve product metadata from your local product record: `product_id`, `product_title`, `local_category_id`, and one or more image references.
2. Retrieve the image bytes from your local storage. If the image is stored in S3, Azure Blob Storage, local disk, or another file service, use that platform's SDK or HTTP client to obtain the file bytes.
3. Upload the image to TikTok Shop by calling [Upload Product Image](https://partner.tiktokshop.com/docv2/page/upload-product-image-202309) with `multipart/form-data`.
4. Store the uploaded image metadata returned by TikTok Shop, especially `data.uri` and `data.url`. Link it back to your local image record.
5. Call [Recommend Category](https://partner.tiktokshop.com/docv2/page/recommend-category-202309) with `product_title` and `images[].uri`. Use the `uri` returned by the upload response in step 3, not the local image URL.
6. Validate `data.leaf_category_id` against your locally stored TikTok Shop category table. If it is missing or belongs to a different category tree version, mark the mapping as `needs_review` and refresh your local category table.

#### Automated mapping branch
Use automated mapping when you trust the recommendation enough to save it without seller confirmation, such as bulk migration or internal pre-mapping.
After step 6 in the main flow:

1. Save `data.leaf_category_id` to your category mapping table.
2. Set `mapping_status` to `confirmed`.
3. Continue with product creation or update only after the category is confirmed and still valid for the seller and category tree version.

For bulk catalog mapping, repeat the main flow for each product. Reuse an appropriate seller access token or test seller token according to your authorization model, and follow rate-limit guidance.
#### Seller-confirmed mapping branch
Use seller-confirmed mapping when the seller is creating or editing a product in your UI and should approve the category before you save it.
After step 6 in the main flow:

1. Display the recommended category path to the seller. Use your locally stored category table to show readable names for the returned `leaf_category_id`.
2. Let the seller accept the recommendation or choose a different TikTok Shop leaf category.
3. If the seller accepts the recommendation, save `data.leaf_category_id` and set `mapping_status` to `confirmed`.
4. If the seller chooses a different category, save the seller-selected leaf category and record that it was manually selected.

#### Multipart upload notes
The image upload step is not specific to Node.js. Equivalent implementations in other languages should send:
| Form field | Type | Description |
| --- | --- | --- |
| `data` | file | Local image file bytes. Supported formats include JPG, JPEG, PNG, WEBP, HEIC, and BMP. Follow the endpoint reference for size and dimension limits. |
| `use_case` | string | Image usage scenario. For category recommendation based on a product gallery image, use `MAIN_IMAGE` unless another use case is more appropriate. |
The upload response includes both `uri` and `url`. Use them differently:
| Field | Use |
| --- | --- |
| `data.uri` | API identifier for later TikTok Shop API requests, including `images[].uri` in Recommend Category and product create/edit payloads. |
| `data.url` | CDN URL for display or for embedding in product descriptions when allowed by the endpoint. |
#### Common pitfalls
| Pitfall | Fix |
| --- | --- |
| Passing `product title`, `name`, or `title` instead of `product_title` | Use the API field name `product_title`. |
| Passing a local image URL to Recommend Category | Upload the image first and pass the returned TikTok Shop `uri` in `images[].uri`. |
| Saving the recommendation without checking the category table | Validate `data.leaf_category_id` against the local category table and category version. |
| Confusing `url` and `uri` | Use `uri` for API payloads. Use `url` for display. |
| Applying one recommendation to all sellers | Category availability and version can vary by seller, region, and permission. Validate before product creation. |
#### Next steps
After a category mapping is confirmed, use the selected `leaf_category_id` when creating, checking, or editing a TikTok Shop product. For category list synchronization, see [Store product categories](https://partner.tiktokshop.com/docv2/page/store-product-categories).

###


---

## Use case guides > Product categories > Explanation of the impact of CA65 attributes on California sales eligibility

Doc: https://partner.tiktokshop.com/docv2/page/zj95mjex · cập nhật 2026-06-26

##### 1.Summary
CA65-related attributes will permanently remain optional on the API side. However, if these attributes are not provided, the product will not be eligible for sale in California. Consumers in California will see the message “This item cannot be delivered to your region.”
##### 2. Impacted Fields
The following core attribute fields are related to California sale eligibility:
| Attribute Name | Attribute ID | Attribute Value | Attribute Value ID |
| --- | --- | --- | --- |
| CA Prop 65: Carcinogens | 101400 | Yes | 1000058 |
|  |  | No | 1000059 |
| CA Prop 65: Repro. Chems | 101395 | Yes | 1000058 |
|  |  | No | 1000059 |
| Carcinogen (Cascading Field) | 101397 | Specific chemical substance enum values (multi-select) | - |
**Note**: `Carcinogen` is a cascading field. It is triggered only when `CA Prop 65: Carcinogens` is set to `Yes`.
##### 3. API Behavior
At the API integration level, the system will return warning messages in the following ways:

* [preCheck API](https://partner.tiktokshop.com/docv2/page/check-product-listing-202309): If CA65 attributes are missing, a warning will be returned in `pre_check_results`.

```JSON
{
  "pre_check_item": "CA65_COMPLIANCE_MISSING",
  "pre_check_details": [
    {
      "short_reason": "Missing CA65 Compliance Information",
      "long_reason": "This product is missing required CA65 compliance information and will be restricted from selling in California. Please complete the required CA65 attributes in the Compliance section.",
      "related_fields": [
        "PRE_CHECK_FIELD_CA65_COMPLIANCE"
      ]
    }
  ]
}
```

* [Create Product API](https://partner.tiktokshop.com/docv2/page/create-product-202309): If CA65 attributes are not included when creating a product, a warning will be returned in `warnings`.

```JSON
"warnings": [
  {
    "message": "The CA65 compliance information is missing. This product will be restricted from selling in California. Please complete the required CA65 attributes in the Compliance section."
  }
]
```

**Important**: Missing CA65 attributes will not block product publication. The product can still be published successfully, but its sale eligibility in California will be restricted.
##### 4. Recommended Integration Approach
To help merchants maintain California sale eligibility and avoid unnecessary sales coverage restrictions, APP / ISV developers are advised to guide merchants to complete CA65-related attributes during the product creation or editing flow.


---

## Use case guides > Analytics > SPS API Merchant Performance Diagnosis: ISV Integration Use Cases

Doc: https://partner.tiktokshop.com/docv2/page/ph0ccose · cập nhật 2026-08-26

An ISV-developed App can use five read-only SPS APIs to build an end-to-end journey: overview, prioritization, diagnosis, object-level drill-down, action, and review. The App frontend first displays the merchant’s SPS, dimensions, peer ranking, and benefits; then prioritizes `Top Opportunity` metrics for diagnosis, identifies affected products, orders, logistics providers, or conversations, and converts recommendations into executable tasks. The SPS API does not modify products, orders, or customer service settings. Actions must either deep-link to TikTok Shop Seller Center or be handled by the App’s own capabilities.

1. View the SPS overview and benefit gaps;

This solution covers six user cases:

2. Identify priority improvement metrics and complete metric diagnosis;
3. Reduce product-satisfaction issues (NRR/NBFR);
4. Stabilize fulfillment and logistics performance (SFCR/OTDR);
5. Improve customer service and aftersales efficiency (IM_DSAT/AHT);
6. Build an action plan, monitor by cycle, and review results continuously.

Implementation must treat API-returned `status`, `benefits.is_unlocked`, `benchmarks`, `top_reason_text`, and `update_time` as the source of truth. Do not hard-code tier thresholds or benefit requirements in the client. Displayed scores are rounded, and some benefits have additional eligibility requirements; do not predict benefit unlocks using `sps_score >= unlock_score`.

### Solution Scope
##### Target Users and Systems
| Item | Definition |
| --- | --- |
| Target merchants | TikTok Shop merchants who have authorized the App and meet or are close to the SPS eligibility threshold |
| App users | Store owners, product operations specialists, fulfillment operations specialists, customer service leads, and aftersales leads |
| App systems | App frontend, analytics module, task and notification module, OAuth token service, and App backend (BFF/API gateway) |
| TikTok Shop systems | Open API and Seller Center |
| Expected outcome | ISVs can use this document directly to design App pages, orchestrate API calls, map App frontend fields, configure Actions, and define acceptance criteria. |
> **Terminology:** In this document, **App** means an ISV-developed application used by merchants; **App frontend** means the pages merchants interact with directly; and **App backend (BFF)** means the backend service that calls the SPS API for the App frontend, handles authentication, and normalizes data.

##### In Scope
**Included:**

* Overall SPS score, tier, peer ranking, primary category, dimension scores, and benefits;
* Status, score, value, benchmarks, trend, calculation details, and diagnosis conclusions for all six metrics;
* Drill-down by product, order, logistics provider, aftersales type, and conversation;
* Recommended Actions, Seller Center deep links, and App-owned action plans;
* `NIL`, no data, partial data, pagination, and expired authorization.

**Excluded:**

* Modifying products, inventory, logistics, or customer service settings through the SPS API;
* Submitting an appeal through the SPS API;
* Calculating or predicting the official SPS within the App;
* Production rollout outside the United States. The five endpoints currently specified support US shops only.

##### SPS Rules at a Glance

* SPS is a dynamic score from 0 to 5. Merchants generally become eligible after receiving at least 30 delivered orders in the previous 90 days. Risk-controlled orders, sample orders, gift orders, and certain other orders may be excluded.
* SPS uses the highest-selling category from the previous 90 days as the primary category and evaluates the shop against benchmarks for peer merchants in that category.
* Recent orders carry more weight. Current official guidance states that the weight decays by `0.7` every 15 days.
* **Scope of** **`NIL`:** Once a shop has received an overall SPS, the overall score is normally not `NIL`. However, each of the six SPS metrics is evaluated independently. If a metric does not meet its scoring eligibility conditions, it may return `status=NIL` with no valid score even while the overall SPS and other metrics are available. The App must continue to show the overall SPS and other scored metrics, render only the affected metric as “Insufficient data,” and must not treat it as 0 or turn the entire SPS page into an empty state. The platform redistributes that metric’s weight across other scored metrics according to its rules.
* Merchants should prioritize metrics marked `Top Opportunity`, but the App must not derive that label independently.
* Low-volume protection, excluded orders, and score adjustments are calculated by the platform. The App should explain the returned results rather than recreate the scoring algorithm.

##### Six Metrics and Data Capabilities
| Dimension | `metric_code` | Metric | Direction | Current official evaluation period | Top Items | Problem Details |
| --- | --- | --- | --- | --- | --- | --- |
| Product Satisfaction | `NRR` | Negative Review Rate | Lower is better | 60 days | Products | Orders with negative reviews |
| Product Satisfaction | `NBFR` | Non-Buyer Fault Return & Refund Rate | Lower is better | 60 days | Products | Return and refund orders |
| Fulfillment and Logistics | `SFCR` | Seller Fault Cancellation Rate | Lower is better | 30 days | Not supported | Canceled orders |
| Fulfillment and Logistics | `OTDR` | On-Time Delivery Rate | Higher is better | 30 days | Logistics providers | Orders not delivered on time |
| Customer Service | `IM_DSAT` | IM Dissatisfaction Rate | Lower is better | 60 days | Not supported | Low-satisfaction conversations |
| Customer Service | `AHT` | After-Sales Handling Time | Lower is better | 60 days | Aftersales types and products | Aftersales orders |
> Display the API value of `evaluate_duration_days` as the source of truth for the evaluation period. The table above is only a reference for the current official rules.

### Integration Architecture and Shared API-Calling Strategy
##### System Architecture

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/1c17e20663974853aed9bddccbd3d7c9~tplv-k9wyc2ijk0-image.image)

##### Page-Level Calling Strategy

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/7954f1895aac431a9177e20ba05f10d5~tplv-k9wyc2ijk0-image.image)

##### API-Calling Principles

1. **Fetch Overview first, then fetch Metrics based on the result.** When Overview returns a valid overall SPS, load Metrics. If an individual `metrics[].status=NIL`, keep the overall SPS and other scored metrics visible, and show “Insufficient data” only for that metric; diagnosis and drill-down availability must follow the corresponding API response. Show an overview-level empty state only when the shop has not yet met overall SPS eligibility or Overview is unavailable. Lazy-load Diagnosis, Top Items, and Problem Details when the merchant opens them.
2. **Use** **`update_time` to indicate data freshness.** Show “Data updated at…” on the page. If `update_time` remains unchanged after a refresh, do not imply that the score has been recalculated.
3. **Interpret results using API status fields.** Prefer `status` and `status_text`; do not reclassify a metric solely by comparing `value` with thresholds.
4. **Route by endpoint capability.**`top_items` does not support `SFCR` or `IM_DSAT`; use `problem_details` directly for these two metrics.
5. **Pass locale through for internationalization.** Include `locale` in requests and prioritize localized names and descriptions returned by the API. Use only `metric_code`, `status`, and `sps_tier` as business-logic keys—not localized labels.
6. **Handle unknown metrics gracefully.** This document lists six metrics, while field descriptions use “possible values include.” Unknown `metric_code` values must be displayed safely or ignored without causing the page to fail.

### User Case 01: View SPS Overview and Benefits Gap
##### Scenario Overview
The store owner wants to view SPS directly in the App frontend used for daily operations, without switching to Seller Center. They need to quickly understand the store’s current performance, the dimension that most needs improvement, its position relative to peer sellers, and which business benefits are unlocked or close to being unlocked.
**Trigger conditions:** The merchant has completed authorization and the store is a US shop.
**Primary role:** Store owner.
**Successful outcome:** The merchant confirms the current SPS status within 30 seconds and opens the highest-priority issue for diagnosis.
##### Merchant Flow
The diagram below presents the complete merchant journey as “flow step — purpose and key interaction — App UI demo.” If the shop has an overall SPS but an individual `metrics[].status=NIL`, the App frontend must keep the SPS Overview, other scored metrics, and benefit information visible, and show “Insufficient data” with the current evaluation period only on the affected metric card. It must not turn the entire page into an empty state.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/cf7118e89b4b42749682348c75aca0ba~tplv-k9wyc2ijk0-image.image)

##### API Call Flow

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/2e9a375078c64e1985775a4a7c126c33~tplv-k9wyc2ijk0-image.image)

##### Page-to-Field Mapping
| Page area | API fields | Interaction |
| --- | --- | --- |
| SPS main card | `sps_score`, `sps_tier`, `sps_tier_text` | Select to view scoring details; do not predict the next score locally. |
| Peer position | `peer_percentile`, `primary_category.*` | Use a tooltip to explain that the comparison is based on the store’s primary category. |
| Evaluation period | `start_evaluation_time`, `end_evaluation_time`, `update_time` | Display the evaluation period and latest update time. |
| Dimension cards | `dimensions[].name/score/status/weight` | Select a card to filter the metrics within that dimension. |
| Benefits list | `benefits[].benefit_name/is_unlocked/unlock_score` | `is_unlocked` is the source of truth; `unlock_score` is informational only and must not be used for local score-based predictions. |
| Priority issues | `top_issues.summary`, `top_issues.issues[]` | Sort by `rank`; select an item to open its corresponding `metric_code`. |
##### Optimization Opportunities and Actions
| Identification signal | Recommendation for the merchant | Action |
| --- | --- | --- |
| `top_issues` is present | Address the highest-ranked issue first instead of spreading resources evenly. | `Diagnose top issue`: Open UC02 |
| A dimension is `POOR/CRITICAL` | Expand the metrics for that dimension instead of looking only at the overall score. | `View metrics` |
| A benefit is locked and `unlock_score` is available | Show the score gap and related priority metrics; do not promise that completing an Action will unlock the benefit. | `Build action plan`: Open UC06 |
| `metrics[].status=NIL` / insufficient data for one metric | Keep the overall SPS and other scored metrics visible; explain only that metric’s scoring eligibility and evaluation period, and do not treat it as 0. | `Learn about SPS` |
| The merchant believes the data is unfair or incorrect | Capture the current metric, evaluation period, and affected records, then open the official appeal entry point. | `Appeal`; the link in the current recommendation document remains: https://seller-us.tiktok.com/university/essay?knowledge_id=6567382587836173 |
##### UI Interaction Requirements

* The initial screen should highlight SPS, Top Opportunity, the three dimensions, and the data update time, with the label “Latest calculated result; not real-time monitoring.”
* Group benefits into unlocked and pending-unlock sections, without using fear-based copy.
* When `metrics[].status=NIL`, use the “Insufficient data” state only for that metric. Keep the overall SPS, other metrics, and benefits visible, and do not display a red score of 0.
* After the merchant selects a Top Issue, preserve the source context and restore the previous scroll position when they return to Overview.

### User Case 02: Identify the Priority Metric and Complete Diagnosis
##### Scenario Overview
The operations team knows the SPS score is low but cannot determine which metric to improve first or how far the current value is from the peer benchmark. The App frontend combines data from the Metrics and Diagnosis APIs on one page to explain what the problem is, why it occurred, how far the store is from the target, and whether the trend is improving.
**Primary roles:** Store owner and domain operations leads.
**Successful outcome:** The merchant selects a clearly defined priority metric and either drills down to affected records or creates an Action.
##### Merchant Flow
The diagram below includes the corresponding App UI demo under each diagnostic step. At the final step, the merchant can either drill down to affected records or add the recommendation directly to the action plan.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/c39aef027fad4e18a72bfa804098d077~tplv-k9wyc2ijk0-image.image)

##### API Call Flow

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/177eb6fdee644981ad36047ba29e42fb~tplv-k9wyc2ijk0-image.image)

##### Diagnostic Prioritization

1. When `top_reason_text` is present, pin it to the top and label it `Top Opportunity`.
2. Display the remaining metrics by the severity of the platform `status`, but do not present App-defined sorting as an official priority ranking.
3. Within the same severity level, metrics may be sorted by worsening trend, gap to `excellent_threshold`, or the preference of the responsible operations lead.
4. Place `NIL` metrics last and explain insufficient data separately.

##### Optimization Opportunities and Actions
| Diagnostic signal | Recommendation | Action |
| --- | --- | --- |
| `top_reason_text` | This metric is the most valuable improvement opportunity to prioritize. | `Diagnose` |
| The trend continues to worsen | Review records newly affected in the last 15 days and address recent issues first. | `View recent problems` |
| The current value has not reached `excellent_threshold` | Show the gap and direction; read the target value from the API. | `Set target` |
| One distribution bucket has an anomalous share | Convert the bucket into a root-cause label and filter the related records. | `Filter affected records` |
| The numerator or denominator appears abnormal | Help the merchant validate the evaluation criteria and included records. | `Review calculation` |
| The merchant believes the data is incorrect | Preserve the raw response, evaluation period, and record IDs to prepare appeal evidence. | `Prepare appeal evidence` |
##### UI Interaction Requirements

* Present the six metrics as switchable tabs or a list; switching metrics must update the value, trend, benchmark, and Action.
* Label the trend chart with both units and the evaluation period; do not show an unlabeled line without axes.
* Use explicit text to indicate whether a lower or higher rate is better; do not rely on color alone.
* When `analysis` is empty, hide the “Intelligent Analysis” module and do not generate diagnostic conclusions that the platform did not return.

### User Case 03: Reduce Product Satisfaction Issues (NRR / NBFR)
##### Scenario Overview
Product operations teams may find that NRR or NBFR is dragging down SPS. They need to identify the products with the greatest concentration of issues and the leading negative-review or return reasons, then improve product quality, product detail pages, packaging, and after-sales handling.
**Primary roles:** Product operations, quality owner, and after-sales owner.
**Successful outcome:** The merchant identifies the top affected products and root causes, then completes the appropriate product, packaging, or review-handling actions.
##### Merchant Flow
The flow below covers NRR / NBFR metric diagnosis, key products, problem orders, and product-action pages. Root causes such as inaccurate descriptions, quality issues, wrong-item shipments, damage, and review handling branch into the appropriate action at the final step.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/facd1d8cd1304233830c72b6e609c316~tplv-k9wyc2ijk0-image.image)

##### API Call Flow

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/2480f93475fe4a08a6ee710dfd48f1bd~tplv-k9wyc2ijk0-image.image)

##### Data Mapping
| Metric | Key Top Items Fields | Key Problem Details Fields |
| --- | --- | --- |
| NRR | `product_id/name`, `image_url`, `delivered_order_count`, `negative_order_count`, `top_review_reasons` | `order_id`, `product_id/name`, `sku_id`, `user_review_rating`, `deliver_time` |
| NBFR | `product_id/name`, `return_order_count`, `top_return_reasons`, `top_reason_order_count` | `order_id`, `product_id/name`, `sku_id`, `return_refund_reason`, `deliver_time` |
##### Optimization Recommendations and Actions
| Metric / Root Cause | Optimization Opportunity | Action | US Seller Center |
| --- | --- | --- | --- |
| NRR: Not as described | Complete size, material, feature, and use-case details, and add authentic images or videos | `Product optimizer` | https://seller-us.tiktok.com/product/optimizer |
| NRR: Concentration of low-star reviews | Review 1–2-star ratings daily, identify recurring causes, and offer replacement or remediation options | `Manage Reviews` | https://seller-us.tiktok.com/product/rating |
| NRR: Repeated product-quality issues | Pause affected SKUs, strengthen inspections, or release an improved version | `Manage Product` | https://seller-us.tiktok.com/product/manage |
| NBFR: Size or material mismatch | Add a size chart, material details, and usage guidance | `Product optimizer` | https://seller-us.tiktok.com/product/optimizer |
| NBFR: Damage | Add bubble wrap, inner boxes, and outer-box protection for fragile products | `Improve packaging` | Instructional guidance; no fixed destination |
| NBFR: Wrong item shipped | Use bulk tools or templates and add SKU picking verification | `Prevent Errors` | https://seller-us.tiktok.com/product/batch/edit-prods?entry-from=manage |
| NRR / NBFR: Concentrated returns | Review return records and take action by product, reason, and batch | `Manage return` | https://seller-us.tiktok.com/order/return |
| Suspected malicious or incorrect data | Preserve supporting order and review evidence, then submit an SPS appeal | `Appeal` | https://seller-us.tiktok.com/university/essay?knowledge_id=6567382587836173 |
##### UI Interaction Requirements

* Display key products in the order returned by the API and provide a “View problem orders” entry point. Because the API does not define rank, a fixed Top-N, or pagination, do not present the result as a complete ranking.
* Use a placeholder when a product image fails to load; do not block diagnosis.
* `Load more` must pass through the opaque `next_page_token`; the client must not parse the token.
* Before an action opens Seller Center, indicate that the merchant is leaving the App and do not claim that the App has completed the change.
* Marking an action complete updates only the App task status; it does not modify SPS API data.

### User Case 04: Stabilize Fulfillment and Logistics Performance (SFCR / OTDR)
##### Scenario Overview
Fulfillment operations teams need to reduce seller-fault cancellations and improve the on-time delivery rate. The App frontend should bring inventory, cancellation reasons, expected and actual delivery times, and logistics-provider performance into one diagnostic flow. This helps merchants decide whether to correct inventory, adjust product handling time, extend dispatch deadlines, switch logistics providers, or enroll in FBT.
**Primary roles:** Fulfillment operations, warehouse owner, and logistics owner.
**Successful outcome:** The merchant completes the appropriate inventory or delivery action and can trace the issue to a specific order or logistics provider.
##### Merchant Flow
The flow below covers SFCR / OTDR diagnosis, cancellation reasons or logistics providers, problem orders, and fulfillment-action pages. Inventory, pricing, SLA, logistics-provider, FBT, and shipping-label actions branch by root cause at the final step.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/caef6c351e8b48dba8791d554e08050b~tplv-k9wyc2ijk0-image.image)

##### API Call Flow

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/6656d7fc4e064eeab0bce9bf31975a28~tplv-k9wyc2ijk0-image.image)

##### Data Mapping
| Metric | Top Items | Key Problem Details Fields |
| --- | --- | --- |
| SFCR | Not supported; do not call | `order_id`, `product_id/name`, `sku_id`, `cancellation_reasons`, `order_create_time` |
| OTDR | `logistics_provider`, `delivered_order_count`, `on_time_deliver_order_count`, `on_time_deliver_rate` | `order_id`, `product_name`, `sku_id`, `expect_deliver_time`, `actual_deliver_time` |
##### Optimization Recommendations and Actions
| Metric / Root Cause | Optimization Opportunity | Action | US Seller Center |
| --- | --- | --- | --- |
| SFCR: Out of stock | Sync inventory in real time, do not inflate sellable inventory, and set order caps when stock is low | `Manage Stock` | https://seller-us.tiktok.com/product/stock |
| SFCR: Delayed inventory updates | Configure inventory alerts or automatic synchronization | `Maintain Stock Accuracy` | https://seller-us.tiktok.com/product/stock |
| SFCR: Pricing or manual errors | Verify prices before listing and use bulk templates to reduce manual errors | `Verify Pricing` / `Prevent Errors` | https://seller-us.tiktok.com/product/manage |
| OTDR: Insufficient peak capacity | Use Order Capacity Handling to extend dispatch deadlines | `Extend your dispatch deadlines` | https://seller-us.tiktok.com/order/shipping-delivery-settings?tab=fulfillment&openOhcTool=true |
| OTDR: Product requires special handling | Set the appropriate product type for custom, pre-order, out-of-stock replenishment, or other special-handling products | `Product-Specific` | https://seller-us.tiktok.com/product/manage?tab=all |
| OTDR: Poor carrier performance | Compare logistics-provider on-time rates and select a reliable carrier or consolidator | `Choose a reliable logistics provider` | Official learning resources |
| OTDR: Unstable self-fulfillment | Evaluate enrollment in FBT; FBT orders receive the applicable exemptions under platform rules | `Enroll in FBT` | https://seller-us.tiktok.com/fbt/fbt_landing?from=fbtaca |
| OTDR: Missing order-status updates | Track shipped orders daily and proactively contact the carrier | `Stay up-to-date on order statuses` | Official learning resources |
| OTDR: Shipping-label or payment noncompliance | Ensure sufficient payment or postage and make sure labels meet carrier standards | `Ensure Payment and Label Compliance` | Instructional guidance |
| OTDR: Dispatch deadline approaching | Monitor delay tags and complete picking, packing, and handover before the automatic-cancellation date | `Monitor Dispatch Tags` / `Meet Pickup Deadlines` | https://seller-us.tiktok.com/order |
##### UI Interaction Requirements

* In the OTDR logistics-provider table, display the numerator, denominator, and on-time rate clearly; do not sort by order volume alone.
* Do not display an empty “Top Items” module on the SFCR page.
* When expected and actual delivery times are shown together, display the length of the delay.
* The FBT action must state the eligibility requirements and must not promise that historical SPS will change immediately after enrollment.

### User Case 05: Improve Customer Service and After-Sales Efficiency (IM_DSAT / AHT)
##### Scenario
Customer service managers need to identify low-satisfaction chats and slow after-sales requests, determine whether the issues stem from response speed, service attitude, FAQ coverage, manual approval workflows, or return inspections, and configure saved replies, automation, or after-sales rules.
**Primary roles:** Customer Service Manager and After-Sales Manager.
**Successful outcome:** The merchant identifies low-rated chats or high-duration after-sales cases and completes the relevant customer service or after-sales Actions.
##### Merchant Flow
The diagram below covers IM_DSAT / AHT diagnosis, low-rated chats or after-sales types, handling bottlenecks, and the Service Actions page. At the final node, Actions branch into response speed, service scripts, FAQs, automated approvals, and agent training.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/00bd8f5d259f455eb2a9197eb7f57f06~tplv-k9wyc2ijk0-image.image)

##### API Call Flow

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/c4589d3acb624660b35cac54c6a544bd~tplv-k9wyc2ijk0-image.image)

##### Data Mapping
| Metric | Top Items | Key Problem Details Fields |
| --- | --- | --- |
| IM_DSAT | Not supported; do not call | `chat_record_id`, `customer_name`, `customer_rating`, `rating_reasons`, `service_agent`, `first_reply_time`, `chat_duration_hours` |
| AHT | `top_aftersales_type_name`, `handle_duration_hours`, `return_order_count`, `top_type_order_count`, `product_id/name` | `order_id`, `return_order_id`, `aftersales_type_name`, `approve_duration_hours`, `inspect_duration_hours`, `total_handle_duration_hours`, `review_count` |
##### Optimization Recommendations and Actions
| Metric / Root Cause | Merchant Optimization | Action | US Seller Center |
| --- | --- | --- | --- |
| IM_DSAT: Slow first response | Enable notifications and set an internal response target of `<1h` | `Turn on notifications` | https://seller-us.tiktok.com/chat/settings/notification |
| IM_DSAT: Repeated common questions | Build an FAQ library and saved replies covering frequent topics such as returns, sizing, and shipping | `Build FAQ Library` / `Use saved answers` | https://seller-us.tiktok.com/chat/assistant/general/automatic-robot-setting |
| IM_DSAT: Missed messages | Review chats daily; mark spam as `No response needed` | `Stay on top of messages` | https://seller-us.tiktok.com/chat/settings/notification |
| IM_DSAT: Service attitude / accuracy | Train agents to communicate professionally, empathetically, and accurately | `Agent training` | Official learning resources |
| IM_DSAT: Insufficient status updates | Enable Chat Assistant and proactive messages to share shipping status | `Use chat assistant and Proactive messages` | https://seller-us.tiktok.com/chat/assistant/general/automation-tool-setting |
| AHT: Slow approval | Review and process after-sales requests within 12 hours whenever possible | `Respond Promptly` | In-app guidance copy |
| AHT: Suitable for automation | Configure automatic approval rules for eligible scenarios | `Configure Self-Service Options` | https://seller-us.tiktok.com/order/shipping-delivery-settings?shop_region=US&tab=return |
| AHT: Repeated inspection / communication | Clarify return and refund policies and provide clear responses and supporting evidence | `Maintain Quality Communication` | In-app guidance copy |
| AHT: Repeated returns for similar products | Improve product descriptions and packaging in parallel | `Manage Product` / `Product optimizer` | https://seller-us.tiktok.com/product/manage |
##### UI Interaction Requirements

* Use customer names as masked by the API; do not attempt to re-identify them.
* Display only fields within the authorized scope in chat details; do not combine them with personal information from other sources.
* For AHT, show approval, inspection, and total handling times together to help merchants locate workflow bottlenecks.
* Do not display an empty Top Items section on the IM_DSAT page.
* The automated approval Action must remind the merchant to review eligible scenarios and risks.

### User Case 06: Build an Action Plan, Monitor Periodically, and Review Continuously
##### Scenario
Cross-functional improvements usually cannot be completed in a single diagnostic session. The shop owner needs to assign recommendations in the App to product, fulfillment, or customer service owners, track due dates, and determine whether trends improved after the next SPS update. For merchants who do not proactively open the page, the App can also run periodic monitoring based on `update_time` and notify them when the SPS tier, Top Opportunity, or benefits status changes.
The SPS API is read-only. Tasks, owners, due dates, and completion status must be stored in the App's own system.
##### Merchant Flow
The diagram below covers the complete journey from converting a recommendation into a task and executing it through an external link, to marking it complete and reviewing it periodically. If new data does not improve, the merchant follows the feedback path back to the diagnosis page and adjusts the Action.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/a2c5721dc837473aa0070fa1a5d989ac~tplv-k9wyc2ijk0-image.image)

##### API and App Data Flow

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/f7741372c676467886fca382c6884e93~tplv-k9wyc2ijk0-image.image)

##### Minimum Action Plan Data Model
| Field | Description |
| --- | --- |
| `shop_id` | Internal shop identifier used by the App; do not expose tokens on the App frontend |
| `metric_code` | Links the task to an SPS metric; may be null for a general Action |
| `action_id` | Stable App Action ID; do not use display copy as the primary key |
| `source_update_time` | SPS data version when the task is created |
| `baseline_value/status/score` | Snapshot at creation; preserve both raw and display values |
| `owner_id`, `due_at`, `completed_at` | Owner, due date, and completion timestamp |
| `target_value` | Optional; proposed from an API benchmark and must be confirmed by the merchant |
| `seller_center_url` | Returned from the App backend (BFF) Action configuration and controlled by market |
| `follow_up_snapshot` | Metric snapshot after a subsequent data update |
##### Optimization Recommendations and Actions
| Management Issue | Recommendation | Action |
| --- | --- | --- |
| Recommendation has no owner | Require an owner or team when creating an Action | `Assign owner` |
| Multiple Actions are in progress | Keep one Top Opportunity as the primary task and the others as secondary tasks | `Prioritize` |
| Data has not been updated | Show “Waiting for platform data update”; do not equate task completion with score improvement | `Check after update` |
| No improvement after completion | Compare problem count, trend, and newly affected objects; refine the root-cause hypothesis | `Re-diagnose` |
| The merchant needs to file an appeal | Export the metric, assessment period, affected objects, and action logs as evidence | `Prepare appeal evidence` |
##### Periodic Monitoring and Notification Strategy

1. Scheduled jobs should call Overview only. If `update_time` is unchanged, stop all subsequent calls.
2. After `update_time` changes, call Metrics and compare `score/status/value/top_reason_text` with the previous snapshot.
3. Send business notifications only when the SPS tier, Top Opportunity, benefits unlock state, or metric status changes. Avoid creating noise from raw decimal fluctuations.
4. After the merchant opens a notification, lazy-load Diagnosis, Top Items, and Problem Details to avoid continuously fetching and storing order or chat details.
5. The current design has no webhook. The polling frequency must be configurable and comply with the refresh frequency and rate limits in the official API documentation.
6. `Need TikTok support`: [appeal link](https://seller-us.tiktok.com/university/essay?knowledge_id=6567382587836173). Until the link is confirmed, show only guidance for preparing an appeal and hide the empty button.

##### UI Interaction Requirements

* “Add to Action Plan” and “Go to Seller Center” are two separate actions.
* When the merchant returns after opening an external link, preserve the task's edit state.
* Completing an Action means only that the operational action is complete; it does not mean SPS has improved.
* The follow-up comparison must use a new `update_time`; otherwise, show “No new data”.

### SPS API Endpoint List and Call Timing
| API | Method & Path | When to Call | Key Parameters |
| --- | --- | --- | --- |
| Get SPS Overview | `GET /analytics/202606/shop_performances/overview` | SPS landing page | `locale` |
| Get SPS Metrics | `GET /analytics/202606/shop_performances/metrics` | SPS landing page and metric-list refresh | `locale` |
| Get SPS Metric Diagnosis | `GET /analytics/202606/shop_performances/metrics/:metric_code/diagnosis` | When the merchant opens metric details | `metric_code`, `locale`, `trend_duration_days` |
| Get SPS Metric Problem Details | `GET /analytics/202606/shop_performances/metrics/:metric_code/problem_details` | When the merchant opens “Problem Orders/Conversations” | `metric_code`, `locale`, `page_size` (default: 10; maximum: 50), `page_token` |
| Get SPS Metric Top Items | `GET /analytics/202606/shop_performances/metrics/:metric_code/top_items` | When the merchant opens product, logistics-provider, or aftersales-type aggregates | `NRR/NBFR/OTDR/AHT` only; `locale` |
Common host: `https://open-api.tiktokglobalshop.com`
Business headers listed here: `x-tts-access-token: <seller_access_token>` and `content-type: application/json`
> All five endpoints use GET and send no request body. The table lists endpoint-specific business parameters only; it is not a complete authentication or signing specification. Follow the official OpenAPI documentation for common parameters, signatures, API scopes, error codes, rate limits, and retry policies.

### Action Recommendation Configuration
##### Recommendation Rules
The recommendation engine only interprets and routes results; it does not replace platform scoring. Diagnosis is native API data, while the Action Catalog contains static suggestions that the App matches to diagnosis results. The App frontend must present these two layers separately:
```Plain Text
API status/top_reason_text
  + metric_code
  + diagnosis.analysis/distribution
  + reason fields from top_items/problem_details
  -> Match an Action by rule
  -> Merchant confirmation
  -> Seller Center deep link or App-owned task
```

Recommended priority:

1. Actions for a `Top Opportunity` metric;
2. Actions that directly match API `analysis` or an explicit issue reason;
3. Actions that can address a high-share Top Item;
4. General preventive Actions;
5. Show appeal guidance only when the merchant believes the data is incorrect or unfair—not as a default shortcut to a higher score.

##### Complete Action Catalog (US Primary Flow)
| Recommendation Mapping | Action Name | Merchant Action | Button | US Link |
| --- | --- | --- | --- | --- |
| ALL | Need TikTok support | Prepare supporting evidence and appeal suspected malicious, unfair, or incorrect data. | Appeal | https://seller-us.tiktok.com/university/essay?knowledge_id=6567382587836173 |
| NRR/NBFR/AHT | Manage return | Review and process returns. | Manage | https://seller-us.tiktok.com/order/return |
| NRR/NBFR | Product optimizer | Optimize titles, images, attributes, variants, and descriptions. | Optimize | https://seller-us.tiktok.com/product/optimizer |
| NRR/NBFR | Manage Product | Delist, revise, or update affected products. | Manage | https://seller-us.tiktok.com/product/manage |
| NRR | Manage Reviews | Review negative feedback, identify root causes, and offer a resolution. | Manage | https://seller-us.tiktok.com/product/rating |
| OTDR | Enroll in FBT | Evaluate enrollment in Fulfilled by TikTok. | Join now | https://seller-us.tiktok.com/fbt/fbt_landing?from=fbtaca |
| OTDR | Product-Specific | Set a more suitable SLA for customized, pre-order, restocking, or special-handling products. | Manage | https://seller-us.tiktok.com/product/manage?tab=all |
| OTDR | Extend your dispatch deadlines | Extend dispatch deadlines during peak-capacity periods. | To edit | https://seller-us.tiktok.com/order/shipping-delivery-settings?tab=fulfillment&openOhcTool=true |
| SFCR | Manage Stock | Verify and update inventory. | Manage | https://seller-us.tiktok.com/product/stock |
| OTDR | Stay up-to-date on your order statuses | Continuously track shipped orders and contact the carrier when needed. | Learn more | https://seller-us.tiktok.com/university/essay?knowledge_id=6179821974439723&role=1&course_type=1&from=search&identity=1 |
| OTDR | Choose a reliable logistics provider | Select a reliable carrier or logistics consolidator. | Learn more | https://seller-us.tiktok.com/university/essay?knowledge_id=8308896260065025&role=1&course_type=1&from=search&identity=1 |
| SFCR/AHT | Customizing Your Cancellation Features | Configure cancellation rules to reduce unnecessary manual handling. | Set up | https://seller-us.tiktok.com/order/shipping-delivery-settings?tab=cancellations |
| IM_DSAT | Mark spam as no response needed | Mark spam or messages that do not require a reply as “No response needed.” | — | None |
| IM_DSAT | Respond Promptly and proactively | Respond promptly and proactively to customer inquiries. | — | None |
| IM_DSAT | Build the FAQ Library | Build automated FAQ replies. | Add New | https://seller-us.tiktok.com/chat/assistant/general/automatic-robot-setting |
| IM_DSAT | Stay on top of incoming messages | Check chats daily and enable notifications. | Turn on | https://seller-us.tiktok.com/chat/settings/notification |
| IM_DSAT | Use saved answers to questions | Create saved replies for frequently asked questions. | Create | https://seller-us.tiktok.com/chat/settings/saved-reply |
| IM_DSAT | Use chat assistant and Proactive messages | Enable the chat assistant and proactive messages. | Set Up | https://seller-us.tiktok.com/chat/assistant/general/automation-tool-setting |
| IM_DSAT | Agent training | Train customer service agents on professional communication, empathy, and accuracy. | Learn more | https://seller-us.tiktok.com/university/essay?knowledge_id=5513514540189453&role=1&course_type=1&from=search&identity=1&anchor_link=EC5F00C9 |
| AHT | Respond Promptly | Process aftersales requests promptly. | — | None |
| AHT | Configure Self-Service Options | Configure automatic approval for eligible aftersales requests. | Set up | https://seller-us.tiktok.com/order/shipping-delivery-settings?shop_region=US&tab=return |
| AHT/IM_DSAT | Maintain Quality Communication | Provide clear responses and relevant supporting evidence. | — | None |
| NRR/NBFR/SFCR | Prevent Errors | Use bulk tools or templates to reduce manual errors. | To Use | https://seller-us.tiktok.com/product/batch/edit-prods?entry-from=manage |
| NBFR/SFCR | Verify Pricing | Double-check pricing before listing. | To check | https://seller-us.tiktok.com/product/manage |
| OTDR/NBFR | For Smooth Shipping | Ensure postage is fully paid and shipping labels are compliant. | — | None |
| OTDR | Monitor Dispatch Tags | Monitor delayed-order tags. | To check | https://seller-us.tiktok.com/order |
| OTDR | Meet Pickup Deadlines | Prepare orders before the auto-cancellation date and set reminders. | To check | https://seller-us.tiktok.com/order |
| SFCR | Maintain Stock Accuracy | Configure low-stock alerts or automatic inventory synchronization. | Set Alert | https://seller-us.tiktok.com/product/stock |
| OTDR | Follow Inbound Guidelines | Follow logistics-partner requirements for inbound delivery, documentation, and packaging. | Learn more | https://seller-us.tiktok.com/university/essay?knowledge_id=6201736389805867&role=1&course_type=1&from=search&identity=1 |
| OTDR | Ensure Payment and Label Compliance | Ensure parcels are fully paid and shipping labels are compliant. | — | None |
| NRR/NBFR | Ensure Full Compliance | Upload and maintain all required qualifications when listing products. | — | None |
| NRR/NBFR | Certificates & Docs: Valid & Ready | Keep certificates authentic, legible, and valid. | — | None |
| NRR/NBFR | Authenticity and Safety First | Sell only authentic products and retain invoices or proof of authenticity. | — | None |
| NRR/NBFR | Monitor & Act on Recalls | Monitor recalls and promptly delist affected products. | To check | https://seller-us.tiktok.com/order |
> The source recommendation table maintains both L2L and POP links. Because the current SPS API design supports US shops only, this solution includes L2L links in the production primary flow. Enable POP links only after the corresponding market APIs become available.

### Page Information Architecture and Interaction Demo Notes
##### Page Structure

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/0a02f065cdba4cf089c3678378ff7962~tplv-k9wyc2ijk0-image.image)

##### Core Components
| Component | Content | Key Interaction |
| --- | --- | --- |
| SPS Header | Overall score, tier, peer percentile, and update time | View scoring details |
| Dimension Cards | Scores, statuses, and weights for the three dimensions | Filter metrics by dimension |
| Metric Switcher | Six metrics, Top Opportunity, and status | Update the full page when the selected metric changes |
| Diagnosis Panel | Current value, score, benchmarks, trend, calculation formula, and distribution | Select a trend period and expand the calculation definition |
| Affected Objects | Products, logistics providers, aftersales types, and problem details | Drill down, paginate, and copy IDs |
| Action Cards | Reason, recommendation, button, and deep link | Add to a plan or open Seller Center |
| Action Plan Drawer | owner、due date、target、note | Save an App task or mark it complete |
##### Demo Data Disclaimer
The interaction demo uses mock data to illustrate fields and behaviors. It does not represent any real shop or platform commitment. Thresholds, scores, problem orders, and trends in the demo are for design illustration only; production environments must use actual SPS API responses.
Display the following two notices persistently on the page:

* “Data comes from the TikTok Shop SPS API and reflects the most recently calculated result, not real-time monitoring. The benchmark for the current primary category may change with category and peer-merchant performance.”
* “The recommendations below are matched by the App based on API diagnosis results and are provided for operational reference only. Taking an Action does not guarantee changes to the score, traffic, or benefits.”

### API List
**Mock data notice:** All request parameters, response examples, shop/product/order/conversation identifiers, and access-credential examples in this section are mock data provided only to illustrate field formats. They do not represent any real account or business data.

##### Get SPS Metrics
| Type | Value |
| --- | --- |
| API Name | Get SPS Metrics |
| API Version | 202606 |
| API URI (fixed for all APIs) | Host: open-api.tiktokglobalshop.com  Schemes: HTTPS |
| API Path | /analytics/:version/shop_performances/metrics |
| API Method | GET |
| API Function Description | Returns SPS metric details and benchmark thresholds for the authorized shop. Supported only for US-region shops. |
###### Request Parameters
####### Path
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
####### Query
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| locale | string | false | en-US | Locale code used to localize response text. If omitted, the default locale is resolved from the request context. |
####### Headers
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| x-tts-access-token | string | true | <REDACTED_EXAMPLE_TOKEN> | Seller access_token |
| content-type | string | true | application/json | Allowed type: application/json |
####### Body (not applicable to GET/DELETE)
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
**Request Body Example**
```JSON
{}
```

###### Response Parameters
| Properties |  |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- | --- |
| metrics |  |  | []object |  | Fixed complete SPS metric set for the authorized shop. |
| > | benchmarks |  | object |  | Benchmark thresholds for the metric. |
| > | > | excellent_threshold | string | 0.02 | Excellent tier threshold. |
| > | > | poor_threshold | string | 0.08 | Poor tier threshold. |
| > | dimension |  | string | Product satisfaction | SPS dimension that the metric belongs to. |
| > | evaluate_duration_days |  | int32 | 30 | Number of days included in this metric's evaluation period. |
| > | end_evaluation_time |  | int64 | 1761264000 | Metric evaluation period end time. Unix timestamp in seconds. |
| > | start_evaluation_time |  | int64 | 1758672000 | Metric evaluation period start time. Unix timestamp in seconds. |
| > | metric_code |  | string | NRR | Stable metric code. Possible values include NRR, NBFR, SFCR, OTDR, AHT, and IM_DSAT. |
| > | metric_name |  | string | 60-day negative review rate | Localized metric display name. |
| > | score |  | string | 4.7 | Metric score, from 0 to 5. |
| > | status |  | string | EXCELLENT | Metric status. Possible values include EXCELLENT, GOOD, POOR, CRITICAL and NIL. |
| > | status_text |  | string | Excellent | Metric status text. Values include Excellent, Good, Normal, Attention. |
| > | value |  | string | 0.97 | Metric value. Hours are represented as values; percentages are represented as values from 0 to 100. |
| > | value_unit |  | string | PERCENT | Unit of the metric value. Possible values include PERCENT and HOURS. |
| > | top_reason_text |  | string | Top opportunity | Indicates that this metric is a key contributor to SPS. |
> **NIL handling:** This example means the individual `IM_DSAT` metric has not yet met its scoring eligibility conditions. The shop’s overall SPS and other metrics may still be available. The App should show “Insufficient data” only for this metric.

```JSON
{
  "metric_code": "IM_DSAT",
  "status": "NIL",
  "status_text": ""
}
```

Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "metrics": {
    "benchmarks": {
      "excellent_threshold": "0.02",
      "poor_threshold": "0.08"
    },
    "dimension": "Product satisfaction",
    "evaluate_duration_days": 30,
    "end_evaluation_time": 1761264000,
    "start_evaluation_time": 1758672000,
    "metric_code": "NRR",
    "metric_name": "60-day negative review rate",
    "score": "4.7",
    "status": "EXCELLENT",
    "status_text": "Excellent",
    "value": "0.97",
    "value_unit": "PERCENT",
    "top_reason_text": "Top opportunity"
  }
}
```

##### Get SPS Overview
| Type | Value |
| --- | --- |
| API Name | Get SPS Overview |
| API Version | 202606 |
| API URI (fixed for all APIs) | Host: open-api.tiktokglobalshop.com  Schemes: HTTPS |
| API Path | /analytics/:version/shop_performances/overview |
| API Method | GET |
| API Function Description | Returns the SPS overview for the authorized shop, including the score, tier, dimensions, benefits, and top issues. Supported only for US-region shops. |
###### Request Parameters
####### Path
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
####### Query
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| locale | string | false | en-US | Locale code used to localize response text. If omitted, the default locale is resolved from the request context. |
####### Headers
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| x-tts-access-token | string | true | <REDACTED_EXAMPLE_TOKEN> | Seller access_token |
| content-type | string | true | application/json | Allowed type: application/json |
####### Body (not applicable to GET/DELETE)
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
**Request Body Example**
```JSON
{}
```

###### Response Parameters
| Properties |  |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- | --- |
| benefits |  |  | []object |  | Fixed complete set of benefits associated with the shop SPS score. |
| > | benefit_name |  | string | LIVE giveaway | Benefit display name localized by the requested locale. |
| > | is_unlocked |  | bool | true | Whether the shop has unlocked this benefit. |
| > | unlock_score |  | string | 4.5 | Score required to unlock the benefit, from 0 to 5. |
| dimensions |  |  | []object |  | Score details by SPS dimension. |
| > | name |  | string | Product satisfaction | Dimension name. |
| > | score |  | string | 4.8 | Dimension score, from 0 to 5. |
| > | status   |  | string | EXCELLENT | Dimension status enum. Possible values include EXCELLENT, GOOD, POOR, CRITICAL and NIL. |
| > | status_text |  | string | Excellent | Dimension status text. Possible values include Excellent, Good, Normal, Attention. |
| > | weight |  | string | 70 | Dimension weight as a percent from 0 to 100. |
| evaluate_duration_days |  |  | int32 | 90 | The number of days included in the score evaluation period. |
| end_evaluation_time |  |  | int64 | 1782518400 | The evaluation period end time. Unix timestamp in seconds. |
| start_evaluation_time |  |  | int64 | 1774828800 | The evaluation period start time. Unix timestamp in seconds. |
| peer_percentile |  |  | string | 86.5 | The shop's percentile among peers, from 0 to 100. |
| primary_category |  |  | object |  | The shop's primary category. |
| > | category_id |  | string | 601450 | The primary category ID. |
| > | category_name |  | string | Home Supplies | The primary category name. |
| sps_score |  |  | string | 4.6 | The shop SPS score, from 0 to 5 with one decimal place. |
| sps_tier |  |  | string | GOOD | The SPS tier. Possible values include EXCELLENT, GOOD, POOR, CRITICAL and NIL. |
| sps_tier_text |  |  | string | Excellent | The SPS tier. Possible values include Excellent, Good, Normal, Attention. |
| top_issues |  |  | object |  | Top SPS issues that contributed to the current score. |
| > | issues |  | []object |  | Ranked issue list. |
| > | > | description | string | Your on-time delivery performance is lower than peer shops. | Localized issue description. |
| > | > | evaluation_duration_days | int32 | 30 | Number of days included in this issue's evaluation period. |
| > | > | end_evaluation_time | int64 | 1761264000 | Issue evaluation period end time. Unix timestamp in seconds. |
| > | > | start_evaluation_time | int64 | 1758672000 | Issue evaluation period start time. Unix timestamp in seconds. |
| > | > | metric_code | string | OTDR | Related metric code. Possible values include NRR, NBFR, SFCR, OTDR, AHT, and IM_DSAT. |
| > | > | metric_name | string | On-time delivery rate | Localized metric display name. |
| > | > | percentile | string | 72.4 | Metric percentile among peer shops, from 0 to 100. |
| > | > | rank | int32 | 1 | Issue rank, where 1 is the top issue. |
| > | summary |  | string | Improve late dispatch and negative reviews to increase your SPS score. | Localized summary of the top issues. |
| update_time |  |  | int64 | 1761264000 | The latest score refresh time. Unix timestamp in seconds. |
Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "benefits": {
    "benefit_name": "LIVE giveaway",
    "is_unlocked": true,
    "unlock_score": "4.5"
  },
  "dimensions": {
    "name": "Product satisfaction",
    "score": "4.8",
    "status": "EXCELLENT",
    "status_text": "Excellent",
    "weight": "70"
  },
  "evaluate_duration_days": 90,
  "end_evaluation_time": 1782518400,
  "start_evaluation_time": 1774828800,
  "peer_percentile": "86.5",
  "primary_category": {
    "category_id": "601450",
    "category_name": "Home Supplies"
  },
  "sps_score": "4.6",
  "sps_tier": "GOOD",
  "sps_tier_text": "Excellent",
  "top_issues": {
    "issues": {
      "description": "Your on-time delivery performance is lower than peer shops.",
      "evaluation_duration_days": 30,
      "end_evaluation_time": 1761264000,
      "start_evaluation_time": 1758672000,
      "metric_code": "OTDR",
      "metric_name": "On-time delivery rate",
      "percentile": "72.4",
      "rank": 1
    },
    "summary": "Improve late dispatch and negative reviews to increase your SPS score."
  },
  "update_time": 1761264000
}
```

##### Get SPS Metric Problem Details
| Type | Value |
| --- | --- |
| API Name | Get SPS Metric Problem Details  |
| API Version | 202606 |
| API URI (fixed for all APIs) | Host: open-api.tiktokglobalshop.com  Schemes: HTTPS |
| API Path | /analytics/:version/shop_performances/metrics/:metric_code/problem_details |
| API Method | GET |
| API Function Description | Returns problem order or chat details for a selected SPS metric. Supported only for US-region shops. |
###### Request Parameters
####### Path
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| metric_code | string | true | NRR | Metric code. Possible values include NRR, NBFR, SFCR, OTDR, AHT, and IM_DSAT. |
####### Query
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| locale | string | false | en-US | Locale code used to localize response text. If omitted, the default locale is resolved from the request context. |
| page_token | string | false | 2 | Token used to retrieve the next page of results. Leave empty for the first page. |
| page_size | int32 | false | 10 | The number of results to return per page. Default value is 10. Maximum value is 50. |
####### Headers
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| x-tts-access-token | string | true | <REDACTED_EXAMPLE_TOKEN> | Seller access_token |
| content-type | string | true | application/json | Allowed type: application/json |
####### Body (not applicable to GET/DELETE)
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
**Request Body Example**
```JSON
{}
```

###### Response Parameters
| Properties |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- |
| aht_problem_order_items |  | []object |  | AHT problem order items. |
| > | aftersales_type_name | string | Only Return | Aftersales type returned by TikTok Shop aftersales classification. |
| > | approve_duration_hours | string | 12.5 | Approval duration in hours. |
| > | inspect_duration_hours | string | 30.0 | Inspection duration in hours. |
| > | order_id | string | 576461413038785752 | Order ID. |
| > | return_order_id | string | 576461413038785753 | Return order ID. |
| > | review_count | int32 | 2 | Number of review rounds. |
| > | total_handle_duration_hours | string | 42.5 | Total aftersales handle duration in hours. |
| im_dsat_chat_items |  | []object |  | IM_DSAT chat session items. |
| > | chat_duration_hours | string | 1.5 | Chat duration in hours. |
| > | chat_record_id | string | 745961413038785752 | Chat record ID. |
| > | customer_name | string | J*** D*** | Masked customer name. |
| > | customer_rating | int32 | 2 | Customer rating from 1 to 5. |
| > | first_reply_time | int64 | 1761264060 | First reply time. Unix timestamp in seconds. |
| > | rating_reasons | []string | other | Customer rating reasons. |
| > | service_agent | string | Agent A | Service agent name. |
| metric_code |  | string | NRR | Stable metric code. Possible values include NRR, NBFR, SFCR, OTDR, AHT, and IM_DSAT. |
| nbfr_problem_order_items |  | []object |  | NBFR problem order items. |
| > | deliver_time | int64 | 1761523200 | Delivery time. Unix timestamp in seconds. |
| > | order_create_time | int64 | 1761264000 | Order creation time. Unix timestamp in seconds. |
| > | order_id | string | 576461413038785752 | Order ID. |
| > | product_id | string | 1729592969712207010 | Product ID. |
| > | product_name | string | Cotton T-Shirt | Product name. |
| > | return_refund_reason | string | Wrong size | Return or refund reason. |
| > | sku_id | string | 1729592969712207013 | SKU ID. |
| next_page_token |  | string | b2Zmc2V0PTAK | An opaque token used to retrieve the next page of a paginated result set. Returns an empty string when there are no more results. |
| nrr_problem_order_items |  | []object |  | NRR problem order items. |
| > | deliver_time | int64 | 1761523200 | Delivery time. Unix timestamp in seconds. |
| > | order_create_time | int64 | 1761264000 | Order creation time. Unix timestamp in seconds. |
| > | order_id | string | 576461413038785752 | Order ID. |
| > | product_id | string | 1729592969712207008 | Product ID. |
| > | product_name | string | Wireless Headphones | Product name. |
| > | sku_id | string | 1729592969712207012 | SKU ID. |
| > | user_review_rating | int32 | 2 | User review rating from 1 to 5. |
| otdr_problem_order_items |  | []object |  | OTDR problem order items. |
| > | actual_deliver_time | int64 | 1761609600 | Actual deliver time. Unix timestamp in seconds. |
| > | expect_deliver_time | int64 | 1761523200 | Expected deliver time. Unix timestamp in seconds. |
| > | order_id | string | 576461413038785752 | Order ID. |
| > | product_name | string | Wireless Headphones | Product name. |
| > | sku_id | string | 1729592969712207014 | SKU ID. |
| sfcr_problem_order_items |  | []object |  | SFCR problem order items. |
| > | cancellation_reasons | []string | Defective item | Cancellation reasons. |
| > | order_create_time | int64 | 1761264000 | Order creation time. Unix timestamp in seconds. |
| > | order_id | string | 576461413038785752 | Order ID. |
| > | product_id | string | 1729592969712207011 | Product ID. |
| > | product_name | string | Smart Watch | Product name. |
| > | sku_id | string | 1729592969712207014 | SKU ID. |
| total_count |  | int32 | 200 | Total number of available records. |
Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "aht_problem_order_items": {
    "aftersales_type_name": "Only Return",
    "approve_duration_hours": "12.5",
    "inspect_duration_hours": "30.0",
    "order_id": "576461413038785752",
    "return_order_id": "576461413038785753",
    "review_count": 2,
    "total_handle_duration_hours": "42.5"
  },
  "im_dsat_chat_items": {
    "chat_duration_hours": "1.5",
    "chat_record_id": "745961413038785752",
    "customer_name": "J*** D***",
    "customer_rating": 2,
    "first_reply_time": 1761264060,
    "rating_reasons": "other",
    "service_agent": "Agent A"
  },
  "metric_code": "NRR",
  "nbfr_problem_order_items": {
    "deliver_time": 1761523200,
    "order_create_time": 1761264000,
    "order_id": "576461413038785752",
    "product_id": "1729592969712207010",
    "product_name": "Cotton T-Shirt",
    "return_refund_reason": "Wrong size",
    "sku_id": "1729592969712207013"
  },
  "next_page_token": "b2Zmc2V0PTAK",
  "nrr_problem_order_items": {
    "deliver_time": 1761523200,
    "order_create_time": 1761264000,
    "order_id": "576461413038785752",
    "product_id": "1729592969712207008",
    "product_name": "Wireless Headphones",
    "sku_id": "1729592969712207012",
    "user_review_rating": 2
  },
  "otdr_problem_order_items": {
    "actual_deliver_time": 1761609600,
    "expect_deliver_time": 1761523200,
    "order_id": "576461413038785752",
    "product_name": "Wireless Headphones",
    "sku_id": "1729592969712207014"
  },
  "sfcr_problem_order_items": {
    "cancellation_reasons": "Defective item",
    "order_create_time": 1761264000,
    "order_id": "576461413038785752",
    "product_id": "1729592969712207011",
    "product_name": "Smart Watch",
    "sku_id": "1729592969712207014"
  },
  "total_count": 200
}
```

##### Get SPS Metric Diagnosis
| Type | Value |
| --- | --- |
| API Name | Get SPS Metric Diagnosis |
| API Version | 202606 |
| API URI (fixed for all APIs) | Host: open-api.tiktokglobalshop.com  Schemes: HTTPS |
| API Path | /analytics/:version/shop_performances/metrics/:metric_code/diagnosis |
| API Method | GET |
| API Function Description | Returns diagnosis details for a single SPS metric, including benchmark thresholds, trends, calculation details, and distribution details. Supported only for US-region shops. |
###### Request Parameters
####### Path
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| metric_code | string | true | OTDR | Metric code. Possible values include NRR, NBFR, SFCR, OTDR, AHT, and IM_DSAT. |
####### Query
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| locale | string | false | en-US | Locale code used to localize response text. If omitted, the default locale is resolved from the request context. |
| trend_duration_days | int32 | false | 30 | Number of days to look back for metric trend data. Default value is 30. |
####### Headers
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| x-tts-access-token | string | true | <REDACTED_EXAMPLE_TOKEN> | Seller access_token |
| content-type | string | true | application/json | Allowed type: application/json |
####### Body (not applicable to GET/DELETE)
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
**Request Body Example**
```JSON
{}
```

###### Response Parameters
| Properties |  |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- | --- |
| benchmarks |  |  | object |  | Benchmark thresholds for this metric. |
| > | excellent_threshold |  | string | 0.98 | Excellent tier threshold. |
| > | poor_threshold |  | string | 0.80 | Poor tier threshold. |
| calculation_rule |  |  | object |  | Calculation details used to derive this metric. |
| > | denominator_label |  | string | Delivered orders | Denominator label. |
| > | denominator_value |  | string | 1000 | Denominator value. |
| > | numerator_label |  | string | On-time delivered orders | Numerator label. |
| > | numerator_value |  | string | 947 | Numerator value. |
| dimension |  |  | string | Product satisfaction | SPS dimension that the metric belongs to.  |
| distribution_details |  |  | []object |  | Additional distribution details for the metric. |
| > | count |  | int32 | 820 | Number of items in the distribution bucket. |
| > | name |  | string | Dispatch 24-48 Hours | Distribution detail name.  |
| > | percent |  | string | 82.0 | Percentage of items in the distribution bucket, from 0 to 100. |
| evaluate_duration_days |  |  | int32 | 30 | Number of days included in the metric evaluation period. |
| end_evaluation_time |  |  | int64 | 1761264000 | Metric evaluation period end time. Unix timestamp in seconds. |
| start_evaluation_time |  |  | int64 | 1758672000 | Metric evaluation period start time. Unix timestamp in seconds. |
| metric_code |  |  | string | OTDR | Stable metric code. Possible values include NRR, NBFR, SFCR, OTDR, AHT, and IM_DSAT. |
| score |  |  | string | 4.3 | Metric score, from 0 to 5. |
| status |  |  | string | GOOD | Metric status. Possible values include EXCELLENT, GOOD, POOR, CRITICAL and NIL. |
| status_text |  |  | string | Excellent | Metric status text. Values include Excellent, Good, Normal, Attention. |
| trend |  |  | object |  | Metric trend over the requested lookback range. |
| > | data_points |  | []object |  | Metric trend data points. |
| > | > | record_date | string | 2026-06-01 | Trend date in YYYY-MM-DD format. |
| > | > | value | string | 0.947 | Metric value on the trend date, using the same unit as value_unit. |
| value |  |  | string | 0.947 | Metric value. Ratios are represented as values from 0 to 1; percentages are represented as values from 0 to 100. |
| value_unit |  |  | string | PERCENT | Unit of the metric value. Possible values include PERCENT and HOURS. |
| analysis |  |  | []object |  |  Diagnostic insights for the selected metric. |
| > | summaries |  | []string |  | Summarized causes affecting the selected metric. |
| > | details |  | []string |  | Detailed explanations for the selected metric diagnosis. |
Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "benchmarks": {
    "excellent_threshold": "0.98",
    "poor_threshold": "0.80"
  },
  "calculation_rule": {
    "denominator_label": "Delivered orders",
    "denominator_value": "1000",
    "numerator_label": "On-time delivered orders",
    "numerator_value": "947"
  },
  "dimension": "Product satisfaction",
  "distribution_details": {
    "count": 820,
    "name": "Dispatch 24-48 Hours",
    "percent": "82.0"
  },
  "evaluate_duration_days": 30,
  "end_evaluation_time": 1761264000,
  "start_evaluation_time": 1758672000,
  "metric_code": "OTDR",
  "score": "4.3",
  "status": "GOOD",
  "status_text": "Excellent",
  "trend": {
    "data_points": {
      "record_date": "2026-06-01",
      "value": "0.947"
    }
  },
  "value": "0.947",
  "value_unit": "PERCENT",
  "analysis": {
    "summaries": "",
    "details": ""
  }
}
```

##### Get SPS Metric Top Items
| Type | Value |
| --- | --- |
| API Name | Get SPS Metric Top Items  |
| API Version | 202606 |
| API URI (fixed for all APIs) | Host: open-api.tiktokglobalshop.com  Schemes: HTTPS |
| API Path | /analytics/:version/shop_performances/metrics/:metric_code/top_items |
| API Method | GET |
| API Function Description | Returns top products, logistics providers, or aftersales types for a selected SPS metric. Supported only for US-region shops. |
###### Request Parameters
####### Path
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| metric_code | string | true | NRR | Metric code. Possible values include NRR, NBFR, OTDR, and AHT. |
####### Query
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| locale | string | false | en-US | Locale code used to localize response text. If omitted, the default locale is resolved from the request context. |
####### Headers
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
| x-tts-access-token | string | true | <REDACTED_EXAMPLE_TOKEN> | Seller access_token |
| content-type | string | true | application/json | Allowed type: application/json |
####### Body (not applicable to GET/DELETE)
| Properties | Type | Required | Example | Properties description |
| --- | --- | --- | --- | --- |
**Request Body Example**
```JSON
{}
```

###### Response Parameters
| Properties |  | Type | Example | Properties description |
| --- | --- | --- | --- | --- |
| aht_aftersales_type_items |  | []object |  | AHT aftersales type items. |
| > | handle_duration_hours | string | 18.5 | Average handle duration in hours. |
| > | product_id | string | 1729592969712207011 | Product ID. |
| > | product_name | string | Smart Watch | Product name. |
| > | return_order_count | int32 | 30 | Total number of return orders. |
| > | top_aftersales_type_name | string | Only Refund | Top aftersales type returned by TikTok Shop aftersales classification. |
| > | top_type_order_count | int32 | 20 | Number of orders associated with the top aftersales type. |
| metric_code |  | string | NRR | Stable metric code. Possible values include NRR, NBFR, OTDR, and AHT. |
| nbfr_top_product_items |  | []object |  | NBFR top product items. |
| > | product_id | string | 1729592969712207010 | Product ID. |
| > | product_name | string | Cotton T-Shirt | Product name. |
| > | return_order_count | int32 | 8 | Number of return or refund orders. |
| > | top_reason_order_count | int32 | 5 | Number of orders associated with the top return or refund reason. |
| > | top_return_reasons | []string | Item doesn't match description | Top return or refund reasons. |
| nrr_top_product_items |  | []object |  | NRR top product items. |
| > | delivered_order_count | int32 | 300 | Total number of delivered orders. |
| > | image_url | string | https://example.com/product.jpg | Product image URL. |
| > | negative_order_count | int32 | 12 | Number of orders with negative reviews. |
| > | product_id | string | 1729592969712207008 | Product ID. |
| > | product_name | string | Wireless Headphones | Product name. |
| > | top_review_reasons | []string | Item doesn't match description | Top negative review reasons. |
| otdr_logistics_items |  | []object |  | OTDR logistics provider items. |
| > | delivered_order_count | int32 | 1000 | Total number of delivered orders. |
| > | logistics_provider | string | TikTok Shipping | Logistics provider name. |
| > | on_time_deliver_order_count | int32 | 947 | Number of orders delivered on time. |
| > | on_time_deliver_rate | string | 0.947 | On-time delivery rate as a ratio from 0 to 1. |
| total_count |  | int32 | 120 | Total number of available records. |
Note: parameter preceded by ">" means the parameter is a subobject.
```JSON
{
  "aht_aftersales_type_items": {
    "handle_duration_hours": "18.5",
    "product_id": "1729592969712207011",
    "product_name": "Smart Watch",
    "return_order_count": 30,
    "top_aftersales_type_name": "Only Refund",
    "top_type_order_count": 20
  },
  "metric_code": "NRR",
  "nbfr_top_product_items": {
    "product_id": "1729592969712207010",
    "product_name": "Cotton T-Shirt",
    "return_order_count": 8,
    "top_reason_order_count": 5,
    "top_return_reasons": "Item doesn't match description"
  },
  "nrr_top_product_items": {
    "delivered_order_count": 300,
    "image_url": "https://example.com/product.jpg",
    "negative_order_count": 12,
    "product_id": "1729592969712207008",
    "product_name": "Wireless Headphones",
    "top_review_reasons": "Item doesn't match description"
  },
  "otdr_logistics_items": {
    "delivered_order_count": 1000,
    "logistics_provider": "TikTok Shipping",
    "on_time_deliver_order_count": 947,
    "on_time_deliver_rate": "0.947"
  },
  "total_count": 120
}
```

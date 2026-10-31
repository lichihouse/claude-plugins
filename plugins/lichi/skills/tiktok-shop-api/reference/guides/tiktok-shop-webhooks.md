# Developer Guide — TikTok Shop webhooks

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.



---

## TikTok Shop webhooks > Overview

Doc: https://partner.tiktokshop.com/docv2/page/tts-webhooks-overview · cập nhật 2026-07-06

Webhooks enable real-time HTTPS notifications for TikTok Shop events. After a shop subscribes to a webhook topic, TikTok Shop sends an HTTP `POST` request to the callback URL registered by the app when the subscribed event occurs.
Do not rely on webhooks as the only source of truth. Network failures, endpoint downtime, retries, or delayed delivery can happen, so your system should also reconcile critical business state through scheduled API polling.
### How webhook delivery works
The diagram below shows the order-status webhook flow. The same delivery pattern applies to other webhook topics.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/33f8046e84ec4c6f9946d446020184da~tplv-k9wyc2ijk0-image.image)

1. The app subscribes to a webhook topic, such as `ORDER_STATUS_CHANGE`, for a shop.
2. The app registers an HTTPS endpoint hosted by the app server.
3. A matching business event happens in the shop, such as a new order or an order-status update.
4. TikTok Shop publishes the event to the subscribed webhook topic.
5. TikTok Shop sends a webhook request with the topic-specific payload to the registered endpoint.

### Webhook topic quick reference
Use the `event_type` value when configuring a shop webhook with the webhook API or in Partner Center. The delivered payload also contains a numeric `type` field. The shared Event API schema publishes the full `event_type` enum, but it does not publish a complete numeric `type` mapping for every topic. Do not branch only on the numeric `type`; use the subscribed `event_type` context and the topic-specific payload schema.
| Webhook topic | `event_type` value | Payload `type` value | Trigger scenario |
| --- | --- | --- | --- |
| Order status change | `ORDER_STATUS_CHANGE` | `1` in the sample payload; confirm against the topic page for production logic | An order is created or the order status changes. |
| Recipient address update | `RECIPIENT_ADDRESS_UPDATE` | See topic-specific payload reference | The recipient address of an order is updated. |
| Package update | `PACKAGE_UPDATE` | See topic-specific payload reference | A package is updated, such as being combined, split, or changed because of address updates. |
| Product status change | `PRODUCT_STATUS_CHANGE` | See topic-specific payload reference | Product audit results are updated. |
| Seller deauthorization | `SELLER_DEAUTHORIZATION` | See topic-specific payload reference | A seller revokes or loses authorization for the app. Use this event to stop API calls for the shop and clean up local connection state. |
| Upcoming authorization expiration | `UPCOMING_AUTHORIZATION_EXPIRATION` | See topic-specific payload reference | The seller authorization will expire soon. TikTok Shop sends this event 30 days before expiration and then daily at 00:00 until reauthorization is completed. |
| Cancellation status change | `CANCELLATION_STATUS_CHANGE` | See topic-specific payload reference | An order cancellation status changes. |
| Return status change | `RETURN_STATUS_CHANGE` | See topic-specific payload reference | An order return status changes. |
| New conversation | `NEW_CONVERSATION` | See topic-specific payload reference | A customer-service agent joins or leaves a conversation. |
| New message | `NEW_MESSAGE` | See topic-specific payload reference | A new message is sent in a customer-service conversation. |
| Product information change | `PRODUCT_INFORMATION_CHANGE` | See topic-specific payload reference | Changes to a product title, description, main images, or attributes go live. |
| Product creation | `PRODUCT_CREATION` | See topic-specific payload reference | A new product is created. |
| Product category change | `PRODUCT_CATEGORY_CHANGE` | See topic-specific payload reference | A product category is changed. |
| New message listener | `NEW_MESSAGE_LISTENER` | See topic-specific payload reference | A creator sends a message to the seller. |
| Invoice status change | `INVOICE_STATUS_CHANGE` | See topic-specific payload reference | The status of an invoice upload changes after using the Upload Invoice endpoint. |
| Product audit status change | `PRODUCT_AUDIT_STATUS_CHANGE` | See topic-specific payload reference | The product audit status changes. |
| Reverse status update | `REVERSE_STATUS_UPDATE` | See topic-specific payload reference | A buyer raises a cancellation, refund-only, or return-and-refund request that requires seller action. |
For shop connection lifecycle handling, subscribe to both `UPCOMING_AUTHORIZATION_EXPIRATION` and `SELLER_DEAUTHORIZATION` when your app needs to maintain long-lived shop access.
### Configure webhooks
You can configure a shop webhook in Partner Center or through the Event API.
In Partner Center, open the app or service and go to the webhook or event-subscription settings:
```Plain Text
Partner Center
  -> App & Service
  -> Select the app or service
  -> Webhooks / Event subscriptions
  -> Add or update the topic and callback URL
```

Console labels may vary by Partner Center version. The required configuration is the webhook topic, represented by `event_type`, and an HTTPS callback URL controlled by your app.
To configure a webhook by API, call **Update Shop Webhook**:
```HTTP
PUT https://open-api.tiktokglobalshop.com/event/202309/webhooks?app_key={app_key}&timestamp={timestamp}&sign={sign}&shop_cipher={shop_cipher}
Content-Type: application/json
x-tts-access-token: {access_token}

{
  "address": "https://example.com/tiktok-shop/webhooks",
  "event_type": "ORDER_STATUS_CHANGE"
}
```

Use **Get Shop Webhooks** to inspect the currently configured webhook topics and callback URLs for a shop. Use **Delete Shop Webhook** only when you intentionally want to remove a topic subscription.
### Header and signature verification
TikTok Shop sends the webhook signature in the HTTP `Authorization` header. The value is the lowercase hexadecimal HMAC-SHA256 digest. It is not a bearer token and should not include a `Bearer` prefix.
The signature is calculated as follows:
```Plain Text
signature_base_string = app_key + raw_request_body
signature = HMAC-SHA256(signature_base_string, app_secret)
```

Important validation rules:
| Rule | Why it matters |
| --- | --- |
| Use the raw request body exactly as received. | Re-serializing JSON, sorting keys, changing whitespace, or changing encoding will produce a different signature. |
| Calculate the signature before parsing or modifying the body. | Some web frameworks consume or normalize the body during JSON parsing. Store the raw body for verification. |
| Compare signatures using a constant-time comparison. | This avoids timing-based comparison leaks. |
| Reject missing or mismatched signatures. | The request should not be processed when the `Authorization` header is absent or invalid. |

Reproducible example:

1. App key:

```Plain Text
abcdef
```

2. Raw request body:

```JSON
{"type":1,"tts_notification_id":"7380066284010030890","shop_id":"7495540735365777507","timestamp":1718305585,"data":{"is_on_hold_order":true,"order_id":"576653688135258178","order_status":"UNPAID","update_time":1718305585}}
```

3. Signature base string:

```Plain Text
abcdef{"type":1,"tts_notification_id":"7380066284010030890","shop_id":"7495540735365777507","timestamp":1718305585,"data":{"is_on_hold_order":true,"order_id":"576653688135258178","order_status":"UNPAID","update_time":1718305585}}
```

4. App secret:

```Plain Text
123
```

5. HMAC-SHA256 result:

```Plain Text
5dec0f11ec2f6783b8deee53c9ffbf8d024302f7c7e7fa55a35d17629031ac05
```

Pseudocode:
```JavaScript
const crypto = require("crypto");

function verifyWebhookSignature({ appKey, appSecret, rawBody, authorization }) {
  const base = appKey + rawBody;
  const expected = crypto
    .createHmac("sha256", appSecret)
    .update(base, "utf8")
    .digest("hex");

  const expectedBuffer = Buffer.from(expected, "utf8");
  const receivedBuffer = Buffer.from(authorization || "", "utf8");

  return (
    expectedBuffer.length === receivedBuffer.length &&
    crypto.timingSafeEqual(expectedBuffer, receivedBuffer)
  );
}
```

### Body parameters
All webhook notifications include common metadata and a topic-specific `data` object.
| Param name | Sample | Description |
| --- | --- | --- |
| `type` | `1` | Numeric notification type in the delivered payload. Do not confuse this with the `event_type` string used when configuring webhook subscriptions. |
| `tts_notification_id` | `7380066284010030890` | Unique TikTok Shop notification ID. Store this value for idempotency and duplicate-event handling when present. |
| `shop_id` | `7495540735365777507` | TikTok Shop ID associated with the event. Use this to map the webhook to the local shop connection. |
| `timestamp` | `1718305585` | Unix timestamp, in seconds, when the notification was pushed. |
| `data` | `{"order_id":"576653688135258178","order_status":"UNPAID","update_time":1718305585}` | Topic-specific business payload. The fields depend on the webhook topic. |
### Sample request
The sample request below uses the same raw body and signature shown in the reproducible example.
```Bash
curl --location --request POST 'https://example.com/tiktok-shop/webhooks' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: 5dec0f11ec2f6783b8deee53c9ffbf8d024302f7c7e7fa55a35d17629031ac05' \
  --data-raw '{"type":1,"tts_notification_id":"7380066284010030890","shop_id":"7495540735365777507","timestamp":1718305585,"data":{"is_on_hold_order":true,"order_id":"576653688135258178","order_status":"UNPAID","update_time":1718305585}}'
```

### Recommended listener behavior
| Situation | Recommended behavior |
| --- | --- |
| Valid signature and known `shop_id` | Process the event, update local state, and respond with a success status quickly. |
| Duplicate `tts_notification_id` | Treat the event as idempotent and avoid creating duplicate business records. |
| Unknown `shop_id` | Log the event and investigate whether the local shop mapping is missing or stale. |
| `SELLER_DEAUTHORIZATION` received | Mark the shop connection inactive, stop seller-scoped API calls for the shop, and ask the seller to authorize again if access is still required. |
| `UPCOMING_AUTHORIZATION_EXPIRATION` received | Notify the seller and route them through reauthorization before access expires. |
| Webhook delivery fails or is delayed | Reconcile through scheduled API polling for critical resources such as orders, packages, products, returns, and cancellations. |
### Related references

* [Get Shop Webhooks](https://partner.tiktokshop.com/docv2/page/get-shop-webhooks)
* [Update Shop Webhook](https://partner.tiktokshop.com/docv2/page/update-shop-webhook)
* [Delete Shop Webhook](https://partner.tiktokshop.com/docv2/page/delete-shop-webhook)
* [Order Status Change webhook](https://partner.tiktokshop.com/docv2/page/order-status-change)
* [Seller deauthorization webhook](https://partner.tiktokshop.com/docv2/page/65095746defece02be4d749d)
* [Upcoming authorization expiration webhook](https://partner.tiktokshop.com/docv2/page/6509579c0fcef602bf11312c)
* [Reauthorize shops](https://partner.tiktokshop.com/docv2/page/reauthorize-shops)
* [Disconnecting shops](https://partner.tiktokshop.com/docv2/page/disconnecting-shops)


---

## TikTok Shop webhooks > Configuration guide

Doc: https://partner.tiktokshop.com/docv2/page/configuration-guide · cập nhật 2026-07-06

Webhooks notify your HTTPS endpoint when subscribed TikTok Shop events occur. You can configure webhook subscriptions in Partner Center Console or with the Events API.
### Webhook configuration overview
There are two supported configuration methods:
| Method | Best for | Where to manage it |
| --- | --- | --- |
| Partner Center Console | Manual setup, first-time setup, and visual confirmation of webhook URL and selected topics. | **Partner Center Console > App & Service > Select your app or service > Basic Information > Developing** |
| Events API | Programmatic shop-level webhook configuration, automation, or configuration sync across shops. | `PUT /event/202309/webhooks`, `GET /event/202309/webhooks`, and `DELETE /event/202309/webhooks` |

Use one operational source of truth for each app or shop. Partner Center and the Events API manage the same webhook configuration surface; changes made in one place can affect what you see in the other.
### Requirements
Before you configure webhooks, make sure that:

* You understand the webhook event model and payload format. See [Webhooks overview](https://partner.tiktokshop.com/docv2/page/tts-webhooks-overview).
* Your app has the API scopes and topic permissions required by the events you want to subscribe to.
* Your receiving service exposes a reachable HTTPS endpoint that meets the webhook URL requirements below.
* If you use the Events API, you can send signed TikTok Shop API requests and provide a valid `x-tts-access-token` when the endpoint requires it. See [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request).

### Webhook URL requirements
| Requirement | Details |
| --- | --- |
| Scheme | Use `https://`. |
| TLS | Support TLS v1.2 or later. |
| Host | Use a domain name. Do not use an IP address. |
| Port | Do not include a custom port in the webhook URL. |
| Success acknowledgement | Return HTTP `200` within 3 seconds when the notification is accepted. |
| Authentication failure | Return HTTP `401` only when your service rejects the webhook signature or authentication. `401` is not a successful delivery acknowledgement. |
### Method 1: Configure webhooks in Partner Center Console
Use this path for webhook URL and topic configuration:
```Plain Text
Partner Center Console
  -> App & Service
  -> Select your app or service
  -> Basic Information
  -> Developing
  -> Webhook URL / Event subscriptions
```

Use **Development Kits > Webhook Log** only when you want to inspect delivery history. It is a monitoring entry, not the webhook configuration entry.
### Step 1: Configure the webhook URL
Add your HTTPS webhook receiver URL in the **Developing** section under **Basic Information**.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/84d2e7f5f4a94851b923a1308308aabc~tplv-k9wyc2ijk0-image.image)
creenshot reference: the webhook URL field is in the app or service configuration area, not in **Development Kits**.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/5ab7fe180c1041f3ac0726950f072196~tplv-k9wyc2ijk0-image.image)

### Step 2: Choose webhook topics
Partner Center may preselect default webhook notifications for your app. The exact default set can vary by app type, market, seller type, and approved scopes, so confirm the selected default topics in the Partner Center subscription UI before launch.
For optional topics, select only the events your integration actually handles. Common webhook categories include:
| Topic category | Example use case | Subscribe when |
| --- | --- | --- |
| Order status updates | Receive a notification when an order is created or the order status changes. | Your app syncs orders, fulfillment state, or order lifecycle changes. |
| Order recipient address updates | Receive a notification when order recipient address information changes. | Your app needs to update shipping, warehouse, or fulfillment data after address changes. |
| Return, refund, or replacement updates | Receive a notification when a return, refund, or replacement status changes. | Your app manages post-sales workflows. |
| Product status updates | Receive a notification when product status changes. | Your app syncs product listing status or listing health. |
| Package or fulfillment updates | Receive package-related status changes when supported for your app and market. | Your app manages fulfillment, shipment, or delivery workflows. |
| Authorization lifecycle events | Receive `UPCOMING_AUTHORIZATION_EXPIRATION` or `SELLER_DEAUTHORIZATION` when supported. | Your app stores seller authorization tokens and needs to maintain or stop shop access. |

For the full and current event list, use the event list in [Webhooks overview](https://partner.tiktokshop.com/docv2/page/tts-webhooks-overview) and the event-specific reference pages linked from that overview.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/796b668db0b44dc196622dab013fc56d~tplv-k9wyc2ijk0-image.image)
creenshot reference: use this area to confirm which topics are selected by default and which optional topics you have enabled.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/7e97002885864b27921395d63794ea6e~tplv-k9wyc2ijk0-image.image)

### Step 3: Receive and verify webhook notifications
TikTok Shop sends an HTTP `POST` request to your configured URL when a subscribed event occurs. The request body contains JSON data for the event.
TikTok Shop verifies SSL certificates when delivering payloads to HTTPS webhook addresses. Make sure your server certificate is valid and trusted.
TikTok Shop places the webhook signature in the `Authorization` request header. This webhook signature is different from the signature you generate when your app calls TikTok Shop APIs. For webhook verification:

1. Read the raw request body exactly as received.
2. Concatenate `{app_key}{raw_webhook_payload}` with no added whitespace or reformatting.
3. Use your app secret as the HMAC-SHA256 key.
4. Compare the generated lowercase hexadecimal value with the `Authorization` header value.

Do not parse and re-serialize the JSON body before verification. Reformatting the body can change whitespace or field order and cause signature verification to fail. For the webhook signing example, see the **Webhooks Header and Body** section in [Webhooks overview](https://partner.tiktokshop.com/docv2/page/tts-webhooks-overview).
### Step 4: Respond to webhook notifications
Return a response within 3 seconds for each notification.
| Situation | HTTP status | Body | Meaning | Retry behavior |
| --- | --- | --- | --- | --- |
| Notification accepted and queued or processed | `200` | Empty body | Successful delivery acknowledgement. | TikTok Shop treats the notification as delivered. |
| Signature or authentication failed | `401` | Empty body | Your service rejected the notification. This is a valid semantic response for authentication failure, but not a success acknowledgement. | Treat as failed delivery. TikTok Shop may retry according to the retry schedule. |
| Timeout, network failure, or other non-200 response | Non-`200` or no response | Any | Delivery failed or was not acknowledged in time. | TikTok Shop retries according to the retry schedule. |

TikTok Shop stops retrying after the 4th retry failure.
| Retry | Trigger |
| --- | --- |
| 1st retry | 2 minutes after the initial push failure |
| 2nd retry | 30 minutes after the 1st retry failure |
| 3rd retry | 3 hours after the 2nd retry failure |
| 4th retry | 12 hours after the 3rd retry failure |

Webhook delivery is at-least-once. Your listener must be idempotent because the same event can be delivered more than once during retries. Store and deduplicate by `tts_notification_id` when it is present in the payload. If an event-specific payload does not include `tts_notification_id`, use the most stable available combination, such as event type, `shop_id`, timestamp, and the business object ID.
### Method 2: Configure webhooks with the Events API
Use the Events API when you need to create, inspect, or delete webhook subscriptions programmatically.
Before calling these APIs:
| Prerequisite | What to check |
| --- | --- |
| API access | Your app must have access to the Events API and the event topic you are configuring. Check the endpoint reference and **App & Service > Manage API** for the required scope or permission. |
| Seller/shop authorization | Use a valid `x-tts-access-token` when the endpoint requires seller-scoped authorization. |
| Request signing | Include the required OpenAPI query parameters such as `app_key`, `timestamp`, and `sign`. Generate `sign` with the TikTok Shop API request signing rules. |
| Shop context | Include `shop_cipher` when the endpoint or shop type requires a shop-level context. |
| Topic value | Use the exact `event_type` value from the event-specific reference page. |

Events API configuration and Partner Center configuration are not mutually exclusive. They update the same underlying subscription configuration. If you call **Update Shop Webhook** for a shop and event that was configured manually, the API can update or replace that shop-event configuration. After any API change, call **Get Shop Webhooks** or check Partner Center to confirm the final state.
Available Events API operations:
| API | Use it for |
| --- | --- |
| [Update Shop Webhook](https://partner.tiktokshop.com/docv2/page/update-shop-webhook) | Create or update a shop webhook subscription for a specific event. This corresponds to setting the callback URL and selected topic in Partner Center. |
| [Get Shop Webhooks](https://partner.tiktokshop.com/docv2/page/get-shop-webhooks) | Retrieve existing shop webhook configurations and verify the current callback URL and event subscriptions. |
| [Delete Shop Webhook](https://partner.tiktokshop.com/docv2/page/delete-shop-webhook) | Cancel a shop webhook subscription for a specific event. Use this only when you intentionally want to stop receiving that event. |
### Check webhook event history
Use this path to inspect webhook delivery logs:
```Plain Text
Partner Center Console
  -> Development Kits
  -> Webhook Log
  -> Select the app or service
```

The webhook log is for monitoring and debugging delivery history. Use it to confirm whether TikTok Shop sent a notification, which callback URL was used, and what response your server returned.
Screenshot reference: this screenshot shows the log and debugging entry under **Development Kits**, separate from the app configuration entry under **App & Service > Developing**.

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/5a30e72db1614b4ea89547aac013dc70~tplv-k9wyc2ijk0-image.image)

### Related pages
| Page | Use it for |
| --- | --- |
| [Webhooks overview](https://partner.tiktokshop.com/docv2/page/tts-webhooks-overview) | Webhook concepts, event list, payload format, and webhook signature verification example. |
| [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request) | Signing TikTok Shop API requests made by your app, including Events API requests. Do not use this algorithm as the webhook receiver verification algorithm. |
| [Update Shop Webhook](https://partner.tiktokshop.com/docv2/page/update-shop-webhook) | Create or update a shop webhook subscription by API. |
| [Get Shop Webhooks](https://partner.tiktokshop.com/docv2/page/get-shop-webhooks) | Verify current shop webhook configuration by API. |
| [Delete Shop Webhook](https://partner.tiktokshop.com/docv2/page/delete-shop-webhook) | Delete a shop webhook subscription by API. |

# Developer Guide — Appendix

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.



---

## Appendix > Quality engine incident reason code

Doc: https://partner.tiktokshop.com/docv2/page/quality-engine-incident-reason-code · cập nhật 2026-07-06

### Overview
Use this page when your app needs to sync Quality Engine incident reasons to TikTok Shop through the Quality Engine order data exchange API.
Quality Engine uses the reason code to understand why an order reconciliation incident happened. Send one of the reason codes listed on this page, match it to the applicable rule IDs, and keep the enum value exactly as written. Codes outside the list may be rejected by Quality Engine.
Last reviewed: July 6, 2026, against the Data Reconciliation OpenAPI reference and the Developer dashboard rule tables.
### Key terms
| Term | Meaning |
| --- | --- |
| Quality Engine | TikTok Shop's order and fulfillment reconciliation system. It compares TikTok Shop order and fulfillment data with the external platform where the seller syncs or fulfills orders. |
| A-LOC | App Caused-Late Dispatch Rate TikTok Shipping Cancel Order Count. In the Developer dashboard, A-LOC incidents are TikTok Shop orders canceled by the system for missing the `shipping_due_time` SLA with `system_cancel_order_reason_shipping_timeout`. |
| Risk order | An order that is at risk of missing the TikTok Shop shipping SLA because order or fulfillment data is inconsistent between TikTok Shop and the external platform. |
| Orphan order | An incident where the TikTok Shop order has no related order in the DTC channel or external platform. |
| Pre-RTS | In this page, a Pre-RTS incident means the order is shipped or has tracking information in the DTC channel, but the corresponding TikTok Shop order is not shipped or fulfilled in TikTok Shop. RTS refers to the ready-to-ship fulfillment stage. |
| DTC channel | Direct-to-Consumer channel, such as Shopify, WooCommerce, BigCommerce, or Magento. In this page, "DTC channel", "channel platform", and "external platform" refer to the seller's external commerce system. |
| 4PL connector | A fourth-party logistics connector or fulfillment integration that can exchange order, package, carrier, or tracking data between the seller's fulfillment system and TikTok Shop. |
| TTS | TikTok Shop. Use "TikTok Shop" in user-facing text unless quoting an API field or existing rule name. |
| `shipping_due_time` / `tts_sla` | The TikTok Shop shipping deadline used by the Developer dashboard rule tables to detect A-LOC and risk-order incidents. |
### Rule alignment
The reason code list on this page uses the R/A rule ID system from the [Developer dashboard](https://partner.tiktokshop.com/docv2/page/developer-dashboard). It should not be mixed with the old FC-101 to FC-105 wording that remains in some dashboard notes.
| Rule IDs | Incident type | Dashboard definition | Reason code category on this page |
| --- | --- | --- | --- |
| [A1](https://partner.tiktokshop.com/docv2/page/developer-dashboard#a--loc-incident-statistics) | A-LOC | TikTok Shop order is canceled for shipping timeout, and the order is not present or not sent to the external platform. | Orphan Order |
| A2 | A-LOC | TikTok Shop order is canceled for shipping timeout; order exists in the DTC channel, but DTC tracking number is null. | Not covered by the current reason code tables. Do not invent a reason code. |
| A3 | A-LOC | TikTok Shop order is canceled for shipping timeout; order exists in the DTC channel and DTC tracking number is not null. | Pre-RTS |
| A4 | A-LOC | TikTok Shop order is canceled for shipping timeout; TikTok Shop tracking and DTC tracking are both not null. | Not covered by the current reason code tables. Do not invent a reason code. |
| R0 | Risk order | TikTok Shop order is on hold; DTC order exists and has tracking. | Not covered by the current reason code tables. |
| R1 | Risk order | TikTok Shop order is awaiting shipment, and no related DTC order exists. | Orphan Order |
| R2 | Risk order | TikTok Shop order is partially shipping, and no related DTC order exists. | Orphan Order |
| R3 / R4 | Risk order | Short-time built-in rules for awaiting shipment or partially shipping orders where the DTC order exists but tracking is null near the SLA deadline. | Not covered by the current reason code tables. |
| R5 | Risk order | TikTok Shop order is awaiting shipment; DTC order exists and DTC tracking number is not null. | Pre-RTS |
| R6 | Risk order | TikTok Shop order is partially shipping; DTC order exists and DTC tracking number is not null. | Pre-RTS |
| R7 | Risk order | TikTok Shop order is awaiting collection; TikTok Shop and DTC tracking are both not null after the TikTok Shop SLA. | Not covered by the current reason code tables. |
The Developer dashboard table includes FC-101 to FC-105 only as legacy "Not Existing Reason" wording. These FC codes are not listed as valid reason codes on this page. Do not send FC-101 to FC-105 in `issue_reason` unless the API reference explicitly lists them for your app version.
### API usage
Use the [Quality Factory Order Data Import API](https://partner.tiktokshop.com/docv2/page/quality-factory-order-data-import-api-202401) to sync order data and incident reason codes.
| Item | Value |
| --- | --- |
| Method and path | `POST /data_reconciliation/202401/orders/import` |
| Query parameter | `shop_cipher` when required for the shop context. Get it from the authorized shop data. |
| Required headers | `x-tts-access-token`, `Content-Type: application/json` |
| Request field for reason code | `orders[].issue_reason` |
| Reason code format | Uppercase enum string, exactly as listed in this page. |
| Related API docs | [Quality Engine Order Data Exchange API](https://bytedance.sg.larkoffice.com/docx/A6qMdwPC5oESvkxLuffcAVMbnLc), [Reason code reference](https://partner.tiktokshop.com/docv2/page/660bf931cf5cc502e03007ca) |
Version note: `POST /data_reconciliation/202309/orders/sync` and `POST /data_reconciliation/202310/orders/import` use `orders[].not_exist_reason`. The 202401 API uses `orders[].issue_reason`. Use the field name from the endpoint version you call.
Minimal request example:
```JSON
{
  "orders": [
    {
      "order_id": "7021436810468230477",
      "channel_type": "SHOPIFY",
      "channel_order_id": "8021436810468230477",
      "channel_order_status": "OPEN",
      "channel_financial_status": "PAID",
      "channel_fulfillment_status": "FULFILLED",
      "channel_order_update_time": "1692163668",
      "issue_reason": "SELLER_TIKTOKSHOP_AUTHORIZATION_REVOKED",
      "packages": [
        {
          "package_id": "RN141567632MY",
          "shipping_provider_name": "UPS",
          "tracking_number": "LX542261779US"
        }
      ]
    }
  ]
}
```

`channel_order_update_time` is the order update timestamp on the DTC channel, not the API call time. It must be a 10-digit Unix timestamp in seconds and must be earlier than the current timestamp.
### Reason code quick guide
| Reason category | Suitable rules | Codes | API field |
| --- | --- | --- | --- |
| Orphan Order | R1 / R2 / A1 | Use the Orphan Order reason code table below. | `issue_reason` |
| Pre-RTS | A3 / R5 / R6 | Use the Pre-RTS reason code table below. | `issue_reason` |
### Orphan Order reason codes
Use these codes when there is no related order in the DTC channel.
| Reason Category | Suitable for Rules | Reason Code | Description |
| --- | --- | --- | --- |
| Orphan Order | R1 / R2 / A1 | `SELLER_TIKTOKSHOP_AUTHORIZATION_REVOKED` | Seller revoked TikTok Shop authorization for the app. |
| Orphan Order | R1 / R2 / A1 | `SELLER_UNINSTALLED_DTC_APP` | Seller uninstalled the app from the DTC channel platform. |
| Orphan Order | R1 / R2 / A1 | `SELLER_NOT_GRANT_DTC_PERMISSION` | Seller did not grant the corresponding DTC channel API permissions to the app. |
| Orphan Order | R1 / R2 / A1 | `SELLER_DTC_STORE_UNAVAILABLE` | Seller's DTC channel store is unavailable. |
| Orphan Order | R1 / R2 / A1 | `SELLER_TIKTOKSHOP_STORE_INACTIVE` | Seller's TikTok Shop store is inactive. |
| Orphan Order | R1 / R2 / A1 | `SELLER_DTC_NO_SKU` | No corresponding SKU was found for the seller's DTC channel products. |
| Orphan Order | R1 / R2 / A1 | `SELLER_DTC_ABNORMAL_PRODUCT_STATUS` | Product status is abnormal on the seller's DTC channel platform. |
| Orphan Order | R1 / R2 / A1 | `SELLER_DTC_PRODUCT_OUT_OF_STOCK` | Products on the seller's DTC channel platform are out of stock. |
| Orphan Order | R1 / R2 / A1 | `SELLER_TIKTOKSHOP_ORDER_AMOUNT_ZERO` | Order amount in the seller's TikTok Shop order is 0. |
| Orphan Order | R1 / R2 / A1 | `SELLER_APP_OWE_FEE` | Seller used the app but did not renew it, or the seller is out of quota. |
| Orphan Order | R1 / R2 / A1 | `SELLER_ABANDON_SYNC_TIKTOKSHOP_ORDER` | Seller opted not to synchronize TikTok Shop orders. |
| Orphan Order | R1 / R2 / A1 | `APP_MISSED_WEBHOOK` | App missed TikTok Shop order webhooks. |
| Orphan Order | R1 / R2 / A1 | `APP_ORDER_RETRIEVE_API_FAILED` | App failed to retrieve orders by calling TikTok Shop APIs. |
| Orphan Order | R1 / R2 / A1 | `APP_ORDER_RETRIEVE_API_NOT_MATCH_DTC_FIELD` | Order information retrieved by the app from TikTok Shop APIs is incomplete or does not match the DTC channel field mapping. |
| Orphan Order | R1 / R2 / A1 | `APP_CALL_DTC_CREATE_ORDER_API_FAILED` | App failed to create the order by calling the DTC channel API. |
| Orphan Order | R1 / R2 / A1 | `OTHER` | Use only when none of the listed Orphan Order codes matches the incident. |
### Pre-RTS reason codes
Use these codes when the order is shipped in the DTC channel but not shipped in TikTok Shop.
| Reason Category | Suitable for Rules | Reason Code | Description |
| --- | --- | --- | --- |
| Pre-RTS | A3 / R5 / R6 | `INVALID_TRACKING_NUMBER` | Invalid tracking number entered in the DTC channel. Examples: the tracking number has extra spaces or tabs, or the tracking number is incorrect but accepted by the DTC channel. TikTok Shop rejects this fulfillment. |
| Pre-RTS | A3 / R5 / R6 | `UNSUPPORTED_CARRIER_TRACKING_NUMBER` | The carrier is supported by the DTC channel but unsupported by TikTok Shop. TikTok Shop rejects this fulfillment. |
| Pre-RTS | A3 / R5 / R6 | `ORDER_NOT_ELIGIBLE_FOR_FULFILLMENT` | The package is shipped in the DTC channel but not in TikTok Shop because TikTok Shop has a cancellation or refund request for the order. TikTok Shop rejects this fulfillment. |
| Pre-RTS | A3 / R5 / R6 | `FULFILL_UNIT_OR_ORDER_NUMBER_NOT_COMBINED_CORRECTLY` | The package or order fulfillment call to TikTok Shop failed because the tracking number was used in another order without correctly combining orders. |
| Pre-RTS | A3 / R5 / R6 | `FULFILL_UNIT_OR_ORDER_NUMBER_NOT_FOUND` | The package or order fulfillment call to TikTok Shop failed because the seller combined or split the order in TikTok Shop or the DTC channel before fulfillment. TikTok Shop rejects this fulfillment. |
| Pre-RTS | A3 / R5 / R6 | `FULFILLMENT_FAILURE_DUE_TO_RATE_LIMIT` | The package or order fulfillment call to TikTok Shop failed because the app exceeded the rate limit and did not retry. |
| Pre-RTS | A3 / R5 / R6 | `FULFILLMENT_FAILURE_DUE_TO_NO_RETRY_LOGIC` | The app called order fulfillment, but TikTok Shop returned a temporary internal error and the app did not retry. |
| Pre-RTS | A3 / R5 / R6 | `FULFILLMENT_FAILURE_DUE_TO_NO_API_CALL` | No order fulfillment call was made for this order from the connector app. |
The current Pre-RTS list does not define an `OTHER` code. Do not send `OTHER` for Pre-RTS incidents unless a newer endpoint reference explicitly adds it. If an incident does not match any listed Pre-RTS code, confirm the expected code through the latest Quality Engine rule definition or Partner Center support.
### Validation checklist
Before syncing a reason code:

1. Confirm the incident category: Orphan Order or Pre-RTS.
2. Confirm the rule ID in the Developer dashboard: R1 / R2 / A1 for Orphan Order, or A3 / R5 / R6 for Pre-RTS.
3. Pick the most specific reason code from the corresponding table.
4. Send the code exactly as listed in `orders[].issue_reason` for the 202401 API.
5. Do not send FC-101 to FC-105, lower-case enum values, or codes from another category unless the endpoint reference explicitly supports them.

### Related pages
| Page | Use it for |
| --- | --- |
| [Developer dashboard](https://partner.tiktokshop.com/docv2/page/developer-dashboard) | Rule definitions for A-LOC and Risk Order incidents. |
| [Quality Engine Order Data Exchange API](https://bytedance.sg.larkoffice.com/docx/A6qMdwPC5oESvkxLuffcAVMbnLc) | API-level integration guide for exchanging order data with Quality Engine. |
| [Quality Factory Order Data Import API 202401](https://partner.tiktokshop.com/docv2/page/quality-factory-order-data-import-api-202401) | Endpoint reference for `POST /data_reconciliation/202401/orders/import`. |
| [Reason code reference](https://partner.tiktokshop.com/docv2/page/660bf931cf5cc502e03007ca) | Published reason code page. |
| [Order API overview](https://partner.tiktokshop.com/docv2/page/order-api-overview) | TikTok Shop order data used in reconciliation. |
| [Fulfillment API overview](https://partner.tiktokshop.com/docv2/page/fulfillment-api-overview) | TikTok Shop fulfillment data used in reconciliation. |
| [shipping_due_time SLA reference](https://partner.tiktokshop.com/docv2/page/sla-information-now-available-in-orders-api) | SLA field used by Quality Engine and Developer dashboard incidents. |

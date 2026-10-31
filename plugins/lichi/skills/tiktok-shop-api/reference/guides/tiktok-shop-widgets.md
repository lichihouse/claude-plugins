# Developer Guide — TikTok Shop widgets

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.



---

## TikTok Shop widgets > Overview

Doc: https://partner.tiktokshop.com/docv2/page/tts-widgets-overview · cập nhật 2026-07-06

### Widget overview
TikTok Shop widgets are frontend components provided through the Widget SDK. A widget combines TikTok Shop-hosted user interface and platform capabilities for a specific seller workflow, such as warehouse settings, shipping template setup, product optimization, or order fulfillment.
Widgets do not replace TikTok Shop Open APIs. They are useful when you want to embed a TikTok Shop-managed UI into your app, while still keeping authorization, token exchange, and integration control in your own backend.
### API vs widget
| Area | TikTok Shop Open API | TikTok Shop Widget |
| --- | --- | --- |
| Integration model | Backend-to-backend REST API integration. | Frontend SDK integration with TikTok Shop-hosted UI. |
| UI ownership | You design and maintain the seller-facing UI in your app. | TikTok Shop provides the widget UI for the supported workflow. |
| Backend work | Required for API signing, access token storage, retries, data mapping, and error handling. | Still required for authorization, access token storage, widget token generation, and backend security. |
| Frontend work | Optional, depending on your own product UI. | Required. Your frontend initializes the SDK, loads the widget, and passes a `getToken` callback. |
| Flexibility | Highest flexibility because you own the full user experience. | Faster to integrate for supported scenarios, but the widget UI itself is not customizable. |
| Best for | Full custom workflows, backend automation, and data sync. | Embedding supported TikTok Shop workflows with lower UI build effort. |

Visual reference from the source guide:
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/8e843fec729141ff9c2bcd062983cd38~tplv-k9wyc2ijk0-image.image)
### Benefits
Widgets can help developers:

* reduce frontend build effort for supported seller workflows;
* provide a TikTok Shop-consistent workflow inside a third-party app;
* reduce errors caused by missing seller-side setup, such as warehouse or shipping template configuration;
* let sellers complete selected operational steps without switching back to Seller Center.

### Integration flow
Use this flow when integrating a widget:
| Step | What to do | Main entry or owner |
| --- | --- | --- |
| 1. Browse widgets | Review available widget options and read the detail page for each widget. | **Partner Center Console > Development Kits > Widget** |
| 2. Confirm availability | Confirm that the widget supports your app type, seller market, seller type, and use case. | Widget detail page and Partner Center UI |
| 3. Configure widget | Select the app and configure widget settings. | **Development Kits > Widget > Configure**, or the app detail page |
| 4. Allowlist domains | Add the root frontend domains where the widget will be embedded. | Widget configuration page |
| 5. Build token flow | Use a seller `access_token` on your backend to call Get Widget Token, then return the short-lived widget token to the frontend. | Your backend and [Get Widget Token](https://partner.tiktokshop.com/docv2/page/get-widget-token) |
| 6. Initialize SDK | Pass the widget config and `getToken` callback to the Widget SDK. | [Widget SDK user guide](https://partner.tiktokshop.com/docv2/page/widget-sdk-user-guide) |
| 7. Test and launch | Test the widget with the correct app key, shop, market, domain, and widget name before release. | Partner Center, your staging environment, and support if needed |

Visual reference from the source guide:
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/a1a917b63a1c400da3def8a0cd80f376~tplv-k9wyc2ijk0-image.image)
### Token flow
The frontend must not call TikTok Shop Open APIs directly. Use this token chain:
| Step | Token or call | Description |
| --- | --- | --- |
| 1 | Seller authorization | The seller authorizes your app and your backend obtains a seller `access_token`. |
| 2 | `GET /authorization/202401/widget_token` | Your backend calls Get Widget Token with the seller `access_token` in the `x-tts-access-token` header. |
| 3 | `widget_token` | TikTok Shop returns a short-lived widget token, usually valid for about 5 minutes. |
| 4 | SDK `getToken` callback | Your frontend calls your backend token endpoint and returns `{ token, expire_at }` to the Widget SDK. |

Keep the App Secret, signing logic, and seller `access_token` on your backend. Only the short-lived widget token should be handed to the frontend SDK.
### Before you begin
Before integrating a widget, confirm:

* the app has been created in Partner Center;
* the seller has authorized the app and the app has the required scopes;
* the widget is enabled or available for your app and use case;
* your frontend domain is ready for widget allowlisting;
* your backend can generate signed TikTok Shop Open API requests;
* your frontend can install and initialize the Widget SDK package.

### Step 1: Browse widget options
Use **Partner Center Console > Development Kits > Widget** to browse available widgets. If an older screenshot uses **Development kits > Widget**, treat it as the same Widget entry under **Development Kits**.
For each widget, click **Learn more** or open the widget detail page to check the latest description, prerequisites, market availability, and integration guide.
| Screenshot | What it shows | How to use it |
| --- | --- | --- |
| Widget tab entry | The **Development Kits > Widget** tab where available widgets are listed. | Open this page to browse widget options and compare scenarios. |
| Widget detail entry | The widget card or detail entry with a learn-more action. | Click the detail entry to review widget prerequisites and integration instructions. |

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/2d7fb32d36704133bc10cf9a9946f613~tplv-k9wyc2ijk0-image.image)
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/765bcb50a6754ec4909bf353232d21ab~tplv-k9wyc2ijk0-image.image)
### Step 2: Configure widget settings
In **Development Kits > Widget**, check the app list and whether widget settings are enabled for each app. Click **Configure** for the target app to open the app details or widget configuration page.
You can also start widget pre-configuration from the app detail page when creating or editing an app.
| Screenshot | What it shows | How to use it |
| --- | --- | --- |
| App list and widget status | A list of apps and whether each app has enabled widgets. | Select the target app and click **Configure**. |
| Configure action | The configure button or entry point for widget settings. | Use this button to jump to the app detail or widget configuration page. |
| App detail widget setting | Widget pre-setting configuration on the app detail page. | Use this when you are creating or editing the app and need to configure widget options. |

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/8943ab9293824232bf4252c8c5f1fc61~tplv-k9wyc2ijk0-image.image)
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/e0becb76e1e54345b42494d3a75ff8af~tplv-k9wyc2ijk0-image.image)
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/913e5f9d2e924d76b6838867538342f1~tplv-k9wyc2ijk0-image.image)
### Step 3: Configure domain allowlist
Add the frontend root domain where your app will embed the widget.
Rules:

* Use your own production or staging frontend domain. Do not use placeholder domains from examples.
* Include the scheme and host, for example `https://app.example.com`.
* Do not include paths such as `/settings/widgets`.
* Configure every frontend root domain that will load the widget.
* The source guide states that up to 10 URLs can be added. If Partner Center shows a different limit, follow the live UI.

| Screenshot | What it shows | How to use it |
| --- | --- | --- |
| Domain allowlist page | Widget domain URL configuration. | Add the root frontend domains that will host the widget and save the configuration. |

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/0304ca539d2248868f29b3ba558f4899~tplv-k9wyc2ijk0-image.image)
### Step 4: Integrate and test
After widget configuration is complete:

1. Follow the widget-specific integration guide.
2. Install the Widget SDK package.
3. Implement a backend token endpoint that calls [Get Widget Token](https://partner.tiktokshop.com/docv2/page/get-widget-token).
4. Initialize the SDK with app key, shop ID, seller region, widget name, and `getToken`.
5. Test in a staging environment whose domain is already allowlisted.
6. Verify that browser errors are not caused by domain mismatch, expired widget token, app key mismatch, shop mismatch, or region mismatch.

### Widget scenarios
Widget availability can change by market, app type, seller type, and TikTok Shop enablement status. Do not rely on a copied market list such as "US" or "US and UK" as the source of truth. Confirm the current market availability in **Development Kits > Widget**, the widget detail page, or the integration material provided for your app.
| Widget | Use case | Market availability | Integration guide |
| --- | --- | --- | --- |
| Warehouse widget | Lets sellers enter or update delivery warehouse and return warehouse information, including contact, address, and sales range. This can reduce product listing failures caused by missing warehouse setup. | Confirm in Partner Center. | [Warehouse widget guide](https://partner.tiktokshop.com/docv2/page/66599ca675ead002e4e0c3fb) |
| Shipping template widget | Lets sellers set shipping templates required for seller-fulfilled listings, especially for 3PL workflows. | Confirm in Partner Center. | [Shipping template widget guide](https://partner.tiktokshop.com/docv2/page/66599c6d36f34802de23344e) |
| Product optimizer widget | Provides recommendations to improve product information quality and product performance after product sync. | Confirm in Partner Center. | [Product optimizer widget guide](https://partner.tiktokshop.com/docv2/page/66599c4236f34802de23338d) |
| Orders by TikTok Shipping widget | Helps sellers using TikTok Shipping process orders, create labels, print labels, and process shipments from the third-party app. | Confirm in Partner Center. | [Orders by TikTok Shipping widget guide](https://partner.tiktokshop.com/docv2/page/665999a9e5764002e59be4e2) |
### Widget demo screenshots
The screenshots below are retained from the source guide as visual examples. Use the live widget detail page to confirm current UI and supported markets.
| Widget | Screenshot |
| --- | --- |
| Warehouse widget | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/7407a25b6dec45318669705c9fe1e659~tplv-k9wyc2ijk0-image.image) |
| Shipping template widget | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/280f49b7ef964c38b41f83fe8e45aa0e~tplv-k9wyc2ijk0-image.image) |
| Product optimizer widget | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/8fded8be498840c39c90597662675a41~tplv-k9wyc2ijk0-image.image)    ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/fd90ebe76bc04eda9b7695eb71e3e431~tplv-k9wyc2ijk0-image.image) |
| Orders by TikTok Shipping widget | ![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/331c80590868472d9ebf9ef49eff392c~tplv-k9wyc2ijk0-image.image) |
### Related pages
| Page | Use it for |
| --- | --- |
| [Get Widget Token](https://partner.tiktokshop.com/docv2/page/get-widget-token) | Backend token exchange from seller `access_token` to short-lived `widget_token`. |
| [Widget SDK user guide](https://partner.tiktokshop.com/docv2/page/widget-sdk-user-guide) | Frontend SDK installation, initialization, `getToken`, and widget troubleshooting. |
| [Authorization guide](https://partner.tiktokshop.com/docv2/page/authorization-guide-202309) | Seller authorization and access token flow. |


---

## TikTok Shop widgets > Get widget token

Doc: https://partner.tiktokshop.com/docv2/page/get-widget-token · cập nhật 2026-07-06

### Overview
Use **Get Widget Token** to generate a short-lived `widget_token` for TikTok Shop Widget SDK integration.
The token flow is:
| Step | Actor | Token or interface | Purpose |
| --- | --- | --- | --- |
| 1 | Seller and developer backend | `access_token` | The seller authorizes the app, and the developer backend obtains an access token through the TikTok Shop authorization flow. |
| 2 | Developer backend | `GET /authorization/202401/widget_token` | The backend calls this Open API with the signed query parameters and `x-tts-access-token` header. |
| 3 | TikTok Shop Open API | `widget_token` | The API returns a short-lived widget token. It usually expires in about 5 minutes. |
| 4 | Developer backend and frontend | Developer-owned token endpoint, for example `/api/widget-token` | The backend returns the widget token to the frontend. Do not expose the seller `access_token` or App Secret to frontend code. |
| 5 | Frontend Widget SDK | `getToken` callback | The frontend SDK uses the widget token to load and call widget services. |

`access_token` and `widget_token` are different credentials. The `access_token` is used by the developer backend to call TikTok Shop Open APIs. The `widget_token` is a short-lived token passed to the Widget SDK.
### API endpoint
| Item | Value |
| --- | --- |
| API name | Get Widget Token |
| API version | `202401` |
| Host | `https://open-api.tiktokglobalshop.com` |
| Method | `GET` |
| Path | `/authorization/202401/widget_token` |
| Request body | None |
| Authentication | Signed common query parameters plus `x-tts-access-token` header |
### Domain and interface scope
Use the correct domain or interface for each part of the integration.
| Domain or interface | Use for | Called by |
| --- | --- | --- |
| `https://open-api.tiktokglobalshop.com` | TikTok Shop Open API resource server. Use this host to call `GET /authorization/202401/widget_token`. | Developer backend |
| `https://partner.tiktokshop.com` and `https://partner.us.tiktokshop.com` | Partner Center, documentation, app configuration, seller authorization entry, API Testing Tool, and support tickets. | Developers in browser / authorization flows |
| `/api/v1/seller/widget/get` | Widget SDK-side interface mentioned in the Widget SDK guide and SDK troubleshooting. Do not use it as the Open API endpoint for generating a widget token. | Widget runtime / SDK-side service |
### Request headers
| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `x-tts-access-token` | string | Yes | The seller access token obtained through the TikTok Shop authorization flow. This token must belong to the seller/shop that will use the widget. |
| `Content-Type` | string | Yes | Use `application/json`. |
### Query parameters
This API has no required business request parameters. Use only the common signed query parameters for normal calls.
| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `app_key` | string | Yes | The unique key assigned to your app in Partner Center. |
| `timestamp` | int64 | Yes | Unix timestamp in seconds. The same timestamp value must be used when generating `sign`. |
| `sign` | string | Yes | Signature generated from the request path, query parameters, request body if any, and App Secret. See [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request). |
| `shop_id` | int64 | No | Optional in the API schema, but not needed for normal calls. The seller/shop context is resolved from `x-tts-access-token`. Do not pass it unless TikTok Shop support or the API Testing Tool explicitly instructs you to do so. |
### Sample request
```Bash
curl --location --request GET 'https://open-api.tiktokglobalshop.com/authorization/202401/widget_token?app_key=<your_app_key>&timestamp=<unix_timestamp>&sign=<signature>' \
  --header 'Content-Type: application/json' \
  --header 'x-tts-access-token: <seller_access_token>'
```

### Response parameters
| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `code` | int32 | Yes | The success or failure status code returned in the API response. |
| `message` | string | Yes | Success message or failure reason. |
| `request_id` | string | Yes | Request log ID. Include this value when contacting support. |
| `data` | object | No | Response data. |
| `data.widget_token` | object | No | Widget token information. |
| `data.widget_token.token` | string | No | The short-lived token passed to the Widget SDK. |
| `data.widget_token.expire_at` | int64 | No | Expiration timestamp of the widget token. The widget token usually expires in about 5 minutes. |
### Response sample
```JSON
{
  "code": 0,
  "data": {
    "widget_token": {
      "token": "<widget_token>",
      "expire_at": 1703100448
    }
  },
  "message": "Success",
  "request_id": "202203070749000101890810281E8C70B7"
}
```

### Frontend SDK handoff
Your frontend should call your own backend endpoint to get the widget token. The backend should call TikTok Shop Open API and return only the short-lived widget token information.
```TypeScript
async function getWidgetToken() {
  const response = await fetch('/api/widget-token', {
    method: 'GET',
    credentials: 'include'
  });
  const result = await response.json();

  if (result.code !== 0) {
    throw new Error(result.message || 'Failed to get widget token');
  }

  return result.data.widget_token;
}
```

When configuring `@tiktokshop/widget-kit` or `@tiktokshop/widget-kit-react`, pass this function to the SDK `getToken` field. The frontend SDK should receive a value with `token` and `expire_at`.
### Error codes
| Error code | Error message | Meaning | Recommended action |
| --- | --- | --- | --- |
| `98001001` | `internal error` | The service failed to retrieve the authorization or shop context. | Retry with exponential backoff. If the error persists, contact TikTok Shop support with `request_id`, app key, market, timestamp, and the full response. |
| `98001004` | `Invalid param` | A required query parameter or header is missing, invalid, or inconsistent with the generated signature. | Check `app_key`, `timestamp`, `sign`, `x-tts-access-token`, `Content-Type`, endpoint path, and API version. Regenerate the signature after confirming the exact request URL. |
| `13002013` | `Seller does not exist` | The access token does not map to a valid authorized seller/shop for this API call. | Confirm that the seller has authorized the app, use the correct seller `access_token`, refresh or re-authorize if needed, and verify the authorized shop mapping with Get Authorized Shops. |

Widget SDK errors are handled separately from this Open API response. For example, `/api/v1/seller/widget/get` errors such as domain whitelist mismatch, expired widget token, invalid widget token, app key mismatch, or shop/region mismatch should be debugged in the Widget SDK integration layer.
### Testing
You can test this API in the [API Testing Tool](https://partner.tiktokshop.com/docv2/page/api-testing-tool) or with a command-line client such as cURL.
Before testing:

1. Confirm that the app is created and the App Key is correct.
2. Complete seller authorization and obtain a valid seller `access_token`.
3. Generate the `sign` value using the exact request path and query parameters.
4. Pass `x-tts-access-token` in the request header.
5. After receiving `widget_token`, verify that your frontend SDK `getToken` callback returns the object containing `token` and `expire_at`.

### Related pages
| Page | Use it for |
| --- | --- |
| [Authorization guide](https://partner.tiktokshop.com/docv2/page/authorization-guide-202309) | Seller authorization and access token flow. |
| [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request) | Signature generation rules. |
| [API Testing Tool](https://partner.tiktokshop.com/docv2/page/api-testing-tool) | Testing Open API requests in Partner Center. |
| [Widget SDK user guide](https://partner.tiktokshop.com/docv2/page/widget-sdk-user-guide) | Frontend SDK integration and `getToken` callback usage. |


---

## TikTok Shop widgets > Widget SDK user guide

Doc: https://partner.tiktokshop.com/docv2/page/widget-sdk-user-guide · cập nhật 2026-07-06

### SDK version and changelog
This guide covers the TikTok Shop Widget SDK packages:
| Package | Use case | Latest npm version | Latest npm publish time |
| --- | --- | --- | --- |
| [@tiktokshop/widget-kit](https://www.npmjs.com/package/@tiktokshop/widget-kit) | Native JavaScript integration | `1.0.4` | 2026-04-27 07:38:24 UTC |
| [@tiktokshop/widget-kit-react](https://www.npmjs.com/package/@tiktokshop/widget-kit-react) | React component integration | `1.0.4` | 2026-04-27 08:54:08 UTC |
The latest versions above were checked against the npm registry on 2026-07-06. New integrations should install the `latest` dist-tag unless your TikTok Shop integration contact asks you to pin a specific version.
```Bash
npm install @tiktokshop/widget-kit-react@latest
npm install @tiktokshop/widget-kit@latest
```

| Version | Package | Publish date | Notes |
| --- | --- | --- | --- |
| `1.0.4` | `@tiktokshop/widget-kit` | 2026-04-27 | Latest npm release. Use for new native JavaScript integrations. Detailed release notes were not included in the source document. |
| `1.0.4` | `@tiktokshop/widget-kit-react` | 2026-04-27 | Latest npm release. Use for new React integrations. Detailed release notes were not included in the source document. |
| `1.0.3` | both packages | 2024-04-08 | Published on npm. Detailed release notes were not included in the source document. |
| `1.0.2` | `@tiktokshop/widget-kit` | 2024-02-19 | Fixed issues. |
| `1.0.2` | `@tiktokshop/widget-kit-react` | 2024-02-19 | Added `WidgetConfigProvider` and `RemoteWidget` for React component integration. |
| `1.0.0` | `@tiktokshop/widget-kit` | 2023-12-22 | Initial native JavaScript SDK with `init`, `loadWidget`, `update`, and `preloadWidget`. |
| `1.0.0` | `@tiktokshop/widget-kit-react` | 2023-12-22 | Initial React SDK version. |
### Choose an integration method
Use the React package if your app is built with React. It wraps SDK initialization, config updates, preloading, and rendering in components.
Use the native JavaScript package if your app is not built with React or if you need to mount the widget manually into a DOM node.
| Scenario | Recommended package | Main APIs |
| --- | --- | --- |
| React app | `@tiktokshop/widget-kit-react` | `WidgetConfigProvider`, `RemoteWidget` |
| Non-React app | `@tiktokshop/widget-kit` | `init`, `preloadWidget`, `loadWidget`, `update` |
### Preconditions
Before integrating the Widget SDK:

1. Build a backend endpoint in your system that returns a short-lived widget token to your frontend. Your backend should call [Get Widget Token](https://partner.tiktokshop.com/docv2/page/get-widget-token), which maps to the OpenAPI path `GET /authorization/202401/widget_token`.
2. Configure your widget domain allowlist with TikTok Shop Open Platform. Widget pages have cross-origin restrictions, so the browser domain that hosts your frontend must be allowlisted.
3. Confirm the widget names enabled for your app. The SDK does not discover widget names automatically. The widget name list is provided in your widget integration documentation or by TikTok Shop Open Platform during widget enablement.
4. Keep TikTok Shop OpenAPI credentials and seller access tokens on your backend. Do not expose app secrets, seller access tokens, or signing logic in the browser.

### Configuration fields
Use explicit values from Partner Center, your seller authorization data, and your widget enablement materials. Do not leave placeholder strings such as `xxx` in production code.
| Field | Required | Example | Where to get it |
| --- | --- | --- | --- |
| `config.shopId` | Yes | `7493990753256900486` | The authorized TikTok Shop seller/shop ID in your app backend. It must match the seller access token used to request the widget token. |
| `config.oecRegion` | Yes | `US` | The seller market or region code from the authorized shop context, such as `US`, `GB`, or `ID`. |
| `config.appKey` | Yes | `6amm4vuh5fo1g` | Partner Center app details. This is the app key/client key for your TikTok Shop app. |
| `config.isvInfo.name` | Yes | `OPEN_PLATFORM` | Your ISV or developer display name in Partner Center or the integration profile shared with TikTok Shop. |
| `getToken` | Yes for initialization | `getWidgetToken` | A frontend callback that calls your backend token endpoint and returns `{ token, expire_at }`. |
| `remotes[].name` | Yes | `@tiktokshop-widget/product:optimizer` | The widget name provided by TikTok Shop Open Platform for the widget scenario enabled for your app. |
| `preloadWidgetNames` | No | `["@tiktokshop-widget/product:optimizer"]` | Widget names that should be preloaded before rendering. Use only names included in `remotes`. |
### Token flow
The frontend must not call TikTok Shop OpenAPI directly. Use this flow:

1. The frontend calls your backend endpoint, for example `GET /api/widget-token?shopId=7493990753256900486`.
2. Your backend verifies the seller session and retrieves the seller's TikTok Shop `access_token`.
3. Your backend calls TikTok Shop OpenAPI `GET /authorization/202401/widget_token` with the required `x-tts-access-token` header.
4. TikTok Shop returns `data.widget_token.token` and `data.widget_token.expire_at`.
5. Your backend returns `{ "token": "...", "expire_at": 1703100448 }` to the frontend.
6. The SDK calls `getToken` whenever it needs a valid widget token.

The internal request path `/api/v1/seller/widget/get` may appear in browser errors or screenshots because the hosted widget page calls an internal widget service. Developers should not call that internal interface directly. Implement your own `getToken` callback and backend endpoint, and have the backend call the public [Get Widget Token](https://partner.tiktokshop.com/docv2/page/get-widget-token) OpenAPI.
### Backend token endpoint example
The following example shows the shape of a backend endpoint. Replace `getSellerAccessToken` and `callTikTokShopOpenAPI` with your existing OpenAPI signing and token handling logic.
```TypeScript
import express from "express";

const app = express();

async function getSellerAccessToken(shopId: string): Promise<string> {
  // Read the seller access token from your authorization storage.
  // Do not expose this token to the browser.
  return "";
}

async function callTikTokShopOpenAPI(path: string, accessToken: string) {
  // Use the same OpenAPI base URL, signing, timestamp, and app credentials
  // that your backend uses for other TikTok Shop OpenAPI calls.
  const response = await fetch(`${process.env.TTS_OPEN_API_BASE_URL}${path}`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
      "x-tts-access-token": accessToken,
    },
  });

  return response.json();
}

app.get("/api/widget-token", async (req, res) => {
  const shopId = String(req.query.shopId ?? "");

  if (!shopId) {
    res.status(400).json({ message: "shopId is required" });
    return;
  }

  const accessToken = await getSellerAccessToken(shopId);
  const body = await callTikTokShopOpenAPI(
    `/authorization/202401/widget_token?shop_id=${encodeURIComponent(shopId)}`,
    accessToken,
  );

  const widgetToken = body?.data?.widget_token;
  if (body?.code !== 0 || !widgetToken?.token || !widgetToken?.expire_at) {
    res.status(502).json({
      message: "Failed to get widget token",
      request_id: body?.request_id,
      code: body?.code,
    });
    return;
  }

  res.json({
    token: widgetToken.token,
    expire_at: widgetToken.expire_at,
  });
});
```

### React quick start
Use `WidgetConfigProvider` once near the top of your React app. Use `RemoteWidget` where the widget should render.
```TypeScript
import { WidgetConfigProvider, RemoteWidget } from "@tiktokshop/widget-kit-react";

const widgetName = "@tiktokshop-widget/product:optimizer";

const widgetConfig = {
  shopId: "7493990753256900486",
  oecRegion: "US",
  appKey: import.meta.env.VITE_TTS_APP_KEY,
  isvInfo: {
    name: "OPEN_PLATFORM",
  },
};

async function getWidgetToken() {
  const response = await fetch(`/api/widget-token?shopId=${widgetConfig.shopId}`);
  if (!response.ok) {
    throw new Error("Failed to request widget token");
  }

  const data = await response.json();
  return {
    token: data.token,
    expire_at: data.expire_at,
  };
}

export function App() {
  return (
    <WidgetConfigProvider
      config={widgetConfig}
      getToken={getWidgetToken}
      remotes={[{ name: widgetName }]}
      preloadWidgetNames={[widgetName]}
    >
      <RemoteWidget
        name={widgetName}
        className="widget-preview-container"
        options={{}}
      />
    </WidgetConfigProvider>
  );
}
```

### Native JavaScript quick start
Call `init` once before calling `preloadWidget`, `loadWidget`, or `update`.
```TypeScript
import { init, preloadWidget, loadWidget, type WidgetComponent } from "@tiktokshop/widget-kit";

const widgetName = "@tiktokshop-widget/product:optimizer";

const widgetConfig = {
  shopId: "7493990753256900486",
  oecRegion: "US",
  appKey: import.meta.env.VITE_TTS_APP_KEY,
  isvInfo: {
    name: "OPEN_PLATFORM",
  },
};

async function getWidgetToken() {
  const response = await fetch(`/api/widget-token?shopId=${widgetConfig.shopId}`);
  if (!response.ok) {
    throw new Error("Failed to request widget token");
  }

  const data = await response.json();
  return {
    token: data.token,
    expire_at: data.expire_at,
  };
}

init({
  config: widgetConfig,
  getToken: getWidgetToken,
  remotes: [{ name: widgetName }],
});

await preloadWidget([widgetName]);

const component: WidgetComponent = await loadWidget(widgetName);
const view = component.create(document.getElementById("widget-preview-container")!);
await view.render({});
```

```HTML

```

### Preload widget
Preloading is optional. Use it when the widget is not displayed on the first screen and you want to load resources earlier.
For React, pass `preloadWidgetNames` to `WidgetConfigProvider`.
```TypeScript
<WidgetConfigProvider
  config={widgetConfig}
  getToken={getWidgetToken}
  remotes={[{ name: widgetName }]}
  preloadWidgetNames={[widgetName]}
>
  <RemoteWidget name={widgetName} options={{}} />
</WidgetConfigProvider>
```

For native JavaScript, call `preloadWidget` after `init`.
```TypeScript
import { preloadWidget } from "@tiktokshop/widget-kit";

await preloadWidget(["@tiktokshop-widget/product:optimizer"]);
```

### Load widget
For React, use `RemoteWidget`.
```TypeScript
import { RemoteWidget } from "@tiktokshop/widget-kit-react";

export function ProductOptimizerWidget() {
  return (
    <RemoteWidget
      name="@tiktokshop-widget/product:optimizer"
      className="widget-preview-container"
      options={{}}
    />
  );
}
```

For native JavaScript, call `loadWidget` after `init`.
```TypeScript
import { loadWidget, type WidgetComponent } from "@tiktokshop/widget-kit";

const component: WidgetComponent = await loadWidget("@tiktokshop-widget/product:optimizer");
const view = component.create(document.getElementById("widget-preview-container")!);
await view.render({});
```

### Update widget config
Use `update` when the current seller or shop context changes after initialization.
For React, update the props passed to `WidgetConfigProvider`.
For native JavaScript, call `update`. `getToken` is required during initialization. In `update`, pass `getToken` only if the token callback has changed.
```TypeScript
import { update } from "@tiktokshop/widget-kit";

await update({
  config: {
    shopId: "7493990753256900486",
    oecRegion: "US",
    appKey: import.meta.env.VITE_TTS_APP_KEY,
    isvInfo: {
      name: "OPEN_PLATFORM",
    },
  },
  getToken: getWidgetToken,
});
```

### Reference API - init
`init` exists in `@tiktokshop/widget-kit`. Call it once before loading or preloading widgets.
| Property | Type | Required | Sample | Description |
| --- | --- | --- | --- | --- |
| `config` | `WidgetConfig` | Yes |  | Basic widget configuration. |
| `config.shopId` | `string` | Yes | `"7493990753256900486"` | Seller or shop ID used for routing and event tracking. |
| `config.oecRegion` | `string` | Yes | `"US"` | Seller region or market code. |
| `config.appKey` | `string` | Yes | `"6amm4vuh5fo1g"` | App key/client key from Partner Center. |
| `config.isvInfo` | `object` | Yes |  | ISV information. |
| `config.isvInfo.name` | `string` | Yes | `"OPEN_PLATFORM"` | ISV or developer display name. |
| `getToken` | `() => Promise<WidgetToken>` | Yes | `getWidgetToken` | Callback that returns a short-lived widget token. |
| `remotes` | `Array<{ name: string }>` | Yes | `[{ name: "@tiktokshop-widget/product:optimizer" }]` | Widget names enabled for your app. |
### Reference API - WidgetToken
`getToken` must resolve to the token object expected by the SDK.
| Property | Type | Required | Sample | Description |
| --- | --- | --- | --- | --- |
| `token` | `string` | Yes | `"eyJhbGciOiJIUzUxMi..."` | Token used by the widget page. |
| `expire_at` | `number` | Yes | `1703100448` | Expiration timestamp. The OpenAPI response describes widget tokens as short-lived, usually about 5 minutes. |
### Reference API - loadWidget
`loadWidget` loads one widget by name.
| Package | Input | Return value | Notes |
| --- | --- | --- | --- |
| `@tiktokshop/widget-kit-react` | `name: string` | React component | Prefer `RemoteWidget` for React integrations. |
| `@tiktokshop/widget-kit` | `name: string` | `Promise<WidgetComponent>` | Use `create`, then `render`, `update`, or `unmount` on the returned view. |
```TypeScript
const component = await loadWidget("@tiktokshop-widget/product:optimizer");
const view = component.create(document.getElementById("widget-preview-container")!);
await view.render({});
```

### Reference API - update
`update` exists in `@tiktokshop/widget-kit`. Use it to update widget configuration after initialization.
| Property | Type | Required | Sample | Description |
| --- | --- | --- | --- | --- |
| `config` | `WidgetConfig` | No |  | New widget config. Required if you are changing shop, region, app key, or ISV info. |
| `getToken` | `() => Promise<WidgetToken>` | No | `getWidgetToken` | Optional for `update` if the callback has not changed. Required during initial setup. |
### Reference API - preloadWidget
`preloadWidget` exists in `@tiktokshop/widget-kit`.
| Property | Type | Required | Sample | Description |
| --- | --- | --- | --- | --- |
| `names` | `string[]` | Yes | `["@tiktokshop-widget/product:optimizer"]` | Widget names to preload. |
### Reference API - WidgetConfigProvider
`WidgetConfigProvider` exists in `@tiktokshop/widget-kit-react`. Place it above the React components that render remote widgets.
| Property | Type | Required | Sample | Description |
| --- | --- | --- | --- | --- |
| `config` | `WidgetConfig` | Yes |  | Basic widget configuration. |
| `getToken` | `() => Promise<WidgetToken>` | Yes | `getWidgetToken` | Callback that returns a short-lived widget token. |
| `remotes` | `Array<{ name: string }>` | Yes | `[{ name: "@tiktokshop-widget/product:optimizer" }]` | Widget names enabled for your app. |
| `preloadWidgetNames` | `string[]` | No | `["@tiktokshop-widget/product:optimizer"]` | Widget names to preload. |
### Reference API - RemoteWidget
`RemoteWidget` exists in `@tiktokshop/widget-kit-react`. Use it to render one enabled widget.
| Property | Type | Required | Sample | Description |
| --- | --- | --- | --- | --- |
| `name` | `string` | Yes | `"@tiktokshop-widget/product:optimizer"` | Widget name enabled for your app. |
| `className` | `string` | No | `"widget-preview-container"` | CSS class name for the widget container. |
| `style` | `CSSProperties` | No | `{ width: 100 }` | Inline style for the widget container. |
| `options` | `Record<string, any>` | No | `{}` | Props/configuration passed to the remote widget. |
### Reference API - WidgetComponent and WidgetView
These interfaces apply to native JavaScript integration.
```TypeScript
export interface WidgetComponent {
  create: (el: HTMLElement) => WidgetView;
}

export interface WidgetView {
  render: (props: Record<string, any>) => Promise<void>;
  unmount: () => Promise<void>;
  update: (props: Record<string, any>) => Promise<void>;
}
```

### Error message list
| Error message | Description | How to fix |
| --- | --- | --- |
| `Please call init first` | `preloadWidget`, `loadWidget`, or `update` was called before SDK initialization. | Call `init` first for native JavaScript, or render widgets inside `WidgetConfigProvider` for React. |
| `Current name configuration not found` | The widget name is not configured in `remotes`, or the name does not match a widget enabled for your app. | Check the widget name provided in your integration documentation, and make sure it is included in `remotes`. |
### FAQ
### FAQ - The widget page fails to load and token requests repeat
Symptom: the browser repeatedly requests a widget token and the widget page never finishes loading.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/9150f60428264983bc2309ad7c27af76~tplv-k9wyc2ijk0-image.image)
Most common causes:

* `getToken` does not return `{ token, expire_at }`.
* The backend returned the full OpenAPI response instead of `data.widget_token`.
* The token is expired.
* `shopId`, `oecRegion`, `appKey`, or the seller access token do not match.
* The frontend domain is not allowlisted for the widget.

The frontend `getToken` callback should return only the widget token object:
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/9991f878fabd45a4990736d4694b8c46~tplv-k9wyc2ijk0-image.image)
```TypeScript
async function getWidgetToken() {
  const response = await fetch(`/api/widget-token?shopId=${widgetConfig.shopId}`);
  const data = await response.json();

  return {
    token: data.token,
    expire_at: data.expire_at,
  };
}
```

### FAQ - Why do I see `/api/v1/seller/widget/get` in errors?
`/api/v1/seller/widget/get` is an internal widget service request made by the hosted widget page. It is not the public API that developers should call.
Developers should call the public OpenAPI from the backend:
| Purpose | API |
| --- | --- |
| Public API for developers to generate a widget token | `GET /authorization/202401/widget_token` |
| Internal widget page request that may appear in browser errors | `/api/v1/seller/widget/get` |
If the internal request fails, debug your public-token flow first: `getToken` output shape, token expiration, app key, shop ID, region, seller access token, and domain allowlist.
Common internal widget error codes:
| Error code | Error message | Reason |
| --- | --- | --- |
| `36017010` | `Widget domain not match` | The allowlisted domain does not match the actual frontend domain. |
| `36017005` | `Widget Token Is Expired` | The widget token has expired. |
| `36017006` | `Widget token is invalid` | The widget token is missing, malformed, or not accepted by the widget service. |
| `36017008` | `app_key is not match` | The app key does not match the token or widget configuration. |
| `36017009` | `Widget Token Shop Not Match` | The `shopId` in config does not match the shop information in the widget token. |
| `36004003` | `invalid client_key` | The app key allowlist is not configured. Provide the domain and app key to TikTok Shop Open Platform for allowlist configuration. |
| `I01008` | `Traffic is invalid` | The shop region does not match the server room. This is usually caused by mismatched `shopId` and `oecRegion`. |
### FAQ - The widget name is wrong
Symptom: the SDK reports `Current name configuration not found` or the widget page cannot be found.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/8a5f75bbb3c3452e9e10b7fe0a8b9a39~tplv-k9wyc2ijk0-image.image)
Check the widget name in the integration documentation shared for your app, then verify:

* The same widget name appears in `remotes`.
* `RemoteWidget.name`, `preloadWidgetNames`, and `loadWidget(name)` use the same exact string.
* The widget scenario is enabled for your app by TikTok Shop Open Platform.

### Related links
| Link | Use it for |
| --- | --- |
| [@tiktokshop/widget-kit on npm](https://www.npmjs.com/package/@tiktokshop/widget-kit) | Native JavaScript package version and package metadata. |
| [@tiktokshop/widget-kit-react on npm](https://www.npmjs.com/package/@tiktokshop/widget-kit-react) | React package version and package metadata. |
| [Get Widget Token](https://partner.tiktokshop.com/docv2/page/get-widget-token) | Public OpenAPI used by your backend to generate a widget token. |


---

## TikTok Shop widgets > Widget integration guide > Warehouse settings

Doc: https://partner.tiktokshop.com/docv2/page/warehouse-settings · cập nhật 2025-07-02

Available market:US&UK
#### What is the "Warehouse setting" widget?
Before listing products, the seller needs to set up the correct Warehouse/ Pickup addresses. When the seller chooses courier pickup services, TikTok Shop will retrieve this address and schedule courier pickup.
Painpoint:

* Seller may have no chance to know this information or set shipping template without logging into Seller center.
* The high failure rate of API listing products is mainly caused by not setting shipping templates

Warehouse Settings widgets can enable the Seller to enter the delivery warehouse and return warehouse information, including warehouse contact person, address, and sales range.
(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/8aa31dd80b8e4a95a9a3a38fa4252f64~tplv-k9wyc2ijk0-image.image)

#### Showcase
(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/4f6766cd54624bb1bfdced1369418c64~tplv-k9wyc2ijk0-image.image)

#### Integration demo
#### React framework
Configure preload in `WidgetConfigProvider` preloadWidgetNames, you can put `WidgetConfigProvider` to the outermost preload time
```TypeScript
import { WidgetConfigProvider,RemoteWidget } from '@tiktokshop/widget-kit-react';

const getWidgetToken = async () => {
  const res: any = await get('https://xxx/api/v1/widget/access_token', {
    outer_shop_id: 'xxx',
    partner_type: '1',
  });
  if (res?.code === 0) {
    return res?.data;
  }
  return {};
};

const initOptions = {
  config: {
    shopId: 'xxx', //seller id, such as 123456
    oecRegion: 'xxx', //country,such as US
    appKey: 'xxx', //The key corresponding to the merchant's creation service
    isvInfo: {
      name: 'xxx', //ISV name,such as OPEN_PLATFORM
    },
  },
  getToken: getWidgetToken, //get auth token
  remotes: [
    {
      name: 'xxx', //Integrated business name, provided by the open platform,such as:@tiktokshop-widget/logistics:warehouse
    },
  ],
};

export default () => {
  return (
    <WidgetConfigProvider
      config={initOptions.config}
      getToken={initOptions.getToken}
      remotes={initOptions.remotes}
      preloadWidgetNames={['@tiktokshop-widget/logistics:warehouse']}>
      <RemoteWidget
        name={'@tiktokshop-widget/logistics:warehouse'}
        className={'containerClass'}
        options={{
            onResult: (data: { code: number }) => {
              if (data.code === 0) {
                //Callback function for successful warehouse submission
              }
            },
            type: 'management',
        }} //Pass in the props required by the widget. If there are none, you don't need to pass them in.
      />
    </WidgetConfigProvider>
  );
};
```

#### Native js
```JSON
import React, { useEffect } from 'react';
import { get } from './utils/fetch';
import { loadWidget, init, WidgetComponent } from '@tiktokshop/widget-kit';

const name = '@tiktokshop-widget/logistics:warehouse';
let view = null;
export default () => {
  const getWidgetToken = async () => {
    const res: any = await get('https://xxx/api/v1/widget/access_token', {
      outer_shop_id: 'xxx',
      partner_type: '1',
    });
    if (res?.code === 0) {
      return res?.data;
    }
    return {};
  };

  const initWidget = () => {//It is recommended to initialize the widget in the outer layer and execute the preloadWidget([name]) method to preload resources.
    init({
      config: {
        shopId: 'xxx',
        oecRegion: 'US',
        appKey: 'xxx',
        isvInfo: {
          name: 'OPEN_PLATFORM',
        },
      },
      remotes: [
        {
          name,
        },
      ],
      getToken: getWidgetToken,
    });
  };
  useEffect(() => {
    initWidget();
    loadWidget(name).then((component: WidgetComponent) => {
      view = component.create(
        document.getElementById('widget-preview-container')!,
      );
      view?.render({
          onResult: (data: { code: number }) => {
              if (data.code === 0) {
                //Callback function for successful warehouse submission
              }
            },
            type: 'management',
      });
    });
    return () => {
      view?.unmount();
    };
  }, []);
  return (
    
  );
};
```

### Change log
| Release date | Update |
| --- | --- |
| 2024/2/22 | The first version is launched, providing basic functions of adding warehouse. |
### Widget SDK User Guide
[Widget SDK User Guide](widget-sdk-user-guide)


---

## TikTok Shop widgets > Widget integration guide > Product optimizer

Doc: https://partner.tiktokshop.com/docv2/page/product-optimizer · cập nhật 2025-07-02

Available market: US&UK
### What is Product optimizer Widget?
Product Optimizer leverages AI-powered recommendations to produce high-quality product information to sellers, including product names, descriptions, and images.
*Read on to learn more or check out Product Optimizer on TTS for reference [here](https://seller-us.tiktok.com/product/optimizer).
### What are the benefits of Product optimizer?
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/c1d6d3d70e0a470aaef9fb78763a5cc8~tplv-k9wyc2ijk0-image.image)
**Workflow**
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/a78f61a714ac444eb0b98b69635076f7~tplv-k9wyc2ijk0-image.image)
### Showcase
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/0edbeaf819ad4850a3efb1ccf35bbb86~tplv-k9wyc2ijk0-image.image)
### Integration demo
#### React framework
Configure preload in `WidgetConfigProvider` preloadWidgetNames, you can put `WidgetConfigProvider` to the outermost preload time
```JSON
import { WidgetConfigProvider,RemoteWidget } from '@tiktokshop/widget-kit-react';

const getWidgetToken = async () => {
  const res: any = await get('https://xxx/api/v1/widget/access_token', {
    outer_shop_id: 'xxx',
    partner_type: '1',
  });
  if (res?.code === 0) {
    return res?.data;
  }
  return {};
};

const initOptions = {
  config: {
    shopId: 'xxx', //seller id, such as 123456
    oecRegion: 'xxx', //country,such as US
    appKey: 'xxx', //The key corresponding to the merchant's creation service
    isvInfo: {
      name: 'xxx', //ISV name,such as OPEN_PLATFORM
    },
  },
  getToken: getWidgetToken, //get auth token
  remotes: [
    {
      name: 'xxx', //Integrated business name, provided by the open platform,such as:@tiktokshop-widget/product:optimizer
    },
  ],
};

export default () => {
  return (
    <WidgetConfigProvider
      config={initOptions.config}
      getToken={initOptions.getToken}
      remotes={initOptions.remotes}
      preloadWidgetNames={['@tiktokshop-widget/product:optimizer']}>
      <RemoteWidget
        name={'@tiktokshop-widget/product:optimizer'}
        className={'containerClass'}
        options={{}} //Pass in the props required by the widget. If there are none, you don't need to pass them in.
      />
    </WidgetConfigProvider>
  );
};
```

#### Native js
```JSON
import React, { useEffect } from 'react';
import { get } from './utils/fetch';
import { loadWidget, init, WidgetComponent } from '@tiktokshop/widget-kit';

const name = '@tiktokshop-widget/product:optimizer';
let view = null;
export default () => {
  const getWidgetToken = async () => {
    const res: any = await get('https://xxx/api/v1/widget/access_token', {
      outer_shop_id: 'xxx',
      partner_type: '1',
    });
    if (res?.code === 0) {
      return res?.data;
    }
    return {};
  };

  const initWidget = () => {//It is recommended to initialize the widget in the outer layer and execute the preloadWidget([name]) method to preload resources.
    init({
      config: {
        shopId: 'xxx',
        oecRegion: 'US',
        appKey: 'xxx',
        isvInfo: {
          name: 'OPEN_PLATFORM',
        },
      },
      remotes: [
        {
          name,
        },
      ],
      getToken: getWidgetToken,
    });
  };
  useEffect(() => {
    initWidget();
    loadWidget(name).then((component: WidgetComponent) => {
      view = component.create(
        document.getElementById('widget-preview-container')!,
      );
      view?.render({});
    });
    return () => {
      view?.unmount();
    };
  }, []);
  return (
    
  );
};
```

#### Integration guide
[Widget SDK User Guide](widget-sdk-user-guide)
**Tips:**

* **Provide a notification for the seller to use the product optimizer**

It's recommended to provide the capability to remind sellers to optimize their product information after syncing products. This can be done by displaying a banner/toast on the product syncing page, reminding them to improve their product details.

* **General warning informing the seller to turn off product sync by specific API fields**

A general warning can be provided to inform sellers to turn off product information(eg product title, description, image) syncing to TTS in their connector app. By doing that, any edits made to a product in a DTC platform will not be synced to TTS once this is set by the seller.

* **Enables seller to turn off the product field synchronization(eg.title, description,image)**

it is recommended for ALL connector apps to add advanced settings to allow sellers to turn off product sync by different product fields. i.e., allow sellers to turn off sync for image, description, video, and title from a DTC platform to TTS. This way, sellers can edit information in a DTC platform for other sales channels without overriding information for TTS products (as these will be optimized by a PDP optimization tool).


---

## TikTok Shop widgets > Widget integration guide > Orders by TikTok shipping(4PL)

Doc: https://partner.tiktokshop.com/docv2/page/orders-by-tiktok-shipping-4pl · cập nhật 2025-07-02

Available market: US
### What is an Orders by TikTok Shipping(4PL) Widget?
**** Enable Seller in Shopify 1P and 3P Apps to process Orders by TikTok Shipping(4PL) orders and complete fulfillment.
*Read on to learn more or check out the Orders by TikTok Shipping(4PL) widget on TTS for reference [here](https://seller-us.tiktok.com/university/essay?identity=1&role=1&knowledge_id=8706274700117762&from=feature_guide).
### Why do we build this?
Pinpoint**:** For sellers who use 3P to manage their orders, when it comes to Orders by TikTok Shipping(4PL) orders sellers need to carry out fulfillment actions in the TTS seller center, which breaks the workflow of sellers' operation in 1P/3P APP.
Solution: enables sellers to process Orders by TikTok Shipping(4PL) orders individually/in batches in the 3P APP.
### Workflow
Select orders in batches - > > create labels - > > print labels - > > process shipments
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/32be0a8919ff4f219135306cab6680b2~tplv-k9wyc2ijk0-image.image)
### Showcase
(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/c26c6aaeb38e4c24bf0cd8b812c00b5d~tplv-k9wyc2ijk0-image.image)

Tips:

* The Orders by TikTok Shipping(4PL) widget will only display Orders by TikTok Shipping(4PL) orders to the seller. It is advisable to use a clear tab name for sellers, such as "Manage Orders Fulfilled by TikTok" or "Manage TikTok Orders by TikTok Shipping(4PL) Orders."

### Integration demo
Configure preload in `WidgetConfigProvider` preloadWidgetNames, you can put `WidgetConfigProvider` to the outermost preload time
```TypeScript
import { WidgetConfigProvider,RemoteWidget } from '@tiktokshop/widget-kit-react';

const getWidgetToken = async () => {
  const res: any = await get('https://xxx/api/v1/widget/access_token', {
    outer_shop_id: 'xxx',
    partner_type: '1',
  });
  if (res?.code === 0) {
    return res?.data;
  }
  return {};
};

const initOptions = {
  config: {
    shopId: 'xxx', //seller id, such as 123456
    oecRegion: 'xxx', //country,such as US
    appKey: 'xxx', //The key corresponding to the merchant's creation service
    isvInfo: {
      name: 'xxx', //ISV name,such as OPEN_PLATFORM
    },
  },
  getToken: getWidgetToken, //get auth token
  remotes: [
    {
      name: 'xxx', //Integrated business name, provided by the open platform,such as:@tiktokshop-widget/order:manageOrders
    },
  ],
};

export default () => {
  return (
    <WidgetConfigProvider
      config={initOptions.config}
      getToken={initOptions.getToken}
      remotes={initOptions.remotes}
      preloadWidgetNames={['@tiktokshop-widget/order:manageOrders']}>
      <RemoteWidget
        name={'@tiktokshop-widget/order:manageOrders'}
        className={'containerClass'}
        options={{}} //Pass in the props required by the widget. If there are none, you don't need to pass them in.
      />
    </WidgetConfigProvider>
  );
};
```

#### Native js
```JSON
import React, { useEffect } from 'react';
import { get } from './utils/fetch';
import { loadWidget, init, WidgetComponent } from '@tiktokshop/widget-kit';

const name = '@tiktokshop-widget/order:manageOrders';
let view = null;
export default () => {
  const getWidgetToken = async () => {
    const res: any = await get('https://xxx/api/v1/widget/access_token', {
      outer_shop_id: 'xxx',
      partner_type: '1',
    });
    if (res?.code === 0) {
      return res?.data;
    }
    return {};
  };

  const initWidget = () => {//It is recommended to initialize the widget in the outer layer and execute the preloadWidget([name]) method to preload resources.
    init({
      config: {
        shopId: 'xxx',
        oecRegion: 'US',
        appKey: 'xxx',
        isvInfo: {
          name: 'OPEN_PLATFORM',
        },
      },
      remotes: [
        {
          name,
        },
      ],
      getToken: getWidgetToken,
    });
  };
  useEffect(() => {
    initWidget();
    loadWidget(name).then((component: WidgetComponent) => {
      view = component.create(
        document.getElementById('widget-preview-container')!,
      );
      view?.render({});
    });
    return () => {
      view?.unmount();
    };
  }, []);
  return (
    
  );
};
```

### Change log
| Release date | Update |
| --- | --- |
| 2024/1/22 | The first version is launched, providing basic functions of 4PL. |
### Widget SDK User Guide
[Widget SDK User Guide](widget-sdk-user-guide)


---

## TikTok Shop widgets > Widget integration guide > Tax information widget

Doc: https://partner.tiktokshop.com/docv2/page/tax-information-widget · cập nhật 2025-07-02

**Available market**
UK&US
### Widget introduction
TikTok Shop requires that all sellers complete Tax Identity Information before selling products. **US businesses/individuals** need to fill in the **W9 Form**, and **non-US businesses/individuals** need to fill in **W8 Form** information.
This widget allows sellers to complete tax information and submit this information within the app they're using without jumping to Seller Center [Account Settling >> Tax](https://seller-uk.tiktok.com/profile/account-setting/tax-information?shop_region=GB)
### Showcase
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/38995bec4b394a1e995a1ba4c7ae4608~tplv-k9wyc2ijk0-image.image)
### Integration demo
#### React framework
Configure preload in `WidgetConfigProvider` preloadWidgetNames, you can put `WidgetConfigProvider` to the outermost preload time
```JSON
import { WidgetConfigProvider,RemoteWidget } from '@tiktokshop/widget-kit-react';

const getWidgetToken = async () => {
  const res: any = await get('https://xxx/api/v1/widget/access_token', {
    outer_shop_id: 'xxx',
    partner_type: '1',
  });
  if (res?.code === 0) {
    return res?.data;
  }
  return {};
};

const initOptions = {
  config: {
    shopId: 'xxx', //seller id, such as 123456
    oecRegion: 'xxx', //country,such as US
    appKey: 'xxx', //The key corresponding to the merchant's creation service
    isvInfo: {
      name: 'xxx', //ISV name,such as OPEN_PLATFORM
    },
  },
  getToken: getWidgetToken, //get auth token
  remotes: [
    {
      name: 'xxx', //Integrated business name, provided by the open platform,such as:@tiktokshop-widget/finance:taxNumber
    },
  ],
};

export default () => {
  return (
    <WidgetConfigProvider
      config={initOptions.config}
      getToken={initOptions.getToken}
      remotes={initOptions.remotes}
      preloadWidgetNames={['@tiktokshop-widget/finance:taxNumber']}>
      <RemoteWidget
        name={'@tiktokshop-widget/finance:taxNumber'}
        className={'containerClass'}
        options={{
            onResult: (data: { code: number }) => {
              if (data.code === 0) {
                //Callback function for successful tax submission
              }
            },
        }} //Pass in the props required by the widget. If there are none, you don't need to pass them in.
      />
    </WidgetConfigProvider>
  );
};
```

#### Native js
```JSON
import React, { useEffect } from 'react';
import { get } from './utils/fetch';
import { loadWidget, init, WidgetComponent } from '@tiktokshop/widget-kit';

const name = '@tiktokshop-widget/finance:taxNumber';
let view = null;
export default () => {
  const getWidgetToken = async () => {
    const res: any = await get('https://xxx/api/v1/widget/access_token', {
      outer_shop_id: 'xxx',
      partner_type: '1',
    });
    if (res?.code === 0) {
      return res?.data;
    }
    return {};
  };

  const initWidget = () => {//It is recommended to initialize the widget in the outer layer and execute the preloadWidget([name]) method to preload resources.
    init({
      config: {
        shopId: 'xxx',
        oecRegion: 'US',
        appKey: 'xxx',
        isvInfo: {
          name: 'OPEN_PLATFORM',
        },
      },
      remotes: [
        {
          name,
        },
      ],
      getToken: getWidgetToken,
    });
  };
  useEffect(() => {
    initWidget();
    loadWidget(name).then((component: WidgetComponent) => {
      view = component.create(
        document.getElementById('widget-preview-container')!,
      );
      view?.render({
          onResult: (data: { code: number }) => {
              if (data.code === 0) {
                //Callback function for successful tax submission
              }
            },
      });
    });
    return () => {
      view?.unmount();
    };
  }, []);
  return (
    
  );
};
```

### Change log
| Release date | Update |
| --- | --- |
| 2024/2/22 | The first version is launched |
### Widget SDK User Guide
[Widget SDK User Guide](widget-sdk-user-guide)


---

## TikTok Shop widgets > Widget integration guide > Data compass widget

Doc: https://partner.tiktokshop.com/docv2/page/data-compass-widget · cập nhật 2025-07-02

**Available market**
Only US
### Introduction
This widget will help sellers better understand their shop performance, manage operations effectively, and grow their business on TikTok. The data compass widget will enable sellers to access core analytics like GMV, visitors, reviews, and product rankings.
### Showcase
(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/0962d033fc814cc4885aec307d1e5598~tplv-k9wyc2ijk0-image.image)

#### Core analysis
Sellers can monitor shop sales and traffic performance for a selected time period through six core metrics:
| Metric | Instruction |
| --- | --- |
| Shop GMV | The total amount paid for orders including state sales tax, shipping, and handling fees, but excluding discounts. |
| Shop orders | The total number of orders placed for this product. |
| Buyers | The total number of unique buyers who placed orders. |
| Avg. CTR per day | The daily average percentage of visitors who saw your product link and clicked through to your product. (Click-through rate per day/number of days within the selected period) |
| Shop visitors | The total number of unique visitors who viewed the product detail page. |
| Cancellations and returns | The number of orders that were returned and refunded within 30 days of delivery. |
| Reviews | The total number of buyer reviews during the selected period. |
| Avg. CVR per day | The daily average percentage of times unique visitors also placed an order. (Conversion rates per day/number of days within the selected period) |
#### Shop trends
This shows core metric trends. If you click Compare With the Same Period [1], you can view a comparison of trends between the current period and previous periods.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/e77f95873229473396225c2f2a95d7da~tplv-k9wyc2ijk0-image.image)
#### Products ranked by GMV
The seller can check the products Top 5 ranking list ordered by GMV, Information and indicators of products and SKUs:

* Product name/ID
* GMV
* Units sold

![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/1ebd3579c9644c0eb8bcedce59903d4d~tplv-k9wyc2ijk0-image.image)
For more detailed data on TikTok Shop, you can add an entrance for merchants to click and go to Seller Center> analysis
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/81a57952e4a5470ba47399f73e9ebade~tplv-k9wyc2ijk0-image.image)
### Integration demo
#### React framework
Configure preload in `WidgetConfigProvider` preloadWidgetNames, you can put `WidgetConfigProvider` to the outermost preload time
1: @tiktokshop-widget/compass:metricGrid
```JSON
import { WidgetConfigProvider,RemoteWidget } from '@tiktokshop/widget-kit-react';

const getWidgetToken = async () => {
  const res: any = await get('https://xxx/api/v1/widget/access_token', {
    outer_shop_id: 'xxx',
    partner_type: '1',
  });
  if (res?.code === 0) {
    return res?.data;
  }
  return {};
};

const initOptions = {
  config: {
    shopId: 'xxx', //seller id, such as 123456
    oecRegion: 'xxx', //country,such as US
    appKey: 'xxx', //The key corresponding to the merchant's creation service
    isvInfo: {
      name: 'xxx', //ISV name,such as OPEN_PLATFORM
    },
  },
  getToken: getWidgetToken,  //get auth token
  remotes: [
    {
      name: 'xxx', //Integrated business name, provided by the open platform,such as:@tiktokshop-widget/compass:metricGrid
    },
  ],
};

export default () => {
  return (
    <WidgetConfigProvider
      config={initOptions.config}
      getToken={initOptions.getToken}
      remotes={initOptions.remotes}
      preloadWidgetNames={['@tiktokshop-widget/compass:metricGrid']}>
      <RemoteWidget
        name={'@tiktokshop-widget/compass:metricGrid'}
        className={'containerClass'}
        options={{
            onClick: onHandleClick,//Control the jump event of clicking the 'More details' button inside the widget
        }} //Pass in the props required by the widget. If there are none, you don't need to pass them in.
      />
    </WidgetConfigProvider>
  );
};
```

2: @tiktokshop-widget/compass:performance
```SQL
import { WidgetConfigProvider,RemoteWidget } from '@tiktokshop/widget-kit-react';

const getWidgetToken = async () => {
  const res: any = await get('https://xxx/api/v1/widget/access_token', {
    outer_shop_id: 'xxx',
    partner_type: '1',
  });
  if (res?.code === 0) {
    return res?.data;
  }
  return {};
};

const initOptions = {
  config: {
    shopId: 'xxx', //seller id, such as 123456
    oecRegion: 'xxx', //country,such as US
    appKey: 'xxx', //The key corresponding to the merchant's creation service
    isvInfo: {
      name: 'xxx', //ISV name,such as OPEN_PLATFORM
    },
  },
  getToken: getWidgetToken, //get auth token
  remotes: [
    {
      name: 'xxx', //Integrated business name, provided by the open platform,such as:@tiktokshop-widget/compass:performance
    },
  ],
};

export default () => {
  return (
    <WidgetConfigProvider
      config={initOptions.config}
      getToken={initOptions.getToken}
      remotes={initOptions.remotes}
      preloadWidgetNames={['@tiktokshop-widget/compass:performance']}>
      <RemoteWidget
        name={'@tiktokshop-widget/compass:performance'}
        className={'containerClass'}
        options={{}} //Pass in the props required by the widget. If there are none, you don't need to pass them in.
      />
    </WidgetConfigProvider>
  );
};
```

### ShowCase
### Change log
| Release date | Update |
| --- | --- |
|  |  |
### Widget SDK User Guide
[Widget SDK User Guide](widget-sdk-user-guide)


---

## TikTok Shop widgets > Widget integration guide > Message center

Doc: https://partner.tiktokshop.com/docv2/page/message-center · cập nhật 2025-07-02

### Introduction
The Message Center widget provides sellers with a centralized location to view all updates related to the TikTok Shop, including information on violations, appeals, policies, orders, products, and more
### Benefits

* Engage sellers connected through your to view important TikTok Shop messages
* Help the seller understand policy updates and actions taken by sellers

### Integration demo
#### React framework
Configure preload in `WidgetConfigProvider` preloadWidgetNames, you can put `WidgetConfigProvider` to the outermost preload time
```TypeScript
import { WidgetConfigProvider,RemoteWidget } from '@tiktokshop/widget-kit-react';

const getWidgetToken = async () => {
  const res: any = await get('https://xxx/api/v1/widget/access_token', {
    outer_shop_id: 'xxx',
    partner_type: '1',
  });
  if (res?.code === 0) {
    return res?.data;
  }
  return {};
};

const initOptions = {
  config: {
    shopId: 'xxx', //seller id, such as 123456
    oecRegion: 'xxx', //country,such as US
    appKey: 'xxx', //The key corresponding to the merchant's creation service
    isvInfo: {
      name: 'xxx', //ISV name,such as OPEN_PLATFORM
    },
  },
  getToken: getWidgetToken, //get auth token
  remotes: [
    {
      name: 'xxx', //Integrated business name, provided by the open platform,such as:@tiktokshop-widget/message:inbox
    },
  ],
};

export default () => {
  return (
    <WidgetConfigProvider
      config={initOptions.config}
      getToken={initOptions.getToken}
      remotes={initOptions.remotes}
      preloadWidgetNames={['@tiktokshop-widget/message:inbox']}>
      <RemoteWidget
        name={'@tiktokshop-widget/message:inbox'}
        className={'containerClass'}
        options={{}} //Pass in the props required by the widget. If there are none, you don't need to pass them in.
      />
    </WidgetConfigProvider>
  );
};
```

#### Native js
```JSON
import React, { useEffect } from 'react';
import { get } from './utils/fetch';
import { loadWidget, init, WidgetComponent } from '@tiktokshop/widget-kit';

const name = '@tiktokshop-widget/message:inbox';
let view = null;
export default () => {
  const getWidgetToken = async () => {
    const res: any = await get('https://xxx/api/v1/widget/access_token', {
      outer_shop_id: 'xxx',
      partner_type: '1',
    });
    if (res?.code === 0) {
      return res?.data;
    }
    return {};
  };

  const initWidget = () => {//It is recommended to initialize the widget in the outer layer and execute the preloadWidget([name]) method to preload resources.
    init({
      config: {
        shopId: 'xxx',
        oecRegion: 'US',
        appKey: 'xxx',
        isvInfo: {
          name: 'OPEN_PLATFORM',
        },
      },
      remotes: [
        {
          name,
        },
      ],
      getToken: getWidgetToken,
    });
  };
  useEffect(() => {
    initWidget();
    loadWidget(name).then((component: WidgetComponent) => {
      view = component.create(
        document.getElementById('widget-preview-container')!,
      );
      view?.render({});
    });
    return () => {
      view?.unmount();
    };
  }, []);
  return (
    
  );
};
```

### Change log
| Release date | Update |
| --- | --- |
| 2024/2/22 | The first version is launched, providing basic functions of managing seller center messages |
### Widget SDK User Guide
[Widget SDK User Guide](widget-sdk-user-guide)


---

## TikTok Shop widgets > Widget integration guide > Return and refund

Doc: https://partner.tiktokshop.com/docv2/page/return-and-refund · cập nhật 2025-07-02

### Introduction
Return & Refund Integration can enable sellers to manage their returns and refund orders in one place. Including:

1. Check the Return & Refund orders and the reasons provided by the buyer
2. Accept or reject the buyer's request.

More information:https://seller-us.tiktok.com/university/essay?identity=1&role=1&knowledge_id=6837901778454274&from=feature_guide
### Benefits

* Inform sellers about the return and refund orders to prevent a negative impact on SLA due to unawareness.
* Offer a comprehensive fulfillment experience within your app, so sellers don't have to navigate back to the Seller Center to manage return and refund orders

### Integration demo
**Tips:**

1. Add a return& refund tab in your app for the seller to operate
2. Guide for sellers to check out the return& refund page

#### React framework
Configure preload in `WidgetConfigProvider` preloadWidgetNames, you can put `WidgetConfigProvider` to the outermost preload time
```TypeScript
import { WidgetConfigProvider,RemoteWidget } from '@tiktokshop/widget-kit-react';

const getWidgetToken = async () => {
  const res: any = await get('https://xxx/api/v1/widget/access_token', {
    outer_shop_id: 'xxx',
    partner_type: '1',
  });
  if (res?.code === 0) {
    return res?.data;
  }
  return {};
};

const initOptions = {
  config: {
    shopId: 'xxx', //seller id, such as 123456
    oecRegion: 'xxx', //country,such as US
    appKey: 'xxx', //The key corresponding to the merchant's creation service
    isvInfo: {
      name: 'xxx', //ISV name,such as OPEN_PLATFORM
    },
  },
  getToken: getWidgetToken, //get auth token
  remotes: [
    {
      name: 'xxx', //Integrated business name, provided by the open platform,such as:@tiktokshop-widget/reverse:ManageReturns
    },
  ],
};

export default () => {
  return (
    <WidgetConfigProvider
      config={initOptions.config}
      getToken={initOptions.getToken}
      remotes={initOptions.remotes}
      preloadWidgetNames={['@tiktokshop-widget/reverse:ManageReturns']}>
      <RemoteWidget
        name={'@tiktokshop-widget/reverse:ManageReturns'}
        className={'containerClass'}
      />
    </WidgetConfigProvider>
  );
};
```

#### Native js
```JSON
import React, { useEffect } from 'react';
import { get } from './utils/fetch';
import { loadWidget, init, WidgetComponent } from '@tiktokshop/widget-kit';

const name = '@tiktokshop-widget/reverse:ManageReturns';
let view = null;
export default () => {
  const getWidgetToken = async () => {
    const res: any = await get('https://xxx/api/v1/widget/access_token', {
      outer_shop_id: 'xxx',
      partner_type: '1',
    });
    if (res?.code === 0) {
      return res?.data;
    }
    return {};
  };

  const initWidget = () => {//It is recommended to initialize the widget in the outer layer and execute the preloadWidget([name]) method to preload resources.
    init({
      config: {
        shopId: 'xxx',
        oecRegion: 'US',
        appKey: 'xxx',
        isvInfo: {
          name: 'OPEN_PLATFORM',
        },
      },
      remotes: [
        {
          name,
        },
      ],
      getToken: getWidgetToken,
    });
  };
  useEffect(() => {
    initWidget();
    loadWidget(name).then((component: WidgetComponent) => {
      view = component.create(
        document.getElementById('widget-preview-container')!,
      );
      view?.render({});
    });
    return () => {
      view?.unmount();
    };
  }, []);
  return (
    
  );
};
```

### Change log
| Release date | Update |
| --- | --- |
| 2024/6/25 | The first version is launched, providing the management of return and refund orders |
### Widget SDK User Guide
[Widget SDK User Guide](widget-sdk-user-guide)


---

## TikTok Shop widgets > Widget integration guide > Shoppable video

Doc: https://partner.tiktokshop.com/docv2/page/shoppable-video · cập nhật 2025-07-02

### Widget Introduction
Compelling videos are at the heart of what drives your success on TikTok Shop. Integrating Shoppable Video hub within your app brings together a wide range of education, inspiration, AI tools, and data to help sellers quickly and easily build shoppable videos.
### What are the benefits?

* **Grow your business with Shoppable Videos:** Shoppable Video is the fastest way to drive traffic to sellers' stores on TikTok Shop. Now they can get access to our powerful Shoppable Video tools directly from the your App.
* **Build shoppable videos with** **lightspeed** **efficiency:** We've done heavy lifting for sellers'; the Content Creation tab produces your customized video in three clicks. Select the product, indicate its key selling points, and then let us handle the rest.
* **Get inspired with insights and best practices:** Check out top trending songs, hashtags, and more to see what's connecting with buyers. Sellers can also explore what shops like their shops are creating.
* **No prior experience required:** Seller can create a shoppable video with the range of tools and options available in the Shoppable Video Widget.

#### Showcase
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/e5ae4679-98bf-4ed4-85c4-4a17f6246b2f.gif)
### Integration demo
#### Description
Shoppable Video Widget including three widget which should be used together:

* @tiktokshop-widget/merchant: OverviewWidget
   * The homepage of Shoppable Videos, provides short video-related educational capabilities, helping new merchants know about short videos and how to grow with short video
* @tiktokshop-widget/merchant: InspirationWidget
   * The inspiration page of Shoppable Videos, provides short video inspiration, benchmarking accounts, trending hashtags, etc., to inspire merchants to create creative inspiration
* @tiktokshop-widget/merchant: MakeContentWidget
   * The content tools page of Shoppable Videos, provides creative production tools to lower the production barrier and help sellers produce short videos easily

The common parameters of the three widgets are:

* handleTabChange
   * Type
   ```TypeScript
      type HandleTabChangeType = (
          tabKey:
            | 'sv_overview'
            | 'sv_get_inspired'
            | 'sv_create_content'
            | 'product_list',
          options?: Record<string, any>,
      )=>void;
   ```

   * Description: Inside the shoppable video widget, there is a jump behavior between multiple widgets. Here, the callback function is used to help developers get the jump event and its parameters in the page.
* Options
   * Type
   ```TypeScript
       {
           pathname?: string;
           search?: string;
       }
   ```

   * Description: The three widgets jump to each other, and each widget has a route inside. So when jumping between widgets, in order to locate the correct route after the jump, some parameters need to be carried through options.
* example
   ```TypeScript
   function Demo(){
       const optionRef = useRef<any>();
       const [visibleWidget,setVisibleWidget] = useState<string>('sv_get_inspired');
       
       return <>
           {visibleWidget === 'sv_get_inspired'?<RemoteWidget 
               name={'@tiktokshop-widget/merchant:InspirationWidget'}
               options={{
                   handleTabChange(tabKey,options){
                       if(tabKey==='product_list'){
                           // Jump to product list page
                       }else if(tabKey==='sv_overview'){
                           // Open OverviewWidget
                           optionRef.current = options;
                           setVisibleWidget(tabKey);
                       }
                   }
               }} 
           />:null}
           {visibleWidget === 'sv_overview' ? <RemoteWidget 
               name={'@tiktokshop-widget/merchant:OverviewWidget'}
               options={{
                   options:optionRef.current
               }} 
           />:null}
       </>
   }
   ```

#### React framework
Configure preload in `WidgetConfigProvider` preloadWidgetNames, you can put `WidgetConfigProvider` to the outermost preload time
```TypeScript
import { WidgetConfigProvider,RemoteWidget } from '@tiktokshop/widget-kit-react';

const getWidgetToken = async () => {
  const res: any = await get('https://xxx/api/v1/widget/access_token', {
    outer_shop_id: 'xxx',
    partner_type: '1',
  });
  if (res?.code === 0) {
    return res?.data;
  }
  return {};
};

const initOptions = {
  config: {
    shopId: 'xxx', //seller id, such as 123456
    oecRegion: 'xxx', //country,such as US
    appKey: 'xxx', //The key corresponding to the merchant's creation service
    isvInfo: {
      name: 'xxx', //ISV name,such as OPEN_PLATFORM
    },
  },
  getToken: getWidgetToken, //get auth token
  remotes: [
    {
      name: '@tiktokshop-widget/merchant:OverviewWidget',
    },
    {
      name: '@tiktokshop-widget/merchant:InspirationWidget',
    },
    {
      name: '@tiktokshop-widget/merchant:MakeContentWidget',
    },
  ],
};

export default () => {
  const [currentWidget,setCurrentWidget] = useState('sv_overview');
  const optionRef = useRef<any>(undefined);
  const tempOptionRef = useRef<any>(undefined);

  useEffect(()=>{
      return ()=>{
          optionRef.current = tempOptionRef.current;
          tempOptionRef.current = undefined;
      }
  },[currentWidget]);
  
  const widgetParams = useMemo()=>({
      handleTabChange: (
        tabKey:
          | 'sv_overview'
          | 'sv_get_inspired'
          | 'sv_create_content'
          | 'product_list',
        options?: Record<string, any>,
      ) => {
          if(tabKey ==='product_list'){
              // open TikTok Shop list page
          }else{
              tempOptionRef.current = options;
              setCurrentWidget(tabKey);
          }
      },
      options: optionRef.current
  }),[currentWidget,optionRef])

  return (
    <WidgetConfigProvider
      config={initOptions.config}
      getToken={initOptions.getToken}
      remotes={initOptions.remotes}
      preloadWidgetNames={[
          '@tiktokshop-widget/merchant:OverviewWidget',
          '@tiktokshop-widget/merchant:InspirationWidget',
          '@tiktokshop-widget/merchant:MakeContentWidget'
      ]}>
        {currentWidget === 'sv_overview' && <RemoteWidget
            name={'@tiktokshop-widget/merchant:OverviewWidget'}
            options={widgetParams}
        />}
        {currentWidget === 'sv_get_inspired' && <RemoteWidget
            name={'@tiktokshop-widget/merchant:InspirationWidget'}
            options={widgetParams}
        />}
        {currentWidget === 'sv_create_content' && <RemoteWidget
            name={'@tiktokshop-widget/merchant:MakeContentWidget'}
            options={widgetParams}
        />}
    </WidgetConfigProvider>
  );
};
```

#### Native js
```JSON
import React, { useEffect } from 'react';
import { get } from './utils/fetch';
import { loadWidget, init, WidgetComponent } from '@tiktokshop/widget-kit';

let view = null;

const getWidgetToken = async () => {
    const res: any = await get('https://xxx/api/v1/widget/access_token', {
        outer_shop_id: 'xxx',
        partner_type: '1',
    });
    if (res?.code === 0) {
        return res?.data;
    }
    return {};
};

const initWidget = () => {//It is recommended to initialize the widget in the outer layer and execute the preloadWidget([name]) method to preload resources.
init({
    config: {
        shopId: 'xxx',
        oecRegion: 'US',
        appKey: 'xxx',
        isvInfo: {
            name: 'OPEN_PLATFORM',
        },
    },
    remotes: [
        {
            name: '@tiktokshop-widget/merchant:OverviewWidget',
        },
        {
            name: '@tiktokshop-widget/merchant:InspirationWidget',
        },
        {
            name: '@tiktokshop-widget/merchant:MakeContentWidget',
        },
    ],
    getToken: getWidgetToken,
    });
};

const widgetNameMap = {
    'sv_overview': '@tiktokshop-widget/merchant:OverviewWidget',
    'sv_get_inspired': '@tiktokshop-widget/merchant:InspirationWidget',
    'sv_create_content': '@tiktokshop-widget/merchant:MakeContentWidget'
}

export default () => {
  const [currentWidget,setCurrentWidget] = useState('sv_overview');
  const optionRef = useRef<any>(undefined);
  const tempOptionRef = useRef<any>(undefined);

  useEffect(() => {
    initWidget();
  }, []);
  
  const widgetParams = useMemo()=>({
      handleTabChange: (
        tabKey:
          | 'sv_overview'
          | 'sv_get_inspired'
          | 'sv_create_content'
          | 'product_list',
        options?: Record<string, any>,
      ) => {
          if(tabKey ==='product_list'){
              // open TikTok Shop list page
          }else{
              tempOptionRef.current = options;
              setCurrentWidget(tabKey);
          }
      },
      options: optionRef.current
  }),[currentWidget,optionRef])
  
  useEffect(()=>{
      if(!currentWidget || !widgetNameMap[currentWidget])return
      loadWidget(widgetNameMap[currentWidget]).then((component: WidgetComponent) => {
          view = component.create(
            document.getElementById('widget-preview-container')!,
          );
          view?.render(widgetParams);
      });
      return ()=>{
          optionRef.current = tempOptionRef.current;
          tempOptionRef.current = undefined;
          view?.unmount();
      } 
  },[currentWidget])
  
  return (
    
  );
};
```

### Change log
| Release date | Update |
| --- | --- |
| 2024/8/5 | The first version is launched, provide the basic functions of shoppable video center |
| 2024/8/15 | Add event tracking & fix campaign banner style. |
### Widget SDK User Guide
Refer to [Widget SDK User Guide](widget-sdk-user-guide).


---

## TikTok Shop widgets > Widget integration guide > Responsible Person and Manufacturer Widget

Doc: https://partner.tiktokshop.com/docv2/page/responsible-person-and-manufacturer-widget · cập nhật 2025-07-02

### Background
In the EU market, when listing products, sellers are required to provide compliance information and upload the relevant product compliance certifications, which include:
**Manufacturer Information:** the manufacturer of the product
> Refers to the details about the production process, location, and entities responsible for product manufacturing. All products must contain labels with the manufacturer's contact details and, if relevant, the importer's information. This information must be visible on physical products and in the product's online listings.

**Responsible Person (RP):** the responsible person who ensures a seller's products comply with EU regulations.
> For any non-food products, it is essential to have a Responsible Person based within the EU. This person is a point of contact for customers and can communicate with regulatory bodies on behalf of the business about product safety matters. Products should be labeled with this person's contact information in a language that can be easily understood by consumers, as determined by the Member State in which the product is made available on the market.

### Widget Introduction
#### Responsible Person information
**Summary:** This widget includes the capability of RP stock query, RP addition, and RP editing.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/ftgeh7fkuht/RPgif01.gif)
#### Manufacturer information
**Summary:** This widget includes the capability of Manufacturer stock query, Manufacturer addition, and Manufacturer editing.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/ftgeh7fkuht/MIgif02.gif)
### How to integrate
Configure preload in `WidgetConfigProvider` preloadWidgetNames, you can put `WidgetConfigProvider` to the outermost preload time
#### Integrate with the Responsible Person information widget
React framework
```TypeScript
import { WidgetConfigProvider,RemoteWidget } from '@tiktokshop/widget-kit-react';

const getWidgetToken = async () => {
  const res: any = await get('https://xxx/api/v1/widget/access_token', {
    outer_shop_id: 'xxx',
    partner_type: '1',
  });
  if (res?.code === 0) {
    return res?.data;
  }
  return {};
};

const name = "@tiktokshop-widget/qualification:rp";

const initOptions = {
  config: {
    shopId: 'xxx', //seller id, such as 123456
    oecRegion: 'xxx', //country,such as US
    appKey: 'xxx', //The key corresponding to the merchant's creation service
    isvInfo: {
      name: 'xxx', //ISV name,such as OPEN_PLATFORM
    },
  },
  getToken: getWidgetToken, //get auth token
  remotes: [
    {
      name: name, //Integrated business name, provided by the open platform,such as:@tiktokshop-widget/reverse:ManageReturns
    },
  ],
};

export default () => {
  return (
    <WidgetConfigProvider
      config={initOptions.config}
      getToken={initOptions.getToken}
      remotes={initOptions.remotes}
      preloadWidgetNames={[name]}>
      <RemoteWidget
        name={name}
        className={'containerClass'}
      />
    </WidgetConfigProvider>
  );
};
```

Native js
```JSON
import React, { useEffect } from 'react';
import { get } from './utils/fetch';
import { loadWidget, init, WidgetComponent } from '@tiktokshop/widget-kit';

const name = '@tiktokshop-widget/qualification:rp';
let view = null;
export default () => {
  const getWidgetToken = async () => {
    const res: any = await get('https://xxx/api/v1/widget/access_token', {
      outer_shop_id: 'xxx',
      partner_type: '1',
    });
    if (res?.code === 0) {
      return res?.data;
    }
    return {};
  };

  const initWidget = () => {//It is recommended to initialize the widget in the outer layer and execute the preloadWidget([name]) method to preload resources.
    init({
      config: {
        shopId: 'xxx',
        oecRegion: 'US',
        appKey: 'xxx',
        isvInfo: {
          name: 'OPEN_PLATFORM',
        },
      },
      remotes: [
        {
          name,
        },
      ],
      getToken: getWidgetToken,
    });
  };
  useEffect(() => {
    initWidget();
    loadWidget(name).then((component: WidgetComponent) => {
      view = component.create(
        document.getElementById('widget-preview-container')!,
      );
      view?.render({});
    });
    return () => {
      view?.unmount();
    };
  }, []);
  return (
    
  );
};
```

#### Integrate with the Manufacturer information widget
React framework
```TypeScript
import { WidgetConfigProvider,RemoteWidget } from '@tiktokshop/widget-kit-react';

const getWidgetToken = async () => {
  const res: any = await get('https://xxx/api/v1/widget/access_token', {
    outer_shop_id: 'xxx',
    partner_type: '1',
  });
  if (res?.code === 0) {
    return res?.data;
  }
  return {};
};

const name = "@tiktokshop-widget/qualification:mf";

const initOptions = {
  config: {
    shopId: 'xxx', //seller id, such as 123456
    oecRegion: 'xxx', //country,such as US
    appKey: 'xxx', //The key corresponding to the merchant's creation service
    isvInfo: {
      name: 'xxx', //ISV name,such as OPEN_PLATFORM
    },
  },
  getToken: getWidgetToken, //get auth token
  remotes: [
    {
      name: name, //Integrated business name, provided by the open platform,such as:@tiktokshop-widget/reverse:ManageReturns
    },
  ],
};

export default () => {
  return (
    <WidgetConfigProvider
      config={initOptions.config}
      getToken={initOptions.getToken}
      remotes={initOptions.remotes}
      preloadWidgetNames={[name]}>
      <RemoteWidget
        name={name}
        className={'containerClass'}
      />
    </WidgetConfigProvider>
  );
};
```

Native js
```JSON
import React, { useEffect } from 'react';
import { get } from './utils/fetch';
import { loadWidget, init, WidgetComponent } from '@tiktokshop/widget-kit';

const name = '@tiktokshop-widget/qualification:mf';
let view = null;
export default () => {
  const getWidgetToken = async () => {
    const res: any = await get('https://xxx/api/v1/widget/access_token', {
      outer_shop_id: 'xxx',
      partner_type: '1',
    });
    if (res?.code === 0) {
      return res?.data;
    }
    return {};
  };

  const initWidget = () => {//It is recommended to initialize the widget in the outer layer and execute the preloadWidget([name]) method to preload resources.
    init({
      config: {
        shopId: 'xxx',
        oecRegion: 'US',
        appKey: 'xxx',
        isvInfo: {
          name: 'OPEN_PLATFORM',
        },
      },
      remotes: [
        {
          name,
        },
      ],
      getToken: getWidgetToken,
    });
  };
  useEffect(() => {
    initWidget();
    loadWidget(name).then((component: WidgetComponent) => {
      view = component.create(
        document.getElementById('widget-preview-container')!,
      );
      view?.render({});
    });
    return () => {
      view?.unmount();
    };
  }, []);
  return (
    
  );
};
```

### Change log
| Release date | Update |
| --- | --- |
| 2024/10/16 | RP widget: first version launched, includes the capability of RP stock query, RP addition, and RP editing.Manufacturer: first version launched, Manufacturer stock query, Manufacturer addition, Manufacturer editing. |
### Widget SDK User Guide
[Widget SDK User Guide](widget-sdk-user-guide)

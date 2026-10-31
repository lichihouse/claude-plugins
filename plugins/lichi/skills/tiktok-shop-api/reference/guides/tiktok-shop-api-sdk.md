# Developer Guide — TikTok Shop API SDK

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.



---

## TikTok Shop API SDK > Overview

Doc: https://partner.tiktokshop.com/docv2/page/tts-api-sdk-overview · cập nhật 2026-07-06

TikTok Shop API SDKs help the backend of your TikTok Shop app call TikTok Shop APIs with less integration work. They generate request clients and handle common request authentication steps, so you do not need to implement the signing flow for every supported API call yourself.
### Availability
The API SDK download page is available from Partner Center for developers who have an effective TikTok Shop app. To download a useful SDK package, sign in with the developer account that owns or manages the app, then confirm the effective apps and API access scopes shown on the SDK page.
Use the SDK download page as the source of truth for account-specific access. If the API SDK entry is not visible for your account, first confirm that you have created a TikTok Shop app and enabled the API scopes required by your integration. If the entry is still unavailable, contact Partner Center support or your TikTok Shop partner manager.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/TTSPC_API_SDK/81b2df68-85e8-4ded-8225-59e4f9a3063b.png)
### Supported Languages and Versions
The SDKs currently support Java, Go, and Node.js. SDK packages are generated based on your effective apps, approved API scopes, selected language, and available API versions, so there may not be a single global "latest SDK version" that applies to every developer.
Before integrating or updating an SDK, confirm the language, SDK version, generation time, included apps, and included API scopes on the [API SDK download page](https://partner.tiktokshop.com/openlearn/api-sdk). If you need newly approved scopes, newly released APIs, or SDK framework updates, see [Update SDK](https://partner.tiktokshop.com/docv2/page/update-sdk).
| Language | Latest SDK version to use | Supported API versions |
| --- | --- | --- |
| Java | Use the version shown on the SDK download page or in the downloaded package files such as `pom.xml` or `build.gradle`. Replace placeholder values such as `1.0.0` in examples with that downloaded version. | The API versions included in your downloaded package. The Java guide examples include versioned clients such as `AuthorizationV202309Api` and `ProductV202502Api`. |
| Go | Use the module version generated in the downloaded SDK package. Replace placeholder values such as `v1.0.0` with the version from your package. | The API versions included in your downloaded package. The Go guide examples include versioned clients such as `AuthorizationV202502API` and `ProductV202502API`. |
| Node.js | Use the generated Node.js SDK package or folder from the SDK download page. Do not assume example dependency versions are the latest SDK package version. | The API versions included in your downloaded package. The Node.js guide examples include versioned clients such as `AuthorizationV202309Api` and `ProductV202502Api`. |
### Choose SDK or Manual Signing
Use the SDK when you are integrating in Java, Go, or Node.js and the API you need is included in the generated SDK package. The SDK is the preferred path for routine API calls because it reduces repetitive request construction and signing work.
Use manual signing when you call TikTok Shop APIs from another language, use a custom HTTP client that does not use the SDK, debug raw HTTP requests, or call an API that is not included in your generated SDK package. For the signing algorithm and language samples, see [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request).
### Webhook Configuration
The API SDK is for making TikTok Shop API requests. It does not replace your webhook configuration or webhook listener implementation. Configure webhook callback URLs and event subscriptions in Partner Center or through the Events API, then implement your own HTTPS endpoint to receive and process webhook events.
For webhook setup, see the [configuration guide](https://partner.tiktokshop.com/docv2/page/configuration-guide). For Events API references, see [Get Shop Webhooks](https://partner.tiktokshop.com/docv2/page/get-shop-webhooks) and [Update Shop Webhook](https://partner.tiktokshop.com/docv2/page/update-shop-webhook).
### Integration Guides
Use the language-specific guide that matches the SDK package you downloaded:
| Language | Integration guide | Minimum environment from the guide |
| --- | --- | --- |
| Java | [Integrate Java SDK](https://partner.tiktokshop.com/docv2/page/integrate-java-sdk) | Java 1.8+; Maven 3.8.3+ or Gradle 7.2+ |
| Go | [Integrate GoLang SDK](https://partner.tiktokshop.com/docv2/page/integrate-golang-sdk) | Go 1.18+ |
| Node.js | [Integrate Node.js SDK](https://partner.tiktokshop.com/docv2/page/integrate-nodejs-sdk) | Node.js 16+ |
### Download and Update Flow

1. Create a TikTok Shop app and configure the API scopes required by your integration.
2. Open [API SDK](https://partner.tiktokshop.com/openlearn/api-sdk) in Partner Center.
3. Review the effective apps and combined API access scopes included in the generated SDK.
4. Select Java, Go, or Node.js and confirm the SDK version and generation time shown on the page.
5. Download the SDK package and integrate it by following the matching language guide.
6. When scopes, API versions, or SDK framework support change, follow [Update SDK](https://partner.tiktokshop.com/docv2/page/update-sdk) and download the regenerated package.

### Related Pages
| Page | Use it for |
| --- | --- |
| [Download SDK](https://partner.tiktokshop.com/docv2/page/download-sdk) | Find the SDK download entry and confirm effective apps, scopes, language, version, and generation time. |
| [Update SDK](https://partner.tiktokshop.com/docv2/page/update-sdk) | Understand SDK regeneration triggers, daily generation, and manual update checks. |
| [Create your App](https://partner.tiktokshop.com/docv2/page/create-your-app) | Create an app and configure app type, scopes, redirect URL, webhook URL, app key, and app secret. |
| [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token) | Generate an access token before making SDK calls against seller or shop data. |
| [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request) | Implement request signing manually when the SDK is not the right fit. |
| [Configuration guide](https://partner.tiktokshop.com/docv2/page/configuration-guide) | Configure webhook callback URLs and event subscriptions. |


---

## TikTok Shop API SDK > Download SDK

Doc: https://partner.tiktokshop.com/docv2/page/download-sdk · cập nhật 2026-07-06

### Overview
Use this page when you need to download a TikTok Shop Open API SDK for the first time.
TikTok Shop SDK packages are generated from the effective apps and API access scopes available to your Partner Center account. The SDK package can differ by app, language, API version, and scope set. Always confirm the app list, scope list, language, SDK version, and generation time on the SDK download page before adding the SDK to your project.
### Before you download
Follow this sequence for a first-time integration:
| Step | Required before download? | Required before making SDK API calls? | What to do |
| --- | --- | --- | --- |
| Create a TikTok Shop app | Yes | Yes | Create the app and configure basic app information. See [Create your App](https://partner.tiktokshop.com/docv2/page/create-your-app) or [Create a TikTok Shop app OAuth client](https://partner.tiktokshop.com/docv2/page/create-tts-app-oauth-client). |
| Configure API scopes | Yes, if the SDK should include those API domains | Yes | In **App & Service > Manage > Manage API**, enable or apply for the API scopes required by your integration. |
| Download SDK | Yes | Yes | Download the generated SDK package for your selected language from the SDK download page. |
| Create a test seller account or use an authorized seller | No | Yes | For test calls, create a test seller account or use an eligible seller account. See [Create a test seller account](https://partner.tiktokshop.com/docv2/page/create-test-seller-account). |
| Obtain an access token | No | Yes | Complete seller authorization and exchange the authorization code for an `access_token`. See [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token). |

The difference is intentional: app creation and scope configuration are required to generate a useful SDK package; a test seller account and access token are required when you actually run SDK calls that access seller or shop data.
### SDK download entry
Open the SDK download page from Partner Center:
| Entry type | Path or URL |
| --- | --- |
| Partner Center path | **Partner Center Console > Development Kits > API SDK** or the equivalent SDK download entry shown in your Partner Center navigation. |
| Direct URL | [https://partner.tiktokshop.com/openlearn/api-sdk](https://partner.tiktokshop.com/openlearn/api-sdk) |

If your Partner Center UI uses a slightly different label, search for **API SDK** or **SDK** under **Development Kits**. Avoid mixing this entry with **App & Service > Manage API**, which is used to configure API scopes rather than download SDK packages.
### Download steps

1. Sign in to Partner Center with the developer account that owns or manages the app.
2. Open **Development Kits > API SDK**.
3. Review the effective apps shown on the page.
4. Review the combined API access scopes included in the generated SDK.
5. Select the SDK language you plan to integrate, such as Java, Go, or Node.js if those options are available on the page.
6. Check the SDK version and generation time shown for that language.
7. Download the SDK package.
8. Store the downloaded package version, generation time, app key, language, and scope set in your project release notes so future SDK updates are traceable.

### Screenshot reference
The screenshot below is retained from the source guide. Use it together with the text steps above.
| Screenshot | What to look for | Action |
| --- | --- | --- |
| SDK download page | Effective apps, combined API access scopes, language selector or language tabs, SDK version/generation time, and download button. | Confirm the SDK includes the APIs and scopes you need, then download the package for your project language. |

![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/TTSPC_API_SDK/download_sdk.PNG)
### Language and version selection
The SDK download page is the source of truth for the currently available SDK languages and package versions.
The language-specific integration guides currently cover:
| Language | Minimum environment from the integration guide | Version guidance |
| --- | --- | --- |
| Java | Java 1.8+; Maven 3.8.3+ or Gradle 7.2+ | Replace placeholder versions such as `1.0.0` with the SDK version shown on the download page. |
| Go | Go 1.18+ | Use the module path and version generated in the downloaded SDK package. |
| Node.js | Use a supported Node.js LTS release for new integrations. | Use the generated package or folder from the download page. Do not assume examples with placeholder versions are the latest package. |

There may not be a single global "latest SDK version" for all developers. SDK packages are generated based on your effective app, language, API scopes, and API versions. If the SDK page shows a version number or generation timestamp, use that value for your project records.
### Scope coverage
The SDK includes APIs from the combined API access scopes of your effective apps. Before downloading, confirm that the scopes shown on the page match the APIs your integration needs.
| Scope type | Meaning | What to check |
| --- | --- | --- |
| Public API scope | A standard API scope available to eligible developers after app setup and seller authorization. | Enable or apply for it in **App & Service > Manage > Manage API**, then confirm it appears in the SDK scope list. |
| Private API scope | A restricted scope granted only after TikTok Shop approval, invitation, market/category enablement, or partner-specific access. It may not be visible to all developers. | If your integration requires a private scope, follow the application path shown in Partner Center or contact your Partner Center support/partner manager. After approval, confirm the private scope appears in the effective scope list before downloading the SDK. |

Adding a new scope after the SDK is downloaded does not update your existing local SDK automatically. Confirm the new scope is approved, ask sellers to reauthorize if the new permission requires seller consent, then download the regenerated SDK.
### Download vs update
This page covers first-time SDK download. Use [Update SDK](https://partner.tiktokshop.com/docv2/page/update-sdk) when you already have an SDK integrated and need to refresh it.
| Page | Use it for |
| --- | --- |
| Download SDK | Find the SDK page, confirm effective apps and scopes, select a language, and download the SDK package for the first integration. |
| Update SDK | Understand when SDKs are regenerated, when to click **check for updates**, how daily generation works, and how to migrate an existing project. |
### Troubleshooting
| Symptom | Likely cause | What to do |
| --- | --- | --- |
| Expected API is missing from the SDK | The required API scope is not enabled or approved for the effective app. | Check **App & Service > Manage > Manage API** and compare it with the SDK scope list. |
| Newly approved scope is not in the downloaded SDK | The SDK package has not been regenerated yet. | Wait for daily generation or use **check for updates** on the SDK page if available. |
| Seller API call fails even though the SDK contains the method | The seller has not authorized the required scope, or the token does not include it. | Complete seller authorization or reauthorization and check `granted_scopes` in the token response. |
| Language version in the example does not match your package | The example uses a placeholder or older version. | Use the SDK version and package structure shown in the downloaded package. |
### Related pages
| Page | Use it for |
| --- | --- |
| [Update SDK](https://partner.tiktokshop.com/docv2/page/update-sdk) | Regeneration triggers, manual update checks, and migration steps. |
| [Create your App](https://partner.tiktokshop.com/docv2/page/create-your-app) | App creation, app type selection, scopes, redirect URL, and app credentials. |
| [Create a TikTok Shop app OAuth client](https://partner.tiktokshop.com/docv2/page/create-tts-app-oauth-client) | OAuth client setup for authorization code and token exchange. |
| [Create a test seller account](https://partner.tiktokshop.com/docv2/page/create-test-seller-account) | Test seller account setup before making SDK API calls. |
| [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token) | Access token generation for testing SDK calls. |
| [Access scope](https://partner.tiktokshop.com/docv2/page/access-scope) | Scope concepts and access management. |

#### Prerequisites
If you are a developer who has developed Apps for TikTok Shop, you can download TikTok Shop API SDK on the [TikTok Shop Partner Center console](https://partner.tiktokshop.com/openlearn/api-sdk).
If you are a developer new to TikTok Shop, you must [create a TikTok Shop App](create-tts-app-oauth-client) before downloading the SDK on the [console](https://partner.tiktokshop.com/openlearn/api-sdk).
#### Download SDK
The SDK includes APIs of the combined collection of access scopes corresponding to your effective apps. The effective apps and combined access scopes, private API scopes included, are listed on the page. Confirm the API access scopes included in the SDK before downloading the SDK.
![Image](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ%5B%5B/ljhwZthlaukjlkulzlp/Developer_Guide/TTSPC_API_SDK/download_sdk.PNG)


---

## TikTok Shop API SDK > Integrate Java SDK

Doc: https://partner.tiktokshop.com/docv2/page/integrate-java-sdk · cập nhật 2026-07-06

### What this guide covers
This guide shows how to install the TikTok Shop Java SDK and make a first API call using [Search Products](https://partner.tiktokshop.com/docv2/page/search-products-202309) as the example.
Before you start, create a test seller account and authorize your app. For guidance, refer to [Create a test seller account](https://partner.tiktokshop.com/docv2/page/create-test-seller-account) and [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token).
### SDK version and update note
TikTok Shop SDK packages are generated for your app, language, and effective API scope set. Do not assume the placeholder version `1.0.0` is always the latest version.
Use the SDK version shown on the SDK download page or in the downloaded SDK package, such as the version in the generated `pom.xml`. If you update scopes, API versions, or the SDK framework, regenerate and download the SDK again. For the update flow, refer to [Update SDK](https://partner.tiktokshop.com/docv2/page/update-sdk).
### SDK signing and access tokens
For SDK API classes such as `ProductV202502Api`, the SDK signs OpenAPI requests after you configure `appKey`, `appSecret`, and `basePath` on `ApiClient`.
The SDK does not replace OAuth authorization. You still need to:

* Obtain an authorization code from the seller authorization flow.
* Exchange the authorization code for an `access_token` and `refresh_token`.
* Store and refresh tokens securely on your server.
* Pass the current seller `access_token` to SDK API calls through the `x-tts-access-token` parameter.

If you call TikTok Shop OpenAPI without the SDK, follow [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request) to generate the request signature yourself.
### Environment
Ensure your project meets all of the following conditions:

* Java 1.8+
* Maven 3.8.3+ or Gradle 7.2+

### Installation for Maven

1. Unzip the downloaded SDK package to obtain the source code.
2. In the SDK source directory, run:

```Bash
mvn clean install
```

1. Add the SDK dependency to your project's `pom.xml`. Replace `${tts.sdk.version}` with the version shown in the SDK package or on the SDK download page.

```XML

  <tts.sdk.version>VERSION_FROM_DOWNLOADED_SDK</tts.sdk.version>

<dependencies>
  <dependency>
    <groupId>com.tiktokshop</groupId>
    <artifactId>open-sdk-java</artifactId>
    <version>${tts.sdk.version}</version>
    <scope>compile</scope>
  </dependency>
</dependencies>
```

1. In your project, run:

```Bash
mvn clean install
```

### Installation for Gradle
Add the SDK dependency to `build.gradle`. Replace `VERSION_FROM_DOWNLOADED_SDK` with the version shown in the SDK package or on the SDK download page.
```Groovy
repositories {
    mavenCentral()
    mavenLocal()
}

dependencies {
    implementation "com.tiktokshop:open-sdk-java:VERSION_FROM_DOWNLOADED_SDK"
}
```

### Manual JAR installation
If you do not use Maven or Gradle, generate the JAR by running:
```Bash
mvn clean package
```

Then manually install the generated SDK JAR and dependency JARs:

* `target/open-sdk-java-VERSION_FROM_DOWNLOADED_SDK.jar`
* `target/lib/*.jar`

### API version note for Get Authorized Shops
`shop_cipher` is required by APIs such as Search Products. To get `shop_cipher`, call [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309).
Use the newest supported Get Authorized Shops API version that is actually generated in your downloaded SDK. Some language SDK guides may show a newer generated class, such as Go's `AuthorizationV202502API`. The Java SDK package used by this guide exposes Get Authorized Shops as `AuthorizationV202309Api.authorization202309ShopsGet`, so this Java example uses `AuthorizationV202309Api`. Do not mix class names across language SDKs.
If a newer downloaded Java SDK exposes a newer authorization class for Get Authorized Shops, update the import, class name, and method name consistently.
### Get access token
The Java SDK package includes `AccessTokenAPI`, which can exchange an authorization code for an access token. The authorization code is short-lived and single-use, so do not hardcode it in source code.
```Java
String appKey = System.getenv("TTS_APP_KEY");
String appSecret = System.getenv("TTS_APP_SECRET");
String authCode = System.getenv("TTS_AUTH_CODE");

AccessTokenAPI accessTokenAPI = new AccessTokenAPI(appKey, appSecret);
ResponseInfo tokenResponse = accessTokenAPI.getToken(authCode);

if (tokenResponse == null || tokenResponse.getCode() != 0 || tokenResponse.getData() == null) {
    String message = tokenResponse == null ? "null response" : tokenResponse.getMessage();
    throw new IllegalStateException("Failed to get access token: " + message);
}

String accessToken = tokenResponse.getData().getAccessToken();
String refreshToken = tokenResponse.getData().getRefreshToken();
```

### Get shop cipher
After you have a seller `access_token`, call Get Authorized Shops and read `cipher` from the returned shop list.
```Java
String contentType = "application/json";

AuthorizationV202309Api authApi = new AuthorizationV202309Api(defaultClient);
GetAuthorizedShopsResponse shopsResponse =
        authApi.authorization202309ShopsGet(accessToken, contentType);

if (shopsResponse == null || shopsResponse.getCode() == null || shopsResponse.getCode() != 0) {
    throw new IllegalStateException("Get Authorized Shops failed: " + shopsResponse);
}

if (shopsResponse.getData() == null || shopsResponse.getData().getShops() == null
        || shopsResponse.getData().getShops().isEmpty()) {
    throw new IllegalStateException("No authorized shops returned.");
}

String shopCipher = shopsResponse.getData().getShops().get(0).getCipher();
```

### Search products
With `accessToken` and `shopCipher`, call Search Products.
```Java
ProductV202502Api productApi = new ProductV202502Api(defaultClient);
SearchProductsRequestBody requestBody = new SearchProductsRequestBody();
requestBody.setStatus("ALL");

SearchProductsResponse result = productApi.product202502ProductsSearchPost(
        1,
        accessToken,
        "application/json",
        null,
        shopCipher,
        requestBody
);

System.out.println(result);
```

If the API request succeeds, you will get a response similar to:
```JSON
{
  "code": 0,
  "data": {
    "next_page_token": "b2Zmc2V0PTAK",
    "products": [
      {
        "audit": {
          "status": "AUDITING"
        },
        "create_time": 1234567890,
        "id": "1729592969712207008",
        "integrated_platform_statuses": [
          {
            "platform": "TOKOPEDIA",
            "status": "PLATFORM_DEACTIVATED"
          }
        ]
      }
    ]
  }
}
```

### Code demo
The following example uses environment variables instead of hardcoded secrets. Configure these values in your local environment or secret manager before running the demo:
| Environment variable | Description |
| --- | --- |
| `TTS_APP_KEY` | App key from Partner Center. |
| `TTS_APP_SECRET` | App secret from Partner Center. Keep it server-side only. |
| `TTS_AUTH_CODE` | Seller authorization code from the authorization redirect URL. It is single-use and short-lived. |
| `TTS_OPEN_API_BASE_URL` | Optional. Defaults to `https://open-api.tiktokglobalshop.com`. |

```Java
import java.util.List;

import tiktokshop.open.sdk_java.api.AuthorizationV202309Api;
import tiktokshop.open.sdk_java.api.ProductV202502Api;
import tiktokshop.open.sdk_java.invoke.AccessTokenAPI;
import tiktokshop.open.sdk_java.invoke.ApiClient;
import tiktokshop.open.sdk_java.invoke.ApiException;
import tiktokshop.open.sdk_java.invoke.Configuration;
import tiktokshop.open.sdk_java.invoke.ResponseInfo;
import tiktokshop.open.sdk_java.model.Authorization.V202309.GetAuthorizedShopsResponse;
import tiktokshop.open.sdk_java.model.Authorization.V202309.GetAuthorizedShopsResponseDataShops;
import tiktokshop.open.sdk_java.model.Product.V202502.SearchProductsRequestBody;
import tiktokshop.open.sdk_java.model.Product.V202502.SearchProductsResponse;

public class Example {
    private static final String CONTENT_TYPE = "application/json";
    private static final String DEFAULT_BASE_PATH = "https://open-api.tiktokglobalshop.com";

    public static void main(String[] args) throws Exception {
        String appKey = requireEnv("TTS_APP_KEY");
        String appSecret = requireEnv("TTS_APP_SECRET");
        String authCode = requireEnv("TTS_AUTH_CODE");
        String basePath = optionalEnv("TTS_OPEN_API_BASE_URL", DEFAULT_BASE_PATH);

        AccessTokenAPI accessTokenAPI = new AccessTokenAPI(appKey, appSecret);
        ResponseInfo tokenResponse = accessTokenAPI.getToken(authCode);
        if (tokenResponse == null || tokenResponse.getCode() != 0 || tokenResponse.getData() == null
                || tokenResponse.getData().getAccessToken() == null) {
            String message = tokenResponse == null ? "null response" : tokenResponse.getMessage();
            throw new IllegalStateException("Failed to get access token: " + message);
        }

        String accessToken = tokenResponse.getData().getAccessToken();

        ApiClient defaultClient = Configuration.getDefaultApiClient()
                .setAppkey(appKey)
                .setSecret(appSecret)
                .setBasePath(basePath);

        String shopCipher = getFirstShopCipher(defaultClient, accessToken);
        searchProducts(defaultClient, accessToken, shopCipher);
    }

    private static String getFirstShopCipher(ApiClient defaultClient, String accessToken) throws ApiException {
        AuthorizationV202309Api authApi = new AuthorizationV202309Api(defaultClient);
        GetAuthorizedShopsResponse shopsResponse =
                authApi.authorization202309ShopsGet(accessToken, CONTENT_TYPE);

        if (shopsResponse == null || shopsResponse.getCode() == null || shopsResponse.getCode() != 0) {
            throw new IllegalStateException("Get Authorized Shops failed: " + shopsResponse);
        }

        if (shopsResponse.getData() == null || shopsResponse.getData().getShops() == null) {
            throw new IllegalStateException("No authorized shops returned.");
        }

        List<GetAuthorizedShopsResponseDataShops> shops = shopsResponse.getData().getShops();
        for (GetAuthorizedShopsResponseDataShops shop : shops) {
            if (shop.getCipher() != null && !shop.getCipher().isEmpty()) {
                System.out.println("Using authorized shop_id: " + shop.getId());
                return shop.getCipher();
            }
        }

        throw new IllegalStateException("No shop_cipher found in authorized shops.");
    }

    private static void searchProducts(ApiClient defaultClient, String accessToken, String shopCipher)
            throws ApiException {
        ProductV202502Api productApi = new ProductV202502Api(defaultClient);
        SearchProductsRequestBody requestBody = new SearchProductsRequestBody();
        requestBody.setStatus("ALL");

        SearchProductsResponse result = productApi.product202502ProductsSearchPost(
                1,
                accessToken,
                CONTENT_TYPE,
                null,
                shopCipher,
                requestBody
        );

        System.out.println("Search Products response: " + result);
    }

    private static String requireEnv(String name) {
        String value = System.getenv(name);
        if (value == null || value.isEmpty()) {
            throw new IllegalStateException("Missing required environment variable: " + name);
        }
        return value;
    }

    private static String optionalEnv(String name, String defaultValue) {
        String value = System.getenv(name);
        return value == null || value.isEmpty() ? defaultValue : value;
    }
}
```

### Run the demo
Set environment variables locally, then compile and run the demo.
```Bash
export TTS_APP_KEY="YOUR_APP_KEY"
export TTS_APP_SECRET="YOUR_APP_SECRET"
export TTS_AUTH_CODE="AUTH_CODE_FROM_AUTHORIZATION_REDIRECT"

mvn clean test
```

Do not commit real app secrets, access tokens, refresh tokens, or authorization codes to source control.
### Related links
| Link | Use it for |
| --- | --- |
| [Download SDK](https://partner.tiktokshop.com/docv2/page/download-sdk) | Download or regenerate the Java SDK package for your app. |
| [Update SDK](https://partner.tiktokshop.com/docv2/page/update-sdk) | Understand when to update SDK packages and how to migrate. |
| [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token) | Obtain a test authorization code and token for development. |
| [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309) | Retrieve shop information and `shop_cipher`. |
| [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request) | Manually sign OpenAPI requests when you are not using the SDK. |


---

## TikTok Shop API SDK > Integrate GoLang SDK

Doc: https://partner.tiktokshop.com/docv2/page/integrate-golang-sdk · cập nhật 2026-07-06

### Overview
Follow this guide to install the TikTok Shop Go SDK, exchange a seller authorization code for an access token, get the authorized shop's `shop_cipher`, and make your first product API call with [Search Products](https://partner.tiktokshop.com/docv2/page/search-products-202502).
The SDK signs TikTok Shop API requests for you. Use [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request) only when you call OpenAPI endpoints with your own HTTP client instead of the SDK.
This guide uses:
| Task | SDK API or helper | OpenAPI endpoint |
| --- | --- | --- |
| Exchange an authorization code for an access token | `apis.NewAccessToken(appKey, appSecret).GetToken(authCode)` | Authorization token exchange helper in the SDK |
| Get authorized shops and `shop_cipher` | `AuthorizationV202309API.Authorization202309ShopsGet(ctx)` | [GET /authorization/202309/shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309) |
| Search products | `ProductV202502API.Product202502ProductsSearchPost(ctx)` | [POST /product/202502/products/search](https://partner.tiktokshop.com/docv2/page/search-products-202502) |

Version note: API groups do not always share the same version. For example, this guide uses `AuthorizationV202309API` for Get Authorized Shops because the current endpoint is `/authorization/202309/shops`, while the Search Products example uses `ProductV202502API`.
### Prerequisites
Before integrating the SDK, you need:

1. A TikTok Shop app and a test seller account. See [Create a test seller account](https://partner.tiktokshop.com/docv2/page/create-test-seller-account).
2. A seller authorization code from the redirect URL configured for your test app. See [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token).
3. The latest Go SDK package downloaded from Partner Center. SDK packages are generated for your app's enabled scopes and API versions. See [Update SDK](https://partner.tiktokshop.com/docv2/page/update-sdk).

Do not commit `app_key`, `app_secret`, `access_token`, `refresh_token`, authorization codes, or seller data to source control. Load secrets from environment variables or your secret manager.
### Environment
Use Go 1.18 or later. The examples use the standard library `context` package. Do not add `golang.org/x/net/context`; it is obsolete for modern Go projects.
Runtime dependencies should come from the SDK package and your application code. Do not add `github.com/stretchr/testify/assert` as a runtime dependency; `testify` is a test helper and belongs in test-only files if your project uses it.
### Project Layout
After downloading and unzipping the SDK, place the SDK folder in your project and use one consistent folder name in `go.mod`.
Example layout:
```Plain Text
my-project/
  go.mod
  main.go
  sdk_golang/
    apis/
    models/
    utils/
    ...
```

Example `go.mod`:
```Go
module example.com/my-project

go 1.22

require tiktokshop/open/sdk_golang v1.0.0

replace tiktokshop/open/sdk_golang => ./sdk_golang
```

If your SDK folder has a different name, use the same placeholder in both lines:
```Go
require tiktokshop/open/<sdk-folder> v1.0.0
replace tiktokshop/open/<sdk-folder> => ./<sdk-folder>
```

After updating `go.mod`, run:
```Shell
go mod tidy
go build ./...
```

### Configure the SDK Client
Create the API client after loading `app_key` and `app_secret`. Do not build a Search Products request here, because `accessToken` and `shopCipher` are runtime values obtained in later steps.
```Go
configuration := apis.NewConfiguration()
configuration.AddAppInfo(appKey, appSecret)

apiClient := apis.NewAPIClient(configuration)
```

### Get Access Token
Use the SDK helper to exchange the one-time seller authorization code for an access token.
```Go
at := apis.NewAccessToken(appKey, appSecret)

resp, err := at.GetToken(authCode)
if err != nil {
    return fmt.Errorf("GetToken failed: %w", err)
}
if resp.Code != 0 {
    return fmt.Errorf("GetToken business error: code=%d", resp.Code)
}

accessToken := resp.Data.AccessToken
if accessToken == "" {
    return fmt.Errorf("GetToken response has empty access_token")
}
```

In production, store the access token, refresh token, and their expiration timestamps in a secure server-side data store. Do not print tokens in logs or store them in frontend code.
### Get Shop Cipher
`shop_cipher` identifies the authorized shop for shop-level APIs such as Search Products. Call [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309) with the seller `accessToken` and use `data.shops[].cipher` from the response.
```Go
shopsRequest := apiClient.AuthorizationV202309API.Authorization202309ShopsGet(ctx)
shopsRequest = shopsRequest.ContentType("application/json")
shopsRequest = shopsRequest.XTtsAccessToken(accessToken)

shopsResponse, httpRes, err := shopsRequest.Execute()
if err != nil {
    return fmt.Errorf("Authorization202309ShopsGet failed: %w", err)
}
if httpRes != nil && httpRes.StatusCode != http.StatusOK {
    return fmt.Errorf("Authorization202309ShopsGet HTTP status: %d", httpRes.StatusCode)
}
if shopsResponse == nil {
    return fmt.Errorf("Authorization202309ShopsGet response is nil")
}
if shopsResponse.GetCode() != 0 {
    return fmt.Errorf(
        "Authorization202309ShopsGet business error: code=%d message=%s",
        shopsResponse.GetCode(),
        shopsResponse.GetMessage(),
    )
}
if len(shopsResponse.Data.Shops) == 0 {
    return fmt.Errorf("no authorized shops found")
}

var shopCipher string
for _, shop := range shopsResponse.Data.Shops {
    var shopID string
    var cipher string
    if shop.Id != nil {
        shopID = *shop.Id
    }
    if shop.Cipher != nil {
        cipher = *shop.Cipher
    }

    fmt.Printf("Authorized shop: shop_id=%s, shop_cipher=%s\n", shopID, cipher)

    if shopCipher == "" && cipher != "" {
        shopCipher = cipher
    }
}

if shopCipher == "" {
    return fmt.Errorf("no shop_cipher found in authorized shops")
}
```

Do not hard-code `shop_cipher`. Always assign it from the shop you want to access. The assignment must happen inside the loop or immediately after selecting a shop from `shopsResponse.Data.Shops`; the loop variable is not available after the loop ends.
### Search Products
Call [Search Products](https://partner.tiktokshop.com/docv2/page/search-products-202502) after you have both `accessToken` and `shopCipher`.
OpenAPI endpoint:
| Item | Value |
| --- | --- |
| Method and path | `POST /product/202502/products/search` |
| Required query parameter | `page_size`, valid range: 1 to 100 |
| Optional query parameters | `page_token`, `shop_cipher` |
| Required headers | `x-tts-access-token`, `Content-Type: application/json` |
| Optional request body filters | `audit_status`, `category_version`, `create_time_ge`, `create_time_le`, `listing_platforms`, `listing_quality_tiers`, `return_draft_version`, `seller_skus`, `sku_ids`, `sns_filter`, `status`, `update_time_ge`, `update_time_le` |

Go SDK request builder used in this guide:
| Method | Meaning |
| --- | --- |
| `ContentType("application/json")` | Sets the `Content-Type` header. |
| `XTtsAccessToken(accessToken)` | Sends the seller token as `x-tts-access-token`. |
| `ShopCipher(shopCipher)` | Maps to query parameter `shop_cipher`. |
| `PageSize(1)` | Maps to required query parameter `page_size`. |
| `Product202502SearchProductsRequestBody(reqBody)` | Sets the JSON request body filters. |

```Go
productsRequest := apiClient.ProductV202502API.Product202502ProductsSearchPost(ctx)
productsRequest = productsRequest.ContentType("application/json")
productsRequest = productsRequest.XTtsAccessToken(accessToken)
productsRequest = productsRequest.ShopCipher(shopCipher)
productsRequest = productsRequest.PageSize(1)

reqBody := productV202502.Product202502SearchProductsRequestBody{
    Status: utils.PtrString("ALL"),
}
productsRequest = productsRequest.Product202502SearchProductsRequestBody(reqBody)

searchProductsResponse, httpRes, err := productsRequest.Execute()
if err != nil {
    return fmt.Errorf("Product202502ProductsSearchPost failed: %w", err)
}
if httpRes != nil && httpRes.StatusCode != http.StatusOK {
    return fmt.Errorf("Product202502ProductsSearchPost HTTP status: %d", httpRes.StatusCode)
}
if searchProductsResponse == nil {
    return fmt.Errorf("Product202502ProductsSearchPost response is nil")
}
if searchProductsResponse.GetCode() != 0 {
    return fmt.Errorf(
        "Product202502ProductsSearchPost business error: code=%d message=%s",
        searchProductsResponse.GetCode(),
        searchProductsResponse.GetMessage(),
    )
}

fmt.Printf("Search Products data: %+v\n", searchProductsResponse.GetData())
```

### Complete Demo
```Go
package main

import (
    "context"
    "fmt"
    "log"
    "net/http"
    "os"

    "tiktokshop/open/sdk_golang/apis"
    productV202502 "tiktokshop/open/sdk_golang/models/product/v202502"
    "tiktokshop/open/sdk_golang/utils"
)

func requiredEnv(name string) string {
    value := os.Getenv(name)
    if value == "" {
        log.Fatalf("missing required environment variable: %s", name)
    }
    return value
}

func getAccessToken(appKey string, appSecret string, authCode string) (string, error) {
    at := apis.NewAccessToken(appKey, appSecret)

    resp, err := at.GetToken(authCode)
    if err != nil {
        return "", fmt.Errorf("GetToken failed: %w", err)
    }
    if resp.Code != 0 {
        return "", fmt.Errorf("GetToken business error: code=%d", resp.Code)
    }

    accessToken := resp.Data.AccessToken
    if accessToken == "" {
        return "", fmt.Errorf("GetToken response has empty access_token")
    }

    return accessToken, nil
}

func getFirstShopCipher(ctx context.Context, apiClient *apis.APIClient, accessToken string) (string, error) {
    shopsRequest := apiClient.AuthorizationV202309API.Authorization202309ShopsGet(ctx)
    shopsRequest = shopsRequest.ContentType("application/json")
    shopsRequest = shopsRequest.XTtsAccessToken(accessToken)

    shopsResponse, httpRes, err := shopsRequest.Execute()
    if err != nil {
        return "", fmt.Errorf("Authorization202309ShopsGet failed: %w", err)
    }
    if httpRes != nil && httpRes.StatusCode != http.StatusOK {
        return "", fmt.Errorf("Authorization202309ShopsGet HTTP status: %d", httpRes.StatusCode)
    }
    if shopsResponse == nil {
        return "", fmt.Errorf("Authorization202309ShopsGet response is nil")
    }
    if shopsResponse.GetCode() != 0 {
        return "", fmt.Errorf(
            "Authorization202309ShopsGet business error: code=%d message=%s",
            shopsResponse.GetCode(),
            shopsResponse.GetMessage(),
        )
    }
    if len(shopsResponse.Data.Shops) == 0 {
        return "", fmt.Errorf("no authorized shops found")
    }

    var shopCipher string
    for _, shop := range shopsResponse.Data.Shops {
        var shopID string
        var cipher string
        if shop.Id != nil {
            shopID = *shop.Id
        }
        if shop.Cipher != nil {
            cipher = *shop.Cipher
        }

        fmt.Printf("Authorized shop: shop_id=%s, shop_cipher=%s\n", shopID, cipher)

        if shopCipher == "" && cipher != "" {
            shopCipher = cipher
        }
    }

    if shopCipher == "" {
        return "", fmt.Errorf("no shop_cipher found in authorized shops")
    }

    return shopCipher, nil
}

func searchProducts(ctx context.Context, apiClient *apis.APIClient, accessToken string, shopCipher string) error {
    productsRequest := apiClient.ProductV202502API.Product202502ProductsSearchPost(ctx)
    productsRequest = productsRequest.ContentType("application/json")
    productsRequest = productsRequest.XTtsAccessToken(accessToken)
    productsRequest = productsRequest.ShopCipher(shopCipher)
    productsRequest = productsRequest.PageSize(1)

    reqBody := productV202502.Product202502SearchProductsRequestBody{
        Status: utils.PtrString("ALL"),
    }
    productsRequest = productsRequest.Product202502SearchProductsRequestBody(reqBody)

    searchProductsResponse, httpRes, err := productsRequest.Execute()
    if err != nil {
        return fmt.Errorf("Product202502ProductsSearchPost failed: %w", err)
    }
    if httpRes != nil && httpRes.StatusCode != http.StatusOK {
        return fmt.Errorf("Product202502ProductsSearchPost HTTP status: %d", httpRes.StatusCode)
    }
    if searchProductsResponse == nil {
        return fmt.Errorf("Product202502ProductsSearchPost response is nil")
    }
    if searchProductsResponse.GetCode() != 0 {
        return fmt.Errorf(
            "Product202502ProductsSearchPost business error: code=%d message=%s",
            searchProductsResponse.GetCode(),
            searchProductsResponse.GetMessage(),
        )
    }

    fmt.Printf("Search Products data: %+v\n", searchProductsResponse.GetData())
    return nil
}

func main() {
    ctx := context.Background()

    appKey := requiredEnv("TTS_APP_KEY")
    appSecret := requiredEnv("TTS_APP_SECRET")
    authCode := requiredEnv("TTS_AUTH_CODE")

    configuration := apis.NewConfiguration()
    configuration.AddAppInfo(appKey, appSecret)
    apiClient := apis.NewAPIClient(configuration)

    accessToken, err := getAccessToken(appKey, appSecret, authCode)
    if err != nil {
        log.Fatal(err)
    }

    shopCipher, err := getFirstShopCipher(ctx, apiClient, accessToken)
    if err != nil {
        log.Fatal(err)
    }

    if err := searchProducts(ctx, apiClient, accessToken, shopCipher); err != nil {
        log.Fatal(err)
    }
}
```

Run the demo with environment variables:
```Shell
TTS_APP_KEY="your_app_key" \
TTS_APP_SECRET="your_app_secret" \
TTS_AUTH_CODE="your_auth_code" \
go run .
```

### SDK Updates
SDK packages are app-specific and generated from the scopes and API versions available to your app. Record the SDK download date or package version in your project so you can reproduce generated method names such as `AuthorizationV202309API` and `ProductV202502API`.
Update the SDK when:
| Trigger | Action |
| --- | --- |
| You enable new API scopes for the app | Download the latest SDK from the [SDK download page](https://partner.tiktokshop.com/docv2/page/download-sdk). |
| An API adds a new version or sunsets an old version | Regenerate the SDK and check generated API names and model package paths. |
| The SDK module path changes | Update both `require` and `replace` in `go.mod` so they refer to the same SDK folder. |
| Method names differ from this guide | Use the method names generated in your downloaded Go SDK and keep the endpoint versions aligned with the OpenAPI reference. |

For SDK update behavior, see [Update SDK](https://partner.tiktokshop.com/docv2/page/update-sdk).


---

## TikTok Shop API SDK > Integrate Node.js SDK

Doc: https://partner.tiktokshop.com/docv2/page/integrate-node-js-sdk · cập nhật 2026-07-06

### Overview
Follow this guide to install the TikTok Shop Node.js SDK, retrieve a seller access token, get an authorized shop's `shop_cipher`, and make your first product API call with [Search Products](https://partner.tiktokshop.com/docv2/page/search-products-202502).
The SDK signs TikTok Shop API requests for you. Use [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request) only when you call OpenAPI endpoints with your own HTTP client instead of the SDK.
This guide uses:
| Task | SDK API or helper | OpenAPI endpoint |
| --- | --- | --- |
| Exchange an authorization code for an access token | `AccessTokenTool.getAccessToken(authCode)` | Authorization token exchange helper in the SDK |
| Get authorized shops and `shop_cipher` | `AuthorizationV202309Api.ShopsGet` | [GET /authorization/202309/shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309) |
| Search products | `ProductV202502Api.ProductsSearchPost` | [POST /product/202502/products/search](https://partner.tiktokshop.com/docv2/page/search-products-202502) |
Version note: API groups do not always share the same version. For example, this guide uses `AuthorizationV202309Api` for Get Authorized Shops because the current endpoint is `/authorization/202309/shops`, while the Search Products example uses `ProductV202502Api`.
### Prerequisites
Before integrating the SDK, you need:

1. A TikTok Shop app and a test seller account. See [Create a test seller account](https://partner.tiktokshop.com/docv2/page/create-test-seller-account).
2. A seller authorization code from the redirect URL configured for your test app. See [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token).
3. The latest Node.js SDK package downloaded from Partner Center. SDK packages are generated for your app's enabled scopes and API versions. See [Update SDK](https://partner.tiktokshop.com/docv2/page/update-sdk).

Do not commit `app_key`, `app_secret`, `access_token`, `refresh_token`, authorization codes, or seller data to source control. Load secrets from environment variables or your secret manager.
### Environment
Use a supported Node.js LTS release. As of July 2026, Node.js 22.x and 24.x are supported LTS lines; Node.js 16.x is end-of-life. Check the [Node.js release schedule](https://github.com/nodejs/release#release-schedule) before publishing a new version of this guide.
Recommended baseline:
| Component | Recommendation |
| --- | --- |
| Node.js | 22.x LTS or 24.x LTS |
| TypeScript | Current supported TypeScript major used by your project |
| HTTP client | Use the SDK's generated client. For custom HTTP calls, use Node's built-in `fetch` or another maintained client. Do not add `request` to new projects. |
### Project layout
After downloading and unzipping the SDK, place it in your project and import it by the relative path from your code file to the SDK entry point.
Example layout:
```Plain Text
my-project/
  package.json
  tsconfig.json
  src/
    index.ts
  tiktok-shop-node-sdk/
    index.ts
    api/
    model/
    ...
```

If your demo file is `src/index.ts`, import from the SDK folder with:
```TypeScript
import {
  AccessTokenTool,
  ClientConfiguration,
  TikTokShopNodeApiClient,
} from "../tiktok-shop-node-sdk";
```

If you place the demo file directly inside the SDK root, `from "."` works because it points to that folder's `index.ts`. In an application project, prefer importing from the explicit SDK folder path.
### Installation
Install the dependencies listed in the SDK package you downloaded. If the generated SDK includes its own `package.json`, use that file as the source of truth.
For a new TypeScript project around the SDK, start with a maintained baseline similar to this:
```JSON
{
  "type": "module",
  "scripts": {
    "start": "tsx src/index.ts"
  },
  "dependencies": {
    "tslib": "^2.8.1"
  },
  "devDependencies": {
    "@types/node": "^24",
    "tsx": "^4",
    "typescript": "^6"
  }
}
```

Do not add `request` or `@types/request` to new integrations. The [request](https://www.npmjs.com/package/request) package is deprecated and should not be used for new custom HTTP code. If your downloaded SDK still depends on `request`, download the latest SDK from Partner Center and check whether the generated client has been updated; otherwise keep the dependency only as a compatibility requirement for that specific SDK package.
Add the following to `tsconfig.json`:
```JSON
{
  "compilerOptions": {
    "esModuleInterop": true,
    "moduleResolution": "node",
    "target": "ES2022",
    "module": "ESNext",
    "strict": true
  }
}
```

Install dependencies:
```Shell
npm install
```

You can also use `yarn install` or `pnpm install` if your project standardizes on Yarn or pnpm.
### Configuration
Configure the SDK from environment variables:
```TypeScript
const requiredEnv = (name: string): string => {
  const value = process.env[name];
  if (!value) {
    throw new Error(`Missing required environment variable: ${name}`);
  }
  return value;
};

ClientConfiguration.globalConfig.app_key = requiredEnv("TTS_APP_KEY");
ClientConfiguration.globalConfig.app_secret = requiredEnv("TTS_APP_SECRET");

const client = new TikTokShopNodeApiClient({
  config: {
    sandbox: process.env.TTS_SANDBOX === "true",
  },
});
```

`sandbox: false` sends requests to the production environment. Use `sandbox: true` only when you are testing against the sandbox or Development Shop environment supported by your SDK package.
### Get Access Token
Use the SDK helper to exchange the one-time seller authorization code for an access token.
```TypeScript
const authCode = requiredEnv("TTS_AUTH_CODE");

const { body: tokenBody } = await AccessTokenTool.getAccessToken(authCode);
console.log("getAccessToken response:", JSON.stringify(tokenBody, null, 2));

const accessToken = tokenBody.data?.access_token;
if (!accessToken) {
  throw new Error("Failed to get access token");
}
```

In production, store the access token, refresh token, and their expiration timestamps in a secure server-side data store. Do not store tokens in frontend code.
### Get Shop Cipher
`shop_cipher` identifies the authorized shop for shop-level APIs such as Search Products. Call [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309) with the seller `accessToken` and use `data.shops[].cipher` from the response.
```TypeScript
const contentType = "application/json";

const { body: shopsGetBody } =
  await client.api.AuthorizationV202309Api.ShopsGet(accessToken, contentType);

console.log("ShopsGet response:", JSON.stringify(shopsGetBody, null, 2));

const shopList = shopsGetBody.data?.shops ?? [];
if (shopList.length === 0) {
  throw new Error("No authorized shops found.");
}

const selectedShop = shopList[0];
const shopId = selectedShop.id;
const shopCipher = selectedShop.cipher;

if (!shopCipher) {
  throw new Error(`No shop_cipher found for shop_id: ${shopId}`);
}

console.log(`Using shop_id: ${shopId}, shop_cipher: ${shopCipher}`);
```

Do not hard-code `shop_cipher`. Always use the cipher for the shop whose products you want to access.
### Search Products
Call [Search Products](https://partner.tiktokshop.com/docv2/page/search-products-202502) after you have both `accessToken` and `shopCipher`.
OpenAPI endpoint:
| Item | Value |
| --- | --- |
| Method and path | `POST /product/202502/products/search` |
| Required query parameter | `page_size`, valid range: 1 to 100 |
| Optional query parameters | `page_token`, `shop_cipher` |
| Required headers | `x-tts-access-token`, `Content-Type: application/json` |
| Optional request body filters | `status`, `seller_skus`, `sku_ids`, `category_version`, `create_time_ge`, `create_time_le`, `update_time_ge`, `update_time_le`, and other fields shown in the endpoint reference |

Node.js SDK method call used in this guide:
| Position | Argument | Meaning |
| --- | --- | --- |
| 1 | `pageSize` | Maps to query parameter `page_size`. |
| 2 | `accessToken` | Sent as `x-tts-access-token`. |
| 3 | `contentType` | Usually `application/json`. |
| 4 | `pageToken` | Optional pagination token. Use `undefined` for the first page. |
| 5 | `searchProductsRequestBody` | Optional JSON body for filters. Use `{}` or `undefined` when you do not need filters. |
| 6 | `shopCipher` | Maps to query parameter `shop_cipher`. |

Different SDK languages may generate different positional argument orders. Do not copy the Java or Go method argument order into Node.js code. Check the generated Node.js SDK method signature in your downloaded SDK when you update the SDK.
```TypeScript
const pageSize = 10;
const pageToken = undefined;
const searchProductsRequestBody = {};

const result = await client.api.ProductV202502Api.ProductsSearchPost(
  pageSize,
  accessToken,
  contentType,
  pageToken,
  searchProductsRequestBody,
  shopCipher
);

console.log("Search Products response:", JSON.stringify(result.body, null, 2));
```

### Complete Demo
```TypeScript
import {
  AccessTokenTool,
  ClientConfiguration,
  TikTokShopNodeApiClient,
} from "../tiktok-shop-node-sdk";

const requiredEnv = (name: string): string => {
  const value = process.env[name];
  if (!value) {
    throw new Error(`Missing required environment variable: ${name}`);
  }
  return value;
};

ClientConfiguration.globalConfig.app_key = requiredEnv("TTS_APP_KEY");
ClientConfiguration.globalConfig.app_secret = requiredEnv("TTS_APP_SECRET");

const client = new TikTokShopNodeApiClient({
  config: {
    sandbox: process.env.TTS_SANDBOX === "true",
  },
});

const main = async () => {
  const contentType = "application/json";

  const authCode = requiredEnv("TTS_AUTH_CODE");
  const { body: tokenBody } = await AccessTokenTool.getAccessToken(authCode);
  console.log("getAccessToken response:", JSON.stringify(tokenBody, null, 2));

  const accessToken = tokenBody.data?.access_token;
  if (!accessToken) {
    throw new Error("Failed to get access token");
  }

  const { body: shopsGetBody } =
    await client.api.AuthorizationV202309Api.ShopsGet(accessToken, contentType);
  console.log("ShopsGet response:", JSON.stringify(shopsGetBody, null, 2));

  const shopList = shopsGetBody.data?.shops ?? [];
  if (shopList.length === 0) {
    throw new Error("No authorized shops found.");
  }

  const selectedShop = shopList[0];
  const shopId = selectedShop.id;
  const shopCipher = selectedShop.cipher;
  if (!shopCipher) {
    throw new Error(`No shop_cipher found for shop_id: ${shopId}`);
  }

  console.log(`Using shop_id: ${shopId}, shop_cipher: ${shopCipher}`);

  const pageSize = 10;
  const pageToken = undefined;
  const searchProductsRequestBody = {};

  const result = await client.api.ProductV202502Api.ProductsSearchPost(
    pageSize,
    accessToken,
    contentType,
    pageToken,
    searchProductsRequestBody,
    shopCipher
  );

  console.log("Search Products response:", JSON.stringify(result.body, null, 2));
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
```

Run the demo with environment variables:
```Shell
TTS_APP_KEY="your_app_key" \
TTS_APP_SECRET="your_app_secret" \
TTS_AUTH_CODE="your_auth_code" \
TTS_SANDBOX="true" \
npm run start
```

Use `TTS_SANDBOX="false"` or omit `TTS_SANDBOX` for production.
### SDK Updates
SDK packages are app-specific and generated from the scopes and API versions available to your app. Record the SDK download date or package version in your project so you can reproduce generated method signatures.
Update the SDK when:
| Trigger | Action |
| --- | --- |
| You enable new API scopes for the app | Download the latest SDK from the [SDK download page](https://partner.tiktokshop.com/docv2/page/download-sdk). |
| An API adds a new version or sunsets an old version | Regenerate the SDK and check generated API class names such as `ProductV202502Api`. |
| The SDK framework changes | Reinstall dependencies from the SDK package and rerun your build. |
| Method parameter order changes after regeneration | Update the code according to the generated Node.js method signature instead of copying examples from Java or Go. |

For SDK update behavior, see [Update SDK](https://partner.tiktokshop.com/docv2/page/update-sdk).


---

## TikTok Shop API SDK > Update SDK

Doc: https://partner.tiktokshop.com/docv2/page/update-sdk · cập nhật 2026-07-06

### What this page covers
Use this page when you have already integrated a TikTok Shop SDK and need to refresh it because your app, API access scopes, API versions, or the SDK framework has changed.
For the first-time SDK download flow, go to [Download SDK](https://partner.tiktokshop.com/docv2/page/download-sdk). To reduce duplicated instructions, keep the split as follows:
| Page | Use it for |
| --- | --- |
| [Download SDK](https://partner.tiktokshop.com/docv2/page/download-sdk) | Find the SDK download page, select a language, and download the SDK for first-time integration. |
| Update SDK | Understand when a newer SDK appears, how to trigger an update check, what compatibility means, and how to migrate your existing project. |
### When an SDK update is generated
The SDK package shown for your app can change when any of the following changes apply to your effective app:

* API access scopes are added to or removed from your app.
* APIs are added, removed, upgraded, or sunset within your app's API access scope collection.
* The SDK framework is upgraded.
* Supported language versions are upgraded.

TikTok Shop sends SDK update notifications through [TikTok Shop Message Center](https://partner.tiktokshop.com/message/list).
[Image: TikTok Shop Message Center SDK update notification](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ[[/ljhwZthlaukjlkulzlp/Developer_Guide/TTSPC_API_SDK/message_center.png)
### Find the update entry
To check for an updated SDK, open the same SDK download page you used for the original SDK:

1. Go to Partner Center.
2. Open the console page for the app whose SDK you want to update.
3. Open the SDK download page described in [Download SDK](https://partner.tiktokshop.com/docv2/page/download-sdk).
4. Check the SDK generation time, SDK version, supported language, and available API scope/API set.
5. If you need the latest generated package, download the SDK again from this page.

The `check for updates` button is on the SDK download page. Use it when you have just changed scopes, app configuration, API access, or language requirements and do not want to wait for the next scheduled SDK generation.
[Image: Check for updates button on the SDK download page](https://sf16-sg.tiktokcdn.com/obj/eden-sg/jvK_ylwvslclK_JWZ[[/ljhwZthlaukjlkulzlp/Developer_Guide/TTSPC_API_SDK/check_for_updates.png)
### Daily generation and manual check
SDKs are generated on a daily basis. The manual `check for updates` button requests an earlier refresh for the app and language shown on the download page.
After clicking `check for updates`:

* Wait for the SDK page to show an updated generation time, package version, or download package.
* If there are no effective changes to scopes, API access, API versions, SDK framework, or supported language versions, the generated SDK may stay the same.
* If generation is still in progress, refresh the SDK download page later or check Message Center for update notifications.
* The version or generated time shown on the download page is the source of truth for the package you should download.

### Compatibility and API retirement
TikTok Shop aims to keep new SDK versions backward compatible, but compatibility depends on the API versions and scopes your app uses.
Use the following rules when assessing an SDK update:
| Change type | What to expect | What you should do |
| --- | --- | --- |
| Non-breaking SDK or API change | Existing SDK calls usually continue to work. New methods or fields may be added. | Update the SDK, run build/tests, and smoke test critical flows. |
| New API version with breaking changes | Breaking API changes are introduced through a new API version. Older versions may remain available for a limited period. | Read the API reference and [API versioning](https://partner.tiktokshop.com/docv2/page/api-versioning) notes before changing your code to a newer API version. |
| API version retirement | A prior API version remains available for at least 2 months after a new version is released. Retirement is announced in the [changelog](https://partner.tiktokshop.com/docv2/changelog) at least 2 months before permanent retirement. | Plan migration before the retirement date. If you call a retired or invalid API version, the API can return `36009014` with a message that the version name is invalid. |
| Scope or app access change | SDK methods can appear or disappear based on the effective app scope/API set. | Confirm your app scopes, update seller authorization if new scopes require reauthorization, then download the regenerated SDK. |

Before updating production traffic, review:

* [Changelog](https://partner.tiktokshop.com/docv2/changelog) for release, breaking change, and retirement notices.
* [API versioning](https://partner.tiktokshop.com/docv2/page/api-versioning) for version naming, selection, and retirement behavior.
* The API reference page for each endpoint you call, including the version dropdown and migration notes.

### Migration steps
Follow these steps whenever you download a newer SDK package:

1. Review the SDK download page and changelog. Confirm what changed: scope set, API version, SDK framework, or language support.
2. Download the SDK package for the same language used by your project.
3. Create a separate branch and replace the generated SDK folder, local module, or package in that branch.
4. Update dependency references to the new SDK package or local module path.
5. Reinstall or rebuild dependencies for your language.
6. Compile the project and fix import, package, class, or method changes.
7. Run unit tests and integration tests for the API domains your app uses.
8. Smoke test authorization, token refresh, request signing, and one core API call per updated API domain.
9. Deploy gradually and monitor API errors, especially invalid version, permission, scope, and signature errors.

### Language-specific update notes
| Language | Typical update action |
| --- | --- |
| Java | Replace the generated SDK module or JAR, update the dependency version or local path, then run `mvn clean test`, `mvn install`, or your Gradle build command. |
| Go | Replace the generated SDK module, update the module path or version if needed, then run `go mod tidy`, `go test ./...`, and `go build ./...`. |
| Node.js | Replace the generated SDK folder or package, keep your application code and config files, then run `npm install`, `yarn install`, or `pnpm install`, followed by your TypeScript build and tests. |

If your language-specific integration guide still shows a placeholder version such as `1.0.0`, do not assume it is the latest SDK version. Use the version or generated timestamp shown on the SDK download page for your app.
### Scope and authorization checks
An SDK update does not automatically grant new API permissions.
If the update includes new scopes or APIs:

* Confirm the app has the required API access scopes in Partner Center.
* If new seller permissions are required, ask sellers to authorize or reauthorize the app as needed.
* Confirm that the regenerated SDK contains the API methods you expect.
* Test with a development shop or sandbox flow before using the updated SDK in production.

### Related links
| Link | Use it for |
| --- | --- |
| [Download SDK](https://partner.tiktokshop.com/docv2/page/download-sdk) | Download the SDK package from the SDK download page. |
| [API versioning](https://partner.tiktokshop.com/docv2/page/api-versioning) | Understand API version naming, version selection, and retirement behavior. |
| [Changelog](https://partner.tiktokshop.com/docv2/changelog) | Track API changes, breaking changes, and retirement notices. |
| [TTS API overview](https://partner.tiktokshop.com/docv2/page/overview) | Return to the API overview and navigation. |

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/d650c57863e9440c86355e51dc41ca19~tplv-k9wyc2ijk0-image.image)

(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/95dc1a7287ae4ef6bb4471ac1877ee59~tplv-k9wyc2ijk0-image.image)

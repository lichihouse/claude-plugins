# Developer Guide — TikTok Shop API concepts

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.



---

## TikTok Shop API concepts > Overview

Doc: https://partner.tiktokshop.com/docv2/page/tts-api-concepts-overview · cập nhật 2026-07-01

TikTok Shop provides a comprehensive range of APIs known as the **TTS API**. These APIs allow developers to access authorized TikTok Shop data, including catalogs, orders, shipments, payments, and more.
With the TTS API, developers can create apps that extend Seller Center's existing functionality. These apps can enhance product catalog listings, streamline order fulfillment, reduce operational workload, and accelerate customer interactions.
### Key features
With the TikTok Shop API, you can:

* Set up an [authorization workflow](https://partner.tiktokshop.com/docv2/page/authorization-overview-202407) that developers initiate from the TTS App & Service Market detail page or from your own website.
* Configure [webhooks](https://partner.tiktokshop.com/docv2/page/tts-webhooks-overview) to receive notifications from TikTok Shop Open Platform.
* Test your app functionality in Sandbox or by making API calls using the [API testing tool](https://partner.tiktokshop.com/dev/api-testing-tool).

### API categories
| **No.** | **API category** | **API description** |
| --- | --- | --- |
| 1 | [Product API](https://partner.tiktokshop.com/docv2/page/products-api-overview) | The Product API is one of the most important APIs in TTS. Developers can use the Product API to access product category rules and attributes, upload product images, videos, certifications, and other files, create products, edit product information, and update inventory and prices. TikTok Shop also provides Global Product APIs for cross-border e-commerce developers. With the Global Product API, cross-border e-commerce developers can offer unified product management solutions for cross-border sellers selling across multiple regional markets. |
| 2 | [Order API](https://partner.tiktokshop.com/docv2/page/order-api-overview) | Developers can use the Order API to retrieve order information from TikTok Shop seller shops. After sellers obtain order information, they can perform order fulfillment operations as well as actions such as order cancellation and returns. |
| 3 | [Fulfillment API](https://partner.tiktokshop.com/docv2/page/fulfillment-api-overview) | Developers can use the Fulfillment API to synchronize fulfillment status for TikTok Shop orders with third-party logistics providers (3PL). They can also fulfill orders using TikTok-provided shipping label services (4PL). In addition, the Fulfilled by TikTok (FBT) service can be used, and developers can access the fulfillment status of TikTok Shop orders through the Fulfillment API. |
| 4 | [Return & Refund API](https://partner.tiktokshop.com/docv2/page/return-refund-and-cancel-api-overview) | When consumers initiate a return or refund request, developers can use the Return & Refund API to access return or refund order information and assist sellers in reviewing or rejecting requests initiated by consumers. |
| 5 | [Logistics API](https://partner.tiktokshop.com/docv2/page/logistic-api-overview) | When sellers use TikTok Shop-provided logistics services, developers can use the Logistics API to help sellers retrieve warehouse lists, global warehouse lists, subscribed delivery options, and shipping providers. |
| 6 | [Promotion API](https://partner.tiktokshop.com/docv2/page/promotion-api-overview) | Developers can use the Promotion API to assist sellers in setting up promotions, discounts, and other offers for specific products. |
| 7 | [Finance API](https://partner.tiktokshop.com/docv2/page/finance-api-overview) | Developers can use the Finance API to assist sellers in obtaining payment and settlement information for their TikTok Shop. |
| 8 | [Seller API](https://partner.tiktokshop.com/docv2/page/seller-api-overview) | The Seller API supports cross-border operations, where a single seller can establish shops in multiple regional markets. Developers can use the Seller API to retrieve the shop status of cross-border sellers and determine whether a specific cross-border market is eligible for the Global Product feature. |
| 9 | [Authorization API](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309) | Developers can use the Authorization API to exchange authorization tokens and retrieve authorized shop information for apps. |
| 10 | [Events API](https://partner.tiktokshop.com/docv2/page/get-shop-webhooks) | Developers can use the Events API to subscribe and unsubscribe Open Platform webhooks for TikTok Shop business events. |
| 11 | Data Reconciliation API | Developers can use the Data Reconciliation API to transfer external data to Open Platform for Quality Engine reconciliation. |
| 12 | [Supply Chain API](https://partner.tiktokshop.com/docv2/page/confirm-package-shipment) | This API is for TikTok Shop certified warehouse partners. Developers can use the Supply Chain API to send package fulfillment details for orders fulfilled by certified warehouses back to TTS. |

For a complete list of available APIs, refer to the [TTS API reference docs](https://partner.tiktokshop.com/docv2/page/create-product).
### Authorization and token navigation
The TTS API uses different authorization flows depending on the data owner. The `user_type` field in token responses helps identify the authorization principal, such as seller, creator, or partner. For exact token response fields and enum values, refer to [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token).
Use the authorization guide that matches the data owner:
| Authorization type | Data owner | US authorization entry | ROW authorization entry | Main guide |
| --- | --- | --- | --- | --- |
| Seller authorization | Seller / shop | `https://services.us.tiktokshop.com/open/authorize` | `https://services.tiktokshop.com/open/authorize` | [Authorization overview](https://partner.tiktokshop.com/docv2/page/authorization-overview-202407) |
| Creator authorization | Creator | `https://shop.tiktok.com/alliance` | `https://shop.tiktok.com/alliance` | [Creator authorization guide](https://partner.tiktokshop.com/docv2/page/creator-authorization-guide) |
| Partner authorization | Partner | `https://partner.us.tiktokshop.com/open/authorize` | `https://partner.tiktokshop.com/open/authorize` | [Partner authorization guide](https://partner.tiktokshop.com/docv2/page/partner-authorization-guide) |
When choosing an API, also check the endpoint's entity tag and access requirements. For tag-level guidance, refer to [API entity tags](https://partner.tiktokshop.com/docv2/page/api-entity-tags). For scope-level guidance, refer to [Access scope](https://partner.tiktokshop.com/docv2/page/access-scope).
### API version
The TTS API is versioned. Some older API versions may remain accessible, but unsupported versions can stop working at any time. Developers are strongly encouraged to use the newest supported version available for the endpoint they are calling.
Do not rely on hardcoded examples to determine the latest version. On each API Reference page, use the version selector or version dropdown to confirm the newest supported version for that endpoint, then follow any migration notes or deprecation notices shown on the page.
For additional details, refer to [TTS API versioning](https://partner.tiktokshop.com/docv2/page/api-versioning).


---

## TikTok Shop API concepts > Methods and endpoints

Doc: https://partner.tiktokshop.com/docv2/page/methods-and-endpoints · cập nhật 2026-07-01

### Methods
TikTok Shop API reference pages define the HTTP method for each endpoint. Most TTS Open APIs use **GET** or **POST**. A small number of endpoints may use other RESTful methods, but developers should always follow the exact method shown on the endpoint reference page.
Using a method that does not match the endpoint reference can cause errors such as `36009010 Invalid method`.
| **Method** | **Typical use** | **Implementation note** |
| --- | --- | --- |
| **GET** | Retrieve resources from TikTok Shop. | Commonly used for query and list APIs. |
| **POST** | Send data or execute an action. | Commonly used when the API has a request body or performs a state-changing operation. |
| **PUT** | Update an existing resource. | Use only when the endpoint reference explicitly lists `PUT`. |
| **DELETE** | Remove a resource. | Use only when the endpoint reference explicitly lists `DELETE`. |
### Endpoints
TikTok Shop API endpoints are organized by resource type and follow the pattern:
**https://{domain}/{category}/{version}/{resource}**
The `/{category}/{version}/{resource}` segment can be found in the corresponding reference doc for any TikTok Shop API. Starting with the `202309` API style, the API version is part of the request path, for example `/authorization/202309/shops`. When you calculate the request signature, use the request path exactly as shown after the domain, including the category, version, and resource segments. For signing rules, refer to [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request).
For example, to call [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309), the endpoint is:
```Plain Text
https://open-api.tiktokglobalshop.com/authorization/202309/shops
```

### Domains and environments
For **business API calls**, TTS Open API currently uses the following domain:
| **Environment** | **URI** | **Use case** |
| --- | --- | --- |
| Production | `https://open-api.tiktokglobalshop.com` | The request host used by developers to call TTS Open API endpoints after creating an app. Use HTTPS. |

Do not use authorization or token domains as the business API request host. They have different purposes:
| **Purpose** | **Domain or entry** | **Use case** | **Reference** |
| --- | --- | --- | --- |
| Business API calls | `https://open-api.tiktokglobalshop.com` | Call API endpoints such as authorization, product, order, fulfillment, and webhook APIs. | Current page |
| Seller authorization | `https://services.us.tiktokshop.com/open/authorize` for US; `https://services.tiktokshop.com/open/authorize` for ROW | Start seller or shop authorization and obtain an authorization code. Do not use this host as an API endpoint host. | [Authorization overview](https://partner.tiktokshop.com/docv2/page/authorization-overview-202407) |
| Partner authorization | `https://partner.us.tiktokshop.com/open/authorize` for US; `https://partner.tiktokshop.com/open/authorize` for ROW | Start partner authorization and obtain an authorization code. Do not use this host as an API endpoint host. | [Partner authorization guide](https://partner.tiktokshop.com/docv2/page/partner-authorization-guide) |
| Creator authorization | `https://shop.tiktok.com/alliance` | Start creator authorization. Do not use this host as an API endpoint host. | [Creator authorization guide](https://partner.tiktokshop.com/docv2/page/creator-authorization-guide) |
| Token exchange | `https://auth.tiktok-shops.com` | Exchange an authorization code for tokens or refresh tokens. | [Generate a test access token](https://partner.tiktokshop.com/docv2/page/generate-test-access-token) |
| Sandbox and API testing |    | Use Sandbox app setup and the [API testing tool](https://partner.tiktokshop.com/dev/api-testing-tool) to test calls, while still following the endpoint reference for the exact path and method. | [Authorization overview](https://partner.tiktokshop.com/docv2/page/authorization-overview-202407) |
### Category quick reference
The category segment groups endpoints by business area. Always copy the final method and path from the endpoint reference page, because version and resource names can differ by API.
| **Business area** | **Common category segment** | **Example resource** | **Reference** |
| --- | --- | --- | --- |
| Authorization | `authorization` | `shops` | [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops-202309) |
| Product | `product` | `products`, `categories`, `inventory` | [Product API overview](https://partner.tiktokshop.com/docv2/page/products-api-overview) |
| Order | `order` | `orders` | [Order API overview](https://partner.tiktokshop.com/docv2/page/order-api-overview) |
| Fulfillment | `fulfillment` | `packages`, `shipping_documents` | [Fulfillment API overview](https://partner.tiktokshop.com/docv2/page/fulfillment-api-overview) |
| Return & Refund | `return_refund` | `returns`, `refunds`, `cancellations` | [Return & Refund API overview](https://partner.tiktokshop.com/docv2/page/return-refund-and-cancel-api-overview) |
| Logistics | `logistics` | `warehouses`, `delivery_options`, `shipping_providers` | [Logistics API overview](https://partner.tiktokshop.com/docv2/page/logistic-api-overview) |
| Promotion | `promotion` | `promotions`, `discounts` | [Promotion API overview](https://partner.tiktokshop.com/docv2/page/promotion-api-overview) |
| Finance | `finance` | `payments`, `settlements` | [Finance API overview](https://partner.tiktokshop.com/docv2/page/finance-api-overview) |
| Seller | `seller` | `shops` | [Seller API overview](https://partner.tiktokshop.com/docv2/page/seller-api-overview) |
| Events | `event` | `webhooks` | [Events API](https://partner.tiktokshop.com/docv2/page/get-shop-webhooks) |
| Supply Chain | `supply_chain` | `packages`, `shipments` | [Supply Chain API](https://partner.tiktokshop.com/docv2/page/confirm-package-shipment) |
### Version and path guidance
The version segment is part of the endpoint path and must match the API reference page. Do not assume that all endpoints use the same version. For version selection and migration guidance, refer to [TTS API versioning](https://partner.tiktokshop.com/docv2/page/api-versioning).
When troubleshooting request failures, check the following first:
| **Symptom** | **Likely cause** | **What to check** |
| --- | --- | --- |
| `36009010 Invalid method` | The HTTP method does not match the endpoint reference. | Reopen the endpoint reference and use the exact method shown there. |
| Signature validation failure | The signed path or timestamp does not match the actual request. | Confirm that the signed path includes `/{category}/{version}/{resource}` and follow [Sign your API request](https://partner.tiktokshop.com/docv2/page/sign-your-api-request). |
| Host or DNS confusion | An authorization, token, or testing domain was used as the business API host. | Use `https://open-api.tiktokglobalshop.com` for business API calls. |


---

## TikTok Shop API concepts > Sign your API request

Doc: https://partner.tiktokshop.com/docv2/page/sign-your-api-request · cập nhật 2026-07-06

#### Introduction
When calling a TikTok Shop API, a signature must be included to properly authenticate your request. All requests that do not include a signature, or have an invalid signature, will be denied access.
TikTok Shop APIs use **HMAC-SHA256** as the default algorithm for generating signatures.
**HS256 (HMAC with SHA-256)** is a symmetric algorithm, meaning there is only one private key that is shared between the two parties. Since the same key is used to both generate and validate the signature, care must be taken to ensure that the key is not compromised.
When TikTok Shop receives an authenticated request, it recreates the signature using the authentication information contained in the request. If the signatures match, the service processes the request. Otherwise, it rejects the request.
❗ **Important**: TikTok Shop APIs use your **app secret** as the private key for authentication. You can obtain your **app secret** from your app details page in Partner Center.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/cc8d63acb74b4e7bb18413efa3aaace7~tplv-k9wyc2ijk0-image.image)

For API version `202309` and later, send the access token in the `x-tts-access-token` request header instead of the query string. The access token is not included when generating the signature. For legacy APIs that still use `access_token` as a query parameter, exclude `access_token` from the reordered query keys.
### Code Samples
You can find the code samples in GoLang, Java, Node.js, and Python below. With the code samples, you do not need to dig deep into the algorithm. If you need code samples in other languages, please highlight the sentence and provide feedback for us.
#### Signature algorithm (Go)
```Go
import (  
    "bytes"  
    "crypto/hmac"  
    "crypto/sha256"  
    "encoding/hex"  
    "io"  
    "mime"  
    "net/http"  
    "sort"  
)  
  
// secret: App secret  
func CalSign(req *http.Request, secret string) string {  
    queries := req.URL.Query()  
  
    // extract all query parameters excluding sign and access_token  
    keys := make([]string, len(queries))  
    idx := 0  
    for k := range queries {  
        // params except 'sign' & 'access_token'  
        if k != "sign" && k != "access_token" {  
            keys[idx] = k  
            idx++  
        }  
    }  
      
    // reorder the parameters' key in alphabetical order  
    sort.Slice(keys, func(i, j int) bool {  
        return keys[i] < keys[j]  
    })  
  
    // Concatenate all the parameters in the format of {key}{value}  
    input := ""  
    for _, key := range keys {  
        input = input + key + queries.Get(key)  
    }  
  
    // append the request path  
    input = req.URL.Path + input  
  
    // if the request header Content-type is not multipart/form-data, append body to the end  
    mediaType, _, _ := mime.ParseMediaType(req.Header.Get("Content-type"))  
    if mediaType != "multipart/form-data" {  
        body, _ := io.ReadAll(req.Body)  
        input = input + string(body)  
          
        req.Body.Close()  
        // reset body after reading from the original  
        req.Body = io.NopCloser(bytes.NewReader(body))  
    }  
  
    // wrap the string generated in step 5 with the App secret  
    input = secret + input + secret  
  
    return generateSHA256(input, secret)  
}  
  
func generateSHA256(input, secret string) string {  
    // encode the digest byte stream in hexadecimal and use sha256 to generate sign with salt(secret)  
    h := hmac.New(sha256.New, []byte(secret))  
  
    if _, err := h.Write([]byte(input)); err != nil {  
        // TODO error log  
        return ""  
    }  
  
    return hex.EncodeToString(h.Sum(nil))  
}
```

#### Signature algorithm (Java)
```Java
package org.example;

import okhttp3.HttpUrl;
import okhttp3.Request;
import okhttp3.RequestBody;
import okio.Buffer;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Main {
    public String generateSignature(Request request, String secret) {
    HttpUrl httpUrl = request.url();
    List<String> parameterNameList = new ArrayList<>(httpUrl.queryParameterNames());

    // extract all query parameters excluding sign and access_token
    parameterNameList.removeIf(param -> "sign".equals(param) || "access_token".equals(param));

    // reorder the parameters' key in alphabetical order
    Collections.sort(parameterNameList);

    // append the request path
    StringBuilder parameterStr = new StringBuilder(httpUrl.encodedPath());
    for (String parameterName : parameterNameList) {
        // Concatenate all the parameters in the format of {key}{value}
        parameterStr.append(parameterName).append(httpUrl.queryParameter(parameterName));
    }

    // if the request header Content-type is not multipart/form-data, append body to the end
    String contentType = request.header("Content-Type");
    if (!"multipart/form-data".equalsIgnoreCase(contentType)) {
        try {
            RequestBody requestBody = request.body();
            if (requestBody != null) {
                Buffer bodyBuffer = new Buffer();
                requestBody.writeTo(bodyBuffer);
                byte[] bodyBytes = bodyBuffer.readByteArray();
                parameterStr.append(new String(bodyBytes, StandardCharsets.UTF_8));
            }
        } catch (Exception e) {
            throw new RuntimeException("failed to generate signature params", e);
        }
    }

    // wrap the string generated in step 5 with the App secret
    String signatureParams = secret + parameterStr + secret;

    // encode wrapped string using HMAC-SHA256
    return generateSHA256(signatureParams, secret);
}

/**
 * generate signature by SHA256
 * @param signatureParams signature params
 * @return signature
 */
public String generateSHA256(String signatureParams, String secret) {
    try {
        // Get an HmacSHA256 Mac instance and initialize with the secret key
        Mac sha256HMAC = Mac.getInstance("HmacSHA256");
        SecretKeySpec secretKeySpec = new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
        sha256HMAC.init(secretKeySpec);

        // Update with input data
        sha256HMAC.update(signatureParams.getBytes(StandardCharsets.UTF_8));

        // Compute the HMAC and get the result
        byte[] hashBytes = sha256HMAC.doFinal();

        // Convert to hex string
        StringBuilder sb = new StringBuilder();
        for (byte hashByte : hashBytes) {
            sb.append(String.format("%02x", hashByte & 0xff));
        }

        return sb.toString();
    } catch (Exception e) {
        throw new RuntimeException("failed to generate signature result", e);
    }
}
}
```

#### Signature algorithm (Node.js)
```TypeScript
import crypto from "crypto";
import localVarRequest from "request";
const excludeKeys = ["access_token", "sign"] as const;
export const generateSign = (
  requestOption: localVarRequest.Options,
  app_secret: string
) => {
  let signString = "";
  // step1: Extract all query parameters excluding sign and access_token. Reorder the parameter keys in alphabetical order:
  const params = requestOption.qs || {};
  const sortedParams = Object.keys(params)
    .filter((key) => !excludeKeys.includes(key as any))
    .sort()
    .map((key) => ({ key, value: params[key] }));
  //step2: Concatenate all the parameters in the format {key}{value}:
  const paramString = sortedParams
    .map(({ key, value }) => `${key}${value}`)
    .join("");

  signString += paramString;

  //step3: Append the string from Step 2 to the API request path:
// @ts-ignore
  const pathname = new URL(requestOption!.uri!||'').pathname;

  signString = `${pathname}${paramString}`;

  //step4: If the request header content-type is not multipart/form-data, append the API request body to the string from Step 3:
  if (
    requestOption.headers?.["content-type"] !== "multipart/form-data" &&
    requestOption.body &&
    Object.keys(requestOption.body).length
  ) {
    const body = JSON.stringify(requestOption.body);
    signString += body;
  }

  //step5: Wrap the string generated in Step 4 with the app_secret:
  signString = `${app_secret}${signString}${app_secret}`;

  //step6: Encode your wrapped string using HMAC-SHA256:
  const hmac = crypto.createHmac("sha256", app_secret);
  hmac.update(signString);
  const sign = hmac.digest("hex");

  return sign;
};
```

#### Signature algorithm (Python)
```Python
import hmac
import hashlib
from urllib.parse import urlparse
import json

def generate_sign(request_option, app_secret):
    """
    Generate HMAC-SHA256 signature
    :param request_option: Request options dictionary containing qs (query params), uri (path), headers, body etc.
    :param app_secret: Secret key for signing
    :return: Hexadecimal signature string
    """
    # Step 1: Extract and filter query parameters, exclude "access_token" and "sign", sort alphabetically
    params = request_option.get('qs', {})
    exclude_keys = ["access_token", "sign"]
    sorted_params = [
        {"key": key, "value": params[key]}
        for key in sorted(params.keys())
        if key not in exclude_keys
    ]

    # Step 2: Concatenate parameters in {key}{value} format
    param_string = ''.join([f"{item['key']}{item['value']}" for item in sorted_params])
    sign_string = param_string

    # Step 3: Append API request path to the signature string
    uri = request_option.get('uri', '')
    pathname = urlparse(uri).path if uri else ''
    sign_string = f"{pathname}{param_string}"

    # Step 4: If not multipart/form-data and request body exists, append the exact body string to be sent
    content_type = request_option.get('headers', {}).get('content-type', '')
    body = request_option.get('body', {})
    if content_type != 'multipart/form-data' and body:
        if isinstance(body, str):
            body_str = body
        else:
            body_str = json.dumps(body, separators=(',', ':'))  # Keep JSON serialization compact and consistent with the request body
        sign_string += body_str

    # Step 5: Wrap signature string with app_secret
    wrapped_string = f"{app_secret}{sign_string}{app_secret}"

    # Step 6: Encode using HMAC-SHA256 and generate hexadecimal signature
    hmac_obj = hmac.new(
        app_secret.encode('utf-8'),
        wrapped_string.encode('utf-8'),
        hashlib.sha256
    )
    sign = hmac_obj.hexdigest()
    return sign
```

### Step-by-step breakdown
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/9204af7b93b648a4abd51f5969b24bec~tplv-k9wyc2ijk0-image.image)
The following is a step-by-step breakdown of how the signature algorithm works:
📌 **Note**: Feel free to skip straight to the **signature algorithm** sections if you do not need a step-by-step breakdown. We've provided sample code in Go, Java, Node.js, and Python

1. As an example, let's assume you'd like to call the Get Authorized Shops endpoint and your `app_secret` is **e59af819cc**:

```HTTP
curl -X GET \
 'https://open-api.tiktokglobalshop.com/authorization/202309/shops?app_key=29a39d&sign=b596b73e0cc6de07ac26f036364178ab16b0a907af13d43f0a0cd2345f582dc8&timestamp=1623812664' \
-H 'x-tts-access-token: TTP_pwSm2AAAAABmmtFz1xlyKMnwg74T2GJ5s0uQbS8jPjb_GkdFVCxPqzQXSyuyfXdQa0AqyDsea2tYFNVf4XeqgZHFfPyv0Vs659QqyLYfsGzanZ5XZAin3_ZkcIxxS0_In6u6XDeU96k' \
-H 'content-type: application/json'
```

2. Extract all query parameters excluding `sign` and `access_token`. Reorder the parameter keys in alphabetical order:

```Go
keys := make([]string, len(queries))    
idx := 0    
for k := range queries {    
    // params except 'sign' & 'access_token'   
    if k != "sign" && k != "access_token" {    
       keys[idx] = k    
       idx++    
    }    
}    
sort.Slice(keys, func(i, j int) bool {    
    return keys[i] < keys[j]    
})
```

The resulting reordered query keys is:
```Plain Text
keys = []string{    
    "app_key",       
    "timestamp"    
}
```

📌 **Note**: Some API endpoints will require the **shop_cipher** query parameter, which would then be included in the reordered query keys. Please call [Get Authorized Shops](https://partner.tiktokshop.com/docv2/page/get-authorized-shops) to obtain a shop's corresponding **shop_cipher**.

3. Concatenate all the parameters in the format `{key}{value}`:

```Go
// Concatenate all the parameters in the format of {key}{value}  
input := ""    
for _, key := range keys {      
   input = input + key + queries.Get(key)      
}
```

The resulting string becomes:
```Plain Text
app_key29a39dtimestamp1623812664
```

4. Append the string from Step 3 to the API request path. The path for Get Authorized Shops is `/authorization/202309/shops`:

```Plain Text
input = path + input
```

The resulting string becomes:
```Plain Text
/authorization/202309/shopsapp_key29a39dtimestamp1623812664
```

📌 **Note**: If the request header content-type is not multipart/form-data, append the API request body to the string as well. Use the exact body bytes that are sent in the HTTP request. Do not parse and re-serialize or reformat the body for signing, because changes to field order, whitespace, escaping, or charset can produce a different signature.
```Plain Text
input = input + body
```

For example, the [Update Shop Webhook](https://partner.tiktokshop.com/docv2/page/update-shop-webhook) endpoint includes the address and event_type parameters in the API request body (as well as the shop_cipher parameter in the query parameters). This would result in the following:
```Plain Text
/event/202309/webhooksapp_key68xu9ks5p4i8shop_cipherROW_xkMbgAAAeVAQra0eZWebFQq5aIKtimestamp1696909648{"address":"https://partner.tiktokshop.com","event_type":"PACKAGE_UPDATE"}
```

5. Wrap the string generated in Step 4 with your `app_secret`:

```Plain Text
input = app_secret + input + app_secret
```

The final string becomes:
```Plain Text
e59af819cc/authorization/202309/shopsapp_key29a39dtimestamp1623812664e59af819cc
```

6. Encode your wrapped string using **HMAC-SHA256**:

```Go
import (      
   "crypto/hmac"      
   "crypto/sha256"      
   "encoding/hex"      
   "sort"      
)      
/**      
** input: string we created in step 5   
** secret: App secret      
**/      
func generateSHA256(input, secret string) string{      
   // encode the digest byte stream in hexadecimal and use sha256 to generate sign with salt(secret)      
   h := hmac.New(sha256.New, []byte(secret))      
  
   if _, err := h.Write([]byte(input)); err != nil{      
      // TODO error log   
      return ""      
   }      
      
   return hex.EncodeToString(h.Sum(nil))      
}
```

The resulting sign is:
```Plain Text
b596b73e0cc6de07ac26f036364178ab16b0a907af13d43f0a0cd2345f582dc8
```

### Common mistakes
What is the most common reason for encountering the "signature is invalid" error during an API call?

* Frequently, this error occurs when developers use incorrect app keys and secrets to generate the signature. It's essential to verify that the app key and secret match precisely.
* Ensure `sign` and `access_token` are **not** included in the reordered query keys (Step 2).
* For API version `202309` and later, send the access token in the `x-tts-access-token` header. Do not include this header value in the signature string.
* Always ensure that you are using the **HMAC-SHA256** signature method (different from regular SHA-256).
* Ensure that the timestamp is within 5 minutes of the current time when the platform receives the request. The timestamp must be represented as a 10-digit Unix timestamp.
* If the request is not `multipart/form-data`, sign the exact body bytes that you send. Re-serializing JSON can change whitespace, field order, or escaping and cause signature verification to fail.


---

## TikTok Shop API concepts > Common parameters

Doc: https://partner.tiktokshop.com/docv2/page/common-parameters · cập nhật 2026-10-08

When calling TikTok Shop APIs, include the following common parameters unless the endpoint documentation states otherwise.
### Query parameters
| **Parameter** | **Location** | **Type** | **Description** | **Sample** |
| --- | --- | --- | --- | --- |
| `app_key` | Query | string | The unique key assigned to your app. Refer to Create your app to find out where to get your **`app_key`**. | 29a39d |
| `sign` | Query | string | A HMAC-SHA256 hash based on the request parameter values, used by the service to verify the sender of the request in addition to the access token.  Refer to Sign your API request to learn how to generate this signature. | bc721f0e0182914e3487b81df204de37a352fc3aa96947efda6dc1e5dd0d5290 |
| `timestamp` | Query | Unix timestamp | A 10-digit Unix timestamp in seconds, used to ensure timeliness of the request and prevent replay attacks. Do not send a millisecond-level timestamp. This value is also used to generate the digital signature for the **`sign`** parameter.  Valid range: [current time - 5 mins, current time + 30 secs]. Sending an invalid timestamp may cause error `36009004 Invalid timestamp`. | 1623812664 |
### Header parameters
| **Parameter** | **Type** | **Description** | **Sample** |
| --- | --- | --- | --- |
| `x-tts-access-token` | string | The access token used to authenticate the shop or seller authorization for the request. For API version `202309` and later, the access token must be sent in this header instead of the query string. | act.example_access_token |
| `content-type` | string | The request content type. Use `application/json` when sending a JSON request body. | application/json |

> **Version note:** For legacy APIs before version `202309`, some older documents may show `access_token` as a query parameter. For API version `202309` and later, use the `x-tts-access-token` header.

### Endpoint-specific common identifiers
Some endpoints require common business identifiers in addition to the parameters above. Whether these fields are required depends on the specific endpoint. Always follow the endpoint documentation for the exact location, requirement, and allowed value.
| **Parameter** | **Location** | **Type** | **Description** | **Sample** |
| --- | --- | --- | --- | --- |
| `shop_cipher` | Depends on endpoint | string | The encrypted shop identifier. Include this field when the endpoint requires a shop-level identifier. If the field is part of the signed request parameters for the endpoint, include it when generating `sign`. | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMtA |
| `category_asset_cipher` | Depends on endpoint | string | The encrypted category asset identifier. Include this field when the endpoint requires a category asset identifier. If the field is part of the signed request parameters for the endpoint, include it when generating `sign`. | CAT_ASSET_XF90igAAAABh00qsWgtvOiGFNqyubMtA |


---

## TikTok Shop API concepts > Common errors

Doc: https://partner.tiktokshop.com/docv2/page/common-errors · cập nhật 2026-07-06

When making API requests, ensuring the correct structure and format is key to smooth communication with TikTok Shop's servers. This topic covers common gateway and cross-domain errors related to the **request query**, **header**, and **body format**. These fundamental errors occur before business logic processing and must be resolved for a request to be processed successfully.
**Note:**`0` in the response code indicates that the request was successfully processed.
**Business error codes:** This page does not exhaustively list endpoint-specific business errors. For business logic failures, open the corresponding endpoint reference page and check the **Errorcode** section at the bottom of that page. For the full API reference entry point, refer to [TTS API reference docs](https://partner.tiktokshop.com/docv2/page/create-product).
**Recommended troubleshooting path:**

1. Confirm the HTTP status code first, especially `401`, `403`, `404`, `408`, `429`, and `5xx`.
2. Check the API response `code` and `message` together. Some common request-validation failures reuse the same numeric code.
3. If the failure is endpoint-specific, check the endpoint reference page's **Errorcode** section.
4. If the failure is authorization-related, compare the endpoint's required scope with both the app's scopes in Partner Center and the token's `granted_scopes` field.

### Message keyword index for `36009004`
The code `36009004` is reused for multiple different request-validation failures. Do not use the numeric code alone for programmatic branching. Combine it with the response `message` keyword, and log the full response including `request_id`.
| **Message keyword** | **Likely meaning** | **What to check** |
| --- | --- | --- |
| `Missing credentials`, `signature` | The required `sign` query parameter is missing. | Generate a valid signature by referring to Sign your API request. |
| `access_token header is invalid` | The `access_token` header is invalid. | Pass the access token obtained from Get Access Token. |
| `x-tts-access-token header is invalid` | The `x-tts-access-token` header is invalid. | Pass the access token obtained from Get Access Token, and confirm the token belongs to the correct authorization principal. |
| `Invalid app_key` | The `app_key` query parameter is invalid, disabled, deleted, or cannot be resolved. | Check the app key on the **App details** page in **Partner Center**. |
| `timestamp`, `lesser than 0` | The `timestamp` query parameter is negative. | Use a Unix timestamp within the accepted time window. |
| `timestamp`, `earlier than 5 minutes` | The timestamp is too old. | Keep the timestamp within 5 minutes before the current time. |
| `timestamp`, `more than 30 seconds` | The timestamp is too far in the future. | Keep the timestamp no more than 30 seconds beyond the current time. |
| `shop_cipher`, `not required` | The request contains an unnecessary `shop_cipher`. | Remove `shop_cipher` and check the endpoint's required identifier. |
| `category_asset_cipher`, `not required` | The request contains an unnecessary `category_asset_cipher`. | Remove `category_asset_cipher` and check the endpoint's required identifier. |
| `shop_id`, `invalid` | The `shop_id` query parameter is invalid. | Retrieve the correct shop identifier from Get Authorized Shops. |
| `Invalid API version` | The API version is invalid or unsupported. | See the version note in **Parameter errors**. The API versioning guide may use `36009014`, while legacy/common gateway responses may still surface `36009004`; verify the actual response for the endpoint/version being called. |
### General errors
| **Code**  | **Error message**  | **Details and guidance** |
| --- | --- | --- |
| 36009002 | Too many requests. You've made too many requests in a short period of time. | Treat this as a rate-limit condition. The HTTP response should be handled together with the business code: `HTTP 429` and `36009002` both indicate rate limiting. Apply retry/backoff logic, respect `Retry-After` if present, and refer to Rate limits for details. |
| 36009007 | Request timeout. The request to the endpoint timed out. | Please try again, or consider splitting it into smaller requests. |
| 36009009 | Invalid path. The specified path does not match any available endpoint. | Refer to the API documentation for details. |
| 36009010 | Invalid method. The HTTP method used is not supported by this endpoint. | Refer to the API documentation for details. |
| 36009021 | Invalid file size. The uploaded file size exceeds the maximum limit. | Refer to the API documentation for details. |
| 36009022 | Invalid request format. The request body format must be `application/json` for structured data or `multipart/form-data` for binary files. | Refer to the API documentation for details. |
| 36009023 | Invalid request format. The value of the `content-type` header must be `multipart/form-data`. | Refer to the API documentation for details. |
### Authorization errors
| **Code**  | **Error message**  | **Details and guidance** |
| --- | --- | --- |
| **105005** | **Access denied. The app is not authorized to access the endpoint because the access scopes granted for the app or the access token do not contain the required access scope for the endpoint.** | **Most common access-scope failure. Check this first when an API call fails with "Access denied" or when calls from Developer Tool / API Testing Tool fail after app setup.**     Suggested checks:    1. Check the granted scopes for the app in **Partner Center** > **App & Service** > **Manage API**. If the required scope is missing, apply or enable it in Partner Center.    2. Check the granted scopes for the token in the `granted_scopes` field of the Get Access Token response. If the required scope is missing, request the user to reauthorize the required scope, and then generate a new token accordingly. |
| 101000 | Invalid query or header. The `category_asset_cipher` query parameter or `x-tts-access-token` header is invalid. | For `category_asset_cipher`, ensure you retrieve the correct value from the Get Authorized Category Assets endpoint.      For `x-tts-access-token`, possible causes include:    - The token has an invalid `user_type` for this endpoint. See the `user_type` value definitions in Generate a test access token, and check the endpoint's entity tag in API entity tags to confirm whether it expects a seller, creator, partner, shop, or asset-level token.    - The token is not associated with a shop, or the associated shop does not match the provided `shop_cipher` query parameter.      Refer to the authorization guide for details. |
| 36009033 | Access denied. Your IP address is not in the IP allow list configured for this app. | Add your IP address in **Partner Center** > **App & Service**. |
### Authentication errors
| **Code**  | **Error message**  | **Details and guidance** |
| --- | --- | --- |
| 105002 | Expired credentials. The `access_token` or `x-tts-access-token` header has expired. | Refresh your token by using the Get Refresh Token endpoint. |
| 106001 | Invalid credentials. The `sign` query parameter is invalid. | Ensure you generate a valid signature by referring to the guide on signing your request. |
| 36009004 | Missing credentials. The request does not include a required signature in the query. | Generate a signature by referring to the guide on signing your request. |
| 36009004 | Invalid credentials. The `access_token` header is invalid. | Please pass in the `access_token` you obtained from the Get Access Token endpoint. |
| 36009004 | Invalid credentials. The `x-tts-access-token` header is invalid. | Please pass in the `access_token` you obtained from the Get Access Token endpoint. |
| 36009004 | Invalid credentials. Invalid `app_key` query parameter. | Possible reasons include an invalid key format, the app not being found, the app being disabled or deleted, or there was an error in retrieving the required authorization. Ensure you are retrieving the correct value from the **App details** page in **Partner Center**. |
| 36009004 | Invalid timestamp. The value of the `timestamp` query parameter must not be lesser than 0. | Timestamps must lie within the range of 5 minutes before to 30 seconds beyond the current time. |
| 36009004 | Invalid timestamp. The value of the `timestamp` query parameter must not be earlier than 5 minutes before the current time. | Timestamps must lie within the range of 5 minutes before to 30 seconds beyond the current time. |
| 36009004 | Invalid timestamp. The value of the `timestamp` query parameter must not exceed the current time by more than 30 seconds. | Timestamps must lie within the range of 5 minutes before to 30 seconds beyond the current time. |
### Parameter errors
| **Code**  | **Error message**  | **Details and guidance** |
| --- | --- | --- |
| 106013 | Missing identifier. The `shop_cipher` query parameter is required to identify the target shop. | Retrieve this value from the Get Authorized Shops endpoint. |
| 36009004 | Unexpected identifier. The `shop_cipher` query parameter is not required for this request. | Remove it and try again. Refer to the API documentation for details on the identifier required. |
| 36009004 | Unexpected identifier. The `category_asset_cipher` query parameter is not required for this request. | Remove it and try again. Refer to the API documentation for details on the identifier required. |
| 36009004 | Invalid identifier. The `shop_id` query parameter is invalid. | Retrieve the correct value from the Get Authorized Shops endpoint. |
| 36009014 / 36009004 | Invalid API version. The `version` value is invalid or unsupported. | The API versioning topic identifies invalid API versions with `36009014`, while older/common gateway examples may show `36009004` with the same `Invalid API version` message. Until all docs and runtime responses are aligned, handle this condition by checking both the code and the `Invalid API version` message keyword, and verify the actual response for the endpoint/version you are calling. Refer to TTS API versioning and the endpoint reference page for valid versions. |
| 36004004 | Invalid auth code. | The `auth_code` has already been used, is expired, or is invalid. |


---

## TikTok Shop API concepts > Regions and languages

Doc: https://partner.tiktokshop.com/docv2/page/regions-and-languages · cập nhật 2026-07-06

### Introduction
TikTok Shop supports retrieval of text data for different regions in a variety of languages through language tags that follow [IETF BCP 47 language tag syntax (RFC 5646)](https://www.rfc-editor.org/rfc/rfc5646).
> **Important:** Locale support can vary by API. The locale codes specified in the endpoint reference documentation take precedence over this page. If an endpoint lists a smaller set of supported locale codes, use that endpoint-specific set.
> `zh-CN` is available only for retrieving machine-translated Chinese reference text in supported multilingual scenarios for global sellers based in China. `zh-CN` is not a default locale for any supported region and is not supported for writing Chinese text into text fields.
> Region and locale availability may change as TikTok Shop opens or updates markets. Use the latest platform market availability and endpoint reference documentation as the source of truth. Last updated: July 6, 2026.

### Supported languages
You can pass the following locale codes in APIs that support localization to obtain text data in the corresponding language.
| **Language** | **Locale codes** |
| --- | --- |
| English | en-GB, en-IE, en-PH, en-SG, en-US |
| French | fr-FR |
| German | de-DE |
| Indonesian | id-ID |
| Italian | it-IT |
| Japanese | ja-JP |
| Malay | ms-MY |
| Portuguese | pt-BR |
| Spanish | es-ES, es-MX |
| Thai | th-TH |
| Vietnamese | vi-VN |
> **Note:** For global sellers based in China, you can pass `zh-CN` to obtain machine-translated Chinese versions of property text for reference if the property supports multilingual content. However, specifying Chinese text in text fields is not supported.

### Region-to-locale mapping
Use the default locale code for a region unless the endpoint reference explicitly supports another locale code. Optional locale codes are endpoint-specific; do not infer unsupported locale codes from a country code, language name, or browser locale.
| **Country** | **Country code** | **Default locale code** | **Optional locale code rule** |
| --- | --- | --- | --- |
| Brazil | BR | pt-BR | Use only locale codes listed or accepted by the endpoint reference. |
| France | FR | fr-FR | Use only locale codes listed or accepted by the endpoint reference. |
| Germany | DE | de-DE | Use only locale codes listed or accepted by the endpoint reference. |
| Indonesia | ID | id-ID | Use only locale codes listed or accepted by the endpoint reference. |
| Ireland | IE | en-IE | Use only locale codes listed or accepted by the endpoint reference. |
| Italy | IT | it-IT | Use only locale codes listed or accepted by the endpoint reference. |
| Japan | JP | ja-JP | Use only locale codes listed or accepted by the endpoint reference. |
| Malaysia | MY | ms-MY | Use only locale codes listed or accepted by the endpoint reference. |
| Mexico | MX | es-MX | Use only locale codes listed or accepted by the endpoint reference. |
| Philippines | PH | en-PH | Use only locale codes listed or accepted by the endpoint reference. |
| Singapore | SG | en-SG | Use only locale codes listed or accepted by the endpoint reference. |
| Spain | ES | es-ES | Use only locale codes listed or accepted by the endpoint reference. |
| Thailand | TH | th-TH | Use only locale codes listed or accepted by the endpoint reference. |
| United Kingdom | GB | en-GB | Use only locale codes listed or accepted by the endpoint reference. |
| United States | US | en-US | Use only locale codes listed or accepted by the endpoint reference. |
| Vietnam | VN | vi-VN | Use only locale codes listed or accepted by the endpoint reference. |
`zh-CN` is intentionally excluded from the default locale column because it is not a supported default or writable locale for any region.
### Supported regions
| **Country** | **Country code** | **Default locale code** |
| --- | --- | --- |
| Brazil | BR | pt-BR |
| France | FR | fr-FR |
| Germany | DE | de-DE |
| Indonesia | ID | id-ID |
| Ireland | IE | en-IE |
| Italy | IT | it-IT |
| Japan | JP | ja-JP |
| Malaysia | MY | ms-MY |
| Mexico | MX | es-MX |
| Philippines | PH | en-PH |
| Singapore | SG | en-SG |
| Spain | ES | es-ES |
| Thailand | TH | th-TH |
| United Kingdom | GB | en-GB |
| United States | US | en-US |
| Vietnam | VN | vi-VN |
> **Note:** Some locale codes may not be supported in certain APIs. The locale codes specified in the endpoint reference documentation take precedence.


---

## TikTok Shop API concepts > Rate limits

Doc: https://partner.tiktokshop.com/docv2/page/rate-limits · cập nhật 2026-09-03

### Overview
The TTS Open Platform uses a dynamic QPS allocation mechanism. Your effective request capacity is calculated from multiple factors, including authorized shop scale, API resource characteristics, endpoint load, and platform-level protection rules.
Key principles:

* The platform does not expose a single fixed QPS query API for all endpoints.
* Endpoint reference documentation, if it publishes a specific limit or counting rule, takes precedence over this page.
* Build a self-adaptive client that reacts to throttling signals, smooths request bursts, uses batch APIs, caches hot data, and retries with exponential backoff plus jitter.
* A throttling response does not always mean your app alone exceeded its app-shop quota. It can also be caused by endpoint-level or platform-level protective throttling.

### 1. Why API Rate Limiting Exists
API rate limiting is a foundational mechanism that keeps the platform stable and fair. It serves two goals:

* **Platform stability**: prevents traffic spikes from overloading the service and degrading access quality for everyone.
* **Fair resource allocation**: distributes platform capacity equitably among developers, so a few apps cannot monopolize resources at the expense of others.

We strongly recommend every developer adopt industry-standard throttling, caching, batching, and retry patterns to build resilient applications.
### 2. Dynamic QPS Allocation
#### 2.1 How Quota Is Calculated
Instead of a one-size-fits-all fixed quota, the platform computes effective request capacity dynamically.
| **Dimension** | **How It Affects Capacity** |
| --- | --- |
| **App authorization scale** (number of authorized shops) | Authorized shop count is a major input to your aggregate capacity. In general, more authorized shops means more total capacity, but the relationship is not guaranteed to be strictly linear. It may be stepwise, endpoint-weighted, and adjusted by platform conditions. Authorization changes may also take time to take effect across all rate-limit systems. |
| **API resource characteristics** (per-endpoint tiering) | Lightweight read APIs usually have higher tolerance than heavy read, write, or complex analytics APIs. Endpoint reference documentation takes precedence if it specifies a different limit, counting rule, or retry behavior. |
| **Real-time platform load** | The ceiling for an endpoint can be adjusted dynamically based on service health, traffic spikes, or protective controls. |
#### 2.2 Capacity Planning Baseline
Because the platform quota is dynamic and endpoint-specific, the following values are **not guaranteed platform limits**. Use them only as conservative starting points for client-side throttling, capacity estimates, and load-test baselines when endpoint reference documentation does not publish an explicit value.
| **API type** | **Suggested initial dispatch target per App ID x Authorized Shop** | **How to use it** |
| --- | --- | --- |
| Heavy write APIs or complex analytics | 0.2-1 request/second | Start low, queue requests, and ramp only after sustained success without throttling. |
| Standard write APIs | 1-3 requests/second | Use idempotency keys or equivalent safeguards before enabling retries. |
| Standard read or sync APIs | 3-10 requests/second | Prefer incremental sync and avoid full pulls. |
| Lightweight read or batch APIs | 5-20 requests/second | Batch where possible and monitor 429 / `36009002` rates during ramp-up. |
Recommended ramp-up pattern:

1. Start from the low end of the relevant range.
2. Increase traffic gradually, for example by 20-30% every 10-15 minutes.
3. Stop ramping immediately when throttling, latency spikes, or error rates increase.
4. Treat the observed stable rate as an operational baseline, not as a guaranteed quota.

#### 2.3 How Shop Scale Affects Capacity
Expanding shop authorization scale is the most direct way to increase aggregate capacity, but do not assume exact linear scaling.

* The total capacity generally increases as more shops authorize the same app.
* Capacity is still affected by endpoint tiering, platform load, and protective controls.
* Newly authorized shops may not raise effective capacity immediately in every internal rate-limit layer.
* For large promotions, migration bursts, or traffic peaks, validate capacity with gradual ramp tests.

### 3. Rate Limit Isolation and Trigger Dimensions
The minimum shop-scoped isolation unit is the **App ID x Authorized Shop** combination.
| **Dimension** | **When It Applies** | **What It Means** | **Developer Action** |
| --- | --- | --- | --- |
| App ID x Authorized Shop | Shop-scoped endpoints called with a valid shop authorization | The same shop authorized to different apps has independent app-shop capacity. The same app authorized to multiple shops has separate shop-level isolation units. | Throttle separately per app-shop pair. Do not let one shop's traffic consume another shop's queue. |
| App ID x endpoint or resource | App-level endpoints, or endpoints where no shop-level authorization applies | Some endpoints may be governed at the app/resource level rather than by shop. | Maintain endpoint-level limiters in addition to shop-level limiters. |
| Endpoint platform protection | Any endpoint during platform-wide traffic spikes or service pressure | The platform may temporarily lower available capacity for all callers, independent of your app's normal request rate. | Back off and retry. Do not assume adding shops immediately resolves this condition. |
| Abuse, security, or network protection | Abnormal bursts, high concurrency, suspicious patterns, or infrastructure-level controls | Additional controls may apply outside the normal app-shop quota model, including IP or traffic-pattern protection. | Smooth traffic, reduce concurrency, and contact support if throttling persists at very low request volume. |
| Unauthorized or unbound shop | Requests for shops that have not authorized the app, or invalid shop identifiers | This is usually an authorization or request validation problem, not a usable shop-level quota. | Fix authorization or shop identity first. Do not treat it as capacity. |
Implementation tip: Do not hard-code one global QPS threshold. Use separate limiters by app, shop, endpoint, and operation type, then adapt dynamically to throttling responses.
### 4. Throttling Signals and Response Handling
#### 4.1 HTTP Status and Business Code Relationship
Rate limiting may be surfaced through both the HTTP layer and the response body:
| **Signal** | **Meaning** | **How to Handle** |
| --- | --- | --- |
| HTTP `429 Too Many Requests` | Transport-level throttling signal. | Treat as rate limited. Stop new requests for the affected limiter and retry with backoff. |
| Business code `36009002` | OpenAPI business error code for rate limiting or request frequency control. | Treat as rate limited even if your HTTP client or SDK surfaces the HTTP status separately. |
| HTTP `429` with body code `36009002` | The clearest rate-limit response: both transport and business layers agree. | Treat as rate limited. Log both fields for diagnosis. |
If either HTTP status `429` or business code `36009002` appears, handle the response as a throttling event. For monitoring, record both HTTP status and business code because SDKs, gateways, and logs may expose them differently.
#### 4.2 429 vs. 503
Distinguishing `429` from `503` is the prerequisite for a robust client.
| **HTTP Status** | **Root Cause** | **Action** |
| --- | --- | --- |
| `429 Too Many Requests` | Your app exceeded the dynamically allocated capacity within the current isolation unit, or the endpoint hit platform-level protective throttling. | Stop sending new requests for the affected limiter. Retry using `Retry-After` if present, otherwise exponential backoff plus random jitter. Never retry immediately at high frequency. |
| `503 Service Unavailable` | Not a rate limit. The underlying service may be overloaded, temporarily unavailable, or under maintenance. | Retry after a short wait. If it persists, check developer announcements or contact technical support to verify whether a known incident is in progress. |
### 5. Best Practices
#### 5.1 Use Batch APIs
The platform offers batch endpoints for many scenarios. Wherever a batch endpoint exists, do not loop the single-item endpoint. Collapsing N calls into one request is the most effective way to stay below the rate limit.
Batch endpoints are typically counted as one call per HTTP request, not per item in the batch, unless the endpoint documentation states otherwise.
#### 5.2 Use Request Queues and Throttling
Maintain an internal request queue and dispatch at a smooth, controlled rate. Avoid bursts where many requests fire within a single second. Apply throttling separately by App ID, shop, endpoint, and operation type.
#### 5.3 Fetch Only What You Need
Trim API requests to the minimum fields and volume your business actually requires. Avoid full-table pulls when incremental sync, cursor-based pagination, or changed-since filters are available.
#### 5.4 Cache Hot Data
Cache low-churn, high-read data such as product master data, shop configuration, category mappings, and reference dictionaries on your side. This drastically reduces unnecessary API traffic.
#### 5.5 Build Idempotent Writes and Tiered Error Handling

* Make write operations idempotent so retries cannot produce duplicates or dirty data.
* Distinguish `429`, business code `36009002`, `503`, other business errors, and network errors.
* Apply the right response to each class instead of using one retry policy for everything.

#### 5.6 Use Exponential Backoff, Jitter, and Retry-After
When you receive HTTP `429` or business code `36009002`, retry with exponential backoff plus jitter. If the response includes a `Retry-After` header, honor it as the minimum wait time.
```Plain Text
wait = max(retry_after_seconds, min(base_delay * (2 ** retry_count) + random_jitter, cap))
```

Key parameters:

* `Retry-After`: if present, may be seconds or an HTTP date. Use it to avoid retrying earlier than the platform requested.
* `base_delay`: start at 1 second when no `Retry-After` header is present.
* Exponential growth: double the wait time on each failure, for example 1s -> 2s -> 4s -> 8s.
* `cap`: cap locally generated backoff, for example at 60 seconds. If `Retry-After` is longer, honor it or surface an alert instead of retrying early.
* `random_jitter`: add a small random offset, for example 0-500ms, to prevent multiple instances from synchronizing retries and creating a new spike.
* `max_retry_count`: set a maximum retry count, for example 5. Beyond that, alert or fall back to a degraded path.

Python reference implementation:
```Python
import random
import time
from datetime import datetime, timezone
from email.utils import parsedate_to_datetime
from typing import Optional

def parse_retry_after(value: Optional[str]) -> Optional[float]:
    if not value:
        return None

    try:
        return max(0.0, float(value))
    except ValueError:
        pass

    try:
        retry_at = parsedate_to_datetime(value)
        if retry_at.tzinfo is None:
            retry_at = retry_at.replace(tzinfo=timezone.utc)
        return max(0.0, (retry_at - datetime.now(timezone.utc)).total_seconds())
    except Exception:
        return None

def backoff_sleep(
    retry: int,
    retry_after: Optional[str] = None,
    base: float = 1.0,
    cap: float = 60.0,
) -> None:
    generated_wait = min(base * (2 ** retry) + random.uniform(0, 0.5), cap)
    header_wait = parse_retry_after(retry_after)
    wait = max(generated_wait, header_wait) if header_wait is not None else generated_wait
    time.sleep(wait)
```

### 6. FAQ
#### Q1: How do I know exactly how much QPS quota my app gets?
Quotas are computed dynamically. The platform does not expose a fixed quota query API for all endpoints. Use endpoint reference documentation first if it publishes an explicit limit. Otherwise, use the capacity planning baseline in section 2.2 as a conservative starting point, then measure your stable rate through gradual ramp-up and throttling metrics.
#### Q2: My business is growing fast. How do I increase my QPS quota?
The core idea of the dynamic allocation mechanism is that aggregate capacity generally grows with authorized shop scale. The most direct and recommended path is to expand your shop authorization scale.
However, do not assume every added shop increases every endpoint's QPS by the same fixed amount. The relationship may be non-linear, endpoint-weighted, stepwise, and affected by platform load. Authorization changes may also have propagation delays. For peak events, ramp gradually.
#### Q3: I rarely send requests. Why do I still see 429 or 36009002 occasionally?
Common causes include:

1. **Sub-second bursts**: even when average QPS is low, several requests in the same second can trigger throttling. Use a request queue to smooth dispatch.
2. **Platform-level protective throttling**: when an endpoint's platform-wide load reaches a protective threshold, the platform may temporarily lower capacity for all callers. This is independent of your normal app request rate.
3. **Concurrency contention within the same isolation unit**: multiple app instances can stack requests within millisecond windows even if each instance appears safe alone.
4. **Endpoint-level constraints**: some endpoints may have stricter resource-level limits than your overall app-shop capacity.

The handling is the same: reduce concurrency, back off, honor `Retry-After` if present, and retry with jitter.
#### Q4: How is QPS counted for batch endpoints vs. single-item endpoints?
Batch endpoints are typically counted as one call per HTTP request, not per item in the batch. Whenever a batch endpoint is available, prefer it. Refer to each endpoint's documentation for its exact counting rule.
#### Q5: Should I retry every 429 or 36009002 response?
Retry only after backoff. Immediate high-frequency retries can worsen throttling and extend the restriction. For write APIs, retry only when the operation is idempotent or protected by an idempotency mechanism.


---

## TikTok Shop API concepts > API versioning

Doc: https://partner.tiktokshop.com/docv2/page/api-versioning · cập nhật 2026-07-06

API versioning enables TikTok Shop to continuously improve and expand API capabilities while maintaining a seamless integration experience as APIs evolve.
When breaking changes are introduced to TikTok Shop APIs, these changes are rolled out through new API versions. Breaking changes may be necessary to improve functionality, introduce new capabilities, or enhance security. To keep integrations stable and benefit from newer capabilities, developers should regularly review supported versions and upgrade when needed.
For examples of both non-breaking and breaking changes, use the [changelog](https://partner.tiktokshop.com/docv2/changelog) as the source of truth instead of relying on fixed examples in this page. Changelog entries are updated over time and may include categories such as API updates, new endpoint releases, field additions, migration notices, breaking changes, and retirement notices.
### API release schedule and version naming
New API versions are generally rolled out on a monthly basis, but not every API is updated every month.
The API version name, such as `202303`, is derived from the year and month when that API version was launched.
### Selecting API versions in API reference docs
API versions are assigned at the API level, meaning different APIs may support different version lists at the same time. Do not use a hardcoded example to decide the latest version of an API.
The API reference page displays the latest supported version of that API by default. Use the version dropdown menu on the reference page to confirm which versions are currently supported for the API you are calling. By clicking a version name in the dropdown menu, you can access the reference doc for that specific API version.
Different APIs from different versions can generally be used together, but integrations should be tested thoroughly. In most cases, use the latest supported version shown on the API reference page for each endpoint. If your integration depends on multiple related APIs, test the version combination before release.
![Image](https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/fdd7aa43e905434bbca6f2d5b67b6a6d~tplv-k9wyc2ijk0-image.image)
### Specifying an API version when calling an API
Starting with the `202309` API style, the API version is part of the request path. For more migration details, refer to Upgrading to 202309 and Methods and endpoints.
Use the endpoint path exactly as shown in the API reference page when generating the request signature.
| API style | URI pattern | Version location |
| --- | --- | --- |
| Legacy API style | `https://open-api.tiktokglobalshop.com/{legacy_resource}?version={version}&app_key={app_key}&timestamp={timestamp}&sign={sign}` | Query parameter |
| `202309` and later API style | `https://open-api.tiktokglobalshop.com/{category}/{version}/{resource}?app_key={app_key}&timestamp={timestamp}&sign={sign}` | Path segment |
Example for the `202309` and later API style:
```HTTP
GET https://open-api.tiktokglobalshop.com/authorization/202309/shops?app_key={app_key}&timestamp={timestamp}&sign={sign}
```

When calculating the signature for `202309` and later APIs, include the path exactly as shown after the host, including the category, version, and resource segments, for example `/authorization/202309/shops`.
### Upgrading to a new API version
Before upgrading to a new API version, read both the changelog and the API reference docs for the target version. Check for changes in path, method, headers, query parameters, request body, response body, error codes, field meanings, market availability, and authorization scope requirements.
Use the version dropdown menu on the API reference page to compare supported versions of the same API. If a separate migration guide is available, such as Upgrading to 202309, follow that guide together with the endpoint reference page.
### Retiring a version of an API
After a new version of an API is released, the prior version remains available for a minimum of 2 months. This is the minimum availability window counted from the new version release.
When an API version is scheduled for permanent retirement, the retirement announcement is communicated through the [changelog](https://partner.tiktokshop.com/docv2/changelog) at least 2 months before the permanent retirement date. This is the retirement notice window counted backward from the permanent retirement date.
These two 2-month windows describe different lifecycle checkpoints. They should be read as the following timeline:
| Timeline node | What happens | Timing rule |
| --- | --- | --- |
| 1. New version released | A newer API version becomes available in the API reference page. | Start of the new version lifecycle. |
| 2. Prior version minimum availability | The prior version remains callable after the new version release. | Minimum 2 months after the new version release. |
| 3. Retirement announcement | If the prior version is scheduled for permanent retirement, a changelog notice is posted. | At least 2 months before permanent retirement. |
| 4. Permanent retirement | The retired version is no longer supported. Calls to that version may fail. | Effective on the retirement date stated in the changelog. |
If you use a retired or invalid version, the API may return an error indicating that the API version is not supported.
```JSON
{
  "code": 36009014,
  "data": null,
  "message": "The version name is invalid, please check and retry."
}
```

Some common gateway or legacy examples may surface `36009004` with an `Invalid API version` message for the same general condition. Until the runtime behavior is fully aligned across docs and endpoints, handle invalid-version failures by checking both the response `code` and the `message` text, and log the `request_id` for troubleshooting. This should be kept consistent with Common errors.
### Staying updated
#### Changelog
The [changelog](https://partner.tiktokshop.com/docv2/changelog) is the primary source for API changes, including new versions, new endpoints, non-breaking updates, migration notices, breaking changes, and retirement notices. Regularly checking the changelog helps you plan upgrades early and avoid calling retired versions.

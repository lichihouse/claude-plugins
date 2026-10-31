# API calls

> Nhóm: Getting Started · nguồn: https://open.shopee.com/developer-guide/16

**⚠️** * Note: This guide only applies to making API calls for Shopee Open API v2.0.*

# **API domains**

 

There are 3 domains available: 

- Production environment 
  - [*https://openplatform.shopee.cn/*](https://openplatform.shopee.cn/)   — for developers who deployed their services near Chinese Mainland.
  - [*https://openplatform.shopee.com.br/*](https://openplatform.shopee.com.br/) — for developer  who deployed their services near US.
  - [*https://partner.shopeemobile.com/*](https://partner.shopeemobile.com/)  — for developer who deployed their services near SG.
- Sandbox environment
  - [*https://openplatform.sandbox.test-stable.shopee.sg/*](https://openplatform.sandbox.test-stable.shopee.sg) — for All developers
  - [*https://openplatform.sandbox.test-stable.shopee.cn/*](https://openplatform.sandbox.test-stable.shopee.cn/)  —for Chinese Mainland developers

 

Select the correct domain name, based on the server location you’re accessing the Open API from.

# **API request methods**

 

Currently, Open API only provides two request methods: **GET** and **POST**.

 

# API Protocol

HTTP/JSON for most APIs. HTTP/FORM for some certain APIs, for example, the API for uploading files.

 

# **API request parameters**

 

In the API document, you will see two types of request parameters:

1.  Common parameter
2.  Request parameter

 

For **GET**-type APIs, these two parameters may exist at the same time, or only the common parameter will exist. 

 

For **POST**-type APIs, these two parameters will exist at the same time.

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=sPZ86F%2FKQhIBn25dCIy5b3nU7xjEI9wxHYIbtVKfV5i2hclNI7gNZVnVE1%2FBfzEmL0ZPkUaVxRni%2BDzi%2FKEfdQ%3D%3D&image_type=png)

 

The table below consists of descriptions for common parameters: 

[TABLE]

# **Types of Open API**

 

In the API document, there are 3 API types due to the different common parameters. The public parameters contained in these 3 types are as follows:

- **Shop API**: partner_id, timestamp, sign, access_token, shop_id
- **Merchant API**: partner_id, timestamp, sign, access_token, merchant_id
- **Public API**: partner_id, timestamp, sign

 

**⚠️** * Note: Red items are highlighted to indicate that they are different from Public API.*

 

The Public API does not require an access token, while both the Shop and Merchant APIs do. 

This means that Shop and Merchant APIs can be called only after the shop has granted authorization.

 

Currently, only Shopee cross-border merchants need to use Merchant API. Local sellers do not need to use it.

# **Signature calculation**

 

**Step 1: Create a base string:**

Different types of APIs contain different elements in its base string. Concatenate the API path (without host) and the following common parameters into a single string. You should strictly follow the sequence (base string) as shown below: 

 

\*API path example：/api/v2/auth/token/get

 

**Shop API:** partner_id, api path, timestamp, access_token, shop_id

\*Example：

partner_id: 2001887

API path: /api/v2/shop/get_shop_info

timestamp: 1655714431

access_token: 59777174636562737266615546704c6d

shop id: 14701711

 

Base string=2001887/api/v2/shop/get_shop_info165571443159777174636562737266615546704c6d14701711

 

**Merchant API**: partner_id, api path, timestamp, access_token, merchant_id

\*Example:

partner_id: 2001887

API path: /api/v2/global_product/get_category

timestamp: 1655714431

access_token: 09777174636962737266615546704c6d

merchant_id: 1000000

 

Base string=2001887/api/v2/global_product/get_category165571443109777174636962737266615546704c6d1000000

 

**Public API:** partner_id, api path, timestamp

\*Example:

partner_id:2001887

API path: /api/v2/public/get_shops_by_partner

timestamp:1655714431

 

Base string=2001887/api/v2/public/get_shops_by_partner1655714431

 

**Step 2: Calculate the signature using the HMAC-SHA256 algorithm**

Calculate the signature by using the HMAC-SHA256 hashing algorithm on the base string and partner Key (obtained through the [*Shopee Open Platform Console App detail page*](https://open.shopee.com/myconsole/management/app?from=header)). The output of the hash function is a hex-encoded string.

 

\*Example：

sign=56f31d01aeda9d08bf456b37f6f6640ef8614b4d6ad49baafe30b39a061f0e26

 

Find out why you may encounter the [*“Wrong sign” error*](https://open.shopee.com/faq?top=162&sub=166&page=1&faq=188) and how you can resolve the issue.

 

**Sample of Code:**

``` python
#!/usr/bin/envpython

# encoding:utf-8

import hmac 

import time

import requests

import hashlib

timest=int(time.time())

host="https://partner.shopeemobile.com 

access_token = "random string"

partner id =80001

partner key = "test....."

#### call shop level api 

shop id =209920

base string ="%s%s%s%s%s"%(partner id, path timest access token, shop id) 

sign = hmac.new( partner key,base string,hashlib.sha256)hexdigest() 

path ="/api/v2/example/shop level/get"

url = host + path + "?partner_id=%s&shop_id=%s&timestamp=%s&access_token=%s&sign=%s"%(partner_id, shop_id, timest, access_token, sign) 

headers={"Content-Type":"application/ison"? 

resp=requests.post(urlheaders=headers)

#### call merchant level api 

merchant id =1234567

base string ="%s%s%s%s%s"%(partner id, path timest, access token, merchant id) 

sign =hmac.new( partner key,base string,hashlib.sha256).hexdigest() 

path ="/api/v2/example/merchant_level/get"

url = host+ path +"?partner id=%s&merchant id=%s&timestamp=%s&access token=%s&sign=%s"%(partnerid, merchant id, timest, access token, sign) 

headers ={"Content-Type":"application/ison"? resp =requests.eet(urlheaders=headers)

#### call public api

base string ="%s%s%5%s"%(partner idpathtimestaccess token)

sign= hmac.new( partner keybase stringhashlib.sha256)hexdigest() 

path ="/api/v2/auth merchant/access token/get"

url = host+path+"?partner id=%s&timestamp=%s&sign=%s%(partner idtimest, sign)

body ={"partner id":partner id, "merchant id": merchant id,"refresh token":"testingtoken") 

headers =["Content-Type":"application/ison"?

resp =requests.post(url,json=bodyheaders=headers)
```

# **API request sample**

 

For **GET**-type API requests, you need to put **both the common parameters and request parameters in the URL**. 

 

For example: [*V2.product.get_category*](https://open.shopee.com/documents/v2/v2.product.get_category?module=89&type=1) 

 

API request URL:

*https://partner.shopeemobile.com/api/v2/product/get_category?partner_id=851249&timestamp=1654673582&shop_id=1001094&access_token=367a0a8eb9d1837cbf7c43b587a0faa4&sign=a40fc50a08c382eeee08e2eb00deb8464c6fdcbe4f1c271e033cdbca3ded4d5b&language=zh-hans*

 

*\*For this API endpoint，partner_id、timestamp、access_token、shop_id and sign are common parameters. Meanwhile, language is a request parameter.*

 

 

For **POST**-type API requests, you need to insert common parameters in the request URL and request parameters in the request body. 

 

For example:[*v2.shop.update_profile*](https://open.shopee.com/documents/v2/v2.shop.update_profile?module=92&type=1) 

 

API request URL:

*https://partner.shopeemobile.com/api/v2/shop/update_profile?partner_id=851249&timestamp=1654673582&shop_id=1001094&access_token=367a0a8eb9d1837cbf7c43b587a0faa4&sign=80cbce8da907d5a1237711409920fc16908a9f9e01b1254ff9cc44aaf0836122*

 

Request body:

{

"shop_logo": "https://cf.shopee.sg/file/8424390be4677b0b3c37ce6499ce261a",

"description": "TTest",

"shop_name": "123"

}

 

*\*For this API endpoint，partner_id、timestamp、access_token、shop_id、and sign are common parameters. Meanwhile, shop_logo、description and shop_name are request parameters.*

# **API response parameters**

[TABLE]

# **API functions**

[TABLE]

# **Problems with API**

If you encounter problems during the API integration process, you may refer to the [*FAQ*](https://open.shopee.com/faq?top=162&sub=169&page=1&faq=) page for help. If your problem persists, you can [*raise a ticket*](https://open.shopee.com/myconsole/ticket-system/raise-ticket).

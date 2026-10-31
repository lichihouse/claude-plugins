# Promotion — tài liệu chi tiết

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.




---

## Promotion API overview

Doc: https://partner.tiktokshop.com/docv2/page/promotion-api-overview · cập nhật 2025-04-11

TikTok Shop provides you with a variety of promotion activities with which you can create a rich shopping experience for TikTok users.
You can use Promotion APIs to create and manage three kinds of promotion activities on TikTok Shop: 

* Product Discount
* Flash Deal
* Coupon in the US / Voucher in other districts (You cannot use OpenAPI to create coupon activities.)

> Notes:

> * All three of the above activities are seller promotion activities which are 100% funded by the seller on TikTok Shop.
> * When a product is listed in both a flash deal promotion and a product discount promotion, only the flash deal price is effective. 
> * When a product is listed in both a flash deal and a TikTok campaign, the campaign price will always be effective.
> * Coupons are always applicable whether or not the product is listed in other promotion activities or a TikTik campaign.

##### Product Discount
You can use the Product Discount activity to create discounts for your specific products. The prices after discount are shown with the original prices crossed out. Here's an example:
(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/40b6766f105c4916a78027cd85465bbe~tplv-k9wyc2ijk0-image.image)

You can apply the activity on product detail pages, livestreams, and showcases. The visual effects are almost the same in these scenarios.
There are two discount types: 

* Fixed Price: Specify the final price after discount.
* Percentage Off: Specify the portion of the deduction amount to the original price.

##### Flash Deal
You can use the Flash Deal activity to create discounts for your specific products. The products in a flash deal will be highlighted with a limited-time countdown. Here's an example:
(ảnh: https://p16-arcosite-sg.ibyteimg.com/tos-alisg-i-k9wyc2ijk0-sg/ed42ed826f6d41b6bf858aa24f0f5c57~tplv-k9wyc2ijk0-image.image)

The deal price for each product needs to be equal to or lower than the price paid by customers in the last 30 days.
##### Coupon / Seller Voucher
You can use coupon activities in the US, or seller voucher activities in other districts, in combination with other promotional activities. You can set this up in the Seller Center, and the visual effect of the coupon depends on your setting.
You cannot set this up using OpenAPI, but you can search for and get the details of the existing coupon activities.

#### API List
You can create and manage your promotion activities in Seller Center and Seller App; you can also do that with Promotion APIs. Here's the list of Promotion APIs:

* To manage product discount or flash deal activities, refer to:
   * [Create Activity](650c33c155bc3202b762b507);
   * [Search Activities](650acfbaf1fd3102b9315a3a);
   * [Get Activities](650acd920fcef602bf36ee2b);
   * [Update Activity](650c584d82c3a602befa4ab8);
   * [Deactivate Activities](650acf9adefece02be7380cf).
* To update the products included in a product discount or a flash deal activity, refer to:
   * [Update Activity Product](650d32c42aaa3602b86ccb5c);
   * [Remove Activity Product](650acfd84a0bb702c072b4eb).
* To search and get the details of a coupon activity, refer to:
   * [Search Coupons](6699dcdf115ebe02f841e4cd);
   * [Get Coupons](6699dce0de15e502ed219e37).


---

## Shipping discount supported areas

Doc: https://partner.tiktokshop.com/docv2/page/shipping-discount-supported-areas · cập nhật 2026-10-09

You can set applied geographical areas for shipping discounts when you create a promotion activity or update a promotion activity.
To set the areas, use `discount.shipping_discount.area_scope.specific_areas` in [Create Activity](650c33c155bc3202b762b507) and [Update Activity](650c584d82c3a602befa4ab8).

The enumeration values for this field are limited to the following list:
### Indonesia

* Aceh
* Bali
* Bangka Belitung Islands
* Banten
* Bengkulu
* Central Java
* Central Kalimantan
* Central Sulawesi
* East Java
* East Kalimantan
* East Nusa Tenggara
* Gorontalo
* Jakarta
* Jambi
* Lampung
* Maluku
* North Kalimantan
* North Maluku
* North Sulawesi
* North Sumatra
* Papua
* Papua Barat Daya
* Papua Pegunungan
* Papua Selatan
* Riau
* Riau islands
* South Kalimantan
* South Sulawesi
* South Sumatra
* Southeast Sulawesi
* West Java
* West Kalimantan
* West Nusa Tenggara
* West Papua
* West Sulawesi
* West Sumatra
* Yogyakarta

### Thailand

* Amnat Charoen
* Ang Thong
* Bangkok
* Bueng Kan
* Buri Ram
* Chachoengsao
* Chai Nat
* Chaiyaphum
* Chanthaburi
* Chiang Mai
* Chiang Rai
* Chon Buri
* Chumphon
* Kalasin
* Kamphaeng Phet
* Kanchanaburi
* Khon Kaen
* Krabi
* Lampang
* Lamphun
* Loei
* Lop Buri
* Mae Hong Son
* Maha Sarakham
* Mukdahan
* Nakhon Nayok
* Nakhon Pathom
* Nakhon Phanom
* Nakhon Ratchasima
* Nakhon Sawan
* Nakhon Si Thammarat
* Nan
* Narathiwat
* Nong Bua Lam Phu
* Nong Khai
* Nonthaburi
* Pathum Thani
* Pattani
* Phangnga
* Phatthalung
* Phayao
* Phetchabun
* Phetchaburi
* Phichit
* Phitsanulok
* Phra Nakhon Si Ayutthaya
* Phrae
* Phuket
* Prachin Buri
* Prachuap Khiri Khan
* Ranong
* Ratchaburi
* Rayong
* Roi Et
* Sa Kaeo
* Sakon Nakhon
* Samut Prakan
* Samut Sakhon
* Samut Songkhram
* Saraburi
* Satun
* Si Sa Ket
* Sing Buri
* Songkhla
* Sukhothai
* Suphan Buri
* Surat Thani
* Surin
* Tak
* Trang
* Trat
* Ubon Ratchathani
* Udon Thani
* Uthai Thani
* Uttaradit
* Yala
* Yasothon

### Vietnam

* An Giang
* Ba Ria - Vung Tau
* Bac Giang
* Bac Kan
* Bac Lieu
* Bac Ninh
* Ben Tre
* Binh Dinh
* Binh Duong
* Binh Phuoc
* Binh Thuan
* Ca Mau
* Can Tho
* Cao Bang
* Da Nang
* Dak Lak
* Dak Nong
* Dien Bien
* Dong Nai
* Dong Thap
* Gia Lai
* Ha Giang
* Ha Nam
* Ha Noi
* Ha Tinh
* Hai Duong
* Hai Phong
* Hau Giang
* Ho Chi Minh
* Hoa Binh
* Hue
* Hung Yen
* Khanh Hoa
* Kien Giang
* Kon Tum
* Lai Chau
* Lam Dong
* Lang Son
* Lao Cai
* Long An
* Nam Dinh
* Nghe An
* Ninh Binh
* Ninh Thuan
* Phu Tho
* Phu Yen
* Quang Binh
* Quang Nam
* Quang Ngai
* Quang Ninh
* Quang Tri
* Soc Trang
* Son La
* Tay Ninh
* Thai Binh
* Thai Nguyen
* Thanh Hoa
* Tien Giang
* Tra Vinh
* Tuyen Quang
* Vinh Long
* Vinh Phuc
* Yen Bai

### Malaysia

* Johor
* Kedah
* Kelantan
* Kuala Lumpur
* Labuan
* Malacca
* Negeri Sembilan
* Pahang
* Penang
* Perak
* Perlis
* Putrajaya
* Sabah
* Sarawak
* Selangor
* Terengganu

### Philippines

* BARMM
* Bicol
* Cagayan Valley
* Calabarzon
* Caraga
* Central Luzon
* Central Visayas
* Cordillera
* Davao
* Eastern Visayas
* Ilocos
* Metro Manila
* Mimaropa
* Northern Mindanao
* Soccsksargen
* Western Visayas
* Zamboanga Peninsula

### Singapore

* Central Singapore
* North East
* North West
* South East
* South West

### Japan

* AICHI KEN
* AKITA KEN
* AOMORI KEN
* CHIBA KEN
* EHIME KEN
* FUKUI KEN
* FUKUOKA KEN
* FUKUSHIMA KEN
* GIFU KEN
* GUMMA KEN
* HIROSHIMA KEN
* HOKKAIDO
* HYOGO KEN
* IBARAKI KEN
* ISHIKAWA KEN
* IWATE KEN
* KAGAWA KEN
* KAGOSHIMA KEN
* KANAGAWA KEN
* KOCHI KEN
* KUMAMOTO KEN
* KYOTO FU
* MIE KEN
* MIYAGI KEN
* MIYAZAKI KEN
* NAGANO KEN
* NAGASAKI KEN
* NARA KEN
* NIIGATA KEN
* OITA KEN
* OKAYAMA KEN
* OKINAWA KEN
* OSAKA FU
* SAGA KEN
* SAITAMA KEN
* SHIGA KEN
* SHIMANE KEN
* SHIZUOKA KEN
* TOCHIGI KEN
* TOKUSHIMA KEN
* TOKYO TO
* TOTTORI KEN
* TOYAMA KEN
* WAKAYAMA KEN
* YAMAGATA KEN
* YAMAGUCHI KEN
* YAMANASHI KEN

### United States

* Alabama
* Alaska
* American Samoa
* Arizona
* Arkansas
* California
* Colorado
* Connecticut
* Delaware
* District of Columbia
* Florida
* Georgia
* Hawaii
* Idaho
* Illinois
* Indiana
* Iowa
* Kansas
* Kentucky
* Louisiana
* Maine
* Maryland
* Massachusetts
* Michigan
* Minnesota
* Mississippi
* Missouri
* Montana
* Nebraska
* Nevada
* New Hampshire
* New Jersey
* New Mexico
* New York
* North Carolina
* North Dakota
* Ohio
* Oklahoma
* Oregon
* Pennsylvania
* Puerto Rico
* Rhode Island
* South Carolina
* South Dakota
* Tennessee
* Texas
* Utah
* Vermont
* Virgin Islands
* Virginia
* Washington
* West Virginia
* Wisconsin
* Wyoming

### Mexico

* Aguascalientes
* Baja California
* Baja California Sur
* Campeche
* Chiapas
* Chihuahua
* Coahuila
* Colima
* Durango
* Estado de Mexico
* Guanajuato
* Guerrero
* Hidalgo
* Jalisco
* Mexico City
* Michoacan
* Morelos
* Nayarit
* Nuevo Leon
* Oaxaca
* Puebla
* Queretaro
* Quintana Roo
* San Luis Potosi
* Sinaloa
* Sonora
* Tabasco
* Tamaulipas
* Tlaxcala
* Veracruz
* Yucatan
* Zacatecas

### Brazil

* Acre
* Alagoas
* Amapa
* Amazonas
* Bahia
* Ceara
* Distrito Federal
* Espirito Santo
* Goias
* Maranhao
* Mato Grosso
* Mato Grosso do Sul
* Minas Gerais
* Para
* Paraiba
* Parana
* Pernambuco
* Piaui
* Rio Grande do Norte
* Rio Grande do Sul
* Rio de Janeiro
* Rondonia
* Roraima
* Santa Catarina
* Sao Paulo
* Sergipe
* Tocantins

### United Kingdom

* England
* Northern Ireland
* Scotland
* Wales

### Germany

* Baden Wurttemberg
* Bavaria
* Berlin
* Brandenburg
* Bremen
* Hamburg
* Hesse
* Lower Saxony
* Mecklenburg Vorpommern
* North Rhine Westphalia
* Rhineland Palatinate
* Saarland
* Saxony
* Saxony Anhalt
* Schleswig Holstein
* Thuringia

### France

* Auvergne Rhone Alpes
* Bourgogne Franche Comte
* Brittany
* Centre Val de Loire
* Corsica
* Grand Est
* Guadeloupe
* Guyane
* Hauts de France
* Ile de France
* La Passion-Clipperton
* La Reunion
* Martinique
* Mayotte
* Normandy
* Nouvelle Aquitaine
* Nouvelle-Caledonie
* Occitania
* Pays de la Loire
* Polynesie francaise
* Provence Alpes Cote d'Azur
* Saint-Barthelemy
* Saint-Martin
* Saint-Pierre-et-Miquelon
* Terres australes et antarctiques francaises
* Wallis-et-Futuna

### Italy

* Abruzzo
* Aosta Valley
* Apulia
* Basilicata
* Calabria
* Campania
* Emilia Romagna
* Friuli Venezia Giulia
* Lazio
* Liguria
* Lombardy
* Marche
* Molise
* Piedmont
* Sardinia
* Sicily
* Trentino South Tyrol
* Tuscany
* Umbria
* Veneto

### Spain

* Andalusia
* Aragon
* Asturias
* Balearic
* Basque
* Canary
* Cantabria
* Castile and Leon
* Castilla La Mancha
* Catalonia
* Ceuta
* Extremadura
* Galicia
* La Rioja
* Madrid
* Melilla
* Murcia
* Navarre
* Valencian

### Ireland

* Carlow
* Cavan
* Clare
* Cork
* Cork City
* Donegal
* Dublin
* Dublin City
* Dun Laoghaire Rathdown
* Fingal
* Galway
* Galway City
* Kerry
* Kildare
* Kilkenny
* Laois
* Leitrim
* Limerick
* Longford
* Louth
* Mayo
* Meath
* Monaghan
* Offaly
* Roscommon
* Sligo
* South Dublin
* Tipperary
* Waterford
* Westmeath
* Wexford
* Wicklow

### Netherlands

* Drenthe
* Flevoland
* Friesland
* Gelderland
* Groningen
* Limburg
* North Brabant
* North Holland
* Overijssel
* South Holland
* Utrecht
* Zeeland

### Belgium

* Brussels-Capital Region
* Flemish Region
* Walloon region

### Poland

* Greater Poland Voivodeship
* Kuyavian-Pomeranian Voivodeship
* Lesser Poland Voivodeship
* Lodz Voivodeship
* Lower Silesian Voivodeship
* Lublin Voivodeship
* Lubusz Voivodeship
* Masovian Voivodeship
* Opole Voivodeship
* Podlaskie Voivodeship
* Pomeranian Voivodeship
* Silesian Voivodeship
* Subcarpathian Voivodeship
* Swietokrzyskie Voivodeship
* Warmian-Masurian Voivodeship
* West Pomeranian Voivodeship

### Austria

* Burgenland
* Kaernten
* Niederoesterreich
* Oberoesterreich
* Salzburg
* Steiermark
* Tirol
* Vorarlberg
* Wien

### Czech Republic

* Central Bohemian
* Hradec Kralove
* Karlovy Vary
* Liberec
* Moravian-Silesian
* Olomouc
* Pardubice
* Pilsen
* Prague Capital City
* South Bohemian
* South Moravian
* Usti nad Labem
* Vysocina
* Zlin

### Greece

* Aigio
* Athonite State
* Attica
* Crete
* Epirus - Western Macedonia
* Macedonia - Thrace
* Peloponnese, Western Greece and the Ionian
* Thessaly - Central Greece

### Portugal

* Aveiro
* Azores
* Beja
* Braga
* Braganca
* Castelo Branco
* Coimbra
* Evora
* Faro
* Guarda
* Leiria
* Lisbon
* Madeira
* Portalegre
* Porto
* Santarem
* Setubal
* Viana do Castelo
* Vila Real
* Viseu

### Hungary

* Bacs-Kiskun
* Baranya
* Bekes
* Borsod-Abauj-Zemplen
* Budapest
* Csongrad-Csanad
* Fejer
* Gyor-Moson-Sopron
* Hajdu-Bihar
* Heves
* Jasz-Nagykun-Szolnok
* Komarom-Esztergom
* Nograd
* Pest
* Somogy
* Szabolcs-Szatmar-Bereg
* Tolna
* Vas
* Veszprem
* Zala


---

## Create Promotion Activity — `POST /promotion/202309/activities`

Doc: https://partner.tiktokshop.com/docv2/page/create-promotion-activity-202309 · cập nhật 2026-10-28 · scope: seller.promotion.write

### Path: /promotion/202309/activities
### Method: [POST]
### Function Description
Create a fixed-price, percentage-off, flash sale, shipping-discount, Buy More Save More, Gift With Purchase, or Buy X Get Y promotion activity. Coupons cannot be created with this API; create them in Seller Center or the seller app. To update the products or SKUs included in the activity, use [Update Activity Product](https://partner.tiktokshop.com/docv2/page/650d32c42aaa3602b86ccb5c).

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| title | string | Y | DiscountEvent0829 | Unique name across all your activities. Maximum length: 50 characters for `FLASHSALE` and `SHIPPING_DISCOUNT`; 100 characters for `FIXED_PRICE`, `DIRECT_DISCOUNT`, `BUY_MORE_SAVE_MORE`, `BUY_X_GET_Y`, and `GIFT_WITH_PURCHASE`. |
| activity_type | string | Y | FIXED_PRICE | The type of promotion activity. |
| Possible values: |  |  |  |  |

* `FIXED_PRICE`: A product discount activity with a fixed price.
* `DIRECT_DISCOUNT`: A product discount activity with a percentage discount.
* `FLASHSALE`: A flash sale activity.
* `SHIPPING_DISCOUNT`: A shipping fee discount activity.
* `BUY_MORE_SAVE_MORE`: A Buy More Save More promotion.
* `GIFT_WITH_PURCHASE`: A Gift With Purchase promotion.
* `BUY_X_GET_Y`: A Buy X Get Y promotion. |
   product_level |string |Y |PRODUCT |The product scope of the activity.
   Possible values:
* `PRODUCT`: Apply the promotion at the product (SPU) level to all SKUs in each selected product.
* `VARIATION`: Apply the promotion only to selected SKUs.
* `SHOP`: Apply the promotion to all products in the shop.

Activity-specific constraints:

* `FIXED_PRICE`, `DIRECT_DISCOUNT`, and `FLASHSALE` support `PRODUCT` or `VARIATION`.
* `SHIPPING_DISCOUNT` does not support `VARIATION`.
* `BUY_MORE_SAVE_MORE` and `BUY_X_GET_Y` support `PRODUCT` or `SHOP`.
* `GIFT_WITH_PURCHASE` requires `PRODUCT`.

To set the products or SKUs covered by the activity, use [Update Activity Product](https://partner.tiktokshop.com/docv2/page/650d32c42aaa3602b86ccb5c). |
duration_type |string |N |NORMAL |The effective time type of the current activity

* NORMAL: `begin_time` and `end_time` must be filled
* INDEFINITE: `begin_time` and `end_time` aren't required, and the promotion will be a long-term activity which runs indefinitely.
1. `INDEFINITE` is only valid when `activity_type` is `SHIPPING_DISCOUNT`,
2. If `duration_type` is `INDEFINITE`, `start_time` and `end_time` should be 0
   Default: NORMAL |
   begin_time |int |Y |1661756811 |Activity start time. UNIX timestamp. The value must be greater than the value of the current time. |
   end_time |int |Y |1661856811 |Activity end time as a Unix timestamp in seconds. For `NORMAL` `FIXED_PRICE`, `DIRECT_DISCOUNT`, `FLASHSALE`, `BUY_MORE_SAVE_MORE`, `BUY_X_GET_Y`, and `GIFT_WITH_PURCHASE` activities, it must be at least 600 seconds after `begin_time`. For a `NORMAL` shipping-discount activity, provide a positive value. |
   participation_limit |[]object |N | |Buyer participation-limit settings. For `BUY_MORE_SAVE_MORE`, `BUY_X_GET_Y`, and `GIFT_WITH_PURCHASE`, provide exactly one entry. |
   ^type |string |Y |BUYER_NO_LIMIT |Determines whether each buyer can receive the activity benefit more than once.
   Possible values:
* `BUYER_NO_LIMIT`: A buyer can benefit from this activity across multiple orders.
* `BUYER_LIMIT_ONLY_ONE`: A buyer can benefit from this activity for no more than one order. |
   discount |object |N | |Discount configuration. For `SHIPPING_DISCOUNT`, provide `shipping_discount`; for `BUY_MORE_SAVE_MORE`, provide `bmsm_discount`; for `GIFT_WITH_PURCHASE`, provide `gift_discount`; and for `BUY_X_GET_Y`, provide `bxgy_discount`. This field is not used for `FIXED_PRICE`, `DIRECT_DISCOUNT`, or `FLASHSALE`. |
   ^shipping_discount |object |N | |Configurations for the shipping discount, including purchase criteria, discount value, shipping method, inventory type, and area scope. |
   ^^threshold_type |string |Y |MINIMAL_ITEM_QUANTITY |The type of purchase criteria. Possible enumerations are:
* `NO_THRESHOLD`: No minimum purchase criteria.
* `MINIMAL_ITEM_QUANTITY`: Buyer must meet or exceed the minimum spend criteria with eligible products.
* `MINIMAL_ORDER_AMOUNT`: Buyer must meet or exceed the minimum spend criteria with eligible order.
   `MINIMAL_ITEM_QUANTITY` and `MINIMAL_ORDER_AMOUNT` can only be set when `product_level==SHOP`. |
   ^^threshold_value |string |N |3 |The purchase threshold of the discount, based on `threshold_type`, for example, `3`. Determined by the user.
* When `threshold_type==NO_THRESHOLD`, this value is not required.
* When `threshold_type==MINIMAL_ITEM_QUANTITY`, the buyer must purchase at least the specified number of eligible products (for example, 3 eligible products). If it represents a quantity, it must be an integer.
* When `threshold_type==MINIMAL_ORDER_AMOUNT`, the eligible-product subtotal must meet or exceed the specified value in local currency (for example, 3 units of local currency). If it represents an order value, it must be limited to two decimal places. |
   ^^type |string |Y |DISCOUNT_SHIPPING_FEE |The shipping benefit type.
* `FREE_SHIPPING`: Reduce the buyer's shipping fee to zero.
* `DISCOUNT_SHIPPING_FEE`: Reduce the buyer's shipping fee by up to the amount specified in `shipping_discount.value`. |
   ^^value |string |N |10.5 |The shipping discount value determined by `type`.
* When `type==FREE_SHIPPING`, omit this value.
* When `type==DISCOUNT_SHIPPING_FEE`, enter the maximum amount deducted from the buyer's shipping fee in local currency, with at most two decimal places. |
   ^^shipping_method |string |N |STANDARD_SHIPPING |The shipping methods to which this promotion applies.
* When `STANDARD_SHIPPING`: Only applies to Standard Shipping methods, including Economy.
* `EXPRESS_SHIPPING`: Only applies to Express Shipping methods.
* `ALL_SHIPPING_METHOD`: Applies to all shipping methods that the shop offers.
   Default: `STANDARD_SHIPPING` |
   ^^inventory_type |string |N |SELF_FULFILLED |The inventory types to which the promotion activity applies:
* `SELF_FULFILLED`: Only applies to inventory fulfilled from seller warehouses
* `FULFILLED_BY_TIKTOK`: Only applies to inventory fulfilled by TikTok from FBT (Fulfilled by TikTok) warehouses.
* `ALL`: Applies to all inventory of eligible products.
   For US shop-wide free-shipping promotions (`product_level` == `SHOP`), the default is `ALL`, and `inventory_type` cannot be set to only `SELF_FULFILLED` or only `FULFILLED_BY_TIKTOK`.
   For other areas, the default is `SELF_FULFILLED`. `FULFILLED_BY_TIKTOK` and `ALL` can only be set when `product_level` == `SHOP` and `threshold_type` = `NO_THRESHOLD`. |
   ^^area_scope |object |Y | |The (buyer's) geographical areas to which the promotion activity applies. |
   ^^^type |string |Y |WHOLE |The (buyer's) geographical area to which the promotion activity applies.
   - `WHOLE`: Promotion activity applies to all areas to which the seller offers fulfillment.
* `SPECIFIC_AREAS`: Only applies to specific fulfillment areas, as defined in `area_scope.specific_areas` |
   ^^^specific_areas |[]string |N |["Washington", "New York"] |The list of areas for which the promotion activity applies. The valid values that may be included in this list are dependent on the region of the shop. The list of valid values for each shop region are available here: [link](https://partner.tiktokshop.com/docv2/page/67e3b059e7dc4f04a4ff9e09) |
   ^bmsm_discount |object |N | |Configurations related to Buy More Save More (BMSM) promotions |
   ^^details |[]object |N | |Configurations for Buy More Save More tiers. Provide one or two tiers. `threshold_type` and `type` must be the same across all tiers. |
   ^^^tier |int |Y |1 |`tier` uses 1-based indexing: the first and second tiers are `1` and `2`, not `0` and `1`. For each subsequent tier, both `threshold_value` and `value` must be greater than those of the previous tier. For example, if tier `1` has `threshold_value` `20` and `value` `15`, tier `2` must have a `threshold_value` greater than `20` and a `value` greater than `15`. |
   ^^^threshold_type |string |Y |MINIMAL_ITEM_QUANTITY |The type of purchase criteria. Possible enumerations are:
* `MINIMAL_ITEM_QUANTITY`: Buyer must meet or exceed the minimum spend criteria with eligible products.
* `MINIMAL_ORDER_AMOUNT`: Buyer must meet or exceed the minimum spend criteria with eligible order. |
   ^^^threshold_value |string |Y |5 |The purchase threshold for this tier.
* When `threshold_type==MINIMAL_ITEM_QUANTITY`, enter a positive integer.
* When `threshold_type==MINIMAL_ORDER_AMOUNT`, enter a positive amount in local currency, with at most two decimal places. |
   ^^^type |string |Y |PERCENTAGE_OFF |The type of discount awarded as a benefit. The value of the discount is determined by `value`.
   Possible enumerations are:
* `PERCENTAGE_OFF`: Buyer will receive X% off the price of the eligible products.
* `AMOUNT_OFF`: Buyer will receive X units of local currency off the price of eligible products. |
   ^^^value |string |Y |10 |The discount value.
* When `type==PERCENTAGE_OFF`, enter a positive integer percentage.
* When `type==AMOUNT_OFF`, enter a positive amount in local currency, with at most two decimal places. |
   ^gift_discount |object |N | |Configurations related to Gift With Purchase (GWP) promotions. Only needs to be configured for GWP promotions. |
   ^^gift_receiving_type |string |Y |ALL_RECEIVE |The receiving type of gift. Currently only one type is supported:
* `ALL_RECEIVE`: All gifts configured in the promotion can be collected. |
   ^^gift_infos |[]object |Y | |Gift With Purchase tier configurations. Provide at least one tier. A maximum of two tiers is permitted in SEA and the UK, while only one tier is permitted in the US. `threshold_type` must be the same across all tiers. |
   ^^^tier |int |Y |1 |`tier` uses 1-based indexing, i.e. the first and second tiers are counted "1, 2", not "0, 1".
   `threshold_value` for a given tier must be greater than that of the previous tier.
   E.g. If `tier`1 has <code>threshold_value</code>`2`, `tier`==2 must have `threshold_value` > `2`. |
   ^^^threshold_type |string |Y |MINIMAL_ITEM_QUANTITY |The purchase threshold type of discount. Possible enumerations are:
* `MINIMAL_ITEM_QUANTITY`: Buyer must meet or exceed the minimum spend criteria with eligible products.
* `MINIMAL_ORDER_AMOUNT`: Buyer must meet or exceed the minimum spend criteria with eligible order. |
   ^^^threshold_value |string |Y |3 |The purchase threshold for the gift, determined by `threshold_type`.
* When `threshold_type==MINIMAL_ITEM_QUANTITY`, enter a positive integer number of eligible products.
* When `threshold_type==MINIMAL_ORDER_AMOUNT`, enter a positive eligible-product subtotal in local currency, with at most two decimal places. |
   ^^^gift_details |[]object |Y | |The gift SKUs for this tier. Across all tiers, provide at least one gift SKU in total, and do not repeat the same sku_id anywhere in the activity. For a MINIMAL_ITEM_QUANTITY tier, this list must not be empty. |
   ^^^^product_id |string |Y |1732239744891062847 |TikTok Shop product id of gift. |
   ^^^^sku_id |string |Y |1732239787859544639 |TikTok Shop sku id of gift. |
   ^^^^total_claim_limit |string |Y |100 |The total claim limit for the gift SKU in this activity. Enter an integer from `1` to `99999`. |
   ^bxgy_discount |object |N | |Configurations related to Buy X Get Y (BXGY) promotions. Only needs to be configured for BXGY promotions. |
   ^^threshold_type |string |Y |MINIMAL_ITEM_QUANTITY |The purchase criterion.
   Possible values:
* `MINIMAL_ITEM_QUANTITY`: The buyer must purchase at least the configured quantity of eligible products.
* `MINIMAL_ORDER_AMOUNT`: The eligible-product subtotal must reach the configured amount. |
   ^^threshold_value |string |Y |5 |The purchase threshold determined by `threshold_type`.
* When `threshold_type==MINIMAL_ITEM_QUANTITY`, enter a positive integer no greater than `10`.
* When `threshold_type==MINIMAL_ORDER_AMOUNT`, enter a positive eligible-product subtotal in local currency, with at most two decimal places. |
   ^^discount_type |string |Y |AMOUNT_OFF_EACH |The type of benefit.
   Possible values:
* PERCENTAGE_OFF: Apply the percentage specified by discount_value to eligible products.
* FREE: Provide the configured quantity of eligible products for free.
* AMOUNT_OFF_EACH: Deduct the local-currency amount specified by discount_value from each eligible product. |
   ^^discount_value |string |Y |5 |Value of the discount.
* When `type`==`PERCENTAGE_OFF`, the buyer will receive X% off the price of eligible products. If the value represents a percentage, it should be an integer.
* `type`==`AMOUNT_OFF_EACH`, the buyer will receive X units of local currency off the price of each eligible products. If the value represents a monetary amount, it should be limited to two decimal places.
   |
   ^^benefit_max_applicable_quantity |string |Y |5 |The quantity of item Y awarded each time the Buy X Get Y benefit applies. Enter a positive integer no greater than `20`. |
   ^^benefit_max_applicable_times |string |N |5 |Optional. The maximum number of times the Buy X Get Y benefit can be applied in one order. Enter a positive integer no greater than `50`. |
   target_user_info |object |N | |Target-audience configuration for `BUY_MORE_SAVE_MORE`, `BUY_X_GET_Y`, and `GIFT_WITH_PURCHASE` activities. If omitted, the activity targets `ALL_USER`. |
   ^user_type |string |N |ALL_USER |Possible enumerations are:
   `ALL_USER`
   `SHOP_NEW_CUSTOMER`
   `SHOP_EXISTING_CUSTOMER`
   `SHOP_REPEAT_CUSTOMER` |
   auction_support_type |string |N |ALL |For `SHIPPING_DISCOUNT` activities, determines whether auction products are supported.
   Possible values:
* `ALL`: Support both regular and auction products.
* `EXCLUDE_AUCTION`: Exclude auction products.
   Default: `ALL`. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/promotion/202309/activities?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"title":"DiscountEvent0829","activity_type":"FIXED_PRICE","product_level":"PRODUCT","duration_type":"NORMAL","begin_time":1661756811,"end_time":1661856811,"participation_limit":[{"type":"BUYER_NO_LIMIT"}],"discount":{"shipping_discount":{"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"3","type":"DISCOUNT_SHIPPING_FEE","value":"10.5","shipping_method":"STANDARD_SHIPPING","inventory_type":"SELF_FULFILLED","area_scope":{"type":"WHOLE","specific_areas":["Washington","New York"]}},"bmsm_discount":{"details":[{"tier":1,"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"5","type":"PERCENTAGE_OFF","value":"10"}]},"gift_discount":{"gift_receiving_type":"ALL_RECEIVE","gift_infos":[{"tier":1,"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"3","gift_details":[{"product_id":"1732239744891062847","sku_id":"1732239787859544639","total_claim_limit":"100"}]}]},"bxgy_discount":{"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"5","discount_type":"AMOUNT_OFF_EACH","discount_value":"5","benefit_max_applicable_quantity":"5","benefit_max_applicable_times":"5"}},"target_user_info":{"user_type":"ALL_USER"},"auction_support_type":"ALL"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^activity_id | string | 7136104329798256386 | On success, the ID of the created activity. Use it as `activity_id` when adding products or SKUs with [Update Activity Product](https://partner.tiktokshop.com/docv2/page/650d32c42aaa3602b86ccb5c). |
| ^create_time | int | 1661756811 | The time when the activity was created. |
| ^update_time | int | 1661756811 | The time when the activity was last updated. |
| ^status | string | ONGOING | Possible values: |

* DRAFT: Promotion activities with this status are not available to TikTok users.
* NOT_START: Promotion activities with this status are not available to TikTok users until the set activity start time.
* ONGOING: Promotion activities with this status are available to TikTok users.
* EXPIRED: Promotion activities with this status are not available to TikTok users because it has expired.
* DEACTIVATED: The activity has been deactivated by the seller and is not available to TikTok users.
* NOT_EFFECTIVE: The activity is terminated by the platform and is not available to TikTok users. |

### Response Sample
```json
{"code":0,"data":{"activity_id":"7136104329798256386","create_time":1661756811,"update_time":1661756811,"status":"ONGOING"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 17003203 | A storewide free shipping promotion activity is already active. Only one can be created at a time. |
| 17029001 | Invalid parameters |
| 17029002 | Title Length Too Long |
| 17029004 | Duplicate activity title. |
| 17029005 | Begin Time Earlier Than Now |
| 17029006 | The activity period is too short. |
| 17029007 | The activity period is too long. |
| 17029008 | FlashSale Period Too Long |
| 17029026 | Invalid SellerID |
| 17029027 | Empty RequestSerialNo |
| 17029035 | ShopRisk Check Failed |
| 17029036 | ActivityType is not supported. |
| 17029049 | ActivityVersion is not supported. |
| 17029052 | ProductType is not supported |
| 17029068 | Selected `inventory_type` is not supported in your region. |
| 17029070 | Empty gift sku info. |
| 17029071 | Gift sku id is invalid, not an integer. |
| 17029072 | Gift sku repeated |
| 17029073 | Price of the gift exceeds the upper limit |
| 17029074 | Eligible products and the gift products must not be the same product. |
| 17029075 | Number of gifts per tier does not meet the limit |
| 17029076 | Gift sku is out of stock. |
| 17029077 | Gifts across different tiers are repeated |
| 17029078 | Number of gift tiers does not meet the requirement |
| 17029082 | Specified time is outside of the defined range for this activity. Please check the time range for the activity and try again. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Update Promotion Activity — `PUT /promotion/202309/activities/{activity_id}`

Doc: https://partner.tiktokshop.com/docv2/page/update-promotion-activity-202309 · cập nhật 2026-10-28 · scope: seller.promotion.write

### Path: /promotion/202309/activities/{activity_id}
### Method: [PUT]
### Function Description
Update an existing promotion activity. The stored activity type determines which request fields are processed:

* For fixed-price, direct-discount, and flash-sale activities, update title, begin_time, and end_time; the other type-specific fields are not processed by this update path.
* For a shipping-discount activity, provide discount.shipping_discount; use duration_type to choose a scheduled or indefinite activity.
* For a Buy More Save More (BMSM) or Buy X Get Y (BXGY) activity, set duration_type to NORMAL, set product_level to PRODUCT or SHOP, provide exactly one participation_limit entry, and provide the matching discount object.
* For a Gift With Purchase (GWP) activity, set duration_type to NORMAL, set product_level to PRODUCT, provide exactly one participation_limit entry, and provide discount.gift_discount.
   Fixed-price, direct-discount, flash-sale, BMSM, BXGY, and GWP activities cannot be updated after they are deactivated or expired. For those activity types, an upcoming activity with a normal schedule requires a future begin_time, while an ongoing activity must keep its existing begin_time. An ongoing BMSM or BXGY activity must also keep its existing first-tier threshold value, threshold type, discount type, product scope, participation limit, and target-user setting.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| activity_id | string | Y | 7402881377634567979 | The unique identifier of the promotion activity. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| title | string | Y | BlackFridayDiscount | Activity name. The name must be unique. Maximum length: 50 Unicode characters for a flash-sale activity; 50 characters for a shipping-discount activity; 100 Unicode characters for a fixed-price, direct-discount, BMSM, BXGY, or GWP activity. |
| duration_type | string | N | NORMAL | The activity schedule mode. |

* For BMSM, BXGY, and GWP activities, set this field to `NORMAL` and provide the scheduled `begin_time` and `end_time`.
* For a shipping-discount activity, use `NORMAL` for a scheduled activity or `INDEFINITE` for an activity without a scheduled end. When this field is omitted for a shipping-discount update, it defaults to `NORMAL`. For `INDEFINITE`, set both `begin_time` and `end_time` to `0`.
* This field is not processed when updating a fixed-price, direct-discount, or flash-sale activity. |
   begin_time |int |Y |1661756811 |Activity start time as a Unix timestamp in seconds. For an INDEFINITE shipping-discount activity, set this field to 0. For a fixed-price, direct-discount, flash-sale, BMSM, BXGY, or GWP activity with a normal schedule, use a future time when the activity is upcoming; if it is ongoing, use its existing start time because that value cannot be changed. |
   end_time |int |Y |1661856811 |Activity end time as a Unix timestamp in seconds. For an INDEFINITE shipping-discount activity, set this field to 0. For a normal-schedule fixed-price, direct-discount, flash-sale, BMSM, BXGY, or GWP update, end_time must be at least 600 seconds after begin_time. |
   product_level |string |N |PRODUCT |The promotion's product scope. You must provide this field when updating a BMSM, BXGY, GWP, or shipping-discount activity.
* PRODUCT: Applies to a product and all of its SKUs. Use this value for GWP; BMSM, BXGY, and shipping-discount also support it.
* VARIATION: Applies only to specified SKUs. It is not supported for BMSM, BXGY, GWP, or shipping-discount updates.
* SHOP: Applies to all products in the shop. It is supported for BMSM, BXGY, and shipping-discount, but not GWP.
   This field is not processed for fixed-price, direct-discount, or flash-sale updates. For an ongoing BMSM or BXGY activity, keep its existing PRODUCT or SHOP scope. |
   participation_limit |[]object |N | |The buyer participation limit. For BMSM, BXGY, and GWP updates, provide exactly one entry. If a BMSM or BXGY activity is ongoing, keep its existing participation limit unchanged. |
   ^type |string |Y |BUYER_NO_LIMIT |Determines whether the promotion limits how many orders each buyer can receive the benefit from.
* `BUYER_NO_LIMIT`: Buyers can receive the benefit across multiple orders.
* `BUYER_LIMIT_ONLY_ONE`: Each buyer can receive the benefit for no more than one order. |
   discount |object |N | |Discount information. |
   ^shipping_discount |object |N | |Configurations for the shipping discount, including purchase criteria, discount value, shipping method, inventory type, and area scope. |
   ^^threshold_type |string |Y |MINIMAL_ITEM_QUANTITY |The type of purchase criteria. Possible enumerations are:
* `NO_THRESHOLD`: No minimum purchase criteria.
* `MINIMAL_ITEM_QUANTITY`: Buyer must meet or exceed the minimum spend criteria with eligible products.
* `MINIMAL_ORDER_AMOUNT`: Buyer must meet or exceed the minimum spend criteria with eligible order.
   `MINIMAL_ITEM_QUANTITY` and `MINIMAL_ORDER_AMOUNT` can only be set when `product_level==SHOP`. |
   ^^threshold_value |string |N |3 |The purchase threshold for the shipping discount, interpreted according to `threshold_type`.
* When `threshold_type` is `NO_THRESHOLD`, this field is not required.
* When `threshold_type` is `MINIMAL_ITEM_QUANTITY`, enter the minimum number of eligible products the buyer must purchase. The value must be an integer.
* When `threshold_type` is `MINIMAL_ORDER_AMOUNT`, enter the minimum eligible-product subtotal in the shop's local currency, for example, 3 units of local currency. The value should have no more than two decimal places. |
   ^^type |string |Y |DISCOUNT_SHIPPING_FEE |The shipping benefit type.
* `FREE_SHIPPING`: Reduces the buyer's shipping charge to zero.
* `DISCOUNT_SHIPPING_FEE`: Reduces the buyer's shipping charge by up to the amount specified in `shipping_discount.value`. |
   ^^value |string |N |10.5 |The shipping discount amount.
* When `type` is `FREE_SHIPPING`, omit this field.
* When `type` is `DISCOUNT_SHIPPING_FEE`, enter the maximum amount to deduct from the buyer's shipping charge in the shop's local currency. The value must have no more than two decimal places. |
   ^^shipping_method |string |N |STANDARD_SHIPPING |The shipping methods to which this promotion applies.
* When `STANDARD_SHIPPING`: Only applies to Standard Shipping methods, including Economy.
* `EXPRESS_SHIPPING`: Only applies to Express Shipping methods.
* `ALL_SHIPPING_METHOD`: Applies to all shipping methods that the shop offers.
   Default: `STANDARD_SHIPPING` |
   ^^inventory_type |string |N |SELF_FULFILLED |The inventory types to which the promotion activity applies:
* `SELF_FULFILLED`: Only applies to inventory fulfilled from seller warehouses
* `FULFILLED_BY_TIKTOK`: Only applies to inventory fulfilled by TikTok from FBT (Fulfilled by TikTok) warehouses.
* `ALL`: Applies to all inventory of eligible products.
   For US shop-wide free-shipping promotions (`product_level` == `SHOP`), the default is `ALL`, and `inventory_type` cannot be set to only `SELF_FULFILLED` or only `FULFILLED_BY_TIKTOK`.
   For other areas, the default is `SELF_FULFILLED`. `FULFILLED_BY_TIKTOK` and `ALL` can only be set when `product_level` == `SHOP` and `threshold_type` = `NO_THRESHOLD`. |
   ^^area_scope |object |Y | |The (buyer's) geographical areas to which the promotion activity applies |
   ^^^type |string |Y |WHOLE |The buyer's geographical area to which the promotion activity applies.
* `WHOLE`: The promotion activity applies to all areas to which the seller offers fulfillment.
* `SPECIFIC_AREAS`: The promotion activity applies only to fulfillment areas listed in `area_scope.specific_areas`. |
   ^^^specific_areas |[]string |N |["Washington", "New York"] |The list of areas for which the promotion activity applies. The valid values that may be included in this list are dependent on the region of the shop. The list of valid values for each shop region are available here: [link](https://partner.tiktokshop.com/docv2/page/67e3b059e7dc4f04a4ff9e09) |
   ^bmsm_discount |object |N | |Configurations related to Buy More Save More (BMSM) promotions |
   ^^details |[]object |N | |Configurations for BMSM promotions. A maximum of two tiers is permitted. `threshold_type` and `type` must be the same across all tiers. When updating an activity, each value must also match the activity's existing threshold type and discount type. |
   ^^^tier |int |Y |1 |The 1-based tier number. Use `1` for the first tier and `2` for the second tier. For each tier after the first, both `threshold_value` and `value` must be greater than the corresponding values in the previous tier. |
   ^^^threshold_type |string |Y |MINIMAL_ITEM_QUANTITY |The type of purchase criteria. Possible enumerations are:
* `MINIMAL_ITEM_QUANTITY`: Buyer must meet or exceed the minimum spend criteria with eligible products.
* `MINIMAL_ORDER_AMOUNT`: Buyer must meet or exceed the minimum spend criteria with eligible order. |
   ^^^threshold_value |string |Y |5 |The purchase threshold for the discount, based on `threshold_type`.
* When `threshold_type` is `MINIMAL_ITEM_QUANTITY`, enter the minimum number of eligible products the buyer must purchase. The value must be a positive integer.
* When `threshold_type` is `MINIMAL_ORDER_AMOUNT`, enter the minimum eligible-product subtotal in the shop's local currency. The value must be positive and have no more than two decimal places. |
   ^^^type |string |Y |PERCENTAGE_OFF |The type of discount awarded as a benefit. The value of the discount is determined by `value`.
   Possible enumerations are:
* `PERCENTAGE_OFF`: Buyer will receive X% off the price of the eligible products.
* `AMOUNT_OFF`: Buyer will receive X units of local currency off the price of eligible products. |
   ^^^value |string |Y |10 |The positive discount value, interpreted according to `type`.
* When `type` is `PERCENTAGE_OFF`, enter the percentage off eligible products as a positive integer.
* When `type` is `AMOUNT_OFF`, enter the positive amount to deduct from eligible products in the shop's local currency, with no more than two decimal places. |
   ^gift_discount |object |N | |Configurations related to Gift With Purchase (GWP) promotions. Only needs to be configured for GWP promotions. |
   ^^gift_receiving_type |string |Y |ALL_RECEIVE |The receiving type of gift. Currently only one type is supported:
* `ALL_RECEIVE`: All gifts configured in the promotion can be collected. |
   ^^gift_infos |[]object |Y | |Gift With Purchase (GWP) tier configurations. Provide at least one tier. A maximum of two tiers is permitted in SEA and the UK; only one tier is permitted in the US. `threshold_type` must be the same across all tiers. |
   ^^^tier |int |Y |1 |`tier` uses 1-based indexing, i.e. the first and second tiers are counted "1, 2", not "0, 1".
   `threshold_value` for a given tier must be greater than that of the previous tier.
   E.g. If `tier`1 has <code>threshold_value</code>`2`, `tier`==2 must have `threshold_value` > `2`. |
   ^^^threshold_type |string |Y |MINIMAL_ITEM_QUANTITY |The purchase threshold type of discount. The threshold type of each tier must be consistent. Possible enumerations are:
* `MINIMAL_ITEM_QUANTITY`: Buyer must meet or exceed the minimum spend criteria with eligible products.
* `MINIMAL_ORDER_AMOUNT`: Buyer must meet or exceed the minimum spend criteria with eligible order. |
   ^^^threshold_value |string |Y |3 |The positive purchase threshold for receiving the gift, interpreted according to `threshold_type`.
* When `threshold_type` is `MINIMAL_ITEM_QUANTITY`, enter the minimum number of eligible products the buyer must purchase. The value must be a positive integer.
* When `threshold_type` is `MINIMAL_ORDER_AMOUNT`, enter the minimum eligible-product subtotal in the shop's local currency, for example, 3 units of local currency. The value must be positive and have no more than two decimal places. |
   ^^^gift_details |[]object |Y | |The gift SKUs for this tier. Across all tiers, provide at least one gift SKU in total, and do not repeat a sku_id anywhere in the activity. For a MINIMAL_ITEM_QUANTITY tier, this list must not be empty. |
   ^^^^product_id |string |Y |1732239744891062847 |TikTok Shop product id of gift. |
   ^^^^sku_id |string |Y |1732239787859544639 |TikTok Shop sku id of gift. |
   ^^^^total_claim_limit |string |Y |100 |The quantity limit of the gift sku which is involved in the activity. The range is [1, 99999]. If you are updating the value of an existing sku, the value cannot be decreased. |
   ^bxgy_discount |object |N | |Configurations for Buy X Get Y (BXGY) promotions. Configure this object only for BXGY promotions. When updating an activity, `threshold_type` and `discount_type` must match the activity's existing values. |
   ^^threshold_type |string |Y |MINIMAL_ITEM_QUANTITY |The purchase threshold type. Possible values:
* `MINIMAL_ITEM_QUANTITY`: The buyer must purchase at least the specified number of eligible products.
* `MINIMAL_ORDER_AMOUNT`: The eligible-product subtotal in the buyer's order must meet or exceed the specified amount in the shop's local currency. |
   ^^threshold_value |string |Y |5 |The purchase threshold for the discount, interpreted according to `threshold_type`.
* When `threshold_type` is `MINIMAL_ITEM_QUANTITY`, enter the minimum number of eligible products the buyer must purchase. The value must be an integer from 1 to 10.
* When `threshold_type` is `MINIMAL_ORDER_AMOUNT`, enter the minimum eligible-product subtotal in the shop's local currency. The value must be positive and have no more than two decimal places. |
   ^^discount_type |string |Y |AMOUNT_OFF_EACH |The type of discount awarded as a benefit. The discount amount or percentage is determined by `discount_value`.
   Possible values:
* `PERCENTAGE_OFF`: The buyer receives the percentage specified by `discount_value` off eligible products.
* `FREE`: The buyer receives the eligible products for free.
* `AMOUNT_OFF_EACH`: The buyer receives the amount specified by `discount_value`, in the shop's local currency, off each eligible product. |
   ^^discount_value |string |Y |5 |Value of the discount.
* When `type`==`PERCENTAGE_OFF`, the buyer will receive X% off the price of eligible products. If the value represents a percentage, it should be an integer.
* `type`==`AMOUNT_OFF_EACH`, the buyer will receive X units of local currency off the price of each eligible products. If the value represents a monetary amount, it should be limited to two decimal places.
   |
   ^^benefit_max_applicable_quantity |string |Y |5 |The maximum quantity of item Y that can receive the BXGY benefit per application. Enter a positive integer from 1 to 20. |
   ^^benefit_max_applicable_times |string |N |5 |Optional. The maximum number of times the BXGY benefit can be applied within a single order. Enter a positive integer from 1 to 50. |
   target_user_info |object |N | |The promotion's target-user configuration. For an ongoing BMSM or BXGY activity, keep the existing target-user setting unchanged and include that existing value in the request. |
   ^user_type |string |N |ALL_USER |Possible enumerations are:
   `ALL_USER`
   `SHOP_NEW_CUSTOMER`
   `SHOP_EXISTING_CUSTOMER`
   `SHOP_REPEAT_CUSTOMER` |
   auction_support_type |string |N |ALL |Determines whether a shipping-discount activity supports auction products. This field is not processed for other activity types.
   Possible values:
* `ALL`: Supports both standard and auction products.
* `EXCLUDE_AUCTION`: Excludes auction products.
   When omitted for a shipping-discount update, defaults to `ALL`. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/promotion/202309/activities/7402881377634567979?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"title":"BlackFridayDiscount","duration_type":"NORMAL","begin_time":1661756811,"end_time":1661856811,"product_level":"PRODUCT","participation_limit":[{"type":"BUYER_NO_LIMIT"}],"discount":{"shipping_discount":{"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"3","type":"DISCOUNT_SHIPPING_FEE","value":"10.5","shipping_method":"STANDARD_SHIPPING","inventory_type":"SELF_FULFILLED","area_scope":{"type":"WHOLE","specific_areas":["Washington","New York"]}},"bmsm_discount":{"details":[{"tier":1,"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"5","type":"PERCENTAGE_OFF","value":"10"}]},"gift_discount":{"gift_receiving_type":"ALL_RECEIVE","gift_infos":[{"tier":1,"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"3","gift_details":[{"product_id":"1732239744891062847","sku_id":"1732239787859544639","total_claim_limit":"100"}]}]},"bxgy_discount":{"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"5","discount_type":"AMOUNT_OFF_EACH","discount_value":"5","benefit_max_applicable_quantity":"5","benefit_max_applicable_times":"5"}},"target_user_info":{"user_type":"ALL_USER"},"auction_support_type":"ALL"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^activity_id | string | 7136104329798256386 | A unique ID that identifies different activities. |
| ^title | string | BlackFridayDiscount | Activity name set by the seller. Returned on successful fixed-price, direct-discount, flash-sale, BMSM, GWP, and BXGY updates. Not returned on successful shipping-discount updates. |
| ^update_time | int | 1661756811 | Last update time as a Unix timestamp in seconds. |
### Response Sample
```json
{"code":0,"data":{"activity_id":"7136104329798256386","title":"BlackFridayDiscount","update_time":1661756811},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 17003203 | A storewide free shipping promotion activity is already active. Only one can be created at a time. |
| 17029001 | Invalid parameters |
| 17029002 | Title Length Too Long |
| 17029003 | The activity title is empty. |
| 17029004 | Duplicate activity title. |
| 17029005 | Begin Time Earlier Than Now |
| 17029006 | The activity period is too short. |
| 17029007 | The activity period is too long. |
| 17029008 | FlashSale Period Too Long |
| 17029009 | Activity does not exist |
| 17029010 | Activity is deactivated |
| 17029011 | Not allowed to update the beginning time of activity |
| 17029012 | Not allowed to update expired activities |
| 17029022 | The product or SKU cannot be in two `ONGOING` or `NOT_START` activities at the same time. |
| 17029026 | Invalid SellerID |
| 17029028 | You are specifying activities not in your shop. |
| 17029052 | ProductType is not supported |
| 17029070 | Empty gift sku info. |
| 17029071 | Gift sku id is invalid, not an integer. |
| 17029072 | Gift sku repeated |
| 17029073 | Price of the gift exceeds the upper limit |
| 17029074 | Eligible products and the gift products must not be the same product. |
| 17029075 | Number of gifts per tier does not meet the limit |
| 17029076 | Gift sku is out of stock. |
| 17029077 | Gifts across different tiers are repeated |
| 17029078 | Number of gift tiers does not meet the requirement |
| 17029082 | Specified time is outside of the defined range for this activity. Please check the time range for the activity and try again. |
| 17029083 | The claim limit quantity of gift can not be decreased |
| 17029084 | The threshold type of gift can not be modified |
| 17029085 | The number of gift tiers can not be changed |
| 17029102 | Product level and shop level are not interchangeable |
| 17029103 | Partial of products have already been applied to another conflict promotion during the selected period. |
| 17029104 | The product(s) selected have already been applied to another buy more save more promotion during the selected period. To proceed, edit the product list or change the promotion period. |
| 17029105 | The threshold type and discount type can not be modified. |
| 17029106 | Participation Limit info cannot change or modify. |
| 17029107 | Due to overlapping with other activities, sellers cannot create shop-scope BMSM activity. |
| 17029109 | The promotion exceeds the threshold. |
| 17029110 | The discount value is below the minimum threshold. |
| 17029111 | The threshold value is invalid. |
| 17029112 | The discount value is invalid. |
| 17029113 | The number of products will exceed the maximum number of the promotion. |
| 17029114 | The promotion type is not supported. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Deactivate Activity — `POST /promotion/202309/activities/{activity_id}/deactivate`

Doc: https://partner.tiktokshop.com/docv2/page/deactivate-activity-202309 · cập nhật 2026-10-28 · scope: seller.promotion.write

### Path: /promotion/202309/activities/{activity_id}/deactivate
### Method: [POST]
### Function Description
Deactivate an ongoing or upcoming activity.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| activity_id | string | Y | 7136104329798256386 | A unique ID that identifies different activities. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/promotion/202309/activities/7136104329798256386/deactivate?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^activity_id | string | 7136104329798256386 | A unique ID that identifies different activities. |
| ^title | string | FlashSale 20230707 | Activity name (50 characters max.) The name must be unique. |
| ^status | string | DEACTIVATED | Activity status after successful deactivation. |
| Possible value: |  |  |  |

* DEACTIVATED: The activity has been deactivated by the seller and is not available to TikTok users. |
   ^update_time |int |1661756811 |The time when the deactivation response was created, as a Unix timestamp in seconds. |

### Response Sample
```json
{"code":0,"data":{"activity_id":"7136104329798256386","title":"FlashSale 20230707","status":"DEACTIVATED","update_time":1661756811},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 17029001 | Invalid parameters |
| 17029009 | Activity does not exist |
| 17029010 | Activity is deactivated |
| 17029011 | Not allowed to update the beginning time of activity |
| 17029012 | Not allowed to update expired activities |
| 17029028 | You are specifying activities not in your shop. |
| 17029036 | ActivityType is not supported. |
| 17029052 | ProductType is not supported |
| 17029055 | Request Timeout |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Activity — `GET /promotion/202309/activities/{activity_id}`

Doc: https://partner.tiktokshop.com/docv2/page/get-activity-202309 · cập nhật 2026-10-28 · scope: seller.promotion.info

### Path: /promotion/202309/activities/{activity_id}
### Method: [GET]
### Function Description
Get the details of a promotion activity. Product information for `FIXED_PRICE`, `DIRECT_DISCOUNT`, and `FLASHSALE` activities that ended more than 180 days ago will not be returned. For coupon activities, use [Get Coupon](6699dce0de15e502ed219e37).

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| activity_id | string | Y | 7402881377634567979 | Activity ID |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/promotion/202309/activities/7402881377634567979?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^activity_id | string | 7136104329798256386 | A unique ID that identifies different activities. |
| ^title | string | FlashSale 20230707 | Activity name (50 characters max.) The name must be unique. |
| ^activity_type | string | FIXED_PRICE | The activity type. |
| Possible values: |  |  |  |

* `FIXED_PRICE`: A product discount activity with a fixed price.
* `DIRECT_DISCOUNT`: A product discount activity with a percentage discount.
* `FLASHSALE`: A flash sale activity.
* `SHIPPING_DISCOUNT`: A shipping fee discount activity.
* `BUY_MORE_SAVE_MORE`: A Buy More Save More promotion.
* `GIFT_WITH_PURCHASE`: A Gift With Purchase promotion.
* `BUY_X_GET_Y`: A Buy X Get Y promotion. |
   ^duration_type |string |NORMAL |The effective time type of the current activity
* NORMAL: `begin_time` and `end_time` must be filled
* INDEFINITE: `begin_time` and `end_time` aren't required, and the promotion will be a long-term activity which runs indefinitely.
1. `INDEFINITE` is only valid when `activity_type` is `SHIPPING_DISCOUNT`,
2. If `duration_type` is `INDEFINITE`, `start_time` and `end_time` should be 0
   Default: NORMAL |
   ^begin_time |int |1661756811 |Activity start time as a UNIX timestamp in seconds. |
   ^end_time |int |1661856811 |Activity end time as a UNIX timestamp in seconds. |
   ^participation_limit |[]object | |The number of times a buyer can participate in the promotion. |
   ^^type |string |BUYER_NO_LIMIT |Determines whether the promotion activity limits the number of times each buyer can receive its benefit. e.g.:
* `BUYER_NO_LIMIT`: No limit for buyers. Buyers can benefit from this promotion across multiple orders.
* `BUYER_LIMIT_ONLY_ONE`: Buyers can benefit from this promotion activity for no more than one order.
   Default: `BUYER_NO_LIMIT` |
   ^products |[]object | |Product List.
   Note:If `FIXED_PRICE`, `DIRECT_DISCOUNT` and `FLASHSALE` activity that ended more than 180 days,this field is empty. |
   ^^id |string |7136011254174631686 |TikTok Shop Product ID. |
   ^^activity_price |object | |Activity price. |
   ^^^amount |string |70500 |Activity price amount. |
   ^^^currency |string |IDR |Currency unit of an activity price. |
   ^^quantity_limit |int |-1 |The quantity limit of the products involved in the activity. The range is `[1, 99]`, or `-1` for unlimited. |
   ^^quantity_per_user |int |-1 |Limit of product purchase per buyer. The range is `[1, 99]`, or `-1` for unlimited. |
   ^^discount |string |10 |Discount value. If the product is 10% off, the value is `10`. Available only if `activity_type==DIRECT_DISCOUNT` and `product_level==PRODUCT`. |
   ^^skus |[]object | |Available only if `product_level==VARIATION`. |
   ^^^id |string |7136382541418366725 |TikTok Shop SKU ID. |
   ^^^discount |string |10 |Discount value. If the SKU is 10% off, the value is `10`. Available only if `activity_type==DIRECT_DISCOUNT`. |
   ^^^quantity_limit |int |-1 |The quantity limit of the SKU involved in the activity. The range is `[1, 99]`, or `-1` for unlimited. |
   ^^^quantity_per_user |int |-1 |Limit of SKU purchase per buyer. The range is `[1, 99]`, or `-1` for unlimited. |
   ^^^activity_price |object | |Activity price. Available only if `activity_type==FIXED_PRICE/FLASHSALE`. |
   ^^^^amount |string |70500 |Activity price amount. |
   ^^^^currency |string |IDR |Currency unit of an activity price. |
   ^^^used_quantity |int |3 |The quantity of SKU that have already taken effect in the activity. |
   ^^used_quantity |int |3 |The quantity of products that have already taken effect in the activity. |
   ^status |string |ONGOING |Activity status.
   Possible values:
* DRAFT: Promotion activities with this status are not available to TikTok users.
* NOT_START: Promotion activities with this status are not available to TikTok users until the set activity start time.
* ONGOING: Promotion activities with this status are available to TikTok users.
* EXPIRED: Promotion activities with this status are not available to TikTok users because it has expired.
* DEACTIVATED: The activity has been deactivated by the seller and is not available to TikTok users.
* NOT_EFFECTIVE: The activity is terminated by the platform and is not available to TikTok users. |
   ^create_time |int |1789355787347 |Activity creation time as a UNIX timestamp in milliseconds. |
   ^update_time |int |1789355865063 |Activity update time as a UNIX timestamp in milliseconds. |
   ^product_level |string |PRODUCT |Activity product dimension, values are:
* PRODUCT: Product level promotion activity.
* VARIATION: SKU level promotion activity.
* SHOP: Shop level promotion activity. |
   ^activity_commands |[]string |["IMMUTABLE"] |Applicable commands to the activity:
* IMMUTABLE: The activity cann't be editable or deactivated |
   ^discount |object | |Type-specific discount information. This field is omitted for `FIXED_PRICE`, `DIRECT_DISCOUNT`, and `FLASHSALE` activities. For other supported activity types, use the corresponding nested discount object when it is returned. |
   ^^shipping_discount |object | |Shipping discount |
   ^^^threshold_type |string |MINIMAL_ITEM_QUANTITY |The type of purchase criteria. Possible enumerations are:
* `NO_THRESHOLD`: No minimum purchase criteria.
* `MINIMAL_ITEM_QUANTITY`: Buyer must meet or exceed the minimum spend criteria with eligible products.
* `MINIMAL_ORDER_AMOUNT`: Buyer must meet or exceed the minimum spend criteria with eligible order.
   `MINIMAL_ITEM_QUANTITY` and `MINIMAL_ORDER_AMOUNT` can only be set when `product_level==SHOP`. |
   ^^^threshold_value |string |3 |The purchase threshold returned for the shipping discount, based on `threshold_type`.
* When `threshold_type==NO_THRESHOLD`, this value is not required.
* When `threshold_type==MINIMAL_ITEM_QUANTITY`, this is the number of eligible products the buyer must purchase and must be an integer.
* When `threshold_type==MINIMAL_ORDER_AMOUNT`, this is the eligible-product subtotal the buyer must reach in local currency (for example, 3 units of local currency) and must have no more than two decimal places. |
   ^^^type |string |DISCOUNT_SHIPPING_FEE |The type of shipping discount returned for the promotion activity.
* FREE_SHIPPING: The buyer's shipping charge is fully covered.
* DISCOUNT_SHIPPING_FEE: The buyer's shipping charge is reduced by up to the amount in value. |
   ^^^value |string |10.5 |Value of the discount.
* When `type==FREE_SHIPPING`, this value is not required.
* `type==DISCOUNT_SHIPPING_FEE`, this value is the maximum amount deducted from the buyer's price of shipping in local currency.
   The value should be limited to two decimal places. |
   ^^^shipping_method |string |STANDARD_SHIPPING |The shipping methods to which this promotion applies.
* When `STANDARD_SHIPPING`: Only applies to Standard Shipping methods, including Economy.
* `EXPRESS_SHIPPING`: Only applies to Express Shipping methods.
* `ALL_SHIPPING_METHOD`: Applies to all shipping methods that the shop offers.
   Default: `STANDARD_SHIPPING` |
   ^^^inventory_type |string |SELF_FULFILLED |The inventory types to which the promotion activity applies:
* `SELF_FULFILLED`: Only applies to Inventory fulfilled from seller warehouses
* `FULFILLED_BY_TIKTOK`: Only applies to Inventory fulfilled by TikTok from FBT (Fulfilled by TikTok) warehouses.
* `ALL`: Applies to all inventory of eligible products.
   Default: `SELF_FULFILLED`
   `FULFILLED_BY_TIKTOK` and `ALL` can only be set when `product_level`==`SHOP` and `threshold_type=NO_THRESHOLD`. |
   ^^^area_scope |object | |The (buyer's) geographical areas to which the promotion activity applies. |
   ^^^^type |string |WHOLE |The (buyer's) geographical area to which the promotion activity applies.
   - `WHOLE`: Promotion activity applies to all areas to which the seller offers fulfillment.
* `SPECIFIC_AREAS`: Only applies to specific fulfillment areas, as defined in `area_scope.specific_areas`. |
   ^^^^specific_areas |[]string |["Washington","New York"] |The list of areas for which the promotion activity applies. The valid values that may be included in this list are dependent on the region of the shop. The list of valid values for each shop region are available here: [link](https://partner.tiktokshop.com/docv2/page/67e3b059e7dc4f04a4ff9e09) |
   ^^bmsm_discount |object | |Configurations related to Buy More Save More (BMSM) promotions. |
   ^^^details |[]object | |Configurations for BMSM promotions.
   A maximum of two `tier`s are permitted. `details.threshold_type` and `details.type` must be the same across all `tier`s. |
   ^^^^tier |int |1 |`tier` uses 1-based indexing, i.e. the first and second tiers are counted "1, 2", not "0, 1".
   `threshold_value` and `value` for a given tier must be greater than that of the previous tier.
   E.g. If `tier`1 has <code>threshold_value</code>`20` and `value`== `15`, `tier`==2 must have `threshold_value` > `20` and `value`>`15`. |
   ^^^^threshold_type |string |MINIMAL_ITEM_QUANTITY |The type of purchase criteria. Possible enumerations are:
* `MINIMAL_ITEM_QUANTITY`: Buyer must meet or exceed the minimum spend criteria with eligible products.
* `MINIMAL_ORDER_AMOUNT`: Buyer must meet or exceed the minimum spend criteria with eligible order. |
   ^^^^threshold_value |string |5 |The purchase threshold of the discount, based on the `threshold_type`, e.g., "3". Determined by user.
* When `threshold_type==NO_THRESHOLD`, this value is not required.
* When `threshold_type==MINIMAL_ITEM_QUANTITY`, buyer must purchase at least the specified number of eligible products (e.g. must purchase 3 or more eligible products to receive the benefit). If it represents a quantity, it must be an integer.
* When `threshold_type==MINIMAL_ORDER_AMOUNT`, the eligible product subtotal for the buyer's order must meet or exceed the specified order value in local currency (e.g. buyer's order subtotal must be at least $3 to receive the benefit). If it represents an order value, it must be limited to two decimal places. |
   ^^^^type |string |PERCENTAGE_OFF |The type of discount awarded as a benefit. The value of the discount is determined by `value`.
   Possible enumerations are:
* `PERCENTAGE_OFF`: Buyer will receive X% off the price of the eligible products.
* `AMOUNT_OFF`: Buyer will receive X units of local currency off the price of eligible products. |
   ^^^^value |string |10 |Value of the discount.
* When `type`==`PERCENTAGE_OFF`, the buyer will receive X% off the price of eligible products. If the value represents a percentage, it should be an integer.
* `type`==`AMOUNT_OFF`, the buyer will receive X units of local currency off the price of eligible products. If the value represents a monetary amount, it should be limited to two decimal places.
   |
   ^^gift_discount |object | |Configurations related to Gift With Purchase (GWP) promotions. Only needs to be configured for GWP promotions. |
   ^^^gift_receiving_type |string |ALL_RECEIVE |The receiving type of gift. Currently only supports one type: `ALL_RECEIVE` |
   ^^^gift_infos |[]object | |Configurations regarding Gift With Purchase (GWP) promotions.
   A maximum of two `tier`s are permitted in SEA and UK. Only one `tier` is permitted in US. And `threshold_type` must be the same across all `tier`s. |
   ^^^^tier |int |1 |`tier` uses 1-based indexing, i.e. the first and second tiers are counted "1, 2", not "0, 1".
   `threshold_value` for a given tier must be greater than that of the previous tier.
   E.g. If `tier`1 has <code>threshold_value</code>`2`, `tier`==2 must have `threshold_value` > `2`. |
   ^^^^threshold_type |string |MINIMAL_ITEM_QUANTITY |purchase threshold type of discount. Possible enumerations are:
* `MINIMAL_ITEM_QUANTITY`: Buyer must meet or exceed the minimum spend criteria with eligible products.
* `MINIMAL_ORDER_AMOUNT`: Buyer must meet or exceed the minimum spend criteria with eligible order. |
   ^^^^threshold_value |string |3 |The purchase threshold value of the gift, based on `threshold_type`. Determined by the user.
* When `threshold_type==MINIMAL_ITEM_QUANTITY`, the buyer must purchase at least the specified number of eligible products (for example, 3 eligible products). If it represents a quantity, it must be an integer.
* When `threshold_type==MINIMAL_ORDER_AMOUNT`, the eligible-product subtotal must meet or exceed the specified value in local currency (for example, 3 units of local currency). If it represents an order value, it must be limited to two decimal places. |
   ^^^^gift_details |[]object | |Gift configurations related to Gift With Purchase (GWP) promotions. |
   ^^^^^product_id |string |1732239744891062847 |TikTok Shop product id of gift. |
   ^^^^^sku_id |string |1732239787859544639 |TikTok Shop sku ID of gift. |
   ^^^^^total_claim_limit |string |100 |The quantity limit of the gift sku which is involved in the activity. The range is [1, 99999]. If you are updating the value of an existing sku, the value cannot be decreased. |
   ^^bxgy_discount |object | |Configurations related to Buy X Get Y (BXGY) promotions. Only needs to be configured for BXGY promotions. |
   ^^^threshold_type |string |MINIMAL_ITEM_QUANTITY |The purchase criterion returned for the activity.
   Possible values:
* `MINIMAL_ITEM_QUANTITY`: The buyer must purchase at least the specified quantity of eligible products.
* `MINIMAL_ORDER_AMOUNT`: The eligible-product subtotal must reach the specified amount. |
   ^^^threshold_value |string |5 |The purchase threshold returned for the activity, based on `threshold_type`.
* When `threshold_type==MINIMAL_ITEM_QUANTITY`, this is the number of eligible products the buyer must purchase and must be an integer.
* When `threshold_type==MINIMAL_ORDER_AMOUNT`, this is the eligible-product subtotal the buyer must reach, in local currency. |
   ^^^discount_type |string |AMOUNT_OFF_EACH |The type of discount awarded as a benefit. For PERCENTAGE_OFF and AMOUNT_OFF_EACH, the discount amount is determined by `discount_value`.
   Possible enumerations are:
* `PERCENTAGE_OFF`: Buyer will receive X% off the price of the eligible products.
* `FREE`: Buyer will receive X eligible products for free.
* `AMOUNT_OFF_EACH`: Buyer will receive X units of local currency off the price of each eligible product. |
   ^^^discount_value |string |10 |Value of the discount.
* When `type`==`PERCENTAGE_OFF`, the buyer will receive X% off the price of eligible products. If the value represents a percentage, it should be an integer.
* `type`==`AMOUNT_OFF_EACH`, the buyer will receive X units of local currency off the price of each eligible products. If the value represents a monetary amount, it should be limited to two decimal places.
   |
   ^^^benefit_max_applicable_quantity |string |5 |The quantity of item Y in a BXGY promotion. This value must be a positive integer. |
   ^^^benefit_max_applicable_times |string |5 |Optional. The maximum number of times the BXGY benefit can be applied within a single order. This value must be a positive integer. |
   ^target_user_info |object | |The targeted user type of the promotion. |
   ^^user_type |string |ALL_USER |The targeted user type.
   Possible values:
* `ALL_USER`
* `SHOP_NEW_CUSTOMER`
* `SHOP_EXISTING_CUSTOMER`
* `SHOP_REPEAT_CUSTOMER`
* `SHOP_ABANDONED_CHECKOUTS_CUSTOMER` |
   ^benefit_products |[]object | |Benefit products in BXGY promotions |
   ^^id |string |1732239744891062847 |TikTokShop product ID |
   ^auction_support_type |string |ALL |Whether a `SHIPPING_DISCOUNT` activity supports auction products. This field is omitted for other activity types and can also be omitted for a shipping-discount activity when auction-support data is unavailable.
   Possible values:
* `ALL`: The activity supports both normal products and auction products.
* `EXCLUDE_AUCTION`: The activity does not support auction products. |

### Response Sample
```json
{"code":0,"data":{"activity_id":"7136104329798256386","title":"FlashSale 20230707","activity_type":"FIXED_PRICE","duration_type":"NORMAL","begin_time":1661756811,"end_time":1661856811,"participation_limit":[{"type":"BUYER_NO_LIMIT"}],"products":[{"id":"7136011254174631686","activity_price":{"amount":"70500","currency":"IDR"},"quantity_limit":-1,"quantity_per_user":-1,"discount":"10","skus":[{"id":"7136382541418366725","discount":"10","quantity_limit":-1,"quantity_per_user":-1,"activity_price":{"amount":"70500","currency":"IDR"},"used_quantity":3}],"used_quantity":3}],"status":"ONGOING","create_time":1789355787347,"update_time":1789355865063,"product_level":"PRODUCT","activity_commands":["IMMUTABLE"],"discount":{"shipping_discount":{"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"3","type":"DISCOUNT_SHIPPING_FEE","value":"10.5","shipping_method":"STANDARD_SHIPPING","inventory_type":"SELF_FULFILLED","area_scope":{"type":"WHOLE","specific_areas":["Washington","New York"]}},"bmsm_discount":{"details":[{"tier":1,"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"5","type":"PERCENTAGE_OFF","value":"10"}]},"gift_discount":{"gift_receiving_type":"ALL_RECEIVE","gift_infos":[{"tier":1,"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"3","gift_details":[{"product_id":"1732239744891062847","sku_id":"1732239787859544639","total_claim_limit":"100"}]}]},"bxgy_discount":{"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"5","discount_type":"AMOUNT_OFF_EACH","discount_value":"10","benefit_max_applicable_quantity":"5","benefit_max_applicable_times":"5"}},"target_user_info":{"user_type":"ALL_USER"},"benefit_products":[{"id":"1732239744891062847"}],"auction_support_type":"ALL"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 17029001 | Invalid parameters |
| 17029009 | Activity does not exist |
| 17029028 | You are specifying activities not in your shop. |
| 17029036 | ActivityType is not supported. |
| 17029052 | ProductType is not supported |
| 17029055 | Request Timeout |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Search Promotion Activities — `POST /promotion/202309/activities/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-promotion-activities-202309 · cập nhật 2026-10-28 · scope: seller.promotion.info

### Path: /promotion/202309/activities/search
### Method: [POST]
### Function Description
Search product discount, flash sale, shipping discount, Buy More Save More, Gift With Purchase, and Buy X Get Y promotion activities. For coupon activities, use [Search Coupons](https://partner.tiktokshop.com/docv2/page/6699dcdf115ebe02f841e4cd).

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| status | string | N | ONGOING | Filter activities by status. If omitted, activities with `NOT_START`, `ONGOING`, `EXPIRED`, or `DEACTIVATED` status are returned. Possible values: |

* `NOT_START`: The activity is not available to TikTok users until its start time.
* `ONGOING`: The activity is available to TikTok users.
* `EXPIRED`: The activity is no longer available because it has expired.
* `DEACTIVATED`: The activity was deactivated by the seller and is not available to TikTok users. |
   activity_title |string |N |Discount |Activity title key words. No fuzzy matching. |
   page_size |int |N |20 |Number of activities to return per page. Range: 0 to 100. If omitted or set to 0, the effective page size is 10. |
   page_token |string |N |21 |Specify the value for the page. Use `""` for the first page. |
   activity_type |string |N |FLASHSALE |The type of promotion activity to return. If `activity_type` is omitted, activities of all supported types are returned. Possible values:
* `FIXED_PRICE`: Product discount activity with a fixed price.
* `DIRECT_DISCOUNT`: Product discount activity with a percentage off.
* `FLASHSALE`: Flash sale activity.
* `SHIPPING_DISCOUNT`: Shipping fee discount activity.
* `BUY_MORE_SAVE_MORE`: Buy More Save More activity.
* `GIFT_WITH_PURCHASE`: Gift With Purchase activity.
* `BUY_X_GET_Y`: Buy X Get Y activity. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/promotion/202309/activities/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"status":"ONGOING","activity_title":"Discount","page_size":20,"page_token":"21","activity_type":"FLASHSALE"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^total_count | int | 120 | Total number of activities matching the supplied filters. This value can be greater than the number of entries in activities. |
| ^next_page_token | string | 1661756811000 | Page cursor for the next request. Pass a non-empty returned token as `page_token` to retrieve the next page. Stop when `next_page_token` is omitted or empty. |
| ^activities | []object |  | Activities list information. |
| ^^id | string | 7136104329798256386 | A unique ID that identifies different activities. |
| ^^title | string | FlashSale 20230707 | Activity name (50 characters max). |
| ^^activity_type | string | FIXED_PRICE | The type of promotion activity. Possible values: |

* `FIXED_PRICE`: Product discount activity with a fixed price.
* `DIRECT_DISCOUNT`: Product discount activity with a percentage off.
* `FLASHSALE`: Flash sale activity.
* `SHIPPING_DISCOUNT`: Shipping fee discount activity.
* `BUY_MORE_SAVE_MORE`: Buy More Save More activity.
* `GIFT_WITH_PURCHASE`: Gift With Purchase activity.
* `BUY_X_GET_Y`: Buy X Get Y activity. |
   ^^duration_type |string |INDEFINITE |The effective time type of the current activity
* NORMAL: `begin_time` and `end_time` must be filled
* INDEFINITE: `begin_time` and `end_time` aren't required, and the promotion will be a long-term activity which runs indefinitely.
1. `INDEFINITE` is only valid when `activity_type` is `SHIPPING_DISCOUNT`,
2. If `duration_type` is `INDEFINITE`, `start_time` and `end_time` should be 0
   Default: NORMAL |
   ^^begin_time |int |1661756811 |Activity start time, as a Unix timestamp in seconds. |
   ^^end_time |int |1661756811 |Activity end time, as a Unix timestamp in seconds. |
   ^^status |string |ONGOING |Activity status.
   Possible values:
* DRAFT: Promotion activities with this status are not available to TikTok users.
* NOT_START: Promotion activities with this status are not available to TikTok users until the set activity start time.
* ONGOING: Promotion activities with this status are available to TikTok users.
* EXPIRED: Promotion activities with this status are not available to TikTok users because it has expired.
* DEACTIVATED: The activity has been deactivated by the seller and is not available to TikTok users.
* NOT_EFFECTIVE: The activity is terminated by the platform and is not available to TikTok users. |
   ^^create_time |int |1788301318971 |The time when the activity was created, as a Unix timestamp in milliseconds. |
   ^^update_time |int |1788301318971 |The time when the activity was last updated, as a Unix timestamp in milliseconds. |
   ^^product_level |string |PRODUCT |Activity product dimension, values are:
   - PRODUCT: Promotion activity applies at the product (SPU) level. Any and all SKUs that are part of this product will be subject to the promotion.
   - VARIATION: Promotion activity only applies to specified SKUs.
   - SHOP: Promotion activity applies to all products in the shop. |
   ^^activity_commands |[]string |["IMMUTABLE"] |Applicable commands to the activity:
* IMMUTABLE: The activity cannot be edited or deactivated. |
   ^^participation_limit |[]object | |The number of times a buyer can participate in the promotion. |
   ^^^type |string |BUYER_NO_LIMIT |Determines whether the promotion activity limits the number of times each buyer can receive its benefit. e.g.:
* `BUYER_NO_LIMIT`: No limit for buyers. Buyers can benefit from this promotion across multiple orders.
* `BUYER_LIMIT_ONLY_ONE`: Buyers can benefit from this promotion activity for no more than one order.
   Default: `BUYER_NO_LIMIT` |
   ^^discount |object | |Discount information. This field is omitted for `FIXED_PRICE`, `DIRECT_DISCOUNT`, and `FLASHSALE` activities. |
   ^^^shipping_discount |object | |Configurations for the shipping discount, including purchase criteria, discount value, shipping method, inventory type, and area scope. |
   ^^^^threshold_type |string |MINIMAL_ITEM_QUANTITY |The type of purchase criteria. Possible enumerations are:
* `NO_THRESHOLD`: No minimum purchase criteria.
* `MINIMAL_ITEM_QUANTITY`: Buyer must meet or exceed the minimum spend criteria with eligible products.
* `MINIMAL_ORDER_AMOUNT`: Buyer must meet or exceed the minimum spend criteria with eligible order.
   `MINIMAL_ITEM_QUANTITY` and `MINIMAL_ORDER_AMOUNT` can only be set when `product_level==SHOP`, |
   ^^^^threshold_value |string |3 |The purchase threshold of the shipping discount, based on the `threshold_type`, e.g., "3". Determined by the user.
* When `threshold_type==NO_THRESHOLD`, this value is not required.
* When `threshold_type==MINIMAL_ITEM_QUANTITY`, the buyer must purchase at least the specified number of eligible products (for example, 3 eligible products). If it represents a quantity, it must be an integer.
* When `threshold_type==MINIMAL_ORDER_AMOUNT`, the eligible product subtotal must meet or exceed the specified value in the shop's local currency (for example, 3 units of local currency). If it represents an order value, it must be limited to two decimal places. |
   ^^^^type |string |DISCOUNT_SHIPPING_FEE |The type of shipping discount returned for the promotion activity.
* FREE_SHIPPING: The buyer's shipping charge is fully covered.
* DISCOUNT_SHIPPING_FEE: The buyer's shipping charge is reduced by up to the amount in value. |
   ^^^^value |string |10.5 |Value of the shipping discount.
* When `type==FREE_SHIPPING`, this value is not returned.
* When `type==DISCOUNT_SHIPPING_FEE`, this value is the maximum amount deducted from the buyer's shipping price in local currency and should be limited to two decimal places. |
   ^^^^shipping_method |string |STANDARD_SHIPPING |The shipping methods to which this promotion applies.
* When `STANDARD_SHIPPING`: Only applies to Standard Shipping methods, including Economy.
* `EXPRESS_SHIPPING`: Only applies to Express Shipping methods.
* `ALL_SHIPPING_METHOD`: Applies to all shipping methods that the shop offers.
   Default: `STANDARD_SHIPPING` |
   ^^^^inventory_type |string |SELF_FULFILLED |The inventory types to which the promotion activity applies:
* `SELF_FULFILLED`: Only applies to Inventory fulfilled from seller warehouses
* `FULFILLED_BY_TIKTOK`: Only applies to Inventory fulfilled by TikTok from FBT (Fulfilled by TikTok) warehouses.
* `ALL`: Applies to all inventory of eligible products.
   Default: `SELF_FULFILLED`
   `FULFILLED_BY_TIKTOK` and `ALL` can only be set when `product_level`==`SHOP` and `threshold_type=NO_THRESHOLD`. |
   ^^^^area_scope |object | |The (buyer's) geographical areas to which the promotion activity applies |
   ^^^^^type |string |WHOLE |The buyer's geographical area to which the promotion activity applies.
* `WHOLE`: The promotion activity applies to all areas to which the seller offers fulfillment.
* `SPECIFIC_AREAS`: The promotion activity applies only to fulfillment areas listed in `area_scope.specific_areas`. |
   ^^^^^specific_areas |[]string |["Washington","New York"] |The list of areas for which the promotion activity applies. The valid values that may be included in this list are dependent on the region of the shop. The list of valid values for each shop region are available here: [link](https://partner.tiktokshop.com/docv2/page/67e3b059e7dc4f04a4ff9e09) |
   ^^^bmsm_discount |object | |Configurations related to Buy More Save More (BMSM) promotions |
   ^^^^details |[]object | |Configurations for Buy More Save More (BMSM) promotions. A maximum of two `tier`s is permitted. `details.threshold_type` and `details.type` must be the same across all tiers. |
   ^^^^^tier |int |1 |`tier` uses 1-based indexing, i.e. the first and second tiers are counted "1, 2", not "0, 1".
   `threshold_value` and `value` for a given tier must be greater than that of the previous tier.
   E.g. If `tier`1 has <code>threshold_value</code>`20` and `value`==`15`, `tier`==2 must have `threshold_value` > `20` and `value`>`15`. |
   ^^^^^threshold_type |string |MINIMAL_ITEM_QUANTITY |The type of purchase criteria. Possible enumerations are:
* `MINIMAL_ITEM_QUANTITY`: Buyer must meet or exceed the minimum spend criteria with eligible products.
* `MINIMAL_ORDER_AMOUNT`: Buyer must meet or exceed the minimum spend criteria with eligible order. |
   ^^^^^threshold_value |string |5 |The purchase threshold of the discount, based on the `threshold_type`, e.g., "3". Determined by user.
* When `threshold_type==NO_THRESHOLD`, this value is not required.
* When `threshold_type==MINIMAL_ITEM_QUANTITY`, buyer must purchase at least the specified number of eligible products (e.g. must purchase 3 or more eligible products to receive the benefit). If it represents a quantity, it must be an integer.
* When `threshold_type==MINIMAL_ORDER_AMOUNT`, the eligible product subtotal for the buyer's order must meet or exceed the specified order value in local currency (e.g. buyer's order subtotal must be at least $3 to receive the benefit). If it represents an order value, it must be limited to two decimal places. |
   ^^^^^type |string |PERCENTAGE_OFF |The type of discount awarded as a benefit. The value of the discount is determined by `value`.
   Possible enumerations are:
* `PERCENTAGE_OFF`: Buyer will receive X% off the price of the eligible products.
* `AMOUNT_OFF`: Buyer will receive X units of local currency off the price of eligible products. |
   ^^^^^value |string |10 |Value of the discount.
* When `type`==`PERCENTAGE_OFF`, the buyer will receive X% off the price of eligible products. If the value represents a percentage, it should be an integer.
* `type`==`AMOUNT_OFF`, the buyer will receive X units of local currency off the price of eligible products. If the value represents a monetary amount, it should be limited to two decimal places. |
   ^^^gift_discount |object | |Configurations related to Gift With Purchase (GWP) promotions. Only needs to be configured for GWP promotions. |
   ^^^^gift_receiving_type |string |ALL_RECEIVE |The receiving type of gift. Currently only one type is supported:
* `ALL_RECEIVE`: All gifts configured in the promotion can be collected. |
   ^^^^gift_infos |[]object | |Configurations regarding Gift With Purchase (GWP) promotions.
   A maximum of two `tier`s are permitted in SEA and UK. Only one `tier` is permitted in US. And `threshold_type` must be the same across all `tier`s. |
   ^^^^^tier |int |1 |`tier` uses 1-based indexing, i.e. the first and second tiers are counted "1, 2", not "0, 1".
   `threshold_value` for a given tier must be greater than that of the previous tier.
   E.g. If `tier`1 has <code>threshold_value</code>`2`, `tier`==2 must have `threshold_value` > `2`. |
   ^^^^^threshold_type |string |MINIMAL_ITEM_QUANTITY |Purchase threshold type of discount. Possible enumerations are:
* `MINIMAL_ITEM_QUANTITY`: Buyer must meet or exceed the minimum spend criteria with eligible products.
* `MINIMAL_ORDER_AMOUNT`: Buyer must meet or exceed the minimum spend criteria with eligible order. |
   ^^^^^threshold_value |string |3 |The purchase threshold value for the gift, based on the `threshold_type`. Determined by the user.
* When `threshold_type==MINIMAL_ITEM_QUANTITY`, the buyer must purchase at least the specified number of eligible products (for example, 3 eligible products). If it represents a quantity, it must be an integer.
* When `threshold_type==MINIMAL_ORDER_AMOUNT`, the eligible product subtotal must meet or exceed the specified value in the shop's local currency (for example, 3 units of local currency). If it represents an order value, it must be limited to two decimal places. |
   ^^^^^gift_details |[]object | |Gift configurations related to Gift With Purchase (GWP) promotions. |
   ^^^^^^product_id |string |1732239744891062847 |TikTok Shop product id of gift. |
   ^^^^^^sku_id |string |1732239787859544639 |TikTok Shop sku id of gift. |
   ^^^^^^total_claim_limit |string |100 |The quantity limit of the gift sku which is involved in the activity. The range is [1, 99999]. If you are updating the value of an existing sku, the value cannot be decreased. |
   ^^^bxgy_discount |object | |Configurations related to Buy X Get Y (BXGY) promotions. Only needs to be configured for BXGY promotions. |
   ^^^^threshold_type |string |MINIMAL_ITEM_QUANTITY |The purchase criterion returned for the activity.
   Possible values:
* `MINIMAL_ITEM_QUANTITY`: The buyer must purchase at least the specified quantity of eligible products.
* `MINIMAL_ORDER_AMOUNT`: The eligible-product subtotal must reach the specified amount. |
   ^^^^threshold_value |string |5 |The purchase threshold returned for the activity, based on `threshold_type`.
* When `threshold_type==MINIMAL_ITEM_QUANTITY`, this is the number of eligible products the buyer must purchase and must be an integer.
* When `threshold_type==MINIMAL_ORDER_AMOUNT`, this is the eligible-product subtotal the buyer must reach, in local currency. |
   ^^^^discount_type |string |AMOUNT_OFF_EACH |The type of discount awarded as a benefit. For PERCENTAGE_OFF and AMOUNT_OFF_EACH, the discount amount is determined by discount_value.
   Possible values:
* PERCENTAGE_OFF: Buyer will receive X% off the price of the eligible products.
* FREE: Buyer will receive X eligible products for free.
* AMOUNT_OFF_EACH: Buyer will receive X units of local currency off the price of each eligible product. |
   ^^^^discount_value |string |5 |Value of the discount.
* When `type`==`PERCENTAGE_OFF`, the buyer will receive X% off the price of eligible products. If the value represents a percentage, it should be an integer.
* `type`==`AMOUNT_OFF_EACH`, the buyer will receive X units of local currency off the price of each eligible products. If the value represents a monetary amount, it should be limited to two decimal places.
   |
   ^^^^benefit_max_applicable_quantity |string |5 |The quantity of item Y in a BXGY promotion. This value must be a positive integer. |
   ^^^^benefit_max_applicable_times |string |5 |Optional. The maximum number of times the BXGY benefit can be applied within a single order. This value must be a positive integer. |
   ^^auction_support_type |string |ALL |Whether a `SHIPPING_DISCOUNT` activity supports auction products. This field is omitted for other activity types and can be omitted when auction-support data is unavailable.
   Possible values:
* `ALL`: The activity supports both normal products and auction products.
* `EXCLUDE_AUCTION`: The activity does not support auction products. |

### Response Sample
```json
{"code":0,"data":{"total_count":120,"next_page_token":"1661756811000","activities":[{"id":"7136104329798256386","title":"FlashSale 20230707","activity_type":"FIXED_PRICE","duration_type":"INDEFINITE","begin_time":1661756811,"end_time":1661756811,"status":"ONGOING","create_time":1788301318971,"update_time":1788301318971,"product_level":"PRODUCT","activity_commands":["IMMUTABLE"],"participation_limit":[{"type":"BUYER_NO_LIMIT"}],"discount":{"shipping_discount":{"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"3","type":"DISCOUNT_SHIPPING_FEE","value":"10.5","shipping_method":"STANDARD_SHIPPING","inventory_type":"SELF_FULFILLED","area_scope":{"type":"WHOLE","specific_areas":["Washington","New York"]}},"bmsm_discount":{"details":[{"tier":1,"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"5","type":"PERCENTAGE_OFF","value":"10"}]},"gift_discount":{"gift_receiving_type":"ALL_RECEIVE","gift_infos":[{"tier":1,"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"3","gift_details":[{"product_id":"1732239744891062847","sku_id":"1732239787859544639","total_claim_limit":"100"}]}]},"bxgy_discount":{"threshold_type":"MINIMAL_ITEM_QUANTITY","threshold_value":"5","discount_type":"AMOUNT_OFF_EACH","discount_value":"5","benefit_max_applicable_quantity":"5","benefit_max_applicable_times":"5"}},"auction_support_type":"ALL"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 17029001 | Invalid parameters |
| 17029055 | Request Timeout |
| 17029059 | `page_token + page_size` must be less than `10000`. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Update Promotion Activity Products — `PUT /promotion/202309/activities/{activity_id}/products`

Doc: https://partner.tiktokshop.com/docv2/page/update-promotion-activity-products-202309 · cập nhật 2026-10-28 · scope: seller.promotion.write

### Path: /promotion/202309/activities/{activity_id}/products
### Method: [PUT]
### Function Description
Use this API as follows:

* For a `FIXED_PRICE`, `DIRECT_DISCOUNT`, or `FLASHSALE` activity with PRODUCT or VARIATION scope, provide a non-empty `products` array. For VARIATION scope, add or update SKUs in each product's `skus` array.
* For a PRODUCT-scoped `SHIPPING_DISCOUNT` or `GIFT_WITH_PURCHASE` activity, provide a non-empty `products` array. A SHOP-scoped shipping-discount activity is not supported by this operation, and this operation does not document nested-SKU updates for shipping-discount or Gift With Purchase.
* For a PRODUCT-scoped `BUY_MORE_SAVE_MORE` or `BUY_X_GET_Y` activity, `products` can be omitted or empty when the request updates only benefit-product relations.
* For a SHOP-scoped `BUY_MORE_SAVE_MORE` or `BUY_X_GET_Y` activity, omit `products` or pass an empty array; use `benefit_product_ids` or `exclude_product_ids` for the applicable relation update.
   For an ongoing flash deal, you can add products or SKUs, but you cannot change the price or purchase limits of products or SKUs already in the activity. To remove products or SKUs, use [Remove Activity Product](https://partner.tiktokshop.com/docv2/page/650acfd84a0bb702c072b4eb).

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| activity_id | string | Y | 7402881377634567979 | The unique identifier of the promotion activity. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| products | []object | N |  | The items to add to the list or the existing items in the list of promotion activity to edit. The length must not exceed `300`. |
| ^id | string | Y | 7135427619356477189 | TikTok Shop product ID |
| ^activity_price_amount | string | N | 4.5 | Deal price in the product's currency. Specify this field when `product_level==PRODUCT` and `activity_type` is `FIXED_PRICE` or `FLASHSALE`. Do not specify it when `activity_type==DIRECT_DISCOUNT` or when `product_level==VARIATION`. |
| ^discount | string | N | 10 | Discount value. If the product is 10% off, the value is `10`. |
| You must specify the value when `product_level==PRODUCT` and `activity_type==DIRECT_DISCOUNT`; and you must not specify it when it's not. |  |  |  |  |
| ^quantity_limit | int | Y | -1 | The quantity limit of the products involved in the activity. The range is `[1, 99]`, or you can use `-1` for unlimited. If you are updating the value of an existing product, the value cannot be less than the current value. |
| When `product_level==VARIATION`, you must specify `-1`. |  |  |  |  |
| ^quantity_per_user | int | Y | -1 | Limit of product purchase per buyer. The range is `[1, 99]`, or you can use `-1` for unlimited. If you are updating the value of an existing product, the value cannot be less than the current value. |
| When `product_level==VARIATION`, you must specify `-1`. |  |  |  |  |
| ^skus | []object | N |  | The SKUs to add to the list or to edit. The number of the SKUs across all products must not exceed 300 in an API call. |
| For a product-discount or flash-deal activity with `product_level==VARIATION`, every product must contain at least one SKU. For those activity types with `product_level==PRODUCT`, specify `[]`. |  |  |  |  |
| ^^id | string | Y | 7125688837187176194 | SKU ID |
| ^^activity_price_amount | string | N | 6.5 | Deal price in the SKU's currency. Specify this field when `product_level==VARIATION` and `activity_type` is `FIXED_PRICE` or `FLASHSALE`. Do not specify it when `activity_type==DIRECT_DISCOUNT`. |
| ^^discount | string | N | 10 | Discount value. If the SKU is 10% off, the value is `10`. |
| You must specify this value when `product_level==VARIATION` and `activity_type==DIRECT_DISCOUNT`. Do not specify it when `activity_type` is `FIXED_PRICE` or `FLASHSALE`. |  |  |  |  |
| ^^quantity_limit | int | Y | -1 | The quantity limit of the SKU involved in the activity. The range is `[1, 99]`, or you can use `-1` for unlimited. If you are updating the value of an existing SKU, the value cannot be decreased. |
| ^^quantity_per_user | int | Y | 10 | Limit of SKU purchase per buyer. The range is `[1, 99]`, or you can use `-1` for unlimited. If you are updating the value of an existing SKU, the value cannot be decreased. |
| activity_id | string | Y | 7136104288010372865 | A unique ID that identifies activities. |
| You cannot update the products in `DEACTIVATED` or `EXPIRED` activities. |  |  |  |  |
| benefit_product_ids | []string | N | ["7135427619356477189","7135427619356477190"] | IDs of benefit products to add to or update in a Buy More Save More (BMSM) or Buy X Get Y (BXGY) activity. Omitting this field or passing an empty array leaves the activity's existing benefit products unchanged; it does not remove them. After the update, the activity can contain at most 100 benefit products. |
| exclude_product_ids | []string | N | ["7135427619356477189","7135427619356477190"] | For a SHOP-level Buy More Save More (BMSM) or Buy X Get Y (BXGY) activity, these are the IDs of products to add to or update in the exclusion list. Omitting this field or passing an empty array leaves existing excluded products unchanged; it does not remove them. Maximum: 100 IDs per request. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/promotion/202309/activities/7402881377634567979/products?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"products":[{"id":"7135427619356477189","activity_price_amount":"4.5","discount":"10","quantity_limit":-1,"quantity_per_user":-1,"skus":[{"id":"7125688837187176194","activity_price_amount":"6.5","discount":"10","quantity_limit":-1,"quantity_per_user":10}]}],"activity_id":"7136104288010372865","benefit_product_ids":["7135427619356477189","7135427619356477190"],"exclude_product_ids":["7135427619356477189","7135427619356477190"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^activity_id | string | 7136104329798256386 | A unique ID that identifies different activities. |
| ^title | string | DiscountPromotion | Activity name set by the merchant. |
| ^update_time | int | 1661756811 | The time when the response was generated, as a Unix timestamp in seconds (UTC). |
| ^status | string | DRAFT | Activity status. |
| Possible values: |  |  |  |

* DRAFT: Promotion activities with this status are not available to TikTok users.
* NOT_START: Promotion activities with this status are not available to TikTok users until the set activity start time.
* ONGOING: Promotion activities with this status are available to TikTok users.
* EXPIRED: Promotion activities with this status are not available to TikTok users because it has expired.
* DEACTIVATED: The activity has been deactivated by the seller and is not available to TikTok users.
* NOT_EFFECTIVE: The activity is terminated by the platform and is not available to TikTok users. |
   ^total_count |int |1 |The number of items in this request.
   When `product_level==PRODUCT`, this is the number of products. When `product_level==VARIATION`, this is the total number of SKUs across all products. When `product_level==SHOP`, this value is `0`. IDs in `benefit_product_ids` and `exclude_product_ids` are not included. |

### Response Sample
```json
{"code":0,"data":{"activity_id":"7136104329798256386","title":"DiscountPromotion","update_time":1661756811,"status":"DRAFT","total_count":1},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 17011102 | Promotion title cannot be a duplicate. |
| 17027107 | Internal system error, please try again later. |
| 17029001 | Invalid parameters |
| 17029009 | Activity does not exist |
| 17029010 | Activity is deactivated |
| 17029012 | Not allowed to update expired activities |
| 17029013 | `sku` must be `[]` for activities of which `product_level==PRODUCT`. |
| 17029014 | The value of `quantity_per_user` is out of range. |
| 17029015 | When `product_level==VARIATION`, the value of `quantity_limit` must be `-1`. |
| 17029016 | Invalid SKU ID. |
| 17029017 | You are specifying products not in your shop. |
| 17029018 | The provided SKU quantity is greater than the available stock. |
| 17029019 | The provided product quantity is greater than the available stock. |
| 17029020 | Product discount exceeds limit. The limit varies based on products and regions. |
| 17029021 | SKU discount exceeds limit. The limit varies based on products and regions. |
| 17029022 | The product or SKU cannot be in two `ONGOING` or `NOT_START` activities at the same time. |
| 17029025 | The quantity of the products or the SKUs included in the activity exceeds `10000`. |
| 17029026 | Invalid SellerID |
| 17029028 | You are specifying activities not in your shop. |
| 17029029 | You are incorrectly specifying `activity_price_amount` instead of `discount` when `activity_type==DIRECT_DISCOUNT` and `product_level==PRODUCT`. |
| 17029030 | You are incorrectly specifying `discount` instead of `activity_price_amount` when `activity_type==FIXED_PRICE / FLASHSALE` and `product_level==PRODUCT`. |
| 17029031 | You are incorrectly specifying `activity_price_amount` instead of `discount` when `activity_type==DIRECT_DISCOUNT` and `product_level==VARIATION`. |
| 17029032 | You are incorrectly specifying `discount` instead of `activity_price_amount` when `activity_type==FIXED_PRICE / FLASHSALE` and `product_level==VARIATION`. |
| 17029033 | `products` is empty. |
| 17029034 | `activity_price_amount` is invalid. |
| 17029037 | `skus` is empty when `product_level==VARIATION`. |
| 17029038 | When `product_level==VARIATION`, you must not specify `product.activity_price_amount` and `product.discount`. |
| 17029039 | Duplicate product ID. |
| 17029040 | Duplicate SKU ID. |
| 17029041 | You must specify `product.discount` when `activity_type==DIRECT_DISCOUNT` and `product_level==PRODUCT`. |
| 17029042 | You must specify `product.activity_price_amount` when `activity_type==FIXED_PRICE / FLASHSALE` and `product_level==PRODUCT`. |
| 17029043 | You must specify `sku.discount` when `activity_type==DIRECT_DISCOUNT` and `product_level==VARIATION`. |
| 17029044 | You must specify `sku.activity_price_amount` when `activity_type==FIXED_PRICE / FLASHSALE` and `product_level==VARIATION`. |
| 17029045 | Duplicated RequestSerialNo. |
| 17029046 | Number of items per request exceeds the limit. |
| 17029047 | An `ONGOING` flash sale product cannot be updated. |
| 17029048 | An `ONGOING` flash sale SKU cannot be updated. |
| 17029049 | ActivityVersion is not supported. |
| 17029050 | The value of `quantity_limit` and `quantity_per_user` must be `-1` or in the range of `[1, 99]`. |
| 17029051 | Product ID not found. |
| 17029053 | The SKU ID does not match the product ID. |
| 17029054 | Please limit the request frequency. |
| 17029055 | Request Timeout |
| 17029056 | Invalid product status. |
| 17029058 | Unable to decrease buyer/num PurchaseLimit. |
| 17029060 | The Categories of products is invalid |
| 17029062 | Discount is below the limit, please confirm. |
| 17029063 | SKU discount is below the limit, please confirm. |
| 17029064 | Product is non-sellable. |
| 17029065 | Target quota is less than the initial quota. |
| 17029066 | Limit info cannot be changed or modified. |
| 17029067 | Auction products are not eligible for promotions. |
| 17029069 | Access denied. This activity does not belong to this shop and therefore cannot be modified. |
| 17029074 | Eligible products and the gift products must not be the same product. |
| 17029079 | Product is already assigned in another conflicting promotion. |
| 17029103 | Partial of products have already been applied to another conflict promotion during the selected period. |
| 17029104 | The product(s) selected have already been applied to another buy more save more promotion during the selected period. To proceed, edit the product list or change the promotion period. |
| 17029113 | The number of products will exceed the maximum number of the promotion. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Remove Promotion Activity Products — `DELETE /promotion/202309/activities/{activity_id}/products`

Doc: https://partner.tiktokshop.com/docv2/page/remove-promotion-activity-products-202309 · cập nhật 2026-10-28 · scope: seller.promotion.write

### Path: /promotion/202309/activities/{activity_id}/products
### Method: [DELETE]
### Function Description
Use this API for `FIXED_PRICE`, `DIRECT_DISCOUNT`, `FLASHSALE`, `BUY_MORE_SAVE_MORE`, `BUY_X_GET_Y`, `GIFT_WITH_PURCHASE`, and `SHIPPING_DISCOUNT` activities. Provide at least one non-empty removal list; omitting the body, sending an empty object, or sending only empty lists does not request an item removal.

* When removing ordinary activity products from a PRODUCT-scoped activity, use `product_ids` and do not provide `sku_ids`.
* When removing ordinary activity products or SKUs from a VARIATION-scoped activity, use `product_ids`, `sku_ids`, or both.
* For `GIFT_WITH_PURCHASE`, provide a non-empty `product_ids` list; the other removal lists are not processed by its branch.
* For `BUY_MORE_SAVE_MORE` or `BUY_X_GET_Y`, `benefit_product_ids` removes benefit-product relations without requiring `product_ids`.
* For a SHOP-scoped `BUY_MORE_SAVE_MORE`, `BUY_X_GET_Y`, or `SHIPPING_DISCOUNT` activity, `exclude_product_ids` removes excluded-product relations.
   You can provide multiple applicable non-empty lists in one ordinary non-GWP request. You cannot remove items from a `DEACTIVATED` or `EXPIRED` activity.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| activity_id | string | Y | 7402881377634567979 | The unique identifier of the promotion activity. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| product_ids | []string | N | ["7493989962827597361"] | IDs of the products to remove. |
| Max count: 300. |  |  |  |  |
| sku_ids | []string | N | ["7135657830438176513"] | IDs of the SKUs to remove. Do not specify this field for a product-level activity. |
| Max count: 300. |  |  |  |  |
| benefit_product_ids | []string | N | ["7493989962827597361"] | IDs of benefit-product relations to remove from a `BUY_MORE_SAVE_MORE` or `BUY_X_GET_Y` activity. Maximum: 100 IDs. |
| exclude_product_ids | []string | N | ["7493989962827597361"] | IDs of excluded-product relations to remove from a SHOP-scoped `BUY_MORE_SAVE_MORE`, `BUY_X_GET_Y`, or `SHIPPING_DISCOUNT` activity. Maximum: 100 IDs. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/promotion/202309/activities/7402881377634567979/products?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"product_ids":["7493989962827597361"],"sku_ids":["7135657830438176513"],"benefit_product_ids":["7493989962827597361"],"exclude_product_ids":["7493989962827597361"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^activity_id | string | 7136104329798256386 | A unique ID that identifies activities. |
| ^status | string | ONGOING | Activity status. |
| Possible values: |  |  |  |

* DRAFT: Promotion activities with this status are not available to TikTok users.
* NOT_START: Promotion activities with this status are not available to TikTok users until the set activity start time.
* ONGOING: Promotion activities with this status are available to TikTok users.
* EXPIRED: Promotion activities with this status are not available to TikTok users because it has expired.
* DEACTIVATED: The activity has been deactivated by the seller and is not available to TikTok users.
* NOT_EFFECTIVE: The activity is terminated by the platform and is not available to TikTok users. |
   ^update_time |int |1661765135 |The time when the response was generated, as a Unix timestamp in seconds (UTC). |

### Response Sample
```json
{"code":0,"data":{"activity_id":"7136104329798256386","status":"ONGOING","update_time":1661765135},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 17027802 | Internal error, promotion purchase limit deletion failed, please try again |
| 17029001 | Invalid parameters |
| 17029009 | Activity does not exist |
| 17029010 | Activity is deactivated |
| 17029011 | Not allowed to update the beginning time of activity |
| 17029012 | Not allowed to update expired activities |
| 17029016 | Invalid SKU ID. |
| 17029023 | Products Not In Promotion |
| 17029024 | SKU(s) not found in this promotion. |
| 17029028 | You are specifying activities not in your shop. |
| 17029036 | ActivityType is not supported. |
| 17029046 | Number of items per request exceeds the limit. |
| 17029047 | An `ONGOING` flash sale product cannot be updated. |
| 17029048 | An `ONGOING` flash sale SKU cannot be updated. |
| 17029052 | ProductType is not supported |
| 17029055 | Request Timeout |
| 17029069 | Access denied. This activity does not belong to this shop and therefore cannot be modified. |
| 17029074 | Eligible products and the gift products must not be the same product. |
| 17029079 | Product is already assigned in another conflicting promotion. |
| 17029102 | Product level and shop level are not interchangeable |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Coupon — `GET /promotion/202406/coupons/{coupon_id}`

Doc: https://partner.tiktokshop.com/docv2/page/get-coupon-202406 · cập nhật 2026-10-28 · scope: seller.promotion.info, seller.customer_service

### Path: /promotion/202406/coupons/{coupon_id}
### Method: [GET]
### Function Description
Use this API to get the full details of a coupon matching the {coupon_id}.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| coupon_id | string | Y | 7136104329798256386 | The unique identifier of the coupon. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/promotion/202406/coupons/7136104329798256386?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^coupon | object |  | The coupon detail object, including identity, display settings, status, claim and redemption durations, discount, threshold, product scope, usage limits, usage stats, and live tasks. |
| ^^id | string | 7342461823095965461 | A unique ID that identifies different coupons. |
| ^^title | string | Coupon202407 | Seller-specified title of the coupon. |
| ^^display_type | string | CHAT |  |
|The display type of coupons.
Values:

* `REGULAR`: Regular coupons which are displayed to TikTok users across all display locations available in TTS, including PLPs, PDPs, TikTok Videos, LIVE Rooms, Creator Showcases, and may be shared via TTS Customer Support instant messages. Includes coupons which target select customer segments.
* `LIVE`: Coupons which are only displayed to TikTok users in LIVE Rooms.
* `CREATOR_EXCLUSIVE`: Coupons that can be claimed through the display channels of the specified creator, such as their LIVE Rooms, and their Creator Showcase.
* `CHAT`: Exclusive coupons that may be sent to customers via TTS customer support chat messages, but are not displayed in other display locations.
* `PROMO_CODE`: Promo codes do not have dedicated display locations on TikTok, but may be shared with customers in LIVEs, in TikTok videos, or other social media platforms. They can be claimed by customers entering a claim code at checkout or by customers that use a custom promo code landing page URL.

|
^^status |string |NOT_START
|Coupon's promotion status.
Values:

* `NOT_START`: Not available to TikTok users until the coupon's configured start time.
* `ONGOING`: Available to TikTok users.
* `EXPIRED`: Not available to TikTok users because it has expired.
* `DEACTIVATED`: Deactivated by the seller and is not available to TikTok users.

|
^^create_time |int |1661756811000 |The UNIX timestamp, in milliseconds, when the coupon was created. |
^^update_time |int |1661756811000 |The UNIX timestamp, in milliseconds, when the coupon was last updated. |
^^claim_duration |object | |Claimable period of the coupon. |
^^^start_time |int |1709568000 |The UNIX timestamp, in seconds, from which a shopper can claim the coupon. |
^^^end_time |int |1709654340 |The UNIX timestamp, in seconds, after which a shopper can no longer claim the coupon. |
^^redemption_duration |object | |Period during which the coupon can be redeemed (i.e. applied to an order). |
^^^type |string |ABSOLUTE |Values:

* `ABSOLUTE`: the redemption period starts from `start_time` and ends at `end_time`.
* `RELATIVE`: the redemption period starts from the time the coupon is claimed and lasts for `relative_time`. |
   ^^^start_time |int |1709754340 |The UNIX timestamp, in seconds, at which the redemption period starts, if `type == 'ABSOLUTE'`. |
   ^^^end_time |int |1709768000 |The UNIX timestamp, in seconds, at which the redemption period ends, if `type == 'ABSOLUTE'`. |
   ^^^relative_time |int |4 |The number of days after coupon claim time for which a coupon is valid to be redeemed, `type = 'RELATIVE'`. |
   ^^display_channels |[]string |["SHOPPING_CENTER"]

|The channels in which the coupons can be displayed or distributed:

* `ALL`: All channels.
* `SHOPPING_CENTER`: Only in TikTok Shop shopping center.
* `CHAT`: Only in TT chat.
* `LIVE`: Only in TT live.
* `PRIVATE`: For promotion code. TikTok users won't know the codes until you show them.
* `PRIVATE_WITH_ALLOW`: A private display-channel value returned for a regular coupon.
* `VIDEO`: Only in short videos.
* `SHOWCASE`: Only in showcases. |
   ^^promo_code |string |TTS12345 |Promotion code. Returned only when `display_type == 'PROMO_CODE'`. The string contains only Unicode letters or digits. The length of the string is in the range of `[6, 12]`. |
   ^^target_buyer_segment |string |NEW
   |The target buyer segment of the coupon. Possible enumerations are:
* `ALL`: May be discovered and claimed by all TTS buyers.
* `NEW`:Customers who have never purchased from your shop.
* `REPEAT_CUSTOMERS`: People who have previously placed orders in your shop and made another purchase within certain days(30 days for non-US and 90 days for US).
* `RECENT_CUSTOMERS`: People who have made their first purchase in your shop in the past certain days(30 days for non-US and 90 days for US).
* `FREQUENT_CUSTOMERS`: Customers with more than 1 purchase within the last 90 days.
* `LAPSED_CUSTOMERS`: Customers with at least 1 purchase in the past 365 days but no purchases within the last certain days(90 days for non-US and 30 days for US).
* `NEW_FOLLOWERS`: People who started following the TikTok account of your shop in the past 30 days.
* `EXISTING_ACTIVE_FOLLOWERS`: People who followed the TikTok account of your shop and engaged with your shop through LIVE, short videos or product cards in the past 30 days.
   |
   ^^usage_limits |object | |Limitations for the use of the coupons. |
   ^^^single_buyer_claim_limit |int |30 |The number of times a single buyer can claim the coupon. |
   ^^^total_claim_limit |int |1000 |The total number of claims allowed for the coupon across all buyers. |
   ^^^redemption_limit |int |1000 |The number of times that a claimed coupon can be redeemed across all buyers. (Only available in ID, MY, PH, TH, SG, VN regions.) |
   ^^usage_stats |object | |Usage statistics |
   ^^^claimed_count |int |5 |The number of times that the coupon has been claimed. |
   ^^^redeemed_count |int |0 |The number of times that a coupon has been redeemed (i.e. applied to an order). |
   ^^discount |object | |The coupon discount configuration, including type, reduction_amount, percentage, and max_discount. |
   ^^^type |string |AMOUNT_OFF |The type of discount offered by the coupon. Possible enumerations are:
* `AMOUNT_OFF`: Reduces the final price of the item by the specified `reduction_amount`
* `PERCENT_OFF`: Reduces the final price by the specified `percentage`. |
   ^^^reduction_amount |object | |Will appear when `type == 'AMOUNT_OFF'`. |
   ^^^^amount |string |30.5 |Monetary value of an `AMOUNT_OFF` discount. |
   ^^^^currency |string |USD |Currency of the discount amount. |
   ^^^percentage |string |30 |The discount offered by the coupon, in percentage points. Will appear when `type == 'PERCENT_OFF'`. |
   ^^^max_discount |object | |Optional monetary upper limit of the total discount amount when `type == "PERCENT_OFF"`. |
   ^^^^amount |string |40 |Monetary value of the `max_discount`. |
   ^^^^currency |string |USD |Currency of the `max_discount`. |
   ^^threshold |object | |Optional minimum purchase criteria that must be met in order to receive the coupon's discount. |
   ^^^type |string |MIN_SPEND |The type of purchase criteria. Possible enumerations are:
* `NONE`: No minimum purchase criteria.
* `MIN_SPEND`: Buyer must meet or exceed the minimum spend criteria with eligible products. |
   ^^^min_spend |object |MIN_SPEND |When `threshold.type == 'MIN_SPEND'`, a customer must purchase products from the range defined by `product_scope` with a monetary amount greater than or equal to this value, or the customer cannot use the coupon. |
   ^^^^amount |string |30 |Monetary value of the `min_spend`. |
   ^^^^currency |string |USD |Currency of the `min_spend` threshold. |
   ^^product_scope |string |FULL_SHOP |The range of the products which the coupon applies to. The possible enumerations are:
* `FULL_SHOP`: All products sold in the shop are eligible for the coupon.
* `SPECIFIC_PRODUCTS`: Only specified products are eligible for the coupon. The list of specified products are returned in the response of the `get_coupon` API. |
   ^^product_ids |[]string |["1729581162206365900"] |The IDs of the eligible products when `product_scope == 'SPECIFIC_PRODUCTS'`. |
   ^^seller_tnc |string |terms & conditions: xxx |Custom terms & conditions optionally uploaded by the seller when configuring the coupon. |
   ^^creation_source |string |SELLER_CENTER |The system where the coupon is created:
* `SELLER_CENTER`: Created via the Promotions section of TikTok Seller Center.
* `SELLER_APP`: Created via the TikTok Seller Mobile App.
* `TTS_CRM`: Created via the TikTok Shop CRM. |
   ^^live_tasks |[]object | |The tasks which the shopper must fulfill before claiming the coupon distributed in TikTok live. Only exists for LIVE coupons in the US and the UK. |
   ^^^type |string |FOLLOW_HOST |Possible enumerations:
* `NONE`: Any shopper in the LIVE room may claim the coupon.
* `FOLLOW_HOST`: Shoppers must follow the LIVE host before being able to claim the coupon.
* `WATCH_FOR_MIN_TIME`: Shoppers must watch the LIVE for the time specified by `min_watch_time` before being able to claim the coupon. |
   ^^^min_watch_time |string |60 |Number of seconds for which the shopper must watch the LIVE in order to claim the coupon. |

### Response Sample
```json
{"code":0,"data":{"coupon":{"id":"7342461823095965461","title":"Coupon202407","display_type":"CHAT\n\n\n","status":"NOT_START\n\n\n\n","create_time":1661756811000,"update_time":1661756811000,"claim_duration":{"start_time":1709568000,"end_time":1709654340},"redemption_duration":{"type":"ABSOLUTE","start_time":1709754340,"end_time":1709768000,"relative_time":4},"display_channels":["SHOPPING_CENTER"],"promo_code":"TTS12345","target_buyer_segment":"NEW\n","usage_limits":{"single_buyer_claim_limit":30,"total_claim_limit":1000,"redemption_limit":1000},"usage_stats":{"claimed_count":5,"redeemed_count":0},"discount":{"type":"AMOUNT_OFF","reduction_amount":{"amount":"30.5","currency":"USD"},"percentage":"30","max_discount":{"amount":"40","currency":"USD"}},"threshold":{"type":"MIN_SPEND","min_spend":{"amount":"30","currency":"USD"}},"product_scope":"FULL_SHOP","product_ids":["1729581162206365900"],"seller_tnc":"terms \u0026 conditions: xxx","creation_source":"SELLER_CENTER","live_tasks":[{"type":"FOLLOW_HOST","min_watch_time":"60"}]}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Search Coupon List — `POST /promotion/202406/coupons/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-coupon-list-202406 · cập nhật 2026-10-28 · scope: seller.promotion.info, seller.customer_service

### Path: /promotion/202406/coupons/search
### Method: [POST]
### Function Description
Use this API to search coupons. Supported coupon creation sources include TikTok Shop Seller Center, the TikTok Seller App, and TikTok Shop CRM. Different supplied filters are combined with AND. Within status or display_type, multiple values are combined with OR. title_keyword performs phrase-prefix matching against the coupon title. For full details about a specific coupon, use the Get Coupon API.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| page_token | string | N | 1661756811000 | Page cursor. Omitting this parameter will return the first page of results. |
| page_size | int | N | 20 | The number of coupons returned in one page of results. The range is `[1, 100]`, with a default value of `50`. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| status | []string | N | ["ONGOING"] | Coupon's promotion status. |
| Values: |  |  |  |  |

* `NOT_START`: Not available to TikTok users until the coupon's configured start time.
* `ONGOING`: Available to TikTok users.
* `EXPIRED`: Not available to TikTok users because it has expired.
* `DEACTIVATED`: Deactivated by the seller and is not available to TikTok users. |
   title_keyword |string |N |Coupon123 |Keywords in coupon titles to search for. The UTF-8 byte length must be from 1 to 100. Fuzzy matching is not supported. |
   display_type |[]string |N |["CHAT"] |The display type of coupons.
   Values:
* `REGULAR`: Regular coupons which are displayed to TikTok users across all display locations available in TTS, including PLPs, PDPs, TikTok Videos, LIVE Rooms, Creator Showcases, and may be shared via TTS Customer Support instant messages. Includes coupons which target select customer segments.
* `LIVE`: Coupons which are only displayed to TikTok users in LIVE Rooms.
* `CREATOR_EXCLUSIVE`: Coupons that can be claimed through the display channels of the specified creator, such as their LIVE Rooms, and their Creator Showcase.
* `CHAT`: Exclusive coupons that may be sent to customers via TTS customer support chat messages, but are not displayed in other display locations.
* `PROMO_CODE`: Promo codes do not have dedicated display locations on TikTok, but may be shared with customers in LIVEs, in TikTok videos, or other social media platforms. They can be claimed by customers entering a claim code at checkout or by customers that use a custom promo code landing page URL. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/promotion/202406/coupons/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_token=1661756811000&page_size=20
```

**Body**
```json
{"status":["ONGOING"],"title_keyword":"Coupon123","display_type":["CHAT"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^total_count | int | 20 | Total number of coupon records matching the supplied filters. This value can be greater than the number of entries in coupons. |
| ^next_page_token | string | 1661756811000 | Cursor for the next page. If this field is present and non-empty, pass its value as `page_token` in the next request. Stop pagination when this field is absent or empty. |
| ^coupons | []object |  | The list of coupons matching the search criteria. |
| ^^id | string | 7342461823095965461 | A unique ID that identifies different coupons. |
| ^^title | string | Coupon202407 | Seller-specified title of the coupon. |
| ^^display_type | string | CHAT |  |
|The display type of coupons.
Values:

* `REGULAR`: Regular coupons which are displayed to TikTok users across all display locations available in TTS, including PLPs, PDPs, TikTok Videos, LIVE Rooms, Creator Showcases, and may be shared via TTS Customer Support instant messages. Includes coupons which target select customer segments.
* `LIVE`: Coupons which are only displayed to TikTok users in LIVE Rooms.
* `CREATOR_EXCLUSIVE`: Coupons that can be claimed through the display channels of the specified creator, such as their LIVE Rooms, and their Creator Showcase.
* `CHAT`: Exclusive coupons that may be sent to customers via TTS customer support chat messages, but are not displayed in other display locations.
* `PROMO_CODE`: Promo codes do not have dedicated display locations on TikTok, but may be shared with customers in LIVEs, in TikTok videos, or other social media platforms. They can be claimed by customers entering a claim code at checkout or by customers that use a custom promo code landing page URL.

|
^^status |string |NOT_START
|Coupon's promotion status.
Values:

* `NOT_START`: Not available to TikTok users until the coupon's configured start time.
* `ONGOING`: Available to TikTok users.
* `EXPIRED`: Not available to TikTok users because it has expired.
* `DEACTIVATED`: Deactivated by the seller and is not available to TikTok users. |
   ^^create_time |int |1661756811000 |The Unix timestamp, in milliseconds, when the coupon was created. |
   ^^update_time |int |1661756811000 |The Unix timestamp, in milliseconds, when the coupon was last updated. |
   ^^claim_duration |object | |Claimable period of the coupon |
   ^^^start_time |int |1709568000 |The Unix timestamp, in seconds, from which a shopper can claim the coupon. |
   ^^^end_time |int |1709654340 |The Unix timestamp, in seconds, after which a shopper can no longer claim the coupon. |
   ^^redemption_duration |object | |Period during which the coupon can be redeemed (i.e. applied to an order). |
   ^^^type |string |ABSOLUTE |Values:
* `ABSOLUTE`: the redemption period starts from `start_time` and ends at `end_time`.
* `RELATIVE`: the redemption period starts from the time the coupon is claimed and lasts for `relative_time`. |
   ^^^start_time |int |1709654340 |The Unix timestamp, in seconds, at which the redemption period starts when `type == 'ABSOLUTE'`. |
   ^^^end_time |int |1709754340 |The Unix timestamp, in seconds, at which the redemption period ends when `type == 'ABSOLUTE'`. |
   ^^^relative_time |int |4 |The number of days after coupon claim time for which a coupon is valid to be redeemed, `type = 'RELATIVE'`. |
   ^^promo_code |string |TTS12345 |Promotion code. Returned only when `display_type == 'PROMO_CODE'`. The string contains only Unicode letters or digits. The length of the string is in the range of `[6, 12]`. |
   ^^target_buyer_segment |string |NEW
   |The target buyer segment of the coupon. Possible enumerations are:
* `ALL`: May be discovered and claimed by all TTS buyers.
* `NEW`:Customers who have never purchased from your shop.
* `REPEAT_CUSTOMERS`: People who have previously placed orders in your shop and made another purchase within certain days(30 days for non-US and 90 days for US).
* `RECENT_CUSTOMERS`: People who have made their first purchase in your shop in the past certain days(30 days for non-US and 90 days for US).
* `FREQUENT_CUSTOMERS`: Customers with more than 1 purchase within the last 90 days.
* `LAPSED_CUSTOMERS`: Customers with at least 1 purchase in the past 365 days but no purchases within the last certain days(90 days for non-US and 30 days for US).
* `NEW_FOLLOWERS`: People who started following the TikTok account of your shop in the past 30 days.
* `EXISTING_ACTIVE_FOLLOWERS`: People who followed the TikTok account of your shop and engaged with your shop through LIVE, short videos or product cards in the past 30 days.
   |
   ^^usage_limits |object | |Limitations for the use of the coupons. |
   ^^^single_buyer_claim_limit |int |30 |The number of times a single buyer can claim the coupon. |
   ^^^total_claim_limit |int |1000 |The total number of claims allowed for the coupon across all buyers. |
   ^^^redemption_limit |int |1000 |The number of times that a claimed coupon can be redeemed across all buyers. (Only available in ID, MY, PH, TH, SG, VN regions.) |
   ^^discount |object | |The coupon discount configuration, including type, reduction_amount, percentage, and max_discount. |
   ^^^type |string |AMOUNT_OFF |The type of discount offered by the coupon. Possible enumerations are:
* `AMOUNT_OFF`: Reduces the final price of the item by the specified `reduction_amount`
* `PERCENT_OFF`: Reduces the final price by the specified `percentage`. |
   ^^^reduction_amount |object | |Will appear when `type == 'AMOUNT_OFF'`. |
   ^^^^amount |string |30.5 |Monetary value of an `AMOUNT_OFF` discount. |
   ^^^^currency |string |USD |Currency of the discount amount. |
   ^^^percentage |string |30 |The discount offered by the coupon, in percentage points. Will appear when `type == 'PERCENT_OFF'`. |
   ^^^max_discount |object | |Optional monetary upper limit of the total discount amount when `type == "PERCENT_OFF"`. |
   ^^^^amount |string |40 |Monetary value of the `max_discount`. |
   ^^^^currency |string |USD |Currency of the `max_discount`. |
   ^^threshold |object | |Optional minimum purchase criteria that must be met in order to receive the coupon's discount. |
   ^^^type |string |MIN_SPEND |The type of purchase criteria. Possible enumerations are:
* `NONE`: No minimum purchase criteria.
* `MIN_SPEND`: Buyer must meet or exceed the minimum spend criteria with eligible products. |
   ^^^min_spend |object | |When `threshold.type == 'MIN_SPEND'`, a customer must purchase products from the range defined by `product_scope` with a monetary amount greater than or equal to this value, or the customer cannot use the coupon. |
   ^^^^amount |string |30 |Monetary value of the `min_spend`. |
   ^^^^currency |string |USD |Currency of the `min_spend` threshold. |
   ^^product_scope |string |FULL_SHOP |The range of the products which the coupon applies to. The possible enumerations are:
* `FULL_SHOP`: All products sold in the shop are eligible for the coupon.
* `SPECIFIC_PRODUCTS`: Only specified products are eligible for the coupon. The list of specified products are returned in the response of the `get_coupon` API. |
   ^^creation_source |string |SELLER_CENTER |The system where the coupon is created:
* `SELLER_CENTER`: Created via the Promotions section of TikTok Seller Center.
* `SELLER_APP`: Created via the TikTok Seller Mobile App.
* `TTS_CRM`: Created via the TikTok Shop CRM. |

### Response Sample
```json
{"code":0,"data":{"total_count":20,"next_page_token":"1661756811000","coupons":[{"id":"7342461823095965461","title":"Coupon202407","display_type":"CHAT\n\n\n","status":"NOT_START\n\n\n\n","create_time":1661756811000,"update_time":1661756811000,"claim_duration":{"start_time":1709568000,"end_time":1709654340},"redemption_duration":{"type":"ABSOLUTE","start_time":1709654340,"end_time":1709754340,"relative_time":4},"promo_code":"TTS12345","target_buyer_segment":"NEW\n","usage_limits":{"single_buyer_claim_limit":30,"total_claim_limit":1000,"redemption_limit":1000},"discount":{"type":"AMOUNT_OFF","reduction_amount":{"amount":"30.5","currency":"USD"},"percentage":"30","max_discount":{"amount":"40","currency":"USD"}},"threshold":{"type":"MIN_SPEND","min_spend":{"amount":"30","currency":"USD"}},"product_scope":"FULL_SHOP","creation_source":"SELLER_CENTER"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Republish Activity — `POST /promotion/202607/activities/{activity_id}/republish`

Doc: https://partner.tiktokshop.com/docv2/page/republish-activity-202607 · cập nhật 2026-10-10 · scope: seller.promotion.write

### Path: /promotion/202607/activities/{activity_id}/republish
### Method: [POST]
### Function Description
Use this API to republish a product discount activity or a flash deal activity that expired or was deactivated within the last 7 days. This API only supports FIXED_PRICE, FLASHSALE, and DIRECT_DISCOUNT activities. You must provide a new effective period by passing the new begin_time and end_time. Products and SKUs already associated with the activity do not need to be added again. After the activity is republished, you can edit the activity and modify its products or SKUs as usual. We recommend using this API instead of recreating the activity to reduce requests to the API for adding products.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| activity_id | string | Y | 7657162458772768530 | A unique ID that identifies different activities. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| end_time | int | N | 1782895064 | Activity end time as a Unix timestamp in seconds. It must be later than begin_time, and the effective period must be at least 10 minutes. The maximum period depends on the activity type and shop region; for FLASHSALE activities, it must not exceed 3 days. |
| begin_time | int | N | 1782875064 | Activity start time as a Unix timestamp in seconds. The value must be later than the current time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/promotion/202607/activities/7657162458772768530/republish?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"end_time":1782895064,"begin_time":1782875064}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^activity_id | string | 7136104329798256386 | On success, the ID of the republished activity. This is the same activity_id supplied in the request path; republishing does not create a new activity. Use this ID for subsequent activity, product, or SKU edits. |
### Response Sample
```json
{"code":0,"data":{"activity_id":"7136104329798256386"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 17003243 | This activity don't allow republishing |

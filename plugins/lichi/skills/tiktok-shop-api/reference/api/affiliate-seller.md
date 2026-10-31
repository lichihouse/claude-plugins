# Affiliate seller — tài liệu chi tiết

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.




---

## Affiliate Seller API overview

Doc: https://partner.tiktokshop.com/docv2/page/affiliate-seller-api-overview · cập nhật 2026-09-21

📌 <b>Note</b>: Affiliate APIs are currently <b>not</b> available in the <b>UK</b> and <b>EU</b> markets.

An app can only use API scopes available for its own category. To use an Affiliate API, open that API’s documentation page and click <b>View app categories</b> at the bottom to check which categories support your registration region and target market. Then create an app under a supported category. If no results are shown, that API is not yet available for the selected region or market.

### Context
Development partners can integrate with the TikTok Shop Affiliate APIs to help TikTok Shop stakeholders create, manage, matchmake, track, monetize, and collaborate across TikTok Shop Affiliate Collaborations and Partner Campaigns. Listing an Affiliate API integrated app within the TikTok Shop App Store offers development partners numerous advantages:

* **Support for Existing Customers**: Satisfy and support your existing customers who are already on TikTok Shop or will be joining soon.
* **Increased Exposure**: Gain visibility among TikTok Shop sellers looking for affiliate solutions within the app store.
* **Marketing Opportunities**: Benefit from inclusion in marketing initiatives related to the TikTok Shop App Store.
* **Competitive Differentiation**: Stand out from competitors that are not integrated with TikTok Shop.
* **Enhanced Revenue Generation**: Provide a down-funnel, measurable solution that focuses on performance and revenue generation, beyond just top-of-funnel awareness and engagement marketing.

---

#### Types of Affiliate APIs
There are 3 types of APIs available for affiliate management:

* **Affiliate Seller API**: Help sellers maximize product visibility through open and target collaborations with TikTok Shop Creator Affiliates, facilitate seamless product promotion, and track the overall conversions from their affiliate marketing efforts.
* **Affiliate Creator API**: Help TikTok Shop Creator Affiliates manage their collaborations and product showcases on TikTok Shop, while also tracking the conversion from their marketing efforts.
* **Affiliate Partner API**: Help TikTok Affiliate Partners (TAPs) effectively manage campaigns that match-make sellers with TikTok Shop Creator Affiliates, optimizing product promotion for sellers while offering enhanced monetization opportunities for TikTok Shop Creator Affiliates.

Development partners can use a combination of these APIs to:

* Enroll seller's catalog into open collaboration
* Create open collaboration
* Create target collaboration
* Create partner campaign
* Help sellers find creators
* and more...

---

### Important Concepts
#### TikTok Shop Affiliate Program
The TikTok Shop Affiliate Program consists of **Affiliate Collaborations** and **Affiliate Partner Campaigns**, both of which allow sellers and TikTok Shop Creator Affiliates to collaborate and build the next era of social commerce based on engaging shoppable content on TikTok. 

* **TikTok Shop Creator Affiliates** are creators that are eligible to sell e-commerce products on TikTok Shop. To be eligible, creators need to fulfil these requirements:
   * Registered in the US, UK, and SEA
   * US: 1K+ followers
   * UK, SEA: 5K+ followers
   * 18+ years old
   * No more than 3 violations on their account

 Creators can apply to be included in the affiliate program [here](https://business.tiktokshop.com/us/creator/).
(Henceforth, TikTok Shop Creator Affiliates will be generally referred to as creators.)

📌 <b>Note</b>: Currently there is no way for external partners to facilitate or moderate creator onboarding programmatically. We will improve upon this in a future iteration, but for now, you can check whether a creator is a TikTok Shop Creator Affiliate in 2 ways:

* The Creator has a "Showcase" icon on their profile
* The Creator is able to successfully authorize the partner

Note that TikTok Shop Creator Authorization is currently separate from TikTok for Business or TikTok for Developers.
 

* **Shoppable content** in the context of TikTok Shop refers to engaging TikTok videos created by creators, where they tag seller products within the videos and embed native anchor links that allow the end-user to directly shop on the creator's content. Key characteristics of e-commerce based on shoppable content:
   * Unlike traditional e-commerce affiliates (links, coupon codes, social media redirects), this type of content eliminates issues with attribution and cookie durations since users engage and purchase without navigating away from the app.
   * It enables straightforward and performance-based monetization, eliminating ambiguities often found in traditional marketing approaches. Creators earn a commission (determined by the seller) on the purchases they directly drive (no view attribution), while sellers receive the remaining payout from the sales after taxes and fees.

(ảnh: data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB2ZXJzaW9uPSIxLjEiIHdpZHRoPSI1NzNweCIgaGVpZ2h0PSIxNjJweCIgdmlld0JveD0iLTAuNSAtMC41IDU3MyAxNjIiPjxkZWZzLz48Zz48cmVjdCB4PSIyIiB5PSI0NyIgd2lkdGg9IjYwIiBoZWlnaHQ9IjYwIiByeD0iOSIgcnk9IjkiIGZpbGw9IiNmZmZmZmYiIHN0cm9rZT0iIzAwMDAwMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSkiPjxmb3JlaWduT2JqZWN0IHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiIHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIj48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDU4cHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogNzdweDsgbWFyZ2luLWxlZnQ6IDNweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMnB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgd2hpdGUtc3BhY2U6IG5vcm1hbDsgd29yZC13cmFwOiBub3JtYWw7ICI+VGlrVG9rIFNob3A8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjxlbGxpcHNlIGN4PSI1NTQuODEiIGN5PSIxMTIuNjMiIHJ4PSI3LjUiIHJ5PSI1LjYyNSIgZmlsbD0iI2ZmZmZmZiIgc3Ryb2tlPSIjMDAwMDAwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PHBhdGggZD0iTSA1NTQuODEgMTE4LjI1IEwgNTU0LjgxIDEzNyBNIDU1NC44MSAxMjIgTCA1MzkuODEgMTIyIE0gNTU0LjgxIDEyMiBMIDU2OS44MSAxMjIgTSA1NTQuODEgMTM3IEwgNTM5LjgxIDE1MiBNIDU1NC44MSAxMzcgTCA1NjkuODEgMTUyIiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSkiPjxmb3JlaWduT2JqZWN0IHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiIHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIj48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBmbGV4LXN0YXJ0OyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMTU5cHg7IG1hcmdpbi1sZWZ0OiA1NTVweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMnB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgYmFja2dyb3VuZC1jb2xvcjogI2ZmZmZmZjsgd2hpdGUtc3BhY2U6IG5vd3JhcDsgIj5TZWxsZXI8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjxwYXRoIGQ9Ik0gMzMwIDc3IEwgMzUyIDc3IEwgMzUyIDEyOCBMIDUzMy40NCAxMjgiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0ic3Ryb2tlIi8+PHBhdGggZD0iTSA1MzguNjkgMTI4IEwgNTMxLjY5IDEzMS41IEwgNTMzLjQ0IDEyOCBMIDUzMS42OSAxMjQuNSBaIiBmaWxsPSIjMDAwMDAwIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSkiPjxmb3JlaWduT2JqZWN0IHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiIHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIj48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDFweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiAxMjlweDsgbWFyZ2luLWxlZnQ6IDQ1M3B4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyBiYWNrZ3JvdW5kLWNvbG9yOiAjZmZmZmZmOyBib3JkZXI6IDFweCBzb2xpZCAjRkZGRkZGOyB3aGl0ZS1zcGFjZTogbm93cmFwOyAiPjYwJSBwcm9maXQ6ICQ2MDwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48L2c+PHBhdGggZD0iTSAyMzIgNzcgTCA2OC4zNyA3NyIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJzdHJva2UiLz48cGF0aCBkPSJNIDYzLjEyIDc3IEwgNzAuMTIgNzMuNSBMIDY4LjM3IDc3IEwgNzAuMTIgODAuNSBaIiBmaWxsPSIjMDAwMDAwIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSkiPjxmb3JlaWduT2JqZWN0IHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiIHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIj48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDFweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiA3OHB4OyBtYXJnaW4tbGVmdDogMTUzcHg7Ij48ZGl2IHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBmb250LXNpemU6IDA7IHRleHQtYWxpZ246IGNlbnRlcjsgIj48ZGl2IHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IGZvbnQtc2l6ZTogMTJweDsgZm9udC1mYW1pbHk6IEhlbHZldGljYTsgY29sb3I6ICMwMDAwMDA7IGxpbmUtaGVpZ2h0OiAxLjI7IHBvaW50ZXItZXZlbnRzOiBhbGw7IGJhY2tncm91bmQtY29sb3I6ICNmZmZmZmY7IHdoaXRlLXNwYWNlOiBub3dyYXA7ICI+MTAlIHBsYXRmb3JtIGZlZTogJDEwPC9kaXY+PC9kaXY+PC9kaXY+PC9mb3JlaWduT2JqZWN0PjwvZz48cGF0aCBkPSJNIDMzMCA3NyBMIDM1MiA3NyBMIDM1MiAyOCBMIDUzMy40NCAyOCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJzdHJva2UiLz48cGF0aCBkPSJNIDUzOC42OSAyOCBMIDUzMS42OSAzMS41IEwgNTMzLjQ0IDI4IEwgNTMxLjY5IDI0LjUgWiIgZmlsbD0iIzAwMDAwMCIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgY2VudGVyOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMjhweDsgbWFyZ2luLWxlZnQ6IDQ0MnB4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyBiYWNrZ3JvdW5kLWNvbG9yOiAjZmZmZmZmOyB3aGl0ZS1zcGFjZTogbm93cmFwOyAiPjMwJSBjb21taXNzaW9uIHJhdGU6ICQzMDwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48L2c+PHBhdGggZD0iTSAyNjIgNDcgTCAzMDAgNDcgQyAzMTYuNTcgNDcgMzMwIDYwLjQzIDMzMCA3NyBDIDMzMCA5My41NyAzMTYuNTcgMTA3IDMwMCAxMDcgTCAyNjIgMTA3IEMgMjQ1LjQzIDEwNyAyMzIgOTMuNTcgMjMyIDc3IEMgMjMyIDYwLjQzIDI0NS40MyA0NyAyNjIgNDcgWiIgZmlsbD0iI2ZmZmZmZiIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgY2VudGVyOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiA5NnB4OyBoZWlnaHQ6IDFweDsgcGFkZGluZy10b3A6IDc3cHg7IG1hcmdpbi1sZWZ0OiAyMzNweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMnB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgd2hpdGUtc3BhY2U6IG5vcm1hbDsgd29yZC13cmFwOiBub3JtYWw7ICI+UHJvZHVjdCBzYWxlczxiciAvPiQxMDA8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjxlbGxpcHNlIGN4PSI1NTQuODEiIGN5PSI3LjYzIiByeD0iNy41IiByeT0iNS42MjUiIGZpbGw9IiNmZmZmZmYiIHN0cm9rZT0iIzAwMDAwMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxwYXRoIGQ9Ik0gNTU0LjgxIDEzLjI1IEwgNTU0LjgxIDMyIE0gNTU0LjgxIDE3IEwgNTM5LjgxIDE3IE0gNTU0LjgxIDE3IEwgNTY5LjgxIDE3IE0gNTU0LjgxIDMyIEwgNTM5LjgxIDQ3IE0gNTU0LjgxIDMyIEwgNTY5LjgxIDQ3IiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSkiPjxmb3JlaWduT2JqZWN0IHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiIHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIj48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBmbGV4LXN0YXJ0OyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogNTRweDsgbWFyZ2luLWxlZnQ6IDU1NXB4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyBiYWNrZ3JvdW5kLWNvbG9yOiAjZmZmZmZmOyB3aGl0ZS1zcGFjZTogbm93cmFwOyAiPkNyZWF0b3I8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjwvZz48L3N2Zz4=)$100&quot;,&quot;style&quot;:&quot;shape=mxgraph.flowchart.terminator;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#000000;strokeWidth=1;&quot;,&quot;parent&quot;:&quot;ssQVTA1O&quot;,&quot;vertex&quot;:&quot;1&quot;,&quot;diagramName&quot;:&quot;Terminator&quot;,&quot;diagramCategory&quot;:&quot;Flowchart&quot;,&quot;-0-mxGeometry&quot;:{&quot;x&quot;:&quot;360&quot;,&quot;y&quot;:&quot;369&quot;,&quot;width&quot;:&quot;98&quot;,&quot;height&quot;:&quot;60&quot;,&quot;as&quot;:&quot;geometry&quot;}},&quot;TGMTYoHJ&quot;:{&quot;id&quot;:&quot;TGMTYoHJ&quot;,&quot;value&quot;:&quot;Creator&quot;,&quot;style&quot;:&quot;shape=umlActor;verticalLabelPosition=bottom;labelBackgroundColor=#ffffff;verticalAlign=top;html=1;outlineConnect=0;&quot;,&quot;parent&quot;:&quot;ssQVTA1O&quot;,&quot;vertex&quot;:&quot;1&quot;,&quot;diagramName&quot;:&quot;Actor&quot;,&quot;diagramCategory&quot;:&quot;general&quot;,&quot;-0-mxGeometry&quot;:{&quot;x&quot;:&quot;667.81&quot;,&quot;y&quot;:&quot;324&quot;,&quot;width&quot;:&quot;30&quot;,&quot;height&quot;:&quot;45&quot;,&quot;as&quot;:&quot;geometry&quot;}}},&quot;mxCellList&quot;:[&quot;sOKJ7z39&quot;,&quot;ssQVTA1O&quot;,&quot;IKfqWfbA&quot;,&quot;4Mp1k6CJ&quot;,&quot;7xHhiAtp&quot;,&quot;b93394G9&quot;,&quot;rNQ9dvt3&quot;,&quot;PyrRYTA8&quot;,&quot;NNO2WQYM&quot;,&quot;MIl0qA5k&quot;,&quot;WYbVFAjh&quot;,&quot;TGMTYoHJ&quot;]},&quot;lastEditTime&quot;:0,&quot;snapshot&quot;:&quot;&quot;}" />

💡<b>What this means for stakeholders?</b>

* **Buyers** (TikTok App users) gain exposure to products through trusted creators and enjoy a direct path to purchasing.
* **Sellers** benefit from engaging TikTok-style shoppable content via creators and a pay-for-performance model without significant upfront costs.
* **Creators** benefit from high potential for performance-based compensation and diverse collaboration opportunities with sellers to promote products.

 

---

#### Affiliate Collaborations
One of the most basic ways to monetize through affiliates is through direct affiliate collaborations between sellers and creators. There are 2 kinds of collaboration modes in the TikTok Shop Affiliate program:

* **Open Collaboration**
   An Open Collaboration refers to a collaboration model where a seller enrolls products into an Open Plan, making the **products available for all TikTok Shop Creator Affilitates** to see on the Creator Marketplace. 
   You can think of an Open Collaboration as a club which is open to creators, the only requirement being that the creator has registered and is approved to be a TikTok Shop Creator Affiliate.
   In some cases, sellers can require approval on an Open Collaboration. This means the Open Collaboration is visible to creators but they must apply and pass seller approval to participate. You can think of this as a club bouncer giving partygoers a quick vibe check. 

* **Target Collaboration**
   A Target Collaboration refers to a collaboration model where a seller enrolls products into a Target Plan, making the **products available only to TikTok Shop Creator Affilitates that are explicitly invited** by the seller. 
   You can think of a Target Collaboration as a club which is invite only. Creators can only get into the club if they are invited by the seller. Once inside, creators must abide by the club's rules and can be removed at anytime. 
   Target Collaborations are a great way for sellers to find creators that suit the seller's unique voice on TikTok, and typically involve creators who have proven themselves through historical performance or possess a strong content portfolio, often carrying higher commission rates.

💡<b>What this means for stakeholders?</b>
Development Partners can leverage from these collaborations by potentially charging a SaaS fee to sellers or creators, or by taking a cut of the matchmaking efforts outside of the TikTok Shop platform directly with the seller or creator.
 

---

#### Affiliate Partner Campaigns
Affiliate Partner Campaigns refers to a collaboration model where TikTok Affiliate Partners (TAPs) help sellers and creators matchmake more efficiently. This model is very similar to sub-affiliates in the traditional affiliate marketing space, with TAPs acting as sub-affiliates, referring the best-fit creators to sellers. 
Continuing off the analogy above regarding clubs, you can think of a TAP as a club promoter - someone who knows which club is best for whom. Club promoters have a pulse on the local club scene, including the age group, DJs, music genres, trends, and overall vibes. 
In the context of TikTok Shop, TAP can recommend viral TikTok trends, products, and help both sellers and creators succeed at creating content for the social commerce era. Some examples of TAP initiatives include creator monetization apps, creator or influencer marketing platforms, sub-affiliates etc. 

The nature of Affiliate Partner Campaigns differs slightly based on the region.

* **US/EMEA**: One(TAP)-to-one(seller) campaigns are the norm. This is no different from an Open or Target Collaboration, except that the TAP facilitates the matchmaking process, thereby taking a cut off the commission. You can think of a TAP as a sub-affiliate network.

* **Rest of world**: One-to-many campaigns are the norm. TAPs often design campaigns that allow for collaboration with multiple TikTok Shop sellers and creators under one broader campaign initiative. These campaigns are geared towards TAPs supporting multiple brands at once, and provide flexibility in commission structures:
   * Enables third party commission sharing (payout to both TAP and creators upon sales)
   * Different customization levers around commissions

Despite the differences, commission sharing is a universal feature across all Affiliate Partner Campaigns. It is key to how TAPs monetize their efforts.

(ảnh: data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB2ZXJzaW9uPSIxLjEiIHdpZHRoPSI2NDVweCIgaGVpZ2h0PSIyNDlweCIgdmlld0JveD0iLTAuNSAtMC41IDY0NSAyNDkiPjxkZWZzLz48Zz48cmVjdCB4PSIyIiB5PSIxMzQiIHdpZHRoPSI2MCIgaGVpZ2h0PSI2MCIgcng9IjkiIHJ5PSI5IiBmaWxsPSIjZmZmZmZmIiBzdHJva2U9IiMwMDAwMDAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgY2VudGVyOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiA1OHB4OyBoZWlnaHQ6IDFweDsgcGFkZGluZy10b3A6IDE2NHB4OyBtYXJnaW4tbGVmdDogM3B4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3b3JkLXdyYXA6IG5vcm1hbDsgIj5UaWtUb2sgU2hvcDwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48L2c+PGVsbGlwc2UgY3g9IjYyNyIgY3k9IjE5OS42MyIgcng9IjcuNSIgcnk9IjUuNjI1IiBmaWxsPSIjZmZmZmZmIiBzdHJva2U9IiMwMDAwMDAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48cGF0aCBkPSJNIDYyNyAyMDUuMjUgTCA2MjcgMjI0IE0gNjI3IDIwOSBMIDYxMiAyMDkgTSA2MjcgMjA5IEwgNjQyIDIwOSBNIDYyNyAyMjQgTCA2MTIgMjM5IE0gNjI3IDIyNCBMIDY0MiAyMzkiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KSI+PGZvcmVpZ25PYmplY3Qgc3R5bGU9Im92ZXJmbG93OiB2aXNpYmxlOyB0ZXh0LWFsaWduOiBsZWZ0OyIgcG9pbnRlci1ldmVudHM9Im5vbmUiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGZsZXgtc3RhcnQ7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDFweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiAyNDZweDsgbWFyZ2luLWxlZnQ6IDYyN3B4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyBiYWNrZ3JvdW5kLWNvbG9yOiAjZmZmZmZmOyB3aGl0ZS1zcGFjZTogbm93cmFwOyAiPlNlbGxlcjwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48L2c+PHBhdGggZD0iTSAzMzAgMTY0IEwgMzUyIDE2NCBMIDM1MiAyMTUgTCA2MDUuNjMgMjE1IiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9InN0cm9rZSIvPjxwYXRoIGQ9Ik0gNjEwLjg4IDIxNSBMIDYwMy44OCAyMTguNSBMIDYwNS42MyAyMTUgTCA2MDMuODggMjExLjUgWiIgZmlsbD0iIzAwMDAwMCIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgY2VudGVyOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMjE2cHg7IG1hcmdpbi1sZWZ0OiA1MDJweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMnB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgYmFja2dyb3VuZC1jb2xvcjogI2ZmZmZmZjsgYm9yZGVyOiAxcHggc29saWQgI0ZGRkZGRjsgd2hpdGUtc3BhY2U6IG5vd3JhcDsgIj42MCUgcHJvZml0OiAkNjA8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjxwYXRoIGQ9Ik0gMjMyIDE2NCBMIDY4LjM3IDE2NCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJzdHJva2UiLz48cGF0aCBkPSJNIDYzLjEyIDE2NCBMIDcwLjEyIDE2MC41IEwgNjguMzcgMTY0IEwgNzAuMTIgMTY3LjUgWiIgZmlsbD0iIzAwMDAwMCIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgY2VudGVyOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMTY1cHg7IG1hcmdpbi1sZWZ0OiAxNTNweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMnB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgYmFja2dyb3VuZC1jb2xvcjogI2ZmZmZmZjsgd2hpdGUtc3BhY2U6IG5vd3JhcDsgIj4xMCUgcGxhdGZvcm0gZmVlOiAkMTA8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjxwYXRoIGQ9Ik0gMzMwIDE2NCBMIDM1MiAxNjQgTCAzNTIgNjkgTCAzMTYuODcgNjkiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0ic3Ryb2tlIi8+PHBhdGggZD0iTSAzMTEuNjIgNjkgTCAzMTguNjIgNjUuNSBMIDMxNi44NyA2OSBMIDMxOC42MiA3Mi41IFoiIGZpbGw9IiMwMDAwMDAiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PHBhdGggZD0iTSAyNjIgMTM0IEwgMzAwIDEzNCBDIDMxNi41NyAxMzQgMzMwIDE0Ny40MyAzMzAgMTY0IEMgMzMwIDE4MC41NyAzMTYuNTcgMTk0IDMwMCAxOTQgTCAyNjIgMTk0IEMgMjQ1LjQzIDE5NCAyMzIgMTgwLjU3IDIzMiAxNjQgQyAyMzIgMTQ3LjQzIDI0NS40MyAxMzQgMjYyIDEzNCBaIiBmaWxsPSIjZmZmZmZmIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSkiPjxmb3JlaWduT2JqZWN0IHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiIHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIj48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBjZW50ZXI7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDk2cHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMTY0cHg7IG1hcmdpbi1sZWZ0OiAyMzNweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMnB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgd2hpdGUtc3BhY2U6IG5vcm1hbDsgd29yZC13cmFwOiBub3JtYWw7ICI+UHJvZHVjdCBzYWxlczxiciAvPiQxMDA8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjxlbGxpcHNlIGN4PSI2MjciIGN5PSI5NC42MyIgcng9IjcuNSIgcnk9IjUuNjI1IiBmaWxsPSIjZmZmZmZmIiBzdHJva2U9IiMwMDAwMDAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48cGF0aCBkPSJNIDYyNyAxMDAuMjUgTCA2MjcgMTE5IE0gNjI3IDEwNCBMIDYxMiAxMDQgTSA2MjcgMTA0IEwgNjQyIDEwNCBNIDYyNyAxMTkgTCA2MTIgMTM0IE0gNjI3IDExOSBMIDY0MiAxMzQiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KSI+PGZvcmVpZ25PYmplY3Qgc3R5bGU9Im92ZXJmbG93OiB2aXNpYmxlOyB0ZXh0LWFsaWduOiBsZWZ0OyIgcG9pbnRlci1ldmVudHM9Im5vbmUiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGZsZXgtc3RhcnQ7IGp1c3RpZnktY29udGVudDogdW5zYWZlIGNlbnRlcjsgd2lkdGg6IDFweDsgaGVpZ2h0OiAxcHg7IHBhZGRpbmctdG9wOiAxNDFweDsgbWFyZ2luLWxlZnQ6IDYyN3B4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyBiYWNrZ3JvdW5kLWNvbG9yOiAjZmZmZmZmOyB3aGl0ZS1zcGFjZTogbm93cmFwOyAiPkNyZWF0b3I8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjxlbGxpcHNlIGN4PSI2MjciIGN5PSI3LjYzIiByeD0iNy41IiByeT0iNS42MjUiIGZpbGw9IiNmZmZmZmYiIHN0cm9rZT0iIzAwMDAwMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxwYXRoIGQ9Ik0gNjI3IDEzLjI1IEwgNjI3IDMyIE0gNjI3IDE3IEwgNjEyIDE3IE0gNjI3IDE3IEwgNjQyIDE3IE0gNjI3IDMyIEwgNjEyIDQ3IE0gNjI3IDMyIEwgNjQyIDQ3IiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9ImFsbCIvPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0wLjUgLTAuNSkiPjxmb3JlaWduT2JqZWN0IHN0eWxlPSJvdmVyZmxvdzogdmlzaWJsZTsgdGV4dC1hbGlnbjogbGVmdDsiIHBvaW50ZXItZXZlbnRzPSJub25lIiB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIj48ZGl2IHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sIiBzdHlsZT0iZGlzcGxheTogZmxleDsgYWxpZ24taXRlbXM6IHVuc2FmZSBmbGV4LXN0YXJ0OyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogNTRweDsgbWFyZ2luLWxlZnQ6IDYyN3B4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyBiYWNrZ3JvdW5kLWNvbG9yOiAjZmZmZmZmOyB3aGl0ZS1zcGFjZTogbm93cmFwOyAiPlRBUDwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48L2c+PHBhdGggZD0iTSA0MTguNSA2OSBMIDQ1MiA2OSBMIDQ1MiAyNSBMIDYwNS42MyAyNSIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJzdHJva2UiLz48cGF0aCBkPSJNIDYxMC44OCAyNSBMIDYwMy44OCAyOC41IEwgNjA1LjYzIDI1IEwgNjAzLjg4IDIxLjUgWiIgZmlsbD0iIzAwMDAwMCIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgY2VudGVyOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMjVweDsgbWFyZ2luLWxlZnQ6IDUzOHB4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyBiYWNrZ3JvdW5kLWNvbG9yOiAjZmZmZmZmOyB3aGl0ZS1zcGFjZTogbm93cmFwOyAiPjUwJSBjdXQ6ICQxNTwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48L2c+PHBhdGggZD0iTSA0MTguNSA2OSBMIDQ1MiA2OSBMIDQ1MiAxMTIgTCA2MDUuNjMgMTEyIiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS1taXRlcmxpbWl0PSIxMCIgcG9pbnRlci1ldmVudHM9InN0cm9rZSIvPjxwYXRoIGQ9Ik0gNjEwLjg4IDExMiBMIDYwMy44OCAxMTUuNSBMIDYwNS42MyAxMTIgTCA2MDMuODggMTA4LjUgWiIgZmlsbD0iIzAwMDAwMCIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHBvaW50ZXItZXZlbnRzPSJhbGwiLz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMC41IC0wLjUpIj48Zm9yZWlnbk9iamVjdCBzdHlsZT0ib3ZlcmZsb3c6IHZpc2libGU7IHRleHQtYWxpZ246IGxlZnQ7IiBwb2ludGVyLWV2ZW50cz0ibm9uZSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSI+PGRpdiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgc3R5bGU9ImRpc3BsYXk6IGZsZXg7IGFsaWduLWl0ZW1zOiB1bnNhZmUgY2VudGVyOyBqdXN0aWZ5LWNvbnRlbnQ6IHVuc2FmZSBjZW50ZXI7IHdpZHRoOiAxcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogMTE0cHg7IG1hcmdpbi1sZWZ0OiA1MzdweDsiPjxkaXYgc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1ib3g7IGZvbnQtc2l6ZTogMDsgdGV4dC1hbGlnbjogY2VudGVyOyAiPjxkaXYgc3R5bGU9ImRpc3BsYXk6IGlubGluZS1ibG9jazsgZm9udC1zaXplOiAxMnB4OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBjb2xvcjogIzAwMDAwMDsgbGluZS1oZWlnaHQ6IDEuMjsgcG9pbnRlci1ldmVudHM6IGFsbDsgYmFja2dyb3VuZC1jb2xvcjogI2ZmZmZmZjsgd2hpdGUtc3BhY2U6IG5vd3JhcDsgIj41MCUgY3V0OiAkMTU8L2Rpdj48L2Rpdj48L2Rpdj48L2ZvcmVpZ25PYmplY3Q+PC9nPjxwYXRoIGQ9Ik0gMjk3IDg5IEwgMzI0IDQ5IEwgNDMyIDQ5IEwgNDA1IDg5IFoiIGZpbGw9IiNlNmU2ZTYiIHN0cm9rZT0iIzgwODA4MCIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBwb2ludGVyLWV2ZW50cz0iYWxsIi8+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTAuNSAtMC41KSI+PGZvcmVpZ25PYmplY3Qgc3R5bGU9Im92ZXJmbG93OiB2aXNpYmxlOyB0ZXh0LWFsaWduOiBsZWZ0OyIgcG9pbnRlci1ldmVudHM9Im5vbmUiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkaXYgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiIHN0eWxlPSJkaXNwbGF5OiBmbGV4OyBhbGlnbi1pdGVtczogdW5zYWZlIGNlbnRlcjsganVzdGlmeS1jb250ZW50OiB1bnNhZmUgY2VudGVyOyB3aWR0aDogMTMzcHg7IGhlaWdodDogMXB4OyBwYWRkaW5nLXRvcDogNjlweDsgbWFyZ2luLWxlZnQ6IDI5OHB4OyI+PGRpdiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgZm9udC1zaXplOiAwOyB0ZXh0LWFsaWduOiBjZW50ZXI7ICI+PGRpdiBzdHlsZT0iZGlzcGxheTogaW5saW5lLWJsb2NrOyBmb250LXNpemU6IDEycHg7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGNvbG9yOiAjMDAwMDAwOyBsaW5lLWhlaWdodDogMS4yOyBwb2ludGVyLWV2ZW50czogYWxsOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3b3JkLXdyYXA6IG5vcm1hbDsgIj4zMCUgb3ZlcmFsbDxiciAvPmNvbW1pc3Npb24gcmF0ZTwvZGl2PjwvZGl2PjwvZGl2PjwvZm9yZWlnbk9iamVjdD48L2c+PC9nPjwvc3ZnPg==)$100&quot;,&quot;style&quot;:&quot;shape=mxgraph.flowchart.terminator;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#000000;strokeWidth=1;&quot;,&quot;parent&quot;:&quot;ssQVTA1O&quot;,&quot;vertex&quot;:&quot;1&quot;,&quot;diagramName&quot;:&quot;Terminator&quot;,&quot;diagramCategory&quot;:&quot;Flowchart&quot;,&quot;-0-mxGeometry&quot;:{&quot;x&quot;:&quot;360&quot;,&quot;y&quot;:&quot;369&quot;,&quot;width&quot;:&quot;98&quot;,&quot;height&quot;:&quot;60&quot;,&quot;as&quot;:&quot;geometry&quot;}},&quot;TGMTYoHJ&quot;:{&quot;id&quot;:&quot;TGMTYoHJ&quot;,&quot;value&quot;:&quot;Creator&quot;,&quot;style&quot;:&quot;shape=umlActor;verticalLabelPosition=bottom;labelBackgroundColor=#ffffff;verticalAlign=top;html=1;outlineConnect=0;&quot;,&quot;parent&quot;:&quot;ssQVTA1O&quot;,&quot;vertex&quot;:&quot;1&quot;,&quot;diagramName&quot;:&quot;Actor&quot;,&quot;diagramCategory&quot;:&quot;general&quot;,&quot;-0-mxGeometry&quot;:{&quot;x&quot;:&quot;740&quot;,&quot;y&quot;:&quot;324&quot;,&quot;width&quot;:&quot;30&quot;,&quot;height&quot;:&quot;45&quot;,&quot;as&quot;:&quot;geometry&quot;}},&quot;apgoCWsU&quot;:{&quot;id&quot;:&quot;apgoCWsU&quot;,&quot;value&quot;:&quot;TAP&quot;,&quot;style&quot;:&quot;shape=umlActor;verticalLabelPosition=bottom;labelBackgroundColor=#ffffff;verticalAlign=top;html=1;outlineConnect=0;&quot;,&quot;parent&quot;:&quot;ssQVTA1O&quot;,&quot;vertex&quot;:&quot;1&quot;,&quot;diagramName&quot;:&quot;Actor&quot;,&quot;diagramCategory&quot;:&quot;general&quot;,&quot;-0-mxGeometry&quot;:{&quot;x&quot;:&quot;740&quot;,&quot;y&quot;:&quot;237&quot;,&quot;width&quot;:&quot;30&quot;,&quot;height&quot;:&quot;45&quot;,&quot;as&quot;:&quot;geometry&quot;}},&quot;f46haEdv&quot;:{&quot;id&quot;:&quot;f46haEdv&quot;,&quot;style&quot;:&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;exitX=1;exitY=0.5;exitDx=0;exitDy=0;&quot;,&quot;parent&quot;:&quot;ssQVTA1O&quot;,&quot;source&quot;:&quot;Vw6AJaG6&quot;,&quot;edge&quot;:&quot;1&quot;,&quot;-0-mxGeometry&quot;:{&quot;relative&quot;:&quot;1&quot;,&quot;as&quot;:&quot;geometry&quot;,&quot;-0-mxPoint&quot;:{&quot;x&quot;:&quot;710&quot;,&quot;y&quot;:&quot;350&quot;,&quot;as&quot;:&quot;sourcePoint&quot;},&quot;-1-mxPoint&quot;:{&quot;x&quot;:&quot;740&quot;,&quot;y&quot;:&quot;260&quot;,&quot;as&quot;:&quot;targetPoint&quot;},&quot;-2-Array&quot;:{&quot;as&quot;:&quot;points&quot;,&quot;-0-mxPoint&quot;:{&quot;x&quot;:&quot;580&quot;,&quot;y&quot;:&quot;304&quot;},&quot;-1-mxPoint&quot;:{&quot;x&quot;:&quot;580&quot;,&quot;y&quot;:&quot;260&quot;},&quot;-2-mxPoint&quot;:{&quot;x&quot;:&quot;740&quot;,&quot;y&quot;:&quot;260&quot;}}}},&quot;I3D2zOhO&quot;:{&quot;id&quot;:&quot;I3D2zOhO&quot;,&quot;value&quot;:&quot;50% cut: $15&quot;,&quot;style&quot;:&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];labelBackgroundColor=#ffffff;&quot;,&quot;parent&quot;:&quot;f46haEdv&quot;,&quot;vertex&quot;:&quot;1&quot;,&quot;connectable&quot;:&quot;0&quot;,&quot;-0-mxGeometry&quot;:{&quot;x&quot;:&quot;0.3743&quot;,&quot;relative&quot;:&quot;1&quot;,&quot;as&quot;:&quot;geometry&quot;,&quot;-0-mxPoint&quot;:{&quot;y&quot;:&quot;-0.51&quot;,&quot;as&quot;:&quot;offset&quot;}}},&quot;VLkfLXJk&quot;:{&quot;id&quot;:&quot;VLkfLXJk&quot;,&quot;style&quot;:&quot;edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;exitX=1;exitY=0.5;exitDx=0;exitDy=0;&quot;,&quot;parent&quot;:&quot;ssQVTA1O&quot;,&quot;source&quot;:&quot;Vw6AJaG6&quot;,&quot;target&quot;:&quot;TGMTYoHJ&quot;,&quot;edge&quot;:&quot;1&quot;,&quot;-0-mxGeometry&quot;:{&quot;relative&quot;:&quot;1&quot;,&quot;as&quot;:&quot;geometry&quot;,&quot;-0-Array&quot;:{&quot;as&quot;:&quot;points&quot;,&quot;-0-mxPoint&quot;:{&quot;x&quot;:&quot;580&quot;,&quot;y&quot;:&quot;304&quot;},&quot;-1-mxPoint&quot;:{&quot;x&quot;:&quot;580&quot;,&quot;y&quot;:&quot;347&quot;}}}},&quot;v3jAxERg&quot;:{&quot;id&quot;:&quot;v3jAxERg&quot;,&quot;value&quot;:&quot;&quot;,&quot;style&quot;:&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];&quot;,&quot;parent&quot;:&quot;VLkfLXJk&quot;,&quot;vertex&quot;:&quot;1&quot;,&quot;connectable&quot;:&quot;0&quot;,&quot;-0-mxGeometry&quot;:{&quot;x&quot;:&quot;0.3989&quot;,&quot;y&quot;:&quot;-1&quot;,&quot;relative&quot;:&quot;1&quot;,&quot;as&quot;:&quot;geometry&quot;,&quot;-0-mxPoint&quot;:{&quot;as&quot;:&quot;offset&quot;}}},&quot;IvvdLcY7&quot;:{&quot;id&quot;:&quot;IvvdLcY7&quot;,&quot;value&quot;:&quot;50% cut: $15&quot;,&quot;style&quot;:&quot;edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];labelBackgroundColor=#ffffff;&quot;,&quot;parent&quot;:&quot;VLkfLXJk&quot;,&quot;vertex&quot;:&quot;1&quot;,&quot;connectable&quot;:&quot;0&quot;,&quot;-0-mxGeometry&quot;:{&quot;x&quot;:&quot;0.3645&quot;,&quot;y&quot;:&quot;-1&quot;,&quot;relative&quot;:&quot;1&quot;,&quot;as&quot;:&quot;geometry&quot;,&quot;-0-mxPoint&quot;:{&quot;as&quot;:&quot;offset&quot;}}},&quot;Vw6AJaG6&quot;:{&quot;id&quot;:&quot;Vw6AJaG6&quot;,&quot;value&quot;:&quot;30% overallcommission rate&quot;,&quot;style&quot;:&quot;shape=parallelogram;perimeter=parallelogramPerimeter;whiteSpace=wrap;html=1;fillColor=#E6E6E6;strokeColor=#808080;&quot;,&quot;parent&quot;:&quot;ssQVTA1O&quot;,&quot;vertex&quot;:&quot;1&quot;,&quot;diagramName&quot;:&quot;Parallelogram&quot;,&quot;diagramCategory&quot;:&quot;general&quot;,&quot;-0-mxGeometry&quot;:{&quot;x&quot;:&quot;425&quot;,&quot;y&quot;:&quot;284&quot;,&quot;width&quot;:&quot;135&quot;,&quot;height&quot;:&quot;40&quot;,&quot;as&quot;:&quot;geometry&quot;}}},&quot;mxCellList&quot;:[&quot;sOKJ7z39&quot;,&quot;ssQVTA1O&quot;,&quot;IKfqWfbA&quot;,&quot;4Mp1k6CJ&quot;,&quot;7xHhiAtp&quot;,&quot;b93394G9&quot;,&quot;rNQ9dvt3&quot;,&quot;PyrRYTA8&quot;,&quot;Y2cBJKct&quot;,&quot;WYbVFAjh&quot;,&quot;TGMTYoHJ&quot;,&quot;apgoCWsU&quot;,&quot;f46haEdv&quot;,&quot;I3D2zOhO&quot;,&quot;VLkfLXJk&quot;,&quot;v3jAxERg&quot;,&quot;IvvdLcY7&quot;,&quot;Vw6AJaG6&quot;]},&quot;lastEditTime&quot;:0,&quot;snapshot&quot;:&quot;&quot;}" />

💡<b>What this means for stakeholders?</b>
TikTok Affiliate Partners (TAPs) that are API-enabled can now efficiently manage Affiliate Partner Campaigns through automation by using these APIs.
Essentially, Affiliate Partner Campaigns function similarly to Open or Target Collaborations, except that TAPs can directly monetize off the transaction. If you are a partner that prefers to monetize off SaaS fees or other means, we recommend that you leverage from the Open or Target Collaboration model.
 

---

### **TikTok Shop Partner Center Policies**
https://partner.tiktokshop.com/docv2/page/6506bbf2de672602b7bc0697


---

## Get Open Collaboration Settings — `GET /affiliate_seller/202409/open_collaboration_settings`

Doc: https://partner.tiktokshop.com/docv2/page/get-open-collaboration-settings-202409 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202409/open_collaboration_settings
### Method: [GET]
### Function Description
Get the open collaboration settings, including auto add settings.

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
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202409/open_collaboration_settings?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^open_collaboration_settings | object |  | Open collaboration settings for the shop. |
| ^^auto_add_product | object |  | Settings for automatically adding products to open collaboration. |
| ^^^enable | bool | true | - true: The seller can add existing non-affiliate products to open collaboration at one time, and future products will also be added automatically. |

* false: Future products will not be added to open collaboration automatically, but existing products' open collaboration will not be reverted. |
   ^^^commission_rate |int |1000 |The default commission rate of open collaboration created for the auto-added products.
   The unit is 0.01%. For example, to set the default commission rate to 10%, set the value to `1000`. If so, if the price of a product is $50 USD, the creator would receive $5 USD for every piece of product sold.
   The range is `[100, 8000]`.
   When enable=false, this field will not be returned. |

### Response Sample
```json
{"code":0,"data":{"open_collaboration_settings":{"auto_add_product":{"enable":true,"commission_rate":1000}}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Edit Open Collaboration Settings — `POST /affiliate_seller/202405/open_collaboration_settings`

Doc: https://partner.tiktokshop.com/docv2/page/edit-open-collaboration-settings-202405 · cập nhật 2026-03-25 · scope: seller.affiliate_collaboration.write

### Path: /affiliate_seller/202405/open_collaboration_settings
### Method: [POST]
### Function Description
This API is used to edit a Seller's open collaboration settings. It allows you to enroll your existing product catalog and all future products into an open collaboration plan. It also allows you to turn this setting off at any point. By default, this option is turned off for all Sellers.

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
| auto_add_product | object | N |  | An object with properties to automatically add products to affiliate open collaboration plans. |
| ^enable | bool | Y | true | Set to `true` if products are automatically added to affiliate open collaboration plans. The seller can add existing non-affiliate products to open collaboration at one time, and future products are added automatically. Set to `false` if otherwise. |
| ^commission_rate | int | Y | 1000 | The commission rate in hundredths of a percent. For example, `3587` is a commission rate of `35.87%`. This value must a minimum of `100` and a maximum of `8000`. Not that setting the `enable` property to `false` overrides this property. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202405/open_collaboration_settings?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"auto_add_product":{"enable":true,"commission_rate":1000}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
### Response Sample
```json
{"code":0,"data":{},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get Open Collaboration Sample Rules — `GET /affiliate_seller/202410/open_collaborations/sample_rules`

Doc: https://partner.tiktokshop.com/docv2/page/get-open-collaboration-sample-rules-202410 · cập nhật 2026-10-28 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202410/open_collaborations/sample_rules
### Method: [GET]
### Function Description
Use this API to get the status and the details of the sample rules for products under an open collaboration. With this API, you can efficiently review the sample distribution criteria for products within the open collaboration context.

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
| product_ids | []string | Y | 172979,848746 | The product IDs whose sample rules to retrieve. Specify 1 to 200 product IDs per request. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202410/open_collaborations/sample_rules?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&product_ids=172979,848746
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^sample_rules | []object |  | The sample rules for the requested products. Products whose sample rules have never been created or have been deleted are omitted. |
| ^^product_id | string | 123456 | The unique id of product. |
| ^^sample_quota | int | 100 | The sample total quantity provided by seller which creators can apply for. |
| ^^is_sample_time_unlimited | bool | true | Whether samples are timely unlimited for request: |

* If true, it means available all the time
* If false, it means sample only available from `begin_time` to `end_time`. |
   ^^status |string |ONGOING |Free sample rule status:
* NOT_STARTED. Not yet reached the specified `begin_time`.
* ONGOING. The sample rule is effective and the collaboration is ongoing.
* `NO_LEFT_COUNT`. `sample_quantity_available` is `0`.
* PLAN_EXCEPTION. The product commission collaboration status is abnormal
* EXPIRED. Exceeded the `end_time`. |
   ^^available_quantity |int |50 |The quantity of remaining samples available for application. |
   ^^start_time |int |1728546888 |When present, the start of the sample application period, expressed as a Unix timestamp in seconds (UTC). |
   ^^end_time |int |1728546888 |When present, the end of the sample application period, expressed as a Unix timestamp in seconds (UTC). |
   ^^thresholds |object | |The threshold criteria that a creator must meet to be eligible to apply for the sample. |
   ^^^minimum_follower_count |int |200 |The creator must have a follower count greater than or equal to this value to be eligible to request the sample. |
   ^^^minimum_gmv |int |1000 |The creator must have the GMV in the past 30 days greater than this value to be eligible to request the sample. |
   ^^^avg_ec_video_views |int |5 |The creator must have an average number of e-commerce video views over the past 30 days greater than or equal to this value to be eligible to request the sample. |
   ^^^category_ids |[]string |["601152"] |A list of first-level product category IDs used to determine creator eligibility. For each creator, first-level product categories are ranked by GMV over the past 30 days. A creator is eligible if at least one category in this list is among the creator's top three categories. By default, no category restriction applies.
   For example, if a creator's top three categories are [{Cellphone_ID}, {Furniture_ID}, {Food_ID}] and this field is `[{Food_ID}]`, the creator is eligible for open collaboration. |
   ^^^predicted_fulfillment_rank |string |ALL |The creators whose predicted rate of posting a shoppable video or LIVE after receiving a sample.
* ALL. All creators regardless of the rate.
* LOW. The creators whose rate is above or equal to low.
* MEDIUM. The creators whose rate is above or equal to medium.
* HIGH. The creators whose rate is high. |

### Response Sample
```json
{"code":0,"data":{"sample_rules":[{"product_id":"123456","sample_quota":100,"is_sample_time_unlimited":true,"status":"ONGOING","available_quantity":50,"start_time":1728546888,"end_time":1728546888,"thresholds":{"minimum_follower_count":200,"minimum_gmv":1000,"avg_ec_video_views":5,"category_ids":["601152"],"predicted_fulfillment_rank":"ALL"}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Edit Open Collaboration Sample Rule — `POST /affiliate_seller/202410/open_collaborations/sample_rules`

Doc: https://partner.tiktokshop.com/docv2/page/edit-open-collaboration-sample-rule-202410 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.write

### Path: /affiliate_seller/202410/open_collaborations/sample_rules
### Method: [POST]
### Function Description
Use this API to manage sample rules in open collaborations, like valid time periods, or thresholds for creators to request samples. You can create, update, or deactivate rules.

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
| product_id | string | Y | 123456 | The product ID to which the sample rule applies. You can only assign one sample rule for one `product_id`. Only the most recent API call will take effect. |
| sample_rule | object | N |  | The sample rule settings to apply to the specified product. Use `activate_status` to create, update, or deactivate the rule. |
| ^sample_quota | int | N | 100 | The total quantity of the samples provided by the seller that the creators can apply for. |
| ^is_sample_time_unlimited | bool | N | true | Whether the sample is always available for application: |

* If true, the sample can be requested at any time.
* If false, the sample can only be requested during specified time periods. You must set start_time and end_time. |
   ^start_time |int |N |1728552553 |The start of the period during which a creator can apply for samples, as a Unix timestamp in seconds. You must specify `start_time` and `end_time` together. |
   ^end_time |int |N |1728552553 |The end of the period during which a creator can apply for samples, as a Unix timestamp in seconds. You must specify `start_time` and `end_time` together. |
   ^thresholds |object |N | |The threshold criteria that a creator must meet to be eligible to apply for the sample. |
   ^^minimum_follower_count |int |N |2000 |The creator must have a follower count greater than or equal to this value to be eligible to request the sample. |
   ^^minimum_gmv |int |N |1000 |The creator must have the GMV in the past 30 days greater than this value to be eligible to request the sample. |
   ^^avg_ec_video_views |int |N |5 |The creator must have an average number of e-commerce video views in the past 30 days greater than or equal to this value to be eligible to request the sample. |
   ^^category_ids |[]string |N |["601152"] |A list of product first-level category IDs.
   Use this to limit participating creators: for each creator, sort their GMV over the past 30 days by first-level product category. If the GMV of one of the categories is among the top three, the creator is eligible to participate in the event. No restriction by default.
   For example, if a creator's top three categories are [{Cellphone_ID}, {Furniture_ID}, {Food_ID}], and the value of tehis parameter is `[{Food_ID}]`, the creator is qualified for open collaboration. |
   ^^predicted_fulfillment_rank |string |N |LOW |The creators whose predicted rate of posting a shoppable video or LIVE after receiving a sample.
* ALL. All creators regardless of the rate.
* LOW. The creators whose rate is above or equal to low.
* MEDIUM. The creators whose rate is above or equal to medium.
* HIGH. The creators whose rate is high. |
   ^activate_status |string |Y |ACTIVATE |To activate the sample rule, use `ACTIVATE`; to deactivate the sample rule, use `DEACTIVATE`.
   When using `ACTIVATE`, you must specify the details of the rule; when using `DEACTIVATE`, you just need to specify `product_id`. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202410/open_collaborations/sample_rules?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"product_id":"123456","sample_rule":{"sample_quota":100,"is_sample_time_unlimited":true,"start_time":1728552553,"end_time":1728552553,"thresholds":{"minimum_follower_count":2000,"minimum_gmv":1000,"avg_ec_video_views":5,"category_ids":["601152"],"predicted_fulfillment_rank":"LOW"},"activate_status":"ACTIVATE"}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
### Response Sample
```json
{"code":0,"data":{},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Create Open Collaboration — `POST /affiliate_seller/202412/open_collaborations`

Doc: https://partner.tiktokshop.com/docv2/page/create-open-collaboration-202412 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.write

### Path: /affiliate_seller/202412/open_collaborations
### Method: [POST]
### Function Description
This API allows the seller to create an open collaboration. You create an open collaboration by selecting products and setting a commission rate.

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
| product_id | string | Y | 789078671231 | The product ID to add to the affiliate open collaboration. Submit one product per request. |
| commission_rate | int | Y | 1000 | The commission rate for the open collaboration, expressed in hundredths of a percent. For example, `3587` represents `35.87%`. The value must be from `100` to `8000`, inclusive. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202412/open_collaborations?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"product_id":"789078671231","commission_rate":1000}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^open_collaboration | object |  | The open collaboration. |
| ^^id | string | 7365861555575916210 | The open collaboration identifier. |
| ^^product_id | string | 789078671231 | The product identifier. |
| ^^effective_time | int | 1715654330 | The time from which the open collaboration commission is effective, expressed as a Unix timestamp in seconds. |
### Response Sample
```json
{"code":0,"data":{"open_collaboration":{"id":"7365861555575916210","product_id":"789078671231","effective_time":1715654330}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16003012 | An open collaboration containing this product already exists. |
| 16003025 | The seller's account is deactivated. |
| 16003033 | The commission rate must be between 1% and 80%. |
| 16003035 | One or more of the products you are trying to add are currently restricted by the platform. |
| 16603010 | The seller is currently restricted by the platform. |


---

## Search Open Collaborations — `POST /affiliate_seller/202412/open_collaborations/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-open-collaborations-202412 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202412/open_collaborations/search
### Method: [POST]
### Function Description
Search the merchant's open collaborations. The response includes product details, current commission information, the number of creators who added each product to their showcase, and the number of creators who posted LIVE or video content.

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
| page_token | string | N | b2Zmc2V0PTAK | Pagination token that determines where the search starts. Leave this parameter empty for the first request. For subsequent requests, pass the `next_page_token` returned by the previous response and reuse the same request-body filters, `sort_field`, `sort_order`, and `page_size`. |
| page_size | int | Y | 50 | The value of "page_size" must be greater than 0 and less than or equal to 100. |
| sort_order | string | N | DESC | Default value of "sort_order" is DESC. |
| Enum: |  |  |  |  |

* ASC：means to sort data in ascending order
* DESC：means to sort data in descending order |
   sort_field |string |N |product_original_price |Some sorting fields are as follows:
* product_original_price: sort by products' original price.
   By default, the open collaborations are sorted in descending order by creation time. |

### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| keyword_type | string | N | PRODUCT_ID | Specifies the type of value in `keyword`. To filter open collaborations by product name or product ID, provide `keyword_type` and `keyword` together. |
| Possible values: |  |  |  |  |

* `PRODUCT_ID`: Search for open collaboration information for the specified product ID.
* `PRODUCT_NAME`: Fuzzy-search open collaboration information by related product names. |
   keyword |string |N |7625459350921 |Search based on the product name or product ID. Pass in the appropriate value based on the keyword_type above. |
   top_level_category_id |string |N |60001 |Filter products by a first-level category ID.
   The value of `top_level_category_id` must be greater than 0. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202412/open_collaborations/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_token=b2Zmc2V0PTAK&page_size=50&sort_order=DESC&sort_field=product_original_price
```

**Body**
```json
{"keyword_type":"PRODUCT_ID","keyword":"7625459350921","top_level_category_id":"60001"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^next_page_token | string | b2Zmc2V0PTEw | Pagination token for the next page. Pass this value as `page_token` in the next request. An empty value indicates that there are no more results. |
| ^total_count | int | 10000 | Total count of products that satisfy all the input search conditions. |
| ^open_collaborations | []object |  | Open collaborations matching the search criteria on the current page. |
| ^^id | string | 94297006405 | The open collaboration id |
| ^^status | string | NORMAL | Status of open collaboration. |
| Field values: |  |  |  |

* NORMAL：NORMAL means the current open collaboration status is normal and in effect.
* TERMINATING: TERMINATING means that the merchant has removed open collaboration and the open collaboration will expire soon. The expiration time can be found at the end_time of current_commission.
   The open collaborations which were removed and expired will not be returned in the response. |
   ^^current_commission |object | |The commission information is currently in effect for this open collaboration. |
   ^^^rate |int |3000 |The commission rate for this product is set by merchants for creators' public promotion.
   The range of this value is [100, 8000].
   This value is expressed in 1/10000 increments. For example: 3000 means the actual commission rate is 30.00%, and 3555 means 35.55% |
   ^^^start_time |int |1725334422 |The Unix timestamp, in seconds, when the commission rate becomes effective. |
   ^^^end_time |int |1727625600 |The Unix timestamp, in seconds, when the commission rate stops being effective. |
   ^^showcase_creator_count |int |15 |This field indicates the number of creators who added the product to the showcase from open collaboration. |
   ^^content_creator_count |int |10 |This field indicates the number of creators who posted the LIve or Video from open collaboration. |
   ^^product |object | |The open collaboration bound product information. |
   ^^^id |string |1729432087292775344 |Product's unique id. |
   ^^^title |string |Blue t-shirt |Product's name. |
   ^^^main_image_url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499 |The product image url. |
   ^^^status |string |LIVE |Product's status.
   Field values:
* LIVE: When the product is normal for sale, return to the LIVE status
* OUT_OF_STOCK: When the product is out of stock for the consumer, the OUT_OF_STOCK state is returned
* SELLER_DEACTIVATE: When the product is deactivated by the merchant, the SELLER_DEACTIVATE status is returned
* PLATFORM_DEACTIVATE: When the product is deactivated by the platform or is not available for sale, the PLATFORM_DEACTIVATE status is returned
* GNE_REJECT: When the product is governed or the open collaboration is dismissed, the GNE_REJECT state is returned
* DELETE: When the product is deleted, the DELETE status is returned
* OTHER: When the product is in an unsaleable state, such as draft, frozen, review, etc, the OTHER status is returned |
   ^^^inventory |int |1274 |The inventory of this product. |
   ^^^original_price |object | |The product's original price |
   ^^^^currency |string |USD |The three-letter currency code of the product's original price. |
   ^^^^minimum_amount |string |12.21 |The minimum original price of all skus of this product. |
   ^^^^maximum_amount |string |100.00 |The maximum original price of all skus of this product. |

### Response Sample
```json
{"code":0,"data":{"next_page_token":"b2Zmc2V0PTEw","total_count":10000,"open_collaborations":[{"id":"94297006405","status":"NORMAL","current_commission":{"rate":3000,"start_time":1725334422,"end_time":1727625600},"showcase_creator_count":15,"content_creator_count":10,"product":{"id":"1729432087292775344","title":"Blue t-shirt","main_image_url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499","status":"LIVE","inventory":1274,"original_price":{"currency":"USD","minimum_amount":"12.21","maximum_amount":"100.00"}}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Remove Open Collaboration — `DELETE /affiliate_seller/202409/open_collaborations/products/{product_id}`

Doc: https://partner.tiktokshop.com/docv2/page/remove-open-collaboration-202409 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.write

### Path: /affiliate_seller/202409/open_collaborations/products/{product_id}
### Method: [DELETE]
### Function Description
Remove a product's open collaboration. You can remove only an open collaboration with `status == NORMAL`. Use the published `POST /affiliate_seller/202409/open_collaborations/search` endpoint to find the product's open collaboration and confirm that its status is `NORMAL` before calling this API. To protect creators' interests, termination is not immediate and takes effect at the returned `terminated_effective_time`. After that time, call the same search endpoint to verify that the open collaboration is no longer returned.

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
| product_id | string | Y | 7890786712312312 | The product id of the open collaboration to be terminated |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202409/open_collaborations/products/7890786712312312?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
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
| ^terminated_effective_time | int | 1725334422 | The Unix timestamp, in seconds, when the open collaboration termination takes effect. This is usually 00:00 on the next day in the shop's time zone. |
### Response Sample
```json
{"code":0,"data":{"terminated_effective_time":1725334422},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16003025 | The seller's account is deactivated. |


---

## Get Open Collaboration Creator Content Details — `GET /affiliate_seller/202508/open_collaborations/creator_content_details`

Doc: https://partner.tiktokshop.com/docv2/page/get-open-collaboration-creator-content-details-202508 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202508/open_collaborations/creator_content_details
### Method: [GET]
### Function Description
This API allows a seller to retrieve creator profiles, content counts, and promotion details for a specified product in open collaboration.

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
| page_token | string | N | b2Zmc2V0PTAK | Pagination token. Omit this parameter or pass an empty string for the first request. For subsequent requests, pass the `next_page_token` returned by the previous response and reuse the same `product_id` and `page_size`. |
| page_size | int | Y | 50 | The value of "page_size" must be greater than 0 and less than or equal to 100. |
| product_id | string | Y | 1730076583746441639 | The product ID that needs to be queried. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202508/open_collaborations/creator_content_details?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_token=b2Zmc2V0PTAK&page_size=50&product_id=1730076583746441639
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^next_page_token | string | b2Zmc2V0PTEw | Pagination token for the next page. Pass this value as `page_token` in the next request. An empty token means there are no more results. |
| ^total_count | int | 1 | Total count of creators that satisfy all the input search conditions. |
| ^creator_content_details | []object |  | Creator profiles, content counts, and promotion details for the specified product. |
| ^^creator_profile | object |  | Creator's profile details. |
| ^^^username | string | example_creator | The creator's username. |
| ^^^nickname | string | nickname | The creator's nickname. |
| ^^^follower_count | int | 10023 | Number of followers of the creator. |
| ^^^avatar | object |  | The creator's avatar details. |
| ^^^^url | string | https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499 | The url of the creator's avatar. |
| ^^^creator_open_id | string | uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg | Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
| ^^video_count | int | 101 | This field indicates the number of videos posted by the creator. |
| ^^live_count | int | 2 | This field indicates the number of lives posted by the creator. |
| ^^promotion_status | string | NORMAL | Promotion status of the creator. |
| Field values: |  |  |  |

* NORMAL: When the creator is promoting normally, it returns to NORMAL status
* TERMINATING:When the creator is asked by the merchant to terminate the promotion, the status will return to TERMINATING, indicating that the creator's promotion rights will expire soon. |
   ^^promotion_end_time |int |1734682697 |End time of creator promotion. |
   ^product |object | |Product details. |
   ^^id |string |1734823553672710512 |Product's unique id. |
   ^^image_url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499 |The product image url. |

### Response Sample
```json
{"code":0,"data":{"next_page_token":"b2Zmc2V0PTEw","total_count":1,"creator_content_details":[{"creator_profile":{"username":"example_creator","nickname":"nickname","follower_count":10023,"avatar":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499"},"creator_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg"},"video_count":101,"live_count":2,"promotion_status":"NORMAL","promotion_end_time":1734682697}],"product":{"id":"1734823553672710512","image_url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499"}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Seller Search Open Collaboration Products — `POST /affiliate_seller/202405/open_collaborations/products/search`

Doc: https://partner.tiktokshop.com/docv2/page/seller-search-open-collaboration-products-202405 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202405/open_collaborations/products/search
### Method: [POST]
### Function Description
Searches for open-collaboration products on the TikTok Shop Affiliate Product Marketplace within the regions where the seller is registered to sell. Category, commission rate, sales price, and title keyword filters are optional. When multiple filter groups are supplied, a product must match every supplied group. When none of these filter groups is supplied, no filter from these groups is applied; results remain scoped to eligible open-collaboration products in the seller's registered regions and are returned through pagination.

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
| sort_order | string | N | DESC | The sort order for the sort_field parameter. Default: ASC |
| Possible values: |  |  |  |  |

* ASC: Ascending order
* DESC: Descending order |
   sort_field |string |N |commission_rate |The returned results will be sorted by the specified field. See the description of the field values in the request body for more information about each field.
   Default: commission_rate
   Possible values:
* commission_rate
* product_sales_price
* commission
* units_sold |
   page_token |string |N |b2Zmc2V0PTIw |An opaque token used to retrieve the next page of a paginated result set. Retrieve this value from the result of the next_page_token from a previous response. It is not needed for the first page. |
   page_size |int |Y |20 |The number of results to be returned per page. Valid range: [1-20]. |

### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| title_keywords | []string | N | ["Men", "Fashion"," Sports Short"] | A list of product keywords. Product titles, or names, are loosely matched. Keywords in the list form a query and the resulting set of matching product names is based on the conjunctive operator `AND` between each keyword. For example, the keyword list `["Men", "Fashion"]` creates a query `"Men" AND "Fashion"` and the resulting set of matching product names contains the loosely matched conjuction of "Men" and "Fashion" such as "Male Fashionable". Maximum length of the list is 20 keywords. Maximum keyword string length is 255 characters. |
| sales_price_range | object | N |  | Restricts the products in the search results to those with prices greater than or equal to the expressed minimum price and less than the expressed maximum price |
| ^amount_ge | string | N | 12.44 | The product price must be greater than this value in order to be included in the search results. The value must be greater than `0`. |
| ^amount_lt | string | N | 100 | The product price must be greater than this value in order to be included in the search results. The value must be greater than `0`. No upper bound is set if this property is not included. |
| category | object | N |  | Restricts the products in the search results to those that are associated with the expressed product category. |
| ^id | string | N | 3412342 | The category identifier. Note that only first-level categories are supported. |
| commission_rate_range | object | N |  | Filters products by the commission rate range specified by `rate_ge` and `rate_lt`. |
| ^rate_ge | int | N | 100 | Products with a commission rate greater than or equal to this value are included in the search results. The rate is expressed in hundredths of a percent; for example, `3587` means `35.87%`. Valid range: [100, 8000]. |
| ^rate_lt | int | N | 8000 | The commission rate must be less than this value in order to be included in the search results. The commission rate is expressed in hundredths of a percent. For example, `3587` is a commission rate of `35.87%`. This value must a minimum of `100`. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202405/open_collaborations/products/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&sort_order=DESC&sort_field=commission_rate&page_token=b2Zmc2V0PTIw&page_size=20
```

**Body**
```json
{"title_keywords":["Men","Fashion"," Sports Short"],"sales_price_range":{"amount_ge":"12.44","amount_lt":"100"},"category":{"id":"3412342"},"commission_rate_range":{"rate_ge":100,"rate_lt":8000}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^products | []object |  | The list of products meeting the search criteria expressed in the request body. |
| ^^shop | object |  | Metadata and data associated with the TikTok Shop that sells the product. |
| ^^^name | string | Test shop | The name of the TikTok shop. |
| ^^id | string | 1729432087292775344 | The product identifier. |
| ^^has_inventory | bool | false | Set to `true` if there are more than zero units of the product in inventory. Set to `false` if there are zero units in inventory. |
| ^^units_sold | int | 12123 | The total number of units sold of this product. |
| ^^title | string | Blue t-shirt | The product name. |
| ^^sale_region | string | ID | The region where the product is offered for sale. |
| ^^main_image_url | string | https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499 | The product image URL. |
| ^^detail_link | string | https://shop.tiktok.com/view/product/1729624807198591373?region=ID&local=en | The URL for the product's detail page. |
| ^^original_price | object |  | The original price of the product. |
| ^^^currency | string | USD | The currency code. |
| ^^^minimum_amount | string | 12.21 | The lowest original price of all SKUs of the product. |
| ^^^maximum_amount | string | 100.00 | The highest original price of all SKUs of the product. |
| ^^category_chains | []object |  | A list of categories associated with the product. |
| ^^^id | string | 343554 | The category identifier. |
| ^^^local_name | string | COMPUTER | The category name. |
| ^^^is_leaf | bool | false | Set to `true` if this category is a leaf node. Set to `false` if not. |
| ^^^parent_id | string | 342948 | The category identifier of the parent category for the category. |
| ^^commission | object |  | Metadata and data associated with the commission rates for the product. |
| ^^^rate | int | 3000 | The commission rate in hundredths of a percent. For example, `3587` is a commission rate of `35.87%`. This value must a minimum of `1000`. |
| ^^^currency | string | USD | The currency code. |
| ^^^amount | string | 121.32 | The commission amount. |
| ^^sales_price | object |  | The product's promotional price range. |
| ^^^currency | string | USD | The currency code. |
| ^^^minimum_amount | string | 34.3 | The lowest promotion price of all SKUs of this product. |
| ^^^maximum_amount | string | 55.7 | The highest promotion price of all SKUs of this product. |
| ^next_page_token | string | b2Zmc2V0PTEw | An opaque token used to retrieve the next page of a paginated result set. If this value is non-empty, pass it as page_token in the next request and keep shop_cipher, page_size, sort_field, sort_order, and the request body unchanged. An empty value means that there are no more pages. |
| ^total_count | int | 10000 | Total count of products meeting the search criteria expressed in the request body. |
### Response Sample
```json
{"code":0,"data":{"products":[{"shop":{"name":"Test shop"},"id":"1729432087292775344","has_inventory":false,"units_sold":12123,"title":"Blue t-shirt","sale_region":"ID","main_image_url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499","detail_link":"https://shop.tiktok.com/view/product/1729624807198591373?region=ID\u0026local=en","original_price":{"currency":"USD","minimum_amount":"12.21","maximum_amount":"100.00"},"category_chains":[{"id":"343554","local_name":"COMPUTER","is_leaf":false,"parent_id":"342948"}],"commission":{"rate":3000,"currency":"USD","amount":"121.32"},"sales_price":{"currency":"USD","minimum_amount":"34.3","maximum_amount":"55.7"}}],"next_page_token":"b2Zmc2V0PTEw","total_count":10000},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Remove Creator From Open Collaboration Product — `POST /affiliate_seller/202508/open_collaborations/{open_collaboration_id}/remove_creator`

Doc: https://partner.tiktokshop.com/docv2/page/remove-creator-from-open-collaboration-product-202508 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.write

### Path: /affiliate_seller/202508/open_collaborations/{open_collaboration_id}/remove_creator
### Method: [POST]
### Function Description
This API is used to remove creators from open collaboration. Please note, due to current platform design, creators can still rejoin an open collaboration after removal. Partners/Sellers can call this API again to remove the creator again.

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
| open_collaboration_id | string | Y | 7890786712312312 | Open collaboration ID. This API is only applicable to the seller removing creators from open collaboration. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| creator_user_open_id | string | Y | uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg | Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
| product_id | string | Y | 789078671231 | The product identifier. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202508/open_collaborations/7890786712312312/remove_creator?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"creator_user_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg","product_id":"789078671231"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
### Response Sample
```json
{"code":0,"data":{},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Create Target Collaboration — `POST /affiliate_seller/202508/target_collaborations`

Doc: https://partner.tiktokshop.com/docv2/page/create-target-collaboration-202508 · cập nhật 2026-10-28 · scope: seller.affiliate_collaboration.write

### Path: /affiliate_seller/202508/target_collaborations
### Method: [POST]
### Function Description
This API is used to create a target collaboration.
A target collaboration is a collaboration between a seller selected set of products (including a commission payout) and a set of creators the seller has added (invited) to the collaboration. Target collaborations are private and not visible in the Creator Marketplace to all creators; they are only visible to those that have been added to the collaboration.

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
| name | string | Y | openapi_test | The name of the target collaboration. |
| message | string | N | this is a message | The message sent to creators associated with the target collaboration. |
| end_time | string | Y | 1715654330 | The date at which the target collaboration ends, in Unix epoch time. |
| products | []object | Y |  | A list of metadata and data for the products provided by the seller for target collaboration. Maximum length of the list is `100` products. |
| ^id | string | Y | 789078671231312312 | The product identifier. |
| ^target_commission_rate | int | Y | 1000 | The desired commission rate for the target collaboration. The desired commission rate is expressed in hundredths of a percent. For example, `3587` is a commission rate of `35.87%`. This value must a minimum of `100`. |
| ^shop_ads_commission_rate | int | N | 1000 | The commission rate applies only to orders generated from ads. If a creator’s video is used as an ad without this rate being set, the resulting orders will instead earn either: |

* The Shop Ads commission you configured in open collaboration, or
* The standard commission defined in this invitation.
   The commission rate is specified in increments of 1/10,000.
   For example, 1000 stands for 0.1 or 10%. |
   creator_user_open_ids |[]string |Y |["uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg"] | Maximum length of the list is `50` user open identifiers. Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
   seller_contact_info |object |Y | |Metadata and data associated with the seller contact information. |
   ^email |string |N |test@tiktokshop.com |The seller's email address. |
   ^phone_number |string |N |1234567890 |The phone number of the seller. |
   ^whatsapp |string |N |1234567890 |The phone number used by the seller to register for WhatsApp. |
   ^telegram |string |N |1234567890 |The seller's Telegram username or phone number. |
   ^line |string |N |1234567890 |The phone number used by the seller to register for the Line app. |
   free_sample_rule |object |Y | |A set of properties that control the free sample behavior for the product. |
   ^has_free_sample |bool |Y |true |If set to `true`, free samples are provided to creators invited to the target collaboration group. If set to `false`, free samples are not provided. |
   ^is_sample_approval_exempt |bool |Y |true |If set to `true`, creators invited to the target collaboration are exempt from seller review and are automatically approved for a free product sample. Note that the `has_free_sample` property overrides the free sample behavior. |
   preferred_content_type |string |N |LIVE |preferred creator content type, "LIVE" or "VIDEO" |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202508/target_collaborations?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"name":"openapi_test","message":"this is a message","end_time":"1715654330","products":[{"id":"789078671231312312","target_commission_rate":1000,"shop_ads_commission_rate":1000}],"creator_user_open_ids":["uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg"],"seller_contact_info":{"email":"test@tiktokshop.com","phone_number":"1234567890","whatsapp":"1234567890","telegram":"1234567890","line":"1234567890"},"free_sample_rule":{"has_free_sample":true,"is_sample_approval_exempt":true},"preferred_content_type":"LIVE"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^target_collaboration | object |  | The target collaboration. |
| ^^id | string | 7365861555575916210 | The target collaboration identifier. |
| ^target_collaboration_conflicts | []object |  | A list of user and product identifiers with target collaboration conflicts that caused target collaboration failure. |
| ^^creator_user_open_id | string | uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg | Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
| ^^product_id | string | 789078671231 | The product identifier. |
| ^invalid_open_id_list | []string | ["xxxx"] | The list of open id that caused the create to fail. |
| ^invalid_product_id_list | []string | ["1234"] | The list of product id that caused the create to fail. |
| ^create_time | int | 1715654330 | The create time of the target collaboration. |
### Response Sample
```json
{"code":0,"data":{"target_collaboration":{"id":"7365861555575916210"},"target_collaboration_conflicts":[{"creator_user_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg","product_id":"789078671231"}],"invalid_open_id_list":["xxxx"],"invalid_product_id_list":["1234"],"create_time":1715654330},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16024004 | test account and non test account can not cross invite |
| 16024006 | The seller cannot invite their official creator. |
| 16024008 | There are products that do not belong to this merchant. |
| 16024016 | The invitation failed because the creator is already linked with a shop account. |
| 16024019 | in sufficient quota to create invitation |
| 16024020 | remove excluded creators to create invitation |
| 16024021 | invitation contains creator exceed follower limit |
| 16024022 | This invitation has exist creator and product, please check conflict pair. |
| 50001702 | Your invitation target contains an unavailable creator or product. Please check your request params.Remove the unavailable creator or product id and try again. |
| 50001703 | The request parameters contain sensitive words. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 98001004 | Parameter {param_name} is invalid. Reason: {reason}. Expected: {expected_value} |


---

## Search Target Collaborations — `POST /affiliate_seller/202508/target_collaborations/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-target-collaborations-202508 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202508/target_collaborations/search
### Method: [POST]
### Function Description
This API is used by Seller to search for all existing target collaborations. Sellers can search based on filters such as Invitation name, Invitation ID, Product name, Product ID and Creator name.

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
| page_size | int | N | 20 | The value of "page_size" must be 20, 50 or 100. |
| page_token | string | N | b2Zmc2V0PTAK | Pagination token that specifies where to continue the search. Omit this parameter or leave it empty in the first request. For subsequent pages, pass the `next_page_token` returned by the previous response and reuse the same request-body filters and `page_size`. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| creator_accept_status | string | N | ACCEPT | Filter target collaborations by the acceptance status of invited creators. |
| Allowed values: |  |  |  |  |

* ACCEPT: The creators have added the products to their showcases.
* ALL: Do not filter by whether the creators have added the products to their showcases.
   Default: ALL. |
   free_sample_setting |string |N |WITH_FREE_SAMPLE |Filtering by target collaborations' free sample setting.
   You can query based on:
* "WITH_FREE_SAMPLE"
* "ALL"
   By default, the target collaborations will be searched by "ALL" setting. |
   search_param |object |N | |Search criteria for target collaborations. When this object is provided, provide both keyword_type and keyword. |
   ^keyword_type |string |Y |TARGET_COLLABORATION_NAME |Type of value provided in keyword.
   Possible values:
* PRODUCT_ID: Search for a specific product ID.
* PRODUCT_NAME: Fuzzy-search by product name.
* TARGET_COLLABORATION_ID: Search for a specific target collaboration ID.
* TARGET_COLLABORATION_NAME: Fuzzy-search by target collaboration name. |
   ^keyword |string |Y |test |The value to search for, interpreted according to keyword_type. |
   creator_user_open_id |string |N |uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg |The creator's TikTok User Open ID. Provide this field to filter target collaborations for the specified creator. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
   collaboration_status |string |Y |ONGOING |Filtering by target collaborations' status.
   You can query based on:
* ONGOING: If you use ONGOING to search, the remaining validity period of the returned target collaborations will be greater than 7 days.
* EXPIRING: If you use EXPIRING to search, the remaining validity period of the returned target collaborations will be less than 7 days.
* VALID: If you use VALID to search, all returned target collaborations will be valid.
* CANCELING: If you use CANCELING to search, all returned target collaborations will be in the process of canceling.
* COMPLETED: If you use COMPLETED to search, all returned target collaborations will be in the state of completed, including expired and canceled. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202508/target_collaborations/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_size=20&page_token=b2Zmc2V0PTAK
```

**Body**
```json
{"creator_accept_status":"ACCEPT","free_sample_setting":"WITH_FREE_SAMPLE","search_param":{"keyword_type":"TARGET_COLLABORATION_NAME","keyword":"test"},"creator_user_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg","collaboration_status":"ONGOING"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^total_count | int | 100 | Total number of target collaborations that match the request across all pages. |
| ^next_page_token | string | b2Zmc2V0PTIw | Cursor for the next page request. |
| ^target_collaborations | []object |  | The basic information of target collaboration which creators can view in Targeted Invitation on TikTok EC Center. |
| ^^id | string | 789078671231123124 | Target collaboration ID. |
| ^^name | string | target_collaboration | Target collaboration name. |
| ^^message | string | test | Message seller has sent to creators about seller's introduction and why excited to collaborate. |
| ^^start_time | int | 1715654330 | Unix timestamp, in seconds, when the target collaboration starts. |
| ^^end_time | int | 1715654330 | Unix timestamp, in seconds, when the target collaboration ends. |
| ^^create_time | int | 1715654330 | Unix timestamp, in seconds, when the target collaboration was created. |
| ^^update_time | int | 1715654330 | Unix timestamp, in seconds, when the target collaboration was last updated. |
| ^^creator_inivited_count | int | 10 | The count of creators invited in the target collaboration. |
| ^^showcase_creator_count | int | 2 | The number of creators in the target collaboration who added at least one of its products to their showcase. |
| ^^content_creator_count | int | 1 | The number of creators who posted content featuring products from target collaboration. |
| ^^product_count | int | 30 | The count of products added in the target collaboration. |
| ^^free_sample_rule | object |  | The free sample rules set by the seller in the target collaboration. |
| ^^^has_free_sample | bool | true | If true, free samples are provided to creators invited to the target collaboration. |
| ^^^is_sample_approval_exempt | bool | true | If true, creators invited to the target collaboration are exempt from seller review and will automatically be approved for a free sample. |
| Note that if has_free_sample=false, this field will not take effect. |  |  |  |
| ^^type | string | STANDARD | The type of target collaboration. |
| Field values: |  |  |  |

* STANDARD: The target collaboration is created by sellers manually selecting products and creators.
* TOP_CREATOR_PROGRAM: The target collaboration created by seller joining TikTok Shop Top Creator Program, requiring only product submission. |

### Response Sample
```json
{"code":0,"data":{"total_count":100,"next_page_token":"b2Zmc2V0PTIw","target_collaborations":[{"id":"789078671231123124","name":"target_collaboration","message":"test","start_time":1715654330,"end_time":1715654330,"create_time":1715654330,"update_time":1715654330,"creator_inivited_count":10,"showcase_creator_count":2,"content_creator_count":1,"product_count":30,"free_sample_rule":{"has_free_sample":true,"is_sample_approval_exempt":true},"type":"STANDARD"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Update Target Collaboration — `PUT /affiliate_seller/202508/target_collaborations/{target_collaboration_id}`

Doc: https://partner.tiktokshop.com/docv2/page/update-target-collaboration-202508 · cập nhật 2026-10-28 · scope: seller.affiliate_collaboration.write

### Path: /affiliate_seller/202508/target_collaborations/{target_collaboration_id}
### Method: [PUT]
### Function Description
This API is used by sellers to update a STANDARD target collaboration. A successful response can still report creators or products that were not updated. Check `data.update_failed` and `data.target_collaboration_conflicts` before treating the update as complete.

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
| target_collaboration_id | string | Y | 7890786712312312 | The unique id of specific target collaboration. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| name | string | Y | openapi_test | The name of the target collaboration. |
| end_time | string | Y | 1715654330 | The end time of the target collaboration, as a Unix timestamp in seconds. |
| products | []object | Y |  | The information about the products provided by the seller for target collaboration with creators in the target collaboration. |
| The maximum number of products is 100. |  |  |  |  |
| When a product is deleted from the product list, if the deleted product has been added to the showcase by the creator, it will take effect at 0:00 the next day, otherwise it will take effect immediately. |  |  |  |  |
| ^id | string | Y | 789078671231312312 | The product identifier. |
| ^commission_rate | int | Y | 1000 | The desired commission rate for the target collaboration. The value is measured in ten thousandths. For example, 3587 means the commission fee equals 35.87% of the original price. The range is [100, 8000]. |
| Increasing product commissions will take effect immediately, while reducing product commissions will take effect at 00:00 the next day if the current product has been added to the showcase by a creator, otherwise it will take effect immediately. |  |  |  |  |
| ^target_ad_commission_rate | int | N | 1000 | The commission rate applies only to orders generated from ads. If a creator’s video is used as an ad without this rate being set, the resulting orders will instead earn either: |

* The Shop Ads commission you configured in open collaboration, or
* The standard commission defined in this invitation.
   The commission rate is specified in increments of 1/10,000.
   For example, 1000 stands for 0.1 or 10%. |
   creator_user_open_ids |[]string |Y |["123123213213"] |The list of Creators' TikTok User Open IDs invited in the target collaboration. The maximum number of creators is 50. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
   seller_contact_info |object |Y | |Contact information for the seller in the target collaboration. |
   ^email |string |Y |test@bytedance.com |Seller's email contact information |
   ^phone_number |string |N |1234567890 |The phone number of the seller. |
   ^whatsapp |string |N |1234567890 |The phone number used by the seller to register for WhatsApp. |
   ^telegram |string |N |1234567890 |The seller's Telegram username or phone number. |
   ^line |string |N |1234567890 |The phone number used by the seller to register for the Line app |
   free_sample_rule |object |Y | |The free sample rules set by the seller in the target collaboration. |
   ^has_free_sample |bool |Y |true |If true, free samples are provided to creators invited to the target collaboration. |
   ^is_sample_approval_exempt |bool |Y |true |If true, creators invited to the target collaboration are exempt from seller review and will automatically be approved for a free sample.
   Note that if has_free_sample=false, this field will not take effect. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202508/target_collaborations/7890786712312312?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"name":"openapi_test","end_time":"1715654330","products":[{"id":"789078671231312312","commission_rate":1000,"target_ad_commission_rate":1000}],"creator_user_open_ids":["123123213213"],"seller_contact_info":{"email":"test@bytedance.com","phone_number":"1234567890","whatsapp":"1234567890","telegram":"1234567890","line":"1234567890"},"free_sample_rule":{"has_free_sample":true,"is_sample_approval_exempt":true}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^target_collaboration_conflicts | []object |  | A list of creators and products with target collaboration conflicts that caused target collaboration update failure. |
| ^^creator_user_open_id | string | 7494656937121841111 | Creator Open ID. More details:https://partner.tiktokshop.com/docv2/page/3obfokj6 |
| ^^product_id | string | 789078671231 | The product identifier. |
| ^update_failed | object |  | Describe which fields were not updated successfully. |
| ^^remove_creator_open_ids | []string | ["12345"] | The list of creators' TikTok User Open IDs that have not been successfully removed. More details:https://partner.tiktokshop.com/docv2/page/3obfokj6 |
| ^^remove_product_ids | []string | ["12345"] | The list of product ids that have not been successfully removed. |
| ^^add_creator_open_ids | []string | ["12345"] | The list of creators' TikTok User Open IDs that have not been successfully added. More details:https://partner.tiktokshop.com/docv2/page/3obfokj6 |
| ^^add_products | object |  | The list of products that have not been successfully added. |
| ^^^id | string | 789078671231312312 | The product identifier. |
| ^^^commission_rate | int | 1000 | The desired commission rate for the target collaboration. The desired commission rate is expressed in hundredths of a percent. For example, 3587 is a commission rate of 35.87%. This value must be a minimum of 1000. |
| ^^change_commissions | object |  | The list of commission information that has not been successfully changed. |
| ^^^product_id | string | 789078671231312312 | The product identifier. |
| ^^^commission_rate | int | 1000 | The desired commission rate for the target collaboration. The desired commission rate is expressed in hundredths of a percent. For example, 3587 is a commission rate of 35.87%. This value must be a minimum of 1000. |
| ^^end_time | int | 1715654330 | The end time of the target collaboration, which has not been successfully updated. |
| ^^seller_contact_info | object |  | Contact information for the seller in the target collaboration which has not been successfully updated. |
| ^^^email | string | test@bytedance.com | Seller's email contact information which has not been successfully updated. |
| ^^^phone_number | string | (+62) 1234567890 |  |
| The phone number of the seller. |  |  |  |
| ^^^whatsapp | string | (+62) 1234567890 |  |
| The phone number used by the seller to register for WhatsApp. |  |  |  |
| ^^^telegram | string | (+62) 1234567890 |  |
| The seller's Telegram username or phone number. |  |  |  |
| ^^^line | string | (+62) 1234567890 |  |
| The phone number used by the seller to register for the Line app |  |  |  |
| ^^name | string | openapi_test | The name of the target collaboration. |
| ^^invalid_product_id_list | []string | ["1234"] | The list of product id that caused the update to fail. |
| ^^invalid_open_id_list | []string | ["xxxxxx"] | The list of open id that caused the update to fail. |
### Response Sample
```json
{"code":0,"data":{"target_collaboration_conflicts":[{"creator_user_open_id":"7494656937121841111","product_id":"789078671231"}],"update_failed":{"remove_creator_open_ids":["12345"],"remove_product_ids":["12345"],"add_creator_open_ids":["12345"],"add_products":{"id":"789078671231312312","commission_rate":1000},"change_commissions":{"product_id":"789078671231312312","commission_rate":1000},"end_time":1715654330,"seller_contact_info":{"email":"test@bytedance.com","phone_number":"(+62) 1234567890\n","whatsapp":"(+62) 1234567890\n","telegram":"(+62) 1234567890\n","line":"(+62) 1234567890\n"},"name":"openapi_test","invalid_product_id_list":["1234"],"invalid_open_id_list":["xxxxxx"]}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16024004 | test account and non test account can not cross invite |
| 16024006 | The seller cannot invite their official creator. |
| 16024008 | There are products that do not belong to this merchant. |
| 16024016 | The invitation failed because the creator is already linked with a shop account. |
| 16024018 | seller can not invite his block creator |
| 16024019 | in sufficient quota to create invitation |
| 16024020 | remove excluded creators to create invitation |
| 16024021 | invitation contains creator exceed follower limit |
| 36009007 | request timeout |
| 50001701 | target collaboration has expired |
| 50001702 | Your invitation target contains an unavailable creator or product. Please check your request params.Remove the unavailable creator or product id and try again. |
| 50001703 | The request parameters contain sensitive words. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 98001004 | Parameter {param_name} is invalid. Reason: {reason}. Expected: {expected_value} |


---

## Remove Target Collaboration — `DELETE /affiliate_seller/202409/target_collaborations/{target_collaboration_id}`

Doc: https://partner.tiktokshop.com/docv2/page/remove-target-collaboration-202409 · cập nhật 2026-08-28 · scope: seller.affiliate_collaboration.write

### Path: /affiliate_seller/202409/target_collaborations/{target_collaboration_id}
### Method: [DELETE]
### Function Description
This API is used by Seller to remove affiliate target collaboration.

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
| target_collaboration_id | string | Y | 7890786712312312 | The unique id of the specified target collaboration. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202409/target_collaborations/7890786712312312?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
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
### Response Sample
```json
{"code":0,"data":{},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 600001001 | seller call this function is too many |
| 600001002 | try lock failed |


---

## Query Target Collaboration Detail — `GET /affiliate_seller/202508/target_collaborations/{target_collaboration_id}`

Doc: https://partner.tiktokshop.com/docv2/page/query-target-collaboration-detail-202508 · cập nhật 2026-10-28 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202508/target_collaborations/{target_collaboration_id}
### Method: [GET]
### Function Description
This API is used by Sellers to get target collaboration information.

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
| target_collaboration_id | string | Y | 1234 | The ID of the target collaboration |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202508/target_collaborations/1234?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^target_collaboration | object |  | Target Collaboration detail. |
| ^^id | string | 789078671231123124 | Target collaboration ID. |
| ^^name | string | target_collaboration | Target collaboration name. |
| ^^message | string | test | Message seller has sent to creators about seller's introduction and why excited to collaborate. |
| ^^seller_contact_info | object |  | Contact information for the seller in the target collaboration. |
| ^^^email | string | test@bytedance.com | Seller's email contact information. |
| ^^^phone_number | string | 1234 | The phone number of the seller. |
| ^^^whatsapp | string | aaaa | The phone number used by the seller to register for WhatsApp. |
| ^^^telegram | string | 1234 | The seller's Telegram username or phone number. |
| ^^^line | string | asd | The phone number used by the seller to register for the Line app |
| ^^start_time | int | 1715654330 | The start time of the target collaboration, as a Unix timestamp in seconds. |
| ^^end_time | int | 1715654330 | The end time of the target collaboration, as a Unix timestamp in seconds. |
| ^^update_time | int | 1715654330 | The update time of the target collaboration, as a Unix timestamp in seconds. |
| ^^creator_invited_count | int | 10 | The count of creators invited in the target collaboration. |
| The count will only include the NORMAL state. |  |  |  |
| ^^showcase_creator_count | int | 2 | This field indicates the number of creators who added the product to the showcase from target collaboration. |
| The count will only include the NORMAL state. |  |  |  |
| ^^content_creator_count | int | 1 | The number of creators who posted content featuring products from target collaboration. |
| The count will only include the NORMAL state. |  |  |  |
| ^^product_count | int | 30 | The count of products added in the target collaboration. |
| The count will only include the NORMAL state. |  |  |  |
| ^^free_sample_rule | object |  | The free sample rules set by the seller in the target collaboration. |
| ^^^has_free_sample | bool | true | If true, free samples are provided to creators invited to the target collaboration group. |
| ^^^is_sample_approval_exempt | bool | true | If true, creators invited to the target collaboration are exempt from seller review and will automatically be approved for a free sample. |
| Note that if has_free_sample=false, this field will not take effect. |  |  |  |
| ^^products | []object |  | The information of products in the target collaboration. |
| ^^^id | string | 789078671231312312 | The product identifier. |
| ^^^main_image_url | string | https://p16-sign-useast2a.tiktokcdn.com/tos-useast2a/12345~c5_168x168.webp?lk3s=a5d48078&nonce=49646&refresh_token=b53364a3a1947c4ac7a0c4bea62e31ea&x-expires=1727175600&x-signature=ASPIxFDNDkN1cknLEItlyC%2Bcfbw%3D&shp=a5d48078&shcp=39dffb78 | The product image url. |
|  |  |  |  |
| ^^^title | string | Christmas Gift | The product name. |
| ^^^original_price | object |  | The original price of the product. |
| ^^^^currency | string | USD | The currency code. |
| ^^^^minimum_amount | string | 12.21 | The lowest original price of all SKUs of the product. |
| ^^^^maximum_amount | string | 100.00 | The highest original price of all SKUs of the product. |
| ^^^commission | object |  | Commission info. |
| ^^^^rate | int | 3000 | The commission rate in hundredths of a percent. For example, 3587 is a commission rate of 35.87%. This value must a minimum of 1000. The range of this value is [100, 8000]. |
| ^^^^effective_time | string | 1715654330 | The time when the commission becomes effective, as a Unix timestamp in seconds represented as a string. |
| ^^^^currency | string | USD | The currency code. |
| ^^^^minimum_amount | string | 34.3 | The minimum estimated commission amount for all SKUs of this product. |
| ^^^^maximum_amount | string | 55.7 | The maximum estimated commission amount for all SKUs of this product. |
| ^^^^shop_ads_commission_rate | int | 100 | The commission rate applies only to orders generated from ads. If a creator’s video is used as an ad without this rate being set, the resulting orders will instead earn either: |

* The Shop Ads commission you configured in open collaboration, or
* The standard commission defined in this invitation.
   The commission rate is specified in increments of 1/10,000.
   For example, 1000 stands for 0.1 or 10%. |
   ^^^status |string |LIVE |Product's status.
   Field values:
* LIVE: When the product is normal for sale, return to the LIVE status
* OUT_OF_STOCK: When the product is out of stock for the consumer, the OUT_OF_STOCK state is returned
* SELLER_DEACTIVATE: When the product is deactivated by the merchant, the SELLER_DEACTIVATE status is returned
* PLATFORM_DEACTIVATE: When the product is deactivated by the platform or is not available for sale, the PLATFORM_DEACTIVATE status is returned
* GNE_REJECT: When the product is governed or the target collaboration is dismissed, the GNE_REJECT state is returned
* DELETE: When the product is deleted, the DELETE status is returned
* OTHER: When the product is in an unsaleable state, such as draft, frozen, review, etc, the OTHER status is returned |
   ^^^commission_effective_status |string |EFFECTIVE_ALL |The effectiveness of this product's target collaboration commission across creators.
   Field values:
* EFFECTIVE_ALL: The commission is effective for all creators.
* EFFECTIVE_PARTIALLY: The commission is effective for some creators.
* EFFECTIVE_NONE: The commission is not effective for any creators.
   Normally, the commission for a product will be the same for all creators.
   If the merchant participates in TOP_CREATOR_PROGRAM, and TOP_CREATOR_PROGRAM includes the current product and some creators, the commission rate will be based on TOP_CREATOR_PROGRAM. The product commission under the current Target Collaboration will be effective for some creators, corresponding to EFFECTIVE_PARTIALLY status. |
   ^^^collaboration_status |string |NORMAL |The status of the product in the current target cooperation.
   Field values:
* NORMAL: The status of the product in the current target collaboration is normal.
* DELETING: The status of the product in the current target collaboration is deleting.Product in the DELETING state will end their delayed effectiveness state and move to the DELETED state at 00:00 the next day.
* DELETED: The status of the product in the current target collaboration is deleted. |
   ^^creators |[]object | |The information of creators in the target collaboration. |
   ^^^username |string |123456 |The TikTok user name. |
   ^^^nickname |string |123456 |The TikTok nick name. |
   ^^^avatar |object | |Data associated with the TikTok creator's profile avatar. |
   ^^^^url |string |https://p16-sign-useast2a.tiktokcdn.com/tos-useast2a-avt-0068-giso/2bf6a2485ec8bf93483e4a6ed907e6fd~c5_720x720.webp?lk3s=a5d48078&x-expires=1712988000&x-signature=E8US22KfUCwKz0R%2FMFF6%2FMOmogs%3D |The URL for the TikTok creator's avatar image file. |
   ^^^selection_region |string |US |The regions in which the creator is eligible to promote products in showcases, videos, and live streams. |
   ^^^showcase_product_count |int |2 |This field indicates the number of products creator has added to the showcase from target collaboration.
   The count includes NORMAL and DELETING states. |
   ^^^content_product_count |int |1 |This field indicates the number of products creator has posted video or live from target collaboration.
   The count includes NORMAL and DELETING states. |
   ^^^collaboration_status |string |NORMAL |The status of the creator in the current target cooperation.
   Field values:
* NORMAL: The status of the creator in the current target collaboration is normal.
* DELETING: The status of the creator in the current target collaboration is deleting.The creator's product promotion relationship in the DELETING status will end the delayed effectiveness status and flow to the DELETED status at 00:00 the next day.
* DELETED: The status of the creator in the current target collaboration is deleted. |
   ^^^product_effective_status |string |EFFECTIVE_ALL |The effectiveness of the target collaboration's product commissions for this creator.
   Field values:
* EFFECTIVE_ALL: The commission is effective for this creator on all products in the target collaboration.
* EFFECTIVE_PARTIALLY: The commission is effective for this creator on some products in the target collaboration.
* EFFECTIVE_NONE: The commission is not effective for this creator on any products in the target collaboration.
   Normally, the commission rate for all products under Target Collaboration is effective.
   If the merchant participates in TOP_CREATOR_PROGRAM, and TOP_CREATOR_PROGRAM includes the current creator and some products, the commission rate will be based on TOP_CREATOR_PROGRAM. The products' commission under the current Target Collaboration will only be partially effective for the creator, corresponding to EFFECTIVE_PARTIALLY status. |
   ^^^creator_open_id |string |uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg |Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
   ^^type |string |STANDARD |The type of target collaboration.
   Field values:
* STANDARD: The target collaboration is created by sellers manually selecting products and creators.
* TOP_CREATOR_PROGRAM: The target collaboration created by seller joining TikTok Shop Top Creator Program, requiring only product submission. |

### Response Sample
```json
{"code":0,"data":{"target_collaboration":{"id":"789078671231123124","name":"target_collaboration","message":"test","seller_contact_info":{"email":"test@bytedance.com","phone_number":"1234","whatsapp":"aaaa","telegram":"1234","line":"asd"},"start_time":1715654330,"end_time":1715654330,"update_time":1715654330,"creator_invited_count":10,"showcase_creator_count":2,"content_creator_count":1,"product_count":30,"free_sample_rule":{"has_free_sample":true,"is_sample_approval_exempt":true},"products":[{"id":"789078671231312312","main_image_url":"https://p16-sign-useast2a.tiktokcdn.com/tos-useast2a/12345~c5_168x168.webp?lk3s=a5d48078\u0026nonce=49646\u0026refresh_token=b53364a3a1947c4ac7a0c4bea62e31ea\u0026x-expires=1727175600\u0026x-signature=ASPIxFDNDkN1cknLEItlyC%2Bcfbw%3D\u0026shp=a5d48078\u0026shcp=39dffb78","title":"Christmas Gift","original_price":{"currency":"USD","minimum_amount":"12.21","maximum_amount":"100.00"},"commission":{"rate":3000,"effective_time":"1715654330","currency":"USD","minimum_amount":"34.3","maximum_amount":"55.7","shop_ads_commission_rate":100},"status":"LIVE","commission_effective_status":"EFFECTIVE_ALL","collaboration_status":"NORMAL"}],"creators":[{"username":"123456","nickname":"123456","avatar":{"url":"https://p16-sign-useast2a.tiktokcdn.com/tos-useast2a-avt-0068-giso/2bf6a2485ec8bf93483e4a6ed907e6fd~c5_720x720.webp?lk3s=a5d48078\u0026x-expires=1712988000\u0026x-signature=E8US22KfUCwKz0R%2FMFF6%2FMOmogs%3D"},"selection_region":"US","showcase_product_count":2,"content_product_count":1,"collaboration_status":"NORMAL","product_effective_status":"EFFECTIVE_ALL","creator_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg"}],"type":"STANDARD"}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 50001700 | seller cannot access this target collaboration |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Conversation List — `GET /affiliate_seller/202412/conversations`

Doc: https://partner.tiktokshop.com/docv2/page/get-conversation-list-202412 · cập nhật 2026-10-28 · scope: seller.affiliate_messages.write

### Path: /affiliate_seller/202412/conversations
### Method: [GET]
### Function Description
Retrieve the seller's IM conversations.

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
| page_size | int | Y | 20 | Number of conversations to return per page. Range: 1–50. |
| page_token | string | N | 12345678 | Pagination cursor. Omit this parameter for the first request. For subsequent pages, use the `next_page_token` returned by the previous response. |
| only_need_conversation_id | bool | N | true | - If `true`, only `conversation_id` in `conversation` is returned. |

* If `false`, all fields in conversation`are returned.`true` by default. |
   conversation_status |string |N |UNREPLIED |Filter the returned IM conversations by status. If omitted, the API returns conversations from all statuses.

Possible values:

* `ALL`: Retrieve all conversations regardless of status.
* `UNREAD`: Retrieve conversations with messages the seller has not read. Messages remain unread until explicitly marked as read by calling [Mark Conversation Read](6791db761882810314a991a8); replying does not change the read status.
* `UNREPLIED`: Retrieve conversations in which the seller is not the last message sender.
* `STARRED`: Retrieve conversations the seller starred.
* `ARCHIVED`: Retrieve conversations the seller archived. |

### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| only_need_conversation_id | bool | N | true | - If `true`, only `conversation_id` in `data.conversation` is returned. |

* If `false`, all fields in `data.conversation` are returned.
   `true` by default. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202412/conversations?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_size=20&page_token=12345678&only_need_conversation_id=true&conversation_status=UNREPLIED
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^has_more | bool | true | Whether there are more conversations. |
| ^next_page_token | string | 12345678 | Pagination cursor for the next page. When `has_more` is `true`, pass this value as `page_token` in the next request. |
| ^conversations | []object |  | The conversation list. |
| ^^id | string | 12345678 | Conversation unique ID. |
| ^^unread_count | int | 2 | Number of unread messages. |
| ^^username | string | test_creator_name | The TikTok user name. |
| ^^avatar | string | https://p16-sign-useast2a.tiktokcdn.com/tos-useast2a-avt-0068-giso/2bf6a2485ec8bf93483e4a6ed907e6fd~c5_720x720.webp | The URL for the TikTok creator's avatar image file. |
| ^^creator_im_id | string | 12345678 | Creators' IM User ID. |
### Response Sample
```json
{"code":0,"data":{"has_more":true,"next_page_token":"12345678","conversations":[{"id":"12345678","unread_count":2,"username":"test_creator_name","avatar":"https://p16-sign-useast2a.tiktokcdn.com/tos-useast2a-avt-0068-giso/2bf6a2485ec8bf93483e4a6ed907e6fd~c5_720x720.webp","creator_im_id":"12345678"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Creator Conversation Messages — `GET /affiliate_seller/202412/conversation/{conversation_id}/messages`

Doc: https://partner.tiktokshop.com/docv2/page/get-creator-conversation-messages-202412 · cập nhật 2026-10-28 · scope: seller.affiliate_messages.write

### Path: /affiliate_seller/202412/conversation/{conversation_id}/messages
### Method: [GET]
### Function Description
Retrieves a page of messages from a conversation.

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
| conversation_id | string | Y | 1234567890 | The identifier of a conversation that belongs to the current seller. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| page_size | int | Y | 20 | The maximum number of messages to return. Must be between 1 and 20. |
| page_token | string | N | 1735032460678899 | The pagination cursor. Omit this parameter for the first request. When `has_more` is `true`, pass the previous response's `next_page_token` to retrieve the next page. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202412/conversation/1234567890/messages?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_size=20&page_token=1735032460678899
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^has_more | bool | true | Whether there are any more messages. |
| ^next_page_token | string | 1735032460678899 | When `has_more` is `true`, pass this cursor as `page_token` in the next request. It is empty when `has_more` is `false`. |
| ^messages | []object |  |  |
| ^^conversation_index | string | 1735032460678899 | Index of the message in the conversation. Higher index corresponds to newer message. |
| ^^message_body | object |  | Message's content |
| ^^^id | string | 7451907556216407553 | Message ID. |
| ^^^conversation_id | string | 7451873679308620048 | Conversation ID to which the message belongs. |
| ^^^type | string | TEXT | Message type. Possible values: |

* TEXT
* PRODUCT_CARD
* TARGET_COLLABORATION_CARD
* FREE_SAMPLE_CARD
* IMAGE
* CRM_TEXT_WITH_IMAGE_CARD
* CRM_TEXT_WITH_PRODUCTS_CARD
* NOTIFICATION
* EMOTICONS
* SYSTEM |
   ^^^content |string |{"content": "simple text message"} |Message content serialized as a JSON string. The JSON object depends on `type`:
* `TEXT`: `{"content": "simple text"}`
* `PRODUCT_CARD`: `{"product_id": "12345"}`
* `TARGET_COLLABORATION_CARD`: `{"invitation_group_id": "1234"}`
* `FREE_SAMPLE_CARD`: `{"apply_id": "1234"}`
* `IMAGE`: `{"height": "290", "url": "<image_url>", "width": "304"}`
* `CRM_TEXT_WITH_IMAGE_CARD`: `{"title": "abc", "content": "efg", "url": "<image_url>"}`
* `CRM_TEXT_WITH_PRODUCTS_CARD`: `{"title": "abc", "content": "efg", "product_ids": [123, 456, 789, 222]}`
* `NOTIFICATION` or `SYSTEM`: `{"content": "notification/system message"}`
* `EMOTICONS`: `{"height": "110", "url": "<image_url>", "width": "110"}` |
   ^^^create_time |int |1691411573 |Message creation time, represented as a Unix timestamp (seconds). |
   ^^^sender_id |string |2368694990397660924 |The message sender im id |

### Response Sample
```json
{"code":0,"data":{"has_more":true,"next_page_token":"1735032460678899","messages":[{"conversation_index":"1735032460678899","message_body":{"id":"7451907556216407553","conversation_id":"7451873679308620048","type":"TEXT","content":"{\"content\": \"simple text message\"}","create_time":1691411573,"sender_id":"2368694990397660924"}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Latest Unread Messages — `GET /affiliate_seller/202412/conversations/messages/list/newest`

Doc: https://partner.tiktokshop.com/docv2/page/get-latest-unread-messages-202412 · cập nhật 2026-10-13 · scope: seller.affiliate_messages.write

### Path: /affiliate_seller/202412/conversations/messages/list/newest
### Method: [GET]
### Function Description
Get the unread messages from the last minute.
You are recommended to use the Webhook, New Message Listener, for the message notification.

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
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202412/conversations/messages/list/newest?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^newest_message_list | []object |  | The list of unread messages from the last minute. |
| ^^conversation_id | string | 12345 | The converastion id to which the message belongs |
| ^^content | string | {"content": "simple text message"} | Message content as a JSON-serialized string. Parse the string as a JSON object; its shape depends on `type`: |

* `TEXT`: `{"content": "simple text"}`
* `PRODUCT_CARD`: `{"product_id": "12345"}`
* `TARGET_COLLABORATION_CARD`: `{"invitation_group_id": "1234"}`
* `FREE_SAMPLE_CARD`: `{"apply_id": "1234"}`
* `IMAGE`: `{"height": "290", "url": "<image URL>", "width": "304"}`
* `CRM_TEXT_WITH_IMAGE_CARD`: `{"title": "abc", "content": "efg", "url": "<image URL>"}`
* `CRM_TEXT_WITH_PRODUCTS_CARD`: `{"title": "abc", "content": "efg", "product_ids": [123, 456, 789, 222]}`
* `NOTIFICATION` or `SYSTEM`: `{"content": "notification or system message"}`
* `EMOTICONS`: `{"height": "110", "url": "<image URL>", "width": "110"}` |
   ^^type |string |TEXT |Message type. Possible values:
* TEXT
* PRODUCT_CARD
* TARGET_COLLABORATION_CARD
* FREE_SAMPLE_CARD
* IMAGE
* CRM_TEXT_WITH_IMAGE_CARD
* CRM_TEXT_WITH_PRODUCTS_CARD
* NOTIFICATION
* EMOTICONS
* SYSTEM |
   ^^sender_id |string |12345678 |sender's IM id |
   ^^unread_message_count |int |1 |The number of unread messages of the sender in the conversation. |

### Response Sample
```json
{"code":0,"data":{"newest_message_list":[{"conversation_id":"12345","content":"{\"content\": \"simple text message\"}","type":"TEXT","sender_id":"12345678","unread_message_count":1}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get or Create Creator Conversation — `POST /affiliate_seller/202508/conversations`

Doc: https://partner.tiktokshop.com/docv2/page/get-or-create-creator-conversation-202508 · cập nhật 2026-10-28 · scope: seller.affiliate_messages.write

### Path: /affiliate_seller/202508/conversations
### Method: [POST]
### Function Description
Get the existing conversation or create a new conversation with the specified TikTok creator. To send a message in the conversation, pass the returned `data.conversation_id` as the `conversation_id` path parameter of Send IM Message (`POST /affiliate_seller/202412/conversations/{conversation_id}/messages`).

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
| creator_open_id | string | Y | uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg | The creator's Open ID. Use the Open ID returned by the relevant API, not a user ID, creator ID, or seller ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
| only_need_conversation_id | bool | N | true | - If `true`, only `conversation_id` in `data.conversation` is returned. |

* If `false`, all fields in `data.conversation` are returned.
   `true` by default. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202508/conversations?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"creator_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg","only_need_conversation_id":true}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^conversation_id | string | 1234567890 | The unique ID of the conversation. |
| ^is_new | bool | true | Whether this is a new conversation. |
| ^username | string | test_creator_name | The TikTok creator's username. |
| ^avatar | string | https://p16-sign-useast2a.tiktokcdn.com/tos-useast2a-avt-0068-giso/2bf6a2485ec8bf93483e4a6ed907e6fd~c5_720x720.webp | The URL for the TikTok creator's avatar image file. |
| ^unread_count | int | 2 | Number of messages unread by the shop. |
| ^creator_im_id | string | 12345678 | Creators' IM User ID. |
### Response Sample
```json
{"code":0,"data":{"conversation_id":"1234567890","is_new":true,"username":"test_creator_name","avatar":"https://p16-sign-useast2a.tiktokcdn.com/tos-useast2a-avt-0068-giso/2bf6a2485ec8bf93483e4a6ed907e6fd~c5_720x720.webp","unread_count":2,"creator_im_id":"12345678"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16030001 | creator has been cleard |
| 16030002 | shop has reached IM quota. More information please check [https://seller.tiktokglobalshop.com/university/essay?identity=1&role=1&knowledge_id=2766765165102865&from=feature_guide] |
| 16030003 | This shop cannot message the creator at the moment because the Affiliate GMV requirement has not been met. |
| 16030007 | shop status invalid |
| 16030009 | test account isolate. please don't use the test account to send message. |
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 45101021 | unauthorized operation on users who hit privacy control |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Upload Message Image — `POST /affiliate_seller/202511/images/upload`

Doc: https://partner.tiktokshop.com/docv2/page/upload-message-image-202511 · cập nhật 2026-10-13 · scope: seller.affiliate_messages.write

### Path: /affiliate_seller/202511/images/upload
### Method: [POST]
### Function Description
You must use this API to upload the image first, before sending an image as a message using [Send IM Messsage](https://partner.tiktokshop.com/docv2/page/send-im-message-202412)

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | multipart/form-data | Allowed type: multipart/form-data |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| data | file | Y |  | The format of the image must be jpg, gif, webp, or png. The size of the image must not exceed 10MB. Zero-byte files are rejected. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202511/images/upload?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^url | string | https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/2ca53c34ad8443e6b39f4e0153d3aed4~tplv-o3syd03w52-origin-image.image?from=1320446476 | Image URL |
| ^width | int | 1280 | Image width in pixels. |
| ^height | int | 720 | Image height in pixels. |
### Response Sample
```json
{"code":0,"data":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/2ca53c34ad8443e6b39f4e0153d3aed4~tplv-o3syd03w52-origin-image.image?from=1320446476","width":1280,"height":720},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 45101001 | Internal error. Please try again later or contact the technical support team for help. |


---

## Send IM Message — `POST /affiliate_seller/202412/conversations/{conversation_id}/messages`

Doc: https://partner.tiktokshop.com/docv2/page/send-im-message-202412 · cập nhật 2026-10-28 · scope: seller.affiliate_messages.write

### Path: /affiliate_seller/202412/conversations/{conversation_id}/messages
### Method: [POST]
### Function Description
Sends a message of the selected type in the specified conversation.

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
| conversation_id | string | Y | 1234 | conversation_id |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| msg_type | string | Y | TEXT | Message type. The value determines the decoded JSON object required in `content`. Possible values: |

* `TEXT`
* `PRODUCT_CARD`
* `TARGET_COLLABORATION_CARD`
* `FREE_SAMPLE_CARD`
* `IMAGE`
* `CRM_TEXT_WITH_IMAGE_CARD`
* `CRM_TEXT_WITH_PRODUCTS_CARD` |
   content |string |Y |{"content": "simple text message"} |Message content as a JSON-serialized string. The decoded JSON object depends on `msg_type`:
* `TEXT`: `{"content": "simple text"}`. `content` is required, must not be empty, and supports up to 2,000 Unicode characters.
* `PRODUCT_CARD`: `{"product_id": "12345"}`. `product_id` is required.
* `TARGET_COLLABORATION_CARD`: `{"target_collaboration_id": "1234"}`. `target_collaboration_id` is required and is the invitation group ID.
* `FREE_SAMPLE_CARD`: `{"apply_id": "1234"}`. `apply_id` is required.
* `IMAGE`: `{"url": "https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/2ca53c34ad8443e6b39f4e0153d3aed4~tplv-o3syd03w52-origin-image.image?from=1320446476", "width": 1280, "height": 720}`. `url`, `width`, and `height` are required; `width` and `height` must be integers. You can obtain `url` by calling [Upload Messages Image](https://partner.tiktokshop.com/docv2/page/upload-message-image-v2-202608).
* `CRM_TEXT_WITH_PRODUCTS_CARD`: `{"product_ids": "12345,123456", "title": "abc", "content": "abc"}`. `product_ids` is required and contains one to five comma-separated positive product IDs. `content` is required, must not be empty, and supports up to 500 Unicode characters. `title` supports up to 50 Unicode characters.
* `CRM_TEXT_WITH_IMAGE_CARD`: `{"image_url": "https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/2ca53c34ad8443e6b39f4e0153d3aed4~tplv-o3syd03w52-origin-image.image?from=1320446476", "title": "abc", "content": "abc"}`. `image_url` and `content` are required. `content` must not be empty and supports up to 500 Unicode characters. `title` supports up to 50 Unicode characters. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202412/conversations/1234/messages?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"msg_type":"TEXT","content":"{\"content\": \"simple text message\"}"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^message_id | string | 1234444 | The message ID. The `message_id` field is not always returned upon successful message submission. |
### Response Sample
```json
{"code":0,"data":{"message_id":"1234444"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16030100 | Shop has reached IM send message quota with this creator |
| 16030101 | Seller account is abnormal or you can't contact this creator because shop level didn't meet the GMV requirement. |
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 45101004 | The query quota has been reached (10000 request per day). Please try again tomorrow. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Mark Conversations as Read — `POST /affiliate_seller/202412/conversatons/read`

Doc: https://partner.tiktokshop.com/docv2/page/mark-conversations-as-read-202412 · cập nhật 2026-10-28 · scope: seller.affiliate_messages.write

### Path: /affiliate_seller/202412/conversatons/read
### Method: [POST]
### Function Description
Mark the messages in the specified conversations to be read.

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
| conversation_ids | []string | Y | [576486316948490001] | The array of conversations to read. |
| After the API is called, all the messages in the specified conversations will be read, and the read timestamp is set to the time when the API is called. |  |  |  |  |
| The length of the array must not exceed `20`. |  |  |  |  |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202412/conversatons/read?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"conversation_ids":[576486316948490000]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^failed_conversation_ids | []string | ["123"] | The conversation IDs that could not be marked as read. Retry the request using only these IDs. |
### Response Sample
```json
{"code":0,"data":{"failed_conversation_ids":["123"]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Search Sample Applications — `POST /affiliate_seller/202508/sample_applications/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-sample-applications-202508 · cập nhật 2026-10-28 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202508/sample_applications/search
### Method: [POST]
### Function Description
This API is provided for sellers to query sample applications based on various criteria such as products, creators, or application statuses. By using this API, sellers can retrieve detailed information about sample application records, including the creator's information and the specifics of each application.

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
| page_token | string | N | b2Zmc2V0PTAK | Pagination offset determines where you begin to search for. It's empty when raise your first request. |
| page_size | int | N | 50 | The value of "page_size" must be greater than 0 and less than or equal to 50. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| product_id | string | N | 123456 | The unique identifier of a product. It is used to specify which product's sample application details are being queried. |
| title | string | N | product name | Product name, supports fuzzy search queries. It allows sellers to search for products by name when managing sample applications. |
| creator_user_oepn_id | string | N | 123456 | The creator's Open ID. Do not use a user ID, creator ID, or seller ID. Send this property as `creator_user_oepn_id` exactly as spelled; do not change the wire key to `creator_user_open_id`. |
| username | string | N | test_tt_name | TikTok User Name of a creator, supports fuzzy search |
| target_collabration_id | string | N | 123456 | The unique ID generated after creating a target collaboration. Send this property as `target_collabration_id` exactly as spelled; do not change the wire key to `target_collaboration_id`. |
| order_id | string | N | 123456 | Main order ID associated with a sample order when the sample application is approved by seller. |
| status | string | N | PENDING | The status of sample applications. |
| The possible enumerated values are: |  |  |  |  |

* PENDING: The sample application is waiting for the seller's review.
* AWAITING_SHIPMENT: The application is approved, and the seller needs to ship the sample.
* SHIPPED: The sample has been shipped by the seller and is waiting for the creator to receive the package.
* CONTENT_PENDING: The creator has received the sample package and is expected to create content.
* REJECT_CANCELLED: The sample application has been rejected by the seller.
* OVERDUE_CANCELLED: The sample application has expired due to being overdue.
* UNFULFILL_CANCELLED: The creator did not fulfill the commitment to create content within the agreed timeframe.
* DEL_OPEN_COLLAB: Open collaboration has been deleted.
* SELLER_NOT_SHIP_CANCELLED: The seller did not ship the sample within the required timeframe.
* WITHDRAW_CANCELLED: The creator withdrew the sample application before the seller approved it.
* UNFULFILLABLE_CANCELLED: The application was cancelled due to reasons beyond the creator's control, making it impossible to create content.
* OPS_CANCELLED: The application was manually cancelled by operations staff.
* OPS_FAILED: The application was marked as failed by operations staff.
* OPS_COMPLETED: The application was manually marked as completed by operations staff.
* COMPLETED: The application is complete, and the creator has posted the content.
   This field allows for tracking the status of a sample application throughout its lifecycle, providing visibility into each stage of the process for sellers and creators. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202508/sample_applications/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_token=b2Zmc2V0PTAK&page_size=50
```

**Body**
```json
{"product_id":"123456","title":"product name","creator_user_oepn_id":"123456","username":"test_tt_name","target_collabration_id":"123456","order_id":"123456","status":"PENDING"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^next_page_token | string | b2Zmc2V0PTUw | The pagination token to pass as `page_token` in the next request. Reuse the same `page_size` for each subsequent page. An empty string indicates that there are no more pages. |
| ^total_count | int | 100 | total count |
| ^sample_applications | []object |  | The sample applications from creators |
| ^^id | string | 123456 | The unique id of sample request application ID |
| ^^commission_rate | string | 0.20 | The commission rate set by the merchant for creators for this product, represented as a decimal fraction with two decimal places. For example, `0.20` represents 20%. The range is [0.01, 0.8]. |
| ^^status | string | PENDING | The status of sample applications. |
| The possible enumerated values are: |  |  |  |

* PENDING: The sample application is waiting for the seller's review.
* AWAITING_SHIPMENT: The application is approved, and the seller needs to ship the sample.
* SHIPPED: The sample has been shipped by the seller and is waiting for the creator to receive the package.
* CONTENT_PENDING: The creator has received the sample package and is expected to create content.
* REJECT_CANCELLED: The sample application has been rejected by the seller.
* OVERDUE_CANCELLED: The sample application has expired due to being overdue.
* UNFULFILL_CANCELLED: The creator did not fulfill the commitment to create content within the agreed timeframe.
* DEL_OPEN_COLLAB: The open collaboration plan has been deleted.
* SELLER_NOT_SHIP_CANCELLED: The seller did not ship the sample within the required timeframe.
* WITHDRAW_CANCELLED: The creator withdrew the sample application before the seller approved it.
* UNFULFILLABLE_CANCELLED: The application was cancelled due to reasons beyond the creator's control, making it impossible to create content.
* OPS_CANCELLED: The application was manually cancelled by operations staff.
* OPS_FAILED: The application was marked as failed by operations staff.
* OPS_COMPLETED: The application was manually marked as completed by operations staff.
* COMPLETED: The application is complete, and the creator has finished creating the content. |
   ^^order_id |string |123456 |The sample order is generated after the sample application is approved by seller |
   ^^available_quantity |int |50 |The remaining stock quota of a sample product. |
   ^^approve_expiration_time |int |1728674995 |The seller approval deadline for the sample application, expressed as a Unix timestamp in seconds. |
   ^^shipment_expiration_time |int |1728674995 |The deadline for the seller to ship the sample for the application, expressed as a Unix timestamp in seconds. |
   ^^tracking_number |string |123456 |The logistics tracking number for the sample application order |
   ^^fulfillment_status |string |ONGOING |It indicates the current status of the fulfillment process. The possible values are:
* PENDING: The creator is yet to fulfill the content creation obligation.
* ONGOING: Fulfillment is in progress; content has been created and is being evaluated against criteria.
* SUCCEED: Fulfillment has been successfully completed; the content meets the required standards.
* FAILED: Fulfillment failed; the content did not meet the required standards.
* OVERDUE: Fulfillment is overdue; the creator did not meet the deadline.
* SUSPEND: Fulfillment has been suspended.
* CANCELLED: Fulfillment has been cancelled, either by the creator or due to operational reasons.
* EXEMPTED: The creator has been exempted from the fulfillment obligation. |
   ^^is_approvable |bool |true |The sample application can be approved or not. |
   ^^disapprovable_reasons |[]string |["Product out of stock"] |Reasons the sample application cannot be approved. This list may be absent or empty even when `is_approvable` is `false`; always check `is_approvable` to determine whether approval is allowed. |
   ^^partner_name |string |ABC |The name of the partner if the sample application is submitted on behalf of a creator by an agency. It is only populated when an agency handles the application process instead of the creator directly. |
   ^^creator |object | |Creator details, including the creator's TikTok username, Creator Open ID, profile information, and e-commerce performance metrics such as sales and fulfillment rates. |
   ^^^creator_open_id |string |uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg |Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
   ^^^username |string |test.name |TikTok User Name of a creator |
   ^^^nickname |string |Test Name |TikTok Nick Name of a creator |
   ^^^follower_count |int |200 |The number of creator's followers |
   ^^^avatar_url |string |https://p16-sign-va.tiktokcdn.com/tos-maliva-avt-0068xxxxx |The URL of the creator's avatar image |
   ^^^gmv |object | |GMV generated by a creators' shoppable content over the past 30 days. It is formatted as a floating-point number with a currency symbol (e.g., "$1234.56"). If the creator has not authorized the disclosure of this information, the field returns an empty string. |
   ^^^^amount |string |500 |GMV amount |
   ^^^^currency |string |USD |The currency code for the GMV amount. |
   ^^^content_count |int |4 |The number of contents a creator has posted in the last 30 days. It is formatted as an integer. If the creator has not authorized the sharing of this information, the field returns an empty string. |
   ^^^fulfillment_percentage |string |60.50 |The creator's sample fulfillment rate over the past 90 days, returned as a percentage string with no percent sign (for example, `60.85`). If the creator has not authorized disclosure of this information, the field returns an empty string. |
   ^^^ec_video_view |int |1200 |The median number of creators' shoppable video views over the past 30 days. If the creator has not authorized the sharing of this information, the field returns an empty string. |
   ^^product |object | |product information |
   ^^^id |string |123456 |The product identifier. |
   ^^^title |string |A women dress |The product name of the product. |
   ^^^sku_id |string |123456 |The unique id of product sku which creator apply for as sample. |
   ^^^sku_image_url |string |https://p16-oec-va.ibyteimg.com/tos-malivaxxxxx |The URL of SKU image. |
   ^^^sku_name |string |Soft Cover |The SKU property value names, joined by commas. |

### Response Sample
```json
{"code":0,"data":{"next_page_token":"b2Zmc2V0PTUw","total_count":100,"sample_applications":[{"id":"123456","commission_rate":"0.20","status":"PENDING","order_id":"123456","available_quantity":50,"approve_expiration_time":1728674995,"shipment_expiration_time":1728674995,"tracking_number":"123456","fulfillment_status":"ONGOING","is_approvable":true,"disapprovable_reasons":["Product out of stock"],"partner_name":"ABC","creator":{"creator_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg","username":"test.name","nickname":"Test Name","follower_count":200,"avatar_url":"https://p16-sign-va.tiktokcdn.com/tos-maliva-avt-0068xxxxx","gmv":{"amount":"500","currency":"USD"},"content_count":4,"fulfillment_percentage":"60.50","ec_video_view":1200},"product":{"id":"123456","title":"A women dress","sku_id":"123456","sku_image_url":"https://p16-oec-va.ibyteimg.com/tos-malivaxxxxx","sku_name":"Soft Cover"}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Review a Sample Application — `POST /affiliate_seller/202507/sample_applications/{application_id}/review`

Doc: https://partner.tiktokshop.com/docv2/page/review-a-sample-application-202507 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.write

### Path: /affiliate_seller/202507/sample_applications/{application_id}/review
### Method: [POST]
### Function Description
This API allows the seller to approve or reject a creator's sample application in an open collaboration. Only applications in the PENDING status can be approved or rejected. When rejecting an application, the seller must provide a supported rejection reason.

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
| application_id | string | Y | 8070747592760922552 | The unique id of sample request application ID |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| review_result | string | Y | APPROVE | The review action to take on the sample application. Possible values: |

* APPROVE: Approves the sample application.
* REJECT: Rejects the sample application. |
   reject_reason |string |N |NOT_MATCH |The reason why a seller rejected a creator's sample application. The possible enumerated values are:
* NOT_MATCH: The creator does not meet the seller's collaboration requirements.
* OFFLINE: The product has been taken offline.
* OUT_OF_STOCK: The product is temporarily out of stock.
* OTHER: Any other reason not covered by the above categories.
   Required if the review_result is set to REJECT
   This field allows the seller to specify the reason for rejecting a sample application, providing clarity to the creator regarding the rejection. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202507/sample_applications/8070747592760922552/review?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"review_result":"APPROVE","reject_reason":"NOT_MATCH"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
### Response Sample
```json
{"code":0,"data":{},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16022020 | seller has no permission to operate agency's sample request |


---

## Search Sample Application Fulfillments — `POST /affiliate_seller/202409/sample_applications/{application_id}/fulfillments/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-sample-application-fulfillments-202409 · cập nhật 2026-10-28 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202409/sample_applications/{application_id}/fulfillments/search
### Method: [POST]
### Function Description
You, the seller, can use this API to get the fulfillment status of the specific sample application and whether the fulfillment resulted in orders. This allows Sellers to track the current progress or analyze the results of their sample distribution program.

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
| application_id | string | Y | 123456789 | The application identifier. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| content_format | string | N | LIVE | The content type generated by the creator after receiving the samples. Possible enumerations: |

* LIVE
* VIDEO |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202409/sample_applications/123456789/fulfillments/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"content_format":"LIVE"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^fulfillments | []object |  | Fulfillments |
| ^^product | object |  | Product information |
| ^^^id | string | 123456 | The product identifier. |
| ^^^main_image_url | string | https://www.example.com | The cover image url of product. |
| ^^content | object |  | Fulfillment content information. |
| ^^^id | string | 123456 | The video or live room identifier. |
| ^^^format | string | LIVE | The format of the generated content: |

* LIVE
* `VIDEO` |
   ^^^url |string |https://www.example.com |The content source link. |
   ^^^view_count |int |100 |The cumulative number of views of the content. |
   ^^^like_count |int |123 |The cumulative number of likes on the content. |
   ^^^comment_count |int |10 |The cumulative number of comments on the content. |
   ^^^paid_order_count |int |1 |The cumulative total number of orders paid for content. |
   ^^^page_link |string |https://www.example.com |Content page url of TikTok. |
   ^^^description |string |abc def gh |The title of video or the description of the live room. |
   ^^^create_time |int |1723529426 |- When `format` is `VIDEO`, this is the Unix timestamp, in seconds, when the video is first made public and linked to the product.
* When `format` is `LIVE`, this is the Unix timestamp, in seconds, when the product link is first added to the live stream. |
   ^^^live_end_time |int |1723529426 |Only when `format==LIVE`.
   It refers to the time when the product link is removed from the live room. If the product link remains active and is not removed, then it is the end of the live stream. |

### Response Sample
```json
{"code":0,"data":{"fulfillments":[{"product":{"id":"123456","main_image_url":"https://www.example.com"},"content":{"id":"123456","format":"LIVE","url":"https://www.example.com","view_count":100,"like_count":123,"comment_count":10,"paid_order_count":1,"page_link":"https://www.example.com","description":"abc def gh","create_time":1723529426,"live_end_time":1723529426}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Generate Target Collaboration Link — `POST /affiliate_seller/202509/target_collaboration/{target_collaboration_id}/link`

Doc: https://partner.tiktokshop.com/docv2/page/generate-target-collaboration-link-202509 · cập nhật 2026-03-25 · scope: seller.affiliate_collaboration.write

### Path: /affiliate_seller/202509/target_collaboration/{target_collaboration_id}/link
### Method: [POST]
### Function Description
Generate a Target Collaboration Link that the seller can share with the creator. This link directs the creator to a guided flow to review details and formally accept the target collaboration

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
| target_collaboration_id | string | Y | 123 | Target collaboration ID. |
|  |  |  |  |  |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202509/target_collaboration/123/link?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
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
| ^link | string | https://affiliate-id.tokopedia.com/api/v1/oec/affiliate/seller/invitation_group/share/long_url/AJBNfIPZXGcc | The link of the target invitation, the creator can jump to the page of adding products after clicking. |
### Response Sample
```json
{"code":0,"data":{"link":"https://affiliate-id.tokopedia.com/api/v1/oec/affiliate/seller/invitation_group/share/long_url/AJBNfIPZXGcc"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Generate Affiliate Product Promotion Link — `POST /affiliate_seller/202405/products/{product_id}/promotion_link/generate`

Doc: https://partner.tiktokshop.com/docv2/page/generate-affiliate-product-promotion-link-202405 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.write

### Path: /affiliate_seller/202405/products/{product_id}/promotion_link/generate
### Method: [POST]
### Function Description
Partner developers acting on behalf of sellers use this API to generate an affiliate-exclusive promotion link for a specific open-collaboration product, identified by `product_id`, in the TikTok Shop Affiliate Product Marketplace.
The partner developer can distribute the generated link to creators. A creator can use the link to add the product to the creator's showcase. If a creator adds the product to a showcase through this link, subsequent consumer purchases can be attributed to the partner.

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
| product_id | string | Y | 789078671231 | The product identifier. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202405/products/789078671231/promotion_link/generate?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
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
| ^product_promotion_link | string | https://www.example.com/t/acibsnsgSIngls | The URL for a web page with information about the product promotion. |
### Response Sample
```json
{"code":0,"data":{"product_promotion_link":"https://www.example.com/t/acibsnsgSIngls"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16015001 | Invalid parameter, the product Ids are not correct. Please ensure the products are in the showcase right now. |
| 16015014 | get product meta failed |


---

## Seller Get Sample Request Deeplink — `GET /affiliate_seller/202512/sample_applications/deeplink`

Doc: https://partner.tiktokshop.com/docv2/page/seller-get-sample-request-deeplink-202512 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202512/sample_applications/deeplink
### Method: [GET]
### Function Description
Use this API to get a TikTok deeplink, use this deeplink to launch the TikTok app and land the user on the sample request page.

* The seller can encode the deeplink into an QR code and send it to a creator via email.

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
| product_id | string | Y | 123456 | The ID of a product that belongs to the authenticated shop. If neither `campaign_id` nor `collaboration_id` is provided, the product must be in an active open collaboration. |
| sku_id | string | Y | 123456 | The ID of a SKU that belongs to the product identified by `product_id`. |
| campaign_id | string | N | 3939495 | If the product belongs to a TAP campaign, `campaign_id` is required. The specified campaign must be active and contain the product identified by `product_id`. |
Supported campaign types:

* `MY_CAMPAIGNS`
* `SELLER_CAMPAIGNS` |
   collaboration_id |string |N |710240393 |If the product belongs to a seller collaboration, `collaboration_id` is required. Do not provide `collaboration_id` together with `campaign_id`. |
   valid_days |int |N |14 |7 days by default.
   14 days maximum.
   1 day minimum. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202512/sample_applications/deeplink?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&product_id=123456&sku_id=123456&campaign_id=3939495&collaboration_id=710240393&valid_days=14
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^deeplink | string | snssdk1180://roma_redirect/?*pia*=1&app_key=aaaa&callback_dp_key=f3318dbad42e495eaa12f3b9bec5af92&enter_from=deeplink&product_id=1729504817131129797&roma_group_key=spark_page_seller_free_sample_apply&roma_page_key=p&sample_apply_source=1&sku_id=1729504817131195333&spark_page=seller_free_sample_apply&track_data=%7B%22is_from_selection_scenarios%22%3A%221%22%2C%22selection_channel%22%3A%22deeplink%22%7D | Use this deeplink to invoke TikTok: |
|  |  |  |  |
### Response Sample
```json
{"code":0,"data":{"deeplink":"snssdk1180://roma_redirect/?_pia_=1\u0026app_key=aaaa\u0026callback_dp_key=f3318dbad42e495eaa12f3b9bec5af92\u0026enter_from=deeplink\u0026product_id=1729504817131129797\u0026roma_group_key=spark_page_seller_free_sample_apply\u0026roma_page_key=p\u0026sample_apply_source=1\u0026sku_id=1729504817131195333\u0026spark_page=seller_free_sample_apply\u0026track_data=%7B%22is_from_selection_scenarios%22%3A%221%22%2C%22selection_channel%22%3A%22deeplink%22%7D"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Search Seller Affiliate Orders — `POST /affiliate_seller/202410/orders/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-seller-affiliate-orders-202410 · cập nhật 2026-10-23 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202410/orders/search
### Method: [POST]
### Function Description
This API allows the partner to retrieve a list of affiliate orders (orders which are affiliate-commission eligible) generated by a seller, returning the order ID and the product ID. Using this, the partner can track their affiliate-conversions on behalf of a seller, using the order ID.

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
| page_token | string | N | b2Zmc2V0PTAK | An opaque token used to retrieve the next page of a paginated result set. Retrieve this value from the result of the `next_page_token` from a previous response. It is not needed for the first page. |
| page_size | int | Y | 20 | The number of results to be returned per page. Default: 20 |
| Valid Range: [1-100] |  |  |  |  |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| create_time_lt | int | N | 1722485856 | Filter orders to show only those that are created before the specified date and time. Unix timestamp.Refer to notes in `create_time_ge` for more usage information. Please note that we only support 3 montns' data at maximum for each single request |
| create_time_ge | int | N | 1719807456 | Filter orders to show only those that are created on or after the specified date and time. Unix timestamp. |
Note:
`create_time_ge` and `create_time_lt` together constitute the creation time filter condition.

* If `create_time_ge` is filled but `create_time_lt` is empty, `create_time_lt` will default to the current time.
* If `create_time_lt` is filled but `create_time_ge` is empty, `create_time_ge` will default to the earliest shop time.
   If both are not specified, data from the last three months will be queried by default. |
   program_id |string |N |73661290629 |Filter orders by the associated affiliate program which refer to your agency partner's campaign ID. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202410/orders/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_token=b2Zmc2V0PTAK&page_size=20
```

**Body**
```json
{"create_time_lt":1722485856,"create_time_ge":1719807456,"program_id":"73661290629"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^orders | []object |  | The returned list of orders. |
| ^^id | string | 579125529499110202 | The order ID. |
| ^^delivery_time | int | 1723748656 | The date and time when the order was delivered. Unix timestamp. |
| ^^create_time | int | 1722420186 | The date and time when the order was created. Unix timestamp. |
| ^^status | string | COMPLETED | Field depreciated, we won't return the value. For your skus settlement status, please find below settle_status. |
| ^^skus | []object |  | The list of SKUs that are included in this order. |
| ^^^sku_id | string | 1729791975232997145 | The ID of your SKU |
| ^^^settlement_status | string | SETTLED | The current settlement status of the sku order. Possible options are: |

* Unknown: The status of the order is undefined. It might be updated later.
* AWAITING PAYMENT：The order hasn't been paid by customer yet, only estimated commission is available
* To-SETTLE：The order is waiting for settlement, only estimated commission is available
* SETTLED: The commission of the order is already settled.
* INELIGIBLE: The order has been returned/refunded/canceled by the buyer, and no commission will be settled. |
   ^^^open_collaboration_id |string |73661290629 |The ID of the open collaboration in which the product is enrolled. |
   ^^^target_collaboration_id |string |73661290629 |The ID of the target collaboration in which the product is enrolled. |
   ^^^campaign_id |string |73661290629 |The ID of the TAP campaign in which the product is enrolled. |
   ^^^creator_username |string |exampleTikTokCreatorUsername |The username of the creator that's participating in the specified open collaboration. |
   ^^^price |object | |The SKU selling price information. |
   ^^^^amount |string |1000 |The price amount. |
   ^^^^currency |string |VND |The price currency. |
   ^^^quantity |int |1 |The SKU quantity for the order. |
   ^^^content_type |string |LIVE |The content format of the creator content through which the order was created.
   Possible values:
* SHOP
* VIDEO
* LIVE
* PRE_LIVE
* PROMOTION_PAGE
* LINKSHARE |
   ^^^content_id |string |7493990579714164574 |The content identifier. |
   ^^^product_id |string |1729503179457070324 |The product ID in TikTok Shop. |
   ^^^commission_model |string |Tiered commission |Determine order commission be calculated based on fixed commission model or tiering
   model |
   ^^^commission_tier_setting |string |3.0 OR 5.0 |Between Seller & Creator percentagecommission. When tiering commission model applied, will return each tier's commission rate seller set. |
   ^^^commission_rate |string |1000 |The commission rate established by the seller to be paid to creators involved in the collaboration, expressed in hundredths of a percent. For example, 1550 represents a commission rate of 15.50%. Please note that we only return the value when this order is directly generated from your creator. If you are working with partner, please refer to partner_commission_rate. |
   ^^^partner_commission_rate |string |1000 |The commission rate established by the seller to be paid to affiliate partner involved in the collaboration, expressed in hundredths of a percent. For example, 1550 represents a commission rate of 15.50%. |
   ^^^shop_ads_commission_rate |string |5000 |The commission rate for orders generated through Shop Ads. |
   ^^^estimated_commission_base |object | |The estimated total sales value before deducting any refunds, used as a base for calculating commission.
   Formula: selling price * order quantity |
   ^^^^amount |string |1000 |The commission base amount. |
   ^^^^currency |string |VND |The commission base currency. |
   ^^^estimated_paid_shop_ads_commission |object | |The estimated Shop Ads commission that a seller will pay on sales.
   Formula: estimated commission base * Shop Ads commission rate |
   ^^^^amount |string |1000 |The commission amount. |
   ^^^^currency |string |VND |The commission currency. |
   ^^^estimated_paid_commission |object | |The estimated commission that a seller will pay on sales.
   Formula: estimated commission base * commission rate.
   Please note that we only return the value when this order is directly generated from your creator. If you are working with partner, please refer to paid_partner_commission. |
   ^^^^amount |string |20000 |The commission amount. |
   ^^^^currency |string |VND |The commission currency. |
   ^^^estimated_paid_partner_commission |object | |The estimated commission that a seller will pay on sales to affiliate partner.
   Formula: estimated commission base * partner commission rate |
   ^^^^amount |string |100 |The commission amount. |
   ^^^^currency |string |USD |The commission currency. |
   ^^^actual_commission_base |object | |The actual total sales value after deducting any refunds, used as a base for calculating commission.
   Formula: selling price * (order quantity - return/refund quantity) |
   ^^^^amount |string |50000 |The commission base amount. |
   ^^^^currency |string |VND |The commission base currency. |
   ^^^actual_paid_commission |object | |The actual commission the seller will pay on sales.
   Formula: actual commission base * commission rate.
   Please note that we only return the value when this order is directly generated from your creator. If you are working with partner, please refer to actual_paid_partner_commission.
   |
   ^^^^amount |string |10000 |The commission amount. |
   ^^^^currency |string |VND |The commission currency. |
   ^^^actual_paid_partner_commission |object | |The actual commission that a seller will pay on sales to affiliate partner.
   Formula: actual commission base * partner commission rate |
   ^^^^amount |string |20000 |The commission amount. |
   ^^^^currency |string |VND |The commission currency. |
   ^^^actual_paid_shop_ads_commission |object | |The actual Shop Ads commission the seller will pay on sales.
   Formula: actual commission base * Shop Ads commission rate |
   ^^^^amount |string |20000 |The commission amount. |
   ^^^^currency |string |VND |The commission currency. |
   ^^^estimated_cofunded_creator_bonus_amount |object | |The portion of the estimated creator bonus that you co-fund in commission boost. |
   ^^^^amount |string |100 |The commission amount. |
   ^^^^currency |string |USD |The commission currency. |
   ^^^actual_cofunded_creator_bonus_amount |object | |The portion of the actual creator bonus that you co-fund in commission boost. |
   ^^^^amount |string |100 |The commission amount. |
   ^^^^currency |string |USD |The commission currency. |
   ^^^refunded_quantity |int |1 |Field depreciated, no value return.please refer to fully_return. |
   ^^^returned_quantity |int |1 |Field depreciated, no value return.please refer to fully_return. |
   ^^^fully_return |string |Yes |Return yes when this sku is fully returned/refunded. No commission given when full return/refund |
   ^^^is_carousel |bool |false |Carousel content may involve a commission rate discount. Return [True] when orders is attributed to carousel content |
   ^^^sku_name |string |Silver PVD |The official display name and unique identifier for this product, defined and standardized by TikTok Shop. |
   ^^^seller_sku |string |cs001-pvd-bag | A unique identifier for this product, defined exclusively by the seller for their own use. |
   ^next_page_token |string |WzE2OTUxMTY2NTQ2OTMsNTc2NDczNDg5ODYxNDEyMDI1XQ== |An opaque token used to retrieve the next page of a paginated result set. Provide this value in the `page_token` parameter of your request if the current response does not return all the results. |
   ^total_count |int |10000 |The total number of sku orders that matches the query conditions. |

### Response Sample
```json
{"code":0,"data":{"orders":[{"id":"579125529499110202","delivery_time":1723748656,"create_time":1722420186,"status":"COMPLETED","skus":[{"sku_id":"1729791975232997145","settlement_status":"SETTLED","open_collaboration_id":"73661290629","target_collaboration_id":"73661290629","campaign_id":"73661290629","creator_username":"exampleTikTokCreatorUsername","price":{"amount":"1000","currency":"VND"},"quantity":1,"content_type":"LIVE","content_id":"7493990579714164574","product_id":"1729503179457070324","commission_model":"Tiered commission","commission_tier_setting":"3.0 OR 5.0","commission_rate":"1000","partner_commission_rate":"1000","shop_ads_commission_rate":"5000","estimated_commission_base":{"amount":"1000","currency":"VND"},"estimated_paid_shop_ads_commission":{"amount":"1000","currency":"VND"},"estimated_paid_commission":{"amount":"20000","currency":"VND"},"estimated_paid_partner_commission":{"amount":"100","currency":"USD"},"actual_commission_base":{"amount":"50000","currency":"VND"},"actual_paid_commission":{"amount":"10000","currency":"VND"},"actual_paid_partner_commission":{"amount":"20000","currency":"VND"},"actual_paid_shop_ads_commission":{"amount":"20000","currency":"VND"},"estimated_cofunded_creator_bonus_amount":{"amount":"100","currency":"USD"},"actual_cofunded_creator_bonus_amount":{"amount":"100","currency":"USD"},"refunded_quantity":1,"returned_quantity":1,"fully_return":"Yes","is_carousel":false,"sku_name":"Silver PVD","seller_sku":"cs001-pvd-bag"}]}],"next_page_token":"WzE2OTUxMTY2NTQ2OTMsNTc2NDczNDg5ODYxNDEyMDI1XQ==","total_count":10000},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Create Compass Offline Export Task — `POST /affiliate_seller/202603/compass/offline_task`

Doc: https://partner.tiktokshop.com/docv2/page/create-compass-offline-export-task-202603 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202603/compass/offline_task
### Method: [POST]
### Function Description
Create an asynchronous offline export task for the specified doc_type and plan_type within a given time window. Returns a task_id for subsequent status query and file download.

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
| module_type | string | N | BASE | Type of Compass data to export. Allowed values: |

* CREATOR: Creator list data.
* BASE: Core performance data. |
   window_type |string |N |PAST_24H |Time window included in the export, ending on end_day. Allowed values: PAST_24H, PAST_7_DAYS, PAST_30_DAYS. |
   end_day |int |N |20260301 |End date in the local timezone of the specified region, formatted as YYYYMMDD.
   * id：UTC+7
   * my：UTC+8
   * sg：UTC+8
   * vn：UTC+7
   * th：UTC+7
   * ph：UTC+8
   * sa：UTC+3
   * us：UTC-8
   * mx：UTC-6
   * br：UTC-3
   * jp：UTC+9
   * gb：UTC+0
   * ie：UTC+0
   * es：UTC+1
   * de：UTC+1
   * fr：UTC+1
   * it：UTC+1
   * pl：UTC+1
   * nl：UTC+1
   * be：UTC+1
   * cz：UTC+1
   * at：UTC+1
   * gr：UTC+2
   * pt：UTC+0
   * hu：UTC+1 |
      plan_type |string |N |ALL |Plan type. Allowed values: ALL, TARGET, OPEN, PARTNER. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202603/compass/offline_task?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"module_type":"BASE","window_type":"PAST_24H","end_day":20260301,"plan_type":"ALL"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^task | object |  | The task for creating downloadable files |
| ^^id | string | 1234 | the id of the task. |
### Response Sample
```json
{"code":0,"data":{"task":{"id":"1234"}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get Compass Task List — `GET /affiliate_seller/202603/compass/offline_tasks`

Doc: https://partner.tiktokshop.com/docv2/page/get-compass-task-list-202603 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202603/compass/offline_tasks
### Method: [GET]
### Function Description
Retrieve the list of export tasks created via Open API for the authorized seller (last 7 days). Supports pagination and returns task status, file_name and timestamps.

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
| doc_type | string | Y | CREATOR | Export-task category to retrieve. |

* CREATOR: Selects creator-list export tasks.
* BASE: Selects core-performance export tasks. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202603/compass/offline_tasks?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&doc_type=CREATOR
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^tasks | []object |  | The list of the task |
| ^^module_type | string | BASE | Allowed values: CREATOR, BASE. |
| ^^id | string | 1234 | The ID of the offline report task. When the task status is `SUCCEEDED`, use this value as the `task_id` path parameter in `GET /affiliate_seller/202603/compass/offline_tasks/{task_id}/file` to download the completed export task's result file. |
| ^^file_name | string | Transaction_Analysis_Core_Metrics_20240301-20240331 | the name of the final download file. |
| ^^status | string | RUNNING | The status of the task. |

* RUNNING
* SUCCEEDED
* FAILED |

### Response Sample
```json
{"code":0,"data":{"tasks":[{"module_type":"BASE","id":"1234","file_name":"Transaction_Analysis_Core_Metrics_20240301-20240331","status":"RUNNING"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Download Compass Task File — `GET /affiliate_seller/202603/compass/offline_tasks/{task_id}/file`

Doc: https://partner.tiktokshop.com/docv2/page/download-compass-task-file-202603 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202603/compass/offline_tasks/{task_id}/file
### Method: [GET]
### Function Description
Download the result file of a completed export task by taskId. Requires ownership validation; returns file.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | multipart/form-data | Allowed type: multipart/form-data |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| task_id | string | Y | 1234 | The id of the task |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202603/compass/offline_tasks/1234/file?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^file | object |  | The downloadable file |
| ^^base64 | string | ZXhhbXBsZQ== | The Base64-encoded contents of the export result file. |
### Response Sample
```json
{"code":0,"data":{"file":{"base64":"ZXhhbXBsZQ=="}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Check Target Collaboration Conflicts — `POST /affiliate_seller/202605/target_collaborations/conflicts/check`

Doc: https://partner.tiktokshop.com/docv2/page/check-target-collaboration-conflicts-202605 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.write

### Path: /affiliate_seller/202605/target_collaborations/conflicts/check
### Method: [POST]
### Function Description
Retrieve conflicting target collaborations for the product and determine if they can be terminated

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
| creator_open_id_list | []string | Y | [" "] | Creator Open ID List. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
| product_id_list | []string | Y | [" "] | product id list |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202605/target_collaborations/conflicts/check?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"creator_open_id_list":[" "],"product_id_list":[" "]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^has_conflict | bool | false | Indicates whether a conflict exists between the creator and the product. (Returns `true` if a conflict is detected.) |
| ^conflict_items | []object |  | A list of creator-product combinations whose conflicts caused the target collaboration to fail. Each item identifies the creator, product, and existing target collaboration involved. |
| ^^creator_open_id | string | uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg | Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
| ^^product_id | string | 1234 | The product identifier. |
| ^^existing_collaboration_id | string | 1234 | The confict target collaboration id |
### Response Sample
```json
{"code":0,"data":{"has_conflict":false,"conflict_items":[{"creator_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg","product_id":"1234","existing_collaboration_id":"1234"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Resolve Target Collaboration Conflicts — `POST /affiliate_seller/202605/target_collaborations/conflicts/resolve`

Doc: https://partner.tiktokshop.com/docv2/page/resolve-target-collaboration-conflicts-202605 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.write

### Path: /affiliate_seller/202605/target_collaborations/conflicts/resolve
### Method: [POST]
### Function Description
Execute resolution actions on resolvable conflict items within the scope of seller authorization.

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
| conflict_items | []object | Y |  | A list of creators and their existing target collaborations involved in conflicts that caused target collaboration failure. Each item identifies a creator and the existing target collaboration from which that creator will be removed. |
| ^existing_collaboration_id | string | Y | 123 | The confict target collaboration id |
| ^creator_open_id | string | Y | uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg | Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202605/target_collaborations/conflicts/resolve?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"conflict_items":[{"existing_collaboration_id":"123","creator_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^success_items | []object |  | success update items |
| ^^creator_open_id | string | uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg | Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
| ^^existing_collaboration_id | string | 123 | The confict target collaboration id |
| ^failed_items | []object |  | failed update items |
| ^^creator_open_id | string | uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg | Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
| ^^existing_collaboration_id | string | 1234 | The confict target collaboration id |
### Response Sample
```json
{"code":0,"data":{"success_items":[{"creator_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg","existing_collaboration_id":"123"}],"failed_items":[{"creator_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg","existing_collaboration_id":"1234"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get Weekly Creator Outreach Records — `POST /affiliate_seller/202608/creator_outreach/records/query`

Doc: https://partner.tiktokshop.com/docv2/page/get-weekly-creator-outreach-records-202608 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.read, seller.affiliate_collaboration.write

### Path: /affiliate_seller/202608/creator_outreach/records/query
### Method: [POST]
### Function Description
Query weekly detailed outreach‑invitation records for a specified seller, including whether IM messages/invitations were sent to a unconnected creator, and whether the creator added products or replied to IM messages.

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
| page_index | int | Y | 1 | Page index, need > 0 |
| page_size | int | Y | 50 | Page size, need > 1 and < =50 |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202608/creator_outreach/records/query?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"page_index":1,"page_size":50}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^data | object |  | Creator outreach records and the total number of matching records. |
| ^^total | int | 10 | Total number of records matching the query before pagination. |
| ^^connect_list | []object |  | Return the list of newly connected creator records for the shop |
| ^^^id | string | 1234 | Record ID |
| ^^^creator_open_id | string | 1234 | Creator open id |
| ^^^has_sent_im_message | bool | false | Has send im message to creator |
| ^^^has_sent_invitation | bool | false | Has send invitation to creator |
| ^^^is_paired | bool | false | Is shop creator paired |
### Response Sample
```json
{"code":0,"data":{"data":{"total":10,"connect_list":[{"id":"1234","creator_open_id":"1234","has_sent_im_message":false,"has_sent_invitation":false,"is_paired":false}]}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get Inbox Category Counts — `GET /affiliate_seller/202608/conversations/group_counts`

Doc: https://partner.tiktokshop.com/docv2/page/get-inbox-category-counts-202608 · cập nhật 2026-10-13 · scope: seller.affiliate_messages.write

### Path: /affiliate_seller/202608/conversations/group_counts
### Method: [GET]
### Function Description
Query the number of sessions grouped by status such as read, unread, starred and archived.

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
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202608/conversations/group_counts?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^data | object |  | Conversation count data grouped by inbox category. |
| ^^group_counts | []object |  | Conversation counts for each inbox category. |
| ^^^group_type | string | UNREAD | Group type name, e.g. |

* UNREAD
   -UNREPLIED
   -STARRED
   -ARCHIVED |
   ^^^count |int |10 |Conversation count in this group |

### Response Sample
```json
{"code":0,"data":{"data":{"group_counts":[{"group_type":"UNREAD","count":10}]}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Update Conversation Status — `POST /affiliate_seller/202608/conversations/{conversation_id}/status`

Doc: https://partner.tiktokshop.com/docv2/page/update-conversation-status-202608 · cập nhật 2026-08-21 · scope: seller.affiliate_messages.write

### Path: /affiliate_seller/202608/conversations/{conversation_id}/status
### Method: [POST]
### Function Description
Support starring or archiving a given conversation with creator.

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
| conversation_id | string | Y | 1234 | conversation id |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| action | string | Y | STARRED | update conversation status. e.g. |
| -STARRED star this conversation |  |  |  |  |
| -UNSTARRED un star this conversation |  |  |  |  |
| -ARCHIVED archived this invitation |  |  |  |  |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202608/conversations/1234/status?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"action":"STARRED"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
### Response Sample
```json
{"code":0,"data":{},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Query Creator Promotion Details in Target Collaboration — `POST /affiliate_seller/202608/target_collaborations/creator_promotion_details/query`

Doc: https://partner.tiktokshop.com/docv2/page/query-creator-promotion-details-in-target-collaboration-202608 · cập nhật 2026-10-13 · scope: seller.affiliate_collaboration.read, seller.affiliate_collaboration.write

### Path: /affiliate_seller/202608/target_collaborations/creator_promotion_details/query
### Method: [POST]
### Function Description
Query the creator commission rate, number of promotional video contents and number of live‑stream promotions for specified creator, specified invitation and specified product.

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
| creator_user_open_id | string | Y | abc | Creator open id |
| invitation_group_id | string | Y | 1234 | Invitation Group Id |
| query | string | N | abc | Product ID or product title to match, as selected by `query_type`. Provide both fields to filter the returned products. |
| query_type | string | N | PRODUCT_ID | Specifies how `query` filters products. Possible values: |

* `PRODUCT_ID`: Match the product ID exactly.
* `PRODUCT_NAME`: Match product titles by case-sensitive substring. |
   invitation_id |string |N |1234 |Creator Invitation Id |
   product_filter |object |N | |Product Fitler |
   ^added_types |[]string |N |["ALL"] |Product added type list, support status:
   -ALL: all status
   -ADDED: creator added product
   NOT_ADDED: creator not added product
   |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202608/target_collaborations/creator_promotion_details/query?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"creator_user_open_id":"abc","invitation_group_id":"1234","query":"abc","query_type":"PRODUCT_ID","invitation_id":"1234","product_filter":{"added_types":["ALL"]}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^data | object |  | Promotion details for products in the target collaboration invitation group. |
| ^^product_details | []object |  | Product detail infomation |
| ^^^product_base_info | object |  | Product basic infomation |
| ^^^^product_id | string | 1234 | Product ID |
| ^^^^title | string | product title | Product titile |
| ^^^^image | object |  | Product Image |
| ^^^^^url | string | https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/2ca53c34ad8443e6b39f4e0153d3aed4~tplv-o3syd03w52-origin-image.image?from=1320446476 | Product Image URL |
| ^^^^price | object |  | Product Price |
| ^^^^^min_price | object |  | Product min price |
| ^^^^^^amount | string | 1 | Price amout |
| ^^^^^^currency | string | GBP | Price currency |
| ^^^^^max_price | object |  | Product max price |
| ^^^^^^amount | string | 1 | Product amount |
| ^^^^^^currency | string | GBP | Product currency |
| ^^^^promotion_price | object |  | Product promotion price |
| ^^^^^min_price | object |  | Product promotion min price |
| ^^^^^^amount | string | 1 | Price amount |
| ^^^^^^currency | string | GBP | Price currency |
| ^^^^^max_price | object |  | Product promotion max price |
| ^^^^^^amount | string | 1 | Price amount |
| ^^^^^^currency | string | GBP | Price currency |
| ^^^^target_commission | int | 2200 | Product target collaboration commission. e.g. 2200 mean 22% commission rate |
| ^^^^open_commission | int | 2200 | Product open collaboration commission. e.g. 2200 mean 22% commission rate |
| ^^^^target_ads_commission | int | 2200 | Product target ads collaboration commission |
| ^^^^old_target_commission | int | 2200 | Product old target collaboration commission |
| ^^^^old_target_ads_commission | int | 2200 | Product old target ads collaboration commission |
| ^^^^commission_effective_time | int | 1786592565735 | Unix timestamp in milliseconds when the target collaboration commission becomes effective. |
| ^^^^ads_commission_effective_time | int | 1786592565735 | Unix timestamp in milliseconds when the target collaboration Ads commission becomes effective. |
| ^^^^product_status | string | 1 | Product status |
| 1: Active |  |  |  |
| 2; Sold out |  |  |  |
| 3: product deactivated by seller; |  |  |  |
| 4: product deactivated by platform |  |  |  |
| 5: product reject |  |  |  |
| 6: product deleted |  |  |  |
| ^^^product_add_status | bool | false | Product added or not |
| ^^^video_count | int | 1 | Creator post video count in collaboration |
| ^^^live_count | int | 1 | Creator LIVE count in collaboration |
| ^^^is_commission_effective | bool | false | Whether the target collaboration commission for this creator-product pair is currently effective. `false` means an active campaign collaboration takes precedence. |
### Response Sample
```json
{"code":0,"data":{"data":{"product_details":[{"product_base_info":{"product_id":"1234","title":"product title","image":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/2ca53c34ad8443e6b39f4e0153d3aed4~tplv-o3syd03w52-origin-image.image?from=1320446476"},"price":{"min_price":{"amount":"1","currency":"GBP"},"max_price":{"amount":"1","currency":"GBP"}},"promotion_price":{"min_price":{"amount":"1","currency":"GBP"},"max_price":{"amount":"1","currency":"GBP"}},"target_commission":2200,"open_commission":2200,"target_ads_commission":2200,"old_target_commission":2200,"old_target_ads_commission":2200,"commission_effective_time":1786592565735,"ads_commission_effective_time":1786592565735,"product_status":"1"},"product_add_status":false,"video_count":1,"live_count":1,"is_commission_effective":false}]}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Upload Message Image V2 — `POST /affiliate_seller/202608/media/upload`

Doc: https://partner.tiktokshop.com/docv2/page/upload-message-image-v2-202608 · cập nhật 2026-10-13 · scope: seller.affiliate_messages.write

### Path: /affiliate_seller/202608/media/upload
### Method: [POST]
### Function Description
You must use this API to upload the image first, before sending an image as a message using [Send IM Messsage](https://partner.tiktokshop.com/docv2/page/send-im-message-202412)

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| shop_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | Use this property to pass shop information in requesting the API. Failure in passing the correct value when requesting the API for cross-border shops will return incorrect response. |
| Get by API [Get Authorization Shop](https://partner.tiktokshop.com/docv2/page/6507ead7b99d5302be949ba9?external_id=6507ead7b99d5302be949ba9) |  |  |  |  |  |
| content-type | header | string | Y | multipart/form-data | Allowed type: multipart/form-data |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| data | file | Y |  | The format of the image must be jpg, gif, webp, or png. The size of the image must not exceed 10MB. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202608/media/upload?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^url | string | https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/2ca53c34ad8443e6b39f4e0153d3aed4~tplv-o3syd03w52-origin-image.image?from=1320446476 | Image Url |
| ^width | int | 1280 | Image width in pixels. |
| ^height | int | 720 | Image height |
### Response Sample
```json
{"code":0,"data":{"url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/2ca53c34ad8443e6b39f4e0153d3aed4~tplv-o3syd03w52-origin-image.image?from=1320446476","width":1280,"height":720},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Weekly Creator Outreach Quota — `GET /affiliate_seller/202607/creator_outreach/quota`

Doc: https://partner.tiktokshop.com/docv2/page/get-weekly-creator-outreach-quota-202607 · cập nhật 2026-10-28 · scope: seller.affiliate_collaboration.read

### Path: /affiliate_seller/202607/creator_outreach/quota
### Method: [GET]
### Function Description
Query the weekly outreach invitation quota for a shop. It returns the current GMV tier, maximum reachable creator follower count corresponding to the tier, consumed quota, remaining quota and other related information.

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
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202607/creator_outreach/quota?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^data | object |  | Creator outreach quota information for the shop. |
| ^^shop_id | string | 1234 | Shop id |
| ^^quota_type | string | BONUS | Quota type, e.g. |
| bouns quota; |  |  |  |
| period quota |  |  |  |
| ^^gmv_tier | string | 1 | Shop gmv tier |
| ^^quota_sum | string | 1000 | Shop quota sum |
| ^^quota_use | string | 500 | Shop quota used |
| ^^unlimited | bool | false | Whether the shop has unlimited creator outreach quota. |
| ^^reached_max_follower_cnt | string | 1000 | Max creator follower count this shop can reach |
| ^^new_connect_count | string | 100 | New connect creator count during this quota period |
| ^^pair_connect_count | string | 100 | Connect paired creator count during this quota period |
| ^^start_time | string | 1754296736852 | Quota period start time |
| ^^end_time | string | 1754296736852 | Quota period end time |
| ^^gmv_level_rule | []object |  | Quota GMV level rules |
| ^^^reached_max_follower_cnt | string | 1000 | Maximum follower count for creators the shop can reach under this GMV tier. |
| ^^^gmv_tier | string | 1 | GMV tier id |
| ^^^left_gmv | object |  | Rule gmv left bound |
| ^^^^amount | string | 1000 | GMV amount |
| ^^^^currency | string | JPY | GMV currency |
| ^^^right_gmv | object |  | Rule gmv right bound |
| ^^^^amount | string | 2000 | GMV amount |
| ^^^^currency | string | JPY | GMV currency |
| ^^^quota_details | []object |  | Creator-level quota detail rules |
| ^^^^creator_levels | []int | [1,2] | Creator tiers covered in the current quota tiering |
| ^^^^quota_period_sum | int | 100 | Period quota num in the current quota tiering |
| ^^^^quota_bonus_sum | int | 60 | Bonus quota num in the current quota tiering, if the seller meet the exposure posts percentile threshold, will gain quota bonus |
| ^^quota_details | []object |  | Creator-level quota detail information |
| ^^^creator_levels | []int | [1,2] | Creator tiers covered in the current quota tiering |
| ^^^quota_period_sum | int | 100 | Period quota num in the current quota tiering |
| ^^^quota_period_use | int | 1 | Period quota use in the current quota tiering |
| ^^^quota_bonus_sum | int | 60 | Bonus quota num in the current quota tiering, if the seller meet the exposure posts percentile threshold, will gain quota bonus |
| ^^^quota_bonus_use | int | 60 | Bonus quota use in the current quota tiering, bonus will be consume first. |
| ^^bonus_exposure_post_percentile_threshold | string | 0.8 | Threshold for exposure posts percentile for shops to obtain additional reward of creator-level quota, 0.8 means the 80th percentile. |
### Response Sample
```json
{"code":0,"data":{"data":{"shop_id":"1234","quota_type":"BONUS","gmv_tier":"1","quota_sum":"1000","quota_use":"500","unlimited":false,"reached_max_follower_cnt":"1000","new_connect_count":"100","pair_connect_count":"100","start_time":"1754296736852","end_time":"1754296736852","gmv_level_rule":[{"reached_max_follower_cnt":"1000","gmv_tier":"1","left_gmv":{"amount":"1000","currency":"JPY"},"right_gmv":{"amount":"2000","currency":"JPY"},"quota_details":[{"creator_levels":[1,2],"quota_period_sum":100,"quota_bonus_sum":60}]}],"quota_details":[{"creator_levels":[1,2],"quota_period_sum":100,"quota_period_use":1,"quota_bonus_sum":60,"quota_bonus_use":60}],"bonus_exposure_post_percentile_threshold":"0.8"}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Marketplace Creator Performance — `GET /affiliate_seller/202608/marketplace_creators/{creator_user_id}`

Doc: https://partner.tiktokshop.com/docv2/page/get-marketplace-creator-performance-202608 · cập nhật 2026-10-28 · scope: seller.creator_marketplace.read

### Path: /affiliate_seller/202608/marketplace_creators/{creator_user_id}
### Method: [GET]
### Function Description
Returns marketplace information and performance metrics for the specified creator.

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
| creator_user_id | string | Y | uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg | Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| data_groups | []string | N | BASIC_CREATOR_INFORMATION | Creator data groups to include in the response. If omitted, all five groups are selected. Individual field availability remains subject to the documented market, permission, and availability conditions for each field. To request multiple groups, provide the values as a comma-separated query string, for example, BASIC_CREATOR_INFORMATION,CONTENT_PERFORMANCE. |
| Available values: |  |  |  |  |

* BASIC_CREATOR_INFORMATION: Basic creator profile information.
* CONTENT_PERFORMANCE: Content performance metrics, Promotion Performance Score (PPS), fulfillment score, and promoted product count.
* FOLLOWER_INFORMATION: Follower location, age, and gender distributions.
* COLLABORATION: Collaborated brands and commission information.
* SALES_AND_GMV: Units sold; GMV and GPM metrics and distributions; product price range; and average GMV per buyer. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202608/marketplace_creators/uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&data_groups=BASIC_CREATOR_INFORMATION
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^creator | object |  | Data associated with the creator's TikTok profile. |
| ^^username | string | dioab | TikTok user name. |
| ^^nickname | string | Dion | TikTok nickname. |
| ^^avatar | object |  | Metadata and data associated with the creator's TikTok profile avatar. |
| ^^^url | string | https://p16-sign-useast2a.tiktokcdn.com/tos-useast2a-avt-0068-giso/2bf6a2485ec8bf93483e4a6ed907e6fd~c5_720x720.webp?lk3s=a5d48078&x-expires=1712988000&x-signature=E8US22KfUCwKz0R%2FMFF6%2FMOmogs%3D | The URL for the creator's TikTok profile avatar. |
| ^^selection_region | string | US | The region where the creator selects products to promote. |
| ^^bio_description | string | This is my personal introduction | The biography description associated with the creator. |
| ^^follower_count | int | 2323 | The creator's follower count. |
| ^^profile_tt_uri | string | aweme://user/profile/7200669046446064666?sec_uid=MS4wLjABAAAAvkrSOIMxn2YpXW5qBFVHIbfQ11u2L1hamtgg3mbk5GRPpl1TrnKo5zzQe5T77YLw&from_scene=8&enter_from=scan | The deep-link URI for the creator's TikTok profile. |
| ^^category_ids | []string | ["60001"] | A list of category identifiers associated with the products for which the creator has created posts. |
| ^^top_collaborated_brand_ids | []string | ["8363021"] | A list of the top 10 brands with which the creator has previously collaborated. |
| ^^brand_collaboration_count | int | 76 | The total number of brands with which the creator has previously collaborated. |
| ^^units_sold | int | 234 | The total number of units sold. Units are indexed to SKU. Note that if the creator has not given permission for precise data sharing, this property will not be present. |
| ^^units_sold_range | object |  | The range of minimum number of units sold to maximum number of units sold over the lifetime of the creator account. Note that this property is included if the target market is `US` only. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
| ^^^minimum_amount | int | 100 | The lowest number of units sold. |
| ^^^maximum_amount | int | 1000 | The highest number of units sold. |
| ^^^formatted_range | string | 0-10 | The formatted range of minimum number of units sold to maximum number of units sold over the lifetime of the creator account. |
| ^^gmv | object |  | Gross merchandise value (GMV) metadata and data associated with the creator. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
| ^^^currency | string | USD | The currency code. |
| ^^^amount | string | 3434.23 | The total GMV associated with the creator. |
| ^^video_gmv | object |  | The video GMV metadata and data associated with the creator. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
| ^^^currency | string | USD | The currency code. |
| ^^^amount | string | 39232.34 | The total video GMV associated with the creator. |
| ^^live_gmv | object |  | Livestream GMV metadata and data associated with the creator. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
| ^^^currency | string | USD | The currency code. |
| ^^^amount | string | 3432.34 | Total livestream GMV associated with the creator. |
| ^^gmv_range | object |  | The range of GMV values associated with this creator. Note that this property is included if the target market is `US` only. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
| ^^^currency | string | USD | The currency code. |
| ^^^minimum_amount | string | 1000.00 | The lowest GMV value. |
| ^^^maximum_amount | string | 10000.00 | The highest GMV value. |
| ^^^formatted_range | string | $0-$100 | The formatted range of GMV values associated with this creator. |
| ^^ec_live_engagement_rate | string | 6000 | E-commerce live stream engagement rate in hundredths of a percent. For example, `6000` is 60%. |
| ^^category_gmv_distribution | []object |  | GMV distribution by category. |
| ^^^category_id | string | 66666 | The top-level category identifier. A value of `-1` represents all other categories. |
| ^^^value | string | 0.3035 | The proportion of the creator's GMV attributed to this category, expressed as a decimal from `0` to `1` (for example, `0.3035` = 30.35%). |
| ^^content_gmv_distribution | []object |  | GMV associated with creator content by content type. |
| ^^^content_type | string | VIDEO | The content type. This an enumerated type with values: |

* VIDEO
* LIVE
* SHOWCASE |
   ^^^value |string |0.3035 |The proportion of the creator's GMV attributed to this content type, expressed as a decimal from `0` to `1` (for example, `0.3035` = 30.35%). |
   ^^product_original_price_range |object | |The range of original prices for products promoted by the creator in the last 30 days. |
   ^^^currency |string |USD |The currency code. |
   ^^^minimum_amount |string |2.59 |The lowest original promoted product price. |
   ^^^maximum_amount |string |343.23 |The higest original promoted product price. |
   ^^gpm |object | |GMV per mille (GPM) metadata and data associated with the creator. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
   ^^^currency |string |USD |The currency code. |
   ^^^amount |string |10.23 |The GPM amount. |
   ^^live_gpm |object | |Livestream GMV per mille (GPM) metadata and data associated with the creator. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
   ^^^currency |string |USD |The currency code. |
   ^^^amount |string |44.96 |The livestream GPM amount. |
   ^^video_gpm |object | |Video GMV per mille (GPM) metadata and data associated with the creator. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
   ^^^currency |string |USD |The currency code. |
   ^^^amount |string |28.89 |The video GPM amount. |
   ^^gpm_range |object | |The range of GPM values associated with the creator. Note that this property is included if the target market is `US`. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
   ^^^currency |string |USD |The currency code. |
   ^^^minimum_amount |string |100.00 |The lowest GPM value. |
   ^^^maximum_amount |string |1000.00 |The highest GPM value. |
   ^^^formatted_range |string |$0-$100 |The formatted range of GPM values associated with the creator. |
   ^^video_gpm_range |object | |The range of video GPM values associted with the creator. Note that this property is included if the target market is `US`. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
   ^^^currency |string |USD |The currency code. |
   ^^^minimum_amount |string |100.00 |The lowest video GPM value. |
   ^^^maximum_amount |string |1000.00 |The highest video GPM value. |
   ^^^formatted_range |string |$0-$100 |The formatted range of video GPM values associted with the creator. |
   ^^live_gpm_range |object | |The range of livestream GPM values associted with the creator. Note that this property is included if the target market is `US` only. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
   ^^^currency |string |USD |The currency code. |
   ^^^minimum_amount |string |100.00 |The lowest livestream GPM value. |
   ^^^maximum_amount |string |1000.00 |The highest livestream GPM value. |
   ^^^formatted_range |string |$0-$100 |The formatted range of livestream GPM values associted with the creator. |
   ^^promoted_product_num |int |311 |The number of products promoted by the creator in the last 30 days. |
   ^^ec_live_count |int |12 |The number of e-commerce livestreams associated with the creator in the last 30 days. |
   ^^ec_video_count |int |34 |The number of e-commerce video posts associated with the creator in the last 30 days. |
   ^^avg_ec_video_play_count |int |1234 |The average number of number of e-commerce video plays. |
   ^^avg_commission_rate |int |6000 |The average commission rate in hundredths of a percent. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
   ^^avg_commission_rate_range |object | |The range of average commission rates associated with the creator. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
   ^^^minimum_amount |int |6000 |The smallest average commission rate in hundredths of a percent. |
   ^^^maximum_amount |int |7000 |The largest average commission rate in hundredths of a percent. |
   ^^avg_gmv_per_buyer |object | |Average GMV per buyer metadata and data associated with the creator. Note that this property is included if the target market is `US` only. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
   ^^^currency |string |USD |The currency code. |
   ^^^amount |string |45.68 |The average GMV per buyer amount. |
   ^^avg_gmv_per_buyer_range |object | |The range of average GMV per buyer associated with the creator. Note that this property is included if the target market is `US` only. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
   ^^^currency |string |USD |The currency code. |
   ^^^minimum_amount |string |100.00 |The smallest average GMV per buyer. |
   ^^^maximum_amount |string |1000.00 |The largest average GMV per buyer. |
   ^^^formatted_range |string |$15-$20 |The formatted range of average GMV per buyer associated with the creator. |
   ^^avg_ec_live_view_count |int |4355 |Average live stream views with promoted products. |
   ^^avg_ec_live_like_count |int |344 |Average e-commerce live stream likes. |
   ^^avg_ec_live_comment_count |int |23 |Average e-commerce live stream comments. |
   ^^avg_ec_live_share_count |int |3434 |Average e-commerce live stream shares. |
   ^^avg_ec_video_like_count |int |324 |Average e-commerce video likes. |
   ^^avg_ec_video_comment_count |int |343 |Average e-commerce video comments. |
   ^^avg_ec_video_share_count |int |22 |Average e-commerce video shares. |
   ^^follower_location |[]object | |A list of key–value pairs representing the distribution of followers by location. |
   ^^^key |string |ID |The country code for the follower location (for example, ID). |
   ^^^value |string |0.3705 |The proportion of followers from this location, expressed as a decimal (e.g., 0.3705 = 37.05%). |
   ^^follower_age |[]object | |A list of key–value pairs representing the distribution of followers by age range. |
   ^^^key |string |18-23 |The age range (e.g., "18–23"). |
   ^^^value |string |0.2500 |The proportion of followers in this age range, expressed as a decimal (e.g., 0.2500 = 25.00%). |
   ^^follower_gender |[]object | |A list of key–value pairs representing the distribution of followers by gender. |
   ^^^key |string |Male |The gender (e.g., "Male", "Female"). |
   ^^^value |string |0.5000 |The proportion of followers of this gender, expressed as a decimal (e.g., 0.5000 = 50.00%). |
   ^^pps |string |4.5 |Promotion Performance Score (PPS)
   The score reflects the quality of a creator's shoppable content and product selection over the past 90 days. A high score may indicate a better shopping experience, with fewer potential refunds or negative reviews. |
   ^^rating |string |3.2 |Rating from sellers who worked with this creator |
   ^^ec_video_engagement_rate |string |3000 |The number of post engagements (likes, shares, and comments) divided by the total video views averaged across the videos in the last 30 days.
   For example, 3000 stands for 0.3 or 30% |
   ^^post_rate |string |100 |The projected rate at which a creator is likely to post a shoppable video or LIVE after receiving a sample.
   For example, 3000 stands for 0.3 or 30% |
   ^^creator_profile |object | |Advanced creator profile information. An empty object means this information is not available for the caller's account or region. |
   ^^^is_official_recommend |bool |false |Creaor has official recommend tag or not |
   ^^^contact_info_available |bool |false |Is creator contact infomation available |
   ^^^creator_bind_mcn_name |string |name |Creator bind MCN name |
   ^^^live_engagement_rate_30d |int |50 |Creator engagement rate last 30 days |
   ^^^video_play_cnt_30d_med |int |10 |Creator average VIDEO play count last 30 days |
   ^^^live_view_cnt_30d_med |int |10 |Creator average LIVE view count last 30 days |
   ^^^live_like_cnt_30d |int |10 |Creator LIVE like count last 30 days |
   ^^^live_comment_cnt_30d_med |int |10 |Creator average LIVE comment count last 30 days |
   ^^^live_share_cnt_30d_med |int |10 |Creator average LIVE share count last 30 days |
   ^^^video_publish_cnt_30d_med |int |10 |Creator average VIDEO publish count last 30 days |
   ^^^has_invited_90d |bool |false |Has invited before 90 days |
   ^^^is_creator_blocked |bool |false |Is creator blocked by shop |
   ^^^creator_level |int |2 |Creator level |
   ^^^creator_fulfillment_reviews |int |10 |The number of fulfillment reviews submitted by sellers for the creator in the last 90 days. |
   ^^^is_eligible_flat_fee |bool |false |Creator is eligible for flat fee invitation |
   ^^^is_rising_star |bool |false |Creator has rising star tag or not |
   ^^^creator_fulfillment_score_90d |string |4.1 |Creator fulfillment score during last 90 days |
   ^^^sample_score |int |75 |Creator credit total score. e.g. 75 means creator' sample scole is 75/100. |
   ^^^creator_connect_info |object | |Creator connect infomation |
   ^^^^is_paired |bool |false |Creator is paired or not |
   ^^^^is_connect |bool |false |Creator is connect or not |
   ^^^^is_blocked |bool |false |Creator is blocked or not |
   ^^^creator_trend_profile |[]object | |Creator trend infomation |
   ^^^^start_timestamp |int |1784419200 |Trend start timestamp |
   ^^^^end_timestamp |int |1784419200 |Trend end timestamp |
   ^^^^gmv |object | |Trend GMV infomation |
   ^^^^^amount |string |1000 |GMV amount |
   ^^^^^symbol |string |$ |GMV symbol |
   ^^^^units_sold |int |1000 |Trend units sold |
   ^^^^follower |int |1000 |Trend follower |
   ^^^^engagement_rate |int |558 |Trend engagement rate e.g. 558 means creator's engagement rate is 5.58% |

### Response Sample
```json
{"code":0,"data":{"creator":{"username":"dioab","nickname":"Dion","avatar":{"url":"https://p16-sign-useast2a.tiktokcdn.com/tos-useast2a-avt-0068-giso/2bf6a2485ec8bf93483e4a6ed907e6fd~c5_720x720.webp?lk3s=a5d48078\u0026x-expires=1712988000\u0026x-signature=E8US22KfUCwKz0R%2FMFF6%2FMOmogs%3D"},"selection_region":"US","bio_description":"This is my personal introduction","follower_count":2323,"profile_tt_uri":"aweme://user/profile/7200669046446064666?sec_uid=MS4wLjABAAAAvkrSOIMxn2YpXW5qBFVHIbfQ11u2L1hamtgg3mbk5GRPpl1TrnKo5zzQe5T77YLw\u0026from_scene=8\u0026enter_from=scan","category_ids":["60001"],"top_collaborated_brand_ids":["8363021"],"brand_collaboration_count":76,"units_sold":234,"units_sold_range":{"minimum_amount":100,"maximum_amount":1000,"formatted_range":"0-10"},"gmv":{"currency":"USD","amount":"3434.23"},"video_gmv":{"currency":"USD","amount":"39232.34"},"live_gmv":{"currency":"USD","amount":"3432.34"},"gmv_range":{"currency":"USD","minimum_amount":"1000.00","maximum_amount":"10000.00","formatted_range":"$0-$100"},"ec_live_engagement_rate":"6000","category_gmv_distribution":[{"category_id":"66666","value":"0.3035"}],"content_gmv_distribution":[{"content_type":"VIDEO","value":"0.3035"}],"product_original_price_range":{"currency":"USD","minimum_amount":"2.59","maximum_amount":"343.23"},"gpm":{"currency":"USD","amount":"10.23"},"live_gpm":{"currency":"USD","amount":"44.96"},"video_gpm":{"currency":"USD","amount":"28.89"},"gpm_range":{"currency":"USD","minimum_amount":"100.00","maximum_amount":"1000.00","formatted_range":"$0-$100"},"video_gpm_range":{"currency":"USD","minimum_amount":"100.00","maximum_amount":"1000.00","formatted_range":"$0-$100"},"live_gpm_range":{"currency":"USD","minimum_amount":"100.00","maximum_amount":"1000.00","formatted_range":"$0-$100"},"promoted_product_num":311,"ec_live_count":12,"ec_video_count":34,"avg_ec_video_play_count":1234,"avg_commission_rate":6000,"avg_commission_rate_range":{"minimum_amount":6000,"maximum_amount":7000},"avg_gmv_per_buyer":{"currency":"USD","amount":"45.68"},"avg_gmv_per_buyer_range":{"currency":"USD","minimum_amount":"100.00","maximum_amount":"1000.00","formatted_range":"$15-$20"},"avg_ec_live_view_count":4355,"avg_ec_live_like_count":344,"avg_ec_live_comment_count":23,"avg_ec_live_share_count":3434,"avg_ec_video_like_count":324,"avg_ec_video_comment_count":343,"avg_ec_video_share_count":22,"follower_location":[{"key":"ID","value":"0.3705"}],"follower_age":[{"key":"18-23","value":"0.2500"}],"follower_gender":[{"key":"Male","value":"0.5000"}],"pps":"4.5","rating":"3.2","ec_video_engagement_rate":"3000","post_rate":"100","creator_profile":{"is_official_recommend":false,"contact_info_available":false,"creator_bind_mcn_name":"name","live_engagement_rate_30d":50,"video_play_cnt_30d_med":10,"live_view_cnt_30d_med":10,"live_like_cnt_30d":10,"live_comment_cnt_30d_med":10,"live_share_cnt_30d_med":10,"video_publish_cnt_30d_med":10,"has_invited_90d":false,"is_creator_blocked":false,"creator_level":2,"creator_fulfillment_reviews":10,"is_eligible_flat_fee":false,"is_rising_star":false,"creator_fulfillment_score_90d":"4.1","sample_score":75,"creator_connect_info":{"is_paired":false,"is_connect":false,"is_blocked":false},"creator_trend_profile":[{"start_timestamp":1784419200,"end_timestamp":1784419200,"gmv":{"amount":"1000","symbol":"$"},"units_sold":1000,"follower":1000,"engagement_rate":558}]}}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16032012 | only affiliate partner cipher can access this api |
| 16901005 | this creator does't have e-commerce permission,please check the request params. |
| 16901006 | creator selection region doesn't match seller's region |
| 16901007 | The seller could not obtain an official creator profile due to insufficient permissions. |
| 16901008 | The creator didn't didn't have e-commerce permissions or has been deactivated. |
| 16901009 | can't access tiktok linkshare creator |
| 36009002 | Too many requests. You've made too many requests in a short period of time. |
| 45101004 | The query quota has been reached (10000 request per day). Please try again tomorrow. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 98001004 | Parameter {param_name} is invalid. Reason: {reason}. Expected: {expected_value} |


---

## Get Creator Marketplace Advanced Search Filters — `POST /affiliate_seller/202608/marketplace_creators/search/filter`

Doc: https://partner.tiktokshop.com/docv2/page/get-creator-marketplace-advanced-search-filters-202608 · cập nhật 2026-10-13 · scope: seller.creator_marketplace.read

### Path: /affiliate_seller/202608/marketplace_creators/search/filter
### Method: [POST]
### Function Description
This API allows you to obtain the advanced filters available in Seller Search Creator Marketplace. Because we are constantly releasing new filters which are specific to each country or region, this API serves as a way for developers to retrieve the latest available search filters.

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
| options | []object | N |  | The filter option types to retrieve. If this field is omitted or empty, both `option_list` and `sorters` are returned as empty arrays. |
| ^option_type | string | N | OPTION_SORTER | Filter option type to retrieve. Possible values: |

* `OPTION_VERTICAL_PRO`: Category Pro, a label for creators who regularly post about one product category and generated most of their sales in that category during the past 60 days.
* `OPTION_LANGUAGE`: Creator language.
* `OPTION_CREATOR_LEVEL`: Creator level based on GMV. The definition varies by country and is maintained by the TikTok Shop Creator team.
* `OPTION_SORTER`: Available creator-search sorting options, returned in `sorters`.
* `OPTION_BRAND`: Creator brand information. This value is not supported in DE, FR, IT, ES, IE, or JP. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202608/marketplace_creators/search/filter?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"options":[{"option_type":"OPTION_SORTER"}]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^data | object |  | The available Creator Marketplace search-filter values and sorting options. |
| ^^option_list | []object |  | Creator Marketplace Advanced Filter Option List. If we return an empty object, it means this filter is not currently supported by your account or region. |
| ^^^option_type | string | OPTION_LANGUAGE | The requested filter option type represented by this entry. |
| ^^^options | []object |  | The available values for this filter option type. |
| ^^^^id | string | 1 | Option id |
| ^^^^name | string | English | The option name. |
| ^^^^option_children | []object |  | Children option detail list, used if the option has sub option choices |
| ^^^^^id | string | 12 | Children Option id |
| ^^^^^name | string | SubTypeName | Children Option name |
| ^^sorters | []object |  | The available sorting options for Creator Marketplace search results. |
| ^^^algorithm_id | string | 1 | sort algorithm id |
| ^^^name | string | related | sort algorithm name |
### Response Sample
```json
{"code":0,"data":{"data":{"option_list":[{"option_type":"OPTION_LANGUAGE","options":[{"id":"1","name":"English","option_children":[{"id":"12","name":"SubTypeName"}]}]}],"sorters":[{"algorithm_id":"1","name":"related"}]}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Search Creators in Creator Marketplace — `POST /affiliate_seller/202608/marketplace_creators/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-creators-in-creator-marketplace-202608 · cập nhật 2026-10-28 · scope: seller.creator_marketplace.read

### Path: /affiliate_seller/202608/marketplace_creators/search
### Method: [POST]
### Function Description
This API is used by Sellers to search for Creators in the Creator Marketplace. Sellers can search based on filters such as GMV, keywords, and Creator follower demographics. All the data returned is for the last 30 days.

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
| page_token | string | N | b2Zmc2V0PTAK | Pagination token that identifies where to continue the search. For the first request, omit this parameter or leave it empty. For each subsequent request, pass the next_page_token returned by the previous response. |
| page_size | int | Y | 12 | The value of "page_size" must be 12 or 20 |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| search_key | string | N | 2E+0EcXoSk2HWdEWh2nITfkBRMbwuug0mt9s3fWgV0k= | Caching search results improves api performance and ensures stable request results. |
| You don't need to pass a value on the first call. |  |  |  |  |
| For the second call, please pass the value returned in the response of the first call. |  |  |  |  |
| keyword | string | N | JefreeStar | Searching creators by keyword, matching based on TikTok Username and Nickname. |
| follower_demographics | object | N |  | Filtering creators by follower demographics |
| ^age_ranges | []string | N | ["AGE_RANGE_18_24", "AGE_RANGE_35_44"] | Follower age filtering options, which are range intervals, include: |
| AGE_RANGE_18_24: "18-24", |  |  |  |  |
| AGE_RANGE_25_34: "25-34", |  |  |  |  |
| AGE_RANGE_35_44: "35-44", |  |  |  |  |
| AGE_RANGE_45_54: "45-54", |  |  |  |  |
| AGE_RANGE_55_AND_ABOVE: "55+" |  |  |  |  |
| ^count_range | object | N |  | Follower count filtering |
| ^^count_ge | int | N | 1000 | The minimum value of follower count. |
| The value passed in must be greater than or equal to 0 |  |  |  |  |
| ^^count_le | int | N | 10000 | The maximum value of follower count. |

* Generally, a value greater than or equal to 0 needs to be passed. If a value less than 0 is passed, it means that the field will not be filtered. |
   ^gender_distribution |object |N | |Filters creators by follower gender.
   Possible values:
* MALE
* FEMALE |
   ^^gender |string |N |MALE |A particular gender, "MALE" or "FEMALE" |
   ^^percentage_ge |int |N |6000 |Greater than or equal to a certain percentage, scaled up by 10,000 times.
   For example, 6000 stands for 0.6 or 60% |
   gmv_ranges |[]string |N |["GMV_RANGE_0_100", "GMV_RANGE_100_1000"] |Filtering by GMV range intervals which include:
   GMV_RANGE_0_100: "0-100",
   GMV_RANGE_100_1000: "100-1000",
   GMV_RANGE_1000_10000: "1000-10000",
   GMV_RANGE_10000_AND_ABOVE: "10000+"
   For example:
* If GMV_RANGE_0_100 is passed, it means filtering the creator data that is greater than or equal to 0 and less than or equal to 100.
* If GMV_RANGE_0_100 and GMV_RANGE_100_1000 are passed, it means to filter the creator data that is greater than or equal to 0 and less than or equal to 1000. |
   units_sold_ranges |[]string |N |["UNITS_SOLD_RANGE_0_10", "UNITS_SOLD_RANGE_100_1000","UNITS_SOLD_RANGE_1000_AND_ABOVE"]
   |Filtering by sales volume range intervals which include:
   UNITS_SOLD_RANGE_0_10: "0-10",
   UNITS_SOLD_RANGE_10_100: "10-100",
   UNITS_SOLD_RANGE_100_1000: "100-1000",
   UNITS_SOLD_RANGE_1000_AND_ABOVE: "1000+"
   For example:
* If UNITS_SOLD_RANGE_0_10 is passed, it means filtering the creator data that is greater than or equal to 0 and less than or equal to 10.
* If UNITS_SOLD_RANGE_0_10 and UNITS_SOLD_RANGE_10_100 are passed, it means to filter the creator data that is greater than or equal to 0 and less than or equal to 100. |
   category |[]object |N | |Array of category filter objects. Use [Get Categories](https://partner.tiktokshop.com/docv2/page/get-categories-202309) to retrieve category IDs. |
   ^parent_category_id |string |N |600001 |Category of the parent category. If you are only using a parent category, you do not need to pass in a child category ID. |
   ^child_category_id_list |[]string |N |["851848"] |If you are using the category ID for a child category, you must pass the parent category as well. A child category is only 1 level deeper than the parent category. We do not support going deeper down the category tree (some countries have 4 levels, others have 7) |
   content_performance |object |N | |Object containing content performance filters |
   ^avg_video_views |string |N |1 |Average Video Views more than
   You can pass in average video views anywhere between 0 and 100k
   Pick any whole number between 0 and 100,000, and we will return all results with average video views greater than that number.
   You can only pass in Average Video Views OR Average Shoppable Video Views. Using both filters will cause the API call to fail. |
   ^avg_shoppable_video_views |string |N |1 |You can pass in average shoppable video views anywhere between 0 and 100k
   Pick any whole number between 0 and 100,000, and we will return all results with average shoppable video views greater than that number.
   You can only pass in Average Video Views OR Average Shoppable Video Views. Using both filters will cause the API call to fail. |
   ^avg_engagement_rate |string |N |1 |Average engagement rate more than 0-20.
   You can only filter by increments of 1% point, up to 20%. |
   ^avg_shopable_engagement_rate |string |N |1 |Average shoppable engagement rate more than 0-20.
   You can only filter by increments of 1% point, up to 20%. |
   ^avg_live_avg_viewers_ge |string |N |1 |Filters creators whose average LIVE viewers are greater than or equal to the specified value.
   Enter a whole number from 0 to 100,000.
   You can only pass one of avg_live_avg_viewers_ge and avg_shoppable_live_avg_viewers_ge. Using both filters causes the API call to fail. |
   ^avg_shoppable_live_avg_viewers_ge |string |N |1 |Filters creators whose average shoppable LIVE viewers are greater than or equal to the specified value.
   Enter a whole number from 0 to 100,000.
   You can only pass one of avg_live_avg_viewers_ge and avg_shoppable_live_avg_viewers_ge. Using both filters causes the API call to fail. |
   affiliate_data |object |N | |Object which contains affiliate based data |
   ^avg_commission_rate |string |N |LESS_THAN_20% |- ALL
* LESS_THAN_20%
* LESS_THAN_15%
* LESS_THAN_10%
* LESS_THAN_5%
   Creator's average commission rate range based on showcase products, sales, and promoted products in the last 30 days.
   You can only pick one value. |
   ^post_rate |string |N |GOOD |These categories represent how often a creator posts a shoppable video or LIVE after receiving a sample.
* ALL
* OK
* GOOD
* BETTER
   Every country has its own benchmark based on what is a GOOD vs BETTER fulfillment rate. BETTER is always going to have the highest fulfillment rate, including 100% fulfillment rate. |
   ^creator_agency_staus |string |N |AGENCY_MANAGED |- AGENCY_MANAGED
* INDEPENDENT |
   ^is_fast_growing |bool |N |false |Top 10% of creators with the greatest increase in transactions, revenue, shoppable videos, live views, or followers in the last 30 days |
   ^not_invited_l90_days |bool |N |false |True/False
   Select this filter to see creators you haven't invited in the last 90 days |
   advanced_filters |object |N | |Advanced filters are specific to each country. Before using advanced filters with this API, use [Get Seller Search Creator Marketplace Advanced Filters](https://partner.tiktokshop.com/docv2/page/get-seller-search-creator-marketplace-advanced-filters) to retrieve the filters available for the relevant country. |
   ^content_preference_type |[]string |N |["VIDEO"] |Content preference type. e.g.
   -VIDEO
   -LIVE |
   ^eligible_flat_fee |bool |N |false |Creator is eligible for flat fee invitation, only available in US local seller |
   ^option_list |[]object |N | |Creator Marketplace Advanced Filter Option List. Please use "Get Seller Search Creator Marketplace Advanced Filters"(https://partner.tiktokshop.com/docv2/page/get-seller-search-creator-marketplace-advanced-filters) get available options for you first |
   ^^options |[]object |N | |Options in this option type |
   ^^^id |string |N |1 |Option id |
   ^^^name |string |N |English |Option name |
   ^^^option_children |[]object |N | |Children Option |
   ^^^^id |string |N |2 |Option id |
   ^^^^name |string |N |SubTypeName |Option name, used if the option has sub-type choices. |
   ^^option_type |string |N |OPTION_LANGUAGE |option type |
   ^sorter_algorithm_id |string |N |1 |Sorter algorithm id. Please use "Get Seller Search Creator Marketplace Advanced Filters"(https://partner.tiktokshop.com/docv2/page/get-seller-search-creator-marketplace-advanced-filters) get available sorter algorithm for you first. Default is 1(default sorter) |
   data_groups |[]string |N |["BASIC_CREATOR_INFORMATION","SALES_AND_GMV"] |Creator's Data Group, get all group by default, which include:
* BASIC_CREATOR_INFORMATION
* CONTENT_PERFORMANCE
* FOLLOWER_INFORMATION
* COLLABORATION
* SALES_AND_GMV |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_seller/202608/marketplace_creators/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&shop_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_token=b2Zmc2V0PTAK&page_size=12
```

**Body**
```json
{"search_key":"2E+0EcXoSk2HWdEWh2nITfkBRMbwuug0mt9s3fWgV0k=","keyword":"JefreeStar","follower_demographics":{"age_ranges":["AGE_RANGE_18_24","AGE_RANGE_35_44"],"count_range":{"count_ge":1000,"count_le":10000},"gender_distribution":{"gender":"MALE","percentage_ge":6000}},"gmv_ranges":["GMV_RANGE_0_100","GMV_RANGE_100_1000"],"units_sold_ranges":["UNITS_SOLD_RANGE_0_10","UNITS_SOLD_RANGE_100_1000","UNITS_SOLD_RANGE_1000_AND_ABOVE"],"category":[{"parent_category_id":"600001","child_category_id_list":["851848"]}],"content_performance":{"avg_video_views":"1","avg_shoppable_video_views":"1","avg_engagement_rate":"1","avg_shopable_engagement_rate":"1","avg_live_avg_viewers_ge":"1","avg_shoppable_live_avg_viewers_ge":"1"},"affiliate_data":{"avg_commission_rate":"LESS_THAN_20%","post_rate":"GOOD","creator_agency_staus":"AGENCY_MANAGED","is_fast_growing":false,"not_invited_l90_days":false},"advanced_filters":{"content_preference_type":["VIDEO"],"eligible_flat_fee":false,"option_list":[{"options":[{"id":"1","name":"English","option_children":[{"id":"2","name":"SubTypeName"}]}],"option_type":"OPTION_LANGUAGE"}],"sorter_algorithm_id":"1"},"data_groups":["BASIC_CREATOR_INFORMATION","SALES_AND_GMV"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^next_page_token | string | b2Zmc2V0PTEy | Pagination token for the next page. To continue, pass this value as query parameter `page_token`, pass the `search_key` returned in the same response as request-body `search_key`, and reuse the same `page_size`. An empty token means there are no more results. |
| ^search_key | string | k1ChOzI9e+j5BHHHEnt+VhItjVFEkPUCCXNsrU8/v4U= | Search key for continuing the same search with stable results. Pass this value as search_key in the next request. |
| ^creators | []object |  | Creator records with basic profile, content performance, follower, GMV, and sales-range information. Included fields depend on the requested `data_groups`. |
| ^^username | string | abc | Creator's TikTok Username |
| ^^nickname | string | cde | Creator's TikTok Nickname |
| ^^avatar | object |  | Creator's profile picture |
| ^^^url | string | https://p16-sign-useast2a.tiktokcdn.com/tos-useast2a-avt-0068-giso/2bf6a2485ec8bf93483e4a6ed907e6fd~c5_720x720.webp?lk3s=a5d48078&x-expires=1712988000&x-signature=E8US22KfUCwKz0R%2FMFF6%2FMOmogs%3D | URL of creator's avatar picture |
| ^^selection_region | string | GB | Regions where the creator operates and promotes products |
| ^^category_ids | []string | ["60001"] | It indicates the main product categories when the creator posts products. |
| ^^avg_ec_live_uv | int | 1331 | Average UV for creator's e-commerce live streams |
| ^^avg_ec_video_view_count | int | 112 | Average views for creator's e-commerce videos |
| ^^follower_count | int | 23241 | Follower count |
| ^^gmv | object |  | Creator GMV-related information |
| If the creator does not authorize sharing precise data, this will be omitted. |  |  |  |
| ^^^currency | string | USD | Currency code for the GMV amount. |
| ^^^amount | string | 1232.90 | GMV value |
| ^^live_gmv | object |  | Live stream GMV |
| If the creator does not authorize sharing precise data, this will be omitted. |  |  |  |
| ^^^currency | string | USD | Currency code for the live-stream GMV amount. |
| ^^^amount | string | 0.34 | Live stream GMV value |
| ^^video_gmv | object |  | Video GMV-related information |
| If the creator does not authorize sharing precise data, this will be omitted. |  |  |  |
| ^^^currency | string | USD | Currency code for the video GMV amount. |
| ^^^amount | string | 23.34 | Video GMV value |
| ^^gmv_range | object |  | GMV range. |
| Applicable if the target market is the US and the creator does not authorize sharing precise data. |  |  |  |
|  |  |  |  |
| ^^^currency | string | USD | Currency code for the GMV range. |
| ^^^minimum_amount | string | 0 | The minimum value of GMV range |
| ^^^maximum_amount | string | 100 | The maximum value of GMV range |
| ^^^formatted_range | string | $0-$100 | The formatted range of GMV values associated with this creator. |
| ^^units_sold_range | object |  | The range of minimum number of units sold to maximum number of units sold over the lifetime of the creator account. Note that this property is included if the target market is US only. Note that if the creator has not given permission for precise data sharing, these properties will not be present. |
| ^^^minimum_amount | int | 100 | The minimum value of sales volume range |
| ^^^maximum_amount | int | 1000 | The maximum value of sales volume range |
| ^^^formatted_range | string | 100-1K | The formatted range of minimum number of units sold to maximum number of units sold over the lifetime of the creator account. |
| ^^top_follower_demographics | object |  | Top follower information of the creator |
| ^^^age_ranges | []string | [ "AGE_RANGE_18_24", "AGE_RANGE_25_34"] | Return the top 3 age ranges of the followers. Ranges are : |
| AGE_RANGE_18_24: "18-24", |  |  |  |
| AGE_RANGE_25_34: "25-34", |  |  |  |
| AGE_RANGE_35_44: "35-44", |  |  |  |
| AGE_RANGE_45_54: "45-54", |  |  |  |
| AGE_RANGE_55_AND_ABOVE: "55+" |  |  |  |
| ^^^major_gender | object |  | Major gender of the followers |
|  |  |  |  |
| ^^^^gender | string | FEMALE | Top follower gender category of the creator, "MALE" or "FEMALE" |
| ^^^^percentage | int | 6524 | Percentage of top follower gender, scaled up by 10,000 times. |
| For example, 6524 stands for 0.6524 or 65.24%. You can then infer that the opposite gender would be 0.3476 or 34.76%. |  |  |  |
| ^^creator_open_id | string | uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg | Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
| ^^creator_profile | object |  | Advanced creator profile information. An empty object means that this profile information is not currently supported for your account or region. |
| ^^^is_official_recommend | bool | false | Creator has official recommend tag or not |
| ^^^creator_bind_mcn_name | string | name | Creator bind MCN name |
| ^^^is_fast_growing | bool | false | Creator has fast growing tag or not |
| ^^^has_collaborated | bool | false | Has collaborated with this creator or not |
| ^^^user_type_tag | []int | [1] | User type tag. |
| Possible values: |  |  |  |

* 1: Privacy creator
* 2: Carve-out creator |
   ^^^has_invited_90d |bool |false |Has invited creaor before 90 days |
   ^^^is_creator_blocked |bool |false |Is this creator blocked by shop or not |
   ^^^pps_score |string |4.3 |Creator promotion performance score(PPS).The score reflects the quality of a creator's shoppable content and product selection over the past 30 days. A high score may indicate a better shopping experience, with fewer potential refunds or negative reviews. e.g. 4.3/5.0 |
   ^^^is_eligible_flat_fee |bool |false |Is creator eligible for flat fee, only available for US local seller |
   ^^^is_rising_star |bool |false |Creator has rising star tag or not |
   ^^^creator_level |int |2 |Creator level |

### Response Sample
```json
{"code":0,"data":{"next_page_token":"b2Zmc2V0PTEy","search_key":"k1ChOzI9e+j5BHHHEnt+VhItjVFEkPUCCXNsrU8/v4U=","creators":[{"username":"abc","nickname":"cde","avatar":{"url":"https://p16-sign-useast2a.tiktokcdn.com/tos-useast2a-avt-0068-giso/2bf6a2485ec8bf93483e4a6ed907e6fd~c5_720x720.webp?lk3s=a5d48078\u0026x-expires=1712988000\u0026x-signature=E8US22KfUCwKz0R%2FMFF6%2FMOmogs%3D"},"selection_region":"GB","category_ids":["60001"],"avg_ec_live_uv":1331,"avg_ec_video_view_count":112,"follower_count":23241,"gmv":{"currency":"USD","amount":"1232.90"},"live_gmv":{"currency":"USD","amount":"0.34"},"video_gmv":{"currency":"USD","amount":"23.34"},"gmv_range":{"currency":"USD","minimum_amount":"0","maximum_amount":"100","formatted_range":"$0-$100"},"units_sold_range":{"minimum_amount":100,"maximum_amount":1000,"formatted_range":"100-1K"},"top_follower_demographics":{"age_ranges":["AGE_RANGE_18_24","AGE_RANGE_25_34"],"major_gender":{"gender":"FEMALE","percentage":6524}},"creator_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg","creator_profile":{"is_official_recommend":false,"creator_bind_mcn_name":"name","is_fast_growing":false,"has_collaborated":false,"user_type_tag":[1],"has_invited_90d":false,"is_creator_blocked":false,"pps_score":"4.3","is_eligible_flat_fee":false,"is_rising_star":false,"creator_level":2}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 45101004 | The query quota has been reached (10000 request per day). Please try again tomorrow. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Check Creator Outreach Eligibility — `POST /affiliate_seller/202610/creator_outreach/eligibility/check`

Doc: https://partner.tiktokshop.com/docv2/page/check-creator-outreach-eligibility-202610 · cập nhật 2026-10-15 · scope: seller.affiliate_collaboration.read



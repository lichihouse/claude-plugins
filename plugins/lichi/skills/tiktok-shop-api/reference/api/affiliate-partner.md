# Affiliate partner — tài liệu chi tiết

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.




---

## Affiliate Partner API overview

Doc: https://partner.tiktokshop.com/docv2/page/affiliate-partner-api-overview · cập nhật 2026-09-21

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

## Create Affiliate Partner Campaign — `POST /affiliate_partner/202405/campaigns`

Doc: https://partner.tiktokshop.com/docv2/page/create-affiliate-partner-campaign-202405 · cập nhật 2026-10-13 · scope: partner.tap_campaign.write

### Path: /affiliate_partner/202405/campaigns
### Method: [POST]
### Function Description
Creates an affiliate partner campaign for either specific sellers identified by shop code or eligible seller types. Configure the campaign period, seller registration period, commission rate, and contact information. When the campaign is created successfully, the operation returns the new `campaign_id` synchronously. The campaign is not displayed to sellers after creation. To publish a successfully created campaign, call `POST /affiliate_partner/202405/campaigns/{campaign_id}/publish` with the returned campaign ID.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| category_asset_cipher | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| name | string | Y | my first campaign | The campaign name. Must contain 1 to 50 characters, inclusive, and must not start with a space. |
| description | string | Y | campaign for test | The campaign description. Must contain 1 to 1000 characters, inclusive, and must not start with a space. |
| campaign_start_time | int | Y | 1712941200 | The scheduled campaign start time as a Unix timestamp in seconds. It must not be earlier than the current time. In subsequent edits, this value can be changed only when the campaign status is `READY` or `UPCOMING`. |
| campaign_end_time | int | Y | 1715878799 | The scheduled campaign end time as a Unix timestamp in seconds. It must be later than `campaign_start_time`, and the campaign period must be between 1 and 360 days, inclusive. In subsequent edits, this value cannot be changed when the campaign status is `CLOSED`. |
| registration_start_time | int | Y | 1712941200 | The scheduled start time for seller product registration as a Unix timestamp in seconds. It must be equal to `campaign_start_time`. In subsequent edits, this value can be changed only when the campaign status is `READY` or `UPCOMING`. |
| registration_end_time | int | Y | 1713891599 | The scheduled end time for seller product registration as a Unix timestamp in seconds. It must be later than `registration_start_time`; the registration period must be at least 1 day and must not extend beyond `campaign_end_time`. In subsequent edits, this value cannot be changed when the campaign status is `CLOSED`. |
| commission_rate | int | Y | 1000 | The total commission rate, in hundredths of a percent (0.01%) units, proposed by the affiliate partner for display to sellers. The value must be between 100 and 8000, inclusive. |
| contact_info | object | Y |  | The partner's contact information. |
| ^whatsapp | string | N | +14255550100 | The partner's phone number registered in WhatsApp, in E.164 international format. Required if the target market is MY, SG, GB, or ID; optional if the target market is US; otherwise, not applicable. |
| ^email | string | Y | 123456@gmail.com | The partner's email address. |
| ^phone | string | N | +14255550100 | The partner's phone number in E.164 international format. |
| ^zalo | string | N | +14255550100 | The partner's phone number registered in Zalo, in E.164 international format. Required if the target market is VN; otherwise, not applicable. |
| ^viber | string | N | +14255550100 | The partner's phone number registered in Viber, in E.164 international format. Required if the target market is PH; otherwise, not applicable. |
| ^line | string | N | +14255550100 | The partner's phone number registered in LINE, in E.164 international format. Required if the target market is TH; otherwise, not applicable. |
| target_shop_codes | []string | N | ["THCBELNL4Y"] | A list of TikTok Shop seller shop codes that may register for the campaign. Find a seller's shop code in TikTok Shop Seller Central by selecting the Seller Profile icon in the top-right corner of the user interface. Specify exactly one of `target_shop_codes` and `target_seller_types`. The list must contain fewer than 100 items. |
| target_seller_types | []string | N | ["CROSS_BORDER"] | A list of eligible seller types that may register for the campaign. Use this field to target seller types instead of specific sellers in `target_shop_codes`. Specify exactly one of `target_seller_types` and `target_shop_codes`. |
| Possible values: |  |  |  |  |

* `LOCAL`
* `CROSS_BORDER` |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202405/campaigns?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"name":"my first campaign","description":"campaign for test","campaign_start_time":1712941200,"campaign_end_time":1715878799,"registration_start_time":1712941200,"registration_end_time":1713891599,"commission_rate":1000,"contact_info":{"whatsapp":"+14255550100","email":"123456@gmail.com","phone":"+14255550100","zalo":"+14255550100","viber":"+14255550100","line":"+14255550100"},"target_shop_codes":["THCBELNL4Y"],"target_seller_types":["CROSS_BORDER"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^campaign_id | string | 7356411663443183367 | The campaign identifier. |
### Response Sample
```json
{"code":0,"data":{"campaign_id":"7356411663443183367"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 16032002 | Invalid campaign period |
| 16032003 | Invalid registration period |
| 16032004 | Invalid campaign seller scope |
| 16032013 | Payment account not yet activated |


---

## Edit Affiliate Partner Campaign — `POST /affiliate_partner/202405/campaigns/{campaign_id}/partial_edit`

Doc: https://partner.tiktokshop.com/docv2/page/edit-affiliate-partner-campaign-202405 · cập nhật 2026-10-13 · scope: partner.tap_campaign.write

### Path: /affiliate_partner/202405/campaigns/{campaign_id}/partial_edit
### Method: [POST]
### Function Description
Partially updates an Affiliate Partner campaign. Fields omitted from the request retain their current values, including omitted fields within `contact_info`. `target_seller_types` and `target_shop_codes` are mutually exclusive. To switch targeting modes, send the previously used field as an empty array and the new field with its values. Campaigns cannot be edited after they are closed.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| campaign_id | string | Y | 7373988288167036678 | The campaign ID in decimal integer format. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| category_asset_cipher | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| name | string | N | test campaign | The campaign name. It must contain 1 to 50 characters and must not start with a space. |
| description | string | N | campaign for api test. | The campaign description. It must contain 1 to 1000 characters and must not start with a space. |
| campaign_start_time | int | N | 1712941200 | The scheduled campaign start time as a Unix timestamp in seconds. This field can be updated only when the campaign status is `READY` or `UPCOMING`. |
| campaign_end_time | int | N | 1715878799 | The scheduled end time in Unix epoch time format for the campaign. Note that the end time must be less than 360 days from the start date. This field is no longer editable when the campaign status is set to `CLOSED`. |
| registration_start_time | int | N | 1712941200 | The scheduled start time for seller product registration, as a Unix timestamp in seconds. This field can be updated only when the campaign status is `READY` or `UPCOMING`. |
| registration_end_time | int | N | 1713891599 | The scheduled end time for seller product registration, as a Unix timestamp in seconds. This field is no longer editable when the campaign status is `CLOSED`. |
| commission_rate | int | N | 1000 | The total commission rate, in units of 0.01%, proposed by the affiliate partner for display to sellers. The value must be between 100 and 8000, inclusive. |
| contact_info | object | N |  | The partner's contact information. |
| ^whatsapp | string | N | +14255550100 | The partner's phone number registered in WhatsApp, in E.164 international format. Applicable if the target market is MY, SG, GB, ID, or US. |
| ^email | string | N | 123456@gmail.com | The partner's email address. |
| ^phone | string | N | +14255550100 | The partner's phone number in E.164 international format. |
| ^zalo | string | N | +14255550100 | The partner's phone number registered in Zalo, in E.164 international format. Applicable if the target market is VN. |
| ^viber | string | N | +14255550100 | The partner's phone number registered in Viber, in E.164 international format. Applicable if the target market is PH. |
| ^line | string | N | +14255550100 | The partner's phone number registered in LINE, in E.164 international format. Applicable if the target market is TH. |
| target_shop_codes | []string | N | ["THCBELNL4Y"] | A list of TikTok Shop seller shop codes to allow to register for the campaign. The seller shop code in available in TikTok Shop Seller Central by clicking on the Seller Profile icon in the top right of the user interface. The list must be less than 100 items in length. |
| target_seller_types | []string | N | ["CROSS_BORDER"] | A list of eligible seller types to allow to register for the campaign. Use this field to broadly target types of sellers instead of specific sellers in the `target_shop_codes` field. This is an enumerated type with possible values: |

* LOCAL
* CROSS_BORDER |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202405/campaigns/7373988288167036678/partial_edit?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"name":"test campaign","description":"campaign for api test.","campaign_start_time":1712941200,"campaign_end_time":1715878799,"registration_start_time":1712941200,"registration_end_time":1713891599,"commission_rate":1000,"contact_info":{"whatsapp":"+14255550100","email":"123456@gmail.com","phone":"+14255550100","zalo":"+14255550100","viber":"+14255550100","line":"+14255550100"},"target_shop_codes":["THCBELNL4Y"],"target_seller_types":["CROSS_BORDER"]}
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
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 16032002 | Invalid campaign period |
| 16032003 | Invalid registration period |
| 16032004 | Invalid campaign seller scope |
| 16032005 | Campaign not found |
| 16032007 | Permission denied |
| 16032008 | Operation denied |


---

## Publish Affiliate Partner Campaign — `POST /affiliate_partner/202405/campaigns/{campaign_id}/publish`

Doc: https://partner.tiktokshop.com/docv2/page/publish-affiliate-partner-campaign-202405 · cập nhật 2026-10-13 · scope: partner.tap_campaign.write

### Path: /affiliate_partner/202405/campaigns/{campaign_id}/publish
### Method: [POST]
### Function Description
This API offers the ability to publish an Affiliate Partner campaign. The campaign will be displayed to sellers after publishing.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| campaign_id | string | Y | 7373988288167036678 | The campaign identifier. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| category_asset_cipher | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202405/campaigns/7373988288167036678/publish?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
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
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 16032005 | Campaign not found |
| 16032007 | Permission denied |
| 16032008 | Operation denied |
| 16032011 | Max campaign online count reached |


---

## Review Affiliate Partner Campaign Product — `POST /affiliate_partner/202405/campaigns/{campaign_id}/products/{product_id}/review`

Doc: https://partner.tiktokshop.com/docv2/page/review-affiliate-partner-campaign-product-202405 · cập nhật 2026-10-13 · scope: partner.tap_campaign.product.write

### Path: /affiliate_partner/202405/campaigns/{campaign_id}/products/{product_id}/review
### Method: [POST]
### Function Description
Use this API as a TikTok Affiliate Partner to approve or reject a product submitted by a seller to a campaign. The product must be in a pending state.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| campaign_id | string | Y | 7373988288167036678 | The campaign identifier. |
| product_id | string | Y | 1730064726487763199 | The product identifier. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| category_asset_cipher | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| review_result | string | Y | APPROVE | The product review decision by the TikTok Affiliate Partner. This is an enumerated type with values: |

* APPROVE
* REJECT
* REJECT_FOREVER |
   reject_reasons |[]string |N |["COMMISSION_TOO_LOW"] |Rejection reasons for the product when `review_result` is `REJECT` or `REJECT_FOREVER`. Possible values for each item:
* COMMISSION_TOO_LOW
* PRODUCT_HARD_TO_PROMOTE
* PRODUCT_TOO_EXPENSIVE
* NO_SUITABLE_CREATOR |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202405/campaigns/7373988288167036678/products/1730064726487763199/review?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"review_result":"APPROVE","reject_reasons":["COMMISSION_TOO_LOW"]}
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
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 16032005 | Campaign not found |
| 16032007 | Permission denied |
| 16032009 | Product operation denied, please ensure campaign is under online status. |


---

## Generate Affiliate Partner Campaign Product Link — `POST /affiliate_partner/202405/campaigns/{campaign_id}/products/{product_id}/promotion_link/generate`

Doc: https://partner.tiktokshop.com/docv2/page/generate-affiliate-partner-campaign-product-link-202405 · cập nhật 2026-10-28 · scope: partner.tap_campaign.link.write

### Path: /affiliate_partner/202405/campaigns/{campaign_id}/products/{product_id}/promotion_link/generate
### Method: [POST]
### Function Description
Generates a promotion link for a product in an existing online campaign. The product must be associated with the campaign and appear in the response from Get Affiliate Partner Campaign Product List with `review_status` set to `APPROVED` or `PENDING_CLOSED`.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| campaign_id | string | Y | 7373988288167036678 | The ID of the campaign. |
| product_id | string | Y | 1730064726487763199 | The ID of the product. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| category_asset_cipher | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| creator_commission_rate | int | Y | 1000 | The commission rate paid to a creator, in hundredths of a percent (0.01%). The value must be at least 100 (1%) and no greater than the total commission rate set by the seller. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202405/campaigns/7373988288167036678/products/1730064726487763199/promotion_link/generate?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"creator_commission_rate":1000}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^product_promotion_link | string | https://affiliate.tiktok.com/api/v1/share/AIxvOHlaJoKO | A URL for product promotion content. This URL is provided to agencies for sharing with colloborating creators. Creators share this link with followers via the TikTok App. Note that creators control whether or not to add products to their showcase in the pop-up window. |
### Response Sample
```json
{"code":0,"data":{"product_promotion_link":"https://affiliate.tiktok.com/api/v1/share/AIxvOHlaJoKO"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 16032005 | Campaign not found |
| 16032007 | Permission denied |
| 16032008 | Operation denied |
| 16032009 | Product operation denied, please ensure campaign is under online status. |
| 16032010 | Campaign product not found |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Affiliate Partner Campaign Detail — `GET /affiliate_partner/202405/campaigns/{campaign_id}`

Doc: https://partner.tiktokshop.com/docv2/page/get-affiliate-partner-campaign-detail-202405 · cập nhật 2026-10-28 · scope: partner.tap_campaign.read

### Path: /affiliate_partner/202405/campaigns/{campaign_id}
### Method: [GET]
### Function Description
This API offers the ability to get affiliate campaign details.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| campaign_id | string | Y | 7373988288167036678 | The campaign ID in decimal integer format. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| category_asset_cipher | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202405/campaigns/7373988288167036678?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^id | string | 7356876895365105455 | The campaign identifier. |
| ^name | string | test_campaign | The campaign name. Maximum length: 50 characters. |
| ^description | string | Campaign for api test. | The campaign description. Maximum length: 1000 characters. |
| ^status | string | READY | The campaign status. The status is an enumerated type with values: |

* READY
* UPCOMING
* ONGOING
* CLOSED |
   ^region |string |US |The region to which the campaign is associated. |
   ^registration_start_time |int |1712941200 |The scheduled start time for seller product registration as a Unix timestamp in seconds. This field can be updated only when the campaign status is `READY` or `UPCOMING`. |
   ^registration_end_time |int |1713891599 |The scheduled end time for seller product registration as a Unix timestamp in seconds. This field is no longer editable when the campaign status is `CLOSED`. |
   ^campaign_start_time |int |1712941200 |The scheduled campaign start time as a Unix timestamp in seconds. This field can be updated only when the campaign status is `READY` or `UPCOMING`. |
   ^campaign_end_time |int |1715878799 |The scheduled end time in Unix epoch time format for the campaign. Note that the end time must be less than 360 days from the start date. This field is no longer editable when the campaign status is set to `CLOSED`. |
   ^commission_rate |int |1000 |The total commission rate in hundredths of a percent (0.01%) units proposed by the affiliate partner for display to sellers. Commission rate must be greater than 100 and less than 8000. |
   ^contact_info |object | |The campaign creator's contact information. |
   ^^whatsapp |string |+14255550100 |WhatsApp account number |
   ^^email |string |123456@gmail.com |Email |
   ^^phone |string |+14255550100 |Phone number |
   ^^zalo |string |+14255550100 |Zalo account number |
   ^^viber |string |+14255550100 |Viber account number |
   ^^line |string |+14255550100 |Line account number |
   ^target_shops |[]object | |A list of TikTok Shop seller shop codes and names with permission to register for the campaign. |
   ^^code |string |THCBELNL4Y |The seller shop code in available in TikTok Shop Seller Central by clicking on the Seller Profile icon in the top right of the user interface. |
   ^^name |string |my_shop |The TikTok Shop name. |
   ^target_seller_types |[]string |["LOCAL"] |A list of seller types eligible to register for the campaign. Use this field to broadly target seller types instead of the specific shops listed in `target_shops`. Possible values:
* LOCAL
* CROSS_BORDER |

### Response Sample
```json
{"code":0,"data":{"id":"7356876895365105455","name":"test_campaign","description":"Campaign for api test.","status":"READY","region":"US","registration_start_time":1712941200,"registration_end_time":1713891599,"campaign_start_time":1712941200,"campaign_end_time":1715878799,"commission_rate":1000,"contact_info":{"whatsapp":"+14255550100","email":"123456@gmail.com","phone":"+14255550100","zalo":"+14255550100","viber":"+14255550100","line":"+14255550100"},"target_shops":[{"code":"THCBELNL4Y","name":"my_shop"}],"target_seller_types":["LOCAL"]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 16032005 | Campaign not found |
| 16032007 | Permission denied |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Affiliate Partner Campaign List — `GET /affiliate_partner/202405/campaigns`

Doc: https://partner.tiktokshop.com/docv2/page/get-affiliate-partner-campaign-list-202405 · cập nhật 2026-10-28 · scope: partner.tap_campaign.read

### Path: /affiliate_partner/202405/campaigns
### Method: [GET]
### Function Description
Lists campaigns for an affiliate partner, filtered by campaign category, participation state, and campaign status.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| category_asset_cipher | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
| page_size | int | Y | 10 | The number of campaigns to return per page. Valid range: 1-100. |
| page_token | string | N | b2Zmc2V0PTAK | An opaque token used to retrieve the next page of a paginated result set. Retrieve this value from the result of the `next_page_token` from a previous response. It is not needed for the first page. Maximum page size is `100` items. |
| status | string | N | READY | This parameter is required. |
| The campaign status. The status is an enumerated type with values: |  |  |  |  |

* `READY`
* `UPCOMING`
* `ONGOING`
* `CLOSED`
* `UNSPECIFIED` |
   type |string |N |MY_CAMPAIGNS |The campaign type. This is an enumerated type with values:
* MY_CAMPAIGNS
* GS_SELLING_CAMPAIGNS
* SELLER_CAMPAIGNS
* EXCLUSIVE_TIKTOK_SHOP
   Default value is MY_CAMPAIGNS. |
   query_type_filter |string |N |DEFAULT |An additional filter whose valid values depend on `type`:
* `SELLER_CAMPAIGNS`: `query_type_filter` is required. Set it to `MARKETPLACE` to include campaigns that the partner has not joined, or `JOINED` to include only campaigns that the partner has joined. When using `MARKETPLACE`, set `status` to `UNSPECIFIED`.
* `EXCLUSIVE_TIKTOK_SHOP`: `query_type_filter` is required. Set it to `AVAILABLE` to include campaigns that the partner is permitted to join, or `JOINED` to include only campaigns that the partner has joined. For either value, set `status` to `UNSPECIFIED`.
* `MY_CAMPAIGNS` or `GS_SELLING_CAMPAIGNS`: omit `query_type_filter` or set it to `DEFAULT`. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202405/campaigns?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_size=10&page_token=b2Zmc2V0PTAK&status=READY&type=MY_CAMPAIGNS&query_type_filter=DEFAULT
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^campaigns | []object |  | A list of campaigns. |
|  |  |  |  |
| ^^id | string | 7360590375814268715 | The campaign identifier. |
| ^^name | string | test | The campaign name. |
| ^^status | string | READY | The campaign status. The status is an enumerated type with values: |

* READY
* UPCOMING
* ONGOING
* CLOSED |
   ^^registration_start_time |int |1712941200 |The scheduled start time in Unix epoch format for seller product registration. Note that this field can be updated when the campaign status is set to `READY` or `UPCOMING` only. |
   ^^registration_end_time |int |1713891599 |The scheduled end time in Unix epoch time format for seller product registration. This field is no longer editable when the campaign status is set to `CLOSED`. |
   ^^campaign_start_time |int |1712941200 |The scheduled start time in Unix epoch time format for the campaign. Note that this field can be updated when the campaign status is set to `READY` or `UPCOMING` only. |
   ^^campaign_end_time |int |1715878799 |The scheduled end time in Unix epoch time format for the campaign. Note that the end time must be less than 360 days from the start date. This field is no longer editable when the campaign status is set to `CLOSED`. |
   ^next_page_token |string |cGFnZV9udW1iZXI9Mg== |An opaque token used to retrieve the next page of a paginated result set. For the first request, omit `page_token` or pass an empty value. For each subsequent request, pass the previous response's non-empty `next_page_token` as `page_token`, and keep the same `category_asset_cipher`, `page_size`, `status`, `type`, and `query_type_filter` values, including whether each optional parameter was omitted or provided. If `next_page_token` is empty, no more pages are available. |
   ^total_count |int |1570 |The total number of campaigns in the list. |

### Response Sample
```json
{"code":0,"data":{"campaigns":[{"id":"7360590375814268715","name":"test","status":"READY","registration_start_time":1712941200,"registration_end_time":1713891599,"campaign_start_time":1712941200,"campaign_end_time":1715878799}],"next_page_token":"cGFnZV9udW1iZXI9Mg==","total_count":1570},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 16032007 | Permission denied |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Affiliate Partner Campaign Product List — `GET /affiliate_partner/202405/campaigns/{campaign_id}/products`

Doc: https://partner.tiktokshop.com/docv2/page/get-affiliate-partner-campaign-product-list-202405 · cập nhật 2026-10-28 · scope: partner.tap_campaign.read

### Path: /affiliate_partner/202405/campaigns/{campaign_id}/products
### Method: [GET]
### Function Description
This API offers the ability to list products submitted by sellers in an Affiliate Partner campaign.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| campaign_id | string | Y | 7373988288167036678 | The numeric ID of an existing Affiliate Partner campaign. |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| category_asset_cipher | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
| page_size | int | Y | 10 | The number of results to return per page. The value must be between 1 and 100. |
| page_token | string | N | b2Zmc2V0PTAK | An opaque token used to retrieve the next page of a paginated result set. Retrieve this value from the result of the `next_page_token` from a previous response. It is not needed for the first page. |
| review_status | string | N | PENDING | The product review status. This an enumerated type with values: |

* PENDING
* APPROVED
* REJECTED
* PENDING_CLOSED
* CLOSED |
   product_name |string |N |sample |Filter the product list by product name. If value of `product_name` is contained in `product.name`, the product will be included in the response. |
   product_id |string |N |1730305356901683547 |Filter the product list by product ID. The value must be a numeric string. A product is included when this value matches `product.id`. |
   shop_name |string |N |Test Shop |Filter the product list by shop name. If value of `shop_name` is contained in `product.shop_name`, the product will be included in the response. |
   category_id |string |N |991496 |Filter the product list by category ID. If value of `category_id` matches `product.category.id`, or the product falls into the leaf category of the specified category, the product will be included in the response. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202405/campaigns/7373988288167036678/products?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_size=10&page_token=b2Zmc2V0PTAK&review_status=PENDING&product_name=sample&product_id=1730305356901683547&shop_name=Test Shop&category_id=991496
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^products | []object |  | The list of products. |
| ^^id | string | 1729442777527587334 | The product identifier. |
| ^^review_status | string | PENDING | The product review status. This an enumerated type with values: |

* PENDING
* APPROVED
* REJECTED
* PENDING_CLOSED
* CLOSED |
   ^^name |string |test case number 4 test case number 4 |The product name. |
   ^^main_image_url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499 |The product image URL. |
   ^^lowest_price |object | |The lowest original price of all SKUs of this product. |
   ^^^currency |string |USD |The currency in the sales region. |
   ^^^amount |string |1.1 |The lowest price amount. |
   ^^highest_price |object | |The highest original price of all SKUs of this product. |
   ^^^currency |string |USD |The currency code for the region in which the product is sold. |
   ^^^amount |string |12.21 |The highest price amount. |
   ^^inventory |int |89 |The number of in-stock units of all SKUs for this product. |
   ^^shop_name |string |my_shop |The TikTok Shop name. |
   ^^total_commission_rate |int |6600 |The total commission rate in hundredths of a percent (0.01%) units. |
   ^^creator_commission_rate |int |1000 |The creator commission rate in hundredths of a percent (0.01%) units. |
   ^^partner_commission_rate |int |5600 |The partner commission rate in hundredths of a percent (0.01%) units. |
   ^^open_collaboration_commission_rate |int |1000 |The product open collaboration commission rate in hundredths of a percent (0.01%) units.
   |
   ^^is_available |bool |true |Set to `true` if a product URL is available. Set to `false` if no product URL is available. |
   ^^product_sales |int |10 |The total number of units sold of this product for this campaign. |
   ^^category |object | |The leaf category to which this product is associated. |
   ^^^id |string |12222 |The category identifier. |
   ^^^name |string |COMPUTER |The category name. |
   ^^sample_quota |int |12 |The total amount of sample inventory available for allocation to creators by the seller. |
   ^^sku_information_list |[]object | |A list of Stock Keeping Units (SKUs) used to identify distinct variants of the product. |
   ^^^sku_name |string |factory product |The name of the sku |
   ^^^sku_id |string |1729666531097281876 |The id of the sku |
   ^^^inventory |object | |SKU inventory details. |
   ^^^^available_quantity |string |80 |The total SKU quantity available in the warehouse. |
   ^^^base_price |object | |the base price of the sku |
   ^^^^region_code |string |MY |the region code of the sku |
   ^^^^currency |string |MYR |The currency of the SKU price.
   Possible values based on the region:
* BRL: Brazil
* EUR: France, Germany, Ireland, Italy, Spain
* GBP: United Kingdom
* IDR: Indonesia
* JPY: Japan
* MXN: Mexico
* MYR: Malaysia
* PHP: Philippines
* SGD: Singapore
* THB: Thailand
* USD: United States
* VND: Vietnam |
   ^^^^list_price |string |162.34 |The SKU's list price information that has been verified to be legitimate by the audit team. This is equivalent to the manufacturer's suggested retail price (MSRP), or the recommended retail price (RRP). |
   ^^^^sale_price |string |162.34 |The SKU's selling price, inclusive of tax.
   Applicable only for cross-border sellers from China. |
   ^^^^localized_dutiable_price |string |141.58 |localized dutiable price
   |
   ^^^region_prices |[]object | |region prices |
   ^^^^region_code |string |MY |the region code of the sku |
   ^^^^currency |string |MYR |The currency of the SKU price.
   Possible values based on the region:
* BRL: Brazil
* EUR: France, Germany, Ireland, Italy, Spain
* GBP: United Kingdom
* IDR: Indonesia
* JPY: Japan
* MXN: Mexico
* MYR: Malaysia
* PHP: Philippines
* SGD: Singapore
* THB: Thailand
* USD: United States
* VND: Vietnam |
   ^^^^list_price |string |162.34 |The SKU's list price information that has been verified to be legitimate by the audit team. This is equivalent to the manufacturer's suggested retail price (MSRP), or the recommended retail price (RRP). |
   ^^^^sale_price |string |162.34 |The SKU's selling price, inclusive of tax.
   Applicable only for cross-border sellers from China. |
   ^^^^localized_dutiable_price |string |141.58 |localized dutiable price |
   ^^^properties |[]object | |The properties of the sku |
   ^^^^name |string |Spesifikasi |the name of the property |
   ^^^^value_name |string |lalai |the name of the value |
   ^^product_description |string |
   This is an example product description.
   |Return product description |
   ^next_page_token |string |cGFnZV9udW1iZXI9Mg== |An opaque token used to retrieve the next page of a paginated result set. When this value is non-empty, pass it as `page_token` in the next request and reuse the same `campaign_id`, `category_asset_cipher`, `page_size`, `review_status`, `product_name`, `product_id`, `shop_name`, and `category_id` values, including any omitted optional filters. An empty `next_page_token` means there are no more pages. |
   ^total_count |int |1570 |The total number of products in the list. |

### Response Sample
```json
{"code":0,"data":{"products":[{"id":"1729442777527587334","review_status":"PENDING","name":"test case number 4 test case number 4","main_image_url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499","lowest_price":{"currency":"USD","amount":"1.1"},"highest_price":{"currency":"USD","amount":"12.21"},"inventory":89,"shop_name":"my_shop","total_commission_rate":6600,"creator_commission_rate":1000,"partner_commission_rate":5600,"open_collaboration_commission_rate":1000,"is_available":true,"product_sales":10,"category":{"id":"12222","name":"COMPUTER"},"sample_quota":12,"sku_information_list":[{"sku_name":"factory product","sku_id":"1729666531097281876","inventory":{"available_quantity":"80"},"base_price":{"region_code":"MY","currency":"MYR","list_price":"162.34","sale_price":"162.34","localized_dutiable_price":"141.58"},"region_prices":[{"region_code":"MY","currency":"MYR","list_price":"162.34","sale_price":"162.34","localized_dutiable_price":"141.58"}],"properties":[{"name":"Spesifikasi","value_name":"lalai"}]}],"product_description":"\u003cp\u003eThis is an example product description.\u003c/p\u003e"}],"next_page_token":"cGFnZV9udW1iZXI9Mg==","total_count":1570},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 16032005 | Campaign not found |
| 16032007 | Permission denied |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Campaign Product Performance List — `GET /affiliate_partner/202501/campaigns/{campaign_id}/products/performance`

Doc: https://partner.tiktokshop.com/docv2/page/get-campaign-product-performance-list-202501 · cập nhật 2026-10-13 · scope: partner.tap_campaign.read

### Path: /affiliate_partner/202501/campaigns/{campaign_id}/products/performance
### Method: [GET]
### Function Description
Retrieves a paginated list of product-level performance statistics for the specified partner campaign.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| campaign_id | string | Y | 1234567890 | the unique id of a campaign |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| page_size | int | N | 10 | The number of results to be returned per page. Valid range: 1-50. |
| page_token | string | N | b2Zmc2V0PTAK | An opaque token used to retrieve the next page of a paginated result set. Retrieve this value from the result of the `next_page_token` from a previous response. It is not needed for the first page. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202501/campaigns/1234567890/products/performance?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_size=10&page_token=b2Zmc2V0PTAK
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^total_count | int | 10 | The total count of products included in the specified campaign. |
| ^campaign_product_statistics | []object |  | A list of objects representing campaign product statistics. |
| ^^data_update_time | string | 1736204400000 | The time at which the product data was last updated, in Unix epoch format. |
| ^^creator_sales_num | int | 1 | The number of creators credited with at least one product sale. |
| ^^collaborated_creators_num | int | 0 | The total number of creators associated with the campaign. |
| ^^promoted_creator_num | int | 0 | The number of the creators involved in the campaign. |
|  |  |  |  |
| ^^sample_requested_creator_num | int | 0 | The total number of samples requested by all creators associated with the campaign. |
| ^^campaign_product_detail | object |  | An object representing the details for the product associated with the campaign. |
| ^^^product_id | string | 12344 | The product identifier. |
| ^^^product_status | string | PRODUCT_UNSPECIFIED | The product status. This is an enumerated type with values: |

* PRODUCT_UNSPECIFIED
* PRODUCT_PENDING
* PRODUCT_APPROVED
* PRODUCT_REJECTED
* PRODUCT_PENDING_CLOSED
* PRODUCT_CLOSED
   |
   ^^^product_name |string |summer underwear soft dress summer underwear-001 |The product name. |
   ^^^product_stock_count |string |100 |The product's total available stock quantity across all SKUs. |
   ^^^total_commission_percent |string |6000 |The total commission rate for the partner plan. It is the sum of `creator_commission_percent` and `partner_commission_percent`. The value is in hundredths of a percent. For example, a value of 1000 means 10.00%. |
   ^^^creator_commission_percent |string |1000 |The commission rate for the creator in the partner plan. The value is in hundredths of a percent. For example, a value of 1000 means 10.00%. |
   ^^^partner_commission_percent |string |5000 |The commission rate for the partner in the partner plan. The value is in hundredths of a percent. For example, a value of 1000 means 10.00%.
   |
   ^^^plan_commission_percent |string |1400 |The commission rate for open collaboration. The value is in hundredths of a percent. For example, a value of 1000 means 10.00%.
   |
   ^^^product_price |object | |The product price. |
   ^^^^min_price |string |1.00 |The minimum offered price of the product. |
   ^^^^max_price |string |3.00 |The maximum offered price of the product. |
   ^^^^currency |string |USD |The currency code for the maximum and minimum offered price for the product. |
   ^^^product_thumbnail |object | |An object representing the product thumbnail. |
   ^^^^uri |string |tos-useast5-i-omjb5zjo8w-tx/178e97ee3b254f9ab237ea7516828266 |The URI of the product thumbnail image. |
   ^^^^url_list |[]string |["https://p19-oec-ttp.tiktokcdn-us.com/tos-useast5-i-omjb5zjo8w-tx/178e97ee3b254f9ab237ea7516828266~tplv-omjb5zjo8w-resize-jpeg:300:300.jpeg?from=520841845", "https://p16-oec-ttp.tiktokcdn-us.com/tos-useast5-i-omjb5zjo8w-tx/178e97ee3b254f9ab237ea7516828266~tplv-omjb5zjo8w-resize-jpeg:300:300.jpeg?from=520841845"] |A list of URLs for the product thumbnail image. |
   ^^^indicator_data |object | |Key performance indicators for the product. |
   ^^^^paid_order_num |string |3 |The total number of paid orders. `paid_order_num` = `actual_order_num` + {number of paid but returned orders}
   |
   ^^^^actual_order_num |string |0 |The actual number of paid orders. |
   ^^^^estimated_amount |string |0 |The total payment amount corresponding to `paid_order_num`.
   |
   ^^^^actual_amount |string |0 |GMV, the total payment amount corresponding to `actual_order_num`.
   |
   ^^^^estimated_partner_commission |string |0 |The partner commission amount corresponding to paid_order_num.
   |
   ^^^^actual_partner_commission |string |0 |The partner commission amount corresponding to actual_order_num.
   |
   ^^^^creator_sales_num |string |0 |The number of creators credited with at least one product sale. |
   ^^^^collaborated_creators_num |string |0 |The total number of creators collaborating on the campaign. |
   ^^^^promoted_creator_num |string |0 |The number of creators involved in the partner plan.
   |
   ^^^^sample_requested_creator_num |string |0 |The total number of creators that applied for a sample. |
   ^next_page_token |string |0 |The token to use as `page_token` in the next request. Keep the same `campaign_id` and `page_size` on subsequent requests. An empty string indicates that there are no more results. |

### Response Sample
```json
{"code":0,"data":{"total_count":10,"campaign_product_statistics":[{"data_update_time":"1736204400000","creator_sales_num":1,"collaborated_creators_num":0,"promoted_creator_num":0,"sample_requested_creator_num":0,"campaign_product_detail":{"product_id":"12344","product_status":"PRODUCT_UNSPECIFIED","product_name":"summer underwear soft dress summer underwear-001","product_stock_count":"100","total_commission_percent":"6000","creator_commission_percent":"1000","partner_commission_percent":"5000","plan_commission_percent":"1400","product_price":{"min_price":"1.00","max_price":"3.00","currency":"USD"},"product_thumbnail":{"uri":"tos-useast5-i-omjb5zjo8w-tx/178e97ee3b254f9ab237ea7516828266","url_list":["https://p19-oec-ttp.tiktokcdn-us.com/tos-useast5-i-omjb5zjo8w-tx/178e97ee3b254f9ab237ea7516828266~tplv-omjb5zjo8w-resize-jpeg:300:300.jpeg?from=520841845","https://p16-oec-ttp.tiktokcdn-us.com/tos-useast5-i-omjb5zjo8w-tx/178e97ee3b254f9ab237ea7516828266~tplv-omjb5zjo8w-resize-jpeg:300:300.jpeg?from=520841845"]},"indicator_data":{"paid_order_num":"3","actual_order_num":"0","estimated_amount":"0","actual_amount":"0","estimated_partner_commission":"0","actual_partner_commission":"0","creator_sales_num":"0","collaborated_creators_num":"0","promoted_creator_num":"0","sample_requested_creator_num":"0"}}}],"next_page_token":"0"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Generate Campaign Product Promotion Links in Batch — `POST /affiliate_partner/202505/campaigns/{campaign_id}/products/promotion_links/generate_batch`

Doc: https://partner.tiktokshop.com/docv2/page/generate-campaign-product-promotion-links-in-batch-202505 · cập nhật 2026-10-13 · scope: partner.tap_campaign.read

### Path: /affiliate_partner/202505/campaigns/{campaign_id}/products/promotion_links/generate_batch
### Method: [POST]
### Function Description
Generate promotion links for multiple products in an online campaign. For OPS or seller-initiated campaigns, use the joined campaign ID created after the partner joins the campaign, not the original campaign ID.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| campaign_id | string | Y | 7362840009596339923 | The ID of the campaign |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| category_asset_cipher | string | N | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3= | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| product_ids | []string | N | [7362840009596339971,7362840009596339923] | The list of product IDs. The max length is 50. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202505/campaigns/7362840009596339923/products/promotion_links/generate_batch?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

**Body**
```json
{"product_ids":[7362840009596340000,7362840009596340000]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^product_promotion_links | []object |  | The list of products for which the promotion links are generated successfully. |
| ^^product_id | string | 7362840009596339971 | The ID of the product to promote. |
| ^^link | string | https://affiliate.tiktok.com/api/v1/share/AIxvOHlaJoKO | This is the product promotion link that agencies can share with collaborated creators. Creators can copy/paste this link into the web browser. Creators will be re-directed to the add-product-link page in the Tikotk app. Creators can decide whether to add products to their showcases in the pop-up window. |
| ^failed_product_ids | []string | [7362840009596339923] | The list of products for which the promotion links failed to be generated. |
### Response Sample
```json
{"code":0,"data":{"product_promotion_links":[{"product_id":"7362840009596339971","link":"https://affiliate.tiktok.com/api/v1/share/AIxvOHlaJoKO"}],"failed_product_ids":[7362840009596340000]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get Creator Performance for Campaign Product — `GET /affiliate_partner/202508/campaigns/{campaign_id}/products/{product_id}/performance`

Doc: https://partner.tiktokshop.com/docv2/page/get-creator-performance-for-campaign-product-202508 · cập nhật 2026-10-28 · scope: partner.tap_campaign.read

### Path: /affiliate_partner/202508/campaigns/{campaign_id}/products/{product_id}/performance
### Method: [GET]
### Function Description
Returns a paginated list of creators associated with a product in an affiliate partner campaign, together with available collaboration and performance details such as commission, free-sample status, follower count, and video and live broadcast counts.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| page_size | int | N | 10 | The number of results to be returned per page. Valid range: 1-50. |
| page_token | string | N | cGFnZV9udW1iZXI9Mg== | An opaque token used to retrieve the next page of a paginated result set. Retrieve this value from the result of the `next_page_token` from a previous response. It is not needed for the first page. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202508/campaigns/{campaign_id}/products/{product_id}/performance?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_size=10&page_token=cGFnZV9udW1iZXI9Mg==
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^total_creator_count | int | 1 | The total number of creators associated with the specified product in the campaign across all pages. |
| ^promotion_creators | []object |  | A list of objects representing information about the Affiliate Creator associated with the product promotion. |
| ^^paid_amount | object |  | An object representing the total amount paid for this product. |
| ^^^currency | string | USD | The currency code for the amount field. |
| ^^^amount | string | 3.00 | The total amount paid for this product. |
| ^^room_count | int | 1 | The number of live broadcast rooms associated with this promotion. |
| ^^video_count | int | 1 | The total number of videos associated with this promotion published by creators. |
| ^^free_sample_status | string | AWAITING_COLLECTION | Status of the Creator's sample application. |

* NOT_REQUESTED
* PENDING
* AWAITING_SHIPMENT
* AWAITING_COLLECTION
* SHIPPED
* CONTENT_PENDING
* REJECT_CANCELLED
* OVERDUE_CANCELLED
* UNFULFIL_CANCELLED
* DEL_PLAN_CANCELLED
* SELLER_NOT_SHIP_CANCELLED
* WITHDRAW_CANCELLED
* UNFULFILLABLE_CANCELLED
* OPERATOR_MANUAL_CANCELLED
* OPERATOR_MANUAL_FAILED
* OPERATOR_MANUAL_COMPLETED
* COMPLETED |
   ^^commission |string |100 |The commission rate in hundredths of a percent (0.01%). For example, a value of 1000 is 10.00%. |
   ^^effective_end_time |string |1731020040687 |The effective end time for the collaboration in Unix epoch time format. |
   ^^effective_start_time |string |1731019880391 |The effective start time for the collaboration in Unix epoch time format. |
   ^^creator |object | |An object representing information about the creator associated with the promotion. |
   ^^^nick_name |string |Test_Creator_E |The TikTok nickname of the creator. |
   ^^^avatar_url |string |https://p19-sign.tiktokcdn-us.com/tos-useast5-avt-0068-tx/c614d3b6ba4d93b31fbda5add0802dd7~c5_1080x1080.webp?lk3s=a5d48078&nonce=6796&refresh_token=634d776ec39c2291053675f60c576515&x-expires=1736478000&x-signature=0G6NmM8H8nDRYYVN7e8QazDMRb0%3D&shp=a5d48078&shcp=9f007bb8 |A URL for the creator's avatar image in the TikTok CDN. |
   ^^^follower_num |int |19 |The total count of TikTok followers for the creator. |
   ^^^user_name |string |us_lxq6213 |The TikTok username of the creator. |
   ^^^creator_open_id |string |uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg |Creator Open ID. More details:https://partner.tiktokshop.com/docv2/page/3obfokj6 |
   ^^affiliate_product_id |string |123456789 |The affiliate product identifier. |
   ^next_page_token |string |cGFnZV9udW1iZXI9Mg== |Opaque token for retrieving the next page. When this value is non-empty, pass it as the `page_token` query parameter in the next request and reuse the same `campaign_id`, `product_id`, and `page_size`. An empty token means there are no more results. |

### Response Sample
```json
{"code":0,"data":{"total_creator_count":1,"promotion_creators":[{"paid_amount":{"currency":"USD","amount":"3.00"},"room_count":1,"video_count":1,"free_sample_status":"AWAITING_COLLECTION","commission":"100","effective_end_time":"1731020040687","effective_start_time":"1731019880391","creator":{"nick_name":"Test_Creator_E","avatar_url":"https://p19-sign.tiktokcdn-us.com/tos-useast5-avt-0068-tx/c614d3b6ba4d93b31fbda5add0802dd7~c5_1080x1080.webp?lk3s=a5d48078\u0026nonce=6796\u0026refresh_token=634d776ec39c2291053675f60c576515\u0026x-expires=1736478000\u0026x-signature=0G6NmM8H8nDRYYVN7e8QazDMRb0%3D\u0026shp=a5d48078\u0026shcp=9f007bb8","follower_num":19,"user_name":"us_lxq6213","creator_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg"},"affiliate_product_id":"123456789"}],"next_page_token":"cGFnZV9udW1iZXI9Mg=="},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Affiliate Campaign Creator Product Content Statistics — `GET /affiliate_partner/202508/campaigns/{campaign_id}/products/{product_id}/creator/{creator_temp_id}/content/statistics`

Doc: https://partner.tiktokshop.com/docv2/page/get-affiliate-campaign-creator-product-content-statistics-202508 · cập nhật 2026-10-28 · scope: partner.tap_campaign.read

### Path: /affiliate_partner/202508/campaigns/{campaign_id}/products/{product_id}/creator/{creator_temp_id}/content/statistics
### Method: [GET]
### Function Description
Retrieves performance statistics for a creator's video or live-room content associated with an affiliate campaign product.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| campaign_id | string | Y | 123 | The campaign identifier. |
| product_id | string | Y | 123 | The product identifier. |
| creator_temp_id | string | Y | uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg | Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| affiliate_product_id | string | Y | 123456789 | The affiliate product identifier used to filter the returned content statistics. |
| content_type | string | N | VIDEO | Content type. Use `VIDEO` for video content or `LIVE_ROOM` for live-room content. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202508/campaigns/123/products/123/creator/uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg/content/statistics?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&affiliate_product_id=123456789&content_type=VIDEO
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^creator_content_statistics | []object |  | A list of objects that represent content statistics for the associated creator. |
| ^^content_type | string | VIDEO | Content type: `VIDEO` for video content or `LIVE_ROOM` for live-room content. |
| ^^cover_img_url | string | https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499 | A URL for the live room cover image in the TikTok CDN.The video content doesn't have this value. |
| ^^source_url | string | https://www.tiktok.com/@cbseveningnews/video/7458098283332767006?q=Victor%20Shaw%20Dies%20In%20Fire%20Rescue%20Attempt&t=1736545359958 | The URL on the public TikTok website at which the live room video can be played back. When content_type == VIDEO, the value is the url of the source video; when content_type == LIVE_ROOM, the value is the url where you can play back the recording of the live. |
|  |  |  |  |
| ^^view_count | string | 1 | The number of public views of the live room or video. |
| ^^like_count | string | 1 | The number of TikTok user likes associated with the live room or video. |
| ^^comment_num | string | 0 | The number of TikTok user comments associated with the live room or video. |
| ^^paid_order_num | string | 0 | The total number of paid orders associated with the live room or video. |
| ^^paid_amount | string | 0 | The aggregate value of product orders associated with the live room or video. |
| ^^linked_tiktok_video | string | http://xxx.tiktok.com/xxxx | The friendly URL for the video on the TikTok website. |
| ^^published_date | string | 2024-11-13 | When content_type == VIDEO, this is the date when the video was published; when content_type == LIVE_ROOM, this is the date when the live started. The value is in YYYY_MM_DD format. |
|  |  |  |  |
| ^^content_end_date | string | 2024-11-13 | When content_type == VIDEO, this field is None; when content_type == LIVE_ROOM, this is the date when the live ended. The value is in YYYY_MM_DD format. |
|  |  |  |  |
### Response Sample
```json
{"code":0,"data":{"creator_content_statistics":[{"content_type":"VIDEO","cover_img_url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499","source_url":"https://www.tiktok.com/@cbseveningnews/video/7458098283332767006?q=Victor%20Shaw%20Dies%20In%20Fire%20Rescue%20Attempt\u0026t=1736545359958","view_count":"1","like_count":"1","comment_num":"0","paid_order_num":"0","paid_amount":"0","linked_tiktok_video":"http://xxx.tiktok.com/xxxx","published_date":"2024-11-13","content_end_date":"2024-11-13"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Get Affiliate Campaign Creator Product Sample Status — `GET /affiliate_partner/202508/campaigns/{campaign_id}/products/{product_id}/creator/{creator_temp_id}/content/statistics/sample/status`

Doc: https://partner.tiktokshop.com/docv2/page/get-affiliate-campaign-creator-product-sample-status-202508 · cập nhật 2026-10-28 · scope: partner.tap_campaign.read

### Path: /affiliate_partner/202508/campaigns/{campaign_id}/products/{product_id}/creator/{creator_temp_id}/content/statistics/sample/status
### Method: [GET]
### Function Description
Retrieves delivery and tracking details for a creator's product sample in an affiliate campaign. The creator must have applied for a sample of the specified product before calling this API.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| campaign_id | string | Y | 123 | The campaign identifier. |
| product_id | string | Y | 123 | The product identifier. |
| creator_temp_id | string | Y | uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg | Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202508/campaigns/123/products/123/creator/uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg/content/statistics/sample/status?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^sample_status | object |  | The creator's sample status |
| ^^shipping_provider_name | string | USPS | The name of the shipping provider |
| ^^delivery_option | string | PREMIUM_SHIPPING | The delivery option: |

* ECONOMY_SHIPPING
* PREMIUM_SHIPPING
   |
   ^^estimated_earliest_delivery_date |string |1712941200 |The earliest estimated delivery date in Unix epoch format. |
   ^^estimated_latest_delivery_date |string |1712941200 |The latest estimated delivery date in Unix epoch format. |
   ^^quantity |int |1 |The quantity of products delivered. |
   ^^tracking_results |[]object | |A list of objects representing tracking events. |
   ^^^tracking_event_update_date |string |1712941200 |The date at which the tracking event was last updated, in Unix epoch format. |
   ^^^tracking_event_description |string |THE_PACKAGE_HAS_BEEN_DELIVERED |The title of the tracking event.
* THE_PACKAGE_HAS_BEEN_DELIVERED
* OUT_FOR_DELIVERY
* ORDER_PACKED_AND_READY_FOR_DROP_OFF_AT_CARRIERS_FACILITY
* ORDER_PLACED |
   ^^^tracking_event_description_extended |string |delivering | More information about the tracking event |

### Response Sample
```json
{"code":0,"data":{"sample_status":{"shipping_provider_name":"USPS","delivery_option":"PREMIUM_SHIPPING","estimated_earliest_delivery_date":"1712941200","estimated_latest_delivery_date":"1712941200","quantity":1,"tracking_results":[{"tracking_event_update_date":"1712941200","tracking_event_description":"THE_PACKAGE_HAS_BEEN_DELIVERED","tracking_event_description_extended":"delivering"}]}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16032001 | nvalid parameter Creator and Seller, please ensure Region mismatch. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Search CAP Affiliate Orders — `POST /affiliate_partner/202603/cap_order/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-cap-affiliate-orders-202603 · cập nhật 2026-10-28 · scope: partner.cap_orders.read

### Path: /affiliate_partner/202603/cap_order/search
### Method: [POST]
### Function Description
Search affiliate orders for an MCN (Creator Agency Partner) within the specified or default creation-time range. When multiple request-body filters are provided, `order_id`, `product_id`, `settle_status`, and the creation-time range are combined using AND semantics, so an order must match every supplied filter.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| page_token | string | N | 6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA+7D1ud64MPNz5OaT | Pagination token returned in `next_page_token` from the previous response. The token contains only the search-after sort position; it does not preserve the search filters or `page_size`. Omit this parameter for the first page. For each subsequent page, pass the returned token, provide a valid `page_size`, and resend the same partner authorization context and request-body filters used for the first page. The `page_size` value can be set independently for each page. For stable pagination, explicitly provide the same fixed `create_time_ge` and `create_time_lt` values on every request instead of relying on the rolling default time range. |
| page_size | int | Y | 20 | The default is 20, it must be positive integer, the range is 1-100 |
| category_asset_cipher | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| order_id | string | N | 576962796354307765 | Transaction main order ID |
| product_id | string | N | 1729435310697057093 | Unique identifier for Product |
| settle_status | int | N | 1 | Filter orders by settlement status. Send one of the following integer values; the response `settle_status` field uses the corresponding label: |

* `1` → `CUSTOMER UNPAID`: The customer has not paid for the order.
* `2` → `PENDING`: The customer can still return the order or request a refund, so earnings are estimated and awaiting settlement.
* `3` → `SETTLED`: Earnings have been settled to your account.
* `4` → `INELIGIBLE`: The order was returned, refunded, or canceled, so no commission will be settled.
* `5` → `FROZEN`: Possible fraud was detected; the commission will be unfrozen after the fraud is resolved. |
   create_time_ge |int |N |1791222188 |Filter orders created at or after this time. Unix timestamp in seconds. `create_time_ge` and `create_time_lt` must be provided together. An explicitly supplied range can span at most 92 days. If neither field is provided, the API searches from three calendar months before the request time through the request time. |
   create_time_lt |int |N |1791229388 |Filter orders created before this time. Unix timestamp in seconds. `create_time_ge` and `create_time_lt` must be provided together. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202603/cap_order/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_token=6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA+7D1ud64MPNz5OaT&page_size=20
```

**Body**
```json
{"order_id":"576962796354307765","product_id":"1729435310697057093","settle_status":1,"create_time_ge":1791222188,"create_time_lt":1791229388}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^sku_orders | []object |  | SKU orders returned for the current page. |
For monetary fields whose names start with `actual_`, the nested `amount` can be present only when `settle_status` is `SETTLED` or `INELIGIBLE`. For all other statuses, the `amount` property is omitted. Even for `SETTLED` or `INELIGIBLE` orders, an individual `actual_*` field can still omit `amount`. |
^^id |string |576962796354307765 |Transaction main order ID |
^^tags |string |test-01 |The customizable ID for each order, used for tracking performance at difference front end modules. |
^^create_time |int |1685548800 |Unix timestamp in seconds when the order was created (UTC). |
^^delivery_time |int |1685548800 |Unix timestamp in seconds when the order was delivered (UTC). This field is omitted when no delivery timestamp is available. |
^^settle_status |string |SETTLED |Settlement Status of the order.
Possible values:

1. "CUSTOMER UNPAID", customer hasn't paid for the orders.
2. "PENDING", customers can still return or get a refund for this order. The earnings shown are estimates and waiting for settlement.
3. "SETTLED", your earnings have already settled to your account
4. "INELIGIBLE", The order has been returned/refunded/canceled by the buyer, and no commission will be settled.
5. "FROZEN", Possible fraud has been detected regarding the order. The commission will be unfrozen after the fraud is resolved. |
   ^^sku_id |string |1729478689395213981 |The SKU identifier. |
   ^^open_collaboration_id |string |7324371012170024705 |The open collaboration identifier associated with the order. |
   ^^target_collaboration_id |string |7324371012170024705 |The target collaboration identifier associated with the order. |
   ^^creator_username |string |liuyi_id_creator1jigo |Creator username |
   ^^product_name |string |Black Hoodie |The product name. |
   ^^product_id |string |1729435310697057093 |Unique identifier for Product |
   ^^price |object | |The SKU selling price information |
   ^^^amount |string |99 |SKU sale price amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^quantity |int |1 |Number of SKU items in the order, including refunded items. |
   ^^shop_name |string |xuyann aaaaa |Shop / Seller name |
   ^^content_type |string |VIDEO |The content format of the creator content through which the order was created.
   Possible values:
* SHOP
* VIDEO
* LIVE
* PRE_LIVE
* PROMOTION_PAGE
* LINKSHARE |
   ^^content_id |string |7494337156519332665 |Unique identifier for content |
   ^^attribution_type |string |Direct |Attribution type for `LINKSHARE` content.
   Possible values:
* `Direct`: same-shop attribution.
* `Indirect`: non-same-shop attribution. The settlement commission rate is usually lower than the rate agreed in the Marketplace or target collaboration.

For other content types, this field is an empty string. |
^^commission_model |string |Tiered commission |Commission calculation model.
Possible values:

* `Fixed commission`
* `Tiered commission` |
   ^^commission_tier_setting |string |3 OR 5 |Seller-configured commission rates for a tiered commission model, expressed as percentages and separated by `OR`. Returns `-` for the fixed commission model. |
   ^^standard_commission_rate |int |3000 |Seller-to-creator standard commission rate. Returned as an integer in hundredths of a percent without a percent sign; for example, 3000 represents 30%. |
   ^^commission_bonus_rate |int |3000 |TTS-to-creator commission bonus rate. Returned as an integer in hundredths of a percent without a percent sign; for example, 3000 represents 30%. |
   ^^shop_ads_commission_rate |int |3000 |Shop Ads commission rate paid to the creator. Returned as an integer in hundredths of a percent without a percent sign; for example, 3000 represents 30%. |
   ^^tap_bonus_commission_rate |int |3000 |Commission bonus rate that the affiliate partner allocates to the creator. Returned as an integer in hundredths of a percent without a percent sign; for example, 3000 represents 30%. |
   ^^revenue_sharing_portion_rate |int |3000 |Revenue-sharing portion between the creator and agency. Returned as an integer in hundredths of a percent without a percent sign; for example, 3000 represents 30%. |
   ^^estimated_commission_base |object | |The estimated commission base is the product sale price multiplied by the number of products sold when the order is created. |
   ^^^amount |string |99 |Commission base amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_standard_commission |object | |Estimated standard commission on sales that a creator will obtain. |
   ^^^amount |string |99 |Commission amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_bonus_commission |object | |Estimated commission TTS pays well-performed creators |
   ^^^amount |string |99 |Commission amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_shop_ads_commission |object | |Estimated commission on sales that a creator will receive from seller/advertisers purchasing a specific creative |
   ^^^amount |string |99 |Commission amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_tap_bonus_commission |object | |Estimated commission bonus which TAP provided to creator |
   ^^^amount |string |99 |Commission amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_creator_tax_isr |object | |Only for Mexico creator, the platform collected related revenue taxes on behalf of government based on regulation. |
   ^^^amount |string |99 |The estimated creator ISR amount. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_creator_tax_iva |object | |Only for Mexico creator, the platform collected related revenue taxes on behalf of government based on regulation. |
   ^^^amount |string |99 |The estimated creator IVA amount. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_creator_tax_pit |object | |Only for VN/TH/PH/ID creators, sellers collect related withholding taxes based on regulation. |
   ^^^amount |string |99 |The estimated creator PIT amount. |
   ^^^currency |string |USD |The currency code. |
   ^^estimated_creator_total_earnings_after_tax |object | |Total after-tax earnings for creator before splitting revenue with agency |
   ^^^amount |string |99 |The estimated creator earnings amount |
   ^^^currency |string |USD |The currency code. |
   ^^estimated_total_agency_earnings |object | |Total after-tax earnings for agency |
   ^^^amount |string |1 |The estimated agency earnings amount |
   ^^^currency |string |USD |The currency code. |
   ^^estimated_agency_isr |object | |Estimated ISR tax amount for Mexico agency |
   ^^^amount |string |99 |Tax amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_agency_iva |object | |Estimated IVA tax amount for Mexico agency |
   ^^^amount |string |99 |Tax amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_commission_base |object | |The actual commission base is the product sale price multiplied by the number of products sold, excluding returned and refunded orders. |
   ^^^amount |string |100 |Commission base amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_standard_commission |object | |Actual commission on sales that a creator will obtain before revenue spliting |
   ^^^amount |string |100 |Commission amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_bonus_commission |object | |The creator's actual TikTok Shop bonus commission. |
   ^^^amount |string |100 |Commission amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_shop_ads_commission |object | |actual commission on sales that a creator will receive from seller/advertisers purchasing a specific creative |
   ^^^amount |string |100 |Commission amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_tap_bonus_commission |object | |Actual commission bonus which TAP provided to creator |
   ^^^amount |string |100 |Actual TAP Bonus Commission amount |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_creator_tax_isr |object | |Only for Mexico creator, the platform collected related revenue taxes on behalf of government based on regulation. |
   ^^^amount |string |1 |The actual creator ISR amount. |
   ^^^currency |string |USD |The currency code. |
   ^^actual_creator_tax_iva |object | |Only for Mexico creator, the platform collected related revenue taxes on behalf of government based on regulation. |
   ^^^amount |string |1 |The actual creator IVA amount. |
   ^^^currency |string |USD |The currency code. |
   ^^actual_creator_tax_pit |object | |Only for VN/TH/PH/ID creators, sellers collected related withholding taxes based on regulation. |
   ^^^amount |string |1 |The actual creator PIT amount. |
   ^^^currency |string |USD |The currency code. |
   ^^actual_creator_total_earnings_after_tax |object | |Total after-tax earnings for creator before splitting revenue with agency |
   ^^^amount |string |1 |The actual creator's earnings amount |
   ^^^currency |string |USD |The currency code. |
   ^^actual_total_agency_commission |object | |Total after-tax earnings for agency |
   ^^^amount |string |1 |The actual agency earnings amount |
   ^^^currency |string |USD |The currency code. |
   ^^actual_agency_isr |object | |The actual ISR tax amount for Mexico agency |
   ^^^amount |string |99 |Tax amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_agency_iva |object | |The actual IVA tax amount for Mexico agency |
   ^^^amount |string |99 |Tax amount without a currency symbol. Use the sibling `currency` field to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^fully_return |string |Yes |Whether this SKU order was fully returned or refunded.
   Possible values:
* `Yes`: this SKU order was fully returned or refunded, and no commission is paid.
* `No`: this SKU order was not fully returned or refunded. |
   ^^settlement_time |int |1775548800 |Unix timestamp in seconds when the order commission was settled (UTC). This field is omitted when no settlement timestamp is available. |
   ^^last_update_time |int |1685548800 |Unix timestamp in seconds when the record was last updated (UTC). |
   ^^is_carousel |bool |false |Carousel content may involve a commission rate discount. Returns true when the SKU order is attributed to carousel content. |
   ^next_page_token |string |6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA+7D1ud64MPNz5OaT |Pagination token for the next page. The token contains only the search-after sort position; it does not preserve the search filters or `page_size`. If this field is returned, pass it as `page_token` in the next request, provide a valid `page_size`, and resend the same partner authorization context and request-body filters used for the first page. The `page_size` value can be set independently for each page. For stable pagination, explicitly provide the same fixed `create_time_ge` and `create_time_lt` values on every request instead of relying on the rolling default time range. Stop paginating when this field is omitted. The field is omitted when the returned page contains fewer records than `page_size`. |
   ^total_count |int |100 |Total number of SKU orders matching the current search criteria across all pages. |

### Response Sample
```json
{"code":0,"data":{"sku_orders":[{"id":"576962796354307765","tags":"test-01","create_time":1685548800,"delivery_time":1685548800,"settle_status":"SETTLED","sku_id":"1729478689395213981","open_collaboration_id":"7324371012170024705","target_collaboration_id":"7324371012170024705","creator_username":"liuyi_id_creator1jigo","product_name":"Black Hoodie","product_id":"1729435310697057093","price":{"amount":"99","currency":"USD"},"quantity":1,"shop_name":"xuyann aaaaa","content_type":"VIDEO","content_id":"7494337156519332665","attribution_type":"Direct","commission_model":"Tiered commission","commission_tier_setting":"3 OR 5","standard_commission_rate":3000,"commission_bonus_rate":3000,"shop_ads_commission_rate":3000,"tap_bonus_commission_rate":3000,"revenue_sharing_portion_rate":3000,"estimated_commission_base":{"amount":"99","currency":"USD"},"estimated_standard_commission":{"amount":"99","currency":"USD"},"estimated_bonus_commission":{"amount":"99","currency":"USD"},"estimated_shop_ads_commission":{"amount":"99","currency":"USD"},"estimated_tap_bonus_commission":{"amount":"99","currency":"USD"},"estimated_creator_tax_isr":{"amount":"99","currency":"USD"},"estimated_creator_tax_iva":{"amount":"99","currency":"USD"},"estimated_creator_tax_pit":{"amount":"99","currency":"USD"},"estimated_creator_total_earnings_after_tax":{"amount":"99","currency":"USD"},"estimated_total_agency_earnings":{"amount":"1","currency":"USD"},"estimated_agency_isr":{"amount":"99","currency":"USD"},"estimated_agency_iva":{"amount":"99","currency":"USD"},"actual_commission_base":{"amount":"100","currency":"USD"},"actual_standard_commission":{"amount":"100","currency":"USD"},"actual_bonus_commission":{"amount":"100","currency":"USD"},"actual_shop_ads_commission":{"amount":"100","currency":"USD"},"actual_tap_bonus_commission":{"amount":"100","currency":"USD"},"actual_creator_tax_isr":{"amount":"1","currency":"USD"},"actual_creator_tax_iva":{"amount":"1","currency":"USD"},"actual_creator_tax_pit":{"amount":"1","currency":"USD"},"actual_creator_total_earnings_after_tax":{"amount":"1","currency":"USD"},"actual_total_agency_commission":{"amount":"1","currency":"USD"},"actual_agency_isr":{"amount":"99","currency":"USD"},"actual_agency_iva":{"amount":"99","currency":"USD"},"fully_return":"Yes","settlement_time":1775548800,"last_update_time":1685548800,"is_carousel":false}],"next_page_token":"6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA+7D1ud64MPNz5OaT","total_count":100},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Search TAP Affiliate Orders — `POST /affiliate_partner/202603/orders/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-tap-affiliate-orders-202603 · cập nhật 2026-10-28 · scope: partner.tap_campaign.read

### Path: /affiliate_partner/202603/orders/search
### Method: [POST]
### Function Description
TAP can use this API to retrieve a list of affiliate orders and track the affiliate conversions.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
| category_asset_cipher | query | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| page_token | string | N | 6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA+7D1ud64MPNz5OaT | The pagination token returned in `next_page_token` from the previous response. When paginating, provide `create_time_ge` and `create_time_lt` in the first request, then pass this token and reuse the same `campaign_id` (if specified), `create_time_ge`, and `create_time_lt` values in every subsequent request. |
| page_size | int | Y | 20 | The default is 20, it must be positive integer, the range is 1-100 |
| category_asset_cipher | string | Y | GCP_XF90igAAAABh00qsWgtvOiGFNqyubMt3 | The partner identifier used in API requests. Retrieve this value by using the [Get Authorized Category Assets API](https://partner.tiktokshop.com/docv2/page/666012dd609d4402cc3be995). |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| create_time_ge | int | N | 1623812664 | Filter orders created at or after this time, specified as a Unix timestamp in seconds (UTC). |
`create_time_ge` and `create_time_lt` must be provided together, and the interval must not exceed three months. If both fields are omitted, the API queries orders from the last three months. |
create_time_lt |int |N |1623899064 |Filter orders created before this time, specified as a Unix timestamp in seconds (UTC). See `create_time_ge` for the pairing, interval, and default behavior. |
campaign_id |string |N |7324371012170024705 |Filter orders by a TAP campaign using its identifier. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_partner/202603/orders/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&category_asset_cipher=ROW_RHkDDABBAAB8tKAVoAqsMTjsQZFLyNfY&page_token=6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA+7D1ud64MPNz5OaT&page_size=20
```

**Body**
```json
{"create_time_ge":1623812664,"create_time_lt":1623899064,"campaign_id":"7324371012170024705"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^sku_orders | []object |  | SKU-level affiliate order records. Estimated commission amount fields are populated when the corresponding estimated component is available. Actual commission amount fields are populated only for `SETTLED` or `INELIGIBLE` orders and are omitted before those states; an individual actual amount can still be omitted when its underlying component is unavailable. |
| ^^id | string | 576962796354307765 | Transaction main order ID |
| ^^create_time | int | 1685548800 | The order creation time as a Unix timestamp in seconds (UTC). |
| ^^delivery_time | int | 1685548800 | The order delivery time as a Unix timestamp in seconds (UTC). |
| ^^settle_status | string | SETTLED | Settlement Status of the order. |
| Possible values: |  |  |  |

1. "CUSTOMER UNPAID", customer hasn't paid for the orders.
2. "PENDING", customers can still return or get a refund for this order. The earnings shown are estimates and waiting for settlement.
3. "SETTLED", your earnings have already settled to your account
4. "INELIGIBLE", The order has been returned/refunded/canceled by the buyer, and no commission will be settled.
5. "FROZEN", Possible fraud has been detected regarding the order. The commission will be unfrozen after the fraud is resolved. |
   ^^sku_id |string |1729793769377925388 |sku ID |
   ^^campaign_id |string |7324371012170024705 |The identifier of the TAP campaign associated with the order. |
   ^^creator_username |string |liuyi_id_creator1jigo |Creator username |
   ^^product_name |string |Black Hoodie |The product name. |
   ^^product_id |string |1729435310697057093 |Unique identifier for Product |
   ^^price |object | |Price |
   ^^^amount |string |99 |The price amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^quantity |int |1 |Number of SKU items in the order, including refunded items. |
   ^^content_type |string |VIDEO |The content format of the creator content through which the order was created.
   Possible values:
* SHOP
* VIDEO
* LIVE
* PRE_LIVE
* PROMOTION_PAGE
* LINKSHARE |
   ^^content_id |string |7494337156519332665 |Unique identifier for content |
   ^^creator_standard_commission_rate |int |3000 |The creator standard commission rate, scaled by 10,000. For example, `3000` represents 30%. |
   ^^partner_standard_commission_rate |int |4000 |The affiliate partner's standard commission rate, scaled by 10,000. For example, `4000` represents 40%. |
   ^^creator_shop_ads_commission_rate |int |3000 |The creator Shop Ads commission rate, scaled by 10,000. For example, `3000` represents 30%. |
   ^^partner_shop_ads_commission_rate |int |4000 |The affiliate partner's Shop Ads commission rate, scaled by 10,000. For example, `4000` represents 40%. |
   ^^partner_tap_bonus_commission_rate |int |1000 |The additional commission rate TikTok Shop offers to affiliate partners for driving product sales in specific campaigns, scaled by 10,000. For example, `1000` represents 10%. |
   ^^creator_tap_bonus_commission_rate |int |2000 |The commission reward rate allocated by the affiliate partner to the creator, scaled by 10,000. For example, `2000` represents 20%. |
   ^^estimated_commission_base |object | |The estimated commission base is the item price multiplied by the number of items ordered at the time the order is created. |
   ^^^amount |string |99 |The estimated commission base amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_creator_standard_commission |object | |Estimated TAP commission x creator commission rate |
   ^^^amount |string |100 |The estimated creator standard commission amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_partner_standard_commission |object | |Estimated commission base x TAP commission rate |
   ^^^amount |string |100 |The estimated affiliate partner standard commission amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_creator_shop_ads_commission |object | |Estimated commission base x creator shop ads commission rate |
   ^^^amount |string |99 |The estimated creator Shop Ads commission amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_partner_shop_ads_commission |object | |Estimated commission base x partner shop ads commission rate |
   ^^^amount |string |99 |The estimated affiliate partner Shop Ads commission amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_partner_tap_bonus_commission |object | |Estimated partner commission reward fee |
   ^^^amount |string |100 |The estimated affiliate partner commission reward amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_creator_tap_bonus_commission |object | |Estimated creator commission reward fee |
   ^^^amount |string |100 |The estimated creator commission reward amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_partner_isr |object | |Estimated ISR tax amount for Mexico partner |
   ^^^amount |string |99 |The estimated ISR tax amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^estimated_partner_iva |object | |Estimated IVA tax amount for Mexico partner |
   ^^^amount |string |99 |The estimated IVA tax amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_commission_base |object | |The actual commission base is the item price multiplied by the number of items ordered minus returns at the time the order is completed. |
   ^^^amount |string |200 |The actual commission base amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_creator_standard_commission |object | |Actual TAP commission x creator commission rate |
   ^^^amount |string |100 |The actual creator standard commission amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_partner_standard_commission |object | |Actual commission base x TAP commission rate |
   ^^^amount |string |99 |The actual affiliate partner standard commission amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_creator_shop_ads_commission |object | |actual commission base x creator shop ads commission rate |
   ^^^amount |string |99 |The actual creator Shop Ads commission amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_partner_shop_ads_commission |object | |actual commission base x partner shop ads commission rate |
   ^^^amount |string |99 |The actual affiliate partner Shop Ads commission amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_partner_isr |object | |Actual ISR tax amount for Mexico partner |
   ^^^amount |string |99 |The actual ISR tax amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_partner_iva |object | |actual IVA tax amount for Mexico partner |
   ^^^amount |string |99 |The actual IVA tax amount without a currency symbol. Use `currency` to identify the currency. |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_partner_tap_bonus_commission |object | |Actual partner commission reward fee |
   ^^^amount |string |200 |The actual fee affiliate partners earn from commission rewards |
   ^^^currency |string |USD |Type of currency use |
   ^^actual_creator_tap_bonus_commission |object | |Actual creator commission reward fee |
   ^^^amount |string |100 |The actual fee creators receive from affiliate partners through commission rewards |
   ^^^currency |string |USD |Type of currency use |
   ^^fully_return |string |Yes |Whether the SKU was fully returned or refunded.
   Possible values:
* `Yes`: The SKU was fully returned or refunded, and no commission is paid.
* `No`: The SKU was not fully returned or refunded. |
   ^^settlement_time |int |1685548800 |The time when the order commission was settled, as a Unix timestamp in seconds (UTC). |
   ^^last_update_time |int |1685548800 |The time when the record was last updated, as a Unix timestamp in seconds (UTC). |
   ^^is_carousel |bool |false |Carousel content may involve a commission rate discount. Returns true when the order is attributed to carousel content. |
   ^next_page_token |string |6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA+7D1ud64MPNz5OaT |Pass this pagination token as `page_token` in the next request. Reuse the same `campaign_id` (if specified), `create_time_ge`, and `create_time_lt` values for every page; specify both time bounds in the first request to keep the search window fixed. Stop paginating when this field is omitted. |
   ^total_count |int |100 |The total number of SKU orders matching the request filters across all pages. |

### Response Sample
```json
{"code":0,"data":{"sku_orders":[{"id":"576962796354307765","create_time":1685548800,"delivery_time":1685548800,"settle_status":"SETTLED","sku_id":"1729793769377925388","campaign_id":"7324371012170024705","creator_username":"liuyi_id_creator1jigo","product_name":"Black Hoodie","product_id":"1729435310697057093","price":{"amount":"99","currency":"USD"},"quantity":1,"content_type":"VIDEO","content_id":"7494337156519332665","creator_standard_commission_rate":3000,"partner_standard_commission_rate":4000,"creator_shop_ads_commission_rate":3000,"partner_shop_ads_commission_rate":4000,"partner_tap_bonus_commission_rate":1000,"creator_tap_bonus_commission_rate":2000,"estimated_commission_base":{"amount":"99","currency":"USD"},"estimated_creator_standard_commission":{"amount":"100","currency":"USD"},"estimated_partner_standard_commission":{"amount":"100","currency":"USD"},"estimated_creator_shop_ads_commission":{"amount":"99","currency":"USD"},"estimated_partner_shop_ads_commission":{"amount":"99","currency":"USD"},"estimated_partner_tap_bonus_commission":{"amount":"100","currency":"USD"},"estimated_creator_tap_bonus_commission":{"amount":"100","currency":"USD"},"estimated_partner_isr":{"amount":"99","currency":"USD"},"estimated_partner_iva":{"amount":"99","currency":"USD"},"actual_commission_base":{"amount":"200","currency":"USD"},"actual_creator_standard_commission":{"amount":"100","currency":"USD"},"actual_partner_standard_commission":{"amount":"99","currency":"USD"},"actual_creator_shop_ads_commission":{"amount":"99","currency":"USD"},"actual_partner_shop_ads_commission":{"amount":"99","currency":"USD"},"actual_partner_isr":{"amount":"99","currency":"USD"},"actual_partner_iva":{"amount":"99","currency":"USD"},"actual_partner_tap_bonus_commission":{"amount":"200","currency":"USD"},"actual_creator_tap_bonus_commission":{"amount":"100","currency":"USD"},"fully_return":"Yes","settlement_time":1685548800,"last_update_time":1685548800,"is_carousel":false}],"next_page_token":"6AsPQsUMvH3RkchNUPPh22NROHkE0D8pmq/N5M1kHYcZmtRyv9aVrNv65W7Q6tFA+7D1ud64MPNz5OaT","total_count":100},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |

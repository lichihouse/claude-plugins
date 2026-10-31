# Affiliate creator — tài liệu chi tiết

> Nguồn: TikTok Shop Partner Center docv2, tải về 2026-10-31 bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.




---

## Affiliate Creator API overview

Doc: https://partner.tiktokshop.com/docv2/page/affiliate-creator-api-overview · cập nhật 2026-09-21

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

## Get Creator Profile — `GET /affiliate_creator/202508/profiles`

Doc: https://partner.tiktokshop.com/docv2/page/get-creator-profile-202508 · cập nhật 2026-10-13 · scope: creator.affiliate.info, creator.video.write

### Path: /affiliate_creator/202508/profiles
### Method: [GET]
### Function Description
Retrieves profile information for the creator associated with the access token. The creator must have a configured sales region; otherwise, the request fails with a precondition error.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
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
https://open-api.tiktokglobalshop.com/affiliate_creator/202508/profiles?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^avatar | object |  | Data associated with the TikTok creator's profile avatar. |
| ^^width | int | 100 | The avatar image width in pixels. |
| ^^height | int | 100 | The avatar image height in pixels. |
| ^^url | string | https://p16-sign.tiktokcdn-us.com/tos-useast5-avt-0068-tx/d76b8cc1b598de90ad5048df46e672b3~c5_100x100.webp?x-expires=1691895600&x-signature=oAT9KOL7aCN3Did9U%2FoKEsbBDj0%3D | The URL for the TikTok creator's avatar image file. |
| ^username | string | abc123 | The TikTok user name. |
| ^selection_region | string | US | The region in which the creator is eligible to promote products in showcases, videos, and live streams. |
| ^register_region | string | US | The region in which the creator's TikTok account is registered. |
| ^seller_type | string | LOCAL | If the creator is also also has a TikTok Shop seller account, the seller type of the creator. This is an enumerated type with values: |

* CROSS_BORDER
* LOCAL |
   ^permissions |[]string |["LIVE_STREAM_PERMISSION","SELF_SALE_PERMISSION","ADD_AFFILIATE_PERMISSION"] |A list of product promotion permissions for the creator. The list can include zero or more of the following permissions:
* LIVE_STREAM_PERMISSION
* SELF_SALE_PERMISSION
* ADD_AFFILIATE_PERMISSION
* PHOTO_SHOPPABLE_PERMISSION_PRODUCT
* PHOTO_SHOPPABLE_PERMISSION_SHOP |
   ^user_type |string |TIKTOK_SHOP_OFFICIAL_ACCOUNT |The creator's user type. This is an enumerated type with values:
* TIKTOK_SHOP_OFFICIAL_ACCOUNT
* TIKTOK_MARKETING_ACCOUNT
* TIKTOK_SHOP_CREATOR |
   ^creator_user_open_id |string |uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg |Creator Open ID. [More details](https://partner.tiktokshop.com/docv2/page/3obfokj6) |

### Response Sample
```json
{"code":0,"data":{"avatar":{"width":100,"height":100,"url":"https://p16-sign.tiktokcdn-us.com/tos-useast5-avt-0068-tx/d76b8cc1b598de90ad5048df46e672b3~c5_100x100.webp?x-expires=1691895600\u0026x-signature=oAT9KOL7aCN3Did9U%2FoKEsbBDj0%3D"},"username":"abc123","selection_region":"US","register_region":"US","seller_type":"LOCAL","permissions":["LIVE_STREAM_PERMISSION","SELF_SALE_PERMISSION","ADD_AFFILIATE_PERMISSION"],"user_type":"TIKTOK_SHOP_OFFICIAL_ACCOUNT","creator_user_open_id":"uACafQAAAABmUU2qon4R0vUYvUVS3QC6CICP2m5A2-wd77j8R9G0yg"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16015006 | There is no selection region in this creator now. please contact the creator and ensure he has ec permission now. |
| 16015007 | no sale region error; detail: creator has no sale region. |
| 16501011 | user has no permission to access this api. please check the creator auth info. |
| 16504002 | query creator info failed.Please check creator ec permission is avaliable now |
| 36009002 | Too many requests. You've made too many requests in a short period of time. |


---

## Get Showcase Products — `GET /affiliate_creator/202405/showcases/products`

Doc: https://partner.tiktokshop.com/docv2/page/get-showcase-products-202405 · cập nhật 2026-10-13 · scope: creator.showcase.read, creator.video.write

### Path: /affiliate_creator/202405/showcases/products
### Method: [GET]
### Function Description
This API lists the products in the creator's showcase, paginated by specified page size and iterated through pages by page token for up to 2000 products in the showcase. This API is generally used when a creator would like to view the products in the showcase. The platform will return the product details in the showcase, as well as the products in the livebag if the creator is live streaming.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| page_size | int | Y | 10 | The number of results to be returned per page. Valid range: [1-20]. |
| page_token | string | N | V231as2V0PTAK | An opaque token used to retrieve the next page of a paginated result set. Retrieve this value from the result of the next_page_token from a previous response. It is not needed for the first page. |
| origin | string | Y | LIVE | Set to `LIVE` to indicate the request originates from a Live room. Set to `SHOWCASE` to indicate that the request originates from the Showcase. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202405/showcases/products?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&page_size=10&page_token=V231as2V0PTAK&origin=LIVE
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^products | []object |  | A list of products. |
| ^^id | string | 53219092314 | The product's product ID |
| ^^shop | object |  | Data and metadata associated with the Seller's TikTok Shop. |
| ^^^name | string | Gift store | The TikTok Shop name. |
| ^^addition | object |  | An object including data about product images. |
| ^^^customized_main_images | []object |  | A list of product images. |
| ^^^^width | int | 100 | The image width in pixels. |
| ^^^^heigth | int | 100 | The image height in pixels. |
| ^^^^url | string | https://p16-sign.tiktokcdn-us.com/tos-useast5-avt-0068-tx/d76b8cc1b598de90ad5048df46e672b3~c5_100x100.webp?x-expires=1691895600&x-signature=oAT9KOL7aCN3Did9U%2FoKEsbBDj0%3D | The product's TikTok Shop image URL. |
| ^^price | object |  | An object including data about the product price. |
| ^^^original_price | object |  | The original price of the product. |
| ^^^^minimum_amount | string | 12.21 | The lowest original price for the product. |
| ^^^^maximum_amount | string | 100.00 | The highest original price for the product. |
| ^^^^currency | string | USD | The ISO 4217 currency code. |
| ^^^seller_discount_price | object |  | An object including data about the product discount price. |
| ^^^^minimum_amount | string | 12.21 | The lowest discount price. |
| ^^^^maximum_amount | string | 100.00 | The highest discount price. |
| ^^^^currency | string | USD | The ISO 4217 currency code. |
| ^^^platform_discount_price | object |  | An object including data about the product platform discount price. |
| ^^^^minimum_amount | string | 12.21 | The lowest product platform discount price. |
| ^^^^maximum_amount | string | 100.00 | The highest product platform discount price. |
| ^^^^currency | string | USD | The ISO 4217 currency code. |
| ^^title | string | Chirstmas Gift | The product's display title. |
| ^^main_images | []object |  | A list of product images. |
| ^^^width | int | 100 | The image width in pixels. |
| ^^^heigth | int | 100 | The image height in pixels. |
| ^^^url | string | https://p16-sign.tiktokcdn-us.com/tos-useast5-avt-0068-tx/d76b8cc1b598de90ad5048df46e672b3~c5_100x100.webp?x-expires=1691895600&x-signature=oAT9KOL7aCN3Did9U%2FoKEsbBDj0%3D | The product's TikTok Shop image URL. |
| ^^status | object |  | An object including product status information. |
| ^^^inventory_status | string | IN_STOCK | The product inventory status. This an enumerated type with values: |

* IN_STOCK
* SOLD_OUT |
   ^^^review_status |string |APPROVED |The product review status. This is an enumerated type with values:
* APPROVED
* UNDER_REVIEW
* CHANGES_UNDER_REVIEW
* UNAVAILABLE
* REJECTED
* ZERO_COMMISSION |
   ^^^is_hidden |bool |false |Set to `false` if the product is visible in the showcase. Set to `true` if the product is hidden from the showcase. |
   ^^^added_status |string |ADDED |The product's add status for the request origin. For `SHOWCASE`, `ADDED` indicates that the product is in the showcase, while `REJECTED` indicates that the product is rejected for use in the current context. For `LIVE`, `ADDED` means the product is already in the Live room's product list (live bag), `NOT_ADDED` means the product can be added, and `REJECTED` means the product cannot be added. |
   ^^source |string |AFFILIATE |The product source. This is an enumerated type with values:
* THIRD_PARTY
* AFFILIATE
* TIKTOK_STORE |
   ^^detail_link |string |https://shop.tiktok.com/view/product/248901892031?region=US&local=en |The product detail page URL. |
   ^^third_party_link |string |https://storename.myshopify.com/products/gold-bracelet-engraved-with-diamonds |The off-TikTok Shop product detail page URL. |
   ^^sale_regions |[]string |["US"] |A list of regions in which the product is offered for sale. |
   ^^commission |object | |An object including data about commissions associated with the product. |
   ^^^rate |int |3000 |The commission rate in hundredths of a percent. For example, `3587` is a commission rate of `35.87%`. The range of this value is [100, 8000]. |
   ^^^reward_rate |int |500 |The reward commission rate in hundredths of a percent. For example, `3587` is a commission rate of `35.87%`. |
   ^^collaboration |object | |An object containing collaboration data for the product. |
   ^^^id |string |7495383576027499219 |The collaboration identifier. |
   ^^^type |string |1 |The collaboration type. This an enumerated type with values:
   1 - Open Collaboration
   2 - Target Collaboration
   5 - Partner Campaign
   11 - Flat Fee
   12 - Collaboration Plus
   13 - Affiliate Promotion |
   ^^^partner |object | |The partner information. |
   ^^^^id |string |123456789 |The partner identifier. |
   ^^^^name |string |Partner Name |The partner name. |
   ^next_page_token |string |V231as2V0PTAK |An opaque token used to retrieve the next page of a paginated result set. |
   ^total_count |int |15 |Total count of products in the response. |

### Response Sample
```json
{"code":0,"data":{"products":[{"id":"53219092314","shop":{"name":"Gift store"},"addition":{"customized_main_images":[{"width":100,"heigth":100,"url":"https://p16-sign.tiktokcdn-us.com/tos-useast5-avt-0068-tx/d76b8cc1b598de90ad5048df46e672b3~c5_100x100.webp?x-expires=1691895600\u0026x-signature=oAT9KOL7aCN3Did9U%2FoKEsbBDj0%3D"}]},"price":{"original_price":{"minimum_amount":"12.21","maximum_amount":"100.00","currency":"USD"},"seller_discount_price":{"minimum_amount":"12.21","maximum_amount":"100.00","currency":"USD"},"platform_discount_price":{"minimum_amount":"12.21","maximum_amount":"100.00","currency":"USD"}},"title":"Chirstmas Gift","main_images":[{"width":100,"heigth":100,"url":"https://p16-sign.tiktokcdn-us.com/tos-useast5-avt-0068-tx/d76b8cc1b598de90ad5048df46e672b3~c5_100x100.webp?x-expires=1691895600\u0026x-signature=oAT9KOL7aCN3Did9U%2FoKEsbBDj0%3D"}],"status":{"inventory_status":"IN_STOCK","review_status":"APPROVED","is_hidden":false,"added_status":"ADDED"},"source":"AFFILIATE","detail_link":"https://shop.tiktok.com/view/product/248901892031?region=US\u0026local=en","third_party_link":"https://storename.myshopify.com/products/gold-bracelet-engraved-with-diamonds","sale_regions":["US"],"commission":{"rate":3000,"reward_rate":500},"collaboration":{"id":"7495383576027499219","type":"1","partner":{"id":"123456789","name":"Partner Name"}}}],"next_page_token":"V231as2V0PTAK","total_count":15},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 18001405 | This creator account has no selection region. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Add Showcase Products — `POST /affiliate_creator/202405/showcases/products/add`

Doc: https://partner.tiktokshop.com/docv2/page/add-showcase-products-202405 · cập nhật 2026-10-13 · scope: creator.showcase.write, creator.video.write

### Path: /affiliate_creator/202405/showcases/products/add
### Method: [POST]
### Function Description
This API adds products to the authenticated creator's showcase. Global Shop users must have at least one selected region before calling this API. A successful API response can still contain `errors` for products that were not added; when there are no product-level addition errors, `errors` is omitted.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
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
| add_type | string | Y | PRODUCT_ID | Specifies how products are added to the showcase. This an enumerated type with values: |

* PRODUCT_ID
* PRODUCT_LINK |
   product_ids |[]string |N |["12390753231","7102893481290"] |A list of product identifiers included if `add_type` is set to `PRODUCT_ID`. The products associated with the identifiers are added to the showcase. Maximum length of the list is 20 product identifiers. |
   product_link |string |N |https://www.example.com/api/v1/share/AImHx6DlXqP1 |A product URL to use when `add_type` is set to `PRODUCT_LINK`. The product associated with the URL is added to the showcase. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202405/showcases/products/add?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

**Body**
```json
{"add_type":"PRODUCT_ID","product_ids":["12390753231","7102893481290"],"product_link":"https://www.example.com/api/v1/share/AImHx6DlXqP1"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^errors | []object |  | A list of product showcase addition errors. |
| ^^code | int | 16001001 | The error code. |
| ^^message | string | Encounter network error, please try again. | A human-readable error message. |
| ^^detail | object |  | Additional detail about the product showcase addition error. |
| ^^^product_id | string | 12390753231 | The product identifier. |
### Response Sample
```json
{"code":0,"data":{"errors":[{"code":16001001,"message":"Encounter network error, please try again.","detail":{"product_id":"12390753231"}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Remove Showcase Products — `DELETE /affiliate_creator/202409/showcases/products`

Doc: https://partner.tiktokshop.com/docv2/page/remove-showcase-products-202409 · cập nhật 2026-10-13 · scope: creator.showcase.write

### Path: /affiliate_creator/202409/showcases/products
### Method: [DELETE]
### Function Description
This API removes the products in the creator's showcase.
The platform will return error code and error message if the deletion fails.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
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
| product_ids | []string | Y | ["12390753231","7102893481290"] | The product IDs to remove from the creator's showcase. Specify at least one product ID. The maximum number of products to delete at once is 200. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202409/showcases/products?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

**Body**
```json
{"product_ids":["12390753231","7102893481290"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^code | int | 0 | The success or failure status code returned in API response. |
| ^message | string | Success | The success or failure messages are returned in API response. Reasons of failure will be described in the message. |
| ^request_id | string | 202203070749000101890810281E8C70B7 | Every request generates a unique request_id for logging purposes. |
### Response Sample
```json
{"code":0,"data":{"code":0,"message":"Success","request_id":"202203070749000101890810281E8C70B7"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16015001 | Invalid parameter, the product Ids are not correct. Please ensure the products are in the showcase right now. |
| 16015027 | System error |


---

## Move Showcase Products to the Top — `POST /affiliate_creator/202409/showcases/products/top`

Doc: https://partner.tiktokshop.com/docv2/page/move-showcase-products-to-the-top-202409 · cập nhật 2026-10-13 · scope: creator.showcase.write

### Path: /affiliate_creator/202409/showcases/products/top
### Method: [POST]
### Function Description
Use this API to move products to the top of the authenticated creator's showcase.
The platform will return the error code and error message if the pinning operation fails.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
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
| product_ids | []string | Y | ["12390753231","7102893481290"] | The IDs of products that are already in the creator's showcase and should be moved to the top. If you provide multiple product IDs, the products are displayed at the top in the same order as the IDs in this array. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202409/showcases/products/top?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

**Body**
```json
{"product_ids":["12390753231","7102893481290"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^code | int | 0 | The success or failure status code returned in API response. |
| ^message | string | Success | The success or failure messages are returned in API response. Reasons of failure will be described in the message. |
| ^request_id | string | 202203070749000101890810281E8C70B7 | Every request generates a unique request_id for logging purposes. |
### Response Sample
```json
{"code":0,"data":{"code":0,"message":"Success","request_id":"202203070749000101890810281E8C70B7"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16015001 | Invalid parameter, the product Ids are not correct. Please ensure the products are in the showcase right now. |
| 16015027 | System error |


---

## Search Open Collaboration Products — `POST /affiliate_creator/202405/open_collaborations/products/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-open-collaboration-products-202405 · cập nhật 2026-10-13 · scope: creator.affiliate_collaboration.read

### Path: /affiliate_creator/202405/open_collaborations/products/search
### Method: [POST]
### Function Description
This API is used to search the information of products with open collaboration by category, commission rate, and keywords. It will return all products on the TikTok Shop Affiliate Product Marketplace that are in an open collaboration.
Creators can only search for open collaboration within the regions they are registered in the affiliate.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| page_token | string | N | b2Zmc2V0PTAK | Pagination token. Leave this parameter empty in the first request. To retrieve the next page, pass the `next_page_token` returned by the previous response and reuse the same `category`, `commission_rate_range`, `sales_price_range`, `title_keywords`, `sort_field`, `sort_order`, and `page_size` values. An empty `next_page_token` means there are no more pages. |
| page_size | int | Y | 20 | The value of "page_size" must be greater than 0 and less than or equal to 20. |
| sort_field | string | N | commission_rate | The returned results are sorted by the specified field. |
Possible values:

* commission_rate
* product_sales_price
* commission
* units_sold

Specify the sort order using the `sort_order` parameter.
|
sort_order |string |N |DESC |The sort order for the objects in the response. Default: ASC
Possible values:

* ASC: Ascending order
* DESC: Descending order |

### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| title_keywords | []string | N | ["Men", "Fashion"," Sports Short"] | A list of product keywords for searching. Product titles, or names, are loosely matched. Keywords in the list form a query and the resulting set of matching product names is based on the conjunctive operator `AND` between each keyword. For example, the keyword list `["Men", "Fashion"]` creates a query `"Men" AND "Fashion"` and the resulting set of matching product names contains the loosely matched conjuction of "Men" and "Fashion" such as "Male Fashionable". Maximum length of the list is 20 keywords. Maximum keyword string length is 255 characters. |
| sales_price_range | object | N |  | Restricts the products in the search results to those with prices greater than or equal to the expressed minimum price and less than the expressed maximum price. |
| ^amount_ge | string | N | 12.44 | The product price must be greater than this value in order to be included in the search results. The value must be greater than `0`. |
| ^amount_lt | string | N | 100 | The product price must be greater than this value in order to be included in the search results. The value must be greater than `0`. No upper bound is set if this property is not included. |
| category | object | N |  | Restricts the products in the search results to those that are associated with the expressed product category. |
| ^id | string | N | 341234 | The category identifier. Note that only first-level categories are supported. |
| commission_rate_range | object | N |  | The commission rate of the searched product needs to be limited within this range. |
| ^rate_ge | int | N | 100 | The minimum commission rate. Products with a commission rate greater than or equal to this value are included in the results. Express the rate in hundredths of a percent; for example, `3587` means `35.87%`. The value must be from `100` to `8000`, inclusive. |
| ^rate_lt | int | N | 8000 | The commission rate must be less than this value in order to be included in the search results. The commission rate is expressed in hundredths of a percent. For example, `3587` is a commission rate of `35.87%`. This value must a minimum of `1000`. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202405/open_collaborations/products/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&page_token=b2Zmc2V0PTAK&page_size=20&sort_field=commission_rate&sort_order=DESC
```

**Body**
```json
{"title_keywords":["Men","Fashion"," Sports Short"],"sales_price_range":{"amount_ge":"12.44","amount_lt":"100"},"category":{"id":"341234"},"commission_rate_range":{"rate_ge":100,"rate_lt":8000}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^products | []object |  | A list of products. |
| ^^shop | object |  | Data and metadata associated with the Seller's TikTok Shop. |
| ^^^name | string | Test shop | The TikTok Shop name. |
| ^^id | string | 1729432087292775344 | The product identifier. |
| ^^has_inventory | bool | false | Set to `true` if there are more than zero units of the product in inventory. Set to `false` if there are zero units in inventory. |
| ^^units_sold | int | 12123 | Total number of units sold. Units are indexed to SKU. Note that if the creator has not given permission for precise data sharing, this property will not be present. |
| ^^title | string | Blue t-shirt | The product name. |
| ^^sale_region | string | ID | The region where the product is offered for sale. |
| ^^main_image_url | string | https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499 | The product image URL. |
| ^^detail_link | string | https://shop.tiktok.com/view/product/1729624807198591373?region=ID&local=en | The URL for the product's detail page. |
| ^^original_price | object |  | The original price of the product. |
| ^^^currency | string | USD | The currency code. |
| ^^^minimum_amount | string | 12.21 | The lowest original price of all SKUs of the product. |
| ^^^maximum_amount | string | 100.00 | The highest original price of all SKUs of the product. |
| ^^category_chains | []object |  | A list of categories associated with the product. Maximum length of the list is `3` categories. |
| ^^^id | string | 343554 | The category identifier. |
| ^^^local_name | string | COMPUTER | The localized category name. |
| ^^^is_leaf | bool | false | Set to `true` if this category is a leaf node. Set to `false` if not. |
| ^^^parent_id | string | 341182 | The category identifier of the parent category. |
| ^^commission | object |  | Metadata and data associated with the commission rates for the product. |
| ^^^rate | int | 3000 | The commission rate in hundredths of a percent. For example, `3587` is a commission rate of `35.87%`. This value must a minimum of `1000`. The range of this value is [100, 8000]. |
| ^^^currency | string | USD | The currency code. |
| ^^^amount | string | 121.32 | The commission amount. |
| ^^sales_price | object |  | Metadata and data associated with the sale price of the product |
| ^^^currency | string | USD | The currency code. |
| ^^^minimum_amount | string | 34.3 | The lowest promotion price of all SKUs of this product. |
| ^^^maximum_amount | string | 55.7 | The highest promotion price of all SKUs of this product. |
| ^next_page_token | string | b2Zmc2V0PTEw | An opaque token used to retrieve the next page of a paginated result set. |
| ^total_count | int | 10000 | Total count of products meeting the search criteria expressed in the request body. |
### Response Sample
```json
{"code":0,"data":{"products":[{"shop":{"name":"Test shop"},"id":"1729432087292775344","has_inventory":false,"units_sold":12123,"title":"Blue t-shirt","sale_region":"ID","main_image_url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499","detail_link":"https://shop.tiktok.com/view/product/1729624807198591373?region=ID\u0026local=en","original_price":{"currency":"USD","minimum_amount":"12.21","maximum_amount":"100.00"},"category_chains":[{"id":"343554","local_name":"COMPUTER","is_leaf":false,"parent_id":"341182"}],"commission":{"rate":3000,"currency":"USD","amount":"121.32"},"sales_price":{"currency":"USD","minimum_amount":"34.3","maximum_amount":"55.7"}}],"next_page_token":"b2Zmc2V0PTEw","total_count":10000},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get Open Collaboration Product List By Product Ids — `POST /affiliate_creator/202509/open_collaborations/products`

Doc: https://partner.tiktokshop.com/docv2/page/get-open-collaboration-product-list-by-product-ids-202509 · cập nhật 2026-10-13 · scope: creator.affiliate_collaboration.read

### Path: /affiliate_creator/202509/open_collaborations/products
### Method: [POST]
### Function Description
Retrieves open collaboration product information for the specified product IDs.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| product_ids | []string | N | 123,456 | A comma-separated list of numeric product IDs. Maximum: 50 IDs per request. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202509/open_collaborations/products?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&product_ids=123,456
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
| ^products | []object |  | Products found for the requested product IDs. The response may contain fewer products than requested. |
| ^^shop | object |  | The product's shop information. |
| ^^^name | string | Test shop | The name of the shop to which the product belongs. |
| ^^id | string | 1729432087292775344 | Product's unique id. |
| ^^has_inventory | bool | false | Whether this product has inventory. |
| ^^units_sold | int | 12 | The total number of units sold for this product. |
| ^^title | string | Blue t-shirt | Product's name. |
| ^^sale_region | string | ID | The region represents the areas where the product can be sold. |
| ^^main_image_url | string | https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499 | The product image url. |
| ^^detail_link | string | https://shop.tiktok.com/view/product/1729624807198591373?region=ID&local=en | Product's detail link which is used to get product details on mobile clients. |
| ^^original_price | object |  | The product's original price |
| ^^^currency | string | USD | The currency in the sale region. |
| ^^^minimum_amount | string | 12.21 | The minimum original price of all skus of this product. |
| ^^^maximum_amount | string | 100.00 | The maximum original price of all skus of this product. |
| ^^category_chains | []object |  | The categories of this product. |
| Return to the top three categories at most |  |  |  |
| ^^^id | string | 3435545 | The current category id of this product. |
| ^^^local_name | string | COMPUTER | The current level category name of this product. |
| ^^^is_leaf | bool | false | Indicate whether current node is leaf node |
| ^^^parent_id | string | 12345 | The category id of its parent category |
| ^^commission | object |  | The commission of this product. |
| ^^^rate | int | 100 | - The commission rate for this product is set by merchants for creators public promotion. |

* The range of this value is [100, 8000].
* This value equals actual commission rate multi 10000. For example: 3000 means the actual commission rate is 30.00%, and 3555 means 35.55% |
   ^^^currency |string |USD |Currency code for the commission amount. |
   ^^^amount |string |0 |The commission amount calculated from the product's promotional price and commission rate. When both minimum and maximum promotional prices are available, the value is formatted as `<minimum commission> - <maximum commission>`; otherwise, it contains the available commission amount. If neither price is available, the value is `0`. The currency is specified by `commission.currency`. |
   ^^sales_price |object | |Sales price information of the product |
   ^^^currency |string |USD |Currency code for the promotional price. |
   ^^^minimum_amount |string |34.3 |The minimum promotion price of all skus of this product. |
   ^^^maximum_amount |string |55.7 |The maximum promotion price of all skus of this product. |
   ^^shop_ads_commission |object | |The ads commission rate applies only to orders generated from ads. If a creator’s video is used as an ad without this rate being set, the resulting orders will instead earn either:
* The Shop Ads commission you configured in open collaboration, or
* The standard commission defined in this invitation. |
   ^^^rate |int |100 |The Shop Ads commission rate for this product, multiplied by 10,000. The range is 100 to 8,000. For example, 3,000 represents 30.00% and 3,555 represents 35.55%. |

### Response Sample
```json
{"code":0,"data":{"products":[{"shop":{"name":"Test shop"},"id":"1729432087292775344","has_inventory":false,"units_sold":12,"title":"Blue t-shirt","sale_region":"ID","main_image_url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499","detail_link":"https://shop.tiktok.com/view/product/1729624807198591373?region=ID\u0026local=en","original_price":{"currency":"USD","minimum_amount":"12.21","maximum_amount":"100.00"},"category_chains":[{"id":"3435545","local_name":"COMPUTER","is_leaf":false,"parent_id":"12345"}],"commission":{"rate":100,"currency":"USD","amount":"0"},"sales_price":{"currency":"USD","minimum_amount":"34.3","maximum_amount":"55.7"},"shop_ads_commission":{"rate":100}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Search Creator Target Collaborations — `POST /affiliate_creator/202405/target_collaborations/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-creator-target-collaborations-202405 · cập nhật 2026-10-13 · scope: creator.affiliate_collaboration.read

### Path: /affiliate_creator/202405/target_collaborations/search
### Method: [POST]
### Function Description
Searches for the authenticated creator's target collaborations and the products within them for the TikTok Shop specified by `shop_id`.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| page_token | string | N | b2Zmc2V0PTAK | An opaque token used to retrieve the next page of a paginated result set. It is not needed for the first page. For each subsequent page, pass the previous response's `next_page_token` unchanged as `page_token` and reuse the same `page_size`, `shop_id`, `keyword`, and `keyword_type` values, including whether optional `keyword` and `keyword_type` were omitted or provided. |
| page_size | int | Y | 20 | The number of results to be returned per page. Valid range: [0-100]. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| shop_id | string | Y | 789078671231 | The TikTok Shop identifier. |
| keyword_type | string | N | TARGET_COLLABORATIONS_ID | The type of value specified in `keyword`. Provide `keyword` and `keyword_type` together to filter by ID or name. Omit both fields to search without an ID or name filter. Possible values: |

* `TARGET_COLLABORATIONS_ID`: Match by target collaboration ID and return matching collaborations in the `LIVE`, `EXPIRED`, `DELETED`, or `ENDED` state.
* `TARGET_COLLABORATIONS_NAME`: Match by target collaboration name and return matching collaborations in the `LIVE` state only. |
   keyword |string |N |12312312 |The target collaboration ID or name to search for, as specified by `keyword_type`. For `TARGET_COLLABORATIONS_ID`, provide a base-10 integer. For `TARGET_COLLABORATIONS_NAME`, provide a value shorter than 500 bytes. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202405/target_collaborations/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&page_token=b2Zmc2V0PTAK&page_size=20
```

**Body**
```json
{"shop_id":"789078671231","keyword_type":"TARGET_COLLABORATIONS_ID","keyword":"12312312"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^total_count | int | 100 | The total number of target collaborations that match the search criteria. |
| ^next_page_token | string | b2Zmc2V0PTIw | An opaque token used to retrieve the next page of a paginated result set. |
| ^target_collaborations | []object |  | A list of target collaboration objects. |
| ^^id | string | 789078671231123124 | The target collaboration identifier. |
| ^^name | string | target_collaboration | The target collaboration name. |
| ^^status | string | LIVE | The target collaboration state. This is an enumerated type with values: |

* LIVE
* EXPIRED
* DELETED
* ENDED |
   ^^products |[]object | |A list of products associated with the target collaboration. |
   ^^^id |string |1729432087292775344 |The product identifier. |
   ^^^title |string |Blue t-shirt |The product name. |
   ^^^main_image_url |string |https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499 |The product image URL in the TikTok Shop. |
   ^^^commission |object | |The commission rate and estimated commission amount for the product in this target collaboration. |
   ^^^^rate |int |1000 |The commission rate for the target collaboration in hundredths of a percent. For example, `3587` is a commission rate of `35.87%`. |
   ^^^^amount |string |121.23 |The estimated commission amount calculated from the product's minimum price, in the currency specified by `currency`. |
   ^^^^currency |string |USD |The currency code. |

### Response Sample
```json
{"code":0,"data":{"total_count":100,"next_page_token":"b2Zmc2V0PTIw","target_collaborations":[{"id":"789078671231123124","name":"target_collaboration","status":"LIVE","products":[{"id":"1729432087292775344","title":"Blue t-shirt","main_image_url":"https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fa0387fa5a204dcfa44d5be75877a163~tplv-o3syd03w52-origin-webp.webp?from=3478900499","commission":{"rate":1000,"amount":"121.23","currency":"USD"}}]}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Search Creator Sample Applications — `POST /affiliate_creator/202412/sample_applications/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-creator-sample-applications-202412 · cập nhật 2026-10-13 · scope: creator.affiliate_collaboration.read

### Path: /affiliate_creator/202412/sample_applications/search
### Method: [POST]
### Function Description
Search sample applications for the authenticated creator.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| page_token | string | N | 87712341234 | The page token returned in `next_page_token` by the previous response. Omit this parameter for the first request. For subsequent pages, pass the returned token and reuse the same `application_statuses` value. |
| page_size | int | N | 50 | The value of "page_size" must be greater than 0 and less than or equal to 50. |
| Default 20 |  |  |  |  |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| application_statuses | []string | N | ["PENDING","AWAITING_SHIPMENT"] | Filter sample applications by status. |
| The possible enumerated values are: |  |  |  |  |

* PENDING: The sample application is waiting for the seller's review.
* AWAITING_SHIPMENT: The application is approved, and the seller needs to ship the sample.
* SHIPPED: The sample has been shipped by the seller and is waiting for the creator to receive the package.
* CONTENT_PENDING: The creator has received the sample package and is expected to create content.
* REJECT_CANCELLED: The sample application has been rejected by the seller.
* OVERDUE_CANCELLED: The sample application has expired due to being overdue.
* UNFULFILL_CANCELLED: The creator did not fulfill the commitment to create content within the agreed timeframe.
* FULFILLMENT_SUSPEND: The application fulfillment was paused because the product could not be promoted.
* DEL_OPEN_COLLAB: Open collaboration has been deleted.
* SELLER_NOT_SHIP_CANCELLED: The seller did not ship the sample within the required timeframe.
* WITHDRAW_CANCELLED: The creator withdrew the sample application before the seller approved it.
* UNFULFILLABLE_CANCELLED: The application was cancelled due to reasons beyond the creator's control, making it impossible to create content.
* OPS_CANCELLED: The application was manually cancelled by operations staff.
* OPS_FAILED: The application was marked as failed by operations staff.
* OPS_ COMPLETED: The application was manually marked as completed by operations staff.
* COMPLETED: The application is complete, and the creator has posted the content.
* TO_BE_POST: The creator has not posted a video or LIVE for this sample.
* POST_IN_REVIEW: The creator has posted a video or LIVE that has not yet satisfied the fulfillment requirements.
* POST_FAILED: The creator posted a video or LIVE but deleted it before completing sample fulfillment.
* CANCELED: The sample application has been canceled.
   This field allows for tracking the status of a sample application throughout its lifecycle, providing visibility into each stage of the process for sellers and creators. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202412/sample_applications/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&page_token=87712341234&page_size=50
```

**Body**
```json
{"application_statuses":["PENDING","AWAITING_SHIPMENT"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^next_page_token | string | 20 | Page token to query next page orders, last page is empty string. |
| ^sample_applications | []object |  | The sample application information. |
| ^^id | string | 8070590921506065183 | The unique id of sample application. |
| ^^sample_product | object |  | The sample product information. |
| ^^^id | string | 1729432087292775344 | The product identifier. |
| ^^^sku_id | string | 1729480364147774364 | The SKU identifier. |
| ^^^sku_sale_property_value_names | []string | ["red","large size"] | The names of the SKU's sale property values. |
| ^^main_order_id | string | 13444222 | The sample order is generated after the sample application is approved by seller. |
| ^^activity_id | string | 13456677 | The sample activity identifier id(only for sample activity). |
| ^^status | string | PENDING | The status of sample applications. |
| The possible enumerated values are: |  |  |  |

* PENDING: The sample application is waiting for the seller's review.
* AWAITING_SHIPMENT: The application is approved, and the seller needs to ship the sample.
* SHIPPED: The sample has been shipped by the seller and is waiting for the creator to receive the package.
* REJECT_CANCELLED: The sample application has been rejected by the seller.
* OVERDUE_CANCELLED: The sample application has expired due to being overdue.
* UNFULFILL_CANCELLED: The creator did not fulfill the commitment to create content within the agreed timeframe.
* FULFILLMENT_SUSPEND: the application fulfillment was paused due to the product status being unpromotable.
* DEL_OPEN_COLLAB: Open collaboration has been deleted.
* SELLER_NOT_SHIP_CANCELLED: The seller did not ship the sample within the required timeframe.
* WITHDRAW_CANCELLED: The creator withdrew the sample application before the seller approved it.
* UNFULFILLABLE_CANCELLED: The application was cancelled due to reasons beyond the creator's control, making it impossible to create content.
* OPS_CANCELLED: The application was manually cancelled by operations staff.
* OPS_FAILED: The application was marked as failed by operations staff.
* OPS_ COMPLETED: The application was manually marked as completed by operations staff.
* COMPLETED: The application is complete, and the creator has posted the content.
* TO_BE_POST: the creator has not posted videos/lives for this sample
* POST_IN_REVIEW: the creator has posted videos/lives which have not satisfied fulfillment rules.
* POST_FAILED: the creator has posted videos/lives and deleted them before completing sample fulfillment.
* CANCELED: this application(order) has been canceled.
   This field allows tracking the status of a sample application throughout its lifecycle, providing visibility into each stage of the process for sellers and creators. |
   ^^creator_fulfillment |object | | Fulfillment info for this sample application. |
   ^^^id |string |123456 |Fulfillment ID. |
   ^^^expiration_time |int |1726301400 |Fulfillment deadline timestamp, in seconds. |
   ^^^total_suspend_duration |int |123 |Total suspension duration for fulfillment, in seconds. |
   ^^^status |string |PENDING |Fulfillment status, It indicates the current status of the fulfillment process. The possible values are:
* PENDING: The creator is yet to fulfill the content creation obligation.
* ONGOING: Fulfillment is in progress; content has been created and is being evaluated against criteria.
* SUCCEED: Fulfillment has been successfully completed; the content meets the required standards.
* FAILED: Fulfillment failed; the content did not meet the required standards.
* OVERDUE: Fulfillment is overdue; the creator did not meet the deadline.
* SUSPEND: Fulfillment has been suspended.
* CANCELLED: Fulfillment has been cancelled, either by the creator or due to operational reasons.
* EXEMPTED: The creator has been exempted from the fulfillment obligation. |
   ^^^bound_product_status |string |LIVE |Represents the marketing status of a product associated with a fulfillment order. It indicates whether the product is available for marketing and fulfillment. The possible values are:
* UNKNOWN: The marketing status of the product is unknown.
* LIVE: The product is available and can be used for fulfillment.
* OUT_OF_STOCK: The product is out of stock and cannot be fulfilled.
* SELLER_DEACTIVATE: The product has been deactivated by the seller.
* PLATFORM_DEACTIVATE: The product has been deactivated by the platform.
* NO_PLAN: There is no valid plan available for the creator to market the product.
* PERMANENT_DELETED: The product has been permanently deleted and is no longer available.
   This field helps sellers and creators understand the current status of products associated with fulfillment orders, ensuring that all parties are aware of the availability and marketing status of the products involved in sample applications and collaborations. |

### Response Sample
```json
{"code":0,"data":{"next_page_token":"20","sample_applications":[{"id":"8070590921506065183","sample_product":{"id":"1729432087292775344","sku_id":"1729480364147774364","sku_sale_property_value_names":["red","large size"]},"main_order_id":"13444222","activity_id":"13456677","status":"PENDING","creator_fulfillment":{"id":"123456","expiration_time":1726301400,"total_suspend_duration":123,"status":"PENDING","bound_product_status":"LIVE"}}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get Creator Sample Application Detail — `POST /affiliate_creator/202412/sample_applications/single_query`

Doc: https://partner.tiktokshop.com/docv2/page/get-creator-sample-application-detail-202412 · cập nhật 2026-10-28 · scope: creator.affiliate_collaboration.read

### Path: /affiliate_creator/202412/sample_applications/single_query
### Method: [POST]
### Function Description
Get the sample detail of specified sample application.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
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
| product_id | string | Y | 1729480364147774364 | The product identifier. |
| application_id | string | N | 8070590921506065183 | Free sample application ID. When `application_type` is `FREE_SAMPLE`, provide `application_id`; if it is omitted, provide `main_order_id` in addition to the required `product_id`. |
| application_type | string | Y | FREE_SAMPLE | The type of creator sample application. |

* FREE_SAMPLE : free sample supplied by seller which creator can apply for by themselves from product detail page.
* SAMPLE_COUPON: creator claimed sample coupon (a type of coupon) and used it to place orders at a discount price.
* SAMPLE_CAMPAIGN: activity organized by the platform. Creators can participate in this activity to obtain sample products provided by the platform for free.
   |
   main_order_id |string |N |579622078763731743 |The real main order identifier, required when application is "SAMPLE_COUPON" or "SAMPLE_CAMPAIGN" or "REFUNDABLE_SAMPLE". |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202412/sample_applications/single_query?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

**Body**
```json
{"product_id":"1729480364147774364","application_id":"8070590921506065183","application_type":"FREE_SAMPLE","main_order_id":"579622078763731743"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^sample_application | object |  | The sample application information. |
| ^^id | string | 8070590921506065183 | Sample application identifier. |
| ^^create_time | int | 1731298837 | Sample application create time in seconds. |
| ^^sample_product | object |  | The sample product information. |
| ^^^id | string | 1729863469568985219 | The product identifier. |
| ^^^sku_id | string | 1729480364147774364 | The SKU identifier. |
| ^^^sku_sale_property_value_names | []string | ["red","large size"] | Sku property name list for this sku id. |
| ^^main_order_id | string | 57871819384716917 | The sample order is generated after the sample application is approved by seller. |
| ^^activity_id | string | 74378918272345199 | The sample activity identifier id( only for sample campaign). |
| ^^type | string | FREE_SAMPLE | The type of creator sample application. |

* FREE_SAMPLE : free sample supplied by seller which creator can apply by themselves from pdp page.
* SAMPLE_COUPON: creator claimed sample coupon (a type of coupon) and used it to purchase orders at a discount price.
* SAMPLE_CAMPAIGN: activity organized by the platform. Creators can participate in this activity to obtain sample products provided by the platform for free. |
   ^^status |string |PENDING |The status of sample applications.
   The possible enumerated values are:
* PENDING: The sample application is waiting for the seller's review.
* AWAITING_SHIPMENT: The application is approved, and the seller needs to ship the sample.
* SHIPPED: The sample has been shipped by the seller and is waiting for the creator to receive the package.
* CONTENT_PENDING: The creator has received the sample package and is expected to create content.
* REJECT_CANCELLED: The sample application has been rejected by the seller.
* OVERDUE_CANCELLED: The sample application has expired due to being overdue.
* UNFULFILL_CANCELLED: The creator did not fulfill the commitment to create content within the agreed timeframe.
* SELLER_NOT_SHIP_CANCELLED: The seller did not ship the sample within the required timeframe.
* WITHDRAW_CANCELLED: The creator withdrew the sample application before the seller approved it.
* UNFULFILLABLE_CANCELLED: The application was cancelled due to reasons beyond the creator's control, making it impossible to create content.
* OPS_CANCELLED: The application was manually cancelled by operations staff.
* OPS_FAILED: The application was marked as failed by operations staff.
* OPS_ COMPLETED: The application was manually marked as completed by operations staff.
* COMPLETED: The application is complete, and the creator has posted the content.
   This field allows for tracking the status of a sample application throughout its lifecycle, providing visibility into each stage of the process for sellers and creators. |
   ^^creator_fulfillment |object | |Fulfillment info for this sample application. |
   ^^^id |string |87147319238415178 |Fulfillment identifier. |
   ^^^expiration_time |int |1726301400 |Fulfillment deadline timestamp, in seconds. |
   ^^^total_suspend_duration |int |7641234 |Total suspension duration for fulfillment, in seconds. |
   ^^^status |string |PENDING |Fulfillment status, It indicates the current status of the fulfillment process. The possible values are:
* PENDING: The creator is yet to fulfill the content creation obligation.
* ONGOING: Fulfillment is in progress; content has been created and is being evaluated against criteria.
* SUCCEED: Fulfillment has been successfully completed; the content meets the required standards.
* FAILED: Fulfillment failed; the content did not meet the required standards.
* OVERDUE: Fulfillment is overdue; the creator did not meet the deadline.
* SUSPEND: Fulfillment has been suspended.
* CANCELLED: Fulfillment has been cancelled, either by the creator or due to operational reasons.
* EXEMPTED: The creator has been exempted from the fulfillment obligation.
* REPEATED: The creator repeated the fulfillment after initially completing it; repeated fulfillment is not treated as a failure. |

### Response Sample
```json
{"code":0,"data":{"sample_application":{"id":"8070590921506065183","create_time":1731298837,"sample_product":{"id":"1729863469568985219","sku_id":"1729480364147774364","sku_sale_property_value_names":["red","large size"]},"main_order_id":"57871819384716917","activity_id":"74378918272345199","type":"FREE_SAMPLE","status":"PENDING","creator_fulfillment":{"id":"87147319238415178","expiration_time":1726301400,"total_suspend_duration":7641234,"status":"PENDING"}}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Creator Search Sample Application Fulfillments — `POST /affiliate_creator/202409/sample_applications/fulfillments/search`

Doc: https://partner.tiktokshop.com/docv2/page/creator-search-sample-application-fulfillments-202409 · cập nhật 2026-10-28 · scope: creator.affiliate_collaboration.read

### Path: /affiliate_creator/202409/sample_applications/fulfillments/search
### Method: [POST]
### Function Description
You, the creator, can use this API to query the fulfillment status for the received sample applications.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| sort_order | string | N | DESC | The sort order for the field specified in the sort_field parameter. |
| Default: ASC |  |  |  |  |
| Possible values: |  |  |  |  |
| ASC: Ascending order |  |  |  |  |
| DESC: Descending order |  |  |  |  |
| sort_field | string | N | expired_time | Possible values: |

* expired_time: Sort by the remaining time to fulfill.
* create_time: Sort by the fulfillment record creation time.
   Default: expired_time. |

### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| fulfillment_statuses | []string | Y | ["PENDING", "ONGOING"] | A list of fulfillment statuses. The response is filtered to include sample fulfillments with the `status` field set to one of the specified values. The possible values are: |

* PENDING: The creator has not yet fulfilled the content creation obligation.
* ONGOING: Fulfillment is in progress; content has been created and is being evaluated against criteria.
* SUCCEED: Fulfillment has been successfully completed; the content meets the required standards.
* FAILED: Fulfillment failed; the content did not meet the required standards.
* OVERDUE: Fulfillment is overdue; the creator did not meet the deadline.
* SUSPEND: Fulfillment has been suspended.
* CANCELLED: Fulfillment has been cancelled, either by the creator or due to operational reasons.
* EXEMPTED: The creator is exempt from the fulfillment obligation. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202409/sample_applications/fulfillments/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&sort_order=DESC&sort_field=expired_time
```

**Body**
```json
{"fulfillment_statuses":["PENDING","ONGOING"]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^fulfillments | []object |  | Creator fulfillment contents. |
| ^^id | string | 123456 | The fulfillment identifier. |
| ^^shop_id | string | 123456 | The TikTok Shop identifier. |
| ^^application_id | string | 123456 | The sample application identifier. |
| ^^sample_application_type | string | FREE_SAMPLE | The type of the sample application. Possible values: |

* FREE_SAMPLE
* SAMPLE_COUPON
* SAMPLE_CAMPAIGN
* PLATFORM_FREE_SAMPLE
* REFUNDABLE_SAMPLE
* UNSPECIFIED |
   ^^product_id |string |123456 |The product identifier. |
   ^^expiration_time |int |1728542813 |Fulfillment deadline timestamp.
   Usually the value is `{you_receiving_sample_time} + 14Days`. But if you apply for fulfillment suspension, the value is `{you_receiving_sample_time} + 14Days + total_suspend_duration`. |
   ^^total_suspend_duration |int |100020 |The duration you applied for fulfillment suspension in seconds. |
   ^^status |string |ONGOING |The fulfillment status.This is an enumerated type with values:
* PENDING: The creator has not yet fulfilled the content creation obligation.
* ONGOING: Fulfillment is in progress; content has been created and is being evaluated against criteria.
* SUCCEED: Fulfillment has been successfully completed; the content meets the required standards.
* FAILED: Fulfillment failed; the content did not meet the required standards.
* OVERDUE: Fulfillment is overdue; the creator did not meet the deadline.SUSPEND: Fulfillment has been suspended.
* CANCELLED: Fulfillment has been cancelled, either by the creator or due to operational reasons.
* EXEMPTED: The creator is exempt from the fulfillment obligation. |
   ^^bound_product_status |string |LIVE |The promotion status of the product associated with the fulfillment. Possible values:
* UNKNOWN: The product's promotion status is unknown.
* LIVE: The product is available for promotion.
* OUT_OF_STOCK: The product is out of stock.
* SELLER_DEACTIVATE: The product has been deactivated by the seller.
* PLATFORM_DEACTIVATE: The product has been deactivated by the platform.
* NO_PLAN: There is no valid plan available for the creator to promote the product.
* PERMANENT_DELETED: The product has been permanently deleted and is no longer available. |

### Response Sample
```json
{"code":0,"data":{"fulfillments":[{"id":"123456","shop_id":"123456","application_id":"123456","sample_application_type":"FREE_SAMPLE","product_id":"123456","expiration_time":1728542813,"total_suspend_duration":100020,"status":"ONGOING","bound_product_status":"LIVE"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Generate General Sharing Links — `POST /affiliate_creator/202505/affiliate_sharing_links/general_publishers/generate_batch`

Doc: https://partner.tiktokshop.com/docv2/page/generate-general-sharing-links-202505 · cập nhật 2026-10-13 · scope: creator.affiliate.share_link.read

### Path: /affiliate_creator/202505/affiliate_sharing_links/general_publishers/generate_batch
### Method: [POST]
### Function Description
You can use this API to generate material sharing links for your publishers. After that, you can encapsulate the sharing link with additional information like publisher ID. Right now, the material type must be `PRODUCT`.
Please ensure that the material is included in the campaign by using [Generate Multi Affiliate Partner Campaign Product Links].

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
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
| material | object | Y |  | The entities for which the sharing links are generated. |
| ^ids | []string | Y | ["7362840009596339971","7362840009596339923"] | The list of material IDs. For `PRODUCT` requests, provide 1 to 50 product IDs. |
| ^type | string | Y | PRODUCT | Right now, the only possible value is `PRODUCT`. |
| When `type` is `PRODUCT`, use product IDs for `ids`. |  |  |  |  |
| ^promotion_campaign_schema | string | N | https://www.tiktok.com/t/ZSxRC4FEL/ | When type is set to CAMPAIGN, this field is required. This schema is associated with the Campaign page. |
| campaign_id | string | N | 7332840009596339923 | If a creator adds products from a campaign, please include the campaign ID. The campaign ID can be found in the Affiliate Center or retrieved using the Get Affiliate Partner Campaign List API. |
| link_type | string | N | TOKO | Optional. For Tokopedia agencies, set this field to `TOKO`. The response returns the Tokopedia product URL in `sharing_link` and omits `deep_link` and `one_link`. |
| If this field is omitted or set to another value, the response returns the TikTok Shop product URL in `sharing_link`. For `PRODUCT` requests, `deep_link` and `one_link` are also returned. |  |  |  |  |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202505/affiliate_sharing_links/general_publishers/generate_batch?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

**Body**
```json
{"material":{"ids":["7362840009596339971","7362840009596339923"],"type":"PRODUCT","promotion_campaign_schema":"https://www.tiktok.com/t/ZSxRC4FEL/"},"campaign_id":"7332840009596339923","link_type":"TOKO"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^sharing_links | []object |  | The successfully generated sharing links. |
| ^^material_id | string | 7362840009596339971 | Material ID. |
| ^^sharing_link | string | https://www.tiktok.com/view/product/1730958349688804006?chain_key=%7B%22t%22%3A1%2C%22k%22%3A%22000000000000000007518161308526446350%22%2C%22sc%22%3A%22OPEN_API%22%7D&scene=pdp&utm_source=open_api&trackParams=%7B%22enter_from_info%22%3A%22product_share_outside%22%2C%22source_page_type%22%3A%22product_share%22%2C%22enable_shop_tab_popup%22%3A1%7D&share_app_id=1233 | This is the product promotion link that agencies can share with collaborated creators. Creators can copy/paste this link into the web browser. |
| After you have the links, add the following request parameters and their corresponding values to the end of the link URL. When a user places an order using this link, the resulting e-commerce order will carry these parameters as part of its information: |  |  |  |

* event_id: Unique event id for each click
* publisher_id: The unique publish_id assigned by CJ
   Nice to have
* publisher_name: From CJ publisher profile.
* device_type: 1-mobile, 2-desktop.
* device_id: The clicks from the same device id can be aggregated as UV.
* referrer_src: The URL of the webpage that a user came from before landing on the current share link. |
   ^^deep_link |string |snssdk1180://ec/pdp?biz_type=0&enter_method=web&gd_label=click_wap_p_product_detail_t_launch_pop_up_s__e__f__fp__fps_affiliate_links_rf_&h5_start_ts=1768977752558&is_commerce=1&jump_time=1768977752558&need_mall=1&needlaunchlog=1&o_app_code=abcsadaadada&page_name=reflow_pdp&page_name=product_detail&params_url=https%3A%2F%2Fshop-id.tokopedia.com%2Fview%2Fproduct%2F1730831248044885504%3Fchain_key%3D%257B%2522event_id%2522%253A%2522o_event_id%2522%252C%2522k%2522%253A%2522000000000000000007596668298679682828%2522%252C%2522sc%2522%253A%2522OPEN_API%2522%252C%2522t%2522%253A1%257D%26div_media_source%3Daffiliate%26event_id%3Do_event_id%26landing_page_name%3Dproduct_detail%26landpage_form%3Dhalf%26page_name%3Dproduct_detail%26scene%3Dpdp%26share_app_id%3D1180%26sticky_diversion_config%3D%257B%2522merge_action%2522%253A%2522
   |A product promotion app deep link that opens the corresponding TikTok Shop product detail page. It is returned for `PRODUCT` requests that use the TikTok Shop link type and is omitted when `link_type` is `TOKO`. Agencies can share this link with collaborated creators, and creators can share it with users. Use `one_link` for the HTTPS link that can be opened in a web browser.

To enable attribution, replace the `o_event_id` placeholder in the returned `deep_link` URL with a developer-generated unique ID for each click. Do not URL-encode or URL-decode the returned link. If a user places an order through this link, the resulting e-commerce order carries the event ID for tracking. |
^^one_link |string |https://snssdk1180.onelink.me/BAuo?params_url=https%3A%2F%2Fshop-id.tokopedia.com%2Fview%2Fproduct%2F1730831248044885504%3Fchain_key%3D%257B%2522event_id%2522%253A%2522o_event_id%2522%252C%2522k%2522%253A%2522000000000000000007596668298679682828%2522%252C%2522sc%2522%253A%2522OPEN_API%2522%252C%2522t%2522%253A1%257D%26div_media_source%3Daffiliate%26event_id%3Do_event_id%26landing_page_name%3Dproduct_detail%26landpage_form%3Dhalf%26page_name%3Dproduct_detail%26scene%3Dpdp%26share_app_id%3D1180%26sticky_diversion_config%3D%257B%2522merge_action%2522%253A%2522merge%2522%252C%2522data%2522%253A%257B%2522channel%2522%253A%255B%2522benefit_hub%2522%255D%257D%252C%2522is_sticky%2522%253A1%257D%26touch_point_product_id%3D1730831248044885504%26trackParams%3D%257B%2522enter_from_info%2522%253A%2522product_share_outside%2522%252C%2522source_page_type%2522%253A%2522product_share%2522%252C%2522enable_shop_tab_popup%2522%253A1%257D%26utm_source%3Dopen_api
|A product promotion one-link that opens the corresponding TikTok Shop product detail page. It is returned for `PRODUCT` requests that use the TikTok Shop link type and is omitted when `link_type` is `TOKO`. Agencies can share this link with collaborated creators, and creators can copy and paste it into a web browser or share it with users.
To enable attribution, replace the `o_event_id` placeholder in the returned `one_link` URL with a developer-generated unique ID for each click. Do not URL-encode or URL-decode the returned link. If a user places an order through this link, the resulting e-commerce order carries the event ID for tracking. If the user does not have TikTok installed, the link redirects the user to the app store to install TikTok. |
^failed_materials |[]object | |The list of materials which failed to generate sharing links for. |
^^material_id |string |7362840009596339972 |Material ID. |
^^fail_reason |string |Product was sold out |Fail reason. |
### Response Sample
```json
{"code":0,"data":{"sharing_links":[{"material_id":"7362840009596339971","sharing_link":"https://www.tiktok.com/view/product/1730958349688804006?chain_key=%7B%22t%22%3A1%2C%22k%22%3A%22000000000000000007518161308526446350%22%2C%22sc%22%3A%22OPEN_API%22%7D\u0026scene=pdp\u0026utm_source=open_api\u0026trackParams=%7B%22enter_from_info%22%3A%22product_share_outside%22%2C%22source_page_type%22%3A%22product_share%22%2C%22enable_shop_tab_popup%22%3A1%7D\u0026share_app_id=1233","deep_link":"snssdk1180://ec/pdp?biz_type=0\u0026enter_method=web\u0026gd_label=click_wap_p_product_detail_t_launch_pop_up_s__e__f__fp__fps_affiliate_links_rf_\u0026h5_start_ts=1768977752558\u0026is_commerce=1\u0026jump_time=1768977752558\u0026need_mall=1\u0026needlaunchlog=1\u0026o_app_code=abcsadaadada\u0026page_name=reflow_pdp\u0026page_name=product_detail\u0026params_url=https%3A%2F%2Fshop-id.tokopedia.com%2Fview%2Fproduct%2F1730831248044885504%3Fchain_key%3D%257B%2522event_id%2522%253A%2522o_event_id%2522%252C%2522k%2522%253A%2522000000000000000007596668298679682828%2522%252C%2522sc%2522%253A%2522OPEN_API%2522%252C%2522t%2522%253A1%257D%26div_media_source%3Daffiliate%26event_id%3Do_event_id%26landing_page_name%3Dproduct_detail%26landpage_form%3Dhalf%26page_name%3Dproduct_detail%26scene%3Dpdp%26share_app_id%3D1180%26sticky_diversion_config%3D%257B%2522merge_action%2522%253A%2522\n","one_link":"https://snssdk1180.onelink.me/BAuo?params_url=https%3A%2F%2Fshop-id.tokopedia.com%2Fview%2Fproduct%2F1730831248044885504%3Fchain_key%3D%257B%2522event_id%2522%253A%2522o_event_id%2522%252C%2522k%2522%253A%2522000000000000000007596668298679682828%2522%252C%2522sc%2522%253A%2522OPEN_API%2522%252C%2522t%2522%253A1%257D%26div_media_source%3Daffiliate%26event_id%3Do_event_id%26landing_page_name%3Dproduct_detail%26landpage_form%3Dhalf%26page_name%3Dproduct_detail%26scene%3Dpdp%26share_app_id%3D1180%26sticky_diversion_config%3D%257B%2522merge_action%2522%253A%2522merge%2522%252C%2522data%2522%253A%257B%2522channel%2522%253A%255B%2522benefit_hub%2522%255D%257D%252C%2522is_sticky%2522%253A1%257D%26touch_point_product_id%3D1730831248044885504%26trackParams%3D%257B%2522enter_from_info%2522%253A%2522product_share_outside%2522%252C%2522source_page_type%2522%253A%2522product_share%2522%252C%2522enable_shop_tab_popup%2522%253A1%257D%26utm_source%3Dopen_api\n"}],"failed_materials":[{"material_id":"7362840009596339972","fail_reason":"Product was sold out"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Generate Publisher Sharing Links in Batch — `POST /affiliate_creator/202504/affiliate_sharing_links/publisher/{publisher_id}/generate_batch`

Doc: https://partner.tiktokshop.com/docv2/page/generate-publisher-sharing-links-in-batch-202504 · cập nhật 2026-10-13 · scope: creator.affiliate.share_link.read

### Path: /affiliate_creator/202504/affiliate_sharing_links/publisher/{publisher_id}/generate_batch
### Method: [POST]
### Function Description
You can use this API to generate material sharing links for a specific publisher. After that, you can share the link with the publisher. Right now, the material type must be `PRODUCT`.
Please ensure that the material is included in the campaign by using [Generate Multi Affiliate Partner Campaign Product Links](generate-multi-affiliate-partner-campaign-product-links).

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| publisher_id | string | Y | publisher_id_in_your_sys | The publisher id in partner's system |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| material | object | Y |  | The entities for which the sharing links are generated. |
| ^ids | []string | Y | ["7362840009596339971","7362840009596339923"] | The list of material IDs. The maximum length is 50. When `type` is `PRODUCT`, provide 1 to 50 product IDs. |
| ^type | string | Y | PRODUCT | The material type. Possible values: |

* `PRODUCT`: Provide product IDs in `ids`.
* `CAMPAIGN`: Provide `promotion_campaign_schema`. |
   ^promotion_campaign_schema |string |N |https://www.tiktok.com/t/ZSxRC4FEL/ |When `type` is set to `CAMPAIGN`, this field is required. This schema is associated with the Campaign page. |
   campaign_id |string |N |7432840009596339923 |If a creator adds products from a campaign, please include the campaign ID. The campaign ID can be found in the Affiliate Center or retrieved using the Get Affiliate Partner Campaign List API. |
   link_type |string |N |TOKO |Controls the `sharing_link` returned when `material.type` is `PRODUCT`.
* Set to `TOKO` for a Tokopedia product URL. This option is for Tokopedia agencies.
* Omit this field for a TikTok Shop product URL. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202504/affiliate_sharing_links/publisher/publisher_id_in_your_sys/generate_batch?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

**Body**
```json
{"material":{"ids":["7362840009596339971","7362840009596339923"],"type":"PRODUCT","promotion_campaign_schema":"https://www.tiktok.com/t/ZSxRC4FEL/"},"campaign_id":"7432840009596339923","link_type":"TOKO "}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^sharing_links | []object |  | Generated affiliate sharing links for successfully processed materials for the publisher specified in the path. |
| ^^material_id | int | 7362840009596339971 | Material ID. |
| ^^sharing_link | string | https://www.tiktok.com/t/AIxvOHlaJoKO | This is the product promotion link that agencies can share with collaborated publishers. The publishers can post this link at their will. |
| ^^deep_link | string | snssdk1180://ec/pdp?biz_type=0&enter_method=web&gd_label=click_wap_p_product_detail_t_launch_pop_up_s__e__f__fp__fps_affiliate_links_rf_&h5_start_ts=1768977752558&is_commerce=1&jump_time=1768977752558&mall_extra_info=%7B%22mall_out_source%22%3A%22seo.web_product_detail.out_of_app%22%2C%22mall_landing_page%22%3A%22product_detail%22%2C%22mall_homepage_visited_type%22%3A2%7D&media_source=channelshareh5&need_mall=1&needlaunchlog=1&o_app_code=abcsadaadada&page_name=reflow_pdp&page_name=product_detail&params_url=https%3A%2F%2Fshop-id.tokopedia.com%2Fview%2Fproduct%2F1730831248044885504%3Fchain_key%3D%257B%2522event_id%2522%253A%2522o_event_id%2522%252C%2522k%2522%253A%2522000000000000000007596668298679682828%2522%252C%2522sc%2522%253A%2522OPEN_API%2522%252C%2522t%2522%253A1%257D%26div_media_source%3Daffiliate%26event_id%3Do_event_id%26landing_page_name%3Dproduct_detail%26landpage_form%3Dhalf%26page_name%3Dproduct_detail%26scene%3Dpdp%26share_app_id%3D1180%26sticky_diversion_config%3D%257B%2522merge_action%2522%253A%2522merge%2522%252C%2522data%2522%253A%257B%2522channel%2522%253A%255B%2522benefit_hub%2522%255D%257D%252C%2522is_sticky%2522%253A1%257D%26touch_point_product_id%3D1730831248044885504%26trackParams%3D%257B%2522enter_from_info%2522%253A%2522product_share_outside%2522%252C%2522source_page_type%2522%253A%2522product_share%2522%252C%2522enable_shop_tab_popup%2522%253A1%257D%26utm_source%3Dopen_api&previous_page=deeplink_ug_seo_outside_gg_product_detail_link_web&refer=web&requestParams=%7B%22product_id%22%3A%5B%221730831248044885504%22%5D%7D&scene=pdp&trackParams=%7B%22enter_from_info%22%3A%22product_share_outside%22%2C%22source_page_type%22%3A%22product_share%22%2C%22enable_shop_tab_popup%22%3A1%7D&traffic_diversion_info=%7B%22traffic_out_source%22%3A%22affiliate_links%22%2C%22page_name%22%3A%22product_detail%22%7D&ug_media_source=deeplink_ug_seo_outside_gg_product_detail_link_web&ug_medium=fe_component&utm_source=open_api&wid=7506871187759580673 | A product promotion deep link that opens the corresponding TikTok Shop product detail page. Agencies can share this link with collaborated creators, and creators can copy/paste it into a web browser (or share it to users). |
| If a user places an order via this link, the resulting e-commerce order will carry these parameter values for tracking. |  |  |  |
| ^^one_link | string | https://snssdk1180.onelink.me/BAuo?params_url=https%3A%2F%2Fshop-id.tokopedia.com%2Fview%2Fproduct%2F1730831248044885504%3Fchain_key%3D%257B%2522event_id%2522%253A%2522o_event_id%2522%252C%2522k%2522%253A%2522000000000000000007596668298679682828%2522%252C%2522sc%2522%253A%2522OPEN_API%2522%252C%2522t%2522%253A1%257D%26div_media_source%3Daffiliate%26event_id%3Do_event_id%26landing_page_name%3Dproduct_detail%26landpage_form%3Dhalf%26page_name%3Dproduct_detail%26scene%3Dpdp%26share_app_id%3D1180%26sticky_diversion_config%3D%257B%2522merge_action%2522%253A%2522merge%2522%252C%2522data%2522%253A%257B%2522channel%2522%253A%255B%2522benefit_hub%2522%255D%257D%252C%2522is_sticky%2522%253A1%257D%26touch_point_product_id%3D1730831248044885504%26trackParams%3D%257B%2522enter_from_info%2522%253A%2522product_share_outside%2522%252C%2522source_page_type%2522%253A%2522product_share%2522%252C%2522enable_shop_tab_popup%2522%253A1%257D%26utm_source%3Dopen_api |  |
| A product promotion one-link that opens the corresponding TikTok Shop product detail page. Agencies can share this link with collaborated creators, and creators can copy/paste it into a web browser (or share it to users). |  |  |  |
| If a user places an order via this link, the resulting e-commerce order will carry these parameter values for tracking. |  |  |  |
| If the user does not have TikTok installed on their phone, they will be redirected to the app store to install TikTok. |  |  |  |
| ^failed_materials | []object |  | The list of materials which failed to generate sharing links for. |
| ^^material_id | string | 7362840009596339923 | Material ID. |
| ^^fail_reason | string | The product was sold out | Fail reason. |
### Response Sample
```json
{"code":0,"data":{"sharing_links":[{"material_id":7362840009596339971,"sharing_link":"https://www.tiktok.com/t/AIxvOHlaJoKO","deep_link":"snssdk1180://ec/pdp?biz_type=0\u0026enter_method=web\u0026gd_label=click_wap_p_product_detail_t_launch_pop_up_s__e__f__fp__fps_affiliate_links_rf_\u0026h5_start_ts=1768977752558\u0026is_commerce=1\u0026jump_time=1768977752558\u0026mall_extra_info=%7B%22mall_out_source%22%3A%22seo.web_product_detail.out_of_app%22%2C%22mall_landing_page%22%3A%22product_detail%22%2C%22mall_homepage_visited_type%22%3A2%7D\u0026media_source=channelshareh5\u0026need_mall=1\u0026needlaunchlog=1\u0026o_app_code=abcsadaadada\u0026page_name=reflow_pdp\u0026page_name=product_detail\u0026params_url=https%3A%2F%2Fshop-id.tokopedia.com%2Fview%2Fproduct%2F1730831248044885504%3Fchain_key%3D%257B%2522event_id%2522%253A%2522o_event_id%2522%252C%2522k%2522%253A%2522000000000000000007596668298679682828%2522%252C%2522sc%2522%253A%2522OPEN_API%2522%252C%2522t%2522%253A1%257D%26div_media_source%3Daffiliate%26event_id%3Do_event_id%26landing_page_name%3Dproduct_detail%26landpage_form%3Dhalf%26page_name%3Dproduct_detail%26scene%3Dpdp%26share_app_id%3D1180%26sticky_diversion_config%3D%257B%2522merge_action%2522%253A%2522merge%2522%252C%2522data%2522%253A%257B%2522channel%2522%253A%255B%2522benefit_hub%2522%255D%257D%252C%2522is_sticky%2522%253A1%257D%26touch_point_product_id%3D1730831248044885504%26trackParams%3D%257B%2522enter_from_info%2522%253A%2522product_share_outside%2522%252C%2522source_page_type%2522%253A%2522product_share%2522%252C%2522enable_shop_tab_popup%2522%253A1%257D%26utm_source%3Dopen_api\u0026previous_page=deeplink_ug_seo_outside_gg_product_detail_link_web\u0026refer=web\u0026requestParams=%7B%22product_id%22%3A%5B%221730831248044885504%22%5D%7D\u0026scene=pdp\u0026trackParams=%7B%22enter_from_info%22%3A%22product_share_outside%22%2C%22source_page_type%22%3A%22product_share%22%2C%22enable_shop_tab_popup%22%3A1%7D\u0026traffic_diversion_info=%7B%22traffic_out_source%22%3A%22affiliate_links%22%2C%22page_name%22%3A%22product_detail%22%7D\u0026ug_media_source=deeplink_ug_seo_outside_gg_product_detail_link_web\u0026ug_medium=fe_component\u0026utm_source=open_api\u0026wid=7506871187759580673","one_link":"https://snssdk1180.onelink.me/BAuo?params_url=https%3A%2F%2Fshop-id.tokopedia.com%2Fview%2Fproduct%2F1730831248044885504%3Fchain_key%3D%257B%2522event_id%2522%253A%2522o_event_id%2522%252C%2522k%2522%253A%2522000000000000000007596668298679682828%2522%252C%2522sc%2522%253A%2522OPEN_API%2522%252C%2522t%2522%253A1%257D%26div_media_source%3Daffiliate%26event_id%3Do_event_id%26landing_page_name%3Dproduct_detail%26landpage_form%3Dhalf%26page_name%3Dproduct_detail%26scene%3Dpdp%26share_app_id%3D1180%26sticky_diversion_config%3D%257B%2522merge_action%2522%253A%2522merge%2522%252C%2522data%2522%253A%257B%2522channel%2522%253A%255B%2522benefit_hub%2522%255D%257D%252C%2522is_sticky%2522%253A1%257D%26touch_point_product_id%3D1730831248044885504%26trackParams%3D%257B%2522enter_from_info%2522%253A%2522product_share_outside%2522%252C%2522source_page_type%2522%253A%2522product_share%2522%252C%2522enable_shop_tab_popup%2522%253A1%257D%26utm_source%3Dopen_api\n"}],"failed_materials":[{"material_id":"7362840009596339923","fail_reason":"The product was sold out"}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Search Affiliate Orders by Creator — `POST /affiliate_creator/202505/orders/trace/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-affiliate-orders-by-creator-202505 · cập nhật 2026-10-28 · scope: creator.affiliate.share_link.read

### Path: /affiliate_creator/202505/orders/trace/search
### Method: [POST]
### Function Description
Retrieves affiliate orders attributed to the creator represented by the current access token. Results can provide order status and timestamps, together with SKU-level product, shop, content, trace, quantity, price, and estimated or actual commission details.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| page_token | string | N | asdasdaszz | An opaque token used to retrieve the next page of a paginated result set. Retrieve this value from the result of the next_page_token from a previous response. It is not needed for the first page. |
| page_size | int | Y | 50 | The number of results to return per page. |
| Valid range: 1 to 100. |  |  |  |  |
### Request Body Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| time_ge | int | Y | 1719807456000 | The inclusive start of the time range for the selected `time_type`, as a Unix timestamp in milliseconds. Orders with timestamps greater than or equal to `time_ge` and less than `time_lt` are included. |
| time_lt | int | Y | 1728443155000 | The exclusive end of the time range for the selected `time_type`, as a Unix timestamp in milliseconds. Orders with timestamps greater than or equal to `time_ge` and less than `time_lt` are included. |
| time_type | string | N | PAY_TIME | Specifies the type of timestamp to filter the orders by. The query time range (time_ge and time_lt) will be applied to the selected time type. |
| Possible values: |  |  |  |  |

* PAY_TIME: Filter based on the order payment time.
* DELIVERY_TIME: Filter based on the order delivery/shipment time.
* SETTLE_TIME: Filter based on the order settlement time.
* CREATE_TIME (default): Filter based on the order creation time. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202505/orders/trace/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&page_token=asdasdaszz&page_size=50
```

**Body**
```json
{"time_ge":1719807456000,"time_lt":1728443155000,"time_type":"PAY_TIME"}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^orders | []object |  | The order resource. |
| ^^id | int | 789078671231123124 | The order identifier. |
| ^^status | string | SETTLED | The current status of the order. Possible values: |

* UNSPECIFIED: The status is undefined and may be updated later.
* ORDERED: The order has been placed, but commission has not been settled. The estimated commission is available.
* SETTLED: The commission has been settled. Actual commission values are populated when the corresponding settled amounts are available.
* REFUNDED: The order was returned, refunded, or canceled by the buyer; actual commission and actual commission base amounts are returned as localized zero values.
* FROZEN: Possible fraud was detected. Commission remains frozen until the issue is resolved.
* DEDUCTED: An additional deduction was made from the balance account.

For statuses other than SETTLED or REFUNDED, actual commission values can be empty. Bonus, shop ads, and creator commission reward amounts are populated only when the corresponding commission data exists; their availability is not determined by order status alone. |
^^skus |[]object | |A list of SKUs associated with the order. |
^^^id |string |1729793769377925388 |The SKU identifier. |
^^^product_id |string |1729793769377859852 |The product identifier. |
^^^price |object | |An object representing the localized price of the product. |
^^^^amount |string |Rp9.900 |The product price as a localized display string. It may include a currency symbol or code and region-specific decimal and grouping separators; see the sibling `currency` field for the currency code. |
^^^^currency |string |IDR |The currency code of the price associated with the product. |
^^^quantity |int |2 |The quantity of this SKU in the order. |
^^^commission_rate |int |1000 |The commission rate associated with the collaboration, in hundredths of a percent. The value does not include a percent sign. For example, `3000` represents 30%. |
^^^estimated_commission_base |object | |An object representing the estimated base commission at the time of order creation. |
^^^^amount |string |Rp9.900 |The estimated commission base as a localized display string. It may include a currency symbol or code and region-specific decimal and grouping separators; see the sibling `currency` field for the currency code. |
^^^^currency |string |IDR |The currency code. |
^^^actual_commission |object | |An object representing the actual creator commission. Its amount includes the components also reported in `actual_bonus_commission` and `actual_creator_commission_reward_fee`. The `actual_shop_ads_commission` amount is separate and is not included. |
^^^^amount |string |Rp1.900 |The actual commission amount as a localized display string. It may include a currency symbol or code and region-specific decimal and grouping separators; see the sibling `currency` field for the currency code. An empty string means that no actual commission value is available. |
^^^^currency |string |IDR |The currency code. |
^^^shop_ads_commission_rate |int |5000 |The commission rate received by a creator for a sale associated with a specific piece of content, in hundredths of a percent. The value does not include a percent sign. For example, `3000` represents 30%. |
^^^commission_bonus_rate |int |1000 |The commission bonus rate associated with the collaboration, in hundredths of a percent. The value does not include a percent sign. For example, `3000` represents 30%. |
^^^product_name |string |black suit |The product name in the TikTok Shop. |
^^^shop_name |string |TestCase idl2l |The name of the TIkTok Shop in which the product is offered for sale. |
^^^returned_quantity |int |1 |The returned quantity of this SKU in the order. |
^^^refunded_quantity |int |0 |The refunded quantity of this SKU in the order. |
^^^campaign_id |string |73661290629 |The campaign identifier associated with the order. |
^^^actual_commission_base |object | |An object representing the actual commission base, calculated by multiplying the product sale price by the number of products sold, subtracting returned and refunded orders. |
^^^^amount |string |Rp9.900 |The actual commission base as a localized display string. It may include a currency symbol or code and region-specific decimal and grouping separators; see the sibling `currency` field for the currency code. For `SETTLED` orders, this contains the actual base when available; for `REFUNDED` orders, it is a localized zero value; for other statuses, it is an empty string. |
^^^^currency |string |IDR |The currency code. |
^^^actual_shop_ads_commission |object | |An object representing the actual shop ads commission, calculated by multiplying the commission base by the shop_ads_commission_rate. |
^^^^amount |string |Rp5.000 |When available, the actual shop ads commission amount as a localized display string. It may include a currency symbol or code and region-specific decimal and grouping separators; see the sibling `currency` field for the currency code. |
^^^^currency |string |IDR |The currency code. |
^^^estimated_shop_ads_commission |object | |An object representing the estimated shop ads commission, calculated by multiplying the estimated commission base by the shop_ads_commission_rate |
^^^^amount |string |Rp8.000 |The estimated shop ads commission amount as a localized display string. It may include a currency symbol or code and region-specific decimal and grouping separators; see the sibling `currency` field for the currency code. |
^^^^currency |string |IDR |The currency code. |
^^^estimated_bonus_commission |object | |An object representing the estimated bonus commission, calculated by multiplying the estimated commission base by the commission bonus rate. |
^^^^amount |string |Rp1.00 |When available, the estimated bonus commission amount as a localized display string. It may include a currency symbol or code and region-specific decimal and grouping separators; see the sibling `currency` field for the currency code. |
^^^^currency |string |IDR |The currency code. |
^^^delivery_time |int |1685548800 |Time and date order delivered, UTC+0 timing |
^^^creator_commission_reward_rate |int |1000 |The commission reward rate that affiliate partners allocate to creators, in hundredths of a percent. The value does not include a percent sign. For example, `1000` represents 10%. |
^^^estimated_creator_commission_reward_fee |object | |Estimated creator commission reward fee. |
^^^^amount |string |250 |When available, the estimated creator commission reward fee as a localized display string. It may include a currency symbol or code and region-specific decimal and grouping separators; see the sibling `currency` field for the currency code. |
^^^^currency |string |IDR |The currency code. |
^^^actual_creator_commission_reward_fee |object | |Actual creator commission reward fee. |
^^^^amount |string |100 |When available, the actual creator commission reward fee as a localized display string. It may include a currency symbol or code and region-specific decimal and grouping separators; see the sibling `currency` field for the currency code. |
^^^^currency |string |IDR |The currency code. |
^^^content_type |string |LIVE |The content format of the creator content through which the order was created.
Possible values:

* SHOP
* VIDEO
* LIVE
* PRE_LIVE
* PROMOTION_PAGE
* LINKSHARE |
   ^^^content_id |string |7493990579714164574 |The content identifier for the creator content through which the order was created. |
   ^^^trace |object | |Extra information for tracing purposes. |
   ^^^^id |string |15678763 |When `trace.type` is `GENERAL`, this is the `event_id` embedded in the general sharing link. When `trace.type` is `SPECIFIC`, this is the `publisher_id` supplied when generating the specific-publisher sharing link. |
   ^^^^type |string |SPECIFIC |For the orders coming from the sharing links for specific publishers, the value is `SPECIFIC`; for the orders coming from the general sharing links, the value is `GENERAL`. |
   ^^^estimated_commission |object | |An object representing the estimated creator commission. Its amount includes the components also reported in `estimated_bonus_commission` and `estimated_creator_commission_reward_fee`. The `estimated_shop_ads_commission` amount is separate and is not included. |
   ^^^^amount |string |1 |The estimated commission amount as a localized display string. It may include a currency symbol or code and region-specific decimal and grouping separators; see the sibling `currency` field for the currency code. |
   ^^^^currency |string |USD |The currency code. |
   ^^^actual_bonus_commission |object | |An object representing the actual bonus commission, calculated by multiplying the actual commission base by the commission bonus rate. |
   ^^^^amount |string |1 |The actual bonus commission amount as a localized display string. It may include a currency symbol or code and region-specific decimal and grouping separators; see the sibling `currency` field for the currency code. |
   ^^^^currency |string |USD |The currency code. |
   ^^create_time |int |1685548800 |Time and date of order created, UTC+0 timing |
   ^^delivery_time |int |1685548800 |Time and date order delivered, UTC+0 timing |
   ^next_page_token |string |b2Zmc2V0PTEw |An opaque token used to retrieve the next page of a paginated result set.
   |
   ^total_count |int |10 |Total count of orders in the response.
   |

### Response Sample
```json
{"code":0,"data":{"orders":[{"id":789078671231123124,"status":"SETTLED","skus":[{"id":"1729793769377925388","product_id":"1729793769377859852","price":{"amount":"Rp9.900","currency":"IDR"},"quantity":2,"commission_rate":1000,"estimated_commission_base":{"amount":"Rp9.900","currency":"IDR"},"actual_commission":{"amount":"Rp1.900","currency":"IDR"},"shop_ads_commission_rate":5000,"commission_bonus_rate":1000,"product_name":"black suit","shop_name":"TestCase idl2l","returned_quantity":1,"refunded_quantity":0,"campaign_id":"73661290629","actual_commission_base":{"amount":"Rp9.900","currency":"IDR"},"actual_shop_ads_commission":{"amount":"Rp5.000","currency":"IDR"},"estimated_shop_ads_commission":{"amount":"Rp8.000","currency":"IDR"},"estimated_bonus_commission":{"amount":"Rp1.00","currency":"IDR"},"delivery_time":1685548800,"creator_commission_reward_rate":1000,"estimated_creator_commission_reward_fee":{"amount":"250","currency":"IDR"},"actual_creator_commission_reward_fee":{"amount":"100","currency":"IDR"},"content_type":"LIVE","content_id":"7493990579714164574","trace":{"id":"15678763","type":"SPECIFIC"},"estimated_commission":{"amount":"1","currency":"USD"},"actual_bonus_commission":{"amount":"1","currency":"USD"}}],"create_time":1685548800,"delivery_time":1685548800}],"next_page_token":"b2Zmc2V0PTEw","total_count":10},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Search Creator Affiliate Orders — `POST /affiliate_creator/202410/orders/search`

Doc: https://partner.tiktokshop.com/docv2/page/search-creator-affiliate-orders-202410 · cập nhật 2026-10-13 · scope: creator.affiliate_collaboration.read

### Path: /affiliate_creator/202410/orders/search
### Method: [POST]
### Function Description
Search affiliate orders attributed to the authenticated creator. The response includes order and SKU details, order status, content attribution, commission rates, and estimated or actual commission amounts for tracking affiliate conversions.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
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
| create_time_ge | int | N | 1719807456 | Filter orders to show only those that are created on or after the specified date and time. Unix timestamp. |
| Note: |  |  |  |  |
| `create_time_ge` and `create_time_lt` together constitute the creation time filter condition. |  |  |  |  |

* If `create_time_ge` is filled but `create_time_lt` is empty, `create_time_lt` will default to the current time.
* If `create_time_lt` is filled but `create_time_ge` is empty, `create_time_ge` will default to the earliest shop time. |
   create_time_lt |int |N |1728443155 |Filter orders to show only those created before the specified time, expressed as a Unix timestamp in seconds. Refer to the notes in `create_time_ge` for more usage information. |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202410/orders/search?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&page_token=b2Zmc2V0PTAK&page_size=20
```

**Body**
```json
{"create_time_ge":1719807456,"create_time_lt":1728443155}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^orders | []object |  | The order resource. |
| ^^id | string | 789078671231123124 | The order identifier. |
| ^^create_time | int | 1685548800 | The time when the order was created, as a Unix timestamp in seconds (UTC). |
| ^^delivery_time | int | 1685548800 | The time when the order was delivered, as a Unix timestamp in seconds (UTC). |
| ^^status | string | SETTLED | The current status of the order. Possible options are: |

* UNSPECIFIED: The status of the order is undefined. It might be updated later.
* AWAITING PAYMENT：The order hasn't been paid yet, only estimated commission is available
* To-SETTLE：The order is waiting for settlement, only estimated commission is available
* SETTLED: The commission of the order is already settled.
* REFUNDED: The order has been returned/refunded/canceled by the buyer, and no commission will be settled.
* FROZEN: Possible fraud has been detected regarding the order. The commission will be unfrozen after the fraud is resolved. |
   ^^skus |[]object | |A list of SKUs associated with the order. |
   ^^^id |string |1729793769377925388 |The SKU identifier. |
   ^^^campaign_id |string |73661290629 |The campaign identifier associated with the order. |
   ^^^open_collaboration_id |string |73661290629 |The open collaboration identifier associated with the order. |
   ^^^target_collaboration_id |string |73661290629 |The target collaboration identifier associated with the order. |
   ^^^product_name |string |black_suit |The product name in the TikTok Shop. |
   ^^^product_id |string |1729793769377859852 |The product identifier. |
   ^^^price |object | |An object representing the localized price of the product. |
   ^^^^amount |string |Rp9.900 |The value of the price associated with the product. |
   ^^^^currency |string |IDR |The currency code of the price associated with the product. |
   ^^^shop_name |string |TestCase idl2l |The name of the TIkTok Shop in which the product is offered for sale. |
   ^^^content_type |string |LIVE |The content format of the creator content through which the order was created.
   Possible values:
* SHOP
* VIDEO
* LIVE
* PRE_LIVE
* PROMOTION_PAGE
* LINKSHARE |
   ^^^content_id |string |7493990579714164574 |The content identifier for the creator content through which the order was created. |
   ^^^quantity |int |2 |The quantity of this SKU in the order, including refunded units. |
   ^^^commission_rate |int |1000 |The total commission rate for this SKU, equal to the sum of the standard commission rate, shop ads commission rate, bonus rate, and reward rate. It is expressed in hundredths of a percent; the percent sign (`%`) is not included. For example, `3000` represents a 30% commission. |
   ^^^commission_tier_setting |string |3.0 OR 5.0 |Between Seller & Creator percentagecommission. When tiering commission model applied, will return each tier's commission rate seller set. |
   ^^^commission_model |string |Tiered commission |The commission model used for the order.
   Possible values:
* Fixed commission
* Tiered commission |
   ^^^commission_bonus_rate |int |1000 |The commission bonus rate associated with the collaboration. It is expressed in hundredths of a percent; the percent sign (`%`) is not included. For example, `3000` represents a 30% commission. |
   ^^^estimated_commission_base |object | |An object representing the estimated base commission at the time of order creation. |
   ^^^^amount |string |Rp9.900 |The estimated commission base amount. |
   ^^^^currency |string |IDR |The currency code. |
   ^^^standard_commission_rate |int |5000 |The standard affiliate commission rate associated with the collaboration. It is expressed in hundredths of a percent; the percent sign (`%`) is not included. For example, `3000` represents a 30% commission. |
   ^^^shop_ads_commission_rate |int |5000 |The commission rate received by a creator for a sale associated with a specific piece of content. It is expressed in hundredths of a percent; the percent sign (`%`) is not included. For example, `3000` represents a 30% commission. |
   ^^^estimated_bonus_commission |object | |An object representing the estimated bonus commission, calculated by multiplying the estimated commission base by the commission bonus rate. |
   ^^^^amount |string |Rp1.00 |The estimated bonus commission amount. |
   ^^^^currency |string |IDR |The currency code. |
   ^^^estimated_standard_commission |object | |An object representing the estimated standard affiliate commission, calculated by multiplying the estimated commission base by the `standard_commission_rate`. |
   ^^^^amount |string |Rp8.000 |The estimated standard commission amount. |
   ^^^^currency |string |IDR |The currency code. |
   ^^^estimated_shop_ads_commission |object | |An object representing the estimated shop ads commission, calculated by multiplying the estimated commission base by the shop_ads_commission_rate |
   ^^^^amount |string |Rp8.000 |The estimated shop ads commission amount. |
   ^^^^currency |string |IDR |The currency code. |
   ^^^estimated_commission |object | |The creator's total estimated commission earnings for this SKU after applicable additions and deductions. |
   ^^^^amount |string |Rp1.980 |The estimated commission amount. |
   ^^^^currency |string |IDR |The currency code. |
   ^^^actual_commission |object | |Represents the final earnings of this sku, calculated by multiplying the actual commission base by the total commission rate, and then deducting the taxes or revenue sharing with the agency amount. |
   ^^^^amount |string |Rp1.900 |The actual commission amount. |
   ^^^^currency |string |IDR |The currency code. |
   ^^^actual_bonus_commission |object | |An object representing the actual bonus commission, calculated by multiplying the actual commission base by the commission bonus rate. |
   ^^^^amount |string |Rp2.000 |The actual bonus commission amount. |
   ^^^^currency |string |IDR |The currency code. |
   ^^^actual_commission_base |object | |An object representing the actual commission base, calculated by multiplying the product sale price by the number of products sold, subtracting returned and refunded orders. |
   ^^^^amount |string |Rp9.900 |The value of the actual commission base. |
   ^^^^currency |string |IDR |The currency code. |
   ^^^actual_standard_commission |object | |An object representing the actual standard affiliate commission, calculated by multiplying the commission base by the standard_commission_rate. |
   ^^^^amount |string |Rp5.000 |The actual standard commission amount. |
   ^^^^currency |string |IDR |The currency code. |
   ^^^actual_shop_ads_commission |object | |An object representing the actual shop ads commission, calculated by multiplying the commission base by the shop_ads_commission_rate. |
   ^^^^amount |string |Rp5.000 |The actual shop ads commission amount. |
   ^^^^currency |string |IDR |The currency code. |
   ^^^returned_quantity |int |1 |The returned quantity for this SKU in the order. |
   ^^^refunded_quantity |int |0 |The refunded quantity for this SKU in the order. |
   ^^^tag |string |test-01 |A field for storing user-defined metadata for tracking purposes. |
   ^^^creator_commission_reward_rate |int |1000 |The commission reward rate that an affiliate partner allocates to the creator. It is expressed in hundredths of a percent; the percent sign (`%`) is not included. For example, `1000` represents 10%. |
   ^^^estimated_creator_commission_reward_fee |object | |Estimated creator commission reward fee. |
   ^^^^amount |string |250 |The estimated fee creators receive from affiliate partners through commission rewards |
   ^^^^currency |string |IDR |The currency code. |
   ^^^actual_creator_commission_reward_fee |object | |Actual creator commission reward fee. |
   ^^^^amount |string |100 |The actual fee creators receive from affiliate partners through commission rewards |
   ^^^^currency |string |IDR |The currency code. |
   ^^^isr |object | |Only for Mexico creator, platform collected related revenue taxes on behalf of government based on regulation. |
   ^^^^amount |string |100 |The actual isr amount. |
   ^^^^currency |string |MXN |The currency code. |
   ^^^iva |object | |Only for Mexico creator, platform collected related revenue taxes on behalf of government based on regulation. |
   ^^^^amount |string |100 |The actual iva amount. |
   ^^^^currency |string |MXN |The currency code. |
   ^^^pit |object | |Only for VN/TH/PH/ID creators, sellers collect related withholding taxes based on regulation. |
   ^^^^amount |string |100 |The actual pit amount. |
   ^^^^currency |string |IDR |The currency code. |
   ^^^shared_with_partner |object | |The amount of the creator's after-tax revenue shared with the affiliated institution under the applicable fee agreement. |
   ^^^^amount |string |100 |The actual shared with partner amount. |
   ^^^^currency |string |IDR |The currency code. |
   ^^^trace_info |object | |Extra information for tracing purposes. |
   ^^^^id |string |15678763 |When `trace_info.type` is `GENERAL`, this is the `{eid}` provided in `sharing_link`; when `trace_info.type` is `SPECIFIC`, this is the `publisher_id`. |
   ^^^^type |string |SPECIFIC |For the orders coming from the sharing links for specific publishers, the value is `SPECIFIC`; for the orders coming from the general sharing links, the value is `GENERAL`. |
   ^^^last_update_time |int |1685548800 |The time when the record was last updated, as a Unix timestamp in seconds (UTC). |
   ^^^is_carousel |bool |false |Carousel content may involve a commission rate discount. Returns true when the order is attributed to carousel content. |
   ^next_page_token |string |b2Zmc2V0PTEw |An opaque token used to retrieve the next page of results. Specify `create_time_ge` and `create_time_lt` in the first request and reuse the same values for every page. Pass a non-empty returned token as `page_token` in the next request. An empty value indicates the last page; stop requesting additional pages. |
   ^total_count |int |10 |The total number of SKU orders that match the search criteria. `page_size` limits SKU-order rows before they are grouped into `orders`; because one order can contain multiple SKUs, the number of returned order objects can be less than `page_size`. Use `next_page_token` to continue pagination. |

### Response Sample
```json
{"code":0,"data":{"orders":[{"id":"789078671231123124","create_time":1685548800,"delivery_time":1685548800,"status":"SETTLED","skus":[{"id":"1729793769377925388","campaign_id":"73661290629","open_collaboration_id":"73661290629","target_collaboration_id":"73661290629","product_name":"black_suit","product_id":"1729793769377859852","price":{"amount":"Rp9.900","currency":"IDR"},"shop_name":"TestCase idl2l","content_type":"LIVE","content_id":"7493990579714164574","quantity":2,"commission_rate":1000,"commission_tier_setting":"3.0 OR 5.0","commission_model":"Tiered commission","commission_bonus_rate":1000,"estimated_commission_base":{"amount":"Rp9.900","currency":"IDR"},"standard_commission_rate":5000,"shop_ads_commission_rate":5000,"estimated_bonus_commission":{"amount":"Rp1.00","currency":"IDR"},"estimated_standard_commission":{"amount":"Rp8.000","currency":"IDR"},"estimated_shop_ads_commission":{"amount":"Rp8.000","currency":"IDR"},"estimated_commission":{"amount":"Rp1.980","currency":"IDR"},"actual_commission":{"amount":"Rp1.900","currency":"IDR"},"actual_bonus_commission":{"amount":"Rp2.000","currency":"IDR"},"actual_commission_base":{"amount":"Rp9.900","currency":"IDR"},"actual_standard_commission":{"amount":"Rp5.000","currency":"IDR"},"actual_shop_ads_commission":{"amount":"Rp5.000","currency":"IDR"},"returned_quantity":1,"refunded_quantity":0,"tag":"test-01","creator_commission_reward_rate":1000,"estimated_creator_commission_reward_fee":{"amount":"250","currency":"IDR"},"actual_creator_commission_reward_fee":{"amount":"100","currency":"IDR"},"isr":{"amount":"100","currency":"MXN"},"iva":{"amount":"100","currency":"MXN"},"pit":{"amount":"100","currency":"IDR"},"shared_with_partner":{"amount":"100","currency":"IDR"},"trace_info":{"id":"15678763","type":"SPECIFIC"},"last_update_time":1685548800,"is_carousel":false}]}],"next_page_token":"b2Zmc2V0PTEw","total_count":10},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Check Creator Sample Eligibility — `GET /affiliate_creator/202412/samples/labels`

Doc: https://partner.tiktokshop.com/docv2/page/check-creator-sample-eligibility-202412 · cập nhật 2026-10-28 · scope: creator.affiliate_collaboration.read

### Path: /affiliate_creator/202412/samples/labels
### Method: [GET]
### Function Description
Check if a creator can apply for a sample of a specific product.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| product_id | string | Y | 1729480364147774364 | The TikTok Shop product identifier. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202412/samples/labels?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&product_id=1729480364147774364
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^label | object |  | Creator applicable sample label information. |
| ^^can_apply | bool | true | Whether the authenticated creator can apply for a sample of the specified product. |
| ^^status | string | ONGOING | Status indicating whether the creator has applied for a free sample of the specified product. |

* UNKNOWN: The application status is unknown.
* TO_APPLY: The creator has not applied for a free sample of the product.
* ONGOING: The creator has applied for a free sample but has not completed sample fulfillment.
* COMPLETE: The creator has applied for a free sample and completed sample fulfillment. |
   ^^application_id |string |86427198341982134 |Sample Application ID. only appear when the creator has already applied this product. |
   ^^reach_limit |bool |true |If the creator has reached the sample application upper limit. |
   ^^sample_product |object | |The sample product information. |
   ^^^sample_sku_list |[]object | |The sample product SKU information. |
   ^^^^id |string |1731055098570377347 |The SKU identifier. |
   ^^^^sale_property_value_ids |string |7068196393634072325 |The SKU property value identifiers joined with underscores (`_`) in the same order as the entries in `sale_properties`. |
   ^^^^price |object | |SKU price information. |
   ^^^^^amount |string |7588986 |The SKU price in major units of the currency specified by `currency`, represented as a decimal string. |
   ^^^^^currency |string |USD |The price currency code. |
   ^^^^sale_properties |[]object | |The SKU property information. |
   ^^^^^id |string |100000 |A SKU property identifier, short for "Stock Keeping Unit Property ID", is a specific identification code assigned to a particular property or characteristic of a SKU.(i.e: "100000" means "color") |
   ^^^^^name |string |color |The SKU property name. |
   ^^^^^value_id |string |7425668826861520646 |The SKU property value identifier is an identification code related to the specific values of the properties of a Stock Keeping Unit (SKU).
   When a SKU has certain properties like color, size, etc., each possible value for those properties has its own unique SKU property value identifier. For instance, if the property is "color" and the possible values are "red", "blue", "green", then "red" would have its own SKU property vvalue identifier, "blue" would have another one, and so on. |
   ^^^^^value_name |string |Default |The SKU property value name. |
   ^^^^is_available |bool |true |Whether this SKU is available for the creator to apply for as a sample. |
   ^^^^unavailable_reason |string |IS_PREORDER |The reason code associated with SKU sample availability. Interpret a specific unavailability reason only when `is_available` is `false`. `UNKNOWN` can also be returned when `is_available` is `true` because no unavailability reason applies.
   Possible values:
* IS_PREORDER: The product is a preorder product and does not support free samples.
* IS_GIFT: The product is a gift and does not support free samples.
* OUT_OF_STOCK: The product is out of stock.
* EXCEED_CB_PRICE_THRESHOLD: The SKU price exceeds the applicable cross-border price threshold.
* ALREADY_APPLYED: The creator has already applied for this SKU.
* UNKNOWN: No mapped unavailability reason is available. |

### Response Sample
```json
{"code":0,"data":{"label":{"can_apply":true,"status":"ONGOING","application_id":"86427198341982134","reach_limit":true,"sample_product":{"sample_sku_list":[{"id":"1731055098570377347","sale_property_value_ids":"7068196393634072325","price":{"amount":"7588986","currency":"USD"},"sale_properties":[{"id":"100000","name":"color","value_id":"7425668826861520646","value_name":"Default"}],"is_available":true,"unavailable_reason":"IS_PREORDER"}]}}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Upload Shoppable Video File — `POST /affiliate_creator/202505/videos/video_files`

Doc: https://partner.tiktokshop.com/docv2/page/upload-shoppable-video-file-202505 · cập nhật 2026-10-13 · scope: creator.video.write

### Path: /affiliate_creator/202505/videos/video_files
### Method: [POST]
### Function Description
Upload a video file before posting a shoppable video to TikTok. After the upload succeeds, call `POST /affiliate_creator/202505/videos` and pass the returned `video_file.id` as `video_info.file_id`.

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
| data | file | Y |  | The local file to be uploaded. |
| Note： |  |  |  |  |

* For files larger than 10 MB, use the [Large File Uploads](https://partner.tiktokshop.com/docv2/page/wfi3nz36).
* Supported formats: MP4, MOV, MKV, WMV, WEBM, AVI, 3GP, FLV, MPEG
* Max video size: 10 MB
* Video aspect ratio: 9:16 to 16:9
   Recommendations for product videos:
* Resolution: 720p or higher
* Duration: > 30 seconds |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202505/videos/video_files?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^video_file | object |  | Video file information. |
| ^^id | string | 123123123123 | The id from of the uploaded video file. |
| ^^md5 | string | D41D8CD98F00B204E9800998ECF8427E | Upload file md5 checksum |
### Response Sample
```json
{"code":0,"data":{"video_file":{"id":"123123123123","md5":"D41D8CD98F00B204E9800998ECF8427E"}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get Shop Products — `GET /affiliate_creator/202509/shop_products`

Doc: https://partner.tiktokshop.com/docv2/page/get-shop-products-202509 · cập nhật 2026-10-13 · scope: creator.video.write

### Path: /affiliate_creator/202509/shop_products
### Method: [GET]
### Function Description
Searches for products in the shop bound to the authenticated creator. Optionally use `title_keyword` to filter products by title. The creator must have a bound shop before calling this API.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
| title_keyword | string | N | apple | The title keyword of the product you wish to search by. |
| sort_field | string | N | PRODUCT_ID | Sort field. |
| Possible values: |  |  |  |  |

* PRODUCT_ID
* PRICE
* SALE

If omitted or empty, defaults to PRODUCT_ID. Any other value is rejected. |
sort_order |string |N |DESC |Sort order.
Possible values:

* DESC
* ASC

If omitted or empty, defaults to DESC. Any other value is rejected. |
page_size |int |Y |20 |Pagination count determines how many products you'll get after sending the request. 20 is a recommended number.
Valid Range: [1-100] |
page_token |string |N |b2Zmc2V0PTAK |An opaque token used to retrieve the next page. Leave this parameter empty for the first request. For subsequent requests, pass the `next_page_token` returned by the previous response and reuse the same `title_keyword`, `sort_field`, `sort_order`, and `page_size` values. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202509/shop_products?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268&title_keyword=apple&sort_field=PRODUCT_ID&sort_order=DESC&page_size=20&page_token=b2Zmc2V0PTAK
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^products | []object |  | The searched product list. It will be empty when there are no search results. |
| ^^id | string | 1729592969712207012 | TikTok product ID. |
| ^^title | string | testcase autotest Live Product | Product name. |
| ^^price | object |  | Product price shown with two decimal places and currency. |
| ^^^amount | string | 56.00 | Product price with two decimal places. |
| ^^^currency | string | USD | Product price currency, based on region where creators can sell. |
| ^^added_status | string | ADDABLE |  |
| Showcase add status with possible values: |  |  |  |

* ADDABLE
* ADDED
* REJECTED |
   ^^brand_name |string |Apple |The brand name a seller has set for a product. |
   ^^images |[]object | |Images of a product. |
   ^^^url |string |https://p19-pu-sign-useast8.tiktokcdn-us.com/tos-useast5-avt-0068-tx/982dd6b4e46a6a24203b00611a474cca~c5_1080x1080.webp |The URL of the product image. |
   ^^^width |int |200 |The width of the product image. |
   ^^^height |int |200 |The height of the product image. |
   ^^sales_count |int |33 |The number of products that have been sold. |
   ^total_count |int |300 |The total number of products that meet the query conditions. |
   ^next_page_token |string |b2Zmc2V0PTIw |An opaque token used to retrieve the next page. Pass it as `page_token` in the next request. It is empty when there are no more products to retrieve. |

### Response Sample
```json
{"code":0,"data":{"products":[{"id":"1729592969712207012","title":"testcase autotest Live Product","price":{"amount":"56.00","currency":"USD"},"added_status":"ADDABLE\n","brand_name":"Apple","images":[{"url":"https://p19-pu-sign-useast8.tiktokcdn-us.com/tos-useast5-avt-0068-tx/982dd6b4e46a6a24203b00611a474cca~c5_1080x1080.webp","width":200,"height":200}],"sales_count":33}],"total_count":300,"next_page_token":"b2Zmc2V0PTIw"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get Shoppable Video Status — `GET /affiliate_creator/202509/videos/{video_id}/status`

Doc: https://partner.tiktokshop.com/docv2/page/get-shoppable-video-status-202509 · cập nhật 2026-10-13 · scope: creator.video.write

### Path: /affiliate_creator/202509/videos/{video_id}/status
### Method: [GET]
### Function Description
Use this API to get shoppable video posting results.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| video_id | string | Y | 7548431509997292816 | The video id from [Publish Shoppable Video] |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202509/videos/7548431509997292816/status?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^video | object |  | returned video info |
| ^^id | string | 7493990579714164574 | Video id |
| ^^post_status | string | FAIL | Video posting status. Possible values: |

* SUCCESS: The video was posted successfully.
* FAIL: The video failed to post.
* PROCESSING: The video is still being processed. Call this API again later to get the latest status. |
   ^^post_time |int |1685548800 |Returned if the video has been successfully posted, i.e. `posting_status = SUCCESS`.
   Represented in seconds. |

### Response Sample
```json
{"code":0,"data":{"video":{"id":"7493990579714164574","post_status":"FAIL","post_time":1685548800}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 38007001 | System Error |
| 170001016 | The video does not belong to the creator or the video is not photo post. Please check valid video status. |


---

## Create Video Precheck Task — `POST /affiliate_creator/202511/videos/precheck_task`

Doc: https://partner.tiktokshop.com/docv2/page/create-video-precheck-task-202511 · cập nhật 2026-10-28 · scope: creator.video.write

### Path: /affiliate_creator/202511/videos/precheck_task
### Method: [POST]
### Function Description
Use this API to create a task that checks a video and its shoppable content anchor for violations. If the task is created successfully, the response returns a task ID.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
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
| video_info | object | Y |  | Video information |
| ^file_id | string | Y | v12d00gd0024d3nfqr7og65 | Video file_id from [Upload Shoppable Video File](https://api/affiliate_creator/202505/videos/video_files) |
| product_link_info | object | Y |  | Product link information |
| ^product_id | string | Y | 17294069642063424 | Use product_id to bind the product with the video. |
| The product_id from [Get Shop Products](https://api/affiliate_creator/202509/shop_products) or [Get Showcase Products](https://api/affiliate_creator/202405/showcases/products) |  |  |  |  |
| ^title | string | Y | Sample product anchor title | The title to be shown on the product anchor. Anchor title should be shorter than 30 characters. Titles may be rejected for punctuation, emoji, or offensive language. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202511/videos/precheck_task?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

**Body**
```json
{"video_info":{"file_id":"v12d00gd0024d3nfqr7og65"},"product_link_info":{"product_id":"17294069642063424","title":"Sample product anchor title"}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^precheck | object |  | Information about the created video content pre-check task. |
| ^^task_id | string | 1123123123 | The ID of the created video pre-check task. Pass this value as the `task_id` path parameter to `GET /affiliate_creator/202511/videos/precheck_tasks/{task_id}` to retrieve the result. |
### Response Sample
```json
{"code":0,"data":{"precheck":{"task_id":"1123123123"}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16011007 | Product link title should be no longer than 30 characters. |
| 16011009 | Product link title contains offensive language. |
| 16011069 | Product link title contains punctuation or emoji. |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 170001002 | Creator TikTok Shop permission check failed. |
| 170001005 | Creator terms of service not signed. Please contact TikTok for more details. |
| 170001006 | GKA terms not signed. Please try again after signing GKA term. |
| 170001007 | Creator did not sign the EU data share agreement. |
| 170001008 | Creator Age verification failed. Please verify age first. |
| 170001009 | The product belongs to unsupported category. |
| 170001010 | The commission plan gets failed or rejected. |
| 170001011 | The product doesn't exist. |
| 170001012 | The product is not available. |
| 170001013 | Showcase SPU exceeds limit. |
| 170001014 | Blocked by spam check. |
| 170001015 | Blocked by TikTok Shop risk control. |
| 170001018 | Get creator pay account error. Please verify the pay account first. |
| 170001019 | The user has exceeded allocated daily quota for precheck resource |


---

## Get Shoppable Video Precheck Result — `GET /affiliate_creator/202601/videos/precheck_tasks/{task_id}`

Doc: https://partner.tiktokshop.com/docv2/page/get-shoppable-video-precheck-result-202601 · cập nhật 2026-10-28 · scope: creator.video.write

### Path: /affiliate_creator/202601/videos/precheck_tasks/{task_id}
### Method: [GET]
### Function Description
Retrieve the violation and, when enabled, good-quality check results for a video precheck task. If a returned check status is `PROCESSING`, call this API again later. If a check status is `FAIL`, review its `issues` field for the detected issues and suggested improvements.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
| content-type | header | string | Y | application/json | Allowed type: application/json |
### Request Path Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| task_id | string | Y | 7493990579714164574 | task id from [Precheck Video Content](https://partner.tiktokshop.com/docv2/page/precheck-video-content-202511) |
### Request Query Parameters
| Properties  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- |
| app_key | string | Y | 38abcd | Every single app will have a unique key. Please use the specific key assigned to your app. |
| sign | string | Y | 5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c | Signature generated by gen algorithm. When you send API requests to TTS, you must sign them so that TTS can identify the senders. |
| timestamp | int | Y | 1623812664 | Unix timestamp GMT (UTC+00:00). This timestamp is used across all API requests. Developers can use this convert to local time. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202601/videos/precheck_tasks/7493990579714164574?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^precheck_task | object |  | Video pre-check task |
| ^^id | string | 7493990579714164574 | The id of the video pre-check task. |
| ^^violation_check_result | object |  | violation check details |
| ^^^status | string | FAIL | SUCCESS: The precheck task passed violation checks |
| FAIL: The precheck task has failed due to violations. Check the 'issues' field for details. |  |  |  |
| PROCESSING: The precheck violation task is still in progress |  |  |  |
| ^^^issues | []object |  | A list of policy violation details returned when violation check fails |
| ^^^^risk | string | Pirated Content | Policy violation |
| ^^^^suggestions | string | Your video may include unoriginal content. Creating original content is essential for standing out from the crowd. | Detailed guidance to resolve the detected violation. |
| ^^good_quality_check_result | object |  | Good-quality check details. This field is omitted when the good-quality check is disabled. |
| ^^^status | string | FAIL | SUCCESS: The precheck task passed all good quality checks |
| FAIL: The precheck task failed good quality checks. Check the 'issues' field for details. |  |  |  |
| PROCESSING: The good qualtify check is still in progress |  |  |  |
| ^^^issues | []object |  | A list of quality issues and improvement suggestions when the good quality check fails. |
| ^^^^code | string | LOW_CONTENT_PROMOTIO | Quality finding |
| ^^^^suggestions | string | You can try to showcase the product from multiple perspectives. | Recommended improvements based on the quality finding. |
### Response Sample
```json
{"code":0,"data":{"precheck_task":{"id":"7493990579714164574","violation_check_result":{"status":"FAIL","issues":[{"risk":"Pirated Content","suggestions":"Your video may include unoriginal content. Creating original content is essential for standing out from the crowd."}]},"good_quality_check_result":{"status":"FAIL","issues":[{"code":"LOW_CONTENT_PROMOTIO","suggestions":"You can try to showcase the product from multiple perspectives."}]}}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Upload Shoppable Photo File — `POST /affiliate_creator/202511/photos/photo_files`

Doc: https://partner.tiktokshop.com/docv2/page/upload-shoppable-photo-file-202511 · cập nhật 2026-10-28 · scope: creator.video.write

### Path: /affiliate_creator/202511/photos/photo_files
### Method: [POST]
### Function Description
Use this API to upload the photos before photo posting. It returns the photo_file_uri for each uploaded image

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
| data | file | Y |  | The local image file to upload. |
Requirements:

* Supported formats: JPG, JPEG, PNG, WEBP, HEIC, BMP
* Zero-byte files are rejected.
* Maximum file size: 10 MiB (10,485,760 bytes).
* Aspect ratio: 9:16 to 16:9 |

### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202511/photos/photo_files?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^photo_file | object |  | Photo Info |
| ^^photo_uri | string | skldjfskdlfjlskdfs000023423s | In [Post Shoppable Photos], use this photo URI to fill photo_file_uris field |
### Response Sample
```json
{"code":0,"data":{"photo_file":{"photo_uri":"skldjfskdlfjlskdfs000023423s"}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |


---

## Post Shoppable Video — `POST /affiliate_creator/202603/videos`

Doc: https://partner.tiktokshop.com/docv2/page/post-shoppable-video-202603 · cập nhật 2026-10-28 · scope: creator.video.write

### Path: /affiliate_creator/202603/videos
### Method: [POST]
### Function Description
Use this API to submit a shoppable video for publishing. When the submission succeeds, pass the returned video ID as the `video_id` path parameter to Get Shoppable Video Status (`GET /affiliate_creator/202509/videos/{video_id}/status`) to retrieve the posting status: `PROCESSING`, `SUCCESS`, or `FAIL`. If the status is `PROCESSING`, call the status API again later to check for a terminal status.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
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
| video_info | object | Y |  | Video information |
| ^file_id | string | Y | v12d00gd0024d3nfqr7og65 | The video file ID returned by Upload Shoppable Video File (`POST /affiliate_creator/202505/videos/video_files`). |
| ^title | string | Y | Sample video title | The video caption. |
| The maximum length is 2200 in UTF-16 runes. |  |  |  |  |
| If not specified, the ticket post will not have any captions. |  |  |  |  |
| ^cover_uri | string | N | v12d00gd0024d3nfqr7og65oooiuuyy | The video cover image URI returned by Upload Shoppable Photo File (`POST /affiliate_creator/202511/photos/photo_files`). |
| ^cover_timestamp_ms | int | N | 1000 | The input parameter is a timestamp, which specifies a particular moment in the video. The frame at that timestamp will be used as the video cover. If cover_uri and cover_timestamp_ms are both not provided, the cover will default to the first frame of the uploaded video. Only one of cover_uri or cover_timestamp_ms can be provided. If both parameters are passed, cover_uri will take precedence. |
| ^music_id | string | N | 717294069642063456 | The music ID for the video's background music. Obtain it from Search Music (`GET /affiliate_creator/202602/music/search`). If not provided, no music will be associated with the video. |
| product_link_info | object | Y |  | Product link information |
| ^product_id | string | Y | 17294069642063424 | The product ID to bind to the video. Obtain it from Get Shop Products (`GET /affiliate_creator/202509/shop_products`) or Get Showcase Products (`GET /affiliate_creator/202405/showcases/products`). |
| ^title | string | Y | Sample product anchor title | The title to be shown on the product anchor. Anchor title should be shorter than 30 characters. Titles may be rejected for punctuation, emoji, or offensive language. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202603/videos?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

**Body**
```json
{"video_info":{"file_id":"v12d00gd0024d3nfqr7og65","title":"Sample video title","cover_uri":"v12d00gd0024d3nfqr7og65oooiuuyy","cover_timestamp_ms":1000,"music_id":"717294069642063456"},"product_link_info":{"product_id":"17294069642063424","title":"Sample product anchor title"}}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^video | object |  | Submitted shoppable video information. |
| ^^id | string | 7548431509997292816 | The video id, use this id to query video publish status. |
### Response Sample
```json
{"code":0,"data":{"video":{"id":"7548431509997292816"}},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16011007 | Product link title should be no longer than 30 characters. |
| 16011009 | Product link title contains offensive language. |
| 16011069 | Product link title contains punctuation or emoji. |
| 38007001 | System Error |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 170001002 | Creator TikTok Shop permission check failed. |
| 170001003 | Creator Tiktok Shop permission temporarily banned. |
| 170001004 | Creator TikTok Shop permission is permanently banned. |
| 170001005 | Creator terms of service not signed. Please contact TikTok for more details. |
| 170001006 | GKA terms not signed. Please try again after signing GKA term. |
| 170001007 | Creator did not sign the EU data share agreement. |
| 170001008 | Creator Age verification failed. Please verify age first. |
| 170001009 | The product belongs to unsupported category. |
| 170001010 | The commission plan gets failed or rejected. |
| 170001011 | The product doesn't exist. |
| 170001012 | The product is not available. |
| 170001013 | Showcase SPU exceeds limit. |
| 170001014 | Blocked by spam check. |
| 170001015 | Blocked by TikTok Shop risk control. |
| 170001018 | Get creator pay account error. Please verify the pay account first. |
| 170001020 | You have exceeded the frequency to post EC short videos. Please take a rest. |
| 170001024 | cover_timestamp_ms must be a non-negative integer within the video duration. |
| 170001025 | cover_timestamp_ms exceeds the video duration. |
| 170001030 | Creator account banned. Please contact TikTok agent for your account. |
| 170001031 | Creator forbidden to post content. |
| 170001040 | Please use valid video file id to post TikTok Shop short video. |
| 170001050 | Getting errors during video posting workflow. Please try again or contact TikTok. |
| 170001060 | Posting quota exceeded: the creator is under violation control, resulting in a reduced posting limit. |
| 170001061 | Posting quota exceeded: creator is in the newbie period. |
| 170001062 | Posting quota exceeded: platform-level posting limit reached. |
| 170001063 | The product you added only supports auction sales and cannot be used in shoppable videos or Carousels. |


---

## Map Tokopedia to TikTok Shop Product IDs — `GET /affiliate_creator/202606/toko_product_mappers`

Doc: https://partner.tiktokshop.com/docv2/page/map-tokopedia-to-tiktok-shop-product-ids-202606 · cập nhật 2026-10-13 · scope: creator.affiliate_collaboration.read

### Path: /affiliate_creator/202606/toko_product_mappers
### Method: [GET]
### Function Description
Returns mappings from the specified Tokopedia product IDs to the corresponding TikTok Shop product IDs.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
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
| toko_pids | []int | N | [123456] | List of Tokopedia product IDs to map to TikTok Shop product IDs. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202606/toko_product_mappers?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^error | object |  | Error details returned when the product mapping request fails. |
| ^^code | int | 1 | Error code returned when the product mapping request fails. |
| ^^message | string | empty_product_id | error detail information |
| ^product | []object |  | list of product data |
| ^^toko_pid | int | 2177906740 | product id in tokopedia format |
| ^^tts_pid | int | 1735209287836402920 | product id in tts format |
### Response Sample
```json
{"code":0,"data":{"error":{"code":1,"message":"empty_product_id"},"product":[{"toko_pid":2177906740,"tts_pid":1735209287836402920}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Get Tokopedia and TikTok Shop Product ID Mappings — `POST /affiliate_creator/202607/map_toko_product`

Doc: https://partner.tiktokshop.com/docv2/page/get-tokopedia-and-tiktok-shop-product-id-mappings-202607 · cập nhật 2026-10-13 · scope: creator.affiliate.share_link.read

### Path: /affiliate_creator/202607/map_toko_product
### Method: [POST]
### Function Description
Returns mappings from the specified Tokopedia product IDs to the corresponding TikTok Shop product IDs.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
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
| toko_pids | []int | N | [123456] | List of Tokopedia product IDs to map to TikTok Shop product IDs. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202607/map_toko_product?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

**Body**
```json
{"toko_pids":[123456]}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^error | object |  | error information |
| ^^code | int | 1 | The code identifying the product ID mapping error. |
| ^^message | string | empty_product_id | error detail information |
| ^product | []object |  | list of product data |
| ^^toko_pid | int | 2177906740 | product id in tokopedia format |
| ^^tts_pid | int | 1735209287836402920 | product id in tts format |
### Response Sample
```json
{"code":0,"data":{"error":{"code":1,"message":"empty_product_id"},"product":[{"toko_pid":2177906740,"tts_pid":1735209287836402920}]},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |


---

## Post Shoppable Photos — `POST /affiliate_creator/202610/photos`

Doc: https://partner.tiktokshop.com/docv2/page/post-shoppable-photos-202610 · cập nhật 2026-10-28 · scope: creator.video.write

### Path: /affiliate_creator/202610/photos
### Method: [POST]
### Function Description
Use this API to post the shoppable photos with uris and metadata.

---

### Common Parameters
For common parameters, refer to [How to call TikTok Shop APIs - Common Parameters](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Properties  | Location  | Type  | Require  | Sample  | Properties description  |
| --- | --- | --- | --- | --- | --- |
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
| photos_info | []object | Y |  | Photo Info Metadata |
| ^photo_file_uris | string | Y | tos-useast5-i-photomode-tx/owBwaPnAIiaYg4Ck6aNcAmLkBA14n8QQQGEgi | Photo file uris, not a file upload. Use [Upload Shoppable Photo File] to upload the image and obtain the photo_file_uri, then pass that URI in this field |
| music_id | string | N | 7577090708998212365 | Music ID |
| title | string | N | Post title | Post title:The maximum length is 5000 in UTF-16 runes. If not specified, the ticket post will not have any captions. - You can add relevant hashtags to increase discoverability. The format is simply # followed by the topic name. Multiple hashtags are supported,e.g.,#humor#BFCM |
| link_info | object | N |  | Photo anchor and linking metadata |
| ^post_type | string | Y | 1 | 1-LINK_TO_PRODUCT, 2-LINK_TO_SHOP, 3-LINK_TO_ONE_PIC_ONE_PRODUCT |
| ^shop_info | object | N |  | Shop Info |
| ^^shop_id | string | N | 7494831143334152261 | Shop ID |
| ^^group_type | string | N | 1 | 1 for shop_home_page, 2 for category, 3 for collection |
| ^^group_id | string | N | 6 | Category ID/Collection ID. Use [Get Shop Category And Collection] to retrieve a valid category_id or collection_id, then set it in this field |
| ^links | []object | N |  | Photo Anchor List |
| ^^product_id | string | N | 74998589993939330 | Product ID |
| ^^link_title | string | N | product A | Photo Anchor Title:The title to be shown on the product anchor. Anchor title should be shorter than 30 characters |
| is_ai_generated | bool | N | false | Field to indicate whether the content was AI generated. Marking this field as true will display a tag indicating this post as an AI generated post. |
### Request Sample
**Query**
```Plain Text
https://open-api.tiktokglobalshop.com/affiliate_creator/202610/photos?app_key=123abc&sign=5361235029d141222525e303d742f9e38aea052d10896d3197ab9d6233730b8c&timestamp=1625484268
```

**Body**
```json
{"photos_info":[{"photo_file_uris":"tos-useast5-i-photomode-tx/owBwaPnAIiaYg4Ck6aNcAmLkBA14n8QQQGEgi"}],"music_id":"7577090708998212365","title":"Post title","link_info":{"post_type":"1","shop_info":{"shop_id":"7494831143334152261","group_type":"1","group_id":"6"},"links":[{"product_id":"74998589993939330","link_title":"product A"}]},"is_ai_generated":false}
```

### Response Parameters
| Properties  | Type  | Sample  | Properties description  |
| --- | --- | --- | --- |
| code | int | 0 | The success or failure status code returned in API response. |
| message | string | Success | The success or failure messages returned in API response. Reasons of failure will be described in the message. |
| request_id | string | 202203070749000101890810281E8C70B7 | Request log |
| data | object |  | Specific return information |
| ^photo | object |  | Post shoppable photos response |
| ^^photo_post_id | string | 34234234234324342 | Photo post ID |
| ^quota | string | 3/day | Content posting quota for the creator. Returned on successful publish; included in the error message on failure; omitted if no quota restriction applies. |
### Response Sample
```json
{"code":0,"data":{"photo":{"photo_post_id":"34234234234324342"},"quota":"3/day"},"message":"Success","request_id":"202203070749000101890810281E8C70B7"}
```

### Error Code
For common error codes, refer to [How to call TikTok Shop APIs - Common Error Code](https://partner.tiktokshop.com/docv2/page/64f199679495ef0281851ee5#Back%20To%20Top)
| Code  | Message  |
| --- | --- |
| 16011007 | Product link title should be no longer than 30 characters. |
| 16011009 | Product link title contains offensive language. |
| 16011069 | Product link title contains punctuation or emoji. |
| 38007001 | System Error |
| 36009003 | Internal error. Please try again. If the issue persists after multiple attempts, please contact platform support. |
| 170001002 | Creator TikTok Shop permission check failed. |
| 170001003 | Creator Tiktok Shop permission temporarily banned. |
| 170001004 | Creator TikTok Shop permission is permanently banned. |
| 170001005 | Creator terms of service not signed. Please contact TikTok for more details. |
| 170001006 | GKA terms not signed. Please try again after signing GKA term. |
| 170001007 | Creator did not sign the EU data share agreement. |
| 170001008 | Creator Age verification failed. Please verify age first. |
| 170001009 | The product belongs to unsupported category. |
| 170001010 | The commission plan gets failed or rejected. |
| 170001011 | The product doesn't exist. |
| 170001012 | The product is not available. |
| 170001013 | Showcase SPU exceeds limit. |
| 170001014 | Blocked by spam check. |
| 170001015 | Blocked by TikTok Shop risk control. |
| 170001018 | Get creator pay account error. Please verify the pay account first. |
| 170001020 | You have exceeded the frequency to post EC short videos. Please take a rest. |
| 170001030 | Creator account banned. Please contact TikTok agent for your account. |
| 170001031 | Creator forbidden to post content. |
| 170001040 | Please use valid video file id to post TikTok Shop short video. |
| 170001050 | Getting errors during video posting workflow. Please try again or contact TikTok. |
| 170001060 | Posting quota exceeded: the creator is under violation control, resulting in a reduced posting limit. |
| 170001061 | Posting quota exceeded: creator is in the newbie period. |
| 170001062 | Posting quota exceeded: platform-level posting limit reached. |
| 170001063 | The product you added only supports auction sales and cannot be used in shoppable videos or Carousels. |

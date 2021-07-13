# 簡易社群電商銷售系統

## 系統規格列點描述
- [ ] 此電商系統含 Shop (商店)、Manager (商店管理員)、Product (商品)、Order (訂單) 等基本資料模型，並提供 FB Chatbot 供 Buyer 訂購。
- [x] 請先於 FB 上建立 FB App，供後續登入以及 Chatbot 設定使用。
- [x] 網站使用者可以 Facebook OAuth 授權登入與註冊成為 Manager (可以 Devise、OmniAuth 等套件完成)，並於 Manager 註冊後自動為其建立所屬 Shop
- [x] Manager 可以在 Shop 中建立、編輯與刪除多筆 Product，Product 的資訊包括 商品名稱、商品說明、商品價格、商品圖片(連結)
- [ ] Manager 可於登入時，透過調整的 Facebook OAuth 授權設定，授權讓 FB App 取得後續 Chatbot 所需權限
- [x] Manager 可以在 Shop 中指定任意粉絲團 ID，連結 FB App 為所指粉絲團提供 Chatbot 功能。
- [x] 任意用戶可以在與前述粉絲團對話時，得到 Chatbot 回應，Chatbot 以 Carousel 方式顯示商品列表，並顯示確認訂單的按鈕。
- [ ] 任意用戶可以點擊確認訂單按鈕，於 Shop 中建立 Order，Order 的資訊包括 所屬關聯 Product、買家名稱 (From FB)、建立日期等。
- [ ] Manager 可以在 Shop 中瀏覽由用戶所建立之所有 Order
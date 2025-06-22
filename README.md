# To The Abyss

這是一款由 Godot Engine 4.4.1 製作的 2D idle 挖掘遊戲，支援手機、桌機與 Web 平台。玩家將一路向下打穿深淵牆壁，解鎖更強的技能與資源生成方式。

🔗 遊戲試玩連結（Itch.io）  
👉 [https://swear01.itch.io/to-the-abyss](https://swear01.itch.io/to-the-abyss)

---

## 🧩 下載需求與套件

本專案使用了來自 Godot Asset Library 的資源：

- **Kenney Particle Pack**  
  Asset ID：**783**  
  用途：提供粒子效果（牆壁破壞時的碎石特效）

安裝方式：
1. 打開 Godot Engine 編輯器
2. 進入「Asset Library」
3. 搜尋 `Kenney Particle Pack` 或輸入 Asset ID `783`
4. 點選下載並匯入到本專案中

---

## 🗂️ 專案資料夾結構

| 資料夾名稱 | 用途說明 |
|------------|----------|
| `addons/`     | 第三方插件（包含 Kenney 粒子包） |
| `assets/`     | 圖像、音效等外部素材 |
| `build/`      | 匯出用的設定與產出資料夾 |
| `config/`     | 設定檔、關卡參數等 |
| `effects/`    | 特效場景或資源（例如粒子） |
| `fonts/`      | 自定義字型 |
| `media/`      | 宣傳媒體素材（影片、預覽圖） |
| `scenes/`     | 所有 Godot 場景檔案（如 UI、遊戲主場景） |
| `shaders/`    | 自定義 shader |
| `src/`        | GDScript 原始碼（遊戲邏輯） |
| `themes/`     | 顏色主題設定與樣式 |

---

## 🎮 遊戲玩法概要

- 點擊牆壁造成傷害，逐層向下突破
- 解鎖空位後可產出黃金，用於購買礦工
- 礦工會自動挖掘，並在一定時間後死亡
- 收集 `稿元` 可召喚自動生產礦工的「海濤法師」
- 每達成一定深度，可選擇飛昇進入下一圈（重置進度、擴大遊戲寬度）

---

## 📱 支援平台

- 📱 手機（Web 版可直接遊玩）
- 💻 桌上型電腦
- 🌐 瀏覽器（HTML5）

---

## 📜 授權與使用

- 本遊戲代碼與美術資源僅供學術交流與展示使用
- Kenney Particle Pack 使用 CC0 授權，請遵守原創者授權條款（可商用）

---

🎉 感謝遊玩與支持！更多更新內容請關注 Itch.io 網頁！

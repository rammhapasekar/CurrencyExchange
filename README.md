# 💱 CurrencyExchange-MVI

A modern SwiftUI application demonstrating currency conversion between user’s local currency and a selected currency using a clean **Model-View-Intent (MVI)** architecture, powered by **Combine** and **AsyncImage**, with local caching and full test coverage.

<img width="117" height="255" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-09-09 at 16 13 43" src="https://github.com/user-attachments/assets/d91190e0-c825-4af7-aace-5ad13ff87268" />


---

## ✨ Features

- 🔄 **Real-time exchange rate fetching** via [ExchangeRate-API](https://www.exchangerate-api.com/)
- 🌍 **Base currency auto-detected** from user's locale
- 🌐 **Browse or search** from a list of all countries/currencies
- 🏁 **Country flags** displayed using embedded base64 strings or downloaded via URL
- 📦 **Local cache** for flag images using `NSCache`
- 🔎 **Search filter** for currencies by country or name
- 💡 **Modern MVI pattern** with `Store`, `State`, `Action`, `Reducer`
- 🧪 **Unit and UI test coverage** using `XCTest` and `XCUITest`
- 📱 **iOS 16+** with support for `.navigationLink` styled `Picker` for a native experience

---

## 🛠️ Technologies

- Swift 5.7+
- SwiftUI
- Combine
- AsyncImage
- XCTest / XCUITest
- ExchangeRate-API

---

## 🧩 Architecture

### 🧠 Model-View-Intent (MVI)

## 🙌 Acknowledgements

- ExchangeRate-API for real-time exchange rates
- CountryFlags for country flag references

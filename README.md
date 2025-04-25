# Flickr-Image

# 📸 Flickr Image Search App

A SwiftUI-based iOS application that fetches public images from the Flickr Public Feed API using user-defined search tags. Built using a protocol-oriented MVVM architecture, Combine for data binding, and async/await for efficient networking. The app provides a clean UI with adaptive layouts for both portrait and landscape orientations on iPhone and iPad.

## 🔑 Key Features

- 🔍 Live search with real-time updates
- 🖼️ LazyVGrid layout for displaying fetched images
- 📄 Detail view with full-size image, metadata, and link
- 📤 Share image and metadata using system share sheet
- 🧠 Protocol-oriented design with dependency injection
- ⚙️ Combine + debounce for smooth search experience
- 💡 SwiftLint integrated for code quality
- 🌗 Light and dark mode support
- 🧪 Unit tested ViewModel using XCTest

## 🚀 Live Preview

![Image1](https://github.com/user-attachments/assets/58ba7f21-20c5-475e-9f7c-002354fbaff6)
![image2](https://github.com/user-attachments/assets/f4ced34d-b000-494d-a20a-c9ac95cca6a8)
![cat](https://github.com/user-attachments/assets/1ad26ac1-c165-4034-bf05-9e97cf94eb36)


## 🧱 Project Structure

### 📡 Networking
| Component | Description |
|----------|-------------|
| `FlickrServiceProtocol` | Defines API contract for image fetching |
| `NetworkService` | Implements `URLSession` + Combine |
| `FlickrImageModel.swift` | Codable model mapping Flickr's JSON response |

### 🧠 ViewModel
| Component | Description |
|----------|-------------|
| `FlickrImageViewModel` | Handles search logic, API calls, state management |
| `searchImages(tags:)` | Initiates API call with debounced input |
| `observeSearchText()` | Uses Combine’s debounce for live search |

### 🖼️ UI Views
| View | Description |
|------|-------------|
| `ContentView.swift` | Hosts the search bar and grid |
| `ImageGridView.swift` | Displays results in 2-column responsive grid |
| `ImageDetailView.swift` | Full image preview, metadata, and share button |
| `ImageCardView.swift` | Image tile with corner radius and clipping |

---

## 🧪 Testing Plan

| Layer | Test Coverage |
|-------|---------------|
| ✅ ViewModel | Verifies mock image fetch, error handling |
| ✅ Model Decoding | Tests `FlickrItem` decoding |
| ✅ UI Tests | Basic interaction tests using XCTest/XCUITest |

---

## 📲 How to Run

1. Clone the repo:
   ```bash
   git clone https://github.com/Dhenu97/Flickr-Image.git
   ```
2. Open the project in **Xcode 15+**
3. Run the project on any iOS simulator or device (iOS 15+)

---

## 🧪 How to Run Tests

1. In Xcode, select `FlickrImage` scheme
2. Run all tests with `Cmd + U` or via `Product > Test`

---

## 📦 Tech Stack

- ✅ Swift 5.9
- ✅ SwiftUI
- ✅ Combine
- ✅ MVVM
- ✅ Dependency Injection
- ✅ URLSession + async/await
- ✅ XCTest + SwiftLint
- ✅ Xcode 15+

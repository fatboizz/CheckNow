<div align="center">

# ⏱️ CheckNow - Smart Task & Schedule Manager

[![Flutter CI](https://github.com/checknow/checknow/actions/workflows/ci.yml/badge.svg)](https://github.com/checknow/checknow/actions)
[![Flutter Version](https://img.shields.io/badge/Flutter-%3E%3D3.19.4-02569B?logo=flutter)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-%3E%3D3.3.2-0175C2?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Architecture: Clean Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture%20%2B%20GetX-green.svg)](https://pub.dev/packages/get)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Windows-lightgrey.svg)]()

<p align="center">
  <b>Ứng dụng quản lý thời gian biểu, nhắc nhở công việc và theo dõi thói quen hàng ngày được xây dựng trên nền tảng Flutter và GetX theo chuẩn Clean Architecture.</b>
</p>

</div>

---

## 📌 Mục Lục

- [Giới Thiệu](#-giới-thiệu)
- [Tính Năng Nổi Bật](#-tính-năng-nổi-bật)
- [Tech Stack & Thư Viện](#-tech-stack--thư-viện)
- [Kiến Trúc Dự Án (Clean Architecture)](#-kiến-trúc-dự-án-clean-architecture)
- [Cây Thư Mục Dự Án](#-cây-thư-mục-dự-án)
- [Sơ Đồ Dữ Liệu & Luồng Hoạt Động](#-sơ-đồ-dữ-liệu--luồng-hoạt-động)
- [Yêu Cầu Môi Trường (Prerequisites)](#-yêu-cầu-môi-trường-prerequisites)
- [Hướng Dẫn Cài Đặt & Chạy Ứng Dụng](#-hướng-dẫn-cài-đặt--chạy-ứng-dụng)
- [Kiểm Thử (Testing) & CI/CD](#-kiểm-thử-testing--cicd)
- [Bảo Mật & Quản Lý Môi Trường](#-bảo-mật--quản-lý-môi-trường)
- [Đóng Góp (Contributing)](#-đóng-góp-contributing)
- [Giấy Phép (License)](#-giấy-phép-license)

---

## 📖 Giới Thiệu

**CheckNow** là giải pháp hỗ trợ người dùng theo dõi và tổ chức các nhiệm vụ hàng ngày một cách khoa học. Ứng dụng cung cấp thanh lịch trực quan (DatePicker Timeline), hệ thống nhắc nhở thông báo chuẩn xác qua `flutter_local_notifications`, tự động reset trạng thái các công việc lặp lại vào lúc nửa đêm, cùng khả năng chuyển đổi giao diện Sáng / Tối (Light & Dark Mode) mượt mà.

---

## ✨ Tính Năng Nổi Bật

- 📅 **Lịch Trình Trực Quan (Horizontal DatePicker):** Dễ dàng lướt và lọc nhiệm vụ theo từng ngày trong tuần/tháng với hỗ trợ tiếng Việt đầy đủ (`vi_VN`).
- 🔔 **Hệ Thống Thông Báo Đa Tầng:**
  - Thông báo khi bắt đầu nhiệm vụ (Start Time).
  - Nhắc nhở định kỳ (Reminder trước 1, 5, 10, 15, 20 phút).
  - Thông báo khi hết hạn nhiệm vụ (End Time).
- 🔁 **Lập Lịch Lặp Lại Thông Minh (Recurring Engine):** Hỗ trợ lập lịch `Không`, `Mỗi Ngày`, `Mỗi Tuần`, `Mỗi Tháng`. Tự động tính toán chu kỳ và số ngày trong tháng (hỗ trợ năm nhuận chính xác).
- 🌙 **Giao Diện Đa Chế Độ (Theme Toggle):** Chuyển đổi Dark / Light mode tức thì kèm thông báo và tự động lưu trạng thái bằng `GetStorage`.
- 💾 **Lưu Trữ Cục Bộ An Toàn (Offline-First):** Sử dụng cơ sở dữ liệu SQLite cục bộ, bảo mật dữ liệu người dùng mà không phụ thuộc kết nối Internet liên tục.
- 🎨 **Hiệu Ứng Chuyển Động Sang Trọng:** Tích hợp `flutter_staggered_animations` tạo cảm giác chuyển động mượt mà khi hiển thị danh sách công việc.

---

## 🛠️ Tech Stack & Thư Viện

| Thành Phần | Công Nghệ / Thư Viện | Phiên Bản | Mục Đích |
| :--- | :--- | :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev) | `^3.19.4` | Xây dựng UI đa nền tảng |
| **Language** | [Dart](https://dart.dev) | `>=3.3.2 <4.0.0` | Ngôn ngữ phát triển ứng dụng |
| **State Management** | [GetX](https://pub.dev/packages/get) | `^4.6.6` | Quản lý state reactive và navigation |
| **Local Database** | [sqflite](https://pub.dev/packages/sqflite) | `^2.3.3` | Lưu trữ dữ liệu SQLite cục bộ |
| **Key-Value Cache** | [get_storage](https://pub.dev/packages/get_storage) | `^2.1.1` | Lưu cấu hình giao diện & user settings |
| **Notifications** | [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) | `^9.9.1` | Hệ thống thông báo đẩy cục bộ |
| **Timezone Support** | [timezone](https://pub.dev/packages/timezone) & [flutter_timezone](https://pub.dev/packages/flutter_timezone) | `1.0.8` | Xử lý múi giờ định vị chính xác |
| **Date & Calendar** | [date_picker_timeline](https://pub.dev/packages/date_picker_timeline) & [intl](https://pub.dev/packages/intl) | `^1.2.6` / `^0.19.0` | Thanh chọn ngày ngang & định dạng thời gian |
| **Typography** | [google_fonts](https://pub.dev/packages/google_fonts) | `^6.2.1` | Font chữ Lato hiện đại |
| **Animations** | [flutter_staggered_animations](https://pub.dev/packages/flutter_staggered_animations) | `^1.1.1` | Hiệu ứng xuất hiện danh sách |
| **Cloud Services** | [firebase_core](https://pub.dev/packages/firebase_core) | `^2.31.1` | Nền tảng kết nối Firebase |

---

## 🏗️ Kiến Trúc Dự Án (Clean Architecture)

Mã nguồn được tổ chức theo tiêu chuẩn **Clean Architecture** kết hợp phân rã theo tính năng (**Feature-Based Modularization**):

```
┌────────────────────────────────────────────────────────┐
│                   Presentation Layer                   │
│   (Modules: Home, Add Task, Notification + Shared UI)   │
└───────────────────────────┬────────────────────────────┘
                            │ (Uses)
┌───────────────────────────▼────────────────────────────┐
│                    Business Logic                      │
│             (GetX Controllers & Schedulers)            │
└───────────────────────────┬────────────────────────────┘
                            │ (Calls)
┌───────────────────────────▼────────────────────────────┐
│                   Data / Domain Layer                  │
│     (TaskRepository Interface & Task Model Entity)     │
└───────────────────────────┬────────────────────────────┘
                            │ (Persists through)
┌───────────────────────────▼────────────────────────────┐
│                   Persistence Layer                    │
│             (SQLite DBProvider & GetStorage)           │
└────────────────────────────────────────────────────────┘
```

---

## 📁 Cây Thư Mục Dự Án

```text
checknow/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md             # Template báo cáo lỗi GitHub
│   │   └── feature_request.md        # Template đề xuất tính năng GitHub
│   └── workflows/
│       └── ci.yml                    # Pipeline CI GitHub Actions (Lint, Test, Analyze)
├── android/                          # Native Android platform config
│   ├── app/
│   │   └── google-services.json.example # Mẫu cấu hình Firebase Android an toàn
│   └── local.properties.example     # Mẫu biến môi trường Android SDK local
├── assets/
│   └── images/
│       └── IMG_2958.JPG              # Default avatar image
├── ios/                              # Native iOS platform config
├── lib/
│   ├── core/                         # Cross-cutting concerns
│   │   ├── constants/
│   │   │   ├── app_assets.dart       # Đường dẫn tài nguyên tĩnh
│   │   │   ├── app_colors.dart       # Bảng mã màu chuẩn
│   │   │   └── app_constants.dart    # Biến số cấu hình toàn app
│   │   ├── services/
│   │   │   ├── notification_service.dart # Quản lý thông báo cục bộ
│   │   │   └── theme_service.dart    # Quản lý Light/Dark mode
│   │   ├── theme/
│   │   │   ├── app_theme.dart        # Cấu hình ThemeData Light & Dark
│   │   │   └── text_styles.dart      # Typographies & TextStyles
│   │   └── utils/
│   │       └── date_time_utils.dart  # Thuật toán tính ngày & năm nhuận
│   ├── data/                         # Data access & persistence
│   │   ├── models/
│   │   │   └── task_model.dart       # Thực thể Task (JSON/DB serialization)
│   │   ├── providers/
│   │   │   └── db_provider.dart      # SQLite DBHelper provider
│   │   └── repositories/
│   │       └── task_repository.dart  # Repository Pattern interface & impl
│   ├── modules/                      # Feature modules
│   │   ├── add_task/
│   │   │   └── views/
│   │   │       └── add_task_page.dart # Màn hình tạo nhiệm vụ mới
│   │   ├── home/
│   │   │   ├── controllers/
│   │   │   │   ├── task_controller.dart      # GetX state controller
│   │   │   │   └── task_reset_scheduler.dart # Bộ lập lịch tự động nửa đêm
│   │   │   ├── views/
│   │   │   │   └── home_page.dart            # Màn hình chính
│   │   │   └── widgets/
│   │   │       └── task_tile.dart            # Thẻ preview nhiệm vụ
│   │   └── notification/
│   │       └── views/
│   │           └── notified_page.dart        # Màn hình chi tiết thông báo
│   ├── shared/
│   │   └── widgets/
│   │       ├── custom_button.dart            # Reusable button widget
│   │       └── custom_input_field.dart       # Reusable input field widget
│   └── main.dart                     # Entry point khởi tạo app
├── test/
│   └── widget_test.dart              # Bộ Unit & Widget test tự động
├── .editorconfig                     # Chuẩn hóa quy cách code IDE
├── .env.example                      # Template biến môi trường
├── .gitignore                        # Git ignore rules đầy đủ
├── CHANGELOG.md                      # Lịch sử thay đổi các phiên bản
├── CONTRIBUTING.md                   # Hướng dẫn đóng góp mã nguồn
├── LICENSE                           # Giấy phép MIT
├── analysis_options.yaml             # Cấu hình static code analysis linter
└── pubspec.yaml                      # Khai báo dependencies & asset
```

---

## 🗄️ Sơ Đồ Dữ Liệu & Luồng Hoạt Động

### 1. Bảng Dữ Liệu SQLite (`tasks1`)

| Cột (Field) | Kiểu Dữ Liệu | Ràng Buộc | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | `PRIMARY KEY AUTOINCREMENT` | Định danh duy nhất của nhiệm vụ |
| `title` | `TEXT` | `NOT NULL` | Tiêu đề nhiệm vụ |
| `note` | `TEXT` | - | Nội dung ghi chú chi tiết |
| `date` | `TEXT` | - | Ngày hẹn thực hiện (định dạng `M/d/yyyy`) |
| `startTime`| `TEXT` | - | Thời gian bắt đầu (ví dụ: `08:30 AM`) |
| `endTime` | `TEXT` | - | Thời gian kết thúc (ví dụ: `10:00 AM`) |
| `remind` | `INTEGER`| - | Số phút nhắc trước (`1, 5, 10, 15, 20`) |
| `repeat` | `TEXT` | - | Tần suất lặp (`Không`, `Mỗi Ngày`, `Mỗi Tuần`, `Mỗi Tháng`) |
| `color` | `INTEGER`| - | Mã màu hiển thị (`0: Xanh dương`, `1: Hồng`, `2: Vàng`) |
| `isCompleted`| `INTEGER`| `DEFAULT 0` | Trạng thái (`0: Phải làm`, `1: Đã làm`) |

### 2. Luồng Hoạt Động Midnight Reset (Recurring Tasks)

```
[Khởi động ứng dụng]
        │
        ▼
[TaskResetScheduler.scheduleDailyReset()]
        │
        ├─► Tính Duration đến 00:00:00 ngày hôm sau
        │
        ▼
[Khi đồng hồ điểm 00:00:00]
        │
        ├─► DBProvider.updateIsCompletedToZero() (reset repeat = 'Mỗi Ngày')
        ├─► TaskController.getTask() (cập nhật lại danh sách trên UI)
        └─► Lên lịch hẹn giờ lặp lại cho nửa đêm kế tiếp
```

---

## 💻 Yêu Cầu Môi Trường (Prerequisites)

- **Flutter SDK:** Phiên bản `>= 3.19.4` (kênh `stable`).
- **Dart SDK:** Phiên bản `>= 3.3.2 < 4.0.0`.
- **Java Development Kit (JDK):** JDK 17 hoặc 21 (dành cho Android Gradle build).
- **Android Studio / VS Code:** Cài đặt kèm Flutter & Dart extensions.
- **Xcode:** (Nếu phát triển cho hệ điều hành iOS / macOS).

---

## 🚀 Hướng Dẫn Cài Đặt & Chạy Ứng Dụng

### Bước 1: Clone Repository
```bash
git clone https://github.com/<your-username>/checknow.git
cd checknow
```

### Bước 2: Thiết Lập Biến Môi Trường & File Cấu Hình
1. Tạo file `.env` từ file mẫu:
   ```bash
   cp .env.example .env
   ```
2. (Tùy chọn cho Android) Nếu sử dụng dịch vụ Firebase, đặt file cấu hình `google-services.json` vào thư mục `android/app/`:
   ```bash
   cp android/app/google-services.json.example android/app/google-services.json
   # Sau đó điền thông tin Firebase Project của bạn
   ```
3. Tạo file `local.properties` cho Android (trỏ đến SDK cục bộ của bạn):
   ```bash
   cp android/local.properties.example android/local.properties
   ```

### Bước 3: Cài Đặt Dependencies
```bash
flutter pub get
```

### Bước 4: Kiểm Tra Thiết Bị & Khởi Chạy
Kiểm tra các thiết bị hoặc máy ảo đang kết nối:
```bash
flutter devices
```

Khởi chạy ứng dụng:
```bash
# Chạy ở chế độ Debug
flutter run

# Chạy cụ thể trên một thiết bị
flutter run -d <device-id>
```

---

## 🧪 Kiểm Thử (Testing) & CI/CD

Dự án đi kèm bộ kiểm thử tự động tại thư mục `test/`:

```bash
# Chạy toàn bộ Unit & Widget Tests
flutter test

# Kiểm tra cú pháp và tuân thủ Coding Conventions
flutter analyze

# Kiểm tra định dạng mã nguồn theo chuẩn Dart
dart format --output=none --set-exit-if-changed .
```

Hệ thống **GitHub Actions CI** (`.github/workflows/ci.yml`) sẽ tự động kích hoạt trên mỗi commit hoặc Pull Request để đảm bảo toàn bộ mã nguồn luôn đạt chuẩn trước khi merge.

---

## 🔒 Bảo Mật & Quản Lý Môi Trường

> [!IMPORTANT]
> **Cam Kết Bảo Mật Tuyệt Đối:**
> - Các file nhạy cảm như `.env`, `google-services.json`, `local.properties`, và các file chứng chỉ ký app (`*.keystore`, `*.jks`) đã được thiết lập nghiêm ngặt trong `.gitignore`.
> - Tuyệt đối không commit credentials hoặc API keys bí mật lên bất kỳ public branch nào. Luôn sử dụng file `.example` khi muốn chia sẻ cấu trúc mẫu.

---

## 🤝 Đóng Góp (Contributing)

Mọi ý kiến đóng góp, báo cáo lỗi hoặc đề xuất tính năng mới đều được hoan nghênh! Hãy đọc kỹ tài liệu [CONTRIBUTING.md](CONTRIBUTING.md) để nắm rõ quy trình gửi Pull Request và quy chuẩn Conventional Commits.

---

## 📄 Giấy Phép (License)

Dự án được phân phối dưới giấy phép [MIT License](LICENSE). Bản quyền © 2026 CheckNow Contributors.

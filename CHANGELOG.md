# Changelog

Tất cả các thay đổi đáng chú ý của dự án **CheckNow** sẽ được ghi chép tại file này.
Định dạng dựa trên [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) và tuân thủ [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2026-11-08

### ✨ Added
- **Clean Architecture & Feature-Based Modularization**:
  - `lib/core/`: Quản lý tập trung `app_colors`, `app_constants`, `app_assets`, `app_theme`, `text_styles`, `date_time_utils`, `notification_service`, `theme_service`.
  - `lib/data/`: Tách biệt `Task` model, `DBProvider` (SQLite), và `TaskRepository` theo mô hình Repository Pattern.
  - `lib/modules/`: Nhóm logic theo từng tính năng chuyên biệt (`home`, `add_task`, `notification`).
  - `lib/shared/`: Xây dựng các reusable UI components (`CustomButton`, `CustomInputField`).
- **DevOps & GitHub Standardization**:
  - Continuous Integration: Thiết lập GitHub Actions workflow (`.github/workflows/ci.yml`) tự động lint, analyze và chạy unit tests.
  - Issue Templates: Thêm mẫu báo cáo lỗi (`bug_report.md`) và đề xuất tính năng (`feature_request.md`).
  - Configuration & Environment: Tạo `.env.example`, `google-services.json.example`, `local.properties.example`, `.editorconfig`.
  - Open Source Documentation: Bổ sung `README.md` chuyên nghiệp showcase, `LICENSE` (MIT) và `CONTRIBUTING.md`.
- **Unit & Smoke Tests**:
  - Bổ sung bộ kiểm thử tự động tại `test/widget_test.dart` bao phủ serialization của Task Model, thuật toán năm nhuận / tính số ngày trong tháng, logic lập lịch lặp lại và bảng màu sắc.

### 🛡️ Security
- **Bảo mật & Cô lập Credentials**:
  - Cô lập file nhạy cảm `google-services.json` (chứa API key và Project ID) và `local.properties` (chứa đường dẫn tuyệt đối của máy cá nhân).
  - Cập nhật `.gitignore` toàn diện, cam kết tuyệt đối không để lộ thông tin bí mật hay credentials khi công khai mã nguồn.

### 🧹 Removed & Cleaned
- Dọn dẹp hơn 1.4 GB file rác, artifact build và cache: `.gradle/`, `build/`, `.dart_tool/`, `windows/flutter/ephemeral/`, `.flutter-plugins*`.
- Loại bỏ thư mục lồng nhau thừa `checknow1/checknow1`, đưa toàn bộ dự án về chuẩn root repository.
- Xóa các file mã nguồn cũ phân mảnh, sửa lỗi typo tên file (`task_title.dart` -> `task_tile.dart`, `add_task_bar.dart` -> `add_task_page.dart`).
- Khắc phục lỗi circular import trong theme và thay thế các thuộc tính UI deprecated (`colorScheme.background` -> `colorScheme.surface`).


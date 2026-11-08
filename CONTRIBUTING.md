# Hướng Dẫn Đóng Góp (Contributing Guidelines)

Cảm ơn bạn đã quan tâm đến việc đóng góp cho dự án **CheckNow**! 🎉

CheckNow là một dự án mã nguồn mở và chúng tôi rất hoan nghênh mọi đóng góp: từ báo cáo lỗi, đề xuất tính năng, cải thiện tài liệu đến gửi Pull Request (PR).

---

## 🧭 Quy trình làm việc (Git Workflow)

Chúng tôi áp dụng mô hình **Git Feature Branching**:

1. **Fork** repository về tài khoản cá nhân của bạn trên GitHub.
2. **Clone** repository đã fork về máy:
   ```bash
   git clone https://github.com/<your-username>/checknow.git
   cd checknow
   ```
3. Tạo nhánh tính năng mới từ nhánh `main`:
   ```bash
   git checkout -b feature/ten-tinh-nang-moi
   # hoặc đối với sửa lỗi:
   git checkout -b fix/ten-loi-can-sua
   ```
4. Thực hiện các thay đổi và tuân thủ chuẩn code (xem mục bên dưới).
5. Chạy kiểm tra định dạng và unit test:
   ```bash
   dart format --output=none --set-exit-if-changed .
   flutter analyze
   flutter test
   ```
6. Commit thay đổi tuân theo chuẩn **Conventional Commits**:
   ```bash
   git commit -m "feat(home): add filter by task completion status"
   # hoặc:
   git commit -m "fix(scheduler): prevent timer duplication on midnight"
   ```
7. Push nhánh lên GitHub và tạo **Pull Request** vào nhánh `main`.

---

## 📐 Chuẩn Code & Kiến Trúc (Code Standards)

CheckNow áp dụng **Clean Architecture** kết hợp mô hình **Feature-Based** với GetX:

- **`lib/core/`**: Chứa constants, theme, utility functions và service hệ thống.
- **`lib/data/`**: Chứa data models, database provider (SQLite), và repositories.
- **`lib/modules/`**: Phân chia theo từng feature (Home, Add Task, Notification). Mỗi feature gồm controllers, views và feature-widgets.
- **`lib/shared/`**: Chứa các widget tái sử dụng dùng chung cho toàn bộ app.

### Quy tắc quan trọng:
- Đặt tên file theo chuẩn `kebab-case` hoặc `snake_case` (ví dụ: `custom_button.dart`, `task_tile.dart`).
- Tên class theo chuẩn `PascalCase` (ví dụ: `TaskController`, `TaskTile`).
- Biến và phương thức theo chuẩn `camelCase`.
- Luôn kiểm tra null safety và tránh gọi trực tiếp Database provider từ UI (hãy đi qua Controller và Repository).
- Không commit các file chứa secret, credentials (`.env`, `google-services.json`, keystore...).

---

## 🧪 Kiểm Thử (Testing)

Trước khi gửi PR, hãy đảm bảo:
- Tất cả unit test hiện tại đều PASS:
  ```bash
  flutter test
  ```
- Viết thêm unit test cho các logic mới bổ sung vào `test/`.

---

## 💬 Nhận Trợ Giúp

Nếu bạn có câu hỏi hoặc cần trao đổi thêm, vui lòng tạo một Issue hoặc liên hệ qua kênh thảo luận của dự án.
Cảm ơn sự đóng góp quý báu của bạn!

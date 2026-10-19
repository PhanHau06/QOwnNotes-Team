# Phân công nhiệm vụ nhóm QOwnNotes

## Mục tiêu chung

Tùy biến QOwnNotes v24.12.7 trên Ubuntu 20.04 x86_64, Qt 5.12.8, GCC 9.4;
tích hợp và phát hành gói `.deb`. Mỗi người đọc BUILD.md, build nguồn nền
và làm trên nhánh được giao. Checklist chưa đánh dấu là việc chưa xác nhận xong.

## Người 1 — PhanHau06: môi trường, Git, tích hợp, đóng gói

**Nhánh:** `chore/*`, `docs/*`; PR vào `dev`, phát hành qua PR `dev` vào `main`.

**Đã xác nhận trong phiên làm việc:**

- [x] VM Ubuntu 20.04, SSH từ Windows và bộ công cụ Qt5/GCC.
- [x] Chọn nguồn v24.12.7 và build bản nền thành công (~9,8 MB executable).
- [x] Tạo repository nhóm, main/dev và ba nhánh tính năng.
- [x] Nhập nguồn thành commit ban đầu, giữ thông tin nguồn và giấy phép.
- [x] Build thành công lần dọn CI đầu theo kết quả terminal.

**Cần hoàn tất:**

- [x] Build sạch bản dọn đầy đủ `041e16d`, kiểm tra executable `--version` thành công.
- [ ] Chạy thử GUI và chụp ảnh bản gốc (kiểm tra CLI chưa thay thế bước này).
- [ ] Xác nhận một thành viên khác build được theo BUILD.md.
- [ ] Mời đủ thành viên, xác nhận quyền push và tài khoản của từng người.
- [ ] Bảo vệ main/dev: yêu cầu PR, ít nhất một reviewer, cấm force-push/xóa nhánh.
- [ ] Tạo bảng To do / Doing / Review / Done, họp ngắn mỗi 2–3 ngày.
- [ ] Snapshot/OVA môi trường, loại token và khóa SSH cá nhân trước khi chia sẻ.
- [ ] Review PR nhỏ, giải quyết xung đột, build và chạy thử sau các đợt merge.
- [ ] Thử đóng gói `.deb` sớm; khai báo dependency runtime.
- [ ] Kiểm tra `.deb` cài/gỡ trên Ubuntu sạch, đủ executable/icon/desktop/bản dịch.
- [ ] Ghi quy trình đóng gói, tạo release tag, đính kèm `.deb` và ảnh nghiệm thu.

**Bàn giao:** BUILD.md kiểm chứng, quy trình Git, snapshot/OVA, `.deb`, release.

## Người 2 — bộ đếm từ và thời gian đọc

**Nhánh:** `feature/wordcount`.
**Đọc code:** `src/mainwindow.cpp`, `.h`, `.ui`, `src/dialogs/settingsdialog.*`;
tìm `statusBar`, thay đổi editor và xử lý đổi ghi chú.

- [ ] Build nguồn nền, kiểm tra chức năng đếm sẵn có để không làm trùng.
- [ ] Thống nhất đếm Markdown thô; tách từ theo khoảng trắng, bỏ chuỗi rỗng.
- [ ] Ghi rõ ký tự có tính khoảng trắng không và cách tính Unicode.
- [ ] Hiển thị số từ, ký tự, thời gian đọc trên label riêng ở status bar.
- [ ] Mặc định 200 từ/phút; rỗng: 0 từ; nội dung dưới một phút: `< 1 phút`.
- [ ] Cập nhật khi gõ/đổi ghi chú; debounce 200–300 ms nếu cần.
- [ ] Thêm tùy chọn bật/tắt trong Settings, lưu theo cơ chế Settings của app.
- [ ] Bật/tắt có hiệu lực ngay và giữ trạng thái sau khởi động lại.
- [ ] Bọc chuỗi `tr()`, gửi danh sách chuỗi mới cho Người 4.
- [ ] Kiểm tra rỗng, tiếng Việt, emoji, Markdown, ghi chú rất dài, chuyển ghi chú.
- [ ] PR vào dev: quy tắc đếm, file sửa, lệnh build, bước thử và ảnh.

**Nghiệm thu:** số liệu đúng theo quy tắc, không giật khi gõ, không hỏng status bar cũ,
Settings có hiệu lực và được lưu. Logic mới nằm trong hàm riêng để giảm xung đột.

## Người 3 — tạo ghi chú từ mẫu

**Nhánh:** `feature/template`.
**Đọc code:** `MainWindow::createNewNote`, `on_action_New_note_triggered`
trong `src/mainwindow.cpp`, `src/entities/note.*`, resource `.qrc` nếu thêm mẫu dạng file.

- [ ] Build nền, hiểu luồng tạo/lưu note trước khi sửa.
- [ ] Ba mẫu: Họp, Việc cần làm, Nhật ký.
- [ ] Họp: tiêu đề, ngày, người tham dự, nội dung, việc cần làm.
- [ ] Việc cần làm: checkbox Markdown `- [ ]`.
- [ ] Nhật ký: ngày, tâm trạng, việc đã làm, điều biết ơn.
- [ ] Thay `{{date}}` bằng ngày hiện tại theo định dạng thống nhất.
- [ ] Menu/hộp thoại chọn mẫu; hủy không tạo ghi chú ngoài ý muốn.
- [ ] Giữ hành vi ghi chú thường; logic mẫu trong hàm riêng.
- [ ] Trùng tên không ghi đè; note tạo xong xuất hiện, sửa và mở lại được.
- [ ] Bọc chuỗi bằng `tr()`, gửi Người 4 dịch.
- [ ] Thử từng mẫu, hủy dialog, tên tiếng Việt, trùng tên và ghi chú thường.
- [ ] PR vào dev, kèm ảnh, file sửa và các bước kiểm tra.

**Nghiệm thu:** cả ba mẫu đúng, ngày thay đúng, lưu/mở lại ổn định, chức năng cũ tốt.
Ghim ghi chú là mở rộng; chỉ thay phạm vi template nếu cả nhóm thống nhất trước.

## Người 4 — branding, theme, tiếng Việt

**Nhánh:** `feature/branding`.
**Đọc code:** `icons/`, `src/images/`, `.qrc`, `src/PBE.QOwnNotes.desktop`,
About, Settings, `src/languages/QOwnNotes_vi.ts`.

- [ ] Build nền, ảnh trước, liệt kê nơi hiển thị tên/icon.
- [ ] Chốt tên hiển thị; đổi title, About, desktop entry.
- [ ] Giữ tên class, namespace và đường dẫn cấu hình nội bộ.
- [ ] Thiết kế SVG/PNG, đồng bộ icon app, tray và menu Ubuntu.
- [ ] Có thể dùng `bash icons/generate-icons.sh` (cần librsvg2-bin).
- [ ] Theme sáng/tối, font tiếng Việt; kiểm tra tương phản và chữ bị cắt.
- [ ] Dịch menu/Settings/hộp thoại và chuỗi của Người 2/3.
- [ ] Chạy `lupdate src/QOwnNotes.pro`, kiểm tra diff, dịch `.ts`, chạy `lrelease`.
- [ ] Default tiếng Việt/theme/font chỉ áp dụng cho cấu hình mới, không ghi đè lựa chọn cũ.
- [ ] Kiểm tra lần chạy đầu trên tài khoản/VM thử hoặc cấu hình đã sao lưu.
- [ ] Giữ ghi công trong About, LICENSE và giấy phép thư viện.
- [ ] Kiểm tra `.deb` cùng Người 1, chụp ảnh trước/sau, PR vào dev.

**Nghiệm thu:** tên/icon/theme nhất quán; tiếng Việt đúng, không vỡ layout;
`.qm` được sinh và đóng gói, không commit file sinh ra.

## Phối hợp và lịch triển khai

| Chặng | Người 1 | Người 2 | Người 3 | Người 4 |
|---|---|---|---|---|
| Bắt đầu | Chốt môi trường, quyền Git | Đọc status bar/editor | Đọc luồng tạo note | Khảo sát UI/icon |
| Triển khai | Review nhỏ, thử đóng gói | Logic đếm | Ba mẫu/menu | Branding/theme |
| Tích hợp | Build sau merge | Settings/test | Hoàn thiện/test | Dịch chuỗi/default |
| Nghiệm thu | VM sạch, `.deb`, release | Sửa lỗi | Sửa lỗi | Kiểm tra gói/ảnh |

Người 2/3 cùng sửa mainwindow: tách hàm riêng và báo nhau trước khi chỉnh UI.
Người 4 thống nhất quyền sửa layout với hai bạn; không chỉnh `.ui` song song độc lập.
Mỗi người push nhánh mình, PR chọn base `dev`, ít nhất một người khác review.
Theo CONTRIBUTING.md để cập nhật origin/dev bằng merge, không viết lại lịch sử chung.

## Nghiệm thu toàn nhóm

- [ ] Clone sạch và build theo BUILD.md.
- [ ] Bộ đếm, Settings và ba mẫu hoạt động.
- [ ] Branding, tiếng Việt, theme được áp dụng.
- [ ] Lưu/mở ghi chú và khởi động lại bình thường.
- [ ] `.deb` cài/gỡ trên Ubuntu sạch, đủ dependency runtime.
- [ ] LICENSE/ghi công/bản quyền thư viện được giữ.
- [ ] Release có `.deb`, ảnh và hướng dẫn sử dụng.

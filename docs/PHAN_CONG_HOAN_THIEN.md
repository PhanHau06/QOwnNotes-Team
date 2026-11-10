# Phân công hoàn thiện QOwnNotes Team

**Cập nhật:** 10/11/2026  
**Nhánh tích hợp đã kiểm tra:** `dev`, commit `ceaaa2782`  
**Yêu cầu của giảng viên:** giao diện nghiệm thu bằng tiếng Anh.

## Trạng thái hiện tại

- Các nhánh tính năng đã được gộp vào `dev`.
- Bản tích hợp đã build thành công và mở được trên Ubuntu.
- Bộ đếm đã đạt ca thử cơ bản; bật/tắt hiển thị hoạt động.
- Ba mẫu Meeting, To-do, Journal đã tạo đúng nội dung.
- Đã thử thành công ngày hiện tại, trùng tên Meeting, Cancel, chỉnh sửa tiếng Việt và lưu/mở lại ghi chú từ mẫu.
- About hiển thị tên nhóm và giữ ghi công tác giả gốc.
- Chưa hoàn tất kiểm thử bộ đếm, đóng gói bản cuối và phát hành.
- Chưa xác nhận thay đổi ngôn ngữ mặc định từ tiếng Việt sang tiếng Anh đã được thực hiện trong mã nguồn.

Đây là phân công cho giai đoạn hoàn thiện tiếp theo. Các mục chưa đánh dấu cần có kết quả kiểm tra hoặc bằng chứng trước khi xác nhận xong. Đọc cùng `PHAN_CONG.md` để đối chiếu phạm vi ban đầu; yêu cầu giao diện tiếng Anh trong tài liệu này cập nhật yêu cầu ngôn ngữ nghiệm thu trước đó.

## Người 1 — PhanHau06

### Tích hợp đóng gói và tài liệu

- [ ] Thống nhất với Người 4 ai sửa ngôn ngữ mặc định, xác nhận English cho cấu hình mới.
- [ ] Review và tích hợp các PR hoàn thiện của thành viên.
- [ ] Build lại bản tích hợp sau các thay đổi cuối.
- [ ] Tạo gói `.deb` từ đúng bản build đã kiểm tra, dùng staging riêng.
- [ ] Dùng tên người duy trì `QOwnNotes Team` cho gói, không yêu cầu email cá nhân.
- [ ] Cập nhật version và mô tả gói, bỏ mô tả baseline/preliminary.
- [ ] Kiểm tra cài, chạy và gỡ gói trên Ubuntu sạch; kiểm tra dependency, executable, desktop entry, icon và tài nguyên.
- [ ] Cập nhật README, BUILD, phân công và báo cáo Anh/Việt.
- [ ] Tổng hợp ảnh nghiệm thu và hướng dẫn sử dụng.
- [ ] Xác nhận một thành viên khác build được theo tài liệu.
- [ ] Kiểm tra quyền thành viên và bảo vệ nhánh; hoàn thiện snapshot/OVA nếu vẫn thuộc phạm vi bàn giao.
- [ ] Sau nghiệm thu, tạo PR `dev` vào `main`, tag và release kèm `.deb` và tài liệu.

## Người 2 — Phạm Vũ Ngọc Dương

### Hoàn thiện bộ đếm

Phần lập trình chính đã merge. Tiếp tục kiểm tra và sửa lỗi nếu có:

- [ ] Nội dung rỗng: 0 từ, 0 ký tự, thời gian đọc bằng 0.
- [ ] Tiếng Việt, emoji, dấu cách, tab và xuống dòng.
- [ ] Chuyển ghi chú cập nhật đúng số liệu.
- [ ] 200 từ: khoảng 1 phút ở tốc độ 200 từ/phút; khoảng 4 phút ở tốc độ 50 từ/phút.
- [ ] Bật/tắt và tốc độ đọc được giữ sau khi khởi động lại.
- [ ] Ghi chú dài khoảng 20.000 từ không gây giật rõ rệt khi gõ.
- [ ] Kiểm tra câu chữ tiếng Anh của nhãn, tooltip và Settings.
- [ ] Ghi quy tắc đếm và kết quả thử vào tài liệu.
- [ ] Gửi PR nếu sửa code, kèm ảnh và bước kiểm tra.

## Người 3 — trunghieudn16

### Hoàn thiện mẫu ghi chú

Các ca cơ bản đã đạt trên VM tích hợp: ba mẫu, ngày, trùng tên Meeting, Cancel và lưu/mở lại nội dung.

- [ ] Kiểm tra thêm trùng tên với To-do và Journal.
- [ ] Kiểm tra tạo mẫu khi chuyển thư mục hoặc thư mục con.
- [ ] Kiểm tra câu chữ tiếng Anh trong menu, hộp thoại và nội dung mẫu.
- [ ] Xác nhận ghi chú thường vẫn hoạt động sau khi dùng mẫu.
- [ ] Viết hướng dẫn sử dụng ba mẫu và bổ sung ảnh nghiệm thu.
- [ ] Gửi PR nếu phát hiện lỗi hoặc cần sửa nội dung.

## Người 4 — Nhu Hoang

### Hoàn thiện giao diện tiếng Anh và nhận diện

Tên ứng dụng, màu nhấn và About đã merge. About đã được kiểm tra trên VM.

- [ ] Phối hợp Người 1 đặt English làm ngôn ngữ mặc định cho cấu hình mới; tránh sửa trùng.
- [ ] Giữ lựa chọn ngôn ngữ đã lưu của người dùng cũ.
- [ ] Kiểm tra tên `QOwnNotes_Team` tại title, About và menu Ubuntu.
- [ ] Hoàn thiện icon app, tray và menu Ubuntu theo phạm vi đã giao.
- [ ] Kiểm tra chế độ sáng/tối, tương phản, font và chữ bị cắt.
- [ ] Kiểm tra giao diện trên cấu hình mới, không xóa cấu hình cá nhân để thử.
- [ ] Phối hợp Người 1 kiểm tra giao diện trong bản cài `.deb`.
- [ ] Bổ sung ảnh và gửi PR hoàn thiện.

Tiếng Việt là tính năng bổ sung, không phải điều kiện nghiệm thu. Không đặt tiếng Việt làm giao diện mặc định của bản nộp.

## Quy trình phối hợp

- Cập nhật `origin/dev` trước khi sửa; giữ lại thay đổi chưa commit trước khi chuyển nhánh.
- Làm trên nhánh riêng; gửi PR vào `dev`.
- Không force-push hoặc reset lịch sử dùng chung.
- Người 2 và Người 3 cùng sửa `mainwindow`: báo nhau trước khi chỉnh.
- Chỉ đánh dấu hoàn thành khi có kết quả kiểm tra thực tế.
- PR ghi rõ thay đổi, kết quả build, bước thử và ảnh.
- Chưa đưa bản chưa nghiệm thu vào `main`.
- Người phụ trách cập nhật checklist khi hoàn thành; không đánh dấu cả nhóm đã xong chỉ vì các nhánh đã merge.

## Nội dung thông báo cho nhóm

Các phần chính đã merge vào dev và bản tích hợp đã chạy được trên Ubuntu. Ba mẫu đã qua kiểm thử cơ bản. Mọi người cập nhật dev và xem docs/PHAN_CONG_HOAN_THIEN.md để hoàn thiện tiếp: Người 2 kiểm thử bộ đếm/Settings và hiệu năng; Người 3 kiểm tra thêm mẫu ở thư mục con, trùng tên và viết hướng dẫn; Người 4 hoàn thiện giao diện tiếng Anh, icon và sáng/tối. Người 1 phụ trách tích hợp, .deb, tài liệu và release. Thầy yêu cầu giao diện tiếng Anh nên giữ English làm mặc định. Mỗi bạn gửi PR vào dev, kèm kết quả build và ảnh kiểm thử; báo nhau trước khi cùng sửa mainwindow.

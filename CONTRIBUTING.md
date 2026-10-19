# Làm việc nhóm

## Nhánh và commit

main là bản ổn định; dev là bản tích hợp. Mỗi người dùng nhánh trong PHAN_CONG.md.
Sau khi bảo vệ nhánh, mọi thay đổi main/dev qua PR, ít nhất một người khác review.
Không force-push/reset lịch sử chung. Giữ ghi công, bản quyền mã nguồn và thư viện.
Commit nhỏ, dùng `feat:`, `fix:`, `ui:`, `i18n:`, `docs:`, `chore:`.
Không commit executable, build, `.qm`, token, SSH key hay ghi chú cá nhân.

## Cập nhật trước khi làm

```bash
git status --short
# Commit công việc đang làm trước khi tiếp tục nếu có thay đổi.
git fetch origin
git switch feature/wordcount
git merge origin/dev
```

Thay tên nhánh cho Người 3/4. Nếu xung đột, sửa từng file, git add và hoàn tất merge;
báo Người 1 khi chưa rõ, không xóa code người khác chỉ để hết xung đột.

## Kiểm tra và gửi PR

Chạy `bash scripts/build.sh`, thử tính năng trong desktop Ubuntu và xem `git diff`.
Git add file thực tế đã sửa, commit, rồi push nhánh mình. PR chọn base `dev`.
Mô tả PR gồm vấn đề/hành vi mới, file chính, lệnh build/kết quả, bước thử và ảnh UI.
Gửi chuỗi tr() mới cho Người 4. Kẹt build hơn 30 phút thì báo Người 1.
Người 1 build lại bản tích hợp trước merge; không khai kiểm thử chưa chạy.

## Thiết lập repository — Người 1

Mời thành viên và xác nhận quyền push. Tạo quy tắc bảo vệ main/dev trong Settings:
yêu cầu PR, ít nhất một approval, chặn force-push và xóa nhánh.
Không đặt required status check chưa có workflow thực sự chạy.
Tạo bảng To do / Doing / Review / Done, một người phụ trách mỗi task.

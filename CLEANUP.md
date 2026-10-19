# Phạm vi dọn nguồn Ubuntu

Loại khỏi cây nguồn: website/blog, ảnh chụp cũ, ví dụ scripting ngoài app,
CI upstream (GitHub Actions/AppVeyor/GitLab/Travis), Read the Docs, Nix/direnv,
Crowdin, cấu hình đóng gói đa nền tảng và script phát hành upstream.

Giữ:
- `src/`: C++, UI, resource, ảnh/font, bản dịch, thư viện và giấy phép,
  cấu hình build và `src/debian/` để phục vụ `.deb`.
- `icons/`: SVG gốc và script đã sửa để chỉ tạo icon Ubuntu.
- `tests/`: mã kiểm thử ứng dụng.
- `scripts/`: script cài môi trường, build và kiểm tra nguồn của nhóm.
- Tài liệu nhóm, LICENSE, thông tin nguồn, quyền riêng tư và bản quyền.
- CHANGELOG được qmake liệt kê trong DISTFILES nên giữ tham khảo.
- Cấu hình Git/định dạng phục vụ phát triển.

Chỉ giữ `.cpp`/`.h` sẽ làm thiếu UI và tài nguyên. Không cắt sâu thư viện bên thứ ba.
File nền tảng khác trong src vẫn được cấu hình build tham chiếu nên giữ nguyên.
Tất cả thay đổi là commit bình thường: file đã xóa vẫn nằm trong commit cũ,
không làm lại lịch sử lần nữa.

verify-source.py kiểm tra đường dẫn qmake/pri, resource app và gitlink;
đây không phải xác nhận compiler hay GUI đã chạy thành công.

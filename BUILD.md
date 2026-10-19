# Build trên Ubuntu 20.04

## Môi trường

- Ubuntu 20.04 x86_64; GCC 9.4; qmake/lrelease Qt 5.12.8.
- VM đã dùng: khoảng 4 GB RAM, 2 CPU; build bằng `make -j1`.
- Nguồn nền QOwnNotes v24.12.7, nhập thành commit `8881bad`.
- Bản gốc và lần dọn CI ban đầu đã build thành công theo terminal Người 1.
- Commit mới phải build lại; kiểm tra cấu trúc không thay cho build và chạy GUI.

## Kết quả kiểm chứng bản dọn đầy đủ — 20/10/2026

- Build sạch commit `041e16d` qua `scripts/build.sh` trên VM Ubuntu 20.04,
  Qt 5.12.8, GCC 9.4, JOBS=1: thành công, mã thoát 0.
- Executable khoảng 9,8 MB; chạy `QT_QPA_PLATFORM=offscreen .../QOwnNotes --version`
  với thư mục cấu hình thử riêng: in `QOwnNotes 24.12.7`, mã thoát 0.
- 735 đường dẫn nguồn/resource, 18 project qmake/pri, 10 resource: hợp lệ.
- Cú pháp Bash của setup/build/icon: hợp lệ. Chưa chạy cài dependency trên VM sạch
  hoặc tái tạo icon (máy thử chưa có librsvg2-bin).
- Chưa xác nhận tương tác GUI, tính năng custom, đóng gói/cài/gỡ `.deb`.

## 1. Clone

```bash
mkdir -p ~/finalterm
cd ~/finalterm
git clone --branch dev https://github.com/PhanHau06/QOwnNotes-Team.git
cd QOwnNotes-Team
git switch feature/wordcount
```

Thay nhánh bằng `feature/template` hoặc `feature/branding` theo nhiệm vụ.
Nếu clone trước lần làm lại lịch sử, giữ riêng code đã sửa rồi clone mới.
Nguồn thư viện đã nhập trực tiếp; không cần tải submodule.

## 2. Cài dependency

```bash
bash scripts/setup-ubuntu.sh
qmake -v
g++ --version
lrelease -version
```

Script dùng `sudo apt`, cài Qt5 và công cụ phát triển. Không cần cài QOwnNotes từ PPA.
Nhóm thống nhất Ubuntu 20.04 và Qt5, không tự đổi Qt6 giữa dự án.

## 3. Build

```bash
python3 scripts/verify-source.py
bash scripts/build.sh
```

Script tạo `.qm` bằng lrelease, cấu hình qmake, chạy make; gặp lỗi sẽ dừng.
Executable mặc định: `../build-QOwnNotes-Team/QOwnNotes`, ngoài repository.
Để chọn thư mục riêng:

```bash
JOBS=1 BUILD_DIR="$HOME/finalterm/build-team-check" bash scripts/build.sh
```

Dùng thư mục build khác cho mỗi clone, không dùng Makefile của nguồn cũ.
Script kiểm tra nguồn của thư mục build để tránh biên dịch nhầm clone.

## 4. Chạy thử

Mở Terminal trong desktop Ubuntu, chạy executable do script in ra.
SSH thường không có màn hình đồ họa; xem cửa sổ app qua VirtualBox.

- [ ] Mở app, chọn thư mục ghi chú thử riêng.
- [ ] Tạo, sửa tiếng Việt, đổi ghi chú và mở lại.
- [ ] Mở Settings, đóng app rồi khởi động lại.
- [ ] Kiểm tra tính năng vừa sửa, chụp ảnh UI cho PR.

## 5. Xử lý lỗi

- Thiếu module Qt: chạy setup, kiểm tra qmake dùng Qt5.
- Compiler bị `Killed`: kiểm tra RAM/swap, giữ JOBS=1.
- `Could not connect to display`: chạy app từ desktop Ubuntu.
- `not a git repository`: chạy Git trong thư mục nguồn có `.git`.
- Thiếu danh tính commit: cấu hình `git config user.name` và `git config user.email`.
- GitHub hỏi Password: dán token, không dán lệnh khác vào ô đăng nhập.

## 6. Đóng gói và nghiệm thu — Người 1

Giữ `src/debian/`, `.desktop`, icon, bản dịch để đóng gói `.deb`.
Cấu hình Debian gốc cần được điều chỉnh theo bản custom thực tế.

- [ ] Build bản tích hợp từ clone sạch.
- [ ] Tạo `.deb` có executable, desktop entry, icon, `.qm` và giấy phép.
- [ ] Khai báo đủ dependency runtime, không dựa vào package dev của máy build.
- [ ] Cài bằng `sudo apt install ./ten-goi.deb` trên VM Ubuntu 20.04 sạch.
- [ ] Kiểm tra menu, icon, ngôn ngữ, chức năng; thử gỡ bằng apt.
- [ ] Bổ sung chính xác lệnh đóng gói đã thành công vào tài liệu này.
- [ ] Sau nghiệm thu, tạo tag/release và đính kèm `.deb`.

Không coi đóng gói hay kiểm thử GUI hoàn thành chỉ vì đã có file thực thi.

# QOwnNotes Team — đồ án Linux và mã nguồn mở

Tùy biến QOwnNotes v24.12.7 trên Ubuntu 20.04, Qt 5.12.8, GCC 9.4.
Mã nền đã build thành công trên VM 4 GB RAM, 2 CPU.
Các tính năng custom là nhiệm vụ cần triển khai, chưa được coi là hoàn thành.

| Người | Phụ trách | Nhánh |
|---|---|---|
| 1 — PhanHau06 | Môi trường, Git, tích hợp, `.deb` | `chore/*`, `docs/*` |
| 2 | Đếm từ, ký tự, thời gian đọc | `feature/wordcount` |
| 3 | Mẫu ghi chú | `feature/template` |
| 4 | Branding, theme, tiếng Việt | `feature/branding` |

- [Phân công chi tiết](PHAN_CONG.md)
- [Môi trường và build](BUILD.md)
- [Quy trình Git và PR](CONTRIBUTING.md)
- [Phạm vi dọn nguồn](CLEANUP.md)
- [Nguồn mã](PROJECT_ORIGIN.md)

## Bắt đầu trên Ubuntu

```bash
git clone --branch dev https://github.com/PhanHau06/QOwnNotes-Team.git
cd QOwnNotes-Team
bash scripts/setup-ubuntu.sh
bash scripts/build.sh
```

Mở executable `../build-QOwnNotes-Team/QOwnNotes` từ Terminal trong desktop Ubuntu.
Thư viện đã nhập trực tiếp trong `src/libraries/`; không cần cập nhật submodule.

## Cấu trúc

- `src/`: code, UI Qt, resource, bản dịch, thư viện, cấu hình build và Debian.
- `icons/`: SVG gốc và script sinh icon Ubuntu.
- `tests/`: mã kiểm thử.
- `scripts/`: công cụ môi trường, build và kiểm tra nguồn của nhóm.
- Các file Markdown: hướng dẫn và thông tin nguồn/giấy phép.

Không commit file build, executable, `.qm`, token hoặc dữ liệu ghi chú cá nhân.

## Ghi công

Dựa trên [QOwnNotes](https://github.com/pbek/QOwnNotes) của Patrizio Bekerle
và các cộng tác viên. Giữ [LICENSE](LICENSE), thông tin bản quyền và giấy phép
thư viện trong `src/libraries/`. Phần tùy biến nhóm được ghi qua commit và PR.

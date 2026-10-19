# Icon của nhóm

Sửa icon.svg và icon-dark.svg, rồi chạy từ repository:

```bash
bash icons/generate-icons.sh
```

Cần librsvg2-bin (setup-ubuntu.sh đã cài).
Sinh PNG 16–512 px và SVG trong src/images cho app/menu Ubuntu.
Không tạo icon website, Snap, Windows, macOS.
Giữ file icon nền tảng khác được cấu hình nguồn tham chiếu. Build lại và kiểm tra UI.

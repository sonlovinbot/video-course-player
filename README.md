# Video Course Player — Bộ công cụ dựng "dashboard xem video" bằng Claude Code

Bộ khung + công cụ để biến **video bài giảng** thành một **trang web xem video** có:
danh sách chương bấm-để-nhảy, phụ đề song ngữ (EN/VI) chạy theo lời nói, tab tài liệu,
và đóng gói được thành **phần mềm chạy local** (Windows / macOS / Linux) hoặc **PWA cài từ trình duyệt**.

> Repo này **chỉ chứa công cụ + hướng dẫn** để bạn tự làm lại với video của mình.
> **Không** kèm video, tài liệu hay bản chép lời của khoá học gốc (lý do bản quyền).

---

## 📁 Có gì trong repo

| Đường dẫn | Là gì |
|-----------|-------|
| `app/index.html` | Trang player (1 file: player + chương + phụ đề + tab bài học/PDF). Đọc dữ liệu từ `course-data.js`. |
| `app/course-data.sample.js` | **Dữ liệu mẫu** — cấu trúc để bạn điền. Copy thành `course-data.js`. |
| `app/sw.js`, `manifest.webmanifest`, `icons/` | Cho phép **cài như app (PWA)** + chạy offline. |
| `app/Mở phần mềm.command` | Double-click (macOS) để chạy app local nhanh. |
| `.claude/serve.py` | Server tĩnh nhỏ **có hỗ trợ tua video** (HTTP Range). Dùng để xem thử local. |
| `.claude/launch.json` | Cấu hình chạy server. |
| `packaging/src/launcher.go` | Server gọn viết bằng Go → binary chạy local, tự mở trình duyệt. |
| `packaging/build.sh` | Đóng gói thành bộ cài `.dmg` / `.zip` / `.tar.gz` cho 3 hệ điều hành. |
| `Huong-dan-Claude-Code-dung-video.*` | **Hướng dẫn trực quan** (HTML + PDF): dùng Claude Code để cắt & dựng video. Bắt đầu từ đây nếu bạn mới. |
| `HUONG-DAN-SU-DUNG.pdf` | Hướng dẫn cho **người học** cách cài & dùng phần mềm. |

Những thứ **không có** trong repo (tự sinh ra khi làm): `course-data.js`, `MP4/`,
`app/pdf-pages/`, `transcripts/`, `packaging/build/`, `packaging/dist/`.

---

## 🚀 Bắt đầu nhanh (xem template chạy thử)

Cần: **Python 3** (có sẵn trên Mac/Linux). Từ thư mục gốc repo:

```bash
cp app/course-data.sample.js app/course-data.js     # dùng dữ liệu mẫu
# đặt 1 video tên vi-du.mp4 vào thư mục MP4/ (tự tạo): MP4/vi-du.mp4
python3 .claude/serve.py 8123                        # chạy server local
```

Mở trình duyệt: `http://localhost:8123/app/index.html`

---

## 🎬 Làm với video của bạn (khuyến nghị: dùng Claude Code)

Mở [Claude Code](https://claude.com/claude-code) tại thư mục này rồi ra lệnh bằng tiếng Việt.
Xem hướng dẫn từng bước + prompt mẫu trong **`Huong-dan-Claude-Code-dung-video.pdf`**.

Mạch việc: `video → chép lời (whisper) → chia chương → sinh course-data.js → xem & chỉnh`.
Prompt gợi ý:

> "Trong folder này có video của tôi. Chép lời bằng whisper local kèm mốc thời gian,
> chia thành các chương theo chủ đề, sinh file `app/course-data.js`, rồi chạy local cho tôi xem."

Công cụ cần (Claude Code cài giúp được): `ffmpeg`, `whisper` (whisper.cpp), `python3`.

---

## 📦 Đóng gói thành phần mềm cài đặt

Cần **Go** (`brew install go`). Từ thư mục gốc:

```bash
bash packaging/build.sh mac      # hoặc: win | linux | all
```

Kết quả nằm ở `packaging/dist/` (đã gitignore). Mỗi bộ cài kèm sẵn `app/` + `MP4/` →
người dùng tải về, mở lên là tự bật trang trong trình duyệt, chạy offline.

> Bộ cài **chưa ký số** → macOS: chuột phải → Open; Windows: More info → Run anyway.

---

## ⚖️ Bản quyền

Khung code và hướng dẫn trong repo này dùng tự do cho video **của bạn**.
Đừng đưa video / tài liệu / bản chép lời của khoá học có bản quyền (vd
PronunciationWorkshop.com) lên repo công khai.

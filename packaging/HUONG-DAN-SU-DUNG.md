# Pronunciation Workshop — Hướng dẫn sử dụng

Phần mềm học phát âm tiếng Anh Mỹ (16 bài video + tài liệu PDF song ngữ + phụ đề EN/VI).
Đây là **phần mềm chạy trên máy (offline)**: cài xong, mở lên là nó tự bật trang học trên trình duyệt. **Không cần internet, không cần cài thêm gì.**

> Tải đúng file cho máy của bạn:
> - 🍎 **macOS** → `PronunciationWorkshop-mac.dmg`
> - 🪟 **Windows** → `PronunciationWorkshop-win.zip`
> - 🐧 **Linux** → `PronunciationWorkshop-linux.tar.gz`

---

## 🍎 macOS (MacBook / iMac)

1. Mở file **`PronunciationWorkshop-mac.dmg`** (nháy đúp).
2. Cửa sổ hiện ra → **kéo biểu tượng "Pronunciation Workshop" thả vào thư mục Applications**.
3. Vào **Applications**, **bấm chuột phải** vào "Pronunciation Workshop" → chọn **Open**.
4. Lần đầu macOS hỏi "unidentified developer" → bấm **Open** lần nữa.
   *(Nếu không thấy nút Open: vào  → System Settings → Privacy & Security, kéo xuống bấm "Open Anyway".)*
5. Một cửa sổ Terminal nhỏ màu đen hiện ra (báo phần mềm đang chạy) và **trình duyệt tự mở trang học**.
6. **Giữ cửa sổ đen đó mở** khi đang học. Học xong, **đóng nó lại** để tắt phần mềm.

> Chỉ cần làm bước 1–2 một lần. Lần sau chỉ mở từ Applications.

---

## 🪟 Windows (10/11)

1. **Bấm chuột phải** vào `PronunciationWorkshop-win.zip` → **Extract All…** (Giải nén tất cả).
2. Mở thư mục vừa giải nén → nháy đúp **`Pronunciation Workshop.exe`**.
3. Nếu hiện bảng xanh **"Windows protected your PC"** → bấm **More info** → **Run anyway**.
   *(Đây là vì phần mềm chưa mua chứng chỉ ký số, hoàn toàn an toàn.)*
4. Một cửa sổ đen (Command Prompt) hiện ra và **trình duyệt tự mở trang học**.
5. **Giữ cửa sổ đen mở** khi học; **đóng** nó để tắt.

> Mẹo: để thư mục đã giải nén ở chỗ cố định (vd Desktop). Có thể chuột phải `Pronunciation Workshop.exe` → **Send to → Desktop (create shortcut)** cho dễ mở lần sau.

---

## 🐧 Linux

1. Giải nén: nháy đúp `PronunciationWorkshop-linux.tar.gz` → Extract, **hoặc** chạy lệnh:
   ```
   tar -xzf PronunciationWorkshop-linux.tar.gz
   ```
2. Vào thư mục `PronunciationWorkshop-linux`, chạy file **`PronunciationWorkshop`**:
   - Nháy đúp → chọn **Run**, **hoặc** mở Terminal trong thư mục đó và gõ:
     ```
     ./PronunciationWorkshop
     ```
3. Trình duyệt tự mở trang học. Giữ cửa sổ Terminal mở khi học, đóng để tắt.

> Cần có `xdg-open` để tự mở trình duyệt (đa số bản Linux có sẵn). Nếu trình duyệt không tự mở, xem mục Xử lý sự cố bên dưới.

---

## 📚 Cách dùng trang học

| Khu vực | Chức năng |
|---------|-----------|
| **Cột trái** | Danh sách **16 bài**. Bấm vào bài để mở các **chủ đề nhỏ** (chapter). Bấm chủ đề → video tự nhảy đúng đoạn. |
| **Giữa** | Trình phát video. Nút **‹ Trước / ↻ Xem lại / Tiếp ›** để chuyển chủ đề. |
| **Thanh phụ đề (dưới video)** | Nút **CC** bật/tắt phụ đề. Nút **Khớp − / +** để chỉnh phụ đề chạy sớm/muộn cho khít giọng thầy (tự lưu). |
| **Góc phải trên** | Nút **EN / VI** đổi ngôn ngữ cho **toàn bộ** (giao diện, bài học, phụ đề). |
| **Cột phải — tab Bài học** | Nội dung bài (từ tài liệu PDF), song ngữ. Nút **"Xem trang PDF liên quan"** nhảy sang trang PDF tương ứng. |
| **Cột phải — tab Phụ đề** | Toàn bộ lời thầy nói. Bấm 1 dòng để tua video tới chỗ đó. |
| **Cột phải — tab PDF gốc** | Ảnh trang sách thật. Bấm ảnh để **phóng to/zoom**; bấm "Tới video" để nhảy tới đoạn liên quan. |

💡 **Điện thoại / máy tính bảng**: giao diện tự xếp lại 1 cột, vuốt để cuộn. (Phần mềm này cài trên máy tính, nhưng nếu sau này đưa lên web thì điện thoại cũng dùng được.)

---

## 🔧 Xử lý sự cố

- **Trình duyệt không tự mở** → tự mở trình duyệt và gõ địa chỉ ghi trong cửa sổ đen, thường là:
  `http://127.0.0.1:8123/app/` (nếu cổng bận, cửa sổ đen sẽ hiện số cổng khác — dùng đúng số đó).
- **Lỡ đóng trình duyệt** → mở lại trình duyệt, gõ lại địa chỉ trên (cửa sổ đen vẫn đang chạy).
- **Video không chạy / giật** → bấm tải lại trang (Ctrl/Cmd + R). Dùng **Chrome, Edge, Safari hoặc Firefox** bản mới.
- **Phụ đề lệch với giọng thầy** → bấm nút **Khớp +** (phụ đề đang trễ) hoặc **Khớp −** (phụ đề đang sớm) cho khít.
- **Phần "Chấm phát âm/Micro"** (nếu thêm sau này) chỉ chạy khi mở qua phần mềm này (localhost), không chạy khi mở file rời.
- **Tắt hẳn phần mềm** → đóng cửa sổ đen (Terminal/Command Prompt).

---

## ❓ Câu hỏi nhanh
- **Có cần internet không?** Không. Mọi video & tài liệu nằm sẵn trong phần mềm.
- **Có an toàn không?** Có. Cảnh báo của macOS/Windows chỉ vì phần mềm chưa mua chứng chỉ ký số, không phải virus.
- **Cài 1 lần dùng mãi?** Đúng. Mở lại bất cứ lúc nào.

Chúc bạn học tốt! 🎧🗣️

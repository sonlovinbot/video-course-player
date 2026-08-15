/* ============================================================================
   DỮ LIỆU MẪU — course-data.sample.js
   ----------------------------------------------------------------------------
   Đây là ví dụ cấu trúc dữ liệu mà trang player (index.html) đọc.
   Khi làm thật, AI (Claude Code) sẽ sinh ra file `course-data.js` từ video của
   bạn: chép lời -> chia chương -> ghép transcript song ngữ.

   Cách dùng nhanh để xem thử template:
     1) Copy file này thành `course-data.js`  (cùng thư mục app/)
     2) Đặt 1 video mp4 vào ../MP4/ đúng tên trong `srcLocal` bên dưới
     3) Mở app qua server local (xem README) rồi bấm chương để test
   ========================================================================== */
window.COURSE = {
  title: "Tên khoá học của bạn",
  subtitle: "Mô tả ngắn — tác giả",
  useLocal: true,                 // true = phát video local (../MP4/...)
  sessions: [
    {
      id: "1",
      title: { en: "Session 1 — Sample topic", vi: "Bài 1 — Chủ đề mẫu" },
      video: { type: "hls", src: "", srcLocal: "../MP4/vi-du.mp4", duration: 300 },
      pdfPages: "1-2",
      // Phụ đề: mỗi dòng { t: giây bắt đầu, en, vi }
      transcript: [
        { t: 0,  en: "Welcome to the sample lesson.", vi: "Chào mừng đến bài học mẫu." },
        { t: 6,  en: "This line appears at 6 seconds.", vi: "Dòng này hiện ở giây thứ 6." },
        { t: 14, en: "Subtitles follow the audio.", vi: "Phụ đề chạy theo lời nói." }
      ],
      // Ảnh trang tài liệu (tuỳ chọn) — bấm để phóng to / nhảy tới chương
      pdf: [
        { img: "pdf-pages/p1.png", chapter: "intro", topics: { en: "Overview", vi: "Tổng quan" } }
      ],
      // Chương: chia video theo chủ đề
      chapters: [
        {
          id: "intro", start: 0, end: 120, pdfIdx: 0,
          title: { en: "Opening", vi: "Mở đầu" },
          lesson: {
            en: "<h4>Opening</h4><p>Write the English lesson here (from your PDF).</p>",
            vi: "<h4>Mở đầu</h4><p>Viết nội dung bài học tiếng Việt ở đây.</p>"
          }
        },
        {
          id: "topic-a", start: 120, end: 300, pdfIdx: 0,
          title: { en: "Topic A", vi: "Chủ đề A" },
          lesson: {
            en: "<h4>Topic A</h4><p class='words-label'>Practice words:</p><div class='word-grid'><span>One</span><span>Two</span><span>Three</span></div>",
            vi: "<h4>Chủ đề A</h4><p class='words-label'>Luyện từ:</p><div class='word-grid'><span>One</span><span>Two</span><span>Three</span></div>"
          }
        }
      ]
    }
  ]
};

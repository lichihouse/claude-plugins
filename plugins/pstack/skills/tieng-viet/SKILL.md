---
name: tieng-viet
description: >-
  Bảng tiếng Việt công dụng các skill pstack. Dùng khi người dùng không rành
  tiếng Anh, quên lệnh /pstack:, hỏi how / why / arena / swarm nghĩa là gì,
  hoặc gõ /pstack:tieng-viet.
disable-model-invocation: true
---

# pstack tiếng Việt

Trả lời bằng tiếng Việt, câu ngắn. Không dịch nguyên văn file skill tiếng Anh. Thuật ngữ chuyên ngành giữ tiếng Anh.

Khi người dùng mở skill này: hiện hai bảng dưới. Đừng giảng lại toàn bộ plugin. Nếu người dùng hỏi thêm về một lệnh, đọc `SKILL.md` của lệnh đó (cùng thư mục cha với skill này) rồi tóm tắt bằng tiếng Việt.

Lệnh gõ có tiền tố `/pstack:` khi pstack là plugin. Nếu repo cài pstack dạng skill dự án (khối `pstack` lúc mở phiên ghi "project skills"), bỏ tiền tố: `/how` thay cho `/pstack:how`.

## Lệnh hay gõ

| Gõ | Dùng khi |
|---|---|
| `/pstack:poteto-mode` | Làm việc kỹ, gọn, có kiểm chứng. Điểm vào mặc định cho việc nghiêm túc. Tắt: `/pstack:poteto-mode off` hoặc "tắt poteto-mode". |
| `/pstack:how` | Cái này chạy thế nào? File nào phụ trách? Nên đặt code ở đâu? |
| `/pstack:why` | Sao ngày xưa làm vậy? Tra git, PR, ticket, chat, log qua MCP. |
| `/pstack:teach` | Giải thích cho tôi hiểu thật (how + why, dựng từng sơ đồ). |
| `/pstack:recall` | Tôi đang làm dở chỗ nào? Dựng lại ngữ cảnh từ lịch sử chat. |
| `/pstack:blast-radius` | Sửa cái này thì vỡ chỗ nào? Chạy thật để chứng minh. |
| `/pstack:architect` | Việc lớn: phác kiểu, hàm, file rồi mới viết code. |
| `/pstack:arena` | Nhiều model làm cùng một việc, chọn bản tốt, ghép điểm hay. |
| `/pstack:swarm` | Chia nhiều việc nhỏ, chạy song song, gom một báo cáo. |
| `/pstack:interrogate` | Nhiều model soi lỗ hổng một diff. Chỉ kết luận, không tự sửa. |
| `/pstack:figure-it-out` | Việc lớn chưa có cách làm sẵn. Viết quy trình rồi mới làm. |
| `/pstack:show-me-your-work` | Nhật ký quyết định (làm gì, vì sao, bằng chứng) để xem lại sau. |
| `/pstack:tdd` | Viết test fail trước rồi mới sửa. Chỉ khi người dùng xin. |
| `/pstack:deslop` | Dọn code "rác AI" trong diff trước khi commit. |
| `/pstack:no-comments` | Xoá comment thừa (gọi agent Comment Sicko). |
| `/pstack:unslop` | Dọn văn phong AI trong chữ viết. |
| `/pstack:technical-writing` | Viết docs, README, PR, commit message. |
| `/pstack:bro` | Nói lại tin trước cho dễ hiểu. |
| `/pstack:create-verification-skill` | Tạo skill `verify-<app>` để agent bấm app như người dùng. |
| `/pstack:maintain-verification-skill` | Skill verify đã lệch so với app, sửa lại. |
| `/pstack:control-ui` | Lái trình duyệt (Playwright, CDP) để lấy ảnh, log, bằng chứng. |
| `/pstack:control-cli` | Lái CLI / TUI để lấy bằng chứng. |
| `/pstack:automate-me` | Học thói quen làm việc của bạn, tạo `<tên-bạn>-mode`. |
| `/pstack:reflect` | Học từ phiên vừa xong, đề xuất sửa skill. |
| `/pstack:setup-pstack` | Đổi model và mức nỗ lực cho từng vai. |
| `/pstack:tieng-viet` | Bảng này. |

Skill `principle-*`, `typescript-best-practices`: nội quy, không cần gõ. poteto-mode tự đọc khi cần.

Mức nỗ lực (effort) trong bảng model: app ghi Low / Medium / High / Extra / Max, tương ứng `low` / `medium` / `high` / `xhigh` / `max`. Ultracode không phải mức nỗ lực mà là chế độ của phiên (`xhigh` + tự điều phối workflow). Haiku không có mức nỗ lực.

## Câu tiếng Việt → lệnh

- chạy thế nào, hiểu code, đặt file ở đâu → `/pstack:how`
- vì sao, sao làm vậy, lịch sử quyết định → `/pstack:why`
- dạy tôi, giải thích cho tôi hiểu → `/pstack:teach`
- thiết kế trước, đừng viết code vội → `/pstack:architect`
- làm nhiều bản rồi chọn bản đẹp → `/pstack:arena`
- chia việc, quét nhiều chỗ cùng lúc → `/pstack:swarm`
- soi lỗ hổng, review gắt → `/pstack:interrogate`
- vỡ chỗ nào, ảnh hưởng tới đâu → `/pstack:blast-radius`
- việc to, chưa biết chia bước → `/pstack:figure-it-out`
- đang làm dở, bắt kịp lại → `/pstack:recall`
- sửa bug, làm tính năng, làm cho kỹ → `/pstack:poteto-mode <mô tả việc>`
- dọn code trước khi commit → `/pstack:deslop`
- nói lại cho dễ hiểu → `/pstack:bro`
- đổi model pstack → `/pstack:setup-pstack`

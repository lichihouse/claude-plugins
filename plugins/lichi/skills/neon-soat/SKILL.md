---
name: neon-soat
description: Nhờ Gemini 4 Neon (tài khoản Antigravity của Đức, chạy qua T3 Code trên Mac) làm người soát thứ hai cho Claude ở repo Kho và Booking. Dùng ở 3 lúc - plan việc rủi ro trước khi gửi Đức, diff PR có code trước khi merge (Booking: chỉ PR rủi ro §7), kết luận về nguyên nhân hay số đo trước khi báo. Gồm cách gọi từ phiên trên Mac và từ thread cloud (Remote Control), cách xử lý kết quả, dòng ghi vào PR.
---

# Nhờ Gemini Neon soát

Đức chốt ngày 24/11/2026: mọi việc ở repo Kho (`lichihouse/Quan-ly-Kho`) đều qua thêm một lượt soát, còn ở Booking chỉ PR rủi ro (AGENTS.md §7) và plan lớn của Gemini 4 Neon. Claude vẫn làm chính. Neon đọc repo thật (trong worktree riêng) cùng brief Claude viết, rồi nêu lỗi kèm kịch bản. Đức chốt: cần chất lượng review, không cần tiết kiệm token.

Neon là **người soát thứ hai, không phải cổng chặn**. Nếu Mac tắt, Neon hết hạn mức hay báo lỗi thì bỏ qua và ghi lý do. Không để việc đứng chờ Neon, và không nhờ Đức bấm gì.

Đức đã chọn dùng tài khoản Antigravity gói cá nhân và tự chịu rủi ro điều khoản của Google. Không hỏi lại chuyện này.

## 1. Khi nào gọi

| Lúc | Cách gọi |
|---|---|
| PR có code (Kho: mọi PR có code; **Booking: chỉ PR rủi ro theo AGENTS.md §7**, PR thường không gọi Neon): sau khi reviewer của repo báo sạch HIGH và MED, trước khi merge (Booking: trước `gh pr ready` / hẹn merge, PR còn nháp) | Chế độ repo (2b): Neon đọc nhánh PR trong worktree riêng |
| Plan việc rủi ro theo AGENTS.md của repo (Kho: việc rủi ro; Booking: plan có mục Đỏ gồm **Dừng hỏi**, ; hoặc plan nhiều PR / đổi hành vi diện rộng dù chỉ mức Vàng): sau lượt soát của Claude, trước khi gửi Đức | Đẩy plan lên một nhánh (file `docs/plan-*.md` hoặc trong mô tả commit), rồi dùng chế độ repo, để Neon đối chiếu plan với code thật. Không đẩy được thì dùng chế độ brief (2a) và dán kèm các đoạn code mà plan dựa vào |
| Kết luận về nguyên nhân lỗi, kết luận dựa trên số đo, đề xuất việc khó đảo ngược: trước khi báo Đức | Chế độ repo trên nhánh đang làm khi nhánh có commit khác nhánh gốc; kết luận về `main` / prod (không có diff, script ra exit 4) thì dùng chế độ brief. Brief ghi kết luận và bằng chứng thô |

Không gọi Neon cho PR chỉ đổi docs hay markdown, hoặc khi chỉ trả lời câu hỏi thường. Ngoại lệ ở Booking: PR chạm mục "Luật và công cụ agent" §7 (vd `AGENTS.md`, `.claude/**`, `docs/agents/**`, `docs/ENGINEERING_PRINCIPLES.md`) là PR rủi ro nên vẫn gọi Neon dù chỉ là markdown. Booking: PR thường ghi `- neon: N/A (PR thường)`. Chi tiết khi nào soát hay soát lại (luồng staging, `fix/sync-dev-main-*`, cùng head SHA, PR thường thành rủi ro) theo AGENTS.md §6 mục Neon của Booking.

Chỉ phiên chính gọi Neon. Subagent không gọi. Hook của plugin lichi nhắc phiên chính khi phiên mở ở repo Kho hoặc Booking, hay ở thư mục cha chứa một trong hai repo đó.

Diff lớn hơn 1500 dòng (không tính test, file sinh, lockfile) thì chia thành nhiều lượt. Mỗi lượt một nhóm file, ghi rõ nhóm trong brief ("chỉ soát artifacts/api-server/src/lib/allocation*").

## 2. Cách gọi

Chỉ có một cửa: script `/Users/hiuduc/.claude/neon-soat.sh` trên Mac của Đức. Mã nguồn của script là `neon-soat.sh` trong thư mục skill này. Đức đã cho phép sẵn `Bash(bash /Users/hiuduc/.claude/neon-soat.sh:*)`, nên lệnh chạy thẳng, không hỏi. Không gọi `t3` hay `agy` trực tiếp: auto mode chặn hai lệnh này.

Script tự ghép phần "luật chung" vào trước brief. Phần luật chung gồm: vai người soát độc lập tìm lỗi thật, được đọc file và chạy test, cấm sửa file, commit, push, đọc `.env`, và mẫu đầu ra bắt buộc. Gọi `gemini-4-neon` với `effort=medium` qua `t3` (Đức chọn 24/11). Không giới hạn lượt hay thời gian.

Có hai chế độ:

- **2a. Chế độ brief:** `bash /Users/hiuduc/.claude/neon-soat.sh < /tmp/neon-brief.md`. Neon chỉ thấy brief và chạy trong thư mục trống `~/neon-soat`. Dùng khi nội dung không nằm trên nhánh nào.
- **2b. Chế độ repo:** `bash /Users/hiuduc/.claude/neon-soat.sh <thư mục repo trên Mac> <nhánh> [nhánh gốc] < /tmp/neon-brief.md`. Script làm 4 việc:
  1. `git fetch`.
  2. Kiểm `origin/<nhánh>` có tồn tại và có diff so với nhánh gốc. Không đạt thì exit 4 hoặc 5, không gọi Neon.
  3. Tạo worktree riêng của T3 tại đúng commit đó. Neon không đụng thư mục làm việc của Đức.
  4. Dặn Neon đọc `AGENTS.md` và code xung quanh trước khi kết luận.

  Nhánh gốc mặc định theo `origin/HEAD`: Kho là `master`, Booking là `main`. Thư mục repo trên Mac: `/Users/hiuduc/Projects/Quan-ly-Kho`, `/Users/hiuduc/Projects/Booking` (cả hai đã là project T3).

Exit code: 0 xong · 1 t3 lỗi · 2 Neon hỏi lại · 4 brief hoặc diff rỗng · 5 sai repo hoặc nhánh.

### Viết brief (`/tmp/neon-brief.md`)

Luôn ghi brief bằng tool Write, không dùng `echo "..."` (shell sẽ bung `$VAR` và backtick). Brief gồm đủ 5 mục:

```
1. Muc dich: <ai can, vi sao, 2-3 cau; trich nguyen van yeu cau cua Duc neu co>
2. Dung la gi: <tieu chi dung / hanh vi mong doi; cai gi KHONG duoc doi>
3. Luat lien quan: <muc AGENTS.md lien quan, vd "Kho §5 cong no, §8 schema chi ADD"; Neon tu doc file>
4. Cho nghi nhat: <3-5 cau hoi cu the Claude muon Neon dao sau, vd "huy phieu giua chung co lam lech so du xuong khong">
5. Ngoai pham vi: <phan khong can soat, vd file sinh, doi ten>
```

Không đưa vào brief:
- Kết luận của reviewer khác (reviewer-kho, interrogate) hay "Claude đã kiểm X đúng". Neon phải đọc độc lập thì lượt soát thứ hai mới có giá trị. Claude tự gộp hai bên sau.
- `.env`, khoá, mật khẩu, token, chuỗi kết nối DB, dữ liệu khách hàng thật (tên, số điện thoại, địa chỉ).

### a. Phiên đang chạy trên Mac (Remote Control, Claude Desktop, T3)

Write brief ra `/tmp/neon-brief.md`. Push nhánh lên trước, vì script đọc `origin/<nhánh>`. Sau đó chạy lệnh của chế độ 2b (hoặc 2a), mỗi lệnh riêng, không nối bằng `|`.

### b. Thread cloud (thread Project của claude.ai, có tool `start_remote_control`)

1. Push nhánh. Gọi `start_remote_control` với `folder` là `/Users/hiuduc/Projects/Quan-ly-Kho` (Đức đã duyệt sẵn, không cần ai bấm; script nhận đường dẫn repo nên Booking cũng chạy được từ đây). `instructions` theo mẫu dưới.
2. Kết quả về dưới dạng tin nhắn từ phiên trên Mac. Neon có thể chạy vài phút.
3. Luôn gọi `stop_remote_control`, kể cả khi lỗi hay Mac không trả lời, vì trong lúc Remote Control chạy, các tool thư mục của thread bị khoá.

`instructions` không được chứa thẻ dạng HTML. Đừng viết `<...>` trong brief gửi qua đây, hãy viết bằng chữ.

```
Chi lam dung cac buoc duoi, khong sua file nao khac, khong chuyen nhanh. Bao NGUYEN VAN dau ra, thoi gian chay va exit code.
1. Dung tool Write ghi phan nam giua ===BRIEF=== va ===HET=== vao /tmp/neon-brief.md.
2. bash /Users/hiuduc/.claude/neon-soat.sh /Users/hiuduc/Projects/(Quan-ly-Kho|Booking) (nhanh) (nhanh goc) < /tmp/neon-brief.md; echo "exit=$?"
===BRIEF===
(5 muc brief)
===HET===
```

### c. Không gọi được

Gặp các trường hợp dưới thì bỏ qua, ghi lý do, rồi làm tiếp. Chỉ thử lại 1 lần, và chỉ khi lỗi có thể tự hết (Mac chưa trả lời, lỗi mạng). Thiếu tool, hết hạn mức, exit 4 hoặc 5 thì sửa đầu vào hoặc bỏ qua, không thử lại y nguyên.
- Không có `start_remote_control`, và phiên cũng không chạy trên Mac.
- Mac không trả lời trong 2 phút, hoặc Neon chạy quá 20 phút. Script không tự cắt giờ, phiên gọi tự quyết định bỏ qua.
- Exit khác 0. Đầu ra báo lỗi hạn mức (`quota`, `RESOURCE_EXHAUSTED`, `429`). Đầu ra không có dòng `KET_LUAN:`.
- Script mất hoặc hỏng (`No such file`, `No T3 Code project matches`): báo Đức chạy lại `cai-tren-mac.sh` của skill này trong Terminal. Script này sửa quyền nên không tự cài.

## 3. Xử lý kết quả

- Đối chiếu từng lỗi với code thật: Read đúng file:line, chạy lại kịch bản Neon nêu (test hoặc lệnh). Lỗi có `NGHI:` hay không kèm kịch bản thì kiểm kỹ hơn trước khi tin.
- Xếp lại từng lỗi theo thang HIGH / MED / LOW của reviewer repo (`reviewer-kho`, `reviewer-booking`), không theo mức Neon đặt.
- Lỗi đúng mức HIGH / MED: sửa, rồi chạy lại cổng máy và review lại phần đổi như AGENTS.md của repo. LOW: ghi fix / dismiss + lý do, không mở vòng sửa mới. Phần sửa dài hơn 50 dòng thì gọi Neon thêm một lượt cho phần đó.
- Lỗi sai: bác, ghi một câu lý do có bằng chứng.
- `CAN_THEM:`: bổ sung vào brief rồi gọi lại một lượt nếu điểm đó quan trọng.
- Neon bắt được lỗi mà reviewer của Claude bỏ sót: coi là lỗi lọt cổng theo AGENTS.md của repo, và thêm chốt chặn cho loại lỗi đó.
- Neon sai nhiều lần cùng một kiểu (vd không hiểu luật X): thêm 1 câu về luật đó vào mục "Luat lien quan" của brief những lần sau. Luật chung thì đề xuất sửa `neon-soat.sh`.

## 4. Ghi lại

PR có code: thêm một dòng vào khối DoD, ngay dưới dòng `- review:`, theo một trong các dạng:

```
- neon: HIGH=<n> MED=<n> LOW=<n> · đã sửa: <...> · bác: <... vì ...>
- neon: KHONG_CO_LOI
- neon: bỏ qua (<lý do>)
- neon: N/A (chỉ docs)   # Booking: chỉ docs không thuộc PR rủi ro §7
- neon: N/A (PR thường)   # chỉ Booking, theo AGENTS.md §7
- neon: N/A (phiên chính là Neon)
```

Plan hay kết luận gửi Đức: thêm một câu "Neon đã soát: ..." hoặc "Neon bỏ qua vì ...". Không dán nguyên văn đầu ra của Neon cho Đức.

## 5. Tự cải thiện

Mục tiêu: Neon bắt được nhiều lỗi thật hơn và báo nhầm ít đi theo thời gian. Mọi thay đổi đều phải **đo được** trên bộ đề kiểm, không sửa theo cảm giác.

### Dữ liệu có sẵn

- Dòng `- neon:` trong DoD của mỗi PR (Kho, Booking) ghi Neon báo gì, cái nào đã sửa, cái nào bác và vì sao.
- `~/neon-soat/nhat-ky.md` trên Mac: script tự ghi đầu ra nguyên văn của mọi lượt (giờ, repo, nhánh, exit).
- `de-kiem/` trong thư mục skill này: bộ đề kiểm. Mỗi ca là một thư mục gồm `brief.md` (chạy ở chế độ brief, tự chứa đủ code) và `dap-an.md` (lỗi phải bắt, và những gì không được báo là HIGH/MED).

### Khi gặp sai thì làm ngay

| Gặp | Làm |
|---|---|
| Neon bỏ sót lỗi HIGH/MED mà sau này mới lộ (reviewer, CI, Đức phát hiện) | Thêm một ca vào `de-kiem/`. Nếu do brief thiếu thì sửa mẫu brief (mục 2). Nếu do luật chung thì sửa `LUAT_CHUNG` trong `neon-soat.sh` |
| Neon bắt được lỗi mà reviewer của Claude bỏ sót | Lỗi lọt cổng của repo: thêm chốt chặn theo AGENTS.md. Thêm ca vào `de-kiem/` để giữ khả năng này của Neon |
| Neon báo nhầm cùng một kiểu từ 2 lần trở lên | Thêm 1 câu vào `LUAT_CHUNG` hoặc vào mục "Luat lien quan" của mẫu brief. Thêm ca có `dap-an.md` ghi rõ "không được báo" |
| Script hay cách gọi lỗi | Sửa `neon-soat.sh` hoặc mục 2, kèm test tay |

### Cách sửa (PR vào lichihouse/claude-plugins)

1. Sửa xong thì chạy **toàn bộ** bộ đề trên Mac, cả bản cũ lẫn bản mới. Trên Mac: `git clone --depth 1 --branch <nhánh> https://github.com/lichihouse/claude-plugins /tmp/cp-neon`. Với mỗi ca, chạy `bash /Users/hiuduc/.claude/neon-soat.sh < /tmp/cp-neon/plugins/lichi/skills/neon-soat/de-kiem/<ca>/brief.md`. Để chạy bản mới: chép `neon-soat.sh` mới vào `~/.claude/neon-soat.sh` sau khi đã sao lưu bản cũ thành `~/.claude/neon-soat.sh.bak-<ngày>`.
2. Chấm từng ca theo `dap-an.md`: bắt đủ hay sót, có báo nhầm HIGH/MED không. Ghi bảng trước / sau vào mô tả PR.
3. Bản mới **không kém hơn** ở ca nào thì giữ bản mới, merge theo luật thường của repo (CI xanh), tăng version lichi. Kém hơn ở bất kỳ ca nào thì trả `~/.claude/neon-soat.sh` về bản sao lưu và không merge.
4. Báo Đức một dòng: đã đổi gì, kết quả bộ đề trước / sau.

### Tổng kết hằng tuần

Mỗi tuần một lần (trigger "Tổng kết Neon soát" của project Kho, nếu đã tạo), làm 3 việc:
- Đọc dòng `- neon:` của các PR đã merge trong tuần ở Kho và Booking.
- Đọc `~/neon-soat/nhat-ky.md` qua Remote Control.
- Đếm số lượt, số lỗi đúng, số lỗi bác, số lượt bỏ qua và lý do. Tìm kiểu sai lặp lại rồi đi theo bảng "Khi gặp sai" ở trên.

Không có gì đáng sửa thì chỉ báo số liệu, không mở PR.

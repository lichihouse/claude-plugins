---
name: neon-soat
description: Nhờ Gemini 4 Neon (tài khoản Antigravity của Đức, chạy qua T3 Code trên Mac) làm người soát thứ hai cho Claude ở repo Kho và Booking. Dùng ở 3 lúc - plan việc rủi ro trước khi gửi Đức, diff PR có code trước khi merge, kết luận về nguyên nhân hay số đo trước khi báo. Gồm cách gọi từ phiên trên Mac và từ thread cloud (Remote Control), cách xử lý kết quả, dòng ghi vào PR.
---

# Nhờ Gemini Neon soát

Đức chốt ngày 24/11/2026: mọi việc ở repo Kho (`lichihouse/Quan-ly-Kho`) và Booking đều qua thêm một lượt soát của Gemini 4 Neon. Claude vẫn làm chính. Neon chỉ đọc nội dung Claude gửi rồi nêu lỗi.

Neon là **người soát thứ hai, không phải cổng chặn**. Nếu Mac tắt, Neon hết hạn mức hay báo lỗi thì bỏ qua và ghi lý do. Không để việc đứng chờ Neon, và không nhờ Đức bấm gì.

Đức đã chọn dùng tài khoản Antigravity gói cá nhân và tự chịu rủi ro điều khoản của Google. Không hỏi lại chuyện này.

## 1. Khi nào gọi

| Lúc | Gửi gì cho Neon |
|---|---|
| Plan việc rủi ro (tiền, VAT, giá, công nợ, allocation, quyền, DB, deploy): sau lượt soát của Claude, trước khi gửi Đức | Toàn văn plan, kèm các đoạn code mà plan dựa vào (file:line) |
| Mọi PR có code: sau khi reviewer của repo báo sạch HIGH và MED, trước khi merge | Diff của PR (bỏ lockfile, file sinh, ảnh), kèm 2-3 câu nói PR làm gì |
| Kết luận về nguyên nhân lỗi, kết luận dựa trên số đo, hoặc đề xuất việc khó đảo ngược: trước khi báo Đức | Kết luận kèm bằng chứng thô (lệnh, output, file:line) |

Không cần gọi Neon khi PR chỉ đổi docs hay markdown, hoặc khi chỉ trả lời câu hỏi thường.

Chỉ phiên chính gọi Neon. Subagent không gọi.

## 2. Cách gọi

Chỉ có một cửa để gọi Neon: script `/Users/hiuduc/.claude/neon-soat.sh` trên Mac của Đức.

- Script đọc nội dung từ stdin và tự thêm lời dặn: "chỉ soát, trả HIGH/MED/LOW, không có lỗi thì ghi KHONG_CO_LOI".
- Script gọi `gemini-4-neon` qua `t3`, chạy trong thư mục trống `~/neon-soat` (project T3 tên `neon-soat`). Vì vậy Neon không đọc hay sửa được code.
- Không giới hạn số lượt. Mỗi lượt mất khoảng 10 đến 60 giây.
- Đức đã cho phép sẵn `Bash(bash /Users/hiuduc/.claude/neon-soat.sh:*)`, nên lệnh chạy thẳng, không hỏi.

Không gọi `t3` hay `agy` trực tiếp: auto mode chặn hai lệnh này, và Đức chỉ mở quyền cho script.

Nếu script mất hoặc hỏng (lỗi `No such file`, hoặc `No T3 Code project matches`), Đức cài lại bằng `cai-tren-mac.sh` trong thư mục skill này (Đức tự chạy trong Terminal, vì script này sửa quyền). Không tự cài.

### a. Phiên đang chạy trên Mac (Remote Control, Claude Desktop, T3)

Luôn đi theo 3 bước. Mỗi bước là một lệnh riêng, không nối bằng ống `|`: lỗi ở giữa ống sẽ bị nuốt mất, và quyền allow chỉ phủ lệnh bắt đầu bằng `bash /Users/hiuduc/.claude/neon-soat.sh`.

1. Dùng tool Write ghi bối cảnh 2-3 câu vào `/tmp/neon-boi-canh.md`. Không ghi bằng `echo "..."`, vì shell sẽ bung `$VAR` và chạy `` `...` `` có trong nội dung.
2. Ghi nội dung cần soát vào `/tmp/neon-noi-dung.md`:
   - Plan hay kết luận: dùng tool Write.
   - Diff nhánh đang làm:
     ```bash
     git fetch origin && git diff origin/<nhánh gốc>...HEAD -- . ':(exclude)pnpm-lock.yaml' ':(exclude,glob)**/generated/**' ':(exclude,glob)**/*.png' > /tmp/neon-noi-dung.md && test -s /tmp/neon-noi-dung.md && echo DIFF_OK
     ```
     Không thấy `DIFF_OK` thì dừng. Nguyên nhân là diff rỗng hoặc sai ref. Đừng gửi cho Neon, vì nó sẽ trả `KHONG_CO_LOI` giả.
3. Gộp hai file rồi gọi Neon:
   ```bash
   cat /tmp/neon-boi-canh.md /tmp/neon-noi-dung.md > /tmp/neon-input.md
   ```
   ```bash
   bash /Users/hiuduc/.claude/neon-soat.sh < /tmp/neon-input.md
   ```

### b. Thread cloud (thread Project của claude.ai, có tool `start_remote_control`)

1. Gọi `start_remote_control`:
   - `folder` là repo trên Mac: `/Users/hiuduc/Projects/Quan-ly-Kho` hoặc `/Users/hiuduc/Projects/Booking`. Đức đã duyệt sẵn hai thư mục này, nên không cần ai bấm.
   - `instructions` theo mẫu bên dưới.
2. Kết quả về dưới dạng tin nhắn từ phiên trên Mac.
3. Luôn gọi `stop_remote_control`, kể cả khi lệnh lỗi hoặc Mac không trả lời. Lý do: trong lúc Remote Control chạy, các tool thư mục của thread bị khoá.

Mẫu `instructions`:

```
Làm đúng các bước dưới, không sửa file nào khác. Báo NGUYÊN VĂN đầu ra và exit code của từng lệnh. Lệnh nào lỗi thì dừng và báo lỗi đó.
1. Dùng tool Write ghi phần nằm giữa ===BOI_CANH=== và ===HET=== vào /tmp/neon-boi-canh.md.
2. <Diff PR:> chạy trong <thư mục repo>:
   git fetch origin && git diff origin/<nhánh gốc>...origin/<nhánh> -- . ':(exclude)pnpm-lock.yaml' ':(exclude,glob)**/generated/**' ':(exclude,glob)**/*.png' > /tmp/neon-noi-dung.md && test -s /tmp/neon-noi-dung.md && echo DIFF_OK
   <Plan / kết luận:> dùng tool Write ghi phần nằm giữa ===NOI_DUNG=== và ===HET=== vào /tmp/neon-noi-dung.md.
3. cat /tmp/neon-boi-canh.md /tmp/neon-noi-dung.md > /tmp/neon-input.md
4. bash /Users/hiuduc/.claude/neon-soat.sh < /tmp/neon-input.md
===BOI_CANH===
<2-3 câu: repo, PR làm gì, soát gì>
===HET===
```

Nếu plan dài quá 30 KB: lưu thành file trên nhánh rồi push. Ở bước 2, thay bằng lệnh `git fetch origin && git show origin/<nhánh>:<đường dẫn> > /tmp/neon-noi-dung.md`.

### c. Không gọi được

Gặp một trong các trường hợp sau thì bỏ qua và ghi lý do. Chỉ thử lại 1 lần, và chỉ khi lỗi có thể tự hết (Mac chưa trả lời, lỗi mạng). Thiếu tool, hết hạn mức hay diff rỗng thì không thử lại.
- Không có `start_remote_control`, và phiên cũng không chạy trên Mac.
- Mac không trả lời trong 2 phút, hoặc Neon chạy quá 10 phút. Script không tự cắt giờ, vì Đức muốn không giới hạn; phiên gọi tự quyết bỏ qua.
- Script trả exit code khác 0.
- Đầu ra báo lỗi hạn mức (`quota`, `RESOURCE_EXHAUSTED`, `429`), hoặc đầu ra không có dòng HIGH/MED/LOW nào và cũng không có `KHONG_CO_LOI`.

## 3. Không gửi cho Neon

- File `.env`, khoá, mật khẩu, token, chuỗi kết nối DB.
- Dữ liệu khách hàng thật: tên, số điện thoại, địa chỉ.

Nếu diff chứa những thứ này thì loại file đó ra bằng `':(exclude)<đường dẫn>'`.

## 4. Xử lý kết quả

- Đối chiếu từng lỗi Neon nêu với code thật: Read đúng file:line, chạy test nếu cần. Neon chỉ thấy phần nội dung được gửi, nên dễ báo nhầm vì thiếu ngữ cảnh.
- Lỗi đúng: sửa, rồi chạy lại cổng máy của repo. Không cần gọi Neon lần nữa, trừ khi phần sửa dài hơn 50 dòng.
- Lỗi sai: bác, ghi một câu lý do.
- Neon bắt được lỗi mà reviewer của Claude bỏ sót: coi là lỗi lọt cổng theo AGENTS.md của repo, và thêm chốt chặn cho loại lỗi đó.

## 5. Ghi lại

PR có code: thêm một dòng vào khối DoD, ngay dưới dòng `- review:`, theo một trong ba dạng:

```
- neon: HIGH=<n> MED=<n> LOW=<n> · đã sửa: <...> · bác: <... vì ...>
- neon: KHONG_CO_LOI
- neon: bỏ qua (<lý do>)
```

Plan hay kết luận gửi Đức: thêm một câu "Neon đã soát: ..." hoặc "Neon bỏ qua vì ...". Không dán nguyên văn đầu ra của Neon cho Đức.

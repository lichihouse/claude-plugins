# Skill kiến thức lichi

Plugin lichi mang hai skill tài liệu: `lichi:shopee-open-api` (Shopee Open Platform v2) và `lichi:tiktok-shop-api` (TikTok Shop Partner Center). Người dùng hỏi về API sàn hoặc viết code gọi sàn thì model gọi skill và trả lời theo tài liệu trong thư mục skill, không theo trí nhớ.

## Sub-features

- `shopee-trigger` câu hỏi API Shopee làm model gọi `Skill lichi:shopee-open-api` rồi Read file dưới `plugins/lichi/skills/shopee-open-api/`.
- `tiktok-trigger` tương tự cho TikTok Shop.
- `no-trigger` câu hỏi không liên quan sàn không gọi hai skill này.

## How to get to it (user POV)

- Hỏi "API Shopee nào lấy tiền thực nhận (escrow) của một đơn?".
- Hỏi "TikTok Shop API nào lấy danh sách đơn hoàn, version nào?".
- Gõ thẳng `/lichi:shopee-open-api`.

## Driving it with control-plugins

Preconditions:

- `$CP doctor --probe` in `DOCTOR OK`.

- **Shopee.** Run `$CP drive shopee --model sonnet --max-turns 6 -- "API Shopee v2 nào trả tiền thực nhận (escrow) của một đơn? Nêu đúng path endpoint."` Summary có `tool Skill lichi:shopee-open-api` và ít nhất một `tool Read .../plugins/lichi/skills/shopee-open-api/...`; câu trả lời nêu một path `/api/v2/payment/...`. Grep path đó trong `plugins/lichi/skills/shopee-open-api` phải thấy.
- **TikTok.** Run `$CP drive tiktok --model sonnet --max-turns 6 -- "TikTok Shop API nào lấy danh sách đơn hoàn (return)? Nêu path và version."` Có `tool Skill lichi:tiktok-shop-api` và Read dưới `plugins/lichi/skills/tiktok-shop-api/`.
- **Không gọi nhầm.** Run `$CP drive no-skill --model sonnet --max-turns 2 -- "2+2 bằng mấy?"`. Không có `tool Skill`.

## Gotchas

- Path endpoint trong câu trả lời chỉ là bằng chứng khi grep thấy nó trong file skill. Model có thể nhớ path từ huấn luyện mà không mở skill.
- Skill nạp qua `--plugin-dir` có tiền tố `lichi:`. Nếu summary ghi `Skill shopee-open-api` không tiền tố thì đó là bản cài kiểu project skill, không phải plugin.

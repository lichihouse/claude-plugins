# Plugin Claude Code của Lichi House

Marketplace plugin Claude Code, gắn theo **tài khoản claude.ai** nên dùng được ở mọi repo: Claude Code trên web, tab Code trong app Desktop / mobile, và terminal.

| Plugin | Mô tả |
|---|---|
| [`pstack`](plugins/pstack/) | pstack của poteto (Lauren Tan) port từ Cursor sang Claude Code: `/pstack:poteto-mode`, how / why, arena / swarm / interrogate, 23 principle, playbook có kiểm chứng. |

## Gắn vào tài khoản (làm một lần)

1. Mở claude.ai bằng **trình duyệt** → **Customize** → tab **Plugins**.
2. **Personal plugins** → **+** → **Add marketplace** → **Add from a repository** → `lichihouse/claude-plugins`.
3. Cài **pstack** từ marketplace này.

Từ đó mọi phiên Claude Code của tài khoản tự nạp plugin (terminal cần bản ≥ 2.1.273 và đăng nhập claude.ai). Chi tiết, cách dự phòng và cách dùng: [`plugins/pstack/README.md`](plugins/pstack/README.md).

## Kiểm tra trước khi push

```bash
claude plugin validate --strict .
claude plugin validate --strict plugins/pstack
bash plugins/pstack/tools/lint-port.sh
bash plugins/pstack/tools/test-hooks.sh
```

CI (`.github/workflows/validate.yml`) chạy đúng các lệnh này cho mỗi push và PR.

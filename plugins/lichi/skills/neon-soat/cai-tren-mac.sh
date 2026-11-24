#!/bin/bash
# Cài (hoặc cài lại) cửa gọi Gemini Neon trên Mac của Đức. Đức tự chạy trong Terminal:
#   bash cai-tren-mac.sh
# Đã cài lần đầu 24/11/2026. Cần T3 Code đã đăng nhập Antigravity.
set -eu
mkdir -p ~/neon-soat ~/.claude
cat > ~/.claude/neon-soat.sh <<'SH'
#!/bin/bash
# Nho Gemini 4 Neon soat noi dung doc tu stdin.
set -u
NOI_DUNG=$(cat)
cd ~/neon-soat || exit 1
printf '%s\n\n%s\n' "Ban la nguoi soat thu hai. Chi doc noi dung ben duoi, KHONG chay lenh, KHONG doc hay sua file. Tra loi tieng Viet, ngan, liet ke loi theo HIGH/MED/LOW, moi loi 1-2 dong kem ly do. Khong co loi thi ghi: KHONG_CO_LOI." "$NOI_DUNG" \
  | t3 thread start --provider antigravity --model gemini-4-neon --title "Neon soat $(date +%H%M)" --wait . -
SH
chmod +x ~/.claude/neon-soat.sh
t3 project add --title neon-soat "$HOME/neon-soat" 2>&1 || true
python3 - <<'PY'
import json, os, shutil, time
p = os.path.expanduser("~/.claude/settings.json")
s = json.load(open(p)) if os.path.exists(p) else {}
if os.path.exists(p):
    shutil.copy(p, p + ".bak-" + time.strftime("%Y-%m-%d"))
rule = "Bash(bash " + os.path.expanduser("~/.claude/neon-soat.sh") + ":*)"
allow = s.setdefault("permissions", {}).setdefault("allow", [])
if rule not in allow:
    allow.append(rule)
json.dump(s, open(p, "w"), ensure_ascii=False, indent=2)
json.load(open(p))
print("XONG quyen:", rule)
PY
echo "Tra loi dung 1 cau: 2+2 bang may?" | bash ~/.claude/neon-soat.sh

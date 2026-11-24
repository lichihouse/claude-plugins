#!/bin/bash
# Cài (hoặc cài lại) cửa gọi Gemini Neon trên Mac của Đức. Đức tự chạy trong Terminal:
#   bash <thư mục skill neon-soat>/cai-tren-mac.sh   (cần neon-soat.sh nằm cùng thư mục)
# Đã cài lần đầu 24/11/2026. Cần T3 Code đã đăng nhập Antigravity.
set -eu
command -v t3 >/dev/null || { echo 'Chua co t3: cai T3 Code va dang nhap Antigravity truoc.'; exit 1; }
mkdir -p ~/neon-soat ~/.claude
cp "$(dirname "$0")/neon-soat.sh" ~/.claude/neon-soat.sh
chmod +x ~/.claude/neon-soat.sh
out=$(t3 project add --title neon-soat "$HOME/neon-soat" 2>&1) || echo "$out" | grep -qi "exist" || { echo "$out"; exit 1; }
echo "$out"
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
printf '%s\n' "Soat ham sau (tinh tong tien don): function tong(a){let t=0;for(let i=1;i<a.length;i++)t+=a[i];return t}" | bash ~/.claude/neon-soat.sh

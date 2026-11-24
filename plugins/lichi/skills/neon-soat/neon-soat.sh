#!/bin/bash
# Nhờ Gemini 4 Neon soát. Bản cài trên Mac: ~/.claude/neon-soat.sh (cai-tren-mac.sh chép file này sang).
#
#   neon-soat.sh < brief.md
#       Neon chỉ đọc brief, chạy trong thư mục trống ~/neon-soat.
#   neon-soat.sh <thư mục repo> <nhánh> [nhánh gốc] < brief.md
#       Neon chạy trong một git worktree riêng của repo, checkout đúng origin/<nhánh>,
#       đọc được cả repo, tự xem `git diff origin/<nhánh gốc>...HEAD`, chạy được test.
#       Worktree riêng nên không đụng thư mục làm việc của Đức.
#
# Exit: 0 xong · 1 t3 lỗi · 2 Neon hỏi lại · 4 brief rỗng · 5 sai repo / nhánh.
set -u
BRIEF=$(cat)
[ "${#BRIEF}" -ge 20 ] || { echo "NOI_DUNG_RONG: brief qua ngan, khong co gi de soat"; exit 4; }

LUAT_CHUNG='Ban la nguoi soat thu hai, doc lap voi Claude (nguoi viet code / plan). Viec cua ban la TIM LOI THAT, khong phai xac nhan la dung. Moi ket luan Claude dua ra deu chua chac, tu kiem lai.

Duoc lam: doc moi file, git log / git diff / git show, chay test va lenh chi doc.
Khong duoc: sua file trong repo, git commit, git push, goi API ngoai, doc file .env hay khoa bi mat, ghi vao bat ky DB nao.

Tra loi tieng Viet. Moi loi mot muc, dung mau:
[HIGH|MED|LOW] <file:dong>  <tom tat 1 dong>
  Kich ban: <input / thao tac cu the -> ket qua sai cu the>
  Bang chung: <da doc file nao / chay lenh nao, ket qua>
  Sua: <cach sua ngan>
HIGH = sai tien / so lieu / mat du lieu / lo quyen / sap luong chinh. MED = sai o ca bien co that, hoac thieu test cho ca rui ro. LOW = nho, de sau.
Khong neu loi style, dat ten, format. Chua chac thi mo dau dong bang NGHI:. Thieu ngu canh de ket luan thi ghi CAN_THEM: <can gi>.
Dong cuoi cung bat buoc: KET_LUAN: HIGH=<n> MED=<n> LOW=<n>  (khong co loi thi ghi KET_LUAN: KHONG_CO_LOI).'

MODEL=(--provider antigravity --model gemini-4-neon --option effort=medium)
TITLE="Neon soat $(date +%m%d-%H%M)"

if [ $# -eq 0 ]; then
  cd ~/neon-soat || exit 1
  printf '%s\n\n--- BRIEF ---\n%s\n' "$LUAT_CHUNG" "$BRIEF" \
    | t3 thread start "${MODEL[@]}" --title "$TITLE" --wait . -
  exit $?
fi

REPO=$1
NHANH=${2:?thieu ten nhanh}
GOC=${3:-}
[ -d "$REPO/.git" ] || [ -f "$REPO/.git" ] || { echo "SAI_REPO: $REPO khong phai repo git"; exit 5; }
git -C "$REPO" fetch --quiet origin || { echo "SAI_REPO: git fetch loi"; exit 5; }
REF=$(git -C "$REPO" rev-parse --verify --quiet "origin/$NHANH^{commit}") \
  || { echo "SAI_NHANH: khong co origin/$NHANH"; exit 5; }
if [ -z "$GOC" ]; then
  GOC=$(git -C "$REPO" symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null | sed 's#^origin/##')
  GOC=${GOC:-master}
fi
git -C "$REPO" rev-parse --verify --quiet "origin/$GOC^{commit}" >/dev/null \
  || { echo "SAI_NHANH: khong co origin/$GOC"; exit 5; }
SO_DONG=$(git -C "$REPO" diff --numstat "origin/$GOC...$REF" | awk '{s+=$1+$2} END {print s+0}')
[ "$SO_DONG" -gt 0 ] || { echo "NOI_DUNG_RONG: origin/$GOC...origin/$NHANH khong co thay doi"; exit 4; }

VI_TRI="Ban dang o mot git worktree rieng, HEAD = origin/$NHANH ($REF). Nhanh goc: origin/$GOC.
Xem thay doi: git diff origin/$GOC...HEAD (tong $SO_DONG dong them + xoa). Doc AGENTS.md o goc repo (va AGENTS.md long trong thu muc bi doi) truoc: day la luat nghiep vu va quy uoc cua repo, loi vi pham luat do la loi that.
Doc ca code xung quanh: ham goi va ham bi goi cua cho bi doi, test lien quan, schema DB neu dung toi."

printf '%s\n\n%s\n\n--- BRIEF ---\n%s\n' "$LUAT_CHUNG" "$VI_TRI" "$BRIEF" \
  | t3 thread start "${MODEL[@]}" --title "$TITLE $NHANH" --worktree "$REF" --wait "$REPO" -

#!/usr/bin/env python3
"""Tải lại toàn bộ tài liệu Shopee Open Platform v2 (API reference, Developer Guide, Push Mechanism)
và sinh lại các file Markdown tham chiếu. Chỉ ĐỌC trang tài liệu công khai, không gọi API shop.

Cách chạy:  python3 -I fetch_shopee_docs.py <thư_mục_ra>      (cần curl + pandoc)
Kết quả:    <ra>/raw/{modules,guides,pushcat}.json, raw/api/*.json, raw/guide/*.json, raw/push/*.json
            <ra>/reference/api/<Module>.md, reference/push.md, reference/guides/*.md, reference/index.json
"""
import html, json, os, re, subprocess, sys, urllib.parse
from concurrent.futures import ThreadPoolExecutor

BASE = "https://open.shopee.com/opservice/api/v1"
OUT = sys.argv[1] if len(sys.argv) > 1 else "shopee-docs"
RAW, REF = os.path.join(OUT, "raw"), os.path.join(OUT, "reference")
for d in ("api", "guide", "push"): os.makedirs(os.path.join(RAW, d), exist_ok=True)
for d in ("api", "guides"): os.makedirs(os.path.join(REF, d), exist_ok=True)

def get(url, path):
    subprocess.run(["curl", "-sS", "-m", "40", "--retry", "3", "-o", path, url], check=False)
    return json.load(open(path))

def clean(s):
    s = re.sub(r"<br\s*/?>", " ", s or ""); s = re.sub(r"<[^>]+>", " ", s)
    return re.sub(r"\s+", " ", html.unescape(s)).strip().replace("|", "\\|")

def to_md(h):
    md = subprocess.run(["pandoc", "-f", "html", "-t", "gfm-raw_html", "--wrap=none"], input=h or "", capture_output=True, text=True).stdout
    return re.sub(r"\n{3,}", "\n\n", md.replace(" ", " "))

def jload(v, default):
    if isinstance(v, (dict, list)): return v
    try: return json.loads(v) if v else default
    except Exception: return default

def rows(ps, req, depth=0, out=None):
    out = [] if out is None else out
    for x in ps or []:
        if depth == 0 and not req and x.get("name") in ("error", "message", "request_id", "warning"): continue
        nm = ("↳" * depth + " " if depth else "") + x.get("name", "")
        cols = [f"`{nm}`", x.get("type", "")]
        if req: cols.append("✔" if str(x.get("required")).lower() == "true" else "")
        cols.append(clean(x.get("description", ""))[:700])
        out.append("| " + " | ".join(cols) + " |")
        rows(x.get("children"), req, depth + 1, out)
    return out

# 1) API reference
mods = get(f"{BASE}/doc/module/?version=2", os.path.join(RAW, "modules.json"))["modules"]
index = {m["module_name"]: [i["name"] for i in m["items"]] for m in mods if m["type"] == 1}
names = [n for v in index.values() for n in v]
def fetch_api(n):
    get(f"{BASE}/doc/api/?version=2&api_name={urllib.parse.quote(n)}", os.path.join(RAW, "api", f"{n}.json"))
with ThreadPoolExecutor(8) as ex: list(ex.map(fetch_api, names))
json.dump(index, open(os.path.join(REF, "index.json"), "w"), indent=1, ensure_ascii=False)
for mod, ns in index.items():
    L = [f"# Module {mod} ({len(ns)} API)", "", "Tự sinh từ open.shopee.com/documents/v2. Mô tả giữ nguyên tiếng Anh. ✔ = bắt buộc, `↳` = trường con.", ""]
    for n in ns:
        d = json.load(open(os.path.join(RAW, "api", f"{n}.json")))
        p = jload(d.get("params"), {}); df = jload(d.get("define"), {"content": d.get("define") or ""})
        method = {1: "POST", 2: "GET"}.get(d.get("method"), str(d.get("method")))
        L += [f"## {n}", f"`{method} {d.get('path','')}` · loại: {d.get('api_type','')} · app được gọi: {', '.join(d.get('api_permission') or [])}", "",
              clean(df.get("content", "") if isinstance(df, dict) else df), ""]
        rl = d.get("rate_limit")
        if rl and rl != "[0, 0, 0]": L += [f"Rate limit: {rl}", ""]
        ul = d.get("update_log_list") or []
        if ul: L += ["Lịch sử cập nhật: " + "; ".join(f"{u['date']}: {clean(u['content'])}" for u in ul[:5]), ""]
        errs = [e.get("description") for e in d.get("error_list") or [] if e.get("description")]
        rq = rows(p.get("request_params"), True)
        if rq: L += ["**Request**", "", "| Tham số | Kiểu | Bắt buộc | Mô tả |", "|---|---|---|---|"] + rq + [""]
        rs = rows(p.get("response_params"), False)
        if rs: L += ["**Response**", "", "| Trường | Kiểu | Mô tả |", "|---|---|---|"] + rs + [""]
        if errs: L += ["Lỗi riêng: " + " · ".join(clean(e) for e in errs[:15]), ""]
    open(os.path.join(REF, "api", f"{re.sub(r'[^A-Za-z0-9]+','-',mod)}.md"), "w").write("\n".join(L))

# 2) Developer Guide
gl = get(f"{BASE}/developer_guide/list?language_code=en", os.path.join(RAW, "guides.json"))["developer_guide_list"]
docs = []
def walk(xs, path):
    for x in xs:
        if x["item_type"] == 2: docs.append((x["item_id"], path))
        walk(x.get("children") or [], path + [x["item_name"]] if x["item_type"] == 1 else path)
walk(gl, [])
def fetch_guide(i):
    get(f"{BASE}/developer_guide/detail?document_id={i}&language_code=en", os.path.join(RAW, "guide", f"{i}.json"))
with ThreadPoolExecutor(8) as ex: list(ex.map(fetch_guide, [i for i, _ in docs]))
for i, path in docs:
    g = json.load(open(os.path.join(RAW, "guide", f"{i}.json")))
    if "title" not in g: continue
    slug = re.sub(r"[^a-z0-9]+", "-", g["title"].lower()).strip("-")[:60]
    open(os.path.join(REF, "guides", f"{i:04d}-{slug}.md"), "w").write(
        f"# {g['title']}\n\n> Nhóm: {' / '.join(path)} · nguồn: https://open.shopee.com/developer-guide/{i}\n\n{to_md(g.get('content'))}")

# 3) Push Mechanism
cats = get(f"{BASE}/push/category", os.path.join(RAW, "pushcat.json"))["category"]
L = ["# Shopee Push Mechanism (webhook)", "", "Tự sinh từ open.shopee.com/push-mechanism. `code` = trường code trong body push. retry = số giây chờ giữa các lần gửi lại.", ""]
for c in cats:
    L += [f"## {c['category_name']}", ""]
    for p in c["push"]:
        d = get(f"{BASE}/push/doc?push_api_id={p['push_api_id']}", os.path.join(RAW, "push", f"{p['push_api_id']}.json"))["push_api"]
        pc = jload(d.get("push_content"), {}); pc = pc.get("content", "") if isinstance(pc, dict) else d.get("push_content")
        L += [f"### {d['push_api_name']} (code {d['push_code']})", clean(d.get("description")), "",
              f"timeout {d.get('push_timeout')}s · retry {d.get('retry_strategy')} · guarantee {d.get('push_guarantee')}", "",
              "| Trường | Kiểu | Mô tả |", "|---|---|---|"] + rows(jload(d.get("push_params"), []), False) + ["", "Ví dụ:", "", to_md(pc).strip()[:3000], ""]
open(os.path.join(REF, "push.md"), "w").write("\n".join(L))
print(f"API {len(names)} · guide {len(docs)} · push {sum(len(c['push']) for c in cats)} → {OUT}")

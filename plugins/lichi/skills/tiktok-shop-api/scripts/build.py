#!/usr/bin/env python3
"""Build the TikTok Shop API knowledge base from raw Partner Center JSON.
Usage: python3 -I build.py <raw_docs_dir> <tree_json> <out_dir>
raw_docs_dir: one JSON per document written by fetch-docs.js."""
import json, glob, os, re, sys, datetime, collections

RAW, TREE, OUT = sys.argv[1], sys.argv[2], sys.argv[3]
DOC = 'https://partner.tiktokshop.com/docv2/page/'
METH = {'1': 'POST', '2': 'GET', '3': 'PUT', '4': 'DELETE', '5': 'PATCH'}

def slug(s):
    return re.sub(r'[^a-z0-9]+', '-', s.lower()).strip('-')

def clean(md):
    md = re.sub(r'<!--.*?-->', '', md, flags=re.S)
    md = re.sub(r'<img [^>]*src="([^"]+)"[^>]*/?>', r'(ảnh: \1)', md)
    md = re.sub(r'</?(div|span|strong|br|p|font)[^>]*>', '', md)
    md = re.sub(r'\n{3,}', '\n\n', md)
    md = re.sub(r'^#', '###', md, flags=re.M)   # demote headings under the API heading
    return md.strip()

def day(ts):
    return datetime.datetime.fromtimestamp(int(ts), datetime.timezone.utc).strftime('%Y-%m-%d') if ts and str(ts).isdigit() else ''

def leaf_fields(lst):
    out, stack = [], []
    for e in lst or []:
        n = e['name']; d = len(n) - len(n.lstrip('^')); n = n.lstrip('^')
        stack = stack[:d] + [n]
        out.append({'path': '.'.join(stack), 'type': e.get('type', ''), 'desc': (e.get('desc') or '')[:300]})
    return out

docs = [json.load(open(f)) for f in glob.glob(os.path.join(RAW, '*.json'))]
tree = json.load(open(TREE))
order = {n['document_id']: i for i, n in enumerate(tree)}
docs.sort(key=lambda x: order.get(x['id'], 1e9))

SKIP_GUIDES = {'Developing for the TikTok Shop App Store', 'TikTok Shop App Scoring and Tiering'}  # app-store publishing, not relevant to a seller's in-house app
FULL_CHANGELOG_FROM = '2025'  # older entries stay in the index only

def w(path, text):
    p = os.path.join(OUT, 'reference', path) if not path.startswith('04-') else os.path.join(OUT, path); os.makedirs(os.path.dirname(p), exist_ok=True)
    open(p, 'w').write(text)

stamp = datetime.date.today().isoformat()
hdr = f'> Nguồn: TikTok Shop Partner Center docv2, tải về {stamp} bằng `scripts/fetch-docs.js`. Không sửa tay: chạy lại `scripts/build.py`.\n\n'

# ---------- API Reference ----------
catalog, by_group = [], collections.defaultdict(list)
for x in docs:
    if x['top'] != 'API Reference':
        continue
    parts = x['path'].split(' > ')
    group = parts[1]
    m = (x.get('meta') or {}).get('data', {}).get('document_api_meta') or {}
    path = m.get('interface_path') or ''
    content = x['detail']['data']['content']
    if not path:
        mm = re.search(r'# Path: (\S+)', content); path = mm.group(1) if mm else ''
    ver = (re.search(r'/(\d{6})/', path) or [None, ''])[1]
    scopes = [s.get('scope_key') for s in (m.get('scope_list') or []) if s.get('scope_key')]
    entry = dict(group=group, name=x['name'].strip(), method=METH.get(str(m.get('method') or x.get('method') or ''), '') if path else '',
                 path=path, version=ver, scopes=scopes, shop_cipher=m.get('is_shop_chiper_exist') == 'True',
                 doc=DOC + x['key'], updated=day(x['update_time']), kind='api' if path else 'overview',
                 query=[q['name'] for q in (m.get('request_query_param') or []) if q['name'] not in ('app_key', 'sign', 'timestamp', 'shop_cipher')],
                 response_fields=[f['path'] for f in leaf_fields(m.get('response_param'))])
    catalog.append(entry)
    by_group[group].append((entry, content))

w('catalog/api-catalog.json', json.dumps(catalog, ensure_ascii=False, indent=1))
idx = ['# Danh mục API TikTok Shop (bản mới nhất trên Partner Center)\n', hdr,
       f'Tổng: **{sum(1 for c in catalog if c["kind"]=="api")} API** + {sum(1 for c in catalog if c["kind"]!="api")} trang tổng quan, {len(by_group)} nhóm. '
       'Partner Center chỉ hiện **phiên bản mới nhất** của mỗi API; bản cũ hơn có thể vẫn chạy nhưng không còn trong mục lục.\n',
       'Chi tiết từng API (tham số, response, lỗi): `reference/api/<nhóm>.md`. Dạng máy đọc: `reference/catalog/api-catalog.json`.\n']
for g, items in by_group.items():
    idx.append(f'\n## {g} → `reference/api/{slug(g)}.md`\n\n| API | Method | Path | Scope | shop_cipher | Cập nhật |\n|---|---|---|---|---|---|')
    for e, _ in items:
        if e['kind'] != 'api':
            idx.append(f'| [{e["name"]}]({e["doc"]}) (tổng quan) | | | | | {e["updated"]} |'); continue
        idx.append(f'| [{e["name"]}]({e["doc"]}) | {e["method"]} | `{e["path"]}` | {", ".join(e["scopes"])} | {"có" if e["shop_cipher"] else ""} | {e["updated"]} |')
    body = [f'# {g} — tài liệu chi tiết\n', hdr]
    for e, content in items:
        head = f'\n\n---\n\n## {e["name"]}' + (f' — `{e["method"]} {e["path"]}`' if e['path'] else '')
        meta = f'\n\nDoc: {e["doc"]} · cập nhật {e["updated"]}' + (f' · scope: {", ".join(e["scopes"])}' if e['scopes'] else '')
        body.append(head + meta + '\n\n' + clean(content))
    w(f'api/{slug(g)}.md', '\n'.join(body) + '\n')
w('04-muc-luc-api.md', '\n'.join(idx) + '\n')

# ---------- Webhooks ----------
wh = [x for x in docs if x['top'] == 'Webhooks']
wi = ['# Webhook topics TikTok Shop\n', hdr, '| Nhóm | Topic (số = `type` trong payload) | Doc |\n|---|---|---|']
wb = ['# Webhook — nội dung chi tiết\n', hdr]
for x in wh:
    parts = x['path'].split(' > ')
    g = parts[1] if len(parts) > 2 else '(chung)'
    wi.append(f'| {g} | {x["name"].strip()} | {DOC + x["key"]} |')
    wb.append(f'\n\n---\n\n## {g} > {x["name"].strip()}\n\nDoc: {DOC + x["key"]} · cập nhật {day(x["update_time"])}\n\n' + clean(x['detail']['data']['content']))
w('webhooks/index.md', '\n'.join(wi) + '\n')
w('webhooks/details.md', '\n'.join(wb) + '\n')

# ---------- Changelog ----------
cl = [x for x in docs if x['top'] == 'Changelog']
cl.sort(key=lambda x: -int(x['update_time'] or 0))
ci = ['# Changelog TikTok Shop API (mới nhất trước)\n', hdr, 'Ngày = ngày cập nhật trang. Nội dung đầy đủ (từ 2025): `reference/changelog/<năm>.md`; bản cũ hơn mở link.\n',
      '| Ngày | Nhóm | Tiêu đề |\n|---|---|---|']
by_year = collections.defaultdict(list)
for x in cl:
    d = day(x['update_time']); parts = x['path'].split(' > ')
    g = parts[1] if len(parts) > 2 else ''
    ci.append(f'| {d} | {g} | [{x["name"].strip()}]({DOC + x["key"]}) |')
    if d[:4] >= FULL_CHANGELOG_FROM:
        by_year[d[:4]].append(f'\n\n---\n\n## {d} · {g} · {x["name"].strip()}\n\nDoc: {DOC + x["key"]}\n\n' + clean(x['detail']['data']['content']))
w('changelog/index.md', '\n'.join(ci) + '\n')
for y, parts in by_year.items():
    w(f'changelog/{y}.md', f'# Changelog {y}\n\n' + hdr + '\n'.join(parts) + '\n')

# ---------- Developer Guide ----------
dg = [x for x in docs if x['top'] == 'Developer Guide']
gi = ['# Developer Guide (hướng dẫn kỹ thuật: auth, ký request, webhook, lỗi chung...)\n', hdr, '| Mục | Trang | File |\n|---|---|---|']
by_sec = collections.defaultdict(list)
for x in dg:
    parts = x['path'].split(' > ')
    sec = parts[1] if len(parts) > 2 else 'General'
    if sec in SKIP_GUIDES:
        continue
    gi.append(f'| {" > ".join(parts[1:-1]) or sec} | [{x["name"].strip()}]({DOC + x["key"]}) | `reference/guides/{slug(sec)}.md` |')
    by_sec[sec].append(f'\n\n---\n\n## {" > ".join(parts[1:])}\n\nDoc: {DOC + x["key"]} · cập nhật {day(x["update_time"])}\n\n' + clean(x['detail']['data']['content']))
w('guides/index.md', '\n'.join(gi) + '\n')
for s, parts in by_sec.items():
    w(f'guides/{slug(s)}.md', f'# Developer Guide — {s}\n\n' + hdr + '\n'.join(parts) + '\n')
print('ok', len(catalog), len(wh), len(cl), len(dg))

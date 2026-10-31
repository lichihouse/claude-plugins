#!/usr/bin/env python3
"""Compare an OpenAPI snapshot split by first-level path (e.g. the TikTok toolkit skill
`tts-openapi-guide/references/oas/`) with reference/catalog/api-catalog.json.
Usage: python3 -I compare_oas.py <oas_dir> <api-catalog.json> > reference/oas-gap.md"""
import json, glob, os, re, sys, collections

OAS, CAT = sys.argv[1], sys.argv[2]
COMMON = {'app_key', 'sign', 'timestamp', 'shop_cipher'}

def base(p): return re.sub(r'\{[^}]+\}', '{}', re.sub(r'/\d{6}/', '/V/', p))
def ver(p): return re.search(r'/(\d{6})/', p).group(1)

def oas_fields(schema, root):
    out = set()
    def res(s):
        while '$ref' in s:
            s2 = root
            for k in s['$ref'].lstrip('#/').split('/'): s2 = s2[k]
            s = s2
        return s
    def walk(s, pre, dep=0):
        if dep > 12: return
        s = res(s)
        if s.get('type') == 'array' or 'items' in s: walk(s.get('items', {}), pre, dep + 1); return
        for k, v in (s.get('properties') or {}).items():
            p = f'{pre}.{k}' if pre else k; out.add(p); walk(v, p, dep + 1)
        for c in s.get('allOf', []): walk(c, pre, dep + 1)
    walk(schema, ''); return out

def leaves(s):
    s = {x[5:] if x.startswith('data.') else x for x in s}
    return sorted(x for x in s if not any(y.startswith(x + '.') for y in s) and x not in ('code', 'message', 'request_id', 'data'))

R = {}
for f in glob.glob(os.path.join(OAS, 'paths', '*.json')) or glob.glob(os.path.join(OAS, '*.json')):
    d = json.load(open(f))
    for p, ops in (d.get('paths') or {}).items():
        for m, op in ops.items():
            if m not in ('get', 'post', 'put', 'delete', 'patch'): continue
            sch = (((op.get('responses') or {}).get('200') or {}).get('content') or {}).get('application/json', {}).get('schema', {})
            R[(m.upper(), p)] = dict(resp=leaves(oas_fields(sch, d)), query={q.get('name') for q in op.get('parameters', []) if q.get('in') == 'query'} - COMMON)

W = {(c['method'], c['path']): c for c in json.load(open(CAT)) if c['kind'] == 'api'}
rb = collections.defaultdict(list)
for (m, p) in R: rb[(m, base(p))].append(p)
wbase = {(m, base(p)) for (m, p) in W}

print('# Chênh lệch: spec OAS cũ ↔ Partner Center (tự sinh bởi scripts/compare_oas.py)\n')
print(f'> OAS: {len(R)} operation. Partner Center: {len(W)} API (chỉ bản mới nhất). So response + query; trường liệt kê là trường lá, bỏ tiền tố `data.`.\n')
groups = collections.defaultdict(list); stat = collections.Counter()
for (m, p), w in W.items():
    if (m, p) in R: kind, ref = 'same', p
    elif (m, base(p)) in rb: kind, ref = 'newver', max(rb[(m, base(p))], key=ver)
    else: kind, ref = 'new', None
    groups[p.split('/')[1]].append((kind, m, p, w, ref))
for g in sorted(groups):
    lines = []
    for kind, m, p, w, ref in sorted(groups[g], key=lambda t: ({'new': 0, 'newver': 1, 'same': 2}[t[0]], t[2])):
        stat[kind] += 1
        if kind == 'new':
            lines.append(f'- **MỚI, OAS chưa có**: `{m} {p}` — {w["name"]}'); continue
        r = R[(m, ref)]; wl = leaves(w['response_fields'])
        add = [x for x in wl if x not in r['resp']]; rem = [x for x in r['resp'] if x not in wl]
        qa = sorted(set(w['query']) - r['query']); qr = sorted(r['query'] - set(w['query']))
        if kind == 'newver': lines.append(f'- **BẢN MỚI {ver(p)}** (OAS mới nhất {ver(ref)}): `{m} {p}` — {w["name"]}')
        elif add or rem or qa or qr: lines.append(f'- **Cùng bản, trường đổi**: `{m} {p}` — {w["name"]}')
        else: stat['identical'] += 1; continue
        for lab, v in (('+ response', add), ('− response', rem), ('+ query', qa), ('− query', qr)):
            if v: lines.append(f'  - {lab}: ' + ', '.join(f'`{x}`' for x in v))
    if lines: print(f'\n## {g}\n'); print('\n'.join(lines))
print('\n## Có trong OAS nhưng không còn trong mục lục Partner Center\n')
print('Không chắc là đã tắt: có thể chỉ hiện cho thị trường/loại app khác, hoặc là bản cũ. Hạn khai tử chính thức xem `reference/changelog/index.md`.\n')
ro = collections.defaultdict(list)
for (m, p) in sorted(R):
    if (m, base(p)) not in wbase: ro[p.split('/')[1]].append(f'`{m} {p}`')
for g, v in sorted(ro.items()): print(f'- **{g}** ({len(v)}): ' + ', '.join(v))
print(f'\n_Tổng: {stat["new"]} API mới, {stat["newver"]} bản mới, {stat["same"]} trùng bản ({stat["identical"]} giống hệt), {sum(len(v) for v in ro.values())} chỉ có trong OAS._')

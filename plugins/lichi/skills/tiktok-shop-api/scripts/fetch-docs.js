// Download every API Reference / Webhooks / Changelog / Developer Guide page from
// TikTok Shop Partner Center docv2 into <out>/ (default ./raw). Read-only, public docs.
// Usage: node scripts/fetch-docs.js [outDir]
// Needs Playwright with Chromium (plain curl gets "internal error" without the page's cookies).
const { chromium } = require('playwright');
const fs = require('fs');
const path = require('path');

const OUT = process.argv[2] || 'raw';
const TOPS = new Set(['API Reference', 'Webhooks', 'Changelog', 'Developer Guide']);
const BASE = 'https://partner.tiktokshop.com';

(async () => {
  fs.mkdirSync(path.join(OUT, 'docs'), { recursive: true });
  const browser = await chromium.launch();
  const page = await (await browser.newContext()).newPage();
  await page.goto(`${BASE}/docv2/page/get-authorized-shops-202309`, { waitUntil: 'networkidle', timeout: 90000 });

  const tree = await page.evaluate(async () =>
    (await fetch('/api/v1/document/tree?workspace_id=3&aid=359713&locale=en-US').then(r => r.json())).data.document_tree);
  fs.writeFileSync(path.join(OUT, 'tree.json'), JSON.stringify(tree));

  const byId = Object.fromEntries(tree.map(n => [n.document_id, n]));
  const trail = n => { const p = []; while (n) { p.unshift(n.name); n = byId[n.parent_id]; } return p; };
  const list = tree.filter(n => !n.is_dir).map(n => {
    const t = trail(n);
    return { top: t[0], path: t.join(' > '), key: n.document_path || n.document_id, id: n.document_id,
             name: n.name, update_time: n.update_time, method: n.api_method };
  }).filter(x => TOPS.has(x.top));

  let ok = 0, bad = 0;
  for (let i = 0; i < list.length; i += 8) {
    await Promise.all(list.slice(i, i + 8).map(async x => {
      const r = await page.evaluate(async x => {
        const get = u => fetch(u).then(r => r.json()).catch(e => ({ err: String(e) }));
        const out = { detail: await get(`/api/v1/document/detail?document_id=${encodeURIComponent(x.key)}&workspace_id=3&aid=359713&locale=en-US`) };
        if (x.top === 'API Reference') out.meta = await get(`/api/v1/document/api_meta?src_document_id=${encodeURIComponent(x.key)}&aid=359713&locale=en-US`);
        return out;
      }, x);
      if (r.detail && r.detail.code === 0) { ok++; fs.writeFileSync(path.join(OUT, 'docs', `${x.id}.json`), JSON.stringify({ ...x, ...r })); }
      else { bad++; console.error('failed', x.key, JSON.stringify(r.detail).slice(0, 150)); }
    }));
  }
  console.log(`saved ${ok}, failed ${bad} -> ${OUT}/docs`);
  await browser.close();
})();

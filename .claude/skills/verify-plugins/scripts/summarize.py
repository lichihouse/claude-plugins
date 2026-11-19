#!/usr/bin/env python3
"""Tóm tắt stream-json của một phiên Claude Code con thành bằng chứng đọc được.

  summarize.py <file.jsonl>                    tóm tắt: plugin nạp, hook, tool call, kết quả
  summarize.py --session <file.jsonl>          in session_id (để --resume và cleanup)
  summarize.py --check-probe <file> <pstack> <lichi>   exit 0 nếu probe đạt
"""
import json
import sys


def events(path):
    with open(path, encoding="utf-8") as fh:
        for line in fh:
            line = line.strip()
            if line:
                try:
                    yield json.loads(line)
                except json.JSONDecodeError:
                    pass


def init_of(evs):
    return next((e for e in evs if e.get("type") == "system" and e.get("subtype") == "init"), {})


def short(text, n=400):
    text = str(text).replace("\n", "⏎ ")
    return text if len(text) <= n else text[:n] + f"… (+{len(text) - n})"


def summarize(path):
    evs = list(events(path))
    init = init_of(evs)
    print(f"== {path}")
    print(f"session {init.get('session_id')}  model {init.get('model')}  cwd {init.get('cwd')}  claude {init.get('claude_code_version')}")
    for p in init.get("plugins", []):
        if p.get("name") in ("pstack", "lichi"):
            print(f"plugin  {p['name']} {p.get('version')} from {p.get('path')} [{p.get('source')}]")
    for w in init.get("plugin_warnings") or []:
        print(f"plugin-warning {short(w, 200)}")
    for e in evs:
        if e.get("type") == "system" and e.get("subtype") == "hook_response":
            out = (e.get("output") or e.get("stdout") or "").strip()
            print(f"hook    {e.get('hook_name')} exit={e.get('exit_code')} {e.get('outcome')}: {short(out, 300) if out else '(không in gì)'}")
    for e in evs:
        if e.get("type") != "assistant":
            continue
        for c in e.get("message", {}).get("content", []):
            if c.get("type") == "tool_use":
                inp = c.get("input", {})
                key = inp.get("file_path") or inp.get("command") or inp.get("skill") or inp.get("subagent_type") or inp.get("pattern") or inp.get("subject") or ""
                extra = f" model={inp['model']}" if inp.get("model") else ""
                extra += f" effort={inp['effort']}" if inp.get("effort") else ""
                print(f"tool    {c.get('name')} {short(key, 160)}{extra}")
    for e in evs:
        if e.get("type") == "user":
            for c in e.get("message", {}).get("content", []) if isinstance(e.get("message", {}).get("content"), list) else []:
                if c.get("type") == "tool_result" and c.get("is_error"):
                    print(f"tool-error {short(c.get('content'), 300)}")
    res = next((e for e in reversed(evs) if e.get("type") == "result"), None)
    if res:
        print(f"result  {res.get('subtype')} turns={res.get('num_turns')} cost=${res.get('total_cost_usd', 0):.3f}")
        print(f"reply   {short(res.get('result', ''), 1200)}")
    else:
        print("result  (không có sự kiện result: phiên con chết giữa chừng, xem .stderr)")


def main(argv):
    if len(argv) >= 2 and argv[0] == "--session":
        sid = init_of(list(events(argv[1]))).get("session_id")
        if sid:
            print(sid)
        return 0
    if len(argv) == 4 and argv[0] == "--check-probe":
        evs = list(events(argv[1]))
        paths = {p.get("name"): p.get("path") for p in init_of(evs).get("plugins", [])}
        res = next((e for e in reversed(evs) if e.get("type") == "result"), {})
        ok = paths.get("pstack") == argv[2] and paths.get("lichi") == argv[3] and "PONG" in str(res.get("result", ""))
        if not ok:
            print(f"     plugins={paths} result={short(res.get('result'), 200)}", file=sys.stderr)
        return 0 if ok else 1
    if len(argv) == 1:
        summarize(argv[0])
        return 0
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))

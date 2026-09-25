#!/usr/bin/env bash
# Package the plugin as a zip for claude.ai (Customize > Plugins > upload), plugin files at the zip root.
# Inside a git checkout it packs the committed tree (git archive), which keeps exec bits and
# never picks up build output or half-resolved sync files. Commit first.
# Usage: bash plugins/pstack/tools/build-zip.sh [out-dir]   (default: <repo root>/dist)
set -euo pipefail
plugin="$(cd "$(dirname "$0")/.." && pwd -P)"
version=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$plugin/.claude-plugin/plugin.json" | head -n 1)

if top=$(git -C "$plugin" rev-parse --show-toplevel 2>/dev/null); then
	out_dir="${1:-$top/dist}"
	mkdir -p "$out_dir"
	out="$(cd "$out_dir" && pwd -P)/pstack-$version.zip"
	prefix=$(git -C "$plugin" rev-parse --show-prefix)
	if [ -n "$(git -C "$plugin" status --porcelain -- .)" ]; then
		echo "warning: uncommitted changes under $plugin are not in the zip" >&2
	fi
	git -C "$top" archive --format=zip -o "$out" "HEAD:${prefix%/}"
else
	out_dir="${1:-dist}"
	mkdir -p "$out_dir"
	out="$(cd "$out_dir" && pwd -P)/pstack-$version.zip"
	python3 - "$plugin" "$out" <<'PY'
import os, stat, sys, zipfile
root, out = sys.argv[1], sys.argv[2]
with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
    for dirpath, dirs, files in os.walk(root):
        dirs[:] = [d for d in dirs if d not in ("node_modules", "dist", ".git")]
        for f in files:
            if f == ".DS_Store" or f.endswith((".log", ".zip")):
                continue
            path = os.path.join(dirpath, f)
            info = zipfile.ZipInfo(os.path.relpath(path, root).replace(os.sep, "/"))
            info.create_system = 3
            mode = 0o755 if (os.stat(path).st_mode & stat.S_IXUSR or f.endswith(".sh")) else 0o644
            info.external_attr = (stat.S_IFREG | mode) << 16
            with open(path, "rb") as fh:
                z.writestr(info, fh.read(), zipfile.ZIP_DEFLATED)
PY
fi

size=$(wc -c < "$out" | tr -d ' ')
echo "$out ($((size / 1024)) KB)"
[ "$size" -lt 52428800 ] || { echo "over 50 MB, claude.ai will reject it" >&2; exit 1; }

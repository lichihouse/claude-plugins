#!/usr/bin/env bash
# Fixture repo: add() clamps its sum through a private clamp() to [-1000, 1000].
set -eu
cat > math.js <<'JS'
'use strict';

const LIMIT = 1000;

function clamp(value) {
  return Math.min(LIMIT, Math.max(-LIMIT, value));
}

function add(a, b) {
  return clamp(a + b);
}

module.exports = { add };
JS
git init -q
git add math.js
git commit -qm 'add math.js'

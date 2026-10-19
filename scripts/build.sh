#!/usr/bin/env bash
# Export the marimo notebook to a WebAssembly site in dist/ (relative asset URLs, so any /<repo>/ base path works).
set -euo pipefail
cd "$(dirname "$0")/.."
rm -rf dist
marimo export html-wasm app.py -o dist --mode run --no-show-code
rm -rf dist/public
cp public/site.json public/thumbnail.svg public/preview.webm public/preview.mp4 dist/
touch dist/.nojekyll
# GoatCounter analytics
sed -i 's|</head>|<script data-goatcounter="https://demo-web.goatcounter.com/count" async src="//gc.zgo.at/count.js"></script></head>|' dist/index.html

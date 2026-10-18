# demo-web-marimo

**Lemonade Lab**: a reactive Python page built with [marimo](https://marimo.io) and exported to WebAssembly, so the Python runs in the visitor's browser (Pyodide). Hosted on GitHub Pages at https://sthudir.github.io/demo-web-marimo/.

## Files
- `app.py`: the whole site. A marimo notebook: sliders (`mo.ui.slider`) feed plain Python cells that recompute on every change. Includes the YouTube video embed.
- `public/site.json`, `public/thumbnail.svg`: what the hub reads for its card. Copied to the output root by the build.
- `scripts/build.sh`: exports to `dist/`.

## Run locally
```
python3 -m venv .venv && . .venv/bin/activate
pip install -r requirements.txt  # includes uv, which marimo needs for the WASM export
marimo edit app.py        # live editor
bash scripts/build.sh     # static export to dist/
python -m http.server --directory dist
```

## Deploy
Push to `main`. `.github/workflows/deploy.yml` builds with Python 3.11 and publishes `dist/` to GitHub Pages. If the `HUB_DISPATCH_TOKEN` secret exists, it also tells the hub to refresh.

## Video
Edit the `<iframe>` in the last cell of `app.py` (YouTube privacy-enhanced `youtube-nocookie.com/embed/<id>`).

## Base path
marimo's WASM export uses relative URLs, so it works under `/demo-web-marimo/` with no setting. Only `site.json` and the links in `app.py` mention the repo name.

## Caveats
The first load downloads the Pyodide runtime (a few MB) from a CDN, so it needs internet and takes a few seconds. Packages used in `app.py` must be available in Pyodide; this demo uses only the standard library.

## Licence
Public domain (CC0). Everything here is made up for a demo; use and share it freely. See `LICENSE`.

#!/usr/bin/env bash
# Render a mermaid file to PNG for the look-loop. mermaid-cli is required.
# Usage: render-mermaid.sh <input.mmd> <output.png>
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "usage: render-mermaid.sh <input.mmd> <output.png>" >&2
  echo "mermaid-cli is required: npm install -g @mermaid-js/mermaid-cli" >&2
  exit 2
fi

input=$1
output=$2

if [[ ! -f "$input" ]]; then
  echo "render-mermaid.sh: no such file: $input" >&2
  exit 2
fi

find_chrome() {
  local c
  for c in \
    "${CHROME_PATH:-}" \
    "${PUPPETEER_EXECUTABLE_PATH:-}" \
    /usr/bin/google-chrome-stable \
    /usr/bin/google-chrome \
    /usr/bin/chromium-browser \
    /usr/bin/chromium \
    /usr/bin/google-chrome-unstable \
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
    "/Applications/Chromium.app/Contents/MacOS/Chromium"
  do
    if [[ -n "$c" && -x "$c" ]]; then
      printf '%s' "$c"
      return 0
    fi
  done
  return 1
}

run_mmdc() {
  local -a cmd
  if command -v mmdc >/dev/null 2>&1; then
    cmd=(mmdc)
  else
    cmd=(npx -y @mermaid-js/mermaid-cli@11)
  fi
  "${cmd[@]}" "$@"
}

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$(dirname "$output")"

cfg=()
chrome=""
if chrome=$(find_chrome); then
  python3 -c 'import json,sys; print(json.dumps({"executablePath": sys.argv[1], "args": ["--no-sandbox", "--disable-setuid-sandbox"]}))' "$chrome" >"$tmp/puppeteer.json"
  cfg=(-p "$tmp/puppeteer.json")
fi

if ! run_mmdc -i "$input" -o "$output" "${cfg[@]+"${cfg[@]}"}"; then
  echo "render-mermaid.sh: mermaid-cli failed. mermaid-cli is required (npm install -g @mermaid-js/mermaid-cli) plus Chrome or Chromium." >&2
  exit 1
fi

if [[ ! -f "$output" ]]; then
  echo "render-mermaid.sh: mermaid-cli produced no PNG at $output" >&2
  exit 1
fi

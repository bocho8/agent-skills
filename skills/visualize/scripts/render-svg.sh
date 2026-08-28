#!/usr/bin/env bash
# Render an SVG file to PNG for the look-loop.
# Usage: render-svg.sh <input.svg> <output.png>
# Needs rsvg-convert (librsvg) or ImageMagick magick.
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "usage: render-svg.sh <input.svg> <output.png>" >&2
  echo "need rsvg-convert (librsvg) or magick" >&2
  exit 2
fi

input=$1
output=$2

if [[ ! -f "$input" ]]; then
  echo "render-svg.sh: no such file: $input" >&2
  exit 2
fi

mkdir -p "$(dirname "$output")"

if command -v rsvg-convert >/dev/null 2>&1; then
  rsvg-convert -z 2 "$input" -o "$output"
elif command -v magick >/dev/null 2>&1; then
  magick -density 192 -background white "$input" "$output"
else
  echo "render-svg.sh: need rsvg-convert (librsvg2-tools) or magick" >&2
  exit 1
fi

if [[ ! -f "$output" ]]; then
  echo "render-svg.sh: produced no PNG at $output" >&2
  exit 1
fi

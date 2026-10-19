#!/usr/bin/env bash
set -euo pipefail
icon_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
images_dir="$icon_dir/../src/images"
command -v rsvg-convert >/dev/null || { echo 'Can librsvg2-bin.' >&2; exit 1; }
for name in icon.svg icon-dark.svg; do
    test -f "$icon_dir/$name" || { echo "Thieu $name" >&2; exit 1; }
done
for size in 16 24 32 48 64 96 128 256 512; do
    target="$images_dir/icons/${size}x${size}/apps"
    mkdir -p "$target"
    rsvg-convert -w "$size" -h "$size" "$icon_dir/icon.svg" -o "$target/QOwnNotes.png"
done
mkdir -p "$images_dir/icons/scalable/apps"
rsvg-convert -w 128 -h 128 "$icon_dir/icon.svg" -o "$images_dir/icon.png"
rsvg-convert -w 128 -h 128 "$icon_dir/icon-dark.svg" -o "$images_dir/icon-dark.png"
cp "$icon_dir/icon.svg" "$images_dir/icons/scalable/apps/QOwnNotes.svg"
cp "$icon_dir/icon-dark.svg" "$images_dir/icon-dark.svg"
echo 'Da cap nhat icon app va menu Ubuntu.'

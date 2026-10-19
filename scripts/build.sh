#!/usr/bin/env bash
set -euo pipefail
repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
build_dir=${BUILD_DIR:-"$repo_dir/../build-QOwnNotes-Team"}
jobs=${JOBS:-1}
[[ "$jobs" =~ ^[1-9][0-9]*$ ]] || { echo 'JOBS phai la so nguyen duong.' >&2; exit 1; }
for tool in qmake lrelease make python3; do
    command -v "$tool" >/dev/null || { echo "Thieu $tool; chay setup-ubuntu.sh." >&2; exit 1; }
done
qt_version=$(qmake -query QT_VERSION)
[[ "$qt_version" == 5.* ]] || { echo "Can Qt5, hien tai $qt_version." >&2; exit 1; }
python3 "$repo_dir/scripts/verify-source.py"
mkdir -p -- "$build_dir"
build_dir=$(cd -- "$build_dir" && pwd -P)
case "$build_dir/" in
    "$repo_dir/"*) echo 'Dat build ngoai repository.' >&2; exit 1 ;;
esac
marker="$build_dir/.qownnotes-source"
if [[ -f "$marker" ]]; then
    [[ "$(cat "$marker")" == "$repo_dir" ]] || {
        echo 'Build dir thuoc clone khac. Chon BUILD_DIR moi.' >&2; exit 1;
    }
elif [[ -f "$build_dir/Makefile" ]]; then
    echo 'Build dir co Makefile khong ro nguon. Chon BUILD_DIR moi.' >&2
    exit 1
fi
printf '%s\n' "$repo_dir" > "$marker"
(cd "$repo_dir/src" && lrelease QOwnNotes.pro)
cd "$build_dir"
qmake "$repo_dir/src/QOwnNotes.pro" CONFIG+=release
make -j"$jobs"
test -x "$build_dir/QOwnNotes"
printf '\nBuild thanh cong. Mo tu desktop Ubuntu:\n%s\n' "$build_dir/QOwnNotes"

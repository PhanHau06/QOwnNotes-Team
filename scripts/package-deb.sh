#!/usr/bin/env bash
# Package a staged qmake installation. This is a baseline test package.
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
stage=${STAGE_DIR:-"$repo_dir/../package-root"}
meta_dir=${META_DIR:-"$repo_dir/../package-meta"}
output=${OUTPUT_DIR:-"$repo_dir/../packages"}
version=${PACKAGE_VERSION:-24.12.7+team1}
maintainer=${MAINTAINER:-"PhanHau06 <phan-hau@example.invalid>"}
arch=$(dpkg --print-architecture)

test -x "$stage/usr/bin/QOwnNotes"
test -f "$stage/usr/share/applications/PBE.QOwnNotes.desktop"
test -f "$stage/usr/share/qt5/translations/QOwnNotes_vi.qm"
test -f "$stage/usr/share/icons/hicolor/scalable/apps/QOwnNotes.svg"

mkdir -p "$meta_dir/debian" "$stage/DEBIAN" "$output"
cat > "$meta_dir/debian/control" <<'CONTROL'
Source: qownnotes-team
Section: editors
Priority: optional
Maintainer: PhanHau06 <phan-hau@example.invalid>

Package: qownnotes-team
Architecture: any
Description: QOwnNotes team baseline build
CONTROL

dependency_output=$(cd "$meta_dir" && dpkg-shlibdeps -O -e"$stage/usr/bin/QOwnNotes")
dependencies=$(printf '%s\n' "$dependency_output" | sed -n 's/^shlibs:Depends=//p')
test -n "$dependencies"

cat > "$stage/DEBIAN/control" <<CONTROL
Package: qownnotes-team
Version: $version
Section: editors
Priority: optional
Architecture: $arch
Maintainer: $maintainer
Depends: $dependencies, libqt5sql5-sqlite, libqt5svg5, openssl
Conflicts: qownnotes
Replaces: qownnotes
Homepage: https://github.com/PhanHau06/QOwnNotes-Team
Description: QOwnNotes team baseline build for Ubuntu
 Based on QOwnNotes 24.12.7.
 Preliminary package for testing the team's packaging process.
CONTROL

doc_dir="$stage/usr/share/doc/qownnotes-team"
mkdir -p "$doc_dir/third-party"
cp "$repo_dir/LICENSE" "$repo_dir/PROJECT_ORIGIN.md" "$doc_dir/"
(
    cd "$repo_dir"
    find src/libraries -type f \
        \( -iname '*license*' -o -iname '*copying*' -o -iname '*copyright*' \) \
        -exec cp --parents -t "$doc_dir/third-party" -- {} +
)

chmod 755 "$stage/DEBIAN" "$stage/usr/bin/QOwnNotes"
chmod 644 "$stage/DEBIAN/control"
package="$output/qownnotes-team_${version}_${arch}.deb"
dpkg-deb --root-owner-group --build "$stage" "$package"
dpkg-deb --info "$package"
printf '\nDa tao goi: %s\n' "$package"

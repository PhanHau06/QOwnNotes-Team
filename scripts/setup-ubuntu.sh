#!/usr/bin/env bash
set -euo pipefail
[[ -r /etc/os-release ]] || { echo 'Chay trong Ubuntu.' >&2; exit 1; }
. /etc/os-release
if [[ "$ID" != ubuntu || "$VERSION_ID" != 20.04 ]]; then
    echo "Moi truong nhom la Ubuntu 20.04, hien tai ${PRETTY_NAME}." >&2
    exit 1
fi
sudo apt update
sudo apt install -y git build-essential cmake pkg-config ca-certificates python3 \
    qtbase5-dev qt5-qmake qtbase5-dev-tools qtdeclarative5-dev \
    qttools5-dev qttools5-dev-tools libqt5svg5-dev libqt5websockets5-dev \
    libqt5x11extras5-dev libqt5sql5-sqlite libaspell-dev libsecret-1-dev \
    qtcreator librsvg2-bin dpkg-dev debhelper cdbs fakeroot
qmake -v

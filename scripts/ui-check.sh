#!/usr/bin/env bash
# Before/after UI check for QOwnNotes_Team on Ubuntu 20.04.
#
#   bash scripts/ui-check.sh build    # build BEFORE_REF and AFTER_REF (no desktop needed)
#   bash scripts/ui-check.sh config   # language-default checks, offscreen (no desktop needed)
#   bash scripts/ui-check.sh shots    # screenshots, run in a terminal on the VM desktop
#   bash scripts/ui-check.sh all      # build, config, shots
#
# Everything uses a throw-away XDG config/data directory under WORK_DIR, so the
# personal configuration and notes are never touched.
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
work=${WORK_DIR:-"$HOME/finalterm/ui-check"}
before_ref=${BEFORE_REF:-origin/dev}
after_ref=${AFTER_REF:-origin/feature/team-icons}
jobs=${JOBS:-2}
out="$work/results"
read -r -a names <<< "${NAMES:-before after}"

declare -A ref_of=([before]="$before_ref" [after]="$after_ref")

mkdir -p "$out"

log() { printf '%s\n' "$*" | tee -a "$out/summary.txt"; }

exe_of() { printf '%s/%s-build/QOwnNotes' "$work" "$1"; }

stage_build() {
    git -C "$repo_dir" fetch -q origin
    for name in "${names[@]}"; do
        local src="$work/$name-src" bld="$work/$name-build"
        if [[ ! -d "$src" ]]; then
            git -C "$repo_dir" worktree add --detach "$src" "${ref_of[$name]}"
        else
            git -C "$src" checkout -q --detach "${ref_of[$name]}"
        fi
        (cd "$src" && JOBS="$jobs" BUILD_DIR="$bld" bash scripts/build.sh)
        log "build $name: $(git -C "$src" rev-parse --short HEAD) ${ref_of[$name]} -> $(exe_of "$name")"
    done
}

conf_value() { # conf key
    grep -E "^$2=" "$1" 2>/dev/null || echo "$2 = (not set)"
}

run_offscreen() { # exe cfgdir
    XDG_CONFIG_HOME="$2/config" XDG_DATA_HOME="$2/data" QT_QPA_PLATFORM=offscreen \
        timeout 8 "$1" --allow-multiple-instances >/dev/null 2>&1 || true
    sleep 1
}

stage_config() {
    {
        echo "== language default checks ($(date -Is)) =="
        for name in "${names[@]}"; do
            local exe
            exe=$(exe_of "$name")
            [[ -x "$exe" ]] || { echo "missing $exe, run the build stage first"; exit 1; }
            echo
            echo "### $name (${ref_of[$name]})"

            local a="$work/cfg-$name-fresh"
            rm -rf "$a"
            mkdir -p "$a/config" "$a/data"
            run_offscreen "$exe" "$a"
            echo "[A] brand new configuration:"
            conf_value "$a/config/PBE/QOwnNotes.conf" interfaceLanguage
            conf_value "$a/config/PBE/QOwnNotes.conf" teamDefaultsApplied

            local b="$work/cfg-$name-saved-notes"
            rm -rf "$b"
            mkdir -p "$b/config/PBE" "$b/data" "$b/notes"
            printf '[General]\ninterfaceLanguage=de\nnotesPath=%s/notes\n' "$b" \
                > "$b/config/PBE/QOwnNotes.conf"
            run_offscreen "$exe" "$b"
            echo "[B] existing user (language de + notesPath), must stay de:"
            conf_value "$b/config/PBE/QOwnNotes.conf" interfaceLanguage
            conf_value "$b/config/PBE/QOwnNotes.conf" teamDefaultsApplied

            local c="$work/cfg-$name-saved-lang"
            rm -rf "$c"
            mkdir -p "$c/config/PBE" "$c/data"
            printf '[General]\ninterfaceLanguage=de\n' > "$c/config/PBE/QOwnNotes.conf"
            run_offscreen "$exe" "$c"
            echo "[C] language de without notesPath, must stay de:"
            conf_value "$c/config/PBE/QOwnNotes.conf" interfaceLanguage
            conf_value "$c/config/PBE/QOwnNotes.conf" teamDefaultsApplied
        done
    } 2>&1 | tee "$out/config-check.txt"
}

enable_dark() { # conf
    # Same keys as Utils::Misc::switchToDarkOrLightMode(true), plus no first-run dialog.
    python3 - "$1" <<'PY'
import re
import sys

path = sys.argv[1]
text = open(path, encoding="utf-8").read()


def set_key(text, section, key, value):
    header = "[%s]\n" % section
    line = "%s=%s\n" % (key, value)
    start = text.find(header)
    if start == -1:
        if text and not text.endswith("\n"):
            text += "\n"
        return text + "\n" + header + line
    body_start = start + len(header)
    nxt = text.find("\n[", body_start)
    body_end = len(text) if nxt == -1 else nxt + 1
    body = re.sub(r"(?m)^%s=.*\n?" % re.escape(key), "", text[body_start:body_end])
    return text[:body_start] + line + body + text[body_end:]


for key in ("darkMode", "darkModeColors", "darkModeIconTheme", "darkModeTrayIcon"):
    text = set_key(text, "General", key, "true")
text = set_key(text, "Editor", "CurrentSchemaKey", "EditorColorSchema-cdbf28fc-1ddc-4d13-bb21-6a4043316a2f")
text = set_key(text, "appMetrics", "notificationShown", "true")
open(path, "w", encoding="utf-8").write(text)
PY
}

stage_shots() {
    : "${DISPLAY:?Run the shots stage in a terminal on the VM desktop (DISPLAY is empty).}"
    for tool in scrot wmctrl; do
        command -v "$tool" >/dev/null || sudo apt-get install -y "$tool"
    done
    for name in "${names[@]}"; do
        local exe cfg conf pid
        exe=$(exe_of "$name")
        [[ -x "$exe" ]] || { echo "missing $exe, run the build stage first"; exit 1; }
        cfg="$work/cfg-$name-shots"
        conf="$cfg/config/PBE/QOwnNotes.conf"
        rm -rf "$cfg"
        rm -f "$out/$name"-*.png
        mkdir -p "$cfg/config" "$cfg/data"

        XDG_CONFIG_HOME="$cfg/config" XDG_DATA_HOME="$cfg/data" \
            "$exe" --allow-multiple-instances >/dev/null 2>&1 &
        pid=$!
        sleep 6
        scrot "$out/$name-1-first-run.png"
        { echo "== $name first run windows =="; wmctrl -l; } >> "$out/windows.txt"
        echo
        echo ">> [$name] In the app window finish the welcome wizard (Next ... Finish)"
        echo ">> and wait until the main window with a note list is visible."
        read -r -p ">> Press Enter here when the main window is open: " _
        wmctrl -a QOwnNotes_Team || true
        sleep 2
        scrot "$out/$name-2-main-light.png"
        { echo "== $name main window =="; wmctrl -l; } >> "$out/windows.txt"
        kill -TERM "$pid" 2>/dev/null || true
        wait "$pid" 2>/dev/null || true
        sleep 2

        enable_dark "$conf"
        XDG_CONFIG_HOME="$cfg/config" XDG_DATA_HOME="$cfg/data" \
            "$exe" --allow-multiple-instances >/dev/null 2>&1 &
        pid=$!
        sleep 9
        wmctrl -a QOwnNotes_Team || true
        sleep 2
        scrot "$out/$name-3-main-dark.png"
        { echo "== $name main window (dark) =="; wmctrl -l; } >> "$out/windows.txt"
        kill -TERM "$pid" 2>/dev/null || true
        wait "$pid" 2>/dev/null || true
        log "screenshots $name: $out/$name-*.png"
    done
}

case "${1:-all}" in
    build) stage_build ;;
    config) stage_config ;;
    shots) stage_shots ;;
    all) stage_build; stage_config; stage_shots ;;
    *) echo "usage: $0 build|config|shots|all" >&2; exit 1 ;;
esac

{
    echo
    echo "== environment =="
    lsb_release -ds 2>/dev/null || true
    qmake -query QT_VERSION 2>/dev/null || true
    g++ --version 2>/dev/null | head -1 || true
} >> "$out/summary.txt"
echo "Results are in: $out"

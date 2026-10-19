#!/usr/bin/env python3
"""Check static qmake inputs and application resources; does not compile code."""
import glob
import re
import subprocess
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
seen = set()
resources = set()
errors = []
checked = 0


def check_file(path):
    global checked
    checked += 1
    if not path.is_file():
        errors.append("Missing file: " + str(path.relative_to(ROOT)))


def inspect_project(project):
    if project in seen:
        return
    seen.add(project)
    if not project.is_file():
        check_file(project)
        return
    content = project.read_text(encoding="utf-8-sig")
    content = re.sub(r"\\\r?\n", " ", content)
    for raw_line in content.splitlines():
        line = raw_line.split("#", 1)[0].strip()
        for match in re.finditer(r"\binclude\(([^)]+)\)", line):
            value = match.group(1).strip().replace("$$PWD", str(project.parent))
            if "$" not in value:
                inspect_project((project.parent / value).resolve())
        match = re.match(
            r"(?:[\w!|():.-]+:\s*)?(SOURCES|HEADERS|FORMS|RESOURCES|TRANSLATIONS|DISTFILES)\s*\+?=\s*(.*)",
            line,
        )
        if not match:
            continue
        kind, values = match.groups()
        for value in values.split():
            value = value.strip('"').replace("$$PWD", str(project.parent))
            if "$" in value or value in ("{", "}"):
                continue
            candidate = (project.parent / value).resolve()
            if "*" in value:
                if not glob.glob(str(candidate)):
                    errors.append("Empty file pattern: " + value)
                continue
            check_file(candidate)
            if kind == "RESOURCES" and candidate.is_file():
                resources.add(candidate)


inspect_project(ROOT / "src/QOwnNotes.pro")
for resource in sorted(resources):
    try:
        tree = ET.parse(resource)
        for entry in tree.findall(".//file"):
            check_file((resource.parent / (entry.text or "").strip()).resolve())
    except ET.ParseError as exc:
        errors.append("Invalid resource XML: {}: {}".format(resource, exc))

try:
    result = subprocess.run(
        ["git", "ls-files", "--stage"], cwd=str(ROOT),
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, check=True,
    )
    for entry in result.stdout.splitlines():
        if entry.startswith("160000 "):
            errors.append("Unvendored gitlink: " + entry.split("\t", 1)[-1])
except (OSError, subprocess.CalledProcessError) as exc:
    errors.append("Cannot inspect tracked files with Git: " + str(exc))

if errors:
    print("\n".join(errors), file=sys.stderr)
    sys.exit(1)
print("OK: {} static file inputs, {} qmake projects, {} resources; no gitlinks.".format(
    checked, len(seen), len(resources)))

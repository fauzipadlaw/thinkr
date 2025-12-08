#!/usr/bin/env python3
import re
from pathlib import Path

# The script is expected to be run from the root of the project.
path = Path("pubspec.yaml")
if not path.exists():
    raise SystemExit("pubspec.yaml not found. Make sure to run this script from the project root.")

text = path.read_text()
match = re.search(r'^version:\s*([0-9]+)\.([0-9]+)\.([0-9]+)(?:\+([0-9]+))?', text, re.MULTILINE)
if not match:
    raise SystemExit("version not found in pubspec.yaml")

major, minor, patch = map(int, match.group(1, 2, 3))
build = int(match.group(4) or 0)

patch += 1
build += 1
new_version = f"{major}.{minor}.{patch}+{build}"

updated_text = re.sub(r'^version:\s*.*$', f'version: {new_version}', text, count=1, flags=re.MULTILINE)
path.write_text(updated_text)

print(new_version)
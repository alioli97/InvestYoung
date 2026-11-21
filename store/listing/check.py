"""Checks the Play Store listing texts against Play Console's length limits."""
import pathlib
import re
import sys

LIMITS = [30, 80, 4000]  # app name, short description, full description

ok = True
for path in sorted(pathlib.Path(__file__).parent.glob("*.md")):
    if path.name == "README.md":
        continue
    sections = [s.strip() for s in re.split(r"^## .*$", path.read_text(), flags=re.M)[1:]]
    for text, limit in zip(sections, LIMITS):
        status = "ok" if len(text) <= limit else "TOO LONG"
        ok &= len(text) <= limit
        print(f"{path.name}: {len(text):>4}/{limit} {status}")
sys.exit(0 if ok else 1)

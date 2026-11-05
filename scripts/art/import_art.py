#!/usr/bin/env python3
"""Import story art into Tales/Assets.xcassets as JPEG image sets.

Each source image is converted to an RGB JPEG at 85% quality (the project's
convention for story art) and written into the image set named after the file,
replacing whatever image was there and rewriting Contents.json to match.

Usage (from the repository root):

    # Files named after their image set, e.g. AMA012.png -> AMA012.imageset
    python3 scripts/art/import_art.py ~/Downloads/AMA012.png ~/Downloads/AMA013.png

    # A file with any name, imported under an explicit image set name
    python3 scripts/art/import_art.py AMA012=~/Downloads/image-7.png

    # Repair image sets whose Contents.json lists a file that is missing
    # (e.g. a PNG uploaded over a JPEG placeholder)
    python3 scripts/art/import_art.py --fix-catalog

Options:
    --size N   Resize page art to N x N pixels (default 1024). Icons and
               title-screen art (names containing "-Icon" or "-Title") keep
               their original size. Pass --size 0 to never resize.

Requires Pillow (pip install pillow).
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
CATALOG = ROOT / "Tales" / "Assets.xcassets"
IMAGE_SUFFIXES = {".png", ".jpg", ".jpeg", ".heic", ".webp"}
JPEG_QUALITY = 85


def find_imageset(name: str) -> Path:
    matches = [p for p in CATALOG.rglob(f"{name}.imageset") if p.is_dir()]
    if not matches:
        raise SystemExit(f"No image set named '{name}' in {CATALOG.relative_to(ROOT)}")
    if len(matches) > 1:
        raise SystemExit(f"More than one image set named '{name}': {matches}")
    return matches[0]


def keeps_original_size(name: str) -> bool:
    return "-Icon" in name or "-Title" in name


def import_image(name: str, source: Path, size: int) -> None:
    imageset = find_imageset(name)
    with Image.open(source) as image:
        image.load()
    if image.mode in ("RGBA", "LA", "P"):
        image = image.convert("RGBA")
        background = Image.new("RGB", image.size, (0, 0, 0))
        background.paste(image, mask=image.getchannel("A"))
        image = background
    else:
        image = image.convert("RGB")
    if size and not keeps_original_size(name) and image.size != (size, size):
        image = image.resize((size, size), Image.LANCZOS)

    target = imageset / f"{name}.jpg"
    image.save(target, "JPEG", quality=JPEG_QUALITY, optimize=True, subsampling=0)

    for old in imageset.iterdir():
        if old.suffix.lower() in IMAGE_SUFFIXES and old != target:
            old.unlink()

    contents = {
        "images": [{"filename": target.name, "idiom": "universal"}],
        "info": {"author": "xcode", "version": 1},
    }
    (imageset / "Contents.json").write_text(json.dumps(contents, indent=2).replace('": ', '" : ') + "\n")
    print(f"{source} -> {target.relative_to(ROOT)} ({image.size[0]}x{image.size[1]})")


def fix_catalog(size: int) -> int:
    fixed = 0
    for imageset in sorted(CATALOG.rglob("*.imageset")):
        name = imageset.stem
        try:
            listed = [i["filename"] for i in json.loads((imageset / "Contents.json").read_text())["images"] if "filename" in i]
        except (OSError, ValueError, KeyError):
            listed = []
        if listed and all((imageset / f).exists() for f in listed):
            continue
        images = [p for p in imageset.iterdir() if p.suffix.lower() in IMAGE_SUFFIXES]
        if not images:
            print(f"warning: {imageset.relative_to(ROOT)} has no image file", file=sys.stderr)
            continue
        # Prefer a non-JPEG upload over a stale JPEG if both are present.
        source = sorted(images, key=lambda p: p.suffix.lower() in {".jpg", ".jpeg"})[0]
        import_image(name, source, size)
        fixed += 1
    return fixed


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("images", nargs="*", help="PATH or NAME=PATH")
    parser.add_argument("--size", type=int, default=1024)
    parser.add_argument("--fix-catalog", action="store_true")
    args = parser.parse_args()

    if args.fix_catalog:
        print(f"Re-encoded {fix_catalog(args.size)} image set(s).")
    for item in args.images:
        if "=" in item:
            name, path = item.split("=", 1)
        else:
            name, path = Path(item).stem, item
        source = Path(path).expanduser()
        if not source.is_file():
            raise SystemExit(f"Not a file: {source}")
        import_image(name, source, args.size)
    if not args.fix_catalog and not args.images:
        parser.print_help()


if __name__ == "__main__":
    main()

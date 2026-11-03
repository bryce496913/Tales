#!/usr/bin/env python3
"""Static release checks for the Tales Xcode project.

Run from anywhere: python3 scripts/release_readiness_checks.py
Exits non-zero and lists every failure if any check fails.
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TALES = ROOT / "Tales"
SPHINX = TALES / "Tales From the Sphinx"
ANUBIS = TALES / "The Trial of Anubis"
HADES = TALES / "The Descent to Hades"
PBXPROJ = ROOT / "Tales.xcodeproj" / "project.pbxproj"

SPHINX_ENDINGS = {
    "Page2View.swift": "page2-death",
    "Page7View.swift": "page7-lose",
    "Page11View.swift": "page11-death",
    "Page13View.swift": "page13-win",
    "Page14View.swift": "page14-death",
    "Page15View.swift": "page15-lose",
    "Page20View.swift": "page20-lose",
    "Page21View.swift": "page21-death",
    "Page22View.swift": "page22-lose",
    "Page24View.swift": "page24-death",
    "Page25View.swift": "page25-death",
}

failures = []


def check(condition, message):
    if not condition:
        failures.append(message)


def swift_files():
    return sorted(p for p in TALES.rglob("*.swift") if not p.name.startswith("._"))


def check_sphinx_endings():
    for filename, ending_id in SPHINX_ENDINGS.items():
        path = SPHINX / filename
        if not path.exists():
            failures.append(f"missing Sphinx ending file {filename}")
            continue
        check(f'endingID: "{ending_id}"' in path.read_text(), f"{filename} missing endingID {ending_id}")


def check_sphinx_routes():
    root_text = (SPHINX / "TalesFromTheSphinxRootView.swift").read_text()
    handled = {int(n) for n in re.findall(r"case (\d+): Page\d+View\(\)", root_text)}
    for path in sorted(SPHINX.glob("*.swift")):
        for number in re.findall(r"\.page\((\d+)\)", path.read_text()):
            check(int(number) in handled, f"{path.name} navigates to .page({number}), which StoryDestinationView does not handle")


def check_removed_apis():
    for path in swift_files():
        text = path.read_text()
        rel = path.relative_to(ROOT)
        check("exitTransition" not in text, f"exitTransition remains in {rel}")
        check("var typewriterSpeed: TypewriterSpeed = " not in text, f"StoryPageEffects typewriterSpeed remains in {rel}")


def check_project_membership():
    project = PBXPROJ.read_text()
    referenced = set(re.findall(r"path = \"?([^\";]+\.swift)\"?;", project))
    on_disk = {p.name for p in swift_files()}
    for name in sorted(on_disk - referenced):
        failures.append(f"{name} exists on disk but is not in the Xcode project")
    for name in sorted(referenced - on_disk):
        failures.append(f"{name} is in the Xcode project but missing on disk")

    # Folder names must match exactly: macOS ignores case, but other checkouts do not.
    groups = {}
    for group_id, children, rest in re.findall(
            r"([0-9A-F]+)(?: /\*[^*]*\*/)? = \{\s*isa = PBXGroup;\s*children = \((.*?)\);(.*?)\};", project, flags=re.S):
        path = re.search(r"\bpath = \"?([^\";]+)\"?;", rest)
        groups[group_id] = (re.findall(r"([0-9A-F]+) /\*", children), path.group(1) if path else None)
    parents = {child: group_id for group_id, (children, _) in groups.items() for child in children}

    def group_folder(group_id):
        parts = []
        while group_id in groups:
            if groups[group_id][1]:
                parts.append(groups[group_id][1])
            group_id = parents.get(group_id)
        return list(reversed(parts))

    for group_id, (_, path) in groups.items():
        if not path:
            continue
        current = ROOT
        for part in group_folder(group_id):
            if part not in {p.name for p in current.iterdir()}:
                failures.append(f"Xcode group folder '{part}' not found in {current.relative_to(ROOT) or '.'} (check capitalisation)")
                break
            current = current / part


def check_images():
    """Story art lives in Assets.xcassets (so App Thinning and the asset compiler handle it)."""
    import json
    catalog = TALES / "Assets.xcassets"
    imagesets = {p.stem: p for p in catalog.rglob("*.imageset")}
    for name, imageset in sorted(imagesets.items()):
        try:
            files = [i["filename"] for i in json.loads((imageset / "Contents.json").read_text())["images"] if "filename" in i]
        except (OSError, ValueError, KeyError):
            failures.append(f"{imageset.relative_to(ROOT)} has a missing or invalid Contents.json")
            continue
        check(files, f"{imageset.relative_to(ROOT)} has no image file")
        for filename in files:
            check((imageset / filename).exists(), f"{imageset.relative_to(ROOT)} lists missing file {filename}")

    for path in sorted(TALES.rglob("*")):
        if path.suffix.lower() in {".png", ".jpg", ".jpeg", ".heic"} and ".xcassets" not in str(path) and "Preview Content" not in str(path):
            failures.append(f"{path.relative_to(ROOT)} is a loose image; add it to Assets.xcassets instead")

    referenced = set()
    for path in swift_files():
        text = path.read_text()
        names = re.findall(r'(?:imageName|iconImageName|titleImageName): "([^"]+)"', text)
        names += re.findall(r'\bImage\("([^"]+)"\)', text)
        for name in names:
            referenced.add(name)
            check(name in imagesets, f"{path.relative_to(ROOT)} references image '{name}', which is not in Assets.xcassets")
    for name in sorted(set(imagesets) - referenced):
        failures.append(f"Assets.xcassets image '{name}' is not used by any view (remove it to keep the app small)")


def check_audio():
    project = PBXPROJ.read_text()
    resources_phase = project.split("/* Begin PBXResourcesBuildPhase section */")[-1].split("/* End PBXResourcesBuildPhase section */")[0]
    bundled = set(re.findall(r"/\* ([^*]+\.m4a) in Resources \*/,", resources_phase))
    for path in swift_files():
        for name in re.findall(r'resourceName = "([^"]+)"', path.read_text()):
            check((TALES / f"{name}.m4a").exists(), f"{path.relative_to(ROOT)} references missing audio {name}.m4a")
            check(f"{name}.m4a" in bundled, f"{name}.m4a is not in the app target's Copy Bundle Resources")


def check_story_routes(folder, enum_name, prefix, outcome_view, story_name):
    """Checks a numbered-page story (ANU, HDS): routes, ending IDs and one illustration per page."""
    lower = prefix.lower()
    route_text = (folder / f"{enum_name}.swift").read_text()
    cases = re.findall(r"^\s*case (\w+) = \"", route_text, flags=re.M)
    check(cases, f"no {enum_name} cases found")
    destination_view = enum_name.replace("Route", "DestinationView")
    destination = route_text[route_text.index(f"struct {destination_view}"):]
    for case in cases:
        check(f"case .{case}:" in destination, f"{destination_view} does not handle .{case}")

    for path in sorted(folder.glob("*.swift")):
        for target in re.findall(r"destination: \.(\w+)", path.read_text()):
            check(target in cases, f"{path.name} navigates to unknown route .{target}")

    # Game-over pages are numbered routes; the route enum's endingID maps each to its stable ID.
    mapping = dict(re.findall(rf'case \.({lower}\d{{3}}): return "([^"]+)"', route_text))
    check(mapping, f"{enum_name} has no ending IDs")
    for case, ending_id in mapping.items():
        path = folder / f"{prefix}{case[3:]}View.swift"
        if not path.exists():
            failures.append(f"missing {story_name} ending file {path.name}")
            continue
        text = path.read_text()
        check(f"{outcome_view}(" in text, f"{path.name} is an ending but does not use {outcome_view}")
        # The route enum is the only copy of the ID; the engine records it on navigation.
        check("endingID:" not in text, f"{path.name} passes an endingID; it now comes from {enum_name} alone")
    for path in sorted(folder.glob(f"{prefix}*View.swift")):
        if f"{outcome_view}(" in path.read_text():
            check(f"{lower}{path.stem[3:6]}" in mapping, f"{path.name} shows an outcome but has no ending ID in {enum_name}")

    # Every page has its own illustration named after its route number.
    for case in cases:
        number = case[3:]
        path = folder / f"{prefix}{number}View.swift"
        if not path.exists():
            failures.append(f"missing {story_name} page file {path.name} for .{case}")
            continue
        images = re.findall(r'imageName: "([^"]+)"', path.read_text())
        check(images == [f"{prefix}{number}"], f"{path.name} should use image {prefix}{number}, found {images}")


def check_anubis_routes():
    check_story_routes(ANUBIS, "TrialOfAnubisRoute", "ANU", "TrialOfAnubisOutcomeView", "Anubis")


def check_hades_routes():
    check_story_routes(HADES, "DescentToHadesRoute", "HDS", "DescentToHadesOutcomeView", "Hades")


def check_tracked_junk():
    # .gitignore keeps these out, but uploads through GitHub's web UI or Desktop can bypass it.
    try:
        tracked = subprocess.run(["git", "ls-files"], cwd=ROOT, capture_output=True, text=True, check=True).stdout.splitlines()
    except (OSError, subprocess.CalledProcessError):
        return
    for path in tracked:
        if path.endswith(".DS_Store") or "/xcuserdata/" in path or path.endswith(".xcuserstate"):
            failures.append(f"{path} is committed; remove it with git rm --cached (it is personal/macOS state)")


def main():
    check_sphinx_endings()
    check_sphinx_routes()
    check_removed_apis()
    check_project_membership()
    check_images()
    check_audio()
    check_anubis_routes()
    check_hades_routes()
    check_tracked_junk()

    if failures:
        print("Release readiness checks FAILED:")
        for failure in failures:
            print(f"  - {failure}")
        return 1
    print("Release readiness checks passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())

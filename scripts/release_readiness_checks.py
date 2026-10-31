#!/usr/bin/env python3
"""Static release checks for the Tales Xcode project.

Run from anywhere: python3 scripts/release_readiness_checks.py
Exits non-zero and lists every failure if any check fails.
"""
import re
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
# Story pages may be built before their illustrations exist; they show a placeholder until then.
pending_art = []
PENDING_ART = re.compile(r"HDS\d{3}\.png")


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
    images = {p.name for p in TALES.rglob("*.png")}
    project = PBXPROJ.read_text()
    registered = set(re.findall(r"path = \"?([^\";]+\.png)\"?;", project))
    resources_phase = project.split("/* Begin PBXResourcesBuildPhase section */")[-1].split("/* End PBXResourcesBuildPhase section */")[0]
    bundled = set(re.findall(r"/\* ([^*]+\.png) in Resources \*/,", resources_phase))
    for name in sorted(images - registered):
        failures.append(f"{name} exists on disk but is not in the Xcode project (add it with File > Add Files)")
    for name in sorted(registered - images):
        failures.append(f"{name} is in the Xcode project but missing on disk")
    for name in sorted(registered - bundled):
        failures.append(f"{name} is in the Xcode project but not in the app target's Copy Bundle Resources")
    for path in swift_files():
        text = path.read_text()
        names = re.findall(r'(?:imageName|resourceName): "([^"]+\.png)"', text)
        names += re.findall(r'(?:Image|ImageName|StaticImage)\(imageName: "([^"]+\.png)"', text)
        for name in names:
            if name in images:
                continue
            if PENDING_ART.fullmatch(name):
                pending_art.append(name)
            else:
                failures.append(f"{path.relative_to(ROOT)} references missing image {name}")


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
        check(f'endingID: "{ending_id}"' in text,
              f"{path.name} endingID does not match {enum_name} ({ending_id})")
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
        check(images == [f"{prefix}{number}.png"], f"{path.name} should use {prefix}{number}.png, found {images}")


def check_anubis_routes():
    check_story_routes(ANUBIS, "TrialOfAnubisRoute", "ANU", "TrialOfAnubisOutcomeView", "Anubis")


def check_hades_routes():
    check_story_routes(HADES, "DescentToHadesRoute", "HDS", "DescentToHadesOutcomeView", "Hades")


def main():
    check_sphinx_endings()
    check_sphinx_routes()
    check_removed_apis()
    check_project_membership()
    check_images()
    check_audio()
    check_anubis_routes()
    check_hades_routes()

    if failures:
        print("Release readiness checks FAILED:")
        for failure in failures:
            print(f"  - {failure}")
        return 1
    if pending_art:
        print(f"Pending illustrations (placeholder shown in the app): {', '.join(sorted(set(pending_art)))}")
    print("Release readiness checks passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())

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


def check_images():
    images = {p.name for p in TALES.rglob("*.png")}
    for path in swift_files():
        text = path.read_text()
        names = re.findall(r'(?:imageName|resourceName): "([^"]+\.png)"', text)
        names += re.findall(r'(?:Image|ImageName|StaticImage)\(imageName: "([^"]+\.png)"', text)
        for name in names:
            check(name in images, f"{path.relative_to(ROOT)} references missing image {name}")


def check_anubis_routes():
    route_text = (ANUBIS / "TrialOfAnubisRoute.swift").read_text()
    cases = re.findall(r"^\s*case (\w+) = \"", route_text, flags=re.M)
    check(cases, "no TrialOfAnubisRoute cases found")
    destination = route_text[route_text.index("struct TrialOfAnubisDestinationView"):]
    for case in cases:
        check(f"case .{case}:" in destination, f"TrialOfAnubisDestinationView does not handle .{case}")

    for path in sorted(ANUBIS.glob("*.swift")):
        for target in re.findall(r"destination: \.(\w+)", path.read_text()):
            check(target in cases, f"{path.name} navigates to unknown route .{target}")

    state_text = (ANUBIS / "TrialOfAnubisNavigationState.swift").read_text()
    mapping = dict(re.findall(r'case \.(\w+): return "([^"]+)"', state_text))
    ending_views = {
        "endTrue": "AnubisTrueEndingView.swift",
        "endAmmit": "AnubisAmmitEndingView.swift",
        "endRebel": "AnubisRebelEndingView.swift",
        "endTrickster": "AnubisTricksterEndingView.swift",
        "endLost": "AnubisLostSoulEndingView.swift",
    }
    for case, filename in ending_views.items():
        ending_id = mapping.get(case)
        check(ending_id is not None, f"TrialOfAnubisNavigationState has no ending ID for .{case}")
        if ending_id:
            check(f'endingID: "{ending_id}"' in (ANUBIS / filename).read_text(),
                  f"{filename} endingID does not match navigation state ({ending_id})")


def main():
    check_sphinx_endings()
    check_removed_apis()
    check_project_membership()
    check_images()
    check_anubis_routes()

    if failures:
        print("Release readiness checks FAILED:")
        for failure in failures:
            print(f"  - {failure}")
        return 1
    print("Release readiness checks passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())

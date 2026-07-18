#!/usr/bin/env python3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TALES = ROOT / "Tales"

EXPECTED_ENDINGS = {
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

for filename, ending_id in EXPECTED_ENDINGS.items():
    text = (TALES / filename).read_text()
    assert f'endingID: "{ending_id}"' in text, f"{filename} missing {ending_id}"

for path in TALES.glob("*.swift"):
    if path.name.startswith("._"):
        continue
    text = path.read_text()
    assert "exitTransition" not in text, f"exitTransition remains in {path}"
    assert "var typewriterSpeed: TypewriterSpeed = " not in text, f"StoryPageEffects typewriterSpeed remains in {path}"

for path in list(TALES.glob("Page*View.swift")) + [TALES / "Plot1View.swift", TALES / "Plot2View.swift"]:
    text = path.read_text()
    assert "PreviewContainer {" in text, f"{path.name} preview is not wrapped in PreviewContainer"

navigation_text = (TALES / "AppNavigationState.swift").read_text()
assert "func markEndingReached(_ endingID: String)" in navigation_text
assert "if inserted { completedEndings = endings }" in navigation_text
assert "if isAdventureActive { isAdventureActive = false }" in navigation_text

story_layout = (TALES / "StoryPageLayout.swift").read_text()
assert "gameOptions.typewriterSpeed.speed" in story_layout
assert "effects.choicesWaitForText" in story_layout
assert "gameOptions.pageTransitionsEnabled" in story_layout

print("release readiness static checks passed")

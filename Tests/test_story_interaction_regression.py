import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def read(rel):
    return (ROOT / rel).read_text()


class SharedStoryInteractionRegressionTests(unittest.TestCase):
    def test_choice_button_is_stateless_and_invokes_action_directly(self):
        source = read('Tales/Tales From the Sphinx/ChoiceButton.swift')
        self.assertNotIn('@State private var isNavigating', source)
        self.assertNotIn(r'@Environment(\.isEnabled)', source)
        self.assertNotIn('HapticManager.shared', source)
        self.assertNotIn('.disabled(', source)
        self.assertRegex(source, r'Button\(action:\s*action\)')

    def test_story_choice_button_style_has_explicit_configuration_only(self):
        source = read('Tales/Tales From the Sphinx/ChoiceButtonStyle.swift')
        self.assertIn('let glowEnabled: Bool', source)
        self.assertIn('let reduceMotion: Bool', source)
        self.assertNotIn('@EnvironmentObject', source)
        self.assertNotIn('.disabled(', source)
        self.assertNotIn('allowsHitTesting', source)
        self.assertNotIn('HapticManager.shared', source)

    def test_transition_overlay_cannot_intercept_story_controls(self):
        source = read('Tales/Tales From the Sphinx/StoryTransitionContainer.swift')
        self.assertIn('.allowsHitTesting(false)', source)
        self.assertIn('.accessibilityHidden(true)', source)

    def test_visible_choice_containers_are_conditionally_rendered(self):
        sphinx = read('Tales/Tales From the Sphinx/StoryPageLayout.swift')
        anubis = read('Tales/The Trial of Anubis/TrialOfAnubisViews.swift')
        self.assertIn('if choicesVisible', sphinx)
        self.assertIn('if choicesVisible', anubis)
        self.assertNotIn('.disabled(!choicesVisible)', sphinx)
        self.assertNotIn('.disabled(!choicesVisible)', anubis)

    def test_typewriter_completion_is_guarded(self):
        source = read('Tales/Tales From the Sphinx/TypewriterText.swift')
        self.assertIn('@State private var didComplete = false', source)
        self.assertIn('private func completeOnce()', source)
        self.assertGreaterEqual(source.count('completeOnce()'), 3)

    def test_navigation_locks_live_in_coordinators(self):
        sphinx = read('Tales/Tales From the Sphinx/AppNavigationState.swift')
        anubis = read('Tales/The Trial of Anubis/TrialOfAnubisCore.swift')
        self.assertIn('@Published private(set) var isProcessingNavigation = false', sphinx)
        self.assertRegex(sphinx, r'defer\s*\{\s*isProcessingNavigation = false\s*\}')
        self.assertIn('@Published private(set) var isProcessingChoice = false', anubis)
        self.assertRegex(anubis, r'defer\s*\{\s*isProcessingChoice = false\s*\}')

    def test_expected_cross_story_ui_identifiers_exist(self):
        sphinx_nav = read('Tales/Tales From the Sphinx/StoryNavigationButton.swift')
        self.assertIn('sphinx-choice-', sphinx_nav)
        self.assertIn('sphinx-route-plot1', read('Tales/Tales From the Sphinx/Plot1View.swift'))
        self.assertIn('sphinx-route-plot2', read('Tales/Tales From the Sphinx/Plot2View.swift'))
        self.assertIn('sphinx-route-page-1', read('Tales/Tales From the Sphinx/Page1View.swift'))
        anubis_views = read('Tales/The Trial of Anubis/TrialOfAnubisViews.swift')
        self.assertIn('anubis-node-', anubis_views)
        self.assertIn('anubis-choice-', read('Tales/The Trial of Anubis/TrialOfAnubisChoiceButton.swift'))
        self.assertIn('anubis-choice-container-ready', anubis_views)

    def test_no_extra_production_navigation_state_instances(self):
        production = [p for p in (ROOT / 'Tales').rglob('*.swift') if '_Previews' not in p.name]
        sphinx_instances = []
        anubis_instances = []
        for path in production:
            text = path.read_text()
            if 'PreviewProvider' in text:
                text = text.split('PreviewProvider')[0]
            if 'SphinxNavigationState()' in text:
                sphinx_instances.append(str(path.relative_to(ROOT)))
            if 'TrialOfAnubisNavigationState()' in text:
                anubis_instances.append(str(path.relative_to(ROOT)))
        self.assertEqual(sphinx_instances, ['Tales/Tales From the Sphinx/TalesApp.swift'])
        self.assertEqual(anubis_instances, ['Tales/Tales From the Sphinx/TalesApp.swift'])

    def test_anubis_first_nodes_and_effects_are_unchanged(self):
        content = read('Tales/The Trial of Anubis/TrialOfAnubisStoryContent.swift')
        self.assertIn('id: "ANU-001-approach-the-black-doorway", source: .anu001, title: "Approach the black doorway", detail: nil, destination: .anu002, effects: []', content)
        self.assertIn('id: "ANU-001-walk-away-into-the-desert", source: .anu001, title: "Walk away into the desert", detail: nil, destination: .anu003, effects: [.loseMemories(1)]', content)
        self.assertIn('id: "ANU-002-enter-the-doorway", source: .anu002, title: "Enter the doorway", detail: nil, destination: .anu003, effects: []', content)
        self.assertIn('id: "ANU-003-follow-the-jackal-statues", source: .anu003, title: "Follow the jackal statues", detail: nil, destination: .anu004, effects: []', content)
        self.assertIn('id: "ANU-004-answer-honestly", source: .anu004, title: "Answer honestly", detail: nil, destination: .anu005, effects: [.adjustHeartWeight(-1)]', content)


if __name__ == '__main__':
    unittest.main()

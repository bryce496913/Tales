import pathlib
import re
import unittest

ROOT = pathlib.Path(__file__).resolve().parents[1]
CONTENT = ROOT / "Tales/The Trial of Anubis/TrialOfAnubisStoryContent.swift"
DOC = ROOT / "Tales/The Trial of Anubis/Documentation/The_Trial_of_Anubis_Full_Story_Views.md"
ENDINGS = ROOT / "Tales/The Trial of Anubis"


def swift_text():
    return CONTENT.read_text()


def extract_node_narratives(swift):
    pattern = re.compile(r'\.anu(\d{3}): TrialOfAnubisNode\(id: \.anu\d{3}, imageName: "ANU\d{3}\.png", title: "[^\"]+", narrative: """\n(.*?)\n""", choices:', re.S)
    return {f"ANU-{node}": narrative for node, narrative in pattern.findall(swift)}


def extract_doc_text(markdown, node):
    pattern = re.compile(rf"## {node} — [^\n]+\n\n\*\*Suggested Image:\*\* `[^`]+`\n\n\*\*Text:\*\*\n\n(.*?)(?:\n\n### Choices|\n\n### Deterministic Ending Order)", re.S)
    match = pattern.search(markdown)
    assert match, f"Missing documented Text block for {node}"
    return match.group(1).strip()


class TrialOfAnubisContentTests(unittest.TestCase):
    def test_node_choice_and_ending_counts(self):
        swift = swift_text()
        self.assertEqual(len(re.findall(r"TrialOfAnubisNode\(", swift)), 28)
        self.assertEqual(len(re.findall(r"TrialOfAnubisChoice\(", swift)), 64)
        self.assertEqual(len(list(ENDINGS.glob("Anubis*EndingView.swift"))), 5)

    def test_conditional_requirements_unchanged(self):
        swift = swift_text()
        requirements = re.findall(r"requirement: (\.[A-Za-z]+)", swift)
        self.assertEqual(requirements, [".hasGoldenScarab", ".learnedTrueName", ".hasWeaponOrUnderworldPower"])

    def test_choice_details_removed(self):
        self.assertNotIn('detail: """', swift_text())

    def test_sample_narratives_match_canonical_markdown(self):
        swift_narratives = extract_node_narratives(swift_text())
        markdown = DOC.read_text()
        for node in ["ANU-001", "ANU-005", "ANU-009", "ANU-015", "ANU-022", "ANU-027"]:
            self.assertEqual(swift_narratives[node], extract_doc_text(markdown, node))

    def test_old_long_form_passages_removed_from_compiled_nodes(self):
        swift = swift_text()
        old_passages = [
            "No wind moves across the dunes.",
            "The only sound is the slow beat of your own heart.",
            "The circular opening leads to a spiral stair",
            "The passage narrows, then dissolves into fog.",
        ]
        for passage in old_passages:
            self.assertNotIn(passage, swift)

    def test_endings_have_no_markdown_headings_in_outcome_text(self):
        for path in ENDINGS.glob("Anubis*EndingView.swift"):
            text = path.read_text()
            outcome = re.search(r"outcomeText: \"\"\"\n(.*?)\n\"\"\"", text, re.S).group(1)
            self.assertNotIn("**", outcome)
            self.assertNotIn("#", outcome)
            self.assertNotIn("`", outcome)


if __name__ == "__main__":
    unittest.main()

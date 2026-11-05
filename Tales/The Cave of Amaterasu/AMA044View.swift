import SwiftUI

struct AMA044View: View {
    var body: some View {
        CaveOfAmaterasuOutcomeView(
            outcome: .lose,
            title: "The Rock Stays Shut",
            classification: "Eternal Night",
            imageName: "AMA044",
            storyText: """
            You can’t wait any longer. You throw yourself at the gap, as if you could drag the sun out by force. Amaterasu cries out in fright. The light vanishes from the crack, and the boulder grinds shut again, tighter than before, and from deep inside the cave you hear another rock rolling into place behind it, and then another. The laughter of the gods dies away. Uzume climbs slowly down from her tub. The roosters will not crow again. The gods will try other festivals and other plans, but the goddess has learned that the world outside is a place where people grab at her, and she will not come out again.
            """,
            outcomeText: """
            You tried to force the sun out of hiding.

            The rock is sealed, and the world will have to learn to live in the dark.
            """
        )
    }
}

struct AMA044View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA044View()
        }
    }
}

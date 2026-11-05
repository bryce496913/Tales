import SwiftUI

struct AMA013View: View {
    var body: some View {
        CaveOfAmaterasuOutcomeView(
            outcome: .death,
            title: "Looked Upon the Sun",
            classification: "Death",
            imageName: "AMA013",
            storyText: """
            While the gods are talking, you creep to the great boulder and put your eye to the crack. Just one look, you think, at the goddess everyone is waiting for. Inside, the cave is full of a light so pure that it has no colour at all. Amaterasu sits at the centre of it with her face in her hands. She lifts her head. For one heartbeat you see the face of the sun, and it is the most beautiful thing in heaven or on earth. Then there is only white, and warmth, and nothing. When the gods come looking for you, they find only the shape of a hand scorched into the stone.
            """,
            outcomeText: """
            You looked upon the face of the sun with mortal eyes.

            Even the gods do not dare to do that.
            """
        )
    }
}

struct AMA013View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA013View()
        }
    }
}

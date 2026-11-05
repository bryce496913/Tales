import SwiftUI

struct AMA021View: View {
    var body: some View {
        CaveOfAmaterasuOutcomeView(
            outcome: .lose,
            title: "Hidden by the Tengu",
            classification: "Hidden",
            imageName: "AMA021",
            storyText: """
            The tengu have a way of dealing with humans who are too proud or too tired: they hide them. You wake in the hollow among the cedar roots, among the spirited-away, and the mountain is so quiet, and the moss is so soft. Sometimes you remember that you were supposed to be carrying something. Sometimes you remember a bell. The farmer pats your hand and tells you not to worry. Far away, at the foot of a different mountain, the people of a village you once knew hang your sandals by the shrine door and wait for you to come home, the way people always wait for the ones the tengu take.
            """,
            outcomeText: """
            The tengu hid you away, as they hide the proud and the weary.

            Mount Kurama keeps its mirror, and its guests.
            """
        )
    }
}

struct AMA021View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA021View()
        }
    }
}

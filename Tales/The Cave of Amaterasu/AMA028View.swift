import SwiftUI

struct AMA028View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA028",
            title: "The Turtle Remembers",
            text: """
            Just as you lift the cup, something hard bumps against your knee. It is the old turtle from the beach, which has crept under the table. “Do you know how long you have been here?” it whispers. “Only a few hours, though it feels like days. And every day you spend in the Dragon Palace is a hundred years in the world above. Stay one more day, and everyone you love will be dust.” The cup falls from your hand. The turtle nudges you toward the hall of the Dragon King. “Go now. And whatever the princess gives you, keep it closed.”
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Go to the Dragon King",
                    destination: .ama026
                )
            }
        }
    }
}

struct AMA028View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA028View()
        }
    }
}

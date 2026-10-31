import SwiftUI

struct HDS001View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS001.png",
            title: "The Sea Cave",
            text: """
            You wake on a shelf of black stone inside a cave. Behind you, the sea glows green through a narrow opening, and the storm has gone as if it never happened. There is no sign of the boat, or of Theo. Ahead, a stairway has been cut into the rock, worn smooth by feet that were not human, and it leads down into a darkness that smells of earth and cold iron. Carved above the first step, in letters older than any you know, are the words: “Here the living do not pass.” Somewhere far below, someone calls your name. It sounds like Theo.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Go deeper",
                    destination: .hds002
                )

                DescentToHadesNavigationButton(
                    title: "Swim for the light",
                    destination: .hds003
                )
            }
        }
    }
}

struct HDS001View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS001View()
        }
    }
}

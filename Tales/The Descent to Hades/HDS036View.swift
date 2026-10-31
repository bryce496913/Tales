import SwiftUI

struct HDS036View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS036.png",
            title: "The Sibyl’s Riddle",
            text: """
            The Sibyl opens her eyes. They are milky white, but you are certain she can see you. “Aeneas came down for his father,” she says. “You come for a brother. Tell me, what would you give to have him back?” A breeze stirs the grove, and the golden branch chimes softly, as if it is listening too. You would like to say “anything”. You would like to say “my life”. You are not sure either is true.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Answer honestly",
                    destination: .hds038
                )

                DescentToHadesNavigationButton(
                    title: "Promise anything",
                    destination: .hds037
                )
            }
        }
    }
}

struct HDS036View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS036View()
        }
    }
}

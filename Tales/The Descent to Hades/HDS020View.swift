import SwiftUI

struct HDS020View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS020.png",
            title: "Echoes in the Water",
            text: """
            You start across the stepping stones. Halfway over, they begin to sink, and the river rises to your knees and pours memories into you. It shows you the boat again, but this time it does not lie. You see yourself in the moment before the wave hit, letting go of Theo’s hand to grab the rail. It lasted a single second, made of pure fear, and it is the one thing you have never allowed yourself to remember. The river waits, as if to see what you will do with it.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Admit it",
                    destination: .hds022
                )

                DescentToHadesNavigationButton(
                    title: "Blame the sea",
                    destination: .hds019
                )
            }
        }
    }
}

struct HDS020View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS020View()
        }
    }
}

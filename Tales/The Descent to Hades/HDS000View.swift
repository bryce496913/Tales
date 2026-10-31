import SwiftUI

struct HDS000View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS000.png",
            title: "The Storm at Tainaron",
            text: """
            You and your younger brother, Theo, hired a small boat to see the sea caves at Cape Tainaron, at the southern tip of mainland Greece, where the old stories say there is a doorway to the underworld. The guide laughed about it over breakfast. By the afternoon nobody was laughing. A squall came off the open sea without warning, the boat rolled and the water closed over you both. You remember Theo’s hand in yours, the cold, the dark and the moment his fingers slipped away. Then a wave threw you against rock, and the roar of the sea went quiet.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Continue",
                    destination: .hds001
                )
            }
        }
    }
}

struct HDS000View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS000View()
        }
    }
}

import SwiftUI

struct HDS007View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS007.png",
            title: "The Banks of the Styx",
            text: """
            The road ends at a black river so wide you cannot see the other side. Its water does not move, and it reflects nothing. Hundreds of souls wait silently on the shore. A long, flat boat slides out of the mist, steered by a tall old man in a hooded cloak whose eyes burn like coals. This is Charon, the ferryman. Each soul places a coin on his palm before stepping aboard. Hermes has vanished. You turn out your pockets and find only seawater and sand, and on your finger, the silver ring your grandmother left you. Charon stops the boat in front of you and holds out his hand.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Offer your ring",
                    destination: .hds009
                )

                DescentToHadesNavigationButton(
                    title: "Swim across",
                    destination: .hds008
                )
            }
        }
    }
}

struct HDS007View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS007View()
        }
    }
}

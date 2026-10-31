import SwiftUI

struct HDS035View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS035.png",
            title: "The Grove of the Golden Bough",
            text: """
            The golden tree stands alone in a quiet grove. Its trunk is ordinary bark, but one low branch is pure gold, leaves and twigs and all, chiming softly in the breeze. Beneath it, on a stone bench, sits a very old woman wrapped in grey, with dry leaves tangled in her hair. She is the Sibyl of Cumae, who once guided the hero Aeneas through the underworld. “The bough breaks only for the one the Fates allow,” she says without opening her eyes. “If you are not that one, all the strength in the world will not move it.”
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Reach for the bough",
                    destination: .hds037
                )

                DescentToHadesNavigationButton(
                    title: "Speak to the Sibyl",
                    destination: .hds036
                )
            }
        }
    }
}

struct HDS035View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS035View()
        }
    }
}

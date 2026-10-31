import SwiftUI

struct HDS030View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS030.png",
            title: "The Way Out of Tartarus",
            text: """
            You wait while the river roars and your skin blisters. Then, with a long sigh, the flames sink. An ember rolls to the bank and you lift it into the bronze bowl. It burns without consuming anything. When you turn around, Tisiphone is standing on the path. She looks at the ember, then at you. “Patience,” she says. “Rarer down here than courage.” She steps aside and points her whip toward the bronze road.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Return",
                    destination: .hds015
                )
            }
        }
    }
}

struct HDS030View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS030View()
        }
    }
}

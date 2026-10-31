import SwiftUI

struct HDS029View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS029.png",
            title: "The Furies Wake",
            text: """
            You lunge, scoop an ember into the bronze bowl and pull it back, smoking. The river roars as if you have robbed it, and all three Furies rise screaming from the walls of Tartarus: Tisiphone, Alecto and Megaera, their whips trailing fire. Between you and the bronze road lies a narrow bridge over the burning river. To your left, a dark crack in the rock leads underground, cool and silent and out of sight.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Run for the bridge",
                    destination: .hds015
                )

                DescentToHadesNavigationButton(
                    title: "Hide in the dark",
                    destination: .hds031
                )
            }
        }
    }
}

struct HDS029View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS029View()
        }
    }
}

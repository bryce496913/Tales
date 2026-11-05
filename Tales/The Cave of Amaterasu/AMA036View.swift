import SwiftUI

struct AMA036View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA036",
            title: "The Serpent Sleeps",
            text: """
            One by one, the eight heads sway, droop and fall. The serpent’s snoring shakes the leaves from the trees. You wait until the last head has dropped into its empty vat, then you climb over the fence and walk along the serpent’s back, between the cypress trees that grow there, toward its eight tails. One of them is glowing from the inside, faintly blue, like a lantern behind a paper screen.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Cut open the glowing tail",
                    destination: .ama037
                )
            }
        }
    }
}

struct AMA036View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA036View()
        }
    }
}

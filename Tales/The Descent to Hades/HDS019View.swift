import SwiftUI

/// Drinking leads to HDS-021 (Theo stops you) if you woke Theo at HDS-017, otherwise to the HDS-023 game over.
struct HDS019View: View {
    @EnvironmentObject
    private var navigationState: DescentToHadesNavigationState

    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS019.png",
            title: "The Reflection",
            text: """
            You kneel and lower the flask. The surface goes still, and in it you see the boat, the storm and Theo’s hand slipping out of yours. Then the picture changes. This time you hold on. You pull him up, you both reach the shore, and you sit together on the warm rocks, laughing in the sun. The water whispers that this is how it should have been. All you have to do is drink, and the grief will go, and the other memory with it. Your mouth is so dry. It would be so easy.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Look away",
                    destination: .hds022
                )

                if navigationState.hasFlag(.wokeTheo) {
                    DescentToHadesNavigationButton(
                        title: "Drink",
                        destination: .hds021
                    )
                } else {
                    DescentToHadesNavigationButton(
                        title: "Drink",
                        destination: .hds023
                    )
                }
            }
        }
    }
}

struct HDS019View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS019View()
        }
    }
}

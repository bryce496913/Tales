import SwiftUI

struct HDS010View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS010.png",
            title: "Thrown Ashore",
            text: """
            You tell Charon that Zeus himself sent you on an errand. The ferryman is silent for a long moment. Then he laughs, a terrible creaking sound, and tips the boat. You roll over the side into the shallows of the far shore, gasping, as the river drags at your legs and tries to pull your memories away. You crawl out onto black sand with your heart pounding. Behind you, Charon’s voice drifts out of the mist: “Every lie told down here is heard. Remember that when you stand before my master.” Ahead of you, something very large begins to growl.
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Continue",
                    destination: .hds011
                )
            }
        }
    }
}

struct HDS010View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS010View()
        }
    }
}

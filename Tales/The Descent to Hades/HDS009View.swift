import SwiftUI

struct HDS009View: View {
    var body: some View {
        DescentToHadesPageLayout(
            imageName: "HDS009.png",
            title: "Charon’s Question",
            text: """
            Charon closes his fingers over the ring and gestures you aboard. The boat moves without a sound. Halfway across, the souls around you fade into the mist until you are alone with the ferryman. Without turning his head, he speaks in a voice like stones grinding together. “You are warm. You are breathing. The living do not cross my river unless they are heroes, fools or thieves. Which are you, and why have you come?”
            """,
            effects: DescentToHadesPageEffects(
                entryTransition: .mistFade,
                choicesWaitForText: true
            )
        ) {
            DescentToHadesChoicesStack {
                DescentToHadesNavigationButton(
                    title: "Tell the truth",
                    destination: .hds011
                )

                DescentToHadesNavigationButton(
                    title: "Lie",
                    destination: .hds010,
                    marks: .liedToCharon
                )
            }
        }
    }
}

struct HDS009View_Previews: PreviewProvider {
    static var previews: some View {
        DescentToHadesPreviewContainer {
            HDS009View()
        }
    }
}

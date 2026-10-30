import SwiftUI

struct ANU046View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU046.png",
            title: "The Voice You Saved",
            text: """
            You take their hand and the warm light closes around you. Then another voice cuts through it, thin but familiar. It is the soul you freed in the Hall of Whispers. They stand in the doorway of the memory, flickering between a child, an old woman and a wounded soldier, and they repeat your name again and again so that you cannot forget it. The memory cracks like glass. Beyond it, the fog parts and a heartbeat that sounds exactly like your own calls you forward.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Follow the heartbeat",
                    destination: .anu020
                )
            }
        }
    }
}

struct ANU046View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU046View()
        }
    }
}

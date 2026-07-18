import SwiftUI

struct ANU028View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU028.png",
            title: "Final Decision",
            text: """
                You return every piece of the scales to Anubis and the sacred balance begins rebuilding itself. Your heart rises from your chest and floats above the empty pan while the feather of Ma’at waits on the other side. Anubis tells you that this is your final chance to accept judgment honestly. You can allow the scales to decide your fate or interfere with the balance before it settles.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Accept honest judgment",
                    destination: .endTrue
                )

                TrialOfAnubisNavigationButton(
                    title: "Manipulate the scales",
                    destination: .endTrickster
                )
            }
        }
    }
}

struct ANU028View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU028View()
        }
    }
}

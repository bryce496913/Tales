import SwiftUI

struct ANU037View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU024.png",
            title: "The Collapsing Tomb",
            text: """
            Your blow splits the guardian in two and it falls without a sound. At once, the stone rings around the mechanism lock in place, then begin tearing themselves apart. The ceiling cracks, columns fall and the floor tilts toward a pit of blue fire. Through the dust you can see the exit passage, already half-blocked by falling rubble. Above you, a huge slab breaks free from the ceiling.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Run",
                    destination: .anu011
                )

                TrialOfAnubisNavigationButton(
                    title: "Dodge",
                    destination: .anu038
                )
            }
        }
    }
}

struct ANU037View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU037View()
        }
    }
}

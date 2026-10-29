import SwiftUI

struct ANU044View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU044.png",
            title: "A Secret Kept",
            text: """
            You fold the name away inside your mind and say nothing. The scribe’s mask fills with a single approving word before falling blank again. “A secret is a weapon,” he says, “and every weapon draws attention.” Behind him, the stars on the ceiling shift and reveal a narrow stair spiralling down toward a low grinding sound, like great stone wheels turning. At the same moment, a masked figure slips between the scroll shelves, watching you.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Follow the masked figure",
                    destination: .anu023
                )

                TrialOfAnubisNavigationButton(
                    title: "Take the stairs",
                    destination: .anu024
                )
            }
        }
    }
}

struct ANU044View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU044View()
        }
    }
}

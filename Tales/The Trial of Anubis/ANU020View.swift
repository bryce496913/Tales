import SwiftUI

struct ANU020View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU020.png",
            title: "The Heart Pan",
            text: """
                The fog clears and reveals a chamber shaped like the inside of a giant heart. The missing Heart Pan hangs at the centre, held above thousands of names carved into the floor. Some of the names belong to the dead, while others belong to people who have not yet been born. Your own name appears beneath your feet beside the name of an underworld scribe, suggesting that your arrival was recorded long before the scales were broken.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Recover the Heart Pan",
                    destination: .anu021
                )

                TrialOfAnubisNavigationButton(
                    title: "Examine the names beneath it",
                    destination: .anu021
                )
            }
        }
    }
}

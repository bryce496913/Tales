import SwiftUI

struct ANU005View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU005.png",
            title: "Anubis Revealed",
            text: """
                The staircase opens into a hall so large that the ceiling disappears into darkness. At its centre stands Anubis, dressed in black and gold with glowing amber eyes. Behind him is a shattered set of scales, with one pan cracked on the floor and the central balance stone torn from its frame. Shadowy souls drift through open gates while something enormous growls from behind the pillars. Anubis tells you that the scales used to judge the dead have been stolen and that you must recover the missing pieces before the boundary between life and death collapses.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Kneel and listen",
                    destination: .anu006
                )

                TrialOfAnubisNavigationButton(
                    title: "Demand to be released",
                    destination: .anu007
                )
            }
        }
    }
}

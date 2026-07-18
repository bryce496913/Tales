import SwiftUI

struct ANU012View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU012.png",
            title: "Feather Arm Chamber",
            text: """
                The sealed door opens into a circular room where the golden Feather Arm floats above a shaft of blue fire. Painted figures kneel around the walls holding their hearts in their hands, but their shadows move on their own. Deep scratches cross the floor and lead toward a hidden passage behind the murals. A low growl moves through the stone as the Feather Arm slowly turns within reach.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Lift the Feather Arm",
                    destination: .anu013
                )

                TrialOfAnubisNavigationButton(
                    title: "Inspect the shadows",
                    destination: .anu014
                )
            }
        }
    }
}

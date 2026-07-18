import SwiftUI

struct ANU004View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU004.png",
            title: "The Voice Below",
            text: """
                You descend a spiral staircase that circles a shaft with no visible bottom. The voice follows beside you and asks why you entered the temple. As you continue downward, the steps show flashes of your own life: small acts of kindness, lies that were never discovered and moments when fear controlled you. Far below, two amber eyes open in the darkness. The voice speaks again, this time with greater force. “Answer.”
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Answer honestly",
                    destination: .anu005
                )

                TrialOfAnubisNavigationButton(
                    title: "Lie about why you are here",
                    destination: .anu005
                )
            }
        }
    }
}

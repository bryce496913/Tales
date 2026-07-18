import SwiftUI

struct ANU016View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU016.png",
            title: "The Broken Chain",
            text: """
                At the far side of Ammit’s chamber, you find a section of her broken chain lying across the path. The links were cut cleanly, proving that someone released her on purpose. When you touch the chain, you see a vision of an underworld scribe removing the Heart Pan while a hidden figure watches. A fragment of dark power floats above the broken metal, offering you the choice to repair part of the chain or take its power for yourself.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .sandFade,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Repair the broken chain",
                    destination: .anu017
                )

                TrialOfAnubisNavigationButton(
                    title: "Leave the chain and continue",
                    destination: .anu017
                )
            }
        }
    }
}

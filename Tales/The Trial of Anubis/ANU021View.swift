import SwiftUI

struct ANU021View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU021.png",
            title: "The Scribe’s Secret",
            text: """
                A hidden door leads to an underworld scribe surrounded by endless rolls of papyrus. His face is covered by a blank mask that fills with moving words whenever he speaks. He shows you a scroll describing every choice you have made and says that your arrival was written before you were born. When you ask who allowed the scales to break, he tells you that truth must be purchased with trust, force or memory.
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Trust the underworld scribe",
                    destination: .anu022
                )

                TrialOfAnubisNavigationButton(
                    title: "Threaten the scribe",
                    destination: .anu022
                )
            }
        }
    }
}

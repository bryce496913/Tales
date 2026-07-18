import SwiftUI

struct ANU023View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU023.png",
            title: "The Rebel’s Offer",
            text: """
                A masked rebel steps from behind the scribe’s scrolls and claims that the gods use judgment to protect their own power. They show you visions of frightened souls being weighed, forgotten workers waiting without names and kings passing easily into eternity. The rebel offers you underworld power and asks you to restore the scales only long enough to decide whether Anubis deserves to keep control of them.
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Reject the rebel’s offer",
                    destination: .anu024
                )

                TrialOfAnubisNavigationButton(
                    title: "Accept the rebel’s offer",
                    destination: .anu024
                )
            }
        }
    }
}

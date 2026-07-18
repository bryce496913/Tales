import SwiftUI

struct ANU011View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU011.png",
            title: "The Crying Soul",
            text: """
You find a trapped soul pinned beneath a heavy stone tablet. Their body changes between a child, an old woman and a wounded soldier as the hall steals pieces of their identity. They tell you that they were waiting for judgment when the scales broke and that they will soon forget their own name. Freeing them will take time, but they promise to tell you what they know about Ammit and the stolen pieces if you help them.
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Free the trapped soul",
                    destination: .anu012
                )

                TrialOfAnubisNavigationButton(
                    title: "Leave the soul trapped",
                    destination: .anu012
                )
            }
        }
    }
}

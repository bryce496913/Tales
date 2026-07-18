import SwiftUI

struct ANU025View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU025.png",
            title: "The Final Guardian",
            text: """
                The guardian blocks the exit as cracks spread across its body. It says that it was created to protect the Balance Stone and now has no purpose without it. The room begins collapsing behind you while the guardian lowers its weapon and asks you to judge what should happen to it. You can spare it, destroy it or use Anubis’s hidden title to command it.
            """
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Spare the final guardian",
                    destination: .anu026
                )

                TrialOfAnubisNavigationButton(
                    title: "Destroy the final guardian",
                    destination: .anu026
                )
            }
        }
    }
}

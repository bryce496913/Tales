import SwiftUI

struct ANU023View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU023.png",
            title: "The Rebel’s Offer",
            text: """
            A masked rebel steps from behind the scribe’s scrolls and claims that the gods use judgment to protect their own power. They show you visions of frightened souls being weighed, forgotten workers waiting without names and kings passing easily into eternity. The rebel offers you underworld power and asks you to restore the scales only long enough to decide whether Anubis deserves to keep control of them.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Reject",
                    destination: .anu045
                )

                TrialOfAnubisNavigationButton(
                    title: "Accept",
                    destination: .anu024,
                    marks: .acceptedRebel
                )
            }
        }
    }
}

struct ANU023View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU023View()
        }
    }
}

import SwiftUI

struct ANU026View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU026.png",
            title: "Return to the Hall",
            text: """
                The three recovered pieces begin pulling toward one another and open a doorway back to the Hall of Judgment. Anubis waits beside the broken scales while countless souls gather in the darkness. Ammit watches from behind the pillars, and the rebel’s words remain in your mind. Anubis extends his hand and orders you to return the pieces, but you now understand that carrying them gives you power over the future of the underworld.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Return the scale pieces honestly",
                    destination: .anu028
                )

                TrialOfAnubisNavigationButton(
                    title: "Hide one piece and bargain",
                    destination: .anu027
                )
            }
        }
    }
}

struct ANU026View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU026View()
        }
    }
}

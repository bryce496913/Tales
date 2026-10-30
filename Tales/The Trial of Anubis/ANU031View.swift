import SwiftUI

struct ANU031View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU014.png",
            title: "Pulled Through the Glass",
            text: """
            You press your hand against the glass. Your heart stops, and so does every heart in the room. The red chamber dissolves into thick white fog and you are pulled through it as if a hand has closed around your chest. When you can breathe again, you are kneeling on cold stone. Your heartbeat has returned, louder than ever, and it echoes from somewhere just ahead of you in the fog.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Follow the heartbeat",
                    destination: .anu020
                )
            }
        }
    }
}

struct ANU031View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU031View()
        }
    }
}

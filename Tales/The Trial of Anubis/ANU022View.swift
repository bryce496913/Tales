import SwiftUI

struct ANU022View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU022.png",
            title: "The True Name",
            text: """
                The scribe brings you into a dark chamber where stars form the shape of a jackal. He explains that the gods once had titles powerful enough to command the laws of creation. He then teaches you the hidden title of Anubis: He Who Opens the Final Door and Must Obey the Balance. Speaking it could command parts of the underworld, while keeping it secret would leave you with a weapon that no one knows you possess.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .sandFade,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Speak Anubis’s hidden title",
                    destination: .anu023
                )

                TrialOfAnubisNavigationButton(
                    title: "Keep the name secret",
                    destination: .anu023
                )
            }
        }
    }
}

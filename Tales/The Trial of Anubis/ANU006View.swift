import SwiftUI

struct ANU006View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU006.png",
            title: "Terms of Judgment",
            text: """
            Anubis raises his hand and shows you visions of the three missing pieces: the Feather Arm, the Heart Pan and the Balance Stone. He explains that fear, greed and rebellion have carried them into different parts of the underworld. If you return them, the dead can be judged again and the gates between worlds can be closed. When you ask what happens to you, Anubis says that an honest heart may return to the living, but anyone seeking a reward must first understand its price.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .sandFade,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Agree",
                    destination: .anu008
                )

                TrialOfAnubisNavigationButton(
                    title: "Ask for a reward",
                    destination: .anu033
                )
            }
        }
    }
}

struct ANU006View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU006View()
        }
    }
}

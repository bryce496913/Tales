import SwiftUI

struct ANU026View: View {
    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU026.png",
            title: "The Scales Made Whole",
            text: """
            As you step back into the Hall of Gates, the Feather Arm, the Heart Pan and the Balance Stone pull against your hands, straining toward one another. All three gates seal behind curtains of blue fire and a fourth door opens where there was only wall before. Beyond it, Anubis waits beside the broken scales while countless souls gather in the darkness. He extends his hand and asks for the pieces. Behind you, a narrow passage glows with light from the world above, and you realise that whoever carries all three pieces holds power over the future of the underworld.
            """,
            effects: TrialOfAnubisPageEffects(
                entryTransition: .stoneDoor,
                choicesWaitForText: true
            )
        ) {
            TrialOfAnubisChoicesStack {
                TrialOfAnubisNavigationButton(
                    title: "Talk to Anubis",
                    destination: .anu027
                )

                TrialOfAnubisNavigationButton(
                    title: "Try to escape",
                    destination: .anu028
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

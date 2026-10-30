import SwiftUI

struct ANU026View: View {
    @EnvironmentObject
    private var navigationState: TrialOfAnubisNavigationState

    var body: some View {
        TrialOfAnubisPageLayout(
            imageName: "ANU026.png",
            title: "The Scales Made Whole",
            text: storyText,
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

                if navigationState.progress.storyFlags.contains(.acceptedRebel) {
                    TrialOfAnubisNavigationButton(
                        title: "Keep the deal",
                        destination: .anu047
                    )
                } else {
                    TrialOfAnubisNavigationButton(
                        title: "Escape",
                        destination: .anu028
                    )
                }
            }
        }
    }

    private var storyText: String {
        var result = """
        As you step back into the Hall of Gates, the Feather Arm, the Heart Pan and the Balance Stone pull against your hands, straining toward one another. All three gates seal behind curtains of blue fire and a fourth door opens where there was only wall before. Beyond it, Anubis waits beside the broken scales while countless souls gather in the darkness. He extends his hand and asks for the pieces. Behind you, a narrow passage glows with light from the world above, and you realise that whoever carries all three pieces holds power over the future of the underworld.
        """

        if navigationState.progress.storyFlags.contains(.abandonedSoul) {
            result += " Among the gathered dead, one figure flickers between a child, an old woman and a wounded soldier. It is the soul you left beneath the stone tablet, and it no longer remembers its name."
        }

        if navigationState.progress.storyFlags.contains(.acceptedRebel) {
            result += " Then the masked rebel steps out from among the souls. They say nothing, but they hold out their hand beside Anubis’s, and you remember the deal you made among the scribe’s scrolls."
        }

        return result
    }
}

struct ANU026View_Previews: PreviewProvider {
    static var previews: some View {
        TrialOfAnubisPreviewContainer {
            ANU026View()
        }
    }
}

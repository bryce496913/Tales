import SwiftUI

/// Staying one more day leads to AMA-028 (the turtle warns you) if you saved the turtle at AMA-022,
/// otherwise to the AMA-030 game over.
struct AMA027View: View {
    @EnvironmentObject
    private var navigationState: CaveOfAmaterasuNavigationState

    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA027",
            title: "The Feast Beneath the Waves",
            text: """
            You are not quite sure how you came to be sitting at the Dragon King’s feast, but here you are, and it is wonderful. Fish in silk robes fill your bowl with dishes you have never tasted. Otohime dances. The music never stops, and nobody ever seems to grow tired. You eat, and sleep on silk cushions, and wake to another feast. Was that hours, or days? Through the round window, the garden of cherry blossoms has turned to summer, and then to autumn. Somewhere far above, you remember, the world is waiting in the dark. “Stay one more day,” Otohime says, filling your cup. “Just one. What difference can one day make?”
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Remember why you came",
                    destination: .ama026
                )

                if navigationState.hasFlag(.savedTheTurtle) {
                    CaveOfAmaterasuNavigationButton(
                        title: "Stay one more day",
                        destination: .ama028
                    )
                } else {
                    CaveOfAmaterasuNavigationButton(
                        title: "Stay one more day",
                        destination: .ama030
                    )
                }
            }
        }
    }
}

struct AMA027View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA027View()
        }
    }
}

import SwiftUI

struct AMA001View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA001",
            title: "Grandmother’s Shrine",
            text: """
            Your grandmother kneels before the shrine’s little altar in her white and red robes, her breath smoking in the cold. She has served this shrine for sixty years, and she tells you the story the way she told it when you were small. Susanoo, the storm god, ran wild in heaven. He smashed the dikes of his sister’s rice fields and tore down her weaving hall, and Amaterasu, goddess of the sun, was so frightened and so ashamed that she shut herself inside the Heavenly Rock Cave. While she hides, there is no day. “The gods are many,” your grandmother says, “but sometimes the gods are waiting for us.” She presses her shrine bell into your hand, a cluster of small brass bells on a red cord. “Ring it when you cannot tell the truth from a trick. Climb to the summit. Long ago, the bridge to heaven came down there.”
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Climb the mountain",
                    destination: .ama002
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Stay with her",
                    destination: .ama003
                )
            }
        }
    }
}

struct AMA001View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA001View()
        }
    }
}

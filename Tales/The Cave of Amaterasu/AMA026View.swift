import SwiftUI

struct AMA026View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA026",
            title: "The Dragon King",
            text: """
            Otohime leads you into a hall so tall that its ceiling is lost in the dark water. Coiled around its pillars is Ryūjin, the Dragon King of the sea, with scales of green bronze, a beard like seaweed and eyes as large as rice bowls. Around his neck hangs a string of curved jewels, deep green and red, glowing like coals. These are the Curved Jewels, which fell from heaven into his sea. “What falls into the sea belongs to the sea,” he rumbles. “They are beautiful, and I am old, and there is very little beauty left in the dark. Why should I give them to you?”
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Tell him what the night has done",
                    destination: .ama029
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Promise to stay as his guest",
                    destination: .ama027
                )
            }
        }
    }
}

struct AMA026View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA026View()
        }
    }
}

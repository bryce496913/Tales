import SwiftUI

struct AMA019View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA019",
            title: "The Mirror’s Truth",
            text: """
            You step in front of the mirror. At first you see only yourself, muddy, scratched and frightened. Then the mirror shows you more. It shows the moment on the mountain when you nearly turned back. It shows every time you were unkind to your grandmother and pretended you hadn’t been. It shows how small you are against the size of the dark, and how badly you want somebody else to fix it. It is not cruel. It is simply true. Your face burns. Behind you, the tengu have gone quiet, waiting to see what you will do.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Keep looking",
                    destination: .ama020
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Look away",
                    destination: .ama018
                )
            }
        }
    }
}

struct AMA019View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA019View()
        }
    }
}

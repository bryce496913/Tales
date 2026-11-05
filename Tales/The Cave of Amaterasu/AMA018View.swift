import SwiftUI

struct AMA018View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA018",
            title: "The Hall of Sōjōbō",
            text: """
            The crow-tengu bring you to the very top of Mount Kurama, to a hall of black cedar beams, and lead you inside, hopping and muttering. On a platform at the far end sits Sōjōbō, King of the Tengu. He is as tall as a doorway, with a red face, a nose like a long branch, a white beard down to his belt and a fan of feathers in one hand. Behind him, hanging from a beam, is a bronze mirror as wide as a cartwheel, its rim shaped like a flower with eight petals. Even in the dark, it shines. “The Eight-Hand Mirror shows every face exactly as it is,” Sōjōbō says. “The proud cannot bear to look into it. If you can, you may carry it away. Or you may try to take it from me, if you think you are strong enough.”
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .shojiSlide,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Look into the mirror",
                    destination: .ama019
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Challenge him for it",
                    destination: .ama021
                )
            }
        }
    }
}

struct AMA018View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA018View()
        }
    }
}

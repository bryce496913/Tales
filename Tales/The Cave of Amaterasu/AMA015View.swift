import SwiftUI

struct AMA015View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA015",
            title: "The Cedars of Kurama",
            text: """
            The cloud road sets you down at the foot of Mount Kurama, where cedars older than any city climb into the dark. Somewhere above, heavy wings beat through the branches, and something laughs in a voice like a crow. A stone stairway runs straight up the mountainside, steep and slick with moss, lit by a few stone lanterns. Beside it, a narrower path winds through the great tangled roots of the cedars, and it looks shorter. Near the top of the mountain, through a gap in the trees, you catch a glint of silver, like moonlight on water. The mirror is up there.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Climb the stone stair",
                    destination: .ama016
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Take the path through the roots",
                    destination: .ama017
                )
            }
        }
    }
}

struct AMA015View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA015View()
        }
    }
}

import SwiftUI

struct AMA040View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA040",
            title: "The Dance of Ame-no-Uzume",
            text: """
            At your nod, the roosters crow all together, so loudly that the stars shake. Ame-no-Uzume leaps onto her overturned tub and begins to dance, stamping until the tub booms like a drum. She dances wildly and ridiculously, flinging her sleeves and pulling faces, until the eight hundred myriad gods are roaring with laughter, slapping their knees and falling over each other. The noise rolls across heaven. Then a voice speaks through the crack in the rock, small and puzzled. “The world is dark,” says Amaterasu. “Why are you all laughing?” Uzume shouts back, “Because there is someone out here even brighter than you!” The boulder shifts, just a little.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Raise the mirror to the crack",
                    destination: .ama041
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Throw your weight against the rock",
                    destination: .ama044
                )
            }
        }
    }
}

struct AMA040View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA040View()
        }
    }
}

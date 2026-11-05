import SwiftUI

struct AMA025View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA025",
            title: "The Dragon Palace",
            text: """
            The sea closes over you and carries you down and down, through water as warm as a bath, until you come to rest in front of the gates of Ryūgū-jō, the Dragon Palace. Its towers are made of coral, its roofs of mother-of-pearl, and its courtyards are full of fish in silk robes who bow as you pass. Each of its four gardens is in a different season: cherry blossoms in one, summer cicadas in the next, then red maples, then snow. A princess in robes the colour of sea foam comes to greet you. She is Otohime, the Dragon King’s daughter. “A guest from the dry world!” she says. “How wonderful. We’ve prepared a feast. You must be so tired.” From a great hall beyond her come music, laughter and the smell of food.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .torchReveal,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Ask for the jewels",
                    destination: .ama026
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Join the feast",
                    destination: .ama027
                )
            }
        }
    }
}

struct AMA025View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA025View()
        }
    }
}

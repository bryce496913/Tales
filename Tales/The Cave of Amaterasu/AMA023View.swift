import SwiftUI

struct AMA023View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA023",
            title: "The Turtle’s Back",
            text: """
            You chase the children away and gently turn the turtle back onto its belly. It blinks at you with eyes as old as the sea, and then it speaks. “Kindness on a dark night is a rare thing,” it says. “I serve the Dragon King’s daughter, and I know why you have come. Climb on my back.” You wade out and climb onto its shell, which grows broader as it swims. Then it dives. The water closes over your head, but you find you can breathe it like cool air. Far below, lights appear: towers of coral and pearl, gates of red lacquer, and a palace glowing in the deep.
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Hold on tight",
                    destination: .ama025
                )
            }
        }
    }
}

struct AMA023View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA023View()
        }
    }
}

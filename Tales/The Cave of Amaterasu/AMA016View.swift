import SwiftUI

struct AMA016View: View {
    var body: some View {
        CaveOfAmaterasuPageLayout(
            imageName: "AMA016",
            title: "The Crow-Tengu",
            text: """
            Halfway up the stairway, a dozen figures drop out of the cedars and land on the steps around you. They have the bodies of small men in priests’ robes and the heads of crows, with sharp black beaks and bright, curious eyes. They are karasu-tengu, the crow goblins of the mountain, and they carry little wooden swords. “A human!” one caws. “A human, climbing our mountain in the dark without being asked.” They hop closer, clacking their beaks. “Tell us, human. What makes you so important that the King of the Tengu should see you?”
            """,
            effects: CaveOfAmaterasuPageEffects(
                entryTransition: .inkFade,
                choicesWaitForText: true
            )
        ) {
            CaveOfAmaterasuChoicesStack {
                CaveOfAmaterasuNavigationButton(
                    title: "Bow to them",
                    destination: .ama018
                )

                CaveOfAmaterasuNavigationButton(
                    title: "Boast that you crossed the Bridge of Heaven",
                    destination: .ama017
                )
            }
        }
    }
}

struct AMA016View_Previews: PreviewProvider {
    static var previews: some View {
        CaveOfAmaterasuPreviewContainer {
            AMA016View()
        }
    }
}
